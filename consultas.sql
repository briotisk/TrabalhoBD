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

SELECT c.id_colonia, c.nome, COUNT(p.cpf) as qtd_pessoas
FROM colonia c JOIN pessoa p ON p.colonia = c.id_colonia
GROUP BY c.id_colonia, c.nome
HAVING COUNT (p.cpf) = ( SELECT MAX(qtds.qtd_pessoas)
	FROM ( SELECT COUNT(p.cpf) as qtd_pessoas
		FROM colonia c JOIN pessoa p ON p.colonia = c.id_colonia
		GROUP BY c.id_colonia, c.nome) qtds);

SELECT p.nome, c.nome, e.CREA, SUM(h.nroleitos) as qtd_leitos_projetados
FROM ((((projeta_instalacao pj JOIN hospital h ON pj.instalacao = h.id_instalacao)
	RIGHT JOIN engenheiro e ON pj.engenheiro = e.cpf)
	JOIN pessoa p ON e.cpf = p.cpf)
	JOIN colonia c ON c.id_colonia = p.colonia
	)
GROUP BY e.cpf, p.nome, c.nome, e. CREA;

SELECT p.nome, p.profissao, c.Nome
FROM pessoa p JOIN colonia c ON p.colonia = c.Id_colonia
WHERE DataNasc in
	(SELECT min(DataNasc)
		FROM pessoa pi JOIN colonia ci ON ci.Id_Colonia = pi.Colonia
		GROUP BY ci.Id_Colonia)
GROUP BY p.nome, p.profissao, c.Nome
ORDER BY c.Nome;
