<div style="text-align: center; background-color: #e1e1e1; padding: 20px;">
    <img src="https://i.postimg.cc/KjVgCXz4/Cevi-Wetikon-horizontal-schwarz.png" height="50" alt="Cevi Wetzikon Pool Tool">
</div>
<br>
<p>Liebe/r Cevianer/in<br><br>
Hier findest du eine Liste mit allen Umfragen, die du auf dem Cevi Wetzikon Pool Tool erstellt hast.</p>

<ul>
    {foreach $polls as $poll}
        <li>
            <b>Umfrage: {$poll->title|html}</b><br>
            Admin Link: <a href="{poll_url id=$poll->admin_id admin=true}">{poll_url id=$poll->admin_id admin=true}</a><br>
            Erstellt am: {$poll->creation_date|intl_date_format:$date_format['txt_full']}<br><br>
        </li>
    {/foreach}
</ul>

<p>Bei Fragen wende ich gerne an Tweet: tweet@cevi-wetzikon.ch</p>
