from movieDV_project import settings
import mysql.connector

def getDatabaseConnection():
    db_config = settings.DATABASES['default']
    host = db_config['HOST']
    user = db_config['USER']
    password = db_config['PASSWORD']
    database = db_config['NAME']

    connection = mysql.connector.connect(
        host=host,
        user=user,
        password=password,
        database=database
    )
    return connection