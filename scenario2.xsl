<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                xmlns:lib="https://www.ana-escobar.com/library/">
    <xsl:output method="html" encoding="UTF-8" />
    <!-- A table showing the active members out of the total number of members, their name, lastname and joined date -->

    <xsl:template match="/">
		<html>
            <blockquote>
                <head> <title>List of active members</title> </head>
                <body>
                    <h2>List of <xsl:value-of select="count(//lib:member[lib:memberStatus='active'])"/> active members from a total of <xsl:value-of select="count(//lib:member)"/> members</h2>
                    <table border="1">  <!-- Create a table as a result -->
                        <tr bgcolor="#49a26c">
                            <th align="left">Lastname</th>
                            <th align="left">Name</th>
                            <th align="left">Joined Date</th>
                        </tr>
                        <xsl:apply-templates select="//lib:member[lib:memberStatus='active']">  <!-- Only active members -->
                            <xsl:sort select="lib:memberLastName"/>  <!-- Order result by lastname -->
                        </xsl:apply-templates>
                    </table>
                </body>
            </blockquote>
		</html>
	</xsl:template>

    <xsl:template match="lib:member">  <!-- For each member element -->
		<html>
            <tr>
                <td><xsl:value-of select="lib:memberLastName"/></td>
                <td><xsl:value-of select="lib:memberFirstName"/></td>
                <td><xsl:value-of select="lib:joinedDate"/></td>
            </tr>
        </html>
    </xsl:template>

</xsl:stylesheet>