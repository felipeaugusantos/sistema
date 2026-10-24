unit Principal.View.Frame.FMXDashProjecaoMargem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Principal.View.Frame.FMXGraficoBase, FMX.Controls.Presentation, FMX.Objects,
  FMX.Effects, FMX.Ani, FMX.Layouts, System.Math;

type
  TframeProjecaoMargem = class(TfraGraficoBase)
    layProjecaoMargem: TLayout;
    layTituloProjecaoMargem: TLayout;
    lblTituloProjecaoMargem: TLabel;
    layGraficoProjecaoMargem: TLayout;
    layVelocimento: TLayout;
    layPonteiro: TLayout;
    patPonteiro: TPath;
    cirBranco: TCircle;
    lblMargem2: TLabel;
    lblMargem1: TLabel;
    lblMargem4: TLabel;
    lblMargem3: TLabel;
    lblMargem5: TLabel;
    lblMargem6: TLabel;
    layLegendaMetaMes: TLayout;
    lblTituloMetaMes: TLabel;
    lblMetaMes: TLabel;
    cirCorMetaMes: TCircle;
    layLegendaVariacao: TLayout;
    lblVariacaoMeta: TLabel;
    cirVariacaoMeta: TCircle;
    lblLegendaVariacao: TLabel;
    layLegendaMargemAtual: TLayout;
    lblMetaAtual: TLabel;
    cirCorMetaAtual: TCircle;
    lblLegendaMetaAtual: TLabel;
    linTopoProjecaoMargem: TLine;
    linRodapeProjecaoMargem: TLine;
    imgVelocimetro: TImage;
    Pie1: TPie;
    layTopoMetaMes: TLayout;
    layTopoMargemAtual: TLayout;
    layTopoVariacao: TLayout;
    linBaseLegendas: TLine;
    linMetaMesLeft: TLine;
    linVariacaoMetaDireita: TLine;
    linMargemAtualRight: TLine;
    linMargemAtualLeft: TLine;
    layLegendaProjecaoMargem: TLayout;
  private
    { Private declarations }
    LMetaMargem,
    LMargemAtual: Double;

    procedure AtualizaValoresProjecaoDeMargem(strCodEmp, strComCus, strTipVis: String);
    procedure AtualizaLegendasProjecaoDeMargem;
    procedure AtualizaVelocimento(LMargem: Double);
    procedure AjustarGraficos;

    function MargemToAngulo(LMargem: Double): Double;
    function MargemMaxima: Double;
    function CorMargemAtual(LMargem: Double): TAlphaColor;
    function CalculaVariacao(LMargem: Double): Double;
    function UsaConfigDeMargem: Boolean;
  public
    { Public declarations }
    procedure AtualizaProjecaoDeMargem(dtaSelecionado:TDateTime; strTipEmp,
                                       strCodEmp, strComCus, strTipVis: String);
  end;

Const
  Vermelho   = TAlphaColor($FFE1211E);
  Laranja    = TAlphaColor($FFF87200);
  Amarelo    = TAlphaColor($FFF5B700);
  VerdeClaro = TAlphaColor($FFC4D803);
  Verde      = TAlphaColor($FF79BE27);

var
  frameProjecaoMargem: TframeProjecaoMargem;

implementation

{$R *.fmx}

{ TfraProjecaoMargem }

procedure TframeProjecaoMargem.AjustarGraficos;
Var
  LWidthColuna : Double;
begin
  LWidthColuna := (recFundoGrafico.Width -
                   layProjecaoMargem.Margins.Left -
                   layProjecaoMargem.Margins.Right - 2) / 3;

  layLegendaMetaMes.Width := LWidthColuna;
  layLegendaMargemAtual.Width := LWidthColuna;
  layLegendaVariacao.Width := LWidthColuna;

  Self.Repaint;
end;

procedure TframeProjecaoMargem.AtualizaLegendasProjecaoDeMargem;
Var
  LFatorDivisao: Double;
  i: Integer;
  LLegenda: TLabel;
begin
  LFatorDivisao := LMetaMargem / 4;

  For i := 1 To 5 Do
  Begin
    LLegenda := TLabel(FindComponent('lblMargem'+ IntToStr(i+1)));
    LLegenda.Text := FormatFloat('#0', LFatorDivisao * i) + '%';
  End;

  If UsaConfigDeMargem Then
  Begin
    lblTituloProjecaoMargem.Text := 'Projeção de Margem';
    lblLegendaMetaAtual.Text     := 'Margem Atual:';
  End
  Else
  Begin
    lblTituloProjecaoMargem.Text := 'Projeção de Markup';
    lblLegendaMetaAtual.Text     := 'Markup Atual:';
  End;

  AtualizaVelocimento(LMargemAtual);
end;

procedure TframeProjecaoMargem.AtualizaProjecaoDeMargem(dtaSelecionado:TDateTime; strTipEmp,
                                       strCodEmp, strComCus, strTipVis: String);
begin
  dtaMesSelecionado := dtaSelecionado;
  strTipoEmpresa    := strTipEmp;

  AnimarAguarde(layProjecaoMargem);

  AtualizaValoresProjecaoDeMargem(strCodEmp, strComCus, strTipVis);
  AtualizaLegendasProjecaoDeMargem;
  AjustarGraficos;

  AnimarAguarde(layProjecaoMargem, False);
end;

procedure TframeProjecaoMargem.AtualizaValoresProjecaoDeMargem(strCodEmp, strComCus, strTipVis: String);
begin
  If Assigned(objDash) Then
    objDash.RetornaDadosProjecaoMargem(LMetaMargem, LMargemAtual, dtaMesSelecionado, strTipoEmpresa, strCodEmp, strComCus, strTipVis);
end;

procedure TframeProjecaoMargem.AtualizaVelocimento(LMargem: Double);
Var
  //LMargem: Double;
  LCor: TAlphaColor;
begin
  lblMetaMes.Text := FormatFloat('#0.00', LMetaMargem) + '%';

  {pieVermelho.Fill.Color   := Vermelho;
  pieLaranja.Fill.Color    := Laranja;
  pieAmarelo.Fill.Color    := Amarelo;
  pieVerdeClaro.Fill.Color := VerdeClaro;
  pieVerde.Fill.Color      := Verde;}

  cirCorMetaMes.Fill.Color := Verde;
  cirCorMetaMes.Stroke.Color := Verde;

  lblMetaAtual.Text    := FormatFloat('#0.00', LMargem) + '%';
  lblVariacaoMeta.Text := FormatFloat('#0.00', CalculaVariacao(LMargem)) + '%';

  LCor := CorMargemAtual(LMargem);

  cirCorMetaAtual.Fill.Color   := LCor;
  cirCorMetaAtual.Stroke.Color := LCor;

  If ((RoundTo(LMargem, -2) - RoundTo(LMetaMargem, -2)) < 0) Then
  Begin
    cirVariacaoMeta.Fill.Color   := Vermelho;
    cirVariacaoMeta.Stroke.Color := Vermelho;
  End
  Else
  Begin
    cirVariacaoMeta.Fill.Color   := Verde;
    cirVariacaoMeta.Stroke.Color := Verde;
  End;

  layPonteiro.RotationAngle := MargemToAngulo(LMargem);

  If (RoundTo(layPonteiro.RotationAngle, -2) = 180) Then
  Begin
    lblMetaAtual.Text    := FormatFloat('#0.00', LMargemAtual) + '%';
    lblVariacaoMeta.Text := FormatFloat('#0.00', CalculaVariacao(LMargemAtual)) + '%';
  End;
end;

function TframeProjecaoMargem.CalculaVariacao(LMargem: Double): Double;
begin
  If (LMetaMargem = 0) Then
    Result := 100
  Else
    Result := RoundTo((LMargem * 100) / LMetaMargem, -2);
end;

function TframeProjecaoMargem.CorMargemAtual(LMargem: Double): TAlphaColor;
Var
  i: Integer;
  LVariacao: Double;
begin
  Result := $00000000;

  LVariacao := (LMetaMargem / 4);

  i := 1;
  While (i <= 5) Do
  Begin
    If (RoundTo(LMargem, -2) <= RoundTo((LVariacao * i), -2)) Then
    Begin
      If (RoundTo(LMargem, -2) = RoundTo((LVariacao * i), -2)) Then
        Inc(i);

      Case i Of
        1: Result := Vermelho;
        2: Result := Laranja;
        3: Result := Amarelo;
        4: Result := VerdeClaro;
        5: Result := Verde;
      End;

      If (Result = $00000000) Then
        If (i > 5) Then
          Result := Verde;

      Exit;
    End;

    Inc(i);
  End;
end;

function TframeProjecaoMargem.MargemMaxima: Double;
begin
  Result := (LMetaMargem / 4) + LMetaMargem;
end;

function TframeProjecaoMargem.MargemToAngulo(LMargem: Double): Double;
Var
  LMaxima: Double;
begin
  LMaxima := MargemMaxima;

  If (LMargem >= LMaxima) Then
    Result := 180
  Else
    Result := (LMargem * 180) / LMaxima;
end;

function TframeProjecaoMargem.UsaConfigDeMargem: Boolean;
Var
  intCfgSis: Integer;
begin
  Result    := False;
  intCfgSis := StrToInt(objDash.CfgSis('MARMKP'));

  Case intCfgSis Of
    1,5: Result := True;
  End;
end;

end.
