unit untFuncFerias;

interface

uses SysUtils, Uni, Contnrs;

Type

    TFunFer = class(TObject)
      private
        FCodFun  : String;
        FAquIni  : TDateTime;
        FAquFin  : TDateTime;
        FGozIni  : TDateTime;
        FGozFin  : TDateTime;
        FDtaRec  : TDateTime;
        FValRec  : Double;
        FCodEmp  : String;

        qryFerias: TUniQuery;

        procedure pZeraValores;

      protected
        function getCodFun: String;
        function getAquIni: TDateTime;
        function getAquFin: TDateTime;
        function getGozIni: TDateTime;
        function getGozFin: TDateTime;
        function getDtaRec: TDateTime;
        function getValRec: Double;

        procedure setCodFun(const Value: String);
        procedure setAquIni(const Value: TDateTime);
        procedure setAquFin(const Value: TDateTime);
        procedure setGozIni(const Value: TDateTime);
        procedure setGozFin(const Value: TDateTime);
        procedure setDtaRec(const Value: TDateTime);
        procedure setValRec(const Value: Double);
        procedure setCodEmp(const Value: String);

      public

        Constructor Create; reintroduce; overload;
        Constructor Create(Const strCodFun, strAutInc: String); overload;
        Destructor Destroy; override;

        procedure pInsereFerias;
        class procedure pApagarFerias(const strCodFun, strCodEmp: String);
        class function fRetFerias(const strCodFun, strCodEmp: String): TObjectList;

        property strCodFun: String    Read getCodFun Write setCodFun;
        property dtaAquIni: TDateTime Read getAquIni Write setAquIni;
        property dtaAquFin: TDateTime Read getAquFin Write setAquFin;
        property dtaGozIni: TDateTime Read getGozIni Write setGozIni;
        property dtaGozFin: TDateTime Read getGozFin Write setGozFin;
        property dtaDtaRec: TDateTime Read getDtaRec Write setDtaRec;
        property fltValRec: Double    Read getValRec Write setValRec;
        property strCodEmp: String    Read FCodEmp write setCodEmp;

  End;

implementation

uses untFuncoesSimples, untConstantes, Data.DB, System.Classes,
  untTypesSistema;

{ TFunFer }

constructor TFunFer.Create;
begin
  qryFerias := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TFunFer.Create(const strCodFun, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  qryFerias := fCriaQuery(Nil);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                      ');
  qryAux.SQL.Add('  *                         ');
  qryAux.SQL.Add('FROM                        ');
  qryAux.SQL.Add('  FUNFER                    ');
  qryAux.SQL.Add('WHERE                       ');
  qryAux.SQL.Add('  FER_CODFUN = :CODFUN AND  ');
  qryAux.SQL.Add('  AUTOINCREM = :AUTINC      ');

  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodFun := qryAux.FieldByName('FER_CODFUN').AsString;
    FAquIni := qryAux.FieldByName('FER_AQUINI').AsDateTime;
    FAquFin := qryAux.FieldByName('FER_AQUFIN').AsDateTime;
    FGozIni := qryAux.FieldByName('FER_GOZINI').AsDateTime;
    FGozFin := qryAux.FieldByName('FER_GOZFIN').AsDateTime;
    FDtaRec := qryAux.FieldByName('FER_DTAREC').AsDateTime;
    FValRec := qryAux.FieldByName('FER_VALREC').AsFloat;
  End;
end;

destructor TFunFer.Destroy;
begin
  inherited;
end;

class function TFunFer.fRetFerias(const strCodFun, strCodEmp: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin
  Result := TObjectList.Create(True);
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM FUNFER WHERE FER_CODFUN = :CODFUN AND FER_CODEMP = :CODEMP');
  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TFunFer.Create(strCodFun, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

function TFunFer.getCodFun: String;
begin
  Result := FCodFun;
end;

function TFunFer.getAquIni: TDateTime;
begin
  Result := FAquIni;
end;

function TFunFer.getAquFin: TDateTime;
begin
  Result := FAquFin;
end;

function TFunFer.getGozIni: TDateTime;
begin
  Result := FGozIni;
end;

function TFunFer.getGozFin: TDateTime;
begin
  Result := FGozFin;
end;

function TFunFer.getDtaRec: TDateTime;
begin
  Result := FDtaRec;
end;

function TFunFer.getValRec: Double;
begin
  Result := FValRec;
end;

class procedure TFunFer.pApagarFerias(const strCodFun, strCodEmp: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM FUNFER WHERE FER_CODFUN = :CODFUN AND FER_CODEMP = :CODEMP');
  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

procedure TFunFer.pInsereFerias;
begin
  setCodFun(FCodFun);
  setAquIni(FAquIni);
  setAquFin(FAquFin);
  setGozIni(FGozIni);
  setGozFin(FGozFin);
  setDtaRec(FDtaRec);
  setValRec(FValRec);

  With qryFerias Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO FUNFER  ');
    SQL.Add('(                   ');
    SQL.Add('  FER_CODEMP,       ');
    SQL.Add('  FER_CODFUN,       ');
    SQL.Add('  FER_AQUINI,       ');
    SQL.Add('  FER_AQUFIN,       ');
    SQL.Add('  FER_GOZINI,       ');
    SQL.Add('  FER_GOZFIN,       ');
    SQL.Add('  FER_DTAREC,       ');
    SQL.Add('  FER_VALREC,       ');
    SQL.Add('  AUTOINCREM        ');
    SQL.Add(') VALUES (          ');
    SQL.Add('  :CODEMP,          ');
    SQL.Add('  :CODFUN,          ');
    SQL.Add('  :AQUINI,          ');
    SQL.Add('  :AQUFIN,          ');
    SQL.Add('  :GOZINI,          ');
    SQL.Add('  :GOZFIN,          ');
    SQL.Add('  :DTAREC,          ');
    SQL.Add('  :VALREC,          ');
    SQL.Add('  :AUTINC)          ');

    ParamByName('CODEMP').AsString   := FCodEmp;
    ParamByName('CODFUN').AsString   := FCodFun;
    ParamByName('AQUINI').AsDateTime := FAquIni;
    ParamByName('AQUFIN').AsDateTime := FAquFin;
    ParamByName('GOZINI').AsDateTime := FGozIni;
    ParamByName('GOZFIN').AsDateTime := FGozFin;
    ParamByName('DTAREC').AsDateTime := FDtaRec;
    ParamByName('VALREC').AsFloat    := FValRec;
    ParamByName('AUTINC').AsString   := fRetAutoIncrem('FUNFER', VS_strCodEmp);
    ExecSQL;
    Close;
  End;
end;

procedure TFunFer.pZeraValores;
begin
  FCodFun := '';
  FAquIni := 0;
  FAquFin := 0;
  FGozIni := 0;
  FGozFin := 0;
  FDtaRec := 0;
  FValRec := 0;
end;

procedure TFunFer.setCodEmp(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Código da Empresa deve ser preenchido!');

  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TFunFer.setCodFun(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Funcionário deve ser preenchido!');

  If (FCodFun <> Value) Then
    FCodFun := Value;
end;

procedure TFunFer.setAquIni(const Value: TDateTime);
begin
  If (Value = 0) Then
    Raise ExceptionAutCom.Create('A Data Inicial da Aquisição deve ser preenchida!');

  If (FAquIni <> Value) Then
    FAquIni := Value;
end;

procedure TFunFer.setAquFin(const Value: TDateTime);
begin
  If (Value = 0) Then
    Raise ExceptionAutCom.Create('A Data Final da Aquisição deve ser preenchida!');

  If (FAquFin <> Value) Then
    FAquFin := Value;
end;

procedure TFunFer.setGozIni(const Value: TDateTime);
begin
  If (Value = 0) Then
    Raise ExceptionAutCom.Create('A Data Inicial do Gozo deve ser preenchida!');

  If (FGozIni <> Value) Then
    FGozIni := Value;
end;

procedure TFunFer.setGozFin(const Value: TDateTime);
begin
  If (Value = 0) Then
    Raise ExceptionAutCom.Create('A Data Final do Gozo deve ser preenchida!');

  If (FGozFin <> Value) Then
    FGozFin := Value;
end;


procedure TFunFer.setDtaRec(const Value: TDateTime);
begin
  If (Value = 0) Then
    Raise ExceptionAutCom.Create('A data de recebimento deve ser preenchida!');

  If (FDtaRec <> Value) Then
    FDtaRec := Value;
end;

procedure TFunFer.setValRec(const Value: Double);
begin
  If Value < 0 Then
    Raise ExceptionAutCom.Create('O valor recebido não pode ser um valor negativo!');

  If (FValRec <> Value) Then
    FValRec := Value;
end;

end.
