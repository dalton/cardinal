require_relative '../../app/models/replacement_parser'
describe ReplacementParser do
  rp = ReplacementParser.new(StanfordParser.new, EntityReplacer.new)
  it "should extract verbs from a sentence" do
    parse = rp.parse "That same year, they moved to Los Angeles from New York and purchased the house"
    parse.verbs.first.text.should == "move"
    parse.verbs.first.index.should == 6
    parse.verbs.first.subjects.first.text.should == "person"
    parse.verbs.first.subjects.first.index.should == 5
    parse.verbs.last.text.should == "purchase"
    parse.verbs.last.index.should == 14
    parse.verbs.last.direct_objects.first.text.should == "house"
    parse.verbs.last.direct_objects.first.index.should == 16
  end
end