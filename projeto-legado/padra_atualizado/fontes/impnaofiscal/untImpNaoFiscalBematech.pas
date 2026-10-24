unit untImpNaoFiscalBematech;

interface

uses Windows, SysUtils, untImpNaoFiscal;

Type
  TImpNaoFiscalBematech = class(TImpNaoFiscal)

  private

    {*******************************************}
    {* FUNÇÕES PARA A DLL                      *}
    {***22/04/2008***************************MV*}
    IniciaPorta:               function(strPorta: ShortString): Integer; stdcall;
    ConfiguraModeloImpressora: function(intModelo: Integer): Integer; stdcall;
    FechaPorta:                function:Integer; stdcall;
    AcionaGuilhotina:          function(intModo: Integer): Integer; stdcall;
    ComandoTX:                 function(BufTrans: string; TamBufTrans: integer): integer; stdcall;

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

uses untfuncoesSimples;

{ TImpNaoFiscalBematech }

constructor TImpNaoFiscalBematech.Create;
begin
  inherited;
  strPatDll := fArqIniLocal(0, 'BEMATECH', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');
  pCarregaDll;
end;

destructor TImpNaoFiscalBematech.Destroy;
begin
  FreeLibrary(FHandle);
  inherited;
end;

procedure TImpNaoFiscalBematech.pAcionaGuilhotina(blnCorteTotal: Boolean);
begin
  pIniciaImpressora;
  AcionaGuilhotina := GetProcAddress(FHandle, 'AcionaGuilhotina');
  AcionaGuilhotina(IIF(blnCorteTotal, 1, 0));
  pFechaPorta;
end;

procedure TImpNaoFiscalBematech.pFechaPorta;
begin

  FechaPorta := GetProcAddress(FHandle, 'FechaPorta');
  FechaPorta;

end;

procedure TImpNaoFiscalBematech.pIniciaImpressora;
  Var
    intRetorno: Integer;
    strPorta: ShortString;
    intModelo: Integer;
begin
  strPorta    := ShortString(fArqIniLocal(0, 'BEMATECH', 'PORTA', '', 'opcoes_nao_fiscal.ini'));
  intModelo   := StrToInt(fArqIniLocal(0, 'BEMATECH', 'MODELO', '', 'opcoes_nao_fiscal.ini'));

  IniciaPorta := GetProcAddress(FHandle, 'IniciaPorta');
  intRetorno  := IniciaPorta(strPorta);

  If (intRetorno <= 0) Then
    Raise Exception.Create('Problemas ao iniciar porta: ' + String(strPorta) + #13#10 +
                           'Erro: ' + IntToStr(intRetorno));

  ConfiguraModeloImpressora := GetProcAddress(FHandle, 'ConfiguraModeloImpressora');
  ConfiguraModeloImpressora(intModelo);
end;

procedure TImpNaoFiscalBematech.pAbreGaveta;
Var
    strComando: String;
begin
  pIniciaImpressora;
  ComandoTX := GetProcAddress(FHandle, 'ComandoTX');

  strComando := #27 + #118 + #140;
  ComandoTX(strComando, Length(strComando));

  pFechaPorta;
end;

end.

