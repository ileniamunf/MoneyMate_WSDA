<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MoneyMate&trade; - Admin Aggiungi Titolare </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">

    <style>
        #aggiungiTitolareForm input {
            box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);
        }
    </style>

    <script src="jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            let today1 = new Date();
            let today2 = new Date();
            let min = new Date(today1.setFullYear(today1.getFullYear() - 120));
            let max = new Date(today2.setFullYear(today2.getFullYear() - 18));

            $("#dataNascita").attr("min", min.toISOString().slice(0, 10));
            $("#dataNascita").attr("max", max.toISOString().slice(0, 10));


            $("input").focus(function(){
                $("#resultPass").text("");
            });


            $("body").on("submit", "#aggiungiTitolareForm", function(ev){
                ev.preventDefault();

                let pass1 = $("#pass").val();
                let pass2 = $("#pass2").val();

                if(pass1 != pass2){
                    $("#resultPass").html("Le due password non coincidono.");
                    $("#resultPass").css("color","red");
                }

                if ($("#aggiungiTitolareForm")[0].checkValidity() && (pass1 == pass2)) {

                    $.post("${pageContext.request.contextPath}/AggiungiTitolareServlet", {
                        nome: $("#nome").val(),
                        cognome: $("#cognome").val(),
                        dataNascita: $("#dataNascita").val(),
                        CF: $("#CF").val(),
                        numTel: $("#numTel").val(),
                        citta: $("#citta").val(),
                        emailTitolare: $("#emailTitolare").val(),
                        pass: $("#pass").val()
                    }, function(data, status){
                        if(status == "success"){
                            window.location.reload();
                        }
                    });
                } else {
                    ev.preventDefault();
                    ev.stopPropagation();
                }

            });

            let esitoModal = new bootstrap.Modal($("#esitoModal"));
            if(esitoModal != undefined){
                esitoModal.show();
            }
        });
    </script>
</head>
<body style="overflow: hidden">
<jsp:include page="../componenti/NavbarAdmin.jsp"/>

<div style="position:relative; top:80px; padding:10px; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%); width: 100%; height: 100%;">
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Aggiungi Titolare</strong> </h1>

    <div id="btnContainer" style="bottom: 60px;">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'GestioneUtentiServlet'"></button>
        <svg id="backArrow" xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16" style="top: 46px;">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <div id="buttonsContainer" class="mx-auto py-3" style="position: relative; top: -70px;">
        <form id="aggiungiTitolareForm" class="container-sm" >
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="nome" class="form-label">Nome:</label>
                        <input type="text" class="form-control" name="newNome" id="nome" placeholder="Mario" maxlength="64" minlength="2" pattern="^([A-Z][a-z]+(\s?))+$" required="required"/>
                    </div>
                    <div class="mb-3">
                        <label for="cognome" class="form-label">Cognome:</label>
                        <input type="text" class="form-control" name="newCognome" id="cognome" placeholder="Rossi" maxlength="64" minlength="2" pattern="^([A-Z][a-z]+(\s?))+$" required="required"/>
                    </div>
                    <div class="mb-3">
                        <label for="dataNascita" class="form-label">Data di nascita:</label>
                        <input type="date" class="form-control" name="newDataNascita" id="dataNascita" placeholder="YYYY-MM-DD" maxlength="10" required="required"/>
                    </div>
                    <div class="mb-3">
                        <label for="CF" class="form-label">Codice Fiscale:</label>
                        <input type="text" class="form-control" name="newCF" id="CF" placeholder="RSSMRA74T03C421J" maxlength="16" required="required"/>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 px-3">
                            <label for="numTel" class="form-label">Numero di Telefono:</label>
                        </div>
                        <div class="col-sm-8">
                           <div class="input-group">
                               <span class="input-group-text">+ 39</span>
                               <input type="txt" class="form-control" name="newNumTel" id="numTel" placeholder="3214567890" maxlength="10" pattern="^(38|34|36|33|32)\d{8}$" required="required"/>
                           </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="citta" class="form-label">Citt&agrave;:</label>
                        <input type="text" class="form-control" name="newSCitta" id="citta" placeholder="Roma" required="required" pattern="^([A-Z][a-z]+(\s?))+$" maxlength="128"/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="mb-3" >
                        <label for="emailTitolare" class="form-label">Email Titolare:</label>
                        <input type="email" class="form-control" name="emailTitolare" id="emailTitolare" placeholder="Indirizzo@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" required="required"/>
                    </div>
                    <div class="mb-3" >
                        <label for="pass" class="form-label">Password:</label>
                        <input type="password" class="form-control" name="password" id="pass" placeholder="Password" pattern="^(.|\s)*\S(.|\s)*$" maxlength="64" required="required"/>
                    </div>
                    <div class="mb-3" >
                        <label for="pass2" class="form-label">Conferma Password:</label>
                        <input type="password" class="form-control" name="password2" id="pass2" placeholder="Password" pattern="^(.|\s)*\S(.|\s)*$" maxlength="64" required="required"/>
                    </div>
                    <div class="position-absolute bottom-0 right-0 pb-md-5 text-center">
                        <button id="btnAggiungiTitolare" class="position-relative mr-md-3 btn" type="submit"> Aggiungi Titolare</button>
                    </div>
                    <p id="resultPass"></p>
                </div>
            </div>
        </form>
    </div>
</div>


<jsp:include page="../componenti/Footer.jsp"/>

<%  if(Integer.parseInt(session.getAttribute("codeOp").toString()) != 0) {%>

<jsp:include page="/WEB-INF/componenti/Modal.jsp" />

<%
        session.removeAttribute("codeOp");
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
