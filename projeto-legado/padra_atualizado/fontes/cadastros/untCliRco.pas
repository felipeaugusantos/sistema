unit untCliRco;

interface

uses SysUtils, Uni, Contnrs, Classes;


{*******************************************}
{* REFERENCIAS COMERCIAIS DO CLIENTE       *}
{****************************************AC*}

Type

    TCliRco = class(TComponent)
      private
        FAutInc: String;
        FCodCli: String;
        FNomEmp: String;
        FCgcCpf: String;
        FCgcEmp: String;
        FTelEmp: String;
        FConEmp: String;
        FEmaEmp: String;
        FDtaCon: TDateTime;
        FNomInf: String;
        FDtaPco: TDateTime;
        FValPco: Double;
        FDtaMco: TDateTime;
        FValMco: Double;
        FDtaUco: TDateTime;
        FValUco: Double;
        FCodOpe: String;
        FDesOpe: String;

        qryCliRco: TUniQuery;

        procedure pZeraValores;

      protected
        function getAutInc: String;
        function getCodCli: String;
        function getNomEmp: String;
        function getCgcCpf: String;
        function getCgcEmp: String;
        function getTelEmp: String;
        function getConEmp: String;
        function getEmaEmp: String;
        function getDtaCon: TDateTime;
        function getNomInf: String;
        function getDtaPco: TDateTime;
        function getValPco: Double;
        function getDtaMco: TDateTime;
        function getValMco: Double;
        function getDtaUco: TDateTime;
        function getValUco: Double;
        function getCodOpe: String;

        procedure setAutInc(const Value: String);
        procedure setCodCli(const Value: String);
        procedure setNomEmp(const Value: String);
        procedure setCgcCpf(const Value: String);
        procedure setCgcEmp(const Value: String);
        procedure setTelEmp(const Value: String);
        procedure setConEmp(const Value: String);
        procedure setEmaEmp(const Value: String);
        procedure setDtaCon(const Value: TDateTime);
        procedure setNomInf(const Value: String);
        procedure setDtaPco(const Value: TDateTime);
        procedure setValPco(const Value: Double);
        procedure setDtaMco(const Value: TDateTime);
        procedure setValMco(const Value: Double);
        procedure setDtaUco(const Value: TDateTime);
        procedure setValUco(const Value: Double);
        procedure setCodOpe(const Value: String);

      public

        Constructor Create(AOwner: TComponent); reintroduce; overload;
        Constructor Create(AOwner: TComponent; Const strCodCli, strAutInc: String; blnAutoIncNULL : Boolean = False); reintroduce; overload;
        Destructor Destroy; override;

        procedure pInsereCliRco;
        class procedure pApagarCadRco(const strCodCli: String);
        class function fRetRefComerciais(const strCodCli: String; blnAutoIncNULL : Boolean = False): TObjectList;

    property strAutInc: String    Read getAutInc Write setAutInc;
    property strCodCli: String    Read getCodCli Write setCodCli;
        property strNomEmp: String Read getNomEmp Write setNomEmp;
        property strCgcCpf: String Read getCgcCpf Write setCgcCpf;
        property strCgcEmp: String Read getCgcEmp Write setCgcEmp;
        property strTelEmp: String Read getTelEmp Write setTelEmp;
        property strConEmp: String Read getConEmp Write setConEmp;
        property strEmaEmp: String Read getEmaEmp Write setEmaEmp;
        property strDtaCon: TDateTime Read getDtaCon Write setDtaCon;
        property strNomInf: String Read getNomInf Write setNomInf;
        property strDtaPco: TDateTime Read getDtaPco Write setDtaPco;
        property strValPco: Double Read getValPco Write setValPco;
        property strDtaMco: TDateTime Read getDtaMco Write setDtaMco;
        property strValMco: Double Read getValMco Write setValMco;
        property strDtaUco: TDateTime Read getDtaUco Write setDtaUco;
        property strValUco: Double Read getValUco Write setValUco;
        property strCodOpe: String Read getCodOpe Write setCodOpe;
        property strDesOpe: String Read FDesOpe;

  End;

implementation

uses untfuncoesSimples, untConstantes, Data.DB, untTypesSistema;

{ TCliRco }

constructor TCliRco.Create(AOwner: TComponent; const strCodCli, strAutInc: String; blnAutoIncNULL : Boolean = False);
  Var
    qryAux: TUniQuery;
begin
  inherited Create(AOwner);
  qryCliRco := fCriaQuery(Self);

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT                                   ');
  qryAux.SQL.Add('  CLIRCO.AUTOINCREM AS AUTINC,           ');
  qryAux.SQL.Add('  CLIRCO.*,                              ');
  qryAux.SQL.Add('  CADOPE.*                               ');
  qryAux.SQL.Add('FROM                                     ');
  qryAux.SQL.Add('  CLIRCO                                 ');
  qryAux.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = CLI_CODOPE ');
  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  CLI_CODCLI = :CODCLI AND               ');
  qryAux.SQL.Add('  CLIRCO.AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;

  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    If blnAutoIncNULL Then
      FAutInc := ''
    Else
      FAutInc := qryAux.FieldByName('AUTINC').AsString;
    
    FCodCli := qryAux.FieldByName('CLI_CODCLI').AsString;
    FNomEmp := qryAux.FieldByName('CLI_EMPRCO').AsString;
    FCgcCpf := qryAux.FieldByName('CLI_CGCCPF').AsString;
    FCgcEmp := qryAux.FieldByName('CLI_CGCEMP').AsString;
    FTelEmp := qryAux.FieldByName('CLI_TELEMP').AsString;
    FConEmp := qryAux.FieldByName('CLI_CONEMP').AsString;
    FEmaEmp := qryAux.FieldByName('CLI_EMAIL_').AsString;
    FDtaCon := qryAux.FieldByName('CLI_DTACON').AsDateTime;
    FNomInf := qryAux.FieldByName('CLI_NOMINF').AsString;
    FDtaPco := qryAux.FieldByName('CLI_DTAPCO').AsDateTime;
    FValPco := qryAux.FieldByName('CLI_VALPCO').AsFloat;
    FDtaMco := qryAux.FieldByName('CLI_DTAMCO').AsDateTime;
    FValMco := qryAux.FieldByName('CLI_VALMCO').AsFloat;
    FDtaUco := qryAux.FieldByName('CLI_DTAUCO').AsDateTime;
    FValUco := qryAux.FieldByName('CLI_VALUCO').AsFloat;
    FCodOpe := qryAux.FieldByName('CLI_CODOPE').AsString;
    FDesOpe := qryAux.FieldByName('OPE_NOMOPE').AsString;
  End;
  FreeAndNil(qryAux);
end;

constructor TCliRco.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  qryCliRco := fCriaQuery(Self);
  pZeraValores;
end;

destructor TCliRco.Destroy;
begin
  FreeAndNil(qryCliRco);
  inherited;
end;

class function TCliRco.fRetRefComerciais(const strCodCli: String; blnAutoIncNULL : Boolean = False): TObjectList;
  Var
    qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM CLIRCO WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TCliRco.Create(nil, strCodCli, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

function TCliRco.getAutInc: String;
begin
  Result := FAutInc;
end;

function TCliRco.getCgcCpf: String;
begin
  Result := FCgcCpf;
end;

function TCliRco.getCgcEmp: String;
begin
  Result := FCgcEmp;
end;

function TCliRco.getCodCli: String;
begin
  Result := FCodCli;
end;

function TCliRco.getNomInf: String;
begin
  Result := FNomInf;
end;

function TCliRco.getCodOpe: String;
begin
  Result := FCodOpe;
end;

function TCliRco.getConEmp: String;
begin
  Result := FConEmp;
end;

function TCliRco.getDtaCon: TDateTime;
begin
  Result := FDtaCon;
end;

function TCliRco.getDtaMco: TDateTime;
begin
  Result := FDtaMco;
end;

function TCliRco.getDtaPco: TDateTime;
begin
  Result := FDtaPco;
end;

function TCliRco.getDtaUco: TDateTime;
begin
  Result := FDtaUco;
end;

function TCliRco.getEmaEmp: String;
begin
  Result := FEmaEmp;
end;

function TCliRco.getNomEmp: String;
begin
  Result := FNomEmp;
end;

function TCliRco.getTelEmp: String;
begin
  Result := FTelEmp;
end;

function TCliRco.getValMco: Double;
begin
  Result := FValMco;
end;

function TCliRco.getValPco: Double;
begin
  Result := FValPco;
end;

function TCliRco.getValUco: Double;
begin
  Result := FValUco;
end;

class procedure TCliRco.pApagarCadRco(const strCodCli: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM CLIRCO WHERE CLI_CODCLI = :CODCLI');
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TCliRco.pInsereCliRco;
begin
  setAutInc(FAutInc);
  setCodCli(FCodCli);
  setNomEmp(FNomEmp);
  setCgcCpf(FCgcCpf);
  setCgcEmp(FCgcEmp);
  setTelEmp(FTelEmp);
  setConEmp(FConEmp);
  setEmaEmp(FEmaEmp);
  setDtaCon(FDtaCon);
  setNomInf(FNomInf);
  setDtaPco(FDtaPco);
  setValPco(FValPco);
  setDtaMco(FDtaMco);
  setValMco(FValMco);
  setDtaUco(FDtaUco);
  setValUco(FValUco);
  setCodOpe(FCodOpe);

  qryCliRco.Close;
  qryCliRco.SQL.Clear;
  qryCliRco.SQL.Add('INSERT INTO CLIRCO  ');
  qryCliRco.SQL.Add('(                   ');
  qryCliRco.SQL.Add('  CLI_CODCLI,       ');
  qryCliRco.SQL.Add('  CLI_EMPRCO,       ');
  qryCliRco.SQL.Add('  CLI_CGCCPF,       ');
  qryCliRco.SQL.Add('  CLI_CGCEMP,       ');
  qryCliRco.SQL.Add('  CLI_TELEMP,       ');
  qryCliRco.SQL.Add('  CLI_CONEMP,       ');
  qryCliRco.SQL.Add('  CLI_EMAIL_,       ');
  qryCliRco.SQL.Add('  CLI_DTACON,       ');
  qryCliRco.SQL.Add('  CLI_NOMINF,       ');
  qryCliRco.SQL.Add('  CLI_DTAPCO,       ');
  qryCliRco.SQL.Add('  CLI_VALPCO,       ');
  qryCliRco.SQL.Add('  CLI_DTAMCO,       ');
  qryCliRco.SQL.Add('  CLI_VALMCO,       ');
  qryCliRco.SQL.Add('  CLI_DTAUCO,       ');
  qryCliRco.SQL.Add('  CLI_VALUCO,       ');
  qryCliRco.SQL.Add('  CLI_CODOPE,       ');
  qryCliRco.SQL.Add('  CLI_CODEMP,       ');
  qryCliRco.SQL.Add('  AUTOINCREM        ');
  qryCliRco.SQL.Add(') VALUES (          ');
  qryCliRco.SQL.Add('  :CODCLI,          ');
  qryCliRco.SQL.Add('  :EMPRCO,          ');
  qryCliRco.SQL.Add('  :CGCCPF,          ');
  qryCliRco.SQL.Add('  :CGCEMP,          ');
  qryCliRco.SQL.Add('  :TELEMP,          ');
  qryCliRco.SQL.Add('  :CONEMP,          ');
  qryCliRco.SQL.Add('  :EMAIL_,          ');
  qryCliRco.SQL.Add('  :DTACON,          ');
  qryCliRco.SQL.Add('  :NOMINF,          ');
  qryCliRco.SQL.Add('  :DTAPCO,          ');
  qryCliRco.SQL.Add('  :VALPCO,          ');
  qryCliRco.SQL.Add('  :DTAMCO,          ');
  qryCliRco.SQL.Add('  :VALMCO,          ');
  qryCliRco.SQL.Add('  :DTAUCO,          ');
  qryCliRco.SQL.Add('  :VALUCO,          ');
  qryCliRco.SQL.Add('  :CODOPE,          ');
  qryCliRco.SQL.Add('  :CODEMP,          ');
  qryCliRco.SQL.Add('  :AUTINC)          ');

  qryCliRco.ParamByName('CODCLI').AsString   := FCodCli;
  qryCliRco.ParamByName('EMPRCO').AsString   := FNomEmp;
  qryCliRco.ParamByName('CGCCPF').AsString   := FCgcCpf;
  qryCliRco.ParamByName('CGCEMP').AsString   := FCgcEmp;
  qryCliRco.ParamByName('TELEMP').AsString   := FTelEmp;
  qryCliRco.ParamByName('CONEMP').AsString   := FConEmp;
  qryCliRco.ParamByName('EMAIL_').AsString   := FEmaEmp;

  if FDtaCon > 0 then
    qryCliRco.ParamByName('DTACON').AsDateTime := FDtaCon
  else
    qryCliRco.ParamByName('DTACON').IsNull;

  qryCliRco.ParamByName('NOMINF').AsString   := FNomInf;

  if FDtaPco > 0 then
    qryCliRco.ParamByName('DTAPCO').AsDateTime := FDtaPco
  else
    qryCliRco.ParamByName('DTAPCO').IsNull;

  qryCliRco.ParamByName('VALPCO').AsFloat    := FValPco;

  if FDtaMco > 0 then
    qryCliRco.ParamByName('DTAMCO').AsDateTime := FDtaMco
  else
    qryCliRco.ParamByName('DTAMCO').IsNull;

  qryCliRco.ParamByName('VALMCO').AsFloat    := FValMco;

  if FDtaUco > 0 then  
    qryCliRco.ParamByName('DTAUCO').AsDateTime := FDtaUco
  else
    qryCliRco.ParamByName('DTAUCO').IsNull;

  qryCliRco.ParamByName('VALUCO').AsFloat    := FValUco;

  if FCodOpe <> '' then  
    qryCliRco.ParamByName('CODOPE').AsString := FCodOpe
  else
    qryCliRco.ParamByName('CODOPE').IsNull;

  qryCliRco.ParamByName('CODEMP').AsString   := VS_strCodEmp;

  if (Trim(FAutInc) <> '') then
    qryCliRco.ParamByName('AUTINC').AsString := FAutInc
  else
  begin
    qryCliRco.ParamByName('AUTINC').AsString := fRetAutoIncrem('CLIRCO', VS_strCodEmp);
    setAutInc(qryCliRco.ParamByName('AUTINC').AsString);
  end;

  qryCliRco.ExecSQL;
  qryCliRco.Close;

end;

procedure TCliRco.pZeraValores;
begin
  FAutInc := '';
  FCodCli := '';
  FNomEmp := '';
  FCgcCpf := '';
  FCgcEmp := '';
  FTelEmp := '';
  FConEmp := '';
  FEmaEmp := '';
  FDtaCon := 0;
  FNomInf := '';
  FDtaPco := 0;
  FValPco := 0;
  FDtaMco := 0;
  FValMco := 0;
  FDtaUco := 0;
  FValUco := 0;
  FCodOpe := '';
end;

procedure TCliRco.setAutInc(const Value: String);
begin
  If (FAutInc <> Value) Then
    FAutInc := Value;
end;

procedure TCliRco.setCgcCpf(const Value: String);
begin
  If (FCgcCpf <> Value) Then
    FCgcCpf := Value;
end;

procedure TCliRco.setCgcEmp(const Value: String);
begin
  If (FCgcEmp <> Value) Then
    FCgcEmp := Value;
end;

procedure TCliRco.setCodCli(const Value: String);
begin
  If (FCodCli <> Value) Then
    FCodCli := Value;
end;

procedure TCliRco.setNomInf(const Value: String);
begin
  If (FNomInf <> Value) Then
    FNomInf := Value;
end;

procedure TCliRco.setCodOpe(const Value: String);
begin

  FDesOpe := fRetNomVendRep(Value);
  If (fEmptyStr(FDesOpe)) And (not fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('Esse operador não está cadastrado!');

  If (FCodOpe <> Value) Then
    FCodOpe := Value;

end;

procedure TCliRco.setConEmp(const Value: String);
begin
  If (FConEmp <> Value) Then
    FConEmp := Value;
end;

procedure TCliRco.setDtaCon(const Value: TDateTime);
begin
  If (FDtaCon <> Value) Then
    FDtaCon := Value;
end;

procedure TCliRco.setDtaMco(const Value: TDateTime);
begin
  If (FDtaMco <> Value) Then
    FDtaMco := Value;
end;

procedure TCliRco.setDtaPco(const Value: TDateTime);
begin
  If (FDtaPco <> Value) Then
    FDtaPco := Value;
end;

procedure TCliRco.setDtaUco(const Value: TDateTime);
begin
  If (FDtaUco <> Value) Then
    FDtaUco := Value;
end;

procedure TCliRco.setEmaEmp(const Value: String);
begin
  If (FEmaEmp <> Value) Then
    FEmaEmp := Value;
end;

procedure TCliRco.setNomEmp(const Value: String);
begin
  If (FNomEmp <> Value) Then
    FNomEmp := Value;
end;

procedure TCliRco.setTelEmp(const Value: String);
begin
  If (FTelEmp <> Value) Then
    FTelEmp := Value;
end;

procedure TCliRco.setValMco(const Value: Double);
begin
  If (FValMco <> Value) Then
    FValMco := Value;
end;

procedure TCliRco.setValPco(const Value: Double);
begin
  If (FValPco <> Value) Then
    FValPco := Value;
end;

procedure TCliRco.setValUco(const Value: Double);
begin
  If (FValUco <> Value) Then
    FValUco := Value;
end;

end.
