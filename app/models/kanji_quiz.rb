class KanjiQuiz < Quiz

  set_table_name "kanji_quizzes"

  def export(params)

    @questions = KanjiQuestion.find(:all,
                               :conditions=>'quiz_id='+self.id.to_s,
                               :order => "ordinal DESC"
                               )
    @total = @questions.size
    @correct = self.correct

    if (@total > 0)
      if (@total > 1) 
        @ratio = ((@correct.to_f/(@total.to_f-1))*100).ceil
      else
        @ratio = 100
      end
    else
      @ratio = 0
    end

    @xml = ""
    xml = Builder::XmlMarkup.new( :target => @xml, :indent => 2 )

    xml.instruct! :xml, :version => "1.0", :encoding => "utf-8"
# the next line allows the browser to transform the document, 
# if we choose to send the document as xml.
    if params['send-stylesheet-ref'] == true
      xml.instruct! :"xml-stylesheet",:type=>"text/xsl",:href=>"/jverb/stylesheets/xsl/quiz2html.xsl"
    end

    xml.quiz(:user_id => self.user_id,
             :started => self.started,
             :elapsed => Time.now - self.started,
             :speed => ((@correct * 60.0) / (Time.now - self.started)),
             :id => self.id,
             :total => @total,
             :ratio => @ratio,
             :correct => @correct) do

      @questions.each do |q|
        xml.question(:id => q.attributes["id"],
                     :ordinal => q.attributes["ordinal"],
                     :lexeme => Lexeme.find(q.attributes["lexeme"]).string,
                     :answer => q.attributes["answer"],
                     :guess => q.attributes["guess"])
      end
    end

  end



end
