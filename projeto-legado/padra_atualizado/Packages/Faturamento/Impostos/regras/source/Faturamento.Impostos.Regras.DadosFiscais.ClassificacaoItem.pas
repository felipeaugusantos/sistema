unit Faturamento.Impostos.Regras.DadosFiscais.ClassificacaoItem;

interface

uses Faturamento.Impostos.Interfaces.DadosFiscais.ClassificacaoItem,
  Faturamento.Impostos.Tipos.DadosFiscais.ClassificacaoItem,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes,
  Shared.Functions.Funcoes.Faturamento,
  System.SysUtils, System.StrUtils;

type
  TRegraImpostosDadosFiscaisClassificacaoItem = class(TInterfacedObject, IRegraImpostosDadosFiscaisClassificacaoItem)
  private
    FCfgContribuinteDeIpi : Boolean;
    FCfgCfopNotaImp: String;

    Function ValidarItemSemClienteConsumidorParaDocumentoDeVenda(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    Function ValidarItemSemClienteConsumidorParaDocumentoDeVendaForaDoEstado(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    Function ValidarNotaEspecialTintometricoEspiritoSanto(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    Function ValidarClienteExteriorSemVendaPresencial(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    Function ValidarNfeComplementoMatrizPreenchidaParaFornecedor(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    Function ValidarOutrasSaidasParaConsertoDeEquipamentos(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : Boolean;
    function ValidarNotaDevolucaoParaOpcaoDeDocumento(Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;

    function RetonarDocumentosClassificacaoFiscal : String;
    function RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao02(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : String;
    function RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao03(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : String;

    Function ClassificacaoItemContribuinteIpi : String;
    Function ClassificacaoItemContribuinteIpiDentroEstadoCfop: String;
    Function ClassificacaoItemFaturamentoConsignacao(Const ADentroDoEstadoCFOP :Boolean): String;

    Function ClassificacaoItemOutrasSaidasForncedor(Const ADentroDoEstadoCFOP :Boolean): String;
    Function ClassificacaoItemDevolucaoDeDemonstracao(Const ADentroDoEstadoCFOP :Boolean): String;
    Function ClassificacaoItemRetornoDeConsignacao(Const ADentroDoEstadoCFOP :Boolean): String;

    Function ClassificacaoItemRetornoDeremessa(Const ADentroDoEstadoCFOP :Boolean): String;
    Function ClassificacaoItemOutrasSaidasConsertoDeEquipamentos(Const ADentroDoEstadoCFOP :Boolean): String;
    Function ClassificacaoItemNotaDeDevolucaoDentroDoEstadoCFOP(Const ADentroDoEstadoCFOP :Boolean): String;

    Function ClassificacaoItemClienteExteriorSemVendaPresencial(Const AClassificacaoFiscal :String): String;
    Function ClassificacaoItemClienteExteriorSemVendaPresencialEntrada(Const AClassificacaoFiscal :String): String;
    Function ClassificacaoItemClienteExteriorSemVendaPresencialSaida(Const AClassificacaoFiscal :String): String;

    Function ClassificacaoItemSemClienteConsumidorParaDocumentoDeVenda(Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : String;
    Function ClassificacaoItemSemClienteConsumidorParaDocumentoDeVendaContrinuinteDeIpi(Const AClassificacaoFiscal :String; Const AParametros: IParametrosDadosFiscaisClassificacaoItem) : String;

  public
    function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem;

    class function New(): IRegraImpostosDadosFiscaisClassificacaoItem;
  end;

  function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem; stdcall;


implementation


function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem; stdcall;
begin
  Result := TRegraImpostosDadosFiscaisClassificacaoItem.New.DadosFiscaisClassificacaoDoItem(AParametros);
end;

{ TRegraImpostosDadosFiscaisClassificacaoItem }

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemClienteExteriorSemVendaPresencial(
Const AClassificacaoFiscal :String) : String;
begin
  Result := ClassificacaoItemClienteExteriorSemVendaPresencialEntrada(AClassificacaoFiscal);
  Result := ClassificacaoItemClienteExteriorSemVendaPresencialSaida(Result);
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemClienteExteriorSemVendaPresencialEntrada(
  Const AClassificacaoFiscal : String): String;
begin
  Result := AClassificacaoFiscal;

  If StrToInt(LeftStr(AClassificacaoFiscal, 1)) >= 5 Then
    Exit;

  Result := '3' + RightStr(AClassificacaoFiscal,3);

  If RightStr(Result,3) <> '108' Then
    Exit;

  Result := FCfgCfopNotaImp;

end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemClienteExteriorSemVendaPresencialSaida(
  Const AClassificacaoFiscal : String): String;
begin
  Result := AClassificacaoFiscal;

  If StrToInt(LeftStr(AClassificacaoFiscal, 1)) < 5 Then
    Exit;

  Result := '7' + RightStr(AClassificacaoFiscal,3);

  If RightStr(Result,3) <> '108' Then
    Exit;

  Result := '7102';

  If (not FCfgContribuinteDeIpi) Then
    Exit;

  Result := '7101';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemContribuinteIpi : String;
begin
  Result := '6102';

  If FCfgContribuinteDeIpi Then
    Result := '6101';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemContribuinteIpiDentroEstadoCfop: String;
begin
  Result := '5102';

  If FCfgContribuinteDeIpi Then // CONTRIBUINTEIPI
    Result := '5101';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemDevolucaoDeDemonstracao(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '2913';

  If (ADentroDoEstadoCFOP) Then
    Result := '1913';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemFaturamentoConsignacao(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '6' + Copy(Trim(objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO)), 2, 3);

  If ADentroDoEstadoCFOP Then
    Result := '5' + Copy(Trim(objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO)), 2, 3);
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemNotaDeDevolucaoDentroDoEstadoCFOP(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '2202';

  If (ADentroDoEstadoCFOP) Then
    Result := '1202';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemOutrasSaidasConsertoDeEquipamentos(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '6' + Copy(Trim(objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO)), 2, 3);

  If (ADentroDoEstadoCFOP) Then
    Result := '5' + Copy(Trim(objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO)), 2, 3);
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemOutrasSaidasForncedor(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '6202';

  If (ADentroDoEstadoCFOP) Then
    Result := '5202';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemRetornoDeConsignacao(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '2' + Copy(Trim( objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO)), 2, 3);

  If (ADentroDoEstadoCFOP) Then
    Result := '1' + Copy(Trim( objConfiguracoes.fGetValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO)), 2, 3);
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemRetornoDeremessa(
  const ADentroDoEstadoCFOP: Boolean): String;
begin
  Result := '2' + objConfiguracoes.fGetValorConfiguracao(CFG_CFOP_REMESSA_ENTRADA);

  if (ADentroDoEstadoCFOP)then
    Result := '1' + objConfiguracoes.fGetValorConfiguracao(CFG_CFOP_REMESSA_ENTRADA);
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemSemClienteConsumidorParaDocumentoDeVenda(
Const AParametros: IParametrosDadosFiscaisClassificacaoItem): String;
begin
  Result := '6102';

  If AParametros.DocumentoDeVenda Then
    Result := '6108';

  Result := ClassificacaoItemSemClienteConsumidorParaDocumentoDeVendaContrinuinteDeIpi(Result, AParametros);

end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ClassificacaoItemSemClienteConsumidorParaDocumentoDeVendaContrinuinteDeIpi(
  const AClassificacaoFiscal: String;
  const AParametros: IParametrosDadosFiscaisClassificacaoItem): String;
begin

  Result := AClassificacaoFiscal;

  If (FCfgContribuinteDeIpi) Then
  Begin
    Result := '6101';

    If Not AParametros.ClienteConsumidorFinal Then
      Exit;

    If AParametros.DocumentoDeVenda Then
      Result := '6107';

    Exit;
  End;

  If Not AParametros.ClienteConsumidorFinal Then
    Result := '6102';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.DadosFiscaisClassificacaoDoItem(
  AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem;
Var
  LClassificacao1 : String;
  LClassificacao2 : String;
  LClassificacao3 : String;
begin

  FCfgContribuinteDeIpi :=
    objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean);

  FCfgCfopNotaImp := objConfiguracoes.fGetValorConfiguracao(CFG_CFOP_NOTA_IMPORTACAO, varString);

  LClassificacao1 := ClassificacaoItemContribuinteIpi;

  LClassificacao2 := AParametros.ClassificacaoFiscal2;

  LClassificacao3:=  AParametros.ClassificacaoFiscal3;

  If AParametros.DentroDoEstadoCFOP Then
  Begin
    LClassificacao1 := ClassificacaoItemContribuinteIpiDentroEstadoCfop;
  End;

  If ValidarItemSemClienteConsumidorParaDocumentoDeVendaForaDoEstado(AParametros) Then
  Begin
    LClassificacao1 :=
      ClassificacaoItemSemClienteConsumidorParaDocumentoDeVenda(AParametros);
  End;

  If ValidarNotaDevolucaoParaOpcaoDeDocumento(AParametros)Then
  Begin
    If AParametros.OpcaoDocumento = FATURAMENTO_CONSIGNACAO Then
    Begin
      LClassificacao1 := ClassificacaoItemFaturamentoConsignacao(AParametros.DentroDoEstadoCFOP);
    End
    Else If AParametros.OpcaoDocumento = OUTRAS_SAIDAS_FORNECEDOR  Then
    Begin
      LClassificacao1 := ClassificacaoItemOutrasSaidasForncedor(AParametros.DentroDoEstadoCFOP);
    End
    Else If AParametros.OpcaoDocumento = DEVOLUCAO_DE_DEMOSTRACAO Then
    Begin
      LClassificacao1 := ClassificacaoItemDevolucaoDeDemonstracao(AParametros.DentroDoEstadoCFOP);
    End
    Else If AParametros.OpcaoDocumento = RETORNO_DE_CONSIGNACAO Then
    Begin
      LClassificacao1 := ClassificacaoItemRetornoDeConsignacao(AParametros.DentroDoEstadoCFOP);
    End
    Else If AParametros.OpcaoDocumento = RETORNO_DE_REMESSA then
    Begin
      LClassificacao1 := ClassificacaoItemRetornoDeremessa(AParametros.DentroDoEstadoCFOP);
    End
    Else
    Begin
      LClassificacao1 := ClassificacaoItemNotaDeDevolucaoDentroDoEstadoCFOP(AParametros.DentroDoEstadoCFOP);

      If (Pos(AParametros.CfopDevolucao, DEVOLUCAO_DE_MERCADORIA_CONSIGNACAO) > 0) Then
      Begin
        LClassificacao1 := AParametros.CfopDevolucao;

        LClassificacao2 := RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao02(AParametros);

        LClassificacao3 := RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao03(AParametros);
      End;

    End;

  End;

  If ValidarClienteExteriorSemVendaPresencial(AParametros) Then
  Begin
    LClassificacao1 := ClassificacaoItemClienteExteriorSemVendaPresencial(LClassificacao1);
  End;

  If ValidarNotaEspecialTintometricoEspiritoSanto(AParametros) Then
  Begin
    If Not (AParametros.ClassificacaoNotaEspiritoSanto = EmptyStr) Then
      LClassificacao1 := AParametros.ClassificacaoNotaEspiritoSanto;
  End;

  If ValidarOutrasSaidasParaConsertoDeEquipamentos(AParametros) Then
  Begin
    LClassificacao1 := ClassificacaoItemOutrasSaidasConsertoDeEquipamentos(AParametros.DentroDoEstadoCFOP);
  End;

  If ValidarNfeComplementoMatrizPreenchidaParaFornecedor(AParametros) Then
  Begin
    If Not(AParametros.ClassificacaoNfeComplemento = EmptyStr) Then
      LClassificacao1 := AParametros.ClassificacaoNfeComplemento;
  End;

  If AParametros.NotaDeComplementoDeClienteComplementandoValor Then
  Begin
    If Not(AParametros.ClassificacaoNfeComplemento = EmptyStr) Then
      LClassificacao1 := AParametros.ClassificacaoNfeComplemento;
  End;

  Result :=
    TResultadodadosFiscaisClassificacaoItem.New
      .ClassificacaoFiscal1(LClassificacao1)
      .ClassificacaoFiscal2(LClassificacao2)
      .ClassificacaoFiscal3(LClassificacao3);

end;

class function TRegraImpostosDadosFiscaisClassificacaoItem.New: IRegraImpostosDadosFiscaisClassificacaoItem;
begin
  Result := Self.Create;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.RetonarDocumentosClassificacaoFiscal: String;
begin
  Result := ENTRADA_FORNECEDOR + '-';
  Result := Result + OUTRAS_ENTRADAS + '-';
  Result := Result + DEVOLUCAO + '-';
  Result := Result + PEDIDO_DEVOLUCAO_RETIRADA + '-';
  Result := Result + OUTRAS_SAIDAS_FORNECEDOR + '-';
  Result := Result + DEVOLUCAO_DE_DEMOSTRACAO + '-';
  Result := Result + RETORNO_DE_CONSIGNACAO + '-';
  Result := Result + FATURAMENTO_CONSIGNACAO + '-';
  Result := Result + ENVIO_GARANTIA_FORNECEDOR + '-';
  Result := Result + RETORNO_DE_REMESSA + '-';
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao02(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): String;
begin
  Result := AParametros.ClassificacaoFiscal2;

  If (AParametros.ClassificacaoFiscal2 = EmptyStr) Then
    Exit;

  Result := AParametros.CfopDevolucao;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.RetornarClassifFiscalParaDevolcucaoMercadoriaConsignacao03(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): String;
begin
  Result := AParametros.ClassificacaoFiscal3;

  If (AParametros.ClassificacaoFiscal3 = EmptyStr) Then
    Exit;

  Result := AParametros.CfopDevolucao;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarItemSemClienteConsumidorParaDocumentoDeVendaForaDoEstado(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := false;

  If Not ValidarItemSemClienteConsumidorParaDocumentoDeVenda(AParametros) Then
    Exit;

  If AParametros.DentroDoEstadoCFOP Then
    Exit;

  Result := true;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarNfeComplementoMatrizPreenchidaParaFornecedor(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := False;

  If Not (AParametros.NCFornecedor)  Then
    Exit;

  If Not(AParametros.NfeComplementoMatrizPreenchida) Then
    Exit;

  Result := True;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarNotaDevolucaoParaOpcaoDeDocumento(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := true;

  If (AParametros.NotaDevolucao) Then
    Exit;

  If TFunctionFuncoesFaturamento.
    LocalizarOpcaoDeDocumento(AParametros.OpcaoDocumento, RetonarDocumentosClassificacaoFiscal) Then
  Begin
    Exit;
  End;

  result := False;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarNotaEspecialTintometricoEspiritoSanto(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := False;

  If Not(AParametros.OpcaoDocumento = NOTA_ESPECIAL) Then
    Exit;

  If Not (objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_NOTA_TINTOMETRICO_ESPIRITO_SANTO, varBoolean)) Then
    Exit;

  if (AParametros.DocumentoDeComplementoDeValores) Then
    Exit;

  If Not AParametros.ClienteFilialEmpresaLogada Then
    Exit;

  Result := True;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarOutrasSaidasParaConsertoDeEquipamentos(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := False;

  If Not(AParametros.OpcaoDocumento = OUTRAS_SAIDAS) Then
    Exit;

  If Not (AParametros.ConsertoDeEquipamento) Then
    Exit;

  Result := True;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarClienteExteriorSemVendaPresencial(
  Const AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := false;

  If Not(AParametros.ClienteEstado = EXTERIOR) Then
    Exit;

  If (AParametros.VendaPresencial) Then
    Exit;

  Result := true;
end;

function TRegraImpostosDadosFiscaisClassificacaoItem.ValidarItemSemClienteConsumidorParaDocumentoDeVenda(
  Const  AParametros: IParametrosDadosFiscaisClassificacaoItem): Boolean;
begin
  Result := True;

  If (AParametros.AtividadeConstrutora) Then
    Exit;

  Result := False;

  If (AParametros.InscricaoEstadual <> EmptyStr) Then
    Exit;

  If (AParametros.MicroEmpreendedor) Then
    Exit;

  Result := True;
end;

 exports DadosFiscaisClassificacaoDoItem;

end.
