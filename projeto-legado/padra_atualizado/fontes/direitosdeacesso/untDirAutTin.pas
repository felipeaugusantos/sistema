unit untDirAutTin;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, untPai, ComCtrls, DBCtrls, Controls,
  StdCtrls, Menus, Buttons, ExtCtrls, Graphics, Forms, Dialogs, StrUtils, AppEvnts,
  DB, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, System.ImageList, Vcl.ImgList,
  cxImageList, cxButtons, untPermissaoAcessoAuttin;

type
  TfrmDirAutTin = class(TfrmPai)
    pnlFundo: TPanel;
    Label3: TLabel;
    lblNomTela: TLabel;
    dtsOpe01: TDataSource;
    dtsOpe02: TDataSource;
    pnlPermissaoAcesso: TPanel;
    lblInformacaoPastas: TLabel;
    trvMenu: TTreeView;
    btnHerOpe: TcxButton;
    btnHerGpo: TcxButton;
    btnAceTot: TcxButton;
    btnRemTot: TcxButton;
    tmrAtualizar: TTimer;
    popDirAcesso: TPopupMenu;
    mnuAdicionarPermissao: TMenuItem;
    mnuRemoverPermissao: TMenuItem;
    imgIcones: TcxImageList;
    procedure FormShow(Sender: TObject);
    procedure pCarregaMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure pGeraVetor;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnAceTotClick(Sender: TObject);
    procedure mnuRemoverPermissaoClick(Sender: TObject);
    procedure btnHerOpeClick(Sender: TObject);
    procedure btnHerGpoClick(Sender: TObject);
    procedure btnRemTotClick(Sender: TObject);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure trvMenuClick(Sender: TObject);
    procedure trvMenuKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure trvMenuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuAdicionarPermissaoClick(Sender: TObject);
  private
    { Private declarations }
    stlNomFrm: TStringList;
    stlDireitosAcesso: TStringList;
    FAbsoluteIndexSelecionado: Integer;
    FDireitoAcessoSelecionado: String;
    FFrmPermissaoAcesso: TfrmPermissaoAcessoAutTin;
    procedure pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode; strKey: String);
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

uses untFuncoes, untfuncoesSimples, untModulo, untDirAcessoTotalAutTin,
  untTypesSistema, untAcessoTotalAutTin, untInicializarDllAutTin, untHerancaDireitos,
  untPrincipal;

{$R *.dfm}

procedure TfrmDirAutTin.FormShow(Sender: TObject);
begin
  inherited;
  fExecutarModal(pCarregaMenu, 'Carregando direitos de acesso, Aguarde ...', '');
  trvMenu.Selected := trvMenu.Items[0];
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutTin.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(trvMenu);
end;

procedure TfrmDirAutTin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If frmModulo.Database.InTransaction Then
  Begin
    If fMensagem('','Deseja salvar as alterações?',['','']) = 1 Then
      fCommit
    Else
      fRollBack;
  End;

	FreeAndNil(stlNomFrm);
  FreeAndNil(stlDireitosAcesso);
end;

procedure TfrmDirAutTin.FormCreate(Sender: TObject);
begin
  inherited;
  stlNomFrm := TStringList.Create;
  stlDireitosAcesso := TStringList.Create;
  FFrmPermissaoAcesso := TfrmPermissaoAcessoAutTin.Create(Self);
  FFrmPermissaoAcesso.Align := alClient;
  FFrmPermissaoAcesso.blnDocked := True;
  FFrmPermissaoAcesso.AfterAplicar := pAfterAplicar;
  FFrmPermissaoAcesso.Dock(pnlPermissaoAcesso, pnlPermissaoAcesso.BoundsRect);
  FFrmPermissaoAcesso.Show;
end;

{**********************}
{* CARREGA O TREEVIEW *}
{*******************RG*}
procedure TfrmDirAutTin.pAfterAplicar;
begin
  pSetFocus(trvMenu);
end;

procedure TfrmDirAutTin.pCarregaMenu;
Var
  Item: TMenuItem;
begin
  trvMenu.Items.BeginUpdate;
  Try
    Begin
      Item := frmPrincipal.mnuTintaDeMaquina;

      pMontaTreeView(Item, nil, '');
    End;
  Finally
    trvMenu.Items.EndUpdate;
  End;
end;


procedure TfrmDirAutTin.pCopiaDireitosGpo(intGpoDe, intGpoPara: Integer);
Var
  LSQL: String;
  LCount: Integer;
  LAutInc: String;
begin
  Try
    LCount := fCampoTabela('COUNT(0)', 'DIRGPO', ['GPO_CODGPO'], [intGpoDe.ToString]);
    LAutInc := fRetAutoIncrem('LOGDIR', VS_strCodEmp, LCount);

    LSQL := '';
    LSQL := LSQL + 'SET @AUTINC = "' + LAutInc + '";                                    ';
    LSQL := LSQL + 'SET @EMPFIS = LEFT(@AUTINC, 3);                                     ';
    LSQL := LSQL + 'SET @EMPLOG = RIGHT(@AUTINC, 3);                                    ';
    LSQL := LSQL + 'SET @PROINC = CAST(MID(@AUTINC, 4, 14) AS DECIMAL(12,0)) + 1;       ';
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
      LSQL := LSQL + 'DELETE FROM DIRGPT WHERE GPT_CODGPO = @GRUDIR;                    ';
    End;

    LSQL := LSQL + 'REPLACE INTO DIRGPT (                                               ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  GPT_CODGPO,                                                       ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPT                                                            ';
    LSQL := LSQL + 'WHERE GPT_CODGPO = @GRUORI;                                         ';
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
    LSQL := LSQL + '  CONCAT(                                                           ';
    LSQL := LSQL + '    @EMPFIS,                                                        ';
    LSQL := LSQL + '    LPAD(@PROINC := @PROINC + 1, 14, "0"),                          ';
    LSQL := LSQL + '    @EMPLOG                                                         ';
    LSQL := LSQL + '  ) AS AUTOINCREM,                                                  ';
    LSQL := LSQL + '  @DTAALT,                                                          ';
    LSQL := LSQL + '  @HORALT,                                                          ';
    LSQL := LSQL + '  @OPEALT,                                                          ';
    LSQL := LSQL + '  "DIRGPT",                                                         ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPT                                                            ';
    LSQL := LSQL + 'WHERE GPT_CODGPO = @GRUORI;                                         ';

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

procedure TfrmDirAutTin.pCopiaDireitosOperador(strOpeDe, strOpePara: String);
Var
  LSQL: String;
  LCount: Integer;
  LAutInc: String;
begin
  Try
    LCount := fCampoTabela('COUNT(0)', 'DIROPE', ['OPE_CODOPE'], [strOpeDe]);
    LAutInc := fRetAutoIncrem('LOGDIR', VS_strCodEmp, LCount);

    LSQL := '';
    LSQL := LSQL + 'SET @AUTINC = "' + LAutInc + '";                                    ';
    LSQL := LSQL + 'SET @EMPFIS = LEFT(@AUTINC, 3);                                     ';
    LSQL := LSQL + 'SET @EMPLOG = RIGHT(@AUTINC, 3);                                    ';
    LSQL := LSQL + 'SET @PROINC = CAST(MID(@AUTINC, 4, 14) AS DECIMAL(12,0)) + 1;       ';
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
      LSQL := LSQL + 'DELETE FROM DIRTIN WHERE TIN_CODOPE = @OPEDIR;                    ';
    End;


    LSQL := LSQL + 'REPLACE INTO DIRTIN (                                               ';
    LSQL := LSQL + '  TIN_NOMFRM,                                                       ';
    LSQL := LSQL + '  TIN_CODOPE,                                                       ';
    LSQL := LSQL + '  TIN_ACAOUS,                                                       ';
    LSQL := LSQL + '  TIN_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  TIN_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  TIN_ACAOUS,                                                       ';
    LSQL := LSQL + '  TIN_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRTIN                                                            ';
    LSQL := LSQL + 'WHERE TIN_CODOPE = @OPEORI;                                         ';
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
    LSQL := LSQL + '  CONCAT(                                                           ';
    LSQL := LSQL + '    @EMPFIS,                                                        ';
    LSQL := LSQL + '    LPAD(@PROINC := @PROINC + 1, 14, "0"),                          ';
    LSQL := LSQL + '    @EMPLOG                                                         ';
    LSQL := LSQL + '  ) AS AUTOINCREM,                                                  ';
    LSQL := LSQL + '  @DTAALT,                                                          ';
    LSQL := LSQL + '  @HORALT,                                                          ';
    LSQL := LSQL + '  @OPEALT,                                                          ';
    LSQL := LSQL + '  "DIRTIN",                                                         ';
    LSQL := LSQL + '  TIN_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  TIN_ACAOUS,                                                       ';
    LSQL := LSQL + '  TIN_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRTIN                                                            ';
    LSQL := LSQL + 'WHERE TIN_CODOPE = @OPEORI;                                         ';

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

{*****************************************}
{* PEGA O NOME DO FORM QUE O MENU CHAMA  *}
{**************************************AF*}
procedure TfrmDirAutTin.pPegaNomeDireitoAcesso;
Var
  LHasChildren: Boolean;
begin
  If trvMenu.SelectionCount > 0 Then
  Begin
    FAbsoluteIndexSelecionado := trvMenu.Selected.AbsoluteIndex;
    FDireitoAcessoSelecionado := stlDireitosAcesso[FAbsoluteIndexSelecionado];

    If FDireitoAcessoSelecionado.IsEmpty Then
    Begin
      If trvMenu.Selected.HasChildren Then
      Begin
        trvMenu.Select(trvMenu.Selected.Item[0]);
        FAbsoluteIndexSelecionado := trvMenu.Selected.AbsoluteIndex;
        FDireitoAcessoSelecionado := stlDireitosAcesso[FAbsoluteIndexSelecionado];
      End;
    End;

    FFrmPermissaoAcesso.strDireitoAcesso := FDireitoAcessoSelecionado;

    LHasChildren := trvMenu.Items[FAbsoluteIndexSelecionado].HasChildren;

    If LHasChildren Then
    Begin
      If Not lblInformacaoPastas.Visible Then
        lblInformacaoPastas.Visible := True;

      If FFrmPermissaoAcesso.Visible Then
        FFrmPermissaoAcesso.Visible := False;
    End
    Else
    Begin
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
  End;
end;


procedure TfrmDirAutTin.pRemoverAcessoEmCascata;
Var
  LIndex: Integer;
begin
  inherited;
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcessoAutTin.RemoverAcessoSubrotinas(FDireitoAcessoSelecionado);
  Finally
    trvMenu.Select(trvMenu.Items[LIndex]);
  End;
end;

procedure TfrmDirAutTin.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  pnlPermissaoAcesso.Caption := '';
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutTin.trvMenuClick(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  lblInformacaoPastas.Visible := False;
  FFrmPermissaoAcesso.Visible := False;
  pnlPermissaoAcesso.Caption := 'Atualizando ...';
  tmrAtualizar.Enabled := True;
end;

procedure TfrmDirAutTin.trvMenuKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key <> VK_Return) Or (Not FFrmPermissaoAcesso.Visible) Then
    tmrAtualizar.Enabled := True;
end;

procedure TfrmDirAutTin.trvMenuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  If (Button = mbRight) Then
  Begin
    pPegaNomeDireitoAcesso;
    If trvMenu.Items[FAbsoluteIndexSelecionado].HasChildren Then
      popDirAcesso.Popup(fGetParentLeft(trvMenu) + X + 30, fGetParentTop(trvMenu) + Y + 30);
  End;
end;

procedure TfrmDirAutTin.mnuAdicionarPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pLiberarAcessoEmCascata, 'Realizando liberação de acesso, Aguarde ...', '');
end;

procedure TfrmDirAutTin.mnuRemoverPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pRemoverAcessoEmCascata, 'Removendo permissão de acesso, Aguarde ...', '');
end;

procedure TfrmDirAutTin.btnAceTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotalAutTin;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotalAutTin, frmDirAcessoTotal);
  Try
    frmDirAcessoTotal.blnMostraGrupo := True;
    frmDirAcessoTotal.objAceTot := TAceTot.Create(stlDireitosAcesso, tdiAutTin);
    frmDirAcessoTotal.ShowModal;
  Finally
    pFreeAndNil(frmDirAcessoTotal);
  End;
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutTin.btnHerGpoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosGrupo, 'Realizando herança de grupo de operadores, Aguarde ...', '');
end;

procedure TfrmDirAutTin.btnHerOpeClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosOperador, 'Realizando herança de operador, Aguarde ...', '');
end;

procedure TfrmDirAutTin.btnRemTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotalAutTin;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotalAutTin, frmDirAcessoTotal);
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

procedure TfrmDirAutTin.btnSairClick(Sender: TObject);
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

procedure TfrmDirAutTin.btnSalvarClick(Sender: TObject);
begin
  inherited;
  Try
    fCommit;
    fMensagem('','Direitos Salvos com Sucesso',['&O K']);
  Except
 	  On E: Exception do
	  Begin
		  pMensagensErro(E.Message,Self.Name);
	  End;
  End;
  btnSair.Click;
end;

{**********************************************}
{* MONTA MENU NOVAMENTE COM OS NOMES CORRETOS *}
{* E GERA O VETOR COM OS NOMES DOS FORMS E OS *}
{* INDICES                                    *}
{*******************************************AF*}
procedure TfrmDirAutTin.pGeraVetor;
  Var
    intContador: Integer;
    strValor: String;
Begin
  {**************}
  {* ZERA VETOR *}
  {***********AF*}
  SetLength(arrMenu,0);

  For intContador := 0 To trvMenu.Items.Count -1 Do
  Begin
    strValor := Trim(RightStr(trvMenu.Items[intContador].Text, Length(trvMenu.Items[intContador].Text) - Pos('>', trvMenu.Items[intContador].Text)));
    trvMenu.Items[intContador].Text := LeftStr(trvMenu.Items[intContador].Text, Pos('>', trvMenu.Items[intContador].Text)-1);

    If (Pos('mnu', strValor) > 0) Or (strValor = 'frmConfGerais') Then
    Begin
      trvMenu.Items[intContador].ImageIndex := 0;
      trvMenu.Items[intContador].SelectedIndex := 0;
      trvMenu.Items[intContador].StateIndex := 0;
      trvMenu.Items[intContador].ExpandedImageIndex := 0;
    End
    Else
    Begin
      trvMenu.Items[intContador].ImageIndex := 2;
      trvMenu.Items[intContador].SelectedIndex := 2;
      trvMenu.Items[intContador].StateIndex := 2;
      trvMenu.Items[intContador].ExpandedImageIndex := 2;
    End;

    SetLength(arrMenu,Length(arrMenu)+1);

    arrMenu[intContador].strNomform := strValor;
    stlNomFrm.Add(arrMenu[intContador].strNomform);
    stlDireitosAcesso.Add(strValor);
  End;
End;

procedure TfrmDirAutTin.pHerancaDireitos(strTipoDir: String);
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

procedure TfrmDirAutTin.pHerancaDireitosGrupo;
begin
  pHerancaDireitos('Grupo');
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutTin.pHerancaDireitosOperador;
begin
  pHerancaDireitos('Operador');
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAutTin.pLiberarAcessoEmCascata;
Var
  LIndex: Integer;
begin
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcessoAutTin.LiberarAcessoSubrotinas(FDireitoAcessoSelecionado);
  Finally
    trvMenu.Select(trvMenu.Items[LIndex]);
  End;
end;

procedure TfrmDirAutTin.pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode;
  strKey: String);
Var
  intIndice: Integer;
  NoFilho: TTreeNode;
begin
  If Item.Caption <> '-' Then
    If Item.Hint = '' Then
      Item.Hint := Item.Name;

  If (Item.Count > 0) Then
  Begin
    If (Item.Caption <> '-') and (Item.Tag <> 7654321) Then
    Begin
      NoPai := trvMenu.Items.AddChild(NoPai, AnsiReplaceStr(Item.Caption, '&', ''));
      NoPai.ImageIndex := 0;
      NoPai.SelectedIndex := 0;
      NoPai.StateIndex := 0;
      NoPai.ExpandedImageIndex := 0;
      stlDireitosAcesso.AddObject(Item.Hint, Item);
    End;

    For intIndice := 0 To Item.Count - 1 Do
      pMontaTreeView(Item.Items[intIndice], NoPai, strKey);
  End
  Else
  Begin
    If (Item.Caption <> '-') and (Item.Tag <> 7654321) Then
    Begin
      NoFilho := trvMenu.Items.AddChild(NoPai, AnsiReplaceStr(Item.Caption, '&', ''));
      NoFilho.ImageIndex := 1;
      NoFilho.SelectedIndex := 1;
      NoFilho.StateIndex := 1;
      NoFilho.ExpandedImageIndex := 1;
      stlDireitosAcesso.AddObject(Item.Hint, Item);
    End;
  End;
end;

procedure TfrmDirAutTin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape:
      If fCheckParent(ActiveControl, FFrmPermissaoAcesso) Then
      Begin
        pSetFocus(trvMenu);
      End;

    VK_F2: btnHerOpe.Click;
    VK_F3: btnHerGpo.Click;
    VK_F4: btnAceTot.Click;
    VK_F5: btnRemTot.Click;
  End;

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    If fCheckParent(ActiveControl, FFrmPermissaoAcesso) Then
    Begin
      pSetFocus(FFrmPermissaoAcesso.edtPesquisar);
    End;
  End;
end;

end.

