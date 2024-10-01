import numpy as np
import math
import pandas as pd
def get_chemicals_list(filename):
    chemicals = pd.read_csv(filename)
    chemicals_list = list(chemicals[' symbol'].str.strip())
    return chemicals_list
chem_list=get_chemicals_list("chemical_elements.csv")
print(chem_list)