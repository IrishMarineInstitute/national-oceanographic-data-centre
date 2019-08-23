<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gml="http://www.opengis.net/gml"
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs gmd gco gml gmx xlink"
    version="2.0">
    
    <!--<xsl:strip-space elements="*"/>-->
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/gmd:MD_Metadata">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <title><xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" /> | Marine Institute Data Catalogue</title>
                <link rel="stylesheet" href="../css/nodc.css" />
                <link rel="stylesheet" href="../css/leaflet.css" />
                <link href="https://fonts.googleapis.com/css?family=Roboto&#38;display=swap" rel="stylesheet" />
                <script src="../js/leaflet.js"></script>
                <script type="application/json+ld">
                    <xsl:value-of select="//gmd:RS_Identifier[gmd:codeSpace/gco:CharacterString/text()='https://schema.org']/gmd:code/gco:CharacterString" />
                </script>
                <script>
                    var thisGeoJsonFeature = {
                            "type": "Feature",
                            "properties": {
                                "name": ""
                            },
                            "geometry":
                            {<xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_BoundingPolygon/gmd:polygon" />}};
                </script>
            </head>
            <body>
                <div id="header" class="header">
                    <div id="headerLeft" class="headerLeft">
                        <div id="logo" class="logo"><img src="../img/marine-logo.png" class="header-img-logo" alt="Marine Instittue Logo"/></div>
                        <div id="ie_marine_data" class="catalogueName">Marine Institute Data Catalogue</div>
                    </div>
                    <div id="headerRight" class="headerRight">
                        <span class="menu-item"><i class="material-icons" alt="Search">search</i></span><span class="menu-item"><i class="material-icons" alt="About">info</i></span>
                    </div>
                </div>
                <div id="map" class="map">
                </div>
                <script src="../js/nodcLeafletMapFunctions.js"></script>
                <div id="container" class="container">
                    <div id="title">
                        <h1>
                            <xsl:apply-templates select="/gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>&#160;<xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />
                        </h1>
                    </div>
                    <div id="abstract">
                        <p>
                            <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString" />
                        </p>
                    </div>
                    <div id="contents">
                        <ul>
                            <li><a href="#general-information">General Information</a></li>
                            <li><a href="#parameters">Parameters</a></li>
                            <li><a href="#categories">Categories</a></li>
                            <li><a href="#metadata">Metadata</a></li>
                        </ul>
                    </div>
                    <div id="general-information">
                        <h2>General Information</h2>
                        <div id="timePeriod" class="blockRow">
                            <div class="blockLabel"><i class="material-icons" alt="Time period">date_range</i></div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div id="parameters">
                        <h2>Parameters</h2>
                        <div id="discipline" class="blockRow">
                            <div class="blockLabel">Discipline</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords[gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://vocab.nerc.ac.uk/collection/P08/current/']/gmd:keyword/gmx:Anchor">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                        <div id="parameterGroups"  class="blockRow">
                            <div class="blockLabel">Parameter Groups</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords[gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://vocab.nerc.ac.uk/collection/P03/current/']/gmd:keyword/gmx:Anchor">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                        <div id="discovery" class="blockRow">
                            <div class="blockLabel">Parameter Discovery Terms</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords[gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://vocab.nerc.ac.uk/collection/P02/current/']/gmd:keyword/gmx:Anchor">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                        <div id="usage" class="blockRow">
                            <div class="blockLabel">Parameter Usage Terms</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords[gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://vocab.nerc.ac.uk/collection/P01/current/']/gmd:keyword/gmx:Anchor">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div id="categories">
                        <h2>Categories</h2>
                        <div id="isoCategories" class="blockRow">
                            <div class="blockLabel">ISO Topic Categories</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:topicCategory/gmd:MD_TopicCategoryCode">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each> 
                            </div>
                        </div>
                        <div id="inspireThemes" class="blockRow">
                            <div class="blockLabel">INSPIRE Themes</div>
                            <div class="blockValue">
                                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords[gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href='http://www.eionet.europa.eu/gemet/inspire_themes']/gmd:keyword/gmx:Anchor">
                                    <xsl:value-of select="(.)"/><br />
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div id="metadata">
                        <h2>Metadata</h2>
                        <div id="resourceIdentifier" class="blockRow">
                            <div class="blockLabel">Resource identifier</div>
                            <div class="blockValue">
                                <xsl:value-of select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
                            </div>
                        </div>
                        <div id="lastModified" class="blockRow">
                            <div class="blockLabel">Last modified</div>
                            <div class="blockValue">
                                <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision']/gmd:date/gco:Date"/>
                            </div>
                        </div>
                        <div id="firstPublished" class="blockRow">
                            <div class="blockLabel">First published</div>
                            <div class="blockValue">
                                <xsl:value-of select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='publication']/gmd:date/gco:Date"/>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div id="footer" class="footer">
                    <div id="footer-logo-left" class="footer-logo-left">
                        <img src="../img/emff_logo.png" class="footer_img_emff_logo" alt="European Maritime and Fisheries Fund logo" />
                    </div>
                    <div id="footer-text" class="footer-text">
                        Development of this catalogue has been funded through the European Maritime and Fisheries Fund and the Marine Institute's Digital Ocean Programme. &#169; Copyright Marine Institute.
                    </div>
                    <div id="footer-logo-right" class="footer-logo-right">
                        <img src="../img/IDO_LogoLight.png" class="footer_img_ido_logo" alt="Ireland's Digital Ocean logo" />
                    </div>
                </div>
            </body>    
        </html>
    </xsl:template>
    
    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_BoundingPolygon/gmd:polygon">
        <xsl:apply-templates select="gml:Point" />
        <xsl:apply-templates select="gml:LineString" />
        <xsl:apply-templates select="gml:Polygon" />  
    </xsl:template>
    
    <xsl:template match="gml:Point">
        "type:"Point","coordinates": <xsl:for-each select="gml:pos"><xsl:call-template name="split"><xsl:with-param name="str" select="normalize-space(.)" /></xsl:call-template></xsl:for-each>
    </xsl:template>
    
    <xsl:template match="gml:LineString">
        "type":"LineString", "coordinates": [<xsl:for-each select="gml:pos"><xsl:call-template name="split"><xsl:with-param name="str" select="normalize-space(.)" /></xsl:call-template><xsl:if test="position() != last()">, </xsl:if></xsl:for-each>]
    </xsl:template>
       
    <xsl:template name="split">
        <xsl:param name="str" />
        <xsl:choose>
            <xsl:when test="contains($str,' ')">
                <xsl:variable name="first">
                    <xsl:value-of select="substring-before($str,' ')" />
                </xsl:variable>
                <xsl:variable name="second">
                    <xsl:value-of select="substring-before(substring-after(concat($str,' '),' '),' ')" />
                </xsl:variable>
                <xsl:value-of select="concat('[',$first,',',$second,']')" />
                
                <xsl:if test="substring-after(substring-after($str,' '),' ')">
                    <xsl:text>, </xsl:text>
                    <xsl:call-template name="split">
                        <xsl:with-param name="str">
                            <xsl:value-of select="substring-after(substring-after($str,' '),' ')"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="/gmd:MD_Metadata/gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue">
        <xsl:if test=".='dataset'"><i class="material-icons">storage</i></xsl:if>
    </xsl:template>
    
</xsl:stylesheet>