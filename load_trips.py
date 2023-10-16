import psycopg2 as psql
import pandas as pd
import numpy as np

import sqlalchemy as sql


df = pd.read_csv('trips.csv')

conn_string = 'postgresql://user:password@localhost:5432/awto'
db = sql.create_engine(conn_string)
conn = db.connect()
connection = db.raw_connection()
cursor = connection.cursor()


df1 = df[["user_id","rut_user","name_user"]]
df_user = df1.drop_duplicates()
try:
    df_user.to_sql('users', con=conn, if_exists='append', index=False)
except:
    print("Existen datos duplicados")

df2 = df[["vehicle_id"]]
df_veh = df2.drop_duplicates()
try:
    df_veh.to_sql('vehicles', con=conn, if_exists='append', index=False)
except:
    print("Existen datos duplicados")

df_trip = df[["trip_id","user_id","vehicle_id","booking_time","start_time","end_time","status_id","travel_dist","price_amount","price_tax","price_total","start_lat","start_lon","end_lat","end_lon"]]
try:
    df_trip.to_sql('trips', con=conn, if_exists='append', index=False)
except:
    print("Existen datos duplicados")

