package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Carta;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.SHA256;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "AggiungiCartaServlet", value = "/AggiungiCartaServlet")
public class AggiungiCartaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/AggiungiCartaAdmin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }

        String email = request.getParameter("emailCarta");
        String numCard = request.getParameter("newNumeroCarta");

        Date dataScadenza = null;
        try {
            dataScadenza = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("newDataScadenzaCarta"));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        String cvv = request.getParameter("newCVVCarta");
        Float saldo = Float.parseFloat(request.getParameter("newSaldoCarta"));

        //Validazione input server-side
        Pattern patternEmail = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
        Pattern patternCard = Pattern.compile("^([0-9]{4} ){3}[0-9]{4}$");
        Pattern patternCvv = Pattern.compile("[0-9]{3}");
        Matcher emailMatcher = patternEmail.matcher(email);
        Matcher cardMatcher = patternCard.matcher(numCard);
        Matcher cvvMatcher = patternCvv.matcher(cvv);

        int codeOp = 0;
        if(emailMatcher.find() && cardMatcher.find() && cvvMatcher.find()){
            Connessione conn = new Connessione();

            if(conn.cercaUtente(email)){
                Carta newCard =  new Carta(email, numCard.replace(" ",""), dataScadenza, SHA256.SHA256Hash(cvv), saldo);

                if(conn.insertCarta(newCard)){

                    codeOp = 1;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Carta aggiunta correttamente.\"}");
                } else {

                    codeOp = 2;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Non e&grave; stato possibile aggiungere la carta.\"}");
                }
            }else {
                codeOp = 4;
                request.getSession().setAttribute("codeOp", codeOp);
                request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Utente inesistente!\"}");

            }

        }

        request.removeAttribute("emailCarta");
        request.removeAttribute("newNumeroCarta");
        request.removeAttribute("newDataScadenzaCarta");
        request.removeAttribute("newCVVCarta");
        request.removeAttribute("newSaldoCarta");

        doGet(request, response);



    }
}
