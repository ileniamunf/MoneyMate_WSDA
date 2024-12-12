package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Negoziante;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.SHA256;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "AggiungiNegozianteServlet", value = "/AggiungiNegozianteServlet")
public class AggiungiNegozianteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/AggiungiNegozianteAdmin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }

        String nome = request.getParameter("nome");
        String attivita = request.getParameter("attivita");
        String citta = request.getParameter("citta");
        String numTel = request.getParameter("numTel");
        String email = request.getParameter("emailNegoziante");
        String pass = request.getParameter("pass");


        //Validazoine server-side input
        Pattern patternEmail = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
        Pattern patternPass = Pattern.compile("^(.|\\s)*\\S(.|\\s)*$");
        Pattern patternCitta = Pattern.compile("^([A-Z][a-z]+(\\s?))+$");
        Pattern patternNumTel = Pattern.compile("^((38|34|36|33|32)\\d{8}|0\\d{9})$");
        Matcher emailMatcher = patternEmail.matcher(email);
        Matcher passMatcher = patternPass.matcher(pass);
        Matcher cittaMatcher = patternCitta.matcher(citta);
        Matcher numTelMatcher = patternNumTel.matcher(numTel);

        int codeOp = 0;
        if(emailMatcher.find() && passMatcher.find() && cittaMatcher.find() && numTelMatcher.find()){
            Connessione connessione = new Connessione();

            if(connessione.cercaUtente(email)){
                //Utente Esistente
                codeOp = 2;
                request.getSession().setAttribute("codeOp", codeOp);
                request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Utente già esistente!\"}");
            }else{
                Negoziante negoziante = new Negoziante(email, SHA256.SHA256Hash(pass),nome,attivita,citta, numTel);

                if(connessione.insertNegoziante(negoziante)){
                    codeOp = 1;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Negoziante aggiunto correttamente.\"}");

                }else{codeOp = 4;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Non e&grave; stato possibile aggiungere il nuovo Negoziante.\"}");

                }

            }
        }else{
            response.setStatus(500);
            response.sendRedirect("errore.jsp");
        }
    }
}
