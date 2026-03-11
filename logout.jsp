<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    // 1. Get the current session if it exists, don't create a new one
    HttpSession userSession = request.getSession(false);

    if (userSession != null) {
        // 2. Clear all data stored in the session
        userSession.removeAttribute("user_id");
        userSession.removeAttribute("user_name");
        
        // 3. Completely destroy the session
        userSession.invalidate();
    }

    // 4. Redirect to login page with a success parameter
    response.sendRedirect("manager.jsp?msg=logged_out");
%>