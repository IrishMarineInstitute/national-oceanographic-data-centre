# To Do

This page describes known issues and actions to complete for the Irish National Marine Data Centre repository. Please check this document prior to raising a GitHub issue.

## GitHub
- Add license
- Website up badge from shields.io
- Build passing badge when Travis integration set up

## RDF Export
- Complete the DCAT mapping
- Schema.org
  - variableMeasured from P01
  - measurementTechnique from L22
- Geolink
  - hasMeasurementType from P02 and P03
  - isDatasetOf from C17
    - hasPlatformType from L06

## DataCite XML export
	
## HTML export
- Complete HTML export
- Add Google Analytics
- Investigate generating the Schema.org JSON-LD on the fly
- Minify and concatenate the CSS and JS files
- Investigate font hosting to remove CDN dependency
- Add related resource titles
- Set the nodcLeafletMapFunctions.js script to be an autorun function
- Fix GeoJSON export issues

## HTML home page
- Add a search function

## HTML pages
- About
- Services
- Generic header,footer for iFraming / injecting via CSS/JS
- Submission standards and guidelines

## Build process
- ~~Rename metadata files~~
- Build HTML and RDF from ISO XML
- Generate a sitemap