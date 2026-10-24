unit Contabilidade.Classes.TImportacaoDadosContabeisParCon;

interface

uses
  Uni, cxProgressBar, System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis, Contabilidade.Interfaces,
  Contabilidade.Classes.TValidaProcessoParCon, Contabilidade.Classes.CfgContabil;

type
  TParConMapInfo = record
    strSeqPar : string ;
    strMd5Key : string ;
  end;

  TImportacaoDadosContabeisParCon = Class(TImportacaoDadosContabeisBase)
  private
    FFontesComplementares: TDictFontesComplementares;
    FMapaCodigosHispad: TDictMapaCodigosHispad;
    FarrParCon: array of TParConInfo;
    FarrCmpPar: array of TCmpParInfo;
    FarrParNco: array of TParNcoInfo;
    FdctParConMap: TDictionary<string, TParConMapInfo>;
    function fLookupNatCfo(const AstrDescri: string): string;
    function fResolveCodemp: string;
    function fConverteEstruturaParaValidacao(const AArr: array of TParConInfo): TList<TDadosValidacaoParCon>;
    procedure pCarregaCmpPar;
    procedure pCarregaParNco;
  protected
    procedure pCarregaInfoColunas; override;
    function fGetSqlInsert: string; override;
    function fGetSqlInsertCmpPar: string;
    function fGetSqlInsertParNco: string;
    function fGetNomeTabela: string; override;
  public
    function fCarregaDadosPlanilha(const AprocErros: TErroContabilProc): boolean; override;
    function fPersisteDados: boolean; override;

    constructor Create(pgbProgresso: TcxProgressBar;
      AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
      AFontesComplementares: TDictFontesComplementares;
      AMapaCodigosHispad: TDictMapaCodigosHispad = nil;
      ACfgContabil: ICfgContabil = nil);
    destructor Destroy; override;
  End;

implementation

uses
  System.SysUtils, Vcl.Forms, untFuncoesSimples, Contabilidade.Funcoes,
  Contabilidade.Classes.THashParCon, Data.DB;

{ TImportacaoDadosContabeisParCon }

function TImportacaoDadosContabeisParCon.fGetNomeTabela: string;
begin
  Result := 'PARCON';
end;

constructor TImportacaoDadosContabeisParCon.Create(pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  AFontesComplementares: TDictFontesComplementares;
  AMapaCodigosHispad: TDictMapaCodigosHispad;
  ACfgContabil: ICfgContabil);
begin
  FFontesComplementares := AFontesComplementares;
  FMapaCodigosHispad := AMapaCodigosHispad;
  FdctParConMap := TDictionary<string, TParConMapInfo>.Create;
  inherited Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, ACfgContabil);
end;

destructor TImportacaoDadosContabeisParCon.Destroy;
begin
  FreeAndNil(FdctParConMap);
  inherited;
end;

procedure TImportacaoDadosContabeisParCon.pCarregaInfoColunas;
begin
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_SEQPAR*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_TIPLAN*', True));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_FORPGO', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_NATOPE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_DESVAL', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CLAFIS', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CONCRE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CFCRED', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PORCRE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_HISCRE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CONDEB', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CFDEBI', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PORDEB', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PCCRED', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PCDEBI', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_NATCFO', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PAGAME', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_ORIGEM', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_TIPPCD', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_TIPPCC', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_BANDEB', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_BANCRE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_ABFDEB', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_ABFCRE', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_PAGANT', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_TITPDD', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CODTRI', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CODORI', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_VIGINI', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_VIGFIN', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_CODGRU', False));
  FListInfoColunaDadosContabeis.Add(TCriaColunaDadosContabeis.fColuna('CON_ORICPC', False));
end;

function TImportacaoDadosContabeisParCon.fLookupNatCfo(const AstrDescri: string): string;
var
  qryLookup: TUniQuery;
begin
  Result := '';
  if Trim(AstrDescri) = '' then
    Exit;

  qryLookup := fCriaQuery(nil);
  try
    qryLookup.SQL.Text := 'SELECT AUTOINCREM FROM NATCFO WHERE UPPER(TRIM(NAT_DESCRI)) = :DESCRI LIMIT 1';
    qryLookup.ParamByName('DESCRI').AsString := AnsiUpperCase(Trim(AstrDescri));
    qryLookup.Open;
    if not qryLookup.IsEmpty then
      Result := qryLookup.FieldByName('AUTOINCREM').AsString;
  finally
    qryLookup.Free;
  end;
end;

function TImportacaoDadosContabeisParCon.fResolveCodemp: string;
begin
  if FCfgContabil.fCfgSisBoolean('CONEMP') then
    Result := VS_strCodEmp
  else
    Result := '';
end;

function TImportacaoDadosContabeisParCon.fConverteEstruturaParaValidacao(
  const AArr: array of TParConInfo): TList<TDadosValidacaoParCon>;
var
  intCnt: Integer;
  regItem: TDadosValidacaoParCon;
begin
  Result := TList<TDadosValidacaoParCon>.Create;
  for intCnt := Low(AArr) to High(AArr) do
  begin
    FillChar(regItem, SizeOf(regItem), #0);
    regItem.ASeqPar := AArr[intCnt].strCON_SEQPAR;
    regItem.ACodemp := AArr[intCnt].strCON_CODEMP;
    Result.Add(regItem);
  end;
end;

procedure TImportacaoDadosContabeisParCon.pCarregaCmpPar;
var
  LFonteCmpPar: IImportacaoDadosContabeisFonte;
  LintLinha, LintQtdLinhas, LintUltimo: Integer;
  LstrSeqParRef: string;
begin
  if not Assigned(FFontesComplementares) then
    Exit;

  if not FFontesComplementares.TryGetValue('CMPPAR', LFonteCmpPar) then
    Exit;

  LintQtdLinhas := LFonteCmpPar.fQntLinhas;
  for LintLinha := 0 to LintQtdLinhas - 1 do
  begin
    LstrSeqParRef := LFonteCmpPar.fGetDadosCelula(0, LintLinha, LstrSeqParRef);

    SetLength(FarrCmpPar, Length(FarrCmpPar) + 1);
    LintUltimo := High(FarrCmpPar);

    FarrCmpPar[LintUltimo].strPAR_SEQPAR := LstrSeqParRef;
    FarrCmpPar[LintUltimo].strPAR_COMPLE := LFonteCmpPar.fGetDadosCelula(1, LintLinha, LstrSeqParRef);
  end;
end;

procedure TImportacaoDadosContabeisParCon.pCarregaParNco;
var
  LFonteParNco: IImportacaoDadosContabeisFonte;
  LintLinha, LintQtdLinhas, LintUltimo: Integer;
  LstrSeqParRef: string;
begin
  if not Assigned(FFontesComplementares) then
    Exit;

  if not FFontesComplementares.TryGetValue('PARNCO', LFonteParNco) then
    Exit;

  LintQtdLinhas := LFonteParNco.fQntLinhas;
  for LintLinha := 0 to LintQtdLinhas - 1 do
  begin
    LstrSeqParRef := LFonteParNco.fGetDadosCelula(0, LintLinha, LstrSeqParRef);

    SetLength(FarrParNco, Length(FarrParNco) + 1);
    LintUltimo := High(FarrParNco);

    FarrParNco[LintUltimo].strCON_SEQPAR := LstrSeqParRef;
    FarrParNco[LintUltimo].strNCO_CODEMP := LFonteParNco.fGetDadosCelula(1, LintLinha, LstrSeqParRef);
    FarrParNco[LintUltimo].strNCO_CREDEB := LFonteParNco.fGetDadosCelula(2, LintLinha, LstrSeqParRef);
    FarrParNco[LintUltimo].strNCO_CODCON := LFonteParNco.fGetDadosCelula(3, LintLinha, LstrSeqParRef);
  end;
end;

function TImportacaoDadosContabeisParCon.fGetSqlInsert: string;
begin
  Result := 'INSERT INTO PARCON ('
    + 'CON_SEQPAR, CON_TIPLAN, CON_FORPGO, CON_NATOPE, CON_DESVAL, '
    + 'CON_CLAFIS, CON_CONCRE, CON_CFCRED, CON_PORCRE, CON_HISCRE, '
    + 'CON_CONDEB, CON_CFDEBI, CON_PORDEB, CON_PCCRED, CON_PCDEBI, '
    + 'CON_NATCFO, CON_MD5CLA, CON_PAGAME, CON_ORIGEM, CON_TIPPCD, '
    + 'CON_TIPPCC, CON_BANDEB, CON_BANCRE, CON_ABFDEB, CON_ABFCRE, '
    + 'CON_PAGANT, CON_TITPDD, CON_CODTRI, CON_CODORI, CON_VIGINI, '
    + 'CON_VIGFIN, CON_CODGRU, CON_ORICPC, CON_CODEMP'
    + ') VALUES ('
    + ':SEQPAR, :TIPLAN, :FORPGO, :NATOPE, :DESVAL, '
    + ':CLAFIS, :CONCRE, :CFCRED, :PORCRE, :HISCRE, '
    + ':CONDEB, :CFDEBI, :PORDEB, :PCCRED, :PCDEBI, '
    + ':NATCFO, :MD5CLA, :PAGAME, :ORIGEM, :TIPPCD, '
    + ':TIPPCC, :BANDEB, :BANCRE, :ABFDEB, :ABFCRE, '
    + ':PAGANT, :TITPDD, :CODTRI, :CODORI, :VIGINI, '
    + ':VIGFIN, :CODGRU, :ORICPC, :CODEMP'
    + ')';
end;

function TImportacaoDadosContabeisParCon.fGetSqlInsertCmpPar: string;
begin
  Result := 'INSERT INTO CMPPAR ('
    + 'PAR_SEQPAR, PAR_MD5KEY, PAR_COMPLE'
    + ') VALUES ('
    + ':SEQPAR, :MD5KEY, :COMPLE'
    + ')';
end;

function TImportacaoDadosContabeisParCon.fGetSqlInsertParNco: string;
begin
  Result := 'INSERT INTO PARNCO ('
    + 'NCO_CODEMP, NCO_CREDEB, NCO_MD5KEY, CON_SEQPAR, NCO_CODCON'
    + ') VALUES ('
    + ':CODEMP, :CREDEB, :MD5KEY, :SEQPAR, :CODCON'
    + ')';
end;

function TImportacaoDadosContabeisParCon.fCarregaDadosPlanilha(
  const AprocErros: TErroContabilProc): boolean;
var
  intConLin: Integer;
  intUltimo: Integer;
  intQtdLinhas: Integer;
  LDadosValidacao: TList<TDadosValidacaoParCon>;
begin
  pSetaTextoProgresso(pgbProgresso, 'Lendo dados: Parâmetros de Contabilização');
  Result := False;

  if not fValidaCabecalho then
    Exit;

  if not fQtdLinhas(intQtdLinhas) then
    Exit;

  pgbProgresso.Properties.Max := intQtdLinhas - 1;
  SetLength(FarrParCon, 0);
  SetLength(FarrCmpPar, 0);
  SetLength(FarrParNco, 0);

  for intConLin := fIndicePrimeiroRegistro to intQtdLinhas - 1 do
  begin
    pgbProgresso.Position := intConLin;
    Application.ProcessMessages;

    SetLength(FarrParCon, Length(FarrParCon) + 1);
    intUltimo := High(FarrParCon);

    FarrParCon[intUltimo].strCON_SEQPAR := fGetDadosCelula( 0, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_TIPLAN := fGetDadosCelula( 1, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_FORPGO := fGetDadosCelula( 2, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_NATOPE := fGetDadosCelula( 3, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_DESVAL := fGetDadosCelula( 4, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_CLAFIS := fGetDadosCelula( 5, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_CONCRE := fGetDadosCelula( 6, intConLin, tdcStr, False);
    FarrParCon[intUltimo].intCON_CFCRED := fGetDadosCelula( 7, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_PORCRE := fGetDadosCelula( 8, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_HISCRE := fGetDadosCelula( 9, intConLin, tdcInt);
    FarrParCon[intUltimo].strCON_CONDEB := fGetDadosCelula(10, intConLin, tdcStr, False);
    FarrParCon[intUltimo].intCON_CFDEBI := fGetDadosCelula(11, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_PORDEB := fGetDadosCelula(12, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_PCCRED := fGetDadosCelula(13, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_PCDEBI := fGetDadosCelula(14, intConLin, tdcInt);
    FarrParCon[intUltimo].strCON_NATCFO := fGetDadosCelula(15, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_PAGAME := fGetDadosCelula(16, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_ORIGEM := fGetDadosCelula(17, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_TIPPCD := fGetDadosCelula(18, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_TIPPCC := fGetDadosCelula(19, intConLin, tdcStr, False);
    FarrParCon[intUltimo].intCON_BANDEB := fGetDadosCelula(20, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_BANCRE := fGetDadosCelula(21, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_ABFDEB := fGetDadosCelula(22, intConLin, tdcInt);
    FarrParCon[intUltimo].intCON_ABFCRE := fGetDadosCelula(23, intConLin, tdcInt);
    FarrParCon[intUltimo].strCON_PAGANT := fGetDadosCelula(24, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_TITPDD := fGetDadosCelula(25, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_CODTRI := fGetDadosCelula(26, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_CODORI := fGetDadosCelula(27, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_VIGINI := fGetDadosCelula(28, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_VIGFIN := fGetDadosCelula(29, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_CODGRU := fGetDadosCelula(30, intConLin, tdcStr, False);
    FarrParCon[intUltimo].strCON_ORICPC := fGetDadosCelula(31, intConLin, tdcStr, False);

    // Resolve CON_CODEMP via repositorio de configuracoes
    FarrParCon[intUltimo].strCON_CODEMP := fResolveCodemp;

    // Resolve NATCFO: lookup pela descricao
    FarrParCon[intUltimo].strCON_NATCFO_AUTOINCREM := fLookupNatCfo(FarrParCon[intUltimo].strCON_NATCFO);
  end;

  pCarregaCmpPar;
  pCarregaParNco;

  if not FblnIgnorarErrosImportacao then
  begin
    if FMensagemErroDadosContabeis.fTemMensagemErro then
    begin
      if not FblnImportacaoOrquestrada then
        FMensagemErroDadosContabeis.pMostraMensagemErro(True);
      Exit;
    end;
  end;

  ///valida as informacoes carregadas no array
  LDadosValidacao := fConverteEstruturaParaValidacao(FarrParCon);
  try
    if not TValidaProcessoParCon.fValidaParConBloco(LDadosValidacao, AprocErros) then
    begin
      Exit;
    end;
  finally
    FreeAndNil(LDadosValidacao);
  end;

  Result := True;
end;

function TImportacaoDadosContabeisParCon.fPersisteDados: boolean;
var
  intCnt: Integer;
  LintHiscrePersistir: Integer;
  LintHiscreMapeado: Integer;
  strSeqParOriginal: string;
  strSeqParNovo: string;
  strMd5: string;
  strMensagemErro: string;
  blnAbortado: Boolean;
  intLin: Integer;
  regMapInfo: TParConMapInfo;
begin
  Result := False;
  blnAbortado := False;
  pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Parâmetros de Contabilização');
  pgbProgresso.Properties.Max := Length(FarrParCon);

  pStartTransactionImportacao;

  try
    FqryExec.Close;
    FqryExec.SQL.Text := fGetSqlInsert;

    for intCnt := Low(FarrParCon) to High(FarrParCon) do
    begin
      try
        pgbProgresso.Position := intCnt + 1;
        Application.ProcessMessages;

        if not FMensagemErroDadosContabeis.fTemLinhaComErro(intCnt) then
        begin
          strSeqParOriginal := FarrParCon[intCnt].strCON_SEQPAR;
          strSeqParNovo := fAtualizaProCod('PARCON', 'CON_SEQPAR');

          // Recalcula MD5 com o novo SEQPAR (demais campos ja resolvidos no carregamento)
          strMd5 := THashParCon.New(
            FarrParCon[intCnt].strCON_DESVAL,
            FarrParCon[intCnt].strCON_FORPGO,
            FarrParCon[intCnt].strCON_NATOPE,
            FarrParCon[intCnt].strCON_TIPLAN,
            FarrParCon[intCnt].strCON_NATCFO_AUTOINCREM,
            strSeqParNovo,
            FarrParCon[intCnt].strCON_VIGINI,
            FarrParCon[intCnt].strCON_VIGFIN
          ).getHash;

          regMapInfo.strSeqPar := strSeqParNovo;
          regMapInfo.strMd5Key := strMd5;
          FdctParConMap.Add(strSeqParOriginal, regMapInfo);

          FqryExec.ParamByName('SEQPAR').AsString := strSeqParNovo;
          FqryExec.ParamByName('TIPLAN').AsString := FarrParCon[intCnt].strCON_TIPLAN;
          FqryExec.ParamByName('FORPGO').AsString := FarrParCon[intCnt].strCON_FORPGO;
          FqryExec.ParamByName('NATOPE').AsString := FarrParCon[intCnt].strCON_NATOPE;
          FqryExec.ParamByName('DESVAL').AsString := FarrParCon[intCnt].strCON_DESVAL;
          FqryExec.ParamByName('CLAFIS').AsString := FarrParCon[intCnt].strCON_CLAFIS;
          FqryExec.ParamByName('CONCRE').AsString := FarrParCon[intCnt].strCON_CONCRE;
          FqryExec.ParamByName('CFCRED').AsInteger := FarrParCon[intCnt].intCON_CFCRED;
          FqryExec.ParamByName('PORCRE').AsInteger := FarrParCon[intCnt].intCON_PORCRE;
          LintHiscrePersistir := FarrParCon[intCnt].intCON_HISCRE;
          if Assigned(FMapaCodigosHispad) and (LintHiscrePersistir <> 0) then
          begin
            if not FMapaCodigosHispad.TryGetValue(LintHiscrePersistir, LintHiscreMapeado) then
              raise Exception.CreateFmt(
                'Não foi encontrado mapeamento do histórico padrão para CON_HISCRE=%d na linha %d da PARCON.',
                [LintHiscrePersistir, intCnt + 2]
              );
            LintHiscrePersistir := LintHiscreMapeado;
          end;
          FqryExec.ParamByName('HISCRE').AsInteger := LintHiscrePersistir;
          FqryExec.ParamByName('CONDEB').AsString := FarrParCon[intCnt].strCON_CONDEB;
          FqryExec.ParamByName('CFDEBI').AsInteger := FarrParCon[intCnt].intCON_CFDEBI;
          FqryExec.ParamByName('PORDEB').AsInteger := FarrParCon[intCnt].intCON_PORDEB;
          FqryExec.ParamByName('PCCRED').AsInteger := FarrParCon[intCnt].intCON_PCCRED;
          FqryExec.ParamByName('PCDEBI').AsInteger := FarrParCon[intCnt].intCON_PCDEBI;

          if FarrParCon[intCnt].strCON_NATCFO_AUTOINCREM <> '' then
            FqryExec.ParamByName('NATCFO').AsString := FarrParCon[intCnt].strCON_NATCFO_AUTOINCREM
          else
            FqryExec.ParamByName('NATCFO').Clear;

          FqryExec.ParamByName('MD5CLA').AsString := strMd5;
          FqryExec.ParamByName('PAGAME').AsString := FarrParCon[intCnt].strCON_PAGAME;
          FqryExec.ParamByName('ORIGEM').AsString := FarrParCon[intCnt].strCON_ORIGEM;
          FqryExec.ParamByName('TIPPCD').AsString := FarrParCon[intCnt].strCON_TIPPCD;
          FqryExec.ParamByName('TIPPCC').AsString := FarrParCon[intCnt].strCON_TIPPCC;
          FqryExec.ParamByName('BANDEB').AsInteger := FarrParCon[intCnt].intCON_BANDEB;
          FqryExec.ParamByName('BANCRE').AsInteger := FarrParCon[intCnt].intCON_BANCRE;
          FqryExec.ParamByName('ABFDEB').AsInteger := FarrParCon[intCnt].intCON_ABFDEB;
          FqryExec.ParamByName('ABFCRE').AsInteger := FarrParCon[intCnt].intCON_ABFCRE;
          FqryExec.ParamByName('PAGANT').AsString := FarrParCon[intCnt].strCON_PAGANT;
          FqryExec.ParamByName('TITPDD').AsString := FarrParCon[intCnt].strCON_TITPDD;
          FqryExec.ParamByName('CODTRI').AsString := FarrParCon[intCnt].strCON_CODTRI;
          FqryExec.ParamByName('CODORI').AsString := FarrParCon[intCnt].strCON_CODORI;

          if Trim(FarrParCon[intCnt].strCON_VIGINI) <> '' then
            FqryExec.ParamByName('VIGINI').AsString := FarrParCon[intCnt].strCON_VIGINI
          else
            FqryExec.ParamByName('VIGINI').Clear;

          if Trim(FarrParCon[intCnt].strCON_VIGFIN) <> '' then
            FqryExec.ParamByName('VIGFIN').AsString := FarrParCon[intCnt].strCON_VIGFIN
          else
            FqryExec.ParamByName('VIGFIN').Clear;

          FqryExec.ParamByName('CODGRU').AsString := FarrParCon[intCnt].strCON_CODGRU;
          FqryExec.ParamByName('ORICPC').AsString := FarrParCon[intCnt].strCON_ORICPC;

          if FarrParCon[intCnt].strCON_CODEMP <> '' then
            FqryExec.ParamByName('CODEMP').AsString := FarrParCon[intCnt].strCON_CODEMP
          else
            FqryExec.ParamByName('CODEMP').Clear;

          FqryExec.ExecSQL;
        end;
      except
        on E1: Exception do
        begin
          strMensagemErro := 'Problemas ao importar PARCON linha ' + IntToStr(intCnt + 2) + ', erro: ' + E1.Message;
          if not FblnIgnorarErrosImportacao then
          begin
            blnAbortado := True;
            raise Exception.Create(strMensagemErro);
          end
          else
            FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro);
        end;
      end;
    end;

    // -- CMPPAR --
    if Length(FarrCmpPar) > 0 then
    begin
      pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Complementos (CMPPAR)');
      pgbProgresso.Properties.Max := Length(FarrCmpPar);
      FqryExec.SQL.Text := fGetSqlInsertCmpPar;

      for intLin := Low(FarrCmpPar) to High(FarrCmpPar) do
      begin
        try
          pgbProgresso.Position := intLin + 1;
          Application.ProcessMessages;

          if FdctParConMap.ContainsKey(FarrCmpPar[intLin].strPAR_SEQPAR) then
          begin
            FqryExec.ParamByName('SEQPAR').AsString := FdctParConMap[FarrCmpPar[intLin].strPAR_SEQPAR].strSeqPar;
            FqryExec.ParamByName('MD5KEY').AsString := FdctParConMap[FarrCmpPar[intLin].strPAR_SEQPAR].strMd5Key;
            FqryExec.ParamByName('COMPLE').AsString := FarrCmpPar[intLin].strPAR_COMPLE;
            FqryExec.ExecSQL;
          end;
        except
          on E1: Exception do
          begin
            strMensagemErro := 'Problemas ao importar CMPPAR linha ' + IntToStr(intLin + 2) + ', erro: ' + E1.Message;
            if not FblnIgnorarErrosImportacao then
            begin
              blnAbortado := True;
              raise Exception.Create(strMensagemErro);
            end
            else
              FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro);
          end;
        end;
      end;
    end;

    // -- PARNCO --
    if Length(FarrParNco) > 0 then
    begin
      pSetaTextoProgresso(pgbProgresso, 'Gravando Registros: Contas Desmembramento (PARNCO)');
      pgbProgresso.Properties.Max := Length(FarrParNco);
      FqryExec.SQL.Text := fGetSqlInsertParNco;

      for intLin := Low(FarrParNco) to High(FarrParNco) do
      begin
        try
          pgbProgresso.Position := intLin + 1;
          Application.ProcessMessages;

          if FdctParConMap.ContainsKey(FarrParNco[intLin].strCON_SEQPAR) then
          begin
            FqryExec.ParamByName('CODEMP').AsString := FarrParNco[intLin].strNCO_CODEMP;
            FqryExec.ParamByName('CREDEB').AsString := FarrParNco[intLin].strNCO_CREDEB;
            FqryExec.ParamByName('MD5KEY').AsString := FdctParConMap[FarrParNco[intLin].strCON_SEQPAR].strMd5Key;
            FqryExec.ParamByName('SEQPAR').AsString := FdctParConMap[FarrParNco[intLin].strCON_SEQPAR].strSeqPar;
            FqryExec.ParamByName('CODCON').AsString := FarrParNco[intLin].strNCO_CODCON;
            FqryExec.ExecSQL;
          end;
        except
          on E1: Exception do
          begin
            strMensagemErro := 'Problemas ao importar PARNCO linha ' + IntToStr(intLin + 2) + ', erro: ' + E1.Message;
            if not FblnIgnorarErrosImportacao then
            begin
              blnAbortado := True;
              raise Exception.Create(strMensagemErro);
            end
            else
              FMensagemErroDadosContabeis.pRegistraMensagemErro(strMensagemErro);
          end;
        end;
      end;
    end;

    pCommitImportacao;

  except
    on E2: Exception do
    begin
      pRollbackImportacao;
      FMensagemErroDadosContabeis.pRegistraMensagemErro(E2.Message);
      if FblnImportacaoOrquestrada then
        Raise;
    end;
  end;

  if FMensagemErroDadosContabeis.fTemMensagemErro then
  begin
    // Na persistencia, forcar exibicao mesmo quando orquestrado:
    // um erro aqui aborta toda a sequencia, nao ha acumulo de janelas
    FMensagemErroDadosContabeis.pMostraMensagemErro(blnAbortado, FblnImportacaoOrquestrada);
    Exit;
  end;

  pMensagemSucesso;
  Result := True;
end;

end.
