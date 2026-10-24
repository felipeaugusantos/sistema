unit Contabilidade.Classes.UniQueryAuditoria;

interface

uses
  System.Classes, System.SysUtils, System.Variants, Data.DB, Uni;

type
  TUniQueryAuditoria = class(TUniQuery)
  private
    FNomeTabela: String;
    FNomeFormulario: String;
    FLogar: Boolean;
    FSnapshotAntes: TStringList;
    FEstadoAntes: TDataSetState;
    FSeqAjuAtual: String;
    FChaveRegistroAntes: String;

    class function fChaveConexao(const AConexao: TUniConnection): String; static;
    class function fLogAjcExisteNaConexao(const AConexao: TUniConnection): Boolean; static;
    function fLogAjcDisponivel: Boolean;

    class function fCampoParaLog(const ACampo: TField): Boolean; static;
    class function fNormalizarValor(const AValor: String): String; static;
    class function fValorParaSnapshot(const ACampo: TField; const AUsarValorAntigo: Boolean): String; static;
    class function fValorSnapshotParaLog(const AValor: String): String; static;
    class function fCampoChaveTabelaLocal(const ATabela: String; const AConexao: TUniConnection): TArray<String>; static;

    procedure pCapturarSnapshot(const AUsarValorAntigo: Boolean = False);
    procedure pLimparSnapshot;
    function fValorSnapshot(const ANomeCampo: String): String;
    function fValorCampoAtual(const ACampo: TField): String;
    function fObterCampoChave: TArray<String>;
    function fObterChaveRegistro: String;
    function fGerarSeqAju: String;
  protected
    procedure DoBeforeEdit; override;
    procedure DoBeforePost; override;
    procedure DoAfterPost; override;
    procedure DoBeforeDelete; override;
    procedure DoAfterDelete; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function fObterCamposChavePK(const ATabela: String; const AConexao: TUniConnection): TArray<String>; static;
    property NomeTabela: String read FNomeTabela write FNomeTabela;
    property NomeFormulario: String read FNomeFormulario write FNomeFormulario;
    property Logar: Boolean read FLogar write FLogar;
    property SeqAjuAtual: String read FSeqAjuAtual write FSeqAjuAtual;
  end;

function fCriaQueryContabilidade(ANomeTabela, ANomeFormulario: String;
  AOwner: TComponent = nil; AConexao: TUniConnection = nil;
  ALogar: Boolean = True): TUniQueryAuditoria;

implementation

uses
  System.Generics.Collections, System.SyncObjs,
  untFuncoesSimples, untTypesSistema,
  Contabilidade.Funcoes, Contabilidade.Classes.LogAjcOp,
  Contabilidade.Classes.LogAjc, Contabilidade.Model.TDadosImportacaoContabil;

const
  CTokenValorNuloSnapshot = '{NULL_SNAPSHOT}';
  CSeparadorChaveComposta = '|';
  CTabelaLogAjc = 'LOGAJC';

var
  GCacheCamposChavePK: TDictionary<String, TArray<String>>;
  GCacheLockPK: TCriticalSection;
  // Guarda apenas resposta conclusiva -- ver fLogAjcExisteNaConexao.
  GCacheLogAjc: TDictionary<String, Boolean>;
  GCacheLockLogAjc: TCriticalSection;

class function TUniQueryAuditoria.fCampoParaLog(const ACampo: TField): Boolean;
begin
  Result := Assigned(ACampo) and not (ACampo.DataType in [ftBlob, ftGraphic, ftStream, ftOraBlob, ftOraClob, ftTypedBinary]);
end;

class function TUniQueryAuditoria.fNormalizarValor(const AValor: String): String;
begin
  // Mesmo limite da gravacao (ver CTamMaxValor em Contabilidade.Classes.LogAjc)
  Result := Trim(AValor);
  if Length(Result) > CTamMaxValor then
    Result := Copy(Result, 1, CTamMaxValor);
end;

class function TUniQueryAuditoria.fValorParaSnapshot(const ACampo: TField; const AUsarValorAntigo: Boolean): String;
var
  Lvalor: Variant;
begin
  if not Assigned(ACampo) then
    Exit(CTokenValorNuloSnapshot);

  if AUsarValorAntigo then
  begin
    try
      Lvalor := ACampo.OldValue;
    except
      Lvalor := ACampo.Value;
    end;
  end
  else
    Lvalor := ACampo.Value;

  if VarIsNull(Lvalor) or VarIsEmpty(Lvalor) then
    Exit(CTokenValorNuloSnapshot);

  Result := fNormalizarValor(VarToStr(Lvalor));
end;

class function TUniQueryAuditoria.fValorSnapshotParaLog(const AValor: String): String;
begin
  if AValor = CTokenValorNuloSnapshot then
    Exit('');

  Result := AValor;
end;

class function TUniQueryAuditoria.fObterCamposChavePK(const ATabela: String;
  const AConexao: TUniConnection): TArray<String>;
var
  LstrTabela: String;
  LqryPK: TUniQuery;
  LlstCampos: TList<String>;
begin
  Result := nil;

  if fEmptyStr(ATabela) then
    raise Exception.Create('TUniQueryAuditoria.fObterCamposChavePK: nome da tabela nao informado.');

  if not Assigned(AConexao) then
    raise Exception.Create('TUniQueryAuditoria.fObterCamposChavePK: conexao nao informada.');

  LstrTabela := UpperCase(Trim(ATabela));

  // 1) tenta cache
  GCacheLockPK.Enter;
  try
    if GCacheCamposChavePK.TryGetValue(LstrTabela, Result) then
    begin
      if Length(Result) = 0 then
        raise Exception.CreateFmt('TUniQueryAuditoria: tabela %s nao possui PRIMARY KEY definida.', [LstrTabela]);
      Exit;
    end;
  finally
    GCacheLockPK.Leave;
  end;

  // 2) consulta INFORMATION_SCHEMA
  LlstCampos := TList<String>.Create;
  try
    LqryPK := TUniQuery.Create(nil);
    try
      LqryPK.Connection := AConexao;
      LqryPK.SQL.Add('SELECT COLUMN_NAME ');
      LqryPK.SQL.Add('  FROM INFORMATION_SCHEMA.STATISTICS ');
      LqryPK.SQL.Add(' WHERE TABLE_SCHEMA = DATABASE() ');
      LqryPK.SQL.Add('   AND TABLE_NAME   = :TABELA ');
      LqryPK.SQL.Add('   AND INDEX_NAME   = ''PRIMARY'' ');
      LqryPK.SQL.Add(' ORDER BY SEQ_IN_INDEX ');
      LqryPK.ParamByName('TABELA').AsString := LstrTabela;
      LqryPK.Open;

      while not LqryPK.Eof do
      begin
        LlstCampos.Add(LqryPK.Fields[0].AsString);
        LqryPK.Next;
      end;
    finally
      FreeAndNil(LqryPK);
    end;

    Result := LlstCampos.ToArray;
  finally
    FreeAndNil(LlstCampos);
  end;

  // 3) grava no cache (mesmo vazio, para nao reconsultar)
  GCacheLockPK.Enter;
  try
    GCacheCamposChavePK.AddOrSetValue(LstrTabela, Result);
  finally
    GCacheLockPK.Leave;
  end;

  if Length(Result) = 0 then
    raise Exception.CreateFmt('TUniQueryAuditoria: tabela %s nao possui PRIMARY KEY definida.', [LstrTabela]);
end;

class function TUniQueryAuditoria.fCampoChaveTabelaLocal(const ATabela: String;
  const AConexao: TUniConnection): TArray<String>;
begin
  Result := fObterCamposChavePK(ATabela, AConexao);
end;

class function TUniQueryAuditoria.fChaveConexao(const AConexao: TUniConnection): String;
begin
  // Identidade logica do banco, nao o endereco do objeto: duas conexoes para o mesmo
  // banco compartilham a resposta, e conexao liberada nao deixa entrada orfa apontando
  // para um endereco que pode ser reaproveitado por outra conexao.
  Result := UpperCase(AConexao.Server + CSeparadorChaveComposta +
                      IntToStr(AConexao.Port) + CSeparadorChaveComposta +
                      AConexao.Database);
end;

class function TUniQueryAuditoria.fLogAjcExisteNaConexao(const AConexao: TUniConnection): Boolean;
var
  Lchave: String;
  Lsonda: TSondaTabela;
begin
  if not Assigned(AConexao) then
    Exit(False);

  Lchave := fChaveConexao(AConexao);

  GCacheLockLogAjc.Enter;
  try
    if GCacheLogAjc.TryGetValue(Lchave, Result) then
      Exit;
  finally
    GCacheLockLogAjc.Leave;
  end;

  Lsonda := fSondarTabelaContabil(CTabelaLogAjc, AConexao);

  // staFalhou nao e resposta: guardar uma falha transitoria desligaria a auditoria em
  // silencio ate o processo reiniciar, que era o defeito original. Nao cacheia e tenta
  // de novo na proxima operacao; enquanto isso a auditoria fica suspensa, nao perdida.
  if Lsonda = staFalhou then
    Exit(False);

  Result := (Lsonda = staExiste);

  GCacheLockLogAjc.Enter;
  try
    GCacheLogAjc.AddOrSetValue(Lchave, Result);
  finally
    GCacheLockLogAjc.Leave;
  end;
end;

function TUniQueryAuditoria.fLogAjcDisponivel: Boolean;
begin
  // Resolvido sob demanda, na conexao que vai gravar o log -- a mesma que e passada a
  // TLogAjc.pGravarLote. No construtor nao daria: fCriaQueryContabilidade so atribui a
  // Connection depois do Create, entao a sondagem caia na conexao corrente do sistema,
  // que nem sempre e esta.
  Result := fLogAjcExisteNaConexao(Self.Connection);
end;

constructor TUniQueryAuditoria.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSnapshotAntes := TStringList.Create;
  FSnapshotAntes.NameValueSeparator := '=';
  FLogar := True;
  FSeqAjuAtual := '';
  FChaveRegistroAntes := '';
end;

destructor TUniQueryAuditoria.Destroy;
begin
  FreeAndNil(FSnapshotAntes);
  inherited Destroy;
end;

procedure TUniQueryAuditoria.pCapturarSnapshot(const AUsarValorAntigo: Boolean = False);
var
  LintCampo: Integer;
  Lcampo: TField;
  Lvalor: String;
begin
  FSnapshotAntes.Clear;

  if not Active then
    Exit;

  for LintCampo := 0 to Fields.Count - 1 do
  begin
    Lcampo := Fields[LintCampo];
    if not Self.fCampoParaLog(Lcampo) then
      Continue;

    Lvalor := Self.fValorParaSnapshot(Lcampo, AUsarValorAntigo);
    FSnapshotAntes.Add(Lcampo.FieldName + FSnapshotAntes.NameValueSeparator + Lvalor);
  end;
end;

procedure TUniQueryAuditoria.pLimparSnapshot;
begin
  FSnapshotAntes.Clear;
end;

function TUniQueryAuditoria.fValorSnapshot(const ANomeCampo: String): String;
var
  Lidx: Integer;
begin
  Lidx := FSnapshotAntes.IndexOfName(ANomeCampo);
  if Lidx < 0 then
    Exit('');

  Result := FSnapshotAntes.ValueFromIndex[Lidx];
end;

function TUniQueryAuditoria.fValorCampoAtual(const ACampo: TField): String;
begin
  if (not Assigned(ACampo)) or ACampo.IsNull then
    Exit('');

  Result := Self.fNormalizarValor(ACampo.AsString);
end;

function TUniQueryAuditoria.fObterCampoChave: TArray<String>;
begin
  Result := Self.fCampoChaveTabelaLocal(FNomeTabela, Self.Connection);
end;

function TUniQueryAuditoria.fObterChaveRegistro: String;
var
  LarrCampos: TArray<String>;
  LintCampo: Integer;
  Lfld: TField;
  LstrValor: String;
begin
  Result := '';

  LarrCampos := fObterCampoChave;

  for LintCampo := 0 to High(LarrCampos) do
  begin
    Lfld := FindField(LarrCampos[LintCampo]);
    if Lfld = nil then
      Exit('');

    LstrValor := Lfld.AsString;

    if LintCampo = 0 then
      Result := LstrValor
    else
      Result := Result + CSeparadorChaveComposta + LstrValor;
  end;
end;

function TUniQueryAuditoria.fGerarSeqAju: String;
begin
  if TLogAjcOpContext.SeqAju <> '' then
    Result := TLogAjcOpContext.SeqAju
  else
    Result := TLogAjc.fGerarSeqAju;
end;

procedure TUniQueryAuditoria.DoBeforeEdit;
begin
  // Captura o snapshot no inicio da edicao, quando Value ainda traz o valor original
  // vindo do banco. Evita depender de OldValue no DoBeforePost: em query com JOIN ou
  // coluna calculada o OldValue nao devolve o valor anterior, o fallback assume o valor
  // NOVO e o diff do DoAfterPost fica vazio -- nada era gravado na LOGAJC.
  pLimparSnapshot;

  if FLogar and fLogAjcDisponivel then
    pCapturarSnapshot(False);

  inherited DoBeforeEdit;
end;

procedure TUniQueryAuditoria.DoBeforePost;
begin
  FEstadoAntes := Self.State;

  if FLogar and fLogAjcDisponivel then
  begin
    if FEstadoAntes = dsEdit then
    begin
      // snapshot ja veio do DoBeforeEdit; OldValue fica apenas como fallback
      if FSnapshotAntes.Count = 0 then
        pCapturarSnapshot(True);
    end
    else if FEstadoAntes = dsInsert then
      pLimparSnapshot;

    FSeqAjuAtual := fGerarSeqAju;
  end;

  inherited DoBeforePost;
end;

procedure TUniQueryAuditoria.DoAfterPost;
var
  LintCampo: Integer;
  Lcampo: TField;
  LvalorAnt, LvalorAtu, LvalorAtuComparacao, LincDoc: String;
  LitensLog: TObjectList<TLogAjcItem>;
  LitemLog: TLogAjcItem;
  LCodEmp, LCodOpe: string;
  LDtaAlt: TDate;
  LHraAlt: TTime;
begin
  inherited DoAfterPost;

  if not FLogar then
    Exit;

  if not fLogAjcDisponivel then
    Exit;

  LitensLog := TObjectList<TLogAjcItem>.Create;
  try
    LincDoc := fObterChaveRegistro;

    LCodEmp := VS_strCodEmp;
    LCodOpe := strLoginUsuarioLogado;
    LDtaAlt := fNow;
    LHraAlt := fTime;

    if FEstadoAntes = dsInsert then
    begin
      for LintCampo := 0 to Fields.Count - 1 do
      begin
        Lcampo := Fields[LintCampo];
        if not Self.fCampoParaLog(Lcampo) then
          Continue;

        LvalorAtu := fValorCampoAtual(Lcampo);

        LitemLog := TLogAjcItem.Create;
        LitemLog.CodEmp := LCodEmp;
        LitemLog.CodOpe := LCodOpe;
        LitemLog.DtaAlt := LDtaAlt;
        LitemLog.HraAlt := LHraAlt;
        LitemLog.Tabela := FNomeTabela;
        LitemLog.Incdoc := LincDoc;
        LitemLog.Tipaju := 'INC';
        LitemLog.Coluna := Lcampo.FieldName;
        LitemLog.ValAnt := '';
        LitemLog.ValAtu := LvalorAtu;
        LitemLog.NomFrm := FNomeFormulario;
        LitemLog.SeqAju := FSeqAjuAtual;
        LitensLog.Add(LitemLog);
      end;
    end
    else if FEstadoAntes = dsEdit then
    begin
      for LintCampo := 0 to Fields.Count - 1 do
      begin
        Lcampo := Fields[LintCampo];
        if not Self.fCampoParaLog(Lcampo) then
          Continue;

        LvalorAnt := fValorSnapshot(Lcampo.FieldName);
        LvalorAtu := fValorCampoAtual(Lcampo);
        if Lcampo.IsNull then
          LvalorAtuComparacao := CTokenValorNuloSnapshot
        else
          LvalorAtuComparacao := LvalorAtu;

        if LvalorAnt <> LvalorAtuComparacao then
        begin
          LitemLog := TLogAjcItem.Create;
          LitemLog.CodEmp := LCodEmp;
          LitemLog.CodOpe := LCodOpe;
          LitemLog.DtaAlt := LDtaAlt;
          LitemLog.HraAlt := LHraAlt;
          LitemLog.Tabela := FNomeTabela;
          LitemLog.Incdoc := LincDoc;
          LitemLog.Tipaju := 'ALT';
          LitemLog.Coluna := Lcampo.FieldName;
          LitemLog.ValAnt := Self.fValorSnapshotParaLog(LvalorAnt);
          LitemLog.ValAtu := Self.fValorSnapshotParaLog(LvalorAtuComparacao);
          LitemLog.NomFrm := FNomeFormulario;
          LitemLog.SeqAju := FSeqAjuAtual;
          LitensLog.Add(LitemLog);
        end;
      end;
    end;

    TLogAjc.pGravarLote(LitensLog, Self.Connection);
  finally
    FreeAndNil(LitensLog);
  end;
end;

procedure TUniQueryAuditoria.DoBeforeDelete;
begin
  if FLogar and fLogAjcDisponivel then
  begin
    FChaveRegistroAntes := fObterChaveRegistro;
    pCapturarSnapshot(False);
    FSeqAjuAtual := fGerarSeqAju;
  end;

  inherited DoBeforeDelete;
end;

procedure TUniQueryAuditoria.DoAfterDelete;
var
  LintItem: Integer;
  Lcoluna, LvalorAnt: String;
  LitensLog: TObjectList<TLogAjcItem>;
  LitemLog: TLogAjcItem;
  LCodEmp, LCodOpe: string;
  LDtaAlt: TDate;
  LHraAlt: TTime;
begin
  inherited DoAfterDelete;

  if not FLogar then
    Exit;

  if not fLogAjcDisponivel then
    Exit;

  LitensLog := TObjectList<TLogAjcItem>.Create;
  try
    LCodEmp := VS_strCodEmp;
    LCodOpe := strLoginUsuarioLogado;
    LDtaAlt := fNow;
    LHraAlt := fTime;

    for LintItem := 0 to FSnapshotAntes.Count - 1 do
    begin
      Lcoluna := FSnapshotAntes.Names[LintItem];
      LvalorAnt := Self.fValorSnapshotParaLog(FSnapshotAntes.ValueFromIndex[LintItem]);
      LitemLog := TLogAjcItem.Create;
      LitemLog.CodEmp := LCodEmp;
      LitemLog.CodOpe := LCodOpe;
      LitemLog.DtaAlt := LDtaAlt;
      LitemLog.HraAlt := LHraAlt;
      LitemLog.Tabela := FNomeTabela;
      LitemLog.Incdoc := FChaveRegistroAntes;
      LitemLog.Tipaju := 'EXC';
      LitemLog.Coluna := Lcoluna;
      LitemLog.ValAnt := LvalorAnt;
      LitemLog.ValAtu := '';
      LitemLog.NomFrm := FNomeFormulario;
      LitemLog.SeqAju := FSeqAjuAtual;
      LitensLog.Add(LitemLog);
    end;

    TLogAjc.pGravarLote(LitensLog, Self.Connection);
  finally
    FreeAndNil(LitensLog);
  end;

  FChaveRegistroAntes := '';
end;

function fCriaQueryContabilidade(ANomeTabela, ANomeFormulario: String;
  AOwner: TComponent = nil; AConexao: TUniConnection = nil;
  ALogar: Boolean = True): TUniQueryAuditoria;
begin
  Result := TUniQueryAuditoria.Create(AOwner);

  if Assigned(AConexao) then
    Result.Connection := AConexao
  else
    Result.Connection := fGetConexao;

  if Assigned(Result.Connection) then
    Result.Tag := Result.Connection.Tag;

  Result.Options.RequiredFields := False;
  Result.NomeTabela := ANomeTabela;
  Result.NomeFormulario := ANomeFormulario;
  Result.Logar := ALogar;

  if Assigned(ProcTracerContabilidadeSetQueryEvent) then
    ProcTracerContabilidadeSetQueryEvent(Result);
end;

initialization
  GCacheCamposChavePK := TDictionary<String, TArray<String>>.Create;
  GCacheLockPK := TCriticalSection.Create;
  GCacheLogAjc := TDictionary<String, Boolean>.Create;
  GCacheLockLogAjc := TCriticalSection.Create;

finalization
  FreeAndNil(GCacheCamposChavePK);
  FreeAndNil(GCacheLockPK);
  FreeAndNil(GCacheLogAjc);
  FreeAndNil(GCacheLockLogAjc);

end.
