from invoke import task
import os
import xml.etree.ElementTree
import flask

app = flask.Flask('flaskInInvoke')

def enum():
    return {'baseUrl':
            'https://irishmarineinstitute.github.io/national-oceanographic-data-centre/'}

def getXmlNamespaces():
    return {'gmd': 'http://www.isotc211.org/2005/gmd',
            'gco': 'http://www.isotc211.org/2005/gco'}

def getNewFileName(oldFileName,switch):
    e = xml.etree.ElementTree.parse(oldFileName).getroot()
    if switch == "dataset":
        for p in e.findall('./gmd:fileIdentifier/gco:CharacterString',
                       getXmlNamespaces()):
            return str.replace(str.replace(p.text,'.','_'),':','__')

@task
def rename(c, dataset=False, sensor=False):
    if dataset:
        for f in (os.listdir("./iso-xml")):
            if(getNewFileName("./iso-xml/" + f,'dataset') == None):
                raise Exception('No metadata identifier found... File {}'.
                                format(f))
            else:
                os.rename("./iso-xml/" + f,
                          "./iso-xml/" + getNewFileName("./iso-xml/" +
                                                        f,'dataset') + ".xml")

@task
def applytransforms(c, dataset = False, sensor=False):
    if dataset:
        for f in (os.listdir("./iso-xml")):
            print("Applying transformation to HTML...")
            print("Applying transformation to RDF...")

@task
def buildsitemap(c):
    Enum = enum()
    urls = []
    for f in (os.listdir("./html")):
        with open('./html/'+f, 'r') as content_file:
            content = content_file.read()
        content = content[content.find('div id="lastModified"'):]
        content = content[content.find('div class="blockValue"'):]
        content = content[content.find('>') + 1:]
        content = content[:content.find('<')]
        urls.append({'url': 'html/' + f, 'lastModified': content})
    with app.app_context():
        rendered = flask.render_template('sitemap.xml',Enum = Enum, urls=urls)
    with open('sitemap.xml', 'w+') as sitemap:
        sitemap.write(rendered)

    
