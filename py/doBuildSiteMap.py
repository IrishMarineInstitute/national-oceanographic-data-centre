import sys
from ie.marine.data.dataCentre.tasks.BuildSiteMap import BuildSiteMap

if __name__ == "__main__":
    directory = sys.argv[1]
    template = sys.argv[2]
    baseUrl = sys.argv[3]
    BuildSiteMap(directory,template,baseUrl)
