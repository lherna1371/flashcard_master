class Question
  attr_reader :question, :answer

  def initialize(args)
    @question = args[0]
    @answer   = args[1]
  end

end

class QuestionParser
  attr_reader :file, :list
  
  def initialize(file = 'english-spanish.txt')
    @file = file
    @list = List.new
  end

  def load
    array = []
    File.open(file).each do |line|
      
      array << line.chomp
    end
    array
  end


  def create_objects(array)
    array.each do |pair|
      list.add(Question.new(pair))
    end
  end
end

class List
  attr_reader :all_questions

  def initialize
    @all_questions = []
  end

  def add(question_object)
    @all_questions << question_object
  end
end

