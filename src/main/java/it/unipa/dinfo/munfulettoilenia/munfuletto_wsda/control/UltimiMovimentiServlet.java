package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Titolare;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Transazione;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UltimiMovimentiServlet", value = "/UltimiMovimentiServlet")
public class UltimiMovimentiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Titolare") == null){
            response.sendRedirect("index.jsp");
            return ;
        }

        doPost(request, response);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/UltimiMovimentiTitolare.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connessione connessione = new Connessione();
        HttpSession session = request.getSession();

        Titolare titolare = (Titolare) session.getAttribute("Titolare");

        ArrayList<Transazione> movimenti = connessione.getTransazioni(titolare.getEmail());

        session.setAttribute("ultimiMovimenti", movimenti);
    }
}
