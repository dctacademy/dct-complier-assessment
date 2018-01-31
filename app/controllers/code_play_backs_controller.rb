class CodePlayBacksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_code_play_back, only: [:show, :edit, :update, :destroy]

  # GET /code_play_backs
  # GET /code_play_backs.json
  def index
    @code_play_backs = CodePlayBack.all
  end

  # GET /code_play_backs/1
  # GET /code_play_backs/1.json
  def show
  end

  # GET /code_play_backs/new
  def new
    @code_play_back = CodePlayBack.new
  end

  # GET /code_play_backs/1/edit
  def edit
  end

  # POST /code_play_backs
  # POST /code_play_backs.json
  def create
    @code_play_back = CodePlayBack.new(code_play_back_params)
    @code_play_back.user_id = current_user.id
    @code_play_back.save
    respond_to do |format|
      format.js
    end
  end

  # PATCH/PUT /code_play_backs/1
  # PATCH/PUT /code_play_backs/1.json
  def update
    respond_to do |format|
      if @code_play_back.update(code_play_back_params)
        format.html { redirect_to @code_play_back, notice: 'Code play back was successfully updated.' }
        format.json { render :show, status: :ok, location: @code_play_back }
      else
        format.html { render :edit }
        format.json { render json: @code_play_back.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /code_play_backs/1
  # DELETE /code_play_backs/1.json
  def destroy
    @code_play_back.destroy
    respond_to do |format|
      format.html { redirect_to code_play_backs_url, notice: 'Code play back was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_play_back
      @code_play_back = CodePlayBack.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_play_back_params
      params.require(:code_play_back).permit(:practice_id, :user_id, :statement)
    end
end
