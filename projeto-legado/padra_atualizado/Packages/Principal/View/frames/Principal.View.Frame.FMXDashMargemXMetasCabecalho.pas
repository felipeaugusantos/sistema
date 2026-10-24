unit Principal.View.Frame.FMXDashMargemXMetasCabecalho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.ListBox, FMX.Layouts, Shared.Functions.DataSet, System.Math,
  Shared.Functions.Core, Principal.View.Frame.FMXDashMargemXMetasColuna;

type
  TframeMargemXMetas = class(TfraGraficoBase)
    layMargemXMetas: TLayout;
    layLegendasMargemXMetas: TLayout;
    lblEixoYValor10MargemXMetas: TLabel;
    lblEixoYValor9MargemXMetas: TLabel;
    lblEixoYValor6MargemXMetas: TLabel;
    lblEixoYValor4MargemXMetas: TLabel;
    lblEixoYValor2MargemXMetas: TLabel;
    lblEixoYValor3MargemXMetas: TLabel;
    lblEixoYValor5MargemXMetas: TLabel;
    lblEixoYValor7MargemXMetas: TLabel;
    lblEixoYValor8MargemXMetas: TLabel;
    lblEixoYValor1MargemXMetas: TLabel;
    layGraficosMargemXMetas: TLayout;
    linFundoMargemXMetas1: TLine;
    linFundoMargemXMetas2: TLine;
    linFundoMargemXMetas3: TLine;
    linFundoMargemXMetas4: TLine;
    linFundoMargemXMetas5: TLine;
    linFundoMargemXMetas6: TLine;
    linFundoMargemXMetas7: TLine;
    linFundoMargemXMetas8: TLine;
    linFundoMargemXMetas9: TLine;
    linLegendaVerticalMargemXMetas: TLine;
    linLegendaHorizontalMargemXMetas: TLine;
    lstMargemXMetas: TListBox;
    lstIteEmpresa1: TListBoxItem;
    layCabecalhoMargemXMetas: TLayout;
    lblTituloMargemXMetas: TLabel;
    lblSubtituloMargemXMetas: TLabel;
    lblLegendaColunaMar: TLabel;
    cirCorMargem: TCircle;
    lblLegendaColunaMet: TLabel;
    cirCorMeta: TCircle;
    aniAguardeMarXMet: TAniIndicator;
    lblCarregandoMarXMet: TLabel;
    frameMargemXMetasColuna1: TframeMargemXMetasColuna;
    procedure frameMargemXMetasColuna1recMargemMouseEnter(Sender: TObject);
    procedure frameMargemXMetasColuna1recMargemMouseLeave(Sender: TObject);
  private
    { Private declarations }
    arrVlrFat,
    arrVlrMet: Array of Double;
    function  AtualizaValoresMargemXMetas(strComCus: String): Double;
    function  RetornaValorMaximo(qryValores: IMyQuery): Double;
    procedure AtualizaLegendasMargemXMetas(MaiorValor: Double);
    procedure MostraValor(Sender:TRectangle);
    procedure Aguarde(Ligar: Boolean);
  public
    { Public declarations }
    procedure AtualizaMargemXMetas(dtaSelecionado:TDateTime; strTipEmp: String; strComCus: String);
  end;

var
  frameMargemXMetas: TframeMargemXMetas;

implementation

{$R *.fmx}

{ TframeMargemXMetas }

procedure TframeMargemXMetas.Aguarde(Ligar: Boolean);
begin
  layMargemXMetas.Visible := Not Ligar;

  aniAguardeMarXMet.Visible    := Ligar;
  aniAguardeMarXMet.Enabled    := Ligar;

  Application.ProcessMessages;
end;

procedure TframeMargemXMetas.AtualizaMargemXMetas(dtaSelecionado:TDateTime; strTipEmp: String; strComCus: String);
Var
  MaiorValor: Double;
begin
  lblSubtituloMargemXMetas.Text := 'Desempenho das filiais no mês de ' + MesAnoPorExtenso(dtaSelecionado);

  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  Aguarde(True);

  MaiorValor := AtualizaValoresMargemXMetas(strComCus);
  AtualizaLegendasMargemXMetas(MaiorValor);

  Aguarde(False);
end;

procedure TframeMargemXMetas.AtualizaLegendasMargemXMetas(
  MaiorValor: Double);
Var
  LFatorDivisao : Double;
  i:Integer;
  LEixoY: TLabel;
begin
  LFatorDivisao := MaiorValor / 9;

  For i := 1 To 9 Do
  Begin
    LEixoY := TLabel(FindComponent('lblEixoYValor'+ IntToStr(i+1) +'MargemXMetas'));
    LEixoY.Text := FormatFloat('#,##0.00', LFatorDivisao * i) + '%';
  End;
end;

function TframeMargemXMetas.AtualizaValoresMargemXMetas(strComCus: String): Double;
Var
  qryEmpresas : IMyQuery;
  strSQL       : String;
  LItem        : TListBoxItem;
  LFrame       : TframeMargemXMetasColuna;
  LCount       : Integer;
  LItemWidth   : Single;
  LValorMaximo : Double;
Begin
  LValorMaximo := 0;
  strSQL := objDash.RetornaSQLMargemXMetas(dtaMesSelecionado, strTipoEmpresa, strComCus);

  lstMargemXMetas.Items.Clear;

  If Not strSQL.IsEmpty Then
  Begin
    Try
      lstMargemXMetas.BeginUpdate;

      qryEmpresas := objCore.fCriarQuery;

      qryEmpresas.Close;
      qryEmpresas.SQL.Clear;
      qryEmpresas.SQL.Add(strSQL);
      qryEmpresas.Open;

      LValorMaximo := RetornaValorMaximo(qryEmpresas);

      LItemWidth :=  ((recFundoGrafico.Width -
                       layLegendasMargemXMetas.Width -
                       layMargemXMetas.Margins.Left -
                       layMargemXMetas.Margins.Right - 2) / qryEmpresas.RecordCount);

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
          LFrame        := TframeMargemXMetasColuna.Create(Self);
          LFrame.Name   := 'FramaColuna' + LCount.ToString();
          LFrame.recMargem.OnMouseEnter := frameMargemXMetasColuna1recMargemMouseEnter;
          LFrame.recMargem.OnMouseLeave := frameMargemXMetasColuna1recMargemMouseLeave;

          LFrame.recMeta.OnMouseEnter := frameMargemXMetasColuna1recMargemMouseEnter;
          LFrame.recMeta.OnMouseLeave := frameMargemXMetasColuna1recMargemMouseLeave;

          LFrame.Parent := LItem;
          LFrame.Align  := TAlignLayout.Contents;
          LFrame.Width  := LItemWidth;
          LItem.Width   := LItemWidth;

          LFrame.layMargem.Width        := LItemWidth / 2;
          LFrame.recMargem.Margins.Left := (LItemWidth / 2) / 2;

          LFrame.layMeta.Width          := LItemWidth / 2;
          LFrame.recMeta.Margins.Right  := (LItemWidth / 2) / 2;

          LFrame.recMargem.Height       := ValorToGrafico(qryEmpresas.FieldByName('MARATU').AsFloat, LValorMaximo);
          arrVlrFat[LCount-1]           := qryEmpresas.FieldByName('MARATU').AsFloat;
          LFrame.recMargem.TagString    := qryEmpresas.FieldByName('CODEMP').AsString;
          LFrame.recMargem.Tag          := LCount;

          LFrame.recMeta.Height         := ValorToGrafico(qryEmpresas.FieldByName('VLRMET').AsFloat, LValorMaximo);
          arrVlrMet[LCount-1]           := qryEmpresas.FieldByName('VLRMET').AsFloat;
          LFrame.recMeta.TagString      := qryEmpresas.FieldByName('CODEMP').AsString;
          LFrame.recMeta.Tag            := LCount;

          LFrame.lblLegenda.Text        := qryEmpresas.FieldByName('CODEMP').AsString;

          LItem.Parent := lstMargemXMetas;

          qryEmpresas.Next;
        End;
      End;
    Finally
      lstMargemXMetas.EndUpdate;
    End;
  End;
  Result := LValorMaximo;
end;

procedure TframeMargemXMetas.frameMargemXMetasColuna1recMargemMouseEnter(
  Sender: TObject);
begin
  inherited;
  MostraValor(TRectangle(Sender));
end;

procedure TframeMargemXMetas.frameMargemXMetasColuna1recMargemMouseLeave(
  Sender: TObject);
begin
  inherited;
  EscondeValorGrafico;
end;

procedure TframeMargemXMetas.MostraValor(Sender:TRectangle);
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

  If (Sender.Fill.Color = cirCorMargem.Fill.Color) Then
    LValor := arrVlrFat[TRectangle(Sender).Tag-1]
  Else
    LValor := arrVlrMet[TRectangle(Sender).Tag-1];

  InformaValorEixoY(lblValorEixoY, Sender, LValor, True);
  lblValorEixoX.Text := 'Emp: ' + TRectangle(Sender).TagString;

  calValorGrafico.Width  := recCor.Margins.Left + recCor.Width +
                            lblValorEixoY.Margins.Left + lblValorEixoY.Width +
                            lblValorEixoY.Margins.Right;

  calValorGrafico.Position.X := LMargemPadrao + LColunaLegendaWidth +
                               (TListBoxItem(lstMargemXMetas.ItemByIndex(0)).Width * (TRectangle(Sender).Tag - 1)) +
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

function TframeMargemXMetas.RetornaValorMaximo(qryValores: IMyQuery): Double;
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

        If (qryValores.FieldByName('MARATU').AsFloat >
            qryValores.FieldByName('VLRMET').AsFloat) Then
          LValor := qryValores.FieldByName('MARATU').AsFloat
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
