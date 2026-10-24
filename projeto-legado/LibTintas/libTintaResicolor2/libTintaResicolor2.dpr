library libTintaResicolor2;

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
  Windows,
  untLibTintaResicolor2 in 'untLibTintaResicolor2.pas',
  untTipoTinta in '..\libTintasComum\Tipos\untTipoTinta.pas',
  untAbstractLibTinta in '..\libTintasComum\Genericos\untAbstractLibTinta.pas',
  untAbstractLibTintaImobiliaria in '..\libTintasComum\Genericos\untAbstractLibTintaImobiliaria.pas',
  untILibTinta in '..\libTintasComum\Interfaces\untILibTinta.pas',
  untIConfTinta in '..\libTintasComum\Interfaces\untIConfTinta.pas',
  untIAutcomTintaWrapper in '..\libTintasComum\Interfaces\untIAutcomTintaWrapper.pas',
  untIDataSet in '..\libTintasComum\Interfaces\untIDataSet.pas',
  untAbstractFormula in '..\libTintasComum\Genericos\untAbstractFormula.pas',
  untAbstractFormulaImobiliaria in '..\libTintasComum\Genericos\untAbstractFormulaImobiliaria.pas',
  untColorante in '..\libTintasComum\Genericos\untColorante.pas',
  untStrUtils in '..\libTintasComum\Comuns\untStrUtils.pas',
  untVariantUtils in '..\libTintasComum\Comuns\untVariantUtils.pas',
  untFloatUtils in '..\libTintasComum\Comuns\untFloatUtils.pas',
  untAutcomTintaFactory in '..\libTintasComum\Factorys\untAutcomTintaFactory.pas',
  untICalculadorFormula in '..\libTintasComum\Interfaces\untICalculadorFormula.pas',
  untAbstractCalculadorFormulaImobiliaria in '..\libTintasComum\Genericos\untAbstractCalculadorFormulaImobiliaria.pas',
  untICalculadorFormulaImobiliaria in '..\libTintasComum\Interfaces\untICalculadorFormulaImobiliaria.pas',
  untFormulaImobiliariaResicolor2 in 'untFormulaImobiliariaResicolor2.pas',
  untTintadeMaquinaWrapperResicolor2 in 'untTintadeMaquinaWrapperResicolor2.pas',
  untIConfiguradorConsulta in '..\libTintasComum\Interfaces\untIConfiguradorConsulta.pas',
  untITintadeMaquinaWrapper in '..\libTintasComum\Interfaces\untITintadeMaquinaWrapper.pas',
  untAbstractTintadeMaquinaWrapper in '..\libTintasComum\Genericos\untAbstractTintadeMaquinaWrapper.pas',
  untIConsultaCompTintaNovaConfigurador in '..\libTintasComum\Interfaces\untIConsultaCompTintaNovaConfigurador.pas',
  untConsultaCompResicolor2 in 'untConsultaCompResicolor2.pas',
  untAbstractCalculadorPrecoTinta in '..\libTintasComum\Genericos\untAbstractCalculadorPrecoTinta.pas',
  untIConsultaComp in '..\libTintasComum\Interfaces\untIConsultaComp.pas',
  untIConsultaTinta in '..\libTintasComum\Interfaces\untIConsultaTinta.pas',
  untIConsulta in '..\libTintasComum\Interfaces\untIConsulta.pas',
  untICalculadorPrecoTinta in '..\libTintasComum\Interfaces\untICalculadorPrecoTinta.pas',
  untIDigDadosTintometricos in '..\libTintasComum\Interfaces\untIDigDadosTintometricos.pas',
  untDigDadosTintometricosImobiliaria in '..\libTintasComum\Genericos\untDigDadosTintometricosImobiliaria.pas',
  untAbstractDigDadosTintometricos in '..\libTintasComum\Genericos\untAbstractDigDadosTintometricos.pas',
  untGTinForTipos in '..\libTintasComum\Tipos\untGTinForTipos.pas',
  untIDicionario in '..\libTintasComum\Interfaces\untIDicionario.pas',
  untPai in '..\libTintasComum\Genericos\untPai.pas' {frmPai},
  untUltConsultas in '..\libTintasComum\Comuns\untUltConsultas.pas',
  untFuncoesGenerica in '..\libTintasComum\Genericos\untFuncoesGenerica.pas',
  untAbstractDigTintaImobiliaria in '..\libTintasComum\Genericos\untAbstractDigTintaImobiliaria.pas' {frmAbstractDigTintaImobiliaria},
  untFormulacaoImobiliaria in '..\libTintasComum\Genericos\untFormulacaoImobiliaria.pas' {frmFormulacaoImobiliaria},
  untAbstractConsultaComp in '..\libTintasComum\Genericos\untAbstractConsultaComp.pas',
  untIAuttinMenuItem in '..\libTintasComum\Interfaces\untIAuttinMenuItem.pas',
  untGenericAuttinMenuItem in '..\libTintasComum\Genericos\untGenericAuttinMenuItem.pas',
  untAuttinMenuItemResicolor2 in 'untAuttinMenuItemResicolor2.pas',
  untIGravando in '..\libTintasComum\Interfaces\untIGravando.pas',
  untStatusGravando in '..\libTintasComum\Interfaces\untStatusGravando.pas',
  untIAuttinWrapper in '..\libTintasComum\Interfaces\untIAuttinWrapper.pas',
  untIGravandoExecucaoNome in '..\libTintasComum\Interfaces\untIGravandoExecucaoNome.pas',
  untIGravandoExecucao in '..\libTintasComum\Interfaces\untIGravandoExecucao.pas',
  untAbstractGravandoExecucaoResicolor2 in 'untAbstractGravandoExecucaoResicolor2.pas',
  untGravandoExecucaoResicolor2Cores in 'untGravandoExecucaoResicolor2Cores.pas',
  untGravandoExecucaoResicolor2Colorantes in 'untGravandoExecucaoResicolor2Colorantes.pas',
  untGravandoExecucaoResicolor2Bases in 'untGravandoExecucaoResicolor2Bases.pas',
  untAbstractCriadorTabela in '..\libTintasComum\Genericos\untAbstractCriadorTabela.pas',
  untCriadorTabelas in '..\libTintasComum\Factorys\untCriadorTabelas.pas',
  untIConfiguradorTinta in '..\libTintasComum\Interfaces\untIConfiguradorTinta.pas',
  untConfiguradorResicolor2 in 'untConfiguradorResicolor2.pas',
  untLibTintaFactory in '..\libTintasComum\Factorys\untLibTintaFactory.pas',
  untAbstractConfiguradorTinta in '..\libTintasComum\Genericos\untAbstractConfiguradorTinta.pas',
  untGravandoExecucaoResicolor2NovasFormulas in 'untGravandoExecucaoResicolor2NovasFormulas.pas',
  untICadLibTintas in '..\libTintasComum\Interfaces\untICadLibTintas.pas',
  untCadastroBasesResicolor2 in 'untCadastroBasesResicolor2.pas',
  untConsultaCadastro in '..\libTintasComum\Genericos\untConsultaCadastro.pas',
  untConsultaCadastroBaseResicolor2 in 'untConsultaCadastroBaseResicolor2.pas',
  untILibTintaControleVisual in '..\libTintasComum\Interfaces\untILibTintaControleVisual.pas',
  untILibTintaControleVisualPropriedade in '..\libTintasComum\Interfaces\untILibTintaControleVisualPropriedade.pas',
  untAbstractLibTintaControleVisual in '..\libTintasComum\Genericos\untAbstractLibTintaControleVisual.pas',
  untGenericLibTintaControleVisualPropriedade in '..\libTintasComum\Genericos\untGenericLibTintaControleVisualPropriedade.pas',
  untGenericLibTintaControleVisual in '..\libTintasComum\Genericos\untGenericLibTintaControleVisual.pas',
  untGenericLibTintaControleVisualLabel in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualLabel.pas',
  untGenericLibTintaControleVisualWinControl in '..\libTintasComum\Genericos\untGenericLibTintaControleVisualWinControl.pas',
  untAbstractLibTintaControleVisualEvento in '..\libTintasComum\Genericos\untAbstractLibTintaControleVisualEvento.pas',
  untGenericLibTintaControleVisualDBEditFocus in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualDBEditFocus.pas',
  untGenericLibTintaControleVisualEditFocus in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualEditFocus.pas',
  untLibTintaControleVisualImplementacao in '..\libTintasComum\Genericos\untLibTintaControleVisualImplementacao.pas',
  untDbeCodUniKeyPress in '..\libTintasComum\Eventos\untDbeCodUniKeyPress.pas',
  untDbePesquisaItemKeyPress in '..\libTintasComum\Eventos\untDbePesquisaItemKeyPress.pas',
  untBtnRestaurarPrecoEvento in '..\libTintasComum\Eventos\untBtnRestaurarPrecoEvento.pas',
  untCadastroColorantesResicolor2 in 'untCadastroColorantesResicolor2.pas',
  untConsultaCadastroColoranteResicolor2 in 'untConsultaCadastroColoranteResicolor2.pas',
  untCadastroNovasFormulasResicolor2 in 'untCadastroNovasFormulasResicolor2.pas',
  untGenericLibTintaControleVisualDBCheckBox in '..\libTintasComum\Comuns\untGenericLibTintaControleVisualDBCheckBox.pas',
  untAbstractCadastro in '..\libTintasComum\Genericos\untAbstractCadastro.pas',
  untConsultaCadastroNovasFormulasResicolor2 in 'untConsultaCadastroNovasFormulasResicolor2.pas',
  untDbeCodColKeyPressResicolor2 in 'untDbeCodColKeyPressResicolor2.pas',
  untDbeCodProKeyPressNovasFormulasResicolor2 in 'untDbeCodProKeyPressNovasFormulasResicolor2.pas',
  untGravandoVazio in '..\libTintasComum\Comuns\untGravandoVazio.pas',
  untISaldosColorantes in '..\libTintasComum\Interfaces\untISaldosColorantes.pas',
  untGenericSaldosColorantes in '..\libTintasComum\Genericos\untGenericSaldosColorantes.pas',
  untIMultiSelectLocalizador in '..\libTintasComum\MultiSelectLocalizador\untIMultiSelectLocalizador.pas',
  untMultiSelectLocalizador in '..\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizador.pas',
  untMultiSelectLocalizadorFactory in '..\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizadorFactory.pas',
  untResicolor2MultiSelectLocalizador in 'untResicolor2MultiSelectLocalizador.pas',
  untTipoCadastro in '..\libTintasComum\Tipos\untTipoCadastro.pas',
  untITintaDeMaquina in '..\libTintasComum\Interfaces\untITintaDeMaquina.pas',
  untITintaDeMaquinaComponente in '..\libTintasComum\Interfaces\untITintaDeMaquinaComponente.pas',
  untITintaDeMaquinaComponenteComparer in '..\libTintasComum\Interfaces\untITintaDeMaquinaComponenteComparer.pas',
  untTintaDeMaquinaComponenteTipo in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteTipo.pas',
  untGenericTintaDeMaquina in '..\libTintasComum\Genericos\untGenericTintaDeMaquina.pas',
  untInterfacedObjectNoCount in '..\libTintasComum\FuncoesCentralizadas\InterfacedObjectNoCount\untInterfacedObjectNoCount.pas',
  untTintaDeMaquinaComponenteComparerColorante in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerColorante.pas',
  untGenericTintaDeMaquinaComponente in '..\libTintasComum\Genericos\untGenericTintaDeMaquinaComponente.pas',
  untTintaDeMaquinaComponenteComparerBaseImobiliaria in '..\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerBaseImobiliaria.pas',
  untBaseAutomotiva in '..\libTintasComum\Genericos\untBaseAutomotiva.pas',
  untDbeDesProKeyPressNovasFormulasResicolor2 in 'untDbeDesProKeyPressNovasFormulasResicolor2.pas',
  untICalculadorFatVendasLibTintas in '..\libTintasComum\Interfaces\untICalculadorFatVendasLibTintas.pas',
  untAbstractDigTintaIndustrial in '..\libTintasComum\Genericos\untAbstractDigTintaIndustrial.pas' {frmAbstractDigTintaIndustrial},
  untTypesSistema in '..\..\padra_atualizado\fontes\genericos\untTypesSistema.pas',
  untIDefinicaoTxt in '..\libTintasComum\Interfaces\untIDefinicaoTxt.pas',
  untDefinicaoTxtFormato in '..\libTintasComum\Genericos\untDefinicaoTxtFormato.pas',
  untDefinicaoTxtCharacterSet in '..\libTintasComum\Genericos\untDefinicaoTxtCharacterSet.pas',
  untADOFactory in '..\libTintasComum\Genericos\untADOFactory.pas',
  untDefinicaoTxtCurrencyPosFormat in '..\libTintasComum\Genericos\untDefinicaoTxtCurrencyPosFormat.pas',
  untIDefinicaoTxtCampo in '..\libTintasComum\Interfaces\untIDefinicaoTxtCampo.pas',
  untDefinicaoTxtCampoTipo in '..\libTintasComum\Genericos\untDefinicaoTxtCampoTipo.pas',
  untDefinicaoTxtCurrencyNegFormat in '..\libTintasComum\Genericos\untDefinicaoTxtCurrencyNegFormat.pas',
  untGenericDefinicaoTxt in '..\libTintasComum\Genericos\untGenericDefinicaoTxt.pas',
  untGenericDefinicaoTxtCampo in '..\libTintasComum\Genericos\untGenericDefinicaoTxtCampo.pas',
  untADOTxtFactory in '..\libTintasComum\Genericos\untADOTxtFactory.pas',
  untDbeLinhaKeyPressResicolor2 in 'untDbeLinhaKeyPressResicolor2.pas',
  untDbeUnidadeKeyPressResicolor2 in 'untDbeUnidadeKeyPressResicolor2.pas',
  untCalculadorFormulaImobiliariaResicolor2 in 'untCalculadorFormulaImobiliariaResicolor2.pas',
  TypesLayoutPedidoCompra in '..\..\padra_atualizado\fontes\genericos\TypesLayoutPedidoCompra.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R VCLStyles.res}

  function GetTintadeMaquina(const autcomTintaWrapper: IAutcomTintaWrapper): ILibTinta; stdcall;
  begin
    TAutcomTintaFactory.Registrar(autcomTintaWrapper);
    TLibTintaFactory.Registrar(TLibTintaResicolor2.Create());
    Result := TLibTintaFactory.GetLibTinta as ILibTinta;
  end;


exports
  GetTintadeMaquina;

begin
end.
