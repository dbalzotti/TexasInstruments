<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
    exclude-result-prefixes="#all">

	<xsl:import href="plugin:rocks.xml.pdf.css.page:xslt/dita2pdf-css-page-import.xsl"/>
	<xsl:import href="utilities.xsl"/>
	<xsl:import href="infoshare.dita2htm.diff.xsl"/>
    <xsl:include href="infoshare.jobticket.xsl"/>	

	<xsl:variable name="generate-toc" select="true()"/>
	
     <xsl:param name="input.dir.url"/>
	<!-- infoshare metadata -->
	
	<xsl:variable name="lower-case">abcdefghijklmnopqrstuvwxyz"</xsl:variable>
	<xsl:variable name="upper-case">ABCDEFGHIJKLMNOPQRSTUVWXYZ"</xsl:variable>
	<xsl:variable name="jobTicketLngValue">
	  	<xsl:call-template name="getJobTicketParam">
		  	<xsl:with-param name="varname">language</xsl:with-param>
		  	<xsl:with-param name="default"></xsl:with-param>
	  	</xsl:call-template>	
	</xsl:variable>	
	<xsl:variable name="output.lang">
		<xsl:value-of select="translate($jobTicketLngValue, $lower-case, $upper-case)"/>
	</xsl:variable>

	
    <!-- Override the template in dita2htmlImpl.xsl and add custom metadata -->
    <xsl:template match="/|node()|@*" mode="gen-user-head">
        <xsl:message>Using override header.</xsl:message>
        <!-- Link the CSS file -->
		<!--xsl:choose>
			<xsl:when test="contains($ilox.pagesize, 'Press')"-->
				<link rel="stylesheet" type="text/css" href="ti_datasheet_style.css" />
			<!--/xsl:when>
			<xsl:otherwise/>

		</xsl:choose-->        
     
	</xsl:template>
	
	
    <xsl:template name="create-book-title">
	

    </xsl:template>	
	
  <xsl:template match="*[contains(@class, ' topic/topic ')][contains(@outputclass, 'first-page-topic')]"/>

  <xsl:template match="*[contains(@class, ' topic/fn ')]">
    <span>
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
	
      <xsl:template match="*" mode="addContentToHtmlBodyElement">
        <main role="main">
            <article role="article">
                <xsl:attribute name="aria-labelledby">
                    <xsl:apply-templates select="*[contains(@class,' topic/title ')] |
                                       self::dita/*[1]/*[contains(@class,' topic/title ')]" mode="return-aria-label-id"/>
                </xsl:attribute>
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-startprop ')]" mode="out-of-line"/>

                <xsl:apply-templates select="opentopic:map"/>

                <div id="body-content">
                    <xsl:apply-templates select="* except opentopic:map"/>
                </div>

                <!-- this will include all things within topic; therefore, -->
                <!-- title content will appear here by fall-through -->
                <!-- followed by prolog (but no fall-through is permitted for it) -->
                <!-- followed by body content, again by fall-through in document order -->
                <!-- followed by related links -->
                <!-- followed by child topics by fall-through -->
                <!--xsl:call-template name="gen-endnotes"/-->    <!-- include footnote-endnotes -->
                <xsl:apply-templates select="*[contains(@class, ' ditaot-d/ditaval-endprop ')]" mode="out-of-line"/>
            </article>
        </main>
    </xsl:template>
	
    <xsl:template match="*" mode="chapterBody">
        <body>
            <xsl:apply-templates select="." mode="addAttributesToHtmlBodyElement"/>
            <xsl:if test="contains(@class, ' map/map ')">
                <xsl:call-template name="create-book-title"/>
            </xsl:if>
            <xsl:call-template name="setaname"/>  <!-- For HTML4 compatibility, if needed -->
            <xsl:value-of select="$newline"/>
            <xsl:apply-templates select="." mode="addHeaderToHtmlBodyElement"/>

            <!-- Include a user's XSL call here to generate a toc based on what's a child of topic -->
            <!--xsl:call-template name="gen-user-sidetoc"/-->

            <xsl:apply-templates select="." mode="addContentToHtmlBodyElement"/>
            <xsl:apply-templates select="." mode="addFooterToHtmlBodyElement"/>
        </body>
        <xsl:value-of select="$newline"/>
    </xsl:template>
	
    	
	
	<!-- ============================================================== -->
   <xsl:template name="getMetadataValue">
      <xsl:param name="fieldname" />
      <xsl:param name="fieldlevel" />
      <xsl:param name="default" />
      <xsl:choose>
         <xsl:when test="document($pubMetfile,/)//ishfield[@name=$fieldname and @level=$fieldlevel]">
            <xsl:value-of select="document($pubMetfile,/)//ishfield[@name=$fieldname and @level=$fieldlevel]"/>
         </xsl:when>
		 <xsl:otherwise>
            <xsl:value-of select="$default"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   

</xsl:stylesheet>
