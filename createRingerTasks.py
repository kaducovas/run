import os
import subprocess
import shlex
from datetime import datetime
import time
import pickle
from sqlalchemy import create_engine
import shutil
import json


engine = create_engine('postgresql://ringer:2019_constantedeplanck@201.17.19.173:80/ringerdb')
conn = engine.connect()
basedir='/home/caducovas/run/'

timeNow = datetime.now()
#comecou=time.time()
insertTime=str(timeNow).split('.')[0].replace('-','').replace(' ','').replace(':','')

if not os.path.exists(basedir+'/jobs/'):
    os.makedirs(basedir+'/jobs/')

#there' a syntax difference between both. did not figure out yet how to translate automatically
preproc = "[Norm1()]"
#ppfile =  "[Norm1()]"
dimension = 100
model = 'MLP'

inits = 1
etbinidx = 1
etabinidx = 1
hl_neuron = 7

context = 'teste'

fine_tuning = 'no'
operationPoint = 'Offline_LH_VeryLoose'

datetime = timeNow
time = insertTime

owner = None
status = 'queued'
elapsed =  None


#for etBin
#for etabin
#for dim
#DO NOT FORGET for each for sleep 1 and receive a new time

os.system(basedir+"createPreprocTask.sh %s %d %d" % (basedir+'/jobs/', inits, hl_neuron))
#os.system(basedir+"createPreprocTask.sh %s %d %d '%s'" % (basedir+'/jobs/', inits, hl_neuron, ppfile))

jobFiles = os.listdir(basedir+'/jobs/')
for jobFile in jobFiles:
    sort = int(jobFile.split('.')[2][-1])
    file = open(basedir+'/jobs/'+jobFile)
    conf = pickle.load(file)
    print conf
    conn.execute('INSERT INTO tasks (context, datetime, time , model, hl_neuron, inits,sort, etbinidx ,etabinidx, preproc, conf, operationPoint, dimension, fine_tuning, status) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)', (context, datetime, time , model, hl_neuron, inits,sort, etbinidx ,etabinidx, preproc, json.dumps(conf), operationPoint, dimension, fine_tuning, status))



#os.rmdir(basedir+'/jobs/')
shutil.rmtree(basedir+'/jobs/')

#context text COLLATE pg_catalog."default",
#datetime timestamp without time zone,
#time text COLLATE pg_catalog."default",
#model text COLLATE pg_catalog."default",
#hl_neuron integer,
#inits integer
#sort integer,
#etbinidx integer,
#etabinidx integer,
#preproc text,
#conf JSONB,
#operationPoint text,
#dimension integer,
#fine_tuning text COLLATE pg_catalog."default",
#owner text,
#status text,
#elapsed time without time zone,

###Create tuning job files preproc format
#ppCol "[Norm1(), PCA({'energy' : 30})]"
#StackedAutoEncoder({'hidden_neurons' : [60], 'aetype' : 'contractive'})]"
#PCA({'energy' : 66})]"
#,NLPCA(level = self.level, nlpcs=47, nmapping=71)] ))
#,PCA(level = self.level, energy = 70)] )) #,
#StackedAutoEncoder({'hidden_neurons' : [60], 'aetype' : 'contractive'})] )) #,
#StackedAutoEncoder(level=self.level,hidden_neurons=[30],aetype='vanilla')] )) #, SAE_FineTuning()] ))
#StackedAutoEncoder(level = self.level,hidden_neurons=[50], aetype='vanilla'),
#StackedAutoEncoder(level = self.level,hidden_neurons=[40], aetype='vanilla'),
#StackedAutoEncoder(level = self.level,hidden_neurons=[30], aetype='vanilla'),
#StackedAutoEncoder(level = self.level,hidden_neurons=[20], aetype='vanilla'),



#@@context, datetime, time , model, hl_neuron, inits, etbinidx ,etabinidx, preproc, conf, operationPoint, dimension, fine_tuning, status
#@@(%s,%s,%s,%s,%d,%d,%d,%d,%s,%s,%s,%d,%s,%s)
