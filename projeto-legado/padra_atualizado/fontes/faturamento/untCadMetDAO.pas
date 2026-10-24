unit untCadMetDAO;

interface

uses
  System.SysUtils, Uni, untCadMet, Data.DB, UniClientDataSet;

Type
  TObjDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fExecutaConsulta(strCondicao: String): TCadMet;
    function fMontaObjModel(objDados: TDataSet): TCadMet;
    procedure pPreencheParametrosQuery(objDados: TCadMet);
  public
    constructor Create;
    destructor Destroy; override;
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fGravar(objDados: TCadMet): Boolean;
    function fBuscaPorMesAno(strCodVen, strMesAno: String): TCadMet;
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
  Result := '  INSERT INTO CADMET (   '+
            '    AUTOINCREM,          '+
            '    MET_CODEMP,          '+
            '    MET_CODVEN,          '+
            '    MET_MESANO,          '+
            '    MET_TOTMET,          '+
            '    MET_MARGEM,          '+
            '    MET_TOTFRE,          '+
            '    MET_ATEDIA,          '+
            '    MET_TICMED,          '+
            '    MET_ITEDOC           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODEMP,           '+
            '      :CODVEN,           '+
            '      :MESANO,           '+
            '      :TOTMET,           '+
            '      :MARGEM,           '+
            '      :TOTFRE,           '+
            '      :ATEDIA,           '+
            '      :TICMED,           '+
            '      :ITEDOC            '+
            '    )                    ';
end;

function TObjDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    CADMET                  '+
            '  SET                       '+
            '    MET_CODEMP = :CODEMP,   '+
            '    MET_CODVEN = :CODVEN,   '+
            '    MET_MESANO = :MESANO,   '+
            '    MET_TOTMET = :TOTMET,   '+
            '    MET_MARGEM = :MARGEM,   '+
            '    MET_TOTFRE = :TOTFRE,   '+
            '    MET_ATEDIA = :ATEDIA,   '+
            '    MET_TICMED = :TICMED,   '+
            '    MET_ITEDOC = :ITEDOC    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TObjDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM CADMET      '+
            #13 + strCondicao;
end;

function TObjDAO.fBuscaPorMesAno(strCodVen, strMesAno: String): TCadMet;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE MET_CODVEN  = '+ QuotedStr(strCodVen) +
                 '   AND MET_MESANO  = '+ QuotedStr(strMesAno);

  Result := fExecutaConsulta(strCondicao);
end;

function TObjDAO.fGravar(objDados: TCadMet): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := IIF(fEmptyStr(objDados.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);

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

procedure TObjDAO.pPreencheParametrosQuery(objDados: TCadMet);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADMET', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('CODVEN').AsString := objDados.getCodVen();
  qryTabela.ParamByName('MESANO').AsString := objDados.getMesAno();
  qryTabela.ParamByName('TOTMET').AsFloat  := objDados.getTotMet();
  qryTabela.ParamByName('MARGEM').AsFloat  := objDados.getMargem();
  qryTabela.ParamByName('TOTFRE').AsFloat  := objDados.getTotFre();
  qryTabela.ParamByName('ATEDIA').AsFloat  := objDados.getAteDia();
  qryTabela.ParamByName('TICMED').AsFloat  := objDados.getTicMed();
  qryTabela.ParamByName('ITEDOC').AsFloat  := objDados.getIteDoc();
end;

function TObjDAO.fExecutaConsulta(strCondicao: String): TCadMet;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryTabela.Open;

  Result := fMontaObjModel(qryTabela);
end;

function TObjDAO.fMontaObjModel(objDados: TDataSet): TCadMet;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TCadMet.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('MET_CODEMP').AsString,
                           objDados.FieldByName('MET_MESANO').AsString,
                           objDados.FieldByName('MET_CODVEN').AsString,
                           objDados.FieldByName('MET_TOTMET').AsFloat,
                           objDados.FieldByName('MET_MARGEM').AsFloat,
                           objDados.FieldByName('MET_TOTFRE').AsFloat,
                           objDados.FieldByName('MET_ATEDIA').AsFloat,
                           objDados.FieldByName('MET_TICMED').AsFloat,
                           objDados.FieldByName('MET_ITEDOC').AsFloat);
end;

end.
