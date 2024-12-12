<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html>
<head>

    <title>MoneyMate&trade; - Index</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">


    <script src="jquery-3.7.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#email").focus(function(){
                $("#erroreCredenziali").text("");
            });

            $("#password").focus(function(){
                $("#erroreCredenziali").text("");
            });

            <% if(request.getSession().getAttribute("stato") != null){ %>
                $("#login").addClass("show");
            <%}%>

            $("#dropdownCheck2").click(function(){
                $("#dropdownCheck2").is(":checked") ? $("#password").attr("type","text") : $('#password').attr('type', 'password');
            });


        });


    </script>



</head>
<body>
<jsp:include page="WEB-INF/componenti/Navbar.jsp" />

<main>
    <div id="homeCarouselAutoplaying" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="img/carousel/resized/1.jpeg" class="d-block w-100 " alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h3>NASCE <strong>MONEYMATE&trade;!</strong> <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-bank" viewBox="0 0 16 16" style="position:relative; top:-5px">
                        <path d="m8 0 6.61 3h.89a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5H15v7a.5.5 0 0 1 .485.38l.5 2a.498.498 0 0 1-.485.62H.5a.498.498 0 0 1-.485-.62l.5-2A.5.5 0 0 1 1 13V6H.5a.5.5 0 0 1-.5-.5v-2A.5.5 0 0 1 .5 3h.89zM3.777 3h8.447L8 1zM2 6v7h1V6zm2 0v7h2.5V6zm3.5 0v7h1V6zm2 0v7H12V6zM13 6v7h1V6zm2-1V4H1v1zm-.39 9H1.39l-.25 1h13.72z"/>
                    </svg> </h3>
                    <p style="font-size: 1.5em;">Leader nel mercato dei servizi digitali adatti alle tue esigenze.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/carousel/resized/2.jpeg" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h3> TUTTO CON UN CLICK! <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-mouse2-fill" viewBox="0 0 16 16" style="position:relative; top:-5px">
                        <path d="M7.5.026C4.958.286 3 2.515 3 5.188V5.5h4.5zm1 0V5.5H13v-.312C13 2.515 11.042.286 8.5.026M13 6.5H3v4.313C3 13.658 5.22 16 8 16s5-2.342 5-5.188z"/>
                    </svg> </h3>
                    <p style="font-size: 1.5em;"> Controlla i tuoi movimenti bancari e le tue carte.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/carousel/resized/3.jpg" class="d-block w-100 " alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h3> VICINO AI TUOI CLIENTI! <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-credit-card-fill" viewBox="0 0 16 16" style="position:relative; top:-5px">
                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1H0zm0 3v5a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7zm3 2h1a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-1a1 1 0 0 1 1-1"/>
                    </svg> </h3>
                    <p style="font-size: 1.5em;"> Ricariche e addebiti col solo numero di carta.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="img/carousel/resized/4.jpeg" class="d-block w-100 " alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h3> CONTROLLA IL TUO SALDO! <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-cash-coin" viewBox="0 0 16 16" style="position:relative; top:-5px">
                        <path fill-rule="evenodd" d="M11 15a4 4 0 1 0 0-8 4 4 0 0 0 0 8m5-4a5 5 0 1 1-10 0 5 5 0 0 1 10 0"/>
                        <path d="M9.438 11.944c.047.596.518 1.06 1.363 1.116v.44h.375v-.443c.875-.061 1.386-.529 1.386-1.207 0-.618-.39-.936-1.09-1.1l-.296-.07v-1.2c.376.043.614.248.671.532h.658c-.047-.575-.54-1.024-1.329-1.073V8.5h-.375v.45c-.747.073-1.255.522-1.255 1.158 0 .562.378.92 1.007 1.066l.248.061v1.272c-.384-.058-.639-.27-.696-.563h-.668zm1.36-1.354c-.369-.085-.569-.26-.569-.522 0-.294.216-.514.572-.578v1.1zm.432.746c.449.104.655.272.655.569 0 .339-.257.571-.709.614v-1.195z"/>
                        <path d="M1 0a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h4.083q.088-.517.258-1H3a2 2 0 0 0-2-2V3a2 2 0 0 0 2-2h10a2 2 0 0 0 2 2v3.528c.38.34.717.728 1 1.154V1a1 1 0 0 0-1-1z"/>
                        <path d="M9.998 5.083 10 5a2 2 0 1 0-3.132 1.65 6 6 0 0 1 3.13-1.567"/>
                    </svg> </h3>
                    <p style="font-size: 1.5em;"> Scopri il saldo della tua carta con il nostro servizio.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#homeCarouselAutoplaying" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#homeCarouselAutoplaying" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <div id="chiSiamo" style="height: 11vh">

    </div>

    <section class="px-5" style="height: 87vh; padding-bottom: 20px; display: flex; flex-direction: column; font-style: italic">
        <div class="container">
            <h1 style="color: var(--red-main); text-align: center; font-size: 2.5em; text-transform: uppercase"> Chi siamo?</h1>
            <hr />
            <div class="row">
                <div class="col-4" style="text-align: center">
                    <img src="img/business_woman%20(1).jpeg" style="width: 350px; height: 350px; border-radius: 50%; border: 4px solid var(--gold-main); box-shadow: -100px 4px 8px rgba(192,29,46,0.1)">
                </div>
                <div class="col-8">
                    <p class="my-5" style="font-size: 1.2em"> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce molestie velit faucibus consequat iaculis. Pellentesque id elementum urna. Proin quis lorem ac dui scelerisque venenatis eget vel dui. Mauris condimentum orci sed ligula bibendum volutpat. Vestibulum consectetur maximus vestibulum. Curabitur auctor nec ex eget luctus. Donec massa nulla, iaculis ut vulputate sit amet, suscipit eget augue. Vivamus turpis tellus, pharetra non libero sed, finibus consequat mauris. Nulla molestie placerat rutrum. Donec sed elit luctus lacus ultrices accumsan sit amet at risus. Nullam egestas purus eu turpis tempus suscipit. Fusce nunc neque, egestas ut nisi vitae, maximus blandit nisi. </p>

                </div>

            </div>
            <div class="row">
                <div class="col-8">
                    <p class="my-5" style="font-size: 1.2em"> Aenean aliquam pulvinar ante vel dapibus. Ut vel est libero. In luctus nibh tellus, sed faucibus turpis convallis et. Fusce vitae justo vitae augue porta pharetra ut in neque. Phasellus gravida consectetur enim, non ultrices mi condimentum vitae. Ut vel leo lectus. Nulla at vulputate metus. Aenean ullamcorper id nulla vel iaculis. Pellentesque sit amet feugiat ipsum, varius faucibus dolor. Vivamus sagittis, nunc nec tincidunt laoreet, sem odio tincidunt metus, quis gravida purus erat sed nisl. Interdum et malesuada fames ac ante ipsum primis in faucibus. Maecenas tincidunt turpis rutrum nisi laoreet, sit amet porttitor est semper. Nunc mattis fringilla sem a mattis. </p>
                </div>
                <div class="col-4">
                    <img src="img/businessman%20(1).jpeg" style="width: 350px; height: 350px; border-radius: 50%; border: 4px solid var(--gold-main); box-shadow: 100px 4px 8px rgba(192,29,46,0.1)">


                </div>

            </div>
            <div class="row" style="height: 20vh">
            </div>


        </div>
    </section>

</main>

<jsp:include page="WEB-INF/componenti/Footer.jsp" />
<jsp:include page="WEB-INF/componenti/cookieBanner.jsp" />


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="cookie.js" defer></script>
</body>
</html>





