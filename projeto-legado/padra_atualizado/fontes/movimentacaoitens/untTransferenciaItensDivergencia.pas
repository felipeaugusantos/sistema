unit untTransferenciaItensDivergencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxLabel, EditFocus, untZClient, MemDS, DBAccess, Uni,
  cxImageComboBox, System.ImageList, Vcl.ImgList, cxImageList, dxGDIPlusClasses,
  Generics.Collections,
  untFuncoesSimples,
  untTransferenciaDivergenciaExcedente, cxCurrencyEdit;

type
  TfrmTransferenciaItensDivergencia = class(TfrmPaiEdit)
    pnlGrids: TPanel;
    cxgItensLVL: TcxGridLevel;
    cxgItens: TcxGridCitel;
    cxgEmpresas: TcxGridCitel;
    cxgEmpresasLVL: TcxGridLevel;
    btnFinalizar: TBitBtnLocked;
    pnlLegendas: TPanel;
    Image1: TImage;
    Label8: TLabel;
    Image2: TImage;
    Label9: TLabel;
    cxImageList2: TcxImageList;
    btnCancelar: TBitBtnLocked;
    Image4: TImage;
    Label11: TLabel;
    pnlTopo: TPanel;
    lblInstrucao: TLabel;
    cxgItensView: TcxGridTableView;
    cxgItensViewCODITE: TcxGridColumn;
    cxgItensViewDESITE: TcxGridColumn;
    cxgItensViewQTDCON: TcxGridColumn;
    cxgItensViewTIPDIV: TcxGridColumn;
    cxgEmpresasView: TcxGridTableView;
    cxgEmpresasViewColumn1: TcxGridColumn;
    cxgEmpresasViewColumn2: TcxGridColumn;
    cxgEmpresasViewQTDITE: TcxGridColumn;
    cxgItensViewColumn1: TcxGridColumn;
    procedure FormShow(Sender: TObject);
    procedure cxgItensViewFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgEmpresasViewEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FListaItens: TList<TItemContext>;
    FActiveItemIndex: Integer;
    procedure pPreencherGridItens;
    procedure pCarregarEmpresasDoItem(const AIndexItem: Integer);
  public
    { Public declarations }
    property ListaItens: TList<TItemContext> read FListaItens write FListaItens;
  end;

implementation

uses
  untMensagemTexto;


{$R *.dfm}

procedure TfrmTransferenciaItensDivergencia.btnFinalizarClick(
  Sender: TObject);
var
  LIndiceItem,
  J: Integer;
  LdobTotalAlocado: Double;
  LstrMsgErros: string;
  LintPrimeiroErroIndex: Integer;
  LblnErro: Boolean;
begin
  LblnErro := False;
  LstrMsgErros := '';
  LintPrimeiroErroIndex := -1;

  LstrMsgErros := FPadR('CÓD', 6) + ' ' +
               FPadR('ITEM', 35) + ' ' +
               FPadL('QTD DIV', 11) + ' ' +
               FPadL('QTD INF', 11) + #13#10 +
               StringOfChar('-', 65) + #13#10;

  for LIndiceItem := 0 to FListaItens.Count - 1 do
  begin
    LdobTotalAlocado := 0;
    for J := 0 to High(FListaItens[LIndiceItem].EmpresasTransf) do
    begin
      LdobTotalAlocado := LdobTotalAlocado + FListaItens[LIndiceItem].EmpresasTransf[J].QtdEnviar;
    end;

    if Abs(LdobTotalAlocado - FListaItens[LIndiceItem].QtdDivergencia) > 0.0001 then
    begin
      LblnErro := True;
      if LintPrimeiroErroIndex = -1 then
        LintPrimeiroErroIndex := LIndiceItem;

      // Formata e alinha cada coluna respeitando o limite total de 65 caracteres
      LstrMsgErros := LstrMsgErros +
        FPadR(FListaItens[LIndiceItem].CodIte, 6) + ' ' +
        FPadR(Copy(FListaItens[LIndiceItem].Descricao, 1, 35), 35) + ' ' +
        FPadL(FormatFloat(',0.00', FListaItens[LIndiceItem].QtdDivergencia), 11) + ' ' +
        FPadL(FormatFloat(',0.00', LdobTotalAlocado), 11) + #13#10;
    end;
  end;

  if LblnErro then
  begin
    TfrmMensagemTexto.pMensagem('ATENÇÃO',
        'Inconsistência de Quantidades Encontrada!' + #13#10 +
        LstrMsgErros + #13#10 +
        'A soma a enviar deve ser EXATAMENTE IGUAL à divergência de cada item.');

    cxgItensView.Controller.FocusedRecordIndex := LintPrimeiroErroIndex;
    pCarregarEmpresasDoItem(LintPrimeiroErroIndex);
    Exit;
  end;

  ModalResult := mrOk;
end;

procedure TfrmTransferenciaItensDivergencia.cxgEmpresasViewEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
var
  LItem: TItemContext;
  LRowIndex: Integer;
  LValorModificado: Variant;
begin
  inherited;
  if (AItem = nil) or (AItem.Index <> cxgEmpresasViewQTDITE.Index) then
    Exit;

  LRowIndex := Sender.Controller.FocusedRecordIndex;

  if (FActiveItemIndex >= 0) and (FActiveItemIndex < FListaItens.Count) and
   (LRowIndex >= 0) and (LRowIndex < Length(FListaItens[FActiveItemIndex].EmpresasTransf)) then
  begin
    LValorModificado := Sender.Controller.EditingController.Edit.EditValue;
    LItem := FListaItens[FActiveItemIndex];
    LItem.EmpresasTransf[LRowIndex].QtdEnviar :=
      fStrToFloat(VarToStrDef(LValorModificado, '0'), 0);
    FListaItens[FActiveItemIndex] := LItem;
  end;
end;

procedure TfrmTransferenciaItensDivergencia.cxgItensViewFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;
  if (AFocusedRecord <> nil) then
  begin
    if (AFocusedRecord.RecordIndex <> FActiveItemIndex) then
    begin
      pCarregarEmpresasDoItem(AFocusedRecord.RecordIndex);
    end;
  end;
end;

procedure TfrmTransferenciaItensDivergencia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F10: btnFinalizar.Click;
    VK_ESCAPE: Close;
  end;
  inherited;
end;

procedure TfrmTransferenciaItensDivergencia.FormShow(Sender: TObject);
begin
  inherited;
  FActiveItemIndex := 0;
  if not Assigned(FListaItens) or (FListaItens.Count = 0) then
  begin
    fMensagem('','Nenhum item com divergência pendente encontrado.',['OK']);
    ModalResult := mrCancel;
    Exit;
  end;
  pPreencherGridItens;
  pCarregarEmpresasDoItem(0);
end;

procedure TfrmTransferenciaItensDivergencia.pPreencherGridItens;
var
  I: Integer;
begin
  cxgItensView.DataController.RecordCount := FListaItens.Count;

  for I := 0 to FListaItens.Count - 1 do
  begin
    cxgItensView.DataController.Values[I, 0] := FListaItens[I].CodIte;
    cxgItensView.DataController.Values[I, 1] := FListaItens[I].Descricao;
    cxgItensView.DataController.Values[I, 2] := FListaItens[I].TipoDivergencia;
    cxgItensView.DataController.Values[I, 3] := FListaItens[I].QtdDivergencia;
    cxgItensView.DataController.Values[I, 4] := FListaItens[I].TipoDivergencia;
  end;
end;


procedure TfrmTransferenciaItensDivergencia.pCarregarEmpresasDoItem(const AIndexItem: Integer);
var
  I: Integer;
  LItem: TItemContext;
begin
  FActiveItemIndex := AIndexItem;
  LItem := FListaItens[AIndexItem];

  cxgEmpresasView.DataController.RecordCount := Length(LItem.EmpresasTransf);

  for I := 0 to High(LItem.EmpresasTransf) do
  begin
    cxgEmpresasView.DataController.Values[I, 0] := LItem.EmpresasTransf[I].CodEmp;
    cxgEmpresasView.DataController.Values[I, 1] := LItem.EmpresasTransf[I].NomEmp;
    cxgEmpresasView.DataController.Values[I, 2] := LItem.EmpresasTransf[I].QtdEnviar;
  end;
end;


end.
