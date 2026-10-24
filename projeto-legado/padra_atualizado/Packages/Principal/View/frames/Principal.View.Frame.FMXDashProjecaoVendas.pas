unit Principal.View.Frame.FMXDashProjecaoVendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.Layouts, DateUtils;

type
  TframeProjecaoVendas = class(TfraGraficoBase)
    layProjecaoFaturamento: TLayout;
    layLegendasProjecaoFaturamento: TLayout;
    lblEixoYValor10ProjecaoFaturamento: TLabel;
    lblEixoYValor9ProjecaoFaturamento: TLabel;
    lblEixoYValor6ProjecaoFaturamento: TLabel;
    lblEixoYValor4ProjecaoFaturamento: TLabel;
    lblEixoYValor2ProjecaoFaturamento: TLabel;
    lblEixoYValor3ProjecaoFaturamento: TLabel;
    lblEixoYValor5ProjecaoFaturamento: TLabel;
    lblEixoYValor7ProjecaoFaturamento: TLabel;
    lblEixoYValor8ProjecaoFaturamento: TLabel;
    lblEixoYValor1ProjecaoFaturamento: TLabel;
    layGraficosProjecaoFaturamento: TLayout;
    linFundoProjecaoFaturamento9: TLine;
    linFundoProjecaoFaturamento8: TLine;
    linFundoProjecaoFaturamento7: TLine;
    linFundoProjecaoFaturamento6: TLine;
    linFundoProjecaoFaturamento5: TLine;
    linFundoProjecaoFaturamento4: TLine;
    linFundoProjecaoFaturamento3: TLine;
    linFundoProjecaoFaturamento2: TLine;
    linFundoProjecaoFaturamento1: TLine;
    linLegendaVerticalProjecaoFaturamento: TLine;
    flwBGraficosProjecaoFaturamento: TFlowLayout;
    layColuna1ProjecaoFaturamento: TLayout;
    lblProjecaoFaturamento1: TLabel;
    recProjecaoFaturamento1: TRectangle;
    layColuna2ProjecaoFaturamento: TLayout;
    lblProjecaoFaturamento2: TLabel;
    recProjecaoFaturamento2: TRectangle;
    layColuna3ProjecaoFaturamento: TLayout;
    lblProjecaoFaturamento3: TLabel;
    recProjecaoFaturamento3: TRectangle;
    linLegendaHorizontalProjecaoFaturamento: TLine;
    layCabecalhoProjecaoFaturamento: TLayout;
    lblSubTituloProjecaoFaturamento: TLabel;
    lblVendaDiariaMeta: TLabel;
    lblVendaDiariaPraticada: TLabel;
    lblTituloProjecaoFaturamento: TLabel;
    procedure recProjecaoFaturamento1MouseEnter(Sender: TObject);
    procedure recProjecaoFaturamento1MouseLeave(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaLegendasProjecaoDeFaturamento(MaiorValor: Double);
    function  AtualizaValoresProjecaoDeFaturamento(strCodEmp, strTipVis: String): Double;
    procedure AjustarGraficos;
    function fEhDiaUtil(dteData: TDate): Boolean;
    procedure pCalculaDiasUteis(Var fltDiasUteis, fltDiasUteisPassados, fltDiasRestantes: Double);
  public
    { Public declarations }
    dtaMesSelecionado: TDateTime;
    arrProjecao      : Array of Double;

    procedure AtualizaProjecaoDeFaturamento(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
  end;

var
  frameProjecaoVendas: TframeProjecaoVendas;

implementation

{$R *.fmx}

{ TframeProjecaoVendas2 }

procedure TframeProjecaoVendas.AjustarGraficos;
Var
  LWidthColuna,
  LMargem : Double;
begin
  LWidthColuna := (recFundoGrafico.Width -
                   layLegendasProjecaoFaturamento.Width -
                   layProjecaoFaturamento.Margins.Left -
                   layProjecaoFaturamento.Margins.Right - 10) / 3;

  layColuna1ProjecaoFaturamento.Width := LWidthColuna;
  layColuna2ProjecaoFaturamento.Width := LWidthColuna;
  layColuna3ProjecaoFaturamento.Width := LWidthColuna;

  LMargem := LWidthColuna / 4;

  recProjecaoFaturamento1.Margins.Left  := LMargem;
  recProjecaoFaturamento2.Margins.Left  := LMargem;
  recProjecaoFaturamento3.Margins.Left  := LMargem;

  recProjecaoFaturamento1.Margins.Right := LMargem;
  recProjecaoFaturamento2.Margins.Right := LMargem;
  recProjecaoFaturamento3.Margins.Right := LMargem;

  Self.Repaint;
end;

procedure TframeProjecaoVendas.AtualizaLegendasProjecaoDeFaturamento(
  MaiorValor: Double);
Var
  LFatorDivisao : Double;
  i:Integer;
  LEixoY: TLabel;
begin
  LFatorDivisao := MaiorValor / 9;

  For i := 1 To 9 Do
  Begin
    LEixoY := TLabel(FindComponent('lblEixoYValor'+ IntToStr(i+1) +'ProjecaoFaturamento'));
    LEixoY.Text := FormatFloat('#,##0.00', LFatorDivisao * i);
  End;
end;

procedure TframeProjecaoVendas.AtualizaProjecaoDeFaturamento(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
Var
  LValorMaior: Double;
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layProjecaoFaturamento);

  LValorMaior := AtualizaValoresProjecaoDeFaturamento(strCodEmp, strTipVis);
  AtualizaLegendasProjecaoDeFaturamento(LValorMaior);
  AjustarGraficos;

  AnimarAguarde(layProjecaoFaturamento, False);
end;

function TframeProjecaoVendas.fEhDiaUtil(dteData: TDate): Boolean;
begin
  Result := True;

  If (DayOfWeek(dteData) in [1, 7]) Then
    Result := False;

  If objDash.EhFeriado(dteData) Then
    Result := False;
end;

procedure TframeProjecaoVendas.pCalculaDiasUteis(var fltDiasUteis,
  fltDiasUteisPassados, fltDiasRestantes: Double);
var
  dteData, dteDtaFin, dteHoje: TDate;
  fltValorSabado, fltValorDomingo: Double;
begin
  dteData   := dtaMesSelecionado;
  dteDtaFin := EncodeDate(YearOf(dtaMesSelecionado), MonthOf(dtaMesSelecionado), DaysInMonth(dtaMesSelecionado));
  dteHoje   := Now;

  fltDiasUteis := 0;
  fltDiasUteisPassados := 0;

  fltValorSabado := objDash.CfgSis('SABUTI');
  fltValorDomingo:= 0;

  While dteData <= dteDtaFin Do
  Begin
    If Not objDash.EhFeriado(dteData) Then
    Begin
      If fEhDiaUtil(dteData) Then
        fltDiasUteis := fltDiasUteis + 1

      Else If (DayOfWeek(dteData) = 7) Then
        fltDiasUteis := fltDiasUteis + fltValorSabado

      Else If (DayOfWeek(dteData) = 1) Then
        fltDiasUteis := fltDiasUteis + fltValorDomingo;

      if dteData <= dteHoje Then
        fltDiasUteisPassados := fltDiasUteis;
    End;

    dteData := dteData + 1;
  End;

  fltDiasRestantes := fltDiasUteis - fltDiasUteisPassados;
end;

function TframeProjecaoVendas.AtualizaValoresProjecaoDeFaturamento(strCodEmp, strTipVis: String): Double;
Var
  LValorMaior,
  LPraticada,
  LMetaDiaria,
  LValorRestante : Double;
  i              : Integer;
  recGrafico     : TRectangle;
  fltDiasUteis,
  fltDiasUteisPassados,
  fltDiasRestantes : Double;
begin
  Result := 0;

  pCalculaDiasUteis(fltDiasUteis, fltDiasUteisPassados, fltDiasRestantes);

  If Assigned(objDash) Then
  Begin
    SetLength(arrProjecao, 3);

    objDash.RetornaDadosProjecaoFaturamento(arrProjecao, LValorMaior, dtaMesSelecionado, strTipoEmpresa, strCodEmp, strTipVis);
    LValorMaior := RoundUp(LValorMaior);

    For i := 0 To Length(arrProjecao)-1 Do
    Begin
      recGrafico          := TRectangle(FindComponent('recProjecaoFaturamento' + IntToStr(i+1)));
      recGrafico.Tag      := i;
      recGrafico.Height   := ValorToGrafico(arrProjecao[i], LValorMaior);
    End;

    LPraticada     := arrProjecao[0] / fltDiasUteisPassados;
    LMetaDiaria    := 0;
    LValorRestante := arrProjecao[1] - arrProjecao[0];

    If (MesSelecionadoEhOMesAtual(dtaMesSelecionado)) Then
      If (LValorRestante > 0) Then
        LMetaDiaria:= LValorRestante / fltDiasRestantes;

    lblVendaDiariaPraticada.Text := 'Praticada R$ ' + FormatFloat('#,##0.00', LPraticada);
    lblVendaDiariaMeta.Text      := 'Necessária R$ ' + FormatFloat('#,##0.00', LMetaDiaria);

    Result := LValorMaior;
  End;
end;

procedure TframeProjecaoVendas.recProjecaoFaturamento1MouseEnter(
  Sender: TObject);
Var
  LLegenda: TLabel;
begin
  inherited;
  LLegenda := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));

  MostraValorGrafico(TRectangle(Sender),
                     arrProjecao[TRectangle(Sender).Tag],
                     LLegenda.Text);
end;

procedure TframeProjecaoVendas.recProjecaoFaturamento1MouseLeave(
  Sender: TObject);
begin
  inherited;
  EscondeValorGrafico;
end;

end.
