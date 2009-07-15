class KanjiQuestion < ActiveRecord::Base
  def random(quiz_id,params)
    self.quiz_id = quiz_id
    self.ordinal = KanjiQuestion.find(:all,:conditions=>'quiz_id='+self.quiz_id.to_s).size + 1

    #   1. choose a random kanji
    verb_obj = Lexeme.find(:all)[rand(Lexeme.count)]
    
    @verb = verb_obj[:string]

    # at some point need to allow multiple translations
    self.lexeme = verb_obj.id

    self.answer = verb_obj.string
    
    self.save

    return self

  end

end
