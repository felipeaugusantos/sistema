unit untGeoSale_Vendedor;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Vendedor = Class(TGeoSale_Base)
  Private
    FBlock: String;
    FNomOpe: String;
    FCodOpe: String;
    function GetCodOpe: String;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('OPE_CODOPE')]
    Property CD_VENDEDOR       : String Read GetCodOpe Write FCodOpe;

    [TCampoString]
    [TNomeCampo('OPE_NOMOPE')]
    Property NM_VENDEDOR       : String  Read FNomOpe Write FNomOpe;

    [TCampoString]
    [TNomeCampo('IDBLOCK')]
    property ID_BLOQUEIO_FAIXA : String  Read FBlock  Write FBlock;

  End;

implementation

{ TGeoSale_Vendedor }

uses untFuncoesSimples;

function TGeoSale_Vendedor.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Vendedor.TXT';
end;

function TGeoSale_Vendedor.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE   ';
  Result := Result + '        OPE_CODOPE,    ';
  Result := Result + '        OPE_NOMOPE,    ';
  Result := Result + '        "" AS IDBLOCK  ';
  Result := Result + ' FROM CADOPE           ';
  Result := Result + ' WHERE OPE_CODOPE <> "AUT"';
end;

function TGeoSale_Vendedor.GetCodOpe: String;
begin
  Result := fRetSomenteNumeros(FCodOpe);
end;

procedure TGeoSale_Vendedor.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
