<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:lib="https://www.ana-escobar.com/library/">
    <xsl:output method="text" encoding="UTF-8" />
    <!-- MEASURE MEMBER ENGAGEMENT: Member (firstname, lastname, status) and how many books they've borrowed in total, 
      resultset ordered from highest number of borrowed books to lowest -->

    <xsl:template match="/">
      <!-- CONVERT INPUT TO XML FOR JSON -->
      <xsl:variable name="xml">
        <array>
            <xsl:for-each select="//lib:member">  <!-- For each member element -->
            <xsl:sort select="count(lib:borrowedBooks/lib:borrowedBook)" order="descending" />  <!-- Order result by descending order of number of books borrowed -->
            <map>
                <string key="firstname">
                    <xsl:value-of select="lib:memberFirstName"/>
                </string>
                <string key="lastname">
                    <xsl:value-of select="lib:memberLastName"/>
                </string>
                <string key="status">
                  <xsl:value-of select="lib:memberStatus"/>
              </string>
              <string key="nbBorrowedBooks">
                <xsl:value-of select="count(lib:borrowedBooks/lib:borrowedBook)"/>
              </string>
            </map>
        </xsl:for-each>
        </array>
      </xsl:variable>
      <!-- OUTPUT -->
      <xsl:value-of select="xml-to-json($xml)"/>
    </xsl:template>

</xsl:stylesheet>