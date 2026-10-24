unit untCfgGavetaImpNaoFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, ComboBoxFocus, EditFocus;

type
  TfrmCfgGavetaImpNaoFiscal = class(TfrmPai)
    Label2: TLabel;
    btnLocImp: TBitBtnLocked;
    edtImpressora: TEditFocus;
    Label3: TLabel;
    cbxModImpGav: TComboBoxFocus;
    btnGravar: TBitBtnLocked;
    procedure btnLocImpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaArqIni;
    procedure pGravaArqIni;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untTypesSistema, untCfgRel;


{$R *.dfm}

procedure TfrmCfgGavetaImpNaoFiscal.btnGravarClick(Sender: TObject);
begin
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

procedure TfrmCfgGavetaImpNaoFiscal.btnLocImpClick(Sender: TObject);
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

procedure TfrmCfgGavetaImpNaoFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  pImpressorasConfGaveta(cbxModImpGav.Items);
  pCarregaArqIni;

  If VS_SpoolImpressaoCitel Then
  Begin
    edtImpressora.ReadOnly    := True;
    edtImpressora.TabStop     := False;
    edtImpressora.Color       := $00FFDFB8;
    edtImpressora.NormalColor := $00FFDFB8;
    edtImpressora.FocusColor  := $00FFDFB8;
  End;
end;

procedure TfrmCfgGavetaImpNaoFiscal.pCarregaArqIni;
Var
  LstrDirIni: String;
begin
  LstrDirIni := fCfgSis('PTNGAV');

  If (fEmptyStr(LstrDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações da gaveta (CFG_PTNGAV).');
    Exit;
  End;

  edtImpressora.Text := fArqIniLocal(0, 'GAVETA', 'IMPRESSORA', '', LstrDirIni + '\opcoes_gaveta.ini');
  cbxModImpGav.ItemIndex := cbxModImpGav.Items.IndexOf(fArqIniLocal(0, 'GAVETA', 'MODELO_IMP_GAVETA', 'NENHUM', LstrDirIni + '\opcoes_gaveta.ini'));
end;

procedure TfrmCfgGavetaImpNaoFiscal.pGravaArqIni;
Var
  LstrDirIni: String;
begin
  LstrDirIni := fCfgSis('PTNGAV');

  If (fEmptyStr(LstrDirIni)) Then
  Begin
    pMensagemOk('Por favor, configure o path para configurações da gaveta (CFG_PTNGAV).');
    Exit;
  End;

  fArqIniLocal(1, 'GAVETA', 'IMPRESSORA', edtImpressora.Text, LstrDirIni + '\opcoes_gaveta.ini');
  fArqIniLocal(1, 'GAVETA', 'MODELO_IMP_GAVETA', cbxModImpGav.Text, LstrDirIni + '\opcoes_gaveta.ini');
end;

end.
