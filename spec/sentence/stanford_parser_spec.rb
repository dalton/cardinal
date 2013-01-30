require_relative '../../app/models/stanford_parser'
describe StanfordParser do
  it "should extract verbs from a sentence" do
    sp = StanfordParser.new
    parse = sp.parse "My dog also likes eating sausage"
    parse.verbs.first.text.should == "likes"
    parse.verbs.first.index.should == 4
    parse.verbs.first.subjects.first.text.should == "dog"
    parse.verbs.first.subjects.first.index.should == 2
    parse.verbs.last.text.should == "eat"
    parse.verbs.last.index.should == 5
    parse.verbs.last.direct_objects.first.text.should == "sausage"
    parse.verbs.last.direct_objects.first.index.should == 6
  end
  it "should extract multiple subjects and direct objects from a sentence" do
    sp = StanfordParser.new
    parse = sp.parse "My dog and my cat like eating sausage and pizza"
    parse.verbs.first.text.should == "like"
    parse.verbs.first.index.should == 6
    parse.verbs.first.subjects.first.text.should == "dog"
    parse.verbs.first.subjects.first.index.should == 2
    parse.verbs.first.subjects.last.text.should == "cat"
    parse.verbs.first.subjects.last.index.should == 5
    parse.verbs.last.text.should == "eat"
    parse.verbs.last.index.should == 7
    parse.verbs.last.direct_objects.first.text.should == "sausage"
    parse.verbs.last.direct_objects.first.index.should == 8
    parse.verbs.last.direct_objects.last.text.should == "pizza"
    parse.verbs.last.direct_objects.last.index.should == 10
  end
end