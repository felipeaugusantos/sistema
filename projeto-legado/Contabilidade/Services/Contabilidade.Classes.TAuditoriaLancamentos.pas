unit Contabilidade.Classes.TAuditoriaLancamentos;

interface

uses
  Uni, UniClientDataSet, Contabilidade.Interfaces.TAuditoriaLancamentos,
  Data.DB, System.Generics.Collections, Contabilidade.Interfaces;

type
  TAuditoriaLancamentosService = class(TInterfacedObject, IAuditoriaLancamentosService)
  private
    function fMySqlTipoParaFieldType(const ADataType: string): TFieldType;
    function fCarregarMetadataColunas(const ATabela: string): TMapaColunas;
    function fTryConverterFloat(const ATexto: string; out AValor: Double): Boolean;
    function fTryConverterData(const ATexto: string; out AValor: TDateTime): Boolean;
    function fEhValorNulo(const ATexto: string): Boolean;
    procedure pAtribuirValorTipado(ACds: TUniClientDataSet;
      const AColuna: string; const ATexto: string);
    function fRetornaSqlLancon(const AFiltros: TArrayFiltrosLog;
      const ATipo: TPesquisaLancamentoContabil): String;
    function fRetornaSqlParcon(): String;
    function fRetornaSqlParNco(): String;
    function fRetornaSqlPorNco(): String;
    function fRetornaSqlCliNco(): String;
    function fRetornaSqlForNco(): String;
    function fRetornaSqlBanNco(): String;
    function fRetornaSqlCtaNco(): String;
    function fRetornaSqlCmpPar(): String;
    function fRetornaAutoIncLancon(
      const AIncDoc, AAutoIncLancon: string): TValoresArray;
    function fRetornaAutoIncParnco(const ASeqPar: String): TValoresArray;
    function fRetornaCodigoPornco(const ACodigo: String): TValoresArray;
    function fRetornaCodigoClinco(const ACodigo: String): TValoresArray;
    function fRetornaCodigoFornco(const ACodigo: String): TValoresArray;
    function fRetornaCodigoBannco(const ACodigo: String): TValoresArray;
    function fRetornaCodigoCtanco(const ACodigo: String): TValoresArray;
    function fRetornaAutoIncCmpPar(const ASeqPar: String): TValoresArray;
    function fCarregarLogPivotado(const ATabela: string;
      const AFiltros: TArrayFiltrosLog): TUniClientDataSet;
  public
    function fCarregarRegistrosAtuaisLancon(
      const AFiltros: TArrayFiltrosLog;
      const ATipo: TPesquisaLancamentoContabil): TUniQuery;
    function fCarregarLancamentosAlteradosLancon(
      const AAutoInc, AIncDoc: string): TUniClientDataSet;
    function fCarregarRegistroAtualParcon(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosParcon(
      const ASeqPar: String): TUniClientDataSet;
    function fCarregarRegistroAtualParNco(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosParNco(
      const ASeqPar: String): TUniClientDataSet;
    function fCarregarRegistroAtualPorNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosPorNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualCliNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosCliNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualForNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosForNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualBanNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosBanNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualCtaNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosCtaNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualCmpPar(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosCmpPar(
      const ASeqPar: String): TUniClientDataSet;
    class function New: IAuditoriaLancamentosService;
  end;

implementation

uses
  Classes, untFuncoesSimples, System.SysUtils, System.StrUtils, System.Math,
  Contabilidade.Util.FiltrosLogBuilder, Variants, System.SyncObjs;

var
  GCacheMetadataColunas: TDictionary<string, TMapaColunas>;
  GCacheLockMetadata: TCriticalSection;

{ TAuditoriaLancamentosService }

function TAuditoriaLancamentosService.fCarregarRegistrosAtuaisLancon(
  const AFiltros: TArrayFiltrosLog;
  const ATipo: TPesquisaLancamentoContabil): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlLancon(AFiltros, ATipo);
    TFiltroLogBuilder.pAplicarParametros(Result, AFiltros);
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarLancamentosAlteradosLancon(
  const AAutoInc, AIncDoc: string): TUniClientDataSet;
var
  AIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  AIncs := fRetornaAutoIncLancon(AIncDoc, AAutoInc);
  if Length(AIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', AIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('LANCON', LFiltros);
  LConsultaLogs.First;
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarLogPivotado(
  const ATabela: string;
  const AFiltros: TArrayFiltrosLog): TUniClientDataSet;
const
  CTipoInc    = 'INC';
  CTipoAlt    = 'ALT';
  CTipoExc    = 'EXC';
  CTipoAltAnt = 'ALT-ANT';
  CTipoAltAtu = 'ALT-ATU';

  CColunasPermitidas: array[0..7] of string = (
    'LOG_CODEMP', 'LOG_INCDOC', 'LOG_DTAALT', 'LOG_CODOPE',
    'LOG_TIPAJU', 'LOG_COLUNA', 'LOG_SEQAJU', 'LOG_NOMFRM'
  );
var
  LqryLog: TUniQuery;
  LcdsResultado: TUniClientDataSet;
  LColunasDist: TStringList;
  LMapaColunas: TMapaColunas;
  LInfo: TInfoColuna;
  LWhereExtra: string;
  LColunaLogUp, LTipAju, LValAnt, LValAtu: string;
  LIncDocCorrente, LSeqAjuCorrente: string;
  LChaveAtual, LChaveCorrente: string;
  LCnt: Integer;

  function fColunaPermitida(const ANome: string): Boolean;
  var
    LCnt2: Integer;
  begin
    Result := False;
    for LCnt2 := Low(CColunasPermitidas) to High(CColunasPermitidas) do
      if SameText(ANome, CColunasPermitidas[LCnt2]) then
        Exit(True);
  end;

  procedure pAplicarFiltros(AQry: TUniQuery);
  begin
    AQry.ParamByName('TABELA').AsString := ATabela;
    TFiltroLogBuilder.pAplicarParametros(AQry, AFiltros);
  end;

  procedure pPreencherMetadados(const ATipoExibido: string);
  begin
    LcdsResultado.FieldByName('LOG_CODEMP').AsString   := LqryLog.FieldByName('LOG_CODEMP').AsString;
    LcdsResultado.FieldByName('LOG_DTAALT').AsDateTime := LqryLog.FieldByName('LOG_DTAALT').AsDateTime;
    LcdsResultado.FieldByName('LOG_HRAALT').AsString   := LqryLog.FieldByName('LOG_HRAALT').AsString;
    LcdsResultado.FieldByName('LOG_CODOPE').AsString   := LqryLog.FieldByName('LOG_CODOPE').AsString;
    LcdsResultado.FieldByName('LOG_NOMFRM').AsString   := LqryLog.FieldByName('LOG_NOMFRM').AsString;
    LcdsResultado.FieldByName('LOG_SEQAJU').AsString   := LqryLog.FieldByName('LOG_SEQAJU').AsString;
    LcdsResultado.FieldByName('LOG_INCDOC').AsString   := LqryLog.FieldByName('LOG_INCDOC').AsString;
    LcdsResultado.FieldByName('LOG_TIPAJU').AsString   := ATipoExibido;
  end;

  procedure pAtualizarLinha(const ATipoLinha, AIncDoc, ASeqAju,
    AColuna, AValor: string);
  begin
    if not LcdsResultado.Locate('LOG_TIPAJU;LOG_INCDOC;LOG_SEQAJU',
                                VarArrayOf([ATipoLinha, AIncDoc, ASeqAju]),
                                [loCaseInsensitive]) then
      Exit;
    LcdsResultado.Edit;
    pAtribuirValorTipado(LcdsResultado, AColuna, AValor);
    LcdsResultado.Post;
  end;

begin
  if Trim(ATabela) = '' then
    raise Exception.Create('fCarregarLogPivotado: parametro ATabela e obrigatorio.');

  LcdsResultado := TUniClientDataSet.Create(nil);
  LqryLog       := fCriaQuery(nil);
  LColunasDist  := TStringList.Create;
  LMapaColunas := nil;
  try
    LColunasDist.Sorted := True;
    LColunasDist.Duplicates := dupIgnore;
    try
      LWhereExtra := TFiltroLogBuilder.fMontarWhere(
        'LOGAJC',
        AFiltros,
        CColunasPermitidas);

      if LWhereExtra <> '' then
        LWhereExtra := ' AND ' + LWhereExtra;

      // 1) Descobre LOG_COLUNA distintas para a tabela informada
      LqryLog.SQL.Clear;
      LqryLog.SQL.Add('SELECT DISTINCT LOG_COLUNA  ');
      LqryLog.SQL.Add('  FROM LOGAJC               ');
      LqryLog.SQL.Add(' WHERE LOG_TABELA = :TABELA ' + LWhereExtra);
      pAplicarFiltros(LqryLog);
      LqryLog.Open;
      while not LqryLog.Eof do
      begin
        if Trim(LqryLog.FieldByName('LOG_COLUNA').AsString) <> '' then
          LColunasDist.Add(UpperCase(LqryLog.FieldByName('LOG_COLUNA').AsString));
        LqryLog.Next;
      end;
      LqryLog.Close;

      // 2) Carrega metadata da tabela (tipo + tamanho de cada coluna)
      LMapaColunas := fCarregarMetadataColunas(ATabela);

      // 3) Schema do CDS: metadados fixos + 1 coluna tipada por LOG_COLUNA.
      //    LOG_INCDOC e incluido nos metadados para servir de chave do Locate.
      LcdsResultado.FieldDefs.Clear;
      LcdsResultado.FieldDefs.Add('LOG_CODEMP', ftString, 10, False);
      LcdsResultado.FieldDefs.Add('LOG_DTAALT', ftDate,   0,  False);
      LcdsResultado.FieldDefs.Add('LOG_HRAALT', ftString, 8,  False);
      LcdsResultado.FieldDefs.Add('LOG_CODOPE', ftString, 20, False);
      LcdsResultado.FieldDefs.Add('LOG_TIPAJU', ftString, 10, False);
      LcdsResultado.FieldDefs.Add('LOG_NOMFRM', ftString, 60, False);
      LcdsResultado.FieldDefs.Add('LOG_SEQAJU', ftString, 36, False);
      LcdsResultado.FieldDefs.Add('LOG_INCDOC', ftString, 30, False);

      for LCnt := 0 to LColunasDist.Count - 1 do
      begin
        if LMapaColunas.TryGetValue(LColunasDist[LCnt], LInfo) then
        begin
          if LInfo.Tipo in [ftString, ftMemo] then
            LcdsResultado.FieldDefs.Add(LColunasDist[LCnt], LInfo.Tipo,
              IfThen(LInfo.Tamanho > 0, LInfo.Tamanho, 255), False)
          else
            LcdsResultado.FieldDefs.Add(LColunasDist[LCnt], LInfo.Tipo, 0, False);
        end
        else
          LcdsResultado.FieldDefs.Add(LColunasDist[LCnt], ftString, 4000, False);
      end;

      LcdsResultado.CreateDataSet;
      LcdsResultado.LogChanges := False;

      // Indices:
      //   IDX_CHAVE     — usado durante a montagem para Locate O(log n)
      //   IDX_EXIBICAO  — ordenacao final apresentada ao consumidor
      LcdsResultado.AddIndex('IDX_CHAVE',
                             'LOG_TIPAJU;LOG_INCDOC;LOG_SEQAJU', []);
      LcdsResultado.AddIndex('IDX_EXIBICAO',
                             'LOG_DTAALT;LOG_HRAALT;LOG_TIPAJU', []);
      LcdsResultado.IndexName := 'IDX_CHAVE';

      LcdsResultado.Open;

      // 4) Leitura sequencial ordenada por AUTOINCREM
      LqryLog.SQL.Clear;
      LqryLog.SQL.Add('SELECT AUTOINCREM, LOG_CODEMP, LOG_DTAALT, LOG_HRAALT,  ');
      LqryLog.SQL.Add('       LOG_CODOPE, LOG_TABELA, LOG_INCDOC, LOG_TIPAJU,  ');
      LqryLog.SQL.Add('       LOG_COLUNA, LOG_VALANT, LOG_VALATU, LOG_NOMFRM,  ');
      LqryLog.SQL.Add('       LOG_SEQAJU                                       ');
      LqryLog.SQL.Add('  FROM LOGAJC                                           ');
      LqryLog.SQL.Add(' WHERE LOG_TABELA = :TABELA ' + LWhereExtra);
      LqryLog.SQL.Add(' ORDER BY AUTOINCREM                                    ');
      pAplicarFiltros(LqryLog);
      LqryLog.Open;

      LChaveAtual := '';

      // 5) Pivotacao com chave unificada TIPAJU + INCDOC + SEQAJU
      //    - ALT: par ANT/ATU por chave; cada coluna alimenta ambas as linhas.
      //    - INC: 1 linha por chave; cada coluna recebe LOG_VALATU.
      //    - EXC: 1 linha por chave; cada coluna recebe LOG_VALANT.
      LqryLog.First;
      while not LqryLog.Eof do
      begin
        LColunaLogUp    := UpperCase(LqryLog.FieldByName('LOG_COLUNA').AsString);
        LTipAju         := LqryLog.FieldByName('LOG_TIPAJU').AsString;
        LValAnt         := LqryLog.FieldByName('LOG_VALANT').AsString;
        LValAtu         := LqryLog.FieldByName('LOG_VALATU').AsString;
        LIncDocCorrente := LqryLog.FieldByName('LOG_INCDOC').AsString;
        LSeqAjuCorrente := LqryLog.FieldByName('LOG_SEQAJU').AsString;

        LChaveCorrente := LTipAju+'|'+LIncDocCorrente+'|'+LSeqAjuCorrente;

        // Mudou de chave? cria nova(s) linha(s) de saida.
        if not SameText(LChaveAtual, LChaveCorrente) then
        begin
          if LTipAju = CTipoAlt then
          begin
            // par ANT/ATU
            LcdsResultado.Append;
            pPreencherMetadados(CTipoAltAnt);
            LcdsResultado.Post;

            LcdsResultado.Append;
            pPreencherMetadados(CTipoAltAtu);
            LcdsResultado.Post;
          end
          else
          begin
            // INC ou EXC — linha unica
            LcdsResultado.Append;
            pPreencherMetadados(LTipAju);
            LcdsResultado.Post;
          end;
          LChaveAtual := LChaveCorrente;
        end;

        // Alimenta a coluna corrente nas linha(s) certa(s) via Locate
        if LTipAju = CTipoAlt then
        begin
          pAtualizarLinha(CTipoAltAnt, LIncDocCorrente, LSeqAjuCorrente,
                          LColunaLogUp, LValAnt);
          pAtualizarLinha(CTipoAltAtu, LIncDocCorrente, LSeqAjuCorrente,
                          LColunaLogUp, LValAtu);
        end
        else if LTipAju = CTipoInc then
          pAtualizarLinha(LTipAju, LIncDocCorrente, LSeqAjuCorrente,
                          LColunaLogUp, LValAtu)
        else if LTipAju = CTipoExc then
          pAtualizarLinha(LTipAju, LIncDocCorrente, LSeqAjuCorrente,
                          LColunaLogUp, LValAnt);

        LqryLog.Next;
      end;

      // 6) Troca para o indice de exibicao e posiciona no inicio
      LcdsResultado.IndexName := 'IDX_EXIBICAO';
      LcdsResultado.First;
      Result := LcdsResultado;
    finally
      LMapaColunas.Free;
      LColunasDist.Free;
      FreeAndNil(LqryLog);
    end;
  except
    FreeAndNil(LcdsResultado);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarMetadataColunas(
  const ATabela: string): TMapaColunas;
var
  LqryMeta: TUniQuery;
  LInfo: TInfoColuna;
  LNome: string;
  LstrTabela: string;
  LMapa: TMapaColunas;
begin
  if Trim(ATabela) = '' then
  begin
    Result := TMapaColunas.Create;
    Exit;
  end;

  LstrTabela := UpperCase(Trim(ATabela));

  GCacheLockMetadata.Enter;
  try
    if GCacheMetadataColunas.TryGetValue(LstrTabela, LMapa) then
    begin
      // Retorna uma cópia porque o caller faz .Free
      Result := TMapaColunas.Create(LMapa);
      Exit;
    end;
  finally
    GCacheLockMetadata.Leave;
  end;

  Result := TMapaColunas.Create;
  LqryMeta := fCriaQuery(nil);
  try
    LqryMeta.SQL.Add('SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH ');
    LqryMeta.SQL.Add('  FROM INFORMATION_SCHEMA.COLUMNS                       ');
    LqryMeta.SQL.Add(' WHERE TABLE_SCHEMA = DATABASE()                        ');
    LqryMeta.SQL.Add('   AND TABLE_NAME   = :TABELA                           ');
    LqryMeta.ParamByName('TABELA').AsString := ATabela;
    LqryMeta.Open;

    while not LqryMeta.Eof do
    begin
      LNome      := UpperCase(LqryMeta.FieldByName('COLUMN_NAME').AsString);
      LInfo.Tipo := fMySqlTipoParaFieldType(LqryMeta.FieldByName('DATA_TYPE').AsString);

      if (LInfo.Tipo in [ftString, ftMemo]) and
         (not LqryMeta.FieldByName('CHARACTER_MAXIMUM_LENGTH').IsNull) then
        LInfo.Tamanho := LqryMeta.FieldByName('CHARACTER_MAXIMUM_LENGTH').AsInteger
      else
        LInfo.Tamanho := 0;

      if (LInfo.Tipo = ftString) and (LInfo.Tamanho > 4000) then
      begin
        LInfo.Tipo    := ftMemo;
        LInfo.Tamanho := 0;
      end;

      Result.AddOrSetValue(LNome, LInfo);
      LqryMeta.Next;
    end;

    GCacheLockMetadata.Enter;
    try
      if not GCacheMetadataColunas.ContainsKey(LstrTabela) then
        GCacheMetadataColunas.Add(LstrTabela, TMapaColunas.Create(Result));
    finally
      GCacheLockMetadata.Leave;
    end;

  finally
    FreeAndNil(LqryMeta);
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualBanNco(
  const ACodigo: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlBanNco;
    Result.ParamByName('CODBAN').AsString := ACodigo;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualCliNco(
  const ACodigo: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlCliNco;
    Result.ParamByName('CODCLI').AsString := ACodigo;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualCmpPar(
  const ASeqPar: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlCmpPar;
    Result.ParamByName('SEQPAR').AsString := ASeqPar;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualCtaNco(
  const ACodigo: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlCtaNco;
    Result.ParamByName('CODCTA').AsString := ACodigo;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualForNco(
  const ACodigo: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlForNco;
    Result.ParamByName('CODFOR').AsString := ACodigo;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualParcon(
  const ASeqPar: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlParcon;
    Result.ParamByName('SEQPAR').AsString := ASeqPar;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualParNco(
  const ASeqPar: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlParNco;
    Result.ParamByName('SEQPAR').AsString := ASeqPar;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistroAtualPorNco(
  const ACodigo: String): TUniQuery;
begin
  Result := fCriaQuery;
  try
    Result.Close;
    Result.SQL.Text := fRetornaSqlPorNco;
    Result.ParamByName('CODPOR').AsString := ACodigo;
    Result.Open;
    Result.First;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosBanNco(
  const ACodigo: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaCodigoBannco(ACodigo);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('BANNCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosCliNco(
  const ACodigo: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaCodigoClinco(ACodigo);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('CLINCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosCmpPar(
  const ASeqPar: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaAutoIncCmpPar(ASeqPar);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('CMPPAR', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosCtaNco(
  const ACodigo: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaCodigoCtanco(ACodigo);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('CTANCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosForNco(
  const ACodigo: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaCodigoFornco(ACodigo);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('FORNCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosParcon(
  const ASeqPar: String): TUniClientDataSet;
var
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', ASeqPar)];
  LConsultaLogs := fCarregarLogPivotado('PARCON', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosParNco(
  const ASeqPar: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaAutoIncParnco(ASeqPar);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('PARNCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fCarregarRegistrosAlteradosPorNco(
  const ACodigo: String): TUniClientDataSet;
var
  LIncs: TValoresArray;
  LFiltros: TArrayFiltrosLog;
  LConsultaLogs: TUniClientDataSet;
begin
  LIncs := fRetornaCodigoPornco(ACodigo);
  if Length(LIncs) > 0 then
  begin
    LFiltros := [TParFiltroLog.Em('LOG_INCDOC', LIncs)];
  end
  else
  begin
    LFiltros := [TParFiltroLog.Igual('LOG_INCDOC', '-1')];
  end;
  LConsultaLogs := fCarregarLogPivotado('PORNCO', LFiltros);
  Result := LConsultaLogs;
end;

function TAuditoriaLancamentosService.fEhValorNulo(
  const ATexto: string): Boolean;
var
  LTexto: string;
begin
  LTexto := Trim(ATexto);
  Result := (LTexto = '')   or
            (LTexto = '\N') or
            SameText(LTexto, 'NULL');
end;

function TAuditoriaLancamentosService.fMySqlTipoParaFieldType(
  const ADataType: string): TFieldType;
var
  LTipo: string;
begin
  LTipo := LowerCase(Trim(ADataType));

  if (LTipo = 'tinyint')  or (LTipo = 'smallint') or (LTipo = 'mediumint') or
     (LTipo = 'int')      or (LTipo = 'integer')  or (LTipo = 'year') then
    Result := ftInteger
  else if LTipo = 'bigint' then
    Result := ftLargeInt
  else if (LTipo = 'decimal') or (LTipo = 'numeric') or
          (LTipo = 'float')   or (LTipo = 'double')  or (LTipo = 'real') then
    Result := ftFloat
  else if LTipo = 'date' then
    Result := ftDate
  else if (LTipo = 'datetime') or (LTipo = 'timestamp') then
    Result := ftDateTime
  else if LTipo = 'time' then
    Result := ftTime
  else if LTipo = 'bit' then
    Result := ftBoolean
  else if (LTipo = 'text') or (LTipo = 'mediumtext') or (LTipo = 'longtext') then
    Result := ftMemo
  else
    Result := ftString;
end;

function TAuditoriaLancamentosService.fRetornaAutoIncCmpPar(
  const ASeqPar: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'CMPPAR';
      LConsultaLog.ParamByName('COLUNA').AsString := 'PAR_SEQPAR';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ASeqPar;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];

  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaAutoIncLancon(const AIncDoc,
  AAutoIncLancon: string): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_INCDOC = :INCDOC_LANCON ');
      LConsultaLog.ParamByName('TABELA').AsString := 'LANCON';
      LConsultaLog.ParamByName('COLUNA').AsString := 'CON_INCDOC';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := AIncDoc;
      LConsultaLog.ParamByName('INCDOC_LANCON').AsString := AAutoIncLancon;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;
    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];
  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaAutoIncParnco(
  const ASeqPar: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'PARNCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'CON_SEQPAR';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ASeqPar;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;
    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];
  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaCodigoBannco(
  const ACodigo: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'BANNCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'NCO_CODBAN';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ACodigo;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];

  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaCodigoClinco(
  const ACodigo: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'CLINCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'NCO_CODCLI';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ACodigo;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];
  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaCodigoCtanco(
  const ACodigo: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'CTANCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'NCO_CODCTA';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ACodigo;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];

  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaCodigoFornco(
  const ACodigo: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'FORNCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'NCO_CODFOR';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ACodigo;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];

  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaCodigoPornco(
  const ACodigo: String): TValoresArray;
var
  LConsultaLog: TUniQuery;
  LlstIds: TList<string>;
  LCnt: Integer;
begin
  LlstIds := TList<string>.Create;
  try
    LConsultaLog := fCriaQuery();
    try
      LConsultaLog.Close;
      LConsultaLog.SQL.Clear;
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALATU = :VALOR_INCDOC ');
      LConsultaLog.SQL.Add(' UNION ');
      LConsultaLog.SQL.Add(' SELECT LOG_INCDOC FROM LOGAJC ');
      LConsultaLog.SQL.Add(' WHERE LOG_TABELA = :TABELA AND ');
      LConsultaLog.SQL.Add('       LOG_COLUNA = :COLUNA AND ');
      LConsultaLog.SQL.Add('       LOG_VALANT = :VALOR_INCDOC ');
      LConsultaLog.ParamByName('TABELA').AsString := 'PORNCO';
      LConsultaLog.ParamByName('COLUNA').AsString := 'NCO_CODPOR';
      LConsultaLog.ParamByName('VALOR_INCDOC').AsString := ACodigo;
      LConsultaLog.Open;
      LConsultaLog.First;
      while not LConsultaLog.Eof do
      begin
        LlstIds.Add(LConsultaLog.FieldByName('LOG_INCDOC').AsString);
        LConsultaLog.Next;
      end;
    finally
      FreeAndNil(LConsultaLog);
    end;

    SetLength(Result, LlstIds.Count);
    for LCnt := 0 to LlstIds.Count - 1 do
      Result[LCnt] := LlstIds[LCnt];

  finally
    FreeAndNil(LlstIds);
  end;
end;

function TAuditoriaLancamentosService.fRetornaSqlBanNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_CODBAN, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CODCON ';
  LSql := LSql + '  FROM BANNCO ';
  LSql := LSql + '  WHERE NCO_CODBAN = :CODBAN ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlCliNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_CODCLI, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CODCON ';
  LSql := LSql + '  FROM CLINCO ';
  LSql := LSql + '  WHERE NCO_CODCLI = :CODCLI ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlCmpPar: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '    AUTOINCREM, ';
  LSql := LSql + '    PAR_SEQPAR, ';
  LSql := LSql + '    PAR_MD5KEY, ';
  LSql := LSql + '    PAR_COMPLE ';
  LSql := LSql + '  FROM CMPPAR ';
  LSql := LSql + '  WHERE PAR_SEQPAR = :SEQPAR ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlCtaNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_CODCTA, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CODCON ';
  LSql := LSql + '  FROM CTANCO ';
  LSql := LSql + '  WHERE NCO_CODCTA = :CODCTA ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlForNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_CODFOR, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CODCON ';
  LSql := LSql + '  FROM FORNCO ';
  LSql := LSql + '  WHERE NCO_CODFOR = :CODFOR ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlLancon(
  const AFiltros: TArrayFiltrosLog;
  const ATipo: TPesquisaLancamentoContabil): String;
const
  CColunasPermitidasLancon: array[0..10] of string = (
    'AUTOINCREM', 'CON_EMPLAN', 'CON_DTALAN', 'CON_TIPLAN',
    'CON_CONCRE', 'CON_CONDEB', 'CON_HISPAD',
    'CON_HISTOR', 'CON_VALLAN', 'CON_INCDOC', 'CON_SEQPAR'
  );
  CColunasPermitidasLo2Lan: array[0..8] of string = (
    'AUTOINCREM', 'LAN_EMPLAN', 'LAN_DTALAN', 'LAN_TIPLAN',
    'LAN_CONCRE', 'LAN_CONDEB', 'LAN_HISPAD',
    'LAN_HISTOR', 'LAN_VALLAN'
  );
var
  LWhereExtra, LWhereLo2Lan: String;
  LSql: string;
begin
  LSql := EmptyStr;
  Result := EmptyStr;
  case ATipo of
    plcLancon:
      begin
        LSql := LSql + ' SELECT ';
        LSql := LSql + '  LANCON.AUTOINCREM, ';
        LSql := LSql + '  LANCON.CON_EMPLAN, ';
        LSql := LSql + '  LANCON.CON_DTALAN, ';
        LSql := LSql + '  LANCON.CON_TIPLAN, ';
        LSql := LSql + '  LANCON.CON_CLAFIS, ';
        LSql := LSql + '  LANCON.CON_NATOPE, ';
        LSql := LSql + '  LANCON.CON_DESVAL, ';
        LSql := LSql + '  LANCON.CON_CONCRE, ';
        LSql := LSql + '  PLANCR.NCO_DESCRI AS DES_CONCRE, ';
        LSql := LSql + '  PLANCR.NCO_CONRED AS RED_CONCRE, ';
        LSql := LSql + '  LANCON.CON_CONDEB, ';
        LSql := LSql + '  PLANDE.NCO_DESCRI AS DES_CONDEB, ';
        LSql := LSql + '  PLANDE.NCO_CONRED AS RED_CONDEB, ';
        LSql := LSql + '  LANCON.CON_HISPAD, ';
        LSql := LSql + '  REPLACE(UPPER(COALESCE(LANCON.CON_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ';
        LSql := LSql + '  LANCON.CON_VALLAN, ';
        LSql := LSql + '  LANCON.CON_AUTOMA, ';
        LSql := LSql + '  LANCON.CON_CCUSTO, ';
        LSql := LSql + '  EVEDEB.EVE_DESEVE AS DES_CCUSTO, ';
        LSql := LSql + '  LANCON.CON_CODOPE, ';
        LSql := LSql + '  LANCON.CON_INCDOC, ';
        LSql := LSql + '  LANCON.CON_CCUSCR, ';
        LSql := LSql + '  EVECRE.EVE_DESEVE AS DES_CCUSCR, ';
        LSql := LSql + '  LANCON.CON_TABELA, ';
        LSql := LSql + '  LANCON.CON_PAGAME, ';
        LSql := LSql + '  LANCON.CON_TIP_FC, ';
        LSql := LSql + '  LANCON.CON_TT_ULT, ';
        LSql := LSql + '  LANCON.CON_SEQPAR, ';
        LSql := LSql + '  LANCON.CON_AUTMOD, '; // INCLUIR NA GRID
        LSql := LSql + '  LANCON.CON_INVNCO, ';
        LSql := LSql + '  LO2LAN.LAN_NUMLOT, ';
        LSql := LSql + '  LANCON.CON_TPORIC, ';
        LSql := LSql + '  LANCON.CON_CDORIC, ';
        LSql := LSql + '  LANCON.CON_OPBCCR, ';
        LSql := LSql + '  LANCON.CON_TPORID, ';
        LSql := LSql + '  LANCON.CON_CDORID, ';
        LSql := LSql + '  LANCON.CON_OPBCDB  ';
        LSql := LSql + ' FROM LANCON ';
        LSql := LSql + '  LEFT JOIN LO2LAN ON LANCON.AUTOINCREM = LO2LAN.LAN_CODLAN ';
        LSql := LSql + '  LEFT JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ';
        LSql := LSql + '  LEFT JOIN PLANCO AS PLANCR ON LANCON.CON_CONCRE = PLANCR.NCO_CODCON AND PLANCR.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '  LEFT JOIN PLANCO AS PLANDE ON LANCON.CON_CONDEB = PLANDE.NCO_CODCON AND PLANDE.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '  LEFT JOIN CADEVE AS EVECRE ON LANCON.CON_CCUSCR = EVECRE.EVE_CODEVE ';
        LSql := LSql + '  LEFT JOIN CADEVE AS EVEDEB ON LANCON.CON_CCUSTO = EVEDEB.EVE_CODEVE ';
        LSql := LSql + ' WHERE ';

        LWhereExtra := TFiltroLogBuilder.fMontarWhere(
          'LANCON',
          AFiltros,
          CColunasPermitidasLancon);

        if fEmptyStr(LWhereExtra) then
        begin
          LWhereExtra := 'FALSE';
        end;

        Result := LSql + LWhereExtra;
      end;
    plcLote, plcLoteLancado:
      begin
        LSql := LSql + ' SELECT ';
        LSql := LSql + '   LANCON.AUTOINCREM, ';
        LSql := LSql + '   LANCON.CON_EMPLAN, ';
        LSql := LSql + '   LANCON.CON_DTALAN, ';
        LSql := LSql + '   LANCON.CON_TIPLAN, ';
        LSql := LSql + '   LANCON.CON_NATOPE, ';
        LSql := LSql + '   LANCON.CON_DESVAL, ';
        LSql := LSql + '   LANCON.CON_CONCRE, ';
        LSql := LSql + '   PLANCR.NCO_DESCRI AS DES_CONCRE, ';
        LSql := LSql + '   PLANCR.NCO_CONRED AS RED_CONCRE, ';
        LSql := LSql + '   LANCON.CON_CONDEB, ';
        LSql := LSql + '   PLANDE.NCO_DESCRI AS DES_CONDEB, ';
        LSql := LSql + '   PLANDE.NCO_CONRED AS RED_CONDEB, ';
        LSql := LSql + '   LANCON.CON_HISPAD, ';
        LSql := LSql + '   REPLACE(UPPER(COALESCE(CON_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ';
        LSql := LSql + '   LANCON.CON_VALLAN, ';
        LSql := LSql + '   LANCON.CON_AUTOMA, ';
        LSql := LSql + '   LANCON.CON_CCUSTO, ';
        LSql := LSql + '   EVEDEB.EVE_DESEVE AS DES_CCUSTO, ';
        LSql := LSql + '   LANCON.CON_CODOPE, ';
        LSql := LSql + '   LANCON.CON_INCDOC, ';
        LSql := LSql + '   LANCON.CON_CCUSCR, ';
        LSql := LSql + '   EVECRE.EVE_DESEVE AS DES_CCUSCR, ';
        LSql := LSql + '   LANCON.CON_TABELA, ';
        LSql := LSql + '   LANCON.CON_PAGAME, ';
        LSql := LSql + '   LANCON.CON_TT_ULT, ';
        LSql := LSql + '   LANCON.CON_SEQPAR, ';
        LSql := LSql + '   LANCON.CON_INVNCO, ';
        LSql := LSql + '   LO2LAN.LAN_PARMUL AS LAN_NUMLOT, ';
        LSql := LSql + '  LANCON.CON_TPORIC, ';
        LSql := LSql + '  LANCON.CON_CDORIC, ';
        LSql := LSql + '  LANCON.CON_OPBCCR, ';
        LSql := LSql + '  LANCON.CON_TPORID, ';
        LSql := LSql + '  LANCON.CON_CDORID, ';
        LSql := LSql + '  LANCON.CON_OPBCDB  ';
        LSql := LSql + ' FROM LANCON ';
        LSql := LSql + '   INNER JOIN LO2LAN ON LANCON.AUTOINCREM = LO2LAN.LAN_CODLAN ';
        LSql := LSql + '   LEFT JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ';
        LSql := LSql + '   LEFT JOIN PLANCO AS PLANCR ON LANCON.CON_CONCRE = PLANCR.NCO_CODCON AND PLANCR.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '   LEFT JOIN PLANCO AS PLANDE ON LANCON.CON_CONDEB = PLANDE.NCO_CODCON AND PLANDE.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '   LEFT JOIN CADEVE AS EVECRE ON LANCON.CON_CCUSCR = EVECRE.EVE_CODEVE ';
        LSql := LSql + '   LEFT JOIN CADEVE AS EVEDEB ON LANCON.CON_CCUSTO = EVEDEB.EVE_CODEVE ';
        LSql := LSql + ' WHERE %s ';
        LSql := LSql + ' UNION ALL ';
        LSql := LSql + ' SELECT ';
        LSql := LSql + '   LO2LAN.AUTOINCREM, ';
        LSql := LSql + '   LO2LAN.LAN_EMPLAN AS CON_EMPLAN, ';
        LSql := LSql + '   LO2LAN.LAN_DTALAN AS CON_DTALAN, ';
        LSql := LSql + '   LO2LAN.LAN_TIPLAN AS CON_TIPLAN, ';
        LSql := LSql + '   NULL AS CON_NATOPE, ';
        LSql := LSql + '   NULL AS CON_DESVAL, ';
        LSql := LSql + '   LO2LAN.LAN_CONCRE AS CON_CONCRE, ';
        LSql := LSql + '   PLANCR.NCO_DESCRI AS DES_CONCRE, ';
        LSql := LSql + '   PLANCR.NCO_CONRED AS RED_CONCRE, ';
        LSql := LSql + '   LO2LAN.LAN_CONDEB AS CON_CONDEB, ';
        LSql := LSql + '   PLANDE.NCO_DESCRI AS DES_CONDEB, ';
        LSql := LSql + '   PLANDE.NCO_CONRED AS RED_CONDEB, ';
        LSql := LSql + '   LO2LAN.LAN_HISPAD AS CON_HISPAD, ';
        LSql := LSql + '   REPLACE(UPPER(COALESCE(LO2LAN.LAN_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ';
        LSql := LSql + '   LO2LAN.LAN_VALLAN AS CON_VALLAN, ';
        LSql := LSql + '   LO2LAN.LAN_AUTOMA AS CON_AUTOMA, ';
        LSql := LSql + '   LO2LAN.LAN_CCUSTO AS CON_CCUSTO, ';
        LSql := LSql + '   EVEDEB.EVE_DESEVE AS DES_CCUSTO, ';
        LSql := LSql + '   NULL AS CON_CODOPE, ';
        LSql := LSql + '   LO2LAN.AUTOINCREM AS CON_INCDOC, ';
        LSql := LSql + '   LO2LAN.LAN_CCUSCR AS CON_CCUSCR, ';
        LSql := LSql + '   EVECRE.EVE_DESEVE AS DES_CCUSCR, ';
        LSql := LSql + '   NULL AS CON_TABELA, ';
        LSql := LSql + '   NULL AS CON_PAGAME, ';
        LSql := LSql + '   NULL AS CON_TT_ULT, ';
        LSql := LSql + '   NULL AS CON_SEQPAR, ';
        LSql := LSql + '   NULL AS CON_INVNCO, ';
        LSql := LSql + '   LO2LAN.LAN_PARMUL AS LAN_NUMLOT, ';
        LSql := LSql + '   NULL AS CON_TPORIC, ';
        LSql := LSql + '   NULL AS CON_CDORIC, ';
        LSql := LSql + '   NULL AS CON_OPBCCR, ';
        LSql := LSql + '   NULL AS CON_TPORID, ';
        LSql := LSql + '   NULL AS CON_CDORID, ';
        LSql := LSql + '   NULL AS CON_OPBCDB  ';
        LSql := LSql + ' FROM LO2LAN ';
        LSql := LSql + '   LEFT JOIN CADEMP ON LO2LAN.LAN_EMPLAN = CADEMP.EMP_CODEMP ';
        LSql := LSql + '   LEFT JOIN PLANCO AS PLANCR ON LO2LAN.LAN_CONCRE = PLANCR.NCO_CODCON AND PLANCR.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '   LEFT JOIN PLANCO AS PLANDE ON LO2LAN.LAN_CONDEB = PLANDE.NCO_CODCON AND PLANDE.NCO_TPLACO = CADEMP.EMP_TPLACO ';
        LSql := LSql + '   LEFT JOIN CADEVE AS EVECRE ON LO2LAN.LAN_CCUSCR = EVECRE.EVE_CODEVE ';
        LSql := LSql + '   LEFT JOIN CADEVE AS EVEDEB ON LO2LAN.LAN_CCUSTO = EVEDEB.EVE_CODEVE ';
        LSql := LSql + ' WHERE %s ';

        LWhereExtra := TFiltroLogBuilder.fMontarWhere(
          'LANCON',
          AFiltros,
          CColunasPermitidasLancon);

        if fEmptyStr(LWhereExtra) then
        begin
          LWhereExtra := 'FALSE';
        end;

        LWhereLo2Lan := TFiltroLogBuilder.fMontarWhere(
          'LO2LAN',
          AFiltros,
          CColunasPermitidasLo2Lan);

        if fEmptyStr(LWhereLo2Lan) then
        begin
          LWhereLo2Lan := 'FALSE';
        end;
        LWhereLo2Lan := ReplaceStr(LWhereLo2Lan, '.CON_', '.LAN_');

        Result := Format(LSql, [LWhereExtra, LWhereLo2Lan]);
      end;
    end;
end;

function TAuditoriaLancamentosService.fRetornaSqlParcon: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '   CON_SEQPAR, ';
  LSql := LSql + '   CON_TIPLAN, ';
  LSql := LSql + '   CON_FORPGO, ';
  LSql := LSql + '   CON_DESVAL, ';
  LSql := LSql + '   CON_CLAFIS, ';
  LSql := LSql + '   CON_NATCFO, ';
  LSql := LSql + '   CON_PAGAME, ';
  LSql := LSql + '   CON_NATOPE, ';
  LSql := LSql + '   CON_CONCRE, ';
  LSql := LSql + '   CON_CFCRED, ';
  LSql := LSql + '   CON_PORCRE, ';
  LSql := LSql + '   CON_PCCRED, ';
  LSql := LSql + '   CON_BANCRE, ';
  LSql := LSql + '   CON_ABFCRE, ';
  LSql := LSql + '   CON_TIPPCC, ';
  LSql := LSql + '   CON_CONDEB, ';
  LSql := LSql + '   CON_CFDEBI, ';
  LSql := LSql + '   CON_PORDEB, ';
  LSql := LSql + '   CON_PCDEBI, ';
  LSql := LSql + '   CON_BANDEB, ';
  LSql := LSql + '   CON_ABFDEB, ';
  LSql := LSql + '   CON_TIPPCD, ';
  LSql := LSql + '   CON_ORIGEM, ';
  LSql := LSql + '   CON_PAGANT, ';
  LSql := LSql + '   CON_TITPDD, ';
  LSql := LSql + '   CON_CODEMP, ';
  LSql := LSql + '   CON_VIGINI, ';
  LSql := LSql + '   CON_VIGFIN ';
  LSql := LSql + ' FROM PARCON ';
  LSql := LSql + ' WHERE CON_SEQPAR = :SEQPAR ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlParNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_MD5KEY, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CREDEB, ';
  LSql := LSql + '     NCO_CODCON, ';
  LSql := LSql + '     CON_SEQPAR ';
  LSql := LSql + '  FROM PARNCO ';
  LSql := LSql + '  WHERE CON_SEQPAR = :SEQPAR ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fRetornaSqlPorNco: String;
var
  LSql: String;
begin
  LSql := EmptyStr;
  LSql := LSql + ' SELECT ';
  LSql := LSql + '     NCO_CODPOR, ';
  LSql := LSql + '     NCO_CODEMP, ';
  LSql := LSql + '     NCO_CODCON ';
  LSql := LSql + '  FROM PORNCO ';
  LSql := LSql + '  WHERE NCO_CODPOR = :CODPOR ';
  Result := LSql;
end;

function TAuditoriaLancamentosService.fTryConverterData(
  const ATexto: string; out AValor: TDateTime): Boolean;
var
  LTexto: string;
  LFormat: TFormatSettings;
begin
  LTexto := Trim(ATexto);

  Result := TryStrToDateTime(LTexto, AValor);
  if Result then Exit;

  LFormat := TFormatSettings.Create;
  LFormat.DateSeparator   := '-';
  LFormat.TimeSeparator   := ':';
  LFormat.ShortDateFormat := 'yyyy-mm-dd';
  LFormat.LongDateFormat  := 'yyyy-mm-dd hh:nn:ss';
  Result := TryStrToDateTime(LTexto, AValor, LFormat);
  if Result then Exit;

  LFormat.DateSeparator   := '/';
  LFormat.ShortDateFormat := 'dd/mm/yyyy';
  LFormat.LongDateFormat  := 'dd/mm/yyyy hh:nn:ss';
  Result := TryStrToDateTime(LTexto, AValor, LFormat);
end;

function TAuditoriaLancamentosService.fTryConverterFloat(
  const ATexto: string; out AValor: Double): Boolean;
var
  LTexto: string;
  LFormat: TFormatSettings;
begin
  LTexto := Trim(ATexto);

  Result := TryStrToFloat(LTexto, AValor);
  if Result then Exit;

  LFormat := TFormatSettings.Create;
  LFormat.DecimalSeparator  := '.';
  LFormat.ThousandSeparator := ',';
  Result := TryStrToFloat(LTexto, AValor, LFormat);
  if Result then Exit;

  LFormat.DecimalSeparator  := ',';
  LFormat.ThousandSeparator := '.';
  Result := TryStrToFloat(LTexto, AValor, LFormat);
  if Result then Exit;

  LTexto := StringReplace(LTexto, '.', '', [rfReplaceAll]);
  LTexto := StringReplace(LTexto, ',', '.', [rfReplaceAll]);
  LFormat.DecimalSeparator := '.';
  Result := TryStrToFloat(LTexto, AValor, LFormat);
end;

class function TAuditoriaLancamentosService.New: IAuditoriaLancamentosService;
begin
  Result := Self.Create;
end;

procedure TAuditoriaLancamentosService.pAtribuirValorTipado(
  ACds: TUniClientDataSet; const AColuna: string; const ATexto: string);
var
  LField: TField;
  LValor: Double;
  LData: TDateTime;
  LInt: Integer;
  LInt64: Int64;
begin
  LField := ACds.FindField(AColuna);
  if LField = nil then
    Exit;

  if fEhValorNulo(ATexto) then
  begin
    LField.Clear;
    Exit;
  end;

  case LField.DataType of
    ftInteger:
      if TryStrToInt(Trim(ATexto), LInt) then
        LField.AsInteger := LInt
      else
        LField.Clear;

    ftLargeInt:
      if TryStrToInt64(Trim(ATexto), LInt64) then
        LField.AsLargeInt := LInt64
      else
        LField.Clear;

    ftFloat:
      if fTryConverterFloat(ATexto, LValor) then
        LField.AsFloat := LValor
      else
        LField.Clear;

    ftDate, ftDateTime, ftTime:
      if fTryConverterData(ATexto, LData) then
        LField.AsDateTime := LData
      else
        LField.Clear;

    ftBoolean:
      LField.AsBoolean := MatchText(Trim(ATexto), ['1', 'S', 'T', 'Y', 'TRUE', 'SIM', 'VERDADEIRO']);
  else
    LField.AsString := Trim(ATexto);
  end;
end;

initialization
  GCacheMetadataColunas := TObjectDictionary<string, TMapaColunas>.Create([doOwnsValues]);
  GCacheLockMetadata := TCriticalSection.Create;

finalization
  FreeAndNil(GCacheMetadataColunas);
  FreeAndNil(GCacheLockMetadata);

end.
