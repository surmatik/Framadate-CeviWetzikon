{extends file='page.tpl'}

{block name=main}
    <div class="home">
        <h1 style="display: flex; align-items: center; justify-content: center;">
            <span style="margin-right: 20px;">🌳</span> Cevi Wetzikon <br> Pool Tool <span style="margin-left: 20px;">🌳</span>
        </h1>

        <hr class="title-line">
        <p>👉 Das Tool für Planung von Höcks, Anlässen und mehr!</p>
        <div class="buttons">
            <a href="{$SERVER_URL|html}create_poll.php?type=date" class="button"><i class="fas fa-calendar-alt calendar-icon"></i> Termin Umfrage erstellen</a>
            <a href="{$SERVER_URL|html}create_poll.php?type=autre" class="button"><i class="fas fa-poll survey-icon"></i> Klasssiche Umfrage erstellen</a>
        </div>
        <img src="images/framadate.png" alt="">
    </div>
    <style>
        main {
            background-color: #fff0;
            border-top: 0;
        }
    </style>
{/block}
