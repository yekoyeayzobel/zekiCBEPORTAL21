<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE | Manager Command Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root { --cbe-purple: #4B0082; --cbe-gold: #FFD700; }
        body { background-color: #f4f7f9; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .sidebar { background: var(--cbe-purple); min-height: 100vh; color: white; }
        .nav-link { color: rgba(255,255,255,0.8); transition: 0.3s; }
        .nav-link:hover, .nav-link.active { color: var(--cbe-gold); background: rgba(255,255,255,0.1); }
        .stat-card { border: none; border-left: 5px solid var(--cbe-purple); border-radius: 10px; transition: 0.3s; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <nav class="col-md-2 d-none d-md-block sidebar shadow-sm p-3">
            <div class="text-center mb-4">
                <img src="image/Logo.png" width="80" alt="CBE Logo">
                <h6 class="mt-2 fw-bold">MANAGER PORTAL</h6>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="#"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="view_accounts.jsp"><i class="bi bi-people me-2"></i> Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="audit_logs.jsp"><i class="bi bi-shield-check me-2"></i> Audit Logs</a></li>
                <li class="nav-item"><a class="nav-link" href="transaction.jsp"><i class="bi bi-shield-check me-2"></i> Today Transaction</a></li>
                <li class="nav-item"><a class="nav-link" href="transfer1.jsp"><i class="bi bi-box-arrow-right me-2"></i> Exit</a></li>
                <a class="nav-link" href="transaction.jsp">Today Transaction</a>
            </ul>
        </nav>

        <main class="col-md-10 ms-sm-auto px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Branch Performance Overview</h2>
                <div class="badge bg-success p-2">System Status: Online</div>
            </div>

            <div class="row g-4 mb-5">
                <%
                    // Logic to fetch total stats from DB
                    double totalBankBalance = 0;
                    int totalAccounts = 0;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                        
                        // Get Total Balance
                        ResultSet rs1 = con.createStatement().executeQuery("SELECT SUM(balance), COUNT(*) FROM account");
                        if(rs1.next()) {
                            totalBankBalance = rs1.getDouble(1);
                            totalAccounts = rs1.getInt(2);
                        }
                        con.close();
                    } catch(Exception e) { }
                %>
                <div class="col-md-4">
                    <div class="card stat-card p-4">
                        <small class="text-muted text-uppercase fw-bold">Total Vault Deposits</small>
                        <h2 class="text-primary mt-2"><%= String.format("%,.2f", totalBankBalance) %> ETB</h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card p-4" style="border-left-color: #2ecc71;">
                        <small class="text-muted text-uppercase fw-bold">Active Customers</small>
                        <h2 class="mt-2"><%= totalAccounts %></h2>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card stat-card p-4" style="border-left-color: #e67e22;">
                        <small class="text-muted text-uppercase fw-bold">Pending Requests</small>
                        <h2 class="mt-2">0</h2>
                    </div>
                </div>
            </div>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0">Live Transaction Audit</h5>
                </div>
                <div class="card-body">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Date</th>
                                <th>Type</th>
                                <th>Sender</th>
                                <th>Receiver</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                try {
                                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                                    ResultSet rs = con.createStatement().executeQuery("SELECT * FROM transactions ORDER BY created_at DESC LIMIT 10");
                                    while(rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getTimestamp("created_at") %></td>
                                <td><span class="badge bg-info text-dark text-uppercase"><%= rs.getString("transaction_type") %></span></td>
                                <td><%= rs.getString("sender_account_id") %></td>
                                <td><%= rs.getString("receiver_account_id") == null ? "-" : rs.getString("receiver_account_id") %></td>
                                <td class="fw-bold"><%= rs.getDouble("amount") %> ETB</td>
                                <td><span class="text-success"><i class="bi bi-check-circle-fill me-1"></i> Completed</span></td>
                            </tr>
                            <% 
                                    }
                                    con.close();
                                } catch(Exception e) { }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>

</body>
</html>