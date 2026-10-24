(*
   CONSIDERANDO fNOW(), SE FOR DAS 00:01 ATE´ 12:00, TRAZER 'MANHA' COMO SUGESTAO.
   CONSIDERANDO fNOW(), SE FOR DAS 12:01 ATE´ 18:00, TRAZER 'TARDE' COMO SUGESTAO.
   CONSIDERANDO fNOW(), SE FOR DAS 18:01 ATE´ 00:00, TRAZER 'NOITE' COMO SUGESTAO.
*)

unit untTurnoEntrega;

interface

uses
  StdCtrls, ComboBoxFocus, Classes, SysUtils,
  DateUtils, Variants, Windows;

Type
  TTurnoEntrega = Class(TComponent)
  private
    function fInicioDaManha: TDateTime;
    function fFinalDaManha: TDateTime;
    function fInicioDaTarde: TDateTime;
    function fFinalDaTarde: TDateTime;
    function fInicioDaNoite: TDateTime;
    function fFinalDaNoite: TDateTime;
    function fGetTurnoInterna(varTipVar: TVarType): Variant;
  public
    function fExibeTurno(strOpcDoc: String; intIdxEnt: Integer): Boolean;
    procedure pMostraTurno(blnMostra: Boolean; lblTurno: TLabel; cmbTurno: TComboBoxFocus; blnAtribuiValor: Boolean = False);
    function fTurnoStrToInt(strTurno: String): Integer;
    function fTurnoIntToStr(intTurno: Integer): String;
    function fGetTurno(strDummy: String  = ''): String; overload;
    function fGetTurno(intDummy: Integer = 0): Integer; overload;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Reintroduce;
  End;

implementation

uses untConstantes, untFuncoesSimples;

{ TTurnoEntrega }

constructor TTurnoEntrega.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

destructor TTurnoEntrega.Destroy;
begin
  //
end;

function TTurnoEntrega.fExibeTurno(strOpcDoc: String; intIdxEnt: Integer): Boolean;
begin
  Result := (Pos(strOpcDoc,'OR_PD_VN_') > 0) And (fCfgSis('EXITUR', varBoolean)) And (intIdxEnt = IDX_ENTREGA);
end;

function TTurnoEntrega.fInicioDaManha: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(0, 1, 0, 0);
end;

function TTurnoEntrega.fFinalDaManha: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(12, 0, 0, 0);
end;

function TTurnoEntrega.fInicioDaTarde: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(12, 1, 0, 0);
end;

function TTurnoEntrega.fFinalDaTarde: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(18, 0, 0, 0);
end;

function TTurnoEntrega.fInicioDaNoite: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(18, 1, 0, 0);
end;

function TTurnoEntrega.fFinalDaNoite: TDateTime;
begin
  Result := EncodeDate(YearOf(VS_Date), MonthOf(VS_Date), DayOf(VS_Date)) +
            EncodeTime(0, 0, 0, 0);
end;

function TTurnoEntrega.fGetTurno(strDummy: String  = ''): String;
begin
  Result := fGetTurnoInterna(varString);
end;

function TTurnoEntrega.fGetTurno(intDummy: Integer  = 0): Integer;
begin
  Result := fGetTurnoInterna(varInteger);
end;

function TTurnoEntrega.fGetTurnoInterna(varTipVar: TVarType): Variant;
begin
  If (fNow() >= fInicioDaManha) And
     (fNow() <= fFinalDaManha ) Then
  Begin
    case varTipVar Of
      varInteger: Result := fTurnoStrToInt('Manhã');
      varString: Result := fTurnoIntToStr(fTurnoStrToInt('Manhã'));
    End;
  End

  Else If (fNow() >= fInicioDaTarde) And
          (fNow() <= fFinalDaTarde ) Then
  Begin
    case varTipVar Of
      varInteger: Result := fTurnoStrToInt('Tarde');
      varString: Result := fTurnoIntToStr(fTurnoStrToInt('Tarde'));
    End;
  End

  Else If (fNow() >= fInicioDaNoite) And
          (fNow() <= fFinalDaNoite ) Then
  Begin
    case varTipVar Of
      varInteger: Result := fTurnoStrToInt('Noite');
      varString: Result := fTurnoIntToStr(fTurnoStrToInt('Noite'));
    End;
  End
  Else
  Begin
    case varTipVar Of
      varInteger: Result := -1;
      varString: Result := '';
    End;
  End;  
end;

procedure TTurnoEntrega.pMostraTurno(blnMostra: Boolean; lblTurno: TLabel; cmbTurno: TComboBoxFocus; blnAtribuiValor: Boolean = False);
begin
  lblTurno.Visible := blnMostra;
  cmbTurno.Visible := blnMostra;

  If (blnMostra) And (blnAtribuiValor) Then
    cmbTurno.ItemIndex := fGetTurnoInterna(varInteger);
end;

function TTurnoEntrega.fTurnoStrToInt(strTurno: String): Integer;
begin
  Result := -1;
  If ( SysUtils.AnsiSameText(strTurno, 'Manhã')) Then
    Result := 0
  Else If (SysUtils.AnsiSameText(strTurno, 'Tarde')) Then
    Result := 1
  Else If (SysUtils.AnsiSameText(strTurno, 'Noite')) Then
    Result := 2;
end;

function TTurnoEntrega.fTurnoIntToStr(intTurno: Integer): String;
begin
  Result := '';
  Case intTurno Of
    0: Result := 'Manhã';
    1: Result := 'Tarde';
    2: Result := 'Noite';
  End;
end;

end.
