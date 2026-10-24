{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untTransfCheqEmpresa;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, StrUtils,
  MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, {Qt,} DateUtils,
  Menus, QColorLabel, Uni, AppEvnts, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem,
  MaskUtils, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridLevel, cxGrid,cxProgressBar,untGravando, untBuscaCheques, untFechamentoFinanceiro,
  frxDBSet;

type
  TfrmTransfCheqEmpresa = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosCheque: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pnlAux2: TPanel;
    pnlBotoesTransf: TPanel;
    Label1: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    edtBanco: TEditFocus;
    edtNome: TEditFocus;
    edtAgencia: TEditFocus;
    edtCtaCorrente: TEditFocus;
    edtNroCheque: TEditFocus;
    edtEmitente: TEditFocus;
    edtEndereco: TEditFocus;
    edtTelefone: TEditFocus;
    edtNroNota: TEditFocus;
    edtVencimento: TEditFocus;
    edtValor: TEditFocus;
    edtChqSelecionados: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    Panel1: TPanel;
    lstIndices: TListBox;
    lblIndices: TLabel;
    Label6: TLabel;
    ColorLabel1: TColorLabel;
    edtOrdem: TEditFocus;
    Label20: TLabel;
    edtNomEmpOri: TEditFocus;
    edtCodEmpOri: TEditFocus;
    Label21: TLabel;
    edtNomEmpDest: TEditFocus;
    edtCodEmpDest: TEditFocus;
    Label26: TLabel;
    Label9: TLabel;
    edtTotalCheques: TEditFocus;
    Label23: TLabel;
    edtValorTotal: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnCarrCheques: TBitBtnLocked;
    FlwPnlBotoesTransf: TFlowPanel;
    btnSairTransf: TBitBtnLocked;
    dbgCheques: TcxGrid;
    dbgChequesLevel1: TcxGridLevel;
    dbgChequesDBTableView1: TcxGridDBTableView;
    dbgChequesDBTableView1CHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDBTableView1CHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDBTableView1CHQ_DTACAD: TcxGridDBColumn;
    dbgChequesDBTableView1CHQ_DTAVEN: TcxGridDBColumn;
    dbgChequesDBTableView1CHQ_DTATRF: TcxGridDBColumn;
    dbgChequesDBTableView1CHQ_VALCHQ: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    frxTransfChequeEmpresa: TfrxReport;
    frxDBCheques: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairTransfClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure edtCodEmpDestKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure edtOrdemExit(Sender: TObject);
    procedure dbgChequesDBTableView1DblClick(Sender: TObject);
    procedure dbgChequesDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgChequesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    cdsCheque: TUniClientDataSet;
    dtsCheque: TDataSource;

    qryConEmp: TUniQuery;
    qryConPor: TUniQuery;

    strCtaBai : String;
    strPorBai : String;
    strNomPorBai : String;
    strCtaDeb : String;
    strPorDeb : String;

    strCtaDep: String;
    dtaDtaDep: TDateTime;

    strValorFiltro: String;
    strCampoFiltro: String;
    objFechamento: TFechamentoFinanceiro;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pCarregaEmpresa(edtCodigo, edtNome: TEditFocus);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pCalculaTotalCheques(edtQtdChq, edtValTot: TEditFocus; blnFiltrar: Boolean);
  protected

    procedure pAtualizaTemporaria(blnMsg: Boolean);
    procedure pLimpaDados;
    procedure pMarcaCheque(blnMarcar: Boolean; dtaDtaTrf: TDateTime; strEmpTrf: String);
    procedure pTransfereChq(strEmpTrf, strCodBco, strNumAge, strConCor, strNumChq: String);
    procedure pSelecionaCheque;
    procedure pImprimeChqTransferidos;
    function fTransfCheques: Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaCamposDeData: Boolean;
    function  fDesmarcarTodos(pgbStatus: TcxProgressBar): Boolean;
    function  fMarcarTodos(pgbStatus: TcxProgressBar): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pManipulaPanels(Habilita: Boolean);
  public
    { Public declarations }
  end;


implementation

uses  untFuncoes, untfuncoesSimples, untTypesSistema, untBaixaAnalitica, untPai,
      untPesqAux, untConsultas,untFuncoesGenerica,
      untMovBan, untCadChq, untTCadChqRepository,
      untTBanChqRepository;

{$R *.dfm}

{ TfrmTransfCheqEmpresa }

function TfrmTransfCheqEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmpOri) Then
    Begin
      If (fEmptyStr(edtCodEmpOri.Text)) Then
      Begin
        edtNomEmpOri.Clear;
      End
      Else
      Begin
        pCarregaEmpresa(edtCodEmpOri, edtNomEmpOri);
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodEmpDest) Then
    Begin
      If (fEmptyStr(edtCodEmpDest.Text)) Then
      Begin
        fMensagem('AVISO','Código da Empresa Destino deve ser informado.', ['&O K']);
        edtNomEmpDest.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa(edtCodEmpDest, edtNomEmpDest);
        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;

        If edtCodEmpDest.Text = VS_strCodEmp Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa Destino deve ser diferente da Empresa Origem!', ['&Ok']);
          edtCodEmpDest.Clear;
          Result := False;
        End;
      End;

    End

    Else If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
        mskDtaFin.Clear;

        If (fEmptyStr(edtCodEmpDest.Text)) Then
        Begin
          fMensagem('AVISO','Código da Empresa Destino deve ser informado.', ['&O K']);
          edtNomEmpDest.Clear;
          Result := False;
        End;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;
    End

    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Digite a data Final!', ['&O k']);
        Result := False;
      End

      Else If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End

      Else
      Begin
        If (fEmptyStr(edtCodEmpDest.Text)) Then
        Begin
          fMensagem('AVISO','Código da Empresa Destino deve ser informado.', ['&O K']);
          edtNomEmpDest.Clear;
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtOrdem) Then
    Begin
      If Pos(edtOrdem.Text, 'CV') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Opção Inválida. Selecione "C" ou "V"', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmTransfCheqEmpresa.fValidaCamposDeData: Boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    mskDtaFin.Enabled := False;
    mskDtaFin.Clear;
  End
  Else
  Begin
    mskDtaFin.Enabled := True;
  End;

  if mskDtaFin.Enabled then
  begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Digite a data Final!', ['&O k']);
      Result := False;
    End
    Else
    If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
      Result := False;
    End;
  end;

end;

procedure TfrmTransfCheqEmpresa.pAtualizaDados(DataSet: TDataSet);
begin
  edtBanco.Text       := DataSet.FieldByName('CHQ_CODBCO').AsString;
  edtNome.Text        := DataSet.FieldByName('CHQ_NOMBCO').AsString;
  edtAgencia.Text     := DataSet.FieldByName('CHQ_NUMAGE').AsString;
  edtCtaCorrente.Text := DataSet.FieldByName('CHQ_CONCOR').AsString;
  edtNroCheque.Text   := DataSet.FieldByName('CHQ_NUMCHQ').AsString;
  edtEmitente.Text    := DataSet.FieldByName('CHQ_NOMEMI').AsString;
  edtEndereco.Text    := DataSet.FieldByName('CHQ_ENDERE').AsString;
  edtTelefone.Text    := fFormataFone(DataSet.FieldByName('CHQ_TELEMI').AsString);
  edtNroNota.Text     := DataSet.FieldByName('CHQ_NUMNOT').AsString;
  edtVencimento.Text  := DataSet.FieldByName('CHQ_DTAVEN').AsString;
  edtValor.Text       := FormatFloat('#,##0.00', DataSet.FieldByName('CHQ_VALCHQ').AsFloat);
end;

procedure TfrmTransfCheqEmpresa.pAtualizaTemporaria(blnMsg: Boolean);
  Var
    strSQL: String;
    qryCheque: TUniQuery;
    dspCheque: TUniDataSetProvider;
begin
  Try
    cdsCheque.Close;
    qryCheque := fCriaQuery(Self);
    dspCheque := TUniDataSetProvider.Create(Self);
    dspCheque.DataSet := qryCheque;
    cdsCheque.SetProvider(dspCheque);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  Q.CHQ_CODBCO, ';
    strSQL := strSQL + '  B.BCO_NOMBCO AS CHQ_NOMBCO, ';
    strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
    strSQL := strSQL + '  Q.CHQ_CONCOR, ';
    strSQL := strSQL + '  Q.CHQ_NUMCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CODCLI, ';
    strSQL := strSQL + '  Q.CHQ_NOMEMI, ';
    strSQL := strSQL + '  Q.CHQ_ENDERE, ';
    strSQL := strSQL + '  Q.CHQ_TELEMI, ';
    strSQL := strSQL + '  Q.CHQ_CGCCPF, ';
    strSQL := strSQL + '  Q.CHQ_C_G_C_, ';
    strSQL := strSQL + '  Q.CHQ_DTACAD, ';
    strSQL := strSQL + '  Q.CHQ_DTAVEN, ';
    strSQL := strSQL + '  Q.CHQ_VALCHQ, ';
    strSQL := strSQL + '  Q.CHQ_HIST01, ';
    strSQL := strSQL + '  Q.CHQ_HIST02, ';
    strSQL := strSQL + '  Q.CHQ_CTADEP, ';
    strSQL := strSQL + '  Q.CHQ_DTADEP, ';
    strSQL := strSQL + '  Q.CHQ_DOCDEP, ';
    strSQL := strSQL + '  Q.CHQ_CODPOR, ';
    strSQL := strSQL + '  Q.CHQ_CODCTA, ';
    strSQL := strSQL + '  Q.CHQ_DTADEV, ';
    strSQL := strSQL + '  Q.CHQ_MOTDEV, ';
    strSQL := strSQL + '  Q.CHQ_DTARDP, ';
    strSQL := strSQL + '  Q.CHQ_FORREP, ';
    strSQL := strSQL + '  Q.CHQ_OBSREP, ';
    strSQL := strSQL + '  Q.CHQ_DTAREP, ';
    strSQL := strSQL + '  Q.CHQ_RESCAI, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.CHQ_NUMNOT, ';
    strSQL := strSQL + '  Q.CHQ_DTACUS, ';
    strSQL := strSQL + '  Q.CHQ_PORCUS, ';
    strSQL := strSQL + '  Q.CHQ_DOCUME, ';
    strSQL := strSQL + '  Q.CHQ_INCCTR, ';
    strSQL := strSQL + '  Q.CHQ_HISTOR, ';
    strSQL := strSQL + '  Q.CHQ_DOCCUS, ';
    strSQL := strSQL + '  Q.CHQ_LOTCUS, ';
    strSQL := strSQL + '  Q.CHQ_PORDEB, ';
    strSQL := strSQL + '  Q.CHQ_CTADEB, ';
    strSQL := strSQL + '  Q.CHQ_MOTDV2, ';
    strSQL := strSQL + '  Q.CHQ_DTADP2, ';
    strSQL := strSQL + '  Q.CHQ_DTADV2, ';
    strSQL := strSQL + '  Q.CHQ_SEQCOM, ';
    strSQL := strSQL + '  Q.CHQ_SEQCON, ';
    strSQL := strSQL + '  Q.CHQ_EMPRCX, ';
    strSQL := strSQL + '  Q.CHQ_DEVDEF, ';
    strSQL := strSQL + '  Q.CHQ_CODVEN, ';
    strSQL := strSQL + '  Q.CHQ_SEQTRF, ';
    strSQL := strSQL + '  Q.CHQ_DUPDEV, ';
    strSQL := strSQL + '  Q.CHQ_DUPDEP, ';
    strSQL := strSQL + '  Q.CHQ_CTDPSV, ';
    strSQL := strSQL + '  Q.CHQ_CTDBSV, ';
    strSQL := strSQL + '  Q.CHQ_PRDBSV, ';
    strSQL := strSQL + '  Q.CHQ_CDCTSV, ';
    strSQL := strSQL + '  Q.CHQ_CDPRSV, ';
    strSQL := strSQL + '  Q.CHQ_TELCHE, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  Q.CHQ_SEQDEP, ';
    strSQL := strSQL + '  Q.CHQ_CODOPE, ';
    strSQL := strSQL + '  Q.CHQ_CODCMC,  ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS CHQ_DTATRF, ';
    strSQL := strSQL + '  "   " AS CHQ_EMPTRF, ';
    strSQL := strSQL + '  SUBSTRING(Q.CHQ_HISTOR,1,10000) AS CHQ_HISTOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADBCO B ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
    strSQL := strSQL + '  Q.CHQ_DTADEP IS NULL ';

    If (Not fEmptyStr(edtCodEmpOri.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_CODEMP = :CODEMP ';

    If edtOrdem.Text = 'C' Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
    End
    Else
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    End;

    With qryCheque Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtCodEmpOri.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpOri.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;

      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCheque);
        cdsCheque.Open;
        cdsCheque.DisableControls;
        TFloatField(cdsCheque.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';
        cdsCheque.First;
        cdsCheque.EnableControls;
        pSetFocus(dbgCheques);
      End
      Else
      Begin
        If blnMsg Then
          fMensagem('', 'Não há cheques a serem transferidos!', ['&O k']);
        pSetFocus(edtCodEmpDest);
        blnMudarFoco := False;
        pLimpaDados ;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCheques.pAtualizaTemporaria]');
    End;
  End;

  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmTransfCheqEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  strCtaDep := '';
  dtaDtaDep := 0.0;

  qryConPor := fCriaQuery(Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  cdsCheque := TUniClientDataSet.Create(Self);
  cdsCheque.OnFilterRecord := pFilterRecord;
  cdsCheque.AfterScroll := pAtualizaDados;
  dtsCheque := fCriaDataSource(cdsCheque);
  dbgChequesDBTableView1.DataController.DataSource := dtsCheque;

  If lstIndices.Items.Count = 0 Then
  Begin
    lstIndices.Items.Add('Nro. Cheque');
    lstIndices.Items.Add('Valor Cheque');
    lstIndices.Items.Add('Dat. Cad.');
    lstIndices.Items.Add('Dat. Ven.');
    lstIndices.Selected[0] := True;
  End;

  edtCodEmpOri.Text := VS_strCodEmp;
  pCarregaEmpresa(edtCodEmpOri, edtNomEmpOri);
end;

{*****************************************}
{* LIMPA DADOS INFORMATIVOS DOS CHEQUES  *}
{**************************************MV*}
procedure TfrmTransfCheqEmpresa.pLimpaDados;
begin
  edtBanco.Clear;
  edtNome.Clear;
  edtAgencia.Clear;
  edtCtaCorrente.Clear;
  edtNroCheque.Clear;
  edtEmitente.Clear;
  edtEndereco.Clear;
  edtTelefone.Clear;
  edtNroNota.Clear;
  edtVencimento.Clear;
  edtValor.Clear;

  edtTotalCheques.Clear;
  edtValorTotal.Clear;

  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;

  cdsCheque.Close;
end;

{*****************************************}
{* MARCA / DESMARCA A DUPLICATA          *}
{**************************************MV*}
procedure TfrmTransfCheqEmpresa.pManipulaPanels(Habilita: Boolean);
begin
  pnlDadosCheque.Enabled      := Habilita;
  pnlInformativos.Enabled     := Habilita;
end;

procedure TfrmTransfCheqEmpresa.pMarcaCheque(blnMarcar: Boolean; dtaDtaTrf: TDateTime; strEmpTrf: String);
begin
  With cdsCheque Do
  Begin
    Edit;
    If blnMarcar Then
    Begin
      FieldByName('CHQ_DTATRF').AsDateTime := dtaDtaTrf;
      FieldByName('CHQ_EMPTRF').AsString   := strEmpTrf;
    End
    Else
    Begin
      FieldByName('CHQ_DTATRF').Value := Null;
      FieldByName('CHQ_EMPTRF').Value := Null;
    End;
    Post;
  End;
end;

procedure TfrmTransfCheqEmpresa.dbgChequesDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  var
  strMarDes: String;
begin
  inherited;
  With cdsCheque Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDBTableView1CHQ_DTATRF.Index]);

    If strMarDes <> '' Then
    Begin
        ACanvas.Font.Color := clBlue;
    End;

    {If (lstIndices.ItemIndex = 0) Then
    Begin
      If (dbgChequesDBTableView1.Columns[AViewInfo.Item.Index].DataBinding.FieldName = 'CHQ_NUMCHQ') Then
      Begin
        ACanvas.Brush.Color:= clInfoBk;
        ACanvas.Font.Color:= clWindowText;
      End;
    End
    Else If (lstIndices.ItemIndex = 1) Then
    Begin
      If (dbgChequesDBTableView1.Columns[AViewInfo.Item.Index].DataBinding.FieldName = 'CHQ_VALCHQ') Then
      Begin
        ACanvas.Canvas.Brush.Color:= clInfoBk;
        ACanvas.Canvas.Font.Color:= clWindowText;
      End;
    End
    Else If (lstIndices.ItemIndex = 2) Then
    Begin
      If (dbgChequesDBTableView1.Columns[AViewInfo.Item.Index].DataBinding.FieldName = 'CHQ_DTACAD') Then
        Begin
          ACanvas.Canvas.Brush.Color:= clInfoBk;
          ACanvas.Canvas.Font.Color:= clWindowText;
        End;
    End
    Else If (lstIndices.ItemIndex = 3) Then
    Begin
      If (dbgChequesDBTableView1.Columns[AViewInfo.Item.Index].DataBinding.FieldName = 'CHQ_DTAVEN') Then
        Begin
          ACanvas.Canvas.Brush.Color:= clInfoBk;
          ACanvas.Canvas.Font.Color:= clWindowText;
        End;
    End;}
 end;
end;

procedure TfrmTransfCheqEmpresa.dbgChequesDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  pSelecionaCheque;
  pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  pSetFocus(Self);
end;

procedure TfrmTransfCheqEmpresa.dbgChequesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}
  If (Key = VK_Return) And (Not cdsCheque.IsEmpty) Then
  Begin
    pSelecionaCheque;
    dbgChequesDBTableView1.NavigatorButtons.Next.Click;
    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
    pSetFocus(Self);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodEmpDest);
  End;
end;

procedure TfrmTransfCheqEmpresa.pSelecionaCheque;
begin
  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmpOri.Text, cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime) then
    Exit
  else
  if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmpDest.Text, cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime) then
    Exit;

  If Not cdsCheque.IsEmpty Then
    pMarcaCheque(cdsCheque.FieldByName('CHQ_DTATRF').IsNull, VS_Date, edtCodEmpDest.Text);
end;

procedure TfrmTransfCheqEmpresa.pStep(pgbStatus: TcxProgressBar);
begin
If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmTransfCheqEmpresa.fTransfCheques: Boolean;
  Var
    blnConfirma:  Boolean;
    strSeqLan:    String;
    strHisBai:    String;
    strHisBa2:    String;
    strPortador:  String;
    strPortadorDeb:String;

    arrBaixas: Array Of TBaixaCheque;
    repCadChq: TCadChqRepository;
    lstBanChq : TBanChqRepository;
    frmBaixaAnalitica : TfrmBaixaAnalitica;
begin
  Result       := False;
  SetLength(arrBaixas, 0);

  {*****************************************}
  {* PEDE PORTADOR E CENTRO DE CUSTO       *}
  {**************************************MV*}
  Try
    pCriarFormularios(TfrmBaixaAnalitica, frmBaixaAnalitica);
    frmBaixaAnalitica.Caption := 'Dados Complementares';
    frmBaixaAnalitica.Label5.Caption := 'DÉBITO (Empresa Origem)';
    frmBaixaAnalitica.Label6.Caption := 'CRÉDITO (Empresa Destino)';

    frmBaixaAnalitica.blnTransferencia := True;
    frmBaixaAnalitica.ShowModal;

    strCtaBai     := frmBaixaAnalitica.strCtaBai;
    strPorBai     := frmBaixaAnalitica.strPorBai;
    strNomPorBai  := frmBaixaAnalitica.strNomPorBai;
    strCtaDeb     := frmBaixaAnalitica.strCtaDeb;
    strPorDeb     := frmBaixaAnalitica.strPorDeb;

    blnConfirma := frmBaixaAnalitica.blnConfirma;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmTransfCheqEmpresa.fTransfCheques]');
    End;
  End;

  pFreeAndNil(frmBaixaAnalitica);

  If blnConfirma Then
  Begin
    {*REQ*145940**********RP*}
    If Not fEmpresaTemAcessoPortador(strPorBai, edtCodEmpOri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa Origem sem acesso para utilizar o portador ('+ strPorBai +'). Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Exit(False);
    End;

    If Not fEmpresaTemAcessoPortador(strPorDeb, edtCodEmpDest.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa Destino sem acesso para utilizar o portador ('+ strPorDeb +'). Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Exit(False);
    End;

    If (fMensagem('', 'Confirma transferência dos cheques?', ['&Sim', '&Não']) <> 1) Then
      Exit(False);

    With cdsCheque Do
    Begin
      {***********************************************}
      {* ORDENANDO OS REGISTROS PARA A TRANSFERENCIA *}
      {********************************************AN*}
      DisableControls;
      //IndexFieldNames := 'CHQ_DTATRF';

      First;
      repCadChq := TCadChqRepository.Create;
      fStartTransaction;
      lstBanChq := TBanChqRepository.Create;

      Try

        While Not Eof Do
        Begin
          {*****************************************}
          {* CASO NÃO ESTEJA MARCADA, NÃO FAZ NADA *}
          {**************************************MV*}
          If Not FieldByName('CHQ_DTATRF').IsNull Then
          Begin

            strHisBai := 'TRANSFERENCIA DO CHEQUE No. ' + FieldByName('CHQ_NUMCHQ').AsString;
            strHisBa2 := ' - CONTA ' + FieldByName('CHQ_NUMAGE').AsString +
                         '.'         + FieldByName('CHQ_CONCOR').AsString +
                         ' - EMP. '  + FieldByName('CHQ_CODEMP').AsString;

            strPortador := strPorBai;

            lstBanChq.pClear;
            lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODCLI').AsString,
                           FieldByName('CHQ_NOMEMI').AsString,
                           FieldByName('CHQ_HIST01').AsString,
                           FieldByName('CHQ_HIST02').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           '',
                           FieldByName('CHQ_VALCHQ').AsFloat);

            strSeqLan := fGravaMovBan(strCtaBai,                            // Centro de Custo
                                      strPortador,                          // Portador de Origem
                                      strLoginUsuarioLogado,                // Operador da Transf.
                                      FieldByName('CHQ_DTATRF').AsDateTime, // Data do Lançamento
                                      fTime(),                              // Hora do Lançamento
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                                      'D',                                  // Credito / Debito
                                      edtCodEmpOri.Text,                    // Empresa de Origem
                                      FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                                      strHisBai,                            // Histórico 1
                                      strHisBa2,                            // Histórico 2
                                      '',                                   // Cliente da Duplicata
                                      '',                                   // Fornecedor da Duplicata
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                                      0,                                    // Sequencial de Transf.
                                      '',                                   // Parcela da Duplicata
                                      '',                                   // Empresa da Duplicata
                                      '',                                   // Série
                                      '',                                   // Sequencial de Lançamento
                                      '',
                                      lstBanChq.fGetList                    // Log Bancário
                                     );

            If fEmptyStr(strSeqLan) Then
              Break;

            strPortadorDeb := strPorDeb;

            lstBanChq.pClear;
            lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODCLI').AsString,
                           FieldByName('CHQ_NOMEMI').AsString,
                           FieldByName('CHQ_HIST01').AsString,
                           FieldByName('CHQ_HIST02').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           '',
                           FieldByName('CHQ_VALCHQ').AsFloat);

            strSeqLan := fGravaMovBan(strCtaDeb,                            // Centro de Custo
                                      strPortadorDeb,                       // Portador de Destino
                                      strLoginUsuarioLogado,                // Operador da Transf.
                                      FieldByName('CHQ_DTATRF').AsDateTime, // Data do Lançamento
                                      fTime(),                              // Hora do Lançamento
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                                      'C',                                  // Credito / Debito
                                      edtCodEmpDest.Text,                   // Empresa de Destino
                                      FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                                      strHisBai,                            // Histórico 1
                                      strHisBa2,                            // Histórico 2
                                      '',                                   // Cliente da Duplicata
                                      '',                                   // Fornecedor da Duplicata
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                                      0,                                    // Sequencial de Transf.
                                      '',                                   // Parcela da Duplicata
                                      '',                                   // Empresa da Duplicata
                                      '',                                   // Série
                                      '',                                   // Sequencial de Lançamento
                                      '',
                                      lstBanChq.fGetList                    // Log Bancário
                                     );

            If fEmptyStr(strSeqLan) Then
              Break;

            {**************************************}
            {* UPDATE DO CODIGO DA EMPRESA DO CHQ *}
            {***********************************IV*}
            pTransfereChq( edtCodEmpDest.Text,
                           FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString );

            {********************}
            {* GRAVAR NO LOGCHQ *}
            {*****************JU*}
            repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                                FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                                'TRANSFERENCIA ' + FieldByName('CHQ_CODEMP').AsString + '->' + edtCodEmpDest.Text);
          End;

          Next;
        End;

        FreeAndNil(repCadChq);

        If Not fEmptyStr(strSeqLan) Then
        Begin
          fCommit;
          Result := True;
        End
        Else
        Begin
          fRollBack;
          Result := False;
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, '[fTransfCheques]');
        End;
      End;

      FreeAndNil(lstBanChq);
      {**********************************}
      {* CHAMANDO A ROTINA DE ORDENACAO *}
      {*******************************AN*}
    End;
  End;

end;

procedure TfrmTransfCheqEmpresa.pCalculaTotalCheques(edtQtdChq,
  edtValTot: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldGen: TAggregateField;
begin
  Try
    cdsGen := TUniClientDataSet.Create(Self);
    fldGen := TAggregateField.Create(Self);
    With fldGen Do
    Begin
      Name          := 'cdsGenCHQ_TOTCHQ';
      FieldName     := 'CHQ_TOTCHQ';
      DataSet       := cdsGen;
      Expression    := 'SUM(CHQ_VALCHQ)';
      DisplayFormat := '#,##0.00';
      Active        := True;
    End;
    cdsGen.AggregatesActive := True;
    cdsGen.Data := cdsCheque.Data;

    With cdsGen Do
    Begin
      If blnFiltrar Then
      Begin
        Filtered := False;
        Filter := 'CHQ_DTATRF IS NOT NULL';
        Filtered := True;
      End;

      If Not cdsGen.IsEmpty Then
      Begin
        edtQtdChq.Text := IntToStr(RecordCount);
        If Not fEmptyStr(TAggregateField(FieldByName('CHQ_TOTCHQ')).Value) Then
          edtValTot.Text := FormatFloat('#,##0.00', TAggregateField(FieldByName('CHQ_TOTCHQ')).Value)
        Else
          // REQ 67169
          // SOLICITA QUE AO INVES DE FICAR 0,00 FIQUE VAZIO COMO NAS OUTRAS TELAS
          // FA
          edtValTot.Text := '';
      End
      Else
      Begin
          // REQ 67169
          // SOLICITA QUE AO INVES DE FICAR 0,00 FIQUE VAZIO COMO NAS OUTRAS TELAS
          // FA
        edtQtdChq.Text := '';
        edtValTot.Text := '';
      End;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmTransfCheqEmpresa.pCalculaTotalCheques]');
    End;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmTransfCheqEmpresa.btnCarrChequesClick(Sender: TObject);
begin
  inherited;
  if (fValidaCampos(edtCodEmpDest)) then
  begin
    if fValidaCamposDeData then
    begin
      pAtualizaTemporaria(True);
      pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
      pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
      dbgChequesDBTableView1.NavigatorButtons.First.Click;
    end;
  end;
end;

procedure TfrmTransfCheqEmpresa.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If(fValidaCampos(edtCodEmpDest))Then
  Begin
    If (Not fEmptyStr(edtTotalSelecionado.Text))  And
       (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
    Begin
      If fTransfCheques Then
      Begin
        If (fMensagem('', 'Imprimir Relatório de Cheques Transferidos?', ['&Sim', '&Não']) = 1) Then
        Begin
          pImprimeChqTransferidos;
        End;

        pAtualizaTemporaria(False);
        If Not cdsCheque.IsEmpty Then
        Begin
          pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
          pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
        End
        Else
          pLimpaDados;
      End;
      pSetFocus(Self);
      cdsCheque.EnableControls;
      dbgChequesDBTableView1.NavigatorButtons.First.Click;
    End
    else
    begin
      fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    end;

  End;
end;

procedure TfrmTransfCheqEmpresa.btnDesmTodosClick(Sender: TObject);
begin
  inherited;
  pManipulaPanels(False);
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodos;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cheques!';
  frmGravando.ShowModal;
  pManipulaPanels(True);
end;

procedure TfrmTransfCheqEmpresa.btnSairTransfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmTransfCheqEmpresa.pCarregaEmpresa(edtCodigo, edtNome: TEditFocus);
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodigo.Text);
  With qryConEmp Do
  Begin
    edtNome.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmTransfCheqEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    btnDesmTodos.Click;
    pSetFocus(pnlCabecalho);
  End

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
    pSetFocus(pnlCabecalho);
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

end;

procedure TfrmTransfCheqEmpresa.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If (fValidaCampos(edtCodEmpDest))Then
  Begin
    If cdsCheque.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
      Exit;
    End;

    If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
    Begin
      If Not cdsCheque.FindNext Then
        fMensagem('ATENÇÃO!', 'Não há cheques para serem transferidos!', ['&O k']);
    End
    Else
      fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
  End;

end;

procedure TfrmTransfCheqEmpresa.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pManipulaPanels(False);
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodos;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques!';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pManipulaPanels(True);
end;

procedure TfrmTransfCheqEmpresa.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If(fValidaCampos(edtCodEmpDest))Then
  begin
    If (cdsCheque.IsEmpty)    Then
    Begin
      fMensagem('', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
      Exit;
    End;

    Try
      pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
      frmBuscaCheques.ShowModal;

      If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
      Begin
        strValorFiltro := frmBuscaCheques.strValorFiltro;
        strCampoFiltro := frmBuscaCheques.strCampoFiltro;
        cdsCheque.FindFirst;
        If Not cdsCheque.FindFirst Then
        Begin
          fMensagem('ATENÇÃO!', 'Não há cheques para serem transferidos!', ['&O k']);
        End;

      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmTransfCheqEmpresa.btnIniBusClick]');
      End;
    End;


    pFreeAndNil(frmBuscaCheques);
  End;

end;

procedure TfrmTransfCheqEmpresa.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmTransfCheqEmpresa.edtCodEmpDestKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpDest, edtNomEmpDest, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpDest) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmTransfCheqEmpresa.edtOrdemExit(Sender: TObject);
begin
  inherited;

  if (fEmptyStr(edtOrdem.Text)) then
  begin
    fMensagem('AVISO', 'Opção Inválida. Selecione "C" ou "V".', ['&O K']);
    pSetFocus(edtOrdem);
  end;
end;

function TfrmTransfCheqEmpresa.fDesmarcarTodos(
  pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  result := true;
  If(fValidaCampos(edtCodEmpDest))Then
  Begin
    If cdsCheque.IsEmpty Then
    Begin
      fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
      Exit;
    End;
    pgbStatus.Properties.Max := cdsCheque.RecordCount;
    With cdsCheque Do
    Begin
      Try
        pDisableControls(cdsCheque, prcScroll);
        AggregatesActive := False;
        If IsEmpty Then
          Exit;

        First;
        While Not Eof Do
        Begin
          pMarcaCheque(False, 0, '');
          pStep(pgbStatus);
          Next;
        End;
      Finally
        First;
        pEnableControls(cdsCheque, prcScroll);
      End;
    End;
    dbgChequesDBTableView1.NavigatorButtons.First.Click;
    cdsCheque.AggregatesActive := True;
    pAtualizaDados(cdsCheque);
    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  End;
end;

function TfrmTransfCheqEmpresa.fMarcarTodos(
  pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  Result := True;
  If(fValidaCampos(edtCodEmpDest))Then
  Begin
    If cdsCheque.IsEmpty Then
    Begin
      fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
      Exit;
    End;
    pgbStatus.Properties.Max := cdsCheque.RecordCount;
    With cdsCheque Do
    Begin
      If IsEmpty Then
        Exit;
      Try
        pDisableControls(cdsCheque, prcScroll);
        AggregatesActive := False;
        First;

        while not Eof do
        begin
          //FECHAMENTO FINANCEIRO
          if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmpOri.Text, cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime) then
            Exit
          else
          if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmpDest.Text, cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime) then
            Exit;

          Next;
        end;

        First;
        While (Not Eof) Do
        Begin
          {***********************************}
          {* VERIFICANDO SE O REGISTRO ATUAL *}
          {* JA ESTA MARCADO. SE ESTIVER TEM *}
          {* QUE ATUALIZA-LO COM A EMPRESA E *}
          {* DATA DE TRANSFERENCIA DIGITADA  *}
          {********************************AN*}
          If Not cdsCheque.FieldByName('CHQ_DTATRF').IsNull Then
            pMarcaCheque(False, 0, '');

          pSelecionaCheque;
          pStep(pgbStatus);
          Next;
        End;
      Finally
        First;
        pEnableControls(cdsCheque, prcScroll);
      End;
    End;
    dbgChequesDBTableView1.NavigatorButtons.First.Click;
    cdsCheque.AggregatesActive := True;
    pAtualizaDados(cdsCheque);
    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  End;
end;

procedure TfrmTransfCheqEmpresa.pTransfereChq(strEmpTrf, strCodBco, strNumAge,
  strConCor, strNumChq: String);
  Var
    strSQL: String;
    qryGenChq: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE CADCHQ ';
  strSQL := strSQL + ' SET CHQ_CODEMP = :CODEMP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CHQ_CODBCO = :CODBCO AND';
  strSQL := strSQL + '   CHQ_NUMAGE = :NUMAGE AND';
  strSQL := strSQL + '   CHQ_CONCOR = :CONCOR AND';
  strSQL := strSQL + '   CHQ_NUMCHQ = :NUMCHQ ';

  qryGenChq := fCriaQuery(Self);
  With qryGenChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strEmpTrf;
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('NUMAGE').AsString := strNumAge;
    ParamByName('CONCOR').AsString := strConCor;
    ParamByName('NUMCHQ').AsString := strNumChq;
    ExecSQL;
  End;
  FreeAndNil(qryGenChq);
end;

procedure TfrmTransfCheqEmpresa.pImprimeChqTransferidos;
begin
  With cdsCheque Do
  Begin
    If IsEmpty Then
      Exit;

    OnFilterRecord := Nil;
    DisableControls;
    Filter := 'CHQ_DTATRF IS NOT NULL';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      Try
        Self.frxDBCheques.DataSet := cdsCheque;

        TfrxMemoView(Self.frxTransfChequeEmpresa.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
        Self.frxTransfChequeEmpresa.DotMatrixReport             := False;
        Self.frxTransfChequeEmpresa.PrintOptions.PrintMode      := pmScale;
        Self.frxTransfChequeEmpresa.PrintOptions.PrintOnSheet   := 9;
        Self.frxTransfChequeEmpresa.Script.Variables['EMPRESA']  := fRetNomeEmpresa;

        Self.frxTransfChequeEmpresa.Script.Variables['EMPRESAORIGEM']   := edtCodEmpOri.Text  + ' - ' + edtNomEmpOri.Text;;
        Self.frxTransfChequeEmpresa.Script.Variables['EMPRESADESTINO']  := edtCodEmpDest.Text + ' - ' + edtNomEmpDest.Text;

        pPreviewReport('TfrmTransfCheqEmpresa.pImprimeChqTransferidos',
                       'Transferência de cheque entre empresas ',
                       Self.frxTransfChequeEmpresa);

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
    End
    Else
    Begin
      fMensagem('', 'Não há dados para gerar o relatório!', ['&Ok']);
    End;

    Filtered := False;
    Filter   := '';
    EnableControls;
    OnFilterRecord := pFilterRecord;
  End;
end;

End.

