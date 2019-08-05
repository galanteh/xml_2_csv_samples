<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="UTF-8" />
  <xsl:variable name="delimiter" select="'|'" />
  <xsl:variable name="newline" select="'&#10;'" />

    <xsl:template match="/">
        <xsl:text>mts|neun|moid|mt|value</xsl:text>
        <xsl:value-of select="$newline" />
        <xsl:for-each select="///mv/moid">
            <!-- mts-->
            <xsl:variable name="mts" select="../../../mi/mts" />
            <!-- neid_neun-->
            <xsl:variable name="neid_neun" select="../../../neid/neun" />
            <!-- moid-->
            <xsl:variable name="moid" select="." />

            <xsl:for-each select="../../mt">
              <xsl:value-of select="$mts" />
              <xsl:value-of select="$delimiter" />
              <xsl:value-of select="$neid_neun" />
              <xsl:value-of select="$delimiter" />
              <xsl:value-of select="$moid" />
              <xsl:value-of select="$delimiter" />
              <!-- type-->
              <xsl:value-of select="." />
              <xsl:value-of select="$delimiter" />
              <!-- value-->
              <xsl:value-of select="../mv/r" />
              <xsl:value-of select="$newline" />
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
