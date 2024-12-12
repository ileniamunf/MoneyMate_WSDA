package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Carta;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.Connessione;
import jakarta.json.Json;
import jakarta.json.JsonBuilderFactory;
import jakarta.json.JsonObject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import netscape.javascript.JSObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@WebServlet(name = "BloccaSbloccaCartaServlet", value = "/BloccaSbloccaCartaServlet")
public class BloccaSbloccaCartaServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }
        if(request.getSession().getAttribute("codeOp") == null){
            request.getSession().setAttribute("codeOp",0);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/BloccaSbloccaCartaAdmin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Admin") == null){
            response.sendRedirect("index.jsp");
            return ;
        }

        String numero = request.getParameter("hidNumCard");
        String op = request.getParameter("op");

        //Validazione input server-side
        Pattern patternNumero = Pattern.compile("^[0-9]{16}$");
        Matcher numeroMatcher = patternNumero.matcher(numero);
        Boolean isValid = numeroMatcher.find();


        String newStato;

        if(isValid){
            if(op.equals("Blocca")){
                newStato = "Bloccata";
            } else {
                newStato = "Attiva";
            }

            Connessione conn = new Connessione();


            int codeOp = 0;
            if(conn.bloccaSbloccaCarta(numero,newStato)){
                if(op.equals("Blocca")){
                    codeOp = 1; //esito positivo del blocca

                }else{
                    codeOp=3; //esito postivo dello sblocca
                }
            } else{
                if(op.equals("Blocca")){
                    codeOp = 2;   //esito negativo del blocca
                }else{
                    codeOp=4; //esito negativo dello sblocca
                }
            }

            switch (codeOp){
                case 1:
                    request.getSession().setAttribute("codeOp",codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Carta bloccata correttamente.\"}");
                    break;
                case 2:
                    request.getSession().setAttribute("codeOp",codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Non e&grave; stato possibile bloccare la carta.\"}");
                    break;
                case 3:
                    request.getSession().setAttribute("codeOp",codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Successo!\", \"Corpo\": \"Carta attivata correttamente.\"}");
                    break;
                case 4:
                    request.getSession().setAttribute("codeOp",codeOp);
                    request.getSession().setAttribute("text","{\"Titolo\":\"Errore!\", \"Corpo\": \"Non e&grave; stato possibile attivare la carta.\"}");
                    break;
                default:
                    request.getSession().setAttribute("codeOp",0);
                    request.getSession().setAttribute("text","");




            }
        }else{
            response.setStatus(500);
            response.sendRedirect("errore.jsp");
        }


    }
}
