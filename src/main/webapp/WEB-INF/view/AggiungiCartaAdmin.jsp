<html>
<head>
    <title>MoneyMate&trade; - Admin Aggiungi Carta </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">

    <script src="jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            let today = new Date();
            let min = new Date(today.setMonth(today.getMonth() + 3));
            let max = new Date(today.setFullYear(today.getFullYear() + 5));

            $("#newDataScadenzaCarta").attr("min", min.toISOString().slice(0, 10));
            $("#newDataScadenzaCarta").attr("max", max.toISOString().slice(0, 10));

            $("#newNumeroCarta").keyup(function(ev) {
                let value = $("#newNumeroCarta").val();

                if ((value.length == 4 || value.length == 9 || value.length == 14) && ev.keyCode != 8) { //keycode = 8 è il cancella
                    $("#newNumeroCarta").val(value + " ");
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
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Aggiungi Carta</strong> </h1>

    <div id="btnContainer" style="bottom: 60px;">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'LoginServlet'"></button>
       <svg id=backArrow xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <div id="buttonsContainer" class="mx-auto py-3" style="position: relative; top: -70px;">
        <form id="aggiungiCarta" action="AggiungiCartaServlet" method="post">
            <div class="mb-3" >
                <label for="emailCarta" class="form-label">Email Titolare:</label>
                <input type="email" class="form-control" name="emailCarta" id="emailCarta" placeholder="Indirizzo@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" required="required"/>
            </div>
            <div class="mb-3">
                <label for="newNumeroCarta" class="form-label">Numero Carta:</label>
                <input type="text" class="form-control" name="newNumeroCarta" id="newNumeroCarta" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" pattern="^([0-9]{4} ){3}[0-9]{4}$" required="required"/>
            </div>
            <div class="mb-3">
                <label for="newDataScadenzaCarta" class="form-label">Data di Scadenza:</label>
                <input type="date" class="form-control" name="newDataScadenzaCarta" id="newDataScadenzaCarta" placeholder="YYYY-MM-DD" maxlength="10" required="required"/>
            </div>
            <div class="mb-3">
                <label for="newCVVCarta" class="form-label">CVV:</label>
                <input type="text" class="form-control" name="newCVVCarta" id="newCVVCarta" placeholder="123" maxlength="3" required="required" pattern="[0-9]{3}"/>
            </div>
            <div class="mb-3">
                <label for="newSaldoCarta" class="form-label">Saldo (&euro;):</label>
                <input type="text" class="form-control" name="newSaldoCarta" id="newSaldoCarta" placeholder="100.00" required="required" pattern="^\d{1,8}(\.\d{2})?$" maxlength="11"/>
            </div>

            <button id="btnAggiungiCarta" class="mt-2" type="submit" > Aggiungi Carta</button>


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
