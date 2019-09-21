<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">

  <xsl:param name="debug-page-regions">false</xsl:param>

  <xsl:attribute-set name="region-body.odd">
    <xsl:attribute name="column-count">
      <xsl:value-of select="$columnCount"/>
    </xsl:attribute>
    <xsl:attribute name="column-gap">
      <xsl:value-of select="$columnGap"/>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$page-margin-inside"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$page-margin-outside"/>
    </xsl:attribute>
    <xsl:attribute name="axf:column-fill">balance</xsl:attribute>
    <xsl:attribute name="background-color">
      <xsl:choose>
        <xsl:when test="contains(string($debug-page-regions),'true')">#E0FFE0</xsl:when>
        <xsl:otherwise>transparent</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-body.even">
    <xsl:attribute name="column-count">
      <xsl:value-of select="$columnCount"/>
    </xsl:attribute>		
    <xsl:attribute name="column-gap">
      <xsl:value-of select="$columnGap"/>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$page-margin-outside"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$page-margin-inside"/>
    </xsl:attribute>
    <xsl:attribute name="axf:column-fill">balance</xsl:attribute>
    <xsl:attribute name="background-color">
      <xsl:choose>
        <xsl:when test="contains(string($debug-page-regions),'true')">#E0FFE0</xsl:when>
        <xsl:otherwise>transparent</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-body.back-page">
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$page-margin-outside"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$page-margin-inside"/>
    </xsl:attribute>
    <xsl:attribute name="display-align">after</xsl:attribute>
    <xsl:attribute name="background-color">
      <xsl:choose>
        <xsl:when test="contains(string($debug-page-regions),'true')">#E0FFE0</xsl:when>
        <xsl:otherwise>transparent</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="region-blank.odd">
    <xsl:attribute name="display-align">center</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-blank.even" use-attribute-sets="region-blank.odd">
  </xsl:attribute-set>

</xsl:stylesheet>