unit untImportCatalogoPrecoConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, Vcl.Mask,
  MaskEditFocus, EditFocus, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, uni, Datasnap.DBClient, UniClientDataSet, frxDBSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImportCatalogoPrecoConfirma = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlFiltros: TPanel;
    pnlGrid: TPanel;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosTableView1: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtArquivo: TEditFocus;
    cxgDadosTableView1LINEXC: TcxGridDBColumn;
    cxgDadosTableView1CODITE: TcxGridDBColumn;
    cxgDadosTableView1DESITE: TcxGridDBColumn;
    cxgDadosTableView1CODBAR: TcxGridDBColumn;
    cxgDadosTableView1CODFAB: TcxGridDBColumn;
    cxgDadosTableView1CATATI: TcxGridDBColumn;
    cxgDadosTableView1NVOCAT: TcxGridDBColumn;
    cxgDadosTableView1EXCLIN: TcxGridDBColumn;
    cxgDadosTableView1ATPRCT: TcxGridDBColumn;
    cxgDadosTableView1ATPRIT: TcxGridDBColumn;
    dtsDados: TDataSource;
    btnRelErr: TBitBtnLocked;
    frxReportJ_Criticas: TfrxReport;
    frxDbCriticas: TfrxDBDataset;
    dtsCriticas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRelErrClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    cdsCriticas: TUniClientDataSet;
    procedure pAbrirRelatorio;
    { Private declarations }
  public
    { Public declarations }
    blnConfirma : Boolean;
    stlLErrosRel : TStringList;
  end;

var
  frmImportCatalogoPrecoConfirma: TfrmImportCatalogoPrecoConfirma;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmImportCatalogoPrecoConfirma.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmImportCatalogoPrecoConfirma.btnRelErrClick(Sender: TObject);
begin
  inherited;
  pAbrirRelatorio;
end;

procedure TfrmImportCatalogoPrecoConfirma.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  cdsCriticas := TUniClientDataSet.Create(nil);
  stlLErrosRel := TStringList.Create;
end;

procedure TfrmImportCatalogoPrecoConfirma.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCriticas);
  FreeAndNil(stlLErrosRel);
  TUniClientDataSet(dtsDados.DataSet).Filtered := False;
  TUniClientDataSet(dtsDados.DataSet).Filter := '';
  inherited;
end;

procedure TfrmImportCatalogoPrecoConfirma.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F2 Then
    pAbrirRelatorio;
end;

procedure TfrmImportCatalogoPrecoConfirma.FormShow(Sender: TObject);
begin
  inherited;
  cdsCriticas.Data := TUniClientDataSet(dtsDados.DataSet).Data;
  cdsCriticas.Filtered := False;
  cdsCriticas.Filter := 'SITFOR > 0 OR SITMAR > 0 OR SITUNI > 0';
  cdsCriticas.Filtered := True;

  TUniClientDataSet(dtsDados.DataSet).Filtered := False;
  TUniClientDataSet(dtsDados.DataSet).Filter := 'SITFOR = 0 AND SITMAR = 0 AND SITUNI = 0';
  TUniClientDataSet(dtsDados.DataSet).Filtered := True;

  btnRelErr.Visible := (Not (cdsCriticas.IsEmpty)) or (stlLErrosRel.Count > 0);
  dtsCriticas.DataSet := cdsCriticas;
  pAbrirRelatorio;
end;

procedure TfrmImportCatalogoPrecoConfirma.pAbrirRelatorio;
begin
  If Not btnRelErr.Visible Then
     Exit;

  frxReportJ_Criticas.DotMatrixReport           := False;
  frxReportJ_Criticas.PrintOptions.PrintMode    := pmScale;
  frxReportJ_Criticas.PrintOptions.PrintOnSheet := 9;
  Try
    TfrxMemoView(frxReportJ_Criticas.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');
    TfrxMemoView(frxReportJ_Criticas.FindObject('MemoErros')).Text := stlLErrosRel.Text;
  Except
    TfrxMemoView(frxReportJ_Criticas.FindObject('mmoDetalhe')).Highlight.Color := clWindow;
  End;

  frxReportJ_Criticas.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

  If frxReportJ_Criticas.PrepareReport Then
    pPreviewReport(Self.Name, Self.Caption, frxReportJ_Criticas);
end;

end.
