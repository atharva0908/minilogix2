<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Invoice</title></head>
<body>
<h2>Shipment Invoice</h2>
<p>Your Shipment ID: <b><%=request.getAttribute("shippingId")%></b></p>
<a href="payment.jsp?shipId=<%=request.getAttribute("shippingId")%>">Proceed to Payment</a>
</body>
</html>
