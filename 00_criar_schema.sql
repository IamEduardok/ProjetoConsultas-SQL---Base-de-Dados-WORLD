-- Projeto World - Jose Eduardo - RA 220100
-- Execute somente em uma instancia MySQL local/separada do banco do trabalho.
-- Este script cria e seleciona o schema do projeto, sem apagar dados.

CREATE DATABASE IF NOT EXISTS jose_eduardo_world
  CHARACTER SET utf8mb4;

USE jose_eduardo_world;

SELECT DATABASE() AS schema_selecionado;
