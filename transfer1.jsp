<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Fund Transfer</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --white: #ffffff;
            --dark-bg: #1a1a1a;
            --glass: rgba(255, 255, 255, 0.95);
            --success: #2ecc71;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background: #f0f2f5; overflow-x: hidden; }

        /* --- Dynamic Header --- */
        header {
            background: var(--white);
            padding: 10px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-left img { height: 60px; }
        .header-titles h1 { color: var(--cbe-purple); font-size: 1.4rem; letter-spacing: 1px; }
        
        .user-greeting { text-align: right; border-left: 2px solid var(--cbe-gold); padding-left: 15px; }
        .user-greeting span { font-size: 0.8rem; color: #666; display: block; }
        .user-greeting strong { color: var(--cbe-purple); font-size: 0.9rem; }

        /* --- Nav --- */
        nav { background: var(--cbe-purple); }
        nav ul { list-style: none; display: flex; justify-content: center; }
        nav ul li a { color: white; text-decoration: none; padding: 15px 20px; display: block; font-size: 0.85rem; transition: 0.3s; }
        nav ul li a:hover, nav ul li a.active { background: rgba(255,255,255,0.1); color: var(--cbe-gold); }

        /* --- Background Slider --- */
        .hero-slider { position: absolute; width: 100%; height: 100vh; z-index: -1; overflow: hidden; top: 0; }
        .slide { position: absolute; width: 100%; height: 100%; background-size: cover; background-position: center; opacity: 0; animation: fadeSlider 25s infinite; filter: brightness(0.7); }
        .s1 { background-image: url('https://images.unsplash.com/photo-1633151209234-226e6378e9a1?q=80&w=1600'); animation-delay: 0s; }
        .s2 { background-image: url('https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1600'); animation-delay: 5s; }
        .s3 { background-image: url('https://images.unsplash.com/photo-1556742044-3c52d6e88c62?q=80&w=1600'); animation-delay: 10s; }
        .s4 { background-image: url('https://images.unsplash.com/photo-1460925895917-afdab827c52f?q=80&w=1600'); animation-delay: 15s; }
        .s5 { background-image: url('https://images.unsplash.com/photo-1579621970588-a35d0e7ab9b6?q=80&w=1600'); animation-delay: 20s; }

        @keyframes fadeSlider { 0%, 20% { opacity: 1; } 25%, 100% { opacity: 0; } }

        /* --- Transfer Card --- */
        .main-content { min-height: 80vh; display: flex; justify-content: center; align-items: center; padding: 40px 20px; }
        .transfer-card {
            background: var(--glass);
            backdrop-filter: blur(12px);
            padding: 40px; border-radius: 24px;
            width: 100%; max-width: 550px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.3);
        }

        .transfer-card h2 { color: var(--cbe-purple); text-align: center; margin-bottom: 30px; }
        
        .form-group { margin-bottom: 20px; position: relative; }
        .form-group label { display: block; font-size: 0.75rem; font-weight: 700; color: var(--cbe-purple); margin-bottom: 8px; text-transform: uppercase; }
        .form-group input {
            width: 100%; padding: 14px; border: 2px solid #e1e1e1; border-radius: 12px;
            font-family: inherit; font-size: 1rem; transition: 0.3s;
        }
        .form-group input:focus { border-color: var(--cbe-purple); outline: none; }
        
        /* Validation Hint */
        .hint { font-size: 0.7rem; color: #888; margin-top: 4px; display: block; }

        .btn-submit { 
            background: var(--cbe-purple); color: white; border: none; padding: 16px; 
            border-radius: 12px; cursor: pointer; width: 100%; font-weight: 600; 
            transition: 0.3s; font-size: 1rem;
        }
        .btn-submit:hover { background: #310055; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(75,0,130,0.3); }
        .btn-submit:disabled { background: #ccc; cursor: not-allowed; }

        footer { background: var(--dark-bg); color: #888; padding: 40px 5%; text-align: center; }
    </style>
</head>
<body>

    <header>
        <div class="header-left">
            <img src="image/Logo.png" alt="CBE">
            <div class="header-titles">
                <h1>COMMERCIAL BANK OF ETHIOPIA</h1>
            </div>
        </div>
        <div class="user-greeting" id="dynamicGreeting">
            <span id="dayPart">Good Day,</span>
            <strong id="userNameDisplay">Valued Customer</strong>
        </div>
    </header>

    <nav>
        <ul>
            <ul>
            <li><a href="create.html">NEW ACCOUNT</a></li>
            <li><a href="balance1.jsp">BALANCE</a></li>
            <li><a href="deposit1.jsp">DEPOSIT</a></li>
            <li><a href="withdraw1.jsp">WITHDRAW</a></li>
            <li><a href="transfer1.jsp">TRANSFER</a></li>
            <li><a class="active" href="closeac1.jsp">CLOSE A/C</a></li>
            <li><a href="about.jsp">ABOUT US</a></li>
        </ul>
        </ul>
    </nav>

    <div class="hero-slider">
        <div class="slide s1"></div>
        <div class="slide s2"></div>
        <div class="slide s3"></div>
        <div class="slide s4"></div>
        <div class="slide s5"></div>
    </div>

    <div class="main-content">
        <div class="transfer-card">
            <h2>Internal Fund Transfer</h2>
            <% if(request.getAttribute("error") != null) { %>
    <div style="background: #fee; color: #b30000; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center; border: 1px solid #b30000;">
        <strong>?? Error:</strong> <%= request.getAttribute("error") %>
    </div>
<% } %>
            <form id="transferForm" action="TransferAction.jsp" method="post" onsubmit="return handleProcessing(this)">
                
                <div class="form-group">
                    <label>Source Account</label>
                    <input type="text" name="fromaccount" id="fromAcc" maxlength="13" placeholder="1000..." oninput="this.value = this.value.replace(/\D/g,'')">
                    <span class="hint">CBE Standard: 13 digits</span>
                </div>

                <div class="form-group">
                    <label>Destination Account</label>
                    <input type="text" name="toaccount" id="toAcc" maxlength="13" placeholder="1000..." oninput="this.value = this.value.replace(/\D/g,'')">
                    <span class="hint">Recipient's 13-digit account</span>
                </div>

                <div class="form-group">
                    <label>Amount (ETB)</label>
                    <input type="number" name="amount" id="amt" step="0.01" min="1" placeholder="0.00">
                </div>

                <div class="form-group">
                    <label>Transaction Authorization (PIN/Password)</label>
                    <input type="password" name="password" required placeholder="????????">
                </div>
                
                <button type="submit"name="submit" class="btn-submit" id="submitBtn">EXECUTE TRANSFER</button>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 Commercial Bank of Ethiopia. All Rights Reserved. <br> 
        <small>Regulated by the National Bank of Ethiopia.</small></p>
    </footer>

    <script>
        // 1. Dynamic Greeting based on Ethiopia Time
        function setGreeting() {
            const hour = new Date().getHours();
            const greetingElem = document.getElementById('dayPart');
            if (hour < 12) greetingElem.innerText = "Good Morning,";
            else if (hour < 17) greetingElem.innerText = "Good Afternoon,";
            else greetingElem.innerText = "Good Evening,";
            
    const sessionUser = "<%= session.getAttribute("EmpId") != null ? session.getAttribute("employeeName") : "Guest User" %>";
    
    document.getElementById('userNameDisplay').innerText = sessionUser;

        }

        // 2. Professional Processing State
        function handleProcessing(form) {
            const btn = document.getElementById('submitBtn');
            const from = document.getElementById('fromAcc').value;
            const to = document.getElementById('toAcc').value;
            const amount = document.getElementById('amt').value;

            // Strict Validation
             if (!/^\d+$/.test(acc)) {
    alert("Error: Please enter numbers only.");
    return false;
}
            if (from === to) {
                alert("?? Error: Source and Destination accounts cannot be identical.");
                return false;
            }
            if (amount <= 0) {
                alert("?? Error: Please enter a valid transfer amount.");
                return false;
            }

            // Visual Dynamic Feedback
            btn.disabled = true;
            btn.innerText = "Verifying Transaction...";
            btn.style.background = "#8e44ad";
            
            // In a real app, the form would submit here. 
            // We return true to allow the action="TransferServlet" to proceed.
            return true; 
        }

        window.onload = setGreeting;
    </script>
</body>
</html>