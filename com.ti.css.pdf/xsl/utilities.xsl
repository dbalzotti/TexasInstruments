<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
    exclude-result-prefixes="#all">

    <!-- Function-ish to process data elements in topicmeta element -->
    <xsl:template name="intralox_get-data-value">
        <xsl:param name="field-name-min-str"/>
        <xsl:param name="html-element" select='div'/>
        <xsl:param name="default-value" select="''"/>
        
        <xsl:variable name="data-node" 
            select="(//topicmeta/data[@name = $field-name-min-str])[1]"/>
        <xsl:choose>
            <xsl:when test="count($data-node)=0">
                <xsl:value-of select="$default-value"/>
            </xsl:when>
            <!-- If there are multiple children <data> elements, put a <> around them -->
            <xsl:when test="count($data-node/data) > 0">
                <xsl:element name="{$html-element}">
                    <xsl:variable name="data-count" select="count($data-node/data)"/>
                    <xsl:for-each select="$data-node/data">
                        <p>
                            <xsl:apply-templates/>
                        </p>                    
                    </xsl:for-each>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="{$html-element}">
                    <xsl:attribute name="class">
                        <xsl:value-of select="$field-name-min-str"/>
                    </xsl:attribute>
                    <xsl:value-of select="$data-node"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>