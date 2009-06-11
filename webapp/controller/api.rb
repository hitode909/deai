# -*- coding: nil -*-
require 'pp'
require 'json'
class ApiController < Controller
  map '/api'
  provide(:json, :type => 'text/javascript'){ |action, value| value.to_json}

  def index
    @title = "This is API."
  end

  def new
    return "no message" unless request[:message]
    @letter = Letter.create(
      :name => request[:name],
#      :profile => request[:profile],
      :message => request[:message]
      )
    return "something wrong" unless @letter
    session[:letter_token] = @letter.token
  end

  def get
    token = session[:letter_token]
    letter = Letter[:token => token]
    redirect(MainController.r) unless letter
    @trade = Trade.find_or_create(:letter_id => letter.id)
    @trade.get_pair
    if @trade.pair
      session.delete(:letter_token)
      return result(@trade.pair.letter)
    end
  end

  def result(letter)
    result = { }
    result[:result] = !!letter
    result[:content] = letter if letter
  end

end
