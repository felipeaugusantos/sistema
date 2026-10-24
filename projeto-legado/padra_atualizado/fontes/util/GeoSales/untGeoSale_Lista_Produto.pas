unit untGeoSale_Lista_Produto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Lista_Produto = Class(TGeoSale_Base)
  Private
    FCodEmp: String;
    FCodIte: String;
    FSequen: String;
    FTabPre: Integer;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('CODEMP')]
    Property CD_ORG_VENDA : String  Read FCodEmp Write FCodEmp;

    [TCampoInteger]
    [TNomeCampo('TABPRE')]
    Property CD_TAB_PRECO : Integer Read FTabPre Write FTabPre;

    [TCampoString]
    [TNomeCampo('ITE_CODITE')]
    Property CD_PRODUTO   : String Read FCodIte Write FCodIte;

    [TCampoString]
    [TNomeCampo('SEQUEN')]
    Property CD_SEQUENCIAL: String Read FSequen Write FSequen;

  End;

implementation

{ TGeoSale_Lista_Produto }

uses untFuncoesSimples;

function TGeoSale_Lista_Produto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Lista_Produto.TXT';
end;

function TGeoSale_Lista_Produto.fGetSql: String;
  Var
    intIndex : Integer;
    strTabPrc: String;
begin
  strTabPrc := fCfgSis('TABPRC', varString);

  Result := '';
  For intIndex := 1 to Length(strTabPrc) Do
  Begin
    If ( strTabPrc[intIndex] = 'S' ) Then
    Begin
      If not fEmptyStr(Result) Then
        Result := Result + ' UNION ALL ';

      Result := Result + ' SELECT G.ITE_CODEMP AS CODEMP,                               ';
      Result := Result + intToStr(intIndex) + ' AS TABPRE,                              ';
      Result := Result + '        G.ITE_CODITE,                                         ';
      Result := Result + 'CONCAT(' + intToStr(intIndex) + ', G.ITE_CODITE, G.ITE_CODEMP) AS SEQUEN ';
      Result := Result + ' FROM ITEGER G                                                ';
      Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE           ';
      Result := Result + ' WHERE LOCATE(G.ITE_CODEMP," '+ FEmpresas + '") > 0           ';
      Result := Result + '   AND C.ITE_ITEATI = "S"                                     ';

    End;
  End;
end;

procedure TGeoSale_Lista_Produto.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
