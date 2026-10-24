library TintaGlobalColor;

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
  SysUtils,
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  untLibTintaGlobalColor in '..\..\..\..\..\LibTintas\libTintaGlobalColor\untLibTintaGlobalColor.pas',
  untTipoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoTinta.pas',
  untAbstractLibTinta in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractLibTinta.pas',
  untAbstractLibTintaImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractLibTintaImobiliaria.pas',
  untILibTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untILibTinta.pas',
  untIConfTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConfTinta.pas',
  untIAutcomTintaWrapper in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIAutcomTintaWrapper.pas',
  untIDataSet in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIDataSet.pas',
  untAbstractFormula in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractFormula.pas',
  untAbstractFormulaImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractFormulaImobiliaria.pas',
  untAbstractDigTintaImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractDigTintaImobiliaria.pas',
  untAbstractDigTintaIndustrial in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractDigTintaIndustrial.pas' {frmAbstractDigTintaIndustrial},
  untColorante in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untColorante.pas',
  untStrUtils in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untStrUtils.pas',
  untVariantUtils in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untVariantUtils.pas',
  untFloatUtils in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untFloatUtils.pas',
  untAutcomTintaFactory in '..\..\..\..\..\LibTintas\libTintasComum\Factorys\untAutcomTintaFactory.pas',
  untICalculadorFormula in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICalculadorFormula.pas',
  untAbstractCalculadorFormulaImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractCalculadorFormulaImobiliaria.pas',
  untICalculadorFormulaImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICalculadorFormulaImobiliaria.pas',
  untFormulaImobiliariaGlobalColor in '..\..\..\..\..\LibTintas\libTintaGlobalColor\untFormulaImobiliariaGlobalColor.pas',
  untTintadeMaquinaWrapperGlobalColor in '..\..\..\..\..\LibTintas\libTintaGlobalColor\untTintadeMaquinaWrapperGlobalColor.pas',
  untIConfiguradorConsulta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConfiguradorConsulta.pas',
  untITintadeMaquinaWrapper in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintadeMaquinaWrapper.pas',
  untAbstractTintadeMaquinaWrapper in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractTintadeMaquinaWrapper.pas',
  untIConsultaCompTintaNovaConfigurador in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConsultaCompTintaNovaConfigurador.pas',
  untAbstractCalculadorPrecoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractCalculadorPrecoTinta.pas',
  untIConsultaComp in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConsultaComp.pas',
  untIConsultaTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConsultaTinta.pas',
  untIConsulta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConsulta.pas',
  untICalculadorPrecoTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICalculadorPrecoTinta.pas',
  untIDigDadosTintometricos in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIDigDadosTintometricos.pas',
  untDigDadosTintometricosImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untDigDadosTintometricosImobiliaria.pas',
  untAbstractDigDadosTintometricos in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractDigDadosTintometricos.pas',
  untGTinForTipos in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untGTinForTipos.pas',
  untIDicionario in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIDicionario.pas',
  untUltConsultas in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untUltConsultas.pas',
  untFuncoesGenerica in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untFuncoesGenerica.pas',
  untAbstractConsultaComp in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractConsultaComp.pas',
  untIAuttinMenuItem in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIAuttinMenuItem.pas',
  untGenericAuttinMenuItem in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericAuttinMenuItem.pas',
  untIGravando in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIGravando.pas',
  untStatusGravando in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untStatusGravando.pas',
  untIAuttinWrapper in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIAuttinWrapper.pas',
  untIGravandoExecucaoNome in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIGravandoExecucaoNome.pas',
  untIGravandoExecucao in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIGravandoExecucao.pas',
  untAbstractCriadorTabela in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractCriadorTabela.pas',
  untCriadorTabelas in '..\..\..\..\..\LibTintas\libTintasComum\Factorys\untCriadorTabelas.pas',
  untIConfiguradorTinta in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untIConfiguradorTinta.pas',
  untConfiguradorGlobalColor in '..\..\..\..\..\LibTintas\libTintaGlobalColor\untConfiguradorGlobalColor.pas',
  untLibTintaFactory in '..\..\..\..\..\LibTintas\libTintasComum\Factorys\untLibTintaFactory.pas',
  untAbstractConfiguradorTinta in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractConfiguradorTinta.pas',
  untICadLibTintas in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICadLibTintas.pas',
  untConsultaCadastro in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untConsultaCadastro.pas',
  untILibTintaControleVisual in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untILibTintaControleVisual.pas',
  untILibTintaControleVisualPropriedade in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untILibTintaControleVisualPropriedade.pas',
  untAbstractLibTintaControleVisual in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractLibTintaControleVisual.pas',
  untGenericLibTintaControleVisualPropriedade in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericLibTintaControleVisualPropriedade.pas',
  untGenericLibTintaControleVisual in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericLibTintaControleVisual.pas',
  untGenericLibTintaControleVisualLabel in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untGenericLibTintaControleVisualLabel.pas',
  untGenericLibTintaControleVisualWinControl in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericLibTintaControleVisualWinControl.pas',
  untAbstractLibTintaControleVisualEvento in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractLibTintaControleVisualEvento.pas',
  untGenericLibTintaControleVisualDBEditFocus in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untGenericLibTintaControleVisualDBEditFocus.pas',
  untGenericLibTintaControleVisualEditFocus in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untGenericLibTintaControleVisualEditFocus.pas',
  untLibTintaControleVisualImplementacao in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untLibTintaControleVisualImplementacao.pas',
  untGenericLibTintaControleVisualDBCheckBox in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untGenericLibTintaControleVisualDBCheckBox.pas',
  untAbstractCadastro in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untAbstractCadastro.pas',
  untGravandoVazio in '..\..\..\..\..\LibTintas\libTintasComum\Comuns\untGravandoVazio.pas',
  untISaldosColorantes in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untISaldosColorantes.pas',
  untGenericSaldosColorantes in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericSaldosColorantes.pas',
  untIMultiSelectLocalizador in '..\..\..\..\..\LibTintas\libTintasComum\MultiSelectLocalizador\untIMultiSelectLocalizador.pas',
  untMultiSelectLocalizador in '..\..\..\..\..\LibTintas\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizador.pas',
  untMultiSelectLocalizadorFactory in '..\..\..\..\..\LibTintas\libTintasComum\MultiSelectLocalizador\untMultiSelectLocalizadorFactory.pas',
  untGlobalColorMultiSelectLocalizador in '..\..\..\..\..\LibTintas\libTintaGlobalColor\untGlobalColorMultiSelectLocalizador.pas',
  untTipoCadastro in '..\..\..\..\..\LibTintas\libTintasComum\Tipos\untTipoCadastro.pas',
  untITintaDeMaquina in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquina.pas',
  untITintaDeMaquinaComponente in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquinaComponente.pas',
  untITintaDeMaquinaComponenteComparer in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untITintaDeMaquinaComponenteComparer.pas',
  untTintaDeMaquinaComponenteTipo in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untTintaDeMaquinaComponenteTipo.pas',
  untGenericTintaDeMaquina in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericTintaDeMaquina.pas',
  untInterfacedObjectNoCount in '..\..\..\..\..\LibTintas\libTintasComum\FuncoesCentralizadas\InterfacedObjectNoCount\untInterfacedObjectNoCount.pas',
  untTintaDeMaquinaComponenteComparerColorante in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerColorante.pas',
  untGenericTintaDeMaquinaComponente in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untGenericTintaDeMaquinaComponente.pas',
  untTintaDeMaquinaComponenteComparerBaseImobiliaria in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untTintaDeMaquinaComponenteComparerBaseImobiliaria.pas',
  untBaseAutomotiva in '..\..\..\..\..\LibTintas\libTintasComum\Genericos\untBaseAutomotiva.pas',
  untICalculadorFatVendasLibTintas in '..\..\..\..\..\LibTintas\libTintasComum\Interfaces\untICalculadorFatVendasLibTintas.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas';

function GetTintadeMaquina(const autcomTintaWrapper: IAutcomTintaWrapper): ILibTinta; stdcall;
  begin
    TAutcomTintaFactory.Registrar(autcomTintaWrapper);
    TLibTintaFactory.Registrar(TLibTintaGlobalColor.Create());
    Result := TLibTintaFactory.GetLibTinta as ILibTinta;
  end;

exports
  GetTintadeMaquina;

begin
  FormatSettings := TFormatSettings.Create('pt-BR');
end.
