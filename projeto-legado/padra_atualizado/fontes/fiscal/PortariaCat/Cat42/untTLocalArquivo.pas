//# Especifica qual pasta o Austi ira acessa para recuperar
//# informações dos arquivos (opcoes.ini) e (libUtil.dll)
//# True = acessa a pasta anterior
//# false = acessa a pasta padrão aonde se encontra o executavel do autsi;
//# ESTRUTRA FEITA POIS O PROCESSO ESTA EM FASE DE TESTES E SERA NECESSARIO MUDAR LOCAL COM FREQUENCIA.

unit untTLocalArquivo;

interface

type
  TLocalArquivo = class
  private
  public

  end;

  function f__VS_CONEXAO_USANDO_LINUX_AUTSI: Boolean;
  function f__VS_CONEXAO_USANDO_PASTA_ANTERIOR_A_DO_AUTSI: Boolean;
  function f__VS_RET_CONFIGURACAO_BANCO_DE_DADOS: Boolean;
  function fCaminhoConexaoUsandoPastaAnteriorDoAusti: string;

implementation

uses
  {$IFDEF MSWINDOWS}
  Vcl.Forms,
  {$ENDIF}
  untFuncoes,
  System.SysUtils;


{ TLocalArquivo }


function f__VS_CONEXAO_USANDO_LINUX_AUTSI: Boolean;
begin
  //atenção, setar como True para produção
  // somente Linux
  // false = executa em modo debug pelo delphi
  // true = recuperar caminho do opcoes.ini e opcoesautsi.ini para o binário
  Result:= True;
end;

function f__VS_RET_CONFIGURACAO_BANCO_DE_DADOS: Boolean;
begin
  // somente windows
  // false = configurações opcoesautsi.ini
  // true = configurações banco de dados
  // VS_blnSpedNovo = configuração da unit (untExportaSpedFiscal)
  Result:= VS_blnSpedNovo;
end;

function f__VS_CONEXAO_USANDO_PASTA_ANTERIOR_A_DO_AUTSI: Boolean;
begin
  Result:= False;
end;

function fCaminhoConexaoUsandoPastaAnteriorDoAusti: string;
begin
  {$IFDEF MSWINDOWS}
  Result:= Copy(ExtractFileDir(Application.ExeName), 1, LastDelimiter('\', ExtractFileDir(Application.ExeName)));
  {$ENDIF}
end;

end.

