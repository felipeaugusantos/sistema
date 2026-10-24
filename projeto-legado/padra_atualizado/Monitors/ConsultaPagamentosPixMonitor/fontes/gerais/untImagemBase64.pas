unit untImagemBase64;

interface

uses SysUtils,  ExtCtrls, Classes,
  Soap.EncdDecd, JPEG, System.NetEncoding, Winapi.Windows,
  IdHTTP, Data.DB, PNGImage, Vcl.Graphics, frxClass, Forms,
  axCtrls, untTypesSistema;

  function fBase64FromImg(objImage: TGraphic): String;

  procedure pImagemFromBase64(const strBase64: string; var objPicture : TPicture); Overload;
  procedure pImagemFromBase64(const strBase64: string; var objPicture : TfrxPictureView); Overload;
  procedure pImagemProdutoFromBase64(const strBase64: string; var objPicture : TfrxPictureView; blnExecutaImagensLargas: Boolean);

  function fOtimizaImagem(var strBase64 : String) : Boolean;
  function fStreamFromBase64(const strBase64: string; var objOutput: TBytesStream): Boolean;
  function fGetImageByUrl(URL: string) :TJPEGImage;
  function fBase64FromFile(strCaminho : String) : String;
  function fBase64FromJPEG(objImage: TJPEGImage): String;
  function fJPEGFromBase64(const strBase64: string): TJPEGImage;
  function fRedimensionarImagem(const intLargura, intAltura: Integer; strFileName: String; blnJpeg: Boolean; var imagem: TGraphic): TRetornoImagem;
  function fRetornaThumbImagemFromBase64(const strBase64: string; blnExecutaImagensLargas: Boolean) : TPicture;
  procedure pFileImagemFromBase64(const strBase64: string; var strCaminhoImagem: string);

implementation

uses
  untFuncoesSimples;

function fStreamFromBase64(const strBase64: string; var objOutput: TBytesStream): Boolean;
var
  objInput: TStringStream;
begin
  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  Try
    Try
      Soap.EncdDecd.DecodeStream(objInput, objOutput);
      objOutput.Position := 0;
      Result := True;
    Except
      Result := False;
    End;
  Finally
    objInput.Free;
  End;

end;

function fBase64FromImg(objImage: TGraphic): String;
Var
  objInput: TBytesStream;
  objOutput: TStringStream;
Begin
  objInput := TBytesStream.Create;
  Try
    objImage.SaveToStream(objInput);
    objInput.Position := 0;
    objOutput := TStringStream.Create(EmptyStr, TEncoding.ASCII);
    Try
      Soap.EncdDecd.EncodeStream(objInput, objOutput);
      Result := objOutput.DataString;
    Finally
      objOutput.Free;
    End;
  Finally
    objInput.Free;
  End;
End;

procedure pImagemFromBase64(const strBase64: string; var objPicture : TPicture); Overload;
var
  objInput  : TStringStream;
  objOutput : TBytesStream;

  //picAux e imgAux foram criados para não dar memoryleak
  imgAux    : TGraphic;
  picAux    : TPicture;
begin
  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  objOutput := TBytesStream.Create;

  Try
    Soap.EncdDecd.DecodeStream(objInput, objOutput);
    objOutput.Position := 0;


    picAux := TPicture.Create;

    if Copy(strBase64, 1, 4) = '/9j/' then
      imgAux := TJPEGImage.Create
    else
      imgAux := TPngImage.Create;

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

procedure pImagemFromBase64(const strBase64: string; var objPicture : TfrxPictureView); Overload;
var
  objInput  : TStringStream;
  objOutput : TBytesStream;

  //picAux e imgAux foram criados para não dar memoryleak
  imgAux    : TGraphic;
  picAux    : TPicture;
begin
  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  objOutput := TBytesStream.Create;

  Try
    Soap.EncdDecd.DecodeStream(objInput, objOutput);
    objOutput.Position := 0;


    picAux := TPicture.Create;

    if Copy(strBase64, 1, 4) = '/9j/' then
      imgAux := TJPEGImage.Create
    else
      imgAux := TPngImage.Create;

    try
      imgAux.LoadFromStream(objOutput);
      picAux.Graphic := imgAux;

      objPicture.Picture.Assign(picAux);
    finally
      FreeAndNil(imgAux);
      FreeAndNil(picAux);
    end;

  Finally
    objInput.Free;
    objOutput.Free;
  End;
end;

function fRedimensionarImagem(const intLargura, intAltura: Integer; strFileName: String;
  blnJpeg: Boolean; var imagem: TGraphic): TRetornoImagem; overload;
var
  picAux: TPicture;
  bmpImage: TBitmap;
  thmImage: TPNGImage;
  ARect: TRect;
begin
  Application.ProcessMessages;

  Result := riNulo;

  If fEmptyStr(strFileName) Then
    Exit;

  picAux   := TPicture.Create;
  bmpImage := TBitmap.Create;
  thmImage := TPNGImage.Create;

  Try
    picAux.LoadFromFile(strFileName);
    Try
      If picAux.Graphic is TBitmap Then
        bmpImage.PixelFormat := TBitmap(picAux.Graphic).PixelFormat
      Else
        bmpImage.PixelFormat := pf32bit;

      bmpImage.Assign(picAux.Graphic);
      bmpImage.SetSize(intLargura, intAltura);

      ARect := Rect(0, 0, intLargura, intAltura);

      bmpImage.Canvas.StretchDraw(ARect, picAux.Graphic);
      thmImage.Assign(bmpImage);
      imagem.Assign(thmImage);

      Result := riOK;
    Except
      On E: Exception Do
      Begin
        Result := riErro;
        raise;
      End;
    End;

  Finally
    If Assigned(bmpImage) Then
      FreeAndNil(bmpImage);
    If Assigned(picAux) Then
      FreeAndNil(picAux);
    FreeAndNil(thmImage);
  End;
end;

function fRetornaThumbImagemFromBase64(const strBase64: string; blnExecutaImagensLargas: Boolean) : TPicture;
var
  objFileStream: TFileStream;
  imgAux : TGraphic;
  picAux : TPicture;
  intTam: Integer;

  bytes: TBytes;
  strExtensao: String;
  tamKb: Double;

  strArquivoTmp: String;
  intTamThumb: Integer;
  blnJpeg: Boolean;
  tamKbImgMax: Integer;
Begin
  intTam := Length(strBase64) * SizeOf(Char);

  picAux := TPicture.Create;
  Try

    If (Not blnExecutaImagensLargas) and (intTam > 640000000) Then
    Begin
      Raise Exception.Create('Tamanho da imagem é muito grande para ser utilizada neste processo. ');
      Exit;
    End;

    Try
      tamKbImgMax := fCfgSis('TAMIMG');
      tamKbImgMax := IIF(tamKbImgMax >= 0, tamKbImgMax, 1024);

      If Copy(strBase64, 1, 4) = '/9j/' Then
      Begin
        strExtensao := '.jpeg';
      End
      Else
      If (Pos('iVBORw0KGg', strBase64) > 0) Then
      Begin
        strExtensao := '.png';
      End
      Else
      Begin
        Raise Exception.Create('Extensão não permitida neste processo. ');
        Exit;
      End;

      bytes:= TNetEncoding.Base64.DecodeStringToBytes(strBase64);
      tamKb := Round( Length(Bytes) / (1024));

      strArquivoTmp := IncludeTrailingPathDelimiter( ExtractFilePath(Application.ExeName))  + 'ImgTemp' + strExtensao;
      If FileExists(strArquivoTmp) Then
        DeleteFile(PChar(strArquivoTmp));

      objFileStream := TFileStream.Create(strArquivoTmp, fmCreate);
      Try
        If ((bytes <> nil) and (tamKb <= tamKbImgMax)) Then
        Begin
          objFileStream.Write(bytes[0], Length(Bytes));
        End;

      Finally
        FreeAndNil(objFileStream);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Erro ao ler a imagem: ' + E.Message);
        Exit;
      End;
    End;

    Try
      intTamThumb :=  fCfgSis('TAMTHU', varInteger);

      If FileExists(strArquivoTmp) Then
      Begin
        blnJpeg := (Copy(strBase64, 1, 4) = '/9j/');
        imgAux := TPNGImage.Create;

        If fRedimensionarImagem(intTamThumb, intTamThumb, strArquivoTmp, blnJpeg, imgAux) = riOK Then
        Begin
          If Assigned(imgAux) Then
            picAux.Graphic := imgAux;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('Erro ao carregar a imagem: ' + E.Message);
      End;
    End;

  Finally
    If Assigned(imgAux) Then
      FreeAndNil(imgAux);

    Result := picAux;
  End;
end;

procedure pImagemProdutoFromBase64(const strBase64: string; var objPicture : TfrxPictureView; blnExecutaImagensLargas: Boolean); Overload;
var
  objOutput : TBytesStream;
  imgAux : TGraphic;
  picAux : TPicture;
  intTam: Integer;
begin
  intTam := Length(strBase64) * SizeOf(Char);

  If (Not blnExecutaImagensLargas) and (intTam > 640000) Then
    Exit;

  If Copy(strBase64, 1, 4) = '/9j/' Then
    imgAux := TJPEGImage.Create
  Else
    imgAux := TPngImage.Create;

  objOutput := TBytesStream.Create;
  picAux := TPicture.Create;
  Try
    Try
      If Not fStreamFromBase64(strBase64, objOutput) Then
      Begin
        Raise Exception.Create('Erro ao ler a imagem!');
        Exit;
      End;

      imgAux.LoadFromStream(objOutput);
      picAux.Assign(imgAux);
      If Assigned(picAux) and Assigned(objPicture) Then
        objPicture.Picture := picAux;
    Except
      Raise Exception.Create('Erro ao converter a imagem!');
    End;
  Finally
    FreeAndNil(imgAux);
    FreeAndNil(picAux);
    FreeAndNil(objOutput);
  End;
end;

function fBase64FromFile(strCaminho : String) : String;
var
  imgGraphic : TGraphic;
begin
  Result := '';

  try
    try
      If UpperCase(ExtractFileExt(strCaminho)) = '.PNG' Then
        imgGraphic := TPngImage.Create
      Else If UpperCase(ExtractFileExt(strCaminho)) = '.BMP' Then
        imgGraphic := TBitmap.Create
      Else
        imgGraphic := TJPEGImage.Create;

      imgGraphic.LoadFromFile(strCaminho);

      Result := fBase64FromImg(imgGraphic)
    except
      Raise exception.Create('Arquivo Inválido!');
    end;
  finally
    FreeAndNil(imgGraphic);
  end;
end;


//var
//  strStream: String;
//  memStream: TMemoryStream;
//  jpegimg: TJPEGImage;
//  idhttp1: TIdHTTP;
//
//  idhttp2: TIdHTTP;
//  memStream2: TMemoryStream;
//begin
//  try
//    idhttp1 := TIdHTTP.Create(nil);
//    strStream := idhttp1.Get (url);
//  except
//    Exit;
//  end;
//
//  memStream := TMemoryStream.Create;
//  jpegimg   := TJPEGImage.Create;
//
//  try
//    memStream.Write(strStream[1], Length(strStream));
//    memStream.Position := 0;
//    jpegimg.LoadFromStream(memStream);
//  finally
//    memStream.Free;
//    jpegimg.Free;
//  end;
//end;

//function fGetImageByUrl(URL: string) :TJPEGImage;
//var
//  strStream: String;
//  memStream: TMemoryStream;
//  jpegimg: TJPEGImage;
//  vIdHTTP : TIdHTTP;
//begin
//  try
//    try
//      memStream := TMemoryStream.Create;
//      jpegimg   := TJPEGImage.Create;
//      vIdHTTP := TIdHTTP.Create(nil);
//
////      vIdHTTP.Get(URL, memStream);
////
////      jpegimg.LoadFromStream(memStream);
//
//      vIdHTTP.Get('https://vignette2.wikia.nocookie.net/finalfantasy/images/9/9f/Type_0_Ace.jpg', memStream);
//
//      jpegimg.LoadFromStream(memStream);
//
//      Result := jpegimg;
//
//    except
//      Exit;
//    end;
//  finally
//    memStream.Free;
//    jpegimg.Free;
//  end;
//end;

function fGetImageByUrl(URL: string): TJPEGImage;
var
  MS : TMemoryStream;
  Gif: TJPEGImage;
  IdHTTP1 :TIdHTTP;
begin
  MS := TMemoryStream.Create;
  try
    IdHTTP1 := TIdHttp.Create(nil);
    Gif := TJPEGImage.Create;

    IdHTTP1.Get(URL, MS);

    MS.Position := 0;
    Gif.LoadFromStream(MS);

    Result := Gif;
  finally
    MS.Free;
  end;
end;

function fOtimizaImagem(var strBase64 : String) : Boolean;
var
  objInput  : TStringStream;
  objOutput : TBytesStream;
  jpgAux    : TJPEGImage;
  pngAux    : TPNGImage;

  imgGraphic : TGraphic;

  function fReduzPNG(var PNG : TPNGImage) : Boolean;
    var
      Bmp1,Bmp2: TBitmap;
  begin

    Bmp1:=TBitmap.Create;
    Bmp2:=TBitmap.Create;

    try

      Bmp1.Assign(PNG);

      try

       With Bmp2 Do
       Begin
         PixelFormat := pf32bit;
         Width :=  800;
         Height := Round(Bmp1.Height * ( 800 / Bmp1.Width));

         Canvas.StretchDraw(Rect(0,0,Bmp2.Width,Bmp2.Height),Bmp1);
       End;

       PNG.Assign(BMP2);
       Result := True;

      finally

      end;
    finally
      Bmp1.Free;
      Bmp2.Free;
    end;
  end;

  function fReduzJPEG(var Source : TJpegImage) : Boolean;
  var
    Dest, Temp: TBitmap;
  begin

    try
      Dest := TBitmap.Create;
      try
        Temp := TBitmap.Create;
        try
          Source.DIBNeeded;
          Dest.Assign(Source);
          Temp.SetSize(1000, Round(Source.Height * ( 1000 / Source.Width)) );
          Temp.Canvas.StretchDraw(Rect(0, 0, 1000, Round(Source.Height * ( 1000 / Source.Width)) ), Dest );

          Source.Assign(Temp);

          Result := True;
        finally
          Temp.Free;
        end;
      finally
        Dest.Free;
      end;
    finally

    end;
  end;

Begin
  Result := False;

  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  objOutput := TBytesStream.Create;

  Try
    Soap.EncdDecd.DecodeStream(objInput, objOutput);
    objOutput.Position := 0;

    Try
      If Copy(strBase64, 1, 4) = '/9j/' Then
      Begin
        jpgAux := TJPEGImage.Create;
        jpgAux.LoadFromStream(objOutput);
        If fReduzJPEG(jpgAux) Then
        Begin
          try
            imgGraphic := jpgAux;
            strBase64  := fBase64FromImg(imgGraphic);
            Result    := True;
          finally
            FreeAndNil(jpgAux);
          end;
        End;
      End
      Else
      Begin
        pngAux := TPNGImage.Create;
        pngAux.LoadFromStream(objOutput);
        If fReduzPNG(pngAux) Then
        Begin
          try
            imgGraphic := pngAux;
            strBase64  := fBase64FromImg(imgGraphic);
            Result    := True;
          finally
            FreeAndNil(pngAux);
          end;
        End;
      End;

    Finally

    End;
  Finally
    objInput.Free;
    objOutput.Free;
  End;
End;

function fBase64FromJPEG(objImage: TJPEGImage): String;
Var
  objInput: TBytesStream;
  objOutput: TStringStream;
Begin
  objInput := TBytesStream.Create;
  Try
    objImage.SaveToStream(objInput);
    objInput.Position := 0;
    objOutput := TStringStream.Create('', TEncoding.ASCII);
    Try
      Soap.EncdDecd.EncodeStream(objInput, objOutput);
      Result := objOutput.DataString;
    Finally
      objOutput.Free;
    End;
  Finally
    objInput.Free;
  End;
End;

function fJPEGFromBase64(const strBase64: string): TJPEGImage;
var
  objInput: TStringStream;
  objOutput: TBytesStream;
begin
  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  Try
    objOutput := TBytesStream.Create;
    Try
      Soap.EncdDecd.DecodeStream(objInput, objOutput);
      objOutput.Position := 0;
      Result := TJPEGImage.Create;
      Try
        Result.LoadFromStream(objOutput);
      Except
        Result.Free;
        Raise;
      End;
    Finally
      objOutput.Free;
    end;
  Finally
    objInput.Free;
  End;
end;

procedure pFileImagemFromBase64(const strBase64: string; var strCaminhoImagem: string);
var
  objInput  : TStringStream;
  objOutput : TBytesStream;

  //picAux e imgAux foram criados para não dar memoryleak
  imgAux    : TGraphic;
  picAux    : TPicture;

  strExtensao: String;
begin
  objInput := TStringStream.Create(strBase64, TEncoding.ASCII);
  objOutput := TBytesStream.Create;

  Try
    Soap.EncdDecd.DecodeStream(objInput, objOutput);
    objOutput.Position := 0;

    picAux := TPicture.Create;

    if Copy(strBase64, 1, 4) = '/9j/' then
    begin
      imgAux := TJPEGImage.Create;
      strExtensao := '.jpg';
    end
    else
    begin
      imgAux := TPngImage.Create;
      strExtensao := '.png';
    end;

    try
      imgAux.LoadFromStream(objOutput);
      picAux.Graphic := imgAux;

      strCaminhoImagem := strCaminhoImagem + strExtensao;

      picAux.SaveToFile(strCaminhoImagem);
    finally
      FreeAndNil(imgAux);
      FreeAndNil(picAux);
    end;

  Finally
    objInput.Free;
    objOutput.Free;
  End;
end;

end.
