<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gml="http://www.opengis.net/gml"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    exclude-result-prefixes="xs gmd gco"
    version="2.0">
    
    <xsl:strip-space elements="*"/>
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/gmd:MD_Metadata">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <script type="application/json+ld">
                    <xsl:value-of select="//gmd:RS_Identifier[gmd:codeSpace/gco:CharacterString/text()='https://schema.org']/gmd:code/gco:CharacterString" />
                </script>
            </head>
            <body>
                <div id="map">
                    
                </div>
                <div id="title">
                    <h1>
                        <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />
                    </h1>
                </div>
                <div id="abstract">
                    <p>
                        <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString" />
                    </p>
                </div>
                <div id="metadata">
                    <h2>Metadata</h2>
                    <div id="resourceIdentifier">
                        <span>Resource identifier</span>
                        <span>
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
                        </span>
                    </div>
                </div>
            </body>    
        </html>
    </xsl:template>
    
</xsl:stylesheet>