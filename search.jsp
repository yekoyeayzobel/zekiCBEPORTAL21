<%@ page import="java.sql.*, java.util.Base64, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>CBE | Full Customer Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --cbe-purple: #4b2c6d; --cbe-gold: #fdb913; }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f0f2f5; padding: 20px; }
        .container { max-width: 700px; margin: auto; background: white; padding: 30px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
        .profile-header { text-align: center; border-bottom: 2px solid var(--cbe-purple); padding-bottom: 20px; margin-bottom: 20px; }
        .photo-display img { border-radius: 50%; border: 4px solid var(--cbe-purple); object-fit: cover; width: 130px; height: 130px; background: #eee; }
        
        /* Table Styling for Information */
        .info-table { width: 100%; border-collapse: collapse; margin-top: 20px; margin-bottom: 20px; }
        .info-table td { padding: 12px; border-bottom: 1px solid #eee; }
        .info-table td.label { font-weight: bold; color: var(--cbe-purple); width: 40%; }
        
        video { width: 100%; border-radius: 10px; background: #222; transform: scaleX(-1); margin-top: 15px; }
        .btn { width: 100%; padding: 14px; cursor: pointer; border: none; border-radius: 8px; font-weight: bold; margin-top: 10px; transition: 0.3s; }
        .btn-search { background: var(--cbe-purple); color: white; }
        .btn-save { background: #28a745; color: white; }
        .btn-capture { background: var(--cbe-gold); color: #333; }
        .hidden { display: none; }
        .section-title { border-left: 5px solid var(--cbe-gold); padding-left: 10px; margin-top: 30px; color: #333; }
    </style>
</head>
<body>
<div class="container">
    <%
        String accNo = request.getParameter("accNo");
        if (accNo == null || accNo.trim().isEmpty()) { 
    %>
        <div class="profile-header">
            <i class="fas fa-university fa-3x" style="color:var(--cbe-purple)"></i>
            <h2>Customer Service Portal</h2>
        </div>
        <form method="GET">
            <input type="text" name="accNo" placeholder="Enter Account Number" style="width:100%; padding:15px; margin-bottom:15px; border:2px solid #ddd; border-radius:8px;" required>
            <button type="submit" class="btn btn-search">FETCH CUSTOMER DATA</button>
        </form>
    <% 
        } else { 
            try {
 String loggedInEmpId = (String) session.getAttribute("empId");
    if (loggedInEmpId == null) {
        response.sendRedirect("employeelogin.jsp");
        return;
    }
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");
                
                // Fetching ALL information
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM account WHERE accountnumber = ?");
                ps.setString(1, accNo);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    // Map your DB columns here
                    String name = rs.getString("username");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone"); // Assumes you have a phone column
                    String balance = rs.getString("balance"); // Assumes you have a balance column
                    String accType = rs.getString("status"); // Assumes you have this
                    
                    byte[] photoBytes = rs.getBytes("photo");
                    String base64Photo = (photoBytes != null) ? Base64.getEncoder().encodeToString(photoBytes) : null;
    %>
                <div class="profile-header">
                    <div class="photo-display">
                        <img id="currentImg" src="<%= (base64Photo != null) ? "data:image/png;base64,"+base64Photo : "https://via.placeholder.com/130" %>">
                    </div>
                    <h2><%= name %></h2>
                    <span style="background:var(--cbe-gold); padding:4px 12px; border-radius:20px; font-weight:bold;">ID: <%= accNo %></span>
                </div>

                <h3 class="section-title">Personal Details</h3>
                <table class="info-table">
                    <tr><td class="label">Full Name:</td><td><%= name %></td></tr>
                    <tr><td class="label">Email Address:</td><td><%= (email != null) ? email : "N/A" %></td></tr>
                    <tr><td class="label">Phone Number:</td><td><%= (phone != null) ? phone : "Not Linked" %></td></tr>
                    <tr><td class="label">Account Type:</td><td><%= (accType != null) ? accType : "Savings" %></td></tr>
                    <tr><td class="label">Current Balance:</td><td style="color:green; font-weight:bold;"><%= (balance != null) ? balance : "0.00" %> ETB</td></tr>
                </table>

                <h3 class="section-title">Identity Update (Biometrics)</h3>
                <form action="upload.jsp" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="accNo" value="<%= accNo %>">
                    <input type="hidden" name="cameraData" id="cameraData">

                    <video id="webcam" autoplay></video>
                    <canvas id="snapshot" class="hidden"></canvas>
                    <button type="button" class="btn btn-capture" onclick="takeSnapshot()">SCAN FACE</button>
                    
                    <div style="margin-top:15px; background:#f9f9f9; padding:10px; border-radius:5px;">
                        <label><b>Manual Upload:</b></label><br>
                        <input type="file" name="filePhoto" accept="image/*">
                    </div>

                    <button type="submit" class="btn btn-save">UPDATE CUSTOMER RECORD</button>
                    <a href="search.jsp" style="display:block; text-align:center; margin-top:15px; color:var(--cbe-purple);">Back to Lookup</a>
                </form>

                <script>
                    const video = document.getElementById('webcam');
                    const canvas = document.getElementById('snapshot');
                    const cameraInput = document.getElementById('cameraData');

                    navigator.mediaDevices.getUserMedia({ video: true })
                        .then(stream => { video.srcObject = stream; })
                        .catch(err => alert("Webcam Error: Please use HTTPS or localhost."));

                    function takeSnapshot() {
                        const context = canvas.getContext('2d');
                        canvas.width = video.videoWidth;
                        canvas.height = video.videoHeight;
                        context.translate(canvas.width, 0);
                        context.scale(-1, 1);
                        context.drawImage(video, 0, 0);
                        const dataURL = canvas.toDataURL('image/png');
                        cameraInput.value = dataURL;
                        document.getElementById('currentImg').src = dataURL;
                    }
                </script>
    <%
                } else {
                    out.println("<div style='text-align:center; padding:20px;'><h3>❌ Account Not Found</h3><a href='search.jsp'>Try Another Search</a></div>");
                }
                conn.close();
            } catch (Exception e) { out.println("<p style='color:red;'>System Error: " + e.getMessage() + "</p>"); }
        }
    %>
</div>
</body>
</html>