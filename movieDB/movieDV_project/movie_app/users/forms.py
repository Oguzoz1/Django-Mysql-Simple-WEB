from django import forms
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit

class DatabaseManagerLoginForm(forms.Form):
    dmName = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Manager Username'}))
    password = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Password'}))

class DirectorLoginForm(forms.Form):
    directorUserName = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Director Username'}))
    directorPassword = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Director Password'}))

class AudienceLoginForm(forms.Form):
    audienceUserName = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Director Username'}))
    audiencePassword = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Director Password'}))

class AddForm(forms.Form):
    USER_TYPE_CHOICES = (
        ('director', 'Director'),
        ('audience', 'Audience'),
    )
    user_type = forms.ChoiceField(choices=USER_TYPE_CHOICES)
    newUsername = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New Username'}))
    newPassword = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New Password'}))
    name = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'name'}))
    surname = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'surname'}))

class AddMovie(forms.Form):
    movie_id = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New movieID'}))
    movie_name = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New Movie Name'}))
    duration = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Duration'}))
    genreID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Genre ID'}))

class AddPredecessor(forms.Form):
    targetMovieID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New movieID'}))
    predecessorMovieID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'New movieID'}))

class Deleteform(forms.Form):
    username = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'username'}))

class AddPlatformIDForm(forms.Form):
    directorName = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))
    platformID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'PlatformID'}))

class DirectorProcessForm(forms.Form):
    directorNameX = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))

class AudienceProcessForm(forms.Form):
    audienceName = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))

class MovieIDForm(forms.Form):
    movieID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Movie ID'}))

class ShowMoviesForm(forms.Form):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.add_input(Submit('show_button', 'Show Movies', css_class='btn-primary'))

class ShowBoughtTickets(forms.Form):
    helper = FormHelper()
    helper.form_method = 'POST'
    helper.add_input(Submit('show_bought', 'Show Tickets', css_class='btn-primary'))


class BuyTicket(forms.Form):
    sessionID = forms.CharField(widget=forms.TextInput(attrs={'placeholder': 'Session ID'}))
