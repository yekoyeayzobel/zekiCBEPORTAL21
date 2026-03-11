<%-- WithdrawAction.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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

    if (accNo != null && pass != null && amountStr != null) {
        Connection con = null;
        try {
            double amount = Double.parseDouble(amountStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
            
            con.setAutoCommit(false); 

            // Step 1: Check credentials (የነበረው index 5 ስህተት ተስተካክሏል)
            String checkQuery = "SELECT balance FROM account WHERE accountnumber=? AND password=? AND username=?";
            PreparedStatement ps = con.prepareStatement(checkQuery);
            ps.setString(1, accNo);
            ps.setString(2, pass);
            ps.setString(3, user);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double currentBalance = rs.getDouble("balance");

                if (currentBalance >= amount) {
                    double newBalance = currentBalance - amount;

                    // Step 2: Update the balance
                    String updateQuery = "UPDATE account SET balance=? WHERE accountnumber=?";
                    PreparedStatement ups = con.prepareStatement(updateQuery);
                    ups.setDouble(1, newBalance);
                    ups.setString(2, accNo);
                    ups.executeUpdate();

                    // Step 3: Log the withdrawal (VALUES ላይ ? ተጨምሯል)
                    String logQuery = "INSERT INTO transactions (" +
                                      "sender_account_id, amount, " +
                                      "sender_prev_balance, sender_new_balance, " +
                                      "transaction_type, transaction_status, description, done_by) " +
                                      "VALUES (?, ?, ?, ?, 'withdrawal', 'completed', 'ATM/Branch Withdrawal', ?)";
                    
                    PreparedStatement lps = con.prepareStatement(logQuery);
                    lps.setString(1, accNo);          
                    lps.setDouble(2, amount);          
                    lps.setDouble(3, currentBalance); 
                    lps.setDouble(4, newBalance);     
                    lps.setString(5, loggedInEmpId); // ሰራተኛው እዚህ ጋር ይገባል
                    lps.executeUpdate();

                    con.commit(); 

                    // SUCCESS
                    request.setAttribute("accountnumber", accNo);
                    request.setAttribute("username", user);
                    request.setAttribute("withdrawn", amount);
                    request.setAttribute("oldBalance", currentBalance);
                    request.setAttribute("newBalance", newBalance);
                    
                    request.getRequestDispatcher("receipt.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Insufficient funds! Current balance: " + currentBalance + " ETB");
                    request.getRequestDispatcher("withdraw1.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Authentication Failed! Check account details.");
                request.getRequestDispatcher("withdraw1.jsp").forward(request, response);
            }
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch(SQLException ignored) {}
            request.setAttribute("error", "System Error: " + e.getMessage());
            request.getRequestDispatcher("withdraw1.jsp").forward(request, response);
        } finally {
            if (con != null) try { con.close(); } catch(SQLException ignored) {}
        }
    }
%>