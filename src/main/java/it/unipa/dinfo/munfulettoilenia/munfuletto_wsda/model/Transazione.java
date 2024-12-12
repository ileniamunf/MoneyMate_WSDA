package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

import java.util.Date;

public class Transazione {
    private static int numero= 0;
    private String nomeNeg, numCarta, operazione;
    private float ammontare;
    private Date data;
    private String causale;



    public Transazione(){

    }


    public Transazione(String nomeNeg, String numCarta, String operazione, float ammontare, Date data, String causale){
        //setNumero(numero);
        setNomeNeg(nomeNeg);
        setNumCarta(numCarta);
        setOperazione(operazione);
        setAmmontare(ammontare);
        setData(data);
        setCausale(causale);
    }

    public void setCausale(String causale) {
        this.causale = causale;
    }


    public void setNumero(int numero) {
        this.numero++;
        this.numero = numero;

    }

    public void setNomeNeg(String nomeNeg) {
        this.nomeNeg = nomeNeg;
    }

    public void setNumCarta(String numCarta) {
        this.numCarta = numCarta;
    }

    public void setOperazione(String operazione) {
        this.operazione = operazione;
    }

    public void setAmmontare(float ammontare) {
        this.ammontare = ammontare;
    }

    public void setData(Date data) {
        this.data = data;
    }


    public int getNumero() {
        return numero;
    }

    public String getNomeNeg() {
        return nomeNeg;
    }

    public String getNumCarta() {
        return numCarta;
    }

    public String getOperazione() {
        return operazione;
    }

    public float getAmmontare() {
        return ammontare;
    }

    public Date getData() {
        return data;
    }

    public String getCausale() {
        return causale;
    }


}
