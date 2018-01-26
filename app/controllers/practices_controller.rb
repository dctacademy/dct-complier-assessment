class PracticesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource only: [:submissions]
  before_action :set_practice, only: [:show, :edit, :update, :destroy]

  # GET /practices
  # GET /practices.json
  def index
    @practices = Practice.all
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
    practice = Practice.find(params[:id])
    @assignment = Assignment.find(practice.assignment)
    @assignment_group = practice.assignment_group
    @flag = Favourite.find_by(user_id: current_user.id,assignment_id: @assignment.id)
    @rb = @assignment.answers.where(language: "ruby")
    @js = @assignment.answers.where(language: "javascript")
    @py = @assignment.answers.where(language: "python")
    # create time of viewing the assignment only once when the user clicks on the practice link
    #binding.pry
    SubmissionTimer.create(user_id: current_user.id, practice_id: params[:id], assignment_id: @assignment.id, assignment_group_id: practice.assignment_group_id) if SubmissionTimer.find_by(user_id: current_user.id, practice_id: params[:id], assignment_id: @assignment.id, assignment_group_id: practice.assignment_group_id).nil?
    #binding.pry
    @start_time = SubmissionTimer.find_by(user_id: current_user.id, practice_id: params[:id], assignment_id: @assignment.id, assignment_group_id: practice.assignment_group_id)
    #binding.pry
  end

  # GET /practices/new
  def new
    @practice = Practice.new
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices
  # POST /practices.json
  def create
    @practice = Practice.new(practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to @practice, notice: 'Practice was successfully created.' }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to @practice, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submissions
    @practice = Practice.find(params[:practice_id])
    @assignment = Assignment.find(@practice.assignment_id)
    @submissions = @practice.submissions
    @hash_solutions = {}
    # show only the solutions for assignments of the languages chosen in practice assignment group
    @assignment.solutions.pluck(:language).uniq.find_all{|l| @practice.assignment_group.tag_list.include?(l.downcase)}.each {|language| @hash_solutions[language] = @assignment.solutions.where('language = ?', language)}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(:assignment_group_id, :assignment_id, student_ids: [])
    end
end
