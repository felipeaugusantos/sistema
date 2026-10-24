unit Contabilidade.Classes.TImportacaoDadosContabeisLancon;

interface

uses Uni, cxProgressBar, Classes, Data.DB,
     Contabilidade.Classes.TImportacaoDadosContabeis,
     Contabilidade.Classes.TValidaProcessoLancamentoContabil,
     System.Generics.Collections, UniClientDataSet, Contabilidade.Interfaces, Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisLancon = Class(TImportacaoDadosContabeisBase)
  private
    FarrLanCon : TObjectList<TLanConInfo> ;
    FstrTipLan : String ;
    FblnExisteCampoCON_VERSIS : boolean ;
    FblnExisteCampoCON_EMPLOG : boolean ;
    function fConverteEstruturaParaValidacao(const AArr: TObjectList<TLanConInfo>):TList<TDadosValidacaoLanCon> ;
    function fValidaSubConta(const AstrContaCredito, AstrContaDebito: String): Boolean ;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert:string; override;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados: boolean; override ;
    constructor Create(pgbProgresso: TcxProgressBar; AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const AstrTipLan: String; ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;


implementation

uses SysUtils, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls,
     StrUtils, Contabilidade.Funcoes, Variants;

{ TImportacaoDadosContabeisLancon }

function TImportacaoDadosContabeisLancon.fGetNomeTabela: string;
begin
  Result := 'LANCON';
end;

constructor TImportacaoDadosContabeisLancon.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean; const AstrTipLan: String;
  ACfgContabil: ICfgContabil);
begin
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil);
  FstrTipLan := AstrTipLan ;
  FarrLanCon := TObjectList<TLanConInfo>.Create();
  FblnExisteCampoCON_VERSIS := fCampoExiste('LANCON', 'CON_VERSIS');
  FblnExisteCampoCON_EMPLOG := fCampoExiste('LANCON', 'CON_EMPLOG');
end;

destructor TImportacaoDadosContabeisLancon.Destroy;
begin
  FreeAndNil(FarrLanCon) ;
  inherited;
end;

function TImportacaoDadosContabeisLancon.fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean;
var
  LintConLin : integer ;
  LDadosValidacao: TList<TDadosValidacaoLanCon> ;
  LlcItem: TLanConInfo ;
  LcdsPlancoVigencia: TUniClientDataset ;
  LstrCodEveDeb, LstrCodEveCre: string ;
  LcdsPlancoInfo: TUniClientDataSet;
  LintQtdLinhas: Integer ;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo Planilha: Lançamentos Contábeis');
  result := False ;
  if not fValidaCabecalho then
    exit ;

  if not fQtdLinhas(LintQtdLinhas) then
    exit ;

  pgbProgresso.Properties.Max := LintQtdLinhas-1;

  FarrLanCon.Clear ;

  LcdsPlancoInfo := fCarregaPlancoInfo ;
  try
    For LintConLin := fIndicePrimeiroRegistro To LintQtdLinhas-1 Do
    Begin
      pgbProgresso.Position := LintConLin;
      Application.ProcessMessages;

      LlcItem := TLanConInfo.Create ;
      LlcItem.LINHA      := IntToStr(LintConLin) ;
      LlcItem.CON_EMPLAN := fStrZero(copy(fGetDadosCelula(0, LintConLin, tdcStr), 1, 3), 3) ;
      LlcItem.CON_DTALAN := fGetDadosCelula(1, LintConLin, tdcDate) ;
      LlcItem.CON_CONDEB := copy(fSemMascaraPlaNco(fGetDadosCelula(2, LintConLin, tdcStr)), 1, 20) ;
      LlcItem.CON_CONCRE := copy(fSemMascaraPlaNco(fGetDadosCelula(3, LintConLin, tdcStr)), 1, 20) ;
      LlcItem.CON_HISPAD := fGetDadosCelula(4, LintConLin, tdcInt) ;
      LlcItem.CON_HISTOR := fGetDadosCelula(5, LintConLin, tdcStr) ;
      LlcItem.CON_VALLAN := fGetDadosCelula(6, LintConLin, tdcFloat) ;
      LlcItem.CON_CCUSTO := copy(fGetDadosCelula(7, LintConLin, tdcStr), 1, 5) ;
      LlcItem.CON_CCUSCR := copy(fGetDadosCelula(8, LintConLin, tdcStr), 1, 5) ;
      LlcItem.CON_CCUSTO := iif(fEmptyStr(LlcItem.CON_CCUSTO), '', fStrZero(LlcItem.CON_CCUSTO,5)) ;
      LlcItem.CON_CCUSCR := iif(fEmptyStr(LlcItem.CON_CCUSCR), '', fStrZero(LlcItem.CON_CCUSCR,5)) ;

      LstrCodEveDeb := fRetornaCentroCusto(LcdsPlancoInfo, LlcItem.CON_CONDEB, LlcItem.CON_CCUSTO, LlcItem.CON_EMPLAN) ;
      LstrCodEveCre := fRetornaCentroCusto(LcdsPlancoInfo, LlcItem.CON_CONCRE, LlcItem.CON_CCUSCR, LlcItem.CON_EMPLAN) ;
      LlcItem.CON_CCUSTO := LstrCodEveDeb ;
      LlcItem.CON_CCUSCR := LstrCodEveCre ;

      LlcItem.CON_INCDOC := copy(fGetDadosCelula(9, LintConLin, tdcStr), 1, 20) ;
      LlcItem.CON_INCDOC := iif(fEmptyStr(LlcItem.CON_INCDOC), fGerarIncDocLanConManual, LlcItem.CON_INCDOC) ;

      if fCfgDesmembrarSubContaCliFor = 'S' then
      begin
        if fValidaSubConta(LlcItem.CON_CONCRE, LlcItem.CON_CONDEB) then
        begin
          LlcItem.CON_CLIFOR := fStrZero(copy(fGetDadosCelula(10, LintConLin, tdcStr), 1, 8), 8) ;
          LlcItem.CON_TIP_FC := copy(fGetDadosCelula(11, LintConLin, tdcStr), 1, 1) ;
        end ;
      end ;

      FarrLanCon.Add(LlcItem) ;

    End;

  finally
    FreeAndNil(LcdsPlancoInfo) ;
  end ;

  if not FblnIgnorarErrosImportacao then
  begin
    if FMensagemErroDadosContabeis.fTemMensagemErro then
    begin
      if not FblnImportacaoOrquestrada then
        FMensagemErroDadosContabeis.pMostraMensagemErro(True) ;
      exit ;
    end;
  end;

  ///valida as informações carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrLanCon) ;
  LcdsPlancoVigencia := fCarregaPlancoVigencia ;
  try
    if not TValidaProcessoLancamentoContabil.fValidaBloco(LDadosValidacao, LcdsPlancoVigencia) then
      exit ;

  finally
    FreeAndNil(LDadosValidacao) ;
    FreeAndNil(LcdsPlancoVigencia) ;
  end;

  result := True ;
end;

function TImportacaoDadosContabeisLancon.fGetSqlInsert: string;
var
  LstrColunasSubConta, LstrParametrosSubConta,
  LstrColunasVersis, LstrParametrosVersis: String ;
  LstrColunasEmplog, LstrParametrosEmplog: String ;
begin
  LstrColunasSubConta := '' ;
  LstrParametrosSubConta := '' ;
  if fCfgDesmembrarSubContaCliFor = 'S' then
  begin
    LstrColunasSubConta := ', CON_CLIFOR, CON_TIP_FC ' ;
    LstrParametrosSubConta := ', :CLIFOR, :TIP_FC ' ;
  end ;

  LStrColunasVersis := '';
  LStrParametrosVersis := '';
  if FblnExisteCampoCON_VERSIS then
  begin
    LStrColunasVersis := ', CON_VERSIS ';
    LStrParametrosVersis := ', :VERSIS ';
  end;

  LStrColunasEmplog := '';
  LStrParametrosEmplog := '';
  if FblnExisteCampoCON_EMPLOG then
  begin
    LStrColunasEmplog := ', CON_EMPLOG ';
    LStrParametrosEmplog := ', :EMPLOG ';
  end;

  result := ' INSERT INTO LANCON ' ;
  result := result + ' ( ' ;
  result := result + ' CON_EMPLAN, ' ;
  result := result + ' CON_TIPLAN, ' ;
  result := result + ' CON_DTALAN, ' ;
  result := result + ' CON_CONCRE, ' ;
  result := result + ' CON_CONDEB, ' ;
  result := result + ' CON_HISPAD, ' ;
  result := result + ' CON_HISTOR, ' ;
  result := result + ' CON_VALLAN, ' ;
  result := result + ' CON_CCUSTO, ' ;
  result := result + ' CON_CCUSCR, ' ;
  result := result + ' CON_CODOPE, ' ;
  result := result + ' CON_INCDOC ' ;
  result := result + LstrColunasSubConta ;
  result := result + LStrColunasVersis ;
  result := result + LStrColunasEmplog ;
  result := result + ' ) ' ;
  result := result + ' VALUES ' ;
  result := result + ' ( ' ;
  result := result + ' :EMPLAN, ' ;
  result := result + ' :TIPLAN, ' ;
  result := result + ' :DTALAN, ' ;
  result := result + ' :CONCRE, ' ;
  result := result + ' :CONDEB, ' ;
  result := result + ' :HISPAD, ' ;
  result := result + ' :HISTOR, ' ;
  result := result + ' :VALLAN, ' ;
  result := result + ' :CCUSTO, ' ;
  result := result + ' :CCUSCR, ' ;
  result := result + ' :CODOPE, ' ;
  result := result + ' :INCDOC ' ;
  result := result + LstrParametrosSubConta ;
  result := result + LStrParametrosVersis ;
  result := result + LStrParametrosEmplog ;
  result := result + ' ) ; ' ;
end;

function TImportacaoDadosContabeisLancon.fPersisteDados: boolean;
var
  intCnt : integer ;
  strMensagemErro : string ;
  blnAbortado : boolean ;
  LlcItem: TLanConInfo ;
begin
  result := false ;
  blnAbortado := False ;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Lançamentos Contábeis');
  pgbProgresso.Properties.Max := FarrLanCon.Count;

  pStartTransactionImportacao ;
  try
    intCnt := 0 ;

    FqryExec.Close ;
    FqryExec.SQL.Clear ;
    FqryExec.SQL.Text := fGetSqlInsert ;
    for LlcItem in FarrLanCon do
    begin
      try
        pgbProgresso.Position := intCnt+1;
        Application.ProcessMessages;

        FqryExec.ParamByName('EMPLAN').AsString := fstrZero(LlcItem.CON_EMPLAN, 3) ;
        FqryExec.ParamByName('TIPLAN').AsString := FstrTipLan ;
        FqryExec.ParamByName('DTALAN').AsDate := LlcItem.CON_DTALAN ;
        FqryExec.ParamByName('CONCRE').Value := iif(fEmptyStr(LlcItem.CON_CONCRE), Null, LlcItem.CON_CONCRE) ;
        FqryExec.ParamByName('CONDEB').Value := iif(fEmptyStr(LlcItem.CON_CONDEB), Null, LlcItem.CON_CONDEB) ;
        FqryExec.ParamByName('HISPAD').Value := iif(LlcItem.CON_HISPAD = 0, Null, LlcItem.CON_HISPAD) ;
        FqryExec.ParamByName('HISTOR').AsString := LlcItem.CON_HISTOR ;
        FqryExec.ParamByName('VALLAN').AsFloat := LlcItem.CON_VALLAN ;
        FqryExec.ParamByName('CCUSTO').Value := iif(fEmptyStr(LlcItem.CON_CCUSTO), Null, LlcItem.CON_CCUSTO) ;
        FqryExec.ParamByName('CCUSCR').Value := iif(fEmptyStr(LlcItem.CON_CCUSCR), Null, LlcItem.CON_CCUSCR) ;
        FqryExec.ParamByName('CODOPE').AsString := strLoginUsuarioLogado ;
        FqryExec.ParamByName('INCDOC').AsString := LlcItem.CON_INCDOC ;
        if fCfgDesmembrarSubContaCliFor = 'S' then
        begin
          FqryExec.ParamByName('CLIFOR').AsString := LlcItem.CON_CLIFOR ;
          FqryExec.ParamByName('TIP_FC').AsString := LlcItem.CON_TIP_FC ;
        end ;
        if FblnExisteCampoCON_VERSIS then
          FqryExec.ParamByName('VERSIS').AsString := VC_StrVersaoContabilidade ;
        if FblnExisteCampoCON_EMPLOG then
          FqryExec.ParamByName('EMPLOG').AsString := VS_strCodEmp ;
        FqryExec.ExecSQL ;
      except
        on E1: Exception Do
        begin
          strMensagemErro := 'Problemas ao importar a linha '+inttostr(intCnt+2)+', erro: '+E1.Message ;
          if not FblnIgnorarErrosImportacao then
          begin
            blnAbortado := True ;
            raise Exception.Create(strMensagemErro);
          end
          else
          begin
            blnAbortado := False ;
            FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro) ;
          end;
        end;
      end;
    end;

    pCommitImportacao ;
  Except
    On E2: Exception Do
    Begin
      pRollbackImportacao ;
      FMensagemErroDadosContabeis.pRegistraMensagemErro(E2.Message) ;
    End;
  End;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada) ;
    exit ;
  end;

  pMensagemSucesso ;

  result := true ;
end;

function TImportacaoDadosContabeisLancon.fValidaSubConta(const AstrContaCredito,
  AstrContaDebito: String): Boolean;
var
  LstrTplAco, LstrSubConta: String ;
  LblnSubContaCredito, LblnSubContaDebito: Boolean ;
begin
  LblnSubContaCredito := False ;
  LblnSubContaDebito := False ;
  LstrTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);
  if not fEmptyStr(AstrContaCredito) then
  begin
    LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [AstrContaCredito, LstrTplAco], False) ;
    LblnSubContaCredito := LstrSubConta = 'S'
  end ;

  if not fEmptyStr(AstrContaDebito) then
  begin
    LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [AstrContaDebito, LstrTplAco], False) ;
    LblnSubContaDebito := LstrSubConta = 'S'
  end ;

  Result := LblnSubContaCredito or LblnSubContaDebito ;

end;

procedure TImportacaoDadosContabeisLancon.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO EMPRESA*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('DATA LANÇAMENTO*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA DEBITO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CONTA CREDITO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO HISTÓRICO PADRÃO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('COMPLEMENTO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('VALOR LANÇAMENTO*', True)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CENTRO CUSTO DEBITO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CENTRO CUSTO CREDITO', False)) ;
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CÓDIGO AGRUPADOR', False)) ;
  if fCfgDesmembrarSubContaCliFor = 'S' then
  begin
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('SUBCONTA', False)) ;
    FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('C/F', False)) ;
  end ;
end;

function TImportacaoDadosContabeisLancon.fConverteEstruturaParaValidacao(
  const AArr: TObjectList<TLanConInfo>): TList<TDadosValidacaoLanCon>;
var
  LlciItem: TLanConInfo ;
  regItem: TDadosValidacaoLanCon;
begin
  Result := TList<TDadosValidacaoLanCon>.Create();
  for LlciItem in AArr do
  begin
    FillChar(regItem, SizeOf(regItem), #0);
    regItem.dtaLan := LlciItem.CON_DTALAN ;
    regItem.strCodEmp := LlciItem.CON_EMPLAN ;
    regItem.fltValor := LlciItem.CON_VALLAN ;
    regItem.strContaCredito := LlciItem.CON_CONCRE ;
    regItem.strContaDebito := LlciItem.CON_CONDEB ;
    regItem.strCentroCustoCredito := LlciItem.CON_CCUSCR ;
    regItem.strCentroCustoDebito := LlciItem.CON_CCUSTO ;
    regItem.strComplemento := LlciItem.CON_HISTOR ;
    regItem.strHistoricoPadrao := inttostr(LlciItem.CON_HISPAD) ;
    if fCfgDesmembrarSubContaCliFor = 'S' then
    begin
      regItem.blnValidarClienteFornecedorDebito := fValidaSubConta(regItem.strContaCredito, regItem.strContaDebito) ;
      regItem.strClienteFornecedorDebito := LlciItem.CON_CLIFOR ;
      regItem.strTipoFCDebito := LlciItem.CON_TIP_FC ;
    end ;
    regItem.strIncDoc := LlciItem.CON_INCDOC ;
    regItem.strLinha  := LlciItem.LINHA ;
    Result.Add(regItem) ;
  end;
end;

end.
