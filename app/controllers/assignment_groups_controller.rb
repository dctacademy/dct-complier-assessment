class AssignmentGroupsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_assignment_group, only: [:show, :edit, :update, :destroy]

  # GET /assignment_groups
  # GET /assignment_groups.json
  def index
    if params[:batch_id]
      @batch = Batch.find(params[:batch_id])
      @assignment_groups = @batch.assignment_groups
    else
      @assignment_groups = AssignmentGroup.all
    end
  end

  # GET /assignment_groups/1
  # GET /assignment_groups/1.json
  def show
  end

  # GET /assignment_groups/new
  def new
    @assignment_group = AssignmentGroup.new
    @assignment_group.batch_id = params[:batch_id] if params[:batch_id]
  end

  # GET /assignment_groups/1/edit
  def edit
  end

  # POST /assignment_groups
  # POST /assignment_groups.json
  def create
    @assignment_group = AssignmentGroup.new(assignment_group_params)
    @assignment_group.tag_list = params[:assignment_group][:tag_list]
    respond_to do |format|
      if @assignment_group.save
        format.html { redirect_to batch_assignment_group_path(@assignment_group.batch, @assignment_group), notice: 'Assignment group was successfully created.' }
        format.json { render :show, status: :created, location: @assignment_group }
      else
        format.html { render :new }
        format.json { render json: @assignment_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignment_groups/1
  # PATCH/PUT /assignment_groups/1.json
  def update
    @assignment_group.tag_list = params[:assignment_group][:tag_list]
    respond_to do |format|
      if @assignment_group.update(assignment_group_params)
        format.html { redirect_to batch_assignment_group_path(@assignment_group.batch, @assignment_group), notice: 'Assignment group was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment_group }
      else
        format.html { render :edit }
        format.json { render json: @assignment_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment_groups/1
  # DELETE /assignment_groups/1.json
  def destroy
    @assignment_group.destroy
    respond_to do |format|
      format.html { redirect_to assignment_groups_url, notice: 'Assignment group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment_group
      @assignment_group = AssignmentGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_group_params
      params.require(:assignment_group).permit(:title, :batch_id, :tag_list, :due_datetime, assignment_ids: [], student_ids: [])
    end
end
