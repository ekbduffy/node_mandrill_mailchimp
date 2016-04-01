{% extends "../layout.swig" %}
{% block title %}Отправки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Список отправок{% endblock %}
{% block content %}
    <section class="panel">
        <header class="panel-heading">
            Отправки в базе
        </header>
        <div class="panel-body">
            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Что куда</th>
                    <th>Исключение</th>
                    <th>Создана</th>
                </tr>
                </thead>
                <tbody>
                    {% for row in sendings %}
                    <tr>
                        <td>{{row.id}}</td>
                        <td><a href="/sending/details/{{row.id}}">{{row.enname}} > {{row.liname}}</a></td>
                        <td>{{row.exliname}}</td>
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
