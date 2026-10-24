unit untLogCanRepository;

interface

uses untDtoLogCan, untConnection, System.Generics.Collections;

type
  TLogCanRepository = class
  private
    FConnection : IConnection;
    procedure SetaStatusPenCan(const AAutoincrem: String; AStatus : String);
    procedure FinalizarPendenciaComErro(const AAutInc: String; const AMessage : String);
  public
    function PendenciasDeCancelamento(const ACodigoEmpresa : String; const AConsiderarErros : Boolean = False; const ATipoFC : String = '') : TList<TDtoLogCan>;
    procedure IncrementaTentativasDeCancelamento(const AAutoincrem: String);
    procedure AtualizaHistorico(const AAutInc: String; const AMsgCan : String);
    procedure FinalizarPendenciaComErroMultiplasTentativas(const AAutInc: String);
    procedure FinalizarPendenciaComErroEstorno(const AAutInc, AMsgComplementar : String);
    constructor Create(const AConnection : IConnection);
  End;

implementation

uses untQuery, DateUtils, untFuncoesSimples, SysUtils;

{ TLogCanRepository }

procedure TLogCanRepository.AtualizaHistorico(const AAutInc: String; const AMsgCan: String);
  Var
    LQuery : IQuery;
    LMsgCan : String;
begin
  LQuery := FConnection.NewQuery;
  LMsgCan := 'Data: ' + FormatDateTime('dd-mm-yyyy', VS_Date) + ' Hora: ' + FormatDateTime('hh:mm:ss', fTime) + ' - ' + AMsgCan;
  LQuery.Close;
  LQuery.SQL.Text := 'UPDATE LOGCAN SET LOG_HISCAN = CONCAT_WS(''\n'', NULLIF(LOG_HISCAN, ''''), :MSGCAN) WHERE AUTOINCREM = :AUTINC';
  LQuery.ParamByName('MSGCAN').AsString := LMsgCan;
  LQuery.ParamByName('AUTINC').AsString := AAutInc;
  LQuery.ExecSQL;
end;

constructor TLogCanRepository.Create(const AConnection: IConnection);
begin
  FConnection := AConnection;
end;

procedure TLogCanRepository.FinalizarPendenciaComErro(const AAutInc: String; const AMessage : String);
begin
  FConnection.StartTransaction;
  Try
    AtualizaHistorico(AAutInc, AMessage);
    SetaStatusPenCan(AAutInc, 'E');
    FConnection.Commit;
  Except
    On E: Exception Do
    Begin
      FConnection.RollBack;
      Raise;
    End;
  End;
end;

procedure TLogCanRepository.FinalizarPendenciaComErroEstorno(const AAutInc, AMsgComplementar : String);
begin
  FinalizarPendenciaComErro(AAutInc, 'Pendência finalizada em razão de problemas ao estornar duplicatas.' + IIF(AMsgComplementar.IsEmpty, '', sLineBreak + AMsgComplementar));
end;

procedure TLogCanRepository.FinalizarPendenciaComErroMultiplasTentativas(const AAutInc: String);
begin
  FinalizarPendenciaComErro(AAutInc, 'Pendência finalizada em razão de múltiplas tentativas sem sucesso.');
end;

function TLogCanRepository.PendenciasDeCancelamento(const ACodigoEmpresa : String; const AConsiderarErros : Boolean = False; const ATipoFC : String = ''): TList<TDtoLogCan>;
  Var
    LQuery : IQuery;
    LLogCan : TDtoLogCan;
begin
  LQuery := FConnection.NewQuery;
  LQuery.Close;
  LQuery.SQL.Clear;
  LQuery.SQL.Add(' SELECT A.AUTOINCREM, A.LOG_NUMDOC, A.LOG_ESPDOC, A.LOG_CODEMP, A.LOG_FORCLI, ');
  LQuery.SQL.Add('        A.LOG_SERIE_, A.LOG_TIP_FC, A.LOG_TENTAT, A.LOG_DHUTEN, B.NFE_STATUS, ');
  LQuery.SQL.Add('        TIMESTAMP(LOG_DTACAN, LOG_HORCAN) AS DATA_HORA_CAN, LOG_DESMOT, LOG_MOTDEL, ');
  LQuery.SQL.Add('        LOG_HISCOM, LOG_OPCDEL ');
  LQuery.SQL.Add('   FROM LOGCAN A ');
  LQuery.SQL.Add('   LEFT JOIN LOGNFE B ON A.LOG_NUMDOC = B.NFE_NUMDOC ');
  LQuery.SQL.Add('                     AND A.LOG_ESPDOC = B.NFE_ESPDOC ');
  LQuery.SQL.Add('                     AND A.LOG_CODEMP = B.NFE_CODEMP ');
  LQuery.SQL.Add('                     AND A.LOG_FORCLI = B.NFE_CODCLI ');
  LQuery.SQL.Add('                     AND A.LOG_TIP_FC = B.NFE_TIP_FC ');
  LQuery.SQL.Add('                     AND A.LOG_SERIE_ = B.NFE_SERIE_ ');
  LQuery.SQL.Add('                     AND IFNULL(A.LOG_ACESSO,"") = IFNULL(B.NFE_ACESSO,"") ');
  LQuery.SQL.Add('  WHERE TRUE ');
  If (Not fEmptyStr(ACodigoEmpresa)) Then
    LQuery.SQL.Add('  AND A.LOG_CODEMP = :CODEMP ');
  If (AConsiderarErros) Then
    LQuery.SQL.Add('    AND A.LOG_PENCAN IN ("E", "S") ')
  Else
    LQuery.SQL.Add('    AND A.LOG_PENCAN = "S" ');
  LQuery.SQL.Add('    AND A.LOG_CANCOM = "N" ');
  LQuery.SQL.Add('    AND A.LOG_LIBCAN = "N" ');
  If (Not fEmptyStr(ATipoFC)) Then
    LQuery.SQL.Add('    AND A.LOG_TIP_FC = :TIP_FC ');
  If (Not fEmptyStr(ACodigoEmpresa)) Then
    LQuery.ParamByName('CODEMP').AsString := ACodigoEmpresa;
  If (Not fEmptyStr(ATipoFC)) Then
    LQuery.ParamByName('TIP_FC').AsString := ATipoFC;
  LQuery.Open;
  Result := TList<TDtoLogCan>.Create;
  If LQuery.IsEmpty Then
    Exit;
  LQuery.First;
  While Not LQuery.Eof Do
  Begin
    LLogCan := Default(TDtoLogCan);
    LLogCan.strNumDoc := LQuery.FieldByName('LOG_NUMDOC').AsString;
    LLogCan.strEspDoc := LQuery.FieldByName('LOG_ESPDOC').AsString;
    LLogCan.strCodEmp := LQuery.FieldByName('LOG_CODEMP').AsString;
    LLogCan.strCliFor := LQuery.FieldByName('LOG_FORCLI').AsString;
    LLogCan.strTip_Fc := LQuery.FieldByName('LOG_TIP_FC').AsString;
    LLogCan.strSerie := LQuery.FieldByName('LOG_SERIE_').AsString;
    LLogCan.intTentat := LQuery.FieldByName('LOG_TENTAT').AsInteger;
    LLogCan.dtaDhuTen := LQuery.FieldByName('LOG_DHUTEN').AsDateTime;
    LLogCan.strAutInc := LQuery.FieldByName('AUTOINCREM').AsString;
    LLogCan.blnInutil := (LQuery.FieldByName('NFE_STATUS').AsString = 'EE');
    LLogCan.dtaDtaHraCan := LQuery.FieldByName('DATA_HORA_CAN').AsDateTime;
    LLogCan.strDesMot := LQuery.FieldByName('LOG_DESMOT').AsString;
    LLogCan.strMotDel := LQuery.FieldByName('LOG_MOTDEL').AsString;
    LLogCan.strHisCom := LQuery.FieldByName('LOG_HISCOM').AsString;
    LLogCan.strOpcDel := LQuery.FieldByName('LOG_OPCDEL').AsString;
    Result.Add(LLogCan);
    LQuery.Next;
  End;
end;

procedure TLogCanRepository.IncrementaTentativasDeCancelamento(const AAutoincrem: String);
  Var
    LQuery : IQuery;
begin
  LQuery := FConnection.NewQuery;
  LQuery.Close;
  LQuery.SQL.Text := 'UPDATE LOGCAN SET LOG_DHUTEN = NOW(), LOG_TENTAT = LOG_TENTAT + 1 WHERE AUTOINCREM = :AUTINC';
  LQuery.ParamByName('AUTINC').AsString := AAutoincrem;
  LQuery.ExecSQL;
end;

procedure TLogCanRepository.SetaStatusPenCan(const AAutoincrem: String; AStatus : String);
  Var
    LQuery : IQuery;
begin
  LQuery := FConnection.NewQuery;
  LQuery.Close;
  LQuery.SQL.Text := 'UPDATE LOGCAN SET LOG_PENCAN = :PENCAN WHERE AUTOINCREM = :AUTINC';
  LQuery.ParamByName('PENCAN').AsString := AStatus;
  LQuery.ParamByName('AUTINC').AsString := AAutoincrem;
  LQuery.ExecSQL;
end;

end.
