require 'java'
require_relative "../../lib/stanford-ner-2012-07-09/stanford-ner-2012-07-09.jar"
#require "#{Rails.root}/lib/stanford-ner-2012-07-09/stanford-ner-2012-07-09.jar"
java_import "edu.stanford.nlp.ie.AbstractSequenceClassifier"
java_import "edu.stanford.nlp.ie.crf.CRFClassifier"
java_import "edu.stanford.nlp.ling.CoreLabel"
java_import "edu.stanford.nlp.ling.CoreAnnotations"
java_import "java.util.List"

class EntityReplacer

  REPLACABLES = {
      "he" => "person",
      "she" => "person",
      "I" => "person",
      "i" => "person",
      "you" => "person",
      "we" => "person",
      "us" => "person",
      "people" => "person",
      "they" => "person",
      "them" => "person",
      "it" => "entity",
      "here" => "location",
      "there" => "location",
      "this" => "entity",
      "that" => "entity"
  }

  def initialize
    #serializedClassifier = "#{Rails.root}/lib/stanford-ner-2012-07-09/classifiers/english.all.3class.distsim.crf.ser.gz"
    serializedClassifier = "#{File.dirname(__FILE__)}/../../lib/stanford-ner-2012-07-09/classifiers/english.all.3class.distsim.crf.ser.gz"
    @classifier = CRFClassifier.getClassifierNoExceptions(serializedClassifier)
  end

  def replace(text)
    @classifier.classify(text).first.collect { |word|
      aa = word.get(CoreAnnotations::AnswerAnnotation)
      token = (aa == "O" ? word.value : aa.downcase)
      REPLACABLES[token.downcase].nil? ? token : REPLACABLES[token.downcase]
    }
  end

end