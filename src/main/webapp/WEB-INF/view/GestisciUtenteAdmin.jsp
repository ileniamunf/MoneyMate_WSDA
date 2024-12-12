<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MoneyMate&trade; - Admin Aggiungi Utente </title>
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

    <script src="jquery-3.7.1.min.js"></script>


</head>
<body style="overflow: hidden;">

<jsp:include page="../componenti/NavbarAdmin.jsp"/>
<div style="position:relative; top:80px; padding:10px; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%); width: 100%; height: 100%;">
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Gestisci Utenti</strong> </h1>
    <p style="text-align: center; font-size: 20px; position: relative; top:10px;"> Scegli un'operazione tra quelle disponibili.</p>


    <div id="btnContainer">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'LoginServlet'"></button>
        <svg id=backArrow xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <div class="container-md mx-auto bg-white" id="content" style="position: relative; top: -50px; width: 45%; height: 450px; border-radius: 50px; background-clip: text;">
        <div class="row pb-2" style="position:relative; height: 225px;">
            <div class="col-lg-6 px-2" style="text-align: center; padding: unset">
                <div class="card" style="width: 100%; max-width: 550px; border-radius: 50px 0 0 50px; height: 100%; border: 1px solid black; box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);">
                    <a href="AggiungiTitolareServlet" class="btn">
                        <div class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-vcard-fill" viewBox="0 0 16 16" style="width: 100%; height: 100px;">
                                <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm9 1.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4a.5.5 0 0 0-.5.5M9 8a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 0-1h-4A.5.5 0 0 0 9 8m1 2.5a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 0-1h-3a.5.5 0 0 0-.5.5m-1 2C9 10.567 7.21 9 5 9c-2.086 0-3.8 1.398-3.984 3.181A1 1 0 0 0 2 13h6.96q.04-.245.04-.5M7 6a2 2 0 1 0-4 0 2 2 0 0 0 4 0"/>
                            </svg>
                            <h5 class="card-title" style="position: relative; top:15px; font-size: 30px;">Aggiungi Titolare</h5>
                        </div>
                    </a>
                </div>
            </div>
            <div class="col-lg-6 px-2" style="text-align: center; padding: unset";>
                <div class="card " style="width: 100%; max-width: 550px; border-radius: 0 50px 50px 0; height: 100%; border: 1px solid black; box-shadow: 10px 10px 14px 1px rgba(00,00,00,0.2);">
                    <a href="AggiungiNegozianteServlet" class="btn">
                        <div class="card-body">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-plus-fill" viewBox="0 0 16 16" style="width: 100%; height: 100px;">
                                <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0m7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0M9 5.5V7h1.5a.5.5 0 0 1 0 1H9v1.5a.5.5 0 0 1-1 0V8H6.5a.5.5 0 0 1 0-1H8V5.5a.5.5 0 0 1 1 0"/>
                            </svg>
                            <h5 class="card-title" style="position: relative; top:15px; font-size: 30px; ">Aggiungi Negoziante</h5>
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
