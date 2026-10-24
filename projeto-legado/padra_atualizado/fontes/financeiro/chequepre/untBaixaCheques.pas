{***************************}
{* qryConEmp -> CADEMP     *}
{************************JB*}
unit untBaixaCheques;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids,
  Mask, MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus,
  QColorLabel, Uni, AppEvnts, UniClientDataSet, untfuncoesSimples, BitBtnLockedIncrem,
  untTypesSistema, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxProgressBar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage,  cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, untTBanChqRepository, untTBanCtpRepository,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCadPag, Math, untBuscaCheques;

type
  TfrmBaixaCheques = class(TfrmPaiSimples)
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
    pnlTotais: TPanel;
    Label23: TLabel;
    Label9: TLabel;
    pnlBotoesBaixa: TPanel;
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
    edtTotalCheques: TEditFocus;
    edtValorTotal: TEditFocus;
    Label20: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label6: TLabel;
    edtCustodia: TEditFocus;
    lbl1: TLabel;
    lbl2: TColorLabel;
    edtTipSel: TEditFocus;
    lbl3: TColorLabel;
    shpMultSel: TShape;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape3: TShape;
    Label4: TLabel;
    Label11: TLabel;
    btnCarrCheques: TBitBtnLocked;
    dbgCheques: TcxGrid;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTADEP: TcxGridDBColumn;
    dbgChequesDadosCHQ_CTADEP: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTATRA: TcxGridDBColumn;
    dbgChequesDadosCHQ_RESCAI: TcxGridDBColumn;
    dbgChequesNivel: TcxGridLevel;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    ColorLabel1: TColorLabel;
    chkImpRedep: TCheckBox;
    chkLimpaFiltros: TCheckBox;
    FlwPnlBotoesBaixa: TFlowPanel;
    dbgChequesDadosCHQ_TRFLIB: TcxGridDBColumn;
    grbCMC7: TGroupBox;
    lblCMC7: TLabel;
    chkLeitor: TCheckBox;
    chkInfMan: TCheckBox;
    edtCMC7: TEditFocus;
    dbgChequesDadosCHQ_PORCHQ: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure chkLeitorClick(Sender: TObject);
    procedure chkInfManClick(Sender: TObject);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    cdsCheque: TUniClientDataSet;
    dtsCheque: TDataSource;

    blnInfDta: Boolean;
    strRcxTcc: String;

    qryConEmp: TUniQuery;

    strCtaBai : String;
    strPorBai : String;
    strNomPorBai : String;
    strCtaDeb : String;
    strPorDeb : String;

    strCodBan    : String;
    strNumChq    : String;
    strConCor    : String;
    strNumAge    : String;

    AValorTarifaDescAntec: Double;
    AValorTaxaDescAntec  : Double;
    APlanoContasAntecipacao: String;
    AFornecedorAntecipacao: String;

    strCtaDep: String;
    dtaDtaDep: TDateTime;

    strValorFiltro: String;
    strCampoFiltro: String;
    strHistorChq: String;

    arrEmp : TConsultasArray;
    strEmp : String;

    FLiberacaoTransferencia: Boolean;

    procedure pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    Function  fBaixaSomenteResumoCaixa: Boolean;
    function  fAggData(intCampo, intFiltro, intFuncao: Integer): TDate;
    procedure pModCheque1;
    procedure pModCheque2;
    function  fRetornaPortadorCheque(ACheque: TUniClientDataSet) : string;
  protected
    procedure pAtualizaTemporaria;
    procedure pLimpaDados;
    procedure pMarcaCheque(blnMarcar: Boolean; dtaDtaDep: TDateTime; strCtaDep: String);
    procedure pCalculaTotalCheques;
    procedure pCalculaValoresInformativos;
    function  fBaixaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDigInfCheques(dtaDtaCad, dtaDtaDev: TDate): Boolean;
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pSelecionaCheque;
    procedure pBuscaIni;
    procedure pBuscaProx;
    function  fDigInfoBaixa : Boolean;
    procedure pAdicionarChequesPorDataDeDeposito(dtaDtaDep: TDate;
      var lstBanChq: TBanChqRepository; blnFiltrarDtaDep: Boolean);

    procedure pDestravaCheques;
    function fValidaValorBaixa(const fltValor:Double): Boolean;

    procedure pAtualizaRelacaoDepositoCheques(sSeqLanMovBan, sSeqDep, sEmpr : String);
  public
    { Public declarations }
    blnResCai: Boolean;

    fltValorBaixa: Double;
    strCodPorFix: String;
    dteDtaRecFix: TDateTime;
    arrSeqLan: TStringArray;
  end;


implementation

uses SysUtils, Variants, Graphics, Forms, StrUtils, untFuncoesGenerica, UniDataSetProvider,
  untFuncoes, untBaixaDigCheque, untBaixaAnalitica, untPai, untConsultas,
  untFuncoesConsulta, untCadChq, untMovBan, untCadRcxx,
  untTCadChqRepository, untGravando;

{$R *.dfm}

const
  DATA_CADASTRO = 0;
  DATA_DEVOLUCAO = 1;
  DATA_DEPOSITO = 2;

  FILTRO_MARCAVEIS = 0;
  FILTRO_MARCADOS = 1;

  RET_MAIOR = 0;
  RET_MENOR = 1;

{ TfrmBaixaCheques }

function TfrmBaixaCheques.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intIndex : Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      pDesmarcaLista(edtCodEmp, arrEmp);    

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Clear;
      End
      Else If (Length(arrEmp) <= 1) And (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End

      Else
      If (Length(arrEmp) > 1) Then
      Begin
        For intIndex := 0 To High(arrEmp) Do
        Begin
          If (Pos(arrEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa(' + arrEmp[intIndex].strCodigo + ')!', ['&O k']);
            Result := False;
            Break;
          End;
        End;  

      End;

    End

    Else
    If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
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

    Else If (Sender = edtTipSel) Then
    Begin

      If fEmptyStr(edtTipSel.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Tipo deve ser preenchido!',['& O K']);
        Result := False;
      End
      Else If Pos(edtTipSel.Text,'1_2') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Tipo deve ser 1 ou 2 !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCustodia) Then
    Begin
      If fEmptyStr(edtCustodia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Situação deve ser preenchido!',['& O K']);
        Result := False;
      End
      Else If Pos(edtCustodia.Text, 'C_S_T') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo Situação deve ser C, S, ou T!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCMC7) Then
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


function TfrmBaixaCheques.fValidaValorBaixa(const fltValor: Double): Boolean;
var
  fltValSel: Double;
begin
  Result := True;
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    pCalculaValoresInformativos;

    fltValSel := 0;
    if edtTotalSelecionado.Text <> '' then
       fltValSel := fStrToFloat(edtTotalSelecionado.Text);

    fltValSel := fltValSel + fltValor;
    if  RoundTo(fltValSel, -2) > RoundTo(fltValorBaixa, -2) then
      Result := False;
  end;
end;

procedure TfrmBaixaCheques.pAdicionarChequesPorDataDeDeposito(dtaDtaDep: TDate;
  var lstBanChq: TBanChqRepository; blnFiltrarDtaDep: Boolean);
  Var
    cdsCloneCheque: TUniClientDataSet;
begin
  lstBanChq.pClear;
  cdsCloneCheque := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsCloneCheque, cdsCheque);

  If blnFiltrarDtaDep Then
    cdsCloneCheque.Filter := 'CHQ_MARDES = ' + QuotedStr('M') + ' AND CHQ_DTADEP = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaDtaDep))
  Else
    cdsCloneCheque.Filter := 'CHQ_MARDES = ' + QuotedStr('M');

  cdsCloneCheque.Filtered := True;

  With cdsCloneCheque Do
  Begin
    First;
    While Not Eof Do
    Begin
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
      Next;
    End;
  End;

  FreeAndNil(cdsCloneCheque);
end;

procedure TfrmBaixaCheques.pAtualizaDados(DataSet: TDataSet);
begin
  If cdsCheque.ControlsDisabled = False Then
  Begin
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
  End;
end;

procedure TfrmBaixaCheques.pAtualizaTemporaria;
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
    strSQL := strSQL + 'SELECT DISTINCT ';
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
    strSQL := strSQL + '  Q.CHQ_PORCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CDCTSV, ';
    strSQL := strSQL + '  Q.CHQ_CDPRSV, ';
    strSQL := strSQL + '  Q.CHQ_TELCHE, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  Q.CHQ_SEQDEP, ';
    strSQL := strSQL + '  Q.CHQ_CODOPE, ';
    strSQL := strSQL + '  Q.CHQ_CODCMC, ';
    strSQL := strSQL + '  Q.CHQ_DTADEP, ';
    strSQL := strSQL + '  Q.CHQ_CTADEP, ';
    strSQL := strSQL + '  Q.CHQ_TRFLIB, ';
    strSQL := strSQL + '  SUBSTRING(Q.CHQ_HISTOR,1,10000) AS CHQ_HISTOR, ';
    strSQL := strSQL + '  "D" AS CHQ_MARDES, ';
    strSQL := strSQL + '  CONCAT(PCHQ.POR_CODPOR, "-", PCHQ.POR_NOMPOR) AS PORCHQ, ';
    strSQL := strSQL + '  Q.AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q ';
    strSQL := strSQL + '  INNER JOIN  CADBCO B ON B.BCO_CODBCO = Q.CHQ_CODBCO ';
    strSQL := strSQL + '  LEFT JOIN CADPOR PCHQ ON Q.CHQ_PORCHQ = PCHQ.POR_CODPOR  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ((Q.CHQ_DTADEP IS NULL) OR ((Q.CHQ_DTADEP IS NOT NULL) AND (Q.CHQ_DTADEV IS NOT NULL) AND (Q.CHQ_DTADP2 IS NULL) AND (Q.CHQ_DTADV2 IS NULL))) AND ';
    strSQL := strSQL + '  (Q.CHQ_INCCTR = "N" OR Q.CHQ_INCCTR IS NULL)';

    strSQL := strSQL + fStrLocateEmpresa(edtCodEmp, arrEmp, 'Q.CHQ_CODEMP', 'CODEMP');

    If fEmptyStr(edtCMC7.Text) Then
      begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

        strSQL := strSQL + '  AND (CHQ_NAODEP = "N" OR CURRENT_DATE >= CHQ_DTAVEN ) ';

        If edtCustodia.Text = 'C' Then
          strSQL := strSQL + '  AND Q.CHQ_DTACUS IS NOT NULL '
        Else If edtCustodia.Text = 'S' Then
          strSQL := strSQL + '  AND Q.CHQ_DTACUS IS NULL ';

        If blnResCai Then
          strSQL := strSQL + '  AND Q.CHQ_RESCAI = 1 ';

        If chkImpRedep.Checked Then
          strSQL := strSQL + '  AND (CHQ_DTADEV IS NOT NULL AND CHQ_DTADP2 IS NULL AND COALESCE(CHQ_DEVDEF, 0) = 0 ) ';
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

      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCheque);

      If fEmptyStr(edtCMC7.Text) Then
        Begin
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
            ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
          End;
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
        (cdsCheque.FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := ',0.00';
      End
      Else
      Begin
        fMensagem('', 'Não há cheques a serem depositados!', ['&O k']);
        If cdsCheque.IsEmpty Then
          pSetFocus(edtCodEmp);
        blnMudarFoco := False;
        Exit;
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaCheques.pAtualizaTemporaria]');
    End;
  End;

  cdsCheque.First;
  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmBaixaCheques.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmBaixaCheques.FormCreate(Sender: TObject);
begin
  inherited;
  chkLimpaFiltros.checked := true;
  strNomeTabela     := 'CADCHQ';
  blnResCai := False;

  strCtaDep := '';
  dtaDtaDep := 0.0;

  fltValorBaixa :=  0;
  strCodPorFix  := '';
  SetLength(arrSeqLan, 0);

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

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

  // VERIFICA SE PODE EFETUAR "TRANSFERENCIA DE CHEQUES"
  strRcxTcc       := fCfgSis('RCXTCC');

  Label11.Visible := (strRcxTcc = '2');
  Shape3.Visible  := (strRcxTcc = '2');
  Label4.Visible  := (strRcxTcc = '2');
  Label26.Visible := (strRcxTcc = '2');
  Shape2.Visible  := (strRcxTcc = '2');
  Label24.Visible := (strRcxTcc = '2');
  GroupBox1.Height:= IIF(strRcxTcc = '2', 67, 34);

  FLiberacaoTransferencia := fCfgSis('USAAUT', varBoolean);
end;

{*****************************************}
{* LIMPA DADOS INFORMATIVOS DOS CHEQUES  *}
{**************************************MV*}
procedure TfrmBaixaCheques.pLimpaDados;
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

  edtCodEmp.Clear;
  edtNomEmp.Clear;

  mskDtaIni.Clear;
  mskDtaFin.Clear;

  pDestravaCheques;

  cdsCheque.Close;
end;

procedure TfrmBaixaCheques.pDestravaCheques;
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

{*****************************************}
{* MARCA / DESMARCA A DUPLICATA          *}
{**************************************MV*}
procedure TfrmBaixaCheques.pMarcaCheque(blnMarcar: Boolean; dtaDtaDep: TDateTime; strCtaDep: String);
  Var
    intRecNo : Integer;
begin

  intRecNo    := cdsCheque.RecNo;

  With cdsCheque Do
  Begin
    If blnMarcar Then
    Begin
      if not fValidaValorBaixa(FieldByName('CHQ_VALCHQ').Value) then
      begin
         pMensagemOk('Não é possível selecionar esta duplicata, o valor excede o permitido!' + #13 +
                     'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa)+ #13 +
                     'Valor disponível: ' + FormatFloat('###,###,##0.00', fltValorBaixa-fStrToFloat(edtTotalSelecionado.Text)));
         Exit;
      end;

      Edit;
      If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        Cancel;
        fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;

      If edtTipSel.Text = '1' Then
      Begin
        FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;
        FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
      End;

      If edtTipSel.Text = '2' Then
      Begin
        FieldByName('CHQ_DTADEP').Value    := Null;
        FieldByName('CHQ_CTADEP').Value    := Null;
      End;

      FieldByName('CHQ_MARDES').AsString := 'M';
      Post;
    End
    Else
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        Edit;
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
        FieldByName('CHQ_MARDES').AsString := 'D';
        FieldByName('CHQ_DTADEP').Value    := Null;
        FieldByName('CHQ_CTADEP').Value    := Null;
        Post;
      End;
    End;

  End;

  cdsCheque.RecNo := intRecNo;
end;

procedure TfrmBaixaCheques.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var  strMarDes, strResCai, strDtaTrans: String;

    LTFLiberada: String;
begin

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

procedure TfrmBaixaCheques.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
 If (Key = VK_Return) Then
    pSelecionaCheque
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodEmp);
  End;
end;

procedure TfrmBaixaCheques.pSelecionaCheque;
  Var
    blnConfirma: Boolean;
begin

  If cdsCheque.IsEmpty Then
    Exit;

  If fBaixaSomenteResumoCaixa Then
  Begin
    If FLiberacaoTransferencia Then
      pMensagemOk('Esse cheque foi recebido pelo Caixa e ainda não foi transferido ou a transferência não foi liberada!')
    Else
      pMensagemOk('Esse cheque foi recebido pelo Caixa e ainda não foi transferido!');

    Exit;
  End;

  If  edtTipSel.Text = '1' Then
  Begin
    blnConfirma := False;
    If cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M' Then
      blnConfirma := fDigInfCheques(cdsCheque.FieldByName('CHQ_DTACAD').AsDateTime,
                                    cdsCheque.FieldByName('CHQ_DTADEV').AsDateTime);

    If (Not fBaixaSomenteResumoCaixa) And (cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M' )
    And blnConfirma Then
      pMarcaCheque(True, dtaDtaDep, strCtaDep)
    Else
      pMarcaCheque(False, 0, '');

    pSetFocus(Self);
    dbgChequesDados.NavigatorButtons.Next.Click;
  End
  Else
  Begin
    If (Not fBaixaSomenteResumoCaixa) And (cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M' ) Then
    pMarcaCheque(True, dtaDtaDep, strCtaDep)
    Else
      pMarcaCheque(False, 0, '');

    pSetFocus(Self);
    dbgChequesDados.NavigatorButtons.Next.Click;
  End;

  pCalculaValoresInformativos;


end;

function TfrmBaixaCheques.fAggData(intCampo, intFiltro,
  intFuncao: Integer): TDate;
  Var
    cdsTmp : TUniClientDataSet;
    strCampo: String;
begin

  Case intCampo Of
    DATA_CADASTRO:  strCampo := 'CHQ_DTACAD';
    DATA_DEVOLUCAO: strCampo := 'CHQ_DTADEV';
    DATA_DEPOSITO:  strCampo := 'CHQ_DTADEP';
  End;

  cdsTmp := TUniClientDataSet.Create(Self);
  Try
    cdsTmp.Data := cdsCheque.Data;
    If intFiltro = FILTRO_MARCADOS Then
    Begin
      cdsTmp.Filter := 'CHQ_MARDES = ' + QuotedStr('M');
      cdsTmp.Filtered := True;
    End
    Else
    If (strRcxTcc = '2') And (intFiltro = FILTRO_MARCAVEIS) Then
    Begin
      cdsTmp.Filter := '(CHQ_RESCAI <> 1) OR (CHQ_DTATRA IS NOT NULL)';
      cdsTmp.Filtered := True;
    End;

    cdsTmp.First;
    Result := cdsTmp.FieldByName(strCampo).AsDateTime;

    While not cdsTmp.Eof Do
    Begin
      If ((intFuncao = RET_MAIOR) And
          (Not cdsTmp.FieldByName(strCampo).IsNull) And
          (Result < cdsTmp.FieldByName(strCampo).AsDateTime)) Or
         ((intFuncao = RET_MENOR) And
          (Not cdsTmp.FieldByName(strCampo).IsNull) And
          (Result > cdsTmp.FieldByName(strCampo).AsDateTime))Then
        Result := cdsTmp.FieldByName(strCampo).AsDateTime;

      cdsTmp.Next;
    End;
  Finally
    FreeAndNil(cdsTmp);
  End;
end;

function TfrmBaixaCheques.fBaixaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnBaiAna     : Boolean;
    fltValMovBan  : Double;
    strSeqLan     : String;
    strHisBai     : String;
    strPortador   : String;
    strPortadorDeb: String;
    intContador   : Integer;
    dtaDtaAnt     : TDateTime;
    arrBaixas     : Array Of TBaixaCheque;
    strSeqDep     : String;
    repCadChq     : TCadChqRepository;
    lstBanChq     : TBanChqRepository;
    lstBanCtp     : TBanCtpRepository;
    ASeqConP      : Integer;
    ANumDupPagar  : String;
begin
  fltValMovBan := 0.0;
  SetLength(arrBaixas, 0);

  strSeqDep := '';

  blnBaiAna := (fCfgSis('CHQ_AS') = 'A');
  Application.ProcessMessages;
  With cdsCheque Do
  Begin
    {*************************************************}
    {* ALTERANDO A ORDEM DO CLIENTDATASET PARA BAIXA *}
    {**********************************************AN*}
    IndexFieldNames := 'CHQ_MARDES;CHQ_DTADEP';

    dtaDtaAnt := FieldByName('CHQ_DTADEP').AsDateTime;
    First;
    DisableControls;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;

    fStartTransaction;

    lstBanChq := TBanChqRepository.Create;

    Try
      repCadChq := TCadChqRepository.Create;

      While Not Eof Do
      Begin
        pStep(pgbStatus);
        {*****************************************}
        {* CASO NÃO ESTEJA MARCADA, NÃO FAZ NADA *}
        {**************************************MV*}
        If (Not FieldByName('CHQ_DTADEP').IsNull) And (FieldByName('CHQ_DTADEP').AsDateTime <> 0) And
           (FieldByName('CHQ_MARDES').AsString = 'M') Then
        Begin
          If strSeqDep.IsEmpty Then
            strSeqDep := fAtualizaProCod('CADCHQ', 'CHQ_SEQDEP', '', 1, Nil,
              function (const AValue: String) : String
              begin
                Result := fStrZero(RightStr(AValue, 6), 6);
              end
            );

          dtaDtaAnt := FieldByName('CHQ_DTADEP').AsDateTime;

          {********************************************}
          {* BAIXA ANALITICA: 1 MOVBAN P/ CADA CHEQUE *}
          {*****************************************MV*}
          If blnBaiAna Then
          Begin

            strHisBai := 'DEPOSITO CHEQUE No. ' + FieldByName('CHQ_NUMCHQ').AsString;

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
                                      strPortador,                          // Portador da Baixa
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
                                      //'',                                 // Sequencial de Lançamento
                                      '',                                   // Código do Evento
                                      '',                                   // Documento da Baixa
                                      lstBanChq.fGetList,                   // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      True,
                                      Nil,
                                      '',
                                      'S',
                                      strSeqDep
                                     );

            If fEmptyStr(strSeqLan) Then
            Begin
              Break;
            End;

            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLan, Length(arrSeqLan) + 1);
              arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
            end;

            {**********************************************}
            {* CASO ESTEJA DIGITADO A OPÇÃO DE DÉBITO     *}
            {* GRAVA UM MOVBAN TIPO "D" PARA CADA CHEQUE  *}
            {*******************************************LU*}
            If (Not fEmptyStr(strPorDeb)) Then
            Begin
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
                                          strPortadorDeb,                       // Portador do débito
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
                                          //'',                                 // Sequencial de Lançamento
                                          '',                                   // Código do Evento
                                          '',                                   // Documento da Baixa
                                          lstBanChq.fGetList,                   // Log Bancário
                                          0,
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          1,
                                          True,
                                          Nil,
                                          '',
                                          'S',
                                          strSeqDep
                                         );

                If fEmptyStr(strSeqLan) Then
                Begin
                  Break;
                End;

              End;

          End
          Else If (dtaDtaAnt <> FieldByName('CHQ_DTADEP').AsDateTime) Then
          Begin
            {*****************************************}
            {* SINTETIZA AS ENTRADAS NO MOVBAN       *}
            {**************************************MV*}
            SetLength(arrBaixas, Length(arrBaixas)+1);
            arrBaixas[Length(arrBaixas)-1].fltValor  := fltValMovBan;
            arrBaixas[Length(arrBaixas)-1].dtaDtaDep := dtaDtaAnt;

            dtaDtaAnt := FieldByName('CHQ_DTADEP').AsDateTime;
            If RecNo < RecordCount Then
              fltValMovBan := FieldByName('CHQ_VALCHQ').AsFloat
            Else
              fltValMovBan := 0.0;
          End
          Else
          Begin
            If RecNo < RecordCount Then
              fltValMovBan := fltValMovBan + FieldByName('CHQ_VALCHQ').AsFloat;
          End;

          If (Not blnBaiAna) Then
          Begin
            strPortador := strPorBai;
            strPortadorDeb := strPorDeb;
          End;

          {*******************************************}
          {* FORMATA HISTÓRICO DO CHEQUE             *}
          {****************************************AC*}
          pVerificaHistoricoCheque(FieldbyName('CHQ_HISTOR').AsString,
                                   DateToStr(FieldbyName('CHQ_DTAVEN').AsDateTime),
                                   DateToStr(dtaDtaDep),
                                   strCtaDep,
                                   strPorBai+'-'+strNomPorBai);

          pDepositaCheque(FieldByName('CHQ_CODBCO').AsString,
                          FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString,
                          FieldByName('CHQ_NUMCHQ').AsString,
                          FieldByName('CHQ_CODEMP').AsString,
                          FieldByName('CHQ_CTADEP').AsString,
                          FieldByName('CHQ_DTADEP').AsDateTime,
                          strSeqLan,
                          strPorBai,
                          strCtaBai,
                          strHistorChq,
                          strPorDeb,
                          strCtaDeb,
                          IIF(blnResCai And (strRcxTcc = '2'), VS_Date, 0),
                          strSeqDep,
                          '',
                          '',
                          IIF(AValorTaxaDescAntec > 0, AValorTaxaDescAntec, 0));

          {*************************************}
          {* INSERE OS VALORES NO ARRAY DO LOG *}
          {**********************************JU*}
          repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                              FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                              'BAIXA (frmBaixaCheques.fBaixaCheques)');

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
        End;

        Next;
      End;

      FreeAndNil(repCadChq);

      If Not blnBaiAna Then
      Begin

        SetLength(arrBaixas, Length(arrBaixas)+1);
        arrBaixas[Length(arrBaixas)-1].fltValor  := fltValMovBan + FieldByName('CHQ_VALCHQ').AsFloat;
        arrBaixas[Length(arrBaixas)-1].dtaDtaDep := dtaDtaAnt;

        {*****************************************}
        {* GRAVA O MOVBAN SINTETIZADO POR DATA   *}
        {**************************************MV*}
        For intContador := 0 To Length(arrBaixas) - 1 Do
        Begin
          strPortador := strPorBai;

          pAdicionarChequesPorDataDeDeposito(arrBaixas[intContador].dtaDtaDep, lstBanChq, (Length(arrBaixas) > 1));

          strSeqLan := fGravaMovBan(strCtaBai,                        // Centro de Custo
                                    strPortador,                      // Portador da Baixa
                                    strLoginUsuarioLogado,            // Operador da Baixa
                                    arrBaixas[intContador].dtaDtaDep, // Data do Lançamento
                                    fTime(),                          // Hora do Lançamento
                                    'CHQ.DIVER.',                     // Numero do Documento
                                    'C',                              // Credito / Debito
                                    VS_strCodEmp,                     // Empresa da Baixa
                                    arrBaixas[intContador].fltValor,  // Valor Do Lançamento
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
                                    '',                               // Documento da Baixa
                                    lstBanChq.fGetList,                   // Log Bancário
                                    0,
                                    0,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    1,
                                    True,
                                    Nil,
                                    '',
                                    'S',
                                    strSeqDep
                                   );

          If Not fEmptyStr(strSeqLan) Then
          Begin
             pAtualizaRelacaoDepositoCheques(strSeqLan, strSeqDep, VS_strCodEmp);
          End;

          If fEmptyStr(strSeqLan) Then
          Begin
            Break;
          End;

          if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
          begin
            SetLength(arrSeqLan, Length(arrSeqLan) + 1);
            arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
          end;

          {**********************************************}
          {* CASO ESTEJA DIGITADO A OPÇÃO DE DÉBITO     *}
          {* GRAVA UM MOVBAN TIPO "D" PARA CADA CHEQUE  *}
          {*******************************************LU*}
          If (Not fEmptyStr(strPorDeb)) Then
          Begin
            strPortadorDeb := strPorDeb;

            pAdicionarChequesPorDataDeDeposito(arrBaixas[intContador].dtaDtaDep, lstBanChq, (Length(arrBaixas) > 1));

            strSeqLan := fGravaMovBan(strCtaDeb,                        // Centro de Custo
                                      strPortadorDeb,                   // Portador do Débito
                                      strLoginUsuarioLogado,            // Operador da Baixa
                                      arrBaixas[intContador].dtaDtaDep, // Data do Lançamento
                                      fTime(),                          // Hora do Lançamento
                                      'CHQ.DIVER.',                     // Numero do Documento
                                      'D',                              // Credito / Debito
                                      VS_strCodEmp,                     // Empresa da Baixa
                                      arrBaixas[intContador].fltValor,  // Valor Do Lançamento
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
                                      '',                               // Documento da Baixa
                                      lstBanChq.fGetList,                   // Log Bancário
                                      0,
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      1,
                                      True,
                                      Nil,
                                      '',
                                      'S',
                                      strSeqDep
                                     );

            If fEmptyStr(strSeqLan) Then
            Begin
              Break;
            End;
          End;
        End;
      End;

      //GRAVAÇÃO DA TARIFA DE DESCONTO POR ANTECIPAÇÃO
      //BANCTP / MOVBAN / CADPAG QUITADO
      If AValorTarifaDescAntec > 0 Then
      begin
        ASeqConp     := fRetCtpCon;
        ANumDupPagar := fRetSequencialCadPag;

        lstBanCtp := TBanCtpRepository.Create;
        lstBanCtp.pClear;

        lstBanCtp.fAdd(ANumDupPagar,
                       'A',
                       '',
                       VS_strCodEmp,
                       AFornecedorAntecipacao,
                       'REF. DESCONTO POR ANTECIPACAO NO DEPOSITO DE CHEQUES',
                       '',
                       APlanoContasAntecipacao,
                       VS_strCodEmp,
                       0,
                       AValorTarifaDescAntec,
                       AValorTarifaDescAntec,
                       0,
                       0,
                       0);

        strSeqLan := fGravaMovBan(APlanoContasAntecipacao,              // Centro de Custo
                                  strPorBai,                            // Portador do Débito
                                  strLoginUsuarioLogado,                // Operador da Baixa
                                  VS_Date,                              // Data do Lançamento
                                  fTime(),                              // Hora do Lançamento
                                  ANumDupPagar,                         // Numero do Documento
                                  'D',                                  // Credito / Debito
                                  VS_strCodEmp,                         // Empresa da Baixa
                                  AValorTarifaDescAntec,                // Valor Do Lançamento
                                  'REF. DESC. ANTECIPACAO NO DEP. CHQ', // Histórico 1
                                  '',                                   // Histórico 2
                                  '',                                   // Cliente da Duplicata
                                  AFornecedorAntecipacao,               // Fornecedor da Duplicata
                                  '',                                   // Número da Duplicata
                                  0,                                    // Sequencial de Baixa
                                  '',                                   // Parcela da Duplicata
                                  '',                                   // Empresa da Duplicata
                                  '',                                   // Série
                                  '',                                   // Código do Evento
                                  '',                                   // Documento da Baixa
                                  lstBanCtp.fGetList,                   // Log Bancario
                                  0,                                    // SeqTrf
                                  ASeqConp                              // SeqCon
                                  );

        fGravaCadPag('frmBaixaCheques',
                     'INCLUSAO DA TARIFA DE DESCONTO POR ANTECIPACAO',
                     AFornecedorAntecipacao,
                     ANumDupPagar,
                     'A',
                     VS_strCodEmp,
                     APlanoContasAntecipacao,
                     '',
                     0,
                     VS_Date,
                     VS_Date,
                     0,
                     AValorTarifaDescAntec,
                     'N',
                     'N',
                     'N',
                     'REF. DESCONTO POR ANTECIPACAO NO DEPOSITO DE CHEQUES',
                     '',
                     'REF. DESCONTO POR ANTECIPACAO NO DEPOSITO DE CHEQUES',
                     strPorBai,
                     APlanoContasAntecipacao,
                     strSeqLan,
                     strLoginUsuarioLogado,
                     VS_Date,
                     AValorTarifaDescAntec,
                     0,
                     0,
                     VS_strCodEmp,
                     '',
                     'N',
                     strPorBai,
                     '',
                     0,
                     0,
                     fRetCtpCon,
                     False,
                     0,
                     '',
                     0,
                     'N',
                     '',
                     '',
                     '',
                     fRetAutoIncrem('CADPAG', VS_strCodEmp),
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     AValorTarifaDescAntec);
      end;

      fCommit;
      Result := True;

      //NÃO RETIRAR
      cdsCheque.EnableControls;
      cdsCheque.EmptyDataSet;

      fMensagem('ATENÇÃO!', 'Sequencial de fechamento: ' + strSeqDep, ['&Ok']);

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        If Pos('AUT001 - ', E.Message) = 0 Then
          pMensagensErro(E.Message, '[fBaixaCheques]')
        Else
          pMensagemOK(StringReplace(E.Message, 'AUT001 - ', EmptyStr, [rfReplaceAll]));
      End;
    End;

    FreeAndNil(lstBanChq);

    IndexFieldNames := '';
  End;

  cdsCheque.EnableControls;

end;

procedure TfrmBaixaCheques.pCalculaTotalCheques;
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

procedure TfrmBaixaCheques.pCalculaValoresInformativos;
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
      Filter := 'CHQ_MARDES = ''M''';
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
      pMensagensErro(E.Message, '[TfrmBaixaCheques.pCalculaValoresInformativos]');
    End;
  End;
  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaCheques.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False)  Or
     Not fValidaCampos(mskDtaIni, False)  Or
     Not fValidaCampos(mskDtaFin, False)  Or
     Not fValidaCampos(edtTipSel, False)  Or
     Not fValidaCampos(edtCustodia, False) Then
     Exit;

  If Not fValidaCampos(edtCMC7) Then
    Exit;

  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  If Not cdsCheque.IsEmpty Then
  Begin
    pCalculaTotalCheques;
    pCalculaValoresInformativos;
    pSetFocus(dbgCheques);
  End
  Else
  begin
    if strCodPorFix = '' then
      pLimpaDados ;
  end;

end;

procedure TfrmBaixaCheques.btnConfirmaClick(Sender: TObject);
Var
  cdsAux : TUniClientDataSet;
  fltValSel: Double;
begin
  inherited;

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If edtTipSel.Text = '2' Then
  Begin
    If Not fDigInfCheques(fAggData(DATA_CADASTRO, FILTRO_MARCADOS, RET_MAIOR),
                          fAggData(DATA_DEVOLUCAO, FILTRO_MARCADOS, RET_MAIOR)) Then
      Exit;
  End;

  //Limite de valor de lançamentos se a tela for chamada pela nova
  //tela de conciliação bancária
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotalSelecionado.Text <> '' then
       fltValSel := fStrToFloat(edtTotalSelecionado.Text);

    if  RoundTo(fltValSel, -2) < RoundTo(fltValorBaixa, -2) then
    begin
      pMensagemOk('Não é possível efetuar a baixa, o valor é menor que o valor para baixa!' + #13 + #13 +
                  'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa));
      Exit;
    end;
  end;

  cdsAux := TUniClientDataSet.Create(Nil);
  cdsAux.Data := cdsCheque.Data;

  {************************************************}
  {* VALIDAÇÃO CASO ESTEJA ALGUM REGISTRO MARCADO *}
  {*          E COM CONTA DEPOSITO VAZIA          *}
  {*********************************************LE*}
  cdsAux.Filter := 'CHQ_MARDES = ' + QuotedStr('M');
  cdsAux.Filtered := True;
  cdsAux.First;
  While Not cdsAux.Eof Do
  Begin
    If (cdsAux.FieldByName('CHQ_MARDES').AsString = 'M') And
     (cdsAux.FieldByName('CHQ_DTADEP').Value = Null )Then
     Begin
       fMensagem('', 'É necessário preencher a data de deposito!', ['&Ok']);
       edtTipSel.Text := '2';
       If Not fDigInfCheques(cdsAux.FieldByName('CHQ_DTACAD').AsDateTime,
                             cdsAux.FieldByName('CHQ_DTADEV').AsDateTime) Then
         Exit
       Else
         Break;
     End;
     cdsAux.Next;
  End;
  FreeAndNil(cdsAux);

  If (Not fEmptyStr(edtTotalSelecionado.Text))  And
     (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
  Begin
    If fDigInfoBaixa Then
    Begin
      If  fMensagem('', 'Confirma depósito?', ['&Sim', '&Não']) = 1  Then
       Begin
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.fExecutarAcao := fBaixaCheques;
        frmGravando.lblGravando.Caption := 'Aguarde... Realizando o Depósito do(s) Cheque(s).';
        frmGravando.ShowModal;
        pFreeAndNil(frmGravando);
        TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
        If Not cdsCheque.IsEmpty Then
        Begin
          pCalculaValoresInformativos;
          pCalculaTotalCheques;
        End;

        if (fltValorBaixa > 0) and (strCodPorFix <> '') then
        begin
          btnSairBaixa.Click;
          Exit;
        end;

        if chklimpaFiltros.checked then
        begin
          pLimpaDados;
          pSetfocus(edtCodEmp);
          exit;
        end;
      End;
      pSetFocus(Self);
    End;
  End;

end;

procedure TfrmBaixaCheques.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  Close;
end;

procedure TfrmBaixaCheques.chkInfManClick(Sender: TObject);
begin
  inherited;
  If chkInfMan.Checked Then
    Begin
      chkLeitor.Checked := FALSE;
      lblCMC7.Caption := 'Digite o código CMC7';
    End;
  pSetFocus(edtCMC7);
end;

procedure TfrmBaixaCheques.chkLeitorClick(Sender: TObject);
begin
  inherited;
  If chkLeitor.Checked Then
    Begin
      chkInfMan.Checked := FALSE;
      lblCMC7.Caption := 'Passe o cheque desejado';
    End;
  pSetFocus(edtCMC7);
end;

Function TfrmBaixaCheques.fBaixaSomenteResumoCaixa: Boolean;
Begin
  Result := (strRcxTcc = '2') And
            cdsCheque.FieldByName('CHQ_DTATRA').IsNull And
            (cdsCheque.FieldByName('CHQ_RESCAI').AsInteger = 1);

  If Not Result Then
    Result := Not untCadChq.TransferenciaLiberada(FLiberacaoTransferencia,
                                                  cdsCheque.FieldByName('CHQ_RESCAI').AsInteger = 1,
                                                  cdsCheque.FieldByName('CHQ_TRFLIB').AsString);
End;

procedure TfrmBaixaCheques.btnMarcarTodosClick(Sender: TObject);
Var
    blnConfirma: Boolean;
begin

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('','É necessário ter registros para marcar!',['&O K']);
    Exit;
  End;

  If ( edtTipSel.Text = '1') Then
    blnConfirma := fDigInfCheques(fAggData(DATA_CADASTRO, FILTRO_MARCAVEIS, RET_MAIOR),
                                  fAggData(DATA_DEVOLUCAO, FILTRO_MARCAVEIS, RET_MAIOR))
  Else If edtTipSel.Text = '2' Then
    blnConfirma := True
  Else
    blnConfirma := False;

  If blnConfirma Then
  Begin
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fMarcarTodas;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques.';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  End;

  If fBaixaSomenteResumoCaixa Then
  Begin
    If FLiberacaoTransferencia Then
      pMensagemOk('Cheques recebidos pelo Caixa que ainda não foram transferidos ou as transferências não foram liberadas, não podem ser depositados!')
    Else
      pMensagemOk('Cheques recebidos pelo Caixa que ainda não foram transferidos não podem ser depositados!');
  End;
end;

procedure TfrmBaixaCheques.btnDesmTodosClick(Sender: TObject);
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

procedure TfrmBaixaCheques.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmBaixaCheques.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCheques.FormKeyDown(Sender: TObject; var Key: Word;
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

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    btnDesmTodos.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmBaixaCheques.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheques.','');

end;

procedure TfrmBaixaCheques.btnIniBusClick(Sender: TObject);
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
    TfrmGravando.fExecutarModal(pBuscaIni,'Aguarde... Localizando Cheque.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCheques.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaCheques);

end;

procedure TfrmBaixaCheques.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  Begin
    If Pos('_VALCHQ', strCampoFiltro) > 0 Then
      Accept := FloatToStrF(fStrToFloat(strValorFiltro),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat,ffFixed,15,2)
    Else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  End;
end;

procedure TfrmBaixaCheques.pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
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

function TfrmBaixaCheques.fDigInfCheques(dtaDtaCad, dtaDtaDev: TDate): Boolean;
  Var
    intRecNo: Integer;
     frmBaixaDigCheque : TfrmBaixaDigCheque;
  procedure pSetaDataContaDeposito;
    Var
      cdsAux : TUniClientDataSet;
  Begin
    cdsAux := TUniClientDataSet.Create(Self);

    cdsAux.Data := cdsCheque.Data;

    With cdsAux Do
    Begin
      First;

      While Not Eof Do
      Begin
        If FieldByName('CHQ_MARDES').AsString = 'M' Then
        Begin
          Edit;
          FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;
          FieldByName('CHQ_CTADEP').AsString   := strCtaDep;
          Post;
        End;

        Next;
      End;
    End;

    cdsCheque.Data := cdsAux.Data;
    FreeAndNil(cdsAux);
  End;
begin
  Try
    pCriarFormularios(TfrmBaixaDigCheque, frmBaixaDigCheque);
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro na criação do formulário, tente novamente: ' + E.Message,
        '[TfrmBaixaCheques.fSelecionaCheque]');
      Result := False;
      Exit;
    End;
  End;

  Try
    frmBaixaDigCheque.blnRepasse := False;
    frmBaixaDigCheque.edtCtaDep.Text := strCtaDep;
    frmBaixaDigCheque.dtaDtaDev      := dtaDtaDev;
    frmBaixaDigCheque.dtaDtaCad      := dtaDtaCad;

    If dtaDtaDep > 0 Then
      frmBaixaDigCheque.mskDtaDep.Text := DateToStr(dtaDtaDep);

    if (strCodPorFix <> '') and (dteDtaRecFix > 0) then
    begin
      frmBaixaDigCheque.mskDtaDep.Date    := dteDtaRecFix;
      frmBaixaDigCheque.mskDtaDep.Enabled := False;
    end;

    frmBaixaDigCheque.ShowModal;
    Result    := frmBaixaDigCheque.blnConfirma;
    strCtaDep := frmBaixaDigCheque.strCtaDep;
    dtaDtaDep := frmBaixaDigCheque.dtaDtaDep;

    blnInfDta := True;
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmBaixaDigCheque);
      pMensagensErro(E.Message, '[TfrmBaixaCheques.fSelecionaCheque]');
      Result := False;
      Exit;
    End;
  End;
  pFreeAndNil(frmBaixaDigCheque);

  If Result And (edtTipSel.Text = '2') Then
  Begin
    With cdsCheque Do
    Begin
      DisableControls;
      intRecNo := RecNo;
      pSetaDataContaDeposito;
      strCtaDep := '';
      RecNo := intRecNo;
      EnableControls;
    End;
  End;
end;


function TfrmBaixaCheques.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnNaoMar: Boolean;

  procedure pSetaDataContaDeposito;
  Begin
    With cdsCheque Do
    Begin
      First;

      While Not Eof Do
      Begin
        pStep(pgbStatus);

        // AOS CHEQUES JÁ MARCADOS APENAS ATUALIZA A DATA E CONTA DO DEPÓSITO
        If FieldByName('CHQ_MARDES').AsString = 'M' Then
        Begin
          Edit;

          If dtaDtaDep <> 0 Then
            FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;

          If Not fEmptyStr(strCtaDep) Then
            FieldByName('CHQ_CTADEP').AsString   := strCtaDep;

          Post;
        End
        Else
        If (Not fBaixaSomenteResumoCaixa) And (fEmptyStr(fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString))) Then
        Begin
          if not fValidaValorBaixa(FieldByName('CHQ_VALCHQ').Value) then
          begin
            Next;
            Continue;
          end;

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False);

          Edit;
          FieldByName('CHQ_MARDES').AsString   := 'M' ;

          If dtaDtaDep <> 0 Then
            FieldByName('CHQ_DTADEP').AsDateTime := dtaDtaDep;

          If Not fEmptyStr(strCtaDep) Then
            FieldByName('CHQ_CTADEP').AsString   := strCtaDep;

          Post;
        End
        Else
        Begin
          blnNaoMar := True;
        End;

        Next;

      End;
    End;
  End;
Begin
  cdsCheque.AfterScroll    := nil;
  cdsCheque.DisableControls;

  With cdsCheque Do
  Begin
    If IsEmpty Then
    Begin
      fMensagem('', 'É necessário ter registros para Marcar!', ['&O K']);
      Result := False;
      Exit;
    End;

    If edtTipSel.Text = '1' Then
      blnInfDta := False;

    cdsCheque.AggregatesActive := False;

    First;

    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;

    blnNaoMar := False;
    pSetaDataContaDeposito;

    First;

    AggregatesActive := True;
  End;

  pCalculaValoresInformativos;

  cdsCheque.AfterScroll    := pAtualizaDados;
  cdsCheque.EnableControls;

  If blnNaoMar Then
    pMensagemOK('Alguns cheques não foram marcados por algum dos motivos: ' + #13 + '*Estar sendo utilizados por outra estação;' + #13 + '*Recebidos pelo caixa e ainda não foram transferidos.');

  Result := True;
End;

function TfrmBaixaCheques.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin

    First;
    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;
    DisableControls;
    While Not Eof Do
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        pStep(pgbStatus);
        pMarcaCheque(False, 0, '');
      End;
      Next;
    End;

    First;
  End;
  pCalculaValoresInformativos;
  cdsCheque.EnableControls;
  Result := True;
End;


procedure TfrmBaixaCheques.pStep(pgbStatus: TcxProgressBar);
Begin

  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

End;

procedure TfrmBaixaCheques.pBuscaIni;
Begin
  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;
    pSetFocus(dbgCheques);

    If Not cdsCheque.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques para serem buscados!', ['&O k']);
    End;

    pSetFocus(dbgCheques);
  End;
End;

procedure TfrmBaixaCheques.pBuscaProx;
Begin

 If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsCheque.FindNext Then
      fMensagem('ATENÇÃO!', 'Busca concluída!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

  pSetFocus(dbgCheques);
End;

function TfrmBaixaCheques.fDigInfoBaixa : Boolean;
var
 Key: Char;
 frmBaixaAnalitica : TfrmBaixaAnalitica;
 strCodEmpresas: TStringList;
 strEmpSemAcesso, strCodPortadorCheque: String;
Begin
  {*****************************************}
  {* PEDE PORTADOR E CENTRO DE CUSTO       *}
  {**************************************MV*}

  Try
    Application.ProcessMessages;
    pCriarFormularios(TfrmBaixaAnalitica, frmBaixaAnalitica);
    frmBaixaAnalitica.dtaDtValPor  := fAggData(DATA_DEPOSITO, FILTRO_MARCADOS, RET_MENOR);
    frmBaixaAnalitica.blnVemBxCh   := True;

    if strCodPorFix <> '' then
    begin
      frmBaixaAnalitica.edtPorBai.Text :=  strCodPorFix;
      Key := #13;
      frmBaixaAnalitica.edtPorBaiKeyPress(nil, Key);
      frmBaixaAnalitica.edtPorBai.Enabled := False;
    end;

    strCodPortadorCheque := '';

    if fCfgSis('CHQPOR', varBoolean) then
      strCodPortadorCheque := fRetornaPortadorCheque(cdsCheque);

    frmBaixaAnalitica.blnChecaPortador            := TRUE;
    frmBaixaAnalitica.AMostrarDescontoAntecipacao := True;
    frmBaixaAnalitica.edtValorTotalCheques.Text   := edtTotalSelecionado.Text;
    frmBaixaAnalitica.AValorTaxa                  := 0;

    if strCodPortadorCheque <> '' then
      frmBaixaAnalitica.strPorDeb := strCodPortadorCheque;

    frmBaixaAnalitica.ShowModal;

    strCtaBai     := frmBaixaAnalitica.strCtaBai;
    strPorBai     := frmBaixaAnalitica.strPorBai;
    strNomPorBai  := frmBaixaAnalitica.strNomPorBai;
    strCtaDeb     := frmBaixaAnalitica.strCtaDeb;
    strPorDeb     := frmBaixaAnalitica.strPorDeb;

    if frmBaixaAnalitica.AValorTaxa > 0 then
    begin
      AValorTaxaDescAntec     := frmBaixaAnalitica.AValorTaxa;
      AValorTarifaDescAntec   := frmBaixaAnalitica.AValorTarifaAntecipacao;
      APlanoContasAntecipacao := frmBaixaAnalitica.APlanoContasDescAntec;
      AFornecedorAntecipacao  := frmBaixaAnalitica.AFornecedorDescAntec;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCheques.fBaixaCheques]');
    End;
  End;

  Result := frmBaixaAnalitica.blnConfirma;

  If Result Then
  Begin
    cdsCheque.Filtered := False;
    cdsCheque.Filter   := 'CHQ_MARDES = ''M''';
    cdsCheque.Filtered := True;

    strCodEmpresas := fDatasetDistinctField(cdsCheque, 'CHQ_CODEMP');

    cdsCheque.Filtered := False;

    If Not fEmptyStr(strPorBai) Then
    Begin
      If Not fEmpresasTemAcessoPortador(strPorBai, strCodEmpresas, strEmpSemAcesso) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Crédito] informado (%s): %s. Operação abortada!', [strPorBai, strEmpSemAcesso]), ['&OK']);
        strCodEmpresas.Free;
        Exit(False);
      End;
    End;

    If Not fEmptyStr(strPorDeb) Then
    Begin
      If Not fEmpresasTemAcessoPortador(strPorDeb, strCodEmpresas, strEmpSemAcesso) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Débito] informado (%s): %s. Operação abortada!', [strPorDeb, strEmpSemAcesso]), ['&OK']);
        strCodEmpresas.Free;
        Exit(False);
      End;
    End;

    strCodEmpresas.Free;
  End;

  pFreeAndNil(frmBaixaAnalitica);

End;

function TfrmBaixaCheques.fRetornaPortadorCheque(ACheque: TUniClientDataSet) : string;
var LPortadorCheque : string;
begin
  try
    try
      ACheque.DisableControls;
      ACheque.AfterScroll := nil;
      ACheque.Filtered    := False;
      ACheque.Filter      := 'CHQ_MARDES = ''M''';
      ACheque.Filtered    := True;
      ACheque.First;
      LPortadorCheque     := ACheque.FieldByName('CHQ_PORCHQ').AsString;

      while (not ACheque.Eof) do
      begin
        if ACheque.FieldByName('CHQ_MARDES').AsString = 'M' then
        begin
          if ACheque.FieldByName('CHQ_PORCHQ').AsString <> LPortadorCheque then
          begin
            LPortadorCheque := '';
            break;
          end;
        end;
        ACheque.Next;
      end;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    end;
  finally
    ACheque.Filtered    := False;
    ACheque.Filter      := '';
    ACheque.AfterScroll := pAtualizaDados;
    ACheque.EnableControls;
    ACheque.First;
    Result := LPortadorCheque;
  end
end;

procedure TfrmBaixaCheques.pModCheque1;
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

procedure TfrmBaixaCheques.pModCheque2;
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

procedure TfrmBaixaCheques.pAtualizaRelacaoDepositoCheques(sSeqLanMovBan, sSeqDep, sEmpr : String);
  Var
    cdsCloneCheque: TUniClientDataSet;
    strInc : String;
    qryAtuChq : TUniQuery;
    qryCheques : TUniQuery;
begin
  cdsCloneCheque := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsCloneCheque, cdsCheque);

  cdsCloneCheque.Filter := 'CHQ_MARDES = ' + QuotedStr('M');
  cdsCloneCheque.Filtered := True;

  With cdsCloneCheque Do
  Begin
    First;
    While Not Eof Do
    Begin
       If fEmptyStr(strInc) Then
          strInc := '"' + FieldByName('AUTOINCREM').AsString + '"'
       Else
          strInc := strInc + ',' + '"' + FieldByName('AUTOINCREM').AsString + '"';

       Next;
    End;
  End;
  FreeAndNil(cdsCloneCheque);

  // select para trazer os cheques e poder verificar se foi deposito 1 ou 2;
  Try
    qryCheques := fCriaQuery(Self);
    qryAtuChq := fCriaQuery(Self);

    qryCheques.Close;
    qryCheques.SQL.Clear;
    qryCheques.SQL.Add('SELECT ');
    qryCheques.SQL.Add('  AUTOINCREM, CHQ_DTADEP, CHQ_DTADP2 ');
    qryCheques.SQL.Add(' FROM CADCHQ ');
    qryCheques.SQL.Add(' WHERE AUTOINCREM IN ('+ strInc + ') ');
    qryCheques.Open;

    If (Not qryCheques.IsEmpty) Then
    Begin
       qryCheques.First;

       While Not qryCheques.Eof Do
       Begin

         qryAtuChq.Close;
         qryAtuChq.SQL.Clear;
         qryAtuChq.SQL.Add(' UPDATE CADCHQ ');

         If qryCheques.FieldByName('CHQ_DTADP2').AsDateTime > 0 Then
            qryAtuChq.SQL.Add(' SET CHQ_SEQDP2 = :SEQLAN ')
         Else
         If qryCheques.FieldByName('CHQ_DTADEP').AsDateTime > 0 Then
            qryAtuChq.SQL.Add(' SET CHQ_SEQDP1 = :SEQLAN ');

         qryAtuChq.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
         qryAtuChq.ParamByName('SEQLAN').AsString := sSeqLanMovBan;
         qryAtuChq.ParamByName('AUTOIN').AsString := qryCheques.FieldByName('AUTOINCREM').AsString;
         qryAtuChq.ExecSQL;

         qryCheques.Next;
       End;

    End;

    If Assigned(qryCheques) Then
       FreeAndNil(qryCheques);

    If Assigned(qryAtuChq) Then
       FreeAndNil(qryAtuChq);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmBaixaCheques.pAtualizaRelacaoDepositoCheques] ' +E.Message);
    End;
  End;
end;

end.

