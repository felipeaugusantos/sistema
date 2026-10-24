unit untLogImportacaoNotaEletronica;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Datasnap.DBClient, UniClientDataSet,
  cxGridBandedTableView, cxGridDBBandedTableView, frxDBSet;

type
  TfrmLogImportacaoNotaEletronica = class(TfrmPai)
    Panel4: TPanel;
    Panel2: TPanel;
    cxgDevolucoes: TcxGridCitel;
    cxlDevolucoes: TcxGridLevel;
    Panel5: TPanel;
    Panel3: TPanel;
    cxgXMLCancelamento: TcxGridCitel;
    cxvXMLCancelamento: TcxGridDBTableViewCitel;
    cxlXMLCancelamento: TcxGridLevel;
    Panel6: TPanel;
    Panel1: TPanel;
    cxgCancelados: TcxGridCitel;
    cxvCancelados: TcxGridDBTableViewCitel;
    cxlCancelados: TcxGridLevel;
    cdsCancelados: TUniClientDataSet;
    cdsXMLCancelamento: TUniClientDataSet;
    cdsDevolucoes: TUniClientDataSet;
    cxGridB08_NNF: TcxGridDBColumn;
    cxGridB07_SERIE: TcxGridDBColumn;
    cxGridC03_XNOME: TcxGridDBColumn;
    cxGridNOMARQ: TcxGridDBColumn;
    cxGridSTATUS: TcxGridDBColumn;
    dtsCancelados: TDataSource;
    dtsXMLCancelamento: TDataSource;
    dtsDevolucoes: TDataSource;
    cdsCanceladosB08_NNF: TStringField;
    cdsCanceladosB07_SERIE: TStringField;
    cdsCanceladosC03_XNOME: TStringField;
    cdsCanceladosNOMARQ: TStringField;
    cdsCanceladosSTATUS: TStringField;
    cxvDevolucoes: TcxGridDBTableViewCitel;
    cdsXMLCancelamentoNOMARQ: TStringField;
    cdsXMLCancelamentoDOCAUT: TStringField;
    cxvXMLCancelamentoDOCAUT: TcxGridDBColumn;
    cxvXMLCancelamentoNOMARQ: TcxGridDBColumn;
    cdsDevolucoesNOMARQ: TStringField;
    cdsDevolucoesDOCAUT: TStringField;
    cxvDevolucoesDOCAUT: TcxGridDBColumn;
    cxvDevolucoesNOMARQ: TcxGridDBColumn;
    cdsErros: TUniClientDataSet;
    cdsErrosNOMARQ: TStringField;
    cdsErrosNUMDOC: TStringField;
    cdsErrosNSERIE: TStringField;
    cdsErrosMOTIV: TStringField;
    cdsErrosCODITE: TStringField;
    cdsErrosCODBAR: TStringField;
    cdsErrosDESITE: TStringField;
    frxDBErros: TfrxDBDataset;
    frxReportJ: TfrxReport;
    btnRelErr: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnRelErrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogImportacaoNotaEletronica: TfrmLogImportacaoNotaEletronica;

implementation

{$R *.dfm}

procedure TfrmLogImportacaoNotaEletronica.btnRelErrClick(Sender: TObject);
var
  strNomFil,
  strTipImp: String;
  frxReport: TfrxReport;
begin
  inherited;
  If cdsErros.IsEmpty Then
    Exit;

  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

  frxReport := frxReportJ;
  frxReport.DotMatrixReport           := False;
  frxReport.PrintOptions.PrintMode    := pmScale;
  frxReport.PrintOptions.PrintOnSheet := 9;

  Try
    TfrxMemoView(frxReportJ.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');
  Except
    TfrxMemoView(frxReportJ.FindObject('mmoDetalhe')).Highlight.Color := clWindow;
  End;

  frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

  If frxReport.PrepareReport Then
    pPreviewReport(Self.Name, Self.Caption, frxReport);
end;

procedure TfrmLogImportacaoNotaEletronica.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCancelados.CreateDataSet;
  cdsXMLCancelamento.CreateDataSet;
  cdsDevolucoes.CreateDataSet;
  cdsErros.CreateDataSet;
end;

end.
