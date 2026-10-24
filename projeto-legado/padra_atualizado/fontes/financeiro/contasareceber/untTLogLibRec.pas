unit untTLogLibRec;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema, untLiberacao ;

Type

  TLogLibRec = class
  private

  public

    sNumDoc : String;
    sEspDoc : String;
    sCodEmp : String;

    property FNumDoc : String  read sNumDoc write sNumDoc;
    property FEspDoc : String  read sEspDoc write sEspDoc;
    property FCodEmp : String  read sCodEmp write sCodEmp;

    Class procedure CriaTabelaTemporaria;
    Class procedure pGravarTmplogLib( strNumDoc, strEspDoc, strCodEmp: String);
    Class procedure pGravarLogLib(strNumDoc, strEspDoc, strCodEmp: String; ANomFrm : String = '');
    Class procedure pDropTabelaLogLib();
    Class procedure pLimpaTmpLogLib();
    Class procedure pInsereLogLigTMP( objLiberacao : TLiberacao; StrNumDup, strEspDoc, strCodEmp: String;  ANomFrm : String = '' );
    Class procedure pInsereLogLigTemp( objLiberacao : TLiberacao; StrNumDup, strEspDoc, strCodEmp : String );
    Class procedure pGeraLogLiberacaoTemporario(strNumDoc, strEspDoc, strCodEmp: String; strObserv: String = ''; ANomFrm: String = '');
    class procedure pRemoveTmpLogLib(strNumDoc, strEspDoc, strCodEmp : String);
    Class function pExisteTabela: Boolean;
    Class function GetNumeroLiberacao(objLiberacao : TLiberacao): Variant;

    Constructor Create(); reintroduce;
    Destructor  Destroy; Override;

  end;

  implementation

{ TLogLibRec }

constructor TLogLibRec.Create();
begin
//
end;

Class procedure TLogLibRec.CriaTabelaTemporaria;
  Var
    LSql : String;
    LQryTmp : TUniQuery;
begin

  Try
    LQryTmp := fCriaQuery(Nil);
    LSql := '';

    pDropTabelaLogLib();

    LSql := LSql + ' CREATE TEMPORARY TABLE TMP_LOGLIB ';
    LSql := LSql + ' SELECT        ';
    LSql := LSql + '   LOG_NUMDOC, ';
    LSql := LSql + '   LOG_ESPDOC, ';
    LSql := LSql + '   LOG_CODEMP, ';
    LSql := LSql + '   LOG_CODOPE, ';
    LSql := LSql + '   LOG_CODVEN, ';
    LSql := LSql + '   LOG_DTACAD, ';
    LSql := LSql + '   LOG_HRACAD, ';
    LSql := LSql + '   LOG_OBSERV, ';
    LSql := LSql + '   LOG_PARDOC, ';
    LSql := LSql + '   LOG_TIPLOG, ';
    LSql := LSql + '   LOG_INFOF4, ';
    LSql := LSql + '   LOG_NROLIB, ';
    LSql := LSql + '   LOG_HRALIB, ';
    LSql := LSql + '   LOG_DTALIB, ';
    LSql := LSql + '   LOG_DTAENV, ';
    LSql := LSql + '   LOG_HRAENV, ';
    LSql := LSql + '   LOG_DIRACE, ';
    LSql := LSql + '   LOG_DESACE, ';
    LSql := LSql + '   LOG_TITULO, ';
    LSql := LSql + '   LOG_CODLIB  ';
    LSql := LSql + ' FROM          ';
    LSql := LSql + '   LOGLIB      ';
    LSql := LSql + ' WHERE FALSE   ';

    Try
      LQryTmp.Close;
      LQryTmp.Sql.Clear;
      LQryTmp.Sql.Add(LSql);
      LQryTmp.ExecSQL;
      LQryTmp.Close;

      LQryTmp.Close;
      LQryTmp.SQL.Clear;
      LQryTmp.SQL.Add('ALTER TABLE TMP_LOGLIB ADD LOG_NOMFRM VARCHAR(70) DEFAULT NULL');
      LQryTmp.ExecSQL;
      LQryTmp.Close;
    Except
      On E: Exception Do
      Begin
       pMensagensErro(E.Message, '[TLogLibRec.CriaTabelaLogLibTemporaria]');
      End;
    End;
  Finally
    FreeAndNil(LQryTmp);
  End;

end;

destructor TLogLibRec.Destroy;
begin
  inherited;
end;

{QUANDO CONFIGURADO SENHA FIXA (CFG_SENFVU) NÃO EXISTE NÚMERO DE LIBERAÇÃO}
class function TLogLibRec.GetNumeroLiberacao(objLiberacao: TLiberacao): Variant;
begin
  Try
    Result := objLiberacao.stlNumLib[0];
  Except
    Result := Null;
  End;
end;

{Procedure feita para garantir que todas liberações estão na loglib temporaria MT: 210729}
Class procedure TLogLibRec.pGeraLogLiberacaoTemporario(strNumDoc, strEspDoc, strCodEmp,
  strObserv,ANomFrm: String);
  Var
    qryGen     : TUniQuery;
    intContador: Integer;
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' INSERT INTO TMP_LOGLIB ');
      SQL.Add('  (LOG_NUMDOC,      ');
      SQL.Add('   LOG_ESPDOC,      ');
      SQL.Add('   LOG_CODEMP,      ');
      SQL.Add('   LOG_CODVEN,      ');
      SQL.Add('   LOG_CODOPE,      ');
      SQL.Add('   LOG_DTACAD,      ');
      SQL.Add('   LOG_HRACAD,      ');
      SQL.Add('   LOG_HRALIB,      ');
      SQL.Add('   LOG_DTALIB,      ');
      SQL.Add('   LOG_HRAENV,      ');
      SQL.Add('   LOG_DTAENV,      ');
      SQL.Add('   LOG_NROLIB,      ');
      SQL.Add('   LOG_DIRACE,      ');
      SQL.Add('   LOG_DESACE,      ');
      SQL.Add('   LOG_OBSERV,      ');
      SQL.Add('   LOG_TITULO,      ');
      SQL.Add('   LOG_CODLIB,      ');
      SQL.Add('   LOG_NOMFRM)      ');
      SQL.Add(' VALUES             ');
      SQL.Add('  (:NUMDOC,         ');
      SQL.Add('   :ESPDOC,         ');
      SQL.Add('   :CODEMP,         ');
      SQL.Add('   :CODVEN,         ');
      SQL.Add('   :CODOPE,         ');
      SQL.Add('   :DTACAD,         ');
      SQL.Add('   :HRACAD,         ');
      SQL.Add('   :HRALIB,         ');
      SQL.Add('   :DTALIB,         ');
      SQL.Add('   :HRAENV,         ');
      SQL.Add('   :DTAENV,         ');
      SQL.Add('   :NROLIB,         ');
      SQL.Add('   :DIRACE,         ');
      SQL.Add('   :DESACE,         ');
      SQL.Add('   :OBSERV,         ');
      SQL.Add('   :TITULO,         ');
      SQL.Add('   :CODLIB,         ');
      SQL.Add('   :NOMFRM)         ');

      For intContador := 0 To Length(arrLogLib) -1 Do
      Begin
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('NOMFRM').AsString := ANomFrm;
        ParamByName('CODOPE').AsString := arrLogLib[intContador].strOpeLib;
        ParamByName('NROLIB').AsString := arrLogLib[intContador].strNumLib;
        ParamByName('DIRACE').AsString := arrLogLib[intContador].strDirAce;
        ParamByName('DESACE').AsString := arrLogLib[intContador].strMsgSen;

        if (not fEmptyStr(strObserv)) then
          ParamByName('OBSERV').AsString := strObserv
        else
        begin
          If (Not fEmptyStr(arrLogLib[intContador].strInfBlo)) Then
            ParamByName('OBSERV').AsString := AnsiUpperCase(arrLogLib[intContador].strInfBlo)
          Else
            ParamByName('OBSERV').AsString := AnsiUpperCase(arrLogLib[intContador].strObserv);
        end;

        ParamByName('DTACAD').AsDate   := VS_Date;
        ParamByName('HRACAD').AsTime   := arrLogLib[intContador].dtaHraCad;
        ParamByName('HRALIB').AsTime   := arrLogLib[intContador].dtaHraLib;
        ParamByName('DTALIB').AsDate   := arrLogLib[intContador].dtaDtaLib;
        ParamByName('HRAENV').AsTime   := arrLogLib[intContador].dtaHraEnv;
        ParamByName('DTAENV').AsDate   := arrLogLib[intContador].dtaDtaEnv;
        ParamByName('TITULO').AsString := arrLogLib[intContador].strTitulo;
        ParamByName('CODLIB').AsString := arrLogLib[intContador].strCodLib;

        If Not fEmptyStr(arrLogLib[intContador].strCodVen) Then
          ParamByName('CODVEN').AsString := arrLogLib[intContador].strCodVen;

        arrLogLib[intContador].blnInsLog := TRUE;

        ExecSQL;
        Close;
      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

class procedure TLogLibRec.pGravarLogLib(strNumDoc, strEspDoc, strCodEmp,
  ANomFrm: String);
  Var
    LQryLogLib: TUniQuery;
    LQryTmp   : TUniQuery;
    LSQL      : String;
    LInc      : Integer;
Begin
  Try
    LQryTmp    := fCriaQuery(Nil);
    LQryLogLib := fCriaQuery(Nil);

    If Not fTabelaExiste('TMP_LOGLIB') Then
      Exit;

    pGeraLogLiberacaoTemporario(strNumDoc, strEspDoc, strCodEmp,'',ANomFrm);

    Try
      LQryTmp.Close;
      LQryTmp.Sql.Clear;
      LQryTmp.Sql.Add(' SELECT * FROM          ');
      LQryTmp.Sql.Add('   ( SELECT             ');
      LQryTmp.Sql.Add('          TMP_LOGLIB.*  ');
      LQryTmp.Sql.Add('        FROM            ');
      LQryTmp.Sql.Add('          TMP_LOGLIB    ');
      LQryTmp.Sql.Add('      ORDER BY LOG_DTACAD,      ');
      LQryTmp.Sql.Add('               LOG_HRACAD DESC  ');
      LQryTmp.Sql.Add('   ) TAB                        ');
      LQryTmp.Sql.Add('     GROUP BY LOG_DIRACE,       ');
      LQryTmp.Sql.Add('     LOG_DTACAD,LOG_NOMFRM      ');
      LQryTmp.Open;
      LQryTmp.First;
    Except
      Exit;
    End;

    If LQryTmp.IsEmpty Then Exit;

    LSQL := '';
    LSQL := LSQL + 'INSERT INTO           ';
    LSQL := LSQL + '  LOGLIB(             ';
    LSQL := LSQL + '         LOG_NUMDOC,  ';
    LSQL := LSQL + '         LOG_ESPDOC,  ';
    LSQL := LSQL + '         LOG_CODEMP,  ';
    LSQL := LSQL + '         LOG_CODOPE,  ';
    LSQL := LSQL + '         LOG_CODVEN,  ';
    LSQL := LSQL + '         LOG_DTACAD,  ';
    LSQL := LSQL + '         LOG_HRACAD,  ';
    LSQL := LSQL + '         LOG_OBSERV,  ';
    LSQL := LSQL + '         LOG_INFOF4,  ';
    LSQL := LSQL + '         LOG_NROLIB,  ';
    LSQL := LSQL + '         LOG_HRALIB,  ';
    LSQL := LSQL + '         LOG_DTALIB,  ';
    LSQL := LSQL + '         LOG_DTAENV,  ';
    LSQL := LSQL + '         LOG_HRAENV,  ';
    LSQL := LSQL + '         LOG_DIRACE,  ';
    LSQL := LSQL + '         LOG_DESACE,  ';
    LSQL := LSQL + '         LOG_TITULO,  ';
    LSQL := LSQL + '         LOG_CODLIB)  ';
    LSQL := LSQL + '  VALUES(             ';
    LSQL := LSQL + '         :LOG_NUMDOC, ';
    LSQL := LSQL + '         :LOG_ESPDOC, ';
    LSQL := LSQL + '         :LOG_CODEMP, ';
    LSQL := LSQL + '         :LOG_CODOPE, ';
    LSQL := LSQL + '         :LOG_CODVEN, ';
    LSQL := LSQL + '         :LOG_DTACAD, ';
    LSQL := LSQL + '         :LOG_HRACAD, ';
    LSQL := LSQL + '         :LOG_OBSERV, ';
    LSQL := LSQL + '         :LOG_INFOF4, ';
    LSQL := LSQL + '         :LOG_NROLIB, ';
    LSQL := LSQL + '         :LOG_HRALIB, ';
    LSQL := LSQL + '         :LOG_DTALIB, ';
    LSQL := LSQL + '         :LOG_DTAENV, ';
    LSQL := LSQL + '         :LOG_HRAENV, ';
    LSQL := LSQL + '         :LOG_DIRACE, ';
    LSQL := LSQL + '         :LOG_DESACE, ';
    LSQL := LSQL + '         :LOG_TITULO, ';
    LSQL := LSQL + '         :LOG_CODLIB) ';

    Try

      For LInc := 0 To LQryTmp.RecordCount -1 Do
      Begin
        LQryLogLib.Close;
        LQryLogLib.SQL.Clear;
        LQryLogLib.SQL.Add(LSQL);
        LQryLogLib.ParamByName('LOG_NUMDOC').AsString   := LQryTmp.FieldByName('LOG_NUMDOC').AsString;
        LQryLogLib.ParamByName('LOG_ESPDOC').AsString   := LQryTmp.FieldByName('LOG_ESPDOC').AsString;
        LQryLogLib.ParamByName('LOG_CODEMP').AsString   := LQryTmp.FieldByName('LOG_CODEMP').AsString;
        LQryLogLib.ParamByName('LOG_CODOPE').AsString   := LQryTmp.FieldByName('LOG_CODOPE').AsString;

        LQryLogLib.ParamByName('LOG_CODVEN').Value      := Null;
        If Not fEmptyStr(LQryTmp.FieldByName('LOG_CODVEN').AsString) Then
          LQryLogLib.ParamByName('LOG_CODVEN').AsString   := LQryTmp.FieldByName('LOG_CODVEN').AsString;

        LQryLogLib.ParamByName('LOG_DTACAD').AsDateTime := LQryTmp.FieldByName('LOG_DTACAD').AsDateTime;
        LQryLogLib.ParamByName('LOG_HRACAD').AsDateTime := LQryTmp.FieldByName('LOG_HRACAD').AsDateTime;
        LQryLogLib.ParamByName('LOG_OBSERV').AsString   := LQryTmp.FieldByName('LOG_OBSERV').AsString;
        LQryLogLib.ParamByName('LOG_INFOF4').AsString   := LQryTmp.FieldByName('LOG_INFOF4').AsString;
        LQryLogLib.ParamByName('LOG_NROLIB').AsString   := LQryTmp.FieldByName('LOG_NROLIB').AsString;
        LQryLogLib.ParamByName('LOG_HRALIB').AsDateTime := LQryTmp.FieldByName('LOG_HRALIB').AsDateTime;
        LQryLogLib.ParamByName('LOG_DTALIB').AsDate     := LQryTmp.FieldByName('LOG_DTALIB').AsDateTime;
        LQryLogLib.ParamByName('LOG_DTAENV').AsDate     := LQryTmp.FieldByName('LOG_DTAENV').AsDateTime;
        LQryLogLib.ParamByName('LOG_HRAENV').AsDateTime := LQryTmp.FieldByName('LOG_HRAENV').AsDateTime;
        LQryLogLib.ParamByName('LOG_DIRACE').AsString   := LQryTmp.FieldByName('LOG_DIRACE').AsString;
        LQryLogLib.ParamByName('LOG_DESACE').AsString   := LQryTmp.FieldByName('LOG_DESACE').AsString;
        LQryLogLib.ParamByName('LOG_TITULO').AsString   := LQryTmp.FieldByName('LOG_TITULO').AsString;
        LQryLogLib.ParamByName('LOG_CODLIB').AsString   := LQryTmp.FieldByName('LOG_CODLIB').AsString;
        LQryLogLib.ExecSQL;
        LQryTmp.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TLogLibRec.pGravarTmplogLib]');
      End;

    End;

  Finally
    FreeAndNil(LQryLogLib);
    FreeAndNil(LQryTmp);
  End;

End;

class procedure TLogLibRec.pGravarTmplogLib( strNumDoc, strEspDoc, strCodEmp: String );
  Var
    LQryLogLib: TUniQuery;
    LQryTmp   : TUniQuery;
    LSQL      : String;
    LInc      : Integer;
Begin
  Try
    LQryTmp    := fCriaQuery(Nil);
    LQryLogLib := fCriaQuery(Nil);

    If Not fTabelaExiste('TMP_LOGLIB') Then
      Exit;

    Try
      LQryTmp.Close;
      LQryTmp.Sql.Clear;
      LQryTmp.Sql.Add(' SELECT * FROM          ');
      LQryTmp.Sql.Add('   ( SELECT             ');
      LQryTmp.Sql.Add('          TMP_LOGLIB.*  ');
      LQryTmp.Sql.Add('        FROM            ');
      LQryTmp.Sql.Add('          TMP_LOGLIB    ');
      LQryTmp.Sql.Add('      WHERE LOG_NUMDOC = :LOG_NUMDOC AND   ');
      LQryTmp.Sql.Add('            LOG_ESPDOC = :LOG_ESPDOC AND   ');
      LQryTmp.Sql.Add('            LOG_CODEMP = :LOG_CODEMP       ');
      LQryTmp.Sql.Add('      ORDER BY LOG_DTACAD,      ');
      LQryTmp.Sql.Add('               LOG_HRACAD DESC  ');
      LQryTmp.Sql.Add('   ) TAB                        ');
      LQryTmp.Sql.Add('     GROUP BY LOG_DIRACE,       ');
      LQryTmp.Sql.Add('     LOG_DTACAD                 ');
      LQryTmp.ParamByName('LOG_NUMDOC').AsString := strNumDoc;
      LQryTmp.ParamByName('LOG_ESPDOC').AsString := strEspDoc;
      LQryTmp.ParamByName('LOG_CODEMP').AsString := strCodEmp;
      LQryTmp.Open;
      LQryTmp.First;
    Except
      Exit;
    End;

    If LQryTmp.IsEmpty Then Exit;

    LSQL := '';
    LSQL := LSQL + 'INSERT INTO           ';
    LSQL := LSQL + '  LOGLIB(             ';
    LSQL := LSQL + '         LOG_NUMDOC,  ';
    LSQL := LSQL + '         LOG_ESPDOC,  ';
    LSQL := LSQL + '         LOG_CODEMP,  ';
    LSQL := LSQL + '         LOG_CODOPE,  ';
    LSQL := LSQL + '         LOG_CODVEN,  ';
    LSQL := LSQL + '         LOG_DTACAD,  ';
    LSQL := LSQL + '         LOG_HRACAD,  ';
    LSQL := LSQL + '         LOG_OBSERV,  ';
    LSQL := LSQL + '         LOG_INFOF4,  ';
    LSQL := LSQL + '         LOG_NROLIB,  ';
    LSQL := LSQL + '         LOG_HRALIB,  ';
    LSQL := LSQL + '         LOG_DTALIB,  ';
    LSQL := LSQL + '         LOG_DTAENV,  ';
    LSQL := LSQL + '         LOG_HRAENV,  ';
    LSQL := LSQL + '         LOG_DIRACE,  ';
    LSQL := LSQL + '         LOG_DESACE,  ';
    LSQL := LSQL + '         LOG_TITULO,  ';
    LSQL := LSQL + '         LOG_CODLIB)  ';
    LSQL := LSQL + '  VALUES(             ';
    LSQL := LSQL + '         :LOG_NUMDOC, ';
    LSQL := LSQL + '         :LOG_ESPDOC, ';
    LSQL := LSQL + '         :LOG_CODEMP, ';
    LSQL := LSQL + '         :LOG_CODOPE, ';
    LSQL := LSQL + '         :LOG_CODVEN, ';
    LSQL := LSQL + '         :LOG_DTACAD, ';
    LSQL := LSQL + '         :LOG_HRACAD, ';
    LSQL := LSQL + '         :LOG_OBSERV, ';
    LSQL := LSQL + '         :LOG_INFOF4, ';
    LSQL := LSQL + '         :LOG_NROLIB, ';
    LSQL := LSQL + '         :LOG_HRALIB, ';
    LSQL := LSQL + '         :LOG_DTALIB, ';
    LSQL := LSQL + '         :LOG_DTAENV, ';
    LSQL := LSQL + '         :LOG_HRAENV, ';
    LSQL := LSQL + '         :LOG_DIRACE, ';
    LSQL := LSQL + '         :LOG_DESACE, ';
    LSQL := LSQL + '         :LOG_TITULO,  ';
    LSQL := LSQL + '         :LOG_CODLIB)  ';

    Try

      For LInc := 0 To LQryTmp.RecordCount -1 Do
      Begin
        LQryLogLib.Close;
        LQryLogLib.SQL.Clear;
        LQryLogLib.SQL.Add(LSQL);
        LQryLogLib.ParamByName('LOG_NUMDOC').AsString   := LQryTmp.FieldByName('LOG_NUMDOC').AsString;
        LQryLogLib.ParamByName('LOG_ESPDOC').AsString   := LQryTmp.FieldByName('LOG_ESPDOC').AsString;
        LQryLogLib.ParamByName('LOG_CODEMP').AsString   := LQryTmp.FieldByName('LOG_CODEMP').AsString;
        LQryLogLib.ParamByName('LOG_CODOPE').AsString   := LQryTmp.FieldByName('LOG_CODOPE').AsString;
        LQryLogLib.ParamByName('LOG_CODVEN').AsString   := LQryTmp.FieldByName('LOG_CODVEN').AsString;
        LQryLogLib.ParamByName('LOG_DTACAD').AsDateTime := LQryTmp.FieldByName('LOG_DTACAD').AsDateTime;
        LQryLogLib.ParamByName('LOG_HRACAD').AsDateTime := LQryTmp.FieldByName('LOG_HRACAD').AsDateTime;
        LQryLogLib.ParamByName('LOG_OBSERV').AsString   := LQryTmp.FieldByName('LOG_OBSERV').AsString;
        LQryLogLib.ParamByName('LOG_INFOF4').AsString   := LQryTmp.FieldByName('LOG_INFOF4').AsString;
        LQryLogLib.ParamByName('LOG_NROLIB').AsString   := LQryTmp.FieldByName('LOG_NROLIB').AsString;
        LQryLogLib.ParamByName('LOG_HRALIB').AsDateTime := LQryTmp.FieldByName('LOG_HRALIB').AsDateTime;
        LQryLogLib.ParamByName('LOG_DTALIB').AsDate     := LQryTmp.FieldByName('LOG_DTALIB').AsDateTime;
        LQryLogLib.ParamByName('LOG_DTAENV').AsDate     := LQryTmp.FieldByName('LOG_DTAENV').AsDateTime;
        LQryLogLib.ParamByName('LOG_HRAENV').AsDateTime := LQryTmp.FieldByName('LOG_HRAENV').AsDateTime;
        LQryLogLib.ParamByName('LOG_DIRACE').AsString   := LQryTmp.FieldByName('LOG_DIRACE').AsString;
        LQryLogLib.ParamByName('LOG_DESACE').AsString   := LQryTmp.FieldByName('LOG_DESACE').AsString;
        LQryLogLib.ParamByName('LOG_TITULO').AsString   := LQryTmp.FieldByName('LOG_TITULO').AsString;
        LQryLogLib.ParamByName('LOG_CODLIB').AsString   := LQryTmp.FieldByName('LOG_CODLIB').AsString;
        LQryLogLib.ExecSQL;
        LQryTmp.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TLogLibRec.pGravarTmplogLib]');
      End;

    End;

  Finally
    FreeAndNil(LQryLogLib);
    FreeAndNil(LQryTmp);
  End;

End;

Class procedure TLogLibRec.pDropTabelaLogLib();
begin
  If fTabelaExiste('TMP_LOGLIB') Then
     fDropTable('TMP_LOGLIB');
End;

class function TLogLibRec.pExisteTabela: Boolean;
begin
  Result := fTabelaExiste('TMP_LOGLIB');
end;

Class procedure TLogLibRec.pLimpaTmpLogLib();
  Var
    LQryLogLib: TUniQuery;
Begin

  Try
    LQryLogLib := fCriaQuery(Nil);

    If Not fTabelaExiste('TMP_LOGLIB') Then
       Exit;

    Try
      LQryLogLib.Close;
      LQryLogLib.Sql.Clear;
      LQryLogLib.Sql.Add(' DELETE FROM TMP_LOGLIB ');
      LQryLogLib.ExecSQL;
    Except
      Exit;
    End;

  Finally
    FreeAndNil(LQryLogLib);
  End;

End;

Class procedure TLogLibRec.pRemoveTmpLogLib(strNumDoc, strEspDoc, strCodEmp : String );
  Var
    LQryLogLib: TUniQuery;
Begin

  Try
    LQryLogLib := fCriaQuery(Nil);

    If Not fTabelaExiste('TMP_LOGLIB') Then
       Exit;

    Try
      LQryLogLib.Close;
      LQryLogLib.Sql.Clear;
      LQryLogLib.Sql.Add(' DELETE FROM TMP_LOGLIB ');
      LQryLogLib.Sql.Add('      WHERE LOG_NUMDOC = :LOG_NUMDOC AND   ');
      LQryLogLib.Sql.Add('            LOG_ESPDOC = :LOG_ESPDOC AND   ');
      LQryLogLib.Sql.Add('            LOG_CODEMP = :LOG_CODEMP       ');
      LQryLogLib.ParamByName('LOG_NUMDOC').AsString := strNumDoc;
      LQryLogLib.ParamByName('LOG_ESPDOC').AsString := strEspDoc;
      LQryLogLib.ParamByName('LOG_CODEMP').AsString := strCodEmp;
      LQryLogLib.ExecSQL;
    Except
      Exit;
    End;

  Finally
    FreeAndNil(LQryLogLib);
  End;

End;


Class procedure TLogLibRec.pInsereLogLigTemp( objLiberacao : TLiberacao; StrNumDup, strEspDoc, strCodEmp : String );
Begin

  pInsereLogLigTMP(objLiberacao, StrNumDup, strEspDoc, strCodEmp );

End;

Class procedure TLogLibRec.pInsereLogLigTMP( objLiberacao : TLiberacao; StrNumDup, strEspDoc, strCodEmp, ANomFrm : String );
  Var
    qryTmpLogLibEnv : TUniQuery;
    LSQL            : String;
Begin

  If Not Assigned(objLiberacao) Then Exit;

  If Not fTabelaExiste('TMP_LOGLIB') Then
    Exit;

  Try
    LSQL := '';
    LSQL := LSQL + 'INSERT INTO           ';
    LSQL := LSQL + '  TMP_LOGLIB(         ';
    LSQL := LSQL + '         LOG_NUMDOC,  ';
    LSQL := LSQL + '         LOG_ESPDOC,  ';
    LSQL := LSQL + '         LOG_CODEMP,  ';
    LSQL := LSQL + '         LOG_CODOPE,  ';
    LSQL := LSQL + '         LOG_CODVEN,  ';
    LSQL := LSQL + '         LOG_DTACAD,  ';
    LSQL := LSQL + '         LOG_HRACAD,  ';
    LSQL := LSQL + '         LOG_OBSERV,  ';
    LSQL := LSQL + '         LOG_INFOF4,  ';
    LSQL := LSQL + '         LOG_NROLIB,  ';
    LSQL := LSQL + '         LOG_HRALIB,  ';
    LSQL := LSQL + '         LOG_DTALIB,  ';
    LSQL := LSQL + '         LOG_DTAENV,  ';
    LSQL := LSQL + '         LOG_HRAENV,  ';
    LSQL := LSQL + '         LOG_DIRACE,  ';
    LSQL := LSQL + '         LOG_DESACE,  ';
    LSQL := LSQL + '         LOG_TITULO,  ';
    LSQL := LSQL + '         LOG_CODLIB,  ';
    LSQL := LSQL + '         LOG_NOMFRM)  ';
    LSQL := LSQL + '  VALUES(             ';
    LSQL := LSQL + '         :LOG_NUMDOC, ';
    LSQL := LSQL + '         :LOG_ESPDOC, ';
    LSQL := LSQL + '         :LOG_CODEMP, ';
    LSQL := LSQL + '         :LOG_CODOPE, ';
    LSQL := LSQL + '         :LOG_CODVEN, ';
    LSQL := LSQL + '         :LOG_DTACAD, ';
    LSQL := LSQL + '         :LOG_HRACAD, ';
    LSQL := LSQL + '         :LOG_OBSERV, ';
    LSQL := LSQL + '         :LOG_INFOF4, ';
    LSQL := LSQL + '         :LOG_NROLIB, ';
    LSQL := LSQL + '         :LOG_HRALIB, ';
    LSQL := LSQL + '         :LOG_DTALIB, ';
    LSQL := LSQL + '         :LOG_DTAENV, ';
    LSQL := LSQL + '         :LOG_HRAENV, ';
    LSQL := LSQL + '         :LOG_DIRACE, ';
    LSQL := LSQL + '         :LOG_DESACE, ';
    LSQL := LSQL + '         :LOG_TITULO, ';
    LSQL := LSQL + '         :LOG_CODLIB,  ';
    LSQL := LSQL + '         :LOG_NOMFRM) ';

    Try
      qryTmpLogLibEnv := fCriaQuery(Nil);

      qryTmpLogLibEnv.Close;
      qryTmpLogLibEnv.SQL.Clear;
      qryTmpLogLibEnv.SQL.Add(LSQL);
      qryTmpLogLibEnv.ParamByName('LOG_NUMDOC').AsString  := StrNumDup;
      qryTmpLogLibEnv.ParamByName('LOG_ESPDOC').AsString  := strEspDoc;
      qryTmpLogLibEnv.ParamByName('LOG_CODEMP').AsString  := strCodEmp;
      qryTmpLogLibEnv.ParamByName('LOG_CODOPE').AsString  := IIF(not fEmptyStr(objLiberacao.strOperador), objLiberacao.strOperador, objLiberacao.strCodOpe);
      qryTmpLogLibEnv.ParamByName('LOG_CODVEN').AsString  := objLiberacao.strCodOpe;
      qryTmpLogLibEnv.ParamByName('LOG_DTACAD').AsDate    := VS_Date;
      qryTmpLogLibEnv.ParamByName('LOG_HRACAD').AsTime    := fTime();
      qryTmpLogLibEnv.ParamByName('LOG_OBSERV').AsString  := objLiberacao.objMsgLibera.fGetMensagem;
      qryTmpLogLibEnv.ParamByName('LOG_INFOF4').AsString  := '';
      qryTmpLogLibEnv.ParamByName('LOG_NROLIB').Value     := GetNumeroLiberacao(objLiberacao);
      qryTmpLogLibEnv.ParamByName('LOG_HRALIB').AsTime    := fTime();
      qryTmpLogLibEnv.ParamByName('LOG_DTALIB').AsDate    := VS_Date;
      qryTmpLogLibEnv.ParamByName('LOG_DTAENV').AsDate    := VS_Date;
      qryTmpLogLibEnv.ParamByName('LOG_HRAENV').AsTime    := fTime();
      qryTmpLogLibEnv.ParamByName('LOG_DIRACE').AsString  := objLiberacao.strDirAce;
      qryTmpLogLibEnv.ParamByName('LOG_DESACE').AsString  := objLiberacao.strMsgSen;
      qryTmpLogLibEnv.ParamByName('LOG_TITULO').AsString  := objLiberacao.strMsgSen;
      qryTmpLogLibEnv.ParamByName('LOG_CODLIB').AsString  := fCodigoLiberacaoLogLib(objLiberacao.strDirAce);
      qryTmpLogLibEnv.ParamByName('LOG_NOMFRM').AsString  := ANomFrm;
      qryTmpLogLibEnv.ExecSQL;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TLogLibRec.pInsereLogLigTMP]');
      End;

    End;

  Finally
    FreeAndNil(qryTmpLogLibEnv);
  End;

End;

end.
