unit untFatAbastecimentoItens;

interface

uses
  DB,
  Uni,
  Math,
  Classes,
  Variants,
  SysUtils,
  strUtils,
  DateUtils,
  cxProgressBar,
  UniClientDataSet,
  untFuncFatTypes,
  untTypesSistema,
  Vcl.StdCtrls,
  Vcl.Forms,
  untMsgLiberacao,
  untLiberacao,
  System.Generics.Collections,
  System.UITypes,
  untLogAbt;

type
  ESaldoSaldoInsuficienteParaAbastecimentoComEstoque = Class(Exception);
  ESaldoSaldoInsuficienteParaAbastecimentoComTransferencia = Class(Exception);

  TSaldoDisponivel = record
    fltSaldoDisponivelOriginal: Double;
    fltSaldoDisponivelFinal: Double;
    strNumLot: String;
  end;

  TControleSaldoDisponivel = class(TInterfacedObject, IInterface)
  private
    FObjVenda: Pointer;
    dicSaldoDisponivel: TDictionary<String, TSaldoDisponivel>;
  public
    constructor Create(objVenda: Pointer);
    destructor Destroy; override;
    procedure pIniciarSaldoDisponivel;
    procedure pAddItem(strCodIte, strCodEmp, strNumLot, strSeqFdo: String);
    procedure pAddItemLote(strCodIte, strEmpIte, strCodEmp, strNumLot, strSeqFdo: String; fltQtdIte: Double);
    procedure pDecrementarSaldoDisponivel(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double);
    procedure pIncrementarSaldoDisponivel(strCodIte, strCodEmp, strNumLot: String; fltQtdIte: Double);
    function fRetornaSaldoDisponivel(strCodIte, strCodEmp, strNumLot: String): Double;
    function fRetornaLote(strCodIte, strCodEmp, strNumLot: String): String;
  end;

  TEmpresaAbastecimento = class(TInterfacedObject, IInterface)
  public
    intAutInc: Integer;
    strSeqFdo: String;
    strCodIte: String;
    strNumLot: String;
    strEmpIte: String;
    strEmpTra: String;
    blnEmpMat: Boolean;
    intDiaEst: Integer; // DDE
    fltQtdTra: Double;
    fltEstMin: Double;
    varSeqTra: Variant;
  end;

  TAbastecimentoPedido = class(TInterfacedObject, IInterface)
  public
    strSequencialFatdor: String;
    strSequencialPrepRQ: String;
    strSequencialPrepTE: String;
  end;

  TAbastecimentoSequencialTransf = class(TInterfacedObject, IInterface)
  public
    intAutInc,
    intSeqEmp: Integer;
    strCodEmp: String;
    fltSalTra: Double;
    strCodIte: String;
    strNumLot: String;
  end;

  TAbastecimentoSequencialResumo = class(TInterfacedObject, IInterface)
  public
    lstTransf: TList<TAbastecimentoSequencialTransf>;
    intTransf: Integer;
    intComple: Integer;
    fltSalTra: Double;
    constructor Create;
    destructor Destroy; override;
  end;

  TProdutosDoPedidoDeAbastecimento = Record
    strCodIte: String;
    strDesIte: String;
    fltQtdCom: Double;
    fltQtdTra: Double;
    blnTrava: Boolean;
  end;


  TAbastecimentoItensPedido = class
    private
      FCampos  : TList<TFieldDefInf>;
      FEmpresasAbastecimento: TList<TEmpresaAbastecimento>;
      FAbastecimentosPedido: TList<TAbastecimentoPedido>;
      FControleSaldoDisponivel: TControleSaldoDisponivel;
      FCdsItens: TUniClientDataSet;
      FCdsItensTmp: TUniClientDataSet;
      FStlCodEmp: TStringList;
      FStlEmpresas: TStringList;
      FStlItensDup: TStringList;
      FObjVenda: Pointer;
      FExibirProdutoEmEstoque: Boolean;
      FUtilizarSequencial: Boolean;
      FSequencialResumo: TList<TAbastecimentoSequencialResumo>;
      FOpcaoExibir: TOpcaoExibirTelaAbastecimento;
      FProgresso: TcxProgressBar;
      FTravaAbastecimentoPorCompra: TDictionary<Integer, TProdutosDoPedidoDeAbastecimento>;
      FblnValidarTodos: Boolean;
      FblnTeveAlgumTipoAbastecimento: Boolean;
      FblnReqAut: Boolean;
      FblnConsiderarLoteSaldoTotal: Boolean;
      FblnEhEmissaoPDAVista: Boolean;

      procedure SetProgressMax(AValue: Integer);
      procedure IncProgressPos(AValue: Integer);
      procedure SetProgressInfo(AValue: String);

      function fRetornaGiro(strCodIte, strCodEmp: String; intMeses: Integer): TDoubleArray;

      function fQuantidadeReservaItem(strSeqFdo: String): Double;

      function fSaldoDisponivel(item: TDadosfechamento; strCodEmp: String): Double;
      function fCalculaDiasEstoque(item: TDadosfechamento; strCodEmp: String): Integer;
      function fRetornaEstoqueMinimo(strCodIte, strCodEmp: String): Double;

      function fQuantidadeJaEmReqCompra(strSeqDet: String): Double;
      function fQuantidadeJaEmTransferencia(strSeqDet: String): Double;

      function fField(strCampo: String): TField;

      procedure pDefineQuantidadeComprar;
      procedure pDefineQuantidadeEstoque;
      procedure pDefineQuantidadeTransferir;
      procedure pDefineQuantidadeTransferirSequencial;
      procedure pIniciarQuantidades;
      procedure pSetaQtdItemRestante(var fltQtdRestante: Double);

      function fIniciarSaldoDisponivel(AProgresso: TcxProgressBar = nil): Boolean;

      procedure pListarEmpresas;
      procedure pDefinirCampos;
      procedure pCriarCdsItens;
      procedure pCarregarItens;
      procedure pCalcularFormaAbastecimentoItens;
      procedure pInformacaoPedidoCompra;
      procedure pDeterminaEmpresasTransferencia;
      procedure pDeterminaEmpresasTransferenciaSequencial;

      function  fLimitarEstoqueATransferirPeloEstoqueMinimoDaEmpresa : Boolean;

      procedure pValidarEstoqueDisponivel;
      procedure pValidarQtdAbastecimentoComEstoque;
      procedure pValidarQtdAbastecimentoComTransferencia;

      procedure pAtualizarItensSelecionadosAbastecimento;
      procedure pAtualizarItensFaturamentoParcial;
      procedure pSepararItensPorTipoAbastecimento;

      procedure pBeforePost(DataSet: TDataSet);
      procedure pAfterPost(DataSet: TDataSet);
      procedure pValidarTodosItens;

      function fEmpresaAbastecimento(strCodEmp, strCodIte: String; intAutInc: Integer): TEmpresaAbastecimento;
      function fGetSeqTra(CodEmpOri, CodEmpDes: String): Variant;

      function fDefinirTipoAbastecimentoInterna(AProgresso: TcxProgressBar = nil): Boolean;
      procedure pChamaAvisoDeTravaComQtdCompraInformado(fltQtdItem, fltQtdCompra: Double; strCodIte: String; intAutInc: Integer);
      function fRetornaSaldoDisponivelParaTransferencia: Double;
      function fLiberaTravaQuantidadeDeCompra: Boolean;

      procedure pPreparaRequisicaoCompra(AstrIncFdoNov, AstrEmpIte, AstrCodIte, AstrNumDoc,
        AstrEspDoc, AstrEmpDoc: String; AfltQtdReqCompra: Double; AstrSeqPedCompra: String = '');
      procedure pPreparaRequisicaoCdsVinculos(AstrIncFdoNov, AstrEmpIte, AstrNumDoc, AstrEspDoc, AstrEmpDoc: String; AintSeqDetAnt: String);
      procedure pAtualizaSeqFDORequisicoesVinculadas(AstrIncFdoAnt, AstrIncFdoNov: String; strCodIte: String = '');
      function fTotalJaVinculado: Double;
      procedure pConfirmaAbastecimento;

      procedure pPreencheObjetoLogAbt(Var objLogAbt: TLogAbt);
      procedure pPreparaLogAbt();
      procedure pCarregaRequisicoesSolicitadas;
    public
      constructor Create(objVenda: Pointer);
      destructor Destroy; override;

      procedure pApagarAbastecimentosAnteriorSemPedidoCompra;
      procedure pCarregarAbastecimentosAnterior;
      procedure pEmpresasAbastecimento(blnAlterou: Boolean = False);

      function fDefinirTipoAbastecimento(OpcaoExibir: TOpcaoExibirTelaAbastecimento): Boolean;

      procedure pSelecionarTodos(blnMarcado: Boolean);

      function fValidarTodosItens: Boolean;

      function fTemSolicitacaoDeTransferenciaOuCompra: Boolean;

      procedure pAtualizarAbastecimentosAnteriores(strIncFdoAnt,
        strIncFdoNov, strNumDoc, strEspDoc, strEmpDoc: String;
        opcTipAbs: TOpcaoAbastecimentoItem; strCodIte: String);

      procedure pGerarPreparaRequisicoes(Item: TDadosFechamento;
        strIncFdoNov, strNumDoc, strEspDoc, strEmpDoc: String;
        opcTipAbs: TOpcaoAbastecimentoItem);

      function fGerarPreparaTransferencias(Item: TDadosFechamento;
                                           strIncFdoNov,
                                           strNumDoc,
                                           strEspDoc,
                                           strEmpDoc: String;
                                           opcTipAbs: TOpcaoAbastecimentoItem): Boolean;

      property cdsItens: TUniClientDataSet read FCdsItens;
      property ExibirProdutoEmEstoque: Boolean read FExibirProdutoEmEstoque write FExibirProdutoEmEstoque;
      property TeveAlgumTipoAbastecimento: Boolean read FblnTeveAlgumTipoAbastecimento write FblnTeveAlgumTipoAbastecimento;
      property AbastecimentosPedido: TList<TAbastecimentoPedido> read FAbastecimentosPedido;
      property stlCodEmp: TStringList read FStlCodEmp write FStlCodEmp;
  end;

  function fPossuiAbastecimentoVinculadoComReqCompra(strSeqDet: String; var strRequisicoes: String): Boolean;
  function fPossuiAbastecimentoVinculadoComTransferencia(strSeqDet: String; var strTransferencias: String): Boolean;

implementation

uses
  untFuncoesSimples, untFuncFat, untFatDefineTipoAbastecimentoItens, untConstantes,
  untTPreparaRequisicaoCompra, untPreparaGeracaoTE, untFatSelPedidoCompraRequisicao;

function fPossuiAbastecimentoVinculadoComReqCompra(strSeqDet: String; var strRequisicoes: String): Boolean;
begin
  strRequisicoes :=
    fCampoTabela('GROUP_CONCAT(DISTINCT PRQ_CODREQ, "-", PRQ_EMPREQ)',
                 'FDOABS INNER JOIN PREPRQ ON PREPRQ.AUTOINCREM = FDOABS.ABS_SEQPRQ '+
                 'INNER JOIN MOVRCD ON MOVRCD.RCD_CODIGO = PREPRQ.PRQ_CODREQ AND '+
                 'MOVRCD.RCD_CODITE = PREPRQ.PRQ_CODITE AND '+
                 'MOVRCD.RCD_CODEMP = PREPRQ.PRQ_EMPREQ',
                ['ABS_SEQFDO','MOVRCD.RCD_REQNEG<>'], [strSeqDet,'S']);
  Result := Not fEmptyStr(strRequisicoes);
end;

function fPossuiAbastecimentoVinculadoComTransferencia(strSeqDet: String; var strTransferencias: String): Boolean;
begin
  strTransferencias :=
    fCampoTabela('GROUP_CONCAT(DISTINCT PRE_NUMDOC, "-", PRE_ESPDOC, "-", PRE_EMPDOC)',
                 'FDOABS INNER JOIN PREPTE on PREPTE.AUTOINCREM = FDOABS.ABS_SEQPTE ' +
                 'LEFT JOIN FATGOR ON FGO_NUMDOC = PRE_NUMDOC AND FGO_ESPDOC = PRE_ESPDOC' +
                 ' AND FGO_CODEMP = PRE_EMPDOC',
                ['ABS_SEQFDO', 'IFNULL(FGO_MOTBAI, "")'], [strSeqDet, '']);

  Result := Not fEmptyStr(strTransferencias);
end;

{ TAbastecimentoItensPedido }

constructor TAbastecimentoItensPedido.Create(objVenda: Pointer);
begin
  FObjVenda := objVenda;
  FStlItensDup := TStringList.Create;
  FblnReqAut := TFatVenda(FObjVenda).blnReqAut;
  FblnEhEmissaoPDAVista := TFatVenda(FObjVenda).fDefinirTipoAbastecimentoPedidoAVista;
  FblnConsiderarLoteSaldoTotal := (fCfgSis('ABLOTT', varBoolean) and (fCfgSis('CTLEST', varInteger) = 1));
  FExibirProdutoEmEstoque := False;
  FUtilizarSequencial := fCfgSis('SEQABA', varBoolean);
  pListarEmpresas;
  pDefinirCampos;
  pCriarCdsItens;
  fChamaTelaGravando(fIniciarSaldoDisponivel);

  FSequencialResumo := TList<TAbastecimentoSequencialResumo>.Create;
  FTravaAbastecimentoPorCompra := TDictionary<Integer, TProdutosDoPedidoDeAbastecimento>.Create;
  FblnValidarTodos := False;
  FblnTeveAlgumTipoAbastecimento := False;
end;

destructor TAbastecimentoItensPedido.Destroy;
begin
  FCampos.Free;
  FStlCodEmp.Free;
  FStlEmpresas.Free;
  FStlItensDup.Free;
  FCdsItens.Free;
  FCdsItensTmp.Free;
  FEmpresasAbastecimento.Free;
  FAbastecimentosPedido.Free;
  FSequencialResumo.Free;
  FTravaAbastecimentoPorCompra.Free;

  inherited;
end;

function TAbastecimentoItensPedido.fCalculaDiasEstoque(item: TDadosfechamento; strCodEmp: String): Integer;
  Var
    arrGiro6Meses: TDoubleArray;
    intIdx, intIdxMaior, intIdxMenor: Integer;
    fltQtdTotalVendas: Double;
    fltVendasDiaria: Double;
begin
  arrGiro6Meses := fRetornaGiro(item.strCodIte, strCodEmp, 6);

  intIdxMaior := 0;
  intIdxMenor := 0;

  For intIdx := Low(arrGiro6Meses) To High(arrGiro6Meses) Do
  Begin
    If arrGiro6Meses[intIdx] > arrGiro6Meses[intIdxMaior] Then
      intIdxMaior := intIdx;

    If arrGiro6Meses[intIdx] < arrGiro6Meses[intIdxMenor] Then
      intIdxMenor := intIdx;
  End;

  fltQtdTotalVendas := 0;

  //Despreza os meses com maior e menor venda
  For intIdx := Low(arrGiro6Meses) To High(arrGiro6Meses) Do
    If (intIdx <> intIdxMaior) And (intIdx <> intIdxMenor) Then
      fltQtdTotalVendas := fltQtdTotalVendas + arrGiro6Meses[intIdx];

  fltVendasDiaria := fltQtdTotalVendas / 120 {4 meses * 30 dias};

  Result := Floor(fSaldoDisponivel(item, strCodEmp) / fltVendasDiaria);
end;

function TAbastecimentoItensPedido.fDefinirTipoAbastecimento(OpcaoExibir: TOpcaoExibirTelaAbastecimento): Boolean;
begin
  FOpcaoExibir := OpcaoExibir;
  Result := fChamaTelaGravando(fDefinirTipoAbastecimentoInterna, 'Aguarde, definindo tipo de abastecimento ...');
end;

function TAbastecimentoItensPedido.fDefinirTipoAbastecimentoInterna(AProgresso: TcxProgressBar = nil): Boolean;
begin
  Result := True;
  FProgresso := AProgresso;

  pCarregarItens;
  pCarregaRequisicoesSolicitadas;
  pInformacaoPedidoCompra;
  pEmpresasAbastecimento;
  pCarregarAbastecimentosAnterior;
  pCalcularFormaAbastecimentoItens;
  FCdsItens.AfterPost := pAfterPost;
  FCdsItens.BeforePost := pBeforePost;

  If (FOpcaoExibir <> oeNaoExibir) Or FblnReqAut Then
    pPreparaLogAbt();

  Try
    If fTemSolicitacaoDeTransferenciaOuCompra() Or (FOpcaoExibir In [oeExibirSempre]) Then
    Begin
      If FOpcaoExibir In [oeNaoExibir] Then
        Result := fValidarTodosItens;

      If (FOpcaoExibir In [oeExibirSempre, oeExibirSeTranfOuCompra]) Or (Not Result) Then
        Result := TfrmFatDefineTipoAbastecimentoItens.fDefinirTipoAbastecimento(Self);

      If Result Then
        pConfirmaAbastecimento;
    End
    else if FblnReqAut then
      pConfirmaAbastecimento;

    If (FOpcaoExibir <> oeNaoExibir) Or FblnReqAut Then
      pPreparaLogAbt();
  Finally
    FCdsItens.BeforePost := nil;
    FCdsItens.AfterPost := nil;
    FProgresso := nil;
  End;
end;

function TAbastecimentoItensPedido.fEmpresaAbastecimento(strCodEmp, strCodIte: String; intAutInc: Integer): TEmpresaAbastecimento;
var
  empresaAbastec: TEmpresaAbastecimento;
begin
  Result := Nil;

  For empresaAbastec In FEmpresasAbastecimento Do
  Begin
    If (strCodEmp = empresaAbastec.strEmpTra) And
       (strCodIte = empresaAbastec.strCodIte) And
       (IIF(FStlItensDup.IndexOf(empresaAbastec.strCodIte) = -1, True, intAutInc = empresaAbastec.intAutInc))
       Then
    begin
      Result := empresaAbastec;
      Break;
    end;
  end;
end;

function TAbastecimentoItensPedido.fField(strCampo: String): TField;
begin
  Result := FCdsItens.FieldByName(strCampo);
end;

function TAbastecimentoItensPedido.fGetSeqTra(CodEmpOri,
  CodEmpDes: String): Variant;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  try
    qryConsulta.SQL.Add('SELECT ');
    qryConsulta.SQL.Add('  CON_SEQTRA ');
    qryConsulta.SQL.Add('FROM');
    qryConsulta.SQL.Add('  CONEMP ');
    qryConsulta.SQL.Add('WHERE CON_EMPORI = :EmpOri');
    qryConsulta.SQL.Add('  AND CON_EMPDES = :EmpDes ');

    qryConsulta.ParamByName('EmpOri').AsString := CodEmpOri;
    qryConsulta.ParamByName('EmpDes').AsString := CodEmpDes;
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('CON_SEQTRA').AsVariant;

  finally
    qryConsulta.Free;
  end;
end;

function TAbastecimentoItensPedido.fQuantidadeJaEmReqCompra(strSeqDet: String): Double;
Var
  abastecimento: TAbastecimentoPedido;
begin
  Result := 0;
  For abastecimento In FAbastecimentosPedido Do
    If abastecimento.strSequencialFatdor = strSeqDet Then
      If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
        Result := Result + fCampoTabela('PRQ_QTDITE', 'PREPRQ', ['AUTOINCREM'],
          [abastecimento.strSequencialPrepRQ]);
end;

function TAbastecimentoItensPedido.fQuantidadeJaEmTransferencia(strSeqDet: String): Double;
Var
  abastecimento: TAbastecimentoPedido;

  function fRetornaQuantidadeTransferenciaEmAberto(Const strSequencialPrepTE: String): Double;
    var
      qryGen: TUniQuery;
  begin
    Result := 0;

    qryGen := fCriaQuery(Nil);
    Try
      qryGen.SQL.Add('SELECT IFNULL(PRE_QTDITE, 0) FROM PREPTE    ');
      qryGen.SQL.Add('  WHERE PREPTE.AUTOINCREM = :AUTOINCREM     ');
      qryGen.SQL.Add('   AND ((SELECT COUNT(*) FROM FATDOR        ');
      qryGen.SQL.Add('         WHERE FDO_JAFATU = 0               ');
      qryGen.SQL.Add('           AND FDO_CODITE = PRE_CODITE      ');
      qryGen.SQL.Add('           AND FDO_NUMDOC = PRE_NUMDOC      ');
      qryGen.SQL.Add('           AND FDO_ESPDOC = PRE_ESPDOC      ');
      qryGen.SQL.Add('           AND FDO_CODEMP = PRE_EMPDOC) > 0 ');
      qryGen.SQL.Add('        OR PRE_NUMDOC IS NULL)              ');

      qryGen.ParamByName('AUTOINCREM').AsString := strSequencialPrepTE;

      qryGen.Open;

      If (Not qryGen.IsEmpty) Then
        Result := qryGen.Fields[0].AsFloat;
    Finally
      FreeAndNil(qryGen);
    End;
  end;

begin
  Result := 0;
  For abastecimento In FAbastecimentosPedido Do
    If abastecimento.strSequencialFatdor = strSeqDet Then
      If Not fEmptyStr(abastecimento.strSequencialPrepTE) Then
        Result := Result + fRetornaQuantidadeTransferenciaEmAberto(abastecimento.strSequencialPrepTE);
end;

function TAbastecimentoItensPedido.fQuantidadeReservaItem(
  strSeqFdo: String): Double;
begin
  Result := fCampoTabela('FDO_QTDRES', 'EXTDOR', ['FDO_SEQFDO'], [strSeqFdo]);
end;

function TAbastecimentoItensPedido.fRetornaEstoqueMinimo(strCodIte,
  strCodEmp: String): Double;
begin
  Result := fCampoTabela('ITE_ESTMIN','ITEGER',['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strCodEmp]);
end;

function TAbastecimentoItensPedido.fRetornaGiro(strCodIte, strCodEmp: String;
  intMeses: Integer): TDoubleArray;
Var
  intMes: Integer;
  dtaMesGiro: TDateTime;
  strMes: String;
  strAno: String;
begin
  SetLength(Result, intMeses);

  dtaMesGiro := VS_Date;

  For intMes := 1 To intMeses Do
  Begin
    dtaMesGiro := IncMonth(dtaMesGiro, -1);

    strMes := fStrZero(MonthOf(dtaMesGiro).ToString, 2);
    strAno := YearOf(dtaMesGiro).ToString;

    Result[intMes - 1] := fCampoTabela('IFNULL(GIR_QSAI' + strMes + ', 0)',
      'GIRITE', ['GIR_CODITE', 'GIR_CODEMP', 'GIR_A_N_O_'],
      [strCodIte, strCodEmp, strAno]);
  End;

end;

function TAbastecimentoItensPedido.fRetornaSaldoDisponivelParaTransferencia: Double;
var
  strEmpTra: String;
  fltSalDis: Double;
  empresaAbastec: TEmpresaAbastecimento;
begin
  Result := 0;
  For strEmpTra In FStlCodEmp Do
  Begin
    If strEmpTra = fField('EMPITE').AsString Then
      Continue;

    If Not fPermiteTransfEntreEmps(strEmpTra, fField('EMPITE').AsString) Then
      Continue;

    fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(fField('CODITE').AsString, strEmpTra, fField('NUMLOT').AsString);

    if FUtilizarSequencial then
    begin
      empresaAbastec := fEmpresaAbastecimento(strEmpTra, fField('CODITE').AsString, fField('AUTINC').AsInteger);
      if not Assigned(empresaAbastec) then
        Continue;

      if empresaAbastec.varSeqTra = null then
        Continue;

      fltSalDis  := fltSalDis - empresaAbastec.fltEstMin;
    end;

    If fltSalDis <= 0 Then
      Continue;

    Result := Result + fltSalDis;
  End;
end;

function TAbastecimentoItensPedido.fSaldoDisponivel(item: TDadosfechamento; strCodEmp: String): Double;
begin
  Result := FControleSaldoDisponivel.fRetornaSaldoDisponivel(item.strCodIte, strCodEmp, item.strNumLot);
end;

function TAbastecimentoItensPedido.fTemSolicitacaoDeTransferenciaOuCompra: Boolean;
begin
  Result := False;
  FCdsItens.First;

  While (Not FCdsItens.Eof) And (Not Result) Do
  Begin
    if FblnReqAut then
      Result := (fFormataFloat(fField('QTDREQ').AsFloat + fField('QTDTRA').AsFloat + fField('REQSOL').AsFloat + fField('QTDEST').AsFloat, 4) <> fFormataFloat(fField('QTDITE').AsFloat, 4)) Or (fField('QTDREQ').AsFloat > 0)
    else
      Result := ((fField('QTDREQ').AsFloat > 0) Or (fField('QTDTRA').AsFloat > 0));

    FCdsItens.Next();
  End;

  FCdsItens.First;
end;

function TAbastecimentoItensPedido.fTotalJaVinculado: Double;
var
  strSeqFDO: String;
  strCodIte: String;
  fltTotVinc: Double;
  cdsDados: TUniClientDataSet;
begin
  strCodIte := fField('CODITE').AsString;
  strSeqFDO := fField('SEQFDO').AsString;
  fltTotVinc := 0;

  Result := TFatVenda(FObjVenda).fGetTotalVinculado(strCodIte, False, strSeqFDO);

  cdsDados := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(cdsDados, FCdsItens);
    cdsDados.Filtered := False;
    cdsDados.Filter := 'CODITE=' + QuotedStr(strCodIte) + IIF(not fEmptyStr(strSeqFDO), ' AND SEQFDO=' + QuotedStr(strSeqFDO), '');
    cdsDados.Filtered := True;

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      fltTotVinc := fltTotVinc + cdsDados.FieldByName('REQSOL').AsFloat;
      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;

  Result := Result - fltTotVinc;
end;

function TAbastecimentoItensPedido.fValidarTodosItens: Boolean;
begin
  Try
    Result := fLiberaTravaQuantidadeDeCompra;
    If Result Then
      pValidarTodosItens;
  Except
    On E: EAbort Do
      Result := False;
    On E: Exception Do
      Raise;
  End;
end;

procedure TAbastecimentoItensPedido.IncProgressPos(AValue: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    FProgresso.Position := FProgresso.Position + AValue;
    Application.ProcessMessages;
  End;
end;

procedure TAbastecimentoItensPedido.pValidarEstoqueDisponivel;
begin
  if not (fCfgSis('CESTMI', varBoolean)) then
    Exit;

  FControleSaldoDisponivel.pIniciarSaldoDisponivel;
  pValidarQtdAbastecimentoComEstoque;
  pValidarQtdAbastecimentoComTransferencia;
end;

procedure TAbastecimentoItensPedido.pValidarQtdAbastecimentoComEstoque;

  procedure pValidaEstoque(blnErro: Boolean);
    Var
      strCodIte: String;
      strEmpIte: String;
      strNumLot: String;
      fltSalDis: Double;
      fltQtdIte: Double;
  begin
    strCodIte := FCdsItensTmp.FieldByName('CODITE').AsString;
    strEmpIte := FCdsItensTmp.FieldByName('EMPITE').AsString;
    fltQtdIte := FCdsItensTmp.FieldByName('QTDEST').AsFloat;
    strNumLot := FCdsItensTmp.FieldByName('NUMLOT').AsString;
    fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(strCodIte, strEmpIte, strNumLot);

    If fltQtdIte <= 0 Then
      Exit;

    If blnErro And (fltSalDis < fltQtdIte) Then
      Raise ESaldoSaldoInsuficienteParaAbastecimentoComEstoque.Create('O Produto ' + strCodIte +
        ' não possui estoque suficiente na empresa ' + strEmpIte + '!');

    FControleSaldoDisponivel.pDecrementarSaldoDisponivel(strCodIte, strEmpIte, strNumLot, fltQtdIte);
  end;

begin
  FCdsItensTmp.First;

  While Not FCdsItensTmp.Eof Do
  Begin
    If (FCdsItensTmp.FieldByName('CODITE').AsString =  fField('CODITE').AsString) And
       (FCdsItensTmp.FieldByName('AUTINC').AsString <> fField('AUTINC').AsString) Then
    Begin
      pValidaEstoque(False);
    End;
    FCdsItensTmp.Next;
  End;

  If FCdsItensTmp.Locate('AUTINC', fField('AUTINC').AsString, []) Then
    pValidaEstoque(True);
end;

procedure TAbastecimentoItensPedido.pValidarQtdAbastecimentoComTransferencia;

  procedure pValidaEstoque(blnErro: Boolean);
    Var
      strCodIte: String;
      strEmpIte: String;
      strEmpTra: String;
      strNumLot: String;
      fltSalDis: Double;
      fltQtdRes: Double;
      fltQtdTra: Double;
      intAutInc: Integer;
      empresaAbastec: TEmpresaAbastecimento;
  begin
    intAutInc := FCdsItensTmp.FieldByName('AUTINC').AsInteger;
    strCodIte := FCdsItensTmp.FieldByName('CODITE').AsString;
    strEmpIte := FCdsItensTmp.FieldByName('EMPITE').AsString;
    strNumLot := FCdsItensTmp.FieldByName('NUMLOT').AsString;
    fltQtdRes := FCdsItensTmp.FieldByName('QTDTRA').AsFloat -
                 FCdsItensTmp.FieldByName('TRAANT').AsFloat;

    For strEmpTra In FStlCodEmp Do
    Begin
      If strEmpTra = strEmpIte Then
        Continue;

      If Not fPermiteTransfEntreEmps(strEmpTra, strEmpIte) Then
        Continue;

      If fltQtdRes <= 0 Then
        Break;

      fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(strCodIte, strEmpTra, strNumLot);

      if FUtilizarSequencial then
      begin
        empresaAbastec := fEmpresaAbastecimento(strEmpTra, strCodIte, intAutInc);
        if not Assigned(empresaAbastec) then
          Continue;

        if empresaAbastec.varSeqTra = null then
          Continue;

        fltSalDis  := fltSalDis - empresaAbastec.fltEstMin;
      end;

      If fltSalDis <= 0 Then
        Continue;

      If fltSalDis < fltQtdRes Then
        fltQtdTra := fltSalDis
      Else
        fltQtdTra := fltQtdRes;

      fltQtdRes := fltQtdRes - fltQtdTra;

      FControleSaldoDisponivel.pDecrementarSaldoDisponivel(strCodIte, strEmpTra, strNumLot, fltQtdTra);
    End;

    If blnErro And (fltQtdRes > 0) Then
      Raise ESaldoSaldoInsuficienteParaAbastecimentoComTransferencia.Create('O Produto ' +
        strCodIte + ' não possui estoque suficiente nas outras lojas para abastecimento ' +
          'por transferência!');
  end;

begin
  FCdsItensTmp.First;

  While Not FCdsItensTmp.Eof Do
  Begin
    If (FCdsItensTmp.FieldByName('CODITE').AsString =  fField('CODITE').AsString) And
       (FCdsItensTmp.FieldByName('AUTINC').AsString <> fField('AUTINC').AsString) Then
    Begin
      pValidaEstoque(False);
    End;
    FCdsItensTmp.Next;
  End;

  If FCdsItensTmp.Locate('AUTINC', fField('AUTINC').AsString, []) Then
    pValidaEstoque(True);
end;

procedure TAbastecimentoItensPedido.pAfterPost(DataSet: TDataSet);
begin
  FCdsItensTmp.Data := FCdsItens.Data;
end;

procedure TAbastecimentoItensPedido.pApagarAbastecimentosAnteriorSemPedidoCompra();
  Var
    abastecimento: TAbastecimentoPedido;

  procedure pApagarRequisicaoCompra(strSequencialPrepRQ: String);
    Var
      qryReq: TUniQuery;
  begin
    If fEmptyStr(strSequencialPrepRQ) Then
      Exit;

    qryReq := fCriaQuery;

    Try
      qryReq.SQL.Text :=
        'SELECT DISTINCT RCD_CODIGO, RCD_CODEMP ' +
        'FROM PREPRQ ' +
        '  INNER JOIN MOVRCD ON RCD_CODIGO = PRQ_CODREQ ' +
        '                   AND RCD_CODEMP = PRQ_EMPREQ ' +
        'WHERE RCD_SEQCOT IS NULL ' + //nao possui cotacao
        '  AND RCD_SEQPCD IS NULL ' + //nao possui pedido de compra
        '  AND PREPRQ.AUTOINCREM = "' + strSequencialPrepRQ + '" ';

      qryReq.Open;

      While Not qryReq.Eof Do
      Begin
        pExcluiRequisicaoCompra(
          qryReq.FieldByName('RCD_CODIGO').AsString,
          qryReq.FieldByName('RCD_CODEMP').AsString,
          Self.ClassName);
        qryReq.Next;
      End;

    Finally
      qryReq.Free;
    End;
  end;

begin
  pCarregarAbastecimentosAnterior;

  For abastecimento In FAbastecimentosPedido Do
    pApagarRequisicaoCompra(abastecimento.strSequencialPrepRQ);

  pCarregarAbastecimentosAnterior;
end;

procedure TAbastecimentoItensPedido.pAtualizarAbastecimentosAnteriores(strIncFdoAnt,
  strIncFdoNov, strNumDoc, strEspDoc, strEmpDoc: String; opcTipAbs: TOpcaoAbastecimentoItem; strCodIte: String);
  Var
    qryFdoAbs: TUniQuery;
    abastecimento: TAbastecimentoPedido;

  procedure pAtualizaNumeroPedidoPreparaRQ;
  begin
    If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
      untFuncoesSimples.fExecutaSQL(
        ' UPDATE ' +
        '   PREPRQ ' +
        ' SET ' +
        '   PRQ_NUMDOC = "' + strNumDoc + '", ' +
        '   PRQ_ESPDOC = "' + strEspDoc + '", ' +
        '   PRQ_EMPDOC = "' + strEmpDoc + '"  ' +
        ' WHERE AUTOINCREM = "' + abastecimento.strSequencialPrepRQ + '" ');
  end;

  procedure pAtualizaNumeroPedidoRequisicaoCompra;
  begin
    If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
      untFuncoesSimples.fExecutaSQL(
        'UPDATE ' +
        '  PREPRQ ' +
        '  INNER JOIN MOVRCD ON MOVRCD.AUTOINCREM = PREPRQ.PRQ_SEQRCD ' +
        'SET ' +
        '  RCD_DOCPDV = "' + strNumDoc + '", ' +
        '  RCD_ESPPDV = "' + strEspDoc + '", ' +
        '  RCD_EMPPDV = "' + strEmpDoc + '"  ' +
        'WHERE ' +
        '  PREPRQ.AUTOINCREM = "' + abastecimento.strSequencialPrepRQ + '" ');
  end;

  procedure pAtualizaNumeroPedidoPreparaTE;
  var
    strLibera: String;
  begin
    strLibera := IIF((not FblnEhEmissaoPDAVista), ', PRE_LIBERA = "S" ', '');
    If Not fEmptyStr(abastecimento.strSequencialPrepTE) Then
      untFuncoesSimples.fExecutaSQL(
        ' UPDATE ' +
        '   PREPTE ' +
        ' SET ' +
        '   PRE_DOCABS = "' + strNumDoc + '", ' +
        '   PRE_ESPABS = "' + strEspDoc + '", ' +
        '   PRE_EMPABS = "' + strEmpDoc + '"  ' +
        strLibera +
        ' WHERE AUTOINCREM = "' + abastecimento.strSequencialPrepTE + '" ');
  end;

  procedure pAtualizaNumeroPedidoTranferencia;
  begin
    If Not fEmptyStr(abastecimento.strSequencialPrepTE) Then
      untFuncoesSimples.fExecutaSQL(
        ' UPDATE ' +
        '   PREPTE ' +
        '   INNER JOIN FATGOR ON FGO_NUMDOC = PRE_NUMDOC ' +
        '                    AND FGO_ESPDOC = PRE_ESPDOC ' +
        '                    AND FGO_CODEMP = PRE_EMPDOC ' +
        '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
        ' SET ' +
        '   FGO_NMPDAB = "' + strNumDoc + '", ' +
        '   FGO_ESPDAB = "' + strEspDoc + '", ' +
        '   FGO_EMPDAB = "' + strEmpDoc + '", ' +
        '   FGO_MEN001 = "Ref. Ped.Venda: ' + strNumDoc + '-' + strEspDoc + '-' + strEmpDoc + '" ' +
        ' WHERE PREPTE.AUTOINCREM = "' + abastecimento.strSequencialPrepTE + '" ');
  end;

begin
  qryFdoAbs := fCriaQuery;

  Try
    qryFdoAbs.Close;
    qryFdoAbs.SQL.Text := 'DELETE FROM FDOABS WHERE ABS_SEQFDO = ' + QuotedStr(strIncFdoAnt);
    qryFdoAbs.ExecSQL;

    qryFdoAbs.Close;
    qryFdoAbs.SQL.Text := 'SELECT * FROM FDOABS WHERE FALSE';
    qryFdoAbs.Open;

    For abastecimento In FAbastecimentosPedido Do
      If abastecimento.strSequencialFatdor = strIncFdoAnt Then
      Begin
        If Not fEmptyStr(abastecimento.strSequencialPrepRQ) And (opcTipAbs In [oaReqCompra, oaTodos]) Then
        Begin
          if not fEmptyStr(fCampoTabela('AUTOINCREM', 'PREPRQ', ['AUTOINCREM'], [abastecimento.strSequencialPrepRQ])) then
          begin
            qryFdoAbs.Append;
            qryFdoAbs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FDOABS', Vs_strCodEmp);
            qryFdoAbs.FieldByName('ABS_SEQFDO').AsString := strIncFdoNov;
            qryFdoAbs.FieldByName('ABS_SEQPRQ').AsString := abastecimento.strSequencialPrepRQ;
            qryFdoAbs.Post;

            pAtualizaNumeroPedidoPreparaRQ;
            pAtualizaNumeroPedidoRequisicaoCompra;
          end;
        End;

        If Not fEmptyStr(abastecimento.strSequencialPrepTE) And (opcTipAbs In [oaSolicitTransf, oaTodos]) Then
        Begin
          qryFdoAbs.Append;
          qryFdoAbs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FDOABS', Vs_strCodEmp);
          qryFdoAbs.FieldByName('ABS_SEQFDO').AsString := strIncFdoNov;
          qryFdoAbs.FieldByName('ABS_SEQPTE').AsString := abastecimento.strSequencialPrepTE;
          qryFdoAbs.Post;

          pAtualizaNumeroPedidoPreparaTE;
          pAtualizaNumeroPedidoTranferencia;
        End;
      End;
  Finally
    qryFdoAbs.Free;
  End;

  if FblnReqAut then
    pAtualizaSeqFDORequisicoesVinculadas(strIncFdoAnt, strIncFdoNov, strCodIte);
end;

procedure TAbastecimentoItensPedido.pAtualizarItensFaturamentoParcial;
  Var
    i: Integer;
begin
  SetProgressInfo('Aguarde, Atualizando itens faturamento parcial ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  For i := 0 To Length(TFatVenda(FObjVenda).arrMatItens) -1 Do
  Begin
    IncProgressPos(1);
    If FCdsItens.Locate('AUTINC', TFatVenda(FObjVenda).arrMatItens[i].intAutInc, []) Then
      TFatVenda(FObjVenda).arrMatItens[i].blnFatPar := fField('FATPAR').AsBoolean;
  End;
end;

procedure TAbastecimentoItensPedido.pAtualizarItensSelecionadosAbastecimento;
  Var
    i: Integer;
begin
  SetProgressInfo('Aguarde, Atualizando itens selecionados ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));
  For i := 0 To Length(TFatVenda(FObjVenda).arrMatItens) -1 Do
  Begin
    IncProgressPos(1);
    If FCdsItens.Locate('AUTINC', TFatVenda(FObjVenda).arrMatItens[i].intAutInc, []) Then
      TFatVenda(FObjVenda).arrMatItens[i].blnSelAbs := fField('ITESEL').AsBoolean;
  End;
end;

procedure TAbastecimentoItensPedido.pAtualizaSeqFDORequisicoesVinculadas(AstrIncFdoAnt, AstrIncFdoNov: String; strCodIte: String = '');
var
  cdsReq: TUniClientDataSet;
  cdsClo: TUniClientDataSet;
begin
  cdsReq := TFatVenda(FObjVenda).cdsVinculos;
  cdsReq.Filtered := False;

  if (not fEmptyStr(strCodIte)) then
  begin
    cdsReq.Filter := 'ITE_CODITE=' + QuotedStr(strCodIte);
    cdsReq.Filtered := True;
  end;

  cdsReq.First;
  while not cdsReq.Eof do
  begin
    if (cdsReq.FieldByName('SEQFDO').AsString = AstrIncFdoAnt) then
    begin
      cdsReq.Edit;
      cdsReq.FieldByName('SEQFDO').AsString := AstrIncFdoNov;
      cdsReq.Post;
    end;

    cdsReq.Next;
  end;

  cdsReq.Filtered := False;
  cdsReq.Filter := '';

  cdsClo := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(cdsClo, cdsReq);
    cdsReq.First;
    while not cdsReq.Eof do
    begin
      if (Not fEmptyStr(cdsReq.FieldByName('SEQFDO').AsString)) then
      begin
        cdsClo.Filtered := False;
        cdsClo.Filter := 'SEQFDO = ' + QuotedStr(cdsReq.FieldByName('SEQFDO').AsString);
        cdsClo.Filtered := True;

        If (cdsClo.RecordCount > 1) Then
          Raise Exception.Create('Atenção! Houve uma inconsistência ao gravar o relacionamento de vínculos de pedidos (FATVIN). Item: '
                                 +strCodIte+' ,por favor, entre em contato com a Citel');
      end;

      cdsReq.Next;
    end;
  finally
    FreeAndNil(cdsClo);
  end;
end;

procedure TAbastecimentoItensPedido.pBeforePost(DataSet: TDataSet);
  Var
    intDecQtd: Integer;
    strMsg: String;
    frmFatSelPedido: TfrmFatSelPedidoCompraRequisicao;

  procedure pComparaValores(fieldAtu, fieldAnt: TField);
  begin
    If Not SameValue(fFormataFloat(fieldAtu.AsFloat, intDecQtd),
                     fFormataFloat(fieldAnt.AsFloat, intDecQtd)) Then
      strMsg := strMsg +'* '+ fieldAtu.DisplayLabel +': '+ FormatFloat(fMskDigitos(intDecQtd), fieldAtu.AsFloat) +' / '+
                              fieldAnt.DisplayLabel +': '+ FormatFloat(fMskDigitos(intDecQtd), fieldAnt.AsFloat) + sLineBreak;
  end;
begin
  If Not fField('ALTQTD').AsBoolean Then
  Begin
    intDecQtd := fCfgSis('DECQTD', VarInteger);
    strMsg := '';

    pComparaValores(fField('QTDEST'), fField('ESTANT'));
    pComparaValores(fField('QTDREQ'), fField('REQANT'));
    pComparaValores(fField('QTDTRA'), fField('TRAANT'));

    If Not fEmptyStr(strMsg) Then
    Begin
      pMensagemOk('A quantidade para abastecimento informada anteriormente em ' +
        'comprar e transferência já são suficientes para atender a venda do produto ' +
        fField('CODITE').AsString +'-'+ fField('DESITE').AsString + sLineBreak +
        Trim(strMsg), 500, 250);
      DataSet.Cancel;
      Abort;
    End;
    Exit;
  End;

  If fField('QTDEST').AsFloat < 0 Then
  Begin
    pMensagemOk('A quantidade para abastecimento informada em estoque não ' +
      'pode ser negativa!');
    DataSet.Cancel;
    Abort;
  End;

  If (fField('QTDREQ').AsFloat < 0) Then
  Begin
    pMensagemOk('A quantidade para abastecimento informada em comprar não ' +
      'pode ser negativa!');
    DataSet.Cancel;
    Abort;
  End;

  If (fField('QTDTRA').AsFloat < 0) Then
  Begin
    pMensagemOk('A quantidade para abastecimento informada em transferência não ' +
      'pode ser negativa!');
    DataSet.Cancel;
    Abort;
  End;

  If (fField('TRAANT').AsFloat > 0) And
     (fField('QTDTRA').AsFloat < fField('TRAANT').AsFloat) Then
  Begin
    pMensagemOk('A quantidade para abastecimento informada em transferência não ' +
      'pode ser inferior a quantidade já solicitada anteriormente!');
    DataSet.Cancel;
    Abort;
  End;

  If (fField('REQANT').AsFloat > 0) And
     (fField('QTDREQ').AsFloat < fField('REQANT').AsFloat) Then
  Begin
    pMensagemOk('A quantidade para abastecimento informada em comprar não ' +
      'pode ser inferior a quantidade já solicitada em requisição de compra ' +
      'anteriormente!');
    DataSet.Cancel;
    Abort;
  End;

  If Not fCfgSis('TRCPPD', varBoolean) Then
  Begin
    If fFormataFloat( fField('QTDEST').AsFloat +
                      fField('QTDREQ').AsFloat +
                      fField('REQSOL').AsFloat +
                      fField('QTDTRA').AsFloat, 4 ) <> fFormataFloat(fField('QTDITE').AsFloat, 4) Then
    Begin
      pMensagemOk('A quantidade para abastecimento informada em estoque, ' +
        'comprar e transferência somadas deve ser igual à quantidade do item!');
      DataSet.Cancel;
      Abort;
    End;
  End
  Else
  Begin
    If fFormataFloat( fField('QTDREQ').AsFloat +
                      fField('REQSOL').AsFloat +
                      fField('QTDTRA').AsFloat, 4 ) = fFormataFloat(fField('QTDITE').AsFloat, 4) Then
    Begin
      fField('QTDEST').AsFloat := 0;
    End
    Else If fFormataFloat( fField('QTDREQ').AsFloat +
                           fField('REQSOL').AsFloat +
                           fField('QTDTRA').AsFloat, 4 ) < fFormataFloat(fField('QTDITE').AsFloat, 4) Then
    Begin
      fField('QTDEST').AsFloat := fFormataFloat(fField('QTDITE').AsFloat, 4) -
                                  (fFormataFloat( fField('QTDREQ').AsFloat +
                                                  fField('REQSOL').AsFloat +
                                                  fField('QTDTRA').AsFloat, 4 ))
    End
    Else If fFormataFloat( fField('QTDREQ').AsFloat +
                           fField('REQSOL').AsFloat +
                           fField('QTDTRA').AsFloat, 4 ) > fFormataFloat(fField('QTDITE').AsFloat, 4) Then
    Begin
      pMensagemOk('A quantidade para abastecimento informada em comprar '+
                  'e transferência somadas não pode ser maior que '+
                  'à quantidade do item!');
      DataSet.Cancel;
      Abort;
    End;

  End;

  If (fField('QTDREQ').AsFloat > 0) And (fRetAtiComItem(fField('CODITE').AsString) = 'N') Then
  Begin
    pMensagemOk('Não permitido informar quantidade em comprar para o item ' +
      fField('CODITE').AsString + ' pois o mesmo não está ativo para compras!');
    DataSet.Cancel;
    Abort;
  End;

  pChamaAvisoDeTravaComQtdCompraInformado(fField('QTDITE').AsFloat, fField('QTDREQ').AsFloat, fField('CODITE').AsString, fField('AUTINC').AsInteger);

  If FCdsItensTmp.Locate('AUTINC', fField('AUTINC').AsInteger, []) Then
  Begin
    FCdsItensTmp.Edit;
    FCdsItensTmp.FieldByName('QTDEST').AsFloat := fField('QTDEST').AsFloat;
    FCdsItensTmp.FieldByName('QTDREQ').AsFloat := fField('QTDREQ').AsFloat;
    FCdsItensTmp.FieldByName('QTDTRA').AsFloat := fField('QTDTRA').AsFloat;
    FCdsItensTmp.Post;

    Try
      pValidarEstoqueDisponivel;
    Except
      On E: ESaldoSaldoInsuficienteParaAbastecimentoComEstoque Do
      Begin
        pMensagemOk(E.Message);
        Abort;
      End;

      On E: ESaldoSaldoInsuficienteParaAbastecimentoComTransferencia Do
      Begin
        pMensagemOk(E.Message);
        Abort;
      End;

      On E: Exception Do
        Raise;
    End;
  End;

  if FblnValidarTodos and FblnReqAut then
  begin
    if (fField('QTDREQ').AsFloat > 0) then
    begin
      if (fMensagem('', 'O item ' + fField('CODITE').AsString +'-'+ fField('DESITE').AsString + ' ainda possui quantidade ' + FloatToStr(fField('QTDREQ').AsFloat) +
        ' a ser requisitada.' + #13 + 'Deseja gerar a requisição?', ['&Sim', '&Não']) = 2) then
      begin
        DataSet.Cancel;
        Abort;
      end;

      pCriarFormularios(TfrmFatSelPedidoCompraRequisicao, frmFatSelPedido);

      try
        frmFatSelPedido.FstrCodIte := fField('CODITE').AsString;
        frmFatSelPedido.FfltQtdIte := fField('QTDREQ').AsFloat;
        frmFatSelPedido.ShowModal;

        if (frmFatSelPedido.ModalResult = mrCancel) then
        begin
          DataSet.Cancel;
          Abort;
        end;

        fField('REQSOL').AsFloat := fField('REQSOL').AsFloat + fField('QTDREQ').AsFloat;
        fField('QTDREQ').AsFloat := 0;
      finally
        pFreeAndNil(frmFatSelPedido);
      end;
    end;
  end;
end;

procedure TAbastecimentoItensPedido.pIniciarQuantidades;
  Var
    fltCompra: Double;
    fltTransf: Double;
    fltDifQtd: Double;
begin
  fltCompra := IIF(FblnReqAut, 0, fQuantidadeJaEmReqCompra(fField('SEQFDO').AsString));
  fltTransf := fQuantidadeJaEmTransferencia(fField('SEQFDO').AsString);

  fltDifQtd := fFormatafloat(fltCompra + fltTransf - fField('QTDITE').AsFloat, 4);

  If fltDifQtd > 0 Then
    If fltCompra >= fltDifQtd Then
      fltCompra := fltCompra - fltDifQtd
    Else
      fltCompra := 0;

  fltDifQtd := fFormatafloat(fltCompra + fltTransf - fField('QTDITE').AsFloat, 4);

  If fltDifQtd > 0 Then
    If fltTransf >= fltDifQtd Then
      fltTransf := fltTransf - fltDifQtd
    Else
      fltTransf := 0;

  fltDifQtd := fFormatafloat(fltCompra + fltTransf - fField('QTDITE').AsFloat, 4);

  fField('QTDEST').AsFloat   := 0;
  fField('QTDREQ').AsFloat   := fltCompra;
  fField('QTDTRA').AsFloat   := fltTransf;
  fField('ALTQTD').AsBoolean := fltDifQtd < 0;
  fField('ESTANT').AsFloat   := 0;
  fField('REQANT').AsFloat   := fltCompra;
  fField('TRAANT').AsFloat   := fltTransf;
end;

procedure TAbastecimentoItensPedido.pDefineQuantidadeEstoque;
  Var
    fltSalDis: Double;
    fltQtdRestante: Double;

  procedure pArredondaSaldoMltVen();
  var
    fltMltVen: Double;
    fltResto: Double;
    intDecQtd: Integer;
  begin
    intDecQtd := fCfgSis('DECQTD', varInteger);
    fltMltVen := fFormataFloat(fRetMltVenItem(fField('CODITE').AsString), intDecQtd);

    If (fltMltVen <= 0) Then
      Exit;

    If (fltSalDis = fltQtdRestante) Then
      Exit;

    fltResto := Frac(fFormataFloat(fltSalDis / fltMltVen, intDecQtd));

    If (fFormataFloat(fltResto, intDecQtd) = 0) Then
      Exit;

    fltResto := Trunc(fFormataFloat(fltSalDis / fltMltVen, intDecQtd));

    fltSalDis := fFormataFloat(fltResto * fltMltVen, intDecQtd);
  end;
begin
  pSetaQtdItemRestante(fltQtdRestante);

  fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(fField('CODITE').AsString,
                                                                fField('EMPITE').AsString,
                                                                fField('NUMLOT').AsString);
  pArredondaSaldoMltVen();

  If (fltQtdRestante > 0) And (fltSalDis > 0) Then
  Begin
    If (fltSalDis > fltQtdRestante) Then
    Begin
      fField('QTDEST').AsFloat := fltQtdRestante;
      fltQtdRestante := 0;
    End
    Else
    Begin
      fField('QTDEST').AsFloat := fltSalDis;
      fltQtdRestante := fltQtdRestante - fltSalDis;
    End;

    FControleSaldoDisponivel.pDecrementarSaldoDisponivel(fField('CODITE').AsString,
      fField('EMPITE').AsString, fField('NUMLOT').AsString, fField('QTDEST').AsFloat);
  End;
end;

procedure TAbastecimentoItensPedido.pDefineQuantidadeTransferir;
  Var
    fltQtdRestante: Double;
    strEmpTra: String;
    fltQtdTra: Double;
    fltSalDis: Double;
    blnApenasLoteTotal: Boolean;
    recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
begin
  blnApenasLoteTotal := FblnConsiderarLoteSaldoTotal and (not fEmptyStr(fField('NUMLOT').AsString));
  pSetaQtdItemRestante(fltQtdRestante);

  For strEmpTra In FStlCodEmp Do
  Begin
    If strEmpTra = fField('EMPITE').AsString Then
      Continue;

    If Not fPermiteTransfEntreEmps(strEmpTra, fField('EMPITE').AsString) Then
      Continue;

    If fltQtdRestante <= 0 Then
      Break;

    fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(fField('CODITE').AsString,
      strEmpTra, fField('NUMLOT').AsString);

    If fltSalDis <= 0 Then
      Continue;

    If (fltSalDis >= fltQtdRestante) Then
    Begin
      fltQtdTra := fltQtdRestante;
      fltQtdRestante := 0;
    End
    Else If blnApenasLoteTotal Then
      fltQtdTra := 0
    Else
    Begin
      fltQtdTra := fltSalDis;
      fltQtdRestante := fltQtdRestante - fltSalDis;
    End;

    fField('QTDTRA').AsFloat := fField('QTDTRA').AsFloat + fltQtdTra;

    FControleSaldoDisponivel.pDecrementarSaldoDisponivel(fField('CODITE').AsString,
      strEmpTra, fField('NUMLOT').AsString, fltQtdTra);
  End;

  if FTravaAbastecimentoPorCompra.TryGetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento) then
  begin
    recProdutosDoPedidoDeAbastecimento.fltQtdTra := fRetornaSaldoDisponivelParaTransferencia;
    FTravaAbastecimentoPorCompra.AddOrSetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento);
  end;
end;

procedure TAbastecimentoItensPedido.pDefineQuantidadeTransferirSequencial;
var
  blnApenasLoteTotal: Boolean;

  function fDefineQuantidadeTransferirTotal(fltQtdRestante: Double): Boolean;
  Var
    strEmpTra: String;
    fltSalDis: Double;
    empresaAbastec: TEmpresaAbastecimento;
    recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
  begin
    Result := False;
    For strEmpTra In FStlCodEmp Do
    Begin
      If strEmpTra = fField('EMPITE').AsString Then
        Continue;

      If Not fPermiteTransfEntreEmps(strEmpTra, fField('EMPITE').AsString) Then
        Continue;

      If fltQtdRestante <= 0 Then
        Break;

      fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(fField('CODITE').AsString,
        strEmpTra, fField('NUMLOT').AsString);

      If fltSalDis <= 0 Then
        Continue;

      If fltSalDis >= fltQtdRestante Then
      begin
        empresaAbastec := fEmpresaAbastecimento(strEmpTra, fField('CODITE').AsString, fField('AUTINC').AsInteger);
        if Assigned(empresaAbastec) then
        begin
          if empresaAbastec.varSeqTra = null then
            Continue;

          if (fltSalDis - fltQtdRestante >= empresaAbastec.fltEstMin) then
          begin
            Result := True;

            fField('QTDTRA').AsFloat := fField('QTDTRA').AsFloat + fltQtdRestante;

            FControleSaldoDisponivel.pDecrementarSaldoDisponivel(
              fField('CODITE').AsString,
               strEmpTra,
               fField('NUMLOT').AsString,
               fltQtdRestante);

            Break;
          end;
        end;
      end;
    End;

    if FTravaAbastecimentoPorCompra.TryGetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento) then
    begin
      recProdutosDoPedidoDeAbastecimento.fltQtdTra := fRetornaSaldoDisponivelParaTransferencia;
      FTravaAbastecimentoPorCompra.AddOrSetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento);
    end;
  end;

  function fDefineQuantidadeTransferirParcial(fltQtdRestante: Double): Boolean;
  Var
    strEmpTra: String;
    fltQtdTra: Double;
    fltSalDis: Double;
    empresaAbastec: TEmpresaAbastecimento;
    recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
  begin
    Result := False;
    pSetaQtdItemRestante(fltQtdRestante);
    For strEmpTra In FStlCodEmp Do
    Begin
      If strEmpTra = fField('EMPITE').AsString Then
        Continue;

      If Not fPermiteTransfEntreEmps(strEmpTra, fField('EMPITE').AsString) Then
        Continue;

      If fltQtdRestante <= 0 Then
        Break;

      fltSalDis := FControleSaldoDisponivel.fRetornaSaldoDisponivel(fField('CODITE').AsString,
        strEmpTra, fField('NUMLOT').AsString);

      If fltSalDis <= 0 Then
        Continue;

      empresaAbastec := fEmpresaAbastecimento(strEmpTra, fField('CODITE').AsString, fField('AUTINC').AsInteger);
      if not Assigned(empresaAbastec) then
        Continue;

      if empresaAbastec.varSeqTra = null then
        Continue;

      fltSalDis  := fltSalDis - empresaAbastec.fltEstMin;

      If (fltSalDis >= fltQtdRestante) Then
      Begin
        fltQtdTra := fltQtdRestante;
        fltQtdRestante := 0;
      End
      Else If blnApenasLoteTotal Then
        fltQtdTra := 0
      Else
      Begin
        fltQtdTra := fltSalDis;
        fltQtdRestante := fltQtdRestante - fltSalDis;
      End;

      fField('QTDTRA').AsFloat := fField('QTDTRA').AsFloat + fltQtdTra;

      FControleSaldoDisponivel.pDecrementarSaldoDisponivel(
        fField('CODITE').AsString,
         strEmpTra,
         fField('NUMLOT').AsString,
         fltQtdTra);

      if fltQtdRestante = 0 then
      begin
        Result := True;
        Break;
      end;
    End;

    if not Result then
    begin
      FControleSaldoDisponivel.pIncrementarSaldoDisponivel(
        fField('CODITE').AsString,
         strEmpTra,
         fField('NUMLOT').AsString,
         fField('QTDTRA').AsFloat);

      fField('QTDTRA').AsFloat := 0;
    end;

    if FTravaAbastecimentoPorCompra.TryGetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento) then
    begin
      recProdutosDoPedidoDeAbastecimento.fltQtdTra := fRetornaSaldoDisponivelParaTransferencia;
      FTravaAbastecimentoPorCompra.AddOrSetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento);
    end;
  end;

var
  fltQtdRestante: Double;
begin
  blnApenasLoteTotal := FblnConsiderarLoteSaldoTotal and (not fEmptyStr(fField('NUMLOT').AsString));
  pSetaQtdItemRestante(fltQtdRestante);

  if (TFatVenda(FObjVenda).strOriF11 = 'S') and (fltQtdRestante = 0) then
    Exit;

  If (fltQtdRestante > 0) Then
  Begin
    If (Not fDefineQuantidadeTransferirTotal(fltQtdRestante)) Then
      fDefineQuantidadeTransferirParcial(fltQtdRestante);
  End;
end;

procedure TAbastecimentoItensPedido.pDefineQuantidadeComprar;
  Var
    fltQtdRestante: Double;
begin
  pSetaQtdItemRestante(fltQtdRestante);
  If (fltQtdRestante > 0) Then
  Begin
    fField('QTDREQ').AsFloat := fField('QTDREQ').AsFloat + fltQtdRestante;
    fltQtdRestante := 0;
  End;
end;

procedure TAbastecimentoItensPedido.pSetaQtdItemRestante(Var fltQtdRestante: Double);
begin
  fltQtdRestante := fField('QTDITE').AsFloat -
                    fField('QTDEST').AsFloat -
                    fField('QTDREQ').AsFloat -
                    fField('REQSOL').AsFloat -
                    fField('QTDTRA').AsFloat;
end;

procedure TAbastecimentoItensPedido.pCalcularFormaAbastecimentoItens;

  procedure pProcessarItens(pExecutar: TGenericProcedure; AInfo: String);
  begin
    SetProgressInfo('Aguarde, ' + AInfo + ' ...');
    SetProgressMax(FCdsItens.RecordCount);

    FCdsItens.First;
    While Not FCdsItens.Eof Do
    Begin
      IncProgressPos(1);
      FCdsItens.Edit;
      pExecutar;
      FCdsItens.Post;
      FCdsItens.Next;
    End;
    FCdsItens.First;
  end;

begin
  FControleSaldoDisponivel.pIniciarSaldoDisponivel;

  pProcessarItens(pIniciarQuantidades, 'Iniciando quantidades');
  pProcessarItens(pDefineQuantidadeEstoque, 'Definindo quantidade estoque');

  If FUtilizarSequencial Then
    pProcessarItens(pDefineQuantidadeTransferirSequencial, 'Definindo quantidade transferência')
  Else
    pProcessarItens(pDefineQuantidadeTransferir, 'Definindo quantidade transferir');

  pProcessarItens(pDefineQuantidadeComprar, 'Definindo quantidade comprar');

  FCdsItensTmp.Data := FCdsItens.Data;
end;

procedure TAbastecimentoItensPedido.pCarregarAbastecimentosAnterior;
  Var
    qryFdoAbs: TUniQuery;
    item: TDadosFechamento;
    abastecimento: TAbastecimentoPedido;
begin
  If Not Assigned(FAbastecimentosPedido) Then
    FAbastecimentosPedido := TList<TAbastecimentoPedido>.Create;

  FAbastecimentosPedido.Clear;
  FAbastecimentosPedido.TrimExcess;

  qryFdoAbs := fCriaQuery;
  qryFdoAbs.SQL.Add('SELECT * FROM FDOABS WHERE ABS_SEQFDO = :SEQFDO');

  SetProgressInfo('Aguarde, Carregando abastecimentos anterior ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    IncProgressPos(1);

    qryFdoAbs.Close;
    qryFdoAbs.ParamByName('SEQFDO').AsString := item.strSeqDet;
    qryFdoAbs.Open;

    qryFdoAbs.First;
    While Not qryFdoAbs.Eof Do
    Begin
      abastecimento := TAbastecimentoPedido.Create;
      abastecimento.strSequencialFatdor := qryFdoAbs.FieldByName('ABS_SEQFDO').AsString;
      abastecimento.strSequencialPrepRQ := qryFdoAbs.FieldByName('ABS_SEQPRQ').AsString;
      abastecimento.strSequencialPrepTE := qryFdoAbs.FieldByName('ABS_SEQPTE').AsString;
      FAbastecimentosPedido.Add(abastecimento);
      qryFdoAbs.Next;
    End;
  End;

  FreeAndNil(qryFdoAbs);
end;

procedure TAbastecimentoItensPedido.pCarregaRequisicoesSolicitadas;
var
  fltQtdIte: Double;
  fltReqSol: Double;
  fltTotReqSol: Double;
begin
  FCdsItens.First;

  while not FCdsItens.Eof do
  begin
    fltTotReqSol := fTotalJaVinculado;
    fltQtdIte := fField('QTDITE').AsFloat;

    if fltTotReqSol > fltQtdIte then
      fltReqSol := fltQtdIte
    else
      fltReqSol := fltTotReqSol;

    FCdsItens.Edit;
    fField('REQSOL').AsFloat   := fltReqSol;
    FCdsItens.Post;

    FCdsItens.Next;
  end;
end;

procedure TAbastecimentoItensPedido.pCarregarItens;
  Var
    strCodEmp: String;
    item: TDadosFechamento;
    fltSaldoDisponivel: Double;
    fltReservaItem: Double;
    stlAux: TStringList;
    recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
begin
  SetProgressInfo('Aguarde, Carregando itens ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  FCdsItens.EmptyDataSet;
  stlAux := TStringList.Create;
  FTravaAbastecimentoPorCompra.Clear;

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    IncProgressPos(1);

    If item.strIdePro <> 'NOR' Then
      Continue;

    If item.strCodAca <> '' Then
      Continue;

    If fEhItemServico(item.strCodIte) Then
      Continue;

    If item.strCodIte = fCfgSis('ITEVID') Then
      Continue;

    If item.strCodIte = fCfgSis('ITEBOM') Then
      Continue;

    If item.strCodIte = fCfgSis('ITEMAN') Then
      Continue;

    If item.strCodIte = fCfgSis('ITELAN') Then
      Continue;

    If item.strCodIte = fCfgSis('ITETAX') Then
      Continue;

    If item.strCodIte = fCfgSis('ITEFRE') Then
      Continue;

    {Req.: 135671 - Item Estrutura}
    If fItemEstrutura(item.strCodIte) And (fCfgSis('BXSBIT') = '2') Then
      Continue;

    If (stlAux.IndexOf(item.strCodIte) <> -1) Then
      FStlItensDup.Add(item.strCodIte);
    stlAux.Add(item.strCodIte);

    FCdsItens.Append;

    fField('ITESEL').AsBoolean := False;
    fField('ALTQTD').AsBoolean := True;
    fField('AUTINC').AsInteger := item.intAutInc;
    fField('SEQFDO').AsString  := item.strSeqDet;
    fField('CODITE').AsString  := item.strCodIte;
    fField('NUMLOT').AsString  := item.strNumLot;
    fField('DESITE').AsString  := item.strDesIte;
    fField('QTDITE').AsFloat   := item.fltQtdIte;
    fField('VALUNI').AsFloat   := item.fltUnitar;
    fField('TOTITE').AsFloat   := item.fltTotIte;
    fField('FATPAR').AsBoolean := True;
    fField('EMPITE').AsString  := item.strEmpIte;
    fField('EMPFIL').AsString  := fRetFantasiaEmpresa(item.strEmpIte);
    fField('LOTTOT').AsBoolean := FblnConsiderarLoteSaldoTotal and TFatVenda(FObjVenda).objCadLot.fExisteLote(item.strCodIte, item.strEmpIte);

    For strCodEmp In FStlCodEmp Do
    Begin
      fltSaldoDisponivel := fSaldoDisponivel(item, strCodEmp);

      fField('EST_EMP_' + strCodEmp).AsFloat := fltSaldoDisponivel;

      If strCodEmp = item.strEmpIte Then
        fField('QTDLOJ').AsFloat := fltSaldoDisponivel
      Else
        fField('QTDFIL').AsFloat := fField('QTDFIL').AsFloat + fltSaldoDisponivel;
    End;

    If FExibirProdutoEmEstoque Then
    Begin
      fField('EM_EST').Visible := True;
      fField('ESTRES').Visible := True;

      fltReservaItem := fFormataFloat(fQuantidadeReservaItem(item.strSeqDet), 4);

      fField('ESTRES').AsFloat := fltReservaItem;

      If fltReservaItem >= fFormataFloat(item.fltQtdIte, 4) Then
        fField('EM_EST').AsString := 'Sim'
      Else If fltReservaItem <= 0.00 Then
        fField('EM_EST').AsString := 'Não'
      Else
        fField('EM_EST').AsString := 'Parcialmente';
    End;

    FillChar(recProdutosDoPedidoDeAbastecimento, SizeOf(recProdutosDoPedidoDeAbastecimento), #0);
    recProdutosDoPedidoDeAbastecimento.strCodIte := item.strCodIte;
    recProdutosDoPedidoDeAbastecimento.strDesIte := item.strDesIte;

    if (not FTravaAbastecimentoPorCompra.TryGetValue(item.intAutInc, recProdutosDoPedidoDeAbastecimento)) then
      FTravaAbastecimentoPorCompra.Add(item.intAutInc, recProdutosDoPedidoDeAbastecimento);

    FCdsItens.Post;
  End;

  stlAux.Free;
  FCdsItensTmp.Data := FCdsItens.Data;
end;

procedure TAbastecimentoItensPedido.pChamaAvisoDeTravaComQtdCompraInformado(
  fltQtdItem, fltQtdCompra: Double; strCodIte: String; intAutInc: Integer);
var
  recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
begin
  If Not fCfgSis('INFCOM', varBoolean) Then
    Exit;

  If Not fVerificaAcessoSistema('GRCOET') Then
    Exit;

  If fltQtdCompra <= 0 Then
    Exit;

  if FTravaAbastecimentoPorCompra.TryGetValue(intAutInc, recProdutosDoPedidoDeAbastecimento) then
  begin
    If recProdutosDoPedidoDeAbastecimento.fltQtdTra < fltQtdItem Then
      Exit;

    If recProdutosDoPedidoDeAbastecimento.blnTrava Then
      Exit;

    recProdutosDoPedidoDeAbastecimento.fltQtdCom := fltQtdCompra;
    recProdutosDoPedidoDeAbastecimento.blnTrava := True;
    FTravaAbastecimentoPorCompra.AddOrSetValue(intAutInc, recProdutosDoPedidoDeAbastecimento);

    pMensagemOk('Aviso - O produto '+strCodIte+' possui estoque suficiente nas outras lojas '+
                'para abastecimento por transferência, ao final será solicitado senha de liberação.');
  end;
end;

procedure TAbastecimentoItensPedido.pConfirmaAbastecimento;
begin
  pAtualizarItensSelecionadosAbastecimento;
  pAtualizarItensFaturamentoParcial;

  if FUtilizarSequencial then
    pDeterminaEmpresasTransferenciaSequencial
  else
    pDeterminaEmpresasTransferencia;

  pSepararItensPorTipoAbastecimento;
end;

function TAbastecimentoItensPedido.fIniciarSaldoDisponivel(AProgresso: TcxProgressBar = nil): Boolean;
  Var
    strCodEmp: String;
    item: TDadosFechamento;
    blnApenasLoteTotal: Boolean;
begin
  Result := True;
  FProgresso := AProgresso;
  Try
    FControleSaldoDisponivel := TControleSaldoDisponivel.Create(FObjVenda);

    SetProgressInfo('Aguarde, Calculando saldo disponível dos itens ...');
    SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens) * FStlCodEmp.Count);

    For item In TFatVenda(FObjVenda).arrMatItens Do
    Begin
      blnApenasLoteTotal := FblnConsiderarLoteSaldoTotal and TFatVenda(FObjVenda).objCadLot.fExisteLote(item.strCodIte, item.strEmpIte);

      For strCodEmp In FStlCodEmp Do
      Begin
        IncProgressPos(1);
        if blnApenasLoteTotal then
          FControleSaldoDisponivel.pAddItemLote(item.strCodIte, item.strEmpIte, strCodEmp, item.strNumLot, item.strSeqDet, item.fltQtdIte)
        else
          FControleSaldoDisponivel.pAddItem(item.strCodIte, strCodEmp, item.strNumLot, item.strSeqDet);
      End;
    End;

  Finally
    FProgresso := nil;
  End;
end;

function TAbastecimentoItensPedido.fLiberaTravaQuantidadeDeCompra: Boolean;
var
  blnTemItensParaTravar: Boolean;
  recProdutosDoPedidoDeAbastecimento: TProdutosDoPedidoDeAbastecimento;
  objLiberacao : TLiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  Result := True;
  blnTemItensParaTravar := False;

  objLiberacao := TLiberacao.Create;

  try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir gerar requisição de compra quando item possui saldo em outras empresas para transferência!');
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa solicitante', VS_strCodEmp + '-' + fRetNomeEmpresa);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'Cod.'        , fTamCodIte , alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'Descrição'   , 80, alEsquerda, teAutcom);
    objLinha.pAddColuna('', 'Qtde Comprar', 14, alDireita , teAutcom);
    objLinha.pAddColuna('', 'Qtde Filiais', 14, alDireita , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    FCdsItens.First;

    while not FCdsItens.Eof do
    begin
      if FTravaAbastecimentoPorCompra.TryGetValue(fField('AUTINC').AsInteger, recProdutosDoPedidoDeAbastecimento) then
      begin
        if recProdutosDoPedidoDeAbastecimento.blnTrava then
        begin
          blnTemItensParaTravar := True;

          objLinha := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('Cod.'        , recProdutosDoPedidoDeAbastecimento.strCodIte                                                          , fTamCodIte   );
          objLinha.pAddColuna('Descrição'   , recProdutosDoPedidoDeAbastecimento.strDesIte                                                          , 80           );
          objLinha.pAddColuna('Qtde Comprar', FloatToStrF(recProdutosDoPedidoDeAbastecimento.fltQtdCom, ffFixed, 12, fCfgSis('DECQTD', varInteger)) , 14, alDireita);
          objLinha.pAddColuna('Qtde Filiais', FloatToStrF(recProdutosDoPedidoDeAbastecimento.fltQtdTra, ffFixed, 12, fCfgSis('DECQTD', varInteger)) , 14, alDireita);

          objTabela.lstLinhas.Add(objLinha);
        end;
      end;
      FCdsItens.Next;
    end;

    if not blnTemItensParaTravar then
      Exit;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', TFatVenda(FObjVenda).strCodCli + '-' + TFatVenda(FObjVenda).strCliNom);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ', TFatVenda(FObjVenda).strCliCgc);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia', fRetNomFantasia(TFatVenda(FObjVenda).strCodCli));
    objLiberacao.objMsgLibera.pAddSeparador(fTamCodIte + 117);

    objLiberacao.strDirAce := 'GRCOET';
    objLiberacao.strMsgSen := 'Liberação de compra com saldo em outras empresas.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
end;

function TAbastecimentoItensPedido.fLimitarEstoqueATransferirPeloEstoqueMinimoDaEmpresa: Boolean;
begin

  Result := False;

  If Not fCfgSis('SLTFRC', varBoolean) Then
    Exit;

  If Not fCfgSis('ESTMIN', varBoolean) Then
    Exit;

  Result := True;

end;

procedure TAbastecimentoItensPedido.pDefinirCampos;
  Var
    intDecQtd: Integer;
    intDecUni: Integer;
    strEmpresa: String;
    blnExiFatPar: Boolean;

  procedure pAddCampo(Name, DisplayLabel, Format: String; DataType: TFieldType;
    Size: Integer = 0; Precision: Integer = 0; Visible: Boolean = True);
    var
      FieldInf: TFieldDefInf;
  begin
    FieldInf.Name := Name;

    FieldInf.DisplayLabel  := DisplayLabel;
    FieldInf.DisplayFormat := Format;
    FieldInf.DataType      := DataType;
    FieldInf.Size          := Size;
    FieldInf.Precision     := Precision;
    FieldInf.Visible       := Visible;

    FCampos.Add(FieldInf);
  end;

begin
  FCampos := TList<TFieldDefInf>.Create;

  blnExiFatPar := (fCfgExpedicaoParcialHabilitada) And (fCfgSis('FTEXPC', varBoolean));

  intDecQtd := Max(3, fCfgSis('DECQTD', VarInteger));
  intDecUni := fCfgSis('DECUNI', VarInteger);

  pAddCampo('ITESEL', '...', '', ftBoolean);
  pAddCampo('ALTQTD', 'Alt.Qtde', '', ftBoolean, 0, 0, False);
  pAddCampo('AUTINC', 'Aut.Inc', '', ftInteger, 0, 0, False);
  pAddCampo('SEQFDO', 'Seq.Fdo.', '', ftString, 20, 0, False);
  pAddCampo('CODITE', 'Código', '', ftString, fTamCodIte);
  pAddCampo('NUMLOT', 'Lote', '', ftString, VS_Size_NumLot, 0, False);
  pAddCampo('DESITE', 'Produto', '', ftString, 100);
  pAddCampo('QTDITE', 'Qtde', fMskDigitos(intDecUni), ftFloat);
  pAddCampo('VALUNI', 'Vr.Unitário', fMskDigitos(intDecUni), ftFloat);
  pAddCampo('TOTITE', 'Vr.Total', fMskDigitos(2), ftFloat);
  pAddCampo('QTDEST', 'Estoque', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('QTDREQ', 'Comprar', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('REQSOL', 'Requisitada', fMskDigitos(intDecQtd), ftFloat, 0, 0, FblnReqAut);
  pAddCampo('QTDTRA', 'Transf.', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('ESTANT', 'Estoque (Ant.)', fMskDigitos(intDecQtd), ftFloat, 0, 0, False);
  pAddCampo('REQANT', 'Comprar (Ant.)', fMskDigitos(intDecQtd), ftFloat, 0, 0, False);
  pAddCampo('TRAANT', 'Transf. (Ant.)', fMskDigitos(intDecQtd), ftFloat, 0, 0, False);
  pAddCampo('EM_EST', 'Em Estoque', '', ftString, 20, 0, False);
  pAddCampo('ESTRES', 'Est. Reserv.', fMskDigitos(intDecQtd), ftFloat, 0, 0, False);
  pAddCampo('FATPAR', 'Fat.Parcial', '', ftBoolean, 0, 0, blnExiFatPar);
  pAddCampo('EMPITE', 'Emp.', '', ftString, 3, 0, False);
  pAddCampo('EMPFIL', 'Filial', '', ftString, 20);
  pAddCampo('QTDCOM', 'Qtde Compras', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('DTAENT', 'Data Prev.Ent.', '', ftDate);
  pAddCampo('QTDLOJ', 'Qtde Loja', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('QTDFIL', 'Qtde Filiais', fMskDigitos(intDecQtd), ftFloat);
  pAddCampo('LOTTOT', 'Lote Total', '', ftBoolean, 0, 0, False);

  For strEmpresa In FStlEmpresas Do
    pAddCampo('EST_EMP_' + LeftStr(strEmpresa, 3), Copy(strEmpresa, 1, 11),
      fMskDigitos(intDecQtd), ftFloat);
end;

procedure TAbastecimentoItensPedido.pDeterminaEmpresasTransferencia;
  Var
    fltQtdRestante: Double;
    item: TDadosFechamento;
    blnApenasLoteTotal: Boolean;

  function fEmpresaComMaiorDiasDeEstoque: String;
    Var
      strEmpMaior: String;
      intDiasMaior: Integer;
      fltSaldoDisponivel: Double;
      empresaAbastec: TEmpresaAbastecimento;
  begin
    strEmpMaior  := '';
    intDiasMaior := -1;

    For empresaAbastec In FEmpresasAbastecimento Do
    Begin
      If (empresaAbastec.intAutInc <> item.intAutInc) Then
        Continue;

      If empresaAbastec.strEmpIte = empresaAbastec.strEmpTra Then
        Continue;

      fltSaldoDisponivel := FControleSaldoDisponivel.fRetornaSaldoDisponivel(
        empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

      If fltSaldoDisponivel <= 0 Then
        Continue;

      If empresaAbastec.intDiaEst > intDiasMaior Then
      Begin
        strEmpMaior  := empresaAbastec.strEmpTra;
        intDiasMaior := empresaAbastec.intDiaEst;
      End;
    End;

    Result := strEmpMaior;
  end;

  procedure pDefineQuantidadeTransferirDaMatriz;
    Var
      fltQtdTransf: Double;
      fltSaldoDisponivel: Double;
      empresaAbastec: TEmpresaAbastecimento;
  begin
    For empresaAbastec In FEmpresasAbastecimento Do
    Begin
      If (empresaAbastec.intAutInc <> item.intAutInc) Then
        Continue;

      If empresaAbastec.strEmpIte = empresaAbastec.strEmpTra Then
        Continue;

      If Not empresaAbastec.blnEmpMat Then
        Continue;

      If empresaAbastec.intDiaEst <= 20 Then
        Continue;

      fltSaldoDisponivel := FControleSaldoDisponivel.fRetornaSaldoDisponivel(
        empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

      If fltSaldoDisponivel >= fltQtdRestante Then
        fltQtdTransf := fltQtdRestante
      Else If blnApenasLoteTotal Then
        fltQtdTransf := 0
      Else
        fltQtdTransf := fltSaldoDisponivel;

      empresaAbastec.fltQtdTra := empresaAbastec.fltQtdTra + fltQtdTransf;

      if blnApenasLoteTotal then
        empresaAbastec.strNumLot := FControleSaldoDisponivel.fRetornaLote(empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

      fltQtdRestante := fltQtdRestante - fltQtdTransf;

      FControleSaldoDisponivel.pDecrementarSaldoDisponivel(empresaAbastec.strCodIte,
        empresaAbastec.strEmpTra, empresaAbastec.strNumLot, fltQtdTransf);
    End;
  end;

  procedure pDefineQuantidadeTransferirOutrasLojas;
    Var
      fltQtdTransf: Double;
      fltSaldoDisponivel: Double;
      strEmpMaiorDiasEstoque: String;
      empresaAbastec: TEmpresaAbastecimento;
  begin
    strEmpMaiorDiasEstoque := fEmpresaComMaiorDiasDeEstoque;

    For empresaAbastec In FEmpresasAbastecimento Do
    Begin
      If (empresaAbastec.intAutInc <> item.intAutInc) Then
        Continue;

      If empresaAbastec.strEmpIte = empresaAbastec.strEmpTra Then
        Continue;

      If empresaAbastec.strEmpTra <> strEmpMaiorDiasEstoque Then
        Continue;

      fltSaldoDisponivel := FControleSaldoDisponivel.fRetornaSaldoDisponivel(
        empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

      If fltSaldoDisponivel >= fltQtdRestante Then
        fltQtdTransf := fltQtdRestante
      Else If blnApenasLoteTotal Then
        fltQtdTransf := 0
      Else
        fltQtdTransf := fltSaldoDisponivel;

      empresaAbastec.fltQtdTra := empresaAbastec.fltQtdTra + fltQtdTransf;

      if blnApenasLoteTotal then
        empresaAbastec.strNumLot := FControleSaldoDisponivel.fRetornaLote(empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

      fltQtdRestante := fltQtdRestante - fltQtdTransf;

      FControleSaldoDisponivel.pDecrementarSaldoDisponivel(empresaAbastec.strCodIte,
        empresaAbastec.strEmpTra, empresaAbastec.strNumLot, fltQtdTransf);
    End;
  end;

begin
  FControleSaldoDisponivel.pIniciarSaldoDisponivel;

  SetProgressInfo('Aguarde, Determinando empresas transferência ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    IncProgressPos(1);

    If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
      Continue;

    If fField('QTDEST').AsFloat <= 0 Then
      Continue;

    FControleSaldoDisponivel.pDecrementarSaldoDisponivel(fField('CODITE').AsString,
      fField('EMPITE').AsString, fField('NUMLOT').AsString, fField('QTDEST').AsFloat);
  End;

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    blnApenasLoteTotal := FblnConsiderarLoteSaldoTotal and (not fEmptyStr(item.strNumLot));

    If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
      Continue;

    fltQtdRestante := fField('QTDTRA').AsFloat -
      fQuantidadeJaEmTransferencia(fField('SEQFDO').AsString);

    If fltQtdRestante <= 0 Then
      Continue;

    pDefineQuantidadeTransferirDaMatriz;

    While fFormataFloat(fltQtdRestante, 4) <> 0 Do
      pDefineQuantidadeTransferirOutrasLojas;
  End;

end;

procedure TAbastecimentoItensPedido.pDeterminaEmpresasTransferenciaSequencial;
Var
  fltQtdRestante: Double;
  item: TDadosFechamento;
  blnApenasLoteTotal: Boolean;

  function RetornaMelhorPossibilidade: TAbastecimentoSequencialResumo;
  var
    SequencialResumo: TAbastecimentoSequencialResumo;
    intTransfMenor: Integer;
    intCompleMenor: Integer;
  begin
    Result := Nil;
    intTransfMenor := 99999;
    intCompleMenor := 99999;
    for SequencialResumo in FSequencialResumo do
    begin
      if (SequencialResumo.intTransf < intTransfMenor) or
        ((SequencialResumo.intTransf = intTransfMenor) and (SequencialResumo.intComple < intCompleMenor)) then
      begin
        intTransfMenor := SequencialResumo.intTransf;
        intCompleMenor := SequencialResumo.intComple;
        Result := SequencialResumo;
      end;
    end;
  end;

  procedure GeraCombinacoes(AListaEmpresas, AResult: TStrings);
  var
    I, J: Integer;
    X: string;
    TS, TS2, S1: TStrings;
    NumDig: Integer;
  begin
    TS := TStringList.Create;
    TS2 := TStringList.Create;
    S1 := TStringList.Create;
    try
      AResult.Text := AListaEmpresas.Text;

      NumDig := Length(AResult.Strings[0]) * AResult.count;

      while Length(AResult.Strings[0]) < NumDig do
      begin
        for I := 0 to (AResult.count - 1) do
          TS2.Add(AResult.Strings[I]);

        for I := 0 to (AResult.count - 1) do
        begin
          S1.Clear;
          for J := 0 to Pred(AListaEmpresas.count) do
          begin
            X := AListaEmpresas[J];
            if Pos(X, AResult.Strings[I]) = 0 then
              S1.Add(X);
          end;

          for J := 0 to Pred(S1.count) do
          begin
            X := S1[J];
            TS.Add(AResult.Strings[I] + '|' + X);
          end;
        end;
        AResult.Text := TS.Text;
        TS.Clear;
      end;

      for I := 0 to (AResult.count - 1) do
        TS2.Add(AResult.Strings[I]);

      AResult.Text := TS2.Text;

    finally
      TS2.Free;
      TS.Free;
      S1.Free;
    end;
  end;

  function fDefineQuantidadeTransferir: TAbastecimentoSequencialResumo;
  Var
    fltQtdTransf: Double;
    fltSaldoDisponivel: Double;
    empresaAbastec: TEmpresaAbastecimento;
    SequencialResumo: TAbastecimentoSequencialResumo;
    SequencialTransf: TAbastecimentoSequencialTransf;
    fltQtdRestanteInicial: Double;
    lstEmpresas: TStringList;
    lstCombinacoes: TStringList;
    Combinacao: String;
    Empresas: TArray<String>;
    Empresa: String;
  begin
    lstEmpresas := TStringList.Create;
    lstCombinacoes := TStringList.Create;
    Try
      fltQtdRestanteInicial := fltQtdRestante;
      FSequencialResumo.Clear;
      FSequencialResumo.TrimExcess;

      For empresaAbastec In FEmpresasAbastecimento Do
      Begin
        If (empresaAbastec.intAutInc <> item.intAutInc) Then
          Continue;

        If empresaAbastec.strEmpIte = empresaAbastec.strEmpTra Then
          Continue;

        if empresaAbastec.varSeqTra = null then
          Continue;

        lstEmpresas.Add(empresaAbastec.strEmpTra);
      End;

      GeraCombinacoes(lstEmpresas, lstCombinacoes);
      for Combinacao in lstCombinacoes do
      begin
        SequencialResumo := TAbastecimentoSequencialResumo.Create;
        fltQtdRestante := fltQtdRestanteInicial;

        Empresas := Combinacao.Split(['|']);
        for Empresa in Empresas do
        begin
          empresaAbastec := fEmpresaAbastecimento(Empresa, item.strCodIte, item.intAutInc);
          if not Assigned(empresaAbastec) then
            Continue;

          fltSaldoDisponivel := FControleSaldoDisponivel.fRetornaSaldoDisponivel(
            empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

          if (fCfgSis('CESTMI', varBoolean)) then
            fltSaldoDisponivel := fltSaldoDisponivel - empresaAbastec.fltEstMin;

          If (fltSaldoDisponivel >= fltQtdRestante) Then
          Begin
            fltQtdTransf := fltQtdRestante;
            fltQtdRestante := 0;
          End
          Else If blnApenasLoteTotal Then
            fltQtdTransf := 0
          Else
          Begin
            fltQtdTransf := fltSaldoDisponivel;
            fltQtdRestante := fltQtdRestante - fltSaldoDisponivel;
          End;

          if fltQtdTransf > 0 then
          begin
            SequencialTransf := TAbastecimentoSequencialTransf.Create;
            SequencialTransf.intAutInc := empresaAbastec.intAutInc;
            SequencialTransf.intSeqEmp := empresaAbastec.varSeqTra;
            SequencialTransf.strCodEmp := empresaAbastec.strEmpTra;
            SequencialTransf.fltSalTra := fltQtdTransf;
            SequencialTransf.strCodIte := empresaAbastec.strCodIte;

            if blnApenasLoteTotal then
              SequencialTransf.strNumLot := FControleSaldoDisponivel.fRetornaLote(empresaAbastec.strCodIte, empresaAbastec.strEmpTra, empresaAbastec.strNumLot);

            SequencialResumo.lstTransf.Add(SequencialTransf);

            SequencialResumo.fltSalTra := SequencialResumo.fltSalTra + SequencialTransf.fltSalTra;
            SequencialResumo.intTransf := SequencialResumo.intTransf + 1;
            SequencialResumo.intComple := SequencialResumo.intComple + empresaAbastec.varSeqTra;
          end;

          if fltQtdRestante = 0 then
            Break;
        end;

        if SequencialResumo.fltSalTra = fltQtdRestanteInicial then
          FSequencialResumo.Add(SequencialResumo);
      End;

      Result := RetornaMelhorPossibilidade;
    Finally
      lstEmpresas.Free;
      lstCombinacoes.Free;
    End;
  end;

var
  SequencialResumo: TAbastecimentoSequencialResumo;
  SequencialTransf: TAbastecimentoSequencialTransf;
  empresaAbastec: TEmpresaAbastecimento;
begin
  FControleSaldoDisponivel.pIniciarSaldoDisponivel;

  SetProgressInfo('Aguarde, Determinando empresas transferência ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    IncProgressPos(1);

    If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
      Continue;

    If fField('QTDEST').AsFloat <= 0 Then
      Continue;

    FControleSaldoDisponivel.pDecrementarSaldoDisponivel(fField('CODITE').AsString,
      fField('EMPITE').AsString, fField('NUMLOT').AsString, fField('QTDEST').AsFloat);
  End;

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    blnApenasLoteTotal := FblnConsiderarLoteSaldoTotal and (not fEmptyStr(item.strNumLot));

    If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
      Continue;

    fltQtdRestante := fField('QTDTRA').AsFloat -
      fQuantidadeJaEmTransferencia(fField('SEQFDO').AsString);

    If fltQtdRestante <= 0 Then
      Continue;

    SequencialResumo := fDefineQuantidadeTransferir;
    if SequencialResumo <> Nil then
    begin
      for SequencialTransf in SequencialResumo.lstTransf do
      begin
        empresaAbastec := fEmpresaAbastecimento(SequencialTransf.strCodEmp, SequencialTransf.strCodIte, SequencialTransf.intAutInc);
        if not Assigned(empresaAbastec) then
          Continue;

        empresaAbastec.fltQtdTra := SequencialTransf.fltSalTra;

        if blnApenasLoteTotal then
          empresaAbastec.strNumLot := SequencialTransf.strNumLot;
      end;
    end;
  End;
end;

procedure TAbastecimentoItensPedido.pEmpresasAbastecimento(blnAlterou: Boolean = False);
  Var
    strLote: String;
    strCodEmp: String;
    item: TDadosFechamento;
    empresaAbastec: TEmpresaAbastecimento;
    intSeqAlterado: integer;
begin
  intSeqAlterado := 0;
  If Not Assigned(FEmpresasAbastecimento) Then
    FEmpresasAbastecimento := TList<TEmpresaAbastecimento>.Create;

  FEmpresasAbastecimento.Clear;
  FEmpresasAbastecimento.TrimExcess;

  SetProgressInfo('Aguarde, Carregando empresas abastecimento ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens) * FStlCodEmp.Count);

  For item In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    For strCodEmp In FStlCodEmp Do
    Begin
      IncProgressPos(1);

      If (strCodEmp <> item.strEmpIte) Then
        If Not (fPermiteTransfEntreEmps(strCodEmp, item.strEmpIte)) Then
          Continue;

      strLote := item.strNumLot;

      If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp,
                                           item.strCodIte) Then
      Begin
        strLote := '';
      End;

      empresaAbastec := TEmpresaAbastecimento.Create;
      empresaAbastec.intAutInc := item.intAutInc;
      empresaAbastec.strSeqFdo := item.strSeqDet;
      empresaAbastec.strCodIte := item.strCodIte;
      empresaAbastec.strNumLot := strLote;
      empresaAbastec.strEmpIte := item.strEmpIte;
      empresaAbastec.strEmpTra := strCodEmp;

      empresaAbastec.fltEstMin := 0;

      If fLimitarEstoqueATransferirPeloEstoqueMinimoDaEmpresa Then
        empresaAbastec.fltEstMin := fRetornaEstoqueMinimo(item.strCodIte, strCodEmp);

      empresaAbastec.intDiaEst := fCalculaDiasEstoque(item, strCodEmp);
      empresaAbastec.blnEmpMat := strCodEmp = fCfgSis('EMPMAT');
      empresaAbastec.fltQtdTra := 0;
      empresaAbastec.varSeqTra := fGetSeqTra(item.strEmpIte, strCodEmp);

      if (blnAlterou) and (empresaAbastec.varSeqTra > 0) then
      begin
        Inc(intSeqAlterado);
        empresaAbastec.varSeqTra := intSeqAlterado;
      end;

      FEmpresasAbastecimento.Add(empresaAbastec);
    End;
  End;

end;

procedure TAbastecimentoItensPedido.pGerarPreparaRequisicoes(Item: TDadosFechamento;
  strIncFdoNov, strNumDoc, strEspDoc, strEmpDoc: String; opcTipAbs: TOpcaoAbastecimentoItem);
  Var
    fltQuantidadeReqCompra: Double;
    abastecimento: TAbastecimentoPedido;

  procedure pAtualizaQuantidadePreparaRQ(fltQtdReq: Double);
    Var
      qryGen: TUniQuery;
  begin
    If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
    Begin
      qryGen := fCriaQuery;
      Try
       qryGen.SQL.Text :=
         ' UPDATE ' +
         '   PREPRQ ' +
         ' SET ' +
         '   PRQ_QTDITE = :QTDITE '+
         ' WHERE AUTOINCREM = "' + abastecimento.strSequencialPrepRQ + '"';
        qryGen.ParamByName('QTDITE').Value := fltQtdReq;
        qryGen.ExecSQL;
      Finally
        FreeAndNil(qryGen);
      End
    End;
  end;

  procedure pAtualizaQuantidadeRequisicaoCompra(fltQtdReq: Double);
    Var
      qryGen: TUniQuery;
  begin
    If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
    Begin
      qryGen := fCriaQuery;
      Try
       qryGen.SQL.Text :=
         'UPDATE ' +
         '  PREPRQ ' +
         '  INNER JOIN MOVRCD ON MOVRCD.AUTOINCREM = PREPRQ.PRQ_SEQRCD ' +
         'SET ' +
         '  RCD_QTDITE = :QTDITE '+
         'WHERE ' +
         '  PREPRQ.AUTOINCREM = "' + abastecimento.strSequencialPrepRQ + '" AND '+
         '  MOVRCD.RCD_SEQCOT IS NULL AND '+
         '  MOVRCD.RCD_SEQPCD IS NULL ';
        qryGen.ParamByName('QTDITE').Value := fltQtdReq;
        qryGen.ExecSQL;
      Finally
        FreeAndNil(qryGen);
      End;
    End;
  end;

begin
  If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
    Exit;

  fltQuantidadeReqCompra := ((fField('QTDREQ').AsFloat + fField('REQSOL').AsFloat)) -
    fQuantidadeJaEmReqCompra(fField('SEQFDO').AsString);

  If (Not FblnReqAut) Then
  Begin
    If (opcTipAbs In [oaReqCompra, oaTodos]) And
       (Not fEmptyStr(fField('SEQFDO').AsString)) And
       (fField('QTDREQ').AsFloat <> fQuantidadeJaEmReqCompra(fField('SEQFDO').AsString)) Then
    Begin
      For abastecimento In FAbastecimentosPedido Do
      Begin
        If abastecimento.strSequencialFatdor = fField('SEQFDO').AsString Then
        Begin
          If Not fEmptyStr(abastecimento.strSequencialPrepRQ) Then
          Begin
            pAtualizaQuantidadePreparaRQ(fField('QTDREQ').AsFloat);
            pAtualizaQuantidadeRequisicaoCompra(fField('QTDREQ').AsFloat);
          End;
        End;
      End;
    End;
  End;

  If fltQuantidadeReqCompra <= 0 Then
    Exit;

  If Not (opcTipAbs In [oaReqCompra, oaTodos]) Then
    Exit;

  if FblnReqAut then
    pPreparaRequisicaoCdsVinculos(strIncFdoNov, item.strEmpIte, strNumDoc, strEspDoc, strEmpDoc, item.strSeqDet)
  else
    pPreparaRequisicaoCompra(strIncFdoNov, item.strEmpIte, item.strCodIte, strNumDoc, strEspDoc, strEmpDoc, fltQuantidadeReqCompra);

end;

function TAbastecimentoItensPedido.fGerarPreparaTransferencias(Item: TDadosFechamento;
                                                               strIncFdoNov,
                                                               strNumDoc,
                                                               strEspDoc,
                                                               strEmpDoc: String;
                                                               opcTipAbs: TOpcaoAbastecimentoItem):Boolean;
  Var
    strSeqPTe: String;
    qryFdoAbs: TUniQuery;
    empresaAbastec: TEmpresaAbastecimento;
begin
  Result := True;

  If Not FCdsItens.Locate('AUTINC', item.intAutInc, []) Then
    Exit;

  If Not (opcTipAbs In [oaSolicitTransf, oaTodos]) Then
    Exit;

  qryFdoAbs := fCriaQuery;
  qryFdoAbs.SQL.Add('SELECT * FROM FDOABS WHERE FALSE');
  qryFdoAbs.Open;

  Try

    For empresaAbastec In FEmpresasAbastecimento Do
    Begin
      If (empresaAbastec.intAutInc <> item.intAutInc) Then
        Continue;

      If empresaAbastec.strEmpIte = empresaAbastec.strEmpTra Then
        Continue;

      If empresaAbastec.fltQtdTra <= 0 Then
        Continue;

      If TPreparaGeracaoTE.fGravarPreparaGeracaoTE_MultiLoja(strNumDoc,
                                                             strEspDoc,
                                                             strEmpDoc,
                                                             empresaAbastec.strCodIte,
                                                             empresaAbastec.strEmpTra,
                                                             empresaAbastec.strEmpIte,
                                                             empresaAbastec.strNumLot,
                                                             empresaAbastec.fltQtdTra,
                                                             strSeqPTe,
                                                             (not FblnEhEmissaoPDAVista),
                                                             Item.strEmpIte) Then
      Begin
        qryFdoAbs.Append;
        qryFdoAbs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FDOABS', Vs_strCodEmp);
        qryFdoAbs.FieldByName('ABS_SEQFDO').AsString := strIncFdoNov;
        qryFdoAbs.FieldByName('ABS_SEQPTE').AsString := strSeqPTe;
        qryFdoAbs.Post;
      End
      Else
      Begin
        Result := False;
        Break;
      End;
    End;

  Finally
    FreeAndNil(qryFdoAbs);
  End;

end;

procedure TAbastecimentoItensPedido.pCriarCdsItens;
  Var
    FieldInf: TFieldDefInf;
begin
  FCdsItens := TUniClientDataSet.Create(nil);
  FCdsItensTmp := TUniClientDataSet.Create(nil);

  For FieldInf In FCampos Do
    FCdsItens.FieldDefs.Add(FieldInf.Name, FieldInf.DataType, FieldInf.Size);

  FCdsItens.CreateDataSet;

  For FieldInf In FCampos Do
    FCdsItens.FindField(FieldInf.Name).Visible := FieldInf.Visible;

  For FieldInf In FCampos Do
    FCdsItens.FindField(FieldInf.Name).DisplayLabel := FieldInf.DisplayLabel;

  For FieldInf In FCampos Do
    If FieldInf.DataType = ftFloat Then
      TFloatField(FCdsItens.FindField(FieldInf.Name)).DisplayFormat := FieldInf.DisplayFormat;
end;

procedure TAbastecimentoItensPedido.pInformacaoPedidoCompra;
  Var
    qryPedCom: TUniQuery;
begin
  qryPedCom := fCriaQuery;

  qryPedCom.SQL.Add('SELECT SQL_NO_CACHE ');
  qryPedCom.SQL.Add('  MIN(PCD_DTAENT) AS DTAENT, ');
  qryPedCom.SQL.Add('  SUM(ROUND(PCD_QTDITE - PCD_QTDBAI, 2) * PCD_EMBALA) AS QTDITE ');
  qryPedCom.SQL.Add('FROM ');
  qryPedCom.SQL.Add('  PCMDET D ');
  qryPedCom.SQL.Add('  INNER JOIN PCMGER ');
  qryPedCom.SQL.Add('    ON PCG_NUMPED = PCD_NUMPED ');
  qryPedCom.SQL.Add('    AND PCG_ESPDOC = PCD_ESPDOC ');
  qryPedCom.SQL.Add('    AND PCG_CODEMP = PCD_CODEMP ');
  qryPedCom.SQL.Add('WHERE PCD_BAIXAD = 0 ');
  qryPedCom.SQL.Add('  AND PCD_ESPDOC = "PD" ');
  qryPedCom.SQL.Add('  AND PCD_NUMCTN = 0 ');
  qryPedCom.SQL.Add('  AND PCG_NUMCTN = 0 ');
  qryPedCom.SQL.Add('  AND PCD_CODITE = :CODITE ');

  If fCfgSis ('LIBPCM', varBoolean) Then
    qryPedCom.SQL.Add(' AND (PCG_PEDLIB IS NOT NULL) ');

  SetProgressInfo('Aguarde, Informações pedido de compra ...');
  SetProgressMax(FCdsItens.RecordCount);

  FCdsItens.First;

  While Not FCdsItens.Eof Do
  Begin
    IncProgressPos(1);

    qryPedCom.Close;
    qryPedCom.ParamByName('CODITE').AsString := fField('CODITE').AsString;
    qryPedCom.Open;

    FCdsItens.Edit;
    fField('QTDCOM').AsFloat := qryPedCom.FieldByName('QTDITE').AsFloat;

    If qryPedCom.FieldByName('DTAENT').AsDateTime = 0 Then
      fField('DTAENT').Value := Null
    Else
      fField('DTAENT').AsDateTime := qryPedCom.FieldByName('DTAENT').AsDateTime;

    FCdsItens.Post;
    FCdsItens.Next;
  End;

  FCdsItens.First;

  qryPedCom.Free;
end;

procedure TAbastecimentoItensPedido.pListarEmpresas;
var
  LQuery : TUniquery;
begin
  FStlEmpresas := TStringList.Create;
  FStlCodEmp := TStringList.Create;

  LQuery := fCriaQuery;
  Try
    LQuery.Sql.Text := 'SELECT CONCAT(EMP_CODEMP, ''-'', EMP_NOMFAN) EMPRESA FROM CADEMP ';
    Lquery.Open;
    while not LQuery.Eof do
    begin
      FStlEmpresas.Add(Lquery.FieldByName('EMPRESA').AsString);
      LQuery.Next;
    end;

    LQuery.Close;
    LQuery.Sql.Clear;

    if FUtilizarSequencial then
    begin
      LQuery.Sql.Add('SELECT EMP_CODEMP');
      LQuery.Sql.Add('FROM CADEMP');
      LQuery.Sql.Add('LEFT JOIN CONEMP ON CON_EMPDES = EMP_CODEMP and CON_EMPORI = :EMPORI');
      LQuery.Sql.Add('ORDER BY CON_SEQTRA');

      Lquery.ParamByName('EMPORI').AsString := Vs_strCodEmp;
      Lquery.Open;
      while not LQuery.Eof do
      begin
        FStlCodEmp.Add(Lquery.FieldByName('EMP_CODEMP').AsString);
        LQuery.Next;
      end;

      LQuery.Close;
    end
    else
      FStlCodEmp.Text := AnsiReplaceStr(
        fCampoTabela('GROUP_CONCAT(EMP_CODEMP SEPARATOR "' +
          STRING_QUEBRA + '")', 'CADEMP', [], []), STRING_QUEBRA, STRING_ENTER);

  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TAbastecimentoItensPedido.pPreencheObjetoLogAbt(Var objLogAbt: TLogAbt);
begin
  objLogAbt.strCodIte        := fField('CODITE').AsString;
  objLogAbt.strAutInc        := fField('AUTINC').AsString;

  objLogAbt.fltQtdIte        := fField('QTDITE').AsFloat;

  objLogAbt.blnSelecaoAnt    := objLogAbt.blnSelecaoAtu;
  objLogAbt.blnSelecaoAtu    := fField('ITESEL').AsBoolean;

  objLogAbt.fltEstoqueAnt    := objLogAbt.fltEstoqueAtu;
  objLogAbt.fltEstoqueAtu    := fField('QTDEST').AsFloat;

  objLogAbt.fltComprarAnt    := objLogAbt.fltComprarAtu;
  objLogAbt.fltComprarAtu    := fField('QTDREQ').AsFloat;

  objLogAbt.fltRequisAnt     := objLogAbt.fltRequisAtu;
  objLogAbt.fltRequisAtu     := fField('REQSOL').AsFloat;

  objLogAbt.fltTransfAnt     := objLogAbt.fltTransfAtu;
  objLogAbt.fltTransfAtu     := fField('QTDTRA').AsFloat;

  objLogAbt.fltQtdCompraAnt  := objLogAbt.fltQtdCompraAtu;
  objLogAbt.fltQtdCompraAtu  := fField('QTDCOM').AsFloat;

  objLogAbt.fltQtdLojaAnt    := objLogAbt.fltQtdLojaAtu;
  objLogAbt.fltQtdLojaAtu    := fField('QTDLOJ').AsFloat;

  objLogAbt.fltQtdFiliaisAnt := objLogAbt.fltQtdFiliaisAtu;
  objLogAbt.fltQtdFiliaisAtu := fField('QTDFIL').AsFloat;
end;

procedure TAbastecimentoItensPedido.pPreparaLogAbt;
Var
  objLogAbt: TLogAbt;
begin
  FCdsItens.First;

  While (Not FCdsItens.Eof) Do
  Begin
    objLogAbt := TFatVenda(FObjVenda).lstLogAbt.fRetornaPeloAutInc(FCdsItens.FieldByName('AUTINC').AsString);
    If (Not Assigned(objLogAbt)) Then
    Begin
      objLogAbt := TLogAbt.Create;
      TFatVenda(FObjVenda).lstLogAbt.Add(objLogAbt);
    End;

    pPreencheObjetoLogAbt(objLogAbt);

    FCdsItens.Next();
  End;

  FCdsItens.First;
end;

procedure TAbastecimentoItensPedido.pPreparaRequisicaoCdsVinculos(AstrIncFdoNov, AstrEmpIte, AstrNumDoc, AstrEspDoc, AstrEmpDoc: String; AintSeqDetAnt: String);
var
  fltTotReq,
  fltTotReqComPedCompra: Double;
  cdsReq: TUniClientDataSet;
begin
  fltTotReq := TFatVenda(FObjVenda).fGetTotalVinculado(fField('CODITE').AsString, False);
  fltTotReqComPedCompra := TFatVenda(FObjVenda).fGetTotalVinculado(fField('CODITE').AsString, True);

  fltTotReq := fltTotReq - fltTotReqComPedCompra;
  cdsReq := TFatVenda(FObjVenda).cdsVinculos;

  if fltTotReqComPedCompra > 0 then
  begin
    cdsReq.Filtered := False;
    cdsReq.Filter := 'ITE_CODITE=' + QuotedStr(fField('CODITE').AsString) + ' AND AUTINC <> '''' ';
    cdsReq.Filtered := True;

    cdsReq.First;

    while not cdsReq.Eof do
    begin
      pPreparaRequisicaoCompra(AstrIncFdoNov, AstrEmpIte, fField('CODITE').AsString,
        AstrNumDoc, AstrEspDoc, AstrEmpDoc, cdsReq.FieldByName('QTDITE').AsFloat, cdsReq.FieldByName('AUTINC').AsString);

      cdsReq.Next;
    end;
  end;

  if fltTotReq > 0 then
    pPreparaRequisicaoCompra(AstrIncFdoNov, AstrEmpIte, fField('CODITE').AsString,
      AstrNumDoc, AstrEspDoc, AstrEmpDoc, fltTotReq);

  pAtualizaSeqFDORequisicoesVinculadas('', AstrIncFdoNov, fField('CODITE').AsString);
end;

procedure TAbastecimentoItensPedido.pPreparaRequisicaoCompra(AstrIncFdoNov, AstrEmpIte, AstrCodIte, AstrNumDoc,
  AstrEspDoc, AstrEmpDoc: String; AfltQtdReqCompra: Double; AstrSeqPedCompra: String = '');
var
  qryFdoAbs: TUniQuery;
  objRequisicoes: TPreparaRequisicaoCompra;
begin
  qryFdoAbs := fCriaQuery;
  qryFdoAbs.SQL.Add('SELECT * FROM FDOABS WHERE FALSE');
  qryFdoAbs.Open;

  objRequisicoes := TPreparaRequisicaoCompra.Create();

  Try
    objRequisicoes.pAdicionarItemRequisicao(
            TItemRequisicaoCompra.Create('',
                                         AstrEmpIte,
                                         strLoginUsuarioLogado,
                                         AstrCodIte,
                                         '',
                                         AstrNumDoc,
                                         AstrEspDoc,
                                         AstrEmpDoc,
                                         '',
                                         AfltQtdReqCompra,
                                         VS_Date,
                                         fTime(),
                                         AstrSeqPedCompra));

    If objRequisicoes.fGravarRequisicao() Then
    Begin
      qryFdoAbs.Append;
      qryFdoAbs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FDOABS', Vs_strCodEmp);
      qryFdoAbs.FieldByName('ABS_SEQFDO').AsString := AstrIncFdoNov;
      qryFdoAbs.FieldByName('ABS_SEQPRQ').AsString := objRequisicoes.ItensRequisicao[0].fGetAutInc;
      qryFdoAbs.Post;
    End;
  Finally
    FreeAndNil(objRequisicoes);
    FreeAndNil(qryFdoAbs);
  End;
end;

procedure TAbastecimentoItensPedido.pSelecionarTodos(blnMarcado: Boolean);
begin
  FCdsItens.First;

  While Not FCdsItens.Eof Do
  Begin
    FCdsItens.Edit;
    fField('ITESEL').AsBoolean := blnMarcado;
    FCdsItens.Post;
    FCdsItens.Next;
  End;

  FCdsItens.First;
end;

procedure TAbastecimentoItensPedido.pSepararItensPorTipoAbastecimento;
  Var
    fltEstoque: Double;
    fltComprar: Double;
    fltTransf : Double;
    blnFatPar : Boolean;
    fltFator  : Double;
    intIndex  : Integer;
    itemPedido: TDadosFechamento;
    itensNovos: TMatrizFechamento;

  procedure pAtualizaTotaisItemNovo();
  begin
    With itensNovos[Length(itensNovos) - 1] Do
    Begin
      fltTotIte := fFormataFloat(fltTotIte * fltFator, 2);
      fltTotCus := fFormataFloat(fltTotCus * fltFator, 2);
      fltTotCu2 := fFormataFloat(fltTotCu2 * fltFator, 2);
      fltTotMed := fFormataFloat(fltTotMed * fltFator, 2);
      fltTotUlt := fFormataFloat(fltTotUlt * fltFator, 2);
      fltTotImp := fFormataFloat(fltTotImp * fltFator, 2);
      fltDesOrg := fFormataFloat(fltDesOrg * fltFator, 2);
    End;
    FblnTeveAlgumTipoAbastecimento := True;
  end;

begin
  if FblnEhEmissaoPDAVista then
    Exit;

  SetLength(itensNovos, 0);

  SetProgressInfo('Aguarde, Separando itens por tipo de abastecimento ...');
  SetProgressMax(Length(TFatVenda(FObjVenda).arrMatItens));

  For itemPedido In TFatVenda(FObjVenda).arrMatItens Do
  Begin
    IncProgressPos(1);

    blnFatPar := False;
    fltEstoque := 0;
    fltComprar := 0;
    fltTransf  := 0;

    If FCdsItens.Locate('AUTINC', itemPedido.intAutInc, []) Then
    Begin
      blnFatPar  := fField('FATPAR').AsBoolean;
      fltEstoque := fField('QTDEST').AsFloat;
      fltComprar := fField('QTDREQ').AsFloat + fField('REQSOL').AsFloat;
      fltTransf  := fField('QTDTRA').AsFloat;
    End;

    If Not blnFatPar Then
    Begin
      SetLength(itensNovos, Length(itensNovos) + 1);
      itensNovos[Length(itensNovos) - 1] := itemPedido;
      itensNovos[Length(itensNovos) - 1].opcTipAbs := oaTodos;
      Continue;
    End;

    If fltEstoque > 0 Then
    Begin
      fltFator := fltEstoque / itemPedido.fltQtdIte;
      SetLength(itensNovos, Length(itensNovos) + 1);
      itensNovos[Length(itensNovos) - 1] := itemPedido;
      itensNovos[Length(itensNovos) - 1].fltQtdIte := fltEstoque;
      itensNovos[Length(itensNovos) - 1].opcTipAbs := oaEstoque;
      pAtualizaTotaisItemNovo();
    End;

    If fltComprar > 0 Then
    Begin
      fltFator := fltComprar / itemPedido.fltQtdIte;
      SetLength(itensNovos, Length(itensNovos) + 1);
      itensNovos[Length(itensNovos) - 1] := itemPedido;
      itensNovos[Length(itensNovos) - 1].fltQtdIte := fltComprar;
      itensNovos[Length(itensNovos) - 1].opcTipAbs := oaReqCompra;
      pAtualizaTotaisItemNovo();
    End;

    If fltTransf > 0 Then
    Begin
      fltFator := fltTransf / itemPedido.fltQtdIte;
      SetLength(itensNovos, Length(itensNovos) + 1);
      itensNovos[Length(itensNovos) - 1] := itemPedido;
      itensNovos[Length(itensNovos) - 1].fltQtdIte := fltTransf;
      itensNovos[Length(itensNovos) - 1].opcTipAbs := oaSolicitTransf;
      pAtualizaTotaisItemNovo();
    End;
  End;

  SetLength(TFatVenda(FObjVenda).arrMatItens, Length(itensNovos));

  For intIndex := Low(itensNovos) to High(itensNovos) Do
    TFatVenda(FObjVenda).arrMatItens[intIndex] := itensNovos[intIndex];
end;

procedure TAbastecimentoItensPedido.pValidarTodosItens;
begin
  FblnValidarTodos := True;
  SetProgressInfo('Aguarde, Validando todos itens ...');
  SetProgressMax(FCdsItens.RecordCount);

  try
    FCdsItens.First;

    While Not FCdsItens.Eof Do
    Begin
      IncProgressPos(1);
      FCdsItens.Edit;
      FCdsItens.Post;
      FCdsItens.Next;
    End;

    FCdsItens.First;
  finally
    FblnValidarTodos := False;
  end;
end;

procedure TAbastecimentoItensPedido.SetProgressInfo(AValue: String);
begin
  If Assigned(FProgresso) And (GetParentForm(FProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(FProgresso).FindComponent('lblGravando')).Caption := AValue;
    Application.ProcessMessages;
  End;
end;

procedure TAbastecimentoItensPedido.SetProgressMax(AValue: Integer);
begin
  If Assigned(FProgresso) Then
  Begin
    FProgresso.Properties.Max := AValue;
    FProgresso.Position := 0;
  End;
end;

{ TControleSaldoDisponivel }

constructor TControleSaldoDisponivel.Create;
begin
  FObjVenda := objVenda;
  dicSaldoDisponivel := TDictionary<String, TSaldoDisponivel>.Create;
end;

destructor TControleSaldoDisponivel.Destroy;
begin
  dicSaldoDisponivel.Free;
  inherited;
end;

function TControleSaldoDisponivel.fRetornaLote(strCodIte, strCodEmp,
  strNumLot: String): String;
var
  strKey: String;
  recSaldo: TSaldoDisponivel;
begin
  Result := strNumLot;

  if TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  if dicSaldoDisponivel.TryGetValue(strKey, recSaldo) then
    Result := recSaldo.strNumLot;
end;

function TControleSaldoDisponivel.fRetornaSaldoDisponivel(strCodIte, strCodEmp, strNumLot: String): Double;
  Var
    strKey: String;
    recSaldo: TSaldoDisponivel;
begin
  Result := 0;
  If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) Then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  if dicSaldoDisponivel.TryGetValue(strKey, recSaldo) then
    Result := recSaldo.fltSaldoDisponivelFinal;
end;

procedure TControleSaldoDisponivel.pAddItem(strCodIte, strCodEmp, strNumLot, strSeqFdo: String);
  Var
    strKey: String;
    fltSaldo: Double;
    recSaldo: TSaldoDisponivel;
    LNumeroPedido: String;
    LEmpresasRelacionadasItemPedido: TArray<String>;
    blnIgnorarLote: Boolean;
begin
  If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) Then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  If dicSaldoDisponivel.ContainsKey(strKey) Then
    Exit;

  LNumeroPedido := IIF(TFatVenda(FObjVenda).strEspOrc = 'PD', TFatVenda(FObjVenda).strNumOrc, '');

  If Not LNumeroPedido.IsEmpty Then
  Begin
    If strSeqFdo.IsEmpty Then
    Begin
      If (TFatVenda(FObjVenda).ListaItensRemovidosComSeqFdo.IndexOf(strKey) >= 0) Then
        strSeqFdo := fRetornaSeqFdoItemDocumento(LNumeroPedido, 'PD', strCodEmp, strCodIte, strNumLot);
    End;

    LEmpresasRelacionadasItemPedido := fGetEmpresasReprocessarItemPedido(strSeqFdo);
    If Not MatchStr(strCodEmp, LEmpresasRelacionadasItemPedido) Then
      LNumeroPedido := '';//evita select desnecessario e faz usar os campos do iteger com saldo calculado
  End;

  blnIgnorarLote := (fUtilizaDefinicaoLoteSeparacaoSemWMS(strCodIte,
                                                          strCodEmp,
                                                          TFatVenda(FObjVenda).strOpcDoc) And
                    (strNumLot = 'A DEFINIR'));

  fltSaldo := untFuncoesSimples.
    fRetornaSaldoDisponivel(strCodIte,
                            False,
                            True,
                            strNumLot,
                            True,
                            strCodEmp,
                            LNumeroPedido,
                            False,
                            True,
                            True,
                            blnIgnorarLote);

  recSaldo.fltSaldoDisponivelOriginal := fltSaldo;
  recSaldo.fltSaldoDisponivelFinal    := fltSaldo;
  recSaldo.strNumLot                  := strNumLot;

  dicSaldoDisponivel.Add(strKey, recSaldo);
end;

procedure TControleSaldoDisponivel.pAddItemLote(strCodIte, strEmpIte, strCodEmp,
  strNumLot, strSeqFdo: String; fltQtdIte: Double);
var
  strKey: String;
  fltSaldo: Double;
  fltSaldoLote: Double;
  recSaldo: TSaldoDisponivel;
  LNumeroPedido: String;
  LEmpresasRelacionadasItemPedido: TArray<String>;
  strLoteItem: String;
  qryCadLot: TUniQuery;
begin
  strLoteItem := strNumLot;
  fltSaldo := 0;

  If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) Then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  If dicSaldoDisponivel.ContainsKey(strKey) Then
    Exit;

  LNumeroPedido := IIF(TFatVenda(FObjVenda).strEspOrc = 'PD', TFatVenda(FObjVenda).strNumOrc, '');

  If Not LNumeroPedido.IsEmpty Then
  Begin
    LEmpresasRelacionadasItemPedido := fGetEmpresasReprocessarItemPedido(strSeqFdo);
    If Not MatchStr(strCodEmp, LEmpresasRelacionadasItemPedido) Then
      LNumeroPedido := '';//evita select desnecessario e faz usar os campos do iteger com saldo calculado
  End;

  if (strNumLot = 'A DEFINIR') then
  begin
    qryCadLot := fCriaQuery;

    try
      qryCadLot.SQL.Text := TFatVenda(FObjVenda).objCadLot.fRetSQLLoteItemEmp(strCodIte, strCodEmp);
      qryCadLot.Open;

      while not qryCadLot.Eof do
      begin
        fltSaldoLote := untFuncoesSimples.
                        fRetornaSaldoDisponivel(strCodIte,
                                                False,
                                                True,
                                                qryCadLot.FieldByName('LOT_NUMLOT').AsString,
                                                True,
                                                strCodEmp,
                                                LNumeroPedido);

        if (fltSaldoLote >= fltQtdIte) then
        begin
          fltSaldo := fltSaldoLote;
          strLoteItem := qryCadLot.FieldByName('LOT_NUMLOT').AsString;
          Break;
        end;

        qryCadLot.Next;
      end;
    finally
      FreeAndNil(qryCadLot);
    end;
  end
  else
  begin
    fltSaldoLote := untFuncoesSimples.
                    fRetornaSaldoDisponivel(strCodIte,
                                            False,
                                            True,
                                            strLoteItem,
                                            True,
                                            strCodEmp,
                                            LNumeroPedido);

    if (fltSaldoLote >= fltQtdIte) then
      fltSaldo := fltSaldoLote;
  end;

  recSaldo.fltSaldoDisponivelOriginal := fltSaldo;
  recSaldo.fltSaldoDisponivelFinal    := fltSaldo;
  recSaldo.strNumLot                  := strLoteItem;

  dicSaldoDisponivel.Add(strKey, recSaldo);
end;

procedure TControleSaldoDisponivel.pDecrementarSaldoDisponivel(strCodIte, strCodEmp,
  strNumLot: String; fltQtdIte: Double);
  Var
    strKey: String;
    recSaldo: TSaldoDisponivel;
begin
  If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) Then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  if dicSaldoDisponivel.TryGetValue(strKey, recSaldo) then
  Begin
    recSaldo.fltSaldoDisponivelFinal := recSaldo.fltSaldoDisponivelFinal - fltQtdIte;
    dicSaldoDisponivel[strKey] := recSaldo;
  End;
end;

procedure TControleSaldoDisponivel.pIncrementarSaldoDisponivel(strCodIte,
  strCodEmp, strNumLot: String; fltQtdIte: Double);
  Var
    strKey: String;
    recSaldo: TSaldoDisponivel;
begin
  If TFatVenda(FObjVenda).fIgnorarLote(strCodEmp, strCodIte) Then
    strNumLot := '';

  strKey := strCodIte + '-' + strCodEmp + '-' + strNumLot;

  if dicSaldoDisponivel.TryGetValue(strKey, recSaldo) then
  Begin
    recSaldo.fltSaldoDisponivelFinal := recSaldo.fltSaldoDisponivelFinal + fltQtdIte;
    dicSaldoDisponivel[strKey] := recSaldo;
  End;
end;

procedure TControleSaldoDisponivel.pIniciarSaldoDisponivel;
  Var
    strKey: String;
    recSaldo: TSaldoDisponivel;
begin
  For strKey In dicSaldoDisponivel.Keys Do
  Begin
    if dicSaldoDisponivel.TryGetValue(strKey, recSaldo) then
    Begin
      recSaldo.fltSaldoDisponivelFinal := recSaldo.fltSaldoDisponivelOriginal;
      dicSaldoDisponivel[strKey] := recSaldo;
    End;
  End;
end;

{ TAbastecimentoSequencialResumo }

constructor TAbastecimentoSequencialResumo.Create;
begin
  lstTransf := TList<TAbastecimentoSequencialTransf>.Create;
end;

destructor TAbastecimentoSequencialResumo.Destroy;
begin
  lstTransf.Free;
  inherited;
end;

end.
