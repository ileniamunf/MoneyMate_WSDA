<jsp:useBean id="Negoziante" type="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Negoziante" scope="session"/>
<%
    if (session.getAttribute("Carta") != null) {
        session.removeAttribute("Carta");
    }

%>


<html>
<head>
    <title>MoneyMate&trade; - Negoziante <%= Negoziante.getNome()%> </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">

    <style>
        a:link,a:visited, a:hover {
            color: unset;
            text-decoration: none;
        }

    </style>

</head>
<body style="overflow: hidden">
<jsp:include page="../componenti/NavbarNegoziante.jsp"/>
<div style="position:relative; top:80px; text-align: left; width: 100%; padding:10px; height: 100%; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%);">
    <h1 style="margin-bottom: 160px; position: relative; top:60px; color: white; text-align: center; text-shadow: 2px 0px black;">Benvenuto, <strong>Negoziante <%= Negoziante.getNome()%></strong>!</h1>

    <div class="container-md mx-auto bg-white" id="content" style="position: relative; top: -50px; width: 45%; height: 450px; border-radius: 50px; background-clip: text;">
        <div class="row pb-2" style="position:relative; height: 225px;">
            <div class="col-lg-6 px-2" style="text-align: center; padding: unset">
                <div class="card" style="width: 100%; max-width: 550px; border-radius: 50px 0 0 50px; height: 100%; border: 1px solid black; box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);">
                    <a href="AddebitaRicaricaCartaServlet" class="btn">
                        <div class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cash-coin" viewBox="0 0 16 16" style="width: 100%; height: 100px">
                                <path fill-rule="evenodd" d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8m5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0"/>
                                <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195z"/>
                                <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083q.088-.517.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1z"/>
                                <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 6 6 0 0 1 3.13-1.567"/>
                            </svg>
                            <h5 class="card-title" style="position: relative; top:15px; font-size: 30px;">Addebita / Ricarica Carta</h5>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-6 px-2" style="text-align: center; padding: unset";>
                <div class="card " style="width: 100%; max-width: 550px; border-radius: 0 50px 50px 0; height: 100%; border: 1px solid black; box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);">
                    <a href="LogoutServlet" class="btn">
                        <div class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16" style="width: 100%; height: 100px">
                                <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"/>
                                <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
                            </svg>
                            <h5 class="card-title" style="position: relative; top:15px; font-size: 30px; ">Esci</h5>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../componenti/Footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>




