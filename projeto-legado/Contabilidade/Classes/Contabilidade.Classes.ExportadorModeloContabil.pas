unit Contabilidade.Classes.ExportadorModeloContabil;

interface

uses
  System.SysUtils, System.Classes,
  Uni,
  cxProgressBar,
  Contabilidade.Classes.ImportacaoModeloContabil,
  Contabilidade.Classes.ImportacaoModeloContabilWriter,
  Contabilidade.Classes.TImportacaoDadosContabeis,
  Contabilidade.Classes.TValidaProcessoCfgSis;

type
  TExportadorModeloContabil = class
  private
    function fCriaQueryExport(const AstrSql: string): TUniQuery;
    function fMontaExclusoesBlacklistSQL: string;
    procedure pInicializaProgresso(ApgbProgresso: TcxProgressBar);
    procedure pInformarEtapa(ApgbProgresso: TcxProgressBar; const AstrMensagem: string);
    procedure pAvancaProgresso(ApgbProgresso: TcxProgressBar; AintPosicao: Integer);

    procedure pExportarCfgSis(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
    procedure pExportarHispad(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
    procedure pExportarPlanco(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
    procedure pExportarParCon(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
    procedure pExportarCmpPar(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
    procedure pExportarParNco(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
  public
    procedure pExportar(const AstrCaminho: string; ApgbProgresso: TcxProgressBar = nil);
    procedure pExportarStream(AStream: TStream; ApgbProgresso: TcxProgressBar = nil);
  end;

implementation

uses
  untFuncoesSimples,
  untGravando,
  Contabilidade.Funcoes,
  Contabilidade.Classes.TImportacaoDadosContabeisFonteDataset;

{ TExportadorModeloContabil }

function TExportadorModeloContabil.fCriaQueryExport(const AstrSql: string): TUniQuery;
begin
  Result := fCriaQuery(nil);
  Result.SQL.Text := AstrSql;
end;

function TExportadorModeloContabil.fMontaExclusoesBlacklistSQL: string;
var
  LintI: Integer;
  LstrLista: string;
begin
  LstrLista := '';

  for LintI := Low(CFGSIS_BLACKLIST) to High(CFGSIS_BLACKLIST) do
  begin
    if LstrLista <> '' then
      LstrLista := LstrLista + ', ';
    LstrLista := LstrLista + QuotedStr('CFG_' + CFGSIS_BLACKLIST[LintI]);
  end;

  for LintI := Low(CFGSIS_GERENCIADAS_PELA_UI) to High(CFGSIS_GERENCIADAS_PELA_UI) do
  begin
    if LstrLista <> '' then
      LstrLista := LstrLista + ', ';
    LstrLista := LstrLista + QuotedStr('CFG_' + CFGSIS_GERENCIADAS_PELA_UI[LintI]);
  end;

  if LstrLista <> '' then
    Result := ' AND UPPER(SIS_CODCFG) NOT IN (' + LstrLista + ')'
  else
    Result := '';
end;

procedure TExportadorModeloContabil.pInicializaProgresso(ApgbProgresso: TcxProgressBar);
begin
  if not Assigned(ApgbProgresso) then
    Exit;
  pInformacao('Preparando exportação do modelo contábil...', ApgbProgresso);
  pProgresso(0, 6, ApgbProgresso);
end;

procedure TExportadorModeloContabil.pInformarEtapa(ApgbProgresso: TcxProgressBar; const AstrMensagem: string);
begin
  if not Assigned(ApgbProgresso) then
    Exit;
  pInformacao(AstrMensagem, ApgbProgresso);
end;

procedure TExportadorModeloContabil.pAvancaProgresso(ApgbProgresso: TcxProgressBar; AintPosicao: Integer);
begin
  if not Assigned(ApgbProgresso) then
    Exit;
  pProgresso(AintPosicao, 6, ApgbProgresso);
end;

procedure TExportadorModeloContabil.pExportarCfgSis(AWriter: TImportacaoModeloContabilWriter;
  ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando Configurações do sistema...');

  LstrSql :=
    'SELECT ' +
    '  REPLACE(UPPER(SIS_CODCFG), ''CFG_'', '''') AS SIS_CODCFG, ' +
    '  SIS_VALCFG ' +
    'FROM CFGSIS ' +
    'WHERE SIS_CODEMP = :CODEMP ' +
    '  AND UPPER(SIS_GRUCFG) = ''CONTABILIDADE''' +
    fMontaExclusoesBlacklistSQL +
    ' ORDER BY SIS_CODCFG';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.ParamByName('CODEMP').AsString := VS_strCodEmp;
  Lqry.Open;

  AWriter.pAdicionarTabela(DES_IMPORTACAODADOSCONTABEIS[tidcConfiguracoes], TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportarHispad(AWriter: TImportacaoModeloContabilWriter;
  ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando Histórico padrão...');

  LstrSql := 'SELECT PAD_CODIGO, PAD_DESCRI FROM HISPAD WHERE TRUE ';
  if fCfgHisTpl then
    LstrSql := LstrSql + ' AND PAD_TPLACO = ' + fRetTplacoEmpresaLogada.QuotedString
  else
    LstrSql := LstrSql + ' AND IFNULL(PAD_TPLACO, "") = "" ';
  LstrSql := LstrSql + ' ORDER BY PAD_CODIGO';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.Open;

  AWriter.pAdicionarTabela(DES_IMPORTACAODADOSCONTABEIS[tidcHistoricoPadrao], TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportarPlanco(AWriter: TImportacaoModeloContabilWriter;
  ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando Plano de contas...');

  LstrSql :=
    'SELECT ' +
    '  NCO_CODCON, NCO_DESCRI, NCO_CONRED, NCO_TPLACO, NCO_APURAC, ' +
    '  NCO_NATURE, NCO_FINALI, NCO_CTAREF, NCO_REDUTO, NCO_PATRIM ' +
    'FROM PLANCO ' +
    'WHERE NCO_TPLACO = :TPLACO ' +
    'ORDER BY NCO_CODCON';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.ParamByName('TPLACO').AsString := fRetTplacoEmpresaLogada;
  Lqry.Open;

  AWriter.pAdicionarTabela(DES_IMPORTACAODADOSCONTABEIS[tidcPlanoContas], TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportarParCon(AWriter: TImportacaoModeloContabilWriter;
  ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando Parâmetros de contabilização...');

  LstrSql :=
    'SELECT ' +
    '  CON_SEQPAR, CON_TIPLAN, CON_FORPGO, CON_NATOPE, CON_DESVAL, ' +
    '  CON_CLAFIS, CON_CONCRE, CON_CFCRED, CON_PORCRE, CON_HISCRE, ' +
    '  CON_CONDEB, CON_CFDEBI, CON_PORDEB, CON_PCCRED, CON_PCDEBI, ' +
    '  CON_NATCFO, CON_PAGAME, CON_ORIGEM, CON_TIPPCD, CON_TIPPCC, ' +
    '  CON_BANDEB, CON_BANCRE, CON_ABFDEB, CON_ABFCRE, CON_PAGANT, ' +
    '  CON_TITPDD, CON_CODTRI, CON_CODORI, CON_VIGINI, CON_VIGFIN, ' +
    '  CON_CODGRU, CON_ORICPC ' +
    'FROM PARCON ' +
    'WHERE TRUE ';

  if fCfgConEmp = 'S' then
    LstrSql := LstrSql + ' AND IFNULL(CON_CODEMP, "") = ' + VS_strCodEmp.QuotedString
  else
    LstrSql := LstrSql + ' AND IFNULL(CON_CODEMP, "") = ""';

  LstrSql := LstrSql + ' ORDER BY CON_SEQPAR';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.Open;

  AWriter.pAdicionarTabela(DES_IMPORTACAODADOSCONTABEIS[tidcParametrosContabilizacao], TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportarCmpPar(AWriter: TImportacaoModeloContabilWriter;
  ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando complementos de contabilização (CMPPAR)...');

  // col 0=PAR_SEQPAR, col 1=PAR_COMPLE
  // PAR_MD5KEY nao e exportado: o importador recalcula o MD5 via FdctParConMap
  LstrSql :=
    'SELECT CP.PAR_SEQPAR, CP.PAR_COMPLE ' +
    'FROM CMPPAR CP ' +
    'INNER JOIN PARCON PC ON PC.CON_SEQPAR = CP.PAR_SEQPAR ' +
    'WHERE TRUE ';

  if fCfgConEmp = 'S' then
    LstrSql := LstrSql + ' AND IFNULL(PC.CON_CODEMP, "") = ' + VS_strCodEmp.QuotedString
  else
    LstrSql := LstrSql + ' AND IFNULL(PC.CON_CODEMP, "") = ""';

  LstrSql := LstrSql + ' ORDER BY CP.PAR_SEQPAR';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.Open;

  AWriter.pAdicionarTabela('CMPPAR', TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportarParNco(AWriter: TImportacaoModeloContabilWriter; ApgbProgresso: TcxProgressBar);
var
  Lqry: TUniQuery;
  LstrSql: string;
begin
  pInformarEtapa(ApgbProgresso, 'Exportando contas contábeis por parâmetro (PARNCO)...');

  // col 0=CON_SEQPAR, col 1=NCO_CODEMP, col 2=NCO_CREDEB, col 3=NCO_CODCON
  // NCO_MD5KEY nao e exportado: o importador recalcula o MD5 via FdctParConMap
  LstrSql :=
    'SELECT PN.CON_SEQPAR, PN.NCO_CODEMP, PN.NCO_CREDEB, PN.NCO_CODCON ' +
    'FROM PARNCO PN ' +
    'INNER JOIN PARCON PC ON PC.CON_SEQPAR = PN.CON_SEQPAR ' +
    'WHERE TRUE ';

  if fCfgConEmp = 'S' then
    LstrSql := LstrSql + ' AND IFNULL(PC.CON_CODEMP, "") = ' + VS_strCodEmp.QuotedString
  else
    LstrSql := LstrSql + ' AND IFNULL(PC.CON_CODEMP, "") = ""';

  LstrSql := LstrSql + ' ORDER BY PN.CON_SEQPAR, PN.NCO_CREDEB';

  Lqry := fCriaQueryExport(LstrSql);
  Lqry.Open;

  AWriter.pAdicionarTabela('PARNCO', TImportacaoDadosContabeisFonteDataSet.New(Lqry, True));
end;

procedure TExportadorModeloContabil.pExportar(const AstrCaminho: string; ApgbProgresso: TcxProgressBar = nil);
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(AstrCaminho, fmCreate);
  try
    pExportarStream(LStream, ApgbProgresso);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TExportadorModeloContabil.pExportarStream(AStream: TStream; ApgbProgresso: TcxProgressBar = nil);
// Ciclo de vida das queries: cada pExportar* cria a query com OwnsDataSet=True.
// A TImportacaoDadosContabeisFonteDataSet assume ownership e destroi a query
// quando o writer liberar as fontes no FreeAndNil(LWriter).
var
  LWriter: TImportacaoModeloContabilWriter;
begin
  LWriter := TImportacaoModeloContabilWriter.Create;
  try
    pInicializaProgresso(ApgbProgresso);

    pExportarCfgSis(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 1);

    pExportarHispad(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 2);

    pExportarPlanco(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 3);

    pExportarParCon(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 4);

    pExportarCmpPar(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 5);

    pExportarParNco(LWriter, ApgbProgresso);
    pAvancaProgresso(ApgbProgresso, 6);

    pInformarEtapa(ApgbProgresso, 'Gravando arquivo de exportação...');
    LWriter.pSalvarStream(AStream);
  finally
    FreeAndNil(LWriter); // libera o writer e todas as fontes (que destroem as queries)
  end;
end;

end.