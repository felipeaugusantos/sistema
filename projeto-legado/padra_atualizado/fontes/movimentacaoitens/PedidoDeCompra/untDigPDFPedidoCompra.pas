unit untDigPDFPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, StdCtrls, EditFocus, QColorLabel, AppEvnts, Menus,
  Buttons, ExtCtrls, BitBtnLockedIncrem;

type
  TfrmDigPDFPedidoCompra = class(TfrmPaiEdit)
    chkMarca: TCheckBox;
    chkCodFab: TCheckBox;
    gbPreco: TGroupBox;
    ColorLabel2: TColorLabel;
    edtPreco: TEditFocus;
    gbOrdem: TGroupBox;
    ColorLabel3: TColorLabel;
    edtOrdem: TEditFocus;
    rdgQuantidade: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmDigPDFPedidoCompra.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkMarca);
end;

function TfrmDigPDFPedidoCompra.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {****************************}
  {* VERIFICA CAMPO PREÇO     *}
  {*************************LA*}
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
  {*************************LA*}
  Else
  If (Sender = edtOrdem) Then
  Begin
    If (edtOrdem.Text <> 'D') And (edtOrdem.Text <> 'A') Then
    Begin
      fMensagem('','O campo Ordem deve ser D ou A.',['&O K']);
      Result := False;
    End;
  End

end;

procedure TfrmDigPDFPedidoCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) And (Not fVerificaCampos) Then
    Action := caNone;

end;

end.
