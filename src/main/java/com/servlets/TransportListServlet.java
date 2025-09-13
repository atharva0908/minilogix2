package com.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class TransportListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Map<String, String>> flightList = new ArrayList<>();
        List<Map<String, String>> trainList  = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/newminilogix2", "root", "Gogo@2003");

            String query = "SELECT transport_id,name,type,source,destination,departure_time,arrival_time FROM transport";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String,String> t = new HashMap<>();
                t.put("id", rs.getString("transport_id"));
                t.put("name", rs.getString("name"));
                t.put("type", rs.getString("type")); // 'Flight' or 'Train'
                t.put("source", rs.getString("source"));
                t.put("destination", rs.getString("destination"));
                t.put("departure", rs.getString("departure_time"));
                t.put("arrival", rs.getString("arrival_time"));

                if ("Flight".equalsIgnoreCase(t.get("type"))) {
                    flightList.add(t);
                } else if ("Train".equalsIgnoreCase(t.get("type"))) {
                    trainList.add(t);
                }
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            throw new ServletException("Error fetching transport data", e);
        }

        // ✅ Send two separate lists
        request.setAttribute("flightList", flightList);
        request.setAttribute("trainList", trainList);

        RequestDispatcher rd = request.getRequestDispatcher("userDashboard.jsp");
        rd.forward(request, response);
    }
}
