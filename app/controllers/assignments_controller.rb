class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource  only: [:approve_assignment,:recents,:approved,:approval,:search,:sources,:approve,:findslug,:random]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.where(approved: true).includes(:tags)
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    respond_to do |format|
      format.html{
        @flag = Favourite.find_by(user_id: current_user.id,assignment_id: @assignment.id)
        @rb = @assignment.answers.where(language: "ruby")
        @js = @assignment.answers.where(language: "javascript")
        @py = @assignment.answers.where(language: "python")
      }
      format.json{
        render json: @assignment
      }
    end

  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.tag_list = params[:assignment][:tag_list]
    @assignment.company_list = params[:assignment][:company_list]
    @assignment.approved = true if current_user.role? "admin"
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
        n = Notification.create(
          title: "#{@assignment.title}",
          url: "/assignments/#{@assignment.id}",
          notification_type_id: NotificationType.find_by(name: "assignment_created").id,
          user_id: current_user.id

        )
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    @assignment.tag_list = params[:assignment][:tag_list]
    @assignment.company_list = params[:assignment][:company_list]
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve_assignment
    @assignment = Assignment.find(params[:assignment_id])
    @assignment.update_attributes(approved: true)
  end

  def recents
    @assignments = Assignment.order(created_at: :desc).limit(10)
  end

  def approved
    @assignments = Assignment.where(is_allowed: true)
  end

  def approve
    @assignments = Assignment.where(approved: false).limit(10)
  end

  def approval
    @assignments = Assignment.where(is_allowed: false).limit(10)
  end

  def search
    @search = Assignment.search do
      fulltext params[:search] do
        boost_fields :title => 5.0
      end
    end
    respond_to do |format|
      format.json { render json: @search.results }
    end
  end

  def sources
    @sources = Assignment.all.map{|n| n.source}.uniq
  end

  def findslug
    @slug = params[:name]
    @response = HTTParty.get("https://www.codewars.com/api/v1/code-challenges/" + @slug)
    respond_to do |format|
      format.json {render json: @response}
    end
  end

  def random
    type = params[:type]
    if type == "next"
      id = Assignment.offset(params[:id].to_i).limit(30).pluck(:id).sample
      @assignment = Assignment.find(id)
      redirect_to @assignment
    elsif type == "skip"
      id = Assignment.limit(params[:id]).pluck(:id).sample
      @assignment = Assignment.find(id)
      redirect_to @assignment
    else
      redirect_to :root ,notice: "something went wrong!!! don't manipulate the url."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:title, :body, :url, :user_id, :source , :tag_list, :company_list, :approved, :points)
    end
end
