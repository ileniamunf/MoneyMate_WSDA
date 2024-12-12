package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

public class Utente {
    private String email, password, tipo;

    public Utente(){
    }

    public Utente(String email, String password, String tipo){
        setEmail(email);
        setPassword(password);
        setTipo(tipo);

    }


    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }


    public String getEmail() {
        return email;
    }


    public String getPassword() {
        return password;
    }


    public String getTipo() {
        return tipo;
    }


}



