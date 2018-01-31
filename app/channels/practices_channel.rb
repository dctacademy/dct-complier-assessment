class PracticesChannel < ApplicationCable::Channel  
	
	def subscribed
    # "practices_#{params[:data][:user_id]}_#{params[:data][:practice_id]}"
    # practices = current_user.role? "admin" ? Practice.all : current_user.student.batches
    stream_from "practices"
  end

  def unsubscribed
    stop_all_streams
  end

end  