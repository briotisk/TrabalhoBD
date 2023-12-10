-- Seleciona as colônias que possuem mais de 1 profissional da saúde
select c.id_colonia, count (*)
from (colonia c join pessoa p on c.id_Colonia = p.colonia) where (Upper(profissao) = 'PROFISSIONAL DA SAUDE') 
group by (c.id_Colonia)
having count(*) > 1
order by c.id_Colonia;


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
