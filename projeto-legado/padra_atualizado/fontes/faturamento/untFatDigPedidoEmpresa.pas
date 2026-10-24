unit untFatDigPedidoEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Data.DB, MemDS,
  DBAccess, Uni;

type
  TfrmFatDigPedidoEmpresa = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    lblPedido: TLabel;
    edtPedido: TEditFocus;
    lblEmpresa: TLabel;
    edtEmpresa: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    function fValidaPedido(const ANumPed, ACodEmp: String): Boolean;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untPanelCxPedOrc, untPnlDadosPedOrc, untTypesSistema,
  untConsultas, untFatAnaliseCustoPedido;

procedure TfrmFatDigPedidoEmpresa.btnConfirmarClick(Sender: TObject);
var
  LfrmFatAnaliseCustoPedido: TfrmFatAnaliseCustoPedido;
begin
  inherited;

  if fValidaPedido(edtPedido.Text, edtEmpresa.Text) then
  begin
    pCriarFormularios(TfrmFatAnaliseCustoPedido, LfrmFatAnaliseCustoPedido);

    try
      LfrmFatAnaliseCustoPedido.FNumPed := edtPedido.Text;
      LfrmFatAnaliseCustoPedido.FCodEmp := edtEmpresa.Text;
      LfrmFatAnaliseCustoPedido.ShowModal;

      edtPedido.Clear;
      edtEmpresa.Clear;
    finally
      pFreeAndNil(LfrmFatAnaliseCustoPedido);
    end;
  end;
end;

procedure TfrmFatDigPedidoEmpresa.edtPedidoKeyPress(Sender: TObject;
  var Key: Char);
const
  ESPDOC = 'PD';
var
  LobjfrmPnl : TPanelCxPedOrc;
  LarrDoc    : TConsultasArray;
  LqryPedido: TUniQuery;
begin
  inherited;

  LqryPedido := fCriaQuery;

  try
    if fEntraCons(Key) then
    begin
      LobjfrmPnl  := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, ESPDOC);
      try
        if fPesqPedOrc(conPedCompleta, Self, 'PD', ESPDOC, VS_strCodEmp , edtPedido, Nil, edtEmpresa, LqryPedido, Key, LarrDoc, True, LobjfrmPnl, '', 'N', '', True) then
        begin
          pSetFocus(btnConfirmar);
        end;
      finally
        FreeAndNil(LobjfrmPnl);
      end;
    end;
  finally
    FreeAndNil(LqryPedido);
  end;
end;

procedure TfrmFatDigPedidoEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtPedido);
end;

function TfrmFatDigPedidoEmpresa.fValidaPedido(const ANumPed,
  ACodEmp: String): Boolean;
var
  LqryPedido: TUniQuery;
begin
  Result := False;

  if fEmptyStr(ANumPed) then
  begin
    pMensagemOk('Número do pedido não informado!');
    pSetFocus(edtPedido);
    Exit;
  end;

  if fEmptyStr(ACodEmp) then
  begin
    pMensagemOk('Empresa não informada!');
    pSetFocus(edtEmpresa);
    Exit;
  end;

  LqryPedido := fCriaQuery;

  try
    LqryPedido.Close;
    LqryPedido.SQL.Clear;
    LqryPedido.SQL.Add('SELECT FGO_JAFATU, FGO_MOTBAI');
    LqryPedido.SQL.Add('FROM FATGOR');
    LqryPedido.SQL.Add('WHERE FGO_CODEMP = :CODEMP');
    LqryPedido.SQL.Add('AND FGO_ESPDOC = "PD"');
    LqryPedido.SQL.Add('AND FGO_NUMDOC = :NUMPED');

    LqryPedido.ParamByName('CODEMP').AsString := ACodEmp;
    LqryPedido.ParamByName('NUMPED').AsString := ANumPed;

    LqryPedido.Open;

    if LqryPedido.IsEmpty then
    begin
      pMensagemOk('Este pedido de venda não existe.');
      pSetFocus(edtPedido);
      Exit;      
    end;

    if LqryPedido.FieldByName('FGO_JAFATU').AsInteger = 1 then
    begin
      if fEmptyStr(LqryPedido.FieldByName('FGO_MOTBAI').AsString) then
        pMensagemOk('Este pedido de venda já foi faturado.')
      else
        pMensagemOk('Este pedido de venda foi baixado não entregue.');

      pSetFocus(edtPedido);
      Exit;      
    end;

    Result := True;
  finally
    FreeAndNil(LqryPedido);
  end;
end;

end.
