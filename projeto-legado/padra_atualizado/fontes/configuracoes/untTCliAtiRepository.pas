unit untTCliAtiRepository;

interface

uses Aurelius.Criteria.Base, System.Generics.Collections, System.SysUtils,
     Aurelius.Criteria.Linq, untObjectManager, untFieldFiltros, Classes,
     Aurelius.Types.Nullable, Aurelius.Bind.Dataset, untTCliAti,
     Db;

Type
  TFiltros = class sealed
  Public
    strCodAti: TFieldFiltros<String>;
    strCodEmp: TFieldFiltros<String>;
    Constructor Create;
  End;

  TCliAtiRepository = class
  private
    FblnAtualizaDados: Boolean;
    FqryCliAti: TAureliusDataset;
    blnCriouObj: Boolean;
    listaCliAti : TList<TCliAti>;
    function fFiltrar<E: class>(Filter: TFiltros): TCriteria;
    function fExecuta(Filter: TFiltros): TCliAti;
    function fExecutaList(Filter: TFiltros): TList<TCliAti>;
    procedure pCarregaAtividades;
    procedure pDesAtiGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  public
    Constructor Create(blnAtualizaDados: Boolean);
    Destructor Destroy; Override;
    function fRetAtividades(strCodEmp: String): TList<TCliAti>;
    function fRetAtividade(strCodAti: String; strCodEmp: String = ''): TCliAti;
    function fAtividadeCadastrada(strCodAti: String; strCodEmp: String = ''): Boolean;
    function fInsereAtividade(strCodAti: String; strCodEmp: String = ''): Boolean;
    function fRemoverAtividade(strCodAti: String; strCodEmp: String = ''): Boolean;
    property qryCliAti: TAureliusDataset read FqryCliAti write FqryCliAti;
  end;

implementation

uses untUtilRepository, untFuncoesSimples;

{ TFiltros }

constructor TFiltros.Create;
begin
  strCodAti := '';
  strCodEmp := '';
end;

{ TCliAtiRepository }

constructor TCliAtiRepository.Create(blnAtualizaDados: Boolean);
begin
  blnCriouObj := False;
  frwk := fCriaObjManager(blnCriouObj);
  FqryCliAti := TAureliusDataset.Create(Nil);
  FblnAtualizaDados := blnAtualizaDados;
  If (FblnAtualizaDados) Then
    pCarregaAtividades;
end;

destructor TCliAtiRepository.Destroy;
begin
  If blnCriouObj Then
    FreeAndNil(frwk);

  If FqryCliAti.Active Then
    FqryCliAti.Close;

  FreeAndNil(FqryCliAti);

  If Assigned(listaCliAti) Then
    FreeAndNil(listaCliAti);

  inherited;
end;

function TCliAtiRepository.fAtividadeCadastrada(strCodAti,
  strCodEmp: String): Boolean;
  Var
    objCliAti : TCliAti;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  objCliAti := fRetAtividade(strCodAti, strCodEmp);
  Result := (Assigned(objCliAti)) And (objCliAti.ATI_CODATI = strCodAti);
end;

function TCliAtiRepository.fExecuta(Filter: TFiltros): TCliAti;
  Var
    lstCliAti : TList<TCliAti>;
begin
  lstCliAti := fFiltrar<TCliAti>(Filter).List<TCliAti>;
  If (Not Assigned(lstCliAti)) Or (lstCliAti.Count <= 0) Then
    Result := Nil
  Else
    Result := lstCliAti[0];
end;

function TCliAtiRepository.fExecutaList(Filter: TFiltros): TList<TCliAti>;
begin
  Result := fFiltrar<TCliAti>(Filter).List<TCliAti>;
end;

function TCliAtiRepository.fFiltrar<E>(Filter: TFiltros): TCriteria;
  Var
    ACriteria: TCriteria;
begin
  ACriteria := frwk.objDBManager.CreateCriteria<E>;

  If Not fEmptyStr(Filter.strCodAti) Then
  Begin
    Case Filter.strCodAti.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FATI_CODATI'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FATI_CODATI'));
      Else ACriteria.Add(TLinq.Eq('FATI_CODATI', Filter.strCodAti));
    End;
  End;

  If Not fEmptyStr(Filter.strCodEmp) Then
  Begin
    Case Filter.strCodEmp.Opcao Of
      opcIsNull   : ACriteria.Add(TLinq.IsNull('FATI_CODEMP'));
      opcIsNotNull: ACriteria.Add(TLinq.IsNotNull('FATI_CODEMP'));
      Else ACriteria.Add(TLinq.Eq('FATI_CODEMP', Filter.strCodEmp));
    End;
  End;

  Result := ACriteria;
end;

function TCliAtiRepository.fInsereAtividade(strCodAti,
  strCodEmp: String): Boolean;
  Var
    objCliAti : TCliAti;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  objCliAti := TCliAti.Create;
  Try
    objCliAti.AUTOINCREM := fRetAutoIncrem(TUtil.fRetTableName(objCliAti), strCodEmp);
    objCliAti.ATI_CODATI := strCodAti;
    objCliAti.ATI_CODEMP := strCodEmp;
    frwk.objDBManager.Save(objCliAti);
    Result := True;

    If (FblnAtualizaDados) Then
      pCarregaAtividades;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCliAtiRepository.fInsereAtividade');
    End;
  End;
end;

function TCliAtiRepository.fRemoverAtividade(strCodAti,
  strCodEmp: String): Boolean;
  Var
    objCliAti : TCliAti;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  objCliAti := fRetAtividade(strCodAti, strCodEmp);
  Try
    frwk.objDBManager.Remove(objCliAti);
    Result := True;
    If (FblnAtualizaDados) Then
      pCarregaAtividades;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCliAtiRepository.fRemoverAtividade');
    End;
  End;
end;

function TCliAtiRepository.fRetAtividade(strCodAti, strCodEmp: String): TCliAti;
  Var
    Filter: TFiltros;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Filter := TFiltros.Create;
  Filter.strCodAti := strCodAti;
  Filter.strCodEmp := strCodEmp;
  Result := fExecuta(Filter);
  FreeAndNil(Filter);
end;

function TCliAtiRepository.fRetAtividades(strCodEmp: String): TList<TCliAti>;
  Var
    Filter: TFiltros;
begin
  Filter := TFiltros.Create;
  Filter.strCodEmp := strCodEmp;
  Result := fExecutaList(Filter);
  FreeAndNil(Filter);
end;

procedure TCliAtiRepository.pCarregaAtividades;
begin
  If Assigned(listaCliAti) Then
    FreeAndNil(listaCliAti);

  listaCliAti := fRetAtividades(VS_strCodEmp);

  FqryCliAti.Close;
  FqryCliAti.SetSourceList(listaCliAti);

  If FqryCliAti.FindField('ATI_CODATI') = Nil Then
  Begin
    With TStringField.Create(FqryCliAti.Owner) do
    begin
      FieldName := 'ATI_CODATI';
      Dataset := FqryCliAti;
    end;
  End;

  If FqryCliAti.FindField('objCadAti.ATI_DESATI') = Nil Then
  Begin
    With TStringField.Create(FqryCliAti.Owner) do
    begin
      FieldName := 'objCadAti.ATI_DESATI';
      Dataset := FqryCliAti;
    end;
    FqryCliAti.FieldByName('objCadAti.ATI_DESATI').OnGetText := pDesAtiGetText;
  End;

  FqryCliAti.Open;
end;

procedure TCliAtiRepository.pDesAtiGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  If fEmptyStr(Text) Then
    Text := fRetNomAtividade(FqryCliAti.FieldByName('ATI_CODATI').AsString);
end;

end.
