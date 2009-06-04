require 'digest/sha1'

class ApiController < Controller
  map '/api'
  def index
    @title = "This is API."
  end

  def new
    return "please set your profile" unless request[:profile]
    @letter = Letter.create(
      :profile => request[:profile],
      :message => request[:message]
      )
    return "something wrong" unless @letter
  end

  def notemplate
    "there is no 'notemplate.xhtml' associated with this action"
  end
end
