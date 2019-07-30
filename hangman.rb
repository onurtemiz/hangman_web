class Keyword
  attr_accessor :keyword, :keyword_hide_info
  def initialize
    @keyword = get_keyword('5desk.txt').downcase #Gets 5-12 letter keyword.
    @keyword_hide_info = Hash.new # Create a hash that provides info about letter's info
    @keyword.split('').each do |letter|
      @keyword_hide_info[letter] = 'hidden'
    end
  end

  def get_keyword file #Gets a new keyword
    keyword = ''
    until keyword.length > 5 && keyword.length < 12
      keyword = File.readlines(file,).sample.strip
    end
    keyword
  end

  def show_hidden_keyword # Shows keyword like: _ _ a _ c _ b if info == hidden
    hidden_keyword = ''
    @keyword.split('').each do |letter|
      info = @keyword_hide_info[letter]
      info == 'hidden' ? hidden_keyword += '_ ' : hidden_keyword += letter + ' '
    end
    hidden_keyword
  end

  def show_keyword # Prints keyword
    @keyword
  end
end

class Alphabet
  attr_accessor :alphabet_hash
  def initialize
    @alphabet_array = ('A'..'Z').to_a
    @alphabet_hash = Hash.new         # Creates a Hash of all letters
    @alphabet_array.each do |letter|
      @alphabet_hash[letter] = 'red'  # Mark them as Red
    end
  end

  def change_leter_color(letter) # Change letter's color
    letter = letter.upcase
    @alphabet_hash[letter] == 'red' ? @alphabet_hash[letter] = 'green' : @alphabet_hash[letter] = 'red'
  end

end

class Game
  attr_accessor :life , :keyword , :alphabet
  def initialize
    @keyword = Keyword.new
    @alphabet = Alphabet.new
    @life = 9
  end

  def check_answer answer # If answer is true, sets letter's info to visible.
    keyword = @keyword.keyword
    @keyword.keyword_hide_info.key?(answer) ? @keyword.keyword_hide_info[answer] = 'visible' : false
  end

  def check_letter(answer) # Ask letter or save/load
    answer.length == 1 && answer =~ /[a-zA-Z]/ && @alphabet.alphabet_hash[answer.upcase ]== 'red' ? true : false
  end


  def game_lost?
    true if @life == 0
  end

  def game_won? # Check every key
    game_won = true
    @keyword.keyword_hide_info.each do |letter,info|
      game_won = false if info == 'hidden'
    end
    game_won
  end
end


