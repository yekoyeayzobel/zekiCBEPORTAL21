<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Secure Termination</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --danger: #d93025;
            --text-muted: #5f6368;
            --glass: rgba(255, 255, 255, 0.94);
        }

        body, html { 
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* --- Animated Background Slideshow --- */
        .background-slideshow {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .background-slideshow li {
            position: absolute;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            opacity: 0;
            animation: imageAnimation 30s linear infinite;
        }

        .background-slideshow li:nth-child(1) { background-image: url('https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?q=80&w=2070'); }
        .background-slideshow li:nth-child(2) { background-image: url('https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?q=80&w=2070'); animation-delay: 6s; }
        .background-slideshow li:nth-child(3) { background-image: url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2040'); animation-delay: 12s; }
        .background-slideshow li:nth-child(4) { background-image: url('https://images.unsplash.com/photo-1554469384-e58fac16e23a?q=80&w=1974'); animation-delay: 18s; }
        .background-slideshow li:nth-child(5) { background-image: url('https://images.unsplash.com/photo-1633156189779-2143ca3ee637?q=80&w=2070'); animation-delay: 24s; }

        @keyframes imageAnimation {
            0% { opacity: 0; }
            8% { opacity: 1; }
            20% { opacity: 1; }
            28% { opacity: 0; }
            100% { opacity: 0; }
        }

        .overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(0,0,0,0.7) 0%, rgba(75,0,130,0.4) 100%);
            z-index: -1;
        }

        /* --- Attractive Header --- */
        #header { 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 8%; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            border-bottom: 4px solid var(--cbe-gold);
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        .header-logo-section { display: flex; align-items: center; gap: 15px; }
        .header-logo-section img { height: 55px; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1)); }
        .bank-name h1 { margin: 0; font-size: 1.4rem; color: var(--cbe-purple); letter-spacing: -0.5px; }
        .bank-name p { margin: 0; font-size: 0.75rem; color: var(--text-muted); font-weight: 600; text-transform: uppercase; }

        /* --- Navigation --- */
        #navigation { background: var(--cbe-purple); padding: 0 8%; box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
        #navigation ul { list-style: none; display: flex; margin: 0; padding: 0; gap: 5px; }
        #navigation li a { 
            color: white; text-decoration: none; padding: 18px 20px; 
            display: block; font-size: 0.8rem; font-weight: 600; 
            transition: 0.3s; border-bottom: 3px solid transparent;
        }
        #navigation li a:hover, #navigation li a.active { 
            background: rgba(255,255,255,0.1); 
            border-bottom: 3px solid var(--cbe-gold);
            color: var(--cbe-gold);
        }

        /* --- Main Content --- */
        .content-area { flex: 1; }
        .page-container {
            max-width: 1100px;
            margin: 60px auto;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 50px;
            padding: 0 20px;
        }

        .info-panel { color: white; }
        .info-panel h1 { font-size: 3rem; font-weight: 800; line-height: 1.1; margin-bottom: 20px; }
        .info-panel p { font-size: 1.1rem; opacity: 0.9; margin-bottom: 30px; }

        .guide-item { 
            background: rgba(255,255,255,0.15); 
            padding: 15px 20px; border-radius: 12px; margin-bottom: 15px; 
            backdrop-filter: blur(8px); display: flex; align-items: center; gap: 15px;
            border: 1px solid rgba(255,255,255,0.2);
        }

        .close-card { 
            background: var(--glass);
            padding: 45px; border-radius: 25px; 
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
        }

        .form-group label { display: block; margin-bottom: 10px; font-weight: 700; font-size: 0.8rem; color: #444; }
        .input-wrapper { position: relative; margin-bottom: 25px; }
        .input-wrapper i { position: absolute; left: 18px; top: 16px; color: var(--cbe-purple); font-size: 1.1rem; }
        .input-wrapper input { 
            width: 100%; padding: 15px 15px 15px 50px; border: 1.5px solid #ddd; 
            border-radius: 12px; font-size: 1rem; box-sizing: border-box; transition: 0.3s;
        }
        .input-wrapper input:focus { border-color: var(--cbe-purple); outline: none; box-shadow: 0 0 0 4px rgba(75,0,130,0.1); }

        .btn-submit { 
            width: 100%; background: var(--cbe-purple); color: white; padding: 18px; 
            border: none; border-radius: 12px; font-weight: 700; cursor: pointer; 
            transition: 0.4s; font-size: 1rem; text-transform: uppercase; letter-spacing: 1px;
        }
        .btn-submit:hover { background: var(--danger); transform: translateY(-3px); box-shadow: 0 10px 20px rgba(217, 48, 37, 0.4); }

        /* --- Attractive Footer --- */
        footer {
            background: #1a1a1a;
            color: #ccc;
            padding: 40px 8% 20px;
            margin-top: 100px;
        }
        .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 50px; margin-bottom: 30px; }
        .footer-logo img { height: 40px; margin-bottom: 15px; filter: grayscale(1); }
        .footer-col h4 { color: white; margin-bottom: 20px; font-size: 1.1rem; border-left: 3px solid var(--cbe-gold); padding-left: 10px; }
        .footer-links { list-style: none; padding: 0; }
        .footer-links li { margin-bottom: 10px; font-size: 0.85rem; }
        .footer-links a { color: #888; text-decoration: none; transition: 0.3s; }
        .footer-links a:hover { color: var(--cbe-gold); }
        .copyright { text-align: center; padding-top: 20px; border-top: 1px solid #333; font-size: 0.75rem; color: #666; }

        @media (max-width: 900px) { .page-container { grid-template-columns: 1fr; } .footer-grid { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

    <ul class="background-slideshow">
        <li></li><li></li><li></li><li></li><li></li>
    </ul>
    <div class="overlay"></div>

    <header id="header">
        <div class="header-logo-section">
            <img src="image/Logo.png" alt="CBE Logo">
            <div class="bank-name">
                <h1>COMMERCIAL BANK OF ETHIOPIA</h1>
                <p>The Bank You Can Always Rely On</p>
            </div>
        </div>
        <div style="text-align: right; color: var(--cbe-purple); font-size: 0.8rem; font-weight: 700;">
            <i class="fas fa-headset"></i> 951 (Toll Free)
        </div>
    </header>

    <nav id="navigation">
        <ul>
            <li><a href="create.html">NEW ACCOUNT</a></li>
            <li><a href="balance1.jsp">BALANCE</a></li>
            <li><a href="deposit1.jsp">DEPOSIT</a></li>
            <li><a href="withdraw1.jsp">WITHDRAW</a></li>
            <li><a href="transfer1.jsp">TRANSFER</a></li>
            <li><a class="active" href="closeac1.jsp">CLOSE A/C</a></li>
            <li><a href="about.jsp">ABOUT US</a></li>
        </ul>
    </nav>

    <div class="content-area">
        <div class="page-container">
            <div class="info-panel">
                <h1>Secure Account Termination.</h1>
                <p>Your security is our priority. Closing an account requires strict identity verification to protect your financial history.</p>
                <div class="guidelines">
                    <div class="guide-item"><i class="fas fa-check-circle" style="color:var(--cbe-gold)"></i> Account Balance must be zero</div>
                    <div class="guide-item"><i class="fas fa-shield-alt" style="color:var(--cbe-gold)"></i> Manager approval required for finalization</div>
                </div>
            </div>

            <div class="close-card">
                <form name="F1" onsubmit="return dil(this)" action="close.jsp" method="post">
                    <div class="form-group">
                        <label>ACCOUNT NUMBER</label>
                        <div class="input-wrapper">
                            <i class="fas fa-university"></i>
                            <input type="text" name="accountno" placeholder="Enter-Digit Account No" autocomplete="off">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>USERNAME</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user-shield"></i>
                            <input type="text" name="username" placeholder="Associated Username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>PASSWORD</label>
                        <div class="input-wrapper">
                            <i class="fas fa-key"></i>
                            <input type="password" name="password" placeholder="????????">
                        </div>
                    </div>
                    <button type="submit" class="btn-submit">CONFIRM CLOSURE</button>
                </form>
                <div style="margin-top:20px; color:red; font-weight:bold; text-align:center;">
                    <% if(request.getAttribute("closeMsg")!=null) { out.print(request.getAttribute("closeMsg")); } %>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-grid">
            <div class="footer-col footer-logo">
                <img src="image/Logo.png" alt="CBE Logo">
                <p>Leading the way in Ethiopian banking since 1942. Committed to providing excellence and financial inclusion across the nation.</p>
            </div>
            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Customer Support</a></li>
                    <li><a href="#">Branch Locator</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Contact Us</h4>
                <ul class="footer-links">
                    <li><i class="fas fa-phone"></i> +251-11-5515004</li>
                    <li><i class="fas fa-envelope"></i> info@cbe.com.et</li>
                    <li><i class="fas fa-map-marker-alt"></i> Addis Ababa, Ethiopia</li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            &copy; 2026 Commercial Bank of Ethiopia. All Rights Reserved.
        </div>
    </footer>

    <script>
        function dil(form) {
            const acc = form.accountno.value.trim();
            const user = form.username.value.trim();
            const pass = form.password.value;

            if (!acc || !user || !pass) {
                alert("Please provide all required credentials for termination.");
                return false;
            }
           if (!/^\d+$/.test(acc)) {
    alert("Error: Please enter numbers only.");
    return false;
}
2. 
            return confirm("WARNING: This action is permanent. Do you wish to proceed with account closure?");
        }
    </script>
</body>
</html>