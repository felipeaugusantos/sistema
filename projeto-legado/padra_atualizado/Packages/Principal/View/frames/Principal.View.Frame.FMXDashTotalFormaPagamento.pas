unit Principal.View.Frame.FMXDashTotalFormaPagamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Objects, FMX.Controls.Presentation,
  FMX.Effects, FMXTee.Engine, FMXTee.Series, FMXTee.Procs, FMXTee.Chart,
  FMX.Layouts, Shared.Functions.DataSet, Shared.Functions.Core;

type
  TframeTotalFormaPagamento = class(TfraGraficoBase)
    layTotalFormaPagamento: TLayout;
    layTituloTotalFormaPagamento: TLayout;
    lblSubTituloProjecaoMargem: TLabel;
    lblTituloProjecaoMargem: TLabel;
    layGraficoTotalFormaPagamento: TLayout;
    linTopoTotalFormaPagamento: TLine;
    linRodapeTotalFormaPagamento: TLine;
    graFormaPagamento: TChart;
    serFormasPagamento: TPieSeries;
    procedure graFormaPagamentoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure graFormaPagamentoMouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaValoresTotalFormaPagamento(strCodEmp: String);
  public
    { Public declarations }
    procedure AtualizaTotalFormaPagamento(dtaSelecionado:TDateTime; strTipEmp, strCodEmp: String);
  end;

var
  frameTotalFormaPagamento: TframeTotalFormaPagamento;

implementation

{$R *.fmx}

{ TframeTotalFormaPagamento }

procedure TframeTotalFormaPagamento.AtualizaTotalFormaPagamento(
  dtaSelecionado: TDateTime; strTipEmp, strCodEmp: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layTotalFormaPagamento);
  AtualizaValoresTotalFormaPagamento(strCodEmp);
  AnimarAguarde(layTotalFormaPagamento, False);
end;

procedure TframeTotalFormaPagamento.AtualizaValoresTotalFormaPagamento(strCodEmp: String);
Var
  qrySQL : IMyQuery;
  strSQL : String;
begin
  strSQL := objDash.RetornaSQLTotalFormaPagamento(dtaMesSelecionado, strTipoEmpresa, strCodEmp);

  If Not strSQL.IsEmpty Then
  Begin
    graFormaPagamento.Series[0].Clear;

    Try
      graFormaPagamento.BeginUpdate;
      qrySQL := objCore.fCriarQuery;

      qrySQL.Close;
      qrySQL.SQL.Clear;
      qrySQL.SQL.Add(strSQL + ' ORDER BY TOTITE DESC ');
      qrySQL.Open;

      If Not qrySQL.IsEmpty Then
      Begin
        While Not qrySQL.Eof Do
        Begin
          graFormaPagamento.Series[0].Add(qrySQL.FieldByName('TOTITE').AsFloat,
                                          qrySQL.FieldByName('FORMA_PAGAMENTO').AsString);
          qrySQL.Next;
        End;
      End;

    Finally
      graFormaPagamento.EndUpdate;
    End;
  End;
end;

procedure TframeTotalFormaPagamento.graFormaPagamentoMouseLeave(
  Sender: TObject);
begin
  inherited;
  calValorGrafico.Visible := False;
end;

procedure TframeTotalFormaPagamento.graFormaPagamentoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Single);
Var
  valueIndex : Integer;
begin
  inherited;
  valueIndex := graFormaPagamento.Series[0].Clicked(X,Y);

  If (valueIndex > -1) Then
  Begin
    recCor.Fill.Color :=  graFormaPagamento.Series[0].ValueColor[valueIndex];

    lblValorEixoX.Text := graFormaPagamento.Series[0].ValueMarkText[valueIndex];
    lblValorEixoY.Text := graFormaPagamento.Series[0].LegendString(valueIndex, ltsPlain);

    calValorGrafico.Width  := recCor.Margins.Left + recCor.Width +
                              lblValorEixoY.Margins.Left + lblValorEixoY.Width +
                              lblValorEixoY.Margins.Right;

    calValorGrafico.Position.X := X - (calValorGrafico.Width / 2) + 15;
    calValorGrafico.Position.Y := Y + 5;

    calValorGrafico.BringToFront;
    calValorGrafico.Opacity := 1;
    calValorGrafico.Visible := True;
  End
  Else
    calValorGrafico.Visible := False;
end;

end.
