class NotificationsController < ApplicationController

	before_action :authenticate_user!
	load_and_authorize_resource
	
	def index
		@notifications = 	(current_user.role? "admin") ? Notification.order('created_at DESC') : current_user.notifications.order('created_at DESC')
	end

end
