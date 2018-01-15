class CommentsController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource

	def create
		@comment = Comment.new(comment_params)
		submission = Submission.find(@comment.submission_id)
		@comment.user_id = current_user.id
		@comment.save
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
	end

	private

	def comment_params
		params[:comment].permit(:submission_id, :body)
	end
end
