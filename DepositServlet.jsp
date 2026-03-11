<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
    <title>CBE Official Receipt</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    
    <style>
        :root { --cbe-blue: #0056b3; --cbe-gold: #ffcc00; }
        
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #f0f2f5; padding: 20px; margin: 0; }
        
        /* Reduced width to 800px to ensure it fits A4 Landscape without scaling issues */
        .receipt-container {
            width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border-top: 8px solid var(--cbe-blue);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            position: relative;
        }

        .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #eee; padding-bottom: 15px; }
        
        .logo-area { display: flex; align-items: center; }
        .logo-area h2 { margin: 0; color: var(--cbe-blue); font-size: 20px; }
        .logo-area span { color: var(--cbe-gold); }
        
        .receipt-label { text-align: right; font-size: 12px; color: #666; }
        .receipt-label b { color: #000; font-size: 16px; display: block; }

        /* Small Font Table to prevent horizontal overflow */
        .horizontal-table { width: 100%; border-collapse: collapse; margin-top: 20px; font-size: 12px; }
        .horizontal-table th { background: #f8f9fa; color: var(--cbe-blue); padding: 8px; text-align: left; border: 1px solid #ddd; text-transform: uppercase; }
        .horizontal-table td { padding: 10px; border: 1px solid #ddd; color: #333; }

        .footer-sec { display: flex; justify-content: space-between; align-items: flex-end; margin-top: 25px; }
        
        .qr-code { text-align: left; }
        .qr-code img { width: 80px; height: 80px; border: 1px solid #eee; }
        
        .stamp { 
            border: 2px solid var(--cbe-blue); 
            padding: 5px 15px; 
            color: var(--cbe-blue); 
            font-weight: bold; 
            font-size: 12px;
            transform: rotate(-2deg); 
            background: rgba(0, 86, 179, 0.03);
            text-align: center;
        }

        .btn-box { text-align: center; margin-top: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; text-decoration: none; display: inline-block; font-size: 13px; }
        .btn-pdf { background: #28a745; color: white; }
        .btn-back { background: var(--cbe-blue); color: white; }

        @media print {
            .receipt-container { width: 100%; box-shadow: none; border: 1px solid #ccc; }
            .btn-box { display: none; }
        }
    </style>
</head>
<body>
<%
    String loggedInEmpId = (String) session.getAttribute("empId");
    if (loggedInEmpId == null) {
        out.println("<h3 style='color:red;'>Error: No staff session found. Please login first.</h3>");
        return;
    }

    String accNo = request.getParameter("accountno");
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    String amountStr = request.getParameter("amount");
    
    boolean success = false;
    double depositAmount = 0, oldBalance = 0, newBalance = 0;
    String txnId = "CBE" + (System.currentTimeMillis() / 1000); 

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        Connection conn = null;
        try {
            depositAmount = Double.parseDouble(amountStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");

            // 1. Fetch current balance
            String checkSql = "SELECT balance FROM account WHERE accountnumber = ?";
            PreparedStatement selectPst = conn.prepareStatement(checkSql);
            selectPst.setString(1, accNo);
            ResultSet rs = selectPst.executeQuery();
            
            if (rs.next()) { 
                oldBalance = rs.getDouble("balance"); 
            } else {
                throw new Exception("Account Number " + accNo + " not found!");
            }

            conn.setAutoCommit(false); 

            String updateSql = "UPDATE account SET balance = balance + ? WHERE accountnumber = ? AND username = ? AND password = ?";
            PreparedStatement pst = conn.prepareStatement(updateSql);
            pst.setDouble(1, depositAmount);
            pst.setString(2, accNo);
            pst.setString(3, user);
            pst.setString(4, pass);

            int rowsUpdated = pst.executeUpdate();

            if (rowsUpdated > 0) {
                newBalance = oldBalance + depositAmount;
                  String logSql = "INSERT INTO transactions (" +
                                "receiver_account_id, amount, receiver_prev_balance, receiver_new_balance, " +
                                "transaction_type, transaction_status, description, done_by) " +
                                "VALUES (?, ?, ?, ?, 'deposit', 'completed', 'Branch Cash Deposit', ?)";
                
                PreparedStatement logPst = conn.prepareStatement(logSql);
                logPst.setString(1, accNo);          
                logPst.setDouble(2, depositAmount);  
                logPst.setDouble(3, oldBalance);     
                logPst.setDouble(4, newBalance);     
                logPst.setString(5, loggedInEmpId); 

                if (logPst.executeUpdate() > 0) {
                    conn.commit(); 
                    success = true;
                } else {
                    conn.rollback();
                }
            } else {
                conn.rollback();
                throw new Exception("Invalid Username or Password!");
            }
        } catch (Exception e) { 
            if(conn != null) try { conn.rollback(); } catch(SQLException se) {}
            out.println("<div style='background:#fee; color:red; padding:10px; border:1px solid red; margin-bottom:10px;'>");
            out.println("<strong>Transaction Error:</strong> " + e.getMessage());
            out.println("</div>"); 
        } finally { 
            if (conn != null) conn.close(); 
        }
    }
%>

<div id="receipt-content" class="receipt-container">
    <div class="header">
        <div class="logo-area">
            <img src="image/Logo.png" alt="CBE" width="45" height="45" style="margin-right:10px;">
            <div>
                <h2>CBE <span>COMMERCIAL BANK OF ETHIOPIA</span></h2>
                <small>The Bank You Can Always Rely On</small>
            </div>
        </div>
        <div class="receipt-label">
            <b>Transaction Slip</b>
            <span>Date: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date()) %></span>
        </div>
    </div>

    <% if (success) { %>
        <table class="horizontal-table">
            <thead>
                <tr>
                    <th>Ref No</th>
                    <th>Customer</th>
                    <th>Acc Number</th>
                    <th>Prev Bal</th>
                    <th>Deposit</th>
                    <th>New Bal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="font-weight:bold;"><%= txnId %></td>
                    <td><%= user.toUpperCase() %></td>
                    <td><%= accNo %></td>
                    <td><%= String.format("%,.2f", oldBalance) %></td>
                    <td style="color:green; font-weight:bold;">+<%= String.format("%,.2f", depositAmount) %></td>
                    <td style="background:#f0f7ff; font-weight:bold;"><%= String.format("%,.2f", newBalance) %></td>
                </tr>
            </tbody>
        </table>

        <div class="footer-sec">
            <div class="qr-code">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=CBE-<%=txnId%>" alt="QR">
                <p style="font-size:9px; color:#999;">E-Verification QR</p>
            </div>
            <div class="stamp">
                CBE DIGITAL VERIFIED  <img src="image/Logo.png" alt="CBE" width="45" height="45" style="margin-right:10px;"><br>
                <small>PORTAL AUTHENTICATED</small>
            </div>
        </div>
    <% } else { %>
        <p style="color:red; text-align:center; padding:20px;">Transaction failed. Please check your account details.</p>
    <% } %>
</div>

<div class="btn-box">
    <button class="btn btn-pdf" onclick="downloadPDF()">Download Receipt</button>
    <a href="deposit1.jsp" class="btn btn-back">Back</a>
</div>

<script>
    function downloadPDF() {
        const element = document.getElementById('receipt-content');
        const opt = {
            margin: 10,
            filename: 'CBE_Receipt.pdf',
            image: { type: 'jpeg', quality: 0.98 },
            html2canvas: { scale: 2 },
            jsPDF: { unit: 'mm', format: 'a4', orientation: 'landscape' }
        };
        html2pdf().set(opt).from(element).save();
    }
</script>

</body>
</html>