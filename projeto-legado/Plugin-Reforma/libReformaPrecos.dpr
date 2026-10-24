library libReformaPrecos;

// ShareMem primeiro: String e interfaces cruzam a fronteira com o exe.

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  MidasLib,
  dxCore,
  System.SysUtils,
  Reforma.Contrato.Tipos in 'Contrato\Reforma.Contrato.Tipos.pas',
  Reforma.Contrato.Gravacao in 'Contrato\Reforma.Contrato.Gravacao.pas',
  Reforma.Contrato.Host in 'Contrato\Reforma.Contrato.Host.pas',
  Reforma.Contrato.Exportacao in 'Contrato\Reforma.Contrato.Exportacao.pas',
  Reforma.Contrato.Assinatura in 'Contrato\Reforma.Contrato.Assinatura.pas',
  Reforma.Contrato.Convert in 'Contrato\Reforma.Contrato.Convert.pas',
  Reforma.Calculo.Modelo in 'Calculo\Reforma.Calculo.Modelo.pas',
  Reforma.Calculo.CustoVenda in 'Calculo\Reforma.Calculo.CustoVenda.pas',
  Reforma.Calculo.Formacao in 'Calculo\Reforma.Calculo.Formacao.pas',
  Reforma.Aliquotas.Fonte in 'Aliquotas\Reforma.Aliquotas.Fonte.pas',
  Reforma.Repositorio.Comparativo in 'Repositorio\Reforma.Repositorio.Comparativo.pas',
  Reforma.Repositorio.Banco in 'Repositorio\Reforma.Repositorio.Banco.pas',
  Reforma.Repositorio.Estrutura in 'Repositorio\Reforma.Repositorio.Estrutura.pas',
  Reforma.Repositorio.Refpre in 'Repositorio\Reforma.Repositorio.Refpre.pas',
  Reforma.Repositorio.Conversao in 'Repositorio\Reforma.Repositorio.Conversao.pas',
  Reforma.Simulacao.Replicacao in 'Simulacao\Reforma.Simulacao.Replicacao.pas',
  Reforma.Convert.Estrutura in 'Convert\Reforma.Convert.Estrutura.pas',
  Reforma.Convert.Regra in 'Convert\Reforma.Convert.Regra.pas',
  Reforma.Convert.Conferencia in 'Convert\Reforma.Convert.Conferencia.pas',
  Reforma.Convert.Processo in 'Convert\Reforma.Convert.Processo.pas',
  Reforma.Convert.Grupos in 'Convert\Reforma.Convert.Grupos.pas',
  Reforma.View.Convert in 'View\Reforma.View.Convert.pas' {frmReformaConvert},
  Reforma.Convert.Servico in 'Convert\Reforma.Convert.Servico.pas',
  Reforma.Simulacao.Modelo in 'Simulacao\Reforma.Simulacao.Modelo.pas',
  Reforma.View.Validacao in 'View\Reforma.View.Validacao.pas',
  Reforma.View.Geometria in 'View\Reforma.View.Geometria.pas',
  Reforma.View.Estilo in 'View\Reforma.View.Estilo.pas',
  Reforma.View.Hospedeira in 'View\Reforma.View.Hospedeira.pas',
  Reforma.View.Comparativo in 'View\Reforma.View.Comparativo.pas' {frameComparativo: TFrame},
  Reforma.View.Futura in 'View\Reforma.View.Futura.pas' {frameFutura: TFrame},
  Reforma.View.FuturaGrid in 'View\Reforma.View.FuturaGrid.pas' {frameFuturaGrid: TFrame},
  Reforma.Simulacao.Convert in 'Simulacao\Reforma.Simulacao.Convert.pas',
  Reforma.View.CalculoConvert in 'View\Reforma.View.CalculoConvert.pas',
  Reforma.Plugin in 'Plugin\Reforma.Plugin.pas';

// Estilo (skin) do sistema, o mesmo VCLStyles.res do exe; Reforma.View.Estilo o ativa pelo nome que o host informa.
{$R 'VCLStyles.res'}

exports
  fReformaVersaoContrato,
  pReformaInicializar,
  fReformaAbaVisivel,
  fReformaCriarAba2,
  fReformaCriarAba3,
  fReformaCriarAba3Grid,
  fReformaCriarAba4,
  fReformaCriarAba4Grid,
  pReformaCarregar,
  pReformaEntrarAba,
  pReformaAtualizarAtual,
  pReformaConfirmarEdicao,
  pReformaFinalizar,
  fReformaPendente,
  pReformaGravar,
  pReformaDescartar,
  pReformaAbrirConvert,
  fReformaConvertDisponivel,
  fReformaPrepararBanco,
  fReformaAssinaturaContrato;

begin
  // O DevExpress registra os "look and feel" so quando dxInitialize roda; num exe isso e feito
  // pelo proprio projeto, numa DLL tem que ser explicito (sem isso TcxGroupBox estoura no
  // GetContainerBorderWidth). dxCore finaliza sozinho quando a DLL descarrega.
  dxInitialize;
end.