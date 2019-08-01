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


engine = create_engine('postgresql://ringer:2019_constantedeplanck@201.17.19.173:6432/ringerdb')
conn = engine.connect()

rs = conn.execute("select * from tasks where endtime is null")
for row in rs:
    fields = row

    jobid=fields[0]
    time=fields[3]
    sort=fields[7]

    conn.execute("update tasks set status = 'queued' where id = "+str(jobid))
    conn.execute("delete from classifiers where time = '"+str(time)+"' and sort = "+str(sort))
    conn.execute("delete from reconstruction_metrics where time = '"+str(time)+"' and sort = "+str(sort))

conn.close()
engine.dispose()
