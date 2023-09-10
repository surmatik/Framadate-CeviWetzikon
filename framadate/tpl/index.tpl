{extends file='page.tpl'}

{block name=main}
    <div class="home">
        <h1 class="home-title">
            <span class="home-title-icon1">🌳</span>
            Cevi Wetzikon <br> Pool Tool
            <span class="home-title-icon2">🌳</span>
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
