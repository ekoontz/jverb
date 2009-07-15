<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:param name="imperative"/>
  <xsl:param name="passive"/>
  <xsl:param name="potential"/>
  <xsl:param name="tari"/>
  <xsl:param name="keigo"/>

  <xsl:include href="stdlib.xsl"/>
  <xsl:include href="quiz.xsl"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page">
      <xsl:with-param name="title">Kanji</xsl:with-param>
      <xsl:with-param name="onload">document.guessform.guess.focus();</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="quiz">

    <div class="statusbox">
      <table style="width:99%;text-align:center">
	<tr>
	  <th style="width:40%">Correct</th>
	  <th style="width:40%">Total</th>
	</tr>
	<tr>
	  <td><xsl:value-of select="@correct"/></td>
	  <td><xsl:value-of select="@total - 1"/></td>
	</tr>
	<tr>
	  <th style="text-align:center;border-top:1px solid #6666ff" colspan="2">
	    <xsl:value-of select="@ratio"/>% Correct
	  </th>
	</tr>
	<tr>
	  <td colspan="2">
	    <div style="border:1px solid black;width:100%;padding:0" class="incorrect">
	      <div class="ratio" style="width:{@ratio}%"/>
	    </div>			    
	  </td>			    
	</tr>
	<tr>
	  <th style="text-align:center;border-top:1px solid #6666ff" colspan="2">Speed</th>			    
	</tr>
	<tr>
	  <td colspan="2">
	    <xsl:value-of select="@speed"/> correct answers / minute
	  </td>
	</tr>
      </table>
    </div>						     

    <div style="width:60%;float:left;background:white">
      <form action="next" method="post">
	<table>
	  <tr>
	    <th>
	      <input type="checkbox" name="potential">
		<xsl:if test="$potential = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
            <th>Option 1</th>
	    <th>
	      <form action="?">
		<input type="checkbox" name="passive">
		  <xsl:if test="$passive = 'on'">     
		    <xsl:attribute name="checked">checked</xsl:attribute>
		  </xsl:if>
		</input>
	      </form>
	    </th>
	    <th>Option2</th>
	  </tr>
	</table>
	<table class="question" style="width:99%">
	  <tr>
	    <th/>
	    <th>漢字</th>
	    <th>ひらがな</th>
　	    <th>答え</th>
	  </tr>
	  <xsl:apply-templates select="question">
	    <xsl:with-param name="total" select="count(question)"/>
	  </xsl:apply-templates>
	</table>
      </form>
    </div>
  </xsl:template>
   
  <xsl:template match="question[1]">
    <xsl:param name="total"/>
    <xsl:variable name="id" select="@id"/>
    <tr class="row{position() mod 2}">
      <td><xsl:value-of select="$total - position()"/></td>
      <td><xsl:value-of select="@lexeme"/></td>
      <td>どうぞう答えて：</td>
      <td><form name="guessform" action="?" method="post"><div><input name="guess"/></div></form></td>
    </tr>
  </xsl:template>

  <xsl:template match="question">
    <xsl:param name="total"/>
    <tr class="row{position() mod 2}">
      <td><xsl:value-of select="$total - position()"/></td>
      <td><xsl:value-of select="@lexeme"/></td>
      <td><xsl:apply-templates select="/hiragana[@question=$id]"/></td>
      <td><xsl:value-of select="@guess"/></td>
    </tr>
  </xsl:template>

</xsl:stylesheet>
  