from movie_app.users.main import *

def addNewUser(username,password,name,surname,userType):
    connection = getDatabaseConnection()
    cursor = connection.cursor()
    
    query = "INSERT INTO user (username, password, name, surname) VALUES (%s, %s, %s, %s)"
    values = (username, password, name, surname)
    cursor.execute(query, values)

    if(userType == 'audience'):
        query = "INSERT INTO audience (username) VALUES (%s)"
        values = (username,) 

    elif(userType == 'director'):
        query = "INSERT INTO director (username) VALUES (%s)"
        values = (username,)
   

    cursor.execute(query, values)
    connection.commit()

    cursor.close()
    connection.close()

def deleteUser(username):
    connection = getDatabaseConnection()
    cursor = connection.cursor()
    
    query = "DELETE FROM user WHERE username = %s"
    values = (username,)
    cursor.execute(query, values)
    connection.commit()

    cursor.close()
    connection.close()

def addPlatformID(directorName, platformId):
    connection = getDatabaseConnection()
    cursor = connection.cursor()
   
    query = "UPDATE director SET platform_id = %s WHERE username = %s"
    values = (platformId, directorName)
    cursor.execute(query, values)

    connection.commit()
    cursor.close()
    connection.close()

def getDirectors():
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT DISTINCT u.username, u.name, u.surname, d.nation, d.platform_id FROM user u INNER JOIN director d ON u.username = d.username"
    cursor.execute(query)

    directors = cursor.fetchall()

    cursor.close()
    connection.close()

    return directors

def getAudienceRatings(username):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT r.movie_id, m.movie_name, r.rating FROM ratings r INNER JOIN movies m ON r.movie_id = m.movie_id WHERE r.username = %s"
    values = (username,)
    cursor.execute(query, values)

    ratings = cursor.fetchall()

    cursor.close()
    connection.close()

    return ratings

def getDirectorMovies(username):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT ms.movie_id, ms.movie_name, t.theatre_id, t.time_slot, ms.time_slot FROM movie_sessions ms INNER JOIN theatre t ON ms.theatre_id = t.theatre_id WHERE ms.director_username = %s"
    values = (username,)
    cursor.execute(query, values)

    movies = cursor.fetchall()

    cursor.close()
    connection.close()

    return movies

def getAverageMovieRating(movie_id):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT r.movie_id, m.movie_name, AVG(r.rating) AS overall_rating FROM ratings r INNER JOIN movies m ON r.movie_id = m.movie_id WHERE r.movie_id = %s"
    values = (movie_id,)
    cursor.execute(query, values)

    ratings = cursor.fetchall()

    cursor.close()
    connection.close()

    return ratings
