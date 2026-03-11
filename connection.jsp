<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE | Dynamic Branch Receipt</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        :root { --cbe-purple: #4B0082; --cbe-gold: #FFD700; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f4f7f6; display: flex; flex-direction: column; align-items: center; padding: 20px; }
        
        #receipt-content { 
            background: #fff; width: 650px; padding: 20px; 
            border-left: 15px solid var(--cbe-purple);
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            box-sizing: border-box;
        }

        .header-row { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid var(--cbe-purple); padding-bottom: 10px; margin-bottom: 15px; }
        .bank-brand { display: flex; align-items: center; gap: 10px; }
        .bank-name { color: var(--cbe-purple); font-size: 1.1rem; font-weight: bold; }

        .main-grid { display: flex; gap: 30px; }
        .column { flex: 1; }

        .invoice-label { background: #4b0082; color: white; font-size: 0.7rem; font-weight: bold; text-align: center; padding: 4px; margin-bottom: 10px; border-radius: 3px; }

        .data-table { width: 100%; font-size: 0.75rem; border-collapse: collapse; }
        .data-table td { padding: 5px 0; border-bottom: 1px dashed #eee; }
        .label { color: #777; width: 40%; }
        .value { font-weight: 600; text-align: right; color: #111; }

        .acc-box { background: #fffdf0; border: 1px solid var(--cbe-gold); text-align: center; padding: 10px; margin: 10px 0; border-radius: 5px; }
        .acc-no { font-family: 'Courier New', monospace; font-size: 1.4rem; font-weight: bold; color: var(--cbe-purple); letter-spacing: 1px; }

        .amount-highlight { background: #f4f0ff; padding: 10px; border-radius: 5px; text-align: center; margin-top: 10px; }
        .amount-val { font-size: 1.2rem; font-weight: bold; color: #111; }

        .footer { display: flex; justify-content: space-between; font-size: 0.6rem; color: #999; margin-top: 20px; border-top: 1px solid #eee; padding-top: 8px; }
        
        .btn-group { margin-top: 20px; display: flex; gap: 10px; }
        .btn { padding: 12px 25px; background: var(--cbe-purple); color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: 0.3s; }
        .btn:hover { background: #3a0066; }
    </style>
</head>
<body>

<%
    String action = request.getParameter("submit");
    if (action != null) {
        String pass = request.getParameter("password");
        String repass = request.getParameter("repassword");
        
        if(pass != null && pass.equals(repass)) {
            Connection conn = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                
                // Matches your fixed table columns: accountnumber is omitted as it is auto-increment
                String sql = "INSERT INTO account (username, password, address, phone, email, balance, status) VALUES (?, ?, ?, ?, ?, ?, 'active')";
                PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                
                String inputUser = request.getParameter("username");
                String inputAddress = request.getParameter("address"); 
                String inputPhone = request.getParameter("phone");
                String inputEmail = request.getParameter("email");
                String inputBalance = request.getParameter("balance");

                pstmt.setString(1, inputUser);
                pstmt.setString(2, pass);
                pstmt.setString(3, inputAddress);
                pstmt.setString(4, inputPhone);
                pstmt.setString(5, inputEmail);
                pstmt.setDouble(6, Double.parseDouble(inputBalance));

                if (pstmt.executeUpdate() > 0) {
                    ResultSet rs = pstmt.getGeneratedKeys();
                    long db_accNo = 0;
                    if (rs.next()) db_accNo = rs.getLong(1); // Since we set AUTO_INCREMENT to 1000, this will be 1000, 1001, etc.
                    
                    String db_ref = "FT" + (System.currentTimeMillis() / 1000);
%>
    <div id="receipt-content">
        <div class="header-row">
            <div class="bank-brand">
                <img src="image/Logo.png" alt="CBE Logo" width="40" height="40">
                <div class="bank-name">COMMERCIAL BANK OF ETHIOPIA</div>
            </div>
            <div style="text-align:right; font-size: 0.65rem; color: #666;">
                TIN: 0000006966 | VAT: 011140<br>
                SWIFT: CBETETAA
            </div>
        </div>

        <div class="main-grid">
            <div class="column">
                <div class="invoice-label">TRANSACTION DETAILS</div>
                <table class="data-table">
                    <tr><td class="label">Ref No:</td><td class="value"><%= db_ref %></td></tr>
                    <tr><td class="label">Date:</td><td class="value"><%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date()) %></td></tr>
                    <tr><td class="label">Branch:</td><td class="value"><%= inputAddress != null ? inputAddress.toUpperCase() : "HEAD OFFICE" %></td></tr>
                    <tr><td class="label">Customer:</td><td class="value"><%= inputUser.toUpperCase() %></td></tr>
                </table>
            </div>

            <div class="column">
                <div class="invoice-label">ACCOUNT INFORMATION</div>
                <div class="acc-box">
                    <div style="font-size: 0.6rem; color: #888; margin-bottom: 2px;">OFFICIAL ACCOUNT NUMBER</div>
                    <div class="acc-no"><%= db_accNo %></div>
                </div>
                <div class="amount-highlight">
                    <div style="font-size: 0.7rem; color: #4B0082;">TOTAL BALANCE</div>
                    <div class="amount-val"><%= inputBalance %> ETB</div>
                </div>
            </div>
        </div>

        <div style="font-size: 0.7rem; margin-top: 15px; color: #444;">
            <strong>Amount in Words:</strong> ETB <%= inputBalance %> and Zero cents
        </div>

        <div class="footer">
            <div>© 2026 Commercial Bank of Ethiopia</div>
            <div>System Generated VAT Invoice</div>
            <img src="https://api.qrserver.com/v1/create-qr-code/?size=50x50&data=<%=db_ref%>" width="30">
        </div>
    </div>

    <div class="btn-group">
        <button class="btn" onclick="downloadHorizontalPDF('<%= db_accNo %>')">Download Receipt</button>
        <a href="index.html" style="text-decoration:none;"><button class="btn" style="background:#666;">Home</button></a>
    </div>

    <script>
        function downloadHorizontalPDF(acc) {
            const element = document.getElementById('receipt-content');
            const opt = {
                margin: 10,
                filename: 'CBE_Receipt_' + acc + '.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 3, useCORS: true },
                jsPDF: { unit: 'mm', format: [190, 120], orientation: 'landscape' }
            };
            html2pdf().set(opt).from(element).save();
        }
    </script>
<%
                }
                if(conn != null) conn.close();
            } catch (Exception e) { 
                out.println("<div style='color:red;'>Error: " + e.getMessage() + "</div>"); 
            }
        } else {
            out.println("<script>alert('Passwords do not match!'); window.history.back();</script>");
        }
    }
%>

</body>
</html>