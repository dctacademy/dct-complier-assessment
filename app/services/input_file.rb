class InputFile
  attr_accessor :name,:content,:extension

  @@lang = {
    "ruby" => "rb",
    "javascript" => "js",
    "python" => "py",
  }
  def initialize(name,content,language)
    self.name = name
    self.content = content
    self.extension = @@lang[language]
  end

  def createFile
    FileUtils::mkdir_p("tmp/#{self.name}")
    somefile = File.open("tmp/#{self.name}/#{self.name}.#{self.extension}","w")
    somefile.puts self.content
    somefile.close
  end

  def execute
    begin
      case self.extension
      when "js"
        cmd = "timeout -k 5 5 node tmp/#{self.name}/#{self.name}.js >> tmp/#{self.name}/#{self.name}_out.txt 2>&1"
        `#{cmd}`
      when "py"
        cmd = "timeout -k 5 5 python3 tmp/#{self.name}/#{self.name}.py >> tmp/#{self.name}/#{self.name}_out.txt 2>&1"
        `#{cmd}`
      else
      cmd = "timeout -k 5 5 ruby tmp/#{self.name}/#{self.name}.rb >> tmp/#{self.name}/#{self.name}_out.txt 2>&1"
      `#{cmd}`
      end
    end
    sleep(0.3)
  end

  def respond
    val = File.read("tmp/#{self.name}/#{self.name}_out.txt")
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
    return val
  end

end
