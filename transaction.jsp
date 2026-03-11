<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Ensure we use the correct session key "empId"
    String loggedInEmpId = (String) session.getAttribute("empId");
    if (loggedInEmpId == null) {
        response.sendRedirect("employeelogin.jsp");
        return;
    }

    String url = "jdbc:mysql://localhost:3306/bank";
    String dbUser = "root";
    String dbPass = "";

    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPass);

        // 1. Fetch activities for the CURRENT logged in employee
        String myTransSQL = "SELECT * FROM transactions WHERE done_by = ? ORDER BY transaction_date DESC";
        PreparedStatement psMy = con.prepareStatement(myTransSQL);
        psMy.setString(1, loggedInEmpId);
        ResultSet rsMy = psMy.executeQuery();

        // 2. Fetch ALL activities, joining with employee table to get names
        // Note: we select t.done_by to get the ID
        String allTransSQL = "SELECT t.*, e.username AS staff_name " +
                             "FROM transactions t " +
                             "LEFT JOIN employee e ON t.done_by = e.employee_id " +
                             "ORDER BY t.transaction_date DESC";
        Statement stAll = con.createStatement();
        ResultSet rsAll = stAll.executeQuery(allTransSQL);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CBE | Employee Activity Dashboard</title>
    <style>
        :root { --cbe-purple: #4e148c; --cbe-gold: #ffcc00; --bg: #f4f7f6; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); margin: 0; display: flex; }
        .sidebar { width: 280px; background: var(--cbe-purple); color: white; height: 100vh; position: fixed; padding: 25px; box-sizing: border-box; }
        .main-content { margin-left: 280px; width: calc(100% - 280px); padding: 40px; }
        .card { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 30px; }
        h3 { color: var(--cbe-purple); margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #f8fafc; text-align: left; padding: 12px; font-size: 13px; color: #64748b; border-bottom: 2px solid #edf2f7; }
        td { padding: 12px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }
        .badge { background: #e0f2fe; color: #0369a1; padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold; text-transform: uppercase; }
        .highlight { background-color: #fffbeb !important; font-weight: bold; }
        .staff-id { display: block; font-size: 11px; color: #94a3b8; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2 style="color:var(--cbe-gold)">CBE PORTAL</h2>
        <div style="background: rgba(255,255,255,0.1); padding: 15px; border-radius: 8px;">
    <p style="margin:0; font-size:12px; color: #ccc;">Logged in as:</p>
    
    <h3 style="margin:5px 0 0 0; color:white; border:none; padding:0;">
        <%= (session.getAttribute("empName") != null) ? session.getAttribute("empName") : "Guest User" %>
    </h3>
    
    <small style="color:var(--cbe-gold); font-weight: bold;">
        Manager ID: <%= (session.getAttribute("empId") != null) ? session.getAttribute("empId") : "N/A" %>
    </small>
</div>
        <br>
        <nav>
            <ul style="list-style:none; padding:0;">
                <li style="margin-bottom:15px;"><a href="index.html" style="color:white; text-decoration:none;">🏠 Home</a></li>
                <li><a href="logout.jsp" style="color:#ff6b6b; text-decoration:none; font-weight:bold;">🚪 Logout</a></li>
            </ul>
        </nav>
    </div>

    <div class="main-content">
        
        <div class="card" style="border-top: 4px solid #22c55e;">
            <h3>My Recent Activities</h3>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Type</th>
                        <th>Account</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
    <% while(rsMy.next()) { 
        // Logic: If it's a withdrawal, show sender. If it's a transfer/deposit, show receiver.
        String displayAcc = rsMy.getString("receiver_account_id");
        if (displayAcc == null || displayAcc.isEmpty()) {
            displayAcc = rsMy.getString("sender_account_id");
        }
    %>
    <tr class="highlight">
        <td><%= rsMy.getTimestamp("transaction_date") %></td>
        <td><span class="badge"><%= rsMy.getString("transaction_type") %></span></td>
        <td><%= (displayAcc != null) ? displayAcc : "Internal" %></td>
        <td>ETB <%= String.format("%,.2f", rsMy.getDouble("amount")) %></td>
    </tr>
    <% } %>
</tbody>
            </table>
        </div>

        <div class="card">
            <h3>System-Wide Transactions (All Staff)</h3>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Performed By (Name & ID)</th>
                        <th>Type</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <% while(rsAll.next()) { 
                        String doneBy = rsAll.getString("done_by");
                        boolean isMe = loggedInEmpId.equals(doneBy);
                    %>
                    <tr <%= isMe ? "class='highlight'" : "" %>>
                        <td><%= rsAll.getTimestamp("transaction_date") %></td>
                        <td>
                            <strong><%= rsAll.getString("staff_name") != null ? rsAll.getString("staff_name") : "System" %></strong>
                            <span class="staff-id">ID: <%= (doneBy != null) ? doneBy : "N/A" %> <%= isMe ? "(You)" : "" %></span>
                        </td>
                        <td><span class="badge"><%= rsAll.getString("transaction_type") %></span></td>
                        <td>ETB <%= String.format("%,.2f", rsAll.getDouble("amount")) %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
<% 
    } catch (Exception e) {
        out.println("<div style='color:red; padding:20px; background:white; margin:20px; border-radius:8px;'>");
        out.println("<strong>Database Error:</strong> " + e.getMessage());
        out.println("<br><small>Make sure the 'done_by' column exists in your transactions table.</small>");
        out.println("</div>");
    } finally {
        if (con != null) con.close();
    }
%>