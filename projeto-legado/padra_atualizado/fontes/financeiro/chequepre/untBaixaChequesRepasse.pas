unit untBaixaChequesRepasse;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids,
  Mask, Uni, MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, EditFocus,
  AppEvnts, UniClientDataSet, untfuncoesSimples, BitBtnLockedIncrem, untTypesSistema,
  frxClass, System.Generics.Collections, untFuncoes, frxExportCSVTestabilidade,
  untBaixaAnaliticaCheqRepasse, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxContainer, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxProgressBar, TypesRel, untFuncoesRel2, untTBanChqRepository, untFuncoesRel,
  cxDataControllerConditionalFormattingRulesManagerDialog,untBuscaCheques,Forms;

type
  TfrmBaixaChequesRepasse = class(TfrmPaiSimples)
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
    dbgCheques2: TDBGridCitel;
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
    edtValorTotal: TEditFocus;
    edtTotalCheques: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    lblTotRep: TLabel;
    edtTotRep: TEditFocus;
    dbgCheques: TcxGrid;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesDadosCHQ_CODBCO: TcxGridDBColumn;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    dbgChequesNivel: TcxGridLevel;
    dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn;
    mskDtaCadIni: TcxDateEdit;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    btnCarrCheques: TBitBtnLocked;
    gpbLegenda: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape3: TShape;
    Label4: TLabel;
    Label8: TLabel;
    dbgChequesDadosCHQ_RESCAI: TcxGridDBColumn;
    pnlModalidades: TPanel;
    Label13: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    edtDinheiro: TEditFocus;
    edtChqVista: TEditFocus;
    edtOrdPag: TEditFocus;
    pnlTitulos: TPanel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtTitSel: TEditFocus;
    edtTitPrzMedVen: TEditFocus;
    Label31: TLabel;
    edtChqPrzMedVen: TEditFocus;
    dbgChequesDadosCHQ_DTATRA: TcxGridDBColumn;
    FlwPnlBotoesBaixa: TFlowPanel;
    dbgChequesDadosCHQ_TRFLIB: TcxGridDBColumn;
    grbCMC7: TGroupBox;
    chkLeitor: TCheckBox;
    chkInfMan: TCheckBox;
    lblCMC7: TLabel;
    edtCMC7: TEditFocus;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgCheques2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgCheques2DrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgCheques2DblClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkLeitorClick(Sender: TObject);
    procedure chkInfManClick(Sender: TObject);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    cdsCheque : TUniClientDataSet;
    dtsCheque: TDataSource;

    strValorFiltro: String;
    strCampoFiltro: String;

    strCodBan    : String;
    strNumChq    : String;
    strConCor    : String;
    strNumAge    : String;

    dtaDtaRep: TDateTime;

    strCtaDeb,
    strPorDeb,
    strNomPorBai,
    strCtaCred,
    strPorCred,
    strNomPorCred : String;

    strCtaDep: String;
    dtaDtaDep: TDateTime;

    strHistorChq: String;

    varRegistroChqPre: TRegistroVarChequesPre;
    arrCheques : TStringArray;

    strRcxTcc  : String;

    FLiberacaoTransferencia: Boolean;

    procedure pModCheque1;
    procedure pModCheque2;

    procedure pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
    procedure pAtualizaTemporaria;
    procedure pCalculaTotalCheques(edtQtdChq, edtValTot: TEditFocus; blnFiltrar: Boolean);
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pSelecionaCheque();
    procedure pMarcaCheque(blnMarcar: Boolean; dtaDtaDep: TDateTime; strCtaDep: String;
                           blnMarcarTodos: Boolean = False);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    function fRepassaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fRepassaChequesBaiCtp(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    function fDigInfCheques: Boolean;
    procedure pBuscaIni;
    procedure pBuscaProx;
    function fDigInfoBaixa : Boolean;

    procedure pSetaVencimentosTitulos;
    procedure pSetaCalculoTitulos;
    function fBaixaSomenteResumoCaixa: Boolean;
    function fMaiorDtaCad(): TDateTime;

    function fGravaMovBanAna: String;
    procedure pGravaMovBanSin(arrBaiChq: Array Of TBaixaCheque);

    procedure pDestravaCheques;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    arrEmpresa : TConsultasArray;
    strEmpresa : String;
    blnBaiCtp  : Boolean;
    fltTotRep  : Double;

    strDtaLan: String;
    strForRep: String;
    strObsRep: String;

    dicRepChq : TDictionary<String,TChequeRepassado>;
    cdsCloneCtaPag: TUniClientDataSet;
    bnExiRel : Boolean;
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils, UniDataSetProvider,
  untFuncoesGenerica, untBaixaDigRepasse, untConsultas, untBaixaDigCheque,
  untMovBan, untCadChq, untFuncoesConsulta,
  untTCadChqRepository, untGravando, DateUtils, untTCadChq, untUtilRepository;

{$R *.dfm}

procedure TfrmBaixaChequesRepasse.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  Close;
end;

procedure TfrmBaixaChequesRepasse.chkInfManClick(Sender: TObject);
begin
  inherited;
  If chkInfMan.Checked Then
    Begin
      chkLeitor.Checked := FALSE;
      lblCMC7.Caption := 'Digite o código CMC7';
    End;
  pSetFocus(edtCMC7);
end;

procedure TfrmBaixaChequesRepasse.chkLeitorClick(Sender: TObject);
begin
  inherited;
  If chkLeitor.Checked Then
    Begin
      chkInfMan.Checked := FALSE;
      lblCMC7.Caption := 'Passe o Cheque desejado';
    End;
  pSetFocus(edtCMC7);
end;

function TfrmBaixaChequesRepasse.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*******************************}
    {* ADICIONOU FILTRO DA EMPRESA *}
    {**23/02/2011-14:12**********DP*}
    If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
        edtDesEmpresa.Text := 'TODOS';

    {  pAtualizaTemporaria;
      pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
      pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);   }

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
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (StrToDateDef(mskDtaIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
        End;
    End
    Else
    If (Sender = edtCMC7) Then
    Begin
      If Not fEmptyStr(edtCMC7.Text) Then
      Begin
        Result := False;
        If ((Length(Trim(edtCMC7.Text)) <> 34) And chkLeitor.Checked) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque carregado pelo leitor, deve conter 34 caracteres.', ['&O k']);
          Exit;
        end
        else
        If ((Length(Trim(edtCMC7.Text)) <> 30) And chkInfMan.Checked And (fCfgSis('MODCHQ') = '1')) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque configurado CFG_MODCHQ como "Modelo um", deve conter 30 caracteres.', ['&O k']);
          Exit;
        end
        else
        If ((Length(Trim(edtCMC7.Text)) <> 32) And chkInfMan.Checked And (fCfgSis('MODCHQ') = '2')) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque configurado CFG_MODCHQ como "Modelo dois", deve conter 32 caracteres.', ['&O k']);
          Exit;
        end;
        If fCfgSis('MODCHQ') = '1' Then
        Begin
          pModCheque1;
        End
        Else If fCfgSis('MODCHQ') = '2' Then
        Begin
          pModCheque2;
        End;
        Result := True;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaChequesRepasse.pAtualizaTemporaria;
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
    strSQL := strSQL + '  Q.CHQ_TRFLIB, ';
    strSQL := strSQL + '  CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
    strSQL := strSQL + '  SUBSTRING(Q.CHQ_HISTOR,1,10000) AS CHQ_HISTOR, ';
    strSQL := strSQL + '  " " AS CHQ_MARDES, ';
    strSQL := strSQL + '  CONCAT("CADCHQ", Q.AUTOINCREM) AS CHQ_INCTAB, ';
    strSQL := strSQL + '  Q.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADBCO B ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
    strSQL := strSQL + '  Q.CHQ_DTAREP IS NULL AND ';
    strSQL := strSQL + '  Q.CHQ_DTADV2 IS NULL AND ';
    strSQL := strSQL + '  ((Q.CHQ_DTADEP IS NULL) OR ((Q.CHQ_DTADP2 IS NULL) AND (Q.CHQ_DTADEV IS NOT NULL))) AND ';
    strSQL := strSQL + '  Q.CHQ_DTACUS IS NULL AND ';
    strSQL := strSQL + '  ( ( Q.CHQ_INCCTR = "N" ) OR Q.CHQ_INCCTR IS NULL ) ';

    If fEmptyStr(edtCMC7.Text) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
          strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :CADINI AND :CADFIN ';

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        strSQL := strSQL + '  AND (CHQ_NAODEP = "N" OR CURRENT_DATE >= CHQ_DTAVEN ) ';

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'Q.CHQ_CODEMP', 'CODEMP');
      End
    Else
     Begin
       strSQL := strSQL + '  AND (Q.CHQ_CODBCO = :CODBCO       ';
       strSQL := strSQL + '       AND Q.CHQ_NUMAGE LIKE :NUMAGE   ';
       strSQL := strSQL + '       AND Q.CHQ_CONCOR LIKE :CONCOR   ';
       strSQL := strSQL + '       AND Q.CHQ_NUMCHQ LIKE :NUMCHQ ) ';
       strSQL := strSQL + '  AND (CHQ_NAODEP = "N" OR CURRENT_DATE >= CHQ_DTAVEN ) ';
     End;

    With qryCheque Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If fEmptyStr(edtCMC7.Text) Then
        Begin
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
          Begin
            ParamByName('CADINI').AsDateTime := StrToDateTime(mskDtaCadIni.Text);
            ParamByName('CADFIN').AsDateTime := StrToDateTime(mskDtaCadFin.Text);
          End;

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
          End;

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryCheque);
        End
      Else
        Begin
          ParamByName('CODBCO').AsString := strCodBan;
          ParamByName('NUMAGE').AsString := '%' + strNumAge;
          ParamByName('NUMCHQ').AsString := '%' + strNumChq;
          ParamByName('CONCOR').AsString := '%' + strConCor;
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
        fMensagem('', 'Não há cheques a serem repassados!', ['&O k']);
        pSetFocus(mskDtaCadIni);
        blnMudarFoco := False;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaChequesRepasse.pAtualizaTemporaria]');
    End;
  End;

  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmBaixaChequesRepasse.pCalculaTotalCheques(edtQtdChq,
  edtValTot: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldGen: TAggregateField;
    intDias : Integer;
    fltChqSel : Double;
    fltTotDia : Double;
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
        Filter := 'CHQ_MARDES = ''M''';
        Filtered := True;
      End;

      If Not cdsGen.IsEmpty Then
      Begin
        edtQtdChq.Text := IntToStr(RecordCount);
        If Not fEmptyStr(TAggregateField(FieldByName('CHQ_TOTCHQ')).Value) Then
          edtValTot.Text := FormatFloat('#,##0.00', TAggregateField(FieldByName('CHQ_TOTCHQ')).Value)
        Else
          edtValTot.Text := '0,00';

        fltTotDia := 0;
        fltChqSel := 0;

        FillChar(varRegistroChqPre, SizeOf(varRegistroChqPre), #0);
        FillChar(arrCheques, SizeOf(arrCheques), #0);

        cdsGen.First;
        While Not cdsGen.Eof Do
        Begin
          SetLength(arrCheques, Length(arrCheques) + 1);
          arrCheques[ Length(arrCheques)-1 ] := cdsGen.FieldByName('CHQ_INCTAB').AsString;

          If (cdsGen.FieldByName('CHQ_DTAVEN').AsDateTime < VS_Date) Then
            intDias := 0
          Else
            intDias := DaysBetween(VS_Date, cdsGen.FieldByName('CHQ_DTAVEN').AsDateTime);

          fltTotDia := fltTotDia + (intDias * cdsGen.FieldByName('CHQ_VALCHQ').AsFloat);
          fltChqSel := fltChqSel + cdsGen.FieldByName('CHQ_VALCHQ').AsFloat;

          cdsGen.Next;
        End;

        If (Length(arrCheques) > 0) Then
          varRegistroChqPre.arrCheques := arrCheques;

        If fFormataFloat(fltChqSel,2) <> 0 Then
          edtChqPrzMedVen.Text := FormatFloat('#,##0.00', fFormataFloat(fltTotDia / fltChqSel, 2))
        Else
          edtChqPrzMedVen.Text := '0,00';
      End
      Else
      Begin
        edtQtdChq.Text := '0';
        edtValTot.Text := '0,00';
        edtChqPrzMedVen.Text := '0,00';
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaChequesRepasse.pCalculaTotalCheques]');
    End;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaChequesRepasse.pDestravaCheques;
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

procedure TfrmBaixaChequesRepasse.pAtualizaDados(DataSet: TDataSet);
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

procedure TfrmBaixaChequesRepasse.FormActivate(Sender: TObject);
begin
  inherited;

  If blnBaiCtp Then
  Begin
    lblTotRep.Visible := True;
    edtTotRep.Visible := True;
    edtTotRep.Text    := FormatFloat('#,##0.00', fltTotRep);
  End;

  pSetFocus(mskDtaCadIni);
end;

procedure TfrmBaixaChequesRepasse.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If blnBaiCtp Then
  Begin
    If Not(Assigned(dicRepChq)) Or (dicRepChq.Count = 0) Then
    Begin
      pDestravaCheques;
    End;
  End;
end;

procedure TfrmBaixaChequesRepasse.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Not blnBaiCtp Then
    pLimpaDados;
end;

procedure TfrmBaixaChequesRepasse.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCHQ';

  bnExiRel := False;

  strForRep := '';
  dtaDtaRep := 0.0;
  strObsRep := '';
  strCtaDep := '';
  dtaDtaDep := 0.0;

  cdsCheque := TUniClientDataSet.Create(Self);
  cdsCheque.OnFilterRecord := pFilterRecord;
  cdsCheque.AfterScroll    := pAtualizaDados;

  dtsCheque := fCriaDataSource(cdsCheque);
  //dbgCheques.DataSource := dtsCheque;
  dbgChequesDados.DataController.DataSource := dtsCheque;

  strRcxTcc        := fCfgSis('RCXTCC');

  Label8.Visible   := (strRcxTcc = '2');
  Shape3.Visible   := (strRcxTcc = '2');
  Label4.Visible   := (strRcxTcc = '2');
  Label26.Visible  := (strRcxTcc = '2');
  Shape2.Visible   := (strRcxTcc = '2');
  Label24.Visible  := (strRcxTcc = '2');
  gpbLegenda.Height:= IIF(strRcxTcc = '2', 67, 34);

  FLiberacaoTransferencia := fCfgSis('USAAUT', varBoolean);
end;

procedure TfrmBaixaChequesRepasse.pMarcaCheque(blnMarcar: Boolean; dtaDtaDep: TDateTime; strCtaDep: String;
                                               blnMarcarTodos: Boolean = False);
begin
  With cdsCheque Do
  Begin
    Edit;
    If blnMarcar Then
    Begin
      If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        Cancel;
        If Not blnMarcarTodos Then
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;

      FieldByName('CHQ_MARDES').AsString := 'M';
      FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;
      FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
    End
    Else
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
        FieldByName('CHQ_MARDES').AsString := 'D';
        FieldByName('CHQ_DTADEP').Value := Null;
        FieldByName('CHQ_CTADEP').Value := Null;
      End;
    End;
    Post;
  End;

end;


procedure TfrmBaixaChequesRepasse.pSelecionaCheque();
  Var
    blnConfirma : Boolean;
    frmBaixaDigCheque : TfrmBaixaDigCheque;
begin
  If cdsCheque.IsEmpty Then
    Exit;

  If (cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M') Then
  Begin
    If fBaixaSomenteResumoCaixa Then
    Begin
      If FLiberacaoTransferencia Then
        pMensagemOk('Esse cheque foi recebido pelo Caixa e ainda não foi transferido ou a transferência não foi liberada!')
      Else
        pMensagemOk('Esse cheque foi recebido pelo Caixa e ainda não foi transferido!');
      Exit;
    End;

    If blnBaiCtp Then
    Begin
      If (StrToDate(strDtaLan) < cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime)  Then
      Begin
        pMensagemOk('A Data do Cheque Repassado deve ser menor ou igual a data do pagamento: '+strDtaLan+'!');
        Exit;
      End;
    End;

    If Not blnBaiCtp Then
    Begin

      Try
        pCriarFormularios(TfrmBaixaDigCheque, frmBaixaDigCheque);

        frmBaixaDigCheque.blnRepasse     := True;
        frmBaixaDigCheque.strCtaDep      :=  'REPASSE';
        frmBaixaDigCheque.edtCtaDep.Text :=  'REPASSE';
        frmBaixaDigCheque.edtCtaDep.Enabled := False;
        If dtaDtaDep > 0 Then
          frmBaixaDigCheque.mskDtaDep.Text := DateToStr(dtaDtaDep);

        if (cdsCheque.FieldByName('CHQ_DTADEV').AsDateTime > 0 ) then
          frmBaixaDigCheque.dtaDtaDev := cdsCheque.FieldByName('CHQ_DTADEV').AsDateTime;

        if ( cdsCheque.FieldByName('CHQ_DTADV2').AsDateTime > cdsCheque.FieldByName('CHQ_DTADEV').AsDateTime ) then
          frmBaixaDigCheque.dtaDtaDev := cdsCheque.FieldByName('CHQ_DTADV2').AsDateTime;

        frmBaixaDigCheque.dtaDtaCad := cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime;
        frmBaixaDigCheque.ShowModal;

        blnConfirma := frmBaixaDigCheque.blnConfirma;
        strCtaDep   := frmBaixaDigCheque.strCtaDep;
        dtaDtaDep   := frmBaixaDigCheque.dtaDtaDep;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmBaixaChequesRepasse.pSelecionaCheque]');
        End;
      End;

      pFreeAndNil(frmBaixaDigCheque);

    End
    Else
    Begin
      blnConfirma := True;
      strCtaDep   := 'REPASSE';
      dtaDtaDep   := VS_Date;
    End;

    If blnConfirma Then
      pMarcaCheque(True, dtaDtaDep, strCtaDep);
  End
  Else
   pMarcaCheque(False, 0, '');

  pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
end;

procedure TfrmBaixaChequesRepasse.pSetaCalculoTitulos;
  Var
    fltTitSel : Double;
    fltTotDia : Double;
    intDias : Integer;
begin
  If Not pnlTitulos.Visible Then
    Exit;

  fltTitSel := 0;
  fltTotDia := 0;

  If Assigned(cdsCloneCtaPag) And (cdsCloneCtaPag.Active) Then
  Begin
    cdsCloneCtaPag.First;
    While Not cdsCloneCtaPag.Eof Do
    Begin
      If (cdsCloneCtaPag.FieldByName('CTP_DTAVEN').AsDateTime < VS_Date) Then
        intDias := 0
      Else
        intDias := DaysBetween(VS_Date, cdsCloneCtaPag.FieldByName('CTP_DTAVEN').AsDateTime);

      fltTotDia := fltTotDia + (intDias * cdsCloneCtaPag.FieldByName('CTP_VALPAG').AsFloat);
      fltTitSel := fltTitSel + cdsCloneCtaPag.FieldByName('CTP_VALPAG').AsFloat;

      cdsCloneCtaPag.Next;
    End;
  End;

  edtTitSel.Text := FormatFloat('#,##0.00', fltTitSel);

  If fFormataFloat(fltTitSel,2) <> 0 Then
    edtTitPrzMedVen.Text := FormatFloat('#,##0.00', fFormataFloat(fltTotDia / fltTitSel, 2))
  Else
    edtTitPrzMedVen.Text := '0,00';
end;

procedure TfrmBaixaChequesRepasse.pSetaVencimentosTitulos;
begin
  If Assigned(cdsCloneCtaPag) And (cdsCloneCtaPag.Active) Then
  Begin
    cdsCloneCtaPag.IndexFieldNames := 'CTP_DTAVEN';
    cdsCloneCtaPag.First;
    mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', cdsCloneCtaPag.FieldByName('CTP_DTAVEN').AsDateTime);
    cdsCloneCtaPag.Last;
    mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', cdsCloneCtaPag.FieldByName('CTP_DTAVEN').AsDateTime);
  End;
end;

procedure TfrmBaixaChequesRepasse.dbgCheques2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  {*****************************************}
  {* MARCA / DESMARCA CHEQUE               *}
  {**************************************MV*}
  If (Key = VK_Return) Then
  Begin
    pSelecionaCheque;
    pSetFocus(Self);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaCadIni);
  End;
end;


procedure TfrmBaixaChequesRepasse.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var strMarDes, strResCai, strDtaTrans : String;

    LTFLiberada: String;
begin
  inherited;
  With cdsCheque Do
  Begin
    If Not Active Then
      Exit;

    If (Not AViewInfo.Selected) Then
    begin
      strResCai := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_RESCAI.Index]);
      strDtaTrans := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_DTATRA.Index]);
      LTFLiberada := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_TRFLIB.Index]);

      If (LTFLiberada = 'N') And (strResCai = '1') And (FLiberacaoTransferencia) Then
        ACanvas.Font.Color := clGreen
      Else If (strResCai = '1') And (strRcxTcc = '2') Then
      begin
        If fEmptyStr(strDtaTrans) Then
          ACanvas.Font.Color := clGreen;
      end;

      strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_MARDES.Index]);

      If strMarDes = 'M' Then
        ACanvas.Font.Color := clBlue;
    end;
  End;
end;

procedure TfrmBaixaChequesRepasse.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And Not (cdsCheque.IsEmpty)Then
  Begin
    {**************************************}
    {* VERIFICA SE É BAIXA ANALÍTICA E SE *}
    {* A BAIXA NÃO ESTÁ SENDO REALIZADA   *}
    {* PELA BAIXA DE CONTAS A PAGAR       *}
    {***********************************AJ*}
    If (Not blnBaiCtp) And (fCfgSis('CTP_AS') = 'S') Then
      Exit;

    pSelecionaCheque;
    pSetFocus(dbgCheques);
    dbgChequesDados.NavigatorButtons.Next.Click;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskDtaCadIni);
  End;
end;

procedure TfrmBaixaChequesRepasse.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmBaixaChequesRepasse.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaChequesRepasse.pLimpaDados;
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

  edtTotalCheques.Clear;
  edtValorTotal.Clear;

  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;
  edtChqPrzMedVen.Clear;


  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  pDestravaCheques;

  cdsCheque.Close;
end;

procedure TfrmBaixaChequesRepasse.dbgCheques2DrawColumnCell(
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

procedure TfrmBaixaChequesRepasse.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

   If Not fValidaCampos(mskDtaCadIni, False) And
     Not fValidaCampos(mskDtaCadFin, False) Or
     Not fValidaCampos(mskDtaCadIni,False)  Or
     Not fValidaCampos(mskDtaCadFin,False)  Then
      Exit;

   If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False) Or
     Not fValidaCampos(mskDtaIni,False)  Or
     Not fValidaCampos(mskDtaFin,False)  Then
      Exit;

   If Not fValidaCampos(edtCMC7) Then
     Exit;

  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  If Not cdsCheque.IsEmpty Then
  Begin
    pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
    pSetFocus(dbgCheques);
  End
  Else
    pLimpaDados;
end;

procedure TfrmBaixaChequesRepasse.btnConfirmaClick(Sender: TObject);
Var
  strParRel : String;
  intCnt: Integer;
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

    If (blnBaiCtp) And (fStrToFloat(edtTotalSelecionado.Text) > fStrToFloat(edtTotRep.Text)) Then
    Begin
      fMensagem('', 'Total de cheques selecionados R$ ' + edtTotalSelecionado.Text + ' ultrapassa o valor máximo restante da baixa R$ ' + edtTotRep.Text + '!', ['&Ok']);
      Exit;
    End;

    If (bnExiRel) And (Length(varRegistroChqPre.arrCheques) > 0) And (fMensagem('', 'Deseja imprimir a relação de cheques repassados?', ['&Sim', '&Não']) = 1) Then
    Begin

   strParRel := '';

    For intCnt := Low(arrCheques) To High(arrCheques) Do
     Begin
     If SameText('CADCHQ', Copy(arrCheques[intCnt], 1, Length(arrCheques[intCnt])-20)) Then
     Begin
       If fEmptyStr(strParRel) Then
         strParRel :=  RightStr(arrCheques[intCnt], 20)
       Else
         strParRel := strParRel + ', ' + RightStr(arrCheques[intCnt], 20);
     End;

    end;

    If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(4, 347, [347],
                        ['CHEQUES'],
                        [strParRel],
                        Sender);
   end;

    If blnBaiCtp Then
    Begin
      If fRepassaChequesBaiCtp Then
      Begin
        Close;
        Self.ModalResult := mrOk;
      End;
    End

    Else If (fDigInfoBaixa)  And (Not blnBaiCtp) Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fRepassaCheques;
      frmGravando.lblGravando.Caption := 'Aguarde... Realizando o Repasse do(s) Cheque(s).';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
      If Not cdsCheque.IsEmpty Then
      Begin
        pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
        pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
      End
      Else
        pLimpaDados;
    End;
    pSetFocus(dbgCheques);
  End;
end;

function TfrmBaixaChequesRepasse.fRepassaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnBaiAna: Boolean;
    dtaDtaAnt: TDateTime;
    strSeqLan: String;
    fltValMovBan: Double;

    arrBaixas : Array Of TBaixaCheque;

    strSeqDep : String;
    repCheque : TCadChqRepository;
begin

  fltValMovBan := 0;
  SetLength(arrBaixas, 0);

  blnBaiAna := (fCfgSis('CHQ_AS') = 'A');

  If fMensagem('', 'Confirma repasse dos cheques selecionados?', ['&Sim', '&Não']) =  1 Then
  Begin

    fStartTransaction;

    Try

      With cdsCheque Do
      Begin
        DisableControls;
        IndexFieldNames := 'CHQ_DTADEP';

        First;

        pgbStatus.Position := 0;
        pgbStatus.Properties.Max := RecordCount;

        dtaDtaAnt := 0.0;

        While Not Eof Do
        Begin
          pStep(pgbStatus);

          If FieldByName('CHQ_MARDES').AsString = 'M' Then
          Begin

            If (dtaDtaAnt <= 0) Then
              dtaDtaAnt := FieldByName('CHQ_DTADEP').AsDateTime;

            pRepassaCheque(FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           strForRep,
                           dtaDtaRep,
                           strObsRep);

            {********************************************}
            {* BAIXA ANALITICA: 1 MOVBAN P/ CADA CHEQUE *}
            {*****************************************MV*}
            If blnBaiAna Then
              strSeqLan := fGravaMovBanAna
            Else If (dtaDtaAnt <> FieldByName('CHQ_DTADEP').AsDateTime) Then
            Begin

              {*****************************************}
              {* SINTETIZA AS ENTRADAS NO MOVBAN       *}
              {**************************************MV*}
              SetLength(arrBaixas, Length(arrBaixas)+1);
              arrBaixas[Length(arrBaixas)-1].fltValor  := fltValMovBan;
              arrBaixas[Length(arrBaixas)-1].dtaDtaDep := dtaDtaAnt;

              dtaDtaAnt := FieldByName('CHQ_DTADEP').AsDateTime;
                fltValMovBan := FieldByName('CHQ_VALCHQ').AsFloat
            End
            Else
            Begin
              fltValMovBan := fltValMovBan + FieldByName('CHQ_VALCHQ').AsFloat;
            End;

            {*******************************************}
            {* FORMATA HISTÓRICO DO CHEQUE             *}
            {****************************************AC*}
            pVerificaHistoricoCheque(FieldbyName('CHQ_HISTOR').AsString,
                                     DateToStr(FieldbyName('CHQ_DTAVEN').AsDateTime),
                                     DateToStr(dtaDtaDep),
                                     strCtaDep,
                                     strPorDeb+'-'+strNomPorBai);

            pDepositaCheque(FieldByName('CHQ_CODBCO').AsString,
                            FieldByName('CHQ_NUMAGE').AsString,
                            FieldByName('CHQ_CONCOR').AsString,
                            FieldByName('CHQ_NUMCHQ').AsString,
                            FieldByName('CHQ_CODEMP').AsString,
                            FieldByName('CHQ_CTADEP').AsString,
                            FieldByName('CHQ_DTADEP').AsDateTime,
                            strSeqLan,
                            strPorDeb,
                            strCtaDeb,
                            strHistorChq,
                            strPorDeb,
                            strCtaDeb,
                            0,
                            strSeqDep,
                            strPorCred,
                            strCtaCred);
            fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
          End;

          Next;

        End;

        If Not blnBaiAna Then
        Begin

          SetLength(arrBaixas, Length(arrBaixas)+1);
          arrBaixas[Length(arrBaixas)-1].fltValor  := fltValMovBan;
          arrBaixas[Length(arrBaixas)-1].dtaDtaDep := dtaDtaAnt;

          {*****************************************}
          {* GRAVA O MOVBAN SINTETIZADO POR DATA   *}
          {*****************************************}
          pGravaMovBanSin(arrBaixas);
        End;

      End;

      Result := True;
      fCommit;

      with cdsCheque do
      begin
        First;
        while not eof do
        begin
          If FieldByName('CHQ_MARDES').AsString = 'M' Then
          Begin
            {**************************}
            {* GRAVA LOG DO CADCHQ(X) *}
            {***********************JU*}
            repCheque := TCadChqRepository.Create;
            repCheque.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                                FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                                'BAIXA REPASSE (frmBaixaChequesRepasse.fRepassaCheques)');
            FreeAndNil(repCheque);
          end;

          Next;
        end;
      end;

      fMensagem('ATENÇÃO!', 'Sequencial de depósito: ' + strSeqDep, ['&Ok']);
    Except
      On E: Exception Do
      Begin
        Result := False;
        cdsCheque.IndexFieldNames := '';
        cdsCheque.EnableControls;
        fRollBack;
        If Pos('AUT001 - ', E.Message) = 0 Then
          pMensagensErro(E.Message, '[fRepasseCheques]')
        Else
          pMensagemOK(StringReplace(E.Message, 'AUT001 - ', EmptyStr, [rfReplaceAll]));
      End;
    End;
    cdsCheque.IndexFieldNames := '';
    cdsCheque.EnableControls;
  End
  Else
    Result := False;
end;

procedure TfrmBaixaChequesRepasse.dbgCheques2DblClick(Sender: TObject);
begin
  inherited;
  pSelecionaCheque;
  pSetFocus(Self);
end;


procedure TfrmBaixaChequesRepasse.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If cdsCheque.IsEmpty    Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;


  Try
    pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
    frmBuscaCheques.ShowModal;
    TfrmGravando.fExecutarModal(pBuscaIni,'Aguarde... Localizando Cheque.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaChequesRepasse.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaCheques);
end;

procedure TfrmBaixaChequesRepasse.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;


procedure TfrmBaixaChequesRepasse.pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
  Var
    strFormata: String;
    strValores: String;
begin

  strValores := '';
  strValores := ' ' + fPadR(strDtaVenc,18,' ');
  strValores := strValores + fPadR(strDtaDep,16,' ');
  strValores := strValores + fPadR(strContaDep,17,' ');
  strValores := strValores + fPadR(strPortador,31,' ');

  If (strHistorico = '') Then
  Begin
    strFormata := ' Data Vencimento   Data Depósito   Conta Depósito   Portador Crédito '+#13#10;
    strFormata := strFormata + ' ---------------   -------------   --------------   ---------------- '+#13#10;
    strFormata := strFormata + strValores;
  End
  Else
  Begin
    strFormata := strHistorico+#13#10;
    strFormata := strFormata + strValores;
  End;

  strHistorChq := strFormata;
  strFormata   := '';
  strValores   := '';

end;

procedure TfrmBaixaChequesRepasse.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
    If btnConfirma.Enabled Then
      btnConfirma.Click;
  End;

end;

procedure TfrmBaixaChequesRepasse.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmpresa.Text := Vs_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  pSetaVencimentosTitulos;
  pSetaCalculoTitulos;

  If Not pnlTitulos.Visible Then
    gpbLegenda.Left := gpbLegenda.Left + 30;

  {**************************************}
  {* VERIFICA SE É BAIXA ANALÍTICA E SE *}
  {* A BAIXA NÃO ESTÁ SENDO REALIZADA   *}
  {* PELA BAIXA DE CONTAS A PAGAR       *}
  {***********************************AJ*}
  If (Not blnBaiCtp) And (fCfgSis('CTP_AS') = 'S') Then
  Begin
    pMensagemOK('A Baixa de Contas a Pagar está configurada como Sintética.' + #13 + 'O repasse deverá ser feito selecionando os cheques através da rotina de "Baixa de Contas a Pagar"!');
    btnConfirma.Enabled := False;
  End Else
    btnConfirma.Enabled := True;
end;

procedure TfrmBaixaChequesRepasse.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque.','');

end;

procedure TfrmBaixaChequesRepasse.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('','É necessário ter registros para marcar!',['&O K']);
    Exit;
  End;

  If blnBaiCtp Or fDigInfCheques Then
  Begin
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fMarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques.';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  End;

end;

procedure TfrmBaixaChequesRepasse.btnDesmTodosClick(Sender: TObject);
begin
  inherited;

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

function TfrmBaixaChequesRepasse.fRepassaChequesBaiCtp(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    objRepChq: TChequeRepassado;
    frmBaixaDigRepasse : TfrmBaixaDigRepasse;
begin

  Try
    pCriarFormularios(TfrmBaixaDigRepasse, frmBaixaDigRepasse);

    frmBaixaDigRepasse.mskDtaRep.Enabled := False;

    If fEmptyStr(strDtaLan) Then
    Begin
      frmBaixaDigRepasse.mskDtaRep.Text := DateToStr(dtaDtaDep);
      dtaDtaRep := dtaDtaDep;
    End
    Else
    Begin
      frmBaixaDigRepasse.mskDtaRep.Text := strDtaLan;
      dtaDtaRep := StrToDate(strDtaLan);
    End;

    If Not Self.strForRep.IsEmpty Then
    Begin
      frmBaixaDigRepasse.edtCodFor.Text := Self.strForRep;
      frmBaixaDigRepasse.edtNomFor.Text := fRetNomFornecedor(Self.strForRep);
    End;

    frmBaixaDigRepasse.ShowModal;

    Result    := frmBaixaDigRepasse.blnConfirma;
    strForRep := frmBaixaDigRepasse.strForRep;
    dtaDtaRep := frmBaixaDigRepasse.dtaDtaRep;
    strObsRep := frmBaixaDigRepasse.strObsRep;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRepassaChequesBaiCtp_1]');
      pFreeAndNil(frmBaixaDigRepasse);
      Exit;
    End;
  End;

  pFreeAndNil(frmBaixaDigRepasse);

  Try

    With cdsCheque Do
    Begin
      DisableControls;
      IndexFieldNames := 'CHQ_DTADEP';

      First;

      While Not Eof Do
      Begin

        If FieldByName('CHQ_MARDES').AsString = 'M' Then
        Begin

          pVerificaHistoricoCheque(FieldbyName('CHQ_HISTOR').AsString,
                                   DateToStr(FieldbyName('CHQ_DTAVEN').AsDateTime),
                                   DateToStr(dtaDtaDep),
                                   strCtaDep,
                                   '');

          objRepChq.strCodBco := FieldByName('CHQ_CODBCO').AsString;
          objRepChq.strCodCli := FieldByName('CHQ_CODCLI').AsString;
          objRepChq.strNumAge := FieldByName('CHQ_NUMAGE').AsString;
          objRepChq.strConCor := FieldByName('CHQ_CONCOR').AsString;
          objRepChq.strNumChq := FieldByName('CHQ_NUMCHQ').AsString;
          objRepChq.strDtaEmi := FormatDateTime('dd/mm/yyyy', FieldByName('CHQ_DTACAD').AsDateTime);
          objRepChq.strDtaBom := FormatDateTime('dd/mm/yyyy', dtaDtaDep);
          objRepChq.strEmpChq := FieldByName('CHQ_CODEMP').AsString;
          objRepChq.strCtaDep := 'REPASSE';
          objRepChq.strCodCta := FieldByName('CHQ_CODCTA').AsString;
          objRepChq.strHistor := FieldByName('CHQ_HISTOR').AsString;
          objRepChq.dtaDtaDep := VS_Date;
          objRepChq.fltValChq := FieldByName('CHQ_VALCHQ').AsFloat;
          objRepChq.strAutInc := FieldByName('AUTOINCREM').AsString;

          dicRepChq.AddOrSetValue(FieldByName('CHQ_CODBCO').AsString+FieldByName('CHQ_NUMAGE').AsString+
                                  FieldByName('CHQ_CONCOR').AsString+FieldByName('CHQ_NUMCHQ').AsString,
                                  objRepChq);

        End;

        Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRepassaChequesBaiCtp_2]');
    End;
  End;
  cdsCheque.IndexFieldNames := '';
  cdsCheque.EnableControls;

end;

function TfrmBaixaChequesRepasse.fMaiorDtaCad: TDateTime;
var
  cdsGen: TUniClientDataSet;
  fldGen: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldGen := TAggregateField.Create(Self);
  try
    With fldGen Do
    Begin
      Name          := 'cdsGenCHQ_MAXDTA';
      FieldName     := 'CHQ_MAXDTA';
      DataSet       := cdsGen;
      Expression    := 'MAX(CHQ_DTACAD)';
      Active        := True;
    End;
    cdsGen.AggregatesActive := True;
    cdsGen.Data := cdsCheque.Data;

    Result := cdsGen.FieldByName('CHQ_MAXDTA').Value;
  finally
    FreeAndNil(fldGen);
    FreeAndNil(cdsGen);
  end;
end;

function TfrmBaixaChequesRepasse.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnNaoMar: Boolean;
Begin

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Result := False;
    Exit;
  End;

  blnNaoMar := False;
  With cdsCheque Do
  Begin
    DisableControls;
    First;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;
    pSetFocus(dbgCheques);
    While Not Eof Do
    Begin

      If Not fBaixaSomenteResumoCaixa Then
      Begin
        pMarcaCheque(True, dtaDtaDep, strCtaDep, True);
        pStep(pgbStatus);
      End;

      If FieldByName('CHQ_MARDES').AsString <> 'M' Then
        blnNaoMar := True;

      Next;
    End;
    First;
  End;
  pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  cdsCheque.EnableControls;

  If blnNaoMar Then
    pMensagemOK('Alguns cheques não foram marcados por algum dos motivos: ' + #13 + '*Estar sendo utilizados por outra estação;' + #13 + '*Recebidos pelo caixa e ainda não foram transferidos.');

  Result := True;

End;


function TfrmBaixaChequesRepasse.fBaixaSomenteResumoCaixa: Boolean;
begin
  Result := (fCfgSis('RCXTCC') = '2') And
            cdsCheque.FieldByName('CHQ_DTATRA').IsNull And
            (cdsCheque.FieldByName('CHQ_RESCAI').AsInteger = 1);

  If Not Result Then
    Result := Not untCadChq.TransferenciaLiberada(FLiberacaoTransferencia,
                                                  cdsCheque.FieldByName('CHQ_RESCAI').AsInteger = 1,
                                                  cdsCheque.FieldByName('CHQ_TRFLIB').AsString);
end;

function TfrmBaixaChequesRepasse.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque  Do
  Begin
    DisableControls;
    First;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;
    While Not Eof Do
    Begin
      If cdsCheque.FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        pMarcaCheque(False, 0, '');
        pStep(pgbStatus);
      End;
      Next;
    End;

    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);

    EnableControls;
    First;

  End;
  Result := False;
End;

procedure TfrmBaixaChequesRepasse.pStep(pgbStatus: TcxProgressBar);
Begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

End;

function TfrmBaixaChequesRepasse.fDigInfCheques : Boolean;
  Var
    frmBaixaDigCheque : TfrmBaixaDigCheque;
Begin
  Try
    pCriarFormularios(TfrmBaixaDigCheque, frmBaixaDigCheque);
    frmBaixaDigCheque.blnRepasse := True;
    frmBaixaDigCheque.strCtaDep      :=  'REPASSE';
    frmBaixaDigCheque.edtCtaDep.Text :=  'REPASSE';
    frmBaixaDigCheque.edtCtaDep.Enabled := False;
    frmBaixaDigCheque.dtaDtaCad := fMaiorDtaCad();

    If dtaDtaDep > 0 Then
      frmBaixaDigCheque.mskDtaDep.Text := DateToStr(dtaDtaDep);

    frmBaixaDigCheque.ShowModal;

    Result    := frmBaixaDigCheque.blnConfirma;
    strCtaDep   := frmBaixaDigCheque.strCtaDep;
    dtaDtaDep   := frmBaixaDigCheque.dtaDtaDep;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmBaixaChequesRepasse.pSelecionaCheque]');
    End;
  End;
  pFreeAndNil(frmBaixaDigCheque);
End;


procedure TfrmBaixaChequesRepasse.pBuscaIni;
Begin
  Application.ProcessMessages;
  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;
    If Not cdsCheque.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques para repassados!', ['&O k']);
    End;

  End;

End;

procedure TfrmBaixaChequesRepasse.pBuscaProx;
Begin
  Application.ProcessMessages;
  If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsCheque.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há cheques para repassados!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

End;


function TfrmBaixaChequesRepasse.fDigInfoBaixa : Boolean;
  Var
    blnConfirma: Boolean;
    frmBaixaDigRepasse : TfrmBaixaDigRepasse;
    frmBaixaAnaliticaCheqRepasse : TfrmBaixaAnaliticaCheqRepasse;
Begin

  strCtaDeb := 'REPASSE';
  Try
    pCriarFormularios(TfrmBaixaDigRepasse, frmBaixaDigRepasse);
    If Not fEmptyStr(strForRep) Then
    Begin
      frmBaixaDigRepasse.edtCodFor.Text := strForRep;
      frmBaixaDigRepasse.mskDtaRep.Text := DateToStr(dtaDtaRep);
      frmBaixaDigRepasse.edtObsRep.Text := strObsRep;
    End;
    frmBaixaDigRepasse.ShowModal;

    blnConfirma := frmBaixaDigRepasse.blnConfirma;
    strForRep := frmBaixaDigRepasse.strForRep;
    dtaDtaRep := frmBaixaDigRepasse.dtaDtaRep;
    strObsRep := frmBaixaDigRepasse.strObsRep;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmBaixaChequesRepasse.fRepassaCheques]');
    End;
  End;

  pFreeAndNil(frmBaixaDigRepasse);

  If (Not blnConfirma) Then
  Begin
    Result := False;
    Exit;
  End;

  {*****************************************}
  {* PEDE PORTADOR E CENTRO DE CUSTO PARA  *}
  {* BAIXA                                 *}
  {**************************************MV*}
  Try
    pCriarFormularios(TfrmBaixaAnaliticaCheqRepasse, frmBaixaAnaliticaCheqRepasse);

    frmBaixaAnaliticaCheqRepasse.edtPorDeb.Text := fRetCodPorChq(cdsCheque.FieldByName('AUTOINCREM').AsString);

    frmBaixaAnaliticaCheqRepasse.ShowModal;

    strCtaDeb     := frmBaixaAnaliticaCheqRepasse.strCtaDeb;
    strPorDeb     := frmBaixaAnaliticaCheqRepasse.strPorDeb;
    strNomPorBai  := frmBaixaAnaliticaCheqRepasse.strNomPor;
    strCtaCred    := frmBaixaAnaliticaCheqRepasse.strCtaCred;
    strPorCred    := frmBaixaAnaliticaCheqRepasse.strPorCred;
    strNomPorCred := frmBaixaAnaliticaCheqRepasse.strNomPorCred;

    blnConfirma := frmBaixaAnaliticaCheqRepasse.blnConfirma;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmBaixaChequesRepasse.fRepassaCheques_1]');
    End;
  End;

  pFreeAndNil(frmBaixaAnaliticaCheqRepasse);
  Result := blnConfirma;
End;

function TfrmBaixaChequesRepasse.fGravaMovBanAna: String;
Var
  strHisBai,
  strSeqLan : String;
  lstChqCre,
  lstChqDeb : TBanChqRepository;
begin
  strSeqLan := '';

  Try
   With cdsCheque Do
    Begin
      strHisBai := 'REPASSE CHEQUE No. ' + FieldByName('CHQ_NUMCHQ').AsString;

      //Criando objetos para gravação. Foram criados dois objetos um para crédito e um para débito
      //pois o mesmo estava perdendo a refêrencia de memória e gerando access violation.
      lstChqCre := TBanChqRepository.Create;
      lstChqDeb := TBanChqRepository.Create;

      lstChqCre.pClear;
      lstChqCre.fAdd(FieldByName('CHQ_CODBCO').AsString,
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

      lstChqDeb.pClear;
      lstChqDeb.fAdd(FieldByName('CHQ_CODBCO').AsString,
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

      //Débito
      strSeqLan := fGravaMovBan(strCtaDeb,                            // Centro de Custo
                                strPorDeb,                            // Portador do débito
                                strLoginUsuarioLogado,                // Operador da Baixa
                                FieldByName('CHQ_DTADEP').AsDateTime, // Data do Lançamento
                                fTime(),                              // Hora do Lançamento
                                FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                                'D',                                  // Credito / Debito
                                VS_strCodEmp,                         // Empresa da Baixa
                                FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                                strHisBai,                            // Histórico 1
                                '',                                   // Histórico 2
                                '',                                   // Cliente da Duplicata
                                '',                                   // Fornecedor da Duplicata
                                FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                                0,                                    // Sequencial de Baixa
                                '',                                   // Parcela da Duplicata
                                '',                                   // Empresa da Duplicata
                                '',                                   // Série
                                '',                                   // Código do Evento
                                '',                                   // Documento Baixado
                                lstChqDeb.fGetList                    // Log Bancário
                                );
      fGravaMovBan(strCtaCred,                           // Centro de Custo
                   strPorCred,                           // Portador do Crédito
                   strLoginUsuarioLogado,                // Operador da Baixa
                   FieldByName('CHQ_DTADEP').AsDateTime, // Data do Lançamento
                   fTime(),                              // Hora do Lançamento
                   FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                   'C',                                  // Credito / Debito
                   VS_strCodEmp,                         // Empresa da Baixa
                   FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                   strHisBai,                            // Histórico 1
                   '',                                   // Histórico 2
                   '',                                   // Cliente da Duplicata
                   '',                                   // Fornecedor da Duplicata
                   FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                   0,                                    // Sequencial de Baixa
                   '',                                   // Parcela da Duplicata
                   '',                                   // Empresa da Duplicata
                   '',                                   // Série
                   '',                                   // Código do Evento
                   '',                                   // Documento Baixado
                   lstChqCre.fGetList                    // Log Bancário
                   );

      If Assigned(lstChqCre) Then
        FreeAndNil(lstChqCre);

      If Assigned(lstChqDeb) Then
        FreeAndNil(lstChqDeb);
    End;
  Except
    Raise
  End;
end;

procedure TfrmBaixaChequesRepasse.pGravaMovBanSin(arrBaiChq: Array Of TBaixaCheque);
Var
  lstChqCre,
  lstChqDeb : TBanChqRepository;
  intConta_ : Integer;
  cdsCopChq : TUniClientDataSet;
begin
  Try
    For intConta_ := 0 To Length(arrBaiChq) - 1 Do
    Begin
      cdsCopChq := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsCopChq, cdsCheque);
      cdsCopChq.Filter   := 'CHQ_MARDES = ' + QuotedStr('M') + ' AND CHQ_DTADEP = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', arrBaiChq[intConta_].dtaDtaDep));
      cdsCopChq.Filtered := True;

      //Criando objetos para gravação. Foram criados dois objetos um para crédito e um para débito
      //pois o mesmo estava perdendo a refêrencia de memória e gerando access violation.
      lstChqCre := TBanChqRepository.Create;
      lstChqDeb := TBanChqRepository.Create;

      With cdsCopChq Do
      Begin
        First;
        While Not Eof Do
        Begin
          lstChqCre.fAdd(FieldByName('CHQ_CODBCO').AsString,
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

          lstChqDeb.fAdd(FieldByName('CHQ_CODBCO').AsString,
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
          Next;
        End;
      End;
      FreeAndNil(cdsCopChq);

      //debito
      fGravaMovBan(strCtaDeb,                        // Centro de Custo
                   strPorDeb,                        // Portador do Débito
                   strLoginUsuarioLogado,            // Operador da Baixa
                   arrBaiChq[intConta_].dtaDtaDep,   // Data do Lançamento
                   fTime(),                          // Hora do Lançamento
                   'CHQ.DIVER.',                     // Numero do Documento
                   'D',                              // Credito / Debito
                   VS_strCodEmp,                     // Empresa da Baixa
                   arrBaiChq[intConta_].fltValor,    // Valor Do Lançamento
                   'DEP. CHEQUES DIVERSOS',          // Histórico 1
                   '',                               // Histórico 2
                   '',                               // Cliente da Duplicata
                    '',                               // Fornecedor da Duplicata
                   '',                               // Número da Duplicata
                   0,                                // Sequencial de Baixa
                   '',                               // Parcela da Duplicata
                   '',                               // Empresa da Duplicata
                   '',                               // Série
                   '',                               // Código do Evento
                   '',                               // Documento Baixado
                   lstChqDeb.fGetList                // Log Bancário
                  );

      //credito
      fGravaMovBan(strCtaCred,                       // Centro de Custo
                   strPorCred,                       // Portador do Crédito
                   strLoginUsuarioLogado,            // Operador da Baixa
                   arrBaiChq[intConta_].dtaDtaDep,   // Data do Lançamento
                   fTime(),                          // Hora do Lançamento
                   'CHQ.DIVER.',                     // Numero do Documento
                   'C',                              // Credito / Debito
                   VS_strCodEmp,                     // Empresa da Baixa
                   arrBaiChq[intConta_].fltValor,    // Valor Do Lançamento
                   'DEP. CHEQUES DIVERSOS',          // Histórico 1
                   '',                               // Histórico 2
                   '',                               // Cliente da Duplicata
                   '',                               // Fornecedor da Duplicata
                   '',                               // Número da Duplicata
                   0,                                // Sequencial de Baixa
                   '',                               // Parcela da Duplicata
                   '',                               // Empresa da Duplicata
                   '',                               // Série
                   '',                               // Código do Evento
                   '',                               // Documento Baixado
                   lstChqCre.fGetList                // Log Bancário
                  );
      If Assigned(lstChqCre) Then
        FreeAndNil(lstChqCre);

      If Assigned(lstChqDeb) Then
        FreeAndNil(lstChqDeb);
    End;
  Except
    On E: Exception Do
       Raise E.Create('Não foi possível salvar a movimentação bancária! Ocorreu o seguinte erro: ' + e.Message);
  End;
end;

procedure TfrmBaixaChequesRepasse.pModCheque1;
var
    strCheque    : String;
begin
  strCodBan := '';
  strNumChq := '';
  strConCor := '';
  strNumAge := '';

  strCheque := Trim(edtCMC7.Text);
  //********************************************//
  // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
  // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
  // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
  //*****************************************ED*//
  If (strCheque = '!') Or
     fEmptyStr(strCheque) Then
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCMC7.SelectAll;
    pSetFocus(edtCMC7);
    Exit;
  End;

  //*************************************//
  // VERIFICA SE O PRIMEIRO CARACTER DA  //
  // STRING E IGUAL A "<" E O ÚLTIMO     //
  // CARACTER E IGUAL A "?". SE SIM      //
  // ENTAO QUER DIZER QUE A LEITURA ESTÁ //
  // CORRETA                             //
  //*************************************//
  If chkInfMan.Checked Or
     ((LeftStr(strCheque, 1) = '<') And
      (RightStr(strCheque, 1) = ':')) Then
  Begin

    If chkInfMan.Checked Then
    Begin
      strCodBan := Copy(strCheque, 01, 03);
      strNumChq := fRetiraZerosEsquerda(Copy(strCheque, 12, 06));
      strNumAge := fRetiraZerosEsquerda(Copy(strCheque, 04, 04));

      If (strCodBan = '341') Or (strCodBan = '399') Then
        strConCor := Copy(strCheque, 24, 06)
      Else If strCodBan = '104' Then
        strConCor := Copy(strCheque, 21, 09)
      else if strCodBan = '033' Then
        strConCor := Copy(strCheque, 22, 02) + '0' + Copy(strCheque, 24, 06)
      Else If strCodBan = '001' Then
        strConCor := IfThen(Copy(strCheque, 23, 01) <> '0', Copy(strCheque, 23, 07), Copy(strCheque, 24, 06))
      Else
        strConCor := Copy(strCheque, 23, 07);
      Insert('-',strConCor,Length(strConCor));
      strConCor := fRetiraZerosEsquerda(strConCor);

    End Else
    Begin
      strCodBan := Copy(strCheque, 02, 03);
      strNumChq := fRetiraZerosEsquerda(Copy(strCheque, 14, 06));
      strNumAge := fRetiraZerosEsquerda(Copy(strCheque, 05, 04));

      If (strCodBan = '341') Or (strCodBan = '399') Then
        strConCor := Copy(strCheque, 27, 06)
      Else If strCodBan = '104' Then
        strConCor := Copy(strCheque, 24, 09)
      else if strCodBan = '033' Then
        strConCor := Copy(strCheque, 25, 02) + '0' + Copy(strCheque, 27, 06)
      Else If strCodBan = '001' Then
        strConCor := IfThen(Copy(strCheque, 26, 01) <> '0', Copy(strCheque, 26, 07), Copy(strCheque, 27, 06))
      Else
        strConCor := Copy(strCheque, 26, 07);
      Insert('-',strConCor,Length(strConCor));
      strConCor := fRetiraZerosEsquerda(strConCor);
    End;
  End
  Else
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCMC7.SelectAll;
    pSetFocus(edtCMC7);
  End;
end;

procedure TfrmBaixaChequesRepasse.pModCheque2;
var
    strCheque    : String;
begin
  strCodBan := '';
  strNumChq := '';
  strConCor := '';
  strNumAge := '';
  strCheque   := Trim(edtCMC7.Text);

  //********************************************//
  // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
  // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
  // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
  //*****************************************LB*//
  If (strCheque = '!') Or
     fEmptyStr(strCheque) Then
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCMC7.SelectAll;
    pSetFocus(edtCMC7);
    Exit;
  End;

  If chkInfMan.Checked Or
    ((LeftStr(strCheque, 1) = '<') And (Length(Trim(strCheque)) = 34)) Then
  Begin

    If chkInfMan.Checked Then
    Begin
      strCodBan := Copy(strCheque, 01, 03);
      strNumChq := fRetiraZerosEsquerda(Copy(strCheque, 12, 06));
      strConCor := Copy(strCheque, 24, 08);
      Insert('-',strConCor,8);
      strConCor := fRetiraZerosEsquerda(strConCor);
      strNumAge := fRetiraZerosEsquerda(Copy(strCheque, 04, 04));
    End Else
    Begin
      strCodBan := Copy(strCheque, 02, 03);
      strNumChq := fRetiraZerosEsquerda(Copy(strCheque, 14, 06));
      strConCor := fRetiraZerosEsquerda(Copy(strCheque, 24, 09));
      strNumAge := fRetiraZerosEsquerda(Copy(strCheque, 05, 04));
    End;

  End
  Else
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCMC7.SelectAll;
    pSetFocus(edtCMC7);
  End;

end;

end.

