DROP DATABASE IF EXISTS MLR1;

CREATE DATABASE IF NOT EXISTS MLR1;
USE MLR1;
# -----------------------------------------------------------------------------
#       TABLE : ASSURANCE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ASSURANCE
 (
   NOMCOMPAGNIE CHAR(32) NOT NULL  ,
   CAISSEPRIMAIRE CHAR(32) NULL  ,
   NUMCONTRAT CHAR(32) NULL  
   , PRIMARY KEY (NOMCOMPAGNIE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ETUDIANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT
 (
   NUMETUDIANT INTEGER NOT NULL  ,
   NOMETUDIANT VARCHAR(32) NULL  ,
   PRENOMETUDIANT VARCHAR(32) NULL  ,
   ADRESSEETUDIANT VARCHAR(32) NULL  ,
   MAILETUDIANT VARCHAR(32) NULL  ,
   DATE_NETUDIANT DATE NULL  ,
   SEXEETUDIANT BOOL NULL  ,
   TELETUDIANT INTEGER NULL  ,
   OPTIONETUDIANT VARCHAR(5) NULL  ,
   ANNEESCOLAIRE INTEGER NULL  
   , PRIMARY KEY (NUMETUDIANT) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PROFESSEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROFESSEUR
 (
   NOMPROFESSEUR VARCHAR(32) NOT NULL  ,
   PRENOMPROFESSEUR VARCHAR(32) NULL  ,
   NBRHEURES INTEGER NULL  ,
   NUMPROFESSEUR INTEGER NULL  ,
   MAILPROFESSEUR VARCHAR(32) NULL  
   , PRIMARY KEY (NOMPROFESSEUR) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : STAGE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS STAGE
 (
   NUMSTAGE INTEGER NOT NULL  ,
   NOMENTREPRISE VARCHAR(32) NOT NULL  ,
   NOMTUTEUR VARCHAR(32) NOT NULL  ,
   NOMPROFESSEUR VARCHAR(32) NOT NULL  ,
   NUMETUDIANT INTEGER NOT NULL  ,
   DDSTAGE DATE NULL  ,
   DFSTAGE DATE NULL  ,
   SJSTAGE VARCHAR(32) NULL  ,
   NBRSEMAINE INTEGER NULL  ,
   RPST_STAGE VARCHAR(32) NULL  ,
   CP_ASS VARCHAR(32) NULL  ,
   C_ASS VARCHAR(32) NULL  ,
   NUM_CONTR INTEGER NULL  
   , PRIMARY KEY (NUMSTAGE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE STAGE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_STAGE_ENTREPRISE
     ON STAGE (NOMENTREPRISE ASC);

CREATE  INDEX I_FK_STAGE_TUTEUR
     ON STAGE (NOMTUTEUR ASC);

CREATE  INDEX I_FK_STAGE_PROFESSEUR
     ON STAGE (NOMPROFESSEUR ASC);

CREATE  INDEX I_FK_STAGE_ETUDIANT
     ON STAGE (NUMETUDIANT ASC);

# -----------------------------------------------------------------------------
#       TABLE : PROMOTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROMOTION
 (
   NOMCLASSE VARCHAR(32) NOT NULL  ,
   ANNEE INTEGER NULL  ,
   PROFESSEURPRINCIPAL VARCHAR(32) NULL  ,
   PROFESSEURS INTEGER NULL  ,
   NBRELEVE INTEGER NULL  
   , PRIMARY KEY (NOMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENTREPRISE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENTREPRISE
 (
   NOMENTREPRISE VARCHAR(32) NOT NULL  ,
   NOMTUTEUR VARCHAR(32) NOT NULL  ,
   MAILENTREPRISE VARCHAR(32) NULL  ,
   NUMENTREPRISE INTEGER NULL  ,
   PDGENTREPRISE VARCHAR(32) NULL  ,
   TYPEENTREPRISE VARCHAR(32) NULL  ,
   SECTENREPRISE VARCHAR(32) NULL  ,
   VILLEENTEPRISE VARCHAR(32) NULL  ,
   CODEPOSTALEENTREPRISE INTEGER NULL  
   , PRIMARY KEY (NOMENTREPRISE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENTREPRISE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENTREPRISE_TUTEUR
     ON ENTREPRISE (NOMTUTEUR ASC);

# -----------------------------------------------------------------------------
#       TABLE : PARAMETRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PARAMETRE
 (
   NOMETABLISSEMENT CHAR(32) NOT NULL  ,
   ADRESSEETABLISSEMENT CHAR(32) NULL  ,
   CPETABLISSEMENT CHAR(32) NULL  ,
   NUMETABLISSEMENT CHAR(32) NULL  ,
   FAXETABLISSEMENT CHAR(32) NULL  ,
   REPRESENTANT CHAR(32) NULL  
   , PRIMARY KEY (NOMETABLISSEMENT) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : TUTEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TUTEUR
 (
   NOMTUTEUR VARCHAR(32) NOT NULL  ,
   PRENOMTUTEUR VARCHAR(32) NULL  ,
   FONCTION VARCHAR(32) NULL  ,
   ENTREPRISETUTEUR VARCHAR(32) NULL  ,
   NBRSTAGIAIRE INTEGER NULL  
   , PRIMARY KEY (NOMTUTEUR) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENSEIGNE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENSEIGNE
 (
   NOMPROFESSEUR VARCHAR(32) NOT NULL  ,
   NOMCLASSE VARCHAR(32) NOT NULL  
   , PRIMARY KEY (NOMPROFESSEUR,NOMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENSEIGNE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENSEIGNE_PROFESSEUR
     ON ENSEIGNE (NOMPROFESSEUR ASC);

CREATE  INDEX I_FK_ENSEIGNE_PROMOTION
     ON ENSEIGNE (NOMCLASSE ASC);

# -----------------------------------------------------------------------------
#       TABLE : ETRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETRE
 (
   NUMETUDIANT INTEGER NOT NULL  ,
   NOMCLASSE VARCHAR(32) NOT NULL  
   , PRIMARY KEY (NUMETUDIANT,NOMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ETRE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ETRE_ETUDIANT
     ON ETRE (NUMETUDIANT ASC);

CREATE  INDEX I_FK_ETRE_PROMOTION
     ON ETRE (NOMCLASSE ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_ENTREPRISE (NOMENTREPRISE)
      REFERENCES ENTREPRISE (NOMENTREPRISE) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_TUTEUR (NOMTUTEUR)
      REFERENCES TUTEUR (NOMTUTEUR) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_PROFESSEUR (NOMPROFESSEUR)
      REFERENCES PROFESSEUR (NOMPROFESSEUR) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_ETUDIANT (NUMETUDIANT)
      REFERENCES ETUDIANT (NUMETUDIANT) ;


ALTER TABLE ENTREPRISE 
  ADD FOREIGN KEY FK_ENTREPRISE_TUTEUR (NOMTUTEUR)
      REFERENCES TUTEUR (NOMTUTEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROFESSEUR (NOMPROFESSEUR)
      REFERENCES PROFESSEUR (NOMPROFESSEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROMOTION (NOMCLASSE)
      REFERENCES PROMOTION (NOMCLASSE) ;


ALTER TABLE ETRE 
  ADD FOREIGN KEY FK_ETRE_ETUDIANT (NUMETUDIANT)
      REFERENCES ETUDIANT (NUMETUDIANT) ;


ALTER TABLE ETRE 
  ADD FOREIGN KEY FK_ETRE_PROMOTION (NOMCLASSE)
      REFERENCES PROMOTION (NOMCLASSE) ;

