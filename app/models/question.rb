class Question < ActiveRecord::Base

  def random(quiz_id,params)
    self.quiz_id = quiz_id
    self.ordinal = Question.find(:all,:conditions=>'quiz_id='+self.quiz_id.to_s).size + 1

    if params["keigo"] == "on"
      params["humble"] = "on"
      params["honorific"] = "on"
    end

    #   1. choose a random verb
    verb_obj = Lexeme.find(:all)[rand(Lexeme.count)]
    @verb = verb_obj[:string]

    #   2. choose a random inflection
    # this is kind of inefficient because it
    # loops through randomly-chosen inflections
    # until it finds one that the user wants to be tested on
    # (based on params)
    chosen = false
    # the "tries < 100" is to prevent endless loops.
    tries = 0
    while (chosen == false && (tries < 100))
      tries = tries + 1
      infl_obj = Inflection.find(:all)[rand(Inflection.count)]
      if (params[infl_obj.name])
        chosen = true
      end
    end

    #   3. choose polarity
    if rand(2) == 1
      self.polarity = "positive"
    else
      self.polarity = "negative"
    end

    #   4. choose tense
    if rand(2) == 1
      self.tense = "present"
    else
      self.tense = "past"
    end

    self.english = verb_obj.translate(infl_obj.name,self.polarity,self.tense)

    self.inflection = infl_obj.id

    self.lexeme = verb_obj.id

    self.answer = verb_obj.inflect(infl_obj.name,self.polarity,self.tense)
    
    print "answer: " + self.answer + "\n"

    if self.answer == "??"
      # try again
      self.random(quiz_id,params)
    end

    self.save

# allows you to do :
#    q = Question.new.random"
#  rather than more verbose:
#   q = Question.new
#   q.random

    return self

  end

end
