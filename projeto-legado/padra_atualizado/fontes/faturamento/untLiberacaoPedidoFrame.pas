unit untLiberacaoPedidoFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox;

type
  TfraLiberacaoPedidoFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlLiberacaoPedido: TGroupBox;
    lblMotLib: TLabel;
    edtMotLib: TEditFocus;
    chkAgdLib: TCheckBox;
    procedure chkAgdLibClick(Sender: TObject);
    procedure edtMotLibEnter(Sender: TObject);
  private
    { Private declarations }
    procedure pLimpaMotivo;
  public
    { Public declarations }
    objVenda: TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    procedure OnAlterouCondicaoPagamento;
    procedure pHabilitarLiberacaoPedido(blnHabilitar: Boolean);

    function fConfirmaDados: Boolean;
  end;


implementation

uses untPesqAux, Data.DB, untTypesSistema, Math, untConsultas, untDigPedCmp,
     untTipoFreteAtc, untfuncoesSimples, untConstantes, untValidacoesRotasRegiao,
     untFatMostraItensFechamento, untCadClientes, untFuncoes, untPesoItem,
     untAdiantamentoClienteGenerico, untProjetos, untMsgLiberacao;

{$R *.dfm}

procedure TfraLiberacaoPedidoFrame.pHabilitarLiberacaoPedido(
  blnHabilitar: Boolean);
begin
  If Not blnHabilitar Then
  Begin
     chkAgdLib.Checked := False;
     pnlLiberacaoPedido.Enabled := False;
     edtMotLib.Clear;
  End
  Else
    pnlLiberacaoPedido.Enabled := True;
end;

function TfraLiberacaoPedidoFrame.fConfirmaDados: Boolean;
begin
  inherited;
  Result := fValidaCampos(chkAgdLib, True) And
            fValidaCampos(edtMotLib, True);

  If Not Result Then
    Exit;

  objVenda.blnPedBlo := chkAgdLib.Checked;
  objVenda.strMotBlo := edtMotLib.Text;
end;

procedure TfraLiberacaoPedidoFrame.OnAlterouCondicaoPagamento;
begin
  OnFormShow;
end;

procedure TfraLiberacaoPedidoFrame.OnFormCreate;
begin
  inherited;
end;

procedure TfraLiberacaoPedidoFrame.OnFormDestroy;
begin
  inherited;
end;

function TfraLiberacaoPedidoFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = chkAgdLib) Then
  Begin
    pLimpaMotivo;
  End

  Else If (Sender = edtMotLib) Then
  Begin
    If (fCfgSis('AGDLIB', VarBoolean) Or fCfgSis('AGDLBT', VarBoolean)) And chkAgdLib.Checked And fEmptyStr(edtMotLib.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Motivo do Bloqueio do Pedido deve ser preenchido.', ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraLiberacaoPedidoFrame.chkAgdLibClick(Sender: TObject);
begin
  pLimpaMotivo;
end;

procedure TfraLiberacaoPedidoFrame.pLimpaMotivo;
begin
  If chkAgdLib.Checked Then
    edtMotLib.ReadOnly := False
  Else
  Begin
    edtMotLib.ReadOnly := True;
    edtMotLib.Clear;
  End;
end;

procedure TfraLiberacaoPedidoFrame.edtMotLibEnter(Sender: TObject);
begin
  If chkAgdLib.Checked Then
    edtMotLib.ReadOnly := False
  Else
    edtMotLib.ReadOnly := True;
end;

procedure TfraLiberacaoPedidoFrame.OnFormShow;
begin
  objVenda.pExibirPanelLiberacaoPedido(pnlLiberacaoPedido, chkAgdLib, edtMotLib);
  Self.Visible := pnlLiberacaoPedido.Visible;
end;

end.

