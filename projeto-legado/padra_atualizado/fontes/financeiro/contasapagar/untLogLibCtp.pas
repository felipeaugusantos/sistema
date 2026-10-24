unit untLogLibCtp;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema, untLiberacao,
     System.Generics.Collections;

type
  TRegistroLog = Class
    ObjLiberacao: TLiberacao;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodOpe: String;
    strObserv: String;
    strNumLib: String;
    strDirAce: String;
    strMsgSen: String;
  End;

  TLogLibCtp = class
  private
    DicBaixa: TDictionary<String,TRegistroLog>;
    LogLibCtp: TRegistroLog;
  public
    procedure pGravarLogLib; overLoad;
    procedure pGravarLogLib(strAutoIncrem: String); overLoad;
    procedure pRemoveLogLib(strAutoIncrem: String);
    procedure AddLogLib(strAutoIncrem, sNumDoc, sEspDoc, sCodEmp: String; objLiberacao: TLiberacao);
    procedure pLimparLogLib;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TLogLibCtp }

procedure TLogLibCtp.AddLogLib(strAutoIncrem, sNumDoc, sEspDoc,
  sCodEmp: String; objLiberacao: TLiberacao);
var
  OldReg: TRegistroLog;
begin
  LogLibCtp := TRegistroLog.Create;

  LogLibCtp.strNumDoc :=  sNumDoc;
  LogLibCtp.strEspDoc :=  sEspDoc;
  LogLibCtp.strCodEmp :=  sCodEmp;
  LogLibCtp.strCodOpe := objLiberacao.strCodOpe;
  LogLibCtp.strObserv := objLiberacao.objMsgLibera.fGetMensagem;
  LogLibCtp.strNumLib := objLiberacao.stlNumLib[0];
  LogLibCtp.strDirAce := objLiberacao.strDirAce;
  LogLibCtp.strMsgSen := objLiberacao.strMsgSen;

  // libera o objeto anterior se a chave já existir
  if dicBaixa.TryGetValue(strAutoIncrem, OldReg) then
    OldReg.Free;

 DicBaixa.AddOrSetValue(strAutoIncrem,LogLibCtp);
end;

constructor TLogLibCtp.Create;
begin
  dicBaixa := TDictionary<String,TRegistroLog>.Create;
end;

destructor TLogLibCtp.Destroy;
var
  Item: TRegistroLog;
begin
  if Assigned(dicBaixa) then
  begin
    for Item in dicBaixa.Values do
      Item.Free;
    FreeAndNil(dicBaixa);
  end;

  LogLibCtp := nil;

  inherited;
end;

procedure TLogLibCtp.pGravarlogLib(strAutoIncrem: String);
var
  qryLogLib : TUniQuery;
  LSQL      : String;
Begin

  If Not dicBaixa.ContainsKey(strAutoIncrem) Then Exit;

  Try
    LSQL := '';
    LSQL := LSQL + 'INSERT INTO           ';
    LSQL := LSQL + '  LOGLIB(         ';
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
    LSQL := LSQL + '         :LOG_CODLIB) ';

    Try
      qryLogLib := fCriaQuery(Nil);

      qryLogLib.Close;
      qryLogLib.SQL.Clear;
      qryLogLib.SQL.Add(LSQL);
      qryLogLib.ParamByName('LOG_NUMDOC').AsString  := dicBaixa[strAutoIncrem].strNumDoc;
      qryLogLib.ParamByName('LOG_ESPDOC').AsString  := ''; //dicBaixa[strAutoIncrem].strEspDoc;  -> NÃO É NECESSÁRIO GRAVAR PELO CADPAG POIS DIFERE DO CADREC.
      qryLogLib.ParamByName('LOG_CODEMP').AsString  := dicBaixa[strAutoIncrem].strCodEmp;
      qryLogLib.ParamByName('LOG_CODOPE').AsString  := dicBaixa[strAutoIncrem].strCodOpe;
      qryLogLib.ParamByName('LOG_CODVEN').AsString  := dicBaixa[strAutoIncrem].strCodOpe;
      qryLogLib.ParamByName('LOG_DTACAD').AsDate    := VS_Date;
      qryLogLib.ParamByName('LOG_HRACAD').AsTime    := fTime();
      qryLogLib.ParamByName('LOG_OBSERV').AsString  := dicBaixa[strAutoIncrem].strObserv;
      qryLogLib.ParamByName('LOG_INFOF4').AsString  := '';
      qryLogLib.ParamByName('LOG_NROLIB').AsString  := dicBaixa[strAutoIncrem].strNumLib;
      qryLogLib.ParamByName('LOG_HRALIB').AsTime    := fTime();
      qryLogLib.ParamByName('LOG_DTALIB').AsDate    := VS_Date;
      qryLogLib.ParamByName('LOG_DTAENV').AsDate    := VS_Date;
      qryLogLib.ParamByName('LOG_HRAENV').AsTime    := fTime();
      qryLogLib.ParamByName('LOG_DIRACE').AsString  := dicBaixa[strAutoIncrem].strDirAce;
      qryLogLib.ParamByName('LOG_DESACE').AsString  := dicBaixa[strAutoIncrem].strMsgSen;
      qryLogLib.ParamByName('LOG_CODLIB').AsString  := fCodigoLiberacaoLogLib(dicBaixa[strAutoIncrem].strDirAce);
      qryLogLib.ExecSQL;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TLogLibRec.pInsereLogLigTMP]');
      End;

    End;

  Finally
    FreeAndNil(qryLogLib);
  End;
end;

procedure TLogLibCtp.pLimparLogLib;
var
  Item: TRegistroLog;
begin
  try
    for Item in dicBaixa.Values do
      Item.Free;
    dicBaixa.Clear;
  except on E: Exception do
    pMensagensErro(E.Message, '[TLogLibCtp.pLimparLogLib]');
  end;
end;

procedure TLogLibCtp.pGravarLogLib;
var
  qryLogLib : TUniQuery;
  LSQL      : String;
  Value: TRegistroLog;
Begin
 // Value := TRegistroLog.Create;

  If Not (dicBaixa.Count > 0) Then Exit;

  Try
    For Value in dicBaixa.Values Do
    Begin
      LSQL := '';
      LSQL := LSQL + 'INSERT INTO           ';
      LSQL := LSQL + '  LOGLIB(         ';
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
      LSQL := LSQL + '         :LOG_CODLIB) ';

      Try
        qryLogLib := fCriaQuery(Nil);

        qryLogLib.Close;
        qryLogLib.SQL.Clear;
        qryLogLib.SQL.Add(LSQL);
        qryLogLib.ParamByName('LOG_NUMDOC').AsString  := Value.strNumDoc;
        qryLogLib.ParamByName('LOG_ESPDOC').AsString  := '';//Value.strEspDoc;  -> NÃO É NECESSÁRIO GRAVAR PELO CADPAG POIS DIFERE DO CADREC.
        qryLogLib.ParamByName('LOG_CODEMP').AsString  := Value.strCodEmp;
        qryLogLib.ParamByName('LOG_CODOPE').AsString  := Value.strCodOpe;
        qryLogLib.ParamByName('LOG_CODVEN').AsString  := Value.strCodOpe;
        qryLogLib.ParamByName('LOG_DTACAD').AsDate    := VS_Date;
        qryLogLib.ParamByName('LOG_HRACAD').AsTime    := fTime();
        qryLogLib.ParamByName('LOG_OBSERV').AsString  := Value.strObserv;
        qryLogLib.ParamByName('LOG_INFOF4').AsString  := '';
        qryLogLib.ParamByName('LOG_NROLIB').AsString  := Value.strNumLib;
        qryLogLib.ParamByName('LOG_HRALIB').AsTime    := fTime();
        qryLogLib.ParamByName('LOG_DTALIB').AsDate    := VS_Date;
        qryLogLib.ParamByName('LOG_DTAENV').AsDate    := VS_Date;
        qryLogLib.ParamByName('LOG_HRAENV').AsTime    := fTime();
        qryLogLib.ParamByName('LOG_DIRACE').AsString  := Value.strDirAce;
        qryLogLib.ParamByName('LOG_DESACE').AsString  := Value.strMsgSen;
        qryLogLib.ParamByName('LOG_CODLIB').AsString  := fCodigoLiberacaoLogLib(Value.strDirAce);
        qryLogLib.ExecSQL;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TLogLibCtp.pGravarLogLib]');
        End;

      End;
    End;
  Finally
    //FreeAndNil(Value);
    FreeAndNil(qryLogLib);
  End;
end;

procedure TLogLibCtp.pRemoveLogLib(strAutoIncrem: String);
begin

  If Not dicBaixa.ContainsKey(strAutoIncrem) Then Exit;
  Try

    dicBaixa.Remove(strAutoIncrem);

    { Garantir que a capacidade do dictionary está setada para o numero de registros. }
    dicBaixa.TrimExcess;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLogLibCtp.pRemoveLogLib]');
    End;
  End;
end;

end.
