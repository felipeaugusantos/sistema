unit untDigPedCompraPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untTImportacaoPedidoCompraPromocao,
  EditFocus;

type
  TfrmDigPedCompraPromocao = class(TfrmPai)
    pnlDadosPedido: TPanel;
    cxPedidosView: TcxGridDBTableViewCitel;
    cxPedidosLevel: TcxGridLevel;
    cxPedidos: TcxGridCitel;
    cxPedidosViewPCG_DTAENT: TcxGridDBColumn;
    cxPedidosViewPCG_NUMPED: TcxGridDBColumn;
    cxPedidosViewPCG_CODEMP: TcxGridDBColumn;
    cxPedidosViewFORNEC: TcxGridDBColumn;
    edtNumPed: TEditFocus;
    Label6: TLabel;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxPedidosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    FImpPedComp: TImportacaoPedidoCompraPromocao;

    function fGetImpPedComp: TImportacaoPedidoCompraPromocao;

    procedure pAdicionaPedido;
    function getStlPedidos: TStringList;
    procedure setStlPedidos(const Value: TStringList);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    blnConfirma: Boolean;

    property stlPedidos: TStringList read getStlPedidos write setStlPedidos;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigPedCompraPromocao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fGetImpPedComp().dtsPedidos.DataSet.RecordCount = 0) Then
  Begin
    fMensagem('AVISO', 'Nenhum pedido de compra selecionado!', ['&OK']);
    Exit;
  End;

  blnConfirma := True;
  Close;
end;

procedure TfrmDigPedCompraPromocao.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos() Then
    pAdicionaPedido();
end;

procedure TfrmDigPedCompraPromocao.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigPedCompraPromocao.cxPedidosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strNumPed,
  strCodEmp: String;
begin
  inherited;

  Case Key Of
    VK_DELETE:
      Begin
        If fMensagem('', 'Deseja remover o pedido selecionado?', ['&Sim', '&Não']) = 1 Then
        Begin
          strNumPed := VarAsType(cxPedidosView.ViewData
                         .Records[cxPedidosView.DataController.FocusedRowIndex]
                         .Values[cxPedidosViewPCG_NUMPED.Index], varString);

          strCodEmp := VarAsType(cxPedidosView.ViewData
                         .Records[cxPedidosView.DataController.FocusedRowIndex]
                         .Values[cxPedidosViewPCG_CODEMP.Index], varString);

          fGetImpPedComp().pRemovePedido(strNumPed, strCodEmp);
        End;
      End;
    VK_ESCAPE:
      btnSair.Click();
    VK_F10:
      btnConfirma.Click;
  End;
end;

function TfrmDigPedCompraPromocao.fGetImpPedComp: TImportacaoPedidoCompraPromocao;
begin
  If (Not Assigned(FImpPedComp)) Then
    FImpPedComp := TImportacaoPedidoCompraPromocao.Create();

  Result := FImpPedComp;
end;

procedure TfrmDigPedCompraPromocao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (fGetImpPedComp().dtsPedidos.DataSet.RecordCount > 0) And (Not blnConfirma) Then
  Begin
    If fMensagem('AVISO', 'Deseja cancelar a importação dos pedidos de compra?', ['&Sim', '&Não']) = 2 Then
    Begin
      Action := CaNone;
      Exit;
    End;
  End;

  inherited;
end;

procedure TfrmDigPedCompraPromocao.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  cxPedidosView.DataController.DataSource := fGetImpPedComp().dtsPedidos;
end;

procedure TfrmDigPedCompraPromocao.FormDestroy(Sender: TObject);
begin
  If Assigned(FImpPedComp) Then
    FreeAndNil(FImpPedComp);

  inherited;
end;

procedure TfrmDigPedCompraPromocao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmDigPedCompraPromocao.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumPed);
end;

function TfrmDigPedCompraPromocao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtNumPed) Then
    Begin
      If fEmptyStr(edtNumPed.Text) Then
      Begin
        fMensagem('', 'O Pedido deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('', 'A empresa deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('', 'Empresa não encontrada!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmDigPedCompraPromocao.getStlPedidos: TStringList;
begin
  Result := fGetImpPedComp().stlPedidos;
end;

procedure TfrmDigPedCompraPromocao.pAdicionaPedido;
begin
  If fGetImpPedComp().fAdicionaPedido(edtNumPed.Text, edtCodEmp.Text) Then
  Begin
    edtNumPed.Clear();
    edtCodEmp.Clear();
    edtNomEmp.Clear();
  End;

  pSetFocus(edtNumPed);
end;

procedure TfrmDigPedCompraPromocao.setStlPedidos(const Value: TStringList);
  var
    stlAux: TStrings;
    i: Integer;
begin
  stlAux := TStringList.Create();

  Try
    For i := 0 To Pred(Value.Count) Do
    Begin
      stlAux.Clear();
      ExtractStrings([';'], [' '], PChar(Value[i]), stlAux);

      fGetImpPedComp().fAdicionaPedido(stlAux[0], stlAux[1]);
    End;
  Finally
    stlAux.Free;
  End;
end;

end.
