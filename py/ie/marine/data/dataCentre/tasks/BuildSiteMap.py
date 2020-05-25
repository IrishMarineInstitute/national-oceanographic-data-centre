import chevron
import datetime
import os

def BuildSiteMap(directory, template, baseUrl):
    urls =  []
    webDirectory = directory
    if(webDirectory[0] == '.'):
        webDirectory = webDirectory[1:]
    for f in (os.listdir(directory)):
        with open(directory+'/'+f, 'r', encoding='utf-8') as content_file:
            content: str = content_file.read()
        content = content[content.find('div id="lastModified"'):]
        content = content[content.find('div class="blockValue"'):]
        content = content[content.find('>') + 1:]
        content = content[:content.find('<')]
        if not content:
            content = datetime.datetime.now().replace(microsecond=0).isoformat()
        urls.append({'url': baseUrl + webDirectory + '/' + f, 'lastModified': content})

    with open(template, 'r') as templateFile:
        rendered = chevron.render(templateFile,
                                  {'baseUrl': baseUrl,
                                   'urlset':urls})

    with open('sitemap.xml', 'w+') as sitemap:
        sitemap.write(rendered)


    
