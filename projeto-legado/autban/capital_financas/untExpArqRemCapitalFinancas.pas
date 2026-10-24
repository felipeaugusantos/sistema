unit untExpArqRemCapitalFinancas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask, System.IOUtils,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa,untFuncAutban, untGravando,
  System.DateUtils,untTIntegracaoExtrant,Data.DB,cxProgressBar;

type
  TDadosExtrant = record
    FQueryRemessa: TUniQuery;
    FAutoIncremRemGer: string;
  end;

  TfrmExpArqRemCapitalFinancas = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRemessa: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
  private
    FEnviarRemessaExtrant: TEnviaRemessaExtrant;
    FDadosExtrant : TDadosExtrant;
    FTipoCobranca: String;
    FNomeForm: String;
    FNumeroCarteira: Integer;

    procedure pAtualizaDadosCadRecAlpe(AAutoIncremCadRec, APercentualAlpe, ATaxaTedAlpe: String; ADataAlpe: TDateTime);
    procedure pEnviarArquivoRemessaParaExtrant;
    procedure pGravaLogCtr(AQryRemessa: TUniQuery);
    procedure pStepStatus(APgbStatus: TcxProgressBar);

    function fEnviarXMLDaNotaParaExtrant(APgbProgresso: TcxProgressBar): Boolean;
    function fRetornaListaDuplicatasAgrupadas(ANumAgr, AEmpAgr, ACodCli: String): WideString;
    function fRetornaEmpresa: String;
    function fRetornaNomeBoletoExtrant: String;
    function fRetornaIdentificacaoBoletoExtrant: String;
  public
    property TipoCobranca: String read FTipoCobranca write FTipoCobranca;
    property NumeroCarteira: Integer read FNumeroCarteira write FNumeroCarteira;
    property NomeForm: String read FNomeForm write FNomeForm;

    procedure EnviarArquivoRemessaParaAlpe;
  protected
    function fValidaCampos(ASender: TWinControl; ABuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemCapitalFinancas: TfrmExpArqRemCapitalFinancas;

implementation

uses
  untFuncoes, untfuncoesSimples, untConsultas,
  untTypesSistema, untConstantes, untLogCtr,
  untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemCapitalFinancas.FormShow(Sender: TObject);
var
  LVariante : String;
begin
  inherited;

  FTipoCobranca := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'TIPCOBR','');
  LVariante := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'VARNOMREM','');


  if fEmptyStr(FTipoCobranca) then
    FTipoCobranca := 'S';

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'PATHREM',''));

  if FTipoCobranca = 'S' then
  begin

    if fEmptyStr(LVariante) then
      LVariante := 'A' + IntToStr(FNumeroCarteira);

    edtNomArquivo.Text  := 'CB' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + LVariante  + '.REM';
  end
  else
  begin
    edtNomArquivo.Text  := 'DS' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + 'A' + IntToStr(FNumeroCarteira) + '.REM';
  end;

  if (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'DSNAME','') = 'S') then
  begin
    edtNomArquivo.Text := 'COBN_' + fPadL(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'CODEMPR', ''),07)+ '.REM';
  end;

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCapitalFinancas.pAtualizaDadosCadRecAlpe(AAutoIncremCadRec,
  APercentualAlpe, ATaxaTedAlpe: String; ADataAlpe: TDateTime);
var
  LPercentualAlpe,
  LTaxaTedAlpe: Double;
  LUpdate: TUniQuery;
begin
  if not TryStrToFloat(APercentualAlpe, LPercentualAlpe) then
    LPercentualAlpe := 0.00;

  if not TryStrToFloat(ATaxaTedAlpe, LTaxaTedAlpe) then
    LTaxaTedAlpe := 0.00;

  LUpdate := fCriaQuery;

  try
    LUpdate.SQL.Text := 'UPDATE CADREC SET ' +
                        '   CTR_PERALP=:PERALP, ' +
                        '   CTR_TARTED=:TARTED, ' +
                        '   CTR_DTAALP=:DTAALP ' +
                        'WHERE AUTOINCREM=:AUTINC ';

    LUpdate.ParamByName('PERALP').AsFloat := fFormataFloat(LPercentualAlpe, 2);
    LUpdate.ParamByName('TARTED').AsFloat := fFormataFloat(LTaxaTedAlpe, 2);
    LUpdate.ParamByName('DTAALP').AsDateTime := ADataAlpe;

    LUpdate.ParamByName('AUTINC').AsString := AAutoIncremCadRec;

    LUpdate.ExecSQL;
  finally
    FreeAndNil(LUpdate);
  end;
end;

procedure TfrmExpArqRemCapitalFinancas.pGravaLogCtr(AQryRemessa: TUniQuery);
begin
  AQryRemessa.DisableControls;
  AQryRemessa.First;
  while not AQryRemessa.Eof do
  begin
    untLogCtr.GravaLogCtr(AQryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 978', Self.Name);
    AQryRemessa.Next;
  end;
end;

function TfrmExpArqRemCapitalFinancas.fRetornaListaDuplicatasAgrupadas(ANumAgr, AEmpAgr, ACodCli: String): WideString;
var
  LQryDupAgr: TUniQuery;
begin
  Result := '';
  LQryDupAgr := fCriaQuery(Self);
  try
    LQryDupAgr.SQL.Text :=
      'SELECT '+
      ' CTR_NUMAGR, CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, '+
      ' CTR_CODEMP, CTR_CODCLI, CTR_DTACAD, CTR_VALDUP  '+
      'FROM DUPAGR '+
      'WHERE CTR_NUMAGR = :NUMAGR '+
      'AND CTR_EMPAGR = :EMPAGR '+
      'AND CTR_CODCLI = :CODCLI '+
      'ORDER BY CTR_DTACAD, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, CTR_PARCEL ';

    LQryDupAgr.ParamByName('NUMAGR').AsString := ANumAgr;
    LQryDupAgr.ParamByName('EMPAGR').AsString := AEmpAgr;
    LQryDupAgr.ParamByName('CODCLI').AsString := ACodCli;
    LQryDupAgr.Open;
    LQryDupAgr.First;

    while not LQryDupAgr.Eof do
    begin
      Result := Result +
        FormatDateTime('dd/mm/yy', LQryDupAgr.FieldByName('CTR_DTACAD').AsDateTime) +
        ' DOC:' + LQryDupAgr.FieldByName('CTR_NUMDUP').AsString +
        LQryDupAgr.FieldByName('CTR_PARCEL').AsString +
        LQryDupAgr.FieldByName('CTR_ESPDOC').AsString +
        '-' + LQryDupAgr.FieldByName('CTR_CODEMP').AsString +
        ' V:' + FormatFloat('#,##0.00', LQryDupAgr.FieldByName('CTR_VALDUP').AsFloat) + ' ';

      LQryDupAgr.Next;
    end;
  finally
    LQryDupAgr.Close;
    FreeAndNil(LQryDupAgr);
  end;
end;

procedure TfrmExpArqRemCapitalFinancas.btnGerarClick(Sender: TObject);
var
  LSQL,
  LCodBco,
  LNomEmp,
  LDtaRem,
  LDtaVen,
  LDtaEmi,
  LKeyDup,
  LNumDup,
  LCgcEmp,
  LCgcCli,
  LCodRem,
  LCpfCgc,
  LEmpBco,
  LNumAut,
  LCodAge,
  LCntCor,
  LDigCnt,
  LIdeEmp,
  LCodCar,
  LDiaPro,
  LInstru1,
  LObserv,
  LEmpAgr,
  LCodCli,
  LUsaSac,
  LHeader,
  LTransacao,
  LTrans2,
  LTrailler,
  LTrans7,
  LRespon,
  LNosNum,
  LNovCodEmp,
  LEnvMsg,
  LCartSeq,
  LBenefi,
  LSacAva,
  LSacEnd,
  LSacCEP,
  LSacCid,
  LSacEst,
  LCartei,
  LCcDigito,
  LCodOco,
  LFilePath,
  LAutoIncremRem,
  LchkcbEmp,
  LEndereco,
  LDtaDpoFormatada,
  LInstruProtestoPers,
  LTaxaTedAlpe,
  LPercentualAlpe: String;

  LObsAgr: WideString;

  LRemLoc,
  LUsaCnd,
  LUsaDesPonCli,
  LUsaDesPon,
  LUtilizaAlpe,
  LUtilizaExtrant,
  LApresentarEspecieDocumento: Boolean;

  LCodSeq: Integer;

  LValAtr,
  LPerMul,
  LValDup,
  LDescontoSugerido,
  LValDpo: Double;

  LDtaDpo,
  LDataAlpe: TDateTime;

  LTexto: TextFile;

  LQryRemessa,
  LQryConsultaGen: TUniQuery;
begin
  inherited;
  LNumDup := '';

  if not fVerificaCampos then
    Exit;

  if fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  if not DirectoryExists(fraPathRemessa.edtDirectory.text) then
  begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  end;

  LCodSeq  := 1;
  LCodBco  := '978';
  LNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  LNumAut  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'NUMAUTO', '');
  LCodAge  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'CODAGEN', '');
  LEmpBco  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'CODEMPR', '');
  LCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'NUMCTAC', ''), 7), 7);
  LDigCnt  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'DIGCTAC', '');
  LCodCar  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'CODCART', '');
  LDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  LInstru1 := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'INSTRU1', '');
  LInstruProtestoPers := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'INSTPER', '');
  LObserv  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'OBSERV1', '');
  LRemLoc  := not( fGetBancoConfig(0,'CONFIG978', 'RELOCAL', '') = 'N' );
  LEnvMsg  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'MANDMSG', '');
  LUsaSac  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'SACAVAL', '');
  LBenefi  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'NOMEBEN', '');
  LUtilizaAlpe :=  (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'UTILIZA_ALPE', '') = 'S');
  LUtilizaExtrant :=  (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'UTILIZA_EXTRANT', '') = 'S');

  LApresentarEspecieDocumento := (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'ESPDOCBOL', '') = 'S');

  LPercentualAlpe := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'PERALPE', '');
  LTaxaTedAlpe := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'TEDALPE', '');

  LDataAlpe := fAcertaDataParaDiaUtil(VS_Date);
  if (fRetHoraServidor >= StrToTime('18:00:00')) then
    LDataAlpe := fAcertaDataParaDiaUtil(IncDay(VS_Date, 1));

  LPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'PERMULT', '') );

  LUsaCnd := fCfgSis('USACND', VarBoolean);

  if (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) then
    LUsaDesPonCli := True
  else
    LUsaDesPonCli := False;

  if fCfgSis('DESPON', varBoolean) then
    LUsaDesPon := True
  else
    LUsaDesPon := False;

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  LNovCodEmp := VS_strCodEmp;

  if not( LRemLoc ) then
    LNovCodEmp := fRetornaEmpresa;

  LNomEmp := fRetNomeEmpresa(LNovCodEmp);

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  if fEmptyStr( LNomEmp ) then
  begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  end;

  LRespon := '1';
  if (fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'RESPONS', '') = 'E') then
    LRespon := '2';

  LDiaPro := '00';
  if FTipoCobranca = 'S' then
    LDiaPro := IIF(Pos(LInstru1, '06_05_07_18_') > 0, fStrZero(fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'DIAPROT', ''),2), '00');

  try
    fStartTransaction;
    try
      LCartei  := 'CONFIG978-' + IntToStr(FNumeroCarteira) + '-' + VS_strCodEmp;
      LQryConsultaGen := fCriaQuery(Self);

      LSQL := '';
      LSQL := LSQL + 'SELECT ';
      LSQL := LSQL + '  E.*,  C.CID_NOMCID, C.CID_ESTADO ';
      LSQL := LSQL + 'FROM ';
      LSQL := LSQL + '  CADEMP E ';
      LSQL := LSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
      LSQL := LSQL + 'WHERE ';
      LSQL := LSQL + '  EMP_CODEMP = :CODEMP ';

      LQryConsultaGen.SQL.Add(LSQL);
      LQryConsultaGen.ParamByName('CODEMP').AsString := LNovCodEmp;
      LQryConsultaGen.Open;
      LCgcEmp := LQryConsultaGen.FieldByName('EMP_C_G_C_').AsString;

      if LUsaSac = 'S' then
      begin
        LSacAva := fPadL(fTiraCaracEspeciaisPonto(LCgcEmp), 015, '0') + '  ' + fPadR(LNomEmp, 043);
        LSacEnd := fPadR(LQryConsultaGen.FieldByName('EMP_ENDERE').AsString + ', ' +
                            LQryConsultaGen.FieldByName('EMP_ENDNUM').AsString + ' ' +
                            LQryConsultaGen.FieldByName('EMP_BAIRRO').AsString, 045);
        LSacCEP := fPadR(fRetSomenteNumeros(LQryConsultaGen.FieldByName('EMP_C_E_P_').AsString), 008, '0');
        LSacCid := fPadR(LQryConsultaGen.FieldByName('CID_NOMCID').AsString, 020);
        LSacEst := fPadR(LQryConsultaGen.FieldByName('CID_ESTADO').AsString, 002);
      end;

      LQryConsultaGen.Close;

      LQryRemessa := fCriaQuery(Self);

      LSQL := '';
      LSQL := LSQL + 'SELECT ';
      LSQL := LSQL + '  B.*, ';
      LSQL := LSQL + '  C.CLI_NOMCLI, ';

      if LUtilizaExtrant then
        LSQL := LSQL + '  FIS_ACESSO, NFE_ARQXML, BOL_SEQCTR, BOL_BOLETO, ';

      LSQL := LSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
      LSQL := LSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
      LSQL := LSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
      LSQL := LSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
      LSQL := LSQL + '  R.CTR_DESSUJ AS CTR_DESSUJ, ';
      LSQL := LSQL + '  if(IFNULL(C.CLI_ENDCOB, "") = "", if(IFNULL(C.CLI_ENDERE, "") = "", if(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
      LSQL := LSQL + '  if(IFNULL(C.CLI_ENDCOB, "") = "", if(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
      LSQL := LSQL + '  if(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
      LSQL := LSQL + '  if(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
      LSQL := LSQL + '  if(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
      LSQL := LSQL + '  if(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                    '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
      LSQL := LSQL + '  if(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                    '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
      if LUsaDesPon then
      begin
        LSQL := LSQL + '  ,D.CND_PERDPO ';
        LSQL := LSQL + '  ,D.CND_QTDDAV ';
      end;

      LSQL := LSQL + 'FROM ';
      LSQL := LSQL + '  CADCBI B  ';
      LSQL := LSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
      LSQL := LSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
      LSQL := LSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
      LSQL := LSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
      LSQL := LSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
      LSQL := LSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

      if LUtilizaExtrant then
      begin
        LSQL := LSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = CTR_NUMDUP AND ';
        LSQL := LSQL + '                      FIS_ESPDOC = CTR_ESPDOC AND ';
        LSQL := LSQL + '                      FIS_CODEMP = CTR_CODEMP AND ';
        LSQL := LSQL + '                      FIS_FORCLI = CTR_CODCLI AND ';
        LSQL := LSQL + '                      FIS_TIP_FC = "C"        AND ';
        LSQL := LSQL + '                      FIS_ORIDOC = "V"            ';
        LSQL := LSQL + '  LEFT JOIN XMLNFE ON FIS_ACESSO = NFE_ACESSO     ';
        LSQL := LSQL + '  LEFT JOIN BOLCTR ON R.AUTOINCREM = BOL_SEQCTR   ';
      end;

      if LUsaDesPon then
        LSQL := LSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

      LSQL := LSQL + 'WHERE                                       ';
      LSQL := LSQL + '  CBI_CODBCO = :CODBCO AND                  ';
      LSQL := LSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06" OR B.CBI_CODOCO = "19" OR B.CBI_CODOCO = "20")) OR';
      LSQL := LSQL + '  (CTR_DTAREC IS not NULL AND B.CBI_CODOCO = "02"))';

      if fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'then
      begin
        LchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
        LSQL := LSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(LchkcbEmp,';') + ') ';
      end;

      if (fCfgSis('CONREM', varString) = 'C') then
        LSQL := LSQL + '  AND CBI_CARTEI = :CARTEI ';

      if (not fEmptyStr(edtCodPor.Text)) then
        LSQL := LSQL + '  AND CBI_CODPOR = :CODPOR '
      else if fCfgSis('DACPOR', varBoolean) then
      begin
        LSQL := LSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
        LSQL := LSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      end;

      LQryRemessa.SQL.Add(LSQL);
      LQryRemessa.ParamByName('CODBCO').AsString := LCodBco;

      if (fCfgSis('CONREM', varString) = 'C') then
        LQryRemessa.ParamByName('CARTEI').AsString := LCartei;

      if (not fEmptyStr(edtCodPor.Text)) then
        LQryRemessa.ParamByName('CODPOR').AsString := edtCodPor.Text;

      LQryRemessa.Open;

      if LQryRemessa.IsEmpty then
      begin
        fRollBack;
        fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
        Exit;
      end;

      LQryRemessa.First;

      //Gerando número da remessa e atualizando carteiras "filhas"
      LCartSeq := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'SEQCART', '');
      LCodRem  := fStrZero(fAtuCodSeq('CONFIG978-' + IIF(fEmptyStr(LCartSeq), IntToStr(FNumeroCarteira), LCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG978-' + IIF(fEmptyStr(LCartSeq), IntToStr(FNumeroCarteira), LCartSeq));

      LEmpAgr := LQryRemessa.FieldByName('CBI_CODEMP').AsString;
      LCodCli := LQryRemessa.FieldByName('CBI_CODCLI').AsString;

      AssignFile(LTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      LFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(LTexto);

      {*********************}
      {* HEADER do ARQUIVO *}
      {******************AF*}
      LHeader := '';

      if FTipoCobranca = 'S' then
      begin
        LHeader := fPadR   ('0'                                  , 001)      + //001
                   fPadR   ('1'                                  , 001)      + //002
                   fPadR   ('REMESSA'                            , 007)      + //003
                   fPadR   ('01'                                 , 002)      + //010
                   fPadR   ('COBRANCA'                           , 015)      + //012
                   fPadL   (LEmpBco                              , 020, '0') + //027
                   fPadR   (IIF(LUsaSac <> 'S', LNomEmp, LBenefi), 030)      + //047
                   fPadR   ('237'                                , 003)      + //077
                   fPadR   ('BRADESCO'                           , 015)      + //080
                   fPadR   (LDtaRem                              , 006)      + //095
                   fPadR   (' '                                  , 008)      + //101
                   fPadR   ('MX'                                 , 002)      + //109
                   fPadR   (LCodRem                              , 007)      + //111
                   fPadR   (' '                                  , 277)      + //118
                   fStrZero('1'                                  , 006);       //395
      end
      else
      begin
        LHeader := fPadR   ('0'                                  , 001)      + //001
                   fPadR   ('1'                                  , 001)      + //002
                   fPadR   ('REMESSA'                            , 007)      + //003
                   fPadR   ('01'                                 , 002)      + //010
                   fPadR   ('COBRANCA'                           , 015)      + //012
                   fPadL   (LEmpBco                              , 020, '0') + //027
                   fPadR   (IIF(LUsaSac <> 'S', LNomEmp, LBenefi), 030)      + //047
                   fPadR   ('237'                                , 003)      + //077
                   fPadR   ('BRADESCO'                           , 015)      + //080
                   fPadR   (LDtaRem                              , 006)      + //095
                   fPadR   (' '                                  , 008)      + //101
                   fPadR   ('MX'                                 , 002)      + //109
                   fPadR   (LCodRem                              , 007)      + //111
                   fPadR   (' '                                  , 249)      + //118
                   fPadR   ('DESC'                               , 004)      + //367
                   fPadR   (LNumAut                              , 004)      + //371
                   RightStr(fStrZero(LCodAge, 005)               , 005)      + //375
                   RightStr(fStrZero(LCntCor, 007)               , 007)      + //380
                   fPadR   (LDigCnt                              , 001)      + //387
                   fPadR   (' '                                  , 007)      + //388
                   fStrZero('1'                                  , 006);       //395
      end;

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(LTexto,LHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, LCodBco, LCartei, StrToInt(LCodRem), LAutoIncremRem);

      {************************}
      {* TRANSAÇÃO do ARQUIVO *}
      {*********************AF*}
      LTransacao := '';

      while not LQryRemessa.Eof do
      begin
        LInstru1 := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'INSTRU1', '');

        if LQryRemessa.FieldByName('CBI_PROTES').AsString = 'S' then
        begin
          if (not fEmptyStr(LInstruProtestoPers)) and (LInstruProtestoPers <> '00') then
            LInstru1 := LInstruProtestoPers;
        end;

        LObserv  := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(FNumeroCarteira), 'OBSERV1', '');

        if (fEmptyStr(LObserv)) And
           (FTipoCobranca = 'S')      And
           (Pos(LInstru1, '06_05_07_18_') > 0) then
          LObserv := 'PROTESTAR APOS ' + LDiaPro + IIF(StrToInt(LDiaPro) = 1,' DIA ', ' DIAS ') + 'do VENCIMENTO';

        Inc(LCodSeq);
        Application.ProcessMessages;

        LValAtr := fFormataFloat((
          LQryRemessa.FieldByName('CBI_VALDUP').AsFloat *
          LQryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

        if LQryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 0 then
          LCpfCgc := '99'
        else if LQryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 then
          LCpfCgc := '2'
        else
          LCpfCgc := '1';

        LDtaVen :=
          FormatDateTime('dd',LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
          FormatDateTime('mm',LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
          FormatDateTime('yy',LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        LDtaEmi :=
          FormatDateTime('dd',LQryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
          FormatDateTime('mm',LQryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
          FormatDateTime('yy',LQryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        LNumDup :=
          LQryRemessa.FieldByName('CBI_NUMDUP').AsString +
          IIF(LUtilizaAlpe,
            fStrZero(fRetNumParcela(LQryRemessa.FieldByName('CBI_PARCEL').AsString),2),
            LQryRemessa.FieldByName('CBI_PARCEL').AsString);

        if LApresentarEspecieDocumento then
          LNumDup := RightStr(LNumDup, LNumDup.Length - 2) + LQryRemessa.FieldByName('CBI_ESPDOC').AsString;

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(LQryRemessa.FieldByName('CBI_ESPDOC').AsString) then
        begin
          fRollBack;
          CloseFile(LTexto);
          if FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) then
            DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
          Exit;
        end;

        LKeyDup := fPadR(LQryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                     fPadR(LQryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                     fPadR(LQryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                     fPadR(LQryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

        //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
        LEndereco := RetornaEnderecoENumeroCom40Caracteres(LQryRemessa.FieldByName('ENDERE').AsString, LQryRemessa.FieldByName('NUMERO').AsString);

        LCodOco := LQryRemessa.FieldByName('CBI_CODOCO').AsString;
        if fEmptyStr(LCodOco) then
          LCodOco := '01';

        LCgcEmp := Trim(LCgcEmp);
        LCgcEmp := AnsiReplaceStr(LCgcEmp, '.', '');
        LCgcEmp := AnsiReplaceStr(LCgcEmp, '/', '');
        LCgcEmp := AnsiReplaceStr(LCgcEmp, '-', '');

        LCgcCli := Trim(LQryRemessa.FieldByName('CBI_C_G_C_').AsString);
        LCgcCli := AnsiReplaceStr(LCgcCli, '.', '');
        LCgcCli := AnsiReplaceStr(LCgcCli, '/', '');
        LCgcCli := AnsiReplaceStr(LCgcCli, '-', '');

        LValDup := LQryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        if fCfgSis('VALIMP', varBoolean) then
        begin
          LValDup := LValDup +
            LQryRemessa.FieldByName('CTR_JURSUJ').AsFloat +
            LQryRemessa.FieldByName('CTR_DESCOB').AsFloat;
        end;

        LDescontoSugerido := LQryRemessa.FieldByName('CBI_DESSUJ').AsFloat;

        if fCfgSis('DESBOL', varBoolean) then
        begin
          LValDup := fFormataFloat((LValDup - LQryRemessa.FieldByName('CTR_DESSUJ').AsFloat),2);
          LDescontoSugerido := 0.00;
        end;

        if LUsaDesPonCli And LUsaDesPon then
        begin
          LValDpo := ((LQryRemessa.FieldByName('CBI_VALDUP').AsFloat) * (LQryRemessa.FieldByName('CLI_PERDPO').AsFloat / 100));

          if LValDpo > 0 then
          begin
            LDtaDpo := LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime - LQryRemessa.FieldByName('CLI_QTDDAV').AsInteger;
            LDtaDpoFormatada := FormatDateTime('ddmmyy', LDtaDpo);
          end
          else
            LDtaDpoFormatada := '0';
        end
        else if LUsaCnd And LUsaDesPon then
        begin
          LValDpo := ( (LQryRemessa.FieldByName('CBI_VALDUP').AsFloat ) * (LQryRemessa.FieldByName('CND_PERDPO').AsFloat / 100 ) );

          if LValDpo > 0 then
          begin
            LDtaDpo := LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime - LQryRemessa.FieldByName('CND_QTDDAV').AsInteger;
            LDtaDpoFormatada := FormatDateTime('ddmmyy', LDtaDpo);
          end
          else
            LDtaDpoFormatada := '0';
        end
        else
        begin
          LValDpo := 0;
          LDtaDpoFormatada := '0';
        end;

        {*******************************************}
        {* SE BANCO EMITE BOLETO                   *}
        {****************************************MV*}
        LNosNum := LQryRemessa.FieldByName('CBI_NOSNUM').AsString;
        if (LRespon = '1') then
          LNosNum := '0';

        if FTipoCobranca = 'S' then
        begin
          LIdeEmp := '0'                    + //021
                       RightStr(fStrZero(LCodCar, 3), 3) + //022
                       RightStr(fStrZero(LCodAge, 5), 5) + //025
                       RightStr(fStrZero(LCntCor, 7), 7) + //030
                       RightStr(fStrZero(LDigCnt, 1), 1);  //037

           LTransacao := fPadR     ('1'                                       , 01)      + //001
                          fStrZero   ('0'                                       , 05)      + //002
                          fStrZero   ('0'                                       , 01)      + //007
                          fStrZero   ('0'                                       , 05)      + //008
                          fStrZero   ('0'                                       , 07)      + //013
                          fStrZero   ('0'                                       , 01)      + //020
                          fPadR      (LIdeEmp                                 , 17)      + //021
                          fPadR      (LKeyDup                                 , 25)      + //038
                          fPadR      ('000'                                     , 03)      + //063
                          fPadR      (IIF(LPerMul > 0, '2', '0')              , 01)      + //066 (2) P\ CONSIDERAR O PERCENTUAL DE MULTA
                          fValNumForm(LPerMul                                 , 04)      + //067 PERCENTUAL DE MULTA A SER CONSIDERADO
                          fStrZero   (LNosNum                                 , 12)      + //071
                          fStrZero   ('0'                                       , 10)      + //083
                          fPadR      (LRespon                                 , 01)      + //093
                          fPadR      (' '                                       , 01)      + //094
                          fPadR      (' '                                       , 10)      + //095
                          fPadR      (' '                                       , 01)      + //105
                          fPadR      ('2'                                       , 01)      + //106
                          fPadR      (' '                                       , 02)      + //107
                          fPadR      (LCodOco                                 , 02)      + //109
                          fPadR      (RightStr(LNumDup, 10)                   , 10)      + //111
                          fPadR      (LDtaVen                                 , 06)      + //121
                          fValNumForm(LValDup                                 , 13)      + //127
                          fStrZero   ('0'                                       , 03)      + //140
                          fStrZero   ('0'                                       , 05)      + //143
                          fPadR      ('01'                                      , 02)      + //148
                          fPadR      ('N'                                       , 01)      + //150
                          fPadR      (LDtaEmi                                 , 06)      + //151
                          fPadR      (LInstru1                                , 02)      + //157
                          fPadR      (LDiaPro                                 , 02)      + //159
                          fValNumForm(LValAtr                                 , 13)      + //161
                          fPadR(IIF(LValDpo > 0, LDtaDpoFormatada, IIF(LDescontoSugerido > 0, LDtaVen, '0')), 06, '0')  + //174
                          IIF(LValDpo > 0, fValNumForm(LValDpo, 13), fValNumForm(LDescontoSugerido, 13))     + //180
                          fStrZero   ('0'                                       , 13)      + //193
                          fStrZero   ('0'                                       , 13)      + //206
                          fStrZero   (LCpfCgc                                 , 02)      + //219
                          fPadL      (LCgcCli                                 , 14, '0') + //221
                          fPadR      (LQryRemessa.FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                          fPadR      (LEndereco                              , 40)      + //275
                          fPadR      (' '                                       , 12)      + //315
                          fPadL      (LeftStr(LQryRemessa.FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                          fPadL      (RightStr(LQryRemessa.FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                          fPadR      (IIF(LUsaSac = 'S', LSacAva, LObserv)           , 60)      + //335
                          fStrZero   (IntToStr(LCodSeq)                       , 06);       //395

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(LTexto,LTransacao);

        end
        else
        begin

          LIdeEmp := '0000'                 + //021
                       '070'                  + //022
                       fStrZero(LCodAge, 5) + //025
                       fStrZero(LCntCor, 7) + //030
                       fStrZero(LDigCnt, 1);  //037

          LTransacao := fPadR      ('1'                                       , 01)      + //001
                          fStrZero   ('02'                                      , 02)      + //002
                          fStrZero   (LCgcEmp                                 , 14)      + //004
                          fStrZero   (LIdeEmp                                 , 20)      + //018
                          fPadR      (' '                                       , 25)      + //038
                          fStrZero   ('0'                                       , 08)      + //063
                          fStrZero   ('0'                                       , 12)      + //071
                          fStrZero   ('0'                                       , 10)      + //083
                          fPadR      (' '                                       , 16)      + //093
                                      '11'                                                 + //109
                          fPadR      (RightStr(LNumDup, 10)                   , 10)      + //111
                          fPadR      (LDtaVen                                 , 06)      + //121
                          fValNumForm(LValAtr                                 , 13)      + //127
                          fPadR      (' '                                       , 08)      + //140
                                      '01'                                                 + //148
                          fPadR      (' '                                       , 01)      + //150
                          fStrZero   ('0'                                       , 68)      + //151
                          fStrZero   (LCpfCgc                                 , 02)      + //219
                          fPadL      (LCgcCli                                 , 14, '0') + //221
                          fPadR      (LQryRemessa.FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                          fPadR      (LEndereco                              , 40)      + //275
                          fPadR      (' '                                       , 12)      + //315
                          fPadL      (LeftStr(LQryRemessa.FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                          fPadL      (RightStr(LQryRemessa.FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                          fPadR      (IIF(LUsaSac = 'S', LSacAva, LObserv)           , 60)      + //335
                          fStrZero   (IntToStr(LCodSeq)                       , 06);       //395

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(LTexto,LTransacao);

        end;

        LTrans2 := '';

        if (LEnvMsg = 'S') And
           (LQryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') And
           (LRespon = '1') then
        begin
          Inc(LCodSeq);

          LObsAgr := fRetornaListaDuplicatasAgrupadas(LQryRemessa.FieldByName('CBI_NUMDUP').AsString, LEmpAgr, LCodCli);
          LCcDigito := LCntCor + LDigCnt;

          LTrans2 := '2'                                + //001 - 001
                       fPadR(LObsAgr             , 320) + //002 - 321
                       fPadR('0' , 006             , '0') + //322 - 327
                       fPadL('0' , 013             , '0') + //328 - 340
                       fPadR('0' , 006             , '0') + //341 - 346
                       fPadL('0' , 013             , '0') + //347 - 359
                       fPadR(' '                   , 007) + //360 - 366
                       fPadL(LCodCar, 003        , '0') + //367 - 369
                       fPadL(LCodAge, 005        , '0') + //370 - 374
                       fPadL(LCcDigito, 008      , '0') + //375 - 382
                       fPadL(LNosNum, 012        , '0') + //383 - 394
                       fStrZero(IntToStr(LCodSeq), 06);   //395 - 400

          Writeln(LTexto,LTrans2);
        end;

        {************************************}
        {* QUANDO UTILIZAR SACADOR/AVALISTA *}
        {*********************************AJ*}
        if LUsaSac = 'S' then
        begin
          Inc(LCodSeq);

          LTrans7 := fPadR('7'                    , 001) + //001 - 001
                       fPadR(LSacEnd              , 045) + //001 - 046
                       fPadL(LSacCEP, 008         , '0') + //047 - 054
                       fPadR(LSacCid              , 020) + //055 - 074
                       fPadR(LSacEst              , 002) + //075 - 076
                       fPadL(' '                    , 290) + //077 - 366
                       fPadL(LCodCar, 003         , '0') + //367 - 369
                       fPadL(LCodAge, 005         , '0') + //370 - 374
                       RightStr(fStrZero(LCntCor, 7), 7) +
                       RightStr(fStrZero(LDigCnt, 1), 1) +
                       fPadL(LNosNum, 012         , '0') + //383 - 394
                       fStrZero(IntToStr(LCodSeq) , 006);  //395 - 400
          Writeln(LTexto,LTrans7);
        end;

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMDET *}
        {**** DETALHES DA REMESSA ****}
        {**************************MO*}
        pGravaRemDet(LAutoIncremRem,
                     LQryRemessa.FieldByName('AUTOINCREM').AsString,
                     LNosNum,
                     LPerMul,
                     LQryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                     LQryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                     LQryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                     VS_Date,
                     strLoginUsuarioLogado,
                     '',
                     LQryRemessa.FieldByName('CBI_PROTES').AsString);

        if fCfgSis('UTICRM', varBoolean) And (not fEmptyStr(fCfgSis('OCOFIN', varString)))  then
        begin
          TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(LQryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                                   LQryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                                   LQryRemessa.FieldByName('CBI_CODEMP').AsString,
                                                   LQryRemessa.FieldByName('CBI_CODCLI').AsString,
                                                   LQryRemessa.FieldByName('CBI_PARCEL').AsString,
                                                   strLoginUsuarioLogado,
                                                   fRetCgcCpf(LQryRemessa.FieldByName('CBI_CODCLI').AsString),
                                                   afcEnviaDuplicataBanco);
        end;

        if LUtilizaAlpe then
        begin
          if LCodOco = '01' then
            pAtualizaDadosCadRecAlpe(
              LQryRemessa.FieldByName('AUTOINCREM').AsString,
              LPercentualAlpe,
              LTaxaTedAlpe,
              LDataAlpe);
        end;

        LQryRemessa.Next;
      end;

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(LCodSeq);
      LTrailler := '';
      LTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(LCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(LTexto,LTrailler);

      CloseFile(LTexto);

      pDeletaCadCbi(LCodBco, LCartei, edtCodPor.Text);

      pBackupCnfBco;

      if fCommit then
      begin
        pGravaLogCtr(LQryRemessa);

        fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                  'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

        if LUtilizaAlpe then
        begin
          if (fMensagem('ATENÇÃO','Deseja realizar o envio do arquivo remessa para Alpe?',['&SIM', '&NÃO'], 1) = 1) then
          begin
            TfrmGravando.fExecutarModalA(EnviarArquivoRemessaParaAlpe,'Aguarde, Enviando arquivo remessa para a Alpe.', '');
          end;
        end;

        if LUtilizaExtrant then
        begin
          if (fMensagem('ATENÇÃO','Deseja realizar o envio do arquivo remessa para a Extrant?',['&SIM', '&NÃO'], 1) = 1) then
          begin
            FDadosExtrant.FQueryRemessa := LQryRemessa;
            FDadosExtrant.FAutoIncremRemGer := LAutoIncremRem;
            TfrmGravando.fExecutarModalA(pEnviarArquivoRemessaParaExtrant,'Aguarde, Enviando arquivo remessa para a Extrant.', '');
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        fRollBack;

        try
          CloseFile(LTexto);
        except
          //Caso o erro acontecer após o arquivo já estiver fechado
        end;

        if FileExists(LFilePath) then
          DeleteFile(LFilePath);

        Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco 981 - Capital Finanças' + #13 +
                               'Erro gerado: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(LQryRemessa);
    FreeAndNil(LQryConsultaGen);
  end;
end;

procedure TfrmExpArqRemCapitalFinancas.edtCodPorExit(Sender: TObject);
begin
  inherited;
  if (fEmptyStr(edtCodPor.Text)) then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCapitalFinancas.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    end;
  end;
end;

procedure TfrmExpArqRemCapitalFinancas.EnviarArquivoRemessaParaAlpe;
  var
    LBoletoAlpe : TBoletoAlpe;
    LNomeArquivo : String;
begin
  try
    LBoletoAlpe := TBoletoAlpe.Create;
    LNomeArquivo := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
    LBoletoAlpe.EnviarArquivoRemessa(LNomeArquivo);
  finally
    FreeAndNil(LBoletoAlpe);
  end;
end;

procedure TfrmExpArqRemCapitalFinancas.pEnviarArquivoRemessaParaExtrant;
  var
    LNomeArquivo: String;
    LNomePasta:String;
    LArquivoStream: TStringStream;
    LGravando: TfrmGravando;
begin
  try
    FEnviarRemessaExtrant := TEnviaRemessaExtrant.Create;

    if not FEnviarRemessaExtrant.Conectado then
    begin
      fMensagem('ATENÇÃO!', 'Não foi possível realizar a conexão no servidor FTP!' +#13#10+
                            'Verifique se o servidor está online, se está com o firewall liberado '+#13#10+
                            'e se suas credencias de acesso são validas.', ['&Ok']);
      Exit;
    end;


    LNomeArquivo := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
    LNomePasta := '/' + ExtractFileName(LNomeArquivo);
    LNomePasta := LNomePasta.Replace(ExtractFileExt(LNomeArquivo),'');

    if not FEnviarRemessaExtrant.CriarPasta(LNomePasta) then
    begin
      fMensagem('ATENÇÃO!', 'Não foi possível criar a pasta de destino no servidor FTP!' +#13#10+
                            'Verifique as permissões do usuário.', ['&Ok']);
      Exit;
    end;


    try
      LArquivoStream := TStringStream.Create;
      LArquivoStream.LoadFromFile(LNomeArquivo);

      if not FEnviarRemessaExtrant.EnviarArquivo(LArquivoStream,LNomePasta +'/'+ ExtractFileName(LNomeArquivo)) then
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível enviar o arquivo remessa para o servidor FTP!' +#13#10+
                              'Verifique as permissões do usuário.', ['&Ok']);
        Exit;
      end;

      FEnviarRemessaExtrant.MarcarArquivoComoEnviado(FDadosExtrant.FAutoIncremRemGer);
    finally
      FreeAndNil(LArquivoStream);
    end;

    try
      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.fExecutarAcao := fEnviarXMLDaNotaParaExtrant;
      LGravando.lblGravando.Caption := 'Aguarde... Enviando XML da(s) nota(s).';
      LGravando.ShowModal;
    finally
      FreeAndNil(LGravando);
    end;

    fMensagem('ATENÇÃO!', 'Arquivos enviados com sucesso!', ['&Ok']);
  finally
    FreeAndNil(FEnviarRemessaExtrant);
  end;
end;

function TfrmExpArqRemCapitalFinancas.fEnviarXMLDaNotaParaExtrant(APgbProgresso: TcxProgressBar): Boolean;
var
  LNomeArquivo,
  LNomePasta,
  LMsgDialogo: String;
  LArquivoStream: TStringStream;
  LListaNotas : TStringList;
begin
  Result := True;
  try
    LNomeArquivo := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
    LNomePasta := '/' + ExtractFileName(LNomeArquivo);
    LNomePasta := LNomePasta.Replace(ExtractFileExt(LNomeArquivo),'');
    LListaNotas := TStringList.Create;

    APgbProgresso.Position := 0;
    APgbProgresso.Properties.Max := FDadosExtrant.FQueryRemessa.RecordCount;

    FDadosExtrant.FQueryRemessa.First;
    while not FDadosExtrant.FQueryRemessa.Eof do
    begin
      if fEmptyStr(FDadosExtrant.FQueryRemessa.FieldByName('NFE_ARQXML').AsString) then
      begin
        FDadosExtrant.FQueryRemessa.Next;
        pStepStatus(APgbProgresso);
        Continue;
      end;

      if (LListaNotas.IndexOf(FDadosExtrant.FQueryRemessa.FieldByName('FIS_ACESSO').AsString) > 0) then
      begin
        untLogCtr.GravaLogCtr(
          FDadosExtrant.FQueryRemessa.FieldByName('AUTOINCREM').AsString,
          'ENVIO do XML DA NOTA - EXTRANT (AUTBAN)',
          Self.Name);

        FDadosExtrant.FQueryRemessa.Next;
        pStepStatus(APgbProgresso);
        Continue;
      end;

      try
        LArquivoStream := TStringStream.Create(FDadosExtrant.FQueryRemessa.FieldByName('NFE_ARQXML').AsString);
        LNomeArquivo := Concat(FDadosExtrant.FQueryRemessa.FieldByName('FIS_ACESSO').AsString,'.xml');

        if not FEnviarRemessaExtrant.EnviarArquivo(LArquivoStream,LNomePasta +'/'+ LNomeArquivo) then
        begin
          LMsgDialogo :=
            'Não foi possível enviar o XML da nota '+
                  FDadosExtrant.FQueryRemessa.FieldByName('CBI_NUMDUP').AsString +
                  FDadosExtrant.FQueryRemessa.FieldByName('CBI_PARCEL').AsString +
                  FDadosExtrant.FQueryRemessa.FieldByName('CBI_ESPDOC').AsString +
            '-' + FDadosExtrant.FQueryRemessa.FieldByName('CBI_CODEMP').AsString +#13#10+
               'para o servidor FTP!' +#13#10+
               'Deseja continuar com o envio das outras notas?';

          if fMensagem('ATENÇÃO!', LMsgDialogo, ['&Sim', '&Não'], 1) = 2 then
            Break;

          FDadosExtrant.FQueryRemessa.Next;
          pStepStatus(APgbProgresso);
          Continue;
        end;

      finally
        FreeAndNil(LArquivoStream);
      end;

      untLogCtr.GravaLogCtr(
        FDadosExtrant.FQueryRemessa.FieldByName('AUTOINCREM').AsString,
        'ENVIO do XML DA NOTA - EXTRANT (AUTBAN)',
        Self.Name);
      LListaNotas.Add(FDadosExtrant.FQueryRemessa.FieldByName('FIS_ACESSO').AsString);
      FDadosExtrant.FQueryRemessa.Next;
      pStepStatus(APgbProgresso);
    end;
  finally
    FreeAndNil(LListaNotas);
  end;
end;

function TfrmExpArqRemCapitalFinancas.fRetornaEmpresa: String;
var
  LContador: Integer;
  LArrResult: Array Of String;
  LQryCadEmp: TUniQuery;
begin
  LQryCadEmp := fCriaQuery(Self);
  try
    LQryCadEmp.SQL.Add('SELECT * FROM CADEMP ORDER BY EMP_CODEMP');
    LQryCadEmp.Open;
    LQryCadEmp.First;

    SetLength(LArrResult, LQryCadEmp.RecordCount);
    LContador := 0;

    while not LQryCadEmp.Eof do
    begin
      LArrResult[LContador] := fStrZero(
        LQryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' +
        LQryCadEmp.FieldByName('EMP_NOMEMP').AsString;
      LQryCadEmp.Next;
      Inc(LContador);
    end;

    LContador := 1;

    if Length(LArrResult) > 1 then
      LContador := fGetMenu('Selecione a Empresa', LArrResult, 0);

    Result   := LeftStr(LArrResult[LContador -1], 3);
  finally
    FreeAndNil(LQryCadEmp);
  end;
end;

function TfrmExpArqRemCapitalFinancas.fValidaCampos(ASender: TWinControl; ABuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (inherited fValidaCampos(ASender, ABuscaPorChave)) then
  begin
    if (ASender = edtCodPor) then
    begin
      if not fEmptyStr(edtCodPor.Text) then
      begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        if not CarregaPortador(edtCodPor.Text) then
           Result := False
        else
        if fEmptyStr(edtDesPor.Text) then
        begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        end
        else if not fEmpresaTemAcessoPortador(edtCodPor.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        end
        else if fCfgSis('DACPOR', varBoolean) then
        begin
          if Pos(edtCodPor.Text, strPortadoresOperador) <= 0 then
          begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          end;
        end;
      end;
    end
  end;

  if not Result then
    pSetFocus(ASender);
end;

function TfrmExpArqRemCapitalFinancas.fRetornaIdentificacaoBoletoExtrant: String;
begin
  Result := '';

  if FDadosExtrant.FQueryRemessa.FieldByName('CBI_ESPDOC').AsString.Equals('NS') then
    Result := 'ROY'  {BOLETOS DE ROYALTIES (ROY) - NS}
  else if FDadosExtrant.FQueryRemessa.FieldByName('CBI_ESPDOC').AsString.Equals('ND') then
    Result := 'TAXP' {TAXA DE PUBLICIDADE (TAXP) - ND}
  else if FDadosExtrant.FQueryRemessa.FieldByName('CBI_ESPDOC').AsString.Equals('NF') then
    Result := 'COB'; {COBRANÇA (COB)             - NF}
end;

function TfrmExpArqRemCapitalFinancas.fRetornaNomeBoletoExtrant: String;
begin
  Result :=
    FDadosExtrant.FQueryRemessa.FieldByName('CBI_C_G_C_').AsString +
    FDadosExtrant.FQueryRemessa.FieldByName('CBI_NUMDUP').AsString +
    fRetornaIdentificacaoBoletoExtrant + '.pdf';
end;

procedure TfrmExpArqRemCapitalFinancas.pStepStatus(APgbStatus: TcxProgressBar);
begin
  if Assigned(APgbStatus) then
  begin
    APgbStatus.Position := APgbStatus.Position + 1;
    Application.ProcessMessages;
  end;
end;

end.
