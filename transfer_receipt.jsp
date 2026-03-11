<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE Transfer Receipt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Courier New', monospace; background: #f4f7f6; }
        .receipt-card { max-width: 800px; margin: 30px auto; background: white; padding: 40px; border-top: 10px solid #4B0082; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .bank-logo { color: #4B0082; font-weight: 800; border-bottom: 2px solid #FFD700; padding-bottom: 10px; }
        .data-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px dashed #ddd; }
        .label { color: #666; font-size: 0.9rem; }
        .value { font-weight: bold; color: #111; }
        @media print { .no-print { display: none; } }
    </style>
</head>
<body>
    <div class="receipt-card">
        <div class="text-center mb-4">
              <img src="image/Logo.png" alt="CBE Logo" width="60" class="me-3">
            <h2 class="bank-logo">COMMERCIAL BANK OF ETHIOPIA</h2>
            <p class="small text-muted">Official Fund Transfer Advice</p>
        </div>

        <div class="data-row"><span class="label">Reference No:</span> <span class="value">FT<%= System.currentTimeMillis()/1000 %></span></div>
        <div class="data-row"><span class="label">Date:</span> <span class="value"><%= new java.util.Date() %></span></div>
        <hr>
        <div class="data-row"><span class="label">Sender Name:</span> <span class="value"><%= request.getAttribute("senderName") %></span></div>
        <div class="data-row"><span class="label">From Account:</span> <span class="value"><%= request.getAttribute("fromAcc") %></span></div>
        <div class="data-row"><span class="label">To Account:</span> <span class="value"><%= request.getAttribute("toAcc") %></span></div>
        <hr>
        <div class="data-row" style="background: #fdfae6; padding: 15px;"><span class="label">Transfer Amount:</span> <span class="value" style="font-size: 1.5rem;"><%= request.getAttribute("amount") %> ETB</span></div>
        <div class="data-row"><span class="label">Remaining Balance:</span> <span class="value text-success"><%= request.getAttribute("newBal") %> ETB</span></div>

        <div class="mt-5 text-center no-print">
            <button class="btn btn-primary" onclick="window.print()">Print Receipt</button>
            <a href="transfer1.jsp" class="btn btn-secondary">New Transfer</a>
        </div>
    </div>
</body>
</html>