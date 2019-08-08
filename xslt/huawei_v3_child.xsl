<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:template match="/">
    <output>
        <xsl:for-each select="xml/value">
            <xsl:call-template name="tokenize">
                <xsl:with-param name="beginTime" select="beginTime"/>
                <xsl:with-param name="measInfoId" select="measInfoId"/>
                <xsl:with-param name="measObjLdn" select="measObjLdn"/>
                <xsl:with-param name="text_type" select="measTypes"/>
                <xsl:with-param name="delimiter" select="' '"/>
            	<xsl:with-param name="text" select="measValues"/>
    		</xsl:call-template>
        </xsl:for-each>
    </output>
</xsl:template>

<xsl:template name="tokenize">
    <xsl:param name = "beginTime"/>
    <xsl:param name = "measInfoId"/>
    <xsl:param name = "measObjLdn"/>
    <xsl:param name="text_type"/>
    <xsl:param name="text"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
        <xsl:when test="contains($text, $delimiter) and contains(substring-after($text, $delimiter), $delimiter)">
            <xsl:value-of select="$beginTime"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="$measInfoId"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="$measObjLdn"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="substring-before($text_type, $delimiter)"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="substring-before($text, $delimiter)"/>
            <xsl:text>&#xa;</xsl:text>
            <!-- recursive call -->
            <xsl:call-template name="tokenize">
                <xsl:with-param name="beginTime" select="$beginTime"/>
                <xsl:with-param name="measInfoId" select="$measInfoId"/>
                <xsl:with-param name="measObjLdn" select="$measObjLdn"/>
                <xsl:with-param name="text_type" select="substring-after($text_type, $delimiter)"/>
                <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
                <xsl:with-param name="delimiter" select="' '"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$beginTime"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="$measInfoId"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="$measObjLdn"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="substring-before($text_type, $delimiter)"/>
            <xsl:text> | </xsl:text>
            <xsl:value-of select="substring-before($text, $delimiter)"/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>
