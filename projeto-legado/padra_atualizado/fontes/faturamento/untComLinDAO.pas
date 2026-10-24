unit untComLinDAO;

interface

uses
  untComLin, System.SysUtils, Uni;

type
  TComLinDAO = class
  private
    qryTabela: TUniQuery;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
    function fMontaObjModel: TComLin;
    procedure pPreencheParametrosQuery(Var objDados: TComLin);
    procedure pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
    function fExecutaConsulta(strCondicao: String): TComLin;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TComLin): String;
    function fDeletar(strAutInc: String): Boolean;
    function fBuscarPorAutoIncremento(strAutInc: String): TComLin;
    function fBuscaPorVendedorEmpresa(strCodEmp, strCodVen: String): TComLin;
  end;

implementation

uses
  untFuncoesSimples;

{ TComLinDAO }

constructor TComLinDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TComLinDAO.Destroy;
begin
  FreeAndNil(qryTabela);
end;

function TComLinDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO COMLIN (   '+
            '    AUTOINCREM,          '+
            '    COM_CODEMP,          '+
            '    COM_CODVEN           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODEMP,           '+
            '      :CODVEN            '+
            '    )                    ';
end;

function TComLinDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    COMLIN                  '+
            '  SET                       '+
            '    COM_CODEMP = :CODEMP,   '+
            '    COM_CODVEN = :CODVEN    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TComLinDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM COMLIN      '+
            #13 + strCondicao;
end;

function TComLinDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM COMLIN        '+
            #13 + strCondicao;
end;

function TComLinDAO.fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
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

procedure TComLinDAO.pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
begin
  If (Not fEmptyStr(strSQLWhere)) Then
    strSQLWhere := strSQLWhere + #13 + ' AND ';

  strSQLWhere := strSQLWhere + strCondicao;
end;

function TComLinDAO.fBuscarPorAutoIncremento(strAutInc: String): TComLin;
begin
  Result := fExecutaConsulta(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
end;

function TComLinDAO.fBuscaPorVendedorEmpresa(strCodEmp, strCodVen: String): TComLin;
begin
  Result := fExecutaConsulta(fMontaSQLCondicao(['COM_CODEMP', 'COM_CODVEN'],
                                               [strCodEmp, strCodVen]));
end;

function TComLinDAO.fExecutaConsulta(strCondicao: String): TComLin;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryTabela.Open;

  Result := fMontaObjModel;
end;

function TComLinDAO.fDeletar(strAutInc: String): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := fRetornaSQLDelete(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TComLinDAO.fGravar(objDados: TComLin): String;
begin
  Result := '';

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := IIF(fEmptyStr(objDados.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);

  pPreencheParametrosQuery(objDados);
  qryTabela.ExecSQL;

  Result := objDados.getAutInc;
end;

procedure TComLinDAO.pPreencheParametrosQuery(Var objDados: TComLin);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      objDados.setAutInc(fRetAutoIncrem('COMLIN', VS_strCodEmp));

    qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('CODVEN').AsString := objDados.getCodVen();
end;

function TComLinDAO.fMontaObjModel: TComLin;
begin
  Result := Nil;

  If (qryTabela.IsEmpty) Then
    Exit;

  Result := Result.getInstance(qryTabela.FieldByName('AUTOINCREM').AsString,
                               qryTabela.FieldByName('COM_CODEMP').AsString,
                               qryTabela.FieldByName('COM_CODVEN').AsString);
end;

end.
