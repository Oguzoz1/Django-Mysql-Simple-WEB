from django.urls import path
from . import views

urlpatterns =[
    path('home/', views.home, name='home'),
    path('login/', views.loginIndex, name='loginIndex'),
    path('login/<int:type>', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('shows/<int:type>', views.listRequestsDM, name='listRequestsDM'),
    path('manager/', views.adminHome,name='adminHome'),
    path('director/', views.directorHome,name='directorHome'),
    path('audience/', views.audienceHome,name='audienceHome'),
]