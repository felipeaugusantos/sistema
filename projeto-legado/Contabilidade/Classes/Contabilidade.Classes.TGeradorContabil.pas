unit Contabilidade.Classes.TGeradorContabil;

interface

uses System.Generics.Collections,
     Contabilidade.Model.TDadosImportacaoContabil,
     Contabilidade.Classes.TRepositorioContabil,
     Contabilidade.Classes.TGeradorContabilCtp,
     Contabilidade.Classes.TDadosAbertura,
     StrUtils,
     SysUtils,
     Data.DB,
     Classes,
     cxProgressBar,
     Contabilidade.Interfaces,
     UniClientDataSet,
     Contabilidade.Model.Contabilizaveis,
     Uni,
     Contabilidade.Classes.TGravacaoEmLote;

type
  TLanConControleDebitoCreditoContas = class
  private
    (* Os campos abaixo trabalham em conjunto para controlar as contas de partida simples que possem
       a mesma conta nos lançamentos de crédito e débito. Não podem ser alterados de forma isolada, devem ser alterados em conjunto *)
    FlstCntDebito: TStringList ;
    FlstValCntDebito: TStringList ;
    FlstCntCredito: TStringList ;
    FlstValCntCredito: TStringList ;
    (* Fim do controle de campos em conjuno *)
    FobjDados: TDadosImportacaoContabil ;
  public
    constructor Create ;
    destructor Destroy ; override ;

    property CntDebito: TStringList read FlstCntDebito ;
    property ValCntDebito: TStringList read FlstValCntDebito ;
    property CntCredito: TStringList read FlstCntCredito ;
    property ValCntCredito: TStringList read FlstValCntCredito ;
    property Dados: TDadosImportacaoContabil read FobjDados write FobjDados ;
  end ;

  TGeradorContabil = class
  private
    cdsPlancoVigencia: TUniClientDataSet;
    FcdsPlancoInfo: TUniClientDataSet;
    FValidarVigenciaCta : boolean;
    FListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
    FListaDadosImportacaoContabilWarning: TObjectList<TDadosImportacaoContabil>;
    FListaDadosImportacaoContabilError: TObjectList<TDadosImportacaoContabil>;
    FRepositorio: TRepositorioContabil;
    FDadosAbertura: TDadosAbertura;
    FValidarContas: boolean;
    FblnLancarEmPreValidar: boolean;
    FlstControleDiferencaDebitoCredito: TStringList ;
    FlstControlePesquisaContaContabil: TStringList ;
    AlstControleVigenciaContaContabil: TStringList ;

    FDicHistoricoPadrao : TDictionary<Integer,String>;

    FdictControleDebitoCreditoContas: TObjectDictionary<string, TLanConControleDebitoCreditoContas>;

    blnUtilizaRotinaLoteContabil : boolean;
    blnParametrizouCreditoNaFormaDePagto : boolean;
    FGravacaoEmLote: TGravacaoEmLote;
    FintTamanhoDoLote : Integer;
    FblnTemCentroCusto : Boolean ;
    function fDocumentoExcluido(const AstrIncDoc: String): Boolean;
    function fErrosSoDeDocumentosExcluidos: Boolean;
    procedure pRegistrarProgresso(progresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);

    procedure pCarregaListaErros(AMotivo: string; AOrigem: string; dados: TDadosImportacaoContabil; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False); overload;
    procedure pCarregaListaErros(AMotivo, AOrigem, AHistorico, ATipLan, ADesVal, ATabela, AChave: string; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False; const AdtaLan: TDateTime = 0; const AstrCodEmpDoc: String = ''); overload;
    //procedure pCarregaListaErros(AMotivo: string; AOrigem: string); overload;
    procedure pValidarContasContabeisDadosImportacao;
    procedure pExcluirDadosExistentes(strTipo: string);//faz a exclusão do periodo+empresa, antes de gravar os dados;
    procedure pGravarDadosImportacao;
    procedure pGravarCheckList(const AstrTipLan: string);
    procedure pGravarCheckListSemMovimentoGerarMovFinalPreValidacao(const AstrTipLan: string) ;
    function fPodeGerarMovFinalPreValidacao:boolean ;
    function fVerificaPlanco(const AstrConta: String): string ;
    procedure pIncrementaContadorLote(const AstrAutoInc: String; var AlstControle: TStringList; var AintContador: integer) ;

    //procedure pGerarRecebimento;
    procedure pGerarPagamento;
    function GetListaErros: TUniClientDataSet;
    function GetListaWarnings: TUniClientDataSet;
    function fgetContabilizavel(const ACodigoContabilizavel, AOrigem, AIncDoc: string): TContabilizaveis;
    procedure pValidarTotalDeDebitosECreditos(const AChave: string);
    procedure pLiberaPlancoVigencia;
    function ValidaSomaCreditoDebitoIgualZero:boolean ;
    function fEmpresaCtpDet(const AdicDados: TDadosImportacaoContabil): string ;
    function fDeletaLacamentosGeradosParaOutraEmpresa(const AstrTipo: string; const AblnTemControle: Boolean): boolean ;
    procedure pValidarEmpresaMatrizFilialCtpDet(const AChave: string);
    procedure pValidarHistorico ;
    function fTemControleDelLanconOutrasEmpresas(const AstrTipo: string): Boolean ;
    procedure pValidaPeriodo;
    procedure pGeraDicionarioControleDebitoCreditoContas(AobjDados: TDadosImportacaoContabil) ;
  public
    objValida : IValidaContaContabil;
    procedure pGerar;

    constructor create(dadosAbertura: TDadosAbertura);
    destructor Destroy; override;

    property blnValidarContas: boolean read FValidarContas write FValidarContas;
    property LancarEmPreValidar: boolean read FblnLancarEmPreValidar write FblnLancarEmPreValidar;
    property listaErros: TUniClientDataSet read GetListaErros;
    property listaWarnings: TUniClientDataSet read GetListaWarnings;
  end;

implementation

uses Variants, Contabilidade.Classes.TValidaContasContabeis,
  untFuncoesSimples, Contabilidade.Funcoes, Contabilidade.Model.ContasPagar,
  System.Types, Contabilidade.Classes.CheckListImportacao,
  Contabilidade.Classes.TTrataIncDoc;

{ TLanConControleDebitoCreditoContas }

constructor TLanConControleDebitoCreditoContas.Create;
begin
  inherited Create ;
  FlstCntDebito     := TStringList.Create ;
  FlstValCntDebito  := TStringList.Create ;
  FlstCntCredito    := TStringList.Create ;
  FlstValCntCredito := TStringList.Create ;
end;

destructor TLanConControleDebitoCreditoContas.Destroy;
begin
  FreeAndNil(FlstCntDebito) ;
  FreeAndNil(FlstValCntDebito) ;
  FreeAndNil(FlstCntCredito) ;
  FreeAndNil(FlstValCntCredito) ;
  inherited Destroy ;
end;

{ TGeradorContabil }

constructor TGeradorContabil.create(dadosAbertura: TDadosAbertura);
var
  LqryCon: TUniQuery ;
begin
  FListaDadosImportacaoContabil := TObjectList<TDadosImportacaoContabil>.Create;
  FListaDadosImportacaoContabilWarning := TObjectList<TDadosImportacaoContabil>.Create;
  FListaDadosImportacaoContabilError := TObjectList<TDadosImportacaoContabil>.Create;
  FRepositorio := TRepositorioContabil.Create(dadosAbertura);
  objValida := TValidaContaContabil.New;
  FDadosAbertura := dadosAbertura;
  FDicHistoricoPadrao := TDictionary<Integer,String>.Create;
  FdictControleDebitoCreditoContas := TObjectDictionary<string, TLanConControleDebitoCreditoContas>.Create([doOwnsValues]);

  blnUtilizaRotinaLoteContabil := fConfiguracaoExiste('LTCONT');
  if (blnUtilizaRotinaLoteContabil) then
    blnUtilizaRotinaLoteContabil := fCfgSis('LTCONT', varBoolean);
  blnParametrizouCreditoNaFormaDePagto := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_FORPGO'], [dadosAbertura.strTipoExportacao, FPG_CREDITO], False) > 0;
  FValidarVigenciaCta := fTemVigencia;
  /////carrega as contas em uma tabela de memoria para verificação
  cdsPlancoVigencia := fCarregaPlancoVigencia ;
  FcdsPlancoInfo := dadosAbertura.cdsPlancoInfo ;
  FlstControleDiferencaDebitoCredito := TStringList.Create ;
  FlstControleDiferencaDebitoCredito.Sorted := True ;
  FblnLancarEmPreValidar := False ;

  LqryCon := fCriaQuery() ;
  try
    FGravacaoEmLote := TGravacaoEmLote.Create(Nil,
                                              LqryCon.Connection.Database,
                                              LqryCon.Connection.Username,
                                              LqryCon.Connection.Password,
                                              IntToStr(LqryCon.Connection.Port),
                                              LqryCon.Connection.Server);
  finally
    FreeAndNil(LqryCon) ;
  end ;
  FintTamanhoDoLote := fCfgSis('LOTCON', varInteger);
  FlstControlePesquisaContaContabil := TStringList.Create ;
  FlstControlePesquisaContaContabil.Sorted := True ;
  AlstControleVigenciaContaContabil := TStringList.Create ;
  AlstControleVigenciaContaContabil.Sorted := True ;
  FblnTemCentroCusto := fConfiguracaoExiste('OBRCCU') and fCfgSis('OBRCCU', varBoolean) ;
end;

destructor TGeradorContabil.Destroy;
begin
  FreeAndNil(FGravacaoEmLote);
  FListaDadosImportacaoContabil.Free;
  FListaDadosImportacaoContabilWarning.Free;
  FreeAndNil(FListaDadosImportacaoContabilError);
  FreeAndNil(FlstControleDiferencaDebitoCredito);
  FRepositorio.Free;
  FreeAndNil(FDicHistoricoPadrao);
  FreeAndNil(FdictControleDebitoCreditoContas);
  pLiberaPlancoVigencia;
  FreeAndNil(FlstControlePesquisaContaContabil) ;
  FreeAndNil(AlstControleVigenciaContaContabil) ;
  inherited;
end;

function TGeradorContabil.fgetContabilizavel(const ACodigoContabilizavel, AOrigem, AIncDoc: string): TContabilizaveis;
begin
  Result := TContabilizaveis.Create;
  Result.IncDoc := AIncDoc;
  if (AOrigem = 'Portador') then
    Result.portador.strCodigo := ACodigoContabilizavel
  else if (AOrigem = 'Plano de Contas') or (AOrigem = 'Plano de Contas (Cadastro)') then
    Result.PlanoContasCadastro.strCodigo := ACodigoContabilizavel
  else if (AOrigem = 'Plano de Contas (Baixa)') then
    Result.PlanoContasBaixa.strCodigo := ACodigoContabilizavel
  else if (AOrigem = 'Cliente/Fornecedor') then
    Result.Fornecedor.strCodigo := ACodigoContabilizavel
  else if (AOrigem = 'Conta Débito') then
    Result.ContaDebito := ACodigoContabilizavel
  else if (AOrigem = 'Conta Crédito') then
    Result.ContaCredito := ACodigoContabilizavel;
end;

function TGeradorContabil.GetListaErros: TUniClientDataSet;
begin
  Result := objValida.DataSet ;
end;

function TGeradorContabil.GetListaWarnings: TUniClientDataSet;
begin
  Result := objValida.DataSetWarnings;
end;

procedure TGeradorContabil.pCarregaListaErros(AMotivo: string; AOrigem: string; dados: TDadosImportacaoContabil; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False);
  var
    contaErro : TContaErro;
begin
  FillChar(contaErro, sizeOf(contaErro), #0);
  contaErro.strMotivo := AMotivo;
  contaErro.strHistor := dados.strHistorico;
  contaErro.strTipLan := dados.strTipoLancamento;
  contaErro.strDesVal := dados.strDescricaoValor;
  contaErro.strNatOpe := '';
  contaErro.strOriPla := AOrigem;
  contaErro.strChaveDocumento := dados.strCtpInc;
  contaErro.strTabela := 'CADPAG';
  contaErro.strWarning := iif(AWarning, 'S', 'N') ;
  // Geracao sem empresa informada (todas): a pendencia leva a empresa do titulo.
  contaErro.strCodEmp := FDadosAbertura.empresa.strCodigo;
  if fEmptyStr(contaErro.strCodEmp) and Assigned(dados.empresa) then
    contaErro.strCodEmp := dados.empresa.strCodigo;
  contaErro.strSigla := FDadosAbertura.strTipoExportacao;
  objValida.pAddErro(contaErro, AContabilizaveis, dados.dtaLancamento);
end;

procedure TGeradorContabil.pCarregaListaErros(AMotivo, AOrigem, AHistorico, ATipLan, ADesVal, ATabela, AChave: string; const AContabilizaveis: TContabilizaveis; const AWarning: Boolean = False; const AdtaLan: TDateTime = 0; const AstrCodEmpDoc: String = '');
  var
    recContaErro : TContaErro;
begin
  FillChar(recContaErro, SizeOf(recContaErro), #0);
  recContaErro.strMotivo := AMotivo;
  recContaErro.strOriPla := AOrigem;
  recContaErro.strHistor := AHistorico;
  recContaErro.strTipLan := ATipLan;
  recContaErro.strDesVal := ADesVal;
  recContaErro.strNatOpe := '';
  recContaErro.strChaveDocumento := AChave;
  recContaErro.strTabela := ATabela;
  recContaErro.strWarning := iif(AWarning, 'S', 'N') ;
  recContaErro.strCodEmp := FDadosAbertura.empresa.strCodigo;
  if fEmptyStr(recContaErro.strCodEmp) then
    recContaErro.strCodEmp := AstrCodEmpDoc;
  recContaErro.strSigla := FDadosAbertura.strTipoExportacao;
  objValida.pAddErro(recContaErro, AContabilizaveis, AdtaLan);
end;

{procedure TGeradorContabil.pCarregaListaErros(AMotivo, AOrigem: string);
  var
    dados: TDadosImportacaoContabil;
begin
  dados := TDadosImportacaoContabil.Create;
  try
    pCarregaListaErros(AMotivo, AOrigem, dados, nil);
  finally
    FreeAndNil(dados);
  end;
end;}

function TGeradorContabil.fDeletaLacamentosGeradosParaOutraEmpresa(const AstrTipo: string; const AblnTemControle: Boolean): boolean;
Var
  qryDel : TUniQuery;
  LintControle1, LintControle2: Largeint ;
  LqryExec: TUniQuery;
begin

  if not AblnTemControle then
    Exit(True) ;

  qryDel := fCriaQuery(nil);
  LqryExec := fCriaQuery(nil);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' SELECT LANCNT.CNT_ORIGEM, LANCNT.CNT_CONTRO ');
    qryDel.SQL.Add('   FROM LANCNT INNER JOIN LANCON ON LANCON.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    qryDel.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
    qryDel.ParamByName('TIPLAN').AsString := AstrTipo ;

    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      qryDel.SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      qryDel.ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
      qryDel.ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
    end;

    If Not fEmptyStr(FDadosAbertura.empresa.strCodigo) Then
    begin
      qryDel.SQL.Add('  AND CASE WHEN LANCNT.CNT_ORIGEM <> LANCNT.CNT_CONTRO THEN LANCON.CON_EMPLAN = :CODEMP ELSE LANCNT.CNT_EMPORI = :CODEMP END ');
      qryDel.ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('LANCON.CON_INCDOC')
      .fIncDoc(FDadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(FDadosAbertura.arrIncDoc)
      .fQuerySql(qryDel)
      .fExecute ;

    qryDel.Open ;
    qryDel.First;
    While Not qryDel.Eof Do
    Begin

      LintControle1 := qryDel.FieldByName('CNT_ORIGEM').AsLargeInt ;
      LintControle2 := qryDel.FieldByName('CNT_CONTRO').AsLargeInt ;
      ///apaga o controle
      //qryDel.Delete ;
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCNT WHERE CNT_ORIGEM = :ORIGEM AND CNT_CONTRO = :CONTRO ; ');
      LqryExec.ParamByName('ORIGEM').AsLargeInt := LintControle1 ;
      LqryExec.ParamByName('CONTRO').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;
      //apaga os lançamentos na lancon
      LqryExec.Close;
      LqryExec.SQL.Clear;
      LqryExec.SQL.Add(' DELETE FROM LANCON WHERE AUTOINCREM = :INC2 ; ');
      LqryExec.ParamByName('INC2').AsLargeInt := LintControle2 ;
      LqryExec.ExecSQL ;

      qryDel.Next ;
    end;

    Result := True;
  Finally
    FreeAndNil(qryDel);
    FreeAndNil(LqryExec) ;
  End;

end;

procedure TGeradorContabil.pExcluirDadosExistentes(strTipo: string);
  var
    qryDel: TUniQuery;
    LblnTemControle: Boolean ;
begin
  if (FDadosAbertura.blnModoRobo) and (FDadosAbertura.intModoLancto = MODO_ROBO_2_ESTORNO) then
    Exit;

  // Req. 470760: reprocesso sem lista apagaria o periodo inteiro.
  if FDadosAbertura.blnReprocessaErros and (Length(FDadosAbertura.arrIncDoc) = 0) then
    Exit;

  // No reprocesso so de documentos o check list do periodo fica.
  if (not FDadosAbertura.blnModoRobo) and (not FDadosAbertura.blnReprocessaErros) then
    pGravarCheckList(strTipo) ;

  if not FDadosAbertura.blnModoRobo then
    LblnTemControle := fTemControleDelLanconOutrasEmpresas(strTipo)
  else
    LblnTemControle := True ;

  qryDel := fCriaQuery(nil);
  try
    with qryDel do
    begin
      fDeletaLacamentosGeradosParaOutraEmpresa(strTipo, LblnTemControle) ;

      Close;
      SQL.Clear;
      if LblnTemControle then
      begin
        SQL.Add(' DELETE LANCON ');
        SQL.Add('   FROM LANCON LEFT JOIN LANCNT ON LANCON.AUTOINCREM = LANCNT.CNT_CONTRO ');
        SQL.Add('  WHERE LANCON.CON_TIPLAN = :TIPO ');
        SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
        SQL.add('    AND LANCNT.CNT_CONTRO IS NULL ')
      end
      else
      begin
        SQL.Add(' DELETE ');
        SQL.Add('   FROM LANCON ');
        SQL.Add('  WHERE LANCON.CON_TIPLAN = :TIPO ');
        SQL.Add('    AND LANCON.CON_AUTOMA = 1 ');
      end ;

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('LANCON.CON_INCDOC')
        .fIncDoc(FDadosAbertura.strIncrementoCadPag)
        .fArrIncDoc(FDadosAbertura.arrIncDoc)
        .fQuerySql(qryDel)
        .fExecute ;

      if (FDadosAbertura.dtaDataInicial > 0) then
        SQL.Add('  AND LANCON.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

      if not fEmptyStr(FDadosAbertura.empresa.strCodigo) then
        SQL.Add('  AND LANCON.CON_EMPLAN = :CODEMP ');

      if (FDadosAbertura.dtaDataInicial > 0) then
      begin
        ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
        ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
      end;

      if not fEmptyStr(FDadosAbertura.empresa.strCodigo) then
        ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;

      if (not fEmptyStr(FDadosAbertura.strIncrementoCadPag)) and (Length(FDadosAbertura.arrIncDoc) = 0) then
        ParamByName('INCDOC').AsString := FDadosAbertura.strIncrementoCadPag;

      ParamByName('TIPO').AsString := strTipo;
      ExecSQL;

      if (not FDadosAbertura.blnModoRobo) and (blnUtilizaRotinaLoteContabil) then
      begin
        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' DELETE ');
        qryDel.SQL.Add('   FROM LOTINC ');
        qryDel.SQL.Add('  WHERE INC_TIPLAN = :TIPO ');
        qryDel.SQL.Add('    AND INC_AUTOMA = 1 ');
        qryDel.SQL.Add('    AND INC_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
        qryDel.SQL.Add('    AND INC_EMPLAN = :CODEMP ');
        if FDadosAbertura.blnReprocessaErros then
          TTrataIncDocContabil
            .New
            .fColunaIncDoc('INC_INCDOC')
            .fArrIncDoc(FDadosAbertura.arrIncDoc)
            .fQuerySql(qryDel)
            .fExecute ;
        qryDel.ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
        qryDel.ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
        qryDel.ParamByName('CODEMP').AsString := FDadosAbertura.empresa.strCodigo;
        qryDel.ParamByName('TIPO').AsString := strTipo;
        qryDel.ExecSQL;
      end;
    end;
  finally
    qryDel.Free;
  end;
end;

procedure TGeradorContabil.pGerar;

  function fModoRoboCancelamento: boolean;
  begin
    Result := ((FDadosAbertura.blnModoRobo) and (FDadosAbertura.intModoLancto = MODO_ROBO_3_CANCELAMENTO));
  end;

  var
    strTipo: string;
    LblnPodeGravar: Boolean;
begin
  pValidaPeriodo;

  if FDadosAbertura.strTipoExportacao = TIPO_CONTAS_PAGAR then
  begin
    pGerarPagamento;
    strTipo := 'CTP';
  end
  else if FDadosAbertura.strTipoExportacao = TIPO_CONTAS_PAGAR_PROVISAO then
  begin
    pGerarPagamento;
    strTipo := 'PCP';
  end;

  //exclui os registros do periodo + empresa
  if Not FValidarContas then
    pExcluirDadosExistentes(strTipo);

  if (not FDadosAbertura.blnModoRobo) and (not FDadosAbertura.blnReprocessaErros) then
    pGravarCheckListSemMovimentoGerarMovFinalPreValidacao(strTipo) ;

  if (FListaDadosImportacaoContabil.Count > 0) or (FListaDadosImportacaoContabilWarning.Count > 0) then
  begin
    pValidarContasContabeisDadosImportacao;

    LblnPodeGravar := FDadosAbertura.blnModoRobo or GetListaErros.IsEmpty;
    // Req. 470760: na geracao sem os documentos com erro, os mesmos erros voltam e nao impedem a gravacao.
    if not LblnPodeGravar then
      LblnPodeGravar := fErrosSoDeDocumentosExcluidos;

    if LblnPodeGravar And (Not FValidarContas) then
    begin
      if not fModoRoboCancelamento then
      begin
        //insere no banco de dados os registros capturados
        pGravarDadosImportacao;
      end;
    end;

    if fPodeGerarMovFinalPreValidacao then
    begin
      pExcluirDadosExistentes(strTipo);
      pGravarDadosImportacao;
    end ;

  end;
end;

procedure TGeradorContabil.pGerarPagamento;
  var
    geradorContabilCTP: TGeradorContabilCtp;
    LContasPagar : TContasPagar;
    LitemContasPagarError: TDadosImportacaoContabil ;
begin
  geradorContabilCTP := TGeradorContabilCtp.Create(FDadosAbertura, FListaDadosImportacaoContabil, FListaDadosImportacaoContabilWarning, FListaDadosImportacaoContabilError);
  try
    geradorContabilCTP.parametrosContabil := FRepositorio.fRetParametrosContabil(IIF(FDadosAbertura.blnProvisao, 'PCP', 'CTP'));
    geradorContabilCTP.listaPagamentos := FRepositorio.fRetCadPagPorPeriodo;
    geradorContabilCTP.cdsCtpLancadosPeriodoFechado := FRepositorio.fRetCdsCtpLancadosPeriodoFechado;

    //carrega os objetos para inserção
    geradorContabilCTP.pGerar;

    geradorContabilCTP.cdsCtpLancadosPeriodoFechado := nil;

    if geradorContabilCTP.ListaDadosImportacaoContabilError.Count > 0 then
    begin
      for LitemContasPagarError in geradorContabilCTP.ListaDadosImportacaoContabilError do
      begin
        pCarregaListaErros(LitemContasPagarError.strMensagemUsuario,
                       IIF(LitemContasPagarError.strOrigemCredito.IsEmpty, LitemContasPagarError.strOrigemDebito, LitemContasPagarError.strOrigemCredito),
                       LitemContasPagarError,
                       fgetContabilizaveis(LitemContasPagarError.strCtpInc));
      end ;
    end ;

    if (ValidaSomaCreditoDebitoIgualZero) then
    begin
      if (geradorContabilCTP.listaPagamentos.Count > 0) then
      begin
        for LContasPagar in geradorContabilCTP.listaPagamentos do
          pValidarTotalDeDebitosECreditos(LContasPagar.strAutoincrem);
      end;
    end;

    if (geradorContabilCTP.listaPagamentos.Count > 0) then
    begin
      for LContasPagar in geradorContabilCTP.listaPagamentos do
        pValidarEmpresaMatrizFilialCtpDet(LContasPagar.strAutoincrem);
    end;

    pValidarHistorico ;
  finally
    geradorContabilCTP.Free;
  end;
end;

procedure TGeradorContabil.pGravarCheckList(const AstrTipLan: string);
var
  LdtaIni : TDateTime ;
  LdtaFin : TDateTime ;
  LstrCodEmp: String ;
begin
  LdtaIni := VS_Date ;
  LdtaFin := VS_Date ;
  if FDadosAbertura.blnModoRobo then
  begin
    LdtaIni := FDadosAbertura.dtaLanRobo ;
    LdtaFin := FDadosAbertura.dtaLanRobo ;
    LstrCodEmp := FDadosAbertura.strEmpRobo ;
  end
  else
  begin
    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      LdtaIni := FDadosAbertura.dtaDataInicial;
      LdtaFin := FDadosAbertura.dtaDataFinal;
    end ;
    LstrCodEmp := trim(FDadosAbertura.empresa.strCodigo) ;
  end ;

  TProcessaCheckList.fEstornar(AstrTipLan, LstrCodEmp, LdtaIni, LdtaFin) ;
  TProcessaCheckList.fLancar(AstrTipLan, LstrCodEmp, LdtaIni, LdtaFin) ;
end ;

function TGeradorContabil.fVerificaPlanco(const AstrConta: String): string ;
begin
  Result := fCampoTabela('AUTOINCREM', 'PLANCO', ['NCO_CODCON'], [AstrConta], False) ;
end ;

procedure TGeradorContabil.pIncrementaContadorLote(const AstrAutoInc: String; var AlstControle: TStringList; var AintContador: integer) ;
begin
  if AlstControle.IndexOf(AstrAutoInc) = -1 then
  begin
    AintContador := AintContador + 1 ;
    AlstControle.Add(AstrAutoInc) ;
  end ;
end ;

function TGeradorContabil.fPodeGerarMovFinalPreValidacao:boolean ;
begin
  result := False ;

  if not FblnLancarEmPreValidar then
    exit ;

  if not GetListaErros.IsEmpty then
    exit ;

  result := True ;
end ;

function TGeradorContabil.fTemControleDelLanconOutrasEmpresas(
  const AstrTipo: string): Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery(Nil);
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT LANCNT.CNT_CONTRO  AS CONTROLE ');
    LqryConsulta.SQL.Add(' FROM LANCNT INNER JOIN LANCON AS L ON L.AUTOINCREM = LANCNT.CNT_CONTRO ');
    LqryConsulta.SQL.Add(' WHERE L.CON_TIPLAN = "' + AstrTipo + '" ');
    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      LqryConsulta.SQL.Add('  AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
      LqryConsulta.ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
    end ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('L.CON_INCDOC')
      .fIncDoc(FDadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(FDadosAbertura.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.SQL.Add(' UNION ');

    LqryConsulta.SQL.Add(' SELECT LANCNT.CNT_CONTRO  AS CONTROLE ');
    LqryConsulta.SQL.Add(' FROM LANCNT INNER JOIN LANCON AS L ON L.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    LqryConsulta.SQL.Add(' WHERE L.CON_TIPLAN = "' + AstrTipo + '" ');
    if (FDadosAbertura.dtaDataInicial > 0) then
    begin
      LqryConsulta.SQL.Add('  AND L.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := FDadosAbertura.dtaDataInicial;
      LqryConsulta.ParamByName('DTAFIN').AsDate := FDadosAbertura.dtaDataFinal;
    end ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('L.CON_INCDOC')
      .fIncDoc(FDadosAbertura.strIncrementoCadPag)
      .fArrIncDoc(FDadosAbertura.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.Open ;

    Result := not LqryConsulta.IsEmpty ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TGeradorContabil.pGravarCheckListSemMovimentoGerarMovFinalPreValidacao(const AstrTipLan: string) ;
begin
  if (FListaDadosImportacaoContabil.Count = 0) and fPodeGerarMovFinalPreValidacao then
    pGravarCheckList(AstrTipLan) ;
end ;

function TGeradorContabil.fDocumentoExcluido(const AstrIncDoc: String): Boolean;
begin
  Result := Assigned(FDadosAbertura.lstDocExcluir) and
            (FDadosAbertura.lstDocExcluir.IndexOf(AstrIncDoc + '|CADPAG') >= 0);
end;

function TGeradorContabil.fErrosSoDeDocumentosExcluidos: Boolean;
var
  LcdsErros: TUniClientDataSet;
begin
  // Erro novo, fora da lista da pre-validacao, segue bloqueando a gravacao como hoje.
  Result := False;
  if not Assigned(FDadosAbertura.lstDocExcluir) then
    Exit;

  LcdsErros := GetListaErros;
  LcdsErros.First;
  while not LcdsErros.Eof do
  begin
    if not fDocumentoExcluido(LcdsErros.FieldByName('ERR_CHVDOC').AsString) then
      Exit;
    LcdsErros.Next;
  end;
  Result := True;
end;

procedure TGeradorContabil.pGravarDadosImportacao;
  var
    dados: TDadosImportacaoContabil;
    qryLotInc: TUniQuery;
    intContador: integer;
    LintCntLote: integer;
    LintCntLoteDuplo: integer;
    LListaDadosImportacaoContabil: TObjectList<TDadosImportacaoContabil>;
    LListaDadosImportacaoContabilDuplo: TObjectList<TDadosImportacaoContabil>;
    LlstControleContador: TStringList ;
    LlstControleContadorDuplo: TStringList ;
    LblnInverteContas: Boolean ;
    LstrDescricaoHistoricoPadraoInversao: String ;
    LstrAuxContaCredito: String ;
    LstrAuxCentroCustoCredito: String ;
begin
  intContador := 0;

  qryLotInc := fCriaQuery(nil);
  LListaDadosImportacaoContabil := TObjectList<TDadosImportacaoContabil>.Create(False);
  LListaDadosImportacaoContabilDuplo := TObjectList<TDadosImportacaoContabil>.Create(False);
  LlstControleContador := TStringList.Create ;
  LlstControleContadorDuplo := TStringList.Create ;
  try
    qryLotInc.Close;
    qryLotInc.SQL.Text := fGetSqlInsertLotInc;

    LlstControleContador.Sorted := True ;
    LlstControleContadorDuplo.Sorted := True ;

    LintCntLote := 0 ;
    LintCntLoteDuplo := 0 ;
    for dados in FListaDadosImportacaoContabil do
    begin
      if fDocumentoExcluido(dados.strCtpInc) then
        Continue;

      If (fFormataFloat(dados.fltValorLancamento, 2) <> 0) Then
      Begin
        LblnInverteContas := fInverterContas(dados.strTipoLancamento, dados.fltValorLancamento, (FDadosAbertura.intModoLancto = MODO_ROBO_2_ESTORNO), dados.strFormaPagamento, '') ;

        if (LblnInverteContas) then
        begin
          if (not fEmptyStr(fCfgSis('INVHIS'))) then
          begin
            LstrDescricaoHistoricoPadraoInversao := fRetDescHistoricoPadrao(fCfgSis('INVHIS', varString));
            if not fEmptyStr(LstrDescricaoHistoricoPadraoInversao) then
              dados.intCodigoHistoricoPadrao := fCfgSis('INVHIS', varInteger);
          end;
          LstrAuxContaCredito := dados.strContaCredito ;
          LstrAuxCentroCustoCredito := dados.strCCustoCredito ;

          dados.strContaCredito := dados.strContaDebito ;
          dados.strCCustoCredito := dados.strCCusto ;
          dados.strContaDebito := LstrAuxContaCredito ;
          dados.strCCusto := LstrAuxCentroCustoCredito ;
        end;
        /// deixa as empresa no padrão
        dados.strCodigoEmpresa := dados.empresa.strCodigo ;
        dados.strCodigoEmpDesmem := '' ;
        if Assigned(dados.empresaCtpDet) then
          dados.strCodigoEmpDesmem := dados.empresaCtpDet.strCodigo ;
        dados.strCodigoOperador := strLoginUsuarioLogado ;
        dados.strTabela := 'CADPAG' ;
        dados.intAutomatico := 1 ;
        dados.fltValorLancamento := abs(dados.fltValorLancamento) ;
        if dados.intCodigoHistoricoPadrao <> 0 then
        begin
          dados.strHistorico := fRetDescHistoricoPadrao(dados.intCodigoHistoricoPadrao.ToString, dados.strCodigoEmpresa) + ' ' +  dados.strHistorico ;
        end ;

        if fEmptyStr(fEmpresaCtpDet(dados)) then
        begin
          pIncrementaContadorLote(dados.strCtpInc, LlstControleContador, LintCntLote) ;
          LListaDadosImportacaoContabil.Add(dados) ;
          /// grava o lote
          if LintCntLote > FintTamanhoDoLote then
          begin
            FGravacaoEmLote.pGravar(LListaDadosImportacaoContabil);
            LintCntLote := 0 ;
            LListaDadosImportacaoContabil.Clear ;
          end ;
        end
        else
        begin
          pIncrementaContadorLote(dados.strCtpInc, LlstControleContadorDuplo, LintCntLoteDuplo) ;
          LListaDadosImportacaoContabilDuplo.Add(dados) ;
          /// grava o lote
          if LintCntLoteDuplo > FintTamanhoDoLote then
          begin
            FGravacaoEmLote.pGravarDuplo(LListaDadosImportacaoContabilDuplo);
            LintCntLoteDuplo := 0 ;
            LListaDadosImportacaoContabilDuplo.Clear ;
          end ;
        end ;

        FDadosAbertura.blnGravouRegistro := True;
      End;

      intContador := intContador + 1;

      if (assigned(FDadosAbertura.progresso)) then
        pRegistrarProgresso(FDadosAbertura.progresso, 0, intContador, FListaDadosImportacaoContabil.Count);
    end;

    if LListaDadosImportacaoContabil.Count > 0 then
    begin
      FGravacaoEmLote.pGravar(LListaDadosImportacaoContabil) ;
      LListaDadosImportacaoContabil.Clear ;
    end ;

    if LListaDadosImportacaoContabilDuplo.Count > 0 then
    begin
      FGravacaoEmLote.pGravarDuplo(LListaDadosImportacaoContabilDuplo) ;
      LListaDadosImportacaoContabilDuplo.Clear ;
    end ;

    if (blnUtilizaRotinaLoteContabil) then
    begin
      intContador := 0 ;
      for dados in FListaDadosImportacaoContabil do
      begin
        if fDocumentoExcluido(dados.strCtpInc) then
          Continue;

        qryLotInc.Close;
        qryLotInc.ParamByName('INCDOC').AsString := dados.strCtpInc;
        qryLotInc.ParamByName('TIPLAN').AsString := dados.strTipoLancamento;
        qryLotInc.ParamByName('COMPET').AsString := FormatDateTime('yyyymm', VS_Date);
        qryLotInc.ParamByName('EMPLAN').AsString := dados.empresa.strCodigo;
        qryLotInc.ParamByName('DTALAN').AsDateTime := dados.dtaLancamento;
        qryLotInc.ParamByName('AUTOMA').AsInteger := 1;
        qryLotInc.ParamByName('SEQUEN').AsInteger := fGetNovoLoteContabil;
        qryLotInc.ExecSQL;

        intContador := intContador + 1;

        if (assigned(FDadosAbertura.progresso)) then
          pRegistrarProgresso(FDadosAbertura.progresso, 0, intContador, FListaDadosImportacaoContabil.Count);

      end ;
    end ;

  finally
    FreeAndNil(LListaDadosImportacaoContabil) ;
    FreeAndNil(LListaDadosImportacaoContabilDuplo) ;
    FreeAndNil(LlstControleContador) ;
    FreeAndNil(LlstControleContadorDuplo) ;
    qryLotInc.Free;
  end;
end;

function TGeradorContabil.fEmpresaCtpDet(const AdicDados: TDadosImportacaoContabil): string ;
begin
  result := '' ;
  if not fEmptyStr(AdicDados.empresaCtpDet.strCodigo) then
  begin
    result := AdicDados.empresaCtpDet.strCodigo ;
  end;
end;

function TGeradorContabil.ValidaSomaCreditoDebitoIgualZero: boolean;
begin
  result := False ;
  if not fConfiguracaoExiste('TRDCZE') then
    exit;

  if not fCfgSis('TRDCZE', varBoolean) then
    exit;

  result := True ;
end;

procedure TGeradorContabil.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

procedure TGeradorContabil.pRegistrarProgresso(progresso: TcxProgressBar; intInicio, intAtual, intFinal: Integer);
begin
  progresso.Properties.Min := intInicio;
  progresso.Position := intAtual;
  progresso.Properties.Max := intFinal;
end;

procedure TGeradorContabil.pValidaPeriodo;
begin
  if FDadosAbertura.dtaDataInicial < 0 then
    raise Exception.Create('Data inicial muito antiga!');

  if FDadosAbertura.dtaDataFinal < 0 then
    raise Exception.Create('Data final muito antiga!');
end;

procedure TGeradorContabil.pGeraDicionarioControleDebitoCreditoContas(AobjDados: TDadosImportacaoContabil);
var
  LstrChave: String ;
  LobjControle: TLanConControleDebitoCreditoContas ;
  LstrContaCredito, LstrContaDebito: String ;
begin
  LstrChave := AobjDados.strCtpInc + AobjDados.strPagamento;
  LstrContaCredito := Trim(AobjDados.strContaCredito) ;
  LstrContaDebito := Trim(AobjDados.strContaDebito) ;

  if not FdictControleDebitoCreditoContas.ContainsKey(LstrChave) then
  begin
    LobjControle := TLanConControleDebitoCreditoContas.Create ;
    LobjControle.Dados := AobjDados ;
    FdictControleDebitoCreditoContas.Add(LstrChave, LobjControle);
  end
  else
    LobjControle := FdictControleDebitoCreditoContas.Items[LstrChave] ;

  if (not fEmptyStr(LstrContaCredito)) and (not AobjDados.blnIsCtpDet) and (not AobjDados.blnIsAgrup) then
  begin
    if (fEmptyStr(LstrContaDebito)) AND (LobjControle.CntCredito.IndexOf(LstrContaCredito) < 0) then
    begin
      LobjControle.CntCredito.Add(LstrContaCredito) ;
      LobjControle.ValCntCredito.Add(AobjDados.strDescricaoValor) ;
    end;
  end;

  if (not fEmptyStr(LstrContaDebito)) and (not AobjDados.blnIsCtpDet) and (not AobjDados.blnIsAgrup) then
  begin
    if (fEmptyStr(LstrContaCredito)) AND (LobjControle.CntDebito.IndexOf(LstrContaDebito) < 0) then
    begin
      LobjControle.CntDebito.Add(LstrContaDebito) ;
      LobjControle.ValCntDebito.Add(AobjDados.strDescricaoValor) ;
    end;
  end;

end;

procedure TGeradorContabil.pValidarContasContabeisDadosImportacao;
  var
    dados: TDadosImportacaoContabil;
    intContador: integer;
    strMotivo : string;
    blnGerLan : boolean;
    strMensagemValidacao : string ;
    LstrContaContabil : String ;
    LlstContasDebCredDuplicadas, LlstDescValorContaDebDup, LlstDescValorContaCreDup : TStringList;
    Lindice, LindiceDeb: Integer;
    LobjControle: TLanConControleDebitoCreditoContas;
    LparDebCred: TPair<string, TLanConControleDebitoCreditoContas> ;
    LobjDados: TDadosImportacaoContabil ;
    LstrOrigem: String ;
begin
  FdictControleDebitoCreditoContas.Clear;
  intContador := 0;

  ////processa os warnings, caso tenha
  for dados in FListaDadosImportacaoContabilWarning do
  begin
    pCarregaListaErros(dados.strMensagemUsuario, dados.strOrigemCredito, dados, fgetContabilizavel(dados.strCodigoContabilizavelCredito, dados.strOrigemCredito, dados.strCtpInc), True);
  end ;

  for dados in FListaDadosImportacaoContabil do
  begin
    blnGerLan := True;

    if fLancamentoUtilizaCentroDeCusto(dados.strTipoLancamento) then
    begin
      if not fValidouCentroDeCusto(tpcDebito, dados.strContaDebito, dados.strCCusto, strMotivo, FcdsPlancoInfo, dados.empresa.strCodigo, FblnTemCentroCusto) then
      begin
        pCarregaListaErros(strMotivo, '', dados, TContabilizaveis.Create);
        blnGerLan := False;
      end;
    end;

    if (blnGerLan) then
    begin
      pGeraDicionarioControleDebitoCreditoContas(dados);

      if dados.blnParametrizouCredito then
      begin
        LstrContaContabil := fVerificaPlanco(dados.strContaCredito) ;
        if fEmptyStr(LstrContaContabil) then
          pCarregaListaErros('Conta de crédito não informada', dados.strOrigemCredito, dados, fgetContabilizavel(dados.strCodigoContabilizavelCredito, dados.strOrigemCredito, dados.strCtpInc));
      end;

      if dados.blnParametrizouDebito then
      begin
        LstrContaContabil := fVerificaPlanco(dados.strContaDebito) ;
        if fEmptyStr(LstrContaContabil) then
          pCarregaListaErros('Conta de débito não informada', dados.strOrigemDebito, dados, fgetContabilizavel(dados.strCodigoContabilizavelDebito, dados.strOrigemDebito, dados.strCtpInc));
      end;

      if (dados.strContaCredito.IsEmpty) and (dados.strContaDebito.IsEmpty) then
        pCarregaListaErros(CONTABIL_MSG_NAO_DEFINIU_DEBITO_NEM_CREDITO, dados.strOrigemDebito, dados, fgetContabilizavel(dados.strCodigoContabilizavelCredito, dados.strOrigemCredito, dados.strCtpInc));

      ///verifica se a conta existe e se é sintética
      strMensagemValidacao := fVericaContaNoPlanoContas(dados.strContaCredito, dados.empresa.strCodigo, 'crédito', FlstControlePesquisaContaContabil) ;
      if not fEmptyStr(strMensagemValidacao) then
      begin
        pCarregaListaErros(strMensagemValidacao, dados.strOrigemCredito, dados, fgetContabilizavel(dados.strCodigoContabilizavelCredito, dados.strOrigemCredito, dados.strCtpInc));
        continue ;
      end ;

      strMensagemValidacao := fVericaContaNoPlanoContas(dados.strContaDebito, dados.empresa.strCodigo, 'débito', FlstControlePesquisaContaContabil) ;
      if not fEmptyStr(strMensagemValidacao) then
      begin
        pCarregaListaErros(strMensagemValidacao, dados.strOrigemDebito, dados, fgetContabilizavel(dados.strCodigoContabilizavelDebito, dados.strOrigemDebito, dados.strCtpInc));
        continue ;
      end ;

      if (not fEmptyStr(dados.strContaCredito)) and (not fEmptyStr(dados.strContaDebito)) and (dados.strContaCredito = dados.strContaDebito) then
      begin
        pCarregaListaErros(format(CONTABIL_MSG_CONTA_CREDITO_DEBITO_IGUAIS, [dados.strContaCredito, dados.strContaDebito]), dados.strOrigemDebito, dados, fgetContabilizavel(dados.strCodigoContabilizavelDebito, dados.strOrigemDebito, dados.strCtpInc));
        continue ;
      end ;

      ///Verifica a se o lançamento está na vigência da conta contábil.
      if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                     dados.dtaLancamento,
                                     dados.strContaCredito,
                                     strMensagemValidacao,
                                     dados.empresa.strCodigo,
                                     AlstControleVigenciaContaContabil) then
      begin
        pCarregaListaErros(strMensagemValidacao, dados.strOrigemCredito, dados, fgetContabilizavel(dados.strCodigoContabilizavelCredito, dados.strOrigemCredito, dados.strCtpInc));
      end ;

      if not fVerificaPlancoVigencia(cdsPlancoVigencia,
                                     dados.dtaLancamento,
                                     dados.strContaDebito,
                                     strMensagemValidacao,
                                     dados.empresa.strCodigo,
                                     AlstControleVigenciaContaContabil) then
      begin
        pCarregaListaErros(strMensagemValidacao, dados.strOrigemDebito, dados, fgetContabilizavel(dados.strCodigoContabilizavelDebito, dados.strOrigemDebito, dados.strCtpInc));
      end ;
      ///
    end;

    intContador := intContador + 1;

    if (assigned(FDadosAbertura.progresso)) then
      pRegistrarProgresso(FDadosAbertura.progresso, 0, intContador, FListaDadosImportacaoContabil.Count);
  end;

  if FdictControleDebitoCreditoContas.Count > 0 then
  begin
    LlstContasDebCredDuplicadas := nil;
    LlstDescValorContaDebDup    := nil;
    LlstDescValorContaCreDup    := nil;
    try
      LlstContasDebCredDuplicadas := TStringList.Create;
      LlstDescValorContaDebDup    := TStringList.Create;
      LlstDescValorContaCreDup    := TStringList.Create;

      for LparDebCred in FdictControleDebitoCreditoContas do
      begin
        LobjControle := LparDebCred.Value ;

        LlstContasDebCredDuplicadas.Clear;
        LlstDescValorContaCreDup.Clear;
        LlstDescValorContaDebDup.Clear;

        for Lindice := 0 to LobjControle.CntCredito.Count - 1 do
        begin
          LindiceDeb := LobjControle.CntDebito.IndexOf(LobjControle.CntCredito[Lindice]) ;
          if LindiceDeb <> -1 then
          begin
            LlstContasDebCredDuplicadas.Add(LobjControle.CntCredito[Lindice]) ;
            LlstDescValorContaCreDup.Add(LobjControle.ValCntCredito[Lindice]) ;
            LlstDescValorContaDebDup.Add(LobjControle.ValCntDebito[LindiceDeb]) ;
          end;
        end;

        if (LlstContasDebCredDuplicadas.Count > 0) then
        begin
          LobjDados := LparDebCred.Value.Dados ;
          LstrOrigem := fRetornaOrigemImpMovimento(LobjDados) ;

          for Lindice := 0 to LlstContasDebCredDuplicadas.Count - 1 do
          begin
            if LlstDescValorContaCreDup[Lindice] = LlstDescValorContaDebDup[Lindice] then
            begin
              pCarregaListaErros(format(CONTABIL_MSG_CONTA_CREDITO_DEBITO_IGUAIS, [LlstContasDebCredDuplicadas[Lindice], LlstContasDebCredDuplicadas[Lindice]]),
                                 LstrOrigem,
                                 LobjDados.strHistorico,
                                 LobjDados.strTipoLancamento,
                                 LlstDescValorContaCreDup[Lindice],
                                 LobjDados.strTabela,
                                 LobjDados.strCtpInc,
                                 fgetContabilizaveis(LobjDados.strCtpInc),
                                 False,
                                 LobjDados.dtaLancamento,
                                 LobjDados.empresa.strCodigo);
            end
            else
            begin
              pCarregaListaErros(format(CONTABIL_MSG_CONTA_CREDITO_TEM_REFERENCIA_DEBITO,[LlstContasDebCredDuplicadas[Lindice]]),
                                 LstrOrigem,
                                 LobjDados.strHistorico,
                                 LobjDados.strTipoLancamento,
                                 LlstDescValorContaCreDup[Lindice],
                                 LobjDados.strTabela,
                                 LobjDados.strCtpInc,
                                 fgetContabilizaveis(LobjDados.strCtpInc),
                                 False,
                                 LobjDados.dtaLancamento,
                                 LobjDados.empresa.strCodigo);
              pCarregaListaErros(format(CONTABIL_MSG_CONTA_DEBITO_TEM_REFERENCIA_CREDITO,[LlstContasDebCredDuplicadas[Lindice]]),
                                 LstrOrigem,
                                 LobjDados.strHistorico,
                                 LobjDados.strTipoLancamento,
                                 LlstDescValorContaDebDup[Lindice],
                                 LobjDados.strTabela,
                                 LobjDados.strCtpInc,
                                 fgetContabilizaveis(LobjDados.strCtpInc),
                                 False,
                                 LobjDados.dtaLancamento,
                                 LobjDados.empresa.strCodigo);
            end;
          end;
        end ;
      end ;

    finally
      FreeAndNil(LlstContasDebCredDuplicadas);
      FreeAndNil(LlstDescValorContaDebDup);
      FreeAndNil(LlstDescValorContaCreDup);
    end;
  end;

end;

procedure TGeradorContabil.pValidarEmpresaMatrizFilialCtpDet(const AChave: string);
var
  dados: TDadosImportacaoContabil;
  LlstControle: TStringList ;
  LstrCnpj: string ;
begin
  if fCfgDesMva = 'N' then
    exit;

  if not Assigned(FListaDadosImportacaoContabil) then
    Exit;

  if FListaDadosImportacaoContabil.Count = 0 then
    Exit;

  if AChave.IsEmpty then
    Exit;

  LlstControle := TStringList.Create ;
  try
    LlstControle.Sorted := True ;
    for dados in FListaDadosImportacaoContabil do
    begin
      if (AChave = dados.strCtpInc) and (dados.blnIsCtpDet) then
      begin
        if not fEmptyStr(dados.empresaCtpDet.strCodigo) then
        begin
          LstrCnpj := copy(dados.empresaCtpDet.strC_G_C,1,8) ;
          if LlstControle.IndexOf(LstrCnpj) < 0 then
          begin
            LlstControle.Add(LstrCnpj) ;
          end;
        end;

        if LlstControle.Count > 1 then
        begin
          pCarregaListaErros('Não é permitido desmembramento entre empresas com CNPJ diferente!',
                                 IIF(dados.strOrigemCredito.IsEmpty, dados.strOrigemDebito, dados.strOrigemCredito),
                                 dados,
                                 fgetContabilizaveis(AChave));
          break ;
        end;

      end;
    end;

  finally
    FreeAndNil(LlstControle) ;
  end;


end;

procedure TGeradorContabil.pValidarHistorico;
var
  Lobjdados: TDadosImportacaoContabil;
  LstrOrigem : String ;
begin
  for Lobjdados in FListaDadosImportacaoContabil do
  begin
    if (Lobjdados.intCodigoHistoricoPadrao = 0) and fEmptyStr(Lobjdados.strHistorico) then
    begin
      LstrOrigem := fRetornaOrigemImpMovimento(Lobjdados) ;
      pCarregaListaErros(MSG_VALIDA_HISTORICO,
                         LstrOrigem,
                         Lobjdados,
                         fgetContabilizaveis(Lobjdados.strCtpInc));
    end ;
  end ;
end;

procedure TGeradorContabil.pValidarTotalDeDebitosECreditos(const AChave: string);
  var
    dados: TDadosImportacaoContabil;
    fltTotalDebitos : double;
    fltTotalCreditos : double;
    LstrOrigem : String ;
begin
  if not fConfiguracaoExiste('TRDCZE') then
    exit;

  if not fCfgSis('TRDCZE', varBoolean) then
    exit;

  if not Assigned(FListaDadosImportacaoContabil) then
    Exit;

  if FListaDadosImportacaoContabil.Count = 0 then
    Exit;

  if AChave.IsEmpty then
    Exit;

  pSomaDebitoCreditoImpMovimento(AChave, FListaDadosImportacaoContabil, fltTotalCreditos, fltTotalDebitos) ;

  if (fFormataFloat(fltTotalCreditos + fltTotalDebitos, 2) <> 0) then
  begin
    if ((fFormataFloat(fltTotalDebitos, 2) - fFormataFloat(fltTotalCreditos, 2)) <> 0) then
    begin
      for dados in FListaDadosImportacaoContabil do
      begin
        if (AChave = dados.strCtpInc) and (dados.fltValorLancamento <> 0) then
        begin
          ///para evitar duplicidade quando tem AGP
          if not fEstaNaListaControleDiferencaDebitoCredito(AChave+dados.strDescricaoValor, FlstControleDiferencaDebitoCredito) then
          begin
            LstrOrigem := fRetornaOrigemImpMovimento(dados) ;

            pCarregaListaErros(format(CONTABIL_MSG_TOTDEB_MENOS_TOTCRE_DIFERENTE_ZERO,[FormatCurr('#,##0.00', fFormataFloat(fltTotalDebitos, 2)), FormatCurr('#,##0.00', fFormataFloat(fltTotalCreditos, 2))]),
                             LstrOrigem,
                             dados,
                             fgetContabilizaveis(AChave));
          end ;
        end;
      end;
    end;
  end;
end;

end.
