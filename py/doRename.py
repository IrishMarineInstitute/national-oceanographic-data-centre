import sys
from ie.marine.data.dataCentre.tasks.Rename import Rename

if __name__ == '__main__':
    mode = sys.argv[1].lower()
    Rename(mode)
