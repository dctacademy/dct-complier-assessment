class HomeController < ApplicationController

  def index
  end
  
  def check_cache
    @response = {}
    @uid = params[:uid]
    @aid = params[:aid]
    @lang = params[:language]
    @obj = Check.new(@uid,@aid,@lang)
    @response["response"] = @obj.has_cache
    respond_to do |format|
      format.json { render json: @response}
    end
  end

end
