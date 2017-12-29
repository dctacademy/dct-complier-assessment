class HomeController < ApplicationController

  def index
  end

  def input
    @response = {}
    @content = params[:content]
    @ex = params[:extension]
    @name = SecureRandom.hex(2)
    @input = InputFile.new(@name,@content,@ex)
    @input.createFile
    @input.execute
    @response["response"] = @input.respond
    respond_to do |format|
      format.json { render json: @response}
    end
    FileDeleteJob.perform_later @name
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

  def check_submission
    @response = {}
    @uid = params[:uid]
    @aid = params[:aid]
    @prac_id = params[:prac_id]
    @lang = params[:language]
    @obj = CheckSub.new(@uid,@aid,@lang,@prac_id)
    @response["response"] = @obj.has_cache
    respond_to do |format|
      format.json { render json: @response}
    end
  end

end
