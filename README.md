#House of Trivia - CLI Project

##The Beginning

I started with a lot of ideas. I thought about focusing on dinosaurs, space, animals, sharks, whales, food.. but when looking for an API nothing sparked excitement. Then I stumbled onto a Trivia API. I LOVE trivia. It is something I have always enjoyed so when I saw it I thought "I can use this to create a mini trivia game!" Then immeadiately realized I didn't know where to begin. This is my first project, so my first time coding with out an test files, guides, or tutorials to look at. 

For each of the array we will need to pull out the id and name and create an object for each of those.

##How can I call the answers and then check the answers?

Orig issue: Because I am combining the correct and incorrect answers into one array and shuffling them, I am unable to use index to check the answer
first solution: Change structure and have the user input a word answer, then check if the answer include? in the original array. 

Question.all.first.answers_arr.flattenshuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}

second solution: adapted the lines of code below so that the flattened array is its own thing, in the order of correct answers, then the three incorrect answers. Then will check to see if the array position is [0], if it is 0 then it is correct, if it is 1,2,3 then it is incorrect

        answ = Question.all.first.answers_arr.flatten
        answ.shuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}
        user_answer = gets.chomp.to_i-1

After this I tried making check? it's own method, but it wouldn't let me call the user_answer in another method. I debated turning it into an @user_answer variable, but I was not sure if this was good practice. I inquired with Corinna (insert answer). As it was I combined the two and left it all in the AAQ method. 

    def aaq
        Question.all
        puts "Difficulty: #{Question.all.first.difficulty}"
        puts "Your question is... #{Question.all.first.question}"
        puts "Choose an answer below, then enter the number you think is correct!"
        answ = Question.all.first.answers_arr.flatten
        answ.shuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}
        user_answer = gets.chomp.to_i-1
        if user_answer == answ[0]
            puts "Correct!!! Good job!"
        else user_answer != answ[0]
            puts "Sorry, that's not right! The correct answer is #{Question.all.first.correct_answer}"
        end
        puts "Play again?"
        menu
        puts "To exit enter 'exit!'"
        # binding.pry
        # combine the answers in a random order with an index
    end 

At first this didn't work, but then I caught that in my first if statement I had done user_answer = answ[0], but quickly changed it too user_answer == answ[0]. Such a small change but it makes a big difference! Now I was getting a return but it was returning incorrect everytime. I adjusted my code to the following:

    answ = Question.all.first.answers_arr.flatten
    answ_shuffle = answ.shuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}
    user_answer = gets.chomp.to_i-1
    binding.pry
    if answ_shuffle[user_answer] == answ[0]
        puts "Correct!!! Good job!"
    else answ_shuffle[user_answer] != answ[0]
        puts "Sorry, that's not right! The correct answer is #{Question.all.first.correct_answer}"
    end

I realized that I needed to set the shuffled array to a variable so I could use it to call an array position to compare to. 

The next issue I ran into was after the answer check happened the end wouldn't show the menu but loop endlessly with the same question. I realized I need to change a few lines around. 

    def aaq
        Question.all
        puts "Difficulty: #{Question.all.first.difficulty}"
        puts "Your question is... #{Question.all.first.question}"
        puts "Choose an answer below, then enter the number you think is correct!"
        answ = Question.all.first.answers_arr.flatten
        answ.shuffle.each.with_index(1) {|answer, index| puts "#{index}. #{answer}"}
        user_answer = gets.chomp.to_i-1
        if user_answer == answ[0]
            puts "Correct!!! Good job!"
        else user_answer != answ[0]
            puts "Sorry, that's not right! The correct answer is #{Question.all.first.correct_answer}"
        end
        puts "Play again?"
        run
        # binding.pry
        # combine the answers in a random order with an index
    end 


    I changed the 'menu' to 'run' and then removed the last line. This broke the loop but I realized my exit line wasn't printing. I then moved it up to the top of my run method to be printed after 'Welcome to the House of Trivia'

    Isometric 3

    