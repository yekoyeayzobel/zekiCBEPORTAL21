<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String accId = request.getParameter("accountnumber");
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
        String sql = "UPDATE account SET status = 'active' WHERE accountnumber = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, accId);
        
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("view_accounts.jsp?msg=Reactivated");
        } else {
            out.println("Error: Account not found.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("System Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>