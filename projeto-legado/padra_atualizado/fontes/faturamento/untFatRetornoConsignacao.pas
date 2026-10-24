unit untFatRetornoConsignacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, StrUtils, Buttons, ExtCtrls,
  untFuncFat,
  BitBtnLockedIncrem, DBGridCitel, DBGrids, untZClient,
  MemDS, DBAccess, frxClass, Datasnap.Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, cxProgressBar, untGravando, untTLock, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxGridDBBandedTableView, untCfgColExpRetornoConsig;

const
  cnsAutInc = ' /*AUTINC*/ ';

type
  TfrmFatRetornoConsignacao = class(TfrmPaiOrdena)
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    pnlDocs: TPanel;
    mskDtaFin: TMaskEditFocus;
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    lbl3: TLabel;
    img1: TImage;
    lbl2: TLabel;
    pnlPen: TPanel;
    pnlDev: TPanel;
    pnlEnv: TPanel;
    pnlRet: TPanel;
    pnlEnvTotSin: TPanel;
    pnlDevTotSin: TPanel;
    pnlPenTotSin: TPanel;
    pnlRetTotSin: TPanel;
    pnlEnvTotAnl: TPanel;
    pnlDevTotAnl: TPanel;
    pnlPenTotAnl: TPanel;
    pnlRetTotAnl: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    cxGridConsulta: TcxGridCitel;
    cxGridConsultaView: TcxGridDBTableViewCitel;
    cxGridConsultaViewVENDEDOR: TcxGridDBColumn;
    cxGridConsultaViewDET_CODITE: TcxGridDBColumn;
    cxGridConsultaViewDET_DESCRI_: TcxGridDBColumn;
    cxGridConsultaViewDET_UNIDAD: TcxGridDBColumn;
    cxGridConsultaViewDET_UNITAR: TcxGridDBColumn;
    cxGridConsultaViewDET_QTDENV: TcxGridDBColumn;
    cxGridConsultaViewDET_TOTITE: TcxGridDBColumn;
    cxGridConsultaViewDET_QTFARE: TcxGridDBColumn;
    cxGridConsultaViewDET_TOTFAT: TcxGridDBColumn;
    cxGridConsultaViewDEV_QTDDVS: TcxGridDBColumn;
    cxGridConsultaViewDEV_VLRDVS: TcxGridDBColumn;
    cxGridConsultaViewDET_QTDJAF: TcxGridDBColumn;
    cxGridConsultaViewDET_VLRJAF: TcxGridDBColumn;
    cxGridConsultaViewDET_QTDPEN: TcxGridDBColumn;
    cxGridConsultaViewDET_TOTPEN: TcxGridDBColumn;
    cxGridConsultaViewDET_QTDRET: TcxGridDBColumn;
    cxGridConsultaViewDET_VALRET: TcxGridDBColumn;
    cxGridConsultaLevel1: TcxGridLevel;
    cxGridAnalitico: TcxGridCitel;
    cxGridAnaliticoView: TcxGridDBTableViewCitel;
    cxGridAnaliticoViewGER_DTAENT: TcxGridDBColumn;
    cxGridAnaliticoViewDET_NUMDOC: TcxGridDBColumn;
    cxGridAnaliticoViewDET_ESPDOC: TcxGridDBColumn;
    cxGridAnaliticoViewDET_CODEMP: TcxGridDBColumn;
    cxGridAnaliticoViewVENDEDOR: TcxGridDBColumn;
    cxGridAnaliticoViewDET_UNIDAD: TcxGridDBColumn;
    cxGridAnaliticoViewDET_UNITAR: TcxGridDBColumn;
    cxGridAnaliticoViewDET_QTDENV: TcxGridDBColumn;
    cxGridAnaliticoViewDET_TOTITE: TcxGridDBColumn;
    cxGridAnaliticoViewDET_QTFARE: TcxGridDBColumn;
    cxGridAnaliticoViewDET_TOTFAT: TcxGridDBColumn;
    cxGridAnaliticoViewDEV_QTDDVS: TcxGridDBColumn;
    cxGridAnaliticoViewDEV_VLRDVS: TcxGridDBColumn;
    cxGridAnaliticoViewDET_QTDJAF: TcxGridDBColumn;
    cxGridAnaliticoViewDET_VLRJAF: TcxGridDBColumn;
    cxGridAnaliticoViewDET_QTDPEN: TcxGridDBColumn;
    cxGridAnaliticoViewDET_TOTPEN: TcxGridDBColumn;
    cxGridAnaliticoViewDET_QTDRET: TcxGridDBColumn;
    cxGridAnaliticoViewDET_VALRET: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    btnCfgFatConsig: TBitBtnLocked;
    cxGridConsultaViewDET_NUMLOT: TcxGridDBColumn;
    cxGridAnaliticoViewDET_NUMLOT: TcxGridDBColumn;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure mskDtaIniEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cxGridConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAnaliticoViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridConsultaViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxGridAnaliticoViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridAnaliticoViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnCfgFatConsigClick(Sender: TObject);
    procedure cxGridConsultaViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridAnaliticoViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    qryRevalidar: TUniQuery;
    cdsAnalitico: TZClient;

    blnMarcaTodos : Boolean;
    blnHabilitaScroll: Boolean;
    blnPostandoPai   : Boolean;
    blnPostandoFilho : Boolean;
    intDecUni: Integer;

    frmFechamentoRetorno: TfrmGravando;

    objLock: TLock;

    procedure pCalculaTotais(chrTip: Char='T');
    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    function fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;

    Function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    Function fGetDadosConsignacao(fatVenda: TFatVenda): Boolean;

    Function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fIncluiItens(fatVenda: TFatVenda): Boolean;
    function fSQLSintetico: String;
    function fSQLAnalitico: String;

    procedure pAfterPostAnalitico(DataSet: TDataSet);
    procedure pBeforePostAnalitico(DataSet: TDataSet);
    procedure pAfterInsertAnalitico(DataSet: TDataSet);
    function  fExisteItemSelecionado: Boolean;

    function fMarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure pPreencheMatrizConsignacao;
    procedure pZeraTotais;
    function fTravaDocumento: Boolean;
    function fRetornaQuantidadePendente(const strAutInc: String): Double;
    procedure pGravarConfiguracoes;
    procedure pAjustaColunasGrid;
    procedure pCancelaCdsConsulta;

    procedure pValidaSeOcultaColunaDeLotes;
    function fRetFilter : String;
    function fRetMovConTipD : String;
    function fRetMovConTipF: String;
  public
    { Public declarations }
    blnNfeOutrasEntradas: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fSetParametros: Boolean; Override;

  end;

const
  COR_ENV = 13434828;
  COR_DEV = 16768959;
  COR_PEN = 10944511;
  COR_RET = $00A8D3FF;
  COR_DES = clLtGray;
  COR_JAF = 16768959;

const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_LEFT, VK_RIGHT, VK_NEXT, VK_HOME, VK_END];



implementation

uses untFatTipoFaturamento, untFuncFatTypes, untFuncoesSimples,
     untConsultas, untPesqAux, untFuncoes, untFatDigDadosConsignacao,
     untTypesSistema, untDuplicatas, Faturamento.Consignacao.Classes,
     untFuncoesGenerica, untFuncFatTelasHelper,
     untConfigRetornoConsignacao, untcxGridDBBandedTableViewHelper, untCadLote;

{$R *.dfm}

function TfrmFatRetornoConsignacao.fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;
Var
  blnConfirma: Boolean;

  procedure pAcertaDesEspItens;
    Var
      intIndex: Integer;
      objConsig: TConsignacoes;
  begin
    for intIndex := Low(fatvenda.arrMatItens) to high(fatvenda.arrMatItens) do
    begin
      With fatvenda, dicDocs, arrMatItens[intIndex] Do
        objConsig := TConsignacoes(RetornaObjeto(intToStr(intAutInc)));

      fatvenda.arrMatItens[intIndex].fltDesEsp :=  objConsig.fGetTotalDesEsp;
    end;
  end;

begin

  Result := True;

  pnlHeader.Enabled := False;
  cdsConsulta.DisableControls;

  Try

    Try

      If Not cdsConsulta.Active Then
        Exit(False);

      If (Not fExisteItemSelecionado) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade para retorno não foi informada!', ['&O k']);
        Exit(False);
      End;

      if not fTravaDocumento then
      begin
        Exit(False);
      end;

      Try
        If Assigned(frmFechamentoRetorno) Then
        Begin
          pProgresso (0, 0, frmFechamentoRetorno.pgbStatus);
          pInformacao('Aguarde, realizando fechamento do retorno...', frmFechamentoRetorno.pgbStatus);
        End;

        fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);
        pInicializaTemporaria;

        fatVenda.strOpcDoc := 'CR';

        fatVenda.strCodVen := fatVenda.strCodOpe;
        fatVenda.strCodDig := fatVenda.strCodOpe;
        fatVenda.strNomVen := fRetNomVendRep(fatVenda.strCodVen);
        fatVenda.strNomDig := fRetNomVendRep(fatVenda.strCodDig);

        pPreencheMatrizConsignacao;

        If Assigned(frmFechamentoRetorno) Then
          pInformacao('Aguarde, carregando dados do(s) produto(s) para fechamento...', frmFechamentoRetorno.pgbStatus);

        blnConfirma := fIncluiItens(fatVenda);

        If (cdsVenda.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Nenhum item foi carregado para a geração do documento!', ['&OK']);
          pInicializaTemporaria;
          Exit(False);
        End;

        If (blnConfirma) Then
        Begin

          fatVenda.pCarregaAliquotasRetencao;

          fatVenda.pPreencheMatrizFechamento;

          fatVenda.pCalculaPesBruLiq;

          fatVenda.pCalculaTotGer(False, False);

          If fatVenda.fAplicaDescontoIcmsOrgaoPublicoNoDescontoEspecial Then
          Begin
            If (fatVenda.fltDesEsp <= 0.00) And (fatVenda.fltIcmOrg > 0) Then
              fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
          End;

          fatVenda.pDestacaRetencoes;
          fatVenda.pRetemImpostosNoDescontoEspecial;

          fatVenda.pCalculaTotGer(False, False);

          fatVenda.pCalculaTotGer;

          fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                                   FAlse, False, False, VS_Date, False);

          fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

          fatVenda.pCalculaTotalParaCadRec;

          fatVenda.pRateiaValores;

          pAcertaDesEspItens;

          If Not fGetTipoFaturamento(fatVenda) Then
          Begin
            pInicializaTemporaria;
            Exit(False);
          End;

          If blnNfeOutrasEntradas Then
          Begin
            With fatVenda Do
            Begin
              dtaDtaEnt := fRetDataServidor;
              dtaDtaOri := dtaDtaEnt;
              strEntFat := 'N';
              strOriDoc := 'V';
            End;
          End
          Else
          If Not fGetDadosConsignacao(fatVenda) Then
          Begin
            pInicializaTemporaria;
            Exit(False);
          End;

          if (blnNfeOutrasEntradas) and (fatVenda.fHaveraDesmembramentoProVendedor(fatVenda.strOpcDoc)) then
          begin
            if not fatVenda.fGravaArquivosDesmembrandoVenda(frmFechamentoRetorno.pgbStatus) then
              Exit(False);
          end
          else
          begin
            if not fatVenda.fGravaArquivos(frmFechamentoRetorno.pgbStatus) then
              Exit(False);
          end;

          pInicializaTemporaria;

        End;
      Finally
        objLock.pDestravarTodos;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatBaixaPedidoDev.pConfirma]');
        pInicializaTemporaria;
        pZeraTotais;
      End;
    End;

  Finally
    pnlHeader.Enabled := True;
    cdsConsulta.EnableControls;
    pCalculaTotais;
    pZeraTotais;
  End;

end;

procedure TfrmFatRetornoConsignacao.btnConfirmaClick(Sender: TObject);
begin

  inherited;

  Try

    pCriarFormularios(TfrmGravando, frmFechamentoRetorno);
    frmFechamentoRetorno.strChave      := 'FATRETORNO';
    frmFechamentoRetorno.fExecutarAcao := fConfirma;
    frmFechamentoRetorno.ShowModal;

    If (frmFechamentoRetorno.blnConfirma) Then
    Begin
      pMensagemOk('Operação realizada com sucesso!');
      pSetFocus(mskDtaIni);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If Assigned(frmFechamentoRetorno) Then
    pFreeAndNil(frmFechamentoRetorno);

end;

procedure TfrmFatRetornoConsignacao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnDesmarcaTodos.Visible Then
    Exit;

  Try

    pCriarFormularios(TfrmGravando,frmGravando);

    Try

      frmGravando.strChave            := 'FATRETORNO_DESMARCATODOS';
      frmGravando.fExecutarAcao       := fDesmarcaTodos;
      frmGravando.lblGravando.Caption := 'Aguarde, desmarcando...';
      frmGravando.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnDesmarcaTodos - frmGravando]');
        Exit;
      End;
    End;

  Finally
    pFreeAndNil(frmGravando);
  End;

end;

procedure TfrmFatRetornoConsignacao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnMarcaTodos.Visible Then
    Exit;

  Try

    pCriarFormularios(TfrmGravando,frmGravando);

    Try

      frmGravando.strChave            := 'FATRETORNO_MARCATODOS';
      frmGravando.fExecutarAcao       := fMarcaTodos;
      frmGravando.lblGravando.Caption := 'Aguarde, marcando...';
      frmGravando.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnMarcaTodos - frmGravando]');
        Exit;
      End;
    End;

  Finally
    pFreeAndNil(frmGravando);
  End;

end;

procedure TfrmFatRetornoConsignacao.cdsConsultaAfterPost(DataSet: TDataSet);
  Var
    fltQtdRes : Double;
begin
  inherited;

  //Pai
  If (Not blnPostandoFilho) Then
  Begin
    blnPostandoPai := True;
    Try
      fltQtdRes := cdsConsulta.FieldByName('DET_QTDRET').AsFloat;

      Try
        With cdsAnalitico do
        Begin
          {**************************************************}
          {* LIMPA A QTDE DE RETORNO EM TODOS OS DOCUMENTOS *}
          {* RELACIONADOS AO PRODUTO SELECIONADO.           *}
          {***********************************************MM*}
          First;
          While Not EOF Do
          Begin
            Edit;
            FieldByName('DET_QTDRET').AsFloat := 0;
            Post;
            Next;
          End;

          {**********************************************}
          {* RATEIA A QUANTIDADE DE PRODUTOS RETORNADOS *}
          {* NOS DOCUMENTOS RELACIONADOS.               *}
          {*******************************************MM*}
          First;
          While Not EOF Do
          Begin
            If ((cdsAnalitico.FieldByName('DET_QTDPEN').AsFloat) > 0) Then
            Begin
              Edit;

              If (fltQtdRes > cdsAnalitico.FieldByName('DET_QTDPEN').AsFloat) Then
              Begin
                FieldByName('DET_QTDRET').AsFloat := FieldByName('DET_QTDPEN').AsFloat;
                fltQtdRes                         := fltQtdRes - FieldByName('DET_QTDPEN').AsFloat;
              End
              Else
              Begin
                FieldByName('DET_QTDRET').AsFloat := fltQtdRes;
                fltQtdRes                         := 0;
              End;

              Post;
            End;

            Next;
          End;
          First;
        End;

      Except
        On E: Exception Do
        Begin
          cdsConsulta.EnableControls;
          pMensagensErro(E.Message,'TfrmFatRetornoConsignacao.cdsConsultaAfterPost');
        End;
      End;

      If Not blnMarcaTodos Then
        pCalculaTotais;
    Finally
      blnPostandoPai := False;
      blnHabilitaScroll := True;
    End;
  End;
  
End;

function TfrmFatRetornoConsignacao.fRetFilter : String;
begin
  Result := 'DET_CODITE = ' + QuotedStr(cdsConsulta.FieldByName('DET_CODITE').AsString) + ' AND ' +
            'DET_UNITAR = ' + cdsConsulta.FieldByName('DET_UNITAR').AsString + ' AND ' +
            'VENDEDOR = ' + QuotedStr(cdsConsulta.FieldByName('VENDEDOR').AsString);

  If Not TCadLot.fItemSemNenhumLoteEmpresa(cdsConsulta.FieldByName('DET_CODITE').AsString, VS_strCodEmp) Then
    Result := Result + ' AND DET_NUMLOT = ' + QuotedStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString);

  If Not fEmptyStr(cdsConsulta.FieldByName('DET_CODACA').AsString) Then
    Result := Result + ' AND DET_CODACA = ' + QuotedStr(cdsConsulta.FieldByName('DET_CODACA').AsString);
end;


procedure TfrmFatRetornoConsignacao.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If (Not blnHabilitaScroll) Then
    Exit;

  If Not (cdsConsulta.IsEmpty) Then
  Begin
    With cdsAnalitico Do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := fRetFilter;
      Filtered := True;
      EnableControls;
    End;

    If Not (cdsAnalitico.IsEmpty) Then
      pnlDocs.Caption := '   ' + IntToStr(cdsAnalitico.RecordCount) +
                         IIF(cdsAnalitico.RecordCount <= 1,' DOCUMENTO ENVIADO',' DOCUMENTOS ENVIADOS');

    pCalculaTotais('A');
  End;
end;

procedure TfrmFatRetornoConsignacao.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('DET_QTDRET').AsFloat < 0) Then
    Begin
      cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      pCancelaCdsConsulta;
      Abort;
    End
    Else If (FieldByName('DET_QTDRET').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      pCancelaCdsConsulta;
      Abort;
    End
    Else
      FieldByName('DET_VALRET').AsFloat := FieldByName('DET_QTDRET').AsFloat * FieldByName('DET_UNITAR').AsFloat;
  End;

  blnHabilitaScroll := False;
End;


procedure TfrmFatRetornoConsignacao.edtCodClienteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    fValidaCampos(edtCodCliente, True);
  End;
end;

procedure TfrmFatRetornoConsignacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmFatRetornoConsignacao.FormCreate(Sender: TObject);
begin
  inherited;

  cxgConsulta := cxGridConsulta;

  intDecUni := fCfgSis('DECUNI', varInteger);
  blnPostandoPai          := False;
  blnPostandoFilho        := False;
  blnNfeOutrasEntradas    := False;
  blnSempreRelerBanco     := False;
  blnSelecionaComEspaco   := True;
  blnQuoteLista           := False;
  blnMarcaTodos           := False;  
  blnHabilitaScroll       := True;

  lflLastField.intIndCol  := 0;
  lflLastField.strNomCam  := cxGridConsultaViewVENDEDOR.DataBinding.FieldName;
  lflLastField.strNomCol  := cxGridConsultaViewVENDEDOR.Caption;
  lflLastField.ftyTipCam  := ftString;

  qryCadCli               := fCriaQuery(Self);
  qryRevalidar            := fCriaQuery(Self);

  pCriarCdsVenda(Self);
  fatVenda                := TFatVenda.CreateInstance('DV');
  fatVenda.strOpcDocTrue  := 'CR';
  fatVenda.blnVerEstOrc   := False;
  fatVenda.strNomeForm    := 'frmFatVendas';

  cdsAnalitico            := TZClient.Create(Self, fSQLAnalitico);
  cdsAnalitico.IndexFieldNames := 'DET_ESPDOC;DET_NUMDOC';
  cdsAnalitico.AfterPost  := pAfterPostAnalitico;
  cdsAnalitico.BeforePost := pBeforePostAnalitico;
  cdsAnalitico.AfterInsert:= pAfterInsertAnalitico;

  cxGridAnaliticoView.DataController.DataSource := cdsAnalitico.dtsSource;

  pnlEnv.Color := COR_ENV;
  pnlDev.Color := COR_DEV;
  pnlPen.Color := COR_PEN;
  pnlRet.Color := COR_RET;

  pnlEnvTotSin.Color := COR_ENV;
  pnlDevTotSin.Color := COR_DEV;
  pnlPenTotSin.Color := COR_PEN;
  pnlRetTotSin.Color := COR_RET;

  pnlEnvTotAnl.Color := COR_ENV;
  pnlDevTotAnl.Color := COR_DEV;
  pnlPenTotAnl.Color := COR_PEN;
  pnlRetTotAnl.Color := COR_RET;

  objLock := TLock.Create;
  btnCfgFatConsig.Visible := fVerificaAcessoSistema('FRCBOT');

end;

procedure TfrmFatRetornoConsignacao.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(fatVenda);
  FreeAndNil(cdsAnalitico);
  FreeAndNil(qryRevalidar);
end;

procedure TfrmFatRetornoConsignacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of


    VK_RETURN: Begin
                 If ((ActiveControl) = cxGridConsulta) Then
                 Begin
                   If cdsConsulta.State = dsEdit Then
                   Begin
                     cdsConsulta.Post;
                     cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
                   End
                   Else If cdsConsulta.Active And (Not TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDRET')) Then
                   Begin
                     pSetFocus(cxGridConsulta);
                     cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
                   End;
                 End
                 Else If ((ActiveControl) = cxGridAnalitico) Then
                 Begin
                   If cdsAnalitico.State = dsEdit Then
                   Begin
                     cdsAnalitico.Post;
                     cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
                   End
                   Else If cdsAnalitico.Active And  (Not TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDRET')) Then
                   Begin
                     pSetFocus(cxGridAnalitico);
                     cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
                   End;
                 End
                 Else inherited;
               End;

    VK_ESCAPE: If cdsConsulta.State = dsEdit Then
                 cdsConsulta.Cancel
               Else If ((ActiveControl) = mskDtaIni) Then
               Begin
                 pSetFocus(mskDtaIni);
               End
               Else inherited;

    VK_F6 : btnMarcaTodos.Click;

    VK_F7 : btnDesmarcaTodos.Click;

    VK_F10: btnConfirma.Click;

    Else inherited;
  End;

  If (Key in RowMovementKeys) Then
  Begin
    If ((ActiveControl) = cxGridConsulta) Then
    Begin
      If cdsConsulta.State = dsEdit Then
      Begin
        cdsConsulta.Post;
        cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
      End
      Else If cdsConsulta.Active And (Not TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDRET')) Then
      Begin
        cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
      End;
    End
    Else If ((ActiveControl) = cxGridAnalitico) Then
    Begin
      If cdsAnalitico.State = dsEdit Then
      Begin
        cdsAnalitico.Post;
        cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
      End
      Else If cdsAnalitico.Active And  (Not TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDRET')) Then
      Begin
        cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
      End;
    End;
  End;
end;

procedure TfrmFatRetornoConsignacao.FormShow(Sender: TObject);
begin
  inherited;
  TCfgColExpRetornoConsig.pIniciar(cxGridConsulta,cxGridConsultaView);
  TCfgColExpRetornoConsig.pIniciarAnalit(cxGridAnalitico,cxGridAnaliticoView);

  Self.WindowState := wsMaximized;
end;

function TfrmFatRetornoConsignacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      mskDtaFin.Clear;
      mskDtaFin.Enabled := Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text));

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End
      End;

    End

    Else If (Sender = edtCodCliente) Then
    Begin

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := FALSE;
      End

      Else
      Begin
        pCarregaCliente;
        If fEmptyStr(edtDesCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
          Result := FALSE;
        End

        Else fAbreConsulta(TRUE);

        if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) then
        Begin
          pSetFocus(cxGridConsulta);
          cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
        End;

      End

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatRetornoConsignacao.mskDtaIniEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;
  cdsAnalitico.Close;  

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtDesCliente.Clear;
end;

procedure TfrmFatRetornoConsignacao.pAfterInsertAnalitico(DataSet: TDataSet);
begin
  If (Not blnPodeIncluir) And (cdsAnalitico.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatRetornoConsignacao.pAfterPostAnalitico(DataSet: TDataSet);
  Var
    fltQtdRet : Double;
    strNumDoc,
    strEspDoc,
    strCodEmp : String;
begin

  //Filho
  If (Not blnPostandoPai) Then
  Begin
    blnPostandoFilho := True;
    Try
      strNumDoc := cdsAnalitico.FieldByName('DET_NUMDOC').AsString;
      strEspDoc := cdsAnalitico.FieldByName('DET_ESPDOC').AsString;
      strCodEmp := cdsAnalitico.FieldByName('DET_CODEMP').AsString;

      fltQtdRet := 0;
      With cdsAnalitico do
      Begin
        First;
        While Not Eof Do
        Begin
          fltQtdRet := fltQtdRet + FieldByName('DET_QTDRET').AsFloat;
          Next;
        End;

        Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP', VarArrayOf([strNumDoc,strEspDoc,strCodEmp]), []);
      End;

      With cdsConsulta do
      Begin
        Edit;
        FieldByName('DET_QTDRET').AsFloat := fltQtdRet;
        Post;
      End;

      pCalculaTotais;
    Finally
      blnPostandoFilho := False;
      blnHabilitaScroll := True;
    End;
  End;

End;

procedure TfrmFatRetornoConsignacao.pAjustaColunasGrid;
begin
  cxGridConsultaView.BeginUpdate;
  cxGridAnaliticoView.BeginUpdate;
  Try
    cxGridConsultaView.ApplyBestFit;
    cxGridAnaliticoView.ApplyBestFit;
  Finally
    cxGridConsultaView.EndUpdate;
    cxGridAnaliticoView.EndUpdate;
  End;
end;

procedure TfrmFatRetornoConsignacao.pBeforePostAnalitico(DataSet: TDataSet);
begin

  With DataSet Do
  Begin
    If (FieldByName('DET_QTDRET').AsFloat < 0) Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('DET_QTDRET').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else
      FieldByName('DET_VALRET').AsFloat := FieldByName('DET_QTDRET').AsFloat * FieldByName('DET_UNITAR').AsFloat;
  End;

  blnHabilitaScroll := False;
end;

procedure TfrmFatRetornoConsignacao.pCalculaTotais(chrTip: Char='T');
  Var
    cdsDados : TUniClientDataSet;
    fltEnv,
    fltDev,
    fltPen,
    fltRet: Double;

  procedure pSetTotais(chrTip: Char);
  begin
    If chrTip = 'A' Then
    Begin
      pnlEnvTotAnl.Caption := FormatFloat('#,##0.00', fltEnv);
      pnlDevTotAnl.Caption := FormatFloat('#,##0.00', fltDev);
      pnlPenTotAnl.Caption := FormatFloat('#,##0.00', fltPen);
      pnlRetTotAnl.Caption := FormatFloat('#,##0.00', fltRet);
    End
    Else
    Begin
      pnlEnvTotSin.Caption := FormatFloat('#,##0.00', fltEnv);;
      pnlDevTotSin.Caption := FormatFloat('#,##0.00', fltDev);;
      pnlPenTotSin.Caption := FormatFloat('#,##0.00', fltPen);;
      pnlRetTotSin.Caption := FormatFloat('#,##0.00', fltRet);;
    End
  end;

  procedure pZera;
  begin
    fltEnv := 0;
    fltDev := 0;
    fltPen := 0;
    fltRet := 0;
  end;

begin
  If (CharInSet(chrTip, ['T','S'])) Then
  Begin
    pZera;
    cdsDados := TUniClientDataSet.Create(Self);
    Try
      If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
      Begin
        pCloneDataSet(cdsDados, cdsConsulta);
        With cdsDados Do
        Begin
           First;
           While Not Eof Do
           Begin
             fltEnv := fltEnv + FieldByName('DET_TOTITE').AsFloat;
             fltDev := fltDev + FieldByName('DET_TOTFAT').AsFloat + FieldByName('DET_VLRJAF').AsFloat;
             fltPen := fltPen + FieldByName('DET_TOTPEN').AsFloat;
             fltRet := fltRet + FieldByName('DET_VALRET').AsFloat;
             Next;
           End;
        End;
      End;
    Finally
      pSetTotais('S');
      FreeAndNil(cdsDados);
    End;
  End;

  If (CharInSet(chrTip, ['T','A'])) Then
  Begin
    pZera;
    cdsDados := TUniClientDataSet.Create(Self);
    Try
      If (cdsAnalitico.Active) And (Not cdsAnalitico.IsEmpty) Then
      Begin
        pCloneDataSet(cdsDados, cdsAnalitico);
        cdsDados.Filter := cdsAnalitico.Filter;
        cdsDados.Filtered := True;
        With cdsDados Do
        Begin
           First;
           While Not Eof Do
           Begin
             fltEnv := fltEnv + FieldByName('DET_TOTITE').AsFloat;
             fltDev := fltDev + FieldByName('DET_TOTFAT').AsFloat + FieldByName('DET_VLRJAF').AsFloat;
             fltPen := fltPen + FieldByName('DET_TOTPEN').AsFloat;
             fltRet := fltRet + FieldByName('DET_VALRET').AsFloat;
             Next;
           End;
        End;
      End;
    Finally
      pSetTotais('A');
      FreeAndNil(cdsDados);
    End;
  End;
end;

procedure TfrmFatRetornoConsignacao.pCancelaCdsConsulta;
begin
  blnHabilitaScroll := False;
  cdsConsulta.Cancel;
  blnHabilitaScroll := True;
end;

procedure TfrmFatRetornoConsignacao.pCarregaCliente;
Begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
End;

function TfrmFatRetornoConsignacao.fGetItem(qryGenIte: TUniQuery;
strCodIte: String): Boolean;
  Var
    strSQL: String;
Begin
  Try
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

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      Open;
    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fGetItem]');
    End;

  End;

end;

function TfrmFatRetornoConsignacao.fGetSql(blnLike: Boolean): String;
Begin
  Result := fSQLSintetico;
End;

function TfrmFatRetornoConsignacao.fGetTipoFaturamento(
  fatVenda: TFatVenda): Boolean;
  Var
    arrOpcoes: TOpcoesFaturamentoArray;
    frmFatTipoFaturamento : TfrmFatTipoFaturamento;
Begin
  Result := False;
  SetLength(arrOpcoes, 2);

  arrOpcoes[0].strDesCri := 'Nota Fiscal';
  arrOpcoes[0].strEspDoc := 'NF';
  arrOpcoes[0].strOpcLet := 'N';
  arrOpcoes[0].strMosMen := 'S';

  If not blnNfeOutrasEntradas Then
  Begin
    arrOpcoes[1].strDesCri := 'Retorno de Consignação';
    arrOpcoes[1].strEspDoc := 'CR';
    arrOpcoes[1].strOpcLet := 'R';
    arrOpcoes[1].strMosMen := 'N';
  End;

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat   := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;
      fatVenda.blnRcOutEnt := blnNfeOutrasEntradas;

      If fVerificaSeImpNFAvulsa(fatVenda.strEspDoc, teNaoPermite) Then
        Result := False
      Else
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmFatBaixaEntregaFutura.fGetTipoFaturamento]');
    End;
  End;

  pFreeAndNil(frmFatTipoFaturamento);

  SetLength(arrOpcoes, 0);
end;

Function TfrmFatRetornoConsignacao.fGetDadosConsignacao(fatVenda: TFatVenda): Boolean;
  Var
    frmFatDigDadosConsignacao  : TfrmFatDigDadosConsignacao;
begin
  With fatVenda Do
  Begin
    Try
      pCriarFormularios(TfrmFatDigDadosConsignacao, frmFatDigDadosConsignacao);
      frmFatDigDadosConsignacao.strCodCli      := strCodCli;
      frmFatDigDadosConsignacao.edtEspDoc.Text := strEspDoc;
      frmFatDigDadosConsignacao.showModal;

      If (frmFatDigDadosConsignacao.ModalResult = mrOk) then
      Begin
        dtaDtaEnt := StrToDate(frmFatDigDadosConsignacao.mskDtaEnt.Text);
        dtaDtaOri := StrToDate(frmFatDigDadosConsignacao.mskDtaDoc.Text);
        strNumDoc := fStrZero(frmFatDigDadosConsignacao.edtNumDoc.Text,12);
        strEspDoc := frmFatDigDadosConsignacao.edtEspDoc.Text;
        strSerFsc := frmFatDigDadosConsignacao.edtSerie.Text;
        strEntFat := 'N';
        strOriDoc := 'C';
        Result    := True;
        blnNovoSequencial := False;        
      End
      Else
        Result := False;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;
    pFreeAndNil(frmFatDigDadosConsignacao);
  End;
end;

function TfrmFatRetornoConsignacao.fIncluiItens(fatVenda: TFatVenda): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strNumLot   : String;
    strLotAnt   : String;
    objConsig   : TConsignacoes;
    intPosicao  : Integer;
    strVendedor: String;
Begin
  Try
    qryGenIte := fCriaQuery;

    strVendedor := EmptyStr;

    cdsConsulta.First;

    With cdsConsulta Do
    Begin
      DisableControls;

      fatVenda.fltDesEsp := 0;

      intContador := 0;
      First;

      While Not Eof Do
      Begin
        If FieldByName('DET_QTDRET').AsFloat > 0 Then
        Begin
          strVendedor := cdsConsulta.FieldByName('DET_CODVEN').AsString;

          inc(intContador);

          {**********************************}
          {* Monta matriz com os documentos *}
          {* para salvar na tabela MOVCON   *}
          {**********************************}
          objConsig := TConsignacoes.Create;

          With cdsAnalitico Do
          Begin
            If Not IsEmpty Then
            Begin
              First;
              While Not EOF do
              Begin
                If FieldByName('DET_QTDRET').AsFloat > 0 Then
                Begin
                  SetLength(objConsig.arrConsignacoes, Length(objConsig.arrConsignacoes) + 1);

                  intPosicao := Length(objConsig.arrConsignacoes) - 1;

                  objConsig.arrConsignacoes[intPosicao].strNumDoc         := FieldByName('DET_NUMDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strEspDoc         := FieldByName('DET_ESPDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodIte         := FieldByName('DET_CODITE').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodAca         := FieldByName('DET_CODACA').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodEmp         := FieldByName('DET_CODEMP').AsString;
                  objConsig.arrConsignacoes[intPosicao].fltQtdIte         := FieldByName('DET_QTDRET').AsFloat;
                  objConsig.arrConsignacoes[intPosicao].strAutInc         := FieldByName('AUTOINCREM').AsString;
                  objConsig.arrConsignacoes[intPosicao].tmTipoDeMovimento := tmDevolucaoDefinitiva;

                  fatVenda.strCodVen := strVendedor;
                  fatVenda.strNomVen := fRetNomVendRep(strVendedor);

                End;

                Next;
              End;
            End;
          End;

          strNumLot := FieldByName('DET_NUMLOT').AsString;
          strLotAnt := '';

          fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               'NOR'{FieldByName('DET_IDEPRO').AsString},
                                               FieldByName('ITE_CODGRU').AsString,
                                               FieldByName('DET_CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               FieldByName('DET_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_CODMAR').AsString,
                                               FieldByName('DET_CODFOR').AsString,
                                               FieldByName('DET_REFERE').AsString,
                                               FieldByName('DET_UNIORI').AsFloat,
                                               FieldByName('DET_UNIVIS').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat,
                                               0.0,
                                               FieldByName('DET_DESCON').AsFloat,
                                               FieldByName('DET_QTDRET').AsFloat,
                                               FieldByName('DET_UNITAR').AsFloat*FieldByName('DET_QTDRET').AsFloat,
                                               'E',
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2),
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
                                               fCalculaPrecoVenda(2, fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2), FieldByName('DET_UNITAR').AsFloat, 0, 0, 0, 0, 0),
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               FieldByName('DET_INCPIS').AsString,
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                               '',
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * FieldByName('DET_QTDRET').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               FieldByName('DET_ITECHA').AsString,
                                               FieldByName('DET_ITETIN').AsString,
                                               FieldByName('DET_DESCOR').AsString,
                                               FieldByName('DET_TIPPRE').AsString,
                                               FieldByName('DET_LAZQUA').AsInteger,
                                               FieldByName('DET_TIPEMB').AsString,
                                               0,
                                               0,
                                               FieldByName('DET_PRVTIN').AsFloat,
                                               FieldByName('DET_PRCTIN').AsFloat,
                                               FieldByName('DET_FATTIN').AsFloat,
                                               FieldByName('DET_PROEMB').AsString,
                                               '',
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               FieldByName('DET_PROMOC').AsString,
                                               0,
                                               0,
                                               0,
                                               0,
                                               IIF(fEmptyStr(FieldByName('DET_SEQTIN').AsString), '', '2'),
                                               fatVenda.fRetPerComGrupo(FieldByName('ITE_CODGRU').AsString),
                                               qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                               -1,
                                               0,
                                               '',
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                               qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                               fRetNomMarca(FieldByName('DET_CODMAR').AsString),
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
                                               FieldByName('DET_UNITAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(FieldByName('DET_UNIDAD').AsString),
                                               FieldByName('DET_VOLPRO').AsFloat,
                                               intContador,
                                               '',
                                               FieldByName('DET_CODACA').AsString,
                                               FieldByName('DET_EMPACA').AsString,
                                               (FieldByName('DET_PROACA').AsString = 'S') Or (Not fEmptyStr(FieldByName('DET_CODACA').AsString)),
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
                                               FieldByName('DET_TABPRE').AsString,
                                               qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               0.0,
                                               '',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               FieldByName('DET_QTDRET').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',

                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat * FieldByName('DET_QTDRET').AsFloat, 2),
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               strLotAnt,
                                               strNumLot,
                                               '',
                                               '',
                                               False,
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
                                               FieldByName('ITE_PRECUS').AsFloat,
                                               '',
                                               '',                                               
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * FieldByName('DET_QTDRET').AsFloat,
                                               FieldByName('DET_VAL_RT').AsFloat,
                                               FieldByName('DET_TAXJUR').AsFloat,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               strVendedor,
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
                                               '',
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

          If Not Assigned(fatVenda.dicDocs) Then
            fatVenda.dicDocs := TDicionario.Create;

          fatVenda.dicDocs.AdicionarObjeto(cdsVenda.FieldByName('AUTOINCREM').AsString, objConsig);
        End;

        Next;

      End;

      EnableControls;
      strVendedor := EmptyStr;
    End;

    Result := TRUE;

    FreeAndNil(qryGenIte);

  Except

    On E: Exception Do
    Begin
      Result := False;
			pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fIncluiItens]');
    End;

  End;


end;

function TfrmFatRetornoConsignacao.fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin

  Result := True;

  Try
    blnMarcaTodos := True;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);

    pSetFocus(cxGridConsulta);
  Except
    Result := False;
  End;

end;

function TfrmFatRetornoConsignacao.fAbreConsulta(blnLike: Boolean): Boolean;
Begin

  stlListSelecao.Clear;

  blnHabilitaScroll := False;

  Try
    Result := inherited fAbreConsulta(blnLike);

    If (Result) Then
    Begin
      (cdsConsulta.FieldByName('DET_QTDENV') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTFARE') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTDPEN') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTDRET') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.0000';
      (cdsConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_VALRET') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DEV_QTDDVS') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DEV_VLRDVS') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_QTDJAF') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_VLRJAF') As TFloatField).DisplayFormat := '#,##0.00';

      If Not (cdsConsulta.IsEmpty) Then
      Begin

        pValidaSeOcultaColunaDeLotes;

        With cdsAnalitico Do
        Begin
          Close;
          qryQuery.Close;
          pSetProvider;
          qryQuery.Open;
          pSetaClient(qryQuery);
          Open;

          pnlDocs.Caption := '   ' + IntToStr(RecordCount) +
                             IIF(RecordCount <= 1,' DOCUMENTO ENVIADO',' DOCUMENTOS ENVIADOS');

          (FieldByName('DET_QTDENV') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_QTFARE') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_QTDPEN') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_QTDRET') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.0000';
          (FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_VALRET') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DEV_QTDDVS') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DEV_VLRDVS') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_QTDJAF') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_VLRJAF') As TFloatField).DisplayFormat := '#,##0.00';
        End;
      End
      Else
      Begin
        cdsAnalitico.Close;
        pnlDocs.Caption := '';
      End;

      pCalculaTotais;
    End;

    {APLICANDO ESSE RECURSO E INICIANDO OS GRIDS CONFIGURADOS AQUI TAMBÉM POIS ESTAVA PERDENDO OS FORMATOS
     E AS CONFIGURAÇÕES - KM}
    fExecutarModal(pAjustaColunasGrid, 'Aguarde, ajustando colunas...', '');
  Finally
    blnHabilitaScroll := True;
    //força o evento AfterScroll para filtrar os documentos do primeiro item
    cdsConsultaAfterScroll(cdsConsulta);
  End;
End;

function TfrmFatRetornoConsignacao.fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
begin

  Result := True;

  Try
    blnMarcaTodos := False;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);

    pSetFocus(cxGridConsulta);
  Except
    Result := False;
  End;

end;

function TfrmFatRetornoConsignacao.fExisteItemSelecionado: Boolean;
Var
  blnFilter: Boolean;
  strFilter: String;
begin
  strFilter := cdsConsulta.Filter;
  blnFilter := cdsConsulta.Filtered;

  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'DET_QTDRET > 0';
  cdsConsulta.Filtered := True;

  Result := cdsConsulta.RecordCount > 0;

  cdsConsulta.Filter   := strFilter;
  cdsConsulta.Filtered := blnFilter;
end;

function TfrmFatRetornoConsignacao.fSetParametros: Boolean;
  Var
    strClaEnv : String;
Begin
  strClaEnv := fTransform(fCfgSis('ENVCON'), 4);

  With qryConsulta Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
  qryRevalidar.SQL.Text          := AnsiReplaceStr(fSQLAnalitico, cnsAutInc, ' D.AUTOINCREM = :AUTINC AND ');

  With cdsAnalitico.qryQuery Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  With qryRevalidar Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    ParamByName('CLAENV').AsString := strClaEnv;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := edtCodCliente.Text;
  End;

  Result := True;
End;

function TfrmFatRetornoConsignacao.fRetMovConTipD : String;
begin
  Result := '';
  Result := Result + 'SELECT                             ';
  Result := Result + '  M.CON_AUTICS,                    ';
  Result := Result + '  M.CON_NUMDOC,                    ';
  Result := Result + '  M.CON_ESPDOC,                    ';
  Result := Result + '  M.CON_CODEMP,                    ';
  Result := Result + '  M.CON_CODITE,                    ';
  Result := Result + '  M.CON_CODACA,                    ';
  Result := Result + '  M.CON_QTDITE,                    ';
  Result := Result + '  M.CON_DESESP,                    ';
  Result := Result + '  MOVDET.DET_NUMLOT AS CON_NUMLOT  ';
  Result := Result + 'FROM                               ';
  Result := Result + '  MOVCON M                         ';
  Result := Result + 'LEFT JOIN MOVDET ON               ';
  Result := Result + '  M.CON_AUTICS = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE                              ';
  Result := Result + '  M.CON_TIPMOV = "D"               ';
  Result := Result + 'UNION ALL                          ';
  Result := Result + 'SELECT                             ';
  Result := Result + '  N.CON_AUTICS,                    ';
  Result := Result + '  N.CON_NUMDOC,                    ';
  Result := Result + '  N.CON_ESPDOC,                    ';
  Result := Result + '  N.CON_CODEMP,                    ';
  Result := Result + '  N.CON_CODITE,                    ';
  Result := Result + '  N.CON_CODACA,                    ';
  Result := Result + '  N.CON_QTDITE,                    ';
  Result := Result + '  N.CON_DESESP,                    ';
  Result := Result + '  MOVDET.DET_NUMLOT AS CON_NUMLOT  ';
  Result := Result + 'FROM                               ';
  Result := Result + '  NOTCON N                         ';
  Result := Result + 'LEFT JOIN MOVDET ON               ';
  Result := Result + '  N.CON_AUTICS = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE                              ';
  Result := Result + '  N.CON_TIPMOV = "D"               ';
end;

function TfrmFatRetornoConsignacao.fRetMovConTipF : String;
begin
  Result := '';
  Result := Result + 'SELECT                             ';
  Result := Result + '  M.CON_AUTICS,                    ';
  Result := Result + '  M.CON_NUMDOC,                    ';
  Result := Result + '  M.CON_ESPDOC,                    ';
  Result := Result + '  M.CON_CODEMP,                    ';
  Result := Result + '  M.CON_CODITE,                    ';
  Result := Result + '  M.CON_CODACA,                    ';
  Result := Result + '  M.CON_QTDITE,                    ';
  Result := Result + '  MOVDET.DET_NUMLOT AS CON_NUMLOT  ';
  Result := Result + 'FROM                               ';
  Result := Result + '  MOVCON M                         ';
  Result := Result + 'LEFT JOIN MOVDET ON               ';
  Result := Result + '  M.CON_AUTICS = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE                              ';
  Result := Result + '  M.CON_TIPMOV = "F"               ';
  Result := Result + 'UNION ALL                          ';
  Result := Result + 'SELECT                             ';
  Result := Result + '  N.CON_AUTICS,                    ';
  Result := Result + '  N.CON_NUMDOC,                    ';
  Result := Result + '  N.CON_ESPDOC,                    ';
  Result := Result + '  N.CON_CODEMP,                    ';
  Result := Result + '  N.CON_CODITE,                    ';
  Result := Result + '  N.CON_CODACA,                    ';
  Result := Result + '  N.CON_QTDITE,                    ';
  Result := Result + '  MOVDET.DET_NUMLOT AS CON_NUMLOT  ';
  Result := Result + 'FROM                               ';
  Result := Result + '  NOTCON N                         ';
  Result := Result + 'LEFT JOIN MOVDET ON               ';
  Result := Result + '  N.CON_AUTICS = MOVDET.AUTOINCREM ';
  Result := Result + 'WHERE                              ';
  Result := Result + '  N.CON_TIPMOV = "F"               ';
end;

function TfrmFatRetornoConsignacao.fSQLAnalitico: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  D.DET_NUMDOC, ';
  strSQL := strSQL + '  D.DET_ESPDOC, ';
  strSQL := strSQL + '  D.DET_CODEMP, ';  
  strSQL := strSQL + '  D.DET_NUMLOT, ';
  strSQL := strSQL + '  D.DET_IDEPRO, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  D.DET_UNIDAD, ';
  strSQL := strSQL + '  D.DET_CODMAR, ';
  strSQL := strSQL + '  D.DET_CODFOR, ';
  strSQL := strSQL + '  D.DET_REFERE, ';
  strSQL := strSQL + '  T.DET_VAL_RT, ';
  strSQL := strSQL + '  D.DET_UNIORI, ';
  strSQL := strSQL + '  T.DET_UNIVIS, ';
  strSQL := strSQL + '  T.DET_TAXJUR, ';
  strSQL := strSQL + '  0.00 AS DET_DESCON, ';
//  strSQL := strSQL + '  R.CON_DESESP, ';
  strSQL := strSQL + '  D.DET_TOTCUS, ';
  strSQL := strSQL + '  D.DET_INCPIS, ';
  strSQL := strSQL + '  D.DET_ITECHA, ';
  strSQL := strSQL + '  D.DET_ITETIN, ';
  strSQL := strSQL + '  D.DET_DESCOR, ';
  strSQL := strSQL + '  D.DET_TIPPRE, ';
  strSQL := strSQL + '  D.DET_LAZQUA, ';
  strSQL := strSQL + '  D.DET_TIPEMB, ';
  strSQL := strSQL + '  D.DET_PRVTIN, ';
  strSQL := strSQL + '  D.DET_PRCTIN, ';
  strSQL := strSQL + '  D.DET_FATTIN, ';
  strSQL := strSQL + '  D.DET_PROMOC, ';
  strSQL := strSQL + '  D.DET_SEQTIN, ';
  strSQL := strSQL + '  D.DET_VOLPRO, ';
  strSQL := strSQL + '  D.DET_CODACA, ';
  strSQL := strSQL + '  D.DET_EMPACA, ';
  strSQL := strSQL + '  D.DET_PROACA, ';
  strSQL := strSQL + '  D.DET_TABPRE, ';
  strSQL := strSQL + '  D.DET_TOTCU2, ';
  strSQL := strSQL + '  P.ITE_PRECUS, ';
  strSQL := strSQL + '  D.DET_CODITE, ';
  strSQL := strSQL + '  D.DET_DESCRI, ';
  strSQL := strSQL + '  IF(D.DET_CODACA IS NULL, D.DET_DESCRI, CONCAT(D.DET_CODACA, "-", D.DET_DESCRI)) AS DET_DESCRI_, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE), '+ intDecUni.ToString +') AS DET_UNITAR, ';
  strSQL := strSQL + '  IFNULL(D.DET_PROEMB,"N") AS DET_PROEMB, ';

  If blnMarcaTodos Then
  Begin
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(DEVSIM.DEV_SALDVS,0.0) - IFNULL(F.CON_QTDJAF,0.0)) AS DET_QTDRET, ';
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(DEVSIM.DEV_SALDVS,0.0) - IFNULL(F.CON_QTDJAF,0.0)) * D.DET_UNITAR AS DET_VALRET, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDRET, ';
    strSQL := strSQL + '  0.00 AS DET_VALRET, ';
  End;

  strSQL := strSQL + '  IFNULL(R.CON_DESESP,0.0) AS CON_DESESP, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) AS DET_QTDENV, ';
  strSQL := strSQL + '  IFNULL(R.CON_QTDITE,0.0) AS DET_QTFARE, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(DEVSIM.DEV_SALDVS,0.0) - IFNULL(F.CON_QTDJAF,0.0) AS DET_QTDPEN, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * IFNULL(D.DET_QTDITE,0.0) AS DET_TOTITE, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(DEVSIM.DEV_SALDVS,0.0) - IFNULL(F.CON_QTDJAF,0.0)) AS DET_TOTPEN, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * IFNULL(R.CON_QTDITE,0.0) AS DET_TOTFAT, ';
  strSQL := strSQL + '  OPE.OPE_NOMOPE AS NOMVEN, ';
  strSQL := strSQL + '  D.DET_CODVEN, ';
  strSQL := strSQL + '  CONCAT(D.DET_CODVEN, "-", OPE.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '  IFNULL(DEVSIM.DEV_QTDDVS, 0.0) AS DEV_QTDDVS, ';
  strSQL := strSQL + '  IFNULL((ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * DEVSIM.DEV_QTDDVS), 0.0) AS DEV_VLRDVS, ';
  strSQL := strSQL + '  IFNULL(F.CON_QTDJAF,0.0) AS DET_QTDJAF, '+
                     '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * IFNULL(F.CON_QTDJAF,0.0) AS DET_VLRJAF, ';
  strSQL := strSQL + '  M.GER_DTAENT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER P ON P.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  LEFT  JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  LEFT  JOIN (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_CODACA, SUM(CON_QTDITE) AS CON_QTDITE, SUM(CON_DESESP) AS CON_DESESP  '+
                     '              FROM ('+fRetMovConTipD+') AS A '+
                     '              GROUP BY CON_AUTICS, CON_CODITE, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, IFNULL(CON_CODACA, ""), CON_NUMLOT) AS R '+
                     '               ON R.CON_NUMDOC = D.DET_NUMDOC '+
                     '              AND R.CON_ESPDOC = D.DET_ESPDOC '+
                     '              AND R.CON_CODEMP = D.DET_CODEMP '+
                     '              AND R.CON_CODITE = D.DET_CODITE '+
                     '              AND ((R.CON_AUTICS = D.AUTOINCREM) OR R.CON_AUTICS IS NULL) '+
                     '              AND IFNULL(R.CON_CODACA, "") = IFNULL(D.DET_CODACA, "") ';
  strSQL := strSQL + '  LEFT  JOIN (SELECT CON_AUTICS, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, CON_CODACA, SUM(CON_QTDITE) AS CON_QTDJAF  '+
                     '              FROM ('+fRetMovConTipF+') AS A '+
                     '              GROUP BY CON_AUTICS, CON_CODITE, CON_NUMDOC, CON_ESPDOC, CON_CODEMP, CON_CODITE, IFNULL(CON_CODACA, ""), CON_NUMLOT) AS F '+
                     '               ON F.CON_NUMDOC = D.DET_NUMDOC '+
                     '              AND F.CON_ESPDOC = D.DET_ESPDOC '+
                     '              AND F.CON_CODEMP = D.DET_CODEMP '+
                     '              AND F.CON_CODITE = D.DET_CODITE '+
                     '              AND ((F.CON_AUTICS = D.AUTOINCREM) OR F.CON_AUTICS IS NULL) '+
                     '              AND IFNULL(F.CON_CODACA, "") = IFNULL(D.DET_CODACA, "") ';
  strSQL := strSQL + '  LEFT JOIN (SELECT SUM(DEV_QTDITE - DEV_QTDFAT) DEV_SALDVS,  SUM(DEV_QTDITE) DEV_QTDDVS, DEV_SEQENV FROM CONDEV GROUP BY DEV_SEQENV) DEVSIM '+
                     '         ON DEVSIM.DEV_SEQENV = D.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';
  strSQL := strSQL + 'LEFT JOIN CADOPE OPE ON D.DET_CODVEN = OPE.OPE_CODOPE ';
  strSQL := strSQL + 'INNER JOIN MOVGER M ON M.AUTOINCREM  = D.DET_SEQGER ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + cnsAutInc;

  strSQL := strSQL + '  ((D.DET_ESPDOC = "NF" AND ';
  strSQL := strSQL + '    LOCATE(D.DET_CLAFIS,:CLAENV) > 0) OR (D.DET_ESPDOC = "CS")) AND ';

  strSQL := strSQL + ' D.DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + ' D.DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' P.ITE_CODEMP = :CODEMP ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '    AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' AND (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(DEVSIM.DEV_SALDVS,0.0) - IFNULL(F.CON_QTDJAF,0.0)) > 0.0 ';
  strSQL := strSQL + ' AND IFNULL(D.DET_PROEMB, "N") <> "S" ';
  strSQL := strSQL + ' ORDER BY D.DET_NUMDOC ';

  Result := strSQL
end;

function TfrmFatRetornoConsignacao.fSQLSintetico: String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  fExecutaSQL('SET @AUTOINCREM := 0;');

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  lPAD(@AUTOINCREM := @AUTOINCREM + 1,20,"0") AS AUTOINCREM, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  DET_CODFOR, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_VAL_RT, ';
  strSQL := strSQL + '  DET_UNIORI, ';
  strSQL := strSQL + '  DET_UNIVIS, ';
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  SUM(CON_DESESP) AS DET_DESBAI, ';
  strSQL := strSQL + '  DET_TOTCUS, ';
  strSQL := strSQL + '  DET_INCPIS, ';
  strSQL := strSQL + '  DET_ITECHA, ';
  strSQL := strSQL + '  DET_ITETIN, ';
  strSQL := strSQL + '  DET_DESCOR, ';
  strSQL := strSQL + '  DET_TIPPRE, ';
  strSQL := strSQL + '  DET_LAZQUA, ';
  strSQL := strSQL + '  DET_TIPEMB, ';
  strSQL := strSQL + '  DET_PRVTIN, ';
  strSQL := strSQL + '  DET_PRCTIN, ';
  strSQL := strSQL + '  DET_FATTIN, ';
  strSQL := strSQL + '  DET_PROMOC, ';
  strSQL := strSQL + '  DET_SEQTIN, ';
  strSQL := strSQL + '  DET_VOLPRO, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_PROACA, ';
  strSQL := strSQL + '  DET_TABPRE, ';
  strSQL := strSQL + '  DET_TOTCU2, ';
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_DESCRI_,';
  strSQL := strSQL + '  DET_PROEMB, ';

  If blnMarcaTodos Then
  Begin
    strSQL := strSQL + '  SUM(DET_QTDRET) AS DET_QTDRET, ';
    strSQL := strSQL + '  SUM(DET_QTDRET) * (DET_UNITAR) AS DET_VALRET, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDRET, ';
    strSQL := strSQL + '  0.00 AS DET_VALRET, ';
  End;

  strSQL := strSQL + '  SUM(DET_QTDENV) AS DET_QTDENV, ';
  strSQL := strSQL + '  SUM(DET_QTFARE) AS DET_QTFARE, ';
  strSQL := strSQL + '  SUM(DET_QTDPEN) AS DET_QTDPEN, ';
  strSQL := strSQL + '  SUM(DET_TOTITE) AS DET_TOTITE, ';
  strSQL := strSQL + '  SUM(DET_TOTFAT) AS DET_TOTFAT, ';
  strSQL := strSQL + '  SUM(DET_TOTPEN) AS DET_TOTPEN, ';
  strSQL := strSQL + '  NOMVEN,  ';
  strSQL := strSQL + '  DET_CODVEN, ';
  strSQL := strSQL + '  VENDEDOR, ';
  strSQL := strSQL + '  SUM(DEV_QTDDVS) AS DEV_QTDDVS, '+
                     '  SUM(DEV_VLRDVS) AS DEV_VLRDVS, '+
                     '  SUM(DET_QTDJAF) AS DET_QTDJAF, '+
                     '  SUM(DET_VLRJAF) AS DET_VLRJAF  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '   ( ' + fSQLAnalitico + ' ) AS A ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  A.DET_CODITE, A.DET_CODACA, A.DET_UNIDAD, A.DET_UNITAR, NOMVEN, A.DET_NUMLOT ';
  strSQL := strSQL + 'HAVING SUM(IFNULL(DET_QTDPEN,0.0)) > 0.0 ';

  Result := strSQL;
end;

procedure TfrmFatRetornoConsignacao.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  fatVenda.fltDesAce := 0.00;
  blnPostandoPai   := False;
  blnPostandoFilho := False;
End;

procedure TfrmFatRetornoConsignacao.pPreencheMatrizConsignacao;
var
  arrValidacao: Array of String;
  intIndice: integer;
begin
  cdsConsulta.First;
  SetLength(arrValidacao, 0);
  SetLength(fatVenda.arrDocConsignacao, 0);

  while not cdsConsulta.Eof do
  begin
    if cdsConsulta.FieldByName('DET_QTDRET').AsFloat > 0 then
    begin
      cdsAnalitico.First;
      while not cdsAnalitico.Eof do
      begin
        if (cdsAnalitico.FieldByName('DET_QTDRET').AsFloat > 0) then
        begin
          intIndice := AnsiIndexText(cdsAnalitico.FieldByName('DET_NUMDOC').AsString, arrValidacao);
          if (intIndice < 0) then
          begin
            SetLength(arrValidacao, Length(arrValidacao) + 1);
            SetLength(fatVenda.arrDocConsignacao, Length(fatVenda.arrDocConsignacao) + 1);
            arrValidacao[Length(arrValidacao)-1] := cdsAnalitico.FieldByName('DET_NUMDOC').AsString;
            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].strNumDup := cdsAnalitico.FieldByName('DET_NUMDOC').AsString;
            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].strEspDoc := cdsAnalitico.FieldByName('DET_ESPDOC').AsString;
            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].strCodEmp := cdsAnalitico.FieldByName('DET_CODEMP').AsString;
            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].fltValDoc := TFaturamentoConsignacao.fGetValorParaBaixaDaDuplicata(cdsAnalitico.FieldByName('AUTOINCREM').AsString,
                                                                                                                                                cdsAnalitico.FieldByName('DET_QTDRET').AsFloat);
            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].intSeqBai := 0;
          end
          else
          begin
            fatVenda.arrDocConsignacao[intIndice].fltValDoc := fatVenda.arrDocConsignacao[intIndice].fltValDoc +
                                                               TFaturamentoConsignacao.fGetValorParaBaixaDaDuplicata(cdsAnalitico.FieldByName('AUTOINCREM').AsString,
                                                                                                                     cdsAnalitico.FieldByName('DET_QTDRET').AsFloat);
          end;
        end;
        cdsAnalitico.Next;
      end;
    end;
    cdsConsulta.Next;
  end;

  cdsConsulta.First;
end;

function TfrmFatRetornoConsignacao.fTravaDocumento: Boolean;
var
  stlDoc: TStringList;
  strChaLck: string;
begin
  stlDoc := TStringList.Create;
  Result := True;
  try
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      if cdsConsulta.FieldByName('DET_QTDRET').AsFloat > 0 then
      begin
        cdsAnalitico.First;
        while not cdsAnalitico.Eof do
        begin
          if (cdsAnalitico.FieldByName('DET_QTDRET').AsFloat > 0) then
          begin
            strChaLck := cdsAnalitico.FieldByName('DET_NUMDOC').AsString + cdsAnalitico.FieldByName('DET_ESPDOC').AsString + cdsAnalitico.FieldByName('DET_CODEMP').AsString + edtCodCliente.Text;
            If (stlDoc.IndexOf(strChaLck) = -1) and
               (not objLock.fLock_Unlock('MOVGER' + strChaLck, True , False)) Then
            begin
              fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock('MOVGER' + strChaLck), ['&Ok']);
              Result := False;
              Exit;
            end
            else
            begin
              stlDoc.Add(strChaLck);
              Result := True;

              if (cdsAnalitico.FieldByName('DET_QTDPEN').AsFloat <> fRetornaQuantidadePendente(cdsAnalitico.FieldByName('AUTOINCREM').AsString)) then
              begin
                fMensagem('ATENÇÃO!', 'Documento '+cdsAnalitico.FieldByName('DET_NUMDOC').AsString+'-'+cdsAnalitico.FieldByName('DET_ESPDOC').AsString+' '+
                                      'teve a quantidade pendente alterada. Recarregue essa tela para visualizar a nova quantidade ou verificar se esse '+
                                      'documento já foi totalmente processado!', ['&Ok']);
                Result := False;
                Exit;
              end;
            end;
          end;
          cdsAnalitico.Next;
        end;
      end;
      cdsConsulta.Next;
    end;
  finally
    cdsConsulta.First;
    FreeAndNil(stlDoc);

    if (Not Result) then
      objLock.pDestravarTodos;
  end;
end;

function TfrmFatRetornoConsignacao.fRetornaQuantidadePendente(const strAutInc: String): Double;
begin
  qryRevalidar.Close;
  qryRevalidar.ParamByName('AUTINC').AsString := strAutInc;
  qryRevalidar.Open;

  Result := qryRevalidar.FieldByName('DET_QTDPEN').AsFloat;
end;

procedure TfrmFatRetornoConsignacao.pZeraTotais;
begin
  pnlEnvTotSin.Caption := '0,00';
  pnlDevTotSin.Caption := '0,00';
  pnlPenTotSin.Caption := '0,00';
  pnlRetTotSin.Caption := '0,00';
  pnlEnvTotAnl.Caption := '0,00';
  pnlDevTotAnl.Caption := '0,00';
  pnlPenTotAnl.Caption := '0,00';
  pnlRetTotAnl.Caption := '0,00';
end;

procedure TfrmFatRetornoConsignacao.btnCfgFatConsigClick(Sender: TObject);
begin
  inherited;
  if btnCfgFatConsig.Visible then
  begin
    If TfrmConfigRetornoConsignacao.fIniciaConfiguracaoRetorno(cdsConsulta, cdsAnalitico) Then
      TFrmGravando.fExecutarModal( pGravarConfiguracoes, 'Aguarde... Gravando Configurações!', '');
  end;
end;


procedure TfrmFatRetornoConsignacao.cxGridAnaliticoViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
end;

procedure TfrmFatRetornoConsignacao.cxGridAnaliticoViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  If (AViewInfo.GridRecord.Selected) And (AViewInfo.Item.Focused) Then
  Begin
    ACanvas.Font.Color  := clWhite;
    ACanvas.Brush.Color := $00FF8B17;
  End
  Else
  Begin
    ACanvas.Font.Color := clBlack;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDENV.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_TOTITE.Index) Then
      ACanvas.Brush.Color := COR_ENV;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTFARE.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_TOTFAT.Index) Then
      ACanvas.Brush.Color := COR_DEV;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDPEN.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_TOTPEN.Index) Then
      ACanvas.Brush.Color := COR_PEN;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDRET.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_VALRET.Index) Then
      ACanvas.Brush.Color := COR_RET;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDEV_QTDDVS.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDEV_VLRDVS.Index) Then
      ACanvas.Brush.Color := COR_DES;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDJAF.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_VLRJAF.Index) Then
      ACanvas.Brush.Color := COR_JAF;
  End;
end;

procedure TfrmFatRetornoConsignacao.cxGridAnaliticoViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;


  Case Key Of
   VK_RETURN : Begin
             If cdsAnalitico.State = dsEdit Then
             Begin
               cdsAnalitico.Post;
               cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
             End
             Else If cdsAnalitico.Active And (Not  TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDRET')) Then
             Begin
               cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
             End;
           End;
  end;


end;

procedure TfrmFatRetornoConsignacao.cxGridAnaliticoViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  If (Key in RowMovementKeys) Then
  Begin
    If cdsAnalitico.State = dsEdit Then
    Begin
      cdsAnalitico.Post;
      cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
    End
    Else If cdsAnalitico.Active And (Not TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDRET')) Then
    Begin
      cdsAnalitico.FieldByName('DET_QTDRET').FocusControl;
    End;
  End;
end;

procedure TfrmFatRetornoConsignacao.cxGridConsultaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
end;

procedure TfrmFatRetornoConsignacao.cxGridConsultaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  If (AViewInfo.GridRecord.Selected) And (AViewInfo.Item.Focused) Then
  Begin
    ACanvas.Font.Color  := clWhite;
    ACanvas.Brush.Color := $00FF8B17;
  End
  Else
  Begin
    ACanvas.Font.Color := clBlack;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDENV.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_TOTITE.Index) Then
      ACanvas.Brush.Color := COR_ENV;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTFARE.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_TOTFAT.Index) Then
      ACanvas.Brush.Color := COR_DEV;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDPEN.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_TOTPEN.Index) Then
      ACanvas.Brush.Color := COR_PEN;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDRET.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_VALRET.Index) Then
      ACanvas.Brush.Color := COR_RET;

    If (AViewInfo.Item.Index = cxGridConsultaViewDEV_QTDDVS.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDEV_VLRDVS.Index) Then
      ACanvas.Brush.Color := COR_DES;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDJAF.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_VLRJAF.Index) Then
      ACanvas.Brush.Color := COR_JAF;
  End;
end;

procedure TfrmFatRetornoConsignacao.cxGridConsultaViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  Case Key Of
   VK_RETURN :
           Begin
             If cdsConsulta.State = dsEdit Then
             Begin
               cdsConsulta.Post;
               cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
             End
             Else If cdsConsulta.Active And (Not  TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDRET')) Then
             Begin
               cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
             End;
           End;
  End;
end;

procedure TfrmFatRetornoConsignacao.cxGridConsultaViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;


  If (Key in RowMovementKeys) Then
  Begin
    If cdsConsulta.State = dsEdit Then
    Begin
      cdsConsulta.Post;
      cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
    End
    Else If cdsConsulta.Active And (Not TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDRET')) Then
    Begin
      cdsConsulta.FieldByName('DET_QTDRET').FocusControl;
    End;
  End;
end;

procedure TfrmFatRetornoConsignacao.pGravarConfiguracoes;
begin
  TCfgColExpRetornoConsig.pCarregarDadosSalvosSintet(cxGridConsultaView);
  TCfgColExpRetornoConsig.pCarregarDadosSalvosAnalit(cxGridAnaliticoView);
end;

procedure TfrmFatRetornoConsignacao.pValidaSeOcultaColunaDeLotes;
var
  cdsItensTmp : TUniClientDataSet;
  blnUtiLotes : Boolean;
begin

  if (cdsConsulta.IsEmpty) then
    Exit;

  blnUtiLotes := False;

  cdsItensTmp := TUniClientDataSet.Create(Self);
  try
    pCloneDataSet(cdsItensTmp, cdsConsulta);
    cdsItensTmp.First;
    while not cdsItensTmp.Eof do
    begin
      if not TCadLot.fItemSemNenhumLoteEmpresa(cdsItensTmp.FieldByName('DET_CODITE').AsString, VS_strCodEmp) then
      begin
        blnUtiLotes := True;
        Break;
      end;
      cdsItensTmp.Next;
    End;

    cxGridConsultaViewDET_NUMLOT.Visible := blnUtiLotes;
    cxGridAnaliticoViewDET_NUMLOT.Visible := blnUtiLotes;

  finally
    FreeAndNil(cdsItensTmp);
  end;
end;


end.

