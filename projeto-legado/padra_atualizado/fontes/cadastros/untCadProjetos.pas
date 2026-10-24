unit untCadProjetos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untPaiCad, Vcl.ComCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, QColorLabel, MemoFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, EditFocus, UniClientDataSet, Uni,
  UniDataSetProvider, cxCurrencyEdit, DBMemoFocus,untPesqAux,untGravaArquivoPasta;

type
  TfrmCadProjetos = class(TfrmPaiCad)
    Label1: TLabel;
    Label2: TLabel;
    dbeDesPrj: TDBEditFocus;
    dbeCodPrj: TDBEditFocus;
    dtsTabela: TDataSource;
    Label3: TLabel;
    dbeSituac: TDBEditFocus;
    ColorLabel1: TColorLabel;
    Label12: TLabel;
    dbeDtaIni: TDBEditFocus;
    Label5: TLabel;
    dbeDtaPre: TDBEditFocus;
    Label6: TLabel;
    dbeDtaFin: TDBEditFocus;
    grbObservacao: TGroupBox;
    tbsRecursos: TTabSheet;
    tbsProdutosVendidos: TTabSheet;
    pnlCampos: TPanel;
    Label4: TLabel;
    lblMecCItPerVal: TLabel;
    tbsClientes: TTabSheet;
    pnlCliPrj: TPanel;
    lblCndPag: TLabel;
    btnIncCli: TBitBtnLocked;
    btnCancelCli: TBitBtnLocked;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    cxgGridCliPrj: TcxGrid;
    cxgGridCliPrjView: TcxGridDBTableView;
    cxgColCodCnd: TcxGridDBColumn;
    cxgColDescri: TcxGridDBColumn;
    cxgcxgGridCliPrj: TcxGridLevel;
    cxGridProRec: TcxGrid;
    cxGridViewProRec: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridLevelProRec: TcxGridLevel;
    cxGridViewProRecColumn1: TcxGridDBColumn;
    cxGridViewProRecColumn2: TcxGridDBColumn;
    cxGridViewProRecColumn3: TcxGridDBColumn;
    cxGridViewProRecColumn4: TcxGridDBColumn;
    cxGridViewProRecColumn5: TcxGridDBColumn;
    cxGridViewProRecColumn6: TcxGridDBColumn;
    cxGridProVen: TcxGrid;
    cxGridViewProVen: TcxGridDBTableView;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridDBColumn6: TcxGridDBColumn;
    cxGridDBColumn7: TcxGridDBColumn;
    cxGridDBColumn8: TcxGridDBColumn;
    cxGridLevelProVen: TcxGridLevel;
    cxGridViewProVenColumn1: TcxGridDBColumn;
    cxGridViewProVenColumn2: TcxGridDBColumn;
    cxGridViewProVenColumn3: TcxGridDBColumn;
    mmoObserv: TDBMemoFocus;
    Panel2: TPanel;
    Label8: TLabel;
    Panel3: TPanel;
    Label9: TLabel;
    GroupBox1: TGroupBox;
    DBEditFocus2: TDBEditFocus;
    dbeIndCon: TDBEditFocus;
    tbsServicosFaturados: TTabSheet;
    cxGridServ: TcxGrid;
    cxGridViewServ: TcxGridDBTableView;
    cxGridDBColumn9: TcxGridDBColumn;
    cxGridDBColumn10: TcxGridDBColumn;
    cxGridDBColumn11: TcxGridDBColumn;
    cxGridDBColumn12: TcxGridDBColumn;
    cxGridDBColumn13: TcxGridDBColumn;
    cxGridDBColumn14: TcxGridDBColumn;
    cxGridDBColumn15: TcxGridDBColumn;
    cxGridDBColumn16: TcxGridDBColumn;
    cxGridDBColumn17: TcxGridDBColumn;
    cxGridLevelServ: TcxGridLevel;
    Panel1: TPanel;
    Label14: TLabel;
    DBEditFocus3: TDBEditFocus;
    Label17: TLabel;
    GroupBox2: TGroupBox;
    Label18: TLabel;
    dbeValOrcProdutos: TDBEditFocus;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    GroupBox3: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    dbeValOrcServicos: TDBEditFocus;
    edtValorFatProd: TEditFocus;
    edtValorCustoProd: TEditFocus;
    edtValorMargemLucroProd: TEditFocus;
    edtValorFatServ: TEditFocus;
    edtValorCustoServ: TEditFocus;
    edtValorMargemLucroServ: TEditFocus;
    edtValorRepreseOrcServ: TEditFocus;
    Label16: TLabel;
    edtValorLucroBrutoServ: TEditFocus;
    Label19: TLabel;
    edtValorLucroBrutoProd: TEditFocus;
    edtValorRepreseOrcProd: TEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    edtTotCon: TEditFocus;
    dbeTotRec: TDBEditFocus;
    dbeTotVen: TDBEditFocus;
    dbeTotSer: TDBEditFocus;
    Label7: TLabel;
    dbeValPrj_: TDBEditFocus;
    Label29: TLabel;
    dbeValPrj: TDBEditFocus;
    edtTotalFaturado: TEditFocus;
    edtTotalCustos: TEditFocus;
    edtTotalLucroBruto: TEditFocus;
    edtTotalMargemLucro: TEditFocus;
    edtTotalRepresentatividade: TEditFocus;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    cxGridViewProRecQTDHOR: TcxGridDBColumn;
    tbsContasPagar: TTabSheet;
    Panel4: TPanel;
    Label35: TLabel;
    cxGridCADPAG: TcxGrid;
    cxGridDBCADPAGVIEW: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridDBCADPAGVIEWCTP_CODFOR: TcxGridDBColumn;
    cxGridDBCADPAGVIEWCTP_DTACAD: TcxGridDBColumn;
    cxGridDBCADPAGVIEWCTP_DTAPAG: TcxGridDBColumn;
    cxGridDBCADPAGVIEWCTP_VALORI: TcxGridDBColumn;
    cxGridDBCADPAGVIEWCTP_VALPAG: TcxGridDBColumn;
    edtDesTip: TEditFocus;
    dbeCodTip: TDBEditFocus;
    lblProjeto: TLabel;
    tbDocProjetos: TTabSheet;
    pnlArquivoPasta: TPanel;
    pnlButton: TPanel;
    edtTotPago: TEditFocus;
    cxGridDBCADPAGVIEWCTP_CODCTA: TcxGridDBColumn;
    Label36: TLabel;
    edtTotOri: TEditFocus;
    edtTotRec: TEditFocus;
    lblOco: TLabel;
    dbeCodOco: TDBEditFocus;
    edtDesOco: TEditFocus;
    tbcCreditos: TTabSheet;
    pnlTotalCreditos: TPanel;
    Label37: TLabel;
    Label38: TLabel;
    edtValRecCreditos: TEditFocus;
    edtValOriCreditos: TEditFocus;
    cxGridCreditos: TcxGrid;
    cxGridDBTableViewCreditos: TcxGridDBTableView;
    cxGridDBTableViewCreditosCliente: TcxGridDBColumn;
    cxGridDBTableViewCreditosPlanoCta: TcxGridDBColumn;
    cxGridDBTableViewCreditosDataCad: TcxGridDBColumn;
    cxGridDBTableViewCreditosDataRec: TcxGridDBColumn;
    cxGridDBTableViewCreditosValOri: TcxGridDBColumn;
    cxGridDBTableViewCreditosValRec: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnIncCliClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxgGridCliPrjViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelCliClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodTipKeyPress(Sender: TObject; var Key: Char);
    function dbeCodTipChamaCadastro(Key: Word): string;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBCADPAGVIEWCTP_CODCTAGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
    function dbeCodOcoChamaCadastro(Key: Word): string;
    procedure dbeCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDBTableViewCreditosPlanoCtaGetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    { Private declarations }
    qryCliPrj: TUniQuery;
    cdsCliPrj: TUniClientDataSet;
    dspCliPrj: TUniDataSetProvider;
    dtsCliPrj: TDataSource;
    qryProRec: TUniQuery;
    dtsProRec: TDataSource;
    qryCadPag: TUniQuery;
    dtsCadPag: TDataSource;
    qryCadRec: TUniQuery;
    dtsCadRec: TDataSource;
    qryProVen: TUniQuery;
    dtsProVen: TDataSource;
    qrySerFat: TUniQuery;
    dtsSerFat: TDataSource;
    qryTotaisProdutos: TUniQuery;
    qryTotaisServicos: TUniQuery;
    LQuery: TUniQuery;
    fltLucroBrutoProduto : Double;
    fltLucroBrutoServico : Double;
    qryConTip: TUniQuery;
    FfrmGravaArquivoPasta : TfrmGravaArquivoPasta;

    qryConOco: TUniQuery;

    procedure pCarregarTotaisProdutos;
    procedure pCarregarTotaisServicos;
    procedure TotalizarProdutoServicos;
    procedure pLimparCampos;
    procedure pCarregaTipoProjeto;
    procedure pRecalcularProjeto;
    procedure pCarregaOcorrencia;

    procedure TotalMargemLucro(const strEspDoc : String);


    Function RetornarValorDoProjeto : Double;
    procedure pMostraCamposOco(blmMos: Boolean);

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fInformouClientes: Boolean;
    function fCriaCdsClientes(AOwner: TComponent): TUniClientDataSet;
    procedure pIncluiCliente;
    procedure pGravaClientes;
    procedure pCarregaClientes(strCodPrj: String = '');
    procedure pCarregaRecursos(strCodPrj: String = '');
    procedure pCarregaContasPagar(strCodPrj: String = '');
    procedure pCarregaCreditos(strCodPrj: String = '');
    procedure pCriaCadArquivoPasta;
    procedure pCarregaVendas(strCodPrj: String = '');
    procedure pQueryAfterOpen(DataSet: TDataSet);
    procedure pQueryBeforePost(DataSet: TDataSet);
    procedure pCarregaProjeto;
    procedure pAbreTemporaria;
    procedure pInicializaIndices; override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untProjetos, untFuncIns;

{ TfrmCadProjetos }

procedure TfrmCadProjetos.btnAlterarClick(Sender: TObject);
begin
  pgcDados.ActivePage := tbsGeral;
  inherited;
  pHabilitaCodigo(dbeCodPrj, dbeCodTip, False);
  pnlCliPrj.Enabled     := True;
  cxgGridCliPrj.Enabled := pnlCliPrj.Enabled;
  mmoObserv.Enabled := True;
  pCriaCadArquivoPasta;
end;

procedure TfrmCadProjetos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlCliPrj.Enabled     := False;
  cxgGridCliPrj.Enabled := pnlCliPrj.Enabled;

  If fEmptyStr(qryTabela.FieldByName('PRJ_CODPRJ').AsString) Then
  Begin
    If cdsCliPrj.Active Then
      cdsCliPrj.EmptyDataSet;
  End;

  mmoObserv.Enabled := False;

  If qryTabela.IsEmpty then
    pLimparCampos
  else
    pCarregaTipoProjeto;

  pCriaCadArquivoPasta;
  pMostraCamposOco( Pos(dbeSituac.Text, 'I') > 0 );
  pCarregaOcorrencia;
end;

procedure TfrmCadProjetos.btnCancelCliClick(Sender: TObject);
begin
  inherited;
  edtCodCli.Clear;
  edtNomCli.Clear;
  pSetFocus(edtCodCli);
end;

procedure TfrmCadProjetos.btnExcluirClick(Sender: TObject);
  Var
    strCaminho : String;
begin
  strCaminho := ExtractFilePath(Application.ExeName)+ 'PROJETOS\' + dbeCodPrj.Text;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadProjetos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    If cdsCliPrj.Active Then
      cdsCliPrj.EmptyDataSet;
    pCriaCadArquivoPasta;
    DeleteFile(strCaminho);
    fCommit
  End
  Else
    fRollBack;

  If qryTabela.IsEmpty then
    pLimparCampos
  else
    pCarregaTipoProjeto;
end;

procedure TfrmCadProjetos.btnGravarClick(Sender: TObject);
begin
  If Not fValidaPanel(pnlCampos) Then
  Begin
    Exit;
  End;

  If Not fInformouClientes Then
  Begin
    fMensagem('ATENÇÃO!', 'É obrigatório informar um ou mais clientes para o projeto!', ['&Ok']);
    pgcDados.ActivePage := tbsClientes;
    Exit;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    pGravaClientes;
    fExecutarModal(pRecalcularProjeto,'Aguarde, recalculando projeto...','');

    //qryTabela.Refresh;

    If blnGravou Then
    Begin
      fCommit;
      pCriaCadArquivoPasta;
    End
    Else
      fRollBack;

    mmoObserv.Enabled     := False;
    cxgGridCliPrj.Enabled := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[untCadProjetos.btnGravarClick]');
      fRollBack;
    End;
  End;

end;

procedure TfrmCadProjetos.btnIncCliClick(Sender: TObject);
begin
  inherited;
  pIncluiCliente;
end;

procedure TfrmCadProjetos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodPrj, dbeCodTip, False)
  Else
    pHabilitaCodigo(dbeCodPrj, dbeCodPrj, True);

  pnlCliPrj.Enabled := True;
  mmoObserv.Enabled := True;
  cxgGridCliPrj.Enabled := pnlCliPrj.Enabled;
  If cdsCliPrj.Active Then
    cdsCliPrj.EmptyDataSet;
  qryProRec.Close;
  qryProVen.Close;
  qrySerFat.Close;
  qryCadPag.Close;
  qryCadRec.Close;

  pMostraCamposOco(False);

  pLimparCampos;
  pCriaCadArquivoPasta;
end;

procedure TfrmCadProjetos.btnPesquisaClick(Sender: TObject);
  Var
    arrPrj : TConsultasArray;
    chrKey : Char;
begin
  chrKey := '/';
  If fPesqProjetos(Self, Nil, Nil, qryTabela, chrKey, arrPrj) Then
  Begin
    pLimparCampos;
    pSetFocus(btnAlterar);
    pCarregaTipoProjeto;
    pCriaCadArquivoPasta;
    pMostraCamposOco( Pos(dbeSituac.Text, 'I') > 0 );
    pCarregaOcorrencia;
    fExecutarModal(pRecalcularProjeto,'Aguarde, recalculando projeto...','');
  End;
end;

procedure TfrmCadProjetos.cxgGridCliPrjViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Not pnlCliPrj.Enabled Then
  Begin
    Key := 0;
    Exit;
  End;

  If (Key = VK_DELETE) Then
  Begin
    If Not fEmptyStr(cdsCliPrj.FieldByName('CLI_CODPRJ').AsString) And
       TProjeto.fClienteTemLancamentosNoProjeto(cdsCliPrj.FieldByName('CLI_CODCLI').AsString,
                                                cdsCliPrj.FieldByName('CLI_CODPRJ').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse cliente tem apontamentos no projeto e por esse motivo não pode ser excluído!', ['&Ok']);
      Key := 0;
    End
    Else
    If cdsCliPrj.Active And (cdsCliPrj.RecordCount > 0) And
       (fMensagem('', 'Deseja Remover o Cliente selecionado?', ['&Sim', '&Não'], 2) = 2) Then
      Key := 0;
  End;
end;

procedure TfrmCadProjetos.cxGridDBCADPAGVIEWCTP_CODCTAGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not fEmptyStr(AText) Then
  Begin
    Insert('.',AText,3);
    Insert('.',AText,6);
  End;
end;

procedure TfrmCadProjetos.cxGridDBTableViewCreditosPlanoCtaGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If Not fEmptyStr(AText) Then
  Begin
    Insert('.',AText,3);
    Insert('.',AText,6);
  End;
end;

function TfrmCadProjetos.dbeCodOcoChamaCadastro(Key: Word): string;
begin
  Result := fChamaCadOco(Key);
end;

procedure TfrmCadProjetos.dbeCodOcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOcor: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE OCORRÊNCIAS *}
  {*****************************RV*}
  If fPesqOcorrencia(Self, dbeCodOco, edtDesOco, Nil, Key, arrOcor) Then
    pCarregaOcorrencia;
end;

function TfrmCadProjetos.dbeCodTipChamaCadastro(Key: Word): string;
begin
  Result := fChamaTipPrj(Key);
end;

procedure TfrmCadProjetos.dbeCodTipKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTip : TConsultasArray;
begin
  If fPesqTipoProjeto(Self, dbeCodTip, edtDesTip, nil, Key, arrTip) Then
  Begin
    If fValidaCampos(dbeCodTip, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProjetos.edtCodCliExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

    If fEmptyStr(edtNomCli.Text) Then
    Begin
      fMensagem('', 'Cliente não encontrado !', ['&Ok']);
      pSetFocus(edtCodCli);
    End
  End
  Else
    edtNomCli.Clear;
end;

procedure TfrmCadProjetos.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadProjetos.fInformouClientes: Boolean;
begin
  If cdsCliPrj.Active Then
    Result := cdsCliPrj.RecordCount > 0
  Else
    Result := False;
end;

procedure TfrmCadProjetos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadProjetos.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADPRJ';
  strNomeCampo      := 'PRJ_CODPRJ';
  qryTabela         := fCriaQuery(Self);
  qryTabela.AfterOpen   := pQueryAfterOpen;
  qryTabela.AfterCancel := pQueryAfterOpen;
  qryTabela.BeforePost  := pQueryBeforePost;
  dtsTabela.DataSet := qryTabela;

  qryCliPrj := fCriaQuery(Self);
  cdsCliPrj := fCriaCdsClientes(Self);
  dspCliPrj := TUniDataSetProvider.Create(Self);
  dtsCliPrj := fCriaDataSource(cdsCliPrj);
  dspCliPrj.DataSet := qryCliPrj;

  qryProRec := fCriaQuery(Self);
  dtsProRec := fCriaDataSource(qryProRec);
  qryProVen := fCriaQuery(Self);
  dtsProVen := fCriaDataSource(qryProVen);
  qrySerFat := fCriaQuery(Self);
  dtsSerFat := fCriaDataSource(qrySerFat);

  qryCadPag := fCriaQuery(Self);
  dtsCadPag := fCriaDataSource(qryCadPag);

  qryCadRec := fCriaQuery(Self);
  dtsCadRec := fCriaDataSource(qryCadRec);

  qryTotaisProdutos := fCriaQuery(Self);
  qryTotaisServicos := fCriaQuery(Self);

  LQuery  := fCriaQuery(Self);


  cxgGridCliPrjView.DataController.DataSource := dtsCliPrj;
  cxGridViewProRec.DataController.DataSource  := dtsProRec;
  cxGridViewProVen.DataController.DataSource  := dtsProVen;
  cxGridViewServ.DataController.DataSource    := dtsSerFat;
  cxGridDBCADPAGVIEW.DataController.DataSource := dtsCadPag;
  cxGridDBTableViewCreditos.DataController.DataSource := dtsCadRec;

  SetLength(arrCamposChave, 1 );
  arrCamposChave[0] := dbeCodPrj;

  fltLucroBrutoProduto := 0;
  fltLucroBrutoServico := 0;
  qryConTip  := fCriaQuery(Self);

  pMostraCamposOco(False);

  qryConOco := fCriaQuery(Self);
end;

procedure TfrmCadProjetos.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(dtsCliPrj);
  FreeAndNil(qryCliPrj);
  FreeAndNil(dtsProRec);
  FreeAndNil(dtsProVen);
  FreeAndNil(dtsSerFat);
  FreeAndNil(qryProRec);
  FreeAndNil(qryProVen);
  FreeAndNil(qrySerFat);
  FreeAndNil(cdsCliPrj);
  FreeAndNil(dspCliPrj);

  FreeAndNil(dtsCadPag);
  FreeAndNil(qryCadPag);

  FreeAndNil(dtsCadRec);
  FreeAndNil(qryCadRec);

  FreeAndNil(qryTotaisProdutos);
  FreeAndNil(qryTotaisServicos);
  FreeAndNil(LQuery);

  FreeAndNil(qryConOco);

end;

procedure TfrmCadProjetos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_Escape:btnSair.Click;
  End;
end;

function TfrmCadProjetos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodPrj) Then
    Begin
      If (fEmptyStr(dbeCodPrj.Text)) And (dbeCodPrj.Enabled) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O Código do projeto deve ser preenchido!', ['&Ok']);
      End
      {*****************************************}
      {* VERIFICA SE EXISTE O CODIGO INFORMADO *}
      {* CASO EXISTA TRAZ PARA EDICAO          *}
      {**************************************WI*}
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else If (Sender = dbeDesPrj) Then
    Begin
      If fEmptyStr(dbeDesPrj.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O campo descrição do projeto deve ser preenchido!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeDtaIni) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(dbeDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If Not (fEmptyStr(fTiraCaracEspeciais(dbeDtaPre.Text))) And
         (StrToDate(dbeDtaPre.Text) < StrToDate(dbeDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial não pode ser maior que a data prevista para finalização!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeDtaPre) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(dbeDtaPre.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data prevista para finalização deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      If Not (fEmptyStr(fTiraCaracEspeciais(dbeDtaIni.Text))) And
         (StrToDate(dbeDtaPre.Text) < StrToDate(dbeDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data prevista para finalização não pode ser menor que a data inicial!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If ((Sender = dbeValOrcProdutos) Or (Sender = dbeValOrcServicos))  Then
    begin
      If (Sender = dbeValOrcProdutos) Then
      Begin
        If fEmptyStr(dbeValOrcProdutos.Text) Then
        Begin
          dbeValOrcProdutos.Field.Text := '0,00';
        End;
      End

      Else If (Sender = dbeValOrcServicos) Then
      Begin
        If fEmptyStr(dbeValOrcServicos.Text) Then
        Begin
          dbeValOrcServicos.Field.Text := '0,00';
        End;
      End;

      dbeValPrj.Field.Value := FormatFloat('#,##0.00', RetornarValorDoProjeto);
    end

    Else If (Sender = dbeSituac) Then
    Begin
      If (Pos(dbeSituac.Text, 'I_A_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Situação deve ser A ou I!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        pMostraCamposOco( Pos(dbeSituac.Text, 'I') > 0 );
        If Pos(dbeSituac.Text, 'A') > 0 Then
        Begin
           dbeCodOco.Field.Value := null;
           dbeCodOco.Clear;
           edtDesOco.Clear;
        End;
      End;
    End

    Else If (Sender = dbeCodOco) Then
    Begin
      If (Pos(dbeSituac.Text, 'I') > 0) Then
      Begin
         If fEmptyStr(dbeCodOco.Text) Then
         Begin
           fMensagem('ATENÇÃO!', 'A ocorrência deve ser informada quando a situação for inativo!', ['&Ok']);
           Result :=False;
         End
         Else
         Begin
           pCarregaOcorrencia;
           If qryConOco.FieldByName('OCO_CODOCO').IsNull Then
           Begin
             fMensagem('ATENÇÃO!', 'Essa ocorrência não está cadastrada!', ['&O k']);
             Result := False;
           End
           Else
           Begin
             //dbeCodOco.Text := edtCodOco.Text;
             edtDesOco.Text := edtDesOco.Text;
           End;
         End;
      End;
    End

    Else If (Sender = dbeCodTip) Then
    Begin
      If fEmptyStr(dbeCodTip.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do tipo de projeto deve ser preenchido!', ['&Ok']);
        Result :=False;
      End
      Else
      Begin
        edtDesTip.Text := fCampoTabela('TIP_DESTIP', 'TIPPRJ', ['TIP_CODTIP'], [dbeCodTip.Text], False);

        If fEmptyStr(edtDesTip.Text) Then
        Begin
          fMensagem('', 'Tipo de projeto não encontrado !', ['&Ok']);
          Result := False;
          edtDesTip.Clear;
        End
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadProjetos.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('PRJ_CODPRJ');
  stlCampos.Add('PRJ_DESPRJ');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('PRJ_DESPRJ');
  stlCamInd.Add('PRJ_CODPRJ');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadProjetos.pLimparCampos;
begin
  edtDesTip.Clear;
  edtDesOco.Clear;
end;

procedure TfrmCadProjetos.pCarregaTipoProjeto;
begin
  pPesquisaTipPrj(Nil, qryConTip, dbeCodTip.Text);
  With qryConTip Do
  Begin
    edtDesTip.Text := FieldByName('TIP_DESTIP').AsString;
  End;
end;


function TfrmCadProjetos.fCriaCdsClientes(AOwner: TComponent): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'AUTOINCREM';
    DataType:= ftString;
    Size:= 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_CODPRJ';
    DataType:= ftString;
    Size:= 6;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_CODCLI';
    DataType:= ftString;
    Size:= 8;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name:= 'CLI_NOMCLI';
    DataType:= ftString;
    Size:= 60;
  End;

end;

procedure TfrmCadProjetos.pIncluiCliente;
Begin
  If Not cdsCliPrj.Active Then
    pCarregaClientes;

  With cdsCliPrj Do
  Begin

    If (Not fEmptyStr(edtCodCli.Text)) And fValidaCampos(edtCodCli, True) Then
    Begin

      If Not Locate('CLI_CODCLI', VarArrayOf([edtCodCli.Text]), []) Then
      Begin
        Insert;
        FieldByName('CLI_CODCLI').AsString := edtCodCli.Text;
        FieldByName('CLI_NOMCLI').AsString := edtNomCli.Text;
        Post;
      End;

      edtCodCli.Clear;
      edtNomCli.Clear;

      pSetFocus(edtCodCli);
    End

  End;

End;

procedure TfrmCadProjetos.pAbreTemporaria;
var
  strCodPrj: String;
begin
  strCodPrj := dbeCodPrj.Text;
  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADPRJ WHERE PRJ_CODPRJ = :CHAVE');
    ParamByName('CHAVE').AsString := strCodPrj;
    Open;
  End;
end;

procedure TfrmCadProjetos.pCarregaClientes(strCodPrj: String = '');
Begin
  TProjeto.pCarregaClientes(strCodPrj, qryCliPrj);

  cdsCliPrj.Close;
  cdsCliPrj.SetProvider(dspCliPrj);

  qryCliPrj.Open;
  pSetaClient(qryCliPrj);
  cdsCliPrj.Open;
End;

procedure TfrmCadProjetos.pCarregaContasPagar(strCodPrj: String);
begin
  TProjeto.pCarregaContasPagar(strCodPrj, qryCadPag);
  edtTotPago.Text := FormatFloat('#,##0.00',qryCadPag.FieldByName('VALOR_TOTAL_PAGO').AsFloat);
  edtTotOri.Text :=  FormatFloat('#,##0.00',qryCadPag.FieldByName('VALOR_TOTAL_ORIGINAL').AsFloat);
end;

procedure TfrmCadProjetos.pCarregaCreditos(strCodPrj: String);
begin
  TProjeto.pCarregaCreditos(strCodPrj, qryCadRec);
  edtValRecCreditos.Text := FormatFloat('#,##0.00',qryCadRec.FieldByName('VALOR_TOTAL_CREDITO_RECEBIDO').AsFloat);
  edtValOriCreditos.Text :=  FormatFloat('#,##0.00',qryCadRec.FieldByName('VALOR_TOTAL_CREDITO_ORIGINAL').AsFloat);
end;

procedure TfrmCadProjetos.pCarregaProjeto;
begin
  If Not fEmptyStr(qryTabela.FieldByName('PRJ_CODPRJ').AsString) Then
  Begin
    pCarregaContasPagar(qryTabela.FieldByName('PRJ_CODPRJ').AsString);
    pCarregaCreditos(qryTabela.FieldByName('PRJ_CODPRJ').AsString);
    pCarregaClientes(qryTabela.FieldByName('PRJ_CODPRJ').AsString);
    pCarregaRecursos(qryTabela.FieldByName('PRJ_CODPRJ').AsString);
    pCarregaVendas(qryTabela.FieldByName('PRJ_CODPRJ').AsString);
  End;

  edtTotCon.Text := FormatFloat('#,##0.00', qryTabela.FieldByName('PRJ_TOTREC').AsFloat +
                                            qryTabela.FieldByName('PRJ_TOTVEN').AsFloat +
                                            qryTabela.FieldByName('PRJ_TOTSER').AsFloat);
end;

procedure TfrmCadProjetos.pQueryAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TFloatField(qryTabela.FieldByName('PRJ_VALPRJ')).DisplayFormat := '###,#0.00';
    TFloatField(qryTabela.FieldByName('PRJ_VALPRJ')).EditFormat    := '###,#0.00';
    TFloatField(qryTabela.FieldByName('PRJ_TOTREC')).DisplayFormat := '###,#0.00';
    TFloatField(qryTabela.FieldByName('PRJ_TOTVEN')).DisplayFormat := '###,#0.00';
    TFloatField(qryTabela.FieldByName('PRJ_TOTSER')).DisplayFormat := '####,#0.00';
    TFloatField(qryTabela.FieldByName('PRJ_INDCON')).DisplayFormat := '###,#0.00';
    TDateField(qryTabela.FieldByName('PRJ_DTAINI')).EditMask       := '99/99/9999';
    TDateField(qryTabela.FieldByName('PRJ_DTAPRE')).EditMask       := '99/99/9999';
    TDateField(qryTabela.FieldByName('PRJ_DTAFIN')).EditMask       := '99/99/9999';

    TFloatField(qryTabela.FieldByName('PRJ_ORCPRO')).DisplayFormat    := '#,##0.00';
    TFloatField(qryTabela.FieldByName('PRJ_ORCSER')).DisplayFormat    := '#,##0.00';

  End;

  fExecutarModal(pCarregaProjeto, 'Aguarde, carregando...', '');

  mmoObserv.Enabled := False;
  pgcDados.ActivePage := tbsGeral;
end;

procedure TfrmCadProjetos.pQueryBeforePost(DataSet: TDataSet);
begin
  With qryTabela Do
  Begin
    If FieldByName('PRJ_SITUAC').AsString = 'I' Then
      FieldByName('PRJ_DTAFIN').AsDateTime := VS_Date
    Else
      FieldByName('PRJ_DTAFIN').Value := null;
  End;
end;

procedure TfrmCadProjetos.pRecalcularProjeto;
begin
  If Not fEmptyStr(dbeCodPrj.Text) Then
  Begin
    TProjeto.pRecalculaProjeto(dbeCodPrj.Text);
    TProjeto.pRecalculaRecursos(dbeCodPrj.Text);
    pAbreTemporaria;
  End;
end;

function TfrmCadProjetos.RetornarValorDoProjeto: Double;
Var
  LValorProduto : Double;
  LValorServico : Double;
begin
  If fEmptyStr(dbeValOrcProdutos.Text) Then
    LValorProduto := 0
  else
    LValorProduto := fstrToFloat(dbeValOrcProdutos.Text);

  If fEmptyStr(dbeValOrcServicos.Text) Then
    LValorServico := 0
  else
    LValorServico := fstrToFloat(dbeValOrcServicos.Text);

  Result := (LValorProduto + LValorServico);
end;

procedure TfrmCadProjetos.TotalizarProdutoServicos;
Var
  fltTotalFaturado  : Double;
  fltTotalCusto     : Double;
  fltTotalRepresent : Double;
begin

  fltTotalFaturado := qryTotaisProdutos.FieldByName('VALOR_FATURADO_PRODUTOS').AsFloat + qryTotaisServicos.FieldByName('VALOR_FATURADO_SERVICOS').AsFloat;
  fltTotalCusto    := qryTotaisProdutos.FieldByName('CUSTO_FATURADO_PRODUTOS').AsFloat + qryTabela.FieldByName('PRJ_TOTREC').AsFloat;
  fltTotalRepresent:= (fltTotalFaturado / RetornarValorDoProjeto) * 100;

  edtTotalFaturado.Text           := FormatFloat('#,##0.00',fltTotalFaturado);
  edtTotalCustos.Text             := FormatFloat('#,##0.00',fltTotalCusto);
  edtTotalLucroBruto.Text         := FormatFloat('#,##0.00',fltTotalFaturado - fltTotalCusto);

  edtTotalRepresentatividade.Text := FormatFloat('#,##0.00',fltTotalRepresent);

end;

procedure TfrmCadProjetos.TotalMargemLucro(const strEspDoc : String);
begin
  LQuery.SQL.Text :=
    'SELECT '+
    '    ((SUM(DET_TOTITE - DET_DESESP - DET_DESCFF) - (SUM(DET_TOTCUS )+ :SOMA_RECURSOS_ALOCADOS)) /(SUM(DET_TOTITE - DET_DESESP - DET_DESCFF))) * 100 AS TOTAL_MARGEM_LUCRO, '+
    '     ((SUM(DET_TOTITE-DET_DESESP-DET_DESCFF) / (:VALOR_ORCADO_PROD + :VALOR_ORCADO_SER) ) * 100)AS TOTAL_REPRESENTATIVIDADE'+
    '  FROM AUXMOV A '+
    '  INNER JOIN MOVGER G ON G.AUTOINCREM = A.AUX_SEQGER '+
    '  INNER JOIN MOVDET D ON D.DET_NUMDOC = G.GER_NUMDOC AND '+
    '                       D.DET_ESPDOC   = G.GER_ESPDOC AND '+
    '                       D.DET_CODCLI   = G.GER_CODCLI AND '+
    '                       D.DET_CODEMP   = G.GER_CODEMP '+
    'WHERE A.AUX_CODPRJ = :CODPRJ ';

  LQuery.ParamByName('SOMA_RECURSOS_ALOCADOS').AsFloat  := qryTabela.FieldByName('PRJ_TOTREC').AsFloat;
  LQuery.ParamByName('VALOR_ORCADO_PROD').AsFloat       := qryTabela.FieldByName('PRJ_ORCPRO').AsFloat;
  LQuery.ParamByName('VALOR_ORCADO_SER').AsFloat        := qryTabela.FieldByName('PRJ_ORCSER').AsFloat;
  LQuery.ParamByName('CODPRJ').AsString                 := qryTabela.FieldByName('PRJ_CODPRJ').AsString;
  LQuery.Open;

  edtTotalMargemLucro.Text    := FormatFloat('#,##0.00', LQuery.FieldByName('TOTAL_MARGEM_LUCRO').AsFloat);
  edtTotalRepresentatividade.Text := FormatFloat('#,##0.00', LQuery.FieldByName('TOTAL_REPRESENTATIVIDADE').AsFloat);
end;

procedure TfrmCadProjetos.pCarregaRecursos(strCodPrj: String = '');
  Var
    field: string;
    fieldCredito: String;
Begin

  field:='VALOR_TOTAL_PAGO';
  fieldCredito := 'VALOR_TOTAL_CREDITO_RECEBIDO';

  If fCfgSis('PRJCTP', varInteger) = 2 Then
   field := 'VALOR_TOTAL_ORIGINAL';

  If fCfgSis('PRJCRE', varInteger) = 2 Then
   fieldCredito := 'VALOR_TOTAL_CREDITO_ORIGINAL';

  TProjeto.pCarregaRecursos(strCodPrj, qryProRec);
  edtTotRec.Text := FormatFloat('#,##0.00',(qryTabela.FieldByName('PRJ_TOTREC').AsFloat -
                                            qryCadPag.FieldByName(field).AsFloat +
                                           (qryCadRec.FieldByName(fieldCredito).AsFloat * -1)));
End;

procedure TfrmCadProjetos.pCarregarTotaisProdutos;
begin
  qryTotaisProdutos.SQL.Text := TProjeto.fRetornarSQLTotaisProdutos;
  qryTotaisProdutos.ParamByName('VALOR_ORCADO').AsFloat := qryTabela.FieldByName('PRJ_ORCPRO').AsFloat;
  qryTotaisProdutos.ParamByName('CODPRJ').AsString      := qryTabela.FieldByName('PRJ_CODPRJ').AsString;
  qryTotaisProdutos.Open;

  edtValorFatProd.Text         := FormatFloat('#,##0.00', qryTabela.FieldByName('PRJ_TOTVEN').AsFloat);
  edtValorCustoProd.Text       := FormatFloat('#,##0.00', qryTotaisProdutos.FieldByName('CUSTO_FATURADO_PRODUTOS').AsFloat);
  edtValorMargemLucroProd.Text := FormatFloat('#,##0.00', qryTotaisProdutos.FieldByName('MARGEM_LUCRO_PRODUTO').AsFloat);
  edtValorRepreseOrcProd.Text  := FormatFloat('#,##0.00', qryTotaisProdutos.FieldByName('REPRESENTATIVIDADE_ORCAMENTO_PRODUTO').AsFloat);

  edtValorLucroBrutoProd.Text :=
    FormatFloat('#,##0.00',qryTabela.FieldByName('PRJ_TOTVEN').AsFloat - qryTotaisProdutos.FieldByName('CUSTO_FATURADO_PRODUTOS').AsFloat);

end;

procedure TfrmCadProjetos.pCarregarTotaisServicos;
begin
  qryTotaisServicos.SQL.Text := TProjeto.fRetornarSQLTotaisServicos;
  qryTotaisServicos.ParamByName('VALOR_ORCADO_SERVICO').AsFloat   := qryTabela.FieldByName('PRJ_ORCSER').AsFloat;
  qryTotaisServicos.ParamByName('SOMA_RECURSOS_ALOCADOS').AsFloat := qryTabela.FieldByName('PRJ_TOTREC').AsFloat;
  qryTotaisServicos.ParamByName('CODPRJ').AsString                := qryTabela.FieldByName('PRJ_CODPRJ').AsString;
  qryTotaisServicos.Open;

  edtValorFatServ.Text         := FormatFloat('#,##0.00',qryTotaisServicos.FieldByName('VALOR_FATURADO_SERVICOS').AsFloat);

  DBEditFocus3.Text            := FormatFloat('#,##0.00',qryTotaisServicos.FieldByName('VALOR_FATURADO_SERVICOS').AsFloat);
  edtValorMargemLucroServ.Text := FormatFloat('#,##0.00',qryTotaisServicos.FieldByName('MARGEM_LUCRO_SERVICO').AsFloat);
  edtValorRepreseOrcServ.Text  := FormatFloat('#,##0.00',qryTotaisServicos.FieldByName('REPRESENTATIVIDADE_ORCAMENTO_SERVICO').AsFloat);
  edtValorCustoServ.Text       := FormatFloat('#,##0.00',qryTabela.FieldByName('PRJ_TOTREC').AsFloat);

  edtValorLucroBrutoServ.Text  :=
    FormatFloat('#,##0.00',qryTotaisServicos.FieldByName('VALOR_FATURADO_SERVICOS').AsFloat - qryTabela.FieldByName('PRJ_TOTREC').AsFloat);
end;

procedure TfrmCadProjetos.pCarregaVendas(strCodPrj: String = '');
Begin
  TProjeto.pCarregaVendas(strCodPrj, qryProVen);
  pCarregarTotaisProdutos;

  TProjeto.pCarregaServicos(strCodPrj, qrySerFat);
  pCarregarTotaisServicos;
  TotalMargemLucro(qrySerFat.FieldByName('ESPDOC').AsString);

  TotalizarProdutoServicos;

End;

procedure TfrmCadProjetos.pCriaCadArquivoPasta;
begin
  If Not fEmptyStr(dbeCodPrj.Text) Then
  Begin
    If Assigned(FfrmGravaArquivoPasta) Then
    Begin
      FfrmGravaArquivoPasta.btnSair.Click;
      pFreeAndNil(FfrmGravaArquivoPasta);
    End;

    tbDocProjetos.TabVisible := True;
    pCriarFormularios(TfrmGravaArquivoPasta, FfrmGravaArquivoPasta);
    FfrmGravaArquivoPasta.Align := alClient;
    FfrmGravaArquivoPasta.blnModoDock := True;
    FfrmGravaArquivoPasta.blnConsulta := Not(qryTabela.State In [dsEdit]);
    FfrmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'PROJETOS\' + dbeCodPrj.Text;
    FfrmGravaArquivoPasta.Dock(pnlArquivoPasta, pnlArquivoPasta.BoundsRect);
    FfrmGravaArquivoPasta.show;
  End
  ELse
  Begin
    tbDocProjetos.TabVisible := False;
    If Assigned(FfrmGravaArquivoPasta) Then
    Begin
      FfrmGravaArquivoPasta.btnSair.Click;
      pFreeAndNil(FfrmGravaArquivoPasta);
    End;
  End;
end;

procedure TfrmCadProjetos.pGravaClientes;
Begin
  edtCodCli.Clear;
  edtNomCli.Clear;

  If Not cdsCliPrj.Active Then
    Exit;

  With cdsCliPrj Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      Edit;

      FieldByName('CLI_CODPRJ').AsString := qryTabela.FieldByName('PRJ_CODPRJ').AsString;
      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLIPRJ', VS_strCodEmp);

      Post;
      Next;
    End;

    ApplyUpdates(0);

    EnableControls;
  End;
End;

procedure TfrmCadProjetos.pCarregaOcorrencia;
begin
  If Not fEmptyStr(dbeCodOco.Text) Then
  Begin
     pPesquisaCadOco(Nil, qryConOco, dbeCodOco.Text);
     With qryConOco Do
     Begin
       edtDesOco.Text := FieldByName('OCO_DESOCO').AsString;
     End;
  End;
end;

procedure TfrmCadProjetos.pMostraCamposOco(blmMos : Boolean);
begin
  lblOco.visible    := blmMos;
  dbeCodOco.visible := blmMos;
  EdtDesOco.visible := blmMos;
end;


end.
