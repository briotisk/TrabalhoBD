-- IMPORTANTE: APARENTEMENTE, EM POSTGRE NÃO TEM "VARCHAR2", SENDO SIMPLESMENTE "VARCHAR"
--  
-- SEÇÃO DE COMENTÁRIOS:
-- 1. DEFINI VALORES ARBITRÁRIOS PRA ALGUNS CAMPOS(POR EXEMPLO: RESEARCHER_ID, NROPESQUISA, ETC.)
-- 2. NO PROJETO_PESQUISA USEI "SET NULL" NO "ON DELETE", PQ ACHO QUE NÃO FAZ SENTIDO EXCLUIR A PESQUISA
--    QUANDO O PESQUISADOR É RETIRADO DA BASE DE DADOS
-- 3. COLOQUEI O ATRIBUTO "HABITAVEL" DO PLANETA COMO "SIM" OU "NAO" - TALVEZ PRECISE MUDAR ALGO NO TEXTO
-- 4. PRECISA COLOCAR UMA VERIFICAÇÃO DOS HORÁRIOS DE ENTRADA E SAÍDA DO MOLITAR E PROFISSIONAL DE SAÚDE?
--    PRA VER SE O HORARIO DE ENTRADA É MAIS CEDO QUE O DE SAÍDA, POR EXEMPLO?
-- 5. VERIFICAR TODOS "ON DELETE"

CREATE TABLE PLANETA(
    NOME VARCHAR(20) NOT NULL,
    SISTEMA VARCHAR(20) NOT NULL,
    HABITAVEL CHAR(3) NOT NULL,
    CONSTRAINT PK_PALNETA PRIMARY KEY (NOME),
    CONSTRAINT CK_PLANETA CHECK (UPPER(HABITAVEL) IN ('SIM', 'NAO'))
);

CREATE TABLE LUA(
	NOME_PLANETA VARCHAR(20) NOT NULL,
	NOME_LUA VARCHAR(20) NOT NULL,
	CONSTRAINT PK_LUA PRIMARY KEY (NOME_PLANETA, NOME_LUA),
    CONSTRAINT FK_LUA FOREIGN KEY (NOME_PLANETA)
               REFERENCES PLANETA(NOME)
               ON DELETE CASCADE
);

CREATE TABLE NAVE(
	PLACA CHAR(8) NOT NULL,
	NROASSENTOS integer NOT NULL,
	AUTONOMIA integer NOT NULL,
	VELOCIDADEMAX integer NOT NULL,
    CONSTRAINT PK_NAVE PRIMARY KEY(PLACA)
);

CREATE TABLE COLONIA(
	ID_COLONIA integer NOT NULL,
	NOME_PLANETA CHAR(20) NOT NULL,
	LATITUDE integer NOT NULL,
	LONGITUDE integer NOT NULL,
	NOME VARCHAR(10) NOT NULL,
	NROHABITANTES integer, -- NÃO FARIA MAIS SENTIDO SER NOT NULL TBM?
    CONSTRAINT PK_COLONIA PRIMARY KEY (ID_COLONIA),
    CONSTRAINT SK_COLONIA UNIQUE (NOME_PLANETA, LATITUDE, LONGITUDE),
    CONSTRAINT CK1_COLONIA CHECK(LATITUDE >= 0 AND LATITUDE <= 90),
    CONSTRAINT CK2_COLONIA CHECK(LONGITUDE >= 0 AND LONGITUDE <= 180),
    CONSTRAINT FK_COLONIA FOREIGN KEY (NOME_PLANETA)
               REFERENCES PLANETA(NOME)
               ON DELETE CASCADE
);

CREATE TABLE INSTALACAO(
    ID_INSTALACAO integer NOT NULL,
    COLONIA integer NOT NULL,
    RUA VARCHAR(20) NOT NULL,
    NUMERO integer NOT NULL,
    TIPO VARCHAR(20) NOT NULL,
    NROFUNCIONARIOS integer,
    CUSTO_CONSTRUCAO integer NOT NULL, --VERIFICAR ISSO AQUI
    AREA_CONSTRUIDA integer NOT NULL, --VERIFICAR ISSO AQUI
    AREA_TOTAL integer NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_INSTALACAO PRIMARY KEY (ID_INSTALACAO),
    CONSTRAINT CK_INSTALACAO CHECK(UPPER(TIPO) IN ('HOSPITAL', 'LABORATORIO', 'BASE MILITAR')), 
    CONSTRAINT SK_INSTALACAO UNIQUE(COLONIA, RUA, NUMERO),
    CONSTRAINT FK_INSTALACAO FOREIGN KEY (COLONIA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE
);

CREATE TABLE PESSOA(
    CPF integer NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    COLONIA integer NOT NULL,
    DATANASC DATE NOT NULL,
    PROFISSAO VARCHAR(21),
    CONSTRAINT PK_PESSOA PRIMARY KEY (CPF),
    CONSTRAINT CK_PESSOA CHECK (UPPER(PROFISSAO) IN ('MILITAR', 'PESQUISADOR', 'OPERARIO', 'ENGENHEIRO', 'PROFISSIONAL DA SAUDE')),
    CONSTRAINT FK_PESSOA FOREIGN KEY (COLONIA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE
);

CREATE TABLE ENGENHEIRO(
    CPF integer NOT NULL,
    CREA integer NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_ENGENHEIRO PRIMARY KEY(CPF),
    CONSTRAINT SK_ENGENHEIRO UNIQUE(CREA),
    CONSTRAINT FK_ENGENHEIRO FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);


CREATE TABLE OPERARIO(
    CPF integer NOT NULL,
    NROCARTEIRATRABALHO integer NOT NULL,
    CONSTRAINT PK_OPERARIO PRIMARY KEY(CPF),
    CONSTRAINT SK_OPERARIO UNIQUE(NROCARTEIRATRABALHO),
    CONSTRAINT FK_OPERARIO FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PROFISSIONAL_SAUDE(
    CPF integer NOT NULL,
    CRM integer NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_PROFISSIONAL_SAUDE PRIMARY KEY(CPF),
    CONSTRAINT SK_PROFISSIONAL_SAUDE UNIQUE(CRM),
    CONSTRAINT FK_PROFISSIONAL_SAUDE FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PESQUISADOR(
    CPF integer NOT NULL,
    RESEARCHER_ID integer NOT NULL, 
    CONSTRAINT PK_PESQUISADOR PRIMARY KEY(CPF),
    CONSTRAINT SK_PESQUISADOR UNIQUE(RESEARCHER_ID),
    CONSTRAINT FK_PESQUISADOR FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE BASE_MILITAR(
    ID_INSTALACAO integer NOT NULL,
    CONSTRAINT PK_BASE_MILITAR PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT FK_BASE_MILITAR FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE MILITAR(
    CPF integer NOT NULL,
    PATENTE VARCHAR(8) NOT NULL,
    FUNCAO VARCHAR(10),
    HORA_ENTRADA TIME NOT NULL, --VERIFICAR ISSO AQUI
    HORA_SAIDA TIME NOT NULL, --VERIFICAR ISSO AQUI
    BASE integer,
    CONSTRAINT PK_MILITAR PRIMARY KEY(CPF),
    CONSTRAINT CK1_MILITAR CHECK(UPPER(FUNCAO) IN ('PILOTO', 'EXPLORADOR', 'SOLDADO')),
    CONSTRAINT CK2_MILITAR CHECK (UPPER(PATENTE) IN ('SOLDADO', 'CABO', 'SARGENTO', 'TENENTE', 'CAPITAO', 'MAJOR', 'CORONEL', 'GENERAL')),
    CONSTRAINT FK1_MILITAR FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE,
    CONSTRAINT FK2_MILITAR FOREIGN KEY (BASE)
               REFERENCES BASE_MILITAR(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE PILOTO(
    CPF integer NOT NULL,
    NROCARTEIRA integer NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_PILOTO PRIMARY KEY(CPF),
    CONSTRAINT SK_PILOTO UNIQUE(NROCARTEIRA),
    CONSTRAINT FK_PILOTO FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE EXPLORADOR(
    CPF integer NOT NULL,
    CONSTRAINT PK_EXPLORADOR PRIMARY KEY(CPF),
    CONSTRAINT FK_EXPLORADOR FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE SOLDADO(
    CPF integer NOT NULL,
    CONSTRAINT PK_SOLDADO PRIMARY KEY(CPF),
    CONSTRAINT FK_SOLDADO FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE LABORATORIO(
    ID_INSTALACAO integer NOT NULL,
    CONSTRAINT PK_LABORATORIO PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT FK_LABORATORIO FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE PROJETO_PESQUISA(
    NROPESQUISA integer NOT NULL,
    PESQUISADOR integer NOT NULL,
    LABORATORIO integer NOT NULL,
    AREA_CONHECIMENTO VARCHAR(20),
    CONSTRAINT PK_PROJETO_PESQUISA PRIMARY KEY (NROPESQUISA),
    CONSTRAINT FK1_PROJETO_PESQUISA FOREIGN KEY (LABORATORIO)
               REFERENCES LABORATORIO(ID_INSTALACAO)
               ON DELETE CASCADE,
    CONSTRAINT FK1_PROJETO_PESQUISA FOREIGN KEY (PESQUISADOR)
               REFERENCES PESQUISADOR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE HOSPITAL(
    ID_INSTALACAO integer NOT NULL,
    NOME VARCHAR(20) NOT NULL,
    NROLEITOS integer NOT NULL,
    NROLEITOSOCUPADOS integer NOT NULL,
    CONSTRAINT PK_HOSPITAL PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT CK_NROLEITOSOCUPADOS CHECK(NROLEITOSOCUPADOS <= NROLEITOS),
    CONSTRAINT FK_HOSPITAL FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE DEFENDE(
    COLONIA integer NOT NULL,
    SOLDADO integer NOT NULL,
    CONSTRAINT PK_DEFENDE PRIMARY KEY(COLONIA, SOLDADO),
    CONSTRAINT FK1_DEFENDE FOREIGN KEY (COLONIA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE,
    CONSTRAINT FK1_DEFENDE FOREIGN KEY (SOLDADO)
               REFERENCES SOLDADO(CPF)
               ON DELETE CASCADE
);

CREATE TABLE EXPLORA(
    PLANETA VARCHAR(20) NOT NULL,
    EXPLORADOR integer NOT NULL,
    DATA_HORA TIMESTAMP NOT NULL,
    CONSTRAINT PK_EXPLORA PRIMARY KEY(PLANETA, EXPLORADOR),
    CONSTRAINT FK1_EXPLORA FOREIGN KEY (PLANETA)
               REFERENCES PLANETA(NOME_PLANETA)
               ON DELETE CASCADE,
    CONSTRAINT FK2_EXPLORA FOREIGN KEY (EXPLORADOR)
               REFERENCES EXPLORADOR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PROJETA_INSTALACAO(
    ENGENHEIRO integer NOT NULL,
    INSTALACAO integer NOT NULL,
    CONSTRAINT PK_PROJETA_INSTALACAO PRIMARY KEY(ENGENHEIRO, INSTALACAO), 
    CONSTRAINT FK1_PROJETA_INSTALACAO FOREIGN KEY (ENGENHEIRO)
               REFERENCES ENGENHEIRO(CPF)
               ON DELETE SET NULL,--VERIFICAR ISSO AQUI
    CONSTRAINT FK2_PROJETA_INSTALACAO FOREIGN KEY (INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE SET NULL--VERIFICAR ISSO AQUI
);

CREATE TABLE CONSTROI_INSTALACAO(
    OPERARIO integer NOT NULL,
    INSTALACAO integer NOT NULL,
    CONSTRAINT PK_CONSTROI_INSTALACAO PRIMARY KEY(OPERARIO, INSTALACAO),
    CONSTRAINT FK1_CONSTROI_INSTALACAO FOREIGN KEY (OPERARIO)
               REFERENCES OPERARIO(CPF)
               ON DELETE CASCADE,--VERIFICAR ISSO AQUI
    CONSTRAINT FK2_CONSTROI_INSTALACAO FOREIGN KEY (INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE--VERIFICAR ISSO AQUI
);

CREATE TABLE TRABALHO_SAUDE(
    FUNCIONARIO integer NOT NULL,
    HOSPITAL integer NOT NULL,
    HORA_ENTRADA TIME NOT NULL,
    HORA_SAIDA TIME NOT NULL,
    CONSTRAINT PK_TRABALHO_SAUDE PRIMARY KEY(FUNCAO, HOSPITAL),
    CONSTRAINT FK1_TRABALHO_SAUDE FOREIGN KEY (FUNCIONARIO)
               REFERENCES PROFISSIONAL_SAUDE(CPF)
               ON DELETE CASCADE,
    CONSTRAINT FK2_TRABALHO_SAUDE FOREIGN KEY (HOSPITAL)
               REFERENCES HOSPITAL(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE ROTA(
    COLONIA_SAIDA integer NOT NULL,
    COLONIA_CHEGADA integer NOT NULL,
    DISTANCIA integer NOT NULL,
    LIMITE_VELOCIDADE integer,
    CONSTRAINT PK_ROTA PRIMARY KEY(COLONIA_CHEGADA, COLONIA_SAIDA, DISTANCIA),
    CONSTRAINT CK_ROTA CHECK(COLONIA_CHEGADA <> COLONIA_SAIDA),
    CONSTRAINT FK1_ROTA FOREIGN KEY (COLONIA_CHEGADA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE,
    CONSTRAINT FK2_ROTA FOREIGN KEY (COLONIA_SAIDA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE
);

CREATE TABLE VIAGEM(
    DATA_HORA TIMESTAMP NOT NULL,
    NAVE CHAR(8) NOT NULL,
    COLONIA_SAIDA integer NOT NULL,
    COLONIA_CHEGADA integer NOT NULL,
    DISTANCIA integer NOT NULL,
    HORA_CHEGADA TIMESTAMP NOT NULL,
    PRECO_PASSAGEM integer NOT NULL,
    PILOTO integer NOT NULL,
    DURACAO TIME NOT NULL,
    CONSTRAINT PK_VIAGEM PRIMARY KEY(DATA_HORA, NAVE),
    CONSTRAINT CK1_VIAGEM CHECK(DATA_HORA < HORA_CHEGADA),
    --CONSTRAINT CK2_VIAGEM CHECK(DISTANCIA < )--checar se a distância é menor que a autonomia da nave
    CONSTRAINT FK1_VIAGEM FOREIGN KEY (COLONIA_SAIDA, COLONIA_CHEGADA, DISTANCIA)
               REFERENCES ROTA(COLONIA_SAIDA, COLONIA_CHEGADA, DISTANCIA)
               ON DELETE CASCADE,
    CONSTRAINT FK2_VIAGEM FOREIGN KEY (NAVE)
               REFERENCES NAVE(PLACA)
               ON DELETE CASCADE,
    CONSTRAINT FK3_VIAGEM FOREIGN KEY (PILOTO)
               REFERENCES PILOTO(CPF)
               ON DELETE CASCADE
);

CREATE TABLE VIAJAM(
    PESSOA integer NOT NULL,
    DATA_HORA TIMESTAMP NOT NULL,
    NAVE CHAR(8) NOT NULL,
    CONSTRAINT PK_VIAJAM PRIMARY KEY(PESSOA, DATA_HORA, NAVE),
    CONSTRAINT FK1_VIAJAM FOREIGN KEY (PESSOA)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE,
    CONSTRAINT FK2_VIAJAM FOREIGN KEY (NAVE)
               REFERENCES NAVE(PLACA)
               ON DELETE CASCADE
);