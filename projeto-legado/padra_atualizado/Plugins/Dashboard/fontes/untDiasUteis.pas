unit untDiasUteis;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untFrameBase, FMX.Objects, FMX.Ani, FMX.Layouts, FMX.Controls.Presentation;

type
  TfraDiasUteis = class(TfraBaseFrame)
    pnlControleDiario: TRectangle;
    Image1: TImage;
    Label19: TLabel;
    lblDiasUteis: TLabel;
    Rectangle1: TRectangle;
    Layout21: TLayout;
    lblPercorridos: TLabel;
    lblRestantes: TLabel;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Line5: TLine;
    Line6: TLine;
    lblDiasGraf1: TLabel;
    barRestantes: TRectangle;
    FloatAnimation2: TFloatAnimation;
    barPercorridos: TRectangle;
    FloatAnimation1: TFloatAnimation;
    linTotalDias: TLine;
    lblDiasGraf2: TLabel;
    lblDiasGraf3: TLabel;
    lblDiasGraf4: TLabel;
    lblDiasGraf5: TLabel;
    Layout19: TLayout;
    Label20: TLabel;
    RoundRect7: TRoundRect;
    Label21: TLabel;
    RoundRect8: TRoundRect;
  public
    { Public declarations }
    procedure pCarregaDados(); override;
  end;

var
  fraDiasUteis: TfraDiasUteis;

implementation

{$R *.fmx}

{ TfraDiasUteis }

procedure TfraDiasUteis.pCarregaDados;
begin
  pIniciaVariaveis();

  If Frac(fltDiasUteis) = 0.00 Then
  Begin
    lblDiasUteis.Text := IntToStr(Trunc(fltDiasUteis));
    lblDiasUteis.Font.Size := 70;
  End
  Else If Frac(fltDiasUteis) = 0.5 Then
  Begin
    lblDiasUteis.Text := FormatFloat('0.0', fltDiasUteis);
    lblDiasUteis.Font.Size := 50;
  End
  Else
  Begin
    lblDiasUteis.Text := FormatFloat('0.00', fltDiasUteis);
    lblDiasUteis.Font.Size := 35;
  End;

  If Frac(fltDiasUteisPassados) = 0.00 Then
    lblPercorridos.Text := IntToStr(Trunc(fltDiasUteisPassados))
  Else
  Begin
    If Frac(fltDiasUteisPassados) = 0.5 Then
      lblPercorridos.Text := FormatFloat('0.0', fltDiasUteisPassados)
    Else
      lblPercorridos.Text := FormatFloat('0.00', fltDiasUteisPassados);
  End;

  If Frac(fltDiasRestantes) = 0.00 Then
    lblRestantes.Text := IntToStr(Trunc(fltDiasRestantes))
  Else
  Begin
    If Frac(fltDiasRestantes) = 0.5 Then
      lblRestantes.Text := FormatFloat('0.0', fltDiasRestantes)
    Else
      lblRestantes.Text := FormatFloat('0.00', fltDiasRestantes);
  End;

  barPercorridos.Width := (linTotalDias.Width * fltDiasUteisPassados / fltDiasUteis);
  barRestantes.Width := (linTotalDias.Width * fltDiasRestantes / fltDiasUteis);

  lblDiasGraf1.Text := '0';
  lblDiasGraf2.Text := FormatFloat('0.00', (fltDiasUteis / 4));
  lblDiasGraf3.Text := FormatFloat('0.00', (fltDiasUteis / 2));
  lblDiasGraf4.Text := FormatFloat('0.00', ((fltDiasUteis / 4) * 3));
  lblDiasGraf5.Text := FloatToStr(fltDiasUteis);
end;

end.
