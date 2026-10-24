unit UntMsgInterna;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  CheckLst,
  untFuncoesSimples,
{$ENDIF LINUX}
  Classes, Uni, SysUtils, StrUtils, DateUtils;

Type

  TMsgInterna = Class(TComponent)
  private
    FEmpExiApp : Boolean;

  Public
    strCodMsg: String;

    function fEnviaMensagem(strAssunto,
                            strMsgEnv,
                            strOpeEnv,
                            strOpeRec,
                            strLibera,
                            strNumLib: String;
                            strMsgJso : String = ''): Boolean;

    function fEnviaMensagemAutInc(strAssunto,
                                  strMsgEnv,
                                  strOpeEnv,
                                  strOpeRec,
                                  strLibera,
                                  strNumLib: String;
                                  Var strAutIncMsg : String;
                                  strMsgJso : String = '';
                                  intIdMensagem: integer = 0): Boolean;

    function fEnviaMensagemApp(strAutIncMsg: String): Boolean;

    function fGetProximoCodigoEmTransacao(const strTabela : String; const strCampoBusca : String) : String;

    class function fRetOperadorEnvio(strCodigo: String): String;

    constructor Create(Owner: TComponent); override;
  published


  End;

implementation

uses Data.DB, untModulo;

constructor TMsgInterna.Create(Owner: TComponent);
begin
  inherited;
  FEmpExiApp := fCampoTabela('EMP_EXIAPP', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) = 'S';
end;

function TMsgInterna.fEnviaMensagem(strAssunto,
                                    strMsgEnv,
                                    strOpeEnv,
                                    strOpeRec,
                                    strLibera,
                                    strNumLib: String;
                                    strMsgJso : String = ''): Boolean;
  Var
    strAutIncMsg : String;
Begin
  Result := fEnviaMensagemAutInc(strAssunto,
                                 strMsgEnv,
                                 strOpeEnv,
                                 strOpeRec,
                                 strLibera,
                                 strNumLib,
                                 strAutIncMsg,
                                 strMsgJso);
End;

function TMsgInterna.fEnviaMensagemAutInc(strAssunto,
                                          strMsgEnv,
                                          strOpeEnv,
                                          strOpeRec,
                                          strLibera,
                                          strNumLib: String;
                                          Var strAutIncMsg : String;
                                          strMsgJso : String = '';
                                          intIdMensagem: integer = 0): Boolean;
  Var
    strSQL: String;
    qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    blnComita : Boolean;
    strAutoIncrem : String;
begin
  blnComita := False;

  If Not fInTransaction Then
  Begin
    fStartTransaction;
    blnComita := True;
  End;

  strMsgEnv := fLimpaTagMsgOculta(strMsgEnv);
  strMsgJso := fLimpaTagMsgOculta(strMsgJso);

  Try
    strCodMsg := '';
    strSQL := '';
    strSQL := strSQL + ' INSERT INTO CADMSG ';
    strSQL := strSQL + ' ( ';
    strSQL := strSQL + ' AUTOINCREM, ';
    strSQL := strSQL + ' MSG_CODMSG, ';
    strSQL := strSQL + ' MSG_OPEENV, ';
    strSQL := strSQL + ' MSG_DTAENV, ';
    strSQL := strSQL + ' MSG_HORENV, ';
    strSQL := strSQL + ' MSG_MENSAG, ';
    strSQL := strSQL + ' MSG_LIDA__, ';
    strSQL := strSQL + ' MSG_EMPENV, ';
    strSQL := strSQL + ' MSG_TITULO, ';
    strSQL := strSQL + ' MSG_OPEREC, ';
    strSQL := strSQL + ' MSG_LIBERA, ';
    strSQL := strSQL + ' MSG_NUMLIB, ';
    strSQL := strSQL + ' MSG_IDMSG_, ';
    strSQL := strSQL + ' MSG_MENJSO  ';

    strSQL := strSQL + ' ) ';
    strSQL := strSQL + ' VALUES ( ';

    strSQL := strSQL + '   :AUTOINC,';
    strSQL := strSQL + '   :CODMSGN,';
    strSQL := strSQL + '   :OPEENV, ';
    strSQL := strSQL + '   :DTAENV, ';
    strSQL := strSQL + '   :TIME,   ';
    strSQL := strSQL + '   :MSGENV, ';
    strSQL := strSQL + '   "N",     ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :ASSUNT, ';
    strSQL := strSQL + '   :CODOPE, ';
    strSQL := strSQL + '   :LIBERA, ';
    strSQL := strSQL + '   :NUMLIB, ';
    strSQL := strSQL + '   :IDMSG_, ';
    strSQL := strSQL + '   :MENJSO  ';
    strSQL := strSQL + ' ) ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      strCodMsg := fGetProximoCodigoEmTransacao('CADMSG', 'MSG_CODMSG');
      strAutoIncrem := fRetAutoIncrem('CADMSG',VS_strCodEmp);

      SQL.Text := strSQL;
      ParamByName('AUTOINC').AsString  := strAutoIncrem;
      ParamByName('CODMSGN').AsString  := strCodMsg;
      ParamByName('OPEENV').AsString   := strOpeEnv;
      ParamByName('DTAENV').AsDateTime := VS_Date;
      ParamByName('TIME').AsDateTime   := fTime();
      ParamByName('MSGENV').AsString   := strMsgEnv;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('ASSUNT').AsString   := strAssunto;
      ParamByName('CODOPE').AsString   := strOpeRec;
      ParamByName('LIBERA').AsString   := strLibera;
      ParamByName('NUMLIB').AsString   := strNumLib;
      ParamByName('IDMSG_').AsInteger  := intIdMensagem;
      ParamByName('MENJSO').AsString   := strMsgJso;
      ExecSQL;

      If Not fEmptyStr(strAutIncMsg) Then
        strAutIncMsg := strAutIncMsg + ', ' + QuotedStr(strAutoIncrem)
      Else
        strAutIncMsg := QuotedStr(strAutoIncrem);

      if FEmpExiApp and (not fEmptyStr(strMsgJso)) then
      begin
        fEnviaMensagemApp(strAutoIncrem);
      end;

    End;
    Result := True;
{$IFNDEF LINUX}
    FreeAndNil(qryGen);
{$ENDIF LINUX}
    If (blnComita) Then
      fCommit;
  Except
    On E: Exception Do
    Begin
      If (blnComita) Then
        fRollBack;
      Raise Exception.Create('[fEnviaMensagem] ' + E.Message);
    End;
  End;
end;

function TMsgInterna.fEnviaMensagemApp(strAutIncMsg: String): Boolean;
  Var
    strSQL: String;
    qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    blnComita : Boolean;
begin
  blnComita := False;

  If Not fInTransaction Then
  Begin
    fStartTransaction;
    blnComita := True;
  End;

  Try
    strSQL := '';
    strSQL := strSQL + ' INSERT INTO APP_CADMSG ';
    strSQL := strSQL + ' ( ';
    strSQL := strSQL + ' AUTOINCREM, ';
    strSQL := strSQL + ' MSG_OPEENV, ';
    strSQL := strSQL + ' MSG_DTAENV, ';
    strSQL := strSQL + ' MSG_HORENV, ';
    strSQL := strSQL + ' MSG_MENSAG, ';
    strSQL := strSQL + ' MSG_LIDA__, ';
    strSQL := strSQL + ' MSG_EMPENV, ';
    strSQL := strSQL + ' MSG_TITULO, ';
    strSQL := strSQL + ' MSG_OPEREC, ';
    strSQL := strSQL + ' MSG_NUMLIB, ';
    strSQL := strSQL + ' MSG_MENJSO  ';

    strSQL := strSQL + ' ) ';

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   M.AUTOINCREM, ';
    strSQL := strSQL + '   M.MSG_OPEENV, ';
    strSQL := strSQL + '   M.MSG_DTAENV, ';
    strSQL := strSQL + '   M.MSG_HORENV, ';
    strSQL := strSQL + '   M.MSG_MENSAG, ';
    strSQL := strSQL + '   M.MSG_LIDA__, ';
    strSQL := strSQL + '   M.MSG_EMPENV, ';
    strSQL := strSQL + '   M.MSG_TITULO, ';
    strSQL := strSQL + '   M.MSG_OPEREC, ';
    strSQL := strSQL + '   M.MSG_NUMLIB, ';
    strSQL := strSQL + '   M.MSG_MENJSO  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADMSG M ';
    strSQL := strSQL + ' WHERE  ';
    strSQL := strSQL + '   M.AUTOINCREM  = ' + strAutIncMsg.QuotedString();

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Text := strSQL;
      ExecSQL;
    End;

    Result := True;
{$IFNDEF LINUX}
    FreeAndNil(qryGen);
{$ENDIF LINUX}
    If (blnComita) Then
      fCommit;
  Except
    On E: Exception Do
    Begin
      If (blnComita) Then
        fRollBack;
      Raise Exception.Create('[fEnviaMensagemApp] ' + E.Message);
    End;
  End;
end;

class function TMsgInterna.fRetOperadorEnvio(strCodigo: String): String;
  Var
    strSQL: String;
    qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin

  Try
    Result := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MSG_OPEENV, ';
    strSQL := strSQL + '  OPE_NOMOPE  ';
    strSQL := strSQL + 'FROM   ';
    strSQL := strSQL + '  CADMSG ';
    strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = MSG_OPEENV ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MSG_CODMSG = :CODMSG ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := strSQL;
      ParamByName('CODMSG').AsString := strCodigo;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('MSG_OPEENV').AsString + '-' + FieldByName('OPE_NOMOPE').AsString;
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fRetOperadorEnvio] ' + E.Message);
    End;
  End;
{$IFNDEF LINUX}
  FreeAndNil(qryGen);
{$ENDIF LINUX}
end;

function TMsgInterna.fGetProximoCodigoEmTransacao(const strTabela : String; const strCampoBusca : String): String;
  Var
    objCriarConexao : TCriarConexao;
begin
  objCriarConexao := TCriarConexao.Create();
  Try
    Result := fAtualizaProCod(strTabela, strCampoBusca, '', 1, objCriarConexao.objConexao);
  Finally
    FreeAndNil(objCriarConexao);
  End;
end;

end.

