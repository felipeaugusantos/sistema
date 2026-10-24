unit untCfgNFCe;

interface

uses
  Windows, Classes, Controls, Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, EditFocus, QColorLabel, Vcl.Mask, FilenameEditFocus,
  frxClass, frxExportCSVTestabilidade, SysUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  Printers, ComboBoxFocus;

type
  TfrmCfgNFCe = class(TfrmPai)
    pnlCentral: TPanel;
    btnGravar: TBitBtnLocked;
    Label1: TLabel;
    edtNumPdv: TEditFocus;
    Label2: TLabel;
    edtImpressora: TEditFocus;
    ColorLabel2: TColorLabel;
    edtUsaTef: TEditFocus;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    Label3: TLabel;
    edtDarumaPathDll: TFilenameEditFocus;
    edtMargem: TEditFocus;
    Label4: TLabel;
    btnLocImp: TBitBtnLocked;
    cbxModImpGav: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnLocImpClick(Sender: TObject);
  private
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    function fImpressoraKey(): String;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses Forms, untFuncoesSimples, untTypesSistema, untCfgRel;

{$R *.dfm}

procedure TfrmCfgNFCe.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumPdv);
end;

procedure TfrmCfgNFCe.FormCreate(Sender: TObject);
begin
  inherited;
  pImpressorasConfGaveta(cbxModImpGav.Items);
  pCarregaArqIni;

  edtDarumaPathDll.Dialog.Dialog.Filter := 'Arquivos DLL|*.dll';

  If VS_SpoolImpressaoCitel Then
  Begin
    edtImpressora.ReadOnly    := True;
    edtImpressora.TabStop     := False;
    edtImpressora.Color       := $00FFDFB8;
    edtImpressora.NormalColor := $00FFDFB8;
    edtImpressora.FocusColor  := $00FFDFB8;
  End;

end;

function TfrmCfgNFCe.fImpressoraKey(): String;
begin
  If VS_SpoolImpressaoCitel Then
    Result := 'PONTO_IMPRESSAO'
  Else
    Result := 'IMPRESSORA';
end;

procedure TfrmCfgNFCe.pCarregaArqIni;
  Var
    strDirIni: String;
begin
  strDirIni := fCfgSis('PTNFCE');

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações de NFCe.');
    Exit;
  End;

  edtNumPdv.Text := fArqIniLocal(0, 'NFCE', 'PDV', '', strDirIni + '\opcoes_nfce.ini');
  edtImpressora.Text := fArqIniLocal(0, 'NFCE', fImpressoraKey, '', strDirIni + '\opcoes_nfce.ini');
  edtUsaTef.Text := fArqIniLocal(0, 'NFCE', 'TEF', 'N', strDirIni + '\opcoes_nfce.ini');
  edtDarumaPathDll.Text := fArqIniLocal(0, 'NFCE', 'DARUMA_PATH_DLL', '', strDirIni + '\opcoes_nfce.ini');
  cbxModImpGav.ItemIndex := cbxModImpGav.Items.IndexOf(fArqIniLocal(0, 'NFCE', 'MODELO_IMP_GAVETA', 'NENHUM', strDirIni + '\opcoes_nfce.ini'));
  edtMargem.Text := fArqIniLocal(0, 'NFCE', 'MARGEM', '0', strDirIni + '\opcoes_nfce.ini');
end;

procedure TfrmCfgNFCe.pGravaArqIni;
  Var
    strDirIni: String;
begin
  strDirIni := fCfgSis('PTNFCE');

  If (fEmptyStr(strDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações de NFCe.');
    Exit;
  End;

  fArqIniLocal(1, 'NFCE', 'PDV', edtNumPdv.Text, strDirIni + '\opcoes_nfce.ini');
  fArqIniLocal(1, 'NFCE', fImpressoraKey, edtImpressora.Text, strDirIni + '\opcoes_nfce.ini');
  fArqIniLocal(1, 'NFCE', 'TEF', edtUsaTef.Text, strDirIni + '\opcoes_nfce.ini');
  fArqIniLocal(1, 'NFCE', 'DARUMA_PATH_DLL', edtDarumaPathDll.Text, strDirIni + '\opcoes_nfce.ini');
  fArqIniLocal(1, 'NFCE', 'MODELO_IMP_GAVETA', cbxModImpGav.Text, strDirIni + '\opcoes_nfce.ini');
  fArqIniLocal(1, 'NFCE', 'MARGEM', edtMargem.Text, strDirIni + '\opcoes_nfce.ini');
end;

procedure TfrmCfgNFCe.btnGravarClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtImpressora.Text)) And
     (Not fImpressoraExiste(edtImpressora.Text)) Then
  Begin
    If fMensagem('AVISO', 'A impressora informada não foi encontrada, deseja continuar mesmo assim?', ['&Sim', '&Não']) = 2 Then
    Begin
      pSetFocus(edtImpressora);
      Exit;
    End;
  End;

  pGravaArqIni;
  Close;
end;

procedure TfrmCfgNFCe.btnLocImpClick(Sender: TObject);
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

end.
