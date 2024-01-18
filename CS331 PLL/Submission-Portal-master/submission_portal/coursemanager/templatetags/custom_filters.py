from django import template

register = template.Library()

@register.filter(name='zip_lists')
def zip_lists(*args):
    return zip(*args)