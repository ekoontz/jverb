require 'xml/xslt'

class InflectController < ApplicationController
  def list

    answer = ""

    if (params[:lexeme] && 
        (params[:lexeme] != 'Choose a verb') &&
        params[:inflection] &&
        params[:polarity] &&
        params[:tense])

      verb_obj = Lexeme.find(params[:lexeme])

      lexical = verb_obj.string
      elexical = verb_obj.english

      stage1 = verb_obj.stage1(params[:inflection])
      estage1 = verb_obj.english_mood(verb_obj.english,params[:inflection])

      stage2 = verb_obj.polarize(stage1,
                                 params[:inflection],
                                 params[:polarity])

      estage2 = verb_obj.english_polarize(estage1,
                                          params[:polarity],
                                          params[:inflection])

      answer = (verb_obj.inflect(params[:inflection],
                                params[:polarity],
                                params[:tense])).to_s

      eanswer = (verb_obj.english_tensify(estage2,params[:tense]))


    end

    if !params[:lexeme]
      params[:lexeme] = ""
    end
    if !params[:inflection]
      params[:inflection] = ""
    end
    if !params[:polarity]
      params[:polarity] = ""
    end
    if !params[:tense]
      params[:tense] = ""
    end

    @xml = ""
    xml = Builder::XmlMarkup.new( :target => @xml, :indent => 2 )
    xml.instruct! :xml, :version => "1.0", :encoding => "utf-8"

    inflections = Inflection.find(:all)
    lexemes = Lexeme.find(:all)

    xml.inflect(
                :elexical => elexical,
                :lexical => lexical,
                :answer => answer,
                :eanswer => eanswer,
                :stage1 => stage1,
                :estage1 => estage1,
                :stage2 => stage2,
                :estage2 => estage2
                ) do
      inflections.each do |infl|
        infl.export(xml)
      end
      lexemes.each do |lexeme|
        lexeme.export(xml)
      end
    end

    xslt = XML::XSLT.new()
    xslt.xml = @xml
  

    xslt.parameters = {
      "lexeme" => params[:lexeme],
      "inflection" => params[:inflection],
      "polarity" => params[:polarity],
      "tense" => params[:tense],
      "answer" => answer
    }
                      
    xslt.xsl = "stylesheets/xsl/inflect2html.xsl"

    if self.params["format"] == "xml"
      @out = @xml
    else
      @out = xslt.serve()
    end

    render :xml => @out

  end
end
