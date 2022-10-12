class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def guess(ch)
    if !(ch =~ /^[a-z]+$/i)
      raise ArgumentError
    end

    ch.downcase!
    if @guesses.include?(ch) || @wrong_guesses.include?(ch)
      return false
    end

    if @word.include? ch
      @guesses << ch
    else
      @wrong_guesses << ch
    end
    return true
  end

  def word_with_guesses()
    displayWord = ''
    @word.each_char do |ch|
      if guesses.include? ch
        displayWord << ch
      else
        displayWord << '-'
      end
    end
    return displayWord
  end

  def check_win_or_lose()
    if word_with_guesses() == @word
      return :win
    elsif wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # Get a word from remote "random word" service

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
