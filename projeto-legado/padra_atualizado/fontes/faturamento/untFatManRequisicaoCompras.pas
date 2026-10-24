unit untFatManRequisicaoCompras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, UniClientDataSet, UITypes, cxTextEdit;

type
  TfrmFatManRequisicaoCompras = class(TfrmPaiConfirma)
    dtsGrid: TDataSource;
    btnAlterarVincular: TBitBtnLocked;
    btnRemoverVinculo: TBitBtnLocked;
    btnExcluirRequisicao: TBitBtnLocked;
    pnlRodape: TPanel;
    shpLegendaExisteVinculo: TShape;
    lblPedidoVinculado: TLabel;
    cxgGrid: TcxGridCitel;
    cxgGridTBV: TcxGridDBTableView;
    cxgGridTBVCODITE: TcxGridDBColumn;
    cxgGridTBVDESITE: TcxGridDBColumn;
    cxgGridTBVQTDITE: TcxGridDBColumn;
    cxgGridTBVNUMPED: TcxGridDBColumn;
    cxgGridTBVDTAPED: TcxGridDBColumn;
    cxgGridTBVDTAENT: TcxGridDBColumn;
    cxgGridTBVAUTGER: TcxGridDBColumn;
    cxgGridLevel1: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure btnRemoverVinculoClick(Sender: TObject);
    procedure btnExcluirRequisicaoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarVincularClick(Sender: TObject);
    procedure cxgGridTBVCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FintControle: Integer;
    FcdsVinculos,
    FcdsManutencao: TUniClientDataSet;

    procedure pCriaDataSet;
    procedure pCarregaDataSet;
    procedure pRemoveVinculoUmItem;
    procedure pRemoveVinculoTodos;
    function fTotalReqItem(AstrCodIte: String): Double;
  public
    { Public declarations }
  end;

const
  arrOpcao: Array [1..2] Of String = ('do item posicionado', 'de todos os itens');

implementation

uses
  untTCdsVinculosRequisicoes, untFuncoesSimples, untFatSelPedidoCompraRequisicao;

{$R *.dfm}

procedure TfrmFatManRequisicaoCompras.btnConfirmaClick(Sender: TObject);
begin
  if fMensagem('', 'Confirma as manutenções realizadas nas requisições?', ['&Sim', '&Não']) = 2 then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  FcdsVinculos.First;

  while not FcdsVinculos.Eof do
    FcdsVinculos.Delete;

  FcdsManutencao.First;

  while not FcdsManutencao.Eof do
  begin
    FCdsVinculos.Insert;
    FCdsVinculos.FieldByName('ITE_CODITE').AsString := FcdsManutencao.FieldByName('CODITE').AsString;
    FCdsVinculos.FieldByName('AUTINC').AsString := FcdsManutencao.FieldByName('AUTINC').AsString;
    FCdsVinculos.FieldByName('AUTGER').AsString := FcdsManutencao.FieldByName('AUTGER').AsString;

    if (FcdsManutencao.FieldByName('DTAENT').AsDateTime > 0) then
      FCdsVinculos.FieldByName('DTAENT').AsDateTime := FcdsManutencao.FieldByName('DTAENT').AsDateTime;

    if (FcdsManutencao.FieldByName('DTAPED').AsDateTime > 0) then
      FCdsVinculos.FieldByName('DTAPED').AsDateTime := FcdsManutencao.FieldByName('DTAPED').AsDateTime;

    FCdsVinculos.FieldByName('QTDITE').AsFloat := FcdsManutencao.FieldByName('QTDITE').AsFloat;
    FCdsVinculos.FieldByName('PCD_AUTINC').AsString := FcdsManutencao.FieldByName('PCD_AUTINC').AsString;
    FCdsVinculos.FieldByName('AVULSA').AsString := FcdsManutencao.FieldByName('AVULSA').AsString;
    FCdsVinculos.FieldByName('SEQFDO').AsString := FcdsManutencao.FieldByName('SEQFDO').AsString;
    FCdsVinculos.FieldByName('DESITE').AsString := FcdsManutencao.FieldByName('DESITE').AsString;
    FCdsVinculos.Post;

    FcdsManutencao.Next;
  end;

  inherited;
end;

procedure TfrmFatManRequisicaoCompras.btnExcluirRequisicaoClick(
  Sender: TObject);
var
  intOpcao: Integer;
begin
  inherited;

  if FcdsManutencao.isEmpty Then
    Exit;

  intOpcao := fGetMenu('Excluir Requisição', ['Apenas ' + arrOpcao[1], 'Remover ' + arrOpcao[2]], 1);

  if (intOpcao = 1) then
  begin
    if fMensagem('', 'Confirma a exclusão da requisição do item' +
      FcdsManutencao.FieldByName('CODITE').AsString + '-' + FcdsManutencao.FieldByName('DESITE').AsString + '?', ['&Sim', '&Não']) = 2 then
      Exit;

    FcdsManutencao.Delete;
  end
  else
  begin
    if fMensagem('', 'Confirma a exclusão das requisições ' + arrOpcao[2] + '?', ['&Sim', '&Não']) = 2 then
      Exit;

    FcdsManutencao.First;

    while not FcdsManutencao.Eof do
      FcdsManutencao.Delete;
  end;
end;

procedure TfrmFatManRequisicaoCompras.btnRemoverVinculoClick(Sender: TObject);
var
  intOpcao: Integer;
begin
  inherited;

  if FcdsManutencao.isEmpty Then
    Exit;

  intOpcao := fGetMenu('Remover vínculo com Pedido de Compra', ['Apenas ' + arrOpcao[1], 'Remover ' + arrOpcao[2]], 1);

  if (intOpcao = 1) then
    pRemoveVinculoUmItem
  else
    pRemoveVinculoTodos;
end;

procedure TfrmFatManRequisicaoCompras.btnSairClick(Sender: TObject);
begin
  if fMensagem('', 'Deseja cancelar as alterações realizadas nas requisições?', ['&Sim', '&Não']) = 2 then
  begin
    ModalResult := mrNone;
    Exit;
  end;

  inherited;
end;

procedure TfrmFatManRequisicaoCompras.btnAlterarVincularClick(Sender: TObject);
var
  frmFatSelPedido: TfrmFatSelPedidoCompraRequisicao;
begin
  inherited;

  try
    pCriarFormularios(TfrmFatSelPedidoCompraRequisicao, frmFatSelPedido);
    frmFatSelPedido.FblnManutReq     := True;
    frmFatSelPedido.FstrCodIte       := FcdsManutencao.FieldByName('CODITE').AsString;
    frmFatSelPedido.FstrDesIte       := FcdsManutencao.FieldByName('DESITE').AsString;
    frmFatSelPedido.FfltQtdIte       := fTotalReqItem(FcdsManutencao.FieldByName('CODITE').AsString);
    frmFatSelPedido.FcdsManutencao   := FcdsManutencao;
    frmFatSelPedido.FintControlManut := FintControle;
    frmFatSelPedido.ShowModal;
  finally
    FcdsManutencao.Filtered := False;
    FcdsManutencao.Filter   := '';
    FcdsManutencao.Filtered := True;

    pFreeAndNil(frmFatSelPedido);
  end;
end;

procedure TfrmFatManRequisicaoCompras.cxgGridTBVCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (not fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgGridTBVAUTGER.Index]))) Then
    ACanvas.Brush.Color := shpLegendaExisteVinculo.Brush.Color;
end;

procedure TfrmFatManRequisicaoCompras.FormCreate(Sender: TObject);
begin
  inherited;

  pCriaDataset;
  FCdsVinculos := TCdsVinculosRequisicoes.fGetClientDataSet;

  If Not Assigned(FCdsVinculos) Then
    Exit;

  FCdsVinculos.Filtered := False;
  FCdsVinculos.Filter := '';
  FCdsVinculos.Filtered := True;

  dtsGrid.DataSet := FcdsManutencao;
end;

procedure TfrmFatManRequisicaoCompras.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsManutencao);
end;

procedure TfrmFatManRequisicaoCompras.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_DELETE: btnExcluirRequisicao.Click;
    VK_F3 : btnAlterarVincular.Click;
    VK_F4 : btnRemoverVinculo.Click;
    VK_F10: btnConfirma.Click;
  end;
end;

procedure TfrmFatManRequisicaoCompras.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDataSet;
end;

function TfrmFatManRequisicaoCompras.fTotalReqItem(AstrCodIte: String): Double;
begin
  FcdsManutencao.Filtered := False;
  FcdsManutencao.Filter   := 'CODITE=' + QuotedStr(AstrCodIte);
  FcdsManutencao.Filtered := True;

  Result := StrToFloatDef(FcdsManutencao.FieldByName('TOTITE').AsString, 0);
end;

procedure TfrmFatManRequisicaoCompras.pCarregaDataSet;
begin
  FintControle := 1;
  FCdsVinculos.First;

  while not FCdsVinculos.Eof do
  begin
    FcdsManutencao.Append;
    FcdsManutencao.FieldByName('CODITE').AsString := FCdsVinculos.FieldByName('ITE_CODITE').AsString;
    FcdsManutencao.FieldByName('DESITE').AsString := FCdsVinculos.FieldByName('DESITE').AsString;
    FcdsManutencao.FieldByName('QTDITE').AsFloat  := FCdsVinculos.FieldByName('QTDITE').AsFloat;
    FcdsManutencao.FieldByName('AUTINC').AsString := FCdsVinculos.FieldByName('AUTINC').AsString;
    FcdsManutencao.FieldByName('AUTGER').AsString := FCdsVinculos.FieldByName('AUTGER').AsString;
    FcdsManutencao.FieldByName('NUMPED').AsString := FCdsVinculos.FieldByName('NUMPED').AsString;
    FcdsManutencao.FieldByName('AVULSA').AsString := FCdsVinculos.FieldByName('AVULSA').AsString;
    FcdsManutencao.FieldByName('SEQFDO').AsString := FCdsVinculos.FieldByName('SEQFDO').AsString;

    if (FCdsVinculos.FieldByName('DTAENT').AsDateTime > 0) then    
      FcdsManutencao.FieldByName('DTAENT').AsDateTime  := FCdsVinculos.FieldByName('DTAENT').AsDateTime
    else
      FcdsManutencao.FieldByName('DTAENT').Clear;
      
    if (FCdsVinculos.FieldByName('DTAPED').AsDateTime > 0) then
      FcdsManutencao.FieldByName('DTAPED').AsDateTime  := FCdsVinculos.FieldByName('DTAPED').AsDateTime
    else
      FcdsManutencao.FieldByName('DTAPED').Clear;
      
    FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControle;
    FcdsManutencao.Post;

    inc(FintControle);
    FCdsVinculos.Next;
  end;
end;

procedure TfrmFatManRequisicaoCompras.pCriaDataSet;
var
  aggTotIte: TAggregateField;
begin
  FcdsManutencao := TUniClientDataSet.Create(Self);
  FcdsManutencao.AggregatesActive := True;
  FcdsManutencao.FieldDefs.Add('CODITE', ftString, fTamCodIte);
  FcdsManutencao.FieldDefs.Add('DESITE', ftString, 70);
  FcdsManutencao.FieldDefs.Add('QTDITE', ftFloat);
  FcdsManutencao.FieldDefs.Add('AUTINC', ftString, 20);
  FcdsManutencao.FieldDefs.Add('AUTGER', ftString, 20);
  FcdsManutencao.FieldDefs.Add('NUMPED', ftString, 12);
  FcdsManutencao.FieldDefs.Add('PCD_AUTINC', ftString, 20);
  FcdsManutencao.FieldDefs.Add('DTAENT', ftDate);
  FcdsManutencao.FieldDefs.Add('DTAPED', ftDate);
  FcdsManutencao.FieldDefs.Add('AVULSA', ftString, 1);
  FcdsManutencao.FieldDefs.Add('CONTROLE', ftInteger);
  FcdsManutencao.FieldDefs.Add('SEQFDO', ftString, 20);

  aggTotIte := TAggregateField.Create(FcdsManutencao);

  aggTotIte.FieldName := 'TOTITE';
  aggTotIte.Expression := 'SUM(QTDITE)';
  aggTotIte.Active := True;
  aggTotIte.DataSet := FcdsManutencao;
  aggTotIte.DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  aggTotIte.Active := True;

  FcdsManutencao.CreateDataSet;

  (FcdsManutencao.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (FcdsManutencao.FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));
end;

procedure TfrmFatManRequisicaoCompras.pRemoveVinculoTodos;
var
  strCodIte: String;
  intControlRem,
  fltQtde: Double;
  cdsDados: TUniClientDataSet;
begin
  if fMensagem('', 'Confirma a remoção do vínculo ' + arrOpcao[2] + '?', ['&Sim', '&Não']) = 2 then
    Exit;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, FcdsManutencao);
    cdsDados.Filtered := False;
    cdsDados.Filter   := 'AUTGER <> ''''';
    cdsDados.Filtered := True;

    if cdsDados.IsEmpty then
      Exit;

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      strCodIte := cdsDados.FieldByName('CODITE').AsString;
      intControlRem := cdsDados.FieldByName('CONTROLE').AsInteger;
      fltQtde := cdsDados.FieldByName('QTDITE').AsFloat;

      try
        FcdsManutencao.Filtered := False;
        FcdsManutencao.Filter := 'CODITE=' + QuotedStr(strCodIte) + ' AND AUTGER ='''' ';
        FcdsManutencao.Filtered := True;

        if FcdsManutencao.IsEmpty then
        begin
          FcdsManutencao.Insert;
          FcdsManutencao.FieldByName('AVULSA').AsString    := 'S';
          FcdsManutencao.FieldByName('CODITE').AsString    := strCodIte;
          FcdsManutencao.FieldByName('DESITE').AsString    := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);
          FcdsManutencao.FieldByName('QTDITE').AsFloat     := fltQtde;
          FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControle;
          FcdsManutencao.Post;

          inc(FintControle)
        end
        else
        begin
          FcdsManutencao.Edit;
          FcdsManutencao.FieldByName('QTDITE').AsFloat := FcdsManutencao.FieldByName('QTDITE').AsFloat + fltQtde;
          FcdsManutencao.Post;
        end;
      finally
        FcdsManutencao.Filtered := False;
        FcdsManutencao.Filter := '';
        FcdsManutencao.Filtered := True;
      end;

      FcdsManutencao.Locate('CONTROLE', intControlRem, []);
      FcdsManutencao.Delete;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmFatManRequisicaoCompras.pRemoveVinculoUmItem;
var
  strCodIte: String;
  intControlRem,
  fltQtde: Double;
begin
  strCodIte := FcdsManutencao.FieldByName('CODITE').AsString;

  if fEmptyStr(FcdsManutencao.FieldByName('AUTGER').AsString) then
  begin
    pMensagemOk('O item selecionado não possui vínculo com Pedido de Compra!');
    Exit;
  end;

  if fMensagem('', 'Confirma a remoção do vínculo do item ' + strCodIte + FcdsManutencao.FieldByName('DESITE').AsString + '?', ['&Sim', '&Não']) = 2 then
    Exit;

  intControlRem := FcdsManutencao.FieldByName('CONTROLE').AsInteger;
  fltQtde := FcdsManutencao.FieldByName('QTDITE').AsFloat;

  FcdsManutencao.Filtered := False;
  FcdsManutencao.Filter := 'CODITE=' + QuotedStr(strCodIte) + ' AND AUTGER ='''' ';
  FcdsManutencao.Filtered := True;

  try
    if FcdsManutencao.IsEmpty then
    begin
      FcdsManutencao.Insert;
      FcdsManutencao.FieldByName('CODITE').AsString    := strCodIte;
      FcdsManutencao.FieldByName('DESITE').AsString    := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);
      FcdsManutencao.FieldByName('QTDITE').AsFloat     := fltQtde;
      FcdsManutencao.FieldByName('CONTROLE').AsInteger := FintControle;
      FcdsManutencao.Post;

      inc(FintControle)
    end
    else
    begin
      FcdsManutencao.Edit;
      FcdsManutencao.FieldByName('QTDITE').AsFloat := FcdsManutencao.FieldByName('QTDITE').AsFloat + fltQtde;
      FcdsManutencao.Post;
    end;
  finally
    FcdsManutencao.Filtered := False;
    FcdsManutencao.Filter := '';
    FcdsManutencao.Filtered := True;
  end;

  FcdsManutencao.Locate('CONTROLE', intControlRem, []);
  FcdsManutencao.Delete;
end;

end.
