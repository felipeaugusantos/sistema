unit untAjusteEstoqueFormulacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, MemoFocus, cxTextEdit, UniClientDataSet,
  untCadLote, System.StrUtils, untAuditoriaGravacaoSaldo;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

type
  TfrmAjusteEstoqueFormulacao = class(TfrmPaiSimples)
    pnlDados: TPanel;
    edtCliente: TEditFocus;
    lblCliente: TLabel;
    edtNomCli: TEditFocus;
    lblVendedor: TLabel;
    edtVendedor: TEditFocus;
    edtNomVen: TEditFocus;
    lblDigitador: TLabel;
    edtDigitador: TEditFocus;
    edtNomDig: TEditFocus;
    lblObservação: TLabel;
    pnlGrid: TPanel;
    cxgTblsAjuEstFor: TcxGridDBTableView;
    cxgAjuEstForLevel1: TcxGridLevel;
    cxgAjuEstFor: TcxGrid;
    tblCodigoItem: TcxGridDBColumn;
    tblColorantesBases: TcxGridDBColumn;
    tblQtdOriginal: TcxGridDBColumn;
    tblQtdAlterada: TcxGridDBColumn;
    tblDiferenca: TcxGridDBColumn;
    pnlBotoesAjustes: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    edtObservacao: TMemoFocus;
    pnlProgress: TPanel;
    pgbItens: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtDigitadorExit(Sender: TObject);
    procedure tblQtdAlteradaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure tblDiferencaPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    blnFecharTela: Boolean;
    qryFormul: TUniQuery;
    qryConIte: TUniQuery;
    qryConOpe: TUniQuery;
    qryConCit: TUniQuery;
    dtsFormul: TDataSource;
    dtsItem: TDataSource;
    cdsItem: TUniClientDataSet;
    objCadLot: TCadLot;

    strLote: String;
    strCodOpe: String;
    strPreAju: String;
    strImpAju: String;
    strNumDocAJ  : String;
    strNumDocML  : String;
    strAutInc: String;

    fltCusLot,
    fltIteSalMl,
    fltIteSaldos,
    fltValUni,
    fltTotGer: Double;

    intTamCod,
    intQtdReajuste : integer;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    {***************************************************}
    {*** PROCEDURES TEMPORARIAS CRIA/ATUALIZA/MOSTRA ***}
    {************************************************RG*}
    procedure pCriaTemporaria();
    procedure pCriaCdItem();
    procedure pDeletaTemporaria();
    procedure pMostrarFormulacoes();
    procedure pAtualizaTemporaria();
    function fAlterouBaseCorante(fltQuantidade: Double): Boolean;
    procedure pAddItem(strItem: String);
    function fRetornaValUnitario(): Double;
    function fTabPreco: String;
    function fTabPrecoImp: String;
    function fVerificaLote(strItem: String): Boolean;
    function fVerificaQtdEstoque(fltQtd: Double; strNumLot: String; blnProAca: Boolean; fltSalAca: Double): Boolean;
    function fSaldoLote(strCodIte, strCodEmp, strNumLot: String): Double;
    function fRetQtdDigitada(strNumLot: String): Double;
    Function fRetPrecoLote(strCodIte, strNumLot: String; Var fltCusLot: Double): Boolean;
    function fConfirmarAjuste():Boolean;
    procedure pFormataQuantidadeFormulacao();
    procedure pCarregaDigitador;
    function fRetDescricaoCatalisadorAdvanceTintosystems(strCodCol, strCfgExi: String; qryGen: TUniQuery; Var strCodIte: String): String;
    function fGetSqlIteGer(): String;
    function fGetNumeroLote: String;
    function fGravaGerFgoAjuste(strEspDoc: String): Boolean;
    procedure pDeletaItem();
    procedure pAtualiza();
    function fVerificaLoteCadastrado(): Boolean;
    function fGravaMovDetItems(): Boolean;
    function fGravaMovGerItems(): Boolean;
    function fDescricaoColorante(strCodCol: String; strLinha_: String; strCodIte: String; qryGen: TUniQuery): String;
    function fRetornaCodigoItem(strCodCol: String; strLinha_: String; qryGen: TUniQuery): String;
    procedure pVerificaTabelaFormulacao();
    function fProcessaFromSQL(): String;
    function fRetornaLinha(qryGen: TUniQuery): String;
    function fRetornaCodigoFormula(qryGen: TUniQuery; intContador: Integer): String;
    function fRetornaQuantFormula(qryGen: TUniQuery; IntContador: Integer): Double;
    function fVerificaFormulaVazia(strFormul: String): Boolean;
    function fRetornaValorDescricaoFormula(qryFormul: TUniQuery; strDescri: String; strCodIte: String): String;
    function fRetornaSaldos(qryConIte: TUniQuery; qryConCit: TUniQuery; strNumLot: String): Double;
    function fRetornaSaldosReservado(strCodIte: String; strNumLot: String; strCodEmp: String): Double;
    function fProcessaSaldo(fltQuantidade, fltSaldo: Double): Boolean;
    procedure pCarregaSelectConIte();
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strAutoincrem : String;
    strIdePro     : String;
    strEspDoc     : String;
    strCliente    : String;
    strNumDoc     : String;
    strOperador   : String;
    strDocumento  : String;
    strEmpresa    : String;
    strCodAca     : String;
    strEmpAca     : String;
    dtaDtaEnt     : TDateTime;
    blnAjuste     : Boolean;
    strItem       : String;


  end;

var
  frmAjusteEstoqueFormulacao: TfrmAjusteEstoqueFormulacao;

implementation

uses
  untFuncoesSimples, untFuncTinta, untTipoTinta, untPesqAux, untMovGer,
  untMsgLiberacao, untTypesSistema, untCadIte, untConstantes;

{$R *.dfm}

procedure TfrmAjusteEstoqueFormulacao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAjusteEstoqueFormulacao.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fMensagem('', 'Confirmar Gravação?', ['&Sim', '&Não']) = 1 Then
  Begin
    If fConfirmarAjuste Then
    Begin
      blnAjuste := True;
      fMensagem('', 'Gravação concluida com sucesso!', ['&Ok']);
    End;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.edtDigitadorExit(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(edtDigitador, True) Then
    pSetFocus(edtDigitador);
end;

function TfrmAjusteEstoqueFormulacao.fAlterouBaseCorante(
  fltQuantidade: Double): Boolean;
begin
  Result := True;

  If fltQuantidade <= 0 Then
    Result := False;
end;

function TfrmAjusteEstoqueFormulacao.fConfirmarAjuste: Boolean;
Var
  blnAjuGra   : Boolean;
  recServicos : TDadosServicos;
  strCliEst   : String;
  arrDuplic   : TarrDuplicata;
  strCodErrosAuditoria: String;
begin
  If Not fVerificaLoteCadastrado Then
  Begin
    Result := False;
    Exit;
  End;

  blnAjuGra := True;

  strCliEst := fRetEstadoCliente(strCliente);

  objAuditoriaSaldo.Limpar;

  fStartTransaction();

  Try
    pnlProgress.Visible := True;
    pgbItens.Visible := True;
    pgbItens.Max := cdsItem.RecordCount;

    strNumDocML := IIF(blnAjuGra, fRetSequencial('PRO_ML', VS_strCodEmp, fTamDocCadRec), EmptyStr);
    strNumDocAJ := fRetSequencial('PRO_AJ', VS_strCodEmp, fTamDocCadRec);

    If fEmptyStr(strCodOpe) Then
      strCodOpe := strLoginUsuarioLogado;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    {**************}
    {*GRAVA MOVGER*}
    {***********RG*}
    Result := fGravaMovGer(strAutInc,                                               // Auto Incremento (Retorno)
                           IIF(blnAjuGra, strNumDocML, strNUmDocAJ),                // Numero Documento
                           'ML',                                                    // Espécie
                           VS_strCodEmp,                                            // Empresa
                           '',                                                      // Transportadora
                           edtVendedor.Text,                                        // Vendedor
                           '',                                                      // Fornecedor
                           edtCliente.Text,                                         // Cliente
                           'C',                                                     // Tipo ((C)liente / (F)ornecedor)
                           dtaDtaEnt,                                               // Data da Entrada
                           fTime(),                                                 // Hora da Entrada
                           VS_Date,                                                 // Data do Documento
                           '01000',                                                 // Condição de Pagamento
                           strCliEst,                                               // Estado do Cliente / Fornecedor
                           '',                                                      // Nome do Consumidor
                           '',                                                      // Endereço do Consumidor
                           '',                                                      // Bairro do Consumidor
                           '',                                                      // Cep do Consumidor
                           '',                                                      // Cidade do Consumidor
                           '',                                                      // Estado do Consumidor
                           '',                                                      // Telefone do Consumidor
                           0,
                           '',                                                      // CNPJ / CGC
                           '',                                                      // CNPJ / CGC do consumidor
                           '',                                                      // Inscrição estadual do Consumidor
                           '',                                                      // RG do consumidor
                           0.0,                                                     // Base Simples Paulista
                           0.0,                                                     // Base de IPI
                           0.0,                                                     // Aliquota de IPI
                           0.0,                                                     // Total de IPI
                           0.0,                                                     // Base de ICMS
                           0.0,                                                     // Aliquota de ICMS
                           0.0,                                                     // Total de ICMS
                           0.0,                                                     // Valor de Substituição
                           0.0,                                                     // Aliquota de Substituição
                           0.0,                                                     // Base de Substituição
                           0.0,                                                     // Base de Substituição Simulada
                           0.0,                                                     // Desconto Especial
                           Abs(fltTotGer),                                          // Valor Contábil
                           Abs(fltTotGer),                                          // Total dos Itens
                           0.0,                                                     // Total de Custo
                           0.0,                                                     // Total Médio
                           '',                                                      // Tipo de Frete
                           0.0,                                                     // Valor do Frete
                           0.0,                                                     // Peso Bruto
                           0.0,                                                     // Peso Liquido
                           0.0,                                                     // Volume
                           '',                                                      // Especie
                           '',                                                      // Marca
                           edtObservacao.Text,                                      // Mensagem 1
                           '',                                                      // Mensagem 2
                           '',                                                      // Mensagem 3
                           '',                                                      // Mensagem 4
                           '',                                                      // Mensagem 5
                           blnAjuGra,                                               // Indica se Faturado ou nao
                           IIF(blnAjuGra, 'AJ', EmptyStr),                          // Tipo de Faturamento
                           IIF(blnAjuGra, strNumDocAJ, EmptyStr),                   // Numero de Faturamento
                           IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                  // Empresa dd Faturamento
                           IIF(blnAjuGra, VS_Date, 0),                              // Data de Faturamento
                           IIF(blnAjuGra, edtVendedor.Text, EmptyStr),              // Vendedor do Faturamento
                           IIF(blnAjuGra, '01000', EmptyStr),                       // Condição de Pagamento do Faturamento
                           False,                                                   // Devolução Especial
                           Abs(IIF(blnAjuGra, fltTotGer, 0.0)),                     // Valor do Faturamento
                           0.0,                                                     // Valor Parcela 01
                           0.0,                                                     // Valor Parcela 02
                           0.0,                                                     // Valor Parcela 03
                           0.0,                                                     // Valor Parcela 04
                           0.0,                                                     // Valor Parcela 05
                           0.0,                                                     // Valor Parcela 06
                           0.0,                                                     // Valor Parcela 07
                           0.0,                                                     // Valor Parcela 08
                           0.0,                                                     // Valor Parcela 09
                           0.0,                                                     // Valor Parcela 10
                           0.0,                                                     // Valor Parcela 11
                           0.0,                                                     // Valor Parcela 12
                           arrDuplic,
                           '',                                                      // Série
                           'N',                                                     // Nota Especial
                           '9999',                                                  // Classificação Fiscal 1
                           '',                                                      // Classificação Fiscal 2
                           '',                                                      // Classificação Fiscal 3
                           '',                                                      // Natureza da Operação
                           0.0,                                                     // Percentual de Desconto
                           strCodOpe,                                               // Codigo do Digitador
                           '',                                                      // Codigo da Condição
                           '',                                                      // Forma de Pagamento
                           0.0,                                                     // Fator para meia nota
                           recServicos,
                           0.0,                                                     // Despesa acessoria
                           '',                                                      // Origem do Documento (V)enda (D)evolução
                           'N',                                                     // Usa controle de entrega
                           '',                                                      // Representante
                           0.0,                                                     // Aliquota do IRPF (SERVIÇO)
                           0.0,                                                     // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                                     // Aliquota do Pis (SERVIÇO)
                           0.0,                                                     // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                                     // Aliquota do Cofins (SERVIÇO)
                           0.0,                                                     // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                                     // Aliquota do CSLL (SERVIÇO)
                           0.0,                                                     // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                                     // Valor de IRPF que foi retido
                           0.0,                                                     // Valor de PIS que foi retido
                           0.0,                                                     // Valor de COFINS que foi retido
                           0.0,                                                     // Valor de CSLL que foi retido
                           '',                                                      // Notas de Documentos Acumulados
                           0.0,                                                     // Aliquota do IRPF (PRODUTOS)
                           0.0,                                                     // Aliquota do PIS (PRODUTOS)
                           0.0,                                                     // Aliquota do COFINS (PRODUTOS)
                           0.0,                                                     // Aliquota do CSLL (PRODUTOS)
                           0.0,                                                     // Valor de SERVIÇO que foi retido
                           '',                                                      // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                                     // Percentual da Seguridade Social
                           0.0,                                                     // Valor da Seguridade Social
                           0.0,                                                     // Valor do IRPF Retido (Produto)
                           0.0,                                                     // Valor do IRPF Devido (Produto)
                           0.0,                                                     // Valor do IRPF Retido (Serviço)
                           0.0,                                                     // Valor do IRPF Devido (Serviço)
                           0.0,                                                     // Valor do PIS Retido (Produto)
                           0.0,                                                     // Valor do PIS Devido (Produto)
                           0.0,                                                     // Valor do PIS Retido (Serviço)
                           0.0,                                                     // Valor do PIS Devido (Serviço)
                           0.0,                                                     // Valor do COFINS Retido (Produto)
                           0.0,                                                     // Valor do COFINS Devido (Produto)
                           0.0,                                                     // Valor do COFINS Retido (Serviço)
                           0.0,                                                     // Valor do COFINS Devido (Serviço)
                           0.0,                                                     // Valor do CSLL Retido (Produto)
                           0.0,                                                     // Valor do CSLL Devido (Produto)
                           0.0,                                                     // Valor do CSLL Retido (Serviço)
                           0.0,                                                     // Valor do CSLL Devido (Serviço)
                           '',                                                      // Ordem de Produção
                           0.0,                                                     // Base Orgão Público
                           0.0,                                                     // ICMS Orgão Público
                           0,                                                       // Número do Conhecimento de Frete
                           '',                                                      // Consumidor final
                           'N',                                                     // Entrega no Faturamento
                           '',                                                      // Cliente de Faturamento
                           '',                                                      // Operador da Expedição
                           '',                                                      // Separador da Expedição
                           '',                                                      // Tabela de Preços utilizada
                           '',
                           'N',                                                     // Entrega Futura
                           False,                                                   // Baixa de Entrega Futura
                           0,                                                       // Margem de Lucro
                           0.0,                                                     // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                                     // Valor do retido considerando a base acima.
                           'N',                                                     // Gerar produção fora da loja
                           '',                                                      // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                                 // Data de Entrega no Romaneio
                           '',                                                      // Classificação fiscal 4
                           'N',                                                     // AUTO-SERVIÇO
                           '',                                                      // Evento
                           '',                                                      // AUTINC ENDEREÇO DE ENTREGA
                           '',                                                      // Conteúdo do CNFNFE
                           '',                                                      // Motivo da Devolução
                           '',
                           True);                                                   // Imprime Duplicatas na NF-e


    If Result Then
      objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

    qryConIte.Close;
    qryConIte.SQL.Clear;
    qryConIte.SQL.Add(fGetSqlIteGer);

    If Not fGravaMovDetItems() Then
      Result := False;

    pDeletaItem();

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
    Begin
      fCommit;
      pAtualiza;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fConfirmaAjuste]');
    End;
  End;

  pgbItens.Position := 0;
  pgbItens.Visible := False;
  pnlProgress.Visible := False;
end;

function TfrmAjusteEstoqueFormulacao.fDescricaoColorante(strCodCol,
  strLinha_: String; strCodIte: String; qryGen: TUniQuery): String;
Var
  strCodColRet,
  strDesCol,
  strCfgExi: String;
begin
  Result := '';

  strCfgExi := fCfgSis('EXIDOC');

  pRetItemEDescricaoColorante(strIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp, strLinha_);

  If (Not fEmptyStr(strDesCol)) Then
  Begin
    Result := strDesCol;
  End
  Else If (strIdePro = 'ADT') Then
  Begin
    //Catalisador da advance tintosystems fica no cadastro de bases
    Result := fRetDescricaoCatalisadorAdvanceTintosystems(strCodCol, strCfgExi, qryGen, strCodIte);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fGetNumeroLote: String;
begin
  Result := '';

  If fUsaRotinaWMS Then
  Begin
    If Assigned(objCadLot) Then
      Result := objCadLot.fRetLotePrincipalTintaMaquina(qryConIte.FieldByName('ITE_CODITE').AsString, Vs_strCodEmp);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fGetSqlIteGer: String;
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

function TfrmAjusteEstoqueFormulacao.fGravaGerFgoAjuste(
  strEspDoc: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  Try
    Result := False;

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;

    If Pos(strEspDoc, 'OR_PD_') > 0 Then
    Begin
      qryGen.SQL.Add('  SELECT * FROM FGOAJU    ');
      qryGen.Open;

      qryGen.Insert;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FGOAJU', VS_strCodEmp);
      qryGen.FieldByName('FGO_DOCGRI').AsString := strDocumento;
      qryGen.FieldByName('FGO_ESPGRI').AsString := strEspDoc;
      qryGen.FieldByName('FGO_EMPGRI').AsString := strEmpresa;
      qryGen.FieldByName('FGO_CLIGRI').AsString := strCliente;
      qryGen.FieldByName('FGO_CODITE').AsString := strItem;
      qryGen.FieldByName('FGO_CODACA').AsString := strCodAca;
      qryGen.FieldByName('FGO_EMPACA').AsString := strEmpAca;
      qryGen.FieldByName('FGO_SEQFGO').AsString := strNumDocAJ;
      qryGen.Post;

      Result := True;
    End
    Else
    Begin
      qryGen.SQL.Add('  SELECT * FROM GERAJU    ');
      qryGen.Open;

      qryGen.Insert;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GERAJU', VS_strCodEmp);
      qryGen.FieldByName('GER_DOCGRI').AsString := strDocumento;
      qryGen.FieldByName('GER_ESPGRI').AsString := strEspDoc;
      qryGen.FieldByName('GER_EMPGRI').AsString := strEmpresa;
      qryGen.FieldByName('GER_CLIGRI').AsString := strCliente;
      qryGen.FieldByName('GER_CODITE').AsString := strItem;
      qryGen.FieldByName('GER_CODACA').AsString := strCodAca;
      qryGen.FieldByName('GER_EMPACA').AsString := strEmpAca;
      qryGen.FieldByName('GER_SEQGER').AsString := strNumDocAJ;
      qryGen.Post;

      Result := True;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fGravaMovDetItems(): Boolean;
Var
  strClaFis : String;
  blnAjuGra: Boolean;
  fltCnv_Ml: Double;
  fltQtdSalMl: Double;
  strAutIncTmp: String;
  strCliEst: String;
begin
  blnAjuGra := True;

  Result := True;

  strCliEst := fRetEstadoCliente(strCliente);

  cdsItem.First;
  While (Not cdsItem.Eof) Do
  Begin
    strClaFis := '5999';

    qryConIte.Close;
    qryConIte.ParamByName('CODITE').AsString := cdsItem.FieldByName('ITE_CODITE').AsString;
    qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConIte.Open;

    fltCnv_Ml := IIF(blnAjuGra, qryConIte.FieldByName('ITE_CNV_ML').AsFloat, 1);

    strAutIncTmp := '';

    Result := fGravaMovDet(strAutIncTmp,                                              // Retorna Auto-Incremento por Referencia
                           strAutInc,                                                 // Sequencial do Arquivo Geral
                           IIF(blnAjuGra, strNumDocML, strNumDocAJ),                  // Numero Documento
                           'ML',                                                      // Espécie
                           VS_strCodEmp,                                              // Empresa
                           cdsItem.FieldByName('ITE_CODITE').AsString,                        // Cód. Item
                           edtVendedor.Text,                                          // Vendedor
                           '',                                                        // Código Diversos
                           cdsItem.FieldByName('ITE_CODMAR').AsString,                        // Código da Marca
                           '',                                                        // Fornecedor
                           edtCliente.Text,                                           // Cliente
                           dtaDtaEnt,                                                 // Data da Entrada
                           fTime(),                                                   // Hora da Entrada
                           VS_Date,                                                   // Data do Documento
                           '01000',                                                   // Condição de Pagamento
                           'C',                                                       // Tipo: (C)liente / (F) Fornecedor
                           strCliEst,                                                 // Estado do Fornecedor
                           cdsItem.FieldByName('ITE_DESITE').AsString,                        // Descrição do Item
                           cdsItem.FieldByName('ITE_REFERE').AsString,                        // Referência do Item
                           cdsItem.FieldByName('ITE_CODUNI').AsString,                        // Cód. Unidade
                           qryConCit.FieldByName('ITE_CODFOR').AsString,              // Fornecedor Item
                           cdsItem.FieldByName('ITE_QTDITE').AsFloat,                         // Quantidade do Item
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat,                         // Valor Unitario
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat,                         // Valor Unitário Original
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat,                         // Valor Unitário Original sem Juros
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // Total do Item
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // Valor Contábil do Item
                           (IIF(cdsItem.FieldByName('ITE_CUSLOT').AsFloat > 0,
                                  cdsItem.FieldByName('ITE_CUSLOT').AsFloat,
                                  qryConIte.FieldByName('ITE_PRECUS').AsFloat) / fltCnv_Ml) * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo
                           (qryConIte.FieldByName('ITE_PREMED').AsFloat / fltCnv_Ml) * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // Valor Total Medio
                           0.0,                                                       // % Desconto do Item
                           0.0,                                                       // Valor do Frete
                           0.0,                                                       // Valor do Desconto Especial
                           '',                                                        // Código do Representante
                           '',                                                        // Código do Vendedor 2
                           0.0,                                                       // Percentual de Comissão do Vendedor
                           0.0,                                                       // Total de Comissão do Vendedor
                           0.0,                                                       // Total de Comissão do Vendedor 2
                           strClaFis,                                                 // Classificação Fiscal
                           '',                                                        // Código Fiscal
                           0.0,                                                       // Valor IPI
                           0.0,                                                       // Aliquota IPI
                           0.0,                                                       // Base IPI
                           0.0,                                                       // Valor de ICMS
                           0.0,                                                       // Aliquota de ICMS
                           0.0,                                                       // Base de ICMS
                           0.0,                                                       // Valor de Substituição
                           0.0,                                                       // Aliquota de Substituição
                           0.0,                                                       // Base de Substituição
                           0.0,                                                       // Total de Peso
                           0.0,                                                       // Percentual de Base de ICMS
                           0.0,                                                       // Percentual de Redução de Base
                           blnAjuGra,                                                 // Indica se ja esta Faturado
                           IIF(blnAjuGra, 'AJ', EmptyStr),                            // Tipo de Faturamento
                           IIF(blnAjuGra, strNumDocAJ, EmptyStr),                     // Numero de Faturamento
                           IIF(blnAjuGra, VS_strCodEmp, EmptyStr),                    // Empresa dd Faturamento
                           IIF(blnAjuGra, VS_Date, 0),                                // Data de Faturamento
                           IIF(blnAjuGra, edtVendedor.Text, EmptyStr),                // Vendedor do Faturamento
                           '01000',                         // Condição de Pagamento do Faturamento
                           Abs(IIF(blnAjuGra, fltTotGer, 0.0)),                       // Valor do Faturamento
                           'NOR',                                                     // Identificação Produto ( Normal / Outros )
                           qryConCit.FieldByName('ITE_INCPIS').AsString,              // Indice se incide Pis
                           '',                                                        // Série
                           0.0,                                                       // Valor de Despesa Acessória
                           'N',                                                       // Nota Especial
                           '',                                                        // Documento da Devolução
                           '',                                                        // Espécie da Devolução
                           '',                                                        // Empresa da Devolução
                           '',                                                        // Item de Chamada (TINTA DE MAQUINA)
                           '',                                                        // Item da Tinta (TINTA DE MAQUINA)
                           '',                                                        // Descrição da Cor (TINTA DE MAQUINA)
                           '',                                                        // Tipo de Embalagem (TINTA DE MAQUINA)
                           0.0,                                                       // Quantidade de Embalagem (TINTA DE MAQUINA)
                           0.0,                                                       // Preço da Embalagem (TINTA DE MAQUINA)
                           '',                                                        // Tipo de Preço (TINTA DE MAQUINA)
                           0.0,                                                       // Preço de Venda da Tinta (TINTA DE MAQUINA)
                           0.0,                                                       // Preço de Compra da Tinta (TINTA DE MAQUINA)
                           0.0,                                                       // Fator da Tinta (TINTA DE MAQUINA)
                           '',                                                        // Produto Embalagem (TINTA DE MAQUINA)
                           strCodOpe,                                                 // Código do Digitador
                           '',                                                        // Codigo da Condição
                           '',                                                        // Forma de Pagamento
                           '',                                                        // Item da Embalagem
                           '',                                                        // Grupo do Item da Embalagem
                           0,                                                         // Quarto da Lazzumiz
                           'N',                                                       // É item em promoção?
                           '',                                                        // Tipo de Tinta
                           0.0,                                                       // Quantidade de Pulsos
                           '',                                                        // Número do pedido de compras
                           '',                                                        // Origem do documento
                           '',                                                        // Pedido de Venda - Número
                           '',                                                        // Pedido de Venda - Espécie
                           '',                                                        // Pedido de Venda - Empresa
                           0,                                                         // Pedido de Venda - Sequencial
                           '',                                                        // Ordem de Produção
                           '',
                           '',
                           0,
                           0,
                           0.0,                                                       // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                           cdsItem.FieldByName('ITE_CODACA').AsString,
                           cdsItem.FieldByName('ITE_EMPACA').AsString,
                           Not fEmptyStr(cdsItem.FieldByName('ITE_CODACA').AsString),         // PROD ACABADO
                           Not fEmptyStr(cdsItem.FieldByName('ITE_CODACA').AsString),         // FILKAR
                           '',
                           '',
                           '',
                           '',
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

                           (IIF(cdsItem.FieldByName('ITE_CUSLOT').AsFloat > 0,
                                  cdsItem.FieldByName('ITE_CUSLOT').AsFloat,
                                  qryConIte.FieldByName('ITE_PRECUS').AsFloat) / fltCnv_Ml) * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // Valor Total de Custo 2
                           0,
                           0,
                           '',
                           cdsItem.FieldByName('ITE_NUMLOT').AsString,
                           'N',
                           0,
                           0,
                           0,
                           (qryConIte.FieldByName('ITE_PREULT').AsFloat / fltCnv_Ml) * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // fltTotUlt
                           (qryConIte.FieldByName('ITE_IMPULT').AsFloat / fltCnv_Ml) * cdsItem.FieldByName('ITE_QTDITE').AsFloat, // fltImpUlt
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
                           cdsItem.FieldByName('ITE_UNITAR').AsFloat * cdsItem.FieldByName('ITE_QTDITE').AsFloat);  // fltOutIcm

    If Not Result Then
      Break;

    ReprocessarItem(cdsItem.FieldByName('ITE_CODITE').AsString, '', False);

    If Not fGravaMovGerItems Then
      Break;

    {*****************************************}
    {* ATUALIZA O ESTOQUE DO ITEM, DE ACORDO *}
    {* COM O TIPO DE MOVIMENTAÇÃO (S)        *}
    {**************************************RG*}
    fltQtdSalMl := cdsItem.FieldByName('ITE_QTDITE').AsFloat;

    Result := fAtualizaEstoqueML(cdsItem.FieldByName('ITE_CODITE').AsString, fltQtdSalMl, cdsItem.FieldByName('ITE_NUMLOT').AsString);

    If Not Result Then
      Break;

    Result := fGravaGerFgoAjuste(strEspDoc);

    If Not Result Then
      Break;

    pgbItens.StepBy(1);
    cdsItem.Next;
  End;
end;

function TfrmAjusteEstoqueFormulacao.fGravaMovGerItems: Boolean;
Var
  blnGerouTM: Boolean;
  strNumDocTM : String;
  strAutIncTM : String;
  strCliEst: String;
  blnAjuGra: Boolean;
  recServicos : TDadosServicos;
  arrDuplic   : TarrDuplicata;
  strAutIncTmp: String;
begin
  Result := True;

  blnGerouTM := False;
  blnAjuGra := True;

  strCliEst := fRetEstadoCliente(strCliente);

  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  If (cdsItem.FieldByName('ITE_QTDITE').AsFloat > qryConIte.FieldByName('ITE_SAL_ML').AsFloat) Then
  Begin
    If (Not (blnGerouTM)) Then
    Begin
      strNumDocTM := fRetSequencial('PRO_TM');

      strAutIncTM := fstrEspaco(' ', 20);

      Result := fGravaMovGer(strAutIncTM,                                   // Auto Incremento (Retorno)
                             strNumDocTM,                                   // Numero Documento
                             'TM',                                          // Espécie
                             VS_strCodEmp,                                  // Empresa
                             '',                                            // Transportadora
                             edtVendedor.Text,                              // Vendedor
                             '',                                            // Fornecedor
                             edtCliente.Text,                               // Cliente
                             'C',                                           // Tipo ((C)liente / (F)ornecedor)
                             dtaDtaEnt,                                     // Data da Entrada
                             fTime(),                                       // Hora da Entrada
                             VS_Date,                                       // Data do Documento
                             '01000',                                       // Condição de Pagamento
                             strCliEst,                                     // Estado do Cliente / Fornecedor
                             '',                                            // Nome do Consumidor
                             '',                                            // Endereço do Consumidor
                             '',                                            // Bairro do Consumidor
                             '',                                            // Cep do Consumidor
                             '',                                            // Cidade do Consumidor
                             '',                                            // Estado do Consumidor
                             '',                                            // Telefone do Consumidor
                             0,
                             '',                                            // CNPJ / CGC
                             '',                                            // CNPJ / CGC do consumidor
                             '',                                            // Inscrição estadual do Consumidor
                             '',                                            // RG do consumidor
                             0.0,                                           // Base Simples Paulista
                             0.0,                                           // Base de IPI
                             0.0,                                           // Aliquota de IPI
                             0.0,                                           // Total de IPI
                             0.0,                                           // Base de ICMS
                             0.0,                                           // Aliquota de ICMS
                             0.0,                                           // Total de ICMS
                             0.0,                                           // Valor de Substituição
                             0.0,                                           // Aliquota de Substituição
                             0.0,                                           // Base de Substituição
                             0.0,                                           // Base de Substituição Simulada
                             0.0,                                           // Desconto Especial
                             intQtdReajuste,                                // Valor Contábil
                             intQtdReajuste,                                // Total dos Itens
                             0.0,                                           // Total de Custo
                             0.0,                                           // Total Médio
                             '',                                            // Tipo de Frete
                             0.0,                                           // Valor do Frete
                             0.0,                                           // Peso Bruto
                             0.0,                                           // Peso Liquido
                             0.0,                                           // Volume
                             '',                                            // Especie
                             '',                                            // Marca
                             edtObservacao.Text,                            // Mensagem 1
                             '',                                            // Mensagem 2
                             '',                                            // Mensagem 3
                             '',                                            // Mensagem 4
                             '',                                            // Mensagem 5
                             False,                                         // Indica se Faturado ou nao
                             IIF(blnAjuGra, 'AJ', EmptyStr),                // Tipo de Faturamento
                             IIF(blnAjuGra, strNumDocAJ, EmptyStr),         // Numero de Faturamento
                             IIF(blnAjuGra, VS_strCodEmp, EmptyStr),        // Empresa dd Faturamento
                             IIF(blnAjuGra, VS_Date, 0),                    // Data de Faturamento
                             IIF(blnAjuGra, edtVendedor.Text, EmptyStr),    // Vendedor do Faturamento
                             IIF(blnAJuGra, '01000', EmptyStr),             // Condição de Pagamento do Faturamento
                             False,                                         // Devolução Especial
                             0.0,                                           //Valor do Faturamento
                             0.0,                                           // Valor Parcela 01
                             0.0,                                           // Valor Parcela 02
                             0.0,                                           // Valor Parcela 03
                             0.0,                                           // Valor Parcela 04
                             0.0,                                           // Valor Parcela 05
                             0.0,                                           // Valor Parcela 06
                             0.0,                                           // Valor Parcela 07
                             0.0,                                           // Valor Parcela 08
                             0.0,                                           // Valor Parcela 09
                             0.0,                                           // Valor Parcela 10
                             0.0,                                           // Valor Parcela 11
                             0.0,                                           // Valor Parcela 12
                             arrDuplic,
                             '',                                            // Série
                             'N',                                           // Nota Especial
                             '5999',                                        // Classificação Fiscal 1
                             '',                                            // Classificação Fiscal 2
                             '',                                            // Classificação Fiscal 3
                             '',                                            // Natureza da Operação
                             0.0,                                           // Percentual de Desconto
                             strCodOpe,                                     // Codigo do Digitador
                             '',                                            // Codigo da Condição
                             '',                                            // Forma de Pagamento
                             0.0,                                           // Fator para meia nota
                             recServicos,
                             0.0,                                           // Despesa acessoria
                             '',                                            // Origem do Documento (V)enda (D)evolução
                             'N',                                           // Usa controle de entrega
                             '',                                            // Representante
                             0.0,                                           // Aliquota do IRPF (SERVIÇO)
                             0.0,                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                             0.0,                                           // Aliquota do Pis (SERVIÇO)
                             0.0,                                           // Valor do Pis (SERVIÇO + PRODUTO)
                             0.0,                                           // Aliquota do Cofins (SERVIÇO)
                             0.0,                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                             0.0,                                           // Aliquota do CSLL (SERVIÇO)
                             0.0,                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                             0.0,                                           // Valor de IRPF que foi retido
                             0.0,                                           // Valor de PIS que foi retido
                             0.0,                                           // Valor de COFINS que foi retido
                             0.0,                                           // Valor de CSLL que foi retido
                             '',                                            // Notas de Documentos Acumulados
                             0.0,                                           // Aliquota do IRPF (PRODUTOS)
                             0.0,                                           // Aliquota do PIS (PRODUTOS)
                             0.0,                                           // Aliquota do COFINS (PRODUTOS)
                             0.0,                                           // Aliquota do CSLL (PRODUTOS)
                             0.0,                                           // Valor de SERVIÇO que foi retido
                             '',                                            // Notas de documentos acumulados (SERVIÇO)
                             0.0,                                           // Percentual da Seguridade Social
                             0.0,                                           // Valor da Seguridade Social
                             0.0,                                           // Valor do IRPF Retido (Produto)
                             0.0,                                           // Valor do IRPF Devido (Produto)
                             0.0,                                           // Valor do IRPF Retido (Serviço)
                             0.0,                                           // Valor do IRPF Devido (Serviço)
                             0.0,                                           // Valor do PIS Retido (Produto)
                             0.0,                                           // Valor do PIS Devido (Produto)
                             0.0,                                           // Valor do PIS Retido (Serviço)
                             0.0,                                           // Valor do PIS Devido (Serviço)
                             0.0,                                           // Valor do COFINS Retido (Produto)
                             0.0,                                           // Valor do COFINS Devido (Produto)
                             0.0,                                           // Valor do COFINS Retido (Serviço)
                             0.0,                                           // Valor do COFINS Devido (Serviço)
                             0.0,                                           // Valor do CSLL Retido (Produto)
                             0.0,                                           // Valor do CSLL Devido (Produto)
                             0.0,                                           // Valor do CSLL Retido (Serviço)
                             0.0,                                           // Valor do CSLL Devido (Serviço)
                             '',                                            // Ordem de Produção
                             0.0,                                           // Base Orgão Público
                             0.0,                                           // ICMS Orgão Público
                             0,                                             // Número do Conhecimento de Frete
                             '',                                            // Consumidor final
                             'N',                                           // Entrega no Faturamento
                             '',                                            // Cliente de Faturamento
                             '',                                            // Operador da Expedição
                             '',                                            // Separador da Expedição
                             '',                                            // Tabela de Preços utilizada
                             '',
                             'N',                                           // Entrega Futura
                             False,                                         // Baixa de Entrega Futura
                             0,                                             // Margem de Lucro
                             0.0,                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,                                           // Valor do retido considerando a base acima.
                             'N',                                           // Gerar produção fora da loja
                             '',                                            // Numero do Registro - Correios ou Transportadora
                             VS_Date,                                       // Data de Entrega no Romaneio
                             '',                                            // Classificação fiscal 4
                             'N',                                           // AUTO-SERVIÇO
                             '',                                            // Evento
                             '',                                            // AUTINC ENDEREÇO DE ENTREGA
                             '',                                            // Conteúdo do CNFNFE
                             '',                                            // Motivo da Devolução
                             '',
                             True);                                         // Imprime Duplicatas na NF-e

      blnGerouTM := Result;

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutIncTM, 'MOVGER');
    End;

    If (blnGerouTM) Then
    Begin
      intQtdReajuste := 0;
      fltIteSaldos   := 0;

      fltIteSalMl := qryConIte.FieldByName('ITE_SAL_ML').AsFloat;

      While cdsItem.FieldByName('ITE_QTDITE').AsFloat > fltIteSalMl Do
      Begin
        Inc(intQtdReajuste);

        fltIteSalMl := fltIteSalMl + (qryConIte.FieldByName('ITE_CNV_ML').AsFloat);
        fltIteSaldos := (qryConIte.FieldByName('ITE_SALDOS').AsFloat - intQtdReajuste);
      End;

      qryConIte.Edit;
      qryConIte.FieldByName('ITE_SAL_ML').AsFloat := fltIteSalMl;
      qryConIte.FieldByName('ITE_SALDOS').AsFloat := fltIteSaldos;
      qryConIte.Post;

      strAutIncTmp := fstrEspaco(' ', 20);

      Result := fGravaMovDet(strAutIncTmp,
                             strAutIncTM,
                             strNumDocTM,
                             'TM',
                             VS_strCodEmp,                                      // Empresa
                             cdsItem.FieldByName('ITE_CODITE').AsString,                // Cód. Item
                             edtVendedor.Text,                                  // Vendedor
                             '',                                                // Código Diversos
                             cdsItem.FieldByName('ITE_CODMAR').AsString,                // Código da Marca
                             '',                                                // Fornecedor
                             edtCliente.Text,                                   // Cliente
                             dtaDtaEnt,                                         // Data da Entrada
                             fTime(),                                           // Hora da Entrada
                             VS_Date,                                           // Data do Documento
                             '01000',                                           // Condição de Pagamento
                             'C',                                               // Tipo: (C)liente / (F) Fornecedor
                             strCliEst,                                         // Estado do Fornecedor
                             cdsItem.FieldByName('ITE_DESITE').AsString,                // Descrição do Item
                             cdsItem.FieldByName('ITE_REFERE').AsString,                // Referência do Item
                             cdsItem.FieldByName('ITE_CODUNI').AsString,                // Cód. Unidade
                             qryConCit.FieldByName('ITE_CODFOR').AsString,      // Fornecedor Item
                             intQtdReajuste,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,                                               // % Desconto do Item
                             0.0,                                               // Valor do Frete
                             0.0,                                               // Valor do Desconto Especial
                             '',                                                // Código do Representante
                             '',                                                // Código do Vendedor 2
                             0.0,                                               // Percentual de Comissão do Vendedor
                             0.0,                                               // Total de Comissão do Vendedor
                             0.0,                                               // Total de Comissão do Vendedor 2
                             '5999',                                            // Classificação Fiscal
                             '',                                                // Código Fiscal
                             0.0,                                               // Valor IPI
                             0.0,                                               // Aliquota IPI
                             0.0,                                               // Base IPI
                             0.0,                                               // Valor de ICMS
                             0.0,                                               // Aliquota de ICMS
                             0.0,                                               // Base de ICMS
                             0.0,                                               // Valor de Substituição
                             0.0,                                               // Aliquota de Substituição
                             0.0,                                               // Base de Substituição
                             0.0,                                               // Total de Peso
                             0.0,                                               // Percentual de Base de ICMS
                             0.0,                                               // Percentual de Redução de Base
                             False,                                             // Indica se ja esta Faturado
                             IIF(blnAjuGra, 'AJ', EmptyStr),                    // Tipo de Faturamento
                             IIF(blnAjuGra, strNumDocAJ, EmptyStr),             // Numero de Faturamento
                             IIF(blnAjuGra, VS_strCodEmp, EmptyStr),            // Empresa dd Faturamento
                             IIF(blnAjuGra, VS_Date, 0),                        // Data de Faturamento
                             IIF(blnAjuGra, edtVendedor.Text, EmptyStr),        // Vendedor do Faturamento
                             IIF(blnAjuGra, '01000', EmptyStr),                 // Condição de Pagamento do Faturamento
                             0.0,                                               // Valor do Faturamento
                             'NOR',                                             // Identificação Produto ( Normal / Outros )
                             qryConCit.FieldByName('ITE_INCPIS').AsString,      // Indice se incide Pis
                             '',                                                // Série
                             0.0,                                               // Valor de Despesa Acessória
                             'N',                                               // Nota Especial
                             '',                                                // Documento da Devolução
                             '',                                                // Espécie da Devolução
                             '',                                                // Empresa da Devolução
                             '',                                                // Item de Chamada (TINTA DE MAQUINA)
                             '',                                                // Item da Tinta (TINTA DE MAQUINA)
                             '',                                                // Descrição da Cor (TINTA DE MAQUINA)
                             '',                                                // Tipo de Embalagem (TINTA DE MAQUINA)
                             0.0,                                               // Quantidade de Embalagem (TINTA DE MAQUINA)
                             0.0,                                               // Preço da Embalagem (TINTA DE MAQUINA)
                             '',                                                // Tipo de Preço (TINTA DE MAQUINA)
                             0.0,                                               // Preço de Venda da Tinta (TINTA DE MAQUINA)
                             0.0,                                               // Preço de Compra da Tinta (TINTA DE MAQUINA)
                             0.0,                                               // Fator da Tinta (TINTA DE MAQUINA)
                             '',                                                // Produto Embalagem (TINTA DE MAQUINA)
                             strCodOpe,                                         // Código do Digitador
                             '',                                                // Codigo da Condição
                             '',                                                // Forma de Pagamento
                             '',                                                // Item da Embalagem
                             '',                                                // Grupo do Item da Embalagem
                             0,                                                 // Quarto da Lazzumiz
                             'N',                                               // É item em promoção?
                             '',                                                // Tipo de Tinta
                             0.0,                                               // Quantidade de Pulsos
                             '',                                                // Número do pedido de compras
                             '',                                                // Origem do documento
                             '',                                                // Pedido de Venda - Número
                             '',                                                // Pedido de Venda - Espécie
                             '',                                                // Pedido de Venda - Empresa
                             0,                                                 // Pedido de Venda - Sequencial
                             '',                                                // Ordem de Produção
                             '',                                                // Descrição para Nota Fiscal Especial
                             '',
                             0,
                             0,
                             0.0,                                               // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                             '',
                             '',
                             False,
                             True,
                             '',
                             '',
                             '',
                             '',
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
                             fGetNumeroLote,
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
                             0);

    End;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria();

  If Assigned(dtsFormul) Then
    FreeAndNil(dtsFormul);

  If Assigned(qryFormul) Then
    FreeAndNil(qryFormul);

  If Assigned(qryConOpe) Then
    FreeAndNil(qryConOpe);

  If Assigned(qryConCit) Then
    FreeAndNil(qryConCit);

  If Assigned(qryConIte) Then
    FreeAndNil(qryConIte);

  If Assigned(cdsItem) Then
    FreeAndNil(cdsItem);
end;

procedure TfrmAjusteEstoqueFormulacao.FormCreate(Sender: TObject);
begin
  inherited;
  strLote := '';
  blnFecharTela := False;
  intTamCod := fTamCodIte;
  qryFormul := fCriaQuery(Self);
  dtsFormul := fCriaDataSource(qryFormul);
  cxgTblsAjuEstFor.DataController.DataSource := dtsFormul;

  objCadLot := TCadLot.Create(Self);

  edtCliente.Text := fCfgSis('CLIAJU');
  edtNomCli.Text := fRetNomCliente(edtCliente.Text);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryConCit := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConIte := fCriaQuery(Self);

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  If fEmptyStr(edtNomCli.Text) Then
  Begin
    fMensagem('', 'O Cliente configurado para o ajuste de estoque não está cadastrado no sistema. ' +
                  'Por favor verifique.', ['&Ok']);
    blnFecharTela := True;
    Exit;
  End;

  strPreAju := fCfgSis('PREAJU');
  strImpAju := fCfgSis('IMPAJU');

  pCriaCdItem();
end;

procedure TfrmAjusteEstoqueFormulacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirmar.Click
  Else If (Key = VK_ESCAPE) Then
    btnCancelar.Click;
end;

procedure TfrmAjusteEstoqueFormulacao.FormPaint(Sender: TObject);
begin
  inherited;

  If blnFecharTela Then
    Close;
end;

procedure TfrmAjusteEstoqueFormulacao.FormShow(Sender: TObject);
Var
  strNomCli: String;
begin
  inherited;
  edtVendedor.Text := strOperador;
  edtNomVen.Text := fRetNomVendRep(strOperador);

  strNomCli := fRetNomCliente(Self.strCliente);

  If Not fEmptyStr(strNomCli) Then
    strNomCli := ' - ' + strNomCli;

  edtObservacao.Text := 'Ajuste de estoque referente à baixa da formulação do documento ' + Self.strNumDoc + ', cliente ' +
    Self.strCliente + strNomCli;

  pMostrarFormulacoes();
end;

function TfrmAjusteEstoqueFormulacao.fProcessaSaldo(fltQuantidade,
  fltSaldo: Double): Boolean;
begin
  Result := True;

  If fltQuantidade > fltSaldo Then
  Begin
    If fUsaRotinaWMS Then
    Begin
      fMensagem('', Format('O produto %s não possui saldo suficiente para esse ajuste! ', [qryFormul.Fields[0].AsString]), ['&O k']);
      Result := False;
      Exit;
    End
    Else
    Begin
      intQtdReajuste  := 0;

      fltIteSalMl := fltSaldo;

      While fltQuantidade > fltIteSalMl Do
      Begin
        Inc(intQtdReajuste);

        fltIteSalMl := fltIteSalMl + (qryConIte.FieldByName('ITE_CNV_ML').AsFloat);

        If qryConIte.FieldByName('ITE_SALDOS').AsFloat = 0 Then
        Begin
          fMensagem('', Format('O produto %s não possui saldo suficiente para esse ajuste!', [qryFormul.Fields[0].AsString]), ['&O k']);
          Result := False;
          Exit;
        End;

        fltIteSaldos := (qryConIte.FieldByName('ITE_SALDOS').AsFloat - intQtdReajuste);
      End;
    End;
  End;
end;

function TfrmAjusteEstoqueFormulacao.fRetDescricaoCatalisadorAdvanceTintosystems(
  strCodCol, strCfgExi: String; qryGen: TUniQuery;
  var strCodIte: String): String;
var
  qryForTin: TUniQuery;
  strCodAca,
  strEmpAca: String;
  strCodEmb: String;
begin
  Result := '';

  If (Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP') Then
  Begin
    strCodAca := qryGen.FieldByName('FDO_CODACA').AsString;
    strEmpAca := qryGen.FieldByName('FDO_EMPACA').AsString;
  End
  Else
  Begin
    strCodAca := qryGen.FieldByName('DET_CODACA').AsString;
    strEmpAca := qryGen.FieldByName('DET_EMPACA').AsString;
  End;

  Try
    qryForTin := fCriaQuery;
    Begin
      qryForTin.Close;
      qryForTin.SQL.Clear;
      qryForTin.SQL.Add(' SELECT FOR_TIPCOR ');
      qryForTin.SQL.Add('   FROM FORTIN ');
      qryForTin.SQL.Add('  WHERE FOR_CODACA = :CODACA ');
      qryForTin.SQL.Add('    AND FOR_EMPACA = :EMPACA ');
      qryForTin.ParamByName('CODACA').AsString := strCodAca;
      qryForTin.ParamByName('EMPACA').AsString := strEmpAca;
      qryForTin.Open;

      If (Not fEmptyStr(qryForTin.FieldByName('FOR_TIPCOR').AsString)) Then
      Begin
        strCodEmb := qryForTin.FieldByName('FOR_TIPCOR').AsString;

        qryForTin.Close;
        qryForTin.SQL.Clear;
        qryForTin.SQL.Add(' SELECT BAS_DESCRI, ');
        qryForTin.SQL.Add('        BAS_CODITE  ');
        qryForTin.SQL.Add('   FROM ADT_CADBAS  ');
        qryForTin.SQL.Add('  WHERE BAS_CODBAS = :CODBAS ');
        qryForTin.SQL.Add('    AND BAS_CODEMB = :CODEMB ');
        qryForTin.SQL.Add('    AND BAS_DESCRI LIKE "%PARTE B%" '); //catalisador
        qryForTin.ParamByName('CODBAS').AsString := strCodCol;
        qryForTin.ParamByName('CODEMB').AsString := strCodEmb;
        qryForTin.Open;

        Result := qryForTin.FieldByName('BAS_DESCRI').AsString;

        strCodIte := qryForTin.FieldByName('BAS_CODITE').AsString;
      End;
    End;
  Finally
    FreeAndNil(qryForTin);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fVerificaFormulaVazia(
  strFormul: String): Boolean;
begin
  Result := True;

  If fEmptyStr(strFormul) Then
    Result := False
  Else If strFormul = '_' Then
    Result := False;
end;

function TfrmAjusteEstoqueFormulacao.fVerificaLote(strItem: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  Try
    Result := False; //Significa que não tem lote.

    qryGen := fCriaQuery(Self);
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT        ');
    qryGen.SQL.Add('    *           ');
    qryGen.SQL.Add('  FROM          ');
    qryGen.SQL.Add('    CADLOT      ');
    qryGen.SQL.Add('  WHERE         ');
    qryGen.SQL.Add('    LOT_CODITE = :CODITE AND   ');
    qryGen.SQL.Add('    LOT_CODEMP = :CODEMP AND   ');
    qryGen.SQL.Add('    LOT_STATUS = "S"           ');

    If fUsaRotinaWMS() Then
      qryGen.SQL.Add('  AND LOT_NUMLOT <> "A DEFINIR"   ');

    qryGen.SQL.Add('  ORDER BY LOT_DTAVAL          ');
    qryGen.ParamByName('CODITE').AsString := strItem;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := False;
      Exit;
    End;

    qryGen.Filtered := False;
    qryGen.Filter := 'LOT_PRITIN = "S"';
    qryGen.Filtered := True;

    If qryGen.RecordCount <= 0 Then
      Result := True
    Else
      strLote := qryGen.FieldByName('LOT_NUMLOT').AsString;


    qryGen.Close;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fRetornaCodigoFormula(
  qryGen: TUniQuery; intContador: Integer): String;
begin
  If Pos(strEspDoc, cnstEspTinDet) > 0 Then
    Result := qryGen.FieldByName('DET_FORM' + fStrZero(intContador, 2)).AsString
  Else
    Result := qryGen.FieldByName('FDO_FORM' + fStrZero(intContador, 2)).AsString
end;

function TfrmAjusteEstoqueFormulacao.fRetornaCodigoItem(strCodCol: String; strLinha_: String; qryGen: TUniQuery): String;
Var
  strCodIte: String;
  strCodColRet,
  strDesCol: String;
  strCfgExi: String;
begin
  Result := '';

  strCfgExi := fCfgSis('EXIDOC');

  pRetItemEDescricaoColorante(strIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp, strLinha_);

  If Not fEmptyStr(strCodIte) Then
  Begin
    Result := strCodIte
  End
  Else If strIdePro = 'ADT' Then
  Begin
    fRetDescricaoCatalisadorAdvanceTintosystems(strCodCol, strCfgExi, qryGen, strCodIte);
    Result := strCodIte;
  End;
end;

function TfrmAjusteEstoqueFormulacao.fRetornaLinha(qryGen: TUniQuery): String;
begin
  If Pos(strEspDoc, cnstEspTinDet) > 0  Then
    Result := qryGen.FieldByName('DET_LINTIN').AsString
  Else
    Result := qryGen.FieldByName('FDO_LINTIN').AsString;
end;

function TfrmAjusteEstoqueFormulacao.fRetornaQuantFormula(
  qryGen: TUniQuery; intContador: Integer): Double;
begin
  If Pos(strEspDoc, cnstEspTinDet) > 0  Then
    Result := qryGen.FieldByName('DET_QTDB' + fStrZero(intContador, 2)).AsFloat
  Else
    Result := qryGen.FieldByName('FDO_QTDB' + fStrZero(intContador, 2)).AsFloat;

  If fTipoTinta(strIdePro) = ttImobiliaria Then
    Result := Result / fGetFatorML(strIdePro);
end;

function TfrmAjusteEstoqueFormulacao.fRetornaSaldos(qryConIte: TUniQuery; qryConCit: TUniQuery;
  strNumLot: String): Double;
begin
  If (qryConCit.FieldByName('ITE_CNV_ML').AsFloat > 0) Then
   Result := qryConIte.FieldByName('ITE_SAL_ML').AsFloat
  Else
  Begin
    If fEmptyStr(strNumLot) Then
      Result := qryConIte.FieldByName('ITE_SALDOS').AsFloat
    Else
      Result := fSaldoLote(qryConIte.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strNumLot);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fRetornaValorDescricaoFormula(
  qryFormul: TUniQuery; strDescri: String; strCodIte: String): String;
begin
  Result := '';

  If (fCfgSis('IMPDOP') = '2') Then
    Result := ' - ' + fRetNomProduto(strCodIte)
  Else If Not fEmptyStr(strDescri) Then
    Result := ' - ' + strDescri;
end;

function TfrmAjusteEstoqueFormulacao.fRetornaValUnitario: Double;
Var
  strSQL: String;
  strValor: String;
  fltUnitar: Double;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT            ';
  strSQL := strSQL + '    *               ';
  strSQL := strSQL + '  FROM              ';
  strSQL := strSQL + '    ITEGER          ';
  strSQL := strSQL + '  WHERE ITE_CODITE = :CODITE        ';
  strSQL := strSQL + '    AND ITE_CODEMP = :CODEMP        ';

  Begin
    qryConIte.Close;
    qryConIte.SQL.Clear;
    qryConIte.SQL.Add(strSQL);
    qryConIte.ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
    qryConIte.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryConIte.Open;

    fltCusLot := 0;

    fltUnitar := qryConIte.FieldByName(fTabPrecoImp).AsFloat;

    If SameText(strImpAju, 'TOTCUS') Then
    Begin
      If fRetPrecoLote(qryFormul.Fields[0].AsString, strLote, fltCusLot) Then
        fltUnitar := fltCusLot;
    End;

    strValor := FloatToStrF(fltUnitar / qryConCit.FieldByName('ITE_CNV_ML').AsFloat, ffFixed, 12, 4);
    Result := StrToFloat(strValor);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fRetPrecoLote(strCodIte, strNumLot: String;
  var fltCusLot: Double): Boolean;
Var
  strSQL: String;
  qryCadLot: TUniQuery;
begin
  Result := False;
  fltCusLot := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LOT_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADLOT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
  strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND ';
  strSQL := strSQL + '  LOT_CODEMP = :CODEMP ';

  qryCadLot := fCriaQuery;
  Begin
    qryCadLot.SQL.Text := strSQL;

    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;
    qryCadLot.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCadLot.Open;

    If (Not qryCadLot.IsEmpty) Then
    Begin
      If (qryCadLot.FieldByName('LOT_PRECUS').AsFloat > 0) Then
      Begin
        fltCusLot := qryCadLot.FieldByName('LOT_PRECUS').AsFloat;
        Result := True;
      End;
    End;
  End;
  FreeAndNil(qryCadLot);
end;

function TfrmAjusteEstoqueFormulacao.fRetornaSaldosReservado(strCodIte,
  strNumLot, strCodEmp: String): Double;
begin
  Result := 0;

  If fUsaRotinaWMS() Then
    Result := fGetSaldoResLotDor(strCodIte, strNumLot, strCodEmp);
end;

function TfrmAjusteEstoqueFormulacao.fRetQtdDigitada(strNumLot: String): Double;
Var
  intRecNo: Integer;
begin
  Result := 0.0;

  Begin

    cdsItem.DisableControls;

    intRecNo := cdsItem.RecNo;
    cdsItem.First;

    While Not cdsItem.Eof Do
    Begin
      If (cdsItem.FieldByName('ITE_CODITE').AsString = qryFormul.Fields[0].AsString) Then
      Begin
        If SameText(cdsItem.FieldByName('ITE_NUMLOT').AsString, strNumLot) Then
          Result := Result + cdsItem.FieldByName('ITE_QTDITE').AsFloat;
      End;
      cdsItem.Next;
    End;

    cdsItem.RecNo := intRecNo;

    cdsItem.EnableControls;
  End;
end;

function TfrmAjusteEstoqueFormulacao.fSaldoLote(strCodIte, strCodEmp,
  strNumLot: String): Double;
Var
  qryGen: TUniQuery;
begin
  Result := 0;

  If (fEmptyStr(strCodIte)) Then
    If (fEmptyStr(strNumLot)) Then
      Exit;


  qryGen := fCriaQuery;

  Try
    Begin
      qryGen.Close;
      qryGen.SQL.Clear;

      qryGen.SQL.Add('SELECT IFNULL(LOT_SALDOS, 0) AS LOT_SALDOS FROM CADLOT');
      qryGen.SQL.Add('WHERE');
      qryGen.SQL.Add('  LOT_CODITE = :CODITE AND ');
      qryGen.SQL.Add('  LOT_CODEMP = :CODEMP AND ');
      qryGen.SQL.Add('  LOT_NUMLOT = :NUMLOT     ');

      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('NUMLOT').AsString := strNumLot;
      qryGen.Open;

      If Not qryGen.IsEmpty Then
        Result := qryGen.FieldByName('LOT_SALDOS').AsFloat;

      qryGen.Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmAjusteEstoqueFormulacao.fTabPreco: String;
Var
  strSQL: String;
  qryAux: TUniQuery;
begin
  If (strPreAju = 'CLIENTE') Then
  Begin
    Try
      qryAux := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_TABPRE ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      Begin
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strSQL);
        qryAux.ParamByName('CODCLI').AsString := edtCliente.Text;
        qryAux.Open;

        If Not qryAux.IsEmpty Then
          Result := 'ITE_PREVE' + qryAux.FieldByName('CLI_TABPRE').AsString
        Else
          Result := 'ITE_PREVE1';
      End;

    Except
      Result := 'ITE_PREVE1';
    End;
    FreeAndNil(qryAux);
  End
  Else
    Result := 'ITE_' + strPreAju;
end;

function TfrmAjusteEstoqueFormulacao.fTabPrecoImp: String;
begin
  If SameText(strImpAju,'TOTCUS' ) Then
    Result := 'PRECUS'
  Else If SameText(strImpAju,'TOTULT' ) Then
    Result := 'PREULT'
  Else If SameText(strImpAju,'IMPULT' ) Then
    Result := 'IMPULT'
  Else If SameText(strImpAju,'TOTMED' ) Then
    Result := 'PREMED';

  Result := 'ITE_' + Result;

  if SameText(strImpAju,'TOTITE' ) Then
    Result := fTabPreco
end;

function TfrmAjusteEstoqueFormulacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtDigitador) And (edtDigitador.Enabled) Then
    Begin
      If fEmptyStr(edtDigitador.Text) Then
      Begin
        fMensagem('', 'O Digitador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaDigitador();
        If qryConOpe.FIeldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('', 'Esse digitador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;
end;

function TfrmAjusteEstoqueFormulacao.fVerificaQtdEstoque(fltQtd: Double;
  strNumLot: String; blnProAca: Boolean; fltSalAca: Double): Boolean;
Var
  fltSaldos: Double;
  fltSalRes: Double;
begin
  Result := True;

  If fltQtd <= 0.0 Then
  Begin
    Result := False;
    Exit;
  End;

  fltSaldos := fRetornaSaldos(qryConIte, qryConCit, strNumLot);
  fltSalRes := fRetornaSaldosReservado(qryFormul.Fields[0].AsString, strNumLot, VS_strCodEmp);

  fltSaldos := fltSaldos - fltSalRes;
  fltQtd := fltQtd + fRetQtdDigitada(strNumLot);

  pCarregaSelectConIte();

  If (Pos(fCfgSis('SLD_VN'), 'AT') > 0) Then
  Begin

    If Pos('ITEM ESPECIAL', qryConCit.FieldByName('ITE_DESITE').AsString) > 0 Then
      Exit;

    Result := fProcessaSaldo(fltQtd, fltSaldos);
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pAddItem(strItem: String);
Var
  strRefere,
  strDesIte,
  strGrupo,
  strUnidade,
  strMarca: String;
begin
  strRefere  := '';
  strDesIte  := '';
  strGrupo   := '';
  strMarca   := '';
  strUnidade := '';

  If Not fVerificaQtdEstoque(qryFormul.Fields[4].AsFloat, strLote,
    False, fRetSaldosEmpresa(strItem, VS_strCodEmp)) Then
    Exit;

  pRetDadosItem(strItem, strGrupo, strDesIte, strRefere, strMarca, strUnidade);

  Begin
    cdsItem.Insert;
    cdsItem.FieldByName('ITE_CODITE').AsString := strItem;
    cdsItem.FieldByName('ITE_CODGRU').AsString := qryConCit.FieldByName('ITE_CODGRU').AsString;
    cdsItem.FieldByName('ITE_DESITE').AsString := strDesIte;
    cdsItem.FieldByName('ITE_REFERE').AsString := strRefere;
    cdsItem.FieldByName('ITE_CODMAR').AsString := qryConCit.FieldByName('ITE_CODMAR').AsString;
    cdsItem.FieldByName('ITE_TIPAJU').AsString := 'G';
    cdsItem.FieldByName('ITE_CNV_ML').AsFloat  := qryConCit.FieldByName('ITE_CNV_ML').AsFloat;
    cdsItem.FieldByName('ITE_CODUNI').AsString := strUnidade;
    cdsItem.FieldByName('ITE_SIGUNI').AsString := fRetSiglaUni(cdsItem.FieldByName('ITE_CODUNI').AsString);
    cdsItem.FieldByName('ITE_SALDOS').AsFloat  := fRetSaldosEmpresa(strItem, VS_strCodEmp);
    cdsItem.FieldByName('ITE_SAL_ML').AsFloat  := fRetSaldosMLEmpresa(strItem, VS_strCodEmp);
    cdsItem.FieldByName('ITE_QTDITE').AsFloat  := qryFormul.Fields[4].AsFloat;
    cdsItem.FieldByName('ITE_UNITAR').AsFloat  := fltValUni;
    cdsItem.FieldByName('ITE_TOTITE').AsFloat  := fltValUni * qryFormul.Fields[4].AsFloat;
    cdsItem.FieldByName('ITE_NUMLOT').AsString := strLote;
    cdsItem.FieldByName('ITE_CODACA').AsString := '';
    cdsItem.FieldByName('ITE_EMPACA').AsString := '';
    cdsItem.FieldByName('ITE_ENTSAI').AsString := 'S';
    cdsItem.FieldByName('ITE_CUSLOT').AsFloat  := fltCusLot;
    fltTotGer := fltTotGer + fFormataFloat(cdsItem.FieldByName('ITE_TOTITE').AsFloat, 2);
    cdsItem.Post;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pAtualiza;
begin
  pDeletaTemporaria();
  pCriaTemporaria();
  pMostrarFormulacoes();
end;

procedure TfrmAjusteEstoqueFormulacao.pAtualizaTemporaria;
Var
  strSQL: String;
begin
  If Not fTabelaExiste(fNomeTabelaFormulacao(strIdePro)) Then
    pCriaTemporaria();

  strSQL := '';
  strSQL := strSQL + '  SELECT            ';
  strSQL := strSQL + '    *               ';
  strSQL := strSQL + '  FROM              ';
  strSQL := strSQL + '  ' + fNomeTabelaFormulacao(strIdePro);

  Begin
    qryFormul.Close;
    qryFormul.SQL.Clear;
    qryFormul.SQL.Add(strSQL);
    qryFormul.Open;

    pFormataQuantidadeFormulacao();
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtDigitador.Text, True, True, False);
  Begin
    strCodOpe      := qryConOpe.FieldByName('OPE_CODOPE').AsString;
    edtNomDig.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pCarregaSelectConIte;
begin
  If Not (qryConCit.IsEmpty) Then
  Begin
    qryConIte.Close;
    qryConIte.SQL.Clear;
    qryConIte.SQL.Add(fGetSqlIteGer);
    qryConIte.ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
    qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConIte.Open;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pCriaCdItem;
begin
  cdsItem := TUniClientDataSet.Create(Owner);
  dtsItem := fCriaDataSource(cdsItem);


  Begin
    cdsItem.AggregatesActive := True;

    cdsItem.FieldDefs.Add('ITE_CODITE', ftString, intTamCod);
    cdsItem.FieldDefs.Add('ITE_CODGRU', ftString, 006);
    cdsItem.FieldDefs.Add('ITE_DESITE', ftString, 057);
    cdsItem.FieldDefs.Add('ITE_NUMLOT', ftString, 020);
    cdsItem.FieldDefs.Add('ITE_REFERE', ftString, 016);
    cdsItem.FieldDefs.Add('ITE_CODMAR', ftString, 006);
    cdsItem.FieldDefs.Add('ITE_ENTSAI', ftString, 001);
    cdsItem.FieldDefs.Add('ITE_CODUNI', ftString, 002);
    cdsItem.FieldDefs.Add('ITE_SIGUNI', ftString, 005);
    cdsItem.FieldDefs.Add('ITE_TIPAJU', ftString, 001);
    cdsItem.FieldDefs.Add('ITE_CODACA', ftString, 006);
    cdsItem.FieldDefs.Add('ITE_EMPACA', ftString, 003);
    cdsItem.FieldDefs.Add('ITE_SALDOS', ftFloat);
    cdsItem.FieldDefs.Add('ITE_SAL_ML', ftFloat);
    cdsItem.FieldDefs.Add('ITE_QTDITE', ftFloat);
    cdsItem.FieldDefs.Add('ITE_UNITAR', ftFloat);
    cdsItem.FieldDefs.Add('ITE_CUSLOT', ftFloat);
    cdsItem.FieldDefs.Add('ITE_TOTITE', ftFloat);
    cdsItem.FieldDefs.Add('ITE_CNV_ML', ftFloat);
    cdsItem.FieldDefs.Add('ITEREL', ftInteger);
    cdsItem.FieldDefs.Add('AUTOINCREM', ftAutoInc);

    cdsItem.CreateDataSet;
    cdsItem.Open;

    (cdsItem.FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DEQTAJ', varInteger));
    (cdsItem.FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (cdsItem.FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    (cdsItem.FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
  End;

  pSetaClient(cdsItem);
end;

procedure TfrmAjusteEstoqueFormulacao.pCriaTemporaria;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' CREATE TEMPORARY TABLE ' + fNomeTabelaFormulacao(strIdePro) + ' (';
  strSQL := strSQL + '    TMP_CODITE VARCHAR(10),       ';
  strSQL := strSQL + '    TMP_FORMUL VARCHAR(255),      ';
  strSQL := strSQL + '    TMP_QTDFOR DECIMAL(30,4),     ';
  strSQL := strSQL + '    TMP_QTDDIG DECIMAL(30,4),     ';
  strSQL := strSQL + '    TMP_DIFQTD DECIMAL(30,4)      ';
  strSQL := strSQL + '            );                    ';

  Begin
    qryFormul.Close;
    qryFormul.SQL.Clear;
    qryFormul.SQL.Add(strSQL);
    qryFormul.ExecSQL;
    qryFormul.Close;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pDeletaItem;
begin
  cdsItem.First;
  While cdsItem.RecordCount > 0 Do
  Begin
    cdsItem.Delete;
    cdsItem.Next;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pDeletaTemporaria;
Var
  strSQL: String;
begin
  If fTabelaExiste(fNomeTabelaFormulacao(strIdePro)) Then
  Begin
    strSQL := '';
    strSQL := strSQL + '  DROP TABLE  ' + fNomeTabelaFormulacao(strIdePro) + '; ';

    Begin
      qryFormul.Close;
      qryFormul.SQL.Clear;
      qryFormul.SQL.Add(strSQL);
      qryFormul.ExecSQL;
      qryFormul.Close;
    End;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pFormataQuantidadeFormulacao;
begin
  Begin
    TFloatField(qryFormul.FieldByName('TMP_QTDFOR')).DisplayFormat := '#,#0.0000';
    TFloatField(qryFormul.FieldByName('TMP_QTDDIG')).DisplayFormat := '#,#0.0000';
    TFloatField(qryFormul.FieldByName('TMP_DIFQTD')).DisplayFormat := '#,#0.0000';
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pMostrarFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intContador: Integer;
  qryGen: TUniQuery;

  strCodIte,
  strLinha_: string;
  strDescri: String;
begin
  Try
    Try
      pVerificaTabelaFormulacao();

      strCfgExi := fCfgSis('EXIDOC');
      qryGen := fCriaQuery(Nil, Nil);
      pAtualizaTemporaria();

      strSQL := strSQL + '  SELECT              ';
      strSQL := strSQL + '    DET_NUMDOC,       ';
      strSQL := strSQL + '    DET_CODEMP,       ';
      strSQL := strSQL + '    DET_CODCLI,       ';
      strSQL := strSQL + '    DET_CODITE,       ';
      strSQL := strSQL + '    DET_CODACA,       ';
      strSQL := strSQL + '    DET_EMPACA,       ';
      strSQL := strSQL + '    DET_IDEPRO,       ';
      strSQL := strSQL + '    DET_DESCRI,       ';
      strSQL := strSQL + '    DET_TIPPRE,       ';
      strSQL := strSQL + '    DET_DTAENT,       ';
      strSQL := strSQL + '    DET_HORENT,       ';
      strSQL := strSQL + '    DET_MONTAD,       ';
      strSQL := strSQL + '    DET_A_N_O_,       ';
      strSQL := strSQL + '    DET_QTDEMB,       ';
      strSQL := strSQL + '    IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS QTD,    ';
      strSQL := strSQL + '    OPE_NOMOPE AS DET_NOMOPE,       ';
      strSQL := strSQL + '    DET_ITETIN,       ';
      strSQL := strSQL + '    IFNULL(FOR_CATALI, "") AS FOR_CATALI,                 ';
      strSQL := strSQL + '    CLI_NOMCLI,       ';
      strSQL := strSQL + '    CLI_ENDERE,       ';
      strSQL := strSQL + '    CLI_ENDNUM,       ';
      strSQL := strSQL + '    CLI_BAIRRO,       ';
      strSQL := strSQL + '    CID_NOMCID,       ';
      strSQL := strSQL + '    CID_ESTADO,       ';
      strSQL := strSQL + '    CLI_C_E_P_,       ';
      strSQL := strSQL + '    CLI_FONE01,       ';
      strSQL := strSQL + '    CLI_FONE02,       ';
      strSQL := strSQL + '    CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS DOCUME,     ';

      For intContador := 1 To 20 Do
      Begin
        strSQL := strSQL + '  DET_FORM' + fStrZero(intContador, 2) + ',   ';
        strSQL := strSQL + '  DET_QTDB' + fStrZero(intContador, 2) + ' / IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE) AS DET_QTDB' + fStrZero(intContador, 2) + ',    ';
      End;

      strSQL := strSQL + fProcessaFromSQL();

      If Pos(strEspDoc, 'OR_PD_') > 0 Then
        strSQL := AnsiReplaceStr(strSQL, 'DET_', 'FDO_');

      strSQL := strSQL + '  WHERE               ';
      strSQL := strSQL + '    A.AUTOINCREM = :AUTINC      ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('AUTINC').AsString := strAutoincrem;
      qryGen.Open;

      strSQL := '';
      strSQL := strSQL + STR_SQL_NAO_REPLICAR;
      strSQL := strSQL + '  INSERT INTO   ' + fNomeTabelaFormulacao(strIdePro) + '    ';
      strSQL := strSQL + '    VALUES  (             ';
      strSQL := strSQL + '      :CODITE,            ';
      strSQL := strSQL + '      :FORMUL,            ';
      strSQL := strSQL + '      :QTDFOR,            ';
      strSQL := strSQL + '      :QTDDIG,            ';
      strSQL := strSQL + '      :DIFQTD             ';
      strSQL := strSQL + '            );            ';

      For intContador := 1 To 20 Do
      Begin
        strLinha_ := fRetornaLinha(qryGen);

        fltQtdBas := 0;

        strFormul := fRetornaCodigoFormula(qryGen, intContador);
        fltQtdBas := fltQtdBas + fRetornaQuantFormula(qryGen, intContador);

        If Not fVerificaFormulaVazia(strFormul) Then
          Continue;

        Begin
          qryFormul.Close;
          qryFormul.SQL.Clear;
          qryFormul.SQL.Add(strSQL);
          qryFormul.ParamByName('FORMUL').AsString := strFormul;

          If fCfgSis('TOTPRD', varBoolean) Then
            fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;

          strDescri := fDescricaoColorante(strFormul, strLinha_, strCodIte, qryGen);
          strCodIte := fRetornaCodigoItem(strFormul, strLinha_, qryGen);


          qryFormul.ParamByName('FORMUL').AsString := qryFormul.ParamByName('FORMUL').AsString + fRetornaValorDescricaoFormula(qryFormul, strDescri, strCodIte);
          qryFormul.ParamByName('CODITE').AsString := strCodIte;
          qryFormul.ParamByName('QTDFOR').AsFloat := fltQtdBas * fGetFatorML(strIdePro);
          qryFormul.ParamByName('QTDDIG').AsFloat := 0.0;
          qryFormul.ParamByName('DIFQTD').AsFloat := 0.0;

          qryFormul.ExecSQL;
          qryFormul.Close;
        End;

        pAtualizaTemporaria();
      End;
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally

  End;
end;

function TfrmAjusteEstoqueFormulacao.fProcessaFromSQL(): String;
begin
  Result := '';

  If Pos(strEspDoc, cnstEspTinDet) > 0  Then
  Begin
    Result := Result + '    DET_VOLPRO,     ';
    Result := Result + '    DET_LINTIN      ';
  End
  Else
  Begin
    Result := Result + '    0.0 AS DET_VOLPRO,      ';
    Result := Result + '    DET_LINTIN              ';
  End;

  Result := Result + '  FROM                ';

  {*************************}
  {*SE FOR ORÇAMENTO/PEDIDO*}
  {**********************RG*}
  If Pos(strEspDoc, 'OR_PD_') > 0  Then
  Begin
    Result := AnsiReplaceStr(Result, 'DET_', 'FDO_');
    Result := Result + '  TINDOR A';
    Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI     ';
    Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID     ';
    Result := Result + '  LEFT JOIN CADOPE O ON OPE_CODOPE = FDO_CODVEN   ';
    Result := Result + '  LEFT JOIN FORTIN ON FDO_CODACA = FOR_CODACA     ';
    Result := Result + '                  AND FDO_EMPACA = FOR_EMPACA     ';
  End
  {********************}
  {*** SE FOR VENDA ***}
  {*****************RG*}
  Else
  Begin
    Result := Result + '  TINDET A          ';
    Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI     ';
    Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID     ';
    Result := Result + '  LEFT JOIN CADOPE O ON OPE_CODOPE = DET_CODVEN   ';
    Result := Result + '  LEFT JOIN FORTIN ON DET_CODACA = FOR_CODACA     ';
    Result := Result + '                  AND DET_EMPACA = FOR_EMPACA     ';
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.pVerificaTabelaFormulacao;
begin
  If fEmptyStr(fNomeTabelaFormulacao(strIdePro)) Then
  Begin
    fMensagem('ATENÇÃO','Tabela de formulação da tinta de máquina [ ' + strIdePro  + ' ] não foi encontrada !', ['&Ok']);
    Exit;
  End;

  If fTipoTinta(strIdePro) = ttAutomotiva Then
    cxgTblsAjuEstFor.Columns[1].Caption := 'Base'
  Else
    cxgTblsAjuEstFor.Columns[1].Caption := 'Colorante';
end;

function TfrmAjusteEstoqueFormulacao.fVerificaLoteCadastrado(): Boolean;
begin
  Result := True;

  qryFormul.First;

  blnAjuste := False;

  fltTotGer := 0;

  While Not qryFormul.Eof Do
  Begin
    If fVerificaLote(qryFormul.Fields[0].AsString) Then
    Begin
      fMensagem('', 'O produto %s possui lote cadastrado porem não existe um principal para tinta de máquina' + #13 +
        'Favor verificar para continuar.', ['&O k']);
      Result := False;
      Exit;
    End;

    qryFormul.Next;
  End;

  qryFormul.First;

  While Not qryFormul.Eof Do
  Begin
    If Not fAlterouBaseCorante(qryFormul.Fields[4].AsFloat) Then
    Begin
      qryFormul.Next;
      Continue;
    End;

    pPesquisaCadIte(qryConCit, qryConCit, qryFormul.Fields[0].AsString, '');
    fltValUni := fRetornaValUnitario();
    pAddItem(qryFormul.Fields[0].AsString);

    qryFormul.Next;
  End;

  If cdsItem.RecordCount <= 0 Then
  Begin
    fMensagem('', 'Não foi possivel realizar o ajuste pois nenhuma quantidade foi alterada!', ['&O k']);
    Result := False;
    Exit;
  End;
end;

procedure TfrmAjusteEstoqueFormulacao.tblDiferencaPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If StrToFloatDef(DisplayValue, 0) <= 0 Then
  Begin
    pMensagemOk('A diferença deve ser maior que Zero!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    qryFormul.Edit;
    qryFormul.Fields[3].AsFloat := qryFormul.Fields[2].AsFloat + StrToFloat(DisplayValue);
    qryFormul.Fields[4].AsFloat := StrToFloat(DisplayValue);
    qryFormul.Post;
  End;

end;

procedure TfrmAjusteEstoqueFormulacao.tblQtdAlteradaPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  If StrToFloatDef(DisplayValue, 0) <= qryFormul.Fields[2].AsFloat Then
  Begin
    pMensagemOk('A quantidade digitada deve ser maior que a quantidade original!');
    Error := True;
    ErrorText := '';
  End
  Else
  Begin
    qryFormul.Edit;
    qryFormul.Fields[4].AsFloat := StrToFloat(DisplayValue) - qryFormul.Fields[2].AsFloat;
    qryFormul.Fields[3].AsFloat := StrToFloat(DisplayValue);
    qryFormul.Post;
  End;
end;

end.
