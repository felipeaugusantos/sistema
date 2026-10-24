{**********************************************************}
{* UNIT RESPONSÁVEL PELO CARREGAMENTO DA DLL DE RELATÓRIO *}
{*******************************************************AF*}
unit untFuncoesRel2;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses TypesRel, untFuncoesSimples, untModulo, Windows, SysUtils, untFuncoesRelatorios,
  untModuloSPR, untTypesSistema, Variants, untTSQLTrace, untILiberacao;

  {****** Faturamento *******}

  Procedure pRelatorioFaturamento(relRelPed: TTipoRelFaturamento);
  Procedure pRelatorioFaturamentoDir(relRelPed: TTipoRelFaturamento);
  Procedure pRelatorioFaturamentoPar(relRelPed: TTipoRelFaturamento; varRegistro: TRegistroVarFaturamento; blnTemParametro: Boolean = TRUE; blnAbreDireto: Boolean = False);

  procedure prelfatgeral(prmDllRel: Pointer); External 'libRelFatGeral.dll' delayed;
  procedure prelfatevolucaovendas(prmDllRel: Pointer); External 'libRelFatEvolucaoVendas.dll' delayed;
  procedure prelfatmetas(prmDllRel: Pointer); External 'libRelFatMetas.dll' delayed;
  procedure prelfatcomissao(prmDllRel: Pointer); External 'libRelFatComissao.dll' delayed;
  procedure prelfatvendas(prmDllRel: Pointer); External 'libRelFatVendas.dll' delayed;
  function fSVN_RevisionRelFatGeral: String; stdcall; External 'libRelFatGeral.dll' delayed;
  function fSVN_RevisionRelFatEvolVendas: String; stdcall; External 'libRelFatEvolucaoVendas.dll' delayed;
  function fSVN_RevisionRelFatMetas: String; stdcall; External 'libRelFatMetas.dll' delayed;
  function fSVN_RevisionRelFatComissao: String; stdcall; External 'libRelFatComissao.dll' delayed;
  function fSVN_RevisionRelFatVendas: String; stdcall; External 'libRelFatVendas.dll' delayed;

  {****** Pedidos de Venda *******}

  Procedure pRelatorioPedidosDeVenda(relRelPed: TTipoRelPedidosDeVenda);
  Procedure pRelatorioPedidosDeVendaPar(relRelPed: TTipoRelPedidosDeVenda; varRegistro: TRegistroVarVenda; blnTemParametro: Boolean = TRUE);
  procedure prelpedidosdevenda(prmDllRel: Pointer); External 'libRelPedidosDeVenda.dll' delayed;
  function fSVN_RevisionRelPedVenda: String; stdcall; External 'libRelPedidosDeVenda.dll' delayed;

  {****** Bancarios Contabeis *******}

  procedure pRelatorioBancariosContabeis(relRelPed: TTipoRelBancariosContabeis);
  procedure prelbancarioscontabeis(prmDllRel: Pointer); External 'libRelBancariosContabeis.dll' delayed;
  function fSVN_RevisionRelBancarios: String; stdcall; External 'libRelBancariosContabeis.dll' delayed;

  {****** Cheques Pré *******}

  procedure pRelatorioChequesPre(relRelPed: TTipoRelChequesPre);
  procedure pRelatorioChequesPrePar(relRelPed: TTipoRelChequesPre; varRegistro: TRegistroVarChequesPre);
  procedure prelchequespre(prmDllRel: Pointer); External 'libRelChequesPre.dll' delayed;
  function fSVN_RevisionRelCheques: String; stdcall; External 'libRelChequesPre.dll' delayed;

  {****** Estatisticas *******}

  Procedure pRelatorioEstatisticas(relRelPed: TTipoRelEstatisticas);
  procedure prelestatistica(prmDllRel: Pointer); External 'libRelEstatistica.dll' delayed;
  function fSVN_RevisionRelEstatistica: String; stdcall; External 'libRelEstatistica.dll' delayed;

  {****** Contas a Pagar *******}

  Procedure pRelatorioContasAPagar(relRelPed: TTipoRelContasAPagar);
  procedure prelcontasapagar(prmDllRel: Pointer);External 'libRelContasAPagar.dll' delayed;
  function fSVN_RevisionRelContasPagar: String; stdcall; External 'libRelContasAPagar.dll' delayed;

  {****** Contas a Receber *******}

  Procedure pRelatorioContasAReceber(relRelPed: TTipoRelContasAReceber);
  procedure prelcontasareceber(prmDllRel: Pointer); External 'libRelContasAReceber.dll' delayed;
  procedure pSetLiberacaoRelContasAReceber(objLibera : ILiberacao); stdcall; External 'libRelContasAReceber.dll' delayed;
  function fSVN_RevisionRelContasReceber: String; stdcall; External 'libRelContasAReceber.dll' delayed;


  {****** Livros Fiscais *******}

  Procedure pRelatorioLivrosFiscais(relRelPed: TTipoRelLivrosFiscais);
  procedure prellivrosfiscais(prmDllRel: Pointer); External 'libRelLivrosFiscais.dll' delayed;
  function fSVN_RevisionRelFiscais: String; stdcall; External 'libRelLivrosFiscais.dll' delayed;

  {********* Estoque ***********}

  Procedure pRelatorioEstoque(relRelPed: TTipoRelEstoque);
  Procedure pRelatorioEstoquePar(relRelPed: TTipoRelEstoque; varRegistro: TRegistroVarEstoque; blnTemParametro: Boolean = TRUE);
  procedure prelestoque(prmDllRel: Pointer); External 'libRelEstoque.dll' delayed;
  function fSVN_RevisionRelEstoque: String; stdcall; External 'libRelEstoque.dll' delayed;

  {***********************}

  procedure pIniVariaveis(Var varRecVar: TRecVariaveis);
  procedure pIniModulos(Var modRecMod: TRecModulos);

Const
  CONJ_FATGERAL: set of TTipoRelFaturamento = [relFatEmiDiaria,
                                               relFatCtlTempoEspera,
                                               relFatItensVenMod,relFatRelOrc,relFatExtratoFatFuturo,relFatDocConfOutroCliente,
                                               relFatServicosCliente,relFatVenTransp,relFatLogLib,
                                               relFatDemonstracaoCamp,
                                               relFatTransferencias, relFatBocaCaixaVendedor,
                                               relFatConfDiariaCaixa, relFatDespAcessoria,
                                               relFatAltDescricaoFat, relFatComEntregadores,
                                               relFatEmprestimos, relFatDemonstraDespesas,
                                               relFatVendasPerdidas, relBrindesProfissionais, relFatReciboAvulso,
                                               relFatSepMercadoria,
                                               relFatDistrSherWill, relFatAltVendedorDoc,
                                               relFatDevolucoesVenda, relFatBonificacao, relFatAcompanhaPromocao,
                                               relFatLogAltEntregaFutura, relFatServAtendCliente,
                                               relFatMapDemonsEstoq, relFatDocumentoTipoEnt, relFatHistoricoRomaneio,
                                               relFatUsoConsumo, relFatLogLibRem, relFatDocsMIConf,
                                               relFatPedVendaFaturados, relFatEmiDiaMod3];
  CONJ_FATEVOLUCAOVENDAS: set of TTipoRelFaturamento = [relFatEvolVendas, relFatEvolVendasGrafico, relFatEvolVendasMes];
  CONJ_FATMETAS: set of TTipoRelFaturamento = [RelFatMetasClientes, relFatMetasVendedor, relFatMetasVendedorCtr, relFatMetasVendedorLitGal,
                                                relFatMetasVendedorLitragem, relFatMetasFornecValFat, relFatMetFaturamentoEmp,
                                                relFatMetasVendDeparProd, relFatMetasVendAtivCliente, relFatMetasVendedorValorGruMar,
                                                relFatMetasVendedorFrete, relFatMetasVendedorFatLiq];
  CONJ_FATCOMISSAO: set of TTipoRelFaturamento = [RelFatComGerente, relFatExtratoProfissional, relFatComVenPropLucro, relFatComVendedorMod1,
                                                  relFatComVendedor, RelComissaoVendedorCTRPrevia, relFatComMecanicos,
                                                  relFatComVendCndDes, relFatComVendPes, relFatComVendInd, relFatComVendFat, relFatComVendRec,
                                                  relFatComissaoEspecie, relFatComFatVend, relFatComVendDepart, relFatComDepart];
  CONJ_FATVENDAS: set of TTipoRelFaturamento = [relFatVenTipFat, relFatVendasMarkup, relFatVendasMarkupAndor, relFatVendasCondPagto,
                                                relFatVendasDiariasLoja, relFatVendasConcreto, relFatVendaConjunto, relFatTipoDoc,
                                                relFatMargemDocumento, relFatPorProduto, relFatComparatVenda, relFatItensVendEndEntrega,
                                                relFatVendasCompartilhadas, relFatVendaForPagDesc];
implementation

Uses
  untParCalculaPrecoCusto, untTConfiguracao, untLiberacaoFactory;


Function fCalculaPrecoCusto(fltPreCom,
                            fltDesF01,
                            fltDesF02,
                            fltDesF03,
                            fltDesF04,
                            fltDesF05,
                            fltDesF06,
                            fltIcmEnt,
                            fltIpiEnt,
                            fltFreEnt,
                            fltAcrFin,
                            fltSubsti,
                            fltValFre,
                            fltDesAdb,
                            fltSubFed,
                            fltTCIFCu,
                            fltTSCust,
                            fltDePiCo,
                            fltDeICMS,
                            fltFatReg: Double): Double;
  Var
    cpcParams: TParCalculaPrecoCusto;
Begin
  cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

  With cpcParams Do
  Begin
    curPreCom := fltPreCom;
    curDesF01 := fltDesf01;
    curDesF02 := fltDesf02;
    curDesF03 := fltDesf03;
    curDesF04 := fltDesf04;
    curDesF05 := fltDesf05;
    curDesF06 := fltDesf06;
    curICMSEnt:= fltIcmEnt;
    curIPIEnt := fltIpiEnt;
    curFrete  := fltFreEnt;
    curAcrFin := fltAcrFin;
    curSubsti := fltSubsti;
    curValFre := fltValFre;
    curDesAdb := fltDesAdb;
    curSubFed := fltSubFed;

    if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
    begin
      curTCIFCu := fltTCIFCu;
      curTSCust := fltTSCust;
      curDePiCo := fltDePiCo;
      curDeICMS := fltDeICMS;
      curFatReg := fltFatReg;
    end
    else
    begin
      curTCIFCu := 0;
      curTSCust := 0;
      curDePiCo := 0;
      curDeICMS := 0;
      curFatReg := 0;
    end;
  End;
  Result := cpcParams.fCalculaPrecoCusto();

  FreeAndNil(cpcParams);
End;

procedure pIniVariaveis(Var varRecVar: TRecVariaveis);
Begin
  varRecVar.VS_Date                   := untFuncoesSimples.VS_Date;
  varRecVar.utcRegistros              := untFuncoesSimples.utcRegistros;
  varRecVar.strLoginUsuarioLogado     := untFuncoesSimples.strLoginUsuarioLogado;
  varRecVar.strDescriUsuarioLogado    := untFuncoesSimples.strDescriUsuarioLogado;
  varRecVar.strEmpAcessoUsuarioLogado := untFuncoesSimples.strEmpAcessoUsuarioLogado;
  varRecVar.VS_strCodEmp              := untFuncoesSimples.VS_strCodEmp;
  varRecVar.VS_strUsaTmq              := untFuncoesSimples.VS_strUsaTmq;
  varRecVar.VS_strTitLot              := untFuncoesSimples.VS_strTitLot;
  varRecVar.VS_strTitLts              := untFuncoesSimples.VS_strTitLts;
  varRecVar.strPortadoresOperador     := untFuncoesSimples.strPortadoresOperador;
  varRecVar.arrProCod                 := untFuncoesSimples.arrProCod;
  varRecVar.funcPrecoCusto            := fCalculaPrecoCusto;
  varRecVar.objTraceViewer            := untFuncoesSimples.VS_objTraceViewer;
  varRecVar.blnUsuarioLogadoUtilizaModoClassico := untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico;

  if (not Assigned(untFuncoesSimples.VS_Trace)) then
    untFuncoesSimples.VS_Trace := TSQLTrace.Create();

  varRecVar.objTrace   := untFuncoesSimples.VS_Trace;
  varRecVar.objFuncoes := TFuncoesRelatorio.Create;
End;

procedure pIniModulos(Var modRecMod: TRecModulos);
Begin
  With modRecMod Do
  Begin
    Banco := frmModulo.GetCurrentConnection;
    ModuloSpr := @frmModuloSPR;
  End;
End;

Procedure pRelatorioFaturamento(relRelPed: TTipoRelFaturamento);
  Var
    varRegistro: TRegistroVarFaturamento;
Begin
  pRelatorioFaturamentoPar(relRelPed,varRegistro,FALSE);
End;

Procedure pRelatorioFaturamentoDir(relRelPed: TTipoRelFaturamento);
  Var
    varRegistro: TRegistroVarFaturamento;
Begin
  pRelatorioFaturamentoPar(relRelPed,varRegistro,FALSE,TRUE);
End;

Procedure pRelatorioFaturamentoPar(relRelPed: TTipoRelFaturamento; varRegistro: TRegistroVarFaturamento; blnTemParametro: Boolean = TRUE; blnAbreDireto: Boolean = False);
Var
  prmDllRel: TParamDllRelFaturamento;
Begin
  Try
    prmDllRel := TParamDllRelFaturamento.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
      varRecEst := varRegistro;
      varRecEst.blnTemParametros := blnTemParametro;
      varRecEst.blnAbreDireto    := blnAbreDireto;
    End;

    if relRelPed in CONJ_FATGERAL then
      prelfatgeral(prmDllRel)
    else if relRelPed in CONJ_FATEVOLUCAOVENDAS then
      prelfatevolucaovendas(prmDllRel)
    else if relRelPed in CONJ_FATMETAS then
      prelfatmetas(prmDllRel)
    else if relRelPed in CONJ_FATCOMISSAO then
      prelfatcomissao(prmDllRel)
    else if relRelPed in CONJ_FATVENDAS then
      prelfatvendas(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelFatGeral '+ #13 + E.Message,'[pRelatorioFaturamento]');
    End;
  End;
end;

Procedure pRelatorioPedidosDeVenda(relRelPed: TTipoRelPedidosDeVenda);
  Var
    prmDllRel: TParamDllRelPedidosDeVenda;
Begin
  Try
    prmDllRel := TParamDllRelPedidosDeVenda.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    prelpedidosdevenda(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelPedidosDeVenda '+ #13 + E.Message,'[pRelatorioPedidosDeVenda]');
    End;
  End;
end;

Procedure pRelatorioPedidosDeVendaPar(relRelPed: TTipoRelPedidosDeVenda; varRegistro: TRegistroVarVenda; blnTemParametro: Boolean = TRUE);
  Var
    prmDllRel: TParamDllRelPedidosDeVenda;
Begin
  Try
    prmDllRel := TParamDllRelPedidosDeVenda.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
      varRecEst := varRegistro;
      varRecEst.blnTemParametros := blnTemParametro;
    End;

    prelpedidosdevenda(prmDllRel);

    FreeAndNil(prmDllRel);

  Except
    On E: Exception Do
      pMensagensErro('Erro ao carregar dll: libRelPedidosDeVenda '+ #13 + E.Message,'[pRelatorioPedidosDeVenda]');
  End;
End;

Procedure pRelatorioBancariosContabeis(relRelPed: TTipoRelBancariosContabeis);
  Var
    prmDllRel: TParamDllRelBancariosContabeis;
Begin
  Try
    prmDllRel := TParamDllRelBancariosContabeis.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    prelbancarioscontabeis(prmDllRel);

    FreeAndNil(prmDllRel);

  Except
    On E: Exception Do
      pMensagensErro('Erro ao carregar dll: libRelBancariosContabeis '+ #13 + E.Message,'[pRelatorioBancariosContabeis]');
  End;
end;

Procedure pRelatorioChequesPre(relRelPed: TTipoRelChequesPre);
  Var
    varRegistro : TRegistroVarChequesPre;
Begin
  FillChar(varRegistro, SizeOf(varRegistro), #0);
  pRelatorioChequesPrePar(relRelPed, varRegistro);
end;

procedure pRelatorioChequesPrePar(relRelPed: TTipoRelChequesPre;
  varRegistro: TRegistroVarChequesPre);
  Var
    prmDllRel : TParamDllRelChequesPre;
begin
  Try
    prmDllRel := TParamDllRelChequesPre.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
      varRecEst := varRegistro;
    End;

    prelchequespre(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
      pMensagensErro('Erro ao carregar dll: libRelChequesPre '+ #13 + E.Message,'[pRelatorioChequesPre]');
  End;
end;

Procedure pRelatorioEstatisticas(relRelPed: TTipoRelEstatisticas);
  Var
    prmDllRel: TParamDllRelEstatisticas;
Begin
  Try
    prmDllRel := TParamDllRelEstatisticas.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    prelestatistica(prmDllRel);

    FreeAndNil(prmDllRel);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelEstatistica '+ #13 + E.Message,'[pRelatorioEstatistica]');
    End;
  End;
end;


//Procedure pRelatorioCadastro(relRelCad: TTipoRelCadastro);
//Var
//  varRegistro: TRegistroVarCadastro;
//Begin
//  pRelatorioCadastroPar(relRelCad, varRegistro, False);
//End;
//
//Procedure pRelatorioCadastroPar(relRelCad: TTipoRelCadastro; varRegistro: TRegistroVarCadastro; blnTemParametro: Boolean = TRUE);
//Var
//   prmDllRel: TParamDllRelCadastros;
//Begin
//  try
//    prmDllRel := TParamDllRelCadastros.Create;
//    With prmDllRel Do
//    Begin
//      {$WARN SYMBOL_PLATFORM OFF}
//      intDebugH := DebugHook;
//      {$WARN SYMBOL_PLATFORM ON}
//     relTipRel := relRelCad;
//      pIniVariaveis(varRecVar);
//      pIniModulos(modRecMod);
//      varRecCad := varRegistro;
//      varRecCad.blnTemParametros := blnTemParametro;
//    End;
//
//    prelcadastro(prmDllRel);
//
//    FreeAndNil(prmDllRel);
//  Except
//    On E: Exception Do
//    Begin
//      pMensagensErro('Erro ao carregar dll: libRelCadastros '+ #13 + E.Message,'[pRelatorioCadastro]');
//    End;
//  End;
//end;

Procedure pRelatorioContasAPagar(relRelPed: TTipoRelContasAPagar);
  Var
    prmDllRel: TParamDllRelContasAPagar;
Begin
  Try
    prmDllRel := TParamDllRelContasAPagar.Create;

    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    prelcontasapagar(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelContasAPagar '+ #13 + E.Message,'[pRelatorioContasAPagar]');
    End;
  End;
end;

Procedure pRelatorioContasAReceber(relRelPed: TTipoRelContasAReceber);
var
  prmDllRel: TParamDllRelContasAReceber;
Begin
  Try
    prmDllRel := TParamDllRelContasAReceber.Create;

    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    pSetLiberacaoRelContasAReceber(TLiberacaoFactory.fGetLiberacao);

    prelcontasareceber(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelContasAReceber '+ #13 + E.Message,'[pRelatorioContasAReceber]');
    End;
  End;
end;

Procedure pRelatorioLivrosFiscais(relRelPed: TTipoRelLivrosFiscais);
  Var
    prmDllRel: TParamDllRelLivrosFiscais;
Begin
  Try
    prmDllRel := TParamDllRelLivrosFiscais.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;

    prellivrosfiscais(prmDllRel);

    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelLivrosFiscais '+ #13 + E.Message,'[pRelatorioLivrosFiscais]');
    End;
  End;
end;

Procedure pRelatorioEstoquePar(relRelPed: TTipoRelEstoque; varRegistro: TRegistroVarEstoque; blnTemParametro: Boolean = TRUE);
  Var
    prmDllRel: TParamDllRelEstoque;
Begin
  Try
    prmDllRel := TParamDllRelEstoque.Create;
    With prmDllRel Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      relTipRel := relRelPed;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
      varRecEst := varRegistro;
      varRecEst.blnTemParametros := blnTemParametro;
    End;

    prelestoque(prmDllRel);

    FreeAndNil(prmDllRel);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar dll: libRelEstoque '+ #13 + E.Message,'[pRelatorioEstoque]');
    End;
  End;
end;

Procedure pRelatorioEstoque(relRelPed: TTipoRelEstoque);
  Var
    varRegistro: TRegistroVarEstoque;
Begin
  FillChar(varRegistro, SizeOf(varRegistro), #0);
  pRelatorioEstoquePar(relRelPed,varRegistro,False);
End;

end.
