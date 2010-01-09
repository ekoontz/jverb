require 'xml/xslt'

class QuizController < ApplicationController

  before_filter :set_content_type

  def set_content_type
    @headers = {}
    if self.params["format"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8" 
    else
      @headers["Content-Type"] = "text/html; charset=utf-8" 
    end
  end

  def new
    # set up a new quiz for this user and set session info.
    @quiz = Quiz.new
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

    @quiz = Quiz.find(session[:quiz])

    if !@quiz
      redirect_to :action => 'new'
    end

    @total = Question.find(:all,:conditions=>'quiz_id='+@quiz.id.to_s).size

    at_beginning = true

    # get last question and answer.
    if session[:question] 
      question = Question.find(session[:question])
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

    # generate a new question.
    question = Question.new.random(@quiz.id,self.params)

    session[:question] = question.id

    @xml = @quiz.export(self.params)

    if self.params["format"] == "xml"
      @out = @xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = @xml

      if at_beginning == true
        self.params["potential"] = "on"
        self.params["passive"] = "on"
        self.params["imperative"] = "on"
        self.params["tari"] = "on"
        self.params["keigo"] = "on"
      else
        if !self.params["potential"]
          self.params["potential"] = "off"
        end
        if !self.params["passive"]
          self.params["passive"] = "off"
        end
        if !self.params["imperative"]
          self.params["imperative"] = "off"
        end
        if !self.params["tari"]
          self.params["tari"] = "off"
        end
        if !self.params["keigo"]
          self.params["keigo"] = "off"
        end
      end
      if !self.params["format"]
        self.params["format"] = "html"
      end
      xslt.parameters = {
        "potential" => self.params["potential"],
        "passive" => self.params["passive"],
        "imperative" => self.params["imperative"],
        "tari" => self.params["tari"],
        "keigo" => self.params["keigo"],
        "format" => self.params["format"]
      }
                      
      xslt.xsl = "public/stylesheets/xsl/quiz2html.xsl"
      @out = xslt.serve()

      render :xml => @out

    end

  end


end
