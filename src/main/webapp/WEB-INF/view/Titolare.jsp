<jsp:useBean id="Titolare" type="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Titolare" scope="session"/>
<html>
<head>
    <title>MoneyMate&trade; - Titolare <%= Titolare.getNome()%> </title>
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
<jsp:include page="../componenti/NavbarTitolare.jsp"/>
<div style="position:relative; top:80px; text-align: left; width: 100%; padding:10px; height: 100%; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%);">
    <h1 style="margin-bottom: 160px; position: relative; top:60px; color: white; text-align: center; text-shadow: 2px 0px black;">Benvenuto, <strong><%= Titolare.getNome()%></strong>!</h1>

    <div class="container-md mx-auto bg-white" id="content" style="position: relative; top: -50px; width: 45%; height: 450px; border-radius: 50px; background-clip: text;">
        <div class="row pb-2" style="position:relative; height: 225px;">
            <div class="col-lg-6 px-2" style="text-align: center; padding: unset">
                <div class="card" style="width: 100%; max-width: 550px; border-radius: 50px 0 0 50px; height: 100%; border: 1px solid black; box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);">
                    <a href="UltimiMovimentiServlet" class="btn">
                        <div class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list-columns-reverse" viewBox="0 0 16 16" style="width: 100%; height: 100px;">
                                <path fill-rule="evenodd" d="M0 .5A.5.5 0 0 1 .5 0h2a.5.5 0 0 1 0 1h-2A.5.5 0 0 1 0 .5m4 0a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1h-10A.5.5 0 0 1 4 .5m-4 2A.5.5 0 0 1 .5 2h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m-4 2A.5.5 0 0 1 .5 4h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5m-4 2A.5.5 0 0 1 .5 6h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5m-4 2A.5.5 0 0 1 .5 8h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 0 1h-8a.5.5 0 0 1-.5-.5m-4 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1h-10a.5.5 0 0 1-.5-.5m-4 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m-4 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11a.5.5 0 0 1-.5-.5"/>
                            </svg>
                            <h5 class="card-title" style="position: relative; top:15px; font-size: 30px;">Ultimi Movimenti</h5>
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





