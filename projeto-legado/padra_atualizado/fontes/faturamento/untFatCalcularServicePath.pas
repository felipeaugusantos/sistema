unit untFatCalcularServicePath;

interface

uses System.SysUtils;

type
  TFatCalcularServicePath = class
  public
    class function GetPathFromAuttin(Const ADirectory : String): String;
    class procedure LoadPackagesFromAuttin(Const ADirectory : String);
  end;

implementation

{ TFatCalcularServicePath }

class function TFatCalcularServicePath.GetPathFromAuttin(Const ADirectory : String) : String;
begin
  Result := ADirectory;

  If (Pos(PathDelim + 'auttin', Result) <= 0) Then
    Exit;

  Result := Copy(Result, 0, Pos(PathDelim + 'auttin', Result));
end;

class procedure TFatCalcularServicePath.LoadPackagesFromAuttin(Const ADirectory : String);
var
  LPath: String;
begin
  If (Pos(PathDelim + 'auttin', ADirectory) <= 0) Then
    Exit;

  LPath := GetPathFromAuttin(ADirectory);

{$IFDEF LINUX}
  LoadPackage(PChar(LPath + 'bplshared.functions.so'));
  LoadPackage(PChar(LPath + 'bplfaturamento.precos.interfaces.so'));
  LoadPackage(PChar(LPath + 'bplfaturamento.precos.tipos.so'));
  LoadPackage(PChar(LPath + 'bplfaturamento.precos.calculos.so'));
{$ELSE}
  LoadPackage(PChar(LPath + 'shared.functions.bpl'));
  LoadPackage(PChar(LPath + 'faturamento.precos.interfaces.bpl'));
  LoadPackage(PChar(LPath + 'faturamento.precos.tipos.bpl'));
  LoadPackage(PChar(LPath + 'faturamento.precos.calculos.bpl'));
{$ENDIF}

end;

end.
