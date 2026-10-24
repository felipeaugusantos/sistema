unit untFatSeparadorConferente;

interface

uses
  untTypesSistema, Data.DB;

type
  TOnWriteLogFile = procedure (strText: String) of object;

  IFatSeparadorConferente = Interface
  ['{318505D3-618E-4ED8-A448-A196B868E1E5}']
    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String; Var AblnSeparadorApareceuDesabilitado: Boolean; dsSetores, dsItens: TDataSet): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp: String): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep: String): Boolean; overload;

    function WriteLogFile(const AValue: TOnWriteLogFile): IFatSeparadorConferente;
    function MostrarObs(const AValue: Boolean): IFatSeparadorConferente;
    function Coletor(const AValue: Boolean): IFatSeparadorConferente;
    function CarregaConferente(const AValue: Boolean): IFatSeparadorConferente;
  end;

  TFatSeparadorConferente = class(TInterfacedObject, IFatSeparadorConferente)
  private
    FOnWriteLogFile: TOnWriteLogFile;
    FblnMostrarObs: Boolean;
    FblnColetor: Boolean;
    FarrSetores: TStringArray;
    FblnCarregaConferente: Boolean;
    FblnTravaSeparador: Boolean;

    procedure pWriteLogFile(const AstrText: String);

    function MontaFiltroItem(ADataSet: TDataSet): String;

    function Normal(Var AstrCodCon, AstrCodSep, AstrObsExp: String; Var AblnSeparadorApareceuDesabilitado: Boolean): Boolean;
    function PorLocal(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String; Var AblnSeparadorApareceuDesabilitado: Boolean; dsSetores, dsItens: TDataSet): Boolean;

    function SeparacaoPorSetor(dsSetores, dsItens: TDataSet): Boolean;

    function fCarregaConferente(const AstrCodCon: String): Boolean;
    function fSeparadorApareceuDesabilitado(): Boolean;
    class function fEncontrouSetor(const AstrSetor: String; const AcdsSetores: TDataSet): Boolean;
  public
    constructor Create;
    class function New(): IFatSeparadorConferente;
    class function fGetSetoresParaExp(AstrItens: String): TStringArray;
    class procedure pSetSetoresParaExp(cdsSetores: TDataSet; strItem: String; var strCodCon, strCodSep, strObsExp, strEmbExp: String);
    class function fValidaSetSetoresParaExp(cdsSetores: TDataSet; strItem: String): Boolean;

    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String; Var AblnSeparadorApareceuDesabilitado: Boolean; dsSetores, dsItens: TDataSet): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp: String): Boolean; overload;
    function Solicitar(Var AstrCodCon, AstrCodSep: String): Boolean; overload;

    function WriteLogFile(const AValue: TOnWriteLogFile): IFatSeparadorConferente;
    function MostrarObs(const AValue: Boolean): IFatSeparadorConferente;
    function Coletor(const AValue: Boolean): IFatSeparadorConferente;
    function CarregaConferente(const AValue: Boolean): IFatSeparadorConferente;
  end;

Const
  strSetorDefault = '[SETOR N/I]';
  idxSetorDefault = 0;

implementation

uses
  System.SysUtils, System.StrUtils, System.Math, untFatDigSepConferente,
  untFatDigSepConferentePorLocal, untFuncoesSimples, Uni, UniClientDataSet;

constructor TFatSeparadorConferente.Create;
begin
  FOnWriteLogFile := Nil;
  FblnMostrarObs := True;
  FblnColetor := False;
  FblnCarregaConferente := True;
  FblnTravaSeparador := False;
end;

function TFatSeparadorConferente.Solicitar(Var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String; Var AblnSeparadorApareceuDesabilitado: Boolean; dsSetores, dsItens: TDataSet): Boolean;
begin
  if SeparacaoPorSetor(dsSetores, dsItens) then
    Result := PorLocal(AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb, AblnSeparadorApareceuDesabilitado, dsSetores, dsItens)
  else
    Result := Normal(AstrCodCon, AstrCodSep, AstrObsExp, AblnSeparadorApareceuDesabilitado);
end;

function TFatSeparadorConferente.Solicitar(var AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb: String): Boolean;
var
  LblnSeparadorApareceuDesabilitado: Boolean;
begin
  Result := Self.Solicitar(AstrCodCon, AstrCodSep, AstrObsExp, AstrCodEmb, LblnSeparadorApareceuDesabilitado, Nil, Nil);
end;

function TFatSeparadorConferente.Solicitar(var AstrCodCon, AstrCodSep, AstrObsExp: String): Boolean;
var
  LblnSeparadorApareceuDesabilitado: Boolean;
  LstrCodEmb: String;
begin
  Result := Self.Solicitar(AstrCodCon, AstrCodSep, AstrObsExp, LstrCodEmb, LblnSeparadorApareceuDesabilitado, Nil, Nil);
end;

function TFatSeparadorConferente.Solicitar(var AstrCodCon, AstrCodSep: String): Boolean;
var
  LblnSeparadorApareceuDesabilitado: Boolean;
  LstrCodEmb: String;
  LstrObsExp: String;
begin
  Self.MostrarObs(False);
  Result := Self.Solicitar(AstrCodCon, AstrCodSep, LstrObsExp, LstrCodEmb, LblnSeparadorApareceuDesabilitado, Nil, Nil);
end;

function TFatSeparadorConferente.SeparacaoPorSetor(dsSetores, dsItens: TDataSet): Boolean;
var
  LstrItens: String;
begin
  Result := True;

  if (not Assigned(dsSetores)) then
    Exit(False);

  if (not Assigned(dsItens)) then
    Exit(False);

  if (not fCfgSis('EXSECO', varBoolean)) then
    Exit(False);

  if (not fCfgSis('SEPLOC', varBoolean)) then
    Exit(False);

  If Result then
  begin
    LstrItens := MontaFiltroItem(dsItens);
    FarrSetores := TFatSeparadorConferente.fGetSetoresParaExp(LstrItens);

    Result := Length(FarrSetores) > 0;
  end;

end;

class function TFatSeparadorConferente.New: IFatSeparadorConferente;
begin
  Result := TFatSeparadorConferente.Create;
end;

function TFatSeparadorConferente.Normal(var AstrCodCon, AstrCodSep, AstrObsExp: String; var AblnSeparadorApareceuDesabilitado: Boolean): Boolean;
begin
  pWriteLogFile('Entrou na funcao fSolicitaConferenteSeparador');
  Result := False;

  Try
    pWriteLogFile('Vai criar o formulario TfrmFatDigSepConferente');
    pCriarFormularios(TfrmFatDigSepConferente, frmFatDigSepConferente);

    If Not fEmptyStr(AstrCodSep) Then
    Begin
      frmFatDigSepConferente.edtCodSeparador.Enabled := False;
      frmFatDigSepConferente.edtCodSeparador.Text    := AstrCodSep;
      frmFatDigSepConferente.edtNomSeparador.Text    := fRetNomVendRep(AstrCodSep);
    end;

    If fCarregaConferente(AstrCodCon) Then
    Begin
      frmFatDigSepConferente.edtSenhaConferente.Enabled := False;
      frmFatDigSepConferente.edtSenhaConferente.Text    := fRetSenhaVendedor(AstrCodCon);
      frmFatDigSepConferente.edtNomConferente.Text      := fRetNomVendRep(AstrCodCon);
    end;

    if FblnColetor Then
    Begin
      frmFatDigSepConferente.Width                  := 300;
      frmFatDigSepConferente.edtNomSeparador.Width  := 130;
      frmFatDigSepConferente.edtNomConferente.Width := 130;
      frmFatDigSepConferente.edtObs.Width           := 200;
    End;

    AblnSeparadorApareceuDesabilitado := fSeparadorApareceuDesabilitado;

    frmFatDigSepConferente.lblObs.Visible := FblnMostrarObs;
    frmFatDigSepConferente.edtObs.Visible := FblnMostrarObs;

    pWriteLogFile('Vai chamar o metodo showmodal do formulario');
    frmFatDigSepConferente.ShowModal;

    If (frmFatDigSepConferente.blnConfirma) Then
    Begin
      Result    := True;
      AstrCodCon := frmFatDigSepConferente.strCodConferente;
      AstrCodSep := frmFatDigSepConferente.edtCodSeparador.Text;
      AstrObsExp := frmFatDigSepConferente.edtObs.Text;
    End;

    If (frmFatDigSepConferente.blnConfirma) Then
      pWriteLogFile('frmFatDigSepConferente.blnConfirma resultou verdadeiro')
    Else
      pWriteLogFile('frmFatDigSepConferente.blnConfirma resultou falso');

  Except
    On E: Exception Do
    Begin
      pWriteLogFile('Ocorreu um erro fSolicitaConferenteSeparador:' + E.Message);
      pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.fSolicitaConferenteSeparador]');
    End;
  End;

  pWriteLogFile('Vai destruir o formulario frmFatDigSepConferente');
  pFreeAndNil(frmFatDigSepConferente);
end;

function TFatSeparadorConferente.PorLocal(var AstrCodCon, AstrCodSep,
  AstrObsExp, AstrCodEmb: String; var AblnSeparadorApareceuDesabilitado: Boolean;
  dsSetores, dsItens: TDataSet): Boolean;
var
  strSetor: String;
  intIdx  : Integer;
  frmFatDigSepConferentePorLocal: TfrmFatDigSepConferentePorLocal;

begin
  Result := False;

  Try
    pCriarFormularios(TfrmFatDigSepConferentePorLocal, frmFatDigSepConferentePorLocal);

    frmFatDigSepConferentePorLocal.cdsSepara.CreateDataSet;
    frmFatDigSepConferentePorLocal.cdsSepara.IndexFieldNames := 'SEQSEP;SETOR_';
    intIdx:=0;

    For strSetor In FarrSetores Do
    Begin
      Inc(intIdx);

      frmFatDigSepConferentePorLocal.cdsSepara.Append;
      frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('SEQSEP').AsInteger := IfThen((strSetor='NULL'), IdxSetorDefault, intIdx);
      frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('SETOR_').AsString := IfThen((strSetor='NULL'), strSetorDefault, strSetor);
      frmFatDigSepConferentePorLocal.cdsSepara.Post;

    End;
    frmFatDigSepConferentePorLocal.cdsSepara.First;

    If frmFatDigSepConferentePorLocal.cdsSepara.IsEmpty Then
    Begin
      frmFatDigSepConferentePorLocal.cdsSepara.Append;
      frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('SEQSEP').AsInteger := IdxSetorDefault;
      frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('SETOR_').AsString := strSetorDefault;
      frmFatDigSepConferentePorLocal.cdsSepara.Post;
    End;

    frmFatDigSepConferentePorLocal.cdsSepara.First;

    frmFatDigSepConferentePorLocal.ShowModal;

    pCloneDataSet(TUniClientDataSet(dsSetores), frmFatDigSepConferentePorLocal.cdsSepara);

    If (frmFatDigSepConferentePorLocal.blnConfirma) Then
    Begin
      Result := True;

      AstrCodSep := frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('CODSEP').AsString;
      AstrCodCon := fRetCodVendedor(frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('CODCON').AsString);
      AstrCodEmb := frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('CODEMB').AsString;
      AstrObsExp := frmFatDigSepConferentePorLocal.cdsSepara.FieldByName('OBSEXP').AsString;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmFatExpedicaoItens.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmFatDigSepConferentePorLocal);
end;

function TFatSeparadorConferente.CarregaConferente(
  const AValue: Boolean): IFatSeparadorConferente;
begin
  Result := Self;
  FblnCarregaConferente := AValue;
end;

function TFatSeparadorConferente.Coletor(
  const AValue: Boolean): IFatSeparadorConferente;
begin
  Result := Self;
  FblnColetor := AValue;
end;

function TFatSeparadorConferente.MostrarObs(const AValue: Boolean): IFatSeparadorConferente;
begin
  Result := Self;
  FblnMostrarObs := AValue;
end;

function TFatSeparadorConferente.WriteLogFile(const AValue: TOnWriteLogFile): IFatSeparadorConferente;
begin
  Result := Self;
  FOnWriteLogFile := AValue;
end;

procedure TFatSeparadorConferente.pWriteLogFile(const AstrText: String);
begin
  if Assigned(FOnWriteLogFile) then
    FOnWriteLogFile(AstrText);
end;

function TFatSeparadorConferente.MontaFiltroItem(ADataSet: TDataSet): String;
begin
  Result := EmptyStr;

  ADataSet.First;
  While (Not ADataSet.Eof) Do
  Begin
    If (ADataSet.FieldByName('QTDEXP').AsFloat > 0) Then
      Result := Result + IIF(Length(Result) > 0, ',', '') + ADataSet.FieldByName('CODITE').AsString.QuotedString;

    ADataSet.Next;
  End;
end;

function TFatSeparadorConferente.fCarregaConferente(const AstrCodCon: String): Boolean;
begin
  Result := True;

  if (not FblnCarregaConferente) then
    Exit(False);

  if (fEmptyStr(AstrCodCon)) then
    Exit(False);
end;

class function TFatSeparadorConferente.fEncontrouSetor(const AstrSetor: String; const AcdsSetores: TDataSet): Boolean;
begin
  if (AstrSetor <> 'NULL') then
    Exit(AcdsSetores.Locate('SETOR_', AstrSetor, []))
  else
    Exit(AcdsSetores.Locate('SEQSEP', 0, []));
end;

class function TFatSeparadorConferente.fGetSetoresParaExp(AstrItens: String): TStringArray;
var
  LqryAux: TUniQuery;
begin
  SetLength(Result, 0);

  If fEmptyStr(AstrItens) Then
    Exit;

  LqryAux := fCriaQuery();
  try
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add('SELECT DISTINCT ');
    LqryAux.SQL.Add('  IFNULL(NULLIF('+ IIF(fCfgSis('GRUSEP') = 'S', 'LSE_DESCRI', 'ITE_LOCFIS') +', ""), "NULL") AS SETOR_ ');
    LqryAux.SQL.Add('FROM ITEGER ');

    If fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica Then
    Begin
      LqryAux.SQL.Add('LEFT JOIN CADLOC ON LOC_CODLOC = ITE_LOCFIS AND LOC_CODEMP = ITE_CODEMP ');
      LqryAux.SQL.Add('LEFT JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE ');
    End
    Else
      LqryAux.SQL.Add('LEFT JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE ');

    LqryAux.SQL.Add('WHERE ITE_CODITE IN (' + AstrItens +') ');
    LqryAux.SQL.Add('  AND ITE_CODEMP = :CODEMP ');
    LqryAux.SQL.Add('ORDER BY SETOR_ ');

    LqryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    LqryAux.Open;

    If Not LqryAux.IsEmpty Then
    begin
      LqryAux.First;
      While Not LqryAux.Eof Do
      Begin
        pAddDados(Result, LqryAux.FieldByName('SETOR_').AsString);

        LqryAux.Next;
      End;
    End;
  finally
    FreeAndNil(LqryAux);
  end;
end;

function TFatSeparadorConferente.fSeparadorApareceuDesabilitado: Boolean;
begin
  Result := True;

  if (frmFatDigSepConferente.edtCodSeparador.Enabled) then
    Exit(False);

  if (fEmptyStr(frmFatDigSepConferente.edtCodSeparador.Text)) then
    Exit(False);
end;

class function TFatSeparadorConferente.fValidaSetSetoresParaExp(
  cdsSetores: TDataSet; strItem: String): Boolean;
begin
  Result := True;

  if (Not cdsSetores.Active) then
    Exit(False);

  if (cdsSetores.IsEmpty) then
    Exit(False);

  if (fEmptyStr(strItem)) then
    Exit(False);
end;

class procedure TFatSeparadorConferente.pSetSetoresParaExp(cdsSetores: TDataSet; strItem: String; Var strCodCon, strCodSep, strObsExp, strEmbExp:String);
var
  arrSetor: TStringArray;
  strSetor: String;
begin
  If not fValidaSetSetoresParaExp(cdsSetores, strItem) Then
    Exit;

  cdsSetores.First;

  arrSetor := TFatSeparadorConferente.fGetSetoresParaExp(strItem);
  If Length(arrSetor) > 0 Then
    strSetor := arrSetor[0];

  If TFatSeparadorConferente.fEncontrouSetor(strSetor, cdsSetores) Then
  Begin
    strCodSep := cdsSetores.FieldByName('CODSEP').AsString;
    strCodCon := fRetCodVendedor(cdsSetores.FieldByName('CODCON').AsString);
    strEmbExp := cdsSetores.FieldByName('CODEMB').AsString;
    strObsExp := cdsSetores.FieldByName('OBSEXP').AsString;
  End;

end;

end.
