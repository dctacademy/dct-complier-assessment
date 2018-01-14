class InputFile
  attr_accessor :name,:content,:extension,:executor

  @@extension = {
    "ruby" => "rb",
    "javascript" => "js",
    "python" => "py",
  }

  @@executor = {
    "ruby" => "ruby",
    "javascript" => "node",
    "python" => "python3"
  }

  def initialize(name,content,language)
    self.name = name
    self.content = content
    self.extension = @@extension[language]
    self.executor = @@executor[language]
  end

  def createFile
    FileUtils::mkdir_p("tmp/#{self.name}")
    somefile = File.open("tmp/#{self.name}/#{self.name}.#{self.extension}","w")
    somefile.puts self.content
    somefile.close
    exec_file = File.open("tmp/#{self.name}/#{self.name}.sh","w")
    exec_file.puts "#!/bin/bash"
    exec_file.puts "(time timeout -k 5 5 #{self.executor} tmp/#{self.name}/#{self.name}.#{self.extension} &> tmp/#{self.name}/#{self.name}_out.txt) &> tmp/#{self.name}/#{self.name}_time.txt"
    exec_file.puts "echo $? &> tmp/#{self.name}/#{self.name}_code.txt"
    exec_file.close
    FileUtils::chmod("+x","tmp/#{self.name}/#{self.name}.sh")
  end

  def execute
    cmd = "./tmp/#{self.name}/#{self.name}.sh"
    `#{cmd}`
    # sleep(0.3)
  end

  def respond
    val = File.read("tmp/#{self.name}/#{self.name}_out.txt")
    time = File.read("tmp/#{self.name}/#{self.name}_time.txt")
    time = time.split("\n")[2]
    time.gsub!("user","Time Elapsed")
    code = File.read("tmp/#{self.name}/#{self.name}_code.txt")
    if code.to_i != 124
      begin
        case self.extension
          when "py"
            val.gsub!("tmp/#{self.name}/#{self.name}","File")
          when "js"
            val.gsub!("#{Dir.pwd}/tmp/#{self.name}/#{self.name}","File")
          else
            val.gsub!("tmp/#{self.name}/#{self.name}","File")
          end
      end
      val += time
    else
      val = "You program did not yield any output or ran more than 5 seconds (>=5000ms).\nProcess was killed."
    end
    return val
  end

end
