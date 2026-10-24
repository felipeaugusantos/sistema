unit untFatTransfEstDevEmpCarregamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ComCtrls,
  Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Uni, cxGraphics, cxControls, cxLookAndFeels, frxClass, frxExportCSVTestabilidade,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  untZClient, cxCheckBox, cxCurrencyEdit, untTypesSistema, cxContainer,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, System.Types, System.Math, System.StrUtils, untTLock, untFuncFat;

type
  TfrmFatTransfEstDevEmpCarregamento = class(TfrmPaiConfirma)
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    pnlCabecalho: TPanel;
    cxgConsultaView: TcxGridDBTableViewCitel;
    cxgConsultaLevel: TcxGridLevel;
    cxgConsulta: TcxGridCitel;
    dtsConsul: TDataSource;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodEmpCar: TEditFocus;
    edtNomEmpCar: TEditFocus;
    Label5: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtDscIte: TEditFocus;
    edtCodIte: TEditFocus;
    Label6: TLabel;
    btnAdicionar: TBitBtnLocked;
    cxgConsultaViewNUMDOC: TcxGridDBColumn;
    cxgConsultaViewNOMCLI: TcxGridDBColumn;
    cxgConsultaViewDESITE: TcxGridDBColumn;
    cxgConsultaViewQTDDEV: TcxGridDBColumn;
    cxgConsultaViewQTPEND: TcxGridDBColumn;
    cxgConsultaViewQTDDIG: TcxGridDBColumn;
    cxgConsultaViewDTAENT: TcxGridDBColumn;
    cxgConsultaViewNUMLOT: TcxGridDBColumn;
    dteDtaIni: TcxDateEdit;
    dteDtaFin: TcxDateEdit;
    cxStyleRepo: TcxStyleRepository;
    cxStyleBold: TcxStyle;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodEmpCarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cdsConsulQTDDIGChange(Sender: TField);
    procedure cxgConsultaViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsConsul: TZClient;
    qryGenIte: TUniQuery;
    fatVenda: TFatVenda;
    objLock: TLock;
    arrSelCli, arrSelIte: TConsultasArray;
    strEmptyCodIte: String;

    procedure pMarcaTodos;
    procedure pDesmarcaTodos;
    procedure pAbreConsulta;
    procedure pBuscaDadosItem(Const strCodIte: String);
    procedure pCarregaItens(pgbProgresso: TcxProgressBar);
    function fTravaDestravaDoc(blnTravar: Boolean): Boolean;
    function fConfirma(pgbProgresso: TcxProgressBar): Boolean;
    function fGeraMovimento(pgbProgresso: TcxProgressBar): Boolean;
    function fSqlConsulta: String;
    function fValidaItens: Boolean;
    function fGetTipoFaturamento: Boolean;
    function fPedeDadosEmissaoOutrasEspecies: Boolean;
    function fPedeDadosFiscais: Boolean;
    function fPedeDadosCondPgto: Boolean;
    function fProAca: Boolean;
    function fEfetivaMovs(pgbProgresso: TcxProgressBar): Boolean;
    function fPedeDadosFinalizacaoMov: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncoesConsulta, untFatTipoFaturamento,
  untFuncFatTypes, untGravando, untFuncoes, untDuplicatas,
  untFatDigMensagemGenerica, untFatDadosFiscais, untDigCndPagamento;

{$R *.dfm}

procedure TfrmFatTransfEstDevEmpCarregamento.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    fExecutarModal(pAbreConsulta, 'Aguarde, carregando Pedidos...', '');
end;

procedure TfrmFatTransfEstDevEmpCarregamento.btnConfirmaClick(Sender: TObject);
begin
  If Not cdsConsul.Active Then
    Exit;

  If cdsConsul.IsEmpty Then
    Exit;

  If Not fValidaItens Then
  Begin
    pSetFocus(cxgConsulta);
    pMensagemOk('Nenhum item selecionado.');
    Exit;
  End;

  If fChamaTelaGravando(fConfirma, 'Aguarde, processando...') Then
  Begin
    cdsConsul.Close;
    objLock.pDestravarTodos;
    pMensagemOk('Operação realizada com sucesso!');
    pSetFocus(dteDtaIni);
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.btnDesmarcaClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pDesmarcaTodos, 'Aguarde, desmarcando todos...', '');
end;

procedure TfrmFatTransfEstDevEmpCarregamento.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(pMarcaTodos, 'Aguarde, marcando todos...', '');
end;

procedure TfrmFatTransfEstDevEmpCarregamento.cdsConsulQTDDIGChange(
  Sender: TField);
begin
  If Sender.IsNull Then
    Sender.AsFloat := 0

  Else If Sender.AsFloat < 0 Then
  Begin
    pMensagemOk('Quantidade digitada inválida!');
    Abort;
  End

  Else If CompareValue(Sender.AsFloat, cdsConsul.FieldByName('QTPEND').AsFloat) = GreaterThanValue Then
  Begin
    pMensagemOk('A quantidade digitada não pode ser superior à quantidade pendente!');
    Abort;
  End

  Else
  Begin
    IF Not fTravaDestravaDoc(Sender.AsFloat > 0) Then
    Begin
      Sender.AsFloat := 0;
      Abort;
    End;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.cxgConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not cdsConsul.Active Then
    Exit;

  If AViewInfo.GridRecord.Values[cxgConsultaViewQTDDIG.Index] > 0 Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.cxgConsultaViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    cxgConsultaView.Controller.GoToNext(False,True);
end;

procedure TfrmFatTransfEstDevEmpCarregamento.edtCodEmpCarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpCar, edtNomEmpCar, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodEmpCar, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSelCli, False) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.edtCodIteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDscIte, Nil, Key, arrSelIte, False) Then
  Begin
    If fValidaCampos(edtCodIte, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  strEmptyCodIte := fReplicatorStr('0', fTamCodIte);

  objLock := TLock.Create;

  cdsConsul := TZClient.Create(Self);
  dtsConsul.DataSet := cdsConsul;

  qryGenIte := fCriaQuery;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLock);
  FreeAndNil(cdsConsul);
  FreeAndNil(qryGenIte);
  If Assigned(fatVenda) Then
    FreeAndNil(fatVenda);
end;

procedure TfrmFatTransfEstDevEmpCarregamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6 : btnMarcaTodos.Click;
    VK_F7 : btnDesmarca.Click;
    VK_F10:
      Begin
        pSetFocus(btnConfirma);
        btnConfirma.Click;
      End;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.FormShow(Sender: TObject);
begin
  inherited;
  dteDtaIni.Date := VS_Date;
  dteDtaFin.Date := VS_Date;
end;

function TfrmFatTransfEstDevEmpCarregamento.fPedeDadosCondPgto: Boolean;
  Var
    frmDigCndPagamento: TfrmDigCndPagamento;
begin
  If Not fCfgSis('USACND', varBoolean) Then
    Exit(True);

  Result := False;
  pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
  Try
    Try
      frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text := fCfgSis('CNDINI');
      frmDigCndPagamento.fraDigCndPagamento.fatVenda  := fatVenda;
      frmDigCndPagamento.ShowModal;
      Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;

      If Result Then
        fatVenda.pAtualizaInformacoesCondPagamento;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fPedeDadosCondPgto]');
    End;
  Finally
    pFreeAndNil(frmDigCndPagamento);
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fPedeDadosEmissaoOutrasEspecies: Boolean;
  Var
    frmFatDigMensagemGenerica: TfrmFatDigMensagemGenerica;
begin
  Result := False;
  pCriarFormularios(TfrmFatDigMensagemGenerica, frmFatDigMensagemGenerica);
  Try
    Try
      frmFatDigMensagemGenerica.blnPodeCancelar           := True;
      frmFatDigMensagemGenerica.pnlTransportadora.Visible := False;
      frmFatDigMensagemGenerica.pnlDadosFrete.Visible     := True;
      frmFatDigMensagemGenerica.pnlVolumes.Visible        := False;
      frmFatDigMensagemGenerica.fatVenda                  := fatVenda;

      frmFatDigMensagemGenerica.ShowModal;
      Result := frmFatDigMensagemGenerica.blnConfirma;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fPedeDadosEmissaoOutrasEspecies]');
    End;
  Finally
    pFreeAndNil(frmFatDigMensagemGenerica);
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fPedeDadosFinalizacaoMov: Boolean;
begin
  If fatVenda.strEspDoc = 'NF' Then
    Result := fPedeDadosFiscais
  Else
  Begin
    Result := fPedeDadosEmissaoOutrasEspecies;

    If Result Then
    Begin
      fatVenda.dtaDtaEnt := fRetDataServidor;
      fatVenda.dtaDtaOri := fatVenda.dtaDtaEnt;
      fatVenda.strEntFat := 'N';
      fatVenda.strOriDoc := 'V';
    End;
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fPedeDadosFiscais: Boolean;
  Var
    frmFatDadosFiscais: TfrmFatDadosFiscais;
begin
  Result := False;
  pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
  Try
    Try
      frmFatDadosFiscais.fatVenda := fatVenda;
      frmFatDadosFiscais.ShowModal;

      Result := frmFatDadosFiscais.blnConfirma;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[fPedeDadosFiscais]');
    End;
  Finally
    pFreeAndNil(frmFatDadosFiscais);
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fProAca: Boolean;
begin
  Result := False;
  If cdsConsul.FieldByName('DET_PROACA').AsString = 'S' Then
    Exit(True);
  If Not fEmptyStr(cdsConsul.FieldByName('DET_CODACA').AsString) Then
    Exit(True);
end;

function TfrmFatTransfEstDevEmpCarregamento.fSqlConsulta: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT * FROM ( ';
  strSQL := strSQL + 'SELECT GER_CODCLI, ';
  strSQL := strSQL + '       CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NUMDOC, ';
  strSQL := strSQL + '       CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
  strSQL := strSQL + '       CONCAT(ITE_CODITE, "-", ITE_DESITE) AS DESITE, ';
  strSQL := strSQL + '       GER_DTAENT, ';
  strSQL := strSQL + '       GER_ENTFAT, ';
  strSQL := strSQL + '       DET_BXSBIT, ';
  strSQL := strSQL + '       DET_QTDITE AS QTDDEV, ';
  strSQL := strSQL + '       DET_QTDITE - IFNULL((SELECT SUM(DET.DET_QTDITE) FROM MOVAUX AUX, MOVDET DET ';
  strSQL := strSQL + '                            WHERE AUX.DET_SEQGER = DET.AUTOINCREM ';
  strSQL := strSQL + '                            AND AUX.DET_DEVCAR = MOVDET.AUTOINCREM),0) AS QTPEND, ';
  strSQL := strSQL + '       0.00 AS QTDDIG, ';
  strSQL := strSQL + '       MOVDET.*, ';
  strSQL := strSQL + '       MOVTRI.DET_UNIVIS, ';
  strSQL := strSQL + '       MOVTRI.DET_VAL_RT, ';
  strSQL := strSQL + '       MOVTRI.DET_TAXJUR  ';
  strSQL := strSQL + 'FROM MOVGER ';
  strSQL := strSQL + 'JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + 'JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + 'JOIN MOVAUX ON MOVAUX.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + 'JOIN CADCLI ON CADCLI.CLI_CODCLI = MOVGER.GER_CODCLI ';
  strSQL := strSQL + 'JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE ';
  strSQL := strSQL + 'WHERE IFNULL(DET_DOCDEV,"") <> "" ';
  strSQL := strSQL + '  AND IFNULL(DET_ESPDEV,"") <> "" ';
  strSQL := strSQL + '  AND IFNULL(DET_EMPDEV,"") <> "" ';
  strSQL := strSQL + '  AND DET_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '  AND IF(GER_ENTFAT = "S" AND DET_BXSBIT = "S", '+ QuotedStr(edtCodEmpCar.Text) +' IN ';
  strSQL := strSQL + '    (SELECT ITE_EMPCAR ';
  strSQL := strSQL + '     FROM GERMAT ';
  strSQL := strSQL + '     JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ';
  strSQL := strSQL + '     JOIN CADITE ON ITE_CODITE = DMT_ITESUB ';
  strSQL := strSQL + '     WHERE GMT_CODITE = DET_CODITE ';
  strSQL := strSQL + '       AND ITE_EMPCAR <> DET_CODEMP), ';
  strSQL := strSQL + '  DET_EMPCAR = '+ QuotedStr(edtCodEmpCar.Text) +' AND DET_EMPCAR <> DET_CODEMP) ';

  If Not fEmptyStr(fTiraCaracEspeciais(dteDtaIni.Text)) Then
    strSQL := strSQL + ' AND GER_DTAENT BETWEEN ' + fDateSql(dteDtaIni.Date) + ' AND ' + fDateSql(dteDtaFin.Date);

  If Not fEmptyStr(edtCodIte.Text) Then
    strSQL := strSQL + ' AND DET_CODITE IN (' + fRetArrToSQLIn(arrSelIte, edtCodIte.Text) + ') ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + ' AND GER_CODCLI IN (' + fRetArrToSQLIn(arrSelCli, edtCodCli.Text) + ') ';

  strSQL := strSQL + ' ) AS CONS ';
  strSQL := strSQL + ' WHERE QTPEND > 0 ';
  strSQL := strSQL + ' ORDER BY NUMDOC ';

  Result := strSQL;
end;

function TfrmFatTransfEstDevEmpCarregamento.fGetTipoFaturamento: Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento: TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  If fPermiteEmissaoEspecie('TE', edtCodEmpCar.Text) Then
  Begin
    arrOpcoes[1].strDesCri := 'Transferência de Estoque';
    arrOpcoes[1].strEspDoc := 'TE';
    arrOpcoes[1].strOpcLet := 'T';
    arrOpcoes[1].strMosMen := 'S';
  End;

  Try
    Try
      pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
      frmFatTipoFaturamento.strOpcDoc := 'VN';
      frmFatTipoFaturamento.fatVenda  := fatVenda;
      frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
      frmFatTipoFaturamento.ShowModal;

      If frmFatTipoFaturamento.blnConfirma Then
      Begin
        fatVenda.strEspDoc   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
        fatVenda.strTipFat   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;
        fatVenda.blnRcOutEnt := fatVenda.strEspDoc <> 'NF';

        Result := Not fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite);
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGetTipoFaturamento]');
      End;
    End;
  Finally
    pFreeAndNil(frmFatTipoFaturamento);
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fValidaItens: Boolean;
begin
  Result := False;

  cdsConsul.DisableControls;
  Try
    cdsConsul.First;
    While Not cdsConsul.Eof Do
    Begin
      If cdsConsul.FieldByName('QTDDIG').AsFloat > 0 Then
      Begin
        Result := True;
        Break;
      End;
      cdsConsul.Next;
    End;
  Finally
    cdsConsul.EnableControls;
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fConfirma(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    fatVenda := TFatVenda.CreateInstance('DV');
    fatVenda.strOpcDoc     := 'TE';
    fatVenda.strOpcDocTrue := 'TE';
    fatVenda.strEmp_TE     := VS_strCodEmp;
    fatVenda.strNomeForm   := 'frmFatVendas';
    fatVenda.strCodCli     := fRetornaClienteFilial(edtCodEmpCar.Text);

    If fEmptyStr(fatVenda.strCodCli) Then
    Begin
      pMensagemOk('Cliente filial não informado no cadastro da empresa de carregamento. Verifique o cadastro e tente novamente');
      Exit;
    End;

    pCriarCdsVenda(Self);

    fStartTransaction;

    Result := fGeraMovimento(pgbProgresso);

    If Result Then
      fCommit
    Else
      fRollback;
  Finally
    FreeAndNil(fatVenda);
    pFreeCdsVenda;
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fEfetivaMovs(pgbProgresso: TcxProgressBar): Boolean;
begin
  If fatVenda.strEspDoc = 'NF' Then
    Result := fatVenda.fGravaArquivos(pgbProgresso)
  Else
  Begin
    If fatVenda.fHaveraDesmembramentoProVendedor(fatVenda.strOpcDoc) Then
      Result := fatVenda.fGravaArquivosDesmembrandoVenda(pgbProgresso)
    Else
      Result := fatVenda.fGravaArquivos(pgbProgresso)
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fGeraMovimento(pgbProgresso: TcxProgressBar): Boolean;
begin
  Try
    pInformacao('Aguarde, gerando movimento para a empresa de carregamento...', pgbProgresso);

    fatVenda.fClienteFilialVenda(fatVenda.strCodCli);
    fatVenda.pCarregaDadosClienteBaixa(fatVenda.strCodCli);

    fatVenda.strCodVen := fatVenda.strCodOpe;
    fatVenda.strCodDig := fatVenda.strCodOpe;
    fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
    fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);

    cdsConsul.DisableControls;
    Try
      cdsConsul.Filtered := False;
      cdsConsul.Filter   := 'QTDDIG > 0';
      cdsConsul.Filtered := True;

      pProgresso(0, cdsConsul.RecordCount, pgbProgresso);

      pCarregaItens(pgbProgresso);

      fatVenda.pCarregaAliquotasRetencao;
      fatVenda.pAtualizaClassTransferencias;
      fatVenda.pPreencheMatrizFechamento;
      fatVenda.pCalculaPesBruLiq;
      fatVenda.pCalculaTotGer(False, False);

      If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
      Begin
        If (fatVenda.fltDesEsp <= 0.00) Then
        Begin
          If (fatVenda.fltIcmOrg > 0) Then
            fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        End;
      End;

      fatVenda.pDestacaRetencoes;
      fatVenda.pRetemImpostosNoDescontoEspecial;
      fatVenda.pCalculaTotGer(False, False);
      fatVenda.pCalculaTotGer;

      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                               False, False, False, VS_Date, False);

      fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

      fatVenda.pCalculaTotalParaCadRec;
      fatVenda.pRateiaValores;

      If Not fPedeDadosCondPgto Then
        Exit(False);

      If Not fGetTipoFaturamento Then
        Exit(False);

      If Not fPedeDadosFinalizacaoMov Then
        Exit(False);

      Result := fEfetivaMovs(pgbProgresso);

    Finally
      cdsVenda.EmptyDataSet;
      cdsConsul.Filtered := False;
      cdsConsul.EnableControls;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGeraMovimento]');
    End;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.pAbreConsulta;
  Var
    strMask: String;
begin
  cdsConsul.Close;
  cdsConsul.qryQuery.SQL.Text := fSqlConsulta;

  cdsConsul.fAbreClient(True, 'TfrmFatTransfEstDevEmpCarregamento.pAbreConsulta');

  strMask := fMskDigitos(fCfgSis('DECQTD', varInteger));

  TFloatField(cdsConsul.FieldByName('QTDDEV')).DisplayFormat := strMask;
  TFloatField(cdsConsul.FieldByName('QTPEND')).DisplayFormat := strMask;
  TFloatField(cdsConsul.FieldByName('QTDDIG')).DisplayFormat := strMask;

  cdsConsul.FieldByName('QTDDIG').OnChange := cdsConsulQTDDIGChange;

  objLock.pDestravarTodos;

  If cdsConsul.IsEmpty Then
    pSetFocus(dteDtaIni)
  Else
  Begin
    pSetFocus(cxgConsulta);
    cxgConsultaViewQTDDIG.FocusWithSelection;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.pBuscaDadosItem(Const strCodIte: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  A.ABF_CODABF, ';
  strSQL := strSQL + '  M.MAR_DESMAR, ';
  strSQL := strSQL + '  I.ITE_OBRCPF,  ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + ' JOIN ABFICM A ON I.ITE_CODABF = A.ABF_CODABF '
  Else
    strSQL := strSQL + ' JOIN ABFICM A ON G.ITE_CODABF = A.ABF_CODABF ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

  qryGenIte.Close;
  qryGenIte.SQL.Clear;
  qryGenIte.SQL.Add(strSQL);
  qryGenIte.ParamByName('CODITE').AsString := strCodIte;
  qryGenIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGenIte.ParamByName('ESTADO').AsString := fRetUFEmpresa;
  qryGenIte.Open;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.pCarregaItens(pgbProgresso: TcxProgressBar);
  Var
    recForTin: TForTin;
    recMadeira: TDadosMadeira;
begin
  cdsVenda.EmptyDataSet;

  cdsConsul.First;
  While Not cdsConsul.Eof Do
  Begin
    pBuscaDadosItem(cdsConsul.FieldByName('DET_CODITE').AsString);

    fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                         Nil,
                                         'NOR',
                                         qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                         cdsConsul.FieldByName('DET_CODITE').AsString,
                                         qryGenIte.FieldByName('ITE_DESITE').AsString,
                                         cdsConsul.FieldByName('DET_DESCRI').AsString,
                                         qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                         cdsConsul.FieldByName('DET_UNIDAD').AsString,
                                         cdsConsul.FieldByName('DET_UNIDAD').AsString,
                                         cdsConsul.FieldByName('DET_CODMAR').AsString,
                                         cdsConsul.FieldByName('DET_CODFOR').AsString,
                                         cdsConsul.FieldByName('DET_REFERE').AsString,
                                         cdsConsul.FieldByName('DET_UNIORI').AsFloat,
                                         cdsConsul.FieldByName('DET_UNIVIS').AsFloat,
                                         cdsConsul.FieldByName('DET_UNITAR').AsFloat,
                                         0.0,
                                         cdsConsul.FieldByName('DET_DESCON').AsFloat,
                                         cdsConsul.FieldByName('QTDDIG').AsFloat,
                                         cdsConsul.FieldByName('DET_UNITAR').AsFloat * cdsConsul.FieldByName('QTDDIG').AsFloat,
                                         'S',
                                         cdsConsul.FieldByName('DET_TOTCUS').AsFloat / cdsConsul.FieldByName('QTDDEV').AsFloat,
                                         fFormataFloat(cdsConsul.FieldByName('DET_TOTCUS').AsFloat / cdsConsul.FieldByName('QTDDEV').AsFloat * cdsConsul.FieldByName('QTDDIG').AsFloat, 2),
                                         qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                         qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                         qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREVE7').AsFloat,
                                         fCalculaPrecoVenda(2, fFormataFloat(
                                            cdsConsul.FieldByName('DET_TOTCUS').AsFloat / cdsConsul.FieldByName('QTDDEV').AsFloat *
                                            cdsConsul.FieldByName('QTDDIG').AsFloat, 2), cdsConsul.FieldByName('DET_UNITAR').AsFloat, 0, 0, 0, 0, 0),
                                         qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                         cdsConsul.FieldByName('DET_INCPIS').AsString,
                                         qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                         qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                         qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         qryGenIte.FieldByName('ITE_PREULT').AsFloat * cdsConsul.FieldByName('QTDDIG').AsFloat,
                                         qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                         qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                         qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                         cdsConsul.FieldByName('DET_ITECHA').AsString,
                                         cdsConsul.FieldByName('DET_ITETIN').AsString,
                                         cdsConsul.FieldByName('DET_DESCOR').AsString,
                                         cdsConsul.FieldByName('DET_TIPPRE').AsString,
                                         cdsConsul.FieldByName('DET_LAZQUA').AsInteger,
                                         cdsConsul.FieldByName('DET_TIPEMB').AsString,
                                         0,
                                         0,
                                         cdsConsul.FieldByName('DET_PRVTIN').AsFloat,
                                         cdsConsul.FieldByName('DET_PRCTIN').AsFloat,
                                         cdsConsul.FieldByName('DET_FATTIN').AsFloat,
                                         'N',
                                         '',
                                         0,
                                         0,
                                         qryGenIte.FieldByName('ABF_CODABF').AsString,
                                         qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                         qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                         cdsConsul.FieldByName('DET_PROMOC').AsString,
                                         0,
                                         0,
                                         0,
                                         0,
                                         IIF(fEmptyStr(cdsConsul.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                         fatVenda.fRetPerComGrupo(qryGenIte.FieldByName('ITE_CODGRU').AsString),
                                         qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                         -1,
                                         0,
                                         '',
                                         '',
                                         '',
                                         qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                         qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                         qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                         fRetNomMarca(cdsConsul.FieldByName('DET_CODMAR').AsString),
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         0,
                                         '',
                                         '',
                                         '',
                                         qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                         cdsConsul.FieldByName('DET_UNITAR').AsFloat,
                                         qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                         '',
                                         '',
                                         qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                         '',
                                         '',
                                         fRetSiglaUnidade(cdsConsul.FieldByName('DET_UNIDAD').AsString),
                                         cdsConsul.FieldByName('DET_VOLPRO').AsFloat,
                                         cdsConsul.RecNo,
                                         '',
                                         cdsConsul.FieldByName('DET_CODACA').AsString,
                                         cdsConsul.FieldByName('DET_EMPACA').AsString,
                                         fProAca,
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         cdsConsul.FieldByName('DET_TABPRE').AsString,
                                         qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                         qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                         '',
                                         0.0,
                                         '',
                                         0.0,
                                         IIF(cdsConsul.FieldByName('GER_ENTFAT').AsString = 'S', 'E', 'R'), //strEntRet
                                         '',
                                         'N',
                                         '',
                                         0,
                                         cdsConsul.FieldByName('QTDDIG').AsFloat,
                                         0.0,
                                         0,
                                         qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                         '',
                                         cdsConsul.FieldByName('DET_TOTCU2').AsFloat / cdsConsul.FieldByName('QTDDEV').AsFloat,
                                         fFormataFloat(cdsConsul.FieldByName('DET_TOTCU2').AsFloat / cdsConsul.FieldByName('QTDDEV').AsFloat * cdsConsul.FieldByName('QTDDIG').AsFloat, 2),
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         recForTin,
                                         '',
                                         '',
                                         cdsConsul.FieldByName('DET_NUMLOT').AsString,
                                         '',
                                         '',
                                         ((cdsConsul.FieldByName('GER_ENTFAT').AsString = 'S') And (cdsConsul.FieldByName('DET_BXSBIT').AsString = 'S')), //blnBxSbIt
                                         'N',
                                         'NOR',
                                         0,
                                         '',
                                         qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         1,
                                         True,
                                         '',
                                         '',
                                         '',
                                         0,
                                         qryGenIte.FieldByName('ITE_PRECUS').AsFloat,
                                         '',
                                         '',
                                         recMadeira,
                                         qryGenIte.FieldByName('ITE_IMPULT').AsFloat * cdsConsul.FieldByName('QTDDIG').AsFloat,
                                         cdsConsul.FieldByName('DET_VAL_RT').AsFloat,
                                         cdsConsul.FieldByName('DET_TAXJUR').AsFloat,
                                         '',
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         cdsConsul.FieldByName('DET_CODVEN').AsString,
                                         'N',
                                         0,
                                         0,
                                         0,
                                         False,
                                         False,
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         'N',
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                         0.00,
                                         '',
                                         '',
                                         '',
                                         'S',
                                         'N',
                                         '',
                                         '',
                                         '',
                                         '',
                                         False,
                                         -1,
                                         -1,
                                         'N',
                                         '',
                                         'N',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         False,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         'N',
                                         'N',
                                         '',
                                         0,
                                         0,
                                         '',
                                         cdsConsul.FieldByName('AUTOINCREM').AsString,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                         qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                         qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

    pProgresso(cdsConsul.RecNo, cdsConsul.RecordCount, pgbProgresso);
    cdsConsul.Next;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.pDesmarcaTodos;
begin
  If Not cdsConsul.Active Then
    Exit;

  cdsConsul.DisableControls;
  Try
    cdsConsul.First;
    While Not cdsConsul.Eof Do
    Begin
      cdsConsul.Edit;
      cdsConsul.FieldByName('QTDDIG').AsFloat := 0;
      cdsConsul.Post;

      cdsConsul.Next;
    End;
  Finally
    cdsConsul.EnableControls;
  End;
end;

procedure TfrmFatTransfEstDevEmpCarregamento.pMarcaTodos;
begin
  If Not cdsConsul.Active Then
    Exit;

  cdsConsul.DisableControls;
  Try
    cdsConsul.First;
    While Not cdsConsul.Eof Do
    Begin
      cdsConsul.Edit;
      cdsConsul.FieldByName('QTDDIG').AsFloat := cdsConsul.FieldByName('QTPEND').AsFloat;
      cdsConsul.Post;

      cdsConsul.Next;
    End;
  Finally
    cdsConsul.EnableControls;
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fTravaDestravaDoc(blnTravar: Boolean): Boolean;
  Var
    strLock: String;
begin
  Result := True;
  strLock := 'MOVDET' + cdsConsul.FieldByName('AUTOINCREM').AsString;

  If Not blnTravar Then
  Begin
    If objLock.fLocalizaTrava(strLock) Then
      objLock.fLock_Unlock(strLock, False);
    Exit;
  End;

  If Not objLock.fLocalizaTrava(strLock) Then //travado por outra instância
  Begin
    If Not objLock.fLock_Unlock(strLock, True, False, True) Then
    Begin
      pMensagemOk('Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strLock));
      Exit(False);
    End;
  End;
end;

function TfrmFatTransfEstDevEmpCarregamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = dteDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dteDtaIni.Text)) Then
      Begin
        pMensagemOK('A data inicial deve ser preenchida!');
        Result := False;
      End
    End

    Else If (Sender = dteDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dteDtaFin.Text)) Then
      Begin
        pMensagemOK('A data final deve ser preenchida!');
        Result := False;
      End
      Else If Not fValidaPeriodo(dteDtaIni.Text, dteDtaFin.Text) Then
      Begin
        pMensagemOK('A data final deve ser maior que a data inicial!');
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpCar) Then
    Begin
      If fEmptyStr(edtCodEmpCar.Text) Then
      Begin
        pMensagemOK('A Empresa responsável pelo carregamento deve ser preenchida!');
        Result := False;
      End
      Else
      Begin
        edtNomEmpCar.Text := fRetNomeEmpresaSelec(edtCodEmpCar.Text);
        If fEmptyStr(edtNomEmpCar.Text) Then
        Begin
          pMensagemOK('Essa empresa não está cadastrada!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
        edtNomCli.Text := 'TODOS'
      Else If edtCodCli.Text <> '00000000' Then
      Begin
        SetLength(arrSelCli, 0);
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          pMensagemOK('Esse cliente não está cadastrado!');
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
        edtDscIte.Text := 'TODOS'
      Else If edtCodIte.Text <> strEmptyCodIte Then
      Begin
        SetLength(arrSelIte, 0);
        edtDscIte.Text := fRetNomProduto(edtCodIte.Text);
        If fEmptyStr(edtDscIte.Text) Then
        Begin
          pMensagemOK('Esse produto não está cadastrado!');
          Result := False;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
