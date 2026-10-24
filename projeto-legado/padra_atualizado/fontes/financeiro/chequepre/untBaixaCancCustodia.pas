unit untBaixaCancCustodia;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  Uni, MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, EditFocus, AppEvnts,
  UniClientDataSet, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxProgressBar, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxDataControllerConditionalFormattingRulesManagerDialog, untBuscaCheques;

type
  TfrmBaixaCancCustodia = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
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
    pnlBotoesBaixa: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label23: TLabel;
    label9: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtConCor: TEditFocus;
    edtNumChq: TEditFocus;
    edtNomEmi: TEditFocus;
    edtEndere: TEditFocus;
    edtFone01: TEditFocus;
    edtNumNot: TEditFocus;
    edtDtaVen: TEditFocus;
    edtValChq: TEditFocus;
    edtChqSelecionados: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    edtTotalCheques: TEditFocus;
    edtValorTotal: TEditFocus;
    Label4: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lbl1: TLabel;
    edtLotCus: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    mskDtaCadIni: TcxDateEdit;
    mskDtaVenFin: TcxDateEdit;
    mskDtaVenIni: TcxDateEdit;
    dbgCheques: TcxGrid;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesDadosCHQ_CODBCO: TcxGridDBColumn;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    dbgChequesNivel: TcxGridLevel;
    FlwPnlBotoesBaixa: TFlowPanel;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    cdsCheque: TUniClientDataSet;
    dtsCheque: TDataSource;
    qryConEmp: TUniQuery;

    strValorFiltro: String;
    strCampoFiltro: String;

    procedure pAtualizaTemporaria;
    procedure pCalculaTotalCheques;
    procedure pCalculaValoresInformativos;
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pSelecionaCheque;
    procedure pMarcaCheque(blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
    procedure pCarregaEmpresa;
    procedure pFilterRecord(DataSet: TDataSet;
    var Accept: Boolean);
    function fCancelaCustodiaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pBuscaIni;
    procedure pBuscaProx;

    procedure pDestravaCheques;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Graphics, Forms, StrUtils, UniDataSetProvider, untFuncoesGenerica,
  untfuncoesSimples, untPesqAux, untCadChq, untConsultas, untTypesSistema,
  untTCadChqRepository, untGravando, Variants;

{$R *.dfm}

procedure TfrmBaixaCancCustodia.btnDesmarcarTodasClick(Sender: TObject);
begin

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

end;

procedure TfrmBaixaCancCustodia.btnIniBusClick(Sender: TObject);
begin
  inherited;

  If (Not cdsCheque.Active) Or (cdsCheque.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
    frmBuscaCheques.ShowModal;

    TfrmGravando.fExecutarModal(pBuscaIni,'Aguarde... Localizando Cheques.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCheques.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaCheques);

end;

procedure TfrmBaixaCancCustodia.btnLocProxClick(Sender: TObject);
begin
  inherited;
  //
  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque.','');
end;

procedure TfrmBaixaCancCustodia.btnMarcarTodasClick(Sender: TObject);
begin

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('','É necessário ter registros para marcar!',['&O K']);
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

end;

procedure TfrmBaixaCancCustodia.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  Close;
end;

function TfrmBaixaCancCustodia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin



    {*****************************************}
    {* VALIDAÇÃO DATA DE CUSTÓDIA            *}
    {**************************************LE*}
    If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (StrToDateDef(mskDtaFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (StrToDateDef(mskDtaIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
        End;
    End

    {*****************************************}
    {* VALIDAÇÃO DATA DE CADASTRO            *}
    {**************************************LE*}
    Else If (Sender = mskDtaCadFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And (StrToDateDef(mskDtaCadFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) Then
          Begin
            If StrToDate(mskDtaCadIni.Text) > StrToDate(mskDtaCadFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaCadIni;
            End;
          End;
        End;
    End
    Else
    If (Sender = mskDtaCadIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text))) And (StrToDateDef(mskDtaCadIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaCadIni;
        End;
    End

    {*****************************************}
    {* VALIDAÇÃO DATA DE VENCIMENTO          *}
    {**************************************LE*}
    Else If (Sender = mskDtaVenFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text)) And (StrToDateDef(mskDtaVenFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text))) Then
          Begin
            If StrToDate(mskDtaVenIni.Text) > StrToDate(mskDtaVenFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaVenIni;
            End;
          End;
        End;
    End
    Else
    If (Sender = mskDtaVenIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text))) And (StrToDateDef(mskDtaVenIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaVenIni;
        End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (Not fEmptyStr(edtCodEmp.Text)) Then
      Begin
        pCarregaEmpresa;

        If (qryConEmp.FieldByName('EMP_CODEMP').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['OK']);
          Result:=False;
        End;
      End

      Else edtDesEmp.Text := 'TODOS';

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCancCustodia.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCheque: TUniQuery;
    dspCheque: TUniDataSetProvider;
begin
  Try
    pDestravaCheques;
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
    strSQL := strSQL + '  Q.CHQ_DTATRA, ';
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
    strSQL := strSQL + '  Q.CHQ_CODCMC, ';
    strSQL := strSQL + '  " " AS CHQ_MARDES, ';
    strSQL := strSQL + '  Q.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADBCO B ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
    strSQL := strSQL + '  Q.CHQ_DTACUS IS NOT NULL ';

    if Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + '  AND Q.CHQ_CODEMP = ' + QuotedStr(edtCodEmp.Text);

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTACUS BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :DTACADINI AND :DTACADFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAVENINI AND :DTAVENFIN ';

    If Not fEmptyStr(edtLotCus.Text) Then
      strSQL := strSQL + '  AND Q.CHQ_LOTCUS = :LOTCUS ';

    With qryCheque Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        ParamByName('DTACADINI').AsDateTime := StrToDateTime(mskDtaCadIni.Text);
        ParamByName('DTACADFIN').AsDateTime := StrToDateTime(mskDtaCadFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      Begin
        ParamByName('DTAVENINI').AsDateTime := StrToDateTime(mskDtaVenIni.Text);
        ParamByName('DTAVENFIN').AsDateTime := StrToDateTime(mskDtaVenFin.Text);
      End;

      If Not fEmptyStr(edtLotCus.Text) Then
        ParamByName('LOTCUS').AsString := edtLotCus.Text;

      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCheque);
        cdsCheque.Open;
        TFloatField(cdsCheque.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';
      End
      Else
      Begin
        fMensagem('', 'Não há cheques em custódia!', ['&O k']);
        pSetFocus(mskDtaIni);
        blnMudarFoco := False;
        pCalculaTotalCheques;
        pCalculaValoresInformativos;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCancCustodia.pAtualizaTemporaria]');
    End;
  End;

  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmBaixaCancCustodia.pCalculaTotalCheques;
begin
  With cdsCheque Do
  Begin
    If Not IsEmpty Then
    Begin
      edtTotalCheques.Text := IntToStr(RecordCount);
      If Not fEmptyStr(TAggregateField(FieldByName('CHQ_TOTCHQ')).Value) Then
        edtValorTotal.Text := FormatFloat('#,##0.00', TAggregateField(FieldByName('CHQ_TOTCHQ')).Value)
      Else
        edtValorTotal.Text := '0,00';
    End
    Else
    Begin
      edtTotalCheques.Text := '0';
      edtValorTotal.Text := '0,00';
    End;
  End;
end;

procedure TfrmBaixaCancCustodia.pCalculaValoresInformativos;
  Var
    cdsGen: TUniClientDataSet;
    fldGen: TAggregateField;
begin
  Try
    cdsGen := TUniClientDataSet.Create(Self);
    fldGen := TAggregateField.Create(Self);
    With fldGen Do
    Begin
      Name          := 'cdsGenTotChq';
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
      Filtered := False;
      Filter := 'CHQ_MARDES = ' + QuotedStr('M');
      Filtered := True;

      If Not cdsGen.IsEmpty Then
      Begin
        edtChqSelecionados.Text := IntToStr(RecordCount);
        If Not fEmptyStr(TAggregateField(FieldByName('CHQ_TOTCHQ')).Value) Then
          edtTotalSelecionado.Text := FormatFloat('#,##0.00', TAggregateField(FieldByName('CHQ_TOTCHQ')).Value)
        Else
          edtTotalSelecionado.Text := '0,00';
      End
      Else
      Begin
        edtChqSelecionados.Text := '0';
        edtTotalSelecionado.Text := '0,00';
      End;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCancCustodia.pCalculaValoresInformativos]');
    End;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCancCustodia.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    EdtDesEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmBaixaCancCustodia.pDestravaCheques;
Var
  prcScroll: TprcScroll;
begin
  With cdsCheque Do
  Begin
    If Not Active Then
      Exit;

    pDisableControls(cdsCheque, prcScroll);
    OnFilterRecord := Nil;
    Filter := 'CHQ_MARDES=' + QuotedStr('M');
    Filtered := True;

    First;
    While Not Eof do
    begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

      Next;
    end;
    Filter := '';
    Filtered := False;
    OnFilterRecord := pFilterRecord;
  End;
  pEnableControls(cdsCheque, prcScroll);
end;

procedure TfrmBaixaCancCustodia.pAtualizaDados(DataSet: TDataSet);
begin
  If cdsCheque.ControlsDisabled = False Then
  Begin
    edtCodBco.Text := DataSet.FieldByName('CHQ_CODBCO').AsString;
    edtNomBco.Text := DataSet.FieldByName('CHQ_NOMBCO').AsString;
    edtNumAge.Text := DataSet.FieldByName('CHQ_NUMAGE').AsString;
    edtConCor.Text := DataSet.FieldByName('CHQ_CONCOR').AsString;
    edtNumChq.Text := DataSet.FieldByName('CHQ_NUMCHQ').AsString;
    edtNomEmi.Text := DataSet.FieldByName('CHQ_NOMEMI').AsString;
    edtEndere.Text := DataSet.FieldByName('CHQ_ENDERE').AsString;
    edtFone01.Text := fFormataFone(DataSet.FieldByName('CHQ_TELEMI').AsString);
    edtNumNot.Text := DataSet.FieldByName('CHQ_NUMNOT').AsString;
    edtDtaVen.Text := DataSet.FieldByName('CHQ_DTAVEN').AsString;
    edtValChq.Text := FormatFloat('#,##0.00', DataSet.FieldByName('CHQ_VALCHQ').AsFloat);
  End;
end;

procedure TfrmBaixaCancCustodia.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmBaixaCancCustodia.FormCreate(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriaQuery(Self);

  strNomeTabela := 'CADCHQ';

  cdsCheque := TUniClientDataSet.Create(Self);
  cdsCheque.OnFilterRecord := pFilterRecord;
  cdsCheque.AfterScroll    := pAtualizaDados;

  dtsCheque := fCriaDataSource(cdsCheque);
  dbgChequesDados.DataController.DataSource := dtsCheque;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'cdsChequeTotChq';
    FieldName     := 'CHQ_TOTCHQ';
    DataSet       := cdsCheque;
    Expression    := 'SUM(CHQ_VALCHQ)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;
  cdsCheque.AggregatesActive := True;
end;

procedure TfrmBaixaCancCustodia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaIni);
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodas.Click;
  End
end;

procedure TfrmBaixaCancCustodia.pMarcaCheque(blnMarcar : Boolean; blnMarcarTodos: Boolean = False);
begin
  With cdsCheque Do
  Begin
    If blnMarcar Then
    Begin
      If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        If Not blnMarcarTodos Then
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;
    End
    Else
      fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    FieldByName('CHQ_MARDES').Value := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmBaixaCancCustodia.pSelecionaCheque;
begin

  If cdsCheque.IsEmpty Then
    Exit;

  If cdsCheque.FieldByName('CHQ_MARDES').AsString <>  'M'  Then
    pMarcaCheque(True)
  Else
    pMarcaCheque(False);

  pSetFocus(dbgCheques);
  dbgChequesDados.NavigatorButtons.Next.Click;

  pCalculaValoresInformativos;
end;

procedure TfrmBaixaCancCustodia.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var strMarDes : String;
begin
  With cdsCheque Do
  Begin
    If Not Active Then
      Exit;

    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_MARDES.Index]);

    If strMarDes = 'M' Then
      If (Not AViewInfo.Selected) Then
        ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmBaixaCancCustodia.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_Return) Then
    pSelecionaCheque;

end;

procedure TfrmBaixaCancCustodia.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqEmpresa( conEmpSimples,
                   Self,
                   edtCodEmp,
                   edtDesEmp,
                   qryConEmp,
                   Key,
                   arrSel)  then
  Begin
    If (fValidaCampos(edtCodEmp, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCancCustodia.pLimpaDados;
begin
  edtCodBco.Clear;
  edtNomBco.Clear;
  edtNumAge.Clear;
  edtConCor.Clear;
  edtNumChq.Clear;
  edtNomEmi.Clear;
  edtEndere.Clear;
  edtFone01.Clear;
  edtNumNot.Clear;
  edtDtaVen.Clear;
  edtValChq.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  edtLotCus.Clear;

  edtTotalCheques.Clear;
  edtValorTotal.Clear;

  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;

  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;

  mskDtaVenIni.Clear;
  mskDtaVenFin.Clear;

  pDestravaCheques;

  cdsCheque.Close;
end;

procedure TfrmBaixaCancCustodia.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False) Or
     Not fValidaCampos(mskDtaIni,False)  Or
     Not fValidaCampos(mskDtaFin,False)  Then
     Exit;

   If Not fValidaCampos(mskDtaCadIni, False) And
     Not fValidaCampos(mskDtaCadFin, False) Or
     Not fValidaCampos(mskDtaCadIni,False)  Or
     Not fValidaCampos(mskDtaCadFin,False)  Then
     Exit;


    If Not fValidaCampos(mskDtaVenIni, False) And
     Not fValidaCampos(mskDtaVenFin, False) Or
     Not fValidaCampos(mskDtaVenIni,False)  Or
     Not fValidaCampos(mskDtaVenFin,False)  Then
     Exit;

  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  If Not cdsCheque.IsEmpty Then
  Begin
   pCalculaTotalCheques;
   pCalculaValoresInformativos;
   pSetFocus(dbgCheques);
  End;

end;

procedure TfrmBaixaCancCustodia.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(edtTotalSelecionado.Text))  And
     (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
  Begin
    If fMensagem('', 'Confirma cancelamento da custódia dos cheques selecionados?', ['&Sim', '&Não']) = 1 Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao :=    fCancelaCustodiaCheques;
      frmGravando.lblGravando.Caption := 'Aguarde... Cancelando Envio de Cheques para Custódia.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      pAtualizaTemporaria;
      If Not cdsCheque.IsEmpty Then
      Begin
        pCalculaValoresInformativos;
        pCalculaTotalCheques;
      End
      Else
        pLimpaDados;
    End;
    pSetFocus(Self);
  End;
end;

function TfrmBaixaCancCustodia.fCancelaCustodiaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin

  Application.ProcessMessages;

  With cdsCheque Do
  Begin
    DisableControls;
    try
      First;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := RecordCount;

      repCadChq := TCadChqRepository.Create;

      While Not Eof Do
      Begin
        pStep(pgbStatus);

        If FieldByName('CHQ_MARDES').AsString = 'M' Then
        Begin

          pCancelaCustodia(FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODEMP').AsString);

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
          {********************}
          {* GRAVAR NO LOGCHQ *}
          {*****************JU*}
          repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                              FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                              'CANCELAMENTO DE CUSTODIA (frmBaixaCancCustodia.fCancelaCustodiaCheques)');
        End;

        Next;
      End;
    finally
      EnableControls;
    end;
    FreeAndNil(repCadChq);
  End;
  Result := True;

end;

procedure TfrmBaixaCancCustodia.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;


function TfrmBaixaCancCustodia.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin
    If IsEmpty Then
    Begin
      fMensagem('', 'É necessário ter registros para Marcar!', ['&Ok']);
      Result := False;
      Exit;
    End;


    DisableControls;
    cdsCheque.AggregatesActive := False;
    First;
    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;
    While Not Eof Do
    Begin
      pStep(pgbStatus);
      pMarcaCheque(True, True);
      Next;
    End;
    EnableControls;

    First;
  End;

  cdsCheque.AggregatesActive := True;
  dbgCheques.Repaint;
  pCalculaValoresInformativos;



 Result := True;


End;


function TfrmBaixaCancCustodia.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin
  With cdsCheque Do
  Begin
    First;

    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;
    DisableControls;
    While Not Eof Do
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M'  Then
      Begin
        pStep(pgbStatus);
        pMarcaCheque(False);
       End;
      Next;
    End;

    First;
  End;
  pCalculaTotalCheques;
  pCalculaValoresInformativos;
  cdsCheque.EnableControls;
  Result := True;


End;

procedure TfrmBaixaCancCustodia.pStep(pgbStatus: TcxProgressBar);
Begin

  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

End;

procedure TfrmBaixaCancCustodia.pBuscaIni;
Begin

 If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
 Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;
    If Not cdsCheque.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques para serem cancelados!', ['&O k']);
    End;
    pSetFocus(dbgCheques);
 End;

End;

procedure TfrmBaixaCancCustodia.pBuscaProx;
Begin

  If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsCheque.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há cheques para serem cancelados!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

End;
end.

