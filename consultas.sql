-- Seleciona as colônias que possuem mais de 1 profissional da saúde
SELECT c.id_colonia, COUNT(*)
FROM (colonia c JOIN pessoa p ON c.id_Colonia = p.colonia) WHERE (Upper(profissao) = 'PROFISSIONAL DA SAUDE') 
GROUP BY (c.id_Colonia)
    HAVING COUNT(*) > 1
ORDER BY c.id_Colonia;

SELECT nome, cpf FROM pessoal WHERE 
    NOT EXISTS (
            SELECT data_hora, nave FROM viagem
                WHERE piloto = (SELECT pi.cpf FROM piloto pi
                                JOIN pessoa pe ON pi.cpf = pe.cpf
                                WHERE(UPPER(pe.nome) = 'GABRIEL')))
            EXCEPT
            (SELECT data_hora, nave FROM viajam v WHERE v.pessoa = cpf

SELECT col.id_colonia, col.nome, col.nrohabitantes/COUNT(ps.cpf) as ProfissionaisDaSaudePorHabitante
FROM (profissional_saude ps JOIN pessoa p ON ps.cpf = p.cpf)
    JOIN colonia col on p.colonia = col.id_colonia
GROUP BY col.id_colonia
    HAVING col.nrohabitantes/COUNT(p.cpf) =
   	 (SELECT MAX(ProfissionaisDaSaudePorHabitante) FROM
   		 (SELECT col.nrohabitantes/COUNT(p.cpf) as ProfissionaisDaSaudePorHabitante
   			FROM (profissional_saude ps JOIN pessoa p ON ps.cpf = p.cpf)
   				JOIN colonia col ON p.colonia = col.id_colonia
   		 GROUP BY col.id_colonia) as taxa);
