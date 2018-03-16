class GroupRunsController < ApplicationController
  before_action :set_group_run, only: [:show, :edit, :update, :destroy, :add_user]
  before_action :authenticate_user!

  # GET /group_runs
  # GET /group_runs.json
  def index
    @group_runs = GroupRun.all
  end

  # GET /group_runs/1
  # GET /group_runs/1.json
  def show
  end

  # GET /group_runs/new
  def new
    @group_run = GroupRun.new
  end

  # GET /group_runs/1/edit
  def edit
  end

  # POST /group_runs
  # POST /group_runs.json
  def create
    @run = Run.find(params[:run_id])
    if @run
      attrs = @run.attributes.symbolize_keys.slice(:place, :tempo, :beginning, :distance)
      @new_run = Run.create(attrs.merge(user_id: params[:user_id]))
      if @run.group_run
        @run.group_run.runs << @new_run
      else
        @group_run = GroupRun.create(attrs)
        @group_run.runs << @new_run
        @group_run.runs << @run
      end
      redirect_to run_path(@new_run), notice: I18n.t('group_runs.join_success')
    else
      redirect_to request.referer, notice: I18n.t('group_runs.join_failed')
    end
  end

  # PATCH/PUT /group_runs/1
  # PATCH/PUT /group_runs/1.json
  def update
    respond_to do |format|
      params_obj = ::RunParams.new(group_run_params)
      if @group_run.update(params_obj.model_attrs)
        @group_run.runs.update_all(params_obj.model_attrs.except(:start_date, :start_time))
        format.html { redirect_to @group_run, notice: I18n.t('group_runs.updated') }
        format.json { render :show, status: :ok, location: @group_run }
      else
        format.html { render :edit }
        format.json { render json: @group_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_runs/1
  # DELETE /group_runs/1.json
  def destroy
    @group_run.destroy
    respond_to do |format|
      format.html { redirect_to group_runs_url, notice: 'Group run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    respond_to do |format|
      attrs = @group_run.attributes.symbolize_keys.slice(:place, :tempo, :beginning, :distance)
      @new_run = Run.create(attrs.merge(user_id: params[:user_id]))
      @run.group_run.runs << @new_run
      if @group_run.update(params_obj.model_attrs)
        format.html { redirect_to @group_run, notice: I18n.t('group_runs.join_success') }
        format.json { render :show, status: :ok, location: @group_run }
      else
        format.html { render :edit }
        format.json { render json: @group_run.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_run
      @group_run = GroupRun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_run_params
      params.fetch(:group_run, {}).permit(:place, :start_date, :start_time, :tempo, :distance)
    end
end
