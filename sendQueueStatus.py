
import sqlalchemy
import psycopg2
import json
from urllib3.exceptions import MaxRetryError
import sys
from datetime import datetime, timedelta
from sqlalchemy import create_engine
from prettytable import PrettyTable
import telepot

bot = telepot.Bot('578139897:AAEJBs9F21TojbPoXM8SIJtHrckaBLZWkpo')

engine = create_engine('postgresql://ringer:2019_constantedeplanck@201.17.19.173:6432/ringerdb')
conn = engine.connect()
x = PrettyTable()
x.field_names = ["Status", "nJobs"]

rs = conn.execute("select status,count(*) from tasks where context = 'official' group by status")
for r in rs:
     x.add_row([r[0],str(r[1])])

rs = conn.execute("select max(endtime) from tasks")
for r in rs:
    fields=r

lastEndTime = fields[0]

conn.close()
engine.dispose()

bot.sendMessage('@ringer_tuning','Last Job was finished at '+str(lastEndTime)+'\n'+x.get_string())
