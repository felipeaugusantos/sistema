unit Marketplace.EtiquetaDespachoUnificada.IProcessador;

// Interface + registry de processadores de etiqueta unificada por marketplace.
//
// Cada marketplace tem particularidades (formato ZPL nativo vs bitmap, pisos
// de legibilidade, heuristicas de reposicionamento de elementos, presenca
// ou nao de DANFE embutida). Ao inves de tratar tudo no orquestrador com
// if/else por prefixo, cada processador se auto-registra na inicializacao
// da sua unit e o orquestrador consulta o registry pelo prefixo recebido.
//
// A lista oficial de prefixos + nomes amigaveis exibidos na UI vive em
// untTypesSistema (const VS_arrMarketplaces) - fonte unica da verdade para
// UI (CheckGroup do CFG_EDUNIF) e para navegacao entre marketplaces.
// Marketplace sem processador registrado nao unifica; o que acontece nesse caso
// e decidido em TEtiquetaDespachoUnificada.fGerar.

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  IProcessadorMarketplace = interface
    ['{9C8F2A1E-3B4D-4E5A-8F1B-2D3C4E5F6A7B}']
    // Recebe conteudo ZPL original + path para BMP da DANFE renderizada
    // pelo NFeImpressao.exe (vazio se fPrecisaDanfe = False).
    // Retorna ZPL final unificado, ou string vazia em caso de falha.
    function fProcessar(const AstrZPLOriginal: String;
                        const AstrPathBMPDanfe: String): String;

    // True se o processador precisa que o NFeImpressao renderize a DANFE.
    // Orquestrador so invoca pGerarBMP quando este retorna True; quando e
    // False, fProcessar recebe path vazio. Hoje os tres processadores
    // retornam True - mesmo os marketplaces que embutem uma DANFE propria no
    // bitmap, porque ela fica ilegivel apos a compressao e e recortada fora.
    function fPrecisaDanfe: Boolean;
  end;

  TCriadorProcessador = reference to function: IProcessadorMarketplace;

  TRegistroProcessadores = class
  strict private
    class var FDicionario: TDictionary<String, TCriadorProcessador>;
    class function fObterDicionario: TDictionary<String, TCriadorProcessador>; static;
  public
    // Chamado em `initialization` de cada unit de processador.
    // O prefixo e normalizado (upper case). Registro duplicado sobrescreve.
    class procedure pRegistrar(const AstrPrefixo: String;
                               const ACriador: TCriadorProcessador); static;

    // Retorna nova instancia do processador cadastrado pro prefixo, ou nil
    // se nao houver. Comparacao case-insensitive.
    class function fCriarPorPrefixo(const AstrPrefixo: String): IProcessadorMarketplace; static;

    class destructor Destroy;
  end;

implementation

class function TRegistroProcessadores.fObterDicionario: TDictionary<String, TCriadorProcessador>;
begin
  if FDicionario = nil then
    FDicionario := TDictionary<String, TCriadorProcessador>.Create;
  Result := FDicionario;
end;

class procedure TRegistroProcessadores.pRegistrar(const AstrPrefixo: String;
                                                   const ACriador: TCriadorProcessador);
begin
  fObterDicionario.AddOrSetValue(UpperCase(AstrPrefixo), ACriador);
end;

class function TRegistroProcessadores.fCriarPorPrefixo(const AstrPrefixo: String): IProcessadorMarketplace;
var
  criador: TCriadorProcessador;
begin
  Result := nil;
  if FDicionario = nil then
    Exit;
  if FDicionario.TryGetValue(UpperCase(AstrPrefixo), criador) then
    Result := criador;
end;

class destructor TRegistroProcessadores.Destroy;
begin
  FreeAndNil(FDicionario);
end;

end.
