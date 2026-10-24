unit untManutencaoLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, faturamento.Classes.ManutencaoLocEqu,
  Datasnap.DBClient, UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos,
  untTypesLocEqu, Vcl.Mask, MaskEditFocus, untTLock, untFuncoesLocEqu, untTypesSistema;

type
  TfrmManutencaoLocEqu = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    edtLocalizacao: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodVen: TEditFocus;
    pnlPrincipal: TPanel;
    pnlSaida: TPanel;
    pnlEntrada: TPanel;
    pnlTitSaida: TPanel;
    pnlTitEntrada: TPanel;
    cdsAcessoriosSaida: TUniClientDataSet;
    cdsAcessoriosSaidaEQD_SEQEQL: TStringField;
    cdsAcessoriosSaidaEQD_OPEIPS: TStringField;
    cdsAcessoriosSaidaEQD_QTDACL: TFloatField;
    cdsAcessoriosSaidaEQD_SEQCON: TStringField;
    cdsAcessoriosSaidaEQD_STTIPS: TStringField;
    cdsAcessoriosSaidaAUTOINCREM: TStringField;
    cdsAcessoriosSaidaEQD_SEQACL: TStringField;
    cdsAcessoriosSaidaEQD_AVARIA: TStringField;
    cdsAcessoriosSaidaEQD_CONFER: TStringField;
    cdsAcessoriosSaidaEQD_SUPERV: TStringField;
    cdsAcessoriosSaidaEQD_MARDES: TStringField;
    cdsAcessoriosSaidaEQD_DESCRI: TStringField;
    cdsEqlDetSaida: TUniClientDataSet;
    cdsEqlDetSaidaAUTOINCREM: TStringField;
    StringField1: TStringField;
    cdsEqlDetSaidaEQL_NSERIE: TStringField;
    cdsEqlDetSaidaEQL_DESCRI: TStringField;
    cdsEqlDetSaidaEQD_DTAIPS: TDateTimeField;
    cdsEqlDetSaidaEQD_OBSIPS: TMemoField;
    cdsEqlDetSaidaEQD_SUPERV: TStringField;
    cdsEqlDetSaidaEQD_CONFER: TStringField;
    cdsEqlDetSaidaEQD_MARDES: TStringField;
    cdsEqlDetSaidaEQA_MARDES: TStringField;
    dtsAcessoriosSaida: TDataSource;
    dtsEqlDetSaida: TDataSource;
    cdsEqlDetSaidaEQD_CNDIPS: TStringField;
    cdsEqlDetEntrada: TUniClientDataSet;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    MemoField1: TMemoField;
    StringField6: TStringField;
    StringField7: TStringField;
    StringField8: TStringField;
    StringField9: TStringField;
    cdsAcessoriosEntrada: TUniClientDataSet;
    dtsEqlDetEntrada: TDataSource;
    dtsAcessoriosEntrada: TDataSource;
    cdsAcessoriosSaidaEQD_DTAIPS: TDateTimeField;
    cdsAcessoriosSaidaEQD_CNDIPS: TStringField;
    cdsEqlDetEntradaEQD_VALIPE: TFloatField;
    cdsAcessoriosEntradaEQD_VALIPE: TFloatField;
    pnlAcessoriosEntrada: TPanel;
    pnlDescricaoAcessorioEntrada: TPanel;
    cdsAcessoriosSaidaEQD_OBSIPS: TMemoField;
    cdsEqlDetSaidaEQD_NUMENV: TStringField;
    cdsEqlDetSaidaEQD_ESPENV: TStringField;
    cdsEqlDetSaidaEQD_SERENV: TStringField;
    cdsEqlDetSaidaEQD_EMPENV: TStringField;
    cdsEqlDetEntradaEQD_NUMRET: TStringField;
    cdsEqlDetEntradaEQD_ESPRET: TStringField;
    cdsEqlDetEntradaEQD_EMPRET: TStringField;
    cdsEqlDetEntradaEQD_SERRET: TStringField;
    cdsAcessoriosEntradaEQD_OBSIPE: TMemoField;
    cdsAcessoriosEntradaEQD_DESCRI: TStringField;
    cdsAcessoriosEntradaEQD_MARDES: TStringField;
    cdsAcessoriosEntradaEQD_CONFER: TStringField;
    cdsAcessoriosEntradaEQD_AVARIA: TStringField;
    cdsAcessoriosEntradaEQD_SUPERV: TStringField;
    cdsAcessoriosEntradaEQD_DTAIPE: TDateTimeField;
    cdsAcessoriosEntradaEQD_SEQACL: TStringField;
    cdsAcessoriosEntradaEQD_STTIPE: TStringField;
    cdsAcessoriosEntradaAUTOINCREM: TStringField;
    cdsAcessoriosEntradaEQD_SEQCON: TStringField;
    cdsAcessoriosEntradaEQD_QTDACL: TFloatField;
    cdsAcessoriosEntradaEQD_SUPIPE: TStringField;
    cdsAcessoriosEntradaEQD_SEQEQL: TStringField;
    pnlEquipamentoSaida: TPanel;
    pnlTitEquSaida: TPanel;
    cxGridEquipamentosSaida: TcxGridCitel;
    cxGrdEquipamentosSaidaView: TcxGridDBTableViewCitel;
    cxGrdEquipamentosSaidaViewAUTOINCREM: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_SEQEQL: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQL_DESCRI: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQL_NSERIE: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_DTAIPS: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_CNDIPS: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_OBSIPS: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_CONFER: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_SUPERV: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQD_MARDES: TcxGridDBColumn;
    cxGrdEquipamentosSaidaViewEQA_MARDES: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    pnlEquipamentoEntrada: TPanel;
    cxGridEquipamentosEntrada: TcxGridCitel;
    cxGridEquipamentosEntradaView: TcxGridDBTableViewCitel;
    cxGridEquipamentosEntradaViewAUTOINCREM: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_SEQEQL: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQL_DESCRI: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQL_NSERIE: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_DTAIPE: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_OBSIPE: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_CONFER: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_SUPERV: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_VALIPE: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_MARDES: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQA_MARDES: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnltitEquEntrada: TPanel;
    cxGridAcessoriosEntrada: TcxGridCitel;
    cxGridAcessoriosEntradaView: TcxGridDBTableViewCitel;
    cxGridAcessoriosEntradaViewAUTOINCREM: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_SEQCON: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_SEQEQL: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_SEQACL: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_DESCRI: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_QTDACL: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_DTAIPE: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_OBSIPE: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_CONFER: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_SUPERV: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_VALIPE: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_MARDES: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    cdsEqlDetSaidaEQD_ATUIPS: TStringField;
    cdsAcessoriosSaidaEQD_ATUIPS: TStringField;
    cdsEqlDetEntradaEQD_ATUIPE: TStringField;
    cdsAcessoriosEntradaEQD_ATUIPE: TStringField;
    Splitter1: TSplitter;
    pnlDocumentoSaida: TPanel;
    lblDocumentoSaida: TLabel;
    btnCancelarDocSaida: TBitBtnLocked;
    pnlAcessoriosSaida: TPanel;
    pnlDescricaoAcessorioSaida: TPanel;
    cxGridAcessoriosSaida: TcxGridCitel;
    cxGridAcessoriosSaidaView: TcxGridDBTableViewCitel;
    cxGridAcessoriosSaidaViewAUTOINCREM: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_SEQEQL: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_SEQACL: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_DESCRI: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_QTDACL: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_DTAIPS: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_CNDIPS: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_OBSIPS: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_CONFER: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_SUPERV: TcxGridDBColumn;
    cxGridAcessoriosSaidaViewEQD_MARDES: TcxGridDBColumn;
    cxGridAcessoriosSaidaLvl: TcxGridLevel;
    pnlDocumentoEntrada: TPanel;
    lblDocumentoEntrada: TLabel;
    btnCancelarDocEntrada: TBitBtnLocked;
    cdsEqlDetEntradaEQD_AVAIPE: TStringField;
    cdsAcessoriosEntradaEQD_AVAIPE: TStringField;
    cxGridEquipamentosEntradaViewEQD_AVAIPE: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQD_AVAIPE: TcxGridDBColumn;
    btnConfirmar: TBitBtnLocked;
    btnAlterarInspecao: TBitBtnLocked;
    btnAlterarCobranca: TBitBtnLocked;
    btnCancelarInspecao: TBitBtnLocked;
    cdsEqlDetEntradaEQD_CODCLI: TStringField;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    edtQtdEqu: TEditFocus;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtDtaIni: TEditFocus;
    edtHorIni: TEditFocus;
    edtDtaFin: TEditFocus;
    edtHorFin: TEditFocus;
    lblMesIni: TLabel;
    edtMesIni: TMaskEditFocus;
    lblMesFin: TLabel;
    edtMesFin: TMaskEditFocus;
    Label3: TLabel;
    btnAlterarContrato: TBitBtnLocked;
    cdsEqlDetEntradaEQD_QTDEQU: TFloatField;
    cdsEqlDetSaidaEQD_QTDEQU: TFloatField;
    cxGrdEquipamentosSaidaViewEQD_QTDEQU: TcxGridDBColumn;
    cxGridEquipamentosEntradaViewEQD_QTDEQU: TcxGridDBColumn;
    cdsAcessoriosSaidaEQA_QTDTOT: TFloatField;
    cdsAcessoriosEntradaEQA_QTDTOT: TFloatField;
    cxGridAcessoriosSaidaViewEQA_QTDTOT: TcxGridDBColumn;
    cxGridAcessoriosEntradaViewEQA_QTDTOT: TcxGridDBColumn;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure cdsEqlDetSaidaAfterScroll(DataSet: TDataSet);
    procedure cdsEqlDetEntradaAfterScroll(DataSet: TDataSet);
    procedure btnCancelarDocSaidaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarInspecaoClick(Sender: TObject);
    procedure cxGridEquipamentosSaidaEnter(Sender: TObject);
    procedure cxGridAcessoriosSaidaEnter(Sender: TObject);
    procedure cxGridEquipamentosEntradaEnter(Sender: TObject);
    procedure cxGridAcessoriosEntradaEnter(Sender: TObject);
    procedure btnAlterarCobrancaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarDocEntradaClick(Sender: TObject);
    procedure btnCancelarInspecaoClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cxGridEquipamentosEntradaExit(Sender: TObject);
    procedure cxGridAcessoriosEntradaExit(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarContratoClick(Sender: TObject);
  private
    { Private declarations }
    ObjManutencaoContrato: TManutencaoContrato;
    FBlnExibirAcessorios: Boolean;
    FBlnCarregandoItensSaida,
    FBlnCarregandoItensEntrada: Boolean;
    FQtdIspERea: Integer;
    FQtdIspSRea: Integer;
    FTpInspecao: TTipoInspecao;
    FobjLock: TLock;

    function fCarregarContrato(strNumeroContrato: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    function fValidarInspecaoSaidaRealizada: Boolean;
    function fValidarInspecaoEntradaRealizada: Boolean;
    function fValidarInspecaoAcesoriosSaidaRealizada(const strCodEqu: String): Boolean; overload;
    function fValidarInspecaoAcessoriosEntradaRealizada(const strCodEqu: String): Boolean; overload;
    function fValidarInspecaoAcesoriosSaidaRealizada: Boolean; overload;
    function fValidarInspecaoAcessoriosEntradaRealizada: Boolean; overload;
    function fValidarPodeConfirmar: Boolean;
    function fValidarPodeConfirmarInspecaoSaida: Boolean;

    procedure pFormatarCampos;
    procedure pCriarDataSets;
    procedure pLimparCampos;

    procedure pCarregarEquipamentosSaida;
    procedure pCarregarAcessoriosSaida(aItem: TItemContratoLocacaoEquipamentos);
    procedure pCarregarEquipamentosEntrada;
    procedure pCarregarAcessoriosEntrada(aItem: TItemContratoLocacaoEquipamentos);

    procedure pAbrirTelaInspecaoSaidaEquipamento;
    procedure pAbrirTelaInspecaoSaidaAcessorio;
    procedure pAbrirTelaInspecaoEntradaEquipamento(const blnManInsp, blnManCob: Boolean);
    procedure pAbrirTelaInspecaoEntradaAcessorio(const blnManInsp, blnManCob: Boolean);

    procedure pAlterarInspecaoSaidaEquipamento;
    procedure pAlterarInspecaoSaidaAcessorios;
    procedure pAlterarInspecaoEntradaEquipamento(const blnManInsp, blnManCob: Boolean);
    procedure pAlterarInspecaoEntradaAcessorios(const blnManInsp, blnManCob: Boolean);

    procedure pCancelarInspecaoEquSaida;
    procedure pCancelarInspecaoAceSaida;
    procedure pCancelarInspecaoEquEntrada;
    procedure pCancelarInspecaoAceEntrada;

    procedure pConfirmar;
    procedure pLimparItensDocumentoEntrada(const strEspDoc, strCodEmp, strNumDoc, strSerDoc: String);
    procedure pLimparItensDocumentoSaida(const strEspDoc, strCodEmp, strNumDoc, strSerDoc: String);

    procedure pHabilitaDesabilitaManutencaoContrato;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untCancelamentoDocumentos, untInspecaoLocEquSaida, untInspecaoLocEquEntrada,
  untGravando, untAltContratoLocEqu;

{$R *.dfm}

procedure TfrmManutencaoLocEqu.edtNumConKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel, True, False) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmManutencaoLocEqu.edtNumPedKeyPress(Sender: TObject;
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

function TfrmManutencaoLocEqu.fCarregarContrato(
  strNumeroContrato: String; strNumPed: String = ''; blnExibirMsg: Boolean = True): Boolean;
begin
  ObjManutencaoContrato.Contrato.pLimpar;

  Try

    If Not ObjManutencaoContrato.fIniciarManutencao(strNumeroContrato, strNumPed) Then
    Begin
      If blnExibirMsg Then
        fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (ObjManutencaoContrato.Contrato.Status = 'O') Then
    Begin
      fMensagem('ATENÇÃO', 'Contrato não está ativo! Favor realizar a ativação do contrato antes de realizar a manutenção de inspeção.', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (ObjManutencaoContrato.Contrato.Status = 'F') Then
    Begin
      fMensagem('ATENÇÃO', 'O contrato já está completamente faturado.', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (ObjManutencaoContrato.Contrato.Status = 'C') Then
    Begin
      fMensagem('ATENÇÃO', 'O contrato está Cancelado.', ['&Ok']);
      Result := False;
      Exit;
    End;

    If (ObjManutencaoContrato.Contrato.Status = 'E') Then
    Begin
      fMensagem('ATENÇÃO', 'Contrato Encerrado.', ['&Ok']);
      Result := False;
      Exit;
    End;

    If Not fValidaTravasContrato(ObjManutencaoContrato.Contrato.AutInc) Then
    Begin
      Result := False;
      Exit;
    End;

    pLimparCampos;
    edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', ObjManutencaoContrato.Contrato.DataInicial);
    edtHorIni.Text := FormatDateTime('hh:mm', ObjManutencaoContrato.Contrato.HoraInicial);
    edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', ObjManutencaoContrato.Contrato.DataFinal);
    edtHorFin.Text := FormatDateTime('hh:mm', ObjManutencaoContrato.Contrato.HoraFinal);
    edtQtdEqu.Text := FloatToStr(ObjManutencaoContrato.Contrato.QuantidadeEquipamentos);
    edtMesIni.Text := ObjManutencaoContrato.Contrato.strMesIni;
    edtMesFin.Text := ObjManutencaoContrato.Contrato.strMesFin;
    edtNumCon.Text := ObjManutencaoContrato.Contrato.NroContrato;
    edtCodCli.Text := ObjManutencaoContrato.Contrato.CodCliente;
    edtNomCli.Text := ObjManutencaoContrato.Contrato.NomCliente;
    edtCodVen.Text := ObjManutencaoContrato.Contrato.Vendedor.Codigo;
    edtNomVen.Text := ObjManutencaoContrato.Contrato.Vendedor.Nome;
    edtLocalizacao.Text := ObjManutencaoContrato.Contrato.Localizacao;
    edtNumPed.Text := Copy(ObjManutencaoContrato.Contrato.NumDocPedAdiantamento, 0, 12);
    edtCodEmp.Text := ObjManutencaoContrato.Contrato.Emitente.Codigo;

    pCarregarEquipamentosSaida;
    pCarregarEquipamentosEntrada;

    btnCancelarDocSaida.Enabled := Not fEmptyStr(cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString);
    btnCancelarDocEntrada.Enabled := Not fEmptyStr(cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString);

    If Not(fEmptyStr(ObjManutencaoContrato.Contrato.AutInc)) Then
      FobjLock.fLock_Unlock(cst_TRAVA_MANUTE_LOCEQU + ObjManutencaoContrato.Contrato.AutInc, True, False);

    pHabilitaDesabilitaManutencaoContrato;


    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmManutencaoLocEqu.fCarregarContrato');
    End;
  End;
end;

procedure TfrmManutencaoLocEqu.pHabilitaDesabilitaManutencaoContrato;
Begin
  btnConfirmar.Enabled := True;
  btnAlterarInspecao.Enabled   := True;
  btnAlterarCobranca.Enabled   := False;
  btnCancelarInspecao.Enabled  := True;
  btnAlterarContrato.Visible :=  fVerificaAcessoSistema('ATUCTR');
  btnCancelarDocSaida.Enabled  := True;
  btnCancelarDocEntrada.Enabled  := True;

  If Not Assigned(ObjManutencaoContrato) Then
    Exit;

  If ObjManutencaoContrato.Contrato.Emitente.Codigo = VS_strCodEmp Then
    Exit;

  If ObjManutencaoContrato.objValidaCtr.fRealizarProcessoLocacaoOutraEmpresa Then
  Begin
    btnConfirmar.Enabled := True;
    btnAlterarInspecao.Enabled   := True;
    btnAlterarCobranca.Enabled   := True;
    btnCancelarInspecao.Enabled  := True;
    btnAlterarContrato.Enabled   := False;
    btnCancelarDocSaida.Enabled  := False;
    btnCancelarDocEntrada.Enabled  := False;
  End
  Else
  Begin
    btnConfirmar.Enabled := False;
    btnAlterarInspecao.Enabled   := False;
    btnAlterarCobranca.Enabled   := False;
    btnCancelarInspecao.Enabled  := False;
    btnAlterarContrato.Enabled   := False;
    btnCancelarDocSaida.Enabled  := False;
    btnCancelarDocEntrada.Enabled  := False;
  End;

End;

procedure TfrmManutencaoLocEqu.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  If Assigned( ObjManutencaoContrato ) Then
  Begin
    If ObjManutencaoContrato.EmManutencao  Then
    Begin
      If fMensagem('ATENÇÃO', 'Deseja sair? As inspeções não serão salvas.', ['&Sim', '&Não']) = 2 Then
      Begin
        CanClose := False;
      End;
    End;
  End;
end;

procedure TfrmManutencaoLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  ObjManutencaoContrato := TManutencaoContrato.Create;
  FBlnExibirAcessorios := fCfgSis('UTIACE', VarBoolean);
  pCriarDataSets;
  pFormatarCampos;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;

    lblNumCon.Left := lblNumPed.Left ;
    edtNumCon.Left := lblNumCon.Left + lblNumCon.Width + 3;
  End;

  FobjLock := TLock.Create;

  Self.WindowState := wsMaximized;
end;

procedure TfrmManutencaoLocEqu.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_MANUTE_LOCEQU + ObjManutencaoContrato.Contrato.AutInc, False, False);
  FreeAndNil(FobjLock);
  FreeAndNil(ObjManutencaoContrato);
end;

procedure TfrmManutencaoLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F5  : btnAlterarInspecao.Click;
    VK_F6  : btnAlterarCobranca.Click;
    VK_F7  : btnCancelarInspecao.Click;
    VK_F8  : btnAlterarContrato.Click;
    VK_F10 : Begin
               If Not btnConfirmar.Enabled Then
                 Exit;

               btnConfirmar.Click;
             End;
  End;
end;

procedure TfrmManutencaoLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  btnCancelarDocSaida.Enabled := False;
  btnCancelarDocEntrada.Enabled := False;
  If Not FBlnExibirAcessorios Then
  Begin
    pnlAcessoriosSaida.Visible := False;
    pnlAcessoriosEntrada.Visible := False;
    pnlEquipamentoEntrada.Align := alClient;
    pnlEquipamentoSaida.Align := alClient;
  End;

  pHabilitaDesabilitaManutencaoContrato;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);

end;

function TfrmManutencaoLocEqu.fValidaCampos(Sender: TWinControl;
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
        Result := fCarregarContrato(edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmManutencaoLocEqu.fValidarInspecaoAcesoriosSaidaRealizada(const strCodEqu: String): Boolean;
Var
  intRecNo: Integer;
begin
  Result := True;

  If ObjManutencaoContrato.TipoManutencao = tpAlterarCobranca Then
    Exit;

  intRecNo := cdsAcessoriosSaida.RecNo;
  cdsAcessoriosSaida.DisableControls;
  Try
    cdsAcessoriosSaida.First;
    while not cdsAcessoriosSaida.EOF do
    Begin
      If cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString <> strCodEqu Then
        Continue;

      If cdsAcessoriosSaida.FieldByName('EQD_ATUIPS').AsString = 'N' Then
      Begin
        Result := False;
        Break;
      End;

      cdsAcessoriosSaida.Next;
    End;
  Finally
    cdsAcessoriosSaida.RecNo := intRecNo;
    cdsAcessoriosSaida.EnableControls;
  End;
end;

function TfrmManutencaoLocEqu.fValidarInspecaoAcessoriosEntradaRealizada(const strCodEqu: String): Boolean;
Var
  intRecNo: Integer;
begin
  Result := True;

  If ObjManutencaoContrato.TipoManutencao = tpAlterarCobranca Then
    Exit;

  intRecNo := cdsAcessoriosEntrada.RecNo;
  cdsAcessoriosEntrada.DisableControls;
  Try
    cdsAcessoriosEntrada.First;
    while not cdsAcessoriosEntrada.EOF do
    Begin
      If cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString <> strCodEqu Then
        Continue;

      If cdsAcessoriosEntrada.FieldByName('EQD_ATUIPE').AsString = 'N' Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'A inspeção de entrada do acessório '+ cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString + ' - ' +
                             cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString + ' precisa ser atualizada.', ['&Ok']);
        Break;
      End;

      cdsAcessoriosEntrada.Next;
    End;
  Finally
    cdsAcessoriosEntrada.RecNo := intRecNo;
    cdsAcessoriosEntrada.EnableControls;
  End;
end;

function TfrmManutencaoLocEqu.fValidarInspecaoEntradaRealizada: Boolean;
Var
  intRecNo: Integer;
begin
  Result := True;
  FQtdIspERea := 0;
  intRecNo := cdsEqlDetEntrada.RecNo;
  cdsEqlDetEntrada.DisableControls;
  Try
    cdsEqlDetEntrada.First;
    while not cdsEqlDetEntrada.EOF do
    Begin
      If cdsEqlDetEntrada.FieldByName('EQD_ATUIPE').AsString = 'S' Then
      Begin
        Result := fValidarInspecaoAcessoriosEntradaRealizada(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);
        If Not Result Then
        Begin
          fMensagem('ATENÇÃO', 'É necessário atualizar os dados de entrada dos acessórios do equipamento ' +
                                cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString + ' - ' + cdsEqlDetEntrada.FieldByName('EQl_DESCRI').AsString , ['&Ok']);
          Break;
        End
        Else
          Inc(FQtdIspERea);
      End;

      cdsEqlDetEntrada.Next;
    End;

  Finally
    cdsEqlDetEntrada.RecNo := intRecNo;
    cdsEqlDetEntrada.EnableControls;
  End;
end;

function TfrmManutencaoLocEqu.fValidarInspecaoSaidaRealizada: Boolean;
Var
  intRecNo: Integer;
begin
  Result := True;
  FQtdIspSRea := 0;
  intRecNo := cdsEqlDetSaida.RecNo;
  cdsEqlDetSaida.DisableControls;
  Try
    cdsEqlDetSaida.First;
    while not cdsEqlDetSaida.EOF do
    Begin
      If cdsEqlDetSaida.FieldByName('EQD_ATUIPS').AsString = 'S' Then
      Begin
        inc(FQtdIspSRea);

        Result := fValidarInspecaoAcesoriosSaidaRealizada(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString);
        If Not Result Then
        Begin
          fMensagem('ATENÇÃO', 'É necessário atualizar os dados de saída dos acessórios do equipamento ' +
                                cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString + ' - ' + cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString , ['&Ok']);
          Break;
        End;

      End;

      cdsEqlDetSaida.Next;
    End;
  Finally
    cdsEqlDetSaida.RecNo := intRecNo;
    cdsEqlDetSaida.EnableControls;
  End;
end;

function TfrmManutencaoLocEqu.fValidarPodeConfirmar: Boolean;
begin
  ObjManutencaoContrato.blnAlterarInspecao := False;

  Result := fValidarPodeConfirmarInspecaoSaida;

  If Not Result Then
    Exit;

  If fValidarInspecaoEntradaRealizada Then
  Begin
    If Not fValidarInspecaoAcessoriosEntradaRealizada Then
      Result := False;
  End
  Else
    Result := False;

  If ObjManutencaoContrato.blnAlterarDtaFinalCtr Then
    Exit(True);

  If FQtdIspERea <= 0 Then
  Begin
    If FQtdIspSRea <= 0 Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', 'Nenhum equipamento foi inspecionado.', ['&Ok']);
    End
    Else
      ObjManutencaoContrato.blnAlterarInspecao := True;

  End
  Else
    ObjManutencaoContrato.blnAlterarInspecao := True;
end;

function TfrmManutencaoLocEqu.fValidarPodeConfirmarInspecaoSaida: Boolean;
begin
  Result := True;

  If fValidarInspecaoSaidaRealizada Then
  Begin
    If Not fValidarInspecaoAcesoriosSaidaRealizada Then
      Result := False;
  End
  Else
    Result := False;
end;

procedure TfrmManutencaoLocEqu.pAbrirTelaInspecaoEntradaAcessorio(const blnManInsp, blnManCob: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
  item: TAcessorioContratoLocacaoEquipamentos;
begin
  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    Try
      item := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString);

      If Not Assigned(item) Then
        Exit;

      frmInspecaoLocEquEntrada.strChaveDet := cdsAcessoriosEntrada.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquEntrada.blnAlterar := True;
      frmInspecaoLocEquEntrada.blnCarregarDados := True;
      frmInspecaoLocEquEntrada.TipoEquipamento := tpAcessorio;
      frmInspecaoLocEquEntrada.ObjItemAcessorio := item;
      frmInspecaoLocEquEntrada.blnManutencaoInspecao   := blnManInsp;
      frmInspecaoLocEquEntrada.blnManutencaoConbranca  := blnManCob;
      frmInspecaoLocEquEntrada.ShowModal;

      If frmInspecaoLocEquEntrada.ModalResult = MrOk Then
      Begin
        item.blnAtualizarInspEntrada := True;

        cdsAcessoriosEntrada.Edit;
        If item.HoraInspecaoEntrada > 0 Then
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime := item.DataInspecaoEntrada + item.HoraInspecaoEntrada
        Else
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').Clear;
        cdsAcessoriosEntrada.FieldByName('EQD_ATUIPE').AsString := IIF(item.InspecaoEntradaRealizada, 'S', 'N');
        cdsAcessoriosEntrada.FieldByName('EQD_OBSIPE').AsString := item.ObservacoesEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_VALIPE').AsFloat  := item.ValorCobranca;
        If Not fEmptyStr(item.CodConferenteEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_CONFER').AsString := item.CodConferenteEntrada + ' - ' + item.NomConferenteEntrada;
        If Not fEmptyStr(item.CodSupervisorEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').AsString := item.CodSupervisorEntrada + ' - ' + item.NomSupervisorEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_AVAIPE').AsString := item.Avaria;
        cdsAcessoriosEntrada.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmManutencaoLocEqu.pAbrirTelaInspecaoEntradaAcessorio');
      End;
    End;

  Finally
    pFreeAndNil(frmInspecaoLocEquEntrada);
  End;
end;

procedure TfrmManutencaoLocEqu.pAbrirTelaInspecaoEntradaEquipamento(const blnManInsp, blnManCob: Boolean);
var
  frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada;
  item: TItemContratoLocacaoEquipamentos;
  intRecNo: Integer;
  itemAcessorio: TAcessorioContratoLocacaoEquipamentos;
begin
  pCriarFormularios(TfrmInspecaoLocEquEntrada, frmInspecaoLocEquEntrada);
  Try
    Try
      item := ObjManutencaoContrato.Contrato.fRetornaItemContrato(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);

      If Not Assigned(item) Then
        Exit;

      frmInspecaoLocEquEntrada.strChaveDet := cdsEqlDetEntrada.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquEntrada.blnAlterar  := True;
      frmInspecaoLocEquEntrada.blnCarregarDados := True;
      frmInspecaoLocEquEntrada.TipoEquipamento := tpPrincipal;
      frmInspecaoLocEquEntrada.ObjItemEquipamento := item;
      frmInspecaoLocEquEntrada.blnManutencaoInspecao  := blnManInsp;
      frmInspecaoLocEquEntrada.blnManutencaoConbranca  := blnManCob;
      frmInspecaoLocEquEntrada.ShowModal;

      If frmInspecaoLocEquEntrada.ModalResult = mrOk Then
      Begin
        item.blnAtualizarInspEntrada := item.InspecaoEntradaRealizada;

        cdsEqlDetEntrada.Edit;
        cdsEqlDetEntrada.FieldByName('EQD_ATUIPE').AsString := IIF(item.blnAtualizarInspEntrada, 'S', 'N');
        cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').AsDateTime := item.DataInspecaoEntrada + item.HoraInspecaoEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_OBSIPE').AsString := item.ObservacoesEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_VALIPE').AsFloat := item.ValorCobranca;
        If Not fEmptyStr(item.CodConferenteEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_CONFER').AsString := item.CodConferenteEntrada + ' - ' + item.NomConferenteEntrada;
        If Not fEmptyStr(item.CodSupervisorEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_SUPERV').AsString := item.CodSupervisorEntrada + ' - ' + item.NomSupervisorEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_AVAIPE').AsString := item.Avaria;
        cdsEqlDetEntrada.Post;

        intRecNo := cdsAcessoriosEntrada.RecNo;
        cdsAcessoriosEntrada.DisableControls;
        Try
          cdsAcessoriosEntrada.First;
          while not cdsAcessoriosEntrada.EOF do
          Begin
            itemAcessorio := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString);

            If Not Assigned(itemAcessorio) Then
              Exit;

            itemAcessorio.InspecaoEntradaRealizada := item.InspecaoEntradaRealizada;
            itemAcessorio.blnAtualizarInspEntrada := item.InspecaoEntradaRealizada;
            itemAcessorio.DataInspecaoEntrada := item.DataInspecaoEntrada;
            itemAcessorio.HoraInspecaoEntrada := item.HoraInspecaoEntrada;
            itemAcessorio.CodConferenteEntrada := item.CodConferenteEntrada;
            itemAcessorio.NomConferenteEntrada := item.NomConferenteEntrada;
            itemAcessorio.CodSupervisorEntrada := item.CodSupervisorEntrada;
            itemAcessorio.NomSupervisorEntrada := item.NomSupervisorEntrada;

            cdsAcessoriosEntrada.Edit;
            cdsAcessoriosEntrada.FieldByName('EQD_ATUIPE').AsString   := IIF(itemAcessorio.InspecaoEntradaRealizada, 'S', 'N');
            cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime := itemAcessorio.DataInspecaoEntrada + itemAcessorio.HoraInspecaoEntrada;
            If Not fEmptyStr(item.CodConferenteEntrada) Then
              cdsAcessoriosEntrada.FieldByName('EQD_CONFER').AsString := itemAcessorio.CodConferenteEntrada + ' - ' + itemAcessorio.NomConferenteEntrada;
            If Not fEmptyStr(item.CodSupervisorEntrada) Then
              cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').AsString := itemAcessorio.CodSupervisorEntrada + ' - ' + itemAcessorio.NomSupervisorEntrada;
            cdsAcessoriosEntrada.Post;

            cdsAcessoriosEntrada.Next;
          End;
        Finally
          cdsAcessoriosEntrada.RecNo := intRecNo;
          cdsAcessoriosEntrada.EnableControls;
        End;
      End;

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

procedure TfrmManutencaoLocEqu.pAbrirTelaInspecaoSaidaEquipamento;
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
  item: TItemContratoLocacaoEquipamentos;
  itemAcessorio: TAcessorioContratoLocacaoEquipamentos;
  intRecNo: Integer;
begin

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  Try
    Try
      item := ObjManutencaoContrato.Contrato.fRetornaItemContrato(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString);

      If Not Assigned(item) Then
        Exit;

      frmInspecaoLocEquSaida.strChaveDet := cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquSaida.blnAlterar := True;
      frmInspecaoLocEquSaida.blnManutencaoIns := True;
      frmInspecaoLocEquSaida.blnCarregarDados := True;
      frmInspecaoLocEquSaida.TipoEquipamento := tpPrincipal;
      frmInspecaoLocEquSaida.ObjItemEquipamento := item;
      frmInspecaoLocEquSaida.ShowModal;

      If frmInspecaoLocEquSaida.ModalResult = MrOk Then
      Begin
        item.blnAtualizarInspSaida := item.InspecaoSaidaRealizada;

        cdsEqlDetSaida.Edit;
        cdsEqlDetSaida.FieldByName('EQD_ATUIPS').AsString := IIF(item.blnAtualizarInspSaida, 'S', 'N');
        cdsEqlDetSaida.FieldByName('EQD_DTAIPS').AsDateTime := item.DataInspecaoSaida + item.HoraInspecaoSaida;
        cdsEqlDetSaida.FieldByName('EQD_CNDIPS').AsString := IIF(item.strCondicaoPerfeitaSaida = 'S', 'Sim', 'Não');
        cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := item.ObservacoesSaida;
        If Not fEmptyStr(item.CodConferenteSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_CONFER').AsString := item.CodConferenteSaida + ' - ' + item.NomConferenteSaida;
        If Not fEmptyStr(item.CodSupervisorSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_SUPERV').AsString := item.CodSupervisorSaida + ' - ' + item.NomSupervisorSaida;
        cdsEqlDetSaida.Post;

        intRecNo := cdsAcessoriosSaida.RecNo;
        cdsAcessoriosSaida.DisableControls;
        Try
          cdsAcessoriosSaida.First;
          while not cdsAcessoriosSaida.EOF do
          Begin
            itemAcessorio := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString);

            If Not Assigned(itemAcessorio) Then
              Exit;

            itemAcessorio.InspecaoSaidaRealizada := item.InspecaoSaidaRealizada;
            itemAcessorio.blnAtualizarInspSaida := item.InspecaoSaidaRealizada;
            itemAcessorio.DataInspecaoSaida := item.DataInspecaoSaida;
            itemAcessorio.HoraInspecaoSaida := item.HoraInspecaoSaida;
            itemAcessorio.CodConferenteSaida := item.CodConferenteSaida;
            itemAcessorio.NomConferenteSaida := item.NomConferenteSaida;
            itemAcessorio.CodSupervisorSaida := item.CodSupervisorSaida;
            itemAcessorio.NomSupervisorSaida := item.NomSupervisorSaida;

            cdsAcessoriosSaida.Edit;
            cdsAcessoriosSaida.FieldByName('EQD_ATUIPS').AsString   := IIF(itemAcessorio.InspecaoSaidaRealizada, 'S', 'N');
            cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').AsDateTime := itemAcessorio.DataInspecaoSaida + itemAcessorio.HoraInspecaoSaida;
            If Not fEmptyStr(item.CodConferenteSaida) Then
              cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := itemAcessorio.CodConferenteSaida + ' - ' + itemAcessorio.NomConferenteSaida;
            If Not fEmptyStr(item.CodSupervisorSaida) Then
              cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := itemAcessorio.CodSupervisorSaida + ' - ' + itemAcessorio.NomSupervisorSaida;
            cdsAcessoriosSaida.Post;

            cdsAcessoriosSaida.Next;
          End;
        Finally
          cdsAcessoriosSaida.RecNo := intRecNo;
          cdsAcessoriosSaida.EnableControls;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TManutencaoContrato.pAbrirTelaInspecaoSaida');
      End;
    End;
  Finally
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
end;

procedure TfrmManutencaoLocEqu.pAbrirTelaInspecaoSaidaAcessorio;
var
  frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida;
  item: TAcessorioContratoLocacaoEquipamentos;
begin

  pCriarFormularios(TfrmInspecaoLocEquSaida, frmInspecaoLocEquSaida);
  Try
    Try
      item := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString);

      If Not Assigned(item) Then
        Exit;

      frmInspecaoLocEquSaida.strChaveDet := cdsAcessoriosSaida.FieldByName('AUTOINCREM').AsString;
      frmInspecaoLocEquSaida.blnAlterar := True;
      frmInspecaoLocEquSaida.blnCarregarDados := True;
      frmInspecaoLocEquSaida.TipoEquipamento := tpAcessorio;
      frmInspecaoLocEquSaida.ObjItemAcessorio := item;
      frmInspecaoLocEquSaida.blnManutencaoIns := True;
      frmInspecaoLocEquSaida.ShowModal;

      If frmInspecaoLocEquSaida.ModalResult = MrOk Then
      Begin
        item.blnAtualizarInspSaida := True;

        cdsAcessoriosSaida.Edit;
        cdsAcessoriosSaida.FieldByName('EQD_ATUIPS').AsString := IIF(item.InspecaoSaidaRealizada, 'S', 'N');
        cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').AsDateTime := item.DataInspecaoSaida + item.HoraInspecaoSaida;
        cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := item.ObservacoesSaida;
        cdsAcessoriosSaida.FieldByName('EQD_CNDIPS').AsString :=  IIF(item.strCondicaoPerfeitaSaida = 'S', 'Sim', 'Não');
        If Not fEmptyStr(item.CodConferenteSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := item.CodConferenteSaida + ' - ' + item.NomConferenteSaida;
        If Not fEmptyStr(item.CodSupervisorSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := item.CodSupervisorSaida + ' - ' + item.NomSupervisorSaida;
        cdsAcessoriosSaida.Post;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmManutencaoLocEqu.pAbrirTelaInspecaoSaidaAcessorio');
      End;
    End;
  Finally
    pFreeAndNil(frmInspecaoLocEquSaida);
  End;
end;

procedure TfrmManutencaoLocEqu.pAlterarInspecaoEntradaAcessorios(const blnManInsp, blnManCob: Boolean);
begin
  If Not ObjManutencaoContrato.objValidaCtr.fVerificaPodeRealizarInspecaoEntrada Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.objValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  If blnManCob Then
  Begin
    If cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime <= 0 Then
    Begin
      fMensagem('ATENÇÃO', 'Necessário realizar a inspeção de Entrada antes de ajustar o valor de cobrança!', ['&Ok']);
      Exit;
    End;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  pAbrirTelaInspecaoEntradaAcessorio(blnManInsp, blnManCob);
end;

procedure TfrmManutencaoLocEqu.pAlterarInspecaoEntradaEquipamento(const blnManInsp, blnManCob: Boolean);
begin
  If Not ObjManutencaoContrato.objValidaCtr.fVerificaPodeRealizarInspecaoEntrada Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.objValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  If blnManCob Then
  Begin
    If cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').AsDateTime <= 0 Then
    Begin
      fMensagem('ATENÇÃO', 'Necessário realizar a inspeção de Entrada antes de ajustar o valor de cobrança!', ['&Ok']);
      Exit;
    End;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocEntrada.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;
  pAbrirTelaInspecaoEntradaEquipamento(blnManInsp, blnManCob);
end;

procedure TfrmManutencaoLocEqu.pAlterarInspecaoSaidaAcessorios;
begin
  If Not ObjManutencaoContrato.objValidaCtr.fVerificaPodeRealizarInspecaoSaida Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.objValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  pAbrirTelaInspecaoSaidaAcessorio;
end;

procedure TfrmManutencaoLocEqu.pAlterarInspecaoSaidaEquipamento;
begin
  If Not ObjManutencaoContrato.objValidaCtr.fVerificaPodeRealizarInspecaoSaida Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.objValidaCtr.strMensagemRetorno, ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  pAbrirTelaInspecaoSaidaEquipamento;
end;

procedure TfrmManutencaoLocEqu.pCancelarInspecaoAceEntrada;
var
  item: TAcessorioContratoLocacaoEquipamentos;
begin
  If Not fVerificaAcessoSistema('LOCIPE') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para cancelar a inspeção de Entrada!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocEntrada.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  Try
    item := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString);
    If Not Assigned(item) Then
      Exit;

    item.pLimparDadosInspecaoEntrada(True);
    item.blnAtualizarInspEntrada := True;

    cdsAcessoriosEntrada.Edit;
    cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').Clear;
    cdsAcessoriosEntrada.FieldByName('EQD_ATUIPE').AsString := 'S';
    cdsAcessoriosEntrada.FieldByName('EQD_OBSIPE').AsString := item.ObservacoesEntrada;
    cdsAcessoriosEntrada.FieldByName('EQD_VALIPE').AsFloat  := item.ValorCobranca;
    If fEmptyStr(item.CodConferenteEntrada) Then
      cdsAcessoriosEntrada.FieldByName('EQD_CONFER').Clear;
    If fEmptyStr(item.CodSupervisorEntrada) Then
      cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').Clear;
    cdsAcessoriosEntrada.FieldByName('EQD_VALIPE').AsFloat  := item.ValorCobranca;
    cdsAcessoriosEntrada.FieldByName('EQD_AVAIPE').AsString := item.Avaria;
    cdsAcessoriosEntrada.Post;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmManutencaoLocEqu.pCancelarInspecaoAceEntrada');
    End;
  End;
end;

procedure TfrmManutencaoLocEqu.pCancelarInspecaoAceSaida;
var
  item: TAcessorioContratoLocacaoEquipamentos;
begin
  If Not fVerificaAcessoSistema('LOCIPS') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para cancelar a inspeção de Saída!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  item := ObjManutencaoContrato.Contrato.fRetornaItemAcessorioContrato(cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString, cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString);
  If Not Assigned(item) Then
    Exit;

  item.pLimparDadosInspecaoSaida(True);
  item.blnAtualizarInspSaida := True;

  cdsAcessoriosSaida.Edit;
  cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').Clear;
  cdsAcessoriosSaida.FieldByName('EQD_ATUIPS').AsString := 'S';
  cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := item.ObservacoesEntrada;
  If fEmptyStr(item.CodConferenteEntrada) Then
    cdsAcessoriosSaida.FieldByName('EQD_CONFER').Clear;
  If fEmptyStr(item.CodSupervisorEntrada) Then
    cdsAcessoriosSaida.FieldByName('EQD_SUPERV').Clear;
  cdsAcessoriosSaida.Post;
end;

procedure TfrmManutencaoLocEqu.pCancelarInspecaoEquEntrada;
var
  item: TItemContratoLocacaoEquipamentos;
begin
  If Not fVerificaAcessoSistema('LOCIPE') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para cancelar a inspeção de Entrada!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocEntrada.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  item := ObjManutencaoContrato.Contrato.fRetornaItemContrato(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);

  If Not Assigned(item) Then
    Exit;

  item.pLimparDadosInspecaoEntrada(True);
  item.blnAtualizarInspEntrada := True;

  cdsEqlDetEntrada.Edit;
  cdsEqlDetEntrada.FieldByName('EQD_ATUIPE').AsString := 'S';
  cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').Clear;
  cdsEqlDetEntrada.FieldByName('EQD_OBSIPE').AsString := item.ObservacoesEntrada;
  If fEmptyStr(item.CodConferenteEntrada) Then
    cdsEqlDetEntrada.FieldByName('EQD_CONFER').Clear;
  If fEmptyStr(item.CodSupervisorEntrada) Then
    cdsEqlDetEntrada.FieldByName('EQD_SUPERV').Clear;
  cdsEqlDetEntrada.FieldByName('EQD_VALIPE').AsFloat  := item.ValorCobranca;
  cdsEqlDetEntrada.FieldByName('EQD_AVAIPE').AsString := item.Avaria;
  cdsEqlDetEntrada.Post;
end;

procedure TfrmManutencaoLocEqu.pCancelarInspecaoEquSaida;
var
  item: TItemContratoLocacaoEquipamentos;
begin
  If Not fVerificaAcessoSistema('LOCIPS') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para cancelar a inspeção de Saída!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  item := ObjManutencaoContrato.Contrato.fRetornaItemContrato(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString);

  If Not Assigned(item) Then
    Exit;

  item.pLimparDadosInspecaoSaida(True);
  item.blnAtualizarInspSaida := True;

  cdsEqlDetSaida.Edit;
  cdsEqlDetSaida.FieldByName('EQD_ATUIPS').AsString := 'S';
  cdsEqlDetSaida.FieldByName('EQD_DTAIPS').Clear;
  cdsEqlDetSaida.FieldByName('EQD_CNDIPS').AsString := item.strCondicaoPerfeitaSaida;
  cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := item.ObservacoesSaida;
  If fEmptyStr(item.CodConferenteSaida) Then
    cdsEqlDetSaida.FieldByName('EQD_CONFER').Clear;
  If fEmptyStr(item.CodSupervisorSaida) Then
    cdsEqlDetSaida.FieldByName('EQD_SUPERV').Clear;
  cdsEqlDetSaida.Post;
end;

procedure TfrmManutencaoLocEqu.pCarregarAcessoriosEntrada(aItem: TItemContratoLocacaoEquipamentos);
var
  intCnt: Integer;
begin
  If Not FBlnExibirAcessorios Then
    Exit;

  cdsAcessoriosEntrada.DisableControls;
  Try
    Try
      For intCnt := 0 to aItem.Acessorios.Count-1 Do
      Begin
        cdsAcessoriosEntrada.Insert;
        cdsAcessoriosEntrada.FieldByName('EQD_ATUIPE').AsString := 'N';
        cdsAcessoriosEntrada.FieldByName('AUTOINCREM').AsString := aItem.Acessorios[intCnt].AutInc;
        cdsAcessoriosEntrada.FieldByName('EQD_SEQEQL').AsString := aItem.Equipamento.Codigo;
        cdsAcessoriosEntrada.FieldByName('EQD_SEQACL').AsString := aItem.Acessorios[intCnt].Acessorio.Codigo;
        cdsAcessoriosEntrada.FieldByName('EQD_DESCRI').AsString := aItem.Acessorios[intCnt].Acessorio.Descricao;
        cdsAcessoriosEntrada.FieldByName('EQD_QTDACL').AsFloat  := aItem.Acessorios[intCnt].Quantidade;
        If aItem.Acessorios[intCnt].DataInspecaoEntrada > 0 Then
          cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE').AsDateTime := aItem.Acessorios[intCnt].DataInspecaoEntrada + aItem.Acessorios[intCnt].HoraInspecaoEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_OBSIPE').AsString := aItem.Acessorios[intCnt].ObservacoesEntrada;
        If Not fEmptyStr(aItem.Acessorios[intCnt].CodConferenteEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_CONFER').AsString := aItem.Acessorios[intCnt].CodConferenteEntrada+ ' - ' + aItem.Acessorios[intCnt].NomConferenteEntrada;
        If Not fEmptyStr(aItem.Acessorios[intCnt].CodSupervisorEntrada) Then
          cdsAcessoriosEntrada.FieldByName('EQD_SUPERV').AsString := aItem.Acessorios[intCnt].CodSupervisorEntrada + ' - ' + aItem.Acessorios[intCnt].NomSupervisorEntrada;
        cdsAcessoriosEntrada.FieldByName('EQD_VALIPE').AsFloat := aItem.Acessorios[intCnt].ValorCobranca;
        cdsAcessoriosEntrada.FieldByName('EQD_AVAIPE').AsString := aItem.Acessorios[intCnt].Avaria;
        cdsAcessoriosEntrada.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Acessorios[intCnt].Quantidade * aItem.Quantidade;
        cdsAcessoriosEntrada.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmManutencaoLocEqu.pCarregarAcessoriosEntrada]');
      End;
    End;
  Finally
    cdsAcessoriosEntrada.EnableControls;
  End;
end;

procedure TfrmManutencaoLocEqu.pCarregarAcessoriosSaida(aItem: TItemContratoLocacaoEquipamentos);
var
  intCnt: Integer;
begin
  If Not FBlnExibirAcessorios Then
    Exit;

  cdsAcessoriosSaida.DisableControls;
  Try
    Try
      For intCnt := 0 to aItem.Acessorios.Count-1 Do
      Begin
        cdsAcessoriosSaida.Insert;
        cdsAcessoriosSaida.FieldByName('EQD_ATUIPS').AsString := 'N';
        cdsAcessoriosSaida.FieldByName('AUTOINCREM').AsString := aItem.Acessorios[intCnt].AutInc;
        cdsAcessoriosSaida.FieldByName('EQD_SEQEQL').AsString := aItem.Equipamento.Codigo;
        cdsAcessoriosSaida.FieldByName('EQD_SEQACL').AsString := aItem.Acessorios[intCnt].Acessorio.Codigo;
        cdsAcessoriosSaida.FieldByName('EQD_DESCRI').AsString := aItem.Acessorios[intCnt].Acessorio.Descricao;
        cdsAcessoriosSaida.FieldByName('EQD_QTDACL').AsFloat  := aItem.Acessorios[intCnt].Quantidade;
        If aItem.Acessorios[intCnt].DataInspecaoSaida > 0 Then
          cdsAcessoriosSaida.FieldByName('EQD_DTAIPS').AsDateTime := aItem.Acessorios[intCnt].DataInspecaoSaida + aItem.Acessorios[intCnt].HoraInspecaoSaida;
        cdsAcessoriosSaida.FieldByName('EQD_CNDIPS').AsString := IIF(aItem.Acessorios[intCnt].strCondicaoPerfeitaSaida = 'S', 'Sim', 'Não');
        cdsAcessoriosSaida.FieldByName('EQD_OBSIPS').AsString := aItem.Acessorios[intCnt].ObservacoesSaida;
        If Not fEmptyStr(aItem.Acessorios[intCnt].CodConferenteSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_CONFER').AsString := aItem.Acessorios[intCnt].CodConferenteSaida+ ' - ' + aItem.Acessorios[intCnt].NomConferenteSaida;
        If Not fEmptyStr(aItem.Acessorios[intCnt].CodSupervisorSaida) Then
          cdsAcessoriosSaida.FieldByName('EQD_SUPERV').AsString := aItem.Acessorios[intCnt].CodSupervisorSaida + ' - ' + aItem.Acessorios[intCnt].NomSupervisorSaida;
        cdsAcessoriosSaida.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Acessorios[intCnt].Quantidade * aItem.Quantidade;

        cdsAcessoriosSaida.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmManutencaoLocEqu.pCarregarAcessoriosSaida]');
      End;
    End;
  Finally
    cdsAcessoriosSaida.EnableControls;
  End;
end;

procedure TfrmManutencaoLocEqu.pCarregarEquipamentosEntrada;
var
  intCnt: Integer;
begin
  If cdsEqlDetEntrada.Active Then
    cdsEqlDetEntrada.EmptyDataSet;

  If cdsAcessoriosEntrada.Active Then
    cdsAcessoriosEntrada.EmptyDataSet;

  FBlnCarregandoItensEntrada := True;
  cdsEqlDetEntrada.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjManutencaoContrato.Contrato.Itens.Count-1 Do
      Begin
        If ObjManutencaoContrato.Contrato.Itens[intCnt].DataEncerramento > 0 Then
          Continue;

        cdsEqlDetEntrada.Insert;
        cdsEqlDetEntrada.FieldByName('EQD_ATUIPE').AsString := 'N';
        cdsEqlDetEntrada.FieldByName('AUTOINCREM').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.AutInc;
        cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDetEntrada.FieldByName('EQL_NSERIE').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.NumSerie;
        cdsEqlDetEntrada.FieldByName('EQD_CODCLI').AsString := ObjManutencaoContrato.Contrato.CodCliente;
        If ObjManutencaoContrato.Contrato.Itens[intCnt].DataInspecaoEntrada > 0 Then
          cdsEqlDetEntrada.FieldByName('EQD_DTAIPE').AsDateTime := ObjManutencaoContrato.Contrato.Itens[intCnt].DataInspecaoEntrada + ObjManutencaoContrato.Contrato.Itens[intCnt].HoraInspecaoEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_OBSIPE').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].ObservacoesEntrada;
        If Not fEmptyStr(ObjManutencaoContrato.Contrato.Itens[intCnt].CodConferenteEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_CONFER').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].CodConferenteEntrada+ ' - ' + ObjManutencaoContrato.Contrato.Itens[intCnt].NomConferenteEntrada;
        If Not fEmptyStr(ObjManutencaoContrato.Contrato.Itens[intCnt].CodSupervisorEntrada) Then
          cdsEqlDetEntrada.FieldByName('EQD_SUPERV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].CodSupervisorEntrada + ' - ' + ObjManutencaoContrato.Contrato.Itens[intCnt].NomSupervisorEntrada;
        cdsEqlDetEntrada.FieldByName('EQD_VALIPE').AsFloat  := ObjManutencaoContrato.Contrato.Itens[intCnt].ValorCobranca;
        cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].NumRet;
        cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].EspRet;
        cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].EmpRet;
        cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].SerRet;
        cdsEqlDetEntrada.FieldByName('EQD_AVAIPE').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Avaria;
        cdsEqlDetEntrada.FieldByName('EQD_QTDEQU').AsFloat := ObjManutencaoContrato.Contrato.Itens[intCnt].Quantidade;

        cdsEqlDetEntrada.Post;

        pCarregarAcessoriosEntrada(ObjManutencaoContrato.Contrato.Itens[intCnt]);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmManutencaoLocEqu.pCarregarEquipamentosEntrada]');
      End;
    End;
  Finally
    cdsEqlDetEntrada.EnableControls;
    FBlnCarregandoItensEntrada := False;
    cdsEqlDetEntrada.First;
  End;
end;

procedure TfrmManutencaoLocEqu.pCarregarEquipamentosSaida;
var
  intCnt: Integer;
begin

  If cdsEqlDetSaida.Active Then
    cdsEqlDetSaida.EmptyDataSet;

  If cdsAcessoriosSaida.Active Then
    cdsAcessoriosSaida.EmptyDataSet;

  FBlnCarregandoItensSaida := True;
  cdsEqlDetSaida.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjManutencaoContrato.Contrato.Itens.Count-1 Do
      Begin
        If ObjManutencaoContrato.Contrato.Itens[intCnt].DataEncerramento > 0 Then
          Continue;

        cdsEqlDetSaida.Insert;
        cdsEqlDetSaida.FieldByName('EQD_ATUIPS').AsString := 'N';
        cdsEqlDetSaida.FieldByName('AUTOINCREM').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.AutInc;
        cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.Codigo;
        cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.Descricao;
        cdsEqlDetSaida.FieldByName('EQL_NSERIE').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].Equipamento.NumSerie;
        If ObjManutencaoContrato.Contrato.Itens[intCnt].DataInspecaoSaida > 0 Then
          cdsEqlDetSaida.FieldByName('EQD_DTAIPS').AsDateTime := ObjManutencaoContrato.Contrato.Itens[intCnt].DataInspecaoSaida + ObjManutencaoContrato.Contrato.Itens[intCnt].HoraInspecaoSaida;
        cdsEqlDetSaida.FieldByName('EQD_CNDIPS').AsString := IIF(ObjManutencaoContrato.Contrato.Itens[intCnt].strCondicaoPerfeitaSaida = 'S', 'Sim', 'Não');
        cdsEqlDetSaida.FieldByName('EQD_OBSIPS').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].ObservacoesSaida;
        If Not fEmptyStr(ObjManutencaoContrato.Contrato.Itens[intCnt].CodConferenteSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_CONFER').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].CodConferenteSaida+ ' - ' + ObjManutencaoContrato.Contrato.Itens[intCnt].NomConferenteSaida;
        If Not fEmptyStr(ObjManutencaoContrato.Contrato.Itens[intCnt].CodSupervisorSaida) Then
          cdsEqlDetSaida.FieldByName('EQD_SUPERV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].CodSupervisorSaida + ' - ' + ObjManutencaoContrato.Contrato.Itens[intCnt].NomSupervisorSaida;
        cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].NumEnv;
        cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].EspEnv;
        cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].EmpEnv;
        cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString := ObjManutencaoContrato.Contrato.Itens[intCnt].SerEnv;
        cdsEqlDetSaida.FieldByName('EQD_QTDEQU').AsFloat := ObjManutencaoContrato.Contrato.Itens[intCnt].Quantidade;

        cdsEqlDetSaida.Post;
        pCarregarAcessoriosSaida(ObjManutencaoContrato.Contrato.Itens[intCnt]);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmManutencaoLocEqu.pCarregarEquipamentosSaida]');
      End;
    End;
  Finally
    FBlnCarregandoItensSaida := False;
    cdsEqlDetSaida.EnableControls;
    cdsEqlDetSaida.First;
  End;
end;

procedure TfrmManutencaoLocEqu.pConfirmar;
begin
  If Not fValidarPodeConfirmar Then
    Exit;

  If ObjManutencaoContrato.fConfirmarManutencao Then
  Begin
    fMensagem('ATENÇÃO', 'Processo Concluído com sucesso!', ['&Ok']);
    Self.Close;
  End
  Else If Not fEmptyStr(ObjManutencaoContrato.MensagemRetorno) Then
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
end;

procedure TfrmManutencaoLocEqu.btnAlterarCobrancaClick(Sender: TObject);
begin
  inherited;

  ObjManutencaoContrato.TipoManutencao := tpAlterarCobranca;

  Case FTpInspecao Of
    tpInspEntraEqu: pAlterarInspecaoEntradaEquipamento(False, True);
    tpInspEntraAce: pAlterarInspecaoEntradaAcessorios(False, True);
  end;

end;

procedure TfrmManutencaoLocEqu.btnAlterarContratoClick(Sender: TObject);
var
  frmAltContratoLocEqu: TfrmAltContratoLocEqu;
begin
  inherited;

  If Not fVerificaAcessoSistema('ATUCTR') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado alterar informações do Contrato!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmAltContratoLocEqu, frmAltContratoLocEqu);
  Try
    frmAltContratoLocEqu.objContrato := ObjManutencaoContrato.Contrato;
    frmAltContratoLocEqu.ShowModal;
    If frmAltContratoLocEqu.ModalResult = MrOk Then
    Begin
      ObjManutencaoContrato.dtaFinalContrato := StrToDateTime(frmAltContratoLocEqu.edtDtaFin.Text + ' ' +frmAltContratoLocEqu.edtHorFin.Text);
      ObjManutencaoContrato.blnAlterarDtaFinalCtr := True;
    End;
  Finally
    pFreeAndNil(frmAltContratoLocEqu);
  End;

end;

procedure TfrmManutencaoLocEqu.btnAlterarInspecaoClick(Sender: TObject);
begin
  inherited;

  ObjManutencaoContrato.TipoManutencao := tpAlterarInspecao;

  Case FTpInspecao Of
    tpInspSaidaEqu: pAlterarInspecaoSaidaEquipamento;
    tpInspSaidaAce: pAlterarInspecaoSaidaAcessorios;
    tpInspEntraEqu: pAlterarInspecaoEntradaEquipamento(True, False);
    tpInspEntraAce: pAlterarInspecaoEntradaAcessorios(True, False);
    tpInspNone    : fMensagem('ATENÇÃO', 'Nenhum item selecionado!', ['&Ok']);
  end;

end;

procedure TfrmManutencaoLocEqu.btnCancelarDocEntradaClick(Sender: TObject);
var
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
  strEspDoc: String;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmCancelamentoDocumentos') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para a tela de Cancelamento de Documentos!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoEntradaEqu(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString, False) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocEntrada.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  ObjManutencaoContrato.Contrato.pCarregarDadosAdiantamento;
  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
  Try
    frmCancelamentoDocumentos.edtCliFor.Text := ObjManutencaoContrato.Contrato.CodCliente;
    frmCancelamentoDocumentos.edtDesCri.Text := ObjManutencaoContrato.Contrato.NomCliente;
    frmCancelamentoDocumentos.edtSerie.Text  := cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString;

    strEspDoc := TManutencaoContrato.fRetornaEspecieNFRetorno(cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString,
                                                              cdsEqlDetEntrada.FieldByName('EQD_CODCLI').AsString,
                                                              cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString,
                                                              cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString);


    frmCancelamentoDocumentos.pCancelarDocumentoLocacaoEquipamento(strEspDoc,
                                                                   '',
                                                                   '',
                                                                   cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString);
    If Not frmCancelamentoDocumentos.BlnCancelaProcessoAutomaticoLoc Then
      frmCancelamentoDocumentos.ShowModal;
    If (frmCancelamentoDocumentos.FblnCancelamentoComSucesso) Then
    Begin
      ObjManutencaoContrato.pLimpaDocumentoRetorno(cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString,
                                                   cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString,
                                                   cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString,
                                                   cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString);

      pLimparItensDocumentoEntrada(cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString,
                                   cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString,
                                   cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString,
                                   cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString);

      fMensagem('ATENÇÃO', 'Cancelamento efetuado com sucesso.', ['&Ok']);
    End;
  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;
end;

procedure TfrmManutencaoLocEqu.pLimparItensDocumentoEntrada(const strEspDoc, strCodEmp, strNumDoc, strSerDoc: String);
var
  intRecNo: Integer;
Begin
  intRecNo := cdsEqlDetEntrada.RecNo;
  Try
    cdsEqlDetEntrada.First;
    While Not cdsEqlDetEntrada.Eof Do
    Begin
      If (cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString = strEspDoc) And
         (cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString = strCodEmp) And
         (cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString = strNumDoc) And
         (cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString = strSerDoc) Then
      Begin
        cdsEqlDetEntrada.Edit;
        cdsEqlDetEntrada.FieldByName('EQD_ATUIPE').AsString := 'S';
        cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString := EmptyStr;
        cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString := EmptyStr;
        cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString := EmptyStr;
        cdsEqlDetEntrada.FieldByName('EQD_SERRET').AsString := EmptyStr;
        cdsEqlDetEntrada.Post;
      End;

      cdsEqlDetEntrada.Next;
    End;
  Finally
    cdsEqlDetEntrada.RecNo := intRecNo;
  End;
End;

procedure TfrmManutencaoLocEqu.btnCancelarDocSaidaClick(Sender: TObject);
var
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmCancelamentoDocumentos') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para a tela de Cancelamento de Documentos!', ['&Ok']);
    Exit;
  End;

  If Not ObjManutencaoContrato.fPermiteRealizarManutencaoSaidaEqu(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString, False, True) Then
  Begin
    fMensagem('ATENÇÃO', ObjManutencaoContrato.MensagemRetorno, ['&Ok']);
    btnCancelarDocSaida.Enabled := ObjManutencaoContrato.blnPermiteCancelamentoDocumento;
    Exit;
  End;

  ObjManutencaoContrato.Contrato.pCarregarDadosAdiantamento;
  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
  Try
    Try
      frmCancelamentoDocumentos.edtCliFor.Text := ObjManutencaoContrato.Contrato.CodCliente;
      frmCancelamentoDocumentos.edtDesCri.Text := ObjManutencaoContrato.Contrato.NomCliente;
      frmCancelamentoDocumentos.edtSerie.Text  := cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString;
      frmCancelamentoDocumentos.pCancelarDocumentoLocacaoEquipamento(cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString,
                                                                     '',
                                                                     '',
                                                                     cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString);
      If Not frmCancelamentoDocumentos.BlnCancelaProcessoAutomaticoLoc Then
        frmCancelamentoDocumentos.ShowModal;
      If frmCancelamentoDocumentos.FblnCancelamentoComSucesso Then
      Begin
        ObjManutencaoContrato.pLimpaDocumentoEnvio(cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString,
                                                   cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString,
                                                   cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString,
                                                   cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString);

        pLimparItensDocumentoSaida(cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString,
                                   cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString,
                                   cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString,
                                   cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString);


        fMensagem('ATENÇÃO', 'Cancelamento efetuado com sucesso.', ['&Ok']);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmManutencaoLocEqu.btnCancelarDocSaidaClick');
      End;
    End;
  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;
end;

procedure TfrmManutencaoLocEqu.pLimparItensDocumentoSaida(const strEspDoc, strCodEmp, strNumDoc, strSerDoc: String);
var
  intRecNo: Integer;
Begin
  intRecNo := cdsEqlDetSaida.RecNo;
  Try
    cdsEqlDetSaida.First;
    While Not cdsEqlDetSaida.Eof Do
    Begin
      If (cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString = strEspDoc) And
         (cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString = strCodEmp) And
         (cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString = strNumDoc) And
         (cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString = strSerDoc) Then
      Begin
        cdsEqlDetSaida.Edit;
        cdsEqlDetSaida.FieldByName('EQD_ATUIPS').AsString := 'S';
        cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString := EmptyStr;
        cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString := EmptyStr;
        cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString := EmptyStr;
        cdsEqlDetSaida.FieldByName('EQD_SERENV').AsString := EmptyStr;
        cdsEqlDetSaida.Post;
      End;
      cdsEqlDetSaida.Next;
    End;
  Finally
    cdsEqlDetSaida.RecNo := intRecNo;
  End;
End;

procedure TfrmManutencaoLocEqu.btnCancelarInspecaoClick(Sender: TObject);
begin
  inherited;

  If fMensagem('ATENÇÃO', ' Deseja realmente realizar o cancelamento da inspeção?', ['&Sim', '&Não']) = 2 Then
     Exit;

  ObjManutencaoContrato.TipoManutencao := tpCancelar;

  Case FTpInspecao Of
    tpInspSaidaEqu: pCancelarInspecaoEquSaida;
    tpInspSaidaAce: pCancelarInspecaoAceSaida;
    tpInspEntraEqu: pCancelarInspecaoEquEntrada;
    tpInspEntraAce: pCancelarInspecaoAceEntrada;
  end;

end;

procedure TfrmManutencaoLocEqu.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  TfrmGravando.fExecutarModal(pConfirmar, 'Aguarde confirmando manutenção de inspeção....', 'ManutencaoLocEqu');
  FTpInspecao := tpInspNone;
end;

procedure TfrmManutencaoLocEqu.cdsEqlDetEntradaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If FBlnCarregandoItensEntrada Then
    Exit;

  If cdsEqlDetEntrada.IsEmpty Then
    Exit;

  If FBlnExibirAcessorios Then
  Begin
    cdsAcessoriosEntrada.Filter := 'EQD_SEQEQL = ' + QuotedStr(cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString);
    cdsAcessoriosEntrada.Filtered := True;

    pnlDescricaoAcessorioEntrada.Caption := '  Acessórios do Equipamento: ' + cdsEqlDetEntrada.FieldByName('EQD_SEQEQL').AsString + ' - ' + cdsEqlDetEntrada.FieldByName('EQL_DESCRI').AsString;
  End;

  lblDocumentoEntrada.Caption := ' Documento de Retorno: ' + cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString + '-' + cdsEqlDetEntrada.FieldByName('EQD_ESPRET').AsString + '-' + cdsEqlDetEntrada.FieldByName('EQD_EMPRET').AsString;
  btnCancelarDocEntrada.Enabled := Not fEmptyStr(cdsEqlDetEntrada.FieldByName('EQD_NUMRET').AsString);

end;

procedure TfrmManutencaoLocEqu.cdsEqlDetSaidaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If FBlnCarregandoItensSaida Then
    Exit;

  If cdsEqlDetSaida.IsEmpty Then
    Exit;

  If FBlnExibirAcessorios Then
  Begin
    cdsAcessoriosSaida.Filter := 'EQD_SEQEQL = ' + QuotedStr(cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString);
    cdsAcessoriosSaida.Filtered := True;

    pnlDescricaoAcessorioSaida.Caption := '  Acessórios do Equipamento: ' + cdsEqlDetSaida.FieldByName('EQD_SEQEQL').AsString + ' - ' + cdsEqlDetSaida.FieldByName('EQL_DESCRI').AsString;
  End;

  lblDocumentoSaida.Caption := ' Documento de Envio: ' + cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString + '-' + cdsEqlDetSaida.FieldByName('EQD_ESPENV').AsString + '-' + cdsEqlDetSaida.FieldByName('EQD_EMPENV').AsString;
  btnCancelarDocSaida.Enabled := Not fEmptyStr(cdsEqlDetSaida.FieldByName('EQD_NUMENV').AsString);
end;

procedure TfrmManutencaoLocEqu.cxGridAcessoriosEntradaEnter(Sender: TObject);
begin
  inherited;

  FTpInspecao := tpInspEntraAce;
  btnAlterarCobranca.Enabled := True;
end;

procedure TfrmManutencaoLocEqu.cxGridAcessoriosEntradaExit(Sender: TObject);
begin
  inherited;

  btnAlterarCobranca.Enabled := False;
end;

procedure TfrmManutencaoLocEqu.cxGridAcessoriosSaidaEnter(Sender: TObject);
begin
  inherited;

  FTpInspecao := tpInspSaidaAce;
  btnAlterarCobranca.Enabled := False;
end;

procedure TfrmManutencaoLocEqu.cxGridEquipamentosEntradaEnter(Sender: TObject);
begin
  inherited;

  FTpInspecao := tpInspEntraEqu;
  btnAlterarCobranca.Enabled := True;
end;

procedure TfrmManutencaoLocEqu.cxGridEquipamentosEntradaExit(Sender: TObject);
begin
  inherited;

  btnAlterarCobranca.Enabled := False;
end;
procedure TfrmManutencaoLocEqu.cxGridEquipamentosSaidaEnter(Sender: TObject);
begin
  inherited;

  FTpInspecao := tpInspSaidaEqu;
  btnAlterarCobranca.Enabled := False;
end;

procedure TfrmManutencaoLocEqu.pCriarDataSets;
begin
  cdsEqlDetSaida.CreateDataSet;
  cdsAcessoriosSaida.CreateDataSet;
  cdsEqlDetEntrada.CreateDataSet;
  cdsAcessoriosEntrada.CreateDataSet;
end;

procedure TfrmManutencaoLocEqu.pFormatarCampos;
begin
  TFloatField(cdsEqlDetEntrada.FieldByName('EQD_VALIPE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsAcessoriosEntrada.FieldByName('EQD_VALIPE')).DisplayFormat := '#,##0.00';
  TTimeField(cdsEqlDetSaida.FieldByName('EQD_DTAIPS')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsAcessoriosSaida.FieldByName('EQD_DTAIPS')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsEqlDetEntrada.FieldByName('EQD_DTAIPE')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsAcessoriosEntrada.FieldByName('EQD_DTAIPE')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
end;

procedure TfrmManutencaoLocEqu.pLimparCampos;
begin
  inherited;

  edtNumCon.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtLocalizacao.Clear;
end;

function TfrmManutencaoLocEqu.fValidarInspecaoAcesoriosSaidaRealizada: Boolean;
begin
  If ObjManutencaoContrato.TipoManutencao <> tpAlterarCobranca Then
  Begin
    If FQtdIspSRea <= 0 Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  If cdsAcessoriosSaida.RecordCount = 0 Then
  Begin
    Result := True;
    Exit;
  End;
  cdsAcessoriosSaida.Filtered := False;
  cdsAcessoriosSaida.Filter   := 'EQD_ATUIPS = ' + QuotedStr('S');
  cdsAcessoriosSaida.Filtered := True;

  FQtdIspSRea := FQtdIspSRea + cdsAcessoriosSaida.RecordCount;

  cdsAcessoriosSaida.Filtered := False;

  Result := (cdsAcessoriosSaida.RecordCount > 0);
end;

function TfrmManutencaoLocEqu.fValidarInspecaoAcessoriosEntradaRealizada: Boolean;
begin
  If ObjManutencaoContrato.TipoManutencao <> tpAlterarCobranca Then
  Begin
    If FQtdIspERea <= 0 Then
    Begin
      Result := True;
      Exit;
    End;
  End;

  If cdsAcessoriosEntrada.RecordCount = 0 Then
  Begin
    Result := True;
    Exit;
  End;

  cdsAcessoriosEntrada.Filtered := False;
  cdsAcessoriosEntrada.Filter := 'EQD_ATUIPE =' + QuotedStr('S');
  cdsAcessoriosEntrada.Filtered := True;

  FQtdIspERea := FQtdIspERea + cdsAcessoriosEntrada.RecordCount;

  cdsAcessoriosEntrada.Filtered := False;

  Result := (cdsAcessoriosEntrada.RecordCount > 0);
end;

end.
