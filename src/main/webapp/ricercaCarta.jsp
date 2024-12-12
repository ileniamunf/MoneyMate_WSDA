<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% session.invalidate();%>
<!DOCTYPE html>
<html>
<head>


  <title>MoneyMate&trade; - Ricerca Carta</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
  <link href="styles.css" rel="stylesheet">
  <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
  <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"> </script>
    <script type="text/javascript">
        $(document).ready(function() {
            $(window).click(function(){
                $("#numCard").removeClass("isInvalid");
                $("#numCard").removeClass("isValid");
            });



            $("#numCard").keyup(function(ev){
                let value = $("#numCard").val();

                if((value.length == 4 || value.length == 9 || value.length == 14) && ev.keyCode != 8){ //keycode = 8 è il cancella
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
                    $("#addon").html(addonImg);
                } else{
                    $("#addon").html("");
                }

            });

            $("#cercaCartaForm").submit(
                function(ev){
                    ev.preventDefault();

                    if($("#numCard")[0].checkValidity()){
                        $.post("${pageContext.request.contextPath}/RicercaCartaServlet", {
                            numCard: $("#numCard").val().replaceAll(" ", "")
                        }, function (data, status) {

                            if (status == "success" && data != "") {
                                $("#numCard").removeClass("isInvalid");
                                $("#numCard").addClass("isValid");

                                let cardJSON = JSON.parse(data);
                                let table = "<table id='resultTable'>"+
                                        "<tr style='font-size: 26px; text-align: center'>" +
                                            "<td colspan='3'><strong>Saldo:</strong></td>"+
                                        "</tr>" +
                                        "<tr style='font-size: 54px; text-align: center'>" +
                                            "<td colspan='3' style='margin-top: -3px'>€ " + "<strong>" + Number.parseFloat(cardJSON.Saldo).toLocaleString("it-IT", { minimumFractionDigits: 2 }) + "</strong>" + "</td>"+
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
                                    "</table>";

                                $("#wallet").addClass("nascondi");
                                $("#dismiss").addClass("visible");



                                $("#result").html(table);
                                $("#result").addClass("mostra");




                            } else {
                                $("#numCard").removeClass("isValid");
                                $("#numCard").addClass("isInvalid");

                            }
                        });
                    }
                });

            $("#dismiss").click(function(){
                $(this).removeClass("visible");
                $("#result").html("");
                $("#result").removeClass("mostra");

                $("#wallet").removeClass("nascondi");

            });

            $("#dropdownCheck2").click(function(){
                $("#dropdownCheck2").is(":checked") ? $("#password").attr("type","text") : $('#password').attr('type', 'password');
            });



        });

    </script>


</head>
<body style="overflow: hidden">
  <jsp:include page="WEB-INF/componenti/Navbar.jsp" />
  <div style="padding-block: 100px; height: 100vh">
    <h1 style="color:var(--red-main); text-align: center"><strong>Ricerca Carta</strong> </h1>
    <p style="text-align: center; font-size: 20px"> Inserisci il numero della tua carta per conoscerne il saldo ed il titolare.</p>


    <div id="wallet" class="bg-light w-100 ">
        <div class="mx-auto text-center" style="background-color: white; height: 100px; width: 200px; border-radius: 0 0 100px 100px; border-left:1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; border-top: 1px solid white; position: relative; top: -1.5px">
            <button class="btn btn-outline-primary rounded-circle p-3 lh-1" id="dismiss" type="button" style="transition: display 0.6s ease">
                <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
                    <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8z"/>
                </svg>
                <span class="visually-hidden">Dismiss</span>
            </button>
        </div>

        <div class="mx-auto" style="background-image: url('img/card.png'); position: relative; background-size: 89%; background-repeat: no-repeat; background-position: 50% 0; width: 900px; height: 460px; object-fit: cover">

            <form class="row g-3" id="cercaCartaForm" style="position: relative; top: 60%; left: 80px">
                <div class="row" style="height: 80px">
                    <div class="col-auto" style="width: 56%; position: relative; top:-40px">
                        <label for="numCard" style="color: var(--gold-main); font-size: 24px;"> Numero Carta:</label>

                        <div class="input-group mb-3">
                            <input name="inputNumCard" type="tel" class="form-control" id="numCard" placeholder="XXXX XXXX XXXX XXXX" maxlength="19" style="height: 62px; font-size: 32px" required="required" pattern="^([0-9]{4} ){3}[0-9]{4}$">
                            <span class="input-group-text" id="addon">

                            </span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-3">
                        <button type="submit" class="btn btn-primary rounded-pill mb-3" style="height: 85%; font-size: 24px; position:relative; top:-5px"> Cerca Carta</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
      <div id="result" ></div>

  </div>

  <jsp:include page="WEB-INF/componenti/Footer.jsp" />
  <jsp:include page="WEB-INF/componenti/cookieBanner.jsp" />





<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="cookie.js" defer></script>
</body>
</html>