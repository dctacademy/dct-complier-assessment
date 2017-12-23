class FileDeleteJob < ApplicationJob
  queue_as :default

  def perform(name)
    @flag = File.exist? ("tmp/#{name}")
    if @flag
      FileUtils.rm_rf("tmp/#{name}")
    end
  end
  
end
