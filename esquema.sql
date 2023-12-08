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
	NROASSENTOS NUMBER(4) NOT NULL,
	AUTONOMIA NUMBER(8) NOT NULL,
	VELOCIDADEMAX NUMBER(8) NOT NULL,
    CONSTRAINT PK_NAVE PRIMARY KEY(PLACA)
);

CREATE TABLE COLONIA(
	ID_COLONIA NUMBER(12) NOT NULL,
	NOME_PLANETA CHAR(20) NOT NULL,
	LATITUDE NUMBER(3) NOT NULL,
	LONGITUDE NUMBER(3) NOT NULL,
	NOME VARCHAR(10) NOT NULL,
	NROHABITANTES NUMBER(10), -- NÃO FARIA MAIS SENTIDO SER NOT NULL TBM?
    CONSTRAINT PK_COLONIA PRIMARY KEY (ID_COLONIA),
    CONSTRAINT SK_COLONIA UNIQUE (NOME_PLANETA, LATITUDE, LONGITUDE),
    CONSTRAINT CK1_COLONIA CHECK(LATITUDE >= 0 AND LATITUDE <= 90),
    CONSTRAINT CK1_COLONIA CHECK(LONGITUDE >= 0 AND LONGITUDE <= 180),
    CONSTRAINT FK_COLONIA FOREIGN KEY (NOME_PLANETA)
               REFERENCES PLANETA(NOME)
               ON DELETE CASCADE
);

CREATE TABLE INSTALACAO(
    ID_INSTALACAO NUMBER(10) NOT NULL,
    COLONIA NUMBER(12) NOT NULL,
    RUA VARCHAR(20) NOT NULL,
    NUMERO NUMBER(4) NOT NULL,
    TIPO VARCHAR() NOT NULL,
    NROFUNCIONARIOS NUMBER(4),
    CUSTO_CONSTRUCAO NUMBER(9) NOT NULL, --VERIFICAR ISSO AQUI
    AREA_CONSTRUIDA NUMBER(6) NOT NULL, --VERIFICAR ISSO AQUI
    AREA_TOTAL NUMBER(6) NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_INSTALACAO PRIMARY KEY (ID_INSTALACAO),
    CONSTRAINT CK_INSTALACAO CHECK(UPPER(TIPO) IN ('HOSPITAL', 'LABORATORIO', 'BASE MILITAR')), 
    CONSTRAINT SK_INSTALACAO UNIQUE(COLONIA, RUA, NUMERO),
    CONSTRAINT FK_INSTALACAO FOREIGN KEY (COLONIA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE
);

CREATE TABLE PESSOA(
    CPF NUMBER(11) NOT NULL,
    NOME VARCHAR(50) NOT NULL,
    COLONIA NUMBER(12) NOT NULL,
    DATANASC DATE NOT NULL,
    PROFISSAO VARCHAR(21),
    CONSTRAINT PK_PESSOA PRIMARY KEY (CPF),
    CONSTRAINT CK_PESSOA CHECK (UPPER(PROFISSAO) IN ('MILITAR', 'PESQUISADOR', 'OPERARIO', 'ENGENHEIRO', 'PROFISSIONAL DA SAUDE')),
    CONSTRAINT FK_PESSOA FOREIGN KEY (COLONIA)
               REFERENCES COLONIA(ID_COLONIA)
               ON DELETE CASCADE
);

CREATE TABLE ENGENHEIRO(
    CPF NUMBER(11) NOT NULL,
    CREA NUMBER(10) NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_ENGENHEIRO PRIMARY KEY(CPF),
    CONSTRAINT SK_ENGENHEIRO UNIQUE(CREA),
    CONSTRAINT FK_ENGENHEIRO FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);


CREATE TABLE OPERARIO(
    CPF NUMBER(11) NOT NULL,
    NROCARTEIRATRABALHO NUMBER(11) NOT NULL,
    CONSTRAINT PK_OPERARIO PRIMARY KEY(CPF,)
    CONSTRAINT SK_OPERARIO UNIQUE(NROCARTEIRATRABALHO),
    CONSTRAINT FK_OPERARIO FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PROFISSIONAL_SAUDE(
    CPF NUMBER(11) NOT NULL,
    CRM NUMBER(6) NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_PROFISSIONAL_SAUDE PRIMARY KEY(CPF),
    CONSTRAINT SK_PROFISSIONAL_SAUDE UNIQUE(CRM),
    CONSTRAINT FK_PROFISSIONAL_SAUDE FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PESQUISADOR(
    CPF NUMBER(11) NOT NULL,
    RESEARCHER_ID NUMBER(10) NOT NULL, 
    CONSTRAINT PK_PESQUISADOR PRIMARY KEY(CPF),
    CONSTRAINT SK_PESQUISADOR UNIQUE(RESEARCHER_ID),
    CONSTRAINT FK_PESQUISADOR FOREIGN KEY (CPF)
               REFERENCES PESSOA(CPF)
               ON DELETE CASCADE
);

CREATE TABLE BASE_MILITAR(
    ID_INSTALACAO NUMBER(10) NOT NULL,
    CONSTRAINT PK_INSTALACAO PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT FK_BASE_MILITAR FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE MILITAR(
    CPF NUMBER(11) NOT NULL,
    PATENTE VARCHAR(8) NOT NULL,
    FUNCAO VARCHAR(10),
    HORA_ENTRADA TIME NOT NULL, --VERIFICAR ISSO AQUI
    HORA_SAIDA TIME NOT NULL, --VERIFICAR ISSO AQUI
    BASE NUMBER(10),
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
    CPF NUMBER(11) NOT NULL,
    NROCARTEIRA NUMBER(10) NOT NULL, --VERIFICAR ISSO AQUI
    CONSTRAINT PK_PILOTO PRIMARY KEY(CPF),
    CONSTRAINT SK_PILOTO UNIQUE(NROCARTEIRA),
    CONSTRAINT FK_PILOTO FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE EXPLORADOR(
    CPF NUMBER(11) NOT NULL,
    CONSTRAINT PK_EXPLORADOR PRIMARY KEY(CPF),
    CONSTRAINT FK_EXPLORADOR FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE SOLDADO(
    CPF NUMBER(11) NOT NULL,
    CONSTRAINT PK_SOLDADO PRIMARY KEY(CPF),
    CONSTRAINT FK_SOLDADO FOREIGN KEY (CPF)
               REFERENCES MILITAR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE LABORATORIO(
    ID_INSTALACAO NUMBER(10) NOT NULL,
    CONSTRAINT PK_LABORATORIO PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT FK_LABORATORIO FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE PROJETO_PESQUISA(
    NROPESQUISA NUMBER(6) NOT NULL PRIMARY KEY,
    PESQUISADOR NUMBER(11) NOT NULL,
    LABORATORIO NUMBER(10) NOT NULL,
    AREA_CONHECIMENTO VARCHAR(20),
    CONSTRAINT FK_PROJETO_PESQUISA1 FOREIGN KEY (PESQUISADOR)
               REFERENCES PESQUISADOR(CPF)
               ON DELETE SET NULL
);

CREATE TABLE HOSPITAL(
    ID_INSTALACAO NUMBER(10) NOT NULL,
    NOME VARCHAR(20) NOT NULL,
    NROLEITOS NUMBER(6) NOT NULL,
    NROLEITOSOCUPADOS NUMBER(6) NOT NULL,
    CONSTRAINT PK_HOSPITAL PRIMARY KEY(ID_INSTALACAO),
    CONSTRAINT CK_NROLEITOSOCUPADOS CHECK(NROLEITOSOCUPADOS <= NROLEITOS)
    CONSTRAINT FK_HOSPITAL FOREIGN KEY (ID_INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE
);

CREATE TABLE DEFENDE(
    COLONIA NUMBER(12) NOT NULL,
    SOLDADO NUMBER(11) NOT NULL,
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
    EXPLORADOR NUMBER(11) NOT NULL,
    DATA_HORA TIMESTAMP NOT NULL,
    CONSTRAINT PK_EXPLORA PRIMARY KEY(PLANETA, EXPLORADOR),
    CONSTRAINT FK1_EXPLORA FOREIGN KEY (PLANETA)
               REFERENCES PLANETA(NOME_PLANETA)
               ON CASCADE DELETE,
    CONSTRAINT FK2_EXPLORA FOREIGN KEY (EXPLORADOR)
               REFERENCES EXPLORADOR(CPF)
               ON DELETE CASCADE
);

CREATE TABLE PROJETA_INSTALACAO(
    ENGENHEIRO NUMBER(11) NOT NULL,
    INSTALACAO NUMBER(10) NOT NULL,
    CONSTRAINT PK_PROJETA_INSTALACAO PRIMARY KEY(ENGENHEIRO, INSTALACAO); 
    CONSTRAINT FK1_PROJETA_INSTALACAO FOREIGN KEY (ENGENHEIRO)
               REFERENCES ENGENHEIRO(CPF)
               ON DELETE SET NULL,--VERIFICAR ISSO AQUI
    CONSTRAINT FK2_PROJETA_INSTALACAO FOREIGN KEY (INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE SET NULL--VERIFICAR ISSO AQUI
);

CREATE TABLE CONSTROI_INSTALACAO(
    OPERARIO NUMBER(11) NOT NULL,
    INSTALACAO NUMBER(10) NOT NULL,
    CONSTRAINT PK_CONSTROI_INSTALACAO PRIMARY KEY(OPERARIO, INSTALACAO),
    CONSTRAINT FK1_CONSTROI_INSTALACAO FOREIGN KEY (OPERARIO)
               REFERENCES OPERARIO(CPF)
               ON DELETE CASCADE,--VERIFICAR ISSO AQUI
    CONSTRAINT FK2_CONSTROI_INSTALACAO FOREIGN KEY (INSTALACAO)
               REFERENCES INSTALACAO(ID_INSTALACAO)
               ON DELETE CASCADE--VERIFICAR ISSO AQUI
);

CREATE TABLE TRABALHO_SAUDE(
    FUNCIONARIO NUMBER(11) NOT NULL,
    HOSPITAL NUMBER(10) NOT NULL,
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
    COLONIA_SAIDA NUMBER(10) NOT NULL,
    COLONIA_CHEGADA NUMBER(10) NOT NULL,
    DISTANCIA NUMBER(6) NOT NULL,
    LIMITE_VELOCIDADE NUMBER(6),
    CONSTRAINT PK_ROTA PRIMARY KEY(COLONIA_CHEGADA, COLONIA_SAIDA, DISTANCIA);
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
    COLONIA_SAIDA NUMBER(10) NOT NULL,
    COLONIA_CHEGADA NUMBER(10) NOT NULL,
    DISTANCIA NUMBER(6) NOT NULL,
    HORA_CHEGADA TIMESTAMP NOT NULL,
    PRECO_PASSAGEM NUMBER(4) NOT NULL,
    PILOTO NUMBER(11) NOT NULL,
    DURACAO TIME NOT NULL,
    CONSTRAINT PK_VIAGEM PRIMARY KEY(DATA_HORA, NAVE),
    CONSTRAINT CK_VIAGEM CHECK(DATA_HORA < HORA_CHEGADA),
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
    PESSOA NUMBER(11) NOT NULL,
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