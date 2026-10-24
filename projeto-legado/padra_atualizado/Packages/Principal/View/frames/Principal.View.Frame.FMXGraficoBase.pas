unit Principal.View.Frame.FMXGraficoBase;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.Effects, FMX.Layouts,
  Principal.View.Interfaces, DateUtils, System.Math;

type
  TfraGraficoBase = class(TFrame)
    recFundoGrafico: TRectangle;
    efeSombra: TShadowEffect;
    calValorGrafico: TCalloutRectangle;
    lblValorEixoY: TLabel;
    lblValorEixoX: TLabel;
    recCor: TRectangle;
    aniAguarde: TAniIndicator;
    lblAguarde: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    objDash          : IDashboard;
    dtaMesSelecionado: TDateTime;
    strTipoEmpresa   : string;

    procedure AnimarAguarde(LayoutGrafico: TLayout; Ligar: Boolean = True; ProccessMessages:Boolean = true);
    procedure MostraValorGrafico(Sender: TRectangle; Valor: Double; Legenda: String; BarrasDuplas: Boolean = False);
    procedure EscondeValorGrafico;
    procedure InformaValorEixoY(EixoY: TLabel; Sender: TRectangle; Valor: Double; Porcentagem: Boolean = False);

    function  MesAnoPorExtenso(Data:TDate; Abreviado: Boolean = False): String;
    function  RoundUp(X: Extended): Extended;
    function  Sgn(X: Extended): Integer;
    function  ValorToGrafico(Valor, ValorMaximo: Double): Double;
    function  MesSelecionadoEhOMesAtual(dtaSelecionado:TDateTime): Boolean;
    function  FormataValorEEscondeVazio(Format, Valor: String; Moeda: Boolean = False): String;
  end;

implementation

{$R *.fmx}

{ TfraGraficoBase }

procedure TfraGraficoBase.AnimarAguarde(LayoutGrafico: TLayout; Ligar: Boolean = True; ProccessMessages:Boolean = true);
begin
  LayoutGrafico.Visible := Not Ligar;

  If ProccessMessages Then
  Begin
    aniAguarde.Visible    := Ligar;
    aniAguarde.Enabled    := Ligar;
    Application.ProcessMessages;
  End;
end;

procedure TfraGraficoBase.EscondeValorGrafico;
begin
  calValorGrafico.Visible := False;
end;

function TfraGraficoBase.FormataValorEEscondeVazio(Format, Valor: String;
  Moeda: Boolean): String;
begin
  Result := '';

  If Valor.IsEmpty Then
    Result := EmptyStr
  Else
  Begin
    If Moeda Then
      Result := 'R$ ';

    Result := Result + FormatFloat(Format, Valor.ToDouble());
  End;
end;

procedure TfraGraficoBase.InformaValorEixoY(EixoY: TLabel; Sender: TRectangle; Valor: Double; Porcentagem: Boolean = False);
Begin
  If Porcentagem Then
    EixoY.Text := FormatFloat('#,##0.00', Valor) + '%'
  Else
    EixoY.Text := 'R$ ' + FormatFloat('#,##0.00', Valor);
end;

function TfraGraficoBase.MesAnoPorExtenso(Data: TDate;
  Abreviado: Boolean): String;
Var
  Mes, Ano: Integer;
begin
  Mes := MonthOf(Data);
  Ano := YearOf(Data);

  Case Mes Of
    1 : Result := 'Janeiro';
    2 : Result := 'Fevereiro';
    3 : Result := 'Março';
    4 : Result := 'Abril';
    5 : Result := 'Maio';
    6 : Result := 'Junho';
    7 : Result := 'Julho';
    8 : Result := 'Agosto';
    9 : Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  End;

  If Abreviado Then
    // Jan/20
    Result := Copy(Result,1,3) + '/' + Copy(IntToStr(Ano),3,2)
  Else
    // Janeiro de 2020
    Result := Result + ' de ' + IntToStr(Ano);
end;

function TfraGraficoBase.MesSelecionadoEhOMesAtual(dtaSelecionado:TDateTime): Boolean;
begin
  Result := False;

  If (YearOf(Now) = YearOf(dtaSelecionado)) Then
    Result := MonthOf(dtaSelecionado) = MonthOf(Now);
end;

procedure TfraGraficoBase.MostraValorGrafico(Sender: TRectangle; Valor: Double; Legenda: String; BarrasDuplas: Boolean = False);
Const
  LMargemPadrao = 15;
  LColunaLegendaWidth = 60;
Var
  LLayParent      : TLayout;
  LNomeGrafico    : String;
begin
  LNomeGrafico     := Copy(TRectangle(Sender).Name, 4, Length(TRectangle(Sender).Name) - 4);
  LLayParent       := TLayout(Sender.Parent);

  recCor.Fill.Color := Sender.Fill.Color;

  InformaValorEixoY(lblValorEixoY, Sender, Valor);
  lblValorEixoX.Text := Legenda;

  calValorGrafico.Width  := recCor.Margins.Left + recCor.Width +
                            lblValorEixoY.Margins.Left + lblValorEixoY.Width +
                            lblValorEixoY.Margins.Right;

  If (BarrasDuplas) Then
  Begin
    calValorGrafico.Position.X := TRectangle(Sender).Position.X -
                                 (calValorGrafico.Width / 2) +
                                 (TRectangle(Sender).Width / 2);

    calValorGrafico.Position.Y := TRectangle(Sender).Position.Y - calValorGrafico.Height;
  End
  Else
  Begin
    calValorGrafico.Position.X := LMargemPadrao +
                                  LColunaLegendaWidth +
                                  LLayParent.Position.X +
                                 (LLayParent.Width / 2) -
                                 (calValorGrafico.Width / 2);

    calValorGrafico.Position.Y := recFundoGrafico.Height -
                                 (Sender.Height + 35 + calValorGrafico.Height);
  End;

  calValorGrafico.BringToFront;
  calValorGrafico.Opacity := 1;
  calValorGrafico.Visible := True;
end;

function TfraGraficoBase.RoundUp(X: Extended): Extended;
begin
  Result := Int(X) + Sgn(Frac(X));
end;

function TfraGraficoBase.Sgn(X: Extended): Integer;
begin
  if X < 0 then
    Result := -1
  else
    if X = 0 then
      Result := 0
    else
      Result := 1;
end;

function TfraGraficoBase.ValorToGrafico(Valor, ValorMaximo: Double): Double;
Const
  LAlturaMaxima: Single = 171;
begin
  If (ValorMaximo <= 0) Then
    Result := 0
  Else
    Result := (Valor * LAlturaMaxima) / ValorMaximo;
end;

end.
