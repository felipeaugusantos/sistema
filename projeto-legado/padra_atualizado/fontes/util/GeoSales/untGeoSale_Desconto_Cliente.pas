unit untGeoSale_Desconto_Cliente;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [untRTTILayout.TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Desconto_Cliente = Class(TGeoSale_Base)
  Private
    FDesCli: Double;
    FCodCli: Integer;
    FZeros: Double;
    FZeroI: Integer;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TNomeCampo('CLI_CODCLI')]
    [TCampoInteger]
    Property CD_CLIENTE  : Integer Read FCodCli Write FCodCli;

    [TNomeCampo('CLI_DESCON')]
    [TCampoDouble]
    Property PR_MAX_DESC : Double Read FDesCli Write FDesCli;

    [TNomeCampo('CLI_ZEROS_')]
    [TCampoDouble]
    Property PR_DESC_PARC : Double Read FZeros Write FZeros;

    [TNomeCampo('CLI_ZEROS_')]
    [TCampoInteger]
    Property NR_PRAZO  : Integer Read FZeroI Write FZeroI;

  End;

implementation



uses untFuncoesConsulta;

function TGeoSale_Desconto_Cliente.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Desconto_Cliente.TXT';

end;

function TGeoSale_Desconto_Cliente.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE    ';
  Result := Result + '        CLI_CODCLI,     ';
  Result := Result + '        CLI_DESCON,     ';
  Result := Result + '        0 AS CLI_ZEROS_ ';
  Result := Result + ' FROM CADCLI            ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN ';
  Result := Result + ' WHERE CLI_DESCON > 0   ';
  Result := Result + '   AND LOCATE(OPE_CODEMP,"'+ FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Desconto_Cliente.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
