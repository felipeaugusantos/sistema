unit untMostraGraficoEvolucao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, DB, UniClientDataSet, vclTee.TeEngine, vclTee.Series, ComCtrls, StdCtrls,
  vclTee.TeeProcs, vclTee.Chart, vclTee.DBChart, AppEvnts, Menus, Buttons, ExtCtrls, Printers,
  StrUtils, BitBtnLockedIncrem, VclTee.TeeGDIPlus, Datasnap.DBClient, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmMostraGraficoEvolucao = class(TfrmPaiSimples)
    cdsEvolucao: TUniClientDataSet;
    cdsEvolucaoVAL_EIXO_X: TIntegerField;
    cdsEvolucaoMESANO: TStringField;
    cdsEvolucaoTOTMES: TFloatField;
    dbchEvolucao: TDBChart;
    dlgImprimir: TPrinterSetupDialog;
    cdsEvolucao2: TUniClientDataSet;
    cdsEvolucao2VAL_EIXO_X: TIntegerField;
    cdsEvolucao2MESANO: TStringField;
    cdsEvolucao2TOTMES: TFloatField;
    brsrsEvolucao: TBarSeries;
    brsrsSeries1: TBarSeries;
    btnImprimir: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    strTitulo: String;
    intValoresEixoX: Integer;    
    procedure pAdicionaDadosEvolucao(strAnoMes: string;
                                     fltValor: Double;
                                     MesBase: Integer = 1;
                                     blnComparaGrafico: Boolean = False);
  end;

var
  frmMostraGraficoEvolucao: TfrmMostraGraficoEvolucao;

implementation

{$R *.dfm}

{ TfrmMostraGraficoEvolucao }

procedure TfrmMostraGraficoEvolucao.btnImprimirClick(Sender: TObject);
  Var
    intPag: Integer;
    intCon: Integer;
begin
  inherited;
  intPag := dbchEvolucao.NumPages;
  intCon :=1;
  If dlgImprimir.Execute Then
  Begin
    dbchEvolucao.BackColor := clWhite;
    While (intCon <= intPag) Do
    Begin
      dbchEvolucao.Page := intCon;
      dbchEvolucao.Print;
      Inc(intCon);
    End;
  End;
end;

procedure TfrmMostraGraficoEvolucao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsEvolucao);
  FreeAndNil(cdsEvolucao2);
end;

procedure TfrmMostraGraficoEvolucao.FormCreate(Sender: TObject);
begin
  inherited;
  cdsEvolucao.CreateDataSet;
  cdsEvolucao2.CreateDataSet;
  intValoresEixoX := 0;   
end;

procedure TfrmMostraGraficoEvolucao.FormShow(Sender: TObject);
begin
  inherited;
  Caption := 'Relatório de Evolução de ' + strTitulo;
  dbchEvolucao.Title.Text.Clear;
  dbchEvolucao.Title.Text.Add('Gráfico de Evolução de ' + strTitulo);
end;

procedure TfrmMostraGraficoEvolucao.pAdicionaDadosEvolucao(strAnoMes: string;
                                                           fltValor: Double;
                                                           MesBase: Integer = 1;
                                                           blnComparaGrafico: Boolean = False);
begin
  Inc(intValoresEixoX);

  dbchEvolucao.Series[0].Marks.Visible := True;
  dbchEvolucao.Series[1].Visible := blnComparaGrafico;

  If (MesBase = 1) Then
  Begin
    cdsEvolucao.Append;
    cdsEvolucaoMESANO.AsString     := strAnoMes;
    cdsEvolucaoTOTMES.AsFloat      := fltValor;
    cdsEvolucaoVAL_EIXO_X.AsFloat  := intValoresEixoX * 5;
    cdsEvolucao.Post;
  End
  Else
  Begin
    cdsEvolucao2.Append;
    cdsEvolucao2MESANO.AsString     := strAnoMes;
    cdsEvolucao2TOTMES.AsFloat      := fltValor;
    cdsEvolucao2VAL_EIXO_X.AsFloat  := intValoresEixoX * 5;
    cdsEvolucao2.Post;
  End;
end;

end.
