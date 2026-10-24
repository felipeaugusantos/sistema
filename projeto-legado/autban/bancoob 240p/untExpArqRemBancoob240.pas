unit untExpArqRemBancoob240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa, dxScreenTip,
  cxClasses, dxCustomHint, cxHint;

type
  TfrmExpArqRemBancoob240 = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    HintControler: TcxHintStyleController;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pnlInfoMouseLeave(Sender: TObject);
    procedure pnlInfoMouseEnter(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    function RetornaCodigoMulta:String;
    procedure ShowHint(APanel: TPanel; ATitulo: String);
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBancoob240: TfrmExpArqRemBancoob240;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemBancoob240.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'PATHREM',''));
  If fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'USACRR_','') <> 'S' Then
    edtNomArquivo.Text  := 'RM' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) +
                           fStrZero(FormatDateTime('yy',VS_Date),2) +
                           '.TXT'
  Else
    edtNomArquivo.Text  := 'CBR' +
                           fStrZero(FormatDateTime('yyyy',VS_Date),4) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'SEQRMBB','') +
                           '.REM';
  pSetFocus(edtCodPor);

  fraCheckComboBoxEmpresa.chkcbEmpresaFocusChanged(fraCheckComboBoxEmpresa.chkcbEmpresa);
  fraCheckComboBoxEmpresa.SelecionaEmpresaLogada(fGetBancoConfig(0,'CONFIG756_240p', 'RELOCAL', '') = 'S');


  If (fCfgSis('CONREM', varString) = 'C') Then
  Begin
    pnlInfo.Caption := 'Carteira: ' + intCartei.ToString + ' Empresa: ' + VS_strCodEmp;
  End;
end;

procedure TfrmExpArqRemBancoob240.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;

    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strCodCar  : String;
    strCodCop  : String;
    strDigCop  : String;
    strCtaCor  : String;
    strDigCor  : String;
    strCodCed  : String;
    strDigCed  : String;
    strNomCed  : String;
    strNumCon  : String;
    strConCli  : String;
    strDiasProt: String;
    strInstProt: String;
    strDiasCred: String;
    strProAce  : String;
    strResp    : String;
    strCodPor  : String;
    strCtaBai  : String;
    strInstru1 : String;
    strInstru2 : String;
    strObs001  : String;
    strObs002  : String;
    strObs003  : String;
    strObs004  : String;
    strObs005  : String;
    strComand  : String;
    strModali  : String;
    strNosNum  : String;
    strParcel  : String;

    strDtaRem   : String;
    strHorRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strDtaJur   : String;

    strAgenCob : String;
    strCodRem  : String;

    strHeader   : String;
    strHeLote   : String;
    strTransacao: String;
    strTrailler : String;
    strTrLote   : String;

    strCgcEmp   : String;
    strCpfCgc   : String;

    strKeyDup   : String;
    strSeuNum   : String;
    strCgcCli,
    strCodProt  : String;

    intCodSeq   : Integer;
    LQuantidadeTitulos: Integer;
    intSeqCrr   : Integer;

    fltValAtr   : Double;
    fltTotRem   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    strPerMul,
    strEspDoc   : String;
    fltPerMul   : Double;
    dtaDtaJur   : TDateTime;
    blnUsaCrr   : Boolean;
    strDtaLimRec: String;
    dtaDtaclcLimRec: TDateTime;

    strPerJur   : String;
    strDatMul   : String;
    dtaDtaMul   : TDateTime;
    fltPerJur   : Double;
    strDtaMul   : String;
    strDiaMora  : string;
    strCartSeq  : String;
    strCodOco   : String;
    strDiaLimRec: string;

    strCodBcoResp,
    strNossoNumResp: String;

    strFilePath : String;
    strCartei : String;
    strAutoIncremRem: String;

    fltValDup : Double;

    strEnviarSacador: String;
    strchkcbEmp : String;
    AstrEndereco   : String;
    LMsgErro: String;
    LCodigoMulta: String;
    LDataDesconto: String;
    LDataDescontoDpo: String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;

    strTpDesc       : String;

    LDescontoSugerido : Double;

    strDiasbaixa : String;

    procedure pGravaLogctr;
    begin
      qryRemessa.DisableControls;
      qryRemessa.First;
      While Not qryRemessa.Eof Do
      Begin
        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

        qryRemessa.Next;
      End;
    end;

begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido para exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  LMsgErro       := '';
  strCodBco      := '756';
  strNomBco      := 'Bancoob240';
  strNomEmp      := fRetNomeEmpresa(VS_strCodEmp);
  strCodCar      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODCART', '');
  strCodCop      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODCOPE', '');
  strDigCop      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIGCOPE', '');
  strCodCed      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCed      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIGCEDE', '');
  LCodigoMulta   := RetornaCodigoMulta;
  strNomCed      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'NOMCEDE', '');
  blnUsaCrr      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'USACRR_', '') = 'S';
  strDiaMora     := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIAMORA', '');
  strEspDoc      := Copy(fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'ESPDOC_', '02'), 1, 2);

  strEnviarSacador := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'ENVSACA', 'S');

  If Not blnUsaCrr Then
  Begin
    strNumCon      := '';
    intSeqCrr      := 0;
  End
  Else
  Begin
    strNumCon      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CONVCRR', '');
    intSeqCrr      := StrToIntDef(fGetBancoConfig(0,'CONFIG756_240p-' + IntToStr(intCartei),'SEQRMBB',''), 0);
  End;

  strConCli      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CONVCLI', '');
  strDiasProt    := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIAPROT', '');
  strDiasCred    := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIACRED', '');
  strDiaLimRec   := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIALIMR', '');
  strProAce      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'PROACEI', '');
  strResp        := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'RESPONS', '');
  strCodPor      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'PORBAI_', '');
  strCtaBai      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CTABAI_', '');
  strInstru1     := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2     := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'INSTRU2', '');
  strCodProt     := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODPROT', '');
  blnRemLoc      := Not( fGetBancoConfig(0, 'CONFIG756_240p', 'RELOCAL', '') = 'N' );
  strAgenCob     := IIF(strCodCar = '5', strAgenCob,'00000');

  strDiasbaixa   := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIASBAI', '');

  If Not FEmptyStr(strDiasbaixa) Then
     strDiasbaixa := fPadL(strDiasbaixa, 03, '0');

  If StrToIntDef(strDiasProt, 0) <> 0 Then
    strInstProt := '1'
  Else
    strInstProt := '0';

  strDtaRem      := FormatDateTime('dd', VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);

  strHorRem      := FormatDateTime('HH', fTime()) + FormatDateTime('NN', fTime()) + FormatDateTime('SS', fTime());

  strObs001      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs003      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs004      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'OBSERV4', '');
  strObs005      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'OBSERV5', '');
  strComand      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'COMANDO', '');
  strModali      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'MODALID', '');
  strPerMul      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'PERMULT', '');
  strCtaCor      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODCCOR', '');
  strDigCor      := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'DIGCCOR', '');
  strPerJur      := fGetBancoConfig(0, 'CONFIG756_240p', 'JUROSDI', '');


  If fEmptyStr(strPerMul) Then
    strPerMul := '0';

  If fEmptyStr(strPerJur) Then
    strPerJur := '0,00';

  if strCodProt = '' then
     strCodProt := '3';

  if (Pos(strCodProt,'3_8_9_') > 0) then
    strDiasProt := '0';


  fltPerMul := fStrToFloat(strPerMul);
  If fltPerMul = 0 Then
    LCodigoMulta := '0';

  fltPerJur := fStrToFloat(strPerJur);

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei  := 'CONFIG756_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  R.CTR_PERDPO AS CTR_PERDPO, ';
    strSQL := strSQL + '  R.CTR_QTDDAV AS CTR_QTDDAV, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  SUM(R.CTR_DESSUJ) AS CTR_DESSUJ, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO  AND   ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND B.CBI_CODOCO = "01") OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02"))';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI ' ;

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'SEQCART', '');
      If Not blnUsaCrr Then
        strCodRem      := fStrZero(fAtuCodSeq('CONFIG756_240p-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), IIF(strCodCar = '1', 6, 7))
      Else
        strCodRem      := fStrZero(fAtuCodSeq('CONFIG756_240p-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 8);
      pAtualizaProxNumCartsAutBan('CONFIG756_240p-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************JU*}
      strHeader := '';

      If (Not blnUsaCrr) or (strResp = 'B') Then
        strHeader := fPadR   ('756'              , 003) + //001 - 003  [01]
                     fPadR   ('0000'             , 004) + //004 - 007  [02]
                     fPadR   ('0'                , 001) + //008 - 008  [03]
                     fPadR   (' '                , 009) + //009 - 017  [04]
                     fPadR   ('2'                , 001) + //018 - 018  [05]
                     fPadR   (strCgcEmp          , 014) + //019 - 032  [06]
                     fPadR   (strNumCon          , 020) + //033 - 052  [07]
                     fStrZero(strCodCop          , 005) + //053 - 057  [08]
                     fPadR   (strDigCop          , 001) + //058 - 058  [09]
                     fStrZero(strCtaCor          , 012) + //059 - 070  [10]
                     fPadR   (strDigCor          , 001) + //071 - 071  [11]
                     fPadR   ('0'                , 001) + //072 - 072  [12]
                     fPadR   (strNomEmp          , 030) + //073 - 102  [13]
                     fPadR   ('SICOOB'           , 030) + //103 - 132  [14]
                     fPadR   (' '                , 010) + //133 - 142  [15]
                     fPadR   ('1'                , 001) + //143 - 143  [16]
                     fPadR   (strDtaRem          , 008) + //144 - 151  [17]
                     fPadR   (strHorRem          , 006) + //152 - 157  [18]
                     fPadR   (strCodRem          , 006) + //158 - 163  [19]
                     fPadR   ('081'              , 003) + //164 - 166  [20]
                     fPadR   ('0'            ,005, '0') + //167 - 171  [21]
                     fPadR   (' '                , 069)   //172 - 240  [22 23 24]
      Else
        strHeader := fPadR   ('756'              , 003) + //001 - 003  [01]
                     fPadR   ('0000'             , 004) + //004 - 007  [02]
                     fPadR   ('1'                , 001) + //008 - 008  [03]
                     fPadL   ('R'                , 001) + //009 - 009  [04]
                     fPadR   ('0'           , 007, '0') + //010 - 016  [05]
                     fPadL   (' '                , 002) + //017 - 018  [06]
                     fStrZero(strCodCop          , 004) + //019 - 022  [07]
                     fPadL   (strCodCed          , 007,   '0') + //023 - 029  [08]
                     fPadL   (strCtaCor + strDigCor, 011, '0') + //030 - 040  [09]
                     fPadR   (' '                , 030) + //041 - 070  [10]
                     fPadR   (strNomEmp          , 030) + //071 - 100  [11]
                     fPadR   (' '                , 080) + //101 - 180  [12]
                     fPadR   (strCodRem          , 008) + //181 - 188  [13]
                     fPadR   (strDtaRem          , 008) + //189 - 196  [14]
                     fPadR   ('0'           , 011, '0') + //197 - 207  [15]
                     fPadR   (' '                , 033);  //208 - 240  [16]

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JU*}
      Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strHeader));

      If (Not blnUsaCrr) or (strResp = 'B') Then
      Begin
        {******************}
        {* HEADER DO LOTE *}
        {***************JU*}
        strHeLote := '';
        strHeLote := fPadR   ('756'              , 003) + //001 - 003  [01]
                     fPadR   ('0001'             , 004) + //004 - 007  [02]
                     fPadR   ('1'                , 001) + //008 - 008  [03]
                     fPadR   ('R'                , 001) + //009 - 009  [04]
                     fPadR   ('01'               , 002) + //010 - 011  [05]
                     fPadR   (' '                , 002) + //012 - 013  [06]
                     fPadR   ('040'              , 003) + //014 - 016  [07]
                     fPadR   (' '                , 001) + //017 - 017  [08]
                     fStrZero('2'                , 001) + //018 - 018  [09]
                     fStrZero(strCgcEmp          , 015) + //019 - 033  [10]
                     fPadR   (strNumCon          , 020) + //034 - 053  [11]
                     fStrZero(strCodCop          , 005) + //054 - 058  [12]
                     fPadR   (strDigCop          , 001) + //059 - 059  [13]
                     fStrZero(strCtaCor          , 012) + //060 - 071  [14]
                     fPadR   (strDigCor          , 001) + //072 - 072  [15]
                     fPadR   (' '                , 001) + //073 - 073  [16]
                     fPadR   (strNomEmp          , 030) + //074 - 103  [17]
                     fPadR   (strObs001          , 040) + //104 - 143  [18]
                     fPadR   (strObs002          , 040) + //144 - 183  [19]
                     fPadR   (strCodRem     , 008, '0') + //184 - 191  [20]
                     fPadR   (strDtaRem          , 008) + //192 - 199  [21]
                     fPadR   ('00000000'         , 008) + //200 - 207  [22]
                     fPadR   (' '                , 033);  //208 - 240  [28]

        {***************************}
        {* ESCREVE O HEADER NO TXT *}
        {************************JU*}
        Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strHeLote));
      End;

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      With qryRemessa Do
      Begin
        strTransacao := '';
        intCodSeq := 0;
        LQuantidadeTitulos := 0;
        fltTotRem := 0;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

          if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
          begin
            fRollBack;
            CloseFile(txtTexto);
            If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
              DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
            Exit;
          end;

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          If ((AstrEndereco.Length + qryRemessa.FieldByName('COMPLEMENTO').AsString.Length) <= 40) Then
            AstrEndereco := AstrEndereco + qryRemessa.FieldByName('COMPLEMENTO').AsString;

          strSeuNum := RightStr(RightStr(FieldByName('CBI_NUMDUP').AsString, 9) +
                                FieldByName('CBI_PARCEL').AsString +
                                FieldByName('CBI_ESPDOC').AsString, 15);

          strCodOco := FieldByName('CBI_CODOCO').AsString;
          if fEmptyStr(strCodOco) Then
            strCodOco := '01';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;

          LDescontoSugerido := qryRemessa.FieldByName('CBI_DESSUJ').AsFloat;

          If fCfgSis('DESBOL', varBoolean) Then
          Begin
            fltValDup := fFormataFloat((fltValDup - qryRemessa.FieldByName('CTR_DESSUJ').AsFloat),2);
            LDescontoSugerido := 0.00;
          End;

          strNosNum := FieldByName('CBI_NOSNUM').AsString;

          strParcel := RetornaNumeroParcela(FieldByName('CBI_PARCEL').AsString);

          If (strParcel = '00') Or
             (strParcel = '0')  Then
            strParcel := '01';

          dtaDtaMul :=  FieldByName('CBI_DTAVEN').AsDateTime;
          dtaDtaMul :=  dtaDtaMul + StrToInt(strDiaMora);

          If strPerMul = '0' Then
            strDtaMul :=  '0'
          Else
            strDtaMul :=  FormatDateTime('dd',dtaDtaMul) +
                          FormatDateTime('mm',dtaDtaMul) +
                          FormatDateTime('yyyy',dtaDtaMul);

          If strPerJur <> '0,00' Then
          begin
            strDtaJur :=  FormatDateTime('dd',dtaDtaMul) +
                          FormatDateTime('mm',dtaDtaMul) +
                          FormatDateTime('yyyy',dtaDtaMul);
          end;

          LDataDesconto := '';

          fltValDpo := qryRemessa.FieldByName('CTR_PERDPO').AsFloat;

          If fltValDpo > 0 Then
          Begin
            LDataDescontoDpo := FormatDateTime('DDMMYYYY',(qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime -
                                                           qryRemessa.FieldByName('CTR_QTDDAV').AsInteger));
          End
          Else
            strDtaDpo := '0';

          strTpDesc := IIF( fltValDpo > 0,'2', IIF(LDescontoSugerido > 0,'1','0') );

          Inc(intCodSeq);
          Inc(LQuantidadeTitulos);
          {************************}
          {* TRANSAÇÃO SEGMENTO P *}
          {*********************JU*}
          If (Not blnUsaCrr) or (strResp = 'B') Then
            strTransacao := fPadR      ('756'                                , 03, ' ') + //001 - 003  [01]
                            fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                            fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                            fPadL      ('P'                                  , 01, ' ') + //014 - 014  [05]
                            fPadL      (' '                                  , 01, ' ') + //015 - 015  [06]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [07]
                            fStrZero   (strCodCop                                 , 05) + //018 - 022  [08]
                            fPadR      (strDigCop                            , 01, ' ') + //023 - 023  [09]
                            fStrZero   (strCtaCor                                 , 12) + //024 - 035  [10]
                            fPadR      (strDigCor                            , 01     ) + //036 - 036  [11]
                            fPadR      (' '                                  , 01, ' ') + //037 - 037  [12]
                            fPadR      (fPadL(IIF(strResp = 'B', '0',strNosNum),10,'0') +
                                        fPadL(strParcel, 02, '0')                       +
                                        strModali                                       +
                                        '4'                                             +
                                        fPadR(' ', 5, ' ')                   , 20, ' ') + //038 - 057  [13]
                            fPadR      ('1'                                  , 01, ' ') + //058 - 058  [14]
                            fPadR      ('0'                                  , 01, ' ') + //059 - 059  [15]
                            fPadR      (' '                                  , 01, ' ') + //060 - 060  [16]
                            fPadR      (IIF(strResp = 'B', '1', '2')         , 01, ' ') + //061 - 061  [17]
                            fPadR      (IIF(strResp = 'B', '1', '2')         , 01, ' ') + //062 - 062  [18]
                            fPadR      (strSeuNum                            , 15, '0') + //063 - 077  [19]
                            fPadR      (strDtaVen                            , 08, ' ') + //078 - 085  [20]
                            fValNumForm(fltValDup                            , 15     ) + //086 - 100  [21]
                            fPadR      ('0'                                  , 05, '0') + //101 - 105  [22]
                            fPadR      (' '                                  , 01, ' ') + //106 - 106  [23]
                            fPadR      (strEspDoc                            , 02, ' ') + //107 - 108  [24]
                            fPadR      (IIF(strProAce = 'S', 'A', 'N')       , 01, ' ') + //109 - 109  [25]
                            fPadR      (strDtaEmi                            , 08, ' ') + //110 - 117  [26]
                            fPadR      (IIF(strPerJur <>  '0,00','2','0')              , 01, ' ') + //118 - 118  [27]
                            fPadR      (IIF(strPerJur <>  '0,00',strDtaJur,'00000000') , 08, ' ') + //119 - 126  [28]
                            fValNumForm(fltPerJur                            , 15     ) + //127 - 141  [29]
                            fPadR      ( strTpDesc, 01, ' ') + //142 - 142  [30]
                            fPadR      ( IIF(fltValDpo > 0,LDataDescontoDpo, IIF(LDescontoSugerido > 0,strDtaVen,'0')), 08, '0') + //143 - 150  [31]
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 15), fValNumForm(LDescontoSugerido, 15)) + //151 - 165  [32]
                            fPadR      ('0'                                  , 15, '0') + //166 - 180  [33]
                            fPadR      ('0'                                  , 15, '0') + //181 - 195  [34]
                            fPadR      (strKeyDup                            , 25, ' ') + //196 - 220  [35]
                            fPadR      (strCodProt                           , 01, ' ') + //221 - 221  [36]
                            fPadL      (strDiasProt                          , 02, '0') + //222 - 223  [37]
                            fPadR      ('0'                                  , 01, ' ') + //224 - 224  [38]
                            fPadR      (IIF(strCodOco = '02',strDiasbaixa,' '), 03, ' ') + //225 - 227  [39]
                            fStrZero   ('9'                                  , 02     ) + //228 - 229  [40]
                            fStrZero   ('0'                                  , 10     ) + //230 - 239  [41]
                            fPadR      (' '                                  , 01, ' ')   //240 - 240  [42]
          Else
            strTransacao := fPadR      ('0'                                  , 07, '0') + //001 - 007  [01]
                            fPadR      ('3'                                       , 01) + //008 - 008  [02]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                            fPadL      ('P'                                  , 01, ' ') + //014 - 014  [05]
                            fPadL      (' '                                  , 01, ' ') + //015 - 015  [06]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [07]
                            fStrZero   (strCodCop                                 , 05) + //018 - 022  [08]
                            fPadR      (strDigCop                            , 01, ' ') + //023 - 023  [09]
                            fStrZero   (strCtaCor                                 , 12) + //024 - 035  [10]
                            fPadR      (strDigCor                            , 01     ) + //036 - 036  [11]
                            fPadR      (' '                                  , 01, ' ') + //037 - 037  [12]
                            fPadR      (fStrZero(strNosNum, 10)                         +
                                        fPadL(strParcel, 02, '0')                       +
                                        strModali                                       +
                                        '4'                                             +
                                        '     '                              , 20, '0') + //038 - 057  [09]
                            fPadR      ('9'                                  , 01)      + //058 - 058  [10]
                            fPadR      (strEspDoc                            , 02)      + //059 - 060  [11]
                            fPadR      (IIF(strResp = 'B', '1', '2')         , 01)      + //061 - 061  [12]
                            fPadR      (' '                                  , 01)      + //062 - 062  [13]
                            fPadR      (strKeyDup                            , 15)      + //063 - 077  [14]
                            fPadR      (strDtaVen                            , 08, ' ') + //078 - 085  [15]
                            fValNumForm(fltValDup                            , 15     ) + //086 - 100  [21]
                            fPadR      ('0'                                  , 06, '0') + //101 - 106  [22]
                            fPadR      (IIF(strProAce = 'S', 'A', 'N')       , 01, ' ') + //107 - 107  [23]
                            fPadR      (' '                                  , 02, ' ') + //108 - 109  [24]
                            fPadR      (strDtaEmi                            , 08, ' ') + //110 - 117  [25]
                            fPadR      (IIF(strPerMul <> '0','3','1')        , 01, ' ') + //118 - 118  [26]
                            fValNumForm(fltPerMul                            , 15     ) + //119 - 133  [27]
                            fPadR      ('0'                                  , 09, '0') + //134 - 142  [28]
                            fPadR      ('000000000'                          , 08, ' ') + //143 - 150  [29]
                            fPadR      ('0'                                  , 15, '0') + //151 - 165  [30]
                            fPadR      (' '                                  , 15, ' ') + //166 - 180  [31]
                            fPadR      ('0'                                  , 15, '0') + //181 - 195  [32]
                            fPadR      (strKeyDup                            , 25, ' ') + //196 - 220  [33]
                            fPadR      (strInstProt                          , 01, ' ') + //221 - 221  [34]
                            fPadL      (strDiasProt                          , 02, '0') + //222 - 223  [35]
                            fPadR      ('0'                                  , 04, '0') + //224 - 227  [36]
                            fStrZero   ('9'                                  , 02     ) + //228 - 229  [37]
                            fPadR      ('0'                                  , 10, '0') + //230 - 239  [38]
                            fPadR      ('0'                                       , 01);  //240 - 240  [39]

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));

          Inc(intCodSeq);

          strCodBcoResp   := '000';
          strNossoNumResp := ' ';

          if (strResp = 'B') then
          begin
            if (blnUsaCrr) then
            begin
              strCodBcoResp := '001';
              strNossoNumResp := '1323739';
            end
            else
              strNossoNumResp := ' ';
          end;

          {************************}
          {* TRANSAÇÃO SEGMENTO Q *}
          {*********************JU*}
          strTransacao := '';
          If (Not blnUsaCrr) or (strResp = 'B') Then
            strTransacao := fPadR      ('756'                                , 03, ' ') + //001 - 003  [01]
                            fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                            fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                            fPadL      ('Q'                                  , 01, ' ') + //014 - 014  [05]
                            fPadL      (' '                                  , 01, ' ') + //015 - 015  [06]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [07]
                            fPadR      (IIF(Length(Trim(strCgcCli)) > 11, '2', '1'), 01)+ //018 - 018  [08]
                            fPadL      (strCgcCli                            , 15, '0') + //019 - 033  [09]
                            fPadR      (RetiraQuebraLinha(FieldByName('CLI_NOMCLI').AsString)   , 40, ' ') + //034 - 073  [10]
                            fPadR      (RetiraQuebraLinha(AstrEndereco)                         , 40, ' ') + //074 - 113  [11]
                            fPadR      (RetiraQuebraLinha(FieldByName('BAIRRO').AsString)       , 15, ' ') + //114 - 128  [12]
                            fPadR      (LeftStr(FieldByName('C_E_P_').AsString, 5), 05) + //129 - 133  [13]
                            fPadR      (RightStr(FieldByName('C_E_P_').AsString,3), 03) + //134 - 136  [14]
                            fPadR      (RetiraQuebraLinha(FieldByName('CIDADE').AsString)       , 15, ' ') + //137 - 151  [15]
                            fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //152 - 153  [16]
                            fPadL      (IIF(strEnviarSacador = 'S', '2', '0'), 01, '0') + //154 - 154  [17]
                            fPadL      (IIF(strEnviarSacador = 'S',
                                            strCgcEmp, '0')                  , 15, '0') + //155 - 169  [18]
                            fPadR      (IIF(strEnviarSacador = 'S',
                                            strNomEmp, ' ')                  , 40, ' ') + //170 - 209  [19]
                            fPadL      (strCodBcoResp                        , 03, '0') + //210 - 212  [20]
                            fPadR      (strNossoNumResp                      , 20, ' ') + //213 - 232  [21]
                            fPadR      (' '                                  , 08, ' ')   //233 - 240  [22]
          Else
            strTransacao := fPadR      ('0'                                  , 07, '0') + //001 - 007  [01]
                            fPadL      ('3'                                  , 01, ' ') + //008 - 008  [02]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [03]
                            fPadL      ('Q'                                  , 01, ' ') + //014 - 014  [04]
                            fPadL      (' '                                  , 01, ' ') + //015 - 015  [05]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [06]
                            fPadR      (IIF(Length(Trim(strCgcCli)) > 11, '02', '01'), 02)+ //018 - 019  [07]
                            fPadL      (strCgcCli                            , 14, '0') + //020 - 033  [08]
                            fPadR      (RetiraQuebraLinha(FieldByName('CLI_NOMCLI').AsString)   , 40, ' ') + //034 - 073  [09]
                            fPadR      (RetiraQuebraLinha(AstrEndereco)                         , 40, ' ') + //074 - 113  [10]
                            fPadR      (RetiraQuebraLinha(FieldByName('BAIRRO').AsString)       , 15, ' ') + //114 - 128  [11]
                            fPadR      (LeftStr(FieldByName('C_E_P_').AsString, 5), 05) + //129 - 133  [12]
                            fPadR      (RightStr(FieldByName('C_E_P_').AsString,3), 03) + //134 - 136  [13]
                            fPadR      (RetiraQuebraLinha(FieldByName('CIDADE').AsString)       , 15, ' ') + //137 - 151  [14]
                            fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //152 - 153  [15]
                            fPadL      (IIF(Length(strCgcEmp) > 11,'02','01'), 02) + //154 - 155  [16]
                            fPadL      (strCgcEmp                            , 14, '0') + //156 - 169  [17]
                            fPadR      (' '                                  , 40, ' ') + //170 - 209  [18]
                            fPadR      (' '                                  , 31, ' ') ; //213 - 240  [19]

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));


          strDtaLimRec    := '00000000';
          dtaDtaclcLimRec := 0;

          {*** Data Limite ***}
          If (strResp = 'E') Then
          Begin

            If (strInstru1 = '19') And ((Not fEmptyStr(strDiaLimRec)) And ( (StrToInt(strDiaLimRec) > 0))) Then
            Begin
               dtaDtaclcLimRec := FieldByName('CBI_DTAVEN').AsDateTime + StrToInt(strDiaLimRec);

               strDtaLimRec := FormatDateTime(  'dd',dtaDtaclcLimRec) +
                               FormatDateTime(  'mm',dtaDtaclcLimRec) +
                               FormatDateTime('yyyy',dtaDtaclcLimRec);
            End
            Else
               strDtaLimRec := '00000000';

          End;

          If (Not blnUsaCrr) or (strResp = 'B') Then
          Begin
            Inc(intCodSeq);
            {************************}
            {* TRANSAÇÃO SEGMENTO R *}
            {*********************JU*}
            strTransacao := '';
            strTransacao := fPadR      ('756'                                , 03, ' ') + //001 - 003  [01]
                            fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                            fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                            fPadL      ('R'                                  , 01, ' ') + //014 - 014  [05]
                            fPadR      (' '                                  , 01, ' ') + //015 - 015  [06]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [07]
                            fPadR      ('0'                                  , 01, '0') + //018 - 018  [08]
                            fPadL      ('0'                                  , 08, '0') + //019 - 026  [09]
                            fPadL      ('0'                                  , 15, '0') + //027 - 041  [10]
                            fPadR      ('0'                                  , 01, '0') + //042 - 042  [11]
                            fPadL      ('0'                                  , 08, '0') + //043 - 050  [12]
                            fPadL      ('0'                                  , 15, '0') + //051 - 065  [13]
                            fPadL      (IIF(strPerMul <> '0',LCodigoMulta,'0') , 01, ' ') + //066 - 066  [14]
                            fPadR      (IIF(LCodigoMulta <> '0', strDtaMul, '00000000')    , 08, '0') + //067 - 074  [15]
                            fValNumForm(fltPerMul                            , 15     ) + //075 - 089  [16]
                            fPadL      (' '                                  , 10, ' ') + //090 - 099  [17]
                            fPadR      (strObs001                            , 40, ' ') + //100 - 139  [18]
                            fPadR      (strObs002                            , 40, ' ') + //140 - 179  [19]
                            fPadR      (' '                                  , 20, ' ') + //180 - 199  [20]
                            //fPadR      ('0'                                  , 16, '0') + //200 - 215  [21 22 23]
                            fPadR      (strDtaLimRec                         ,  8, '0') + //200 - 207  [21]
                            fPadR      ('0'                                  ,  8, '0') + //208 - 215  [22 23]
                            fPadR      (' '                                  , 01, ' ') + //216 - 216  [24]
                            fPadR      ('0'                                  , 12, '0') + //217 - 228  [25]
                            fPadR      (' '                                  , 02, ' ') + //229 - 230  [26 27]
                            fPadR      ('0'                                  , 01, '0') + //231 - 231  [28]
                            fPadR      (' '                                  , 09, ' ') ; //232 - 240  [29]

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************JU*}
            Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));

            Inc(intCodSeq);
            {************************}
            {* TRANSAÇÃO SEGMENTO S *}
            {*********************JU*}
            strTransacao := '';
            strTransacao := fPadR      ('756'                                , 03, ' ') + //001 - 003  [01]
                            fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                            fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                            fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                            fPadR      ('S'                                  , 01, ' ') + //014 - 014  [05]
                            fPadR      (' '                                  , 01, ' ') + //015 - 015  [06]
                            fPadL      (strCodOco                            , 02, ' ') + //016 - 017  [07]
                            fPadR      ('3'                                  , 01, ' ') + //018 - 018  [08]
                            fPadR      (LeftStr(strObs001, 40)               ,040, ' ') + //019 - 058  [09]
                            fPadR      (LeftStr(strObs002, 40)               ,040, ' ') + //059 - 098  [10]
                            fPadR      (LeftStr(strObs003, 40)               ,040, ' ') + //099 - 138  [11]
                            fPadR      (LeftStr(strObs004, 40)               ,040, ' ') + //139 - 178  [12]
                            fPadR      (LeftStr(strObs005, 40)               ,040, ' ') + //179 - 218  [13]
                            fPadR      (' '                                  ,022, ' ') ; //219 - 240  [14]


            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************JU*}
            Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTransacao));
          End;

          fltTotRem := fltTotRem + FieldByName('CBI_VALDUP').AsFloat;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       fltPerMul,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '',
                       '',
                       dtaDtaclcLimRec);

          If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CBI_NUMDUP').AsString,
                                                     FieldByName('CBI_ESPDOC').AsString,
                                                     FieldByName('CBI_CODEMP').AsString,
                                                     FieldByName('CBI_CODCLI').AsString,
                                                     FieldByName('CBI_PARCEL').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CBI_CODCLI').AsString),
                                                     afcEnviaDuplicataBanco);
          End;

          Next;
        End;

      End;

      If (Not blnUsaCrr) or (strResp = 'B') Then
      Begin
        {********************}
        {* TRAILLER DO LOTE *}
        {*****************JU*}
        strTrLote := '';
        strTrLote := '756'                  +              //001 - 003  [01]
                     fPadR('0001', 04, ' ') +              //004 - 007  [02]
                     fPadR('5'   , 01, ' ') +              //008 - 008  [03]
                     fPadR(' '   , 09, ' ') +              //009 - 017  [04]
                     fPadL(IntToStr(intCodSeq+2), 06, '0')+//018 - 023  [05]
                     fPadL(IntToStr(LQuantidadeTitulos), 06, '0')+  //024 - 029  [06]
                     fValNumForm(fltTotRem         , 17)+  //030 - 046  [07]
                     fPadL('0'   , 23, '0') +              //047 - 069  [08 09]
                     fPadL('0'   , 23, '0') +              //070 - 092  [10 11]
                     fPadL('0'   , 23, '0') +              //093 - 115  [12 13]
                     fPadL(' '   , 125, ' ');              //116 - 240  [14]
        {******************************}
        {* ESCREVE O TRAILLER DO LOTE *}
        {***************************JU*}
        Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTrLote));
      End;

      {***********************}
      {* TRAILLER DO ARQUIVO *}
      {********************JU*}
      If (Not blnUsaCrr) or (strResp = 'B') Then
      Begin
        intCodSeq := intCodSeq + 4;
        strTrailler := '';
        strTrailler := '756'                        +        //001 - 003  [01]
                       fPadL    ('9', 5, '9')       +        //004 - 008  [02 03]
                       fPadR    (' ', 9, ' ')       +        //009 - 017  [04]
                       fStrZero (1       , 6)       +        //018 - 023  [05]
                       fStrZero (intCodSeq, 006)    +        //024 - 029  [06]
                       fPadL    ('0', 6, '0')       +        //030 - 035  [07]
                       fPadR    (' ', 205, ' ')     ;        //036 - 240  [08]
      End
      Else
      Begin
        intCodSeq := intCodSeq + 2;
        strTrailler := '';
        strTrailler := fPadR    ('0', 7, '0')       +        //001 - 007  [01]
                       fPadL    ('5',      1)       +        //008 - 008  [02]
                       fPadR    (' ', 9, ' ')       +        //009 - 017  [03]
                       fStrZero (intCodSeq, 6)      +        //018 - 023  [04]
                       fValNumForm(fltTotRem, 17)   +        //024 - 040  [05]
                       fPadL    ('0', 6, '0')       +        //041 - 046  [06]
                       fPadR    (' ', 194, ' ')     ;        //047 - 240  [08]
      End;

      {*********************************}
      {* ESCREVE O TRAILLER DO ARQUIVO *}
      {******************************JU*}
      Writeln(txtTexto,untFuncAutban.fRetirarCaracteresEspeciais(strTrailler));

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }
      If (blnUsaCrr) Then
      Begin

        If  intSeqCrr < 99 Then
          Inc(intSeqCrr)
        Else
          intSeqCrr := 1;

        fGetBancoConfig(1, 'CONFIG756_240p-' + IntToStr(intCartei), 'SEQRMBB', fStrZero(intSeqCrr, 02));
      End;

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;

			  fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
					        'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
      End;

    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

  Except
		On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      LMsgErro := 'Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                  'Erro gerado: ' + E.Message;

      If (UpperCase(E.Message) = 'I/O ERROR 64') Then
        LMsgErro := ' O caminho na rede que você especificou está temporariamente' + #13#10 +
                    ' offline ou não está mais disponível.' + #13#10 +
                    ' É possível que:    '+ #13#10 +
                    ' - 1. O compartilhamento no servidor tenha sido excluído temporariamente. '+ #13#10  +
                    ' - 2. O servidor que compartilhou o recurso pode ter sido desligado. '+ #13#10 +
                    ' - 3. As permissões de escrita e leitura podem ter sido alteradas.' + #13#10 +
                    ' Erro gerado: ' + E.Message;

      Raise Exception.Create(LMsgErro);
		End;
  End;

end;

procedure TfrmExpArqRemBancoob240.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBancoob240.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
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
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmExpArqRemBancoob240.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADEMP');
    Open;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemBancoob240.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{1 - Valor Fixo}
{2 - Percentual}
function TfrmExpArqRemBancoob240.RetornaCodigoMulta: String;
begin
  Result := StrToIntDef(fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'CODIGOMULTA', ''),2).ToString;

  If Not MatchStr(Result,['1','2'])Then
    Result := '2';
end;

procedure TfrmExpArqRemBancoob240.pnlInfoMouseEnter(Sender: TObject);
begin
  inherited;
  ShowHint(pnlInfo,'Aviso!');
end;

procedure TfrmExpArqRemBancoob240.pnlInfoMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmExpArqRemBancoob240.ShowHint(APanel: TPanel; ATitulo: String);
begin
  HintControler.ShowHint(APanel.ClientOrigin.X,APanel.ClientOrigin.Y, ATitulo, APanel.Hint);
end;


procedure TfrmExpArqRemBancoob240.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBancoob240.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
