<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us | Commercial Bank of Ethiopia</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --white: #ffffff;
            --bg-light: #f4f7fa;
            --text-gray: #555;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background: var(--bg-light); color: #333; overflow-x: hidden; }

        /* --- Header & Navigation (Matching your previous pages) --- */
        header {
            background: var(--white);
            padding: 15px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        .logo-area { display: flex; align-items: center; gap: 15px; }
        .logo-area h1 { color: var(--cbe-purple); font-size: 1.5rem; text-transform: uppercase; font-weight: 700; }
        .logo-area span { color: var(--cbe-gold); }

        nav { background: var(--cbe-purple); border-bottom: 4px solid var(--cbe-gold); sticky; top: 0; z-index: 1000; }
        nav ul { list-style: none; display: flex; justify-content: center; }
        nav ul li a {
            color: white; text-decoration: none; padding: 20px 25px;
            display: block; font-size: 0.9rem; font-weight: 600; transition: 0.3s;
        }
        nav ul li a:hover { background: rgba(255,255,255,0.1); color: var(--cbe-gold); }

        /* --- Professional 5-Image Auto-Slider --- */
        .slider-wrapper {
            width: 100%; height: 500px; position: relative; overflow: hidden;
        }
        .slides {
            display: flex; width: 500%; height: 100%;
            animation: slideAuto 25s infinite ease-in-out;
        }
        .slide {
            width: 20%; height: 100%; background-size: cover; background-position: center;
            display: flex; align-items: center; justify-content: center; position: relative;
        }
        .slide::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.3));
        }
        .slide-text {
            position: relative; z-index: 2; color: white; text-align: center; max-width: 800px; padding: 20px;
        }
        .slide-text h2 { font-size: 3rem; color: var(--cbe-gold); margin-bottom: 10px; text-transform: uppercase; }
        .slide-text p { font-size: 1.2rem; font-weight: 300; }

        @keyframes slideAuto {
            0%, 18% { transform: translateX(0); }
            20%, 38% { transform: translateX(-20%); }
            40%, 58% { transform: translateX(-40%); }
            60%, 78% { transform: translateX(-60%); }
            80%, 98% { transform: translateX(-80%); }
        }

        /* --- About Content --- */
        .main-content { max-width: 1200px; margin: 60px auto; padding: 0 20px; }
        
        .section-header { text-align: center; margin-bottom: 50px; }
        .section-header h1 { font-size: 2.5rem; color: var(--cbe-purple); }
        .section-header div { width: 80px; height: 4px; background: var(--cbe-gold); margin: 10px auto; }

        .about-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 50px; align-items: center; margin-bottom: 80px;
        }
        .about-text h2 { color: var(--cbe-purple); margin-bottom: 20px; font-size: 1.8rem; }
        .about-text p { margin-bottom: 15px; line-height: 1.8; color: var(--text-gray); }

        /* --- International Focus Section --- */
        .international-stats {
            background: var(--cbe-purple); color: white; padding: 60px 5%;
            border-radius: 15px; display: grid; grid-template-columns: repeat(4, 1fr);
            text-align: center; gap: 20px; margin-bottom: 80px;
        }
        .stat-item h3 { font-size: 2.5rem; color: var(--cbe-gold); }
        .stat-item p { font-size: 0.9rem; opacity: 0.8; }

        /* --- Philosophy Cards --- */
        .philosophy-row {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px;
        }
        .p-card {
            background: white; padding: 40px; border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); border-bottom: 4px solid transparent;
            transition: 0.3s;
        }
        .p-card:hover { transform: translateY(-10px); border-bottom-color: var(--cbe-gold); }
        .p-card i { font-size: 2.5rem; color: var(--cbe-purple); margin-bottom: 20px; }
        .p-card h3 { margin-bottom: 15px; color: var(--cbe-purple); }

        /* --- Footer --- */
        footer { background: #1a1a1a; color: #aaa; padding: 60px 5% 30px; text-align: center; }
        .footer-logo h2 { color: white; margin-bottom: 20px; }
        .footer-logo span { color: var(--cbe-gold); }
    </style>
</head>
<body>

    <header>
        <div class="logo-area">
            <img src="image/Logo.png" alt="CBE Logo" width="60">
            <h1>COMMERCIAL BANK OF <span>ETHIOPIA</span></h1>
        </div>
        <div class="top-meta" style="font-size: 0.8rem; color: #888;">
            <i class="fas fa-globe"></i> International Banking Standard
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="index.html">HOME</a></li>
            <li><a href="create.html">NEW ACCOUNT</a></li>
            <li><a href="balance1.jsp">BALANCE</a></li>
            <li><a href="deposit1.jsp">DEPOSIT</a></li>
            <li><a href="withdraw1.jsp">WITHDRAW</a></li>
            <li><a href="transfer1.jsp">TRANSFER</a></li>
            <li><a href="developers.jsp">Developers</a></li>
             <li><a href="manager.jsp">Manager</a></li>
            <li><a href="about.jsp" style="color: var(--cbe-gold);">ABOUT US</a></li>
            
        </ul>
    </nav>

    <div class="slider-wrapper">
        <div class="slides">
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?q=80&w=1600');">
                <div class="slide-text"><h2>Global Reach</h2><p>Connecting Ethiopia to the international financial markets.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1454165833767-027ffea9e778?q=80&w=1600');">
                <div class="slide-text"><h2>Expert Advice</h2><p>Our story is one of resilience, growth, and customer success.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1551836022-d5d88e9218df?q=80&w=1600');">
                <div class="slide-text"><h2>Modern Innovation</h2><p>Leading the digital revolution in East African banking.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1560520653-9e0e4c89eb11?q=80&w=1600');">
                <div class="slide-text"><h2>Secure Future</h2><p>Your capital, protected by world-class security protocols.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1553729459-efe14ef6055d?q=80&w=1600');">
                <div class="slide-text"><h2>Infinite Possibilities</h2><p>The bank you can always rely on for your future growth.</p></div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="section-header">
            <h1>ABOUT OUR INSTITUTION</h1>
            <div></div>
            <p>Empowering Individuals to Master Their Capital Since 1942</p>
        </div>

        <div class="about-grid">
            <div class="about-image">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=600" alt="CBE Building" style="width: 100%; border-radius: 15px; box-shadow: 0 20px 40px rgba(0,0,0,0.1);">
            </div>
            <div class="about-text">
                <h2>The Infinite Difference</h2>
                <p>Infinite Bank, as part of the Commercial Bank of Ethiopia's digital initiative, is a leading online platform providing secure, fast, and reliable services worldwide.</p>
                <p>Traditional banks use your deposits to fund their growth. <strong>We help you use your deposits to fund yours.</strong> Our system allows you to build a pool of capital that grows 24/7, even while you use it for major life purchases.</p>
                <p>Founded on the principle that <em>"You should be the one who performs the banking function in your life,"</em> we provide the tools to make that a reality.</p>
            </div>
        </div>

        <div class="international-stats">
            <div class="stat-item"><h3>80+</h3><p>Years of Service</p></div>
            <div class="stat-item"><h3>1,900+</h3><p>Branches Globally</p></div>
            <div class="stat-item"><h3>40M+</h3><p>Trusted Customers</p></div>
            <div class="stat-item"><h3>100%</h3><p>Digital Security</p></div>
        </div>

        <div class="philosophy-row">
            <div class="p-card">
                <i class="fas fa-history"></i>
                <h3>Our Story</h3>
                <p>Founded to disrupt the institution-first model, we've evolved into a global powerhouse protecting individual purchasing power.</p>
            </div>
            <div class="p-card">
                <i class="fas fa-shield-alt"></i>
                <h3>Security First</h3>
                <p>International grade encryption ensuring your assets are protected against global market volatility.</p>
            </div>
            <div class="p-card">
                <i class="fas fa-chart-line"></i>
                <h3>Core Mandate</h3>
                <p>To provide financial sovereignty to every hard-working individual through mastered capital management.</p>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-logo">
            <h2>COMMERCIAL BANK OF <span>ETHIOPIA</span></h2>
        </div>
        <p>Official International Banking Portal</p>
        <p style="margin-top: 20px;">Ready to take control? <strong><a href="https://cbeib.cbe.com.et/" target="_blank" style="color: var(--cbe-gold);">Join Internet Banking</a></strong></p>
        <div style="margin-top: 40px; border-top: 1px solid #333; padding-top: 20px; font-size: 0.8rem;">
            &copy; 2026 CBE Online. All Rights Reserved.
        </div>
    </footer>

</body>
</html>