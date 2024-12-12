package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

public class Negoziante extends Utente {
    private String nome, attivita, citta, numTel;
    private boolean abilitato;

    public Negoziante() {

    }


    public Negoziante(String email, String password, String nome, String attivita, String citta, String numTel, boolean abilitato) {
        super(email, password, "Negoziante");
        setNome(nome);
        setAttivita(attivita);
        setCitta(citta);
        setNumTel(numTel);
        setAbilitazione(abilitato);
    }


    public Negoziante(String email, String password, String nome, String attivita, String citta, String numTel) {
        super(email, password, "Negoziante");
        setNome(nome);
        setAttivita(attivita);
        setCitta(citta);
        setNumTel(numTel);
        setAbilitazione(true);
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setAttivita(String attivita) {
        this.attivita = attivita;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }


    public void setNumTel(String numTel) {
        this.numTel = numTel;
    }

    public void setAbilitazione(boolean abilitato) {
        this.abilitato = abilitato;
    }


    public String getNome() {
        return nome;
    }


    public String getAttivita() {
        return attivita;
    }


    public String getCitta() {
        return citta;
    }

    public String getNumTel() {
        return numTel;
    }


    public boolean isAbilitato() {
        return abilitato;
    }
}


