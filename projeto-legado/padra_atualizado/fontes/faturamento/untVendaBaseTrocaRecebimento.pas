unit untVendaBaseTrocaRecebimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus, Uni, untTypesSistema, Faturamento.Classes.VendaBaseTrocaRecebimento,
  Datasnap.DBClient, UniClientDataSet, cxButtonEdit, cxContainer, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus;

type

  TfrmVendaBaseTrocaRecebimento = class(TfrmPaiConfirma)
    pnlFiltros: TPanel;
    cxGridPendenciasDBTableView: TcxGridDBTableViewCitel;
    cxGridPendenciasLevel1: TcxGridLevel;
    cxGridPendencias: TcxGridCitel;
    pnlRodape: TPanel;
    lblCodCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblPeriodo: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnPesquisar: TBitBtnLocked;
    cdsPendencias: TUniClientDataSet;
    dtsPendencias: TDataSource;
    cdsPendenciasMARCADO: TStringField;
    cdsPendenciasAUTOINCREM: TStringField;
    cdsPendenciasPEN_DTAENT: TDateField;
    cdsPendenciasPEN_HORENT: TDateTimeField;
    cdsPendenciasPEN_NUMDOC: TStringField;
    cdsPendenciasPEN_ESPDOC: TStringField;
    cdsPendenciasPEN_CODEMP: TStringField;
    cdsPendenciasPEN_CODITE: TStringField;
    cdsPendenciasPEN_STATUS: TStringField;
    cdsPendenciasDOCUMENTO: TStringField;
    cxGridPendenciasDBTableViewDOCUMENTO: TcxGridDBColumn;
    cxGridPendenciasDBTableViewPEN_DTAENT: TcxGridDBColumn;
    cxGridPendenciasDBTableViewPRODUTO: TcxGridDBColumn;
    cdsPendenciasPRODUTO: TStringField;
    cxGridPendenciasDBTableViewPEN_TOTITE: TcxGridDBColumn;
    cxGridPendenciasDBTableViewPEN_TOTREC: TcxGridDBColumn;
    cdsPendenciasPEN_TOTREC: TFloatField;
    lblVlrTotal: TLabel;
    edtTotRec: TCurrencyEditFocus;
    cdsPendenciasPEN_TOTITE: TFloatField;
    cxGridPendenciasDBTableViewMARCADO: TcxGridDBColumn;
    cxGridPendenciasDBTableViewBTNINFPROD: TcxGridDBColumn;
    btnEntradaSemVinculo: TBitBtnLocked;
    btnBaixarSemRecebimento: TBitBtnLocked;
    shpSepImp: TShape;
    lblSepImpJaImp: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridPendenciasDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnEntradaSemVinculoClick(Sender: TObject);
    procedure cxGridPendenciasDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridPendenciasDBTableViewBTNINFPRODPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure btnBaixarSemRecebimentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConCli: TUniQuery;
    arrCodEmp: TConsultasArray;

    procedure pCarregarDados;
    procedure pFormatarCampos;
    procedure pCarregarCliente;
    procedure pInserirDadosGrid;
    procedure pAtualizarDadosGrid(const strAutInc: String; objItemRecebimento: TItemRecebimento);
    procedure pMarcarDesmarcar(const blnMarcar: Boolean);
    function  fInformarProduto(const strAutInc: String;  const blnAvulso: Boolean = False): Boolean;
    procedure pAtualizarTotais;
    procedure pRealizarFechamento;
    procedure pRealizarEntradaSemVinculo;
    procedure pRealizarBaixaSemRecebimento;
    procedure pImprimirDocumento;
    procedure pLimparItens;
    procedure pCarregaDadosPendentes(strAutInc: String);
    procedure pIncluiItensRecebimentoAutomatico;
    procedure pCarregarEmpresa;
    procedure pIniciarTelaFinanceiroPendente;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnEhFinaceiroPendente: Boolean;

    objVendaTrocaRec: TVendaBaseTrocaRecebimento;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untPesqAux, untVendaBaseTrocaInfProdutos, untImpressaoPedidoTrocaRecebimento;

{$R *.dfm}

procedure TfrmVendaBaseTrocaRecebimento.btnBaixarSemRecebimentoClick(
  Sender: TObject);
begin
  inherited;

  pRealizarBaixaSemRecebimento;
  pCarregarDados;
end;

procedure TfrmVendaBaseTrocaRecebimento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  pRealizarFechamento;

end;

procedure TfrmVendaBaseTrocaRecebimento.btnEntradaSemVinculoClick(
  Sender: TObject);
begin
  inherited;

  pRealizarEntradaSemVinculo;
  pCarregarDados;
end;

procedure TfrmVendaBaseTrocaRecebimento.btnPesquisarClick(Sender: TObject);
begin
  inherited;

  If (Not blnEhFinaceiroPendente) Then
    If (Not fVerificaCampos) Then
      Exit;

  fExecutarModal(pCarregarDados, 'Aguarde, pesquisando pendências ...', '');

end;

procedure TfrmVendaBaseTrocaRecebimento.cxGridPendenciasDBTableViewBTNINFPRODPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  fInformarProduto(cdsPendencias.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmVendaBaseTrocaRecebimento.cxGridPendenciasDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strSel: String;
begin
  inherited;

  If (cdsPendencias.IsEmpty) Then
    Exit;

  strSel := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                                  cxGridPendenciasDBTableViewMARCADO.Index]);

  If (strSel = 'M') Then
  Begin
    If AViewInfo.Selected And Assigned(ActiveControl) And fCheckParent(ActiveControl, cxGridPendencias) Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmVendaBaseTrocaRecebimento.cxGridPendenciasDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_RETURN : pMarcarDesmarcar(cdsPendencias.FieldByName('MARCADO').AsString = 'D');
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCodCli: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCodCli) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  SetLength(arrCodEmp, 0);
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrCodEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not blnEhFinaceiroPendente Then
    Exit;

  If fMensagem('AVISO', 'Venda a Base de Troca - Não foi informado produto para recebimento, deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
    Action := caNone;
end;

procedure TfrmVendaBaseTrocaRecebimento.FormCreate(Sender: TObject);
begin
  inherited;

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  objVendaTrocaRec := TVendaBaseTrocaRecebimento.Create;

  pnlInfo.Caption := '[ENTER - Marcar/Desmarcar]';

  cdsPendencias.CreateDataSet;

  btnEntradaSemVinculo.Visible := fVerificaAcessoSistema('VBTAVU');
  btnBaixarSemRecebimento.Visible := fVerificaAcessoSistema('VBTBAI');

  blnEhFinaceiroPendente := False;

  pFormatarCampos;
end;

procedure TfrmVendaBaseTrocaRecebimento.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objVendaTrocaRec);
end;

procedure TfrmVendaBaseTrocaRecebimento.FormShow(Sender: TObject);
begin
  inherited;

  pIniciarTelaFinanceiroPendente;
end;

function TfrmVendaBaseTrocaRecebimento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregarCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        If qryConCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If Not fEmptyDate(mskDtaIni.Text) Then
      Begin
        If ((Not fEmptyDate(mskDtaIni.Text)) And (StrToDateDef(mskDtaIni.Text, 0) <= 0 )) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
          Result := False;
        End;

        If Result And
           (Not fEmptyDate(mskDtaIni.Text)) And
           (Not fEmptyDate(mskDtaFin.Text)) And
           (StrToDateDef(mskDtaIni.Text, 0) > 0) And
           (StrToDateDef(mskDtaIni.Text, 0) > StrToDateDef(mskDtaFin.Text, 0))  Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyDate(mskDtaFin.Text) Then
      Begin
        If ((Not fEmptyDate(mskDtaFin.Text)) And (StrToDateDef(mskDtaFin.Text, 0) <= 0 )) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe uma data válida!', ['&Ok']);
          Result := False;
        End;

        If Result And
           (Not fEmptyDate(mskDtaIni.Text)) And
           (Not fEmptyDate(mskDtaFin.Text)) And
           (StrToDateDef(mskDtaFin.Text, 0) > 0) And
           (StrToDateDef(mskDtaIni.Text, 0) > StrToDateDef(mskDtaFin.Text, 0))  Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Inicial não pode ser maior que a data final!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        pCarregarEmpresa;
        If (Not SameText(edtCodEmp.Text, '000')) and (Not fEmptyStr(edtCodEmp.Text)) Then
        Begin
          If fEmptyStr(edtNomEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmVendaBaseTrocaRecebimento.pIniciarTelaFinanceiroPendente;
begin
  If Not blnEhFinaceiroPendente Then
    Exit;

  edtCodCli.Enabled := False;
  mskDtaIni.Enabled := False;
  mskDtaFin.Enabled := False;
  btnEntradaSemVinculo.Visible := False;
  btnBaixarSemRecebimento.Visible := False;
  edtCodEmp.Enabled := False;

  If objVendaTrocaRec.fPossuiUnicoDocumentoPendente Then
  Begin
    edtCodCli.Text := objVendaTrocaRec.DocumentosPendentes[0].strCodCli;
    edtNomCli.Text := fRetNomCliente(objVendaTrocaRec.DocumentosPendentes[0].strCodCli);

    pCarregarEmpresa;
  End;

  btnPesquisar.Click;
end;

procedure TfrmVendaBaseTrocaRecebimento.pAtualizarDadosGrid(const strAutInc: String;
  objItemRecebimento: TItemRecebimento);
begin
  If fEmptyStr(strAutInc) Then
    Exit;

  If cdsPendencias.Locate('AUTOINCREM', strAutInc, [] ) Then
  Begin
    cdsPendencias.Edit;
    cdsPendencias.FieldByName('PEN_TOTREC').AsFloat := objItemRecebimento.fltTotRec;
    cdsPendencias.Post;
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pAtualizarTotais;
begin
  objVendaTrocaRec.pCalcularTotais;
  edtTotRec.Text := FormatFloat('#,##0.00', objVendaTrocaRec.fltTotRec);
end;

procedure TfrmVendaBaseTrocaRecebimento.pCarregaDadosPendentes(
  strAutInc: String);
var
  qryPendentes: TUniQuery;
  itemRecebido: TItemRecebido;
  objItemRecebimento: TItemRecebimento;
begin
  qryPendentes := fCriaQuery;

  try
    qryPendentes.Close;
    qryPendentes.SQL.Clear;
    qryPendentes.SQL.Add('SELECT * FROM ITEREC');
    qryPendentes.SQL.Add('WHERE IRC_SEQGER = :SEQGER');
    qryPendentes.SQL.Add('AND IRC_DOCREC IS NULL');
    qryPendentes.ParamByName('SEQGER').AsString := strAutInc;
    qryPendentes.Open;

    if qryPendentes.IsEmpty then
      Exit;

    objItemRecebimento := objVendaTrocaRec.fRetornaItemRecebimento(strAutInc);
    objItemRecebimento.blnEmitirDoc := True;

    while not qryPendentes.Eof do
    begin
      itemRecebido := objItemRecebimento.fAddProdutoRecebido;

      If Assigned(itemRecebido) Then
      Begin
        itemRecebido.strCodIte := qryPendentes.FieldByName('IRC_ITEPEN').AsString;
        itemRecebido.strDesIte := fRetNomProduto(qryPendentes.FieldByName('IRC_ITEPEN').AsString);
        itemRecebido.TipRec := TItemRecebido.fstrToTipRec(qryPendentes.FieldByName('IRC_TIPPEN').AsString);
        itemRecebido.fltVlrUni := qryPendentes.FieldByName('IRC_UNIPEN').AsFloat;
        itemRecebido.fltQtdIte := qryPendentes.FieldByName('IRC_QTDPEN').AsFloat;
        itemRecebido.strAutInc := qryPendentes.FieldByName('AUTOINCREM').AsString;
        itemRecebido.blnEhAlteracao := True;

        pAtualizarTotais;
      End;

      qryPendentes.Next;
    end;

  finally
    FreeAndNil(qryPendentes);
  end;
end;

procedure TfrmVendaBaseTrocaRecebimento.pCarregarCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldByName('CLI_NOMCLI').AsString;

  objVendaTrocaRec.strCodCli := edtCodCli.Text;
  objVendaTrocaRec.strNomCli := qryConCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmVendaBaseTrocaRecebimento.pCarregarDados;
begin
  If cdsPendencias.Active Then
    cdsPendencias.EmptyDataSet;

  If blnEhFinaceiroPendente Then
  Begin
    If objVendaTrocaRec.fCarregarFinanceiroPendente Then
    Begin
      pInserirDadosGrid();
      pIncluiItensRecebimentoAutomatico;
    End;
  End
  Else
  Begin
    If objVendaTrocaRec.fCarregarPendencias(edtCodCli.Text,
                                            mskDtaIni.Text,
                                            mskDtaFin.Text,
                                            IIF(length(arrCodEmp) > 0, '', edtCodEmp.Text),
                                            arrCodEmp) Then
    Begin
      pInserirDadosGrid();
    End;
  End;
  pAtualizarTotais;
end;

procedure TfrmVendaBaseTrocaRecebimento.pCarregarEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    If length(arrCodEmp) > 1 Then
    Begin
      edtNomEmp.Text := '+1';
    End
    Else
    Begin
      edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    End;
  End
  Else
  Begin
    edtNomEmp.Text := 'TODOS';
    SetLength(arrCodEmp, 0);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pFormatarCampos;
begin
  TFloatField(cdsPendencias.FieldByName('PEN_TOTITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPendencias.FieldByName('PEN_TOTREC')).DisplayFormat := '#,##0.00';
end;

function TfrmVendaBaseTrocaRecebimento.fInformarProduto(
  const strAutInc: String; const blnAvulso: Boolean = False): Boolean;
var
  frmVendaBaseTrocaInfProduto: TfrmVendaBaseTrocaInfProduto;
  objItemRecebimento: TItemRecebimento;
begin
  objItemRecebimento := Nil;
  Result := False;

  Try

    If (Not fEmptyStr(fCampoTabela('ITE_PROREC','CADITE',['ITE_CODITE'],[cdsPendenciasPEN_CODITE.AsString],False))) And
       (cdsPendenciasPEN_TOTREC.AsFloat > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto '+cdsPendenciasPEN_CODITE.AsString+' tem produto de recebimento vinculado no cadastro. Não será possível vincular mais produtos!', ['&Ok']);
      Exit;
    End;

    If blnAvulso Then
    Begin
      objItemRecebimento := objVendaTrocaRec.fAddItem;
      objItemRecebimento.blnAvulso := True;
      objItemRecebimento.blnEmitirDoc := True;
    End
    Else
    Begin
      If Assigned(objVendaTrocaRec) Then
        objItemRecebimento := objVendaTrocaRec.fRetornaItemRecebimento(strAutInc);
    End;

    pCriarFormularios(TfrmVendaBaseTrocaInfProduto, frmVendaBaseTrocaInfProduto);
    Try
      frmVendaBaseTrocaInfProduto.objItemRecebimento := objItemRecebimento;
      frmVendaBaseTrocaInfProduto.ShowModal;
      If frmVendaBaseTrocaInfProduto.ModalResult = mrOk Then
      Begin
        If Assigned(objItemRecebimento) Then
        Begin
          objItemRecebimento.pCalcularTotais;
          pAtualizarDadosGrid(strAutInc, objItemRecebimento);
          pMarcarDesmarcar(True);

          Result := True;
        End;
      End;
    Finally
      pFreeAndNil(frmVendaBaseTrocaInfProduto);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pImprimirDocumento;
begin
  If (fMensagem('Confirmação', 'Deseja imprimir o documento?', ['&Sim', '&Não']) = 2) Then
    Exit;

  If Not objVendaTrocaRec.fImprimirDocumentoRB Then
  Begin
    If Not fEmptyStr(objVendaTrocaRec.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objVendaTrocaRec.strMensagemRetorno, ['&O k']);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pInserirDadosGrid;
var
  intCnt: Integer;
  intBkp: Integer;
begin
  If cdsPendencias.Active Then
    cdsPendencias.EmptyDataSet;

  For intCnt:= 0 To objVendaTrocaRec.Itens.Count-1 Do
  Begin
    cdsPendencias.Insert;
    cdsPendencias.FieldByName('MARCADO').AsString := 'D';
    cdsPendencias.FieldByName('PRODUTO').AsString := objVendaTrocaRec.Itens[intCnt].strCodIte + ' - ' +
                                                     objVendaTrocaRec.Itens[intCnt].strDesIte;
    cdsPendencias.FieldByName('AUTOINCREM').AsString := objVendaTrocaRec.Itens[intCnt].strAutInc;
    cdsPendencias.FieldByName('PEN_CODEMP').AsString := objVendaTrocaRec.Itens[intCnt].strCodEmp;
    cdsPendencias.FieldByName('PEN_CODITE').AsString := objVendaTrocaRec.Itens[intCnt].strCodIte;
    cdsPendencias.FieldByName('PEN_ESPDOC').AsString := objVendaTrocaRec.Itens[intCnt].strEspDoc;
    cdsPendencias.FieldByName('PEN_NUMDOC').AsString := objVendaTrocaRec.Itens[intCnt].strNumDoc;
    cdsPendencias.FieldByName('PEN_TOTITE').AsFloat  := objVendaTrocaRec.Itens[intCnt].fltTotIte;
    cdsPendencias.FieldByName('PEN_DTAENT').AsDateTime := objVendaTrocaRec.Itens[intCnt].DtaEnt;
    cdsPendencias.FieldByName('PEN_HORENT').AsDateTime := objVendaTrocaRec.Itens[intCnt].HorEnt;
    cdsPendencias.FieldByName('DOCUMENTO').AsString := objVendaTrocaRec.Itens[intCnt].strNumDoc + '-' +
                                                       objVendaTrocaRec.Itens[intCnt].strEspDoc + '-' +
                                                       objVendaTrocaRec.Itens[intCnt].strCodEmp ;
    cdsPendencias.FieldByName('PEN_TOTREC').AsFloat := fCampoTabela('SUM(IRC_TOTPEN)','ITEREC',['IRC_SEQGER'],[objVendaTrocaRec.Itens[intCnt].strAutInc],False);

    if cdsPendencias.FieldByName('PEN_TOTREC').AsFloat > 0 then
      cdsPendencias.FieldByName('MARCADO').AsString := 'M';

    pCarregaDadosPendentes(objVendaTrocaRec.Itens[intCnt].strAutInc);

    for intBkp := 0 to objVendaTrocaRec.Itens[intCnt].Produtos.Count - 1 do
      objVendaTrocaRec.Itens[intCnt].ProdutosBkp.Add(objVendaTrocaRec.Itens[intCnt].Produtos[intBkp]);

    cdsPendencias.Post;
  End;

end;

procedure TfrmVendaBaseTrocaRecebimento.pLimparItens;
begin
  cdsPendencias.EmptyDataSet;
  objVendaTrocaRec.pLimparItens;
end;

procedure TfrmVendaBaseTrocaRecebimento.pMarcarDesmarcar(
  const blnMarcar: Boolean);
var
  item: TItemRecebimento;
begin
  item := objVendaTrocaRec.fRetornaItemRecebimento(cdsPendencias.FieldByName('AUTOINCREM').AsString);
  item.blnEmitirDoc := blnMarcar;

  cdsPendencias.Edit;
  cdsPendencias.FieldByName('MARCADO').AsString := IIF(blnMarcar, 'M', 'D');
  cdsPendencias.Post;

  pAtualizarTotais;
end;

procedure TfrmVendaBaseTrocaRecebimento.pRealizarBaixaSemRecebimento;
begin
  If objVendaTrocaRec.fRealizarBaixaSemRecebimento() Then
  Begin
    fMensagem('ATENÇÃO!', 'Processo concluído com sucesso.', ['&O k']);
  End
  Else
  Begin
    If Not fEmptyStr(objVendaTrocaRec.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objVendaTrocaRec.strMensagemRetorno, ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'Processo não foi finalizado.', ['&O k']);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pRealizarEntradaSemVinculo;
begin
  pLimparItens;

  If Not objVendaTrocaRec.fVerificaPodeRealizarBaixaSemVinculo Then
  Begin
    If Not fEmptyStr(objVendaTrocaRec.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objVendaTrocaRec.strMensagemRetorno, ['&O k']);

    Exit;
  End;

  If Not objVendaTrocaRec.fVerificaItemAvulsoSelecionado Then
  Begin
    If Not fInformarProduto('', True) Then
      Exit;
  End;

  If objVendaTrocaRec.fRealizarEntradaSemVinculo Then
  Begin
    fMensagem('ATENÇÃO!', 'Documento gerado: ' + objVendaTrocaRec.strDocRec + '-' +
                                                 objVendaTrocaRec.strEspRec + '-' +
                                                 objVendaTrocaRec.strEmpRec, ['&O k']);

    pImprimirDocumento;
  End
  Else
  Begin
    If Not fEmptyStr(objVendaTrocaRec.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objVendaTrocaRec.strMensagemRetorno, ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'Processo não foi finalizado.', ['&O k']);
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pRealizarFechamento;
begin
  If blnEhFinaceiroPendente Then
  Begin
    objVendaTrocaRec.blnEhFinaceiroPendente := blnEhFinaceiroPendente;

    If objVendaTrocaRec.fGravaITERECPendente Then
    Begin
      fMensagem('ATENÇÃO!', 'Financeiro pendente gerado com sucesso.', ['&O k']);
      blnEhFinaceiroPendente := False;

      objVendaTrocaRec.pImprimeFormularioDoc;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Processo não foi finalizado.', ['&O k']);
      ModalResult := mrNone;
    End;
  End
  Else
  If objVendaTrocaRec.fEmitirDocumentoRB Then
  Begin
    fMensagem('ATENÇÃO!', 'Documento gerado: ' + objVendaTrocaRec.strDocRec + '-' +
                                                 objVendaTrocaRec.strEspRec + '-' +
                                                 objVendaTrocaRec.strEmpRec, ['&O k']);

    pImprimirDocumento;

  End
  Else
  Begin
    If Not fEmptyStr(objVendaTrocaRec.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objVendaTrocaRec.strMensagemRetorno, ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'Processo não foi finalizado.', ['&O k']);

    ModalResult := mrNone;
  End;
end;

procedure TfrmVendaBaseTrocaRecebimento.pIncluiItensRecebimentoAutomatico;
var
  objItemRecebimento: TItemRecebimento;
  itemRecebido: TItemRecebido;
  strItemRecebimento: String;
begin
  if not Assigned(cdsPendencias) then
    Exit;

  if not cdsPendencias.Active then
    Exit;

  if cdsPendencias.RecordCount <= 0  then
    Exit;

  while not cdsPendencias.Eof do
  begin
    strItemRecebimento := fCampoTabela('ITE_PROREC','CADITE',['ITE_CODITE'],[cdsPendenciasPEN_CODITE.AsString],False);
    if fEmptyStr(strItemRecebimento) then
    begin
      cdsPendencias.Next;
      Continue;
    end;

    objItemRecebimento := objVendaTrocaRec.fRetornaItemRecebimento(cdsPendencias.FieldByName('AUTOINCREM').AsString);

    if not Assigned(objItemRecebimento) then
    begin
      cdsPendencias.Next;
      Continue;
    end;

    itemRecebido := objItemRecebimento.fAddProdutoRecebido;

    if not Assigned(itemRecebido) then
    begin
      cdsPendencias.Next;
      Continue;
    end;

    itemRecebido.strCodIte := strItemRecebimento;
    itemRecebido.strDesIte := fRetNomProduto(strItemRecebimento);
    itemRecebido.TipRec := TItemRecebido.fstrToTipRec(fCampoTabela('ITE_TIPREC','CADITE',['ITE_CODITE'],[strItemRecebimento],False));
    itemRecebido.fltVlrUni := fCampoTabela('ITE_VLRCRE','CADITE',['ITE_CODITE'],[strItemRecebimento],False);
    itemRecebido.fltQtdIte := fCampoTabela('PEN_QTDITE','PENREC',['AUTOINCREM'],[cdsPendencias.FieldByName('AUTOINCREM').AsString],False);

    pAtualizarTotais;

    cdsPendencias.Edit;
    cdsPendencias.FieldByName('PEN_TOTREC').AsFloat := itemRecebido.fltVlrUni * itemRecebido.fltQtdIte;
    cdsPendencias.Post;

    pMarcarDesmarcar(True);

    cdsPendencias.Next;
  end;
end;

end.
