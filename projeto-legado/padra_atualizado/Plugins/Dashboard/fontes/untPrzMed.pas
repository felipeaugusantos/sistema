unit untPrzMed;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  untFrameBase, FMX.Layouts, FMX.Objects, FMX.Ani, FMX.Controls.Presentation;

type
  TfraPrzMed = class(TfraBaseFrame)
    pnlPrzMed: TRectangle;
    Label6: TLabel;
    Layout21: TLayout;
    lblMedVendas: TLabel;
    lblMaxPermitido: TLabel;
    barMaxPermitido: TRectangle;
    FloatAnimation2: TFloatAnimation;
    barMedVen: TRectangle;
    FloatAnimation1: TFloatAnimation;
    Layout19: TLayout;
    Label20: TLabel;
    RoundRect7: TRoundRect;
    Label21: TLabel;
    RoundRect8: TRoundRect;
  private
    { Private declarations }
    function fGetPrzMedVen: Integer;
    function fGetPrzMaxVen(strPrzMedVen : Integer) : Integer;
  public
    { Public declarations }
    procedure pCarregaDados(); override;
  end;

var
  fraPrzMed: TfraPrzMed;

implementation

{$R *.fmx}

{ TfraPrzMed }

function TfraPrzMed.fGetPrzMaxVen(strPrzMedVen: Integer): Integer;
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT PRZ_MEDMAX ';
  strSQL := strSQL + '  FROM PRZMED     ';
  strSQL := strSQL + ' WHERE (' + IntToStr(strPrzMedVen) + ' >= PRZ_MEDINI) ';
  strSQL := strSQL + '   AND (' + IntToStr(strPrzMedVen) + ' <= PRZ_MEDFIN)';

  Result := 0;

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  If qryAux.FieldValue('PRZ_MEDMAX') <> null Then
    Result := qryAux.FieldValue('PRZ_MEDMAX');
end;

function TfraPrzMed.fGetPrzMedVen: Integer;
  var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT OPE_PRZMMA   ';
  strSQL := strSQL + '  FROM CADOPE       ';
  strSQL := strSQL + ' WHERE OPE_CODOPE = ' + QuotedStr(strLogOpe);

  Result := 0;

  qryAux.Close;
  qryAux.SQL.Text := strSQL;
  qryAux.Open;

  If qryAux.FieldValue('OPE_PRZMMA') <> null Then
    Result := qryAux.FieldValue('OPE_PRZMMA');
end;

procedure TfraPrzMed.pCarregaDados;
  var
    intPrzMedVen: Integer;
    intPrzMaxVen: Integer;
    intTotalPrzM: Integer;
begin
  inherited;

  intPrzMedVen          := fGetPrzMedVen;
  intPrzMaxVen          := fGetPrzMaxVen(intPrzMedVen);

  lblMedVendas.Text     := IntToStr(intPrzMedVen);
  lblMaxPermitido.Text  := IntToStr(intPrzMaxVen);

  intTotalPrzM          := intPrzMedVen + intPrzMaxVen;
  
  barMedVen.Width       := Round((100 / intTotalPrzM) * intPrzMedVen);
  barMaxPermitido.Width := Round((100 / intTotalPrzM) * intPrzMaxVen);
end;

end.
