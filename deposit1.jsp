
<html>
    <head>
        <link rel="stylesheet"href="ccs/newcss2.css">
        <link rel="stylesheet"href="ccs/newcss1.css">
    </head>
    <div id="header">
			     <center><img src="image/Logo.png" alt="business" width="150" height="150"></center><br>
				<h1>COMMERCIAL BANK OF ETHIOPIA <span class="style1"></span></h1>
				<h2>The Bank You Can Always Rely On</h2>
				<A href="index.html"><img   alt="Home Button" src="image/home1.gif"></A>
			</div>
		
			<div id="navigation">
				
				<ul>
				    <li><a href="create.html">NEW ACCOUNT</a></li>
				    <li><a href="balance1.jsp">BALANCE</a></li>
				    <li><a href="deposit1.jsp">DEPOSIT</a></li>
				    <li><a href="withdraw1.jsp">WITHDRAW</a></li>
				    <li><a href="transfer1.jsp">TRANSFER</a></li>
				    <li><a href="closeac1.jsp">CLOSE A/C</a></li>
				    <li><a href="about.jsp">ABOUT US</a></li>
			    </ul>
				
			</div>
<div id="welcome">
    <div style="display: flex; justify-content: center; align-items: center;">
 <img  src="image/Logo.png"width="150" height="150">
</div>
           
    <h1>DEPOSIT FUNDS</h1>

   <form name="F1" onsubmit="return dil(this)" action="DepositServlet.jsp" method="post">
        <table align="center">
            <tr><td>ACCOUNT NO:</td><td><input type="text" name="accountno"/></td></tr>
            <tr><td>USERNAME:</td><td><input type="text" name="username"/></td></tr>
            <tr><td>PASSWORD:</td><td><input type="password" name="password"/></td></tr>
            <tr><td>AMOUNT ($):</td><td><input type="text" name="amount"/></td></tr>
            <tr>
                <td></td>
                <td>
                    <input type="submit" value="Deposit"/>
                    <input type="reset" value="CLEAR">
                </td>
            </tr>
        </table>
    </form>
    </html>
    

    <% if(request.getAttribute("msg") != null) { %>
        <div class="message" style="color: #28a745; background: #e8f5e9; border: 1px solid #28a745;">
            <%= request.getAttribute("msg") %>
        </div>
    <% } %>
</div>
<body>
  <div id="footer-placeholder"></div>

  <script>
    fetch('footer.html')
      .then(response => response.text())
      .then(data => {
        document.getElementById('footer-placeholder').innerHTML = data;
      });
  </script>
</body>