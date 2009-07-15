<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">

  <xsl:param name="direction"/>
  <xsl:param name="order"/>
  <xsl:param name="elapsed"/>
  <xsl:param name="lexicon_tab" select="'v1'"/>

  <xsl:include href="stdlib.xsl"/>
  <xsl:include href="lexeme.xsl"/>

  <xsl:variable name="opposite_direction">
    <xsl:choose>
      <xsl:when test="$direction = 'DESC'">ASC</xsl:when>
      <xsl:otherwise>DESC</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="page">
      <xsl:with-param name="title">Lexicon</xsl:with-param>
      <xsl:with-param name="onload">
	tab('lex','<xsl:value-of select="$lexicon_tab"/>')
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="lexicon">
    <form style="display:none" action="/jverb/lexeme/edit" method="post" id="lexicon_form">
	<input type="hidden" name="lexicon_tab" value="v2"/>
	<input type="hidden" name="order" value="{$order}"/>
	<input type="hidden" name="limit" value="{$limit}"/>
	<input type="hidden" name="total" value="{$total}"/>
    </form>

    <div class="statusbox">
      <xsl:call-template name="detailed_sorter"/>
    </div>

    <div class="main" style="width:100%;">
      <table class="tabs">
	<thead>
	  <tr id="lex_tabs">
	    <th class="tabs" id="v1" onclick="tab('lex','v1','lexicon_tab')">Detailed</th>
	    <th class="tabs spacer"/>
	    <th class="tabs" id="v2" onclick="tab('lex','v2','lexicon_tab')">Table</th>
	  </tr>
	</thead>
	<tbody class="tabs">
	  <tr>
	    <td colspan="3" id="lex_bodies">
	      <div class="tab_body" id="v1_body">
		<xsl:apply-templates select="." mode="detailed_set"/>
	      </div>
	      <div class="tab_body" id="v2_body">
		<xsl:apply-templates select="." mode="wide_table"/>
	      </div>
	    </td>
	  </tr>
	</tbody>
      </table>
    </div>
</xsl:template>
   
  <xsl:template name="sorter">
    <xsl:param name="table_order"/>
    <xsl:param name="column_order"/>
    <xsl:param name="column_name"><xsl:value-of select="$column_order"/></xsl:param>

    <div style="padding:0.5em">
      <xsl:choose>
	<xsl:when test="$table_order = $column_order">
	  <xsl:attribute name="class">selected</xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="class">selectable</xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <table style="border:0;padding:0;margin:0;border-collapse:collapse">
	<tr>
	  <td style="padding-bottom:0.5em;">
	    <a style="border:0px dashed green;" href="?order={$column_order}&amp;direction={$opposite_direction}&amp;lexicon_tab=v2"><xsl:value-of select="$column_name"/></a>
	    </td>
	    <td>
	      <xsl:choose>
		<xsl:when test="$table_order = $column_order">
		  <xsl:choose>
		    <xsl:when test="$direction='ASC'">
		      <a style="border:0px dashed green;padding:0" href="?order={$column_order}&amp;direction={$opposite_direction}&amp;lexicon_tab=v2">
			<img width="15" height="15" src="/jverb/images/asc.png" alt="ascending"/>
		      </a>
		    </xsl:when>
		    <xsl:otherwise>
		      <a style="border:0px dashed green;padding:0" href="?order={$column_order}&amp;direction={$opposite_direction}&amp;lexicon_tab=v2">
			<img width="15" height="15" src="/jverb/images/desc.png" alt="descending"/>
		      </a>
		    </xsl:otherwise>
		  </xsl:choose>
		</xsl:when>
		<xsl:otherwise/>
	      </xsl:choose>
	    </td>
	</tr>
      </table>
    </div>
  </xsl:template>

  <xsl:template match="lexeme">
    <tr id="edit{position()}" class="row{(position()-1) mod 2}">
      <td style="text-align:right;font-weight:bold"><xsl:value-of select="position() + $offset"/></td>
      <td>
	<input type="hidden" name="id" value="{@id}"/>
	<xsl:call-template name="editable_column">
	  <xsl:with-param name="input_name">lexeme[string]</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="@string"/></xsl:with-param>
	</xsl:call-template>
      </td>
      <td>
	<div class="show">
	  <xsl:value-of select="@lex_type"/>
	</div>
	<div class="edit">
	  <xsl:apply-templates select="." mode="lex_type_dropdown"/>
	</div>
      </td>
      <td>
	<div class="show">
	  <xsl:value-of select="@english"/>
	</div>
	<div class="edit">
	  <xsl:apply-templates select="." mode="english_input"/>
	</div>
      </td>
      <td>
	<xsl:choose>
	  <xsl:when test="@lex_type=3">
	    <xsl:call-template name="editable_column">
	      <xsl:with-param name="input_name">lexeme[potential]</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="@potential"/></xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <span class="show"><xsl:value-of select="@potential"/></span>
	  </xsl:otherwise>
	</xsl:choose>
      </td>
      <td>
	<span class="show"><xsl:value-of select="@potential_past"/></span>
      </td>
      <td>
	<span class="show">
	  <xsl:value-of select="@potential_negative"/>
	</span>
      </td>
      <td>
	<span class="show"><xsl:value-of select="@potential_negative_past"/></span>
      </td>

      <td>
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
      <td><xsl:value-of select="@passive_past"/></td>
      <td><xsl:value-of select="@passive_negative"/></td>
      <td><xsl:value-of select="@passive_negative_past"/></td>

      <td>
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
      <td><xsl:value-of select="@imperative_negative"/></td>
      <td>
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
      <td>
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
	<xsl:call-template name="editable_column">
	  <xsl:with-param name="input_name">lexeme[honorific]</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="$honorific_form"/></xsl:with-param>
	</xsl:call-template>
      </td>
      <td>
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

	<xsl:call-template name="editable_column">
	  <xsl:with-param name="input_name">lexeme[humble]</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="$humble_form"/></xsl:with-param>
	</xsl:call-template>
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
  </xsl:template>

  <xsl:template match="lexeme" mode="english_input">
    <input size="{string-length(@english)+1}" name="lexeme[english]" value="{@english}"/>
  </xsl:template>

  <xsl:template match="lexeme" mode="humble_input">
    <xsl:param name="form"/>
  </xsl:template>

  <xsl:template match="lexeme" mode="lex_type_dropdown">
    <select name="lexeme[lex_type]">
      <xsl:call-template name="option">
	<xsl:with-param name="option" select="'る'"/>
	<xsl:with-param name="optiontext" select="'る-verb'"/>
	<xsl:with-param name="select" select="@lex_type"/>
      </xsl:call-template>
      <xsl:call-template name="option">
	<xsl:with-param name="option" select="'う'"/>
	<xsl:with-param name="optiontext" select="'う-verb'"/>
	<xsl:with-param name="select" select="@lex_type"/>
      </xsl:call-template>
      <xsl:call-template name="option">
	<xsl:with-param name="option" select="'3'"/>
	<xsl:with-param name="optiontext" select="'type3'"/>
	<xsl:with-param name="select" select="@lex_type"/>
      </xsl:call-template>
      <xsl:call-template name="option">
	<xsl:with-param name="option" select="'unclassified'"/>
	<xsl:with-param name="select" select="@lex_type"/>
      </xsl:call-template>
    </select>
  </xsl:template>

  <xsl:template name="option">
    <xsl:param name="option"/>
    <xsl:param name="optiontext" select="$option"/>
    <xsl:param name="select"/>
    <option value="{$option}">
      <xsl:if test="$option = $select">
	<xsl:attribute name="selected">selected</xsl:attribute>
      </xsl:if>
      <xsl:value-of select="$optiontext"/>
    </option>
  </xsl:template>

  <xsl:template match="lexicon" mode="wide_table">
    <table class="lexicon" style="width:99%">
      <tr>
	<th style="width:5%" rowspan="3"/>
	<th style="width:5%;" rowspan="3">
	  <xsl:call-template name="sorter">
	    <xsl:with-param name="table_order"><xsl:value-of select="$order"/></xsl:with-param>
	    <xsl:with-param name="column_order">string</xsl:with-param>
	  </xsl:call-template>
	</th>
	<th style="width:5%;" rowspan="3">
	  <xsl:call-template name="sorter">
	    <xsl:with-param name="table_order"><xsl:value-of select="$order"/></xsl:with-param>
	    <xsl:with-param name="column_order">lex_type</xsl:with-param>
	    <xsl:with-param name="column_name">type</xsl:with-param>
	  </xsl:call-template>
	</th>
	<th style="width:10%;text-align:center" rowspan="3">
	  <xsl:call-template name="sorter">
	    <xsl:with-param name="table_order"><xsl:value-of select="$order"/></xsl:with-param>
	    <xsl:with-param name="column_order">english</xsl:with-param>
	    <xsl:with-param name="column_name">english</xsl:with-param>
	  </xsl:call-template>
	  
	</th>
	<th style="width:20%;text-align:center" colspan="4">potential</th>
	<th style="width:20%;text-align:center" colspan="4">passive</th>
	<th style="width:15%;text-align:center" rowspan="1" colspan="2">imperative</th>
	<th style="width:10%;text-align:center" rowspan="3">tari</th>
	<th style="width:10%;text-align:center" rowspan="3">尊敬語</th>
	<th style="width:10%;text-align:center" rowspan="3">謙譲語</th>
	<th style="width:10%" rowspan="3"></th>
      </tr>
      <tr>
	<th style="text-align:center" colspan="2">pos</th><th style="text-align:center" colspan="2">neg</th>
	<th style="text-align:center" colspan="2">pos</th><th style="text-align:center" colspan="2">neg</th>
	<th style="text-align:center" rowspan="2">pos</th><th style="text-align:center" rowspan="2">neg</th>
      </tr>
      <tr>
	<th>pres</th><th>past</th>
	<th>pres</th><th>past</th>
	<th>pres</th><th>past</th>
	<th>pres</th><th>past</th>
      </tr>
      <tr id="editnew" class="row1">
	<td style="text-align:center">new</td>
	<td><input size="10" name="lexeme[string]" style="float:left"></input></td>
	<td>
	  <select name="lexeme[lex_type]" style="float:left">
	    <option value="る">る-verb</option>
	    <option value="う">う-verb</option>
	    <option value="3">type3</option>
	  </select>
	</td>
	<td>
	  <input size="10" name="lexeme[english]" style="float:left"/>
	</td>
	<td style="text-align:left" class="edit">
	  <button 
	      onclick="create_update_delete('lexicon','create','lexicon_form','editnew')">new</button>
	</td>
      </tr>
      <xsl:apply-templates select="lexeme"/>
    </table>
    
  </xsl:template>
  
</xsl:stylesheet>
