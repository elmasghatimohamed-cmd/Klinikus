<<<<<<< HEAD
-- Klinikus schema (PostgreSQL)
CREATE TABLE IF NOT EXISTS utilisateur (
  id BIGSERIAL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  mot_de_passe VARCHAR(100) NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('INFIRMIER','GENERALISTE'))
);

CREATE TABLE IF NOT EXISTS patient (
  id BIGSERIAL PRIMARY KEY,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  date_naissance DATE NOT NULL,
  num_secu VARCHAR(30) NOT NULL,
  tension VARCHAR(20),
  frequence_cardiaque INT,
  temperature NUMERIC(4,1),
  frequence_respiratoire INT,
  date_arrivee TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS consultation (
  id BIGSERIAL PRIMARY KEY,
  patient_id BIGINT NOT NULL REFERENCES patient(id),
  medecin_id BIGINT NOT NULL REFERENCES utilisateur(id),
  motif VARCHAR(255) NOT NULL,
  observations TEXT,
  diagnostic TEXT NOT NULL,
  traitement TEXT,
  cout NUMERIC(10,2) NOT NULL DEFAULT 150.00,
  statut VARCHAR(20) NOT NULL,
  date_consultation TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO utilisateur (nom, email, mot_de_passe, role) VALUES
 ('Infirmier Test', 'infirmier@klinikus.ma', '$2a$10$j/u4vNZHXcwI/A/R8qebwegbR8eJlRsS6YgRWeCm8ddVFcjPP0uZ.', 'INFIRMIER'),
 ('Dr Test', 'medecin@klinikus.ma', '$2a$10$d0zALAeYmnXh1wE9csTTFOaZZJHbknuhszzg5tIxFY9RCUZZaTc6S', 'GENERALISTE');
 
=======
CREATE DATABASE klinikus;
>>>>>>> 7284af4c79a5565d5308b7a8066f0029f4023f79
