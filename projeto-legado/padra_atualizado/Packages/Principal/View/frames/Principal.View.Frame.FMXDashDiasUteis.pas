unit Principal.View.Frame.FMXDashDiasUteis;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, Principal.View.Interfaces,
  DateUtils, FMX.Layouts, FMX.Ani;

type
  TframeDiasUteis = class(TFrame)
    lblDiasUteis: TLabel;
    arcPercorridos: TPie;
    arcRestantes: TPie;
    layDiasUteis: TLayout;
    cirBranco: TCircle;
    aniAguarde: TAniIndicator;
    lblAguarde: TLabel;
    procedure arcPercorridos2MouseEnter(Sender: TObject);
    procedure arcRestantes2MouseEnter(Sender: TObject);
    procedure arcRestantes2MouseLeave(Sender: TObject);
  private
    { Private declarations }
    fltDiasUteis,
    fltDiasUteisPassados,
    fltDiasRestantes: Double;

    procedure pCalculaDiasUteis(Var fltDiasUteis, fltDiasUteisPassados, fltDiasRestantes: Double);
    procedure AmpliarPie(Sender: TPie);
    procedure ReduzirPie(Sender: TPie);
    procedure Aguarde(Ligar: Boolean);
    function fEhDiaUtil(dteData: TDate): Boolean;
  public
    { Public declarations }
    objDash          : IDashboard;
    dtaMesSelecionado: TDateTime;
    procedure AtualizaControleDiario(dtaSelecionado:TDateTime);
  end;

implementation

{$R *.fmx}

{ TframeDiasUteis }

procedure TframeDiasUteis.Aguarde(Ligar: Boolean);
begin
  layDiasUteis.Visible := Not Ligar;
  lblDiasUteis.Visible := Not Ligar;

  aniAguarde.Visible   := Ligar;
  aniAguarde.Enabled   := Ligar;

  Application.ProcessMessages;
end;

procedure TframeDiasUteis.AmpliarPie(Sender: TPie);
begin
  Sender.Size.Height := 71;
  Sender.Size.Width  := 71;
  Sender.Position.X  := 2;
  Sender.Position.Y  := 2;
  layDiasUteis.Repaint;
end;

procedure TframeDiasUteis.arcPercorridos2MouseEnter(Sender: TObject);
begin
  If Frac(fltDiasUteisPassados) = 0.00 Then
    lblDiasUteis.Text := IntToStr(Trunc(fltDiasUteisPassados))
  Else
  Begin
    If Frac(fltDiasUteisPassados) = 0.5 Then
      lblDiasUteis.Text := FormatFloat('0.0', fltDiasUteisPassados)
    Else
      lblDiasUteis.Text := FormatFloat('0.00', fltDiasUteisPassados);
  End;

  lblDiasUteis.Text := lblDiasUteis.Text + ' Dias Percorridos';

  AmpliarPie(TPie(Sender));
end;

procedure TframeDiasUteis.arcRestantes2MouseEnter(Sender: TObject);
begin
  If Frac(fltDiasRestantes) = 0.00 Then
    lblDiasUteis.Text := IntToStr(Trunc(fltDiasRestantes))
  Else
  Begin
    If Frac(fltDiasRestantes) = 0.5 Then
      lblDiasUteis.Text := FormatFloat('0.0', fltDiasRestantes)
    Else
      lblDiasUteis.Text := FormatFloat('0.00', fltDiasRestantes);
  End;

  lblDiasUteis.Text := lblDiasUteis.Text + ' Dias Restantes';

  AmpliarPie(TPie(Sender));
end;

procedure TframeDiasUteis.arcRestantes2MouseLeave(Sender: TObject);
begin
  If Frac(fltDiasUteis) = 0.00 Then
  Begin
    lblDiasUteis.Text := IntToStr(Trunc(fltDiasUteis));
  End
  Else If Frac(fltDiasUteis) = 0.5 Then
  Begin
    lblDiasUteis.Text := FormatFloat('0.0', fltDiasUteis);
  End
  Else
  Begin
    lblDiasUteis.Text := FormatFloat('0.00', fltDiasUteis);
  End;

  lblDiasUteis.Text := lblDiasUteis.Text + ' Dias Úteis';

  ReduzirPie(TPie(Sender));
end;

procedure TframeDiasUteis.AtualizaControleDiario(dtaSelecionado:TDateTime);
begin
  dtaMesSelecionado := dtaSelecionado;

  Aguarde(True);

  pCalculaDiasUteis(fltDiasUteis, fltDiasUteisPassados, fltDiasRestantes);

  If Frac(fltDiasUteis) = 0.00 Then
  Begin
    lblDiasUteis.Text := IntToStr(Trunc(fltDiasUteis));
  End
  Else If Frac(fltDiasUteis) = 0.5 Then
  Begin
    lblDiasUteis.Text := FormatFloat('0.0', fltDiasUteis);
  End
  Else
  Begin
    lblDiasUteis.Text := FormatFloat('0.00', fltDiasUteis);
  End;

  lblDiasUteis.Text := lblDiasUteis.Text + ' Dias Úteis';

  arcPercorridos.EndAngle := (360 * fltDiasUteisPassados) / fltDiasUteis;
  arcRestantes.EndAngle   := ((360 * fltDiasRestantes) / fltDiasUteis) * -1;

  Aguarde(False);
end;

function TframeDiasUteis.fEhDiaUtil(dteData: TDate): Boolean;
begin
  Result := True;

  If (DayOfWeek(dteData) in [1, 7]) Then
    Result := False;

  If objDash.EhFeriado(dteData) Then
    Result := False;
end;

procedure TframeDiasUteis.pCalculaDiasUteis(var fltDiasUteis,
  fltDiasUteisPassados, fltDiasRestantes: Double);
var
  dteData, dteDtaFin, dteHoje: TDate;
  fltValorSabado, fltValorDomingo: Double;
  blnUsarUltimoDiaFechamento: Boolean;
  intUltimoDiaFechamento: Integer;
  intDiaIni, intDiaFim: Integer;
begin
  blnUsarUltimoDiaFechamento := (objDash.CfgSis('USAUDF') = 'S');
  intUltimoDiaFechamento := objDash.CfgSis('UDFDAS');

  Try
    If blnUsarUltimoDiaFechamento then
    Begin
      intDiaIni := intUltimoDiaFechamento + 1;
      intDiaFim := intUltimoDiaFechamento;

      dteData   := EncodeDate(YearOf(dtaMesSelecionado), MonthOf(dtaMesSelecionado), intDiaIni);
      dteData   := IncMonth(dteData, -1);
      dteDtaFin := EncodeDate(YearOf(dtaMesSelecionado), MonthOf(dtaMesSelecionado), intDiaFim);
    End
    Else
    Begin
      dteData   := dtaMesSelecionado;
      dteDtaFin := EncodeDate(YearOf(dtaMesSelecionado), MonthOf(dtaMesSelecionado), DaysInMonth(dtaMesSelecionado));
    End;
  Except
    dteData   := dtaMesSelecionado;
    dteDtaFin := EncodeDate(YearOf(dtaMesSelecionado), MonthOf(dtaMesSelecionado), DaysInMonth(dtaMesSelecionado));
  End;

  dteHoje   := Date();

  fltDiasUteis := 0;
  fltDiasUteisPassados := 0;

  fltValorSabado := objDash.CfgSis('SABUTI');
  fltValorDomingo:= objDash.CfgSis('DOMUTI');

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

procedure TframeDiasUteis.ReduzirPie(Sender: TPie);
begin
  Sender.Size.Height := 65;
  Sender.Size.Width  := 65;
  Sender.Position.X  := 5;
  Sender.Position.Y  := 5;
  layDiasUteis.Repaint;
end;

end.
