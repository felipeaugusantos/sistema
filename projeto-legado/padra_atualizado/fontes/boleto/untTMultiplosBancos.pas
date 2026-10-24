unit untTMultiplosBancos;

interface

uses Uni, Classes, strUtils, System.SysUtils, untFuncoesSimples,untConstantes,
     untTDigBoleto;

Type
  TMultiplosBancos = class(TComponent)
    private
      FCodCnd : String;
      FCodFpg : String;
      FCodCli : String;
      FEspDoc : String;

      FDigBoleto: TDigBoleto;

      function fUtilizaRotinaMultiplosBancos: Boolean;
      function fTemPortadorNosCadastros: Boolean;
      function fGetValue(ValueFF,ValueNF : Variant): Variant;
      function fStrToInt(Value : Variant):Integer;
    public
      FCarregarDadosMultiplosBancos: Boolean;
      procedure pCarregaDadosMultiplosBancos(Var FMltCodBco,
                                                 FMltCodPor,
                                                 FMltBcoIni: String;
                                             Var FMltCodCar: Integer;
                                                 FMltDtaCad,
                                                 FMltDtaVen : TDateTime);
      function fValidaPortadorMultiplosBancos(strCodPor : String): Boolean;
      function fValidaBancoMultiplosBancos(strCodBco : String): Boolean;
      function RetornaNossoNumero(ACodBco, ABcoIni, ACodEmp: String; ACodCar: Integer): string;

      Constructor Create(FMltCodCnd,FMltCodFpg,
                         FMltCodCli,FMltEspDoc: String); Reintroduce;
      Destructor Destroy; Override;
    published
      property strCodCnd  : String  read FCodCnd  write FCodCnd;
      property strCodFpg  : String  read FCodFpg  write FCodFpg;
      property strCodCli  : String  read FCodCli  write FCodCli;
      property strEspDoc  : String  read FEspDoc  write FEspDoc;
  End;

implementation

{ TMultiplosBancos }

constructor TMultiplosBancos.Create(FMltCodCnd,FMltCodFpg,
                                    FMltCodCli,FMltEspDoc: String);
begin
  FCodCnd := FMltCodCnd;
  FCodFpg := FMltCodFpg;
  FCodCli := FMltCodCli;
  FEspDoc := FMltEspDoc;

  FCarregarDadosMultiplosBancos := (fUtilizaRotinaMultiplosBancos And
                                    Not fTemPortadorNosCadastros);

  FDigBoleto := TDigBoleto.Create;
end;

destructor TMultiplosBancos.Destroy;
begin
  FreeAndNil(FDigBoleto);
  inherited;
end;

function TMultiplosBancos.fGetValue(ValueFF, ValueNF: Variant): Variant;
begin
  Result :=  IIF((strEspDoc = 'FF'), ValueFF, ValueNF);
end;

function TMultiplosBancos.fStrToInt(Value: Variant): Integer;
begin
  Try
    If fEmptyStr(Value) Then
      Result := 0
    Else
      Result :=  StrToInt(Value);
  Except
    Result := 0;
  End;
end;

function TMultiplosBancos.fTemPortadorNosCadastros: Boolean;
begin
  Result := False;
  {********************************}
  {* VERIFICA FORMA DE PAGAMENTO  *}
  {*****************************MT*}
  If (Not fEmptyStr(strCodFpg)) Then
  Begin
    Result := Not fEmptyStr(fCampoTabela('FPG_CODPOR', 'CADFPG', ['FPG_CODIGO'], [strCodFpg])) ;
  End;

  If Not Result Then
  Begin
    {**********************************}
    {* VERIFICA CONDIÇÃO DE PAGAMENTO *}
    {*******************************MT*}
    If (Not fEmptyStr(strCodCnd)) Then
    Begin
      Result := Not fEmptyStr(fCampoTabela('CND_CODPOR', 'CADCND', ['CND_CODIGO'], [strCodCnd])) ;
    End;
  End;

  If Not Result Then
  Begin
    {*********************}
    {* VERIFICA CLIENTE  *}
    {******************MT*}
    If (Not fEmptyStr(strCodCli)) Then
    Begin
      If (strEspDoc = 'FF') Then
        Result := Not fEmptyStr(fCampoTabela('CLI_CODPO2', 'CADCLI', ['CLI_CODCLI'], [strCodCli]))
      Else
        Result := Not fEmptyStr(fCampoTabela('CLI_CODPOR', 'CADCLI', ['CLI_CODCLI'], [strCodCli])) ;
    End;
  End;
end;

function TMultiplosBancos.fUtilizaRotinaMultiplosBancos: Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('CFB_CODBCO', 'CFGBOL', ['CFB_CODEMP'], [VS_strCodEmp])) ;
end;

function TMultiplosBancos.fValidaBancoMultiplosBancos(strCodBco: String): Boolean;
begin
  Result := True;

  If fEmptyStr(strCodBco) Then
  Begin
    Result := False;
  End
  Else If (Pos(strCodBco, BANCOS_LASER) <= 0) And
          (strCodBco <> '778')                And
          (strCodBco <> '999')                Then
  Begin
    Result := False;
  End
  Else
  Begin
    If fEmptyStr(fCampoTabela('BCO_CODBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco])) Then
    Begin
      Result := False;
    End;
  End;

end;

function TMultiplosBancos.fValidaPortadorMultiplosBancos(strCodPor: String): Boolean;
begin
  {*****************************************}
  {* VALIDA O PORTADOR                     *}
  {**************************************MT*}
  Result := True;

  If fEmptyStr(strCodPor) Then
  Begin
    Result := False;
  End
  Else
  Begin
    If fEmptyStr(fCampoTabela('POR_CODPOR', 'CADPOR', ['POR_CODPOR'], [strCodPor])) Then
    Begin
      Result := False;
    End
    {*REQ*145940**********RP*}
    Else If Not fEmpresaTemAcessoPortador(strCodPor) Then
    Begin
      Result := False;
    End
    Else If  Not fPortadorPermiteBoletoFaturamento(strCodPor) Then
    Begin
      Result := False;
    End
    Else If (fCampoTabela('POR_IMPBOL', 'CADPOR', ['POR_CODPOR'], [strCodPor]) = 'N') Then
    Begin
      Result := False;
    End
  End;

end;

procedure TMultiplosBancos.pCarregaDadosMultiplosBancos(Var FMltCodBco,
                                                            FMltCodPor,
                                                            FMltBcoIni: String;
                                                        Var FMltCodCar: Integer;
                                                            FMltDtaCad,
                                                            FMltDtaVen: TDateTime);
  Var
    qryCfgMltBan : TUniQuery;
    strSql : String;
Begin

  If FCarregarDadosMultiplosBancos Then
  Begin
    Try
      strSql := '';
      strSql := strSql + 'SELECT                                          ';
      strSql := strSql + '  *                                             ';
      strSql := strSql + 'FROM                                            ';
      strSql := strSql + '  CFGBOL                                        ';
      strSql := strSql + 'WHERE CFB_CODEMP = :CODEMP                      ';
      strSql := strSql + '  AND DATEDIFF(:DTAVEN, :DTACAD) <= CFB_QTDDIA   ';
      strSql := strSql + 'ORDER BY CFB_QTDDIA                             ';

      Try
        qryCfgMltBan := fCriaQuery(Nil);
        qryCfgMltBan.Close;
        qryCfgMltBan.SQL.Clear;
        qryCfgMltBan.SQL.Text := strSql;
        qryCfgMltBan.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryCfgMltBan.ParamByName('DTAVEN').AsDateTime := FMltDtaVen;
        qryCfgMltBan.ParamByName('DTACAD').AsDateTime := FMltDtaCad;
        qryCfgMltBan.Open;

        FMltCodPor := fGetValue(qryCfgMltBan.FieldByName('CFB_POR_FF').AsString, qryCfgMltBan.FieldByName('CFB_CODPOR').AsString);
        FMltCodBco := fGetValue(qryCfgMltBan.FieldByName('CFB_BCO_FF').AsString, qryCfgMltBan.FieldByName('CFB_CODBCO').AsString);
        FMltBcoIni := fGetValue(qryCfgMltBan.FieldByName('CFB_INI_FF').AsString, qryCfgMltBan.FieldByName('CFB_BCOINI').AsString);;
        FMltCodCar := fStrToInt(fGetValue(qryCfgMltBan.FieldByName('CFB_CAR_FF').AsString, qryCfgMltBan.FieldByName('CFB_CARTEI').AsString));

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'TMultiplosBancos.pCarregaDadosMultiplosBancos');
        End;
      End;
    Finally
      FreeAndNil(qryCfgMltBan);
    End;
  End;
end;

function TMultiplosBancos.RetornaNossoNumero(ACodBco, ABcoIni, ACodEmp: String; ACodCar: Integer): string;
  Var
    LCadBco: TUniQuery;
begin
  Result := '';
  Try
    LCadBco := fCriaQuery(Nil);
    Try
      LCadBco.Close;
      LCadBco.SQL.Clear;
      LCadBco.SQL.Text := 'SELECT * FROM CADBCO WHERE BCO_CODBCO = :CODBCO';
      LCadBco.ParamByName('CODBCO').AsString := ACodBco;
      LCadBco.Open;

      Result := FDigBoleto.fPegaNossoNumero(LCadBco, ACodBco, ABcoIni, ACodEmp, ACodCar);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LCadBco);
  End;
end;

end.
