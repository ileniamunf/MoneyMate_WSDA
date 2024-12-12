package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;

import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@WebServlet("/RicercaCartaServlet")
public class RicercaCartaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            response.sendRedirect("ricercaCarta.jsp");


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String numCard = request.getParameter("numCard");


        //Validazione input server-side
        Pattern patternNumCard = Pattern.compile("^[0-9]{16}$");
        Matcher numCardMatcher = patternNumCard.matcher(numCard);
        Boolean isValidNumCard = numCardMatcher.find();


        if(isValidNumCard){
            Connessione conn = new Connessione();
            String card = conn.getCarta(numCard);
            PrintWriter pw = response.getWriter();
            pw.write(card);

        }


    }
}
