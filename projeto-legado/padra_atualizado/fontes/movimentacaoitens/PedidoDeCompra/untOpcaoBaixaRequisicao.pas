unit untOpcaoBaixaRequisicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus;

type
  TfrmOpcaoBaixaRequisicao = class(TfrmPaiConfirma)
    mmoInstru: TMemo;
    Panel1: TPanel;
    rdgOpcaoPedido: TRadioGroup;
    pnlMotivo: TPanel;
    Panel3: TPanel;
    rdgMotNeg: TRadioGroup;
    mmoJUSTIF: TMemoFocus;
    Panel4: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgOpcaoPedidoClick(Sender: TObject);
    procedure rdgMotNegClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmOpcaoBaixaRequisicao: TfrmOpcaoBaixaRequisicao;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmOpcaoBaixaRequisicao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
    If Not fPergunta('Confirma a operação?') Then
      Action := caNone;

end;

function TfrmOpcaoBaixaRequisicao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = rdgOpcaoPedido) Then
    Begin

      If rdgOpcaoPedido.ItemIndex = -1 Then
      Begin
        Result := False;
        pMensagemOk('Informe a opção em relação as requisições!');
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmOpcaoBaixaRequisicao.rdgMotNegClick(Sender: TObject);
begin
  inherited;

  If rdgMotNeg.ItemIndex = 1 Then
    mmoJUSTIF.Texto := rdgMotNeg.Items[1]
  Else
    mmoJUSTIF.Clear;
  pSetFocus(mmoJUSTIF);
end;

procedure TfrmOpcaoBaixaRequisicao.rdgOpcaoPedidoClick(Sender: TObject);
begin
  inherited;

  pnlMotivo.Enabled := rdgOpcaoPedido.ItemIndex = 1;
end;

end.
