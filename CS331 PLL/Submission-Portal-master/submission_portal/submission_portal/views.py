from django.contrib.auth.decorators import login_required
from django.shortcuts import render, redirect

from allauth.account.views import LoginView

class LoginAllAuthView(LoginView):
    template_name = "login.html"