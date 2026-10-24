unit untCrmCatalogoPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.StdCtrls, Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, UniClientDataSet, System.ImageList,
  Vcl.ImgList;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);

  TfrmCrmCatalogoPromocao = class(TfrmPaiConfirma)
    grdItens: TcxGridCitel;
    grdItensTableView: TcxGridDBTableViewCitel;
    grdItensLevel1: TcxGridLevel;
    dtsDados: TDataSource;
    imgLista: TImageList;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdItensTableViewDblClick(Sender: TObject);
    procedure grdItensTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    colunaMarca : TcxGridColumn;

    procedure pEscondeCampos;
    procedure pMarcarIndividual;
    procedure pMarcarDesmarcaTodos(blnStatus: Boolean);
    procedure pMarcar(blnStatus: Boolean);
  public
    { Public declarations }
    cdsDados: TUniClientDataSet;
    blnExibeColImposto: Boolean;
    blnExibeColCliente: Boolean;

    procedure pMarcarTodos;
    procedure pDesmarcarTodos;
    procedure pInverterSelecao;
    procedure pCarregarGrid;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmCrmCatalogoPromocao.FormCreate(Sender: TObject);
begin
  inherited;

  blnExibeColCliente := False;
  blnExibeColImposto := False;

  pnlBotoes.Visible := False;
  pnlStatus.Visible := False;
end;

procedure TfrmCrmCatalogoPromocao.FormDestroy(Sender: TObject);
begin
  inherited;

  dtsDados.DataSet := Nil;

  If Assigned(colunaMarca)Then
    FreeAndNil(colunaMarca);
end;

procedure TfrmCrmCatalogoPromocao.FormShow(Sender: TObject);
begin
  inherited;

  Self.grdItensTableView.ApplyBestFit();
  pSetFocus(grdItens);
end;

procedure TfrmCrmCatalogoPromocao.grdItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  blnMarcado: Boolean;
  APainter: TcxPainterAccess;
begin
  inherited;

  blnMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                         grdItensTableView.GetColumnByFieldName('Marcado').Index]) = 'S';

  If AViewInfo.GridRecord.Index < 0 Then
    Exit;

  If AViewInfo.Item.Index <> colunaMarca.Index Then
    Exit;

  APainter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));

  Try
    APainter.DrawBorders;
    If blnMarcado Then
      imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 1)
    Else
      imgLista.Draw(ACanvas.Canvas, Left + 1, Top + 1, 0);
  Finally
    APainter.Free;
  End;

  ADone := True;

end;

procedure TfrmCrmCatalogoPromocao.grdItensTableViewDblClick(Sender: TObject);
begin
  inherited;

  pMarcarIndividual;
end;

procedure TfrmCrmCatalogoPromocao.grdItensTableViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #13 Then
  Begin
    pMarcarIndividual;
    grdItensTableView.Site.Repaint;
  End;
end;

procedure TfrmCrmCatalogoPromocao.pCarregarGrid;
begin
  dtsDados.DataSet := cdsDados;

  grdItensTableView.ClearItems;

  colunaMarca := grdItensTableView.CreateColumn;
  colunaMarca.DataBinding.ValueTypeClass := TcxStringValueType;
  colunaMarca.Caption := 'ImgMarca';
  colunaMarca.Name := 'ImgMarca';
  colunaMarca.HeaderAlignmentHorz := taCenter;
  colunaMarca.Options.FilteringWithFindPanel := False;
  colunaMarca.Options.Focusing := False;
  colunaMarca.Options.FilteringAddValueItems := False;
  colunaMarca.Options.FilteringFilteredItemsList := False;
  colunaMarca.Options.FilteringMRUItemsList := False;
  colunaMarca.Options.FilteringPopup := False;
  colunaMarca.Options.FilteringPopupMultiSelect := False;
  colunaMarca.Options.ShowCaption := False;
  colunaMarca.Width := 24;

  grdItensTableView.DataController.CreateAllItems;
  grdItensTableView.NavigatorButtons.First.Click;
  pEscondeCampos;

  pMarcarTodos;

  Application.ProcessMessages;
end;

procedure TfrmCrmCatalogoPromocao.pDesmarcarTodos;
begin
  pMarcarDesmarcaTodos(False);
end;

procedure TfrmCrmCatalogoPromocao.pEscondeCampos;
begin
  Try
    grdItensTableView.GetColumnByFieldName('Cliente').Visible := blnExibeColCliente;
    grdItensTableView.GetColumnByFieldName('Marcado').Visible := False;
    grdItensTableView.GetColumnByFieldName('Promoção').Visible := False;
    grdItensTableView.GetColumnByFieldName('Preço Custo').Visible := False;
    grdItensTableView.GetColumnByFieldName('Código de Fábrica').Visible := False;
    grdItensTableView.GetColumnByFieldName('Preço').Visible := False;
    grdItensTableView.GetColumnByFieldName('CaminhoImagem').Visible := False;
    grdItensTableView.GetColumnByFieldName('Montadora').Visible := False;
    grdItensTableView.GetColumnByFieldName('Aplicacao').Visible := False;
    grdItensTableView.GetColumnByFieldName('IndiceImagem').Visible := False;
    grdItensTableView.GetColumnByFieldName('ThumGerado').Visible := False;
    grdItensTableView.GetColumnByFieldName('ImgCarregada').Visible := False;
    grdItensTableView.GetColumnByFieldName('AUTINCIMG').Visible := False;
    grdItensTableView.GetColumnByFieldName('Margem').Visible := fVerificaAcessoSistema('CRMCMG');
    grdItensTableView.GetColumnByFieldName('Preço c/ Imp. c/').Visible := blnExibeColImposto;
    grdItensTableView.GetColumnByFieldName('Preço Promoção c/ Imp.').Visible := blnExibeColImposto;
    grdItensTableView.GetColumnByFieldName('Preço com Impostos').Visible := blnExibeColImposto;
    grdItensTableView.GetColumnByFieldName('ITE_DESMAX').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODGRU').Visible := False;
    grdItensTableView.GetColumnByFieldName('UNI_CODUNI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODFOR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMLUB').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IPISAI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMVAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMATA').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_COMDIS').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IMPULT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREULT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREMED').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CLAIPI').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PESOIT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PESLIQ').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODFAB').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMIN').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMSG').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_MARMGE').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODMAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PRECOM').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_QTPPRO').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_IPIENT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_FREENT').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PRECUS').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODABF').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_OBRCPF').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_CODBAR').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE1').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE2').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE3').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE4').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE5').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE6').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_PREVE7').Visible := False;
    grdItensTableView.GetColumnByFieldName('ITE_DTAUVE').Visible := False;
    grdItensTableView.GetColumnByFieldName('QTDIA_SVND').Visible := False;
  except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCrmCatalogoPromocao.pEscondeCampos]');
  end;
end;

procedure TfrmCrmCatalogoPromocao.pInverterSelecao;
Var
  intRowNum: Integer;
begin
  intRowNum := cdsDados.RecNo;
  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pMarcar(cdsDados.FieldByName('Marcado').AsString <> 'S');
      Next;
    End;
  Finally
    cdsDados.RecNo := intRowNum;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmCrmCatalogoPromocao.pMarcar(blnStatus: Boolean);
begin
  If blnStatus Then
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('Marcado').AsString := 'S';
    cdsDados.Post;
  End
  Else
  Begin
    cdsDados.Edit;
    cdsDados.FieldByName('Marcado').AsString := 'N';
    cdsDados.Post;
  End;
end;

procedure TfrmCrmCatalogoPromocao.pMarcarDesmarcaTodos(blnStatus: Boolean);
Var
  intRowNum: Integer;
begin
  intRowNum := cdsDados.RecNo;
  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pMarcar(blnStatus);
      cdsDados.Next;
    End;
  Finally
    cdsDados.RecNo := intRowNum;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmCrmCatalogoPromocao.pMarcarIndividual;
begin
  If (cdsDados.FieldByName('Marcado').AsString = 'N') Then
    pMarcar(True)
  Else
    pMarcar(False);

  grdItensTableView.Site.Repaint;
  grdItensTableView.NavigatorButtons.Next.Click;
end;

procedure TfrmCrmCatalogoPromocao.pMarcarTodos;
begin
  pMarcarDesmarcaTodos(True);
end;

end.
