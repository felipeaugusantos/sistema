unit untPedeDataAlteracaoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, Vcl.Mask,
  MaskEditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataset,
  cxCalendar, DBClient;

type
  TfrmPedeDataAlteracaoPedido = class(TfrmPaiConfirma)
    mskDtaEntPed: TMaskEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    mmoMotivo: TMemo;
    Panel1: TPanel;
    lblFornecedor: TLabel;
    lblPedido: TLabel;
    gbPorPedido: TGroupBox;
    gbPorItem: TGroupBox;
    cxvItensPedidoCompra: TcxGridDBTableViewCitel;
    cxgItensPedidoCompraLevel1: TcxGridLevel;
    cxgItensPedidoCompra: TcxGridCitel;
    cxGridClmCodItem: TcxGridDBColumn;
    cxGridClmDescricao: TcxGridDBColumn;
    cxGridClmMarca: TcxGridDBColumn;
    cxGridClmCodFabrica: TcxGridDBColumn;
    cxGridClmDataEntregaAtual: TcxGridDBColumn;
    cxGridClmDataEntregaNova: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskDtaEntPedExit(Sender: TObject);
  private
    { Private declarations }
    procedure pSetaMenorDataEntrega;
    procedure pSetaMaiorDataEntrega;
    procedure pSetaDataEntrega;
    procedure cdsItensPedidoCompraAfterPost(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    class function fPedeMotivo_e_NovaDataDeEntrega(var dtaNovaData: TDate; var strMotivo: string; strPedido: string;
                                                    strFornecedor: string; cdsItensPedidoCompra: TUniClientDataSet = nil): Boolean;
  end;

var
  frmPedeDataAlteracaoPedido: TfrmPedeDataAlteracaoPedido;
  dtsProdutos: TDataSource;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmPedeDataAlteracaoPedido }

procedure TfrmPedeDataAlteracaoPedido.cdsItensPedidoCompraAfterPost(DataSet: TDataSet);
begin
  frmPedeDataAlteracaoPedido.pSetaDataEntrega;
end;

procedure TfrmPedeDataAlteracaoPedido.FormCreate(Sender: TObject);
begin
  inherited;

  If fCfgSis('ENTITE') <> 'S' Then
  Begin
    gbPorItem.Visible := False;
    Self.Height := Self.Height - gbPorItem.Height;
  End;

  cxvItensPedidoCompra.DataController.DataSource := dtsProdutos;
end;

procedure TfrmPedeDataAlteracaoPedido.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaEntPed);
end;

function TfrmPedeDataAlteracaoPedido.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  if (Sender = mskDtaEntPed) Then
  Begin
    If (not fEmptyDate(mskDtaEntPed.Text)) And (StrToDateDef(mskDtaEntPed.Text, 0) <= 0) Then
    Begin
      pMensagemOk('Data Inválida!');
      Result := False;
    End
    Else If fEmptyDate(mskDtaEntPed.Text) Then
    Begin
      if gbPorItem.Visible then
      begin
        dtsProdutos.DataSet.Filter := 'NOVA_DATA_ENTREGA <> ' + QuotedStr(EmptyStr);
        dtsProdutos.DataSet.Filtered := True;

        if not (dtsProdutos.DataSet.RecordCount > 0) then
        begin
          pMensagemOk('Data deve ser informada!');
          Result := True;
        end;
        dtsProdutos.DataSet.Filter := '';
        dtsProdutos.DataSet.Filtered := False;
      end
      else
      begin
        pMensagemOk('Data deve ser informada!');
        Result := False;
      end;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmPedeDataAlteracaoPedido.mskDtaEntPedExit(Sender: TObject);
begin
  inherited;
  if not gbPorItem.Visible then
    Exit;

  if not (dtsProdutos.DataSet.RecordCount > 0) then
    Exit;

  if fEmptyDate(mskDtaEntPed.Text) then
    Exit;

  dtsProdutos.DataSet.AfterPost := nil;
  dtsProdutos.DataSet.DisableControls;
  dtsProdutos.DataSet.First;

  try
    while not dtsProdutos.DataSet.Eof do
    begin
      if dtsProdutos.DataSet.FieldByName('PCD_DTAENT').AsString = frmPedeDataAlteracaoPedido.mskDtaEntPed.Text then
      Begin
        dtsProdutos.DataSet.Next;
        Continue;
      End;

      dtsProdutos.DataSet.Edit;
      dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString := frmPedeDataAlteracaoPedido.mskDtaEntPed.Text;
      dtsProdutos.DataSet.Post;

      dtsProdutos.DataSet.Next;
    end;
  finally
    dtsProdutos.DataSet.EnableControls;
    dtsProdutos.DataSet.AfterPost := frmPedeDataAlteracaoPedido.cdsItensPedidoCompraAfterPost;
  end;
end;

procedure TfrmPedeDataAlteracaoPedido.pSetaDataEntrega;
begin

  If fCfgSis('ENTITE',VarBoolean) Then
  Begin
    if fCfgSis('TDEIPC') = '2' then
      pSetaMenorDataEntrega
    else
      pSetaMaiorDataEntrega;
  End;
end;

procedure TfrmPedeDataAlteracaoPedido.pSetaMaiorDataEntrega;
var
  dataAtual: string;
begin
  dtsProdutos.DataSet.DisableControls;
  dtsProdutos.DataSet.First;
  dataAtual := EmptyStr;

  while not dtsProdutos.DataSet.Eof do
  begin
    if not fEmptyDate(dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString) then
    begin
      if (dataAtual.IsEmpty) or (StrToDate(dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString) > StrToDate(dataAtual)) then
        dataAtual := dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString;
    end
    else
    begin
      if (dataAtual.IsEmpty) or (StrToDate(dtsProdutos.DataSet.FieldByName('PCD_DTAENT').AsString) > StrToDate(dataAtual)) then
        dataAtual := dtsProdutos.DataSet.FieldByName('PCD_DTAENT').AsString;
    end;

    dtsProdutos.DataSet.Next;
  end;

  if not fEmptyDate(dataAtual) then
  begin
    frmPedeDataAlteracaoPedido.mskDtaEntPed.Text := dataAtual;
  end;

  dtsProdutos.DataSet.EnableControls;
end;

procedure TfrmPedeDataAlteracaoPedido.pSetaMenorDataEntrega;
var
  dataAtual: string;
begin
  dtsProdutos.DataSet.DisableControls;
  dtsProdutos.DataSet.First;
  dataAtual := EmptyStr;

  while not dtsProdutos.DataSet.Eof do
  begin
    if not fEmptyDate(dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString) then
    begin
      if (dataAtual.IsEmpty) or (StrToDate(dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString) < StrToDate(dataAtual)) then
        dataAtual := dtsProdutos.DataSet.FieldByName('NOVA_DATA_ENTREGA').AsString;

    end
    else
    begin
      if (dataAtual.IsEmpty) or (StrToDate(dtsProdutos.DataSet.FieldByName('PCD_DTAENT').AsString) < StrToDate(dataAtual)) then
        dataAtual := dtsProdutos.DataSet.FieldByName('PCD_DTAENT').AsString;
    end;

    dtsProdutos.DataSet.Next;
  end;

  if not fEmptyDate(dataAtual) then
  begin
    frmPedeDataAlteracaoPedido.mskDtaEntPed.Text := dataAtual;
  end;

  dtsProdutos.DataSet.EnableControls;
end;

class function TfrmPedeDataAlteracaoPedido.fPedeMotivo_e_NovaDataDeEntrega(
  var dtaNovaData: TDate; var strMotivo: string; strPedido: string; strFornecedor: string; cdsItensPedidoCompra: TUniClientDataSet = nil): Boolean;
begin
  if cdsItensPedidoCompra <> nil then
  begin
    dtsProdutos := TDataSource.Create(nil);
    dtsProdutos.dataset := cdsItensPedidoCompra;

    dtsProdutos.DataSet.AfterPost := frmPedeDataAlteracaoPedido.cdsItensPedidoCompraAfterPost;
  end;

  pCriarFormularios(TfrmPedeDataAlteracaoPedido, frmPedeDataAlteracaoPedido);
  frmPedeDataAlteracaoPedido.lblFornecedor.Caption := frmPedeDataAlteracaoPedido.lblFornecedor.Caption + strFornecedor;
  frmPedeDataAlteracaoPedido.lblPedido.Caption     := frmPedeDataAlteracaoPedido.lblPedido.Caption + strPedido;
  Try
    frmPedeDataAlteracaoPedido.ShowModal;
    If fEmptyDate(frmPedeDataAlteracaoPedido.mskDtaEntPed.Text) Then
      dtaNovaData := 0
    Else
      dtaNovaData := StrToDate(frmPedeDataAlteracaoPedido.mskDtaEntPed.Text);

    if cdsItensPedidoCompra.RecordCount > 0 then
    begin
      cdsItensPedidoCompra.First;

      while not cdsItensPedidoCompra.eof do
      begin
        cdsItensPedidoCompra.Edit;

        If (StrToDateDef(cdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString, 0) <= 0) Then
            cdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString := EmptyStr;

        If StrToDateDef(cdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString, 0) = StrToDateDef(cdsItensPedidoCompra.FieldByName('PCD_DTAENT').AsString, 0) Then
            cdsItensPedidoCompra.FieldByName('NOVA_DATA_ENTREGA').AsString := EmptyStr;

        cdsItensPedidoCompra.Post;
        cdsItensPedidoCompra.Next;
      end;
    end;

    strMotivo   := frmPedeDataAlteracaoPedido.mmoMotivo.Text;

    Result := frmPedeDataAlteracaoPedido.ModalResult = mrOk;
  Finally
    FreeAndNil(frmPedeDataAlteracaoPedido);

    if Assigned(dtsProdutos) then
      FreeAndNil(dtsProdutos);
  End;
end;

end.




