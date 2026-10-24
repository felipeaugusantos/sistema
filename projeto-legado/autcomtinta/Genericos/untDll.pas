unit untDll;

interface

uses
  Windows, SysUtils;

type
  TDll = class(TInterfacedObject)
  private
    function GetCarregada: Boolean;
  protected
    handle: THandle;
    strNomeArquivoDll: string;
    procedure CarregarFuncoes; virtual; abstract;
    procedure CarregarFuncaoDll(var pntFuncao: Pointer; strNomeFuncao: string);
  public
    constructor Create(const strNomeArquivoDll: string);
    destructor Destroy; override;
    property Carregada: Boolean read GetCarregada;
  end;

implementation

{ TDll }

procedure TDll.CarregarFuncaoDll(var pntFuncao: Pointer; strNomeFuncao: string);
begin
  Try
    pntFuncao := GetProcAddress(handle, PAnsiChar(AnsiString(strNomeFuncao)));
    if not Assigned(pntFuncao) then
      raise Exception.Create('');
  Except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possivel carregar a função ' + strNomeFuncao);
    end;
  End;
end;

constructor TDll.Create(const strNomeArquivoDll: string);
begin
  inherited Create();
  Self.strNomeArquivoDll := strNomeArquivoDll;
  handle := LoadLibrary(PWideChar(strNomeArquivoDll));
  if GetCarregada then
    CarregarFuncoes;
end;

destructor TDll.Destroy;
begin
  if handle <> 0 then
    FreeLibrary(handle);
  
  inherited;
end;

function TDll.GetCarregada: Boolean;
begin
  Result := handle <> 0;
end;

end.
