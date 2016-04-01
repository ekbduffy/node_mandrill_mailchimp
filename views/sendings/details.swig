{% extends "../layout.swig" %}
{% block title %}Настройка отправки MailChimp->Mandrill{% endblock %}
{% block pagetitle %}Детали отправки{% endblock %}
{% block content %}

    <section class="panel">
            <header class="panel-heading">
                Детали Отправки
            </header>
            <div class="panel-body">
                    <div class="form-group">
                        <label for="inputSubject">Список:</label>                    
                        <strong>{{sending.liname}}</strong>                                                
                    </div>         
                    <div class="form-group">
                        <label for="inputSubject">Исключенный список:</label>                    
                        <strong>{{sending.exliname}}</strong>                                                
                    </div>                 
                    <div class="form-group">
                        <label for="inputSubject">Название рассылки:</label>                    
                        <strong>{{sending.enname}}</strong>                                                
                    </div>                                                       
                    <div class="form-group">
                        <label for="inputSubject">Размер порции:</label>                    
                        <strong>{{sending.portion}}</strong>                                                
                    </div>                       
                    <div class="form-group">
                        <label for="inputSubject">Интервал отправки порций:</label>                    
                        <strong>{{sending.interval}} секунд</strong>                                                
                    </div>                                                             
                    <div class="form-group">
                        <label for="inputSubject">Состояние:</label>                    
                        <strong>{{sending.state}}</strong>                                                
                    </div>                                   

            {% if sending.state == "created" %} 
            Рассылка создана.<br/>Писем к отправке: {{sending.listnum}}.<br/>
            <button class="btn btn-primary" id="sendbutt">Запустить отправку</button>
            {% elseif sending.state == "running" %}
            Рассылка отправляется.<br/> Отправлено {{sending.datanum}} из {{sending.listnum}}.
            {% else %}
             Рассылка отправлена
            {% endif %}
            {{sending|json}}
            </div>
               
    </section>
{% endblock %}
{% block additionalJS %}
<script>
$('#sendbutt').on('click', function (e) {   
     $.ajax('/sending/run/{{sending.id}}');
});
</script>
{% endblock %}
