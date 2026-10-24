unit untGeoSale_Transportadora;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Transportadora = Class(TGeoSale_Base)
  Private
    FNomTra: String;
    FCodtra: Integer;
    FCidade: String;
    FEstado: String;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('TRA_CODTRA')]
    Property CD_TRANSPORTADORA : Integer Read FCodtra Write FCodtra;

    [TCampoString]
    [TNomeCampo('TRA_NOMTRA')]
    Property NM_TRANSPORTADORA : String  Read FNomTra Write FNomTra;

    [TCampoString]
    [TNomeCampo('CID_ESTADO')]
    Property NM_CIDADE         : String  Read FCidade Write FCidade;

    [TCampoString]
    [TNomeCampo('CID_NOMCID')]
    Property NM_ESTADO         : String  Read FEstado Write FEstado;
  End;

implementation

{ TGeoSale_Transportadora }

uses untFuncoesSimples;

function TGeoSale_Transportadora.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Transportadora.TXT';
end;

function TGeoSale_Transportadora.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT TRA_CODTRA,                             ';
  Result := Result + '        TRA_NOMTRA,                             ';
  Result := Result + '        CID_NOMCID,                             ';
  Result := Result + '        CID_ESTADO                              ';
  Result := Result + ' FROM CADTRA                                    ';
  Result := Result + '   INNER JOIN CADCID ON CID_CODCID = TRA_CODCID ';
end;

procedure TGeoSale_Transportadora.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.


