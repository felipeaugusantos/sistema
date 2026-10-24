unit Fulfillment.Classes.AjusteDeEstoque;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples, UniClientDataSet,
{$ENDIF}
  Uni, Data.DB, System.Classes, System.StrUtils,
  System.SysUtils, untTypesSistema, untCustoItemFaturamento,
  untPesqAux, untCadIte,

  Fulfillment.Funcoes,
  Fulfillment.Classes.Parametros,
  Fulfillment.RegrasMovimentacaoEstoque;

type

  TItemAjuste = class
  private
    FCodIte : String;
    FDesIte : String;
    FRefere : String;
    FCodMar : String;
    FEntSai : String;
    FCodUni : String;
    FNumLot : String;
    FCodAca : String;
    FEmpAca : String;
    FCusLot : Double;
    FQtdPla : Double;
    FQtdIte : Double;
    FUnitar : Double;
    FTotIte : Double;
  public

    constructor New(); reintroduce;

    procedure setCodIte(AValue : String);
    procedure setDesIte(AValue : String);
    procedure setRefere(AValue : String);
    procedure setCodMar(AValue : String);
    procedure setEntSai(AValue : String);
    procedure setCodUni(AValue : String);
    procedure setNumLot(AValue : String);
    procedure setCodAca(AValue : String);
    procedure setEmpAca(AValue : String);
    procedure setCusLot(AValue : Double);
    procedure setQtdPla(AValue : Double);
    procedure setQtdIte(AValue : Double);
    procedure setUnitar(AValue : Double);
    procedure setTotIte(AValue : Double);

    function getCodIte : String;
    function getDesIte : String;
    function getRefere : String;
    function getCodMar : String;
    function getEntSai : String;
    function getCodUni : String;
    function getNumLot : String;
    function getCodAca : String;
    function getEmpAca : String;
    function getCusLot : Double;
    function getQtdPla : Double;
    function getQtdIte : Double;
    function getUnitar : Double;
    function getTotIte : Double;

    procedure Limpar;

  end;

  TAjusteDeEstoque = class
  private

    FConOpe : TUniQuery;
    FConCit : TUniQuery;
    FConIte : TUniQuery;
    FPreAju : String;
    FImpAju : String;

    FItensAjuste          : TUniClientDataSet;
    FCustoItemFaturamento : ICustoItemFaturamento;
    FCustoItem            : TRecResulCusto;

    procedure CriarTemporaria;
    procedure CarregaValoresCusto(ACodIte, ACodEmp, ATabPre : String);
    procedure AtribuiTabelas;
    procedure AddInterna(const AItem : TItemAjuste);

    function HabilitouCustoPorTabelaDePreco : Boolean;
    function GetSqlIteGer : String;
    function RetornaTabelaCusto : String;
    function TabPrecoImp : String;
    function TabPreco: String;
    function EhItemEstruturaBaixandoSaldoDosSubItens(ACodIte : String) : Boolean;
    function RetornaDadosItem(ACodIte : String) : TUniQuery;
    function RetornaPrecoUnitario(ACodIte : String) : Double;

  private

    FCodigoDoCliente    : String;
    FNumeroDoDocumento  : String;
    FEspecieDoDocumento : String;
    FCodigoDoVendedor   : String;
    FFulfillment        : TFulfillment;

  public

    constructor New(); Reintroduce;
    destructor Destroy(); Override;

    procedure Add(const AItem : TItemAjuste);

    function Gravar : Boolean;

    property CodigoDoCliente    : String       read FCodigoDoCliente    write FCodigoDoCliente;
    property NumeroDoDocumento  : String       read FNumeroDoDocumento  write FNumeroDoDocumento;
    property EspecieDoDocumento : String       read FEspecieDoDocumento write FEspecieDoDocumento;
    property CodigoDoVendedor   : String       read FCodigoDoVendedor   write FCodigoDoVendedor;
    property Fulfillment        : TFulfillment read FFulfillment        write FFulfillment;

  end;

implementation

  Uses
    untMovGer, untCadLote;

{ TAjusteDeEstoque }

procedure TAjusteDeEstoque.Add(const AItem : TItemAjuste);
var
  LEstrutura  : TUniQuery;
  LDadosItem  : TUniQuery;
  LItemAjuste : TItemAjuste;
  LUnitar     : Double;

  function RetornaLote(ACodIte : String) : String;
  begin

    Result := EmptyStr;

    If (Fulfillment.CodigoDoEstoqueExterno.IsEmpty) Then
      Exit;

    If fUsaRotinaWMS Or (TCadLot.ProdutoTemLote(ACodIte)) Then
      Result := TCadLot.GeraNumeroLoteEstoqueExterno(Fulfillment.CodigoDoEstoqueExterno);

  end;

begin

  If Not Assigned(AItem) Then
    Exit;

  If Not EhItemEstruturaBaixandoSaldoDosSubItens(AItem.getCodIte) Then
  Begin
    AddInterna(AItem);
    Exit;
  End;

  LEstrutura  := RetornaEstrutura(AItem.getCodIte);
  LDadosItem  := RetornaDadosItem(AItem.getCodIte);
  LItemAjuste := TItemAjuste.New;

  Try

    LEstrutura.First;
    While Not LEstrutura.Eof Do
    Begin

      LUnitar := RetornaPrecoUnitario(AItem.getCodIte);

      LItemAjuste.Limpar;
      LItemAjuste.setCodIte(LEstrutura.FieldByName('DMT_ITESUB').AsString);
      LItemAjuste.setDesIte(LDadosItem.FieldByName('ITE_DESITE').AsString);
      LItemAjuste.setRefere(LDadosItem.FieldByName('ITE_REFERE').AsString);
      LItemAjuste.setCodMar(LDadosItem.FieldByName('ITE_CODMAR').AsString);
      LItemAjuste.setEntSai(AItem.getEntSai);
      LItemAjuste.setCodUni(LDadosItem.FieldByName('ITE_CODUNI').AsString);
      LItemAjuste.setNumLot(RetornaLote(LEstrutura.FieldByName('DMT_ITESUB').AsString));
      LItemAjuste.setCodAca(EmptyStr);
      LItemAjuste.setEmpAca(EmptyStr);
      LItemAjuste.setCusLot(0.00);
      LItemAjuste.setQtdPla(0.00);
      LItemAjuste.setQtdIte(LEstrutura.FieldByName('DMT_QTDITE').AsFloat * AItem.getQtdIte);
      LItemAjuste.setUnitar(LUnitar);
      LItemAjuste.setTotIte(LUnitar * LItemAjuste.getQtdIte);

      AddInterna(LItemAjuste);
      LEstrutura.Next;

    End;

  Finally
    FreeAndNil(LItemAjuste);
    FreeAndNil(LDadosItem);
  End;

end;

procedure TAjusteDeEstoque.AddInterna(const AItem: TItemAjuste);
begin
  FItensAjuste.Insert;
  FItensAjuste.FieldByName('ITE_CODITE').AsString := AItem.getCodIte;
  FItensAjuste.FieldByName('ITE_DESITE').AsString := AItem.getDesIte;
  FItensAjuste.FieldByName('ITE_REFERE').AsString := AItem.getRefere;
  FItensAjuste.FieldByName('ITE_CODMAR').AsString := AItem.getCodMar;
  FItensAjuste.FieldByName('ITE_ENTSAI').AsString := AItem.getEntSai;
  FItensAjuste.FieldByName('ITE_CODUNI').AsString := AItem.getCodUni;
  FItensAjuste.FieldByName('ITE_NUMLOT').AsString := AItem.getNumLot;
  FItensAjuste.FieldByName('ITE_CODACA').AsString := AItem.getCodAca;
  FItensAjuste.FieldByName('ITE_EMPACA').AsString := AItem.getEmpAca;
  FItensAjuste.FieldByName('ITE_CUSLOT').AsFloat  := AItem.getCusLot;
  FItensAjuste.FieldByName('ITE_QTDPLA').AsFloat  := AItem.getQtdPla;
  FItensAjuste.FieldByName('ITE_QTDITE').AsFloat  := AItem.getQtdIte;
  FItensAjuste.FieldByName('ITE_UNITAR').AsFloat  := AItem.getUnitar;
  FItensAjuste.FieldByName('ITE_TOTITE').AsFloat  := AItem.getTotIte;
  FItensAjuste.Post;
end;

procedure TAjusteDeEstoque.AtribuiTabelas;
begin
  FConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', nil);
  FConCit := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', nil);
  FConIte := fCriaQuery(nil);
end;

procedure TAjusteDeEstoque.CarregaValoresCusto(ACodIte, ACodEmp, ATabPre : String);
begin

  FillChar(FCustoItem, SizeOf(FCustoItem), #0);

  If Not Assigned(FCustoItemFaturamento) Then
    Exit;

  FCustoItem := FCustoItemFaturamento.Get(ACodIte, ACodEmp, ATabPre);

end;

procedure TAjusteDeEstoque.CriarTemporaria;
begin

  FItensAjuste := TUniClientDataSet.Create(nil);

  FItensAjuste.AggregatesActive := True;
  FItensAjuste.FieldDefs.Add('ITE_CODITE', ftString, fTamCodIte);

  FItensAjuste.FieldDefs.Add('ITE_DESITE', ftString, 057);
  FItensAjuste.FieldDefs.Add('ITE_NUMLOT', ftString, 030);
  FItensAjuste.FieldDefs.Add('ITE_REFERE', ftString, 016);
  FItensAjuste.FieldDefs.Add('ITE_CODMAR', ftString, 006);
  FItensAjuste.FieldDefs.Add('ITE_ENTSAI', ftString, 001);
  FItensAjuste.FieldDefs.Add('ITE_CODUNI', ftString, 002);
  FItensAjuste.FieldDefs.Add('ITE_CODACA', ftString, 006);
  FItensAjuste.FieldDefs.Add('ITE_EMPACA', ftString, 003);

  FItensAjuste.FieldDefs.Add('ITE_QTDITE', ftFloat);
  FItensAjuste.FieldDefs.Add('ITE_UNITAR', ftFloat);
  FItensAjuste.FieldDefs.Add('ITE_CUSLOT', ftFloat);
  FItensAjuste.FieldDefs.Add('ITE_TOTITE', ftFloat);

  FItensAjuste.FieldDefs.Add('LOT_MEDB_L', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_MEDB_A', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_MEDL_L', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_MEDL_A', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_ESPESS', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_NCHAPA', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_PRVMAP', ftFloat);
  FItensAjuste.FieldDefs.Add('LOT_PRVMAT', ftFloat);
  FItensAjuste.FieldDefs.Add('ITE_QTDPLA', ftFloat);

  FItensAjuste.FieldDefs.Add('AUTOINCREM', ftAutoInc);

  With TAggregateField.Create(nil) Do
  Begin
    FieldName     := 'TOT_TOTITE';
    DataSet       := FItensAjuste;
    DisplayFormat := '#,##0.00';
    Alignment     := taRightJustify;
    Expression    := 'SUM(ITE_TOTITE)';
    Active        := True;
  End;

  FItensAjuste.CreateDataSet;
  FItensAjuste.Open;

  (FItensAjuste.FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FItensAjuste.FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (FItensAjuste.FieldByName('ITE_QTDPLA') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
  (FItensAjuste.FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

  pSetaClient(FItensAjuste);

end;

destructor TAjusteDeEstoque.Destroy;
begin

  inherited;

  If Assigned(FConOpe) Then
    FreeAndNil(FConOpe);

  If Assigned(FConCit) Then
    FreeAndNil(FConCit);

  If Assigned(FConIte) Then
    FreeAndNil(FConIte);

end;

function TAjusteDeEstoque.EhItemEstruturaBaixandoSaldoDosSubItens(ACodIte: String): Boolean;
begin

  If Not fItemEstrutura(ACodIte) Then
    Exit(False);

  Result := ((fCfgSis('BXSBIT') = '2') Or (fCfgSis('BXSBIT') = '3'));

end;

function TAjusteDeEstoque.GetSqlIteGer: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  G.*, C.ITE_CNV_ML ';
  Result := Result + 'FROM ';
  Result := Result + '  ITEGER G ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  G.ITE_CODITE = :CODITE AND ';
  Result := Result + '  G.ITE_CODEMP = :CODEMP ';
end;

function TAjusteDeEstoque.Gravar : Boolean;
  Var
    LAutInc   : String;
    LDtaEnt   : TDateTime;
    LHraEnt   : TTime;
    LClaFis   : String;
    LAutIncTmp: String;
    LServicos : TDadosServicos;
    LCnv_Ml   : Double;
    LCliEst   : String;
    LDuplic   : TarrDuplicata;
    LPreCus   : Double;

    LNumDocAJ : String;
    LCodOpe   : String;
    LGravou   : Boolean;
    FConIte   : TUniQuery;
    LNumLot   : String;

    LFulfillmentRegrasMovimentacaoEstoque : FulfillmentRegrasMovimentacaoEstoque;

    function EntradaSaida : String;
    begin

      If fEmptyStr(FItensAjuste.FieldByName('ITE_ENTSAI').AsString) Then
        Result := LFulfillmentRegrasMovimentacaoEstoque.EntradaSaida
      Else
        Result := FItensAjuste.FieldByName('ITE_ENTSAI').AsString;

    end;

begin

  Result := False;

  if (FItensAjuste.IsEmpty) then
    Exit;

  FItensAjuste.First;

  LDtaEnt := Date;
  LHraEnt := Time;
  LCliEst := fRetEstadoCliente(FCodigoDoCliente);

  FConIte := fCriaQuery(nil);

  fStartTransaction;

  Try

    LNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);
    LCodOpe   := strLoginUsuarioLogado;

    FillChar(LDuplic, Sizeof(LDuplic) , #0);

    LGravou := fGravaMovGer(LAutInc,                                                      // Auto Incremento (Retorno)
                           LNumDocAJ,                                                     // Numero Documento
                           'AJ',                                                          // Espécie
                           VS_strCodEmp,                                                  // Empresa
                           '',                                                            // Transportadora
                           FCodigoDoVendedor,                                             // Vendedor
                           '',                                                            // Fornecedor
                           FCodigoDoCliente,                                              // Cliente
                           'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                           LDtaEnt,                                                       // Data da Entrada
                           LHraEnt,                                                       // Hora da Entrada
                           VS_Date,                                                       // Data do Documento
                           '01000',                                                       // Condição de Pagamento
                           LCliEst,                                                       // Estado do Cliente / Fornecedor
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
                           Abs(FItensAjuste.FieldByName('TOT_TOTITE').AsString.ToDouble()),           // Valor Contábil
                           Abs(FItensAjuste.FieldByName('TOT_TOTITE').AsString.ToDouble()),           // Total dos Itens
                           IIF(HabilitouCustoPorTabelaDePreco, Abs(FItensAjuste.FieldByName('TOT_TOTITE').AsString.ToDouble()), 0.0), // Total de Custo
                           0.0,                                                           // Total Médio
                           '',                                                            // Tipo de Frete
                           0.0,                                                           // Valor do Frete
                           0.0,                                                           // Peso Bruto
                           0.0,                                                           // Peso Liquido
                           0.0,                                                           // Volume
                           '',                                                            // Especie
                           '',                                                            // Marca
                           'AJUSTE GERADO AUTOMATICAMENTE PELA IMPORTAÇÃO DO FULL - ESTFUL > FUL_GERA_AJ = S', // Mensagem 1
                           '',                                                            // Mensagem 2
                           '',                                                            // Mensagem 3
                           '',                                                            // Mensagem 4
                           '',                                                            // Mensagem 5
                           True,                                                          // Indica se Faturado ou nao
                           FEspecieDoDocumento,                                           // Tipo de Faturamento
                           FNumeroDoDocumento,                                            // Numero de Faturamento
                           VS_strCodEmp,                                                  // Empresa dd Faturamento
                           VS_Date,                                                       // Data de Faturamento
                           FCodigoDoVendedor,                                             // Vendedor do Faturamento
                           '01000',                                                       // Condição de Pagamento do Faturamento
                           False,                                                         // Devolução Especial
                           Abs(FItensAjuste.FieldByName('TOT_TOTITE').AsString.ToDouble()), // Valor do Faturamento
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
                           LDuplic,
                           '',                                                            // Série
                           'N',                                                           // Nota Especial
                           '9999',                                                        // Classificação Fiscal 1
                           '',                                                            // Classificação Fiscal 2
                           '',                                                            // Classificação Fiscal 3
                           '',                                                            // Natureza da Operação
                           0.0,                                                           // Percentual de Desconto
                           LCodOpe,                                                       // Codigo do Digitador
                           '',                                                            // Codigo da Condição
                           '',                                                            // Forma de Pagamento
                           0.0,                                                           // Fator para meia nota
                           LServicos,
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
                           '',                                                            // Cliente de Faturamento
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
                           '',                                                            //
                           True,                                                          // Imprime Duplicatas na NF-e
                           0,                                                             //  fltValCre
                           0,                                                             //  dtadtlBex
                           '',                                                            //  strEmlCon
                           0,                                                             //  dtaDtESNf
                           0,                                                             //  tmrHrESNf
                           Nil,                                                           //  objFinanc
                           '',                                                            //  strDocCon
                           '',                                                            //  strCodObr
                           '',                                                            //  strCodArt
                           'N',                                                           //  strPermut
                           '',                                                            //  strRetIss
                           'AF',                                                          //  strOpcDoc
                           0,                                                             //  fltFreSug
                           '',                                                            //  strNumAde
                           0,                                                             //  fltBasAnt
                           0,                                                             //  fltValAnt
                           '',                                                            //  strNaoAtu
                           '',                                                            //  strEntUrg
                           '',                                                            //  strMenExp
                           '',                                                            //  strMenEx2
                           '',                                                            //  strMenEx3
                           '',                                                            //  strMenEx4
                           0,                                                             //  fltDupRec
                           0,                                                             //  fltValAdt
                           0,                                                             //  fltDeDVCf
                           '',                                                            //  strPlaVei
                           '',                                                            //  strKm_Vei
                           '',                                                            //  strCliOri
                           '',                                                            //  strCodMot
                           '',                                                            //  strBetone
                           '',                                                            //  strLacre_
                           '',                                                            //  strTipMps
                           '',                                                            //  strAbatim
                           '',                                                            //  strBrita_
                           '',                                                            //  strConBom
                           0,                                                             //  intFckDia
                           0,                                                             //  fltImpPag
                           0,                                                             //  intPrzMed
                           False,                                                         //  blnImpPdv
                           False,                                                         //  blnDTEXREP
                           '',                                                            //  strChvNfeDev
                           '',                                                            //  strOpeSol
                           False,                                                         //  blnEst_Dv
                           '',                                                            //  strNumCOODev
                           '',                                                            //  strNumSerDev
                           '',                                                            //  strNumUSUDev
                           '',                                                            //  strTipDocDev
                           0,                                                             //  fltTotDif
                           nil,                                                           //  objFazenda
                           0,                                                             //  fltFedImp
                           0,                                                             //  fltEstImp
                           0,                                                             //  fltMunImp
                           0,                                                             //  fltTroco_
                           '',                                                            //  strObsNfeFis
                           'N',                                                           //  strVenPre
                           '',                                                            //  strSeqDocOri
                           False,                                                         //  blnConEqu
                           False,                                                         //  blnDescIncond
                           True,                                                          //  blnGraCTP
                           '',                                                            //  strNumera
                           'N',                                                           //  strEdiPes
                           0,                                                             //  fltTaxEnt
                           0,                                                             //  fltVrdIcm
                           0,                                                             //  fltBasVrd
                           0,                                                             //  intNroBox
                           '',                                                            //  strCodEmbarcacao
                           0,                                                             //  fltTotBri
                           '',                                                            //  strTraRdp
                           '',                                                            //  strCliCtt
                           '',                                                            //  strCodMod
                           '',                                                            //  strNumGui
                           '',                                                            //  strHisCom
                           '',                                                            //  strCodPrj
                           '',                                                            //  strNatCfo
                           '',                                                            //  strTpOper
                           '',                                                            //  strCupDes
                          'S',                                                            //  strNotPau
                            0,                                                            //  fltCotMoe
                            0,                                                            //  fltFreMkp
                            0,                                                            //  fltComMkp
                           '',                                                            //  strPlaFat
                          False,                                                          //  blnDevWms
                          False,                                                          //  blnFullFilmentModoRobo
                            0,                                                            //  fltFreCot
                            0,                                                            //  fltFreRat
                          'N',                                                            //  strEntSim
                           '',                                                            //  strSeqDmp
                           '',                                                            //  strEntFutOpc
                            0,                                                            //  fltTotIpiEntFut
                            0,                                                            //  fltTotRetEntFut
                            0,                                                            //  fltTotFcpSTEntFut
                            0,                                                            //  fltICMDes
                            0,                                                            //  fltDesPis
                            '',                                                           //  strOpFaEx
                            '',                                                           //  strDocAba
                            '',                                                           //  strEspAba
                            '',                                                           //  strEmpAba
                            '',                                                           //  strCliAba
                           False,                                                         //  blnColeta
                            '',                                                           //  strNumeroRandomico
                            '',                                                           //  strNumeroDrawback
                            '');                                                          //  finalidade Ajuste

    FConIte.Close;
    FConIte.SQL.Clear;
    FConIte.SQL.Add(GetSqlIteGer);

    LFulfillmentRegrasMovimentacaoEstoque := FulfillmentMovimentacaoEstoque(FFulfillment.ClassificacaoFiscal,
                                                                            FFulfillment.ChaveDeAcesso,
                                                                            FFulfillment.SiglaHubMarketPlace);

    FItensAjuste.First;
    While (Not FItensAjuste.Eof) And (LGravou) Do
    Begin

      LNumLot := FItensAjuste.FieldByName('ITE_NUMLOT').AsString;

      If Not TCadLot.ExisteLoteEstoqueExterno(FItensAjuste.FieldByName('ITE_CODITE').AsString,
                                              FFulfillment.CodigoDoEstoqueExterno, LNumLot) Then
      Begin
        TCadLot.GeraLoteEstoqueExterno(FItensAjuste.FieldByName('ITE_CODITE').AsString,
                                       FFulfillment.CodigoDoEstoqueExterno, LNumLot);
      End;

      LClaFis := IIF(EntradaSaida.Equals('E'), '1999', '5999');

      FConIte.Close;
      FConIte.ParamByName('CODITE').AsString := FItensAjuste.FieldByName('ITE_CODITE').AsString;
      FConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FConIte.Open;

      pPesquisaCadIte(FConCit, FConCit, FItensAjuste.FieldByName('ITE_CODITE').AsString, '', False);

      LPreCus := RetornaPrecoUnitario(FItensAjuste.FieldByName('ITE_CODITE').AsString);
      LCnv_Ml := IIF((FConIte.FieldByName('ITE_CNV_ML').AsFloat > 0), FConIte.FieldByName('ITE_CNV_ML').AsFloat, 1);

      LAutIncTmp := '';

      LGravou := fGravaMovDet(LAutIncTmp,                                                 // Retorna Auto-Incremento por Referencia
                             LAutInc,                                                     // Sequencial do Arquivo Geral
                             LNumDocAJ,                                                   // Numero Documento
                             'AJ',                                                        // Espécie
                             VS_strCodEmp,                                                // Empresa
                             FItensAjuste.FieldByName('ITE_CODITE').AsString,             // Cód. Item
                             FCodigoDoVendedor,                                           // Vendedor
                             '',                                                          // Código Diversos
                             FItensAjuste.FieldByName('ITE_CODMAR').AsString,             // Código da Marca
                             '',                                                          // Fornecedor
                             FCodigoDoCliente,                                            // Cliente
                             LDtaEnt,                                                     // Data da Entrada
                             LHraEnt,                                                     // Hora da Entrada
                             VS_Date,                                                     // Data do Documento
                             '01000',                                                     // Condição de Pagamento
                             'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                             LCliEst,                                                     // Estado do Fornecedor
                             FItensAjuste.FieldByName('ITE_DESITE').AsString,             // Descrição do Item
                             FItensAjuste.FieldByName('ITE_REFERE').AsString,             // Referência do Item
                             FItensAjuste.FieldByName('ITE_CODUNI').AsString,             // Cód. Unidade
                             FConCit.FieldByName('ITE_CODFOR').AsString,                  // Fornecedor Item
                             FItensAjuste.FieldByName('ITE_QTDITE').AsFloat,              // Quantidade do Item
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat,              // Valor Unitario
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat,              // Valor Unitário Original
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat,              // Valor Unitário Original sem juros
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat,    // Total do Item
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat,    // Valor Contábil do Item

                             (IIF(FItensAjuste.FieldByName('ITE_CUSLOT').AsFloat > 0, FItensAjuste.FieldByName('ITE_CUSLOT').AsFloat,
                                  LPreCus) / LCnv_Ml) * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo

                             (FConIte.FieldByName('ITE_PREMED').AsFloat / LCnv_Ml) * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat, // Valor Total Medio

                             0.0,                                                         // % Desconto do Item
                             0.0,                                                         // Valor do Frete
                             0.0,                                                         // Valor do Desconto Especial
                             '',                                                          // Código do Representante
                             '',                                                          // Código do Vendedor 2
                             0.0,                                                         // Percentual de Comissão do Vendedor
                             0.0,                                                         // Total de Comissão do Vendedor
                             0.0,                                                         // Total de Comissão do Vendedor 2
                             LClaFis,                                                     // Classificação Fiscal
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
                             FEspecieDoDocumento,                                         // Tipo de Faturamento
                             FNumeroDoDocumento,                                          // Numero de Faturamento
                             VS_strCodEmp,                                                // Empresa dd Faturamento
                             VS_Date,                                                     // Data de Faturamento
                             FCodigoDoVendedor,                                           // Vendedor do Faturamento
                             '01000',                                                     // Condição de Pagamento do Faturamento
                             Abs(FItensAjuste.FieldByName('TOT_TOTITE').AsString.ToDouble()),         // Valor do Faturamento
                             'NOR',                                                       // Identificação Produto ( Normal / Outros )
                             FConCit.FieldByName('ITE_INCPIS').AsString,                  // Indice se incide Pis
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
                             LCodOpe,                                                     // Código do Digitador
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
                             '',
                             0,
                             0,
                             0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                             FItensAjuste.FieldByName('ITE_CODACA').AsString,
                             FItensAjuste.FieldByName('ITE_EMPACA').AsString,
                             Not fEmptyStr(FItensAjuste.FieldByName('ITE_CODACA').AsString),        // PROD ACABADO
                             LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueFisico.ToFilKar, // FILKAR
                             '',                                                          //  Especie da Entrega Fututa
                             '',                                                          //  Documento da Entrega Fututa
                             '',
                             '',                                                          //  Empresa da Entrega Fututa
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

                             (IIF(FItensAjuste.FieldByName('ITE_CUSLOT').AsFloat > 0,
                                  FItensAjuste.FieldByName('ITE_CUSLOT').AsFloat, LPreCus) / LCnv_Ml) * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo 2

                             0,
                             0,
                             '',
                             LNumLot,
                             'N',
                             0,
                             0,
                             0,
                             (FConIte.FieldByName('ITE_PREULT').AsFloat / LCnv_Ml) * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat, // fltTotUlt
                             (FConIte.FieldByName('ITE_IMPULT').AsFloat / LCnv_Ml) * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat, // fltImpUlt
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
                             0,  // fltUniTab
                             '', // strLot_TA
                             0,  // fltConFre
                             0,  // fltBasAnt
                             0,  // fltIcmAnt
                             0,  // fltVendor
                             0,  // fltOutDes
                             0,  // fltVlGnre
                             'P',
                             FItensAjuste.FieldByName('ITE_UNITAR').AsFloat * FItensAjuste.FieldByName('ITE_QTDITE').AsFloat,  // fltOutIcm
                             0,         // fltIseIcm
                             0,         // fltFreSug
                             '',        // strCodMot
                             '',        // strNatPis
                             '',        // strNatCof
                             '',        // strSeqGad
                             0,         // fltOutVal
                             0,         // fltIcmSai
                             0,         // fltImpFed
                             0,         // fltDesOpe
                             0,         // fltQtdExp
                             '',        // strNumCmp
                             0,         // intNItCmp
                             0,         // fltDeDVCf
                             '',        // strCodMec
                             'N',       // strAntPro
                             'N',       // strAntFre
                             0,         // fltMedAnt
                             0,         // fltPreAnt
                             0,         // fltImpAnt
                             '',        // strSeqAnt
                             'N',       // strRICMPR
                             0,         // fltComLiq
                             '',        // strNcmTin
                             0,         // fltValIva
                             'N',       // strCliBus
                             '',        // strTurEnt
                             'NOR',     // strIdeDev
                             0,         // fltPeBaST
                             0,         // fltVal_RT
                             0,         // fltDesCli
                             0,         // fltImpPag
                             0,         // fltTaxJur
                             0,         // fltSerRat
                             '',        // strProBri
                             0,         // fltPonBri
                             0,         // fltValDif
                             0,         // fltVaFrAn
                             '',        // strLotAba
                             0,         // fltFedImp
                             0,         // fltEstImp
                             0,         // fltMunImp
                             '',        // strIncDev
                             'N',       // strBrinde
                             '',        // strCodPar
                             '',        // strTipBri
                             0,         // fltIcmOrg
                             '',        // strBaqtze
                             '',        // strIncFut
                             0,         // fltValFle
                             0,         // fltTaxEnt
                             0,         // fltVrdIcm
                             0,         // fltBasVrd
                             '',        // strMtdIcm
                             'N',       // strBxSbIt
                             '',        // strIteAbf
                             'N',       // strAtivac
                             0,         // intSeqCom
                             0,         // fltVICMDe
                             '',        // strNcmIte
                             0,         // fltComDig
                             0,         // fltPerDig
                             0,         // fltIcmPav
                             False,     // blnIcmSai
                             0,         // fltAlDifa
                             '',        // strAutSai
                             0,         // fltBFCPST
                             0,         // fltPFCPST
                             0,         // fltVFCPST
                             '',        // strDadSep
                             '',        // strAutEle
                             '',        // strNotUlt
                             0,         // fltPICMEF
                             0,         // fltBICMEF
                             0,         // fltAICMEF
                             0,         // fltVICMEF
                             0,         // fltBSTANT
                             0,         // fltVSTANT
                             '',        // strNotC17
                             0,         // fltAlq922
                             0,         // fltDesCnd
                             '',        // strProEsp
                             '',        // strCodPro
                             '',        // strInc_Pd
                             0,         // fltSICMEF
                             0,         // fltValTCI:
                             0,         // fltCalTCI:
                             0,         // fltVal_TS:
                             'S',       // strExtFul
                             FFulfillment.CodigoDoEstoqueExterno, //strCodExt
                             0,         //fltFreMkp: Double = 0;
                             0,         //fltComMkp: Double = 0;
                             '',        //strAIdKitPromocao : String = '';
                             '',        //strChaveAcesso: String = '';
                             0,         //fltQtdCom: Double = 0;
                             0,         //fltFreCot: Double = 0;
                             '',        //AstrComplemento : String = '';
                             '',        //strEmpCar: String = '';
                             '',        //strAutoinDevCar: String = '';
                             0,         //AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                             0,         //AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                             0,         //AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                             0,         //fltFreRat: Double = 0;
                             0,         //fltValIpiEntFut: Double = 0;
                             0,         //fltValRetEntFut: Double = 0;
                             0,         //fltValFcpSTEntFut: Double = 0;
                             0,         //fltDesPis: Double = 0;
                             False,     //blnClaRet: Boolean = False;
                             '',        //strOpSeEx: String = '';
                             '',        //strConExp: String = '';
                             '',        //strEmbExp: String = '';
                             '',        //strObsExp: String = '';
                             False,     //blnAtoDeclaratorioDF: Boolean = False;
                             '',        //strMovTriLocFis: String = '';
                             0,         //fltVDesST: Double = 0;
                             '',        //strMDesST: String = '';
                             '',        //strNumDrw: String = '';
                             '',        //strTipBus: String = '';
                             '',        //strNumPla: String = '';
                             '',        //strParNum: String = '';
                             '',        //strReqCom: String = '';
                             '',        //strNatOpe: String = '';
                             0,         //fltRpaFre: Double = 0;
                             0,         //fltPerRic: Double = 0;
                             False,     //blnAltEst: Boolean = False;
                             0,         //intSeqPer: Integer = 0;
                             0,         //intDetItem: Integer = 0;
                             0,         //fltICMCFR: Double = 0;
                             0,         //fltFreteCalc: Double = 0;
                             0,         //fltFreConCalc: Double = 0;
                             'N',       //strPegou_ : String = 'N';
                             0,         //fltVFCPOP: Double = 0;
                             0,         //fltVFCPDF: Double = 0;
                             0,         //fltCubage: Double = 0;
                             0,         //fltCfbIpi: Double = 0;
                             0,         //fltCfaIpi: Double = 0;
                             0,         //fltCfvIpi: Double = 0;
                             'N',       //strCipiOK: String = 'N';
                             '',        //strDocIpi: String = '';
                             '',        //strEspIpi: String = '';
                             '',        //strEmpIpi: String = '';
                             0,         //intRemFil: Integer = 0;
                             0,         //fltQtdRemFil: Double = 0;
                             FFulfillment.EhOperacaoFulfillment,                                     //blnFulfillmentModoRobo: Boolean = False;
                             LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueExterno.ToFilFul, //blnFilFul: Boolean = True;
                             False,     //blnBaiDev: Boolean = False;
                             '',        //strAutEnt: String = '';
                             0,         //dtaDtaCmp: TDateTime = 0;
                             FFulfillment.SiglaHubMarketPlace,                //strFullHubMkp: String = '';
                             0,         //fltOutValPD: Double = 0;
                             EntradaSaida,                                                           //strFilFul_EntSai: String = '';
                             '',        //strIncOri: String = '';
                             '',                                              //strTckQbt: String = '';
                             'N',                                             //strEntTri: String = 'N';
                             '',                                              //strFulDif: String = '';
                             FFulfillment.ClassificacaoFiscal,                //strClaFat: String = '';
                             0,                                               //fltICMNCR: Double = 0;
                             0,                                               //fltFCPNCR: Double = 0;
                             'N');                                            //strColoranteDeEntregaFutura : String = 'N';

      ReprocessarItem(FItensAjuste.FieldByName('ITE_CODITE').AsString, '', False);

      If (LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueFisico) Then
      Begin
        LGravou := fAtualizaEstoqueCadIte(FItensAjuste.FieldByName('ITE_CODITE').AsString,
                                          EntradaSaida,
                                          FItensAjuste.FieldByName('ITE_QTDITE').AsFloat,
                                          0.0,
                                          LNumLot,
                                          False);
      End;

      FItensAjuste.Next;

    End;

    Result := LGravou And fCommit;

  Except
    fRollBack;
    Raise;
  End;

End;

function TAjusteDeEstoque.HabilitouCustoPorTabelaDePreco: Boolean;
begin

  Result := False;

  If Not (fCfgSis('TABPRD', varBoolean)) Then
    Exit;

  If Not (FPreAju = 'PRECUS') Then
    Exit;

  Result := True;

end;

constructor TAjusteDeEstoque.New;
begin

  FCodigoDoCliente    := EmptyStr;
  FNumeroDoDocumento  := EmptyStr;
  FEspecieDoDocumento := EmptyStr;
  FCodigoDoVendedor   := EmptyStr;

  FFulfillment := TFulfillment.New;
  FPreAju      := fCfgSis('PREAJU');
  FImpAju      := fCfgSis('IMPAJU');

  If HabilitouCustoPorTabelaDePreco Then
    FCustoItemFaturamento := TCustoItemFaturamento.New;

  AtribuiTabelas;
  CriarTemporaria;

end;

function TAjusteDeEstoque.RetornaDadosItem(ACodIte: String): TUniQuery;
begin

  Result := fCriaQuery;

  Result.SQL.Clear;
  Result.SQL.Add('SELECT         ');
  Result.SQL.Add('  C.*,         ');
  Result.SQL.Add('  U.UNI_DESUNI,');
  Result.SQL.Add('  G.ITE_SALDOS ');
  Result.SQL.Add('FROM           ');
  Result.SQL.Add('  ITEGER G,    ');
  Result.SQL.Add('  CADITE C     ');
  Result.SQL.Add('  JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ');
  Result.SQL.Add('WHERE          ');
  Result.SQL.Add('  C.ITE_CODITE = :CODITE      AND ');
  Result.SQL.Add('  C.ITE_CODITE = G.ITE_CODITE AND ');
  Result.SQL.Add('  G.ITE_CODEMP = :CODEMP ');
  Result.ParamByName('CODITE').AsString := ACodIte;
  Result.ParamByName('CODEMP').AsString := VS_strCodEmp;
  Result.Open;

end;

function TAjusteDeEstoque.RetornaPrecoUnitario(ACodIte: String): Double;
  var
    LConIte : TUniQuery;
begin

  If HabilitouCustoPorTabelaDePreco Then
  Begin
    CarregaValoresCusto(ACodIte, VS_strCodEmp, RetornaTabelaCusto);
    Exit(FCustoItem.fltPreCus);
  End;

  LConIte := fCriaQuery(nil);

  Try

    LConIte.SQL.Clear;
    LConIte.SQL.Add(GetSqlIteGer);
    LConIte.ParamByName('CODITE').AsString := ACodIte;
    LConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LConIte.Open;

    Result := LConIte.FieldByName(TabPrecoImp).AsFloat;

  Finally
    FreeAndNil(LConIte);
  End;

end;

function TAjusteDeEstoque.RetornaTabelaCusto: String;
var
  strTabAju : String;
  intTabPre : Integer;
begin

  Result := '';

  strTabAju := fCfgSis('TABAJU', varString);

  If strTabAju = 'CLIENTE' then
    Exit(fRetTabPrecoCliente(FCodigoDoCliente));

  for intTabPre := 1 to 7 do
  begin
    If strTabAju = 'PRECU' + intTabPre.ToString Then
      Result := intTabPre.ToString;
  end;

end;

function TAjusteDeEstoque.TabPreco: String;
  Var
    LSQL: String;
    LAux: TUniQuery;
begin

  If (FPreAju = 'CLIENTE') Then
  Begin

    Result := 'ITE_PREVE1';

    LAux := fCriaQuery;

    Try

      LSQL := '';
      LSQL := LSQL + 'SELECT ';
      LSQL := LSQL + '  CLI_TABPRE ';
      LSQL := LSQL + 'FROM ';
      LSQL := LSQL + '  CADCLI ';
      LSQL := LSQL + 'WHERE ';
      LSQL := LSQL + '  CLI_CODCLI = :CODCLI ';

      LAux.Close;
      LAux.SQL.Clear;
      LAux.SQL.Add(LSQL);
      LAux.ParamByName('CODCLI').AsString := FCodigoDoCliente;
      LAux.Open;

      Result := IIF(Not LAux.IsEmpty, 'ITE_PREVE' + LAux.FieldByName('CLI_TABPRE').AsString, 'ITE_PREVE1');

    Finally
      FreeAndNil(LAux);
    End;

    Exit;

  End;

  Result := 'ITE_' + FPreAju;

end;

function TAjusteDeEstoque.TabPrecoImp: String;
begin

  If SameText(FImpAju, 'TOTCUS') Then
    Result := 'PRECUS'
  Else If SameText(FImpAju, 'TOTULT') Then
    Result := 'PREULT'
  Else If SameText(FImpAju, 'IMPULT') Then
    Result := 'IMPULT'
  Else If SameText(FImpAju, 'TOTMED') Then
    Result := 'PREMED';

  Result := 'ITE_' + Result;

  If SameText(FImpAju, 'TOTITE') Then
    Result := TabPreco;

end;

{ TItemAjuste }

function TItemAjuste.getCodAca: String;
begin
  Result := FCodAca;
end;

function TItemAjuste.getCodIte: String;
begin
  Result := FCodIte;
end;

function TItemAjuste.getCodMar: String;
begin
  Result := FCodMar;
end;

function TItemAjuste.getCodUni: String;
begin
  Result := FCodUni;
end;

function TItemAjuste.getCusLot: Double;
begin
  Result := FCusLot;
end;

function TItemAjuste.getDesIte: String;
begin
  Result := FDesIte;
end;

function TItemAjuste.getEmpAca: String;
begin
  Result := FEmpAca;
end;

function TItemAjuste.getEntSai: String;
begin
  Result := FEntSai;
end;

function TItemAjuste.getNumLot: String;
begin
  Result := FNumLot;
end;

function TItemAjuste.getQtdIte: Double;
begin
  Result := FQtdIte;
end;

function TItemAjuste.getQtdPla: Double;
begin
  Result := FQtdPla;
end;

function TItemAjuste.getRefere: String;
begin
  Result := FRefere;
end;

function TItemAjuste.getTotIte: Double;
begin
  Result := FTotIte;
end;

function TItemAjuste.getUnitar: Double;
begin
  Result := FUnitar;
end;

procedure TItemAjuste.Limpar;
begin
  FCodIte := EmptyStr;
  FDesIte := EmptyStr;
  FRefere := EmptyStr;
  FCodMar := EmptyStr;
  FEntSai := EmptyStr;
  FCodUni := EmptyStr;
  FNumLot := EmptyStr;
  FCodAca := EmptyStr;
  FEmpAca := EmptyStr;
  FCusLot := 0.00;
  FQtdPla := 0.00;
  FQtdIte := 0.00;
  FUnitar := 0.00;
  FTotIte := 0.00;
end;

constructor TItemAjuste.New;
begin
  Limpar;
end;

procedure TItemAjuste.setCodAca(AValue: String);
begin
  FCodAca := AValue;
end;

procedure TItemAjuste.setCodIte(AValue: String);
begin
  FCodIte := AValue;
end;

procedure TItemAjuste.setCodMar(AValue: String);
begin
  FCodMar := AValue;
end;

procedure TItemAjuste.setCodUni(AValue: String);
begin
  FCodUni := AValue;
end;

procedure TItemAjuste.setCusLot(AValue: Double);
begin
  FCusLot := AValue;
end;

procedure TItemAjuste.setDesIte(AValue: String);
begin
  FDesIte := AValue;
end;

procedure TItemAjuste.setEmpAca(AValue: String);
begin
  FEmpAca := AValue;
end;

procedure TItemAjuste.setEntSai(AValue: String);
begin
  FEntSai := AValue;
end;

procedure TItemAjuste.setNumLot(AValue: String);
begin
  FNumLot := AValue;
end;

procedure TItemAjuste.setQtdIte(AValue: Double);
begin
  FQtdIte := AValue;
end;

procedure TItemAjuste.setQtdPla(AValue: Double);
begin
  FQtdPla := AValue;
end;

procedure TItemAjuste.setRefere(AValue: String);
begin
  FRefere := AValue;
end;

procedure TItemAjuste.setTotIte(AValue: Double);
begin
  FTotIte := AValue;
end;

procedure TItemAjuste.setUnitar(AValue: Double);
begin
  FUnitar := AValue;
end;

end.
