<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                xmlns:lib="https://www.ana-escobar.com/library/">
    <xsl:output method="html" encoding="UTF-8" />
    <!-- Books sorted by publication year (from most recent to latest), the title is in bold and the 
        publication year in italic and grey color. The author(s) of the book must also appear for each book. 
        The books available only for consulting will appear in red color.
        The header of the page is in color blue. -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Title and publication year of books available in the library.
                </title>
            </head>
            <body>
                <h1><span style="color:#0000FF">Here the list of the <xsl:value-of select="count(//lib:book)" /> books and its corresponding author(s)</span></h1>
                <h3>(In red color, those books that can only be consulted and not borrowed.)</h3>
                <blockquote>
                    <xsl:apply-templates select="//lib:book">  <!-- Select book element -->
                        <xsl:sort select="lib:publicationYear" order="descending" />  <!-- Order by descending order of publication year -->
                    </xsl:apply-templates>
                </blockquote>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="lib:book">  <!-- For each book element -->
        <p>
            <strong>
                <xsl:choose>
                    <xsl:when test="lib:type='consult'">
                        <span style="color:#FF0000"><xsl:value-of select="lib:title"/></span>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="lib:title"/>
                    </xsl:otherwise>
                </xsl:choose>
            </strong>
            <em>
                <span style="color:#808080">
                    <xsl:text> ( </xsl:text>
                    <xsl:value-of select="lib:publicationYear"/>
                    <xsl:text> ) </xsl:text>
                </span>
            </em>
            <xsl:apply-templates select="lib:authors/lib:bookauthor"/>  <!-- Apply template for each author(s) of the books -->
        </p>
    </xsl:template>

    <xsl:template match="lib:bookauthor">  <!-- Handle matching key - keyref -->
        <xsl:variable name="authorId" select="@authorId"/>  <!-- Store in a variable the value of the authorId -->
        <xsl:apply-templates select="//lib:author[@id=$authorId]"/>  <!-- Select author element based on the variale created -->
    </xsl:template>

    <xsl:template match="lib:author">  <!-- For each author element -->
        <p>
            <blockquote>
                <xsl:value-of select="lib:authorLastName"/><xsl:text>, </xsl:text><xsl:value-of select="lib:authorFirstName"/>
            </blockquote>
        </p>
    </xsl:template>

</xsl:stylesheet>