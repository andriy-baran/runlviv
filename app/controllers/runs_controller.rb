class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy, :sync_strava]
  before_action :authenticate_user!, only: [:my_runs, :new, :edit, :create, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.preload(:group_run, :user).where('beginning > ?', Time.now - 1.week).order(:beginning)
    @runs_by_date = @runs.group_by{ |run| run.beginning.to_date }
  end

  def my_runs
    @runs = current_user.runs.order('beginning DESC')
    @strava_runs = current_user.strava_imports.order('beginning DESC')
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
  end

  # GET /runs/new
  def new
    @run = Run.new(run_params)
    @competitions = Array(@run.competition)
  end

  # GET /runs/1/edit
  def edit
    @competitions = @competitions = Array(@run.competition)
    authorize @run
  end

  # POST /runs
  # POST /runs.json
  def create
    params_obj = ::RunParams.new(run_params)
    @run = current_user.runs.new(params_obj.model_attrs)
    @competitions = Competition.where('finish > ?', Time.now)
    authorize @run
    respond_to do |format|
      if @run.save
        format.html { redirect_to @run, notice: I18n.t('domain.runs.created') }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  def update
    respond_to do |format|
      params_obj = ::RunParams.new(run_params)
      authorize @run
      if @run.update(params_obj.model_attrs)
        format.html { redirect_to @run, notice: I18n.t('domain.runs.updated') }
        format.json { render :show, status: :ok, location: @run }
      else
        format.html { render :edit }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    authorize @run
    @run.destroy
    respond_to do |format|
      format.html { redirect_to runs_url, notice: 'Run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sync_strava
    if current_user.strava_access_token
      client = Strava::Api::V3::Client.new(access_token: current_user.strava_access_token)
      activities =
        client
          .list_athlete_activities(after: (@run.beginning - 2.hours).to_i,
                                   before: (@run.beginning + 2.hours).to_i)
      if @run.competition_id
        activities =
          activities
            .select { |activity| !activity['manual'] }
            .select { |activity| activity['name'].match(/runlviv\schallenge/i) }
      end
      if activities.empty?
        redirect_to @run, alert: 'Не знайдено жодної активності'
      else
        activities.each do |activity|
          imported = current_user.strava_imports.find_by(strava_id: activity['id'])
          attrs = {
            strava_id: activity['id'],
            distance: activity['distance'],
            name: activity['name'],
            avg_speed: activity['average_speed'],
            beginning: Time.zone.parse(activity['start_date']),
            run_id: @run.id
          }
          if imported
            imported.update_columns(attrs.slice(:name, :run_id))
          else
            current_user.strava_imports.create(attrs)
          end
        end
        redirect_to @run, notice: 'Успішно!'
      end
    else
      redirect_to profile_user_path(current_user), alert: 'Не вдалося. Спробуйте Приєднати Strava'
    end
  end

  def import_strava
    last_date = last_imported.beginning
    client = Strava::Api::V3::Client.new(access_token: current_user.strava_access_token)
    client.list_athlete_activities(after: last_date.to_i).each do |activity|
      attrs = {
        strava_id: activity['id'],
        distance: activity['distance'],
        name: activity['name'],
        avg_speed: activity['average_speed'],
        beginning: Time.zone.parse(activity['start_date'])
      }
      current_user.strava_imports.create(attrs)
    end
    redirect_to runs_user_path(current_user), notice: 'Успішно!'
  rescue Strava::Api::V3::ServerError
    redirect_to request.referer, alert: 'Халепа! Щось пішло не так. Спробуйте ще раз'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.fetch(:run, {}).permit(:place, :start_date, :start_time, :tempo, :distance, :competition_id)
    end

    def last_imported
      current_user.strava_imports.order(:beginning).last || OpenStruct.new(beginning: 1.month.ago)
    end
end
