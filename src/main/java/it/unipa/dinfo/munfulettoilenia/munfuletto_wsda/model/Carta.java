package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

import java.util.Date;

public class Carta {
    private String email, numero, cvv,  stato;
    private Date dataScadenza;
    private float saldo;



    public Carta(){
        setEmail("");
        setNumero("");
        setDataScadenza(new Date());
        setCvv("");
        setSaldo(0);
        setStato("");
    }


    public Carta(String email, String numero, Date dataScadenza, String cvv, float saldo, String stato){
        setEmail(email);
        setNumero(numero);
        setDataScadenza(dataScadenza);
        setCvv(cvv);
        setSaldo(saldo);
        setStato(stato);

    }

    public Carta(String email, String numero, Date dataScadenza, String cvv, float saldo){
        setEmail(email);
        setNumero(numero);
        setDataScadenza(dataScadenza);
        setCvv(cvv);
        setSaldo(saldo);
        setStato("Attiva");

    }


    public void setEmail(String email) {
        this.email = email;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public void setDataScadenza(Date dataScadenza) {
        this.dataScadenza = dataScadenza;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }

    public void setSaldo(float saldo) {
        this.saldo = saldo;
    }

    public void setStato(String stato) {
        this.stato = stato;
    }


    public String getEmail() {
        return email;
    }

    public String getNumero() {
        return numero;
    }

    public Date getDataScadenza() {
        return dataScadenza;
    }

    public String getCvv() {
        return cvv;
    }

    public float getSaldo() {
        return saldo;
    }

    public String getStato() {
        return stato;
    }
}

