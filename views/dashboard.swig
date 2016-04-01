{% extends "layout.swig" %}
{% block title %}Сводка{% endblock %}
{% block pagetitle %}Сводка{% endblock %}
{% block content %}{{ dump(info) }}{% endblock %}
{% block pagefooter %}{% endblock %}