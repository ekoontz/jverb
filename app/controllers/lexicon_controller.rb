class LexiconController < ApplicationController

  def url_encode_params(params) 
    return "" + 
    (params[:lexicon_tab] ? ("lexicon_tab="+ params[:lexicon_tab]) : "") + 
    (params[:order] ? ("&order="+ params[:order]) : "") +
    (params[:offset] ? ("&offset="+ params[:offset]) : "") +
    (params[:limit] ? ("&limit="+ params[:limit]) : "") 
  end

  def create
    @lexeme = Lexeme.new(params[:lexeme])
    @lexeme.created = Time.now
    @lexeme.last_modified = @lexeme.created
    if @lexeme.save
# figure out how flash works and how we can integrate it into xslt..
      flash[:notice] = 'Lexeme was successfully created.'
      redirect_to "/jverb/lexicon?"+self.url_encode_params(params)
    else
      redirect_to "/jverb/lexicon?"+self.url_encode_params(params)
    end
  end

  def destroy
    Lexeme.find(params[:id]).destroy
    redirect_to "/jverb/lexicon"
  end

  def update 
    @lexeme = Lexeme.find(params[:id])
    if @lexeme.update_attributes(params[:lexeme])
      @lexeme.last_modified = Time.now
      @lexeme.save
      flash[:notice] = 'Lexeme was successfully updated.'
      redirect_to "/jverb/lexicon?"+self.url_encode_params(params)
    else
      redirect_to "/jverb/lexicon?"+self.url_encode_params(params)
    end
  end

  def index
    export
  end

  def list
    export
  end

  def export
    @xml = ""
    xml = Builder::XmlMarkup.new( :target => @xml, :indent => 2 )
    xml.instruct! :xml, :version => "1.0", :encoding => "utf-8"

    if !self.params["direction"]
      self.params["direction"] = "ASC"
    end

    if !self.params["order"]
      self.params["order"] = "last_modified"
    end

    if self.params["order"] == "last_modified"
      self.params["direction"] = "DESC"
    end

    if self.params["order"] == "created"
      self.params["direction"] = "DESC"
    end

    if !self.params["lexicon_tab"]
      self.params["lexicon_tab"] = "v1"
    end

    if !self.params["limit"]
      self.params["limit"] = 10
    end

    if self.params["offset"]
      self.params["offset"] = 
              self.params["offset"].to_i
    else
      self.params["offset"] = 0
    end

    # decode self.params['increment']
    if self.params['increment'] == '<<'
      self.params['offset'] = 0
    end

    if self.params['increment'] == '<'
      self.params['offset'] = 
        self.params['offset'] - self.params['limit']
    end

    if self.params['increment'] == '>'
      self.params['offset'] = 
        self.params['offset'] + self.params['limit']
    end

    if self.params['increment'] == '>>'
      self.params['offset'] = 
        self.params['offset'] + self.params['limit']
    end

    if !self.params["total"]
      self.params["total"] = Lexeme.find(:all).size
    end

    sorting_instr = self.params["order"] + ' ' + self.params["direction"]

    @lexemes = Lexeme.find(:all,
                           :order=> sorting_instr,
                           :offset => self.params["offset"],
                           :limit => self.params["limit"]
                           )

    xml.lexicon(:total => self.params["total"],
                :offset => self.params["offset"],
                :limit => self.params["limit"],
                :sortby => self.params["order"], 
                :sortdir => self.params["direction"]) do
      @lexemes.each do |lex|
        lex.export(xml)
      end

      inflections = Inflection.find(:all)
      inflections.each do |infl|
        infl.export(xml)
      end

    end


    if self.params["format"] == "xml"
      @out = @xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = @xml
      xslt.parameters = {
        "order"=>self.params["order"],
        "direction"=>self.params["direction"],
        "lexicon_tab"=>self.params["lexicon_tab"],
        "offset"=>self.params["offset"].to_s,
        "total"=>self.params["total"].to_s,
        "limit"=>self.params["limit"].to_s
      }
      xslt.xsl = "stylesheets/xsl/lexicon2html.xsl"
      @out = xslt.serve()

      render :xml => @out

    end

  end


end
