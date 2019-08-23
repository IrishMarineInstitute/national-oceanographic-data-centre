<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco"
    xmlns:dcat="http://www.w3.org/ns/dcat#"
    xmlns:dct="http://purl.org/dc/terms/"
    xmlns:gl="http://schema.geolink.org/1.0/base/main#"
    xmlns:gml="http://www.opengis.net/gml"
    xmlns:gmx="http://www.isotc211.org/2005/gmx"
    xmlns:locn="http://www.w3.org/ns/locn#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:sdo="https://schema.org/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:time="http://www.w3.org/2006/time#"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs gmd gco gmx xlink"
    version="2.0">
    
    <!--<xsl:strip-space elements="*"/>-->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/gmd:MD_Metadata">
        <rdf:RDF>
            <xsl:apply-templates select="gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]"/>
            <xsl:apply-templates select="gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue">
        <xsl:if test=". = 'dataset'">
            <dcat:Dataset>
                <rdf:type rdf:resource="http://schema.geolink.org/1.0/base/main#Dataset" />
                <rdf:type rdf:resource="https://schema.org/Dataset" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString"/>
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:dateStamp/gco:Date" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox" />
                <xsl:apply-templates select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_BoundingPolygon" />
                <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword" >
                    <xsl:apply-templates select="gmx:Anchor"/>
                </xsl:for-each>
            </dcat:Dataset>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="/gmd:MD_Metadata/gmd:fileIdentifier/gco:CharacterString">
        <dct:identifier>
            <xsl:value-of select="(.)"/>
        </dct:identifier>
        <gl:hasIdentifier>
            <gl:Identifier rdf:about="#geolinkIdentifier">
                <gl:hasIdentifierValue>
                    <xsl:value-of select="(.)"/>
                </gl:hasIdentifierValue>
            </gl:Identifier>
        </gl:hasIdentifier>
        <sdo:identifier>
            <xsl:value-of select="(.)"/>
        </sdo:identifier>
    </xsl:template>
    
    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString">
        <dct:title>
            <xsl:value-of select="(.)"/>
        </dct:title>
        <sdo:name>
            <xsl:value-of select="(.)"/>
        </sdo:name>
    </xsl:template>
    
    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString">
        <dct:description>
            <xsl:value-of select="(.)"/>
        </dct:description>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:dateStamp/gco:Date">
        <dct:issued rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
            <xsl:value-of select="(.)" />
        </dct:issued>
    </xsl:template>

    <xsl:template match="gmx:Anchor">
        <dcat:theme>
            <skos:Concept>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="@xlink:href" />
                </xsl:attribute>
                <skos:prefLabel>
                    <xsl:value-of select="(.)"/>
                </skos:prefLabel>
                <skos:inScheme>
                    <xsl:attribute name="rdf:resource">
                        <xsl:value-of select="ancestor::gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href" />
                    </xsl:attribute>
                </skos:inScheme>
            </skos:Concept>
        </dcat:theme>
        <sdo:about>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="@xlink:href" />
            </xsl:attribute>
        </sdo:about>
    </xsl:template>
    
    <xsl:template match="gmd:identificationInfo[1]/gmd:MD_DataIdentification[1]/gmd:descriptiveKeywords[1]">
        <dcat:DataCatalog>
            <xsl:for-each select="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:descriptiveKeywords">
                <dcat:themeTaxonomy>
                    <skos:ConceptScheme>
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor/@xlink:href"/>
                        </xsl:attribute>
                        <skos:preflabel>
                            <xsl:value-of select="gmd:MD_Keywords/gmd:thesaurusName/gmd:CI_Citation/gmd:title/gmx:Anchor"/>
                        </skos:preflabel>
                    </skos:ConceptScheme>
                </dcat:themeTaxonomy>
            </xsl:for-each>
        </dcat:DataCatalog>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:temporalElement/gmd:EX_TemporalExtent/gmd:extent/gml:TimePeriod/gml:beginPosition">
        <dct:temporal>
            <dct:PeriodOfTime rdf:about="#temporalExtent">
                <rdf:type rdf:resource="http://www.w3.org/2006/time#Interval" />
                <time:hasBeginning>
                    <time:Instant rdf:about="#temporalBeginning">
                        <time:inXSDDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
                            <xsl:value-of select="(.)"/>
                        </time:inXSDDate>
                    </time:Instant>
                </time:hasBeginning>
            </dct:PeriodOfTime>
        </dct:temporal>
        <gl:hasStartDate rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
            <xsl:value-of select="(.)"/>
        </gl:hasStartDate>
        <sdo:temporalCoverage>
            <xsl:value-of select="(.)"/>
        </sdo:temporalCoverage>
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_GeographicBoundingBox">
        <dct:spatial>
            <dct:Location rdf:about="#boundingBox">
                <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#wktLiteral">
                    POLYGON((<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>,&#160;<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>,&#160;<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>,&#160;<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>&#160;,<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>))
                </locn:geometry>
            </dct:Location>
        </dct:spatial>
        <sdo:spatial>
            <sdo:Place rdf:about="#sdoBoundingBox">
                <sdo:geo>
                    <sdo:Geoshape rdf:about="#boundingBoxGeometry">
                        <sdo:polygon>
                            <xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:eastBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:southBoundLatitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:northBoundLatitude/gco:Decimal"/>&#160;<xsl:value-of select="gmd:westBoundLongitude/gco:Decimal"/>
                        </sdo:polygon>
                    </sdo:Geoshape>
                </sdo:geo>
            </sdo:Place>
        </sdo:spatial>            
    </xsl:template>

    <xsl:template match="/gmd:MD_Metadata/gmd:identificationInfo/gmd:MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_BoundingPolygon">
        <xsl:apply-templates select="gmd:polygon" />
    </xsl:template>
    
    <xsl:template match="gmd:polygon">
        <dct:spatial>
            <dct:Location rdf:about="#geographicFeature">
                <locn:geometry rdf:datatype="http://www.opengis.net/ont/geosparql#wktLiteral">
                    <xsl:apply-templates select="gml:Point" />
                    <xsl:apply-templates select="gml:LineString" />
                    <xsl:apply-templates select="gml:Polygon" />
                </locn:geometry>
            </dct:Location>
        </dct:spatial>    
    </xsl:template>
    
    <xsl:template match="gml:LineString">
        LINESTRING(<xsl:for-each select="gml:pos"><xsl:value-of select="(.)"/><xsl:if test="position() != last()">, </xsl:if></xsl:for-each>)
    </xsl:template>
    <xsl:template match="gml:Point">
        POINT(<xsl:for-each select="gml:pos"><xsl:value-of select="(.)"/><xsl:if test="position() != last()">, </xsl:if></xsl:for-each>)
    </xsl:template>
    <xsl:template match="gml:Polygon">
        POLYGON((<xsl:apply-templates select="gml:exterior/gml:LinearRine/gml:posList" />))
    </xsl:template>
    
    <xsl:template match="gml:exterior/gml:LinearRing/gml:posList">
        <xsl:call-template name="split">
            <xsl:with-param name="str" select="normalize-space(.)" />
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="split">
        <xsl:param name="str" />
        <xsl:choose>
            <xsl:when test="contains($str,' ')">
                <xsl:variable name="first">
                    <xsl:value-of select="format-number(number(substring-before($str,' ')),'00.000000')" />
                </xsl:variable>
                <xsl:variable name="second">
                    <xsl:value-of select="format-number(number(substring-before(substring-after(concat($str,' '),' '),' ')),'00.000000')" />
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
    
</xsl:stylesheet>