unit Contabilidade.Classes.TListaValidacoesContabeis;

interface

uses
  Contabilidade.Interfaces, Data.DB, UniClientDataSet, System.Generics.Collections,
  Contabilidade.Model.Contabilizaveis, Uni;

type
  TListaValidacoesContabeis = class(TInterfacedObject, IListaValidacoesContabeis, IUpdateContaContabil)
  private
    FDataSet : TUniClientDataSet;
    listaContabilizaveis : TObjectList<TContabilizaveis>;
    FUpdateContaContabil : IUpdateContaContabil;
  public
    FSigla : String;
    constructor Create;
    destructor Destroy; override;
    function AddValidacao(const AValidacao: IValidaContaContabil): boolean ;
    function getDataSet: TUniClientDataSet;
    procedure setContaContabil(const AConta, AIncDoc: string);
  end;

  TPendenciaContabil = class
  private
    class var FblnTabelaVerificada: Boolean;
    class var FblnTabelaExiste: Boolean;
    class procedure pAddFiltroLista(AQuery: TUniQuery; const ACampo, APrefixo: string; const AarrValores: TArray<string>);
    class procedure pAddFiltroProcessados(AQuery: TUniQuery; const AstrCodEmp: string; const AarrSiglas: TArray<string>;
      AdsErros: TDataSet; const AblnCmvProcessado: Boolean);
  public
    class function fTabelaExiste: Boolean;
    // Devolve no formato de fCriarDataSetErros; quem chama libera. AdtaIni = 0: sem limite inicial.
    class function fListar(const AarrEmp, AarrTip: TArray<string>; const AdtaIni, AdtaFin: TDateTime): TUniClientDataSet;
    class function fExiste(const AarrEmp: TArray<string>; const AdtaFin: TDateTime): Boolean;
    // AstrTipLan: o tipo marcado na tela (CTR, ENT...), nao o ERR_TIPLAN do gerador.
    // AarrSiglas: as siglas geradas pelo tipo (CTR e CTR_ADT_CC...); so os erros delas entram.
    // AblnSomenteProcessados: so tira a pendencia de documento que ganhou LANCON ou voltou com erro.
    class procedure pSubstituir(const AstrCodEmp, AstrTipLan: string; const AarrSiglas: TArray<string>; const AdtaIni, AdtaFin: TDateTime; AdsErros: TDataSet;
      const AblnSomenteProcessados: Boolean = False; const AblnCmvProcessado: Boolean = False);
  end;

implementation

uses
  System.SysUtils, Contabilidade.Classes.TUpdateContaContabil,
  Contabilidade.Funcoes, Contabilidade.Classes.Helpers, untFuncoesSimples, System.StrUtils, System.Classes;

{ TListaValidacoesContabeis }

function TListaValidacoesContabeis.AddValidacao(
  const AValidacao: IValidaContaContabil): Boolean;
  var
    LField : TField;
    LContabilizavel : TContabilizaveis;
    LlistaContabilizaveis : TObjectList<TContabilizaveis>;
    dsValidacao : TDataSet ;
    LChavesErro: TDictionary<string, Byte>;
    LFieldChvDoc: TField;
    LIndice: Integer;
begin
  Result := True ;

  dsValidacao := AValidacao.DataSet ;

  dsValidacao.DisableControls ;
  FDataSet.DisableControls ;
  try
    dsValidacao.First;
    while not dsValidacao.Eof do
    begin
      FDataSet.Insert;

      for LField in dsValidacao.Fields do
        FDataSet.Fields[LField.Index].Value := LField.Value;

      FDataSet.Post;

      dsValidacao.Next;
    end;
  finally
    dsValidacao.EnableControls ;
    FDataSet.EnableControls ;
  end ;

  if not dsValidacao.IsEmpty then
    Result := False ;

  //adiciona os warnings somente para operador admin ou para outros usuários cujo tipo de movimento esteja pré determinado para mostrar
  if (fEhAdmContabilidade) Or (fMostrarWarningGeracaoMovimento(FSigla)) then
  begin
    dsValidacao := AValidacao.DataSetWarnings ;
    dsValidacao.DisableControls ;
    FDataSet.DisableControls ;
    try
      dsValidacao.First;
      while not dsValidacao.Eof do
      begin
        FDataSet.Insert;

        for LField in dsValidacao.Fields do
          FDataSet.Fields[LField.Index].Value := LField.Value;

        FDataSet.FieldByName('ERR_STATUS').AsString := 'GC' ;
        FDataSet.Post;

        dsValidacao.Next;
      end;
    finally
      dsValidacao.EnableControls ;
      FDataSet.EnableControls ;
    end ;
  end ;
  //

  LlistaContabilizaveis := AValidacao.getContabilizaveis;
  LChavesErro := TDictionary<string, Byte>.Create;
  FDataSet.DisableControls;
  try
    LFieldChvDoc := FDataSet.FieldByName('ERR_CHVDOC');
    FDataSet.First;
    while not FDataSet.Eof do
    begin
      LChavesErro.AddOrSetValue(LFieldChvDoc.AsString, 0);
      FDataSet.Next;
    end;

    for LIndice := LlistaContabilizaveis.Count - 1 downto 0 do
    begin
      LContabilizavel := LlistaContabilizaveis[LIndice];
      if LChavesErro.ContainsKey(LContabilizavel.IncDoc) then
      begin
        LlistaContabilizaveis.Extract(LContabilizavel); // sai sem Free
        listaContabilizaveis.Add(LContabilizavel);       // entra sob nova posse
      end;
    end;
  finally
    FDataSet.EnableControls;
    LChavesErro.Free;
  end;
end;

constructor TListaValidacoesContabeis.Create;
begin
  FDataSet := fCriarDataSetErros;
  listaContabilizaveis := TObjectList<TContabilizaveis>.Create;
  FUpdateContaContabil := TUpdateContaContabil.New(listaContabilizaveis);
end;

destructor TListaValidacoesContabeis.Destroy;
begin
  FreeAndNil(FDataSet);
  FreeAndNil(listaContabilizaveis);
  inherited;
end;

function TListaValidacoesContabeis.getDataSet: TUniClientDataSet;
begin
  Result := FDataSet;
end;

procedure TListaValidacoesContabeis.setContaContabil(const AConta,
  AIncDoc: string);
begin
  FUpdateContaContabil.setContaContabil(AConta, AIncDoc);
end;

{ TPendenciaContabil }

class function TPendenciaContabil.fTabelaExiste: Boolean;
begin
  // Versoes que recebem o modulo antes do script da CONPEN seguem no comportamento antigo.
  // Verificada uma vez por execucao: o fTabelaExiste com cache nao existe em todas as versoes que usam o modulo.
  if not FblnTabelaVerificada then
  begin
    FblnTabelaExiste := untFuncoesSimples.fTabelaExiste('CONPEN');
    FblnTabelaVerificada := True;
  end;
  Result := FblnTabelaExiste;
end;

class procedure TPendenciaContabil.pAddFiltroLista(AQuery: TUniQuery; const ACampo, APrefixo: string;
  const AarrValores: TArray<string>);
var
  LintCnt: Integer;
  LstrParams: string;
begin
  if Length(AarrValores) = 0 then
    Exit;

  LstrParams := '';
  for LintCnt := 0 to High(AarrValores) do
    LstrParams := LstrParams + IfThen(LstrParams = '', '', ', ') + ':' + APrefixo + IntToStr(LintCnt);

  AQuery.SQL.Add('   AND ' + ACampo + ' IN (' + LstrParams + ') ');

  for LintCnt := 0 to High(AarrValores) do
    AQuery.ParamByName(APrefixo + IntToStr(LintCnt)).AsString := AarrValores[LintCnt];
end;

class function TPendenciaContabil.fListar(const AarrEmp, AarrTip: TArray<string>; const AdtaIni,
  AdtaFin: TDateTime): TUniClientDataSet;
var
  LqryPen: TUniQuery;
begin
  Result := fCriarDataSetErros;
  try
    if not fTabelaExiste then
      Exit;

    LqryPen := fCriaQuery;
    try
      LqryPen.SQL.Add(' SELECT PEN_CODEMP, PEN_SIGLA, PEN_TIPERR, PEN_TABELA, PEN_CHVDOC, PEN_DTALAN, PEN_MOTIVO, ');
      LqryPen.SQL.Add('        PEN_HISTOR, PEN_DESVAL, PEN_NATOPE, PEN_ORIPLA, PEN_PLANCO ');
      LqryPen.SQL.Add('   FROM CONPEN ');
      LqryPen.SQL.Add('  WHERE PEN_DTALAN <= :DTAFIN ');
      if AdtaIni > 0 then
        LqryPen.SQL.Add('   AND PEN_DTALAN >= :DTAINI ');
      pAddFiltroLista(LqryPen, 'PEN_CODEMP', 'EMP', AarrEmp);
      pAddFiltroLista(LqryPen, 'PEN_TIPLAN', 'TIP', AarrTip);
      LqryPen.SQL.Add('  ORDER BY PEN_CODEMP, PEN_DTALAN, PEN_CHVDOC ');

      LqryPen.ParamByName('DTAFIN').AsDate := AdtaFin;
      if AdtaIni > 0 then
        LqryPen.ParamByName('DTAINI').AsDate := AdtaIni;
      LqryPen.Open;

      Result.DisableControls;
      try
        while not LqryPen.Eof do
        begin
          Result.Insert;
          Result.FieldByName('ERR_STATUS').AsString := 'EE';
          Result.FieldByName('ERR_MOTIVO').AsString := LqryPen.FieldByName('PEN_MOTIVO').AsString;
          Result.FieldByName('ERR_HISTOR').AsString := LqryPen.FieldByName('PEN_HISTOR').AsString;
          Result.FieldByName('ERR_TIPLAN').AsString := LqryPen.FieldByName('PEN_TIPERR').AsString;
          Result.FieldByName('ERR_DESVAL').AsString := LqryPen.FieldByName('PEN_DESVAL').AsString;
          Result.FieldByName('ERR_NATOPE').AsString := LqryPen.FieldByName('PEN_NATOPE').AsString;
          Result.FieldByName('ERR_ORIPLA').AsString := LqryPen.FieldByName('PEN_ORIPLA').AsString;
          Result.FieldByName('ERR_CHVDOC').AsString := LqryPen.FieldByName('PEN_CHVDOC').AsString;
          Result.FieldByName('ERR_TABELA').AsString := LqryPen.FieldByName('PEN_TABELA').AsString;
          Result.FieldByName('ERR_PLANCO').AsString := LqryPen.FieldByName('PEN_PLANCO').AsString;
          Result.FieldByName('ERR_WARNIN').AsString := 'N';
          Result.FieldByName('ERR_CODEMP').AsString := LqryPen.FieldByName('PEN_CODEMP').AsString;
          Result.FieldByName('ERR_DTALAN').AsDateTime := LqryPen.FieldByName('PEN_DTALAN').AsDateTime;
          Result.FieldByName('ERR_SIGLA').AsString := LqryPen.FieldByName('PEN_SIGLA').AsString;
          Result.Post;
          LqryPen.Next;
        end;
        Result.First;
      finally
        Result.EnableControls;
      end;
    finally
      FreeAndNil(LqryPen);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

class function TPendenciaContabil.fExiste(const AarrEmp: TArray<string>; const AdtaFin: TDateTime): Boolean;
var
  LqryPen: TUniQuery;
begin
  Result := False;
  if not fTabelaExiste then
    Exit;

  LqryPen := fCriaQuery;
  try
    LqryPen.SQL.Add(' SELECT AUTOINCREM ');
    LqryPen.SQL.Add('   FROM CONPEN ');
    LqryPen.SQL.Add('  WHERE PEN_DTALAN <= :DTAFIN ');
    pAddFiltroLista(LqryPen, 'PEN_CODEMP', 'EMP', AarrEmp);
    LqryPen.SQL.Add('  LIMIT 1 ');
    LqryPen.ParamByName('DTAFIN').AsDate := AdtaFin;
    LqryPen.Open;
    Result := not LqryPen.IsEmpty;
  finally
    FreeAndNil(LqryPen);
  end;
end;

class procedure TPendenciaContabil.pAddFiltroProcessados(AQuery: TUniQuery; const AstrCodEmp: string;
  const AarrSiglas: TArray<string>; AdsErros: TDataSet; const AblnCmvProcessado: Boolean);
var
  LlstChavesErro: TStringList;
  LstrParams: string;
  LintCnt: Integer;
begin
  AQuery.SQL.Add('    AND ( EXISTS (SELECT 1 FROM LANCON L ');
  AQuery.SQL.Add('                   WHERE L.CON_INCDOC = P.PEN_CHVDOC AND L.CON_AUTOMA = 1 ');
  AQuery.SQL.Add('                     AND (P.PEN_SIGLA IN (''CTP'', ''PCP'') OR IFNULL(L.CON_TABELA, '''') = P.PEN_TABELA)) ');
  if AblnCmvProcessado then
    AQuery.SQL.Add('       OR P.PEN_SIGLA = ''CMV'' ');

  LlstChavesErro := TStringList.Create;
  try
    LlstChavesErro.Sorted := True;
    LlstChavesErro.Duplicates := dupIgnore;
    if Assigned(AdsErros) then
    begin
      AdsErros.First;
      while not AdsErros.Eof do
      begin
        if (AdsErros.FieldByName('ERR_STATUS').AsString = 'EE') and
           ((AstrCodEmp = '') or (AdsErros.FieldByName('ERR_CODEMP').AsString = AstrCodEmp)) and
           (IndexText(AdsErros.FieldByName('ERR_SIGLA').AsString, AarrSiglas) >= 0) then
          LlstChavesErro.Add(AdsErros.FieldByName('ERR_CHVDOC').AsString + '|' + AdsErros.FieldByName('ERR_TABELA').AsString);
        AdsErros.Next;
      end;
    end;

    LstrParams := '';
    for LintCnt := 0 to LlstChavesErro.Count - 1 do
      LstrParams := LstrParams + IfThen(LstrParams = '', '', ', ') + ':ERR' + IntToStr(LintCnt);
    if LstrParams <> '' then
      AQuery.SQL.Add('       OR CONCAT(P.PEN_CHVDOC, ''|'', P.PEN_TABELA) IN (' + LstrParams + ') ');
    AQuery.SQL.Add('    ) ');

    for LintCnt := 0 to LlstChavesErro.Count - 1 do
      AQuery.ParamByName('ERR' + IntToStr(LintCnt)).AsString := LlstChavesErro[LintCnt];
  finally
    FreeAndNil(LlstChavesErro);
  end;
end;

class procedure TPendenciaContabil.pSubstituir(const AstrCodEmp, AstrTipLan: string; const AarrSiglas: TArray<string>;
  const AdtaIni, AdtaFin: TDateTime; AdsErros: TDataSet; const AblnSomenteProcessados: Boolean = False;
  const AblnCmvProcessado: Boolean = False);
var
  LqryPen: TUniQuery;
  LdtaLan: TDateTime;
  LdtaGer: TDateTime;
begin
  if not fTabelaExiste then
    Exit;

  LdtaGer := fNow;
  LqryPen := fCriaQuery;
  try
    fStartTransaction;
    try
      // Geracao normal: o escopo e o mesmo que a geracao regerou, e documento que nao voltou com erro sai.
      // Reprocesso: o filtro por documento pode nao recarregar um pendente (chave que nao casa com a
      // coluna do filtro); sem confirmar, a pendencia sumiria sem o documento ter sido contabilizado.
      // Por isso so sai quem ganhou LANCON, quem voltou com erro (regravado abaixo) e o CMV regerado.
      LqryPen.SQL.Add(' DELETE P FROM CONPEN P ');
      LqryPen.SQL.Add('  WHERE P.PEN_TIPLAN = :TIPLAN ');
      LqryPen.SQL.Add('    AND P.PEN_DTALAN BETWEEN :DTAINI AND :DTAFIN ');
      // Empresa vazia: a geracao foi de todas as empresas e regerou o periodo de todas.
      if AstrCodEmp <> '' then
        LqryPen.SQL.Add('    AND P.PEN_CODEMP = :CODEMP ');
      if AblnSomenteProcessados then
        pAddFiltroProcessados(LqryPen, AstrCodEmp, AarrSiglas, AdsErros, AblnCmvProcessado);
      if AstrCodEmp <> '' then
        LqryPen.ParamByName('CODEMP').AsString := AstrCodEmp;
      LqryPen.ParamByName('TIPLAN').AsString := AstrTipLan;
      LqryPen.ParamByName('DTAINI').AsDate := AdtaIni;
      LqryPen.ParamByName('DTAFIN').AsDate := AdtaFin;
      LqryPen.ExecSQL;

      if Assigned(AdsErros) and (not AdsErros.IsEmpty) then
      begin
        LqryPen.SQL.Clear;
        LqryPen.SQL.Add(' INSERT INTO CONPEN (PEN_CODEMP, PEN_TIPLAN, PEN_SIGLA, PEN_TIPERR, PEN_TABELA, PEN_CHVDOC, PEN_DTALAN, ');
        LqryPen.SQL.Add('                     PEN_MOTIVO, PEN_HISTOR, PEN_DESVAL, PEN_NATOPE, PEN_ORIPLA, PEN_PLANCO, ');
        LqryPen.SQL.Add('                     PEN_CODOPE, PEN_DTAGER) ');
        LqryPen.SQL.Add(' VALUES (:CODEMP, :TIPLAN, :SIGLA, :TIPERR, :TABELA, :CHVDOC, :DTALAN, ');
        LqryPen.SQL.Add('         :MOTIVO, :HISTOR, :DESVAL, :NATOPE, :ORIPLA, :PLANCO, ');
        LqryPen.SQL.Add('         :CODOPE, :DTAGER) ');

        AdsErros.DisableControls;
        try
          AdsErros.First;
          while not AdsErros.Eof do
          begin
            if (AdsErros.FieldByName('ERR_STATUS').AsString = 'EE') and
               ((AstrCodEmp = '') or (AdsErros.FieldByName('ERR_CODEMP').AsString = AstrCodEmp)) and
               (IndexText(AdsErros.FieldByName('ERR_SIGLA').AsString, AarrSiglas) >= 0) then
            begin
              // Data fora do periodo gerado ficaria fora do escopo do DELETE acima e nunca sairia da tabela.
              LdtaLan := AdsErros.FieldByName('ERR_DTALAN').AsDateTime;
              if (LdtaLan < AdtaIni) or (LdtaLan > AdtaFin) then
                LdtaLan := AdtaIni;

              // Empresa vazia: geracao de todas as empresas; vale a empresa do documento.
              LqryPen.ParamByName('CODEMP').AsString := AdsErros.FieldByName('ERR_CODEMP').AsString;
              LqryPen.ParamByName('TIPLAN').AsString := AstrTipLan;
              LqryPen.ParamByName('SIGLA').AsString := AdsErros.FieldByName('ERR_SIGLA').AsString;
            LqryPen.ParamByName('TIPERR').AsString := AdsErros.FieldByName('ERR_TIPLAN').AsString;
              LqryPen.ParamByName('TABELA').AsString := AdsErros.FieldByName('ERR_TABELA').AsString;
              LqryPen.ParamByName('CHVDOC').AsString := AdsErros.FieldByName('ERR_CHVDOC').AsString;
              LqryPen.ParamByName('DTALAN').AsDate := LdtaLan;
              LqryPen.ParamByName('MOTIVO').AsString := AdsErros.FieldByName('ERR_MOTIVO').AsString;
              LqryPen.ParamByName('HISTOR').AsString := AdsErros.FieldByName('ERR_HISTOR').AsString;
              LqryPen.ParamByName('DESVAL').AsString := AdsErros.FieldByName('ERR_DESVAL').AsString;
              LqryPen.ParamByName('NATOPE').AsString := AdsErros.FieldByName('ERR_NATOPE').AsString;
              LqryPen.ParamByName('ORIPLA').AsString := AdsErros.FieldByName('ERR_ORIPLA').AsString;
              LqryPen.ParamByName('PLANCO').AsString := AdsErros.FieldByName('ERR_PLANCO').AsString;
              LqryPen.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
              LqryPen.ParamByName('DTAGER').AsDateTime := LdtaGer;
              LqryPen.ExecSQL;
            end;
            AdsErros.Next;
          end;
        finally
          AdsErros.EnableControls;
        end;
      end;

      fCommit;
    except
      fRollBack;
      raise;
    end;
  finally
    FreeAndNil(LqryPen);
  end;
end;

end.
