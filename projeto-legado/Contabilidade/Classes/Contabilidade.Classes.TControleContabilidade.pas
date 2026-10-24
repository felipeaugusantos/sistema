unit Contabilidade.Classes.TControleContabilidade;

interface

uses Contabilidade.Classes.TMenuContabilidade, Vcl.Menus,
  Contabilidade.Model.TDadosImportacaoContabil, System.Generics.Collections,
  Classes, advMenus, untConsultas, cxEdit, untCfgRepositorio, Uni,
  UniDataSetProvider, UniClientDataSet, untTypesSistema, cxExtEditRepositoryItems,
  cxProgressBar, Controls;

type

  TMenuContabilidade = class
  private
    class procedure pMenuCadastros(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuFechamentos(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuLalurLacs(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuLalurLacsCadastros(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuLalurLacsApuracoes(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuLalurLacsRelatorios(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuExportacaoGeracaoDados(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuImportacoes(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuMovimentacao(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuObrigacoesAcessorias(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuParametros(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuRelatorios(var AMenuContabil:TMenuContabil; const AMenuPai:string; blnKardex: Boolean = True);
    class procedure pMenuImpostoRenda(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuIRLucroPresumido(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuIRLucroPresumidoRelatorios(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuIRLucroPresumidoApuracoes(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pMenuIRLucroReal(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pDesabilitaMenu(AOwner: TComponent; ANomeMenu: string);
    class procedure pHabilitarItemMenu(AOwner: TComponent; ANomeMenu: string; AHabilitar: Boolean) ;
    class function fCfgSisLoc(strCamCfg: String): Variant;
    class procedure pEscondeItemMenuTabela(AOwner: TComponent; const ANomeMenu: string; const ANomeTabela: string);
    // class procedure pMenuImobilizado(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    // class procedure pMenuImobilizadoCadastro(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    // class procedure pMenuImobilizadoRelatorio(var AMenuContabil:TMenuContabil; const AMenuPai:string);
    class procedure pExecutarSpedAncorado(const ANomeExe: String);
  public
    class function Carregar(AMenuContabilidade: TMenuItem; AOwner: TComponent; blnKardex: Boolean = True):boolean ;
    class procedure DesabilitarItemMenu(AOwner: TComponent) ;
    class procedure EsconderItemMenu(AOwner: TComponent) ;
    class procedure MonitorContabil ;

    class procedure pMultLancamentosContabeis(listaLancamentos: TObjectList<TDadosImportacaoContabil>; const AValorTotalLanctos: double; const AdtaLan:TDate; const AstrEmpLan: string);
    ////Eventos ONClick do menu contabil
    class procedure mnuHistoricoPadraoClick(Sender: TObject);
    class procedure mnuPlanoContabilClick(Sender: TObject);
    class procedure mnuTipoDePlanoDeContaContabilClick(Sender: TObject);
    class procedure mnuCadCseClick(Sender: TObject);
    class procedure mnuAbreviacaoContabilProdutosClick(Sender: TObject);
    class procedure mnuNotasExplicativasClick(Sender: TObject);
    class procedure mnuNaturezaDosAjustesClick(Sender: TObject);
    class procedure mnuTipoDaTabelaDinamicaDoEcfClick(Sender: TObject);
    class procedure mnuContasControladasClick(Sender: TObject);
    class procedure mnuTransferenciaSaldosPlanoContasAnteriorClick(Sender: TObject);
    class procedure mnuParametrosContabilizacaoClick(Sender: TObject);
    class procedure mnuCadDefDemonsResultExercClick(Sender: TObject);
    class procedure mnuGerLanConClick(Sender: TObject);
    class procedure mnuManLanConClick(Sender: TObject);
    class procedure mnuLanLotesContabeisClick(Sender: TObject);
    class procedure mnuTransfLancEntreContasClick(Sender: TObject);
    class procedure mnuLancamentosPeriodicosClick(Sender: TObject);
    class procedure mnuLanSalClick(Sender: TObject);
    class procedure mnuLanSalSubClick(Sender: TObject);
    class procedure mnuManutencaoLoteContabilClick(Sender: TObject);
    class procedure mnuECDEscrituracaoContabilDigitalClick(Sender: TObject);
    class procedure mnuConferenciaEstoqueContabilClick(Sender: TObject);
    class procedure mnuFechamentoContabilClick(Sender: TObject);
    class procedure mnuExclusaoFechamentoContabilClick(Sender: TObject);
    class procedure mnuImportacaoContabilClick(Sender: TObject);
    class procedure mnuTipoImobilizadoCClick(Sender: TObject);
    class procedure mnuConfiguracoesLALUR_LACSClick(Sender: TObject);
    class procedure mnuImportacoesPlanoContasClick(Sender: TObject);
    class procedure mnuImportacoesLancamentosContabeisClick(Sender: TObject);
    class procedure mnuImportacoesHistoricoPadraoClick(Sender: TObject);
    class procedure mnuImportacoesSaldoInicialClick(Sender: TObject);
    class procedure mnuImportacoesSaldoInicialSubcontaClick(Sender: TObject);
    class procedure mnuIRLucroPresumidoParamClick(Sender: TObject);
    class procedure mnuIRLucroPresumidoApurCsllClick(Sender: TObject);
    class procedure mnuIRLucroPresumidoApurIrpjClick(Sender: TObject);
    class procedure mnuIRLucroPresumidoRelatorioClick(Sender: TObject);
    class procedure mnuDemonstracaoFluxoCaixaClick(Sender: TObject);
    class procedure mnuNotasExplicativasV2Click(Sender: TObject);
    class procedure mnuDemonstracaoResultadoAbrangenteClick(Sender: TObject);
    class procedure mnuDemonstracaoValorAdicionadoClick(Sender: TObject);
    class procedure mnuDemonstracaoMutacaoPatrimonioLiquidoClick(Sender: TObject);
    class procedure mnuCadImobilizadoClick(Sender: TObject);
    class procedure mnuPlanoContaVinculoPlanoReferencialClick(Sender: TObject);
    class procedure mnuSaldoContasControladasClick(Sender: TObject);
    class procedure mnuApuracaoLucroRealLalurLacsClick(Sender: TObject);
    class procedure mnuApuracaoLucroRealIrpjCsllClick(Sender: TObject);
    class procedure mnuApuracaoLucroRealRelatorioClick(Sender: TObject);
    class procedure mnuECFEscrituracaoContabilFiscalClick(Sender: TObject);
    class procedure mnuFechamentoContabilDiaMesClick(Sender: TObject);
    class procedure mnuExportacaoModeloContabilClick(Sender: TObject);
    class procedure mnuImportacaoModeloContabilClick(Sender: TObject);
  end;

  TCfgRepositorioContabilidade = class
  private
    class function fDigitoPatrimonialLiquidoOK(ACdsCfg: TUniClientDataSet): Boolean;
    class function fRepeteContaReduziadaEcdOK(ACdsCfg: TUniClientDataSet): Boolean;
    class function fValidaPlanoContasFaturamentoOK(ACdsCfg: TUniClientDataSet): Boolean;
    class function fValidaDigPliOK(ACdsCfg: TUniClientDataSet): Boolean;
    class function fValidaDigitoIdentificadorContabilidade(ACdsCfg: TUniClientDataSet): Boolean;
    class function fValida(ACdsCfg: TUniClientDataSet; strCodCfg: string): boolean;
    class function fValidaHisTpl(ACdsCfg: TUniClientDataSet): boolean;
    class function fValidaCFG_CRDSEQ(ACdsCfg: TUniClientDataSet): boolean;
    class function fTemIgual(ACdsCfg: TUniClientDataSet; ArrCfgs: array of string): boolean;
    class procedure pRetPropertiesInterno(strCodCfg: String; var AProperties: Pointer; var intInd: Integer; ACfgRepositorio: Pointer);
    class function fHouveMudancaMascaraContabil(ACdsCfg: TUniClientDataSet):Boolean ;
    class function fMudouSomenteExportacaoParaNao(ACdsCfg: TUniClientDataSet):Boolean ;
    class function fValidarPlanoContasSomenteExportacao(ApgbProgresso: TcxProgressBar):boolean ;
    class function fBuscaCfgSis(const ACdsCfg: TUniClientDataSet; const AValor: string):string ;
    class procedure edtConMascaraContabilPropertiesEditValueChanged(Sender: TObject);
    class function fRetornaPropertiesRepositorio(const ACfg: string; ACfgRepositorio: Pointer; ARepositoryItemClass: TcxEditRepositoryItemClass):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgRepositorio(const ACfg: string; ACfgRepositorio: Pointer):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgALTFIN(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGAPU(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGCOM(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGCUS(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGDES(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGREC(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgMAXHPD(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgPCJUDT(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgPCDEDT(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgADTORD(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgPICORF(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGOUT(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGATI(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgDIGPAS(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
    class function fCustomizePropertyCfgCRDSEQ(const ACfg: string; ACfgRepositorio: Pointer; AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;

    class procedure pbtnOpen_LayoutContabilPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    class function fHouveMudancaMascaraContabilPatrimonioLiquido(ACdsCfg: TUniClientDataSet; const AMascaraContabil:string=''):Boolean ;
    class procedure pRetProperties(strCodCfg: String; var AProperties: Pointer; var intInd: Integer; ACfgRepositorio: Pointer) ;
    class procedure pAdicionaConfiguracoes ;
    class procedure pCfgPCJUDTPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    class procedure pCfgPCDEDTPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    class procedure pCfgADTORDPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    class procedure pCfgPICORFPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    class procedure pCfgCRDSEQPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
                                                 var Error: Boolean);
  public
    class procedure pInicializaParametros(ACfgRepositorio: Pointer) ;
    class function fValidarParametros(ACdsCfg: TUniClientDataSet): boolean ;
  end;

  TProCodContabilidade = class
  private
    class function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
  public
    class procedure pAdicionar(var arrProCod : TarrProCod; var intPosMat: Integer) ;
  end;

  TTraceContabilidade = class
  public
    class procedure pSetQueryEvents(const AQuery: TUniQuery) ;
  end;

  TMostraMensagemErroValidacao = class
  public
    class procedure pMostra(const AdsErros: TUniClientDataset);
  end ;

  TMetodosPlanoDeContasPorEmpresa = class
  public
    class procedure pCarregaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet) ;
    class procedure pSalvaPlanoDeContasPorEmpresa(const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet) ;
  end ;

var
  MascaraContabilAlteradaRepositorio: string ;

implementation

uses System.SysUtils, Winapi.Messages, Winapi.Windows, Vcl.Dialogs, untFuncoesSimples,
     Contabilidade.View.HistoricoPadrao, Contabilidade.View.LancamentoSaldos, Forms,
     Contabilidade.View.ParametrosContabilizacao, Contabilidade.View.PlanoContabil,
     Contabilidade.View.GeracaoLancamentoContabil, Contabilidade.View.ManutencaoLancamentoContabil,
     Contabilidade.View.ConferenciaEstoqueContabil, Contabilidade.Funcoes, Contabilidade.Consultas,
     Contabilidade.View.TipoDePlanoDeContaContabil, Contabilidade.View.FechamentoContabil,
     Contabilidade.View.DefinicoesDRE, Contabilidade.View.Signatarios, Contabilidade.View.FechamentoContabilEstorno,
     Contabilidade.View.ImportacaoContabil, Contabilidade.View.ManutencaoLoteContabil,
     Contabilidade.View.AbreviacaoContabilProdutos, Contabilidade.Classes.TShowModalFormContasPorEmpresa,
     Contabilidade.Interfaces, Contabilidade.View.NotasExplicativas,
     Contabilidade.View.NaturezaDosAjustes, Contabilidade.View.TipoDaTabelaDinamicaDoEcf,
     Contabilidade.View.ConfigLALUR,
     Contabilidade.View.ContasControladas, Contabilidade.View.TransferenciaSaldosPlanoContasAnterior,
     Contabilidade.View.MultLancamentosContabeis, Contabilidade.View.DemonstracaoValorAdicionado,
     Contabilidade.View.DemonstracaoFluxoCaixa, Contabilidade.View.NotasExplicativasV2,
     Contabilidade.View.DemonstracaoResultadoAbrangente,
     Contabilidade.View.DemonstracaoMutacaoPatrimonioLiquido, Contabilidade.View.ImportacaoDadosContabeis,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     untCadTipoImobilizado, untECFMenuDinamico, untConstantes, untUtilMonitor,
     Contabilidade.View.ConfiguracoesImportacaoContabil, untCadImobilizado,
     Contabilidade.View.PlanoContaVinculoPlanoReferencial, Contabilidade.InterfaceTrace,
     Contabilidade.FuncoesFormPai, Contabilidade.View.LogTrace, Contabilidade.View.LancamentosLotesContabeis,
     cxRadioGroup, cxMaskEdit, cxEditRepositoryItems, cxTextEdit, untCfgSistema, cxSpinEdit,
     Contabilidade.View.SaldoContasControladas, Contabilidade.View.ApuracaoLucroRealLalurLacs, cxButtonEdit,
     Contabilidade.View.ConfiguracaoPlanoContasJurosDetalheCTP, Contabilidade.View.ApuracaoLucroRealIrpjCsll,
     EditFocus, Contabilidade.View.ApuracaoLucroRealRelatorio, Contabilidade.View.LancamentosPeriodicos,
     Contabilidade.View.ErrosContabeis, Contabilidade.View.ConfigLucroPresumido,
     Contabilidade.Classes.TParametrosFormContasPorEmpresa,
     Contabilidade.View.ApuracaoLucroPresumido, Contabilidade.Interfaces.SharedLucroPresumido,
     Contabilidade.View.ApuracaoLucroPresumidoRelatorio, Contabilidade.View.LancamentoSaldosSubcontas,
     Contabilidade.OutrosFechamentos.Funcoes,
     Contabilidade.View.ConfiguracaoPisCofinsReceitaFinanceira, Data.Db ,
     Contabilidade.View.TransferenciaLancamentosEntreContas, Contabilidade.View.FechamentoDiaMes,
     Contabilidade.View.ExportacaoModeloContabil, Contabilidade.View.ImportacaoModeloContabil;

const
  cMENUIMOBILIZADO = 'mnuImobilizadoPatrimonio' ;
  PREFIXONOMEPROPREPOSITORIO = 'RepContab' ;

  { TMenuContabilidade }

class function TMenuContabilidade.Carregar(AMenuContabilidade: TMenuItem; AOwner: TComponent; blnKardex: Boolean = True): boolean;
var
  objCarregaMenuCont: TMenuContabil ;
begin
  objCarregaMenuCont := TMenuContabil.Create ;
  try
    objCarregaMenuCont.AdicionarMenuContabil('mnuCtbCadastrosParametros', 'Cadastros', 'mnuCtbCadastrosParametros', Nil, '', True);
    pMenuCadastros(objCarregaMenuCont, 'mnuCtbCadastrosParametros') ;

    objCarregaMenuCont.AdicionarMenuContabil('mnuExpGerDadosContabeis', 'Exportação / Geração de Dados', 'mnuExpGerDadosContabeis', Nil, '', True);
    pMenuExportacaoGeracaoDados(objCarregaMenuCont, 'mnuExpGerDadosContabeis') ;

    objCarregaMenuCont.AdicionarMenuContabil('mnuFechamentosContabeis', 'Fechamentos', 'mnuFechamentosContabeis', Nil, '', True);
    pMenuFechamentos(objCarregaMenuCont, 'mnuFechamentosContabeis');

    // objCarregaMenuCont.AdicionarMenuContabil(cMENUIMOBILIZADO, 'Imobilizado', 'mnuImobilizadoPatrimonio', Nil, '', True);
    // pMenuImobilizado(objCarregaMenuCont, cMENUIMOBILIZADO);

    objCarregaMenuCont.AdicionarMenuContabil('mnuImportacoesContabeis', 'Importações', 'mnuImportacoesContabeis', Nil, '', True);
    pMenuImportacoes(objCarregaMenuCont, 'mnuImportacoesContabeis');

    objCarregaMenuCont.AdicionarMenuContabil('mnuCtbMovimentacaoLancamentos', 'Movimentação / Lançamentos', 'mnuCtbMovimentacaoLancamentos', Nil, '', True);
    pMenuMovimentacao(objCarregaMenuCont, 'mnuCtbMovimentacaoLancamentos') ;

    objCarregaMenuCont.AdicionarMenuContabil('mnuCtbObrigaesAcessrias', 'Obrigações Acessórias', 'mnuCtbObrigaesAcessrias', Nil, '', True);
    pMenuObrigacoesAcessorias(objCarregaMenuCont, 'mnuCtbObrigaesAcessrias') ;

    objCarregaMenuCont.AdicionarMenuContabil('mnuCtbParametros', 'Parâmetros', 'mnuCtbParametros', Nil, '', True);
    pMenuParametros(objCarregaMenuCont, 'mnuCtbParametros') ;

    objCarregaMenuCont.AdicionarMenuContabil('mnuRelatoriosContabeis', 'Relatórios', 'mnuRelatoriosContabeis', Nil, '', True);
    pMenuRelatorios(objCarregaMenuCont, 'mnuRelatoriosContabeis', blnKardex);

    objCarregaMenuCont.AdicionarMenuContabil('mnuImpostoRenda', 'Imposto de Renda', 'mnuImpostoRenda', Nil, '', True);
    pMenuImpostoRenda(objCarregaMenuCont, 'mnuImpostoRenda');

    objCarregaMenuCont.RootMenu := AMenuContabilidade ;
    objCarregaMenuCont.CriarMenu(AOwner) ;

  finally
    FreeAndNil(objCarregaMenuCont) ;
  end;

  pShowModalContasPorEmpresa(TShowModalFormContasPorEmpresa.New);

  procProCodContabilidade := TProCodContabilidade.pAdicionar;
  procCfgRepositorioContabilidadeAdicionar := TCfgRepositorioContabilidade.pAdicionaConfiguracoes;
  procCfgRepositorioContabilidadeProperty := TCfgRepositorioContabilidade.pRetProperties;

  VS_objTraceViewerContabilidade := TTraceViewerContabilidade.Create ;
  ProcTracerContabilidadeSetQueryEvent := TTraceContabilidade.pSetQueryEvents ;

  //dmContabilidadeModuloLog := Nil ;
  //pCriarModulo(TdmContabilidadeModuloLog, TDataModule(dmContabilidadeModuloLog));
  //if Assigned(dmContabilidadeModuloLog) then
  //  dmContabilidadeModuloLog.sqlMonitor.Active := False ;

  Result := True ;
end;

class procedure TMenuContabilidade.pDesabilitaMenu(AOwner: TComponent; ANomeMenu: string);
var
  LMenuItem: TMenuItem ;
begin
  LMenuItem := TMenuItem(AOwner.FindComponent(ANomeMenu)) ;
  if Assigned(LMenuItem) then
  begin
    LMenuItem.Enabled := False ;
  end;
end;

class procedure TMenuContabilidade.pEscondeItemMenuTabela(AOwner: TComponent; const ANomeMenu: string; const ANomeTabela: string);
begin
  if not fTabelaExiste(ANomeTabela) then
  begin
    pHabilitarItemMenu(AOwner, ANomeMenu, False ) ;
  end;
end;

class procedure TMenuContabilidade.pHabilitarItemMenu(AOwner: TComponent;
  ANomeMenu: string; AHabilitar: Boolean);
var
  LMenuItem: TMenuItem ;
begin
  LMenuItem := TMenuItem(AOwner.FindComponent(ANomeMenu)) ;
  if Assigned(LMenuItem) then
  begin
    If AHabilitar Then
    Begin
      LMenuItem.Tag := 0;
      LMenuItem.Visible := True;
    End
    Else
    Begin
      LMenuItem.Tag := 1;
      LMenuItem.Visible := False;
    End;
  end;
end;

class procedure TMenuContabilidade.pMenuCadastros(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuAbreviacaoContabilProdutos', 'Abreviação Contábil Produtos', 'frmAbreviacaoContabilProdutos', mnuAbreviacaoContabilProdutosClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuHistoricoPadrao', 'Histórico Padrão', 'frmHistoricoPadrao', mnuHistoricoPadraoClick, AMenuPai, True);

  AMenuContabil.AdicionarMenuContabil('mnuNotasExplicativas', 'Notas Explicativas', 'frmNotasExplicativas', mnuNotasExplicativasClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuPlanoContabil', 'Plano de Contas', 'frmPlanoContabil', mnuPlanoContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuCadCse', 'Signatários da Escrituração', 'frmCadCse', mnuCadCseClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuTipoDePlanoDeContaContabil', 'Tipo de Plano de Contas Contábil', 'frmTipoDePlanoDeContaContabil', mnuTipoDePlanoDeContaContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuTransferenciaSaldosPlanoContasAnterior', 'Transferência de Saldos de Plano de Contas Anterior', 'frmTransferenciaSaldosPlanoContasAnterior', mnuTransferenciaSaldosPlanoContasAnteriorClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuLalurLacs(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuLalurLacsApuracoes', 'Apurações', 'mnuLalurLacsApuracoes', Nil, AMenuPai, True);
  pMenuLalurLacsApuracoes(AMenuContabil, 'mnuLalurLacsApuracoes') ;

  AMenuContabil.AdicionarMenuContabil('mnuLalurLacsCadastros', 'Cadastros/Configurações', 'mnuLalurLacsCadastros', Nil, AMenuPai, True);
  pMenuLalurLacsCadastros(AMenuContabil, 'mnuLalurLacsCadastros') ;

  AMenuContabil.AdicionarMenuContabil('mnuLalurLacsRelatorios', 'Relatórios', 'mnuLalurLacsRelatorios', Nil, AMenuPai, True);
  pMenuLalurLacsRelatorios(AMenuContabil, 'mnuLalurLacsRelatorios') ;

end;

class procedure TMenuContabilidade.pMenuLalurLacsApuracoes(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuApuracaoLucroRealIrpjCsll', 'Apuração da CSLL e do IRPJ - Cálculo', 'frmApuracaoLucroRealIrpjCsll', mnuApuracaoLucroRealIrpjCsllClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuApuracaoLucroRealLalurLacs', 'Apuração do Lucro Real', 'frmApuracaoLucroRealLalurLacs', mnuApuracaoLucroRealLalurLacsClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuSaldoContasControladas', 'Saldo das Contas Controladas (Parte B)', 'frmSaldoContasControladas', mnuSaldoContasControladasClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuLalurLacsCadastros(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuConfiguracoesLALUR_LACS', 'Configurações do LAIR/LACS', 'frmConfigLALUR', mnuConfiguracoesLALUR_LACSClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuContasControladas', 'Contas controladas (Parte B)', 'frmCadContasControladas', mnuContasControladasClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuNaturezaDosAjustes', 'Natureza dos Ajustes', 'frmNaturezaDosAjustes', mnuNaturezaDosAjustesClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuTipoDaTabelaDinamicaDoEcf', 'Tipo da Tabela Dinâmica da Ecf', 'frmTipoDaTabelaDinamicaDoEcf', mnuTipoDaTabelaDinamicaDoEcfClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuLalurLacsRelatorios(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuApuracaoLucroRealRelatorio', 'Relatório Apuração do Lucro Real', 'frmApuracaoLucroRealRelatorio', mnuApuracaoLucroRealRelatorioClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuExportacaoGeracaoDados(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('ExportaodeLanamentosContbeis1', 'Exportação de Lançamentos Contábeis', 'ExportaodeLanamentosContbeis1', Nil, AMenuPai, False);
  AMenuContabil.AdicionarMenuContabil('mnuGerLanCon', 'Geração de Movimento( Interno AutCom)', 'frmGerLanCon', mnuGerLanConClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuExportacaoModeloContabil', 'Exportação Modelo Contábil', 'mnuExportacaoModeloContabil', mnuExportacaoModeloContabilClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuFechamentos(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuFechamentoContabil', 'Fechamento Contábil', 'frmFechamentoContabil', mnuFechamentoContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuFechamentoContabilEstorno', 'Exclusão de Fechamento Contábil', 'frmFechamentoContabilEstorno', mnuExclusaoFechamentoContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuFechamentoContabilDiaMes', 'Fechamento Contábil Diário/Mensal', 'frmFechamentoContabilDiaMes', mnuFechamentoContabilDiaMesClick, AMenuPai, True);
end;

{class procedure TMenuContabilidade.pMenuImobilizado(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuCadImobilizadoPatrimonio', 'Cadastro', 'mnuCadImobilizadoPatrimonio', Nil, AMenuPai, True);
  pMenuImobilizadoCadastro(AMenuContabil, 'mnuCadImobilizadoPatrimonio');
  AMenuContabil.AdicionarMenuContabil('mnuRelImobilizadoPatrimonio', 'Relatório', 'mnuRelImobilizadoPatrimonio', Nil, AMenuPai, True);
  pMenuImobilizadoRelatorio(AMenuContabil, 'mnuRelImobilizadoPatrimonio');
end;

class procedure TMenuContabilidade.pMenuImobilizadoCadastro(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuCadImobilizado', 'Imobilizado/Patrimônio', 'frmCadImobilizado', mnuCadImobilizadoClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuTipoImobilizadoC', 'Grupo de Bens do Imobilizado/Patrimônio', 'frmTipoImobilizado', mnuTipoImobilizadoCClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuImobilizadoRelatorio(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuRelImobilizado', 'teste', 'mnuRelImobilizado', Nil, AMenuPai, True);
end;
}

class procedure TMenuContabilidade.pMenuImportacoes(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuImportacoesHistoricoPadrao', 'Histórico Padrão', 'mnuImportacoesHistoricoPadrao', mnuImportacoesHistoricoPadraoClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacoesPlanoContas', 'Plano de Contas', 'mnuImportacoesPlanoContas', mnuImportacoesPlanoContasClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacoesLancamentosContabeis', 'Lançamentos Contábeis', 'mnuImportacoesLancamentosContabeis', mnuImportacoesLancamentosContabeisClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacoesSaldosIniciais', 'Saldos Iniciais', 'mnuImportacoesSaldosIniciais', mnuImportacoesSaldoInicialClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacoesSaldosIniciaisSubconta', 'Saldos Iniciais - Subcontas', 'mnuImportacoesSaldosIniciaisSubconta', mnuImportacoesSaldoInicialSubcontaClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacaoContabil', 'Importação Contábil', 'frmImportacaoContabil', mnuImportacaoContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuImportacaoModeloContabil', 'Importação Modelo Contabil', 'mnuImportacaoModeloContabil', mnuImportacaoModeloContabilClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuImpostoRenda(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumido', 'Lucro Presumido', 'mnuIRLucroPresumido', Nil, AMenuPai, True);
  pMenuIRLucroPresumido(AMenuContabil, 'mnuIRLucroPresumido');

  AMenuContabil.AdicionarMenuContabil('mnuIRLucroReal', 'Lucro Real', 'mnuIRLucroReal', Nil, AMenuPai, True);
  pMenuIRLucroReal(AMenuContabil, 'mnuIRLucroReal');
end;

class procedure TMenuContabilidade.pMenuIRLucroPresumido(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoParam', 'Parâmetros', 'mnuIRLucroPresumidoParam', mnuIRLucroPresumidoParamClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoRel', 'Relatórios', 'mnuIRLucroPresumidoRel', nil, AMenuPai, True);
  pMenuIRLucroPresumidoRelatorios(AMenuContabil, 'mnuIRLucroPresumidoRel') ;
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoApur', 'Apurações', 'mnuIRLucroPresumidoApur', nil, AMenuPai, True);
  pMenuIRLucroPresumidoApuracoes(AMenuContabil, 'mnuIRLucroPresumidoApur') ;
end;

class procedure TMenuContabilidade.pMenuIRLucroPresumidoApuracoes(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoApurCsll', 'CSLL', 'mnuIRLucroPresumidoApurCsll', mnuIRLucroPresumidoApurCsllClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoApurIrpj', 'IRPJ', 'mnuIRLucroPresumidoApurIrpj', mnuIRLucroPresumidoApurIrpjClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuIRLucroPresumidoRelatorios(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuIRLucroPresumidoRelRel01', 'Apuração do Lucro Presumido', 'mnuIRLucroPresumidoRelRel01', mnuIRLucroPresumidoRelatorioClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuIRLucroReal(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuLALURLACS', 'LAIR/LACS', 'mnuLALURLACS', Nil, AMenuPai, True);
  pMenuLalurLacs(AMenuContabil, 'mnuLALURLACS');
end;

class procedure TMenuContabilidade.pMenuMovimentacao(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuLanSal', 'Lançamentos de Saldos', 'frmLanSal', mnuLanSalClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuLanSalSub', 'Lançamentos de Saldos - Subcontas', 'frmLanSalSub', mnuLanSalSubClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuLanLotesContabeis', CAPTION_MENU_LOTES_CONTABEIS, NOME_FRM_LOTES_CONTABEIS, mnuLanLotesContabeisClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuTransfLancEntreContas', 'Transferência de Lançamentos entre Contas', 'frmTransfLancEntreContas', mnuTransfLancEntreContasClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuLancamentosPeriodicos', 'Lançamentos Periódicos', 'frmLancamentosPeriodicos', mnuLancamentosPeriodicosClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuObrigacoesAcessorias(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuECDEscrituracaoContabilDigital', 'ECD - Escrituração Contábil Digital', 'mnuECDEscrituracaoContabilDigital', mnuECDEscrituracaoContabilDigitalClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuEcfEscrituracaoContabilFiscal', 'ECF - Escrituração Contábil Fiscal (Beta)', 'mnuEcfEscrituracaoContabilFiscal', mnuECFEscrituracaoContabilFiscalClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuParametros(
  var AMenuContabil: TMenuContabil; const AMenuPai: string);
begin
  AMenuContabil.AdicionarMenuContabil('mnuCadDefDemonsResultExerc', 'Configurações para DRE', 'frmCadDefDemonsResultExerc', mnuCadDefDemonsResultExercClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuParametrosContabilizacao', 'Parametrização para Contabilização', 'frmParametrosContabilizacao', mnuParametrosContabilizacaoClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuPlanoContaVinculoPlanoReferencial', 'Vinculos com o Plano de Contas Contábil', 'mnuPlanoContaVinculoPlanoReferencial', mnuPlanoContaVinculoPlanoReferencialClick, AMenuPai, True);
end;

class procedure TMenuContabilidade.pMenuRelatorios(
  var AMenuContabil: TMenuContabil; const AMenuPai: string; blnKardex: Boolean = True);
begin
  AMenuContabil.AdicionarMenuContabil('mnuCtbBalanco', 'Balanço', 'mnuCtbBalanco', Nil, AMenuPai, False);
  If blnKardex Then
    AMenuContabil.AdicionarMenuContabil('mnuConferenciaEstoqueContabil', 'Conferência Estoque Contábil', 'frmConferenciaEstoqueContabil', mnuConferenciaEstoqueContabilClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('ConfernciaImportaoGeraodeDados1', 'Conferência Importação/Geração de Dados', 'ConfernciaImportaoGeraodeDados1', Nil, AMenuPai, False);
  AMenuContabil.AdicionarMenuContabil('mnuAuxiliares1', 'Auxiliares', 'mnuAuxiliares1', Nil, AMenuPai, False);
  AMenuContabil.AdicionarMenuContabil('mnuAnaVertHor1', 'Análise Vertical/Horizontal', 'mnuAnaVertHor1', Nil, 'mnuAuxiliares1', False);

  AMenuContabil.AdicionarMenuContabil('mnuDemonstracaoFluxoCaixa', 'DFC - Demonstração do Fluxo de Caixa', 'frmDemonstracaoFluxoCaixa', mnuDemonstracaoFluxoCaixaClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuDemonstracaoMutacaoPatrimonioLiquido', 'DMPL - Demonstração das Mutações do Patrimônio Líquido', 'frmDemonstracaoMutacaoPatrimonioLiquido', mnuDemonstracaoMutacaoPatrimonioLiquidoClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuDemonstracaoResultadoAbrangente', 'DRA - Demonstração do Resultado Abrangente', 'frmDemonstracaoResultadoAbrangente', mnuDemonstracaoResultadoAbrangenteClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuDemonstracaoValorAdicionado', 'DVA - Demonstração do Valor Adicionado', 'frmDemonstracaoValorAdicionado', mnuDemonstracaoValorAdicionadoClick, AMenuPai, True);
  AMenuContabil.AdicionarMenuContabil('mnuNotasExplicativasV2', 'Notas Explicativas', 'frmNotasExplicativasV2', mnuNotasExplicativasV2Click, AMenuPai, True);

end;

class procedure TMenuContabilidade.DesabilitarItemMenu(AOwner: TComponent);
begin
  //Quando implementar as opções do menu contabilidade, remover as marcações
  pDesabilitaMenu(AOwner,'EncerramentodePeriodos1');
  pDesabilitaMenu(AOwner,'ExportaodeLanamentosContbeis1');
  pDesabilitaMenu(AOwner,'ConfernciaImportaoGeraodeDados1');
  pDesabilitaMenu(AOwner,'mnuCtbBalanco');
end;

class function TMenuContabilidade.fCfgSisLoc(strCamCfg: String): Variant;
begin
  result := '' ;
  if fConfiguracaoExiste(strCamCfg) then
  begin
    result := fCfgSis(strCamCfg) ;
  end;
end;

class procedure TMenuContabilidade.pExecutarSpedAncorado(const ANomeExe: String);
const
  ASFW_ANY = DWORD(-1);
var
  LExePath  : String;
  LExeDir   : String;
  LCmdLine  : String;
  StartInfo : TStartupInfo;
  ProceInfo : TProcessInformation;
  LOk       : Boolean;
  LThreadAutcom, LThreadECD: DWORD;
  LAttached: Boolean;
begin
  LExePath := ExtractFilePath(Application.ExeName) + ANomeExe;

  if not FileExists(LExePath) then
  begin
    fMensagem('', 'Executável "' + ANomeExe + '" não existe no diretório do AUTCOM!', ['&OK']);
    Exit;
  end;

  LExeDir := ExtractFilePath(LExePath);

  LCmdLine := '"' + LExePath + '"';

  UniqueString(LCmdLine);

  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartInfo.wShowWindow := SW_SHOWNORMAL;

  Winapi.Windows.AllowSetForegroundWindow(ASFW_ANY);
  LOk := CreateProcess(nil,
                       PChar(LCmdLine),
                       nil,
                       nil,
                       False,
                       NORMAL_PRIORITY_CLASS,
                       nil,
                       PChar(LExeDir),
                       StartInfo,
                       ProceInfo);

  if not LOk then
  begin
    fMensagem('', 'Falha ao iniciar "' + ANomeExe + '". Erro Windows: ' +
              IntToStr(GetLastError), ['&OK']);
    Exit;
  end;

  WaitForInputIdle(ProceInfo.hProcess, 5000);
  LThreadAutcom := GetCurrentThreadId;
  LThreadECD    := ProceInfo.dwThreadId;
  LAttached     := AttachThreadInput(LThreadAutcom, LThreadECD, True);
  try
    while True do
    begin
      case MsgWaitForMultipleObjects(1, ProceInfo.hProcess, False,
                                     INFINITE, QS_ALLINPUT) of
        WAIT_OBJECT_0:      Break;
        WAIT_OBJECT_0 + 1:  Application.ProcessMessages;
        WAIT_FAILED:        Break;
      else
        Break;
      end;
    end;
  finally
    if LAttached then
      AttachThreadInput(LThreadAutcom, LThreadECD, False);
    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  end;
end;

class procedure TMenuContabilidade.mnuAbreviacaoContabilProdutosClick(
  Sender: TObject);
begin
  pCriarForm(TfrmAbreviacaoContabilProdutos);
end;

class procedure TMenuContabilidade.mnuApuracaoLucroRealIrpjCsllClick(
  Sender: TObject);
var
  LfrmApuracaoLucroRealIrpjCsll : TfrmApuracaoLucroRealIrpjCsll ;
begin
  Try
    pCriarFormularios(TfrmApuracaoLucroRealIrpjCsll, LfrmApuracaoLucroRealIrpjCsll);
    LfrmApuracaoLucroRealIrpjCsll.WindowState := wsMaximized ;
    LfrmApuracaoLucroRealIrpjCsll.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmApuracaoLucroRealIrpjCsll);
end;

class procedure TMenuContabilidade.mnuApuracaoLucroRealLalurLacsClick(
  Sender: TObject);
var
  LfrmApuracaoLucroRealLalurLacs : TfrmApuracaoLucroRealLalurLacs ;
begin
  Try
    pCriarFormularios(TfrmApuracaoLucroRealLalurLacs, LfrmApuracaoLucroRealLalurLacs);
    LfrmApuracaoLucroRealLalurLacs.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmApuracaoLucroRealLalurLacs);
end;

class procedure TMenuContabilidade.mnuApuracaoLucroRealRelatorioClick(
  Sender: TObject);
var
  LfrmApuracaoLucroRealRelatorio : TfrmApuracaoLucroRealRelatorio ;
begin
  Try
    pCriarFormularios(TfrmApuracaoLucroRealRelatorio, LfrmApuracaoLucroRealRelatorio);
    LfrmApuracaoLucroRealRelatorio.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmApuracaoLucroRealRelatorio);
end;

class procedure TMenuContabilidade.mnuCadCseClick(Sender: TObject);
begin
  pCriarForm(TfrmCadCse, frmCadCse);
end;

class procedure TMenuContabilidade.mnuHistoricoPadraoClick(Sender: TObject);
begin
  pCriarForm(TfrmHistoricoPadrao, frmHistoricoPadrao);
end;

class procedure TMenuContabilidade.mnuNaturezaDosAjustesClick(
  Sender: TObject);
var
  LfrmNaturezaDosAjustes : TfrmNaturezaDosAjustes ;
begin
  Try
    pCriarFormularios(TfrmNaturezaDosAjustes, LfrmNaturezaDosAjustes);
    LfrmNaturezaDosAjustes.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmNaturezaDosAjustes);
end;

class procedure TMenuContabilidade.mnuNotasExplicativasClick(
  Sender: TObject);
begin
  pCriarForm(TfrmNotasExplicativas);
end;

class procedure TMenuContabilidade.mnuPlanoContabilClick(Sender: TObject);
begin
  pCriarForm(TfrmPlanoContabil, frmPlanoContabil);
end;

class procedure TMenuContabilidade.mnuPlanoContaVinculoPlanoReferencialClick(
  Sender: TObject);
var
  LfrmPlanoContaVinculoPlanoReferencial : TfrmPlanoContaVinculoPlanoReferencial ;
begin
  Try
    pCriarFormularios(TfrmPlanoContaVinculoPlanoReferencial, LfrmPlanoContaVinculoPlanoReferencial);
    LfrmPlanoContaVinculoPlanoReferencial.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmPlanoContaVinculoPlanoReferencial);
end;

class procedure TMenuContabilidade.mnuSaldoContasControladasClick(
  Sender: TObject);
var
  LfrmSaldoContasControladas : TfrmSaldoContasControladas ;
begin
  Try
    pCriarFormularios(TfrmSaldoContasControladas, LfrmSaldoContasControladas);
    LfrmSaldoContasControladas.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmSaldoContasControladas);
end;

class procedure TMenuContabilidade.mnuTipoDePlanoDeContaContabilClick(
  Sender: TObject);
begin
  pCriarForm(TfrmTipoDePlanoDeContaContabil, frmTipoDePlanoDeContaContabil);
end;

class procedure TMenuContabilidade.mnuDemonstracaoMutacaoPatrimonioLiquidoClick(
  Sender: TObject);
var
  frmDemonstracaoMutacaoPatrimonioLiquido : TfrmDemonstracaoMutacaoPatrimonioLiquido ;
begin
  Try
    pCriarFormularios(TfrmDemonstracaoMutacaoPatrimonioLiquido, frmDemonstracaoMutacaoPatrimonioLiquido);
    frmDemonstracaoMutacaoPatrimonioLiquido.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmDemonstracaoMutacaoPatrimonioLiquido);
end;

class procedure TMenuContabilidade.mnuDemonstracaoValorAdicionadoClick(Sender: TObject);
var
  frmDemonstracaoValorAdicionado : TfrmDemonstracaoValorAdicionado ;
begin
  Try
    pCriarFormularios(TfrmDemonstracaoValorAdicionado, frmDemonstracaoValorAdicionado);
    frmDemonstracaoValorAdicionado.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmDemonstracaoValorAdicionado);
end;

class procedure TMenuContabilidade.mnuDemonstracaoResultadoAbrangenteClick(
  Sender: TObject);
var
  frmDemonstracaoResultadoAbrangente : TfrmDemonstracaoResultadoAbrangente ;
begin
  Try
    pCriarFormularios(TfrmDemonstracaoResultadoAbrangente, frmDemonstracaoResultadoAbrangente);
    frmDemonstracaoResultadoAbrangente.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmDemonstracaoResultadoAbrangente);
end;

class procedure TMenuContabilidade.mnuNotasExplicativasV2Click(Sender: TObject);
var
  frmNotasExplicativasV2 : TfrmNotasExplicativasV2 ;
begin
  Try
    pCriarFormularios(TfrmNotasExplicativasV2, frmNotasExplicativasV2);
    frmNotasExplicativasV2.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmNotasExplicativasV2);
end;

class procedure TMenuContabilidade.mnuDemonstracaoFluxoCaixaClick(Sender: TObject);
var
  frmDemonstracaoFluxoCaixa : TfrmDemonstracaoFluxoCaixa ;
begin
  Try
    pCriarFormularios(TfrmDemonstracaoFluxoCaixa, frmDemonstracaoFluxoCaixa);
    frmDemonstracaoFluxoCaixa.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmDemonstracaoFluxoCaixa);
end;

class procedure TMenuContabilidade.mnuImportacoesHistoricoPadraoClick(Sender: TObject);
var
  frmImportacoesContabeis : TfrmImportacoesContabeis ;
begin
  Try
    pCriarFormularios(TfrmImportacoesContabeis, frmImportacoesContabeis);
    frmImportacoesContabeis.ImportacaoDadosContabeis := tidcHistoricoPadrao ;
    frmImportacoesContabeis.Caption := 'Importação - ' + StripHotkey(TMenuItem(Sender).Caption);
    frmImportacoesContabeis.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmImportacoesContabeis);
end;

class procedure TMenuContabilidade.mnuImportacoesLancamentosContabeisClick(
  Sender: TObject);
var
  frmImportacoesContabeis : TfrmImportacoesContabeis ;
begin
  Try
    pCriarFormularios(TfrmImportacoesContabeis, frmImportacoesContabeis);
    frmImportacoesContabeis.ImportacaoDadosContabeis := tidcLancamentosContabeis ;
    frmImportacoesContabeis.Caption := 'Importação - ' + StripHotkey(TMenuItem(Sender).Caption);
    frmImportacoesContabeis.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmImportacoesContabeis);
end;

class procedure TMenuContabilidade.mnuImportacoesPlanoContasClick(Sender: TObject);
var
  frmImportacoesContabeis : TfrmImportacoesContabeis ;
begin
  Try
    pCriarFormularios(TfrmImportacoesContabeis, frmImportacoesContabeis);
    frmImportacoesContabeis.ImportacaoDadosContabeis := tidcPlanoContas ;
    frmImportacoesContabeis.Caption := 'Importação - ' + StripHotkey(TMenuItem(Sender).Caption);
    frmImportacoesContabeis.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmImportacoesContabeis);
end;

class procedure TMenuContabilidade.mnuImportacoesSaldoInicialClick(
  Sender: TObject);
var
  frmImportacoesContabeis : TfrmImportacoesContabeis ;
begin
  Try

    pCriarFormularios(TfrmImportacoesContabeis, frmImportacoesContabeis);
    try
      frmImportacoesContabeis.ImportacaoDadosContabeis := tidcSaldosIniciais ;
      frmImportacoesContabeis.Caption := 'Importação - ' + StripHotkey(TMenuItem(Sender).Caption);
      frmImportacoesContabeis.showModal;
    finally
      pFreeAndNil(frmImportacoesContabeis);
    end ;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
end;

class procedure TMenuContabilidade.mnuImportacoesSaldoInicialSubcontaClick(
  Sender: TObject);
var
  frmImportacoesContabeis : TfrmImportacoesContabeis ;
begin
  Try

    pCriarFormularios(TfrmImportacoesContabeis, frmImportacoesContabeis);
    try
      frmImportacoesContabeis.ImportacaoDadosContabeis := tidcSaldosIniciaisSubconta ;
      frmImportacoesContabeis.Caption := 'Importação - ' + StripHotkey(TMenuItem(Sender).Caption);
      frmImportacoesContabeis.showModal;
    finally
      pFreeAndNil(frmImportacoesContabeis);
    end ;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
end;

class procedure TMenuContabilidade.mnuIRLucroPresumidoApurCsllClick(
  Sender: TObject);
var
  LfrmApuracLucroPresumido : TfrmApuracaoLucroPresumido ;
begin
  try
    Try
      pCriarFormularios(TfrmApuracaoLucroPresumido, LfrmApuracLucroPresumido);
      LfrmApuracLucroPresumido.TipoApuracao := tlpCSLL ;
      LfrmApuracLucroPresumido.Caption := 'Apuração - Presumido [CSLL]' ;
      LfrmApuracLucroPresumido.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
      End;
    End;
  finally
    pFreeAndNil(LfrmApuracLucroPresumido);
  end ;
end;

class procedure TMenuContabilidade.mnuIRLucroPresumidoApurIrpjClick(
  Sender: TObject);
var
  LfrmApuracLucroPresumido : TfrmApuracaoLucroPresumido ;
begin
  try
    Try
      pCriarFormularios(TfrmApuracaoLucroPresumido, LfrmApuracLucroPresumido);
      LfrmApuracLucroPresumido.Caption := 'Apuração Lucro Presumido [IRPJ]' ;
      LfrmApuracLucroPresumido.TipoApuracao := tlpIRPJ ;
      LfrmApuracLucroPresumido.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
      End;
    End;
  finally
    pFreeAndNil(LfrmApuracLucroPresumido);
  end ;
end;

class procedure TMenuContabilidade.mnuIRLucroPresumidoParamClick(
  Sender: TObject);
var
  LfrmConfigLucroPresumido : TfrmConfigLucroPresumido ;
begin
  try
    Try
      pCriarFormularios(TfrmConfigLucroPresumido, LfrmConfigLucroPresumido);
      LfrmConfigLucroPresumido.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
      End;
    End;
  finally
    pFreeAndNil(LfrmConfigLucroPresumido);
  end ;
end;

class procedure TMenuContabilidade.mnuIRLucroPresumidoRelatorioClick(
  Sender: TObject);
var
  LfrmApuracaoLucroPresumidoRelatorio : TfrmApuracaoLucroPresumidoRelatorio ;
begin
  try
    Try
      pCriarFormularios(TfrmApuracaoLucroPresumidoRelatorio, LfrmApuracaoLucroPresumidoRelatorio);
      LfrmApuracaoLucroPresumidoRelatorio.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
      End;
    End;
  finally
    pFreeAndNil(LfrmApuracaoLucroPresumidoRelatorio);
  end ;
end;

class procedure TMenuContabilidade.mnuConfiguracoesLALUR_LACSClick(Sender: TObject);
begin
  pCriarForm(TfrmConfigLALUR, frmConfigLALUR);
end;

class procedure TMenuContabilidade.mnuTipoImobilizadoCClick(Sender: TObject);
var
  frmTipoImobilizado : TfrmTipoImobilizado ;
begin
  Try
    pCriarFormularios(TfrmTipoImobilizado, frmTipoImobilizado);
    frmTipoImobilizado.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(frmTipoImobilizado);
end;

class procedure TMenuContabilidade.mnuImportacaoContabilClick(Sender: TObject);
begin
  pCriarForm(TfrmImportacaoContabil);
end;

class procedure TMenuContabilidade.mnuImportacaoModeloContabilClick(
  Sender: TObject);
  var
    LfrmImportacao : TfrmImportacaoModeloContabil;
begin
  if not fOperadorCitelLogado then
  begin
    fMensagem('ATENÇÃO!', 'Operador nao possui acesso para visualizar informações de Importação Modelo Contábil.', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmImportacaoModeloContabil, LfrmImportacao);
  try
    LfrmImportacao.ShowModal;
  finally
    pFreeAndNil(LfrmImportacao);
  end;
end;

class procedure TMenuContabilidade.mnuFechamentoContabilClick(Sender: TObject);
begin
  pCriarForm(TfrmFechamentoContabil, frmFechamentoContabil);
end;

class procedure TMenuContabilidade.mnuExclusaoFechamentoContabilClick(Sender: TObject);
var
  LfrmFechamentoContabilEstorno: TfrmFechamentoContabilEstorno;
begin
  Try
    pCriarFormularios(TfrmFechamentoContabilEstorno, LfrmFechamentoContabilEstorno);
    LfrmFechamentoContabilEstorno.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmFechamentoContabilEstorno);
end;

class procedure TMenuContabilidade.mnuFechamentoContabilDiaMesClick(
  Sender: TObject);
var
  LfrmFechamentoContabilDiaMes: TfrmFechamentoContabilDiaMes;
begin
  Try
    pCriarFormularios(TfrmFechamentoContabilDiaMes, LfrmFechamentoContabilDiaMes);
    LfrmFechamentoContabilDiaMes.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
  pFreeAndNil(LfrmFechamentoContabilDiaMes);
end;

class procedure TMenuContabilidade.mnuConferenciaEstoqueContabilClick(Sender: TObject);
begin
  pCriarForm(TfrmConferenciaEstoqueContabil, frmConferenciaEstoqueContabil);
end;

class procedure TMenuContabilidade.mnuECDEscrituracaoContabilDigitalClick(Sender: TObject);
const
  SPED_CONTABIL_EXE_NAME : String = 'SpedContabil.exe';
begin
  pExecutarSpedAncorado(SPED_CONTABIL_EXE_NAME);
end;

class procedure TMenuContabilidade.mnuECFEscrituracaoContabilFiscalClick(
  Sender: TObject);
const
  SPED_CONTABIL_ECF_EXE_NAME : String = 'SpedContabilECF.exe';
begin
  pExecutarSpedAncorado(SPED_CONTABIL_ECF_EXE_NAME);
end;

class procedure TMenuContabilidade.mnuExportacaoModeloContabilClick(
  Sender: TObject);
  var
    LfrmExportacao : TfrmExportacaoModeloContabil;
begin
  if not fOperadorCitelLogado then
  begin
    fMensagem('ATENÇÃO!', 'Operador nao possui acesso para visualizar informações de Exportação Modelo Contábil.', ['&OK']);
    Exit;
  end;

  pCriarFormularios(TfrmExportacaoModeloContabil, LfrmExportacao);
  try
    LfrmExportacao.ShowModal;
  finally
    pFreeAndNil(LfrmExportacao);
  end;
end;

class procedure TMenuContabilidade.mnuManutencaoLoteContabilClick(Sender: TObject);
begin
  pCriarForm(TfrmManutencaoLoteContabil);
end;

class procedure TMenuContabilidade.mnuLancamentosPeriodicosClick(
  Sender: TObject);
var
  LfrmLancamentosPeriodicos : TfrmLancamentosPeriodicos;
begin
  pCriarFormularios(TfrmLancamentosPeriodicos, LfrmLancamentosPeriodicos);
  try
    LfrmLancamentosPeriodicos.ShowModal;
  finally
    pFreeAndNil(LfrmLancamentosPeriodicos);
  end;
end;

class procedure TMenuContabilidade.mnuLanLotesContabeisClick(Sender: TObject);
var
  LfrmLancamentosLotesContabeis : TfrmLancamentosLotesContabeis;
begin
  pCriarFormularios(TfrmLancamentosLotesContabeis, LfrmLancamentosLotesContabeis);
  try
    LfrmLancamentosLotesContabeis.ShowModal;
  finally
    pFreeAndNil(LfrmLancamentosLotesContabeis);
  end;
end;

class procedure TMenuContabilidade.mnuLanSalClick(Sender: TObject);
begin
  pCriarForm(TfrmLanSal, frmLanSal);
end;

class procedure TMenuContabilidade.mnuLanSalSubClick(Sender: TObject);
var
  frmLanSalSub : TfrmLanSalSub ;
begin
  Try
    pCriarFormularios(TfrmLanSalSub, frmLanSalSub);
    try
      frmLanSalSub.ShowModal;
    finally
      pFreeAndNil(frmLanSalSub);
    end ;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '['+StripHotkey(TMenuItem(Sender).Caption)+']');
    End;
  End;
end;

class procedure TMenuContabilidade.mnuManLanConClick(Sender: TObject);
  var
    LfrmManLanCon : TfrmManLanCon;
begin
  pCriarFormularios(TfrmManLanCon, LfrmManLanCon);
  try
    LfrmManLanCon.prcMultLancamentos := pMultLancamentosContabeis;
    LfrmManLanCon.ShowModal;
  finally
    pFreeAndNil(LfrmManLanCon);
  end;
end;

class procedure TMenuContabilidade.mnuGerLanConClick(Sender: TObject);
begin
  pCriarForm(TfrmGerLanCon, frmGerLanCon);
end;

class procedure TMenuContabilidade.mnuCadDefDemonsResultExercClick(Sender: TObject);
begin
  pCriarForm(TfrmCadDefDemonsResultExerc, frmCadDefDemonsResultExerc);
end;

class procedure TMenuContabilidade.mnuTipoDaTabelaDinamicaDoEcfClick(Sender: TObject);
begin
  pCriarForm(TfrmTipoDaTabelaDinamicaDoEcf, frmTipoDaTabelaDinamicaDoEcf);
end;

class procedure TMenuContabilidade.mnuContasControladasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadContasControladas);
end;

class procedure TMenuContabilidade.mnuTransferenciaSaldosPlanoContasAnteriorClick(
  Sender: TObject);
begin
  pCriarForm(TfrmTransferenciaSaldosPlanoContasAnterior);
end;

class procedure TMenuContabilidade.mnuTransfLancEntreContasClick(
  Sender: TObject);
var
  LfrmTransfLancEntreContas : TfrmTransfLancEntreContas;
begin
  pCriarFormularios(TfrmTransfLancEntreContas, LfrmTransfLancEntreContas);
  try
    LfrmTransfLancEntreContas.ShowModal;
  finally
    pFreeAndNil(LfrmTransfLancEntreContas);
  end;
end;

class procedure TMenuContabilidade.mnuCadImobilizadoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadImobilizado,frmCadImobilizado);
end;

class procedure TMenuContabilidade.MonitorContabil;
begin
  TUtilMonitor.pTestInactivity(ID_Inactivity_Monitor_Contabil,
                               Time_Limit_Monitor_Contabil,
                               VS_objProcessoMonitorContabil,
                               VS_dtaUltimaExecucaoMonitorContabil);

  TUtilMonitor.pRunMonitor(Id_Monitor_Contabil,
                           VS_objProcessoMonitorContabil,
                           VS_dtaUltimaExecucaoMonitorContabil,
                           Monitor_Contabil_ExeName,
                           NO_PARAMS);

  TUtilMonitor.pClearAttemptsLock(Format(Id_Monitor_Contabil, [VS_strCodEmp]),
                                  Attempts_Lock_Monitor_Contabil);
end;

class procedure TMenuContabilidade.mnuParametrosContabilizacaoClick(Sender: TObject);
begin
  pCriarForm(TfrmParametrosContabilizacao) ;
end;

class procedure TMenuContabilidade.pMultLancamentosContabeis(listaLancamentos: TObjectList<TDadosImportacaoContabil>; const AValorTotalLanctos: double; const AdtaLan:TDate; const AstrEmpLan: string);
  var
    LfrmMultLancamentosContabeis : TfrmMultLancamentosContabeis;
begin
  pCriarFormularios(TfrmMultLancamentosContabeis, LfrmMultLancamentosContabeis);
  try
    LfrmMultLancamentosContabeis.fltValorTotalLanctos := AValorTotalLanctos;
    LfrmMultLancamentosContabeis.listaLancamentos := listaLancamentos;
    LfrmMultLancamentosContabeis.dtalan := AdtaLan;
    LfrmMultLancamentosContabeis.strEmpLan := AstrEmpLan;
    LfrmMultLancamentosContabeis.ShowModal;
  finally
    pFreeAndNil(LfrmMultLancamentosContabeis);
  end;
end;

class procedure TMenuContabilidade.EsconderItemMenu(AOwner: TComponent);
begin
  ///esconde menus de acordo com as CFGs
  pHabilitarItemMenu(AOwner, 'mnuIRLucroReal', fCfgSisLoc('SPDECF') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuCtbConfiguracaoSPEDECF', fCfgSisLoc('SPDECF') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuPlanoReferencial', fCfgSisLoc('EXPECD') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuECF', fCfgSisLoc('SPDECF') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuManutencaoLoteContabil', ((fCfgSisLoc('UTICON') = 'S') and (fCfgSisLoc('LTCONT') = 'S'))) ;
  pHabilitarItemMenu(AOwner, 'mnuRelImobilizado', False) ;
  pHabilitarItemMenu(AOwner, 'mnuImportacoesSaldosIniciaisSubconta', fCfgSisLoc('SUBCNT') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuLanSalSub', fCfgSisLoc('SUBCNT') = 'S') ;
  pHabilitarItemMenu(AOwner, 'mnuImportacaoModeloContabil', fOperadorCitelLogado) ;
  pHabilitarItemMenu(AOwner, 'mnuExportacaoModeloContabil', fOperadorCitelLogado) ;
  ///esconde menus caso a tabela não exista no sistema
  pEscondeItemMenuTabela(AOwner, 'mnuDemonstracaoFluxoCaixa', 'PARDFC') ;
  pEscondeItemMenuTabela(AOwner, 'mnuDemonstracaoMutacaoPatrimonioLiquido', 'NTEXPL') ;
  pEscondeItemMenuTabela(AOwner, 'mnuDemonstracaoResultadoAbrangente', 'PARDRA') ;
  pEscondeItemMenuTabela(AOwner, 'mnuDemonstracaoValorAdicionado', 'PARDVA') ;
  pEscondeItemMenuTabela(AOwner, 'mnuImportacoesDemonstrativoEcf', 'ECFREG') ;
  pEscondeItemMenuTabela(AOwner, 'mnuImportacoesPlanoReferencial', 'ECFREG') ;
  pEscondeItemMenuTabela(AOwner, 'mnuNotasExplicativasV2', 'NTEXPL') ;
  pEscondeItemMenuTabela(AOwner, 'mnuAbreviacaoContabilProdutos', 'ABFCOG') ;
  pEscondeItemMenuTabela(AOwner, 'mnuDemonstrativoEcf', 'ECFREG') ;
  pEscondeItemMenuTabela(AOwner, 'mnuNotasExplicativas', 'NOTEXP') ;
  pEscondeItemMenuTabela(AOwner, 'mnuTransferenciaSaldosPlanoContasAnterior', 'TSPCOA') ;
  pEscondeItemMenuTabela(AOwner, 'mnuTipoImobilizadoC', 'TIPIMO') ;
  pEscondeItemMenuTabela(AOwner, 'mnuConfiguracoesLALUR_LACS', 'CFLALU') ;
  pEscondeItemMenuTabela(AOwner, 'mnuManutencaoLoteContabil', 'LOTINC') ;
  pEscondeItemMenuTabela(AOwner, 'mnuContasControladas', 'CTACON') ;
  pEscondeItemMenuTabela(AOwner, 'mnuHistorioDosLancamentos', 'HISLAN') ;
  pEscondeItemMenuTabela(AOwner, 'mnuNaturezaDosAjustes', 'NATAJU') ;
  pEscondeItemMenuTabela(AOwner, 'mnuTipoDaTabelaDinamicaDoEcf', 'TABECF') ;
  pEscondeItemMenuTabela(AOwner, 'mnuCadImobilizado', 'CADIMO') ;
  pEscondeItemMenuTabela(AOwner, 'mnuApuracaoLucroRealLalurLacs', 'APUPRE') ;
  pEscondeItemMenuTabela(AOwner, 'mnuApuracaoLucroRealIrpjCsll', 'ADREAC') ;
  pEscondeItemMenuTabela(AOwner, 'mnuApuracaoLucroRealRelatorio', 'APUPRE') ;

  VC_StrVersaoContabilidade := fRetornaVersaoCont(True);
  VC_CarregaPlanoDeContasPorEmpresaInterno := TMetodosPlanoDeContasPorEmpresa.pCarregaPlanoDeContasPorEmpresa ;
  VC_SalvaPlanoDeContasPorEmpresaInterno := TMetodosPlanoDeContasPorEmpresa.pSalvaPlanoDeContasPorEmpresa ;
  untFuncoesSimples.VS_objTemFecMes := TOutrosFechamentos.fTemFecMes;
  VC_VerificaDeletaFechamento := TOutrosFechamentos.fDeletaFechamento ;
end;

{ TCfgRepositorioContabilidade }

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgADTORD(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxButtonEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_ADTORD' then
  begin
    LProperty := TcxButtonEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryButtonItem)) ;
    LProperty.ReadOnly := True ;
    LProperty.OnButtonClick := pCfgADTORDPropertiesOnButtonClick ;
    LProperty.ViewStyle := vsButtonsAutoWidth ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgALTFIN(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LItemRadio: tCxRadioGroupItem ;
  LProperty: TcxRadioGroupProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_ALTFIN' then
  begin
    LProperty := TcxRadioGroupProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryRadioGroupItem)) ;

    LProperty.Items.Clear ;
    LItemRadio := LProperty.Items.add ;
    LItemRadio.Value := '0' ;
    LItemRadio.Caption := 'Avisar' ;

    LItemRadio := LProperty.Items.add ;
    LItemRadio.Value := '1' ;
    LItemRadio.Caption := 'Travar' ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGAPU(
  const ACfg: string;
  ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGAPU' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGATI(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGATI' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConPrimeiroGrau(MascaraContabilAlteradaRepositorio) ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGCOM(
  const ACfg: string;
  ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGCOM' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGCUS(
  const ACfg: string;
  ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGCUS' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGDES(
  const ACfg: string;
  ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGDES' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGOUT(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGOUT' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;

    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGPAS(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGPAS' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConPrimeiroGrau(MascaraContabilAlteradaRepositorio) ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgCRDSEQ(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties):TcxCustomEditProperties ;
var
  LProperty: TcxTextEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_CRDSEQ' then
  begin
    LProperty := TcxTextEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryTextItem)) ;
    LProperty.MaxValue := 20;
    LProperty.OnValidate := pCfgCRDSEQPropertiesValidate;
    result := LProperty ;
  end;
end;


class function TCfgRepositorioContabilidade.fCustomizePropertyCfgDIGREC(
  const ACfg: string;
  ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxMaskEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_DIGREC' then
  begin
    LProperty := TcxMaskEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryMaskItem)) ;
    LProperty.EditMask := fMskConDigitoIdentificador(MascaraContabilAlteradaRepositorio) ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgMAXHPD(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxSpinEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_MAXHPD' then
  begin
    LProperty := TcxSpinEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositorySpinItem)) ;
    LProperty.MaxValue := 200 ;
    LProperty.MinValue := 20 ;
    LProperty.MaxLength := 3 ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgPCDEDT(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxButtonEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_PCDEDT' then
  begin
    LProperty := TcxButtonEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryButtonItem)) ;
    LProperty.ReadOnly := True ;
    LProperty.ViewStyle := vsButtonsAutoWidth ;
    LProperty.OnButtonClick := pCfgPCDEDTPropertiesOnButtonClick ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgPCJUDT(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxButtonEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_PCJUDT' then
  begin
    LProperty := TcxButtonEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryButtonItem)) ;
    LProperty.ReadOnly := True ;
    LProperty.ViewStyle := vsButtonsAutoWidth ;
    LProperty.OnButtonClick := pCfgPCJUDTPropertiesOnButtonClick ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgPICORF(
  const ACfg: string; ACfgRepositorio: Pointer;
  AProperty: TcxCustomEditProperties): TcxCustomEditProperties;
var
  LProperty: TcxButtonEditProperties ;
begin
  result := Nil ;

  if Assigned(AProperty) then
  begin
    result := AProperty ;
    exit ;
  end;

  if ACfg = 'CFG_PICORF' then
  begin
    LProperty := TcxButtonEditProperties(fRetornaPropertiesRepositorio(ACfg, ACfgRepositorio, TcxEditRepositoryButtonItem)) ;
    LProperty.ReadOnly := True ;
    LProperty.ViewStyle := vsButtonsAutoWidth ;
    LProperty.OnButtonClick := pCfgPICORFPropertiesOnButtonClick ;
    result := LProperty ;
  end;
end;

class function TCfgRepositorioContabilidade.fCustomizePropertyCfgRepositorio(
  const ACfg: string; ACfgRepositorio: Pointer): TcxCustomEditProperties;
begin
  Result := Nil ;
  Result := fCustomizePropertyCfgDIGAPU(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGCOM(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGCUS(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGDES(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGREC(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgMAXHPD(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgPCJUDT(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgADTORD(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgPCDEDT(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgALTFIN(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgPICORF(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGOUT(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGATI(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgDIGPAS(ACfg, ACfgRepositorio, Result) ;
  Result := fCustomizePropertyCfgCRDSEQ(ACfg, ACfgRepositorio, Result) ;
end;

class procedure TCfgRepositorioContabilidade.edtConMascaraContabilPropertiesEditValueChanged(
  Sender: TObject);
var
  formParent : TfrmCfgSistema ;
begin
  formParent := TfrmCfgSistema(GetParentForm(TControl(Sender))) ;
  if TCfgRepositorioContabilidade.fHouveMudancaMascaraContabilPatrimonioLiquido(formParent.cfgRepositorio.cdsCfgSis, TcxTextEdit(Sender).Text) then
  begin
    formParent.cfgRepositorio.mskConPatrimonioLiquido.Properties.EditMask := fMskConPatrimonioLiquido(TcxTextEdit(Sender).Text) ;
    fMensagem('ATENÇÃO', 'Atualize as informações na configuração "CFG_DIGPLI"!', ['&OK']);
  end;
  MascaraContabilAlteradaRepositorio := TcxTextEdit(Sender).Text ;
end;

class function TCfgRepositorioContabilidade.fBuscaCfgSis(
  const ACdsCfg: TUniClientDataSet; const AValor: string): string;
begin
  result := '' ;
  if ACdsCfg.FindKey([AValor]) then
  begin
    result := ACdsCfg.FieldByName('SIS_VALCFG').AsString;
  end;
end;

class function TCfgRepositorioContabilidade.fDigitoPatrimonialLiquidoOK(ACdsCfg: TUniClientDataSet): Boolean;
begin
  Result := not fHouveMudancaMascaraContabilPatrimonioLiquido(ACdsCfg) ;
  if not Result then
  begin
    fMensagem('','Houve mudança na configuração (CFG_MSKCON), atualize a informação da configuração (CFG_DIGPLI)!',['&Ok']);
  end;
end;

class function TCfgRepositorioContabilidade.fHouveMudancaMascaraContabil(ACdsCfg: TUniClientDataSet): Boolean;
var
  strMascaraContabilNova, strMascaraContabilAntiga : string ;
  cdsAux: TUniClientDataSet ;
  strMsg: string ;
  intRetornoMsg: integer ;
begin
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_MSKCON') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;
    strMascaraContabilNova := cdsAux.FieldByName('SIS_VALCFG').AsString ;
  finally
    FreeAndNil(cdsAux) ;
  end;

  strMascaraContabilAntiga := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_MSKCON',VS_strCodEmp]) ;
  if not fEmptyStr(strMascaraContabilAntiga) then
  begin
    if strMascaraContabilAntiga <> strMascaraContabilNova then
    begin
      strMsg := ' Foi identificado mudança na mascara contábil[CFG_MSKCON], nova['+strMascaraContabilNova+'] antiga['+strMascaraContabilAntiga+'].'+#13#10 ;
      strMsg := strMsg + ' Essa mudança pode prejudicar a validação das contas contábeis sintéticas.'+#13#10 ;
      strMsg := strMsg + ' Deseja continuar mesmo assim?' ;
      intRetornoMsg := fMensagem('ATENÇÃO!', strMsg, ['&Sim', '&Não'], 2) ;
      result := intRetornoMsg = 1 ;
      exit ;
    end;
  end;

  Result := True ;
end;

class function TCfgRepositorioContabilidade.fHouveMudancaMascaraContabilPatrimonioLiquido(
  ACdsCfg: TUniClientDataSet; const AMascaraContabil:string=''): Boolean;
var
  strMascaraContabil : string ;
  strMascaraPatrimonio : string ;
  cdsAux: TUniClientDataSet;
begin
  Result := False ;
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_DIGPLI') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    strMascaraPatrimonio := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    if fEmptyStr(AMascaraContabil) then
    begin
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_MSKCON') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
      cdsAux.Filtered := True;
      strMascaraContabil := fSplitContaContabil(cdsAux.FieldByName('SIS_VALCFG').AsString,2) ;
    end
    else
    begin
      strMascaraContabil := fSplitContaContabil(AMascaraContabil,2) ;
    end;

  finally
    FreeAndNil(cdsAux) ;
  end;

  if not fEmptyStr(strMascaraPatrimonio.Replace('.','')) then
  begin
    Result := Length(strMascaraContabil.Replace('.','')) <> Length(strMascaraPatrimonio.Replace('.','')) ;
  end;
end;

class function TCfgRepositorioContabilidade.fMudouSomenteExportacaoParaNao(
  ACdsCfg: TUniClientDataSet): Boolean;
var
  LCdsAux: TUniClientDataSet ;
  LstrSomenteExportacaoNova: String ;
  LstrSomenteExportacaoAntiga: String ;
  LstrContabilidadeAtivada: string ;
begin
  Result := True ;
  LstrContabilidadeAtivada := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_UTICON',VS_strCodEmp]) ;
  if LstrContabilidadeAtivada <> 'S' then
    exit ;

  LCdsAux := TUniClientDataSet.Create(Nil);
  try
    LCdsAux.Data := ACdsCfg.Data;
    LCdsAux.Filtered := False;
    LCdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_EXPCTB') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    LCdsAux.Filtered := True;
    LstrSomenteExportacaoNova := LCdsAux.FieldByName('SIS_VALCFG').AsString ;
  finally
    FreeAndNil(LCdsAux) ;
  end;

  LstrSomenteExportacaoAntiga := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_EXPCTB',VS_strCodEmp]) ;

  if (LstrSomenteExportacaoAntiga = 'S') and (LstrSomenteExportacaoNova = 'N') then
  begin
    Result := fChamaTelaGravando(fValidarPlanoContasSomenteExportacao) ;
  end ;

end;

class function TCfgRepositorioContabilidade.fRepeteContaReduziadaEcdOK(
  ACdsCfg: TUniClientDataSet): Boolean;
var
  cdsAux: TUniClientDataSet;
  strEcd: string ;
  strContaReduzidaRepetida: string ;
begin
  Result := False ;
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_EXPECD') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    strEcd := cdsAux.FieldByName('SIS_VALCFG').AsString ;
    if strEcd = 'S' then
    begin
      cdsAux.Filtered := False;
      cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_RPCTRD') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
      cdsAux.Filtered := True;
      strContaReduzidaRepetida := cdsAux.FieldByName('SIS_VALCFG').AsString ;

      if strContaReduzidaRepetida = 'S' then
      begin
        fMensagem('','Não é permitido repetir conta reduzida [CFG_RPCTRD] quando o ECD estiver habilitado!',['&Ok']);
        exit ;
      end;

    end;
    Result := True ;
  finally
    FreeAndNil(cdsAux) ;
  end;
end;

class function TCfgRepositorioContabilidade.fRetornaPropertiesRepositorio(
  const ACfg: string; ACfgRepositorio: Pointer; ARepositoryItemClass: TcxEditRepositoryItemClass): TcxCustomEditProperties;
var
  LCompRepositorio : TComponent ;
  LItemRepositorio: TcxEditRepositoryItem ;
  strName: string ;
begin
  strName := PREFIXONOMEPROPREPOSITORIO + ACfg ;

  LCompRepositorio := TfrmCfgRepositorio(ACfgRepositorio).cxRepositorio.FindComponent(strName) ;
  if not Assigned(LCompRepositorio) then
  begin
    LItemRepositorio := TfrmCfgRepositorio(ACfgRepositorio).cxRepositorio.CreateItem(ARepositoryItemClass) ;
    LItemRepositorio.Name := strName ;
  end
  else
  begin
    LItemRepositorio := TcxEditRepositoryItem(LCompRepositorio) ;
  end;

  result := LItemRepositorio.Properties ;
end;

class function TCfgRepositorioContabilidade.fTemIgual(
  ACdsCfg: TUniClientDataSet; ArrCfgs: array of string): boolean;
var
    intCnt, intCnt2 : Integer;
    ArrCfgsCopia : array of string;
    strValorCfg : string;
begin
  Result := False;

  SetLength(ArrCfgsCopia, Length(ArrCfgs));
  for intCnt := Low(ArrCfgs) to High(ArrCfgs) do
    ArrCfgsCopia[intCnt] := ArrCfgs[intCnt];

  for intCnt := Low(ArrCfgs) to High(ArrCfgs) do
  begin
    strValorCfg := fBuscaCfgSis(ACdsCfg, ArrCfgs[intCnt]);
    if fEmptyStr(strValorCfg) then
      Continue;
    for intCnt2 := Low(ArrCfgsCopia) to High(ArrCfgsCopia) do
    begin
      if ArrCfgsCopia[intCnt2] <> ArrCfgs[intCnt] then
      begin
        if ACdsCfg.FindKey([ArrCfgsCopia[intCnt2]]) then
        begin
          if (strValorCfg = ACdsCfg.FieldByName('SIS_VALCFG').AsString) then
          begin
            fMensagem('ATENÇÃO!', 'As Configurações "' + ArrCfgsCopia[intCnt2] + '" e "' + ArrCfgs[intCnt] + '" estão com os valores iguais!', ['&OK']);
            Result := True;
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

class function TCfgRepositorioContabilidade.fValida(ACdsCfg: TUniClientDataSet;
  strCodCfg: string): boolean;
begin
  Result := True;
  If (ACdsCfg.FindKey([strCodCfg])) Then
  Begin
    if fEmptyStr(ACdsCfg.FieldByName('SIS_VALCFG').AsString) then
    begin
      fMensagem('ATENÇÃO!', '"' + ACdsCfg.FieldByName('SIS_DESCRI').AsString + '" deve ser preenchido!', ['&OK']);
      Result := False;
    end;
  End;
end;

class function TCfgRepositorioContabilidade.fValidaDigitoIdentificadorContabilidade(
  ACdsCfg: TUniClientDataSet): Boolean;
begin
  Result := True;

  if not fValida(ACdsCfg, 'CFG_DIGATI') then
    Exit(False);

  if not fValida(ACdsCfg, 'CFG_DIGPAS') then
    Exit(False);

  if not fValida(ACdsCfg, 'CFG_DIGREC') then
    Exit(False);

  if not fValida(ACdsCfg, 'CFG_DIGDES') then
    Exit(False);

  if not fValida(ACdsCfg, 'CFG_DIGAPU') then
    Exit(False);

  if fTemIgual(ACdsCfg, ['CFG_DIGATI', 'CFG_DIGPAS', 'CFG_DIGREC', 'CFG_DIGDES', 'CFG_DIGAPU', 'CFG_DIGCUS', 'CFG_DIGOUT']) then
    Exit(False);

end;

class function TCfgRepositorioContabilidade.fValidaDigPliOK(
  ACdsCfg: TUniClientDataSet): Boolean;
var
  cdsAux: TUniClientDataSet;
  LstrUtiCon: string ;
  LstrExpCtb: string ;
  LstrDigPli: String ;
begin
  Result := False ;
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_UTICON') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    LstrUtiCon := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_EXPCTB') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    LstrExpCtb := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_DIGPLI') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    LstrDigPli := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    if (LstrUtiCon = 'S') and (LstrExpCtb = 'N') and (fEmptyStr(LstrDigPli)) then
    begin
      fMensagem('','Quando a CFG_EXPCTB desligada, a CFG_DIGPLI deve ser informada!',['&Ok']);
      exit ;
    end;
    Result := True ;
  finally
    FreeAndNil(cdsAux) ;
  end;
end;

class function TCfgRepositorioContabilidade.fValidaPlanoContasFaturamentoOK(
  ACdsCfg: TUniClientDataSet): Boolean;
var
  cdsAux: TUniClientDataSet;
  LstrCtaFat: string ;
  LstrCtaSai: string ;
begin
  Result := False ;
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_CTAFAT') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    LstrCtaFat := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_CTASAI') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;

    LstrCtaSai := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    if (LstrCtaSai = 'S') and (LstrCtaFat = 'N') then
    begin
      fMensagem('','Quando a CFG_CTASAI for habilitada, a CFG_CTAFAT também deve ser habilitada!',['&Ok']);
      exit ;
    end;
    Result := True ;
  finally
    FreeAndNil(cdsAux) ;
  end;
end;

class function TCfgRepositorioContabilidade.fValidaHisTpl(ACdsCfg: TUniClientDataSet): boolean;
var
  cdsAux: TUniClientDataSet;
  LstrHisTpl, LstrConEmp, LstrConHis: string ;
begin
  Result := False ;
  cdsAux := TUniClientDataSet.Create(Nil);
  try
    cdsAux.Data := ACdsCfg.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_HISTPL') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;
    LstrHisTpl := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_CONEMP') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;
    LstrConEmp := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    if (LstrHisTpl = 'S') and (LstrConEmp <> 'S') then
    begin
      fMensagem('','Ao habilitar a CFG_HISTPL, a CFG_CONEMP também deve estar habilitada!',['&Ok']);
      exit ;
    end;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_CONHIS') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
    cdsAux.Filtered := True;
    LstrConHis := cdsAux.FieldByName('SIS_VALCFG').AsString ;

    if (LstrHisTpl = 'S') and (LstrConHis = 'S') then
    begin
      fMensagem('','CFG_HISTPL e CFG_CONHIS não podem ser habilitadas juntas!',['&Ok']);
      exit ;
    end;

    Result := True ;
  finally
    FreeAndNil(cdsAux) ;
  end;
end;

class function TCfgRepositorioContabilidade.fValidaCFG_CRDSEQ(ACdsCfg: TUniClientDataSet): boolean;
var LTamSeq: integer;
    LTamSeqMaiorDoQueVarCRDTAM: integer;
    LTamSeqContaRedDigitada: integer;
    LCaracASeremPerdidos: string;
begin
  Result := True;
  If ACdsCfg.FindKey(['CFG_UTICON']) Then
  Begin
    If ACdsCfg.FieldByName('SIS_VALCFG').AsString = 'S' Then
    Begin
      If ACdsCfg.FindKey(['CFG_CRDTAM']) Then
      Begin
        LTamSeq := ACdsCfg.FieldByName('SIS_VALCFG').AsInteger;
        If (ACdsCfg.FindKey(['CFG_CRDSEQ'])) And
             (length(ACdsCfg.FieldByName('SIS_VALCFG').AsString) <> LTamSeq ) Then
        Begin
          LTamSeqContaRedDigitada := length(ACdsCfg.FieldByName('SIS_VALCFG').AsString);
          If (LTamSeqContaRedDigitada < LTamSeq ) Then
          Begin
            ACdsCfg.Edit;
            ACdsCfg.FieldByName('SIS_VALCFG').AsString := fPreencheEspaco(ACdsCfg.FieldByName('SIS_VALCFG').AsString, LTamSeq, false, '0');
            ACdsCfg.Post;
          End
          else
          Begin
            LTamSeqMaiorDoQueVarCRDTAM := length(ACdsCfg.FieldByName('SIS_VALCFG').AsString) - LTamSeq;
            LCaracASeremPerdidos := Copy( ACdsCfg.FieldByName('SIS_VALCFG').AsString, 1, LTamSeqMaiorDoQueVarCRDTAM);
            LCaracASeremPerdidos := StringReplace(LCaracASeremPerdidos, '0', '', [rfReplaceAll]);

            If LCaracASeremPerdidos <> '' Then
            Begin
              fMensagem('ATENÇÃO!', 'O sequencial de controle da conta reduzida no Plano de Contas Automática ( CFG_CRDSEQ ), está com o tamanho maior do que o tamanho do campo definido na configuração CFG_CRDTAM. Favor Verificar, pois se o campo for truncado, informações serão perdidas!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              ACdsCfg.Edit;
              ACdsCfg.FieldByName('SIS_VALCFG').AsString := Copy( ACdsCfg.FieldByName('SIS_VALCFG').AsString, LTamSeqMaiorDoQueVarCRDTAM + 1, LTamSeqContaRedDigitada - LTamSeqMaiorDoQueVarCRDTAM);
              ACdsCfg.Post;
            End;
          End;
        End;
      End;
    End;
  End;
end;


class function TCfgRepositorioContabilidade.fValidarParametros(
  ACdsCfg: TUniClientDataSet): boolean;
begin
  result := False ;
  if not fDigitoPatrimonialLiquidoOK(ACdsCfg) then
  begin
    exit ;
  end;

  if not fRepeteContaReduziadaEcdOK(ACdsCfg) then
  begin
    exit ;
  end;

  if not fValidaDigitoIdentificadorContabilidade(ACdsCfg) then
  begin
    exit ;
  end;

  if not fHouveMudancaMascaraContabil(ACdsCfg) then
  begin
    exit ;
  end;

  if not fMudouSomenteExportacaoParaNao(ACdsCfg) then
    exit ;

  if not fValidaPlanoContasFaturamentoOK(ACdsCfg) then
    exit ;

  if not fValidaDigPliOK(ACdsCfg) then
    exit ;

  if not fValidaHisTpl(ACdsCfg) then
    exit;

  if not fValidaCFG_CRDSEQ(ACdsCfg) then
    exit;

  result := True ;
end;

class function TCfgRepositorioContabilidade.fValidarPlanoContasSomenteExportacao(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  result := fValidarPlanoContasSomenteExportacaoExec(ApgbProgresso, TMostraMensagemErroValidacao.pMostra) ;
end;

class procedure TCfgRepositorioContabilidade.pAdicionaConfiguracoes;
begin
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_UTICON','Utilizar Rotina de Contabilidade?'                                                                                 ,'N'                           ,'CONTABILIDADE', False, 0, 'N', 'S', 'S');
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_RPCTRD','Permite Repetir Conta Reduzida no Plano de Contas?'                                                                ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EXPECD','Exporta SPED ECD?'                                                                                                 ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_MSKCON','Máscara do Plano Contábil:'                                                                                        ,'99.99.99.99.999'             ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_SQCNCO','Sequencial de documento'                                                                                           ,'1'                           ,'CONTABILIDADE', True);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_OPCPLC','Opção para plano de contas de clientes'                                                                            ,'A'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_GRPNCO','Grupo do plano de contas para sequencia automática - Clientes'                                                     ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CCTPAS','Na contabilização do "CTP" considerar a configuração "CFG_CTP_AS" que remove lançamentos que já foram importados ' +
                                                         'pela opção "BAN"?'                                                                                                 ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_GRPNCF','Grupo do plano de contas para sequencia automática - Fornecedores'                                                 ,'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_GRPNCO"'
                                                                                                                                                                                         ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_LOTCON','Tamanho do lote de gravação da geração dos lançamentos contábeis'                                                  ,'500'                         ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_INVHIS','Histórico Padrão para quando há inversão de contas'                                                                ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EXCREP','Utilizar a empresa da baixa para gerar os lançamentos de CTR ( Contas a Receber )?'                                ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EVENEC','Eventos que não serão exportados para a Contabilidade'                                                             ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGATI','Dígito identificador - "Ativo"'                                                                                    ,'1'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGPAS','Dígito identificador - "Passivo"'                                                                                  ,'2'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGREC','Dígito identificador - "Receita"'                                                                                  ,'3'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGDES','Dígito identificador - "Despesa"'                                                                                  ,'4'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGAPU','Dígito identificador - "Apuração"'                                                                                 ,'5'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONLUC','Conta para lançamento "LUCRO"'                                                                                     ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONPRE','Conta para lançamento "PREJUÍZO"'                                                                                  ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONRES','Conta para "APURAÇÃO DO RESULTADO DO EXERCÍCIO"'                                                                   ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EXUCCP','Na geração dos lançamentos contábeis, tipo CTP, exportar "Uso e Consumo"?'                                         ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CCCEMP','Utilizar a mesma conta contábil de cada cliente para todas as lojas?'                                              ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_POSORD','Posição da CFG_MSKCON onde a ordenação não será mais pelo código e sim pela descrição do plano de contabil no Balancete (20 = Não agrupa)'   ,'20'                          ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PLAPAI','Posição da CFG_MSKCON onde deve ocorrer o agrupamento dos planos contábeis no Balancete (20 = Não agrupa)'                                   ,'20'                          ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_SENLCO','Senha para bloqueio do lançamento contábil manual'                                                                 ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_LTCONT','Utilizar manutenção de lote contábil?'                                                                             ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_OBRCCU','Obriga informação de centro de custos para contas de receitas e despesas?'                                         ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONONL','Gerar movimento On-Line da contabilidade?'                                                                         ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_MOVBAN','Exibir opção de gerar movimento contábil na tela de "Movimentação de Conta Banco"?'                                ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DEPIMO','Depreciação de Imobilizado/Patrimônio'                                                                             ,'1'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CRDCON','Utilizar Conta Reduzida no Plano de Contas:'                                                                       ,'2'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CRDSEQ','Conta Reduzida no Plano de Contas Automática - Sequencial de controle:'                                            ,'1'                           ,'CONTABILIDADE', True);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CRDTAM','Conta Reduzida no Plano de Contas Automática - Tamanho do da Conta Reduzida:'                                      ,'5'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_SPDECF','Exporta SPED ECF?'                                                                                                 ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_LYCONT','Layout para importação da folha de pagamento e patrimonial:'                                                       ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CCECTR','Conta contábil para lançamento duplo quando a empresa de cadastro (CTR_CODEMP) for diferente da empresa da baixa (CTR_EMPBAI)',''                 ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_TRDCZE','Efetuar trava registro a registro confrontando a soma dos débitos com a soma dos créditos?'                        ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_IMOSCO','Cadastrar Imobilizado/Patrimônio sem Controle Contábil ?'                                                          ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_GERMCT','Por default campo GERAR MOVIMENTO CONTÁBIL'                                                                        ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_FCONCC','Efetuar os Fechamentos Contábeis por Centro de Custo?'                                                             ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTPADF','Quando exportar duplicatas de contas a pagar provenientes de faturamento com adiantamento=sim utilizar como data de lançamento:' ,'1'             ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTPAGR','Quando exportar os lançamentos do tipo CTP/PCP, agrupar as duplicatas gerando apenas um lançamento para registros idênticos?'    ,'N'             ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CCEADT','Conta contábil para lançamento duplo, quando a empresa de cadastro (ADT_CODEMP) for diferente da empresa da baixa (CTR_EMPBAI)',''                ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTRPVI','Permitir lançar CTP/CTR à vista mesmo com o parametrização ENT/SAI à vista configurada nos parâmetros da contabilidade?'    ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTRNUM','Permitir somente números na conta reduzida?'                                                                                ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGPLI','Dígito Identificador - "Patrimônio Líquido"'                                                                                ,''                   ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGCUS','Dígito identificador - "Custo"'                                                                                    ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DESCUP','Permitir informar a descrição do cadastro de Plano de Contas com letras maiúsculas e minúsculas?'                  ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONTRA','Realizar transferência entre Lucro e Prejuízo no final do exercício?'                                              ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGCOM','Dígito identificador - "Compensação"'                                                                              ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CSACST','Parametrizar CST com CFOPs no Tipo Lançamento "SAI"?'                                                              ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_TIPCAR','Contabilizar o valor bruto do cartão pela data de cadastro?'                                                       ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CAGRDP','Contabilizar agrupamento de duplicatas?'                                                                           ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_LIGPDD','Habilitar Títulos PDD nos parâmetros da contabilidade?'                                                            ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EXPCTB','Utiliza o módulo contábil apenas para a exportação de dados?'                                                      ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_MAXHPD','Quantidade máxima de caracteres na descrição do histórico padrão'                                                  ,'40'                          ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_AGRLAN','Efetua os lançamentos de forma Sintética, para os CFOPs pertencentes ao mesmo Parâmetro Contábil'                  ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_NATDSC','Quando exportar lançamentos do tipo ENT/SAI usar a descrição da naureza operação?'                                 ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PCJUDT','Plano de contas para identificar lançamentos de juros no detalhe do CADPAG ao gerar movimento CTP'                 ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_ADTORD','Portador para lançamentos "ADT" originados do caixa na forma de pagamento "Ordem de Pagamento" '                   ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PCDEDT','Plano de contas para identificar lançamentos de descontos no detalhe do CADPAG ao gerar movimento CTP'             ,''                            ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DESMVA','Considerar a empresa informada na tela de desmembramento de valores'                                               ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_MKTPLA','Contabilizar NF por tipo de marketplace'                                                                           ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTRAGR','Gerar títulos agrupados CTR pela empresa de origem'                                                                ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONGRU','Contabilizar por linha/grupo de produtos'                                                                          ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONEMP','Parâmetros da contabilidade por empresa logada?'                                                                   ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PRECTP','Considerar previsões de contas a pagar na contabilidade?'                                                          ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PATCCO','Apresentar o centro de custo nas contas patrimoniais?'                                                             ,'S'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DESMSI','Contabiliza contrapartida de forma agrupada por empresa, no desmembramento de valores?'                            ,'N'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CCECTP','Conta contábil para lançamento duplo quando a empresa de cadastro (CTP_CODEMP) for diferente da empresa da baixa (CTP_EMPBAI)',''                 ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_ALTFIN','Inclusão/alteração de doc. no controle financeiro quando não tiver correspondente contábil cadastrado:'            ,'0'                           ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_TRFCEC','Apresentar cfop _949 na linha de "(-) transferências" do quadro "3 - saídas", na rotina de conferência de estoque contábil' ,'S'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CRECTR','Descontar o crédito utilizado da coluna dinheiro quando tiver o mesmo CTR_SEQCON?'                                          ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_SUBCNT','Ativar desmembramento em subcontas para clientes/fornecedores?'                                                             ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EVESAI','Centro de custo a ser considerado quando não tiver centro de custo nas contas contábeis de (Receita/Despesa/Custo)'         ,' '                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTASAI','Ativar o plano de contas na parametrização do SAI?'                                                                         ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTACNT','Ativar o plano de contas na parametrização do COE/COS?'                                                                     ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTPVEL','Ao contabilizar o CTP usar a coluna CTP_VEIONF para definir se o lançamento é Avulso/Fatura, quando tiver qualquer valor na coluna CTP_CODVEL?','N','CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CRCCXX','Ativar a contabilização pela forma de pagamento do caixa(CADRCXX) no CRC?'                                                   ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EXCPAP','Utilizar a empresa da baixa para gerar os lançamentos de CTP ( Contas a Pagar )?'                                            ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_ABRECO','Usar as tabelas CONFRE/RECTNF para usar a parametrização "Abrev.Prod" no COE/COS?'                                           ,'S'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EMPATI','Plano Contábil para lançamento do Empréstimo entre Empresas - Ativo'                                                         ,''                   ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_EMPPAS','Plano Contábil para lançamento do Empréstimo entre Empresas - Passivo'                                                       ,''                   ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CARHUB','Apresentar os parâmetros para a contabilização das despesas provenientes de operação com "HUB"?'                             ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CONHIS','Utilizar histórico contábil por plano de contas gerencial?'                                                                  ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_CTRFAT','Desconsiderar o filtro FIS_DTAENT=CTR_DTACAD para determinar pagamento fatura no CTR?'                                       ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DIGOUT','Dígito identificador - "Outras"'                                                                                             ,''                   ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_NATCNT','Ao processar o ENT usar a Natureza da Operação da Capa ou do Item? [Sim - Capa | Não - Item]'                                ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_FECCNT','Vincular fechamento contábil com o fechamento Fiscal/Financeiro/Estoque?'                                                    ,'S'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PICORF','Alíquota PIS/COFINS a contabilizar sobre receitas financeiras'                                                               ,'Desabilitado'       ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_IMPAGR','No Desmembramento de Valores para Entradas de Mercadorias/Serviços, os impostos serão lançados de forma agrupada?'           ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_HISTPL','Histórico Padrão por Tipo Plano de Contas?'                                                                                  ,'N'                  ,'CONTABILIDADE', False, 0, 'N', 'S', 'S');
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_SPROEM','Ao processar lançamentos do SAI, desconsiderar os produtos com DET_PROEMB = S?'                                              ,'N'                  ,'CONTABILIDADE', False, 0, 'N', 'S', 'S');
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_ADTOCC','Quando habilitada, permite contabilizar adiantamentos convertidos em crédito no CTR?'                                        ,'S'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_DESCOB','Parâmetro para lançamento das Despesas de Cobranças do Contas à Receber nos Lançamentos Contábeis?'                          ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_AJUICM','Apresentar os parâmetros para a contabilização do Ajuste/Estornos de ICMS?'                                                  ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_PARNAT','Na geração dos Movimentos Contábeis, apresentar CFOPs que não tenham Natureza de Operação vinculada?'                        ,'N'                  ,'CONTABILIDADE', False);
  TfrmCfgRepositorio.pAdicionarConfiguracao('CFG_AJUPAR','Exibir os Parâmetros "AJE-Ajuste de Entrada" e "AJS-Ajuste de Saída"?'                                                       ,'N'                  ,'CONTABILIDADE', False);
end;

class procedure TCfgRepositorioContabilidade.pInicializaParametros(ACfgRepositorio: Pointer);
begin
  MascaraContabilAlteradaRepositorio := '' ;
  TfrmCfgRepositorio(ACfgRepositorio).btnOpen_LayoutContabil.Properties.OnButtonClick := pbtnOpen_LayoutContabilPropertiesButtonClick;
  TfrmCfgRepositorio(ACfgRepositorio).mskConPatrimonioLiquido.Properties.EditMask := fMskConPatrimonioLiquido ;
  TfrmCfgRepositorio(ACfgRepositorio).edtConMascaraContabil.Properties.OnEditValueChanged := edtConMascaraContabilPropertiesEditValueChanged ;
end;

class procedure TCfgRepositorioContabilidade.pbtnOpen_LayoutContabilPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCriarForm(TfrmConfiguracoesImportacaoContabil);
end;

class procedure TCfgRepositorioContabilidade.pCfgADTORDPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  edtCodigo: TEditFocus;
  edtDescri: TEditFocus;
  arrSelecao: TConsultasArray;
  Key: Char;
  LCustomForm: TForm ;
begin

  Try

    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);
    try
      Key := '/';
      LCustomForm := TForm(GetParentForm(TControl(Sender))) ;
      If fPesqPortador(conSimples, LCustomForm, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      Begin
        TcxButtonEdit(Sender).EditValue := edtCodigo.Text;
        TcxButtonEdit(Sender).PostEditValue ;
      End
      Else
      Begin
        if fMensagem('ATENÇÃO', 'Nenhum portador foi selecionado, Deseja Limpar o Valor do Campo ?', ['&Sim', '&Não'], 2) = 1 then
        Begin
          TcxButtonEdit(Sender).EditValue := '';
          TcxButtonEdit(Sender).PostEditValue ;
        End;
      End;

    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;


  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

end;

class procedure TCfgRepositorioContabilidade.pCfgPCDEDTPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LfrmConfiguracaoPlanoContasJurosDetalheCTP: TfrmConfiguracaoPlanoContasJurosDetalheCTP ;
begin
  pCriarFormularios(TfrmConfiguracaoPlanoContasJurosDetalheCTP, LfrmConfiguracaoPlanoContasJurosDetalheCTP) ;
  try
    LfrmConfiguracaoPlanoContasJurosDetalheCTP.Tipo := pcccDescontos ;
    LfrmConfiguracaoPlanoContasJurosDetalheCTP.ShowModal ;
  finally
    pFreeAndNil(LfrmConfiguracaoPlanoContasJurosDetalheCTP) ;
  end;
end;

class procedure TCfgRepositorioContabilidade.pCfgPCJUDTPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LfrmConfiguracaoPlanoContasJurosDetalheCTP: TfrmConfiguracaoPlanoContasJurosDetalheCTP ;
begin
  pCriarFormularios(TfrmConfiguracaoPlanoContasJurosDetalheCTP, LfrmConfiguracaoPlanoContasJurosDetalheCTP) ;
  try
    LfrmConfiguracaoPlanoContasJurosDetalheCTP.ShowModal ;
  finally
    pFreeAndNil(LfrmConfiguracaoPlanoContasJurosDetalheCTP) ;
  end;
end;

class procedure TCfgRepositorioContabilidade.pCfgPICORFPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  LfrmConfiguracaoPisCofinsReceitaFinanceira: TfrmConfiguracaoPisCofinsReceitaFinanceira;
  LCdsCfgSis : TUniClientDataset ;
begin
  pCriarFormularios(TfrmConfiguracaoPisCofinsReceitaFinanceira, LfrmConfiguracaoPisCofinsReceitaFinanceira) ;
  try
    LfrmConfiguracaoPisCofinsReceitaFinanceira.ShowModal ;

    LCdsCfgSis := TfrmCfgSistema(GetParentForm(TControl(Sender))).cdsCfgSis ;
    If (LCdsCfgSis.State = dsBrowse) Then
      LCdsCfgSis.Edit;
    LCdsCfgSis.FieldByName('SIS_VALCFG').AsString := fCfgSisL('PICORF', VarString);
    LCdsCfgSis.Post;
  finally
    pFreeAndNil(LfrmConfiguracaoPisCofinsReceitaFinanceira) ;
  end;
end;

class procedure TCfgRepositorioContabilidade.pCfgCRDSEQPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
Var
  LTamSeq : integer;
begin
  LTamSeq := fCfgSis('CRDTAM', varInteger);
  Try
    StrToInt64(DisplayValue);
    DisplayValue := fStrZero(StrToInt64(DisplayValue), LTamSeq);
  Except
    DisplayValue :=  fPreencheEspaco('1', LTamSeq, false, '0');
  End;
end;

class procedure TCfgRepositorioContabilidade.pRetProperties(strCodCfg: String;
  var AProperties: Pointer; var intInd: Integer; ACfgRepositorio: Pointer);
begin
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_UTICON
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_RPCTRD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_EXPECD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).edtConMascaraContabil.Properties);//CFG_MSKCON
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).edtCodSeq_Tam_10.Properties);//CFG_SQCNCO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgAnaSin_A_S.Properties);//CFG_OPCPLC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).edtTexto_Tam255.Properties);//CFG_GRPNCO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CCTPAS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).edtTexto_Tam255.Properties);//CFG_GRPNCF
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).spnInteger.Properties);//CFG_LOTCON
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConHisPad.Properties);//CFG_INVHIS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_EXCREP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnCfgEveNec.Properties);//CFG_EVENEC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGATI', ACfgRepositorio));//CFG_DIGATI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGPAS', ACfgRepositorio));//CFG_DIGPAS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGREC', ACfgRepositorio));//CFG_DIGREC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGDES', ACfgRepositorio));//CFG_DIGDES
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGAPU', ACfgRepositorio));//CFG_DIGAPU
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CONLUC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CONPRE
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CONRES
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_EXUCCP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CCCEMP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).cmbBalancete.Properties);//CFG_POSORD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).cmbBalancete.Properties);//CFG_PLAPAI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).edtSenha.Properties);//CFG_SENLCO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_LTCONT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_OBRCCU
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CONONL
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_MOVBAN
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgDepreciacaoImobilizado.Properties);//CFG_DEPIMO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgCRDCON.Properties);//CFG_CRDCON
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_CRDSEQ', ACfgRepositorio));//CFG_CRDSEQ
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).spnDia.Properties);//CFG_CRDTAM
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_SPDECF
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnOpen_LayoutContabil.Properties);//CFG_LYCONT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CCECTR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_TRDCZE
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_IMOSCO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgGeraMovContabil.Properties);//CFG_GERMCT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_FCONCC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgCTPComAdiantamentoFaturamento.Properties);//CFG_CTPADF
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTPAGR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CCEADT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTRPVI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTRNUM
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).mskConPatrimonioLiquido.Properties);//CFG_DIGPLI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGCUS', ACfgRepositorio));//CFG_DIGCUS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_DESCUP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CONTRA
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGCOM', ACfgRepositorio));//CFG_DIGCOM
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CSACST
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_TIPCAR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CAGRDP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_LIGPDD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_EXPCTB
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_MAXHPD', ACfgRepositorio));//CFG_MAXHPD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_AGRLAN
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_NATDSC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_PCJUDT', ACfgRepositorio));//CFG_PCJUDT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_ADTORD', ACfgRepositorio));//CFG_ADTORD
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_PCDEDT', ACfgRepositorio));//CFG_PCDEDT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_DESMVA
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_MKTPLA
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTRAGR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CONGRU
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CONEMP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_PRECTP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_PATCCO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_DESMSI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_CCECTP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_ALTFIN', ACfgRepositorio));//CFG_ALTFIN
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_TRFCEC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CRECTR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_SUBCNT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConEvento.Properties);//CFG_EVESAI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTASAI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTACNT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTPVEL
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CRCCXX
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_EXCPAP
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_ABRECO
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_EMPATI
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).btnConPlaNco.Properties);//CFG_EMPPAS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CARHUB
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CONHIS
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_CTRFAT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_DIGOUT', ACfgRepositorio));//CFG_DIGOUT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_NATCNT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_FECCNT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, fCustomizePropertyCfgRepositorio('CFG_PICORF', ACfgRepositorio));//CFG_PICORF
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_IMPAGR
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_HISTPL
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_SPROEM
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_ADTOCC
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_DESCOB
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_AJUICM
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_PARNAT
  pRetPropertiesInterno(strCodCfg, AProperties, intInd, TfrmCfgRepositorio(ACfgRepositorio).rdgSimNao_S_N.Properties);//CFG_AJUPAR
end;

class procedure TCfgRepositorioContabilidade.pRetPropertiesInterno(
  strCodCfg: String; var AProperties: Pointer; var intInd: Integer;
  ACfgRepositorio: Pointer);
begin
  If strCodCfg = arrCamposCfg[fInc(intInd)].strCodCfg Then
  begin
    AProperties := ACfgRepositorio ;
  end;
end;

{ TProCodContabilidade }

class function TProCodContabilidade.fSoma(var intVal: Integer;
  intSoma: Integer): Integer;
begin
  intVal := intVal + intSoma;
  Result := intVal + 1;
end;

class procedure TProCodContabilidade.pAdicionar(var arrProCod: TarrProCod;
  var intPosMat: Integer);
begin
  arrProCod[intPosMat].strNomArq := 'EVENEC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCFO';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEVE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLANCO';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISPAD';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LANCON';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLAINI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TPLACO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDRE';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PARCON';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCSE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTCON';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTLAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ABFCOG';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPIMO';
  arrProCod[intPosMat].strCodSeq := '006';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NATAJU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TABECF';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISLAN';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFLALU';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LYCONT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTACON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TSPCOA';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFLAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFCNF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFSLD';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PARDFC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNTDFC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SLDDFC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PARDVA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNTDVA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRDMPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTDMPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEDMPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISTMV';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MVDMPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DTDMPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DT2DMP';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NTEXPL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PARDRA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNTDRA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFMES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFCTA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LO2CON';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LO2LAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNFROL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUPRE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUVRE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUARE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUCRE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUSAL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APUCDE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTAJDT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PERGER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PERDET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRIRPG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRCSLG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRIRPD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRCSLD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRIRCN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRCSCN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRIRLN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRCSLN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APIRPG';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APIRPD';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APIRPE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APCSLG';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APCSLD';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'APCSPE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FECCDM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROTPL';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));
end;

{ TTraceContabilidade }

class procedure TTraceContabilidade.pSetQueryEvents(const AQuery: TUniQuery);
begin
  if Assigned(VS_objTraceViewerContabilidade) then
  begin
    VS_objTraceViewerContabilidade.SetQueryEvents(AQuery) ;
  end;
end;

{ TMostraMensagemErroValidacao }

class procedure TMostraMensagemErroValidacao.pMostra(
  const AdsErros: TUniClientDataset);
var
  LfrmErrosContabil : TfrmErrosContabil;
begin
  pCriarFormularios(TfrmErrosContabil, LfrmErrosContabil);
  try
    LfrmErrosContabil.cdsErros := AdsErros;
    LfrmErrosContabil.objUpdateContaContabil := Nil;
    LfrmErrosContabil.cxDadosDBTableViewTIPLAN.Visible := False ;
    LfrmErrosContabil.cxDadosDBTableViewORIGEM.Visible := False ;
    LfrmErrosContabil.cxDadosDBTableViewHISTOR.Visible := False ;
    LfrmErrosContabil.cxDadosDBTableViewDESVAL.Visible := False ;
    LfrmErrosContabil.cxDadosDBTableViewNATCFO.Visible := False ;
    LfrmErrosContabil.cxDadosDBTableViewPLANCO.Visible := False ;
    LfrmErrosContabil.ShowModal;
  finally
    pFreeAndNil(LfrmErrosContabil);
  end;
end;

{ TMetodosPlanoDeContasPorEmpresa }

class procedure TMetodosPlanoDeContasPorEmpresa.pCarregaPlanoDeContasPorEmpresa(
  const AstrTabela, AstrValorChave: String; var AcdsNCO: TUniClientDataSet);
begin
  if not fCfgSis('UTICON', varBoolean) then
    Exit ;

  if not Assigned(AcdsNCO) then
    exit;

  if fEmptyStr(AstrTabela) then
  begin
    fMensagem('ATENÇÃO!', 'Tabela não informada!', ['&Ok']);
    exit;
  end;

  AcdsNCO.EmptyDataSet ;

  AcdsNCO := TCarregaCdsContasPorEmpresa.New.fCarregar(
               TParametrosFormContasPorEmpresa.New
               .Tabela(AstrTabela)
               .ValorChave(AstrValorChave)
               .CampoChave(fCampoChave(AstrTabela))
               .CdsDados(AcdsNCO)
             );
end;

class procedure TMetodosPlanoDeContasPorEmpresa.pSalvaPlanoDeContasPorEmpresa(
  const AstrTabela, AstrValorChave: String; const AcdsNCO: TUniClientDataSet);
begin
  if not fCfgSis('UTICON', varBoolean) then
    Exit ;

  TSalvaCdsContasPorEmpresa.New.pSalvar(
               TParametrosFormContasPorEmpresa.New
               .Tabela(AstrTabela)
               .ValorChave(AstrValorChave)
               .CampoChave(fCampoChave(AstrTabela))
               .CdsDados(AcdsNCO)
             );
end;

initialization
  MascaraContabilAlteradaRepositorio := '' ;

end.
