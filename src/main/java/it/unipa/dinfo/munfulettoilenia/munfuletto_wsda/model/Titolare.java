package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

import java.util.Date;

public class Titolare extends Utente{
    private String nome, cognome, codiceFisc,numTel ,citta;
    private Date dataDiNascita;


    public Titolare(){}


    public Titolare(String email, String password, String nome, String cognome, Date dataDiNascita, String codiceFisc, String numTel, String citta){
        super(email, password,"Titolare");
        setNome(nome);
        setCognome(cognome);
        setDataDiNascita(dataDiNascita);
        setCodiceFisc(codiceFisc);
        setNumTel(numTel);
        setCitta(citta);

    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public void setDataDiNascita(Date dataDiNascita) {
        this.dataDiNascita = dataDiNascita;
    }

    public void setCodiceFisc(String codiceFisc) {
        this.codiceFisc = codiceFisc;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }


    public void setNumTel(String numTel) {
        this.numTel = numTel;
    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public Date getDataDiNascita() {
        return dataDiNascita;
    }


    public String getCodiceFisc() {
        return codiceFisc;
    }

    public String getNumTel() {
        return numTel;
    }

    public String getCitta() {
        return citta;
    }
}
