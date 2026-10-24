unit untImpNaoFiscalDaruma;

interface

uses Windows, SysUtils, untImpNaoFiscal;

Type
  TImpNaoFiscalDaruma = class(TImpNaoFiscal)
  private
    FHandle: Cardinal;

    eDefinirProduto_Daruma: function (szProduto: String): Integer; StdCall;
    regPortaComunicacao_DUAL_DarumaFramework: function (stParametro: String): Integer; StdCall;
    iImprimirTexto_DUAL_DarumaFramework: function (stTexto: String; iTam: Integer ): Integer; StdCall;

    procedure pConfiguraImpressora;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure pAcionaGuilhotina(blnCorteTotal: Boolean); override;
    procedure pAbreGaveta; Override;
  End;

implementation

uses untFuncoesSimples;

{ TImpNaoFiscalDaruma }

constructor TImpNaoFiscalDaruma.Create;
begin
  pConfiguraImpressora;
end;

destructor TImpNaoFiscalDaruma.Destroy;
begin
  FreeLibrary(FHandle);
  inherited;
end;

procedure TImpNaoFiscalDaruma.pAbreGaveta;
begin
  inherited;
  //
end;

procedure TImpNaoFiscalDaruma.pAcionaGuilhotina(blnCorteTotal: Boolean);
begin
  inherited;
  iImprimirTexto_DUAL_DarumaFramework('<gui></gui>', 0);
end;

procedure TImpNaoFiscalDaruma.pConfiguraImpressora;
  Var
    strPorta: String;
begin
  strPatDll := fArqIniLocal(0, 'DARUMA', 'PATHDLL', '', 'opcoes_nao_fiscal.ini');
  strPorta  := fArqIniLocal(0, 'DARUMA', 'PORTA', 'LPT1', 'opcoes_nao_fiscal.ini');
  FHandle   := LoadLibrary(PChar(strPatDll));

  If (FHandle = 0) Then
  Begin
    Raise Exception.Create('Não foi possível carregar a DLL para comunicação com a impressora. Por favor verifique.');
  End;

  eDefinirProduto_Daruma := GetProcAddress(FHandle, PChar('eDefinirProduto_Daruma'));
  regPortaComunicacao_DUAL_DarumaFramework := GetProcAddress(FHandle, PChar('regPortaComunicacao_DUAL_DarumaFramework'));
  iImprimirTexto_DUAL_DarumaFramework := GetProcAddress(FHandle, PChar('iImprimirTexto_DUAL_DarumaFramework'));

  {*****************************************}
  {* DEFINE COMO IMPRESSORA NÃO FISCAL     *}
  {**************************************MV*}
  eDefinirProduto_Daruma(PChar('DUAL'));

  regPortaComunicacao_DUAL_DarumaFramework(strPorta);
end;

end.
