package it.unipa.dinfo.munfulettoilenia.munfuletto_wsda.model;

public class Admin extends Utente{
    private int id;


    public Admin(){

    }


    public Admin(String email, String password, int id){
        super(email,password,"Admin");
        setId(id);

    }

    public void setId(int id) {
        this.id = id;
    }


    public int getId() {
        return id;
    }
}
