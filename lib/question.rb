class Question
    attr_accessor :category
    attr_reader :question, :correct_answer, :incorrect_answers, :difficulty, :answers_arr

    @@all = []

    def initialize(category,difficulty,question,correct_answer,incorrect_answers)
        @question = question
        @difficulty = difficulty
        @answers_arr = []
        @correct_answer = correct_answer
        @incorrect_answer = incorrect_answers
        @answers_arr << correct_answer
        @answers_arr << incorrect_answers
        @@all << self
    end

    def self.all
        @@all
    end

    def self.reset
        self.all.clear
    end

end
