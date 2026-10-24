unit untDirAutBan;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPai, ComCtrls, DBCtrls, Controls,
  StdCtrls, Menus, Buttons, ExtCtrls, {QTypes,} Graphics, Forms, Uni,
  Dialogs, StrUtils, AppEvnts, DB, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untFrameMenuPrincipal, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, untPermissaoAcessoAutban;

type
  TfrmDirAutBan = class(TfrmPai)
    pnlFundo: TPanel;
    Label3: TLabel;
    lblNomTela: TLabel;
    dtsOpe01: TDataSource;
    dtsOpe02: TDataSource;
    FrameMenu: TfrmFrameMenuPrincipal;
    pnlPermissaoAcesso: TPanel;
    lblInformacaoPastas: TLabel;
    imgIcones: TcxImageList;
    tmrAtualizar: TTimer;
    btnHerOpe: TcxButton;
    btnHerGpo: TcxButton;
    btnAceTot: TcxButton;
    btnRemTot: TcxButton;
    popDirAcesso: TPopupMenu;
    mnuAdicionarPermissao: TMenuItem;
    mnuRemoverPermissao: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure pCarregaMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure trvMenuKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure trvMenuClick(Sender: TObject);
    procedure pGeraVetor;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnHerOpeClick(Sender: TObject);
    procedure btnHerGpoClick(Sender: TObject);
    procedure btnAceTotClick(Sender: TObject);
    procedure btnRemTotClick(Sender: TObject);
    procedure FrameMenutrvMenuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure mnuAdicionarPermissaoClick(Sender: TObject);
    procedure mnuRemoverPermissaoClick(Sender: TObject);
  private
    { Private declarations }
    stlNomFrm: TStringList;
    stlDireitosAcesso: TStringList;
    FAbsoluteIndexSelecionado: Integer;
    FDireitoAcessoSelecionado: String;
    FFrmPermissaoAcesso: TfrmPermissaoAcessoAutBan;
    procedure pLiberarAcessoEmCascata;
    procedure pRemoverAcessoEmCascata;
    procedure pAfterAplicar;
    procedure pPegaNomeDireitoAcesso();
    procedure pHerancaDireitosGrupo();
    procedure pHerancaDireitosOperador();
    procedure pHerancaDireitos(strTipoDir: String);
    procedure pCopiaDireitosOperador(strOpeDe, strOpePara: String);
    procedure pCopiaDireitosGpo(intGpoDe, intGpoPara: Integer);
  public
    { Public declarations }
  end;

implementation

uses untFuncoes, untfuncoesSimples, untModulo, untDirAcessoTotalAutBan,
  untTypesSistema, untAcessoTotalAutBan, untHerancaDireitos, untPrincipal;

{$R *.dfm}

procedure TfrmDirAutBan.FormShow(Sender: TObject);
begin
  inherited;
  fExecutarModal(pCarregaMenu, 'Carregando direitos de acesso, Aguarde ...', '');
  FrameMenu.trvMenu.Selected := FrameMenu.trvMenu.Items[0];
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutBan.FrameMenutrvMenuMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If (Button = mbRight) Then
  Begin
    pPegaNomeDireitoAcesso;
    If FrameMenu.trvMenu.Items[FAbsoluteIndexSelecionado].HasChildren Then
      popDirAcesso.Popup(fGetParentLeft(FrameMenu.trvMenu) + X + 30, fGetParentTop(FrameMenu.trvMenu) + Y + 30);
  End;
end;

procedure TfrmDirAutBan.mnuAdicionarPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pLiberarAcessoEmCascata, 'Realizando liberação de acesso, Aguarde ...', '');
end;

procedure TfrmDirAutBan.mnuRemoverPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pRemoverAcessoEmCascata, 'Removendo permissão de acesso, Aguarde ...', '');
end;

procedure TfrmDirAutBan.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(FrameMenu.trvMenu);
end;

procedure TfrmDirAutBan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If frmModulo.GetCurrentConnection.InTransaction Then
  Begin
    If fMensagem('','Deseja salvar as alterações?',['','']) = 1 Then
      fCommit
    Else
      fRollBack;
  End;

	FreeAndNil(stlNomFrm);
  FreeAndNil(stlDireitosAcesso);
end;

procedure TfrmDirAutBan.FormCreate(Sender: TObject);
begin
  inherited;
  stlNomFrm := TStringList.Create;
  stlDireitosAcesso := TStringList.Create;
  FFrmPermissaoAcesso := TfrmPermissaoAcessoAutBan.Create(Self);
  FFrmPermissaoAcesso.Align := alClient;
  FFrmPermissaoAcesso.blnDocked := True;
  FFrmPermissaoAcesso.AfterAplicar := pAfterAplicar;
  FFrmPermissaoAcesso.Dock(pnlPermissaoAcesso, pnlPermissaoAcesso.BoundsRect);
  FFrmPermissaoAcesso.Show;
end;

{**********************}
{* CARREGA O TREEVIEW *}
{*******************AF*}
procedure TfrmDirAutBan.pCarregaMenu;
  Var
    trnNoPrincipal: TTreeNode;
Begin
  FrameMenu.AdicionaMenuBancoDoBrasilPagForAPI;
  FrameMenu.AdicionaMenuItauAPIPix;
  FrameMenu.AdicionaMenuSicoobAPIPix;
  FrameMenu.AdicionaMenuSantanderAPIPix;
  FrameMenu.AdicionaMenuJpiFidc;
  FrameMenu.AdicionaMenuBradescoAPIPix;

  with FrameMenu.trvMenu.Items do
  begin
   trnNoPrincipal := Add(nil, 'Configurações Gerais > AUTCONFGER');
   AddChild(trnNoPrincipal, 'Alterar configurações da carteira selecionada > PERCARBAN');
  end;

  pGeraVetor;
End;


procedure TfrmDirAutBan.pCopiaDireitosGpo(intGpoDe, intGpoPara: Integer);
Var
  LSQL: String;
begin
  Try
    LSQL := '';
    LSQL := LSQL + 'SET @DTAALT = "' + FormatDateTime('yyyy-MM-dd', VS_Date) + '";      ';
    LSQL := LSQL + 'SET @HORALT = "' + TimeToStr(fTime()) + '";                            ';
    LSQL := LSQL + 'SET @GRUORI = "' + intGpoDe.ToString + '";                          ';
    LSQL := LSQL + 'SET @OPEALT = "' + strLoginUsuarioLogado + '";                      ';
    LSQL := LSQL + 'SET @GRUDIR = "' + intGpoPara.ToString + '";                        ';
    LSQL := LSQL + '                                                                    ';

    If fGetMenu('Selecione uma opção',
               ['Substituir os acessos existentes',
                'Incrementar os acessos existentes'], 1) = 1 Then
    Begin
      LSQL := LSQL + 'DELETE FROM DIRGPB WHERE GPB_CODGPO = @GRUDIR;                    ';
    End;

    LSQL := LSQL + 'REPLACE INTO DIRGPB (                                               ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  GPB_CODGPO,                                                       ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPB                                                            ';
    LSQL := LSQL + 'WHERE GPB_CODGPO = @GRUORI;                                         ';
    LSQL := LSQL + '                                                                    ';
    LSQL := LSQL + 'INSERT INTO LOGDIR (                                                ';
    LSQL := LSQL + '  AUTOINCREM,                                                       ';
    LSQL := LSQL + '  LOG_DTAALT,                                                       ';
    LSQL := LSQL + '  LOG_HORALT,                                                       ';
    LSQL := LSQL + '  LOG_CODOPE,                                                       ';
    LSQL := LSQL + '  LOG_TABELA,                                                       ';
    LSQL := LSQL + '  LOG_NOMFRM,                                                       ';
    LSQL := LSQL + '  LOG_OPEDIR,                                                       ';
    LSQL := LSQL + '  LOG_CODGPO,                                                       ';
    LSQL := LSQL + '  LOG_ACAOUS,                                                       ';
    LSQL := LSQL + '  LOG_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  fRetAutoincrem(''LOGDIR'', ''' + VS_STRCodEmp + ''') AS AUTOINCREM,                ';
    LSQL := LSQL + '  @DTAALT,                                                          ';
    LSQL := LSQL + '  @HORALT,                                                          ';
    LSQL := LSQL + '  @OPEALT,                                                          ';
    LSQL := LSQL + '  "DIRGPB",                                                         ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPB                                                            ';
    LSQL := LSQL + 'WHERE GPB_CODGPO = @GRUORI;                                         ';

    While LSQL.Contains('  ') Do
      LSQL := LSQL.Replace('  ', ' ');

    fStartTransaction;
    fExecutaSQL(LSQL);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise;
    End;
  End;
end;

procedure TfrmDirAutBan.pCopiaDireitosOperador(strOpeDe, strOpePara: String);
Var
  LSQL: String;
begin
  Try
    LSQL := '';
    LSQL := LSQL + 'SET @DTAALT = "' + FormatDateTime('yyyy-MM-dd', VS_Date) + '";      ';
    LSQL := LSQL + 'SET @HORALT = "' + TimeToStr(fTime()) + '";                            ';
    LSQL := LSQL + 'SET @OPEORI = "' + strOpeDe + '";                                   ';
    LSQL := LSQL + 'SET @OPEALT = "' + strLoginUsuarioLogado + '";                      ';
    LSQL := LSQL + 'SET @OPEDIR = "' + strOpePara + '";                                 ';
    LSQL := LSQL + '                                                                    ';

    If fGetMenu('Selecione uma opção',
               ['Substituir os acessos existentes',
                'Incrementar os acessos existentes'], 1) = 1 Then
    Begin
      LSQL := LSQL + 'DELETE FROM DIRBAN WHERE BAN_CODOPE = @OPEDIR;                    ';
    End;


    LSQL := LSQL + 'REPLACE INTO DIRBAN (                                               ';
    LSQL := LSQL + '  BAN_NOMFRM,                                                       ';
    LSQL := LSQL + '  BAN_CODOPE,                                                       ';
    LSQL := LSQL + '  BAN_ACAOUS,                                                       ';
    LSQL := LSQL + '  BAN_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  BAN_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  BAN_ACAOUS,                                                       ';
    LSQL := LSQL + '  BAN_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRBAN                                                            ';
    LSQL := LSQL + 'WHERE BAN_CODOPE = @OPEORI;                                         ';
    LSQL := LSQL + '                                                                    ';
    LSQL := LSQL + 'INSERT INTO LOGDIR (                                                ';
    LSQL := LSQL + '  AUTOINCREM,                                                       ';
    LSQL := LSQL + '  LOG_DTAALT,                                                       ';
    LSQL := LSQL + '  LOG_HORALT,                                                       ';
    LSQL := LSQL + '  LOG_CODOPE,                                                       ';
    LSQL := LSQL + '  LOG_TABELA,                                                       ';
    LSQL := LSQL + '  LOG_NOMFRM,                                                       ';
    LSQL := LSQL + '  LOG_OPEDIR,                                                       ';
    LSQL := LSQL + '  LOG_CODGPO,                                                       ';
    LSQL := LSQL + '  LOG_ACAOUS,                                                       ';
    LSQL := LSQL + '  LOG_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  fRetAutoincrem(''LOGDIR'', ''' + VS_STRCodEmp + ''') AS AUTOINCREM,                ';
    LSQL := LSQL + '  @DTAALT,                                                          ';
    LSQL := LSQL + '  @HORALT,                                                          ';
    LSQL := LSQL + '  @OPEALT,                                                          ';
    LSQL := LSQL + '  "DIRBAN",                                                         ';
    LSQL := LSQL + '  BAN_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  BAN_ACAOUS,                                                       ';
    LSQL := LSQL + '  BAN_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRBAN                                                            ';
    LSQL := LSQL + 'WHERE BAN_CODOPE = @OPEORI;                                         ';

    While LSQL.Contains('  ') Do
      LSQL := LSQL.Replace('  ', ' ');

    fStartTransaction;
    fExecutaSQL(LSQL);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise;
    End;
  End;
end;

{***********************************}
{* CARREGA LISTBOX DE OPERADOR COM *}
{* ACESSO E SEM ACESSO             *}
{********************************AF*}
procedure TfrmDirAutBan.pAfterAplicar;
begin
  pSetFocus(FrameMenu.trvMenu);
end;

{*****************************************}
{* PEGA O NOME DO FORM QUE O MENU CHAMA  *}
{**************************************AF*}
procedure TfrmDirAutBan.pPegaNomeDireitoAcesso;
begin
  If FrameMenu.trvMenu.SelectionCount > 0 Then
  Begin
    FAbsoluteIndexSelecionado := FrameMenu.trvMenu.Selected.AbsoluteIndex;
    FDireitoAcessoSelecionado := stlDireitosAcesso[FAbsoluteIndexSelecionado];

    If FDireitoAcessoSelecionado.IsEmpty Then
    Begin
      If FrameMenu.trvMenu.Selected.HasChildren Then
      Begin
        FrameMenu.trvMenu.Select(FrameMenu.trvMenu.Selected.Item[0]);
        FAbsoluteIndexSelecionado := FrameMenu.trvMenu.Selected.AbsoluteIndex;
        FDireitoAcessoSelecionado := stlDireitosAcesso[FAbsoluteIndexSelecionado];
      End;
    End;

    FFrmPermissaoAcesso.MnuAutBan := FrameMenu.trvMenu;
    FFrmPermissaoAcesso.DireitoAcesso := stlDireitosAcesso;
    FFrmPermissaoAcesso.strDireitoAcesso := FDireitoAcessoSelecionado;

    If lblInformacaoPastas.Visible Then
      lblInformacaoPastas.Visible := False;

    If Not FFrmPermissaoAcesso.Visible Then
    Begin
      pnlPermissaoAcesso.Caption := 'Atualizando ...';
      Application.ProcessMessages;
      FFrmPermissaoAcesso.Align := alNone;
      FFrmPermissaoAcesso.Align := alClient;
      FFrmPermissaoAcesso.Visible := True;
      pnlPermissaoAcesso.Caption := '';
    End;
  End;
end;


procedure TfrmDirAutBan.pRemoverAcessoEmCascata;
Var
  LIndex: Integer;
begin
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcessoAutBan.RemoverAcessoSubrotinas(FDireitoAcessoSelecionado, FrameMenu.TrvMenu, stlDireitosAcesso);
  Finally
    FrameMenu.trvMenu.Select(FrameMenu.trvMenu.Items[LIndex]);
  End;
end;

procedure TfrmDirAutBan.trvMenuKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key <> VK_Return) Or (Not FFrmPermissaoAcesso.Visible) Then
    tmrAtualizar.Enabled := True;
end;

procedure TfrmDirAutBan.btnAceTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotalAutBan;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotalAutBan, frmDirAcessoTotal);
  Try
    frmDirAcessoTotal.blnMostraGrupo := True;
    frmDirAcessoTotal.objAceTot := TAceTot.Create(stlDireitosAcesso, tdiAutBan);
    frmDirAcessoTotal.ShowModal;
  Finally
    pFreeAndNil(frmDirAcessoTotal);
  End;
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutBan.btnHerGpoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosGrupo, 'Realizando herança de grupo de operadores, Aguarde ...', '');
end;

procedure TfrmDirAutBan.btnHerOpeClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosOperador, 'Realizando herança de operador, Aguarde ...', '');
end;

procedure TfrmDirAutBan.btnRemTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotalAutBan;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotalAutBan, frmDirAcessoTotal);
  Try
    frmDirAcessoTotal.blnMostraGrupo := True;
    frmDirAcessoTotal.objAceTot := TAceTot.Create(stlDireitosAcesso, tdiAutcomRemocao);
    frmDirAcessoTotal.Caption := 'Remoção de Acesso Total';
    frmDirAcessoTotal.ShowModal;
  Finally
    pFreeAndNil(frmDirAcessoTotal);
  End;
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutBan.btnSairClick(Sender: TObject);
begin
  If frmModulo.GetCurrentConnection.InTransaction Then
  Begin
    If fMensagem('','Deseja salvar as alterações?',['','']) = 1 Then
      fCommit
    Else
      fRollBack;
  End;

  inherited;
end;

procedure TfrmDirAutBan.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  pnlPermissaoAcesso.Caption := '';
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutBan.trvMenuClick(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  lblInformacaoPastas.Visible := False;
  FFrmPermissaoAcesso.Visible := False;
  pnlPermissaoAcesso.Caption := 'Atualizando ...';
  tmrAtualizar.Enabled := True;
end;

{**********************************************}
{* MONTA MENU NOVAMENTE COM OS NOMES CORRETOS *}
{* E GERA O VETOR COM OS NOMES DOS FORMS E OS *}
{* INDICES                                    *}
{*******************************************AF*}
procedure TfrmDirAutBan.pGeraVetor;
  Var
    intContador: Integer;
    strValor: String;
Begin
  {**************}
  {* ZERA VETOR *}
  {***********AF*}
  SetLength(arrMenu,0);

  For intContador := 0 To FrameMenu.trvMenu.Items.Count -1 Do
  Begin
    strValor := Trim(RightStr(FrameMenu.trvMenu.Items[intContador].Text, Length(FrameMenu.trvMenu.Items[intContador].Text) - Pos('>', FrameMenu.trvMenu.Items[intContador].Text)));
    FrameMenu.trvMenu.Items[intContador].Text := LeftStr(FrameMenu.trvMenu.Items[intContador].Text, Pos('>', FrameMenu.trvMenu.Items[intContador].Text)-1);

    If (Pos('frm', strValor) > 0) Or (strValor = 'PERCARBAN') Then
    Begin
      FrameMenu.trvMenu.Items[intContador].ImageIndex := 1;
      FrameMenu.trvMenu.Items[intContador].SelectedIndex := 1;
      FrameMenu.trvMenu.Items[intContador].StateIndex := 1;
      FrameMenu.trvMenu.Items[intContador].ExpandedImageIndex := 1;
    End
    Else
    Begin
      FrameMenu.trvMenu.Items[intContador].ImageIndex := 0;
      FrameMenu.trvMenu.Items[intContador].SelectedIndex := 0;
      FrameMenu.trvMenu.Items[intContador].StateIndex := 0;
      FrameMenu.trvMenu.Items[intContador].ExpandedImageIndex := 0;
    End;

    SetLength(arrMenu,Length(arrMenu)+1);

    arrMenu[intContador].strNomform := strValor;
    stlNomFrm.Add(arrMenu[intContador].strNomform);
    stlDireitosAcesso.Add(strValor);
  End;
End;

procedure TfrmDirAutBan.pHerancaDireitos(strTipoDir: String);
begin
  Try
    pCriarFormularios(TfrmHerancaDireitos, frmHerancaDireitos);
    frmHerancaDireitos.strTipDir := strTipoDir;
    frmHerancaDireitos.ShowModal;
    If (frmHerancaDireitos.blnConfirma) Then
    Begin
      btnHerOpe.Enabled := False;
      btnHerGpo.Enabled := False;
      Application.ProcessMessages;

      If SameText(frmHerancaDireitos.strTipDir, 'Operador') Then
      Begin
        pCopiaDireitosOperador(frmHerancaDireitos.edtCodDo.Text, frmHerancaDireitos.edtCodPara.Text);
      End
      Else If SameText(frmHerancaDireitos.strTipDir, 'Grupo') Then
      Begin
        pCopiaDireitosGpo(StrToIntDef(frmHerancaDireitos.edtCodDo.Text, 0),
          StrToIntDef(frmHerancaDireitos.edtCodPara.Text, 0));
      End;

      pMensagemOk('Herança concluída com sucesso!');
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmDirAcesso.pHerancaDireitos]');
  End;
  pFreeAndNil(frmHerancaDireitos);
  btnHerOpe.Enabled := True;
  btnHerGpo.Enabled := True;
end;

procedure TfrmDirAutBan.pHerancaDireitosGrupo;
begin
  pHerancaDireitos('Grupo');
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutBan.pHerancaDireitosOperador;
begin
  pHerancaDireitos('Operador');
  pPegaNomeDireitoAcesso;
end;


procedure TfrmDirAutBan.pLiberarAcessoEmCascata;
Var
  LIndex: Integer;
begin
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcessoAutBan.LiberarAcessoSubrotinas(FDireitoAcessoSelecionado, FrameMenu.TrvMenu, stlDireitosAcesso);
  Finally
    FrameMenu.trvMenu.Select(FrameMenu.trvMenu.Items[LIndex]);
  End;
end;

procedure TfrmDirAutBan.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnSair.Click;
end;

end.


