from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from .models import SiteUser, Assignment, SubmittedAssignment
from django.http import HttpResponseForbidden, FileResponse
from .forms import AssignmentForm, SubmissionForm
from django import template
from django.db.models import Q

# Create your views here.
@login_required(login_url='/accounts/login/')
def index(request):
    user, created = SiteUser.objects.get_or_create(user_id=request.user.id)
    if request.user.is_staff:
        assignments = Assignment.objects.all()
        context = {"assignments": assignments}
        return render(request, 'instructor_index.html', context)
    else:
        assignments = Assignment.objects.all()
        submissions = SubmittedAssignment.objects.filter(Q(student_name = user.user.first_name))
        print(user.user.first_name)
        # print(student__user)
        submitted_array = []
        graded_array = []
        marks_array = []
        total_marks_array = []
        for assignment in assignments:
            flag = False
            flag_graded = False
            marks = 0
            for submission in submissions:
                if submission.submitted_assignment_name == assignment.assignment_name:
                    flag = True
                    flag_graded = submission.is_graded
                    marks = submission.marks
                    break
            
            submitted_array.append(flag)
            graded_array.append(flag_graded)
            marks_array.append(marks)
            total_marks_array.append(assignment.max_marks)

        my_list = zip(assignments, submitted_array, graded_array, marks_array, total_marks_array)

        context = { "my_list": my_list }
        return render(request, 'student_index.html', context)


@login_required(login_url='/accounts/login/') 
def dummy(request, pk):
    return render(request, 'dummy.html')


@login_required(login_url='/accounts/login/') 
def AddAssignment(request):
    if request.user.is_staff:
        if request.method == 'POST':
            form = AssignmentForm(request.POST, request.FILES)

            if form.is_valid():
                assignment = form.save(commit=False)

                if request.FILES.get('assignment_file', None):
                    assignment.assignment_file = request.FILES.get(
                        'assignment_file', None)

                assignment.save()

                return redirect('coursemanager:home')

        else:
           form = AssignmentForm() 

        return render(request, 'assignment.html', {'form': form, 'url': 'add'})
    else:
        return HttpResponseForbidden()
    

@login_required(login_url='/accounts/login/')
def EditAssignment(request,pk):
    if request.user.is_staff:
        form_instance = Assignment.objects.get(pk=pk)
        if request.method == 'POST':
            form = AssignmentForm(request.POST, request.FILES, instance = form_instance)

            if form.is_valid():
                assignment = form.save(commit=False)

                if request.FILES.get('assignment_file', None):
                    assignment.assignment_file = request.FILES.get(
                        'assignment_file', None)

                assignment.save()

                return redirect('coursemanager:home')

        else:
           form = AssignmentForm(instance = form_instance) 

        return render(request, 'assignment.html', {'form': form, 'url': str(pk)})
    else:
        return HttpResponseForbidden()  
    

@login_required(login_url='/accounts/login/') 
def SubmitAssignment(request,pk):
    user, created = SiteUser.objects.get_or_create(user_id=request.user.id)
    if request.user.is_staff:
        return HttpResponseForbidden()
    else:
        assignment = Assignment.objects.get(pk=pk)
        if request.method == 'POST':
            form = SubmissionForm(request.POST, request.FILES)

            if form.is_valid():
                submission = form.save(commit=False)
                submission.student = SiteUser.objects.get(user_id=request.user.id)
                submission.student_name = user.user.first_name
                submission.roll_number = user.user.last_name
                submission.submitted_assignment_name = assignment.assignment_name

                if request.FILES.get('submission_file', None):
                    submission.submission_file = request.FILES.get(
                        'submission_file', None)

                submission.save()

                return redirect('coursemanager:home')

        else:
           form = SubmissionForm() 

        return render(request, 'submission.html', {'form': form, 'name_assignment': assignment.assignment_name, 'url': str(pk)})
    

@login_required(login_url='/accounts/login/')
def MediaView(request, file):
    try:
        return FileResponse(open('media/' + file, 'rb'))
    except:
        return HttpResponseForbidden()