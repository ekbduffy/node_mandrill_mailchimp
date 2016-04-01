{% extends "../layout.swig" %}
{% block title %}Создание рассылки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Новая рассылка{% endblock %}
{% block content %}
    <section class="panel">
        <form role="form" method="POST">
        <header class="panel-heading">
            Создание новой рассылки <a href="/campaign/load" class="btn btn-info pull-right">Загрузить из MailChimp</a>
        </header>
        <div class="panel-body">
            <form role="form" method="POST">
                <div class="form-group">
                    <label for="inputName">Название</label>
                    <input type="text" class="form-control" id="inputName" placeholder="Enter name" name="name" value="{{req.body.name}}" />
                </div>
                <div class="form-group">
                    <label for="inputFrom">Отправитель</label>
                    <select class="form-control m-bot15" id="inputFrom" name="sender" required>
                        <option value="">Выберите отправителя</option>
                        {% for item in sender %}
                        <option value="{{item.id}}">{{item.name}}({{item.email}})</option>
                        {% endfor %}
                    </select>                        
                </div>                
                <div class="form-group">
                    <label for="inputTemplatename">Короткое название шаблона на английском</label>                    
                    <input type="text" class="form-control" id="inputTemplatename" placeholder="Enter name" name="enname" value="{{req.body.enname}}" />                    
                </div>
                <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
            </form>
        </div>
    </section>
{% endblock %}
{% block additionalJS %}
{% endblock %}
