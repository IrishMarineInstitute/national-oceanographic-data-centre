import xml.etree.ElementTree

class Dataset:
    def __init__(self, file = None, namespaces = None):
        if file is not None:
            if namespaces is None:
                raise ValueError('isoHandler: namespaces must be defined in order to read an ISO XML file...')
            else:
                e = xml.etree.ElementTree.parse(file).getroot()
                self.identifier = str(e.findall('./gmd:fileIdentifier/gco:CharacterString',
                            namespaces)[0].text)
                self.title = str(e.findall('./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString',
                            namespaces)[0].text)
                self.abstract = str(e.findall('./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString',
                            namespaces)[0].text)
                self.dateIssued = str(e.findall('./gmd:dateStamp/gco:Date',namespaces)[0].text)
                for a in e.iter('{http://www.isotc211.org/2005/gmx}Anchor'):
                    print(a.text + "    " + a.attrib['{http://www.w3.org/1999/xlink}href'])
    
    def getAbstract(self):
        return self.abstract
    
    def getDateIssued(self):
        return self.dateIssued
    
    def getIdentifier(self):
        return self.identifier
    
    def getTitle(self):
        return self.title
    
    def identifierToFileName(self):
        return str.replace(str.replace(self.identifier, '.', '_'), ':', '__')