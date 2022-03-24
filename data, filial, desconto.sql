SELECT
  p.CODPROD,
  produt.DESCRICAO AS PRODUTO,
  promo.CODFILIAL,
  promo.PRECOFIXO AS PRECO_COM_DESCONTO,
  p.PVENDA AS PRECO_SEM_DESCONTO,
  ROUND(((promo.PRECOFIXO - p.PVENDA) / p.PVENDA) * -100, 2) AS DESCONTO_PORCENTO,
  TRUNC(EST.QTESTGER - EST.QTBLOQUEADA) AS ESTOQUE,
  promo.DTINICIOVIGENCIA,
  promo.DTFIMVIGENCIA
FROM
  PCEST EST,
  PCTABPR p,
  PCPRECOPROM promo,
  PCPRODUT produt
WHERE
  p.CODPROD = promo.CODPROD
  AND p.CODPROD = produt.CODPROD
  AND p.CODPROD = EST.CODPROD
  AND promo.NUMREGIAO = p.NUMREGIAO
  AND promo.CODFILIAL = 1
  AND EST.CODFILIAL = :FILIAL
  AND promo.NUMREGIAO = :REGIAO
  AND promo.DTINICIOVIGENCIA >= :DATA_INICIO_PROMOCAO
  AND promo.DTFIMVIGENCIA <= :DATA_FIM_PROMOCAO

