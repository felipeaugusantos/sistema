unit untExpArqRemBrasil7d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Menus, Buttons, ExtCtrls, strUtils, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemBrasil7d = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    Label1: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;
    strCodRem      : String;
    FEnviarCaracterEspecial: Boolean;

    function fRetEmpresa: String;
    function fSetSacadorAvalista(strSacAvalista,strCpfCnpj : String): String;

    function RetornaComando(AOcorrencia: String): String;
    function RetornaInstrucao(AComando, AInstrucao: String): String;
    function RetornaTextoFormatado(ATexto:String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBrasil7d: TfrmExpArqRemBrasil7d;

implementation

uses untFuncoes, untfuncoesSimples,  Data.DB, untConsultas, untTypesSistema, untConstantes,
     untFuncAutban, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemBrasil7d.FormShow(Sender: TObject);
Var
  strCartSeq: String;
  strCodigoRemessa: String;
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'PATHREM', ''));
  strCartSeq := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'SEQCART', '');
  strCodigoRemessa  := fStrZero(InttoStr(StrToInt(fGetBancoProxNum('CONFIG001D7-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq))) + 1), 7);
  edtNomArquivo.Text  := 'ARQ' + strCodigoRemessa + '.TXT';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBrasil7d.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBrasil7d.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmExpArqRemBrasil7d.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strNomBenef : String;
    strCpfBenef : String;
    strTipInsc  : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaDes   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strDConCor  : String;
    strContCor  : String;
    strCodAgen  : String;
    strDigAgen  : String;
    strCodConv  : String;
    strPreFix   : String;
    strCodCar   : String;
    strVarCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strObsAgru  : String;
    strMandMsg  : String;
    strTipCob   : String;

    LVendorTaxaComprador: Double;
    LVendorTaxaVendedor: Double;
    LVendorIndicativoIOF: String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strInstru1  : String;
    strInstru2  : String;
    strInstruProtestoPers  : String;
    strDiaProPer: String;

    strCnpjSac	: String;
    strSacAval	: String;
    strMsgSac	: String;

    strCidade   : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    fltValDes   : Double;
    txtTexto    : TextFile;
    strCodBan   : String;
    strCobran   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strNosNum   : String;
    strNumDup   : String;
    strPerMult  : String;
    strDtaMult  : String;
    strMailPag  : String;
    qryRemessa  : TUniQuery;
    strDiaProExp: String;
    blnDiaProExp: Boolean;
    strCartSeq  : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    blnUsaCnd   : Boolean;
    blnUsaDesPonCli: Boolean;
    blnUsaDesPon   : Boolean;
    dtaDtaDes: TDateTime;

    strNomCli    : String;
    strResEmi    : String;
    strQtdDtaLimite: String;
    LEnviarEmailBloqueto: Boolean;
    ATipoCobranca  : String;

    fltValDup : Double;
    strchkcbEmp : String;
    AstrEndereco: String;
    blnParNum : Boolean;

    LComando: String;

    LInstrucaoPF: String;
    LDiasProtestoPF: String;

    LInstrucaoPJ: String;
    LDiasProtestoPJ: String;

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

  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p\ exportação deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBan  := '001BANCO DO BRASIL';
  strCodBco  := '001';
  strNomBco  := 'BANCO DO BRASIL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strCodAgen := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CODCONV', '');
  strVarCar  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'VARCART', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'NUMCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAPROT', '');
  strMandMsg := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'MANDMSG', '');
  LEnviarEmailBloqueto := (fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'ENVIAEMAILBLOQUETO', '') <> 'N');
  strInstru1 := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU2', '');
  strInstruProtestoPers := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTPER', '');
  strDiaProPer:= fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAPERS', '');
  strCobran  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'TIPCOBR', '');
  strResEmi  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'RESPONS', '');
  ATipoCobranca   := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'TIPCOBR', '');
  strQtdDtaLimite := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIALIMI', '');
  blnParNum  := (Trim(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'PARCNUM', '')) = 'S') And (fCfgSis('PARNUM') = 'S');

  FEnviarCaracterEspecial := (Trim(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'ENVCESP', '')) = 'S');

  strPerMult := FormatFloat('#,##0.00', fStrToFloat(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'PERMULT', '')));

  LInstrucaoPF    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRUCAO_PF', '');
  LDiasProtestoPF := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAS_PROTESTO_PF', '');
  LInstrucaoPJ    := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRUCAO_PJ', '');
  LDiasProtestoPJ := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAS_PROTESTO_PJ', '');


  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG001D7', 'RELOCAL', '') = 'N' ) ;

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  LVendorTaxaComprador := fStrToFloat(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'TAXACOM', ''));
  LVendorTaxaVendedor := fStrToFloat(fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'TAXAVEN', ''));
  LVendorIndicativoIOF := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INDIOF', '');

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

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

    strTipInsc  := '02';
    strNomBenef := fArqIniAutban(0, 'CONFIG001D7-' + IntToStr(intCartei), 'NOMBENE', '');
    strCpfBenef := fArqIniAutban(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CPFBENE', '');

    If fCfgSis('BENBOL', varBoolean) And (Not fEmptyStr(strCpfBenef)) Then
    Begin
      strNomEmp  := strNomBenef;
      strCgcEmp  := strCpfBenef;
      strTipInsc := '01';
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei :=  'CONFIG001D7-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
     strSQL := strSQL + '  SUM(R.CTR_DESSUJ) AS CTR_DESSUJ, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, C.CLI_PERDPO, C.CLI_QTDDAV, C.CLI_CGCCPF, ';
    strSQL := strSQL + '  C.CLI_EMCOB1, C.CLI_EMCOB2, C.CLI_EMAIL_, C.CLI_EMAIL2, C.CLI_EMAIL3, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';

    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  D.CND_PERDPO, ';
      strSQL := strSQL + '  D.CND_QTDDAV, ';
    End;

    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI     ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND B.CBI_CODOCO IN ("01", "06", "12")) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02" AND ((CTR_BAIMAN="S") OR (CTR_RECPIX="S")))) ';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas' Then
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
          ParamByName('CARTEI').AsString := StrCartei;

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG001D7-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG001D7-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************LB*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 a 001
                   fPadR   ('1'                , 001)      + //002 a 002
                   fPadR   ('REMESSA'          , 007)      + //003 a 009
                   fPadR   ('01'               , 002)      + //010 a 011
                   fPadR   ('COBRANCA'         , 008)      + //012 a 019
                   fPadR   (' '                , 007)      + //020 a 026
                   fPadL   (strCodAgen         , 004, '0') + //027 a 030
                   fPadL   (strDigAgen         , 001)      + //031 a 031
                   fPadL   (strContCor         , 008, '0') + //032 a 039
                   fPadL   (strDConCor         , 001, '0') + //040 a 040
                   fPadL   ('000000'           , 006)      + //041 a 046
                   fPadR   (strNomEmp          , 030)      + //047 a 076
                   fPadR   (strCodBan          , 018)      + //077 a 094
                   fPadR   (strDtaRem          , 006)      + //095 a 100
                   fPadR   (strCodRem          , 007)      + //101 a 107
                   fPadR   (' '                , 022)      + //108 a 129
                   fPadR   (strCodConv         , 007)      + //130 a 136
                   fPadR   (' '                , 258)      + //137 a 394
                   fStrZero(IntToStr(intCodSeq), 006);       //395 a 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);


      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************LB*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          If (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') And
             (strMandMsg = 'S') Then
          Begin
            strObsAgru := 'REF:_' + COPY(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,31);
          End
          Else
          Begin
            strObsAgru := '';
          End;

          strInstru1 := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'INSTRU2', '');
          strDiaPro  := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'DIAPROT', '');

          If qryRemessa.FieldByName('CLI_CGCCPF').AsString.Equals('2') Then
          Begin
            If Not fEmptyStr(LInstrucaoPF) Then
            Begin
              strInstru2 := LInstrucaoPF;
              strDiaPro  := LDiasProtestoPF;
            End;
          End
          Else If Not fEmptyStr(LInstrucaoPJ) Then
          Begin
            strInstru2 := LInstrucaoPJ;
            strDiaPro  := LDiasProtestoPJ;
          End;

          // INSTRUÇÃO PERSONALIZADA;
          If FieldByName('CBI_PROTES').AsString = 'S' Then
          Begin
            If (Not fEmptyStr(strInstruProtestoPers)) Then
            Begin
              strInstru2 := strInstruProtestoPers;
              strDiaPro  := strDiaProPer;
            End;
          End;

          strCnpjSac := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'CNPJSAC', '');
          strSacAval := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'SACAVAL', '');

          {**********************************************************}
          {* VERIFICAÇÃO, SE IMPRIME O CNPJ E O SACADOR/AVALISTA OU *}
          {* CASO NÃO IMPRIMA SACADOR/AVALISTA IMPRIMIR OBSERVAÇÕES *}
          {* SE IMPRIME SACADO POS 88 = 'A' OU SE IMPRIME OBS = ' ' *}
          {*RQ23901***********************************************BB*}

          If ((strCnpjSac = '') And (strSacAval = '')) Then
          	strMsgSac := ' '
          else
          begin
          	strMsgSac := 'A'; {SETA OBS PARA CPF/CNPJ DO SACADOR AVALISTA}
          strObsAgru := fSetSacadorAvalista(strSacAval, strCnpjSac);
          end;

          {*RQ23901***********************************************BB*}

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

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

          If fCfgSis('DESBOL', varBoolean) Then
            fltValDup := fFormataFloat((fltValDup - FieldByName('CTR_DESSUJ').AsFloat),2);

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

          //DE ACORDO COM MANUAL NOVO ESSE CAMPO VAI EM BRANCO
          //strPreFix := 'AI';
          strPreFix := '';

          //*************************************************//
          // COBRANCA SIMPLES CARTEIRAS (11 E 17)            //
          //**********************************************ED*//
          If (Trim(strCobran) = 'S') And (Pos(strCodCar, '_11_12_17') > 0) Then
          Begin
            strTipCob := '';
          End
          Else

          //*************************************************//
          // COBRANCA VENDOR CARTEIRAS (11 E 17)             //
          //**********************************************ED*//
          If (Trim(strCobran) = 'V') And (Pos(strCodCar, '_11_17') > 0) Then
          Begin
            strTipCob := '08VDR';
          End
          Else

          //*************************************************//
          // COBRANCA VINCULADA CARTEIRAS (11 E 17)          //
          //**********************************************ED*//
          If (Trim(strCobran) = 'I') And (Pos(strCodCar, '_11_17_31') > 0) Then
          Begin
            strTipCob := '02VIN';
          End
          Else

          //*************************************************//
          // COBRANCA DESCONTADA CARTEIRAS (11 E 17)         //
          //**********************************************ED*//
          If (Trim(strCobran) = 'D') And (Pos(strCodCar, '_11_17_51') > 0) Then
          Begin
            strTipCob := '04DSC';
          End

          Else
          Begin

            //DE ACORDO COM MANUAL NOVO ESSE CAMPO VAI EM BRANCO
            {If fStrZero(strCodCar,2) = '12' Then
            Begin
              strPreFix := 'AIU';
            End
            Else If ((fStrZero(strCodCar,2) = '31') Or
                     (fStrZero(strCodCar,2) = '51') )Then
            Begin
              strPreFix := 'SD';
            End;}

            If ((fStrZero(strCodCar,2) = '11') Or (fStrZero(strCodCar,2) = '17')) Then
              strTipCob := '04DSC'
            Else
              strTipCob := '';

          End;


          //*************************************************//
          // INFORMACOES REFERENTE AO NOSSO NUMERO           //
          // - PARA AS CARTEIRAS (11, 31 E 51 )              //
          //   PREENCHER COM ZEROS                           //
          //                                                 //
          // - PARA A CARTEIRA (17 )                         //
          //   PREENCHER COM CONVENIO + SEQUENCIAL (N. NUM)  //
          //   EX.: "CCCCCCCSSSSSSSSSS"                      //
          //**********************************************ED*//
          If strResEmi = 'E' Then
          Begin
            strNosNum := fStrZero( FieldByName('CBI_NOSNUM').AsString, 17 );

            If Pos(strCodCar, '_17') > 0 Then
            Begin
              strNosNum := fStrZero( strCodConv, 07 ) + fStrZero( FieldByName('CBI_NOSNUM').AsString, 10 );
            End
            Else If Pos(strCodCar, '_31') > 0 Then
            Begin
              strNosNum := '0';
            End;
          End
          Else
            strNosNum := fStrZero('0', 17);

          //*************************************************//
          // SE A QUANTIDADE DE DIAS PARA PROTESTO NAO FOR   //
          // INFORMADA ENTAO ATRIBUI VALOR ZERO "00"         //
          //**********************************************ED*//
          If fEmptyStr( strDiaPro ) Then
            strDiaPro := '00';

          strDtaDes := '000000';

          If blnUsaDesPonCli And blnUsaDesPon Then
          begin
            fltValDes := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );
            fltValDes := fFormataFloat(fltValDes, 2);

            If fltValDes > 0 Then
            Begin
              dtaDtaDes := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDes := FormatDateTime('ddmmyy', dtaDtaDes);
            End
            Else
              strDtaDes := '000000';
          end
          else
          If blnUsaCnd And blnUsaDesPon Then
          Begin
            fltValDes := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CND_PERDPO').AsFloat / 100 ) );
            fltValDes := fFormataFloat(fltValDes, 2);

            If fltValDes > 0 Then
            Begin
              dtaDtaDes := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CND_QTDDAV').AsInteger;
              strDtaDes := FormatDateTime('ddmmyy', dtaDtaDes);
            End
            Else
              strDtaDes := '000000';
          End
          Else
          Begin
            fltValDes := 0;
            strDtaDes := '000000';
          End;

          //SE PREENCHIDO ENVIAR 3 CARACTERES COMPLETADOS COM ZERO
          //REQ 137946 MO
          if not fEmptyStr(strQtdDtaLimite) then
          begin
            strQtdDtaLimite := fStrZero(strQtdDtaLimite, 3);
          end;

          If blnParNum Then
            strNumDup := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  fPadL(fRetNumParcela(FieldByName('CBI_PARCEL').AsString),003,'0'), 10)
          Else
            strNumDup := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  FieldByName('CBI_PARCEL').AsString, 10);

          strCidade := RetornaTextoFormatado(FieldByName('CIDADE').AsString);

          blnDiaProExp := (strInstru1 = '06') Or (strInstru1 = '88')or (strInstru2 = '06') or (strInstru2 = '88');
          strDiaProExp := IIF(blnDiaProExp, strDiaPro, '  ');

          //Removendo caracteres de quebra de linha da descrição do cliente.
          strNomCli    := StringReplace(FieldByName('CLI_NOMCLI').AsString, #13, '', [rfReplaceAll]);
          strNomCli    := StringReplace(FieldByName('CLI_NOMCLI').AsString, #10, '', [rfReplaceAll]);

          LComando := RetornaComando(FieldByName('CBI_CODOCO').AsString);
          
          strTransacao := fPadR      ('7'                                     , 01)      + //001 a 001
                          fPadR      (strTipInsc                              , 02)      + //002 a 003
                          fPadL      (strCgcEmp                               , 14, '0') + //004 a 017
                          fPadL      (strCodAgen                              , 04, '0') + //018 a 021
                          fPadL      (strDigAgen                              , 01, '0') + //022 a 022
                          fPadL      (strContCor                              , 08, '0') + //023 a 030
                          fPadL      (strDConCor                              , 01, '0') + //031 a 031
                          fStrZero   (strCodConv                              , 07)      + //032 a 038
                          fPadR      (strKeyDup                               , 25)      + //039 a 063
                          fPadL      (strNosNum                               , 17, '0') + //064 a 080
                          fStrZero   ('0'                                     , 02)      + //081 a 082
                          fStrZero   ('0'                                     , 02)      + //083 a 084
                          fPadR      (' '                                     , 03)      + //085 a 087
                        {*************}
                          fPadR			 (strMsgSac																, 01) 		 + //088 a 088
                        {RQ23901****BB}
                          fPadR      (strPreFix                               , 03)      + //089 a 091
                          fPadR      (strVarCar                               , 03)      + //092 a 094
                          fStrZero   ('0'                                     , 01)      + //095 a 095
                          fStrZero   ('0'                                     , 06)      + //096 a 101
                          fPadR      (strTipCob                               , 05)      + //102 a 106
                          fStrZero   (strCodCar                               , 02)      + //107 a 108
                          fPadR      (LComando                                , 02)      + //109 a 110
                          fPadR      (RightStr(strNumDup, 10)                 , 10)      + //111 a 120
                          fPadR      (strDtaVen                               , 06)      + //121 a 126
                          fValNumForm(fltValDup                               , 13)      + //127 a 139
                          fPadR      (strCodBco                               , 03)      + //140 a 142
                          fStrZero   ('0'                                     , 04)      + //143 a 146
                          fPadR      (' '                                     , 01)      + //147 a 147
                          fStrZero   ('01'                                    , 02)      + //148 a 149
                          fPadR      ('N'                                     , 01)      + //150 a 150
                          fPadR      (strDtaEmi                               , 06)      + //151 a 156
                          fPadR      (RetornaInstrucao(LComando, strInstru1)  , 02)      + //157 a 158
                          fPadR      (RetornaInstrucao(LComando, strInstru2)  , 02)      + //159 a 160
                          fValNumForm(fltValAtr                               , 13)      + //161 a 173

                          IIF((LComando = '01') And (strTipCob='08VDR'),
                            fPadR      (strDtaEmi                             , 06)      + //174 a 179
                            fValNumForm(LVendorTaxaVendedor                   , 05, 03)  + //180 a 184
                            fValNumForm(LVendorTaxaComprador                  , 05, 03)  + //185 a 189
                            fPadR      (LVendorIndicativoIOF                  , 01)      + //190 a 190
                            fStrZero   ('0'                                   , 02),       //191 a 192

                            fPadR      (strDtaDes                             , 06)      + //174 a 179
                            fValNumForm(fltValDes                             , 13))     + //180 a 192

                          fStrZero   ('0'                                     , 13)      + //193 a 205
                          fStrZero   ('0'                                     , 13)      + //206 a 218
                          fStrZero   (strCpfCgc                               , 02)      + //219 a 220
                          fStrZero   (strCgcCli                               , 14)      + //221 a 234
                          fPadR      (RetornaTextoFormatado(strNomCli)  , 37)      + //235 a 271
                          fPadR      (' '                                     , 03)      + //272 a 274
                          fPadR      (RetornaTextoFormatado(AstrEndereco), 40)      + //275 a 314
                          fPadR      (RetornaTextoFormatado(FieldByName('BAIRRO').AsString), 12)      + //315 a 326
                          fPadR      (FieldByName('C_E_P_').AsString          , 08)      + //327 a 334
                          fPadR      (RetornaTextoFormatado(strCidade)  , 15)      + //335 a 349
                          fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350 a 351
                          fPadR      (strObsAgru                              , 40)      + //352 a 391
                          fStrZero   (strDiaProExp , 02)                                 + //392 a 393
                          fPadR      (' '                                     , 01)      + //394 a 394
                          fStrZero   (IntToStr(intCodSeq)                     , 06);       //395 a 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          Writeln(txtTexto,strTransacao);
          {******************************}
          {* MUTLA QUANDO CONFIGURADO   *}
          {* PERCENTUAL DE MULTA        *}
          {***************************JU*}
          If fStrToFloat(strPerMult) > 0 Then
          Begin
            Inc(intCodSeq);

            strDtaMult := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime + 1) +
                          FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                          FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

            strTransacao := fPadR      ('5'                    , 001) + //001 a 001
                            fPadR      ('99'                   , 002) + //002 a 003
                            fPadR      ('2'                    , 001) + //004 a 004
                            fPadR      (strDtaMult             , 006) + //005 a 010
                            fValNumForm(fStrToFloat(strPerMult), 012) + //011 a 022
                            fPadL      (strQtdDtaLimite        , 003) + //023 a 025
                            fPadR      (' '                    , 369) + //026 a 394
                            fStrZero   (IntToStr(intCodSeq)    , 006);  //395 a 400

            Writeln(txtTexto,strTransacao);
          End;

          {***************************************************************************************}
          {* O ENVIO DA LINHA REFERENTE AO E-MAIL É VÁLIDO SOMENTE NAS MODALIDADES DE COBRANÇA ***}
          {* ONDE O PRÓPRIO BB É O RESPONSÁVEL PELA IMPRESSÃO E EXPEDIÇÃO DO BOLETO DE COBRANÇA, *}
          {* EXCETO NAS MODALIDADES DESCONTO OU VENDOR *******************************************}
          {*REQ*146196*************************************************************************MO*}
          if ((strResEmi = 'B') Or
              (MatchStr(ATipoCobranca, ['I', 'D']))) And LEnviarEmailBloqueto Then
          begin
            strMailPag := fRetornaEmailCliente(qryRemessa);
            If Not fEmptyStr(strMailPag) Then
            Begin
              Inc(intCodSeq);

              strTransacao := fPadR      ('5'                    , 001) + //001 a 001
                              fPadR      ('01'                   , 002) + //002 a 003
                              fPadR      (strMailPag             , 136) + //004 a 139
                              fPadR      (' '                    , 255) + //140 a 394
                              fStrZero   (IntToStr(intCodSeq)    , 006);  //395 a 400

              Writeln(txtTexto,strTransacao);
            End;
          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       fStrToFloat(strPerMult),
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '',
                       FieldByName('CBI_PROTES').AsString);

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

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001 a 001
                     fPadR   (' '                , 002) + //002 a 003
                     fPadR   (' '                , 136) + //004 a 139
                     fPadR   (' '                , 255) + //140 a 394
                     fStrZero(IntToStr(intCodSeq), 006);  //395 a 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }

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

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;


function TfrmExpArqRemBrasil7d.fRetEmpresa: String;
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
    SQL.Add('ORDER BY EMP_CODEMP ');
    Open;
    First;

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

{***************************************}
{* CONCATENA STRING DE SACADOR/AVALISTA*}
{* TRATANDO PARA QUANDO FOR CPF OU CNPJ*}
{* VIDE REGRA LAYOUT DE REMESSA ********}
{*RQ23901****************************BB*}
function TfrmExpArqRemBrasil7d.fSetSacadorAvalista(strSacAvalista,
  strCpfCnpj: String): String;
begin
	Result := '';

  if Length(fTiraCaracEspeciaisPonto(strCpfCnpj)) <= 11 then
  Begin
    Result := fPadR(strSacAvalista, 25) + fPadR(' ', 01) +
    fPadr('CPF', 03) +	fPadr(fTiraCaracEspeciaisPonto(strCpfCnpj), 11);
  End
  Else
  Begin
  	Result := fPadR(strSacAvalista, 21) + fPadR(' ', 01) +
    	fPadr('CNPJ', 04) +	fPadr(fTiraCaracEspeciaisPonto(strCpfCnpj), 14);
  End;
end;
{*RQ23901****************************BB*}


function TfrmExpArqRemBrasil7d.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBrasil7d.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

function TfrmExpArqRemBrasil7d.RetornaComando(AOcorrencia: String): String;
begin
  Result := '01';

  If Not AOcorrencia.IsEmpty Then
    Result := fStrZero(AOcorrencia, 02);
end;

function TfrmExpArqRemBrasil7d.RetornaInstrucao(AComando, AInstrucao: String): String;
begin
  Result := AInstrucao;

  If AComando = '02' Then
    Result := '44';
end;

function TfrmExpArqRemBrasil7d.RetornaTextoFormatado(ATexto: String): String;
begin
  Result := ATexto;

  If Not FEnviarCaracterEspecial Then
    Result := fRetirarCaracteresEspeciais(Result)
end;

end.
