<% if(session.getAttribute("text") != null){%>
    <script>
        $("#esitoModal").ready(() => {
            let obj = JSON.parse('<%=session.getAttribute("text")%>');
            $("#textModal").html(obj.Corpo);
            $("#esitoModalLabel").html(obj.Titolo);

      <%if(Integer.parseInt(session.getAttribute("codeOp").toString()) == 2 || Integer.parseInt(session.getAttribute("codeOp").toString()) == 4 || Integer.parseInt(session.getAttribute("codeOp").toString()) == 5){%>
                $("#icon").html("X");
                $(".modal-confirm .icon-box").css("background","#ef513a");
                $(".modal-confirm .btn").css("background","#ef513a");
                $(".modal-confirm .btn:hover, .modal-confirm .btn:focus").css("background","#da2c12");
            <%}%>

        });
    </script>

<%}%>

<div id="esitoModal" class="modal fade">
    <div class="modal-dialog modal-confirm">
        <div class="modal-content">
            <div class="modal-header">
                <div class="icon-box">
                    <i id="icon" class="material-icons"> &#x2713; </i>
                </div>
                <h4 class="modal-title w-100" id="esitoModalLabel"></h4>
            </div>
            <div class="modal-body">
                <p class="text-center" id="textModal"></p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary w-100" data-bs-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>


