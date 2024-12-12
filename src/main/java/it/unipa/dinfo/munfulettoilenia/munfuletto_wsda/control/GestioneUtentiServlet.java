package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "GestioneUtentiServlet", value = "/GestioneUtentiServlet")
public class GestioneUtentiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/GestisciUtenteAdmin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
