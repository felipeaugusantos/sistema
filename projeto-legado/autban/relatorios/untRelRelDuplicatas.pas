unit untRelRelDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, StdCtrls, EditFocus,
  QColorLabel, Buttons, ExtCtrls, StrUtils, Menus, Uni, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, Data.DB, MemDS, DBAccess;

type
  TfrmRelRelDuplicatas = class(TfrmPaiRelatorio)
    pnlFundo: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    pnlTopo: TPanel;
    edtCliente: TEditFocus;
    edtEmpresa: TEditFocus;
    edtDesCliente: TEdit;
    edtDesEmpresa: TEdit;
    ckbQbrEmp: TCheckBox;
    rdgOrdem: TRadioGroup;
    qryDuplicatasSPC: TUniQuery;
    frxDBDatasetSPC: TfrxDBDataset;
    frxDuplicatasSPC: TfrxReport;
    qryDuplicatasSPCNUMDUP: TStringField;
    qryDuplicatasSPCESPDOC: TStringField;
    qryDuplicatasSPCCODEMP: TStringField;
    qryDuplicatasSPCNOSNUM: TStringField;
    qryDuplicatasSPCCODCLI: TStringField;
    qryDuplicatasSPCNOMCLI: TStringField;
    qryDuplicatasSPCC_E_P_: TStringField;
    qryDuplicatasSPCDTACAD: TDateField;
    qryDuplicatasSPCDTAVEN: TDateField;
    qryDuplicatasSPCCARTEI: TStringField;
    qryDuplicatasSPCPORCEN: TFloatField;
    qryDuplicatasSPCVALDUP: TFloatField;
    qryDuplicatasSPCCODOCO: TStringField;
    qryDuplicatasSPCSTATUS: TStringField;
    qryDuplicatasSPCMOTIVOSPC: TStringField;
    qryDuplicatas: TUniQuery;
    frxDBDataset1: TfrxDBDataset;
    frxDuplicatas: TfrxReport;
    qryDuplicatasNUMDUP: TStringField;
    qryDuplicatasESPDOC: TStringField;
    qryDuplicatasCODEMP: TStringField;
    qryDuplicatasNOSNUM: TStringField;
    qryDuplicatasCODCLI: TStringField;
    qryDuplicatasNOMCLI: TStringField;
    qryDuplicatasC_E_P_: TStringField;
    qryDuplicatasDTACAD: TDateField;
    qryDuplicatasDTAVEN: TDateField;
    qryDuplicatasCARTEI: TStringField;
    qryDuplicatasPORCEN: TFloatField;
    qryDuplicatasVALDUP: TFloatField;
    qryDuplicatasCODOCO: TStringField;
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure qryDuplicatasSPCNUMDUPGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryDuplicatasSPCSTATUSGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure StringField1GetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure qryDuplicatasNUMDUPGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    FblnEnvPro : Boolean;
    procedure ImprimirSPC;
    procedure ImprimirRelatorio;
  public
    { Public declarations }
    {**************************************}
    {* PASSAR O NOME DO BANCO DA SEGUITE  *}
    {* FORMA 033 - BANESPA                *}
    {***********************************AF*}
    strNomBanco: String;

    property blnEnvPro: Boolean read FblnEnvPro write FblnEnvPro;
  end;

var
  frmRelRelDuplicatas: TfrmRelRelDuplicatas;

implementation

uses untfuncoesSimples, untConsultas, untCfgRel;

{$R *.dfm}

procedure TfrmRelRelDuplicatas.edtEmpresaExit(Sender: TObject);
begin
  If fEmptyStr(edtEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresa(fStrZero(edtEmpresa.Text,3));

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text)) Then
  Begin
    fMensagem('','Código da empresa não encontrado.',['&O K']);
    pSetFocus(edtEmpresa);
  End;
  
  inherited;
end;

procedure TfrmRelRelDuplicatas.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRelDuplicatas.edtClienteExit(Sender: TObject);
begin
  If fEmptyStr(edtCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(fStrZero(edtCliente.Text,8));

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCliente.Text)) Then
  Begin
    fMensagem('','Código do cliente não encontrado.',['&O K']);
    pSetFocus(edtCliente);
  End;

  inherited;
end;

procedure TfrmRelRelDuplicatas.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, Nil, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
      edtDesCliente.Text := fRetNomCliente(fStrZero(edtCliente.Text,8));
    End;
  End;
end;

procedure TfrmRelRelDuplicatas.FormCreate(Sender: TObject);
begin
  inherited;
  FblnEnvPro := False;
end;

procedure TfrmRelRelDuplicatas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If key = VK_RETURN Then
    If (ActiveControl Is TRadioGroup) or (ActiveControl Is TRadioButton) Then
    Begin
      pProximoControle(Sender);
    End;
end;

procedure TfrmRelRelDuplicatas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaConfImpr(qryCfgRel, Self.Name);
  pSetFocus(edtCliente);
end;

procedure TfrmRelRelDuplicatas.ImprimirSPC;
Var
  strSQL    : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CBI_NUMDUP, CBI_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '  CBI_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  CBI_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CBI_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '  CBI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  CLI_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  CBI_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CBI_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CBI_CARTEI AS CARTEI, ';
  strSQL := strSQL + '  ((IFNULL(CBI_VALDUP,0) * IFNULL(CBI_PORCEN,0)) /100) AS PORCEN, ';
  strSQL := strSQL + '  CBI_VALDUP AS VALDUP, ';
  strSQL := strSQL + '  CBI_CODOCO AS CODOCO ';
  strSQL := strSQL + ', CBI_STSSER AS STATUS ';
  strSQL := strSQL + ', CBI_MOTSPC AS MOTIVOSPC ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCBI ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = CBI_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CBI_CODBCO = :CODBCO ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + '  AND CBI_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtEmpresa.Text) Then
    strSQL := strSQL + '  AND CBI_CODEMP = :CODEMP ';

  strSQL := strSQL + 'ORDER BY ';

  // Ordenação
  If rdgOrdem.ItemIndex = 0 Then
    strSQL := strSQL + '  NUMDUP, CODEMP '
  Else
    strSQL := strSQL + '  NOMCLI, NUMDUP, CODEMP ';

  With qryDuplicatasSPC Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODBCO').AsString := LeftStr(strNomBanco,3);

    If Not fEmptyStr(edtCliente.Text) Then
      ParamByName('CODCLI').AsString := edtCliente.Text;

    If Not fEmptyStr(edtEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    Open;

    If Not IsEmpty Then
    Begin

      TfrxMemoView(frxDuplicatasSPC.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      frxDuplicatasSPC.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      frxDuplicatasSPC.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
      frxDuplicatasSPC.Script.Variables['NOMEFORM'] := '[frmRelRelDuplicatas]';

      If edtCliente.Text = '' Then
        frxDuplicatasSPC.Script.Variables['CLIENTE'] := 'CLIENTE: TODOS'
      Else
        frxDuplicatasSPC.Script.Variables['CLIENTE'] := 'CLIENTE: ' + edtCliente.Text +  ' - ' + edtDesCliente.Text;

      If edtEmpresa.Text = '' Then
        frxDuplicatasSPC.Script.Variables['EMPRESA'] := 'EMPRESA: TODAS'
      Else
        frxDuplicatasSPC.Script.Variables['EMPRESA'] := 'EMPRESA: ' + edtEmpresa.Text + ' - ' + edtDesEmpresa.Text;

      pPreviewReport(Self.Name, Self.Caption, frxDuplicatasSPC);

    End
    Else
    Begin
      fMensagem('','Não há dados para gerar relatório!',['&OK']);
    End;

  End;

end;

procedure TfrmRelRelDuplicatas.qryDuplicatasNUMDUPGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.Value + '-' + qryDuplicatasESPDOC.Value;
end;

procedure TfrmRelRelDuplicatas.qryDuplicatasSPCNUMDUPGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.Value + '-' + qryDuplicatasSPCESPDOC.Value;
end;

procedure TfrmRelRelDuplicatas.qryDuplicatasSPCSTATUSGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.Value = 'E' THEN
    Text := 'Exclusão'
  ELSE
    Text := 'Inclusão';
end;

procedure TfrmRelRelDuplicatas.StringField1GetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := Sender.Value + '-' + qryDuplicatasSPCESPDOC.Value;
end;

procedure TfrmRelRelDuplicatas.ImprimirRelatorio;
Var
  strSQL    : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(CBI_NUMDUP, CBI_PARCEL) AS NUMDUP, ';
  strSQL := strSQL + '  CBI_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  CBI_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CBI_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '  CBI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  CLI_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '  CBI_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CBI_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CBI_CARTEI AS CARTEI, ';
  strSQL := strSQL + '  ((IFNULL(CBI_VALDUP,0) * IFNULL(CBI_PORCEN,0)) /100) AS PORCEN, ';
  strSQL := strSQL + '  CBI_VALDUP AS VALDUP, ';
  strSQL := strSQL + '  CBI_CODOCO AS CODOCO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCBI ';
  strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = CBI_CODCLI ';
  strSQL := strSQL + 'WHERE ';

  If (Not FblnEnvPro) Then
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO '
  Else
    strSQL := strSQL + '  COALESCE(CBI_CODBCO , "") = "" ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + '  AND CBI_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtEmpresa.Text) Then
    strSQL := strSQL + '  AND CBI_CODEMP = :CODEMP ';

  strSQL := strSQL + 'ORDER BY ';

  If ckbQbrEmp.Checked Then
  Begin
    If rdgOrdem.ItemIndex = 0 Then
      strSQL := strSQL + '  CODEMP, NUMDUP '
    Else
      strSQL := strSQL + '  CODEMP, NOMCLI '
  End
  Else
  Begin
    If rdgOrdem.ItemIndex = 0 Then
      strSQL := strSQL + '  NUMDUP, CODEMP '
    Else
      strSQL := strSQL + '  NOMCLI, NUMDUP, CODEMP ';
  End;

  With qryDuplicatas Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not FblnEnvPro) Then
      ParamByName('CODBCO').AsString := LeftStr(strNomBanco,3);

    If Not fEmptyStr(edtCliente.Text) Then
      ParamByName('CODCLI').AsString := edtCliente.Text;

    If Not fEmptyStr(edtEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtEmpresa.Text;

    Open;

    If Not IsEmpty Then
    Begin

      {***********************************************************}
      { SE AGRUPO POR EMPRESA SETA O CODEMP NO GROUPHEADER SE NÃO }
      {  ENTÃO SETA TRUE = TRUE PARA NÃO REPETIR O CABEÇALHO.     }
      {***********************************************************}
      If ckbQbrEmp.Checked Then
      begin
        TfrxGroupFooter(frxDuplicatas.FindObject('GroupFooter1')).Visible := True;
        TfrxGroupHeader(frxDuplicatas.FindObject('GroupHeader1')).Condition := 'frxDBDataset1."CODEMP"';
      end
      else
      begin
        TfrxGroupFooter(frxDuplicatas.FindObject('GroupFooter1')).Visible := False;
        TfrxGroupHeader(frxDuplicatas.FindObject('GroupHeader1')).Condition := 'true = true';
      end;

      TfrxMemoView(frxDuplicatas.FindObject('mmoZebra')).Highlight.Color := fCfgSis('CORZEB');

      frxDuplicatas.Script.Variables['NOMEMP']   := fRetNomeEmpresa;
      frxDuplicatas.Script.Variables['BANCO']    := strNomBanco;
      frxDuplicatas.Script.Variables['DATAHORA'] := FormatDateTime('dd/mm/YYYY hh:mm:ss', fRetDataServidor + fRetHoraServidor);
      frxDuplicatas.Script.Variables['NOMEFORM'] := '[frmRelRelDuplicatas]';

      If edtCliente.Text = '' Then
        frxDuplicatas.Script.Variables['CLIENTE'] := 'CLIENTE: TODOS'
      Else
        frxDuplicatas.Script.Variables['CLIENTE'] := 'CLIENTE: ' + edtCliente.Text +  ' - ' + edtDesCliente.Text;

      If edtEmpresa.Text = '' Then
        frxDuplicatas.Script.Variables['EMPRESA'] := 'EMPRESA: TODAS'
      Else
        frxDuplicatas.Script.Variables['EMPRESA'] := 'EMPRESA: ' + edtEmpresa.Text + ' - ' + edtDesEmpresa.Text;

      pPreviewReport(Self.Name, Self.Caption, frxDuplicatas);

    End
    Else
    Begin
      fMensagem('','Não há dados para gerar relatório!',['&OK']);
    End;

  End;

end;

procedure TfrmRelRelDuplicatas.btnImprimirClick(Sender: TObject);
  Var
    LImpressoraPadrao: String;
begin
  inherited;
  edtClienteExit(Sender);
  edtEmpresaExit(Sender);

  If Not TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    LImpressoraPadrao := TCfgRel.fGetImpPadraoWindows;
    If Not qryCfgRel.FieldByName('REL_NOMFIL').AsString.IsEmpty Then
      LImpressoraPadrao := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

    If fEmptyStr(LImpressoraPadrao) Or (TCfgRel.VerImpressoraONLINE(LImpressoraPadrao,False) <> 0) Then
    Begin
      TCfgRel.fMensagem('ATENÇÃO!', 'Impressora padrão indisponível ou não encontrada, '+
                                    'portanto o botão [Imprimir] estará desabilitado na pré-visualização.', ['&OK']);
      frxDuplicatas.PreviewOptions.Buttons := [pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator,pbExportQuick];
    End;
  End;

  IF LeftStr(strNomBanco,3) = 'SPC' THEN
    ImprimirSPC
  else
    ImprimirRelatorio;

  btnImprimir.Enabled := True;
end;

end.

