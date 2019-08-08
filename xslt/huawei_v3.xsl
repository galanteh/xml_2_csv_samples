<xsl:stylesheet version="1.0" xmlns:me="http://latest/nmc-omc/cmNrm.doc#measCollec" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xslFormatting="urn:xslFormatting" exclude-result-prefixes="xslFormatting me xsi">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="beginTime" select="//*[local-name()='measCollec']/@beginTime"/>

    <xsl:template match="me:measCollecFile">
        <xsl:apply-templates select="me:measData"/>
    </xsl:template>

    <xsl:template match="me:measData">
      <xml>
      <xsl:for-each select="me:measInfo">
        <xsl:apply-templates select=".">
          <xsl:with-param name="measInfoId" select = "@measInfoId" />
          <xsl:with-param name="measTypes" select = "me:measTypes" />
        </xsl:apply-templates>
      </xsl:for-each>
      </xml>
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
      <value>
        <beginTime>
          <xsl:value-of select="$beginTime"/>
        </beginTime>
        <measInfoId>
          <xsl:value-of select="$measInfoId"/>
        </measInfoId>
        <measObjLdn>
          <xsl:value-of select="$measObjLdn" />
        </measObjLdn>
        <measTypes>
          <xsl:value-of select="$measTypes"/>
        </measTypes>
        <measValues>
          <xsl:value-of select="."/>
        </measValues>
      </value>
      <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
