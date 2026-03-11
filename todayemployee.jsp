<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String empId = request.getParameter("id"); 
    String pass = request.getParameter("pass"); 

    String url = "jdbc:mysql://localhost:3306/bank";
    String dbUser = "root";
    String dbPass = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, dbUser, dbPass);
        String query = "SELECT username FROM employee WHERE employee_id=? AND password=?";
        ps = con.prepareStatement(query);
        ps.setString(1, empId);
        ps.setString(2, pass);

        rs = ps.executeQuery();

        if (rs.next()) {
         session.setAttribute("empName", rs.getString("username"));
         session.setAttribute("empId", empId);
            response.sendRedirect("index.html");
        } else {
         response.sendRedirect("employeelogin.jsp?error=invalid");
        }
    } catch (Exception e) {
        response.sendRedirect("employeelogin.jsp?error=db_error");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>