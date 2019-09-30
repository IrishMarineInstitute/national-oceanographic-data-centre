import xml.etree.ElementTree
from typing import Dict, List

class isoRecord:
    def __init__(self, file:str = None, namespaces:Dict[str, str] = None):
        if file is not None:
            if namespaces is None:
                raise valueError('isoHandler: namespaces must be defined in order to read an ISO XML file...')
            else:
                e = xml.etree.ElementTree.parse(file).getroot()
                self.identifier: str = str(e.findall('./gmd:fileIdentifier/gco:CharacterString',
                            namespaces)[0].text)
                self.title: str = str(e.findall('./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString',
                            namespaces)[0].text)
                self.abstract: str = str(e.findall('./gmd:identificationInfo/gmd:MD_DataIdentification/gmd:abstract/gco:CharacterString',
                            namespaces)[0].text)
                self.dateIssued: str = str(e.findall('./gmd:dateStamp/gco:Date',namespaces)[0].text)
                for a in e.iter('{http://www.isotc211.org/2005/gmx}Anchor'):
                    print(a.text + "    " + a.attrib['{http://www.w3.org/1999/xlink}href'])
                
    def identifierToFileName(self) -> str:
        return str.replace(str.replace(self.identifier, '.', '_'), ':', '__')
