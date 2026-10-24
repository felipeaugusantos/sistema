unit Faturamento.Impostos.Servicos.Funcoes;

interface

uses System.SysUtils, Shared.Functions.Core,
  Shared.Functions.Funcoes.Faturamento,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Shared.Functions.DataSet,
  Faturamento.Impostos.Interfaces.Ipi, Faturamento.Impostos.Tipos.Ipi,
  Shared.Functions.Configuracoes,
  Shared.Functions.Types, Shared.Functions.Constantes, Shared.Functions.Utils,
  Shared.Functions.Interfaces, Shared.Functions.Tipos;

type
  TFaturamentoImpostosServicosFuncoes = class
  private
    class function TipoDeOperacaoDeTransferencia(ATipoDeAbreviacaoDoCliente, ACodigoDoCliente, ACodigoDaEmpresa, ACodigoDaEmpresaTransferencia, AClienteIndustrial: String): String; static;
  public
    class function RetornarNotaDeImportacao(AClassificacaoFiscalDoItem: String): String;
    class function VendaDentroDoEstado(AEstadoEntrega, AEmpresaEstado: String; AVendaPresencial: Boolean): Boolean;
    class function RetornarTrocaUFEndEntrega(const AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      const ACodigoDaEmpresa, AOpcaoDoDocumento: String; const ADocumentoParaFornecedor: Boolean): String;

    class function TipoDeAbreviacaoDoFornecedor(ACodigoDoFornecedor: String): String;

    class function TipoDeAbreviacaoDoCliente( AParametros : IParametrosTipoDeAbreviacaoDoCliente): String;

    Class function RetornarTipoDeAbreviacaoClienteFornecedor( AParametros : IParametrosTipoDeAbreviacaoDoCliente): String;

    class function RetornarListaDeClienteFilial: String;

    class function AtividadeConstrutora(const ACodigoAtividade, ACodigoDaEmpresa: String): Boolean;

    class function RetornarClienteAtividade(const AClienteAtividade, ACodigoDaEmpresa: String) : IMyCampoTabela;

    class function CarregarDadosIpi(const  AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto,
      ACodigoDaEmpresa : String; const AIpiSaidaProduto : Double; const ASituacaoDoIpi : String) : IResultadoAbreviacaoIpi;

    class Function RetornarDadosAbreviacaoIpi(const  AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String ): IResultadoAbreviacaoIpi;

    class function RetornarResultadoAbreviacaoIpi(const ABaseDeCalculoIPI, AAliquotaDeCalculoIPI: Double): IResultadoAbreviacaoIpi;

    Class procedure AdicionarValorChave(const AValor: Variant; var AValorChave: ArrOfVariant);

    class function EhItemConcreto(const ACodigoDoProduto, AItemConcreto: String): Boolean;

    class function RetornarPrecoCompraMenosDescontoFornecedor(const ACodigoDoProduto, ACodigoDaEmpresa: String): Double;

    class function RetornarTipoDeAbreviacaoNotaEspiritoSanto(Const AOpcaoDeItemNfEspiritoSanto : TOpcItensNFespTinta; Const ATipoDeAbreviacaoFiscal : String ) : String;

    class function RetornaEstadoParaAbreviacao(Const ADentroDoEstado : Boolean; Const AEmpresaEstado, AUFEndEntrega : String ): String;

    class function ExisteNaTabelaCEDEM(const ANCM: string; AGerandoCasosTestes : Boolean = false): Boolean;
  end;

implementation

{ TFaturamentoImpostosServicosFuncoes }

Class procedure TFaturamentoImpostosServicosFuncoes.AdicionarValorChave
(const AValor: Variant; var AValorChave: ArrOfVariant);
begin
  SetLength(AValorChave, Length(AValorChave) + 1);
  AValorChave[Length(AValorChave) - 1] := AValor;
end;


Class function TFaturamentoImpostosServicosFuncoes.RetornarDadosAbreviacaoIpi
(const  AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String ): IResultadoAbreviacaoIpi;
  Var
    strSQL : String;
    LAbrevicaoIpi : IMyCampoTabela;

    LValorChave: ArrOfVariant;

    LBaseDeCalculoIPI: String;
    LAliquotaDeCalculoIPI: String;

    LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  strSQL :=
    TFunctionFuncoesFaturamento.
      GetSelectAbreviacaoIpi(AClassificacaoFiscalDoItem);

  SetLength(LValorChave, 0);
  AdicionarValorChave(ACodigoDoProduto, LValorChave);

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI) = UMA_PARA_CADA_EMPRESA Then
    AdicionarValorChave(ACodigoDaEmpresa, LValorChave);

  AdicionarValorChave(AClassificacaoFiscalDoItem, LValorChave);

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(strSQL);

  LAbrevicaoIpi :=
    objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, LDesmembrarSelectParaCampoTabela.CampoChave, LValorChave, False);

  LBaseDeCalculoIPI := 'BASE';
  LAliquotaDeCalculoIPI := 'ALQ';

  Result :=
    TResultadoAbreviacaoIpi.New
      .BaseDeCalculoIPI(LAbrevicaoIpi.FieldByName(LBaseDeCalculoIPI))
      .AliquotaDeCalculoIPI(LAbrevicaoIpi.FieldByName(LAliquotaDeCalculoIPI));
end;


Class function TFaturamentoImpostosServicosFuncoes.RetornarResultadoAbreviacaoIpi
(const ABaseDeCalculoIPI, AAliquotaDeCalculoIPI: Double): IResultadoAbreviacaoIpi;
begin
  Result :=
    TResultadoAbreviacaoIpi.New
      .BaseDeCalculoIPI(ABaseDeCalculoIpi)
      .AliquotaDeCalculoIPI(AAliquotaDeCalculoIPI);
end;



Class function TFaturamentoImpostosServicosFuncoes.CarregarDadosIpi(
  const AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa : String;
  const AIpiSaidaProduto : Double; const ASituacaoDoIpi : String): IResultadoAbreviacaoIpi;
Var
  LAliquotaDeCalculoIPI : Double;
  LBaseDeCalculoIpi     : Double;
begin
  LAliquotaDeCalculoIPI := 0;
  LBaseDeCalculoIpi     := 0;

  If TFunctionFuncoesFaturamento.ValidarIpiSaida(AEspecieDoDocumento) Then
  Begin
    LAliquotaDeCalculoIPI := AIpiSaidaProduto;
    Result := RetornarResultadoAbreviacaoIpi(LBaseDeCalculoIpi, LAliquotaDeCalculoIPI);
    Exit;
  End;

  If TFunctionFuncoesFaturamento.ValidarSituacaoDoIpi(ASituacaoDoIpi) = Integer(sitTributado) Then
  Begin
    Result := RetornarDadosAbreviacaoIpi(AEspecieDoDocumento, AClassificacaoFiscalDoItem, ACodigoDoProduto, ACodigoDaEmpresa);
    Exit;
  End;

  Result := RetornarResultadoAbreviacaoIpi(LBaseDeCalculoIpi, LAliquotaDeCalculoIPI);
end;


class function TFaturamentoImpostosServicosFuncoes.EhItemConcreto(
  const ACodigoDoProduto, AItemConcreto: String): Boolean;
Var
  LEhItemEstrutura : Boolean;
  LCount           : IMyCampoTabela;
  LItemConcreto    : Boolean;
  LSimplesRemessaConcretoDadosCliente : Boolean;
begin
  LCount :=
    objCore.fCampoTabela(['COUNT(*)'], 'GERMAT', ['GMT_CODITE'], [ACodigoDoProduto], False);

  LEhItemEstrutura :=
    TFunctionFuncoesFaturamento.
      fItemEstrutura(LCount.FieldByName('COUNT(*)'));

  LItemConcreto :=
    TFunctionFuncoesFaturamento.
      fItemConcreto(LEhItemEstrutura, '', AItemConcreto);

  LSimplesRemessaConcretoDadosCliente :=
    (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = CONCREMASSA);

  Result :=
    TFunctionFuncoesFaturamento.
      fEhItemConcreto( LSimplesRemessaConcretoDadosCliente,
                       LItemConcreto);
end;

class function TFaturamentoImpostosServicosFuncoes.ExisteNaTabelaCEDEM(
  const ANCM: string;
  AGerandoCasosTestes : Boolean = false): Boolean;
Var
  LCampoTabela: IMyCampoTabela;
begin

  If AGerandoCasosTestes Then
  begin
    result := false;

    if Not objCore.fTabelaExiste('CEDEM_') Then
      Exit;
  end;

  LCampoTabela := objCore.fCampoTabela(['CED_NCMITE'], 'CEDEM_', ['CED_NCMITE'], [ANCM], False);

  Result := Not objCore.fEmptyStr(LCampoTabela.FieldByName('CED_NCMITE').AsString);
end;

class function TFaturamentoImpostosServicosFuncoes.AtividadeConstrutora(
  const ACodigoAtividade, ACodigoDaEmpresa: String): Boolean;
Var
  LCodigoAtividadeBD : IMyCampoTabela;
begin
  LCodigoAtividadeBD :=
    objCore.fCampoTabela(['ATI_CODATI'], 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [ACodigoAtividade, ACodigoDaEmpresa], False);

  Result :=
    TFunctionFuncoesFaturamento.
      fAtividadeConstrutora(ACodigoAtividade,
                            LCodigoAtividadeBD.FieldByName('ATI_CODATI'));
end;

class function TFaturamentoImpostosServicosFuncoes.RetornaEstadoParaAbreviacao(
  const ADentroDoEstado: Boolean; const AEmpresaEstado,
  AUFEndEntrega: String): String;
begin
  If ADentroDoEstado Then
  Begin
    Result := AEmpresaEstado;
    Exit;
  End;

  Result := AUFEndEntrega;
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarClienteAtividade(
  const AClienteAtividade, ACodigoDaEmpresa: String): IMyCampoTabela;
begin
  Result :=
    objCore.fCampoTabela(['ATI_CODATI'], 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [AClienteAtividade, ACodigoDaEmpresa], False);
end;


class function TFaturamentoImpostosServicosFuncoes.RetornarListaDeClienteFilial: String;
Var
  LSQL          : String;
  LClienteFilial: IMyCampoTabela;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  LSQL := TFunctionFuncoesFaturamento.GetSelectClienteFilial;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  LClienteFilial := objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, [], [], False);

  Result :=
    TFunctionFuncoesFaturamento.
      RetornarListaDeClienteFilial(LClienteFilial.FieldByName('GROUP_CONCAT(EMP_CLIFIL)').AsString);
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarNotaDeImportacao(
  AClassificacaoFiscalDoItem: String): String;
begin
  If Copy(AClassificacaoFiscalDoItem,1,1) = '3' Then
  Begin
    Result := 'S';
    Exit;
  End;

  Result := 'N';
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarPrecoCompraMenosDescontoFornecedor(const ACodigoDoProduto, ACodigoDaEmpresa: String): Double;
var
  LSQL: String;
  LTabUti: String;
  LRetornoCampoTabela: IMyCampoTabela;
  LParametrosCalcularPreComMenosDescForn: IParametrosCalculoPreComMenosDescForn;
  LCALSOP: String;
begin
  LSQL := TFunctionFuncoesFaturamento.SqlCdsIteger('', LTabUti);

  LRetornoCampoTabela :=
    objCore.fCampoTabelaDados(LSQL, ['CODITE', 'CODEMP'], [ACodigoDoProduto, ACodigoDaEmpresa]);

  LCALSOP := objConfiguracoes.fGetValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_PRECO_UTILIZADO_CALCULO_SUBST_OPERACOES_PROPRIAS);

  LParametrosCalcularPreComMenosDescForn :=
    TParametrosCalculoPreComMenosDescForn.New()
      .PrecoDeUltimaCompra(LRetornoCampoTabela.FieldByName('ITE_PREULT').AsFloat)
      .PrecoDeCompra(LRetornoCampoTabela.fieldbyname('ITE_PRECOM').AsFloat)
      .Desconto01(LRetornoCampoTabela.fieldbyname('ITE_DESF01').AsFloat)
      .Desconto02(LRetornoCampoTabela.fieldbyname('ITE_DESF02').AsFloat)
      .Desconto03(LRetornoCampoTabela.fieldbyname('ITE_DESF03').AsFloat)
      .Desconto04(LRetornoCampoTabela.fieldbyname('ITE_DESF04').AsFloat)
      .Desconto05(LRetornoCampoTabela.fieldbyname('ITE_DESF05').AsFloat)
      .Desconto06(LRetornoCampoTabela.fieldbyname('ITE_DESF06').AsFloat)
      .CalculoSubstituicaoOperacoesProprias(LCALSOP);

  Result := TFunctionFuncoesFaturamento.CalcularPreComMenosDescForn(LParametrosCalcularPreComMenosDescForn);
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarTipoDeAbreviacaoClienteFornecedor(
  AParametros: IParametrosTipoDeAbreviacaoDoCliente): String;
begin
  If AParametros.DocumentoParaFornecedor Then
  Begin
    Result := TipoDeAbreviacaoDoFornecedor(AParametros.CodigoDoCliente);
    Exit;
  End;

  Result := TipoDeAbreviacaoDoCliente(AParametros);
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarTipoDeAbreviacaoNotaEspiritoSanto(
  const AOpcaoDeItemNfEspiritoSanto: TOpcItensNFespTinta;
  const ATipoDeAbreviacaoFiscal: String): String;
begin
  If AOpcaoDeItemNfEspiritoSanto in [opcBasesColorantesComDestaqueImpostos, opcColorantesTributados] Then
  Begin
    Result := '_SAI_CNC';
    Exit;
  End;

  Result := ATipoDeAbreviacaoFiscal;
end;

class function TFaturamentoImpostosServicosFuncoes.RetornarTrocaUFEndEntrega(
  const AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
  const ACodigoDaEmpresa, AOpcaoDoDocumento: String; const ADocumentoParaFornecedor: Boolean): String;
Var
  LAtendeRegraFiscalEndEntrega: Boolean;
  LClienteAtividadeBD         : String;
  LAtividadeConstrutora       : Boolean;
begin
  LClienteAtividadeBD :=
    Self.RetornarClienteAtividade(AModelClienteFornecedor.ClienteAtividade,
                                  ACodigoDaEmpresa).FieldByName('ATI_CODATI');

  LAtividadeConstrutora :=
    TFunctionFuncoesFaturamento.
      fAtividadeConstrutora(AModelClienteFornecedor.ClienteAtividade,
                            LClienteAtividadeBD);

  LAtendeRegraFiscalEndEntrega :=
    TFunctionFuncoesFaturamento.
      fAtendeRegraFiscalEndEntrega(AOpcaoDoDocumento,
                                   LAtividadeConstrutora,
                                   ADocumentoParaFornecedor,
                                   AModelClienteFornecedor.ClienteRegraFiscal);

  Result :=
    TFunctionFuncoesFaturamento.
      fTrocaUFEndEntrega(LAtendeRegraFiscalEndEntrega,
                         AModelClienteFornecedor.ClienteEstadoEntrega,
                         AModelClienteFornecedor.ClienteEstado);
end;

class function TFaturamentoImpostosServicosFuncoes.TipoDeAbreviacaoDoCliente(AParametros : IParametrosTipoDeAbreviacaoDoCliente): String;
Var
  LAbreviacao       : IMyCampoTabela;
  LSQL              : String;
  LClienteIndustrial: String;
  LClienteConsumidorFinal: String;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  If (AParametros.CodigoDoCliente = EmptyStr) Then
  begin
    Result := TFunctionFuncoesFaturamento.fGetTipoAbf('C','','','','','','','','','','',false);
    Exit;
  end;

  LClienteConsumidorFinal := TFunctionsUtils.Boolean(AParametros.ClienteConsumidorFinal).AsString;
  LClienteIndustrial := TFunctionsUtils.Boolean(AParametros.ClienteIndustria).AsString;


  LSQL := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  LAbreviacao := objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, ['CLI_CODCLI'], [AParametros.CodigoDoCliente], False);


  Result :=
    TFunctionFuncoesFaturamento.
      fGetTipoAbfCliente(AParametros.CodigoDoCliente,
                         AParametros.ClienteFisicoOuJurico,
                         AParametros.InscricaoEstadual,
                         LClienteConsumidorFinal,
                         LAbreviacao.FieldByName('CODATI'),
                         LAbreviacao.FieldByName('PRORUR'),
                         LAbreviacao.FieldByName('MICEMP'),
                         LAbreviacao.FieldByName('REGTRI'),
                         '',
                         LClienteIndustrial,
                         RetornarListaDeClienteFilial,
                         AtividadeConstrutora(LAbreviacao.FieldByName('CODATI'), AParametros.CodigoDaEmpresa));

  If (Result = '_SAI_TRS') Then
    Result := TipoDeOperacaoDeTransferencia(Result, AParametros.CodigoDoCliente, AParametros.CodigoDaEmpresa, AParametros.CodigoDaEmpresaTransferencia, LClienteIndustrial);

end;

class function TFaturamentoImpostosServicosFuncoes.TipoDeOperacaoDeTransferencia(ATipoDeAbreviacaoDoCliente, ACodigoDoCliente, ACodigoDaEmpresa, ACodigoDaEmpresaTransferencia, AClienteIndustrial: String): String;
var
  LTipoDeOperacao: IMyCampoTabela;
  LCodigoEmpresaOrigem: String;
begin
  Result := ATipoDeAbreviacaoDoCliente;

  If (AClienteIndustrial = 'S') Then
  Begin
    Result := '_SAI_IND';
    Exit;
  End;

  LCodigoEmpresaOrigem := ACodigoDaEmpresa;

  If not (ACodigoDaEmpresaTransferencia = EmptyStr) Then
    LCodigoEmpresaOrigem := ACodigoDaEmpresaTransferencia;

  LTipoDeOperacao := objCore.fCampoTabela(['IF(CON_TIPOPE=2, "T", "V") AS TIPOPE'],
                                          'CADEMP INNER JOIN CONEMP ON CON_EMPDES = EMP_CODEMP',
                                          ['EMP_CLIFIL','CON_EMPORI'],
                                          [ACodigoDoCliente, LCodigoEmpresaOrigem], False);

  If LTipoDeOperacao.FieldByName('TIPOPE').AsString = 'V' Then
    Result := '_SAI_CNC';

end;

class function TFaturamentoImpostosServicosFuncoes.TipoDeAbreviacaoDoFornecedor(
  ACodigoDoFornecedor: String): String;
Var
  LAbreviacao: IMyCampoTabela;
  LSQL       : String;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  If (ACodigoDoFornecedor = EmptyStr) Then
  begin
    Result := TFunctionFuncoesFaturamento.fGetTipoAbf('F','','','','','','','','','','',false);
    Exit;
  end;

  LSQL := TFunctionFuncoesFaturamento.fGetSelectTipoAbfFornecedor;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  LAbreviacao := objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, ['FOR_CODFOR'], [ACodigoDoFornecedor], False);

  Result :=
    TFunctionFuncoesFaturamento.
      fGetTipoAbf('F',
                  LAbreviacao.FieldByName('FISJUR').AsString,
                  LAbreviacao.FieldByName('I_E_S_').AsString,
                  '',
                  '',
                  '',
                  '',
                  LAbreviacao.FieldByName('SIMPAU').AsString,
                  LAbreviacao.FieldByName('TIPFOR').AsString,
                  '',
                  '',
                  false);
end;

class function TFaturamentoImpostosServicosFuncoes.VendaDentroDoEstado(
  AEstadoEntrega, AEmpresaEstado: String; AVendaPresencial: Boolean): Boolean;
Var
  LDentroDoEstado : Boolean;
begin
  LDentroDoEstado :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstado(AEstadoEntrega,
                      AEmpresaEstado);

  Result :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstadoFaturamento(LDentroDoEstado,
                                 AVendaPresencial);
end;

end.
