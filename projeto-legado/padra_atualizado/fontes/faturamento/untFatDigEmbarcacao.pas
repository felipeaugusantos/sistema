unit untFatDigEmbarcacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus;

type
  TfrmFatDigEmbarcacao = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    pnlFundo: TPanel;
    lblNomEmb: TLabel;
    edtCodEmb: TEditFocus;
    edtNomEmb: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodEmb: String;
    strCodCli: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatDigEmbarcacao: TfrmFatDigEmbarcacao;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema;

procedure TfrmFatDigEmbarcacao.btnCancelarClick(Sender: TObject);
begin
  inherited;

  Self.Close();
end;

procedure TfrmFatDigEmbarcacao.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  strCodEmb := fCampoTabela('AUTOINCREM', 'CADEMB', ['EMB_CODEMB'], [edtCodEmb.Text], False);
  btnCancelar.Click();
end;

procedure TfrmFatDigEmbarcacao.edtCodEmbKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCadEmb: TConsultasArray;
begin
  inherited;

  If fPesqCadastroEmbarcacoes(Self, edtCodEmb, edtNomEmb, Nil, Key, arrCadEmb, True, strCodCli) Then Begin
    If fValidaCampos(edtCodEmb, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigEmbarcacao.FormCreate(Sender: TObject);
begin
  inherited;

  strCodEmb := '';
  strCodCli := '';
end;

procedure TfrmFatDigEmbarcacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnCancelar.Click();

  If (Key = VK_F10) Then
    btnConfirmar.Click();
end;

procedure TfrmFatDigEmbarcacao.FormShow(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(strCodEmb)) Then Begin
    edtCodEmb.Text := strCodEmb;
    edtNomEmb.Text := fRetNomEmbarcacao(edtCodEmb.Text);
  End;

  pSetFocus(edtCodEmb);
end;

function TfrmFatDigEmbarcacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then Begin

    If (Sender = edtCodEmb) Then Begin
      If (Not fEmptyStr(edtCodEmb.Text)) Then Begin
        edtNomEmb.Text := fRetNomEmbarcacao(edtCodEmb.Text);

        If (fEmptyStr(edtNomEmb.Text)) Then Begin
          fMensagem('ATENÇÃO!', 'Código de embarcação não é válido. Verifique!', ['&OK']);
          Result := False;
        End Else Begin
          If (Not fEmptyStr(edtCodEmb.Text)) And
             (Not fEmbarcacaoVinculadaCliente(strCodCli, edtCodEmb.Text)) Then Begin
            fMensagem('','A Embarcação selecionada não está vinculada ao cliente informado!',['&OK']);
            edtCodEmb.Text := '';
            edtNomEmb.Text := '';
            Result := False;
          End;
        End;
      End Else Begin
        edtNomEmb.Text := '';
      End;;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
