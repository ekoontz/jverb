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

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page">
      <xsl:with-param name="title">Verbs</xsl:with-param>
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
      <form name="guessform" action="next" method="post">
	<table>
	  <tr>
	    <th>
	      <input type="checkbox" name="potential">
		<xsl:if test="$potential = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
            <th>Potential</th>
	    <th>
	      <input type="checkbox" name="passive">
		<xsl:if test="$passive = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
	    <th>Passive</th>
	    <th>
	      <input type="checkbox" name="imperative">
		<xsl:if test="$imperative = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
	    <th>Imperative</th>
	    <th>
	      <input type="checkbox" name="tari">
		<xsl:if test="$tari = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
	    <th>tari</th>
	    <th>
	      <input type="checkbox" name="keigo">
		<xsl:if test="$keigo = 'on'">     
		  <xsl:attribute name="checked">checked</xsl:attribute>
		</xsl:if>
	      </input>
	    </th>
	    <th>keigo</th>
	  </tr>
	</table>
	<table class="question" style="width:99%">
	  <tr>
	    <th/>
	    <th style="width:25%">dictionary</th>
	    <th style="width:4%">form</th>
	    <th style="width:4%">tense</th>
            <th style="width:3%">+/-</th>
	    <th style="width:9%">translation</th>
	    <th style="width:30%">your guess</th>
	    <th style="width:30%"></th>
	  </tr>
	  <xsl:apply-templates select="question"/>
	</table>
      </form>
    </div>
  </xsl:template>
   
  <xsl:template match="question">
    <tr class="row{position() mod 2}">
      <td><xsl:value-of select="@ordinal"/></td>
      <td><xsl:value-of select="@lexeme"/></td>
      <td>
	<xsl:value-of select="@inflection"/>
      </td>
      <td>
	<xsl:choose>
	  <xsl:when test="@inflection = 'passive'">
	    <xsl:text> </xsl:text><xsl:value-of select="@tense"/>
	  </xsl:when>
	  <xsl:when test="@inflection = 'potential'">
	    <xsl:text> </xsl:text><xsl:value-of select="@tense"/>
	  </xsl:when>
	  <xsl:when test="@inflection = 'honorific'">
	    <xsl:text> </xsl:text><xsl:value-of select="@tense"/>
	  </xsl:when>
	  <xsl:when test="@inflection = 'humble'">
	    <xsl:text> </xsl:text><xsl:value-of select="@tense"/>
	  </xsl:when>
	  <xsl:otherwise/>
	</xsl:choose>
      </td>
      <td>
        <xsl:variable name="polarity"><xsl:choose>
        <xsl:when test="@polarity = 'positive'">+</xsl:when>
        <xsl:otherwise>-</xsl:otherwise>
      </xsl:choose>
        </xsl:variable>
        <span style="font-size:large;font-weight:bold">
	<xsl:choose>
	  <xsl:when test="(@inflection = 'passive')or(@inflection = 'potential')or(@inflection = 'imperative')or(@inflection='honorific')or(@inflection='humble')">
            <xsl:text> </xsl:text><xsl:value-of select="$polarity"/>
	  </xsl:when>
	  <xsl:otherwise/>
	</xsl:choose>
      </span>
      </td>
      <td><xsl:value-of select="@english"/></td>
      <td>
	<xsl:choose>
	  <xsl:when test="position() = 1">
	    <input name="guess"/>
	  </xsl:when>
	  <xsl:when test="@guess = @answer">
	    <xsl:attribute name="class">correct</xsl:attribute>
	    <xsl:value-of select="@guess"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:attribute name="class">incorrect</xsl:attribute>
	    <xsl:value-of select="@guess"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td style="white-space:nowrap;">
	<xsl:choose>
	  <xsl:when test="position() = 1">
	    <input type="submit" value="Next"/>
	  </xsl:when>
	  <xsl:when test="@guess = @answer"/>
	  <xsl:otherwise>
	    <xsl:value-of select="@answer"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
    </tr>
  </xsl:template>


</xsl:stylesheet>
  