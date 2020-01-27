from jinja2 import Template
import urllib3
import xmltodict

urlPrefix = "http://data.marine.ie/geonetwork/srv/eng/catalog.search#/metadata/"

jinjaTemplate = Template(u"""<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    {% for url in datasets %}
        {% set urlSuffix = url.loc.split('/') %}
        <url>
            <loc>{{ urlPrefix }}{{ urlSuffix[-1] }}</loc>
            <lastmod>{{ url.lastmod }}Z</lastmod>
        </url>
    {% endfor %}
</urlset>
""")

http = urllib3.PoolManager()
response = http.request('GET',
                'http://data.marine.ie/geonetwork/srv/eng/portal.sitemap')
dataset = xmltodict.parse(response.data)['urlset']['url']

print(jinjaTemplate.render(urlPrefix = urlPrefix,
                           datasets = dataset))
