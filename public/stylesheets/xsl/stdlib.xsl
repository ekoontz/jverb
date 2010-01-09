<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:include href="edit.xsl"/>

  <xsl:param name="format"/>

  <xsl:template match="/" mode="page">
    <xsl:param name="title" select="'untitled'"/>
    <xsl:param name="onload"/>
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
      <head>
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<title>Japanese Learning Tool:<xsl:value-of select="$title"/></title>
	<link
          href="/stylesheets/quiz.css"
	  media="screen" rel="stylesheet" type="text/css" />

        <script type="text/javascript" src="/jverb/javascripts/edit.js">
	</script>
        <script type="text/javascript" src="/jverb/javascripts/tabs.js">
	</script>
      </head>
      <body onload="{$onload}">
	<div class="header">
	  <div style="width:50%;vertical-align:top">
	    <table style="border:0;vertical-align:top">
	      <tr>
		<td style="vertical-align:top;padding:0;margin:0">
		  <h3 class="en">Japanese Learning Tool: <xsl:value-of select="$title"/></h3>
		</td>
		<td>
		  <div style="width:5em">
		    <h2 class="jp">日本語</h2>
		    <h2 class="jp">動詞</h2>
		    <h2 class="jp">試験</h2>
		  </div>
		</td>
	      </tr>
	    </table>
	  </div>
	  <div style="float:right;margin-right:-1px">
	    <table class="select">
	      <tr>
		<td>
		  <xsl:if test="$title = 'Verbs'">
		    <xsl:attribute name="class">selected</xsl:attribute>
		  </xsl:if>
		  <a href="/jverb/quiz/new">Verbs</a>
		</td>
	      </tr>
	      <tr>
		<td>
		  <xsl:if test="$title = 'Kanji'">
		    <xsl:attribute name="class">selected</xsl:attribute>
		  </xsl:if>
                  <a href="/jverb/kanji/new">Kanji</a>
		</td>
	      </tr>
	      <tr>
		<td>
		  <xsl:if test="$title = 'Lexicon'">
		    <xsl:attribute name="class">selected</xsl:attribute>
		  </xsl:if>
		  <a href="/jverb/lexicon">Lexicon</a>
		</td>
	      </tr>
	      <tr>
		<td>
		  <xsl:if test="$title = 'Inflect'">
		    <xsl:attribute name="class">selected</xsl:attribute>
		  </xsl:if>
		  <a href="/jverb/inflect">Inflect</a>
		</td>
	      </tr>
	    </table>
	  </div>
	</div>	     			    		     

	<xsl:apply-templates/>
        <div style="width:90%;float:right;font-size:smaller;border:1px solid #6666ff;margin-bottom:1em">
          <div style="width:90%;float:left;padding:1em;"> by <a href="http://hiro-tan.org/~ekoontz">Eugene Koontz</a></div>
          <div style="float:left;padding:1em;"><a href="http://hiro-tan.org/svn/jverb">Source Code</a> licensed under the <a href="http://hiro-tan.org/svn/jverb/LICENSE">GNU Public License Version 2</a></div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="*" mode="tabs">
  </xsl:template>



</xsl:stylesheet>
  
