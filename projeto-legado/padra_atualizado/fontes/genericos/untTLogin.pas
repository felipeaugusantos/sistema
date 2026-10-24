unit untTLogin;

interface

uses
  System.SysUtils, Uni, Login.View.Interfaces, Data.DB, System.StrUtils,
  System.Classes, System.Generics.Collections, Vcl.Forms, Dialogs, Menus,
  System.Variants, System.UITypes;

type
  TProcIniciaTagDir =  procedure() of object;
  TProcCarregarRelatorios = procedure() of object;
  TProcCarregarLibFuncoes = procedure() of object;
  TProcCarregarLibTintaMaquina = procedure() of object;
  TProcCarregarMenusAcesso = procedure() of object;
  TProcOrdenaMenu = procedure() of object;

type
  TLogin = class(TInterfacedObject, ILogin)
  private
    FLoginRealizado: Boolean;
    FLogoff: Boolean;
    FEmpresasLoginUsuario: String;
    FUsuario: String;
    FEmpresa: String;
    FPassword: String;
    procedure IncluiUsuario(AUsuario, ASenha, ANome: String);
    procedure CarregarUsuario();
  public
    function SetUsuario(AUsuario: String): ILogin;
    function Usuario(AUsuario: String): String;

    function NomeUsuario(): String;

    function RealizandoLogoff(): Boolean;

    function SetUtilizaModoClassico(AUser: String; AValue: Boolean): ILogin;
    function UtilizaModoClassico(AUser: String): Boolean;

    function SetPassword(APassword: String): ILogin;

    function SetEmpresa(AEmpresa: String): ILogin;
    function Empresa(): String;
    function NomeEmpresa: String; overload;
    function NomeEmpresa(ACodigoEmpresa: String): String; overload;
    function NomeFantasia(ACodigoEmpresa: String): String;

    function EmpresaDefault(): String;
    function EmpresasLoginUsuario(): String;

    function SelecionarEmpresa(strCodOpe: String = ''): Boolean;
    function ListaEmpresas(strCodOpe: String = ''): TArray<String>;

    procedure ValidarUsuario();
    procedure ValidarEmpresa(AValidaUsuarioTambem: Boolean = True);

    function ExecutarLogin(): Boolean;

    function LoginRealizado(): Boolean;

    function UsuarioLogado: String;

    constructor Create(ALogoff: Boolean);
  end;

  TSplashNotificacaoProgresso = class(TInterfacedObject, ISplashNotificacaoProgresso)
  private
    FMax: Integer;
    FProgresso: Integer;
    FMensagem: String;
    FDetalhes: String;
  public
    function SetMax(AValue: Integer): ISplashNotificacaoProgresso;
    function Max(): Integer;

    function SetProgresso(AValue: Integer): ISplashNotificacaoProgresso;
    function Progresso(): Integer;

    function SetMensagem(AValue: String): ISplashNotificacaoProgresso;
    function Mensagem(): String;

    function SetDetalhes(AValue: String): ISplashNotificacaoProgresso;
    function Detalhes(): String;

    class function New(): ISplashNotificacaoProgresso;
  end;

  TSplash = class(TInterfacedObject, ISplash)
  private
    FMax: Integer;
    FProgresso: Integer;
    FEtapa: String;
    FDetalhes: String;
    FViews: TList<ISplashView>;
    FExibirTelaAguarde: Boolean;
    FSplashRealizado: Boolean;
    FGeracaoAutomatica: Boolean;
    FImportacaoPDV: Boolean;
    FProcIniciaTagDir: TProcIniciaTagDir;
    FProcCarregarRelatorios: TProcCarregarRelatorios;
    FProcCarregarLibFuncoes: TProcCarregarLibFuncoes;
    FProcCarregarLibTintaMaquina: TProcCarregarLibTintaMaquina;
    FProcCarregarMenusAcesso: TProcCarregarMenusAcesso;
    FProcOrdenaMenu: TProcOrdenaMenu;
  protected
    procedure OnMensagemAguarde(ATexto: String);
    procedure pProgresso;
  public
    function AddView(AView: ISplashView): ISplash;
    function RemoveView(AView: ISplashView): ISplash;
    procedure NotificarViews(ANotificacao: ISplashNotificacaoProgresso);

    function ExecutarSplash(): Boolean;

    function SplashRealizado(): Boolean;

    destructor Destroy; override;

    constructor Create(AGeracaoAutomatica: Boolean;
                       AImportacaoPDV: Boolean;
                       AExibirTelaAguarde: Boolean;
                       AProcIniciaTagDir: TProcIniciaTagDir;
                       AProcCarregarRelatorios: TProcCarregarRelatorios;
                       AProcCarregarLibFuncoes: TProcCarregarLibFuncoes;
                       AProcCarregarLibTintaMaquina: TProcCarregarLibTintaMaquina;
                       AProcCarregarMenusAcesso: TProcCarregarMenusAcesso;
                       AProcOrdenaMenu: TProcOrdenaMenu);
  end;


implementation

uses untfuncoesSimples, untConstantes, untTHorOpe, untTypesSistema,
  untVersaoProg, untCfgRepositorio, untModuloSPR, untModuloReplicacao,
  untFuncoes, untCfgRel, untAtuVarGlobais, untFuncoesDiarias, untThreadUtils,
  untSenhaOperador;

{ TLogin }

procedure TLogin.CarregarUsuario;
begin
  FEmpresasLoginUsuario := fRetEmpLoginUsuario(FUsuario);
  strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(FUsuario);
  strEmpEstUsuarioLogado := fRetEmpEstUsuario(FUsuario);
  strEmpConsVendFatur := fRetEmpConsVendFatur(FUsuario);
end;

function TLogin.ExecutarLogin(): Boolean;
Var
  LStatusOperador: String;
  frmSenhaOperador: TfrmSenhaOperador;
begin
  FLoginRealizado := False;

  ValidarUsuario();
  ValidarEmpresa();

  pSetaEmpresaLogada(FEmpresa);

  If fValidaSenhaExpiradaOperador(FUsuario) Then
  Begin
    fMensagem('', 'Senha expirada - Favor efetuar a troca!', ['&Ok']);

    pCriarFormularios(TfrmSenhaOperador, frmSenhaOperador);

    Try
      frmSenhaOperador.edtLogin.Text := FUsuario;
      frmSenhaOperador.blnAbriuPelaTelaLogin := True;
      frmSenhaOperador.ShowModal;

      If not frmSenhaOperador.blnSenhaAlteradaSucesso Then
      Begin
        FLoginRealizado := False;
        Raise ELoginUsuarioException.Create('Senha expirada - Favor efetuar a troca!');
      End;

      Exit(False);
    Finally
      pFreeAndNil(frmSenhaOperador);
    End;
  End;

  If fCfgSis('DACPOR', varBoolean) Then
    strPortadoresOperador := fRetPortadoresOperador(FUsuario);

  {* CARACTERE FORA DE STR_CHAR_SENHA E CRIPTOGRAFADO PELO fCrypt COMO 'A' *}
  If Not fSenhaPermitida(FPassword) Then
    Raise ELoginUsuarioException.Create('Login ou Senha incorretos!');

  LStatusOperador := fCampoTabela('OPE_STATUS', 'CADOPE',
    ['OPE_CODOPE', 'BINARY OPE_SENOPE'], [FUsuario, fCrypt(FPassword)]);

  If Not LStatusOperador.IsEmpty Then
  Begin
    If (LStatusOperador = 'A') Then
    Begin
      strLoginUsuarioLogado := FUsuario;
      pCarregarVariaveisUsuarioLogado;
      VS_blnEmpLogadaPertenceBaseEmpFisica := fEmpLogadaPertenceBaseEmpFisica(True);

      If (THorOpe.fExisteRestricoesDeAcesso(resAcesso, True)) Then
        Raise ELoginUsuarioException.Create
          ('Usuário com restrições de acesso!');

      If fEmptyStr(strEmpAcessoUsuarioLogado) Then
        Raise ELoginUsuarioException.Create('Usuário sem empresas de acesso vinculadas');
    End
    Else
      Raise ELoginUsuarioException.Create
        ('Usuário Inativo - Sem permissão de acesso ao Sistema!');
  End
  Else
    Raise ELoginUsuarioException.Create('Login ou Senha incorretos!');

  VS_CfgJaVerificadas := False;
  FLoginRealizado := True;
  Result := True;
end;

constructor TLogin.Create(ALogoff: Boolean);
begin
  FLogoff := ALogoff;
end;

function TLogin.Empresa: String;
begin
  Result := FEmpresa;
end;

function TLogin.EmpresasLoginUsuario: String;
begin
  Result := FEmpresasLoginUsuario;
end;

function TLogin.EmpresaDefault: String;
var
  intParam: Integer;
  intPosParam: Integer;
  strParametro: String;
begin
  Result := fArqIni(0, 'GERAL', 'CODEMP', '');

  intPosParam := 0;
  For intParam := 1 To ParamCount Do
  begin
    if Pos('CODEMP', ParamStr(intParam)) > 0 then
    begin
      intPosParam := intParam;
      Break;
    end;
  end;

  if intPosParam > 0 then
  begin
    strParametro := ParamStr(intPosParam);
    Result := Copy(strParametro, Pos('=',strParametro)+1, Length(strParametro))
  end;
end;

function TLogin.NomeEmpresa: String;
begin
  Result := fRetNomeEmpresaSelec(FEmpresa);
end;

function TLogin.NomeEmpresa(ACodigoEmpresa: String): String;
begin
  Result := fRetNomeEmpresaSelec(ACodigoEmpresa);
end;

function TLogin.NomeFantasia(ACodigoEmpresa: String): String;
begin
  Result := fRetFantasiaEmpresa(ACodigoEmpresa);
end;

function TLogin.NomeUsuario: String;
begin
  Result := fRetNomeOperador(FUsuario);
end;

function TLogin.RealizandoLogoff: Boolean;
begin
  Result := FLogoff;
end;

function TLogin.Usuario(AUsuario: String): String;
begin
  Result := FUsuario;
end;

function TLogin.UsuarioLogado: String;
begin
  Result := strLoginUsuarioLogado;
end;

function TLogin.UtilizaModoClassico(AUser: String): Boolean;
begin
  {$IFDEF TESTABILIDADE_AUTCOM}
  Result := True
  {$Else}
  Exit(fGetUsuarioUtilizaModoClassico(AUser));
  {$ENDIF}
end;

function TLogin.ListaEmpresas(strCodOpe: String = ''): TArray<String>;
begin
  if not fEmptyStr(strCodOpe) then
    Result := String(fCampoTabela('OPE_EMPLOG', 'CADOPE', ['OPE_CODOPE'], [strCodOpe])).Split(['_'])
  else
    Result := String(fCampoTabela('GROUP_CONCAT(EMP_CODEMP)', 'CADEMP', ['LENGTH(EMP_CODEMP)'], ['3'])).Split([',']);
end;

function TLogin.LoginRealizado: Boolean;
begin
  Result := FLoginRealizado;
end;

procedure TLogin.ValidarEmpresa(AValidaUsuarioTambem: Boolean = True);
begin
  If fEmptyStr(FEmpresa) Then
    Raise ELoginEmpresaException.Create('A empresa deve ser informada!');

  If fEmptyStr(fRetNomeEmpresaSelec(FEmpresa)) Then
    Raise ELoginEmpresaException.Create('Código da empresa não encontrado.');

  If (AValidaUsuarioTambem) Then
  Begin
    If (Pos(FEmpresa, fRetEmpLoginUsuario(FUsuario)) <= 0) Then
      Raise ELoginEmpresaException.Create
        ('Usuário sem permissão de acesso a essa Empresa!');
  End;

  If Not fEmpresaAtiva(FEmpresa) Then
    Raise ELoginEmpresaException.Create('Esta empresa está inativa no Cadastro de Empresas. Não é possível o login!');
end;

procedure TLogin.ValidarUsuario();
begin
  If fEmptyStr(FUsuario) Then
    Raise ELoginUsuarioException.Create('Informe o Código do Usuário!');

  If FUsuario.Equals(LOG_ADM) Then
    IncluiUsuario(LOG_ADM, SEN_ADM, 'IMPLANTAÇÃO')

  Else If FUsuario.Equals('998') Then
    IncluiUsuario('998', '998', 'PROGRAMAÇÃO')

  Else If FUsuario.Equals('997') Then
    IncluiUsuario('997', '997', 'ATENDIMENTO');

  If fEmptyStr(fCampoTabela('OPE_CODOPE', 'CADOPE', ['OPE_CODOPE'],
    ['AUT'])) Then
    IncluiUsuario('AUT', SEN_AUT, 'TAREFA AUTOMÁTICA');
end;

procedure TLogin.IncluiUsuario(AUsuario, ASenha, ANome: String);
Var
  LQryGen: TUniQuery;
  LIncrem: String;
  LEmpresa: String;
Begin
  If fRetNomeOperador(AUsuario) = '' Then
  Begin
    LQryGen := fCriaQuery(nil);

    With LQryGen Do
    Begin

      If fEmptyStr(VS_strCodEmp) Then
      Begin
        LEmpresa := fCampoTabela('EMP_CODEMP', 'CADEMP', [], [], True,
          'EMP_CODEMP');
        pSetaEmpresaLogada(LEmpresa);
      End
      Else
        LEmpresa := VS_strCodEmp;

      LIncrem := fRetAutoIncrem('CADOPE', LEmpresa);

      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO CADOPE(AUTOINCREM,OPE_CODOPE,OPE_NOMOPE,' +
        'OPE_CODEMP,OPE_SENOPE,OPE_EMPACE, OPE_EMPLOG, OPE_STATUS) ');

      SQL.Add('VALUES (:AUTINC,:CODOPE,:NOMOPE,:CODEMP,' +
        ':SENOPE,:EMPACE, :EMPLOG, "A")');

      ParamByName('AUTINC').AsString := LIncrem;
      ParamByName('CODOPE').AsString := AUsuario;
      ParamByName('NOMOPE').AsString := ANome;
      ParamByName('CODEMP').AsString := LEmpresa;
      ParamByName('SENOPE').AsString := fCrypt(ASenha);
      ParamByName('EMPACE').AsString := LEmpresa + '_';
      ParamByName('EMPLOG').AsString := LEmpresa + '_';
      ExecSQL;
      Close;
    End;

    FreeAndNil(LQryGen);

  End;
End;

function TLogin.SelecionarEmpresa(strCodOpe: String = ''): Boolean;
Var
  qryGen: TUniQuery;
  arrOpcoes: Array Of String;

  strEmpLog: String;
  arrEmpLog: TArray<String>;
  chrSeparator: Char;

  strSQL: String;
Begin
  Result := False;
  strSql := EmptyStr;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;

    if not fEmptyStr(strCodOpe) then
    begin
      SQL.Clear;
      SQL.Add('SELECT OPE_EMPLOG FROM CADOPE WHERE OPE_CODOPE = :CODOPE');
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;

      chrSeparator := '_';
      arrEmpLog := FieldByName('OPE_EMPLOG').AsString.Split([chrSeparator]);

      for strEmpLog in arrEmpLog do
        strSQL := IIF(fEmptyStr(strSQL), QuotedStr(strEmpLog), strSQL + ',' + QuotedStr(strEmpLog));

      strSQL := ' WHERE EMP_CODEMP IN ('+strSQL+')';
    end;

    SQL.Clear;
    SQL.Add('SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP '+strSQL+' ORDER BY EMP_CODEMP');
    Open;

    If Not IsEmpty Then
    Begin
      SetLength(arrOpcoes, RecordCount);

      First;
      While Not Eof Do
      Begin
        arrOpcoes[Pred(recNo)] := FieldByName('EMP_CODEMP').AsString + ' - ' +
          FieldByName('EMP_NOMEMP').AsString;
        Next;
      End;

      FEmpresa := LeftStr(arrOpcoes[Pred(fGetMenu('Selecione a Empresa',
        arrOpcoes, 1, False, True))], 3);

      Result := True;
    End;

    Close;
  End;

  FreeAndNil(qryGen);
end;

function TLogin.SetEmpresa(AEmpresa: String): ILogin;
begin
  Result := Self;
  FEmpresa := AEmpresa;
end;

function TLogin.SetPassword(APassword: String): ILogin;
begin
  Result := Self;
  FPassword := APassword;
end;

function TLogin.SetUsuario(AUsuario: String): ILogin;
begin
  Result := Self;
  FUsuario := AUsuario;
  CarregarUsuario;
end;

function TLogin.SetUtilizaModoClassico(AUser: String; AValue: Boolean): ILogin;
begin
  Result := Self;

  {$IFDEF TESTABILIDADE_AUTCOM}
  blnUsuarioLogadoUtilizaModoClassico := True
  {$Else}
  TExecSQLNoWait.Exec(STR_SQL_NAO_REPLICAR +
    ' UPDATE CADOPE SET OPE_MODCLA = ' + IfThen(AValue, 'S', 'N').QuotedString +
    ' WHERE OPE_CODOPE = ' + AUser.QuotedString);
  blnUsuarioLogadoUtilizaModoClassico := AValue;
  {$ENDIF}
end;

{ TSplash }

function TSplash.AddView(AView: ISplashView): ISplash;
begin
  FViews.Add(AView);
end;

constructor TSplash.Create(AGeracaoAutomatica: Boolean;
                           AImportacaoPDV: Boolean;
                           AExibirTelaAguarde: Boolean;
                           AProcIniciaTagDir: TProcIniciaTagDir;
                           AProcCarregarRelatorios: TProcCarregarRelatorios;
                           AProcCarregarLibFuncoes: TProcCarregarLibFuncoes;
                           AProcCarregarLibTintaMaquina: TProcCarregarLibTintaMaquina;
                           AProcCarregarMenusAcesso: TProcCarregarMenusAcesso;
                           AProcOrdenaMenu: TProcOrdenaMenu);
begin
  FViews := TList<ISplashView>.Create;
  FSplashRealizado := False;
  FExibirTelaAguarde := AExibirTelaAguarde;
  FGeracaoAutomatica := AGeracaoAutomatica;
  FImportacaoPDV := AImportacaoPDV;
  FProcIniciaTagDir := AProcIniciaTagDir;
  FProcCarregarRelatorios := AProcCarregarRelatorios;
  FProcCarregarLibFuncoes := AProcCarregarLibFuncoes;
  FProcCarregarLibTintaMaquina := AProcCarregarLibTintaMaquina;
  FProcCarregarMenusAcesso := AProcCarregarMenusAcesso;
  FProcOrdenaMenu := AProcOrdenaMenu;

  If Not FExibirTelaAguarde Then
  Begin
    VS_ExibirMensagemAguarde := False;
    VS_OnMensagemAguarde     := Self.OnMensagemAguarde;
  End;
end;

destructor TSplash.Destroy;
var
  intIndex: Integer;
begin
  If Not FExibirTelaAguarde Then
  Begin
    VS_ExibirMensagemAguarde := True;
    VS_OnMensagemAguarde     := nil;
  End;

  If Assigned(FViews) Then
  Begin
    For intIndex := 0 to FViews.Count - 1 Do
      Pointer(FViews.List[intIndex]) := nil;
    FViews.Clear;
  End;

  FreeAndNil(FViews);
  inherited;
end;

function TSplash.ExecutarSplash: Boolean;
  Var
    objVersao: TControleVersao;
begin
  FMax := 12;

  FEtapa := 'Aguarde... Carregando dll de funções.';
  Inc(Fprogresso);
  pProgresso;

  If Assigned(FProcCarregarLibFuncoes) Then
    FProcCarregarLibFuncoes;

  FEtapa := 'Aguarde... Carregando dll de tinta de máquina.';
  Inc(Fprogresso);
  pProgresso;

  If Assigned(FProcCarregarLibTintaMaquina) Then
    FProcCarregarLibTintaMaquina;

  FEtapa := 'Aguarde... Carregando relatórios customizados.';
  Inc(Fprogresso);
  pProgresso;

  If Assigned(FProcCarregarRelatorios) Then
    FProcCarregarRelatorios;

  FEtapa := 'Aguarde... Carregando configurações.';
  Inc(Fprogresso);
  pProgresso;

  If Not FGeracaoAutomatica Then
    If Assigned(FProcIniciaTagDir) Then
      FProcIniciaTagDir;

  TfrmCfgRepositorio.pMontaArrConfiguracoes;

  FEtapa := 'Aguarde... Carregando controle de versões.';
  Inc(Fprogresso);
  pProgresso;

  If (Not FImportacaoPDV) And (Not FGeracaoAutomatica) Then
  Begin
    objVersao := TControleVersao.Create;
    FreeAndNil(objVersao);
  End;

  FEtapa := 'Aguarde... Carregando módulos do sistema.';
  Inc(Fprogresso);
  pProgresso;

  {*****************************************}
  {* INICIALIZA OS MODULOS                 *}
  {**************************************MV*}
  Try
    pCriarFormularios(TfrmModuloSPR, frmModuloSPR);
    //-----------------------------------------------------------
    pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));
    //-------------------------------------------------------------------
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmSplash]');
      Exit;
    End;
  End;

  fAjustaDataSistema;

  //*****************************************************//
  // VERIFICA A VALIDADE DA CÓPIA                        //
  //**************************************************ED*//
  If (fArqIni(0,'GERAL','CODINT','') = '1') Or fEmptyStr(fArqIni(0,'GERAL','CODINT','')) And (Not FGeracaoAutomatica) Then
  Begin
    If Not fValidade_Sistema Then
    Begin
      fMensagem('', 'A validade do sistema expirou!', ['&Ok']);

      If Not fFormDesbloqueio Then
        Exit(False);
    End;
  End;

  FEtapa := 'Aguarde... Carregando filas de impressão.';
  Inc(Fprogresso);
  pProgresso;

  {*****************************************}
  {* ALIMENTA A VARIAVEL "VS_blnTemFil     *}
  {**************************************MV*}
  pCarregaVsTemFil;

  FEtapa := 'Aguarde... Carregando variáveis globais do sistema.';
  Inc(Fprogresso);
  pProgresso;

  {**************************************}
  {* ATUALIZA VARIAVEIS GLOBAIS         *}
  {***********************************JB*}
  If Not pAtuVarGlobais Then
    Exit(False);

  {*****************************************}
  {* PEGA AS FILAS DE IMPRESSAO            *}
  {**************************************MV*}
  If Not FGeracaoAutomatica Then
    pRetFilasImpressao(TCfgRel.arrFilas);

  FEtapa := 'Aguarde... Executando funções diárias.';
  Inc(Fprogresso);
  pProgresso;

  If Not FGeracaoAutomatica Then
    pFuncoesDiarias()
  Else pVerificaProCod;

  FEtapa := 'Aguarde... Ordenando menus.';
  Inc(Fprogresso);
  pProgresso;

  If Assigned(FProcOrdenaMenu) Then
    FProcOrdenaMenu;

  FEtapa := 'Aguarde... Carregando menus do operador.';
  Inc(Fprogresso);
  pProgresso;

  If Assigned(FProcCarregarMenusAcesso) Then
    FProcCarregarMenusAcesso;

  Inc(Fprogresso);
  pProgresso;

  Result := True;
  FSplashRealizado := True;
end;

procedure TSplash.NotificarViews(ANotificacao: ISplashNotificacaoProgresso);
Var
  LView: ISplashView;
begin
  For LView In FViews Do
    LView.NotificarProgresso(ANotificacao);
end;

procedure TSplash.OnMensagemAguarde(ATexto: String);
begin
  FDetalhes := ATexto;
  pProgresso;
end;

procedure TSplash.pProgresso;
begin
  NotificarViews(
    TSplashNotificacaoProgresso.New
      .SetMax(FMax)
      .SetProgresso(FProgresso)
      .SetMensagem(FEtapa)
      .SetDetalhes(FDetalhes)
    );
  Application.ProcessMessages;
end;

function TSplash.RemoveView(AView: ISplashView): ISplash;
begin
  FViews.Remove(AView);
end;

function TSplash.SplashRealizado: Boolean;
begin
  Result := FSplashRealizado;
end;

{ TSplashNotificacaoProgresso }

function TSplashNotificacaoProgresso.Detalhes: String;
begin
  Result := FDetalhes;
end;

function TSplashNotificacaoProgresso.Max: Integer;
begin
  Result := FMax;
end;

function TSplashNotificacaoProgresso.Mensagem: String;
begin
  Result := FMensagem;
end;

class function TSplashNotificacaoProgresso.New: ISplashNotificacaoProgresso;
begin
  Result := Self.Create;
end;

function TSplashNotificacaoProgresso.Progresso: Integer;
begin
  Result := FProgresso;
end;

function TSplashNotificacaoProgresso.SetDetalhes(
  AValue: String): ISplashNotificacaoProgresso;
begin
  Result := Self;
  FDetalhes := AValue;
end;

function TSplashNotificacaoProgresso.SetMax(
  AValue: Integer): ISplashNotificacaoProgresso;
begin
  Result := Self;
  FMax := AValue;
end;

function TSplashNotificacaoProgresso.SetMensagem(
  AValue: String): ISplashNotificacaoProgresso;
begin
  Result := Self;
  FMensagem := AValue;
end;

function TSplashNotificacaoProgresso.SetProgresso(
  AValue: Integer): ISplashNotificacaoProgresso;
begin
  Result := Self;
  FProgresso := AValue;
end;

end.
