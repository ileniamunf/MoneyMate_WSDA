<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Errore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href='https://fonts.googleapis.com/css?family=Comfortaa' rel='stylesheet'>
    <link href="styles.css" rel="stylesheet">
    <link href="https://unpkg.com/boxicons@2.1.2/css/boxicons.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.icon.png">
</head>
<body>
<jsp:include page="WEB-INF/componenti/Navbar.jsp" />
<div style="position: relative; top: 90px; padding: 20px">
    <h1> ERRORE </h1>
    <h2>Si è riscontrato un problema, non abbiamo potuto soddisfare la tua richiesta.</h2>
    <button class="btn btn-primary" onclick="window.location.href='index.jsp'"> Torna alla Home</button>
</div>



<jsp:include page="WEB-INF/componenti/Footer.jsp" />
</body>
</html>