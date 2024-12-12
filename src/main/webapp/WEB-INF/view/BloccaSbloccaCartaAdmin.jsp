<%@ page import="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Carta" %>

<html>
<head>
    <title>Blocca/Sblocca Carta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="styles.css" rel="stylesheet">
    <script src="jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">
    <style>
        #resultTable tr {
            margin-bottom: 1rem;
        }

        #resultTable tr:last-child {
            margin-bottom: 0rem;
        }

        #resultTable td, th {
            padding: .5rem;
        }

    </style>

    <script type="text/javascript">
        $(document).ready(function(){
            let cardJSON;

            $(window).click(function(){
                $("#numCard").removeClass("isInvalid");
                $("#numCard").removeClass("isValid");
            });

            $("#numCard").keyup(function(ev) {
                let value = $("#numCard").val();

                if ((value.length == 4 || value.length == 9 || value.length == 14) && ev.keyCode != 8) { //keycode = 8 è il cancella
                    $("#numCard").val(value + " ");
                }


                let addonImg = document.createElement("img");
                addonImg.width = 32;
                addonImg.height= 32;
                addonImg.src = "img/creditcard.svg";

                if(value.length == 19){
                    let v = $("#numCard").val().replaceAll(" ", "");
                    const visa = new RegExp("^4[0-9]{12}(?:[0-9]{3})?");
                    const mastercard = new RegExp("^5[1-5][0-9]{14}");
                    const amex = new RegExp("^3[47][0-9]{13}");

                    if(visa.test(v) ){
                        addonImg.src = "img/visa.svg";
                    }
                    if(mastercard.test(v) ){
                        addonImg.src="img/mastercard.svg";
                    }
                    if(amex.test(v) ){
                        addonImg.src = "img/amex.svg";
                    }
                    $("#basic-addon2").html(addonImg);
                } else{
                    $("#basic-addon2").html("");
                }
            });


            $('body').on('submit','#cercaCartaForm2',function(ev){
                ev.preventDefault();

                if($("#numCard")[0].checkValidity()){
                    $.post("${pageContext.request.contextPath}/RicercaCartaServlet", {
                        numCard: $("#numCard").val().replaceAll(" ", "")
                    }, function (data,status){
                        if(status == "success" && data != ""){
                             cardJSON = JSON.parse(data);


                            let table = "<table id='resultTable' style='margin-inline: auto; margin-bottom: 0.55rem; width: 85%;'>"+
                                "<tr style='font-size: 26px; text-align: center'>" +
                                "<td colspan='3'><strong>Saldo:</strong></td>"+
                                "</tr>" +
                                "<tr style='font-size: 54px; text-align: center'>" +
                                "<td colspan='3' style='margin-top: -3px'> &euro; " + "<strong>" + Number.parseFloat(cardJSON.Saldo).toLocaleString("it-IT", { minimumFractionDigits: 2 }) + "</strong>" + "</td>"+
                                "</tr>" +
                                "<tr class='row'>" +
                                "</tr>" +
                                "<tr>" +
                                "<td>Numero Carta:</td>"+

                                "<td style='text-align: right; font-size: 26px'>" + "<strong>" + cardJSON["Numero Carta"] + "</strong>" + "</td>"+
                                "</tr>" +
                                "<tr>" +
                                "<td>E-mail Titolare:</td>"+

                                "<td style='text-align: right; font-size: 26px'>" + "<strong>" + cardJSON["Email Titolare"] + "</strong>"+"</td>"+
                                "</tr>" +
                                "<tr>" +
                                "<td>Data Scadenza:</td>"+

                                "<td style='text-align: right; font-size: 26px'>" + "<strong>" + cardJSON["Data di scadenza"] + "<strong>" + "</td>"+
                                "</tr>" +
                                "<td>Stato:</td>"+

                                "<td id='stato' style='text-align: right; font-size: 26px;'>" + "<strong>" + cardJSON["Stato"] + "<strong>" + "</td>"+
                                "</tr>" +
                                "</table>" +
                                "<form id='bloccaSbloccaCartaForm' method='post' action='BloccaSbloccaCartaServlet'>" +
                                    " <input type='hidden' value='" + cardJSON['Numero Carta'] + " ' class='form-control' name='hidNumCard' id='hidNumCard' placeholder='XXXX XXXX XXXX XXXX' maxlength='19' pattern='^([0-9]{4} ){3}[0-9]{4}$'/>" +
                                    " <input type='hidden'  name='op' id='op' />" +
                                    "<div class='row'>" +
                                        "<div class='col'>" +
                                            "<button id='indietro' type='button'>Indietro</button>"+
                                        "</div>" +
                                        "<div class='col'>" +
                                            "<button id='bloccaSblocca' type='submit'></button>"+
                                        "</div>" +
                                    "</div>" +
                                "</form>";

                            $("#resultBS").html(table);

                            $("#cercaCartaForm2").removeClass("compari");
                            $("#cercaCartaForm2").addClass("sparisci");

                            $("#resultBS").removeClass("sparisci");
                            $("#resultBS").addClass("compari");


                            $("body").on("click", "#indietro", function(){
                                $("#resultBS").addClass('sparisci');
                                $("#resultBS").removeClass('compari');

                                $("#cercaCartaForm2").removeClass('sparisci');
                                $("#cercaCartaForm2").addClass('compari');
                            });


                            $("body").on("submit", "#bloccaSbloccaCartaForm", function(ev){
                               ev.preventDefault();

                               $.post("BloccaSbloccaCartaServlet", {
                                   hidNumCard: $("#hidNumCard").val().replaceAll(" ", ""),
                                   op: $("#op").val()
                               }, function(data,status){
                                   if(status == "success"){
                                       window.location.reload();
                                   }
                               })
                            });


                            if(cardJSON["Stato"] == "Attiva"){
                                $("#op").val("Blocca");
                                $("#stato").css("color","green");
                                $("#bloccaSblocca").html("Blocca");
                            }else {
                                $("#op").val("Sblocca");
                                $("#stato").css("color","red");
                                $("#bloccaSblocca").html("Sblocca");
                            }
                        } else{
                            $("#resultBS").html("");
                            $("#numCard").removeClass("isValid");
                            $("#numCard").addClass("isInvalid");
                        }
                    });
                }

                ev.stopPropagation();

            });

            let esitoModal = new bootstrap.Modal($("#esitoModal"));
            if(esitoModal != undefined){
                esitoModal.show();
            }
        });
    </script>
</head>
<body style="overflow: hidden;">
<jsp:include page="../componenti/NavbarAdmin.jsp"/>
<div style="position:relative; top:80px; padding:10px; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%); width: 100%; height: 100%;">
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Blocca/Sblocca Carta</strong> </h1>
    <p style="text-align: center; font-size: 20px; position: relative; top:10px;"> Inserisci il numero della carta per bloccarla o sbloccarla.</p>

    <div id="btnContainer">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'LoginServlet'"></button>
        <svg id=backArrow xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <form id="cercaCartaForm2" class="mx-auto compari">
        <label for="numCard" class="form-label" id="labelNumCard">Numero Carta:</label>

        <div class="input-group mb-3" id="inputContainer">
            <input type="text" class="form-control" name="numCard" id="numCard" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" pattern="^([0-9]{4} ){3}[0-9]{4}$" required="required"/>
            <span class="input-group-text" id="basic-addon2"></span>
        </div>
        <button id="btnCerca" class="mx-auto" type="submit">Cerca Carta</button>
    </form>

    <div id="resultBS" class='sparisci' style="top: 150px; text-align: center; height: 54vh"></div>
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
