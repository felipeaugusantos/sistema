unit untCadRestricaoVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untRestricaoVenda, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, EditFocus;

type
  TfrmCadRestricaoVenda = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    pnlNaoPermiteVenda: TPanel;
    Panel2: TPanel;
    lblTipoNaoPermiteVenda: TLabel;
    edtCodNaoPermiteVenda: TEditFocus;
    edtDesNaoPermiteVenda: TEditFocus;
    btnAddNaoPermiteVenda: TBitBtnLocked;
    btnCancelarNaoPermiteVenda: TBitBtnLocked;
    grdNaoPermiteVenda: TcxGridCitel;
    grdNaoPermiteVendaTv: TcxGridDBTableViewCitel;
    grdNaoPermiteVendaNpvCodigo: TcxGridDBColumn;
    grdNaoPermiteVendaNpvDescri: TcxGridDBColumn;
    grdNaoPermiteVendaLvl: TcxGridLevel;
    rdgNaoPermiteVenda: TRadioGroup;
    pnlParaDestino: TPanel;
    Panel3: TPanel;
    lblTipoParaDestino: TLabel;
    edtCodParaDestino: TEditFocus;
    edtDesParaDestino: TEditFocus;
    btnAddParaDestino: TBitBtnLocked;
    btnCancelarParaDestino: TBitBtnLocked;
    rdgParaDestino: TRadioGroup;
    grdParaDestino: TcxGridCitel;
    grdParaDestinoTv: TcxGridDBTableViewCitel;
    grdParaDestinoPdtCodigo: TcxGridDBColumn;
    grdParaDestinoPdtDescricao: TcxGridDBColumn;
    grdParaDestinoLvl: TcxGridLevel;
    dtsRtvVnd: TDataSource;
    dtsNaoPermiteVenda: TDataSource;
    dtsParaDestino: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodNaoPermiteVendaChange(Sender: TObject);
    procedure edtCodParaDestinoChange(Sender: TObject);
    procedure btnAddNaoPermiteVendaClick(Sender: TObject);
    procedure btnAddParaDestinoClick(Sender: TObject);
    procedure btnCancelarNaoPermiteVendaClick(Sender: TObject);
    procedure btnCancelarParaDestinoClick(Sender: TObject);
    procedure grdNaoPermiteVendaTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdParaDestinoTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FobjRestricaoVenda : TRestricaoVenda;

    function fValidaCamposNaoPermiteVenda: Boolean;
    function fValidaCamposParaDestino: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmCadRestricaoVenda.btnAddNaoPermiteVendaClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCamposNaoPermiteVenda Then
    Exit;

  FobjRestricaoVenda.fAdicionarNaoPermiteVenda(
    edtCodNaoPermiteVenda.Text,
    edtDesNaoPermiteVenda.Text);
end;

procedure TfrmCadRestricaoVenda.btnAddParaDestinoClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCamposParaDestino Then
    Exit;

  FobjRestricaoVenda.fAdicionarParaDestino(
    edtCodParaDestino.Text,
    edtDesParaDestino.Text);
end;

procedure TfrmCadRestricaoVenda.btnAlterarClick(Sender: TObject);
begin
  inherited;
  grdNaoPermiteVenda.Enabled := True;
  grdParaDestino.Enabled     := True;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pSetFocus(dbeDescri);
end;

procedure TfrmCadRestricaoVenda.btnCancelaClick(Sender: TObject);
begin
  inherited;
  grdNaoPermiteVenda.Enabled := False;
  grdParaDestino.Enabled     := False;

  If fEmptyStr(dbeCodigo.Text) Then
    FobjRestricaoVenda.pLimpar
  Else
  Begin
    FobjRestricaoVenda
      .CodigoRestricaoVenda(dbeCodigo.Text)
      .pCarregarInformacoes;
  End;
end;

procedure TfrmCadRestricaoVenda.btnCancelarNaoPermiteVendaClick(
  Sender: TObject);
begin
  inherited;
  edtCodNaoPermiteVenda.Clear;
  pSetFocus(edtCodNaoPermiteVenda);
end;

procedure TfrmCadRestricaoVenda.btnCancelarParaDestinoClick(Sender: TObject);
begin
  inherited;
  edtCodParaDestino.Clear;
  pSetFocus(edtCodParaDestino);
end;

procedure TfrmCadRestricaoVenda.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadResticaoVenda.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    FobjRestricaoVenda.pLimpar;
  End
  Else
    fRollBack;
end;

procedure TfrmCadRestricaoVenda.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If blnGravou Then
    Begin
      FobjRestricaoVenda
        .CodigoRestricaoVenda(dbeCodigo.Text)
        .pGravar;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadRestricaoVenda.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadRestricaoVenda.btnIncluirClick(Sender: TObject);
begin
  inherited;
  grdNaoPermiteVenda.Enabled := True;
  grdParaDestino.Enabled     := True;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  FobjRestricaoVenda.pLimpar;
end;

procedure TfrmCadRestricaoVenda.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
begin
  chrKey := '/';

  If fPesqRestricaoVenda(Self, Nil, Nil, qryTabela, chrKey) Then
  Begin
    grdNaoPermiteVenda.Enabled := False;
    grdParaDestino.Enabled     := False;

    FobjRestricaoVenda
      .CodigoRestricaoVenda(dbeCodigo.Text)
      .pCarregarInformacoes;

    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End
end;

procedure TfrmCadRestricaoVenda.edtCodNaoPermiteVendaChange(Sender: TObject);
begin
  inherited;
  edtDesNaoPermiteVenda.Clear;
end;

procedure TfrmCadRestricaoVenda.edtCodParaDestinoChange(Sender: TObject);
begin
  inherited;
  edtDesParaDestino.Clear;
end;

procedure TfrmCadRestricaoVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FobjRestricaoVenda := TRestricaoVenda
                          .New
                          .RadioGroupNaoPermiteVenda(rdgNaoPermiteVenda)
                          .EditPesquisaNaoPermiteVenda(edtCodNaoPermiteVenda)
                          .LabelTipoNaoPermiteVenda(lblTipoNaoPermiteVenda)
                          .RadioGroupParaDestino(rdgParaDestino)
                          .EditPesquisaParaDestino(edtCodParaDestino)
                          .LabelTipoParaDestino(lblTipoParaDestino)
                          .Form(Self)
                          .FncValidaCampos(fValidaCampos);

  FobjRestricaoVenda.pCarregarDadosComponentes;

  strNomeTabela := 'RTVVND';
  strNomeCampo  := 'RTV_CODIGO';
  qryTabela     := FobjRestricaoVenda.qryRestricaoVenda;

  dtsRtvVnd.DataSet          := qryTabela;
  dtsNaoPermiteVenda.DataSet := FobjRestricaoVenda.cdsNaoPermiteVenda;
  dtsParaDestino.DataSet     := FobjRestricaoVenda.cdsParaDestino;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadRestricaoVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FobjRestricaoVenda);
  inherited;
end;

function TfrmCadRestricaoVenda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodigo) Then
    begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da restrição de venda deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da restrição de venda deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If blnBuscaPorChave Then
    Begin
      If (Sender = edtCodNaoPermiteVenda) Then
        Result := fValidaCamposNaoPermiteVenda
      Else If (Sender = edtCodParaDestino) Then
        Result := fValidaCamposParaDestino
    End
  End;

  If (Not blnBuscaPorChave) And
     (Result) And
     ((Not FobjRestricaoVenda.cdsNaoPermiteVenda.Active) or
      (FobjRestricaoVenda.cdsNaoPermiteVenda.RecordCount = 0))  Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário que adicione pelo um item [NÃO PERMITE A VENDA]!', ['&O k']);
    Result := False;
  End;

  If (Not blnBuscaPorChave) And
     (Result) And
     ((Not FobjRestricaoVenda.cdsParaDestino.Active) or
      (FobjRestricaoVenda.cdsParaDestino.RecordCount = 0)) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário que adicione pelo um item [PARA O DESTINO]!', ['&O k']);
    Result := False;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadRestricaoVenda.fValidaCamposNaoPermiteVenda: Boolean;
var
  LstrMensagemErro : String;
begin
  Result := True;

  If fEmptyStr(edtCodNaoPermiteVenda.Text) Then
  Begin
    If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_FORNECEDOR Then
      fMensagem('ATENÇÃO!', 'O Fornecedor deve ser preenchido!', ['&Ok'])
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_DEPARTAMENTO Then
      fMensagem('ATENÇÃO!', 'O Departamento deve ser preenchido!', ['&Ok'])
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_MARCA Then
      fMensagem('ATENÇÃO!', 'A Marca deve ser preenchida!', ['&Ok'])
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_PRODUTO Then
      fMensagem('ATENÇÃO!', 'O Produto deve ser preenchido!', ['&Ok']);

    Result := False;
  End
  Else
  Begin
    If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_FORNECEDOR Then
    Begin
      edtDesNaoPermiteVenda.Text := fRetNomFornecedor(edtCodNaoPermiteVenda.Text);
      LstrMensagemErro := 'Esse Fornecedor não está cadastrado!';
    End
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_DEPARTAMENTO Then
    Begin
      edtDesNaoPermiteVenda.Text := fRetNomDep(edtCodNaoPermiteVenda.Text);
      LstrMensagemErro := 'Esse Departamento não está cadastrado!';
    End
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_MARCA Then
    Begin
      edtDesNaoPermiteVenda.Text := fRetNomMarca(edtCodNaoPermiteVenda.Text);
      LstrMensagemErro := 'Essa Marca não está cadastrada!';
    End
    Else If FobjRestricaoVenda.itemNaoPermiteVenda.Codigo = NPV_PRODUTO Then
    Begin
      edtDesNaoPermiteVenda.Text := fRetNomProduto(edtCodNaoPermiteVenda.Text);
      LstrMensagemErro := 'Esse Produto não está cadastrado!';
    End;

    If fEmptyStr(edtDesNaoPermiteVenda.Text) Then
    Begin
      fMensagem('ATENÇÃO!', LstrMensagemErro, ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(edtCodNaoPermiteVenda);
end;

function TfrmCadRestricaoVenda.fValidaCamposParaDestino: Boolean;
var
  LstrMensagemErro : String;
begin
  Result := True;

  If fEmptyStr(edtCodParaDestino.Text) Then
  Begin
    If FobjRestricaoVenda.itemParaDestino.Codigo = PD_ESTADO Then
      fMensagem('ATENÇÃO!', 'O Estado deve ser preenchido!', ['&Ok'])
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_CIDADE Then
      fMensagem('ATENÇÃO!', 'A Cidade deve ser preenchida!', ['&Ok'])
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_REGIAO Then
      fMensagem('ATENÇÃO!', 'A Região deve ser preenchida!', ['&Ok'])
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_CLIENTE Then
      fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);

    Result := False;
  End
  Else
  Begin
    If FobjRestricaoVenda.itemParaDestino.Codigo = PD_ESTADO Then
    Begin
      edtDesParaDestino.Text := fRetNomeEstado(edtCodParaDestino.Text);
      LstrMensagemErro := 'Esse Estado não está cadastrado!';
    End
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_CIDADE Then
    Begin
      edtDesParaDestino.Text := fRetNomCidade(edtCodParaDestino.Text);
      LstrMensagemErro := 'Essa Cidade não está cadastrada!';
    End
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_REGIAO Then
    Begin
      edtDesParaDestino.Text := fRetNomRegiao(edtCodParaDestino.Text);
      LstrMensagemErro := 'Essa Região não está cadastrada!';
    End
    Else If FobjRestricaoVenda.itemParaDestino.Codigo = PD_CLIENTE Then
    Begin
      edtDesParaDestino.Text := fRetNomCliente(edtCodParaDestino.Text);
      LstrMensagemErro := 'Esse Cliente não está cadastrado!';
    End;

    If fEmptyStr(edtDesParaDestino.Text) Then
    Begin
      fMensagem('ATENÇÃO!', LstrMensagemErro, ['&Ok']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(edtCodParaDestino);
end;

procedure TfrmCadRestricaoVenda.grdNaoPermiteVendaTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And
     (FobjRestricaoVenda.cdsNaoPermiteVenda.RecordCount > 0) Then
  Begin
    Key := 0;

    If fMensagem('', 'Deseja remover?', ['&Sim', '&Não'], 2) = 1 Then
      FobjRestricaoVenda.fRemoveNaoPermiteVenda(FobjRestricaoVenda.cdsNaoPermiteVenda.FieldByName('CODIGO').AsString);
  End;
end;

procedure TfrmCadRestricaoVenda.grdParaDestinoTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And
     (FobjRestricaoVenda.cdsParaDestino.RecordCount > 0) Then
  Begin
    Key := 0;

    If fMensagem('', 'Deseja remover?', ['&Sim', '&Não'], 2) = 1 Then
      FobjRestricaoVenda.fRemoveParaDestino(FobjRestricaoVenda.cdsParaDestino.FieldByName('CODIGO').AsString);
  End;
end;

procedure TfrmCadRestricaoVenda.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('RTV_CODIGO');
  stlCamInd.Add('RTV_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Restrição');
end;

end.
