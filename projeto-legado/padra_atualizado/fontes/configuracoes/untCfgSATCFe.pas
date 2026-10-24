unit untCfgSATCFe;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus,
  QColorLabel, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, FilenameEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmCfgSATCFe = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    ColorLabel2: TColorLabel;
    Label8: TLabel;
    edtNumPdv: TEditFocus;
    edtImpressora: TEditFocus;
    edtUsaTef: TEditFocus;
    btnGravar: TBitBtnLocked;
    Label6: TLabel;
    Label3: TLabel;
    edtCodigoAtivacao: TEditFocus;
    edtAssinaturaAC: TEditFocus;
    Label4: TLabel;
    cbxModImpGav: TComboBox;
    Label5: TLabel;
    edtPatDll: TFilenameEditFocus;
    edtMargem: TEditFocus;
    Label7: TLabel;
    chkUsaSat: TCheckBox;
    chkGravarSessao: TCheckBox;
    btnLocImp: TBitBtnLocked;
    edtNumSer: TEditFocus;
    Label9: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnLocImpClick(Sender: TObject);
  private
    { Private declarations }
    function fImpressoraKey(): String;
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, System.StrUtils, untCfgRel;

{ TfrmCfgSATCFe }

procedure TfrmCfgSATCFe.btnLocImpClick(Sender: TObject);
Var
  strNomImp, strTipImp: String;
begin
  inherited;
  If fCfgSis('CADIMP', VarBoolean) Or TCfgRel.VS_SpoolImpressaoCitel Then
  Begin
    If TCfgRel.fSelecionaFila('','','','',strNomImp,strTipImp,True) Then
    Begin
      edtImpressora.Text := strNomImp;
      SelectNext(ActiveControl, True, True);
    End;
  End
  Else If (TCfgRel.fExecutePrintDialog(strNomImp)) Then
  Begin
    If fEmptyStr(strNomImp) Then
      strNomImp := TCfgRel.fGetImpressoraSelecionada;
    edtImpressora.Text := strNomImp;
    SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCfgSATCFe.fImpressoraKey(): String;
begin
  If VS_SpoolImpressaoCitel Then
    Result := 'PONTO_IMPRESSAO'
  Else
    Result := 'IMPRESSORA';
end;

procedure TfrmCfgSATCFe.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravaArqIni;
  Close;
end;

procedure TfrmCfgSATCFe.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumPdv);
end;

procedure TfrmCfgSATCFe.FormCreate(Sender: TObject);
begin
  inherited;
  chkUsaSat.Visible := fCfgSis('SATECF', varBoolean);
  pImpressorasConfGaveta(cbxModImpGav.Items);
  pCarregaArqIni;

  edtPatDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';

  If VS_SpoolImpressaoCitel Then
  Begin
    edtImpressora.ReadOnly    := True;
    edtImpressora.TabStop     := False;
    edtImpressora.Color       := $00FFDFB8;
    edtImpressora.NormalColor := $00FFDFB8;
    edtImpressora.FocusColor  := $00FFDFB8;
  End;
end;

procedure TfrmCfgSATCFe.pCarregaArqIni;
  Var
    strDirIni: String;
begin
  strDirIni := fCfgSis('PATSAT');

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações do SAT-CFe.');
    Exit;
  End;

  edtNumPdv.Text := fArqIniLocal(0, 'SATCFE', 'PDV', '', strDirIni + '\opcoes_sat.ini');
  edtImpressora.Text := fArqIniLocal(0, 'SATCFE', fImpressoraKey, '', strDirIni + '\opcoes_sat.ini');
  edtUsaTef.Text := fArqIniLocal(0, 'SATCFE', 'TEF', 'N', strDirIni + '\opcoes_sat.ini');
  edtCodigoAtivacao.Text := fArqIniLocal(0, 'SATCFE', 'CODIGO_ATIVACAO', '', strDirIni + '\opcoes_sat.ini');
  edtPatDll.Text := fArqIniLocal(0, 'SATCFE', 'PATHDLL', '', strDirIni + '\opcoes_sat.ini');
  edtAssinaturaAC.Text := fArqIniLocal(0, 'SATCFE', 'ASSINATURA_AC', '', strDirIni + '\opcoes_sat.ini');
  cbxModImpGav.ItemIndex := cbxModImpGav.Items.IndexOf(fArqIniLocal(0, 'SATCFE', 'MODELO_IMP_GAVETA', 'NENHUM', strDirIni + '\opcoes_sat.ini'));
  edtMargem.Text := fArqIniLocal(0, 'SATCFE', 'MARGEM', '0', strDirIni + '\opcoes_sat.ini');
  chkUsaSat.Checked := StrToBool( fArqIniLocal(0, 'SATCFE', 'USASAT', '0', strDirIni + '\opcoes_sat.ini') );
  chkGravarSessao.Checked := (fArqIniLocal(0, 'SATCFE', 'GRAVAR_SESSAO', 'N', strDirIni + '\opcoes_sat.ini') = 'S');
  edtNumSer.Text := fArqIniLocal(0, 'SATCFE', 'NUMERO_SERIE', '', strDirIni + '\opcoes_sat.ini');
end;

procedure TfrmCfgSATCFe.pGravaArqIni;
  Var
    strDirIni: String;
begin
  strDirIni := fCfgSis('PATSAT');

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações do SAT-CFe.');
    Exit;
  End;

  fArqIniLocal(1, 'SATCFE', 'PDV', edtNumPdv.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', fImpressoraKey, edtImpressora.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'TEF', edtUsaTef.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'CODIGO_ATIVACAO', edtCodigoAtivacao.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'PATHDLL', edtPatDll.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'ASSINATURA_AC', edtAssinaturaAC.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'MODELO_IMP_GAVETA', cbxModImpGav.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'MARGEM', edtMargem.Text, strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'USASAT', IfThen(chkUsaSat.Checked, '1', '0'), strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'GRAVAR_SESSAO', IfThen(chkGravarSessao.Checked, 'S', 'N'), strDirIni + '\opcoes_sat.ini');
  fArqIniLocal(1, 'SATCFE', 'NUMERO_SERIE', edtNumSer.Text, strDirIni + '\opcoes_sat.ini');
end;

end.
