unit untGeoSale_Familia_Produto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Familia_Produto = Class(TGeoSale_Base)
  Private
    FDesGru: String;
    FCodPai: Integer;
    FCodGru: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('GRU_CODGRU')]
    Property CD_FAMILIA     : Integer Read FCodGru Write FCodGru;

    [TCampoString]
    [TNomeCampo('GRU_DESGRU')]
    Property NM_FAMILIA     : String  Read FDesGru Write FDesGru;

    [TCampoInteger]
    [TNomeCampo('CODPAI')]
    Property CD_FAMILIA_PAI : Integer Read FCodPai Write FCodPai;

  End;

implementation

{ TGeoSale_Familia_Produto }

uses untFuncoesSimples;

function TGeoSale_Familia_Produto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Familia_Produto.TXT';
end;

function TGeoSale_Familia_Produto.fGetSql: String;
begin
  Result := '';
  Result := Result + 'SELECT GRU_CODGRU, ';
  Result := Result + '       GRU_DESGRU, ';
  Result := Result + '       IF(RIGHT(GRU_CODGRU,3) <> "000", CONCAT(LEFT(GRU_CODGRU,3), "000") ,NULL) AS CODPAI ';
  Result := Result + 'FROM CADGRU        ';
  Result := Result + 'ORDER BY CODPAI    ';
end;

procedure TGeoSale_Familia_Produto.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
