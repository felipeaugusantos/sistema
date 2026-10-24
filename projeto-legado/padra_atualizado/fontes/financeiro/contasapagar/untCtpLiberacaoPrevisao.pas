unit untCtpLiberacaoPrevisao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, Vcl.Mask, MaskEditFocus, EditFocus, ComboBoxFocus,
  System.StrUtils, Uni, untTypesSistema, cxButtons, UniDataSetProvider,
  UniClientDataSet, MemoFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog,untBaixaCtpBusca,
  untFrameCentroCustoEditFocus, System.IOUtils, QColorLabel,
  untFramePlanoDeContasMaskEdit;

type
  TfrmCtpLiberacaoPrevisao = class(TfrmPaiSimples)
    pnlBotoesBaixa: TPanel;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnAprovar: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label24: TLabel;
    Label11: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    chkLimFil: TCheckBox;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    btnConsultar: TBitBtnLocked;
    mskDtaVenIni: TcxDateEdit;
    mskDtaVenFin: TcxDateEdit;
    pnlAux1: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label23: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    edtQtdDuplicatas: TEditFocus;
    edtQtdSelecionadas: TEditFocus;
    edtValorTotal: TEditFocus;
    edtTotalPago: TEditFocus;
    edtCheque: TEditFocus;
    edtCodigoResponsavel: TEditFocus;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    dbgDuplicatasCTP_NOMPOR: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_MARDES: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    Label3: TLabel;
    Label25: TLabel;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    Label26: TLabel;
    cmbStatus: TComboBoxFocus;
    edtDescricaoResponsavel: TEditFocus;
    Label5: TLabel;
    edtNF: TEditFocus;
    Label8: TLabel;
    edtVeioBoleto: TEditFocus;
    dbgDuplicatasCTP_SERIE_: TcxGridDBColumn;
    dbgDuplicatasCTP_DTACAD: TcxGridDBColumn;
    edtHistor: TMemoFocus;
    FlwPnlBotoesBaixa: TFlowPanel;
    Panel1: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    btnReprovar: TBitBtnLocked;
    Label7: TLabel;
    edtDeposito: TEditFocus;
    dbgDuplicatasViewSTATUS: TcxGridDBColumn;
    dbgDuplicatasViewCTP_VALDUP: TcxGridDBColumn;
    dbgDuplicatasViewCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasViewCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasViewCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasViewCTP_NOMEVE: TcxGridDBColumn;
    dbgDuplicatasViewCTP_NOMCTA: TcxGridDBColumn;
    btnManutencao: TBitBtnLocked;
    btnAnexos: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    ColorLabel2: TColorLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    edtUsaChq: TEditFocus;
    edtVeioNF: TEditFocus;
    edtVeiobo: TEditFocus;
    edtDeposi: TEditFocus;
    ColorLabel1: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAprovarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure btnReprovarClick(Sender: TObject);
    procedure btnManutencaoClick(Sender: TObject);
    procedure btnAnexosClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    frmBaixaCtpBusca : TfrmBaixaCtpBusca;
    strAceCtp: String;

    qryCadPag: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;

    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;

    strEmp: String;
    strFornec: String;
    strEvento: String;
    strPortador: String;
    strCentCusto: String;

    strValorFiltro : String;
    strCampoFiltro : String;

    arrEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    arrEvento: TConsultasArray;
    arrPortador: TConsultasArray;
    arrCentCusto: TConsultasArray;

    function fGetEmpAceCtp: String;
    procedure pCarregaFornecedor;
    procedure pCarregaEventos;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
    procedure pCarregaEmpresa;
    procedure pAtualizaTemporaria;
    procedure pLimpaEdits;
    procedure pLimpaEditsDuplicata;
    procedure pCalculaTotalDuplicatas(edtQuant, edtTotal: TEditFocus; blnFiltrar: Boolean);
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pMarcarTodas(blnMarcar: Boolean);
    procedure pConcluiBusca;
    procedure pLocalizaProximaDup;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
  protected
    procedure pAtualizaDados(DataSet: TDataSet);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untPesqAux, untFuncoesConsulta, untConsultas,
  untGravando, untTLiberacaoPrevisaoPagar, untCtpLiberacaoPrevisaoDados,
  untCadCtaPagar, untGravaArquivoPasta;

{ TfrmCtpLiberacaoPrevisao }

procedure TfrmCtpLiberacaoPrevisao.btnAnexosClick(Sender: TObject);
  Var
    frmGravaArquivoPasta : TfrmGravaArquivoPasta;
    strCaminhoPastaAntiga: String;
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);

    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' + cdsCtaPag.FieldByName('AUTOINCREM').AsString ;

    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTP\' +
                                                            fStrZero( cdsCtaPag.FieldByName('CTP_CODFOR').AsString, 8  ) + '-' +
                                                            fStrZero( cdsCtaPag.FieldByName('CTP_CODEMP').AsString, 3  ) + '-' +
                                                            fStrZero( cdsCtaPag.FieldByName('AUTOINCREM').AsString, 20 ) ;
    if DirectoryExists(strCaminhoPastaAntiga) then
    begin
      TDirectory.Move(strCaminhoPastaAntiga, frmGravaArquivoPasta.strCaminhoPasta);
      Sleep(500);
    end;

    If fRetArquivosDir(frmGravaArquivoPasta.strCaminhoPasta + '\*.*').Count = 0 Then
    Begin
      fMensagem('ATENÇÃO', 'Essa duplicata não possui anexos!', ['&Ok']);
      pFreeAndNil(frmGravaArquivoPasta);
      pSetFocus(dbgDuplicatas);
      Exit;
    End;

    frmGravaArquivoPasta.Caption  := 'Pasta ( Arquivos Anexos )';
    frmGravaArquivoPasta.blnConsulta := True;
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmCtpLiberacaoPrevisao.btnAprovarClick(Sender: TObject);
  var
    objLiberacao: TLiberacaoPrevisaoPagar;
    prcScroll   : TprcScroll;

    frmCtpLiberacaoPrevisaoDados: TfrmCtpLiberacaoPrevisaoDados;
begin
  inherited;

  If Not fVerificaAcessoSistema('LIBCTPPREV') Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para acessar a função!', ['&Ok']);
    Exit;
  End;

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fMensagem('Confirmação', 'Confirma a aprovação das duplicatas selecionadas?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pCriarFormularios(TfrmCtpLiberacaoPrevisaoDados, frmCtpLiberacaoPrevisaoDados);
  frmCtpLiberacaoPrevisaoDados.blnReprova := False;
  frmCtpLiberacaoPrevisaoDados.ShowModal;

  If frmCtpLiberacaoPrevisaoDados.ModalResult <> mrOK Then
  Begin
    FreeAndNil(frmCtpLiberacaoPrevisaoDados);
    Exit;
  End;

  objLiberacao := TLiberacaoPrevisaoPagar.Create(Self.Name);
  objLiberacao.strCodigoPortador      := frmCtpLiberacaoPrevisaoDados.edtCodPor.Text;
  objLiberacao.strCodigoCentroDeCusto := frmCtpLiberacaoPrevisaoDados.fraCentroCusto.edtCodEve.Text;
  objLiberacao.strCodigoPlanoDeContas := fRetSomenteNumeros(frmCtpLiberacaoPrevisaoDados.fraPlanoDeContasCtp.MskCodCta.Text);
  objLiberacao.strHistorico           := frmCtpLiberacaoPrevisaoDados.edtHistorico.Text;

  FreeAndNil(frmCtpLiberacaoPrevisaoDados);

  pDisableControls(cdsCtaPag, prcScroll);
  Try
    fStartTransaction;
    strValorFiltro := '';
    strCampoFiltro := '';

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter := 'CTP_MARDES = ''M''';
    cdsCtaPag.Filtered := True;

    cdsCtaPag.First;
    While Not cdsCtaPag.Eof Do
    Begin
      objLiberacao.pAddPagar(cdsCtaPag.FieldByName('AUTOINCREM').AsString);

      cdsCtaPag.Next;
    End;

    Try
      TfrmGravando.fExecutarModal(objLiberacao.pAprovar, 'Aguarde... Aprovando os Títulos.', '');

      fCommit;

      fMensagem('AVISO', 'Aprovação realizada com sucesso!', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro('Ocorreu um erro ao aprovar as duplicatas.' + #13 +
                       'Erro gerado: ' + E.Message,
                       '[TfrmCtpLiberacaoPrevisao.btnAprovarClick]');
      End;
    End;

  Finally
    FreeAndNil(objLiberacao);

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter   := '';
    pEnableControls(cdsCtaPag, prcScroll);

    If chkLimFil.Checked Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnConsultar.Click;
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.btnConsultarClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');

  If pnlCabecalho.Visible Then
    pSetFocus(dbgDuplicatas);
end;

procedure TfrmCtpLiberacaoPrevisao.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  If (Not btnDesmarcarTodas.Visible) Or (Not btnDesmarcarTodas.Enabled) Then
    Exit;

  pMarcarTodas(False);
end;

procedure TfrmCtpLiberacaoPrevisao.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If Not btnIniBus.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaCtpBusca, frmBaixaCtpBusca);
    if frmBaixaCtpBusca.ShowModal = mrOk then
      pConcluiBusca;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmCtpLiberacaoPrevisao.btnIniBusClick]');
  End;

  pFreeAndNil(frmBaixaCtpBusca);
  pSetFocus(Self);
end;

procedure TfrmCtpLiberacaoPrevisao.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If Not btnLocProx.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  If (Not cdsCtaPag.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
    pLocalizaProximaDup
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmCtpLiberacaoPrevisao.btnManutencaoClick(Sender: TObject);
  Var
    frmCadCtaPagar: TfrmCadCtaPagar;
    strAutoIncrem : String;
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  If fVerificaAcessoSistema('frmCadCtaPagar') Then
  Begin

    Try
      strAutoIncrem := cdsCtaPag.FieldByName('AUTOINCREM').AsString;

      pCriarFormularios(TfrmCadCtaPagar, frmCadCtaPagar);

      frmCadCtaPagar.strAutoIncrem := cdsCtaPag.FieldByName('AUTOINCREM').AsString;
      frmCadCtaPagar.strOrigem     := 'frmBaixaCtaPagar';
      frmCadCtaPagar.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pChamarManutencaoCtp]');
    End;
    pFreeAndNil(frmCadCtaPagar);

    btnConsultar.Click;

    cdsCtaPag.Locate('AUTOINCREM', strAutoIncrem, []);

    pSetFocus(dbgDuplicatas);
  End
  Else
    pMensagemOk('Operador sem direito de acesso!');
end;

procedure TfrmCtpLiberacaoPrevisao.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário carregar títulos para utilizar essa função!', ['&Ok']);
    Exit;
  End;

  If (Not btnMarcarTodas.Visible) Or (Not btnMarcarTodas.Enabled) Then
    Exit;

  pMarcarTodas(True);
end;

procedure TfrmCtpLiberacaoPrevisao.btnReprovarClick(Sender: TObject);
  var
    objLiberacao: TLiberacaoPrevisaoPagar;
    prcScroll   : TprcScroll;

    frmCtpLiberacaoPrevisaoDados: TfrmCtpLiberacaoPrevisaoDados;
begin
  inherited;
  If Not fVerificaAcessoSistema('LIBCTPPREV') Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para acessar a função!', ['&Ok']);
    Exit;
  End;

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fMensagem('Confirmação', 'Confirma a reprova das duplicatas selecionadas?', ['&Sim', '&Não']) = 2 Then
    Exit;

  pCriarFormularios(TfrmCtpLiberacaoPrevisaoDados, frmCtpLiberacaoPrevisaoDados);
  frmCtpLiberacaoPrevisaoDados.blnReprova := True;
  frmCtpLiberacaoPrevisaoDados.ShowModal;

  if (frmCtpLiberacaoPrevisaoDados.ModalResult <> mrOK) Or
     (fEmptyStr(frmCtpLiberacaoPrevisaoDados.edtMotivo.Text)) then
  Begin
    FreeAndNil(frmCtpLiberacaoPrevisaoDados);
    Exit;
  End;

  objLiberacao := TLiberacaoPrevisaoPagar.Create(Self.Name);
  objLiberacao.strMotivoReprova       := frmCtpLiberacaoPrevisaoDados.edtMotivo.Text;
  objLiberacao.strCodigoPortador      := frmCtpLiberacaoPrevisaoDados.edtCodPor.Text;
  objLiberacao.strCodigoCentroDeCusto := frmCtpLiberacaoPrevisaoDados.fraCentroCusto.edtCodEve.Text;
  objLiberacao.strCodigoPlanoDeContas := fRetSomenteNumeros(frmCtpLiberacaoPrevisaoDados.fraPlanoDeContasCtp.MskCodCta.Text);
  objLiberacao.strHistorico           := frmCtpLiberacaoPrevisaoDados.edtHistorico.Text;

  FreeAndNil(frmCtpLiberacaoPrevisaoDados);

  pDisableControls(cdsCtaPag, prcScroll);
  Try
    fStartTransaction;
    strValorFiltro := '';
    strCampoFiltro := '';

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter := 'CTP_MARDES = ''M''';
    cdsCtaPag.Filtered := True;

    cdsCtaPag.First;
    While Not cdsCtaPag.Eof Do
    Begin
      objLiberacao.pAddPagar(cdsCtaPag.FieldByName('AUTOINCREM').AsString);

      cdsCtaPag.Next;
    End;

    Try
      TfrmGravando.fExecutarModal(objLiberacao.pReprovar, 'Aguarde... Reprovando os Títulos.', '');

      fCommit;

      fMensagem('AVISO', 'Reprova realizada com sucesso!', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro('Ocorreu um erro ao reprovar as duplicatas.' + #13 +
                       'Erro gerado: ' + E.Message,
                       '[TfrmCtpLiberacaoPrevisao.btnReprovarClick]');
      End;
    End;

  Finally
    FreeAndNil(objLiberacao);

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter   := '';
    pEnableControls(cdsCtaPag, prcScroll);

    If chkLimFil.Checked Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnConsultar.Click;
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCtpLiberacaoPrevisao.dbgDuplicatasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

   If Not cdsCtaPag.Active Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_MARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.dbgDuplicatasViewDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmCtpLiberacaoPrevisao.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaDuplicata;
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmCtpLiberacaoPrevisao.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCtpLiberacaoPrevisao.fGetEmpAceCtp: String;
begin
  Result:= fCampoTabela('OPE_EMPCTP', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  Result := Copy(Result, 0, (Length(Result) -1));

  If Not fEmptyStr(Result) Then
    Result := AnsiReplaceStr(Result,'_', ',');
end;

procedure TfrmCtpLiberacaoPrevisao.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Position := poScreenCenter;

  strAceCtp := fGetEmpAceCtp;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.Open;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.AfterScroll := pAtualizaDados;
  cdsCtaPag.OnFilterRecord := pFilterRecord;
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;
end;

procedure TfrmCtpLiberacaoPrevisao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If pnlCabecalho.Visible Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnSair.Click;
  End
  Else If (Key = VK_F10) Then
    btnAprovar.Click
  Else If (Key = VK_F11) Then
    btnReprovar.Click
  Else If (Shift = [ssCtrl]) And (Key = VK_F12) Then
    btnAnexos.Click
  Else If (Key = VK_F12) Then
    btnManutencao.Click
  Else If (Key = VK_F5) Then
    btnIniBus.Click
  Else If (Key = VK_F6) Then
    btnLocProx.Click
  Else If (Key = VK_F7) Then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) Then
    btnDesmarcarTodas.Click;
end;

procedure TfrmCtpLiberacaoPrevisao.FormShow(Sender: TObject);
begin
  inherited;
  btnMarcarTodas.Visible := fCfgSis('CTPTUD', varBoolean);

  edtCodEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),VS_strCodEmp, '' );
  edtNomEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),fRetNomeEmpresa, '' );

  WindowState := wsMaximized;

  pSetFocus(edtCodFor);
end;

procedure TfrmCtpLiberacaoPrevisao.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmCtpLiberacaoPrevisao.fraPlanoDeContasMskCodCtaExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta');

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmCtpLiberacaoPrevisao.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCtpLiberacaoPrevisao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}

    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        If edtCodFor.Text <> '00000000' Then
           pCarregaFornecedor;

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
        edtNomFor.Clear;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin

        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarregaEventos;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&OK']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Clear
      Else
      Begin

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&OK']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&OK']);
          Result := False;
        End
        Else If (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão no Baixa contas a pagar desta empresa!', ['&OK']);
          Result := False;
        End;

      End;

    End

    {***************************************}
    {* VALIDA A DATA DE CADASTRO INICIAL   *}
    {************************************MV*}
    Else If (Sender = mskDtaCadIni) Then
    Begin
      mskDtaCadFin.Clear;
      mskDtaCadFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text));
    End

    {***************************************}
    {* VALIDA A DATA DE CADASTRO FINAL     *}
    {************************************MV*}
    Else If (Sender = mskDtaCadFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaCadIni.Text, mskDtaCadFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO INICIAL   *}
    {**************************************MV*}
    Else If (Sender = mskDtaVenIni) Then
    Begin
      mskDtaVenFin.Clear;
      mskDtaVenFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text));
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO FINAL     *}
    {**************************************MV*}
    Else If (Sender = mskDtaVenFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaVenIni.Text, mskDtaVenFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
          Result := False;
        End;
      End;
    End

    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0' Then
           pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&OK']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End
    {**************************************}
    {* VALIDA O CÓDIGO DO PORTADOR        *}
    {***********************************JU*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        If edtCodPor.Text <> '00000' Then
           pCarregaPortador;

       if fEmptyStr(EdtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&OK']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If (High(arrEmp) > 0) Then
        Begin
          If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmp) Then
            Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não permissão para utilizar este portador!', ['&OK']);
              Result := False;
            End;
          End;

        End;

      End
      Else
        edtDesPor.Clear;

    End

    Else If (Sender = edtVeioBo) Or
            (Sender = edtDeposi) Or
            (Sender = edtVeioNF) Or
            (Sender = edtUsaChq) Then
    Begin
      If Not MatchStr(TEdit(Sender).Text, ['S', 'N', 'T']) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os campos Veio Boleto, Cheque, Veio NF e Depósito devem ser preenchidos com "S", "N" ou "T"!', ['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCtpLiberacaoPrevisao.pAtualizaDados(DataSet: TDataSet);
begin
  edtCheque.Text     := DataSet.FieldByName('CTP_USACHQ').AsString;
  edtVeioBoleto.Text := DataSet.FieldByName('CTP_VEIOBO').AsString;
  edtNF.Text         := DataSet.FieldByName('CTP_VEIONF').AsString;
  edtDeposito.Text   := DataSet.FieldByName('CTP_DEPOSI').AsString;

  edtCodigoResponsavel.Text    := DataSet.FieldByName('CTP_CODOPE').AsString;
  edtDescricaoResponsavel.Text := DataSet.FieldByName('OPE_NOMOPE').AsString;

  edtHistor.Texto    := DataSet.FieldByName('CTP_HIST01').AsString;
end;

procedure TfrmCtpLiberacaoPrevisao.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
begin
  If (fCfgSis('DACPOR', varBoolean)) And
     Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If Not fValidaCampos(edtCodPor) Then
    Begin
      blnMudarFoco := False;
      Exit;
    End;
  End;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  P.CTP_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  P.CTP_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ';
    strSQL := strSQL + '  P.CTP_CODFOR, ';
    strSQL := strSQL + '  F.FOR_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_FONE01, ';
    strSQL := strSQL + '  F.FOR_F_A_X_, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_C_G_C_, ';
    strSQL := strSQL + '  P.CTP_CODEMP, ';
    strSQL := strSQL + '  P.CTP_SERIE_, ';
    strSQL := strSQL + '  E.EMP_NOMEMP, ';
    strSQL := strSQL + '  P.CTP_CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA, ';
    strSQL := strSQL + '  P.CTP_HIST01, ';
    strSQL := strSQL + '  P.CTP_HIST02, ';
    strSQL := strSQL + '  P.CTP_PREVIS, ';
    strSQL := strSQL + '  IF(P.CTP_VEIOBO = "S", "SIM", "NÃO") AS CTP_VEIOBO, ';
    strSQL := strSQL + '  P.CTP_DTACAD, ';
    strSQL := strSQL + '  P.CTP_DTAVEN, ';
    strSQL := strSQL + '  P.CTP_VALORI, ';
    strSQL := strSQL + '  P.CTP_VALDUP, ';
    strSQL := strSQL + '  P.CTP_VALPAG, ';
    strSQL := strSQL + '  P.CTP_DTAPAG, ';
    strSQL := strSQL + '  P.CTP_VALJUR, ';
    strSQL := strSQL + '  P.CTP_VALDES, ';
    strSQL := strSQL + '  P.CTP_CODEVE, ';
    strSQL := strSQL + '  P.CTP_TIPDOC, ';
    strSQL := strSQL + '  P.CTP_CODVEL, ';
    strSQL := strSQL + '  P.CTP_CODPOR, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODEVE ,"-", V.EVE_DESEVE) AS CTP_NOMEVE, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODCTA ,"-", C.CTA_DESCTA) AS CTP_NOMCTA, ';
    strSQL := strSQL + '  P.CTP_PORBAI, ';
    strSQL := strSQL + '  B.POR_NOMPOR, ';
    strSQL := strSQL + '  IF(P.CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ';
    strSQL := strSQL + '  IF(P.CTP_VEIONF = "S", "SIM", "NÃO") AS CTP_VEIONF, ';
    strSQL := strSQL + '  IF(P.CTP_DEPOSI = "S", "SIM", "NÃO") AS CTP_DEPOSI, ';
    strSQL := strSQL + '  V.EVE_DESEVE, ';
    strSQL := strSQL + '  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_MULSUJ, 0) AS CTP_MULSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_VENDOR, 0) AS CTP_VENDOR, ';
    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) +  + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ';
    strSQL := strSQL + '  " " AS CTP_MARDES, ';
    strSQL := strSQL + '  " " AS CTP_TIPBAI, ';
    strSQL := strSQL + '  " " AS CTP_TIPDES, ';
    strSQL := strSQL + '  P.AUTOINCREM, ';
    strSQL := strSQL + '  "CADPAG" AS TABELA, ';
    strSQL := strSQL + '  P.CTP_COMPET, ';
    strSQL := strSQL + '  P.CTP_DINHEI, ';
    strSQL := strSQL + '  P.CTP_CHQAVI, ';
    strSQL := strSQL + '  P.CTP_ORDPAG, ';
    strSQL := strSQL + '  P.CTP_REPCHQ, ';
    strSQL := strSQL + '  P.CTP_CODOPE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE, ';
    strSQL := strSQL + '  P.CTP_SEQBAI, ';
    strSQL := strSQL + '  IF(P.CTP_OPEREP IS NULL AND P.CTP_OPEAPR IS NULL, "AGUARDANDO APROVAÇÃO", ';
    strSQL := strSQL + '     IF(P.CTP_OPEREP IS NOT NULL, "REPROVADO", "APROVADO ANTERIORMENTE")) AS STATUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
    strSQL := strSQL + '  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ';
    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  JOIN CADOPE O ON P.CTP_CODOPE = O.OPE_CODOPE ';
    strSQL := strSQL + ' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ';
    strSQL := strSQL + ' LEFT JOIN CADPOR B ON P.CTP_PORBAI = B.POR_CODPOR ';
    strSQL := strSQL + ' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) <> 0 ';
    strSQL := strSQL + '  AND P.CTP_PREVIS = "S" ';
    strSQL := strSQL + '  AND P.CTP_DTAPAG IS NULL ';
    strSQL := strSQL + '  AND P.CTP_SEQBAI = 0  ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTCINI AND :DTCFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTVINI AND :DTVFIN ';

    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      strSQL := strSQL + '  AND P.CTP_CODEVE = V.EVE_CODEVE ';

    If edtVeioBo.Text = 'S' Then
      strSQL := strSQL + '  AND P.CTP_VEIOBO = "S" '
    Else If edtVeioBo.Text = 'N' Then
      strSQL := strSQL + '  AND (P.CTP_VEIOBO = "N" OR P.CTP_VEIOBO IS NULL OR P.CTP_VEIOBO = "") ';

    If edtVeioNF.Text = 'S' Then
      strSQL := strSQL + '  AND P.CTP_VEIONF = "S" '
    Else If edtVeioNF.Text = 'N' Then
      strSQL := strSQL + '  AND (P.CTP_VEIONF = "N" OR P.CTP_VEIONF IS NULL OR P.CTP_VEIONF = "") ';

    If edtDeposi.Text = 'S' Then
      strSQL := strSQL + '  AND P.CTP_DEPOSI = "S" '
    Else If edtDeposi.Text = 'N' Then
      strSQL := strSQL + '  AND (P.CTP_DEPOSI = "N" OR P.CTP_DEPOSI IS NULL OR P.CTP_DEPOSI = "") ';

    If edtCheque.Text = 'S' Then
      strSQL := strSQL + '  AND P.CTP_USACHQ = "S" '
    Else If edtCheque.Text = 'N' Then
      strSQL := strSQL + '  AND (P.CTP_USACHQ = "N" OR P.CTP_USACHQ IS NULL OR P.CTP_USACHQ = "") ';
    
    strSQL := strSQL +  fSQLIn(edtCodFor, arrFornec, 'P.CTP_CODFOR', 'CODFOR');

    strSQL := strSQL + fSQLIn(fraCentroCusto.edtCodEve, arrEvento, 'P.CTP_CODEVE', 'CODEVE');

    strSQL := strSQL + fSQLIn(edtCodEmp, arrEmp, 'P.CTP_CODEMP', 'CODEMP');

    If (Not fEmptyStr(strAceCtp)) Then
      strSQL := strSQL + '  AND P.CTP_CODEMP IN (' + fRetStrToSQLIn(strAceCtp, ',') + ') ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + fSQLIn(edtCodPor, arrPortador, 'P.CTP_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND ((P.CTP_CODPOR IS NULL OR P.CTP_CODPOR = "") ';
      strSQL := strSQL + '  OR P.CTP_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
    End;

    If (cmbStatus.ItemIndex = 0) Then
      strSQL := strSQL + '  AND P.CTP_OPEREP IS NULL '
    Else If (cmbStatus.ItemIndex  = 1) Then
      strSQL := strSQL + '  AND P.CTP_OPEREP IS NOT NULL ';

    strSQL := strSQL + fSQLIn(fraPlanoDeContas.MskCodCta, arrCentCusto, 'P.CTP_CODCTA', 'CODCTA');

    qryCtaPag.Close;
    qryCtaPag.SQL.Text := strSQL;

    pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryCtaPag);
    pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryCtaPag);
    pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCtaPag);
    pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR' , qryCtaPag);

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
    Begin
      qryCtaPag.ParamByName('DTCINI').AsDateTime := mskDtaCadIni.Date;
      qryCtaPag.ParamByName('DTCFIN').AsDateTime := mskDtaCadFin.Date;
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
    Begin
      qryCtaPag.ParamByName('DTVINI').AsDateTime := mskDtaVenIni.Date;
      qryCtaPag.ParamByName('DTVFIN').AsDateTime := mskDtaVenFin.Date;
    End;

    pSetaParam(fraPlanoDeContas.MskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA', qryCtaPag);

    qryCtaPag.Open;

    Application.ProcessMessages;

    If Not qryCtaPag.IsEmpty Then
    Begin
      pSetaClient(qryCtaPag);
      cdsCtaPag.Open;

      (cdsCtaPag.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
      cdsCtaPag.IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
      cdsCtaPag.First;
      Application.ProcessMessages;
      pCalculaTotalDuplicatas(edtQtdDuplicatas, edtValorTotal, False);

      Application.ProcessMessages;
      pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem liberadas!', ['&O k']);
      If (chkLimFil.Checked) Then
        pLimpaEdits;
      pLimpaEditsDuplicata;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End;

    qryCtaPag.Close;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCtpLiberacaoPrevisao.pAtualizaTemporaria]');
    End;
  End;

  Application.ProcessMessages;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmCtpLiberacaoPrevisao.pCalculaTotalDuplicatas(edtQuant,
  edtTotal: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldVal: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldVal := TAggregateField.Create(Self);
  Try
    With fldVal Do
    Begin
      FieldName := 'FLDVAL';
      DataSet := cdsGen;
      DisplayFormat := '#,##0.00';
      Expression := 'SUM(TOTDUP)';
      Active := True;
    End;

    With cdsGen Do
    Begin
      Data := cdsCtaPag.Data;

      If blnFiltrar Then
      Begin
        Filtered := False;
        Filter := 'CTP_MARDES = ''M''';
        Filtered := True;
      End;

      AggregatesActive := True;

      If Not IsEmpty Then
      Begin
        edtTotal.Text    := FormatFloat('#,##0.00', fldVal.Value);
        edtQuant.Text    := IntToStr(RecordCount);
      End
      Else
      Begin
        edtTotal.Text    := '0,00';
        edtQuant.Text    := '0';
      End;
    End;
  Finally
    FreeAndNil(fldVal);
    FreeAndNil(cdsGen);
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);

  fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmCtpLiberacaoPrevisao.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmCtpLiberacaoPrevisao.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCtpLiberacaoPrevisao.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);

  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

procedure TfrmCtpLiberacaoPrevisao.pCarregaPortador;
begin
  pPesquisaCadPor(qryConPor, qryConPor, edtCodPor.Text);

  edtDesPor.Text := qryConPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmCtpLiberacaoPrevisao.pConcluiBusca;
begin
  If fEmptyStr(frmBaixaCtpBusca.objFiltro.strValor) Then
    exit;

  cdsCtaPag.Filter := '';
  strValorFiltro := frmBaixaCtpBusca.objFiltro.strValor;
  strCampoFiltro := frmBaixaCtpBusca.objFiltro.strCampo;
  If Not cdsCtaPag.FindFirst Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas que atendam a busca!', ['&O k']);
end;

procedure TfrmCtpLiberacaoPrevisao.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  begin
    if CompareText(strCampoFiltro, 'TOTDUP') = 0 then
      Accept := CompareText(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) = 0
    else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  end;
end;

procedure TfrmCtpLiberacaoPrevisao.pLimpaEdits;
begin
  pLimpaEditsDuplicata;

  edtNomFor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtNomEmp.Clear;
  edtDesPor.Clear;

  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  mskDtaVenIni.Clear;
  mskDtaVenFin.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  edtCodFor.Clear;
  fraCentroCusto.edtCodEve.Clear;
  edtCodEmp.Clear;
  edtCodPor.Clear;
  edtVeioBo.Text := 'T';
  edtVeioNF.Text := 'T';
  edtDeposi.Text := 'T';
  edtCheque.Text := 'T';
  cmbStatus.ItemIndex := 2;

  cdsCtaPag.AfterScroll := nil;
  Try
    cdsCtaPag.Filtered := False;
    cdsCtaPag.Close;
  Finally
    cdsCtaPag.AfterScroll := pAtualizaDados;
  End;
end;

procedure TfrmCtpLiberacaoPrevisao.pLimpaEditsDuplicata;
begin
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;
  edtTotalPago.Clear;
  edtValorTotal.Clear;

  edtCodigoResponsavel.Clear;
  edtDescricaoResponsavel.Clear;

  edtCheque.Clear;
  edtVeioBoleto.Clear;
  edtNF.Clear;
  edtDeposito.Clear;
end;

procedure TfrmCtpLiberacaoPrevisao.pLocalizaProximaDup;
begin
  If Not cdsCtaPag.FindNext Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas que atendam a busca!', ['&O k']);
end;

procedure TfrmCtpLiberacaoPrevisao.pMarcaDuplicata(blnMarcar: Boolean);
begin
  cdsCtaPag.Edit;
  cdsCtaPag.FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsCtaPag.Post;
end;

procedure TfrmCtpLiberacaoPrevisao.pMarcarTodas(blnMarcar: Boolean);
  Var
    prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsCtaPag, prcScroll);

    cdsCtaPag.First;
    While Not cdsCtaPag.Eof Do
    Begin
      if blnMarcar And Not fEmpresaTemAcessoPortador(cdsCtaPag.FieldByName('CTP_CODPOR').AsString,
                                                     VS_strCodEmp) Then
      Begin
       fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
       cdsCtaPag.Edit;
       cdsCtaPag.FieldByName('CTP_MARDES').AsString := 'D';
       cdsCtaPag.Post;
      End Else
      pMarcaDuplicata(blnMarcar);

      cdsCtaPag.Next;
    End;
    cdsCtaPag.First;
  Finally
    pEnableControls(cdsCtaPag, prcScroll);
  End;

  pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
end;

procedure TfrmCtpLiberacaoPrevisao.pSelecionaDuplicata;
begin
  If cdsCtaPag.IsEmpty Then
    Exit;

  if Not fEmpresaTemAcessoPortador(cdsCtaPag.FieldByName('CTP_CODPOR').AsString,VS_strCodEmp) Then
  Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
  End;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
  Begin
    pMarcaDuplicata(True);
    pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
  End
  Else
  Begin
    pMarcaDuplicata(False);
    pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
  End;

  {******************************************}
  {* POSICIONA O CURSOR NO PRÓXIMO REGISTRO *}
  {***************************************ER*}
  dbgDuplicatasView.NavigatorButtons.Next.Click;
end;

end.
