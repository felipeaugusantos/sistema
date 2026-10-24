unit untDigEmailPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, untFuncoes, untfuncoesSimples, AppEvnts;

type
  TfrmDigEmailPedidoCompra = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtEmail: TEditFocus;
    edtContato: TEditFocus;
    btnConfirma: TBitBtn;
    gbPreco: TGroupBox;
    ColorLabel2: TColorLabel;
    edtPreco: TEditFocus;
    gbOrdem: TGroupBox;
    ColorLabel3: TColorLabel;
    edtOrdem: TEditFocus;
    gbExporta: TGroupBox;
    ColorLabel1: TColorLabel;
    edtTipExp: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnSemPre : Boolean;
    blnOrdDig : Boolean;
    strTipExp : String;
  end;

var
  frmDigEmailPedidoCompra: TfrmDigEmailPedidoCompra;

implementation

{$R *.dfm}

function TfrmDigEmailPedidoCompra.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) Then
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

  Else If (Sender = edtContato) Then
  Begin
    If (fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
  End

  {****************************}
  {* VERIFICA CAMPO PREÇO     *}
  {*************************LU*}
  Else
  If (Sender = edtPreco) Then
  Begin
    If (edtPreco.Text <> 'C') And (edtPreco.Text <> 'S') Then
    Begin
      fMensagem('','O campo Preço deve ser C ou S.',['&O K']);
      Result := False;
    End;
  End
  {****************************}
  {* VERIFICA CAMPO ORDEM     *}
  {*************************LU*}
  Else
  If (Sender = edtOrdem) Then
  Begin
    If (edtOrdem.Text <> 'D') And (edtOrdem.Text <> 'A') Then
    Begin
      fMensagem('','O campo Ordem deve ser D ou A.',['&O K']);
      Result := False;
    End;
  End
  {*****************************}
  {* VERIFICA CAMPO EXPORTACAO *}
  {**************************LU*}
  Else
  If (Sender = edtTipExp) Then
  Begin
    If (edtTipExp.Text <> 'P') And (edtTipExp.Text <> 'E') Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou E.',['&O K']);
      Result := False;
    End;
  End;

end;


procedure TfrmDigEmailPedidoCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If edtPreco.Text = 'C' Then
    blnSemPre := False
  Else
    blnSemPre := True;

  If edtOrdem.Text = 'A' Then
    blnOrdDig := False
  Else
    blnOrdDig := True;

  If edtTipExp.Text = 'P' Then
    strTipExp := 'PDF'
  Else
    strTipExp := 'XLS';

  If (fVerificaCampos)                                       And
     (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigEmailPedidoCompra.FormShow(Sender: TObject);
begin
  inherited;
  edtEmail.SetFocus;
end;

end.

