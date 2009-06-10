# -*- coding: nil -*-
require 'pp'
require 'yaml'
class ApiController < Controller
  map '/api'
  provide(:yaml, :type => 'text/javascript'){ |action, value| value.to_yaml}

  def index
    @title = "This is API."
  end

  def new
    return "no message" unless request[:message]
    @letter = Letter.create(
      :name => request[:name],
      :profile => request[:profile],
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
      return @trade.pair.letter.publish
    end
  end

end
