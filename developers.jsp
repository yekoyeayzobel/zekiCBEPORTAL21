<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Engineering Elite</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --glass: rgba(255, 255, 255, 0.15);
            --glass-border: rgba(255, 255, 255, 0.2);
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body { 
            font-family: 'Poppins', sans-serif; 
            color: white;
            background-color: #000;
            overflow-x: hidden;
        }

        /* --- Scrolling Parallax Background --- */
        .scrolling-bg {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* Replace with your preferred high-res banking office image */
            background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), 
                        url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2000');
            background-attachment: fixed;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            z-index: -2;
        }

        /* --- Floating Birr Layer --- */
        #animation-container {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            pointer-events: none;
            z-index: -1;
        }
        .birr-note {
            position: absolute;
            opacity: 0.3;
            animation: float 12s linear infinite;
            color: var(--cbe-gold);
            font-weight: bold;
        }

        @keyframes float {
            0% { transform: translateY(110vh) rotate(0deg); left: var(--start-x); }
            100% { transform: translateY(-10vh) rotate(360deg); left: var(--end-x); }
        }

        /* --- Transparent Text Effect --- */
        .hero-section {
            height: 70vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 0 5%;
        }

        .transparent-text {
            font-size: 5rem;
            font-weight: 800;
            text-transform: uppercase;
            background: url('https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=1000');
            background-size: cover;
            background-position: center;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 5px 15px rgba(0,0,0,0.5));
            line-height: 1;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            letter-spacing: 5px;
            color: var(--cbe-gold);
            margin-top: 20px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
        }

        /* --- Glassmorphism Grid --- */
        .container { max-width: 1300px; margin: -100px auto 100px; padding: 0 20px; }
        
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 40px;
        }

        .dev-card {
            background: var(--glass);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--glass-border);
            border-radius: 24px;
            padding: 40px 20px;
            text-align: center;
            transition: 0.5s ease;
        }

        .dev-card:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-15px);
            border-color: var(--cbe-gold);
        }

        .image-wrapper {
            width: 140px; height: 140px;
            margin: 0 auto 25px;
            border-radius: 50%;
            border: 3px solid var(--cbe-gold);
            padding: 5px;
            background: rgba(0,0,0,0.3);
        }

        .image-wrapper img {
            width: 100%; height: 100%;
            object-fit: cover;
            border-radius: 50%;
            filter: grayscale(30%);
            transition: 0.3s;
        }

        .dev-card:hover img { filter: grayscale(0%); }

        .dev-card h3 { font-size: 1.6rem; margin-bottom: 5px; color: white; }
        .dev-card .role { color: var(--cbe-gold); font-size: 0.8rem; letter-spacing: 2px; text-transform: uppercase; }
        
        .id-badge {
            display: inline-block;
            margin-top: 15px;
            padding: 5px 15px;
            background: rgba(75, 0, 130, 0.6);
            border-radius: 8px;
            font-family: monospace;
            font-size: 0.9rem;
        }

        footer {
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(10px);
            padding: 60px 0;
            text-align: center;
            border-top: 1px solid var(--glass-border);
        }
    </style>
</head>
<body>

    <div class="scrolling-bg"></div>
    <div id="animation-container"></div>

    <section class="hero-section">
        <h1 class="transparent-text">CBE ENGINEERS</h1>
        <p class="hero-subtitle">THE ARCHITECTS OF INNOVATION</p>
    </section>

    <div class="container">
        <div class="team-grid">
            
            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/yekoye.jpg" alt="Yekoye Ayzobel">
                </div>
                <h3>Yekoye Ayzobel</h3>
                <p class="role">Lead FullStack Development</p>
                <div class="id-badge">ID: 1638/16</div>
            </div>

            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/daniel.jpg" alt="Daniel Tesema">
                </div>
                <h3>Daniel Tesema</h3>
                <p class="role">Backend Architect</p>
                <div class="id-badge">ID: 1703362</div>
            </div>

            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/mekuriawu.jpg" alt="Mekuriawu Andualem">
                </div>
                <h3>Mekuriawu Andualem</h3>
                <p class="role">Cloud & Security</p>
                <div class="id-badge">ID: 1087/16</div>
            </div>

            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/kidist.jpg" alt="Kidist Tesfaye">
                </div>
                <h3>Kidist Tesfaye</h3>
                <p class="role">Creative UX Director</p>
                <div class="id-badge">ID: 0973/16</div>
            </div>

            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/desalegn.jpg" alt="Desalegn Manaye">
                </div>
                <h3>Desalegn Manaye</h3>
                <p class="role">Data Infrastructure</p>
                <div class="id-badge">ID: 0560/16</div>
            </div>

            <div class="dev-card">
                <div class="image-wrapper">
                    <img src="image/betelihem.jpg" alt="Betelihem Nigus">
                </div>
                <h3>Betelihem Nigus</h3>
                <p class="role">Operations Specialist</p>
                <div class="id-badge">ID: 4152/16</div>
            </div>

        </div>
    </div>

    

    <footer>
        <p style="opacity: 0.6">&copy; 2026 Commercial Bank of Ethiopia</p>
        <p style="color: var(--cbe-gold); margin-top: 10px; font-weight: 600;">INTEGRITY | SERVICE | EMPOWERMENT</p>
    </footer>

    <script>
        function createBirrAnimation() {
            const container = document.getElementById('animation-container');
            const symbols = ['??', 'ETB', '200']; 
            for(let i = 0; i < 12; i++) {
                const note = document.createElement('div');
                note.className = 'birr-note';
                const startX = Math.random() * 100;
                note.style.setProperty('--start-x', startX + '%');
                note.style.setProperty('--end-x', (startX + (Math.random()*20-10)) + '%');
                note.style.animationDelay = (Math.random() * 10) + 's';
                note.style.fontSize = (20 + Math.random() * 30) + 'px';
                note.innerText = symbols[Math.floor(Math.random() * symbols.length)];
                container.appendChild(note);
            }
        }
        createBirrAnimation();
    </script>
</body>
</html>