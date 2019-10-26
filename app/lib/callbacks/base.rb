class Callbacks::Base

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    ### Abstract
  end
end
