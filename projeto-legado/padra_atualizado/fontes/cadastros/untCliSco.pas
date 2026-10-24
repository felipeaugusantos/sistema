unit untCliSco;

interface

uses Uni, Contnrs, Classes;

type

  TCliSco = class(TComponent)
    private
      FAutoincrem : String;
      FCodCli     : String;
      FNomSco     : String;
      FPF_PJ_     : String;
      FCpfCnp     : String;
      FNum_RG     : String;
      FDtaNas     : TDate;
      FEstCiv     : String;
      FPer_Ps     : Real;
    protected

      function getAutoincrem : String;
      function getCodCli     : String;
      function getNomSco     : String;
      function getPF_PJ_     : String;
      function getCpfCnp     : String;
      function getNum_RG     : String;
      function getDtaNas     : TDate;
      function getEstCiv     : String;
      function getPer_Ps     : Real;

      procedure setAutoincrem(Value : String);
      procedure setCodCli(Value : String);
      procedure setNomSco(Value : String);
      procedure setPF_PJ_(Value : String);
      procedure setCpfCnp(Value : String);
      procedure setNum_RG(Value : String);
      procedure setDtaNas(Value : TDate);
      procedure setEstCiv(Value : String);
      procedure setPer_Ps(Value : Real);

    public

      Constructor Create(AOwner: TComponent); reintroduce; overload;
      Constructor Create(AOwner: TComponent; strCodCli, strAutInc: String; blnAutoIncNULL : Boolean = False); reintroduce; overload;

      procedure pGravarCliSco;
      procedure pExcluirCliSco;

      class procedure pApagarCadSco(strCodCli: String);
      class function fRetSocios(strCodCli: String; blnAutoIncNULL : Boolean = False): TObjectList;

      procedure pZeraValores;

      property strAutoincrem : String Read getAutoincrem Write setAutoincrem;
      property strCodCli     : String Read getCodCli     Write setCodCli;
      property strNomSco     : String Read getNomSco     Write setNomSco;
      property strPF_PJ_     : String Read getPF_PJ_     Write setPF_PJ_;
      property strCpfCnp     : String Read getCpfCnp     Write setCpfCnp;
      property strNum_RG     : String Read getNum_RG     Write setNum_RG;
      property dtaDtaNas     : TDate  Read getDtaNas     Write setDtaNas;
      property strEstCiv     : String Read getEstCiv     Write setEstCiv;
      property fltPer_Ps     : Real   Read getPer_Ps     Write setPer_Ps;

  End;

implementation

uses
  SysUtils, untConstantes, untFuncoesSimples, Data.DB, untFuncoes;

{ TCliSco }

constructor TCliSco.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  pZeraValores;
end;

constructor TCliSco.Create(AOwner: TComponent; strCodCli, strAutInc: String; blnAutoIncNULL: Boolean);
Var
  qryAux: TUniQuery;
begin

  inherited Create(AOwner);

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  *                        ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  CLISCO                   ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  SCO_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  AUTOINCREM = :AUTINC     ');

    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.Open;

    If (qryAux.IsEmpty) Then
    Begin
      pZeraValores;
    End
    Else
    Begin

      If Not blnAutoIncNULL Then
        FAutoincrem := qryAux.FieldByName('AUTOINCREM').AsString
      Else
        FAutoincrem := '';

      FCodCli := qryAux.FieldByName('SCO_CODCLI').AsString;
      FNomSco := qryAux.FieldByName('SCO_NOMSCO').AsString;
      FPF_PJ_ := qryAux.FieldByName('SCO_PF_PJ_').AsString;
      FCpfCnp := qryAux.FieldByName('SCO_CPFCNP').AsString;
      FNum_RG := qryAux.FieldByName('SCO_NUM_RG').AsString;
      FDtaNas := qryAux.FieldByName('SCO_DTANAS').AsDateTime;
      FEstCiv := qryAux.FieldByName('SCO_ESTCIV').AsString;
      FPer_Ps := qryAux.FieldByName('SCO_PER_PS').AsFloat;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

class function TCliSco.fRetSocios(strCodCli: String; blnAutoIncNULL: Boolean): TObjectList;
Var
  qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT AUTOINCREM FROM CLISCO WHERE SCO_CODCLI = :CODCLI ORDER BY SCO_NOMSCO');
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    qryAux.First;
    While (Not qryAux.Eof) Do
    Begin
      Result.Add(TCliSco.Create(nil, strCodCli, qryAux.FieldByName('AUTOINCREM').AsString, blnAutoIncNULL));
      qryAux.Next;
    End;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

End;

function TCliSco.getAutoincrem: String;
begin
  Result := FAutoincrem;
end;

function TCliSco.getCodCli: String;
begin
  Result := FCodCli;
end;

function TCliSco.getCpfCnp: String;
begin
  Result := FCpfCnp;
end;

function TCliSco.getDtaNas: TDate;
begin
  Result := FDtaNas;
end;

function TCliSco.getEstCiv: String;
begin
  Result := FEstCiv;
end;

function TCliSco.getNomSco: String;
begin
  Result := FNomSco;
end;

function TCliSco.getNum_RG: String;
begin
  Result := FNum_RG;
end;

function TCliSco.getPer_Ps: Real;
begin
  Result := FPer_Ps;
end;

function TCliSco.getPF_PJ_: String;
begin
  Result := FPF_PJ_;
end;

class procedure TCliSco.pApagarCadSco(strCodCli: String);
Var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM CLISCO WHERE SCO_CODCLI = :CODCLI');
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ExecSQL;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TCliSco.pExcluirCliSco;
Var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM CLISCO WHERE AUTOINCREM = :AUTOINC');
    qryAux.ParamByName('AUTOINC').AsString := FAutoincrem;
    qryAux.ExecSQL;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TCliSco.pGravarCliSco;
Var
  qryAux    : TUniQuery;
begin

  qryAux := fCriaQuery(nil);

  Try

    qryAux.Close;
    qryAux.SQL.Clear;

    qryAux.SQL.Add('INSERT INTO CLISCO ');
    qryAux.SQL.Add('( AUTOINCREM,      ');
    qryAux.SQL.Add('  SCO_CODCLI,      ');
    qryAux.SQL.Add('  SCO_NOMSCO,      ');
    qryAux.SQL.Add('  SCO_PF_PJ_,      ');
    qryAux.SQL.Add('  SCO_CPFCNP,      ');
    qryAux.SQL.Add('  SCO_NUM_RG,      ');
    qryAux.SQL.Add('  SCO_DTANAS,      ');
    qryAux.SQL.Add('  SCO_ESTCIV,      ');
    qryAux.SQL.Add('  SCO_PER_PS       ');
    qryAux.SQL.Add(') VALUES (         ');
    qryAux.SQL.Add('  :AUTINC,         ');
    qryAux.SQL.Add('  :CODCLI,         ');
    qryAux.SQL.Add('  :NOMSCO,         ');
    qryAux.SQL.Add('  :PF_PJ_,         ');
    qryAux.SQL.Add('  :CPFCNP,         ');
    qryAux.SQL.Add('  :NUM_RG,         ');
    qryAux.SQL.Add('  :DTANAS,         ');
    qryAux.SQL.Add('  :ESTCIV,         ');
    qryAux.SQL.Add('  :PER_PS)         ');

    If fEmptyStr(FAutoincrem) Then
      FAutoincrem := fRetAutoIncrem('CLISCO', VS_strCodEmp);

    qryAux.ParamByName('AUTINC').AsString := FAutoincrem;
    qryAux.ParamByName('CODCLI').AsString := FCodCli;
    qryAux.ParamByName('NOMSCO').AsString := FNomSco;

    If FPF_PJ_ <> '' Then
      qryAux.ParamByName('PF_PJ_').AsString := FPF_PJ_
    Else
      qryAux.ParamByName('PF_PJ_').IsNull;

    If FCpfCnp <> '' Then
      qryAux.ParamByName('CPFCNP').AsString := FCpfCnp
    Else
      qryAux.ParamByName('CPFCNP').IsNull;

    If FNum_RG <> '' Then
      qryAux.ParamByName('NUM_RG').AsString := FNum_RG
    Else
      qryAux.ParamByName('NUM_RG').IsNull;

    If FDtaNas > 0 Then
      qryAux.ParamByName('DTANAS').AsDateTime := FDtaNas
    Else
      qryAux.ParamByName('DTANAS').IsNull;

    If FEstCiv <> '' Then
      qryAux.ParamByName('ESTCIV').AsString := FEstCiv
    Else
      qryAux.ParamByName('ESTCIV').IsNull;

    If FPer_Ps > 0 Then
      qryAux.ParamByName('PER_PS').AsFloat := FPer_Ps
    Else
      qryAux.ParamByName('PER_PS').AsFloat := 0;

    qryAux.ExecSQL;
    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

End;

procedure TCliSco.pZeraValores;
begin
  FAutoincrem := '';
  FCodCli     := '';
  FNomSco     := '';
  FPF_PJ_     := '';
  FCpfCnp     := '';
  FNum_RG     := '';
  FDtaNas     := 0;
  FEstCiv     := '';
  FPer_Ps     := 0;
end;

procedure TCliSco.setAutoincrem(Value: String);
begin
  FAutoincrem := Value;
end;

procedure TCliSco.setCodCli(Value: String);
begin
  FCodCli := Value;
end;

procedure TCliSco.setCpfCnp(Value: String);
begin
  FCpfCnp := Value;
end;

procedure TCliSco.setDtaNas(Value: TDate);
begin
  FDtaNas := Value;
end;

procedure TCliSco.setEstCiv(Value: String);
begin
  FEstCiv := Value;
end;

procedure TCliSco.setNomSco(Value: String);
begin
  FNomSco := Value;
end;

procedure TCliSco.setNum_RG(Value: String);
begin
  FNum_RG := Value;
end;

procedure TCliSco.setPer_Ps(Value: Real);
begin
  FPer_Ps := Value;
end;

procedure TCliSco.setPF_PJ_(Value: String);
begin
  FPF_PJ_ := Value;
end;

end.
