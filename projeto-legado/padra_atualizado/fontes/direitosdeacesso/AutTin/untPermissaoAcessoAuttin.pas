unit untPermissaoAcessoAutTin;

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
  untPermissaoAcessoAdicionarAutTin, dxGDIPlusClasses, cxGroupBox, cxContainer,
  untTypesSistema, UniClientDataSet;

type
  TfrmPermissaoAcessoAutTin = class(TfrmPai)
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
  private
    { Private declarations }
    FDirAce: String;
    FDocked: Boolean;
    FSomenteSelec: Boolean;
    FSomenteRemover: Boolean;
    FLabelAguarde: TLabel;
    FQryOperadores: TUniQuery;
    FQryGrupos: TUniQuery;
    FAfterAplicar: TGenericProcedure;
    FblnSomenteExibir : Boolean;
    blnClickSenLib : Boolean;
  private
    function GetMenuDirAce(ADirAce: String): TMenuItem;
    function GetDescricaoDirAce(ADirAce: String): String;
    function GetRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
    function TemDireitosEspecificos(ADirAce: String): Boolean;
    Procedure pGravarDireitoAcessoMnuPrincipal(ADirAce: String; ACodOpe: String; ADirEsp: String; AOpeSenLib: String; ADirGpo: Boolean);
    function AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
    function fCaptionForm(sCaption: String; sDirAce: String): String;
    class function ValidarPermissaoParaEditar: Boolean;
  private type
    TAddDirAceOption = (opCheckParent, opCheckChild, opNone);
  private type
    TLiberarAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcessoAutTin;
      FSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
    public
      Procedure pGravarDireitoAcessoMnuPrincipal(ADirAce: String; ACodOpe: String; ADirEsp: String; AOpeSenLib: String; ADirGpo: Boolean);
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;
  private type
    TRemoverAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcessoAutTin;
      FRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
    public
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;
  private
    procedure AdicionarPermissaoUsuario(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure AdicionarPermissaoGrupo(ADirAce, ACodGpo, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure CarregarOperadoresComPermissao;
    procedure CarregarGruposComPermissao;
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

  end;

implementation

uses untfuncoesSimples, untPrincipal, untHighlightGrid, untConstantes,
  untModulo, untDicionarioResultadoQuerySimples, untFuncoesGenerica;

{$R *.dfm}
{ TfrmPermissaoAcessoAutTin }

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

  SQL_DELETE_DIRGPO = 'DELETE FROM DIRGPT WHERE DIR_NOMFRM = "%s" AND GPT_CODGPO = "%s";';
  SQL_DELETE_DIROPE = 'DELETE FROM DIRTIN WHERE TIN_NOMFRM = "%s" AND TIN_CODOPE = "%s";';

  SQL_REPLACE_DIRGPO = 'REPLACE INTO DIRGPT (DIR_NOMFRM, GPT_CODGPO, DIR_ACAOUS, DIR_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';
  SQL_REPLACE_DIROPE = 'REPLACE INTO DIRTIN (TIN_NOMFRM, TIN_CODOPE, TIN_ACAOUS, TIN_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';

function TfrmPermissaoAcessoAutTin.GetDescricaoDirAce(ADirAce: String): String;
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

function TfrmPermissaoAcessoAutTin.GetMenuDirAce(ADirAce: String): TMenuItem;
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

procedure TfrmPermissaoAcessoAutTin.lblRemoverTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(RemoverTodos, 'Removendo todos, Aguarde ...', '');
end;

class procedure TfrmPermissaoAcessoAutTin.LiberarAcessoSubrotinas(ADirAce: String);
Var
  LForm: TfrmPermissaoAcessoAutTin;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
  objLiberar: TLiberarAcessoSubrotinas;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcessoAutTin, LForm);
  Try
    LForm.strDireitoAcesso := IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce);

    LSelecionados := TfrmPermissaoAcessoAdicionarAutTin.Selecionar(LForm.fCaptionForm(LForm.lblDescricaoDireitoAcesso.Caption, LForm.strDireitoAcesso));

    If Length(LSelecionados) = 0 Then
      Exit;

    If fPergunta('Confirma liberação de acesso para "' + LForm.fCaptionForm(LForm.lblDescricaoDireitoAcesso.Caption, LForm.strDireitoAcesso) +
      '" e todos os seus subitens?') Then
    Begin
      objLiberar := TLiberarAcessoSubrotinas.Create;
      Try
        objLiberar.FForm := LForm;
        objLiberar.FDirAce := IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce);
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

procedure TfrmPermissaoAcessoAutTin.LimparFiltros;
begin
  rdgFiltro.ItemIndex := 2;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  cdsTemPermissao.Filtered := False;
end;

procedure TfrmPermissaoAcessoAutTin.lstDireitosEspecificosClickCheck(Sender: TObject);
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

Procedure TfrmPermissaoAcessoAutTin.pGravarDireitoAcessoMnuPrincipal(ADirAce: String; ACodOpe: String; ADirEsp: String; AOpeSenLib: String; ADirGpo: Boolean);
Var
  LQryGen: TUniQuery;
  LStrSQL: String;
begin
  Try
    LQryGen := fCriaQuery;

    If ADirGpo Then
      LStrSQL := '  SELECT * FROM DIRGPO WHERE DIR_NOMFRM = :NOMFRM AND GPO_CODGPO = :CODOPE '
    Else
      LStrSQL := '  SELECT * FROM DIROPE WHERE DIR_NOMFRM = :NOMFRM AND OPE_CODOPE = :CODOPE ';

    LQryGen.Close;
    LQryGen.SQL.Clear;
    LQryGen.SQL.Add(LStrSQL);
    LQryGen.ParamByName('NOMFRM').AsString := ADirAce;
    LQryGen.ParamByName('CODOPE').AsString := ACodOpe;
    LQryGen.Open;

    If LQryGen.IsEmpty Then
    Begin
      LQryGen.Insert;

      If ADirGpo Then
      Begin
        LQryGen.FieldByName('DIR_NOMFRM').AsString := ADirAce;
        LQryGen.FieldByName('GPO_CODGPO').AsString := ACodOpe;
        LQryGen.FieldByName('DIR_ACAOUS').AsString := ADirEsp;
        LQryGen.FieldByName('DIR_OSNLIB').AsString := AOpeSenLib;
      End
      Else
      Begin
        LQryGen.FieldByName('DIR_NOMFRM').AsString := ADirAce;
        LQryGen.FieldByName('OPE_CODOPE').AsString := ACodOpe;
        LQryGen.FieldByName('DIR_ACAOUS').AsString := ADirEsp;
        LQryGen.FieldByName('DIR_OSNLIB').AsString := AOpeSenLib;
      End;

      LQryGen.Post;
    End;

    FreeAndNil(LQryGen);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas.pGravarDireitoAcessoMnuPrincipal');
  End;
end;

procedure TfrmPermissaoAcessoAutTin.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

class procedure TfrmPermissaoAcessoAutTin.RemoverAcessoSubrotinas(ADirAce: String);
Var
  LForm: TfrmPermissaoAcessoAutTin;
  objRemover: TRemoverAcessoSubrotinas;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcessoAutTin, LForm);
  Try
    LForm.strDireitoAcesso := IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce);
    LForm.blnSomenteRemover := True;
    LForm.ShowModal;

    objRemover := TRemoverAcessoSubrotinas.Create;
    Try
      objRemover.FForm := LForm;
      objRemover.FDirAce := IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce);
      objRemover.FRemovidos := LForm.GetRemovidos;

      If Length(objRemover.FRemovidos) = 0 Then
        Exit;

      If Not fPergunta('Confirma remover acesso para "' + LForm.fCaptionForm(LForm.lblDescricaoDireitoAcesso.Caption, LForm.strDireitoAcesso) +
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

procedure TfrmPermissaoAcessoAutTin.RemoverPermissaoGrupo(ADirAce, ACodGpo, AOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
begin
  fExecutaSQL(Format(SQL_DELETE_DIRGPO, [IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodGpo]));
  frmModulo.pAddLogDir('DIRGPT', IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), '', 'DEL', AOpeSenLib, ACodGpo.ToInteger);

  LMenu := GetMenuDirAce(IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce));

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

procedure TfrmPermissaoAcessoAutTin.RemoverPermissaoUsuario(ADirAce, ACodOpe, AOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
begin
  If ADirAce.IsEmpty Then
    Exit;

  fExecutaSQL(Format(SQL_DELETE_DIROPE, [IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodOpe]));
  frmModulo.pAddLogDir('DIRTIN', IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodOpe, 'DEL', AOpeSenLib, 0);

  LMenu := GetMenuDirAce(IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce));

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

procedure TfrmPermissaoAcessoAutTin.RemoverTodos;
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

procedure TfrmPermissaoAcessoAutTin.SetDirAce(const Value: String);
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

function TfrmPermissaoAcessoAutTin.TemDireitosEspecificos(ADirAce: String): Boolean;
begin
  Result := False;
end;

procedure TfrmPermissaoAcessoAutTin.tmrPesquisarTimer(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutTin.tmrSomenteSelecionarTimer(Sender: TObject);
begin
  inherited;
  tmrSomenteSelecionar.Enabled := False;
  btnAdicionar.Click;
  btnConfirmar.Click;
end;

class function TfrmPermissaoAcessoAutTin.ValidarPermissaoParaEditar: Boolean;
Var
  LSenha: String;
begin
  If Not fVerificaAcessoSistema('frmDirAutTin') Then
  Begin
    If Not ffrmSenha(LSenha) Then
      Exit(False);

    If Not fVerificaAcessoSistema('frmDirAutTin', fRetCodVendedor(LSenha)) Then
      Exit(False);
  End;
  Result := True;
end;

procedure TfrmPermissaoAcessoAutTin.AdicionarPermissao(ATipo, ACodigo, ADescricao, AOpeSenLib: String);
begin
  If ATipo.IsEmpty Then
    Exit;

  If cdsTemPermissao.Locate('tipo;codigo', VarArrayOf([ATipo, ACodigo]), []) Then
    Exit;

  cdsTemPermissao.AppendRecord([ATipo, ACodigo, ADescricao, 'IAE', AOpeSenLib]);

  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutTin.AdicionarPermissaoGrupo(ADirAce, ACodGpo, ADirEsp, ADirOpeSenLib: String;
  AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
  LDireitos: String;
  LOpeSenLib: String;
  blnGravarAcesso: Boolean;
begin
  If ADirAce.IsEmpty Then
    Exit;

  blnGravarAcesso := Not (ADirAce = 'mnuPrincipal');


  If blnGravarAcesso Then
  Begin
    LDireitos := fCampoTabela('DIR_ACAOUS', 'DIRGPT', ['GPT_CODGPO', 'DIR_NOMFRM'], [ACodGpo, IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce)]);
    LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIRGPT', ['GPT_CODGPO', 'DIR_NOMFRM'], [ACodGpo, IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce)]);

    If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
    Begin
      fExecutaSQL(Format(SQL_REPLACE_DIRGPO, [IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodGpo, ADirEsp, ADirOpeSenLib]));
      frmModulo.pAddLogDir('DIRGPT', IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), '', ADirEsp, ADirOpeSenLib, ACodGpo.ToInteger);
    End;
  End;

  LMenu := GetMenuDirAce(IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce));

  Case AOption Of
    opCheckParent:
      If Assigned(LMenu.Parent) Then
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

procedure TfrmPermissaoAcessoAutTin.AdicionarPermissaoUsuario(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String;
  AOption: TAddDirAceOption);
Var
  I: Integer;
  LMenu: TMenuItem;
  LDireitos: String;
  LOpeSenLib : String;
  blnGravarAcesso: Boolean;
begin
  If ADirAce.IsEmpty Then
    Exit;

  blnGravarAcesso := Not (ADirAce = 'mnuPrincipal');

  If blnGravarAcesso Then
  Begin
    LDireitos := fCampoTabela('TIN_ACAOUS', 'DIRTIN', ['TIN_CODOPE', 'TIN_NOMFRM'], [ACodOpe, IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce)]);
    LOpeSenLib := fCampoTabela('TIN_OSNLIB', 'DIRTIN', ['TIN_CODOPE', 'TIN_NOMFRM'], [ACodOpe, IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce)]);

    If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
    Begin
      fExecutaSQL(Format(SQL_REPLACE_DIROPE, [IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodOpe, ADirEsp, ADirOpeSenLib]));
      frmModulo.pAddLogDir('DIRTIN',  IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce), ACodOpe, ADirEsp, ADirOpeSenLib, 0);
    End;
  End;

  LMenu := GetMenuDirAce(IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce));

  Case AOption Of
    opCheckParent:
      If Assigned(LMenu.Parent) Then
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

function TfrmPermissaoAcessoAutTin.AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
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

          pGravarDireitoAcessoMnuPrincipal('mnuPrincipal', cdsTemPermissaocodigo.AsString, cdsTemPermissaoespecificos.AsString, cdsTemPermissaoopesenlib.AsString, False);
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

          pGravarDireitoAcessoMnuPrincipal('mnuPrincipal', cdsTemPermissaocodigo.AsString, cdsTemPermissaoespecificos.AsString, cdsTemPermissaoopesenlib.AsString, True);
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
          VarArrayOf(['OPE', FQryOperadores.FieldByName('TIN_CODOPE').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Operador ' +
            fRetNomVendRep(FQryOperadores.FieldByName('TIN_CODOPE').AsString) + ' ... ';

          RemoverPermissaoUsuario(FDirAce, FQryOperadores.FieldByName('TIN_CODOPE').AsString, FQryOperadores.FieldByName('TIN_OSNLIB').AsString, opNone);
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
          VarArrayOf(['GRU', FQryGrupos.FieldByName('GPT_CODGPO').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Grupo ' +
            fRetNomCadGpo(FQryGrupos.FieldByName('GPT_CODGPO').AsString) + ' ... ';

          RemoverPermissaoGrupo(FDirAce, FQryGrupos.FieldByName('GPT_CODGPO').AsString, FQryGrupos.FieldByName('DIR_OSNLIB').AsString, opNone);
        End;

        Application.ProcessMessages;

        FQryGrupos.Next;
      End;

      Result := fCommit();
    Except
      On E: Exception Do
      Begin
        fRollback();
        pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutTin.AplicarAlteracoes');
      End;
    End;
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissao.Locate('codigo', LCodigo, []);
  End;

end;

procedure TfrmPermissaoAcessoAutTin.AtualizaCheckListDirEspecifico;
begin
  btnRemover.Enabled := Not cdsTemPermissao.IsEmpty;
  lstDireitosEspecificos.Checked[0] := cdsTemPermissaoespecificos.AsString.Contains('I');
  lstDireitosEspecificos.Checked[1] := cdsTemPermissaoespecificos.AsString.Contains('A');
  lstDireitosEspecificos.Checked[2] := cdsTemPermissaoespecificos.AsString.Contains('E');

  blnClickSenLib := False;
  chkSenLib.Checked := cdsTemPermissaoopesenlib.AsString.Equals('S');
  blnClickSenLib := True;
end;

procedure TfrmPermissaoAcessoAutTin.btnAdicionarClick(Sender: TObject);
begin
  If blnSomenteSelecionar Then
    Adicionar
  Else
    fExecutarModal(Adicionar, 'Selecionando usuários e grupos, Aguarde ...', '');
end;

procedure TfrmPermissaoAcessoAutTin.Adicionar;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutTin.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
begin
  inherited;
  LimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    LSelecionados := TfrmPermissaoAcessoAdicionarAutTin.Selecionar(Self.lblDescricaoDireitoAcesso.Caption,
      cdsTemPermissao, blnSomenteSelecionar);
    For LSelecionado In LSelecionados Do
      AdicionarPermissao(LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao, LSelecionado.OpeSenLib);
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissaoAfterScroll(cdsTemPermissao);
  End;
end;

procedure TfrmPermissaoAcessoAutTin.btnAplicarClick(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutTin.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Click;
  btnSair.Click;
end;

procedure TfrmPermissaoAcessoAutTin.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If Not cdsTemPermissao.IsEmpty Then
  Begin
    cdsTemPermissao.Delete;
    btnAplicar.Enabled := True;
  End;
end;

procedure TfrmPermissaoAcessoAutTin.CarregarGruposComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin
  FQryGrupos.Close;
  FQryGrupos.SQL.Text := 'SELECT * FROM DIRGPT WHERE DIR_NOMFRM = ' + FDirAce.QuotedString;
  FQryGrupos.Open;

  FQryGrupos.First;

  While Not FQryGrupos.Eof Do
  Begin
    LCodigo := FQryGrupos.FieldByName('GPT_CODGPO').AsString;
    LDirEsp := FQryGrupos.FieldByName('DIR_ACAOUS').AsString;
    LOpeSenLib := FQryGrupos.FieldByName('DIR_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['GRU', LCodigo, fRetNomCadGpo(LCodigo), LDirEsp, LOpeSenLib]);
    FQryGrupos.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcessoAutTin.CarregarOperadoresComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin

  FQryOperadores.Close;
  FQryOperadores.SQL.Clear;
  FQryOperadores.SQL.Add(' SELECT * FROM DIRTIN ');
  FQryOperadores.SQL.Add(' INNER JOIN CADOPE ON CADOPE.OPE_CODOPE = DIRTIN.TIN_CODOPE AND CADOPE.OPE_STATUS = "A" ');
  FQryOperadores.SQL.Add(' WHERE TIN_NOMFRM = ' + FDirAce.QuotedString );
  FQryOperadores.Open;

  FQryOperadores.First;

  While Not FQryOperadores.Eof Do
  Begin
    LCodigo := FQryOperadores.FieldByName('TIN_CODOPE').AsString;
    LDirEsp := FQryOperadores.FieldByName('TIN_ACAOUS').AsString;
    LOpeSenLib := FQryOperadores.FieldByName('TIN_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['OPE', LCodigo, fRetNomVendRep(LCodigo), LDirEsp, LOpeSenLib]);
    FQryOperadores.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcessoAutTin.cdsTemPermissaoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If Not cdsTemPermissao.ControlsDisabled Then
    AtualizaCheckListDirEspecifico;
end;

procedure TfrmPermissaoAcessoAutTin.cdsTemPermissaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
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

procedure TfrmPermissaoAcessoAutTin.chkOpeSenLibClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutTin.chkSenLibClick(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutTin.cxgTemPermissaoViewCustomDrawCell(Sender: TcxCustomGridTableView;
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

procedure TfrmPermissaoAcessoAutTin.cxgTemPermissaoViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmPermissaoAcessoAutTin.cxgTemPermissaoViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

class procedure TfrmPermissaoAcessoAutTin.EditarPermissoes(ADirAce: String);
Var
  LForm: TfrmPermissaoAcessoAutTin;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  pCriarFormularios(TfrmPermissaoAcessoAutTin, LForm);
  Try
    LForm.strDireitoAcesso := IIF(ADirAce = 'frmConfGerais', 'frmConfTintaMaquina', ADirAce);
    LForm.blnSomenteSelecionar := True;
    LForm.BorderStyle := bsNone;
    LForm.Width := 0;
    LForm.Height := 0;
    LForm.ShowModal;
  Finally
    pFreeAndNil(LForm);
  End;
end;

procedure TfrmPermissaoAcessoAutTin.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutTin.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmPermissaoAcessoAutTin.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmPermissaoAcessoAutTin.edtPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmPermissaoAcessoAutTin.fCaptionForm(sCaption,
  sDirAce: String): String;
begin
  Result := sCaption;

  If Result.IsEmpty Then
  Begin
    If sDirAce = 'frmConfGerais' Then
      Result := 'Configurações Gerais';
  End;
end;

procedure TfrmPermissaoAcessoAutTin.FormActivate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Direitos de Acesso (AUTTIN)';
end;

procedure TfrmPermissaoAcessoAutTin.FormCreate(Sender: TObject);
begin
  inherited;
  FQryOperadores := fCriaQuery(Self);
  FQryGrupos := fCriaQuery(Self);
  cdsTemPermissao.CreateDataSet;
  blnSomenteExibir := False;
  blnClickSenLib   := True;
end;

procedure TfrmPermissaoAcessoAutTin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      If btnCancelar.Visible Then
        btnCancelar.Click;
  End;
end;

procedure TfrmPermissaoAcessoAutTin.FormShow(Sender: TObject);
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

{ TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas }

function TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas.Executar(pgbProgresso: TCxProgressBar): Boolean;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutTin.Selecionado;
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

        pGravarDireitoAcessoMnuPrincipal('mnuPrincipal', LSelecionado.Codigo, 'IAE', 'S', False);
        FForm.AdicionarPermissaoUsuario(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckChild);
        FForm.AdicionarPermissaoUsuario(FDirAce, LSelecionado.Codigo, 'IAE', 'S', opCheckParent);
      End
      Else
      Begin
        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Liberando direitos de acesso Grupo ' + LSelecionado.Descricao + ' ... ';

        pGravarDireitoAcessoMnuPrincipal('mnuPrincipal', LSelecionado.Codigo, 'IAE', 'S', True);
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
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas.Executar');
    End;
  End;
end;

Procedure TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas.pGravarDireitoAcessoMnuPrincipal(ADirAce: String; ACodOpe: String; ADirEsp: String; AOpeSenLib: String; ADirGpo: Boolean);
Var
  LQryGen: TUniQuery;
  LStrSQL: String;
begin
  Try
    LQryGen := fCriaQuery;

    If ADirGpo Then
      LStrSQL := '  SELECT * FROM DIRGPO WHERE DIR_NOMFRM = :NOMFRM AND GPO_CODGPO = :CODOPE '
    Else
      LStrSQL := '  SELECT * FROM DIROPE WHERE DIR_NOMFRM = :NOMFRM AND OPE_CODOPE = :CODOPE ';

    LQryGen.Close;
    LQryGen.SQL.Clear;
    LQryGen.SQL.Add(LStrSQL);
    LQryGen.ParamByName('NOMFRM').AsString := ADirAce;
    LQryGen.ParamByName('CODOPE').AsString := ACodOpe;
    LQryGen.Open;

    If LQryGen.IsEmpty Then
    Begin
      LQryGen.Insert;

      If ADirGpo Then
      Begin
        LQryGen.FieldByName('DIR_NOMFRM').AsString := ADirAce;
        LQryGen.FieldByName('GPO_CODGPO').AsString := ACodOpe;
        LQryGen.FieldByName('DIR_ACAOUS').AsString := ADirEsp;
        LQryGen.FieldByName('DIR_OSNLIB').AsString := AOpeSenLib;
      End
      Else
      Begin
        LQryGen.FieldByName('DIR_NOMFRM').AsString := ADirAce;
        LQryGen.FieldByName('OPE_CODOPE').AsString := ACodOpe;
        LQryGen.FieldByName('DIR_ACAOUS').AsString := ADirEsp;
        LQryGen.FieldByName('DIR_OSNLIB').AsString := AOpeSenLib;
      End;

      LQryGen.Post;
    End;

    FreeAndNil(LQryGen);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutTin.TLiberarAcessoSubrotinas.pGravarDireitoAcessoMnuPrincipal');
  End;
end;

{ TfrmPermissaoAcessoAutTin.TRemoverAcessoSubrotinas }

function TfrmPermissaoAcessoAutTin.TRemoverAcessoSubrotinas.Executar(
  pgbProgresso: TCxProgressBar): Boolean;
Var
  LRemovido: TfrmPermissaoAcessoAdicionarAutTin.Selecionado;
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
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutTin.TRemoverAcessoSubrotinas.Executar');
    End;
  End;
end;

function TfrmPermissaoAcessoAutTin.GetRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutTin.Selecionado>;
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
        VarArrayOf(['OPE', Self.FQryOperadores.FieldByName('TIN_CODOPE').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'OPE';
        Result[Length(Result)-1].Codigo := Self.FQryOperadores.FieldByName('TIN_CODOPE').AsString;
        Result[Length(Result)-1].Descricao := fRetNomVendRep(Self.FQryOperadores.FieldByName('TIN_CODOPE').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('TIN_OSNLIB').AsString;
      End;
      Self.FQryOperadores.Next;
    End;

    Self.FQryGrupos.First;
    While Not Self.FQryGrupos.Eof Do
    Begin
      If Not Self.cdsTemPermissao.Locate('tipo;codigo',
        VarArrayOf(['GRU', Self.FQryGrupos.FieldByName('GPT_CODGPO').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'GRU';
        Result[Length(Result)-1].Codigo := Self.FQryGrupos.FieldByName('GPT_CODGPO').AsString;
        Result[Length(Result)-1].Descricao := fRetNomCadGpo(Self.FQryGrupos.FieldByName('GPT_CODGPO').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('TIN_OSNLIB').AsString;
      End;
      Self.FQryGrupos.Next;
    End;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

end.
