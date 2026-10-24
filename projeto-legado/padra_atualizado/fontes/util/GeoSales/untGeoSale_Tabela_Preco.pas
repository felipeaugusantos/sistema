unit untGeoSale_Tabela_Preco;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Tabela_Preco = Class(TGeoSale_Base)
  Private
    FNomTab: String;
    FCodTab: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('TAB_CODTAB')]
    Property CD_TAB_PRECO : Integer Read FCodTab Write FCodTab;

    [TCampoString]
    [TNomeCampo('TAB_NOMTAB')]
    Property DS_TAB_PRECO : String  Read FNomTab Write FNomTab;
  End;

implementation

{ TGeoSale_Tabela_Preco }

uses untFuncoesSimples;

function TGeoSale_Tabela_Preco.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Tabela_Preco.TXT';
end;

function TGeoSale_Tabela_Preco.fGetSql: String;
  Var
    intIndex : Integer;
begin
  Result := '';

  For intIndex := 1 To 7 Do
  Begin
    Result := Result + ' SELECT  ' + intToStr(intIndex) + '  AS TAB_CODTAB,         ';
    Result := Result + ' "TABELA ' + intToStr(intIndex) + '" AS TAB_NOMTAB          ';
    Result := Result + ' FROM CFGSIS                                                ';
    Result := Result + ' WHERE SIS_CODCFG = "CFG_TABPRC"                            ';
    Result := Result + '   AND SIS_CODEMP = :CODEMP                                 ';
    Result := Result + '   AND MID(SIS_VALCFG, ' + intToStr(intIndex) + ', 1) = "S" ';

    if intIndex < 7 Then
      Result := Result + ' UNION ALL ';
  End;

end;

procedure TGeoSale_Tabela_Preco.pSetParams(DataSet: TUniQuery);
begin
  DataSet.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

end.
