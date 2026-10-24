unit untFuncBenef;

interface

uses SysUtils, Uni, Contnrs;

Type

    TFunBnf = class(TObject)
      private
        FCodFun : String;
        FNomBen : String;
        FGraPar : String;
        FNumRG  : String;
        FNumCPF : String;
        FDtaNas : TDateTime;
        FCodEmp : String;

        qryBenef : TUniQuery;

        procedure pZeraValores;

      protected
        procedure setCodFun(const Value: String);
        procedure setNomBen(const Value: String);
        procedure setGraPar(const Value: String);
        procedure setNumRG(const Value: String);
        procedure setNumCPF(const Value: String);
        procedure setDtaNas(const Value: TDateTime);
        procedure setCodEmp(const Value: String);
      public
        Constructor Create; reintroduce; overload;
        Constructor Create(Const strCodFun, strAutInc: String); overload;
        Destructor Destroy; override;
        procedure pInsereBenef;
        class procedure pApagarBenef(const strCodFun, strCodEmp: String);
        class function fRetBenef(const strCodFun, strCodEmp: String): TObjectList;

        property strCodFun: String Read FCodFun Write setCodFun;
        property strNomBen: String Read FNomBen Write setNomBen;
        property strGraPar: String Read FGraPar Write setGraPar;
        property strNumRG: String Read FNumRG Write setNumRG;
        property strNumCPF: String Read FNumCPF Write setNumCPF;
        property strDtaNas: TDateTime Read FDtaNas Write setDtaNas;
        property strCodEmp: String Read FCodEmp write setCodEmp;
  End;

implementation

uses untFuncoesSimples, untConstantes, Data.DB, System.Classes,
  untTypesSistema;

{ TFunFer }

constructor TFunBnf.Create;
begin
  qryBenef := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TFunBnf.Create(const strCodFun, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  qryBenef := fCriaQuery(Nil);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                      ');
  qryAux.SQL.Add('  *                         ');
  qryAux.SQL.Add('FROM                        ');
  qryAux.SQL.Add('  FUNBNF                    ');
  qryAux.SQL.Add('WHERE                       ');
  qryAux.SQL.Add('  BNF_CODFUN = :CODFUN AND  ');
  qryAux.SQL.Add('  AUTOINCREM = :AUTINC      ');

  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
    pZeraValores
  Else
  Begin
    FCodFun := qryAux.FieldByName('BNF_CODFUN').AsString;
    FNomBen := qryAux.FieldByName('BNF_NOMBEN').AsString;
    FGraPar := qryAux.FieldByName('BNF_GRAPAR').AsString;

    FNumRG  := qryAux.FieldByName('BNF_NUMRG').AsString;
    FNumCPF := qryAux.FieldByName('BNF_NUMCPF').AsString;
    FDtaNas := qryAux.FieldByName('BNF_DTANAS').AsDateTime;

  End;
end;

destructor TFunBnf.Destroy;
begin
  inherited;
end;

class function TFunBnf.fRetBenef(const strCodFun, strCodEmp: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin
  Result := TObjectList.Create(True);
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM FUNBNF WHERE BNF_CODFUN = :CODFUN AND BNF_CODEMP=:CODEMP');
  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TFunBnf.Create(strCodFun, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

class procedure TFunBnf.pApagarBenef(const strCodFun, strCodEmp: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM FUNBNF WHERE BNF_CODFUN = :CODFUN AND BNF_CODEMP=:CODEMP');
  qryAux.ParamByName('CODFUN').AsString := strCodFun;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ExecSQL;
  qryAux.Close;
  FreeAndNil(qryAux);
end;

procedure TFunBnf.pInsereBenef;
begin
  setCodFun(FCodFun);
  setNomBen(FNomBen);
  setGraPar(FGraPar);
  setNumRG(FNumRG);
  setNumCPF(FNumCPF);
  setDtaNas(FDtaNas);

  With qryBenef Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO FUNBNF  ');
    SQL.Add('(                   ');
    SQL.Add('  BNF_CODEMP,       ');
    SQL.Add('  BNF_CODFUN,       ');
    SQL.Add('  BNF_NOMBEN,       ');
    SQL.Add('  BNF_GRAPAR,       ');

    SQL.Add('  BNF_NUMRG,        ');
    SQL.Add('  BNF_NUMCPF,       ');
    SQL.Add('  BNF_DTANAS,       ');

    SQL.Add('  AUTOINCREM        ');
    SQL.Add(') VALUES (          ');
    SQL.Add('  :CODEMP,          ');
    SQL.Add('  :CODFUN,          ');
    SQL.Add('  :NOMBEN,          ');
    SQL.Add('  :GRAPAR,          ');

    SQL.Add('  :NUMRG,           ');
    SQL.Add('  :NUMCPF,          ');
    SQL.Add('  :DTANAS,          ');

    SQL.Add('  :AUTINC)          ');

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFUN').AsString := FCodFun;
    ParamByName('NOMBEN').AsString := FNomBen;
    ParamByName('GRAPAR').AsString := FGraPar;

    ParamByName('NUMRG').AsString  := FNumRG;
    ParamByName('NUMCPF').AsString := FNumCPF;
    ParamByName('DTANAS').AsDateTime := FDtaNas;

    ParamByName('AUTINC').AsString := fRetAutoIncrem('FUNBNF', VS_strCodEmp);
    ExecSQL;
    Close;
  End;
end;

procedure TFunBnf.pZeraValores;
begin
  FCodFun  := '';
  FNomBen  := '';
  FGraPar  := '';
  FNumRG   := '';
  FNumCPF  := '';
  FDtaNas  := 0;
end;

procedure TFunBnf.setCodEmp(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Código da Empresa deve ser preenchido!');

  If (FCodEmp <> Value) Then
    FCodEmp := Value;
end;

procedure TFunBnf.setCodFun(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Funcionário deve ser preenchido!');

  If (FCodFun <> Value) Then
    FCodFun := Value;
end;

procedure TFunBnf.setNomBen(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Nome do Beneficiário deve ser preenchida!');

  If (FNomBen <> Value) Then
    FNomBen := Value;
end;

procedure TFunBnf.setNumCPF(const Value: String);
begin
  FNumCPF := Value;
end;

procedure TFunBnf.setDtaNas(const Value: TDateTime);
begin
  FDtaNas := Value;
end;

procedure TFunBnf.setNumRG(const Value: String);
begin
  FNumRG := Value;
end;

procedure TFunBnf.setGraPar(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Grau de Parentesco deve ser preenchido!');

  If (FGraPar <> Value) Then
    FGraPar := Value;
end;

end.

