<footer>
        <div class="footer-columns">
            <div class="footer-column footer-column-1">
                <img class="footer-logo" src="/images/logo-framadate.png" alt="Logo">
                <p>Das Tool für Planung von Höcks, Anlässen und mehr. Für eine reibungslose Organisation und effiziente Zusammenarbeit!</p>
                <p>Entwickelt von <a href="https://linoo.ch" target="_blank">Tweet</a> 👨‍💻, basierend auf <a href="https://framadate.org/" target="_blank">Framadate</a></p>
                <ul class="social-icons">
                    <li><a href="https://www.instagram.com/cevi.wetzikon" target="_blank"><i class="icon fab fa-instagram"></i></a></li>
                    <li><a href="https://de-de.facebook.com/ceviwetzikon" target="_blank"><i class="icon fab fa-facebook"></i></a></li>
                    <li><a href="https://cevi-wetzikon.ch/" target="_blank"><i class="icon fas fa-globe"></i></a></li>
                </ul>
            </div>

            <div class="footer-column footer-column-2">
                <div class="footer-title">Links</div>
                <ul class="footer-links">
                    <li><a href="/docs/hilfe.php">Hilfe</a></li>
                    <li><a href="/docs/kontakt.php">Kontakt</a></li>
                    <li><a href="/find_polls.php">Deine Umfragen</a></li>
                </ul>
            </div>

            <div class="footer-column footer-column-2">
                <div class="footer-title">Weiteres</div>
                <ul class="footer-links">
                    <li><a href="https://cevi-wetzikon.ch/jungschar/" target="_blank"">Jahresprogramm Cevi Wetzikon</a></li>
                    <li><a href="https://db.cevi.ch/" target="_blank">Cevi DB</a></li>
                    <li><a href="https://wiki.cevi.ch/" target="_blank">Cevi Wiki</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="footer-bottom-left">
                <a href="/docs/datenschutz.php" class="footer-links-bottom">Datenschutz</a>
                <a href="/docs/cookie.php" class="footer-links-bottom">Cookie Richtlinien</a>
            </div>
            <div class="footer-bottom-right">
                <a href="https://github.com/surmatik/Framadate-CeviWetzikon" target="_blank"><i class="icon fab fa-github"></i> Surmatik/Framadate-CeviWetzikon</a>
            </div>
        </div>
    </footer>
    <script>
        // JavaScript, um den Footer am unteren Rand zu halten
        function setFooter() {
            const body = document.body;
            const footer = document.querySelector("footer");
            const windowHeight = window.innerHeight;
            const bodyHeight = body.clientHeight;

            if (bodyHeight < windowHeight) {
                footer.style.position = "fixed";
                footer.style.bottom = "0";
            } else {
                footer.style.position = "static";
            }
        }

        // Seite initialisieren und bei Bedarf Footer setzen
        setFooter();
        window.addEventListener("resize", setFooter);
    </script>