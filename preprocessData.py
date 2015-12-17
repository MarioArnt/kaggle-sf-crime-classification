import numpy as np
import pandas as pd
import sklearn as sk
import re
import pickle

Data=pd.read_csv("datasets/train.csv", header =0)
Data['Dates']=pd.to_datetime(Data['Dates'])
a=np.zeros([len(Data),1])
for i in range(len(Data)):
    a[i]=Data['Dates'][i].hour

Data['Hours']=pd.DataFrame(a)

DateMin=pd.Series.min(Data['Dates'])
Data['Dates']=Data['Dates']-DateMin
Data['Dates']=Data['Dates'][:].astype('timedelta64[D]').astype(int)/91

dofDummies = pd.get_dummies(Data['DayOfWeek'])
pdDummies =  pd.get_dummies(Data['PdDistrict'])


dataCorner=np.zeros([len(Data),1])
for i in range(len(Data)):
    if (re.findall(' / ', Data['Address'][i])):
        dataCorner[i]=1
    else:
        dataCorner[i]=0
Data['Corner']=pd.DataFrame(dataCorner)

sK = []
for i in range(len(Data)):
    if (re.findall(' [A-Z]{2} /', Data['Address'][i])):
        sK.append(re.findall(' ([A-Z]{2}) /', Data['Address'][i])[0])
    if (re.findall(' [A-Z]{2}$', Data['Address'][i])):
        sK.append(re.findall(' ([A-Z]{2})$', Data['Address'][i])[0])
sK=list(set(sK))

for j in range(len(sK)):
    buff = np.zeros([len(Data),1])
    pattern1 = ' '+sK[j]+'$'
    pattern2 = ' '+sK[j]+' /'
    for i in range(len(Data)):
        if (re.findall(pattern1, Data['Address'][i])  or re.findall(pattern2, Data['Address'][i])):
            buff[i]=1
        else:
            buff[i]=0
    Data[sK[j]]=pd.DataFrame(buff)


pickle.dump(Data, open( "dataSemi.p", "wb" ) )
