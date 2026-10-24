unit untGeoSale_Sequencial;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Sequencial = Class(TGeoSale_Base)
  Private
    FSequencial: String;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('ID')]
    Property CD_SEQUENCIAL : String Read FSequencial Write FSequencial;
  End;

implementation

{ TGeoSale_Sequencial }

uses untFuncoesSimples;

function TGeoSale_Sequencial.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Sequencial.TXT';
end;

function TGeoSale_Sequencial.fGetSql: String;
  Var
    intIndex : Integer;
begin
  Result := '';

  For intIndex := 1 To 7 Do
  Begin
    Result := Result + ' SELECT  CONCAT(' + intToStr(intIndex) + ', ITE_CODITE, ITE_CODEMP) AS ID  ';
    Result := Result + ' FROM CFGSIS                                                      ';
    Result := Result + ' INNER JOIN ITEGER ON ITE_CODEMP = SIS_CODEMP                     ';
    Result := Result + ' WHERE SIS_CODCFG = "CFG_TABPRC"                                  ';
    Result := Result + '   AND LOCATE(SIS_CODEMP,"' + FEmpresas + '") > 0                 ';
    Result := Result + '   AND MID(SIS_VALCFG, ' + intToStr(intIndex) + ', 1) = "S"       ';

    if intIndex < 7 Then
      Result := Result + ' UNION ALL ';
  End;

end;

procedure TGeoSale_Sequencial.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
