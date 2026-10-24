unit untGeoSale_Titulo;

interface

Uses untGeoSale_Base, Uni, untRTTILayout, System.SysUtils, strUtils;

Type
  [TTipoLayout(Exportar)]
  [TDelimitador(#9)]
  [TReplaceDelimitadorToVazio]
  TGeoSale_Titulo = Class(TGeoSale_Base)
  Private
    FValDup: Double;
    FDtaVen: TDateTime;
    FNumDup: String;
    FCodCli: Integer;
    FDtaCad: TDateTime;
    FCodFpg: String;

  Public
    function fGetSql : String; Override;
    function fGetArquivoNome : String; Override;
    procedure pSetParams(DataSet : TUniQuery); Override;
  Published
    [TCampoString]
    [TNomeCampo('CTR_NUMDUP')]
    Property CD_TITULO     : String     Read FNumDup Write FNumDup;

    [TCampoInteger]
    [TNomeCampo('CTR_CODCLI')]
    Property CD_CLIENTE    : Integer    Read FCodCli Write FCodCli;

    [TCampoDateTime]
    [TNomeCampo('CTR_DTACAD')]
    Property DT_LANCAMENTO : TDateTime  Read FDtaCad Write FDtaCad;

    [TCampoDouble]
    [TNomeCampo('CTR_VALDUP')]
    Property VR_TITULO     : Double     Read FValDup Write FValDup;

    [TCampoDateTime]
    [TNomeCampo('CTR_DTAVEN')]
    Property DT_VENCIMENTO : TDateTime  Read FDtaVen Write FDtaVen;

    [TCampoString]
    [TNomeCampo('CODFPG')]
    Property CD_MEIO_PGTO  : String     Read FCodFpg Write FCodFpg;
  End;

implementation

{ TGeoSale_Titulo }

uses untFuncoesSimples;

function TGeoSale_Titulo.fGetArquivoNome: String;
begin
  Result := IncludeTrailingPathDelimiter(FNomDir) + 'Titulo.TXT';
end;

function TGeoSale_Titulo.fGetSql: String;
begin
  Result := '';

  Result := Result + ' SELECT CONCAT(CTR_NUMDUP, "-", CTR_ESPDOC, "-", CTR_PARCEL, "-", CTR_CODCLI, "-", CTR_CODEMP) AS CTR_NUMDUP, ';
  Result := Result + '        CTR_CODCLI,                                                         ';
  Result := Result + '        CTR_DTACAD,                                                         ';
  Result := Result + '        CTR_VALDUP,                                                         ';
  Result := Result + '        CTR_DTAVEN,                                                         ';
  Result := Result + '        "001" AS CODFPG                                                     ';
  Result := Result + ' FROM CADREC                                                                ';
  Result := Result + ' INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI                               ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN                               ';
  Result := Result + ' WHERE CTR_VALDUP > 0                                                       ';
  Result := Result + '   AND CTR_DTAREC IS NULL                                                   ';
  Result := Result + '   AND LOCATE(OPE_CODEMP,"'+ FEmpresas + '") > 0                            ';
end;

procedure TGeoSale_Titulo.pSetParams(DataSet: TUniQuery);
begin
  Exit;
end;

end.
