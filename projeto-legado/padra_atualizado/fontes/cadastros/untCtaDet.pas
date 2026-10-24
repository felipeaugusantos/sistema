unit untCtaDet;

interface

uses
  StrUtils, SysUtils, Classes, Forms, DB, untFuncoesSimples, Uni,
  System.Generics.Collections;

Type
  TCtaDetList = class;

  TCtaDet = Class
  Private
    FCodCta: String;
    FEmpDet: String;
    FCodEve: String;
    FCtaDet: string;
    FPerCen: Double;
    FCodEmp: String;
    FAutInc: String;
    procedure SetCodCta(const Value: String);
    procedure SetCodEmp(const Value: String);
    procedure SetPerCen(const Value: Double);
    procedure SetCodEve(const Value: String);

    function GetNomEmp: String;
    function GetNomCtaDet: String;

    procedure pInserir;
    procedure pAtualizar;
  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    property strCodCta: String Read FCodCta Write SetCodCta;

    property strEmpDet: String Read FEmpDet Write FEmpDet;
    property strNomEmp: String Read GetNomEmp;

    property strCtaDet: string read FCtaDet write FCtaDet;
    property strNomCtaDet: string read GetNomCtaDet;

    property fltPerCen: Double Read FPerCen Write SetPerCen;
    property strCodEve: String Read FCodEve Write SetCodEve;
    property strCodEmp: String Read FCodEmp Write SetCodEmp;

    property strAutInc: String Read FAutInc;

    procedure pValidar;
    procedure pSalvar;
    procedure pDeletar;

    Constructor Create; Reintroduce;

    class function fRetornaRateios(const strCodCta: String): TCtaDetList;

    class function fContaPossuiRateios(const strCodCta: String): boolean;

  End;

  TCtaDetList = class(TObjectList<TCtaDet>)
  public
    function IndexOf(const pStrCodCta, pStrEmpDet, pStrCtaDet,pStrCodEve: string): integer; overload;
  end;

implementation

uses untConstantes, Math, untTypesSistema;

{ TCtaDetList }

function TCtaDetList.IndexOf(const pStrCodCta, pStrEmpDet,
  pStrCtaDet,pStrCodEve: string): integer;
var
  i: integer;
begin
  Result := -1;
  for i := 0 to Self.Count - 1 do
  begin
    if (CompareText(Self[i].strCodCta, pStrCodCta) = 0) and
       (CompareText(Self[i].strEmpDet, pStrEmpDet) = 0) and
       (CompareText(Self[i].strCtaDet, pStrCtaDet) = 0) and
       (CompareText(Self[i].strCodEve, pStrCodEve) = 0)then
    begin
      Result := i;
      Break;
    end;
  end;
end;

{ TCtaDet }

constructor TCtaDet.Create;
begin
  inherited;
  FCodCta := '';
  FEmpDet := '';
  FCodEve := '';
  FPerCen := 0.0;
  FCodEmp := '';
  FCtaDet := '';
  FAutInc := '';
end;

class function TCtaDet.fContaPossuiRateios(const strCodCta: String): boolean;
var
  oCtaDetList: TCtaDetList;
begin
  oCtaDetList := fRetornaRateios(strCodCta);
  try
    Result := oCtaDetList.Count > 0;
  finally
    oCtaDetList.Free;
  end;
end;

class function TCtaDet.fRetornaRateios(const strCodCta: String): TCtaDetList;
Var
  QryAux: TUniQuery;
  objRat: TCtaDet;
begin
  Result := TCtaDetList.Create;
  QryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  * ');
    qryAux.SQL.Add('FROM  ');
    qryAux.SQL.Add('  CTADET ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTA_CODCTA = :CODCTA ');

    qryAux.ParamByName('CODCTA').AsString := strCodCta;
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      objRat := TCtaDet.Create;
      objRat.strCodCta := qryAux.FieldByname('CTA_CODCTA').AsString;
      objRat.strEmpDet := qryAux.FieldByname('CTA_EMPDET').AsString;
      objRat.strCodEve := qryAux.FieldByname('CTA_CODEVE').AsString;
      objRat.fltPerCen := qryAux.FieldByname('CTA_PERCEN').AsFloat;
      objRat.strCodEmp := qryAux.FieldByname('CTA_CODEMP').AsString;
      objRat.strCtaDet := qryAux.FieldByname('CTA_CTADET').AsString;
      objRat.FAutInc   := qryAux.FieldByname('AUTOINCREM').AsString;
      Result.Add(objRat);
      qryAux.Next;
    End;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TCtaDet.GetNomCtaDet: String;
begin
  result := fRetNomeConta(strCtaDet);
end;

function TCtaDet.GetNomEmp: String;
begin
  Result := fRetNomeEmpresa(strEmpDet);
end;

procedure TCtaDet.pAtualizar;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  CTADET ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  CTA_PERCEN = :PERCEN ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTA_CODCTA = :CODCTA AND ');
    qryAux.SQL.Add('  COALESCE(CTA_EMPDET,'''') = :EMPDET AND ');
    qryAux.SQL.Add('  COALESCE(CTA_CTADET,'''') = :CTADET ');

    If Not fEmptyStr(strCodEve) Then
      qryAux.SQL.Add(' AND CTA_CODEVE = :CODEVE  ');

    qryAux.ParamByName('CODCTA').AsString := strCodCta;
    qryAux.ParamByName('EMPDET').AsString := strEmpDet;
    qryAux.ParamByName('CTADET').AsString := strCtaDet;
    qryAux.ParamByName('PERCEN').AsFloat  := fltPerCen;

    If Not fEmptyStr(strCodEve) Then
      qryAux.ParamByName('CODEVE').AsString := strCodEve;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TCtaDet.pDeletar;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('DELETE FROM ');
    qryAux.SQL.Add('  CTADET ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTA_CODCTA = :CODCTA AND ');
    qryAux.SQL.Add('  COALESCE(CTA_EMPDET,'''') = :EMPDET AND ');
    qryAux.SQL.Add('  COALESCE(CTA_CTADET,'''') = :CTADET ');
    qryAux.SQL.Add('ORDER BY CTA_EMPDET, CTA_CTADET');

    qryAux.ParamByName('CODCTA').AsString := strCodCta;
    qryAux.ParamByName('EMPDET').AsString := strEmpDet;
    qryAux.ParamByName('CTADET').AsString := strCtaDet;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TCtaDet.pInserir;
Var
  qryAux: TUniQuery;
begin
  FAutInc := fRetAutoIncrem('CTADET', VS_strCodEmp);
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('INSERT INTO ');
    qryAux.SQL.Add('  CTADET ');
    qryAux.SQL.Add('( ');
    qryAux.SQL.Add('  CTA_CODCTA, ');
    qryAux.SQL.Add('  CTA_EMPDET, ');
    qryAux.SQL.Add('  CTA_CTADET, ');
    qryAux.SQL.Add('  CTA_PERCEN, ');
    qryAux.SQL.Add('  CTA_CODEMP, ');

    If Not fEmptyStr(strCodEve) Then
   	  qryAux.SQL.Add('  CTA_CODEVE, ');

    qryAux.SQL.Add('  AUTOINCREM) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :CODCTA, ');

    qryAux.SQL.Add('  CASE :EMPDET ');
    qryAux.SQL.Add('    WHEN '''' THEN ');
    qryAux.SQL.Add('      NULL ');
    qryAux.SQL.Add('    ELSE ');
    qryAux.SQL.Add('      :EMPDET ');
    qryAux.SQL.Add('  END, ');

    qryAux.SQL.Add('  CASE :CTADET ');
    qryAux.SQL.Add('    WHEN '''' THEN ');
    qryAux.SQL.Add('      NULL ');
    qryAux.SQL.Add('    ELSE ');
    qryAux.SQL.Add('      :CTADET ');
    qryAux.SQL.Add('  END, ');

    qryAux.SQL.Add('  :PERCEN, ');
    qryAux.SQL.Add('  :CODEMP, ');

    If Not fEmptyStr(strCodEve) Then
      qryAux.SQL.Add('  :CODEVE, ');

    qryAux.SQL.Add('  :AUTINC) ');

    qryAux.ParamByName('CODCTA').AsString := strCodCta;
    qryAux.ParamByName('EMPDET').AsString := strEmpDet;

    If Not fEmptyStr(strCodEve) Then
      qryAux.ParamByName('CODEVE').AsString := strCodEve;

    qryAux.ParamByName('CTADET').AsString := strCtaDet;
    qryAux.ParamByName('PERCEN').AsFloat  := fltPerCen;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('AUTINC').AsString := FAutInc;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TCtaDet.pSalvar;
begin
  pValidar;

  If fEmptyStr(strAutInc) Then
    pInserir
  Else
    pAtualizar;
end;

procedure TCtaDet.pValidar;
begin
  SetCodCta(FCodCta);
  SetCodEmp(FCodEmp);
  SetPerCen(FPerCen);
  setCodEve(FCodEve);

  if fEmptyStr(strEmpDet) and fEmptyStr(strCtaDet) then
    Raise ExceptionAutCom.Create('Empresa e/ou Plano de Contas deve ser preenchido.');
end;

procedure TCtaDet.SetCodCta(const Value: String);
begin
  If fEmptyStr(Value) Then
    Raise ExceptionAutCom.Create('O Plano de Contas deve ser preenchido.');

  FCodCta := Value;
end;

procedure TCtaDet.SetCodEmp(const Value: String);
begin
  If fEmptyStr(Value) Then
    Raise ExceptionAutCom.Create('O código da empresa de cadastro deve ser preenchido.');

  FCodEmp := Value;
end;

procedure TCtaDet.SetCodEve(const Value: String);
begin
  FCodEve := Value;
end;

procedure TCtaDet.SetPerCen(const Value: Double);
begin
  If Not InRange(Value, 0.00, 100.00) Then
    Raise ExceptionAutCom.Create('O percentual deve ser um valor maior que 0 (zero) e menor ou igual a 100 (cem).');

  FPerCen := Value;
end;

end.
