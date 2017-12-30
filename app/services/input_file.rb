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
  # binding.pry
  # sleep(0.3)
  # end

  def respond
    val = File.read("tmp/#{self.name}/#{self.name}_out.txt")
    # case self.extension
    #   when "py"
    #     if val.split("line ").size > 1
    #       leftpar = "code.py"
    #       ex = val.split("line ")[1].split("")[0].to_i - 2
    #       val = val.split("line ")[1].split("")
    #       val.shift
    #       rightpar = val.unshift(ex).join("")
    #       val = leftpar + "line " + rightpar
    #     end
    #   else
    #     if val.split("rb:").size > 1
    #       leftpar = "code."
    #       ex = val.split("rb:")[1].split("")[0].to_i - 3
    #       val = val.split("rb:")[1].split("")
    #       val.shift
    #       rightpar = val.unshift(ex).join("")
    #       val = leftpar + "rb:" + rightpar
    #   end
    # end
    return val
  end
end
