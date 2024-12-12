<nav class="navbar navbar-expand-lg bg-body-tertiary fixed-top" >
  <div class="container-fluid">
    <a id="logo" class="navbar-brand" href="LoginServlet"> <img src="img/logo.png" width="55" height="55" style="mix-blend-mode: multiply" /> Money<span>Mate</span> </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

      <div class="dropdown" role="search" style="position:absolute; right:1.5em">
        <button type="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside"  style="background: none; border:none">
          <img src="img/user.svg" width="50" height="50" style="mix-blend-mode: multiply; border:2px solid var(--gold-main); border-radius: 50%; padding: 2.5px"/>
        </button>
        <ul class="dropdown-menu" style="left: -136px; top:65px; padding-bottom: 0px">
          <li><a class="dropdown-item" href="AggiungiCartaServlet">Aggiungi Carta</a></li>
          <li><a class="dropdown-item" href="BloccaSbloccaCartaServlet">Blocca/Sblocca Carta</a></li>
          <li><a class="dropdown-item" href="GestioneUtentiServlet">Gestione Utenti</a></li>
          <li><hr class="dropdown-divider" style="margin-bottom: 0px"></li>
          <li><a class="dropdown-item" href="LogoutServlet" style="background: var(--red-main); padding: 7px; position: relative; padding-left: 15px; color: white; border-radius: 0rem 0rem 0.29rem 0.29rem">Esci</a></li>
        </ul>
      </div>
  </div>
</nav>