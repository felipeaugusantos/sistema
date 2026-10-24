unit untImagemBase64;

interface

uses
{$IF Defined(LINUX)}
  FMX.Objects, FMX.Graphics, System.NetEncoding,
{$ELSE}
  Windows,
  JPEG, ExtCtrls, Graphics,
  {$IF RTLVersion >= 28}
    NetEncoding,
  {$IFEND}
{$IFEND}
  SysUtils, Classes,
  EncdDecd,
  IdHTTP, DB;

{$IF Defined(LINUX)}
  function ConverterImagemParaBase64(objImage: TImage): String;
  procedure ConverterBase64ParaImagem(const strBase64: string; var objPicture : FMX.Graphics.TBitmap);
{$ELSE}
  function ConverterImagemParaBase64(objImage: TGraphic): String;
  procedure ConverterBase64ParaImagem(const strBase64: string; var objPicture : TPicture);
{$IFEND}

implementation

{$IF Defined(LINUX)}
function ConverterImagemParaBase64(objImage: TImage): String;
Var
  objInput: TMemoryStream;
  objOutput: TStringStream;
Begin
  objInput := TMemoryStream.Create;
  Try
    objImage.Bitmap.SaveToStream(objInput);
    objInput.Position := 0;
    objOutput := TStringStream.Create('');
    Try
      EncodeStream(objInput, objOutput);
      Result := objOutput.DataString;
    Finally
      objOutput.Free;
    End;
  Finally
    objInput.Free;
  End;
End;

procedure ConverterBase64ParaImagem(const strBase64: string; var objPicture : FMX.Graphics.TBitmap);
var
  LInput: TStringStream;
  LOutput: TMemoryStream;
begin
  LInput := TStringStream.Create;
  try
    LInput.WriteString(strBase64);
    LOutput := TMemoryStream.Create;
    try
      LInput.Position := 0;
      TNetEncoding.Base64.Decode(LInput, LOutput);
      LOutput.Position := 0;
      objPicture.LoadFromStream(LOutput);
    finally
      LOutput.Free;
    end;
  finally
    LInput.Free;
  end;
end;
{$ELSE}
function ConverterImagemParaBase64(objImage: TGraphic): String;
Var
  objInput: TMemoryStream;
  objOutput: TStringStream;
Begin
  objInput := TMemoryStream.Create;
  Try
    objImage.SaveToStream(objInput);
    objInput.Position := 0;
    objOutput := TStringStream.Create('');
    Try
      EncodeStream(objInput, objOutput);
      Result := objOutput.DataString;
    Finally
      objOutput.Free;
    End;
  Finally
    objInput.Free;
  End;
End;

procedure ConverterBase64ParaImagem(const strBase64: string; var objPicture : TPicture);
var
  objInput  : TStringStream;
  objOutput : TMemoryStream;

  //picAux e imgAux foram criados para não dar memoryleak
  imgAux    : TGraphic;
  picAux    : TPicture;
begin
  objInput := TStringStream.Create(strBase64);
  objOutput := TMemoryStream.Create;

  Try
    DecodeStream(objInput, objOutput);
    objOutput.Position := 0;


    picAux := TPicture.Create;

    if Copy(strBase64, 1, 4) = '/9j/' then
      imgAux := TJPEGImage.Create
    else
      imgAux := TBitmap.Create;

    try
      imgAux.LoadFromStream(objOutput);
      picAux.Graphic := imgAux;

      objPicture.Assign(picAux);
    finally
      FreeAndNil(imgAux);
      FreeAndNil(picAux);
    end;

  Finally
    objInput.Free;
    objOutput.Free;
  End;
end;
{$IFEND}

end.
