unit Reforma.Plugin;

// Ponto de entrada da DLL. O host cria as abas vazias e passa o HWND: a DLL
// tem VCL propria, entao o frame nasce dentro do handle recebido.

interface

uses
  Reforma.Contrato.Host,
  Reforma.Contrato.Convert;

function fReformaVersaoContrato: Integer; stdcall;
procedure pReformaInicializar(const Host: IReformaHost); stdcall;
// REFTRI-03 (contrato 8): se a aba (1, 2 ou 3) aparece no cadastro. O host pergunta depois de pReformaInicializar.
function fReformaAbaVisivel(const Aba: Integer): Boolean; stdcall;
function fReformaCriarAba2(const PaiHandle: NativeUInt): NativeUInt; stdcall;
function fReformaCriarAba3(const PaiHandle: NativeUInt): NativeUInt; stdcall;
// Variante da aba 3 para hosts cuja aba 1 de precos e grid vertical multi-record (familia
// 150.x). Export adicional (Reforma.Contrato.Exportacao.EXPORT_CRIAR_ABA3_GRID); so o loader
// desses hosts tenta carrega-lo. fReformaCriarAba3 continua intocado para 72/74.111.
function fReformaCriarAba3Grid(const PaiHandle: NativeUInt): NativeUInt; stdcall;
// Aba 4 "Calculo Convert" (contrato 11): classica (72/74.111) e grid vertical (150.x).
function fReformaCriarAba4(const PaiHandle: NativeUInt): NativeUInt; stdcall;
function fReformaCriarAba4Grid(const PaiHandle: NativeUInt): NativeUInt; stdcall;
procedure pReformaCarregar(const CodigoItem: string); stdcall;
procedure pReformaEntrarAba(const Aba: Integer); stdcall;
procedure pReformaAtualizarAtual; stdcall;
procedure pReformaConfirmarEdicao; stdcall;
procedure pReformaFinalizar; stdcall;
function fReformaPendente: Boolean; stdcall;
function pReformaGravar(const CodigoItem: string; out Mensagem: string): Boolean; stdcall;
function fReformaAssinaturaContrato: Cardinal; stdcall;
procedure pReformaDescartar; stdcall;
procedure pReformaAbrirConvert(const Host: IReformaConvertHost); stdcall;
function fReformaConvertDisponivel(const Operador: string; const Data: TDateTime): Boolean; stdcall;
function fReformaPrepararBanco(const Banco: IReformaBancoHost; out Mensagem: string): Boolean; stdcall;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  Vcl.Controls,
  Reforma.Contrato.Exportacao,
  Reforma.Contrato.Assinatura,
  Reforma.Contrato.Gravacao,
  Reforma.Convert.Servico,
  Reforma.Repositorio.Estrutura,
  Reforma.Repositorio.Conversao,
  Reforma.Simulacao.Modelo,
  Reforma.View.Hospedeira,
  Reforma.View.Estilo,
  Reforma.View.Comparativo,
  Reforma.View.Futura,
  Reforma.View.FuturaGrid,
  Reforma.View.CalculoConvert,
  Reforma.Simulacao.Convert;

var
  GHost: IReformaHost;
  GSimulacao: TSimulacaoReforma;
  // Cada aba vive num form da DLL (ver TformHospedeira); o form e dono do frame.
  GFormComparativo: TformHospedeira;
  GFormFutura: TformHospedeira;
  GAbaComparativo: TframeComparativo;
  GAbaFutura: TframeFutura;
  GAbaFuturaGrid: TframeFuturaGrid;
  // Aba 4 "Calculo Convert": so o operador 998 e so antes da conversao (lido uma vez na inicializacao).
  GFormCalculoConvert: TformHospedeira;
  GAbaCalculoConvert: TpnlCalculoConvert;
  GAba4Visivel: Boolean;
  // REFTRI-03: CFG_REFCIS = 'S' (empresa convertida), lido uma vez na inicializacao. A aba 3 nao aparece e a aba 2
  // mostra a conversao (GConsulta) em vez da simulacao.
  GModoConversao: Boolean;
  GConsulta: TConsultaConversao;

function fReformaVersaoContrato: Integer;
begin
  Result := VERSAO_CONTRATO;
end;

function fReformaAssinaturaContrato: Cardinal;
begin
  Result := fReformaCalculaAssinatura;
end;

// Os frames assinam a simulacao: saem antes dela.
procedure pLiberarAbas;
begin
  GAbaCalculoConvert := nil;
  FreeAndNil(GFormCalculoConvert);
  GAbaFutura := nil;
  GAbaFuturaGrid := nil;
  GAbaComparativo := nil;
  FreeAndNil(GFormFutura);
  FreeAndNil(GFormComparativo);
end;

procedure pReformaInicializar(const Host: IReformaHost);
begin
  // Segunda inicializacao sem Finalizar: frames vivos apontariam para a simulacao liberada.
  pLiberarAbas;
  FreeAndNil(GConsulta);
  FreeAndNil(GSimulacao);
  GModoConversao := False;
  GAba4Visivel := False;
  GHost := Host;
  // O estilo (skin) tem de estar ativo antes de qualquer form da DLL existir.
  pAtivarEstilo(Host.EstiloVisual);
  GSimulacao := TSimulacaoReforma.Create(Host);
  GModoConversao := Host.ConfiguracaoBooleana('REFCIS');
  if GModoConversao then
    GConsulta := TConsultaConversao.Create(Host);
  GAba4Visivel := not GModoConversao and fAba4Disponivel(Host);
end;

// A regra de visibilidade e da DLL (RN10): o host so obedece. Antes de inicializar tudo aparece, menos a aba 4.
function fReformaAbaVisivel(const Aba: Integer): Boolean;
begin
  case Aba of
    3: Result := not GModoConversao;
    4: Result := GAba4Visivel;
  else
    Result := True;
  end;
end;

// Antes de Inicializar ou depois de Finalizar nao ha simulacao para o frame assinar. Excecao, e nao
// handle 0: o host nao trata 0, e o except do loader e quem desliga o plugin (blnFalhou).
procedure pExigirInicializado;
begin
  if not Assigned(GSimulacao) or not Assigned(GHost) then
    raise Exception.Create('Aba de precos criada sem pReformaInicializar (ou depois de pReformaFinalizar).');
end;

function fReformaCriarAba2(const PaiHandle: NativeUInt): NativeUInt;
begin
  pExigirInicializado;

  GAbaComparativo := nil;
  FreeAndNil(GFormComparativo);
  GFormComparativo := TformHospedeira.CriarNaJanela(PaiHandle);
  GAbaComparativo := TframeComparativo.Criar(GFormComparativo, GHost, GSimulacao, GConsulta);
  GAbaComparativo.Parent := GFormComparativo;
  GAbaComparativo.Align := alClient;
  pAjustarTema(GFormComparativo);
  GFormComparativo.Visible := True;
  Result := GFormComparativo.Handle;
end;

function fReformaCriarAba3(const PaiHandle: NativeUInt): NativeUInt;
begin
  pExigirInicializado;

  GAbaFutura := nil;
  GAbaFuturaGrid := nil;
  FreeAndNil(GFormFutura);
  GFormFutura := TformHospedeira.CriarNaJanela(PaiHandle);
  GAbaFutura := TframeFutura.Criar(GFormFutura, GHost, GSimulacao);
  GAbaFutura.Parent := GFormFutura;
  GAbaFutura.Align := alClient;
  pAjustarTema(GFormFutura);
  GFormFutura.Visible := True;
  Result := GFormFutura.Handle;
end;

function fReformaCriarAba3Grid(const PaiHandle: NativeUInt): NativeUInt;
begin
  pExigirInicializado;

  GAbaFutura := nil;
  GAbaFuturaGrid := nil;
  FreeAndNil(GFormFutura);
  GFormFutura := TformHospedeira.CriarNaJanela(PaiHandle);
  GAbaFuturaGrid := TframeFuturaGrid.Criar(GFormFutura, GHost, GSimulacao);
  GAbaFuturaGrid.Parent := GFormFutura;
  GAbaFuturaGrid.Align := alClient;
  GFormFutura.AoConfirmar := GAbaFuturaGrid.ConfirmarEdicao;
  pAjustarTema(GFormFutura);
  GFormFutura.Visible := True;
  Result := GFormFutura.Handle;
end;

function fCriarAba4(const PaiHandle: NativeUInt; const Grid: Boolean): NativeUInt;
begin
  pExigirInicializado;

  GAbaCalculoConvert := nil;
  FreeAndNil(GFormCalculoConvert);
  GFormCalculoConvert := TformHospedeira.CriarNaJanela(PaiHandle);
  GAbaCalculoConvert := TpnlCalculoConvert.Criar(GFormCalculoConvert, GFormCalculoConvert, GHost, GSimulacao, Grid);
  pAjustarTema(GFormCalculoConvert);
  GFormCalculoConvert.Visible := True;
  Result := GFormCalculoConvert.Handle;
end;

function fReformaCriarAba4(const PaiHandle: NativeUInt): NativeUInt;
begin
  Result := fCriarAba4(PaiHandle, False);
end;

function fReformaCriarAba4Grid(const PaiHandle: NativeUInt): NativeUInt;
begin
  Result := fCriarAba4(PaiHandle, True);
end;

procedure pReformaCarregar(const CodigoItem: string);
begin
  if Assigned(GSimulacao) then
    GSimulacao.Carregar;

  // Modo conversao: outro produto com a aba 2 na tela (navegacao no cadastro) e lido agora; com a aba fora da tela
  // so ao entrar nela (RF08). A consulta nao rele o mesmo item.
  if GModoConversao and Assigned(GAbaComparativo) and Assigned(GFormComparativo) and
     IsWindowVisible(GFormComparativo.Handle) then
    GAbaComparativo.Entrar;
end;

procedure pReformaEntrarAba(const Aba: Integer);
begin
  // CFG_REFCIS = 'N': o que mudou na aba 1 sem Post (72 e 74.111 editam o produto direto) chega ao lado Novo. Com
  // 'S' a aba 2 mostra a conversao e a aba 3 nao existe: nada a sincronizar.
  if (Aba in [2, 3, 4]) and Assigned(GSimulacao) and not GModoConversao then
    GSimulacao.SincronizarProduto;

  if (Aba = 2) and Assigned(GAbaComparativo) then
    GAbaComparativo.Entrar
  else if (Aba = 3) and Assigned(GAbaFutura) then
    GAbaFutura.Entrar
  else if (Aba = 3) and Assigned(GAbaFuturaGrid) then
    GAbaFuturaGrid.Entrar
  else if (Aba = 4) and Assigned(GAbaCalculoConvert) then
    GAbaCalculoConvert.Entrar;
end;

procedure pReformaAtualizarAtual;
begin
  // CFG_REFCIS = 'N': o produto mudou, o lado Novo e a aba 3 acompanham nos campos que nao sao da REFPRE.
  if Assigned(GSimulacao) and not GModoConversao then
    GSimulacao.SincronizarProduto;

  if Assigned(GAbaComparativo) then
    GAbaComparativo.AtualizarAtual;
  if Assigned(GAbaFutura) then
    GAbaFutura.AplicarEstado;
  if Assigned(GAbaFuturaGrid) then
    GAbaFuturaGrid.AplicarEstado;
  if Assigned(GAbaCalculoConvert) then
    GAbaCalculoConvert.AplicarEstado;
end;

procedure pReformaConfirmarEdicao;
begin
  if Assigned(GFormComparativo) then
    GFormComparativo.ConfirmarEdicao;
  if Assigned(GFormFutura) then
    GFormFutura.ConfirmarEdicao;
end;

// O host pergunta logo antes de gravar: a sincronizacao aqui garante que a REFPRE parte do produto que vai ser
// gravado, mesmo com a aba 1 editada sem abrir as abas 2 e 3.
function fReformaPendente: Boolean;
begin
  if Assigned(GSimulacao) then
    GSimulacao.SincronizarProduto;
  Result := Assigned(GSimulacao) and GSimulacao.GravacaoPendente;
end;

function pReformaGravar(const CodigoItem: string; out Mensagem: string): Boolean;
var
  Resultado: TResultadoGravacao;
begin
  Mensagem := '';
  Result := True;
  if not Assigned(GSimulacao) then
    Exit;

  // Excecao nao atravessa para o host (classe diferente em cada modulo): vira Result e Mensagem.
  try
    Resultado := GSimulacao.Persistir(CodigoItem);
    Result := Resultado.Sucesso;
    if not Result then
      Mensagem := Resultado.Mensagem;
  except
    on E: Exception do
    begin
      Result := False;
      Mensagem := E.Message;
    end;
  end;
end;

procedure pReformaDescartar;
begin
  if Assigned(GSimulacao) then
    GSimulacao.Descartar;
end;

// Menu do Convert: a regra e da DLL (TConvertServico.Liberado), o host so informa operador e data.
function fReformaConvertDisponivel(const Operador: string; const Data: TDateTime): Boolean;
begin
  try
    Result := TConvertServico.Liberado(Operador, Data);
  except
    Result := False;
  end;
end;

// O Convert nao usa GHost/GSimulacao (sao do cadastro): recebe o proprio host. Nenhuma excecao sai daqui.
procedure pReformaAbrirConvert(const Host: IReformaConvertHost);
begin
  if not Assigned(Host) then
    Exit;
  try
    TConvertServico.Abrir(Host);
  except
    on E: Exception do
      Host.Mensagem('Ativar Preços Reforma Tributária', 'Falha na tela de conversão: ' + E.Message);
    else
      Host.Mensagem('Ativar Preços Reforma Tributária', 'Falha na tela de conversão.');
  end;
end;

// Nao depende de pReformaInicializar (nao ha cadastro aberto): so o banco que o host entrega.
function fReformaPrepararBanco(const Banco: IReformaBancoHost; out Mensagem: string): Boolean;
var
  Estrutura: TEstruturaBanco;
begin
  Mensagem := '';
  Result := False;
  if not Assigned(Banco) then
    Exit;

  try
    Estrutura := TEstruturaBanco.Create(Banco);
    try
      Result := Estrutura.Preparar(Mensagem);
    finally
      Estrutura.Free;
    end;
  except
    on E: Exception do
      Mensagem := E.Message;
  end;
end;

procedure pReformaFinalizar;
begin
  try
    pLiberarAbas;
    FreeAndNil(GConsulta);
    FreeAndNil(GSimulacao);
  finally
    GModoConversao := False;
    GAba4Visivel := False;
    // Mesmo com falha acima, ganchos e subclasse nao sobrevivem a descarga da DLL.
    pLiberarGanchos;
    GHost := nil;
  end;
end;

end.