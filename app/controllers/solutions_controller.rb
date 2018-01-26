class SolutionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_solution, only: [:show, :edit, :update, :destroy]

  # GET /solutions
  # GET /solutions.json
  def index
    @assignment = Assignment.find(params[:assignment_id])
    @solutions = @assignment.solutions
    @hash_solutions = {}
    @solutions.pluck(:language).uniq.each {|language| @hash_solutions[language] = @solutions.where('language = ?', language)}
  end

  # GET /solutions/1
  # GET /solutions/1.json
  def show
  end

  # GET /solutions/new
  def new
    @solution = Solution.new
    @assignment = Assignment.find(params[:assignment_id])
  end

  # GET /solutions/1/edit
  def edit
    @assignment = Assignment.find(params[:assignment_id])
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(solution_params)
    @solution.user_id = current_user.id
    @assignment = Assignment.find(params[:assignment_id])
    respond_to do |format|
      if @solution.save
        format.html { redirect_to @solution, notice: 'Solution was successfully created.' }
        format.json { render :show, status: :created, location: @solution }
      else
        format.html { render :new }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /solutions/1
  # PATCH/PUT /solutions/1.json
  def update
    @assignment = Assignment.find(params[:assignment_id])
    respond_to do |format|
      if @solution.update(solution_params)
        format.html { redirect_to @solution, notice: 'Solution was successfully updated.' }
        format.json { render :show, status: :ok, location: @solution }
      else
        format.html { render :edit }
        format.json { render json: @solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution.destroy
    respond_to do |format|
      format.html { redirect_to assignment_solutions_path(@solution.assignment_id), notice: 'Solution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_solution
      @solution = Solution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def solution_params
      params.require(:solution).permit(:user_id, :body, :language, :assignment_id, :code_type)
    end
end
