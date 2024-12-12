package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.utils;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model.*;

public class Connessione {
    Connection connection;

    private static final String DEFAULT_HOST = "jdbc:mysql://localhost:3306/Munfuletto",
            DEFAULT_USER = "root",
            DEFAULT_PSW = "ilenia munfuletto";

    public Connection getConnection() {
        return this.connection;
    }

    public void setConnection(String host, String user, String password){
        try {
            Driver driver = (Driver) Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
            DriverManager.registerDriver(driver);
            this.connection = (Connection) DriverManager.getConnection(host+"?user="+user+"&password="+password);


            this.connection.setAutoCommit(false);
        } catch (SQLException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    //Costruttore
    public Connessione(){
        this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
    }



    //Prepared Statement
    private static final String cercaCartaQuery = "select * from Carte where Numero = ?";
    private static final String cercaUtenteQuery = "select * from Utenti where Email = ? and Password = ?";
    private static final String cercaTitolareQuery = "select * from Titolare,Utenti where Utenti.Email = Titolare.Ref_Email and Titolare.Ref_Email = ?";
    private static final String cercaAdminQuery = "select * from Admin,Utenti where Utenti.Email = Admin.Ref_Email and Admin.Ref_Email = ?";
    private static final String cercaNegozianteQuery = "select * from Negoziante,Utenti where Utenti.Email = Negoziante.Ref_Email and Negoziante.Ref_Email = ?";
    private static final String inserisciCartaQuery = " insert into Carte values (?,?,?,?,?,?)";
    private static final String cercaUtenteQuery2 = " select * from Utenti where Email = ?";
    private static final String aggiornaStatoCartaQuery = "update Carte set Stato = ? where Numero = ?";
    private static final String aggiornaSaldoCartaQuery = "update Carte set Saldo = Saldo + ? where Numero = ? and Stato != 'Bloccata'";
    private static final String aggiornaSaldoCartaQuery2 = "update Carte set Saldo = Saldo - ? where Numero = ? and Stato != 'Bloccata'";
    private static final String inserisciTransazioneQuery = "insert into Transazioni values (?,?,?,?,?,?)";
    private static final String inserisciUtenteQuery = " insert into Utenti values (?,?,?)";
    private static final String inserisciTitolareQuery = " insert into Titolare values (?,?,?,?,?,?,?)";
    private static final String inserisciNegozianteQuery = " insert into Negoziante values (?,?,?,?,?,?)";
    private static final String cercaTransazioniQuery = "select * from Carte C, Transazioni T where C.Numero = T.Ref_Carta and C.Ref_Titolare = ? order by T.Data desc";


    //QUERY
    public String getCarta(String numeroCarta){
        String responseString = "";
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectCartaQuery = this.getConnection().prepareStatement(cercaCartaQuery);
            selectCartaQuery.setString(1,numeroCarta);
            ResultSet result = selectCartaQuery.executeQuery();

            if(result.next()){

                responseString="{"+
                       " \"Email Titolare\": \"" + result.getString("Ref_Titolare") + "\",  " +
                       " \"Numero Carta\": \"" + result.getString("Numero") + "\",  " +
                       " \"Data di scadenza\": \"" + result.getDate("Data scadenza") + "\",  " +
                       " \"Saldo\": \"" + result.getString("Saldo") + "\"," +
                        " \"Stato\": \"" + result.getString("Stato") + "\"" +
                       "}";
            }
            this.getConnection().commit();
            this.getConnection().close();

        } catch (SQLException e){
            e.printStackTrace();
        }

        return responseString;

    }


    public Utente getUtente(String email, String password){
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectUtenteQuery = this.getConnection().prepareStatement(cercaUtenteQuery);
            selectUtenteQuery.setString(1, email);
            selectUtenteQuery.setString(2, password);
            ResultSet result = selectUtenteQuery.executeQuery();

            if(result.next()){
                String tipo = result.getString("Tipo");
                return new Utente(email, password,tipo);
            }
            this.getConnection().commit();
            this.getConnection().close();
        }catch (SQLException e){
            e.printStackTrace();

        }
        return null;

    }


    public Titolare getTitolare(String email){
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectTitolareQuery = this.getConnection().prepareStatement(cercaTitolareQuery);
            selectTitolareQuery.setString(1,email);
            ResultSet result = selectTitolareQuery.executeQuery();

            if(result.next()){
                return new Titolare(result.getString("Ref_Email"), result.getString("Password"),
                        result.getString("Nome"), result.getString("Cognome"), result.getDate("Data di Nascita"),
                        result.getString("Codice Fiscale"), result.getString("NumTel"), result.getString("Citta"));


            }
            this.getConnection().commit();
            this.getConnection().close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return null;
    }


    public Admin getAdmin(String email){
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectAdminQuery = this.getConnection().prepareStatement(cercaAdminQuery);
            selectAdminQuery.setString(1,email);
            ResultSet result = selectAdminQuery.executeQuery();

            if(result.next()){
                return new Admin(result.getString("Ref_Email"), result.getString("Password"), result.getInt("id"));


            }
            this.getConnection().commit();
            this.getConnection().close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return null;
    }


    public Negoziante getNegoziante(String email){
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectNegozianteQuery = this.getConnection().prepareStatement(cercaNegozianteQuery);
            selectNegozianteQuery.setString(1,email);
            ResultSet result = selectNegozianteQuery.executeQuery();

            if(result.next()){
                return new Negoziante(result.getString("Ref_Email"), result.getString("Password"), result.getString("Nome"),result.getString("Attivita"),
                        result.getString("Citta"),result.getString("NumTel"), result.getBoolean("Abilitato"));


            }
            this.getConnection().commit();
            this.getConnection().close();
        }catch(SQLException e){
            e.printStackTrace();
        }

        return null;
    }


    public boolean insertCarta(Carta newCard) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement insertCartaQuery = this.getConnection().prepareStatement(inserisciCartaQuery);
            insertCartaQuery.setString(1, newCard.getEmail());
            insertCartaQuery.setString(2, newCard.getNumero());
            insertCartaQuery.setDate(3, new Date(newCard.getDataScadenza().getTime()));
            insertCartaQuery.setString(4, newCard.getCvv());
            insertCartaQuery.setFloat(5, newCard.getSaldo());
            insertCartaQuery.setString(6, newCard.getStato());


           insertCartaQuery.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();
            return true;

        }catch(SQLException e){
            e.printStackTrace();
        }

        return false;
    }


    public boolean cercaUtente(String email) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement checkUserQuery = this.getConnection().prepareStatement(cercaUtenteQuery2);
            checkUserQuery.setString(1, email);
            ResultSet result = checkUserQuery.executeQuery();

            if(result.next()){
                this.getConnection().commit();
                this.getConnection().close();

                return true;
            }

        }catch(SQLException e){
            e.printStackTrace();
        }

        return false;
    }


    public boolean bloccaSbloccaCarta(String numCard, String newStato) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);

            PreparedStatement updateCardStatusQuery = this.getConnection().prepareStatement(aggiornaStatoCartaQuery);
            updateCardStatusQuery.setString(2, numCard);
            updateCardStatusQuery.setString(1, newStato);

            updateCardStatusQuery.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();

            return true;

        }catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }


    public boolean ricaricaCarta(String numero,Float importo) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);

            PreparedStatement updateBalanceQuery = this.getConnection().prepareStatement(aggiornaSaldoCartaQuery);
            updateBalanceQuery.setFloat(1, importo);
            updateBalanceQuery.setString(2, numero);

            updateBalanceQuery.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();

            return true;

        }catch(SQLException e){
            e.printStackTrace();
        }
        return false;

    }


    public boolean addebitaCarta(String numero, Float importo) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);


            PreparedStatement updateBalanceQuery2 = this.getConnection().prepareStatement(aggiornaSaldoCartaQuery2);
            updateBalanceQuery2.setFloat(1, importo);
            updateBalanceQuery2.setString(2, numero);


            updateBalanceQuery2.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();

            return true;

        }catch(SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public void addTransazione(Transazione transazione) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement addTransazioneQuery = this.getConnection().prepareStatement(inserisciTransazioneQuery);

            addTransazioneQuery.setString(1, transazione.getNomeNeg());
            addTransazioneQuery.setString(2, transazione.getNumCarta());
            addTransazioneQuery.setString(3, transazione.getOperazione());
            addTransazioneQuery.setFloat(4, transazione.getAmmontare());
            addTransazioneQuery.setDate(5, new Date(transazione.getData().getTime()));
            addTransazioneQuery.setString(6, transazione.getCausale());


            addTransazioneQuery.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();

        }catch(SQLException e){
            e.printStackTrace();
        }

    }


    public boolean insertTitolare(Titolare titolare) {
        try{
            if(this.insertUtente(new Utente(titolare.getEmail(), titolare.getPassword(), "Titolare"))){
                this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
                PreparedStatement insertTitolareQuery = this.getConnection().prepareStatement(inserisciTitolareQuery);
                insertTitolareQuery.setString(1, titolare.getEmail());
                insertTitolareQuery.setString(2, titolare.getNome());
                insertTitolareQuery.setString(3, titolare.getCognome());
                insertTitolareQuery.setDate(4, new Date(titolare.getDataDiNascita().getTime()));
                insertTitolareQuery.setString(5, titolare.getCodiceFisc());
                insertTitolareQuery.setString(6, titolare.getNumTel());
                insertTitolareQuery.setString(7, titolare.getCitta());

                insertTitolareQuery.executeUpdate();

                this.getConnection().commit();
                this.getConnection().close();
                return true;
            }
            this.getConnection().rollback();


        }catch(SQLException e){
            e.printStackTrace();
        }

        return false;
    }


    public boolean insertUtente(Utente utente) {
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement insertUtenteQuery = this.getConnection().prepareStatement(inserisciUtenteQuery);
            insertUtenteQuery.setString(1, utente.getEmail());
            insertUtenteQuery.setString(2, utente.getPassword());
            insertUtenteQuery.setString(3, utente.getTipo());

            insertUtenteQuery.executeUpdate();

            this.getConnection().commit();
            this.getConnection().close();
            return true;

        }catch(SQLException e){
            e.printStackTrace();
        }

        return false;
    }


    public boolean insertNegoziante(Negoziante negoziante) {
        try{
            if(this.insertUtente(new Utente(negoziante.getEmail(), negoziante.getPassword(), "Negoziante"))){
                this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
                PreparedStatement insertNegozianteQuery = this.getConnection().prepareStatement(inserisciNegozianteQuery);
                insertNegozianteQuery.setString(1, negoziante.getEmail());
                insertNegozianteQuery.setString(2, negoziante.getNome());
                insertNegozianteQuery.setString(3, negoziante.getAttivita());
                insertNegozianteQuery.setString(4, negoziante.getCitta());
                insertNegozianteQuery.setString(5, negoziante.getNumTel());
                insertNegozianteQuery.setBoolean(6, negoziante.isAbilitato());

                insertNegozianteQuery.executeUpdate();

                this.getConnection().commit();
                this.getConnection().close();
                return true;
            }

            this.getConnection().rollback();

        }catch(SQLException e){
            e.printStackTrace();
        }


        return false;
    }

    public ArrayList<Transazione> getTransazioni(String email) {
        ArrayList<Transazione> transazioni = new ArrayList<Transazione>();
        try{
            this.setConnection(DEFAULT_HOST, DEFAULT_USER, DEFAULT_PSW);
            PreparedStatement selectTransazioniQuery = this.getConnection().prepareStatement(cercaTransazioniQuery);
            selectTransazioniQuery.setString(1, email);

            ResultSet result = selectTransazioniQuery.executeQuery();

            while(result.next()){
                Transazione trans = new Transazione();
                trans.setNomeNeg(result.getString("Ref_Negoziante"));
                trans.setNumCarta(result.getString("Ref_Carta"));
                trans.setOperazione(result.getString("Operazione"));
                trans.setAmmontare(result.getFloat("Ammontare"));
                trans.setData(result.getDate("Data"));
                trans.setCausale(result.getString("Causale"));
                transazioni.add(trans);
            }
            this.getConnection().commit();
            this.getConnection().close();
        }catch (SQLException e){
            e.printStackTrace();

        }
        return transazioni;

    }
}
