<%@ page import="java.sql.*,jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    HttpSession sessionUser = request.getSession(false);
    if(sessionUser == null || sessionUser.getAttribute("email")==null){
        response.sendRedirect("login.jsp?error=notLoggedIn");
        return;
    }

    String email = (String)sessionUser.getAttribute("email");
    String fname="", lname="", contact="";
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/newminilogix2","root","Gogo@2003");
        PreparedStatement ps = con.prepareStatement(
            "SELECT first_name,last_name,contact FROM users WHERE email=?");
        ps.setString(1,email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            fname=rs.getString(1);
            lname=rs.getString(2);
            contact=rs.getString(3);
        }
        con.close();
    }catch(Exception e){ out.print("DB Error: "+e); }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<link rel="stylesheet" href="css/style.css">
<script src="js/dashboard.js" defer></script>
<style>
.dashboard { display:flex; min-height:100vh; }
.sidebar { width:250px; background:#007bff; color:#fff; padding:20px; }
.content { flex:1; padding:20px; position:relative;}
.profile-btn { position:absolute; top:10px; right:10px; cursor:pointer; }
.profile-card { display:none; position:absolute; top:50px; right:10px;
    background:#fff; padding:15px; border-radius:10px; box-shadow:0 4px 8px rgba(0,0,0,0.2);}
.form-section{margin-top:20px;}
.hidden {display:none;}
</style>
</head>
<body>
<div class="dashboard">
    <div class="sidebar">
        <h2>MiniLogix</h2>
        <ul>
            <li><button onclick="showSection('book')">📦 Book Shipment</button></li>
            <li><button onclick="showSection('track')">🔍 Track Shipment</button></li>
            <li><button onclick="showSection('history')">🧾 Order History</button></li>
        </ul>
    </div>
    <div class="content">
        <div class="profile-btn" onclick="toggleProfile()">👤</div>
        <div class="profile-card" id="profileCard">
            <p><b>Name:</b> <%=fname%> <%=lname%></p>
            <p><b>Email:</b> <%=email%></p>
            <p><b>Contact:</b> <%=contact%></p>
        </div>

        <!-- Book Shipment -->
        <div id="book" class="form-section">
            <h3>Book Shipment</h3>
            <label><input type="radio" name="cargoType" value="air" onclick="toggleCargo('air')"> Air Cargo</label>
            <label><input type="radio" name="cargoType" value="land" onclick="toggleCargo('land')"> Land Cargo</label>

            <!-- Air Cargo Form -->
            <div id="airForm" class="hidden">
                <form action="BookShipmentServlet" method="post">
                    <input type="hidden" name="cargoType" value="air">
                    <label>Pickup Location:</label>
                    <input type="text" name="pickup"><br>
                    <label>Drop Location:</label>
                    <input type="text" name="drop"><br>
                    <label>Consignment Quantity:</label>
                    <input type="number" name="quantity" min="1"><br>
                    <label>Weight (kg):</label>
                    <input type="number" name="weight" min="1"><br>
                    <button type="button" onclick="fetchFlights()">Show Available Flights</button>
                    <select name="flightId" id="flightSelect"></select><br>
                    <div id="vehicleOptions" class="hidden">
                        <p>Select Final Delivery Vehicle:</p>
                        <select name="vehicle">
                            <option value="2wheeler">Two Wheeler</option>
                            <option value="3wheeler">Three Wheeler</option>
                            <option value="4wheeler">Four Wheeler</option>
                            <option value="6wheeler">Six Wheeler</option>
                        </select>
                    </div>
                    <button type="submit">Book Air Shipment</button>
                </form>
            </div>

            <!-- Land Cargo Form -->
            <div id="landForm" class="hidden">
                <form action="BookShipmentServlet" method="post">
                    <input type="hidden" name="cargoType" value="land">
                    <label>Pickup Location:</label>
                    <input type="text" name="pickup"><br>
                    <label>Drop Location:</label>
                    <input type="text" name="drop"><br>
                    <label>Consignment Quantity:</label>
                    <input type="number" name="quantity" min="1"><br>
                    <label>Weight (kg):</label>
                    <input type="number" name="weight" min="1"><br>
                    <button type="button" onclick="fetchTrains()">Show Available Trains</button>
                    <select name="trainId" id="trainSelect"></select><br>
                    <p>Select Delivery Vehicle:</p>
                    <select name="vehicle">
                        <option value="2wheeler">Two Wheeler</option>
                        <option value="3wheeler">Three Wheeler</option>
                        <option value="4wheeler">Four Wheeler</option>
                        <option value="6wheeler">Six Wheeler</option>
                    </select>
                    <button type="submit">Book Land Shipment</button>
                </form>
            </div>
        </div>

        <!-- Track Shipment -->
        <div id="track" class="form-section hidden">
            <h3>Track Shipment</h3>
            <form action="TrackShipmentServlet" method="get">
                <label>Enter Shipping ID:</label>
                <input type="text" name="shipId">
                <button type="submit">Track</button>
            </form>
        </div>

        <!-- Order History -->
        <div id="history" class="form-section hidden">
            <h3>Your Order History</h3>
            <div id="historyList">
                <!-- Fill via servlet -->
            </div>
        </div>
    </div>
</div>
</body>
</html>
