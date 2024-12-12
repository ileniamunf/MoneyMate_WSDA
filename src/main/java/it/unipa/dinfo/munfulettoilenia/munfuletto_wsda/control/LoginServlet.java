package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.control;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils.*;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Utente;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Titolare;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Admin;
import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Negoziante;

import java.io.PrintWriter;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(request.getSession().getAttribute("Negoziante") != null){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/Negoziante.jsp");
            dispatcher.forward(request, response);
            return;

        }else if(request.getSession().getAttribute("Titolare") != null){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/Titolare.jsp");
            dispatcher.forward(request, response);
            return;

        } else if(request.getSession().getAttribute("Admin") != null){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/Admin.jsp");
            dispatcher.forward(request, response);
            return;
        }
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mail = request.getParameter("email");
        String password = request.getParameter("password");


        //Validazione input server-side
        Pattern patternEmail = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");
        Pattern patternPw = Pattern.compile("^(.|\\s)*\\S(.|\\s)*$");
        Matcher emailMatcher = patternEmail.matcher(mail);
        Matcher pwMatcher = patternPw.matcher(password);


        if(emailMatcher.find() && pwMatcher.find()){
            Connessione conn = new Connessione();
            Utente utente = conn.getUtente(mail, SHA256.SHA256Hash(password));

            if(utente == null){
                HttpSession session = request.getSession();

                String error = null;

                if(session.getAttribute("stato") == null) {
                    error = "*Email e/o password non validi.";
                }
                session.setAttribute("stato", error);


                response.sendRedirect("index.jsp");


            }else {
                HttpSession session = request.getSession();
                if(session.getAttribute("Admin") != null){
                    session.removeAttribute("Admin");
                }
                if(session.getAttribute("Negoziante") != null){
                    session.removeAttribute("Negoziante");
                }
                if(session.getAttribute("Titolare") != null){
                    session.removeAttribute("Titolare");
                }

                session.setAttribute("Utente",utente);



                String address = "";

                if(utente.getTipo().equals("Titolare")){
                    Titolare titolare = conn.getTitolare(utente.getEmail());

                    if(titolare != null){
                        session.setAttribute("Titolare", titolare);
                        address = "/WEB-INF/view/Titolare.jsp";

                    }

                    
                } else if (utente.getTipo().equals("Admin")){
                    Admin admin = conn.getAdmin(utente.getEmail());

                    if(admin != null){
                        session.setAttribute("Admin", admin);
                        address = "/WEB-INF/view/Admin.jsp";

                    }


                } else if (utente.getTipo().equals("Negoziante")) {
                    Negoziante neg = conn.getNegoziante(utente.getEmail());

                    if(neg != null){
                        session.setAttribute("Negoziante", neg);
                        address = "/WEB-INF/view/Negoziante.jsp";

                    }

                }

                response.setStatus(200);
                RequestDispatcher dispatcher = request.getRequestDispatcher(address);
                dispatcher.forward(request, response);
            }
        }else{
            response.setStatus(500);
            response.sendRedirect("errore.jsp");
        }

    }



}
