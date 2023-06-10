from movie_app.users.main import *

def getMovies():
    connection = getDatabaseConnection()
    cursor = connection.cursor()


    query = """
    SELECT ms.session_id, ms.movie_id, ms.movie_name, u.surname, rp.platform_name, ms.theatre_id, ms.time_slot, ms.predecessors
    FROM movie_sessions ms
    INNER JOIN director d ON ms.director_username = d.username
    INNER JOIN user u ON ms.director_username = u.username
    INNER JOIN rating_platform rp ON ms.platform_id = rp.platform_id
    INNER JOIN theatre t ON ms.theatre_id = t.theatre_id
    """
    cursor.execute(query)
    movies = cursor.fetchall()

    cursor.close()
    connection.close()

    return movies

def getBoughtTickets(audienceUserName):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    query = """
    SELECT ms.movie_id, ms.movie_name, bt.session_id, r.rating,
    ms.average_rating AS overall_rating
    FROM bought_tickets bt
    INNER JOIN movie_sessions ms ON bt.session_id = ms.session_id
    LEFT JOIN ratings r ON r.movie_id = ms.movie_id
    WHERE bt.username = %s
    """
    cursor.execute(query,(audienceUserName,))
    tickets = cursor.fetchall()

    cursor.close()
    connection.close()

    return tickets



def buyTicket(sesssion_id, audienceName):
    connection = getDatabaseConnection()
    cursor = connection.cursor()
    query = "SELECT predecessors FROM movie_sessions WHERE session_id = %s"
    cursor.execute(query, (sesssion_id,))
    predecessors = cursor.fetchone()[0]
    predecessors_list = []

    if predecessors_list:
        predecessors_list = predecessors.split(",")

    #If any of the movies were not watched, exit.
    for predID in predecessors_list:
        if checkPredecessorWatched(predID, audienceName) is False:
            print("PREDECESSORS WERE NOT WATCHED!")
            return
    
    #If all watched:
    #Check if related theatre has capacity more than 0
    query = "SELECT t.theatre_capacity FROM movie_sessions ms INNER JOIN theatre t ON t.theatre_id = ms.theatre_id WHERE session_id = %s"
    cursor.execute(query, (sesssion_id,))
    theatreCapacity = str(cursor.fetchone()[0])
    if int(theatreCapacity) > 0:
        # Max capacity is 100
        ticketID = str(int(sesssion_id) * 1000 + (100 - int(theatreCapacity)))
        query = "UPDATE theatre SET theatre_capacity = theatre_capacity - 1 WHERE theatre_id IN (SELECT theatre_id FROM movie_sessions WHERE session_id = %s)"
        cursor.execute(query, (sesssion_id,))

        query = "INSERT INTO bought_tickets (ticket_id, username, session_id) VALUES (%s, %s, %s)"
        cursor.execute(query, (ticketID, audienceName, sesssion_id))
        connection.commit()
    else: print("THE CAPACITY IS FULL")

    
    cursor.close()
    connection.close()

def checkPredecessorWatched(movie_id, username):
    connection = getDatabaseConnection()
    cursor = connection.cursor()

    if(movie_id is None or movie_id is ""):
        return True
    #Find session ids through providing movie ID
    query = "SELECT session_id FROM movie_sessions WHERE movie_id = %s  "
    cursor.execute(query, (movie_id,))
    movie_sessions = cursor.fetchall()
    session_ids = [session[0] for session in movie_sessions]

    #Find bought tickets for the designated user.
    query = "SELECT session_id FROM bought_tickets WHERE username = %s"
    cursor.execute(query, (username,))
    bought_sessions = cursor.fetchall()
    bought_session_ids = [session[0] for session in bought_sessions]

    # Check if bought ticket's session ID is matching the available session id.
    for session_id in session_ids:

        #looping to see session ids if found return True
        if session_id in bought_session_ids:
            cursor.close()
            connection.close()
            return True

    cursor.close()
    connection.close()
    return False
