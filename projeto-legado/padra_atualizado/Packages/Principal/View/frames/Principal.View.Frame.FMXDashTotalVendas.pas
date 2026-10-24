unit Principal.View.Frame.FMXDashTotalVendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.Layouts;

type
  TframeTotalVendas = class(TfraGraficoBase)
    layTotalVendas: TLayout;
    layLegendasTotalVendas: TLayout;
    lblEixoYValor10TotalVendas: TLabel;
    lblEixoYValor9TotalVendas: TLabel;
    lblEixoYValor6TotalVendas: TLabel;
    lblEixoYValor4TotalVendas: TLabel;
    lblEixoYValor2TotalVendas: TLabel;
    lblEixoYValor3TotalVendas: TLabel;
    lblEixoYValor5TotalVendas: TLabel;
    lblEixoYValor7TotalVendas: TLabel;
    lblEixoYValor8TotalVendas: TLabel;
    lblEixoYValor1TotalVendas: TLabel;
    layGraficosTotalVendas: TLayout;
    linFundoTotalVendas1: TLine;
    linFundoTotalVendas2: TLine;
    linFundoTotalVendas3: TLine;
    linFundoTotalVendas4: TLine;
    linFundoTotalVendas5: TLine;
    linFundoTotalVendas6: TLine;
    linFundoTotalVendas7: TLine;
    linFundoTotalVendas8: TLine;
    linFundoTotalVendas9: TLine;
    linLegendaVerticalTotalVendas: TLine;
    flwGraficosTotalVendas: TFlowLayout;
    layColuna1TotalVendas: TLayout;
    lblTotalVendas1: TLabel;
    recTotalVendas1: TRectangle;
    layColuna2TotalVendas: TLayout;
    lblTotalVendas2: TLabel;
    recTotalVendas2: TRectangle;
    layColuna3TotalVendas: TLayout;
    lblTotalVendas3: TLabel;
    recTotalVendas3: TRectangle;
    layColuna4TotalVendas: TLayout;
    lblTotalVendas4: TLabel;
    recTotalVendas4: TRectangle;
    linLegendaHorizontalTotalVendas: TLine;
    layCabecalhoTotalVendas: TLayout;
    lblTituloTotalVendas: TLabel;
    lblSubtituloTotalVendas: TLabel;
    procedure recTotalVendas1MouseEnter(Sender: TObject);
    procedure recTotalVendas1MouseLeave(Sender: TObject);
    procedure recTotalVendas1Click(Sender: TObject);
  private
    { Private declarations }
    function  AtualizaValoresTotalVendas(strCodEmp, strTipVis: String): Double;
    procedure AtualizaLegendasTotalVendas(MaiorValor: Double);
    procedure AjustarGraficos;
  public
    { Public declarations }
    arrMeses: Array of Double;
    procedure AtualizaTotalVendas(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
  end;

var
  frameTotalVendas: TframeTotalVendas;

implementation

{$R *.fmx}

{ TframeTotalVendas }

procedure TframeTotalVendas.AjustarGraficos;
Var
  LWidthColuna,
  LMargem : Double;
begin
  LWidthColuna := (recFundoGrafico.Width -
                   layLegendasTotalVendas.Width -
                   layTotalVendas.Margins.Left -
                   layTotalVendas.Margins.Right - 10) / 4;

  layColuna1TotalVendas.Width := LWidthColuna;
  layColuna2TotalVendas.Width := LWidthColuna;
  layColuna3TotalVendas.Width := LWidthColuna;
  layColuna4TotalVendas.Width := LWidthColuna;

  LMargem := LWidthColuna / 4;

  recTotalVendas1.Margins.Left  := LMargem;
  recTotalVendas2.Margins.Left  := LMargem;
  recTotalVendas3.Margins.Left  := LMargem;
  recTotalVendas4.Margins.Left  := LMargem;

  recTotalVendas1.Margins.Right := LMargem;
  recTotalVendas2.Margins.Right := LMargem;
  recTotalVendas3.Margins.Right := LMargem;
  recTotalVendas4.Margins.Right := LMargem;

  Self.Repaint;
end;

procedure TframeTotalVendas.AtualizaLegendasTotalVendas(MaiorValor: Double);
Var
  LFatorDivisao : Double;
  LDataSelecionada: TDatetime;
  i:Integer;
  LEixoY, LEixoX: TLabel;
begin
  LFatorDivisao := MaiorValor / 9;

  For i := 1 To 9 Do
  Begin
    LEixoY := TLabel(FindComponent('lblEixoYValor'+ IntToStr(i+1) +'TotalVendas'));
    LEixoY.Text := FormatFloat('#,##0.00', LFatorDivisao * i);
  End;

  For i:= 4 DownTo 1 Do
  Begin
    LDataSelecionada := IncMonth(dtaMesSelecionado, i-4);

    LEixoX      := TLabel(FindComponent('lblTotalVendas'+ IntToStr(i)));
    LEixoX.Text := MesAnoPorExtenso(LDataSelecionada, True);
  End;
end;

procedure TframeTotalVendas.AtualizaTotalVendas(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
Var
  MaiorValor: Double;
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layTotalVendas);

  MaiorValor := AtualizaValoresTotalVendas(strCodEmp, strTipVis);
  AtualizaLegendasTotalVendas(MaiorValor);
  AjustarGraficos;

  AnimarAguarde(layTotalVendas, False);
end;

function TframeTotalVendas.AtualizaValoresTotalVendas(strCodEmp, strTipVis: String): Double;
Var
  LValRef     : Double;
  i           : Integer;
  recGrafico  : TRectangle;
begin
  Result := 0;

  If Assigned(objDash) Then
  Begin
    SetLength(arrMeses, 4);

    objDash.RetornaDadosTotalVendas(arrMeses, LValRef, dtaMesSelecionado, strTipoEmpresa, strCodEmp, strTipVis);
    LValRef := RoundUp(LValRef);

    For i := 0 To Length(arrMeses)-1 Do
    Begin
      recGrafico          := TRectangle(FindComponent('recTotalVendas' + IntToStr(i+1)));
      recGrafico.Tag      := 3-i;
      recGrafico.Height   := ValorToGrafico(arrMeses[3-i], LValRef);
    End;

    Result := LValRef;
  End;
end;

procedure TframeTotalVendas.recTotalVendas1Click(Sender: TObject);
Var
  LLegenda: TLabel;
begin
  inherited;
  LLegenda := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));

  MostraValorGrafico(TRectangle(Sender),
                     arrMeses[TRectangle(Sender).Tag],
                     LLegenda.Text);
end;

procedure TframeTotalVendas.recTotalVendas1MouseEnter(Sender: TObject);
Var
  LLegenda: TLabel;
begin
  inherited;
  LLegenda := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));

  MostraValorGrafico(TRectangle(Sender),
                     arrMeses[TRectangle(Sender).Tag],
                     LLegenda.Text);
end;

procedure TframeTotalVendas.recTotalVendas1MouseLeave(Sender: TObject);
begin
  inherited;
  EscondeValorGrafico;
end;

end.
