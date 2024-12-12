DROP SCHEMA IF EXISTS `Munfuletto`;
CREATE SCHEMA IF NOT EXISTS `Munfuletto`;
USE Munfuletto;


/*La tabella Utenti specifica le utenze, distinte tra Admin, Negoziante e Titolare, ognuno caratterizzato da una email e 
da una password memorizzata come digest di SHA-256*/
CREATE TABLE IF NOT EXISTS Utenti (
	`Email` VARCHAR(64) primary key,
    `Password` CHAR(64) NOT NULL,
    `Tipo` VARCHAR(10) NOT NULL,
    check(Tipo in ('Admin', 'Negoziante','Titolare'))
);


/*La tabella Admin specifica le caratteristiche di un Admin, cioè un id e un riferimento alla email di Utenti */
CREATE TABLE IF NOT EXISTS Admin (
	`Ref_Email` VARCHAR(64) references Utenti(Email),
    `id` SMALLINT auto_increment primary key
    
);

/*La tabella Negoziante ne specifica la email, con riferimento a Utenti, il nome, tipo di attività, città, il numero di telefono e 
se è attualmente abilitato o meno a ricaricare o addebitare una carta*/
CREATE TABLE IF NOT EXISTS Negoziante (
	`Ref_Email` VARCHAR(64) references Utenti(Email),
    `Nome` VARCHAR(128) NOT NULL,
    `Attivita` VARCHAR(128) NOT NULL,
    `Citta` VARCHAR(128) NOT NULL,
    `NumTel` CHAR(10) NOT NULL,
    `Abilitato` BOOL NOT NULL
);


/*La tabella Titolare specifica i clienti della banca, ognuno dei quali presenta una mail ed altre informazioni personali*/
CREATE TABLE IF NOT EXISTS Titolare (
	`Ref_Email` VARCHAR(64) references Utenti(Email),
    `Nome` VARCHAR(64) NOT NULL,
    `Cognome` VARCHAR(64) NOT NULL,
    `Data di Nascita` DATE NOT NULL,
    `Codice Fiscale` CHAR(16) NOT NULL,
    `NumTel` CHAR(10) NOT NULL,
    `Citta` VARCHAR(128) NOT NULL
);

/*La tabella Carte specifica le varie carte, agnuna della quali associata ad un singolo Titolare (più carte per il singolo Titolare ma 
un Titolare per ogni singola carta) dunque unica nel DB. Anche in questo caso memorizzo il CVV come il suo digest SHA-256*/
CREATE TABLE IF NOT EXISTS Carte (
	`Ref_Titolare` VARCHAR(64) references Titolare(Ref_Email),
    `Numero` CHAR(16) primary key,
    `Data scadenza` DATE,
    `CVV` CHAR(64) NOT NULL,
    `Saldo` DECIMAL(10,2),
    `Stato` VARCHAR(8) NOT NULL,
    check(Stato in ('Attiva', 'Bloccata'))
);


/*La tabella Transazioni specifica le transazioni associate ad una specifica carta ed effettuate presso uno specifico negoziante, tracciando
le informazioni come numero, mittente, destinatario, tipo di operazione, l'ammontare e la data in cui è stata effettuata*/
CREATE TABLE IF NOT EXISTS Transazioni (
	/*`Numero` SMALLINT auto_increment PRIMARY KEY,*/
	`Ref_Negoziante` VARCHAR(128) references Negoziante(Nome),
    `Ref_Carta` CHAR(16) references Carte(Numero),
    `Operazione` VARCHAR(8) NOT NULL,
    check(Operazione in ('Ricarica','Addebita')),
    `Ammontare` DECIMAL(10,2) NOT NULL,
    check ((Ammontare >= 0 AND Operazione = 'Ricarica') OR (Ammontare < 0 AND Operazione = 'Addebita')),
    `Data` DATE NOT NULL,
    `Causale` VARCHAR(64) 
);





/*POPOLAZIONE DEL DB*/

/*Utenti*/
insert into Utenti values 
('mario.rossi@gmail.com','1729ec9149d3d2af04ee1838ce459779c1aa95cc73056d21dc25595b6ef97fa0','Titolare'),
('carlo.bianchi@yahoo.com','183bfe8cb6071dfbd18566dd4a8e3c023655c32faeb23fcf3f2bb619192774ce','Negoziante'),
('ilenia.munfuletto@gmail.com','f490f8a773722db6aac81ff0a59e3ae4faf490efb8c31432bc848a51e39370ca','Admin'),
('vincenzo.fardella@gmail.com','57b964e6e581f68c6784e1bdf6417456a150fbb6721165600e71d3815f7ae095','Titolare'),
('federica.purpuri@gmail.com','87ccf22c9ae44ed5ae2a77417e0b6fe5166ad9d3fc4d61d377d58004eba8411d','Negoziante'),
('rosaria.piro@outlook.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Admin'),

('isabella.turano@outlook.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Negoziante'),
('salvatore.benigno@hotmail.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Titolare'),
('mattia.acireale@aruba.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Titolare'),
('saverio.brignano@libero.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Admin'),
('antonio.fazio@live.it','064a82dabccfafb2d955dfceea31746179f67ff2e89ad9d89bf986ce6f24b303','Negoziante');



/*Admin*/
insert into Admin values
('ilenia.munfuletto@gmail.com',1),
('rosaria.piro@outlook.it',2),
('saverio.brignano@libero.it',3);


/*Negoziante*/
insert into Negoziante values
('carlo.bianchi@yahoo.com', 'Bar 4 Bianchi', 'Palermo', 'Tempo Libero','0923947508',TRUE),
('federica.purpuri@gmail.com', 'Viaggi&Co', 'Castelbuono', 'Viaggi e Trasporti', '0921675555', FALSE),
('isabella.turano@outlook.it', 'La casa della piante', 'Salaparuta', 'Fioraio', '0924095673', TRUE),
('antonio.fazio@live.it', 'Chiodo schiaccia chiodo', 'Palermo', 'Ferramenta', '0912106996', TRUE);



/*Titolare*/
insert into Titolare values
('mario.rossi@gmail.com','Mario', 'Rossi', '1974-12-03','RSSMRA74T03C421J','3284567123','Cefalu'),
('vincenzo.fardella@gmail.com','Vincenzo', 'Fardella', '1996-06-21','FRDVCN96H21F061E','3923919074','Mazara del Vallo'),
('salvatore.benigno@hotmail.it','Salvatore', 'Benigno', '1987-02-25','BNGSVT87B25G347U','3687640445','Partanna'),
('mattia.acireale@aruba.it','Mattia', 'Acireale', '1946-09-15','MTTCRL46P15C351O','3339154087','Catania');


/*Carte*/
insert into Carte values
('vincenzo.fardella@gmail.com', '5333124156782502','2025-08-01','c7e616822f366fb1b5e0756af498cc11d2c0862edcb32ca65882f622ff39de1b',2000.00, 'Attiva');



