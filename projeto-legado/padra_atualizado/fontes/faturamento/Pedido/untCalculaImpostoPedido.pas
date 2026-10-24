unit untCalculaImpostoPedido;

interface

uses untCalculoImpostoIPI, Shared.Functions.Types, Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Interfaces.IcmsSt, untTypesIPI, untFactoryImpostos,
  untFatCalcularImpostosService, Data.DB, Faturamento.Impostos.Interfaces.FcpDifal;

type
  TfGetTipAbf = function (strEmpIte: string): string of Object;

  TInputCalculaImpostoPedido = record
    strCliCon: String;
    strOpcDoc : String;
    strCodFor : String;
    strEspDoc : String;
    strTipPed : String;
    strOriF11 : String;
    strTipOpe : String;
    strEmpOri : String;
    strNumOrc : String;
    strTipoDeBaixaEntregaFutura : String;
    strCodigoDaEmpresaAbf: String;
    strCodigoDaEmpresaTE: String;
    blnBaiEntFut: Boolean;
    blnTaxaBombeamentoPedOrc: Boolean;
    blnNCFornecedor : Boolean;
    blnNEFornecedor : Boolean;
    blnVendaPresencial: Boolean;
    blnClienteIndustria : Boolean;
    blnClienteComercializacao : Boolean;
    blnUtilizaSat : Boolean;
    blnDesmembrarMeiaNotaComNotaNormal : Boolean;
    blnRegimeEspecialPorEmpresa : Boolean;
    blnDesmembrarNotaProdutosServicos : Boolean;
    blnEhDevolucaoEspelho : Boolean;
    MetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;
    ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
    strAutoincremEnderecoEntrega : String;
    blnCliFil : Boolean;
    blnDifFCPST : Boolean;
    blnDocumentoParaFornecedor : Boolean;
    strOpcDocTrue : String;
    strIndCom : String;
  End;

  TCalculaImpostoPedido = class
  private
    FInput : TInputCalculaImpostoPedido;
    FDadosPedido : TDataSet;
    FParametrosIcmsSt: IParametrosServicoIcmsSt;
    FParametrosFcpDifal: IParametrosServicoFcpDifal;
    FCalculoImpostosIPI: TCalculoImpostoIPI;
    FGetTipAbf: TfGetTipAbf;
    function fGetBaseSTParaCalculoDeFcpST(const fltBasRet: Double; const strCodAbf, strTipoAbreviacaoFiscal: String): Double;
    function fAtualizaBaseIcms(const fltBasIcm: Double): Double;
    function fExisteNaTabelaCedem(const strClaIpi: String): Boolean;
    function fTotalItem: Double;
    procedure pSetaParametrosST;
    procedure pSetarParametrosFcpDifal(const strCodAbf, strEmpIte: String; const fltValIpi, fltValRet, fltBaseST: Double);
    function fCalculaIpi(const strIncDor: String): Double;
    function fCalculaST(const strIncDor: String; var fltBaseST: Double): Double;
    function fCalculaFCPST(const strIncDor: String; const strCodAbf, strEmpIte: String; const fltValIpi, fltValRet, fltBaseST: Double): Double;
    function fValorReformaProporcional(const strIncDor, strCampo: String; const fltQtdIteCds: Double): Double;
    function fDeveRecalcularTotGerItem(const fltQtdIteCds, fltUnitarCds: Double): Boolean;
    function fBaseDeCalculoDoImposto(const fltTotIte: Double; fltPerBas: Double): Double;
    function fAliquotaDeFcpParaMargem(const fltMargemOriginal, fltBasIcm: Double): Double;
  public
    procedure pAtualizarImpostosCdsVendas(const cdsVenda: TDataSet; const strIncDor, strCodAbf: String; const fltQtdIteCds, fltUnitarCds, fltTotIteCds: Double; var blnDeveRecalcularTotGerItem: Boolean);
    constructor Create(const ADadosPedido: TDataSet; AInput: TInputCalculaImpostoPedido; AGetTipAbf: TfGetTipAbf);
    destructor Destroy; override;
  End;

implementation

uses untFuncoesSimples, SysUtils, Faturamento.Impostos.Tipos.IcmsSt,
  Controller.Faturamento.Interfaces.Cache, Controller.Faturamento.Impostos.Generic,
  Shared.Functions.Funcoes.Faturamento, Faturamento.Impostos.Tipos.FcpDifal,
  untFuncFatTypes;

{ TCalculaImpostoPedido }

function TCalculaImpostoPedido.fAliquotaDeFcpParaMargem(
  const fltMargemOriginal, fltBasIcm: Double): Double;
begin
  Result := fltMargemOriginal;

  If (fltBasIcm = 0) Then
    Exit;

  If (fltMargemOriginal <> 0) Then
    Exit;

  Result := FDadosPedido.FieldByName('ICD_PERFCP').AsFloat;
end;

function TCalculaImpostoPedido.fAtualizaBaseIcms(
  const fltBasIcm: Double): Double;
begin
  Result := fltBasIcm;

  If (fltBasIcm = 0) Then
    Exit;

  Result := fBaseDeCalculoDoImposto(fTotalItem, FDadosPedido.FieldByName('FDO_PERBAS').AsFloat);
end;

function TCalculaImpostoPedido.fBaseDeCalculoDoImposto(const fltTotIte: Double; fltPerBas: Double): Double;
begin
  Result := fltTotIte;

  If (fltPerBas = 100) Then
    Exit;

  If (fltPerBas = 0) Then
    Exit;

  Result := fFormataFloat(((fltTotIte * 100) / 100) * (fltPerBas/100), 2);
end;

constructor TCalculaImpostoPedido.Create(const ADadosPedido: TDataSet; AInput: TInputCalculaImpostoPedido; AGetTipAbf: TfGetTipAbf);
begin
  FInput := AInput;
  FDadosPedido := ADadosPedido;
  FCalculoImpostosIPI := TFactoryImpostos.Ipi;
  FGetTipAbf := AGetTipAbf;
end;

destructor TCalculaImpostoPedido.Destroy;
begin
  FreeAndNil(FCalculoImpostosIPI);
  inherited;
end;

function TCalculaImpostoPedido.fTotalItem: Double;
begin
  Result := fFormataFloat(FDadosPedido.FieldByName('FDO_UNDIDE').AsFloat * FDadosPedido.FieldByName('FDO_QTDITE').AsFloat, 2);
end;

function TCalculaImpostoPedido.fCalculaFCPST(const strIncDor: String; const strCodAbf, strEmpIte: String; const fltValIpi, fltValRet, fltBaseST: Double): Double;
  Var
    LResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
begin
  Result := 0;

  If (Not FDadosPedido.Locate('ITE_CHVUNI', strIncDor, [])) Then
    Exit;

  If (FDadosPedido.FieldByName('FDO_VALRET').AsFloat = 0) Then
    Exit;

  If (FDadosPedido.FieldByName('FDO_VALFCP').AsFloat = 0) Then
    Exit;

  pSetarParametrosFcpDifal(strCodAbf, strEmpIte, fltValIpi, fltValRet, fltBaseST);

  if not TControllerFaturamentoInterfacesCache.TryGetCache(FParametrosFcpDifal, LResultadoServicosClasseFcpDifal) then
  begin
    LResultadoServicosClasseFcpDifal := GetFaturamentoImpostosService.FcpDifal.CalcularValorFcpDifalFinal(FParametrosFcpDifal);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(FParametrosFcpDifal, LResultadoServicosClasseFcpDifal);
  end;
  Result := LResultadoServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal.RecordDifalFCP.fltValFcp;
end;

function TCalculaImpostoPedido.fValorReformaProporcional(const strIncDor, strCampo: String; const fltQtdIteCds: Double): Double;
begin
  Result := 0;

  If (Not fSomarNovosImpostosDaReformaAoValorContabil) Then
    Exit;

  If (Not FDadosPedido.Locate('ITE_CHVUNI', strIncDor, [])) Then
    Exit;

  If (FDadosPedido.FindField(strCampo) = Nil) Then
    Exit;

  If (FDadosPedido.FieldByName('FDO_QTDITE').AsFloat <= 0) Then
    Exit;

  // FDOREF guarda o valor da quantidade cheia do item do pedido
  Result := fFormataFloat(FDadosPedido.FieldByName(strCampo).AsFloat * fltQtdIteCds / FDadosPedido.FieldByName('FDO_QTDITE').AsFloat, 2);
end;

function TCalculaImpostoPedido.fCalculaIpi(const strIncDor: String): Double;
  Var
    arrMatItens : TMatrizFechamento;
begin
  Result := 0;

  If (Not FDadosPedido.Locate('ITE_CHVUNI', strIncDor, [])) Then
    Exit;

  If (FDadosPedido.FieldByName('FDO_VALIPI').AsFloat = 0) Then
    Exit;

  SetLength(arrMatItens, 1);
  FillChar(arrMatItens[0], SizeOf(arrMatItens[0]), #0);
  arrMatItens[0].strCodIte := FDadosPedido.FieldByName('FDO_CODITE').AsString;
  arrMatItens[0].strClaFis := FDadosPedido.FieldByName('FDO_CLAFIS').AsString;
  arrMatItens[0].opcINFesp := opcVazio;
  arrMatItens[0].blnMeiaNotaFatorExpedicao := False;
  arrMatItens[0].fltTotIte := fTotalItem;
  arrMatItens[0].fltValFre := 0;
  arrMatItens[0].fltDesAce := 0;
  arrMatItens[0].fltDesEsp := 0;
  arrMatItens[0].strEspDev := EmptyStr;
  FCalculoImpostosIPI.CalcularValorIpiFinal(arrMatItens, 0);
  Result := arrMatItens[0].fltValIpi;
end;

function TCalculaImpostoPedido.fDeveRecalcularTotGerItem(const fltQtdIteCds, fltUnitarCds: Double): Boolean;
  Const
    DIFERENCA : Double = 0.05;
  Var
    intDecQtd : Integer;
begin
  Result := True;

  intDecQtd := fCfgSis('DECQTD', varInteger);

  If (Not fMesmoValor(fFormataFloat(FDadosPedido.FieldByName('FDO_QTDITE').AsFloat, intDecQtd), fltQtdIteCds, DIFERENCA)) Then
    Exit;

  If (Not fMesmoValor(fFormataFloat(FDadosPedido.FieldByName('FDO_UNDIDE').AsFloat, intDecQtd), fltUnitarCds, DIFERENCA)) Then
    Exit;

  Result := False;
end;

function TCalculaImpostoPedido.fCalculaST(const strIncDor: String; var fltBaseST: Double): Double;
  Var
    LResultadoServicosClasseIcmsSt: IResultadoServicosClasseIcmsSt;
begin
  Result := 0;
  fltBaseST := 0;

  If (Not FDadosPedido.Locate('ITE_CHVUNI', strIncDor, [])) Then
    Exit;

  If (FDadosPedido.FieldByName('FDO_VALRET').AsFloat = 0) Then
    Exit;

  pSetaParametrosST;
  if not TControllerFaturamentoInterfacesCache.TryGetCache(FParametrosIcmsSt, LResultadoServicosClasseIcmsSt) then
  begin
    LResultadoServicosClasseIcmsSt := GetFaturamentoImpostosService.IcmsSt.CalcularValorIcmsSt(FParametrosIcmsSt);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(FParametrosIcmsSt, LResultadoServicosClasseIcmsSt);
  end;
  fltBaseST := LResultadoServicosClasseIcmsSt.ResultadoCalculoSt.BaseDeCalculoDaSubstituicaoTributariaDoItem;
  Result := LResultadoServicosClasseIcmsSt.ResultadoCalculoSt.ValorDaSubstituicaoTributariaDoItem;
end;

procedure TCalculaImpostoPedido.pAtualizarImpostosCdsVendas(const cdsVenda: TDataSet; const strIncDor, strCodAbf: String; const fltQtdIteCds, fltUnitarCds, fltTotIteCds: Double; var blnDeveRecalcularTotGerItem: Boolean);
  Var
    fltValST: Double;
    fltValFCPST: Double;
    fltValIpi: Double;
    fltUnitarioContabil : Double;
    fltBaseST : Double;
    fltValCBS : Double;
    fltValIBS : Double;
    fltValIS : Double;
begin
  fltBaseST := 0;
  blnDeveRecalcularTotGerItem := fDeveRecalcularTotGerItem(fltQtdIteCds, fltUnitarCds);

  If (blnDeveRecalcularTotGerItem) Then
    Exit;

  fltValIpi := fCalculaIpi(strIncDor);
  fltValST := fCalculaST(strIncDor, fltBaseST);
  fltValFCPST := fCalculaFCPST(strIncDor, strCodAbf, FDadosPedido.FieldByName('FDO_EMPITE').AsString, fltValIpi, fltValST, fltBaseST);

  fltValCBS := fValorReformaProporcional(strIncDor, 'REF_CBSVAL', fltQtdIteCds);
  fltValIBS := fValorReformaProporcional(strIncDor, 'REF_VALIBS', fltQtdIteCds);
  fltValIS  := fValorReformaProporcional(strIncDor, 'REF_SELVAL', fltQtdIteCds);

  cdsVenda.FieldByName('ITE_VALIPI').AsFloat := fltValIpi;
  cdsVenda.FieldByName('ITE_VALRET').AsFloat := fltValST;
  cdsVenda.FieldByName('ITE_VAL_ST').AsFloat := fltValST;
  cdsVenda.FieldByName('ITE_VALFCP').AsFloat := fltValFCPST;
  cdsVenda.FieldByName('ITE_VALCBS').AsFloat := fltValCBS;
  cdsVenda.FieldByName('ITE_VALIBS').AsFloat := fltValIBS;
  cdsVenda.FieldByName('ITE_VAL_IS').AsFloat := fltValIS;

  cdsVenda.FieldByName('ITE_VLRCON').AsFloat := fltTotIteCds + fltValST + fltValIpi + fltValFCPST + fltValCBS + fltValIBS + fltValIS;

  fltUnitarioContabil := (fltUnitarCds * fltQtdIteCds) + fltValST + fltValIpi + fltValFCPST + fltValCBS + fltValIBS + fltValIS;
  cdsVenda.FieldByName('ITE_UNICON').AsFloat := (fltUnitarioContabil / fltQtdIteCds);
  cdsVenda.FieldByName('ITE_BASICM').AsFloat := fAtualizaBaseIcms(cdsVenda.FieldByName('ITE_BASICM').AsFloat);
  cdsVenda.FieldByName('ITE_VALFCP_MARGEM').AsFloat := fAliquotaDeFcpParaMargem(cdsVenda.FieldByName('ITE_VALFCP_MARGEM').AsFloat, cdsVenda.FieldByName('ITE_BASICM').AsFloat);
end;

procedure TCalculaImpostoPedido.pSetaParametrosST;
begin
  FParametrosIcmsSt :=
    TParametrosServicoIcmsSt.New
      .CodigoDoCliente(FDadosPedido.FieldByName('FDO_CODCLI').AsString)
      .ClienteConsumidorFinal(FInput.strCliCon = 'S')
      .CodigoDoProduto(FDadosPedido.FieldByName('FDO_CODITE').AsString)
      .CodigoDaEmpresa(FDadosPedido.FieldByName('FDO_EMPITE').AsString)
      .TaxaBombeamentoPedidoOrcamento(FInput.blnTaxaBombeamentoPedOrc)
      .BaixaDeEntregaFutura(FInput.blnBaiEntFut)
      .EntregaFuturaDoItem(FDadosPedido.FieldByName('FDO_ENTFUT').AsString = 'S')
      .TotalGeralDoItem(fTotalItem)
      .MetodoArredondamentoICMSECF(FInput.MetodoArredondamentoICMSECF)
      .NotaComplementoFornecedor(FInput.blnNCFornecedor)
      .NotaEspecialFornecedor(FInput.blnNEFornecedor)
      .CodigoDoFornecedor(FInput.strCodFor)
      .CodigoDoFornecedorDoItem(FDadosPedido.FieldByName('FDO_FORITE').AsString)
      .OpcaoDoDocumento(FInput.strOpcDoc)
      .EspecieDocumento(FInput.strEspDoc)
      .ClassificacaoFiscalDoItem(FDadosPedido.FieldByName('FDO_CLAFIS').AsString)
      .VendaPresencial(FInput.blnVendaPresencial)
      .CodigoDaSituacaoTributaria(FDadosPedido.FieldByName('FDO_CODFIS').AsString)
      .CodigoDaEmpresaTE(FInput.strCodigoDaEmpresaTE)
      .AliquotaDeIcmsDoItem(FDadosPedido.FieldByName('FDO_ALQICM').AsFloat)
      .TipoOperacaoPedidoVenda(FInput.strTipOpe)
      .ClienteIndustria(FInput.blnClienteIndustria)
      .ClienteComercializacao(FInput.blnClienteComercializacao)
      .UtilizaSat(FInput.blnUtilizaSat)
      .ValorUnitarioDoItem(FDadosPedido.FieldByName('FDO_UNDIDE').AsFloat)
      .QuantidadeDoItem(FDadosPedido.FieldByName('FDO_QTDITE').AsFloat)
      .DesmembrarNotaProdutosServicos(FInput.blnDesmembrarNotaProdutosServicos)
      .DesmembrarMeiaNotaComNotaNormal(FInput.blnDesmembrarMeiaNotaComNotaNormal)
      .PrecoDeCustoDoItem(FDadosPedido.FieldByName('ITE_PRECUS').AsFloat)
      .PrecoDeUltimaCompraDoItem(FDadosPedido.FieldByName('ITE_PREULT').AsFloat)
      .PrecoEImpostosDeUltimaCompraDoItem(FDadosPedido.FieldByName('ITE_IMPULT').AsFloat)
      .TipoDePedidoFaturamento(FInput.strTipPed)
      .IdePro(FDadosPedido.FieldByName('FDO_IDEPRO').AsString)
      .PrecoDeCustoDoItemSemImpostos(FDadosPedido.FieldByName('ITE_PRECUS').AsFloat)
      .OrigemF11(FInput.strOriF11 = 'S')
      .CodigoDaEmpresaOriginal(FInput.strEmpOri)
      .NumeroDoOrcamento(FInput.strNumOrc)
      .ParametrosClienteConsumidor(FInput.ParametrosClienteConsumidor)
      .ClassificacaoDeIpi(FDadosPedido.FieldByName('PED_CLAIPI').AsString)
      .TipoDeBaixaEntregaFutura(FInput.strTipoDeBaixaEntregaFutura)
      .EhDevolucaoEspelho(FInput.blnEhDevolucaoEspelho)
      .RegimeEspecialPorEmpresa(FInput.blnRegimeEspecialPorEmpresa)
      .CodigoDaEmpresaAbf(FInput.strCodigoDaEmpresaAbf)
      .CalcularSatEcf(True)
      .MeiaNotaFatorExpedicao(False)
      .PrecoDeCompraDaTinta(0)
      .DescontoEspecialBaixaDeEntregaFutura(0)
      .ValorFreteDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .DescontoEspecial(0)
      .SequencialEnderecoEntrega(EmptyStr)
      .EspecieDeDevolucao(EmptyStr)
      .OpcaoDeItemNfEspiritoSanto(opcVazio)
end;

function TCalculaImpostoPedido.fExisteNaTabelaCedem(const strClaIpi: String): Boolean;
  Var
    strNcmIte : String;
begin
  Result := False;

  If fEmptyStr(strClaIpi) Then
    Exit;

  strNcmIte := fCampoTabela('CED_NCMITE', 'CEDEM_', ['CED_NCMITE'], [strClaIpi], False);
  Result := (Not fEmptyStr(strNcmIte));
end;

function TCalculaImpostoPedido.fGetBaseSTParaCalculoDeFcpST(const fltBasRet: Double; const strCodAbf, strTipoAbreviacaoFiscal: String): Double;
  Var
    fltBasRetAbrev : Double;
begin
  If (fltBasRet = 0) Then
  Begin
    fltBasRetAbrev := fCampoTabela('ABF_BASRET' + strTipoAbreviacaoFiscal, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [strCodAbf, FDadosPedido.FieldByName('CLI_ESTADO').AsString], False);
    Result := fBaseDeCalculoDoImposto(fTotalItem, fltBasRetAbrev);
  End
  Else
    Result := fltBasRet;
end;

procedure TCalculaImpostoPedido.pSetarParametrosFcpDifal(const strCodAbf, strEmpIte: String; const fltValIpi, fltValRet, fltBaseST: Double);
  Var
    RecordDifalFCP: TRecDifalFCP;
    blnEntraIPInaBaseIcms : Boolean;
    fltValorIVAEspecialClienteMT : Double;
    blnExisteNaTabelaCEDEM : Boolean;
    blnClienteIvaEspecialMT : Boolean;
    strTipoAbreviacaoFiscal : String;
    fltBasRet : Double;
begin
  blnExisteNaTabelaCEDEM := fExisteNaTabelaCEDEM(FDadosPedido.FieldByName('PED_CLAIPI').AsString);

  fltValorIVAEspecialClienteMT := TFunctionFuncoesFaturamento.
    GetCliIVAEspMT(FInput.blnDocumentoParaFornecedor,
                   FDadosPedido.FieldByName('CLI_I_E_S_').AsString,
                   FDadosPedido.FieldByName('CLI_ESTADO').AsString,
                   FDadosPedido.FieldByName('CLI_IVAESP').AsFloat,
                   blnExisteNaTabelaCEDEM,
                   FDadosPedido.FieldByName('CLI_CEDESP').AsFloat);

  blnClienteIvaEspecialMT := TFunctionFuncoesFaturamento.
      ClienteIVAEspecialMT( FDadosPedido.FieldByName('CLI_ESTADO').AsString,
                            fRetUFEmpresa(FDadosPedido.FieldByName('FDO_EMPITE').AsString),
                            fltValorIVAEspecialClienteMT);

  blnEntraIPInaBaseIcms := TFunctionFuncoesFaturamento.
    EntraIPInaBaseIcms(FInput.strCliCon = 'S',
                       blnClienteIvaEspecialMT,
                       (FInput.strIndCom = 'C'),
                       FDadosPedido.FieldByName('CLI_SIBICM').AsString = 'S',
                       FInput.blnBaiEntFut);

  strTipoAbreviacaoFiscal := FGetTipAbf(strEmpIte);
  fltBasRet := fGetBaseSTParaCalculoDeFcpST(fltBaseST, strCodAbf, strTipoAbreviacaoFiscal);

  FillChar(RecordDifalFCP, SizeOf(RecordDifalFCP), #0);
  FParametrosFcpDifal :=
    TParametrosServicoFcpDifal.New
      .CodigoDoItemDaAbreviacaoFiscal(FDadosPedido.FieldByName('PED_ITEABF').AsString)
      .CodigoDaAbreviacaoFiscal(strCodAbf)
      .SequencialEnderecoEntrega(FInput.strAutoincremEnderecoEntrega)
      .TipoDaAbreviacaoFiscal(strTipoAbreviacaoFiscal)
      .VendaPresencial(FInput.blnVendaPresencial)
      .ClienteConsumidorFinal(FInput.strCliCon = 'S')
      .NotaComplementoFornecedor(FInput.blnNCFornecedor)
      .NotaEspecialFornecedor(FInput.blnNEFornecedor)
      .CodigoDoCliente(FDadosPedido.FieldByName('FDO_CODCLI').AsString)
      .CodigoDoFornecedor(FInput.strCodFor)
      .ClienteFilial(FInput.blnCliFil)
      .OpcaoDeDocumento(FInput.strOpcDoc)
      .CodigoDaSituacaoTributaria(FDadosPedido.FieldByName('FDO_CODFIS').AsString)
      .BaseDeCalculoDoIcmsDoItem(fBaseDeCalculoDoImposto(fTotalItem, FDadosPedido.FieldByName('FDO_PERBAS').AsFloat))
      .DiferencaFCPST(FInput.blnDifFCPST)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(fltBasRet)
      .CodigoDaSubstituicaoTributariaDoItem(FDadosPedido.FieldByName('FDO_CODFIS').AsString)
      .RecordDifalFCP(RecordDifalFCP)
      .ProdutoIndustrializado(FDadosPedido.FieldByName('ITE_INDREV').AsString = 'I')
      .ParametrosClienteConsumidor(FInput.ParametrosClienteConsumidor)
      .CodigoDaEmpresa(FDadosPedido.FieldByName('FDO_EMPITE').AsString)
      .ClassificacaoFiscalDoItem(FDadosPedido.FieldByName('FDO_CLAFIS').AsString)
      .CodigoDaEmpresaTE(FInput.strCodigoDaEmpresaTE)
      .AliquotaDeIcmsDoItem(FDadosPedido.FieldByName('FDO_ALQICM').AsFloat)
      .DataDoSistema(VS_Date)
      .ClienteIndustria(FInput.blnClienteIndustria)
      .BaixaDeEntregaFutura(FInput.blnBaiEntFut)
      .EspecieDoDocumento(FInput.strEspDoc)
      .ValorDaSubstituicaoTributariaDoItem(fltValret)
      .EntregaFuturaDoItem(FDadosPedido.FieldByName('FDO_ENTFUT').AsString = 'S')
      .CodigoDoItem(FDadosPedido.FieldByName('FDO_CODITE').AsString)
      .QuantidadeDoItem(FDadosPedido.FieldByName('FDO_QTDITE').AsFloat)
      .ValorDoIpi(fltValIpi)
      .ValorTotalDoItem(fTotalItem)
      .PercentualBaseDoIcmsDoItem(FDadosPedido.FieldByName('FDO_PERBAS').AsFloat)
      .OpcaoDeDocumentoVerdadeira(FInput.strOpcDocTrue)
      .EntraIPInaBaseIcms(blnEntraIPInaBaseIcms)
      .ClassificacaoFiscal(FDadosPedido.FieldByName('FDO_CLAFIS').AsString)
      .ProdutoEmbalagem(FDadosPedido.FieldByName('ITE_PROEMB').AsString)
      .ProdutoRevenda(FDadosPedido.FieldByName('ITE_INDREV').AsString = 'R')
      .ProdutoImportacaoDireta(FDadosPedido.FieldByName('ITE_IMPDIR').AsString = 'S')
      .STAtribuidaPorRegimeEspecial(False)
      .ClassificacaoFiscalRecebimentoGarantia(EmptyStr)
      .CodigoDaEmpresaAbf(FInput.strCodigoDaEmpresaAbf)
      .HabilitarNovoCalculoDifalComPercentualBase(True)
      .ValorDaSTDoItemNoFatuamentoConsignacao(0)
      .OpcaoDeItemNfEspiritoSanto(opcVazio)
      .AliquotaFCPST(0)
      .BaseDeCalculoDoIcmsDoItemBenST(0)
      .NumeroDoDocumentoDeDevolucao(EmptyStr)
      .EspecieDoDocumentoDeDevolucao(EmptyStr)
      .EmpresaDoDocumentoDeDevolucao(EmptyStr)
      .DocumentoDeDevolucao(False)
      .ValorDoFrete(0)
      .DescontoEspecial(0)
      .DespesasAcessorias(0)
end;

end.
