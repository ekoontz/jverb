<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="1.0">
  <xsl:output method="xml" indent="yes" encoding="utf-8" 
	      omit-xml-declaration="no"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>

  <xsl:template name="editable_column">
    <xsl:param name="input_name"/>
    <xsl:param name="value"/>
    <div class="show">
      <xsl:value-of select="$value"/>
    </div>
    <div class="edit">
      <input size="{string-length($value)+1}" name="{$input_name}" value="{$value}"/>
    </div>
  </xsl:template>
</xsl:stylesheet>