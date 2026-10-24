unit untTDupEma;

interface

uses Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Uni,
     StrUtils, Math, untFuncoesSimples, Variants,untTypesSistema, untLogCtr ;

Type

  TDupEma = class
  public
    Class procedure GravarDupEma(ASeqEnv: String; ADuplicatasEnvio:TArrDupTabelaEmail);
    Class procedure GravarLogCtr(AAutInc : String; AAutoIncLogCtr: String = '');
  end;

  implementation

{ TDupEma }

class procedure TDupEma.GravarDupEma(ASeqEnv: String;
                                     ADuplicatasEnvio:TArrDupTabelaEmail);
  Var
    LQryDupEma: TUniQuery;
    LSQL      : String;
    LInc      : Integer;
    LInTransaction : Boolean;
    LAutoIncLogCtr : String;
Begin

  If Not Assigned(ADuplicatasEnvio) Then
    Exit;

  If (Length(ADuplicatasEnvio) <= 0) Then
    Exit;

  Try
    LInTransaction := fInTransaction();

    If Not LInTransaction Then
      fStartTransaction();

    LQryDupEma := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'INSERT INTO          ';
    LSQL := LSQL + '  DUPEMA(            ';
    LSQL := LSQL + '         AUTOINCREM, ';
    LSQL := LSQL + '         DUP_NUMDUP, ';
    LSQL := LSQL + '         DUP_PARCEL, ';
    LSQL := LSQL + '         DUP_ESPDOC, ';
    LSQL := LSQL + '         DUP_CODEMP, ';
    LSQL := LSQL + '         DUP_CODCLI, ';
    LSQL := LSQL + '         DUP_SEQBAI, ';
    LSQL := LSQL + '         DUP_SEQENV, '; // autoincrem da emaenv
    LSQL := LSQL + '         DUP_INCDUP) '; // autoincrem do logctr
    LSQL := LSQL + '  VALUES(            ';
    LSQL := LSQL + '         :AUTINC,    ';
    LSQL := LSQL + '         :NUMDUP,    ';
    LSQL := LSQL + '         :PARCEL,    ';
    LSQL := LSQL + '         :ESPDOC,    ';
    LSQL := LSQL + '         :CODEMP,    ';
    LSQL := LSQL + '         :CODCLI,    ';
    LSQL := LSQL + '         :SEQBAI,    ';
    LSQL := LSQL + '         :SEQENV,    ';
    LSQL := LSQL + '         :INCDUP)    ';

    Try

      For LInc := 0 To Length(ADuplicatasEnvio) -1 Do
      Begin
        LQryDupEma.Close;
        LQryDupEma.SQL.Clear;
        LQryDupEma.SQL.Add(LSQL);
        LAutoIncLogCtr := fRetAutoIncrem('LOGCTR',ADuplicatasEnvio[LInc].strCodEmp);
        LQryDupEma.ParamByName('AUTINC').AsString  := fRetAutoIncrem('DUPEMA', VS_strCodEmp);
        LQryDupEma.ParamByName('NUMDUP').AsString  := ADuplicatasEnvio[LInc].strNumDoc;;
        LQryDupEma.ParamByName('PARCEL').AsString  := ADuplicatasEnvio[LInc].strParcel;
        LQryDupEma.ParamByName('ESPDOC').AsString  := ADuplicatasEnvio[LInc].strEspDoc;
        LQryDupEma.ParamByName('CODEMP').AsString  := ADuplicatasEnvio[LInc].strCodEmp;
        LQryDupEma.ParamByName('CODCLI').AsString  := ADuplicatasEnvio[LInc].strCodCli;
        LQryDupEma.ParamByName('SEQBAI').AsInteger := ADuplicatasEnvio[LInc].intSeqBai;
        LQryDupEma.ParamByName('SEQENV').AsString  := ASeqEnv;
        LQryDupEma.ParamByName('INCDUP').AsString  := LAutoIncLogCtr;
        LQryDupEma.ExecSQL;
        TDupEma.GravarLogCtr(ADuplicatasEnvio[LInc].strAutoIn, LAutoIncLogCtr);
      End;

      If Not LInTransaction Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If Not LInTransaction Then
          fRollBack;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LQryDupEma);
  End;
End;

Class procedure TDupEma.GravarLogCtr(AAutInc: String; AAutoIncLogCtr: String = '');
begin
  Try
    untLogCtr.GravaLogCtr(AAutInc,
                          'EMAIL ENVIADO',
                          'TDupEma',
                          '',
                          0,
                          0,
                          '',
                          'N',
                          nil,
                          AAutoIncLogCtr);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;


end.
