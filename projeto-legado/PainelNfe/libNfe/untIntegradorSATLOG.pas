unit untIntegradorSATLOG;

interface

uses Classes, SysUtils, Math, untConstantesNFe;

const
  STR_DIR_LOG_INTEGR_SAT : String = 'C:' + PATH_SEPARATOR + 'LOGSATINT' + PATH_SEPARATOR;

type
  TIntegradorSATLOG = Class
  public
    class procedure pLog(stl: TStrings; strMetodo: String);
  End;

implementation

{ TIntegradorSAT }

class procedure TIntegradorSATLOG.pLog(stl: TStrings; strMetodo: String);
begin
  If DirectoryExists(STR_DIR_LOG_INTEGR_SAT) Then
  Begin
    Try
      If Assigned(stl) Then
        stl.SaveToFile(STR_DIR_LOG_INTEGR_SAT + FormatDateTime('yyyymmdd_hhnnsszzz', nOw) + '_' + strMetodo + '_' + IntToStr(RandomRange(0, 999)) + '.XML');
    Except
      //
    End;
  End;
end;

end.
