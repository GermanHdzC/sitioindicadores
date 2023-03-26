from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from django.contrib.auth import logout

# Create your views here.
#@login_required
def home(request):
    username = request.user.username
    context = {'username': username}
    return render(request, 'Home/home.html', context)

def salir(request):
    logout(request)
    return redirect('/')