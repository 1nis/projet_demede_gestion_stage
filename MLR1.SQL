DROP DATABASE IF EXISTS Stage;

CREATE DATABASE IF NOT EXISTS Stage;
USE Stage;
# -----------------------------------------------------------------------------
#       TABLE : ETUDIANT
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ETUDIANT
 (
   N°ETUDIANT CHAR(32) NOT NULL  ,
   NOMETUDIANT CHAR(32) NULL  ,
   PRENOMETUDIANT CHAR(32) NULL  ,
   ADRESSEETUDIANT CHAR(32) NULL  ,
   MAILETUDIANT CHAR(32) NULL  ,
   DATE_NETUDIANT CHAR(32) NULL  ,
   SEXEETUDIANT CHAR(32) NULL  ,
   TELETUDIANT CHAR(32) NULL  ,
   OPTIONETUDIANT CHAR(32) NULL  ,
   ANNEESCOLAIRE CHAR(32) NULL  
   , PRIMARY KEY (N°ETUDIANT) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : PROFESSEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROFESSEUR
 (
   NOMPROFESSEUR CHAR(32) NOT NULL  ,
   PRENOMPROFESSEUR CHAR(32) NULL  ,
   NBRHEURES CHAR(32) NULL  ,
   NUMPROFESSEUR CHAR(32) NULL  ,
   MAILPROFESSEUR CHAR(32) NULL  
   , PRIMARY KEY (NOMPROFESSEUR) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : STAGE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS STAGE
 (
   NUM_STAGE CHAR(32) NOT NULL  ,
   NOMENTREPRISE CHAR(32) NOT NULL  ,
   NOMTUTEUR CHAR(32) NOT NULL  ,
   NOMPROFESSEUR CHAR(32) NOT NULL  ,
   N°ETUDIANT CHAR(32) NOT NULL  ,
   DDSTAGE DATE NULL  ,
   DFSTAGE CHAR(32) NULL  ,
   SJSTAGE CHAR(32) NULL  ,
   NBRSEMINE CHAR(32) NULL  ,
   RPST_STAGE CHAR(32) NULL  ,
   CP_ASS CHAR(32) NULL  ,
   C_ASS CHAR(32) NULL  ,
   NUM_CONTR CHAR(32) NULL  
   , PRIMARY KEY (NUM_STAGE) 
 ) Engine=InnoDB,
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
     ON STAGE (N°ETUDIANT ASC);

# -----------------------------------------------------------------------------
#       TABLE : PROMOTION
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS PROMOTION
 (
   NOMCLASSE CHAR(32) NOT NULL  ,
   ANNEE CHAR(32) NULL  ,
   PROFESSEURPRINCIPAL CHAR(32) NULL  ,
   PROFESSEURS CHAR(32) NULL  ,
   NBRELEVE CHAR(32) NULL  
   , PRIMARY KEY (NOMCLASSE) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENTREPRISE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENTREPRISE
 (
   NOMENTREPRISE CHAR(32) NOT NULL  ,
   NOMTUTEUR CHAR(32) NOT NULL  ,
   MAILENTREPRISE CHAR(32) NULL  ,
   NUMENTREPRISE CHAR(32) NULL  ,
   PDGENTREPRISE CHAR(32) NULL  ,
   TYPEENTREPRISE CHAR(32) NULL  ,
   SECTENREPRISE CHAR(32) NULL  ,
   VILLEENTEPRISE CHAR(32) NULL  ,
   CODEPOSTALEENTREPRISE CHAR(32) NULL  
   , PRIMARY KEY (NOMENTREPRISE) 
 ) Engine=InnoDB,
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
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : TUTEUR
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS TUTEUR
 (
   NOMTUTEUR CHAR(32) NOT NULL  ,
   PRENOMTUTEUR CHAR(32) NULL  ,
   FONCTION CHAR(32) NULL  ,
   ENTREPRISETUTEUR CHAR(32) NULL  ,
   NBRSTAGIAIRE CHAR(32) NULL  
   , PRIMARY KEY (NOMTUTEUR) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       TABLE : ENSEIGNE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ENSEIGNE
 (
   NOMPROFESSEUR CHAR(32) NOT NULL  ,
   NOMCLASSE CHAR(32) NOT NULL  
   , PRIMARY KEY (NOMPROFESSEUR,NOMCLASSE) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ENSEIGNE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ENSEIGNE_PROFESSEUR
     ON ENSEIGNE (NOMPROFESSEUR ASC);

CREATE  INDEX I_FK_ENSEIGNE_PROMOTION
     ON ENSEIGNE (NOMCLASSE ASC);

# -----------------------------------------------------------------------------
#       TABLE : ÊTRE
# -----------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS ÊTRE
 (
   N°ETUDIANT CHAR(32) NOT NULL  ,
   NOMCLASSE CHAR(32) NOT NULL  
   , PRIMARY KEY (N°ETUDIANT,NOMCLASSE) 
 ) Engine=InnoDB,
 comment = "";

# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ÊTRE
# -----------------------------------------------------------------------------


CREATE  INDEX I_FK_ÊTRE_ETUDIANT
     ON ÊTRE (N°ETUDIANT ASC);

CREATE  INDEX I_FK_ÊTRE_PROMOTION
     ON ÊTRE (NOMCLASSE ASC);


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
  ADD FOREIGN KEY FK_STAGE_ETUDIANT (N°ETUDIANT)
      REFERENCES ETUDIANT (N°ETUDIANT) ;


ALTER TABLE ENTREPRISE 
  ADD FOREIGN KEY FK_ENTREPRISE_TUTEUR (NOMTUTEUR)
      REFERENCES TUTEUR (NOMTUTEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROFESSEUR (NOMPROFESSEUR)
      REFERENCES PROFESSEUR (NOMPROFESSEUR) ;


ALTER TABLE ENSEIGNE 
  ADD FOREIGN KEY FK_ENSEIGNE_PROMOTION (NOMCLASSE)
      REFERENCES PROMOTION (NOMCLASSE) ;


ALTER TABLE ÊTRE 
  ADD FOREIGN KEY FK_ÊTRE_ETUDIANT (N°ETUDIANT)
      REFERENCES ETUDIANT (N°ETUDIANT) ;


ALTER TABLE ÊTRE 
  ADD FOREIGN KEY FK_ÊTRE_PROMOTION (NOMCLASSE)
      REFERENCES PROMOTION (NOMCLASSE) ;

