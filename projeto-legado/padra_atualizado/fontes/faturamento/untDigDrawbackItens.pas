unit untDigDrawbackItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList, MemDS, DBAccess,
  Uni, cxCheckBox, cxTextEdit, cxCurrencyEdit,
  Shared.Functions.Types, Shared.Functions.Funcoes.Faturamento, untCalculoIpi;

type
  TfrmDigDrawbackItens = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlRodape: TPanel;
    shpCamObr: TShape;
    lblCamObr: TLabel;
    grdProdutosDBTableView: TcxGridDBTableView;
    grdProdutosLevel1: TcxGridLevel;
    grdProdutos: TcxGrid;
    cdsProdutos: TUniClientDataSet;
    dtsProdutos: TDataSource;
    cdsProdutosAUTINC: TIntegerField;
    cdsProdutosCLAFIS: TStringField;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESITE: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosVLRUNI: TFloatField;
    cdsProdutosVLRTOT: TFloatField;
    grdProdutosCODITE: TcxGridDBColumn;
    grdProdutosDESITE: TcxGridDBColumn;
    grdProdutosCODUNI: TcxGridDBColumn;
    grdProdutosQTDITE: TcxGridDBColumn;
    grdProdutosVLRUNI: TcxGridDBColumn;
    grdProdutosVLRTOT: TcxGridDBColumn;
    imgProduto: TcxImageList;
    cdsProdutosINDICE: TIntegerField;
    grdProdutosNUMDRW: TcxGridDBColumn;
    btnCopiarDrawback: TBitBtnLocked;
    cdsProdutosNUMDRW: TStringField;
    grdProdutosCLAFIS: TcxGridDBColumn;
    cdsProdutosCODUNI: TStringField;
    cdsProdutosCODSIT: TStringField;
    grdProdutosCODSIT: TcxGridDBColumn;
    btnCopiarClaFis: TBitBtnLocked;
    cdsProdutosCSTIPI: TStringField;
    cdsProdutosENQIPI: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdProdutosDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnCopiarDrawbackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopiarClaFisClick(Sender: TObject);
    procedure cdsProdutosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    procedure pCopiarColuna(strColuna: String);
    function fValidaClaFis: Boolean;
  public
    { Public declarations }
    objVenda: TFatVenda;
  end;

implementation

uses
  untFuncoesSimples, untConstantes;

{$R *.dfm}

procedure TfrmDigDrawbackItens.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  cdsProdutos.CheckBrowseMode;

  if (not fValidaClaFis) then
    Exit;

  Close;
  ModalResult := mrOk;
end;

procedure TfrmDigDrawbackItens.btnCopiarClaFisClick(Sender: TObject);
begin
  inherited;
  pCopiarColuna('CLAFIS');
end;

procedure TfrmDigDrawbackItens.btnCopiarDrawbackClick(Sender: TObject);
begin
  inherited;
  pCopiarColuna('NUMDRW');
end;

procedure TfrmDigDrawbackItens.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProdutos.CreateDataSet;
end;

procedure TfrmDigDrawbackItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F10: if btnConfirma.Enabled then
            begin
              btnConfirma.Click;
            end;
    VK_F2: btnCopiarDrawback.Click;
    VK_F3: if btnCopiarClaFis.Enabled then
           begin
             btnCopiarDrawback.Click;
           end;
  end;
end;

procedure TfrmDigDrawbackItens.FormShow(Sender: TObject);
begin
  inherited;

  btnCopiarClaFis.Enabled := (objVenda.strNotImp = 'S');
  grdProdutosDBTableView.GetColumnByFieldName('NUMDRW').Focused := True;
  grdProdutosDBTableView.GetColumnByFieldName('CLAFIS').Options.Editing := btnCopiarClaFis.Enabled;
end;

procedure TfrmDigDrawbackItens.grdProdutosDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := $0080FFFF;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmDigDrawbackItens.pCopiarColuna(strColuna: String);
var
  strValor: string;
  intPosicao: integer;
begin
  if (not cdsProdutos.Active) then
    Exit;

  if (cdsProdutos.RecordCount = 0) then
    Exit;

  if (cdsProdutos.RecNo < 1) then
    Exit;

  strValor := cdsProdutos.FieldByName(strColuna).AsString;

  cdsProdutos.DisableControls;
  intPosicao := cdsProdutos.RecNo;
  cdsProdutos.First;
  try
    while not cdsProdutos.Eof do
    begin
      cdsProdutos.Edit;
      cdsProdutos.FieldByName(strColuna).AsString := strValor;
      cdsProdutos.Next;
    end;
  finally
    cdsProdutos.RecNo := intPosicao;
    cdsProdutos.EnableControls;
  end;
end;

function TfrmDigDrawbackItens.fValidaClaFis: Boolean;
var
  cdsDados: TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(Nil);
  try
    pCloneDataSet(cdsDados, cdsProdutos);
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if fEmptyStr(cdsDados.FieldByName('CLAFIS').AsString) then
      begin
        fMensagem('ATENÇÃO!', 'Há registros com a Classificação Fiscal em branco!', ['&Ok']);
        Result := False;
        Break;
      end;

      if (objVenda.strNotImp <> 'S') then
      begin
        if (not objVenda.blnVendaPresencial) and (cdsDados.FieldByName('CLAFIS').AsInteger <= 7000) then
        begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal dos itens deve ser maior que 7000!', ['&Ok']);
          Result := False;
          Break;
        end;

        if (cdsDados.FieldByName('CLAFIS').AsString = '7127') and (fEmptyStr(cdsDados.FieldByName('NUMDRW').AsString)) then
        begin
          fMensagem('ATENÇÃO!', 'Não é permitido nº de DrawBack em branco para a classificação 7127!', ['&Ok']);
          Result := False;
          Break;
        end;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfrmDigDrawbackItens.cdsProdutosBeforePost(DataSet: TDataSet);
var
  strCstIpi: String;
  strEnqIpi: String;
  intIdx: Integer;
begin
  inherited;

  If (Not Self.Active) Then
    Exit;

  If (objVenda.strNotImp <> 'S') Then
  Begin
    If (Not fEmptyStr(cdsProdutos.FieldByName('NUMDRW').AsString)) Then
    Begin
      cdsProdutos.FieldByName('CLAFIS').AsString := CLAFIS_DRAWBACK;
    End
    Else If (cdsProdutos.FieldByName('CLAFIS').AsString = CLAFIS_DRAWBACK) Then
    Begin
      For intIdx := 0 To Length(objVenda.arrMatItens) -1 Do
      Begin
        If (objVenda.arrMatItens[intIdx].intAutInc = cdsProdutos.FieldByName('AUTINC').AsInteger) Then
        Begin
          objVenda.arrMatItens[intIdx].strNumDrw := '';
          objVenda.pDefineClassificacaoItem(objVenda.arrMatItens[intIdx], objVenda.fAtendeRegrasDifal(False, objVenda.arrMatItens[intIdx].strEmpIte));

          cdsProdutos.FieldByName('CLAFIS').AsString := objVenda.arrMatItens[intIdx].strClaFis;

          Break;
        End;
      End;
    End;
  End;

  If fEhItemServico(DataSet.FieldByName('CODITE').AsString) Then
    Exit;

  {***********************************************************************}
  {* Força utilização do cadastro de abreviação de IPI para alguns CFOPs *}
  {* Nesse cenário a CST de IPI segue as regras das abreviações de IPI   *}
  {********************************************************************BZ*}
  If Pos(DataSet.FieldByName('CLAFIS').AsString, VS_strCfoIPI) > 0 Then
  Begin
    pRetornaDadosAbreviacaoIpi(DataSet.FieldByName('CODITE').AsString,
                               DataSet.FieldByName('CLAFIS').AsString,
                               strCstIpi, strEnqIpi);
  End
  Else
  Begin
    Case TFunctionFuncoesFaturamento.ValidarSituacaoDoIpi(objVenda.strSitIPI)of
         integer(sitTributado) : Begin
                                   pRetornaDadosAbreviacaoIpi(DataSet.FieldByName('CODITE').AsString,
                                                              DataSet.FieldByName('CLAFIS').AsString,
                                                              strCstIpi, strEnqIpi);
                                 End;
            integer(sitIsento) : strCSTIpi := '52';
      integer(sitNaoTributado) : strCSTIpi := '53';
             integer(sitImune) : strCSTIpi := '54';
          integer(sitSuspenso) : strCSTIpi := '55';
    End;
  End;

  DataSet.FieldByName('CSTIPI').AsString := strCstIpi;
  DataSet.FieldByName('ENQIPI').AsString := strEnqIpi;
end;

end.
