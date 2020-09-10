class Api

    def self.create_categories
        resp = RestClient.get('https://opentdb.com/api_category.php')
        categories_hash = JSON.parse(resp.body,symbolize_names:true)
        categories_arr = categories_hash[:trivia_categories]
        categories_arr.each do |category|
            id = category[:id]
            name = category[:name]
            Category.new(id,name)
            end
    end

    def self.create_question(category)
        resp = RestClient.get("https://opentdb.com/api.php?amount=1&category=#{category.id}&type=multiple")
        question_hash = JSON.parse(resp.body,symbolize_names:true)
        question_arr = question_hash[:results]
        # binding.pry
        category = question_arr[0][:category]
        difficulty = question_arr[0][:difficulty]
        question = question_arr[0][:question]
        correct_answer = question_arr[0][:correct_answer]
        incorrect_answers = question_arr[0][:incorrect_answers]
        quest=Question.new(category,difficulty,question,correct_answer,incorrect_answers)
    end

end


#deals with API 
    #

    #old code
      # Question.answers_arr
        # answers_arr=[]
        # Question.answers_arr << incorrect_answers
        # Question.answers_arr << correct_answer
        # binding.pry
        