{***************************}
{* qryConBco -> CADBCO     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untRelCopiaCheque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, StrUtils, AppEvnts, Uni,
  DB, BitBtnLockedIncrem, frxDMPClass, Math, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  frxExportCSVTestabilidade;

type
  TfrmRelCopiaCheque = class(TfrmPaiRelatorio)
    Label1: TLabel;
    Label2: TLabel;
    edtNumAge: TEditFocus;
    edtNumChq: TEditFocus;
    lblNumAge: TLabel;
    Label3: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    lblBanco: TLabel;
    frxImpCopiaCheque_M: TfrxReport;
    frxImpCopiaCheque_J: TfrxReport;
    edtConCor: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    chkMeiaFolha: TCheckBox;
    chkNovaPagina: TCheckBox;
    chkAssinatura: TCheckBox;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure edtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    function frxImpCopiaCheque_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure FormShow(Sender: TObject);
    function frxImpCopiaCheque_JUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;
    procedure pCarregaBanco;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

uses untPesqAux, untFuncoesSimples, untModuloSPR, untConsultas, untTypesSistema,
  untValorPorExtenso;

{$R *.dfm}

procedure TfrmRelCopiaCheque.edtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBco, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmRelCopiaCheque.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  With qryConBco Do
  Begin
    edtNomBco.Text := FieldByName('BCO_NOMBCO').AsString;
    edtCodBco.Text := FieldByName('BCO_CODBCO').AsString;
  End;
end;

procedure TfrmRelCopiaCheque.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelCopiaCheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadBco);
end;

procedure TfrmRelCopiaCheque.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadBco := fCriaQuery(Self);
  qryConBco := qryCadBco;

  {**************************************}
  {* PASSA A FUNCTION PARA O FASTREPORT *}
  {***********************************AC*}
  frxImpCopiaCheque_M.AddFunction('function fRetExtensoNumero(Value: String): String');
  frxImpCopiaCheque_M.AddFunction('function fRetExtensoNumero2(Value: String): String');

  frxImpCopiaCheque_J.AddFunction('function fRetExtensoNumero(Value: String): String');
  frxImpCopiaCheque_J.AddFunction('function fRetExtensoNumero2(Value: String): String');
end;

function TfrmRelCopiaCheque.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {********************************************}
    {* SE TODOS OS CAMPOS ESTIVEREM PREENCHIDOS *}
    {* ENTÃO NÃO USA O PERÍODO.                 *}
    {*****************************************AC*}
    If (Not fEmptyStr(edtCodBco.Text)) And (Not fEmptyStr(edtNumAge.Text)) And (Not fEmptyStr(edtNumChq.Text)) Then
    Begin
      mskDtaIni.Enabled := False;
      mskDtaFin.Enabled := False;
    End
    Else
    Begin
      mskDtaIni.Enabled := True;
      mskDtaFin.Enabled := True;
    End;

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Essa Empresa não está cadastrada!',['&O K']);
          Result := False;
        End;
      End
      Else
        edtNomEmp.Text := 'TODAS';
    End

    Else If (Sender = edtCodBco) Then
    Begin
      If (Not fEmptyStr(edtCodBco.Text)) Then
      Begin
        pCarregaBanco;

        If (qryConBco.FieldByName('BCO_CODBCO').IsNull) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtNomBco.Text := 'TODOS';
    End

    Else If (Sender = edtConCor) Then
    Begin
      If (Not fEmptyStr(edtConCor.Text)) Then
        edtConCor.Text := fStrZero(edtConCor.Text,12)
    End

    Else If (Sender = edtNumChq) Then
    Begin
      If (Not fEmptyStr(edtNumChq.Text)) Then
        edtNumChq.Text := fStrZero(edtNumChq.Text,10)
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmRelCopiaCheque.btnImprimirClick(Sender: TObject);
  Const
    FATOR_IMP_MAT = 4.497913762;
    FATOR_IMP_LAS = 10;

  Var
    strSQL   : String;
    strNomImp: String;
    frxCheque: TfrxReport;
    intTamPag: Double;
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '   CONCAT(EMI_NUMCHQ, EMI_CODBCO, EMI_NUMAGE, EMI_CONCOR) CHAVE, ';
    strSQL := strSQL + '   " " AS FOR_NOMFOR, ';
    strSQL := strSQL + '   " " AS EMI_NUMDUP, ';
    strSQL := strSQL + '   EMI_NUMCHQ, ';
    strSQL := strSQL + '   CONCAT(EMI_CODBCO," - ",BCO_NOMBCO) AS EMI_CODBCO, ';
    strSQL := strSQL + '   EMI_NUMAGE, ';
    strSQL := strSQL + '   " " AS CID_NOMCID, ';
    strSQL := strSQL + '   EMI_DTABAI, ';
    strSQL := strSQL + '   SUM(EMI_VALBAI) AS EMI_VALBAI, ';
    strSQL := strSQL + '   CONCAT(RIGHT(EMI_BOMPAR,2),"/",RIGHT(LEFT(EMI_BOMPAR,7),2),"/",LEFT(EMI_BOMPAR,4)) AS EMI_BOMPAR, ';
    strSQL := strSQL + '   EMI_FAVORE, ';
    strSQL := strSQL + '   EMI_CONCOR, ';
    strSQL := strSQL + '   CONCAT(EMI_CODPOR, "-", POR_NOMPOR) AS EMI_CODPOR, ';
    strSQL := strSQL + '   CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS EMI_NOMEMP, ';
    strSQL := strSQL + '   EMP_NOMEMP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CHQEMI ';
    strSQL := strSQL + '   LEFT JOIN CADEMP ON EMP_CODEMP = EMI_CODEMP ';
    strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = EMI_CODFOR ';
    strSQL := strSQL + '   LEFT JOIN CADBCO ON BCO_CODBCO = EMI_CODBCO ';
    strSQL := strSQL + '   LEFT JOIN CADPOR ON EMI_CODPOR = POR_CODPOR ';
    strSQL := strSQL + ' WHERE ';

    If (Not (mskDtaIni.Enabled)) And (Not (mskDtaFin.Enabled)) Then
    Begin
      strSQL := strSQL + ' EMI_CODBCO = :CODBCO ';
      strSQL := strSQL + ' AND EMI_NUMAGE = :NUMAGE ';
      strSQL := strSQL + ' AND EMI_NUMCHQ = :NUMCHQ ';
    End
    Else
    Begin
      strSQL := strSQL + ' EMI_DTABAI BETWEEN :DTAINI AND :DTAFIM ';

      If (Not fEmptyStr(edtCodBco.Text)) Then
        strSQL := strSQL + ' AND EMI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtNumAge.Text)) Then
        strSQL := strSQL + ' AND EMI_NUMAGE = :NUMAGE ';

      If (Not fEmptyStr(edtNumChq.Text)) Then
        strSQL := strSQL + ' AND EMI_NUMCHQ = :NUMCHQ ';

      If (Not fEmptyStr(edtConCor.Text)) Then
        strSQL := strSQL + ' AND EMI_CONCOR = :CONCOR ';
    End;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      strSQL := strSQL + ' AND EMI_CODEMP = :CODEMP ';

    strSQL := strSQL + ' GROUP BY EMI_DTABAI, EMI_NUMCHQ, EMI_CODBCO, EMI_NUMAGE ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '   CONCAT(EMI_NUMCHQ, EMI_CODBCO, EMI_NUMAGE, EMI_CONCOR) CHAVE, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   CONCAT(EMI_NUMDUP,EMI_PARCEL,"-",IFNULL(EMI_SERIE_, ""),"-",EMI_CODEMP) AS EMI_NUMDUP, ';
    strSQL := strSQL + '   EMI_NUMCHQ, ';
    strSQL := strSQL + '   CONCAT(EMI_CODBCO," - ",BCO_NOMBCO) AS EMI_CODBCO, ';
    strSQL := strSQL + '   EMI_NUMAGE, ';
    strSQL := strSQL + '   CID_NOMCID, ';
    strSQL := strSQL + '   EMI_DTABAI, ';
    strSQL := strSQL + '   EMI_VALBAI, ';
    strSQL := strSQL + '   CONCAT(RIGHT(EMI_BOMPAR,2),"/",RIGHT(LEFT(EMI_BOMPAR,7),2),"/",LEFT(EMI_BOMPAR,4)) AS EMI_BOMPAR, ';
    strSQL := strSQL + '   EMI_FAVORE, ';
    strSQL := strSQL + '   EMI_CONCOR, ';
    strSQL := strSQL + '   CONCAT(EMI_CODPOR, "-", POR_NOMPOR) AS EMI_CODPOR, ';
    strSQL := strSQL + '   CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) AS EMI_NOMEMP, ';
    strSQL := strSQL + '   EMP_NOMEMP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CHQEMI ';
    strSQL := strSQL + '   LEFT JOIN CADEMP ON EMP_CODEMP = EMI_CODEMP ';
    strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = EMI_CODFOR ';
    strSQL := strSQL + '   LEFT JOIN CADBCO ON BCO_CODBCO = EMI_CODBCO ';
    strSQL := strSQL + '   LEFT JOIN CADPOR ON EMI_CODPOR = POR_CODPOR ';
    strSQL := strSQL + ' WHERE ';

    If (Not (mskDtaIni.Enabled)) And (Not (mskDtaFin.Enabled)) Then
    Begin
      strSQL := strSQL + ' EMI_CODBCO = :CODBCO ';
      strSQL := strSQL + ' AND EMI_NUMAGE = :NUMAGE ';
      strSQL := strSQL + ' AND EMI_NUMCHQ = :NUMCHQ ';
    End
    Else
    Begin
      strSQL := strSQL + ' EMI_DTABAI BETWEEN :DTAINI AND :DTAFIM ';

      If (Not fEmptyStr(edtCodBco.Text)) Then
        strSQL := strSQL + ' AND EMI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtNumAge.Text)) Then
        strSQL := strSQL + ' AND EMI_NUMAGE = :NUMAGE ';

      If (Not fEmptyStr(edtNumChq.Text)) Then
        strSQL := strSQL + ' AND EMI_NUMCHQ = :NUMCHQ ';

      If (Not fEmptyStr(edtConCor.Text)) Then
        strSQL := strSQL + ' AND EMI_CONCOR = :CONCOR ';
    End;

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      strSQL := strSQL + ' AND EMI_CODEMP = :CODEMP ';

    //strSQL := strSQL + ' ORDER BY EMI_NUMCHQ, EMI_CODBCO, EMI_NUMAGE, EMI_NUMDUP, CID_NOMCID DESC ';
    strSQL := strSQL + ' ORDER BY EMI_NUMCHQ, EMI_CODBCO, EMI_NUMAGE, FOR_NOMFOR, EMI_NUMDUP ';

    With frmModuloSPR.qryRelatorio Do 
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not (mskDtaIni.Enabled)) And (Not (mskDtaFin.Enabled)) Then
      Begin
        ParamByName('CODBCO').AsString := edtCodBco.Text;
        ParamByName('NUMAGE').AsString := edtNumAge.Text;
        ParamByName('NUMCHQ').AsString := edtNumChq.Text;
      End
      Else
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

        If (Not fEmptyStr(edtCodBco.Text)) Then
          ParamByName('CODBCO').AsString := edtCodBco.Text;

        If (Not fEmptyStr(edtNumAge.Text)) Then
          ParamByName('NUMAGE').AsString := edtNumAge.Text;

        If (Not fEmptyStr(edtNumChq.Text)) Then
          ParamByName('NUMCHQ').AsString := edtNumChq.Text;

        If (Not fEmptyStr(edtConCor.Text)) Then
          ParamByName('CONCOR').AsString := edtConCor.Text;
      End;

      If (Not fEmptyStr(edtCodEmp.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;

      Open;

      If (Not IsEmpty) Then
      Begin

        {*******************************************}
        {* FILA DE IMPRESSAO                       *}
        {****************************************AC*}
        pCarregaConfImpr(qryCfgRel, Self.Name);
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

        If strTipImp = 'M' Then
        Begin
          frxCheque := frxImpCopiaCheque_M;

          intTamPag := IIF(chkMeiaFolha.Checked, 32, 65);
          TfrxReportPage(frxCheque.FindObject('pCopiaCheque')).PaperHeight := Round(intTamPag * FATOR_IMP_MAT);
          TfrxDMPCommand(frxCheque.FindObject('cmdImpressao')).Command     := '#27#64#27#67#' + IntToStr(Floor(intTamPag)) + '#15#27#80';
        End
        Else
        Begin
          frxCheque := frxImpCopiaCheque_J;

          intTamPag := IIF(chkMeiaFolha.Checked, 14.84, 29.70);
          TfrxReportPage(frxCheque.FindObject('pCopiaCheque')).PaperHeight := Round(intTamPag * FATOR_IMP_LAS);
        End;

        TfrxGroupHeader(frxCheque.FindObject('GHDuplicatas')).StartNewPage := chkNovaPagina.Checked;
        TfrxGroupFooter(frxCheque.FindObject('GFDuplicatas')).Visible      := chkAssinatura.Checked;        

        If (Not fEmptyStr(strNomImp)) Then
        Begin
          frxCheque.PrintOptions.ShowDialog := False;
          frxCheque.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
        End;

        If frxCheque.PrepareReport Then
        Begin
          If (edtDestino.Text = 'V') Then
            pPreviewReport(Self.Name, Self.Caption, frxCheque)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxCheque);
        End;

      End
      Else
        fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);

    End;

  End;

  btnImprimir.Enabled := True;
  If mskDtaIni.Enabled Then
    pSetFocus(mskDtaIni)
  Else
    pSetFocus(edtCodBco);
  pnlInfo.Caption     := '';

end;

function TfrmRelCopiaCheque.frxImpCopiaCheque_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
  Var
    strExtenso: String;
begin
  inherited;

  strExtenso := '';

  If MethodName = 'FRETEXTENSONUMERO' Then
  Begin
    strExtenso := UpperCase(fRetExtensoNumero(Params[0]));
    strExtenso := fPadR(AnsiUpperCase(Copy(strExtenso,1,95)),95,'*');
    Result := strExtenso;
  End;

  If MethodName = 'FRETEXTENSONUMERO2' Then
  Begin
    strExtenso := UpperCase(fRetExtensoNumero(Params[0]));
    strExtenso := fPadR(AnsiUpperCase(Copy(strExtenso,96,95)),100,'*');
    Result := strExtenso;
  End;

end;

procedure TfrmRelCopiaCheque.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  inherited;  
end;

function TfrmRelCopiaCheque.frxImpCopiaCheque_JUserFunction(
  const MethodName: String; var Params: Variant): Variant;
  Var
    strExtenso: String;
begin
  inherited;

  strExtenso := '';

  If MethodName = 'FRETEXTENSONUMERO' Then
  Begin
    strExtenso := UpperCase(fRetExtensoNumero(Params[0]));
    strExtenso := fPadR(AnsiUpperCase(Copy(strExtenso,1,95)),95,'*');
    Result := strExtenso;
  End;

  If MethodName = 'FRETEXTENSONUMERO2' Then
  Begin
    strExtenso := UpperCase(fRetExtensoNumero(Params[0]));
    strExtenso := fPadR(AnsiUpperCase(Copy(strExtenso,96,95)),100,'*');
    Result := strExtenso;
  End;

end;

procedure TfrmRelCopiaCheque.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.


