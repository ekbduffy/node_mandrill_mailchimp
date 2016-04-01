{% extends "../layout.swig" %}
{% block title %}Создание рассылки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Список кампаний{% endblock %}
{% block content %}
    <section class="panel">
        <header class="panel-heading">
            Кампании в базе
        </header>
        <div class="panel-body">
            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Название</th>
                    <th>Отправитель</th>
                    <th>Создана</th>
                </tr>
                </thead>
                <tbody>
                    {% for row in campaigns %}
                    <tr>
                        <td>{{row.id}}</td>
                        <td><a href="/campaign/details/{{row.id}}">{{row.name}}({{row.enname}})</a></td>
                        <td>{{row.sendername}}</td>
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
