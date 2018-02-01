class EditorSettingsController < ApplicationController
  before_action :set_editor_setting, only: [:show, :edit, :update, :destroy]

  # GET /editor_settings
  # GET /editor_settings.json
  def index
    @editor_settings = EditorSetting.all
  end

  # GET /editor_settings/1
  # GET /editor_settings/1.json
  def show
  end

  # GET /editor_settings/new
  def new
    @editor_setting = EditorSetting.new
  end

  # GET /editor_settings/1/edit
  def edit
  end

  # POST /editor_settings
  # POST /editor_settings.json
  def create
    @editor_setting = EditorSetting.new(editor_setting_params)
    @editor_setting.user_id = current_user.id
    respond_to do |format|
      if @editor_setting.save
        format.html { redirect_to @editor_setting, notice: 'Editor setting was successfully created.' }
        format.json { render :show, status: :created, location: @editor_setting }
      else
        format.html { render :new }
        format.json { render json: @editor_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /editor_settings/1
  # PATCH/PUT /editor_settings/1.json
  def update
    @editor_setting.user_id = current_user.id
    respond_to do |format|
      if @editor_setting.update(editor_setting_params)
        format.html { redirect_to @editor_setting, notice: 'Editor setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @editor_setting }
      else
        format.html { render :edit }
        format.json { render json: @editor_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /editor_settings/1
  # DELETE /editor_settings/1.json
  def destroy
    @editor_setting.destroy
    respond_to do |format|
      format.html { redirect_to editor_settings_url, notice: 'Editor setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_editor_setting
      @editor_setting = EditorSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def editor_setting_params
      params.require(:editor_setting).permit(:user_id, :theme_name, :theme_css)
    end
end
