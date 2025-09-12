package com.servlets;

import java.sql.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Update these with your own database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/newminilogix2";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Gogo@2003";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            // Load MySQL driver and connect
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Insert query
            String sql = "INSERT INTO users (first_name, last_name, email, contact, password) VALUES (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, contact);
            ps.setString(5, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Registration successful → redirect to login.jsp
                response.sendRedirect("login.jsp?registered=true");
            } else {
                // Failed → reload register page with error
                response.sendRedirect("register.jsp?error=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=exception");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
