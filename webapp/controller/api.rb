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
      :message => request[:message],
      :user => session[:user]
      )
    return "something wrong" unless @letter
    session[:letter_token] = @letter.token
    @letter.publish
  end

  def get
    token = session[:letter_token]
    letter = Letter[:token => token]
    return nil unless letter
    @trade = Trade.find_or_create(:letter_id => letter.id)
    @trade.get_pair
#    @trade.refresh
    if @trade.pair
      session.delete(:letter_token)
      return @trade.pair.letter.publish
    end
    nil
  end

end
