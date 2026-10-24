unit ArquivosBanco.Funcoes;

interface

uses
  Vcl.Graphics, System.Classes, System.SysUtils, EncdDecd, Winapi.Windows,
  ShellAPI, untFuncoesSimples, System.IOUtils, System.NetEncoding;

type
  TArquivoBancoFuncoes = class
  public
    class function fGetSystemIcon(AstrFileName: String): TIcon;
    class function fBase64Codifica(AstrArquivo: String): String;
    class function fBase64Decodifica(AstrBase64: String): TMemoryStream;
    class procedure pAbrirArquivo(Stream: TStream; strNomeArquivo: String);
  end;

implementation

{ TArquivoBancoFuncoes }

class function TArquivoBancoFuncoes.fBase64Codifica(
  AstrArquivo: String): String;
var
  LEntrada:  TMemoryStream;
  LSaida: TStringStream;
begin
  LEntrada := TMemoryStream.Create();
  LSaida   := TStringStream.Create(EmptyStr);

  LEntrada.LoadFromFile(AstrArquivo);
  LEntrada.Position := 0;
  Try
    EncdDecd.EncodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

class function TArquivoBancoFuncoes.fBase64Decodifica(
  AstrBase64: String): TMemoryStream;
var
  LEntrada:  TStringStream;
begin
  LEntrada := TStringStream.Create(AstrBase64);
  Result   := TMemoryStream.Create();
  Try
    EncdDecd.DecodeStream(LEntrada, Result);
    Result.Position := 0;
  Finally
    FreeAndNil(LEntrada);
  End;
end;

class function TArquivoBancoFuncoes.fGetSystemIcon(AstrFileName: String): TIcon;
var
  LstrExtension: string;
  LFileInfo: TSHFileInfo;
begin
  Result := Nil;

  LstrExtension := ExtractFileExt( AstrFileName );
  if SHGetFileInfo(PChar( '*' + LstrExtension ),
                   FILE_ATTRIBUTE_NORMAL,
                   LFileInfo,
                   SizeOf( LFileInfo ),
                   SHGFI_ICON or SHGFI_SMALLICON or
                    SHGFI_SYSICONINDEX or SHGFI_USEFILEATTRIBUTES
                    ) <> 0 then
  Begin
    Result := TIcon.Create;
    Result.Handle := LFileInfo.hIcon;
  End;
end;

class procedure TArquivoBancoFuncoes.pAbrirArquivo(Stream: TStream; strNomeArquivo: String);
var
  strArquivo: String;
  mmStream: TMemoryStream;
begin
  strArquivo := TPath.GetTempPath + strNomeArquivo;
  mmStream := TMemoryStream.Create;
  Try
    mmStream.LoadFromStream(Stream);
    mmStream.SaveToFile(strArquivo)
  Finally
    FreeAndNil(mmStream);
  End;

  pExecArquivo(strArquivo, 0);
end;

end.
