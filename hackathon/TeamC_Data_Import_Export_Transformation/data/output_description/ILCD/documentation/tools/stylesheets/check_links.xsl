<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:saxon="http://saxon.sf.net/" xmlns:common="http://lca.jrc.it/ILCD/Common">

  <xsl:import href="../../stylesheets/common.xsl"/>

  <xsl:param name="localOnly" select="'false'"/>
  <xsl:param name="checkReferences" select="'true'"/>
  <xsl:param name="checkPermanentDataSetURI" select="'false'"/>
  

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="*">
    <xsl:apply-templates select="@*|node()"/>
  </xsl:template>

  <xsl:template match="@*"/>

  <xsl:template match="text()"/>


  <xsl:template match="common:permanentDataSetURI">
    <xsl:if test="$checkPermanentDataSetURI='true'">
      <xsl:call-template name="check"/>
    </xsl:if>
  </xsl:template>


  <xsl:template match="@uri">
    <xsl:if test="$checkReferences='true'">
      <xsl:call-template name="check"/>
    </xsl:if>
  </xsl:template>


  <xsl:template name="check">
    <xsl:variable name="xmlFile" select="ends-with(lower-case(.), '.xml')"/>
    <xsl:variable name="uri" select="normalize-space(translate(., '\\', '/'))"/>

    <xsl:if test="not($localOnly='true' and starts-with(lower-case($uri), 'http:'))">
      <xsl:choose>
        <xsl:when test="$xmlFile">
          <xsl:if test="not(doc-available(resolve-uri($uri, document-uri(/))))">
            <xsl:call-template name="complain"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="string(saxon:file-last-modified(resolve-uri($uri, document-uri(/))))=''">
            <xsl:call-template name="complain"/>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <xsl:template name="complain">
    <xsl:call-template name="warn">
      <xsl:with-param name="message">Could not open referenced document '<xsl:value-of select="."/>' on <xsl:value-of select="name(parent::*)"/></xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
