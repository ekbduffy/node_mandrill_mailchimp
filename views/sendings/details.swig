{% extends "../layout.swig" %}
{% block title %}Настройка отправки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Детали отправки{% endblock %}
{% block content %}

    <section class="panel">
        <form role="form" method="POST">
            <header class="panel-heading">
                Настройки Отправки
            </header>
            <div class="panel-body">
                    <div class="form-group">
                        <label for="inputSubject">Тема письма</label>                    
                            <input type="text" class="form-control" id="inputSubject" placeholder="Enter Subj" name="subject" value="{{campaign.subject}}">                    
                    </div>            
                    <div class="form-group">
                        <label for="inputName">Название</label>
                        <input type="text" class="form-control" id="inputName" placeholder="Enter name" name="name" value="{{campaign.name}}">
                    </div>
                    <div class="form-group">
                        <label for="inputTemplatename">Короткое название шаблона на английском</label>                    
                        <input type="text" class="form-control" id="inputTemplatename" placeholder="Enter name" name="enname" value="{{campaign.name}}">                    
                    </div>                    
                    <div class="form-group">
                        <label for="inputFrom">Отправитель</label>
                        <select class="form-control m-bot15" id="inputFrom" name="sender" required>
                            <option value="">Выберите отправителя</option>
                            {% for item in senders %}
                            <option value="{{item.id}}" {% if item.id == campaign.sender%}selected{%endif%}>{{item.name}}({{item.email}})</option>
                            {% endfor %}
                        </select>                        
                    </div>                
                    <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
            </div>
            <header class="panel-heading">
                HTML
            </header>
            <div class="panel-body">
                <div class="form-group">
                        <div class="col-sm-12">
                        <textarea class="form-control" name="html" rows="30">{{campaign.html}}</textarea>
                    </div>
                </div>            
                    <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
            </div>            
            
            <header class="panel-heading">
                Text
            </header>
            <div class="panel-body">
                <div class="form-group">
                        <div class="col-sm-12">
                        <textarea class="form-control" name="plaintext" rows="30">{{campaign.plaintext}}</textarea>
                    </div>
                </div>            
                    <button type="submit" class="btn btn-primary pull-right">Сохранить</button>
            </div>                        
        </form>            
    </section>
{% endblock %}
{% block additionalJS %}

<script type="text/javascript" src="/js/ckeditor/ckeditor.js"></script>
{% endblock %}
