<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                xmlns:lib="https://www.ana-escobar.com/library/">
  <xsl:output method="xml" indent="yes"/>
    <!-- We want to identify our active members by their loyalty depending on their joined date. 
      If the member joined before 01-01-2016 the loyalty is 'premium', otherwise the loyalty is 'basic' 
      Output: (name, lastname, birthdate, email, joined date, loyalty) -->
    <xsl:template match="/">
      <xsl:element name = "members">
        <xsl:apply-templates select="//lib:member[lib:memberStatus='active']"></xsl:apply-templates>  <!-- Select acive members -->
      </xsl:element>
    </xsl:template>

  <xsl:template match="lib:member">  <!-- For each member element -->
    <xsl:element name = "member">
      <xsl:variable name="joined" select="lib:joinedDate"/>
      <xsl:variable name="date" select="'2016-01-01'"/>
      <!-- create attribute -->
      <xsl:attribute name = "id"><xsl:value-of select = "@id"/></xsl:attribute>
      <xsl:element name = "firstname"><xsl:apply-templates select = "lib:memberFirstName"/> </xsl:element>
      <xsl:element name = "lastname"><xsl:apply-templates select = "lib:memberLastName"/> </xsl:element>
      <xsl:element name = "email"><xsl:apply-templates select = "lib:email"/> </xsl:element>
      <xsl:element name = "birthdate"><xsl:apply-templates select = "lib:birthDate"/> </xsl:element>
      <xsl:element name = "joineddate"><xsl:apply-templates select = "lib:joinedDate"/> </xsl:element>
      <xsl:choose>
        <xsl:when test="number(translate($joined, '-', '')) &lt; number(translate($date, '-', ''))">  <!-- Compare two dates -->
          <xsl:element name = "loyalty">premium</xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name = "loyalty">basic</xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
 </xsl:template>

</xsl:stylesheet>