require 'xml/xslt'

class KanjiController < ApplicationController

  before_filter :set_content_type

  def set_content_type
    if self.params["format"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8" 
    else
      @headers["Content-Type"] = "text/html; charset=utf-8" 
    end
  end

  def new
    # set up a new quiz for this user and set session info.
    @quiz = KanjiQuiz.new
    @quiz.init
    session[:quiz] = @quiz.id
    session[:question] = nil

    # redirect to next
    redirect_to :action => 'next'
  end

  def next

    @previous_answer = ""
    @css = "welcome"
    
    if !session[:quiz]
      redirect_to :action => 'new'
      return
    end

    @quiz = KanjiQuiz.find(session[:quiz])

    if !@quiz
      redirect_to :action => 'new'
    end

    @total = KanjiQuestion.find(:all,:conditions=>'quiz_id='+@quiz.id.to_s).size

    at_beginning = true

    # get last question and answer.
    if session[:question] 
      question = KanjiQuestion.find(session[:question])
      question.guess = self.params[:guess]
      question.save!
      if !question.guess
#        probably at beginning of quiz.
      else
        at_beginning = false
        if question.guess == question.answer
          if @quiz.correct
            @quiz.correct = @quiz.correct + 1
          else
            @quiz.correct = 1
          end
          @quiz.save!
        else

          #Boo! Wrong answer!
          # might want to tally wrong answers as well as correct.

        end
      end
    end

    # generate a new question.(Kanji should be a subclass of Question)
    question = KanjiQuestion.new.random(@quiz.id,self.params)

    session[:question] = question.id

    @xml = @quiz.export(self.params)

    if self.params["format"] == "xml"
      @out = @xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = @xml

      xslt.parameters = {
        "samplekey" => "samplevalue"
      }
                      
      xslt.xsl = "stylesheets/xsl/kanjiquiz2html.xsl"
      @out = xslt.serve()
    end

  end

end
