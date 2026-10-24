unit Garantia.TSQLMovimentacaoPosterior;

interface

uses
  Classes,
  SysUtils;


  type
    TSQLMovimentacaoPosterior = class
    private
      FSigla: String;
      FCodigoEmpresaLogada: String;
      FCodigoEmpresaGarantia: String;
      FUtilizaGarantiaPelaMatriz: Boolean;

    public
      property strSigla : String read FSigla write FSigla;
      property strCodigoEmpresaLogada : String read FCodigoEmpresaLogada write FCodigoEmpresaLogada;
      property strCodigoEmpresaGarantia : String read FCodigoEmpresaGarantia write FCodigoEmpresaGarantia;
      property blnUtilizaGarantiaPelaMatriz : Boolean read FUtilizaGarantiaPelaMatriz write FUtilizaGarantiaPelaMatriz;


      function fRetornaSQL: String;
      function fRetornaSQLFiltroRecebimentoCliente: String;
      function fRetornaSQLFiltroEmpresaEnvioFornecedor: String;

      constructor Create;
  end;


implementation

uses
  Garantia.Constantes;

{ TSQLMovimentacaoPosterior }

constructor TSQLMovimentacaoPosterior.Create;
begin
  FSigla := '';
  FCodigoEmpresaLogada:= '';
  FCodigoEmpresaGarantia:= '';
  FUtilizaGarantiaPelaMatriz:= False;
end;


function TSQLMovimentacaoPosterior.fRetornaSQL: String;
var
  sql : TStringList;
Begin
  sql := TStringList.Create;
  try
    If TSiglasGarantia.RECEBIMENTO_CLIENTE.Contains(strSigla) Then
    begin

      sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
      sql.Add('SELECT DISTINCT'                                       );
      sql.Add('  GAE_EMPENV AS CODEMP,'                               );
      sql.Add('  GAE_ESPENV AS ESPDOC,'                               );
      sql.Add('  GAE_NUMENV AS NUMDOC'                                );
      sql.Add('FROM MOVDET'                                           );
      sql.Add('  INNER JOIN MOVGRC ON GRC_SEQDET = MOVDET.AUTOINCREM' );
      sql.Add('  INNER JOIN MOVGAD D ON D.AUTOINCREM = GRC_SEQGAD'    );
      sql.Add('  INNER JOIN MOVGAE A ON A.GAE_SEQGAD = D.AUTOINCREM'  );
      sql.Add('WHERE DET_NUMDOC = :NUMDOC'                            );
      sql.Add('  AND DET_CODEMP = :CODEMP'                            );
      sql.Add('  AND DET_CODCLI = :CLIFOR'                            );
      sql.Add('  ' + fRetornaSQLFiltroRecebimentoCliente              );

    end

    Else If TSiglasGarantia.ENVIO_FORNECEDOR.Contains(strSigla) Then
    Begin

      sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
      sql.Add('SELECT DISTINCT'                                       );
      sql.Add('  E.DET_CODEMP AS CODEMP,'                             );
      sql.Add('  E.DET_ESPDOC AS ESPDOC,'                             );
      sql.Add('  E.DET_NUMDOC AS NUMDOC'                              );
      sql.Add('FROM'                                                  );
      sql.Add('  MOVGAD D'                                            );
      sql.Add('  INNER JOIN MOVGAE A ON A.GAE_SEQGAD = D.AUTOINCREM'  );
      sql.Add('  INNER JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG'  );
      sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQGAD'  );
      sql.Add('  INNER JOIN MOVDET E ON E.AUTOINCREM = U.GAU_SEQDET'  );
      sql.Add('WHERE GAE_NUMENV = :NUMDOC'                            );
      sql.Add('  AND GAE_ESPENV IN ("NF","GF")'                       );
      sql.Add('  AND D.GAD_CODFOR = :CLIFOR'                          );
      sql.Add('  AND IFNULL(E.DET_NUMDOC,"") <> ""'                   );
      sql.Add('  ' + fRetornaSQLFiltroEmpresaEnvioFornecedor          );

    End

    Else If TSiglasGarantia.RETORNO_FORNECEDOR.Contains(strSigla) Then
    Begin

      // BAIXA DO REFUGO, SE TIVER NAO PODE CANCELAR O RETORNO DO FORNCEDOR.
      sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
      sql.Add('SELECT DISTINCT'                                       );
      sql.Add('  A.GER_CODEMP AS CODEMP,'                             );
      sql.Add('  A.GER_ESPDOC AS ESPDOC,'                             );
      sql.Add('  A.GER_NUMDOC AS NUMDOC'                              );
      sql.Add('FROM'                                                  );
      sql.Add('  MOVGER G'                                            );
      sql.Add('  INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER'  );
      sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQDET'  );
      sql.Add('  INNER JOIN MOVGER A ON A.AUTOINCREM = U.GAU_AIBXRF'  );
      sql.Add('WHERE D.DET_ESPDOC = "GR"'                             );
      sql.Add('  AND D.DET_NUMDOC = :NUMDOC'                          );
      sql.Add('  AND D.DET_CODEMP = :CODEMP'                          );
      sql.Add('  AND D.DET_CODFOR = :CLIFOR'                          );

      sql.Add('UNION ALL'                                             );

      sql.Add('SELECT DISTINCT'                                       );
      sql.Add('  A.GER_CODEMP AS CODEMP,'                             );
      sql.Add('  A.GER_ESPDOC AS ESPDOC,'                             );
      sql.Add('  A.GER_NUMDOC AS NUMDOC'                              );
      sql.Add('FROM'                                                  );
      sql.Add('  MOVGER G'                                            );
      sql.Add('  INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER'  );
      sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQDET'  );
      sql.Add('  INNER JOIN MOVGER A ON A.AUTOINCREM = U.GAU_AIBXRF'  );
      sql.Add('WHERE D.DET_ESPDOC = "NF"'                             );
      sql.Add('  AND D.DET_NUMDOC = :NUMDOC'                          );
      sql.Add('  AND D.DET_CODEMP = :CODEMP'                          );
      sql.Add('  AND D.DET_CODFOR = :CLIFOR'                          );

    End;

    Result := sql.Text;

  finally
    FreeAndNil(sql);
  end;
End;

function TSQLMovimentacaoPosterior.fRetornaSQLFiltroRecebimentoCliente: String;
begin

  if strSigla = 'GA' then
    Result := 'AND DET_ESPDOC = "GA"'
  else
    Result := 'AND DET_ESPDOC = "NF"';

end;

function TSQLMovimentacaoPosterior.fRetornaSQLFiltroEmpresaEnvioFornecedor: String;
begin
  Result := '';

  {If ((blnUtilizaGarantiaPelaMatriz) and (strCodigoEmpresaLogada <> strCodigoEmpresaGarantia)) Or
     (Not blnUtilizaGarantiaPelaMatriz) then}
    Result := '  AND GAE_EMPENV = :CODEMP';

end;


end.
