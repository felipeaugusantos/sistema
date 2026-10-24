unit Principal.View.Frame.FMXDashTopClientesLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects, FMX.Effects, FMX.Controls.Presentation,
  StrUtils;

type
  TframeTopClientesLinha = class(TFrame)
    layLinha: TLayout;
    recDescricao: TRectangle;
    efeSombra1: TShadowEffect;
    lblDescricao: TLabel;
    recVenda: TRectangle;
    recSombra2: TShadowEffect;
    lblValorVenda: TLabel;
    recMargem: TRectangle;
    efeSombra3: TShadowEffect;
    lblValorMargem: TLabel;
    lblSeparador1: TLabel;
    linSeparador1: TLine;
    lblSeparador2: TLabel;
    linSeparador2A: TLine;
    linSeparador2B: TLine;
    lblSeparador3: TLabel;
    linSeparador3: TLine;
    procedure FramePaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MostrarBarraDeProgresso(Componente: TLabel; Valor: String);
  end;

Const
  {**************}
  {* Modo Claro *}
  {**************}
  FundoCinzaClaro  = TAlphaColor($FFE8E8E8);
  FundoQuadroBranco= TAlphaColorRec.White;
  FonteEscura      = TAlphaColorRec.Black;

  {***************}
  {* Modo Escuro *}
  {***************}
  FundoCinzaEscuro = TAlphaColor($FF384147);
  FundoQuadroCinza = TAlphaColor($FF414A4F);
  FonteClara       = TAlphaColor($FFE3E4E6);

implementation

{$R *.fmx}

procedure TframeTopClientesLinha.FramePaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
Var
  LCont: Integer;
begin
  For LCont := 0 to Self.ComponentCount - 1 do
  Begin
    If (Self.Components[LCont].ClassNameIs('TRectangle')) Then
      If (TRectangle(Self.Components[LCont]).Fill.Color = TAlphaColorRec.White) Then
        TRectangle(Self.Components[LCont]).Fill.Color := FundoQuadroBranco;

    If (Self.Components[LCont].ClassNameIs('TLine')) Then
        TLine(Self.Components[LCont]).Stroke.Dash := TStrokeDash.Dash;
  End;
end;

procedure TframeTopClientesLinha.MostrarBarraDeProgresso(Componente: TLabel;
  Valor: String);
Var
  lblPorcentagem    : TLabel;
  recPorcentagem    : TRectangle;
  strNomeComponente : String;
  fltValor          : Double;
  LTamanhoPreenchimento : Single;
begin
  strNomeComponente := '';

  If Valor.IsEmpty Then
    Componente.Opacity := 0

  Else
  Begin
    Componente.Opacity := 1;

    strNomeComponente   := Copy(Componente.Name, 12, Length(Componente.Name) - 11);

    lblPorcentagem      := TLabel(FindComponent('lblPorcentagem' + strNomeComponente));
    recPorcentagem      := TRectangle(FindComponent('recPorcentagem' + strNomeComponente));

    LTamanhoPreenchimento := lblPorcentagem.Width + lblPorcentagem.Margins.Right - 2;

    fltValor            := StrToFloat(ReplaceStr(Valor, '%', ''));

    If (fltValor >= 100) Then
      recPorcentagem.Width := LTamanhoPreenchimento
    Else
      recPorcentagem.Width := (fltValor * LTamanhoPreenchimento) / 100;

    lblPorcentagem.Text := FormatFloat('#0', fltValor) + '%';
  End;
end;

end.
