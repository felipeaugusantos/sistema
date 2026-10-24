{*************************************************}
{* qryConFpg := frmFatVendas.qryConFpg -> CADFPG *}
{* qryConCnd -> CADCND                           *}
{**********************************************JB*}
unit untDigCndPagamento;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, untTypesSistema,
  Mask, MaskEditFocus, Menus, EditFocus, Grids, DBGridCitel, DBGrids, DBCtrls, StrUtils,
  DBEditFocus, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Data.DB, Windows, untDigCndPagamentoFrame;

type
  TfrmDigCndPagamento = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    BtnObsCliente: TBitBtnLocked;
    fraDigCndPagamento: TfraDigCndPagamento;
    procedure btnCancelaClick(Sender: TObject);
    procedure BtnObsClienteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    procedure pPosChkCndPagTodos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public

  end;


implementation

{$R *.dfm}

uses untFatMostraObsCliente, untFuncoesSimples;

{ TfrmDigCndPagamento }

function TfrmDigCndPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Result := fraDigCndPagamento.fValidaCampos(Sender, blnBuscaPorChave);
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigCndPagamento.pPosChkCndPagTodos;
begin
  if fraDigCndPagamento.chkCndPagTodos.Visible then
  begin
    fraDigCndPagamento.chkCndPagTodos.Left :=  fraDigCndPagamento.edtCodCnd.Left + 1;
    fraDigCndPagamento.chkCndPagTodos.Top  :=  fraDigCndPagamento.edtCodCnd.Top
                            + fraDigCndPagamento.edtCodCnd.Height + 4;
  end;
end;

procedure TfrmDigCndPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fraDigCndPagamento.OnFormClose(Sender, Action);
end;

procedure TfrmDigCndPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  fraDigCndPagamento.OnFormCreate(Sender);
end;

procedure TfrmDigCndPagamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
  Begin
    BtnObsCliente.Click;
  end;
end;

procedure TfrmDigCndPagamento.FormShow(Sender: TObject);
begin
  inherited;
  fraDigCndPagamento.OnFormShow(Sender);
  btnObsCliente.Visible := Not fEmptyStr(fraDigCndPagamento.strCodCli);

  pPosChkCndPagTodos;

end;

procedure TfrmDigCndPagamento.btnCancelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigCndPagamento.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fraDigCndPagamento.fConfirmaDados And fVerificaCampos Then
  Begin
    fraDigCndPagamento.blnConfirma := True;
    Close;
  End
  Else
    fraDigCndPagamento.blnConfirma := False;
end;

procedure TfrmDigCndPagamento.BtnObsClienteClick(Sender: TObject);
  Var
    strObservacao: string;
begin
  inherited;
  strObservacao := fCampoTabela('CLI_OBSERV', 'CADCLI', ['CLI_CODCLI'], [fraDigCndPagamento.strCodCli]);

  Try
    pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
    frmFatMostraObsCliente.memObserv.Text := strObservacao;
    frmFatMostraObsCliente.strCodCli := fraDigCndPagamento.strCodCli;
    frmFatMostraObsCliente.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[BtnObsClienteClick]');
  End;

  pFreeAndNil(frmFatMostraObsCliente);

end;

end.

