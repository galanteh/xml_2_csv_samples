<xsl:stylesheet version="1.0" xmlns:me="http://latest/nmc-omc/cmNrm.doc#measCollec" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xslFormatting="urn:xslFormatting">
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

      <xsl:value-of select="$beginTime"/><xsl:text> | </xsl:text>
      <xsl:value-of select="$measInfoId"/><xsl:text> | </xsl:text>
      <xsl:value-of select="$measObjLdn" /><xsl:text> | </xsl:text>
      <xsl:value-of select="$measTypes" /><xsl:text> | </xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
