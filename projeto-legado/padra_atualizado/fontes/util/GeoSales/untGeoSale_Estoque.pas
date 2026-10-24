unit untGeoSale_Estoque;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Estoque = Class(TGeoSale_Base)
  Private
    FDesEst: String;
    FAtivo: String;
    FCodEst: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('CODEST')]
    Property CD_ESTOQUE : Integer Read FCodEst Write FCodEst;

    [TCampoString]
    [TNomeCampo('DESEST')]
    Property DS_ESTOQUE : String  Read FDesEst Write FDesEst;

    [TCampoString]
    [TNomeCampo('ATIVO')]
    Property ID_ATIVO   : String  Read FAtivo  Write FAtivo;
  End;

implementation

{ TGeoSale_Estoque }

uses untFuncoesSimples;

function TGeoSale_Estoque.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Estoque.TXT';
end;

function TGeoSale_Estoque.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP AS CODEST,   ';
  Result := Result + '        EMP_NOMEMP AS DESEST,   ';
  Result := Result + '        "S" AS ATIVO            ';
  Result := Result + ' FROM CADEMP                    ';
  Result := Result + ' WHERE LOCATE(EMP_CODEMP,"'+ FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Estoque.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
