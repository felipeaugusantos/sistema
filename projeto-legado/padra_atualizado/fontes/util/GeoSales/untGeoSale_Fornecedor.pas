unit untGeoSale_Fornecedor;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Fornecedor = Class(TGeoSale_Base)
  Private
    FNomFor: String;
    FBloque: String;
    FCodFor: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('FOR_CODFOR')]
    Property CD_FORNECEDOR : Integer Read FCodFor Write FCodFor;

    [TCampoString]
    [TNomeCampo('FOR_NOMFOR')]
    Property DS_FORNECEDOR : String  Read FNomFor Write FNomFor;

    [TCampoString]
    [TNomeCampo('BLOQUE')]
    Property ID_BLOQUEADO  : String  Read FBloque Write FBloque;

  End;

implementation

{ TGeoSale_Fornecedor }

uses untFuncoesSimples;

function TGeoSale_Fornecedor.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Fornecedor.TXT';
end;

function TGeoSale_Fornecedor.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT FOR_CODFOR,           ';
  Result := Result + '        FOR_NOMFOR,           ';
  Result := Result + '        IF(FOR_STATUS="I","S","N") AS BLOQUE ';
  Result := Result + ' FROM CADFOR                  ';

end;

procedure TGeoSale_Fornecedor.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
