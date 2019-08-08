<xsl:stylesheet version="1.0" xmlns:me="http://latest/nmc-omc/cmNrm.doc#measCollec" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xslFormatting="urn:xslFormatting" exclude-result-prefixes="xslFormatting me xsi">
    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:variable name="beginTime" select="//*[local-name()='measCollec']/@beginTime"/>

    <xsl:template match="me:measCollecFile">
        <xsl:apply-templates select="me:measData"/>
    </xsl:template>

    <xsl:template match="me:measData">
      <xsl:for-each select="me:measInfo">
        <xsl:apply-templates select=".">
          <xsl:with-param name="measInfoId" select = "@measInfoId" />
          <xsl:with-param name="measTypes" select = "me:measTypes" />
        </xsl:apply-templates>
      </xsl:for-each>
    </xsl:template>

    <xsl:template match="me:measInfo">
      <xsl:param name = "measInfoId" />
      <xsl:param name = "measTypes" />

      <xsl:for-each select="me:measValue">
        <xsl:apply-templates select=".">
          <xsl:with-param name="measInfoId" select = "$measInfoId" />
          <xsl:with-param name="measTypes" select = "$measTypes" />
          <xsl:with-param name="measObjLdn" select = "@measObjLdn" />
        </xsl:apply-templates>
      </xsl:for-each>
    </xsl:template>

    <xsl:template match="me:measValue">
      <xsl:param name = "measInfoId" />
      <xsl:param name = "measTypes" />
      <xsl:param name = "measObjLdn" />

      <xsl:apply-templates select="me:measResults">
        <xsl:with-param name="measInfoId" select = "$measInfoId" />
        <xsl:with-param name="measTypes" select = "$measTypes" />
        <xsl:with-param name="measObjLdn" select = "$measObjLdn" />
      </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="me:measResults">
      <xsl:param name = "measInfoId" />
      <xsl:param name = "measTypes" />
      <xsl:param name = "measObjLdn" />

      <xsl:call-template name="tokenize">
        <xsl:with-param name="measInfoId" select = "$measInfoId" />
        <xsl:with-param name="measTypes" select = "$measTypes" />
        <xsl:with-param name="measObjLdn" select = "$measObjLdn" />
        <xsl:with-param name="text_type"><xsl:value-of select="$measTypes"/></xsl:with-param>
        <xsl:with-param name="text"><xsl:value-of select="."/></xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template name="tokenize">
        <xsl:param name = "measInfoId" />
        <xsl:param name = "measTypes" />
        <xsl:param name = "measObjLdn" />
        <xsl:param name="text_type"/>
        <xsl:param name="text"/>
        <xsl:param name="delimiter" select="' '"/>
        <xsl:choose>
            <xsl:when test="contains($text, $delimiter) and contains(substring-after($text, $delimiter), $delimiter)">
                <xsl:value-of select="$beginTime"/><xsl:text> | </xsl:text>
                <xsl:value-of select="$measInfoId"/><xsl:text> | </xsl:text>
                <xsl:value-of select="$measObjLdn" /><xsl:text> | </xsl:text>
                <xsl:value-of select="substring-before($text_type, $delimiter)"/><xsl:text> | </xsl:text>
                <xsl:value-of select="substring-before($text, $delimiter)"/>
                <xsl:text>&#xa;</xsl:text>
                <!-- recursive call -->
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="measInfoId" select = "$measInfoId" />
                    <xsl:with-param name="measTypes" select = "$measTypes" />
                    <xsl:with-param name="measObjLdn" select = "$measObjLdn" />
                    <xsl:with-param name="text_type" select="substring-after($text_type, $delimiter)"/>
                    <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$beginTime"/><xsl:text> | </xsl:text>
                <xsl:value-of select="$measInfoId"/><xsl:text> | </xsl:text>
                <xsl:value-of select="$measObjLdn" /><xsl:text> | </xsl:text>
                <xsl:value-of select="substring-before($text_type, $delimiter)"/><xsl:text> | </xsl:text>
                <xsl:value-of select="substring-before($text, $delimiter)"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
