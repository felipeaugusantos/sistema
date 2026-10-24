unit untMetMarDAO;

interface

uses
  System.SysUtils, Uni, untMetMar, Data.DB, UniClientDataSet;

Type
  TObjDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaObjModel(objDados: TDataSet): TMetMar;
    function fExecutaTransacao(strSQL: String; objDados: TMetMar = Nil): Boolean;
    procedure pPreencheParametrosQuery(objDados: TMetMar);
  public
    constructor Create;
    destructor Destroy; override;

    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fGravar(objDados: TMetMar): Boolean;
    function fDeletarPorPeriodo(strCodVen, strMesAno: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

constructor TObjDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TObjDAO.Destroy;
begin
  inherited;
  FreeAndNil(qryTabela);
end;

function TObjDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO METMAR (   '+
            '    AUTOINCREM,          '+
            '    MET_CODEMP,          '+
            '    MET_CODVEN,          '+
            '    MET_MESANO,          '+
            '    MET_CODMAR,          '+
            '    MET_PERMAR           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODEMP,           '+
            '      :CODVEN,           '+
            '      :MESANO,           '+
            '      :CODMAR,           '+
            '      :PERMAR            '+
            '    )                    ';
end;

function TObjDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    METMAR                  '+
            '  SET                       '+
            '    MET_CODEMP = :CODEMP,   '+
            '    MET_CODVEN = :CODVEN,   '+
            '    MET_MESANO = :MESANO,   '+
            '    MET_CODMAR = :CODMAR,   '+
            '    MET_PERMAR = :PERMAR    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TObjDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := ' DELETE FROM METMAR '+
            #13 + strCondicao;
end;

function TObjDAO.fGravar(objDados: TMetMar): Boolean;
  Var
    strSQL: String;
begin
  strSQL := IIF(fEmptyStr(objDados.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);
  Result := fExecutaTransacao(strSQL, objDados);
end;

function TObjDAO.fDeletarPorPeriodo(strCodVen, strMesAno: String): Boolean;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE MET_CODVEN  = '+ QuotedStr(strCodVen)+
                 '   AND MET_MESANO  = '+ QuotedStr(strMesAno);

  Result := fExecutaTransacao(fRetornaSQLDelete(strCondicao));
end;

function TObjDAO.fExecutaTransacao(strSQL: String; objDados: TMetMar = Nil): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := strSQL;

    If (Assigned(objDados)) Then
      pPreencheParametrosQuery(objDados);

    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TObjDAO.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;
  cdsDados.First;

  While (Not cdsDados.Eof) Do
  Begin
    If (Not fGravar(fMontaObjModel(cdsDados))) Then
      Exit;
    cdsDados.Next;
  End;

   Result := True;
end;

procedure TObjDAO.pPreencheParametrosQuery(objDados: TMetMar);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('METMAR', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('CODVEN').AsString := objDados.getCodVen();
  qryTabela.ParamByName('MESANO').AsString := objDados.getMesAno();
  qryTabela.ParamByName('CODMAR').AsString := objDados.getCodMar();
  qryTabela.ParamByName('PERMAR').AsFloat  := objDados.getPerMar();
end;

function TObjDAO.fMontaObjModel(objDados: TDataSet): TMetMar;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TMetMar.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('MET_CODEMP').AsString,
                           objDados.FieldByName('MET_MESANO').AsString,
                           objDados.FieldByName('MET_CODVEN').AsString,
                           objDados.FieldByName('MET_CODMAR').AsString,
                           objDados.FieldByName('MET_PERMAR').AsFloat);
end;

end.
