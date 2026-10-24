unit untConsultaContatosEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, Vcl.StdCtrls,
  EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, untTEnvioEmail, Uni;

type
  TfrmConsultaContatosEmail = class(TfrmPai)
    grbPesquisa: TGroupBox;
    edtContato: TEditFocus;
    cmbDestino: TComboBox;
    grbContatosSelecionados: TGroupBox;
    lblPara: TLabel;
    lblComCopia: TLabel;
    lblComCopiaOculta: TLabel;
    edtPara: TEditFocus;
    edtComCopia: TEditFocus;
    edtComCopiaOculta: TEditFocus;
    grbContatos: TGroupBox;
    btnConfirmar: TBitBtnLocked;
    btnCadContato: TBitBtnLocked;
    btnLimpar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtContatoChange(Sender: TObject);
    procedure edtContatoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCadContatoClick(Sender: TObject);
    procedure cmbDestinoChange(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
    objListaContatos: TListaContatosEmail;
    function fGetEditFocus: TEditFocus;
    procedure pDefinirEditDestinoFiltro(AItemIndex: Integer);
  public
    { Public declarations }
    intTipoDestino: Integer;
    strPara, strComCopia, strComCopiaOculta: String;
  end;

var
  frmConsultaContatosEmail: TfrmConsultaContatosEmail;

Const
  IDX_PARA = 0; IDX_COM_COPIA = 1; IDX_COM_COPIA_OCULTA = 2;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadContatosEmail;

procedure TfrmConsultaContatosEmail.btnCadContatoClick(Sender: TObject);
var
  frmCadContatosEmail: TfrmCadContatosEmail;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadContatosEmail, frmCadContatosEmail);
    frmCadContatosEmail.ShowModal();

    objListaContatos.pAtualizarListaContatos();
  Finally
    FreeAndNil(frmCadContatosEmail);
  End;
end;

procedure TfrmConsultaContatosEmail.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  strPara           := edtPara.Text;
  strComCopia       := edtComCopia.Text;
  strComCopiaOculta := edtComCopiaOculta.Text;

  btnSair.Click();
end;

procedure TfrmConsultaContatosEmail.btnLimparClick(Sender: TObject);
begin
  inherited;

  edtPara.Text           := '';
  edtComCopia.Text       := '';
  edtComCopiaOculta.Text := '';
end;

procedure TfrmConsultaContatosEmail.cmbDestinoChange(Sender: TObject);
begin
  inherited;

  pDefinirEditDestinoFiltro(cmbDestino.ItemIndex);
end;

procedure TfrmConsultaContatosEmail.edtContatoChange(Sender: TObject);
begin
  inherited;

  pDefinirEditDestinoFiltro(cmbDestino.ItemIndex);
end;

procedure TfrmConsultaContatosEmail.edtContatoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DOWN) Then Begin
    objListaContatos.lsbContatos.ItemIndex := 0;
    pSetFocus(objListaContatos.lsbContatos);
  End
end;

procedure TfrmConsultaContatosEmail.FormCreate(Sender: TObject);
begin
  inherited;

  Try
    intTipoDestino := 0;

    strPara           := '';
    strComCopia       := '';
    strComCopiaOculta := '';

    objListaContatos := TListaContatosEmail.Create(Self, strLoginUsuarioLogado, toConsultaContatos);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaContatosEmail.FormCreate]');
  End;
end;

procedure TfrmConsultaContatosEmail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Assigned(Self.ActiveControl)) And
     (objListaContatos.lsbContatos.Visible) And
     (
       ((Self.ActiveControl) = edtContato) Or
       ((Self.ActiveControl) = objListaContatos.lsbContatos)
     ) Then Begin
    If (Key = VK_RETURN) Then Begin
      If (Not fEmptyStr(objListaContatos.pSelecionarFiltroString(fGetEditFocus().Text + edtContato.Text))) Then Begin
        If ((Self.ActiveControl) = edtContato) Then
          objListaContatos.pSelecionarContato(0)
        Else
          objListaContatos.pSelecionarContato(objListaContatos.lsbContatos.ItemIndex);

        edtContato.Text := '';
        Key := 0;
      End;
    End;
  End;

  inherited;

  Case (Key) Of
    VK_F10: btnConfirmar.Click();

    VK_F4: btnCadContato.Click();

    VK_F11: btnLimpar.Click();
  End;
end;

procedure TfrmConsultaContatosEmail.FormShow(Sender: TObject);
  Var
    edtTemp: TEditFocus;
begin
  Try
    inherited;

    edtPara.Text           := strPara;
    edtComCopia.Text       := strComCopia;
    edtComCopiaOculta.Text := strComCopiaOculta;

    cmbDestino.ItemIndex := intTipoDestino;

    edtTemp := fGetEditFocus();

    objListaContatos.pFiltrarContatos('', edtContato, edtTemp);
    objListaContatos.pExibirListagem(True, grbContatos);

    If (Not edtComCopia.Visible) Then
      grbContatosSelecionados.Height := grbContatosSelecionados.Height - edtComCopia.Height - 6;

    If (Not edtComCopiaOculta.Visible) Then
      grbContatosSelecionados.Height := grbContatosSelecionados.Height - edtComCopiaOculta.Height - 6;

    pSetFocus(edtContato);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmConsultaContatosEmail.FormShow]');
  End;
end;

procedure TfrmConsultaContatosEmail.pDefinirEditDestinoFiltro(AItemIndex: Integer);
begin
  Case (AItemIndex) Of
    IDX_PARA:
      objListaContatos.pFiltrarContatos(edtContato.Text, edtContato, edtPara);
    IDX_COM_COPIA:
      objListaContatos.pFiltrarContatos(edtContato.Text, edtContato, edtComCopia);
    IDX_COM_COPIA_OCULTA:
      objListaContatos.pFiltrarContatos(edtContato.Text, edtContato, edtComCopiaOculta);
    Else Begin
      fMensagem('ALERTA!', 'Selecione um tipo de destino para a pesquisa de contato.', ['&OK']);
      pSetFocus(cmbDestino);
    End;
  End;
end;

function TfrmConsultaContatosEmail.fGetEditFocus: TEditFocus;
begin
  Case (cmbDestino.ItemIndex) Of
    IDX_PARA:
      Result := edtPara;
    IDX_COM_COPIA:
      Result := edtComCopia;
    IDX_COM_COPIA_OCULTA:
      Result := edtComCopiaOculta;
    Else Begin
      cmbDestino.ItemIndex := IDX_PARA;
      Result := edtPara;
    End;
  End;
end;

end.
