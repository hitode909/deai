require 'pp'

class MainController < Controller
  def index
    @title = "Deai Web Application"
    unless session[:user_id]
      user = User.create
      session[:user_id] = user.id
    end
  end

  def letter(token = session[:letter_token])
    @letter = Letter[:token => token]
    redirect(MainController.r) unless @letter
  end

end
