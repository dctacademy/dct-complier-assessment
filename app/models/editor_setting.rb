class EditorSetting < ApplicationRecord
	belongs_to :user
	validates_presence_of :user_id, :theme_name, :theme_css
end
