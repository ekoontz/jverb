# -*- coding: utf-8 -*-
require 'xml/xslt'

class Lexeme < ActiveRecord::Base

  def export(xml)
    xml.lexeme(:id => attributes["id"],
               :english => attributes["english"],
               :string => attributes["string"],
               :lex_type => attributes["lex_type"],
               :humble => inflect("humble","positive","present"),
               :honorific => inflect("honorific","positive","present"),
               :potential => inflect("potential","positive","present"),
               :potential_negative => inflect("potential","negative","present"),
               :potential_past => inflect("potential","positive","past"),
               :potential_negative_past => inflect("potential","negative","past"),
               :passive => inflect("passive","positive","present"),
               :passive_negative => inflect("passive","negative","present"),
               :passive_past => inflect("passive","positive","past"),
               :passive_negative_past => inflect("passive","negative","past"),
               :imperative => inflect("imperative","positive","present"),
               :imperative_negative => inflect("imperative","negative","present"),
               :tari => inflect("tari","positive","present")
               ) do
      exceptions = LexicalException.find(:all,:conditions=>"lexeme_id="+self.id.to_s)
      exceptions.each do |exception|
        exception.export(xml)
      end
    end
  end

  def stem
    # remove last character of the lexical (dictionary form)
    # for example 食べる (taberu) => 食べ (tabe)
    return self.string.chars.to_a.slice(0,self.string.chars.to_a.size-1).to_s
  end

  def premasu
    # remove last character of the lexical (dictionary form)
    # for example 食べる (taberu) => 食べ (tabe)
#    last = self.string.chars.slice(self.string.chars.to_a.size-1,self.string.chars.to_a.size)
    last = self.string.last

    if last == "る"
      return self.stem+"り"
    end
    if last == "う"
      return self.stem+"い"
    end
    if last == "ぶ"
      return self.stem+"び"
    end
    if last == "む"
      return self.stem+"み"
    end
    if last == "ぬ"
      return self.stem+"に"
    end
    if last == "す"
      return self.stem+"し"
    end
    if last == "く"
      return self.stem+"き"
    end
    if last == "ぐ"
      return self.stem+"ぎ"
    end
    if last == "つ"
      return self.stem+"ち"
    end
    return "("+last+"):dont know"
  end


  def tensify(present_form,form,tense)
    case form
      when "imperative"
      #imperative has no tense.
      return present_form
      when "tari"
      #imperative has no tense.
      return present_form
      else
      case tense
      when "past"
        case present_form.chars.slice(present_form.chars.to_a.size-2,present_form.chars.to_a.size).to_s
        when "する"
          return present_form.chars.slice(0,present_form.chars.to_a.size-2) + "した"
        when "ない"
          return present_form.chars.slice(0,present_form.chars.to_a.size-2) + "なかった"
        else
          case present_form.chars.slice(present_form.chars.to_a.size-1,present_form.chars.to_a.size).to_s
          when "る"
            return present_form.chars.slice(0,present_form.chars.to_a.size-1) + "た"
          when "す"
            return present_form.chars.slice(0,present_form.chars.to_a.size-1) + "した"
          when "う"
            return present_form.chars.slice(0,present_form.chars.to_a.size-1) + "いた"
          else
            case present_form
              when "??"
              return present_form
            end
            raise "tensify("+present_form+","+form+","+tense+"):error 1)"
          end
        end
      else # present
        return present_form
      end
    end
    raise "tensify("+present_form+","+form+","+tense+"):error 2)"
  end

  def polarize(positive,inflection,polarity)
    case inflection
      when "tari"
      return positive
      when "imperative"
      case polarity
        when "positive"
        return positive
        else
        return self.string+"な"
      end
      else
      case polarity
      when "positive"
        return positive
      else # negative
        case positive.chars.to_a.slice(positive.chars.to_a.size-2,
                                       positive.chars.to_a.size).to_s
        when "する"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-2).to_s + "しない"
        when "なる"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-1).to_s + "らない"
        when "ざる"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-1).to_s + "いない"
        end
        case positive.chars.to_a.slice(positive.chars.to_a.size-1,positive.chars.to_a.size).to_s
        when "る"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-1).to_s + "ない"
        when "す"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-1).to_s + "しない"
        when "う"
          return positive.chars.to_a.slice(0,positive.chars.to_a.size-1).to_s + "いない"
        end
        case positive
          when "??"
          return positive
        end
      end
    end
    raise "polarize("+positive+","+inflection+","+polarity+"):(["+positive.chars.to_a.slice(positive.chars.to_a.size-2,positive.chars.to_a.size)+"]:error)"
  end

  def potential
    stem = self.stem
    case self.lex_type
    when "3"
      infl = Inflection.find(:all,:conditions=>"name='potential'")[0]
      exception = 
        LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
      if exception
        return exception.form
      end
      return "??"
    when "う" 
      #<う-verbs>
      #<exceptional う-verbs>
      case self.string
      when "行く"
        return "行ける"
      #</exceptional う-verbs>
      else
        # <regular う-verbs>
        case self.string.last
        when "ぐ"
          return stem + "げる"
        when "く"
          return stem + "ける"
        when "む"
          return stem + "める"
        when "ぶ"
          return stem + "べる"
        when "る"
          return stem + "れる"
        when "う"
          return stem + "える"
        when "す"
          return stem + "せる"
        when "つ"
          return stem + "てる"
        when "ぬ"
          return stem + "ねる"
          # </regular う-verbs>
        else
          return "don't know"
        end
      #</う-verbs>
      end
        #<る-verbs>
    when "る"
      return stem + "られる"
      #</る-verbs>
    else
      raise "unknown lex type: "+self.lex_type
    end
  end

  def tari
    case self.lex_type
    when "3"
      infl = Inflection.find(:all,:conditions=>"name='tari'")[0]
      exception = 
        LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
      if exception
        return exception.form
      end
      return "??"
    when "う"
      #<う-verbs>
      #<exceptional う-verbs>
      case self.string
      when "行く"
        return self.stem + "ったり"
      #</exceptional う-verbs>
      else
        # <regular う-verbs>
        case self.string.last
        when "ぐ"
          return self.stem + "いだり"
        when "く"
          return self.stem + "いたり"
        when "む"
          return self.stem + "んだり"
        when "ぶ"
          return self.stem + "んだり"
        when "る"
          return self.stem + "ったり"
        when "う"
          return self.stem + "ったり"
        when "す"
          return  self.stem + "したり"
        when "つ"
          return self.stem + "ったり"
        when "ぬ"
          return self.stem + "んだり"
          # </regular う-verbs>
        else
          return "don't know"
        end
      #</う-verbs>
      end
        #<る-verbs>
    when "る"
      return self.stem + "たり"
      #</る-verbs>
    else
      raise "unknown lex type: "+self.lex_type
    end
  end

  def passive
    case self.lex_type
    when "3"
      infl = Inflection.find(:all,:conditions=>"name='passive'")[0]
      exception = 
        LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
      if exception
        return exception.form
      end
      return "??"
    when "う"
      #<う-verbs>
      #<exceptional う-verbs>
      case self.string
      when "行く"
        return self.stem + "かれる"
      #</exceptional う-verbs>
      else
        # <regular う-verbs>
        case self.string.last
        when "ぐ"
          return self.stem + "がれる"
        when "く"
          return self.stem + "かれる"
        when "む"
          return self.stem + "まれる"
        when "ぶ"
          return self.stem + "ばれる"
        when "る"
          return self.stem + "られる"
        when "う"
          return self.stem + "われる"
        when "す"
          return self.stem + "される"
        when "つ"
          return self.stem + "たれる"
        when "ぬ"
          return self.stem + "なれる"
          # </regular う-verbs>
        else
          return "don't know"
        end
      #</う-verbs>
      end
        #<る-verbs>
    when "る"
      return self.stem + "られる"
      #</る-verbs>
    else
      raise "passive(): unknown lex type: "+self.lex_type
    end
  end

  def imperative
    stem = self.stem
    case self.lex_type
    when "3"
      infl = Inflection.find(:all,:conditions=>"name='imperative'")[0]
      exception = 
        LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
      if exception
        return exception.form
      end
      return "??"
    when "う"
      #<う-verbs>
      case self.string.last
      when "ぐ"
        return stem + "げ"
      when "く"
        return stem + "け"
      when "む"
        return stem + "め"
      when "ぶ"
        return stem + "べ"
      when "る"
        return stem + "れ"
      when "う"
        return stem + "え"
      when "す"
        return  stem + "せ"
      when "つ"
        return stem + "て"
      when "ぬ"
        return stem + "ね"
        # </regular う-verbs>
      else
        return "don't know"
      end
      #</う-verbs>
      #<る-verbs>
    when "る"
      return stem + "れ"
      #</る-verbs>
    else
      raise "unknown lex type: "+self.lex_type
    end
  end

  def english_tensify(string,tense)
    case tense
    when "past"
      case string
        when "be"
        return "been"
        when "come"
        return "came"
        when "drink"
        return "drunk"
        when "eat"
        return "eaten"
        when "get mad"
        return "got mad"
        when "go"
        return "went"
        when "go home"
        return "gone home"
        when "hear"
        return "heard"
        when "hold"
        return "held"
	when "is"
	return "made to be"
        when "know"
        return "known"
        when "make"
        return "made"
        when "meet"
        return "met"
        when "ride"
        return "ridden"
        when "see"
        return "seen"
        when "speak"
        return "spoken of"
        when "write"
        return "written"
        when "sleep"
        return "slept"
        when "say"
        return "said"
        when "is"
        return "was"
        else
	case string.slice(0,12)
	  when "not be made "
	  return "wasn't made " + string.slice(12,string.size)
	  else
	  case string.slice(0,6)
          when "can't "
	    return "couldn't have " + english_tensify(string.slice(6,string.size),"past")
          when "isn't "
	    return "wasn't " + string.slice(6,string.size)
          else
	    case string.slice(0,4)
	    when "can "
	      return "could have " + english_tensify(string.slice(4,string.size),"past")
	    else
	      case string.slice(0,3)
	      when "is " # is made -> was made
		return "was " + string.slice(3,string.size)
	      when "be " # be made -> been made
		return "been " + string.slice(3,string.size)
	      else
		case string.slice(string.size-2,string.size)
		when "nd" # send -> sent
		  return string.slice(0,string.size-1) + "t"
		else
		  case string.slice(string.size-1,1)
		  when "e" # die -> died
		    return string.slice(0,string.size-1)+"ed"
		  else # jump->jumped
		    return string + "ed"
		  end
		end
	      end
            end
          end
        end
      end
    end
    return string
  end

  def english_mood(string,form)
    case form
      when "imperative"
      return string + "!"
      when "potential"
      case string
	when "is"
	return "can be"
	else
	return "can " + string
	end
      when "passive"
      case string
        when "come"
        return "is made to come"
        when "die"
        return "is killed"
        when "get mad"
        return "is made to get mad"
        when "go"
        return "is made to go"
        when "laugh"
        return "is laughed at"
        when "make"
        return "is made"
        when "go home"
        return "is made to go home"
        when "work"
        return "is made to work"
        when "wait"
        return "is made to wait"
        when "sleep"
        return "is made to sleep"
        else
        case string.slice(0,3)
        when "be "
          return "be made to " + string
        when "go "
          return "be made to " + string
        else
          return "is " + english_tensify(string,"past")
        end
      end
    else
      return string
    end
  end

  def english_polarize(string,polarity,form)
    case polarity
      when "negative"
      case form 
      when "imperative"
	case string
	  when "hear"
	  return "don't listen!"
	  else
	  return "don't " + string
	end
      else
        case string.slice(0,3)
          when "is "
          return "isn't " + string.slice(3,string.size)
          when "be "
          return "not be " + string.slice(3,string.size)
          else
          case string.slice(0,6)
          when "could "
            return "couldn't " + string.slice(6,string.size)
          else
            case string.slice(0,4)
            when "can "
              return "can't " + string.slice(4,string.size)
            end
          end
        end
      end
    end
    return string
  end

  def translate(form,polarity,tense)
    pre_form = english_polarize(english_mood(self.english,form),
                                polarity,form)

    case form
      when "tari"
      return self.english + " (-tari)"
      when "imperative"
      return pre_form
      else
      return english_tensify(pre_form,tense)
    end

  end

  def inflect(form,polarity,tense)
    #note that tari form doesn't need to do tensify() or polarize()
    # since it has neither tense or polarity.

    @inflected = stage1(form)

    return tensify(polarize(@inflected,
                            form,polarity),
                   form,tense)
  end

  def stage1(form)
    case form
    when "tari"
      return self.tari
    when "passive"
      return self.passive
    when "potential"
      return self.potential
    when "imperative"
      return self.imperative
    when "humble"
      return self.kenjougo
    when "honorific"
      return self.sonkeigo
    else
      #error..
      raise "error: don't know how to handle form: " + form
    end
  end

  def humble=(form)
    self.make_exception(form,"humble")
  end

  def honorific=(form)
    self.make_exception(form,"honorific")
  end

  def potential=(form)
    self.make_exception(form,"potential")
  end

  def imperative=(form)
    self.make_exception(form,"imperative")
  end

  def passive=(form)
    self.make_exception(form,"passive")
  end

  def tari=(form)
    self.make_exception(form,"tari")
  end

  def make_exception(form,inflection_name)
    infl = Inflection.find(:all,:conditions=>"name='"+inflection_name+"'")[0]

    exception = 
      LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
    if exception
      #update this object.
      exception.form = form
    else
      exception = LexicalException.new
      exception.lexeme_id = self.id
      exception.inflection_id = infl.id
    end
    exception.form = form
    exception.save
  end

  def kenjougo
    inflection_name = "humble"
    infl = Inflection.find(:all,:conditions=>"name='"+inflection_name+"'")[0]

    exception = 
      LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
    if exception
      return exception.form
    else
      return "お"+self.premasu+"する"
    end
  end

  def sonkeigo
    inflection_name = "honorific"
    infl = Inflection.find(:all,:conditions=>"name='"+inflection_name+"'")[0]

    exception = 
      LexicalException.find(:all,:conditions=>"(lexeme_id="+self.id.to_s+") AND (inflection_id="+infl.id.to_s+")")[0]
    if exception
      return exception.form
    else
      return "お"+self.premasu+"になる"
    end
  end
  
  
end
