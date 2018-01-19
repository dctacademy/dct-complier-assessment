class ListsController < ApplicationController
  load_and_authorize_resource
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all

    respond_to do |format|
      format.html {}
      format.json { render json: @lists}
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @assignments = @list.assignments
    respond_to do |format|
      format.html {}
      format.json { render json: @list,except: [:created_at,:updated_at],include: [:assignments,:tags]}
    end
  end

  # GET /lists/new
  def new
    @list = List.new
    @assignments = Assignment.where(approved: true).includes(:tags)
  end

  # GET /lists/1/edit
  def edit
    @assignments = Assignment.where(approved: true).includes(:tags)
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)
    @list.tag_list = params[:list][:tag_list]
    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :user_id, :tag_list, assignment_ids: [])
    end
end
