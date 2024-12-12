<nav class="navbar navbar-expand-lg bg-body-tertiary fixed-top" >
    <div class="container-fluid">
        <a id="logo" class="navbar-brand" href="index.jsp"> <img src="img/logo.png" width="55" height="55" style="mix-blend-mode: multiply" /> Money<span>Mate</span> </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="index.jsp#homeCarouselAutoplaying"><strong>Home</strong></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="ricercaCarta.jsp">Ricerca Carta</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp#chiSiamo">Chi siamo?</a>
                </li>
            </ul>

            <div class="dropdown" role="search" style="position:absolute; right:1.5em">
                <button type="button" data-bs-toggle="dropdown" aria-expanded="false" data-bs-auto-close="outside"  style="background: none; border:none">
                    <img src="img/user.svg" width="50" height="50" style="mix-blend-mode: multiply; border:2px solid var(--gold-main); border-radius: 50%; padding: 2.5px"/>
                </button>
                <form id="login" class="dropdown-menu bg-body-tertiary p-4" style="width: 370px; left: -300px; top: 63px" action="LoginServlet" method="post" target="_parent">
                    <div class="mb-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="Indirizzo@email.com" pattern="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" required="required" maxlength="64"/>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password:</label>
                        <input type="password" class="form-control" name="password" id="password" placeholder="Password" pattern="^(.|\s)*\S(.|\s)*$" required="required" maxlength="64"/>
                    </div>
                    <div class="mb-3">
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="dropdownCheck2">
                            <label class="form-check-label" for="dropdownCheck2">
                                Mostra
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn" style="background: var(--red-main); color:white">Accedi</button>
                    <% if(request.getSession().getAttribute("stato") != null){%>
                        <p id="erroreCredenziali" style="color: red"> <%= request.getSession().getAttribute("stato") %> </p>
                    <% request.getSession().removeAttribute("stato");}%>


                </form>
            </div>
        </div>
    </div>
</nav>
