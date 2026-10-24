unit untGeoSale_Produto;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Produto = Class(TGeoSale_Base)
  Private
    FDesBon: Double;
    FEmbala: Double;
    FMltVen: Double;
    FRefere: String;
    FIdMoni: String;
    FPesoIt: Double;
    FCodIte: Integer;
    FObserv: String;
    FtipPro: String;
    FAcrMax: Double;
    FDesMax: Double;
    FCodGru: Integer;
    FSaldos: Double;
    FSigUni: String;
    FNumPra: Integer;
    FDesIte: String;
    FCodFor: Integer;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoInteger]
    [TNomeCampo('ITE_CODITE')]
    Property CD_PRODUTO              : Integer Read FCodIte Write FCodIte;

    [TCampoString]
    [TNomeCampo('ITE_DESITE')]
    Property NM_PRODUTO              : String  Read FDesIte Write FDesIte;

    [TCampoString(alEsquerda, 3, '')]
    [TNomeCampo('UNI_SIGUNI')]
    Property DS_UNIDADE_BASE         : String  Read FSigUni Write FSigUni;

    [TCampoDouble]
    [TNomeCampo('ITE_MLTVEN')]
    Property QT_BASE                 : Double  Read FMltVen Write FMltVen;

    [TCampoInteger]
    [TNomeCampo('ITE_CODGRU')]
    Property CD_FAMILIA              : Integer Read FCodGru Write FCodGru;

    [TCampoDouble]
    [TNomeCampo('ITE_SALDOS')]
    Property QT_ESTOQUE              : Double  Read FSaldos Write FSaldos;

    [TCampoString]
    [TNomeCampo('ITE_OBSERV')]
    Property DS_OBS_PRODUTO          : String  Read FObserv Write FObserv;

    [TCampoDouble]
    [TNomeCampo('ITE_EMBALA')]
    Property QT_UNIDADE              : Double  Read FEmbala Write FEmbala;

    [TCampoString]
    [TNomeCampo('ITE_REFERE')]
    Property CD_REFERENCIA           : String  Read FRefere Write FRefere;

    [TCampoDouble]
    [TNomeCampo('ITE_PESOIT')]
    Property PS_PRODUTO_KG           : Double  Read FPesoIt Write FPesoIt;

    [TCampoDouble]
    [TNomeCampo('ITE_DESMAX')]
    Property VR_MAX_PC_DESCONTO      : Double  Read FDesMax Write FDesMax;

    [TCampoDouble]
    [TNomeCampo('ITE_ACRMAX')]
    Property VR_MAX_PC_ACRESCIMO     : Double  Read FAcrMax Write FAcrMax;

    [TCampoInteger]
    [TNomeCampo('ITE_CODFOR')]
    Property CD_FORNECEDOR           : Integer Read FCodFor Write FCodFor;

    [TCampoString]
    [TNomeCampo('ITE_IDMONI')]
    Property ID_MONITORADO           : String  Read FIdMoni Write FIdMoni;

    [TCampoString]
    [TNomeCampo('ITE_TIPPRO')]
    Property ID_TIPO_PRODUTO         : String  Read FtipPro Write FtipPro;

    [TCampoDouble]
    [TNomeCampo('ITE_DESBON')]
    Property PR_DESCONTO_BONIFICACAO : Double  Read FDesBon Write FDesBon;

    [TCampoInteger]
    [TNomeCampo('ITE_NUMPRA')]
    Property NR_PRAZO                : Integer Read FNumPra Write FNumPra;
  End;

implementation

{ TGeoSale_Produto }

uses untFuncoesSimples;

function TGeoSale_Produto.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Produto.TXT';
end;

function TGeoSale_Produto.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT I.ITE_CODITE,                                                                   ';
  Result := Result + '          ITE_DESITE,                                                                   ';
  Result := Result + '          UNI_SIGUNI,                                                                   ';
  Result := Result + '          IFNULL(ITE_MLTVEN,0) AS ITE_MLTVEN,                                           ';
  Result := Result + '          ITE_CODGRU,                                                                   ';
  Result := Result + '          IFNULL(ITE_SALDOS,0) AS ITE_SALDOS,                                           ';
  Result := Result + '          TRIM(CONCAT(IFNULL(ITE_MSGLV1,"")," ", IFNULL(ITE_MSGLV2,""))) AS ITE_OBSERV, ';
  Result := Result + '          IFNULL(ITE_EMBALA,1) AS ITE_EMBALA,                                           ';
  Result := Result + '          ITE_REFERE,                                                                   ';
  Result := Result + '          IFNULL(ITE_PESOIT,0) AS ITE_PESOIT,                                           ';
  Result := Result + '          ITE_DESMAX,                                                                   ';
  Result := Result + '          0 AS ITE_ACRMAX,                                                              ';
  Result := Result + '          ITE_CODFOR,                                                                   ';
  Result := Result + '          "" AS ITE_IDMONI,                                                             ';
  Result := Result + '          "" AS ITE_TIPPRO,                                                             ';
  Result := Result + '          0  AS ITE_DESBON,                                                             ';
  Result := Result + '          0  AS ITE_NUMPRA                                                              ';
  Result := Result + ' FROM ITEGER G                                                                          ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE                                   ';
  Result := Result + '   INNER JOIN CADUNI U ON U.UNI_CODUNI = ITE_CODUNI                                     ';
  Result := Result + ' WHERE G.ITE_CODEMP = :CODEMP                                                           ';
end;

procedure TGeoSale_Produto.pSetParams(DataSet: TUniQuery);
begin
  DataSet.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

end.
