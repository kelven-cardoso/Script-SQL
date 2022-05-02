SELECT
  pcprodut.CODPROD,
  Upper(pcprodut.DESCRICAO),
  PCFORNEC.FORNECEDOR,
  PCTABPR.PTABELA,
  pcprodut.DIRFOTOPROD,
  :DIGITE_SEU_NOME,
  replace(:DESCRICAO,'%','')
FROM
  pcprodut,
  PCTABPR,
  PCFORNEC
WHERE
  PCTABPR.CODPROD = pcprodut.CODPROD
  and pcprodut.codfornec = PCFORNEC.codFORNEC
  AND pcprodut.DESCRICAO LIKE :DESCRICAO
  AND pcprodut.CODPROD LIKE :CODIGO_PRODUTO
  and pcfornec.CODFORNEC in (:fornecedor)
  AND PCTABPR.NUMREGIAO = 1
  AND PCTABPR.PTABELA IS NOT NULL

