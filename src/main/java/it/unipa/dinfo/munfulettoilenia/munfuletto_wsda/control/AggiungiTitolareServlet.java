package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Titolare;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.SHA256;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "AggiungiTitolareServlet", value = "/AggiungiTitolareServlet")
public class AggiungiTitolareServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/AggiungiTitolareAdmin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }

        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");

        Date dataNascita = null;
        try {
            dataNascita = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataNascita"));
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        String CF = request.getParameter("CF");
        String numTel = request.getParameter("numTel");
        String citta = request.getParameter("citta");
        String email= request.getParameter("emailTitolare");
        String pass= request.getParameter("pass");


        //Validazione server-side input
        Pattern patternEmail = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
        Pattern patternPass = Pattern.compile("^(.|\\s)*\\S(.|\\s)*$");
        Pattern patternCitta = Pattern.compile("^([A-Z][a-z]+(\\s?))+$");
        Pattern patternNumTel = Pattern.compile("^(38|34|36|33|32)\\d{8}$");
        Pattern patternNome = Pattern.compile("^([A-Z][a-z]+(\\s?))+$");
        Pattern patternCognome = Pattern.compile("^([A-Z][a-z]+(\\s?))+$");
        Matcher emailMatcher = patternEmail.matcher(email);
        Matcher passMatcher = patternPass.matcher(pass);
        Matcher cittaMatcher = patternCitta.matcher(citta);
        Matcher numTelMatcher = patternNumTel.matcher(numTel);
        Matcher nomeMatcher = patternNome.matcher(nome);
        Matcher cognomeMatcher = patternCognome.matcher(cognome);



        int codeOp = 0;
        if(emailMatcher.find() && passMatcher.find() && cittaMatcher.find() && numTelMatcher.find() && nomeMatcher.find() && cognomeMatcher.find()){
            Connessione connessione = new Connessione();

            if(connessione.cercaUtente(email)){
                //Utente Esistente
                codeOp = 2;
                request.getSession().setAttribute("codeOp", codeOp);
                request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Utente già esistente!\"}");
            }else {
                Titolare titolare = new Titolare(email, SHA256.SHA256Hash(pass), nome, cognome, dataNascita, CF, numTel, citta);

                if(connessione.insertTitolare(titolare)){
                    codeOp = 1;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Titolare aggiunto correttamente.\"}");

                }else{
                    codeOp = 4;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Non e&grave; stato possibile aggiungere il nuovo Titolare.\"}");

                }
            }
        }else{
            response.setStatus(500);
            response.sendRedirect("errore.jsp");
        }



    }
}
