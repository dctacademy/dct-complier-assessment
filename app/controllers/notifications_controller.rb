class NotificationsController < ApplicationController

	before_action :authenticate_user!, except: [:index]
	load_and_authorize_resource
	
	def index
		if params[:agi].present?
			@notifications = Notification.where('url LIKE ?', "%assignment_group_id=#{params[:assignment_group_id]}%").order('created_at DESC')
		elsif params[:agisui].present?
			assignment_group = AssignmentGroup.find(params[:assignment_group_id])
			@notifications = Notification.where('user_id = ? AND url = ? ',params[:student_user_id], "/batches/#{assignment_group.batch_id}/assignment_groups/student_solutions?assignment_group_id=#{params[:assignment_group_id]}&student_user_id=#{params[:student_user_id]}").order('created_at DESC')
		else 
			@notifications = 	(current_user.role? "admin") ? Notification.order('created_at DESC') : current_user.notifications.order('created_at DESC')
		end
	end

end
