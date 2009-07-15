<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:param name="offset"/>
  <xsl:param name="total"/>
  <xsl:param name="order" select="'string'"/>

  <xsl:template match="lexicon" mode="detailed_set">
    <div>
      <table class="plain detailed">
	<xsl:apply-templates select="." mode="detailed_row"/>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="lexicon" mode="detailed_row">
    <xsl:param name="offset" select="0"/>
    <xsl:if test="lexeme[position() &gt; $offset]">
      <tr>
	<td><xsl:apply-templates select="lexeme[$offset + 1]" mode="detailed"/></td>
	<td><xsl:apply-templates select="lexeme[$offset + 2]" mode="detailed"/></td>
	<td><xsl:apply-templates select="lexeme[$offset + 3]" mode="detailed"/></td>
      </tr>
      <xsl:apply-templates select="." mode="detailed_row">
	<xsl:with-param name="offset"><xsl:value-of select="$offset + 3"/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:template>

  <xsl:template match="lexeme" mode="detailed">
    <div class="detailed">
      <table class="plain details">
	<tr>
	  <td>
	    <h1>
	      <xsl:value-of select="@string"/>
	    </h1>
	  </td>
	  <td>
	    <table class="plain inflections">
	      <tr>
		<th>English</th>
		<td>
		  <xsl:value-of select="@english"/>
		</td>
	      </tr>
	      <tr>
		<th>Potential</th>
		<td>
		  <xsl:value-of select="@potential"/>
		</td>
	      </tr>
	      <tr>
		<th class="under">Past</th>
		<td>
		  <xsl:value-of select="@potential_past"/>
		</td>
	      </tr>
	      <tr>
		<th class="under">Neg</th>
		<td>
		  <xsl:value-of select="@potential_negative"/>
		</td>
	      </tr>
	      <tr>
		<th>Passive</th>
		<td>
		  <xsl:value-of select="@passive"/>
		</td>
	      </tr>
	      <tr>
		<th class="under">Past</th>
		<td>
		  <xsl:value-of select="@passive_past"/>
		</td>
	      </tr>
	      <tr>
		<th class="under">Neg</th>
		<td>
		  <xsl:value-of select="@passive_negative"/>
		</td>
	      </tr>

	      <tr>
		<th>謙譲語</th>
		<td><xsl:value-of select="@humble"/></td>
	      </tr>

	      <tr>
		<th>尊敬語</th>
		<td><xsl:value-of select="@honorific"/></td>
	      </tr>


	    </table>
	  </td>
	</tr>
      </table>
    </div>

<!--
    <tr id="edit{position()}" class="row{(position()-1) mod 2}">
      <td><xsl:value-of select="position()"/></td>
      <td>
	<div class="show">
	  <xsl:value-of select="@string"/>
	</div>
	<div class="edit">
	  <input type="hidden" name="id" value="{@id}"/>
	  <input size="10" name="lexeme[string]" value="{@string}"/>
	</div>
      </td>
      <td>
	<div class="show">
	  <xsl:value-of select="@lex_type"/>
	</div>
	<div class="edit">
	  <xsl:apply-templates select="." mode="lex_type_dropdown"/>
	</div>
      </td>
      <td style="text-align:left">
	<div class="show">
	  <xsl:value-of select="@english"/>
	</div>
	<div class="edit">
	  <xsl:apply-templates select="." mode="english_input"/>
	</div>
      </td>
      <td style="text-align:left">
	<xsl:choose>
	  <xsl:when test="@lex_type=3">
	    <xsl:call-template name="editable_column">
	      <xsl:with-param name="input_name">lexeme[potential]</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="@potential"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@potential"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td style="text-align:left">
	<xsl:value-of select="@potential_past"/>
      </td>
      <td style="text-align:left">
	<xsl:value-of select="@potential_negative"/>
      </td>
      <td style="text-align:left">
	<xsl:value-of select="@potential_negative_past"/>
      </td>

      <td style="text-align:left">
	<xsl:choose>
	  <xsl:when test="@lex_type=3">
	    <xsl:call-template name="editable_column">
	      <xsl:with-param name="input_name">lexeme[passive]</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="@passive"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@passive"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td style="text-align:left"><xsl:value-of select="@passive_past"/></td>
      <td style="text-align:left"><xsl:value-of select="@passive_negative"/></td>
      <td style="text-align:left"><xsl:value-of select="@passive_past"/></td>

      <td style="text-align:left">
	<xsl:choose>
	  <xsl:when test="@lex_type=3">
	    <xsl:call-template name="editable_column">
	      <xsl:with-param name="input_name">lexeme[imperative]</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="@imperative"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@imperative"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td style="text-align:left"><xsl:value-of select="@imperative_negative"/></td>
      <td style="text-align:left">
	<xsl:choose>
	  <xsl:when test="@lex_type=3">
	    <xsl:call-template name="editable_column">
	      <xsl:with-param name="input_name">lexeme[tari]</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="@tari"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@tari"/>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td style="text-align:left">
	<xsl:variable name="honorific_id">
	  <xsl:value-of select="/lexicon/inflection[@name='honorific']/@id"/>
	</xsl:variable>
	<xsl:variable name="honorific_form">
	  <xsl:choose>
	    <xsl:when test="exception[@inflection_id=$honorific_id]">
	      <xsl:value-of select="exception[@inflection_id=$honorific_id]/@form"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="@honorific"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<div class="show">
	  <xsl:value-of select="$honorific_form"/>
	</div>
	<div class="edit">
	  <input size="10" name="lexeme[honorific]" value="{$honorific_form}"/>
	</div>
      </td>
      <td style="text-align:left">
	<xsl:variable name="humble_id">
	  <xsl:value-of select="/lexicon/inflection[@name='humble']/@id"/>
	</xsl:variable>
	<xsl:variable name="humble_form">
	  <xsl:choose>
	    <xsl:when test="exception[@inflection_id=$humble_id]">
	      <xsl:value-of select="exception[@inflection_id=$humble_id]/@form"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="@humble"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	<div class="show">
	  <xsl:value-of select="$humble_form"/>
	</div>
	<div class="edit">
	  <input size="10" name="lexeme[humble]" value="{$humble_form}"/>
	</div>
      </td>

      <td class="edit">
	<div class="show">
	  <table>
	    <tr>
		<td><button onclick="edit({position()})">edit</button></td>
		<td><button 
			onclick="create_update_delete('lexicon','destroy','lexicon_form','edit{position()}')">delete</button></td>
	    </tr>
	  </table>
	</div>
	<div class="edit">
	  <table>
	    <tr>
	      <td><button onclick="cancel({position()})">cancel</button></td>
	      <td><button 
		      onclick="create_update_delete('lexicon','update','lexicon_form','edit{position()}')">save</button>
	      </td>
	    </tr>
	  </table>
	</div>
      </td>
    </tr>

-->
  </xsl:template>

  <xsl:template name="detailed_sorter">
    <xsl:variable name="upto">
      <xsl:choose>
	<xsl:when test="( $offset + @limit ) &gt; $total"><xsl:value-of select="$total"/></xsl:when>
	<xsl:otherwise><xsl:value-of select="$offset+@limit"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <div style="width:100%;text-align:center">
      Showing 
      <xsl:value-of select="$offset + 1"/>-<xsl:value-of select="$upto"/> of <xsl:value-of select="$total"/> total.
      <div class="detailed_sorter" style="margin-top:1em">
	<form>
	  <input type="hidden" name="offset" value="{$offset}"/>
	  <input id="lexicon_tab" type="hidden" name="lexicon_tab" value="{$lexicon_tab}"/>
	<table style="width:100%;">
	  <tr>
	    <td>
	      <input type="submit" name="increment" value="&lt;&lt;">
		<xsl:if test="$offset = 0">
		  <xsl:attribute name="disabled">disabled</xsl:attribute>
		</xsl:if>
	      </input>
	    </td>
	    <td>
	      <input type="submit" name="increment" value="&lt;">
		<xsl:if test="$offset = 0">
		  <xsl:attribute name="disabled">disabled</xsl:attribute>
		  </xsl:if>
	      </input>
	    </td>
	    <td>
	      <span style="text-align:right;white-space:nowrap">Order</span>
	    </td>
	    <td>
	      <select onchange="submit()" name="order">
		<option value="string">
		  <xsl:if test="$order='string'">
		    <xsl:attribute name="selected">selected</xsl:attribute>
		  </xsl:if>
		Japanese</option>
		<option value="english">
		  <xsl:if test="$order='english'">
		    <xsl:attribute name="selected">selected</xsl:attribute>
		  </xsl:if>
		English</option>
		<option value="lex_type">
		  <xsl:if test="$order='lex_type'">
		    <xsl:attribute name="selected">selected</xsl:attribute>
		  </xsl:if>
		Type
		</option>
		<option value="created">
		  <xsl:if test="$order='created'">
		    <xsl:attribute name="selected">selected</xsl:attribute>
		  </xsl:if>
		Last Added
		</option>
		<option value="last_modified">
		  <xsl:if test="$order='last_modified'">
		    <xsl:attribute name="selected">selected</xsl:attribute>
		  </xsl:if>
		Last Modified
		</option>
	      </select>
	    </td>
	    <td>
	      <input type="submit" name="increment" value="&gt;">
		<xsl:if test="not($offset + $limit &lt; $total)">
		  <xsl:attribute name="disabled">disabled</xsl:attribute>
		  </xsl:if>
	      </input>
	    </td>
	    <td>
	      <input type="submit" name="increment" value="&gt;&gt;">
		<xsl:if test="not($offset + $limit &lt; $total)">
		  <xsl:attribute name="disabled">disabled</xsl:attribute>
		  </xsl:if>
	      </input>
	    </td>
	  </tr>
	</table>
	</form>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>