unit Principal.View.Frame.FMXDashTotalVendedoresLinha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.ListBox, FMX.Objects, FMX.Effects, FMX.Controls.Presentation,
  StrUtils;

type
  TframeTotalVendedoresLinha = class(TFrame)
    layLinha: TLayout;
    recDescricao: TRectangle;
    efeSombra1: TShadowEffect;
    lblDescricao: TLabel;
    lblSeparador2: TLabel;
    linSeparador2: TLine;
    lblValor: TLabel;
    Line8: TLine;
    recOrcamentosAbertos: TRectangle;
    somOrcamentosAbertos: TShadowEffect;
    lblValorTotalVenda: TLabel;
    Label1: TLabel;
    Line1: TLine;
    Rectangle1: TRectangle;
    ShadowEffect1: TShadowEffect;
    lblValorMeta: TLabel;
    Label3: TLabel;
    Line2: TLine;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    lblValorProjetado: TLabel;
    Label5: TLabel;
    Line3: TLine;
    Rectangle3: TRectangle;
    ShadowEffect3: TShadowEffect;
    lblValorMetaPorcentagem: TLabel;
    Label7: TLabel;
    Line4: TLine;
    Rectangle4: TRectangle;
    ShadowEffect4: TShadowEffect;
    lblValorRealizadoPorcentagem: TLabel;
    Label9: TLabel;
    Line5: TLine;
    Rectangle5: TRectangle;
    ShadowEffect5: TShadowEffect;
    lblValorClientesAtendidos: TLabel;
    Label11: TLabel;
    Line6: TLine;
    Rectangle6: TRectangle;
    ShadowEffect6: TShadowEffect;
    lblValorNumeroVendas: TLabel;
    Label13: TLabel;
    Line7: TLine;
    Rectangle7: TRectangle;
    ShadowEffect7: TShadowEffect;
    lblValorTicketMedio: TLabel;
    Label15: TLabel;
    Line9: TLine;
    Rectangle8: TRectangle;
    ShadowEffect8: TShadowEffect;
    lblValorOrcamentosAbertos: TLabel;
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

procedure TframeTotalVendedoresLinha.FramePaint(Sender: TObject; Canvas: TCanvas;
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

procedure TframeTotalVendedoresLinha.MostrarBarraDeProgresso(Componente: TLabel;
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
