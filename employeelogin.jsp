<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE Staff Portal | Secure Login</title>
    <style>
        :root {
            --cbe-purple: #4e148c;
            --cbe-gold: #ffcc00;
            --cbe-dark: #2d0a54;
            --error-red: #ef4444;
            --success-green: #22c55e;
        }

        body, html {
            height: 100%; margin: 0;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            overflow: hidden; background-color: #000;
        }

        /* 1. Enhanced Smooth Slider */
        .bg-slider {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1;
        }
        .slide {
            position: absolute; width: 100%; height: 100%;
            background-size: cover; background-position: center;
            opacity: 0; transition: opacity 2s ease-in-out, transform 10s linear;
            transform: scale(1);
        }
        .slide.active { 
            opacity: 1; 
            transform: scale(1.1); /* Subtle zoom effect */
        }

        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(45,10,84,0.6) 0%, rgba(0,0,0,0.8) 100%);
            z-index: 0;
        }

        /* 2. Professional Glassmorphism Card */
        .main-container {
            position: relative; z-index: 1;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center; height: 100vh;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(15px);
            padding: 2.5rem; border-radius: 20px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            width: 90%; max-width: 400px;
            text-align: center; border: 1px solid rgba(255,255,255,0.3);
            border-top: 6px solid var(--cbe-gold);
            animation: fadeIn 1s ease-out;
        }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        
        /* Shake animation for validation errors */
        .shake { animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both; }
        @keyframes shake { 10%, 90% { transform: translate3d(-1px, 0, 0); } 20%, 80% { transform: translate3d(2px, 0, 0); } 30%, 50%, 70% { transform: translate3d(-4px, 0, 0); } 40%, 60% { transform: translate3d(4px, 0, 0); } }

        .logo-area img { width: 130px; margin-bottom: 0.5rem; filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1)); }
        h2 { color: var(--cbe-purple); margin: 5px 0; font-size: 1.5rem; font-weight: 800; }

        .dynamic-info { font-size: 0.85rem; color: #64748b; margin-bottom: 1.5rem; display: flex; align-items: center; justify-content: center; gap: 10px; }
        .status-dot { height: 8px; width: 8px; background-color: var(--success-green); border-radius: 50%; box-shadow: 0 0 8px var(--success-green); }

        /* 3. Input & Button Design */
        .input-group { text-align: left; margin-bottom: 1.2rem; position: relative; }
        label { display: block; margin-bottom: 0.4rem; color: var(--cbe-dark); font-weight: 600; font-size: 0.85rem; }
        
        input {
            width: 100%; padding: 14px; border: 1px solid #cbd5e1; border-radius: 10px;
            box-sizing: border-box; font-size: 1rem; transition: 0.3s; background: #f8fafc;
        }

        input:focus { outline: none; border-color: var(--cbe-purple); box-shadow: 0 0 0 4px rgba(78,20,140,0.1); background: #fff; }

        .login-btn {
            width: 100%; padding: 14px; background: var(--cbe-purple); color: white;
            border: none; border-radius: 10px; font-size: 1rem; font-weight: 700;
            cursor: pointer; transition: 0.4s; margin-top: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .login-btn:hover { background: var(--cbe-dark); transform: translateY(-2px); box-shadow: 0 10px 15px rgba(0,0,0,0.2); }
        .login-btn:active { transform: translateY(0); }

        #message { margin-top: 15px; font-size: 0.85rem; font-weight: 600; min-height: 20px; }

        .footer-info { margin-top: 30px; color: rgba(255,255,255,0.7); font-size: 0.75rem; text-align: center; line-height: 1.6; }
    </style>
</head>
<body>

    <div class="bg-slider">
        <div class="slide active" style="background-image: url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2070')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1554469384-e58fac16e23a?q=80&w=1974')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1560520653-9e0e4c89eb11?q=80&w=1973')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1444676632488-26a136c45b9b?q=80&w=2020')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1526303328194-ed255b3fe161?q=80&w=2070')"></div>
    </div>
    <div class="overlay"></div>

    <div class="main-container">
        <div class="login-card" id="card">
            <div class="logo-area">
                 <img src="image/Logo.png" alt="CBE Logo" onerror="this.src='https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Commercial_Bank_of_Ethiopia_logo.png/220px-Commercial_Bank_of_Ethiopia_logo.png'">
                <h2>STAFF PORTAL</h2>
            </div>
            
            <div class="dynamic-info">
                <div class="status-dot"></div>
                <span id="sysStatus">System Secure</span>
                <span>|</span>
                <span id="currentDateTime"></span>
            </div>

            <form id="loginForm"action="todayemployee.jsp">
                <script>
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');
        const messageDiv = document.getElementById('message');
        const card = document.getElementById('card');

        if (error === 'invalid') {
            messageDiv.style.color = "#ef4444"; // Error Red
            messageDiv.innerText = "? Incorrect Employee ID or Password!";
            card.classList.add('shake');
        } else if (error === 'db_error') {
            messageDiv.style.color = "#ef4444";
            messageDiv.innerText = "?? Database Connection Error!";
        }
        setInterval(() => {
            const now = new Date();
            document.getElementById('currentDateTime').innerText = now.toLocaleString();
        }, 1000);
    };
</script>
                <div class="input-group">
                    <label>Employee ID</label>
                    <input type="text" id="username"name="id" placeholder="CBE/HQ/0000" autocomplete="off">
                </div>
                <div class="input-group">
                    <label>Secure Password</label>
                    <input type="password" name="pass"id="password" placeholder="????????">
                </div>
                <button type="submit" class="login-btn" id="loginBtn">Authorize Access</button>
                <div id="message"></div>
            </form>
        </div>
        
        <div class="footer-info">
            <strong>COMMERCIAL BANK OF ETHIOPIA</strong><br>
            &copy; 2026 | IT Infrastructure & Security Department <br>
            Unauthorized access is strictly prohibited and monitored.
        </div>
    </div>

   
</body>
</html>