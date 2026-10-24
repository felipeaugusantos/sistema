unit untChartRelatorioFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxDBData, cxGridLevel, cxGridChartView, cxGridDBChartView, cxClasses,
  cxGridCustomView, cxGrid, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, untGeraFR3, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd,
  dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns,
  dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv,
  dxPSPrVwRibbon, dxPScxPageControlProducer, dxPScxGridLnk,
  dxPScxGridLayoutViewLnk, dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxPgsDlg, dxPrnDlg, dxPSCore, dxPScxCommon;

type
  TfrmChartRelatorioFrame = class(TFrame)
    dtsGrafico: TDataSource;
    pnlChart: TPanel;
    shpGrafico: TShape;
    imgSupEsq: TImage;
    imgSupDir: TImage;
    imgInfEsq: TImage;
    imgInfDir: TImage;
    cxgGrafico: TcxGrid;
    cxvGrafico: TcxGridDBChartView;
    cxvGraficoSeries1: TcxGridDBChartSeries;
    cxgGraficoLevel1: TcxGridLevel;
    tmrRefreshDados: TTimer;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLink1: TdxGridReportLink;
    dxPrintStyleManager1: TdxPrintStyleManager;
    dxPrintStyleManager1Style1: TdxPSPrintStyle;
    dxPrintDialog1: TdxPrintDialog;
    dxPageSetupDialog1: TdxPageSetupDialog;
    dlgImprimir: TPrintDialog;
    procedure pnlChartResize(Sender: TObject);
    procedure tmrRefreshDadosTimer(Sender: TObject);
    procedure cxvGraficoActiveDataLevelChanged(Sender: TObject);
  private
    { Private declarations }
    procedure pSetaDiagrama(intTipDia: Integer);
    Function fTipoDiagrama: Integer;

  public
    { Public declarations }
    intRelatorio: Integer;
    objGeraFr3: TGeraFR3;
    strtTituloEixoX: String;

    procedure pIniciaDiagrama;
  end;

implementation

{$R *.dfm}

Uses
  untZClient,
  untFuncEditorRel,
  untFuncoesSimples,
  untRelatorio,
  untInterfaceRelatorio;

procedure TfrmChartRelatorioFrame.pSetaDiagrama(intTipDia: Integer);
Begin
  Case intTipDia Of
    1: cxvGrafico.DiagramColumn.Active := True;
    2: cxvGrafico.DiagramLine.Active := True;
    3: cxvGrafico.DiagramBar.Active := True;
    4: cxvGrafico.DiagramPie.Active := True;
    5: cxvGrafico.DiagramArea.Active := True;
    6: cxvGrafico.DiagramStackedColumn.Active := True;
    7: cxvGrafico.DiagramStackedBar.Active := True;
    8: cxvGrafico.DiagramStackedArea.Active := True;
  End;
End;

Function TfrmChartRelatorioFrame.fTipoDiagrama: Integer;
Begin
  Case TInterfaceRelatorio.fDestinoToTipo(objGeraFr3.arrCadRel[intRelatorio].FieldByName('REL_DESTIN').AsString) Of
    desGraficoLinha           : Result := 2;
    desGraficoBarras          : Result := 3;
    desGraficoTorta           : Result := 4;
    desGraficoArea            : Result := 5;
    desGraficoColunasEmpilhado: Result := 6;
    desGraficoBarrasEmpilhado : Result := 7;
    desGraficoAreaEmpilhado   : Result := 8;
    Else                        Result := 1;
  End;
End;

procedure TfrmChartRelatorioFrame.pIniciaDiagrama;
  Var
    cdsCampos: TZClient;
begin
 If Assigned(cxvGrafico.ActiveDataGroup) Then
 Begin
   If intRelatorio = 0 Then
     cdsCampos := objGeraFr3.cdsCamposG
   Else If Assigned(objGeraFr3.arrSalvaComplementos[intRelatorio - 1]) Then
     cdsCampos := TRelatorio(objGeraFr3.arrSalvaComplementos[intRelatorio - 1]).objInterface.cdsCampos
   Else
     cdsCampos := Nil;

   If Assigned(cdsCampos) And
      cdsCampos.Locate('CAM_NOMCAM', TcxGridDBChartDataGroup(cxvGrafico.ActiveDataGroup).DataBinding.FieldName, []) Then
   Begin
     If cdsCampos.FieldByName('CAM_TIPDIA').AsInteger > 0 Then
       pSetaDiagrama(cdsCampos.FieldByName('CAM_TIPDIA').AsInteger)
     Else
       pSetaDiagrama(fTipoDiagrama);
   End;
 End Else
 Begin
   pSetaDiagrama(fTipoDiagrama);
 End;

end;


procedure TfrmChartRelatorioFrame.cxvGraficoActiveDataLevelChanged(
  Sender: TObject);
begin
  pIniciaDiagrama;

 If Assigned(cxvGrafico.ActiveDataGroup) Then
 Begin
   cxvGrafico.DiagramArea.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramBar.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramColumn.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramLine.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramStackedArea.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramStackedBar.AxisCategory.Title.Text := '';
   cxvGrafico.DiagramStackedColumn.AxisCategory.Title.Text := '';
 End Else
 Begin
   cxvGrafico.DiagramArea.AxisCategory.Title.Text := strtTituloEixoX;;
   cxvGrafico.DiagramBar.AxisCategory.Title.Text := strtTituloEixoX;;
   cxvGrafico.DiagramColumn.AxisCategory.Title.Text := strtTituloEixoX;;
   cxvGrafico.DiagramLine.AxisCategory.Title.Text := strtTituloEixoX;;
   cxvGrafico.DiagramStackedArea.AxisCategory.Title.Text := strtTituloEixoX;;
   cxvGrafico.DiagramStackedBar.AxisCategory.Title.Text := strtTituloEixoX;
   cxvGrafico.DiagramStackedColumn.AxisCategory.Title.Text := strtTituloEixoX;
 End;

end;

procedure TfrmChartRelatorioFrame.pnlChartResize(Sender: TObject);
begin

  If shpGrafico.Visible Then
  Begin
    cxgGrafico.Width := shpGrafico.Width - 20;
    cxgGrafico.Left  := shpGrafico.Left + 10;

    cxgGrafico.Height := shpGrafico.Height - 20;
    cxgGrafico.Top    := shpGrafico.Top + 10;
  End;

end;

procedure TfrmChartRelatorioFrame.tmrRefreshDadosTimer(Sender: TObject);
  Var
    strTitulo: String;
begin
  Try
    tmrRefreshDados.Enabled := False;
    strTitulo := cxvGrafico.Title.Text;

    cxvGrafico.Title.Text := 'Atualizando...';
    Application.ProcessMessages;

    cxvGrafico.DataController.DataSource.DataSet.Refresh;
  Except
    cxvGrafico.Title.Text := 'Erro de atualização...';
    Application.ProcessMessages;
    Sleep(2000);
  End;

  cxvGrafico.Title.Text := strTitulo;
  Application.ProcessMessages;
  tmrRefreshDados.Enabled := True;
end;

end.
