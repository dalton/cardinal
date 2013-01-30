require_relative '../../app/models/entity_replacer'
describe EntityReplacer do

  er = EntityReplacer.new
  it "should replace people" do
    replaced = er.replace "James functions as the eyes and ears of the government"
    replaced.should == %w(person functions as the eyes and ears of the government)

  end

  it "should replace locations" do
    replaced = er.replace "Huffman was rescued from a beach about 25 miles northwest of Sitka"
    replaced.should == %w(person was rescued from a beach about 25 miles northwest of location)

  end

  it "should replace organizations" do
    replaced = er.replace "Sales of Apple and Samsung devices soar"
    replaced.should == %w(Sales of organization and organization devices soar)

  end

  it "should replace pronouns" do
    replaced = er.replace "That same year, they moved to Los Angeles from New York and purchased the house"
    replaced.should == %w(entity same year , person moved to location location from location location and purchased the house)
  end
end