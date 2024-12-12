package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Negoziante;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Transazione;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "AddebitaRicaricaCartaServlet", value = "/AddebitaRicaricaCartaServlet")
public class AddebitaRicaricaCartaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("Negoziante") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/AddebitaRicaricaCartaNegoziante.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("Negoziante") == null) {
            response.sendRedirect("index.jsp");
            return;
        }
        String numero = request.getParameter("numCard");
        String statoCarta = request.getParameter("statoCarta");
        String op = request.getParameter("op");
        Float importo = Float.parseFloat(request.getParameter("importo"));
        Float saldo = Float.parseFloat(request.getParameter("saldo"));
        String causale = request.getParameter("causale");


        //Validazione input server-side
        Pattern patternNumero = Pattern.compile("[0-9]{16}");
        Matcher numeroMatcher = patternNumero.matcher(numero);
        Boolean isValid = numeroMatcher.find();

        int codeOp= 0;

        if (isValid && statoCarta.equals("Attiva")) {
            Connessione conn = new Connessione();

            if (op.equals("ricarica")) {
                if (conn.ricaricaCarta(numero, importo)) {
                    codeOp = 1;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Ricarica di &euro; "+ importo +" effettuata correttamente.\"}");

                    //Aggiungo transazione di ricarica
                    Negoziante neg = (Negoziante) request.getSession().getAttribute("Negoziante");
                    String oggi = java.time.LocalDate.now().toString();
                    Date today = null;
                    try {
                         today = new SimpleDateFormat("yyyy-MM-dd").parse(oggi);
                    }catch (ParseException e) {
                        throw new RuntimeException(e);
                    }



                    Transazione transazione = new Transazione(neg.getNome(),numero,op, importo, today, causale);

                    conn.addTransazione(transazione);



                } else {
                    codeOp = 2;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Si è verificato un errore con la ricarica.\"}");

                }

            } else {
                if (saldo < importo) {
                    codeOp = 4;
                    request.getSession().setAttribute("codeOp", codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Il saldo disponibile non è sufficiente.\"}");

                } else {
                    if (conn.addebitaCarta(numero, importo)) {
                        codeOp = 3;
                        request.getSession().setAttribute("codeOp", codeOp);
                        request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Addebito di &euro; "+ importo +" effettuato correttamente.\"}");


                        //Aggiungo transazione di addebito
                        Negoziante neg = (Negoziante) request.getSession().getAttribute("Negoziante");
                        String oggi = java.time.LocalDate.now().toString();
                        Date today = null;
                        try {
                            today = new SimpleDateFormat("yyyy-MM-dd").parse(oggi);
                        }catch (ParseException e) {
                            throw new RuntimeException(e);
                        }


                        Transazione transazione = new Transazione(neg.getNome(),numero,op, -importo, today, causale);

                        conn.addTransazione(transazione);


                    } else {
                        codeOp = 5;
                        request.getSession().setAttribute("codeOp", codeOp);
                        request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Si è verificato un errore con l'addebito.\"}");

                    }

                }
            }


        }else{
            response.setStatus(500);
            response.sendRedirect("errore.jsp");
        }


    }
}
