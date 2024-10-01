import numpy as np
import math
import pandas as pd
def get_chemicals_list(filename):
    chemicals = pd.read_csv(filename)
    chemicals_list = list(chemicals[' symbol'].str.strip())
    return chemicals_list
chem_list=get_chemicals_list("chemical_elements.csv")
def parse_chemical_name(name,chem_list):
    temp = ''
    stoi = []
    chem = []

    def cf(m):
        ls = []
        for sf in m:
            if sf.isupper():
                m = m.replace(sf," {}".format(sf))
        return m
    a = list(cf(name).split())

    for ele in a:
        if len(ele) == 1:
            stoi.append(1)
        elif ele[1].isdigit():
            stoi.append(float(ele[1:]))
        elif len(ele) > 2:
            stoi.append(float(ele[2:]))
        else:
            stoi.append(1)

        chem.append(''.join(i for i in ele if not (i.isdigit() or i ==".")))
    return chem, stoi

def check_artifacts_name(name, chem_list):
    if '(' and ')' in name:
        return filter_name(name, chem_list)
    else:
        return name

def filter_name(name, chem_list):
    output = ''
    temp = ''
    mult = 1
    i = 0
    j = 0
    count = 0
    k = 0
    for char in name:
        if char == '(':
            i = count
        if char == ')':
            j = count
            if j < len(name) - 1:
                if name[j+1].isdigit():
                    mult = name[j+1]
                    k = j + 1
        count += 1

    output = name[:i] + name[k+1:]

    temp = name[i+1:j]

    fix, stoi = parse_chemical_name(temp, chem_list)

    for el in fix:
        if int(mult) > 1:
            output += el + mult
        else:
            output += el

    return output


resList={}
for i in chem_list:
    resList[i]=[]
def elemental_composition(name):

    composition = np.zeros((len(chem_list), 1))
    name = check_artifacts_name(name, chem_list)
    ele, stoi = parse_chemical_name(name, chem_list)

    for i in range(len(chem_list)):
        for j in range(len(ele)):
            if chem_list[i] == ele[j]:
                composition[i, 0] = stoi[j]
 
    composition = composition/(np.sum(composition))
    weights = stoi/(np.sum(stoi))

    return composition, ele, stoi
MainDir=r'C:\Users\Sir\OneDrive\Univeristy\HEA Analysis\4K06\Code\Data Folder\Original Data Collected'
filePath=MainDir+r'\TrainDt_300_Extended.csv'
df1=pd.read_csv(filePath,index_col="ID")
res=[]
comps=df1['Comp'].values
for comp in comps:
    composition, ele, stoi=elemental_composition(comp)
    res.append(composition.reshape(-1))
res=pd.DataFrame(res,columns=chem_list)
pd.concat([df1,res],axis=1).to_csv(r'C:\Users\Sir\OneDrive\Univeristy\HEA Analysis\4K06\Code\Data Folder\Processed 0922\AutoCompCal.csv')
