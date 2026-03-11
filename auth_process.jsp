<%-- Use jakarta for Tomcat 11 --%>
<%@ page import="java.sql.*, java.util.*, jakarta.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String managerNameInput = request.getParameter("name"); 
    String plainPassword = request.getParameter("password");

    String dbUrl = "jdbc:mysql://localhost:3306/bank";
    String dbUser = "root";
    String dbPass = ""; 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        
        // Query must select the columns you need
        String sql = "SELECT name, password, role, status FROM managers WHERE name = ? LIMIT 1";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, managerNameInput);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String dbPassword = rs.getString("password");
            String fullName = rs.getString("name");
            String role = rs.getString("role");
            String status = rs.getString("status");

            // 1. Check Status First
            if (status != null && (status.equals("0") || status.equalsIgnoreCase("suspended"))) {
                response.sendRedirect("manager.jsp?error=Account Suspended.");
                return;
            }

            // 2. Compare Passwords
            if (plainPassword != null && plainPassword.equals(dbPassword)) { 
                HttpSession managerSession = request.getSession(true);
                
                // IMPORTANT: These names must match what manager_home.jsp expects!
                managerSession.setAttribute("user_id", managerNameInput); // Used for security check
                managerSession.setAttribute("user_name", fullName);       // Used for the Welcome message
                managerSession.setAttribute("role", role);
                
                managerSession.setMaxInactiveInterval(30 * 60); // 30 mins
                
                response.sendRedirect("manager_home.jsp");
            } else {
                response.sendRedirect("manager.jsp?error=Incorrect Security Key.");
            }
        } else {
            response.sendRedirect("manager.jsp?error=Manager Name Not Recognized.");
        }

    } catch (Exception e) {
        // Log error for the developer
        e.printStackTrace();
        response.sendRedirect("manager.jsp?error=Database Connection Failed.");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException i) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException i) {}
        if (conn != null) try { conn.close(); } catch (SQLException i) {}
    }
%>