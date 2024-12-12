<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Carta" %>
<html>
<head>
    <title>MoneyMate&trade; - Negoziante Addebita/Ricarica Carta</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link href="styles.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">
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
                    }, function (data,status) {
                        if (status == "success" && data != "") {
                            $("#numCard").removeClass("isInvalid");
                            $("#numCard").addClass("isValid");

                            cardJSON = JSON.parse(data);

                            if(cardJSON["Stato"] == "Attiva"){

                                let buttons = '<form id="AddebitaRicaricaForm" class="w-100 pt-4" method="post" >' +
                                    '<div class="mb-0">'+
                                        '<input type="text" value="' + cardJSON["Numero Carta"] + '" class="form-control" name="hidNumCard" id="hidNumCard" maxlength="19" pattern="^([0-9]{4} ){3}[0-9]{4}$" readonly/>' +
                                    '</div>'+
                                    '<input type="hidden" value="' + cardJSON["Stato"] + '"/>'+
                                    '<div class="mb-0">'+
                                        '<div class="form-check form-check-inline">'+
                                            '<input id="opId" name="operation" type="radio" class="form-check-input" checked="" required="required" value="ricarica"> '+
                                            '<label class="form-check-label" for="opId">Ricarica</label>' +
                                        '</div>'+
                                        '<div class="form-check form-check-inline">'+
                                            '<input id="opId2" name="operation" type="radio" class="form-check-input"  required="required" value="addebita"> '+
                                            '<label class="form-check-label" for="opId2">Addebita</label>' +
                                        '</div>'+
                                    '</div>'+
                                    '<div class="input-group mb-3">'+
                                        '<span class="input-group-text">' + '&euro;' + '</span>' +
                                        '<input id="importo" type="text" class="form-control" name="importo" placeholder="100.00" required="required" pattern="^\\d{1,8}(\\.\\d{2})?$" maxlength="11" />' +
                                    '</div>'+
                                    '<div class="mb-3">'+
                                        '<textarea name="causale" id=causale row="4" cols="64" placeholder="Causale" maxlength="64" required=required></textarea>' +
                                    '</div>'+
                                    '<div class="row">'+
                                        '<div class="col">'+
                                            '<button id="indietro" type="button">Indietro</button>' +
                                        '</div>'+
                                        '<div class="col">'+
                                            '<button id="button" type="submit">Ricarica</button>' +
                                        '</div>'+
                                    '</div>'+
                                    '</form>';


                                $("#buttonsContainer").html(buttons);
                                $("#cercaCartaForm2").removeClass("compari");
                                $("#cercaCartaForm2").addClass("sparisci");

                                $("#buttonsContainer").removeClass("sparisci");
                                $("#buttonsContainer").addClass("compari");


                                $("body").on("click", "#indietro", function(){
                                    $("#buttonsContainer").addClass('sparisci');
                                    $("#buttonsContainer").removeClass('compari');

                                    $("#cercaCartaForm2").removeClass('sparisci');
                                    $("#cercaCartaForm2").addClass('compari');
                                });


                                $("body").on("change","input[type=radio][name=operation]", function(ev){
                                    if($(this).val() == "ricarica"){
                                        $("#opId").removeAttr("checked");
                                        $("#opId2").attr("checked", "checked");
                                        $("#button").html("Ricarica");
                                    }else if ($(this).val() == "addebita"){
                                        $("#opId2").removeAttr("checked");
                                        $("#opId").attr("checked", "checked");
                                        $("#button").html("Addebita");
                                    }
                                });



                                $('body').on('submit','#AddebitaRicaricaForm', function(ev){
                                    ev.preventDefault();

                                    if($("#hidNumCard")[0].checkValidity() && $("#importo")[0].checkValidity()){
                                        $.post("AddebitaRicaricaCartaServlet", {
                                            numCard: $("#hidNumCard").val(),
                                            statoCarta: cardJSON["Stato"],
                                            op: $("input[type=radio][name=operation]:checked").val(),
                                            importo: $("#importo").val(),
                                            saldo: cardJSON["Saldo"],
                                            causale: $("#causale").val()

                                        }, function (data, status){
                                            if(status == "success"){
                                                window.location.reload();

                                            }

                                        });
                                    }
                                });




                            }else {
                                $("#buttonsContainer").html("");
                                $("#numCard").removeClass("isValid");
                                $("#numCard").addClass("isInvalid");


                            }

                        }else{
                            $("#buttonsContainer").html("");
                            $("#numCard").removeClass("isValid");
                            $("#numCard").addClass("isInvalid");
                        }
                        }
                    );
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
<jsp:include page="../componenti/NavbarNegoziante.jsp"/>
<div style="position:relative; top:80px; padding:10px; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%); width: 100%; height: 100%;">
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Addebita/Ricarica Carta</strong> </h1>
    <p style="text-align: center; font-size: 20px; position: relative; top:10px;"> Inserisci il numero della carta per addebitarla o ricaricarla.</p>

    <div id="btnContainer">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'LoginServlet'"></button>
        <svg id=backArrow xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <form class="mx-auto compari" id="cercaCartaForm2">
        <label for="numCard" class="form-label" id="labelNumCard">Numero Carta:</label>
        <div class="input-group mb-3" id="inputContainer">
            <input type="text" class="form-control" name="numCard" id="numCard" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" pattern="^([0-9]{4} ){3}[0-9]{4}$" required="required" aria-describedby="basic-addon2"/>
            <span class="input-group-text" id="basic-addon2"></span>
        </div>
        <button class="mx-auto" id="btnCerca" type="submit">Cerca Carta</button>
    </form>

    <div id="buttonsContainer" class="sparisci"></div>
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
