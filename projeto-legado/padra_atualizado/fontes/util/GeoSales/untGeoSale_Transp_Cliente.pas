unit untGeoSale_Transp_Cliente;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Transp_Cliente = Class(TGeoSale_Base)
  Private
    FCodTra: Integer;
    FCodCli: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('ETC_CODCLI')]
    Property CD_CLIENTE        : Integer Read FCodCli Write FCodCli;

    [TCampoInteger]
    [TNomeCampo('ETC_CODTRA')]
    Property CD_TRANSPORTADORA : Integer Read FCodTra Write FCodTra;

  End;

implementation

{ TGeoSale_Transp_Cliente }

uses untFuncoesSimples;

function TGeoSale_Transp_Cliente.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Transp_Cliente.TXT';
end;

function TGeoSale_Transp_Cliente.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT ETC_CODCLI,                               ';
  Result := Result + '        ETC_CODTRA                                ';
  Result := Result + ' FROM ENTCLI                                      ';
  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = ETC_CODCLI     ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN     ';
  Result := Result + ' WHERE ETC_CODTRA IS NOT NULL                     ';
  Result := Result + '   AND ETC_ENDFAT = "S"                           ';
  Result := Result + '   AND LOCATE(OPE_CODEMP,"' + FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Transp_Cliente.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
