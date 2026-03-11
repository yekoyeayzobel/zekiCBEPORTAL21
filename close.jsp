<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 1. Capture Form Inputs
    String accNo = request.getParameter("accountno");
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    // 2. Response Variables
    String message = "";
    String statusType = ""; // success OR error

    // 3. Database Credentials
    String dbUrl = "jdbc:mysql://localhost:3306/bank";
    String dbUser = "root";
    String dbPass = "";

    // 4. Database Logic
    if (accNo != null && user != null && pass != null) {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
            con.setAutoCommit(false);

            // Verify Identity (Added a more secure check)
            String checkSql = "SELECT balance FROM account WHERE accountnumber=? AND username=? AND password=?";
            PreparedStatement psCheck = con.prepareStatement(checkSql);
            psCheck.setString(1, accNo);
            psCheck.setString(2, user);
            psCheck.setString(3, pass);
            
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("balance");

                if (balance == 0) {
                    String deleteSql = "DELETE FROM account WHERE accountnumber=?";
                    PreparedStatement psDelete = con.prepareStatement(deleteSql);
                    psDelete.setString(1, accNo);
                    
                    int rowsAffected = psDelete.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        con.commit();
                        statusType = "success";
                        message = "Account " + accNo + " successfully terminated.";
                    } else {
                        con.rollback();
                        statusType = "error";
                        message = "Error: Database could not remove the record.";
                    }
                } else {
                    statusType = "error";
                    message = "Closure Denied: Balance must be 0.00 ETB (Current: " + balance + ").";
                }
            } else {
                statusType = "error";
                message = "Invalid Credentials: No matching account found.";
            }
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch(SQLException ignored) {}
            statusType = "error";
            message = "System Error: " + e.getMessage();
        } finally {
            if (con != null) try { con.close(); } catch(SQLException ignored) {}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>CBE | Account Termination</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f4f7fa; display: flex; justify-content: center; padding: 50px; }
        .card { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); width: 400px; border-top: 5px solid #4B0082; }
        h2 { color: #4B0082; text-align: center; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-weight: bold; font-size: 0.8rem; margin-bottom: 5px; }
        input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background: #4B0082; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; margin-top: 10px; }
        
        /* Message Display Styles */
        .alert { padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center; font-size: 0.9rem; font-weight: 600; }
        .success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>

<div class="card">
    <h2>Close Account</h2>
    <p style="text-align: center; color: #666; font-size: 0.8rem; margin-bottom: 20px;">Commercial Bank of Ethiopia</p>

    <% if (!message.equals("")) { %>
        <div class="alert <%= statusType %>">
            <%= message %>
        </div>
    <% } %>

    <form method="post">
        <div class="form-group">
            <label>ACCOUNT NUMBER</label>
            <input type="text" name="accountno" required placeholder="13-digit number">
        </div>
        <div class="form-group">
            <label>USERNAME</label>
            <input type="text" name="username" required>
        </div>
        <div class="form-group">
            <label>PASSWORD</label>
            <input type="password" name="password" required>
        </div>
        <button type="submit" class="btn">TERMINATE ACCOUNT</button>
    </form>
</div>

</body>
</html>