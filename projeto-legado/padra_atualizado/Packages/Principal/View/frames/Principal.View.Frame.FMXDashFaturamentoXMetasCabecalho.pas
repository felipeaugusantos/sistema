unit Principal.View.Frame.FMXDashFaturamentoXMetasCabecalho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, Shared.Functions.DataSet, System.Math,
  Shared.Functions.Core, Principal.View.Frame.FMXDashFaturamentoXMetasColuna;

type
  TframeFaturamentoXMetas = class(TfraGraficoBase)
    layFaturamentoXMetas: TLayout;
    layLegendasFaturamentoXMetas: TLayout;
    lblEixoYValor10FaturamentoXMetas: TLabel;
    lblEixoYValor9FaturamentoXMetas: TLabel;
    lblEixoYValor6FaturamentoXMetas: TLabel;
    lblEixoYValor4FaturamentoXMetas: TLabel;
    lblEixoYValor2FaturamentoXMetas: TLabel;
    lblEixoYValor3FaturamentoXMetas: TLabel;
    lblEixoYValor5FaturamentoXMetas: TLabel;
    lblEixoYValor7FaturamentoXMetas: TLabel;
    lblEixoYValor8FaturamentoXMetas: TLabel;
    lblEixoYValor1FaturamentoXMetas: TLabel;
    layGraficosFaturamentoXMetas: TLayout;
    linFundoFaturamentoXMetas1: TLine;
    linFundoFaturamentoXMetas2: TLine;
    linFundoFaturamentoXMetas3: TLine;
    linFundoFaturamentoXMetas4: TLine;
    linFundoFaturamentoXMetas5: TLine;
    linFundoFaturamentoXMetas6: TLine;
    linFundoFaturamentoXMetas7: TLine;
    linFundoFaturamentoXMetas8: TLine;
    linFundoFaturamentoXMetas9: TLine;
    linLegendaVerticalFaturamentoXMetas: TLine;
    linLegendaHorizontalFaturamentoXMetas: TLine;
    lstFaturamentoXMetas: TListBox;
    lstIteEmpresa1: TListBoxItem;
    layCabecalhoFaturamentoXMetas: TLayout;
    lblTituloFaturamentoXMetas: TLabel;
    lblSubtituloFaturamentoXMetas: TLabel;
    lblLegendaColunaFat: TLabel;
    cirCorFaturamento: TCircle;
    lblLegendaColunaMet: TLabel;
    cirCorMeta: TCircle;
    frameFaturamentoXMetasColuna1: TframeFaturamentoXMetasColuna;
    aniAguardeFatXMet: TAniIndicator;
    lblCarregandoFatXMet: TLabel;
    procedure frameFaturamentoXMetasColuna1recFaturamentoMouseEnter(
      Sender: TObject);
    procedure frameFaturamentoXMetasColuna1recFaturamentoMouseLeave(
      Sender: TObject);
  private
    { Private declarations }
    arrVlrFat,
    arrVlrMet: Array of Double;
    function  AtualizaValoresFaturamentoXMetas: Double;
    function  RetornaValorMaximo(qryValores: IMyQuery): Double;
    procedure AtualizaLegendasFaturamentoXMetas(MaiorValor: Double);
    procedure MostraValor(Sender:TRectangle);
    procedure Aguarde(Ligar: Boolean);
  public
    { Public declarations }
    procedure AtualizaFaturamentoXMetas(dtaSelecionado:TDateTime; strTipEmp: String);
  end;

var
  frameFaturamentoXMetas: TframeFaturamentoXMetas;

implementation

{$R *.fmx}

{ TframeFaturamentoXMetas }

procedure TframeFaturamentoXMetas.Aguarde(Ligar: Boolean);
begin
  layFaturamentoXMetas.Visible := Not Ligar;

  aniAguardeFatXMet.Visible    := Ligar;
  aniAguardeFatXMet.Enabled    := Ligar;

  Application.ProcessMessages;
end;

procedure TframeFaturamentoXMetas.AtualizaFaturamentoXMetas(dtaSelecionado:TDateTime; strTipEmp: String);
Var
  MaiorValor: Double;
begin
  lblSubtituloFaturamentoXMetas.Text := 'Desempenho das filiais no mês de ' + MesAnoPorExtenso(dtaSelecionado);

  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  Aguarde(True);

  MaiorValor := AtualizaValoresFaturamentoXMetas;
  AtualizaLegendasFaturamentoXMetas(MaiorValor);

  Aguarde(False);
end;

procedure TframeFaturamentoXMetas.AtualizaLegendasFaturamentoXMetas(
  MaiorValor: Double);
Var
  LFatorDivisao : Double;
  i:Integer;
  LEixoY: TLabel;
begin
  LFatorDivisao := MaiorValor / 9;

  For i := 1 To 9 Do
  Begin
    LEixoY := TLabel(FindComponent('lblEixoYValor'+ IntToStr(i+1) +'FaturamentoXMetas'));
    LEixoY.Text := FormatFloat('#,##0.00', LFatorDivisao * i);
  End;
end;

function TframeFaturamentoXMetas.AtualizaValoresFaturamentoXMetas: Double;
Var
  qryEmpresas : IMyQuery;
  strSQL       : String;
  LItem        : TListBoxItem;
  LFrame       : TframeFaturamentoXMetasColuna;
  LCount       : Integer;
  LItemWidth   : Single;
  LValorMaximo : Double;
Begin
  LValorMaximo := 0;
  strSQL := objDash.RetornaSQLFaturamentoXMetas(dtaMesSelecionado, strTipoEmpresa);

  lstFaturamentoXMetas.Items.Clear;

  If Not strSQL.IsEmpty Then
  Begin
    Try
      lstFaturamentoXMetas.BeginUpdate;

      qryEmpresas := objCore.fCriarQuery;

      qryEmpresas.Close;
      qryEmpresas.SQL.Clear;
      qryEmpresas.SQL.Add(strSQL);
      qryEmpresas.Open;

      LValorMaximo := RetornaValorMaximo(qryEmpresas);

      LItemWidth :=  ((recFundoGrafico.Width -
                       layLegendasFaturamentoXMetas.Width -
                       layFaturamentoXMetas.Margins.Left -
                       layFaturamentoXMetas.Margins.Right - 2) / qryEmpresas.RecordCount);

      If LItemWidth < 30 Then
        LItemWidth := 30;

      If Not qryEmpresas.IsEmpty Then
      Begin
        SetLength(arrVlrFat, qryEmpresas.RecordCount);
        SetLength(arrVlrMet, qryEmpresas.RecordCount);

        qryEmpresas.First;
        While Not qryEmpresas.Eof Do
        Begin
          Application.ProcessMessages;

          Inc(LCount);

          LItem         := TListBoxItem.Create(Self);
          LFrame        := TframeFaturamentoXMetasColuna.Create(Self);
          LFrame.Name   := 'FramaColuna' + LCount.ToString();
          LFrame.recFaturamento.OnMouseEnter := frameFaturamentoXMetasColuna1recFaturamentoMouseEnter;
          LFrame.recFaturamento.OnMouseLeave := frameFaturamentoXMetasColuna1recFaturamentoMouseLeave;

          LFrame.recMeta.OnMouseEnter := frameFaturamentoXMetasColuna1recFaturamentoMouseEnter;
          LFrame.recMeta.OnMouseLeave := frameFaturamentoXMetasColuna1recFaturamentoMouseLeave;

          LFrame.Parent := LItem;
          LFrame.Align  := TAlignLayout.Contents;
          LFrame.Width  := LItemWidth;
          LItem.Width   := LItemWidth;

          LFrame.layFaturamento.Width        := LItemWidth / 2;
          LFrame.recFaturamento.Margins.Left := (LItemWidth / 2) / 2;

          LFrame.layMeta.Width               := LItemWidth / 2;
          LFrame.recMeta.Margins.Right       := (LItemWidth / 2) / 2;

          LFrame.recFaturamento.Height       := ValorToGrafico(qryEmpresas.FieldByName('VLRFAT').AsFloat, LValorMaximo);
          arrVlrFat[LCount-1]                := qryEmpresas.FieldByName('VLRFAT').AsFloat;
          LFrame.recFaturamento.TagString    := qryEmpresas.FieldByName('CODEMP').AsString;
          LFrame.recFaturamento.Tag          := LCount;

          LFrame.recMeta.Height              := ValorToGrafico(qryEmpresas.FieldByName('VLRMET').AsFloat, LValorMaximo);
          arrVlrMet[LCount-1]                := qryEmpresas.FieldByName('VLRMET').AsFloat;
          LFrame.recMeta.TagString           := qryEmpresas.FieldByName('CODEMP').AsString;
          LFrame.recMeta.Tag                 := LCount;

          LFrame.lblLegenda.Text             := qryEmpresas.FieldByName('CODEMP').AsString;

          LItem.Parent := lstFaturamentoXMetas;

          qryEmpresas.Next;
        End;
      End;
    Finally
      lstFaturamentoXMetas.EndUpdate;
    End;
  End;
  Result := LValorMaximo;
end;

procedure TframeFaturamentoXMetas.frameFaturamentoXMetasColuna1recFaturamentoMouseEnter(
  Sender: TObject);
begin
  inherited;
  MostraValor(TRectangle(Sender));
end;

procedure TframeFaturamentoXMetas.frameFaturamentoXMetasColuna1recFaturamentoMouseLeave(
  Sender: TObject);
begin
  inherited;
  EscondeValorGrafico;
end;

procedure TframeFaturamentoXMetas.MostraValor(Sender:TRectangle);
Const
  LMargemPadrao = 15;
  LColunaLegendaWidth = 60;
Var
  LLayParent      : TLayout;
  LValor : Double;
  LNomeGrafico    : String;
begin
  LNomeGrafico := Copy(TRectangle(Sender).Name, 4, Length(TRectangle(Sender).Name) - 4);
  LLayParent   := TLayout(Sender.Parent);

  recCor.Fill.Color := Sender.Fill.Color;

  If (Sender.Fill.Color = cirCorFaturamento.Fill.Color) Then
    LValor := arrVlrFat[TRectangle(Sender).Tag-1]
  Else
    LValor := arrVlrMet[TRectangle(Sender).Tag-1];

  InformaValorEixoY(lblValorEixoY, Sender, LValor);
  lblValorEixoX.Text := 'Emp: ' + TRectangle(Sender).TagString;

  calValorGrafico.Width  := recCor.Margins.Left + recCor.Width +
                            lblValorEixoY.Margins.Left + lblValorEixoY.Width +
                            lblValorEixoY.Margins.Right;

  calValorGrafico.Position.X := LMargemPadrao + LColunaLegendaWidth +
                               (TListBoxItem(lstFaturamentoXMetas.ItemByIndex(0)).Width * (TRectangle(Sender).Tag - 1)) +
                                LLayParent.Position.X +
                               (LLayParent.Width / 2) -
                               (calValorGrafico.Width / 2) +
                               ((TRectangle(Sender).Width / 2) * IfThen(Pos('Meta', TRectangle(Sender).Name) > 0, -1, 1));

  calValorGrafico.Position.Y := recFundoGrafico.Height -
                               (Sender.Height + 35 + calValorGrafico.Height);

  calValorGrafico.BringToFront;
  calValorGrafico.Opacity := 1;
  calValorGrafico.Visible := True;
end;

function TframeFaturamentoXMetas.RetornaValorMaximo(qryValores: IMyQuery): Double;
Var
  LValorMaximo,
  LValor : Double;
begin
  LValorMaximo := 0;
  If Assigned(qryValores) Then
  Begin
    If Not qryValores.IsEmpty Then
    Begin
      qryValores.First;
      while not qryValores.Eof do
      begin
        Application.ProcessMessages;

        If (qryValores.FieldByName('VLRFAT').AsFloat >
            qryValores.FieldByName('VLRMET').AsFloat) Then
          LValor := qryValores.FieldByName('VLRFAT').AsFloat
        else
          LValor := qryValores.FieldByName('VLRMET').AsFloat;

        If LValor > LValorMaximo Then
          LValorMaximo := LValor;

        qryValores.Next;
      end;
    End;
  End;

  Result := LValorMaximo;
end;

end.
