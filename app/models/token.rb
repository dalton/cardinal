class Token

  attr_accessor :text, :part_of_speech, :index
  def initialize(text, pos, index)
    @text = text
    @part_of_speech = pos
    @index = index
  end

  def to_s
    "#{text}-#{index}"
  end
end