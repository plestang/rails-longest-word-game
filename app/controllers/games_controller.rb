require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
    # raise
    # grid.split_new = grid.split(" ")
    # guess_new = guess.split("")

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params['word']}"
    @letters = params['letters'].split
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if user['found'] == true
      @answers = 'Well done!'
    elsif included?(params['word'], @letters)
      @answers = 'Valid word but try to speak a better English!'
    else
      @answers = 'You can do better'
    end
  end

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end
end
