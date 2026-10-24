unit untDirAcesso;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms, UITypes,
  Dialogs, untPai, ExtCtrls, ComCtrls, StdCtrls, Buttons, Menus, StrUtils, ClipBrd,
  DBCtrls, {Qt,} {QTypes,} DB, Uni, AppEvnts, BitBtnLockedIncrem, EditFocus,
  UniClientDataSet, Grids, DBGridCitel, DBGrids, Datasnap.DBClient, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxGDIPlusClasses, cxGroupBox, untPermissaoAcesso, System.Generics.Collections, System.ImageList,
  Math, Vcl.ImgList, cxImageList, cxButtons, System.RegularExpressions;

type
  TfrmDirAcesso = class(TfrmPai)
    popDirAcesso: TPopupMenu;
    pgcDireitosAcesso: TPageControl;
    tbDirAce: TTabSheet;
    tbPesquisar: TTabSheet;
    pnlFundo: TPanel;
    lbl3: TLabel;
    trvMenu: TTreeView;
    lbl4: TLabel;
    cdsPesquisar: TUniClientDataSet;
    strngfldPesquisarDIRACE: TStringField;
    intgrfldPesquisarINDICE: TIntegerField;
    dtsPesquisar: TDataSource;
    btnHerOpe: TCxButton;
    btnHerGpo: TCxButton;
    cdsCopia: TUniClientDataSet;
    cdsCopiaGPO_CODGPO: TIntegerField;
    cdsCopiaDIR_NOMFRM: TStringField;
    cdsCopiaOPE_CODOPE: TStringField;
    cdsCopiaDIR_ACAOUS: TStringField;
    btnAceTot: TCxButton;
    btnRemTot: TcxButton;
    cdsPesquisarDIRACE_BUSCA: TStringField;
    Panel1: TPanel;
    pnlFiltroPesquisa: TPanel;
    Image2: TImage;
    edtPesquisar: TEdit;
    Shape1: TShape;
    pnlGridPesquisa: TPanel;
    imgGridPesquisa: TImage;
    dbgPesquisar: TDBGridCitel;
    cdsPesquisarORDER: TIntegerField;
    pnlPermissaoAcesso: TPanel;
    tmrPesquisar: TTimer;
    imgIcones: TcxImageList;
    lblInformacaoPastas: TLabel;
    tmrAtualizar: TTimer;
    mnuAdicionarPermissao: TMenuItem;
    mnuRemoverPermissao: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure pCarregaMenu;
    procedure pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode; strKey: String);
    procedure trvMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pPegaNomeDireitoAcesso();
    procedure trvMenuKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarChange(Sender: TObject);
    procedure dbgPesquisarDblClick(Sender: TObject);
    procedure btnHerOpeClick(Sender: TObject);
    procedure btnHerGpoClick(Sender: TObject);
    procedure btnAceTotClick(Sender: TObject);
    procedure btnRemTotClick(Sender: TObject);
    procedure trvMenuMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure dbgPesquisarDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);
    procedure pgcDireitosAcessoChange(Sender: TObject);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrAtualizarTimer(Sender: TObject);
    procedure trvMenuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisarExit(Sender: TObject);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure mnuAdicionarPermissaoClick(Sender: TObject);
    procedure mnuRemoverPermissaoClick(Sender: TObject);
  private
    FProcessouLogoff: Boolean;
    FAbsoluteIndexSelecionado: Integer;
    FDireitoAcessoSelecionado: String;
    stlDireitosAcesso: TStringList;
    FFrmPermissaoAcesso: TfrmPermissaoAcesso;

    procedure pAfterAplicar;

    procedure pLiberarAcessoEmCascata;
    procedure pRemoverAcessoEmCascata;

    procedure pMontaCdsPesquisar;
    procedure pHerancaDireitosGrupo();
    procedure pHerancaDireitosOperador();
    procedure pHerancaDireitos(strTipoDir: String);

    procedure pCopiaDireitosOperador(strOpeDe, strOpePara: String);
    procedure pCopiaDireitosGpo(intGpoDe, intGpoPara: Integer);

    { Adicione aqui o direito de acesso que deseja ocultar }
    function fOcultarMenu(strHintMenu: String): Boolean;

    function fGetPalavrasBusca: TStringList;

    { Private declarations }
  public
    { Public declarations }
    blnPesquisar: Boolean;
    function fPesquisarDireitosDeAcesso(blnLikes: Boolean = True): Boolean;
  end;

implementation

uses untPrincipal, untModulo, untfuncoesSimples, untHerancaDireitos, untDirAcessoTotal, untTypesSistema,
  untAcessoTotal;

{$R *.dfm}

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

{ TfrmDirAcesso }
procedure TfrmDirAcesso.FormShow(Sender: TObject);
begin
  inherited;
  cdsCopia.CreateDataSet;
  fExecutarModal(pCarregaMenu, 'Carregando direitos de acesso, Aguarde ...', '');
  fExecutarModal(pMontaCdsPesquisar, 'Carregando pesquisa, Aguarde ...', '');
  trvMenu.Select(trvMenu.Items.Item[0]);
  pPegaNomeDireitoAcesso;
  pgcDireitosAcesso.ActivePage := tbPesquisar;

  If blnPesquisar Then
  Begin
    fPesquisarDireitosDeAcesso(False);
    dbgPesquisarDblClick(Nil);
  End;

  pSetFocus(edtPesquisar);
end;

procedure TfrmDirAcesso.pAfterAplicar;
begin
  pSetFocus(trvMenu);
end;

procedure TfrmDirAcesso.pCarregaMenu;
Var
  Item: TMenuItem;
  intIndice: Integer;
begin
  trvMenu.Items.BeginUpdate;
  Try
    FProcessouLogoff := False;
    For intIndice := 0 To frmPrincipal.mnuAutcomK.Items.Count - 1 Do
    Begin
      Item := frmPrincipal.mnuAutcomK.Items[intIndice];

      pMontaTreeView(Item, nil, '');

      If frmPrincipal.mnuAutcomK.Items[intIndice].Hint = 'frmLogoff' Then
        FProcessouLogoff := True;
    End;
  Finally
    trvMenu.Items.EndUpdate;
  End;
end;

procedure TfrmDirAcesso.pCopiaDireitosGpo(intGpoDe, intGpoPara: Integer);
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
    LSQL := LSQL + 'SET @PROINC = CAST(MID(@AUTINC, 4, 14) AS DECIMAL(12,0)) - 1;       ';
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
      LSQL := LSQL + 'DELETE FROM DIRGPO WHERE GPO_CODGPO = @GRUDIR;                    ';
    End;

    LSQL := LSQL + 'REPLACE INTO DIRGPO (                                               ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  GPO_CODGPO,                                                       ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPO                                                            ';
    LSQL := LSQL + 'WHERE GPO_CODGPO = @GRUORI;                                         ';
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
    LSQL := LSQL + '  "DIRGPO",                                                         ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  @GRUDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIRGPO                                                            ';
    LSQL := LSQL + 'WHERE GPO_CODGPO = @GRUORI;                                         ';

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

procedure TfrmDirAcesso.pCopiaDireitosOperador(strOpeDe, strOpePara: String);
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
    LSQL := LSQL + 'SET @PROINC = CAST(MID(@AUTINC, 4, 14) AS DECIMAL(12,0)) - 1;       ';
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
      LSQL := LSQL + 'DELETE FROM DIROPE WHERE OPE_CODOPE = @OPEDIR;                    ';
    End;

    LSQL := LSQL + 'REPLACE INTO DIROPE (                                               ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  OPE_CODOPE,                                                       ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + ')                                                                   ';
    LSQL := LSQL + 'SELECT                                                              ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIROPE                                                            ';
    LSQL := LSQL + 'WHERE OPE_CODOPE = @OPEORI;                                         ';
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
    LSQL := LSQL + '  "DIROPE",                                                         ';
    LSQL := LSQL + '  DIR_NOMFRM,                                                       ';
    LSQL := LSQL + '  @OPEDIR,                                                          ';
    LSQL := LSQL + '  NULL,                                                             ';
    LSQL := LSQL + '  DIR_ACAOUS,                                                       ';
    LSQL := LSQL + '  DIR_OSNLIB                                                        ';
    LSQL := LSQL + 'FROM                                                                ';
    LSQL := LSQL + '  DIROPE                                                            ';
    LSQL := LSQL + 'WHERE OPE_CODOPE = @OPEORI;                                         ';

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

{ ******************************************* }
{ * MONTA A TREEVIEW COM AS OPÇÕES DO MENU  * }
{ ****************************************DV* }
procedure TfrmDirAcesso.pMontaTreeView(Item: TMenuItem; NoPai: TTreeNode; strKey: String);
Var
  intIndice: Integer;
  NoFilho: TTreeNode;
  strRegex: string;
  rgxExpReg: TRegEx;
  mclMatchCol: TMatchCollection;
  blnInsereFilho: Boolean;
begin

  If Not fOcultarMenu(Item.Hint) Then
  Begin
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
        // Req 307958, tratado para não exibir menus de relatórios do editor não visíveis, válido somente para quando houver CODREL
        strRegex := '(?-i)frm[0-9][0-9][0-9][0-9][0-9][0-9]Rel';
        rgxExpReg := TRegEx.Create(strRegex);
        mclMatchCol := rgxExpReg.Matches(Item.Hint);
        blnInsereFilho := Not ((mclMatchCol.Count > 0) And (Not Item.Visible));

        If blnInsereFilho Then
        Begin
          NoFilho := trvMenu.Items.AddChild(NoPai, AnsiReplaceStr(Item.Caption, '&', ''));
          NoFilho.ImageIndex := IIF(FProcessouLogoff, 2, 1);
          NoFilho.SelectedIndex := IIF(FProcessouLogoff, 2, 1);
          NoFilho.StateIndex := IIF(FProcessouLogoff, 2, 1);
          NoFilho.ExpandedImageIndex := IIF(FProcessouLogoff, 2, 1);
          stlDireitosAcesso.AddObject(Item.Hint, Item);
        End;
      End;
    End;

  End;

end;

procedure TfrmDirAcesso.tmrAtualizarTimer(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  pnlPermissaoAcesso.Caption := '';
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAcesso.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  fPesquisarDireitosDeAcesso;
end;

procedure TfrmDirAcesso.trvMenuClick(Sender: TObject);
begin
  inherited;
  tmrAtualizar.Enabled := False;
  lblInformacaoPastas.Visible := False;
  FFrmPermissaoAcesso.Visible := False;
  pnlPermissaoAcesso.Caption := 'Atualizando ...';
  tmrAtualizar.Enabled := True;
End;

procedure TfrmDirAcesso.FormActivate(Sender: TObject);
begin
  inherited;
  Self.FormResize(nil);
end;

procedure TfrmDirAcesso.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If frmModulo.GetCurrentConnection.InTransaction Then
  Begin
    If fMensagem('', 'Deseja salvar as alterações?', ['', '']) = 1 Then
      fCommit
    Else
      fRollBack;
  End;

  inherited;

  cdsCopia.EmptyDataSet;
  cdsCopia.Close;

  FreeAndNil(stlDireitosAcesso);
end;

procedure TfrmDirAcesso.pgcDireitosAcessoChange(Sender: TObject);
begin
  inherited;
  If pgcDireitosAcesso.ActivePage = tbPesquisar Then
    pSetFocus(edtPesquisar);
end;

procedure TfrmDirAcesso.pHerancaDireitos(strTipoDir: String);
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

procedure TfrmDirAcesso.pHerancaDireitosGrupo;
begin
  pHerancaDireitos('Grupo');
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAcesso.pHerancaDireitosOperador;
begin
  pHerancaDireitos('Operador');
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAcesso.pMontaCdsPesquisar;
Var
  intIndex: Integer;
  LDirAce: String;
  LHint: String;
  LOrder: Integer;

  function fGetDirAce(Item: TTreeNode): String;
  begin
    If Not Assigned(Item) Then
      Exit;

    Result := '';

    If Assigned(Item.Parent) Then
      Result := fGetDirAce(Item.Parent);

    Result := Result + ' > ' + Item.Text;
  end;

  function fGetOrder(AItem: TMenuItem): Integer;
  begin
    If FProcessouLogoff Then
      Exit(999);
    Result := AItem.Parent.IndexOf(AItem);
    If AItem.Parent.Name <> '' Then
      Result := fGetOrder(AItem.Parent);
  end;

begin
  FProcessouLogoff := False;

  cdsPesquisar.CreateDataSet;
  cdsPesquisar.DisableControls;
  Try
    For intIndex := 0 To trvMenu.Items.Count - 1 Do
    Begin
      LDirAce := fGetDirAce(trvMenu.Items[intIndex]);
      LOrder := fGetOrder(TMenuItem(stlDireitosAcesso.Objects[intIndex]));
      LHint := TMenuItem(stlDireitosAcesso.Objects[intIndex]).Hint;

      cdsPesquisar.AppendRecord([LOrder, intIndex, LDirAce, fRemoveAcento(LDirAce + ' ' + LHint)]);

      If stlDireitosAcesso[intIndex] = 'frmLogoff' Then
        FProcessouLogoff := True;
    End;

    cdsPesquisar.IndexFieldNames := 'ORDER;DIRACE';
    cdsPesquisar.First;
  Finally
    cdsPesquisar.EnableControls;
  End;
end;

function TfrmDirAcesso.fGetPalavrasBusca: TStringList;
Var
  strPalavras: String;
begin
  Result := TStringList.Create;

  strPalavras := Trim(edtPesquisar.Text);

  While Pos('  ', strPalavras) > 0 Do
    strPalavras := AnsiReplaceStr(strPalavras, '  ', ' ');

  Result.Text := AnsiReplaceStr(strPalavras, ' ', #13#10);
end;

function TfrmDirAcesso.fPesquisarDireitosDeAcesso(blnLikes: Boolean = True): Boolean;
Var
  strFilter: String;
  strPalavra: String;
  stlPalavras: TStringList;
begin
  inherited;
  If blnLikes Then
  Begin
    strFilter := '';
    If edtPesquisar.Text <> INFO_PESQUISA Then
    Begin
      stlPalavras := fGetPalavrasBusca;
      Try
        For strPalavra In stlPalavras Do
        Begin
          If Not fEmptyStr(strFilter) Then
            strFilter := strFilter + ' AND ';

          strFilter := strFilter + 'UPPER(DIRACE_BUSCA) LIKE UPPER(' +
            QuotedStr('%' + fRemoveAcento(strPalavra) + '%') + ')';
        End;
      Finally
        FreeAndNil(stlPalavras);
      End;
    End;
  End
  Else
    strFilter := 'DIRACE = ' + QuotedStr(edtPesquisar.Text);

  If fEmptyStr(strFilter) Then
    strFilter := '1 = 1';

  cdsPesquisar.Filtered := False;
  cdsPesquisar.Filter := strFilter;
  cdsPesquisar.Filtered := True;

  Result := Not cdsPesquisar.IsEmpty;
end;

procedure TfrmDirAcesso.mnuAdicionarPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pLiberarAcessoEmCascata, 'Realizando liberação de acesso, Aguarde ...', '');
end;

procedure TfrmDirAcesso.mnuRemoverPermissaoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pRemoverAcessoEmCascata, 'Removendo permissão de acesso, Aguarde ...', '');
end;

procedure TfrmDirAcesso.btnHerGpoClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosGrupo, 'Realizando herança de grupo de operadores, Aguarde ...', '');
end;

procedure TfrmDirAcesso.btnHerOpeClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pHerancaDireitosOperador, 'Realizando herança de operador, Aguarde ...', '');
end;

procedure TfrmDirAcesso.dbgPesquisarDblClick(Sender: TObject);
begin
  inherited;
  If cdsPesquisar.Active And Not cdsPesquisar.IsEmpty Then
  Begin
    pgcDireitosAcesso.ActivePage := tbDirAce;
    pSetFocus(trvMenu);
    trvMenu.Select(trvMenu.Items[cdsPesquisar.FieldByName('INDICE').AsInteger]);
    trvMenuClick(trvMenu);
  End;
end;

procedure TfrmDirAcesso.dbgPesquisarDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
Var
  strPalavra: String;
  stlPalavras: TStringList;
begin
  inherited;

  With TDBGridCitel(Sender) Do
  Begin
    if (DataSource = Nil) Or (DataSource.DataSet = nil) Or (Not DataSource.DataSet.Active) Or
      (DataSource.DataSet.RecordCount <= 0) Then
      Exit;

    If gdFocused In State Then
    Begin
      If fUsaLayoutNovo Then
      Begin
        Canvas.Font.Color := clBlack;
      End
      Else
      Begin
        Canvas.Brush.Color := $00F9FFBF;
        Canvas.Font.Color := clNavy;
      End;
      Canvas.FillRect(Rect);
      DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;

    If Column.FieldName = 'DIRACE' Then
    Begin
      stlPalavras := fGetPalavrasBusca;

      For strPalavra In stlPalavras Do
        HighlightCellText(TDBGridCitel(Sender), Rect, Column, strPalavra, State, clYellow, clYellow, clNavy);

      FreeAndNil(stlPalavras);
    End;

  End;

end;

procedure TfrmDirAcesso.dbgPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (ssCtrl In Shift) And (Key In [Ord('c'), Ord('C')]) Then
    Clipboard.AsText := cdsPesquisar.FieldByName('DIRACE').AsString;

  Case Key Of
    VK_RETURN: dbgPesquisarDblClick(nil);
    VK_SPACE: dbgPesquisarDblClick(nil);
    VK_UP: If cdsPesquisar.RecNo <= 1 Then pSetFocus(edtPesquisar);
    VK_ESCAPE: pSetFocus(edtPesquisar);
  End;

end;

procedure TfrmDirAcesso.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmDirAcesso.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmDirAcesso.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmDirAcesso.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (cdsPesquisar.Active And Not cdsPesquisar.IsEmpty) And
     (Key In [VK_DOWN, VK_UP, VK_RETURN]) Then
  Begin
    Case Key Of
      VK_DOWN, VK_RETURN: pSetFocus(dbgPesquisar);
    End;
  End;
end;

function TfrmDirAcesso.fOcultarMenu(strHintMenu: String): Boolean;
begin

  Result := False;

  If Not fEmptyStr(strHintMenu) Then
  Begin
    If (strHintMenu = 'ORPDVN') Then
      Result := Not fCfgSis('ORPDVN', varBoolean)
    Else If (strHintMenu = 'PVVNEF') Then
      Result := Not fCfgSis('ORPDVN', varBoolean)
    Else If (strHintMenu = 'mnuContabilidade') Then
      Result := Not fCfgSis('UTICON', varBoolean)
    Else If (strHintMenu = 'mnuTintaDeMaquina') Then
      Result := True
    Else If (strHintMenu = 'frmPgtoOnlineESiTefParChavesManutencao') Then
      Result := fCfgSis('LINKPG', varString) <> '2' ;
  End;

end;

procedure TfrmDirAcesso.pLiberarAcessoEmCascata;
Var
  LIndex: Integer;
begin
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcesso.LiberarAcessoSubrotinas(FDireitoAcessoSelecionado);
  Finally
    trvMenu.Select(trvMenu.Items[LIndex]);
  End;
end;

{ ***************************************** }
{ * PEGA O NOME DO FORM QUE O MENU CHAMA  * }
{ **************************************AF* }
procedure TfrmDirAcesso.pPegaNomeDireitoAcesso();
Var
  LHasChildren: Boolean;
Begin
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
End;

procedure TfrmDirAcesso.pRemoverAcessoEmCascata;
Var
  LIndex: Integer;
begin
  LIndex := FAbsoluteIndexSelecionado;
  Try
    TfrmPermissaoAcesso.RemoverAcessoSubrotinas(FDireitoAcessoSelecionado);
  Finally
    trvMenu.Select(trvMenu.Items[LIndex]);
  End;
end;

procedure TfrmDirAcesso.trvMenuKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    If FFrmPermissaoAcesso.Visible Then
    Begin
      pSetFocus(FFrmPermissaoAcesso.edtPesquisar);
      Exit;
    End;
  End;

  tmrAtualizar.Enabled := False;
  lblInformacaoPastas.Visible := False;
  FFrmPermissaoAcesso.Visible := False;
  pnlPermissaoAcesso.Caption := 'Atualizando ...';

  If Key In [VK_HOME, VK_END, VK_PRIOR, VK_NEXT] Then
    If (ssShift In Shift) Or (ssAlt In Shift) Or (ssCtrl In Shift) Then
      PostKeyEx32(Key, [], False);
end;

procedure TfrmDirAcesso.trvMenuKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key <> VK_Return) Or (Not FFrmPermissaoAcesso.Visible) Then
    tmrAtualizar.Enabled := True;
end;

procedure TfrmDirAcesso.trvMenuMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  If (Button = mbRight) Then
  Begin
    pPegaNomeDireitoAcesso;
    If trvMenu.Items[FAbsoluteIndexSelecionado].HasChildren Then
      popDirAcesso.Popup(fGetParentLeft(trvMenu) + X + 30, fGetParentTop(trvMenu) + Y + 30);
  End;
end;

procedure TfrmDirAcesso.FormCreate(Sender: TObject);
begin
  inherited;
  blnPesquisar := False;
  stlDireitosAcesso := TStringList.Create;
  FFrmPermissaoAcesso := TfrmPermissaoAcesso.Create(Self);
  FFrmPermissaoAcesso.Align := alClient;
  FFrmPermissaoAcesso.blnDocked := True;
  FFrmPermissaoAcesso.AfterAplicar := pAfterAplicar;
  FFrmPermissaoAcesso.Dock(pnlPermissaoAcesso, pnlPermissaoAcesso.BoundsRect);
  FFrmPermissaoAcesso.Show;
end;

procedure TfrmDirAcesso.btnRemTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotal;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotal, frmDirAcessoTotal);
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

procedure TfrmDirAcesso.btnAceTotClick(Sender: TObject);
var
  frmDirAcessoTotal: TfrmDirAcessoTotal;
begin
  inherited;
  pCriarFormularios(TfrmDirAcessoTotal, frmDirAcessoTotal);
  Try
    frmDirAcessoTotal.blnMostraGrupo := True;
    frmDirAcessoTotal.objAceTot := TAceTot.Create(stlDireitosAcesso, tdiAutcom);
    frmDirAcessoTotal.ShowModal;
  Finally
    pFreeAndNil(frmDirAcessoTotal);
  End;
  pPegaNomeDireitoAcesso;
end;

procedure TfrmDirAcesso.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Escape:
      If edtPesquisar.Focused Then
      Begin
        btnSair.Click;
      End
      Else If fCheckParent(ActiveControl, FFrmPermissaoAcesso) Then
      Begin
        pSetFocus(trvMenu);
      End
      Else
      Begin
        pgcDireitosAcesso.ActivePage := tbPesquisar;
        pSetFocus(edtPesquisar);
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
    End
    Else
    Begin
      pgcDireitosAcesso.ActivePage := tbPesquisar;
      pSetFocus(edtPesquisar);
    End;
  End;
end;

procedure TfrmDirAcesso.FormResize(Sender: TObject);
begin
  inherited;
  dbgPesquisar.Columns[0].Width := dbgPesquisar.Width - 20;
  pnlPermissaoAcesso.Width := Floor(Self.Width * 0.43);
  pPegaNomeDireitoAcesso;
end;

end.
