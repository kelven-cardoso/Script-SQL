select 
a.codprod, a.descricao as produto,  d.descricao as departamento, s.descricao as secao,  c.categoria,
a.embalagem, a.unidade, a.pesoliq, a.pesobruto,
a.codcategoria, a.codsec,
b.modulo, b.rua, b.apto, b.numero,
c.codcategoria,
s.codepto,
d.codepto
from
pcprodut a,
pcest b,
pccategoria c,
pcsecao s,
pcdepto d
where
a.codprod = b.codprod and
a.codcategoria = c.codcategoria and
a.codsec = c.codsec and
c.codsec = s.codsec and
s.codepto = d.codepto and
b.codfilial = 1 and
a.dtexclusao is null;
order by d.codepto, s.codsec, c.codcategoria
