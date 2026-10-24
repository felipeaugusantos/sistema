unit Contabilidade.Classes.LogAjcOp;

interface

uses
  System.SysUtils,
  Contabilidade.Classes.UniQueryAuditoria,
  Contabilidade.Classes.LogAjc;

type
  TLogAjcOpContext = class
  private
    class function GetSeqAju: string; static;
  public
    class procedure BeginContext(const ASeqAju: string = ''); static;
    class procedure EndContext; static;
    class property SeqAju: string read GetSeqAju;
  end;

implementation

threadvar
  GLogAjcOpSeqAju: string;
  GLogAjcOpDepth: Integer;

class function TLogAjcOpContext.GetSeqAju: string;
begin
  Result := GLogAjcOpSeqAju;
end;

class procedure TLogAjcOpContext.BeginContext(const ASeqAju: string = '');
begin
  if GLogAjcOpDepth = 0 then
  begin
    if ASeqAju <> '' then
      GLogAjcOpSeqAju := ASeqAju
    else
      GLogAjcOpSeqAju := TLogAjc.fGerarSeqAju;
  end;

  Inc(GLogAjcOpDepth);
end;

class procedure TLogAjcOpContext.EndContext;
begin
  if GLogAjcOpDepth > 0 then
    Dec(GLogAjcOpDepth);

  if GLogAjcOpDepth = 0 then
    GLogAjcOpSeqAju := '';
end;

end.
