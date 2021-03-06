SELECT * FROM (
SELECT P.CODPROD AS CODIGO,
       P.DESCRICAO AS DESCRIÇÃO,
       P.CODFORNEC AS "COD. FORNECEDOR",
       F.FORNECEDOR AS FORNECEDOR,
       P.DTVENC AS VALIDADE,
       E.QTESTGER,
       E.QTESTGER - E.QTBLOQUEADA QTDISPONIVEL,
       E.QTBLOQUEADA,
       e.codfilial,
       P.MODULO,
       P.RUA,
       TRUNC(P.NUMERO) NUMERO,
       P.APTO,
       P.MODULO || ' - ' || P.RUA || ' - ' || TRUNC(P.NUMERO) || ' - ' ||
       P.APTO ENDERECO,
       --MOSTRA SE O PRODUTO TA COM PRECO FIXO ATIVO
       CASE
         WHEN P.CODPROD IN
              (SELECT DISTINCT CODPROD
                 FROM PCPRECOPROM
                WHERE PCPRECOPROM.DTINICIOVIGENCIA <= TRUNC(SYSDATE)
                  AND PCPRECOPROM.DTFIMVIGENCIA >= TRUNC(SYSDATE))
         THEN
          'A'
         ELSE
          'I'
       END AS PF,
       CASE
         WHEN P.CODPROD IN
              (SELECT DISTINCT CODPROD
                 FROM PCPRECOPROM
                WHERE PCPRECOPROM.DTINICIOVIGENCIA <= TRUNC(SYSDATE)
                  AND PCPRECOPROM.DTFIMVIGENCIA >= TRUNC(SYSDATE))
         THEN
          'X'
         ELSE
          ''
       END AS MARCACAO,
       :POLITICA RESPOSTA
       --FIM = MOSTRA SE O PRODUTO TA COM PRECO FIXO ATIVO
  FROM PCPRODUT P, PCFORNEC F, PCEST E
 WHERE 1 + 1 = 2
   AND P.CODPROD = E.CODPROD
   AND P.CODFORNEC = F.CODFORNEC
   AND P.DTVENC IS NOT NULL
   --AND P.DTVENC BETWEEN :DATAINI AND :DATAFIM
   AND E.QTESTGER - E.QTBLOQUEADA > '0'
   --and P.CODPROD IN (:CODPROD)
   --AND P.CODFORNEC IN (:CODFORNEC)
   and e.codfilial = :filial
 ORDER BY VALIDADE, P.MODULO, P.RUA, P.NUMERO, P.APTO
 ) WHERE PF = RESPOSTA OR RESPOSTA = 'T';