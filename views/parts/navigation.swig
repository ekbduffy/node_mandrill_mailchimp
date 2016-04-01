              <!--sidebar nav start-->
                <ul class="nav nav-pills nav-stacked custom-nav">
                    <li class="{% if req.originalUrl == '/' %}active{% endif %}"><a href="/"><i class="fa fa-home"></i> <span>Сводка</span></a></li>
                    <li class="{% if req.originalUrl.startsWith('/campaign/new')||req.originalUrl.startsWith('/campaign/load') %}active{% endif %}"><a href="/campaign/new"><i class="fa fa-laptop"></i> <span>Новая кампания</span></a></li>
                    <li class="{% if req.originalUrl.startsWith('/campaign') && !(req.originalUrl.startsWith('/campaign/new')||req.originalUrl.startsWith('/campaign/load')) %}active{% endif %}"><a href="/campaign"><i class="fa fa-book"></i> <span>Кампании</span></a></li>                    
                    <li class="{% if req.originalUrl == '/sending' %}active{% endif %}"><a href="/sending"><i class="fa fa-book"></i> <span>Отправки</span></a></li>
                    <li class="{% if req.originalUrl == '/list' %}active{% endif %}"><a href="/list"><i class="fa fa-list-ul"></i> <span>Списки</span></a></li>
                    <li class="{% if req.originalUrl == '/settings' %}active{% endif %}"><a href="/settings"><i class="fa fa-cogs"></i> <span>Настройки</span></a></li>

<!--
                    <li class="menu-list {% if req.path.indexOf('/vk') == 0 %}active{% endif %}"><a href="#"><i class="fa fa-laptop"></i> <span>ВКонтакте</span></a>
                        <ul class="sub-menu-list">
                            <li><a href="/vk/groups">Группы</a></li>
                            <li><a href="/vk/posts">Посты</a></li>
                            <li><a href="/vk/search">Пользователи</a></li>
                            <li><a href="/vk/additional">Дополнительная обработка</a></li>
                        </ul>
                    </li>-->

                </ul>
                <!--sidebar nav end-->