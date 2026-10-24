unit untImpNaoFiscalEpson;
interface

uses Windows, SysUtils, untImpNaoFiscal;

Type
  TImpNaoFiscalEpson = class(TImpNaoFiscal)

  private
    IniciaPorta:      function(strPorta: ShortString): Integer; stdcall;
    FechaPorta:       function:Integer; stdcall;
    AcionaGuilhotina: function(intModo: Integer): Integer; stdcall;
    ComandoTX:        function(BufTrans: string; TamBufTrans: integer): integer; stdcall;
    procedure pIniciaImpressora;
    procedure pFechaPorta;

  protected

  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pAcionaGuilhotina(blnCorteTotal: Boolean); override;
    procedure pAbreGaveta; Override;

  End;

implementation

uses untFuncoesSimples;

{ TImpNaoFiscalEpson }

constructor TImpNaoFiscalEpson.Create;
begin
  inherited;
  strPatDll := fArqIniLocal(0, 'EPSON', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');
  pCarregaDll;
end;

destructor TImpNaoFiscalEpson.Destroy;
begin
  FreeLibrary(FHandle);
  inherited;
end;

procedure TImpNaoFiscalEpson.pAbreGaveta;
Var
  strComando: String;
begin
  pIniciaImpressora;
  ComandoTX := GetProcAddress(FHandle, 'ComandoTX');
  strComando := #27 + #112 + #0 + #25 + #250;
  ComandoTX(strComando, Length(strComando));
  pFechaPorta;
end;

procedure TImpNaoFiscalEpson.pAcionaGuilhotina(blnCorteTotal: Boolean);
begin
  pIniciaImpressora;
  AcionaGuilhotina := GetProcAddress(FHandle, 'AcionaGuilhotina');
  AcionaGuilhotina(IIF(blnCorteTotal, 1, 0));
  pFechaPorta;
end;

procedure TImpNaoFiscalEpson.pFechaPorta;
begin
  FechaPorta := GetProcAddress(FHandle, 'FechaPorta');
  FechaPorta;
end;

procedure TImpNaoFiscalEpson.pIniciaImpressora;
  Var
    intRetorno: Integer;
    strPorta: ShortString;
begin
  strPorta    := ShortString(fArqIniLocal(0, 'EPSON', 'PORTA', '', 'opcoes_nao_fiscal.ini'));

  IniciaPorta := GetProcAddress(FHandle, 'IniciaPorta');
  intRetorno  := IniciaPorta(strPorta);

  If (intRetorno <= 0) Then
    Raise Exception.Create('Problemas ao iniciar porta: ' + String(strPorta) + #13#10 +
                           'Erro: ' + IntToStr(intRetorno));
end;

end.
