all: rename buildSiteMap

buildSiteMap:
# buildSiteMap.py will take three inputs:
#	1. The directory of the HTML files to be parsed
#	2. The location of the template to be read
#	3. The base URL of the website
	python ./py/doBuildSiteMap.py ./html ./templates/sitemap.xml https://irishmarineinstitute.github.io/national-oceanographic-data-centre/

rename:
#rename.py will take one input argument:
#	1. The content type to be renamed ('dataset', 'device')
	python ./py/doRename.py dataset