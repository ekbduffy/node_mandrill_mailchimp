{% extends "../layout.swig" %}
{% block title %}Создание рассылки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Новая рассылка{% endblock %}
{% block content %}

    <section class="panel">
        <header class="panel-heading">
            Настройки новой рассылки
        </header>
        <div class="panel-body">
            <form role="form" method="POST">
                <div class="form-group">
                    <label for="inputName">Название</label>
                    <input type="text" class="form-control" id="inputName" placeholder="Enter name" name="name">
                </div>
                <div class="form-group">
                    <label for="inputMailchimp">Шаблон Mailchimp</label>
                    {% if mailchimperror %}
                                            <br/>{{mailchimperror}}
                    {% else %}
                    <select class="form-control m-bot15" id="inputMailchimp" name="mailchimp">
                    
                        {% for item in campaigns.data %}
                        <option value="{{item.id}}">{{item.title}}</option>
                        {% endfor %}
                    </select>                        
                    {% endif %}
                </div>
                <div class="form-group">
                    <label for="inputList">Список для рассылки</label>                    
                    {% if lists %}
                    <select class="form-control m-bot15" id="inputList" name="list">                    
                        {% for item in lists %}
                        <option value="{{item.id}}">{{item.name}}</option>
                        {% endfor %}
                    </select>
                    {% else %}
                        <br/>Ошибка, нет списков рассылки.
                    {% endif %}
                </div>
                <div class="form-group">
                    <label for="inputPSize">Количество писем в порции</label>
                    <select class="form-control m-bot15" id="inputPSize" name="psize">                    
                        <option>100</option>
                        <option>500</option>
                        <option>1000</option>
                        <option>1500</option>
                        <option>3000</option>
                    </select>
                </div>                
                <div class="form-group">
                    <label for="inputName">Интервал отправки порций</label>
                    <select class="form-control m-bot15" id="inputList" name="list">
                        <option value="1800">Пол часа</option>                    
                        <option value="3600">Час</option>
                        <option value="7200">Два часа</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary pull-right">Создать</button>
            </form>
        </div>
    </section>
{% endblock %}
{% block additionalJS %}
{% endblock %}
