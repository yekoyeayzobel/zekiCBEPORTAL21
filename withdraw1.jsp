<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Professional Withdrawal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --white: #ffffff;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; overflow-x: hidden; background: #f4f7fa; }

        /* --- 5 Image Scrolling Background --- */
        .hero-slider {
            position: fixed; width: 100%; height: 100vh;
            z-index: -1; top: 0; left: 0;
        }
        .slide {
            position: absolute; width: 100%; height: 100%;
            background-size: cover; background-position: center;
            opacity: 0; animation: fadeSlider 25s infinite;
        }
        /* Replace these URLs with your local images or high-res banking photos */
        .s1 { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?q=80&w=1600'); animation-delay: 0s; }
        .s2 { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1600'); animation-delay: 5s; }
        .s3 { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1550565118-3a14e8d0386f?q=80&w=1600'); animation-delay: 10s; }
        .s4 { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1620714223084-8fcacc6dfd8d?q=80&w=1600'); animation-delay: 15s; }
        .s5 { background-image: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1450101499163-c8848c66ca85?q=80&w=1600'); animation-delay: 20s; }

        @keyframes fadeSlider {
            0%, 20% { opacity: 1; }
            25%, 100% { opacity: 0; }
        }

        /* --- Professional Header --- */
        header {
            background: var(--white);
            padding: 10px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            position: sticky; top: 0; z-index: 100;
        }
        .logo-area { display: flex; align-items: center; gap: 15px; }
        .logo-area img { height: 60px; }
        .logo-text h1 { color: var(--cbe-purple); font-size: 1.2rem; }
        .logo-text p { font-size: 0.8rem; color: #666; font-style: italic; }

        /* --- Nav --- */
        nav { background: var(--cbe-purple); }
        nav ul { display: flex; list-style: none; justify-content: center; }
        nav ul li a { color: white; text-decoration: none; padding: 15px 20px; display: block; font-size: 0.85rem; transition: 0.3s; }
        nav ul li a:hover { color: var(--cbe-gold); background: rgba(255,255,255,0.1); }

        /* --- Dynamic Withdraw Form --- */
        .withdraw-container {
            min-height: 80vh; display: flex; flex-direction: column; justify-content: center; align-items: center; padding: 20px;
        }
        .dynamic-greeting { color: white; margin-bottom: 20px; text-shadow: 2px 2px 4px rgba(0,0,0,0.5); font-size: 1.5rem; text-align: center; }
        
        .glass-card {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 40px; border-radius: 20px;
            width: 100%; max-width: 450px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        }
        .glass-card h2 { color: var(--cbe-purple); text-align: center; margin-bottom: 20px; border-bottom: 2px solid var(--cbe-gold); display: inline-block; width: 100%; padding-bottom: 10px; }

        .input-group { margin-bottom: 15px; }
        .input-group label { display: block; font-size: 0.8rem; font-weight: 600; margin-bottom: 5px; color: #333; }
        .input-group input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1rem; }
        .input-group input:focus { border-color: var(--cbe-purple); outline: none; box-shadow: 0 0 5px rgba(75,0,130,0.2); }

        .btn-submit { background: var(--cbe-purple); color: white; border: none; width: 100%; padding: 15px; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 1rem; transition: 0.3s; margin-top: 10px; }
        .btn-submit:hover { background: #310055; transform: translateY(-2px); }

        /* --- Footer --- */
        footer { background: #1a1a1a; color: white; text-align: center; padding: 30px; font-size: 0.8rem; }
    </style>
</head>
<body>

    <div class="hero-slider">
        <div class="slide s1"></div>
        <div class="slide s2"></div>
        <div class="slide s3"></div>
        <div class="slide s4"></div>
        <div class="slide s5"></div>
    </div>

    <header>
        <div class="logo-area">
            <img src="image/Logo.png" alt="CBE Logo" >
            <div class="logo-text">
                <h1>COMMERCIAL BANK OF ETHIOPIA</h1>
                <p>The Bank You Can Always Rely On</p>
            </div>
        </div>
        <a href="index.html"><img src="image/home1.gif" alt="Home" style="height: 40px;"></a>
    </header>

    <nav>
        <ul>
            <li><a href="create.html">NEW ACCOUNT</a></li>
            <li><a href="balance1.jsp">BALANCE</a></li>
            <li><a href="deposit1.jsp">DEPOSIT</a></li>
            <li><a href="withdraw1.jsp" style="color:var(--cbe-gold)">WITHDRAW</a></li>
            <li><a href="transfer1.jsp">TRANSFER</a></li>
            <li><a href="closeac1.jsp">CLOSE A/C</a></li>
            <li><a href="about.jsp">ABOUT US</a></li>
        </ul>
    </nav>

    <div class="withdraw-container">
        <div id="greeting" class="dynamic-greeting">Welcome to CBE Secure Banking</div>

        <div class="glass-card">
            <h2>Withdraw Funds</h2>

            <% if(request.getAttribute("msg") != null) { %>
                <div style="background:#d4edda; color:#155724; padding:10px; border-radius:5px; margin-bottom:15px; font-size:0.8rem; text-align:center;">
                    <%= request.getAttribute("msg") %>
                </div>
            <% } %>

            <form name="F1" onsubmit="return validateWithdraw(this)" action="WithdrawAction.jsp" method="post">
                <div class="input-group">
                    <label>ACCOUNT NUMBER</label>
                    <input type="text" name="accountno" id="acc" maxlength="13" placeholder="1000XXXXXXXXX" oninput="this.value = this.value.replace(/\D/g,'')">
                </div>
                <div class="input-group">
                    <label>USERNAME</label>
                    <input type="text" name="username" required>
                </div>
                <div class="input-group">
                    <label>PASSWORD</label>
                    <input type="password" name="password" required>
                </div>
                <div class="input-group">
                    <label>AMOUNT (ETB)</label>
                    <input type="number" name="amount" id="amt" step="0.01" placeholder="0.00">
                </div>
                
                <button type="submit" class="btn-submit">CONFIRM WITHDRAWAL</button>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Commercial Bank of Ethiopia. All Rights Reserved.</p>
        <p style="color: #777; margin-top: 5px;">Regulated by the National Bank of Ethiopia.</p>
    </footer>

    <script>
        // 1. Dynamic Greeting based on Ethiopia Time
        function updateGreeting() {
            const now = new Date();
            const hours = now.getHours();
            let greet = "Welcome to CBE Secure Banking";
            
            if (hours < 12) greet = "☀️ Good Morning! Ready for your transaction?";
            else if (hours < 17) greet = "🌤️ Good Afternoon! Safe banking starts here.";
            else greet = "🌙 Good Evening! CBE is here for you 24/7.";
            
            document.getElementById('greeting').innerText = greet;
        }

        // 2. Professional Validation
        function validateWithdraw(form) {
            const acc = form.accountno.value;
            const amt = form.amount.value;

            if (!/^\d+$/.test(acc)) {
    alert("Error: Please enter numbers only.");
    return false;
}
            if (amt <= 0 || isNaN(amt)) {
                alert("Please enter a valid withdrawal amount.");
                return false;
            }
            
            // Show "Processing" state on button
            const btn = document.querySelector('.btn-submit');
            btn.innerText = "Processing Security Check...";
            btn.style.opacity = "0.7";
            return true;
        }

        window.onload = updateGreeting;
    </script>
</body>
</html>