#GOALS: fix apostrophe & " error with gsub, and then allow you to try again when
#you pick a wrong answer
class CLI

    def run
        header
        sleep 0.8
        Api.create_categories
        list_categories
        menu
    end

    def list_categories
        Category.all.each.with_index(1) do |category, index|
                 puts "#{index}. #{category.name}"
                 sleep 0.1
        end
        
    end

    def menu
        user_input = gets.chomp
        input = user_input.to_i-1
        if !input.between?(0,23)
            puts "That number isn't even on the list! Come on... this is only the first question"
            sleep 0.3
            list_categories
            menu
        else
            category = Category.all[input]
            Api.create_question(category)
            aaq
            check?
            new_game
        end
    end
        
    def aaq
        Question.all
        str=Question.all.first.question
        new_str=str.gsub("&quot;",'"').gsub("&#039;","'").gsub("&amp;",'&')
        line
        puts "Difficulty: #{Question.all.first.difficulty.upcase}"
        puts "Your question is... #{new_str}"
        puts "Choose an answer below, then enter the number you think is correct!"
    end 

    def check?
        answ = Question.all.first.answers_arr.flatten
        # answ_list = []
        # answ_sub = answ.each do |answer| 
        #     answer.gsub("&quot;",'"').gsub("&#039;","'").gsub("&amp;","&").gsub("&egrave;","e").gsub("&ntilde;","n").gsub("&aacute;","a")
        #     end
        # answ_list << answ.each do |answer| 
        #     answer.gsub("&quot;",'"').gsub("&#039;","'").gsub("&amp;","&").gsub("&egrave;","e").gsub("&ntilde;","n").gsub("&aacute;","a")
        #     end
        answ_shuffle = answ.shuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}
        user_answer = gets.chomp.to_i-1
        if !user_answer.between?(0,3)
            puts "That's not even an answer choice!"
            line
            sleep 1
            aaq
            check?
        elsif answ_shuffle[user_answer] == answ[0]
            line
            puts "CORRECT! Look at you go with your big brain!"
            line
            sleep 1
        else answ_shuffle[user_answer] != answ[0]
            puts "WRONG. Do you want to try again? Y/N"
            line
            sleep 1
            try_again
        end
    end 

    def try_again
        input = gets.chomp.downcase
        if input == "y"
            aaq
            check? 
        elsif input == "n"
            puts "Really? You don't wanna try again??"
            puts "Ok then...The correct answer is #{Question.all.first.correct_answer}."
        else
            puts "ummm... it was a yes or no question.... back to the beginnning you go!"
            sleep 1
            line
                Question.reset
                list_categories
                menu
        end   
    end

    def new_game
        puts "Do you want to play again?"
        puts "Please enter Y or N"
        line
        input = gets.chomp.downcase
            if input == "y" 
            Question.reset
            line
            list_categories
            menu
            elsif input == "n"
                puts "Questions too hard? That's okay... you can always comeback later!"
                line
                exit
            else 
                puts "Your answer disappeared into the oblivion. Try again. "
                line
                sleep 1
                Question.reset
                list_categories
                menu
            end
    end

    def header
        puts <<-'EOF'
                                                                                                                              
                                                                                                                              ▄▀▄     ▄▀▄
                                                                                                                             ▄█░░▀▀▀▀▀░░█▄
                                                                                                                         ▄▄  █░░░░░░░░░░░█  ▄▄
                                                                                                                        █▄▄█ █░░▀░░┬░░▀░░█ █▄▄█        
         . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
           __  __     ______     __  __     ______     ______        ______     ______      ______   ______     __     __    __   __     ______   
          /\ \_\ \   /\  __ \   /\ \/\ \   /\  ___\   /\  ___\      /\  __ \   /\  ___\    /\__  _\ /\  == \   /\ \   /\ \  / /  /\ \   /\  __ \    
          \ \  __ \  \ \ \/\ \  \ \ \_\ \  \ \___  \  \ \  __\      \ \ \/\ \  \ \  __\    \/_/\ \/ \ \  __<   \ \ \  \ \ \/ /   \ \ \  \ \  __ \     
           \ \_\ \_\  \ \_____\  \ \_____\  \/\_____\  \ \_____\     \ \_____\  \ \_\         \ \_\  \ \_\ \_\  \ \_\  \ \__/     \ \_\  \ \_\ \_\    
            \/_/\/_/   \/_____/   \/_____/   \/_____/   \/_____/      \/_____/   \/_/          \/_/   \/_/ /_/   \/_/   \/_/       \/_/   \/_/\/_/   
          . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

                                                             Welcome to the House of Trivia!
                                                                        * * *
                                            Please select a number to receive a question from that category:

        EOF
    end

    def line
        puts ". . . . . . . . . . . . . . . . . . . . . . . . . . . . "
    end
end



#display list of categories
    #accept user input
    #user_input.to-i - 1
    #select category based on number in array
    #call the category based on the id number
    #pulls one multiple choice question
    #user_input again, for answer
    #returns "that is.... correct!" or "that is.... incorrect! The correct answer is (insert)"
#puts question
        #call question using id
        #if the number is apart of the range, then change it 





#To push
# git add .
# git commit -m "message"
# git push origin master

#deals with user


