unit untAltPrecoRecalc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, untFuncoesSimples,  BitBtnLockedIncrem,
  EditFocus, untConsultas, untFuncoesConsulta, frxClass,
  frxExportCSVTestabilidade, untTypesSistema ,untTypesTabelaPreco;

type
  TfrmAltPrecoRecalc = class(TfrmPaiConfirma)
    pgbProIte: TProgressBar;
    lblContReg: TLabel;
    pnlTipAlt: TPanel;
    rdgTipAltGer: TRadioGroup;
    pnlTabPre: TPanel;
    chkRecCus: TCheckBox;
    lbl1: TLabel;
    edtTabPre: TEditFocus;
    edtNomTab: TEditFocus;
    lbl2: TLabel;
    edtCodAbf: TEditFocus;
    edtDesAbf: TEditFocus;
    rdgTipoCalc: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTabPreExit(Sender: TObject);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbfKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbfExit(Sender: TObject);
  private
    { Private declarations }
    arrTabPre: TConsultasArray;
    arrAbf: TConsultasArray;

    Function fRecalculaPrecos: Boolean;
  public
    { Public declarations }
    blnSoIcms: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmAltPrecoRecalc: TfrmAltPrecoRecalc;

implementation

uses
  untCalculaComposicaoCusto;

{$R *.dfm}

//Uses untRecalculaPreco;

procedure TfrmAltPrecoRecalc.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  btnConfirma.Enabled := False;
  btnSair.Enabled     := False;
  Self.Enabled        := False;
  rdgTipAltGer.Enabled:= False;

  If fVerificaCampos And fPergunta('Confirma o recálculo dos preços?') Then
  Begin

    If fRecalculaPrecos Then
    Begin
      pMensagemOk('Operação concluida com sucesso!');
      Close;
    End;

  End;

  btnConfirma.Enabled := True;
  btnSair.Enabled     := True;
  Self.Enabled        := True;
  rdgTipAltGer.Enabled:= True;
end;

procedure TfrmAltPrecoRecalc.edtCodAbfExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAbf, edtDesAbf, arrAbf, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');

end;

procedure TfrmAltPrecoRecalc.edtCodAbfKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAbrevFiscal(Self, edtCodAbf, edtDesAbf, Nil, Key, arrAbf) Then
  Begin
    If fValidaCampos(edtCodAbf, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoRecalc.edtTabPreExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtTabPre,edtNomTab,arrTabPre,fRetNomeTabelaPreco,nil,'do Fornecedor');

end;

procedure TfrmAltPrecoRecalc.edtTabPreKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrTabPre, True, '') Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      pProximoControle(edtTabPre);
  End;


end;

procedure TfrmAltPrecoRecalc.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodAbf.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  blnSoIcms := False;

end;

procedure TfrmAltPrecoRecalc.FormShow(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodAbf.Text) Then
  Begin
    edtDesAbf.Text := fRetDesAbfIcm(edtCodAbf.Text);
  End;

  If blnSoIcms Then
  Begin
    Self.Height := Self.Height - pnlTipAlt.Height;
    pnlTipAlt.Visible := False;
    Caption := 'RECALCULA ICMS DE SAÍDA E SUBUSTITUIÇÃO TRIBUTÁRIA';

    pSetFocus(chkRecCus);
  End Else
  Begin

    If fCfgSis('FORCAL', varString) = 'P' Then
      pSetFocus(rdgTipAltGer.Controls[0] As TWinControl)
    Else
      pSetFocus(rdgTipAltGer.Controls[1] As TWinControl);

  End;
end;

Function TfrmAltPrecoRecalc.fRecalculaPrecos: Boolean;
var OpcRecalculoTabelas: TOpcRecalculoTabelas;
Begin
  OpcRecalculoTabelas.TipoCalculoMargemPreven := IIf(rdgTipAltGer.ItemIndex = 0, tcmVenda, tcmMargem);
  OpcRecalculoTabelas.OpcTabelasReprocessa := IIf(rdgTipoCalc.ItemIndex = 0, topctrTodas, topctrApenasAtivas);

  Try
    Result := TCalculaComposicaoCusto.fCalculaAlteracaoGeral('Alteração de Preço', edtCodAbf.Text, edtTabPre.Text, OpcRecalculoTabelas, True)

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAltPrecoRecalc.pRecalculaPrecos]');
    End;
  End;

  lblContReg.Visible := False;
End;

function TfrmAltPrecoRecalc.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtTabPre) Then
    Begin

    End

    Else If (Sender = edtCodAbf) Then
    Begin

    End;

  End;

  If Not Result Then
    If Sender.CanFocus Then
      pSetFocus(Sender);
end;

end.
