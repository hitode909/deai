class ApiController < Controller
  map '/api'
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
  end

end
