unit untGeoSale_Org_venda_cliente;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Org_venda_cliente = Class(TGeoSale_Base)
  Private
    FGruMpg: String;
    FCodEmp: String;
    FCodCli: String;
    FTabPre: String;
    FCodVen: String;
    function GetCodCli: String;
    function GetCodVen: String;
    function GetGruMpg: String;
    function GetTabPre: String;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('CLI_CODEMP')]
    Property CD_ORG_VENDA    : String Read FCodEmp Write FCodEmp;

    [TCampoString]
    [TNomeCampo('CLI_CODCLI')]
    Property CD_CLIENTE      : String Read GetCodCli Write FCodCli;

    [TCampoString]
    [TNomeCampo('CLI_CODVEN')]
    Property CD_VENDEDOR     : String Read GetCodVen Write FCodVen;

    [TCampoString]
    [TNomeCampo('CLI_TABPRE')]
    Property CD_TAB_PRECO    : String Read GetTabPre Write FTabPre;

    [TCampoString]
    [TNomeCampo('CLI_CODEMP')]
    Property CD_GRUPO_MPGTO  : String Read GetGruMpg Write FGruMpg;

  End;

implementation

{ TGeoSale_Org_venda_cliente }

uses untFuncoesSimples;

function TGeoSale_Org_venda_cliente.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Org_venda_cliente.TXT';
end;

function TGeoSale_Org_venda_cliente.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP AS CLI_CODEMP, ';
  Result := Result + '        CLI_CODCLI,               ';
  Result := Result + '        CLI_CODVEN,               ';
  Result := Result + '        CLI_TABPRE                ';
  Result := Result + ' FROM CADCLI                      ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN    ';
  Result := Result + ' INNER JOIN CADEMP ON (LOCATE(EMP_CODEMP, OPE_EMPACE) > 0) AND (LOCATE(EMP_CODEMP, "'+ FEmpresas + '") > 0) ';
  Result := Result + ' WHERE LOCATE(OPE_CODEMP,"'+ FEmpresas + '") > 0 ';
end;

function TGeoSale_Org_venda_cliente.GetCodCli: String;
begin
  Result := IntToStr(StrToInt(FCodCli));
end;

function TGeoSale_Org_venda_cliente.GetCodVen: String;
begin
  Result := IntToStr(StrToInt(FCodVen));
end;

function TGeoSale_Org_venda_cliente.GetGruMpg: String;
begin
  Result := IntToStr(StrToInt(FGruMpg));
end;

function TGeoSale_Org_venda_cliente.GetTabPre: String;
begin
  Result := IntToStr(StrToIntDef(FTabPre,0));
end;

procedure TGeoSale_Org_venda_cliente.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
