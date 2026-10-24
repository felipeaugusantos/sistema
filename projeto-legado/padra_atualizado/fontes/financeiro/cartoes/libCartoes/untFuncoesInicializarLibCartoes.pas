unit untFuncoesInicializarLibCartoes;

interface

  Uses System.Classes, System.IOUtils, Vcl.Forms, System.SysUtils, Vcl.Menus,
       WinApi.Windows, System.Generics.Collections, Vcl.StdCtrls, System.StrUtils,
       Data.DB,System.Variants,

       cxEdit, cxRadioGroup, cxEditRepositoryItems, cxCurrencyEdit, cxTextEdit,
       Uni, UniClientDataset, cxButtonEdit,

       untInterfacesLibCartoesAutcom, untTLibCartoesAutcom, untTypesSistema,
       untLibCartoesTiposCompartilhados, untFuncoesSimples

       {$IF Declared(VS_CFGSISTEMA_VALIDAR_EXISTE)}
       , untCfgSistemaValidar
       {$ENDIF}
       {$IF Declared(VS_TELAS_ABERTAS_EXISTE)}
       ,untTelasAbertas
       {$ENDIF};

Type
  TMenuLibCartoes = class
  private

  public
    class var FMenusImportacaoJaCriados: Boolean;
    class var FMenusConciliacaoJaCriados: Boolean;
    class var FMenusAntecipacaoJaCriados: Boolean;
    class var FMenusImportacaoRecebiveisMktJaCriados: Boolean;
    class var FMenusBaixaRecebiveisMktJaCriados: Boolean;
    class var FMenusExclusaoJaCriados: Boolean;
    class var FMenusExportacaoJaCriados: Boolean;

    class var FMenuShopeeAntigo: Boolean;
    class var FMenuMagazineLuizaAntigo: Boolean;

    class var FOnClickImportacaoShopee: procedure(Sender: TObject) Of Object;

    class var procOnClickConfirmacaoCartoes: procedure; stdcall;

    class procedure CarregaDllLibCartoes;

    class procedure CarregarMenusImportacao(var AMenuCartoes: TMenuItem);
    class procedure CarregarMenusConciliacao(var AMenuCartoes: TMenuItem);
    class procedure CarregarMenusAntecipacao(var AMenuCartoes: TMenuItem);
    class procedure CarregarMenusImportacaoRecebiveisMkt(AMenuImportacaoCartoes: TMenuItem;
                                                         var AMenuFinanceiro: TMenuItem);
    class procedure CarregarMenusBaixaRecebiveisMkt(var AMenuRecebiveis: TMenuItem);
    class procedure CarregarMenusExclusao(var AMenuCartoes: TMenuItem);
    class procedure CarregarMenusExportacao(var AMenuCartoes: TMenuItem);

    class procedure FinalizarObjetos(ALimpar: Boolean = False);
  End;

Type
  TConfiguracoesLibCartoes = class
  private
    class function RetornaTipoItemCfg(ATipoConfiguracao: TTipoConfiguracao): TcxEditRepositoryItemClass;

    class procedure CarregaPropertiesItem(var ANovoItem: TcxEditRepositoryItem;
                                          AItemLibCartoes: TLibCartoesCfgProperties);

    class procedure OnButtonClick(Sender: TObject; AButtonIndex: Integer);

    class procedure OnClickCadEstabelecimentosCartoes(Sender: TObject; AButtonIndex: Integer);
  public
    class procedure CarregaDllLibCartoes;

    class procedure CarregaRepositorioCartoes(var ACfgRepositorio: Pointer);
  end;

var
  LibCartoesHandle: THandle;
  ObjetoLibCartoes: ILibCartoes;
  InicializaObjetoLibCartoes: procedure(AObjetoLibCartoes: ILibCartoes); StdCall;
  AdicionarConfiguracoesCartoes: procedure; StdCall;
  AdicionarConfiguracoesAntecipacaoRedeCard: procedure; StdCall;
  CarregaPropriedadesConfiguracoesCartoes: procedure(ACodigoConfiguracao: String; var AProperties: Pointer; var AIndiceCfg: Integer; ACfgRepositorio: Pointer); StdCall;
  CarregaPropriedadesConfiguracoesAntecipacaoRedeCard: procedure(ACodigoConfiguracao: String; var AProperties: Pointer; var AIndiceCfg: Integer; ACfgRepositorio: Pointer); StdCall;
  RetornaCfgRepositorioCartoes: function: Pointer; StdCall;
  ValidaConfiguracoesCartoes: procedure(var ADatasetCfg: TUniClientDataset; AAdicionarConfigDuranteValidacao: Boolean; var AResultado: Boolean; AFiltroEmpresa: Boolean = True); StdCall;
  OnClickConfirmacaoCartoes: procedure; StdCall;

implementation

Uses untCfgRepositorio
     {$IF Declared(VS_VERSAO_72))}
     ,untCfgSistema
     {$ENDIF};

{ TMenuLibCartoes }

class procedure TMenuLibCartoes.CarregaDllLibCartoes;
  Var
    LCaminho: String;

    dxInitialize: procedure; StdCall;
begin
  If LibCartoesHandle > 0 Then
    Exit;

  LCaminho := ExtractFilePath(Application.ExeName) + 'libCartoes\libCartoesAutcom.dll';

  LibCartoesHandle := 0;
  If Not FileExists(LCaminho) Then
    Exit;

  LibCartoesHandle := LoadLibrary(PChar(LCaminho));

  ObjetoLibCartoes := TILibCartoesAutcom.Create;

  dxInitialize := GetProcAddress(LibCartoesHandle, 'dxInitialize');
  dxInitialize;

  InicializaObjetoLibCartoes := GetProcAddress(LibCartoesHandle, PChar('InicializaObjetoLibCartoes'));
  InicializaObjetoLibCartoes(ObjetoLibCartoes);

  RetornaCfgRepositorioCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaCfgRepositorioCartoes'));

  AdicionarConfiguracoesCartoes := GetProcAddress(LibCartoesHandle, pChar('AdicionarConfiguracoesCartoes'));
  procCfgRepositorioCartoesAdicionar := AdicionarConfiguracoesCartoes;

  AdicionarConfiguracoesAntecipacaoRedeCard := GetProcAddress(LibCartoesHandle, pChar('AdicionarConfiguracoesAntecipacaoRedeCard'));
  procCfgRepositorioAntecipacaoRedeCardAdicionar := AdicionarConfiguracoesAntecipacaoRedeCard;

  CarregaPropriedadesConfiguracoesCartoes := GetProcAddress(LibCartoesHandle, pChar('CarregaPropriedadesConfiguracoesCartoes'));
  procCfgRepositorioCartoesProperty := CarregaPropriedadesConfiguracoesCartoes;

  CarregaPropriedadesConfiguracoesAntecipacaoRedeCard := GetProcAddress(LibCartoesHandle, pChar('CarregaPropriedadesConfiguracoesAntecipacaoRedeCard'));
  procCfgRepositorioAntecipacaoRedeCardProperty := CarregaPropriedadesConfiguracoesAntecipacaoRedeCard;

  ValidaConfiguracoesCartoes := GetProcAddress(LibCartoesHandle, pChar('ValidaConfiguracoesCartoes'));
  procCfgRepositorioCartoesValidar := ValidaConfiguracoesCartoes;

  OnClickConfirmacaoCartoes := GetProcAddress(LibCartoesHandle, pChar('OnClickConfirmacaoCartoes'));
  procOnClickConfirmacaoCartoes := OnClickConfirmacaoCartoes;

  procCfgRepositorioCartoesCreateProperties := TConfiguracoesLibCartoes.CarregaRepositorioCartoes;

  //Procs que a Lib não precise ficar carregada na memória
  If Not Assigned(procLibCartoesInicializarObjetos) Then
  Begin
    procLibCartoesInicializarObjetos := TMenuLibCartoes.CarregaDllLibCartoes;
    {$IF Declared(procLibCartoesFinaluizarObjetos)}
    procLibCartoesFinaluizarObjetos := Nil;
    {$ENDIF}
  End;
end;

class procedure TMenuLibCartoes.CarregarMenusAntecipacao(
  var AMenuCartoes: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem,
    LContador: Integer;

    RetornaItensMenuAntecipacaoCartoes: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusAntecipacaoJaCriados Then
    Exit;

  RetornaItensMenuAntecipacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuAntecipacaoCartoes'));

  LMenuDll := RetornaItensMenuAntecipacaoCartoes;

  For LMenuItem := 0 To LMenuDll.Count - 1 Do
  Begin
    For LContador := 0 To AMenuCartoes.Count - 1 Do
    Begin
      If Not String(LMenuDll[LMenuItem].Name).Equals(AMenuCartoes.Items[LContador].Name) Then
        Continue;

      AMenuCartoes.Remove(AMenuCartoes.Items[LContador]);

      Break;
    End;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(AMenuCartoes);
    LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

    AMenuCartoes.Add(LMenuAdicionar);
  End;

  FMenusAntecipacaoJaCriados := True;
end;

class procedure TMenuLibCartoes.CarregarMenusBaixaRecebiveisMkt(
  var AMenuRecebiveis: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuBaixaRecebiveisMktAutcom: TMenuItem;

    LMenuItem: Integer;

    RetornaItensMenuBaixaRecebiveisMkt: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusBaixaRecebiveisMktJaCriados Then
    Exit;

  RetornaItensMenuBaixaRecebiveisMkt := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuBaixaRecebiveisMkt'));

  LMenuDll := RetornaItensMenuBaixaRecebiveisMkt;

  LMenuBaixaRecebiveisMktAutcom := AMenuRecebiveis.Find('Conciliação/Baixa de Recebíveis');
  If LMenuBaixaRecebiveisMktAutcom = Nil Then
  Begin
    LMenuBaixaRecebiveisMktAutcom := TCustomMenuItemCartoes.Create(AMenuRecebiveis);
    LMenuBaixaRecebiveisMktAutcom.Name := 'mnuBaixaRecebiveisMkt';
    LMenuBaixaRecebiveisMktAutcom.Caption := 'Conciliação/Baixa de Recebíveis';
    LMenuBaixaRecebiveisMktAutcom.Hint := 'mnuBaixaRecebiveisMkt';

    AMenuRecebiveis.Add(LMenuBaixaRecebiveisMktAutcom);
  End;

  For LMenuItem := 0 To LMenuDll.Count - 1 Do
  Begin
    If TMenuLibCartoes.FMenuShopeeAntigo Then
    Begin
      If LMenuDll[LMenuItem].Name = 'mnuConciliaoShopeePay' Then
        Continue;
    End;

    If TMenuLibCartoes.FMenuMagazineLuizaAntigo Then
    Begin
      If LMenuDll[LMenuItem].Name = 'mnuConciliacaoMagazileLuiza' Then
        Continue;
    End;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(LMenuBaixaRecebiveisMktAutcom);
    LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

    LMenuBaixaRecebiveisMktAutcom.Add(LMenuAdicionar);
  End;

  FMenusBaixaRecebiveisMktJaCriados := True;
end;

class procedure TMenuLibCartoes.CarregarMenusConciliacao(
  var AMenuCartoes: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem,
    LContador: Integer;

    LMenuExiste: Boolean;

    RetornaItensMenuConciliacaoCartoes: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusConciliacaoJaCriados Then
    Exit;

  RetornaItensMenuConciliacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuConciliacaoCartoes'));

  LMenuDLL := RetornaItensMenuConciliacaoCartoes;

  For LMenuItem := 0 To LMenuDLL.Count - 1 Do
  Begin
    LMenuExiste := False;

    For LContador := 0 To AMenuCartoes.Count - 1 Do
    Begin
      If String(LMenuDll[LMenuItem].Name).Equals(AMenuCartoes.Items[LContador].Name) Then
      Begin
        LMenuExiste := True;

        Break;
      End;
    End;

    If LMenuExiste Then
      Continue;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(AMenuCartoes);
    LMenuAdicionar.Name := LMenuDLL[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDLL[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDLL[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDLL[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDLL[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDLL[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDLL[LMenuItem]).Layout;

    AMenuCartoes.Add(LMenuAdicionar);
  End;

  FMenusConciliacaoJaCriados := True;
end;

class procedure TMenuLibCartoes.CarregarMenusExclusao(
  var AMenuCartoes: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuExclusaoAutcom: TMenuItem;

    LMenuItem,
    LContador: Integer;

    LMenuExiste: Boolean;

    RetornaItensMenuExclusaoCartoes: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusExclusaoJaCriados Then
    Exit;

  RetornaItensMenuExclusaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuExclusaoCartoes'));

  LMenuDll := RetornaItensMenuExclusaoCartoes;

  LMenuExclusaoAutcom := AMenuCartoes.Find('Exclusão de arquivos importados');
  If LMenuExclusaoAutcom = Nil Then
  Begin
    LMenuExclusaoAutcom := TCustomMenuItemCartoes.Create(AMenuCartoes);
    LMenuExclusaoAutcom.Name := 'mnuExclusaoDeArquivosImportados';
    LMenuExclusaoAutcom.Caption := 'Exclusão de arquivos importados';
    LMenuExclusaoAutcom.Hint := 'mnuExclusaoDeArquivosImportados';

    AMenuCartoes.Add(LMenuExclusaoAutcom);
  End;

  For LMenuItem := 0 To LMenuDll.Count - 1 Do
  Begin
    LMenuExiste := False;

    For LContador := 0 To LMenuExclusaoAutcom.Count - 1 Do
    Begin
      If String(LMenuDll[LMenuItem].Name).Equals(LMenuExclusaoAutcom.Items[LContador].Name) Then
      Begin
        LMenuExiste := True;

        Break;
      End;
    End;

    If LMenuExiste Then
      Continue;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(LMenuExclusaoAutcom);
    LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

    LMenuExclusaoAutcom.Add(LMenuAdicionar);
  End;

  FMenusExclusaoJaCriados := True;
end;

class procedure TMenuLibCartoes.CarregarMenusExportacao(
  var AMenuCartoes: TMenuItem);
Var
  LMenuDll,
  LMenuAdicionar: TCustomMenuItemCartoes;

  LMenuExportacaoAutcom: TMenuItem;

  LMenuItem,
  LContador: Integer;

  LMenuExiste: Boolean;

  RetornaItensMenuExportacaoCartoes: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusExportacaoJaCriados Then
    Exit;

  RetornaItensMenuExportacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuExportacaoCartoes'));

  LMenuDll := RetornaItensMenuExportacaoCartoes;

  LMenuExportacaoAutcom := AMenuCartoes.Find('Exportação');
  If LMenuExportacaoAutcom = Nil Then
  Begin
    LMenuExportacaoAutcom := TCustomMenuItemCartoes.Create(AMenuCartoes);
    LMenuExportacaoAutcom.Name := 'mnuExportacaoCartoes';
    LMenuExportacaoAutcom.Caption := 'Exportação';
    LMenuExportacaoAutcom.Hint := 'mnuExportacaoCartoes';

    AMenuCartoes.Add(LMenuExportacaoAutcom);
  End;

  For LMenuItem := 0 To LMenuDll.Count - 1 Do
  Begin
    LMenuExiste := False;

    For LContador := 0 To LMenuExportacaoAutcom.Count - 1 Do
    Begin
      If String(LMenuDll[LMenuItem].Name).Equals(LMenuExportacaoAutcom.Items[LContador].Name) Then
      Begin
        LMenuExiste := True;

        Break;
      End;
    End;

    If LMenuExiste Then
      Continue;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(LMenuExportacaoAutcom);
    LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

    LMenuExportacaoAutcom.Add(LMenuAdicionar);
  End;

  FMenusExportacaoJaCriados := True;
end;

class procedure TMenuLibCartoes.CarregarMenusImportacao(var AMenuCartoes: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuItem,
    LContador: Integer;

    LMenuExiste: Boolean;

    RetornaItensMenuImportacaoCartoes: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusImportacaoJaCriados Then
    Exit;

  RetornaItensMenuImportacaoCartoes := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuImportacaoCartoes'));

  LMenuDll := RetornaItensMenuImportacaoCartoes;

  Try
    For LMenuItem := 0 To LMenuDll.Count - 1 Do
    Begin
      LMenuExiste := False;

      For LContador := 0 To AMenuCartoes.Count - 1 Do
      Begin
        If AMenuCartoes.Items[LContador].Name = 'mnuImpShopeePay' Then
          TMenuLibCartoes.FMenuShopeeAntigo := True;
        If AMenuCartoes.Items[LContador].Name = 'mnuImpMagazineLuiza' Then
          TMenuLibCartoes.FMenuMagazineLuizaAntigo := True;

        If String(LMenuDll[LMenuItem].Name).Equals(AMenuCartoes.Items[LContador].Name) Then
        Begin
          LMenuExiste := True;

          Break;
        End;
      End;

      If LMenuExiste Then
        Continue;

      LMenuAdicionar := TCustomMenuItemCartoes.Create(AMenuCartoes);
      LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
      LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
      LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
      LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
      LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
      LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
      LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

      AMenuCartoes.Add(LMenuAdicionar);
    End;

    FMenusImportacaoJaCriados := True;
  Finally
    FreeAndNil(LMenuDll);
  End;
end;

class procedure TMenuLibCartoes.CarregarMenusImportacaoRecebiveisMkt(
  AMenuImportacaoCartoes: TMenuItem; var AMenuFinanceiro: TMenuItem);
  Var
    LMenuDll,
    LMenuAdicionar: TCustomMenuItemCartoes;

    LMenuControleRecebiveisMktAutcom,
    LMenuImportacaoRecebiveisMktAutcom: TMenuItem;

    LMenuItem: Integer;

    RetornaItensMenuImportacaoRecebiveisMkt: function: TCustomMenuItemCartoes;
begin
  If LibCartoesHandle = 0 THen
    Exit;

  If FMenusImportacaoRecebiveisMktJaCriados Then
    Exit;

  If AMenuImportacaoCartoes.Find('Importação Mercado Livre') <> Nil Then
    Exit;

  RetornaItensMenuImportacaoRecebiveisMkt := GetProcAddress(LibCartoesHandle, PChar('RetornaItensMenuImportacaoRecebiveisMkt'));

  LMenuDll := RetornaItensMenuImportacaoRecebiveisMkt;

  LMenuControleRecebiveisMktAutcom := AMenuFinanceiro.Find('Controle de Recebíveis Market Place');
  If LMenuControleRecebiveisMktAutcom = Nil Then
  Begin
    LMenuControleRecebiveisMktAutcom := TCustomMenuItemCartoes.Create(AMenuFinanceiro);
    LMenuControleRecebiveisMktAutcom.Name := 'mnuSeqRecebiveis';
    LMenuControleRecebiveisMktAutcom.Caption := '-';
    LMenuControleRecebiveisMktAutcom.Hint := '';

    AMenuFinanceiro.Add(LMenuControleRecebiveisMktAutcom);

    LMenuControleRecebiveisMktAutcom := TCustomMenuItemCartoes.Create(AMenuFinanceiro);
    LMenuControleRecebiveisMktAutcom.Name := 'mnuControleRecebiveisMkt';
    LMenuControleRecebiveisMktAutcom.Caption := 'Controle de Recebíveis Market Place';
    LMenuControleRecebiveisMktAutcom.Hint := 'mnuControleRecebiveisMkt';

    AMenuFinanceiro.Add(LMenuControleRecebiveisMktAutcom);
  End;

  LMenuImportacaoRecebiveisMktAutcom := TCustomMenuItemCartoes.Create(LMenuControleRecebiveisMktAutcom);
  LMenuImportacaoRecebiveisMktAutcom.Name := 'mnuImportacaoRecebiveisMkt';
  LMenuImportacaoRecebiveisMktAutcom.Caption := 'Importação de Recebíveis';
  LMenuImportacaoRecebiveisMktAutcom.Hint := 'mnuImportacaoRecebiveisMkt';

  LMenuControleRecebiveisMktAutcom.Add(LMenuImportacaoRecebiveisMktAutcom);

  {$IF NOT Declared(VS_VERSAO_72)}
  If Not TMenuLibCartoes.FMenuShopeeAntigo Then
    fCfgSis('SHOHUB');
  {$ENDIF}

  For LMenuItem := 0 To LMenuDll.Count - 1 Do
  Begin
    If TMenuLibCartoes.FMenuShopeeAntigo Then
    Begin
      If LMenuDll[LMenuItem].Name = 'mnuImpShopeePay' Then
        Continue;
    End;

    If TMenuLibCartoes.FMenuMagazineLuizaAntigo Then
    Begin
      If LMenuDll[LMenuItem].Name = 'mnuImpMagazineLuiza' Then
        Continue;
    End;

    LMenuAdicionar := TCustomMenuItemCartoes.Create(LMenuImportacaoRecebiveisMktAutcom);
    LMenuAdicionar.Name := LMenuDll[LMenuItem].Name;
    LMenuAdicionar.Caption := LMenuDll[LMenuItem].Caption;
    LMenuAdicionar.Hint := LMenuDll[LMenuItem].Hint;
    LMenuAdicionar.OnClick := LMenuDll[LMenuItem].OnClick;
    LMenuAdicionar.Projeto := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Projeto;
    LMenuAdicionar.LibAcesso := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).LibAcesso;
    LMenuAdicionar.Layout := TCustomMenuItemCartoes(LMenuDll[LMenuItem]).Layout;

    LMenuImportacaoRecebiveisMktAutcom.Add(LMenuAdicionar);
  End;

  FMenusImportacaoRecebiveisMktJaCriados := True;
end;

class procedure TMenuLibCartoes.FinalizarObjetos(ALimpar: Boolean = False);
begin
  { Adicionado ALimpar para manter a compatibilidade com versões mais antigas e não realizar a limpeza
    da lib em pontos que não é mais para acontecer }
  If Not ALimpar Then
    Exit;

  ObjetoLibCartoes := Nil;
  InicializaObjetoLibCartoes := Nil;
  AdicionarConfiguracoesCartoes := Nil;
  AdicionarConfiguracoesAntecipacaoRedeCard := Nil;
  CarregaPropriedadesConfiguracoesCartoes := Nil;
  CarregaPropriedadesConfiguracoesAntecipacaoRedeCard := Nil;

  If LibCartoesHandle > 0 Then
  Begin
    FreeLibrary(LibCartoesHandle);
    LibCartoesHandle := 0;
  End;
end;

{ TConfiguracoesLibCartoes }

class procedure TConfiguracoesLibCartoes.CarregaDllLibCartoes;
begin
  TMenuLibCartoes.CarregaDllLibCartoes;
end;

class procedure TConfiguracoesLibCartoes.CarregaPropertiesItem(
  var ANovoItem: TcxEditRepositoryItem;
  AItemLibCartoes: TLibCartoesCfgProperties);
  Var
    LItemRadio: TcxRadioGroupItem;

    LItemButton: TcxEditButton;

    LItensProperty: TItensRadioGroup;

    LItensButton: TItensButtons;
begin
  If AItemLibCartoes.TipoClasse.Equals('TcxEditRepositoryRadioGroupItem') Then
  Begin
    TcxRadioGroupProperties(ANovoItem.Properties).DefaultCaption := AItemLibCartoes.CaptionCfg;
    TcxRadioGroupProperties(ANovoItem.Properties).DefaultValue := AItemLibCartoes.ValorDefault;
    TcxRadioGroupProperties(ANovoItem.Properties).Columns := AItemLibCartoes.Colunas;

    For LItensProperty In AItemLibCartoes.ItensRadioGroup Do
    Begin
      LItemRadio := TcxRadioGroupProperties(ANovoItem.Properties).Items.Add;
      LItemRadio.Caption := LItensProperty.Texto;
      LItemRadio.Value := LItensProperty.Valor;
    End;

    Exit;
  end;

  If AItemLibCartoes.TipoClasse.Equals('TcxEditRepositoryCurrencyItem') Then
  Begin
    TcxCurrencyEditProperties(ANovoItem.Properties).DecimalPlaces := AItemLibCartoes.CasasDecimais;
    TcxCurrencyEditProperties(ANovoItem.Properties).EditFormat := AItemLibCartoes.EditFormat;
    TcxCurrencyEditProperties(ANovoItem.Properties).DisplayFormat := AItemLibCartoes.DisplayFormat;
    TcxCurrencyEditProperties(ANovoItem.Properties).UseThousandSeparator := AItemLibCartoes.UsarSeparadorMilhar;

    Exit;
  End;

  If AItemLibCartoes.TipoClasse.Equals('TcxEditRepositoryButtonItem') Then
  Begin
    TcxButtonEditProperties(ANovoItem.Properties).ReadOnly := AItemLibCartoes.ApenasLeitura;

    Case AItemLibCartoes.ViewStyle Of
      tpvsNormal: TcxButtonEditProperties(ANovoItem.Properties).ViewStyle := vsNormal;
      tpvsButtonsAutoWidth: TcxButtonEditProperties(ANovoItem.Properties).ViewStyle := vsButtonsAutoWidth;
      tpvsHideCursor: TcxButtonEditProperties(ANovoItem.Properties).ViewStyle := vsHideCursor;
      tpvsButtonsOnly: TcxButtonEditProperties(ANovoItem.Properties).ViewStyle := vsButtonsOnly;
    End;

    TcxButtonEditProperties(ANovoItem.Properties).Buttons.Clear;
    For LItensButton In AItemLibCartoes.ItensBotoes Do
    Begin
      LItemButton := TcxButtonEditProperties(ANovoItem.Properties).Buttons.Add;
      LItemButton.Caption := LItensButton.Texto;
      LItemButton.Kind := bkText;
    End;

    TcxButtonEditProperties(ANovoItem.Properties).OnButtonClick := OnButtonClick;
    If MatchStr(AItemLibCartoes.Nome, ['libCartoesbtnCadEstabelecimentosCartoes',
                                       'libCartoesbtnCadIDRecebedorPagarMe',
                                       'libCartoesbtnCadChavesAutorizacaoPagarMe']) Then
      TcxButtonEditProperties(ANovoItem.Properties).OnButtonClick := OnClickCadEstabelecimentosCartoes;

    Exit;
  End;

  If AItemLibCartoes.TipoClasse.Equals('TcxEditRepositoryTextItem') Then
  Begin
    If AItemLibCartoes.CaracterPassword <> '' Then
    Begin
      TcxTextEditProperties(ANovoItem.Properties).PasswordChar := AItemLibCartoes.CaracterPassword;
      TcxTextEditProperties(ANovoItem.Properties).EchoMode := eemPassword;
    End;

    TcxTextEditProperties(ANovoItem.Properties).MaxLength := AItemLibCartoes.TamanhoMaximo;
    TcxTextEditProperties(ANovoItem.Properties).CharCase := TEditCharCase(AItemLibCartoes.TipoCaracter);
    TcxTextEditProperties(ANovoItem.Properties).ValidateOnEnter := AItemLibCartoes.RealizarValidacaoOnEnter;
    ANovoItem.PropertiesEvents := AItemLibCartoes.Eventos;
    TcxTextEditProperties(ANovoItem.Properties).OnValidate := AItemLibCartoes.EventosValidacao;

    Exit;
  End;
End;

class procedure TConfiguracoesLibCartoes.CarregaRepositorioCartoes(
  var ACfgRepositorio: Pointer);
  Var
    LListaCfgLib: TObjectList<TLibCartoesCfgProperties>;

    LNovoItem: TcxEditRepositoryItem;

    LContador: Integer;
begin
  LListaCfgLib := RetornaCfgRepositorioCartoes;

  If Not Assigned(LListaCfgLib) Then
    Exit;

  Try
    If LListaCfgLib.Count = 0 Then
      Exit;

    If TfrmCfgRepositorio(ACfgRepositorio).cxRepositorio.ItemByName(LListaCfgLib[0].Nome) <> Nil Then
      Exit;

    For LContador := 0 To LListaCfgLib.Count - 1 Do
    Begin
      LNovoItem := TfrmCfgRepositorio(ACfgRepositorio).cxRepositorio.CreateItem(RetornaTipoItemCfg(LListaCfgLib[LContador].TipoConfiguracao));

      LNovoItem.Name := LListaCfgLib[LContador].Nome;

      CarregaPropertiesItem(LNovoItem, LListaCfgLib[LContador]);
    End;
  Finally
    FreeAndNil(LListaCfgLib);
  End;
end;

class procedure TConfiguracoesLibCartoes.OnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  fMensagem('ATENÇÃO', 'A versão do Autcom deve ser atualizada.', ['&Ok']);
end;

class procedure TConfiguracoesLibCartoes.OnClickCadEstabelecimentosCartoes(
  Sender: TObject; AButtonIndex: Integer);
  Var
    CarregarCadEstabelecimentosCartoes: function(ACodigoConfiguracao, AValorCfg: String): String; StdCall;
    CarregarCadEstabelecimentosCartoesEstilo: function(ACodigoConfiguracao, AValorCfg: String; ALayoutClasico: Boolean): String; StdCall;

    {$IF Declared(VS_CFGSISTEMA_VALIDAR_EXISTE)}
    LCodigoCfg: String;
    {$ENDIF}
begin
  CarregarCadEstabelecimentosCartoes := GetProcAddress(LibCartoesHandle, PChar('CarregarCadEstabelecimentosCartoes'));
  CarregarCadEstabelecimentosCartoesEstilo := GetProcAddress(LibCartoesHandle, PChar('CarregarCadEstabelecimentosCartoesEstilo'));

  {$IF Declared(VS_CFGSISTEMA_VALIDAR_EXISTE)}
  LCodigoCfg := TValidarConfiguracoes.cxDBTableView.DataController.DataSet.FieldByName('SIS_CODCFG').AsString;
  If TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_CODCFG') <> Nil Then
    LCodigoCfg := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_CODCFG').EditValue;

  If Assigned(CarregarCadEstabelecimentosCartoesEstilo) Then
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := CarregarCadEstabelecimentosCartoesEstilo(LCodigoCfg,
                                                                                                                                 VarToStrDef(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue,''),
                                                                                                                                 blnUsuarioLogadoUtilizaModoClassico)
  Else
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := CarregarCadEstabelecimentosCartoes(LCodigoCfg,
                                                                                                                           VarToStrDef(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue,''));
  Exit;
  {$ENDIF}

  {$IF Declared(VS_VERSAO_72))}
  frmCfgSistema.cxDadosDBTableView1.GetColumnByFieldName('SIS_VALCFG').EditValue := CarregarCadEstabelecimentosCartoes(frmCfgSistema.cxDadosDBTableView1.GetColumnByFieldName('SIS_CODCFG').EditValue,
                                                                                                                       VarToStrDef(frmCfgSistema.cxDadosDBTableView1.GetColumnByFieldName('SIS_VALCFG').EditValue,''));
  {$ENDIF}
end;

class function TConfiguracoesLibCartoes.RetornaTipoItemCfg(
  ATipoConfiguracao: TTipoConfiguracao): TcxEditRepositoryItemClass;
begin
  Case ATipoConfiguracao Of
    tpcSimNao, tpcVersaoPagarMe: Result := TcxEditRepositoryRadioGroupItem;
    tpcValorDecimal, tpcValorToleranciaCartao, tpcValorInteiro: Result := TcxEditRepositoryCurrencyItem;
    tpcCadEstabelecimentos, tpcCadIDRecebedoresPagarMe, tpcCadChavesAutorizacaoPagarMe: Result := TcxEditRepositoryButtonItem;
    Else Result := TcxEditRepositoryTextItem;
  End;
end;

initialization
  TMenuLibCartoes.FMenusImportacaoJaCriados := False;
  TMenuLibCartoes.FMenusConciliacaoJaCriados := False;
  TMenuLibCartoes.FMenusAntecipacaoJaCriados := False;
  TMenuLibCartoes.FMenusBaixaRecebiveisMktJaCriados := False;
  TMenuLibCartoes.FMenusImportacaoRecebiveisMktJaCriados := False;
  TMenuLibCartoes.FMenuShopeeAntigo := False;
  TMenuLibCartoes.FMenuMagazineLuizaAntigo := False;

finalization
  TMenuLibCartoes.FinalizarObjetos(True);

end.
