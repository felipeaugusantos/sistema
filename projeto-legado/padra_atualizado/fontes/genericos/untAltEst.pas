unit untAltEst;

interface

uses Uni, Classes, EditFocus, MaskEditFocus, untTypesSistema, untConsultas, untFuncoesConsulta ;

Type
  TAltEst = Class(TComponent)
  Private
    FOwner       : TComponent;
    FqryConsulta : TUniQuery;
    FqryInsAlt   : TUniQuery;

  Public

    constructor Create(Owner : TComponent); reintroduce;

    Class Function fGravaLog(Owner : TComponent;
                             strCodIte, strCodEmp : String;
                             fltNewMin, fltNewMax : Double;
                             blnUptMin: Boolean = True;
                             blnUptMax: Boolean = True;
                             strCodOpe: String = '') : Boolean;

    Function fGravaLogEst(   strCodIte, strCodEmp : String;
                             fltNewMin, fltNewMax : Double;
                             blnUptMin: Boolean = True;
                             blnUptMax: Boolean = True;
                             strCodOpe: String = '') : Boolean;

    function fRetInsertGravaLogEstTmp: string;

    function fRetSQLCriaEstAnt(mskLinGru: TMaskEditFocus; edtCodFor, edtCodMar,edtPrdGru,edtGruCmp,edtCodDep,edtCodIte : TEditFocus;
                               arrLinhaGrupo, arrFornecedor, arrMarca,  arrGrupoPro, arrGruCmp, arrCodDep,arrCodIte: TConsultasArray;
                               strLinGru,     strFornecedor, strMarca,  strPrdGru,   strGruCmp, strCodDep, strEmpresa,strCodIte: string): String;

    procedure SetParametros(qry: TUniQuery; mskLinGru: TMaskEditFocus; edtCodFor, edtCodMar,edtPrdGru,edtGruCmp,edtCodDep,edtCodIte : TEditFocus;
                                            arrLinhaGrupo, arrFornecedor, arrMarca,  arrGrupoPro, arrGruCmp, arrCodDep, arrCodIte: TConsultasArray;
                                            strLinGru,     strFornecedor, strMarca,  strPrdGru,   strGruCmp, strCodDep, strEmpresa, strCodIte: string);

    Class Function fSQLInsertLog(strAutInc, strEmpresa, strCodIte,
            strEstMinAnt, strEstMinAtu, strEstMaxAnt, strEstMaxAtu: String): String;

    // === NOVO === Versão parametrizada para uso em loops preparados
    Class Function fSQLInsertLogParam: String;

  end;


implementation

uses SysUtils, untFuncoesSimples, Data.DB, StrUtils;

{ TAltEst }

constructor TAltEst.Create(Owner: TComponent);
begin
  if (not Assigned(Owner)) or (Owner = nil) Then
    Raise Exception.Create('Owner Não pode ser Vazio!');

  FOwner       := Owner;
  FqryConsulta := fCriaQuery(Self);
  With FqryConsulta, Sql Do
  Begin
    Clear;
    Add(' SELECT SQL_NO_CACHE ');
    Add('        ITE_ESTMAX, ');
    Add('        ITE_ESTMIN ');
    Add(' FROM ITEGER       ');
    Add(' WHERE ITE_CODITE = :CODITE ');
    Add('   AND ITE_CODEMP = :CODEMP ');

  End;

  FqryInsAlt   := fCriaQuery(Self);
  With FqryInsAlt, Sql Do
  Begin
    Clear;

    Add('INSERT INTO ALTEST');
    Add('(');
    Add('  AUTOINCREM,');
    Add('  LOG_DTAALT,');
    Add('  LOG_HRAALT,');
    Add('  LOG_CODOPE,');
    Add('  LOG_CODEMP,');
    Add('  LOG_CODITE,');
    Add('  LOG_MINANT,');
    Add('  LOG_MINATU,');
    Add('  LOG_MAXANT,');
    Add('  LOG_MAXATU,');
    Add('  LOG_NOMFRM');
    Add(' ) VALUES (');

    Add('  :AUTO,');
    Add('  :DTAALT,');
    Add('  :HRAALT,');
    Add('  :CODOPE,');
    Add('  :CODEMP,');
    Add('  :CODITE,');
    Add('  :MINANT,');
    Add('  :MINATU,');
    Add('  :MAXANT,');
    Add('  :MAXATU,');
    Add('  :NOMFRM');
    Add(' )');

  End;

end;

Class Function TAltEst.fSQLInsertLog(strAutInc, strEmpresa, strCodIte,
            strEstMinAnt, strEstMinAtu, strEstMaxAnt, strEstMaxAtu: String): String;
  Var
    strSQL: String;
Begin
  If strEstMinAnt.IsEmpty Then
    strEstMinAnt := ' NULL ';

  If strEstMinAtu.IsEmpty Then
    strEstMinAtu := ' NULL ';

  If strEstMaxAnt.IsEmpty Then
    strEstMaxAnt := ' NULL ';

  If strEstMaxAtu.IsEmpty Then
    strEstMaxAtu := ' NULL ';

  strEstMinAnt := AnsiReplaceStr(strEstMinAnt, ',', '.');
  strEstMinAtu := AnsiReplaceStr(strEstMinAtu, ',', '.');

  strEstMaxAnt := AnsiReplaceStr(strEstMaxAnt, ',', '.');
  strEstMaxAtu := AnsiReplaceStr(strEstMaxAtu, ',', '.');

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO ALTEST (';
  strSQL := strSQL + '  AUTOINCREM,';
  strSQL := strSQL + '  LOG_DTAALT,';
  strSQL := strSQL + '  LOG_HRAALT,';
  strSQL := strSQL + '  LOG_CODOPE,';
  strSQL := strSQL + '  LOG_CODEMP,';
  strSQL := strSQL + '  LOG_CODITE,';
  strSQL := strSQL + '  LOG_MINANT,';
  strSQL := strSQL + '  LOG_MINATU,';
  strSQL := strSQL + '  LOG_MAXANT,';
  strSQL := strSQL + '  LOG_MAXATU,';
  strSQL := strSQL + '  LOG_NOMFRM) ';

  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL +    QuotedStr(strAutInc) + ', ';
  strSQL := strSQL + '  CURDATE(), ';
  strSQL := strSQL + '  CURTIME(), ';
  strSQL := strSQL +    QuotedStr(strLoginUsuarioLogado) + ', ';
  strSQL := strSQL +    QuotedStr(strEmpresa) + ', ';
  strSQL := strSQL +    QuotedStr(strCodIte) + ', ';
  strSQL := strSQL +    strEstMinAnt + ', ';
  strSQL := strSQL +    strEstMinAtu + ', ';
  strSQL := strSQL +    strEstMaxAnt + ', ';
  strSQL := strSQL +    strEstMaxAtu + ', ';
  strSQL := strSQL + '  "frmCalEstMin"  ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL +      strEstMinAnt + ' <> ' + strEstMinAtu + ' OR ' + strEstMaxAnt + ' <> ' + strEstMaxAtu + '; ';

  Result := strSQL;
End;

Class Function TAltEst.fSQLInsertLogParam: String;
Begin
  // Statement único e parametrizado. @ESTMIN/@ESTMAX são variáveis de sessão
  // MySQL setadas pelo UPDATE imediatamente anterior na MESMA conexão.
  Result :=
    ' INSERT INTO ALTEST ('                                          + sLineBreak +
    '  AUTOINCREM,'                                                  + sLineBreak +
    '  LOG_DTAALT,'                                                  + sLineBreak +
    '  LOG_HRAALT,'                                                  + sLineBreak +
    '  LOG_CODOPE,'                                                  + sLineBreak +
    '  LOG_CODEMP,'                                                  + sLineBreak +
    '  LOG_CODITE,'                                                  + sLineBreak +
    '  LOG_MINANT,'                                                  + sLineBreak +
    '  LOG_MINATU,'                                                  + sLineBreak +
    '  LOG_MAXANT,'                                                  + sLineBreak +
    '  LOG_MAXATU,'                                                  + sLineBreak +
    '  LOG_NOMFRM) '                                                 + sLineBreak +
    ' SELECT '                                                       + sLineBreak +
    '  :AUTOINC, CURDATE(), CURTIME(), :CODOPE,'                     + sLineBreak +
    '  :CODEMP, :CODITE,'                                            + sLineBreak +
    '  :ESTMIN, @ESTMIN,'                                            + sLineBreak +
    '  :ESTMAX, @ESTMAX,'                                            + sLineBreak +
    '  :NOMFRM'                                                      + sLineBreak +
    ' WHERE :ESTMIN <> @ESTMIN OR :ESTMAX <> @ESTMAX';
End;

class function TAltEst.fGravaLog(Owner: TComponent; strCodIte,
  strCodEmp: String; fltNewMin, fltNewMax: Double;
  blnUptMin: Boolean = True; blnUptMax: Boolean = True; StrCodOpe: String = ''): Boolean;
  Var
    objAltEst : TAltEst;
begin
  try
    objAltEst := TAltEst.Create(Owner);

    try
      Result := objAltEst.fGravaLogEst(strCodIte, strCodEmp,
                                       fltNewMin, fltNewMax, blnUptMin, blnUptMax, strCodOpe);

    Finally
      FreeAndNil(objAltEst);
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[TAltEst.fGravaLog]' );
      Result := False;
    End;

  End;

end;

Function TAltEst.fGravaLogEst(strCodIte, strCodEmp : String;
                             fltNewMin, fltNewMax : Double;
                             blnUptMin: Boolean = True;
                             blnUptMax: Boolean = True;
                             strCodOpe: String = '') : Boolean;
Begin

  Try

    With FqryConsulta Do
    Begin
      Close;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      Result := (not IsEmpty) And ( ( FieldByName('ITE_ESTMIN').AsFloat <> fltNewMin ) Or
                                    ( FieldByName('ITE_ESTMAX').AsFloat <> fltNewMax ) );

    End;


    if Result Then
    Begin
      With FqryInsAlt Do
      Begin
        Close;

        ParamByName('AUTO').AsString := fRetAutoIncrem('ALTEST', strCodEmp);
        ParamByName('DTAALT').AsDate   := VS_Date;
        ParamByName('HRAALT').AsTime   := fTime();

        if strCodOpe = '' Then
          ParamByName('CODOPE').AsString := strLoginUsuarioLogado
        Else
          ParamByName('CODOPE').AsString := strCodOpe;

        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('MINANT').AsFloat  := FqryConsulta.FieldByName('ITE_ESTMIN').AsFloat;
        ParamByName('MAXANT').AsFloat  := FqryConsulta.FieldByName('ITE_ESTMAX').AsFloat;
        ParamByName('MINATU').AsFloat  := IIF(blnUptMin, fltNewMin, FqryConsulta.FieldByName('ITE_ESTMIN').AsFloat);
        ParamByName('MAXATU').AsFloat  := IIF(blnUptMax, fltNewMax, FqryConsulta.FieldByName('ITE_ESTMAX').AsFloat);
        ParamByName('NOMFRM').AsString := FOwner.Name;

        ExecSQL;
      End;

    End;

    Result := True;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, '[TAltEst.fGravaLogEst]' );
      Result := False;
    End;

  End;

End;

function TAltEst.fRetInsertGravaLogEstTmp: string;
Begin
  Result := '';

  Result := Result + ' SET @INCREMENTO = :AUTINC; ';

  Result := Result + ' INSERT INTO ALTEST ';
  Result := Result + ' ( ';
  Result := Result + '  AUTOINCREM, ';
  Result := Result + '  LOG_DTAALT, ';
  Result := Result + '  LOG_HRAALT, ';
  Result := Result + '  LOG_CODOPE, ';
  Result := Result + '  LOG_CODEMP, ';
  Result := Result + '  LOG_CODITE, ';
  Result := Result + '  LOG_MINANT, ';
  Result := Result + '  LOG_MINATU, ';
  Result := Result + '  LOG_MAXANT, ';
  Result := Result + '  LOG_MAXATU, ';
  Result := Result + '  LOG_NOMFRM)  ';

  Result := Result + '  SELECT ';
  Result := Result + '    CONCAT(' + QuotedStr(fRetEmpresaFisica) + ', RIGHT(CONCAT("00000000000000000", @INCREMENTO:=@INCREMENTO+1),14),' + QuotedStr(VS_strCodEmp) + '), ';
  Result := Result +      fCurrentDate + ', ';
  Result := Result +      fCurrentTime + ', ';
  Result := Result +      QuotedStr(strLoginUsuarioLogado) + ', ';
  Result := Result + '    E.ITE_CODEMP, ';
  Result := Result + '    E.ITE_CODITE, ';
  Result := Result + '    E.ITE_ESTMIN, ';
  Result := Result + '    G.ITE_ESTMIN, ';
  Result := Result + '    E.ITE_ESTMAX, ';
  Result := Result + '    G.ITE_ESTMAX, ';
  Result := Result + '    "frmCalEstMin" ';

  Result := Result + '  FROM ';
  Result := Result + '    ESTANT E ';
  Result := Result + '  INNER JOIN ITEGER G ON G.ITE_CODEMP = E.ITE_CODEMP AND G.ITE_CODITE = E.ITE_CODITE ';
  Result := Result + '  WHERE (E.ITE_ESTMIN <> G.ITE_ESTMIN) OR (E.ITE_ESTMAX <> G.ITE_ESTMAX); ';
End;


function TAltEst.fRetSQLCriaEstAnt(mskLinGru: TMaskEditFocus; edtCodFor, edtCodMar,edtPrdGru,edtGruCmp,edtCodDep,edtCodIte  : TEditFocus;
                                  arrLinhaGrupo, arrFornecedor, arrMarca,  arrGrupoPro, arrGruCmp, arrCodDep, arrCodIte: TConsultasArray;
                                  strLinGru,     strFornecedor, strMarca,  strPrdGru,   strGruCmp, strCodDep, strEmpresa, strCodIte: string): String;
begin
  Result := '';
  Result := Result + ' CREATE TEMPORARY TABLE ESTANT ';
  Result := Result + ' SELECT G.ITE_CODITE, G.ITE_CODEMP, G.ITE_ESTMIN, G.ITE_ESTMAX FROM ITEGER G ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + '   G.ITE_ESMIDG = "G" AND ';
  Result := Result + '   G.ITE_CODEMP = :CODEMP ';
  Result := Result +  fStrLocateLinGru(mskLinGru,    arrLinhaGrupo, 'I.ITE_CODGRU', 'CODGRU') ;
  Result := Result +  fStrLocate(edtCodFor,    arrFornecedor, 'I.ITE_CODFOR', 'CODFOR') ;
  Result := Result +  fStrLocate(edtCodMar,    arrMarca     , 'I.ITE_CODMAR', 'CODMAR') ;
  Result := Result +  fStrLocate(edtPrdGru,    arrGrupoPro  , 'I.ITE_PRDGRU', 'PRDGRU') ;
  Result := Result +  fStrLocate(edtGruCmp,    arrGruCmp    , 'I.ITE_GRUCMP', 'GRUCMP') ;
  Result := Result +  fStrLocate(edtCodDep,    arrCodDep    , 'I.ITE_CODDEP', 'CODDEP') ;
  Result := Result +  fStrLocate(edtCodIte,    arrCodIte    , 'I.ITE_CODITE', 'CODITE') + '; ';
  Result := Result + ' CREATE INDEX IDX_ESTANT ON ESTANT(ITE_CODITE, ITE_CODEMP); ';
end;


procedure TAltEst.SetParametros(qry: TUniQuery; mskLinGru: TMaskEditFocus; edtCodFor, edtCodMar,edtPrdGru,edtGruCmp,edtCodDep, edtCodIte : TEditFocus;
                                            arrLinhaGrupo, arrFornecedor, arrMarca,  arrGrupoPro, arrGruCmp, arrCodDep, arrCodIte: TConsultasArray;
                                            strLinGru,     strFornecedor, strMarca,  strPrdGru,   strGruCmp, strCodDep, strEmpresa,strCodIte: string);
begin
  qry.ParamByName('CODEMP').AsString := strEmpresa;
  pSetaParam(mskLinGru.Text, arrLinhaGrupo, strLinGru,     'CODGRU', qry);
  pSetaParam(edtCodFor.Text, arrFornecedor, strFornecedor, 'CODFOR', qry);
  pSetaParam(edtCodMar.Text, arrMarca,      strMarca ,     'CODMAR', qry);
  pSetaParam(edtPrdGru.Text, arrGrupoPro,   strPrdGru,     'PRDGRU', qry);
  pSetaParam(edtGruCmp.Text, arrGruCmp,     strGruCmp,     'GRUCMP', qry);
  pSetaParam(edtCodDep.Text, arrCodDep,     strCodDep,     'CODDEP', qry);
  pSetaParam(edtCodIte.Text, arrCodIte,     strCodIte,     'CODITE', qry);
end;

end.



