unit untMostraOPIQueSeraoGeradaParaProdutosSemSaldo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxButtonEdit,
  System.Actions, Vcl.ActnList, untZClient, cxMaskEdit;

type
  TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo = class(TfrmPaiEdit)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewProduto: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensViewNomCor: TcxGridDBColumn;
    cxgItensViewSaldos: TcxGridDBColumn;
    cxgItensViewQtdCalc: TcxGridDBColumn;
    cxgItensViewQtdAProduzir: TcxGridDBColumn;
    cxgItensViewQTDOPI: TcxGridDBColumn;
    cxgItensViewDETALHE: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    ActionList1: TActionList;
    btnDetalhe: TAction;

    procedure btnDetalheExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxgItensViewQtdAProduzirPropertiesEditValueChanged(
      Sender: TObject);

    private

      FDataSet: TZClient;

    public

      property DataSet: TZClient read FDataSet write FDataSet;

  end;

var
  frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo: TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo;

implementation

{$R *.dfm}

uses untFuncoesSimples, untQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo;

procedure TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.btnConfirmaClick(
  Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.btnDetalheExecute(
  Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo, frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo);
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.edtQuantidade.Text := '1';
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.DataSet:= FDataSet;
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.strCodIte:= FDataSet.FieldByName('CODITE').AsString;
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.strCodCor:= FDataSet.FieldByName('CODCOR').AsString;
  frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.ShowModal;

  If frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo.ModalResult = MrOk Then
    frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.DataSet:= frmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.DataSet;

  FreeAndNil(frmQuantidadeOPIQueSeraoGeradaParaProdutosSemSaldo);
end;

procedure TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.btnSairClick(
  Sender: TObject);
begin
  inherited;
  ModalResult:= mrCancel;
end;

procedure TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.cxgItensViewQtdAProduzirPropertiesEditValueChanged(
  Sender: TObject);
Var
  fltQtdAProduzir: Double;
begin
  inherited;
  fltQtdAProduzir:= cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency;

  If cxgItensView.DataController.DataSource.DataSet.State = DsEdit Then
    cxgItensView.DataController.DataSource.DataSet.Post;

  If cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency <
     cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOTACUMULADO').AsCurrency Then
  Begin
    pMensagemOk('Quantidade a produzir não pode ser menor que a quantidade acumulada!');
    cxgItensView.DataController.DataSource.DataSet.Edit;
    cxgItensView.DataController.DataSource.DataSet.FieldByName('QTDTOT').AsCurrency := fltQtdAProduzir;
    cxgItensView.DataController.DataSource.DataSet.Post;
    Exit;
  End;

end;

procedure TfrmMostraOPIQueSeraoGeradaParaProdutosSemSaldo.FormCreate(
  Sender: TObject);
begin
  inherited;
  FDataSet:= Nil;
end;

end.
