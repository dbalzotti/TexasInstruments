<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg">

	<!-- Common functions -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text"/>
		<xsl:param name="replace"/>
		<xsl:param name="by"/>
		<xsl:choose>
			<xsl:when test="contains($text,$replace)">
				<xsl:value-of select="substring-before($text,$replace)"/>
				<xsl:value-of select="$by"/>
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)"/>
					<xsl:with-param name="replace" select="$replace"/>
					<xsl:with-param name="by" select="$by"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Special rendering for the object element -->
	<xsl:template match="*[contains(@class,' topic/object ')]" name="topic.object">		
		<xsl:choose>
			<!-- Detect if it is an SDL Media Manager movie -->
			<xsl:when test="contains(@data, 'sdlmedia.com')">
				<div>
					<xsl:if test="$TRANSTYPE='ishditadelivery' and @ishcondition">
						<xsl:copy-of select="@ishcondition"/>
					</xsl:if>				
					<xsl:if test="@data">
						<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
						<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
						<xsl:variable name="originalDataValue">
							<xsl:value-of select="translate(@data, $uppercase, $smallcase)" />
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="$TRANSTYPE='ishwebhelp' or $TRANSTYPE='ishditadelivery'">
								<!-- Show the video -->
								<xsl:variable name="dataValue">
									<xsl:call-template name="string-replace-all">
										<xsl:with-param name="text">
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$originalDataValue" />
												<xsl:with-param name="replace" select="'distribution/?o'" />
												<xsl:with-param name="by" select="'distribution/embed/?o'" />
											</xsl:call-template>
										</xsl:with-param>
										<xsl:with-param name="replace" select="'distributions/?o'" />
										<xsl:with-param name="by" select="'distributions/embed/?o'" />
									</xsl:call-template>
								</xsl:variable>
								<xsl:element name="script">
									<xsl:attribute name="type">text/javascript</xsl:attribute>
									<xsl:attribute name="language">javascript</xsl:attribute>
									<xsl:attribute name="src">
										<xsl:value-of select="$dataValue" />
									</xsl:attribute>
									<xsl:text> </xsl:text>
								</xsl:element>
								<xsl:variable name="mmID" select="substring-after($dataValue,'o=')"/>
								<xsl:element name="div">
									<xsl:attribute name="id">
										<xsl:choose>
											<xsl:when test="contains($mmID,'&amp;')">
												<xsl:value-of select="substring-before($mmID,'&amp;')" />							
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="$mmID" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
									<xsl:text> </xsl:text>
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- Show an image placeholder -->
								<xsl:variable name="dataValue">
									<xsl:call-template name="string-replace-all">
										<xsl:with-param name="text">
											<xsl:call-template name="string-replace-all">
												<xsl:with-param name="text" select="$originalDataValue" />
												<xsl:with-param name="replace" select="'distribution/?o'" />
												<xsl:with-param name="by" select="'distribution/?f'" />
											</xsl:call-template>
										</xsl:with-param>
										<xsl:with-param name="replace" select="'distributions/?o'" />
										<xsl:with-param name="by" select="'distributions/?f'" />
									</xsl:call-template>
								</xsl:variable>
								<xsl:element name="img">
									<xsl:attribute name="src">
										<xsl:value-of select="concat($dataValue,'&amp;ext=.jpg')" />
									</xsl:attribute>
								</xsl:element>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
				</div>
			</xsl:when>
			<xsl:when test="contains(@type,'flash')">
				<xsl:element name="object">
					<xsl:if test="@id">
						<xsl:attribute name="id">
							<xsl:value-of select="@id" />
						</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="type">
						<xsl:text>application/x-shockwave-flash</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="width">
						<xsl:choose>
							<xsl:when test="@width">
								<xsl:value-of select="@width" />
							</xsl:when>
							<xsl:otherwise>300</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="height">
						<xsl:choose>
							<xsl:when test="@height">
								<xsl:value-of select="@height" />
							</xsl:when>
							<xsl:otherwise>300</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="data">
						<xsl:value-of select="@data" />
					</xsl:attribute>
				</xsl:element>				
			</xsl:when>
			<xsl:otherwise>
				<iframe>
					<xsl:copy-of select="@id | @declare | @codebase | @type | @archive | @height | @usemap | @tabindex | @classid | @codetype | @standby | @width | @name"/>
					<xsl:if test="@data">
						<xsl:attribute name="src">
							<xsl:choose>
								<xsl:when test="contains(@data,'youtube.com/v/')">
									<xsl:value-of select="replace(@data, 'youtube.com/v/', 'youtube.com/embed/')" />							
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="@data" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</xsl:if>
					<xsl:if test="$TRANSTYPE='ishditadelivery' and @ishcondition">
						<xsl:copy-of select="@ishcondition"/>
					</xsl:if>
					<xsl:if test="@longdescref or *[contains(@class, ' topic/longdescref ')]">
						<xsl:apply-templates select="." mode="ditamsg:longdescref-on-object"/>
					</xsl:if>
					<xsl:apply-templates/>
				</iframe>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>