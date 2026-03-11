<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Management Secure Access</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --cbe-purple: #4b2c6d;
            --cbe-purple-dark: #2d1a41;
            --cbe-gold: #fdb913;
            --text-main: #1a1a1a;
            --glass: rgba(255, 255, 255, 0.9);
            --error-red: #ef4444;
        }

        body, html {
            margin: 0; padding: 0;
            height: 100%; width: 100%;
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
            overflow: hidden;
            background-color: #0f172a;
        }

        .main-wrapper { display: flex; height: 100vh; width: 100vw; }

        /* --- LEFT SIDE: THE BRAND EXPERIENCE --- */
        .gallery-side {
            flex: 1.6;
            position: relative;
            overflow: hidden;
            display: none; 
        }

        @media (min-width: 992px) { .gallery-side { display: block; } }

        .slide {
            position: absolute;
            inset: 0;
            opacity: 0;
            transition: opacity 2s ease-in-out, transform 10s linear;
            background-size: cover;
            background-position: center;
            transform: scale(1.1);
        }

        .slide.active { 
            opacity: 0.6; 
            transform: scale(1);
        }

        .overlay-branding {
            position: absolute;
            top: 50%;
            left: 10%;
            transform: translateY(-50%);
            color: white;
            z-index: 10;
            max-width: 600px;
        }

        .overlay-branding h1 { 
            font-size: 4rem; 
            font-weight: 800;
            margin: 0; 
            color: var(--cbe-gold);
            line-height: 1.1;
        }

        .overlay-branding p { font-size: 1.4rem; margin-top: 20px; color: #e2e8f0; font-weight: 300; }

        /* --- RIGHT SIDE: THE SECURE TERMINAL --- */
        .login-side {
            flex: 1;
            background: radial-gradient(circle at center, #ffffff 0%, #f1f5f9 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            z-index: 20;
            box-shadow: -10px 0 50px rgba(0,0,0,0.2);
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 50px;
            background: var(--glass);
            border-radius: 32px;
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.5);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15);
        }

        .brand-header { text-align: left; margin-bottom: 30px; }
        .brand-header .icon-box {
            background: var(--cbe-purple);
            width: 55px; height: 55px;
            display: flex; align-items: center; justify-content: center;
            border-radius: 14px; margin-bottom: 20px;
            box-shadow: 0 10px 20px rgba(75, 44, 109, 0.2);
        }
        .brand-header i { color: var(--cbe-gold); font-size: 1.6rem; }
        .brand-header h2 { font-size: 1.6rem; color: var(--cbe-purple-dark); margin: 0; font-weight: 800; }
        .brand-header p { color: #64748b; font-size: 0.9rem; margin-top: 5px; }

        /* ERROR MESSAGE STYLING */
        .error-box {
            background: #fee2e2;
            border-left: 4px solid var(--error-red);
            color: #991b1b;
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-6px); }
            75% { transform: translateX(6px); }
        }

        .form-group { margin-bottom: 20px; }
        .form-group label { 
            display: block; margin-bottom: 8px; font-weight: 600; 
            color: #475569; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px;
        }
        
        .input-wrapper { position: relative; }
        .input-wrapper i { position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #94a3b8; transition: 0.3s; }
        
        .input-wrapper input {
            width: 100%;
            padding: 15px 15px 15px 50px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            box-sizing: border-box;
        }

        .input-wrapper input:focus {
            border-color: var(--cbe-purple);
            outline: none;
            box-shadow: 0 0 0 4px rgba(75, 44, 109, 0.1);
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: var(--cbe-purple);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.4s;
            margin-top: 10px;
            display: flex; align-items: center; justify-content: center; gap: 12px;
            letter-spacing: 1px;
        }

        .btn-login:hover { 
            background: var(--cbe-purple-dark); 
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(75, 44, 109, 0.3);
        }

        .security-footer {
            margin-top: 40px;
            text-align: center;
            border-top: 1px solid #e2e8f0;
            padding-top: 25px;
        }

        .badge {
            display: inline-flex; align-items: center; gap: 8px;
            background: #f0f9ff; color: #0369a1;
            padding: 6px 14px; border-radius: 100px;
            font-size: 0.65rem; font-weight: 800; margin-bottom: 12px;
        }
    </style>
</head>
<body>

<div class="main-wrapper">
    <div class="gallery-side">
        <div class="slide active" style="background-image: url('https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&w=1500')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=1500')"></div>
        <div class="slide" style="background-image: url('https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&w=1500')"></div>
        
        <div class="overlay-branding">
            <h1 id="slideTitle">Core Integrity</h1>
            <p id="slideDesc">Securing the financial future of Ethiopia through robust technology.</p>
        </div>
    </div>

    <div class="login-side">
        <div class="login-card">
            <div class="brand-header">
                <div class="icon-box">
                    <i class="fas fa-shield-halved"></i>
                </div>
                <h2>Managerial Login</h2>
                <p>Access the administrative core terminal.</p>
            </div>

            <%-- Professional Error Handling --%>
            <% 
                String error = request.getParameter("error");
                if (error != null) { 
            %>
                <div class="error-box">
                    <i class="fas fa-circle-exclamation"></i>
                    <strong><%= error %></strong>
                </div>
            <% } %>

            <form id="authForm" action="auth_process.jsp" method="POST">
                <div class="form-group">
                    <label>Employee Name</label>
                    <div class="input-wrapper">
                        <i class="fas fa-id-badge"></i>
                        <input type="text" name="name" placeholder="Full Name" required autocomplete="off">
                    </div>
                </div>

                <div class="form-group">
                    <label>Security Access Key</label>
                    <div class="input-wrapper">
                        <i class="fas fa-key"></i>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn-login" id="loginBtn">
                    <span>SECURE AUTHORIZATION</span> <i class="fas fa-arrow-right"></i>
                </button>
            </form>

            <div class="security-footer">
                <div class="badge">
                    <i class="fas fa-user-shield"></i> ENCRYPTED SESSION ACTIVE
                </div>
                <p style="font-size: 0.65rem; color: #94a3b8; line-height: 1.4;">
                    Unauthorized access is strictly prohibited and subject to CBE Global Security Policy monitoring.
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    // Slide Data
    const slides = document.querySelectorAll('.slide');
    const title = document.getElementById('slideTitle');
    const desc = document.getElementById('slideDesc');
    const content = [
        { t: "Core Integrity", d: "Securing the financial future of Ethiopia through robust technology." },
        { t: "Unified Analytics", d: "Real-time managerial insights across every branch." },
        { t: "Data Fortification", d: "Bank-grade encryption protecting millions of transactions." }
    ];

    let current = 0;

    function nextSlide() {
        slides[current].classList.remove('active');
        current = (current + 1) % slides.length;
        slides[current].classList.add('active');
        
        title.style.opacity = 0;
        desc.style.opacity = 0;
        
        setTimeout(() => {
            title.innerText = content[current].t;
            desc.innerText = content[current].d;
            title.style.opacity = 1;
            desc.style.opacity = 1;
        }, 800);
    }

    setInterval(nextSlide, 8000);

    // Form submission animation
    document.getElementById('authForm').onsubmit = function() {
        const btn = document.getElementById('loginBtn');
        btn.innerHTML = '<span>AUTHENTICATING...</span> <i class="fas fa-spinner fa-spin"></i>';
        btn.style.opacity = '0.8';
        btn.style.pointerEvents = 'none';
    };
</script>

</body>
</html>