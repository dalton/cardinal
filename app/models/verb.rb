require 'delegate'
class Verb < Delegator

  attr_accessor :subjects, :direct_objects

  def initialize(obj)
    super
    @subjects = []
    @direct_objects = []
    @delegate_token_obj = obj
  end

  def __getobj__
    @delegate_token_obj # return object we are delegating to, required
  end

  def __setobj__(obj)
    @delegate_token_obj = obj # change delegation object,
                              # a feature we're providing
  end

end