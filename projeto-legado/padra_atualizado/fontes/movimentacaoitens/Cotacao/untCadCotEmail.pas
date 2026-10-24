unit untCadCotEmail;

interface

uses
  Windows, Classes, Controls, Forms, untPaiEdit, StdCtrls, EditFocus, ExtCtrls,
  AppEvnts, Menus, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untSalvaDadosInterface;

type
  TfrmCadCotEmail = class(TfrmPaiEdit)
    rdgGerArq: TRadioGroup;
    grbInfEma: TGroupBox;
    chkEnvEma: TCheckBox;
    Label1: TLabel;
    edtEmail: TEditFocus;
    Label2: TLabel;
    edtContato: TEditFocus;
    lblFornecedor: TLabel;
    chkExbAplicProd: TCheckBox;
    btnConfirma: TBitBtnLocked;
    rdgOrdenacao: TRadioGroup;
    chkMsgLivre: TCheckBox;
    rdgOpcIte: TRadioGroup;
    rdgTipoCod: TRadioGroup;
    rdgFormato: TRadioGroup;
    chkExbMarca: TCheckBox;
    grpExpColunas: TGroupBox;
    chkReferencia: TCheckBox;
    chkSemelhantes: TCheckBox;
    chkCna: TCheckBox;
    chkExportarSemPreco: TCheckBox;
    procedure chkEnvEmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkExbMarcaClick(Sender: TObject);
    procedure rdgGerArqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
     objSalInt: TSalvaInterface;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses SysUtils, untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadCotEmail.chkEnvEmaClick(Sender: TObject);
begin
  inherited;

  grbInfEma.Enabled := chkEnvEma.Checked;

end;

function TfrmCadCotEmail.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) And chkEnvEma.Checked Then
  Begin

    If (fEmptyStr(edtEmail.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Pos('@', edtEmail.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtContato) And chkEnvEma.Checked  Then
  Begin
    If (fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadCotEmail.rdgGerArqClick(Sender: TObject);
begin
  inherited;
  grpExpColunas.Enabled := rdgGerArq.ItemIndex = 0;
end;

procedure TfrmCadCotEmail.chkExbMarcaClick(Sender: TObject);
begin
  inherited;
  If rdgOrdenacao.Items.Count = 4 Then
    rdgOrdenacao.Items.Delete(2);
  If chkExbMarca.Checked Then
    rdgOrdenacao.Items.Insert(2,'Marca + Descrição do Item');
end;

procedure TfrmCadCotEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  objSalInt.fSalvaDados('', Self.Name, strLoginUsuarioLogado, True);
  If (ModalResult = mrOK) And (Not fVerificaCampos) Then
    Action := caNone;

end;

procedure TfrmCadCotEmail.FormCreate(Sender: TObject);
begin
  inherited;
  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.fCarregaDados('', Self, Self.Name, strLoginUsuarioLogado);
end;

procedure TfrmCadCotEmail.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(TWinControl(rdgGerArq.Controls[0]));
  chkExbMarcaClick(chkExbMarca);
end;

end.
