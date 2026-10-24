unit untBaixaLotesWMS;

interface

uses
  StrUtils, SysUtils, Classes, Forms, DB,
  Uni, Controls, EditFocus, UniClientDataSet,
  Math, ComCtrls, untCadLote, cxProgressBar,
  untAuditoriaGravacaoFaturamento, System.Types,
  untTFatReprocessarSaldoItem,

  Fulfillment.RegrasMovimentacaoEstoque,
  Fulfillment.Types,
  Fulfillment.Classes.Parametros;

Type
  TMovimentacao = (mvmIgual, mvmAMais, mvmAMenos);

  TBaixaLotesWMS = Class(TComponent)
  Private

    FCadLot      : TCadLot;
    FCodCli      : String;
    strAutInc    : String;
    dtaDtaEnt    : TDateTime;
    strClaFis    : String;
    strAutIncDet : String;

    FLotes: TUniClientDataSet;
    FExpIte: TUniClientDataSet;

    FCodOpe,
    FEspDoc,
    FNumDoc: String;
    FProgre: TCxProgressBar;

    FDocFat: String;
    FEspFat: String;
    FEmpFat: String;
    FCliFat: String;
    FFulfillment: TFulfillment;

    FAuditFaturamento : IAuditoriaGravacaoFaturamento;
    FAuditoriaGravacaoFaturamentoMSGErro : String;
    FCodErroAuditoria: String;
    FValidaLoteDefPD: Boolean;

    function fDeveMovimentarEstoqueFisico(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
    function fDeveMovimentarEstoqueExterno(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;

    function GetLoteDestino(const ACodIte, ALotePD: String): String;

    function GetTemLotes: Boolean;

    function fGravaMovGerTransf: Boolean;

    function fGravaMovDetTransf: Boolean;
    function fGravaMovDetTransf_Interna(AQuantidade   : Double = 0.00;
                                        AMovimentacao : TMovimentacao = mvmIgual;
                                        ACodigoDoItem : String = '';
                                        ANumeroDoLote : String = '') : Boolean;

    function fSQLItem: String;

    function fApagaDigitacaoLotes(const ABaixaEstoque: Boolean = False): Boolean;
    function fApagaLotesDigitados       : Boolean;
    function fApagaTodosOsLotesDoPedido : Boolean;
    function fAtualizaLotDorLotesTransitorios: Boolean;
  Public

    function fCarregaLotesDigitados(strAutIncFatDor: String; strAutIncMovDet: String=''): Double;

    function fBaixarEstoqueLotes(pgbProgresso: TCxProgressBar = nil): Boolean;

    function fTransferirParaEstoqueExterno(pgbProgresso: TCxProgressBar = nil): Boolean;
    function fTransferirParaEstoqueExterno_MovimentarQuantidadeSeparada(pgbProgresso: TCxProgressBar = nil): Boolean;
    function fTransferirParaEstoqueExterno_GerarPDParaGuardarDiferencas(pgbProgresso: TCxProgressBar = nil): Boolean;

    function fApagaDigitacaoLotes_RemoverLocalizacaoFisicaLotes(pgbProgresso: TCxProgressBar = nil): Boolean;

    procedure pLimparLotes;

    constructor Create(Owner: TComponent); Reintroduce;
    Destructor  Destroy; Override;

    property strCodOpe: String Read FCodOpe Write FCodOpe;
    property strEspDoc: String Read FEspDoc;
    property strNumDoc: String Read FNumDoc;

    property strDocFat: String Read FDocFat Write FDocFat;
    property strEspFat: String Read FEspFat Write FEspFat;
    property strEmpFat: String Read FEmpFat Write FEmpFat;
    property strCliFat: String Read FCliFat Write FCliFat;

    property Fulfillment : TFulfillment Read FFulfillment Write FFulfillment;

    //cdsItens do frmFatExpedicaoItens
    property cdsExpIte: TUniClientDataSet Read FExpIte Write FExpIte;

    property strAuditoriaGravacaoFaturamentoMSGErro: String Read FAuditoriaGravacaoFaturamentoMSGErro Write FAuditoriaGravacaoFaturamentoMSGErro;
    property strCodErroAuditoria: String Read FCodErroAuditoria Write FCodErroAuditoria;
    property blnValidaLoteDefPD: Boolean Read FValidaLoteDefPD Write FValidaLoteDefPD;

    property blnTemLotes: Boolean Read GetTemLotes;

  end;

implementation

Uses
  untMovGer, untFuncoesSimples, untReimpressao, untTypesSistema, untConstantes,

  Fulfillment.Classes.NotaRemessaVsPedidoVenda,
  Fulfillment.Funcoes, untGravando;

Const
  STR_CLAENT = '1999';
  STR_CLASAI = '5999';

function TBaixaLotesWMS.fApagaLotesDigitados : Boolean;
Var
  LEmpresa : String;
  LEmpresas: TArray<String>;
  LLisIncFatDor : String;
  LobjReprocessarSaldoItens: IReprocessarSaldoItem;
begin
  Result := True;

  LobjReprocessarSaldoItens := TReprocessarSaldoItem.New();

  LLisIncFatDor := '';

  FLotes.First;
  While Not FLotes.Eof Do
  Begin
    pIncrementaListaStr(FLotes.FieldByName('AUTINC').AsString, LLisIncFatDor, True, True);

    LEmpresas := fGetEmpresasReprocessarItemPedido(FLotes.FieldByName('AUTINC').AsString);

    For LEmpresa In LEmpresas Do
      LobjReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(FLotes.FieldByName('CODITE').AsString).Empresa(LEmpresa));

    FLotes.Next;
  End;

  If (LLisIncFatDor <> '') Then
  Begin
    pEnviaLotDorParaDelLotDor(LLisIncFatDor);
    Result := Result And fExecutaSQL('DELETE FROM LOTDOR WHERE LDO_SEQFDO IN (' +LLisIncFatDor+ ')');
  End;

  LobjReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;
end;

function TBaixaLotesWMS.fApagaTodosOsLotesDoPedido : Boolean;
Var
  LLotDor   : TUniQuery;
  LEmpresas : TArray<String>;
  LLisIncFatDor: String;
  LEmpresa  : String;
  LobjReprocessarSaldoItens: IReprocessarSaldoItem;
begin
  Result := True;

  LobjReprocessarSaldoItens := TReprocessarSaldoItem.New();
  LLotDor := fCriaQuery();
  Try
    LLotDor.SQL.Add(' SELECT                         ');
    LLotDor.SQL.Add('   FATDOR.AUTOINCREM AS AUTINC, ');
    LLotDor.SQL.Add('   FATDOR.FDO_CODITE AS CODITE  ');
    LLotDor.SQL.Add(' FROM     ');
    LLotDor.SQL.Add('   LOTDOR ');
    LLotDor.SQL.Add('   INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO ');
    LLotDor.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC ');
    LLotDor.SQL.Add('   AND FDO_ESPDOC = :ESPDOC ');
    LLotDor.SQL.Add('   AND FDO_CODEMP = :CODEMP ');

    LLotDor.ParamByName('NUMDOC').AsString := FFulfillment.NumeroPedido;
    LLotDor.ParamByName('ESPDOC').AsString := 'PD';
    LLotDor.ParamByName('CODEMP').AsString := FFulfillment.EmpresaPedido;
    LLotDor.Open;

    LLotDor.First;

    LLisIncFatDor := '';
    While Not LLotDor.Eof Do
    Begin
      pIncrementaListaStr(LLotDor.FieldByName('AUTINC').AsString, LLisIncFatDor, True, True);

      LEmpresas := fGetEmpresasReprocessarItemPedido(LLotDor.FieldByName('AUTINC').AsString);

      For LEmpresa In LEmpresas Do
        LobjReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(LLotDor.FieldByName('CODITE').AsString).Empresa(LEmpresa));

      LLotDor.Next;
    End;

  Finally
    If (LLisIncFatDor <> '') Then
    Begin
      pEnviaLotDorParaDelLotDor(LLisIncFatDor);
      Result := Result And fExecutaSQL('DELETE FROM LOTDOR WHERE LDO_SEQFDO IN (' +LLisIncFatDor+ ')');
    End;

    LobjReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;
    FreeAndNil(LLotDor);
  End;
end;

function TBaixaLotesWMS.fAtualizaLotDorLotesTransitorios: Boolean;
var
  LLisIncFatDor,
  LLisIncLotDor,
  LEmpresa : String;
  LEmpresas: TArray<String>;
  LQry: TUniQuery;
  LobjReprocessarSaldoItens: IReprocessarSaldoItem;
begin
  Result := True;

  LLisIncFatDor := '';
  LLisIncLotDor := '';

  LQry := fCriaQuery;
  LobjReprocessarSaldoItens := TReprocessarSaldoItem.New();
  try
    LQry.SQL.Add('UPDATE LOTDOR ');
    LQry.SQL.Add('SET LDO_QTDITE = :QTDITE, ');
    LQry.SQL.Add('    LDO_QTDSEP = :QTDITE  ');
    LQry.SQL.Add('WHERE AUTOINCREM = :SEQLDO ');

    FLotes.First;

    while not FLotes.Eof do
    begin
      if (FLotes.FieldByName('QTDSEP').AsFloat = 0) then
      begin
        FLotes.Next;
        Continue;
      end;

      if (FLotes.FieldByName('QTDPEN').AsFloat = 0) then
      begin
        pIncrementaListaStr(FLotes.FieldByName('AUTINC').AsString, LLisIncFatDor, True, True);
      end
      else if ((FLotes.FieldByName('QTDSEP').AsFloat - FLotes.FieldByName('QTDITE').AsFloat) = 0) then
      begin
        pIncrementaListaStr(FLotes.FieldByName('SEQLDO').AsString, LLisIncLotDor, True, True);
      end
      else
      begin
        LQry.Close;
        LQry.ParamByName('SEQLDO').AsString := FLotes.FieldByName('SEQLDO').AsString;
        LQry.ParamByName('QTDITE').AsFloat  := FLotes.FieldByName('QTDSEP').AsFloat - FLotes.FieldByName('QTDITE').AsFloat;
        LQry.ExecSQL;
      end;

      LEmpresas := fGetEmpresasReprocessarItemPedido(FLotes.FieldByName('AUTINC').AsString);

      For LEmpresa In LEmpresas Do
        LobjReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(FLotes.FieldByName('CODITE').AsString).Empresa(LEmpresa));

      FLotes.Next;
    end;
  finally
    If (LLisIncFatDor <> '') Then
    Begin
      pEnviaLotDorParaDelLotDor(LLisIncFatDor);
      Result := Result And fExecutaSQL('DELETE FROM LOTDOR WHERE LDO_SEQFDO IN (' +LLisIncFatDor+ ')');
    End;
    If (LLisIncLotDor <> '') Then
    Begin
      Result := Result And fExecutaSQL('DELETE FROM LOTDOR WHERE AUTOINCREM IN (' +LLisIncLotDor+ ')');
    End;

    LobjReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;
    FreeAndNil(LQry);
  end;
end;

constructor TBaixaLotesWMS.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FCadLot := TCadLot.Create(Self);
  FCodCli := fCfgSis('CLI_TA');

  FFulfillment := TFulfillment.New;

  FLotes := TUniClientDataSet.Create(Self);

  With FLotes, FieldDefs Do
  Begin

    With AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMLOT'; DataType := ftString; Required := False; Size := VS_Size_NumLot; End;
    With AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDITE'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'AUTGRV'; DataType := ftString; Required := False; End; //RELAÇÃO ENTRE A MOVDET NOTA/ MOVDET TL/TA
    With AddFieldDef Do Begin Name := 'LOTEPD'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'SEQLDO'; DataType := ftString; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDPEN'; DataType := ftFloat;  Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDSEP'; DataType := ftFloat;  Required := False; End;

    CreateDataSet;
    Open;

    IndexFieldNames := 'AUTINC;CODITE;NUMLOT';
  End;

  FAuditFaturamento := TAuditoriaGravacaoFaturamento.New;
  FAuditoriaGravacaoFaturamentoMSGErro := '';
  FCodErroAuditoria := '';
  FValidaLoteDefPD := False;
end;

Function TBaixaLotesWMS.fGravaMovGerTransf: Boolean;
  Var
    recServicos: TDadosServicos;
    arrDuplic : TarrDuplicata;
Begin
  {***************************************************************}
  {* Limpa os dados de servicoes como codigo, descricao e valor  *}
  {************************************************************JC*}
  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                         FNumDoc,                                                       // Numero Documento
                         FEspDoc,                                                       // Espécie
                         VS_strCodEmp,                                                  // Empresa
                         '',                                                            // Transportadora
                         FCodOpe,                                                       // Vendedor
                         '',                                                            // Fornecedor
                         FCodCli,                                                       // Cliente
                         'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                         dtaDtaEnt,                                                     // Data da Entrada
                         fTime(),                                                       // Hora da Entrada
                         VS_Date,                                                       // Data do Documento
                         '01000',                                                       // Condição de Pagamento
                         '',                                                            // Estado do Cliente / Fornecedor
                         '',                                                            // Nome do Consumidor
                         '',                                                            // Endereço do Consumidor
                         '',                                                            // Bairro do Consumidor
                         '',                                                            // Cep do Consumidor
                         '',                                                            // Cidade do Consumidor
                         '',                                                            // Estado do Consumidor
                         '',                                                            // Telefone do Consumidor
                         0,
                         '',                                                            // CNPJ / CGC
                         '',                                                            // CNPJ / CGC do consumidor
                         '',                                                            // Inscrição estadual do Consumidor
                         '',                                                            // RG do consumidor
                         0.0,                                                           // Base Simples Paulista
                         0.0,                                                           // Base de IPI
                         0.0,                                                           // Aliquota de IPI
                         0.0,                                                           // Total de IPI
                         0.0,                                                           // Base de ICMS
                         0.0,                                                           // Aliquota de ICMS
                         0.0,                                                           // Total de ICMS
                         0.0,                                                           // Valor de Substituição
                         0.0,                                                           // Aliquota de Substituição
                         0.0,                                                           // Base de Substituição
                         0.0,                                                           // Base de Substituição Simulada
                         0.0,                                                           // Desconto Especial
                         0.0,                                                           // Valor Contábil
                         0.0,                                                           // Total dos Itens
                         0.0,                                                           // Total de Custo
                         0.0,                                                           // Total Médio
                         '',                                                            // Tipo de Frete
                         0.0,                                                           // Valor do Frete
                         0.0,                                                           // Peso Bruto
                         0.0,                                                           // Peso Liquido
                         0.0,                                                           // Volume
                         '',                                                            // Especie
                         '',                                                            // Marca
                         '',                                                            // Mensagem 1
                         '',                                                            // Mensagem 2
                         '',                                                            // Mensagem 3
                         '',                                                            // Mensagem 4
                         '',                                                            // Mensagem 5
                         True,                                                          // Indica se Faturado ou nao
                         FEspFat,                                                       // Tipo de Faturamento
                         FDocFat,                                                       // Numero de Faturamento
                         FEmpFat,                                                       // Empresa dd Faturamento
                         VS_Date,                                                       // Data de Faturamento
                         '',                                                            // Vendedor do Faturamento
                         '',                                                            // Condição de Pagamento do Faturamento
                         False,                                                         // Devolução Especial
                         0.0,                                                           // Valor do Faturamento
                         0.0,                                                           // Valor Parcela 01
                         0.0,                                                           // Valor Parcela 02
                         0.0,                                                           // Valor Parcela 03
                         0.0,                                                           // Valor Parcela 04
                         0.0,                                                           // Valor Parcela 05
                         0.0,                                                           // Valor Parcela 06
                         0.0,                                                           // Valor Parcela 07
                         0.0,                                                           // Valor Parcela 08
                         0.0,                                                           // Valor Parcela 09
                         0.0,                                                           // Valor Parcela 10
                         0.0,                                                           // Valor Parcela 11
                         0.0,                                                           // Valor Parcela 12
                         arrDuplic,
                         '',                                                            // Série
                         'N',                                                           // Nota Especial
                         '99999',                                                       // Classificação Fiscal 1
                         '',                                                            // Classificação Fiscal 2
                         '',                                                            // Classificação Fiscal 3
                         '',                                                            // Natureza da Operação
                         0.0,                                                           // Percentual de Desconto
                         FCodOpe,                                                       // Codigo do Digitador
                         '',                                                            // Codigo da Condição
                         '',                                                            // Forma de Pagamento
                         0.0,                                                           // Fator para meia nota
                         recServicos,
                         0.0,                                                           // Despesa acessoria
                         '',                                                            // Origem do Documento (V)enda (D)evolução
                         'N',                                                           // Usa controle de entrega
                         '',                                                            // Representante
                         0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                         0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do Pis (SERVIÇO)
                         0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                         0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                         0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                         0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                         0.0,                                                           // Valor de IRPF que foi retido
                         0.0,                                                           // Valor de PIS que foi retido
                         0.0,                                                           // Valor de COFINS que foi retido
                         0.0,                                                           // Valor de CSLL que foi retido
                         '',                                                            // Notas de Documentos Acumulados
                         0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                         0.0,                                                           // Aliquota do PIS (PRODUTOS)
                         0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                         0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                         0.0,                                                           // Valor de SERVIÇO que foi retido
                         '',                                                            // Notas de documentos acumulados (SERVIÇO)
                         0.0,                                                           // Percentual da Seguridade Social
                         0.0,                                                           // Valor da Seguridade Social
                         0.0,                                                           // Valor do IRPF Retido (Produto)
                         0.0,                                                           // Valor do IRPF Devido (Produto)
                         0.0,                                                           // Valor do IRPF Retido (Serviço)
                         0.0,                                                           // Valor do IRPF Devido (Serviço)
                         0.0,                                                           // Valor do PIS Retido (Produto)
                         0.0,                                                           // Valor do PIS Devido (Produto)
                         0.0,                                                           // Valor do PIS Retido (Serviço)
                         0.0,                                                           // Valor do PIS Devido (Serviço)
                         0.0,                                                           // Valor do COFINS Retido (Produto)
                         0.0,                                                           // Valor do COFINS Devido (Produto)
                         0.0,                                                           // Valor do COFINS Retido (Serviço)
                         0.0,                                                           // Valor do COFINS Devido (Serviço)
                         0.0,                                                           // Valor do CSLL Retido (Produto)
                         0.0,                                                           // Valor do CSLL Devido (Produto)
                         0.0,                                                           // Valor do CSLL Retido (Serviço)
                         0.0,                                                           // Valor do CSLL Devido (Serviço)
                         '',                                                            // Ordem de Produção
                         0.0,                                                           // Base Orgão Público
                         0.0,                                                           // ICMS Orgão Público
                         0,                                                             // Número do Conhecimento de Frete
                         '',                                                            // Consumidor final
                         'N',                                                           // Entrega no Faturamento
                         FCliFat,                                                       // Cliente de Faturamento
                         '',                                                            // Operador da Expedição
                         '',                                                            // Separador da Expedição
                         '',                                                            // Tabela de Preços utilizada
                         '',
                         'N',                                                           // Entrega Futura
                         FALSE,                                                         // Baixa de Entrega Futura
                         0,                                                             // Margem de Lucro
                         0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                         0.0,                                                           // Valor do retido considerando a base acima.
                         'N',                                                           // Gerar produção fora da loja
                         '',                                                            // Numero do Registro - Correios ou Transportadora
                         VS_Date,                                                       // Data de Entrega no Romaneio
                         '',                                                            // Classificação fiscal 4
                         'N',                                                           // AUTO-SERVIÇO
                         '',                                                            // Evento
                         '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                         '',                                                            // Conteúdo do CNFNFE
                         '',                                                            // Motivo da Devolução
                         '',
                         False);                                                        // Imprime Duplicatas na NF-e

  FAuditFaturamento.Adicionar(strAutInc, 'MOVGER');

  If Assigned(FProgre) Then
    FProgre.Position := FProgre.Position + 1;

  pProcessMessages;
End;

Function TBaixaLotesWMS.fSQLItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                   ';
  strSQL := strSQL + '   ITE_DESITE,            ';
  strSQL := strSQL + '   ITE_CODMAR,            ';
  strSQL := strSQL + '   ITE_CODUNI,            ';
  strSQL := strSQL + '   ITE_CODFOR,            ';
  strSQL := strSQL + '   ITE_REFERE,            ';
  strSQL := strSQL + '   ITE_INCPIS,            ';
  strSQL := strSQL + '   ITE_PRECUS             ';
  strSQL := strSQL + ' FROM                     ';
  strSQL := strSQL + '   CADITE C               ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP          ';
  strSQL := strSQL + ' WHERE                    ';
  strSQL := strSQL + '   C.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

function TBaixaLotesWMS.fTransferirParaEstoqueExterno(pgbProgresso: TCxProgressBar = nil): Boolean;
begin
  If (ModeloDeMovimentacaoDeSaldo = fmmGerarPedidoParaGuardarAsDiferencas) Then
    Result := fTransferirParaEstoqueExterno_GerarPDParaGuardarDiferencas(pgbProgresso)
  Else
    Result := fTransferirParaEstoqueExterno_MovimentarQuantidadeSeparada(pgbProgresso);
end;

function TBaixaLotesWMS.fTransferirParaEstoqueExterno_GerarPDParaGuardarDiferencas(pgbProgresso: TCxProgressBar): Boolean;
begin
  FAuditoriaGravacaoFaturamentoMSGErro := '';
  FCodErroAuditoria := '';

  Try
    dtaDtaEnt := VS_Date;

    If Assigned(pgbProgresso) Then
    Begin
      FProgre := pgbProgresso;
      FProgre.Position := 0;
      FProgre.properties.Max := 2 * FLotes.RecordCount + 1;
    End;

    FEspDoc := 'TL';
    FNumDoc := fRetSequencial_TL;

    FAuditFaturamento.Limpar;

    Result := fGravaMovGerTransf;

    strClaFis := STR_CLASAI;
    Result := Result And fGravaMovDetTransf;

    strClaFis := STR_CLAENT;
    Result := Result And fGravaMovDetTransf;

    Result := Result And fApagaDigitacaoLotes;

    if (Result) And (not FAuditFaturamento.fValidouTodas(FCodErroAuditoria)) then
    begin
      FAuditoriaGravacaoFaturamentoMSGErro := 'ATENÇÃO! ' + fRetornaErrosAuditoria(FCodErroAuditoria);
      Result := False;
    end;

    FProgre := nil;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fTransferirParaEstoqueExterno_GerarPDParaGuardarDiferencas]');
    End;
  End;
end;

function TBaixaLotesWMS.fTransferirParaEstoqueExterno_MovimentarQuantidadeSeparada(pgbProgresso: TCxProgressBar): Boolean;
  const
    FIELD_DIVERGENCIA = 'INCONSISTENCIA';

  var
    LNotaRemessaVsPedidoVenda : TNotaRemessaVsPedidoVenda;
    LItensValidacao           : TUniClientDataSet;

    LSigla             : String;
    LCodigoDoItem      : String;

  function fExecMovimentacoes(AStatusNotaRemessaVsPedidoVenda : TStatusNotaRemessaVsPedidoVenda) : Boolean;
    var
      LQuantidadeSeparada      : Double;
      LQuantidadeTotalSeparada : Double;
      LQuantidadeTotalFaturada : Double;
      LQuantidadeDivergente    : Double;
      LQuantidadeConvergente   : Double;

      LSeparouAMais : Boolean;
      LNumeroDoLote : String;
      LLotDor       : TUniQuery;
  begin

    Result := True;

    LNumeroDoLote            := EmptyStr;
    LQuantidadeTotalSeparada := 0.00;

    strClaFis := STR_CLASAI;
    LLotDor   := RetornaQueryDadosLOTDOR(Fulfillment.NumeroPedido, 'PD', Fulfillment.EmpresaPedido, LCodigoDoItem);

    If LLotDor.IsEmpty Then
      Exit;

    LLotDor.First;
    While Not LLotDor.Eof Do
    Begin

      LNumeroDoLote            := LLotDor.FieldByName('NUMLOT').AsString;
      LQuantidadeSeparada      := LLotDor.FieldByName('QTDSEP').AsFloat;
      LQuantidadeTotalSeparada := (LQuantidadeTotalSeparada + LQuantidadeSeparada);

      Result := Result And fGravaMovDetTransf_Interna(LQuantidadeSeparada, mvmIgual, LCodigoDoItem, LNumeroDoLote);

      LLotDor.Next;
    End;

    strClaFis := STR_CLAENT;

    If (AStatusNotaRemessaVsPedidoVenda = staQtdCondizenteEntrePedidoENota) Then
    Begin
      Result := Result And fGravaMovDetTransf_Interna(LQuantidadeTotalSeparada, mvmIgual, LCodigoDoItem, EmptyStr);
      Exit(Result);
    End;

    If (AStatusNotaRemessaVsPedidoVenda = staProdutoDivergente) Then
    Begin
      LQuantidadeTotalFaturada := LItensValidacao.FieldByName('QTDITE_NF').AsFloat;
      LSeparouAMais            := (LQuantidadeTotalSeparada > LQuantidadeTotalFaturada);
      LQuantidadeDivergente    := IIF(LSeparouAMais, (LQuantidadeTotalSeparada - LQuantidadeTotalFaturada), (LQuantidadeTotalFaturada - LQuantidadeTotalSeparada));

      Result := Result And fGravaMovDetTransf_Interna(LQuantidadeDivergente, IIF(LSeparouAMais, mvmAMais, mvmAMenos), LCodigoDoItem, EmptyStr);
      Exit(Result);
    End;

    If (AStatusNotaRemessaVsPedidoVenda = staQtdDivergente) Then
    Begin
      LQuantidadeTotalFaturada := LItensValidacao.FieldByName('QTDITE_NF').AsFloat;
      LSeparouAMais            := (LQuantidadeTotalSeparada > LQuantidadeTotalFaturada);
      LQuantidadeDivergente    := IIF(LSeparouAMais, (LQuantidadeTotalSeparada - LQuantidadeTotalFaturada), (LQuantidadeTotalFaturada - LQuantidadeTotalSeparada));
      LQuantidadeConvergente   := IIF(LSeparouAMais, LQuantidadeTotalFaturada, LQuantidadeTotalSeparada);

      Result := Result And fGravaMovDetTransf_Interna(LQuantidadeConvergente, mvmIgual, LCodigoDoItem, EmptyStr);
      Result := Result And fGravaMovDetTransf_Interna(LQuantidadeDivergente, IIF(LSeparouAMais, mvmAMais, mvmAMenos), LCodigoDoItem, EmptyStr);
      Exit(Result);
    End;

  end;

begin

  LNotaRemessaVsPedidoVenda := TNotaRemessaVsPedidoVenda.New(Fulfillment.ChaveDeAcesso,
                                                             Fulfillment.NumeroPedido,
                                                             Fulfillment.NumeroPedido,
                                                             Fulfillment.EmpresaPedido,
                                                             Fulfillment.SiglaHubMarketPlace);

  LItensValidacao := TUniClientDataSet.Create(Nil);

  Try

    LNotaRemessaVsPedidoVenda.PreValidacao;
    pCloneDataSet(LItensValidacao, LNotaRemessaVsPedidoVenda.ItensValidacao);

    FAuditoriaGravacaoFaturamentoMSGErro := '';
    FCodErroAuditoria := '';

    Try
      dtaDtaEnt := VS_Date;

      If Assigned(pgbProgresso) Then
      Begin
        FProgre := pgbProgresso;
        FProgre.Position := 0;
        FProgre.properties.Max := 2 * FLotes.RecordCount + 1;
      End;

      FEspDoc := 'TL';
      FNumDoc := fRetSequencial_TL;

      FAuditFaturamento.Limpar;

      Result := fGravaMovGerTransf;

      If (Result) Then
      Begin

        LItensValidacao.First;
        While Not LItensValidacao.Eof Do
        Begin

          LSigla        := IIF(Not fEmptyStr(LItensValidacao.FieldByName('CODITE_NF').AsString), 'NF', 'PD');
          LCodigoDoItem := LItensValidacao.FieldByName('CODITE_' + LSigla).AsString;

          Result := Result And fExecMovimentacoes(TStatusNotaRemessaVsPedidoVenda(LItensValidacao.FieldByName(FIELD_DIVERGENCIA).AsInteger));

          LItensValidacao.Next;

        End;

      End;

      Result := Result And fApagaDigitacaoLotes;

      if (Result) And (not FAuditFaturamento.fValidouTodas(FCodErroAuditoria)) then
      begin
        FAuditoriaGravacaoFaturamentoMSGErro := 'ATENÇÃO! ' + fRetornaErrosAuditoria(FCodErroAuditoria);
        Result := False;
      end;

      FProgre := nil;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fTransferirParaEstoqueExterno_MovimentarQuantidadeSeparada]');
      End;
    End;

  Finally
    FreeAndNil(LNotaRemessaVsPedidoVenda);
  End;

end;

function TBaixaLotesWMS.GetLoteDestino(const ACodIte, ALotePD: String): String;
Var
  LNumLot: String;
begin
  If Not Self.FFulfillment.CodigoDoEstoqueExterno.IsEmpty And TCadLot.ExisteLoteEstoqueExterno(ACodIte, Self.FFulfillment.CodigoDoEstoqueExterno, LNumLot) Then
    Result := LNumLot
  else if FValidaLoteDefPD and fLoteDefinidoEmissaoPDUtilizandoLocTransitoriaVagao(ACodIte) then
    Result := ALotePD
  Else
    Result := 'A DEFINIR';
end;

function TBaixaLotesWMS.GetTemLotes: Boolean;
begin
  Result := FLotes.Active And Not FLotes.IsEmpty;
end;

function TBaixaLotesWMS.fGravaMovDetTransf_Interna(AQuantidade   : Double = 0.00;
                                                   AMovimentacao : TMovimentacao = mvmIgual;
                                                   ACodigoDoItem : String = '';
                                                   ANumeroDoLote : String = '') : Boolean;
  var
    qryCadIte                     : TUniQuery;
    LFulRegrasMovEstoque          : FulfillmentRegrasMovimentacaoEstoque;
    LDeveMovimentarEstoqueExterno : Boolean;
    LDeveMovimentarEstoqueFisico  : Boolean;
    LDivergenciaFulfillment       : String;

    LCodigoDoItem : String;
    LQuantidade   : Double;
    LNumeroDoLote : String;
    LLotePD       : String;
begin

  qryCadIte := fCriaQuery(Self);

  Try

    qryCadIte.SQL.Text := fSQLItem;

    qryCadIte.Close;
    qryCadIte.ParamByName('CODITE').AsString := FLotes.FieldByName('CODITE').AsString;
    qryCadIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadIte.Open;

    strAutIncDet := '';
    LFulRegrasMovEstoque.Limpar;

    If Self.FFulfillment.EhOperacaoFulfillment Then
      LFulRegrasMovEstoque := FulfillmentMovimentacaoEstoque(strClaFis, '', Self.FFulfillment.SiglaHubMarketPlace, IIF(Self.FFulfillment.EhOperacaoDeRemessa, opBaixaLotesWMSRemessa, opBaixaLotesWMS));

    LDeveMovimentarEstoqueFisico  := IIF(AMovimentacao = mvmAMenos, False, fDeveMovimentarEstoqueFisico(LFulRegrasMovEstoque));
    LDeveMovimentarEstoqueExterno := IIF(AMovimentacao = mvmAMenos, False, fDeveMovimentarEstoqueExterno(LFulRegrasMovEstoque));
    LDivergenciaFulfillment       := IIF(AMovimentacao <> mvmIgual, IIF(AMovimentacao = mvmAMais, '+', '-'), EmptyStr);

    LQuantidade   := IIF((AQuantidade > 0),         AQuantidade,   FLotes.FieldByName('QTDITE').AsFloat);
    LCodigoDoItem := IIF(Not ACodigoDoItem.IsEmpty, ACodigoDoItem, FLotes.FieldByName('CODITE').AsString);
    LNumeroDoLote := IIF(Not ANumeroDoLote.IsEmpty, ANumeroDoLote, FLotes.FieldByName('NUMLOT').AsString);
    LLotePD       := IIF(Not ANumeroDoLote.IsEmpty, ANumeroDoLote, FLotes.FieldByName('LOTEPD').AsString);

    Result := fGravaMovDet(strAutIncDet,                                                // Retorna Auto-Incremento por Referencia
                           strAutInc,                                                   // Sequencial do Arquivo Geral
                           FNumDoc,                                                     // Numero Documento
                           FEspDoc,                                                     // Espécie
                           VS_strCodEmp,                                                // Empresa
                           LCodigoDoItem,                                               // Cód. Item
                           FCodOpe,                                                     // Vendedor
                           '',                                                          // Código Diversos
                           qryCadIte.FieldByName('ITE_CODMAR').AsString,                // Código da Marca
                           '',                                                          // Fornecedor
                           FCodCli,                                                     // Cliente
                           dtaDtaEnt,                                                   // Data da Entrada
                           Time,                                                        // Hora da Entrada
                           VS_Date,                                                     // Data do Documento
                           '01000',                                                     // Condição de Pagamento
                           'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                           '',                                                          // Estado do Fornecedor
                           qryCadIte.FieldByName('ITE_DESITE').AsString,                // Descrição do Item
                           qryCadIte.FieldByName('ITE_REFERE').AsString,                // Referência do Item
                           qryCadIte.FieldByName('ITE_CODUNI').AsString,                // Cód. Unidade
                           qryCadIte.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                           LQuantidade,                                                 // Quantidade do Item
                           qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                 // Valor Unitario
                           qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                 // Valor Unitário Original
                           qryCadIte.FieldByName('ITE_PRECUS').AsFloat,                 // Valor Unitário Original Sem Juros
                           RoundTo(FLotes.FieldByName('QTDITE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),  // Total do Item
                           RoundTo(FLotes.FieldByName('QTDITE').AsFloat * qryCadIte.FieldByName('ITE_PRECUS').AsFloat, -2),  // Valor Contábil do Item
                           0.0,                                                         // Valor Total de Custo
                           0.0,                                                         // Valor Total Medio
                           0.0,                                                         // % Desconto do Item
                           0.0,                                                         // Valor do Frete
                           0.0,                                                         // Valor do Desconto Especial
                           '',                                                          // Código do Representante
                           '',                                                          // Código do Vendedor 2
                           0.0,                                                         // Percentual de Comissão do Vendedor
                           0.0,                                                         // Total de Comissão do Vendedor
                           0.0,                                                         // Total de Comissão do Vendedor 2
                           strClaFis,                                                   // Classificação Fiscal
                           '',                                                          // Código Fiscal
                           0.0,                                                         // Valor IPI
                           0.0,                                                         // Aliquota IPI
                           0.0,                                                         // Base IPI
                           0.0,                                                         // Valor de ICMS
                           0.0,                                                         // Aliquota de ICMS
                           0.0,                                                         // Base de ICMS
                           0.0,                                                         // Valor de Substituição
                           0.0,                                                         // Aliquota de Substituição
                           0.0,                                                         // Base de Substituição
                           0.0,                                                         // Total de Peso
                           0.0,                                                         // Percentual de Base de ICMS
                           0.0,                                                         // Percentual de Redução de Base
                           True,                                                        // Indica se ja esta Faturado
                           FEspFat,                                                     // Tipo de Faturamento
                           FDocFat,                                                     // Numero de Faturamento
                           FEmpFat,                                                     // Empresa dd Faturamento
                           VS_Date,                                                     // Data de Faturamento
                           '',                                                          // Vendedor do Faturamento
                           '',                                                          // Condição de Pagamento do Faturamento
                           0.0,                                                         // Valor do Faturamento
                           'NOR',                                                       // Identificação Produto ( Normal / Outros )
                           qryCadIte.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
                           '',                                                          // Série
                           0.0,                                                         // Valor de Despesa Acessória
                           'N',                                                         // Nota Especial
                           '',                                                          // Documento da Devolução
                           '',                                                          // Espécie da Devolução
                           '',                                                          // Empresa da Devolução
                           '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                           '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                           '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                           '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                           0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                           0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                           '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                           0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                           0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                           0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                           '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                           FCodOpe,                                                     // Código do Digitador
                           '',                                                          // Codigo da Condição
                           '',                                                          // Forma de Pagamento
                           '',                                                          // Item da Embalagem
                           '',                                                          // Grupo do Item da Embalagem
                           0,                                                           // Quarto da Lazzumiz
                           'N',                                                         // É item em promoção?
                           '',                                                          // Tipo de Tinta
                           0.0,                                                         // Quantidade de Pulsos
                           '',                                                          // Número do pedido de compras
                           '',                                                          // Origem do documento
                           '',                                                          // Pedido de Venda - Número
                           '',                                                          // Pedido de Venda - Espécie
                           '',                                                          // Pedido de Venda - Empresa
                           0,                                                           // Pedido de Venda - Sequencial
                           '',                                                          // Ordem de Produção
                           '',                                                          // Descrição para Nota Fiscal Especial
                           FCliFat,                                                     // Cliente de Faturamento
                           0,
                           0,
                           0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                           '',
                           '',
                           False,
                           LDeveMovimentarEstoqueFisico.ToFilKar, // blnFilKar
                           '',                                    // Especie da Entrega Fututa
                           '',                                    // Documento da Entrega Fututa
                           '',
                           '',                                    // Empresa da Entrega Fututa
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0,
                           'N',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           IIF(strClaFis = STR_CLASAI, LNumeroDoLote, GetLoteDestino(LCodigoDoItem, LLotePD)), //strNumLot
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           IIF(strClaFis = STR_CLASAI, GetLoteDestino(LCodigoDoItem, LLotePD), LNumeroDoLote), //strLot_TA
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'P',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           '',
                           'N',
                           'N',
                           0,
                           0,
                           0,
                           '',
                           'N',
                           0,
                           '',
                           0,
                           'N',
                           '',
                           'NOR',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           'N',
                           '',
                           '',
                           0,
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           'N',
                           '',
                           'N',
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           False,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           IIF(LDeveMovimentarEstoqueExterno, 'S', ''),
                           IIF(LDeveMovimentarEstoqueExterno, Self.FFulfillment.CodigoDoEstoqueExterno, ''),
                           0,
                           0,
                           '',
                           '',
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           False,
                           '',
                           '',
                           '',
                           '',
                           False,
                           '',
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           False,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           'N',
                           '',
                           '',
                           '',
                           0,
                           0,
                           Self.FFulfillment.EhOperacaoFulfillment,               //blnFulfillmentModoRobo: Boolean = False;
                           LDeveMovimentarEstoqueExterno.ToFilFul,                //blnFilFul: Boolean = True;
                           False,                                                 //blnBaiDev: Boolean = False;
                           '',                                                    //strAutEnt: String = '';
                           0,                                                     //dtaDtaCmp: TDateTime = 0;
                           Self.FFulfillment.SiglaHubMarketPlace,                 //strFullHubMkp: String = '';
                           0,                                                                         //fltOutValPD: Double = 0;
                           IIF(LDeveMovimentarEstoqueExterno, LFulRegrasMovEstoque.EntradaSaida, ''), //strFilFul_EntSai: String = '';
                           '',                        //strIncOri: String = '';
                           '',                        //strTckQbt: String = '';
                           'N',                       //strEntTri: String = 'N';
                           LDivergenciaFulfillment);  //strFulDif: String = '';

    If Result And LDeveMovimentarEstoqueFisico Then
    Begin
      Result := FCadLot.fAtualizaEstoqueLote(LCodigoDoItem,
                                             IIF(strClaFis = STR_CLASAI, 'S', 'E'),
                                             IIF(strClaFis = STR_CLASAI, LNumeroDoLote, GetLoteDestino(LCodigoDoItem, LLotePD)),
                                             LQuantidade);
    End;

  Finally
    FreeAndNil(qryCadIte);
  End;

end;

procedure TBaixaLotesWMS.pLimparLotes;
begin
  FLotes.EmptyDataSet;
end;

function TBaixaLotesWMS.fCarregaLotesDigitados(strAutIncFatDor: String; strAutIncMovDet: String=''): Double;
  Var
    qryLotDor: TUniQuery;
    intQtdDec: Integer;
    fltQtdIte, fltQtdExp: Double;

  function ConsiderarQuantidadeSeparada : Boolean;
  begin

    Result := False;

    If (fCfgSis('CPQTCF') <> COMPARAR_QTDSEP_COLETOR) Then
      Exit;

    If Self.FFulfillment.EhOperacaoFulfillment Then
      Exit(True);

    If (qryLotDor.FieldByName('TOT_QTDSEP').AsFloat > 0.0) And
       (fFormataFloat(qryLotDor.FieldByName('TOT_QTDSEP').AsFloat, intQtdDec) = fFormataFloat(fltQtdExp, intQtdDec)) Then
      Exit(True);

  end;

begin
  Result := 0;

  intQtdDec := fCfgSis('DECQTD', varInteger);

  qryLotDor := fCriaQuery;

  Try

    qryLotDor.Close;
    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Add('SELECT ');
    qryLotDor.SQL.Add('  LOTDOR.*,   ');
    qryLotDor.SQL.Add('  LOT_LOCFIS, ');
    qryLotDor.SQL.Add('  FDO_CODITE, ');
    qryLotDor.SQL.Add('  FDO_QTDEXP, ');
    qryLotDor.SQL.Add('  (SELECT SUM(IFNULL(LD.LDO_QTDSEP,0)) FROM LOTDOR LD WHERE LD.LDO_SEQFDO = FATDOR.AUTOINCREM) AS TOT_QTDSEP, ');
    qryLotDor.SQL.Add('  FDO_NUMLOT, ');
    qryLotDor.SQL.Add('  (FDO_QTDITE - FDO_QTDBAI) AS QTDPEN, ');
    qryLotDor.SQL.Add('  LDO_QTDSEP  ');
    qryLotDor.SQL.Add('FROM ');
    qryLotDor.SQL.Add('  LOTDOR ');
    qryLotDor.SQL.Add('  INNER JOIN FATDOR ON ');
    qryLotDor.SQL.Add('    LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryLotDor.SQL.Add('  INNER JOIN CADLOT ON ');
    qryLotDor.SQL.Add('    LOT_CODITE = FDO_CODITE AND ');
    qryLotDor.SQL.Add('    LOT_NUMLOT = LDO_NUMLOT AND ');
    qryLotDor.SQL.Add('    LOT_CODEMP = :CODEMP ');
    qryLotDor.SQL.Add('  INNER JOIN EXTDOR ON ');
    qryLotDor.SQL.Add('    FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ');
    qryLotDor.SQL.Add('WHERE ');
    qryLotDor.SQL.Add('  LDO_SEQFDO = :SEQFDO ');

    If (fCfgSis('TIPEXP') = TIPEXP_POR_ROMANEIO_E_PEDIDO_NAO_SERA_FATURADO) And fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
      qryLotDor.SQL.Add('  AND EXTDOR.FDO_INFLOT = "N" ');

    qryLotDor.ParamByName('SEQFDO').AsString := strAutIncFatDor;
    qryLotDor.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryLotDor.Open;

    qryLotDor.First;
    While Not qryLotDor.Eof Do
    Begin
      fltQtdExp := qryLotDor.FieldByName('FDO_QTDEXP').AsFloat;

      If fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO Then
      Begin
        If Assigned(cdsExpIte) And cdsExpIte.Active And cdsExpIte.Locate('AUTOINCREM', strAutIncFatDor, []) Then
          fltQtdExp := cdsExpIte.FieldByName('QTDEXP').AsFloat;
      End;

      fltQtdIte := IIF(ConsiderarQuantidadeSeparada, qryLotDor.FieldByName('LDO_QTDSEP').AsFloat, qryLotDor.FieldByName('LDO_QTDITE').AsFloat);

      Result := Result + fltQtdIte;

      If fltQtdIte > 0 Then
      Begin
        FLotes.Append;
        FLotes.FieldByName('AUTINC').AsString := qryLotDor.FieldByName('LDO_SEQFDO').AsString;
        FLotes.FieldByName('CODITE').AsString := qryLotDor.FieldByName('FDO_CODITE').AsString;
        FLotes.FieldByName('NUMLOT').AsString := qryLotDor.FieldByName('LDO_NUMLOT').AsString;
        FLotes.FieldByName('QTDITE').AsFloat  := fltQtdIte;
        FLotes.FieldByName('LOCFIS').AsString := qryLotDor.FieldByName('LOT_LOCFIS').AsString;
        FLotes.FieldByName('AUTGRV').AsString := strAutIncMovDet;
        FLotes.FieldByName('LOTEPD').AsString := qryLotDor.FieldByName('FDO_NUMLOT').AsString;
        FLotes.FieldByName('SEQLDO').AsString := qryLotDor.FieldByName('AUTOINCREM').AsString;
        FLotes.FieldByName('QTDPEN').AsFloat  := qryLotDor.FieldByName('QTDPEN').AsFloat;
        FLotes.FieldByName('QTDSEP').AsFloat  := qryLotDor.FieldByName('LDO_QTDSEP').AsFloat;
        FLotes.Post;
      End;

      qryLotDor.Next;

    End;

  Finally
    FreeAndNil(qryLotDor);
  End;

end;

function TBaixaLotesWMS.fDeveMovimentarEstoqueExterno(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
begin
  Result := False;

  If Not Self.FFulfillment.EhOperacaoFulfillment Then
    Exit;

  Result := (AFulRegrasMovEstoque.Operacao in ([opBaixaLotesWMS, opBaixaLotesWMSRemessa])) And
            (AFulRegrasMovEstoque.MovimentaEstoqueExterno);
end;

function TBaixaLotesWMS.fDeveMovimentarEstoqueFisico(AFulRegrasMovEstoque: FulfillmentRegrasMovimentacaoEstoque): Boolean;
begin
  Result := True;

  If Not Self.FFulfillment.EhOperacaoFulfillment Then
    Exit;

  Result := (AFulRegrasMovEstoque.Operacao in ([opBaixaLotesWMS, opBaixaLotesWMSRemessa])) And
            (AFulRegrasMovEstoque.MovimentaEstoqueFisico);
end;

destructor TBaixaLotesWMS.Destroy;
begin

  If Assigned(FFulfillment) Then
    FreeAndNil(FFulfillment);

  inherited Destroy;
end;

function TBaixaLotesWMS.fApagaDigitacaoLotes(const ABaixaEstoque: Boolean = False): Boolean;
begin
  If (FFulfillment.EhOperacaoFulfillment) And (ModeloDeMovimentacaoDeSaldo = fmmQuantidadeSeparada) Then
    Exit(fApagaTodosOsLotesDoPedido);

  if ABaixaEstoque and fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO then
    Exit(fAtualizaLotDorLotesTransitorios);

  Result := fApagaLotesDigitados;
end;

function TBaixaLotesWMS.fApagaDigitacaoLotes_RemoverLocalizacaoFisicaLotes(pgbProgresso: TCxProgressBar): Boolean;
begin

  Try

    If Assigned(pgbProgresso) Then
    Begin
      FProgre := pgbProgresso;
      FProgre.Position := 0;
      FProgre.properties.Max := 2 * FLotes.RecordCount + 1;
    End;

    Result := fApagaDigitacaoLotes(True);

    FProgre := nil;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fApagaDigitacaoLotes_RemoverLocalizacaoFisicaLotes]');
    End;
  End;

end;

Function TBaixaLotesWMS.fGravaMovDetTransf: Boolean;
Begin

  Result := False;

  FLotes.First;

  While (Not FLotes.Eof) Do
  Begin

    Result := fGravaMovDetTransf_Interna;

    If Not Result Then
      Break;

    If Assigned(FProgre) Then
      FProgre.Position := FProgre.Position + 1;

    pProcessMessages;
    FLotes.Next;

  End;

End;

function TBaixaLotesWMS.fBaixarEstoqueLotes(pgbProgresso: TCxProgressBar = nil): Boolean;
begin
  Try
    FCodErroAuditoria := '';
    dtaDtaEnt    := VS_Date;

    If Assigned(pgbProgresso) Then
    Begin
      FProgre := pgbProgresso;
      FProgre.Position := 0;
      FProgre.properties.Max := 2 * FLotes.RecordCount + 1;
    End;

    FEspDoc := 'TL';
    FNumDoc := fRetSequencial_TL;

    FAuditFaturamento.Limpar;

    Result := fGravaMovGerTransf;

    strClaFis := STR_CLASAI;
    Result := Result And fGravaMovDetTransf;

    strClaFis := STR_CLAENT;
    Result := Result And fGravaMovDetTransf;

    Result := Result And fApagaDigitacaoLotes(True);

    if (Result) And (not FAuditFaturamento.fValidouTodas(FCodErroAuditoria)) then
    begin
      FAuditoriaGravacaoFaturamentoMSGErro := 'ATENÇÃO! ' + fRetornaErrosAuditoria(FCodErroAuditoria);
      Result := False;
    end;

    FProgre := nil;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fBaixarEstoqueLotes]');
    End;
  End;
End;

end.
