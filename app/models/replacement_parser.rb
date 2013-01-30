require_relative 'stanford_parser'
require_relative 'entity_replacer'
class ReplacementParser

  def initialize(parser, replacer)
    @parser = parser
    @replacer = replacer
  end

  def parse(text)
    original_parse = @parser.parse(text)
    replacements = @replacer.replace(text)
    original_parse.verbs.each do |verb|
      verb.subjects.each do |subject|
        subject.text = replacements[subject.index - 1]
      end
      verb.direct_objects.each do |direct_object|
        direct_object.text = replacements[direct_object.index - 1]
      end
    end
    original_parse
  end
end