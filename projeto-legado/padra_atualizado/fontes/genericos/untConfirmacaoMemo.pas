unit untConfirmacaoMemo;

interface

uses
  Windows, Classes, Controls, untPai, StdCtrls, MemoFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmConfirmacaoMemo = class(TfrmPai)
    memMsg: TMemoFocus;
    lblTitulo: TLabel;
    btnSim: TBitBtnLocked;
    btnNao: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
  public
    { Public declarations }
    function fConfirma(strCaption, strTitulo, strMsg: String): Boolean;
    function fInformarMensagem(strCaption, strTitulo: String; var strMsg: String): Boolean;
  End;

Var
  frmConfirmacaoMemo: TfrmConfirmacaoMemo;

implementation

uses Forms;

{$R *.dfm}

{ TfrmPendenciasCliente }

procedure TfrmConfirmacaoMemo.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfirmacaoMemo.btnSimClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

function TfrmConfirmacaoMemo.fConfirma(strCaption, strTitulo, strMsg: String): Boolean;
begin
  Caption := strCaption;
  lblTitulo.Caption := strTitulo;
  memMsg.Texto := strMsg;
  memMsg.ReadOnly := True;
  ShowModal;
  Result := blnConfirma;
end;

function TfrmConfirmacaoMemo.fInformarMensagem(strCaption, strTitulo: String;
  var strMsg: String): Boolean;
begin
  Caption := strCaption;
  lblTitulo.Caption := strTitulo;
  memMsg.Texto := strMsg;
  memMsg.ReadOnly := False;
  btnNao.Visible := False;
  btnSim.Caption := '&Confirmar';
  ShowModal;
  Result := blnConfirma;
  If Result Then
    strMsg := memMsg.Text;
end;

procedure TfrmConfirmacaoMemo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.
