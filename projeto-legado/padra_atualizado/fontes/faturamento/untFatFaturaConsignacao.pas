unit untFatFaturaConsignacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, StrUtils, Buttons, ExtCtrls,
  untFuncFat,
  BitBtnLockedIncrem, DBGridCitel, DBGrids, untZClient,
  MemDS, DBAccess, frxClass, Datasnap.Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, untConstantes, cxProgressBar, untGravando, Faturamento.Consignacao.Classes,
  untTypesSistema, untFuncoesSimples, untTLock, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxGridDBBandedTableView, untCfgColExpFaturaConsig;

const
  cnsAutInc = ' /*AUTINC*/ ';

type
  TfrmFatFaturaConsignacao = class(TfrmPaiOrdena)
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
    pnlFat: TPanel;
    pnlEnvTotSin: TPanel;
    pnlDevTotSin: TPanel;
    pnlPenTotSin: TPanel;
    pnlFatTotSin: TPanel;
    pnlEnvTotAnl: TPanel;
    pnlDevTotAnl: TPanel;
    pnlPenTotAnl: TPanel;
    pnlFatTotAnl: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    lblRetornoConsignacao: TLabel;
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
    cxGridConsultaViewDET_QTDFAT: TcxGridDBColumn;
    cxGridConsultaViewDET_DESCON: TcxGridDBColumn;
    cxGridConsultaViewDET_VALUNI: TcxGridDBColumn;
    cxGridConsultaViewDET_UNICAL: TcxGridDBColumn;
    cxGridConsultaViewDET_VALFAT: TcxGridDBColumn;
    cxGridConsultaLevel1: TcxGridLevel;
    btnCfgFatConsig: TBitBtnLocked;
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
    cxGridAnaliticoViewDET_QTDFAT: TcxGridDBColumn;
    cxGridAnaliticoViewDET_DESCON: TcxGridDBColumn;
    cxGridAnaliticoViewDET_VALUNI: TcxGridDBColumn;
    cxGridAnaliticoViewDET_UNICAL: TcxGridDBColumn;
    cxGridAnaliticoViewDET_VALFAT: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
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
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCfgFatConsigClick(Sender: TObject);
    procedure cxGridAnaliticoViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridAnaliticoViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridAnaliticoViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxGridAnaliticoViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridConsultaViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxGridConsultaViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridConsultaViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxGridConsultaViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    fatVenda : TFatVenda;
    qryCadCli: TUniQuery;
    qryRevalidar: TUniQuery;
    blnMarcaTodos : Boolean;
    blnHabilitaScroll: Boolean;
    blnPostandoPai   : Boolean;
    blnPostandoFilho : Boolean;
    intDecUni: Integer;

    frmFechamentoVenda: TfrmGravando;

    FblnRealizarRetornoAutomatico : Boolean;
    FObjRetornoConsignacaoBuilder : TRetornoConsignacaoBuilder;

    arrDatas  : TDateArray;
    arrDuplic : TDigDuplicArray;

    objLock: TLock;

    FblnRealizandoFaturamentoViaDevolucaoSimbolica : Boolean;

    FblnFaturado : Boolean;

    procedure pCalculaTotais(chrTip: Char='T');
    procedure pCarregaCliente;
    procedure pInicializaTemporaria;
    function fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;

    Function fGetTipoFaturamento(fatVenda: TFatVenda): Boolean;
    Function fGetCndPagto(fatVenda: TFatVenda): Boolean;
    Function fGetItem(qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fIncluiItens(fatVenda: TFatVenda; AblnRealizandoRetorno : Boolean; AstrEspecieDocumentoAProcessar : String): Boolean;
    function fSQLSintetico: String;
    function fSQLAnalitico: String;

    procedure pAfterPostAnalitico(DataSet: TDataSet);
    procedure pBeforePostAnalitico(DataSet: TDataSet);
    procedure pAfterInsertAnalitico(DataSet: TDataSet);
    function fValidaCliente(strCodCli: String): Boolean;
    function fPedeDadosFiscais: Boolean;

    function fMarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure pPreencheMatrizConsignacao(AblnRealizandoRetorno : Boolean; AstrEspecieDocumentoAProcessar : String);
    procedure pZeraTotais;
    procedure pFocusControl(DataSet: TDataSet);

    function fValorMinimoValido(DataSet: TDataSet): Boolean;
    function fValorMinimoValidoConsulta: Boolean;
    function fValorMinimoValidoAnalitico: Boolean;

    function fProcessaDocumento(AblnRealizandoRetorno: Boolean; AstrEspecieDocumentoAProcessar: String = ''; AstrCodCli: String = ''): Boolean;
    function fGetLiberacaoParaAbortarProcesso : Boolean;
    function fGetFormasPagamento : Boolean;
    function fTravaDocumento: Boolean;
    function fRetornaQuantidadePendente(const strAutInc: String): Double;
    procedure pGravarConfiguracoes;
    procedure pTratarExibicaoCampos(blnInicio : Boolean);
    procedure pAjustaColunasGrid;
    procedure pCancelaCdsConsulta;
    function fVerificaCodFpg(strCodFpg : String) : Boolean;

    procedure pValidaSeOcultaColunaDeLotes;
    procedure pCarregaChaveReferenciada;
    function fExiteChaveReferenciada(strChvRef: String): Boolean;
    function fRetFilter : String;
    function fRetMovConTipD : String;
    function fRetMovConTipF: String;
    function fSelecionaNovoClienteFat(Out strCodCli: String): Boolean;
    function fSelecionouApenasEspecieCS: Boolean;
  public
    { Public declarations }
    cdsAnalitico: TZClient;

    procedure pAbreConsultaPorAcessoExterno;

    property blnRealizandoFaturamentoViaDevolucaoSimbolica : Boolean read FblnRealizandoFaturamentoViaDevolucaoSimbolica write FblnRealizandoFaturamentoViaDevolucaoSimbolica;
    property blnFaturado                                   : Boolean read FblnFaturado                                   write FblnFaturado;

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
  COR_FAT = $00A8D3FF;
  COR_CAL = $00FFFF9B;
  COR_DES = clLtGray;
  COR_JAF = 16768959;

const
  RowMovementKeys = [VK_UP, VK_PRIOR, VK_DOWN, VK_LEFT, VK_RIGHT, VK_NEXT, VK_HOME, VK_END];
  

implementation

uses untFatTipoFaturamento, untDigCndPagamento,
     untConsultas, untPesqAux, untFuncoes, untFuncFatTypes,
     untFatDadosFiscais, untFatFormasPagamento, untDuplicatas, untLiberacao,
     untMsgLiberacao, untFuncoesGenerica, untcxGridDBBandedTableViewHelper, untFuncFatTelasHelper,
     untConfigFaturaConsignacao, untCadLote, untFatTrocaCliente;

{$R *.dfm}

function TfrmFatFaturaConsignacao.fConfirma(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    LblnRealizandoRetorno : Boolean;
    LIdx : Integer;
    LstrEspecieDocumentoAProcessar : String;
    LstrMensagem : String;
    LstrCodCli : String;
begin

  Result := True;

  pnlHeader.Enabled := False;
  cdsConsulta.DisableControls;

  Try

    Try

      If (Not fValidaCliente(edtCodCliente.Text)) Then
      Begin
        pSetFocus(edtCodCliente);
        Exit(False);
      End;

      If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há dados para confirmar!', ['&OK']);
        Exit(False);
      End;

      if not fTravaDocumento then
      begin
        Exit(False);
      end;

      If Assigned(frmFechamentoVenda) Then
      Begin
        pProgresso (0, 0, frmFechamentoVenda.pgbStatus);
        pInformacao('Aguarde, realizando fechamento do retorno...', frmFechamentoVenda.pgbStatus);
      End;

      fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);

      FblnRealizarRetornoAutomatico := (fCfgSis('RETACS', varBoolean)) And
                                       ((fatVenda.intCgcCpf = 2) or ((fatVenda.intCgcCpf = 1) and fEmptyStr(fatVenda.strCliIes))) And
                                       (not FblnRealizandoFaturamentoViaDevolucaoSimbolica);

      LstrCodCli := edtCodCliente.Text;

      If fCfgSis('TRCLCS', varBoolean) Then
      Begin
        If Not fSelecionaNovoClienteFat(LstrCodCli) Then
          Exit(False);

        If (LstrCodCli <> edtCodCliente.Text) And (Not fSelecionouApenasEspecieCS) Then
        Begin
          pMensagemOk('Não é permitido a troca de cliente para consignação enviada com espécie "NF"!');
          Exit(False);
        End;
      End;

      try
        if FblnRealizarRetornoAutomatico then
        Begin
          for LIdx := 1 to 3 do
          Begin
            fatVEnda.objFatVendaImp.pLimparDocumentos;

            if LIdx = 1 then
            Begin
              LblnRealizandoRetorno          := True;
              LstrEspecieDocumentoAProcessar := 'CS';
            End
            Else
            if LIdx = 2 then
            Begin
              LblnRealizandoRetorno          := True;
              LstrEspecieDocumentoAProcessar := 'NF';
            End
            Else
            Begin
              LblnRealizandoRetorno          := False;
              LstrEspecieDocumentoAProcessar := '';
            End;

            if not fProcessaDocumento(LblnRealizandoRetorno, LstrEspecieDocumentoAProcessar, LstrCodCli) then
            Begin
              pInicializaTemporaria;
              Exit(False);
            End;
          End;
        End
        Else
        Begin
          if not fProcessaDocumento(False, '', LstrCodCli) then
          Begin
            pInicializaTemporaria;
            Exit(False);
          End;
        End;

        if FblnRealizarRetornoAutomatico then
        Begin
          if not FObjRetornoConsignacaoBuilder.fSalvar(LstrMensagem) then
          Begin
            fMensagem('', 'Erro ao salvar o retorno automático da consignação: '+LstrMensagem, ['&OK']);
            pInicializaTemporaria;
            Exit(False);
          End;
        End;

      finally
        fatVenda.strOpcDocTrue := 'FC';
      end;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatBaixaPedidoDev.fConfirma]');
        pInicializaTemporaria;
        pZeraTotais;
      End;
    End;

  Finally
    pnlHeader.Enabled := True;
    cdsConsulta.EnableControls;
    objLock.pDestravarTodos;
    pCalculaTotais;
    pZeraTotais;
  End;


end;

procedure TfrmFatFaturaConsignacao.btnCfgFatConsigClick(Sender: TObject);
begin
  inherited;
  if btnCfgFatConsig.Visible then
  begin
    If TfrmConfigFaturaConsignacao.fIniciaConfiguracaoFatura(cdsConsulta, cdsAnalitico) Then
      TFrmGravando.fExecutarModal( pGravarConfiguracoes, 'Aguarde... Gravando Configurações!', '');
  end;
end;

procedure TfrmFatFaturaConsignacao.btnConfirmaClick(Sender: TObject);
begin

  inherited;

  Try
    FblnFaturado := False;

    pCriarFormularios(TfrmGravando, frmFechamentoVenda);
    frmFechamentoVenda.strChave      := 'FATFATURA';
    frmFechamentoVenda.fExecutarAcao := fConfirma;
    frmFechamentoVenda.ShowModal;

    If (frmFechamentoVenda.blnConfirma) Then
    Begin
      pMensagemOk('Operação realizada com sucesso!');
      pSetFocus(mskDtaIni);
      lblRetornoConsignacao.Caption := '';
      FblnFaturado := True;
    End
    Else
    Begin
      pMensagemOk('Operação interrompida!');
      pSetFocus(mskDtaIni);
      lblRetornoConsignacao.Caption := '';
    End;

    FObjRetornoConsignacaoBuilder.pLimparLista;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If Assigned(frmFechamentoVenda) Then
    pFreeAndNil(frmFechamentoVenda);

end;

procedure TfrmFatFaturaConsignacao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;

  If Not btnDesmarcaTodos.Visible Then
    Exit;

  Try

    pCriarFormularios(TfrmGravando,frmGravando);

    Try

      frmGravando.strChave            := 'FATFATURA_DESMARCATODOS';
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

procedure TfrmFatFaturaConsignacao.btnMarcaTodosClick(Sender: TObject);
begin

  inherited;

  If Not btnMarcaTodos.Visible Then
    Exit;

  Try

    pCriarFormularios(TfrmGravando,frmGravando);

    Try

      frmGravando.strChave            := 'FATFATURA_MARCATODOS';
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

procedure TfrmFatFaturaConsignacao.cdsConsultaAfterPost(DataSet: TDataSet);
  Var
    fltQtdRes : Double;
begin
  inherited;

  //Pai
  If (Not blnPostandoFilho) Then
  Begin
    blnPostandoPai := True;
    Try
      fltQtdRes := cdsConsulta.FieldByName('DET_QTDFAT').AsFloat;

      Try
        With cdsAnalitico do
        Begin
          {**************************************************}
          {* LIMPA A QTDE FATURADA EM TODOS OS DOCUMENTOS   *}
          {* RELACIONADOS AO PRODUTO SELECIONADO.           *}
          {***********************************************MM*}
          First;
          While Not EOF Do
          Begin
            Edit;
            FieldByName('DET_QTDFAT').AsFloat := 0;
            Post;
            Next;
          End;

          {**********************************************}
          {* RATEIA A QUANTIDADE DE PRODUTOS FATURADOS  *}
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
                FieldByName('DET_QTDFAT').AsFloat := FieldByName('DET_QTDPEN').AsFloat;
                fltQtdRes                         := fltQtdRes - FieldByName('DET_QTDPEN').AsFloat;
              End
              Else
              Begin
                FieldByName('DET_QTDFAT').AsFloat := fltQtdRes;
                fltQtdRes                         := 0;
              End;

              if fCfgSis('VALFMC', varBoolean) then
              begin
                If FieldByName('DET_QTDFAT').AsFloat > 0 Then
                Begin
                  cdsAnalitico.FieldByName('DET_DESCON').AsFloat := cdsConsulta.FieldByName('DET_DESCON').AsFloat;
                  cdsAnalitico.FieldByName('DET_VALUNI').AsFloat := cdsConsulta.FieldByName('DET_VALUNI').AsFloat;
                End;
              end;

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
          pMensagensErro(E.Message,'TfrmFatFaturaConsignacao.cdsConsultaAfterPost');
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

function TfrmFatFaturaConsignacao.fRetFilter : String;
begin
  Result := 'DET_CODITE = ' + QuotedStr(cdsConsulta.FieldByName('DET_CODITE').AsString) + ' AND ' +
            'DET_UNITAR = ' + cdsConsulta.FieldByName('DET_UNITAR').AsString + ' AND ' +
            'VENDEDOR = ' + QuotedStr(cdsConsulta.FieldByName('VENDEDOR').AsString);

  If Not TCadLot.fItemSemNenhumLoteEmpresa(cdsConsulta.FieldByName('DET_CODITE').AsString, VS_strCodEmp) Then
    Result := Result + ' AND DET_NUMLOT = ' + QuotedStr(cdsConsulta.FieldByName('DET_NUMLOT').AsString);

  If Not fEmptyStr(cdsConsulta.FieldByName('DET_CODACA').AsString) Then
    Result := Result + ' AND DET_CODACA = ' + QuotedStr(cdsConsulta.FieldByName('DET_CODACA').AsString);
end;

procedure TfrmFatFaturaConsignacao.cdsConsultaAfterScroll(DataSet: TDataSet);
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

    If blnMarcaTodos Then
      Exit;

    If Not (cdsAnalitico.IsEmpty) Then
      pnlDocs.Caption := '   ' + IntToStr(cdsAnalitico.RecordCount) +
                         IIF(cdsAnalitico.RecordCount <= 1,' DOCUMENTO ENVIADO',' DOCUMENTOS ENVIADOS');

    pCalculaTotais('A');
  End;
end;

procedure TfrmFatFaturaConsignacao.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If (FieldByName('DET_QTDFAT').AsFloat < 0) Then
    Begin
      pFocusControl(cdsConsulta);
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      pCancelaCdsConsulta;
      Abort;
    End
    Else If (FieldByName('DET_QTDFAT').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      pFocusControl(cdsConsulta);
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      pCancelaCdsConsulta;
      Abort;
    End
    Else If (FieldByName('DET_DESCON').AsFloat > 100) Then
    Begin
      pFocusControl(cdsConsulta);
      fMensagem('ATENÇÃO!', 'A porcentagem de desconto não pode ser maior que 100!', ['&Ok']);
      pCancelaCdsConsulta;
      Abort;
    End
    Else If (Not fValorMinimoValidoConsulta) Then
    Begin
      pFocusControl(cdsConsulta);
      pCancelaCdsConsulta;
      Abort;
    End
    Else
    Begin
      if fCfgSis('VALFMC', varBoolean) then
      Begin
        If (Not blnPostandoFilho) Then
        Begin
          FieldByName('DET_UNICAL').AsFloat := (FieldByName('DET_VALUNI').AsFloat * (1-FieldByName('DET_DESCON').AsFloat/100));
          FieldByName('DET_VALFAT').AsFloat := fFormataFloat(FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNICAL').AsFloat, intDecUni);
        End;
      End
      Else
      Begin
        FieldByName('DET_VALFAT').AsFloat := (FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNITAR').AsFloat);
      End;
    End;
  End;

  blnHabilitaScroll := False;
End;

procedure TfrmFatFaturaConsignacao.cxGridAnaliticoViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (Not cdsAnalitico.Active) Then
    Exit;

  pFocusControl(cdsAnalitico);
end;

procedure TfrmFatFaturaConsignacao.cxGridAnaliticoViewCustomDrawCell(
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

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDFAT.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_VALFAT.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_DESCON.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_VALUNI.Index) Then
      ACanvas.Brush.Color := COR_FAT;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_UNICAL.Index) Then
      ACanvas.Brush.Color := COR_CAL;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDEV_QTDDVS.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDEV_VLRDVS.Index) Then
      ACanvas.Brush.Color := COR_DES;

    If (AViewInfo.Item.Index = cxGridAnaliticoViewDET_QTDJAF.Index) Or
       (AViewInfo.Item.Index = cxGridAnaliticoViewDET_VLRJAF.Index) Then
      ACanvas.Brush.Color := COR_JAF;
  End;
end;

procedure TfrmFatFaturaConsignacao.cxGridAnaliticoViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
   VK_RETURN : Begin
             If cdsAnalitico.State = dsEdit Then
             Begin
               cdsAnalitico.Post;
               pFocusControl(cdsConsulta);
             End
             Else If cdsAnalitico.Active And (Not  TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDFAT')) Then
             Begin
               pFocusControl(cdsConsulta);
             End;
           End;
  end;
end;

procedure TfrmFatFaturaConsignacao.cxGridAnaliticoViewKeyUp(Sender: TObject;
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
      pFocusControl(cdsAnalitico);
    End
    Else If cdsAnalitico.Active And (Not TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDRET')) Then
    Begin
      pFocusControl(cdsAnalitico);
    End;
  End;
end;

procedure TfrmFatFaturaConsignacao.cxGridConsultaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (Not cdsConsulta.Active) Then
    Exit;

  pFocusControl(cdsConsulta);
end;

procedure TfrmFatFaturaConsignacao.cxGridConsultaViewCustomDrawCell(
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

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDFAT.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_VALFAT.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_DESCON.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_VALUNI.Index) Then
      ACanvas.Brush.Color := COR_FAT;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_UNICAL.Index) Then
      ACanvas.Brush.Color := COR_CAL;

    If (AViewInfo.Item.Index = cxGridConsultaViewDEV_QTDDVS.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDEV_VLRDVS.Index) Then
      ACanvas.Brush.Color := COR_DES;

    If (AViewInfo.Item.Index = cxGridConsultaViewDET_QTDJAF.Index) Or
       (AViewInfo.Item.Index = cxGridConsultaViewDET_VLRJAF.Index) Then
      ACanvas.Brush.Color := COR_JAF;
  End;
end;

procedure TfrmFatFaturaConsignacao.cxGridConsultaViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
   VK_RETURN : Begin
             If cdsConsulta.State = dsEdit Then
             Begin
               cdsConsulta.Post;
               pFocusControl(cdsConsulta);
             End
             Else If cdsConsulta.Active And (Not  TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDFAT')) Then
             Begin
               pFocusControl(cdsConsulta);
             End;
           End;
  end;
end;

procedure TfrmFatFaturaConsignacao.cxGridConsultaViewKeyUp(Sender: TObject;
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
      pFocusControl(cdsConsulta);
    End
    Else If cdsConsulta.Active And (Not TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDFAT')) Then
    Begin
      pFocusControl(cdsConsulta);
    End;
  End;

end;

procedure TfrmFatFaturaConsignacao.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    fValidaCampos(edtCodCliente, True);
  End;
end;

procedure TfrmFatFaturaConsignacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmFatFaturaConsignacao.FormCreate(Sender: TObject);
begin
  inherited;

  cxgConsulta := cxGridConsulta;

  intDecUni := fCfgSis('DECUNI', varInteger);
  blnPostandoPai          := False;
  blnPostandoFilho        := False;
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

  fatVenda                := TFatVenda.CreateInstance('VN');
  fatVenda.strOpcDocTrue  := 'FC';
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
  pnlFat.Color := COR_FAT;

  pnlEnvTotSin.Color := COR_ENV;
  pnlDevTotSin.Color := COR_DEV;
  pnlPenTotSin.Color := COR_PEN;
  pnlFatTotSin.Color := COR_FAT;

  pnlEnvTotAnl.Color := COR_ENV;
  pnlDevTotAnl.Color := COR_DEV;
  pnlPenTotAnl.Color := COR_PEN;
  pnlFatTotAnl.Color := COR_FAT;

  FObjRetornoConsignacaoBuilder := TRetornoConsignacaoBuilder.Create;

  objLock := TLock.Create;

  FblnRealizandoFaturamentoViaDevolucaoSimbolica := False;
  FblnFaturado                                   := False;
  btnCfgFatConsig.Visible := fVerificaAcessoSistema('FRCBOT');

end;

procedure TfrmFatFaturaConsignacao.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(fatVenda);
  FreeAndNil(cdsAnalitico);
  FreeAndNil(qryRevalidar);
  FreeAndNil(FObjRetornoConsignacaoBuilder);
end;

procedure TfrmFatFaturaConsignacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of

    VK_RETURN: Begin
                 If ((ActiveControl) = cxGridConsulta) Then
                 Begin
                   If cdsConsulta.State = dsEdit Then
                   Begin
                     cdsConsulta.Post;
                     pFocusControl(cdsConsulta);
                   End
                   Else If cdsConsulta.Active And (Not  TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_QTDFAT')) Then
                   Begin
                     pFocusControl(cdsConsulta);
                   End;
                 End
                 Else If ((ActiveControl) = cxGridAnalitico) Then
                 Begin
                   If cdsAnalitico.State = dsEdit Then
                   Begin
                     cdsAnalitico.Post;
                     pFocusControl(cdsConsulta);
                   End
                   Else If cdsAnalitico.Active And (Not TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_QTDFAT')) Then
                   Begin
                     pFocusControl(cdsConsulta);
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
end;

procedure TfrmFatFaturaConsignacao.FormShow(Sender: TObject);
begin
  inherited;
  pTratarExibicaoCampos(True);
  TCfgColExpFaturaConsig.pIniciar(cxGridConsulta,cxGridConsultaView);
  TCfgColExpFaturaConsig.pIniciarAnalit(cxGridAnalitico,cxGridAnaliticoView);
  pTratarExibicaoCampos(False);
  Self.WindowState := wsMaximized;
end;

function TfrmFatFaturaConsignacao.fValidaCampos(Sender: TWinControl;
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

      If fValidaCliente(edtCodCliente.Text) Then
      Begin
        fAbreConsulta(TRUE);

        if (cdsConsulta.Active) and (not cdsConsulta.IsEmpty) then
        begin
          pSetFocus(cxGridConsulta);
          cdsConsulta.FieldByName('DET_QTDFAT').FocusControl;
        end;

        fatVenda.pCarregaDadosClienteBaixa(edtCodCliente.Text);
        FblnRealizarRetornoAutomatico := (fCfgSis('RETACS', varBoolean)) And
                                         ((fatVenda.intCgcCpf = 2) or ((fatVenda.intCgcCpf = 1) and fEmptyStr(fatVenda.strCliIes)));
        if FblnRealizarRetornoAutomatico then
        begin
          lblRetornoConsignacao.Visible := True;
          lblRetornoConsignacao.Caption := 'Faturamento de Consignação para PF/PJ sem IE.'+
          ' Ao finalizar o faturamento, o sistema emitirá o retorno automático para zerar a operação do envio, conforme definido na CFG_RETACS';
        end
        else
        Begin
          lblRetornoConsignacao.Visible := False;
          lblRetornoConsignacao.Caption := '';
        End;


      End
      Else 
      Begin
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatFaturaConsignacao.fValidaCliente(strCodCli: String): Boolean;
begin
  Result := True;

  If fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtDesCliente.Clear;
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
    End;
  End;

  If (Not Result) Then
  Begin
    cdsConsulta.Close;
    cdsAnalitico.Close;
  End;
end;

function TfrmFatFaturaConsignacao.fValorMinimoValido(DataSet: TDataSet): Boolean;
var
  blnLiberouPreco: Boolean;
  strVarCcnAnt: string;
  fltVarValUni: Double;
  fltVarTotGer: Double;
  qryConCit: TUniQuery;
  qryConIte: TUniQuery;

  qryConCitOri: TUniQuery;
  qryConIteOri: TUniQuery;

  VS_strTRVEPROriginal: string;
begin
  strVarCcnAnt := EmptyStr;
  fltVarValUni := DataSet.FieldByName('DET_VALUNI').AsFloat;
  fltVarTotGer := 0;

  qryConIteOri := fatVenda.qryConIte;
  qryConCitOri := fatVenda.qryConCit;

  qryConCit := fCriarQuery('SELECT CADITE.*, BAR_CODBAR, BAR_EMBALA, BAR_PREVEN, BAR_TABPRE, BAR_DESCRI FROM CADITE LEFT JOIN ITEBAR ON BAR_CODITE = ITE_CODITE WHERE FALSE', Self);
  pSetaQueryCadIte(qryConCit);
  qryConIte := fCriarQueryIteGer(Self);
  qryConIte.Close;
  qryConIte.ParamByName('CODITE').AsString := DataSet.FieldByName('DET_CODITE').AsString;
  qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConIte.Open;
  fatVenda.qryConIte := qryConIte;
  fatVenda.qryConCit := qryConCit;
  fatVenda.strTabPre := DataSet.FieldByName('DET_TABPRE').AsString;
  fatVenda.strCliNom := edtDesCliente.Text;

  VS_strTRVEPROriginal := VS_strTRVEPR;
  VS_strTRVEPR := '1';
  blnLiberouPreco := True;
  try
    blnLiberouPreco := fatVenda.fValidaUnitario(fltVarValUni,
                                                fltVarTotGer,
                                                strVarCcnAnt,
                                                DataSet.FieldByName('DET_QTDFAT').AsFloat,
                                                0,
                                                0,
                                                DataSet.FieldByName('DET_UNIORI').AsFloat,
                                                0,
                                                0,
                                                0,
                                                0,
                                                DataSet.FieldByName('DET_DESCON').AsFloat,
                                                0,
                                                0,
                                                DataSet.FieldByName('DET_TOTCUS').AsFloat,
                                                0,
                                                DataSet.FieldByName('DET_TOTITE').AsFloat,
                                                VS_strCodEmp,
                                                DataSet.FieldByName('DET_TABPRE').AsString,
                                                DataSet.FieldByName('DET_CODITE').AsString,
                                                fRetDescricao(DataSet.FieldByName('DET_CODITE').AsString, 'CADITE', 'ITE_CODITE', 'ITE_DESITE'),
                                                DataSet.FieldByName('DET_IDEPRO').AsString,
                                                '',
                                                '',
                                                '',
                                                fatVenda.strPromoc,
                                                'S',
                                                'N',
                                                False,
                                                cdsVenda,
                                                qryConCit,
                                                Nil,
                                                qryConIte,
                                                0,
                                                fRetSiglaUnidadePorCodIte(DataSet.FieldByName('DET_CODITE').AsString),
                                                DataSet.FieldByName('DET_TOTMED').AsFloat);
  finally
    VS_strTRVEPR := VS_strTRVEPROriginal;

    Result  := blnLiberouPreco; 

    FreeAndNil(qryConCit);
    FreeAndNil(qryConIte);
    fatVenda.qryConIte := qryConIteOri;
    fatVenda.qryConCit := qryConCitOri;
  end;
end;

function TfrmFatFaturaConsignacao.fValorMinimoValidoAnalitico: Boolean;
begin
  Result := True;

  If (Not blnPostandoPai) And fCfgSis('VALFMC', varBoolean) and
     ((TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_DESCON') Or
      TcxGridDBBandedTableView(cxGridAnaliticoView).ColumnSelected('DET_VALUNI'))) Then
  Begin
    Result := fValorMinimoValido(cdsAnalitico);
  End;
end;

function TfrmFatFaturaConsignacao.fValorMinimoValidoConsulta: Boolean;
begin
  Result := True;

  If (Not blnPostandoFilho) And fCfgSis('VALFMC', varBoolean) and
     ((TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_DESCON') Or
      TcxGridDBBandedTableView(cxGridConsultaView).ColumnSelected('DET_VALUNI')))  Then
  Begin
    Result := fValorMinimoValido(cdsConsulta);
  End;
end;

function TfrmFatFaturaConsignacao.fVerificaCodFpg(strCodFpg: String): Boolean;
begin
  Result := False;

  if (fatVenda.strCodFpg = '001') then
    Exit(True);

  if (fatVenda.strCodFpg = '007') then
    Exit(True);

  if (fatVenda.strCodFpg = '009') then
    Exit(True);
end;

procedure TfrmFatFaturaConsignacao.mskDtaIniEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;
  cdsAnalitico.Close;  

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCliente.Clear;
  edtDesCliente.Clear;
end;

procedure TfrmFatFaturaConsignacao.pAbreConsultaPorAcessoExterno;
begin
  fAbreConsulta(True);
end;

procedure TfrmFatFaturaConsignacao.pAfterInsertAnalitico(DataSet: TDataSet);
begin
  If (Not blnPodeIncluir) And (cdsAnalitico.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatFaturaConsignacao.pAfterPostAnalitico(DataSet: TDataSet);
  Var
    fltTotValUni,
    fltTotUniCal,
    fltQtdFat : Double;
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodigoVendedor,
    strCodigoItem,
    strCodigoUnidadeMedida,
    strNumLot : String;
    fltValorUnitario : Double;
begin

  //Filho
  If (Not blnPostandoPai) Then
  Begin
    blnPostandoFilho := True;
    Try
      strNumDoc              := cdsAnalitico.FieldByName('DET_NUMDOC').AsString;
      strEspDoc              := cdsAnalitico.FieldByName('DET_ESPDOC').AsString;
      strCodEmp              := cdsAnalitico.FieldByName('DET_CODEMP').AsString;
      strCodigoVendedor      := cdsAnalitico.FieldByName('DET_CODVEN').AsString;
      strCodigoItem          := cdsAnalitico.FieldByName('DET_CODITE').AsString;
      strCodigoUnidadeMedida := cdsAnalitico.FieldByName('DET_UNIDAD').AsString;
      fltValorUnitario       := cdsAnalitico.FieldByName('DET_UNITAR').AsFloat;
      strNumLot              := cdsAnalitico.FieldByName('DET_NUMLOT').AsString;

      fltQtdFat := 0;
      fltTotValUni := 0;
      fltTotUniCal := 0;
      With cdsAnalitico do
      Begin
        First;
        While Not Eof Do
        Begin

          if (strNumDoc              = cdsAnalitico.FieldByName('DET_NUMDOC').AsString) and
             (strEspDoc              = cdsAnalitico.FieldByName('DET_ESPDOC').AsString) and
             (strCodEmp              = cdsAnalitico.FieldByName('DET_CODEMP').AsString) and
             (strCodigoVendedor      = cdsAnalitico.FieldByName('DET_CODVEN').AsString) and
             (strCodigoItem          = cdsAnalitico.FieldByName('DET_CODITE').AsString) and
             (strCodigoUnidadeMedida = cdsAnalitico.FieldByName('DET_UNIDAD').AsString) and
             (fltValorUnitario       = cdsAnalitico.FieldByName('DET_UNITAR').AsFloat) then
          Begin
            fltQtdFat := fltQtdFat + FieldByName('DET_QTDFAT').AsFloat;

            If FieldByName('DET_QTDFAT').AsFloat > 0 Then
            Begin
              fltTotValUni := fltTotValUni + (FieldByName('DET_VALUNI_ORI').AsFloat * FieldByName('DET_QTDFAT').AsFloat);
              fltTotUniCal := fltTotUniCal + (FieldByName('DET_UNICAL').AsFloat * FieldByName('DET_QTDFAT').AsFloat);
            End;
          End;

          Next;
        End;

        Locate('DET_NUMDOC;DET_ESPDOC;DET_CODEMP', VarArrayOf([strNumDoc,strEspDoc,strCodEmp]), []);
      End;

      With cdsConsulta do
      Begin
        if Locate('DET_CODVEN;DET_CODITE;DET_UNITAR;DET_UNIDAD;DET_NUMLOT', VarArrayOf([strCodigoVendedor,strCodigoItem,fltValorUnitario,strCodigoUnidadeMedida, strNumLot]), []) then
        Begin

          Edit;
          FieldByName('DET_QTDFAT').AsFloat := fltQtdFat;

          if fCfgSis('VALFMC', varBoolean) then
          begin
            cdsConsulta.FieldByName('DET_VALUNI').AsFloat := cdsConsulta.FieldByName('DET_VALUNI_ORI').AsFloat;
            cdsConsulta.FieldByName('DET_DESCON').AsFloat := cdsConsulta.FieldByName('DET_DESCON_ORI').AsFloat;
            cdsConsulta.FieldByName('DET_VALFAT').AsFloat := 0;
            cdsConsulta.FieldByName('DET_UNICAL').AsFloat := 0;
            If (fltQtdFat > 0) Then
            Begin
              cdsConsulta.FieldByName('DET_VALUNI').AsFloat := fltTotValUni / fltQtdFat;
              cdsConsulta.FieldByName('DET_DESCON').AsFloat := 100 - (((fltTotUniCal/fltQtdFat) * 100) / cdsConsulta.FieldByName('DET_VALUNI_ORI').AsFloat);
              cdsConsulta.FieldByName('DET_UNICAL').AsFloat := (cdsConsulta.FieldByName('DET_VALUNI').AsFloat * (1-cdsConsulta.FieldByName('DET_DESCON').AsFloat/100));
              cdsConsulta.FieldByName('DET_VALFAT').AsFloat := fFormataFloat(cdsConsulta.FieldByName('DET_QTDFAT').AsFloat * cdsConsulta.FieldByName('DET_UNICAL').AsFloat, intDecUni);
            End;
          end;

          Post;
        End;
      End;

      pCalculaTotais;
    Finally
      blnPostandoFilho := False;
      blnHabilitaScroll := True;
    End;
  End;

End;

procedure TfrmFatFaturaConsignacao.pAjustaColunasGrid;
begin
  cxGridConsultaView.BeginUpdate;
  cxGridAnaliticoView.BeginUpdate;
  Try
    cxGridConsultaView.ApplyBestFit;
    cxGridAnaliticoView.ApplyBestFit;

    TCfgColExpFaturaConsig.pIniciar(cxGridConsulta, cxGridConsultaView);
    TCfgColExpFaturaConsig.pIniciarAnalit(cxGridAnalitico, cxGridAnaliticoView);

    pTratarExibicaoCampos(False);
  Finally
    cxGridConsultaView.EndUpdate;
    cxGridAnaliticoView.EndUpdate;
  End;
end;

procedure TfrmFatFaturaConsignacao.pBeforePostAnalitico(DataSet: TDataSet);
begin
  
  With DataSet Do
  Begin
    If (FieldByName('DET_QTDFAT').AsFloat < 0) Then
    Begin
      pFocusControl(cdsAnalitico);
      fMensagem('ATENÇÃO!', 'Informe uma quantidade maior que zero!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('DET_QTDFAT').AsFloat > FieldByName('DET_QTDPEN').AsFloat) Then
    Begin
      pFocusControl(cdsAnalitico);
      fMensagem('ATENÇÃO!', 'Quantidade informada maior que a quantidade pendente!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else If (FieldByName('DET_DESCON').AsFloat > 100) Then
    Begin
      pFocusControl(cdsAnalitico);
      fMensagem('ATENÇÃO!', 'A porcentagem de desconto não pode ser maior que 100!', ['&Ok']);
      Cancel;
      Abort;
    End
    Else
    If (Not fValorMinimoValidoAnalitico) Then
    Begin
      pFocusControl(cdsAnalitico);
      Cancel;
      Abort;
    End
    Else
    Begin
      if fCfgSis('VALFMC', varBoolean) then
      Begin
        FieldByName('DET_UNICAL').AsFloat := (FieldByName('DET_VALUNI').AsFloat * (1-FieldByName('DET_DESCON').AsFloat/100));
        FieldByName('DET_VALFAT').AsFloat := fFormataFloat(FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNICAL').AsFloat, intDecUni);
      End
      Else
      Begin
        FieldByName('DET_VALFAT').AsFloat := (FieldByName('DET_QTDFAT').AsFloat * FieldByName('DET_UNITAR').AsFloat);
      End;
    End;
  End;

  blnHabilitaScroll := False;
end;

procedure TfrmFatFaturaConsignacao.pCalculaTotais(chrTip: Char='T');
  Var
    cdsDados : TUniClientDataSet;
    fltEnv,
    fltDev,
    fltPen,
    fltFat: Double;

  procedure pSetTotais(chrTip: Char);
  begin
    If chrTip = 'A' Then
    Begin
      pnlEnvTotAnl.Caption := FormatFloat('#,##0.00', fltEnv);
      pnlDevTotAnl.Caption := FormatFloat('#,##0.00', fltDev);
      pnlPenTotAnl.Caption := FormatFloat('#,##0.00', fltPen);
      pnlFatTotAnl.Caption := FormatFloat('#,##0.00', fltFat);
    End
    Else
    Begin
      pnlEnvTotSin.Caption := FormatFloat('#,##0.00', fltEnv);;
      pnlDevTotSin.Caption := FormatFloat('#,##0.00', fltDev);;
      pnlPenTotSin.Caption := FormatFloat('#,##0.00', fltPen);;
      pnlFatTotSin.Caption := FormatFloat('#,##0.00', fltFat);;
    End
  end;

  procedure pZera;
  begin
    fltEnv := 0;
    fltDev := 0;
    fltPen := 0;
    fltFat := 0;
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
             fltFat := fltFat + FieldByName('DET_VALFAT').AsFloat;
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
             fltFat := fltFat + FieldByName('DET_VALFAT').AsFloat;
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

procedure TfrmFatFaturaConsignacao.pCancelaCdsConsulta;
begin
  blnHabilitaScroll := False;
  cdsConsulta.Cancel;
  blnHabilitaScroll := True;
end;

procedure TfrmFatFaturaConsignacao.pCarregaCliente;
Begin
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

  fatVenda.strCodCli := edtCodCliente.Text; // Cliente - Codigo
End;

procedure TfrmFatFaturaConsignacao.pFocusControl(DataSet: TDataSet);
begin
  if not fCfgSis('VALFMC', varBoolean) then
  begin
    If DataSet = cdsConsulta Then
      pSetFocus(cxGridConsulta)
    Else
      pSetFocus(cxGridAnalitico);

    DataSet.FieldByName('DET_QTDFAT').FocusControl;
  end;
end;

function TfrmFatFaturaConsignacao.fGetCndPagto(fatVenda: TFatVenda): Boolean;
  Var
    frmDigCndPagamento : TfrmDigCndPagamento;
begin
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.fraDigCndPagamento.blnCnfDoc         := False;
    frmDigCndPagamento.fraDigCndPagamento.fatVenda          := fatVenda;

    frmDigCndPagamento.fraDigCndPagamento.strCodCli         := fatVenda.strCodCli;

    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text  := fatVenda.strCodCnd;
      frmDigCndPagamento.fraDigCndPagamento.strCcnAnt       := fatVenda.strCodCnd;
    End;

    frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text    := fatVenda.strCodFpg;
    frmDigCndPagamento.fraDigCndPagamento.edtDesForPag.Text := fRetDesFpg(fatVenda.strCodFpg);

    If Not fEmptyStr(fatVenda.strCodCnd) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.pCarregaCondicao;
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
    End;

    frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text := fatVenda.strConPag;

    {*********************************************}
    { CARREGA ESTES DADOS PARA SENHA DE LIBERACAO }
    { PARA ZERAR TAXA DE JUROS                    }
    {******************************************JB*}
    frmDigCndPagamento.fraDigCndPagamento.strCodVen      := fatVenda.strCodVen;
    frmDigCndPagamento.fraDigCndPagamento.strCodDig      := fatVenda.strCodDig;
    frmDigCndPagamento.fraDigCndPagamento.strNTrava      := fatVenda.strNTrava;
    frmDigCndPagamento.fraDigCndPagamento.stlNumLib      := fatVenda.stlNumLib;
    frmDigCndPagamento.fraDigCndPagamento.blnHabZta      := True;

    frmDigCndPagamento.Caption := frmDigCndPagamento.Caption;

    If (fCfgSis('CNDVEN') = 'F')      And
        fCfgSis('USACND', varBoolean) And
        fCfgSis('PFLCLI', varBoolean) Then
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := fatVenda.fRetornaMargemPraticadaDocumento(frmDigCndPagamento.fraDigCndPagamento.blnIgnMar);
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := fatVenda.fltTotGer;
    End
    Else
    Begin
      frmDigCndPagamento.fraDigCndPagamento.fltMarDoc := 0;
      frmDigCndPagamento.fraDigCndPagamento.fltValDoc := 0;
    End;

    frmDigCndPagamento.showModal;

    Result := frmDigCndPagamento.fraDigCndPagamento.blnConfirma;
    If Result Then
    Begin
      fatVenda.strConPag := frmDigCndPagamento.fraDigCndPagamento.mskCndPag.Text;
      fatVenda.strCodCnd := frmDigCndPagamento.fraDigCndPagamento.edtCodCnd.Text;
      fatVenda.strCodFpg := frmDigCndPagamento.fraDigCndPagamento.edtForPag.Text;
      fatVenda.intPrzMed := fFloatToInt(fCalcMediaPagto(fatVenda.strConPag));
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetCndPagto]');
    End;
  End;
end;

function TfrmFatFaturaConsignacao.fGetFormasPagamento: Boolean;
  var
    intContador  : integer;
    arrDuplicFat : TDigDuplicArray;
    arrCartoes   : TCartoesResumoCaixaArray;
    strCndAtu    : string;
    frmFatFormasPagamento : TfrmFatFormasPagamento;
begin
  Try
    pCriarFormularios(TfrmFatFormasPagamento, frmFatFormasPagamento);
    frmFatFormasPagamento.fatVenda     := fatVenda;
    frmFatFormasPagamento.strCodOpe    := fatVenda.strCodDig;
    frmFatFormasPagamento.strCodCnd    := fatVenda.strCodCnd;
    frmFatFormasPagamento.strMskCnd    := fatVenda.strConPag;
              frmFatFormasPagamento.fltValTot    := fatVenda.fltTotGer;
              frmFatFormasPagamento.cdsChqPre    := fatVenda.cdsChequePre;
              frmFatFormasPagamento.cdsChqVis    := fatVenda.cdsChequeVis;
              frmFatFormasPagamento.blnAltBas    := (fUtilizarComoDataBaseCtrDataEmissaoPedido(fatVenda.fFaturandoPedido, fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento));
              If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(fatVenda.fFaturandoPedido)) And (fatVenda.dtaPreVis <> 0) And (VS_Date < fatVenda.dtaPreVis) Then
                frmFatFormasPagamento.dtaDtaEntOri := fatVenda.dtaPreVis
              Else
                frmFatFormasPagamento.dtaDtaEntOri := fatVenda.dtaDtaEntOri;

              {*******************************************}
              {* CASO FOR PARCELADO A VISTA, MOSTRA SO-  *}
    {* MENTE MODALIDADES PARA A VISTA          *}
    {****************************************MV*}
    If (fStatusCndPag(fatVenda.strConPag) = A_VISTA) Then
    Begin
      frmFatFormasPagamento.edtFaturado.ReadOnly := True;
      frmFatFormasPagamento.lblFaturado.Enabled  := False;
    End;

    If fClienteConsumidor(fatVenda.strCliOri, False, True) Then
    Begin
      frmFatFormasPagamento.edtFaturado.ReadOnly := True;
      frmFatFormasPagamento.edtFaturado.Visible := False;
      frmFatFormasPagamento.lblFaturado.Visible := False;
      frmFatFormasPagamento.Height              := 270;
    End;

    frmFatFormasPagamento.edtFinanc.Enabled := Pos(fatVenda.strOpcDoc, 'VN_CS_') > 0;
    frmFatFormasPagamento.lblFinanc.Enabled := Pos(fatVenda.strOpcDoc, 'VN_CS_') > 0;
    frmFatFormasPagamento.blnConsignacao := True;

    {*******************************************}
    {* CASO FOR CARTÃO, MOSTRA SOMENTE MODALI- *}
    {* DADE PARA CARTÃO                        *}
    {****************************************AZ*}
    if (fatVenda.strCodFpg = '007') then
    begin
      frmFatFormasPagamento.edtDinheiro.Enabled := False;
      frmFatFormasPagamento.lblDinheiro.Enabled := False;
      frmFatFormasPagamento.edtChqVista.Enabled := False;
      frmFatFormasPagamento.lblChequeVista.Enabled := False;
      frmFatFormasPagamento.edtChqPre.Enabled := False;
      frmFatFormasPagamento.lblChequePre.Enabled := False;
      frmFatFormasPagamento.edtOrdPag.Enabled := False;
      frmFatFormasPagamento.lblOrdPag.Enabled := False;
      frmFatFormasPagamento.edtFaturado.Enabled := False;
      frmFatFormasPagamento.lblFaturado.Enabled := False;
      frmFatFormasPagamento.edtFinanc.Enabled := False;
      frmFatFormasPagamento.lblFinanc.Enabled := False;
      frmFatFormasPagamento.edtValCre.Enabled := False;
      frmFatFormasPagamento.lblValCre.Enabled := False;
      frmFatFormasPagamento.edtCartao.TabOrder := 0;
    end;

    If frmFatFormasPagamento.ShowModal = mrOK Then
      Result := True
    Else
    Begin
      fatVenda.objFinanc.pLimpaDados;
      Result := False;
    End;

    If Result Then
    Begin
      If (frmFatFormasPagamento.fltDinhei + frmFatFormasPagamento.fltChqVis + frmFatFormasPagamento.fltChqPre +
          frmFatFormasPagamento.fltCartao + frmFatFormasPagamento.fltOrdPag + frmFatFormasPagamento.fltFatura +
          frmFatFormasPagamento.fltValFin) = 0 Then
        Result := False;
    End;

    If Result Then
    Begin
      fatVenda.optTrocoDinheiro      := frmFatFormasPagamento.optTroco;
      fatVenda.fltValorTrocoDinheiro := frmFatFormasPagamento.fltValorTroco;

      {************************************}
      {* ALIMENTA VARIAVEIS QUE VÃO SER   *}
      {* GRAVADAS NO RESUMO DE CAIXA      *}
      {*********************************AF*}
      fatVenda.fltValCqP := frmFatFormasPagamento.fltChqPre;
      fatVenda.fltValCqV := frmFatFormasPagamento.fltChqVis;
      fatVenda.fltValDin := frmFatFormasPagamento.fltDinhei;
      fatVenda.fltValCar := frmFatFormasPagamento.fltCartao;
      fatVenda.fltValOrd := frmFatFormasPagamento.fltOrdPag;
      fatVenda.fltFatura := frmFatFormasPagamento.fltFatura;
      fatVenda.fltValFin := frmFatFormasPagamento.fltValFin;

      {************************************}
      {* AGORA TENHO QUE MONTA UMA NOVA   *}
      {* FORMA DE PAGAMENTO               *}
      {*********************************AF*}
      For intContador := 0 To 10 Do
      Begin
        arrDuplicFat[intContador] := fatVenda.arrDuplicata[intContador];
      End;

      SetLength(arrCartoes,Length(frmFatFormasPagamento.arrCartoes));

      For intContador := 0 To Length(frmFatFormasPagamento.arrCartoes)-1 Do
      Begin
        arrCartoes[intContador] := frmFatFormasPagamento.arrCartoes[intContador];
      End;

      fatVenda.objFinanc.pSalvaCartoes(arrCartoes);

      if Length(arrCartoes) > 0 then
        fatVenda.arrCartoes := arrCartoes;

      If (frmFatFormasPagamento.fltDinhei > 0) Or
         (frmFatFormasPagamento.fltChqVis > 0) Or
         (frmFatFormasPagamento.fltChqPre > 0) Or
         (frmFatFormasPagamento.fltCartao > 0) Or
         (frmFatFormasPagamento.fltOrdPag > 0) Or
         (frmFatFormasPagamento.fltValFin > 0) Then
      Begin
        intContador := 0;
        pZeraDigDuplic(fatVenda.arrDuplicata);

        fatVenda.arrDuplicata[intContador].intNumDup := 0;
        fatVenda.arrDuplicata[intContador].strSequen := 'A';
        fatVenda.arrDuplicata[intContador].curValor  := frmFatFormasPagamento.fltDinhei +
                                               frmFatFormasPagamento.fltChqVis +
                                               frmFatFormasPagamento.fltChqPre +
                                               frmFatFormasPagamento.fltCartao +
                                               frmFatFormasPagamento.fltOrdPag +
                                               frmFatFormasPagamento.fltValFin;

        if frmFatFormasPagamento.fltValorTroco <> 0 then
          fatVenda.arrDuplicata[intContador].curValor := fatVenda.arrDuplicata[intContador].curValor - frmFatFormasPagamento.fltValorTroco;

        fatVenda.arrDuplicata[intContador].dtaDtaVen := FormatDateTime('dd/mm/yyyy',VS_Date);

        If fatVenda.fltFatura > 0.0 Then
        Begin

          While (arrDuplicFat[intContador].dtaDtaVen <> '') And
                (intContador < 11)                          Do
          Begin

            fatVenda.arrDuplicata[intContador + 1].intNumDup := 0;
            fatVenda.arrDuplicata[intContador + 1].strSequen := String(arrLetras[intContador + 1]);
            fatVenda.arrDuplicata[intContador + 1].curValor  := arrDuplicFat[intContador].curValor;
            fatVenda.arrDuplicata[intContador + 1].dtaDtaVen := arrDuplicFat[intContador].dtaDtaVen;
            Inc(intContador);

          End;

        End;

      End;


      intContador := 0;
      {*****************************************}
      {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
      {**************************************AF*}
      While (fatVenda.arrDuplicata[intContador].dtaDtaVen <> '') And
            (intContador < 11)                          Do
      Begin

        SetLength(arrDatas, intContador + 1);
        arrDatas[intContador] := StrToDate(fatVenda.arrDuplicata[intContador].dtaDtaVen);
        Inc(intContador);

      End;
      strCndAtu := fRetornaCndPag(arrDatas, VS_Date);

    End
    Else
    Begin
      fatVenda.optTrocoDinheiro      := otNada;
      fatVenda.fltValorTrocoDinheiro := 0;
    End;


  Except
    On E: Exception Do
    Begin
      Result := False;
      strCndAtu := '';
      pMensagensErro(E.Message, '[fConfirmaVenda_11]');
    End;
  End;

  pFreeAndNil(frmFatFormasPagamento);

  If Not Result Then
  Begin
    fatVenda.cdsChequePre.EmptyDataSet;
    fatVenda.cdsChequeVis.EmptyDataSet;
    SetLength(arrCartoes,0);
    Exit(False);
  End;
end;

function TfrmFatFaturaConsignacao.fGetItem(qryGenIte: TUniQuery;
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
    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_DESOPE, ';
    strSQL := strSQL + '  G.ITE_ICMSAI, ';
    strSQL := strSQL + '  G.ITE_IMPFED, ';
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
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

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

function TfrmFatFaturaConsignacao.fGetLiberacaoParaAbortarProcesso: Boolean;
  var
    LobjLiberacao : TLiberacao;
    LRetornoConsignacao : TRetornoConsignacao;
begin
  if not FblnRealizarRetornoAutomatico then
    Exit(True);

  LobjLiberacao := TLiberacao.Create;

  Try
    LobjLiberacao.Clear;
    LobjLiberacao.objMsgLibera.pAddTexto('Interromper faturamento de consignação com retorno automático');

    LobjLiberacao.strDirAce := 'PERINTFATCON';
    LobjLiberacao.strMsgSen := 'Interromper faturamento de consignação com retorno automático';
    LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);
    LobjLiberacao.objMsgLibera.pAddTexto('Se interromper será necessário realizar o faturamento via Venda Normal, já que o retorno automático da consignação já foi realizado. ', alEsquerda);
    LobjLiberacao.objMsgLibera.pAddTexto('Caso queira voltar ao ponto inicial desta operação será necessário cancelar os documentos do retorno gerados. Segue(m) o(s) mesmo(s):', alEsquerda);
    LobjLiberacao.objMsgLibera.pAddTexto('', alEsquerda);

    for LRetornoConsignacao in FObjRetornoConsignacaoBuilder.ObjRetornoConsignacaoList do
    Begin
      LobjLiberacao.objMsgLibera.pAddTexto(LRetornoConsignacao.NumeroDoDocumentoDoRetorno+'-'+
                                           LRetornoConsignacao.EspecieDoDocumentoDoRetorno, alEsquerda);
    End;

    LobjLiberacao.blnMosMen := True;
    LobjLiberacao.strCodOpe := fatVenda.strCodVen;
    LobjLiberacao.strCodDig := fatVenda.strCodDig;

    Result := LobjLiberacao.fLibera;

  Finally
    FreeAndNil(LobjLiberacao);
  End;
end;

function TfrmFatFaturaConsignacao.fGetSql(blnLike: Boolean): String;
Begin
  Result := fSQLSintetico;
End;

function TfrmFatFaturaConsignacao.fGetTipoFaturamento(
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

  arrOpcoes[1].strDesCri := 'Faturamento Futuro';
  arrOpcoes[1].strEspDoc := 'FF';
  arrOpcoes[1].strOpcLet := 'F';
  arrOpcoes[1].strMosMen := 'N';

  Try
    pCriarFormularios(TfrmFatTipoFaturamento, frmFatTipoFaturamento);
    frmFatTipoFaturamento.strOpcDoc := 'VN';
    frmFatTipoFaturamento.fatVenda  := fatVenda;
    frmFatTipoFaturamento.arrOpcoes := arrOpcoes;
    frmFatTipoFaturamento.showModal;

    If frmFatTipoFaturamento.blnConfirma Then
    Begin
      fatVenda.strEspDoc := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strEspDoc;
      fatVenda.strTipFat := arrOpcoes[frmFatTipoFaturamento.intPosAtual].strDesCri;

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

function TfrmFatFaturaConsignacao.fIncluiItens(fatVenda: TFatVenda; AblnRealizandoRetorno : Boolean; AstrEspecieDocumentoAProcessar : String): Boolean;
  Var
    qryGenIte   : TUniQuery;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
    strNumLot   : String;
    strLotAnt   : String;
    objConsig   : TConsignacoes;
    intPosicao  : Integer;
    impSubIteEst: TImpostosSubItensEstrutura;
    fltUnitarIte,
    fltOutValIte,
    fltDesOpeIte,
    fltIcmSaiIte,
    fltImpFedIte,
    fltPreVe1Ite,
    fltPreVe2Ite,
    fltPreVe3Ite,
    fltPreVe4Ite,
    fltPreVe5Ite,
    fltPreVe6Ite,
    fltPreVe7Ite: Double;
    strVendedor: String;
    LstrCampo : String;
    LfltQuantidadeItem  : Double;
    LstrMensagem : String;
Begin
  LstrCampo  := IIF(AblnRealizandoRetorno, 'DET_QTDPEN', 'DET_QTDFAT');

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
        If (FieldByName('DET_QTDFAT').AsFloat > 0)Then
        Begin
          LfltQuantidadeItem := 0;

          strVendedor := cdsConsulta.FieldByName('DET_CODVEN').AsString;
          inc(intContador);

          {**********************************}
          {* Monta matriz com os documentos *}
          {* para salvar na tabela MOVCON   *}
          {**********************************}
          objConsig               := TConsignacoes.Create;
          objConsig.blnDeveGravar := (AblnRealizandoRetorno) or not(FblnRealizarRetornoAutomatico);

          With cdsAnalitico Do
          Begin
            If Not IsEmpty Then
            Begin
              First;
              While Not EOF do
              Begin
                If FieldByName(LstrCampo).AsFloat > 0  Then
                Begin
                  if (AstrEspecieDocumentoAProcessar <> '') and
                     (FieldByName('DET_ESPDOC').AsString <> AstrEspecieDocumentoAProcessar) then
                  Begin
                    cdsAnalitico.Next;
                    Continue;
                  End
                  Else
                    LfltQuantidadeItem := LfltQuantidadeItem + FieldByName(LstrCampo).AsFloat;

                  SetLength(objConsig.arrConsignacoes, Length(objConsig.arrConsignacoes) + 1);
                  intPosicao := Length(objConsig.arrConsignacoes) - 1;

                  objConsig.arrConsignacoes[intPosicao].strNumDoc         := FieldByName('DET_NUMDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strEspDoc         := FieldByName('DET_ESPDOC').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodIte         := FieldByName('DET_CODITE').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodAca         := FieldByName('DET_CODACA').AsString;
                  objConsig.arrConsignacoes[intPosicao].strCodEmp         := FieldByName('DET_CODEMP').AsString;
                  objConsig.arrConsignacoes[intPosicao].fltQtdIte         := FieldByName(LstrCampo).AsFloat;
                  objConsig.arrConsignacoes[intPosicao].strAutInc         := FieldByName('AUTOINCREM').AsString;
                  objConsig.arrConsignacoes[intPosicao].tmTipoDeMovimento := tmFaturamento;

                  fatVenda.strCodVen := strVendedor;
                  fatVenda.strNomVen := fRetNomVendRep(strVendedor);

                End;

                if FblnRealizarRetornoAutomatico then
                Begin
                  if AblnRealizandoRetorno then
                  Begin
                    FObjRetornoConsignacaoBuilder.NumeroDoDocumentoDoEnvio  := FieldByName('DET_NUMDOC').AsString;
                    FObjRetornoConsignacaoBuilder.EspecieDoDocumentoDoEnvio := FieldByName('DET_ESPDOC').AsString;
                    FObjRetornoConsignacaoBuilder.EmpresaDoDocumentoDoEnvio := FieldByName('DET_CODEMP').AsString;
                    FObjRetornoConsignacaoBuilder.CodigoItemEnvio           := FieldByName('DET_CODITE').AsString;
                    FObjRetornoConsignacaoBuilder.IdMovDetEnvio             := FieldByName('AUTOINCREM').AsString;
                    FObjRetornoConsignacaoBuilder.QuantidadeFaturada        := FieldByName('DET_QTDFAT').AsFloat;
                    FObjRetornoConsignacaoBuilder.QuantidadeRetornada       := FieldByName('DET_QTDPEN').AsFloat;
                    FObjRetornoConsignacaoBuilder.CodigoProdutoAcabado      := FieldByName('DET_CODACA').AsString;

                    if not FObjRetornoConsignacaoBuilder.fAdiconarDocumentoDetalhe(LstrMensagem) then
                    Begin
                      fMensagem('', 'Erro ao tratar o detalhe do retorno automático da consignação: '+LstrMensagem, ['&OK']);
                      pInicializaTemporaria;
                      Exit(False);
                    End;
                  End;
                End;

                Next;
              End;
            End;
          End;

          if LfltQuantidadeItem = 0 then
          Begin
            Next;
            Continue;
          End;

          strNumLot := FieldByName('DET_NUMLOT').AsString;
          strLotAnt := '';

          fGetItem(qryGenIte,FieldByName('DET_CODITE').AsString);

          if AblnRealizandoRetorno then
            fltUnitarIte := FieldByName('DET_UNITAR').AsFloat
          else
            fltUnitarIte := IIF(fCfgSis('VALFMC', varBoolean), FieldByName('DET_UNICAL').AsFloat, FieldByName('DET_UNITAR').AsFloat);

          If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', qryGenIte.FieldByName('ITE_DESITE').AsString) > 0,
                                                     FieldByName('DET_CODITE').AsString) Then
          Begin
            impSubIteEst.strCodIte := FieldByName('DET_CODITE').AsString;
            impSubIteEst.strEmpIte := '';
            impSubIteEst.fltUniPai := fltUnitarIte;
            impSubIteEst.fltQtdPai := LfltQuantidadeItem;

            fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);

            fltOutValIte := impSubIteEst.fltOutVal;
            fltDesOpeIte := impSubIteEst.fltDesOpe;
            fltImpFedIte := impSubIteEst.fltImpFed;
            fltIcmSaiIte := impSubIteEst.fltIcmSai;
            fltPreVe1Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','1',fatVenda.fltMargem);
            fltPreVe2Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','2',fatVenda.fltMargem);
            fltPreVe3Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','3',fatVenda.fltMargem);
            fltPreVe4Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','4',fatVenda.fltMargem);
            fltPreVe5Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','5',fatVenda.fltMargem);
            fltPreVe6Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','6',fatVenda.fltMargem);
            fltPreVe7Ite := fatVenda.fCalculaPrecoEstrutura(False, Preco_de_Venda,FieldByName('DET_CODITE').AsString,'','S','7',fatVenda.fltMargem);
          End
          Else
          Begin
            fltOutValIte := qryGenIte.FieldByName('ITE_OUTVAL').AsFloat;
            fltDesOpeIte := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;
            fltImpFedIte := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;
            fltIcmSaiIte := IIF(fCfgSis('IMPCF4') = 'S', fatVenda.fCalculaAliquota(FieldByName('DET_CODITE').AsString, VS_strCodEmp, qryGenIte.FieldByName('ITE_IMPDIR').AsString), qryGenIte.FieldByName('ITE_ICMSAI').AsFloat);
            fltPreVe1Ite := qryGenIte.FieldByName('ITE_PREVE1').AsFloat;
            fltPreVe2Ite := qryGenIte.FieldByName('ITE_PREVE2').AsFloat;
            fltPreVe3Ite := qryGenIte.FieldByName('ITE_PREVE3').AsFloat;
            fltPreVe4Ite := qryGenIte.FieldByName('ITE_PREVE4').AsFloat;
            fltPreVe5Ite := qryGenIte.FieldByName('ITE_PREVE5').AsFloat;
            fltPreVe6Ite := qryGenIte.FieldByName('ITE_PREVE6').AsFloat;
            fltPreVe7Ite := qryGenIte.FieldByName('ITE_PREVE7').AsFloat;
          End;

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               IIF(FblnRealizarRetornoAutomatico, 'NOR', FieldByName('DET_IDEPRO').AsString),
                                               FieldByName('ITE_CODGRU').AsString,
                                               FieldByName('DET_CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               FieldByName('DET_DESCRI').AsString,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_UNIDAD').AsString,
                                               FieldByName('DET_CODMAR').AsString,
                                               FieldByName('DET_FORITE').AsString,
                                               FieldByName('DET_REFERE').AsString,
                                               FieldByName('DET_UNIORI').AsFloat,
                                               FieldByName('DET_UNIVIS').AsFloat,
                                               fltUnitarIte,
                                               0.0,
                                               IIF(AblnRealizandoRetorno, FieldByName('DET_DESCON_ORI').AsFloat, FieldByName('DET_DESCON').AsFloat),
                                               LfltQuantidadeItem,
                                               fltUnitarIte * LfltQuantidadeItem,
                                               'S',
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * LfltQuantidadeItem, 2),
                                               qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                               qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                               qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                               fltPreVe1Ite,
                                               fltPreVe2Ite,
                                               fltPreVe3Ite,
                                               fltPreVe4Ite,
                                               fltPreVe5Ite,
                                               fltPreVe6Ite,
                                               fltPreVe7Ite,
                                               fCalculaPrecoVenda(2, fFormataFloat(FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat * LfltQuantidadeItem, 2), fltUnitarIte, 0, 0, 0, 0, 0),
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
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * LfltQuantidadeItem,
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
                                               FieldByName('DET_ITEEMB').AsString,
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
                                               IIF(AblnRealizandoRetorno, fltUnitarIte, FieldByName('DET_VALUNI').AsFloat),
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
                                               IIF(FblnRealizarRetornoAutomatico, (FieldByName('DET_PROACA').AsString = 'S') Or (Not fEmptyStr(FieldByName('DET_CODACA').AsString)), (FieldByName('DET_PROACA').AsString = 'S')),
                                               '',
                                               '',
                                               '',
                                               fltOutValIte, //OUTVAL
                                               0,
                                               fltDesOpeIte, // DESOPE
                                               fltIcmSaiIte, // ICMSAI
                                               fltImpFedIte, // IMPFED
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
                                               LfltQuantidadeItem,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',
                                               FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               fFormataFloat(FieldByName('DET_TOTCU2').AsFloat / FieldByName('DET_QTDENV').AsFloat * LfltQuantidadeItem, 2),
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
                                               FieldByName('DET_TOTCUS').AsFloat / FieldByName('DET_QTDENV').AsFloat,
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * LfltQuantidadeItem,
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
      strVendedor := EmptyStr;
      EnableControls;
    End;

    Result := TRUE;

    FreeAndNil(qryGenIte);

  Except

    On E: ExceptionAutCom Do
    Begin
      Result := False;
	   		pMensagemOK(E.Message);
    End;

    On E: Exception Do
    Begin
      Result := False;
		   	pMensagensErro(E.Message,'[TfrmFatBaixaEntregaFutura.fIncluiItens]');
    End;

  End;


end;

function TfrmFatFaturaConsignacao.fMarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
begin

  Result := True;

  Try
    blnMarcaTodos := True;
    cdsAnalitico.qryQuery.SQL.Text := fSQLAnalitico;
    fAbreConsulta(True);

    If fCfgSis('VALFMC', varBoolean) Then
    Begin
      pgbStatus.Properties.Max := cdsConsulta.RecordCount;

      cdsConsulta.DisableControls;
      cdsAnalitico.DisableControls;

      Try
        cdsConsulta.First;
        While Not cdsConsulta.EOF Do
        Begin
          pStepStatusGravacao(pgbStatus);

          cdsConsulta.Edit;
          cdsConsulta.FieldByName('DET_QTDFAT').AsFloat := cdsConsulta.FieldByName('DET_QTDPEN').AsFloat;
          cdsConsulta.Post;

          cdsConsulta.Next;
        End;
      Finally
        cdsConsulta.First;
        cdsConsulta.EnableControls;
        cdsAnalitico.EnableControls;
      End;
    End;

    pSetFocus(cxGridConsulta);
    blnMarcaTodos := False;
    pCalculaTotais;
  Except
    Result := False;
  End;

end;

function TfrmFatFaturaConsignacao.fAbreConsulta(blnLike: Boolean): Boolean;
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
      (cdsConsulta.FieldByName('DET_QTDFAT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_VALFAT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_DESCON') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_VALUNI') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsConsulta.FieldByName('DET_UNICAL') As TFloatField).DisplayFormat := '#,##0.00';
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
          (FieldByName('DET_QTDFAT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTFAT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_TOTPEN') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_VALFAT') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_DESCON') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_VALUNI') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('DET_UNICAL') As TFloatField).DisplayFormat := '#,##0.00';
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

function TfrmFatFaturaConsignacao.fDesmarcaTodos(pgbStatus: TcxProgressBar = Nil) : Boolean;
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

function TfrmFatFaturaConsignacao.fPedeDadosFiscais: Boolean;
begin
  Try
    pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
    frmFatDadosFiscais.fatVenda := fatVenda;
    frmFatDadosFiscais.blnPodeCancelar := True;
    frmFatDadosFiscais.ShowModal;
    Result := frmFatDadosFiscais.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmFatFaturaConsignacao.fPedeDadosFiscais]');
    End;
  End;
  pFreeAndNil(frmFatDadosFiscais);
end;

function TfrmFatFaturaConsignacao.fProcessaDocumento(AblnRealizandoRetorno: Boolean; AstrEspecieDocumentoAProcessar: String = ''; AstrCodCli: String = ''): Boolean;
  Var
    blnConfirma           : Boolean;
    blnMosDup             : Boolean;
    LstrMensagem          : String;
    LstrCodCliAnt         : String;
    LblnSairDoLoop,
    LblnRealizouAcao      : Boolean;
    intIndDoc           : Integer;
    documento: TDadosImpressaoVenda;

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

  FillChar(fatVenda.arrDocConsignacao, SizeOf(fatVenda.arrDocConsignacao), #0);
  SetLength(fatVenda.arrDocConsignacao,0);

  LstrCodCliAnt := fatVenda.strCodCli;

  if AblnRealizandoRetorno then
  Begin
    fatVenda.strOpcDocTrue := 'CR';
    fatVenda.strOpcDoc     := 'CR';
    fatVenda.strCodCli     := edtCodCliente.Text; //o retorno é sempre para o cliente original
  End
  Else
  Begin
    fatVenda.strOpcDocTrue := 'FC';
    fatVenda.strCodCli     := AstrCodCli;

    if FblnRealizarRetornoAutomatico then
      fatVenda.strOpcDoc := 'VN'
    else
      fatVenda.strOpcDoc := 'FC';
  End;

  If fatVenda.strCodCli <> LstrCodCliAnt Then
    fatVenda.pCarregaDadosClienteBaixa(fatVenda.strCodCli);

  pInicializaTemporaria;

  fatVenda.strCodVen         := fatVenda.strCodOpe;
  fatVenda.strCodDig         := fatVenda.strCodOpe;
  fatVenda.strNomVen         := fRetNomVendRep(fatVenda.strCodVen);
  fatVenda.strNomDig         := fRetNomVendRep(fatVenda.strCodDig);
  fatVenda.blnNovoSequencial := True;

  if (AblnRealizandoRetorno) or not(FblnRealizarRetornoAutomatico) then
    pPreencheMatrizConsignacao(AblnRealizandoRetorno, AstrEspecieDocumentoAProcessar) ;

  If Assigned(frmFechamentoVenda) Then
    pInformacao('Aguarde, carregando dados do(s) produto(s) para fechamento...', frmFechamentoVenda.pgbStatus);

  blnConfirma := fIncluiItens(fatVenda, AblnRealizandoRetorno, AstrEspecieDocumentoAProcessar);

  If (cdsVenda.IsEmpty) Then
    Exit;

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

    if AblnRealizandoRetorno then
      fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotGer,
                                               FAlse, False, False, VS_Date, False);

    if not AblnRealizandoRetorno  then
    Begin
      If Not fGetCndPagto(fatVenda) Then
      Begin
        LblnRealizouAcao := False;
        LblnSairDoLoop   := fGetLiberacaoParaAbortarProcesso;

        if not LblnSairDoLoop then
        Begin
          Repeat
            LblnRealizouAcao  := fGetCndPagto(fatVenda);

            if not LblnRealizouAcao then
              LblnSairDoLoop := fGetLiberacaoParaAbortarProcesso
            else
              LblnSairDoLoop := True;

          Until LblnSairDoLoop;
        End;

        if (LblnSairDoLoop) and not(LblnRealizouAcao) then
        Begin
          pInicializaTemporaria;
          Exit(False);
        End;
      End;
    end;

    if not AblnRealizandoRetorno  then
    Begin
      If Not fGetTipoFaturamento(fatVenda) Then
      Begin
        LblnRealizouAcao := False;
        LblnSairDoLoop   := fGetLiberacaoParaAbortarProcesso;

        if not LblnSairDoLoop then
        Begin
          Repeat
            LblnRealizouAcao  := fGetTipoFaturamento(fatVenda);

            if not LblnRealizouAcao then
              LblnSairDoLoop := fGetLiberacaoParaAbortarProcesso
            else
              LblnSairDoLoop := True;

          Until LblnSairDoLoop;
        End;

        if (LblnSairDoLoop) and not(LblnRealizouAcao) then
        Begin
          pInicializaTemporaria;
          Exit(False);
        End;
      End;
    End
    Else
    Begin
      if AstrEspecieDocumentoAProcessar = 'CS' then
      Begin
        fatVenda.strEspDoc         := 'CR';
        fatVenda.strTipFat         := 'Retorno de Consignação';
        fatVenda.blnRcOutEnt       := False;
        fatVenda.dtaDtaEnt         := fRetDataServidor;
        fatVenda.dtaDtaOri         := fatVenda.dtaDtaEnt;
        fatVenda.strEntFat         := 'N';
        fatVenda.strOriDoc         := 'C';
        fatVenda.blnNovoSequencial := True;
      End
      Else
      Begin
        fatVenda.strEspDoc   := 'NF';
        fatVenda.strTipFat   := 'Nota Fiscal';
        fatVenda.blnRcOutEnt := True;
        fatVenda.dtaDtaEnt   := fRetDataServidor;
        fatVenda.dtaDtaOri   := fatVenda.dtaDtaEnt;
        fatVenda.strEntFat   := 'N';
        fatVenda.strOriDoc   := 'V';
      End;
    End;

    If (Pos(fatVenda.strEspDoc, 'NF_EL_NS_') > 0) and not(AblnRealizandoRetorno) Then
    Begin
      If (Not fPedeDadosFiscais) Then
      Begin
        LblnRealizouAcao := False;
        LblnSairDoLoop   := fGetLiberacaoParaAbortarProcesso;

        if not LblnSairDoLoop then
        Begin
          Repeat
            LblnRealizouAcao  := fPedeDadosFiscais;

            if not LblnRealizouAcao then
              LblnSairDoLoop := fGetLiberacaoParaAbortarProcesso
            else
              LblnSairDoLoop := True;

          Until LblnSairDoLoop;
        End;

        if (LblnSairDoLoop) and not(LblnRealizouAcao) then
        Begin
          pInicializaTemporaria;
          Exit(False);
        End;
      End;
    End;

    If (fatVenda.VS_blnUsaFpg) And (fVerificaCodFpg(fatVenda.strCodFpg)) And
      (not AblnRealizandoRetorno) And (fCfgSis('BAIAVI', VarBoolean)) Then
    Begin
      If (Not fGetFormasPagamento) Then
      Begin
        LblnRealizouAcao := False;
        LblnSairDoLoop   := fGetLiberacaoParaAbortarProcesso;

        if not LblnSairDoLoop then
        Begin
          Repeat
            LblnRealizouAcao  := fGetFormasPagamento;

            if not LblnRealizouAcao then
              LblnSairDoLoop := fGetLiberacaoParaAbortarProcesso
            else
              LblnSairDoLoop := True;

          Until LblnSairDoLoop;
        End;

        if (LblnSairDoLoop) and not(LblnRealizouAcao) then
        Begin
          pInicializaTemporaria;
          Exit(False);
        End;
      End;
    End;

    fatVenda.pCalculaTotalParaCadRec;

    If not(AblnRealizandoRetorno) and (Not fatVenda.fDigitaDuplicata(blnMosDup, arrDatas, VS_Date, False, arrDuplic)) Then
      Exit(False);

    if not(AblnRealizandoRetorno) then
      fatVenda.strConPag := fRetornaCndPag(fatVenda.arrDuplicata, VS_Date);

    fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

    fatVenda.pRateiaValores;

    pAcertaDesEspItens;
    pCarregaChaveReferenciada;

    if fatVenda.fHaveraDesmembramentoProVendedor(fatVenda.strOpcDoc) then
    begin
      if not fatVenda.fGravaArquivosDesmembrandoVenda(frmFechamentoVenda.pgbStatus) then
        Exit(False);
    end
    else
    begin
      if not fatVenda.fGravaArquivos(frmFechamentoVenda.pgbStatus) then
        Exit(False);
    end;

    if FblnRealizarRetornoAutomatico then
    Begin
      //caso houve desmembramento, foi gerado mais de um documento
      For intIndDoc := 0 To fatVenda.objFatVendaImp.ItemsCount -1 Do
      Begin
        documento := fatVenda.objFatVendaImp[intIndDoc];

        If AblnRealizandoRetorno Then
        Begin
          FObjRetornoConsignacaoBuilder.NumeroDoDocumentoDoRetorno  := documento.strNumDoc;
          FObjRetornoConsignacaoBuilder.EspecieDoDocumentoDoRetorno := documento.strEspDoc;
          FObjRetornoConsignacaoBuilder.EmpresaDoDocumentoDoRetorno := documento.strEmpDoc;
          FObjRetornoConsignacaoBuilder.SerieDoDocumentoDoRetorno   := documento.strSerFsc;
          FObjRetornoConsignacaoBuilder.ClienteDoDocumentoDoRetorno := documento.strCodCli;
        End
        Else
        Begin
          FObjRetornoConsignacaoBuilder.NumeroDoDocumentoDoFaturamento  := documento.strNumDoc;
          FObjRetornoConsignacaoBuilder.EspecieDoDocumentoDoFaturamento := documento.strEspDoc;
          FObjRetornoConsignacaoBuilder.EmpresaDoDocumentoDoFaturamento := documento.strEmpDoc;
          FObjRetornoConsignacaoBuilder.SerieDoDocumentoDoFaturamento   := documento.strSerFsc;

          FObjRetornoConsignacaoBuilder.MatrizItens := documento.arrMatItens;
          FObjRetornoConsignacaoBuilder.pAtualizarAutoIncremDoFaturamento;
        End;

        If Not FObjRetornoConsignacaoBuilder.fAdiconarDocumento(LstrMensagem) Then
        Begin
          fMensagem('', 'Erro ao tratar o retorno automático da consignação: '+LstrMensagem, ['&OK']);
          pInicializaTemporaria;
          Exit(False);
        End;
      End;
    End;

    pInicializaTemporaria;

  End;
end;

function TfrmFatFaturaConsignacao.fSelecionaNovoClienteFat(Out strCodCli: String): Boolean;
  Var
    frmFatTrocaCliente: TfrmFatTrocaCliente;
begin
  strCodCli := '';
  pCriarFormularios(TfrmFatTrocaCliente, frmFatTrocaCliente);
  Try
    frmFatTrocaCliente.fatVenda := fatVenda;
    frmFatTrocaCliente.blnValidaClienteAtivo := True;
    frmFatTrocaCliente.ShowModal;

    Result := frmFatTrocaCliente.blnResult;

    If Result Then
      strCodCli := frmFatTrocaCliente.edtCliFat.Text;
  Finally
    pFreeAndNil(frmFatTrocaCliente);
  End;
end;

function TfrmFatFaturaConsignacao.fSelecionouApenasEspecieCS: Boolean;
begin
  Result := False;

  cdsConsulta.DisableControls;
  cdsAnalitico.DisableControls;

  Try
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      cdsAnalitico.First;
      While Not cdsAnalitico.Eof Do
      Begin
        If cdsAnalitico.FieldByName('DET_QTDFAT').AsFloat > 0 Then
        Begin
          Result := (cdsAnalitico.FieldByName('DET_ESPDOC').AsString = 'CS');

          If Not Result Then
            Exit;
        End;

        cdsAnalitico.Next;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
    cdsAnalitico.EnableControls;
  End;
end;

function TfrmFatFaturaConsignacao.fSetParametros: Boolean;
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

function TfrmFatFaturaConsignacao.fRetMovConTipD : String;
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

function TfrmFatFaturaConsignacao.fRetMovConTipF : String;
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

function TfrmFatFaturaConsignacao.fSQLAnalitico: String;
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
  strSQL := strSQL + '  D.DET_FORITE, ';
  strSQL := strSQL + '  D.DET_REFERE, ';
  strSQL := strSQL + '  T.DET_VAL_RT, ';
  strSQL := strSQL + '  D.DET_UNIORI, ';
  strSQL := strSQL + '  T.DET_UNIVIS, ';
  strSQL := strSQL + '  T.DET_TAXJUR, ';
  strSQL := strSQL + '  D.DET_DESCON AS DET_DESCON_ORI, ';
  strSQL := strSQL + '  0.00 AS DET_DESCON, ';
  strSQL := strSQL + '  D.DET_TOTCUS, ';
  strSQL := strSQL + '  D.DET_TOTMED, ';
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
  strSQL := strSQL + '  D.DET_UNIDIG AS DET_VALUNI_ORI, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE), '+ intDecUni.ToString +') AS DET_VALUNI, ';
  strSQL := strSQL + '  IFNULL(D.DET_PROEMB,"N") AS DET_PROEMB, ';
  strSQL := strSQL + '  D.DET_ITEEMB, ';

  If blnMarcaTodos Then
  Begin
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(F.CON_QTDJAF,0.0)) AS DET_QTDFAT, ';
    strSQL := strSQL + '  (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(F.CON_QTDJAF,0.0)) * D.DET_UNITAR AS DET_VALFAT, ';
    strSQL := strSQL + '  D.DET_UNITAR AS DET_UNICAL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDFAT, ';
    strSQL := strSQL + '  0.00 AS DET_VALFAT, ';
    strSQL := strSQL + '  0.00 AS DET_UNICAL, ';
  End;

  strSQL := strSQL + '  IFNULL(R.CON_DESESP,0.0) AS CON_DESESP, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) AS DET_QTDENV, ';
  strSQL := strSQL + '  IFNULL(R.CON_QTDITE,0.0) AS DET_QTFARE, ';
  strSQL := strSQL + '  IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(F.CON_QTDJAF,0.0) AS DET_QTDPEN, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * IFNULL(D.DET_QTDITE,0.0) AS DET_TOTITE, ';
  strSQL := strSQL + '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(F.CON_QTDJAF,0.0)) AS DET_TOTPEN, ';
  strSQL := strSQL + '  IFNULL(D.DET_UNITAR,0.0) * IFNULL(R.CON_QTDITE,0.0) AS DET_TOTFAT, ';
  strSQL := strSQL + '  OPE.OPE_NOMOPE AS NOMVEN, ';
  strSQL := strSQL + '  D.DET_CODVEN, ';
  strSQL := strSQL + '  CONCAT(D.DET_CODVEN, "-", OPE.OPE_NOMOPE) AS VENDEDOR, ';
  strSQL := strSQL + '  IFNULL(DEVSIM.DEV_QTDDVS, 0.0) AS DEV_QTDDVS, ';
  strSQL := strSQL + '  IFNULL((ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * DEVSIM.DEV_QTDDVS), 0.0) AS DEV_VLRDVS, ';
  strSQL := strSQL + '  IFNULL(F.CON_QTDJAF,0.0) AS DET_QTDJAF, '+
                     '  ROUND(((D.DET_TOTITE - D.DET_DESESP) / D.DET_QTDITE),2) * IFNULL(F.CON_QTDJAF,0.0) AS DET_VLRJAF, ';
  strSQL := strSQL + '  M.GER_DTAENT, ';
  strSQL := strSQL + '  X.FIS_ACESSO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON D.DET_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER P ON P.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + '  LEFT  JOIN CADFIS X ON X.FIS_NUMDOC = D.DET_NUMDOC AND ';
  strSQL := strSQL + '                         X.FIS_ESPDOC = D.DET_ESPDOC AND ';
  strSQL := strSQL + '                         X.FIS_SERIE_ = D.DET_SERIE_ AND ';
  strSQL := strSQL + '                         X.FIS_CODEMP = D.DET_CODEMP AND ';
  strSQL := strSQL + '                         X.FIS_FORCLI = D.DET_CODCLI AND ';
  strSQL := strSQL + '                         X.FIS_TIP_FC = D.DET_TIP_FC ';
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
  strSQL := strSQL + '  LEFT JOIN (SELECT SUM(DEV_QTDITE) DEV_QTDDVS, DEV_SEQENV FROM CONDEV GROUP BY DEV_SEQENV) DEVSIM '+
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
  strSQL := strSQL + ' P.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) > 0 AND ';
  strSQL := strSQL + ' D.DET_PROEMB <> "S" ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '    AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' AND (IFNULL(D.DET_QTDITE,0.0) - IFNULL(R.CON_QTDITE,0.0) - IFNULL(F.CON_QTDJAF,0.0)) > 0.0 ';

  strSQL := strSQL + ' ORDER BY D.DET_NUMDOC ';

  Result := strSQL
end;

function TfrmFatFaturaConsignacao.fSQLSintetico: String;
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
  strSQL := strSQL + '  DET_FORITE, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_VAL_RT, ';
  strSQL := strSQL + '  DET_UNIORI, ';
  strSQL := strSQL + '  DET_UNIVIS, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_DESCON AS DET_DESCON_ORI, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  SUM(CON_DESESP) AS DET_DESBAI, ';
  strSQL := strSQL + '  DET_TOTCUS, ';
  strSQL := strSQL + '  DET_TOTMED, ';
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
  strSQL := strSQL + '  DET_DESCRI_, ';
  strSQL := strSQL + '  DET_VALUNI_ORI, ';
  strSQL := strSQL + '  DET_VALUNI, ';
  strSQL := strSQL + '  DET_PROEMB, ';
  strSQL := strSQL + '  DET_ITEEMB, ';

  If blnMarcaTodos Then
  Begin
    If fCfgSis('VALFMC', varBoolean) Then
    Begin
      strSQL := strSQL + '  0.00 AS DET_QTDFAT, ';
      strSQL := strSQL + '  0.00 AS DET_VALFAT, ';
      strSQL := strSQL + '  0.00 AS DET_UNICAL, ';
    End
    Else
    Begin 
      strSQL := strSQL + '  SUM(DET_QTDFAT) AS DET_QTDFAT, ';
      strSQL := strSQL + '  SUM(DET_VALFAT) AS DET_VALFAT, ';
      strSQL := strSQL + '  0.00            AS DET_UNICAL, ';
    End;
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DET_QTDFAT, ';
    strSQL := strSQL + '  0.00 AS DET_VALFAT, ';
    strSQL := strSQL + '  0.00 AS DET_UNICAL, ';
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
  strSQL := strSQL + '  A.DET_CODITE, A.DET_CODACA, A.DET_UNIDAD, A.DET_UNITAR, NOMVEN, A.DET_NUMLOT, A.DET_CODVEN ';
  strSQL := strSQL + 'HAVING SUM(IFNULL(DET_QTDPEN,0.0)) > 0.0 ';

  Result := strSQL;
end;

function TfrmFatFaturaConsignacao.fTravaDocumento: Boolean;
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
      if cdsConsulta.FieldByName('DET_QTDFAT').AsFloat > 0 then
      begin
        cdsAnalitico.First;
        while not cdsAnalitico.Eof do
        begin
          if (cdsAnalitico.FieldByName('DET_QTDFAT').AsFloat > 0) then
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

function TfrmFatFaturaConsignacao.fRetornaQuantidadePendente(const strAutInc: String): Double;
begin
  qryRevalidar.Close;
  qryRevalidar.ParamByName('AUTINC').AsString := strAutInc;
  qryRevalidar.Open;

  Result := qryRevalidar.FieldByName('DET_QTDPEN').AsFloat;
end;

procedure TfrmFatFaturaConsignacao.pInicializaTemporaria;
begin
  cdsVenda.EmptyDataSet;
  fatVenda.strMen001 := '';
  fatVenda.strMen002 := '';
  fatVenda.fltDesAce := 0.00;
  blnPostandoPai   := False;
  blnPostandoFilho := False;
End;

procedure TfrmFatFaturaConsignacao.pPreencheMatrizConsignacao(AblnRealizandoRetorno : Boolean; AstrEspecieDocumentoAProcessar : String);
var
  arrValidacao: Array of String;
  intIndice: integer;
  LstrCampoQuantidade : String;
begin
  LstrCampoQuantidade := IIF(AblnRealizandoRetorno, 'DET_QTDPEN', 'DET_QTDFAT');

  cdsConsulta.First;
  SetLength(arrValidacao, 0);
  SetLength(fatVenda.arrDocConsignacao, 0);

  while not cdsConsulta.Eof do
  begin
    if (cdsConsulta.FieldByName('DET_QTDFAT').AsFloat > 0) Then
    begin
      cdsAnalitico.First;
      while not cdsAnalitico.Eof do
      begin
        if (AstrEspecieDocumentoAProcessar <> '') and
           (cdsAnalitico.FieldByName('DET_ESPDOC').AsString <> AstrEspecieDocumentoAProcessar) then
        Begin
          cdsAnalitico.Next;
          Continue;
        End;

        if (cdsAnalitico.FieldByName(LstrCampoQuantidade).AsFloat > 0) then
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
                                                                                                                                                cdsAnalitico.FieldByName(LstrCampoQuantidade).AsFloat);

            fatVenda.arrDocConsignacao[Length(fatVenda.arrDocConsignacao)-1].intSeqBai := 0;
          end
          else
          begin
            fatVenda.arrDocConsignacao[intIndice].fltValDoc := fatVenda.arrDocConsignacao[intIndice].fltValDoc +
                                                               TFaturamentoConsignacao.fGetValorParaBaixaDaDuplicata(cdsAnalitico.FieldByName('AUTOINCREM').AsString,
                                                                                                                     cdsAnalitico.FieldByName(LstrCampoQuantidade).AsFloat);
          end;
        end;
        cdsAnalitico.Next;
      end;
    end;
    cdsConsulta.Next;
  end;

  cdsConsulta.First;
end;

procedure TfrmFatFaturaConsignacao.pZeraTotais;
begin
  pnlEnvTotSin.Caption := '0,00';
  pnlDevTotSin.Caption := '0,00';
  pnlPenTotSin.Caption := '0,00';
  pnlFatTotSin.Caption := '0,00';
  pnlEnvTotAnl.Caption := '0,00';
  pnlDevTotAnl.Caption := '0,00';
  pnlPenTotAnl.Caption := '0,00';
  pnlFatTotAnl.Caption := '0,00';
end;

procedure TfrmFatFaturaConsignacao.pGravarConfiguracoes;
begin
  TCfgColExpFaturaConsig.pCarregarDadosSalvosSintet(cxGridConsultaView);
  TCfgColExpFaturaConsig.pCarregarDadosSalvosAnalit(cxGridAnaliticoView);
  pTratarExibicaoCampos(False);
end;

procedure TfrmFatFaturaConsignacao.pTratarExibicaoCampos(blnInicio : Boolean);
begin
  if fCfgSis('VALFMC', varBoolean) then
  begin
    If blnInicio Then
    Begin
      cxGridConsultaViewDET_DESCON.Visible  := True;
      cxGridConsultaViewDET_DESCON.Options.Editing := True;
      cxGridConsultaViewDET_DESCON.Width    := 75;

      cxGridConsultaViewDET_VALUNI.Visible  := True;
      cxGridConsultaViewDET_VALUNI.Options.Editing := True;
      cxGridConsultaViewDET_VALUNI.Width    := 75;

      cxGridConsultaViewDET_UNICAL.Visible  := True;
      cxGridConsultaViewDET_UNICAL.Options.Editing := True;
      cxGridConsultaViewDET_UNICAL.Width    := 75;

      cxGridAnaliticoViewDET_DESCON.Visible  := True;
      cxGridAnaliticoViewDET_DESCON.Options.Editing := True;
      cxGridAnaliticoViewDET_DESCON.Width    := 75;

      cxGridAnaliticoViewDET_VALUNI.Visible  := True;
      cxGridAnaliticoViewDET_VALUNI.Options.Editing := True;
      cxGridAnaliticoViewDET_VALUNI.Width    := 75;

      cxGridAnaliticoViewDET_UNICAL.Visible  := True;
      cxGridAnaliticoViewDET_UNICAL.Options.Editing := True;
      cxGridAnaliticoViewDET_UNICAL.Width    := 75;
    End;
  end
  Else
  begin
    cxGridConsultaViewDET_DESCON.Visible   := False;
    cxGridConsultaViewDET_VALUNI.Visible   := False;
    cxGridConsultaViewDET_UNICAL.Visible   := False;
    cxGridAnaliticoViewDET_DESCON.Visible  := False;
    cxGridAnaliticoViewDET_VALUNI.Visible  := False;
    cxGridAnaliticoViewDET_UNICAL.Visible  := False;
  End;
End;

procedure TfrmFatFaturaConsignacao.pValidaSeOcultaColunaDeLotes;
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

function TfrmFatFaturaConsignacao.fExiteChaveReferenciada(strChvRef: String): Boolean;
Var
  intContador: Integer;
begin
  Result := False;

  For intContador := Low(fatVenda.arrChaveReferenciada) To High(fatVenda.arrChaveReferenciada) Do
  Begin
    If (fatVenda.arrChaveReferenciada[intContador].strChvRef = strChvRef) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TfrmFatFaturaConsignacao.pCarregaChaveReferenciada;
var
  intPosicao: integer;
begin
  If not assigned(fatVenda) Then
    Exit;

  cdsConsulta.DisableControls;
  cdsAnalitico.DisableControls;

  Try
    cdsConsulta.First;

    While not cdsConsulta.eof Do
    Begin
      While not cdsAnalitico.eof Do
      Begin
        IF fEmptyStr(cdsAnalitico.FieldByName('FIS_ACESSO').AsString) Then
        Begin
          cdsAnalitico.Next;
          Continue;
        End;

        If (cdsAnalitico.FieldByName('DET_QTDFAT').AsFloat > 0) Then
        Begin
          If not fExiteChaveReferenciada(cdsAnalitico.FieldByName('FIS_ACESSO').AsString) Then
          Begin
            SetLength(fatVenda.arrChaveReferenciada, Length(fatVenda.arrChaveReferenciada) + 1);
            intPosicao := Length(fatVenda.arrChaveReferenciada) - 1;
            fatVenda.arrChaveReferenciada[intPosicao].strChvRef := cdsAnalitico.FieldByName('FIS_ACESSO').AsString;
          End;
        End;

        cdsAnalitico.Next;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
    cdsAnalitico.EnableControls;
  End;
end;

end.
