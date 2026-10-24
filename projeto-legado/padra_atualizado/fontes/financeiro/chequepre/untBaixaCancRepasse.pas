unit untBaixaCancRepasse;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids,
  Mask, Uni, MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, EditFocus,
  AppEvnts, UniClientDataSet, BitBtnLockedIncrem, frxClass, Messages,
  frxExportCSVTestabilidade, cxProgressBar, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, untFechamentoFinanceiro,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, untBuscaCheques;

type
  TfrmBaixaCancRepasse = class(TfrmPaiSimples)
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
    edtCodPortador: TEditFocus;
    Label4: TLabel;
    edtDesPortador: TEditFocus;
    Label13: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    mskDtaVenIni: TcxDateEdit;
    mskDtaVenFin: TcxDateEdit;
    dbgCheques: TcxGrid;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesDadosCHQ_CODBCO: TcxGridDBColumn;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODPOR: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    dbgChequesNivel: TcxGridLevel;
    FlwPnlBotoesBaixa: TFlowPanel;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgCheques1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgCheques1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    strValorFiltro: String;
    strCampoFiltro: String;

    qryConPor: TUniQuery;
    qryConEmp: TUniQuery;
    cdsCheque: TUniClientDataSet;
    dtsCheque: TDataSource;

    strCodPor,
    strCodCta,
    strPorDeb,
    strCtaDeb,
    strPorCre,
    strCtaCre,
    strHist01,
    strNumChq,
    strEmpChq,
    strCodCli,
    strCodBco,
    strNumAge,
    strConCor,
    strNomEmi,
    strHistc1,
    strHistc2: String;
    fltValChq: Double;
    dtaDtaLan: TDateTime;
    objFechamento: TFechamentoFinanceiro;

    procedure pAtualizaTemporaria;
    procedure pCalculaTotalCheques;
    procedure pCalculaValoresInformativos;
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pSelecionaCheque;
    procedure pMarcaCheque(blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
    procedure pCarregaPortador;
    procedure pCarregaEmpresa;
    function  fCancelaRepasseCheques(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pSetaVariaveis;
    function  fUpdateChequeRepasse: Boolean;
    function  fGravaCreditoMovBan: Boolean;
    function  fGravaDebitoMovBan: Boolean;

    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
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

uses SysUtils, Graphics, Forms, strUtils, UniDataSetProvider, untFuncoesGenerica,
  untFuncoesSimples, untPesqAux, untDigPortador, untCadChq,
  untMovBan, untConsultas, untTypesSistema, untTCadChqRepository, untGravando,
  Variants, untTBanChqRepository;

{$R *.dfm}

procedure TfrmBaixaCancRepasse.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False) Or
     Not fValidaCampos(mskDtaIni,False)  Or
     Not fValidaCampos(mskDtaFin,False)  Or
     Not fValidaCampos(edtCodPortador, False) Then
      Exit;

   If Not fValidaCampos(mskDtaCadIni, False) And
     Not fValidaCampos(mskDtaCadFin, False) Or
     Not fValidaCampos(mskDtaCadIni,False)  Or
     Not fValidaCampos(mskDtaCadFin,False)  Or
     Not fValidaCampos(edtCodPortador, False) Then
      Exit;


    If Not fValidaCampos(mskDtaVenIni, False) And
     Not fValidaCampos(mskDtaVenFin, False) Or
     Not fValidaCampos(mskDtaVenIni,False)  Or
     Not fValidaCampos(mskDtaVenFin,False) Or
     Not fValidaCampos(edtCodPortador, False) Then
      Exit;


  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  If Not cdsCheque.IsEmpty Then
  Begin
    cdsCheque.DisableControls;
    pCalculaTotalCheques;
    pCalculaValoresInformativos;
    pSetFocus(dbgCheques);
    cdsCheque.EnableControls;
  End;
end;

procedure TfrmBaixaCancRepasse.btnDesmTodosClick(Sender: TObject);
begin
  inherited;

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('','É necessário ter registros para desmarcar',['&Ok ']);
    Exit;
  End;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmBaixaCancRepasse.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

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

procedure TfrmBaixaCancRepasse.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  Close;
end;

function TfrmBaixaCancRepasse.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin


    {*****************************************}
    {* VALIDAÇÃO DATA DE CADASTRO            *}
    {**************************************LE*}

    If (Sender = mskDtaCadFin) Then
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
    {* VALIDAÇÃO DATA DE REPASSE             *}
    {**************************************LE*}
    Else If (Sender = mskDtaFin) Then
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
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
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
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text))) and (StrToDateDef(mskDtaVenIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaVenIni;
      End;
    End

    Else If (Sender = edtCodPortador) Then
    Begin

      If (fEmptyStr(edtCodPortador.Text)) Then
      Begin

        fMensagem('ATENÇÃO!', 'Informe o Portador para gravação no Movimento Bancário quando o Portador do Cheque estiver em branco!', ['&Ok']);
        Result := False;

      End
      Else
      Begin
        pCarregaPortador;
        If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não está cadastrado!', ['&Ok']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPortador.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPortador.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;

      End

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
        End
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCancRepasse.pAtualizaTemporaria;
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
    strSQL := strSQL + '  Q.CHQ_PORCRE, ';
    strSQL := strSQL + '  Q.CHQ_CTACRE, ';
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
    strSQL := strSQL + '  CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
    strSQL := strSQL + '  " " AS CHQ_MARDES, ';
    strSQL := strSQL + '  Q.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q ';
    strSQL := strSQL + '  LEFT JOIN CADBCO B on B.BCO_CODBCO = Q.CHQ_CODBCO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_DTAREP IS NOT NULL AND ';
    strSQL := strSQL + '  COALESCE(Q.CHQ_DEVDEF, 0) = 0 ';

    If Not fEmptyStr(edtCodEmp.Text) Then
      strSQL := strSQL + '  AND Q.CHQ_CODEMP = '+QuotedStr(edtCodEmp.Text); 

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTAREP BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :DTACADINI AND :DTACADFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAVENINI AND :DTAVENFIN ';

    If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCUS, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORDEB, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCHQ, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

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

      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCheque);
        cdsCheque.Open;
        TFloatField(cdsCheque.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';
      End
      Else
      Begin
        fMensagem('', 'Não há cheques repassados no período selecionado!', ['&O k']);
        pSetFocus(mskDtaIni);
        blnMudarFoco := False;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCancRepasse.pAtualizaTemporaria]');
    End;
  End;
  dbgCheques.Repaint;
  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmBaixaCancRepasse.pCalculaTotalCheques;
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

procedure TfrmBaixaCancRepasse.pCalculaValoresInformativos;
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
      pMensagensErro(E.Message, '[TfrmBaixaCancRepasse.pCalculaValoresInformativos]');
    End;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCancRepasse.pAtualizaDados(DataSet: TDataSet);
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

procedure TfrmBaixaCancRepasse.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmBaixaCancRepasse.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
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

procedure TfrmBaixaCancRepasse.pMarcaCheque(blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
  Var
    strPorDeb: String;
    blnUpdPorDeb: Boolean;
    frmDigPortador : TfrmDigPortador;
begin

  strPorDeb := cdsCheque.FieldByName('CHQ_PORDEB').AsString;
  blnUpdPorDeb := False;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(cdsCheque.FieldByName('CHQ_CODEMP').AsString, cdsCheque.FieldByName('CHQ_DTAREP').AsDateTime) then
    Exit;

  If fEmptyStr(strPorDeb) Then
  Begin
    fMensagem('', 'Portador para débito em branco!', ['&Ok']);
    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.Caption := 'Informe o Portador para o débito';
    frmDigPortador.ShowModal;
    If frmDigPortador.blnConfirma Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor, cdsCheque.FieldByName('CHQ_CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa "'+ cdsCheque.FieldByName('CHQ_CODEMP').AsString +'" sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
      End;

      strPorDeb := frmDigPortador.strCodPor;
      FreeAndNil(frmDigPortador);
      blnUpdPorDeb := True;
    End Else
    Begin
      FreeAndNil(frmDigPortador);
      Exit;
    End;
  End;

  With cdsCheque Do
  Begin
    IF blnMarcar THEN
    BEGIN
      If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        Cancel;
        If Not blnMarcarTodos Then
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;
    END
    ELSE
      fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    If blnUpdPorDeb Then
      FieldByName('CHQ_PORDEB').Value := strPorDeb;
    FieldByName('CHQ_MARDES').Value := IIF(blnMarcar, 'M', 'D');
    Post;
  End;

  pCalculaValoresInformativos;
end;

procedure TfrmBaixaCancRepasse.pSelecionaCheque;
begin
  If Not cdsCheque.IsEmpty Then
    pMarcaCheque(cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M');
end;

procedure TfrmBaixaCancRepasse.dbgCheques1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}
  If (Key = VK_Return) Then
    pSelecionaCheque
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaIni);
  End;
end;

procedure TfrmBaixaCancRepasse.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var strMarDes : String;
begin
  inherited;
   With cdsCheque Do
   Begin
    If Not Active Then
      Exit;

    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_MARDES.Index]);

    If strMarDes = 'M' Then
      If Not AViewInfo.Selected Then
       ACanvas.Font.Color := clBlue;
   End;

end;

procedure TfrmBaixaCancRepasse.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) And Not(cdsCheque.IsEmpty)Then
  Begin
    pSelecionaCheque;
    pSetFocus(dbgCheques);
    dbgChequesDados.NavigatorButtons.Next.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaIni);
  End;
end;

procedure TfrmBaixaCancRepasse.pLimpaDados;
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

procedure TfrmBaixaCancRepasse.dbgCheques1DrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With cdsCheque Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('CHQ_MARDES').AsString = 'M' Then
    Begin
      dbgCheques.Canvas.Font.Color := clBlue;
    End;
  End;

end;

procedure TfrmBaixaCancRepasse.btnConfirmaClick(Sender: TObject);
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
    cdsCheque.DisableControls;

    If fMensagem('', 'Confirma cancelamento do repasse dos cheques selecionados?', ['&Sim', '&Não']) = 1 Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fCancelaRepasseCheques;
      frmGravando.lblGravando.Caption := 'Aguarde... Cancelando Repasse do(s) Cheque(s).';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
      If Not cdsCheque.IsEmpty Then
      Begin
        pCalculaValoresInformativos;
        pCalculaTotalCheques;
      End
      Else
        pLimpaDados;

      pMensagemOK('Se foi feito a baixa de algum título com o valor do cheque repassado, é necessário estornar esse título para que o portador de repasse não fique negativo!');
    End;
    pSetFocus(Self);
  End;
  cdsCheque.EnableControls;
end;

function TfrmBaixaCancRepasse.fCancelaRepasseCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin
  Result := False;

  Application.ProcessMessages;
  repCadChq := TCadChqRepository.Create;

  With cdsCheque Do
  Begin
    Try
      fStartTransaction;

      First;
      Result := True;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := RecordCount;
      While Not Eof Do
      Begin

        If FieldByName('CHQ_MARDES').AsString = 'M' Then
        Begin
          pStep(pgbStatus);
          pSetaVariaveis;

          If Not fUpdateChequeRepasse Then
            Result := False;

          If (Result) And (Not cdsCheque.FieldByName('CHQ_PORDEB').IsNull) And (Not cdsCheque.FieldByName('CHQ_CTADEB').IsNull) Then
          Begin
            If Not fGravaCreditoMovBan Then
              Result := False;
          End;

          If (Result) And (Not cdsCheque.FieldByName('CHQ_PORCRE').IsNull) And (Not cdsCheque.FieldByName('CHQ_CTACRE').IsNull) Then
          Begin
            If Not fGravaDebitoMovBan Then
              Result := False;
          End;

          If Not Result Then
            Break;

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
        End;

        Next;
      End;

      If (Result) Then
      begin
        fCommit;

        {**************************}
        {* GRAVA LOG DO CADCHQ(X) *}
        {***********************JU*}
        repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                            FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                            'CANCELAMENTO DE REPASSE (frmBaixaCancRepasse.fCancelaRepasseCheques)');
      end
      Else
        fRollBack;

    Except
      fRollBack;
    End;
  End;

  If Assigned(repCadChq) Then
    FreeAndNil(repCadChq);
end;



{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmBaixaCancRepasse.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmBaixaCancRepasse.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples,
                   Self,
                   edtCodPortador,
                   edtDesPortador,
                   qryConPor,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If (fValidaCampos(edtCodPortador, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmBaixaCancRepasse.pCarregaEmpresa;
begin
  pPesquisaCadEmp(Nil, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    EdtDesEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmBaixaCancRepasse.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPortador.Text);
  With qryConPor Do
  Begin
    edtDesPortador.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmBaixaCancRepasse.pDestravaCheques;
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
    while not eof do
    begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
      End;
      Next;
    end;
    Filter := '';
    Filtered := False;
    OnFilterRecord := pFilterRecord;
  End;
  pEnableControls(cdsCheque, prcScroll);
end;

function TfrmBaixaCancRepasse.fUpdateChequeRepasse: Boolean;
begin

  Result := True;

  Try
    With cdsCheque Do
    Begin
      pCancelaRepasse(FieldByName('CHQ_CODBCO').AsString,
                      FieldByName('CHQ_NUMAGE').AsString,
                      FieldByName('CHQ_CONCOR').AsString,
                      FieldByName('CHQ_NUMCHQ').AsString,
                      FieldByName('CHQ_CODEMP').AsString);
    End;

  Except
    On E: Exception Do
    Begin
    	pMensagensErro(E.Message,'[TfrmBaixaCancRepasse.fUpdateChequeRepasse]');
      Result := False;
    End;
  End;

end;

function TfrmBaixaCancRepasse.fGravaCreditoMovBan: Boolean;
  Var
    lstBanChq : TBanChqRepository;
begin

  Result := True;

  lstBanChq := TBanChqRepository.Create;
  lstBanChq.fAdd(strCodBco,
                 strNumAge,
                 strConCor,
                 strNumChq,
                 strCodCli,
                 strNomEmi,
                 strHistc1,
                 strHistc2,
                 strEmpChq,
                 '',
                 fltValChq);

  If fGravaMovBan(strCtaDeb,                        // Centro de Custo Debito
                  strPorDeb,                        // Portador da Baixa Debito
                  strLoginUsuarioLogado,            // Operador da Baixa
                  dtaDtaLan,                        // Data do Lançamento
                  fTime(),                          // Hora do Lançamento
                  strNumChq,                        // Numero do Documento
                  'C',                              // Credito / Debito
                  VS_strCodEmp,                     // Empresa da Baixa
                  fltValChq,                        // Valor Do Lançamento
                  strHist01,                        // Histórico 1
                  '',                               // Histórico 2
                  strCodCli,                        // Cliente da Duplicata
                  '',                               // Fornecedor da Duplicata
                  strNumChq,                        // Número da Duplicata
                  0,                                // Sequencial de Baixa
                  '',                               // Parcela da Duplicata
                  strEmpChq,                        // Empresa da Duplicata
                  '',                               // Série
                  '',                               // Código do Evento
                  '',                               // Documento baixado
                  lstBanChq.fGetList                // Log Bancário
                 ) = '' Then

  Result := False;

  lstBanChq.pClear;
  FreeAndNil(lstBanChq);
end;

function TfrmBaixaCancRepasse.fGravaDebitoMovBan: Boolean;
  Var
    lstBanChq : TBanChqRepository;
begin

  Result := True;

  lstBanChq := TBanChqRepository.Create;
  lstBanChq.fAdd(strCodBco,
                 strNumAge,
                 strConCor,
                 strNumChq,
                 strCodCli,
                 strNomEmi,
                 strHistc1,
                 strHistc2,
                 strEmpChq,
                 '',
                 fltValChq);

  If fGravaMovBan(strCtaCre,                        // Centro de Custo Credito
                  strPorCre,                        // Portador da Baixa Credito
                  strLoginUsuarioLogado,            // Operador da Baixa
                  dtaDtaLan,                        // Data do Lançamento
                  fTime(),                          // Hora do Lançamento
                  strNumChq,                        // Numero do Documento
                  'D',                              // Credito / Debito
                  VS_strCodEmp,                     // Empresa da Baixa
                  fltValChq,                        // Valor Do Lançamento
                  strHist01,                        // Histórico 1
                  '',                               // Histórico 2
                  strCodCli,                        // Cliente da Duplicata
                  '',                               // Fornecedor da Duplicata
                  strNumChq,                        // Número da Duplicata
                  0,                                // Sequencial de Baixa
                  '',                               // Parcela da Duplicata
                  strEmpChq,                        // Empresa da Duplicata
                  '',                               // Série
                  '',                               // Código do Evento
                  '',                               // Documento baixado
                  lstBanChq.fGetList                // Log Bancário
                 ) = '' Then

  Result := False;

  lstBanChq.pClear;
  FreeAndNil(lstBanChq);
end;

procedure TfrmBaixaCancRepasse.pSetaVariaveis;
begin
  With cdsCheque Do
  Begin
    strCodPor := FieldByName('CHQ_CODPOR').AsString;

    If fEmptyStr(strCodPor) Then
      strCodPor := edtCodPortador.Text;

    strCodCta := FieldByName('CHQ_CODCTA').AsString;
    strPorDeb := FieldByName('CHQ_PORDEB').AsString;
    strCtaDeb := FieldByName('CHQ_CTADEB').AsString;
    strPorCre := FieldByName('CHQ_PORCRE').AsString;
    strCtaCre := FieldByName('CHQ_CTACRE').AsString;
    If FieldByName('CHQ_DTADEP').AsDateTime > VS_Date Then
      dtaDtaLan := FieldByName('CHQ_DTADEP').AsDateTime
    Else
      dtaDtaLan := VS_Date;
    fltValChq := FieldByName('CHQ_VALCHQ').AsFloat;
    strHist01 := 'CANCEL. DO REPASSE CHEQUES No. ' + FieldByName('CHQ_NUMCHQ').AsString;
    strNumChq := FieldByName('CHQ_NUMCHQ').AsString;
    strEmpChq := FieldByName('CHQ_CODEMP').AsString;
    strCodCli := FieldByName('CHQ_CODCLI').AsString;
    strCodBco := FieldByName('CHQ_CODBCO').AsString;
    strNumAge := FieldByName('CHQ_NUMAGE').AsString;
    strConCor := FieldByName('CHQ_CONCOR').AsString;
    strNomEmi := FieldByName('CHQ_NOMEMI').AsString;
    strHistc1 := FieldByName('CHQ_HIST01').AsString;
    strHistc2 := FieldByName('CHQ_HIST02').AsString;
  End;

end;

procedure TfrmBaixaCancRepasse.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
    FrmBuscaCheques.lblDtaFil.Caption := 'Dta.Ven.';
    frmBuscaCheques.ShowModal;
  Finally
    TfrmGravando.fExecutarModal(pBuscaIni,'Aguarde... Localizando Cheque.','');
    FreeAndNil(frmBuscaCheques);
  End;

end;

procedure TfrmBaixaCancRepasse.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque','');

end;

procedure TfrmBaixaCancRepasse.FormKeyDown(Sender: TObject; var Key: Word;
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
  End

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;


end;

procedure TfrmBaixaCancRepasse.FormShow(Sender: TObject);
begin
  inherited;
  {**************************************}
  If (fCfgSis('CTP_AS') = 'S') Then
  Begin
    pMensagemOK('A Baixa do Contas a Pagar está configurada como Sintética.' + #13 + 'O cancelamento do repasse é feito automaticamente ao estornar o título do contas a pagar!');
    PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmBaixaCancRepasse.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;


function TfrmBaixaCancRepasse.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin
    Try
      DisableControls;
      First;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := RecordCount;

      while not Eof do
      begin
        //FECHAMENTO FINANCEIRO
        if objFechamento.FechamentoFinanceiroJaRealizado(cdsCheque.FieldByName('CHQ_CODEMP').AsString, cdsCheque.FieldByName('CHQ_DTAREP').AsDateTime) then
        begin
          Result := False;
          Exit;
        end;

        Next;
      end;

      First;
      While Not Eof Do
      Begin
        pStep(pgbStatus);
        pMarcaCheque(True, True);
        Next;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
    First;
  End;
  cdsCheque.EnableControls;
  Result := True;

End;


function TfrmBaixaCancRepasse.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin
    Try
      First;
      DisableControls;
      While Not Eof Do
      Begin
        pStep(pgbStatus);
        pMarcaCheque(False);
        Next;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
   End;
   First;
  End;
  cdsCheque.EnableControls;
  Result := True;

End;

procedure TfrmBaixaCancRepasse.pStep(pgbStatus: TcxProgressBar);
Begin

 If Assigned(pgbStatus) Then
 Begin
  pgbStatus.Position := pgbStatus.Position + 1;
  Application.ProcessMessages;
 End;

End;

procedure TfrmBaixaCancRepasse.pBuscaIni;
Begin

  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBuscaCheques.strValorFiltro;
      strCampoFiltro := IIF(frmBuscaCheques.strCampoFiltro = 'CHQ_DTACAD','CHQ_DTAVEN', frmBuscaCheques.strCampoFiltro);
      If Not cdsCheque.FindFirst Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há cheques a serem repassados!', ['&O k']);
      End;
      pSetFocus(dbgCheques);
    End;

End;

procedure TfrmBaixaCancRepasse.pBuscaProx;
Begin

  If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsCheque.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há cheques a serem repassados!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

End;

end.

