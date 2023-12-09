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
            (123456789100,'Terra',-30,80,'Nova Catanduva',1500),
            (123456789101,'Terra',50,170,'Brasilio',2300),
            (123456789102,'Marte',10,120,'Natalina',2321),
	    (123456789103,'Titã',-70,110,'Ararino',3500),	
	    (123456789104,'Marte',-20,-170,'Campo Longo',4000),
	    (123456789105,'Titã',60,-35,'São Marcos',4500);

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
            (12345678900,'Gabriel',123456789100,TO_DATE('04/02/2003', 'DD/MM/YYYY'),'Militar'),
            (12345678901,'Caio',123456789101,TO_DATE('10/07/2002', 'DD/MM/YYYY'),'Militar'),
            (12345678902,'Arthur',123456789102,TO_DATE('15/08/1985','DD/MM/YYYY'),'Operario'),
            (12345678903,'Daniela',123456789103,TO_DATE('04/07/2000', 'DD/MM/YYYY'),'Profissional da Saude'),
            (12345678904,'Melissa',123456789105,TO_DATE('19/02/2003','DD/MM/YYYY'),'Engenheiro'),
            (12345678905,'Bruna',123456789105,TO_DATE('17/09/2003','DD/MM/YYYY'),'Profissional da Saude'),
            (12345678906,'Felipe',123456789104,TO_DATE('31/01/2001','DD/MM/YYYY'),'Militar'),
            (12345678907,'Daniel',123456789105,TO_DATE('11/11/2002', 'DD/MM/YYYY'),'Engenheiro'),
            (12345678908,'Guilherme',123456789103,TO_DATE('23/01/2001','DD/MM/YYYY'),'Pesquisador'),
            (12345678909,'Aquiles',123456789100,TO_DATE('11/09/1994','DD/MM/YYYY'),'Operario'),
	    (12345678910,'Fausto Silva',123456789103,TO_DATE('08/03/1990','DD/MM/YYYY'),'Militar'),
	    (12345678911,'Leila Pereira',123456789104,TO_DATE('01/01/2001','DD/MM/YYYY'),'Militar'),
	    (12345678912,'Edson Arantes',123456789102,TO_DATE('12/10/1994','DD/MM/YYYY'),'Militar'),
	    (12345678913,'Marcos Leonardo',123456789102,TO_DATE('01/02/2003','DD/MM/YYYY'),'Pesquisador'),
	    (12345678914,'Joaquim',123456789103,TO_DATE('10/04/1999','DD/MM/YYYY'),null),
	    (12345678915,'Mancho Verdo',123456789100,TO_DATE('02/02/1992','DD/MM/YYYY'),null);

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
            (12345678906,'Marte', TIMESTAMP('21/06/2023 12:30:00, DD/MM/YYYY HH:MM:SS')),
            (12345678912,'Titã', TIMESTAMP('10/08/2023 17:00:00, DD/MM/YYYY HH:MM:SS'));

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
            (12345678903,123456789,TIME('10:00:00, HH:MM:SS'),TIME('18:00:00, HH:MM:SS')),
            (12345678905,412986490,TIME('02:00:00, HH:MM:SS'),TIME('10:00:00, HH:MM:SS'));

INSERT INTO ROTA
       VALUES
          ('Ararino','Nova Catanduva',220000,12000),
          ('Nova Catanduva','Brasilio',270,540),
	     ('Natalina','Campo Longo',330,170),
	     ('Ararino','São Marcos',400,200),
	     ('Campo Longo','São Marcos',150000,13000),
          ('Brasilio','Campo Longo',45000,8000),
          ('São Marcos','Brasilio',218000,11000),
	     ('Campo Longo','Nova Catanduva',50000,5000);

INSERT INTO VIAGEM
       VALUES
         (TIMESTAMP('12/02/2023 10:30:00,DD/MM/YYYY HH:MM:SS'),'HSL9D9S2',123456789103,123456789105,400,TIME('12:30:00,HH:MM:SS'),200,12345678900,TIME('02:00:00, HH:MM:SS')),
	    (TIMESTAMP('20/08/2023 5:00:00,DD/MM/YYYY HH:MM:SS'),'HSL9D9S2',123456789103,123456789100,220000,TIME('00:00:00,HH:MM:SS'),1400,12345678900,TIME('19:00:00, HH:MM:SS')),
         (TIMESTAMP('12/10/2022 15:30:00,DD/MM/YYYY HH:MM:SS'),'HSL9D9S2',123456789100,123456789101,270,TIME('16:00:00,HH:MM:SS'),230,12345678900,TIME('00:30:00, HH:MM:SS')),
	    (TIMESTAMP('30/03/2020 21:30:00,DD/MM/YYYY HH:MM:SS'),'HSL9D9S2',123456789102,123456789104,330,TIME('22:20:00,HH:MM:SS'),260,12345678900,TIME('00:50:00, HH:MM:SS')),
	    (TIMESTAMP('2O/02/2023 5:30:00,DD/MM/YYYY HH:MM:SS'),'LDV37C3F',123456789104,123456789105,150000,TIME('15:00:00,HH:MM:SS'),1000,12345678911,TIME(11':30:00, HHH:MM:SS')),
         (TIMESTAMP('31/01/2022 20:00:00,DD/MM/YYYY HH:MM:SS'),'LDV37C3F',123456789101,123456789104,45000,TIME('02:00:00,HH:MM:SS'),500,12345678911,TIME('6:00:00, HH:MM:SS')),
         (TIMESTAMP('04/02/2023 18:00:00,DD/MM/YYYY HH:MM:SS'),'LDV37C3F',123456789105,123456789101,218000,TIME('14:30:00,HH:MM:SS'),1375,12345678911,TIME('20:00:00, HHH:MM:SS')),
	    (TIMESTAMP('21/07/2022 11:00:00,DD/MM/YYYY HH:MM:SS'),'LDV37C3F', 123456789104,123456789100,50000,TIME('21:30:00,HH:MM:SS'),510,12345678911,TIME('10:30:00, HH:MM:SS'));	
	

INSERT INTO VIAJAM
       VALUES
            (12345678900, TIMESTAMP('10/01/2023 09:30:00, DD/MM/YYYY HH:MM:SS'), 'HSL9D9S2'),
            (12345678911, TIMESTAMP('27/09/2023 19:00:00, DD/MM/YYYY HH:MM:SS'), 'LDV37C3F');
