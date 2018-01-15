class CommentsController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource

	def create
		@comment = Comment.new(comment_params)
		submission = Submission.find(@comment.submission_id)
		@comment.user_id = current_user.id
		@comment.save
		Notification.create(
      title: "#{submission.assignment.title}",
      user_id: submission.user_id,
      url: "/batches/#{submission.practice.assignment_group.batch.id}/assignment_groups/student_solutions?assignment_group_id=#{submission.practice.assignment_group.id}&student_user_id=#{submission.user_id}",
      practice_id: submission.practice_id,
      notification_type_id: NotificationType.find_by(name: "comment_created").id
    )
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		submission = @comment.submission
		Notification.create(
      title: "#{submission.assignment.title}",
      user_id: submission.user_id,
      url: "/batches/#{submission.practice.assignment_group.batch.id}/assignment_groups/student_solutions?assignment_group_id=#{submission.practice.assignment_group.id}&student_user_id=#{submission.user_id}",
      practice_id: submission.practice_id,
      notification_type_id: NotificationType.find_by(name: "comment_deleted").id
    )
	end

	private

	def comment_params
		params[:comment].permit(:submission_id, :body)
	end
end
