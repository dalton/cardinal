require_relative 'token'
require_relative 'verb'
require 'java'
require_relative "../../lib/stanford-parser/stanford-parser.jar"
require_relative "../../lib/stanford-parser/stanford-parser-2012-07-09-models.jar"
class StanfordParser
  include_class 'edu.stanford.nlp.parser.lexparser.LexicalizedParser'
  include_class 'edu.stanford.nlp.trees.PennTreebankLanguagePack'
  include_class 'edu.stanford.nlp.process.Morphology'

  SUBJECT_TYPED_DEPENDENCIES = %w(agent nsubj xsubj)
  DIRECT_OBJECT_TYPED_DEPENDENCIES = %w(dobj nsubjpass)
  VERB_TYPED_DEPENDENCIES = SUBJECT_TYPED_DEPENDENCIES + DIRECT_OBJECT_TYPED_DEPENDENCIES
  VERB_TAGS = %w(VB VBD VBG VBN VBP VBZ)

  def parse(text)
    lp = LexicalizedParser.loadModel("edu/stanford/nlp/models/lexparser/englishFactored.ser.gz")
    parse = lp.apply(text)

    tlp = PennTreebankLanguagePack.new
    gsf = tlp.grammaticalStructureFactory
    gs = gsf.newGrammaticalStructure(parse)
    tdl = gs.typedDependenciesCCprocessed
    parse = Parse.new
    parse.verbs = verbs_from_typed_dependencies(tdl)
    parse
  end

  def verbs_from_typed_dependencies(tdl)
    verbs = []
    tdl.each { |d|
      if VERB_TYPED_DEPENDENCIES.include? d.reln.toString
        text, index = d.gov.to_s.split("-")
        verb = Verb.new(Token.new(stem(text), "", index.to_i))
        tdl.each { |a|
          if SUBJECT_TYPED_DEPENDENCIES.include?(a.reln.toString) && a.gov.to_s == d.gov.to_s
            t, i = a.dep.to_s.split("-")
            verb.subjects << Token.new(stem(t), "", i.to_i)
          end
          if DIRECT_OBJECT_TYPED_DEPENDENCIES.include?(a.reln.toString) && a.gov.to_s == d.gov.to_s
            t, i = a.dep.to_s.split("-")
            verb.direct_objects << Token.new(stem(t), "", i.to_i)
          end
        }
        verbs << verb
      end
    }
    verbs
  end

  def stem(word)
    morph = Morphology.new
    morph.stem(word)
  end

  private
  class Parse
    attr_accessor :verbs

    def initialize
      @verbs = []
    end
  end
end