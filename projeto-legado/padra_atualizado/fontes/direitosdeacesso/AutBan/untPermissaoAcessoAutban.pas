unit untPermissaoAcessoAutban;

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
  untPermissaoAcessoAdicionarAutban, dxGDIPlusClasses, cxGroupBox, cxContainer,
  untTypesSistema, UniClientDataSet;

type
  TfrmPermissaoAcessoAutban = class(TfrmPai)
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
    trvAutBan: TTreeView;
    FDireitosAcessos: TStringList;
  private
    function GetDescricaoDirAce(ADirAce: String): String;
    function GetRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
    function TemDireitosEspecificos(ADirAce: String): Boolean;
    function AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
    function fCaptionForm(sCaption: String; sDirAce: String): String;
    class function ValidarPermissaoParaEditar: Boolean;
  private type
    TAddDirAceOption = (opCheckParent, opCheckChild, opNone);

  private type
    TLiberarAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcessoAutban;
      FSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
      MnuAutBan: TTreeView;
      DireitoAcesso: TStringList;
    public
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;

  private type
    TRemoverAcessoSubrotinas = class
    public
      FDirAce: String;
      FForm: TfrmPermissaoAcessoAutban;
      FRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
      MnuAutBan: TTreeView;
      DireitoAcesso: TStringList;
    public
      function Executar(pgbProgresso: TCxProgressBar): Boolean;
    end;

  private
    Procedure AdicionarPermissaoUsuario(LMenu: TTreeNode; ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure AdicionarDireitoAcessoOperador(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String);
    procedure AdicionarPermissaoGrupo(LMenu: TTreeNode; ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    procedure AdicionarDireitoAcessoGrupo(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String);
    procedure CarregarOperadoresComPermissao;
    procedure CarregarGruposComPermissao;
    procedure RemoverPermissaoUsuario(LMenu: TTreeNode; ACodOpe, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    Procedure RemoverDireitoAcessoOperador(ADirAce, ACodOpe, AOpeSenLib: String);
    procedure RemoverPermissaoGrupo(LMenu: TTreeNode; ACodOpe, ADirOpeSenLib: String; AOption: TAddDirAceOption);
    Procedure RemoverDireitoAcessoGrupo(ADirAce, ACodGpo, AOpeSenLib: String);
    procedure AdicionarPermissao(ATipo, ACodigo, ADescricao, AOpeSenLib: String);
    procedure Adicionar;
    procedure LimparFiltros;
    procedure RemoverTodos;
    procedure SetDirAce(const Value: String);
    procedure AtualizaCheckListDirEspecifico;
  public
    { Public declarations }
    class procedure EditarPermissoes(ADirAce: String);
    class procedure LiberarAcessoSubrotinas(ADirAce: String; Menu: TTreeView; FDireitoAcesso: TStringList);
    class procedure RemoverAcessoSubrotinas(ADirAce: String; Menu: TTreeView; FDireitoAcesso: TStringList);
    property strDireitoAcesso: String Read FDirAce write SetDirAce;
    property blnSomenteSelecionar: Boolean Read FSomenteSelec write FSomenteSelec;
    property blnSomenteRemover: Boolean Read FSomenteRemover write FSomenteRemover;
    property blnDocked: Boolean Read FDocked write FDocked;
    property lblAguarde: TLabel Read FLabelAguarde write FLabelAguarde;
    property AfterAplicar: TGenericProcedure Read FAfterAplicar Write FAfterAplicar;
    property blnSomenteExibir : Boolean read FblnSomenteExibir write FblnSomenteExibir;
    property MnuAutBan: TTreeView Read trvAutBan Write trvAutBan;
    Property DireitoAcesso: TStringList Read FDireitosAcessos Write FDireitosAcessos;
  end;

implementation

uses untfuncoesSimples, untPrincipal, untHighlightGrid, untConstantes,
  untModulo, untDicionarioResultadoQuerySimples, untFuncoesGenerica;

{$R *.dfm}
{ TfrmPermissaoAcessoAutban }

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

  SQL_DELETE_DIRGPO = 'DELETE FROM DIRGPB WHERE DIR_NOMFRM = "%s" AND GPB_CODGPO = "%s";';
  SQL_DELETE_DIROPE = 'DELETE FROM DIRBAN WHERE BAN_NOMFRM = "%s" AND BAN_CODOPE = "%s";';

  SQL_REPLACE_DIRGPO = 'REPLACE INTO DIRGPB (DIR_NOMFRM, GPB_CODGPO, DIR_ACAOUS, DIR_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';
  SQL_REPLACE_DIROPE = 'REPLACE INTO DIRBAN (BAN_NOMFRM, BAN_CODOPE, BAN_ACAOUS, BAN_OSNLIB) VALUES ("%s", "%s", "%s", "%s");';

function TfrmPermissaoAcessoAutban.GetDescricaoDirAce(ADirAce: String): String;
Var
  iIndex: Integer;
  AValue: String;
begin
  iIndex := MnuAutBan.Selected.AbsoluteIndex;
  AValue := Trim(MnuAutBan.Items[iIndex].Text);
  Result := AValue;
end;

procedure TfrmPermissaoAcessoAutban.lblRemoverTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(RemoverTodos, 'Removendo todos, Aguarde ...', '');
end;

class procedure TfrmPermissaoAcessoAutban.LiberarAcessoSubrotinas(ADirAce: String; Menu: TTreeView; FDireitoAcesso: TStringList);
Var
  LForm: TfrmPermissaoAcessoAutban;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
  objLiberar: TLiberarAcessoSubrotinas;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcessoAutban, LForm);
  Try
    LForm.MnuAutBan := Menu;
    LForm.DireitoAcesso := FDireitoAcesso;
    LForm.strDireitoAcesso :=  ADirAce;

    LSelecionados := TfrmPermissaoAcessoAdicionarAutban.Selecionar(LForm.fCaptionForm(LForm.lblDescricaoDireitoAcesso.Caption, LForm.strDireitoAcesso));

    If Length(LSelecionados) = 0 Then
      Exit;

    If fPergunta('Confirma liberação de acesso para "' + LForm.fCaptionForm(LForm.lblDescricaoDireitoAcesso.Caption, LForm.strDireitoAcesso) +
      '" e todos os seus subitens?') Then
    Begin
      objLiberar := TLiberarAcessoSubrotinas.Create;
      Try
        objLiberar.FForm := LForm;
        objLiberar.FDirAce := ADirAce;
        objLiberar.FSelecionados := LSelecionados;
        objLiberar.MnuAutBan := Menu;
        objLiberar.DireitoAcesso := FDireitoAcesso;
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

procedure TfrmPermissaoAcessoAutban.LimparFiltros;
begin
  rdgFiltro.ItemIndex := 2;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  cdsTemPermissao.Filtered := False;
end;

procedure TfrmPermissaoAcessoAutban.lstDireitosEspecificosClickCheck(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutban.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

class procedure TfrmPermissaoAcessoAutban.RemoverAcessoSubrotinas(ADirAce: String; Menu: TTreeView; FDireitoAcesso: TStringList);
Var
  LForm: TfrmPermissaoAcessoAutban;
  objRemover: TRemoverAcessoSubrotinas;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  TLimparCaches.Execute;

  pCriarFormularios(TfrmPermissaoAcessoAutban, LForm);
  Try
    LForm.MnuAutBan := Menu;
    LForm.DireitoAcesso := FDireitoAcesso;
    LForm.strDireitoAcesso := ADirAce;
    LForm.blnSomenteRemover := True;
    LForm.ShowModal;

    objRemover := TRemoverAcessoSubrotinas.Create;
    Try
      objRemover.FForm := LForm;
      objRemover.FDirAce := ADirAce;
      objRemover.MnuAutBan := Menu;
      objRemover.DireitoAcesso := FDireitoAcesso;
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

procedure TfrmPermissaoAcessoAutban.RemoverDireitoAcessoGrupo(ADirAce, ACodGpo, AOpeSenLib: String);
begin
  fExecutaSQL(Format(SQL_DELETE_DIRGPO, [ADirAce, ACodGpo]));
  frmModulo.pAddLogDir('DIRGPB', ADirAce, '', 'DEL', AOpeSenLib, ACodGpo.ToInteger);

  If Assigned(lblAguarde) Then
    lblAguarde.Caption := 'Removendo direitos de acesso grupo ' + fRetNomCadGpo(ACodGpo) + #13#10 +
      LeftStr(ADirAce, 150) + ' ...';

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.RemoverDireitoAcessoOperador(ADirAce, ACodOpe, AOpeSenLib: String);
begin
  If ADirAce.IsEmpty Then
    Exit;

  fExecutaSQL(Format(SQL_DELETE_DIROPE, [ADirAce, ACodOpe]));
  frmModulo.pAddLogDir('DIRBAN', ADirAce, ACodOpe, 'DEL', AOpeSenLib, -1);

  If Assigned(lblAguarde) Then
    lblAguarde.Caption := 'Removendo direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
      LeftStr(ADirAce, 150) + ' ...';

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.RemoverPermissaoGrupo(LMenu: TTreeNode; ACodOpe, ADirOpeSenLib: String; AOption: TAddDirAceOption);
Var
  NoFilho: TTreeNode;
  AForm: String;
  I: Integer;
begin
  If LMenu.HasChildren Then
  Begin
    For I := 0 To LMenu.Count - 1 Do
    Begin
      NoFilho := LMenu.Item[I];
      AForm := DireitoAcesso[NoFilho.AbsoluteIndex];

      fExecutaSQL(Format(SQL_DELETE_DIRGPO, [AForm, ACodOpe]));
      frmModulo.pAddLogDir('DIRGPB', AForm, '', 'DEL', ADirOpeSenLib, ACodOpe.ToInteger);

      If Assigned(lblAguarde) Then
        lblAguarde.Caption := 'Removendo direitos de acesso grupo ' + fRetNomCadGpo(ACodOpe) + #13#10 +
          LeftStr(LMenu.Item[I].Text, 150) + ' ...';

      If NoFilho.HasChildren Then
        RemoverPermissaoGrupo(NoFilho, ACodOpe, ADirOpeSenLib, AOption);
    End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.RemoverPermissaoUsuario(LMenu: TTreeNode; ACodOpe, ADirOpeSenLib: String; AOption: TAddDirAceOption);
Var
  NoFilho: TTreeNode;
  AForm: String;
  I: Integer;
begin
  If LMenu.HasChildren Then
  Begin
    For I := 0 To LMenu.Count - 1 Do
    Begin
      NoFilho := LMenu.Item[I];
      AForm := DireitoAcesso[NoFilho.AbsoluteIndex];

      fExecutaSQL(Format(SQL_DELETE_DIROPE, [AForm, ACodOpe]));
      frmModulo.pAddLogDir('DIRBAN', AForm, ACodOpe, 'DEL', ADirOpeSenLib, -1);

      If Assigned(lblAguarde) Then
        lblAguarde.Caption := 'Removendo direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
          LeftStr(LMenu.Item[I].Text, 150) + ' ...';

      If NoFilho.HasChildren Then
        RemoverPermissaoUsuario(NoFilho, ACodOpe, ADirOpeSenLib, AOption);
    End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.RemoverTodos;
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

procedure TfrmPermissaoAcessoAutban.SetDirAce(const Value: String);
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

function TfrmPermissaoAcessoAutban.TemDireitosEspecificos(ADirAce: String): Boolean;
begin
  Result := False;
end;

procedure TfrmPermissaoAcessoAutban.tmrPesquisarTimer(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutban.tmrSomenteSelecionarTimer(Sender: TObject);
begin
  inherited;
  tmrSomenteSelecionar.Enabled := False;
  btnAdicionar.Click;
  btnConfirmar.Click;
end;

class function TfrmPermissaoAcessoAutban.ValidarPermissaoParaEditar: Boolean;
Var
  LSenha: String;
begin
  If Not fVerificaAcessoSistema('frmDirAutban') Then
  Begin
    If Not ffrmSenha(LSenha) Then
      Exit(False);

    If Not fVerificaAcessoSistema('frmDirAutban', fRetCodVendedor(LSenha)) Then
      Exit(False);
  End;
  Result := True;
end;

procedure TfrmPermissaoAcessoAutban.AdicionarDireitoAcessoGrupo(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String);
Var
  LDireitos: String;
  LOpeSenLib : String;
begin
  If ADirAce.IsEmpty Then
    Exit;

  LDireitos := fCampoTabela('DIR_ACAOUS', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [ACodOpe, ADirAce]);
  LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [ACodOpe, ADirAce]);

  If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
  Begin
    fExecutaSQL(Format(SQL_REPLACE_DIRGPO, [ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib]));
    frmModulo.pAddLogDir('DIRGPB', ADirAce, '', ADirEsp, ADirOpeSenLib, ACodOpe.ToInteger);
  End;

  If Assigned(lblAguarde) Then
    lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomCadGpo(ACodOpe) + #13#10 +
     LeftStr(ADirAce, 150) + ' ...';

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.AdicionarDireitoAcessoOperador(ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib: String);
Var
  LDireitos: String;
  LOpeSenLib : String;
begin
  If ADirAce.IsEmpty Then
    Exit;

  LDireitos := fCampoTabela('BAN_ACAOUS', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [ACodOpe, ADirAce]);
  LOpeSenLib := fCampoTabela('BAN_OSNLIB', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [ACodOpe, ADirAce]);

  If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
  Begin
    fExecutaSQL(Format(SQL_REPLACE_DIROPE, [ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib]));
    frmModulo.pAddLogDir('DIRBAN', ADirAce, ACodOpe, ADirEsp, ADirOpeSenLib, -1);
  End;

  If Assigned(lblAguarde) Then
    lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
     LeftStr(ADirAce, 150) + ' ...';

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.AdicionarPermissao(ATipo, ACodigo, ADescricao, AOpeSenLib: String);
begin
  If ATipo.IsEmpty Then
    Exit;

  If cdsTemPermissao.Locate('tipo;codigo', VarArrayOf([ATipo, ACodigo]), []) Then
    Exit;

  cdsTemPermissao.AppendRecord([ATipo, ACodigo, ADescricao, 'IAE', AOpeSenLib]);

  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutban.AdicionarPermissaoGrupo(LMenu: TTreeNode; ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LDireitos: String;
  LOpeSenLib : String;
  NoFilho: TTreeNode;
  AForm: String;
begin
  If LMenu.HasChildren Then
  Begin
    For I := 0 To LMenu.Count - 1 Do
    Begin
      NoFilho := LMenu.Item[I];
      AForm := DireitoAcesso[NoFilho.AbsoluteIndex];

      LDireitos := fCampoTabela('DIR_ACAOUS', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [ACodOpe, AForm]);
      LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [ACodOpe, AForm]);

      If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
      Begin
        fExecutaSQL(Format(SQL_REPLACE_DIRGPO, [AForm, ACodOpe, ADirEsp, ADirOpeSenLib]));
        frmModulo.pAddLogDir('DIRGPB', AForm, '', ADirEsp, ADirOpeSenLib, ACodOpe.ToInteger);
      End;

      If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomCadGpo(ACodOpe) + #13#10 +
            LeftStr(LMenu.Item[I].Text, 150) + ' ...';

      If NoFilho.HasChildren Then
        AdicionarPermissaoGrupo(NoFilho, ACodOpe, ADirEsp, ADirOpeSenLib, AOption);
    End;
  End;

  Application.ProcessMessages;
end;

procedure TfrmPermissaoAcessoAutban.AdicionarPermissaoUsuario(LMenu: TTreeNode; ACodOpe, ADirEsp, ADirOpeSenLib: String; AOption: TAddDirAceOption);
Var
  I: Integer;
  LDireitos: String;
  LOpeSenLib : String;
  NoFilho: TTreeNode;
  AForm: String;
begin
  If LMenu.HasChildren Then
  Begin
    For I := 0 To LMenu.Count - 1 Do
    Begin
      NoFilho := LMenu.Item[I];
      AForm := DireitoAcesso[NoFilho.AbsoluteIndex];

      LDireitos := fCampoTabela('BAN_ACAOUS', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [ACodOpe, AForm]);
      LOpeSenLib := fCampoTabela('BAN_OSNLIB', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [ACodOpe, AForm]);

      If (Not LDireitos.Equals(ADirEsp)) Or (Not LOpeSenLib.Equals(ADirOpeSenLib)) Then
      Begin
        fExecutaSQL(Format(SQL_REPLACE_DIROPE, [AForm, ACodOpe, ADirEsp, ADirOpeSenLib]));
        frmModulo.pAddLogDir('DIRBAN', AForm, ACodOpe, ADirEsp, ADirOpeSenLib, -1);
      End;

      If Assigned(lblAguarde) Then
          lblAguarde.Caption := 'Liberando direitos de acesso Operador ' + fRetNomVendRep(ACodOpe) + #13#10 +
            LeftStr(LMenu.Item[I].Text, 150) + ' ...';

      If NoFilho.HasChildren Then
        AdicionarPermissaoUsuario(NoFilho, ACodOpe, ADirEsp, ADirOpeSenLib, AOption);
    End;
  End;

  Application.ProcessMessages;
end;

function TfrmPermissaoAcessoAutban.AplicarAlteracoes(pgbProgresso: TCxProgressBar): Boolean;
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

          AdicionarDireitoAcessoOperador(FDirAce,
                                         cdsTemPermissaocodigo.AsString,
                                         cdsTemPermissaoespecificos.AsString,
                                         cdsTemPermissaoopesenlib.AsString);
        End;

        If cdsTemPermissaotipo.AsString = 'GRU' Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Liberando direitos de acesso Grupo ' +
            cdsTemPermissaodescricao.AsString + ' ... ';

          AdicionarDireitoAcessoGrupo(FDirAce,
                                         cdsTemPermissaocodigo.AsString,
                                         cdsTemPermissaoespecificos.AsString,
                                         cdsTemPermissaoopesenlib.AsString);
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
          VarArrayOf(['OPE', FQryOperadores.FieldByName('BAN_CODOPE').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Operador ' +
            fRetNomVendRep(FQryOperadores.FieldByName('BAN_CODOPE').AsString) + ' ... ';

          RemoverDireitoAcessoOperador(FDirAce, FQryOperadores.FieldByName('BAN_CODOPE').AsString, FQryOperadores.FieldByName('BAN_OSNLIB').AsString);
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
          VarArrayOf(['GRU', FQryGrupos.FieldByName('GPB_CODGPO').AsString]), []) Then
        Begin
          TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption :=
            lblDescricaoDireitoAcesso.Caption + #13#10 + 'Removendo direitos de acesso Grupo ' +
            fRetNomCadGpo(FQryGrupos.FieldByName('GPB_CODGPO').AsString) + ' ... ';

          RemoverDireitoAcessoGrupo(FDirAce, FQryGrupos.FieldByName('GPB_CODGPO').AsString, FQryGrupos.FieldByName('DIR_OSNLIB').AsString);
        End;

        Application.ProcessMessages;

        FQryGrupos.Next;
      End;

      Result := fCommit();
    Except
      On E: Exception Do
      Begin
        fRollback();
        pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutban.AplicarAlteracoes');
      End;
    End;
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissao.Locate('codigo', LCodigo, []);
  End;

end;

procedure TfrmPermissaoAcessoAutban.AtualizaCheckListDirEspecifico;
begin
  btnRemover.Enabled := Not cdsTemPermissao.IsEmpty;
  lstDireitosEspecificos.Checked[0] := cdsTemPermissaoespecificos.AsString.Contains('I');
  lstDireitosEspecificos.Checked[1] := cdsTemPermissaoespecificos.AsString.Contains('A');
  lstDireitosEspecificos.Checked[2] := cdsTemPermissaoespecificos.AsString.Contains('E');

  blnClickSenLib := False;
  chkSenLib.Checked := cdsTemPermissaoopesenlib.AsString.Equals('S');
  blnClickSenLib := True;
end;

procedure TfrmPermissaoAcessoAutban.btnAdicionarClick(Sender: TObject);
begin
  If blnSomenteSelecionar Then
    Adicionar
  Else
    fExecutarModal(Adicionar, 'Selecionando usuários e grupos, Aguarde ...', '');
end;

procedure TfrmPermissaoAcessoAutban.Adicionar;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutban.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
begin
  inherited;
  LimparFiltros;
  cdsTemPermissao.DisableControls;
  Try
    LSelecionados := TfrmPermissaoAcessoAdicionarAutban.Selecionar(Self.lblDescricaoDireitoAcesso.Caption,
      cdsTemPermissao, blnSomenteSelecionar);
    For LSelecionado In LSelecionados Do
      AdicionarPermissao(LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao, LSelecionado.OpeSenLib);
  Finally
    cdsTemPermissao.EnableControls;
    cdsTemPermissaoAfterScroll(cdsTemPermissao);
  End;
end;

procedure TfrmPermissaoAcessoAutban.btnAplicarClick(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutban.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Click;
  btnSair.Click;
end;

procedure TfrmPermissaoAcessoAutban.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If Not cdsTemPermissao.IsEmpty Then
  Begin
    cdsTemPermissao.Delete;
    btnAplicar.Enabled := True;
  End;
end;

procedure TfrmPermissaoAcessoAutban.CarregarGruposComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin
  FQryGrupos.Close;
  FQryGrupos.SQL.Text := 'SELECT * FROM DIRGPB WHERE DIR_NOMFRM = ' + FDirAce.QuotedString;
  FQryGrupos.Open;

  FQryGrupos.First;

  While Not FQryGrupos.Eof Do
  Begin
    LCodigo := FQryGrupos.FieldByName('GPB_CODGPO').AsString;
    LDirEsp := FQryGrupos.FieldByName('DIR_ACAOUS').AsString;
    LOpeSenLib := FQryGrupos.FieldByName('DIR_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['GRU', LCodigo, fRetNomCadGpo(LCodigo), LDirEsp, LOpeSenLib]);
    FQryGrupos.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcessoAutban.CarregarOperadoresComPermissao;
Var
  LCodigo: String;
  LDirEsp: String;
  LOpeSenLib : String;
begin
  FQryOperadores.Close;
  FQryOperadores.SQL.Clear;
  FQryOperadores.SQL.Add(' SELECT * FROM DIRBAN ');
  FQryOperadores.SQL.Add(' INNER JOIN CADOPE ON CADOPE.OPE_CODOPE = DIRBAN.BAN_CODOPE AND CADOPE.OPE_STATUS = "A" ');
  FQryOperadores.SQL.Add(' WHERE BAN_NOMFRM = ' + FDirAce.QuotedString );
  FQryOperadores.Open;

  FQryOperadores.First;

  While Not FQryOperadores.Eof Do
  Begin
    LCodigo := FQryOperadores.FieldByName('BAN_CODOPE').AsString;
    LDirEsp := FQryOperadores.FieldByName('BAN_ACAOUS').AsString;
    LOpeSenLib := FQryOperadores.FieldByName('BAN_OSNLIB').AsString;
    cdsTemPermissao.AppendRecord(['OPE', LCodigo, fRetNomVendRep(LCodigo), LDirEsp, LOpeSenLib]);
    FQryOperadores.Next;
  End;

  cdsTemPermissao.First;
end;

procedure TfrmPermissaoAcessoAutban.cdsTemPermissaoAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If Not cdsTemPermissao.ControlsDisabled Then
    AtualizaCheckListDirEspecifico;
end;

procedure TfrmPermissaoAcessoAutban.cdsTemPermissaoFilterRecord(DataSet: TDataSet; var Accept: Boolean);
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

procedure TfrmPermissaoAcessoAutban.chkOpeSenLibClick(Sender: TObject);
begin
  inherited;
  btnAplicar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutban.chkSenLibClick(Sender: TObject);
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

procedure TfrmPermissaoAcessoAutban.cxgTemPermissaoViewCustomDrawCell(Sender: TcxCustomGridTableView;
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

procedure TfrmPermissaoAcessoAutban.cxgTemPermissaoViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmPermissaoAcessoAutban.cxgTemPermissaoViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
  ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

class procedure TfrmPermissaoAcessoAutban.EditarPermissoes(ADirAce: String);
Var
  LForm: TfrmPermissaoAcessoAutban;
begin
  If Not ValidarPermissaoParaEditar Then
    Exit;

  pCriarFormularios(TfrmPermissaoAcessoAutban, LForm);
  Try
    LForm.strDireitoAcesso := ADirAce;
    LForm.blnSomenteSelecionar := True;
    LForm.BorderStyle := bsNone;
    LForm.Width := 0;
    LForm.Height := 0;
    LForm.ShowModal;
  Finally
    pFreeAndNil(LForm);
  End;
end;

procedure TfrmPermissaoAcessoAutban.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAutban.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmPermissaoAcessoAutban.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmPermissaoAcessoAutban.edtPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

function TfrmPermissaoAcessoAutban.fCaptionForm(sCaption,
  sDirAce: String): String;
begin
  Result := sCaption;

  If Result.IsEmpty Then
  Begin
    If sDirAce = 'frmConfGerais' Then
      Result := 'Configurações Gerais';
  End;
end;

procedure TfrmPermissaoAcessoAutban.FormActivate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Direitos de Acesso (Autban)';
end;

procedure TfrmPermissaoAcessoAutban.FormCreate(Sender: TObject);
begin
  inherited;
  FQryOperadores := fCriaQuery(Self);
  FQryGrupos := fCriaQuery(Self);
  cdsTemPermissao.CreateDataSet;
  blnSomenteExibir := False;
  blnClickSenLib   := True;
end;

procedure TfrmPermissaoAcessoAutban.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      If btnCancelar.Visible Then
        btnCancelar.Click;
  End;
end;

procedure TfrmPermissaoAcessoAutban.FormShow(Sender: TObject);
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

{ TfrmPermissaoAcessoAutban.TLiberarAcessoSubrotinas }

function TfrmPermissaoAcessoAutban.TLiberarAcessoSubrotinas.Executar(pgbProgresso: TCxProgressBar): Boolean;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutban.Selecionado;
  LDireitos: String;
  LOpeSenLib : String;
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
        LDireitos := fCampoTabela('BAN_ACAOUS', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [LSelecionado.Codigo, FDirAce]);
        LOpeSenLib := fCampoTabela('BAN_OSNLIB', 'DIRBAN', ['BAN_CODOPE', 'BAN_NOMFRM'], [LSelecionado.Codigo, FDirAce]);

        If (Not LDireitos.Equals('IAE')) Or (Not LOpeSenLib.Equals('S')) Then
        Begin
          fExecutaSQL(Format(SQL_REPLACE_DIROPE, [FDirAce, LSelecionado.Codigo, 'IAE', 'S']));
          frmModulo.pAddLogDir('DIRBAN', FDirAce, LSelecionado.Codigo, 'IAE', 'S', -1);
        End;

        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Liberando direitos de acesso Operador ' + LSelecionado.Descricao + ' ... ';

        FForm.AdicionarPermissaoUsuario(MnuAutBan.Selected, LSelecionado.Codigo, 'IAE', 'S', opCheckChild);
      End
      Else
      Begin
        LDireitos := fCampoTabela('DIR_ACAOUS', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [LSelecionado.Codigo, FDirAce]);
        LOpeSenLib := fCampoTabela('DIR_OSNLIB', 'DIRGPB', ['GPB_CODGPO', 'DIR_NOMFRM'], [LSelecionado.Codigo, FDirAce]);

        If (Not LDireitos.Equals('IAE')) Or (Not LOpeSenLib.Equals('S')) Then
        Begin
          fExecutaSQL(Format(SQL_REPLACE_DIRGPO, [FDirAce, LSelecionado.Codigo, 'IAE', 'S']));
          frmModulo.pAddLogDir('DIRGPB', FDirAce, '', 'IAE', 'S', LSelecionado.Codigo.ToInteger);
        End;

        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Liberando direitos de acesso Grupo ' + LSelecionado.Descricao + ' ... ';

        FForm.AdicionarPermissaoGrupo(MnuAutBan.Selected, LSelecionado.Codigo, 'IAE', 'S', opCheckChild);
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
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutban.TLiberarAcessoSubrotinas.Executar');
    End;
  End;
end;

{ TfrmPermissaoAcessoAutban.TRemoverAcessoSubrotinas }

function TfrmPermissaoAcessoAutban.TRemoverAcessoSubrotinas.Executar(
  pgbProgresso: TCxProgressBar): Boolean;
Var
  LRemovido: TfrmPermissaoAcessoAdicionarAutban.Selecionado;
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
        fExecutaSQL(Format(SQL_DELETE_DIROPE, [FDirAce, LRemovido.Codigo]));
        frmModulo.pAddLogDir('DIRBAN', FDirAce, LRemovido.Codigo, 'DEL', LRemovido.OpeSenLib, -1);

        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Removendo direitos de acesso Operador ' + LRemovido.Descricao + ' ... ';

        FForm.RemoverPermissaoUsuario(MnuAutBan.Selected, LRemovido.Codigo, LRemovido.OpeSenLib, opCheckChild);
      End
      Else
      Begin
        fExecutaSQL(Format(SQL_DELETE_DIRGPO, [FDirAce, LRemovido.Codigo]));
        frmModulo.pAddLogDir('DIRGPB', FDirAce, '', 'DEL', LRemovido.OpeSenLib, LRemovido.Codigo.ToInteger);

        FForm.lblAguarde.Caption := FForm.lblDescricaoDireitoAcesso.Caption + ' e subrotinas' + #13#10 +
          'Removendo direitos de acesso Grupo ' + LRemovido.Descricao + ' ... ';

        FForm.RemoverPermissaoGrupo(MnuAutBan.Selected, LRemovido.Codigo, LRemovido.OpeSenLib, opCheckChild);
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
      pMensagensErro(E.Message, 'TfrmPermissaoAcessoAutban.TRemoverAcessoSubrotinas.Executar');
    End;
  End;
end;

function TfrmPermissaoAcessoAutban.GetRemovidos: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
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
        VarArrayOf(['OPE', Self.FQryOperadores.FieldByName('BAN_CODOPE').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'OPE';
        Result[Length(Result)-1].Codigo := Self.FQryOperadores.FieldByName('BAN_CODOPE').AsString;
        Result[Length(Result)-1].Descricao := fRetNomVendRep(Self.FQryOperadores.FieldByName('BAN_CODOPE').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('BAN_OSNLIB').AsString;
      End;
      Self.FQryOperadores.Next;
    End;

    Self.FQryGrupos.First;
    While Not Self.FQryGrupos.Eof Do
    Begin
      If Not Self.cdsTemPermissao.Locate('tipo;codigo',
        VarArrayOf(['GRU', Self.FQryGrupos.FieldByName('GPB_CODGPO').AsString]), []) Then
      Begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result)-1].Tipo := 'GRU';
        Result[Length(Result)-1].Codigo := Self.FQryGrupos.FieldByName('GPB_CODGPO').AsString;
        Result[Length(Result)-1].Descricao := fRetNomCadGpo(Self.FQryGrupos.FieldByName('GPB_CODGPO').AsString);
        Result[Length(Result)-1].OpeSenLib := Self.FQryOperadores.FieldByName('BAN_OSNLIB').AsString;
      End;
      Self.FQryGrupos.Next;
    End;
  Finally
    cdsTemPermissao.EnableControls;
  End;
end;

end.
