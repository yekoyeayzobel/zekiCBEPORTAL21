<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    String user = request.getParameter("username");
    String accNo = request.getParameter("accountno");
    String pass = request.getParameter("password");
    
    double balance = 0.0;
    boolean success = false;
    String errorMsg = null;

    // Database Logic
    if (user != null && accNo != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");

            // FIXED: Removed space in 'account_no'
            String sql = "SELECT balance FROM account WHERE username=? AND password=? AND accountnumber=?";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user);
            pstmt.setString(2, pass);
            pstmt.setString(3, accNo);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                balance = rs.getDouble("balance");
                success = true;
            } else {
                errorMsg = "Security Verification Failed. Information does not match our records.";
            }
        } catch (Exception e) {
            errorMsg = "System Connection Error: " + e.getMessage();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Dashboard | Infinite Bank</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .dashboard-card {
            background: white;
            width: 450px;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            text-align: center;
        }

        .bank-logo {
            font-size: 24px;
            font-weight: bold;
            color: #1e3c72;
            letter-spacing: 2px;
            margin-bottom: 5px;
        }

        .status-badge {
            display: inline-block;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 20px;
            background: #e8f5e9;
            color: #2e7d32;
        }

        .avatar {
            width: 80px;
            height: 80px;
            background: #f0f2f5;
            border-radius: 50%;
            margin: 0 auto 15px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 30px;
            color: #1e3c72;
        }

        .user-name {
            font-size: 22px;
            margin: 0;
            color: #2c3e50;
        }

        .acc-number {
            font-size: 14px;
            color: #7f8c8d;
            margin-bottom: 30px;
        }

        .balance-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            border: 1px solid #edf2f7;
        }

        .balance-label {
            font-size: 13px;
            color: #95a5a6;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .balance-amount {
            font-size: 36px;
            font-weight: 800;
            color: #2d3436;
        }

        .error-card {
            color: #c0392b;
            border: 1px solid #f5c6cb;
            background: #f8d7da;
            padding: 20px;
            border-radius: 10px;
        }

        .btn-back {
            margin-top: 30px;
            display: inline-block;
            text-decoration: none;
            color: #1e3c72;
            font-weight: 600;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-back:hover { color: #2a5298; transform: translateX(-5px); }
    </style>
</head>
<body>

    <div class="dashboard-card">
             <center><img src="image/Logo.png" alt="business" width="150" height="150"></center><br>
        <div class="bank-logo">COMMERCIAL BANK OF ETHIOPIA</div>
       
        
        <% if(success) { %>
            <div class="status-badge">Active Account</div>
            
            <div class="avatar">?</div>
            
            <h2 class="user-name"><%= user.toUpperCase() %></h2>
            <div class="acc-number">Account: ****<%= accNo.substring(Math.max(0, accNo.length() - 4)) %></div>

            <div class="balance-container">
                <div class="balance-label">Available Balance</div>
                <div class="balance-amount"><%= String.format("%,.2f", balance) %>ETB</div>
            </div>
            
        <% } else { %>
            <div class="avatar">??</div>
            <div class="error-card">
                <strong>Access Denied</strong><br>
                <%= (errorMsg != null) ? errorMsg : "Please log in to view balance." %>
            </div>
        <% } %>

        <a href="balance1.jsp" class="btn-back">? Return to Portal</a>
    </div>
<body>
  <div id="footer-placeholder"></div>

  <script>
    fetch('footer.html')
      .then(response => response.text())
      .then(data => {
        document.getElementById('footer-placeholder').innerHTML = data;
      });
  </script>
</body>
</body>
</html>