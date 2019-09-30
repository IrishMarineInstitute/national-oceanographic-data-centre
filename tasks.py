from invoke import task     # type: ignore
import os
import io
import xml.etree.ElementTree
import flask
from typing import Dict, List
import py.isoHandler        # type: ignore

app = flask.Flask('flaskInInvoke')


def enum() -> Dict[str, str]:
    return {'baseUrl':
            'https://irishmarineinstitute.github.io/' +
            'national-oceanographic-data-centre/'}


def getXmlNamespaces() -> Dict[str, str]:
    return {'gmd': 'http://www.isotc211.org/2005/gmd',
            'gco': 'http://www.isotc211.org/2005/gco',
            'gmx': 'http://www.isotc211.org/2005/gmx'}


def getNewFileName(oldFileName: str, switch: str) -> str:
    if switch == "dataset":
        obj = py.isoHandler.isoRecord(  oldFileName, getXmlNamespaces())
    return obj.identifierToFileName()

@task
def rename(c, dataset=False, sensor=False):
    if dataset:
        for f in (os.listdir("./iso-xml")):
            if(getNewFileName("./iso-xml/" + f, 'dataset') is None):
                raise Exception('No metadata identifier found... File {}'.
                                format(f))
            else:
                os.rename("./iso-xml/" + f,
                          "./iso-xml/" + getNewFileName("./iso-xml/" +
                                                        f, 'dataset') + ".xml")


@task
def applytransforms(c, dataset=False, sensor=False):
    if dataset:
        for f in (os.listdir("./iso-xml")):
            obj = py.isoHandler.isoRecord('./iso-xml/' + f, getXmlNamespaces())
            with app.app_context():
                renderedRdf: str = flask.render_template('iso2rdf.ttl',data=obj)
                renderedHtml: str = flask.render_template('iso2html.html',data=obj)
            with io.open('./rdf/' + obj.identifierToFileName() + '.ttl', 'w+', encoding="utf-8") as rdfOut:
                rdfOut.write(renderedRdf)
            with io.open('./html/' + obj.identifierToFileName() + '.html', 'w+', encoding="utf-8") as htmlOut:
                htmlOut.write(renderedHtml)
            
@task
def buildsitemap(c):
    Enum: Dict[str, str] = enum()
    urls: List[Dict[str, str]] = []
    for f in (os.listdir("./html")):
        with open('./html/'+f, 'r') as content_file:
            content: str = content_file.read()
        content = content[content.find('div id="lastModified"'):]
        content = content[content.find('div class="blockValue"'):]
        content = content[content.find('>') + 1:]
        content = content[:content.find('<')]
        urls.append({'url': 'html/' + f, 'lastModified': content})
    with app.app_context():
        rendered: str = flask.render_template('sitemap.xml',
                                              Enum=Enum, urls=urls)
    with open('sitemap.xml', 'w+') as sitemap:
        sitemap.write(rendered)


@task
def typesafe(c):
    c.run("mypy tasks.py")
