require_relative "../../app/models/token"

describe Token do
  token = Token.new("dog", "NN", 2)
  it "should have text" do
    token.text.should == "dog"
  end

  it "should have an index" do
    token.index.should == 2
  end

  it "should have a part of speech" do
    token.part_of_speech.should == "NN"
  end
end