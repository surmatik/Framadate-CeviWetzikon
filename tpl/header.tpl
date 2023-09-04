    <header class="header-cevi">
        <div class="header-left">
            <a href="{$SERVER_URL|html}">
                <img src="{$SERVER_URL|html}images/logo-framadate.png" alt="">
            </a>
        </div>
        <div class="header-right">
            <p class="time">Cevi Wetzikon Doodle Tool</p>
            <a href="{$SERVER_URL|html}find_polls.php" class="button">Meine Umfragen</a>
            <div class="dropdown">
                <a href="#" class="button button-dropdown">+</a>
                <div class="dropdown-content">
                    <a href="{$SERVER_URL|html}create_poll.php?type=date"><i class="fas fa-calendar-alt calendar-icon"></i> Termin Umfrage erstellen</a>
                    <a href="{$SERVER_URL|html}create_poll.php?type=autre"><i class="fas fa-poll survey-icon"></i> Klassische Umfrage erstellen</a>
                </div>
            </div>
        </div>        
    </header>
    <main>
