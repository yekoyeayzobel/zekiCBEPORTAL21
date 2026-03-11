<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.LocalDate" %>
<%
    // Determine which report to show: "total" or "today"
    String viewMode = request.getParameter("view");
    if (viewMode == null) viewMode = "total"; 
    
    String reportTitle = viewMode.equals("today") ? "Daily Financial Audit (" + LocalDate.now() + ")" : "Full Historical Audit Trail";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE | Audit System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        :root { --cbe-purple: #4B0082; --bg-light: #f8f9fc; }
        body { background-color: var(--bg-light); font-family: 'Segoe UI', sans-serif; }
        
        .audit-card { border: none; border-radius: 12px; box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1); background: white; }
        .type-pill { padding: 0.4em 0.8em; border-radius: 50rem; font-size: 0.75rem; font-weight: 700; display: inline-block; }
        .bg-transfer { background-color: #e0f2fe; color: #0369a1; }
        .bg-deposit { background-color: #dcfce7; color: #15803d; }
        .bg-withdraw { background-color: #fee2e2; color: #b91c1c; }
        
        /* Print Styles */
        @media print {
            .no-print { display: none !important; }
            body { background-color: white !important; }
            .audit-card { box-shadow: none !important; border: 1px solid #ddd !important; }
            .print-header { display: block !important; text-align: center; margin-bottom: 30px; border-bottom: 2px solid var(--cbe-purple); }
        }
        .print-header { display: none; }
    </style>
</head>
<body>

<div class="print-header">
    <h2 style="color: #4B0082;">COMMERCIAL BANK OF ETHIOPIA</h2>
    <h5>SYSTEM AUDIT LOG: <%= viewMode.toUpperCase() %> REPORT</h5>
    <p>Generated: <%= new java.util.Date() %></p>
</div>

<div class="container-fluid py-4">
    <div class="d-sm-flex align-items-center justify-content-between mb-4 no-print">
        <h1 class="h4 mb-0 text-gray-800 fw-bold"><i class="bi bi-shield-lock me-2"></i>Audit Trail</h1>
        <div class="btn-group shadow-sm">
            <a href="?view=total" class="btn btn-sm btn-outline-dark <%= viewMode.equals("total")?"active":"" %>">Total History</a>
            <a href="?view=today" class="btn btn-sm btn-outline-dark <%= viewMode.equals("today")?"active":"" %>">Today Only</a>
            <button onclick="downloadCSV()" class="btn btn-sm btn-success"><i class="bi bi-file-earmark-excel me-1"></i> Excel/CSV</button>
            <button onclick="window.print()" class="btn btn-sm btn-primary"><i class="bi bi-printer me-1"></i> Print/PDF</button>
            <a href="manager_dashboard.jsp" class="btn btn-sm btn-dark">Exit</a>
        </div>
    </div>

    <div class="card audit-card mb-4 no-print">
        <div class="card-body">
            <div class="row g-3">
                <div class="col-md-9">
                    <input type="text" id="logSearch" class="form-control" placeholder="Search accounts, amounts, or timestamps..." onkeyup="filterAudit()">
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="typeFilter" onchange="filterAudit()">
                        <option value="">All Transactions</option>
                        <option value="TRANSFER">Transfers</option>
                        <option value="DEPOSIT">Deposits</option>
                        <option value="WITHDRAWAL">Withdrawals</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <div class="card audit-card">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="auditTable">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">Date & Time</th>
                            <th>Type</th>
                            <th>Parties (From → To)</th>
                            <th>Amount (ETB)</th>
                            <th>Balance Impact</th>
                            <th class="pe-4">Verification</th>
                        </tr>
                    </thead>
                    <%-- Replace your existing <tbody> section with this --%>
<tbody>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
            
            String sql = "SELECT * FROM transactions ";
            if(viewMode.equals("today")) {
                sql += "WHERE DATE(transaction_date) = CURDATE() ";
            }
            sql += "ORDER BY transaction_date DESC";
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while(rs.next()) {
                String type = rs.getString("transaction_type");
                double prevBal = rs.getDouble("sender_prev_balance");
                double newBal = rs.getDouble("sender_new_balance");
                
                String pill = type.equalsIgnoreCase("transfer") ? "bg-transfer" : 
                             (type.equalsIgnoreCase("withdrawal") ? "bg-withdraw" : "bg-deposit");
    %>
    <tr>
        <td class="ps-4"><small class="text-muted"><%= rs.getTimestamp("transaction_date") %></small></td>
        <td><span class="type-pill <%= pill %>"><%= type %></span></td>
        <td>
            <strong><%= rs.getString("sender_account_id") %></strong> 
            <% if(rs.getString("receiver_account_id") != null && !rs.getString("receiver_account_id").isEmpty()) { %>
                <i class="bi bi-arrow-right text-muted mx-1"></i> <%= rs.getString("receiver_account_id") %>
            <% } %>
        </td>
        <td class="fw-bold text-dark"><%= String.format("%,.2f", rs.getDouble("amount")) %></td>
        
        <td>
            <div class="d-flex align-items-center">
                <span class="text-secondary small"><%= String.format("%,.0f", prevBal) %></span>
                <i class="bi bi-arrow-right-short mx-2 text-primary"></i>
                <span class="fw-bold text-dark"><%= String.format("%,.0f", newBal) %></span>
                
                <%-- Visual Indicator: Up for Deposit, Down for Withdrawal --%>
                <% if (newBal > prevBal) { %>
                    <i class="bi bi-caret-up-fill text-success ms-2 small"></i>
                <% } else if (newBal < prevBal) { %>
                    <i class="bi bi-caret-down-fill text-danger ms-2 small"></i>
                <% } %>
            </div>
        </td>
        
        <td class="pe-4"><span class="badge bg-success-subtle text-success border border-success-subtle">Success</span></td>
    </tr>
    <%
            }
            con.close();
        } catch(Exception e) {
            out.println("<tr><td colspan='6' class='text-center p-4 text-danger'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>
</tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Real-time Search and Type filtering
    function filterAudit() {
        const input = document.getElementById("logSearch").value.toUpperCase();
        const type = document.getElementById("typeFilter").value.toUpperCase();
        const rows = document.getElementById("auditTable").getElementsByTagName("tr");

        for (let i = 1; i < rows.length; i++) {
            const text = rows[i].innerText.toUpperCase();
            const rowType = rows[i].cells[1].innerText.toUpperCase();
            rows[i].style.display = (text.includes(input) && (type === "" || rowType.includes(type))) ? "" : "none";
        }
    }

    // Export Table Data to CSV (Excel compatible)
    function downloadCSV() {
        let csv = [];
        const rows = document.querySelectorAll("table tr");
        for (const row of rows) {
            if (row.style.display !== "none") {
                const cols = row.querySelectorAll("td, th");
                const rowData = Array.from(cols).map(c => '"' + c.innerText.replace(/\n/g, ' ') + '"');
                csv.push(rowData.join(","));
            }
        }
        const csvFile = new Blob([csv.join("\n")], { type: "text/csv" });
        const link = document.createElement("a");
        link.download = "CBE_Audit_Report_<%= viewMode %>_<%= LocalDate.now() %>.csv";
        link.href = window.URL.createObjectURL(csvFile);
        link.click();
    }
</script>
</body>
</html>