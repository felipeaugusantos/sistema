unit Principal.View.Frame.FMXDashPedidosNaoFaturados;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Objects, FMX.Controls.Presentation,
  FMX.Effects, FMX.Layouts;

type
  TframePedidosNaoFaturados = class(TfraGraficoBase)
    layPedidosNaoFaturados: TLayout;
    layLegendasPedidosNaoFaturados: TLayout;
    lblEixoYValor10PedidosNaoFaturados: TLabel;
    lblEixoYValor9PedidosNaoFaturados: TLabel;
    lblEixoYValor6PedidosNaoFaturados: TLabel;
    lblEixoYValor4PedidosNaoFaturados: TLabel;
    lblEixoYValor2PedidosNaoFaturados: TLabel;
    lblEixoYValor3PedidosNaoFaturados: TLabel;
    lblEixoYValor5PedidosNaoFaturados: TLabel;
    lblEixoYValor7PedidosNaoFaturados: TLabel;
    lblEixoYValor8PedidosNaoFaturados: TLabel;
    lblEixoYValor1PedidosNaoFaturados: TLabel;
    layGraficosPedidosNaoFaturados: TLayout;
    linFundoPedidosNaoFaturados1: TLine;
    linFundoPedidosNaoFaturados2: TLine;
    linFundoPedidosNaoFaturados3: TLine;
    linFundoPedidosNaoFaturados4: TLine;
    linFundoPedidosNaoFaturados5: TLine;
    linFundoPedidosNaoFaturados6: TLine;
    linFundoPedidosNaoFaturados7: TLine;
    linFundoPedidosNaoFaturados8: TLine;
    linFundoPedidosNaoFaturados9: TLine;
    linLegendaVerticalPedidosNaoFaturados: TLine;
    flwGraficosPedidosNaoFaturados: TFlowLayout;
    layColuna1PedidosNaoFaturados: TLayout;
    lblPedidosNaoFaturados1: TLabel;
    recPedidosNaoFaturados1: TRectangle;
    layColuna2PedidosNaoFaturados: TLayout;
    lblPedidosNaoFaturados2: TLabel;
    recPedidosNaoFaturados2: TRectangle;
    layColuna3PedidosNaoFaturados: TLayout;
    lblPedidosNaoFaturados3: TLabel;
    recPedidosNaoFaturados3: TRectangle;
    layColuna4PedidosNaoFaturados: TLayout;
    lblPedidosNaoFaturados4: TLabel;
    recPedidosNaoFaturados4: TRectangle;
    linLegendaHorizontalPedidosNaoFaturados: TLine;
    layCabecalhoPedidosNaoFaturados: TLayout;
    lblTituloPedidosNaoFaturados: TLabel;
    lblSubtituloPedidosNaoFaturados: TLabel;
    procedure recPedidosNaoFaturados1Click(Sender: TObject);
    procedure recPedidosNaoFaturados1MouseEnter(Sender: TObject);
    procedure recPedidosNaoFaturados1MouseLeave(Sender: TObject);
  private
    { Private declarations }
    function  AtualizaValoresPedidosNaoFaturados(strCodEmp, strTipVis: String): Double;
    procedure AtualizaLegendasPedidosNaoFaturados(MaiorValor: Double);
    procedure AjustarGraficos;
  public
    { Public declarations }
    arrMeses: Array of Double;
    procedure AtualizaPedidosNaoFaturados(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
  End;

var
  framePedidosNaoFaturados: TframePedidosNaoFaturados;

implementation

{$R *.fmx}

{ TframePedidosNaoFaturados }

procedure TframePedidosNaoFaturados.AjustarGraficos;
Var
  LWidthColuna,
  LMargem : Double;
begin
  LWidthColuna := (recFundoGrafico.Width -
                   layLegendasPedidosNaoFaturados.Width -
                   layPedidosNaoFaturados.Margins.Left -
                   layPedidosNaoFaturados.Margins.Right - 10) / 4;

  layColuna1PedidosNaoFaturados.Width := LWidthColuna;
  layColuna2PedidosNaoFaturados.Width := LWidthColuna;
  layColuna3PedidosNaoFaturados.Width := LWidthColuna;
  layColuna4PedidosNaoFaturados.Width := LWidthColuna;

  LMargem := LWidthColuna / 4;

  recPedidosNaoFaturados1.Margins.Left  := LMargem;
  recPedidosNaoFaturados2.Margins.Left  := LMargem;
  recPedidosNaoFaturados3.Margins.Left  := LMargem;
  recPedidosNaoFaturados4.Margins.Left  := LMargem;

  recPedidosNaoFaturados1.Margins.Right := LMargem;
  recPedidosNaoFaturados2.Margins.Right := LMargem;
  recPedidosNaoFaturados3.Margins.Right := LMargem;
  recPedidosNaoFaturados4.Margins.Right := LMargem;

  Self.Repaint;
end;

procedure TframePedidosNaoFaturados.AtualizaLegendasPedidosNaoFaturados(
  MaiorValor: Double);
Var
  LFatorDivisao : Double;
  LDataSelecionada: TDatetime;
  i:Integer;
  LEixoY, LEixoX: TLabel;
begin
  LFatorDivisao := MaiorValor / 9;

  For i := 1 To 9 Do
  Begin
    LEixoY := TLabel(FindComponent('lblEixoYValor'+ IntToStr(i+1) +'PedidosNaoFaturados'));
    LEixoY.Text := FormatFloat('#,##0.00', LFatorDivisao * i);
  End;

  For i:= 4 DownTo 1 Do
  Begin
    LDataSelecionada := IncMonth(dtaMesSelecionado, i-4);

    LEixoX      := TLabel(FindComponent('lblPedidosNaoFaturados'+ IntToStr(i)));

    If (i > 1) Then
      LEixoX.Text := MesAnoPorExtenso(LDataSelecionada, True)
    Else
      LEixoX.Text := 'Meses Anteriores';
  End;
end;

procedure TframePedidosNaoFaturados.AtualizaPedidosNaoFaturados(dtaSelecionado:TDateTime; strTipEmp, strCodEmp, strTipVis: String);
Var
  MaiorValor: Double;
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layPedidosNaoFaturados);

  MaiorValor := AtualizaValoresPedidosNaoFaturados(strCodEmp, strTipVis);
  AtualizaLegendasPedidosNaoFaturados(MaiorValor);
  AjustarGraficos;

  AnimarAguarde(layPedidosNaoFaturados, False);
end;

function TframePedidosNaoFaturados.AtualizaValoresPedidosNaoFaturados(strCodEmp, strTipVis: String): Double;
Var
  LValRef     : Double;
  i           : Integer;
  recGrafico  : TRectangle;
begin
  Result := 0;

  If Assigned(objDash) Then
  Begin
    SetLength(arrMeses, 4);

    objDash.RetornaDadosPedidosNaoFaturados(arrMeses, LValRef, dtaMesSelecionado, strTipoEmpresa, strCodEmp, strTipVis);
    LValRef := RoundUp(LValRef);

    For i := 0 To Length(arrMeses)-1 Do
    Begin
      recGrafico          := TRectangle(FindComponent('recPedidosNaoFaturados' + IntToStr(i+1)));
      recGrafico.Tag      := 3-i;
      recGrafico.Height   := ValorToGrafico(arrMeses[3-i], LValRef);
    End;

    Result := LValRef;
  End;
end;

procedure TframePedidosNaoFaturados.recPedidosNaoFaturados1Click(
  Sender: TObject);
Var
  LLegenda: TLabel;
begin
  inherited;
  LLegenda := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));

  MostraValorGrafico(TRectangle(Sender),
                     arrMeses[TRectangle(Sender).Tag],
                     LLegenda.Text);
end;

procedure TframePedidosNaoFaturados.recPedidosNaoFaturados1MouseEnter(
  Sender: TObject);
Var
  LLegenda: TLabel;
begin
  inherited;
  LLegenda := TLabel(FindComponent('lbl' + Copy(TRectangle(Sender).Name, 4, 20)));

  MostraValorGrafico(TRectangle(Sender),
                     arrMeses[TRectangle(Sender).Tag],
                     LLegenda.Text);
end;

procedure TframePedidosNaoFaturados.recPedidosNaoFaturados1MouseLeave(
  Sender: TObject);
begin
  inherited;
  EscondeValorGrafico;
end;

end.
