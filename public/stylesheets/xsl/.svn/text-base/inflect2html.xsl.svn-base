<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:include href="stdlib.xsl"/>

  <xsl:param name="lexeme"/>
  <xsl:param name="inflection"/>
  <xsl:param name="polarity"/>
  <xsl:param name="tense"/>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page">
      <xsl:with-param name="title">Inflect</xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="inflect">
    <div style="padding:1em;margin:1em;border:1px solid #6666ff">
    <form action="?">
      <table class="inflselect">
	<tr>
	  <th>Verb</th>
	  <th>Inflection</th>
	  <th>Polarity</th>
	  <th>Tense</th>
	</tr>
	<tr>
	  <td>
	    <select name="lexeme" onchange="submit()">
	      <option>Choose a verb</option>
	      <xsl:apply-templates select="lexeme" mode="dropdown"/>
	    </select>
	  </td>
	  <td>
	    <select name="inflection" onchange="submit()">
	      <xsl:apply-templates select="inflection" mode="dropdown"/>
	    </select>
	  </td>
	  <td>
	    <select name="polarity" onchange="submit()">
	      <option>
		<xsl:if test="$polarity = 'positive'">
		  <xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		positive
	      </option>
	      <option>
		<xsl:if test="$polarity = 'negative'">
		  <xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		negative
	      </option>
	    </select>
	  </td>
	  <td>
	    <select name="tense" onchange="submit()">
	      <option>
		<xsl:if test="$tense = 'present'">
		  <xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		present
	      </option>
	      <option>		
		<xsl:if test="$tense = 'past'">
		  <xsl:attribute name="selected">selected</xsl:attribute>
		</xsl:if>
		past
	      </option>
	    </select>
	  </td>

	</tr>

      </table>

      <xsl:if test="@answer != ''">
	<table class="inflect">
	  <tr>
	    <th/>
	    <th>J</th>
	    <th>E</th>
	  </tr>
	  <tr>
	    <th>Lexical</th>
	    <td>
	      <h3><xsl:value-of select="@lexical"/></h3>
	    </td>
	    <td>
	      <h3><xsl:value-of select="@elexical"/></h3>
	    </td>
	  </tr>
	  <tr>
	    <th>Inflect</th>
	    <td>
	      <h3><xsl:value-of select="@stage1"/></h3>
	    </td>
	    <td>
	      <h3><xsl:value-of select="@estage1"/></h3>
	    </td>
	  </tr>
	  <tr>
	    <th>Polarize</th>
	    <td>
	      <h3><xsl:value-of select="@stage2"/></h3>
	    </td>
	    <td>
	      <h3><xsl:value-of select="@estage2"/></h3>
	    </td>
	  </tr>
	  <tr>
	    <th>Tense</th>
	    <td><h2><xsl:value-of select="@answer"/></h2></td>
	    <td><h2><xsl:value-of select="@eanswer"/></h2></td>
	  </tr>
	</table>
      </xsl:if>
    </form>
    </div>
  </xsl:template>

  <xsl:template match="inflection" mode="dropdown">
    <option>
      <xsl:if test="$inflection = @name">
	<xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="@name"/>
    </option>
  </xsl:template>

  <xsl:template match="lexeme" mode="dropdown">
    <option value="{@id}">
      <xsl:if test="$lexeme = @id">
	<xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
    <xsl:value-of select="@string"/><xsl:text> </xsl:text>(<xsl:value-of select="@english"/>)</option>
  </xsl:template>

</xsl:stylesheet>
  