unit untCadQuestFidelidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, untMskC_G_C_, EditFocus,
  untMskTelefone;

type
  TfrmCadQuestFidelidade = class(TfrmPai)
    pnlGeral: TPanel;
    lblDocumento: TLabel;
    edtCgcCpf: TEditFocus;
    edtNumCgc: TMaskEditC_G_C_;
    btnConfirmaDados: TBitBtnLocked;
    lblNome: TLabel;
    lblTelefone: TLabel;
    lblEmail: TLabel;
    edtNome: TEditFocus;
    edtEmail: TEditFocus;
    edtTelefone: TMaskEditTelefone;
    pnlQuest: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblQuestPontos: TLabel;
    lblQuestValor: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    memHistoricoQuest: TMemo;
    memOfertasQuest: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    blnEhCadastro: Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pHabilitaCampos(blnHabilita: Boolean);
    { Public declarations }
  end;

var
  frmCadQuestFidelidade: TfrmCadQuestFidelidade;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmCadQuestFidelidade }

procedure TfrmCadQuestFidelidade.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  if (fEmptyStr(edtEmail.Text)) and (fEmptyStr(edtTelefone.Text)) then
  begin
    fMensagem('ATENÇÃO', 'Preencha o telefone ou o e-mail do cliente!', ['&Ok']);
    pSetFocus(edtTelefone);
    Exit;
  end;
  If (fVerificaCampos) then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmCadQuestFidelidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if not blnEhCadastro then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TfrmCadQuestFidelidade.FormShow(Sender: TObject);
begin
  inherited;
  if blnEhCadastro then
  begin
    pSetFocus(edtCgcCpf);
  end
  else
  begin
    pSetFocus(btnConfirmaDados);
  end;
end;

function TfrmCadQuestFidelidade.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  if blnEhCadastro then
  begin
    If (Sender = edtCgcCpf) Then
    Begin
      If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O tipo de documeto deve ser preenchido', ['&Ok']);
        pSetFocus(edtCgcCpf);
      End;
    End

    Else If (Sender = edtTelefone) Then
    Begin
      If (not fEmptyStr(edtTelefone.Text)) and (Not fValidaCelular(edtTelefone.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um celular válido!', ['&Ok']);
        Result := False;
        pSetFocus(edtTelefone);
      End;
    End

    Else If (Sender = edtEmail) Then
    Begin
      If (not fEmptyStr(edtEmail.Text)) and (Not fEnderecoEmailValido(edtEmail.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o e-mail corretamente!', ['&Ok']);
        Result := False;
        pSetFocus(edtEmail);
      End;
    End

    Else If (Sender = edtNumCgc) Then
    Begin
      If fEmptyStr(edtNumCgc.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O Número do documento não pode ser vazio', ['&Ok']);
        pSetFocus(edtNumCgc);
      End
      Else
      Begin
        Result := fValidaCnpjCpf(edtCgcCpf.Text, edtNumCgc.Text, False);
        pSetFocus(edtNumCgc);
      End;
    End;
  end;
end;

procedure TfrmCadQuestFidelidade.pHabilitaCampos(blnHabilita: Boolean);
begin
  edtCgcCpf.Enabled   := blnHabilita;
  edtNumCgc.Enabled   := blnHabilita;
  edtNome.Enabled     := blnHabilita;
  edtEmail.Enabled    := blnHabilita;
  edtTelefone.Enabled := blnHabilita;
  blnEhCadastro       := blnHabilita;

  if blnHabilita then
  begin
    Self.Caption := 'Pré Cadastro Quest Fidelidade';
    pnlQuest.Visible := False;
    Self.Height := 162;
  end
  else
  begin
    Self.Caption := 'Informações do cliente Quest Fidelidade';
    pnlQuest.Visible := True;
    Self.Height := 605;
  end;
end;

end.
