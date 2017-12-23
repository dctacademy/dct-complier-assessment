class CheckSub
  attr_accessor :uid,:aid,:lang,:prac_id

  def initialize(uid,aid,lang,prac_id)
    self.uid = uid
    self.aid = aid
    self.lang = lang
    self.prac_id = prac_id
  end

  def has_cache
    @flag = Submission.where(user_id: self.uid,assignment_id: self.aid,language: self.lang,practice_id: self.prac_id)
    if @flag.empty?
      @con = {"statement"=> "default"}
      return @con
    else
      @con = @flag.first
    end
    return @con
  end
#class end
end
