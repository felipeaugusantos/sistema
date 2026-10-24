unit untGeoSale_Cliente;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [untRTTILayout.TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Cliente = Class(TGeoSale_Base)
  Private
    FLimite: Double;
    FSobNom: String;
    FBairro: String;
    FTipCli: Integer;
    FSeqAtd: Integer;
    FLacuna: Double;
    FNomCli: String;
    FCodRot: Integer;
    FTelefo: String;
    FSaldoL: Double;
    FEndere: String;
    FSalExc: Double;
    FC_G_F_: String;
    FSituac: String;
    FBonIte: String;
    FC_G_C_: String;
    FCodCli: Integer;
    FDtaCad: String;
    FCatego: Integer;
    FCidade: String;
    FEstado: String;
    FC_E_P_: String;
    FEmail_: String;

  Public

    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TNomeCampo('CLI_CODCLI')]
    [TCampoInteger]
    Property CD_CLIENTE                : Integer Read FCodCli Write FCodCli;

    [TNomeCampo('CLI_NOMCLI')]
    [TCampoString]
    Property NM_CLIENTE                : String  Read FNomCli Write FNomCli;

    [TNomeCampo('CLI_FANSOB')]
    [TCampoString]
    Property NM_FANTASIA               : String  Read FSobNom Write FSobNom;

    [TNomeCampo('CLI_ENDERE')]
    [TCampoString]
    Property DS_ENDEDECO               : String  Read FEndere Write FEndere;

    [TNomeCampo('CLI_BAIRRO')]
    [TCampoString]
    Property NM_BAIRRO                 : String  Read FBairro Write FBairro;

    [TNomeCampo('CID_NOMCID')]
    [TCampoString]
    Property NM_CIDADE                 : String  Read FCidade Write FCidade;

    [TNomeCampo('CID_ESTADO')]
    [TCampoString]
    Property NM_ESTADO                 : String  Read FEstado Write FEstado;

    [TNomeCampo('ROTA')]
    [TCampoInteger]
    Property CD_ROTA                   : Integer Read FCodRot Write FCodRot;

    [TNomeCampo('SEQATD')]
    [TCampoInteger]
    Property NR_SEQ_ATEND              : Integer Read FSeqAtd Write FSeqAtd;

    [TNomeCampo('SALLIM')]
    [TCampoDouble]
    Property VR_SALDO_LIMITE           : Double  Read FSaldoL Write FSaldoL;

    [TNomeCampo('STATUS')]
    [TCampoString]
    Property DS_SITUACAO               : String  Read FSituac Write FSituac;

    [TNomeCampo('CLI_FONE01')]
    [TCampoString]
    Property NR_TELEFONE               : String  Read FTelefo Write FTelefo;

    [TNomeCampo('CLI_LIMCRE')]
    [TCampoDouble]
    Property VR_LIMITE                 : Double  Read FLimite Write FLimite;

    [TNomeCampo('CLI_C_E_P_')]
    [TCampoString]
    Property NR_CEP                    : String  Read FC_E_P_ Write FC_E_P_;

    [TNomeCampo('CLI_C_G_C_')]
    [TCampoString]
    Property NR_CNPJ_CPF               : String  Read FC_G_C_ Write FC_G_C_;

    [TNomeCampo('C_G_F_')]
    [TCampoString]
    Property NR_CGF                    : String  Read FC_G_F_ Write FC_G_F_;

    [TNomeCampo('SALEXC')]
    [TCampoDouble]
    Property PC_SALDO_LIMITE_EXCENDETE : Double  Read FSalExc Write FSalExc;

    [TNomeCampo('CLI_EMAIL_')]
    [TCampoString]
    Property DS_EMAIL                  : String  Read FEmail_ Write FEmail_;

    [TNomeCampo('CLI_DTACAD')]
    [TCampoString]
    Property DT_CADASTRO               : String  Read FDtaCad Write FDtaCad;

    [TNomeCampo('BONITE')]
    [TCampoString]
    Property ID_BONIFICA_CAD_PRODUTOS  : String  Read FBonIte Write FBonIte;

    [TNomeCampo('CODCAT')]
    [TCampoInteger]
    Property CD_CATEGORIA              : Integer Read FCatego Write FCatego;

    [TNomeCampo('LACUNA')]
    [TCampoDouble]
    Property VR_LACUNA                 : Double  Read FLacuna Write FLacuna;

    [TNomeCampo('TIPCLI')]
    [TCampoInteger]
    Property CD_TIPO_CLIENTE           : Integer Read FTipCli Write FTipCli;

  End;

implementation

{ TGeoSale_Cliente }

uses untFuncoesConsulta;

function TGeoSale_Cliente.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Cliente.TXT';

end;

function TGeoSale_Cliente.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                    ';
  Result := Result + '        CLI_CODCLI,                                     ';
  Result := Result + '        CLI_NOMCLI,                                     ';
  Result := Result + '        CLI_FANSOB,                                     ';
  Result := Result + '        CLI_ENDERE,                                     ';
  Result := Result + '        IF( IFNULL(CLI_BAIRRO,"") = "", "-", CLI_BAIRRO) AS CLI_BAIRRO,           ';
  Result := Result + '        CID_NOMCID,                                     ';
  Result := Result + '        CID_ESTADO,                                     ';
  Result := Result + '        NULL AS ROTA,                                   ';
  Result := Result + '        NULL AS SEQATD,                                 ';
  Result := Result + '        NULL AS SALLIM,                                 ';
  Result := Result + '        IF(CLI_STATUS = "A",NULL,CLI_STATUS) AS STATUS, ';
  Result := Result + '        CLI_FONE01,                                     ';
  Result := Result + '        CLI_LIMCRE,                                     ';
  Result := Result + '        CLI_C_E_P_,                                     ';
  Result := Result + '        CLI_C_G_C_,                                     ';
  Result := Result + '        NULL AS C_G_F_,                                 ';
  Result := Result + '        NULL AS SALEXC,                                 ';
  Result := Result + '        CLI_EMAIL_,                                     ';
  Result := Result + '        "" AS CLI_DTACAD,                               ';
  Result := Result + '        NULL AS BONITE,                                 ';
  Result := Result + '        NULL AS CODCAT,                                 ';
  Result := Result + '        NULL AS LACUNA,                                 ';
  Result := Result + '        NULL AS TIPCLI                                  ';
  Result := Result + ' FROM CADCLI                                            ';
  Result := Result + ' INNER JOIN CADCID ON CID_CODCID = CLI_CODCID           ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN           ';
  Result := Result + ' WHERE LOCATE(OPE_CODEMP,"'+ FEmpresas + '") > 0        ';
end;

procedure TGeoSale_Cliente.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
