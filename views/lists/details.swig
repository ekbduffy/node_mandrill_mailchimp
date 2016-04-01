{% extends "../layout.swig" %}
{% block title %}Детали списка MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Редактирование списка адресов{{campaign.name}}{% endblock %}
{% block content %}

    <section class="panel">
        <form role="form" method="POST">
            <input type=hidden name="action" value="save"/>
            <header class="panel-heading">
                Список адресов
            </header>
            <div class="panel-body">
                    <div class="form-group">
                        <label for="inputName">Название</label>
                        <input type="text" class="form-control" id="inputName" placeholder="Enter name" name="name" value="{{list.name}}">
                    </div>                
                    <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
            </div>
            <header class="panel-heading">
                Адреса
            </header>
            <div class="panel-body">
                <table class="table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Email</th>
                        <th>Имя</th>
                        <th>Фамилия</th>
                        <th>Дополнительные поля</th>
                        <th>Подписка</th>
                        <th>Действия</th>
                    </tr>
                    </thead>
                    <tbody>
                        {% for row in emails %}
                        <tr>
                            <td>{{row.id}}</td>
                            <td>{{row.email}}</td>
                            <td>{{row.firstName}}</td>
                            <td>{{row.lastName}}</td>
                            <td>{{row.additional|json}}<a href="#" class="btn btn-default">Ред.</a></td>
                            <td>{{row.subscribed}}</td>
                            <td><a href="#" class="btn btn-default">Отписать</a> <a href="#" class="btn btn-default">Удалить</a></td>
                        </tr>                    
                        {% endfor %}
                    </tbody>
                </table>                
                {{emails|json}}     
            </div>            
        </form>                    
    </section>

    <section class="panel">
        <form role="form" method="POST">
            <input type=hidden name="action" value="add"/>
            <header class="panel-heading">
                Добавить адреса к списку
            </header>
            <div class="panel-body">
                    <div class="form-group">
                        Вставьте адреса. XML, CSV или JSON.<br/>
                        JSON: <strong>{"email":"ivan@eleview.com","firstName":"ivan","lastName":"test","additional":null}</strong><br/>
                        XML: <strong>&lt;ASI email=&quot;ivan@eleview.com&quot; firstName=&quot;Ivan&quot; lastName=&quot;Davletshin&quot;/&gt;</strong><br/>
                        CSV: <strong>""</strong>
                        <textarea rows="40" style="width:100%" name="addresses"></textarea>
                    </div>                
                    <button type="submit" class="btn btn-primary pull-right">Добавить</button>
            </div>            
        </form>                    
    </section>

    
{% endblock %}
{% block additionalJS %}

<script type="text/javascript" src="/js/ckeditor/ckeditor.js"></script>
{% endblock %}
