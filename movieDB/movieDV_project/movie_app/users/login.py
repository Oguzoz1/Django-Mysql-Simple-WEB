from movie_app.users.main import *

def checkCredentials(name,password):
    if((name == "ouz" and password == "") or (name == "ahmet" and password == "oz")):
        return True
    return False
def checkDatabaseManager(username,password):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT * FROM database_managers WHERE username = %s AND password = %s"
    params = (username, password)
    cursor.execute(query, params)

    result = cursor.fetchone()

    cursor.close()
    connection.close()

    return result

def checkDirector(username, password):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT * FROM user WHERE username = %s AND password = %s"
    params = (username, password)
    cursor.execute(query, params)

    result = cursor.fetchone()

    cursor.close()
    connection.close()

    return result

def checkAudience(username, password):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT * FROM user WHERE username = %s AND password = %s"
    params = (username, password)
    cursor.execute(query, params)

    result = cursor.fetchone()

    cursor.close()
    connection.close()

    return result