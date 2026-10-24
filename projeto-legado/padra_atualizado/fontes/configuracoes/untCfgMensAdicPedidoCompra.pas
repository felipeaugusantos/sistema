unit untCfgMensAdicPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, Menus, StdCtrls,  Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, MemoFocus, Uni, untFuncoesSimples;

type
  TfrmCfgMensAdicPedidoCompra = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    memMsgAdicional: TMemoFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    FBlnConfirma: Boolean;
    { Private declarations }
  public
    class function fSalvaMensagem(strEspPed: String; strMensagem: String): Boolean;
    property blnConfirma: Boolean read FBlnConfirma;
    { Public declarations }
  end;

var
  frmCfgMensAdicPedidoCompra: TfrmCfgMensAdicPedidoCompra;

implementation

uses untPai;

{$R *.dfm}

procedure TfrmCfgMensAdicPedidoCompra.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  FblnConfirma := True;
end;

procedure TfrmCfgMensAdicPedidoCompra.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmCfgMensAdicPedidoCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrOk Then
  Begin
    If Not fVerificaCampos Then
      Action := canone;

  End;
end;

procedure TfrmCfgMensAdicPedidoCompra.FormCreate(Sender: TObject);
begin
  inherited;
  FBlnConfirma := False;
end;

class function TfrmCfgMensAdicPedidoCompra.fSalvaMensagem(
  strEspPed: String; strMensagem: String): Boolean;
 var  qryComand : TUniQuery;
begin
  Result := True;
  If strMensagem = '#NDEF' then
    Exit(True);

  Try
    qryComand := fCriaQuery;
    Try
      qryComand.SQL.Add('DELETE FROM MENPDC WHERE  MEN_CODEMP = :MEN_CODEMP AND  MEN_ESPPDC = :MEN_ESPPDC;');
      qryComand.SQL.Add('INSERT INTO MENPDC (');
      qryComand.SQL.Add('MEN_CODEMP,');
      qryComand.SQL.Add('MEN_ESPPDC,');
      qryComand.SQL.Add('MEN_MENSSA');
      qryComand.SQL.Add(')');
      qryComand.SQL.Add('VALUES');
      qryComand.SQL.Add('(:MEN_CODEMP,');
      qryComand.SQL.Add(' :MEN_ESPPDC,');
      qryComand.SQL.Add(' :MEN_MENSSA');
      qryComand.SQL.Add(');');

      qryComand.ParamByName('MEN_CODEMP').AsString := VS_StrCodEmp;
      qryComand.ParamByName('MEN_ESPPDC').AsString := strEspPed;
      qryComand.ParamByName('MEN_MENSSA').AsString := strMensagem;

      qryComand.ExecSQL;
    Finally
      FreeAndNil(qryComand);
    End;
  Except
    On e: Exception do
    Begin
      Raise  e;
    End;
  End;


end;

procedure TfrmCfgMensAdicPedidoCompra.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
