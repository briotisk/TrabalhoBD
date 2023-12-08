INSERT INTO PLANETA
       VALUES
            ('Terra', 'Solar', 'SIM'),
            ('Júpiter', 'Solar', 'NAO'),
            ('Titã', 'Solanus', 'SIM'),
            ('Cybertron', 'Aguilar', 'NAO'),
            ('Marte', 'Solar', 'SIM');

INSERT INTO LUA
       VALUES
            ('Terra', 'Lua'),
            ('Júpiter', 'Eoropa'),
            ('Júpiter', 'Calisto'),
            ('Júpiter', 'Io'),
            ('Júpiter', 'Ganimedes'),
            ('Marte', 'Fobos'),
            ('Marte', 'Deimos');

INSERT INTO NAVE
       VALUES
            ('HSL9D9S2', 381, 15000525, 120000),
            ('LDV37C3F', 1032, 200500, 50000);

INSERT INTO COLONIA
       VALUES
            (123456789100,'Terra',123,123,'Nova Catanduva',1500),
            (123456789101,'Terra',124,125,'Brasilio',2300),
            (123456789102,'Marte',100,100,'Natalina',2321),
	    (123456789103,'Titã',500,500,'Ararino',3500),	
	    (123456789104,'Marte',700,700,'Campo Longo',4000),
	    (123456789105,'Titã',800,800,'São Marcos',4500);

INSERT INTO INSTALACAO
       VALUES
            (123456789, 123456789100, 'Benjamin', 492, 'HOSPITAL', 152, 10000000, 1000, 1200),
            (112255924, 123456789101, 'SantosB', 2, 'LABORATORIO', 24, 400000, 200, 250),
            (861820375, 123456789102, 'Caioba', 101, 'BASE MILITAR', 200, 35000000, 1200, 2000),
            (889347311, 123456789103, 'ETBilu', 530, 'LABORATORIO', 30, 550000, 220, 240),
            (343872300, 123456789104, 'Palmeiras', 12, 'BASE MILITAR', 158, 40000000, 1500, 2100),
            (412986490, 123456789105, 'Treze', 198, 'HOSPITAL', 204, 15000000, 980, 1100);

INSERT INTO PESSOA
       VALUES
            (12345678900,'Gabriel','Nova Catanduva',TO_DATE('04/02/2003, DD/MM/YYYY'),'Militar'),
            (12345678901,'Caio','Brasilio',TO_DATE('10/07/2002, DD/MM/YYYY'),'Militar'),
            (12345678902,'Arthur','Natalino',TO_DATE('15/08/1985,DD/MM/YYYY'),'Operario'),
            (12345678903,'Daniela','Aranino',TO_DATE('04/07/2000, DD/MM/YYYY'),'Profissional da Saude'),
            (12345678904,'Melissa','São Marcos',TO_DATE('19/02/2003,DD/MM/YYYY'),'Engenheiro'),
            (12345678905,'Bruna','São Marcos',TO_DATE('17/09/2003,DD/MM/YYYY'),'Profissional da Saude'),
            (12345678906,'Felipe','Campo Longo',TO_DATE('31/01/2001,DD/MM/YYYY'),'Militar'),
            (12345678907,'Daniel','São Marcos',TO_DATE('11/11/2002, DD/MM/YYYY'),'Engenheiro'),
            (12345678908,'Guilherme','Ararino',TO_DATE('23/01/2001,DD/MM/YYYY'),'Pesquisador'),
            (12345678909,'Aquiles','Nova Catanduva',TO_DATE('11/09/1994,DD/MM/YYYY'),'Operario')
	    (12345678910,'Fausto Silva','Ararino',TO_DATE('08/03/1990,DD/MM/YYYY'),'Militar')
	    (12345678911,'Leila Pereira','Campo Longo',TO_DATE('01/01/2001,DD/MM/YYYY'),'Militar')
	    (12345678912,'Edson Arantes','Natalino',TO_DATE('12/10/1994,DD/MM/YYYY'),'Militar')
	    (12345678913,'Marcos Leonardo','Natalino',TO_DATE('01/02/2003,DD/MM/YYYY'),'Pesquisador')
	    (12345678914,'Joaquim','Ararino',TO_DATE('10/04/1999,DD/MM/YYYY'),null)
	    (12345678915,'Mancho Verdo','Nova Catanduva',TO_DATE('02/02/1992,DD/MM/YYYY'),null);

INSERT INTO ENGENHEIRO
       VALUES
            (),
            ();

INSERT INTO OPERARIO
       VALUES
            (),
            ();

INSERT INTO PROFISSIONAL_SAUDE
       VALUES
            (),
            ();

INSERT INTO PESQUISADOR
       VALUES
            (),
            ();

INSERT INTO BASE_MILITAR
       VALUES
            (861820375),
            (343872300);

INSERT INTO MILITAR
       VALUES
            (),
            ();

INSERT INTO PILOTO
       VALUES
            (),
            ();

INSERT INTO EXPLORADOR
       VALUES
            (),
            ();

INSERT INTO SOLDADO
       VALUES
            (),
            ();

INSERT INTO LABORATORIO
       VALUES
            (112255924),
            (889347311);

INSERT INTO PROJETO_PESQUISA
       VALUES
            (),
            ();

INSERT INTO HOSPITAL
       VALUES
            (123456789, 'Albert Einstein', 300, 101),
            (412986490, 'Unimed', 500, 232);

INSERT INTO DEFENDE
       VALUES
            (),
            ();

INSERT INTO EXPLORA
       VALUES
            (),
            ();

INSERT INTO PROJETA_INSTALACAO
       VALUES
            (),
            ();

INSERT INTO CONSTROI_INSTALACAO
       VALUES
            (),
            ();

INSERT INTO TRABALHO_SAUDE
       VALUES
            (),
            ();

INSERT INTO ROTA
       VALUES
            (),
            ();

INSERT INTO VIAGEM
       VALUES
            (),
            ();

INSERT INTO VIAJAM
       VALUES
            (),
            ();
