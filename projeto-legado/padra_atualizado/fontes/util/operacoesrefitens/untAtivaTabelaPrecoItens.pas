unit untAtivaTabelaPrecoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGridBandedTableView,
  cxGridDBBandedTableView, untAtivaTabelaPreco, cxLabel, cxTextEdit;

type
  TfrmAtivaTabelaPrecoItens = class(TfrmPaiConfirma)
    cxgProdutosLevel1: TcxGridLevel;
    cxgProdutos: TcxGrid;
    cxvProdutos: TcxGridDBBandedTableView;
    cxvProdutosCODITE: TcxGridDBBandedColumn;
    cxvProdutosDESITE: TcxGridDBBandedColumn;
    cxvProdutosDESADB: TcxGridDBBandedColumn;
    cxvProdutosCLAIPI: TcxGridDBBandedColumn;
    cxvProdutosDIAFOR: TcxGridDBBandedColumn;
    cxvProdutosPREVEN: TcxGridDBBandedColumn;
    cxvProdutosMARGEM: TcxGridDBBandedColumn;
    cxvProdutosPRECOM: TcxGridDBBandedColumn;
    cxvProdutosDESF01: TcxGridDBBandedColumn;
    cxvProdutosCODEMP: TcxGridDBBandedColumn;
    btnMarTod: TBitBtnLocked;
    btnDesTod: TBitBtnLocked;
    btnMarcaDesmarca: TBitBtnLocked;
    cxvProdutosDESF02: TcxGridDBBandedColumn;
    cxvProdutosDESF03: TcxGridDBBandedColumn;
    cxvProdutosDESF04: TcxGridDBBandedColumn;
    cxvProdutosDESF05: TcxGridDBBandedColumn;
    cxvProdutosDESF06: TcxGridDBBandedColumn;
    cxvProdutosICMENT: TcxGridDBBandedColumn;
    cxvProdutosSUBFED: TcxGridDBBandedColumn;
    cxvProdutosIPIENT: TcxGridDBBandedColumn;
    cxvProdutosFREENT: TcxGridDBBandedColumn;
    cxvProdutosVALFRE: TcxGridDBBandedColumn;
    cxvProdutosACRFIN: TcxGridDBBandedColumn;
    cxvProdutosSUBSTI: TcxGridDBBandedColumn;
    cxvProdutosTCIFCU: TcxGridDBBandedColumn;
    cxvProdutosTSCUST: TcxGridDBBandedColumn;
    cxvProdutosDEPICO: TcxGridDBBandedColumn;
    cxvProdutosDEICMS: TcxGridDBBandedColumn;
    cxvProdutosFATREG: TcxGridDBBandedColumn;
    cxvProdutosPRECUS: TcxGridDBBandedColumn;
    cxvProdutosOUTVAL: TcxGridDBBandedColumn;
    cxvProdutosICMSAI: TcxGridDBBandedColumn;
    cxvProdutosIMPFED: TcxGridDBBandedColumn;
    cxvProdutosDESOPE: TcxGridDBBandedColumn;
    cxvProdutosBAREMB: TcxGridDBBandedColumn;
    cxvProdutosCODBAR: TcxGridDBBandedColumn;
    cxvProdutosCODFAB: TcxGridDBBandedColumn;
    cxvProdutosREFERE: TcxGridDBBandedColumn;
    cxvProdutosDESFAB: TcxGridDBBandedColumn;
    cxvProdutosPRENOV: TcxGridDBBandedColumn;
    cxvProdutosMLTCOM: TcxGridDBBandedColumn;
    cxvProdutosEMBALA: TcxGridDBBandedColumn;
    cxvProdutosPESOIT: TcxGridDBBandedColumn;
    cxvProdutosNOTESP: TcxGridDBBandedColumn;
    cxvProdutosEXCIPI: TcxGridDBBandedColumn;
    cxvProdutosSIGUNI: TcxGridDBBandedColumn;
    cxvProdutosCODABF: TcxGridDBBandedColumn;
    cxvProdutosABFPIS: TcxGridDBBandedColumn;
    cxvProdutosABFIPI: TcxGridDBBandedColumn;
    cxvProdutosABFCOF: TcxGridDBBandedColumn;
    cxvProdutosSITPRO: TcxGridDBBandedColumn;
    cxvProdutosPRDGRU: TcxGridDBBandedColumn;
    cxvProdutosPRECOMNOV: TcxGridDBBandedColumn;
    cxvProdutosDESF01NOV: TcxGridDBBandedColumn;
    cxvProdutosDESF02NOV: TcxGridDBBandedColumn;
    cxvProdutosDESF03NOV: TcxGridDBBandedColumn;
    cxvProdutosDESF04NOV: TcxGridDBBandedColumn;
    cxvProdutosDESF05NOV: TcxGridDBBandedColumn;
    cxvProdutosDESF06NOV: TcxGridDBBandedColumn;
    cxvProdutosICMENTNOV: TcxGridDBBandedColumn;
    cxvProdutosSUBFEDNOV: TcxGridDBBandedColumn;
    cxvProdutosIPIENTNOV: TcxGridDBBandedColumn;
    cxvProdutosFREENTNOV: TcxGridDBBandedColumn;
    cxvProdutosVALFRENOV: TcxGridDBBandedColumn;
    cxvProdutosACRFINNOV: TcxGridDBBandedColumn;
    cxvProdutosSUBSTINOV: TcxGridDBBandedColumn;
    cxvProdutosDESADBNOV: TcxGridDBBandedColumn;
    cxvProdutosTCIFCUNOV: TcxGridDBBandedColumn;
    cxvProdutosTSCUSTNOV: TcxGridDBBandedColumn;
    cxvProdutosDEPICONOV: TcxGridDBBandedColumn;
    cxvProdutosDEICMSNOV: TcxGridDBBandedColumn;
    cxvProdutosFATREGNOV: TcxGridDBBandedColumn;
    cxvProdutosPRECUSNOV: TcxGridDBBandedColumn;
    cxvProdutosOUTVALNOV: TcxGridDBBandedColumn;
    cxvProdutosICMSAINOV: TcxGridDBBandedColumn;
    cxvProdutosIMPFEDNOV: TcxGridDBBandedColumn;
    cxvProdutosDESOPENOV: TcxGridDBBandedColumn;
    cxvProdutosDIAFORNOV: TcxGridDBBandedColumn;
    cxvProdutosCLAIPINOV: TcxGridDBBandedColumn;
    cxvProdutosDESFABNOV: TcxGridDBBandedColumn;
    cxvProdutosCODFABNOV: TcxGridDBBandedColumn;
    cxvProdutosBAREMBNOV: TcxGridDBBandedColumn;
    cxvProdutosREFERENOV: TcxGridDBBandedColumn;
    cxvProdutosCODBARNOV: TcxGridDBBandedColumn;
    cxvProdutosEXCIPINOV: TcxGridDBBandedColumn;
    cxvProdutosMLTCOMNOV: TcxGridDBBandedColumn;
    cxvProdutosEMBALANOV: TcxGridDBBandedColumn;
    cxvProdutosNOTESPNOV: TcxGridDBBandedColumn;
    cxvProdutosPESOITNOV: TcxGridDBBandedColumn;
    cxvProdutosSIGUNINOV: TcxGridDBBandedColumn;
    cxvProdutosCODABFNOV: TcxGridDBBandedColumn;
    cxvProdutosABFPISNOV: TcxGridDBBandedColumn;
    cxvProdutosABFIPINOV: TcxGridDBBandedColumn;
    cxvProdutosABFCOFNOV: TcxGridDBBandedColumn;
    cxvProdutosSITPRONOV: TcxGridDBBandedColumn;
    cxvProdutosPRDGRUNOV: TcxGridDBBandedColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvProdutosMARCADO: TcxGridDBBandedColumn;
    Panel1: TPanel;
    lblLegendaAzul: TLabel;
    lblAvisoAtivo: TLabel;
    cxvProdutosCODFOR: TcxGridDBBandedColumn;
    cxvProdutosCODFORNOV: TcxGridDBBandedColumn;
    cxvProdutosCODTAB: TcxGridDBBandedColumn;
    cxvProdutosCODTABNOV: TcxGridDBBandedColumn;
    cxvProdutosCOMLIQ: TcxGridDBBandedColumn;
    cxvProdutosColumn1: TcxGridDBBandedColumn;
    cxvProdutosMARNOV: TcxGridDBBandedColumn;
    cxvProdutosColumn2: TcxGridDBBandedColumn;
    cxvProdutosTabPre: TcxGridDBBandedColumn;
    flpLegenda: TFlowPanel;
    pnlPreco1: TPanel;
    Shape1: TShape;
    lblPreco1: TLabel;
    pnlPreco2: TPanel;
    Shape2: TShape;
    Label2: TLabel;
    pnlPreco3: TPanel;
    Shape3: TShape;
    Label3: TLabel;
    pnlPreco4: TPanel;
    Shape4: TShape;
    Label4: TLabel;
    pnlPreco5: TPanel;
    Shape5: TShape;
    Label5: TLabel;
    Panel7: TPanel;
    pnlPreco6: TLabel;
    pnlPreco7: TPanel;
    Shape7: TShape;
    Label7: TLabel;
    Shape6: TShape;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnDesTodClick(Sender: TObject);
    procedure btnMarcaDesmarcaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxvProdutosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxvProdutosColumn2GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    function fQtdEmpresas : integer;
    { Private declarations }
  public
    { Public declarations }
    objAtivaTabela: TAtivaTabelaPreco
  end;

var
  frmAtivaTabelaPrecoItens: TfrmAtivaTabelaPrecoItens;

implementation

{$R *.dfm}

Uses
  StrUtils,
  untFuncoesSimples;

procedure TfrmAtivaTabelaPrecoItens.btnDesTodClick(Sender: TObject);
begin
  inherited;

  objAtivaTabela.fMarcaTodos(False);
  cxvProdutos.NavigatorButtons.First.Click;
end;

procedure TfrmAtivaTabelaPrecoItens.btnMarcaDesmarcaClick(Sender: TObject);
begin
  inherited;

  objAtivaTabela.pMarcaDesmarca;
end;

procedure TfrmAtivaTabelaPrecoItens.btnMarTodClick(Sender: TObject);
begin
  inherited;

  objAtivaTabela.fMarcaTodos(True);
  cxvProdutos.NavigatorButtons.First.Click;
end;

procedure TfrmAtivaTabelaPrecoItens.cxvProdutosColumn2GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If AText = 'S' Then
    AText := 'Sim'
  Else
    AText := 'Não'


end;

procedure TfrmAtivaTabelaPrecoItens.cxvProdutosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosMARCADO.Index]) = 'S') Then
      ACanvas.Font.Color := clBlue;

  If fQtdEmpresas > 1 then
  Begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '1') Then
      ACanvas.Brush.Color := clWhite;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '2') Then
      ACanvas.Brush.Color := $0087B8DE;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '3') Then
      ACanvas.Brush.Color := clSkyBlue;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '4') Then
      ACanvas.Brush.Color := clActiveCaption;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '5') Then
      ACanvas.Brush.Color := clMoneyGreen;;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '6') Then
      ACanvas.Brush.Color := $E6F0FA;
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvProdutosTabPre.Index]) = '7') Then
      ACanvas.Brush.Color := clSilver;
  End;

  If EndsText('_NOV', TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName) And
     Assigned(cxvProdutos.GetColumnByFieldName(AnsiReplaceStr(TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName, '_NOV', '_ATU'))) And
     (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                  cxvProdutos.GetColumnByFieldName(AnsiReplaceStr(TcxGridDBBandedColumn(AViewInfo.Item).DataBinding.FieldName, '_NOV', '_ATU')).Index]) <>
      VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                  AViewInfo.Item.Index])) Then
    ACanvas.Brush.Color := clYellow;
  If AViewInfo.Selected then
     ACanvas.Font.Color := clBlack;
end;

procedure TfrmAtivaTabelaPrecoItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fPergunta('Confirma a atualização de Preços?') Then
    Begin

      If objAtivaTabela.fAtualizaPrecos Then
        pMensagemOk('Operação concluída com sucesso!')
      Else
        Action := caNone;

    End

    Else Action := caNone;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
      Action := caNone;

  End;

end;

procedure TfrmAtivaTabelaPrecoItens.FormCreate(Sender: TObject);
begin
  inherited;

  cxvProdutosOUTVAL.Caption    := fCfgSis('DOVCPP') + ' (+)';
  cxvProdutosOUTVALNOV.Caption := fCfgSis('DOVCPP') + ' (+)';
  cxvProdutosDESADB.Caption    := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  cxvProdutosDESADBNOV.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
  cxvProdutosVALFRE.Caption    := fCfgSis('DESVFR') + ' (+)';
  cxvProdutosVALFRENOV.Caption := fCfgSis('DESVFR') + ' (+)';

  If Not (fCfgSis('SUFRAM', varBoolean) And (fCfgSis('FRMCUS', varString) = '4')) Then
  begin
    cxvProdutosTCIFCU.Visible := False;
    cxvProdutosTSCUST.Visible := False;
    cxvProdutosDEPICO.Visible := False;
    cxvProdutosDEICMS.Visible := False;
    cxvProdutosFATREG.Visible := False;

    cxvProdutosTCIFCUNOV.Visible := False;
    cxvProdutosTSCUSTNOV.Visible := False;
    cxvProdutosDEPICONOV.Visible := False;
    cxvProdutosDEICMSNOV.Visible := False;
    cxvProdutosFATREGNOV.Visible := False;
  End;

end;

procedure TfrmAtivaTabelaPrecoItens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
  If Key = VK_F3 Then
    btnMarTod.Click;
  If Key = VK_F4 Then
    btnDesTod.Click;
  If Key = VK_RETURN Then
    btnMarcaDesmarca.Click;
end;

procedure TfrmAtivaTabelaPrecoItens.FormShow(Sender: TObject);
begin
  inherited;

{  cxvProdutosCODTAB.Caption    := 'Tabela ' + objAtivaTabela.intTabelaPrecoVenda.ToString() + ' (Atual)';
  cxvProdutosCODTABNOV.Caption := 'Tabela ' + objAtivaTabela.intTabelaPrecoVenda.ToString() + ' (Nova)';

  cxvProdutosMARGEM.DataBinding.FieldName := 'ITE_MARBR' + objAtivaTabela.intTabelaPrecoVenda.ToString() + '_ATU';
  cxvProdutosMARNOV.DataBinding.FieldName := 'ITE_MARBR' + objAtivaTabela.intTabelaPrecoVenda.ToString() + '_NOV';
  cxvProdutosMARNOV.Caption := 'Margem ' + objAtivaTabela.intTabelaPrecoVenda.ToString() + ' (Nova)';

  cxvProdutosPREVEN.DataBinding.FieldName := 'ITE_PREVE' + objAtivaTabela.intTabelaPrecoVenda.ToString() + '_ATU';
  cxvProdutosPRENOV.DataBinding.FieldName := 'ITE_PREVE' + objAtivaTabela.intTabelaPrecoVenda.ToString() + '_NOV';
  cxvProdutosPRENOV.Caption := 'Preço Venda ' + objAtivaTabela.intTabelaPrecoVenda.ToString() + ' (Nova)';}


  cxvProdutos.DataController.DataSource := objAtivaTabela.cdsDados.dtsSource;
  flpLegenda.Visible := False;
  If fQtdEmpresas > 1 Then
    flpLegenda.Visible := True;

  If flpLegenda.Visible Then
  Begin
    If objAtivaTabela.strTabelaPrecoVenda[7] = 'N' Then
      pnlPreco7.Visible := False;

    If objAtivaTabela.strTabelaPrecoVenda[6] = 'N' Then
    begin
      pnlPreco6.Visible := False;
      Shape6.Visible := False;
    End;

    If objAtivaTabela.strTabelaPrecoVenda[5] = 'N' Then
      pnlPreco5.Visible := False;

    If objAtivaTabela.strTabelaPrecoVenda[4] = 'N' Then
      pnlPreco4.Visible := False;

    If objAtivaTabela.strTabelaPrecoVenda[3] = 'N' Then
      pnlPreco3.Visible := False;

    If objAtivaTabela.strTabelaPrecoVenda[2] = 'N' Then
      pnlPreco2.Visible := False;

    If objAtivaTabela.strTabelaPrecoVenda[1] = 'N' Then
      pnlPreco1.Visible:= False;
  End;


end;


function TfrmAtivaTabelaPrecoItens.fQtdEmpresas: integer;
var i : integer;
begin
  result := 0;
  For i := 1 To 7 do
  Begin
    If objAtivaTabela.strTabelaPrecoVenda[i] = 'S' Then
      inc(result);
  End;

end;

end.
