unit Principal.Classes.ImagemMemoria;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  FMX.Graphics, FMX.Types, FMX.Objects, System.Types;

type
  TFormatoImagem = (fiUnknown, fiJPEG, fiPNG, fiBMP, fiGIF, fiTIFF);

type
  TImagemMemoria = class
  private
    FID: string;
    FBitmap: TBitmap;
    FExtensao: string;
    FFormato: TFormatoImagem;
    procedure DetectarFormatoImagem(ABitmap: TBitmap);
  public
    constructor Create(const AID: string; ABitmap: TBitmap);
    destructor Destroy; override;
    property ID: string read FID;
    property Bitmap: TBitmap read FBitmap;
    property Extensao: string read FExtensao;
    property Formato: TFormatoImagem read FFormato;
  end;

  TGerenciadorImagens = class
  private
    FListaImagens: TObjectList<TImagemMemoria>;
    function GerarIDUnico: string;
  public
    constructor Create;
    destructor Destroy; override;
    function AdicionarImagem(ABitmap: TBitmap): string; overload;
    function AdicionarImagem(const ABase64: string): string; overload;
    function AdicionarImagem(AStream: TStream): string; overload;
    function ObterImagem(const AID: string): TBitmap;
    function ObterImagemComoBase64(const AID: string): string;
    function ObterExtensaoImagem(const AID: string): string;
    function ObterFormatoImagem(const AID: string): TFormatoImagem;
    procedure RemoverImagem(const AID: string);
    procedure LimparTodasImagens;
    function ContarImagens: Integer;
  end;

implementation

uses
  System.NetEncoding;

{ TImagemMemoria }

constructor TImagemMemoria.Create(const AID: string; ABitmap: TBitmap);
begin
  inherited Create;
  FID := AID;
  FBitmap := TBitmap.Create;
  if Assigned(ABitmap) then
  begin
    FBitmap.Assign(ABitmap);
    DetectarFormatoImagem(FBitmap);
  end
  else
  begin
    FExtensao := '';
    FFormato := fiUnknown;
  end;
end;

destructor TImagemMemoria.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TImagemMemoria.DetectarFormatoImagem(ABitmap: TBitmap);
var
  LMemoryStream: TMemoryStream;
  LHeader: array[0..3] of Byte;
begin
  FExtensao := '';
  FFormato := fiUnknown;

  if not Assigned(ABitmap) or (ABitmap.Width <= 0) or (ABitmap.Height <= 0) then
    Exit;

  LMemoryStream := TMemoryStream.Create;
  try
    ABitmap.SaveToStream(LMemoryStream);
    if LMemoryStream.Size > 4 then
    begin
      LMemoryStream.Position := 0;
      LMemoryStream.Read(LHeader, SizeOf(LHeader));

      // Detecta formato pelo header
      case LHeader[0] of
        $FF:
          if LHeader[1] = $D8 then
          begin
            FExtensao := 'jpg';
            FFormato := fiJPEG;
          end;
        $89:
          if (LHeader[1] = $50) and (LHeader[2] = $4E) and (LHeader[3] = $47) then
          begin
            FExtensao := 'png';
            FFormato := fiPNG;
          end;
        $47:
          if (LHeader[1] = $49) and (LHeader[2] = $46) then
          begin
            FExtensao := 'gif';
            FFormato := fiGIF;
          end;
        $42:
          if LHeader[1] = $4D then
          begin
            FExtensao := 'bmp';
            FFormato := fiBMP;
          end;
        $49:
          if (LHeader[1] = $49) and (LHeader[2] = $2A) then
          begin
            FExtensao := 'tif';
            FFormato := fiTIFF;
          end;
        $4D:
          if (LHeader[1] = $4D) and (LHeader[2] = $00) then
          begin
            FExtensao := 'tif';
            FFormato := fiTIFF;
          end;
      end;
    end;
  finally
    LMemoryStream.Free;
  end;

  // Default para PNG se não detectado (mais comum em assinaturas/base64)
  if FExtensao = '' then
  begin
    FExtensao := 'png';
    FFormato := fiPNG;
  end;
end;

{ TGerenciadorImagens }

constructor TGerenciadorImagens.Create;
begin
  inherited;
  FListaImagens := TObjectList<TImagemMemoria>.Create(True);
end;

destructor TGerenciadorImagens.Destroy;
begin
  LimparTodasImagens;
  FreeAndNil(FListaImagens);
  inherited;
end;

function TGerenciadorImagens.AdicionarImagem(ABitmap: TBitmap): string;
var
  LID: string;
begin
  if not Assigned(ABitmap) then
    raise Exception.Create('Bitmap não pode ser nulo');

  LID := GerarIDUnico;
  FListaImagens.Add(TImagemMemoria.Create(LID, ABitmap));
  Result := LID;
end;

function TGerenciadorImagens.AdicionarImagem(const ABase64: string): string;
var
  LStream: TStringStream;
begin
  LStream := TStringStream.Create(ABase64);
  try
    LStream.Position := 0;
    Result := AdicionarImagem(LStream);
  finally
    LStream.Free;
  end;
end;

function TGerenciadorImagens.AdicionarImagem(AStream: TStream): string;
var
  LBitmap: TBitmap;
begin
  if not Assigned(AStream) then
    raise Exception.Create('Stream não pode ser nulo');

  LBitmap := TBitmap.Create;
  try
    AStream.Position := 0;
    LBitmap.LoadFromStream(AStream);
    Result := AdicionarImagem(LBitmap);
  finally
    LBitmap.Free;
  end;
end;

function TGerenciadorImagens.ContarImagens: Integer;
begin
  Result := FListaImagens.Count;
end;

function TGerenciadorImagens.GerarIDUnico: string;
begin
  Result := TGUID.NewGuid.ToString.Replace('{', '').Replace('}', '');
end;

procedure TGerenciadorImagens.LimparTodasImagens;
begin
  FListaImagens.Clear;
end;

function TGerenciadorImagens.ObterExtensaoImagem(const AID: string): string;
var
  LImagem: TImagemMemoria;
begin
  Result := '';
  for LImagem in FListaImagens do
  begin
    if SameText(LImagem.ID, AID) then
    begin
      Result := LImagem.Extensao;
      Break;
    end;
  end;
end;

function TGerenciadorImagens.ObterFormatoImagem(
  const AID: string): TFormatoImagem;
var
  LImagem: TImagemMemoria;
begin
  Result := fiUnknown;
  for LImagem in FListaImagens do
  begin
    if SameText(LImagem.ID, AID) then
    begin
      Result := LImagem.Formato;
      Break;
    end;
  end;
end;

function TGerenciadorImagens.ObterImagem(const AID: string): TBitmap;
var
  LImagem: TImagemMemoria;
begin
  Result := nil;
  for LImagem in FListaImagens do
  begin
    if SameText(LImagem.ID, AID) then
    begin
      Result := TBitmap.Create;
      Result.Assign(LImagem.Bitmap);
      Break;
    end;
  end;
end;

function TGerenciadorImagens.ObterImagemComoBase64(const AID: string): string;
var
  LBitmap: TBitmap;
  LStream: TMemoryStream;
begin
  LBitmap := ObterImagem(AID);
  if not Assigned(LBitmap) then
    Exit('');

  LStream := TMemoryStream.Create;
  try
    LBitmap.SaveToStream(LStream);
    LStream.Position := 0;
    Result := TNetEncoding.Base64.EncodeBytesToString(LStream.Memory, LStream.Size);
  finally
    LStream.Free;
    LBitmap.Free;
  end;
end;

procedure TGerenciadorImagens.RemoverImagem(const AID: string);
var
  I: Integer;
begin
  for I := FListaImagens.Count - 1 downto 0 do
  begin
    if SameText(FListaImagens[I].ID, AID) then
    begin
      FListaImagens.Delete(I);
      Break;
    end;
  end;
end;

end.
