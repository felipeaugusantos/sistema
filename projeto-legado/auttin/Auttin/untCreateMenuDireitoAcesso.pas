unit untCreateMenuDireitoAcesso;

interface

uses
  untFuncoesSimples, System.Classes, Windows, SysUtils, Variants,
  Menus, untIAuttinMenuItem, untILibTinta, ComCtrls, Forms, StrUtils,
  untGerenciadorMenuAuttinDlls, untFuncTinta, untILibTintaFactory, Uni,
  ExtCtrls, Controls, Graphics, Buttons, Dialogs, StdCtrls, MidasLib, MadExcept,
  untITintasDeMaquina;

Type
  TMenuDireitoAceAutTin = Class(TInterfacedObject)
  Private
    mnuTintasMaquina: TMenuItem;
    mnuGlasurit: TMenuItem;
    mnuSalcomix: TMenuItem;
    mnuConf: TMenuItem;
    SubItem: TMenuItem;
    lstMenu: TList;
    iTintas: ITintasDeMaquina;
    function fRetVersaoTintometrico(strIdePro: String): String;
    function fTintaDisponivel(strTinta: String): Boolean;
    procedure mnuGenericDllTintaMenuClick(Sender: TObject);
    Public
    Procedure ProcessarMenuTintasDll(trvMenu: TTreeView); Stdcall;
    Procedure ProcessarMenuConfiguracao(Menu: TMenuItem); Stdcall;
    Procedure ProcessarMenuGlasurit(Menu: TMenuItem); Stdcall;
    Procedure ProcessarMenuSalcomix(Menu: TMenuItem); StdCall;
    Procedure CriarSubMenuGenerico(Menu: TMenuItem; ACaption: String; AName: String; AHint: String; AVisible: Boolean);
    Procedure ProcessarSubMenus(Menu: IAuttinMenuItem; subMenu: TMenuItem; strNomeTinta: String; strIdePro: String); Stdcall;
    function fValidaMenuNil(Menu: TMenuItem; ACaption: String): Boolean; Stdcall;
    function fValidaGeracaoTintas(ACaption: String; AGeracaoNova: String; AGeracaoAntiga: String): Boolean; Stdcall;
    function CorrigeNome(strTexto: String): String; Stdcall;
    function fAdicionarMenu(arvore: TTreeView; menuItem: TMenuItem; arvoreItem: TTreeNode = nil): TTreeNode; Stdcall;
    constructor Create();
    destructor Destroy(); override;

End;

implementation

{ TMenuDireitoAceAutTin }

function TMenuDireitoAceAutTin.CorrigeNome(strTexto: String): String;
begin
  If (LeftStr(strTexto, 1) = '&') Then
    Result := Copy(strTexto, 6, Length(strTexto))
  Else
    Result := strTexto;

  Result := Result;
end;

constructor TMenuDireitoAceAutTin.Create;
begin
  inherited Create();
end;

procedure TMenuDireitoAceAutTin.CriarSubMenuGenerico(Menu: TMenuItem; ACaption,
  AName, AHint: String; AVisible: Boolean);
begin
  SubItem := TMenuItem.Create(Nil);
  SubItem.Name := AName;
  SubItem.Hint := AHint;
  SubItem.Caption := ACaption;
  SubItem.Visible := AVisible;
  Menu.Add(SubItem);
end;

destructor TMenuDireitoAceAutTin.Destroy;
var
  intCont: Integer;
begin
  For intCont := 0 To lstMenu.Count - 1 Do
  Begin
    TTreeNode(lstMenu.Items[intCont]).Free;
    lstMenu.Delete(intCont);
  End;

  If Assigned(SubItem) Then
    FreeAndNil(SubItem);

  If Assigned(mnuConf) Then
    FreeAndNil(mnuConf);

  If Assigned(mnuGlasurit) Then
    FreeAndNil(mnuGlasurit);

  If Assigned(mnuSalcomix) Then
    FreeAndNil(mnuSalcomix);

  If Assigned(mnuTintasMaquina) Then
    FreeAndNil(mnuTintasMaquina);

  If Assigned(lstMenu) Then
    FreeAndNil(lstMenu);

  iTintas := Nil;
end;

function TMenuDireitoAceAutTin.fAdicionarMenu(arvore: TTreeView;
  menuItem: TMenuItem; arvoreItem: TTreeNode): TTreeNode;
Var
  intCont: Integer;
  strGeracaoNova:String;
  strGeracaoAntiga:String;
begin
  Result := nil;
  Try
    strGeracaoNova := 'Gerar Cadastro de Tintas';
    strGeracaoAntiga := 'Geração de Arquivos';

    If Not fValidaMenuNil(menuItem, menuItem.Caption) Then
    Begin
      Result := Nil;
      Exit;
    End;

    If Not fValidaGeracaoTintas(menuItem.Caption, strGeracaoNova, strGeracaoAntiga) Then
    Begin
      Result := Nil;
      Exit;
    End;

    If arvoreItem = Nil Then
    Begin
      arvoreItem := TTreeNode.Create(arvore.Items);
      lstMenu.Add(arvoreItem);
    End
    Else If (menuItem.Visible) Then
    Begin
      arvoreItem := arvore.Items.AddChild(arvoreItem, CorrigeNome(menuItem.Caption) + ' > ' + menuItem.Hint);
    End;

    For intCont := 0 To menuItem.Count - 1 Do
      Result := fAdicionarMenu(arvore, menuItem.Items[intCont], arvoreItem);

    arvore.SaveToFile(ExtractFilePath(Application.ExeName) + '\Auttin\MenuAutTin.txt');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fAdicionarMenu]');
    End;
  End;
end;

function TMenuDireitoAceAutTin.fRetVersaoTintometrico(
  strIdePro: String): String;
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

function TMenuDireitoAceAutTin.fTintaDisponivel(strTinta: String): Boolean;
Var
  intContador: Integer;
begin
  Result := False;

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

function TMenuDireitoAceAutTin.fValidaGeracaoTintas(ACaption, AGeracaoNova,
  AGeracaoAntiga: String): Boolean;
begin
  Result := True;

  If ACaption = AGeracaoNova Then
  Begin
    If Not fEhAdministrador(strLoginUsuarioLogado) Then
      Exit(False);
  End;

  If ACaption = AGeracaoAntiga Then
  Begin
    If Not fEhAdministrador(strLoginUsuarioLogado) Then
      Exit(False);
  End;
end;

function TMenuDireitoAceAutTin.fValidaMenuNil(Menu: TMenuItem;
  ACaption: String): Boolean;
begin
  Result := True;

  If Menu = Nil Then
    Exit(False);

  If fEmptyStr(ACaption) Then
    Exit(False);
end;

procedure TMenuDireitoAceAutTin.mnuGenericDllTintaMenuClick(Sender: TObject);
begin
  //
end;

procedure TMenuDireitoAceAutTin.ProcessarMenuConfiguracao(Menu: TMenuItem);
begin
  mnuConf := TMenuItem.Create(Nil);
  mnuConf.Name := 'mnuConfGerais';
  mnuConf.Hint := 'frmConfGerais';
  mnuConf.Caption := 'Configurações Gerais';
  mnuConf.Visible := True;
  Menu.Add(mnuConf);

  CriarSubMenuGenerico(mnuConf, 'Configurações', 'mnuConfTintaMaquina', 'frmConfTintaMaquina', True); //Processa o Menu de Configurações
end;

procedure TMenuDireitoAceAutTin.ProcessarMenuGlasurit(Menu: TMenuItem);
begin
  If fTintaDisponivel('Glasurit') Then
  Begin
    mnuGlasurit := TMenuItem.Create(Nil);
    mnuGlasurit.Name := 'mnuGlasurit';
    mnuGlasurit.Hint := 'mnuGlasurit';
    mnuGlasurit.Caption := 'Glasurit';
    mnuGlasurit.Visible := True;
    Menu.Add(mnuGlasurit);

    CriarSubMenuGenerico(mnuGlasurit, 'Configurações', 'mnuConfiguracoesGlasurit', 'frmConfiguracoesGlasurit', True);
    CriarSubMenuGenerico(mnuGlasurit, 'Cadastro de Bases', 'mnuCadGlabases', 'frmCadGlaBases', True);
    CriarSubMenuGenerico(mnuGlasurit, 'Cadastro de Novas Fórmulas', 'mnuCadGlaNovasFormulas', 'frmCadGlaNovasFormulas', True);
    CriarSubMenuGenerico(mnuGlasurit, 'Gerar Cadastro de Tintas', 'mnuCadGlaGeraArquivo', 'frmCadGlaGeraArquivo', True);
    CriarSubMenuGenerico(mnuGlasurit, 'Consultar Arquivo', 'mnuConsultaGlasurit', 'frmConsultaGlasurit', True);
    CriarSubMenuGenerico(mnuGlasurit, 'Gerar Cadastro de Novas Fórmulas', 'mnuCadGlaGerNfm', 'frmCadGlaGerNfm', True);
  End;
end;

procedure TMenuDireitoAceAutTin.ProcessarMenuSalcomix(Menu: TMenuItem);
begin
  If fTintaDisponivel('Salcomix') Then
  Begin
    mnuSalcomix := TMenuItem.Create(Nil);
    mnuSalcomix.Name := 'mnuSalcomix';
    mnuSalcomix.Hint := 'mnuSalcomix';
    mnuSalcomix.Caption := 'Salcomix';
    mnuSalcomix.Visible := True;
    Menu.Add(mnuSalcomix);

    CriarSubMenuGenerico(mnuSalcomix, 'Configurações', 'mnuConfiguracoesSalcomix', 'frmConfiguracoesSalcomix', True);
    CriarSubMenuGenerico(mnuSalcomix, 'Cadastro de Bases', 'mnuCadSalbases', 'frmCadSalBases', True);
    CriarSubMenuGenerico(mnuSalcomix, 'Cadastro de Novas Fórmulas', 'mnuCadSalNovasFormulas', 'frmCadSalNovasFormulas', True);
    CriarSubMenuGenerico(mnuSalcomix, 'Gerar Cadastro de Tintas', 'mnuCadSalGeraArquivo', 'frmCadSalGeraArquivo', True);
    CriarSubMenuGenerico(mnuSalcomix, 'Consultar Arquivo', 'mnuConsultaSalcomix', 'frmConsultaSalcomix', True);
    CriarSubMenuGenerico(mnuSalcomix, 'Gerar Cadastro de Novas Fórmulas', 'mnuCadSalGerNfm', 'frmCadSalGerNfm', True);
  End;
end;

procedure TMenuDireitoAceAutTin.ProcessarMenuTintasDll(trvMenu: TTreeView);
var
  libTintaFactory: ILibTintaFactory;
  stlIdentificadores: TStringList;
  stlDllsDuplicadas: TStringList;
  libTinta  : ILibTinta;
  intCont   : Integer;
begin
  lstMenu := TList.Create;
  mnuTintasMaquina := TMenuItem.Create(Nil);
  mnuTintasMaquina.Caption := '&Tintas de Máquina';
  mnuTintasMaquina.Name := 'mnuTintasMaquina';
  mnuTintasMaquina.Hint := 'mnuTintasMaquina';
  mnuTintasMaquina.Visible := False;

  iTintas := fGetTintasdeMaquina;

  ProcessarMenuConfiguracao(mnuTintasMaquina);
  ProcessarMenuGlasurit(mnuTintasMaquina);
  ProcessarMenuSalcomix(mnuTintasMaquina);

  stlIdentificadores := nil;
  Try
    Try
      stlIdentificadores := TStringList.Create;
      stlDllsDuplicadas := TStringList.Create;
      libTintaFactory := GetLibTintaFactory;
      libTintaFactory.GetIdentificadores(stlIdentificadores);

      For intCont := 0 To stlIdentificadores.Count - 1 Do
      Begin
        If stlDllsDuplicadas.IndexOf(stlIdentificadores[intCont]) < 0 Then
        Begin
          libTinta := libTintaFactory.GetITintadeMaquina(stlIdentificadores[intCont]);
          ProcessarSubMenus(libTinta.Menu, mnuTintasMaquina, libTinta.GetNomeTinta, stlIdentificadores[intCont]);
          stlDllsDuplicadas.Add(stlIdentificadores[intCont]);
        End
        Else
        Begin
          fMensagem('Atenção', 'A tinta de máquina [' + stlIdentificadores[intCont] + '] está com a sua dll duplicada' + #13#10 +
                               'no diretório autcom\auttin\tintas. ' + #13#10 +
                               'Favor entrar em contato com a citel.' + #13#10 +
                               'Obrigado.', ['&Ok'] );
        End;
      End;

      fAdicionarMenu(trvMenu, mnuTintasMaquina);
    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    if Assigned(stlIdentificadores) then FreeAndNil(stlIdentificadores);
    if Assigned(stlDllsDuplicadas) then FreeAndNil(stlDllsDuplicadas);
  End;
end;

procedure TMenuDireitoAceAutTin.ProcessarSubMenus(Menu: IAuttinMenuItem;
  subMenu: TMenuItem; strNomeTinta, strIdePro: String);
var
  intCont   : Integer;
  novo      : TMenuItem;
  strVersao : String;
begin
  if not Assigned(menu) then
    Exit;

  novo := TMenuItem.Create(Nil);

  strVersao := fRetVersaoTintometrico(strIdePro);

  If (Pos(strNomeTinta, menu.Caption) > 0) And (Not fEmptyStr(strVersao)) Then
    novo.Caption := menu.Caption + ' - '+ strVersao
  Else
    novo.Caption := menu.Caption;

  novo.Name := 'mnu' + GetValidComponentName(Copy(menu.Hint, 4, Length(menu.Hint)));
  novo.Hint := menu.Hint;
  novo.Visible := True;
  novo.OnClick := mnuGenericDllTintaMenuClick;
  subMenu.Add(novo);
  TGerenciadorMenuAuttinDlls.Registrar(novo.Name, menu);

  For intCont := 0 To menu.Cont - 1 Do
    ProcessarSubMenus(menu[intCont], novo, strNomeTinta, strIdepro);
end;

end.
