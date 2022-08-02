from pandas import DataFrame
import pandas as pd
import shutil

ontologyfile = r'C:\Users\martingi\OneDrive - Lewis University\Research\NSF_ERI_2021\work\ontology\ClassActivityTTL.owl'
mockdatacsv = r'C:\Users\martingi\OneDrive - Lewis University\Research\NSF_ERI_2021\work\data\mockdata.csv'
rdfdatattl = r'C:\Users\martingi\OneDrive - Lewis University\Research\NSF_ERI_2021\work\data\mockdata.ttl'
#copy ontology file
shutil.copyfile(ontologyfile, rdfdatattl)

rdfdata=pd.read_csv(mockdatacsv)

#get first 3 columns into dataframe
RDFDF=DataFrame(rdfdata, columns=['SUBJECT','PREDICATE','OBJECT'])
#drop empty rows
RDFDF.dropna(subset=['SUBJECT'], inplace=True)
#remove trailing newline characters
RDFDF = RDFDF.replace(r'\n',' ', regex=True) 
#identify rows that start with # 
rows2delete=RDFDF.SUBJECT.str.startswith('#')
RDFDF.drop(RDFDF[rows2delete].index, inplace=True)
RDFDF['SUFFIX']='.'

with open(rdfdatattl, 'a') as f:
    dfAsString = RDFDF.to_string(header=False, index=False)
    f.write(dfAsString)










