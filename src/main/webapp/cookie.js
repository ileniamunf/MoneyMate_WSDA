const cookieBox = document.querySelector(".wrapper"),
    button = document.getElementById("ok");


window.addEventListener("load", function() {
    if(document.cookie.includes("accepted")) return;
        cookieBox.classList.add("show");
        button.addEventListener("click", function(){
            cookieBox.classList.remove("show");
            console.log(button.id);
            if(button.id == "ok"){
                document.cookie = "isAccepted = accepted; max-age=" + 60*60*24*14;
            }
    });
});


