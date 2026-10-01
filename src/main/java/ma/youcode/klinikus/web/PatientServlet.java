package ma.youcode.klinikus.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/infirmier/patients")
public class PatientServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        // Load patients here

        request.getRequestDispatcher("/WEB-INF/views/infirmier/patients.jsp")
                .forward(request, response);
    }
}