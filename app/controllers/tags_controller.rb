class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
    respond_to do |format|
      format.html {}
      format.json { render json: @tags,except: [:taggings_count] }
    end
  end

  def search
  end

  def create
    @tag = ActsAsTaggableOn::Tag.new(params[:acts_as_taggable_on_tag].permit(:name))
		@tag.save
  end


  def questions
    # @response = {}
    @tag_name = params[:tag_name].split(",")
    @type = params[:search_type]
    if @type == "exact"
      @questions = Assignment.tagged_with(@tag_name,:match_all => true)
    else
      @questions = Assignment.tagged_with(@tag_name,:any => true)
    end
    @questions.map{|n| n.body = n.body.truncate(150)}
    respond_to do |format|
      format.json { render json: @questions,only: [:title,:code,:body,:is_allowed]}
    end
  end


  def assignments
    @tag_name = params[:tag_name].split(",")
    @type = params[:search_type]
    @batch = params[:bid]
    ids_to_exclude = Batch.find(@batch).assignment_groups.map{|n| n.assignments.map{|n| n.id}}.flatten
    if @type == "exact"
      questions = Assignment.tagged_with(@tag_name[0])
      @tag_name.shift
      @tag_name.each do |tag|
        questions  = questions.tagged_with(tag)
      end
      @filtered_questions = questions.where.not(id: ids_to_exclude)
    else
      questions = Assignment.tagged_with(@tag_name,:any => true)
      @filtered_questions = questions.where.not(id: ids_to_exclude)
    end
    @filtered_questions.map{|n| n.body = n.body.truncate(150)}
    @filtered_questions.map{|n| n.url = "<a href=\"#\" class=\"link\" value=\"/assignments/" + n.id.to_s + "\">show</a>"}
    respond_to do |format|
      format.json { render json: @filtered_questions,only: [:title,:code,:body,:url]}
    end
  end

  def question_filter
    @tag_name = params[:tag_name].split(",")
    @type = params[:type]
    if @type == "exact"
      @questions = Assignment.tagged_with(@tag_name,:match_all => true).where("is_allowed = ?",true)
    else
      @questions = Assignment.tagged_with(@tag_name,:any => true).where("is_allowed = ?",true)
    end
    respond_to do |format|
      format.json { render json: @questions,only: [:id,:title,:body],include: :tags }
    end
  end



end
