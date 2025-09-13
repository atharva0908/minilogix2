package com.servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import java.util.UUID;

public class BookShipmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String cargoType=req.getParameter("cargoType");
        String pickup=req.getParameter("pickup");
        String drop=req.getParameter("drop");
        int quantity=Integer.parseInt(req.getParameter("quantity"));
        int weight=Integer.parseInt(req.getParameter("weight"));
        String vehicle=req.getParameter("vehicle");
        String email=(String)req.getSession().getAttribute("email");

        String shippingId = "SHIP-" + UUID.randomUUID().toString().substring(0,8);
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/newminilogix2","root","Gogo@2003");
            PreparedStatement ps=con.prepareStatement(
                "INSERT INTO shipments(email,shipping_id,cargo_type,pickup,drop_loc,quantity,weight,vehicle) VALUES(?,?,?,?,?,?,?,?)");
            ps.setString(1,email);
            ps.setString(2,shippingId);
            ps.setString(3,cargoType);
            ps.setString(4,pickup);
            ps.setString(5,drop);
            ps.setInt(6,quantity);
            ps.setInt(7,weight);
            ps.setString(8,vehicle);
            ps.executeUpdate();
            con.close();
        }catch(Exception e){throw new ServletException(e);}

        req.setAttribute("shippingId",shippingId);
        req.getRequestDispatcher("invoice.jsp").forward(req,res);
    }
}
