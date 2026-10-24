unit untComDepDAO;

interface

uses
  untComDep, System.SysUtils, Uni;

type
  TComDepDAO = class
  private
    qryComDep: TUniQuery;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
    function fMontaObjComDep: TComDep;
    procedure pPreencheParametrosQryComDep(objComDep: TComDep);
    procedure pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
    function fExecutaConsulta(strCondicao: String): TComDep;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objComDep: TComDep): Boolean;
    function fDeletar(strAutInc: String): Boolean;
    function fBuscarPorAutoIncremento(strAutInc: String): TComDep;
    function fBuscaPorDepEFaixaDeFaturamento(strCodDep: String; fltFatIni, fltFatFin: Double): TComDep;
    function fBuscarPorCodigo(strCodCom: String): TComDep;
  end;

implementation

uses
  untFuncoesSimples;

{ TComDepDAO }

constructor TComDepDAO.Create;
begin
  qryComDep := fCriaQuery;
end;

destructor TComDepDAO.Destroy;
begin
  FreeAndNil(qryComDep);
end;

function TComDepDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO COMDEP (   '+
            '    AUTOINCREM,          '+
            '    COM_CODCOM,          '+
            '    COM_DESCOM,          '+
            '    COM_CODDEP,          '+
            '    COM_FATINI,          '+
            '    COM_FATFIN           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODCOM,           '+
            '      :DESCOM,           '+
            '      :CODDEP,           '+
            '      :FATINI,           '+
            '      :FATFIN            '+
            '    )                    ';
end;

function TComDepDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    COMDEP                  '+
            '  SET                       '+
            '    COM_CODCOM = :CODCOM,   '+
            '    COM_DESCOM = :DESCOM,   '+
            '    COM_CODDEP = :CODDEP,   '+
            '    COM_FATINI = :FATINI,   '+
            '    COM_FATFIN = :FATFIN    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TComDepDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM COMDEP      '+
            #13 + strCondicao;
end;

function TComDepDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM COMDEP        '+
            #13 + strCondicao;
end;

function TComDepDAO.fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
  Var
    strSQLWhere: String;
    strCondicao: String;
    intIndex: Integer;
begin
  For intIndex := 0 To Length(arrCampos) - 1 Do
  Begin
    strCondicao := arrCampos[intIndex] + ' = ' + QuotedStr(arrValores[intIndex]);
    pIncluiCondicaoSQLWhere(strSQLWhere, strCondicao);
  End;

  strSQLWhere := #13 + ' WHERE ' + #13 + strSQLWhere;

  Result := strSQLWhere;
end;

procedure TComDepDAO.pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
begin
  If (Not fEmptyStr(strSQLWhere)) Then
    strSQLWhere := strSQLWhere + #13 + ' AND ';

  strSQLWhere := strSQLWhere + strCondicao;
end;

function TComDepDAO.fBuscarPorAutoIncremento(strAutInc: String): TComDep;
begin
  Result := fExecutaConsulta(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
end;

function TComDepDAO.fBuscarPorCodigo(strCodCom: String): TComDep;
begin
  Result := fExecutaConsulta(fMontaSQLCondicao(['COM_CODCOM'], [strCodCom]));
end;

function TComDepDAO.fBuscaPorDepEFaixaDeFaturamento(strCodDep: String; fltFatIni, fltFatFin: Double): TComDep;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE COM_CODDEP  = '+ QuotedStr(strCodDep) +
                 '   AND COM_FATINI <= '+ QuotedStr(FloatToStr(fltFatIni))+
                 '   AND COM_FATFIN >= '+ QuotedStr(FloatToStr(fltFatFin));

  Result := fExecutaConsulta(strCondicao);
end;

function TComDepDAO.fExecutaConsulta(strCondicao: String): TComDep;
begin
  qryComDep.Close;
  qryComDep.SQL.Clear;
  qryComDep.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryComDep.Open;

  Result := fMontaObjComDep;
end;

function TComDepDAO.fDeletar(strAutInc: String): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryComDep.Close;
    qryComDep.SQL.Clear;
    qryComDep.SQL.Text := fRetornaSQLDelete(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
    qryComDep.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TComDepDAO.fGravar(objComDep: TComDep): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryComDep.Close;
    qryComDep.SQL.Clear;
    qryComDep.SQL.Text := IIF(fEmptyStr(objComDep.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);

    pPreencheParametrosQryComDep(objComDep);
    qryComDep.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

procedure TComDepDAO.pPreencheParametrosQryComDep(objComDep: TComDep);
begin
  If (qryComDep.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objComDep.getAutInc)) Then
      qryComDep.ParamByName('AUTINC').AsString := fRetAutoIncrem('COMDEP', VS_strCodEmp)
    Else
      qryComDep.ParamByName('AUTINC').AsString := objComDep.getAutInc;
  End;

  qryComDep.ParamByName('CODCOM').AsString := objComDep.getCodCom();
  qryComDep.ParamByName('DESCOM').AsString := objComDep.getDesCom();
  qryComDep.ParamByName('CODDEP').AsString := objComDep.getCodDep();
  qryComDep.ParamByName('FATINI').AsFloat  := objComDep.getFatIni();
  qryComDep.ParamByName('FATFIN').AsFloat  := objComDep.getFatFin();
end;

function TComDepDAO.fMontaObjComDep: TComDep;
begin
  Result := Nil;

  If (qryComDep.IsEmpty) Then
    Exit;

  Result := Result.getInstance(qryComDep.FieldByName('AUTOINCREM').AsString,
                               qryComDep.FieldByName('COM_CODCOM').AsString,
                               qryComDep.FieldByName('COM_DESCOM').AsString,
                               qryComDep.FieldByName('COM_CODDEP').AsString,
                               qryComDep.FieldByName('COM_FATINI').AsFloat,
                               qryComDep.FieldByName('COM_FATFIN').AsFloat);
end;

end.
