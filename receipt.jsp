<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CBE_Official_Receipt_<%= request.getAttribute("txnId") %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Courier New', Courier, monospace; background-color: #f8f9fa; }
        .receipt-container { 
            width: 100%; max-width: 1100px; margin: 20px auto; 
            background: #fff; padding: 30px; border: 1px solid #333;
        }
        .bank-header { border-bottom: 3px solid #4a148c; margin-bottom: 20px; padding-bottom: 10px; }
        .table-receipt { width: 100%; border-collapse: collapse; margin-bottom: 20px; table-layout: fixed; }
        .table-receipt th, .table-receipt td { 
            border: 1px solid #ccc; padding: 10px; text-align: left; 
            word-wrap: break-word; overflow-wrap: break-word;
        }
        .table-receipt th { background-color: #f8f4ff; font-size: 0.75rem; color: #4a148c; }
        .amount-cell { font-family: 'Arial', sans-serif; font-weight: bold; font-size: 1.2rem; }
        .status-badge { font-size: 0.8rem; padding: 5px 10px; border-radius: 4px; }
        @media print { 
            .no-print { display: none; } 
            .receipt-container { border: none; width: 100%; max-width: 100%; margin: 0; }
        }
    </style>
</head>
<body>

<div class="receipt-container shadow-lg">
    <div class="bank-header d-flex justify-content-between align-items-center">
        <div class="d-flex align-items-center">
            <img src="image/Logo.png" alt="CBE Logo" width="60" class="me-3">
            <div>
                <h2 class="mb-0" style="color: #4a148c; font-weight: 800;">COMMERCIAL BANK OF ETHIOPIA</h2>
                <p class="mb-0">TIN: 0000006966 | VAT: 011140 | SWIFT: CBETETAA</p>
            </div>
        </div>
        <div class="text-end">
            <h4 class="text-muted mb-0">OFFICIAL TRANSACTION SLIP</h4>
            <small>Printed on: <%= new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new java.util.Date()) %></small>
        </div>
    </div>

    <%-- Customer & Reference Row --%>
    <table class="table-receipt">
        <thead>
            <tr>
                <th>Customer Name</th>
                <th>Account Number</th>
                <th>Reference Number</th>
                <th>Transaction Type</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><strong><%= request.getAttribute("username") != null ? request.getAttribute("username").toString().toUpperCase() : "N/A" %></strong></td>
                <td><%= request.getAttribute("accountnumber") %></td>
                <td><strong><%= "TXN-" + System.currentTimeMillis() / 1000 %></strong></td>
                <td><span class="badge bg-primary">CASH WITHDRAWAL</span></td>
            </tr>
        </tbody>
    </table>

    <%-- Financial Details Row --%>
    <table class="table-receipt">
        <thead>
            <tr>
                <th style="width: 25%;">Previous Balance</th>
                <th style="width: 25%;">Amount Withdrawn</th>
                <th style="width: 25%;">New Balance</th>
                <th style="width: 25%;">Currency</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><%= String.format("%,.2f", (Double)request.getAttribute("oldBalance")) %></td>
                <td class="text-danger fw-bold">- <%= String.format("%,.2f", (Double)request.getAttribute("withdrawn")) %></td>
                <td class="text-success fw-bold"><%= String.format("%,.2f", (Double)request.getAttribute("newBalance")) %></td>
                <td>ETB (Ethiopian Birr)</td>
            </tr>
        </tbody>
    </table>

    <div class="row mt-4">
        <div class="col-8">
            <p><strong>Amount in Words:</strong> <br>
            <span class="fst-italic text-muted">
                <%-- Simple logic for display --%>
                <%= request.getAttribute("withdrawn") %> ETB and Zero Cents Only.
            </span></p>
            <div class="mt-4">
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=<%= request.getAttribute("accountnumber") %>-<%= request.getAttribute("withdrawn") %>" alt="QR Verification">
                <p class="small text-muted mt-1">Scan for E-Verification</p>
            </div>
        </div>
        <div class="col-4 text-center">
            <div style="border-bottom: 2px solid #000; height: 80px; width: 80%; margin: 0 auto;"></div>
            <p class="mt-2 mb-0"><strong>Bank Officer Signature</strong></p>
            <small>Commercial Bank of Ethiopia</small>
        </div>
    </div>

    <div class="footer-info mt-4 pt-3 border-top text-center">
        <p class="small mb-0">This is a system-generated electronic receipt. No physical signature is required for digital verification.</p>
        <p class="small text-muted">&copy; 2026 Commercial Bank of Ethiopia. The Bank You Can Always Rely On.</p>
    </div>

    <%-- Controls --%>
    <div class="mt-4 text-center no-print">
        <button class="btn btn-dark btn-lg px-5" onclick="window.print()">Print Receipt</button>
        <a href="withdraw1.jsp" class="btn btn-outline-secondary btn-lg ms-3">New Transaction</a>
    </div>
</div>

</body>
</html>