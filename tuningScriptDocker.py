# %load ../scripts/skeletons/time_test.py
#!/usr/bin/env python

# TODO Improve skeleton documentation

from timeit import default_timer as timer
from Gaugi.Configure import Development
Development.set( True )
import sqlalchemy
import psycopg2
import json
import pickle
import uuid
import os
import traceback
import datetime as dt
from urllib3.exceptions import MaxRetryError
import sys
from datetime import datetime, timedelta
from sqlalchemy import create_engine


engine = create_engine('postgresql://ringer:2019_constantedeplanck@201.17.19.173:80/ringerdb')
conn = engine.connect()
rs = conn.execute("update tasks set status='running' where id in ( select id from tasks where status='queued' order by id asc limit 1 for update ) returning id;")


jobid=None

for row in rs:
    jobid = row[0]

if jobid is None:
    print 'No tasks in the queue!'
    sys.exit(0)

hostname = os.environ['HOST']
conn.execute("update tasks set owner = '"+hostname+"' where id = "+str(jobid))

rs = conn.execute("select * from tasks where id = "+str(jobid))
for row in rs:
    fields = row

conn.close()
basepath='/home/caducovas/run/'


print fields

time=fields[3]
et= fields[8]
eta= fields[9]
preproc= fields[10]
conf= fields[11]
opPoint= fields[12]
fineTuning= fields[14]

print preproc
print time
conf= fields[11]

confFilename = basepath+str(uuid.uuid4())+'.pic'

with open(confFilename, 'wb') as handle:
    pickle.dump(conf, handle, protocol=pickle.HIGHEST_PROTOCOL)

start = timer()

DatasetLocationInput = '/volume/mc16a.zee.20M.jf17.20M.offline.binned.calo.wdatadrivenlh.npz'

#try:
#from Gaugi.Logger import Logger, LoggingLevel
#mainLogger = Logger.getModuleLogger(__name__)
#mainLogger.info("Entering main job.")

print 'Entering main job!'

try:
    from TuningTools.TuningJob import TuningJob
    tuningJob = TuningJob()

    from TuningTools.PreProc import *
    import ast

    preprocList=[]
    preprocStringList = ast.literal_eval(preproc)
    for string in preprocStringList:
        preprocList.append(eval(string))


    tuningJob( DatasetLocationInput,
               #euronBoundsCol = [10, 10],
               #sortBoundsCol = [0, 1],
               #initBoundsCol = 5,
               confFileList = confFilename,
               #ppFileList = basepath+'run/ppFile_preproc.pic',
               crossValidFile = basepath+'crossValid_SAE_jackknife.pic',
               etBins = [et, et],
               etaBins = [eta, eta],
               operationPoint = str(opPoint),
               #coreConf = 'keras',
               #epochs = 100,
               #showEvo = 0,
               #algorithmName= 'rprop',
               #doMultiStop = True,
               #doPerf = True,
               #maxFail = 100,
               #seed = 0,
               ppCol = PreProcChain( preprocList ) ,
               scheduleTime = time,
               crossValidSeed = 66 )
               #level = LoggingLevel.DEBUG )

    #mainLogger.info("Finished.")

    end = timer()

    os.remove(confFilename)



    #conn = engine.connect()
    #conn.execute("update tasks set elapsed = %s where id = "+str(jobid), (dt.timedelta(seconds=(end - start))))
    #conn.execute("update tasks set status = 'finished' where id = "+str(jobid))
    #conn.execute("update tasks set endtime = %s where id = "+str(jobid), (datetime.now() - timedelta(hours=3)))
    print 'execution time is: ', (end - start)


except MaxRetryError as e:
    conn = engine.connect()
    conn.execute("update tasks set status = 'queued' where id = "+str(jobid))
    os.remove(confFilename)
    print("type error: " + str(e))
    print(traceback.format_exc())

conn.close()
