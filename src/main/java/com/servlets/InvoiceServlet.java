package com.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class InvoiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Update your DB credentials here
    private static final String DB_URL = "jdbc:mysql://localhost:3306/newminilogix2";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Gogo@2003";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch details from the booking form
        String userEmail = request.getParameter("userEmail");  // Pass from session or form
        String cargoType = request.getParameter("cargoType");  // Air Cargo or Land Cargo
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String vehicleType = request.getParameter("vehicleType");
        String transportId = request.getParameter("transportId"); // Flight or Train ID
        String quantity = request.getParameter("quantity");
        String weight = request.getParameter("weight");
        String rate = request.getParameter("rate");

        // Generate unique shipping ID
        String shippingId = "SHIP-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load JDBC driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Insert shipment into DB
            String sql = "INSERT INTO shipments " +
                         "(shipping_id, user_email, cargo_type, pickup_location, drop_location, vehicle_type, transport_id, quantity, weight, rate) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, shippingId);
            ps.setString(2, userEmail);
            ps.setString(3, cargoType);
            ps.setString(4, pickup);
            ps.setString(5, drop);
            ps.setString(6, vehicleType);
            ps.setString(7, transportId);
            ps.setInt(8, Integer.parseInt(quantity));
            ps.setDouble(9, Double.parseDouble(weight));
            ps.setDouble(10, Double.parseDouble(rate));

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Pass shippingId to invoice.jsp
                request.setAttribute("shippingId", shippingId);
                request.getRequestDispatcher("invoice.jsp").forward(request, response);
            } else {
                response.sendRedirect("userDashboard.jsp?error=invoiceFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("userDashboard.jsp?error=exception");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
