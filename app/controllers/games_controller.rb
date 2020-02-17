require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    session[:score] = session[:score] || 0
    @score = session[:score]
    letter_array = []
    10.times do
      letter_array << ("A".."Z").to_a.sample
    end
    @letters = letter_array
  end

  def score
    attempt = params[:word]
    grid = params[:letters].split(" ")
    if included?(attempt.upcase, grid)
      if english_word?(attempt)
        @result = "Congratulations! #{attempt.upcase} is a valid English word!"
        session[:score] += attempt.size
        @score = session[:score]
      else
        @result = "Sorry, but #{attempt.upcase} does not seem to be an English word"
      end
    else
      @result = "Sorry but #{attempt.upcase} can't be build out of #{grid.join(', ')}"
    end
  end

  private

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
