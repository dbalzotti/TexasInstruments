<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">

  <!-- This should be updated to be the date/time as of the latest code change. -->
  <xsl:variable name="code-timestamp">
    2018 June 7 21:00 UTC
  </xsl:variable>

  <xsl:param name="display-code-timestamp" select="'true'"/>

  <xsl:param name="allow-hyphenation-within-tables">false</xsl:param>

  <xsl:param name="frame-appendix-figures">true</xsl:param>

  <xsl:param name="terminate-on-missing-string-mapping">false</xsl:param>

  <!-- This can be 'letter', 'A4', or 'WxHunit' (e.g. 5.5x8.5in) --> 
  <xsl:param name="inputPageSize" as="xs:string">
    <xsl:call-template name="getMetadataValue.wd">
      <xsl:with-param name="document.id" select="$export-document-id"/>
      <xsl:with-param name="fieldname">FEDWARDSPAGESIZE</xsl:with-param>
      <xsl:with-param name="fieldlevel" select="'lng'"/>
      <xsl:with-param name="default" select="'letter'"/>
    </xsl:call-template>
  </xsl:param>

  <xsl:param name="column-count-override">
    <xsl:call-template name="getMetadataValue.wd">
      <xsl:with-param name="document.id" select="$export-document-id"/>
      <xsl:with-param name="fieldname">FEDWARDSCOLUMNCOUNT</xsl:with-param>
      <xsl:with-param name="fieldlevel" select="'lng'"/>
      <xsl:with-param name="default" select="''"/>
    </xsl:call-template>
  </xsl:param>

  <xsl:variable name="page-width">
    <xsl:choose>
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">8.5in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">210mm</xsl:when>
      <xsl:when test="contains($inputPageSize,'x')">
        <xsl:value-of 
          select="concat(normalize-space(tokenize($inputPageSize,'x')[1])
                  ,substring($inputPageSize,string-length($inputPageSize) - 1))"/>
      </xsl:when>
      <xsl:otherwise>8.5in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable><!-- page-width -->

  <xsl:variable name="page-height">
    <xsl:choose>
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">11in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">297mm</xsl:when>
      <xsl:when test="contains($inputPageSize,'x')">
        <xsl:value-of select="normalize-space(tokenize($inputPageSize,'x')[2])"/>
      </xsl:when>
      <xsl:otherwise>11in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable><!-- page-height -->

  <xsl:variable name="columnCount" as="xs:integer">

    <xsl:variable name="pub-type" as="xs:string">
      <xsl:call-template name="getMetadataValue.wd">
        <xsl:with-param name="document.id" select="$export-document-id"/>
        <xsl:with-param name="fieldname" select="'FISHPUBLICATIONTYPE'"/>
        <xsl:with-param name="fieldlevel" select="'logical'"/>
        <xsl:with-param name="default" select="'Unk'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:message>
      <xsl:text>Publication type: </xsl:text>
      <xsl:value-of select="$pub-type"/>
    </xsl:message>

    <xsl:choose>
      <xsl:when test="string(number($column-count-override))!='NaN'">
        <xsl:value-of select="number($column-count-override)"/>
      </xsl:when>
      <xsl:when test="$pub-type eq 'IFU - 1 Column'">1</xsl:when>
      <xsl:when test="$pub-type eq 'IFU - 2 Column'">2</xsl:when>
      <xsl:otherwise>3</xsl:otherwise>
    </xsl:choose>

  </xsl:variable><!-- columnCount -->

  <xsl:variable name="columnGap">
    <xsl:choose>
      <xsl:when test="$inputPageSize eq '140x182mm' ">
        <xsl:text>4.25mm</xsl:text>
      </xsl:when>
      <xsl:when test="$columnCount eq 2">
        <xsl:text>0.5in</xsl:text>
      </xsl:when>
      <xsl:when test="$columnCount eq 3">
        <xsl:text>.217in</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0pt</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="column-width-expression">
    <xsl:text>(</xsl:text>
    <xsl:value-of select="$page-width"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$page-margin-inside"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$page-margin-outside"/>
    <xsl:text> - (</xsl:text>
    <xsl:value-of select="$columnGap"/>
    <xsl:text> * (</xsl:text>
    <xsl:value-of select="$columnCount"/>
    <xsl:text> - 1))) div </xsl:text>
    <xsl:value-of select="$columnCount"/>
  </xsl:variable>

  <xsl:variable name="symbolLegendColumnCount" as="xs:integer">
    <xsl:choose>
      <xsl:when test="$multilingual eq 'no' or $language-count le 2">3</xsl:when>
      <xsl:when test="$language-count eq 3">2</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable><!-- symbolLegendColumnCount -->

  <xsl:variable name="symbolLegendColumnGap">
    <xsl:choose>
      <xsl:when test="$inputPageSize eq '140x182mm' and $symbolLegendColumnCount eq 2">
        <xsl:text>4.25mm</xsl:text>
      </xsl:when>
      <xsl:when test="$symbolLegendColumnCount eq 2">
        <xsl:text>0.5in</xsl:text>
      </xsl:when>
      <xsl:when test="$symbolLegendColumnCount eq 3">
        <xsl:text>.217in</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>0</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable><!-- symbolLegendColumnGap -->

  <xsl:variable name="page-margin-top">
    <xsl:choose>
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">0.375in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">9.5mm</xsl:when>
	  <!-- DHB add for 140x182mm page sizes -->
	  <xsl:when test="$inputPageSize eq '140x182mm'">9mm</xsl:when>
      <xsl:otherwise>0.375in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="page-margin-bottom">
    <xsl:choose>
	   <!-- DHB modified letter to 0.375 based on review by Ann and added 8mm margin for 140x182mm Page sizes-->
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">0.375in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">5.8mm</xsl:when>
	  <xsl:when test="$inputPageSize eq '140x182mm'">8mm</xsl:when>
      <xsl:otherwise>0.375in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="page-margin-inside">
    <xsl:choose>
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">0.375in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">9.5mm</xsl:when>
      <xsl:otherwise>0.375in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="page-margin-outside">
    <xsl:choose>
      <xsl:when test="lower-case($inputPageSize) eq 'letter'">0.375in</xsl:when>
      <xsl:when test="$inputPageSize eq 'A4'">9.5mm</xsl:when>
      <xsl:otherwise>0.375in</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="appendix-figure-padding-left">5pt</xsl:variable>
  <xsl:variable name="appendix-figure-padding-right">5pt</xsl:variable>
  <xsl:variable name="appendix-figure-padding-top">5pt</xsl:variable>
  <xsl:variable name="appendix-figure-padding-bottom">5pt</xsl:variable>

  <xsl:variable name="appendix-figure-frame-thickness">1pt</xsl:variable>

  <xsl:variable name="appendix-figure-max-width-expression">
    <xsl:value-of select="$page-width"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$page-margin-inside"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$page-margin-outside"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$appendix-figure-padding-left"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="$appendix-figure-padding-right"/>
  </xsl:variable>

  <xsl:variable name="appendix-figure-max-height-expression">
    <xsl:text>200pt</xsl:text>
  </xsl:variable>

  <xsl:param name="font-size-override">
    <xsl:call-template name="getMetadataValue.wd">
      <xsl:with-param name="document.id" select="$export-document-id"/>
      <xsl:with-param name="fieldname">FEDWARDSFONTSIZE</xsl:with-param>
      <xsl:with-param name="fieldlevel" select="'lng'"/>
      <xsl:with-param name="default" select="''"/>
    </xsl:call-template>
  </xsl:param>

  <xsl:variable name="default-font-size">
    <xsl:choose>
      <xsl:when test="$font-size-override='6pt'">6pt</xsl:when>
      <xsl:when test="$font-size-override='7pt'">7pt</xsl:when>
      <xsl:when test="$font-size-override='8pt'">8pt</xsl:when>
      <xsl:when test="$font-size-override='10pt'">10pt</xsl:when>
      <xsl:when test="$font-size-override='12pt'">12pt</xsl:when>
      <xsl:when test="$columnCount eq 1">12pt</xsl:when>
      <xsl:when test="$columnCount eq 2">10pt</xsl:when>
      <xsl:otherwise>7pt</xsl:otherwise>
    </xsl:choose>

  </xsl:variable><!-- default-font-size -->

  <xsl:variable name="default-line-height">
    <xsl:choose>
      <xsl:when test="$font-size-override='6pt'">7pt</xsl:when>
      <xsl:when test="$font-size-override='7pt'">9pt</xsl:when>
      <xsl:when test="$font-size-override='8pt'">10pt</xsl:when>
      <xsl:when test="$font-size-override='10pt'">12pt</xsl:when>
      <xsl:when test="$font-size-override='12pt'">14pt</xsl:when>
      <xsl:when test="$columnCount eq 1">14</xsl:when>
      <xsl:when test="$columnCount eq 2">12pt</xsl:when>
      <xsl:otherwise>9pt</xsl:otherwise>
    </xsl:choose>
  </xsl:variable><!-- default-line-height -->

  <xsl:param name="H1-scale">1.6</xsl:param>
  <xsl:param name="H2-scale">1.424</xsl:param>
  <xsl:param name="H3-scale">1.26</xsl:param>
  <xsl:param name="H4-scale">1.0</xsl:param>
  <xsl:param name="H5-scale">1</xsl:param>
  <xsl:param name="small-scale">.88</xsl:param>

</xsl:stylesheet>
