unit untTrocaLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos, Uni, cadastro.Model.EquipamentoLocacao,
  cadastro.Controller.ContratoLocacaoEquipamentos, untTypesSistema,
  untTLock, untFuncoesLocEqu, untTypesLocEqu;

type
  TfrmTrocaEquipamento = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    lblTroca: TLabel;
    edtNumCon: TEditFocus;
    edtNroTrc: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    edtLocalizacao: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodVen: TEditFocus;
    pnlEntrada: TPanel;
    pnTituloEntrada: TPanel;
    cdsAcessoriosEntrada: TUniClientDataSet;
    cdsAcessoriosEntradaEQD_SEQEQL: TStringField;
    cdsAcessoriosEntradaEQD_OPEIPS: TStringField;
    cdsAcessoriosEntradaEQD_SUPIPE: TStringField;
    cdsAcessoriosEntradaEQD_OBSIPS: TStringField;
    cdsAcessoriosEntradaEQD_OBSIPE: TStringField;
    cdsAcessoriosEntradaEQD_QTDACL: TFloatField;
    cdsAcessoriosEntradaEQD_SEQCON: TStringField;
    tr: TStringField;
    cdsAcessoriosEntradaEQD_STTIPS: TStringField;
    cdsAcessoriosEntradaAUTOINCREM: TStringField;
    cdsAcessoriosEntradaEQD_SEQACL: TStringField;
    cdsAcessoriosEntradaEQD_DTAIPE: TDateTimeField;
    cdsAcessoriosEntradaEQD_AVARIA: TStringField;
    cdsAcessoriosEntradaEQD_CONFER: TStringField;
    cdsAcessoriosEntradaEQD_SUPERV: TStringField;
    cdsAcessoriosEntradaEQD_MARDES: TStringField;
    cdsAcessoriosEntradaEQD_DESCRI: TStringField;
    cdsEqlDetEntrada: TUniClientDataSet;
    cdsEqlDetEntradaAUTOINCREM: TStringField;
    StringField1: TStringField;
    cdsEqlDetEntradaEQL_NSERIE: TStringField;
    cdsEqlDetEntradaEQL_DESCRI: TStringField;
    cdsEqlDetEntradaEQD_DTAIPE: TDateTimeField;
    cdsEqlDetEntradaEQD_AVARIA: TStringField;
    cdsEqlDetEntradaEQD_OBSIPE: TMemoField;
    cdsEqlDetEntradaEQD_SUPERV: TStringField;
    cdsEqlDetEntradaEQD_CONFER: TStringField;
    cdsEqlDetEntradaEQD_MARDES: TStringField;
    cdsEqlDetEntradaEQA_MARDES: TStringField;
    dtsAcessoriosEntrada: TDataSource;
    dtsEqlDetEntrada: TDataSource;
    cdsEqlDetEntradaEQL_CODITE: TStringField;
    cdsEqlDetEntradaEQL_DESITE: TStringField;
    cdsAcessoriosEntradaACL_CODITE: TStringField;
    cdsAcessoriosEntradaACL_DESITE: TStringField;
    pnlSaida: TPanel;
    pnlTituloSaida: TPanel;
    cdsEqlDetSaida: TUniClientDataSet;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    DateTimeField1: TDateTimeField;
    StringField6: TStringField;
    MemoField1: TMemoField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    StringField12: TStringField;
    dtsEqlDetSaida: TDataSource;
    cdsAcessoriosSaida: TUniClientDataSet;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    StringField17: TStringField;
    FloatField1: TFloatField;
    StringField18: TStringField;
    StringField19: TStringField;
    StringField20: TStringField;
    StringField21: TStringField;
    StringField22: TStringField;
    DateTimeField2: TDateTimeField;
    StringField23: TStringField;
    StringField24: TStringField;
    StringField25: TStringField;
    StringField26: TStringField;
    StringField27: TStringField;
    StringField28: TStringField;
    StringField29: TStringField;
    dtsAcessoriosSaida: TDataSource;
    cdsEqlDetSaidaEQD_DTAIPS: TSQLTimeStampField;
    cdsEqlDetSaidaEQD_OBSIPS: TMemoField;
    cdsAcessoriosSaidaEQD_DTAIPS: TDateTimeField;
    pnlTotais: TPanel;
    Label10: TLabel;
    edtVlrTotIpe: TEditFocus;
    cdsEqlDetSaidaEQD_VALIPE: TFloatField;
    cdsEqlDetEntradaEQD_VALIPE: TFloatField;
    cdsAcessoriosEntradaEQD_VALIPE: TFloatField;
    btnConfirma: TBitBtnLocked;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    cdsEqlDetEntradaEQD_SEQDET: TStringField;
    cdsAcessoriosEntradaEQD_SEQDET: TStringField;
    pnlEquipamentosSaida: TPanel;
    lblEquipamentosSaida: TLabel;
    pnlEquipamento: TPanel;
    lblCodEql: TLabel;
    edtCodEql: TEditFocus;
    edtDesEql: TEditFocus;
    cxGridEquipamentoSaida: TcxGridCitel;
    cxgrdEquipamentosSaida: TcxGridDBTableViewCitel;
    cxgrdEquipamentosSaidaViewEQD_SEQEQL: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQL_DESCRI: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQL_NSERIE: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_DTAIPS: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_OBSIPS: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_CONFER: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_SUPERV: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_MARDES: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlAcessoriosSaida: TPanel;
    lblAcessoriosSaida: TLabel;
    cxGridAcessoriosSaida: TcxGridCitel;
    cxgrdAcessoriosSaida: TcxGridDBTableViewCitel;
    cxGridDBTableViewAcessoriosSaidaEQD_SEQACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_DESCRI: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_QTDACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_DTAIPS: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_CONFER: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_SUPERV: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_MARDES: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cdsAcessoriosSaidaEQD_OBSIPS: TStringField;
    cxGridDBTableViewAcessoriosSaidaEQD_OBSIPS: TcxGridDBColumn;
    pnlAcessoriosEntrada: TPanel;
    lblAcessoriosEquipamento: TLabel;
    cxGridAcessoriosEntrada: TcxGridCitel;
    cxGridDBTableViewAcessorios: TcxGridDBTableViewCitel;
    cxGridDBTableViewAcessoriosEQD_SEQACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_DESCRI: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_QTDACL: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_DTAIPE: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_AVARIA: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_OBSIPE: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_CONFER: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_SUPERV: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosEQD_MARDES: TcxGridDBColumn;
    cxGridAcessoriosEntradaLeve1: TcxGridLevel;
    pnlEquipamentoEntrada: TPanel;
    lblEquipamento: TLabel;
    cxgrdEquipamentosEntrada: TcxGridCitel;
    cxgrdEquipamentosEntradaView: TcxGridDBTableViewCitel;
    cxgrdEquipamentosEntradaViewEQD_SEQEQL: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQL_DESCRI: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQL_NSERIE: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_DTAIPE: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_AVARIA: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_OBSIPE: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_CONFER: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_SUPERV: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_MARDES: TcxGridDBColumn;
    cxgrdEquipamentosEntradaLvl: TcxGridLevel;
    Splitter3: TSplitter;
    PopupMenu1: TPopupMenu;
    cdsEqlDetSaidaEQL_DESCRI: TStringField;
    btnAdicionar: TBitBtnLocked;
    cdsEqlDetEntradaEQD_IPEREA: TStringField;
    cdsAcessoriosEntradaEQD_IPEREA: TStringField;
    cxGridDBTableViewAcessoriosEQD_IPEREA: TcxGridDBColumn;
    cxgrdEquipamentosEntradaViewEQD_IPEREA: TcxGridDBColumn;
    cdsEqlDetSaidaEQD_IPSREA: TStringField;
    cdsAcessoriosSaidaEQD_IPSREA: TStringField;
    cxgrdEquipamentosSaidaViewEQD_IPSREA: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQD_IPSREA: TcxGridDBColumn;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    cdsEqlDetEntradaEQD_QTDEQU: TFloatField;
    cdsEqlDetSaidaEQD_QTDEQU: TFloatField;
    cxgrdEquipamentosEntradaViewEQD_QTDEQU: TcxGridDBColumn;
    cxgrdEquipamentosSaidaViewEQD_QTDEQU: TcxGridDBColumn;
    cdsAcessoriosEntradaEQA_QTDTOT: TFloatField;
    cxGridDBTableViewAcessoriosEQA_QTDTOT: TcxGridDBColumn;
    cxGridDBTableViewAcessoriosSaidaEQA_QTDTOT: TcxGridDBColumn;
    cdsAcessoriosSaidaEQA_QTDTOT: TFloatField;
    cdsEqlDetEntradaEQD_EQUTRC: TStringField;
    btnAlterarCobranca: TBitBtnLocked;
    blnImprimirAditivo: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsEqlDetEntradaAfterScroll(DataSet: TDataSet);
    procedure cxgrdEquipamentosEntradaViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridDBTableViewAcessoriosCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgrdEquipamentosEntradaViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableViewAcessoriosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEqlKeyPress(Sender: TObject; var Key: Char);
    procedure cxgrdEquipamentosSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgrdAcessoriosSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure edtNroTrcKeyPress(Sender: TObject; var Key: Char);
    procedure blnImprimirAditivoClick(Sender: TObject);
    procedure cxgrdEquipamentosSaidaCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgrdAcessoriosSaidaCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarCobrancaClick(Sender: TObject);
  private
    { Private declarations }
    ObjContrato: TContratoLocacaoEquipamentos;
    ObjTroca: TTrocaContrato;
    ObjEquipamento: TEquipamentoLocacaoPrincipal;
    ObjValidacao: TValidarContrato;

    blnCarregandoItens: Boolean;
    arrSelTroca: TConsultasArray;
    qryTroca: TUniQuery;
    FobjLock: TLock;
    FTrocaCarregada: Boolean;

    procedure pCarregarDetalhamentoTroca;
    procedure pAdicionarItemTroca(var item: TItemTrocaContrato; const aCodItem, aCodEqlAnt, aCodEql: String);
    procedure pAdicionarAcessorioTroca(var item: TItemTrocaContrato; const aCodEql, aCodItem, aCodAclAnt, aCodAcl: String);
    procedure pFormatarCampos;
    procedure pLimparCampos;
    procedure pCarregarEquipamentosEntrada;
    procedure pCarregarEquipamentoSaida(item: TItemTrocaContrato; const aEquipamento: TEquipamentoLocacaoPrincipal = nil);
    procedure pCarregarAcessoriosEntrada(const blnMarcar: Boolean);
    procedure pAdicionarAcessoriosSaidaGrid(const item: TItemTrocaContrato);
    procedure pRemoverItemTroca;
    procedure pRemoverAcessorioTroca;
    procedure pMarcarEquipamentoEntrada(const blnMarcar: Boolean);
    procedure pMarcarEquipamentoSaida(const blnMarcar: Boolean);
    procedure pMarcarAcessorioEntrada(const blnMarcar: Boolean);
    procedure pMarcarAcessorioSaida(const blnMarcar: Boolean);
    procedure pAbrirTelaInspecaoEntrada(const blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoEntradaAcessorio(const blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoSaida(const blnAlterar: Boolean);
    procedure pAbrirTelaInspecaoAcessorioSaida(const blnAlterar: Boolean);
    procedure pCalcularTotais;
    procedure pEfetuarTrocaAcessorio(aItem: TItemTrocaContrato);
    procedure pImprimirAditivoContrato;
    procedure pHabilitarComponentes(blnHabilitar: Boolean);
    procedure pExibirTravaAcessoriosDiferentes;
    procedure pExibirTravaProdutosAcessoriosDif;
    procedure pExibirTravaProdutoEquipamentoDif;
    procedure pExibirTelaTravaEquipamento;

    function fCarregarEquipamentoTrocaGrid: Boolean;
    function fCarregarAcessorioTrocaGrid: Boolean;
    function fCarregarEquipamentoSaidaTrocaGrid: Boolean;
    function fCarregarAcessorioSaidaTrocaGrid: Boolean;
    function fAdicionarItemTroca(const aEqlDetAutInc: String; strCodEql: String): TItemTrocaContrato;
    function fAdicionarAcessorioTroca(const strCodEql: String; const aEqlDetAutInc: String): TItemTrocaContrato;
    function fCarregarContrato(const strAutInc, strNumeroContrato: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    function fCarregarEquipamento(const aCodEql: String): Boolean;
    function fCarregarTroca(const strNroTrc: String): Boolean;
    function fLiberacaoRealizarInspecaoEntradaEquipamento: Boolean;
    function fLiberacaoRealizarInspecaoEntradaAcessorio: Boolean;
    function fLiberacaoRealizarInspecaoSaidaEquipamento: Boolean;
    function fLiberacaoRealizarInspecaoSaidaAcessorio: Boolean;
    function fEquipamentoAdicionado(const aCodEql: String): Boolean;
    function fVerificaAcessorioSelecionado(const aCodEql, aCodAcl: String): Boolean;
    function fPodeCarregarItemTrocaAcessorio(const aItem: TItemTrocaContrato): Boolean;
    function fPodeCarregarItemTrocaEquipamento(const aItem: TItemTrocaContrato): Boolean;
    function fValidarValorLocacaoTroca(const aEquipamento: TEquipamentoLocacaoPrincipal; strCodEql: String): Boolean;
    function fValidarEquipamento(const strCodEql: String): Boolean;
    procedure AlteracaoValorCobrancaEquipamento;
    procedure AlteracaoValorCobrancaAcessorio;
    procedure AbrirTelaInspecaoCobranca(const AItem: TItemTrocaContrato);
    function PodeAlterarValorCobranca(ATipoItem: TTpEquipamentoLocacao): Boolean;
    function RetornaQuantidadeEquipamentosSelecionados: Integer;
    function RetornaQuantidadeAcessoriosSelecionados: Integer;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untInspecaoLocEquSaida,
  untInspecaoLocEquEntrada, untObservacao, untLiberacao,
  untMsgLiberacao;

{$R *.dfm}

procedure TfrmTrocaEquipamento.btnAdicionarClick(Sender: TObject);
var
  item: TItemTrocaContrato;
begin
  inherited;

  If fEmptyStr(edtCodEql.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Informe o equipamento para a troca.', ['&Ok']);
    pSetFocus(edtCodEql);
    Exit;
  End;

  If fEmptyStr(objEquipamento.Codigo) Then
  Begin
    fMensagem('ATENÇÃO', 'Equipamento não pode ser utilizado para a troca.', ['&Ok']);
    pSetFocus(edtCodEql);
    Exit;
  End;

  blnCarregandoItens := True;
  Try
    pAdicionarItemTroca(item, cdsEqlDetEntrada.FieldByName('EQD_SEQDET').AsString, cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, objEquipamento.Codigo);
    pCarregarEquipamentoSaida(item);
    pAdicionarAcessoriosSaidaGrid(item);
  Finally
    blnCarregandoItens := False;
    edtCodEql.Clear;
    edtDesEql.Clear;
    edtCodEql.Enabled := False;
  End;
end;

procedure TfrmTrocaEquipamento.btnAlterarCobrancaClick(Sender: TObject);
var
  LQtdEqlSel, LQtdAceSel: Integer;
begin
  inherited;

  LQtdEqlSel := RetornaQuantidadeEquipamentosSelecionados;
  LQtdAceSel := RetornaQuantidadeAcessoriosSelecionados;

  If ( LQtdEqlSel > 0) Then
    AlteracaoValorCobrancaEquipamento
  Else If ( LQtdAceSel > 0) Then
    AlteracaoValorCobrancaAcessorio;

  If ((LQtdEqlSel + LQtdAceSel) <= 0 ) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há itens selecionados. Verifique!', ['&Ok']);
  End;

end;

procedure TfrmTrocaEquipamento.AbrirTelaInspecaoCobranca(
  const AItem: TItemTrocaContrato);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
begin
  If Not Assigned(AItem) Then
    Exit;

  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    Try
      If AItem.TipoItem = tpPrincipal Then
      Begin
        frmInspecaoLocEquEntrada.strChaveDet := AItem.ItemAnteriorContrato.AutInc;
        frmInspecaoLocEquEntrada.ObjItemEquipamento := AItem.ItemAnteriorContrato;
      End
      Else If AItem.TipoItem = tpAcessorio Then
      Begin
        frmInspecaoLocEquEntrada.strChaveDet := AItem.acessorioAnteriorContrato.AutInc;
        frmInspecaoLocEquEntrada.ObjItemAcessorio := AItem.acessorioAnteriorContrato;
      End;

      frmInspecaoLocEquEntrada.blnAlterar := True;
      frmInspecaoLocEquEntrada.blnCarregarDados := True;
      frmInspecaoLocEquEntrada.TipoEquipamento := AItem.TipoItem;
      frmInspecaoLocEquEntrada.blnManutencaoInspecao := False;
      frmInspecaoLocEquEntrada.blnManutencaoConbranca := True;
      frmInspecaoLocEquEntrada.ShowModal;
      If frmInspecaoLocEquEntrada.ModalResult = mrOk Then
      Begin
        ObjTroca.EmAlteracaoValorCobranca := True;
        AItem.ValorCobrancaAlterado := True;
        btnConfirma.Enabled := True;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TTrocaContrato.AbrirTelaInspecaoCobranca');
      End;
    End;
  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmTrocaEquipamento.AlteracaoValorCobrancaAcessorio;
var
  LItem: TItemTrocaContrato;
begin

  If Not btnAlterarCobranca.Enabled Then
    Exit;

  If Not PodeAlterarValorCobranca(tpAcessorio) Then
    Exit;

  LItem := ObjTroca.fRetornaItemTrocaDo(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString,
                                        tpAcessorio,
                                        cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString);

  If Assigned(LItem) Then
  Begin
    AbrirTelaInspecaoCobranca(LItem);
  End;

  pCalcularTotais;
end;

procedure TfrmTrocaEquipamento.AlteracaoValorCobrancaEquipamento;
var
  LItem: TItemTrocaContrato;
begin
  If Not btnAlterarCobranca.Enabled Then
    Exit;

  If Not PodeAlterarValorCobranca(tpPrincipal) Then
    Exit;

  LItem := ObjTroca.fRetornaItemTrocaDo(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, tpPrincipal);

  If Assigned(LItem) Then
  Begin
    AbrirTelaInspecaoCobranca(LItem);
  End;

  pCalcularTotais;
end;

procedure TfrmTrocaEquipamento.blnImprimirAditivoClick(Sender: TObject);
begin
  inherited;

  pImprimirAditivoContrato;
end;

procedure TfrmTrocaEquipamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If ObjTroca.EmAlteracaoValorCobranca Then
  Begin
    ObjTroca.ConfirmaAlteracaoCobranca;
    fMensagem('ATENÇÃO', ObjTroca.MensagemRetorno, ['&Ok']);
  End
  Else
  Begin
    If ObjTroca.fConfirmarTroca Then
    Begin
      pHabilitarComponentes(False);
      edtNroTrc.Text := ObjTroca.Codigo;
      If fMensagem('ATENÇÃO','Deseja imprimir o aditivo do contrato', ['&Sim', '&Não']) = 1 Then
        pImprimirAditivoContrato;

      Self.Close;
    End
    Else
    Begin
      fMensagem('ATENÇÃO', ObjTroca.MensagemRetorno, ['&Ok']);
    End;
  End;
end;

procedure TfrmTrocaEquipamento.cdsEqlDetEntradaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If blnCarregandoItens Then
    Exit;

  If Not DataSet.IsEmpty Then
  begin
    pSetFocus(cxgrdEquipamentosEntrada);

    pCarregarDetalhamentoTroca;
  end;

end;

procedure TfrmTrocaEquipamento.cxgrdAcessoriosSaidaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;


  If FTrocaCarregada Then
  Begin
  End
  Else
  Begin
    If AViewInfo.GridRecord.Values[cxGridDBTableViewAcessoriosSaidaEQD_IPSREA.Index] = 'S' Then
    Begin
      ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmTrocaEquipamento.cxgrdAcessoriosSaidaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);

    VK_RETURN: pMarcarAcessorioSaida(cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString = 'D');
  End;

end;

procedure TfrmTrocaEquipamento.cxgrdEquipamentosEntradaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxgrdEquipamentosEntradaViewEQD_MARDES.Index] = 'M' Then
  Begin
    If FTrocaCarregada Then
    Begin
      ACanvas.Font.Color := clBlue;
    End
    Else
    Begin
      If AViewInfo.GridRecord.Values[cxgrdEquipamentosEntradaViewEQD_IPEREA.Index] = 'S' Then
        ACanvas.Font.Color := clBlue;
    End;
  End;
end;

procedure TfrmTrocaEquipamento.cxgrdEquipamentosEntradaViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: Begin
                 pMarcarEquipamentoEntrada(cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString = 'D');
               End;
    VK_F2 :  AlteracaoValorCobrancaEquipamento;
  End;
end;

procedure TfrmTrocaEquipamento.cxGridDBTableViewAcessoriosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If FTrocaCarregada Then
  Begin
    If (AViewInfo.GridRecord.Values[cxGridDBTableViewAcessoriosEQD_MARDES.Index] = 'M')Then
    Begin
      ACanvas.Font.Color := clBlue;
    End;
  End
  Else
  Begin
    If AViewInfo.GridRecord.Values[cxGridDBTableViewAcessoriosEQD_IPEREA.Index] = 'S' Then
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmTrocaEquipamento.cxGridDBTableViewAcessoriosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pMarcarAcessorioEntrada(cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString = 'D');
    VK_F2 : AlteracaoValorCobrancaAcessorio;
  End;
end;

procedure TfrmTrocaEquipamento.cxgrdEquipamentosSaidaCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[cxgrdEquipamentosSaidaViewEQD_IPSREA.Index] = 'S' Then
  Begin
    ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmTrocaEquipamento.cxgrdEquipamentosSaidaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pMarcarEquipamentoSaida(True);
  End;

end;

procedure TfrmTrocaEquipamento.edtCodEqlKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCadEql: TConsultasArray;
begin
  inherited;

  If fPesqCadastroEquipLocacao(Self, edtCodEql, edtDesEql, nil, Key, arrCadEql, False, edtNumCon.Text, ObjContrato.HoraInicial, ObjContrato.HoraFinal) Then
  Begin
    If fValidaCampos(edtCodEql, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaEquipamento.edtNroTrcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqTrocaContrato(Self, edtNroTrc, qryTroca, Key, arrSelTroca) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaEquipamento.edtNumConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumCon, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTrocaEquipamento.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmTrocaEquipamento.fCarregarContrato(
  const strAutInc, strNumeroContrato: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin
  pLimparCampos;
  FTrocaCarregada := False;
  ObjContrato.pLimpar;
  ObjTroca.pLimpar;

  pHabilitarComponentes(True);
  ObjContrato.fCarregarContrato(strAutInc, strNumeroContrato, True, strNumPed);

  If Not(ObjTroca.Valida.fVerificaPodeRealizarTroca) Then
  Begin
    If Not fEmptyStr(ObjTroca.Valida.strMensagemRetorno) Then
    Begin
      If blnExibirMsg Then
        fMensagem('ATENÇÃO', ObjTroca.Valida.strMensagemRetorno, ['&Ok']);
    End;
    Result := False;
    edtNumCon.Clear;
    Exit;
  End;

  If Not fValidaTravasContrato(objContrato.AutInc) Then
  Begin
    Result := False;
    Exit;
  End;

  ObjTroca.Contrato := ObjContrato;
  edtCodCli.Text := objContrato.CodCliente;
  edtNomCli.Text := objContrato.NomCliente;
  edtCodVen.Text := objContrato.Vendedor.Codigo;
  edtNomVen.Text := objContrato.Vendedor.Nome;
  edtLocalizacao.Text := objContrato.Localizacao;
  edtNumCon.Text := ObjContrato.NroContrato;
  edtNumPed.Text := Copy(ObjContrato.NumDocPedAdiantamento, 0, 12);

  pCarregarEquipamentosEntrada;
  pCarregarDetalhamentoTroca;

  pSetFocus(cxgrdEquipamentosEntrada);
  cxgrdEquipamentosEntradaView.DataController.FocusedRowIndex := 0;
  edtCodEql.Enabled := False;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_TROCAS_LOCEQU + objContrato.AutInc, True, False);

  Result := True;
end;

procedure TfrmTrocaEquipamento.pExibirTravaProdutoEquipamentoDif;
var
  frmObservacao: TfrmObservacao;
Begin
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Atenção!';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Lines.Add('O equipamento de saída não possui o mesmo produto vinculado que o equipamento de entrada. Sendo assim, não é permitido ' +
                                   'realizar a troca. Faça o cancelamento/encerramento do contrato em questão e depois, faça um contrato novo.');
    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Entrada: '+ cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString);
    frmObservacao.memObs.Lines.Add('Produto:' + cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESITE').AsString);
    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Saída: '+ objEquipamento.Codigo +  ' - ' + objEquipamento.Descricao);
    frmObservacao.memObs.Lines.Add('Produto:' + objEquipamento.CodigoItem +  ' - '  + objEquipamento.DescricaoItem);
    frmObservacao.memObs.SelStart := 0;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
End;

function TfrmTrocaEquipamento.fValidarEquipamento(
  const strCodEql: String): Boolean;
begin
  If fEquipamentoAdicionado(strCodEql) Then
  Begin
    Result := False;
    pMensagemOk('O equipamento ' + strCodEql + ' já foi inserido para efetuar a troca!');
    Exit;
  End;

  If ObjContrato.fEquipamentoJaInseridoNesseContrato(strCodEql) Then
  Begin
    Result := False;
    pMensagemOk('O equipamento ' + strCodEql + ' já foi inserido nesse contrato!');
    edtCodEql.Clear;
    pSetFocus(edtCodEql);
    Exit;
  End;

  If Not TContratoLocacaoEquipamentos.fEquipamentoDisponivel(strCodEql, ObjContrato, True) Then
  Begin
    Result := False;
    pSetFocus(edtCodEql);
    Exit;
  End;

  Result := True;
end;

procedure TfrmTrocaEquipamento.pExibirTelaTravaEquipamento;
var
  frmObservacao: TfrmObservacao;
Begin
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    If objEquipamento.TravaInclusao Then
    Begin
      frmObservacao.Caption := 'Equipamento ' + objEquipamento.Codigo + ' - ' + objEquipamento.Descricao +' com restrições: ';
      frmObservacao.lblMensagem.Visible := False;
      frmObservacao.memObs.Texto := objEquipamento.MensagemTravaInclusao;
      frmObservacao.memObs.SelStart := 0;
      frmObservacao.ShowModal;

      edtCodEql.Clear;
      pSetFocus(edtCodEql);
      Exit;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', objEquipamento.Mensagem, ['&O k']);
      edtCodEql.Clear;
      pSetFocus(edtCodEql);
      Exit;
    End;
  Finally
    If Assigned(frmObservacao) Then
      pFreeAndNil(frmObservacao);
  End;
End;

function TfrmTrocaEquipamento.fCarregarEquipamento(
  const aCodEql: String): Boolean;
begin
  Result := True;

  objEquipamento.pLimpar;

  If Not fValidarEquipamento(aCodEql) Then
    Exit;

  ObjValidacao.ObjContrato := ObjContrato;

  objEquipamento.pCarregaEquipamento('', aCodEql);
  If Not objEquipamento.fValidarEquipamento Then
  Begin
    pExibirTelaTravaEquipamento;
    Result := False;
  End
  Else
  Begin
    If (objEquipamento.CodigoItem <> cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString) And
       (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'N') Then
    Begin

      If ObjValidacao.fContratoPossuiAdiantamento Then
      Begin
        fMensagem('ATENÇÃO', 'Não é possível trocar o equipamento selecionado por um equipamento diferente, pois possui adiantamento realizado.', ['&Ok']);
        Result := False;
        edtCodEql.Clear;
        pSetFocus(edtCodEql);
        Exit;
      End;

      If ObjTroca.fValidarEquipamentoTrocaDiferente(cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString,
                                                    cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString,
                                                    objEquipamento) Then
      Begin
        cdsEqlDetEntrada.Edit;
        cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString := 'S';
        cdsEqlDetEntrada.Post;
      End
      Else
      Begin
        pExibirTravaProdutoEquipamentoDif;
        Result := False;
        edtCodEql.Clear;
        pSetFocus(edtCodEql);
        Exit;
      End;
    End;

    If (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'N') And
       (Not ObjTroca.fValidarAcessoriosEntradaSaidaIguais(cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString,
                                                          cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString,
                                                          objEquipamento)) Then
    Begin
      pExibirTravaAcessoriosDiferentes;
      Result := False;
      edtCodEql.Clear;
      pSetFocus(edtCodEql);
      Exit;
    End;

    If (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'N') And
       (Not ObjTroca.fValidarProdutoAcessorioEntradaSaidaIguais(cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString,
                                                                cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString,
                                                                objEquipamento)) Then
    Begin
      pExibirTravaProdutosAcessoriosDif;
      Result := False;
      edtCodEql.Clear;
      pSetFocus(edtCodEql);
      Exit;
    End;

    If (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'N') And
       (Not ObjTroca.fValidarQuantidadeAcessoriosEntradaSaidaIguais(cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString,
                                                                    cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString,
                                                                    objEquipamento)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade dos acessórios do equipamento de saída não são iguais às quantidades dos acessórios do equipamento de entrada. Sendo assim, não ' +
                            'é permitido realizar a troca. Faça o cancelamento/encerramento do contrato em questão e depois, faça um contrato novo.', ['&O k']);
      Result := False;
      edtCodEql.Clear;
      pSetFocus(edtCodEql);
      Exit;
    End;

    If (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'N') And
       (Not fValidarValorLocacaoTroca(objEquipamento, cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString)) Then
    Begin
      pMensagemOk('O valor de locação do equipamento ' + aCodEql + ' possui valor de locação diferente do equipamento devolvido. Será mantido o valor negociado!');
    End;

    edtDesEql.Text := objEquipamento.Descricao;
  End;
end;

function TfrmTrocaEquipamento.fCarregarTroca(const strNroTrc: String): Boolean;
var
  strAutInc: String;
begin
  Result := False;
  blnCarregandoItens := True;
  FTrocaCarregada    := False;
  Try
    Try
      pHabilitarComponentes(False);
      strAutInc := qryTroca.FieldByName('AUTOINCREM').AsString;

      ObjTroca.pCarregarTroca(strAutInc, strNroTrc);
      If fEmptyStr(ObjTroca.Codigo) Then
      Begin
        fMensagem('ATENÇÃO', 'Troca não encontrada!', ['&Ok']);
        Result := False;
        Exit;
      End;
      ObjContrato := ObjTroca.Contrato;

      edtCodEql.Enabled := False;

      edtNumCon.Text := objContrato.NroContrato;
      edtNroTrc.Text := ObjTroca.Codigo;
      edtCodCli.Text := objContrato.CodCliente;
      edtNomCli.Text := objContrato.NomCliente;
      edtCodVen.Text := objContrato.Vendedor.Codigo;
      edtNomVen.Text := objContrato.Vendedor.Nome;
      edtLocalizacao.Text := objContrato.Localizacao;

      fCarregarEquipamentoTrocaGrid;
      fCarregarAcessorioTrocaGrid;
      fCarregarEquipamentoSaidaTrocaGrid;
      fCarregarAcessorioSaidaTrocaGrid;

      pCalcularTotais;

      If objContrato.Status = 'A' Then
      Begin
        cxgrdEquipamentosEntrada.Enabled := True;
        cxGridAcessoriosEntrada.Enabled := True;
        FTrocaCarregada := True;
        btnAlterarCobranca.Enabled := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fCarregarTroca');
      End;
    End;
  Finally
    blnCarregandoItens := False;
  End;

end;

function TfrmTrocaEquipamento.fEquipamentoAdicionado(
  const aCodEql: String): Boolean;
begin
  Result := False;

  cdsEqlDetSaida.DisableControls;
  Try
    cdsEqlDetSaida.First;
    While Not cdsEqlDetSaida.Eof Do
    Begin    
      If (cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString = aCodEql) Then
      Begin
        Result := True;
        Break;
      End;
      cdsEqlDetSaida.Next;
    End;      
   
  Finally
    cdsEqlDetSaida.EnableControls;
  End;
end;

function TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoEntradaAcessorio: Boolean;
Var
  objLiberacao: TLiberacao;
begin

  objLiberacao := TLiberacao.Create;
  Try
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Operação que está sendo efetuada: Troca de Acessórios', alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Atenção! Operador não possui acesso liberado para realizar a inspeção de acessórios.', alCentro, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Contrato: ' + ObjContrato.NroContrato , alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + ObjContrato.CodCliente + ' - ' + ObjContrato.NomCliente, alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Equipamento: '+ cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString, alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Acessório: '+ cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString, alEsquerda, teAmbos, '', 99);
      objLiberacao.strDirAce := 'LOCIPE';
      objLiberacao.strMsgSen := 'Permitir realizar a inspeção de acessório.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoEntradaAcessorio');
      End;
    End;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoEntradaEquipamento: Boolean;
Var
  objLiberacao: TLiberacao;
  aItem: TAcessorioContratoLocacaoEquipamentos;
  intCont,
  intCnt: Integer;
begin

  objLiberacao := TLiberacao.Create;
  Try
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Operação que está sendo efetuada: Troca de Equipamentos', alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Atenção! Operador não possui acesso liberado para realizar a inspeção de equipamentos.', alCentro, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Contrato: ' + ObjContrato.NroContrato , alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + ObjContrato.CodCliente + ' - ' + ObjContrato.NomCliente, alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Equipamento: '+ cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString, alEsquerda, teAmbos, '', 99);

      For intCont := 0 to objContrato.Itens.Count  -1 Do
      Begin
        If objContrato.Itens[intCont].Equipamento.Codigo = cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
        Begin
          If objContrato.Itens[intCont].Acessorios.Count > 0 Then
            objLiberacao.objMsgLibera.pAddTexto('Acessórios: ', alEsquerda, teAmbos, '', 99);
          For intCnt := 0 to objContrato.Itens[intCont].Acessorios.Count  -1 Do
          Begin
            aItem := objContrato.Itens[intCont].Acessorios[intCnt];
            objLiberacao.objMsgLibera.pAddTexto(aItem.Acessorio.Codigo + ' - ' + aItem.Acessorio.Descricao, alEsquerda, teAmbos, '', 99);
          End;
        End;
      End;

      objLiberacao.strDirAce := 'LOCIPE';
      objLiberacao.strMsgSen := 'Permitir realizar a inspeção de equipamentos.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoEntradaEquipamento');
      End;
    End;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoSaidaAcessorio: Boolean;
Var
  objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  Try
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Operação que está sendo efetuada: Troca de Acessórios', alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Atenção! Operador não possui acesso liberado para realizar a inspeção de acessórios.', alCentro, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Contrato: ' + ObjContrato.NroContrato , alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + ObjContrato.CodCliente + ' - ' + ObjContrato.NomCliente, alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Acessório: '+ cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString +  ' - ' + cdsAcessoriosSaida.FieldByName('EQD_DESCRI').AsString, alEsquerda, teAmbos, '', 99);
      objLiberacao.strDirAce := 'LOCIPS';
      objLiberacao.strMsgSen := 'Permitir realizar a inspeção de acessórios.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoSaidaAcessorio');
      End;
    End;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

function TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoSaidaEquipamento: Boolean;
Var
  objLiberacao: TLiberacao;
  aEquipamento: TEquipamentoLocacaoPrincipal;
  intCont: Integer;
begin

  objLiberacao := TLiberacao.Create;
  aEquipamento := TEquipamentoLocacaoPrincipal.Create;
  Try
    Try
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Operação que está sendo efetuada: Troca de Equipamentos', alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Atenção! Operador não possui acesso liberado para realizar a inspeção de equipamentos.', alCentro, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddSeparador(99);
      objLiberacao.objMsgLibera.pAddTexto('Contrato: ' + ObjContrato.NroContrato , alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + ObjContrato.CodCliente + ' - ' + ObjContrato.NomCliente, alEsquerda, teAmbos, '', 99);
      objLiberacao.objMsgLibera.pAddTexto('Equipamento: '+ cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString, alEsquerda, teAmbos, '', 99);

      aEquipamento.pCarregaEquipamento(cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString);

      If aEquipamento.Acessorios.Count > 0 Then
        objLiberacao.objMsgLibera.pAddTexto('Acessórios: ', alEsquerda, teAmbos, '', 99);

      For intCont := 0 to aEquipamento.Acessorios.Count -1 Do
      Begin
        objLiberacao.objMsgLibera.pAddTexto(aEquipamento.Acessorios[intCont].Acessorio.Codigo + ' - ' + aEquipamento.Acessorios[intCont].Acessorio.Descricao, alEsquerda, teAmbos, '', 99);
      End;

      objLiberacao.strDirAce := 'LOCIPS';
      objLiberacao.strMsgSen := 'Permitir realizar a inspeção de equipamentos.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fLiberacaoRealizarInspecaoSaidaEquipamento');
      End;
    End;
  Finally
    FreeAndNil(objLiberacao);
    FreeAndNil(aEquipamento);
  End;
end;

procedure TfrmTrocaEquipamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  If Not fEmptyStr(edtNumCon.Text) Then
  Begin
    If (Not ObjTroca.EmAlteracaoValorCobranca) And (Not ObjTroca.blnTrocaRealizada) Then
    Begin
      If fMensagem('ATENÇÃO', 'Deseja sair? As informações não serão salvas.', ['&Sim', '&Não']) = 2 Then
      Begin
        CanClose := False;
      End;
    End;
  End;
end;

procedure TfrmTrocaEquipamento.FormCreate(Sender: TObject);
begin
  inherited;

  ObjContrato := TContratoLocacaoEquipamentos.Create;
  ObjTroca := TTrocaContrato.Create(ObjContrato);
  ObjEquipamento := TEquipamentoLocacaoPrincipal.Create;
  ObjValidacao := TValidarContrato.Create(ObjContrato);

  cdsEqlDetEntrada.CreateDataSet;
  cdsAcessoriosEntrada.CreateDataSet;
  cdsEqlDetSaida.CreateDataSet;
  cdsAcessoriosSaida.CreateDataSet;

  qryTroca := fCriarQuery('SELECT * FROM TRCEQL WHERE TRUE', Self);

  If Not fCfgSis('UTIACE', VarBoolean) Then
  Begin
    pnlAcessoriosEntrada.Visible := False;
    pnlAcessoriosSaida.Visible := False;
    pnlEquipamentoEntrada.Align := alClient;
    pnlEquipamentosSaida.Align := alClient;
  End;

  pFormatarCampos;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNomCli.Left;
    lblNumCon.Left := lblCodCli.Left;
    edtNroTrc.Left := edtNomCli.Left;
    lblTroca.Left := lblCodCli.Left;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmTrocaEquipamento.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_TROCAS_LOCEQU + objContrato.AutInc, False, False);
  FreeAndNil(FobjLock);

  If Assigned(ObjContrato) Then
    FreeAndNil(ObjContrato);

  If Assigned(ObjTroca) Then
    FreeAndNil(ObjTroca);

  If Assigned(ObjEquipamento) Then
    FreeAndNil(ObjEquipamento);

  If Assigned(ObjValidacao) Then
    FreeAndNil(ObjValidacao);

  FreeAndNil(qryTroca);
end;

procedure TfrmTrocaEquipamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F6  : blnImprimirAditivo.Click;
    VK_F10 : Begin
               If Not btnConfirma.Enabled Then
                 Exit;

               If (Shift = []) Then
                 btnConfirma.Click;
             End;
  End;
end;

procedure TfrmTrocaEquipamento.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmTrocaEquipamento.fPodeCarregarItemTrocaAcessorio(
  const aItem: TItemTrocaContrato): Boolean;
begin
  Result := True;

  If aItem.TipoItem = tpPrincipal Then
  Begin
    Result := False;
    Exit;
  End;

  If cxgrdEquipamentosEntrada.Enabled  Then
  Begin
    If Not aItem.blnEdicao Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  If Not Assigned(aItem.acessorioContrato) Then
  Begin
    Result := False;
    Exit;
  End;

  If cxGridAcessoriosSaida.Enabled Then
  Begin
    If aItem.acessorioAnteriorContrato.CodEquipamento <> cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
    Begin
      Result := False;
      Exit;
    End;
  End;
end;

function TfrmTrocaEquipamento.fPodeCarregarItemTrocaEquipamento(
  const aItem: TItemTrocaContrato): Boolean;
begin
  Result := True;

  If aItem.TipoItem = tpAcessorio Then
  Begin
    Result := False;
    Exit;
  End;

  If Not Assigned(aItem.itemAnteriorContrato) Then
  Begin
    Result := False;
    Exit;
  End;

  If cxGridEquipamentoSaida.Enabled Then
  Begin
    If aItem.itemAnteriorContrato.Equipamento.Codigo <> cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  If aItem.itemContrato.Equipamento.Codigo = cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TfrmTrocaEquipamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin

    If (Sender = edtNumCon) Then
    Begin
      If fEmptyStr(edtNumCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Informe o número do contrato.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fCarregarContrato('', edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', '', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEql) Then
    Begin
      If fEmptyStr(edtCodEql.Text) Then
      Begin
        edtDesEql.Clear;
      End
      Else
      Begin
        Result := fCarregarEquipamento(edtCodEql.Text);
      End;
    End

    Else If (Sender = edtNroTrc) Then
    Begin
      If Not fEmptyStr(edtNroTrc.Text) Then
      Begin
        Result := fCarregarTroca(edtNroTrc.Text);
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmTrocaEquipamento.fValidarValorLocacaoTroca(
  const aEquipamento: TEquipamentoLocacaoPrincipal; strCodEql: String): Boolean;
var
  objEqlAnterior: TEquipamentoLocacaoPrincipal;
begin
  objEqlAnterior := TEquipamentoLocacaoPrincipal.Create;
  Try
    objEqlAnterior.pCarregaEquipamento('', strCodEql);
    Result := (objEqlAnterior.ValorLocacao  =  aEquipamento.ValorLocacao);
    If Not Result Then
      Result := (objEqlAnterior.ValorLocacaoDiaria  =  aEquipamento.ValorLocacaoDiaria);
  Finally
    objEqlAnterior.Free;
  End;
end;

function TfrmTrocaEquipamento.fVerificaAcessorioSelecionado(const aCodEql,
  aCodAcl: String): Boolean;
Var
  intRecNo: Integer;
begin
  Result := False;
  blnCarregandoItens := True;
  cdsAcessoriosEntrada.DisableControls;
  intRecNo := cdsAcessoriosEntrada.RecNo;
  try
    cdsAcessoriosEntrada.First;
    try
      While Not (cdsAcessoriosEntrada.Eof) Do
      Begin
        If (cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString = aCodEql) Then
        Begin
          If  (cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString = aCodAcl) Then
          Begin
            If cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString = 'M' Then
            Begin
              Result := True;
              Break;
            End;
          End;
        End;

        cdsAcessoriosEntrada.Next;
      End;
    except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.fVerificaAcessorioSelecionado');
      End;
    end;
  finally
    cdsAcessoriosEntrada.RecNo := intRecNo;
    cdsAcessoriosEntrada.EnableControls;
    blnCarregandoItens := False;
  end;
end;

procedure TfrmTrocaEquipamento.pAbrirTelaInspecaoAcessorioSaida(
  const blnAlterar: Boolean);
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
  item: TItemTrocaContrato;
begin

  If Not (cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString = 'M') Then
    Exit;      

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  Try
    Try
      If Not fVerificaAcessoSistema('LOCIPS') Then
      Begin
        If Not fLiberacaoRealizarInspecaoSaidaAcessorio Then
        Begin
          fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para realizar a inspeção de Saída!', ['&Ok']);
          Exit;
        End;
      End;   

      item := ObjTroca.fRetornaAcessorioTroca(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString, '');

      If Not Assigned(item) Then
        Exit;         
           
      If Not Assigned(item.acessorioContrato) Then
        Exit;           
        
      frmInspecaoLocEquSaida.strChaveDet := cdsAcessoriosSaida.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquSaida.blnAlterar := blnAlterar;
      frmInspecaoLocEquSaida.blnCarregarDados := True;
      frmInspecaoLocEquSaida.TipoEquipamento := tpAcessorio;
      frmInspecaoLocEquSaida.ObjItemAcessorio := item.acessorioContrato;
      frmInspecaoLocEquSaida.ShowModal;

      If frmInspecaoLocEquSaida.ModalResult = MrOk Then
      Begin
        cdsAcessoriosSaida.Edit;
        cdsAcessoriosSaida.FieldByName('EQD_IPSREA').AsString := IIF(item.acessorioContrato.InspecaoSaidaRealizada, 'S', 'N');
        cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').AsDateTime := item.acessorioContrato.DataInspecaoSaida + item.acessorioContrato.HoraInspecaoSaida;
        cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := item.acessorioContrato.ObservacoesSaida;
        If Not fEmptyStr(item.acessorioContrato.CodConferenteSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := item.acessorioContrato.CodConferenteSaida + ' - ' + item.acessorioContrato.NomConferenteSaida;
        If Not fEmptyStr(item.acessorioContrato.CodSupervisorSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := item.acessorioContrato.CodSupervisorSaida + ' - ' + item.acessorioContrato.NomSupervisorSaida;
        cdsAcessoriosSaida.Post;

        pEfetuarTrocaAcessorio(item);
      End
      Else
      Begin
        cdsAcessoriosSaida.Edit;
        cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString := 'D';
        cdsAcessoriosSaida.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pAbrirTelaInspecaoAcessorioSaida');
      End;
    End;
  Finally
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
end;

procedure TfrmTrocaEquipamento.pAbrirTelaInspecaoEntrada(const blnAlterar: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
  item: TItemTrocaContrato;
begin
  edtCodEql.Enabled := False;
  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try

    If Not fVerificaAcessoSistema('LOCIPE') Then
    Begin
      If Not fLiberacaoRealizarInspecaoEntradaEquipamento Then
      Begin
        fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para realizar a inspeção de Entrada!', ['&Ok']);
        Exit;
      End;
    End;

    Try
      item := fAdicionarItemTroca('',
                                  cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);
      If Not Assigned(item) Then
        Exit;

      If Not Assigned(item.itemAnteriorContrato) Then
        Exit;

      frmInspecaoLocEquEntrada.strChaveDet := cdsEqlDetEntrada.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquEntrada.blnAlterar  := blnAlterar;
      frmInspecaoLocEquEntrada.blnCarregarDados := True;
      frmInspecaoLocEquEntrada.TipoEquipamento := tpPrincipal;
      frmInspecaoLocEquEntrada.ObjItemEquipamento := item.itemAnteriorContrato;
      frmInspecaoLocEquEntrada.ShowModal;

      If frmInspecaoLocEquEntrada.ModalResult = mrOk Then
      Begin
        cdsEqlDetEntrada.Edit;
        cdsEqlDetEntrada.FieldByName('EQD_IPEREA').AsString := IIF(item.itemAnteriorContrato.InspecaoEntradaRealizada, 'S', 'N');
        cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').AsDateTime := item.itemAnteriorContrato.DataInspecaoEntrada + item.itemAnteriorContrato.HoraInspecaoEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_AVARIA').AsString := item.itemAnteriorContrato.Avaria;
        cdsEqlDetEntrada.FieldByName('EQD_OBSIPE').AsString := item.itemAnteriorContrato.ObservacoesEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_VALIPE').AsFloat := item.itemAnteriorContrato.ValorCobranca;
        If Not fEmptyStr(item.itemAnteriorContrato.CodConferenteEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_CONFER').AsString := item.itemAnteriorContrato.CodConferenteEntrada + ' - ' + item.itemAnteriorContrato.NomConferenteEntrada;
        If Not fEmptyStr(item.itemAnteriorContrato.CodSupervisorEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_SUPERV').AsString := item.itemAnteriorContrato.CodSupervisorEntrada + ' - ' + item.itemAnteriorContrato.NomSupervisorEntrada;
        cdsEqlDetEntrada.Post;

        pCalcularTotais;
      End
      Else
      Begin
        pRemoverItemTroca;
      End;

      edtCodEql.Enabled := item.itemAnteriorContrato.InspecaoEntradaRealizada;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pAbrirTelaInspecaoEntrada');
      End;
    End;

  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmTrocaEquipamento.pAbrirTelaInspecaoEntradaAcessorio(
  const blnAlterar: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
  item: TItemTrocaContrato;
begin
  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    Try
      If Not fVerificaAcessoSistema('LOCIPE') Then
      Begin
        If Not fLiberacaoRealizarInspecaoEntradaAcessorio Then
        Begin
          fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para realizar a inspeção de Entrada!', ['&Ok']);
          Exit;
        End;
      End;

      item := fAdicionarAcessorioTroca(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosEntrada.FieldByName('EQD_SEQDET').AsString);
      If Not Assigned(item) Then
        Exit;

      If Not Assigned(item.acessorioAnteriorContrato) Then
        Exit;

      frmInspecaoLocEquEntrada.strChaveDet := cdsAcessoriosEntrada.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquEntrada.blnAlterar := blnAlterar;
      frmInspecaoLocEquEntrada.blnCarregarDados := True;
      frmInspecaoLocEquEntrada.TipoEquipamento := tpAcessorio;
      frmInspecaoLocEquEntrada.ObjItemAcessorio := item.acessorioAnteriorContrato;
      frmInspecaoLocEquEntrada.ShowModal;

      If frmInspecaoLocEquEntrada.ModalResult = MrOk Then
      Begin       
        cdsAcessoriosEntrada.Edit;    
      
        If item.acessorioAnteriorContrato.HoraInspecaoEntrada > 0 Then        
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime := item.acessorioAnteriorContrato.DataInspecaoEntrada + item.acessorioAnteriorContrato.HoraInspecaoEntrada
        Else
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').Clear;
        cdsAcessoriosEntrada.FieldByName('EQD_IPEREA').AsString := IIF(item.acessorioAnteriorContrato.InspecaoEntradaRealizada, 'S', 'N');  
        cdsAcessoriosEntrada.FieldByName('EQD_AVARIA').AsString := item.acessorioAnteriorContrato.Avaria;
        cdsAcessoriosEntrada.FieldByName('EQD_OBSIPE').AsString := item.acessorioAnteriorContrato.ObservacoesEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_VALIPE').AsFloat  := item.acessorioAnteriorContrato.ValorCobranca;
        If Not fEmptyStr(item.acessorioAnteriorContrato.CodConferenteEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_CONFER').AsString := item.acessorioAnteriorContrato.CodConferenteEntrada + ' - ' + item.acessorioAnteriorContrato.NomConferenteEntrada;
        If Not fEmptyStr(item.acessorioAnteriorContrato.CodSupervisorEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').AsString := item.acessorioAnteriorContrato.CodSupervisorEntrada + ' - ' + item.acessorioAnteriorContrato.NomSupervisorEntrada;
        cdsAcessoriosEntrada.Post;
      End
      Else
      Begin
        pRemoverAcessorioTroca;           
      End;

      pCalcularTotais;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pAbrirTelaInspecaoEntradaAcessorio');
      End;
    End;
    
  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmTrocaEquipamento.pAbrirTelaInspecaoSaida(const blnAlterar: Boolean);
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
  item: TItemTrocaContrato;
begin

  If Not (cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString = 'M') Then
    Exit;

  If Not fVerificaAcessoSistema('LOCIPS') Then
  Begin
    If Not fLiberacaoRealizarInspecaoSaidaEquipamento Then
    Begin
      fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para realizar a inspeção de Saída!', ['&Ok']);
      Exit;
    End;
  End;

  item := ObjTroca.fRetornaItemTroca(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString);

  If Not Assigned(item) Then
    Exit;

  If Not Assigned(item.itemContrato) Then
    Exit;

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  blnCarregandoItens := True;
  Try
    Try
      frmInspecaoLocEquSaida.strChaveDet := cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquSaida.blnAlterar := blnAlterar;
      frmInspecaoLocEquSaida.blnCarregarDados := True;
      frmInspecaoLocEquSaida.TipoEquipamento := tpPrincipal;
      frmInspecaoLocEquSaida.ObjItemEquipamento := item.itemContrato;
      frmInspecaoLocEquSaida.ShowModal;

      If frmInspecaoLocEquSaida.ModalResult = MrOk Then
      Begin
        cdsEqlDetSaida.Edit;
        cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString := 'M';
        cdsEqlDetSaida.FieldByName('EQD_IPSREA').AsString := IIF(item.itemContrato.InspecaoSaidaRealizada, 'S', 'N');
        cdsEqlDetSaida.FieldByName('EQD_DTAIPS').AsDateTime := item.itemContrato.DataInspecaoSaida + item.itemContrato.HoraInspecaoSaida ;
        cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := item.itemContrato.ObservacoesSaida;
        If Not fEmptyStr(item.itemContrato.CodConferenteSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_CONFER').AsString := item.itemContrato.CodConferenteSaida + ' - ' + item.itemContrato.NomConferenteSaida;
        If Not fEmptyStr(item.itemContrato.CodSupervisorSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_SUPERV').AsString := item.itemContrato.CodSupervisorSaida + ' - ' + item.itemContrato.NomSupervisorSaida;
        cdsEqlDetSaida.Post;
      End
      Else
      Begin
        cdsEqlDetSaida.Edit;
        cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDetSaida.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pAbrirTelaInspecaoSaida');
      End;
    End;
  Finally
    blnCarregandoItens := False;
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
End;

procedure TfrmTrocaEquipamento.pAdicionarAcessoriosSaidaGrid(const item: TItemTrocaContrato);
var
  intCnt: Integer;
  blnMarcado: Boolean;
  aEquipamento: TEquipamentoLocacaoPrincipal;
  itemTroca: TItemTrocaContrato;
begin
  blnCarregandoItens := True;

  If cdsAcessoriosSaida.Active Then
    cdsAcessoriosSaida.EmptyDataSet;

  cdsAcessoriosSaida.DisableControls;
  Try
    aEquipamento := item.itemContrato.Equipamento;
    Try
      lblAcessoriosSaida.Caption := '  Acessórios do Equipamento:' + aEquipamento.Codigo + ' - ' + aEquipamento.Descricao;
      For intCnt := 0 to aEquipamento.Acessorios.Count -1 Do
      Begin

        blnMarcado := fVerificaAcessorioSelecionado(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, aEquipamento.Acessorios[intCnt].Acessorio.Codigo);

        pAdicionarAcessorioTroca(itemTroca, cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, aEquipamento.Acessorios[intCnt].Acessorio.CodigoItem, '', aEquipamento.Acessorios[intCnt].Acessorio.Codigo);

        cdsAcessoriosSaida.Insert;
        cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString := IIF(blnMarcado, 'M', 'D');
        cdsAcessoriosSaida.FieldByName('AUTOINCREM').AsString := aEquipamento.Acessorios[intCnt].Acessorio.AutInc;
        cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString := aEquipamento.Codigo;
        cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString := aEquipamento.Acessorios[intCnt].Acessorio.Codigo;
        cdsAcessoriosSaida.FieldByName('ACL_CODITE').AsString := aEquipamento.Acessorios[intCnt].Acessorio.CodigoItem;
        cdsAcessoriosSaida.FieldByName('EQD_DESCRI').AsString := aEquipamento.Acessorios[intCnt].Acessorio.Descricao;
        cdsAcessoriosSaida.FieldByName('ACL_DESITE').AsString := aEquipamento.Acessorios[intCnt].Acessorio.DescricaoItem;
        cdsAcessoriosSaida.FieldByName('EQD_QTDACL').AsFloat  := aEquipamento.Acessorios[intCnt].Quantidade;
        cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').Clear;
        cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := EmptyStr;
        cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := EmptyStr;
        cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := EmptyStr;
        cdsAcessoriosSaida.FieldByName('EQA_QTDTOT').AsFloat  := aEquipamento.Acessorios[intCnt].Quantidade * item.itemContrato.Quantidade;
        cdsAcessoriosSaida.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.pAdicionarAcessoriosSaidaGrid]');
      End;
    End;
  Finally
    cdsAcessoriosSaida.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmTrocaEquipamento.pAdicionarAcessorioTroca(
  var item: TItemTrocaContrato; const aCodEql, aCodItem, aCodAclAnt, aCodAcl: String);
begin
  item := ObjTroca.fRetornaAcessorioTroca(aCodEql, aCodAclAnt, aCodItem);
  If Not Assigned(item) Then
    Exit;

  If Not Assigned(item.acessorioContrato) Then
    Exit;

  If Not Assigned(item.acessorioAnteriorContrato) Then
    Exit;

  item.fEfetuarTrocaAcessorio(aCodAcl);
end;

function TfrmTrocaEquipamento.fCarregarAcessorioSaidaTrocaGrid: Boolean;
var
  intCnt: Integer;
  intCont: Integer;
begin
  blnCarregandoItens := True;
  intCont := 0;

  If cdsAcessoriosSaida.Active Then
    cdsAcessoriosSaida.EmptyDataSet;

  cdsAcessoriosSaida.DisableControls;
  Try
    Try
      For intCnt := 0 to  ObjTroca.Itens.Count  -1 Do
      Begin
        If Not fPodeCarregarItemTrocaAcessorio(ObjTroca.Itens[intCnt]) Then
          Continue;

        Inc(intCont);  

        cdsAcessoriosSaida.Insert;
        cdsAcessoriosSaida.FieldByName('EQD_IPSREA').AsString := IIF(ObjTroca.Itens[intCnt].acessorioContrato.InspecaoEntradaRealizada, 'S', 'N');
        cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString := 'D';
        cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString := ObjTroca.Itens[intCnt].acessorioContrato.CodEquipamento;
        cdsAcessoriosSaida.FieldByName('AUTOINCREM').AsString := ObjTroca.Itens[intCnt].acessorioContrato.Acessorio.AutInc;
        cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString := ObjTroca.Itens[intCnt].acessorioContrato.Acessorio.Codigo;
        cdsAcessoriosSaida.FieldByName('ACL_CODITE').AsString := ObjTroca.Itens[intCnt].acessorioContrato.Acessorio.CodigoItem;
        cdsAcessoriosSaida.FieldByName('EQD_DESCRI').AsString := ObjTroca.Itens[intCnt].acessorioContrato.Acessorio.Descricao;
        cdsAcessoriosSaida.FieldByName('ACL_DESITE').AsString := ObjTroca.Itens[intCnt].acessorioContrato.Acessorio.DescricaoItem;
        cdsAcessoriosSaida.FieldByName('EQD_QTDACL').AsFloat  := ObjTroca.Itens[intCnt].acessorioContrato.Quantidade;
        If ObjTroca.Itens[intCnt].acessorioContrato.DataInspecaoSaida  > 0 Then
          cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').AsDateTime := ObjTroca.Itens[intCnt].acessorioContrato.DataInspecaoSaida + ObjTroca.Itens[intCnt].acessorioContrato.HoraInspecaoSaida;
        cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := ObjTroca.Itens[intCnt].acessorioContrato.ObservacoesSaida;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].acessorioContrato.CodConferenteSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := ObjTroca.Itens[intCnt].acessorioContrato.CodConferenteSaida + ' - ' + ObjTroca.Itens[intCnt].acessorioContrato.NomConferenteSaida;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].acessorioContrato.CodSupervisorSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := ObjTroca.Itens[intCnt].acessorioContrato.CodSupervisorSaida + ' - ' + ObjTroca.Itens[intCnt].acessorioContrato.NomSupervisorSaida;
        cdsAcessoriosSaida.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.fCarregarAcessorioSaidaTrocaGrid]');
      End;
    End;
  Finally
    Result := intCont > 0;
    blnCarregandoItens := False;
    cdsAcessoriosSaida.EnableControls;
  End;
End;

function TfrmTrocaEquipamento.fCarregarAcessorioTrocaGrid: Boolean;
var
  intCnt: Integer;
  intCont: Integer;
begin
  blnCarregandoItens := True;
  intCont := 0;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  cdsAcessoriosEntrada.DisableControls;
  Try
    Try
      For intCnt := 0 to  ObjTroca.Itens.Count  -1 Do
      Begin
        If ObjTroca.Itens[intCnt].TipoItem = tpPrincipal Then
          Continue;

        If cxGridAcessoriosEntrada.Enabled Then
        Begin
          If ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodEquipamento <> cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
            Continue;
        End;

        Inc(intCont);  

        cdsAcessoriosEntrada.Insert;
        cdsAcessoriosEntrada.FieldByName('EQD_IPEREA').AsString := IIF(ObjTroca.Itens[intCnt].acessorioAnteriorContrato.InspecaoEntradaRealizada, 'S', 'N');
        cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString := 'D';
        cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodEquipamento;
        cdsAcessoriosEntrada.FieldByName('AUTOINCREM').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Acessorio.AutInc;
        cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Acessorio.Codigo;
        cdsAcessoriosEntrada.FieldByName('ACL_CODITE').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Acessorio.CodigoItem;
        cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Acessorio.Descricao;
        cdsAcessoriosEntrada.FieldByName('ACL_DESITE').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Acessorio.DescricaoItem;
        cdsAcessoriosEntrada.FieldByName('EQD_QTDACL').AsFloat  := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Quantidade;
        If ObjTroca.Itens[intCnt].acessorioAnteriorContrato.DataInspecaoEntrada  > 0 Then
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.DataInspecaoEntrada + ObjTroca.Itens[intCnt].acessorioAnteriorContrato.HoraInspecaoEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_AVARIA').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.Avaria;
        cdsAcessoriosEntrada.FieldByName('EQD_OBSIPE').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.ObservacoesEntrada;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodConferenteEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_CONFER').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodConferenteEntrada + ' - ' + ObjTroca.Itens[intCnt].acessorioAnteriorContrato.NomConferenteEntrada;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodSupervisorEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').AsString := ObjTroca.Itens[intCnt].acessorioAnteriorContrato.CodSupervisorEntrada + ' - ' + ObjTroca.Itens[intCnt].acessorioAnteriorContrato.NomSupervisorEntrada;
        cdsAcessoriosEntrada.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.fCarregarAcessorioTrocaGrid]');
      End;
    End;
  Finally
    Result := intCont > 0;
    blnCarregandoItens := False;
    cdsAcessoriosEntrada.EnableControls;
  End;
end;

function TfrmTrocaEquipamento.fCarregarEquipamentoSaidaTrocaGrid: Boolean;
var
  intCnt: Integer;
  intCont: Integer;
begin
  intCont := 0;
  blnCarregandoItens := True;

  If cdsEqlDetSaida.Active Then
    cdsEqlDetSaida.EmptyDataSet;

  If cdsAcessoriosSaida.Active Then
    cdsAcessoriosSaida.EmptyDataSet;

  cdsEqlDetSaida.DisableControls;
  Try
    Try
      For intCnt := 0 to  ObjTroca.Itens.Count -1 Do
      Begin
        If Not fPodeCarregarItemTrocaEquipamento(ObjTroca.Itens[intCnt]) Then
          Continue;

        Inc(intCont);

        cdsEqlDetSaida.Insert;
        cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDetSaida.FieldByName('EQD_IPSREA').AsString := IIF(ObjTroca.Itens[intCnt].itemContrato.InspecaoSaidaRealizada, 'S', 'N');
        cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.AutInc;
        cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.Codigo;
        cdsEqlDetSaida.FieldByName('EQL_CODITE').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.CodigoItem;
        cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.Descricao;
        cdsEqlDetSaida.FieldByName('EQL_DESITE').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.DescricaoItem;
        cdsEqlDetSaida.FieldByName('EQL_NSERIE').AsString := ObjTroca.Itens[intCnt].itemContrato.Equipamento.NumSerie;
        cdsEqlDetSaida.FieldByName('EQD_DTAIPS').AsDateTime := ObjTroca.Itens[intCnt].itemContrato.DataInspecaoSaida + ObjTroca.Itens[intCnt].itemContrato.HoraInspecaoSaida;
        cdsEqlDetSaida.FieldByName('EQD_AVARIA').AsString := ObjTroca.Itens[intCnt].itemContrato.Avaria;
        cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := ObjTroca.Itens[intCnt].itemContrato.ObservacoesSaida;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].itemContrato.CodConferenteSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_CONFER').AsString := ObjTroca.Itens[intCnt].itemContrato.CodConferenteSaida + ' - ' + ObjTroca.Itens[intCnt].itemContrato.NomConferenteSaida;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].itemContrato.CodSupervisorSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_SUPERV').AsString := ObjTroca.Itens[intCnt].itemContrato.CodSupervisorSaida + ' - ' + ObjTroca.Itens[intCnt].itemContrato.NomSupervisorSaida;
        cdsEqlDetSaida.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.fCarregarEquipamentoSaidaTrocaGrid]');
      End;
    End;
  Finally
    Result := intCont > 0;
    cdsEqlDetSaida.EnableControls;
    blnCarregandoItens := False;
  End;
end;

function TfrmTrocaEquipamento.fCarregarEquipamentoTrocaGrid: Boolean;
var
  intCnt: Integer;
begin
  blnCarregandoItens := True;
  
  Result := ObjTroca.Itens.Count > 0;

  If Not Result Then
    Exit;

  If cdsEqlDetEntrada.Active Then
    cdsEqlDetEntrada.EmptyDataSet;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  cdsEqlDetEntrada.DisableControls;
  Try
    Try
      For intCnt := 0 to  ObjTroca.Itens.Count -1 Do
      Begin
        If ObjTroca.Itens[intCnt].TipoItem = tpAcessorio Then
          continue;

        cdsEqlDetEntrada.Insert;
        cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDetEntrada.FieldByName('EQD_IPEREA').AsString := IIF(ObjTroca.Itens[intCnt].itemAnteriorContrato.InspecaoEntradaRealizada, 'S', 'N');
        cdsEqlDetEntrada.FieldByName('EQD_SEQDET').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.AutInc;
        cdsEqlDetEntrada.FieldByName('AUTOINCREM').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.AutInc;
        cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.Codigo;
        cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.CodigoItem;
        cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.Descricao;
        cdsEqlDetEntrada.FieldByName('EQL_DESITE').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.DescricaoItem;
        cdsEqlDetEntrada.FieldByName('EQL_NSERIE').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Equipamento.NumSerie;
        cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').AsDateTime := ObjTroca.Itens[intCnt].itemAnteriorContrato.DataInspecaoEntrada + ObjTroca.Itens[intCnt].itemAnteriorContrato.HoraInspecaoEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_AVARIA').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.Avaria;
        cdsEqlDetEntrada.FieldByName('EQD_OBSIPE').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.ObservacoesEntrada;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].itemAnteriorContrato.CodConferenteEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_CONFER').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.CodConferenteEntrada + ' - ' + ObjTroca.Itens[intCnt].itemAnteriorContrato.NomConferenteEntrada;
        If Not fEmptyStr(ObjTroca.Itens[intCnt].itemAnteriorContrato.CodSupervisorEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_SUPERV').AsString := ObjTroca.Itens[intCnt].itemAnteriorContrato.CodSupervisorEntrada + ' - ' + ObjTroca.Itens[intCnt].itemAnteriorContrato.NomSupervisorEntrada;
        cdsEqlDetEntrada.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.pAdicionarEquipamentoTrocaGrid]');
      End;
    End;
  Finally
    cdsEqlDetEntrada.EnableControls;
    blnCarregandoItens := False;
  End;
end;

function TfrmTrocaEquipamento.fAdicionarAcessorioTroca(const strCodEql: String;
  const aEqlDetAutInc: String): TItemTrocaContrato;
var
  item: TItemTrocaContrato;
  itemContrato: TItemContratoLocacaoEquipamentos;
  acessorioContrato,
  acessorioAnteriorContrato: TAcessorioContratoLocacaoEquipamentos;
begin
  itemContrato := ObjContrato.fRetornaItemContrato(strCodEql);

  item := ObjTroca.fAddAcessorio;
  acessorioAnteriorContrato := TAcessorioContratoLocacaoEquipamentos.Create(itemContrato);
  acessorioAnteriorContrato.pCarregar(aEqlDetAutInc);
  acessorioAnteriorContrato.pLimparDadosInspecaoEntrada;
  acessorioAnteriorContrato.CodEquipamento := strCodEql;

  acessorioContrato := TAcessorioContratoLocacaoEquipamentos.Create(itemContrato);
  acessorioContrato.pCarregar(aEqlDetAutInc);
  acessorioContrato.pLimparDadosInspecaoEntrada;
  acessorioContrato.pLimparDadosInspecaoSaida;
  acessorioContrato.CodEquipamento := strCodEql;

  item.acessorioContrato  := acessorioContrato;
  item.acessorioAnteriorContrato := acessorioAnteriorContrato;

  Result := item;
end;

function TfrmTrocaEquipamento.fAdicionarItemTroca(const aEqlDetAutInc: String; strCodEql: String): TItemTrocaContrato;
var
  item: TItemTrocaContrato;
  itemContrato,
  itemAnteriorContrato: TItemContratoLocacaoEquipamentos;
begin
  item := ObjTroca.fAddItem;
  itemAnteriorContrato := TItemContratoLocacaoEquipamentos.Create(ObjContrato);
  itemAnteriorContrato.pCarregar('', strCodEql);
  itemAnteriorContrato.pLimparDadosInspecaoEntrada;

  itemContrato := TItemContratoLocacaoEquipamentos.Create(ObjContrato);
  itemContrato.pCarregar('', strCodEql);
  itemContrato.pLimparDadosInspecaoEntrada;
  itemContrato.pLimparDadosInspecaoSaida;

  item.itemContrato := itemContrato;
  item.itemAnteriorContrato := itemAnteriorContrato;

  Result := item;
end;

procedure TfrmTrocaEquipamento.pAdicionarItemTroca(var item: TItemTrocaContrato; const aCodItem, aCodEqlAnt, aCodEql: String);
begin
  item := ObjTroca.fRetornaItemTroca(aCodEqlAnt);
  If Not Assigned(item) Then
    Exit;

  If Not Assigned(item.itemContrato) Then
    Exit;

  If Not Assigned(item.itemAnteriorContrato) Then
    Exit;

  item.blnPermiteEquDif := (cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString = 'S');
  item.fEfetuarTrocaEquipamento(aCodEql);
end;

procedure TfrmTrocaEquipamento.pCalcularTotais;
begin
  ObjTroca.pCalcularTotais;

  edtVlrTotIpe.Text := FormatFloat('#,##0.00', ObjTroca.ValorTotalCobranca);
end;

procedure TfrmTrocaEquipamento.pCarregarAcessoriosEntrada(const blnMarcar: Boolean);
var
  intCnt,
  intCont: Integer;
  aItem: TAcessorioContratoLocacaoEquipamentos;
begin

  blnCarregandoItens := True;
  
  lblAcessoriosEquipamento.Caption := '  Acessórios do Equipamento: ' + cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString + ' - ' +  cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString;

  cdsAcessoriosEntrada.DisableControls;
  Try
    Try
      For intCont := 0 to objContrato.Itens.Count  -1 Do
      Begin
        If objContrato.Itens[intCont].Equipamento.Codigo = cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString Then
        Begin
          If Not cxGridAcessoriosEntrada.Visible Then
            Exit;

          If cdsAcessoriosEntrada.Active Then
            cdsAcessoriosEntrada.EmptyDataSet;

          If Not Assigned(objContrato) Then
            Exit;       

          For intCnt := 0 to objContrato.Itens[intCont].Acessorios.Count  -1 Do
          Begin
            aItem := objContrato.Itens[intCont].Acessorios[intCnt];
            aItem.pLimparDadosInspecaoEntrada;

            cdsAcessoriosEntrada.Insert;
            cdsAcessoriosEntrada.FieldByName('EQD_IPEREA').AsString := 'N';
            cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString := 'D';
            cdsAcessoriosEntrada.FieldByName('EQD_SEQDET').AsString := aItem.AutInc;
            cdsAcessoriosEntrada.FieldByName('AUTOINCREM').AsString := aItem.Acessorio.AutInc;
            cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString := aItem.CodEquipamento;
            cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString := aItem.Acessorio.Codigo;
            cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString := aItem.Acessorio.Descricao;
            cdsAcessoriosEntrada.FieldByName('ACL_CODITE').AsString := aItem.Acessorio.CodigoItem;
            cdsAcessoriosEntrada.FieldByName('ACL_DESITE').AsString := aItem.Acessorio.DescricaoItem;
            cdsAcessoriosEntrada.FieldByName('EQD_QTDACL').AsFloat  := aItem.Quantidade;
            cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').Clear;
            cdsAcessoriosEntrada.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * objContrato.Itens[intCont].Quantidade;

            cdsAcessoriosEntrada.Post;
          End;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.pCarregarAcessoriosEntrada]');
      End;
    End;
  Finally
    blnCarregandoItens := False;
    cdsAcessoriosEntrada.EnableControls;
  End;
end;

procedure TfrmTrocaEquipamento.pCarregarDetalhamentoTroca;
begin
  blnCarregandoItens := True;
  try
    try
      If Not fCarregarAcessorioTrocaGrid Then       
        pCarregarAcessoriosEntrada(cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString = 'M');
        
      fCarregarEquipamentoSaidaTrocaGrid;
      fCarregarAcessorioSaidaTrocaGrid;
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pCarregarDetalhamentoTroca');
      End;
    end;
  finally            
    blnCarregandoItens := False;
  end;
end;

procedure TfrmTrocaEquipamento.pCarregarEquipamentoSaida(item: TItemTrocaContrato; const aEquipamento: TEquipamentoLocacaoPrincipal = nil);
begin
  blnCarregandoItens := True;
  
  If cdsEqlDetSaida.Active Then
    cdsEqlDetSaida.EmptyDataSet;

  cdsEqlDetSaida.DisableControls;
  Try
    Try
      If Not Assigned(item) Then
      Begin
        If Assigned(aEquipamento) Then
          item := ObjTroca.fRetornaItemTroca(aEquipamento.Codigo);
      End;

      If Not Assigned(item) Then
        Exit;

      If Not Assigned(item.itemContrato) Then
        Exit;

      cdsEqlDetSaida.Insert;
      cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString := 'D';
      cdsEqlDetSaida.FieldByName('EQD_IPSREA').AsString := IIF(item.itemContrato.InspecaoSaidaRealizada, 'S', 'N');
      cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString := item.itemContrato.Equipamento.AutInc;
      cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString := item.itemContrato.Equipamento.Codigo;
      cdsEqlDetSaida.FieldByName('EQL_CODITE').AsString := item.itemContrato.Equipamento.CodigoItem;
      cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString := item.itemContrato.Equipamento.Descricao;
      cdsEqlDetSaida.FieldByName('EQL_DESITE').AsString := item.itemContrato.Equipamento.DescricaoItem;
      cdsEqlDetSaida.FieldByName('EQL_NSERIE').AsString := item.itemContrato.Equipamento.NumSerie;
      If item.itemContrato.HoraInspecaoSaida > 0 Then
        cdsEqlDetSaida.FieldByName('EQD_DTAIPS').AsDateTime := item.itemContrato.DataInspecaoSaida + item.itemContrato.HoraInspecaoSaida
      Else
        cdsEqlDetSaida.FieldByName('EQD_DTAIPS').Clear;
      cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := item.itemContrato.ObservacoesSaida;
      If Not fEmptyStr(item.itemContrato.CodConferenteSaida) Then
        cdsEqlDetSaida.FieldByName('EQD_CONFER').AsString := item.itemContrato.CodConferenteSaida + ' - ' + item.itemContrato.NomConferenteSaida;
      If Not fEmptyStr(item.itemContrato.CodSupervisorSaida) Then
        cdsEqlDetSaida.FieldByName('EQD_SUPERV').AsString := item.itemContrato.CodSupervisorSaida + ' - ' + item.itemContrato.NomSupervisorSaida;

      cdsEqlDetSaida.Post;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.pCarregarEquipamentoSaida]');
      End;
    End;
  Finally
    cdsEqlDetSaida.EnableControls;
    blnCarregandoItens := False;
  End;

end;

procedure TfrmTrocaEquipamento.pCarregarEquipamentosEntrada;
var
  intCnt: Integer;
begin
  blnCarregandoItens := True;

  If cdsEqlDetEntrada.Active Then
    cdsEqlDetEntrada.EmptyDataSet;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  cdsEqlDetEntrada.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjContrato.Itens.Count-1 Do
      Begin
        If ObjContrato.Itens[intCnt].DataEncerramento > 0 Then
          Continue;

        If ObjContrato.Itens[intCnt].InspecaoEntradaRealizada Then
          Continue;

        ObjContrato.Itens[intCnt].pLimparDadosInspecaoEntrada;

        cdsEqlDetEntrada.Insert;
        cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString := 'D';
        cdsEqlDetEntrada.FieldByName('EQD_SEQDET').AsString := ObjContrato.Itens[intCnt].AutInc;
        cdsEqlDetEntrada.FieldByName('AUTOINCREM').AsString := ObjContrato.Itens[intCnt].Equipamento.AutInc;
        cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString := ObjContrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDetEntrada.FieldByName('EQL_CODITE').AsString := ObjContrato.Itens[intCnt].Equipamento.CodigoItem;
        cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString := ObjContrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDetEntrada.FieldByName('EQL_DESITE').AsString := ObjContrato.Itens[intCnt].Equipamento.DescricaoItem;
        cdsEqlDetEntrada.FieldByName('EQL_NSERIE').AsString := ObjContrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDetEntrada.FieldByName('EQD_IPEREA').AsString := 'N';
        cdsEqlDetEntrada.FieldByName('EQD_EQUTRC').AsString := 'N';
        cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').Clear;
        cdsEqlDetEntrada.Post;
      End;    

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmTrocaEquipamento.pCarregarEquipamentosEntrada]');
      End;
    End;
  Finally
    cdsEqlDetEntrada.EnableControls;
    blnCarregandoItens := False;
  End;
end;

procedure TfrmTrocaEquipamento.pEfetuarTrocaAcessorio(
  aItem: TItemTrocaContrato);
begin
  If aItem.acessorioContrato.Acessorio.Codigo = cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString Then
  Begin
    aItem.acessorioContrato.CodEquipamento := cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString;
    aItem.acessorioContrato.Acessorio.fCarregaAcessorio(cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString);
  End;
end;

procedure TfrmTrocaEquipamento.pExibirTravaAcessoriosDiferentes;
var
  frmObservacao: TfrmObservacao;
  intAce: Integer;
  intCnt: Integer;
begin
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Atenção!';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Lines.Add('Os acessórios do equipamento de saída não são os mesmos que estão vinculados ao equipamento de entrada. Sendo assim, não ' +
                                   'é permitido realizar a troca. Faça o cancelamento/encerramento do contrato em questão e depois, faça um contrato novo.');
    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Entrada: '+ cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString);

    intAce := 0;
    cdsAcessoriosEntrada.DisableControls;
    Try
      cdsAcessoriosEntrada.First;
      While Not cdsAcessoriosEntrada.Eof Do
      Begin
        If intAce = 0 Then
          frmObservacao.memObs.Lines.Add('Acessórios: ' + cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString)
        Else
          frmObservacao.memObs.Lines.Add(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString);

        Inc(intAce);
        cdsAcessoriosEntrada.Next;
      End;
    Finally
      cdsAcessoriosEntrada.EnableControls;
    End;

    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Saída: '+ objEquipamento.Codigo +  ' - ' + objEquipamento.Descricao);

    For intCnt:= 0 To objEquipamento.Acessorios.Count -1 Do
    Begin
      If intCnt = 0 Then
        frmObservacao.memObs.Lines.Add('Acessórios: ' + objEquipamento.Acessorios[intCnt].Acessorio.Codigo + ' - ' + objEquipamento.Acessorios[intCnt].Acessorio.Descricao)
      Else
        frmObservacao.memObs.Lines.Add(objEquipamento.Acessorios[intCnt].Acessorio.Codigo + ' - ' + objEquipamento.Acessorios[intCnt].Acessorio.Descricao);
    End;

    If objEquipamento.Acessorios.Count = 0 Then
      frmObservacao.memObs.Lines.Add('Sem acessórios');

    frmObservacao.memObs.SelStart := 0;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmTrocaEquipamento.pExibirTravaProdutosAcessoriosDif;
var
  frmObservacao: TfrmObservacao;
  intAce: Integer;
  intCnt: Integer;
begin
  pCriarFormularios(TfrmObservacao, frmObservacao);
  Try
    frmObservacao.Caption := 'Atenção!';
    frmObservacao.lblMensagem.Visible := False;
    frmObservacao.memObs.Lines.Add('O acessório de saída não possui o mesmo produto vinculado que o acessório de entrada. Sendo assim, não é permitido ' +
                                   'realizar a troca. Faça o cancelamento/encerramento do contrato em questão e depois, faça um contrato novo.');
    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Entrada: '+ cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString);

    intAce := 0;
    cdsAcessoriosEntrada.DisableControls;
    Try
      cdsAcessoriosEntrada.First;
      While Not cdsAcessoriosEntrada.Eof Do
      Begin
        If intAce = 0 Then
          frmObservacao.memObs.Lines.Add('Acessórios: ' + cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString)
        Else
          frmObservacao.memObs.Lines.Add(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString);
        frmObservacao.memObs.Lines.Add('Produto: ' + cdsAcessoriosEntrada.FieldByName('ACL_CODITE').AsString +  ' - ' + cdsAcessoriosEntrada.FieldByName('ACL_DESITE').AsString);

        Inc(intAce);
        cdsAcessoriosEntrada.Next;
      End;
    Finally
      cdsAcessoriosEntrada.EnableControls;
    End;

    frmObservacao.memObs.Lines.Add('');
    frmObservacao.memObs.Lines.Add('Equipamento de Saída: ' + objEquipamento.Codigo +  ' - ' + objEquipamento.Descricao);

    For intCnt:= 0 To objEquipamento.Acessorios.Count -1 Do
    Begin
      If intCnt = 0 Then
        frmObservacao.memObs.Lines.Add('Acessórios: ' + objEquipamento.Acessorios[intCnt].Acessorio.Codigo + ' - ' + objEquipamento.Acessorios[intCnt].Acessorio.Descricao)
      Else
        frmObservacao.memObs.Lines.Add(objEquipamento.Acessorios[intCnt].Acessorio.Codigo + ' - ' + objEquipamento.Acessorios[intCnt].Acessorio.Descricao);
      frmObservacao.memObs.Lines.Add('Produto: '+ objEquipamento.Acessorios[intCnt].Acessorio.CodigoItem + ' - ' + objEquipamento.Acessorios[intCnt].Acessorio.DescricaoItem);
    End;

    If objEquipamento.Acessorios.Count = 0 Then
      frmObservacao.memObs.Lines.Add('Sem acessórios');

    frmObservacao.memObs.SelStart := 0;
    frmObservacao.ShowModal;
  Finally
    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmTrocaEquipamento.pFormatarCampos;
begin
  TTimeField(cdsEqlDetEntrada.FieldByName('EQD_DTAIPE')).DisplayFormat := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE')).DisplayFormat := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsEqlDetSaida.FieldByName('EQD_DTAIPS')).DisplayFormat := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsAcessoriosSaida.FieldByName('EQD_DTAIPS')).DisplayFormat := 'dd/mm/yyyy hh:nn';
end;

procedure TfrmTrocaEquipamento.pHabilitarComponentes(blnHabilitar: Boolean);
begin
  edtCodCli.Enabled := blnHabilitar;
  edtNomCli.Enabled := blnHabilitar;
  edtCodVen.Enabled := blnHabilitar;
  edtNomVen.Enabled := blnHabilitar;
  edtLocalizacao.Enabled := blnHabilitar;
  edtCodEql.Enabled := blnHabilitar;
  edtDesEql.Enabled := blnHabilitar;

  cxgrdEquipamentosEntrada.Enabled := blnHabilitar;
  cxGridAcessoriosEntrada.Enabled := blnHabilitar;
  cxGridEquipamentoSaida.Enabled := blnHabilitar;
  cxGridAcessoriosSaida.Enabled := blnHabilitar;

  cxgrdEquipamentosEntradaView.OptionsData.Editing := blnHabilitar;
  cxGridDBTableViewAcessorios.OptionsData.Editing := blnHabilitar;
  cxgrdEquipamentosSaida.OptionsData.Editing := blnHabilitar;
  cxgrdAcessoriosSaida.OptionsData.Editing := blnHabilitar;

  btnAdicionar.Enabled := blnHabilitar;
  btnConfirma.Enabled := blnHabilitar;
  btnAlterarCobranca.Enabled := False;
end;

procedure TfrmTrocaEquipamento.pImprimirAditivoContrato;
begin
  If ObjTroca.fImprimirAditivoContrato Then
  Begin
    If fMensagem('ATENÇÃO!', 'Aditivo de contrato gerado com sucesso!' + #13 +
                             'Deseja abrir o documento?', ['&Sim', '&Não']) = 1 Then
      pExecArquivo(ObjTroca.NomeArquivoAditivo, Handle);
  End;
end;

procedure TfrmTrocaEquipamento.pLimparCampos;
begin
  inherited;

  edtNroTrc.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtLocalizacao.Clear;
  edtVlrTotIpe.Clear;
  edtCodEql.Clear;
  edtDesEql.Clear;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  If cdsEqlDetSaida.Active Then
    cdsEqlDetSaida.EmptyDataSet;

  If cdsAcessoriosSaida.Active Then
    cdsAcessoriosSaida.EmptyDataSet;
end;

procedure TfrmTrocaEquipamento.pMarcarAcessorioEntrada(
  const blnMarcar: Boolean);

begin

  If cdsAcessoriosEntrada.RecordCount <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Não há acessórios para processar a troca. Verifique!', ['&Ok']);
    Exit;
  End;

  If Not blnMarcar Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente desmarcar o acessório para realização da troca?', ['&Sim', '&Não']) = 1 Then
    Begin
      pRemoverAcessorioTroca;
      Exit;
    End;
  End;

  cdsAcessoriosEntrada.Edit;
  cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsAcessoriosEntrada.Post;

  If Not FTrocaCarregada Then
  Begin

    If blnMarcar Then
      pAbrirTelaInspecaoEntradaAcessorio(True);

  End;

end;

procedure TfrmTrocaEquipamento.pMarcarAcessorioSaida(const blnMarcar: Boolean);
begin
  cdsAcessoriosSaida.Edit;
  cdsAcessoriosSaida.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsAcessoriosSaida.Post;

  If blnMarcar Then
    pAbrirTelaInspecaoAcessorioSaida(True);
end;

procedure TfrmTrocaEquipamento.pMarcarEquipamentoEntrada(
  const blnMarcar: Boolean);
begin
  If cdsEqlDetEntrada.RecordCount <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Não há itens para processar a troca. Verifique!', ['&Ok']);
    Exit;
  End;

  blnCarregandoItens := True;
  Try
    If Not blnMarcar Then
    Begin
      If fMensagem('ATENÇÃO!', 'Deseja realmente desmarcar o equipamento para realização da troca?', ['&Sim', '&Não']) = 2 Then
        Exit;
    End;

    cdsEqlDetEntrada.Edit;
    cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    cdsEqlDetEntrada.Post;

    If Not FTrocaCarregada Then
    Begin

      If blnMarcar Then
        pAbrirTelaInspecaoEntrada(True)
      Else
        pRemoverItemTroca;

    End;

  Finally
    blnCarregandoItens := False;
  End;

end;

procedure TfrmTrocaEquipamento.pMarcarEquipamentoSaida(
  const blnMarcar: Boolean);
begin
  If Not blnMarcar Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente desmarcar o equipamento para efetivação da troca?', ['&Sim', '&Não']) = 1 Then
    Begin
      pRemoverAcessorioTroca;
      Exit;
    End;
  End;

  blnCarregandoItens := True;
  try
    try
      cdsEqlDetSaida.Edit;
      cdsEqlDetSaida.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
      cdsEqlDetSaida.Post;

      If blnMarcar Then
        pAbrirTelaInspecaoSaida(True);
    except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmTrocaEquipamento.pMarcarEquipamentoSaida');
      End;
    end;
  finally
    blnCarregandoItens := False;
  end;
end;

function TfrmTrocaEquipamento.PodeAlterarValorCobranca(ATipoItem: TTpEquipamentoLocacao): Boolean;
begin
  If fEmptyStr(edtNroTrc.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'Não há troca selecionada para efetuar alteração', ['&Ok']);
    Exit(False);
  End;

  Case ATipoItem Of
    tpPrincipal : Result := (RetornaQuantidadeEquipamentosSelecionados > 0);
    tpAcessorio : Result := (RetornaQuantidadeAcessoriosSelecionados > 0)
    Else
      Result := False;
  End;

end;

procedure TfrmTrocaEquipamento.pRemoverAcessorioTroca;
begin
  cdsAcessoriosEntrada.Edit;
  cdsAcessoriosEntrada.FieldByName('EQD_MARDES').AsString := 'D'; 
  cdsAcessoriosEntrada.Post;
  ObjTroca.fRemoverAcessorioTroca(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString);
  pCalcularTotais;
end;

procedure TfrmTrocaEquipamento.pRemoverItemTroca;
begin
  cdsEqlDetEntrada.Edit;
  cdsEqlDetEntrada.FieldByName('EQD_MARDES').AsString := 'D'; 
  cdsEqlDetEntrada.Post;
  ObjTroca.fRemoverItemTroca(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);
  pCalcularTotais;
end;

function TfrmTrocaEquipamento.RetornaQuantidadeAcessoriosSelecionados: Integer;
var
  LIntRec: Integer;
begin
  If fCfgSis('UTIACE', varBoolean) Then
  Begin
    LIntRec := cdsAcessoriosEntrada.RecNo;
    cdsAcessoriosEntrada.Filter := 'EQD_MARDES = ' + QuotedStr('M');
    cdsAcessoriosEntrada.Filtered := True;

    Result := cdsAcessoriosEntrada.RecordCount;

    cdsAcessoriosEntrada.Filter := '';
    cdsAcessoriosEntrada.Filtered := False;
    cdsAcessoriosEntrada.RecNo := LIntRec;
  End
  Else
    Result := 0;
end;

function TfrmTrocaEquipamento.RetornaQuantidadeEquipamentosSelecionados: Integer;
var
  LIntRec: Integer;
begin
  LIntRec := cdsEqlDetEntrada.RecNo;
  cdsEqlDetEntrada.Filter := 'EQD_MARDES = ' + QuotedStr('M');
  cdsEqlDetEntrada.Filtered := True;

  Result := cdsEqlDetEntrada.RecordCount;

  cdsEqlDetEntrada.Filter := '';
  cdsEqlDetEntrada.Filtered := False;
  cdsEqlDetEntrada.RecNo := LIntRec;
end;

end.
