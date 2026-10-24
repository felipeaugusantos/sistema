unit untCadMixDAO;

interface

uses
  untCadMix, System.SysUtils, Uni, UniClientDataSet, Data.DB;

type
  TCadMixDAO = class
  private
    qryTabela: TUniQuery;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
    procedure pPreencheParametrosQuery(objDados: TCadMix);
    procedure pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
    function fMontaObjeto(objDados: TDataSet): TCadMix;
    function fExecutaConsulta(strCondicao: String): TCadMix;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TCadMix): Boolean;
    function fDeletar(strAutInc: String): Boolean;
    function fBuscaPorEmpresa(strCodEmp: String): TCadMix;
    function fBuscarPorAutoIncremento(strAutInc: String): TCadMix;
  end;

implementation

uses
  untFuncoesSimples;

{ TCadMixDAO }

constructor TCadMixDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TCadMixDAO.Destroy;
begin
  FreeAndNil(qryTabela);
end;

function TCadMixDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO CADMIX (  '+
            '    AUTOINCREM,         '+
            '    MIX_CODEMP,         '+
            '    MIX_PERMET          '+
            '  )                     '+
            '  VALUES                '+
            '    (                   '+
            '     :AUTINC,           '+
            '     :CODEMP,           '+
            '     :PERMET            '+
            '    )                   ';
end;

function TCadMixDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    CADMIX                  '+
            '  SET                       '+
            '    MIX_CODEMP = :CODEMP,   '+
            '    MIX_PERMET = :PERMET    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TCadMixDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM CADMIX      '+
            #13 + strCondicao;
end;

function TCadMixDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM CADMIX        '+
            #13 + strCondicao;
end;

function TCadMixDAO.fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
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

procedure TCadMixDAO.pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
begin
  If (Not fEmptyStr(strSQLWhere)) Then
    strSQLWhere := strSQLWhere + #13 + ' AND ';

  strSQLWhere := strSQLWhere + strCondicao;
end;

function TCadMixDAO.fExecutaConsulta(strCondicao: String): TCadMix;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryTabela.Open;

  Result := fMontaObjeto(qryTabela);
end;

function TCadMixDAO.fBuscaPorEmpresa(strCodEmp: String): TCadMix;
  Var
    strCondicao: String;
begin
  strCondicao := fMontaSQLCondicao(['MIX_CODEMP'], [strCodEmp]);

  Result := fExecutaConsulta(strCondicao);
end;

function TCadMixDAO.fBuscarPorAutoIncremento(strAutInc: String): TCadMix;
begin
  Result := fExecutaConsulta(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
end;

function TCadMixDAO.fDeletar(strAutInc: String): Boolean;
begin
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
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TCadMixDAO.fGravar(objDados: TCadMix): Boolean;
begin
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
       Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TCadMixDAO.pPreencheParametrosQuery(objDados: TCadMix);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADMIX', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('PERMET').AsFloat  := objDados.getPerMet();
end;

function TCadMixDAO.fMontaObjeto(objDados: TDataSet): TCadMix;
begin
  Result := Nil;

  If (Not Assigned(objDados)) Or (objDados.IsEmpty) Then
    Exit;

  Result := TCadMix.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('MIX_CODEMP').AsString,
                           objDados.FieldByName('MIX_PERMET').AsFloat);
end;

end.
