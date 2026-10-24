unit untPermissaoAcesso;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ExtCtrls, ComCtrls, DB, strUtils, StdCtrls, EditFocus,
  Mask, DBCtrls, CheckLst, Menus, Buttons, Uni, AppEvnts, cxProgressBar,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Datasnap.DBClient, cxGridCitel, System.ImageList, Vcl.ImgList, cxImageList, cxImageComboBox,
  untPermissaoAcessoAdicionar, dxGDIPlusClasses, cxGroupBox, cxContainer,
  untTypesSistema, UniClientDataSet;

type
  TfrmPermissaoAcesso = class(TfrmPai)
    lblNomForm: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    lblDescricaoDireitoAcesso: TLabel;
    lblDireitosEspecificos: TLabel;
    lstDireitosEspecificos: TCheckListBox;
    cxgTemPermissaoView: TcxGridDBTableViewCitel;
    cxgTemPermissaoLevel: TcxGridLevel;
    cxgTemPermissao: TcxGridCitel;
    Panel1: TPanel;
    btnAdicionar: TBitBtnLocked;
    btnRemover: TBitBtnLocked;
    cdsTemPermissao: TUniClientDataSet;
    cdsTemPermissaotipo: TStringField;
    cdsTemPermissaodescricao: TStringField;
    cdsTemPermissaocodigo: TStringField;
    dtsTemPermissao: TDataSource;
    cxgTemPermissaoViewtipo: TcxGridDBColumn;
    cxgTemPermissaoViewdescricao: TcxGridDBColumn;
    cxgTemPermissaoViewcodigo: TcxGridDBColumn;
    imgIcones: TcxImageList;
    cdsTemPermissaoespecificos: TStringField;
    Panel2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Image1: TImage;
    edtPesquisar: TEdit;
    Label3: TLabel;
    Panel3: TPanel;
    btnAplicar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    tmrPesquisar: TTimer;
    Styles: TcxStyleRepository;
    cxsFoco: TcxStyle;
    cxsSemFoco: TcxStyle;
    rdgFiltro: TRadioGroup;
    lblRemoverTodos: TLabel;
    tmrSomenteSelecionar: TTimer;
    cdsTemPermissaoopesenlib: TStringField;
    chkSenLib: TCheckBox;
    btnVerGrupos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsTemPermissaoAfterScroll(DataSet: TDataSet);
    procedure cdsTemPermissaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cxgTemPermissaoViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure lstDireitosEspecificosClickCheck(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure cxgTemPermissaoViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure rdgFiltroClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxgTemPermissaoViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblRemoverTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure tmrSomenteSelecionarTimer(Sender: TObject);
    procedure chkOpeSenLibClick(Sender: TObject);
    procedure chkSenLibClick(Sender: TObject);
    procedure btnVerGruposClick(Sender: TObject);
  private
    { Private declarations }
    FDirAce: String;
    FDocked: Boolean;
    FSomenteSelec: Boolean;
    FSomenteRemover: Boolean;
    FLabelAguarde: TLabel;
    FQryOperadores: TUniQuery;
    FQryGrupos: TUniQuery;
    FQryDirEsp: TUniQuery;
    FAfterAplicar: TGenericProcedure;
    FblnSomenteExibir : Boolean;
    blnClickSenLib : Boolean;
    FOpeLib: String;
  private
    function GetMenuDirAce(ADirAce: String): TMenuItem;
    function GetDescricaoDirAce(ADirAce: String): String;
    function GetRemovidos: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
    function TemDireitosEspecificos(ADirAce: String): Boolean;
    function AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
    class function ValidarPermissaoParaEditar(var LOpeLib: String): Boolean;
  private type
    TAddDirAceOption = (opCheckParent, opCheckChild, opNone);
  private type
    TLiberarAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcesso;
      FSelecionados: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
    public
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;
  private type
    TRemoverAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcesso;
      FRemovidos: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
    public
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;
  private
    procedure AdicionarPermissaoUsuario(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure AdicionarPermissaoGrupo(ADirAce, ACodGpo, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure CarregarOperadoresComPermissao;
    procedure CarregarGruposComPermissao;
    procedure CarregarDireitosEspecificos;
    procedure RemoverPermissaoUsuario(ADirAce, ACodOpe, AOpeSenLib: String; AOption: TAddDirAceOption);
    procedure RemoverPermissaoGrupo(ADirAce, ACodGpo, AOpeSenLib: String; AOption: TAddDirAceOption);
    procedure AdicionarPermissao(ATipo, ACodigo, ADescricao, AOpeSenLib: String);
    procedure Adicionar;
    procedure LimparFiltros;
    procedure RemoverTodos;
    procedure SetDirAce(const Value: String);
    procedure AtualizaCheckListDirEspecifico;
  public
    { Public declarations }
    class procedure EditarPermissoes(ADirAce: String);
    class procedure LiberarAcessoSubrotinas(ADirAce: String);
    class procedure RemoverAcessoSubrotinas(ADirAce: String);
    property strDireitoAcesso: String Read FDirAce write SetDirAce;
    property blnSomenteSelecionar: Boolean Read FSomenteSelec write FSomenteSelec;
    property blnSomenteRemover: Boolean Read FSomenteRemover write FSomenteRemover;
    property blnDocked: Boolean Read FDocked write FDocked;
    property lblAguarde: TLabel Read FLabelAguarde write FLabelAguarde;
    property AfterAplicar: TGenericProcedure Read FAfterAplicar Write FAfterAplicar;
    property blnSomenteExibir : Boolean read FblnSomenteExibir write FblnSomenteExibir;
    property OperadorLiberacaoAcesso: String read FOpeLib write FOpeLib;
  end;

implementation

uses untfuncoesSimples, untPrincipal, untHighlightGrid, untConstantes,
  untModulo, untDicionarioResultadoQuerySimples, untFuncoesGenerica,
  untCadGruOperadorNovo;

{$R *.dfm}
{ TfrmPermissaoAcesso }

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

  SQL_DELETE_DIRGPO = 'DELETE FROM DIRGPO WHERE DIR_NOMFRM = "%s" AND GPO_CODGPO = "%s";';
  SQL_DELETE_DIROPE = 'DELETE FROM DIROPE WHERE DIR_NOMFRM = "%s" AND OPE_CODOPE = "%s";';

  SQL_REPLACE_DIRGPO = 'REPLACE INTO DIRGPO (DIR_NOMFRM, GPO_CODGPO, DIR_ACAOUS, DIR_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';
  SQL_REPLACE_DIROPE = 'REPLACE INTO DIROPE (DIR_NOMFRM, OPE_CODOPE, DIR_ACAOUS, DIR_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';

function TfrmPermissaoAcesso.GetDescricaoDirAce(ADirAce: String): String;
Var
  LMenu: TMenuItem;
  I: Integer;
begin
  Result := '';
  LMenu := Nil;
  For I := 0 To Pred(frmPrincipal.mnuAutcomK.Items.Count) Do
  Begin
    LMenu := fFindMenu(ADirAce, frmPrincipal.mnuAutcomK.Items[I], True);
    If Assigned(LMenu) Then
      Break;
  End;
  If Assigned(LMenu) Then
    Result := fGetMenuPath(LMenu);
end;

function TfrmPermissaoAcesso.GetMenuDirAce(ADirAce: String): TMenuItem;
Var
  I: Integer;
begin
  Result := Nil;
  For I := 0 To Pred(frmPrincipal.mnuAutcomK.Items.Count) Do
  Begin
    Result := fFindMenu(ADirAce, frmPrincipal.mnuAutcomK.Items[I], True);
    If Assigned(Result) Then
      Break;
  End;
end;

procedure TfrmPermissaoAcesso.lblRemoverTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(RemoverTodos, 'Removendo todos, Aguarde ...', '');
end;

class procedure TfrmPermissaoAcesso.LiberarAcessoSubrotinas(ADirAce: String);
Var
  LForm: TfrmPermissaoAcesso;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
  objLiberar: TLiberarAcessoSubrotinas;
  LOpeLib: String;
begin
  If Not ValidarPermissaoParaEditar(LOpeLib) Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcesso, LForm);
  Try
    LForm.strDireitoAcesso := ADirAce;
    LForm.OperadorLiberacaoAcesso := LOpeLib;

    LSelecionados := TfrmPermissaoAcessoAdicionar.Selecionar(LForm.lblDescricaoDireitoAcesso.Caption);

    If Length(LSelecionados) = 0 Then
      Exit;

    If fPergunta('Confirma liberação de acesso para "' + LForm.lblDescricaoDireitoAcesso.Caption +
      '" e todos os seus subitens?') Then
    Begin
      objLiberar := TLiberarAcessoSubrotinas.Create;
      Try
        objLiberar.FForm := LForm;
        objLiberar.FDirAce := ADirAce;
        objLiberar.FSelecionados := LSelecionados;
        fChamaTelaGravando(objLiberar.Executar, 'Atualizando permissões de acesso, Aguarde ...');
      Finally
        FreeAndNil(objLiberar);
      End;
    End;

  Finally
    pFreeAndNil(LForm);
  End;

  TLimparCaches.Execute;
end;

procedure TfrmPermissaoAcesso.LimparFiltros;
begin
  rdgFiltro.ItemIndex := 2;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  cdsTemPermissao.Filtered := False;
end;

procedure TfrmPermissaoAcesso.lstDireitosEspecificosClickCheck(Sender: TObject);
Var
  LDirEsp: String;
begin
  inherited;
  If cdsTemPermissao.IsEmpty Then
    Exit;

  LDirEsp := '';

  If lstDireitosEspecificos.Checked[0] Then
    LDirEsp := LDirEsp + 'I';

  If lstDireitosEspecificos.Checked[1] Then
    LDirEsp := LDirEsp + 'A';

  If lstDireitosEspecificos.Checked[2] Then
    LDirEsp := LDirEsp + 'E';

  cdsTemPermissao.Edit;
  cdsTemPermissaoespecificos.AsString := LDirEsp;
  cdsTemPermissao.Post;

  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcesso.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
  btnVerGrupos.Visible := (rdgFiltro.ItemIndex = 1) And fVerificaAcessoSistema('frmCadGruOperadorNovo');
end;

class procedure TfrmPermissaoAcesso.RemoverAcessoSubrotinas(ADirAce: String);
Var
  LForm: TfrmPermissaoAcesso;
  objRemover: TRemoverAcessoSubrotinas;
  LOpeLib: String;
begin
  If Not ValidarPermissaoParaEditar(LOpeLib) Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcesso, LForm);
  Try
    LForm.strDireitoAcesso := ADirAce;
    LForm.blnSomenteRemover := True;
    LForm.OperadorLiberacaoAcesso := LOpeLib;
    LForm.ShowModal;

    objRemover := TRemoverAcessoSubrotinas.Create;
    Try
      objRemover.FForm := LForm;
      objRemover.FDirAce := ADirAce;
      objRemover.FRemovidos := LForm.GetRemovidos;

      If Length(objRemover.FRemovidos) = 0 Then
        Exit;

      If Not fPergunta('Confirma remover acesso para "' + LForm.lblDescricaoDireitoAcesso.Caption +
        '" e todos os seus subitens?') Then
        Exit;

      fChamaTelaGravando(objRemover.Executar, 'removendo permissões de acesso, Aguarde ...');
    Finally
      FreeAndNil(objRemover);
    End;
  Finally
    pFreeAndNil(LForm);
  End;

  TLimparCaches.Execute;
end;

procedure TfrmPermissaoAcesso.RemoverPermissaoGrupo(ADirAce, ACodGpo, AOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
begin
  fExecutaSQL(Format(SQL_DELETE_DIRGPO, [ADirAce, ACodGpo]));
  frmModulo.pAddLogDir('DIRGPO', ADirAce, '', 'DEL', AOpeSenLib, ACodGpo.ToInteger, FOpeLib);

  LMenu := GetMenuDirAce(ADirAce);

  Case AOption Of
    opCheckParent:
      If Assigned(LMenu.Parent) Then
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Removendo direitos de acesso grupo ' + fRetNomCadGpo(ACodGpo) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Parent), 150) + ' ...';

        RemoverPermissaoGrupo(LMenu.Parent.Hint, ACodGpo, AOpeSenLib, AOption);
      End;

    opCheckChild:
      For I := 0 To LMenu.Count - 1 Do
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Removendo direitos de acesso grupo ' + fRetNomCadGpo(ACodGpo) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Items[I]), 150) + ' ...';

        RemoverPermissaoGrupo(LMenu.Items[I].Hint, ACodGpo, AOpeSenLib, AOption);
      End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcesso.RemoverPermissaoUsuario(ADirAce, ACodOpe, AOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
begin
  If ADirAce.IsEmpty Then
    Exit;

  fExecutaSQL(Format(SQL_DELETE_DIROPE, [ADirAce, ACodOpe]));
  frmModulo.pAddLogDir('DIROPE', ADirAce, ACodOpe, 'DEL', AOpeSenLib, 0, FOpeLib);

  LMenu := GetMenuDirAce(ADirAce);

  Case AOption Of
    opCheckParent:
      If Assigned(LMenu.Parent) Then
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Removendo direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Parent), 150) + ' ...';

        RemoverPermissaoUsuario(LMenu.Parent.Hint, ACodOpe, AOpeSenLib, AOption);
      End;

    opCheckChild:
      For I := 0 To LMenu.Count - 1 Do
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Removendo direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Items[I]), 150) + ' ...';

        RemoverPermissaoUsuario(LMenu.Items[I].Hint, ACodOpe, AOpeSenLib, AOption);
      End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcesso.RemoverTodos;
begin
  cdsTemPermissao.DisableControls;
  Try
    While Not cdsTemPermissao.IsEmpty Do
    Begin
      btnRemover.Click;
      Application.ProcessMessages;
    End;
    btnAplicar.Enabled := True;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

procedure TfrmPermissaoAcesso.SetDirAce(const Value: String);
begin
  If FDocked And btnAplicar.Enabled And Not FDirAce.IsEmpty Then
    If fPergunta('Alterações realizadas em "' + lblDescricaoDireitoAcesso.Caption + '" não foram aplicadas.' +
      #13#10 + 'Deseja aplicar as alterações?') Then
    Begin
      btnAplicar.Click;
    End;

  FDirAce := Value;
  lblDescricaoDireitoAcesso.Caption := GetDescricaoDirAce(FDirAce);

  cdsTemPermissao.DisableControls;
  Try
    cdsTemPermissao.EmptyDataSet;
    CarregarOperadoresComPermissao;
    CarregarGruposComPermissao;
    CarregarDireitosEspecificos;
  Finally
    cdsTemPermissao.EnableControls;
  End;

  lstDireitosEspecificos.Visible := True;
  lblDireitosEspecificos.Visible := True;

  If Not TemDireitosEspecificos(FDirAce) Then
  Begin
    lstDireitosEspecificos.Visible := False;
    lblDireitosEspecificos.Visible := False;
  End;

  If btnAplicar.Focused Then
    pSetFocus(edtPesquisar)
  Else
    edtPesquisar.Text := INFO_PESQUISA;

  btnAplicar.Enabled := False;

  cdsTemPermissaoAfterScroll(cdsTemPermissao);
end;

function TfrmPermissaoAcesso.TemDireitosEspecificos(ADirAce: String): Boolean;
begin
  Result := False;
  FQryDirEsp.First;
  While Not FQryDirEsp.Eof Do
  Begin
    If ADirAce.ToLower.StartsWith(FQryDirEsp.FieldByName('DIR_NOMFRM').AsString.ToLower) Then
      Exit(True);
    FQryDirEsp.Next;
  End;
end;

procedure TfrmPermissaoAcesso.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  Try
    cdsTemPermissao.DisableControls;
    cdsTemPermissao.Filtered := False;
    cdsTemPermissao.Filtered := True;
    If Not cdsTemPermissao.IsEmpty Then
      AtualizaCheckListDirEspecifico;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

procedure TfrmPermissaoAcesso.tmrSomenteSelecionarTimer(Sender: TObject);
begin
  inherited;
  tmrSomenteSelecionar.Enabled := False;
  btnAdicionar.Click;
  btnConfirmar.Click;
end;

class function TfrmPermissaoAcesso.ValidarPermissaoParaEditar(var LOpeLib: String): Boolean;
var
  LSenha: String;
begin
  If Not fVerificaAcessoSistema('frmDirAcesso') Then
  Begin
    If Not ffrmSenha(LSenha) Then
      Exit(False);

    LOpeLib := fRetCodVendedor(LSenha);

    If Not fVerificaAcessoSistema('frmDirAcesso', LOpeLib) Then
      Exit(False);
  End;
  Result := True;
end;

procedure TfrmPermissaoAcesso.AdicionarPermissao(ATipo, ACodigo, ADescricao, AOpeSenLib: String);
begin
  If ATipo.IsEmpty Then
    Exit;

  If cdsTemPermissao.Locate('tipo;codigo', VarArrayOf([ATipo, ACodigo]), []) Then
    Exit;

  cdsTemPermissao.AppendRecord([ATipo, ACodigo, ADescricao, 'IAE', AOpeSenLib]);

  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcesso.AdicionarPermissaoGrupo(ADirAce, ACodGpo, ADirEsp, ADirOpeSenLib: String;
  AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
  LDireitos: String;
  LOpeSenLib: String;
begin
  If ADirAce.IsEmpty Then
    Exit;

  LDireitos := fCampoTabela('DIR_ACAOUS', 'DIRGPO', ['GPO_CODGPO', 'DIR_NOMFRM'], [ACodGpo, ADirAce]);
  LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIRGPO', ['GPO_CODGPO', 'DIR_NOMFRM'], [ACodGpo, ADirAce]);

  If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
  Begin
    fExecutaSQL(Format(SQL_REPLACE_DIRGPO, [ADirAce, ACodGpo, ADirEsp, ADirOpeSenLib]));
    frmModulo.pAddLogDir('DIRGPO', ADirAce, '', ADirEsp, ADirOpeSenLib, ACodGpo.ToInteger, FOpeLib);
  End;

  LMenu := GetMenuDirAce(ADirAce);

  Case AOption Of
    opCheckParent:
      If (Assigned(LMenu)) and (Assigned(LMenu.Parent)) Then
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Grupo ' + fRetNomCadGpo(ACodGpo) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Parent), 150) + ' ...';

        AdicionarPermissaoGrupo(LMenu.Parent.Hint, ACodGpo, ADirEsp, ADirOpeSenLib, AOption);
      End;

    opCheckChild:
      For I := 0 To LMenu.Count - 1 Do
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Grupo ' + fRetNomCadGpo(ACodGpo) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Items[I]), 150) + ' ...';

        AdicionarPermissaoGrupo(LMenu.Items[I].Hint, ACodGpo, ADirEsp, ADirOpeSenLib, AOption);
      End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcesso.AdicionarPermissaoUsuario(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String;
  AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
  LDireitos: String;
  LOpeSenLib : String;
begin
  If ADirAce.IsEmpty Then
    Exit;

  LDireitos := fCampoTabela('DIR_ACAOUS', 'DIROPE', ['OPE_CODOPE', 'DIR_NOMFRM'], [ACodOpe, ADirAce]);
  LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIROPE', ['OPE_CODOPE', 'DIR_NOMFRM'], [ACodOpe, ADirAce]);

  If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
  Begin
    fExecutaSQL(Format(SQL_REPLACE_DIROPE, [ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib]));
    frmModulo.pAddLogDir('DIROPE', ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib, 0, FOpeLib);
  End;

  LMenu := GetMenuDirAce(ADirAce);

  Case AOption Of
    opCheckParent:
      If Assigned(LMenu) And (Assigned(LMenu.Parent)) Then
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Parent), 150) + ' ...';

        AdicionarPermissaoUsuario(LMenu.Parent.Hint, ACodOpe, ADirEsp, ADirOpeSenLib, AOption);
      End;

    opCheckChild:
      For I := 0 To LMenu.Count - 1 Do
      Begin
        If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
            LeftStr(fGetMenuPath(LMenu.Items[I]), 150) + ' ...';

        AdicionarPermissaoUsuario(LMenu.Items[I].Hint, ACodOpe, ADirEsp, ADirOpeSenLib, AOption);
      End;
  End;

  Application.ProcessMessages;
end;

function TfrmPermissaoAcesso.AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
Var
  LCodigo: String;
begin
  Result := False;

  LCodigo := cdsTemPermissaocodigo.AsString;

  FQryOperadores.Close;
  FQryOperadores.Open;

  FQryGrupos.Close;
  FQryGrupos.Open;

  LimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    Try
      fStartTransaction();

      pgbProgresso.properties.Max := cdsTemPermissao.RecordCount;

      cdsTemPermissao.First;
      While Not cdsTemPermissao.Eof Do
      Begin
        pgbProgresso.Position := cdsTemPermissao.RecNo;

        If cdsTemPermissaotipo.AsString = 'OPE' Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Liberando direitos de acesso Operador ' +
            cdsTemPermissaodescricao.AsString + ' ... ';

          AdicionarPermissaoUsuario(FDirAce,
                                    cdsTemPermissaocodigo.AsString,
                                    cdsTemPermissaoespecificos.AsString,
                                    cdsTemPermissaoopesenlib.AsString,
                                    opCheckParent);
        End;

        If cdsTemPermissaotipo.AsString = 'GRU' Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Liberando direitos de acesso Grupo ' +
            cdsTemPermissaodescricao.AsString + ' ... ';

          AdicionarPermissaoGrupo(FDirAce,
                                  cdsTemPermissaocodigo.AsString,
                                  cdsTemPermissaoespecificos.AsString,
                                  cdsTemPermissaoopesenlib.AsString,
                                  opCheckParent);
        End;

        Application.ProcessMessages;

        cdsTemPermissao.Next;
      End;

      pgbProgresso.properties.Max := FQryOperadores.RecordCount;

      FQryOperadores.First;
      While Not FQryOperadores.Eof Do
      Begin
        pgbProgresso.Position := FQryOperadores.RecNo;

        If Not cdsTemPermissao.Locate('tipo;codigo',
          VarArrayOf(['OPE', FQryOperadores.FieldByName('OPE_CODOPE').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Operador ' +
            fRetNomVendRep(FQryOperadores.FieldByName('OPE_CODOPE').AsString) + ' ... ';

          RemoverPermissaoUsuario(FDirAce, FQryOperadores.FieldByName('OPE_CODOPE').AsString, FQryOperadores.FieldByName('DIR_OSNLIB').AsString, opNone);
        End;

        Application.ProcessMessages;

        FQryOperadores.Next;
      End;

      pgbProgresso.properties.Max := FQryGrupos.RecordCount;

      FQryGrupos.First;
      While Not FQryGrupos.Eof Do
      Begin
        pgbProgresso.Position := FQryGrupos.RecNo;

        If Not cdsTemPermissao.Locate('tipo;codigo',
          VarArrayOf(['GRU', FQryGrupos.FieldByName('GPO_CODGPO').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Grupo ' +
            fRetNomCadGpo(FQryGrupos.FieldByName('GPO_CODGPO').AsString) + ' ... ';

          RemoverPermissaoGrupo(FDirAce, FQryGrupos.FieldByName('GPO_CODGPO').AsString, FQryGrupos.FieldByName('DIR_OSNLIB').AsString, opNone);
        End;

        Application.ProcessMessages;

        FQryGrupos.Next;
      End;

      Result := fCommit();
    Except
      On E: Exception Do
      Begin
        fRollback();
        pMensagensErro(E.Message, 'TfrmPermissaoAcesso.AplicarAlteracoes');
      End;
    End;
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissao.Locate('codigo', LCodigo, []);
  End;

end;

procedure TfrmPermissaoAcesso.AtualizaCheckListDirEspecifico;
begin
  btnRemover.Enabled := Not cdsTemPermissao.IsEmpty;
  lstDireitosEspecificos.Checked[0] := cdsTemPermissaoespecificos.AsString.Contains('I');
  lstDireitosEspecificos.Checked[1] := cdsTemPermissaoespecificos.AsString.Contains('A');
  lstDireitosEspecificos.Checked[2] := cdsTemPermissaoespecificos.AsString.Contains('E');

  blnClickSenLib := False;
  chkSenLib.Checked := cdsTemPermissaoopesenlib.AsString.Equals('S');
  blnClickSenLib := True;
end;

procedure TfrmPermissaoAcesso.btnAdicionarClick(Sender: TObject);
begin
  If blnSomenteSelecionar Then
    Adicionar
  Else
    fExecutarModal(Adicionar, 'Selecionando usuários e grupos, Aguarde ...', '');
end;

procedure TfrmPermissaoAcesso.Adicionar;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionar.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
begin
  inherited;
  LimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    LSelecionados := TfrmPermissaoAcessoAdicionar.Selecionar(Self.lblDescricaoDireitoAcesso.Caption,
      cdsTemPermissao, blnSomenteSelecionar);
    For LSelecionado In LSelecionados Do
      AdicionarPermissao(LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao, LSelecionado.OpeSenLib);
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissaoAfterScroll(cdsTemPermissao);
  End;
end;

procedure TfrmPermissaoAcesso.btnAplicarClick(Sender: TObject);
begin
  inherited;
  If Not btnAplicar.Enabled Then
    Exit;

  If blnSomenteRemover Then
    Exit;

  If Not blnSomenteSelecionar Then
    If Not fPergunta('Confirma atualização das permissões de acesso?') Then
      Exit;

  TLimparCaches.Execute;

  fChamaTelaGravando(AplicarAlteracoes, 'Atualizando permissões de acesso, Aguarde ...');

  If blnDocked Then
    pSetFocus(edtPesquisar)
  Else
    pSetFocus(btnConfirmar);

  btnAplicar.Enabled := False;

  TLimparCaches.Execute;

  If Assigned(AfterAplicar) Then
    AfterAplicar;
end;

procedure TfrmPermissaoAcesso.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Click;
  btnSair.Click;
end;

procedure TfrmPermissaoAcesso.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If Not cdsTemPermissao.IsEmpty Then
  Begin
    cdsTemPermissao.Delete;
    btnAplicar.Enabled := True;
  End;
end;

procedure TfrmPermissaoAcesso.btnVerGruposClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadGruOperadorNovo);
end;

procedure TfrmPermissaoAcesso.CarregarDireitosEspecificos;
begin
  FQryDirEsp.Close;
  FQryDirEsp.SQL.Text := 'SELECT * FROM DIRESP';
  FQryDirEsp.Open;
end;

procedure TfrmPermissaoAcesso.CarregarGruposComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin
  FQryGrupos.Close;
  FQryGrupos.SQL.Text := 'SELECT * FROM DIRGPO WHERE DIR_NOMFRM = ' + FDirAce.QuotedString;
  FQryGrupos.Open;

  FQryGrupos.First;

  While Not FQryGrupos.Eof Do
  Begin
    LCodigo := FQryGrupos.FieldByName('GPO_CODGPO').AsString;
    LDirEsp := FQryGrupos.FieldByName('DIR_ACAOUS').AsString;
    LOpeSenLib := FQryGrupos.FieldByName('DIR_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['GRU', LCodigo, fRetNomCadGpo(LCodigo), LDirEsp, LOpeSenLib]);
    FQryGrupos.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcesso.CarregarOperadoresComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin

  FQryOperadores.Close;
  FQryOperadores.SQL.Clear;
  FQryOperadores.SQL.Add(' SELECT * FROM DIROPE ');
  FQryOperadores.SQL.Add(' INNER JOIN CADOPE ON CADOPE.OPE_CODOPE = DIROPE.OPE_CODOPE AND CADOPE.OPE_STATUS = "A" ');
  FQryOperadores.SQL.Add(' WHERE DIR_NOMFRM = ' + FDirAce.QuotedString );
  FQryOperadores.Open;

  FQryOperadores.First;

  While Not FQryOperadores.Eof Do
  Begin
    LCodigo := FQryOperadores.FieldByName('OPE_CODOPE').AsString;
    LDirEsp := FQryOperadores.FieldByName('DIR_ACAOUS').AsString;
    LOpeSenLib := FQryOperadores.FieldByName('DIR_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['OPE', LCodigo, fRetNomVendRep(LCodigo), LDirEsp, LOpeSenLib]);
    FQryOperadores.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcesso.cdsTemPermissaoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If Not cdsTemPermissao.ControlsDisabled Then
    AtualizaCheckListDirEspecifico;
end;

procedure TfrmPermissaoAcesso.cdsTemPermissaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
Var
  LPalavra: String;
  LPalavras: TStringList;
begin
  inherited;
  Accept := True;
  LPalavras := fGetPalavras(edtPesquisar);
  Try
    If edtPesquisar.Text <> INFO_PESQUISA Then
      For LPalavra In LPalavras Do
        Accept := Accept And fRemoveAcento(DataSet.FieldByName('codigo').AsString + ' ' +
          DataSet.FieldByName('descricao').AsString).ToUpper.Contains(fRemoveAcento(LPalavra).ToUpper);

    Case rdgFiltro.ItemIndex Of
      0:
        Accept := Accept And DataSet.FieldByName('tipo').AsString.Equals('OPE');
      1:
        Accept := Accept And DataSet.FieldByName('tipo').AsString.Equals('GRU');
    End;
  Finally
    FreeAndNil(LPalavras);
  End;
end;

procedure TfrmPermissaoAcesso.chkOpeSenLibClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcesso.chkSenLibClick(Sender: TObject);
begin
  inherited;
  If blnClickSenLib Then
  Begin
    cdsTemPermissao.Edit;

    If chkSenLib.Checked Then
      cdsTemPermissaoopesenlib.AsString := 'S'
    Else
      cdsTemPermissaoopesenlib.AsString := 'N';

    cdsTemPermissao.Post;

    btnAplicar.Enabled := True;
  End;
end;

procedure TfrmPermissaoAcesso.cxgTemPermissaoViewCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  LLista: TStringList;
  LArray: TArray<String>;
  I: Integer;
begin
  inherited;
  If (edtPesquisar.Text <> INFO_PESQUISA) And (AViewInfo.Item.Index <> cxgTemPermissaoViewtipo.Index) Then
  Begin
    LLista := fGetPalavras(edtPesquisar);
    Try
      SetLength(LArray, LLista.Count);
      For I := 0 To LLista.Count - 1 Do
        LArray[I] := LLista[I];
      pHighlightCxGrid(ACanvas, AViewInfo, LArray);
      ADone := LLista.Count > 0;
    Finally
      FreeAndNil(LLista);
    End;
  End;
end;

procedure TfrmPermissaoAcesso.cxgTemPermissaoViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE:
      btnRemover.Click;
    VK_INSERT:
      btnAdicionar.Click;
    VK_ESCAPE:
      If btnCancelar.Visible Then
        btnCancelar.Click;
    VK_UP:
      If cxgTemPermissaoView.DataController.RecNo <= 1 Then
        pSetFocus(edtPesquisar);
  End;

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    pSetFocus(edtPesquisar);
  End;
end;

procedure TfrmPermissaoAcesso.cxgTemPermissaoViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

class procedure TfrmPermissaoAcesso.EditarPermissoes(ADirAce: String);
Var
  LForm: TfrmPermissaoAcesso;
  LOpeLib: String;
begin
  If Not ValidarPermissaoParaEditar(LOpeLib) Then
    Exit;

  pCriarFormularios(TfrmPermissaoAcesso, LForm);
  Try
    LForm.strDireitoAcesso := ADirAce;
    LForm.blnSomenteSelecionar := True;
    LForm.BorderStyle := bsNone;
    LForm.Width := 0;
    LForm.Height := 0;
    LForm.OperadorLiberacaoAcesso := LOpeLib;
    LForm.ShowModal;
  Finally
    pFreeAndNil(LForm);
  End;
end;

procedure TfrmPermissaoAcesso.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmPermissaoAcesso.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmPermissaoAcesso.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmPermissaoAcesso.edtPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DOWN, VK_RETURN:
      Begin
        cxgTemPermissaoView.DataController.GotoFirst;
        pSetFocus(cxgTemPermissao);
      End;
  End;
end;

procedure TfrmPermissaoAcesso.FormActivate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Direitos de Acesso (AUTCOM)';
end;

procedure TfrmPermissaoAcesso.FormCreate(Sender: TObject);
begin
  inherited;
  FQryOperadores := fCriaQuery(Self);
  FQryGrupos := fCriaQuery(Self);
  FQryDirEsp := fCriaQuery(Self);
  cdsTemPermissao.CreateDataSet;
  blnSomenteExibir := False;
  blnClickSenLib   := True;
end;

procedure TfrmPermissaoAcesso.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      If btnCancelar.Visible Then
        btnCancelar.Click;
  End;
end;

procedure TfrmPermissaoAcesso.FormShow(Sender: TObject);
begin
  inherited;
  btnConfirmar.Visible := Not blnDocked;
  btnCancelar.Visible := Not blnDocked;

  If blnDocked Then
    btnAplicar.Align := alLeft;

  If Not blnDocked Then
    pSetFocus(edtPesquisar);

  If blnSomenteRemover Then
  Begin
    btnAplicar.Visible := False;
    btnAdicionar.Visible := False;
  End;

  If blnSomenteExibir Then
  Begin
    btnAplicar.Visible := False;
    btnAdicionar.Visible := False;
    btnRemover.Visible := False;
    lblRemoverTodos.Visible := False;
    btnConfirmar.Visible := False;
    btnCancelar.Caption := 'Fechar';
  End;

  tmrSomenteSelecionar.Enabled := blnSomenteSelecionar;
end;

{ TfrmPermissaoAcesso.TLiberarAcessoSubrotinas }

function TfrmPermissaoAcesso.TLiberarAcessoSubrotinas.Executar(pgbProgresso: TCxProgressBar): Boolean;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionar.Selecionado;
begin
  Result := False;
  Try
    fStartTransaction;

    FForm.lblAguarde := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));

    pgbProgresso.properties.Max := Length(FSelecionados);
    pgbProgresso.Position := 0;

    For LSelecionado In FSelecionados Do
    Begin
      If LSelecionado.Tipo.Equals('OPE') Then
      Begin
        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Liberando direitos de acesso Operador ' + LSelecionado.Descricao + ' ... ';

        FForm.AdicionarPermissaoUsuario(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckChild);
        FForm.AdicionarPermissaoUsuario(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckParent);
      End
      Else
      Begin
        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Liberando direitos de acesso Grupo ' + LSelecionado.Descricao + ' ... ';

        FForm.AdicionarPermissaoGrupo(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckChild);
        FForm.AdicionarPermissaoGrupo(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckParent);
      End;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := fCommit;

    pMensagemOk('Liberação de acesso realizada com sucesso!');
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, 'TfrmPermissaoAcesso.TLiberarAcessoSubrotinas.Executar');
    End;
  End;
end;

{ TfrmPermissaoAcesso.TRemoverAcessoSubrotinas }

function TfrmPermissaoAcesso.TRemoverAcessoSubrotinas.Executar(
  pgbProgresso: TCxProgressBar): Boolean;
Var
  LRemovido: TfrmPermissaoAcessoAdicionar.Selecionado;
begin
  Result := False;
  Try
    fStartTransaction;

    FForm.lblAguarde := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));

    pgbProgresso.properties.Max := Length(FRemovidos);
    pgbProgresso.Position := 0;

    For LRemovido In FRemovidos Do
    Begin
      If LRemovido.Tipo.Equals('OPE') Then
      Begin
        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Removendo direitos de acesso Operador ' + LRemovido.Descricao + ' ... ';

        FForm.RemoverPermissaoUsuario(FDirAce, LRemovido.Codigo, LRemovido.OpeSenLib, opCheckChild);
      End
      Else
      Begin
        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Removendo direitos de acesso Grupo ' + LRemovido.Descricao + ' ... ';

        FForm.RemoverPermissaoGrupo(FDirAce, LRemovido.Codigo, LRemovido.OpeSenLib, opCheckChild);
      End;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    Result := fCommit;

    pMensagemOk('Operação realizada com sucesso!');
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, 'TfrmPermissaoAcesso.TRemoverAcessoSubrotinas.Executar');
    End;
  End;
end;

function TfrmPermissaoAcesso.GetRemovidos: TArray<TfrmPermissaoAcessoAdicionar.Selecionado>;
begin
  SetLength(Result, 0);

  FQryOperadores.Close;
  FQryOperadores.Open;

  FQryGrupos.Close;
  FQryGrupos.Open;

  LimparFiltros;

  cdsTemPermissao.DisableControls;
  Try
    Self.FQryOperadores.First;
    While Not Self.FQryOperadores.Eof Do
    Begin
      If Not Self.cdsTemPermissao.Locate('tipo;codigo',
        VarArrayOf(['OPE', Self.FQryOperadores.FieldByName('OPE_CODOPE').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'OPE';
        Result[Length(Result)-1].Codigo := Self.FQryOperadores.FieldByName('OPE_CODOPE').AsString;
        Result[Length(Result)-1].Descricao := fRetNomVendRep(Self.FQryOperadores.FieldByName('OPE_CODOPE').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('DIR_OSNLIB').AsString;
      End;
      Self.FQryOperadores.Next;
    End;

    Self.FQryGrupos.First;
    While Not Self.FQryGrupos.Eof Do
    Begin
      If Not Self.cdsTemPermissao.Locate('tipo;codigo',
        VarArrayOf(['GRU', Self.FQryGrupos.FieldByName('GPO_CODGPO').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'GRU';
        Result[Length(Result)-1].Codigo := Self.FQryGrupos.FieldByName('GPO_CODGPO').AsString;
        Result[Length(Result)-1].Descricao := fRetNomCadGpo(Self.FQryGrupos.FieldByName('GPO_CODGPO').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('DIR_OSNLIB').AsString;
      End;
      Self.FQryGrupos.Next;
    End;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

end.
