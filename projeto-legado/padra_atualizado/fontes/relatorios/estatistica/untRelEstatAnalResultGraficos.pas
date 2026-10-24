unit untRelEstatAnalResultGraficos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, vclTee.TeEngine, vclTee.Series, vclTee.TeeProcs, vclTee.Chart,
  vclTee.DBChart, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, Printers, BitBtnLockedIncrem, StrUtils, Math,
  VclTee.TeeGDIPlus, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade;

type
  TfrmRelEstatAnalResultGraficos = class(TfrmPaiSimples)
    dbchAnalise: TDBChart;
    brsrsSerieAnalise: TBarSeries;
    tbsAvaliacao: TTabSheet;
    brsrsAvaliacao: TBarSeries;
    dbchAvaliacao: TDBChart;
    tbsContasResultado: TTabSheet;
    cdsContas: TUniClientDataSet;
    cdsContasVALORES: TFloatField;
    cdsContasLEGENDAS: TStringField;
    tmrRotacao: TTimer;
    dbchContas: TDBChart;
    pSerContas: TPieSeries;
    chkAtivarRotacao: TCheckBox;
    trkbRotacao: TTrackBar;
    lbl1: TLabel;
    lbla: TLabel;
    trkbElevacao: TTrackBar;
    lbl2: TLabel;
    trkbZoom: TTrackBar;
    lblDespesas: TLabel;
    dlgImprimir: TPrinterSetupDialog;
    btnImprimir: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrRotacaoTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure trkbRotacaoChange(Sender: TObject);
    procedure trkbElevacaoChange(Sender: TObject);
    procedure trkbZoomChange(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    intRotacao: Integer;
    fltTotDesp: Double;
    { Private declarations }
  public
    { Public declarations }
    procedure pAdicionaCamposAnalise(strLegenda: string; fltValor: Double);
    procedure pAdicionaCamposAvalicao(strLegenda: string; fltValor: Double);
    procedure pAdicionaContasResultado(strLegenda: string; fltValor: Double);
  end;

var
  frmRelEstatAnalResultGraficos: TfrmRelEstatAnalResultGraficos;

implementation

{$R *.dfm}

uses untFuncoesSimples, untIFuncoes;

procedure TfrmRelEstatAnalResultGraficos.btnImprimirClick(Sender: TObject);
  Var
    intPag: Integer;
    intCon: Integer;
    chtGra: TDBChart;
begin
  inherited;

  chtGra := nil;

  If (pgcDados.TabIndex = 0) Then
    chtGra := dbchAnalise
  Else If (pgcDados.TabIndex = 1) Then
    chtGra := dbchAvaliacao
  Else If (pgcDados.TabIndex = 2) Then
    chtGra := dbchContas;
  intPag := chtGra.NumPages;
  intCon :=1;
  If dlgImprimir.Execute Then
  Begin
    chtGra.BackColor := clWhite;
    While (intCon <= intPag) Do
    Begin
      chtGra.Page := intCon;
      chtGra.Print;
      Inc(intCon);
    End;
  End;
end;

procedure TfrmRelEstatAnalResultGraficos.FormCreate(Sender: TObject);
begin
  inherited;
  cdsContas.CreateDataSet;
  intRotacao := 0;
  fltTotDesp := 0;
end;

procedure TfrmRelEstatAnalResultGraficos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F1: pgcDados.ActivePage := tbsGeral;
    VK_F2: pgcDados.ActivePage := tbsAvaliacao;
    VK_F3: pgcDados.ActivePage := tbsContasResultado;
  End;
  lblDespesas.Visible := (pgcDados.ActivePage = tbsContasResultado);  
end;

procedure TfrmRelEstatAnalResultGraficos.FormShow(Sender: TObject);
begin
  inherited;
  tbsContasResultado.Visible := Not cdsContas.IsEmpty;
  tmrRotacao.Enabled := Not cdsContas.IsEmpty;

  trkbRotacao.Position  := pSerContas.RotationAngle;
  trkbElevacao.Position := dbchContas.View3DOptions.Elevation;
  trkbZoom.Position     := dbchContas.View3DOptions.Zoom;

  lblDespesas.Caption := ' Total da Despesas: ' + FormatFloat('##,#0.00', fltTotDesp);

  pgcDados.ActivePage := tbsAvaliacao;
  pgcDados.ActivePage := tbsGeral;
end;

procedure TfrmRelEstatAnalResultGraficos.pAdicionaCamposAnalise(strLegenda: string; fltValor: Double);
begin
  brsrsSerieAnalise.AddBar(Abs(fltValor), strLegenda, IfThen(fltValor > 0, clGreen, clRed));
end;

procedure TfrmRelEstatAnalResultGraficos.pAdicionaCamposAvalicao(strLegenda: string; fltValor: Double);
begin
  brsrsAvaliacao.AddBar(Abs(fltValor), strLegenda, IfThen(fltValor > 0, clGreen, clRed));
end;

procedure TfrmRelEstatAnalResultGraficos.pAdicionaContasResultado(
  strLegenda: string; fltValor: Double);
begin
  cdsContas.Append;
  cdsContasLEGENDAS.AsString := strLegenda;
  cdsContasVALORES.AsFloat   := fltValor;
  cdsContas.Post;
  fltTotDesp := fltTotDesp + fltValor;
end;

procedure TfrmRelEstatAnalResultGraficos.pgcDadosChange(Sender: TObject);
begin
  inherited;
  lblDespesas.Visible := (pgcDados.ActivePage = tbsContasResultado);
end;

procedure TfrmRelEstatAnalResultGraficos.tmrRotacaoTimer(Sender: TObject);
begin
  inherited;
  If chkAtivarRotacao.Checked Then
  Begin
    If intRotacao < 360 Then Inc(intRotacao) Else intRotacao := 0;
    pSerContas.Rotate(intRotacao);
  End;
end;

procedure TfrmRelEstatAnalResultGraficos.trkbElevacaoChange(Sender: TObject);
begin
  inherited;
  If ((ActiveControl) = trkbElevacao) Then
  Begin
    dbchContas.View3DOptions.Elevation := trkbElevacao.Position;
  End;
end;

procedure TfrmRelEstatAnalResultGraficos.trkbRotacaoChange(Sender: TObject);
begin
  inherited;
  If ((ActiveControl) = trkbRotacao) Then
  Begin
    chkAtivarRotacao.Checked := False;
    pSerContas.Rotate(trkbRotacao.Position);
  End;
end;

procedure TfrmRelEstatAnalResultGraficos.trkbZoomChange(Sender: TObject);
begin
  inherited;
  If ((ActiveControl) = trkbZoom) Then
  Begin
    dbchContas.View3DOptions.Zoom := trkbZoom.Position;
  End;
end;

end.
