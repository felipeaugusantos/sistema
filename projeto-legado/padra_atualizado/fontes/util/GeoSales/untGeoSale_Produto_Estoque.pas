unit untGeoSale_Produto_Estoque;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Produto_Estoque = Class(TGeoSale_Base)
  Private
    FCodIte: Integer;
    FCodEst: Integer;
    FSaldos: Double;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('ITE_CODITE')]
    property CD_PRODUTO : Integer Read FCodIte Write FCodIte;

    [TCampoInteger]
    [TNomeCampo('ITE_CODEMP')]
    property CD_ESTOQUE : Integer Read FCodEst Write FCodEst;

    [TCampoDouble]
    [TNomeCampo('ITE_SALDOS')]
    property QT_ESTOQUE : Double  Read FSaldos Write FSaldos;
  End;

implementation

{ TGeoSale_Produto_Estoque }

uses untFuncoesSimples;

function TGeoSale_Produto_Estoque.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Produto_Estoque.TXT';
end;

function TGeoSale_Produto_Estoque.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT ITE_CODITE, ';
  Result := Result + '        ITE_CODEMP, ';
  Result := Result + '        ITE_SALDOS  ';
  Result := Result + ' FROM ITEGER        ';
  Result := Result + ' WHERE LOCATE(ITE_CODEMP,"'+ FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Produto_Estoque.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
