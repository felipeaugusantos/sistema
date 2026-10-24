library libTintaRennerPerformance;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  SysUtils,
  MidasLib,
  dxCore,
  Windows,
  untAuttinMenuItemRennerPerformance in 'untAuttinMenuItemRennerPerformance.pas',
  untTipoTinta in '..\libTintasComum\Tipos\untTipoTinta.pas',
  untGenericAuttinMenuItem in '..\libTintasComum\Genericos\untGenericAuttinMenuItem.pas',
  untIAuttinWrapper in '..\libTintasComum\Interfaces\untIAuttinWrapper.pas',
  untIAuttinMenuItem in '..\libTintasComum\Interfaces\untIAuttinMenuItem.pas',
  untIAutcomTintaWrapper in '..\libTintasComum\Interfaces\untIAutcomTintaWrapper.pas',
  untTipoCadastro in '..\libTintasComum\Tipos\untTipoCadastro.pas',
  untLibTintaFactory in '..\libTintasComum\Factorys\untLibTintaFactory.pas',
  untAbstractLibTinta in '..\libTintasComum\Genericos\untAbstractLibTinta.pas',
  untILibTinta in '..\libTintasComum\Interfaces\untILibTinta.pas',
  untGTinForTipos in '..\libTintasComum\Tipos\untGTinForTipos.pas',
  untIDigDadosTintometricos in '..\libTintasComum\Interfaces\untIDigDadosTintometricos.pas',
  untConfiguradorRennerPerformance in 'untConfiguradorRennerPerformance.pas',
  untAbstractConfiguradorTinta in '..\libTintasComum\Genericos\untAbstractConfiguradorTinta.pas',
  untIGravandoExecucaoNome in '..\libTintasComum\Interfaces\untIGravandoExecucaoNome.pas',
  untIGravandoExecucao in '..\libTintasComum\Interfaces\untIGravandoExecucao.pas',
  untIGravando in '..\libTintasComum\Interfaces\untIGravando.pas',
  untStatusGravando in '..\libTintasComum\Interfaces\untStatusGravando.pas',
  untIConfiguradorTinta in '..\libTintasComum\Interfaces\untIConfiguradorTinta.pas',
  untICadLibTintas in '..\libTintasComum\Interfaces\untICadLibTintas.pas',
  untIConsulta in '..\libTintasComum\Interfaces\untIConsulta.pas',
  untIDataSet in '..\libTintasComum\Interfaces\untIDataSet.pas',
  untIConfTinta in '..\libTintasComum\Interfaces\untIConfTinta.pas',
  untIConsultaTinta in '..\libTintasComum\Interfaces\untIConsultaTinta.pas',
  untITintadeMaquinaWrapper in '..\libTintasComum\Interfaces\untITintadeMaquinaWrapper.pas',
  untIConfiguradorConsulta in '..\libTintasComum\Interfaces\untIConfiguradorConsulta.pas',
  untIConsultaComp in '..\libTintasComum\Interfaces\untIConsultaComp.pas',
  untIConsultaCompTintaNovaConfigurador in '..\libTintasComum\Interfaces\untIConsultaCompTintaNovaConfigurador.pas',
  untIDicionario in '..\libTintasComum\Interfaces\untIDicionario.pas',
  untAbstractGravandoExecucaoRennerPerformance in 'untAbstractGravandoExecucaoRennerPerformance.pas',
  untStrUtils in '..\libTintasComum\Comuns\untStrUtils.pas',
  untAbstractCriadorTabela in '..\libTintasComum\Genericos\untAbstractCriadorTabela.pas',
  untCriadorTabelas in '..\libTintasComum\Factorys\untCriadorTabelas.pas',
  untFuncoesGenerica in '..\libTintasComum\Genericos\untFuncoesGenerica.pas',
  untISaldosColorantes in '..\libTintasComum\Interfaces\untISaldosColorantes.pas',
  untFloatUtils in '..\libTintasComum\Comuns\untFloatUtils.pas',
  untGravandoExecucaoRennerPerformanceNovasFormulas in 'untGravandoExecucaoRennerPerformanceNovasFormulas.pas',
  untGravandoVazio in '..\libTintasComum\Comuns\untGravandoVazio.pas',
  untTintadeMaquinaWrapperRennerPerformance in 'untTintadeMaquinaWrapperRennerPerformance.pas',
  untAbstractTintadeMaquinaWrapper in '..\libTintasComum\Genericos\untAbstractTintadeMaquinaWrapper.pas',
  untVariantUtils in '..\libTintasComum\Comuns\untVariantUtils.pas',
  untConsultaCompRennerPerformance in 'untConsultaCompRennerPerformance.pas',
  untAbstractConsultaComp in '..\libTintasComum\Genericos\untAbstractConsultaComp.pas',
  untCadastroBasesRennerPerformance in 'untCadastroBasesRennerPerformance.pas',
  untCadastroNovasFormulasRennerPerformance in 'untCadastroNovasFormulasRennerPerformance.pas',
  untGenericLibTintaControleVisual in '..\libTintasComum\Genericos\untGenericLibTintaControleVisual.pas',
  untAbstractLibTintaControleVisualEvento in '..\libTintasComum\Genericos\untAbstractLibTintaControleVisualEvento.pas',
  untGenericLibTintaControleVisualLabel in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualLabel.pas',
  untDbePesquisaItemKeyPress in '..\libTintasComum\Eventos\untDbePesquisaItemKeyPress.pas',
  untGenericLibTintaControleVisualDBEditFocus in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualDBEditFocus.pas',
  untGenericLibTintaControleVisualEditFocus in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualEditFocus.pas',
  untLibTintaControleVisualImplementacao in '..\libTintasComum\Genericos\untLibTintaControleVisualImplementacao.pas',
  untConsultaCadastroBaseRennerPerformance in 'untConsultaCadastroBaseRennerPerformance.pas',
  untConsultaCadastro in '..\libTintasComum\Genericos\untConsultaCadastro.pas',
  untGenericLibTintaControleVisualPropriedade in '..\libTintasComum\Genericos\untGenericLibTintaControleVisualPropriedade.pas',
  untAbstractLibTintaControleVisual in '..\libTintasComum\Genericos\untAbstractLibTintaControleVisual.pas',
  untILibTintaControleVisual in '..\libTintasComum\Interfaces\untILibTintaControleVisual.pas',
  untILibTintaControleVisualPropriedade in '..\libTintasComum\Interfaces\untILibTintaControleVisualPropriedade.pas',
  untAutcomTintaFactory in '..\libTintasComum\Factorys\untAutcomTintaFactory.pas',
  untBtnRestaurarPrecoEvento in '..\libTintasComum\Eventos\untBtnRestaurarPrecoEvento.pas',
  untAbstractCadastro in '..\libTintasComum\Genericos\untAbstractCadastro.pas',
  untGenericLibTintaControleVisualWinControl in '..\libTintasComum\Genericos\untGenericLibTintaControleVisualWinControl.pas',
  untGenericLibTintaControleVisualDBCheckBox in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualDBCheckBox.pas',
  untConsultaCadastroNovasFormulasRennerPerformance in 'untConsultaCadastroNovasFormulasRennerPerformance.pas',
  untRennerPerformanceMultiSelectLocalizador in 'untRennerPerformanceMultiSelectLocalizador.pas',
  untMultiSelectLocalizador in '..\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizador.pas',
  untMultiSelectLocalizadorFactory in '..\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizadorFactory.pas',
  untIMultiSelectLocalizador in '..\libTintasComum\MultiSelectLocalizador\untIMultiSelectLocalizador.pas',
  untAbstractFormulaAutomotiva in '..\libTintasComum\Genericos\untAbstractFormulaAutomotiva.pas',
  untITintaDeMaquinaComponente in '..\libTintasComum\Interfaces\untITintaDeMaquinaComponente.pas',
  untICalculadorFormulaAutomotiva in '..\libTintasComum\Interfaces\untICalculadorFormulaAutomotiva.pas',
  untTipoEmbalagem in '..\libTintasComum\Tipos\untTipoEmbalagem.pas',
  untModoVenda in '..\libTintasComum\Tipos\untModoVenda.pas',
  untBaseAutomotiva in '..\libTintasComum\Genericos\untBaseAutomotiva.pas',
  untFormulaAutomotivaRennerPerformance in 'untFormulaAutomotivaRennerPerformance.pas',
  untAbstractCalculadorFormulaAutomotiva in '..\libTintasComum\Genericos\untAbstractCalculadorFormulaAutomotiva.pas',
  untTintaDeMaquinaComponenteComparerBaseAutomotiva in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerBaseAutomotiva.pas',
  untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.pas',
  untITintaDeMaquinaComponenteComparer in '..\libTintasComum\Interfaces\untITintaDeMaquinaComponenteComparer.pas',
  untAbstractFormula in '..\libTintasComum\Genericos\untAbstractFormula.pas',
  untColorante in '..\libTintasComum\Genericos\untColorante.pas',
  untICalculadorFormula in '..\libTintasComum\Interfaces\untICalculadorFormula.pas',
  untGenericTintaDeMaquina in '..\libTintasComum\Genericos\untGenericTintaDeMaquina.pas',
  untITintaDeMaquina in '..\libTintasComum\Interfaces\untITintaDeMaquina.pas',
  untTintaDeMaquinaComponenteTipo in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteTipo.pas',
  untInterfacedObjectNoCount in '..\libTintasComum\FuncoesCentralizadas\InterfacedObjectNoCount\untInterfacedObjectNoCount.pas',
  untGenericTintaDeMaquinaComponente in '..\libTintasComum\Genericos\untGenericTintaDeMaquinaComponente.pas',
  untLibTintaRennerPerformance in 'untLibTintaRennerPerformance.pas',
  untAbstractLibTintaAutomotiva in '..\libTintasComum\Genericos\untAbstractLibTintaAutomotiva.pas',
  untICalculadorPrecoTinta in '..\libTintasComum\Interfaces\untICalculadorPrecoTinta.pas',
  untDigDadosTintometricosAutomotiva in '..\libTintasComum\Genericos\untDigDadosTintometricosAutomotiva.pas',
  untPai in '..\libTintasComum\Genericos\untPai.pas' {frmPai},
  untAbstractDigTintaAutomotiva in '..\libTintasComum\Genericos\untAbstractDigTintaAutomotiva.pas' {frmAbstractDigTintaAutomotiva},
  untAbstractDigDadosTintometricos in '..\libTintasComum\Genericos\untAbstractDigDadosTintometricos.pas',
  untGenericSaldosColorantes in '..\libTintasComum\Genericos\untGenericSaldosColorantes.pas',
  untAbstractCalculadorPrecoTinta in '..\libTintasComum\Genericos\untAbstractCalculadorPrecoTinta.pas',
  untUltConsultas in '..\libTintasComum\Comuns\untUltConsultas.pas',
  untFormulacaoAutomotiva in '..\libTintasComum\Genericos\untFormulacaoAutomotiva.pas' {frmFormulacaoAutomotiva},
  untICalculadorFatVendasLibTintas in '..\libTintasComum\Interfaces\untICalculadorFatVendasLibTintas.pas',
  untIDefinicaoTxt in '..\libTintasComum\Interfaces\untIDefinicaoTxt.pas',
  untDefinicaoTxtFormato in '..\libTintasComum\Genericos\untDefinicaoTxtFormato.pas',
  untDefinicaoTxtCharacterSet in '..\libTintasComum\Genericos\untDefinicaoTxtCharacterSet.pas',
  untDefinicaoTxtCurrencyPosFormat in '..\libTintasComum\Genericos\untDefinicaoTxtCurrencyPosFormat.pas',
  untIDefinicaoTxtCampo in '..\libTintasComum\Interfaces\untIDefinicaoTxtCampo.pas',
  untDefinicaoTxtCampoTipo in '..\libTintasComum\Genericos\untDefinicaoTxtCampoTipo.pas',
  untDefinicaoTxtCurrencyNegFormat in '..\libTintasComum\Genericos\untDefinicaoTxtCurrencyNegFormat.pas',
  untGenericDefinicaoTxt in '..\libTintasComum\Genericos\untGenericDefinicaoTxt.pas',
  untGenericDefinicaoTxtCampo in '..\libTintasComum\Genericos\untGenericDefinicaoTxtCampo.pas',
  untADOTxtFactory in '..\libTintasComum\Genericos\untADOTxtFactory.pas',
  untADOFactory in '..\libTintasComum\Genericos\untADOFactory.pas',
  untAbstractTintaSQLServer in '..\libTintasComum\Genericos\untAbstractTintaSQLServer.pas',
  untCadastroColorantesRennerPerformance in 'untCadastroColorantesRennerPerformance.pas',
  untConsultaCadastroColoranteRennerPerformance in 'untConsultaCadastroColoranteRennerPerformance.pas',
  untDbeCodProKeyPressNovasFormulasRennerPerformance in 'untDbeCodProKeyPressNovasFormulasRennerPerformance.pas',
  untDbeCodColKeyPressRennerPerformance in 'untDbeCodColKeyPressRennerPerformance.pas',
  untTypesSistema in '..\..\padra_atualizado\fontes\genericos\untTypesSistema.pas',
  untGravandoExecucaoRennerPerformanceBases in 'untGravandoExecucaoRennerPerformanceBases.pas',
  untGravandoExecucaoRennerPerformanceCores in 'untGravandoExecucaoRennerPerformanceCores.pas',
  untGravandoExecucaoRennerPerformanceColorantes in 'untGravandoExecucaoRennerPerformanceColorantes.pas',
  TypesLayoutPedidoCompra in '..\..\padra_atualizado\fontes\genericos\TypesLayoutPedidoCompra.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

  function GetTintadeMaquina(const autcomTintaWrapper: IAutcomTintaWrapper): ILibTinta; stdcall;
  begin
    TAutcomTintaFactory.Registrar(autcomTintaWrapper);
    TLibTintaFactory.Registrar(TLibTintaRennerPerformance.Create());
    Result := TLibTintaFactory.GetLibTinta as ILibTinta;
  end;


exports
  dxInitialize,
  dxFinalize,
  GetTintadeMaquina;
begin
end.
