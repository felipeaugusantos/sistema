unit untGeoSale_Organizacao_Venda;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Organizacao_Venda = Class(TGeoSale_Base)
  Private
    FEstado: String;
    FNomEmp: String;
    FCodEmp: String;
    FC_E_P_: String;
    FNomCid: String;
    FEndere: String;
    FFone01: String;
    FI_E_S_: String;
    FC_G_C_: String;
    FHomePa: String;
    FEmail_: String;
    FBairro: String;
  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TNomeCampo('EMP_CODEMP')]
    [TCampoString]
    Property CD_ORG_VENDA              : String Read FCodEmp Write FCodEmp;

    [TNomeCampo('EMP_NOMEMP')]
    [TCampoString]
    Property NM_ORGANIZACAO            : String Read FNomEmp Write FNomEmp;

    [TNomeCampo('EMP_ENDERE')]
    [TCampoString]
    Property END_ORGANIZACAO           : String Read FEndere Write FEndere;

    [TNomeCampo('EMP_BAIRRO')]
    [TCampoString]
    Property BAIRRO_ORGANIZACAO        : String Read FBairro Write FBairro;

    [TNomeCampo('CID_NOMCID')]
    [TCampoString]
    Property CIDADE_ORGANIZACAO        : String Read FNomCid Write FNomCid;

    [TNomeCampo('CID_ESTADO')]
    [TCampoString]
    Property UF_ORGANIZACAO            : String Read FEstado Write FEstado;

    [TNomeCampo('EMP_C_G_C_')]
    [TCampoString]
    Property CNPJ_ORGANIZACAO          : String Read FC_G_C_ Write FC_G_C_;

    [TNomeCampo('EMP_CODEMP')]
    [TCampoInteger]
    Property CD_ESTOQUE                : String Read FCodEmp Write FCodEmp;

    [TNomeCampo('EMP_C_E_P_')]
    [TCampoString]
    Property CEP_ORGANIZACAO           : String Read FC_E_P_ Write FC_E_P_;

    [TNomeCampo('EMP_I_E_S_')]
    [TCampoString]
    Property INSC_ESTADUAL_ORGANIZACAO : String Read FI_E_S_ Write FI_E_S_;

    [TNomeCampo('EMP_EMAIL_')]
    [TCampoString]
    Property EMAIL_ORGANIZACAO         : String Read FEmail_ Write FEmail_;

    [TNomeCampo('EMP_HOMEPA')]
    [TCampoString]
    Property SITE_ORGANIZACAO          : String Read FHomePa Write FHomePa;

    [TNomeCampo('EMP_FONE01')]
    [TCampoString]
    Property FONE_ORGANIZACAO          : String Read FFone01 Write FFone01;
  End;

implementation

{ TGeoSale_Organizacao_Venda }

uses untFuncoesSimples;

function TGeoSale_Organizacao_Venda.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Organizacao_Venda.TXT';
end;

function TGeoSale_Organizacao_Venda.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_CODEMP,                          ';
  Result := Result + '        EMP_NOMEMP,                          ';
  Result := Result + '        EMP_ENDERE,                          ';
  Result := Result + '        EMP_BAIRRO,                          ';
  Result := Result + '        CID_NOMCID,                          ';
  Result := Result + '        CID_ESTADO,                          ';
  Result := Result + '        EMP_C_G_C_,                          ';
  Result := Result + '        EMP_C_E_P_,                          ';
  Result := Result + '        EMP_I_E_S_,                          ';
  Result := Result + '        EMP_EMAIL_,                          ';
  Result := Result + '        EMP_HOMEPA,                          ';
  Result := Result + '        EMP_FONE01                           ';
  Result := Result + ' FROM CADEMP                                 ';
  Result := Result + ' INNER JOIN CADCID ON CID_CODCID = EMP_CODCID';
  Result := Result + ' WHERE LOCATE(EMP_CODEMP,"'+ FEmpresas + '") > 0 ';
end;

procedure TGeoSale_Organizacao_Venda.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;


end.
