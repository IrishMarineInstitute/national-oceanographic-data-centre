from invoke import task
import os
import xml.etree.ElementTree

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
                raise Exception('No metadata identifier found... File {}'.format(f))
            else:
                os.rename("./iso-xml/" + f,
                          "./iso-xml/" + getNewFileName("./iso-xml/" +
                                                        f,'dataset') + ".xml")
        
    
