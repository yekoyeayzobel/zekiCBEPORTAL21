<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CBE | Manager Command Center</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root {
            --cbe-purple: #4B0082;
            --cbe-gold: #FFD700;
            --sidebar-width: 260px;
        }

        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        
        /* Sidebar Styling */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            background: var(--cbe-purple);
            color: white;
            transition: all 0.3s;
            z-index: 1000;
        }
        .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 12px 20px;
            margin: 5px 15px;
            border-radius: 8px;
            display: flex;
            align-items: center;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: var(--cbe-gold);
        }
        
        /* Content Area */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
        }

        /* Dashboard Cards */
        .stat-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s;
        }
        .stat-card:hover { transform: translateY(-5px); }
        .icon-shape {
            width: 48px;
            height: 48px;
            background: rgba(75, 0, 130, 0.1);
            color: var(--cbe-purple);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }
    </style>
</head>
<body>

<div class="sidebar d-flex flex-column p-3">
    <div class="text-center mb-4">
        <img src="image/Logo.png" alt="CBE Logo" style="height: 60px;">
        <h5 class="mt-3 fw-bold">Admin Portal</h5>
    </div>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="manager_dashboard.jsp" class="nav-link active">
                <i class="bi bi-grid-1x2-fill me-3"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="view_accounts.jsp" class="nav-link">
                <i class="bi bi-people-fill me-3"></i> Customer Accounts
            </a>
        </li>
        <li>
            <a href="audit_logs.jsp" class="nav-link">
                <i class="bi bi-shield-lock-fill me-3"></i> Transaction Audit
            </a>
        </li>
    </ul>
    <hr>
    <a href="logout.jsp" class="nav-link text-danger">
        <i class="bi bi-box-arrow-left me-3"></i> Sign Out
    </a>
</div>

<div class="main-content">
    <header class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold mb-0">Branch Overview</h2>
            <p class="text-muted">Welcome back, Bank Manager</p>
        </div>
        <div class="dropdown">
            <button class="btn btn-white shadow-sm border rounded-pill px-4">
                <i class="bi bi-calendar3 me-2 text-primary"></i> 
                <%= new java.text.SimpleDateFormat("MMM dd, yyyy").format(new java.util.Date()) %>
            </button>
        </div>
    </header>

    <%
        double totalBalance = 0;
        int customerCount = 0;
        int todayTransacts = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
            
            // Query 1: Total Bank Deposits & Customer Count
            ResultSet rs1 = con.createStatement().executeQuery("SELECT SUM(balance), COUNT(*) FROM account");
            if(rs1.next()) {
                totalBalance = rs1.getDouble(1);
                customerCount = rs1.getInt(2);
            }

            // Query 2: Today's Transaction Volume
            ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM transactions WHERE DATE(created_at) = CURDATE()");
            if(rs2.next()) todayTransacts = rs2.getInt(1);

            con.close();
        } catch(Exception e) { /* Handle error */ }
    %>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="card stat-card p-4">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="text-muted small fw-bold text-uppercase mb-1">Total Vault Deposits</p>
                        <h3 class="fw-bold mb-0"><%= String.format("%,.2f", totalBalance) %> ETB</h3>
                    </div>
                    <div class="icon-shape"><i class="bi bi-bank"></i></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card p-4">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="text-muted small fw-bold text-uppercase mb-1">Active Customers</p>
                        <h3 class="fw-bold mb-0"><%= customerCount %> Users</h3>
                    </div>
                    <div class="icon-shape" style="background: rgba(46, 204, 113, 0.1); color: #2ecc71;">
                        <i class="bi bi-person-check"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card stat-card p-4">
                <div class="d-flex justify-content-between">
                    <div>
                        <p class="text-muted small fw-bold text-uppercase mb-1">Today's Volume</p>
                        <h3 class="fw-bold mb-0"><%= todayTransacts %> Operations</h3>
                    </div>
                    <div class="icon-shape" style="background: rgba(230, 126, 34, 0.1); color: #e67e22;">
                        <i class="bi bi-activity"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card stat-card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-0">
            <h5 class="fw-bold mb-0">Critical Audit Monitor</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">Reference ID</th>
                            <th>Time</th>
                            <th>Action</th>
                            <th>Amount</th>
                            <th>Risk Level</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                                ResultSet rs = con.createStatement().executeQuery("SELECT * FROM transactions ORDER BY created_at DESC LIMIT 6");
                                while(rs.next()) {
                                    String type = rs.getString("transaction_type");
                                    double amt = rs.getDouble("amount");
                                    String riskBadge = amt > 100000 ? "bg-danger" : "bg-success";
                                    String riskText = amt > 100000 ? "High Watch" : "Normal";
                        %>
                        <tr>
                            <td class="ps-4">#<%= rs.getInt("transaction_id") %></td>
                            <td><small><%= rs.getTimestamp("created_at") %></small></td>
                            <td><span class="badge bg-light text-dark border text-uppercase"><%= type %></span></td>
                            <td class="fw-bold"><%= String.format("%,.2f", amt) %> ETB</td>
                            <td><span class="badge <%= riskBadge %>"><%= riskText %></span></td>
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
    </div>
</div>



</body>
</html>