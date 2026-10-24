unit Principal.View.Frame.FMXDashVendasXMetasDiarias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Objects, FMX.Controls.Presentation,
  FMX.Effects, FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Chart,
  FMX.Layouts, System.DateUtils, Shared.Functions.DataSet,
  Shared.Functions.Core;

type
  TframeVendasXMetasDiarias = class(TfraGraficoBase)
    layProjecaoVendasXMetas: TLayout;
    layCabecalhoProjecaoVendasXMetas: TLayout;
    lblTituloVendasXMetasDiarias: TLabel;
    layLegenda: TLayout;
    lblLegVendas: TLabel;
    layLegVendasForma: TLayout;
    linVendas: TLine;
    recVendas: TRectangle;
    lblLegMetas: TLabel;
    layLegMetasForma: TLayout;
    linMetas: TLine;
    recMetas: TRectangle;
    graVendasXMetas: TChart;
    graserMetas: TLineSeries;
    graserVendas: TLineSeries;
    procedure graVendasXMetasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure graVendasXMetasMouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaValoresVendasXMetas(strCodEmp, strTipVis: String);
  public
    { Public declarations }
    procedure AtualizaVendasXMetas(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
  end;

var
  frameVendasXMetasDiarias: TframeVendasXMetasDiarias;

implementation

{$R *.fmx}

{ TframeVendasXMetasDiarias }

procedure TframeVendasXMetasDiarias.AtualizaValoresVendasXMetas(strCodEmp, strTipVis: String);
Var
  qrySQL : IMyQuery;
  strSQL,
  strDia : String;
begin
  strSQL := objDash.RetornaSQLVendasXMetasDiarias(dtaMesSelecionado, strTipoEmpresa, strCodEmp, strTipVis);

  If Not strSQL.IsEmpty Then
  Begin
    graVendasXMetas.Series[0].Clear;
    graVendasXMetas.Series[1].Clear;
    Try
      qrySQL := objCore.fCriarQuery;

      qrySQL.Close;
      qrySQL.SQL.Clear;
      qrySQL.SQL.Add(strSQL);

      qrySQL.Open;

      If Not qrySQL.IsEmpty Then
      Begin
        While Not qrySQL.Eof Do
        Begin
          strDia := FormatFloat('00', DayOf(qrySQL.FieldByName('DIAMES').AsDate)) + '/' +
                    FormatFloat('00', MonthOf(qrySQL.FieldByName('DIAMES').AsDate));

          graVendasXMetas.Series[0].Add(qrySQL.FieldByName('METDIA').AsFloat, strDia);
          graVendasXMetas.Series[1].Add(qrySQL.FieldByName('VENDA').AsFloat, strDia);
          qrySQL.Next;
        End;
      End;

    Finally

    End;
  End;
end;

procedure TframeVendasXMetasDiarias.AtualizaVendasXMetas(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layProjecaoVendasXMetas);
  AtualizaValoresVendasXMetas(strCodEmp, strTipVis);
  AnimarAguarde(layProjecaoVendasXMetas, False);
end;

procedure TframeVendasXMetasDiarias.graVendasXMetasMouseLeave(Sender: TObject);
begin
  inherited;
  calValorGrafico.Visible := False;
end;

procedure TframeVendasXMetasDiarias.graVendasXMetasMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
var
  seriesIndex, valueIndex : Integer;
begin
  inherited;

  For seriesIndex := graVendasXMetas.SeriesCount - 1 downto 0 do
  begin
    valueIndex := graVendasXMetas.Series[seriesIndex].Clicked(X,Y);

    If (valueIndex > -1) Then
    Begin
      recCor.Fill.Color :=  graVendasXMetas.Series[seriesIndex].ValueColor[valueIndex];

      lblValorEixoX.Text := graVendasXMetas.Series[seriesIndex].ValueMarkText[valueIndex];
      lblValorEixoY.Text := 'R$ ' + FormatFloat('#,##0.00', graVendasXMetas.Series[seriesIndex].GetMarkValue(valueIndex));

      calValorGrafico.Width  := recCor.Margins.Left + recCor.Width +
                                lblValorEixoY.Margins.Left + lblValorEixoY.Width +
                                lblValorEixoY.Margins.Right;

      calValorGrafico.Position.X := X - (calValorGrafico.Width / 2) + 15;
      calValorGrafico.Position.Y := Y + 10;

      calValorGrafico.BringToFront;
      calValorGrafico.Opacity := 1;
      calValorGrafico.Visible := True;
      Break;
    End
    Else
      calValorGrafico.Visible := False;
  End;

end;

end.
