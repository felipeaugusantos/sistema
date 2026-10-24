unit untPainelMovimentacaoGondola;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,untTGerenciaMovimentacaoGondola,
  cxDBLookupComboBox, dxmdaset, cxGridBandedTableView, cxGridDBBandedTableView,
  cxCurrencyEdit, Math, cxProgressBar, cxTextEdit, cxLabel, cxDBEditRepository, Vcl.ComCtrls,
  cxCheckBox;

type
  TfrmPainelMovimentacaoGondola = class(TfrmPai)
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    Panel1: TPanel;
    btnEfetivar: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    BitBtnLocked2: TBitBtnLocked;
    Label1: TLabel;
    dtsDados: TDataSource;
    cxgSolicitacao: TcxGridDBBandedTableViewCitel;
    cxgSolicitacaoSOL_STATUS: TcxGridDBBandedColumn;
    dtsAcao: TDataSource;
    cxgSolicitacaoSOL_DTASOL: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn3: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn4: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn5: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn6: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn7: TcxGridDBBandedColumn;
    cxgSolicitacaoColumn8: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_NUMLOT: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_QTDITE: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_FISORI: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_LOTORI: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_QTDATD: TcxGridDBBandedColumn;
    cxgSolicitacaoSALDIS: TcxGridDBBandedColumn;
    cxgSolicitacaoMARCAD: TcxGridDBBandedColumn;
    cxgSolicitacaoTEM_LOTE: TcxGridDBBandedColumn;
    cxgSolicitacaoSOL_OBSERV: TcxGridDBBandedColumn;
    cxEditRepository1: TcxEditRepository;
    cxLkpAcao: TcxEditRepositoryLookupComboBoxItem;
    dxMemData1: TdxMemData;
    dxMemData1KEY: TIntegerField;
    dxMemData1VALOR: TStringField;
    btnGerPed: TBitBtnLocked;
    cxgSolicitacaoColumn1: TcxGridDBBandedColumn;
    btnReimprime: TBitBtnLocked;
    cxgSolicitacaoColumn2: TcxGridDBBandedColumn;
    procedure cxgSolicitacaoCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgSolicitacaoKeyPress(Sender: TObject; var Key: Char);
    procedure cxgSolicitacaoEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgSolicitacaoFocusedRecordChanged(Sender: TcxCustomGridTableView;
      APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure cxgSolicitacaoSOL_STATUSGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure BitBtnLocked2Click(Sender: TObject);
    procedure cxgSolicitacaoSOL_QTDATDPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnEfetivarClick(Sender: TObject);
    procedure cxgSolicitacaoFocusedItemChanged(Sender: TcxCustomGridTableView;
      APrevFocusedItem, AFocusedItem: TcxCustomGridTableItem);
    procedure btnGerPedClick(Sender: TObject);
    procedure btnReimprimeClick(Sender: TObject);
  protected
    FGerenciaMovimentacaoGondola: TGerenciaMovimentacaoGondola;
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure pAbrePainel(AGerenciaMovimentacaoGondola: TGerenciaMovimentacaoGondola);
  end;

var
  frmPainelMovimentacaoGondola: TfrmPainelMovimentacaoGondola;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmPainelMovimentacaoGondola }

procedure TfrmPainelMovimentacaoGondola.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  FGerenciaMovimentacaoGondola.Autorizar
end;

procedure TfrmPainelMovimentacaoGondola.BitBtnLocked2Click(Sender: TObject);
begin
  inherited;
  FGerenciaMovimentacaoGondola.Indefinir
end;

procedure TfrmPainelMovimentacaoGondola.btnEfetivarClick(Sender: TObject);
begin
  inherited;
  FGerenciaMovimentacaoGondola.Efetivar;
end;

procedure TfrmPainelMovimentacaoGondola.btnGerPedClick(Sender: TObject);
begin
  inherited;
  FGerenciaMovimentacaoGondola.pImprimirSeparacao(True);
end;

procedure TfrmPainelMovimentacaoGondola.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;
  FGerenciaMovimentacaoGondola.Negar;
end;

procedure TfrmPainelMovimentacaoGondola.btnReimprimeClick(Sender: TObject);
begin
  inherited;


  FGerenciaMovimentacaoGondola.pImprimirSeparacao(True, True);

end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgSolicitacaoMARCAD.Index]) = 'M' Then
     ACanvas.Brush.Color := clAqua
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgSolicitacaoSOL_STATUS.Index]) = '1' Then
     ACanvas.Brush.Color := $D7EBFA
  Else If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgSolicitacaoSOL_STATUS.Index]) = '2' Then
     ACanvas.Brush.Color := clMoneyGreen;
  If AViewInfo.Item = cxgSolicitacaoSOL_LOTORI Then
    if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgSolicitacaoTEM_LOTE.Index]) = '0' Then
      ACanvas.Brush.Color := clGray;
  If AViewInfo.Item = cxgSolicitacaoSOL_QTDITE Then
      ACanvas.Brush.Color := clGradientActiveCaption;
  If (AViewInfo.Item = cxgSolicitacaoSOL_FISORI) or
     ((AViewInfo.Item = cxgSolicitacaoSOL_LOTORI) and (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxgSolicitacaoTEM_LOTE.Index]) <> '0')) or
     (AViewInfo.Item = cxgSolicitacaoSOL_QTDATD) Then
     ACanvas.Brush.Color := $D2FAFA;

  If AViewInfo.Selected Then
  Begin
    ACanvas.Font.Color := clBlack;
    ACanvas.Font.Style := [fsBold];
  End;
end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  var arrLotes: TConsultasArray;
      edtLote: TCustomEdit;

begin
  inherited;

  If dtsDados.DataSet.FieldByName('TEM_LOTE').AsInteger = 0 then
    Exit;
  If cxgSolicitacaoSOL_LOTORI.Focused Then
    If fEntraCons(Key) Then
    Begin
      edtLote := TCustomEdit.Create(nil);
      Try
        If fPesqLoteItens(Self,
                          edtLote,
                          nil,
                          fCfgSis('DECUNI', varInteger),
                          nil,
                          Key,
                          arrLotes,
                          True,
                          dtsDados.dataset.FieldByName('SOL_CODITE').AsString,
                          VS_strCodEmp,
                          True,
                          False,
                          nil,
                          False,
                          False,
                          False) Then
        Begin
          If not (dtsDados.DataSet.State in dsEditModes) Then
             dtsDados.DataSet.Edit;
           AEdit.EditValue := edtLote.Text;
           dtsDados.DataSet.FieldByName('SOL_LOTORI').AsString := edtLote.Text;
        End
        Else
          AEdit.Clear;
      Finally
        FreeAndNil(edtLote)
      End;

    End
    Else If Key = #13 Then
      cxgSolicitacaoSOL_QTDATD.Focused := True;
end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  If APrevFocusedItem = cxgSolicitacaoSOL_LOTORI then
    If FGerenciaMovimentacaoGondola.cdsDados.State in dsEditModes Then
      FGerenciaMovimentacaoGondola.cdsDados.Post;

end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoFocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;


  cxgSolicitacaoSOL_LOTORI.Options.Editing := True;
  cxgSolicitacaoSOL_FISORI.Options.Editing := True;
  cxgSolicitacaoSALDIS.Options.Editing := True;
  cxgSolicitacaoSOL_QTDATD.Options.Editing := True;
  If Assigned(AFocusedRecord) Then
  Begin
    If (VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgSolicitacaoTEM_LOTE.Index]) <> '0') Then
      cxgSolicitacaoSOL_LOTORI.Options.Editing := True
    Else
      cxgSolicitacaoSOL_LOTORI.Options.Editing := False;
    FGerenciaMovimentacaoGondola.strLoteOriginal := VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgSolicitacaoSOL_LOTORI.Index]);

    If (VarToStr(Sender.DataController.Values[AFocusedRecord.RecordIndex, cxgSolicitacaoSOL_STATUS.Index]) = '2') Then
    Begin
      cxgSolicitacaoSOL_LOTORI.Options.Editing := False;
      cxgSolicitacaoSOL_FISORI.Options.Editing := False;
      cxgSolicitacaoSALDIS.Options.Editing := False;
      cxgSolicitacaoSOL_QTDATD.Options.Editing := False;
    End;
  End;
end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoKeyPress(Sender: TObject;
  var Key: Char);
  var arrLotes: TConsultasArray;
      edtLote: TCustomEdit;

begin
  inherited;
  If cxgSolicitacaoSOL_LOTORI.Focused Then
  begin
    If fEntraCons(Key) Then
    Begin
      If (dtsDados.DataSet.FieldByName('TEM_LOTE').AsInteger > 0) Then
      Begin
        edtLote := TCustomEdit.Create(nil);
        Try
          If fPesqLoteItens(Self,
                            edtLote,
                            nil,
                            fCfgSis('DECUNI', varInteger),
                            nil,
                            Key,
                            arrLotes,
                            True,
                            dtsDados.dataset.FieldByName('SOL_CODITE').AsString,
                            VS_strCodEmp,
                            True,
                            False,
                            nil,
                            False,
                            False,
                            False) Then
          Begin
            If not (dtsDados.DataSet.State in dsEditModes) Then
               dtsDados.DataSet.Edit;
             dtsDados.DataSet.FieldByName('SOL_NUMLOT').AsString := edtLote.Text;
          End;

        Finally
          FreeAndNil(edtLote)
        End;

      End;
    End
    Else If Key = #13 Then
      cxgSolicitacaoSOL_QTDATD.Focused := True;

  End;
end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoSOL_QTDATDPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If DisplayValue = '' Then
    DisplayValue := 0;
  If DisplayValue > FGerenciaMovimentacaoGondola.cdsDados.FieldByName('SALDIS').AsFloat Then
  Begin
    pMensagemOk('Quantidade atendida não pode ser maior do que o Saldo Disponível!');
    If FGerenciaMovimentacaoGondola.cdsDados.FieldByName('SOL_QTDITE').AsFloat > FGerenciaMovimentacaoGondola.cdsDados.FieldByName('SALDIS').AsFloat Then
      DisplayValue := FGerenciaMovimentacaoGondola.cdsDados.FieldByName('SALDIS').AsFloat
    Else
      DisplayValue := FGerenciaMovimentacaoGondola.cdsDados.FieldByName('SOL_QTDITE').AsFloat;
  End;
end;

procedure TfrmPainelMovimentacaoGondola.cxgSolicitacaoSOL_STATUSGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = '0' Then
    AText := 'Indefinido'
  Else If AText = '1' Then
    AText := 'Negado'
  Else If AText = '2' Then
    AText := 'Autorizado'
end;

procedure TfrmPainelMovimentacaoGondola.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

begin
  inherited;
  Application.ProcessMessages;
  case Key of
    VK_SPACE : Begin
                 If ((cxgSolicitacaoSOL_LOTORI.Focused) Or (cxgSolicitacaoSOL_FISORI.Focused))And
                    (cxgSolicitacao.DataController.DataSet.State in dsEditModes) Then
                      Exit;
                   FGerenciaMovimentacaoGondola.MarcaDesmarcaItem(FGerenciaMovimentacaoGondola.cdsDados.FieldByName('MARCAD').AsString = '');

               End;
    VK_F5    : FGerenciaMovimentacaoGondola.MarcaDesmarcaTodos(True);
    VK_F6    : FGerenciaMovimentacaoGondola.MarcaDesmarcaTodos(False);
    VK_F1    : FGerenciaMovimentacaoGondola.Negar;
    VK_F2    : FGerenciaMovimentacaoGondola.Autorizar;
    VK_F3    : FGerenciaMovimentacaoGondola.Indefinir;
  End;
end;

class procedure TfrmPainelMovimentacaoGondola.pAbrePainel(AGerenciaMovimentacaoGondola: TGerenciaMovimentacaoGondola);
begin
  pCriarFormularios(TfrmPainelMovimentacaoGondola, frmPainelMovimentacaoGondola);
  Try
    frmPainelMovimentacaoGondola.FGerenciaMovimentacaoGondola :=  AGerenciaMovimentacaoGondola;
    frmPainelMovimentacaoGondola.dtsDados.DataSet := AGerenciaMovimentacaoGondola.cdsDados;
    AGerenciaMovimentacaoGondola.dtsDados := frmPainelMovimentacaoGondola.dtsDados;

    frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_LOTORI.Visible := AGerenciaMovimentacaoGondola.blnTemRegistroComLote;
    frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_NUMLOT.Visible := AGerenciaMovimentacaoGondola.blnTemRegistroComLote;
    TcxCurrencyEditProperties(frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_QTDITE.Properties).DisplayFormat := AGerenciaMovimentacaoGondola.mskSaldo;
    TcxCurrencyEditProperties(frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_QTDATD.Properties).DisplayFormat := AGerenciaMovimentacaoGondola.mskSaldo;
    TcxCurrencyEditProperties(frmPainelMovimentacaoGondola.cxgSolicitacaoSALDIS.Properties).DisplayFormat := AGerenciaMovimentacaoGondola.mskSaldo;
    frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_STATUS.RepositoryItem := frmPainelMovimentacaoGondola.cxLkpAcao;
    frmPainelMovimentacaoGondola.cxgSolicitacaoSOL_STATUS.Options.Editing := True;



    frmPainelMovimentacaoGondola.Showmodal;
  Finally
    FreeAndNil(frmPainelMovimentacaoGondola);
  End
end;

end.
