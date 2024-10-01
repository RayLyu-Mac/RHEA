import numpy as np
import math
import pandas as pd
import os
def get_chemicals_list(filename):
    chemicals = pd.read_csv(filename)
    chemicals_list = list(chemicals[' symbol'].str.strip())
    return chemicals_list
script_dir = os.path.dirname(os.path.realpath(__file__))
chemListDir=csv_file_path = os.path.join(script_dir, 'chemical_elements.csv')
chem_list=get_chemicals_list(chemListDir)
print(chem_list)
