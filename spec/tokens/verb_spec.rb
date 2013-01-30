require_relative "../../app/models/verb"

describe Verb do

  verb = Verb.new(Token.new("like","VBP", 8 ))

  it "should have subjects" do
    t1 = Token.new("dog", "NN", 2)
    t2 = Token.new("cat", "NN", 5)
    verb.subjects << t1
    verb.subjects << t2
    verb.should have(2).subjects
  end

  it "should have direct objects" do
    t1 = Token.new("sausage", "NN", 2)
    t2 = Token.new("pizza", "NN", 5)
    verb.direct_objects << t1
    verb.direct_objects << t2
    verb.should have(2).direct_objects
  end
end