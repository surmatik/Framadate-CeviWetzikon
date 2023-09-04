{extends file='page.tpl'}

{block name=main}
    <div class="home">
        <h1>Cevi Wetzikon Doodle Tool</h1>
        <p>Erstelle ganz einfach eine Umfrage für einen Höck oder sonst einen Analss.</p>
        <div class="buttons">
            <a href="/create_poll.php?type=date" class="button"><i class="fas fa-calendar-alt calendar-icon"></i> Termin Umfrage erstellen</a>
            <a href="/" class="button"><i class="fas fa-poll survey-icon"></i> Klasssiche Umfrage erstellen</a>
        </div>
        <img src="images/framadate.png" alt="">
    </div>
{/block}
