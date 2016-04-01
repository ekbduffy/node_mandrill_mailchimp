{% extends "layout.swig" %}
{% block title %}MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Сводка рассылок{% endblock %}
{% block content %}

<section class="panel">
    <header class="panel-heading">
            Mandrill stat
    </header>
    <div class="panel-body">{% if info.mandrillstat.stats %}
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>Период</th>
                                <th>Отправлено</th>
                                <th>Hard Bounces</th>
                                <th>Soft Bounces</th>
                                <th>Rejects</th>
                                <th>Complaints</th>
                                <th>Отписок</th>
                                <th>Открытий(Уникальных)</th>
                                <th>Кликов(Уникальных)</th>
                            </tr>
                            </thead>
                            <tbody>
                                
                                {% for stat in info.mandrillstat.stats %}                                
                                <tr>
                                    <td>{{ loop.key }}</td>
                                    <td>{{stat.sent}}</td>
                                    <td>{{stat.hard_bounces}}</td>
                                    <td>{{stat.soft_bounces}}</td>
                                    <td>{{stat.rejects}}</td>
                                    <td>{{stat.complaints}}</td>
                                    <td>{{stat.unsubs}}</td>
                                    <td>{{stat.opens}}({{stat.unique_opens}})</td>
                                    <td>{{stat.clicks}}({{stat.unique_clicks}})</td>
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>
                        {% else %}
                            Ошибка, нет данных от Mandrill
                        {% endif %}
    </div>
</section>

<section class="panel">
    <header class="panel-heading">
            MailChimp stat
    </header>
    <div class="panel-body">{% if info.mailchimperror %}
                                Ошибка, нет данных от MailChimp:<br/>
                                {{info.mailchimperror}}
                        {% else %}
                            {{info.mailchimp|json}}
                        {% endif %}
    </div>
</section>

{% endblock %}
{% block pagefooter %}{% endblock %}