require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @user_word = params[:user_word].downcase.split('')
    @letters = params[:letters].downcase.split('')
    @included = @user_word.all? { |letter| @letters.count(letter) >= @user_word.count(letter) }
    if @included && JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@user_word.join}").read)['found']
      @score = 10
    else
      @score = 0
    end
  end
end
