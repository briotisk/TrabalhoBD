-- Seleciona as colônias que possuem mais de 1 profissional da saúde
select c.id_colonia, count (*)
from (colonia c join pessoa p on c.id_Colonia = p.colonia) where (Upper(profissao) = 'PROFISSIONAL DA SAUDE') 
group by (c.id_Colonia)
having count(*) > 1
order by c.id_Colonia;