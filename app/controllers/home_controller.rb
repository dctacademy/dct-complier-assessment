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
    submission_status = submission.is_checked
    binding.pry
    if params[:is_checked] == "correct"
      batch_student.update_attributes(points: batch_student.points + assignment.points) if submission.practice.assignment_group.allow_points
    elsif params[:is_checked] == "incorrect"
      binding.pry
      if submission.is_checked == "correct"
        binding.pry
        batch_student.update_attributes(points: batch_student.points - assignment.points) if submission.practice.assignment_group.allow_points
        binding.pry
      end
    end
    submission.update_attributes(is_checked: params[:is_checked])

    # POINTS 
    # if submission.is_checked == "correct"
    #   batch_student.update_attributes(points: batch_student.points + assignment.points) if submission.practice.assignment_group.allow_points # if it is sample test then no need to add points
    # elsif submission.is_checked == "incorrect"
    #   if submission_status == "correct" # only if is_checked is correct then deduct points other wise we would not have assigned it in the first place
    #     batch_student.update_attributes(points: batch_student.points - assignment.points) if submission.practice.assignment_group.allow_points # if it is sample test then no need to add points
    #   end
    # end
    Notification.create(
      title: "#{submission.assignment.title}",
      user_id: submission.user_id,
      url: "/batches/#{submission.practice.assignment_group.batch.id}/assignment_groups/student_solutions?assignment_group_id=#{submission.practice.assignment_group.id}&student_user_id=#{submission.user_id}",
      practice_id: submission.practice_id,
      notification_type_id: NotificationType.find_by(name: "assignment_correction").id
    )

    render json: {
      "message": "Successfully updated"
    }
  end

end
