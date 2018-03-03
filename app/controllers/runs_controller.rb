class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:my_runs, :new, :edit, :create, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.all.order(:beginning)
    @runs_by_date = @runs.group_by{ |run| run.beginning.to_date }
  end

  def my_runs
    @runs = current_user.runs.order('beginning DESC')
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  def edit
    authorize @run
  end

  # POST /runs
  # POST /runs.json
  def create
    params_obj = ::RunParams.new(run_params)
    @run = current_user.runs.new(params_obj.model_attrs)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.fetch(:run, {}).permit(:place, :start_date, :start_time, :tempo, :distance)
    end
end
