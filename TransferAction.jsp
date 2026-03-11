<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
        String loggedInEmpId = (String) session.getAttribute("empId");
        
    if (loggedInEmpId == null) {
        out.println("<h3 style='color:red;'>Error: No staff session found. Please login first.</h3>");
        return;
    }
    String fromAcc = request.getParameter("fromaccount");
    String toAcc = request.getParameter("toaccount");
    String amountStr = request.getParameter("amount");
    String pass = request.getParameter("password");

    if (fromAcc != null && toAcc != null && amountStr != null) {
        Connection con = null;
        try {
            double amount = Double.parseDouble(amountStr);
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
            con.setAutoCommit(false);

            PreparedStatement ps1 = con.prepareStatement("SELECT balance, username FROM account WHERE accountnumber=? AND password=?");
            ps1.setString(1, fromAcc);
            ps1.setString(2, pass);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                double senderOldBal = rs1.getDouble("balance");
                String senderName = rs1.getString("username");

                if (senderOldBal >= amount) {
                    PreparedStatement ps2 = con.prepareStatement("SELECT balance FROM account WHERE accountnumber=?");
                    ps2.setString(1, toAcc);
                    ResultSet rs2 = ps2.executeQuery();

                    if (rs2.next()) {
                        double receiverOldBal = rs2.getDouble("balance");
                        PreparedStatement ps3 = con.prepareStatement("UPDATE account SET balance = balance - ? WHERE accountnumber=?");
                        ps3.setDouble(1, amount);
                        ps3.setString(2, fromAcc);
                        ps3.executeUpdate();
                        PreparedStatement ps4 = con.prepareStatement("UPDATE account SET balance = balance + ? WHERE accountnumber=?");
                        ps4.setDouble(1, amount);
                        ps4.setString(2, toAcc);
                        ps4.executeUpdate();

String logSql = "INSERT INTO transactions (sender_account_id, receiver_account_id, amount, " +
                "sender_prev_balance, sender_new_balance, receiver_prev_balance, receiver_new_balance, " +
                "transaction_type, transaction_status, description, done_by) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'transfer', 'completed', 'Fund Transfer', ?)";

PreparedStatement logPst = con.prepareStatement(logSql);
logPst.setString(1, fromAcc);
logPst.setString(2, toAcc);
logPst.setDouble(3, amount);
logPst.setDouble(4, senderOldBal);
logPst.setDouble(5, senderOldBal - amount);
logPst.setDouble(6, receiverOldBal);
logPst.setDouble(7, receiverOldBal + amount);
logPst.setString(8, loggedInEmpId);

logPst.executeUpdate();

                        con.commit(); 
                        request.setAttribute("senderName", senderName);
                        request.setAttribute("fromAcc", fromAcc);
                        request.setAttribute("toAcc", toAcc);
                        request.setAttribute("amount", amount);
                        request.setAttribute("newBal", senderOldBal - amount);
                        
                        request.getRequestDispatcher("transfer_receipt.jsp").forward(request, response);
                    } else {
                        throw new Exception("Destination account not found!");
                    }
                } else {
                    throw new Exception("Insufficient balance!");
                }
            } else {
                throw new Exception("Invalid Source Account or Password!");
            }
        } catch (Exception e) {
            if (con != null) con.rollback();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("transfer1.jsp").forward(request, response);
        } finally {
            if (con != null) con.close();
        }
    }
%>