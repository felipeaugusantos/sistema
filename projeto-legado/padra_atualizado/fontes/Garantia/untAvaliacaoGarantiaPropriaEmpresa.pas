unit untAvaliacaoGarantiaPropriaEmpresa;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  untAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes, untFuncFat, Uni, UniClientDataSet, cxContainer, cxProgressBar, untGarantiaPedidoReposicao,
  untCadLote, untGarantiaPropriaEmpresaTypes, untAuditoriaGravacaoSaldo, untConstantes;


type
  TDocumentoRecord = Record
    strNumDoc: String;
    strEspDoc: String;
    strAutInc: String;
    procedure pLimpar;
  End;

  TDocumento = TDocumentoRecord;
  TArrDocumentos = Array of TDocumento;



type
  TfrmAvaliacaoGarantiaPropriaEmpresa = class(TfrmPai)
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGridCitel;
    btnConfirmar: TBitBtnLocked;
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    cdsDadosCODITE: TStringField;
    cdsDadosDESITE: TStringField;
    cdsDadosAUTINC: TStringField;
    cdsDadosQTDREQ: TFloatField;
    cdsDadosQTDREF: TFloatField;
    cdsDadosQTDAPR: TFloatField;
    cdsDadosCODCLI: TStringField;
    cdsDadosNOMCLI: TStringField;
    cdsDadosNUMENT: TStringField;
    cxGridDBTableViewCitel1AUTINC: TcxGridDBColumn;
    cxGridDBTableViewCitel1NUMENT: TcxGridDBColumn;
    cxGridDBTableViewCitel1CODITE: TcxGridDBColumn;
    cxGridDBTableViewCitel1DESITE: TcxGridDBColumn;
    cxGridDBTableViewCitel1QTDREQ: TcxGridDBColumn;
    cxGridDBTableViewCitel1QTDREF: TcxGridDBColumn;
    cxGridDBTableViewCitel1QTDAPR: TcxGridDBColumn;
    cxGridDBTableViewCitel1CODCLI: TcxGridDBColumn;
    cxGridDBTableViewCitel1NOMCLI: TcxGridDBColumn;
    cdsDadosFINALIDADE: TStringField;
    cxGridDBTableViewCitel1Finalidade: TcxGridDBColumn;
    cdsComponentes: TUniClientDataSet;
    cdsComponentesINCGAD: TStringField;
    cdsComponentesCOMPONENTE: TStringField;
    cdsComponentesAPROVEITAR: TFloatField;
    cdsComponentesREFUGAR: TFloatField;
    cdsComponentesCUSTO: TFloatField;
    cdsDadosSELECIONADO: TStringField;
    cxGridDBTableViewCitel1Selecionado: TcxGridDBColumn;
    cdsDadosSIGUNI: TStringField;
    cdsComponentesTOTALCUSTOREFUGAR: TAggregateField;
    cdsComponentesTOTALCUSTOAPROVEITAR: TAggregateField;
    cdsDadosGPE_SEQBAI: TStringField;
    cdsDadosGPE_SEQAJE: TStringField;
    cdsDadosAUTOINCREM: TStringField;
    cdsDadosTEM_ESTRUTURA: TStringField;
    cdsDadosCODFAB: TStringField;
    cxGridDBTableViewCitel1CODFAB: TcxGridDBColumn;
    cdsDadosITE_REFERE: TStringField;
    cdsDadosITE_CODMAR: TStringField;
    cdsDadosGAD_VALITE: TFloatField;
    Panel1: TPanel;
    Label1: TLabel;
    pnlCliente: TPanel;
    edtCodCli: TEditFocus;
    lblCliente: TLabel;
    edtNomCli: TEditFocus;
    cdsComponentesORIGEM: TStringField;
    cdsComponentesMOTIVO: TStringField;
    cdsComponentesDESTINO: TStringField;
    cdsComponentesINCAJU: TStringField;
    cdsDadosVALENT: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure cdsDadosFINALIDADEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsDadosBeforeDelete(DataSet: TDataSet);
    procedure cdsDadosQTDREFValidate(Sender: TField);
    procedure cdsDadosQTDAPRValidate(Sender: TField);
    procedure cxGridDBTableViewCitel1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBTableViewCitel1DblClick(Sender: TObject);
    procedure cxGridDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    FClienteFilial: String;
    FCliEst: String;
    FCodOpe: String;
    FPedidoReposicao: TDocumento;
    FstrFornecedorFilial : String;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    function fSqlDados: String;
    procedure pCarregarDados;
    procedure pCriarTabelaDados;
    procedure pMensagemQuantidadeInvalida;
    function fValidarQuantidade(Sender: TField; Out fltDif: Double): Boolean; overload;
    function fValidarQuantidade(const fltQtdReq, fltQtd: Double; Out fltDif: Double): Boolean;overload;
    function fEscolherFinalidade: TFinalidade;
    procedure pConfirmar;
    function fConfirmar(prgProgresso : TcxProgressbar): Boolean;
    procedure pReceberComponente(Componente: TComponente);
    procedure pAdicionarProdutoAcabadoAproveitamento(const fltQtdApr, fltQtdRef: Double);
    procedure pLimparComponentes(const strIncGad: String);
    function fTratarFinalidadeComponentes(const strCodIte: String; fltQtd: Double): boolean;
    procedure pLimparDados;
    procedure pSelecionarItem;
    procedure pMarcarItem(const blnSelecionar: Boolean; blnTodos: Boolean = False);

    function fSqlAprovarGarantia: String;

    function fAplicarAvaliacaoGarantia(const strIncGad: String; fltQtdApr, fltQtdRep: double): Boolean;overload;
    function fAjustarEstoques(InResult: Boolean;
                              var   ArrDocumentos: TArrDocumentos;
                              var  Documento: TDocumento): Boolean;

    function fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP: String): Boolean;
    procedure pCarregarCliente(fatVenda : TFatVenda);
    function  fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    function fTratarPerdaRefugados(Var ArrDocumentos: TArrDocumentos): Boolean;
    function fAplicarAvaliacaoGarantia: Boolean;overload;
    procedure pGuardarDocumento(var ArrDocumentos: TArrDocumentos; Documento: TDocumento);overload;
    procedure pGuardarDocumento(var ArrDocumentos: TArrDocumentos; strNumDoc, strEspDoc, strAutInc: String);overload;

    procedure pFiltrarAprovado;
    procedure pFiltarSelecionados;
    procedure pFiltrarItensPedido;
    procedure pLimparFiltroDados;

    procedure pLimparFiltroComponentes;
    function fAjustarEstoque(Var strAutInc, strNumDoc, strEspDoc: String; blnAjEntrada: boolean = True): Boolean;
    function fGetSqlIteGer: String;
    function fGetSqlCadIte: String;
    procedure pFiltrarComponentesAproveitar;

    function fGravarMovGPE: Boolean;
    function fGravarMGPECO(const strAutInc: String): Boolean;
    function fTemItemSelecionado: boolean;
    procedure pMensagemExibirDocumentos(const arrDocumentos: TArrDocumentos; stlGarantias: TStrings);

    function fAplicarQuantidade(const fltQtdApr, fltQtdRef: Double): Boolean;
    procedure pCancelar;
    function fGravaPedidoVenda(Var ArrDocumentos: TArrDocumentos): Boolean;
    function fIncluirItensPedido(Pedido: TGarantiaPedido): Boolean;
    function fValorUnitarioItem: Double;
    function fObterPrefixoClaFis: String;

  Private const
    F_APROVAR: String = '1';
    F_REFUGAR: String = '2';
    NAO: String = '0';
    SIM: String = '1';
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pReceberAutIncPedido(strAutInc, strNumDoc, strEspDoc: String);
    { Public declarations }
  end;

var
  frmAvaliacaoGarantiaPropriaEmpresa: TfrmAvaliacaoGarantiaPropriaEmpresa;

implementation

uses
  untFuncoesSimples, System.strUtils, untDigCliente, untFuncoes, untTypesSistema, untMovGer, untCadIte, untProdAcabado,  untConsultas,
  untFatDadosFiscais, untFuncFatTypes, untFatTipoFaturamento, untObsGarantia, untGravando, untGarantiaLibDiversos, untGarantiaPropriaEmpresaCancelamento,
  untMensagemExplicativa;

{$R *.dfm}

{ TfrmAvaliacaoGarantiaPropriaEmpresa }

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if (cdsDados.State in [dsInsert, dsEdit]) then
    cdsDados.Post;

  pconfirmar;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cdsDadosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  pLimparComponentes(cdsDadosAUTINC.AsString);
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cdsDadosFINALIDADEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
Var
  Finalidade : TFinalidade;
begin
  inherited;
  Finalidade.pSetAsString(Sender.AsString);
  Text := Finalidade.fGetText;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cdsDadosQTDAPRValidate(Sender: TField);
Var
  fltDif: Double;
begin
  inherited;
  if Not fValidarQuantidade(Sender, fltDif) then
  begin
    pMensagemQuantidadeInvalida;
    cdsDados.Cancel;
  end
  else
  begin
    if Not  fAplicarQuantidade(Sender.AsFloat, fltDif) then
      abort;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cdsDadosQTDREFValidate(Sender: TField);
Var
  fltDif: Double;
begin
  inherited;
  if Not fValidarQuantidade(Sender, fltDif) then
  begin
    pMensagemQuantidadeInvalida;
    cdsDados.Cancel;
  end
  else
  begin
    if Not  fAplicarQuantidade(fltDif, Sender.AsFloat) then
      abort;

  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cxGridDBTableViewCitel1CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var value: String;
begin
  inherited;
  value := VarToStrDef(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridDBTableViewCitel1Selecionado.Index],'0');
  if value = SIM then
  begin
    ACanvas.Font.Color := clBlue;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cxGridDBTableViewCitel1DblClick(Sender: TObject);
begin
  inherited;
  pSelecionarItem;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.cxGridDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN, VK_SPACE : pSelecionarItem;
  end;
end;



procedure TfrmAvaliacaoGarantiaPropriaEmpresa.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fAjustarEstoque(var strAutInc, strNumDoc, strEspDoc: String; blnAjEntrada: boolean = True): Boolean;
var
  strClaFis: string;
  strNumDocAJ: String;

  qryConIte: TUniQuery;
  qryConCit: TUniQuery;

  dtaDtaEnt   : TDateTime;
  strEntSai: String;
  arrDuplic   : TarrDuplicata;
  fltTotal: Double;
  recServicos : TDadosServicos;
  fltCnv_Ml: Double;
  strAutIncTmp: String;
  fltQtd: Double;
begin
  qryConCit := Nil;
  qryConIte := Nil;
  Try
    Try
       qryConCit := fCriaQuery;
       qryConIte := fCriaQuery;


        if blnAjEntrada then
        begin
          strEntSai := 'E';
          fltTotal := StrToFloat(cdsComponentesTOTALCUSTOAPROVEITAR.AsString);
          strClaFis := '1999'
        end
        else begin
          fltTotal := StrToFloat(cdsComponentesTOTALCUSTOREFUGAR.AsString);
          strEntSai := 'S';
          strClaFis := '5999';
        end;

        strNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);
        strNumDoc := strNumDocAJ;
        strEspDoc := 'AJ';
        dtaDtaEnt := VS_Date;
        FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

        {$Region 'GRAVAMOVGER'}
        Result := fGravaMovGer(strAutInc,                                                     // Auto Incremento (Retorno)
                               strNumDocAJ,                      // Numero Documento
                               'AJ',                                                // Espécie
                               VS_strCodEmp,                                                  // Empresa
                               '',                                                            // Transportadora
                               FCodOpe,                                                     // Vendedor
                               '',                                                            // Fornecedor
                               FClienteFilial,                                                // Cliente
                               'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                               dtaDtaEnt,                                                     // Data da Entrada
                               fTime(),                                                       // Hora da Entrada
                               VS_Date,                                                       // Data do Documento
                               '01000',                                                       // Condição de Pagamento
                               FCliEst,                                                     // Estado do Cliente / Fornecedor
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
                               Abs(fltTotal),                              // Valor Contábil
                               Abs(fltTotal),                              // Total dos Itens
                               0.0,                                                           // Total de Custo
                               0.0,                                                           // Total Médio
                               '',                                                            // Tipo de Frete
                               0.0,                                                           // Valor do Frete
                               0.0,                                                           // Peso Bruto
                               0.0,                                                           // Peso Liquido
                               0.0,                                                           // Volume
                               '',                                                            // Especie
                               '',                                                            // Marca
                               'GARANTIA PRÓPRIA EMPRESA',                                                // Mensagem 1
                               '',                                                // Mensagem 2
                               '',                                                            // Mensagem 3
                               '',                                                            // Mensagem 4
                               '',                                                            // Mensagem 5
                               False,                                                     // Indica se Faturado ou nao

                               EmptyStr,                                // Tipo de Faturamento
                               EmptyStr,                         // Numero de Faturamento
                               EmptyStr,                        // Empresa dd Faturamento
                               0,                                    // Data de Faturamento
                               EmptyStr,                           // Vendedor do Faturamento
                               EmptyStr,                             // Condição de Pagamento do Faturamento
                               False,                                                         // Devolução Especial
                               0.0,         // Valor do Faturamento
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
                               '9999',                                                        // Classificação Fiscal 1
                               '',                                                            // Classificação Fiscal 2
                               '',                                                            // Classificação Fiscal 3
                               '',                                                            // Natureza da Operação
                               0.0,                                                           // Percentual de Desconto
                               FCodOpe,                                                     // Codigo do Digitador
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
                               '',
                               True);                                                         // Imprime Duplicatas na NF-e
        {$EndRegion}

        If Result Then
          objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

        qryConIte.Close;
        qryConIte.SQL.Clear;
        qryConIte.SQL.Add(fGetSqlIteGer);

        qryConCit.Close;
        qryConCit.SQL.Clear;
        qryConCit.SQL.Add(fGetSqlCadIte);

        cdsComponentes.First;

        While (Not cdsComponentes.Eof) And (Result) Do
        Begin
          if blnAjEntrada then
            fltQtd := cdsComponentesAproveitar.AsFloat
          else
            fltQtd := cdsComponentesRefugar.AsFloat;

          qryConIte.Close;
          qryConIte.ParamByName('CODITE').AsString := cdsComponentes.FieldByName('COMPONENTE').AsString;
          qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryConIte.Open;

          qryConCit.Close;
          qryConCit.ParamByName('CODITE').AsString := cdsComponentes.FieldByName('COMPONENTE').AsString;
          qryConCit.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryConCit.Open;

          fltCnv_Ml := 1;

          strAutIncTmp := '';
          {$Region 'GRAVAMOVDET'}
          Result := fGravaMovDet(strAutIncTmp,                                                // Retorna Auto-Incremento por Referencia
                                 strAutInc,                                                   // Sequencial do Arquivo Geral
                                 strNumDocAJ,                    // Numero Documento
                                 'AJ',                                              // Espécie
                                 VS_strCodEmp,                                                // Empresa
                                 cdsComponentes.FieldByName('COMPONENTE').AsString,                          // Cód. Item
                                 FCodOpe,                                                   // Vendedor
                                 '',                                                          // Código Diversos
                                 qryConCit.FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                                 '',                                                          // Fornecedor
                                 FClienteFilial,                                              // Cliente
                                 dtaDtaEnt,                                                   // Data da Entrada
                                 fTime(),                                                     // Hora da Entrada
                                 VS_Date,                                                     // Data do Documento
                                 '01000',                                                     // Condição de Pagamento
                                 'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                                 FCliEst,                                                    // Estado do Fornecedor
                                 qryConCit.FieldByName('ITE_DESITE').AsString,                          // Descrição do Item
                                 qryConCit.FieldByName('ITE_REFERE').AsString,                          // Referência do Item
                                 qryConCit.FieldByName('ITE_CODUNI').AsString,                          // Cód. Unidade
                                 qryConCit.FieldByName('ITE_CODFOR').AsString,                // Fornecedor Item
                                 fltQtd,                           // Quantidade do Item
                                 cdsComponentesCUSTO.asfloat,                           // Valor Unitario
                                 cdsComponentesCUSTO.asfloat,                           // Valor Unitário Original
                                 cdsComponentesCUSTO.asfloat,                           // Valor Unitário Original sem juros
                                 cdsComponentesCUSTO.asfloat * fltQtd,    // Total do Item
                                 cdsComponentesCUSTO.asfloat * fltQtd,    // Valor Contábil do Item
                                 fltQtd * cdsComponentesCusto.AsFloat, // Valor Total de Custo
                                 (qryConIte.FieldByName('ITE_PREMED').AsFloat / fltCnv_Ml) * fltQtd, // Valor Total Medio
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
                                 False,                                                   // Indica se ja esta Faturado
                                 EmptyStr,                              // Tipo de Faturamento
                                 strNumDocAJ,                       // Numero de Faturamento
                                 EmptyStr,                      // Empresa dd Faturamento
                                 0,                                  // Data de Faturamento
                                 EmptyStr,                         // Vendedor do Faturamento
                                 EmptyStr,                           // Condição de Pagamento do Faturamento
                                 0.0,       // Valor do Faturamento
                                 'NOR',                                                       // Identificação Produto ( Normal / Outros )
                                 qryConCit.FieldByName('ITE_INCPIS').AsString,                // Indice se incide Pis
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
                                 FCodOpe,                                                   // Código do Digitador
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
                                 '',
                                 '',
                                 True,  // PROD ACABADO
                                 False, // FILKAR
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
                                 (qryConIte.FieldByName('ITE_PRECUS').AsFloat / fltCnv_Ml) * fltQtd, // Valor Total de Custo 2
                                 0,
                                 0,
                                 '',
                                 '',
                                 'N',
                                 0,
                                 0,
                                 0,
                                 (qryConIte.FieldByName('ITE_PREULT').AsFloat / fltCnv_Ml) * fltQtd, // fltTotUlt
                                 (qryConIte.FieldByName('ITE_IMPULT').AsFloat / fltCnv_Ml) * fltQtd, // fltImpUlt
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
                                 cdsComponentesCUSTO.asfloat * fltQtd,  // fltOutIcm
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
                                 0,   // fltValTCI:
                                 0,   // fltCalTCI:
                                 0);   // fltVal_TS:

          {$Endregion}

          If Not Result Then
            Break;

          cdsComponentes.Edit;
          cdsComponentesINCAJU.AsString := strAutIncTmp;
          cdsComponentes.Post;

          Result := fAtualizaEstoqueCadIte(qryConIte.FieldByName('ITE_CODITE').AsString,
                                             strEntSai,
                                             fltQtd,
                                             0.0,
                                             '', False);

          If Not Result Then
            Break;


          cdsComponentes.Next;
        End;
    Finally
       if Assigned(qryConCit)   then
        qryConCit.free;

       if Assigned(qryConIte)   then
        qryConIte.free;
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;

end;


function TfrmAvaliacaoGarantiaPropriaEmpresa.fSqlAprovarGarantia: String;
begin
  Result := ' UPDATE MOVGAD  SET GAD_QTDRET = :QTDRET, GAD_QTDREP = :QTDREP, GAD_DTARET = :DTARET WHERE AUTOINCREM = :AUTINC ';
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fAplicarAvaliacaoGarantia(const strIncGad: String; fltQtdApr, fltQtdRep: double): Boolean;
Var
  Qry: TUniQuery;
begin
  Result := True;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Sql.Clear;
      Qry.Sql.Add(fSqlAprovarGarantia);
      Qry.ParamByName('QTDRET').AsFloat := fltQtdApr;
      Qry.ParamByName('QTDREP').AsFloat := fltQtdRep;
      Qry.ParamByName('DTARET').AsDateTime := VS_Date;
      Qry.ParamByName('AUTINC').AsString := strIncGad;
      Qry.Execute;
    Finally
      Qry.Free;
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;
end;


function TfrmAvaliacaoGarantiaPropriaEmpresa.fAjustarEstoques(InResult: Boolean;
                                                              var   ArrDocumentos: TArrDocumentos;
                                                              var  Documento: TDocumento): Boolean;
begin
  Result := InResult;
  if Result and (Not cdsComponentes.IsEmpty) then
  begin
    if fAjustarEstoque(Documento.strAutInc, Documento.strNumDoc, Documento.strEspDoc) then
    begin
      pGuardarDocumento(ArrDocumentos,Documento);
      cdsDados.First;
      while Not cdsDados.Eof do
      begin
        if (cdsDadosTem_Estrutura.AsString = SIM) then
        begin
          cdsDados.Edit;
          cdsDadosGPE_SEQAJE.AsString := Documento.strAutInc;
          cdsDados.Post;
        end;
        cdsDados.Next;
      end;
    end
    else
      Result := False;
  end;
End;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fConfirmar(prgProgresso : TcxProgressbar): Boolean;
Var
  ArrDocumentos: TArrDocumentos;
  Documento: TDocumento;
  blnTransacaoLocal: Boolean;
  stlGarantias: TStringList;
  strCodErrosAuditoria: String;
begin
  cdsDados.DisableControls;
  Result := fTemItemSelecionado;
  blnTransacaoLocal := False;
  stlGarantias := Nil;
  if Not Result then
  begin
    cdsDados.EnableControls;
    fMensagem('Atenção!','Não há garantia selecionado!',['&Ok']);
    Exit;
  end;

  SetLength(ArrDocumentos,0);
  Try
    prgProgresso.properties.Max := 1;
    prgProgresso.Position := 0;

    objAuditoriaSaldo.Limpar;

    blnTransacaoLocal := fStartTransaction;
    pFiltarSelecionados;

    Result := Result and (Not cdsDados.IsEmpty) and fAplicarAvaliacaoGarantia;

    {$Region 'Processando ajuste dos componentes'}
    prgProgresso.properties.Max := 2;
    prgProgresso.Position := 0;

    pFiltrarComponentesAproveitar;


    Result := fAjustarEstoques(Result, ArrDocumentos, Documento);

    
    {$Endregion}

    {$Region 'GRAVANDO MOVGPE'}
    prgProgresso.properties.Max := 1;
    prgProgresso.Position := 0;
    Result := Result and fGravarMovGPE;
    prgProgresso.Position := 1;
    Application.ProcessMessages;
    {$Endregion}

    {$Region 'GERAR PEDIDO REPOSICAO'}
    pFiltrarItensPedido;
    prgProgresso.properties.Max := 1;
    prgProgresso.Position := 0;
    Result := Result and fGravaPedidoVenda(ArrDocumentos);
    prgProgresso.Position := 1;
    Application.ProcessMessages;
    {$Endregion}

    If Result And blnTransacaoLocal And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    if Result and blnTransacaoLocal then
    begin
      Result := fCommit;
      blnTransacaoLocal := Not Result;
    end;

    {$Region 'Emissão de perda'}
    prgProgresso.properties.Max := 1;
    prgProgresso.Position := 0;
    pFiltrarAprovado;
    Result := Result and fTratarPerdaRefugados(ArrDocumentos);
    prgProgresso.Position := 1;
    Application.ProcessMessages;
    {$EndRegion}

    if Result Then
    begin
      stlGarantias := TStringList.Create;
      pFiltarSelecionados;
      cdsDados.First;
      While Not cdsDados.Eof do
      begin
        if stlGarantias.IndexOf(cdsDadosNUMENT.AsString) = -1 then
          stlGarantias.Add(cdsDadosNUMENT.AsString);
        cdsDados.Next;
      end;
    end;

  Finally
    if Result then
    begin
      pMensagemExibirDocumentos(ArrDocumentos, stlGarantias);
    end
    else
    begin
      if blnTransacaoLocal then
        fRollBack;
      pCancelar;
    end;

    if Assigned(stlGarantias) Then
      FreeAndNil(stlGarantias);

    pLimparFiltroDados;
    pLimparFiltroComponentes;
    cdsDados.EnableControls;
  End;

end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fTemItemSelecionado: boolean;
begin
  pFiltarSelecionados;
  Result := Not cdsDados.IsEmpty;
  pLimparFiltroDados;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fAplicarAvaliacaoGarantia: Boolean;
begin
  cdsDados.First;
  Result := True;
  while (Not cdsDados.Eof) and Result do
  begin
    Result := fAplicarAvaliacaoGarantia(cdsDadosAUTINC.AsString, cdsDadosQTDAPR.Asfloat, cdsDadosQTDREF.AsFloat);
    cdsDados.Next;
  end;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fTratarPerdaRefugados(Var ArrDocumentos: TArrDocumentos): Boolean;
  Var
    strAutInc, strNumDoc, strEspDoc: String;
begin
  if cdsDados.IsEmpty then
    Exit(true);

  Result :=  fGravaDocumentoSaida(strAutInc, strNumDoc, strEspDoc);
  if Result then
  begin
    cdsDados.First;
    while Not cdsDados.EOF do
    begin
      cdsDados.Edit;
      cdsDadosGPE_SEQBAI.AsString := strAutInc;
      cdsDados.post;
      cdsDados.Next;
    end;
    pGuardarDocumento(ArrDocumentos, strNumDoc, strEspDoc, strAutInc);
    fGravarMovGPE;
  end;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA CLIENTE                        *}
    {**************************************RL*}
    If Sender = edtCodCli Then
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
        Result := False;
      End

      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
          pSetFocus(edtCodCli);
          Result := False;
        End

        {*******************************************}
        {* CARREGA PRODUTOS DO CLIENTE             *}
        {****************************************RL*}
        Else
        Begin
          pLimparDados;
          pCarregarDados;
        End;

      End;




  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fValidarQuantidade(const fltQtdReq, fltQtd: Double; Out fltDif: Double): Boolean;
begin
  fltDif := fltQtdReq - fltQtd;
  Result := Not (fltDif < 0);
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fValorUnitarioItem: Double;
begin
  if cdsDadosVALENT.AsFloat <= 0 then
  begin
    if cdsDadosQTDREQ.AsFloat > 0 then
      Result := cdsDadosGAD_VALITE.AsFloat/cdsDadosQTDREQ.AsFloat
    else
      Result := cdsDadosGAD_VALITE.AsFloat;
  end
  else
    Result := cdsDadosVALENT.AsFloat;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fEscolherFinalidade: TFinalidade;
Const
  LARGURA_BTN: Integer = 350;
  LARGURA_MSG: integer = 800;

begin
  Result :=  TFinalidade(ord(fMensagem('Pergunta',
                                       'Qual ação sera tomada em relação à garantia aprovada?',
                                       ['&Aproveitamento de Produto',
                                        '&NF Emissão de Perda do produto com defeito'],
                                        1,
                                        false,            //blnSaiComEsc: Boolean = False;
                                        1,                //intEstFon: Integer = 1;
                                        LARGURA_BTN,      //intWidBut: Integer = 0;
                                        False,            //blnAutosize: Boolean = False;
                                        0,                //intSomarTop: Integer=0;
                                        false,            //blnObrigaEsc: Boolean = False;
                                        false,            //blnOcultPainelBtn: Boolean = False;
                                        True,             //blnBtnSemImg : Boolean = False;
                                        0,                //intHeightOpc: Integer = 0;
                                        LARGURA_MSG))); //intFormWidth: Integer = 0;

  if Result = TFinalidade.Aproveitamento then
  begin
    if fMensagem('Pergunta',
                  'Em relação a garantia aprovada, o que será aproveitado?',
                  ['&Aproveitamento de componentes da estrutura',
                   'Aproveitamento apenas do &produto acabado'],
                   1,
                   false,            //blnSaiComEsc: Boolean = False;
                   1,                //intEstFon: Integer = 1;
                   LARGURA_BTN,      //intWidBut: Integer = 0;
                   False,            //blnAutosize: Boolean = False;
                   0,                //intSomarTop: Integer=0;
                   false,            //blnObrigaEsc: Boolean = False;
                   false,            //blnOcultPainelBtn: Boolean = False;
                   True,             //blnBtnSemImg : Boolean = False;
                   0,                //intHeightOpc: Integer = 0;
                   LARGURA_MSG) = 2 then //intFormWidth: Integer = 0;
      Result := TFinalidade.ProdutoAcabado;
  end;
end;



function TfrmAvaliacaoGarantiaPropriaEmpresa.fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';
    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';
    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  M.MAR_DESMAR, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';

    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_PREDOL, ';

    strSQL := strSQL + '  IFNULL(  '+
                          ' (SELECT LOT_NUMLOT FROM CADLOT '+
                          '        WHERE '+
                          '            LOT_GARPRI = "S" '+
                          '        AND LOT_STATUS = "S" '+
                          '        AND LOT_CODITE = :CODITE '+
                          '        AND LOT_CODEMP = :CODEMP '+
                          ' ),"") AS ITE_NUMLOT, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    qryGenIte.Close;
    qryGenIte.SQL.Clear;
    qryGenIte.SQL.Add(strSQL);
    qryGenIte.ParamByName('CODITE').AsString := strCodIte;
    qryGenIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGenIte.ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
    qryGenIte.Open;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmGarantiaBaixaRefugo.fGetItem]');
    End;

  End;

end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  arrOpcoes[1].strDesCri := 'Faturamento Futuro';
  arrOpcoes[1].strEspDoc := 'FF';
  arrOpcoes[1].strOpcLet := 'F';
  arrOpcoes[1].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmAvaliacaoGarantiaPropriaEmpresa.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGravaDocumentoSaida(var strAutIncP, strNumDocP, strEspDocP: String): Boolean;
  Const
    NAO: String = 'N';
  var
    LfatVenda   : TFatVenda;
    strCodCli: String;
    strPrefixCFOP : String;
begin
  inherited;
  strCodCli := FClienteFilial;
  Result := True;

  If Not Result Then
    Exit;

  Try
    pCriarCdsVenda(Self);
    cdsVenda.EmptyDataSet;

    LfatVenda                := TFatVenda.CreateInstance('VN');
    LfatVenda.blnBaixaRefugo := true;
    LfatVenda.strOpcDocTrue  := 'OU';
    LfatVenda.blnVerEstOrc   := False;
    LfatVenda.strNomeForm    := 'frmFatVendas';
    LfatVenda.strMen001 := 'GARANTIA PROPRIA EMPRESA';
    LfatVenda.strMen002 := '';
    LfatVenda.strOpcDoc := 'OU';
    LfatVenda.strOriDoc := 'V';
    LfatVenda.strCodVen := strLoginUsuarioLogado;
    LfatVenda.strNomVen := fRetNomVendRep(LfatVenda.strCodVen);
    LfatVenda.strConPag := '01000';
    //LfatVenda.strCodForTe := edtCodFor.Text;

    pCarregarCliente(LfatVenda);

    Result := fIncluiItens(LfatVenda) And fGetTipoFaturamento(LfatVenda);

    If (Result) Then
    Begin
      LfatVenda.pCarregaAliquotasRetencao;

      LfatVenda.pPreencheMatrizFechamento;

      LfatVenda.pCalculaPesBruLiq;

      LfatVenda.pCalculaTotGer(False, False);

      If LfatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (LfatVenda.fltDesEsp <= 0.00) And (LfatVenda.fltIcmOrg > 0) Then
          LfatVenda.fltDesEsp := LfatVenda.fltIcmOrg;
      End;

      LfatVenda.pDestacaRetencoes;
      LfatVenda.pRetemImpostosNoDescontoEspecial;

      LfatVenda.pCalculaTotGer(False, False);

      LfatVenda.pCalculaTotGer;

      strPrefixCFOP := fObterPrefixoClaFis;

      LfatVenda.strClaFis := strPrefixCFOP + fCfgSis('CLAREF', varString);
      If (fRetCodEmpClienteFilial(strCodCli) = VS_strCodEmp) Then
        LfatVenda.strOpcDoc := 'TE';

      LfatVenda.strDesCla := fRetDesCla(LfatVenda.strClaFis);

      LfatVenda.pCalculaTotalParaCadRec;

      LfatVenda.pRateiaValores;

      if LfatVenda.strEspDoc = 'NF' then
      begin
        {$Region 'Tratamento para EspDoc = NF'}
        Try
          pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);

          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := LfatVenda.strClafis;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Text    := LfatVenda.strDesCla;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
          frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.cmbNatOpe.Enabled := False;
          frmFatDadosFiscais.blnForcaEdiBas    := True;
          frmFatDadosFiscais.fatVenda := LfatVenda;

          frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
          frmFatDadosFiscais.blnPodeCancelar := True;
          frmFatDadosFiscais.fraDadosFechamentoVendaMSGFatFrame.edtMens01.Enabled := False; //A observação 1 tem que ser fixa para baixar o Pedido de Compra e preencher o campo PCD_DOCEMI ao fazer a entrada na filial;
          frmFatDadosFiscais.blnBaixaRefugo := True;
          frmFatDadosFiscais.ShowModal;

          Result := frmFatDadosFiscais.blnConfirma;

        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        pFreeAndNil(frmFatDadosFiscais);
        {$Endregion}
      End
      Else Begin
        {$Region 'Tratamento para EspDoc <> NF'}
        Try
          pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
          frmObsGarantia.ShowModal;

          Result := frmObsGarantia.ModalResult = mrOk;

          If Result Then
          Begin
            LfatVenda.strMen002 := frmObsGarantia.edtObs1.Text;
            LfatVenda.strMen003 := frmObsGarantia.edtObs2.Text;
          End
          else
          Begin
            LfatVenda.strMen002 := '';
            LfatVenda.strMen003 := '';
          End;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        pFreeAndNil(frmObsGarantia);
        {$Endregion}
      End;

      If (Not Result) Then
      Begin
        fRollBack;
        Exit;
      End;
      {$Region 'Gravando documento'}
      Try
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.strChave            := 'FATFATURA';
        frmGravando.fExecutarAcao       := LfatVenda.fGravaArquivos;
        frmGravando.lblGravando.Caption := 'Aguarde, Gravando Retorno...';
        frmGravando.ShowModal;
        Result                          := frmGravando.blnConfirma;
        If Result Then
        Begin
          strAutIncP := LfatVenda.strAutInc;
          strNumDocP := LfatVenda.strNumDoc;
          strEspDocP := LfatVenda.strEspDoc;
        End;
        pFreeAndNil(frmGravando);

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
          pFreeAndNil(frmGravando);
        End;
      End;
      {$Endregion}
    End;

  Finally
    FreeAndNil(LfatVenda);
    pFreeCdsVenda;
  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGravaPedidoVenda(Var ArrDocumentos: TArrDocumentos): Boolean;
Var
  Pedido: TGarantiaPedido;
begin
  Result := False;
  Try
    Try
      Pedido := TGarantiaPedido.create(untGarantiaPropriaEmpresaTypes.TOrigemPedido.AvaliacaoGarantia);
      Pedido.pSetEnviarAutIncPedido(pReceberAutIncPedido);
      Pedido.pCarregarCFGs;
      Pedido.strCodEmp := VS_strCodEmp;
      Pedido.strCodCli := cdsDadosCODCLI.AsString;
      Pedido.strMen001 := Pedido.TAG_IDENTIFICACAO;
      Pedido.pgbStatus := Nil;
      Pedido.strCodVen := strLoginUsuarioLogado;
      Pedido.dtaDtaEnt := VS_Date;
      Pedido.dtaHorEnt := fTime();
      Pedido.strEstado := fRetEstadoCliente(Pedido.strCodCli);
      Pedido.strClaFis := fGetCFOPReposicaoPD(Pedido.strEstado);

      Result := Not fEmptyStr(Pedido.strClaFis);

      if Result and fIncluirItensPedido(Pedido) then
      begin
        Pedido.fltVlrCon := Pedido.fTotalProdutos;

        Result := Pedido.fGravarPedido;

        Result := Result and Pedido.fMarcarItensPedidoComoReposicaoGarantia;

        Result := REsult and Pedido.fGravarMovGPV;

        if Result then
          Pedido.pAtualizaDocReferenciado;
      end;
    Except
      On E: Exception do
      begin
        Result := False;
      end;
    End;
  Finally
    if Result then
      pGuardarDocumento(ArrDocumentos,Pedido.strNumDoc, Pedido.strEspDoc, Pedido.strAutInc);

    if Assigned(Pedido) then
      FreeAndNil(Pedido);
  End;

end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGravarMGPECO(
  const strAutInc: String): Boolean;
  Var
    Qry: TUniQuery;
    strSQLIns: String;
begin
  pFiltrarComponentesAproveitar;
  Qry := Nil;
  Result := True;
  Try
    strSQLIns := ' INSERT INTO MGPECO (AUTOINCREM, GPE_AUTINC, GPE_SEQAJC, GPE_ORIGEM, GPE_MOTIVO, GPE_DESTIN) ';
    strSQLIns := strSQLIns + ' VALUES (:AUTOINCREM, :GPE_AUTINC, :GPE_SEQAJC, :GPE_ORIGEM, :GPE_MOTIVO, :GPE_DESTIN) ';
    Qry := fCriaQuery;
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(strSQLIns);
    cdsComponentes.First;
    While Not cdsComponentes.Eof do
    begin
      Qry.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('MGPECO',VS_strCodEmp);
      Qry.ParamByName('GPE_AUTINC').AsString := strAutInc;
      Qry.ParamByName('GPE_SEQAJC').AsString := cdsComponentesINCAJU.AsString;
      Qry.ParamByName('GPE_ORIGEM').AsString := cdsComponentesORIGEM.AsString;
      Qry.ParamByName('GPE_MOTIVO').AsString := cdsComponentesMOTIVO.AsString;
      Qry.ParamByName('GPE_DESTIN').AsString := cdsComponentesDESTINO.AsString;
      Try
        Qry.Execute;
      Except
        On E: Exception do
        begin
          Result := False;
        end;
      End;
      cdsComponentes.Next;
    end;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
    cdsComponentes.Filtered := False;
    cdsComponentes.Filter := EmptyStr;
  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGravarMovGPE: Boolean;
Var
  Qry: TUniQuery;
  strAutInc: String;
begin
  Result := True;
  Try
    Qry := fCriaQuery;
    Try
      Qry.Sql.Clear;
      Qry.Sql.Add(' SELECT * FROM MOVGPE WHERE AUTOINCREM = :AUTINC ');
      pFiltarSelecionados;
      cdsDados.First;
      while (Not cdsDados.Eof) do
      begin
        if Qry.Active then
          Qry.Close;
        Qry.ParamByName('AUTINC').AsString := cdsDadosAutoincrem.AsString;
        Qry.Open;
        if Qry.IsEmpty then
        begin
          strAutInc := fRetAutoIncrem('MOVGPE', VS_strCodEmp);
          Qry.Append;
          Qry.FieldByName('AUTOINCREM').AsString := strAutInc;
          Qry.FieldByName('GPE_SEQGAD').AsString := cdsDadosAUTINC.AsString;
          cdsDados.Edit;
          cdsDadosAUTOINCREM.AsString := strAutInc;
          cdsDados.Post;
        end
        else
          Qry.Edit;

        Qry.FieldByName('GPE_QTDAPR').AsFloat := cdsDadosQTDAPR.AsFloat;
        Qry.FieldByName('GPE_QTDREF').AsFloat := cdsDadosQTDREF.AsFloat;

        if Not fEmptyStr(cdsDadosGPE_SEQBAI.AsString) then
          Qry.FieldByName('GPE_SEQBAI').AsString := cdsDadosGPE_SEQBAI.AsString;

        if Not fEmptyStr(cdsDadosGPE_SEQAJE.AsString) then
          Qry.FieldByName('GPE_SEQAJE').AsString := cdsDadosGPE_SEQAJE.AsString;
        Qry.Post;
        cdsDados.next;
      end;
      Result := Result and fGravarMGPECO(strAutInc);
    Finally
      Qry.Free;
    End;
  Except
    On E: Exception do
    begin
      Result := False;
    end;
  End;

end;


function TfrmAvaliacaoGarantiaPropriaEmpresa.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strIteDes   : String;
    fltPreEnv   : Double;
    cdsGroup    : TUniClientDataSet;
    fldQtd: TField;
Begin
  Try
    qryGenIte := fCriaQuery;
    cdsGroup  := TUniClientDataSet.Create(Self);
    cdsGroup.FieldDefs := cdsDados.FieldDefs;
    cdsGroup.CreateDataSet;
    cdsGroup.EmptyDataSet;

    cdsDados.DisableControls;
    cdsDados.First;

    cdsGroup.Close;
    cdsGroup.Open;
    fldQtd := cdsGroup.FieldByName('QTDAPR');
    While Not cdsDados.Eof Do
    Begin
      If Not cdsGroup.Locate('CODITE', cdsDados.FieldByName('CODITE').AsString, []) Then
      Begin
        cdsGroup.Insert;
        cdsGroup.FieldByName('CODITE').AsString := cdsdadosCodIte.AsString;
        cdsGroup.FieldByName('DESITE').AsString := cdsDados.FieldByName('DESITE').AsString;
        cdsGroup.FieldByName('SIGUNI').AsString := cdsDados.FieldByName('SIGUNI').AsString;
        cdsGroup.FieldByName('AUTINC').AsString := cdsDados.FieldByName('AUTINC').AsString;
        fldQtd.AsFloat  := cdsDados.FieldByName('QTDAPR').AsFloat;
        cdsGroup.Post;
      End
      Else
      Begin
        cdsGroup.Edit;
        fldQtd.AsFloat  := fldQtd.AsFloat + cdsDados.FieldByName('QTDAPR').AsFloat;
        cdsGroup.Post;
      End;
      cdsDados.Next;
    End;

    cdsDados.EnableControls;

    cdsGroup.DisableControls;

    fatVenda.fltDesEsp := 0;

    intContador := 0;
    cdsGroup.First;

    While Not cdsGroup.Eof Do
    Begin
      inc(intContador);

      If (intContador = 1) Then
      Begin
        fatVenda.strCodVen    := strLoginUsuarioLogado;
        fatVenda.strNomVen    := fRetNomVendRep(fatVenda.strCodVen);
      End;

      fGetItem(qryGenIte,cdsGroup.FieldByName('CODITE').AsString);

      strIteDes := qryGenIte.FieldByName('ITE_DESITE').AsString;

      fltPreEnv := qryGenIte.FieldByName('ITE_PRECUS').AsFloat;

      fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                           Nil,
                                           'NOR',
                                           qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                           cdsGroup.FieldByName('CODITE').AsString,
                                           qryGenIte.FieldByName('ITE_DESITE').AsString,
                                           strIteDes,
                                           qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                           qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                           qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                           qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                           qryGenIte.FieldByName('ITE_CODFOR').AsString,
                                           qryGenIte.FieldByName('ITE_REFERE').AsString,
                                           fltPreEnv, // fltUniOri
                                           fltPreEnv, // fltUniVis
                                           fltPreEnv, // fltUniTar
                                           0.0,
                                           0.0,
                                           fldQtd.AsFloat,
                                           fltPreEnv * fldQtd.AsFloat, // fltTotIte
                                           'S',
                                           qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltPreCus
                                           fFormataFloat(qryGenIte.FieldByName('ITE_PRECUS').AsFloat * fldQtd.AsFloat, 2), // fltTotCus
                                           qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                           qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                           qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                           0.0,
                                           qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                           'N',
                                           qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                           qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                           qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                           '',
                                           '',
                                           '',
                                           0,
                                           0,
                                           '',
                                           qryGenIte.FieldByName('ITE_PREULT').AsFloat * fldQtd.AsFloat,
                                           qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                           qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                           qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                           '',
                                           '',
                                           '',
                                           '',
                                           0,
                                           '',
                                           0,
                                           0,
                                           0.00,
                                           0.00,
                                           0.00,
                                           'N',
                                           '',
                                           0,
                                           0,
                                           qryGenIte.FieldByName('ABF_CODABF').AsString,
                                           qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                           qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                           'N',
                                           0,
                                           0,
                                           0,
                                           0,
                                           '',
                                           fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                           qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                           -1,
                                           0,
                                           '',
                                           '',
                                           '',
                                           qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                           qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                           qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                           fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                           '',
                                           0,
                                           0,
                                           '',
                                           '',
                                           '',
                                           0,
                                           '',
                                           '',
                                           '',
                                           qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                           fltPreEnv, // fltUniDig
                                           qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                           '',
                                           '',
                                           qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                           '',
                                           '',
                                           fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                           0.00,
                                           intContador,
                                           '',
                                           '',
                                           '',
                                           False,
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
                                           '',
                                           '',
                                           '1',
                                           qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                           qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                           '',
                                           0.0,
                                           '',
                                           0.0,
                                           'R',
                                           '',
                                           'N',
                                           '',
                                           0,
                                           fldQtd.AsFloat,
                                           0.0,
                                           0,
                                           qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                           '',
                                           0.00,
                                           0.00,
                                           0.00,
                                           0,
                                           0,
                                           0,
                                           0,
                                           0,
                                           recForTin,
                                           '',
                                           '',
                                           qryGenIte.FieldByName('ITE_NUMLOT').AsString,
                                           '',
                                           '',
                                           False,
                                           'N',
                                           'NOR',
                                           0,
                                           '',
                                           qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                           '',
                                           0,
                                           0,
                                           0,
                                           '',
                                           1,
                                           True,
                                           '',
                                           '',
                                           '',
                                           0,
                                           qryGenIte.FieldByName('ITE_PRECUS').AsFloat, // fltCusIte
                                           '',
                                           '',
                                           recMadeira,
                                           qryGenIte.FieldByName('ITE_IMPULT').AsFloat * fldQtd.AsFloat,
                                           0,
                                           0,
                                           cdsGroup.FieldByName('AUTINC').AsString);

      cdsGroup.Next;
    End;

    cdsGroup.EnableControls;

    Result := TRUE;

    FreeAndNil(qryGenIte);
    FreeAndNil(cdsGroup);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmAvaliacaoGarantiaPropriaEmpresa.fIncluiItens]');
    End;

  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fIncluirItensPedido(Pedido: TGarantiaPedido): Boolean;
Var
  aItem: TGarantiaPedidoItem;
  blnParar: Boolean;
  blnTemRefugo : Boolean;
  blnInclusaoItemRefugo: Boolean;
  fltQtdIte: Double;
  intCont: Integer;
  strNumLotSai : String;
  objCadLot : TCadLot;
begin
  objCadLot := Nil;
  Try
    objCadLot := TCadLot.Create(Nil);
    cdsDados.First;
    intCont := 0;
    while Not cdsDados.EOF do
    begin
      blnParar := False;
      blnTemRefugo := cdsDadosQtdRef.AsFloat > 0;
      blnInclusaoItemRefugo := blnTemRefugo and (cdsDadosQtdApr.AsFloat = 0) ;
      Repeat
        strNumLotSai := objCadLot.fRetArmazemPrincipalOrcamentoPedidoVenda(cdsDadosCODITE.AsString);

        aItem := Pedido.fAdicionarItem;

        if blnInclusaoItemRefugo then
        begin
          fltQtdIte  :=  cdsDadosQTDREF.AsFloat;
          aItem.strTipRep := F_REFUGAR;
        end
        else begin
          fltQtdIte  :=  cdsDadosQTDAPR.AsFloat;
          aItem.strTipRep := F_APROVAR;
        end;

        aItem.strCodIte  :=  cdsDadosCODITE.AsString;
        aItem.strCodMar  :=  cdsDadosITE_CODMAR.AsString;
        aItem.strDescri  :=  cdsDadosDesIte.AsString;
        aItem.strRefere  :=  cdsDadosITE_REFERE.AsString;
        aItem.strUnidad  :=  fRetUnidadeItem(aItem.strCodIte);
        aItem.strIdePro  :=  'NOR';
        aItem.strForIte  :=  FstrFornecedorFilial;
        aItem.fltQtdIte  :=  fltQtdIte;
        aItem.fltUnitar  :=  fValorUnitarioItem;
        aItem.fltUniOri  :=  aItem.fltUnitar;
        aItem.fltUniVis  :=  aItem.fltUnitar;
        aItem.fltTotIte  :=  aItem.fltUnitar * aItem.fltQtdIte;
        aItem.strCodRep  :=  fRetCodRepresCliente(fRetornaClienteFilial(aItem.Pedido.strCodEmp));
        aItem.fltUniDig  :=  aItem.fltUnitar;
        aItem.strNumLot  :=  strNumLotSai;
        aItem.fltQtdDev  :=  cdsDadosQTDREF.AsFloat;
        aItem.fltQtdPre  :=  cdsDadosQTDAPR.AsFloat;
        aItem.strSeqGad  :=  cdsDadosAUTINC.AsString;
        aItem.strNumLot  :=  strNumlotSai;
        aItem.fltQtdDevolvida :=  0;
        aItem.fltQtdPrejuizo  :=  0;

        if Not blnParar then
        begin
          if (blnTemRefugo) then
          begin
            blnParar := blnInclusaoItemRefugo;

            if Not blnParar then
              blnInclusaoItemRefugo := True;
          end
          else
          begin
            blnParar := True;
          end;
        end;

      Until blnParar;
      inc(intCont);
      cdsDados.Next;
    end;
  Finally
    if Assigned(objCadLot) then
      FreeAndNil(objCadLot);
  End;

  Result := intCont = cdsDAdos.RecordCount;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fObterPrefixoClaFis: String;
begin
  If SameText(FCliEst, fCadEmp('ESTADO')) Then
    Result := '5'
  Else
    Result := '6';
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  FPedidoReposicao.pLimpar;
  FClienteFilial := fRetornaClienteFilial(VS_strCodEmp);
  FCliEst :=  fRetEstadoCliente(FClienteFilial);
  FCodOpe := strLoginUsuarioLogado;
  FstrFornecedorFilial := fObterFornecedorFilial(VS_strCodEmp);
  pCriarTabelaDados;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

//  pCarregarDados;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10 : btnConfirmar.Click;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pAdicionarProdutoAcabadoAproveitamento(const fltQtdApr, fltQtdRef: Double);
begin
  cdsComponentes.Append;
  cdsComponentesINCGAD.AsString     :=  cdsDadosAUTINC.AsString;
  cdsComponentesCOMPONENTE.AsString :=  cdsDadosCODITE.AsString;
  cdsComponentesAPROVEITAR.AsFloat  :=  fltQtdApr;
  cdsComponentesREFUGAR.AsFloat     :=  fltQtdRef;
  cdsComponentesCUSTO.AsFloat       :=  cdsDadosGAD_VALITE.AsFloat;
  cdsComponentes.post;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pCancelar;
begin
  Try
    pFiltarSelecionados;
    TGarantiaPropriaEmpresaCancelamento.pExcluirOcorrenciaCRM(FPedidoReposicao.strAutInc);
    TGarantiaPropriaEmpresaCancelamento.fApagarPedido(FPedidoReposicao.strAutInc);
    cdsDados.First;
    while Not cdsDados.Eof do
    begin
      TGarantiaPropriaEmpresaCancelamento.fExcluirMovGPE(cdsDadosAutoincrem.AsString);
      if Not fEmptyStr(cdsDadosGPE_SEQAJE.AsString) then
        TGarantiaPropriaEmpresaCancelamento.fExcluirAjuste(cdsDadosGPE_SEQAJE.AsString);
      TGarantiaPropriaEmpresaCancelamento.fEstornarAvaliacaoGarantia(cdsDadosAutInc.AsString);
      cdsDados.Next;
    end;
  Except
    On E: Exception do
      pMensagensErro(E.Message, '[TfrmAvaliacaoGarantiaPropriaEmpresa.pCancelar]');
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pCarregarCliente(fatVenda: TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(FClienteFilial);
  fatVenda.strCodVen := strLoginUsuarioLogado;
  fatVenda.strCliCon := 'N';
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fSqlDados: String;
begin
  Result :=          ' SELECT G.GAG_NUMENT, G.GAG_DTAENT, G.GAG_CODCLI, C.CLI_NOMCLI, ';

  Result :=          ' SELECT G.GAG_NUMENT, G.GAG_DTAENT, G.GAG_CODCLI, C.CLI_NOMCLI, ';
  Result := Result +        ' D.AUTOINCREM, D.GAD_CODITE, D.GAD_QTDREQ, D.GAD_VALITE, ';
  Result := Result +        ' I.ITE_DESITE, I.ITE_CODFAB, I.ITE_CODMAR, I.ITE_REFERE, U.UNI_SIGUNI, ';
  Result := Result +        ' (D.GAD_QTDREQ - (IFNULL(D.GAD_QTDREF,0) + IFNULL(D.GAD_QTDRET,0))) AS "QTDREQ", ';

  Result := Result + ' IF(IFNULL(SUB.TOTALSUBITENS,0) = 0,"0","1") AS TEM_ESTRUTURA, PE.DET_UNITAR AS VALENT ';

  Result := Result + ' FROM  MOVGAG G ';
  Result := Result + ' JOIN CADCLI C ON C.CLI_CODCLI = G.GAG_CODCLI ';
  Result := Result + ' JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
  Result := Result + ' JOIN CADITE I ON I.ITE_CODITE = D.GAD_CODITE ';
  Result := Result + ' JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

  Result := Result + ' LEFT JOIN (SELECT G.GMT_CODEMP, G.GMT_CODITE,  COUNT(1) AS "TOTALSUBITENS" ';
  Result := Result +             ' FROM  GERMAT G ';
  Result := Result +             ' JOIN DETMAT D ON D.DMT_SEQGER = G.AUTOINCREM ';
  Result := Result +             ' GROUP BY 1,2) AS SUB ON SUB.GMT_CODEMP = G.GAG_CODEMP AND SUB.GMT_CODITE = D.GAD_CODITE ';

  Result := Result + ' LEFT JOIN (SELECT A.GRC_SEQGAD, B.DET_UNITAR ';
  Result := Result + '            FROM MOVGRC A ';
  Result := Result + '            JOIN MOVDET B ON B.AUTOINCREM = A.GRC_SEQDET ';
  Result := Result + '            WHERE A.GRC_OPCDOC IN ("NE","GA","DV","OE", "OU", "VN")) PE ON PE.GRC_SEQGAD = D.AUTOINCREM ';


  Result := Result + ' WHERE G.GAG_GARIND = ''S'' ';
  Result := Result +    ' AND D.GAD_QTDREQ - (IFNULL(D.GAD_QTDREF,0) + IFNULL(D.GAD_QTDRET,0) + IFNULL(D.GAD_QTDREP,0)) > 0 ';
  Result := Result +    ' AND G.GAG_CODEMP = :CODEMP ';
  Result := Result +    ' AND G.GAG_CODCLI = :CODCLI ';
  Result := Result + ' ORDER BY G.GAG_CODEMP, G.GAG_CODCLI, G.GAG_NUMENT, D.GAD_CODITE ';
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pCarregarDados;
Var
  Qry: TUniQuery;
begin
  Qry := Nil;
  Try
    cdsDadosQTDAPR.OnValidate := nil;
    cdsDadosQTDREF.OnValidate := Nil;

    Qry := fCriaQuery;
    Qry.sql.Clear;
    Qry.Sql.Add(fSqlDados);
    Qry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Qry.ParamByName('CODCLI').AsString := edtCodCli.Text;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      Qry.First;
      while Not Qry.Eof do
      begin
        cdsDados.Append;
        cdsDadosCODITE.AsString         := Qry.FieldByName('GAD_CODITE').AsString;
        cdsDadosDESITE.AsString         := Qry.FieldByName('ITE_DESITE').AsString;
        cdsDadosAUTINC.AsString         := Qry.FieldByName('AUTOINCREM').AsString;
        cdsDadosQTDREQ.AsFloat          := Qry.FieldByName('QTDREQ').AsFloat;
        cdsDadosCODCLI.AsString         := Qry.FieldByName('GAG_CODCLI').AsString;
        cdsDadosNOMCLI.AsString         := Qry.FieldByName('CLI_NOMCLI').AsString;
        cdsDadosNUMENT.AsString         := Qry.FieldByName('GAG_NUMENT').AsString;
        cdsDadosSIGUNI.AsString         := Qry.FieldByName('UNI_SIGUNI').AsString;
        cdsDadosTem_Estrutura.AsString  := Qry.FieldByName('TEM_ESTRUTURA').AsString;
        cdsDadosCODFAB.AsString         := Qry.FieldByName('ITE_CODFAB').AsString;
        cdsDadosITE_CODMAR.AsString     := Qry.FieldByName('ITE_CODMAR').AsString;
        cdsDadosITE_REFERE.AsString     := Qry.FieldByName('ITE_REFERE').AsString;
        cdsDadosGAD_VALITE.AsFloat      := Qry.FieldByName('GAD_VALITE').AsFloat;
        cdsDadosVALENT.AsFloat          := Qry.FieldByName('VALENT').AsFloat;
        cdsDadosAutoincrem.AsString     := EmptyStr;
        cdsDadosGPE_SEQBAI.AsString     := EmptyStr;
        cdsDadosGPE_SEQAJE.AsString     := EmptyStr;
        cdsDadosFinalidade.AsString     := EmptyStr;
        cdsDadosSelecionado.AsString    := NAO;
        cdsDadosQTDREF.AsFloat          := 0;
        cdsDadosQTDAPR.AsFloat          := 0;
        cdsDados.Post;
        Qry.Next;
      end;
    end;

    if cdsDados.IsEmpty then
      fMensagem('','Não foram encontrados dados',['&Ok']);
  Finally
    if Assigned(Qry) then
      Qry.Free;

    cdsDadosQTDAPR.OnValidate := cdsDadosQTDAPRValidate;
    cdsDadosQTDREF.OnValidate := cdsDadosQTDREFValidate;
  End;

end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pConfirmar;
var
  frmGravando : TFrmGravando;
  blnConfirmar: Boolean;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Gravando Informações!';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fConfirmar;
    frmGravando.ShowModal;
    blnConfirmar := frmGravando.blnConfirma;
    if blnConfirmar then
    begin
      fMensagem('Confirmação','Processo concluído com sucesso.',['&OK']);
      pLimparDados;
      pCarregarDados;
    end
    else
    begin
     fMensagem('Atenção!','Processo não concluído.',['&OK']);
    end;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pCriarTabelaDados;
begin
  if cdsDados.Active then
    cdsDados.Close;
  cdsDadosITE_REFERE.Size := fTamRefere;
  cdsDados.CreateDataSet;

  if cdsComponentes.Active then
    cdsComponentes.Close;
  cdsComponentes.CreateDataSet;
end;


procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pFiltarSelecionados;
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := ' SELECIONADO = ''1'' ';
  cdsDados.Filtered := True;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pFiltrarAprovado;
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := ' SELECIONADO = ''1'' AND QTDAPR > 0 ';
  cdsDados.Filtered := True;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pFiltrarComponentesAproveitar;
begin
 cdsComponentes.Filtered := False;
 cdsComponentes.Filter := ' APROVEITAR > 0 ';
 cdsComponentes.Filtered := True;
end;



procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pFiltrarItensPedido;
begin
  cdsDados.Filtered := False;
  cdsDados.Filter := ' SELECIONADO = ''1'' ';
  cdsDados.Filtered := True;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pGuardarDocumento(
  var ArrDocumentos: TArrDocumentos; strNumDoc, strEspDoc, strAutInc: String);
  Var
    recDocumento: TDocumento;
begin
  recDocumento.strNumDoc := strNumDoc;
  recDocumento.strEspDoc := strEspDoc;
  recDocumento.strAutInc := strAutInc;
  pGuardarDocumento(ArrDocumentos, recDocumento);
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pGuardarDocumento(var ArrDocumentos: TArrDocumentos; Documento: TDocumento);
begin
  SetLength(ArrDocumentos,length(ArrDocumentos)+1);
  ArrDocumentos[High(ArrDocumentos)].strAutInc := Documento.strAutInc;
  ArrDocumentos[High(ArrDocumentos)].strNumDoc := Documento.strNumDoc;
  ArrDocumentos[High(ArrDocumentos)].strEspDoc := Documento.strEspDoc;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pLimparComponentes(const strIncGad: String);
begin
  cdsComponentes.First;
  while Not cdsComponentes.Eof do
  begin
    if cdsComponentesINCGAD.AsString <> strIncGad then
    begin
      cdsComponentes.Next;
      Continue;
    end;
    cdsComponentes.Delete;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pLimparDados;
begin
  cdsDados.EmptyDataSet;
  cdsComponentes.EmptyDataSet;
  FPedidoReposicao.pLimpar;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pLimparFiltroDados;
begin
  cdsDados.Filter := EmptyStr;
  cdsDados.Filtered := False;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pLimparFiltroComponentes;
begin
  cdsComponentes.Filtered := False;
  cdsComponentes.Filter := EmptyStr;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pMarcarItem(const blnSelecionar: Boolean; blnTodos: Boolean);
begin
  if blnTodos then
  begin
    Try
      cdsDados.DisableControls;
      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        pMarcarItem(blnSelecionar);
        cdsDados.Next;
      End;
    Finally
      cdsDados.First;
      cdsDados.EnableControls;
    End;
  end
  else
  begin
    cdsDados.Edit;
    cdsDadosSELECIONADO.AsString := ifthen(blnSelecionar,SIM,NAO);
    cdsDados.post;
  end;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pMensagemExibirDocumentos(const arrDocumentos: TArrDocumentos; stlGarantias: TStrings);
Var
  strMsg : String;
  i: Integer;
begin
  if length(arrDocumentos) = 0 then
    Exit;

  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Documentos Gerados';
    frmMensagemExplicativa.mmoInstru.Font.Size := 12;
    frmMensagemExplicativa.mmoInstru.Font.Style := [];

    frmMensagemExplicativa.mmoInstru.Lines.Add('Documentos - Especie ');
    for i := 0 to Length(arrDocumentos) -1 do
    begin
      strMsg := StringOfChar(' ',2) + fConcatenar([arrDocumentos[i].strNumDoc, arrDocumentos[i].strEspDoc],'-');
      frmMensagemExplicativa.mmoInstru.Lines.Add(strMsg);
    end;
    frmMensagemExplicativa.mmoInstru.Lines.Add(sLineBreak);
    frmMensagemExplicativa.mmoInstru.Lines.Add('Garantias processadas:');
    for i := 0 to stlGarantias.Count -1 do
    begin
      strMsg :=  stlGarantias[i];
      if i = stlGarantias.Count -1 then
        strMsg := strMsg + '.'
      else
        strMsg := strMsg + ',';
      frmMensagemExplicativa.mmoInstru.Lines.Add(strMsg);
    end;

    frmMensagemExplicativa.ShowModal;
  Finally
    pFreeAndNil(frmMensagemExplicativa);
  End;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pMensagemQuantidadeInvalida;
begin
  fMensagem('Atenção','A soma de items aprovados e refugado não pode ser maior que a quantidade do item.',['&Ok']);
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pReceberAutIncPedido(strAutInc, strNumDoc, strEspDoc: String);
begin
  FPedidoReposicao.strAutInc := strAutInc;
  FPedidoReposicao.strNumDoc := strNumDoc;
  FPedidoReposicao.strEspDoc := strEspDoc;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pReceberComponente(Componente: TComponente);
begin
  if Componente.fltQtdApr <= 0 then
    Exit;

  cdsComponentes.Append;
  cdsComponentesINCGAD.AsString := cdsDadosAUTINC.AsString;
  cdsComponentesCOMPONENTE.AsString :=  Componente.strITESUB;
  cdsComponentesAPROVEITAR.AsFloat  :=  Componente.fltQtdApr;
  cdsComponentesREFUGAR.AsFloat     :=  Componente.fltQtdDis - Componente.fltQtdApr;
  cdsComponentesCUSTO.AsFloat       :=  Componente.fltCusIte;
  cdsComponentesORIGEM.AsString     :=  Componente.strOrigem;
  cdsComponentesMOTIVO.AsString     :=  Componente.strMotivo;
  cdsComponentesDESTINO.AsString    :=  Componente.strDestino;
  cdsComponentes.post;
end;

procedure TfrmAvaliacaoGarantiaPropriaEmpresa.pSelecionarItem;
Var
  blnMarcar: Boolean;
begin
  inherited;
  if Not cdsDados.IsEmpty then
  begin
    blnMarcar := Not (cdsDadosSelecionado.AsString = SIM);
    if blnMarcar then
    begin
      if (cdsDadosQTDREQ.AsFloat = (cdsDadosQTDAPR.AsFloat + cdsDadosQTDREF.AsFloat)) then
        pMarcarItem(blnMarcar)
      else
        fMensagem('Atenção','A soma de items aprovados e refugado de ser igual a quantidade do item.',['&Ok']);
    end
    else
        pMarcarItem(blnMarcar);
  end;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fTratarFinalidadeComponentes(const strCodIte: String; fltQtd: Double): Boolean;
begin
  Result := False;
  Try
    frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes := TfrmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.Create(Self);
    frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.pSetEnventoEnviarEnviarItensEstrutura(pReceberComponente);
    if frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.fPermitirIndicarFinalidade(strCodIte, fltQtd) then
    begin
      frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.ShowModal;
      Result := frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.ModalResult = mrOk;
    end
    else begin
      fMensagem('Atenção!','Não foi localizada estrutura para o produto, não pode haver aproveitamento.',['&OK']);
    end;
    frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes.Release;
  Finally
    if Assigned(frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes) then
    begin
      FreeAndNil(frmAvaliacaoGarantiaPropriaEmpresaFinalidadeComponentes);
    end;
  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fValidarQuantidade(Sender: TField; Out fltDif: Double): boolean;
begin
  if Not ((Sender.FieldName = cdsDadosQTDAPR.FieldName) or (Sender.FieldName = cdsDadosQTDREF.FieldName)) then
    Exit(False);

  Result :=  fValidarQuantidade(cdsDadosQtdReq.AsFloat, Sender.AsFloat, fltDif);
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fAplicarQuantidade(const fltQtdApr, fltQtdRef: Double): Boolean;
Var
  Finalidade: TFinalidade;
  blnTemEstrutura: Boolean;
begin
  Result := True;
  blnTemEstrutura :=  cdsDadosTem_Estrutura.AsString = SIM;
  Finalidade := TFinalidade.NaoDefinido;

  pLimparComponentes(cdsDadosAUTINC.AsString);
  Try
    cdsDadosQTDAPR.OnValidate := Nil;
    cdsDadosQTDREF.OnValidate := Nil;

    if fltQtdApr > 0 then
    begin
      if blnTemEstrutura then
        Finalidade := fEscolherFinalidade
      else
        Finalidade := TFinalidade.Perda;


      Case Finalidade of
        TFinalidade.Aproveitamento: fTratarFinalidadeComponentes(cdsDadosCODITE.AsString, fltQtdApr);
        TFinalidade.ProdutoAcabado: pAdicionarProdutoAcabadoAproveitamento(fltQtdApr,0);
      end;
    end;

    if Result then
    begin
      cdsDadosQTDAPR.AsFloat := fltQtdApr;
      cdsDadosQTDREF.AsFloat := fltQtdRef;
      cdsDadosSelecionado.AsString := SIM;
    end
    else
    begin
      Finalidade := TFinalidade.NaoDefinido;
      cdsDadosQTDAPR.AsFloat := 0;
      cdsDadosQTDREF.AsFloat := 0;
      cdsDadosSelecionado.AsString := NAO;
    end;
     cdsDadosFINALIDADE.AsString := Finalidade.fGetAsString;

  Finally
    cdsDadosQTDAPR.OnValidate := cdsDadosQTDAPRValidate;
    cdsDadosQTDREF.OnValidate := cdsDadosQTDREFValidate
  End;
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGetSqlCadIte: String;
begin
  Result := 'SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';
end;

function TfrmAvaliacaoGarantiaPropriaEmpresa.fGetSqlIteGer: String;
begin
  Result := 'SELECT G.*, C.ITE_CNV_ML ';
  Result := Result + ' FROM ITEGER G ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE G.ITE_CODITE = :CODITE AND G.ITE_CODEMP = :CODEMP ';
end;



{ TDocumentoRecord }

procedure TDocumentoRecord.pLimpar;
begin
  Self.strNumDoc := EmptyStr;
  Self.strEspDoc := EmptyStr;
  Self.strAutInc := Emptystr;
end;

end.

