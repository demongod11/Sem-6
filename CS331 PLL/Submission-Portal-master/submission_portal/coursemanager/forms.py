from django.forms import ModelForm, NumberInput, TextInput
from .models import Assignment, SubmittedAssignment
from django import forms
from django.forms.widgets import DateTimeInput

class AssignmentForm(ModelForm):
    class Meta:
        model = Assignment
        fields = [
            'assignment_name',
            'description',
            'deadline',
            'max_marks',
            'assignment_file',
        ]

        widgets = {
            'assignment_name': TextInput(attrs={
                'class': "form-control",
                }),

            'description': TextInput(attrs={
                'class': "form-control",
                }),

            'deadline': DateTimeInput(
                format='%Y-%m-%d %H:%M:%S',
                attrs={
                    'class': 'form-control',
                    'placeholder': 'Select a time',
                    'type': 'datetime-local'
                }),

            'max_marks': NumberInput(attrs={
                     'class': "form-control",
                }),
        }


class SubmissionForm(ModelForm):
    class Meta:
        model = SubmittedAssignment
        fields = [
            'student_name',
            'roll_number',
            'submission_file',
            'submitted_assignment_name',
        ]

        widgets = {
            'student_name': TextInput(attrs={
                'class': "form-control",
                'id': 'stud_name'
                }),

            'roll_number': TextInput(attrs={
                'class': "form-control",
                'id': 'roll_num'
                }),

            'submitted_assignment_name': TextInput(attrs={
                'class': "form-control",
                'id': 'sa'
                }),
        }