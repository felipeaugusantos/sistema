unit untTEnviaEmailCancelamentoBoleto;

interface

uses untFuncoesSimples,untFuncoes, untTypesSistema,Data.DB,System.SysUtils,
     Uni,System.StrUtils,System.Variants;

Type
  TBoletoCancelado = Class
    LNumDup: String;
    LParcel: String;
    LEspDoc: String;
    LCodEmp: String;
    LCodCli: String;
    LAutInc: String;
    LLinDig: String;
    LSeqBai: Integer;
    LDtaCad: TDateTime;
    LDtaVen: TDateTime;
    LValDup: Double;
    LEmaCli: String;
  End;

Type
  TEnviaEmailCancelamentoBoleto = class(TObject)
  private
    LBoletoCancelado: TBoletoCancelado;
    LDadosEmail : TDadosDisparaEmail;
    function CriaObjetoBoletoCancelado(AAutoIncrem : String) : TBoletoCancelado;
    function CriaTabelaEmail:TArrDupTabelaEmail;
    procedure CarregaDadosEmail;
    function RetornaEmailDeEnvio(ADataSet: TDataset): String;
  public
    Constructor Create(AAutoIncrem: String);
    Destructor Destroy; Override;
    function EnviaEmailCancelamentoBoleto: Boolean;
 End;

implementation

{ TEnviaEmailCancelamentoBoleto }

procedure TEnviaEmailCancelamentoBoleto.CarregaDadosEmail;
  Var
    LNum_PD: String;
    LEmp_PD: String;
begin
  Try
    pRetNumeroPedidoVenda(LBoletoCancelado.LNumDup,
                          LBoletoCancelado.LEspDoc,
                          LBoletoCancelado.LCodEmp,
                          LBoletoCancelado.LCodCli,
                          LNum_PD,
                          LEmp_PD);

    LDadosEmail.strNumDoc         := LBoletoCancelado.LNumDup;
    LDadosEmail.strParcel         := LBoletoCancelado.LParcel;
    LDadosEmail.strCodCli         := LBoletoCancelado.LCodCli;
    LDadosEmail.strEspDoc         := LBoletoCancelado.LEspDoc;
    LDadosEmail.strCodEmp         := LBoletoCancelado.LCodCli;
    LDadosEmail.strNumOrc         := LNum_PD;
    LDadosEmail.strEspOrc         := IIF(fEmptyStr(LNum_PD),'', 'PD');
    LDadosEmail.strEmpOri         := LEmp_PD;
    LDadosEmail.strEmailCli       := LBoletoCancelado.LEmaCli;
    LDadosEmail.strLinhaDigitavel := LBoletoCancelado.LLinDig;
    LDadosEmail.strDtaEmi         := DateToStr(LBoletoCancelado.LDtaCad);
    LDadosEmail.strValDup         := FormatFloat('R$ #,##0.00', LBoletoCancelado.LValDup);
    LDadosEmail.strDtaVen         := DateToStr(LBoletoCancelado.LDtaVen);
    LDadosEmail.arrDupTabela      := CriaTabelaEmail;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(Concat(E.Message,' [TEnviaEmailCancelamentoBoleto.CarregaDadosEmail]'))
    End;
  End;
end;

constructor TEnviaEmailCancelamentoBoleto.Create(AAutoIncrem: String);
begin
  LBoletoCancelado := CriaObjetoBoletoCancelado(AAutoIncrem);
  CarregaDadosEmail;
end;

function TEnviaEmailCancelamentoBoleto.CriaObjetoBoletoCancelado(AAutoIncrem: String): TBoletoCancelado;
  Var
    LCadRec : TUniQuery;
begin
  Result :=  TBoletoCancelado.Create;
  Try
    LCadRec := fCriaQuery(Nil);
    Try
      LCadRec.Close;
      LCadRec.SQL.Clear;
      LCadRec.SQL.Text := 'SELECT                             '+
                          '  CTR_NUMDUP,                      '+
                          '  CTR_PARCEL,                      '+
                          '  CTR_ESPDOC,                      '+
                          '  CTR_CODEMP,                      '+
                          '  CTR_CODCLI,                      '+
                          '  CTR_SEQBAI,                      '+
                          '  CTR_DTACAD,                      '+
                          '  CTR_DTAVEN,                      '+
                          '  CTR_VALDUP,                      '+
                          '  CTR_LINDIG,                      '+
                          '  CLI_EMCOB1,                      '+
                          '  CLI_EMCOB2,                      '+
                          '  CLI_EMAIL_,                      '+
                          '  CLI_EMAIL2,                      '+
                          '  CLI_EMAIL3                       '+
                          'FROM                               '+
                          '  CADREC                           '+
                          '  JOIN CADCLI                      '+
                          '    ON CLI_CODCLI = CTR_CODCLI     '+
                          'WHERE CADREC.AUTOINCREM = :AUTOINC ';

      LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
      LCadRec.Open;

      Result.LNumDup := LCadRec.FieldByName('CTR_NUMDUP').AsString;
      Result.LParcel := LCadRec.FieldByName('CTR_PARCEL').AsString;
      Result.LEspDoc := LCadRec.FieldByName('CTR_ESPDOC').AsString;
      Result.LCodEmp := LCadRec.FieldByName('CTR_CODEMP').AsString;
      Result.LCodCli := LCadRec.FieldByName('CTR_CODCLI').AsString;
      Result.LSeqBai := LCadRec.FieldByName('CTR_SEQBAI').AsInteger;
      Result.LDtaCad := LCadRec.FieldByName('CTR_DTACAD').AsDatetime;
      Result.LDtaVen := LCadRec.FieldByName('CTR_DTAVEN').AsDatetime;
      Result.LValDup := LCadRec.FieldByName('CTR_VALDUP').AsFloat;
      Result.LAutInc := LCadRec.ParamByName('AUTOINC').AsString;
      Result.LLinDig := LCadRec.FieldByName('CTR_LINDIG').AsString;
      Result.LEmaCli := RetornaEmailDeEnvio(LCadRec);

    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(Concat(E.Message,' [TEnviaEmailCancelamentoBoleto.CriaObjetoBoletoCancelado]'));
      End;
    End;
  Finally
    FreeAndNil(LCadRec);
  End;
end;

function TEnviaEmailCancelamentoBoleto.CriaTabelaEmail: TArrDupTabelaEmail;
begin
  SetLength(Result,1);
  Result[0].strNumDoc := LBoletoCancelado.LNumDup;
  Result[0].strParcel := LBoletoCancelado.LParcel;
  Result[0].strEspDoc := LBoletoCancelado.LEspDoc;
  Result[0].strCodEmp := LBoletoCancelado.LCodEmp;
  Result[0].strCodCli := LBoletoCancelado.LCodCli;
  Result[0].dtaDtaCad := LBoletoCancelado.LDtaCad;
  Result[0].dtaDtaVen := LBoletoCancelado.LDtaVen;
  Result[0].fltVlrDup := LBoletoCancelado.LValDup;
  Result[0].strAutoIn := LBoletoCancelado.LAutInc;
  Result[0].intSeqBai := LBoletoCancelado.LSeqBai;
  Result[0].strLinDig := LBoletoCancelado.LLinDig;
end;

destructor TEnviaEmailCancelamentoBoleto.Destroy;
begin
  FreeAndNil(LBoletoCancelado);
  inherited;
end;

function TEnviaEmailCancelamentoBoleto.EnviaEmailCancelamentoBoleto: Boolean;
begin
  Result := True;
  If VarToStrDef(fCampoTabela('EMA_STATUS', 'EMASAI',['EMA_CODIGO', 'EMA_CODGRU', 'EMA_CODEMP', 'EMA_ENTSAI'],
                                                     ['003', '008', VS_strCodEmp, 'S']), '') = 'A' Then
    Result := fDisparaEmailBoletoAutomatico(LDadosEmail,'BO',staCancelandoBoleto);
end;

function TEnviaEmailCancelamentoBoleto.RetornaEmailDeEnvio(ADataSet: TDataset): String;
begin
  If (fCfgSis('GPEMCB', VarBoolean)) Then
  Begin
    Result := '';

    If Not fEmptyStr(ADataSet.FieldByName('CLI_EMCOB1').AsString) Then
      Result := ADataSet.FieldByName('CLI_EMCOB1').AsString;

    If Not fEmptyStr(ADataSet.FieldByName('CLI_EMCOB2').AsString) Then
    Begin
      If fEmptyStr(Result) Then
        Result := ADataSet.FieldByName('CLI_EMCOB2').AsString
      Else
        Result := Result + '; ' + ADataSet.FieldByName('CLI_EMCOB2').AsString;
    End;

    If fEmptyStr(Result) Then
    Begin
      If Not fEmptyStr(ADataSet.FieldByName('CLI_EMAIL_').AsString) Then
        Result := ADataSet.FieldByName('CLI_EMAIL_').AsString
      Else If Not fEmptyStr(ADataSet.FieldByName('CLI_EMAIL2').AsString) Then
        Result := ADataSet.FieldByName('CLI_EMAIL2').AsString;
    End;
  End
  Else
  Begin
    If Not fEmptyStr(ADataSet.FieldByName('CLI_EMCOB1').AsString) Then
      Result := ADataSet.FieldByName('CLI_EMCOB1').AsString
    Else If Not fEmptyStr(ADataSet.FieldByName('CLI_EMCOB2').AsString) Then
      Result := ADataSet.FieldByName('CLI_EMCOB2').AsString
    Else If Not fEmptyStr(ADataSet.FieldByName('CLI_EMAIL_').AsString) Then
      Result := ADataSet.FieldByName('CLI_EMAIL_').AsString
    Else If Not fEmptyStr(ADataSet.FieldByName('CLI_EMAIL2').AsString) Then
      Result := ADataSet.FieldByName('CLI_EMAIL2').AsString
    Else
      Result := '';
  End;

  If (Not fEmptyStr(ADataSet.FieldByName('CLI_EMAIL3').AsString)) Then
  Begin
    If (Not fEmptyStr(Result)) Then
      Result := Result + '; ' + ADataSet.FieldByName('CLI_EMAIL3').AsString
    Else
      Result := ADataSet.FieldByName('CLI_EMAIL3').AsString;
  End;

  Result := AnsiReplaceStr(Result, ';;', ';');
end;

end.
