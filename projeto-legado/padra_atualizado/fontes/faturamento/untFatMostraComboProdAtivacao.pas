unit untFatMostraComboProdAtivacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomView, cxGridCitel, cxGridLevel, cxGrid,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxLabel, cxGridDBTableView,
  cxCheckBox, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmFatMostraComboProdAtivacao = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    pnlRodape: TPanel;
    cxgComVenLevel1: TcxGridLevel;
    cxgComVen: TcxGridCitel;
    cxgComVenDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    COMVEN: TcxGridDBBandedColumn;
    VIGENC: TcxGridDBBandedColumn;
    TABPRE: TcxGridDBBandedColumn;
    CODITE: TcxGridDBBandedColumn;
    DESITE: TcxGridDBBandedColumn;
    REFERE: TcxGridDBBandedColumn;
    UNIDAD: TcxGridDBBandedColumn;
    QTDITE: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    Label1: TLabel;
    Label2: TLabel;
    dtsComVen: TDataSource;
    cxStyle3: TcxStyle;
    pnlCabecalho: TPanel;
    Panel1: TPanel;
    cxgProCom: TcxGridCitel;
    cxgProComDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    SIGUNI: TcxGridDBBandedColumn;
    cxGridDBBandedColumn4: TcxGridDBBandedColumn;
    SITUAC: TcxGridDBBandedColumn;
    PREVEN: TcxGridDBBandedColumn;
    cxgProComLevel1: TcxGridLevel;
    dtsProCom: TDataSource;
    procedure cxgComVenDBBandedTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cxgComVenDBBandedTableViewCitel1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure pConfirma;
    procedure pFiltraProdCombo;
    procedure pAfterScroll(DataSet: TDataSet);
  public
    { Public declarations }
  end;

var
  frmFatMostraComboProdAtivacao: TfrmFatMostraComboProdAtivacao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatMostraComboProdAtivacao.cxgComVenDBBandedTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  pConfirma;
end;

procedure TfrmFatMostraComboProdAtivacao.cxgComVenDBBandedTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pConfirma;
end;

procedure TfrmFatMostraComboProdAtivacao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(cxgComVen);
end;

procedure TfrmFatMostraComboProdAtivacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsComVen.DataSet.AfterScroll := Nil;
  dtsProCom.DataSet.Filtered := False;
  dtsProCom.DataSet.Filter   := '';
end;

procedure TfrmFatMostraComboProdAtivacao.FormShow(Sender: TObject);
begin
  inherited;
  dtsComVen.DataSet.AfterScroll := pAfterScroll;
  pFiltraProdCombo;
end;

procedure TfrmFatMostraComboProdAtivacao.pAfterScroll(DataSet: TDataSet);
begin
  pFiltraProdCombo;
end;

procedure TfrmFatMostraComboProdAtivacao.pConfirma;
begin
  If (dtsComVen.DataSet.RecordCount = 0) Then
    Exit;

  If (fMensagem('ATENÇÃO!', 'Confirma a troca do Produto atual pelo Produto de Ativação selecionado e sua respectiva quantidade?', ['&S i m', '&N ã o'], 1) = 1) Then
    btnConfirma.Click;

end;

procedure TfrmFatMostraComboProdAtivacao.pFiltraProdCombo;
begin
  dtsProCom.DataSet.Filtered := False;
  dtsProCom.DataSet.Filter   := 'SEQGER = ' + QuotedStr(dtsComVen.DataSet.FieldByName('AUTINC').AsString);
  dtsProCom.DataSet.Filtered := True;
end;

end.
