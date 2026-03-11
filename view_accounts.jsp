<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE Manager | Customer Administration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root { --cbe-purple: #4B0082; --cbe-gold: #FFD700; }
        body { background-color: #f8f9fa; }
        .navbar-manager { background-color: var(--cbe-purple); color: white; }
        .search-box { border-radius: 20px; border: 1px solid #ddd; padding-left: 40px; }
        .search-icon { position: absolute; left: 15px; top: 10px; color: #888; }
        .status-active { color: #2ecc71; font-weight: bold; }
        .table-container { background: white; border-radius: 15px; padding: 25px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
    </style>
</head>
<body>

<nav class="navbar navbar-manager shadow-sm mb-4">
    <div class="container-fluid">
        <span class="navbar-brand mb-0 h1"><img src="image/Logo.png" width="40" class="me-2"> CBE Administrative Portal</span>
        <a href="manager_dashboard.jsp" class="btn btn-outline-light btn-sm">Back to Dashboard</a>
    </div>
</nav>

<div class="container">
    <div class="row mb-4 align-items-center">
        <div class="col-md-6">
            <h3>Customer Accounts Oversight</h3>
            <p class="text-muted">Manage all active and inactive bank accounts.</p>
        </div>
        <div class="col-md-6 position-relative">
            <i class="bi bi-search search-icon"></i>
            <input type="text" id="accountSearch" class="form-control search-box" placeholder="Search by Name or Account Number..." onkeyup="filterTable()">
        </div>
    </div>

    <div class="table-container">
        <table class="table table-hover align-middle" id="accountsTable">
            <thead class="table-light">
                <tr>
                    <th>Account No.</th>
                    <th>Customer Name</th>
                    <th>Username</th>
                    <th>Current Balance</th>
                    <th>Account Type</th>
                     <th>Account Status</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection con = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                        
                        // Querying your 'account' table
                        String sql = "SELECT accountnumber, username, balance,status FROM account ORDER BY username ASC";
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery(sql);

                        while(rs.next()) {
                            String accNo = rs.getString("accountnumber");
                            String user = rs.getString("username");
                            double bal = rs.getDouble("balance");
                            String status=rs.getString("status");
                %>  
<tr>
    <td><strong><%= accNo %></strong></td>
    <td><%= user.toUpperCase() %></td>
    <td><span class="text-muted">@<%= user.toLowerCase() %></span></td>
    <td class="fw-bold"><%= String.format("%,.2f", bal) %> ETB</td>
    <td><span class="badge rounded-pill bg-light text-dark border">Savings</span></td>
    
    <td>
        <% if("DELETED".equalsIgnoreCase(status)) { %>
            <span class="badge bg-danger">Inactive / Deleted</span>
        <% } else { %>
            <span class="badge bg-success">Active</span>
        <% } %>
    </td>

    <td class="text-center">
        <div class="btn-group">
            <button class="btn btn-sm btn-outline-primary" title="View Profile"><i class="bi bi-eye"></i></button>
            
            <% if("DELETED".equalsIgnoreCase(status)) { %>
                <a href="ActivateAccountAction.jsp?accountnumber=<%= accNo %>" 
                   class="btn btn-sm btn-success" 
                   onclick="return confirm('Do you want to REACTIVATE account <%= accNo %>?')">
                   <i class="bi bi-check-circle"></i> Activate
                </a>
            <% } else { %>
                <a href="DeleteAccountAction.jsp?accountnumber=<%= accNo %>" 
                   class="btn btn-sm btn-outline-danger" 
                   onclick="return confirm('WARNING: Are you sure you want to delete account <%= accNo %>?')">
                   <i class="bi bi-trash"></i> Delete
                </a>
            <% } %>
        </div>
    </td>
</tr>
                <%
                        }
                    } catch(Exception e) {
                        out.println("<tr><td colspan='6' class='text-center text-danger'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        if(con != null) con.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</div>



<script>
    // Real-time Search Filter
    function filterTable() {
        let input = document.getElementById("accountSearch");
        let filter = input.value.toUpperCase();
        let table = document.getElementById("accountsTable");
        let tr = table.getElementsByTagName("tr");

        for (let i = 1; i < tr.length; i++) {
            let tdAcc = tr[i].getElementsByTagName("td")[0];
            let tdName = tr[i].getElementsByTagName("td")[1];
            if (tdAcc || tdName) {
                let txtValueAcc = tdAcc.textContent || tdAcc.innerText;
                let txtValueName = tdName.textContent || tdName.innerText;
                if (txtValueAcc.toUpperCase().indexOf(filter) > -1 || txtValueName.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

</body>
</html>