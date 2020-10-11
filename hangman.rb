finished = false
temp_dictionary = File.read "5desk.txt"
@word = ""
@guess_count = 0
@guess_array = []
@all_guesses_array = []
@finished = false
dictionary = temp_dictionary.downcase


def choose_word(dictionary)
    dict_array = dictionary.split("\n")
    word_chosen = false
    random_index = Random.rand(dict_array.length)
    word = dict_array[random_index]

    while word.length < 5 || word.length > 12
        random_index = Random.rand(dict_array.length)
        word = dict_array[random_index]
    end

    set_word(word)
end

def make_guess(guess)
    word_array = get_word.split("")
    guess_array = get_guess_array
    already_guessed = false
    set_guess_count(1)

    if get_all_guesses_array.include?(guess)
        already_guessed = true
        set_guess_count(-1)
    end

    if already_guessed
        guess_array.each_with_index do |letter, index|
            if index == guess_array.length - 1
                print letter + "\n\n"
            else
                print letter + "|"
            end
        end

        puts "already guessed that letter!"
        puts "guesses remaining: " + (6 - get_guess_count).to_s
        return 0
    else
        set_new_all_guesses_array_item(guess)
    end

    if word_array.include?(guess)
        word_array.each_with_index do |letter, index|
            if letter == guess
                guess_array[index] = guess
            end
        end

        print_guess_array(guess_array)
        puts "correct guess!"
        puts "guesses remaining: " + (6 - get_guess_count).to_s
    else
        print_guess_array(guess_array)
        puts "sorry! incorrect guess!"
        puts "guesses remaining: " + (6 - get_guess_count).to_s
    end

    set_guess_array(guess_array)

    if get_guess_array.join("") == get_word
        set_finished(true)
        print "\n"
    end
end

def print_guess_array(guess_array)
    guess_array.each_with_index do |letter, index|
        if index == guess_array.length - 1
            print letter + "\n\n"
        else
            print letter + "|"
        end
    end
end

def set_word(word)
    @word = word
end

def get_word
    return @word
end

def set_guess_count(to_increase_by)
    @guess_count += to_increase_by
end

def get_guess_count
    return @guess_count
end

def set_guess_array(array)
    @guess_array = array
end

def get_guess_array
    return @guess_array
end

def set_new_all_guesses_array_item(item)
    @all_guesses_array.push(item)
end

def get_all_guesses_array
    return @all_guesses_array
end

def set_finished(f)
    @finished = f
end

def get_finished
    return @finished
end

choose_word(dictionary)

while get_guess_array.length < get_word.length
    get_guess_array.push("_")
end

while get_guess_count < 6 && !get_finished
    puts "please guess a letter: "
    new_guess = gets.chomp.downcase

    while new_guess.length > 1 || new_guess.length < 1 || new_guess == " "
        puts "Incorrect input. please try again: "
        new_guess = gets.chomp.downcase
    end

    print "\n"
    make_guess(new_guess)
end

puts ""
puts "game over!"
get_finished = true
@already_finished = false

if get_guess_array.join("") == get_word
    @already_finished = true
end

if !@already_finished
    puts ""
    puts "Do you think you know the word? Please enter 'yes' or 'no'"
    knows = gets.chomp.downcase
    print "\n"

    while knows != "yes" && knows != "no"
        puts "Incorrect input. Please answer 'yes' or 'no'."
        knows = gets.chomp.downcase
        print "\n"
    end

    if knows == "yes"
        puts "What is the word?"
        puts "Please note: you must type the word exactly! " +
          "That means no spaces or special characters. You will lose otherwise!"
        print "your guess: "
        last_guess = gets.chomp.downcase

        if last_guess == get_word
            last_guess_array = last_guess.split("")
            set_guess_array([])
            new_guess_array = []
            @word_array = get_word.split("")

            @word_array.each_with_index do |letters, index|
                new_guess_array.push(last_guess_array[index])
            end

            set_guess_array(new_guess_array)
        end
    end
end

if get_finished
    puts "the word: " + get_word

    if get_guess_array.join("") == get_word
        puts "You win!"
    else
        puts "You lose!"
    end
end