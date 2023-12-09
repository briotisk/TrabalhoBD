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
            (12345678909,'Aquiles','Nova Catanduva',TO_DATE('11/09/1994,DD/MM/YYYY'),'Operario'),
	    (12345678910,'Fausto Silva','Ararino',TO_DATE('08/03/1990,DD/MM/YYYY'),'Militar'),
	    (12345678911,'Leila Pereira','Campo Longo',TO_DATE('01/01/2001,DD/MM/YYYY'),'Militar'),
	    (12345678912,'Edson Arantes','Natalino',TO_DATE('12/10/1994,DD/MM/YYYY'),'Militar'),
	    (12345678913,'Marcos Leonardo','Natalino',TO_DATE('01/02/2003,DD/MM/YYYY'),'Pesquisador'),
	    (12345678914,'Joaquim','Ararino',TO_DATE('10/04/1999,DD/MM/YYYY'),null),
	    (12345678915,'Mancho Verdo','Nova Catanduva',TO_DATE('02/02/1992,DD/MM/YYYY'),null);

INSERT INTO ENGENHEIRO
       VALUES
            (12345678907,1234567890),
            (12345678904,1234567891);

INSERT INTO OPERARIO
       VALUES
            (12345678909,23456789012),
            (12345678905,23456789013);

INSERT INTO PROFISSIONAL_SAUDE
       VALUES
            (12345678903, 813401),
            (12345678905, 198245);

INSERT INTO PESQUISADOR
       VALUES
            (12345678908, 1289516259),
            (12345678913, 8023457092);

INSERT INTO BASE_MILITAR
       VALUES
            (861820375),
            (343872300);

INSERT INTO MILITAR
       VALUES
            (12345678900, 'Tenente', 'Piloto', TIME(('06:00:00, HH:MM:SS')), TIME(('18:00:00, HH:MM:SS')), 343872300),
            (12345678901, 'Cabo', 'Soldado', TIME(('10:00:00, HH:MM:SS')), TIME(('22:00:00, HH:MM:SS')), 861820375),
            (12345678906, 'Sargento', 'Explorador', TIME(('12:00:00, HH:MM:SS')), TIME(('00:00:00, HH:MM:SS')), 343872300),
            (12345678910, 'Major', 'Soldado', TIME(('22:00:00, HH:MM:SS')), TIME(('10:00:00, HH:MM:SS')), 343872300),
            (12345678911, 'General', 'Piloto', TIME(('18:00:00, HH:MM:SS')), TIME(('06:00:00, HH:MM:SS')), 861820375),
            (12345678912, 'Coronel', 'Explorador', TIME(('00:00:00, HH:MM:SS')), TIME(('12:00:00, HH:MM:SS')), 861820375);

INSERT INTO PILOTO
       VALUES
            (12345678900,1234567890),
            (12345678911,1234567891);

INSERT INTO EXPLORADOR
       VALUES
            (12345678906),
            (12345678912);

INSERT INTO SOLDADO
       VALUES
            (12345678901),
            (12345678910);

INSERT INTO LABORATORIO
       VALUES
            (112255924),
            (889347311);

INSERT INTO PROJETO_PESQUISA
       VALUES
            (123456, 12345678908, 889347311, 'Tecnologia'),
            (654321, 12345678913, 112255924, 'Químico');

INSERT INTO HOSPITAL
       VALUES
            (123456789, 'Albert Einstein', 300, 101),
            (412986490, 'Unimed', 500, 232);

INSERT INTO DEFENDE
       VALUES
            (123456789101, 12345678901),
            (123456789103, 12345678910);

INSERT INTO EXPLORA
       VALUES
            (12345678906,'Marte', TIMESTAMP('21/06/2023 12:30:00, DD/MM/YYYY HH/MM/SS')),
            (12345678912,'Titã', TIMESTAMP('10/08/2023 17:00:00, DD/MM/YYYY HH/MM/SS'));

INSERT INTO PROJETA_INSTALACAO
       VALUES
            (12345678907,889347311),
            (12345678904,112255924);

INSERT INTO CONSTROI_INSTALACAO
       VALUES
            (12345678902,343872300),
            (12345678909,861820375);

INSERT INTO TRABALHO_SAUDE
       VALUES
            (12345678903,123456789,hora,hora),
            (12345678905,412986490,hora,hora);

INSERT INTO ROTA
       VALUES
            ('Ararino','Nova Catanduva',220000,1200),
            ('Nova Catanduva','Brasilio',270,70),
	    ('Natalina','Campo Longo',330,80),
	    ('Ararino','São Marcos',400,100),
	    ('Campo Longo','São Marcos',150000,1000),
            ('Brasilio','Campo Longo',45000,1000),
            ('São Marcos','Brasilio',218000,1200),
	    ('Campo Longo','Nova Catanduva',50000,1000);

INSERT INTO VIAGEM
       VALUES
            (),
            ();

INSERT INTO VIAJAM
       VALUES
            (),
            ();
