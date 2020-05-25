import os

from ie.marine.data.dataCentre.contentTypes import Dataset
from ie.marine.data.dataCentre.static import XmlNamespaces

def getNewFileName(oldFileName, mode):
    if mode == "dataset":
        obj = Dataset.Dataset(  oldFileName, XmlNamespaces.getXmlNamespaces())
    return obj.identifierToFileName()

def Rename(mode):
    if(mode == 'dataset'):
        for f in (os.listdir("./iso-xml")):
            if(getNewFileName("./iso-xml/" + f, 'dataset') is None):
                raise Exception('No metadata identifier found... File {}'.
                            format(f))
            else:
                os.rename("./iso-xml/" + f,
                          "./iso-xml/" + getNewFileName("./iso-xml/" +
                                                        f, 'dataset') + ".xml")