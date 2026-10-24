unit untTValidaCorrespondenteContabil;

interface

Uses untFuncoesSimples,MadExcept,System.SysUtils,untLiberacao,untMsgLiberacao,
     System.Classes ;

Type
  TValidaCorrespondenteContabil = Class(TObject)
  Private
    FUtilizaContabilidade : Boolean;
    FTravar : Boolean;
    FLiberacao : TLiberacao;
    FPortadoresValidados : TStringList;
    FPlanoDeContasValidados : TStringList;
    function ValidarPortador(ACodPor,ACodEmp:String):Boolean;
    function ValidarPlanoDeConta(ACodCta,ACodEmp:String):Boolean;
    function LiberaPortador(ACodPor:String):Boolean;
    function LiberaPlanoDeConta(ACodCta:String):Boolean;
    function PortadorJaValidado(ACodPor:String):Boolean;
    function PlanoDeContasJaValidado(ACodCta:String):Boolean;
    function ValidaEmpresa(Var ACodEmp: String): Boolean;
  Public
    constructor Create;
    Destructor Destroy; Override;
    function PortadorPossuiCorrespondenteContabil(ACodPor : String; ACodEmp : String):Boolean;
    function PlanoDeContasPossuiCorrespondenteContabil(ACodCta : String; ACodEmp : String):Boolean;
    procedure AddPortadorValidado(ACodPor:String);
    procedure AddPlanoDeContasValidado(ACodCta:String);
    procedure LimparListas;

  End;

implementation

{ TValidaCorrespondenteContabil }

procedure TValidaCorrespondenteContabil.AddPlanoDeContasValidado(
  ACodCta: String);
begin
  If fEmptyStr(ACodCta) Then
    Exit;

  If Not PlanoDeContasJaValidado(ACodCta)Then
    FPlanoDeContasValidados.Add(ACodCta);
end;

procedure TValidaCorrespondenteContabil.AddPortadorValidado(ACodPor: String);
begin
  If fEmptyStr(ACodPor) Then
    Exit;

  If Not PortadorJaValidado(ACodPor)Then
    FPortadoresValidados.Add(ACodPor);
end;

constructor TValidaCorrespondenteContabil.Create;
begin
  FLiberacao  := TLiberacao.Create;
  FPortadoresValidados := TStringList.Create;
  FPlanoDeContasValidados := TStringList.Create;
end;

destructor TValidaCorrespondenteContabil.Destroy;
begin
  FreeAndNil(FLiberacao);
  FreeAndNil(FPortadoresValidados);
  FreeAndNil(FPlanoDeContasValidados);
  inherited;
end;

function TValidaCorrespondenteContabil.LiberaPlanoDeConta(
  ACodCta: String): Boolean;
begin
  pRemoveLiberacao('PERALTDOCFIN',ACodCta);
  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('*** PLANO DE CONTAS SEM CORRESPONDENTE CONTÁBIL ***',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PARA AS EMPRESAS QUE UTILIZAM A ROTINA CONTÁBIL, SE FAZ  NECESSÁRIO A ASSOCIAÇÃO DE UM ',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PLANO CONTÁBIL PARA O PLANO DE CONTAS, AFIM DE EVITAR PROBLEMAS NA GERAÇÃO DO MOVIMENTO CONTÁBIL. ',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PLANO DE CONTAS: ' + Concat(ACodCta,' - '+ fRetNomeConta(ACodCta)),alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);

  FLiberacao.strDirAce := 'PERALTDOCFIN';
  FLiberacao.strMsgSen := 'Plano de Contas sem correspondente contábil';
  FLiberacao.strCodIte := ACodCta;
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := FLiberacao.fLibera;
end;

function TValidaCorrespondenteContabil.LiberaPortador(ACodPor: String): Boolean;
begin
  pRemoveLiberacao('PERALTDOCFIN',ACodPor);
  FLiberacao.Clear;
  FLiberacao.objMsgLibera.pAddTexto('*** PORTADOR SEM CORRESPONDENTE CONTÁBIL ***',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PARA AS EMPRESAS QUE UTILIZAM A ROTINA CONTÁBIL, SE FAZ  NECESSÁRIO A ASSOCIAÇÃO DE UM ',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PLANO CONTÁBIL PARA O PORTADOR, AFIM DE EVITAR PROBLEMAS NA GERAÇÃO DO MOVIMENTO CONTÁBIL. ',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);
  FLiberacao.objMsgLibera.pAddTexto('PORTADOR: ' + Concat(ACodPor,' - '+ fRetNomPortador(ACodPor)),alCentro);
  FLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------------------------------------------',alCentro);

  FLiberacao.strDirAce := 'PERALTDOCFIN';
  FLiberacao.strMsgSen := 'Portador sem correspondente contábil';
  FLiberacao.strCodIte := ACodPor;
  FLiberacao.strCodOpe := strLoginUsuarioLogado;
  FLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := FLiberacao.fLibera;
end;

procedure TValidaCorrespondenteContabil.LimparListas;
begin
  FPortadoresValidados.Clear;
  FPlanoDeContasValidados.Clear;
end;

function TValidaCorrespondenteContabil.PlanoDeContasJaValidado(
  ACodCta: String): Boolean;
  Var
    LContador : Integer;
begin
  Result := False;

  For LContador := 0 to Pred(FPlanoDeContasValidados.Count) do
  Begin
    If FPlanoDeContasValidados[LContador].Equals(ACodCta) Then
      Exit(True);
  End;
end;

function TValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(ACodCta, ACodEmp: String): Boolean;
begin
  Result := True;

  Try
    If Not ValidarPlanoDeConta(ACodCta,ACodEmp) Then
      Exit;

    If Not FTravar Then
    Begin
      Result := False;

      If fMensagem('AVISO','Para as empresas que utilizam a rotina contábil, se faz  necessário a associação de um plano contábil '+
                           'para o Plano de Contas, afim de evitar problemas na geração do movimento contábil.'+ #13#10 +
                           'Deseja continuar mesmo assim?',['&Sim', '&Não'], 2) = 1 Then
        Result := True;

    End Else
    Begin
      Result := LiberaPlanoDeConta(ACodCta);
    End;

    If Result Then
      AddPlanoDeContasValidado(ACodCta);

  Except
    On E : Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function TValidaCorrespondenteContabil.PortadorJaValidado(
  ACodPor: String): Boolean;
  Var
    LContador : Integer;
begin
  Result := False;

  For LContador := 0 to Pred(FPortadoresValidados.Count) do
  Begin
    If FPortadoresValidados[LContador].Equals(ACodPor) Then
      Exit(True);
  End;
end;

function TValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(ACodPor: String; ACodEmp : String): Boolean;
begin
  Result := True;
  Try

    If Not ValidarPortador(ACodPor,ACodEmp) Then
      Exit;

    If Not FTravar Then
    Begin
      Result := False;

      If fMensagem('AVISO','Para as empresas que utilizam a rotina contábil, se faz  necessário a associação de um plano contábil '+
                           'para o portador, afim de evitar problemas na geração do movimento contábil.'+ #13#10 +
                           'Deseja continuar mesmo assim?',['&Sim', '&Não'], 2) = 1 Then
        Result := True;
    End Else
    Begin
      Result := LiberaPortador(ACodPor);
    End;

    If Result Then
      AddPortadorValidado(ACodPor);

  Except
    On E : Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function TValidaCorrespondenteContabil.ValidaEmpresa(Var ACodEmp: String): Boolean;
  Var
    LNomeEmpresa : String;
begin
  Result := True;

  If fEmptyStr(ACodEmp) Then
    Exit(False);

  LNomeEmpresa := fRetNomeEmpresaSelec(ACodEmp);

  If fEmptyStr(LNomeEmpresa) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informar uma empresa de lançamento existente para validação do correspondente contábil', ['&Ok']);
    Result := False;
  End;

end;

function TValidaCorrespondenteContabil.ValidarPlanoDeConta(ACodCta,
  ACodEmp: String): Boolean;
  Var
    LCorrespondenteContabil : String;
begin
  Result := True;

  If Not ValidaEmpresa(ACodEmp) Then
    Exit(False);

  FUtilizaContabilidade := fCfgSis('UTICON', varBoolean,ACodEmp);
  FTravar := (fCfgSis('ALTFIN', varInteger,ACodEmp) = 1);

  If Not FUtilizaContabilidade Then
    Exit(False);

  If PlanoDeContasJaValidado(ACodCta) Then
    Exit(False);

  LCorrespondenteContabil := fCampoTabela('NCO_CODCON',
                                          'CTANCO',
                                          ['NCO_CODCTA', 'NCO_CODEMP'],
                                          [ACodCta, VS_strCodEmp],
                                          False);

  If LCorrespondenteContabil.IsEmpty Then
    LCorrespondenteContabil :=  fCampoTabela('CTA_PLANCO', 'CADCTA', ['CTA_CODCTA'], [ACodCta], False);

  If Not fEmptyStr(LCorrespondenteContabil) Then
    Exit(False);

end;

function TValidaCorrespondenteContabil.ValidarPortador(ACodPor, ACodEmp: String): Boolean;
  Var
    LCorrespondenteContabil : String;
begin
  Result := True;

  If Not ValidaEmpresa(ACodEmp) Then
    Exit(False);

  FUtilizaContabilidade := fCfgSis('UTICON', varBoolean,ACodEmp);
  FTravar := (fCfgSis('ALTFIN', varInteger,ACodEmp) = 1);

  If Not FUtilizaContabilidade Then
    Exit(False);

  If PortadorJaValidado(ACodPor) Then
    Exit(False);

  LCorrespondenteContabil := fCampoTabela('NCO_CODCON',
                                          'PORNCO',
                                          ['NCO_CODPOR', 'NCO_CODEMP'],
                                          [ACodPor, VS_strCodEmp],
                                          False);

  If LCorrespondenteContabil.IsEmpty Then
    LCorrespondenteContabil :=  fCampoTabela('POR_PLANCO', 'CADPOR', ['POR_CODPOR'], [ACodPor], False);

  If Not fEmptyStr(LCorrespondenteContabil) Then
    Exit(False);

end;

end.
