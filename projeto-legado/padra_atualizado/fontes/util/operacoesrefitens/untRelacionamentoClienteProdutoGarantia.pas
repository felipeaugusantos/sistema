unit untRelacionamentoClienteProdutoGarantia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Vcl.Mask,
  MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, QColorLabel,
  Uni, untGravando, cxCheckBox, untZClient, cxMemo, cxTextEdit,
  cxButtonEdit, cxDropDownEdit, cxCalendar, cxGridBandedTableView,
  cxGridDBBandedTableView, untIRelacionamentoClienteProdutoGarantia,
  untTRelacionamentoClienteProdutoGarantia;

type
  TfrmRelacionamentoClienteProdutoGarantia = class(TfrmPaiSimples)
    pnlFiltro: TPanel;
    Label6: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label8: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    pnlGrid: TPanel;
    btnExcluirRelac: TBitBtnLocked;
    btnManutencao: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgProdutos: TcxGrid;
    cxgProdutosLevel1: TcxGridLevel;
    dtsProdutos: TDataSource;
    cxvProdutos: TcxGridDBBandedTableView;
    cxgProdutosCODCLI: TcxGridDBBandedColumn;
    cxgProdutosNOMCLI: TcxGridDBBandedColumn;
    cxgProdutosCODITE: TcxGridDBBandedColumn;
    cxgProdutosDESITE: TcxGridDBBandedColumn;
    cxgProdutosCODITC: TcxGridDBBandedColumn;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnExcluirRelacClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnManutencaoClick(Sender: TObject);
    procedure cxvProdutosEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxvProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliEnter(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure btnAdicionarEnter(Sender: TObject);
    procedure btnCancelaItemEnter(Sender: TObject);
    procedure cxgProdutosEnter(Sender: TObject);
  private
    { Private declarations }
    FQryCadCli: TUniQuery;
    FQryCadIte: TUniQuery;

    FCdsProdutos: TZClient;

    FRelacionamento: IRelacionamentoClienteProdutoGarantia;

    procedure CarregaCliente;
    procedure CarregaItem;
    procedure AtribuiTabelas;
    procedure AbreConsulta;
    function SqlConsulta: String;
    procedure FechaConsulta;

    procedure SetaParametroCodCli;
    procedure SetaParametroCodIte;

    function RetornaFiltrosConsultaCodCli: String;
    function RetornaFiltrosConsultaCodIte: String;

    procedure SetaParametrosConsulta;
    procedure ValidaCampo(const ACampo, ACampoDescricao: String);
    procedure OnBeforePost(ADataSet: TDataSet);
    procedure AtualizaProdutoManutencao(AKey: Char);
    procedure HabilitaEdicaoCampoGrid(const AValue: Boolean);
    procedure HabilitaBotoesManutencao(const AValue: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRelacionamentoClienteProdutoGarantia: TfrmRelacionamentoClienteProdutoGarantia;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux;

{$R *.dfm}

{ TfrmRelacionamentoClienteProdutoGarantia }

procedure TfrmRelacionamentoClienteProdutoGarantia.AtualizaProdutoManutencao(AKey: Char);
Var
  LArrSel: TConsultasArray;
begin
  If Not fPesqItem(conIteSimples, Self, nil, nil, FQryCadIte, AKey, LArrSel, True, nil, 'Consulta de Itens', '1') Then
    Exit;

  Try
    FCdsProdutos.FieldByName('CODITE').AsString := FQryCadIte.FieldByName('ITE_CODITE').AsString;
    FCdsProdutos.Post;
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TfrmRelacionamentoClienteProdutoGarantia.AtualizaProdutoManutencao]');
    end;
  End;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnAdicionarClick(
  Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(AbreConsulta, 'Aguarde, Carregando Produtos...', '');
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnAdicionarEnter(
  Sender: TObject);
begin
  inherited;
  HabilitaBotoesManutencao(False);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnExcluirRelacClick(Sender: TObject);
begin
  inherited;

  If Not FCdsProdutos.Active Then
    Exit;

  If FCdsProdutos.RecordCount = 0 Then
    Exit;

  If fMensagem('ATENÇÃO!', 'Deseja realmente excluir o registro?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    FRelacionamento.Excluir(FCdsProdutos.FieldByName('AUTINC').AsString);
    FCdsProdutos.Delete;
    pSetFocus(cxgProdutos);
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TfrmRelacionamentoClienteProdutoGarantia.btnExcluirRelacClick]');
    end;
  End;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnManutencaoClick(
  Sender: TObject);
var
  LIndex: integer;
  LDone: Boolean;
begin
  inherited;

  If Not FCdsProdutos.Active Then
    Exit;

  If FCdsProdutos.RecordCount = 0 Then
    Exit;

  LDone := True;
  HabilitaEdicaoCampoGrid(True);
  pSetFocus(cxgProdutos);
  LIndex := cxvProdutos.GetColumnByFieldName('CODITE').Index;
  cxvProdutos.datacontroller.focuscontrol(LIndex, LDone);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.cxgProdutosEnter(
  Sender: TObject);
begin
  inherited;
  HabilitaBotoesManutencao(True);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.cxvProdutosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;

  If Not cxgProdutosCODITE.Options.Editing Then
    Exit;

  If Not (FCdsProdutos.State = dsEdit) Then
    FCdsProdutos.Edit;

  If Not fEntraCons(Key) Then
    Exit;

  If Not (AItem.Index = cxgProdutosCODITE.Index) Then
  Begin
    Key := #0;
    Exit;
  End;

  AtualizaProdutoManutencao(Key);

  Key := #0;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.cxvProdutosKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If Not cxgProdutosCODITE.Options.Editing Then
    Exit;

  If (Not (FCdsProdutos.State = dsEdit)) And
     (cxgProdutosCODITE.Focused) Then
    FCdsProdutos.Edit;

  If Not fEntraCons(Key) Then
    Exit;

  If Not cxgProdutosCODITE.Focused Then
  Begin
    Key := #0;
    Exit;
  End;

  AtualizaProdutoManutencao(Key);

  Key := #0;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnCancelaItemClick(
  Sender: TObject);
begin
  inherited;
  FechaConsulta;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.btnCancelaItemEnter(
  Sender: TObject);
begin
  inherited;
  HabilitaBotoesManutencao(False);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.edtCodCliEnter(
  Sender: TObject);
begin
  inherited;
  HabilitaBotoesManutencao(False);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.edtCodCliKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If Not fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, nil, Key, arrSel) Then
    Exit;

  If fValidaCampos(edtCodCli, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.edtCodIteEnter(
  Sender: TObject);
begin
  inherited;
  HabilitaBotoesManutencao(False);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.edtCodIteKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If Not fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Exit;

  If fValidaCampos(edtCodIte, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsProdutos := TZClient.Create(Self);
  dtsProdutos.DataSet := FCdsProdutos;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCdsProdutos);
  FreeAndNil(FQryCadCli);
  FreeAndNil(FQryCadIte);
  inherited;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F9 :
            Begin
              If btnExcluirRelac.Enabled Then btnExcluirRelac.Click;
            End;
    VK_F8 :
            Begin
              If btnManutencao.Enabled Then btnManutencao.Click;
            End;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.FormShow(Sender: TObject);
begin
  inherited;
  FRelacionamento := TRelacionamentoClienteProdutoGarantia.New();
  AtribuiTabelas;
  pSetFocus(edtCodCli);
end;

function TfrmRelacionamentoClienteProdutoGarantia.RetornaFiltrosConsultaCodCli: String;
begin
  Result := '';

  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  Result := Result + ' AND ITC.ITE_CODCLI = :CODCLI ';
end;

function TfrmRelacionamentoClienteProdutoGarantia.RetornaFiltrosConsultaCodIte: String;
begin
  Result := '';

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  Result := Result + ' AND ITC.ITE_CODITE = :CODITE ';
end;

function TfrmRelacionamentoClienteProdutoGarantia.SqlConsulta: String;
begin
  Result := '';
  Result := Result + FRelacionamento.GetSQL;

  Result := Result + ' AND ITC.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + RetornaFiltrosConsultaCodCli;
  Result := Result + RetornaFiltrosConsultaCodIte;

  Result := Result + ' ORDER BY ITC.ITE_CODCLI, ITC.ITE_CODITC ';
end;

function TfrmRelacionamentoClienteProdutoGarantia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        edtNomCli.Text := 'TODOS';
      End
      Else
      Begin
        CarregaCliente;
        If FQryCadCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        edtDesIte.Text := 'TODOS';
      End
      Else
      Begin
        CarregaItem;
        If FQryCadIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Produto não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.HabilitaBotoesManutencao(
  const AValue: Boolean);
begin
  btnExcluirRelac.Enabled := AValue;
  btnManutencao.Enabled := AValue;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.HabilitaEdicaoCampoGrid(
  const AValue: Boolean);
begin
  cxgProdutosCODITE.Options.Editing := AValue;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.OnBeforePost(
  ADataSet: TDataSet);
begin
  ValidaCampo('CODITE','DESITE');
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.AbreConsulta;
begin
  Try
    cxgProdutos.Enabled := False;

    FCdsProdutos.qryQuery.Close;

    FCdsProdutos.qryQuery.SQL.Text := SqlConsulta;

    SetaParametrosConsulta;

    FCdsProdutos.fAbreClient(True, 'TfrmRelacionamentoClienteProdutoGarantia.pAbreConsulta');

    cxgProdutos.Enabled := True;

    FCdsProdutos.BeforePost := OnBeforePost;

    HabilitaEdicaoCampoGrid(False);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmConsultaPedidos.pAbreConsulta');
    End;
  End;

  pSetFocus(cxgProdutos);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.AtribuiTabelas;
begin
  FQryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  FQryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.SetaParametroCodCli;
begin
  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  FCdsProdutos.qryQuery.ParamByName('CODCLI').AsString := edtCodCli.Text;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.SetaParametroCodIte;
begin
  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  FCdsProdutos.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.SetaParametrosConsulta;
begin
  SetaParametroCodCli;
  SetaParametroCodIte;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.ValidaCampo(const ACampo, ACampoDescricao: String);
begin
  If FCdsProdutos.FieldByName(ACampo).NewValue = FCdsProdutos.FieldByName(ACampo).OldValue Then
    Exit;

  FCdsProdutos.FieldByName(ACampo).AsString := fPadL(FCdsProdutos.FieldByName(ACampo).AsString, 5,'0');
  FCdsProdutos.FieldByName(ACampoDescricao).AsString := fRetNomProduto(FCdsProdutos.FieldByName(ACampo).NewValue);

  If fEmptyStr(FCdsProdutos.FieldByName(ACampoDescricao).AsString) Then
  Begin
    fMensagem('Atenção', 'Produto não encontrado!', ['&OK']);
    FCdsProdutos.FieldByName(ACampo).AsString := '';
    Exit;
  End;

  Try
    FRelacionamento.Atualizar(FCdsProdutos.FieldByName('AUTINC').AsString, FCdsProdutos.FieldByName('CODITE').AsString);
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TfrmRelacionamentoClienteProdutoGarantia.pValidaCampo]');
    end;
  End;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.CarregaCliente;
begin
  pPesquisaCadCli(FQryCadCli, FQryCadCli, edtCodCli.Text);

  edtNomCli.Text := FQryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.CarregaItem;
begin
  pPesquisaCadIte(FQryCadIte, FQryCadIte, edtCodIte.Text);

  edtDesIte.Text := FQryCadIte.FieldByName('ITE_DESITE').AsString;
end;

procedure TfrmRelacionamentoClienteProdutoGarantia.FechaConsulta;
begin
  FCdsProdutos.Close;

  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;

  HabilitaEdicaoCampoGrid(False);
end;

end.
