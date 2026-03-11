<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Employee Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --cbe-dark: #2c004d;
            --white: #ffffff;
            --bg-light: #f4f7fa;
            --text-muted: #888;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background: var(--bg-light); color: #333; line-height: 1.6; }

        /* --- Professional Top Utility Bar --- */
        .top-bar {
            background: var(--cbe-dark);
            color: white;
            padding: 8px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
        }
        .top-bar i { color: var(--cbe-gold); margin-right: 5px; }

        /* --- Main Header Section --- */
        header {
            background: var(--white);
            padding: 15px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            position: relative;
            z-index: 10;
        }
        .logo-area { display: flex; align-items: center; gap: 15px; }
        .logo-area h1 { color: var(--cbe-purple); font-size: 1.6rem; font-weight: 700; text-transform: uppercase; }
        .logo-area span { color: var(--cbe-gold); }
        .server-info { text-align: right; }
        .server-info p { font-size: 0.7rem; color: var(--text-muted); text-transform: uppercase; }
        #serverTime { font-weight: 600; color: var(--cbe-purple); font-size: 0.9rem; }

        /* --- Advanced Navigation --- */
        nav { 
            background: var(--cbe-purple); 
            sticky; top: 0; z-index: 100;
            border-bottom: 3px solid var(--cbe-gold);
        }
        nav ul { list-style: none; display: flex; justify-content: center; }
        nav ul li { position: relative; }
        nav ul li a {
            color: white; text-decoration: none; padding: 18px 25px;
            display: block; font-size: 0.85rem; font-weight: 500; 
            text-transform: uppercase; transition: all 0.3s ease;
        }
        nav ul li a:hover { background: rgba(255,255,255,0.15); color: var(--cbe-gold); }
        nav ul li a.active { border-bottom: 3px solid var(--cbe-gold); margin-bottom: -3px; }

        /* --- Hero Slider (Keep original logic) --- */
        .hero-slider { width: 100%; height: 400px; position: relative; overflow: hidden; }
        .slides { display: flex; width: 500%; height: 100%; animation: slideAnimation 25s infinite ease-in-out; }
        .slide { width: 20%; height: 100%; background-size: cover; background-position: center; display: flex; align-items: center; justify-content: center; }
        .slide-content { background: rgba(0, 0, 0, 0.7); color: white; padding: 40px; border-radius: 4px; text-align: center; max-width: 600px; border-left: 5px solid var(--cbe-gold); }
        .slide-content h2 { color: var(--cbe-gold); font-size: 2rem; margin-bottom: 10px; }

        @keyframes slideAnimation {
            0%, 18% { transform: translateX(0); }
            20%, 38% { transform: translateX(-20%); }
            40%, 58% { transform: translateX(-40%); }
            60%, 78% { transform: translateX(-60%); }
            80%, 98% { transform: translateX(-80%); }
        }

        /* --- Layout Container --- */
        .container {
            display: grid; grid-template-columns: 280px 1fr 280px;
            gap: 30px; padding: 50px 5%; max-width: 1400px; margin: 0 auto;
        }
        .card { background: var(--white); padding: 30px; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); }

        /* --- Form Styling --- */
        .balance-form h2 { color: var(--cbe-purple); margin-bottom: 25px; text-align: center; font-weight: 700; position: relative;}
        .balance-form h2::after { content: ''; width: 50px; height: 3px; background: var(--cbe-gold); position: absolute; bottom: -8px; left: 50%; transform: translateX(-50%); }
        .input-group { margin-bottom: 20px; }
        .input-group label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 0.85rem; color: #555; }
        .input-group input { width: 100%; padding: 12px 15px; border: 1.5px solid #ececec; border-radius: 5px; outline: none; transition: 0.3s; font-family: inherit; }
        .input-group input:focus { border-color: var(--cbe-purple); box-shadow: 0 0 8px rgba(75,0,130,0.1); }
        .btn-submit { background: var(--cbe-purple); color: white; border: none; padding: 14px; border-radius: 5px; cursor: pointer; flex: 2; font-weight: 700; transition: 0.3s; }
        .btn-submit:hover { background: var(--cbe-dark); transform: translateY(-2px); }
        .btn-clear { background: #f8f8f8; border: 1px solid #ddd; padding: 14px; border-radius: 5px; cursor: pointer; flex: 1; font-weight: 600; }

        /* --- Professional Footer --- */
        footer { background: #1a1a1a; color: #f1f1f1; padding: 60px 5% 20px; margin-top: 60px; }
        .footer-grid {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1.5fr;
            gap: 40px; max-width: 1400px; margin: 0 auto; padding-bottom: 40px;
        }
        .footer-section h4 { color: var(--cbe-gold); margin-bottom: 20px; font-size: 1rem; text-transform: uppercase; }
        .footer-section p { font-size: 0.85rem; color: #aaa; margin-bottom: 15px; }
        .footer-links { list-style: none; }
        .footer-links li { margin-bottom: 10px; }
        .footer-links li a { color: #aaa; text-decoration: none; font-size: 0.85rem; transition: 0.3s; }
        .footer-links li a:hover { color: white; padding-left: 5px; }
        .contact-info li { font-size: 0.85rem; margin-bottom: 10px; color: #aaa; display: flex; align-items: center; gap: 10px; }
        .contact-info i { color: var(--cbe-gold); width: 20px; }
        
        .footer-bottom {
            border-top: 1px solid #333; padding-top: 20px; text-align: center;
            font-size: 0.75rem; color: #777; display: flex; justify-content: space-between; align-items: center;
        }
        .social-icons { display: flex; gap: 15px; }
        .social-icons a { color: white; background: #333; width: 35px; height: 35px; display: flex; align-items: center; justify-content: center; border-radius: 50%; transition: 0.3s; }
        .social-icons a:hover { background: var(--cbe-purple); color: var(--cbe-gold); }
    </style>
</head>
<body>

    <div class="top-bar">
        <div><i class="fas fa-shield-alt"></i> Internal Secure Employee Portal</div>
        <div>
            <span style="margin-right: 20px;"><i class="fas fa-phone-alt"></i> IT Support: 8888</span>
            <span><i class="fas fa-globe"></i> Ethiopia (EN)</span>
        </div>
    </div>

    <header>
        <div class="logo-area">
            <img src="image/Logo.png" alt="CBE Logo" width="55">
            <h1>COMMERCIAL BANK OF <span>ETHIOPIA</span></h1>
        </div>
        <div class="server-info">
            <p>System Local Time</p>
            <div id="serverTime">Loading...</div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="index.html">Dashboard</a></li>
            <li><a href="create.html">New Account</a></li>
            <li><a href="balance1.jsp" class="active">Balance</a></li>
            <li><a href="deposit1.jsp">Deposit</a></li>
            <li><a href="withdraw1.jsp">Withdraw</a></li>
            <li><a href="transfer1.jsp">Transfer</a></li>
            <li><a href="about.jsp">About Us</a></li>
        </ul>
    </nav>

    <div class="hero-slider">
        <div class="slides">
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1556742044-3c52d6e88c62?q=80&w=1600');">
                <div class="slide-content"><h2>Digital Excellence</h2><p>Empowering Ethiopia through modern financial technology.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1579621970588-a35d0e7ab9b6?q=80&w=1600');">
                <div class="slide-content"><h2>Secure Savings</h2><p>Your trust is our greatest asset. Your money is safe with us.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1600');">
                <div class="slide-content"><h2>24/7 Service</h2><p>Access your accounts anytime, anywhere across the nation.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1521791136064-7986c292321d?q=80&w=1600');">
                <div class="slide-content"><h2>Economic Growth</h2><p>Supporting local businesses and national development projects.</p></div>
            </div>
            <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?q=80&w=1600');">
                <div class="slide-content"><h2>CBE Birr</h2><p>Experience the convenience of mobile banking at your fingertips.</p></div>
            </div>
        </div>
    </div>

    <div class="container">
        <aside class="card">
            <h4 style="color: var(--cbe-purple); margin-bottom: 15px; border-bottom: 2px solid var(--cbe-gold);">Staff Links</h4>
            <ul class="footer-links">
                <li style="margin-bottom: 10px;"><a href="#" style="color: #444;">Operation Manual</a></li>
                <li style="margin-bottom: 10px;"><a href="#" style="color: #444;">Compliance Policy</a></li>
                <li style="margin-bottom: 10px;"><a href="#" style="color: #444;">Daily Rates API</a></li>
                <li style="margin-bottom: 10px;"><a href="#" style="color: #444;">Report Issue</a></li>
            </ul>
        </aside>

        <main class="card balance-form">
            <h2>BALANCE INQUIRY</h2>
            
            <% if(request.getAttribute("balance") != null) { %>
                <div style="background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; color: #0056b3; font-weight: bold; text-align: center; border: 1px solid #b6d4fe;">
                    <i class="fas fa-check-circle"></i> Current Balance: <%= request.getAttribute("balance") %> ETB
                </div>
            <% } %>

            <form name="F1" onsubmit="return validateForm(this)" action="querybalance.jsp" method="post">
                <div class="input-group">
                    <label><i class="fas fa-hashtag"></i> Account Number</label>
                    <input type="text" name="accountno" placeholder="Enter 13-digit account number">
                </div>
                <div class="input-group">
                    <label><i class="fas fa-user-tie"></i>  Username</label>
                    <input type="text" name="username" placeholder="Staff Username">
                </div>
                <div class="input-group">
                    <label><i class="fas fa-lock"></i> Authorization Password</label>
                    <input type="password" name="password" placeholder="••••••••">
                </div>
                
                <div style="display: flex; gap: 10px;">
                    <button type="submit" class="btn-submit">INQUIRE BALANCE</button>
                    <button type="reset" class="btn-clear">CLEAR</button>
                </div>
            </form>
        </main>

        <aside class="card" style="text-align: center;">
            <h4 style="color: var(--cbe-purple);">Security Reminder</h4>
            <div style="font-size: 3rem; color: var(--cbe-gold); margin: 15px 0;"><i class="fas fa-user-shield"></i></div>
            <p style="font-size: 0.8rem; color: #666;">Never share employee credentials. Ensure the customer's identity is verified before processing inquiries.</p>
        </aside>
    </div>

    <footer>
        <div class="footer-grid">
            <div class="footer-section">
                <h4>About CBE</h4>
                <p>The Commercial Bank of Ethiopia is the leading bank in Ethiopia, established in 1942. We are committed to being a world-class commercial bank by 2025.</p>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="footer-section">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms & Conditions</a></li>
                    <li><a href="#">Staff Webmail</a></li>
                    <li><a href="#">Corporate Website</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h4>Support</h4>
                <ul class="footer-links">
                    <li><a href="#">IT Help Desk</a></li>
                    <li><a href="#">Security Center</a></li>
                    <li><a href="#">Fraud Reporting</a></li>
                    <li><a href="#">System Status</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h4>Contact Us</h4>
                <ul class="contact-info">
                    <li><i class="fas fa-map-marker-alt"></i> CBE HQ, Addis Ababa, ET</li>
                    <li><i class="fas fa-phone-alt"></i> 951 (Customer Service)</li>
                    <li><i class="fas fa-envelope"></i> support@cbe.com.et</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Commercial Bank of Ethiopia. All Rights Reserved.</p>
            <p>Designed for Secure Internal Operations</p>
        </div>
    </footer>

    <script>
        function updateClock() {
            const now = new Date();
            document.getElementById('serverTime').innerHTML = now.toLocaleString();
        }
        setInterval(updateClock, 1000);
        updateClock();
    </script>
</body>
</html>