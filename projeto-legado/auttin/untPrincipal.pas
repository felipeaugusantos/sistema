unit untPrincipal;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, ExtCtrls, Controls, ComCtrls,
  Graphics, Buttons, Forms, Dialogs, StdCtrls, ImgList, MidasLib,
  StrUtils,  Uni,  UniClientDataSet, untLogTrace,
  untTintadeMaquina, untICadastroTintaBase, untITintasDeMaquina,
  untICadastroTintaColorantes,  untICadastroTintaBaseAutomotiva,
  MadExcept, {untICadastroTintaColorantesEmbalagem,}
  untLogForm, untTestabilidade, dxGDIPlusClasses;

TYPE
  TfrmPrincipal = class(TForm)
    stbStatus: TStatusBar;
    tmrRelogio: TTimer;
    pnlRodape: TPanel;
    mnuAutCai: TMainMenu;
    mnuTintasMaquina: TMenuItem;
    trvMenu: TTreeView;
    pnlImagem: TPanel;
    Image1: TImage;
    btnSair: TSpeedButton;

    splDivisoria: TSplitter;
    tmrDataSistema: TTimer;
    mnuConfiguracoes: TMenuItem;

    // Glasurit
    mnuGlasurit: TMenuItem;
    mnuConfiguracoesGlasurit: TMenuItem;
    mnuCadGlabases: TMenuItem;
    mnuCadGlaNovasFormulas: TMenuItem;
    mnuCadGlaGeraArquivo: TMenuItem;
    mnuConsultaGlasurit: TMenuItem;
    mnuCadGlaGerNfm: TMenuItem;
    mnuSalcomix: TMenuItem;
    mnuConfiguracoesSalcomix: TMenuItem;
    mnuCadSalBases: TMenuItem;
    mnuCadSalNovasFormulas: TMenuItem;
    mnuCadSalGeraArquivo: TMenuItem;
    mnuConsultaSalcomix: TMenuItem;
    mnuCadSalGerNfm: TMenuItem;

    procedure tmrRelogioTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure btnSairClick(Sender: TObject);

    procedure mnuConfiguracoesClick(Sender: TObject);
    procedure pVerificaTrv;
    procedure trvMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure trvMenuDblClick(Sender: TObject);
    function fVerificaAcessoAutTin(strNomeForm: String): Boolean;

    procedure FormDestroy(Sender: TObject);
    procedure tmrDataSistemaTimer(Sender: TObject);


    // GLASURIT
    procedure mnuConfiguracoesGlasuritClick(Sender: TObject);
    procedure mnuCadGlaBasesClick(Sender: TObject);
    procedure mnuCadGlaNovasFormulasClick(Sender: TObject);
    procedure mnuCadGlaGeraArquivoClick(Sender: TObject);
    procedure mnuConsultaGlasuritClick(Sender: TObject);
    procedure mnuCadGlaGerNfmClick(Sender: TObject);
    procedure mnuConfiguracoesSalcomixClick(Sender: TObject);
    procedure mnuCadSalBasesClick(Sender: TObject);
    procedure mnuCadSalNovasFormulasClick(Sender: TObject);
    procedure mnuCadSalGeraArquivoClick(Sender: TObject);
    procedure mnuConsultaSalcomixClick(Sender: TObject);
    procedure mnuCadSalGerNfmClick(Sender: TObject);

  private
    { Private declarations }
    mnuBarrinha: TMenuItem;
    iTintas: ITintasDeMaquina;
    lstMenu: TList;
    blnLogado: Boolean;
    blnLogouComSenha: Boolean;
    function fAcessoGeracaoTintas():Boolean;

    procedure pVerificaMenu(Item: TMenuItem);
    procedure pCarregaVsTemFil;
    function fTintaDisponivel(strTinta: String): Boolean;
    function fAdicionarMenu(arvore:TTreeView; menuItem: TMenuItem; arvoreItem: TTreeNode = nil): TTreeNode;
    procedure pAcertaCfgUsaForTintas;
    procedure ConfigurarTinta(tela: TFormClass);
    procedure ProcessarMenuTintasDlls;
    procedure mnuGenericDllTintaMenuClick(Sender: TObject);
    function fMenuPodeFicarVisivel(strHint: String): Boolean;
    function fRetornaOHintDeTodasAsTintas: String;
    function fRetVersaoTintometrico(strIdepro : String) : String;
  public
    { Public declarations }
    procedure pProcessaMenu;
    procedure pGeraVetor;
    procedure pSelecionaMenu(strNome: String);
    procedure pCadastrarNovasFormulas(tintaClasse: TTintadeMaquinaClasse);
    destructor Destroy; override;

  published
    objTestabilidade: TTestabilidade;

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untFuncoes, untConstantes,  DB,
    untModulo, untModuloCons, untModuloSPR,
    untModuloTinta, untFuncTinta, untConfiguracoes,
    untFuncoesSimples, untModuloReplicacao,untPaiGeraArq,
    untGlasuritDinamica, untConfiguracoesGlasurit, untCadGlaBases,
    untCadGlaNovasFormulas, untCadGlaGeraArquivo,
    untIConfTinta,
    untAbstractGravando,
    untGravandoFactory,
    untLogAut,
    //untGenericGravandoExecucaoArquivos,
    // untGenericGravandoExecucao,
    //untGenericGravandoExecucaoArquivosInsert,
    //untGenericGravandoExecucaoArquivosInsertGravando,
    untILibTintaFactory, untILibTinta, untIAuttinMenuItem,
    untGerenciadorMenuAuttinDlls, untAuttinWrapper, untExecutaSQLReplicacaoTinta, untCadSalBases,
    untCadSalNovasFormulas, untConfiguracoesSalcomix, untCadSalGeraArquivo,
    untSalcomixDinamica, untHorarioSistema;


{$R *.dfm}

procedure TfrmPrincipal.tmrRelogioTimer(Sender: TObject);
begin
  stbStatus.Panels[1].Text := FormatDateTime('dd/mm/yyyy', Date);
  stbStatus.Panels[0].Text := FormatDateTime('hh:mm:ss', fTime());
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  If not blnLogado then
    Exit;

  Self.Caption := 'AutTin' + '   -   Versão: ' + fRetornaVersao + ' - ' + VS_strCodEmp + ' - ' + fRetNomeEmpresa;
  stbStatus.Panels[3].Text := strLoginUsuarioLogado + ' - ' + strDescriUsuarioLogado;

  pAcertaCfgUsaForTintas;

  //Coloquei essa instrução a pedido do Ronaldo pq essa tinta nao será
  //mais utilizada.
  fArqIniTinta(1, 'Coral Industrial', 'USATIN', 'N');
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Escape Then
    btnSair.Click
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
  Var
    strSenha : String;

    PersistentClass: TPersistentClass;
    Form: TForm;
    recModulos: TRecModulosAutcom;
    dicParametros: TDicionario;
    stl: TStringList;

  function fGetRevisionSVN: String;
  {$I rev.inc}
  Begin
    Result := SVN_REVISION;
  End;

begin
  untFuncoesSimples.VS_objTraceViewer := TTraceViewer.Create;

  lstMenu := TList.Create;

  objTestabilidade := TTestabilidade.fGetTestabilidade;
  pIniciaLogLeak(DebugHook, 'Auttin');

  FormatSettings.ThousandSeparator := #0;

  SystemParametersInfo(SPI_SETBEEP, 0, Nil, 0);

  Self.Caption := 'AutTin';

  If ParamCount > 0 Then
  Begin
    If ParamStr(1) = 'GETREVISION' Then
    Begin
      TFinalizarAutcomMonitor.Monitorar;

      Self.Hide;
      stl := TStringList.Create;

      stl.Add('Rev: ' + fGetRevisionSVN);
      stl.SaveToFile(ExtractFilePath(Application.ExeName) + '\AutTinRev.txt');

      FreeAndNil(stl);

      Application.Terminate;
      Exit;
    End;

    strLoginUsuarioLogado := ParamStr(2);
    If ParamStr(1) = 'nfm' Then
      VS_strCodEmp          := ParamStr(3)
    Else
      VS_strCodEmp          := ParamStr(4);

    If ParamStr(1) = '1' Then
      mnuConfiguracoes.Visible := False;
  End
  Else
    strLoginUsuarioLogado  := LOG_ADM;

  utcRegistros := TUltConsultas.Create;

  pCriarModulo(TfrmModulo, TDataModule(frmModulo));
  pCriarModulo(TfrmModuloSPR, TDataModule(frmModuloSPR));
  pCriarModulo(TfrmModuloCons, TDataModule(frmModuloCons));

  pCarregaNre;
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

  pCriarModulo(TfrmModuloTinta, TDataModule(frmModuloTinta));

  //pAtualizaVersao(AUTTIN);

  recModulos.Banco := frmModulo.GetCurrentConnection;
  dicParametros := TDicionario.Create;

  pCarregaVsTemFil;

  strDescriUsuarioLogado := fRetNomeOperador(strLoginUsuarioLogado);

  blnLogado := True;
  blnLogouComSenha := False;

  If ParamCount = 0 Then
  Begin
    strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(LOG_ADM);
    If ffrmSenhaEmpresa(strSenha, VS_strCodEmp, 'AutTin - Senha Gerencial') Then
    Begin
      If (strSenha <> SEN_AUTTIN) Then
      Begin
        TFinalizarAutcomMonitor.Monitorar;
        blnLogado := False;
        fMensagem('', 'Senha Incorreta!', ['&Ok']);
        Application.Terminate;
        Exit;
      End
      Else
      Begin
        strLoginUsuarioLogado  := LOG_ADM;
        blnLogouComSenha := True;
      End;
    End
    Else
    Begin
      TFinalizarAutcomMonitor.Monitorar;
      blnLogado := False;
      Application.Terminate;
      Exit;
    End;
  End;

  If (blnLogouComSenha) Then
    DefinirTimeZoneEmSessaoMySql(frmModulo.GetCurrentConnection, VS_strCodEmp);

  dicParametros['codemp'] := VS_strCodEmp;
  dicParametros['usuariologado'] := strLoginUsuarioLogado;
  pSetaParametros(dicParametros, Nil, Nil, recModulos, Nil, Nil, DebugHook, Nil, VS_objTraceViewer, TExecutaSQLReplicacaoTinta.Create, Nil, nil, nil, fConsulta, True);

  pcarregaNre;
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, strLoginUsuarioLogado, VS_strCodEmp, DebugHook, TCfgSis.Create(), VS_objTraceViewer,
                    VS_Date, VS_ComputerNetName, VS_UserFromWindows, VS_IPAddressAsString, VS_MacAddress);

  pAtuVarGlobaisSimples;

  iTintas := fGetTintasdeMaquina;

  ProcessarMenuTintasDlls();
  fAdicionarMenu(trvMenu, mnuTintasMaquina);

  pVerificaProCod;

  pProcessaMenu;

  {**************************************}
  {* PEGA O LOGIN DO USUÁRIO E VERIFICA *}
  {* SE É PARA EXPORTAR O TXT           *}
  {***********************************AF*}
  If (ParamCount > 2) And (not MatchStr(ParamStr(1), ['exec', 'nfm'])) Then
  Begin
    If ParamStr(3) = '1' Then
    Begin
      TFinalizarAutcomMonitor.Monitorar;
      trvMenu.SaveToFile(ExtractFilePath(Application.ExeName) + '\MenuAutTin.txt');
      Application.Terminate;
    End;

    strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(LOG_ADM);
  End

  {***************************************************}
  {* EXECUTA UM FORM E FECHA O PROGRAMA. PARA EXECU- *}
  {* TAR O FORM, TEM QUE USAR O REGISTERCLASS E      *}
  {* UNREGISTERCLASS.                                *}
  {** 07/07/2008 - 08:37 **************************MV*}
  Else If (ParamCount > 1) Then
  Begin
    If ParamStr(1) = 'exec' Then
    Begin
      PersistentClass := GetClass(ParamStr(5));

      If (Assigned(PersistentClass)) Then
      Begin
        Form := TFormClass(PersistentClass).Create(Application);
        Form.ShowModal;
      End;

      TFinalizarAutcomMonitor.Monitorar;
      Application.Terminate;
    End Else If ParamStr(1) = 'nfm' Then
    Begin
      If (Not Assigned(TGerenciadorMenuAuttinDlls.Get(ParamStr(4)))) Then
      Begin
        pMensagemSonora('A Dll da Tinta específica não foi encontrada.  ' + #13#10 +
                        'Favor entrar em contato com a CITEL.' + #13#10 +
                        'Obrigado.');
      End
      Else
        TGerenciadorMenuAuttinDlls.Get(ParamStr(4)).Executar(TAuttinWrapper.Create);

      TFinalizarAutcomMonitor.Monitorar;
      Application.Terminate;
    End;
  End;

  If (blnLogado) Then
  Begin
    Try
      //Registra LOGACE do Auttin.Exe
      TLogAut.New().pLogin();
    Except
      //
    End;
  End;

  tmrDataSistema.Enabled := True;
  pVerificaTrv;
  pGeraVetor;
  fAjustaDataSistema;

  FreeAndNil(dicParametros);

  TLogForm.strCodEmp := VS_strCodEmp;
  TLogForm.strCodOpe := strLoginUsuarioLogado;
  TLogForm.dtaDtaLog := VS_Date;
  TLogForm.fncCriaQuery := fCriaQuery;
  TLogForm.fncTime := fTime;
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (fMensagem('', 'Deseja sair do AutTin?', ['&Sim', '&Não']) = 2) Then
  Begin
    Action := caNone;
  End
  Else
  Begin
    pFinalizaLibrarys;

    TLogAut.New().pLogout();

    pFecharBanco(frmModulo.GetCurrentConnection);
    pDestroiModulo(frmModulo);

    FreeAndNil(objTestabilidade);
  End;
end;

procedure TfrmPrincipal.pVerificaMenu(Item: TMenuItem);
  Var
    intContador, intLetra: Integer;
    blnTemDireito, blnBarrinha: Boolean;
Begin
  intLetra    := 65;

  blnBarrinha := False;

  {**********************************}
  {* FOR NO MENU INTEIRO            *}
  {*******************************AF*}
  For intContador := 0 To Item.Count-1 Do
  Begin
    If Item[intContador].Caption <> '-' Then
    Begin
      blnTemDireito := fVerificaAcessoAutTin(Item[intContador].Hint);

      If blnTemDireito Then
        blnTemDireito := fTintaDisponivel(Item[intContador].Hint);

      {******************************}
      {* SE A TAG FOR = 0 ENTAO VAI *}
      {* COLOCAR A LETRA            *}
      {***************************AF*}
      If blnTemDireito Then
      Begin
        If Item[intContador].Tag = 0 Then
        Begin
          Item[intContador].Caption := '&' + Char(intLetra) + ' - ' + Item[intContador].Caption;
          Inc(intLetra);

          {*****************************}
          {* MANDA APARECER A BARRINHA *}
          {**************************AF*}
          If (mnuBarrinha <> Nil) Then
          Begin
            mnuBarrinha.Visible := True;
            mnuBarrinha := Nil;
          End;
          blnBarrinha := True;
        End;
      End
      Else
      Begin
        Item[intContador].Visible := False;
        {********************************}
        {* MANDA DESAPARECER A BARRINHA *}
        {*****************************AF*}
        If mnuBarrinha <> Nil Then
        Begin
          mnuBarrinha.Visible := False;
        End;
      End;

      {**********************************}
      {* VERIFICA SE EXISTE UM SUBMENU  *}
      {*******************************AF*}
      If Item[intContador].Count > 0 Then
      Begin
        If blnTemDireito Then
          pVerificaMenu(Item[intContador]);
      End;

    End
    Else
    Begin

      If blnBarrinha Then
      Begin
        If mnuBarrinha = Nil Then
        Begin
          Item[intContador].Visible := True;
          blnBarrinha := False;
          mnuBarrinha := Item[intContador];
        End
        Else
        Begin
          mnuBarrinha := Item[intContador];
        End;
      End
      Else
      Begin
        Item[intContador].Visible := False;
      End;

    End;
  End;
End;

{**********************************}
{* PROCESSA O MENU PARA VERIFI-   *}
{* CAÇÃO DE ACESSOS               *}
{*******************************AF*}
procedure TfrmPrincipal.pProcessaMenu;
  Var
    intContador: Integer;
    blnTemDireito: Boolean;
Begin

  mnuBarrinha := Nil;

  For intContador := 0 To mnuAutCai.Items.Count -1 Do
  Begin
    blnTemDireito := fVerificaAcessoAutTin(mnuAutCai.Items[intContador].Hint);

    If blnTemDireito Then
    Begin
      pVerificaMenu(mnuAutCai.Items[intContador]);
    End
    Else
    Begin
      mnuAutCai.Items[intContador].Visible := False;
    End;
  End;

End;

procedure TfrmPrincipal.ProcessarMenuTintasDlls;
var
  libTintaFactory: ILibTintaFactory;
  stlIdentificadores: TStringList;
  libTinta  : ILibTinta;
  intCont   : Integer;

  stlDllsDuplicadas: TStringList;

  procedure ProcessarSubMenus(menu: IAuttinMenuItem; subMenu: TMenuItem; strNomeTinta : String; strIdepro : String);
  var
    intCont      : Integer;
    novo         : TMenuItem;
    strVersao    : String;
  begin
    if not Assigned(menu) then
      Exit;

    novo := TMenuItem.Create(Self);

    strVersao := fRetVersaoTintometrico(strIdePro);

    If (Pos(strNomeTinta, menu.Caption) > 0)
     And (Not fEmptyStr(strVersao)) Then
    Begin
      novo.Caption := menu.Caption + ' - '+ strVersao;
    End
    else
    begin
      novo.Caption := menu.Caption
    end;

    novo.Name := 'mnu' + GetValidComponentName(Copy(menu.Hint, 4, Length(menu.Hint)));
    novo.Hint := menu.Hint;
    novo.Visible := True;
    novo.OnClick := mnuGenericDllTintaMenuClick;
    subMenu.Add(novo);
    TGerenciadorMenuAuttinDlls.Registrar(novo.Name, menu);

    for intCont := 0 to menu.Cont - 1 do
      ProcessarSubMenus(menu[intCont], novo, strNomeTinta, strIdepro);
  end;

begin
  stlIdentificadores := nil;
  Try
    Try
      stlIdentificadores := TStringList.Create;
      libTintaFactory := GetLibTintaFactory;
      libTintaFactory.GetIdentificadores(stlIdentificadores);

      stlDllsDuplicadas := TStringList.Create;

      for intCont := 0 to stlIdentificadores.Count - 1 do
      begin
        if stlDllsDuplicadas.IndexOf(stlIdentificadores[intCont]) < 0 then
        Begin
        libTinta := libTintaFactory.GetITintadeMaquina(stlIdentificadores[intCont]);

        ProcessarSubMenus(libTinta.Menu, mnuTintasMaquina, libTinta.GetNomeTinta, stlIdentificadores[intCont]);
          stlDllsDuplicadas.Add(stlIdentificadores[intCont]);
        End
        Else
          fMensagem('Atenção', 'A tinta de máquina [' + stlIdentificadores[intCont] + '] está com a sua dll duplicada' + #13#10 +
                               'no diretório autcom\auttin\tintas. ' + #13#10 +
                               'Favor entrar em contato com a citel.' + #13#10 +
                               'Obrigado.', ['&Ok'] );
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlIdentificadores) then FreeAndNil(stlIdentificadores);
    if Assigned(stlDllsDuplicadas) then FreeAndNil(stlDllsDuplicadas);
  End;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TfrmPrincipal.fRetornaOHintDeTodasAsTintas: String;
begin
  Result := 'frmCadMixGeraArquivo_frmCadBziGeraArquivo_';
  Result := Result + 'frmCadCorImoGeraArquivo_frmCadLksGeraArquivo_frmCadStaGeraArquivo_';
  Result := Result + 'frmCadDacGeraArquivo_frmCadWanProGeraArquivo_frmCadReiGeraArquivo_frmCadSHEGeraArquivo_';
  Result := Result + 'frmCadFUTGeraArquivo_frmCadKilGeraArquivo_frmCadSalGeraArquivo_frmCadGlaGeraArquivo_';
  Result := Result + 'frmCadDupGeraArquivo_frmCadRsiGeraArquivo_frmCadSkyGeraArquivos_frmCadFarGeraArquivo_';
  Result := Result + 'frmCadAnjoGeraArquivo_frmGeraArqAdvance_frmCadUniGeraArquivos_frmCadWegGeraArquivo_';
  Result := Result + 'frmGeraArqAdvanceTintoSystem_frmCadNexaGeraArquivo_frmAlessiGravando_';
  Result := Result + 'frmVelutexGravando_frmBrazilianColorGravando_frmHydronorthGravando_frmSayerlackGravando_';
  Result := Result + 'frmCalamarGravando_frmCadIquineGeraArquivo_frmCadLikoGeraArquivo_frmCadRecoaGeraArquivo_';
  Result := Result + 'frmCadGlobalColorGeraArquivo_frmCadAnjoSinteticaGeraArquivo_frmCadRennerIndustrialGeraArquivo_';
  Result := Result + 'frmCadAnnettaGeraArquivo_frmCadStandoxGeraArquivo_frmCadBAUGeraArquivo_';
  Result := Result + 'frmCadSuvGeraArquivo_frmCadQUAGeraArquivo_frmCadMZDGeraArquivo_frmCadMZAGeraArquivo_';
  Result := Result + 'frmCadCIMGeraArquivo_frmCadCIAGeraArquivo_frmCadANJGeraArquivo_';
  Result := Result + 'frmCadAleGeraArquivo_frmCadStaWebGeraArquivo_';
end;

function TfrmPrincipal.fRetVersaoTintometrico(strIdepro: String): String;
Var
  qryAux : TUniQuery;
begin
  Try
    qryAux := fCriaQuery;

    qryAux.Close;
    qryAux.SQL.Text := ' SELECT TRIM(CFG_VALCFG) VALCFG '+
                       '   FROM CFGTIN '+
                       '  WHERE CFG_CODCFG = "VERSAO" '+
                       '    AND CFG_CODEMP = :CODEMP  '+
                       '    AND CFG_IDEPRO = :IDEPRO  ';
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('IDEPRO').AsString := strIdepro;
    qryAux.Open;

    Result := qryAux.FieldByName('VALCFG').AsString;
  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmPrincipal.fTintaDisponivel(strTinta: String): Boolean;
  Var
    intContador: Integer;
begin

  Result := False;

  If (Copy(strTinta, 1, 3) = 'frm') Then
  Begin
    Result := True;
    Exit;
  End;

  strTinta := Copy(strTinta, 4, Length(strTinta));

  For intContador := 0 To iTintas.fGetQtdTintas -1 Do
  Begin
    If (iTintas.fEstaDisponivel(intContador))
      And (AnsiLowerCase(iTintas.fGetNomeTinta(intContador)) = AnsiLowerCase(strTinta)) Then
    Begin
      Result := True;
      Break;
    End;
  End;

end;

procedure TfrmPrincipal.mnuConfiguracoesClick(Sender: TObject);
begin
  pCriarForm(TfrmConfiguracoes, frmConfiguracoes);
end;

{**********************************************}
{* MONTA MENU NOVAMENTE COM OS NOMES CORRETOS *}
{* E GERA O VETOR COM OS NOMES DOS FORMS E OS *}
{* INDICES                                    *}
{*******************************************AF*}
procedure TfrmPrincipal.pGeraVetor;
  Var
    intContador: Integer;
    strValor: String;
Begin
  {**************}
  {* ZERA VETOR *}
  {***********AF*}
  SetLength(arrMenu,0);

  trvMenu.AlphaSort(True);

  For intContador := 0 To trvMenu.Items.Count -1 Do
  Begin
    strValor := Trim(RightStr(trvMenu.Items[intContador].Text, Length(trvMenu.Items[intContador].Text) - Pos('>', trvMenu.Items[intContador].Text)));
    trvMenu.Items[intContador].Text := LeftStr(trvMenu.Items[intContador].Text, Pos('>', trvMenu.Items[intContador].Text)-1);

    SetLength(arrMenu,Length(arrMenu)+1);

    arrMenu[intContador].strNomform := strValor;

  End;

End;

procedure TfrmPrincipal.trvMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
  Begin
    trvMenuDblClick(Sender);
  End;
end;

{********************************}
{* DELETA DO TREEVIEW AS TINTAS *}
{*****************************AF*}
procedure TfrmPrincipal.pVerificaTrv;
Var
    intContador: Integer;
    strValor: String;
Begin

  intContador := 0;

  While intContador <> trvMenu.Items.Count Do
  Begin
    strValor := Trim(RightStr(trvMenu.Items[intContador].Text, Length(trvMenu.Items[intContador].Text) - Pos('>', trvMenu.Items[intContador].Text)));

    If (Not fTintaDisponivel(strValor)) Or (Not fVerificaAcessoAutTin(strValor)) Or (Not fMenuPodeFicarVisivel(strValor)) Then
    Begin
      trvMenu.Items[intContador].Delete;
      intContador := -1;
    End;

    Inc(intContador);
  End;

end;

procedure TfrmPrincipal.trvMenuDblClick(Sender: TObject);
begin

  If Length(arrMenu) <> 0 Then
  Begin
    pSelecionaMenu(arrMenu[trvMenu.Selected.AbsoluteIndex].strNomForm);
  End;

end;

{*****************************}
{* VERIFICA SE TEM PERMISSÃO *}
{**************************AF*}
function TfrmPrincipal.fVerificaAcessoAutTin(strNomeForm: String): Boolean;
  Var
    strSQL: String;
Begin

  If strLoginUsuarioLogado <> '999' Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DIRTIN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TIN_CODOPE = :CODOPE AND ';
    strSQL := strSQL + '  TIN_NOMFRM = :NOMFRM ';

    With frmModuloTinta.qryGen001 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      ParamByName('NOMFRM').AsString := strNomeForm;
      Open;

      If Not IsEmpty Then
        Result := True
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   D.DIR_NOMFRM  ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   DIRGPT D ';
        strSQL := strSQL + '   JOIN CADGPO G ON G.GPO_CODGPO = D.GPT_CODGPO ';
        strSQL := strSQL + '   JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE AND   ';
        strSQL := strSQL + '   D.DIR_NOMFRM = :NOMFRM       ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        ParamByName('NOMFRM').AsString := strNomeForm;
        Open;

        If Not IsEmpty Then
          Result := True
        Else
          Result := False;
      End;

      Close;
    End;
  End
  Else
  Begin
    Result := True;
  End;
End;


//***************************************//
// VERIFICA SE A EMPRESA POSSUI FILIAL  *//
//************************************RL*//

procedure TfrmPrincipal.pCarregaVsTemFil;
  Var
    qryTmpEmp: TUniQuery;
    strSQL   : String;
begin
  qryTmpEmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';

  With qryTmpEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    If FieldByName('QTD').AsInteger > 1 Then
    Begin
      VS_blnTemFil := True
    End
    Else
    Begin
      VS_blnTemFil := False;
    End;

    Close;
  End;

  FreeAndNil(qryTmpEmp);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
var
  intCont: Integer;
begin
  for intCont := 0 to lstMenu.Count - 1 do
  begin
    TTreeNode(lstMenu.Items[intCont]).Free;
    lstMenu.Delete(intCont);
  end;
    
  if Assigned(lstMenu) then FreeAndNil(lstMenu);
end;

procedure TfrmPrincipal.tmrDataSistemaTimer(Sender: TObject);
begin
  If fEmptyStr(VS_strCodEmp) Then
    Exit;
  fAjustaDataSistema;
end;



procedure TfrmPrincipal.pSelecionaMenu(strNome: String);  
Var    
	componemte: TComponent;
begin  
	componemte := FindComponent('mnu' + Copy(strNome, 4, Length(strNome)));
  If (componemte <> nil) and (componemte is TMenuItem) Then
    TMenuItem(componemte).Click;
end;



procedure TfrmPrincipal.pCadastrarNovasFormulas(
  tintaClasse: TTintadeMaquinaClasse);
begin
  Try
    Try
      frmPaiGeraArq := TfrmPaiGeraArq.Create(Self, tintaClasse);
      frmPaiGeraArq.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    If Assigned(frmPaiGeraArq) Then FreeAndNil(frmPaiGeraArq);
  End;
end;


procedure TfrmPrincipal.ConfigurarTinta(tela: TFormClass);
var
  frmConf: TForm;
  strNomeLock: string;
begin
  frmConf := nil;
  strNomeLock := 'CFGTIN.' + tela.ClassName;
  strNomeLock := GetMD5(strNomeLock);

  If (Not fLock_Unlock(strNomeLock, True, False)) Then
  Begin
    fMensagem('', Format('A estação [%s] está usando a configuração da tinta', [fGetHostLock(strNomeLock)]), ['&Ok']);
    Exit;
  End;

  Try
    Try
      frmConf := tela.Create(Self);
      frmConf.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmConf) then FreeAndNil(frmConf);
    fLock_Unlock(strNomeLock, False, False);
  End;
end;

destructor TfrmPrincipal.Destroy;
begin
  iTintas := nil;
  If Assigned(utcRegistros) Then FreeAndNil(utcRegistros);
  inherited;
end;

function TfrmPrincipal.fAcessoGeracaoTintas: Boolean;
Var
  intContador: Integer;
Const
  arrOperador:Array[1..3] Of String = ('997', '998', '999');
begin
  Result := False;

  For intContador := 1 To 3 Do
  Begin
    If strLoginUsuarioLogado = arrOperador[intContador] Then
      Result := True;
  End;
end;

function TfrmPrincipal.fAdicionarMenu(arvore: TTreeView;
  menuItem: TMenuItem; arvoreItem: TTreeNode): TTreeNode;
  Var
    intCont: Integer;
    strGeracaoNova:String;
    strGeracaoAntiga:String;

  function CorrigeNome(strTexto: String): String;
  Begin
    If (LeftStr(strTexto, 1) = '&') Then
      Result := Copy(strTexto, 6, Length(strTexto))
    Else
      Result := strTexto;

    Result := Result;
  End;


begin
  Result := nil;

  strGeracaoNova := 'Gerar Cadastro de Tintas';
  strGeracaoAntiga := 'Geração de Arquivos';
  
  If (menuItem = nil) or (fEmptyStr(menuItem.Caption)) Then
  Begin
    Result := nil;
    Exit;
  End;

  If (menuItem.Caption = strGeracaoNova) Or (menuItem.Caption = strGeracaoAntiga) Then
  Begin
    If Not fAcessoGeracaoTintas Then
    Begin
      Result := Nil;
      Exit;
    End;
  End;

  If (arvoreItem = nil) Then
  begin
    arvoreItem := TTreeNode.Create(arvore.Items);
    lstMenu.Add(arvoreItem);
  end
  Else If menuItem.Visible Then
    arvoreItem := arvore.Items.AddChild(arvoreItem, CorrigeNome(menuItem.Caption) + ' > ' + menuItem.Hint);

  For intCont := 0 To menuItem.Count - 1 Do
  Begin
    Result := fAdicionarMenu(arvore, menuItem.Items[intCont], arvoreItem);
  End;
end;

function TfrmPrincipal.fMenuPodeFicarVisivel(strHint: String): Boolean;
begin
  Result := blnLogouComSenha Or ((Not blnLogouComSenha) And (Pos(strHint, fRetornaOHintDeTodasAsTintas) <= 0));
end;


procedure TfrmPrincipal.mnuConfiguracoesGlasuritClick(Sender: TObject);
begin
  ConfigurarTinta(TfrmConfiguracoesGlasurit);
end;

procedure TfrmPrincipal.mnuConfiguracoesSalcomixClick(Sender: TObject);
begin
  ConfigurarTinta(TfrmConfiguracoesSalcomix);
end;

procedure TfrmPrincipal.mnuCadGlaBasesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGlaBases, frmCadGlaBases);
end;

procedure TfrmPrincipal.mnuCadGlaNovasFormulasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGlaNovasFormulas, frmCadGlaNovasFormulas);
end;

procedure TfrmPrincipal.mnuCadSalBasesClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSalBases, frmCadSalBases);
end;

procedure TfrmPrincipal.mnuCadSalGeraArquivoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSalGeraArquivo, frmCadSalGeraArquivo);
end;

procedure TfrmPrincipal.mnuCadSalGerNfmClick(Sender: TObject);
begin
  pCadastrarNovasFormulas(TSalcomixDinamica);
end;

procedure TfrmPrincipal.mnuCadSalNovasFormulasClick(Sender: TObject);
begin
  pCriarForm(TfrmCadSalNovasFormulas, frmCadSalNovasFormulas);
end;

procedure TfrmPrincipal.mnuCadGlaGeraArquivoClick(Sender: TObject);
begin
  pCriarForm(TfrmCadGlaGeraArquivo, frmCadGlaGeraArquivo);
end;

procedure TfrmPrincipal.mnuConsultaGlasuritClick(Sender: TObject);
begin
  fConsultaGlasuritGeralDinamica(Self);
end;

procedure TfrmPrincipal.mnuConsultaSalcomixClick(Sender: TObject);
begin
  fConsultaSalcomixGeralDinamica(Self);
end;

procedure TfrmPrincipal.mnuCadGlaGerNfmClick(Sender: TObject);
begin
  pCadastrarNovasFormulas(TGlasuritDinamica);
end;


procedure TfrmPrincipal.mnuGenericDllTintaMenuClick(Sender: TObject);
begin
  TGerenciadorMenuAuttinDlls.Get(TMenuItem(Sender).Name).Executar(TAuttinWrapper.Create);
end;


procedure TfrmPrincipal.pAcertaCfgUsaForTintas;
begin
  Try
    Try
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;

end;

initialization
//  dxInitializeFuncoes;
finalization
//  dxFinalizeFuncoes;

end.
