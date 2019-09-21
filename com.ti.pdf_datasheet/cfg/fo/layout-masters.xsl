<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
  
  <xsl:template name="createLayoutMasters">
    <xsl:call-template name="createTILayoutMasters"/>
  </xsl:template>
  
  <xsl:template name="createTILayoutMasters">
    <fo:layout-master-set>

      <!--BODY simple masters-->
      <fo:simple-page-master master-name="body-first" xsl:use-attribute-sets="simple-page-master">
        <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
        <fo:region-before region-name="first-body-header" xsl:use-attribute-sets="region-before"/>
        <fo:region-after region-name="first-body-footer" xsl:use-attribute-sets="region-after"/>
      </fo:simple-page-master>

      <xsl:if test="$mirror-page-margins">
        <fo:simple-page-master master-name="body-even" xsl:use-attribute-sets="simple-page-master">
          <fo:region-body xsl:use-attribute-sets="region-body.even"/>
          <fo:region-before region-name="even-body-header" xsl:use-attribute-sets="region-before"/>
          <fo:region-after region-name="even-body-footer" xsl:use-attribute-sets="region-after"/>
        </fo:simple-page-master>
      </xsl:if>

      <fo:simple-page-master master-name="body-odd" xsl:use-attribute-sets="simple-page-master">
        <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
        <fo:region-before region-name="odd-body-header" xsl:use-attribute-sets="region-before"/>
        <fo:region-after region-name="odd-body-footer" xsl:use-attribute-sets="region-after"/>
      </fo:simple-page-master>

      <fo:simple-page-master master-name="body-last" xsl:use-attribute-sets="simple-page-master">
        <fo:region-body xsl:use-attribute-sets="region-body.even"/>
        <fo:region-before region-name="last-body-header" xsl:use-attribute-sets="region-before"/>
        <fo:region-after region-name="last-body-footer" xsl:use-attribute-sets="region-after"/>
      </fo:simple-page-master>

      <!-- blank pages -->
      <xsl:if test="$mirror-page-margins">
        <fo:simple-page-master master-name="blank-even" xsl:use-attribute-sets="simple-page-master">
          <fo:region-body region-name="blank-body"
            xsl:use-attribute-sets="region-blank.even"/>
          <fo:region-before region-name="even-body-header" xsl:use-attribute-sets="region-before"/>
          <fo:region-after region-name="even-body-footer" xsl:use-attribute-sets="region-after"/>
        </fo:simple-page-master>
      </xsl:if>

      <fo:simple-page-master master-name="blank-odd" xsl:use-attribute-sets="simple-page-master">
        <fo:region-body region-name="blank-body"
          xsl:use-attribute-sets="region-blank.odd"/>
        <fo:region-before region-name="odd-body-header" xsl:use-attribute-sets="region-before"/>
        <fo:region-after region-name="odd-body-footer" xsl:use-attribute-sets="region-after"/>
      </fo:simple-page-master>

      <fo:simple-page-master master-name="back-page-master"
        xsl:use-attribute-sets="simple-page-master">
        <fo:region-body region-name="back-page-body"
          xsl:use-attribute-sets="region-body.back-page"/>
        <fo:region-before region-name="even-body-header" xsl:use-attribute-sets="region-before"/>
        <fo:region-after region-name="even-body-footer" xsl:use-attribute-sets="region-after"/>
      </fo:simple-page-master><!-- back-page-master -->
        
      <!--Sequences-->
      <xsl:call-template name="generate-page-sequence-master">
        <xsl:with-param name="master-name" select="'body-sequence'"/>
        <xsl:with-param name="master-reference" select="'body'"/>
      </xsl:call-template>

      <xsl:call-template name="generate-page-sequence-master">
        <xsl:with-param name="master-name" select="'symbol-legend-sequence'"/>
        <xsl:with-param name="master-reference" select="'symbol-legend'"/>
      </xsl:call-template>

      <xsl:call-template name="generate-page-sequence-master">
        <xsl:with-param name="master-name" select="'figures-sequence'"/>
        <xsl:with-param name="master-reference" select="'figures'"/>
      </xsl:call-template>

    </fo:layout-master-set>
  </xsl:template><!-- name="createTILayoutMasters" -->
  
  <!-- Generate a page sequence master -->
  <xsl:template name="generate-page-sequence-master">
    <xsl:param name="master-name"/>
    <xsl:param name="master-reference"/>
    <xsl:param name="first" select="true()"/>
    <xsl:param name="last" select="true()"/>
    <fo:page-sequence-master master-name="{$master-name}">
      <fo:repeatable-page-master-alternatives>

        <xsl:choose>
          <xsl:when test="$mirror-page-margins">
            <fo:conditional-page-master-reference master-reference="blank-odd"
              odd-or-even="odd" blank-or-not-blank="blank"/>
            <fo:conditional-page-master-reference master-reference="blank-even"
              odd-or-even="even" blank-or-not-blank="blank"/>
          </xsl:when>
          <xsl:otherwise>
            <fo:conditional-page-master-reference master-reference="blank-odd" 
              blank-or-not-blank="blank"/>
          </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="$first">
          <fo:conditional-page-master-reference master-reference="{$master-reference}-first"
            odd-or-even="odd"
            page-position="first"/>
        </xsl:if>
        <xsl:if test="$last">
        <fo:conditional-page-master-reference master-reference="blank-even"
            odd-or-even="even"
            page-position="last"
            blank-or-not-blank="blank"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="$mirror-page-margins">
            <fo:conditional-page-master-reference master-reference="{$master-reference}-odd"
              odd-or-even="odd"/>
            <fo:conditional-page-master-reference master-reference="{$master-reference}-even"
              odd-or-even="even"/>
          </xsl:when>
          <xsl:otherwise>
            <fo:conditional-page-master-reference master-reference="{$master-reference}-odd"/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:repeatable-page-master-alternatives>
    </fo:page-sequence-master>
    
  </xsl:template><!-- name="generate-page-sequence-master" -->
  
</xsl:stylesheet>