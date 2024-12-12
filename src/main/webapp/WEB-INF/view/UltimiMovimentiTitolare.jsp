<%@ page import="java.util.ArrayList" %>
<%@ page import="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Transazione" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<jsp:useBean id="Titolare" type="it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Titolare" scope="session"/>
<jsp:useBean id="ultimiMovimenti" type="java.util.ArrayList<it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.Transazione>" scope="session"/>

<html>
<head>
    <title>MoneyMate&trade; - Titolare Ultimi Movimenti </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">

</head>
<body style="overflow: hidden">
<jsp:include page="../componenti/NavbarTitolare.jsp"/>
<div style="position:relative; top:80px; text-align: left; width: 100%; padding:10px; height: 100%; background: linear-gradient(109.6deg, rgb(220, 181, 142) 90%,rgb(231, 62, 68) 53.6%, rgb(162, 2, 63) 11.2%);">
    <h1 style="color:var(--red-main); text-align: center; position: relative; top: 10px;"><strong>Ultimi Movimenti</strong> </h1>
    <p style="text-align: center; font-size: 20px; position: relative; top:10px;"> Le ultime transazioni bancarie delle tue carte:</p>

    <div id="btnContainer" style="bottom: 60px;">
        <button id="butnBack" type="button" class="btn" onclick="window.location.href = 'LoginServlet'"></button>
        <svg id="backArrow" xmlns="http://www.w3.org/2000/svg" width="150px" height="75px" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16" style="top: 46px;">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
        </svg>
    </div>

    <div class="mx-auto" id="transactionTable" style="overflow-y: scroll">
        <table class="table table-hover table-striped">
            <%if(ultimiMovimenti.isEmpty()){%>
            <tr>Non ci sono transazioni da visualizzare.</tr>

            <%}else{%>
            <tr id="headers">
                <th>Nome Attivit&agrave;</th>
                <th>Numero Carta</th>
                <th>Operazione</th>
                <th>Ammontare</th>
                <th>Data</th>
                <th class="text-center">Causale</th>
            </tr>

                <%for(int i=0; i<ultimiMovimenti.size(); i++){%>
                <tr>
                    <td><%=ultimiMovimenti.get(i).getNomeNeg()%></td>
                    <td><%=ultimiMovimenti.get(i).getNumCarta()%></td>
                    <td><%=ultimiMovimenti.get(i).getOperazione().substring(0,1).toUpperCase() + ultimiMovimenti.get(i).getOperazione().substring(1)%></td>
                    <td> &euro; <%=ultimiMovimenti.get(i).getAmmontare()%></td>
                    <td><%=ultimiMovimenti.get(i).getData()%></td>
                    <td class="text-center"><em><%=ultimiMovimenti.get(i).getCausale()%></em></td>
                </tr>

                <%}%>
            <%}%>

        </table>
    </div>


</div>
<jsp:include page="../componenti/Footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>





