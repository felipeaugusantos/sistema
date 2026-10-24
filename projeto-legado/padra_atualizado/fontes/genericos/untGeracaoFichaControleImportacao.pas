unit untGeracaoFichaControleImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, MaskEditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, FilenameEditFocus, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Uni, untTGeraFCI, Data.DB,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.DBCtrls, DBEditFocus,
  System.ImageList, Vcl.ImgList, Vcl.ExtDlgs, ShlObj, 
  untFrameDirectoryEditFocus;

type
  TfrmGeracaoFichaControleImportacao = class(TfrmPai)
    pnlPrincipal: TPanel;
    btnConfirma: TBitBtnLocked;
    dtsProdutos: TDataSource;
    btnFiltrar: TBitBtnLocked;
    grbProdutos: TGroupBox;
    dbgItens: TDBGridCitel;
    grbFiltros: TGroupBox;
    lblLinhaGrupoIni: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    rdgTabPre: TRadioGroup;
    imgArquivo: TImageList;
    edtCaminho: TEditFocus;
    btnArquivo: TSpeedButton;
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruEnter(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtProdutosExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnArquivoClick(Sender: TObject);
  private
    { Private declarations }
    objGeraFci: TGeraFCI;
    FstrTABPRC : string;
    procedure LimparTela;
    function fTabelaSelecionada: Integer;
    function fTabelaDePrecoValida(const intTabelaPreco: Integer): Boolean;
    function fTabelaSelecionadaEhValida: Boolean;
  public
    { Public declarations }
    blnExportacao: Boolean;
  end;

var
  frmGeracaoFichaControleImportacao: TfrmGeracaoFichaControleImportacao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmGeracaoFichaControleImportacao.btnArquivoClick(Sender: TObject);
begin
  inherited;

  {$WARN SYMBOL_PLATFORM OFF}
  With (TFileOpenDialog.Create(nil)) Do
  Begin
    If (blnExportacao) Then
    Begin
      Title := 'Selecione o diretório...';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
    End
    Else
    Begin
      Title := 'Selecione um arquivo...';
      Options := [fdoPathMustExist, fdoForceFileSystem];
    End;

    OkButtonLabel := 'Selecionar';
    DefaultFolder := GetSpecialFolderPath(CSIDL_PERSONAL, False);

    If (Execute()) Then
    Begin
      edtCaminho.Text := FileName;
    End;
  End;
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure TfrmGeracaoFichaControleImportacao.btnConfirmaClick(Sender: TObject);
  var
    bConfirma: Boolean;
begin
  inherited;

  If (objGeraFci.cdsItens.IsEmpty) Then
  Begin
    If (blnExportacao) Then
      fMensagem('ALERTA', 'Nenhum produto para exportação foi encontrado!', ['&Ok'])
    Else
      fMensagem('ALERTA', 'Nenhum produto para importação foi encontrado!', ['&Ok']);
    Exit;
  End;

  If (blnExportacao) Then
    bConfirma := (fMensagem('ATENÇÃO', 'Deseja prosseguir com a exportação dos dados?', ['&Sim', '&Não']) = 1)
  Else
    bConfirma := (fMensagem('ATENÇÃO', 'Deseja prosseguir com a importação dos dados?', ['&Sim', '&Não']) = 1);

  If (Not bConfirma) Then
    Exit;

  If (blnExportacao) Then
  Begin
    If (fEmptyStr(edtCaminho.Text)) Then
    Begin
      fMensagem('ALERTA', 'Informe o caminho do diretório para exportação da FCI!', ['&Ok']);
      pSetFocus(edtCaminho);
    End
    Else If (not fTabelaSelecionadaEhValida) Then
    Begin
      fMensagem('ALERTA', 'Informe uma tabela de preço válida para exportação da FCI!', ['&Ok']);
      pSetFocus(edtCaminho);
    End
    Else
    Begin
      If (objGeraFci.ExportarDados(edtCaminho.Text,
                                   IntToStr(fTabelaSelecionada),
                                   fTiraCaracEspeciais(mskLinGru.Text),
                                   edtProdutos.Text)) Then
      Begin
        fMensagem('AVISO', 'Exportação da FCI realizada com sucesso!', ['&Ok']);
        LimparTela();
      End;
    End;
  End
  Else
  Begin
    If (fEmptyStr(edtCaminho.Text)) Then
    Begin
      fMensagem('ALERTA', 'Informe o caminho do arquivo para importação da FCI!', ['&Ok']);
      pSetFocus(edtCaminho);
    End
    Else
    Begin
      If (objGeraFci.ImportarDados()) Then
      Begin
        fMensagem('AVISO', 'Importação da FCI realizada com sucesso!', ['&Ok']);
        LimparTela();
      End;
    End;
  End;
end;

procedure TfrmGeracaoFichaControleImportacao.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  If (blnExportacao) Then
  Begin
    if (not fTabelaSelecionadaEhValida) then
    begin
      fMensagem('ALERTA', 'Informe uma tabela de preço válida!', ['&Ok']);
      Exit;
    end;

    If (objGeraFci.FiltrarProdutos(IntToStr(fTabelaSelecionada), mskLinGru.Text, edtProdutos.Text)) Then
      dtsProdutos.DataSet := objGeraFci.cdsItens
    Else
      dtsProdutos.DataSet := nil;
  End
  Else
  Begin
    If (fEmptyStr(edtCaminho.Text)) Then
    Begin
      fMensagem('ALERTA', 'Informe o caminho do arquivo FCI para carregar os itens!', ['&Ok']);
      pSetFocus(edtCaminho);
    End
    Else If (objGeraFci.CarregarProdutosArquivoImportacao(edtCaminho.Text)) Then
      dtsProdutos.DataSet := objGeraFci.cdsItens
    Else
      dtsProdutos.DataSet := nil;
  End;
end;

procedure TfrmGeracaoFichaControleImportacao.edtProdutosExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);

  If (fEmptyStr(edtDesProduto.Text)) And (Not fEmptyStr(edtProdutos.Text)) Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&Ok']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;
end;

procedure TfrmGeracaoFichaControleImportacao.edtProdutosKeyPress(
  Sender: TObject; var Key: Char);
  var
    qryGenIte: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;

  qryGenIte := fCriaQuery(nil);

  If (fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel,
    True, nil, 'Consulta de Itens Estrutura', '1', '', 0, False, False, 0, cdrCodIte, '', False,
    '', '', True, False, True, '', False, False, False, False, False, False, False, False,
    '', -1, False, '', True, '', '', '', '', '', '', True, False, True)) Then
    Self.SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);
end;

procedure TfrmGeracaoFichaControleImportacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(objGeraFci);
end;

procedure TfrmGeracaoFichaControleImportacao.FormCreate(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior ou igual à (1366 x 768), posiciona a tela!}
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  objGeraFci    := TGeraFCI.Create(VS_strCodEmp);
  blnExportacao := False;
  pSetaCodIte(edtProdutos);
end;

procedure TfrmGeracaoFichaControleImportacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) And
    ( (ActiveControl Is TRadioGroup) Or (ActiveControl Is TfraDirectoryEditFocus)
      Or (ActiveControl Is TFilenameEditFocus) ) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmGeracaoFichaControleImportacao.FormShow(Sender: TObject);
  var
    intCnt : Integer;
    imagem : TBitmap;
begin
  inherited;

  Try
    imagem := TBitmap.Create();

    FstrTABPRC := fCfgSis('TABPRC', varString);

    If Length(FstrTABPRC) < 7 Then
      FstrTABPRC := FstrTABPRC + StringOfChar('N', 7-Length(FstrTABPRC));

    rdgTabPre.Items.Clear();

    For intCnt := 1 To Length(FstrTABPRC) Do
    Begin
      if (FstrTABPRC[intCnt] = 'S') then
        rdgTabPre.Items.Add(IntToStr(intCnt));
    End;

    rdgTabPre.ItemIndex := 0;

    If (blnExportacao) Then
    Begin
      Self.Caption := Self.Caption + ' - Exportação para SEFAZ';
      btnFiltrar.Caption := '&Filtrar Itens';

      dbgItens.Columns[8].Visible := False;  //CODFCI
      dbgItens.Columns[9].Visible := False;  //VALFCI

      imgArquivo.GetBitmap(0, imagem);

      pSetFocus(mskLinGru);
    End
    Else
    Begin
      Self.Caption := Self.Caption + ' - Importação da SEFAZ';
      btnFiltrar.Caption := 'Carregar &Itens';

      rdgTabPre.Enabled   := False;
      mskLinGru.Enabled   := False;
      edtProdutos.Enabled := False;

      imgArquivo.GetBitmap(1, imagem);

      pSetFocus(edtCaminho);
    End;

    btnArquivo.Glyph.Assign(imagem);
  Finally
    FreeAndNil(imagem);
  End;
end;

function TfrmGeracaoFichaControleImportacao.fTabelaDePrecoValida(const intTabelaPreco: Integer): Boolean;
begin
  if (intTabelaPreco <= 0) then
    Exit(False);

  if (intTabelaPreco > Length(FstrTABPRC)) then
    Exit(False);

  Result := True;
end;

function TfrmGeracaoFichaControleImportacao.fTabelaSelecionada: Integer;
begin
  Result := StrToIntDef(rdgTabPre.Items[rdgTabPre.ItemIndex], 0);
end;

function TfrmGeracaoFichaControleImportacao.fTabelaSelecionadaEhValida: Boolean;
begin
  Result := fTabelaDePrecoValida(fTabelaSelecionada);
end;

procedure TfrmGeracaoFichaControleImportacao.LimparTela;
begin
  rdgTabPre.ItemIndex := 0;

  mskLinGru.Text   := '';
  edtDesGrupo.Text := '';

  edtProdutos.Text   := '';
  edtDesProduto.Text := '';

  edtCaminho.Text := '';

  dtsProdutos.DataSet := nil;

  pSetFocus(mskLinGru);
end;

procedure TfrmGeracaoFichaControleImportacao.mskLinGruEnter(Sender: TObject);
begin
  inherited;

  edtProdutos.Clear;
  edtDesProduto.Text := '';
end;

procedure TfrmGeracaoFichaControleImportacao.mskLinGruExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(mskLinGru.Text)) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinGru.Text);

    If (fEmptyStr(edtDesGrupo.Text)) Then
    Begin
      fMensagem('AVISO', 'Código da Linha/Grupo não encontrado.', ['&Ok']);
      mskLinGru.Clear;
      pSetFocus(mskLinGru);
    End;
  End;
end;

procedure TfrmGeracaoFichaControleImportacao.mskLinGruKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If (fPesqGrupo(Self, mskLinGru, edtDesGrupo, nil, Key, arrSel)) Then
  Begin
    If (fValidaCampos(mskLinGru, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
