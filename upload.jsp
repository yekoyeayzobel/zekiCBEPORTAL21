<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String accNo = request.getParameter("accNo");
    String cameraData = request.getParameter("cameraData");
    InputStream inputStream = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank", "root", "");

        // 1. የካሜራ ፎቶ ከሆነ (Base64)
        if (cameraData != null && cameraData.startsWith("data:image")) {
            String base64Image = cameraData.split(",")[1];
            byte[] imageBytes = Base64.getDecoder().decode(base64Image);
            inputStream = new ByteArrayInputStream(imageBytes);
        } 
        
        // 2. ከፋይል የተመረጠ ፎቶ ከሆነ
        if (inputStream == null) {
            try {
                Part filePart = request.getPart("filePhoto");
                if (filePart != null && filePart.getSize() > 0) {
                    inputStream = filePart.getInputStream();
                }
            } catch (Exception e) { /* Multipart config ካልተስተካከለ */ }
        }

        if (inputStream != null && accNo != null) {
            // ፎቶውን በዳታቤዝ ውስጥ ማዘመን
            PreparedStatement ps = conn.prepareStatement("UPDATE account SET photo = ? WHERE accountnumber = ?");
            ps.setBinaryStream(1, inputStream);
            ps.setString(2, accNo);
            
            int rowAffected = ps.executeUpdate();
            ps.close();

            if (rowAffected > 0) {
                // በስኬት ከተቀየረ የሚታይ መልዕክት
                out.println("<script>");
                out.println("alert('✅ Customer Profile Successfully Updated!');");
                out.println("window.location='search.jsp?accNo=" + accNo + "';");
                out.println("</script>");
            } else {
                // አካውንቱ ዳታቤዝ ውስጥ ካልተገኘ
                out.println("<script>alert('❌ Error: Account number not found.'); history.back();</script>");
            }
        } else {
            // ምንም ምስል ካልተላከ
            out.println("<script>alert('⚠️ No image received! Please capture a photo or select a file.'); history.back();</script>");
        }
        
        if (conn != null) conn.close();

    } catch (Exception e) {
        // የሲስተም ስህተት ካጋጠመ (ለምሳሌ Data Truncation/Database error)
        String errorMsg = e.getMessage().replace("'", "\\'"); // ለ JavaScript ደህንነት
        out.println("<script>alert('❌ System Error: " + errorMsg + "'); history.back();</script>");
    }
%>