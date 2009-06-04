class MainController < Controller
  def index
    @title = "Deai Web Application"
  end

  def letter(token = nil)
    @letter = Letter[:token => token]
    redirect(MainController.r) unless @letter
  end
end
