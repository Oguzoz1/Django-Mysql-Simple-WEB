from django.shortcuts import render, redirect
from django.http import HttpResponse
from movie_app.users.forms import *
from movie_app.users.login import *
from movie_app.users.shows import *
from movie_app.users.manager import *
from movie_app.users.director import *
from movie_app.users.audience import *
 
# Create your views here.
def home(request):
    if('dmName' in request.session):
        dmName = request.session['dmName']
        return render(request,'movie_app/managermenu.html', {'dmName' : dmName})
    if('directorUserName' in request.session):
        directorName = request.session['directorUserName']
        return render(request,'movie_app/directormenu.html', {'directorName' : directorName})
    if('audienceUserName' in request.session):
        audienceName = request.session['audienceUserName']
        return render(request,'movie_app/audiencemenu.html', {'audienceName' : audienceName})
    else: return redirect('../login/')


def loginIndex(request):
    context = {"canLogin" : False}
    return render(request, 'movie_app/login.html',context)

def login(request, type):
    if(type == 0): # managers
        context = {"canLogin" : True, "login_form": DatabaseManagerLoginForm()}
    if(type == 1): # directors
        context = {"canLogin" : True, "login_form": DirectorLoginForm()}
    if(type == 2): # audience
        context = {"canLogin" : True, "login_form": AudienceLoginForm()}

    dmName = request.POST.get("dmName")
    password = request.POST.get("password")
    directorUsername = request.POST.get("directorUserName")
    directorPassword = request.POST.get("directorPassword")
    audienceUsername = request.POST.get("audienceUserName")
    audiencePassword = request.POST.get("audiencePassword")

    managerLogin = checkDatabaseManager(dmName,password)
    directorLogin = checkDirector(directorUsername,directorPassword)
    audienceLogin = checkAudience(audienceUsername,audiencePassword)

    if(managerLogin):
        request.session['dmName'] = dmName
        return redirect('../manager/')
    elif(directorLogin):
        request.session['directorUserName'] = directorUsername
        return redirect('../director/')
    elif(audienceLogin):
        request.session['audienceUserName'] =  audienceUsername
        return redirect('../audience/')


    return render(request, 'movie_app/login.html',context)

def logout(request):
    request.session['dmName'] = ""
    request.session['password'] = ""
    request.session['directorUserName'] = ""
    request.session['directorPassword'] = ""
    request.session['audienceUserName'] = ""
    request.session['audiencePassword'] = ""
    return redirect('../login/')

def adminHome(request):
    newUsername = request.POST.get('newUsername')
    newPassword = request.POST.get('newPassword')
    name = request.POST.get('name')
    surname = request.POST.get('surname')
    userType = request.POST.get('user_type')
    username = request.POST.get('username')
    directorName = request.POST.get('directorName')
    platformId = request.POST.get('platformID')

    if (newUsername == None or newPassword == None):
        inputCheck = True
    else: 
        addNewUser(newUsername,newPassword,name,surname,userType)
        inputCheck = False

    if(username != None):
        deleteUser(username)
    if(directorName != None and platformId != None):
        addPlatformID(directorName,platformId)

    context = {"input_fail" : inputCheck, "add_form" : AddForm(), "delete_form" : Deleteform(),
            "platform_form": AddPlatformIDForm()}
    return render(request, 'movie_app/managermenu.html', context)


def listRequestsDM(request,type):
    if ('dmName' in request.session):
        dmName = request.session['dmName']
    else:
        return redirect('../login/')
    
    if dmName is None:
        return redirect('../login/')
    
    directorNameX = request.POST.get('directorNameX')
    audienceName = request.POST.get('audienceName')
    movieID = request.POST.get('movieID')

    
    returnTable = []
    typeTitle = ""
    dataForm = None
    if (type == 0 and dmName != None): # directors
        returnTable = getDirectors()
        typeTitle = "DIRECTORS"
        dataOrder = "USERNAME, NAME, SURNAME, NATION, PLATFORM ID"
    elif (type == 1): # Audience Ratings
        returnTable = getAudienceRatings(audienceName)
        typeTitle = "RATINGS BY USERS"
        dataOrder = "MOVIE ID, MOVIE NAME, RATING"
        dataForm = AudienceProcessForm()
    elif (type == 2): # comedy
        returnTable = getDirectorMovies(directorNameX)
        typeTitle = "DIRECTOR MOVIE SESSIONS"
        dataOrder = "MOVIE ID, MOVIE NAME, THEATRE ID, THEATRE TIME SLOT, MOVIE TIME"
        dataForm = DirectorProcessForm()
    elif (type == 3): # comedy
        returnTable = getAverageMovieRating(movieID)
        typeTitle = "AVERAGE OF MOVIE RATINGS"
        dataOrder = "MOVIE ID, MOVIE NAME, AVERAGE RATINGS"
        dataForm = MovieIDForm()
    else:
        return redirect('../home/')
    
    if (len(returnTable) == 0):
        returnTable = False
    
    context = {"table_name": typeTitle, "table_data": returnTable, "data_form" : dataForm, "info_field": dataOrder}
    return render(request, 'movie_app/shows.html', context)

def directorHome(request):
    if ('directorUserName' in request.session):
        directorUsername = request.session['directorUserName']
    else:
        return redirect('../login/')
    
    movie_id = request.POST.get("movie_id")
    movie_name = request.POST.get("movie_name")
    genreID = request.POST.get("genreID")
    duration = request.POST.get("duration")
    targetMovieId = request.POST.get("targetMovieID")
    predecessormovieID = request.POST.get("predecessorMovieID")

    if(directorUsername is not None and movie_id is not None and genreID is not None):
        addMovie(movie_id,movie_name, duration, directorUsername,genreID)
    if(targetMovieId and predecessormovieID is not None):
        addPredecessor(targetMovieId, predecessormovieID)
    else: print("NO USERNAME AND MOVIE ID")

    context = {"add_form" : AddMovie(),"predecessor_form" : AddPredecessor()}
    return render(request, 'movie_app/directormenu.html', context)

def audienceHome(request):
    if ('audienceUserName' in request.session):
        audienceUserName = request.session['audienceUserName']
    else:
        return redirect('../login/')
    

    form = ShowMoviesForm(request.POST)
    form2 = ShowBoughtTickets(request.POST)
    table_data = []
    bought_tickets = []
    data_field = None
    data_field2 = None
    sessionID = request.POST.get("sessionID")

    if sessionID is not None:
        buyTicket(sessionID, audienceUserName)

    if request.method == 'POST' and form.is_valid():
        data_field = "SESSION ID, MOVIE ID, MOVIE NAME, SURNAME, PLATFORM NAME, THEATRE ID, TIME SLOT, PREDECESSORS"
        table_data = getMovies()

    if request.method == 'POST' and form2.is_valid():
        data_field2 = "MOVIE ID , MOVIE NAME, SESSION ID, RATING, OVERALL RATING"
        bought_tickets = getBoughtTickets(audienceUserName)


    context = {
        'show_button': form,
        'table_data': table_data,
        'data_field': data_field,
        'data_field2' : data_field2,
        'buy_tickets' : BuyTicket(),
        'show_bought': form2,
        'bought_tickets' : bought_tickets,
    }
    return render(request, 'movie_app/audiencemenu.html', context)
    