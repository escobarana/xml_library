<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet version="1.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                xmlns:lib="https://www.ana-escobar.com/library/">
    <xsl:output method="html" encoding="UTF-8" />
    <!-- Members who have not returned a book yet and the borrowed date of the book, with the identifier of the book borrowed.
    Table ordered by member lastname, alphabetically. -->
    <xsl:template match="/">
		<html>
            <blockquote>
                <head> <title>List of members who have not returned a book</title> </head>
                <body>
                    <h2>List of members who have not returned a book</h2>
                    <table border="1">  <!-- Create a table -->
                        <tr bgcolor="#49a26c">
                            <th align="left">Member Lastname</th>
                            <th align="left">Member Name</th>
                            <th align="left">Borrowed date</th>
                            <th align="left">Book title</th>
                            <th align="left">Book ISBN 10</th>
                        </tr>
                        
                        <xsl:apply-templates select="//lib:member[lib:memberStatus='active']">  <!-- Select active members -->
                            <xsl:sort select="lib:memberLastName"/>  <!-- Order by member's lastname -->
                        </xsl:apply-templates>

                    </table>
                </body>
            </blockquote>
		</html>
	</xsl:template>

    <xsl:template match="lib:member">  <!-- For each member element -->
        <xsl:variable name="name" select="lib:memberFirstName"/>
        <xsl:variable name="lastname" select="lib:memberLastName"/>
        <xsl:for-each select="lib:borrowedBooks/lib:borrowedBook">  <!-- Select the borrowed books of the member -->
            <xsl:if test="not(@returnedDate)">  <!-- Returns a boolean value depending if this attribute exists or not -->
                <xsl:variable name="bookId" select="@bookId"/>  <!-- If the attribute doesn't exist then we select the id of the book -->

                <tr>  <!-- Fill the table -->
                    <td><xsl:value-of select="$lastname"/></td>
                    <td><xsl:value-of select="$name"/></td>
                    <td><xsl:value-of select="@borrowDate"/></td>
                    <td><xsl:value-of select="//lib:book[@id=$bookId]/lib:title"/></td>  <!-- Select the title of the book matching the previous id -->
                    <td><xsl:value-of select="//lib:book[@id=$bookId]/lib:isbn"/></td>   <!-- Select the ISBN of the book matching the previous id -->
                </tr>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>