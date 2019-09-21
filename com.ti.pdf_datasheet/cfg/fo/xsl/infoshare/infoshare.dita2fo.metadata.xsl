<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions" version="1.1">

	<!-- ============================================================== -->
   <xsl:template name="getMetadataValue">
      <xsl:param name="document.id" />
      <xsl:param name="fieldname" />
      <xsl:param name="fieldlevel" />
      <xsl:param name="default" />
      <xsl:choose>
         <xsl:when test="document(concat('file:///',$WORKDIR, '/', $document.id, $ext.metadata),/)//ishfield[@name=$fieldname and @level=$fieldlevel]">
            <xsl:value-of select="document(concat('file:///',$WORKDIR, '/', $document.id, $ext.metadata),/)//ishfield[@name=$fieldname and @level=$fieldlevel]"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$default"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
      <!-- ============================================================== -->
</xsl:stylesheet>
