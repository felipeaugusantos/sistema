unit citelSSL;

interface

uses
  System.Classes, System.SysUtils, Windows, Vcl.Forms;

type
  TGetTwoStrings = procedure(OutStr1, OutStr2: TStream); stdcall;

procedure geraChaves(var PrivateKey: String; var PublicKey: String);

implementation

procedure geraChaves(var PrivateKey: String; var PublicKey: String);
var
  Hdll: THandle;
  geraChavesDll: TGetTwoStrings;
  strmPrivateKey, strmPublicKey: TStringStream;
begin
  Hdll := LoadLibrary(pWideChar(ExtractFilePath(Application.ExeName) + 'citelSSL.dll'));

  if Hdll <> 0 then
  begin
    try
      @geraChavesDll := GetProcAddress(Hdll, 'geraChaves');

      if Assigned(geraChavesDll) then
      begin
        strmPrivateKey := TStringStream.Create();
        strmPublicKey := TStringStream.Create();

        try
          geraChavesDll(strmPrivateKey, strmPublicKey);

          PrivateKey := strmPrivateKey.DataString;
          PublicKey := strmPublicKey.DataString;
        finally
          strmPrivateKey.Free;
          strmPublicKey.Free;
        end;
      end;
    finally
      FreeLibrary(Hdll);
    end;
  end
  else
  begin
    raise Exception.Create('Não foi encontrada a dll citelSSL.dll');
  end;
end;

end.
