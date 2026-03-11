<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Action Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
<%
    String accId = request.getParameter("accountnumber");
    if(accId != null) accId = accId.trim();
    if (accId == null || accId.isEmpty() || accId.equals("null")) {
%>
        <div class="alert alert-danger">
            <h3>Invalid Request</h3>
            <p>No valid account number was received to process the deletion.</p>
            <a href="AccountList.jsp" class="btn btn-secondary">Back to List</a>
        </div>
<%
        return; 
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bank";
        String dbUser = "root";   
        String dbPass = "";                     

        Class.forName("com.mysql.cj.jdbc.Driver"); 
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        conn.setAutoCommit(false);

        String sql = "UPDATE account SET status = 'DELETED' WHERE accountnumber = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, accId);              
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            conn.commit(); 
%>
            <div class="card shadow-lg p-4">
                <div class="text-success mb-3">
                    <i class="bi bi-check-circle-fill" style="font-size: 3rem;"></i>
                </div>
                <h2 class="text-success">Action Successful</h2>
                <hr>
                <p class="lead">Account <strong><%= accId %></strong> has been deactivated and removed from active records.</p>
                <div class="mt-4">
                    <a href="view_accounts.jsp" class="btn btn-primary">Return to Account List</a>
                </div>
            </div>
<%
        } else {
%>
            <div class="alert alert-warning shadow">
                <h3>Account Not Found</h3>
                <p>The system could not find account number <%= accId %>.</p>
                <a href="view_accounts.jsp" class="btn btn-outline-dark">Try Again</a>
            </div>
<%
        }

    } catch (Exception e) {
        if (conn != null) try { conn.rollback(); } catch (SQLException se) {}
%>
        <div class="alert alert-danger shadow">
            <h3>System Error</h3>
            <p>The transaction was rolled back for safety. Error: <%= e.getMessage() %></p>
            <a href="view_accounts.jsp" class="btn btn-danger">Back to Safety</a>
        </div>
<%
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
            </div>
        </div>
    </div>
</body>
</html>