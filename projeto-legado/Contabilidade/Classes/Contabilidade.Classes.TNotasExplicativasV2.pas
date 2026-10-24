unit Contabilidade.Classes.TNotasExplicativasV2;

interface

uses Classes, Uni, UniClientDataSet;

type
  TNotasExplicativasParametros = class
  private
    class function fGetSqlInsertNTEXPL: string;
    class function fGetSqlUpdateNTEXPL: string;
    class function fGetSqlDeleteNTEXPL: string;
  public
    class procedure Carregar(const ACodigo: integer; var cdsParametros : TUniClientDataSet) ;
    class function Gravar(const cdsParametros : TUniClientDataSet; const ModoInsert: Boolean):boolean ;
    class function Deletar(const ACodigo: integer):boolean ;
  end;

  TNotasExplicativasGerar = class
  private
    FAnoExercicio: integer ;
    FEmpresas: TStringList ;
    function EmpresasToStr:string ;
  public
    property AnoExercicio : integer read FAnoExercicio write FAnoExercicio ;
    property Empresas : TStringList read FEmpresas write FEmpresas ;
    function Processar:TUniClientDataset ;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples, SysUtils ;

{ TNotasExplicativasParametros }

class procedure TNotasExplicativasParametros.Carregar(const ACodigo: integer;
  var cdsParametros: TUniClientDataSet);
var
  strSql : string ;
  qryParametros: TUniQuery;
begin
  strSql := '' ;
  strSql := strSql + ' SELECT ' ;
  strSql := strSql + '  AUTOINCREM, ' ;
  strSql := strSql + '  EXP_CODIGO, ' ;
  strSql := strSql + '  EXP_NOTEXP, ' ;
  strSql := strSql + '  EXP_ANOINI, ' ;
  strSql := strSql + '  EXP_ANOFIN  ' ;
  strSql := strSql + ' FROM NTEXPL ' ;
  strSql := strSql + ' WHERE EXP_CODIGO = :CODIGO ' ;
  strSql := strSql + ' ORDER BY EXP_CODIGO' ;

  qryParametros := fCriaQuery;
  try
    qryParametros.Close ;
    qryParametros.SQL.Clear ;
    qryParametros.SQL.Add(strSql) ;
    qryParametros.ParamByName('CODIGO').AsInteger := ACodigo ;
    qryParametros.Open ;

    If Assigned(cdsParametros) Then
      FreeAndNil(cdsParametros);

    cdsParametros := fCriaClientDatset(qryParametros);

  finally
    FreeAndNil(qryParametros);
  end;

end;

class function TNotasExplicativasParametros.Deletar(
  const ACodigo: integer): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    try
      qryExec.Close ;
      qryExec.SQL.Clear ;
      qryExec.SQL.Add(fGetSqlDeleteNTEXPL);
      qryExec.ParamByName('CODIGO').AsInteger := ACodigo ;
      qryExec.ExecSQL ;

    finally
      FreeAndNil(qryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  End;
  result := True ;
end;

class function TNotasExplicativasParametros.fGetSqlDeleteNTEXPL: string;
begin
  result := 'DELETE FROM NTEXPL WHERE EXP_CODIGO = :CODIGO; ' ;
end;

class function TNotasExplicativasParametros.fGetSqlInsertNTEXPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' INSERT INTO NTEXPL ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' AUTOINCREM, ' ;
  strSql := strSql + ' EXP_CODIGO, ' ;
  strSql := strSql + ' EXP_NOTEXP, ' ;
  strSql := strSql + ' EXP_ANOINI, ' ;
  strSql := strSql + ' EXP_ANOFIN ' ;
  strSql := strSql + ' ) ' ;
  strSql := strSql + ' VALUES ' ;
  strSql := strSql + ' ( ' ;
  strSql := strSql + ' :AUTOINCREM, ' ;
  strSql := strSql + ' :CODIGO, ' ;
  strSql := strSql + ' :NOTEXP, ' ;
  strSql := strSql + ' :ANOINI, ' ;
  strSql := strSql + ' :ANOFIN ' ;
  strSql := strSql + ' ); ' ;
  result := strSql ;
end;

class function TNotasExplicativasParametros.fGetSqlUpdateNTEXPL: string;
var
  strSql: string ;
begin
  strSql := '' ;
  strSql := strSql + ' UPDATE NTEXPL ' ;
  strSql := strSql + ' SET ' ;
  strSql := strSql + ' EXP_CODIGO = :CODIGO, ' ;
  strSql := strSql + ' EXP_NOTEXP = :NOTEXP, ' ;
  strSql := strSql + ' EXP_ANOINI = :ANOINI, ' ;
  strSql := strSql + ' EXP_ANOFIN = :ANOFIN ' ;
  strSql := strSql + ' WHERE AUTOINCREM = :AUTOINCREM ' ;
  result := strSql ;
end;

class function TNotasExplicativasParametros.Gravar(
  const cdsParametros: TUniClientDataSet; const ModoInsert: Boolean): boolean;
var
  qryExec : TUniQuery ;
begin
  fStartTransaction;
  try
    qryExec := fCriaQuery ;
    try
      qryExec.Close ;
      qryExec.SQL.Clear ;
      if ModoInsert then
      begin
        qryExec.SQL.Add(fGetSqlInsertNTEXPL);
        qryExec.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('NTEXPL',Vs_strCodEmp)  ;
        qryExec.ParamByName('CODIGO').AsInteger := cdsParametros.FieldByName('EXP_CODIGO').AsInteger  ;
        qryExec.ParamByName('NOTEXP').AsString :=  cdsParametros.FieldByName('EXP_NOTEXP').AsString  ;
        qryExec.ParamByName('ANOINI').AsString := cdsParametros.FieldByName('EXP_ANOINI').AsString  ;
        qryExec.ParamByName('ANOFIN').AsString := cdsParametros.FieldByName('EXP_ANOFIN').AsString  ;
        qryExec.ExecSQL ;
      end
      else
      begin
        qryExec.SQL.Add(fGetSqlUpdateNTEXPL);
        qryExec.ParamByName('AUTOINCREM').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString  ;
        qryExec.ParamByName('CODIGO').AsInteger := cdsParametros.FieldByName('EXP_CODIGO').AsInteger  ;
        qryExec.ParamByName('NOTEXP').AsString :=  cdsParametros.FieldByName('EXP_NOTEXP').AsString  ;
        qryExec.ParamByName('ANOINI').AsString := cdsParametros.FieldByName('EXP_ANOINI').AsString  ;
        qryExec.ParamByName('ANOFIN').AsString := cdsParametros.FieldByName('EXP_ANOFIN').AsString  ;
        qryExec.ExecSQL ;
      end;
    finally
      FreeAndNil(qryExec) ;
    end;
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      raise E ;
    End;
  End;
  result := True ;
end;

{ TNotasExplicativasGerar }

constructor TNotasExplicativasGerar.Create;
begin
  FEmpresas := TStringList.Create;
end;

destructor TNotasExplicativasGerar.Destroy;
begin
  FreeAndNil(FEmpresas) ;
  inherited;
end;

function TNotasExplicativasGerar.EmpresasToStr: string;
var
  intCnt : integer ;
begin
  result := '' ;
  for intCnt := 0 to FEmpresas.Count-1 do
  begin
    if fEmptyStr(result) then
    begin
      result := quotedstr(FEmpresas.Strings[intCnt]) ;
    end
    else
    begin
      result := result + ',' + quotedstr(FEmpresas.Strings[intCnt]) ;
    end;
  end;
end;

function TNotasExplicativasGerar.Processar: TUniClientDataset;
var
  qryGerar : TUniQuery ;
  cdsGerar : TUniClientDataset ;
  strEmpresas : String ;
  strFiltroEmpresas : string ;
begin
  result := nil ;
  strFiltroEmpresas := '' ;

  if FAnoExercicio <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  strEmpresas := EmpresasToStr ;
  if not fEmptyStr(strEmpresas) then
  begin
    strFiltroEmpresas := ' AND EMP_CODEMP IN ('+strEmpresas+') ' ;
  end;

  qryGerar := fCriaQuery() ;
  try
    qryGerar.Close ;
    qryGerar.SQL.Clear ;
    qryGerar.SQL.Add(' SELECT EXP_CODIGO, EXP_NOTEXP, EMP_CODEMP, EMP_NOMEMP ') ;
    qryGerar.SQL.Add(' FROM NTEXPL, CADEMP ') ;
    qryGerar.SQL.Add(' WHERE :EXERCI BETWEEN IF(COALESCE(EXP_ANOINI,0) = 0, 2000, EXP_ANOINI) AND IF(COALESCE(EXP_ANOFIN,0) = 0, 9999, EXP_ANOFIN) '+strFiltroEmpresas) ;
    qryGerar.ParamByName('EXERCI').AsInteger := FAnoExercicio ;
    qryGerar.Open ;

    cdsGerar := fCriaClientDatset(qryGerar) ;

    result := cdsGerar ;
  finally
    FreeAndNil(qryGerar) ;
  end;
end;

end.
