DROP DATABASE IF EXISTS MLR2;

CREATE DATABASE IF NOT EXISTS MLR2;
USE MLR2;
# -----------------------------------------------------------------------------
#       TABLE : ETUDIANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT
 (
   NUMETUDIANT INTEGER NOT NULL  AUTO_INCREMENT,
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
   NUMPROFESSEUR INTEGER NOT NULL  AUTO_INCREMENT,
   NOMPROFESSEUR VARCHAR(32) NULL  ,
   PRENOMPROFESSEUR VARCHAR(32) NULL  ,
   NBRHEURES INTEGER NULL  ,
   MAILPROFESSEUR VARCHAR(32) NULL  
   , PRIMARY KEY (NUMPROFESSEUR) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : STAGE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS STAGE
 (
   NUMSTAGE INTEGER NOT NULL  AUTO_INCREMENT,
   NUMENTREPRISE INTEGER NOT NULL  ,
   NUMTUTEUR INTEGER NOT NULL  ,
   NUMPROFESSEUR INTEGER NOT NULL  ,
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
     ON STAGE (NUMENTREPRISE ASC);

CREATE  INDEX I_FK_STAGE_TUTEUR
     ON STAGE (NUMTUTEUR ASC);

CREATE  INDEX I_FK_STAGE_PROFESSEUR
     ON STAGE (NUMPROFESSEUR ASC);

CREATE  INDEX I_FK_STAGE_ETUDIANT
     ON STAGE (NUMETUDIANT ASC);

# -----------------------------------------------------------------------------
#       TABLE : PROMOTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROMOTION
 (
   NUMCLASSE INTEGER NOT NULL AUTO_INCREMENT ,
   NOMCLASSE VARCHAR(32) NULL  ,
   ANNEE INTEGER NULL  ,
   PROFESSEURPRINCIPAL VARCHAR(32) NULL  ,
   PROFESSEURS INTEGER NULL  ,
   NBRELEVE INTEGER NULL  
   , PRIMARY KEY (NUMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENTREPRISE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENTREPRISE
 (
   NUMENTREPRISE INTEGER NOT NULL  AUTO_INCREMENT,
   NUMTUTEUR INTEGER NOT NULL  ,
   NOMENTREPRISE VARCHAR(32) NULL  ,
   MAILENTREPRISE VARCHAR(32) NULL  ,
   PDGENTREPRISE VARCHAR(32) NULL  ,
   TYPEENTREPRISE VARCHAR(32) NULL  ,
   SECTENREPRISE VARCHAR(32) NULL  ,
   VILLEENTEPRISE VARCHAR(32) NULL  ,
   CODEPOSTALEENTREPRISE INTEGER NULL  
   , PRIMARY KEY (NUMENTREPRISE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENTREPRISE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENTREPRISE_TUTEUR
     ON ENTREPRISE (NUMTUTEUR ASC);

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
   NUMTUTEUR INTEGER NOT NULL  AUTO_INCREMENT,
   NOMTUTEUR VARCHAR(32) NULL  ,
   PRENOMTUTEUR VARCHAR(32) NULL  ,
   FONCTION VARCHAR(32) NULL  ,
   ENTREPRISETUTEUR VARCHAR(32) NULL  ,
   NBRSTAGIAIRE INTEGER NULL  
   , PRIMARY KEY (NUMTUTEUR) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENSEIGNE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENSEIGNE
 (
   NUMPROFESSEUR INTEGER NOT NULL  AUTO_INCREMENT,
   NUMCLASSE INTEGER NOT NULL  
   , PRIMARY KEY (NUMPROFESSEUR,NUMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENSEIGNE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENSEIGNE_PROFESSEUR
     ON ENSEIGNE (NUMPROFESSEUR ASC);

CREATE  INDEX I_FK_ENSEIGNE_PROMOTION
     ON ENSEIGNE (NUMCLASSE ASC);

# -----------------------------------------------------------------------------
#       TABLE : ETRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETRE
 (
   NUMETUDIANT INTEGER NOT NULL  AUTO_INCREMENT,
   NUMCLASSE INTEGER NOT NULL  
   , PRIMARY KEY (NUMETUDIANT,NUMCLASSE) 
 ) Engine = InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ETRE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ETRE_ETUDIANT
     ON ETRE (NUMETUDIANT ASC);

CREATE  INDEX I_FK_ETRE_PROMOTION
     ON ETRE (NUMCLASSE ASC);


# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_ENTREPRISE (NUMENTREPRISE)
      REFERENCES ENTREPRISE (NUMENTREPRISE) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_TUTEUR (NUMTUTEUR)
      REFERENCES TUTEUR (NUMTUTEUR) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_PROFESSEUR (NUMPROFESSEUR)
      REFERENCES PROFESSEUR (NUMPROFESSEUR) ;


ALTER TABLE STAGE 
  ADD FOREIGN KEY FK_STAGE_ETUDIANT (NUMETUDIANT)
      REFERENCES ETUDIANT (NUMETUDIANT) ;


ALTER TABLE ENTREPRISE 
  ADD FOREIGN KEY FK_ENTREPRISE_TUTEUR (NUMTUTEUR)
      REFERENCES TUTEUR (NUMTUTEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROFESSEUR (NUMPROFESSEUR)
      REFERENCES PROFESSEUR (NUMPROFESSEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROMOTION (NUMCLASSE)
      REFERENCES PROMOTION (NUMCLASSE) ;


ALTER TABLE ETRE 
  ADD FOREIGN KEY FK_ETRE_ETUDIANT (NUMETUDIANT)
      REFERENCES ETUDIANT (NUMETUDIANT) ;


ALTER TABLE ETRE 
  ADD FOREIGN KEY FK_ETRE_PROMOTION (NUMCLASSE)
      REFERENCES PROMOTION (NUMCLASSE) ;

