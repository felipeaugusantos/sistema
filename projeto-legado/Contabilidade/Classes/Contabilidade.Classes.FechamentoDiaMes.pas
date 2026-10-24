unit Contabilidade.Classes.FechamentoDiaMes;

interface

uses
  System.SysUtils, System.Classes, System.StrUtils, System.Generics.Collections,
  Data.Db,
  Uni, UniClientDataset, UniDataSetProvider,
  untTypesSistema, Contabilidade.Funcoes,
  Contabilidade.Interfaces;

type
  TFechamentoException = class(Exception);
  TFechamentoInclusaoException = class(TFechamentoException);

  TFechamentoContabilDiaMes = class
  private
    FstrNomeFormulario : String;
    FstrUltEmpresaFechada: String;
    FQryUltimoFechamento: TUniQuery;
    FQryUltimo24Fechamento: TUniQuery;
    procedure pCarregaSqlUltimoFechamento;
    procedure pCarregaSqlUltimo24Fechamento;
    procedure pIncluirFechamentoInterno(const AstrCodEmp: String; const ADtaRef: TDate; const AblnRaiz: Boolean);
    procedure pExcluirFechamentoInterno(const AstrCodEmp: String; const ADtaRef: TDate);
    function fGetArrEmp(const AstrCodEmp: string; const AblnRaiz: Boolean): TConsultasArray;
  public
    function fGetUltimaEmpresaFechada: string;
    function fTemOutrosFechamentosNaRaiz(const AstrCodEmp: String; const ADtaRef: TDate): Boolean;
    function fExcluirFechamento(const AstrCodEmp: String; const ADtaRef: TDate; const AblnRaiz: Boolean): Boolean;
    function fIncluirFechamento(const AstrCodEmp: String; const ADtaRef: TDate; const AblnRaiz: Boolean): Boolean;
    function fGetDataUltimoFechamento(const AstrCodEmp: String): TDate;
    function fGetDataUltimoFecCon(const AstrCodEmp: String): TDate;
    function fCarregaUltimoFechamentoTodasEmpresas(Var AcdsUltimoFec: TUniClientDataSet; Var AdspUltimoFec: TUniDataSetProvider): Boolean;
    function fCarregaUltimos24Fechamentos(Var AcdsUltimo24Fec: TUniClientDataSet; Var AdspUltimo24Fec: TUniDataSetProvider): Boolean;

    constructor Create(const AstrNomeFormulario : String);
    destructor Destroy; override;
  end;

  TDictFecEmp = TDictionary<String, TDate>;

  TVerificaFechamentoDiaMes = class
  private
    FDictFecEmp: TDictFecEmp;
    FlstCodEmp: TStringList;
    FblnTabelaExiste: Boolean;
    FblnAlgumaEmpFec: Boolean;

    class function fstrCodEmpToArr(const AstrCodEmp: string): TConsultasArray;
    class function fArrEmpLength(const AarrEmp: TConsultasArray): Integer;
    class function fArrTodasEmpresas(const AarrEmp: TConsultasArray): Boolean;
    class function fstrFiltroEmpresas(const AarrEmp: TConsultasArray; const AstrAlias: string = ''): string;
    class function fstrEmpresas(Astrs: TStrings): string;
    class function fCarregaUltimoFechamentoEmpresas: TDictFecEmp;

    class function fAlgumaEmpresaArrFechadaPerido(const AdtaIni: TDate; const AarrEmp: TConsultasArray; var AdictFecEmp: TDictFecEmp; var AlstEmp: TStringList): Boolean;
    class function fAlgumaEmpresaTemFechamento(Adict: TDictFecEmp): Boolean;
    class function fTemLancon(const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList; const ATiposContabeis: TSetTiposContabeis): Boolean;
    class function fTemLancntGenerico(const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList; const ATipoContabil: TTiposContabeis; Const AqryLan: TUniQuery): Boolean;
    class function fTemLanconCTR(const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList; const AblnDtaBan: Boolean; Const AqryLan: TUniQuery): Boolean;
    class function fTemLancntCTR(const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList; const AblnDtaBan: Boolean; Const AqryLan: TUniQuery): Boolean;
    class procedure pMostraLancamentos(var AqryLan: TUniQuery);

  public
    class function fTemFechamento(const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray; const AblnVerifAdcLancon: Boolean = False; const ATiposContabeis: TSetTiposContabeis = []): Boolean; overload;
    class function fTemFechamento(const AdtaIni, AdtaFin: TDate; const AstrCodEmp: string; const AblnVerifAdcLancon: Boolean = False; const ATiposContabeis: TSetTiposContabeis = []): Boolean; overload;
    function fTemFechamentoTValida(const AdtaIni, AdtaFin: TDate; const AstrCodEmp: string; var AstrMsg: string): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Classes.TLanConCTR, Contabilidade.Classes.UniQueryAuditoria, Contabilidade.View.LancamentosContabeis;

const
  SQL_ULT_FEC_EMPRESAS = 'SELECT EMP_CODEMP, MAX(FEC_DTAREF) AS FEC_DTAREF FROM CADEMP LEFT JOIN FECCDM ON EMP_CODEMP = FEC_CODEMP GROUP BY EMP_CODEMP';

{ TFechamentoContabilDiaMes }

constructor TFechamentoContabilDiaMes.Create(const AstrNomeFormulario: String);
begin
  FstrNomeFormulario := AstrNomeFormulario;
  FstrUltEmpresaFechada := '';
  FQryUltimoFechamento   := fCriaQuery;
  FQryUltimo24Fechamento := fCriaQuery;
  pCarregaSqlUltimo24Fechamento;
  pCarregaSqlUltimoFechamento;
end;

destructor TFechamentoContabilDiaMes.Destroy;
begin
  FreeAndNil(FQryUltimo24Fechamento);
  FreeAndNil(FQryUltimoFechamento);
  inherited;
end;

function TFechamentoContabilDiaMes.fCarregaUltimoFechamentoTodasEmpresas(
  var AcdsUltimoFec: TUniClientDataSet;
  var AdspUltimoFec: TUniDataSetProvider): Boolean;
Begin
  AcdsUltimoFec.Close;
  FQryUltimoFechamento.Close;

  AdspUltimoFec.DataSet := FQryUltimoFechamento;
  AcdsUltimoFec.SetProvider(AdspUltimoFec);

  AcdsUltimoFec.Open;

  Result := True;
End;

function TFechamentoContabilDiaMes.fCarregaUltimos24Fechamentos(
  var AcdsUltimo24Fec: TUniClientDataSet;
  var AdspUltimo24Fec: TUniDataSetProvider): Boolean;
Begin
  AcdsUltimo24Fec.Close;
  FQryUltimo24Fechamento.Close;

  AdspUltimo24Fec.DataSet := FQryUltimo24Fechamento;
  AcdsUltimo24Fec.SetProvider(AdspUltimo24Fec);

  AcdsUltimo24Fec.Open;

  Result := True;
end;

function TFechamentoContabilDiaMes.fExcluirFechamento(const AstrCodEmp: String;
  const ADtaRef: TDate; const AblnRaiz: Boolean): Boolean;
var
  LarrEmp: TConsultasArray;
  LintCount: integer;
begin
  Result := True;
  LarrEmp := fGetArrEmp(AstrCodEmp, AblnRaiz);

  fStartTransaction;
  try
    for LintCount := Low(LarrEmp) to High(LarrEmp) do 
      pExcluirFechamentoInterno(LarrEmp[LintCount].strCodigo, ADtaRef);

    fCommit;
  except
    fRollBack;
    raise;
  end;
end;

function TFechamentoContabilDiaMes.fGetArrEmp(const AstrCodEmp: string; const AblnRaiz: Boolean): TConsultasArray;
begin
  if AblnRaiz then
    Result := fObtemEmpresasFiliais(AstrCodEmp)
  else
  begin
    SetLength(Result, 1);
    Result[0].strCodigo := AstrCodEmp;
    Result[0].strDescri := '';
  end;
end;

function TFechamentoContabilDiaMes.fGetDataUltimoFecCon(
  const AstrCodEmp: String): TDate;
var
  LqryFECCON: TUniQuery;
begin
  Result := 0;

  LqryFECCON := fCriaQuery(nil);
  try
    LqryFECCON.SQL.Add('SELECT MAX(CON_FECFIN) AS CON_FECFIN ');
    LqryFECCON.SQL.Add('FROM FECCON ');
    LqryFECCON.SQL.Add('INNER JOIN ( ');
    LqryFECCON.SQL.Add('  SELECT EMP_CODEMP ');
    LqryFECCON.SQL.Add('  FROM CADEMP ');
    LqryFECCON.SQL.Add('  WHERE SUBSTR(EMP_C_G_C_,1,8) = ( ');
    LqryFECCON.SQL.Add('    SELECT SUBSTR(EMP_C_G_C_,1,8) ');
    LqryFECCON.SQL.Add('    FROM CADEMP ');
    LqryFECCON.SQL.Add('    WHERE EMP_CODEMP = :CODEMP ');
    LqryFECCON.SQL.Add('  ) ');
    LqryFECCON.SQL.Add(') AS EMP ON EMP.EMP_CODEMP = CON_CODEMP ');
    LqryFECCON.SQL.Add('GROUP BY CON_CODEMP ');

    LqryFECCON.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqryFECCON.Open;

    if LqryFECCON.RecordCount = 0 then
      Exit;

    Result := LqryFECCON.FieldByName('CON_FECFIN').AsDateTime;
  finally
    FreeAndNil(LqryFECCON);
  end;
end;

function TFechamentoContabilDiaMes.fGetDataUltimoFechamento(
  const AstrCodEmp: String): TDate;
var
  LqryFECCDM: TUniQuery;
begin
  Result := 0;

  LqryFECCDM := fCriaQuery(nil);
  try
    LqryFECCDM.SQL.Text := 'SELECT MAX(FEC_DTAREF) AS DTAREF FROM FECCDM WHERE FEC_CODEMP = :CODEMP';
    LqryFECCDM.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqryFECCDM.Open;

    if LqryFECCDM.RecordCount = 0 then
      Exit;

    Result := LqryFECCDM.FieldByName('DTAREF').AsDateTime;
  finally
    FreeAndNil(LqryFECCDM);
  end;
end;

function TFechamentoContabilDiaMes.fGetUltimaEmpresaFechada: string;
begin
  Result := FstrUltEmpresaFechada ;
end;

function TFechamentoContabilDiaMes.fIncluirFechamento(const AstrCodEmp: String;
  const ADtaRef: TDate; const AblnRaiz: Boolean): Boolean;
var
  LintCount: integer;
  LarrEmp: TConsultasArray;
  LdtaUltFecCon: TDate;
begin
  Result := True;

  LdtaUltFecCon := fGetDataUltimoFecCon(AstrCodEmp);
  if LdtaUltFecCon >= ADtaRef then
    raise TFechamentoInclusaoException.Create('O fechamento sugerido para a empresa ' +AstrCodEmp+
      ' deve ser maior que o último fechamento contábil (FECCON) realizado (' + FormatDateTime('DD/MM/YYYY', LdtaUltFecCon) + ')!');

  LarrEmp := fGetArrEmp(AstrCodEmp, AblnRaiz);

  fStartTransaction;
  try
    for LintCount := Low(LarrEmp) to High(LarrEmp) do
      pIncluirFechamentoInterno(LarrEmp[LintCount].strCodigo, ADtaRef, AblnRaiz);

    fCommit;
  except
    fRollBack;
    raise;
  end;

  if Result then
    FstrUltEmpresaFechada := AstrCodEmp;
end;

function TFechamentoContabilDiaMes.fTemOutrosFechamentosNaRaiz(
  const AstrCodEmp: String; const ADtaRef: TDate): Boolean;
var
  Lqry: TUniQuery;
begin
  Lqry := fCriaQuery(nil);
  try
    Lqry.SQL.Add('SELECT 1 FROM FECCDM');
    Lqry.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = FEC_CODEMP ');
    Lqry.SQL.Add('WHERE FEC_DTAREF = :DTAREF ');
    Lqry.SQL.Add('  AND FEC_CODEMP IN ( ');
    Lqry.SQL.Add('    SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CODEMP <> :CODEMP AND SUBSTR(EMP_C_G_C_,1,8) = ( ');
    Lqry.SQL.Add('      SELECT SUBSTR(EMP_C_G_C_,1,8) FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');
    Lqry.SQL.Add('    ) ');
    Lqry.SQL.Add('  ) ');
    Lqry.ParamByName('DTAREF').AsDate := ADtaRef;
    Lqry.ParamByName('CODEMP').AsString := AstrCodEmp;
    Lqry.Open;

    Result := not Lqry.IsEmpty;
  finally
    FreeAndNil(Lqry);
  end;

end;

procedure TFechamentoContabilDiaMes.pCarregaSqlUltimo24Fechamento;
begin
  FQryUltimo24Fechamento.Close;
  FQryUltimo24Fechamento.SQL.Clear;

  FQryUltimo24Fechamento.SQL.Add('SELECT f1.*, OPE_NOMOPE AS NOMOPE ');
  FQryUltimo24Fechamento.SQL.Add('FROM FECCDM f1 ');
  FQryUltimo24Fechamento.SQL.Add('INNER JOIN CADEMP e ON f1.FEC_CODEMP = e.EMP_CODEMP ');
  FQryUltimo24Fechamento.SQL.Add('INNER JOIN CADOPE ON OPE_CODOPE = f1.FEC_CODOPE ');
  FQryUltimo24Fechamento.SQL.Add('WHERE (');
  FQryUltimo24Fechamento.SQL.Add('  SELECT COUNT(*) ');
  FQryUltimo24Fechamento.SQL.Add('  FROM FECCDM f2 ');
  FQryUltimo24Fechamento.SQL.Add('  WHERE f2.FEC_CODEMP = f1.FEC_CODEMP ');
  FQryUltimo24Fechamento.SQL.Add('    AND f2.FEC_DTAREF >= f1.FEC_DTAREF ');
  FQryUltimo24Fechamento.SQL.Add(') <= 24 ');
  FQryUltimo24Fechamento.SQL.Add('  AND EMP_EMPATI = "S" ');
  FQryUltimo24Fechamento.SQL.Add('ORDER BY f1.FEC_CODEMP, f1.FEC_DTAREF DESC ');
end;

procedure TFechamentoContabilDiaMes.pCarregaSqlUltimoFechamento;
begin
  FQryUltimoFechamento.Close;
  FQryUltimoFechamento.SQL.Clear;

  FQryUltimoFechamento.SQL.Add('SELECT F.*, C.CON_FECFIN, EMP_NOMEMP AS NOMEMP ');
  FQryUltimoFechamento.SQL.Add('FROM FECCDM F ');
  FQryUltimoFechamento.SQL.Add('INNER JOIN CADEMP ON EMP_CODEMP = FEC_CODEMP AND EMP_EMPATI = "S" ');
  FQryUltimoFechamento.SQL.Add('INNER JOIN (  ');
  FQryUltimoFechamento.SQL.Add('  SELECT FEC_CODEMP, MAX(FEC_DTAREF) AS FEC_DTAREF  ');
  FQryUltimoFechamento.SQL.Add('  FROM FECCDM  ');
  FQryUltimoFechamento.SQL.Add('  GROUP BY FEC_CODEMP ');
  FQryUltimoFechamento.SQL.Add(') AS M ON M.FEC_CODEMP = F.FEC_CODEMP AND M.FEC_DTAREF = F.FEC_DTAREF ');
  FQryUltimoFechamento.SQL.Add('LEFT JOIN ( ');
  FQryUltimoFechamento.SQL.Add('  SELECT SUBSTR(EMP_C_G_C_,1,8) AS RAIZ, MAX(CON_FECFIN) AS CON_FECFIN  ');
  FQryUltimoFechamento.SQL.Add('  FROM FECCON ');
  FQryUltimoFechamento.SQL.Add('  INNER JOIN CADEMP ON EMP_CODEMP = CON_CODEMP ');
  FQryUltimoFechamento.SQL.Add('  GROUP BY RAIZ ');
  FQryUltimoFechamento.SQL.Add(') AS C ON C.RAIZ = SUBSTR(EMP_C_G_C_,1,8) ');
end;

procedure TFechamentoContabilDiaMes.pExcluirFechamentoInterno(
  const AstrCodEmp: String; const ADtaRef: TDate);
var
  Lqry: TUniQuery;
begin
  Lqry := fCriaQueryContabilidade('FECCDM', FstrNomeFormulario, nil, nil, True);
  try
    Lqry.SQL.Text := 'SELECT * FROM FECCDM WHERE FEC_DTAREF = :DTAREF AND FEC_CODEMP = :CODEMP ';
    Lqry.ParamByName('DTAREF').AsDate := ADtaRef;
    Lqry.ParamByName('CODEMP').AsString := AstrCodEmp;
    Lqry.Open;
    while not Lqry.IsEmpty do
    begin
      Lqry.Delete;
    end;
  finally
    FreeAndNil(Lqry);
  end;

end;

procedure TFechamentoContabilDiaMes.pIncluirFechamentoInterno(
  const AstrCodEmp: String; const ADtaRef: TDate;
  const AblnRaiz: Boolean);
var
  Lqry: TUniQuery;
  LdtaUltFec: TDate;
begin
  LdtaUltFec := fGetDataUltimoFechamento(AstrCodEmp);

  if ADtaRef <= 0 then
    raise TFechamentoInclusaoException.Create('Data de fechamento inválida!');

  if LdtaUltFec >= ADtaRef then
    raise TFechamentoInclusaoException.Create('O fechamento sugerido para a empresa ' +AstrCodEmp+
      ' deve ser maior que o último fechamento realizado (' + FormatDateTime('DD/MM/YYYY', LdtaUltFec) + ')!');

  try
    try
      Lqry := fCriaQueryContabilidade('FECCDM', FstrNomeFormulario, nil, nil, True);
      Lqry.SQL.Text := 'SELECT * FROM FECCDM WHERE FALSE';
      Lqry.Open;
      Lqry.Insert;
      Lqry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FECCDM', AstrCodEmp);
      Lqry.FieldByName('FEC_CODEMP').AsString := AstrCodEmp;
      Lqry.FieldByName('FEC_CODOPE').AsString := strLoginUsuarioLogado;
      Lqry.FieldByName('FEC_DTAREF').AsDateTime := ADtaRef;
      Lqry.FieldByName('FEC_DTAFEC').AsDateTime := fNow;
      Lqry.FieldByName('FEC_HORFEC').AsDateTime := fTime;
      Lqry.Post;
    except
      on E: Exception do
        raise TFechamentoInclusaoException.Create('Erro ao incluir fechamento para a empresa ' +AstrCodEmp+ ': ' + E.Message);
    end;
  finally
    FreeAndNil(Lqry);
  end;
end;

{ TVerificaFechamentoDiaMes }

class function TVerificaFechamentoDiaMes.fTemFechamento(const AdtaIni, AdtaFin: TDate;
  const AarrEmp: TConsultasArray; const AblnVerifAdcLancon: Boolean = False;
  const ATiposContabeis: TSetTiposContabeis = []): Boolean;
var
  LdictUltFecEmp: TDictFecEmp;
  LlstFecEmp: TStringList;
begin
  if not fTabelaExiste('FECCDM') then
  begin
    Result := False;
    Exit;
  end;

  LlstFecEmp := TStringList.Create;
  LdictUltFecEmp := fCarregaUltimoFechamentoEmpresas;
  try
    if not fAlgumaEmpresaTemFechamento(LdictUltFecEmp) then
    begin
      Result := False;
      Exit;
    end;

    if fAlgumaEmpresaArrFechadaPerido(AdtaIni, AarrEmp, LdictUltFecEmp, LlstFecEmp) then
    begin
      fMensagem('ATENÇÃO!', 'Existe um fechamento dia/mês travando o periodo desta movimentação para ' + fstrEmpresas(LlstFecEmp), ['&OK']);
      Result := True;
      Exit;
    end;

    if not AblnVerifAdcLancon then
    begin
      Result := False;
      Exit;
    end;

    Result := False;
    if (AblnVerifAdcLancon) and (ATiposContabeis = []) then
      raise Exception.Create('Quando AblnVerifAdcLancon=True, ATiposContabeis deve ser informado!');

    Result := fTemLancon(AdtaIni, AdtaFin, AarrEmp, LlstFecEmp, ATiposContabeis);
  finally
    FreeAndNil(LdictUltFecEmp);
    FreeAndNil(LlstFecEmp);
  end;

end;

class function TVerificaFechamentoDiaMes.fTemFechamento(const AdtaIni,
  AdtaFin: TDate; const AstrCodEmp: string;
  const AblnVerifAdcLancon: Boolean; const ATiposContabeis: TSetTiposContabeis): Boolean;
var
  LarrEmp: TConsultasArray ;
begin
  LarrEmp := fstrCodEmpToArr(AstrCodEmp);

  Result := Self.fTemFechamento(AdtaIni, AdtaFin, LarrEmp, AblnVerifAdcLancon, ATiposContabeis);
end;

function TVerificaFechamentoDiaMes.fTemFechamentoTValida(const AdtaIni,
  AdtaFin: TDate; const AstrCodEmp: string; var AstrMsg: string): Boolean;
begin
  AstrMsg := '';

  if not FblnTabelaExiste then
  begin
    Result := True;
    Exit;
  end;

  if not FblnAlgumaEmpFec then
  begin
    Result := True;
    Exit;
  end;

  if fAlgumaEmpresaArrFechadaPerido(AdtaIni, fstrCodEmpToArr(AstrCodEmp), FDictFecEmp, FlstCodEmp) then
  begin
    AstrMsg := 'Existe um fechamento dia/mês travando o periodo desta movimentação para ' + fstrEmpresas(FlstCodEmp);
    Result := True;
    Exit;
  end;

  Result := False;
end;

class function TVerificaFechamentoDiaMes.fTemLancon(const AdtaIni, AdtaFin: TDate;
  const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList;
  const ATiposContabeis: TSetTiposContabeis): Boolean;
var
  LblnDtaBan: Boolean;
  LTipoContabil: TTiposContabeis;
  LqryLan: TUniQuery;
begin
  //LANCON GENERICO não é necessário pois seria redundante a fAlgumaEmpresaArrFechadaPerido

  for LTipoContabil in ATiposContabeis do
  begin
    if LTipoContabil <> tcCTR then
    begin
      LqryLan := fCriaQuery(nil);
      try
        if fTemLancntGenerico(AdtaIni, AdtaFin, AarrEmp, AlstFecEmp, LTipoContabil, LqryLan) then
        begin
          If fMensagem('ATENÇÃO!', 'Não é possível realizar a operação, a movimentação impactaria registros de períodos que já estão fechados (LANCNT) para ' + fstrEmpresas(AlstFecEmp) + #13#10 + 'Deseja visualizar os lançamentos?', ['&Sim', '&Não']) = 1 Then
          Begin
            if LqryLan.Active then
              pMostraLancamentos(LqryLan)
            else fMensagem('ATENÇÃO!', 'Não foi possível mostrar os lançamentos. Tente novamente!', ['&OK']);
          End;
          Result := True;
          Exit;
        end;
      finally
        FreeAndNil(LqryLan);
      end;
    end
    else // ctr
    begin
      LblnDtaBan := fCampoExiste('CADREC', 'CTR_DTABAN');

      LqryLan := fCriaQuery(nil);
      try
        if fTemLanconCTR(AdtaIni, AdtaFin, AarrEmp, AlstFecEmp, LblnDtaBan, LqryLan) then
        begin
          If fMensagem('ATENÇÃO!', 'Não é possível realizar a operação, a movimentação impactaria registros de períodos que já estão fechados (CTR) para ' + fstrEmpresas(AlstFecEmp) + #13#10 + 'Deseja visualizar os lançamentos?', ['&Sim', '&Não']) = 1 Then
          Begin
            if LqryLan.Active then
              pMostraLancamentos(LqryLan)
            else fMensagem('ATENÇÃO!', 'Não foi possível mostrar os lançamentos. Tente novamente!', ['&OK']);
          End;
          Result := True;
          Exit;
        end;
      finally
        FreeAndNil(LqryLan);
      end;

      LqryLan := fCriaQuery(nil);
      try
        if fTemLancntCTR(AdtaIni, AdtaFin, AarrEmp, AlstFecEmp, LblnDtaBan, LqryLan) then
        begin
          If fMensagem('ATENÇÃO!', 'Não é possível realizar a operação, a movimentação impactaria registros de períodos que já estão fechados (CTR/LANCNT) para ' + fstrEmpresas(AlstFecEmp) + #13#10 + 'Deseja visualizar os lançamentos?', ['&Sim', '&Não']) = 1 Then
          Begin
            if LqryLan.Active then
              pMostraLancamentos(LqryLan)
            else fMensagem('ATENÇÃO!', 'Não foi possível mostrar os lançamentos. Tente novamente!', ['&OK']);
          End;
          Result := True;
          Exit;
        end;
      finally
        FreeAndNil(LqryLan);
      end;

    end ;
  end ;

  Result := False;
end;

class function TVerificaFechamentoDiaMes.fTemLanconCTR(const AdtaIni, AdtaFin: TDate;
  const AarrEmp: TConsultasArray; var AlstFecEmp: TStringList; const AblnDtaBan: Boolean; Const AqryLan: TUniQuery): Boolean;
var
  LstrFiltroEmp, LstrFiltroCCO, LstrAuxEmp: string;
begin
  AlstFecEmp.Clear;
  LstrFiltroEmp := fstrFiltroEmpresas(AarrEmp);
  LstrFiltroCCO := '  AND (NOT ' + TLanConCTR.fFiltroCCOriginadoAdt(AblnDtaBan) +') ';

  try
    AqryLan.SQL.Add('SELECT * FROM ( ');

    if not AblnDtaBan then
    begin
      AqryLan.SQL.Add('SELECT LANCON.* ');
      AqryLan.SQL.Add('FROM LANCON ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      AqryLan.SQL.Add('WHERE CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
    end
    else
    begin
      AqryLan.SQL.Add('SELECT LANCON.* ');
      AqryLan.SQL.Add('FROM LANCON ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      AqryLan.SQL.Add('WHERE CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN ');

      AqryLan.SQL.Add('UNION ');

      AqryLan.SQL.Add('SELECT LANCON.* ');
      AqryLan.SQL.Add('FROM LANCON ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON LANCON.CON_INCDOC = CADREC.AUTOINCREM ');
      AqryLan.SQL.Add('WHERE CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
      AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN IS NULL ');
    end;
    AqryLan.SQL.Add(') LANCON ');
    AqryLan.SQL.Add('INNER JOIN ('+ SQL_ULT_FEC_EMPRESAS +') FECCDM ON TRUE ');
    AqryLan.SQL.Add('  AND FECCDM.EMP_CODEMP = LANCON.CON_EMPLAN ');
    AqryLan.SQL.Add('  AND FECCDM.FEC_DTAREF >= LANCON.CON_DTALAN ');
    AqryLan.SQL.Add('ORDER BY CON_EMPLAN ');

    if AdtaIni > 0 then
    begin
      AqryLan.ParamByName('DTAINI').AsDate := AdtaIni;
      AqryLan.ParamByName('DTAFIN').AsDate := AdtaFin;
    end;

    AqryLan.Open;

    LstrAuxEmp := '';
    while not AqryLan.Eof do
    begin
      if AqryLan.FieldByName('CON_EMPLAN').AsString = LstrAuxEmp then
      begin
        AqryLan.Next;
        Continue;
      end ;

      LstrAuxEmp := AqryLan.FieldByName('CON_EMPLAN').AsString;

      AlstFecEmp.Add(LstrAuxEmp);

      AqryLan.Next;
    end;
  except
    On E: Exception do
    Begin
      fMensagem('ATENÇÃO!', 'Erro na rotina fTemLanconCTR que procura por lançamentos (CTR) no período selecionado. Erro: ' + E.message, ['&OK']);
      Result := True;
      Exit;
    End;
  end;

  Result := not AqryLan.IsEmpty;
end;

class function TVerificaFechamentoDiaMes.fTemLancntCTR(const AdtaIni,
  AdtaFin: TDate; const AarrEmp: TConsultasArray;
  var AlstFecEmp: TStringList; const AblnDtaBan: Boolean; Const AqryLan: TUniQuery): Boolean;
var
  LstrFiltroEmp, LstrFiltroCCO, LstrAuxEmp: string;
begin
  AlstFecEmp.Clear;

  LstrFiltroEmp := fstrFiltroEmpresas(AarrEmp, 'L1');
  LstrFiltroCCO := '  AND (NOT ' + TLanConCTR.fFiltroCCOriginadoAdt(AblnDtaBan, 'L1') +') ';

  try
    AqryLan.SQL.Add('SELECT * FROM ( ');
    if not AblnDtaBan then
    begin
      //SEM DTABAN, ORIGEM -> CONTRO
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_ORIGEM = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_CONTRO ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');

      AqryLan.SQL.Add('UNION ');

      //SEM DTABAN, CONTRO -> ORIGEM
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_CONTRO = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_ORIGEM ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
    end
    else
    begin
      //DTABAN, ORIGEM -> CONTRO
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_ORIGEM = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_CONTRO ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN ');

      AqryLan.SQL.Add('UNION ');

      //DTABAN, CONTRO -> ORIGEM
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_CONTRO = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_ORIGEM ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN BETWEEN :DTAINI AND :DTAFIN ');

      AqryLan.SQL.Add('UNION ');

      //DTAREC, ORIGEM -> CONTRO
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_ORIGEM = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_CONTRO ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
      AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN IS NULL ');

      AqryLan.SQL.Add('UNION ');

      //DTAREC, CONTRO -> ORIGEM
      AqryLan.SQL.Add('SELECT L2.* ');
      AqryLan.SQL.Add('FROM LANCON L1 ');
      AqryLan.SQL.Add('INNER JOIN LANCNT ON LANCNT.CNT_CONTRO = L1.AUTOINCREM ');
      AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_ORIGEM ');
      AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
      AqryLan.SQL.Add('WHERE L1.CON_TIPLAN = "CTR" ');
      AqryLan.SQL.Add(LstrFiltroCCO);
      AqryLan.SQL.Add(LstrFiltroEmp);
      if AdtaIni > 0 then
        AqryLan.SQL.Add('  AND CADREC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ');
      AqryLan.SQL.Add('  AND CADREC.CTR_DTABAN IS NULL ');
    end;

    AqryLan.SQL.Add(') LANCON ');
    AqryLan.SQL.Add('INNER JOIN ('+ SQL_ULT_FEC_EMPRESAS +') FECCDM ON TRUE ');
    AqryLan.SQL.Add('  AND FECCDM.EMP_CODEMP = LANCON.CON_EMPLAN ');
    AqryLan.SQL.Add('  AND FECCDM.FEC_DTAREF >= LANCON.CON_DTALAN ');
    AqryLan.SQL.Add('ORDER BY CON_EMPLAN ');

    if AdtaIni > 0 then
    begin
      AqryLan.ParamByName('DTAINI').AsDate := AdtaIni;
      AqryLan.ParamByName('DTAFIN').AsDate := AdtaFin;
    end;

    AqryLan.Open;

    LstrAuxEmp := '';
    while not AqryLan.Eof do
    begin
      if AqryLan.FieldByName('CON_EMPLAN').AsString = LstrAuxEmp then
      begin
        AqryLan.Next;
        Continue;
      end ;

      LstrAuxEmp := AqryLan.FieldByName('CON_EMPLAN').AsString;

      AlstFecEmp.Add(LstrAuxEmp);

      AqryLan.Next;
    end;
  except
    On E: Exception do
    Begin
      fMensagem('ATENÇÃO!', 'Erro na rotina fTemLancntCTR que procura por lançamentos (CTR/LANCNT) no período selecionado. Erro: ' + E.message, ['&OK']);
      Result := True;
      Exit;
    End;
  end;

  Result := not AqryLan.IsEmpty;
end;

class procedure TVerificaFechamentoDiaMes.pMostraLancamentos(var AqryLan: TUniQuery);
begin
  pMostraLancamentosContabeis(TDataset(AqryLan), 'Lançamentos contábeis travados pelo Fechamento Dia/Mês');
end;

class function TVerificaFechamentoDiaMes.fTemLancntGenerico(
  const AdtaIni, AdtaFin: TDate; const AarrEmp: TConsultasArray;
  var AlstFecEmp: TStringList; const ATipoContabil: TTiposContabeis; Const AqryLan: TUniQuery): Boolean;
var
  LstrFiltroEmp, LstrAuxEmp: string;
  LTipoContabil: String;
begin
  LTipoContabil := DES_CONTABIL_SIGLA[ATipoContabil] ;

  AlstFecEmp.Clear;
  LstrFiltroEmp := fstrFiltroEmpresas(AarrEmp, 'L1');

  try
    AqryLan.SQL.Add('SELECT * FROM ( ');

    AqryLan.SQL.Add('SELECT L2.* ');
    AqryLan.SQL.Add('FROM LANCON L1 ');
    AqryLan.SQL.Add('INNER JOIN LANCNT ON L1.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_CONTRO');
    AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
    AqryLan.SQL.Add('WHERE TRUE AND L1.CON_TIPLAN = :TIPLAN ');
    AqryLan.SQL.Add(LstrFiltroEmp);
    if AdtaIni > 0 then
      AqryLan.SQL.Add('  AND L1.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    AqryLan.SQL.Add('UNION ');

    AqryLan.SQL.Add('SELECT L2.* ');
    AqryLan.SQL.Add('FROM LANCON L1 ');
    AqryLan.SQL.Add('INNER JOIN LANCNT ON L1.AUTOINCREM = LANCNT.CNT_CONTRO ');
    AqryLan.SQL.Add('INNER JOIN LANCON L2 ON L2.AUTOINCREM = LANCNT.CNT_ORIGEM ');
    AqryLan.SQL.Add('INNER JOIN CADREC ON CADREC.AUTOINCREM = L2.CON_INCDOC ');
    AqryLan.SQL.Add('WHERE TRUE AND L1.CON_TIPLAN = :TIPLAN ');
    AqryLan.SQL.Add(LstrFiltroEmp);
    if AdtaIni > 0 then
      AqryLan.SQL.Add('  AND L1.CON_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    AqryLan.SQL.Add(') LANCON ');
    AqryLan.SQL.Add('INNER JOIN ('+ SQL_ULT_FEC_EMPRESAS +') FECCDM ON TRUE');
    AqryLan.SQL.Add('  AND FECCDM.EMP_CODEMP = LANCON.CON_EMPLAN ');
    AqryLan.SQL.Add('  AND FECCDM.FEC_DTAREF >= LANCON.CON_DTALAN ');
    AqryLan.SQL.Add('ORDER BY LANCON.CON_EMPLAN ');
    AqryLan.ParamByName('TIPLAN').AsString := LTipoContabil;


    if AdtaIni > 0 then
    begin
      AqryLan.ParamByName('DTAINI').AsDate := AdtaIni;
      AqryLan.ParamByName('DTAFIN').AsDate := AdtaFin;
    end;

    AqryLan.Open;

    LstrAuxEmp := '';
    while not AqryLan.Eof do
    begin
      if AqryLan.FieldByName('CON_EMPLAN').AsString = LstrAuxEmp then
      Begin
        AqryLan.Next;
        Continue;
      End;

      LstrAuxEmp := AqryLan.FieldByName('CON_EMPLAN').AsString;

      AlstFecEmp.Add(LstrAuxEmp);

      AqryLan.Next;
    end;
  except
    On E: Exception do
    Begin
      fMensagem('ATENÇÃO!', 'Erro na rotina fTemLancntGenerico que procura por lançamentos (LANCNT) no período selecionado. Erro: ' + E.message , ['&OK']);
      Result := True;
      Exit;
    End;
  end;

  Result := not AqryLan.IsEmpty;
end;

class function TVerificaFechamentoDiaMes.fAlgumaEmpresaTemFechamento(Adict: TDictFecEmp): Boolean;
var
  LPair: TPair<String, TDate>;
begin
  Result := False;
  for LPair in Adict do
  begin
    Result := LPair.Value <> 0;

    if Result then
      break;
  end;
end;

constructor TVerificaFechamentoDiaMes.Create;
begin
  FblnTabelaExiste := fTabelaExiste('FECCDM');
  if FblnTabelaExiste then
  begin
    FDictFecEmp := fCarregaUltimoFechamentoEmpresas;
    FblnAlgumaEmpFec := fAlgumaEmpresaTemFechamento(FDictFecEmp);
    FlstCodEmp := TStringList.Create;
  end
  else
  begin
    FDictFecEmp := nil;
    FblnAlgumaEmpFec := False;
    FlstCodEmp := nil;
  end;

end;

destructor TVerificaFechamentoDiaMes.Destroy;
begin
  if Assigned(FDictFecEmp) then
    FreeandNil(FDictFecEmp);
  if Assigned(FlstCodEmp) then
    FreeAndNil(FlstCodEmp);
  inherited;
end;

class function TVerificaFechamentoDiaMes.fAlgumaEmpresaArrFechadaPerido(
  const AdtaIni: TDate; const AarrEmp: TConsultasArray;
  var AdictFecEmp: TDictFecEmp; var AlstEmp: TStringList): Boolean;
var
  LintCount: Integer;
  LPair: TPair<String, TDate>;
  Ldtafec: TDate;
begin
  Result := False;
  AlstEmp.Clear;

  if fArrTodasEmpresas(AarrEmp) then
  begin
    for LPair in AdictFecEmp do
    begin
      if LPair.Value = 0 then
        continue;

      if LPair.Value >= AdtaIni then
      begin
        Result := True;
        AlstEmp.Add(LPair.Key);
      end;
    end;
  end
  else
  begin
    for LintCount := Low(AarrEmp) to High(AarrEmp) do
    begin
      if AarrEmp[LintCount].strCodigo.Trim = '' then
        continue;

      if not AdictFecemp.TryGetValue(AarrEmp[LintCount].strCodigo, Ldtafec) then
        Ldtafec := 0;

      if Ldtafec = 0 then
        continue;

      if Ldtafec >= AdtaIni then
      begin
        Result := True;
        AlstEmp.Add(AarrEmp[LintCount].strCodigo);
      end;
    end;
  end;
end;

class function TVerificaFechamentoDiaMes.fstrCodEmpToArr(
  const AstrCodEmp: string): TConsultasArray;
var
  LreqEmpresa: TConsultas ;
begin
  FillChar(LreqEmpresa, SizeOf(LreqEmpresa), #0);
  LreqEmpresa.strCodigo := AstrCodEmp;
  SetLength(Result, 1);
  Result[0] := LreqEmpresa ;
end;

class function TVerificaFechamentoDiaMes.fstrEmpresas(Astrs: TStrings): string;
var
  Lstr: string;
begin
  Result := '';
  for Lstr in Astrs do
  begin
    if Result <> '' then
      Result := Result + ', ';

    Result := Result + Lstr;
  end;

  if Astrs.Count = 1 then
    Result := 'a Empresa: ' + Result + '.'
  else
    Result := 'as Empresas: ' + Result + '.'
end;

class function TVerificaFechamentoDiaMes.fstrFiltroEmpresas(
  const AarrEmp: TConsultasArray; const AstrAlias: string = ''): string;
var
  LintCount: Integer;
begin
  if fArrTodasEmpresas(AarrEmp) then
    Result := ''
  else if fArrEmpLength(AarrEmp) = 1 then
  begin
    Result := 'AND ' + IfThen(AstrAlias <> '', AstrAlias + '.') + 'CON_EMPLAN = "' +  AarrEmp[0].strCodigo + '" '
  end
  else
  begin
    Result := '';
    for LintCount := Low(AarrEmp) to High(AarrEmp) do
    begin
      if Result <> '' then
        Result := Result + ', ';
      Result := Result + '"' + AarrEmp[LintCount].strCodigo + '"';
    end;

    Result := ' AND ' + IfThen(AstrAlias <> '', AstrAlias + '.') + 'CON_EMPLAN IN ( ' + Result + ')';
  end;
end;

class function TVerificaFechamentoDiaMes.fArrEmpLength(
  const AarrEmp: TConsultasArray): Integer;
var
  LintCount: integer;
begin
  Result := 0;
  for LintCount := Low(AarrEmp) to High(AarrEmp) do
    if AarrEmp[LintCount].strCodigo.Trim <> '' then
      Result := Result + 1;
end;

class function TVerificaFechamentoDiaMes.fArrTodasEmpresas(
  const AarrEmp: TConsultasArray): Boolean;
var
  LintLenArr: Integer;
begin
  LintLenArr := fArrEmpLength(AarrEmp);
  Result := (LintLenArr = 0) or ((LintLenArr = 1) and (AarrEmp[0].strCodigo = ''));
end;

class function TVerificaFechamentoDiaMes.fCarregaUltimoFechamentoEmpresas: TDictFecEmp;
var
  Lqry: TUniQuery;
  Ldta: TDate;
begin
  Result := TDictFecEmp.Create();

  Lqry := fCriaQuery(nil);
  try
    Lqry.SQL.Text := SQL_ULT_FEC_EMPRESAS;
    Lqry.Open;

    while not Lqry.Eof do
    begin
      try
        if Lqry.FieldByName('FEC_DTAREF').IsNull then
          Ldta := 0
        else
          Ldta := Lqry.FieldByName('FEC_DTAREF').AsDateTime;
      except
        Ldta := 0;
      end;

      Result.Add(Lqry.FieldByName('EMP_CODEMP').AsString, Ldta);

      Lqry.Next;
    end;
  finally
    FreeandNil(Lqry);
  end;
end;

end.
