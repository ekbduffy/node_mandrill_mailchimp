{% extends "../layout.swig" %}
{% block title %}Создание рассылки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Новая рассылка{% endblock %}
{% block content %}
    <section class="panel">
        <header class="panel-heading">
            Загрузка новой рассылки<a href="/campaign/new" class="btn btn-info pull-right">Просто создать</a>
        </header>
        <div class="panel-body">
            <form role="form" method="POST">
                <div class="form-group">
                    <label for="inputName">Название</label>
                    <input type="text" class="form-control" id="inputName" placeholder="Enter name" name="name" value="{{req.body.name}}"/>
                </div>
                <div class="form-group">
                    <label for="inputMailchimp">Шаблон Mailchimp</label>
                    {% if mailchimperror %}
                                            <br/>{{mailchimperror}}
                    {% else %}
                    <select class="form-control m-bot15" id="inputMailchimp" name="mailchimp" required>
                        <option value="">Выберите шаблон</option>
                        {% for item in campaigns %}
                        <option value="{{item.id}}">{{item.settings.title}}</option>
                        {% endfor %}
                    </select>                        
                    {% endif %}
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
                    <input type="text" class="form-control" id="inputTemplatename" placeholder="Enter name" name="enname" value="{{req.body.enname}}"/>                    
                </div>
                <button type="submit" class="btn btn-primary pull-right">Создать</button>
            </form>
        </div>
    </section>
{% endblock %}
{% block additionalJS %}
{% endblock %}
