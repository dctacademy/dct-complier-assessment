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

  def check_assignment
    submission = Submission.find(params[:submission_id])
    batch_student = BatchStudent.find_by(batch_id: submission.practice.assignment_group.batch.id ,student_id: submission.user.student.id)
    assignment = submission.assignment
    if params[:is_checked] == "true"
      submission.update_attributes(is_checked: true)
      batch_student.update_attributes(points: batch_student.points + assignment.points) if submission.practice.assignment_group.allow_points # if it is sample test then no need to add points
    else
      submission.update_attributes(is_checked: false)
      batch_student.update_attributes(points: batch_student.points - assignment.points) if submission.practice.assignment_group.allow_points
    end
    render json: {
      "message": "Successfully updated"
    }
  end

end
