{% extends "../layout.swig" %}
{% block title %}Списки рассылки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Списоки адресов для рассылки{% endblock %}
{% block content %}
    <section class="panel">
        <header class="panel-heading">
            Списки адресов
        </header>
        <div class="panel-body">
            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название</th>
                    <th>Количество адресов</th>
                    <th>Создан</th>
                </tr>
                </thead>
                <tbody>
                    {% for row in lists %}
                    <tr>
                        <td>{{row.id}}</td>
                        <td><a href="/list/details/{{row.id}}">{{row.name}}</a></td>
                        <td>{{row.emails}}</td>
                        <td>{{row.created|date('Y-m-d')}}</td>
                    </tr>                    
                    {% endfor %}
                </tbody>
            </table>
        </div>
    </section>
{% endblock %}
{% block additionalJS %}
{% endblock %}
