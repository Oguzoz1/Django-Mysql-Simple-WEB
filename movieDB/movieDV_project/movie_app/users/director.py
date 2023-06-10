from movie_app.users.main import *

def addMovie(movie_id, movie_name, duration, director_username, genreID):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT username FROM director WHERE username = %s"
    cursor.execute(query, (director_username,))
    director = cursor.fetchone()
    genre_id = int(genreID)
    if director:
        query = "SELECT genre_name FROM genre WHERE genre_id = %s"
        cursor.execute(query, (genre_id,))
        director = cursor.fetchone()

        if genre_id:
            query = "INSERT INTO movies (movie_id, movie_name, duration, director_username, platform_id, genre) VALUES (%s, %s, %s, %s, (SELECT platform_id FROM director WHERE username = %s))"
            values = (movie_id, movie_name, duration, director_username, director_username, genre_id)
            cursor.execute(query, values)
            connection.commit()

    cursor.close()
    connection.close()

def addPredecessor(movie_id, Pmovie_ID):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = "SELECT session_id FROM movie_sessions WHERE movie_id = %s"
    cursor.execute(query, (movie_id,))
    sessionIDs = [row[0] for row in cursor.fetchall()]
    print(sessionIDs)
    query = "SELECT movie_id FROM movies WHERE movie_id = %s"
    cursor.execute(query, (Pmovie_ID, ))
    PmovieID = cursor.fetchone()
    
    if sessionIDs and PmovieID:
        
        for sessionID in sessionIDs:
            query = "SELECT predecessors FROM movie_sessions WHERE session_id = %s"
            cursor.execute(query, (sessionID,))
            current_predecessors = cursor.fetchone()[0]

            new_predecessor = ""
            if(current_predecessors is None):
                 new_predecessor = PmovieID[0]
            else: 
                new_predecessor = str(PmovieID[0])
                new_predecessor = current_predecessors + "," + new_predecessor

            update_query = "UPDATE movie_sessions SET predecessors = %s WHERE session_id = %s"
            cursor.execute(update_query, (new_predecessor, sessionID, ))
            connection.commit()

    cursor.close()
    connection.close()

