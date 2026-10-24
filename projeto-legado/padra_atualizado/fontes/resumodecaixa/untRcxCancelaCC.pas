unit untRcxCancelaCC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, System.Generics.Collections, UniClientDataSet, UniDataSetProvider,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock,
  untRcxTResumoDeCaixa, cxCurrencyEdit;

type
  TfrmRcxCancelaCC = class(TfrmPai)
    grdCreditoTableView: TcxGridDBTableView;
    grdCreditoLevel1: TcxGridLevel;
    grdCredito: TcxGrid;
    grdCreditoTableViewRCX_DTACAD: TcxGridDBColumn;
    grdCreditoTableViewRCX_HORCAD: TcxGridDBColumn;
    grdCreditoTableViewRCX_SEQCON: TcxGridDBColumn;
    grdCreditoTableViewCLIENTE: TcxGridDBColumn;
    grdCreditoTableViewRCX_VALDOC: TcxGridDBColumn;
    btnCancelaCC: TBitBtnLocked;
    grdCreditoTableViewMARDES: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaCCClick(Sender: TObject);
    procedure grdCreditoTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grdCreditoTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdCreditoTableViewKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    cdsLancaCC: TUniClientDataSet;
    dsrLancaCC: TDataSource;
    objLock: TLock;
    procedure pCarregaGrid();
    procedure pAfterOpen(Sender: TDataSet);
    procedure pMudaSelecao();
    function fChequesDepositados(): Boolean;
    function fCartoesBaixados(): Boolean;
    function fContaRecBaixada(): Boolean;
    function fContaEstornada(): Boolean;
    function fChequeTransferido(): Boolean;
    function fCartaoTransferido(): Boolean;
    function fSaldoCaixaInsuficiente(var strModalidades: String): Boolean;
    function fExisteDupPaga : Boolean;
    function EstornaCaixa(intRcxCon: Integer): Boolean;
    procedure pExcluiReceber();
    procedure pExcluiCheque();
    procedure pExcluiCartao();
    procedure HabilitaItensDaTela(AHabiliar: Boolean);
    function fVerificaPixAvulso(intSeqCon: Integer; strCodEmp: String;
      dtaDtaCaixa: TDate): Boolean;

    procedure CancelaCreditoCliente;
  public
    strCodigoCaixa: String;

    objResumoDeCaixa: TResumoDeCaixa;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untCadRcxx, untTCadRcxx, untFuncoes, untTCadRecRepository,
  untTCadRec, untTCadChqRepository, untGravando, untLogMca,
  untTCadChq, untLogCtr, untTFuncoesPixAutcom;

{$R *.dfm}

{ TfrmRcxCancelaCC }

procedure TfrmRcxCancelaCC.btnCancelaCCClick(Sender: TObject);
begin
  inherited;

  If Not btnCancelaCC.Enabled Then
    Exit;

  TfrmGravando.fExecutarModal(CancelaCreditoCliente, 'Aguarde... Cancelado crédito do cliente.', '');
end;

function TfrmRcxCancelaCC.fCartaoTransferido: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_DTACAD>=:DTACAD ' +
                          '  AND MCA_SEQCON=:SEQCON ' +
                          '  AND MCA_EMPRCX=:EMPRCX ' +
                          '  AND MCA_DTATRA IS NOT NULL ';

    LConsulta.ParamByName('DTACAD').AsDateTime := cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime;
    LConsulta.ParamByName('SEQCON').AsInteger := cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('EMPRCX').AsString := cdsLancaCC.FieldByName('RCX_EMPDUP').AsString;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmRcxCancelaCC.fCartoesBaixados: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_DTACAD>=:DTACAD ' +
                          '  AND MCA_SEQCON=:SEQCON ' +
                          '  AND MCA_EMPRCX=:EMPRCX ' +
                          '  AND MCA_DTAREC IS NOT NULL ';

    LConsulta.ParamByName('DTACAD').AsDateTime := cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime;
    LConsulta.ParamByName('SEQCON').AsInteger := cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('EMPRCX').AsString := cdsLancaCC.FieldByName('RCX_EMPDUP').AsString;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmRcxCancelaCC.fChequesDepositados: Boolean;
var
  cadchqRep: TCadChqRepository;
  lstCadChq: TList<TCadChq>;
  cadChq: TCadChq;
begin
  cadchqRep := TCadChqRepository.Create;
  Try
    lstCadChq := cadchqRep.fGetCheques(cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger,
                                       cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    Result := False;
    For cadChq in lstCadChq Do
    Begin
      If cadChq.CHQ_DTADEP.HasValue Then
      Begin
        Result := True;
        Break;
      End;
    End;
  Finally
    FreeAndNil(cadchqRep);
    FreeAndNil(lstCadChq);
  End;
end;

function TfrmRcxCancelaCC.fChequeTransferido: Boolean;
var
  cadchqRep: TCadChqRepository;
  lstCadChq: TList<TCadChq>;
  cadChq: TCadChq;
begin
  cadchqRep := TCadChqRepository.Create;
  Try
    lstCadChq := cadchqRep.fGetCheques(cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger,
                                       cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    Result := False;
    For cadChq in lstCadChq Do
    Begin
      If cadChq.CHQ_SEQTRF.HasValue Then
      Begin
        Result := True;
        Break;
      End;
    End;
  Finally
    FreeAndNil(cadchqRep);
    FreeAndNil(lstCadChq);
  End;
end;

function TfrmRcxCancelaCC.fContaRecBaixada: Boolean;
var
  cadrecRep: TCadRecRepository;
  cadRecBaix: TList<TCadRec>;
begin
  cadrecRep := TCadRecRepository.Create;
  Try
    cadRecBaix := cadrecRep.fRetDuplicatasBaixadas(cdsLancaCC.FieldByName('RCX_NUMDOC').AsString,
                                                   'CC',
                                                   cdsLancaCC.FieldByName('RCX_CODCLI').AsString,
                                                   cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    Result := cadRecBaix.Count > 0;
  Finally
    FreeAndNil(cadrecRep);
    FreeAndNil(cadRecBaix);
  End;
end;

function TfrmRcxCancelaCC.fContaEstornada: Boolean;
var
  cadrecRep: TCadRecRepository;
  cadRecEst: TCadRec;
begin
  cadrecRep := TCadRecRepository.Create;
  Try
    cadRecEst := cadrecRep.fRetDuplicata(cdsLancaCC.FieldByName('RCX_NUMDOC').AsString,
                                         'CC',
                                         cdsLancaCC.FieldByName('RCX_CODCLI').AsString,
                                         cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    Result := cadRecEst.CTR_NUMDUP <> cdsLancaCC.FieldByName('RCX_NUMDOC').AsString;
  Except
    Result := True;
  End;

  If Assigned(cadrecRep) Then
    FreeAndNil(cadrecRep);
end;

procedure TfrmRcxCancelaCC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmRcxCancelaCC.FormCreate(Sender: TObject);
begin
  inherited;
  cdsLancaCC := TUniClientDataSet.Create(Self);
  cdsLancaCC.AfterOpen := pAfterOpen;
  dsrLancaCC := fCriaDataSource(cdsLancaCC);
  grdCreditoTableView.DataController.DataSource := dsrLancaCC;
  objLock := TLock.Create;

  strCodigoCaixa := '';
end;

procedure TfrmRcxCancelaCC.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnCancelaCC.Click;
  If Key = VK_Escape Then
    pEscapePressed;
end;

procedure TfrmRcxCancelaCC.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaGrid();
end;

function TfrmRcxCancelaCC.fSaldoCaixaInsuficiente(var strModalidades: String): Boolean;

  procedure pAddMod(var strResultado: String; strModalidade: String);
  Begin
    If Length(strResultado) > 0 Then
    Begin
      If Pos(' e ', strResultado) > 0 Then
        strResultado := ', ' + strResultado
      else
        strResultado := ' e ' + strResultado;
    End;
    strResultado := strModalidade + strResultado;
  End;

Var
    blnPixAvulso : Boolean;
begin
  Result := False;
  strModalidades := '';

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_VALFIN', strCodigoCaixa) < cdsLancaCC.FieldByName('RCX_VALFIN').AsFloat Then
  Begin
    pAddMod(strModalidades, 'financiamento');
    Result := True;
  End;

  blnPixAvulso := fVerificaPixAvulso(cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger,
                                     cdsLancaCC.FieldByName('RCX_CODEMP').AsString,
                                     cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime);

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_ORDREC', strCodigoCaixa, '', '', cdsLancaCC.FieldByName('RCX_RECPIX').AsString = 'S', blnPixAvulso, Not blnPixAvulso) < cdsLancaCC.FieldByName('RCX_ORDREC').AsFloat Then
  Begin
    pAddMod(strModalidades, 'ordem de pagamento');
    Result := True;
  End;

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CARREC', strCodigoCaixa) < cdsLancaCC.FieldByName('RCX_CARREC').AsFloat Then
  Begin
    pAddMod(strModalidades, 'cartão');
    Result := True;
  End;

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CHQPRE', strCodigoCaixa) < cdsLancaCC.FieldByName('RCX_CHQPRE').AsFloat Then
  Begin
    pAddMod(strModalidades, 'cheque pré');
    Result := True;
  End;

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_CHQAVI', strCodigoCaixa) < cdsLancaCC.FieldByName('RCX_CHQAVI').AsFloat Then
  Begin
    pAddMod(strModalidades, 'cheque à vista');
    Result := True;
  End;

  If objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa) < cdsLancaCC.FieldByName('RCX_DINREC').AsFloat Then
  Begin
    pAddMod(strModalidades, 'dinheiro');
    Result := True;
  End;
end;

procedure TfrmRcxCancelaCC.grdCreditoTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pMudaSelecao();
end;

procedure TfrmRcxCancelaCC.grdCreditoTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  strMarDes : String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdCreditoTableViewMARDES.Index]);
  If (cdsLancaCC.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmRcxCancelaCC.grdCreditoTableViewKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pMudaSelecao();
end;

procedure TfrmRcxCancelaCC.HabilitaItensDaTela(AHabiliar: Boolean);
begin
  grdCredito.Enabled := AHabiliar;
  btnCancelaCC.Enabled := AHabiliar;
  btnSair.Enabled := AHabiliar;
end;

procedure TfrmRcxCancelaCC.pAfterOpen(Sender: TDataSet);
begin
  TFloatField(Sender.FieldByName('RCX_VALDOC')).DisplayFormat := '###,###,##0.00';
end;

procedure TfrmRcxCancelaCC.pCarregaGrid;
  Var
    qryLancaCC: TUniQuery;

    fltSaldo: Double;

    dteUltFech: TDateTime;
begin
  cdsLancaCC.Close;
  qryLancaCC := fCriaQuery(Nil);
  Try
    qryLancaCC.Close;
    qryLancaCC.SQL.Clear;
    qryLancaCC.SQL.Add('SELECT                          ');
    qryLancaCC.SQL.Add('  CADRCXX.AUTOINCREM,           ');
    qryLancaCC.SQL.Add('  C.AUTOINCREM AS CTR_AUTINC,   ');
    qryLancaCC.SQL.Add('  RCX_CODCLI,                   ');
    qryLancaCC.SQL.Add('  CONCAT(RCX_CODCLI,            ');
    qryLancaCC.SQL.Add('         '' - '',               ');
    qryLancaCC.SQL.Add('         CLI_NOMCLI) AS CLIENTE,');
    qryLancaCC.SQL.Add('  RCX_CODOPE,                   ');
    qryLancaCC.SQL.Add('  RCX_NUMDOC,                   ');
    qryLancaCC.SQL.Add('  RCX_ESPDOC,                   ');
    qryLancaCC.SQL.Add('  RCX_CODEMP,                   ');
    qryLancaCC.SQL.Add('  RCX_EMPDUP,                   ');
    qryLancaCC.SQL.Add('  RCX_DTACAD,                   ');
    qryLancaCC.SQL.Add('  RCX_HORCAD,                   ');
    qryLancaCC.SQL.Add('  RCX_DESCRI,                   ');
    qryLancaCC.SQL.Add('  RCX_VALDOC,                   ');
    qryLancaCC.SQL.Add('  RCX_DINREC,                   ');
    qryLancaCC.SQL.Add('  RCX_CHQAVI,                   ');
    qryLancaCC.SQL.Add('  RCX_CHQPRE,                   ');
    qryLancaCC.SQL.Add('  RCX_CARREC,                   ');
    qryLancaCC.SQL.Add('  RCX_ORDREC,                   ');
    qryLancaCC.SQL.Add('  RCX_VALFIN,                   ');
    qryLancaCC.SQL.Add('  RCX_SEQCON,                   ');
    qryLancaCC.SQL.Add('  RCX_SQFCRX,                   ');
    qryLancaCC.SQL.Add('  RCX_EMPDUP,                   ');
    qryLancaCC.SQL.Add('  RCX_IDECAI,                   ');
    qryLancaCC.SQL.Add('  RCX_RECPIX,                   ');
    qryLancaCC.SQL.Add('  M.MPX_TX_ID_,                 ');
    qryLancaCC.SQL.Add('  " " AS MARDES                 ');
    qryLancaCC.SQL.Add('FROM                            ');
    qryLancaCC.SQL.Add('  CADRCXX                       ');
    qryLancaCC.SQL.Add('INNER JOIN CADCLI               ');
    qryLancaCC.SQL.Add('   ON CLI_CODCLI = RCX_CODCLI   ');
    qryLancaCC.SQL.Add('INNER JOIN CADREC C             ');
    qryLancaCC.SQL.Add('   ON C.CTR_NUMDUP = RCX_NUMDOC ');
    qryLancaCC.SQL.Add('  AND C.CTR_ESPDOC = RCX_ESPDOC ');
    qryLancaCC.SQL.Add('  AND C.CTR_CODCLI = RCX_CODCLI ');
    qryLancaCC.SQL.Add('  AND C.CTR_CODEMP = RCX_EMPDUP ');
    qryLancaCC.SQL.Add('  AND C.CTR_SEQBAI = RCX_SEQBAI ');
    qryLancaCC.SQL.Add('INNER JOIN LOGCTR R             ');
    qryLancaCC.SQL.Add('   ON R.CTR_NUMDUP = RCX_NUMDOC ');
    qryLancaCC.SQL.Add('  AND R.CTR_ESPDOC = RCX_ESPDOC ');
    qryLancaCC.SQL.Add('  AND R.CTR_CODCLI = RCX_CODCLI ');
    qryLancaCC.SQL.Add('  AND R.CTR_CODEMP = RCX_EMPDUP ');
    qryLancaCC.SQL.Add('  AND R.CTR_SEQBAI = RCX_SEQBAI ');
    qryLancaCC.SQL.Add('  AND R.CTR_RESCAI = 1          ');
    qryLancaCC.SQL.Add('  AND R.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD") ');
    qryLancaCC.SQL.Add('LEFT JOIN MOVPIX M              ');
    qryLancaCC.SQL.Add('   ON M.MPX_SEQCON=RCX_SEQCON   ');
    qryLancaCC.SQL.Add('  AND M.MPX_CODEMP=RCX_CODEMP   ');
    qryLancaCC.SQL.Add('  AND M.MPX_DTAREC=RCX_DTACAD   ');
    qryLancaCC.SQL.Add('LEFT JOIN ADTCLI A              ');
    qryLancaCC.SQL.Add('   ON A.ADT_SEQCON=RCX_SEQCON   ');
    qryLancaCC.SQL.Add('  AND A.ADT_EMPLAN=RCX_CODEMP   ');
    qryLancaCC.SQL.Add('  AND A.ADT_DTALAN=RCX_DTACAD   ');
    qryLancaCC.SQL.Add('  AND A.ADT_TIPLAN="C"          ');
    qryLancaCC.SQL.Add('WHERE RCX_DTACAD > :DTAFEC      ');
    qryLancaCC.SQL.Add('  AND RCX_CODEMP = :CODEMP      ');

    If Not strCodigoCaixa.IsEmpty Then
    Begin
      qryLancaCC.SQL.Add('  AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString);
      qryLancaCC.SQL.Add('  AND RCX_LANFEC = "N"        ');
    End;

    qryLancaCC.SQL.Add('  AND RCX_ESPDOC = ''CC''       ');
    qryLancaCC.SQL.Add('  AND RCX_VALDOC > 0            ');
    qryLancaCC.SQL.Add('  AND C.CTR_PARCEL = ''A''      ');
    qryLancaCC.SQL.Add('  AND C.CTR_DTAREC IS NULL      ');
    qryLancaCC.SQL.Add('  AND A.AUTOINCREM IS NULL      ');
    qryLancaCC.SQL.Add('  AND (SELECT IFNULL(COUNT(AUTOINCREM), 0) ');
    qryLancaCC.SQL.Add('       FROM CADREC              ');
    qryLancaCC.SQL.Add('       WHERE CTR_NUMDUP = RCX_NUMDOC ');
    qryLancaCC.SQL.Add('         AND CTR_ESPDOC = RCX_ESPDOC ');
    qryLancaCC.SQL.Add('         AND CTR_CODCLI = RCX_CODCLI ');
    qryLancaCC.SQL.Add('         AND CTR_CODEMP = RCX_EMPDUP ');
    qryLancaCC.SQL.Add('         AND CTR_SEQBAI > 0) = 0     ');
    qryLancaCC.SQL.Add('  GROUP BY C.CTR_NUMDUP,        ');
    qryLancaCC.SQL.Add('  C.CTR_ESPDOC,                 ');
    qryLancaCC.SQL.Add('  C.CTR_CODCLI,                 ');
    qryLancaCC.SQL.Add('  C.CTR_CODEMP,                 ');
    qryLancaCC.SQL.Add('  C.CTR_SEQBAI                  ');
    qryLancaCC.SQL.Add('ORDER BY                        ');
    qryLancaCC.SQL.Add('  RCX_DTACAD,                   ');
    qryLancaCC.SQL.Add('  RCX_HORCAD                    ');

    objResumoDeCaixa.fRetornaUltimoFechamento(fltSaldo, dteUltFech, strCodigoCaixa);

    qryLancaCC.ParamByName('DTAFEC').AsDateTime := dteUltFech - IIF(objResumoDeCaixa.strTipoFechamento <> 'C', 0, 1);
    qryLancaCC.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryLancaCC.Open;

    cdsLancaCC := fCriaClientDatset(qryLancaCC);
    cdsLancaCC.AfterOpen := pAfterOpen;

    dsrLancaCC.DataSet := cdsLancaCC;

    cdsLancaCC.Open;
    cdsLancaCC.First;
  Finally
    qryLancaCC.Close;

    FreeAndNil(qryLancaCC);
  End;
end;

procedure TfrmRcxCancelaCC.CancelaCreditoCliente;
  var
    intRcxCon: Integer;

    strModalidades: String;
begin
  inherited;

  cdsLancaCC.DisableControls;
  cdsLancaCC.Filtered := False;
  cdsLancaCC.Filter   := 'MARDES = ' + QuotedStr('M');
  cdsLancaCC.Filtered := True;

  Try

    If cdsLancaCC.IsEmpty Then
    Begin
      fMensagem('', 'Nenhum registro de crédito para ser cancelado!', ['&Ok']);
      Exit;
    End;

    If fContaEstornada() Then
    Begin
      fMensagem('', 'A conta de crédito referente a este lançamento foi estornada! Operação cancelada.', ['&Ok']);
      objLock.pDestravarTodos;
      pCarregaGrid();
      Exit;
    End;

    If fChequesDepositados() Then
    Begin
      fMensagem('', 'Os Cheques recebidos nesse lançamento já foram depositados! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If (fCfgSis('RCXTCC') = '2') And fChequeTransferido() Then
    Begin
      fMensagem('', 'Os Cheques recebidos nesse lançamento já foram transferidos do caixa! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If fCartoesBaixados() Then
    Begin
      fMensagem('', 'Os Cartões recebidos nesse lançamento já foram baixados! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If (fCfgSis('RCXTCC') = '2') And fCartaoTransferido() Then
    Begin
      fMensagem('', 'Os Cartões recebidos nesse lançamento já foram transferidos do caixa! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If fContaRecBaixada() Then
    Begin
      fMensagem('', 'A conta de crédito referente a este lançamento já sofreu baixas! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If fSaldoCaixaInsuficiente(strModalidades) Then
    Begin
      fMensagem('', 'O cancelamento deste lançamento deixará o caixa negativo na(s) modalidade(s) ' + strModalidades + '! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If fExisteDupPaga Then
    Begin
      fMensagem('', 'Esse crédito foi gerado a partir da baixa de um débito. Para o cancelamento, executar a rotina de estorno de contas a receber! Operação cancelada.', ['&Ok']);
      Exit;
    End;

    If fMensagem('Confirmação', 'Deseja realmente cancelar o crédito realizado para este cliente?', ['&Sim', '&Não']) = 1 Then
    Begin
      intRcxCon := StrToInt(fRetRcxCon);

      fStartTransaction;
      Try
        HabilitaItensDaTela(False);

        If EstornaCaixa(intRcxCon) Then
        Begin
          pExcluiReceber();
          pExcluiCheque();
          pExcluiCartao();

          If cdsLancaCC.FieldByName('RCX_RECPIX').AsString = 'S' Then
          Begin
            If Not cdsLancaCC.FieldByName('MPX_TX_ID_').AsString.IsEmpty Then
            Begin
              TFuncoesPixAutcom.ExcluirPixDoCaixa(cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger,
                                                  cdsLancaCC.FieldByName('RCX_CODEMP').AsString,
                                                  cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime,
                                                  Self.Name,
                                                  intRcxCon);
            End;
          End;

          fCommit;

          pCarregaGrid();
          objLock.pDestravarTodos;
          fMensagem('', 'Lançamento de crédito cancelado com sucesso!', ['&Ok']);
        End
        Else
        Begin
          fRollback;

          pCarregaGrid();
          objLock.pDestravarTodos;
          fMensagem('', 'Não foi possível cancelar o lançamento de crédito!', ['&Ok']);
        End;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[frmRcxCancelaCC.btnCancelaCCClick]');
        End;
      End;
    End;

  Finally
    HabilitaItensDaTela(True);

    cdsLancaCC.Filtered := False;
    cdsLancaCC.EnableControls;
  End;
end;

function TfrmRcxCancelaCC.EstornaCaixa(intRcxCon: Integer): Boolean;
var
  objCadRcxx: TCadRcxx;
begin
  objCadRcxx := TCadRcxx.Create();

  objCadRcxx.strCodCli := cdsLancaCC.FieldByName('RCX_CODCLI').AsString;
  objCadRcxx.strCodOpe := cdsLancaCC.FieldByName('RCX_CODOPE').AsString;
  objCadRcxx.strNumDoc := cdsLancaCC.FieldByName('RCX_NUMDOC').AsString;
  objCadRcxx.strEspDoc := 'LD';
  objCadRcxx.strCodEmp := VS_strCodEmp;
  objCadRcxx.dtaDtaCad := cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime;
  objCadRcxx.dtaHorCad := fTime();
  objCadRcxx.strParcel := '';
  objCadRcxx.strDescri := 'CANCELAMENTO DE CRÉDITO DO CLIENTE: ' + cdsLancaCC.FieldByName('CLIENTE').AsString;
  objCadRcxx.strIdeFec := '';
  objCadRcxx.fltValDoc := cdsLancaCC.FieldByName('RCX_VALDOC').AsFloat * -1;
  objCadRcxx.fltDinRec := cdsLancaCC.FieldByName('RCX_DINREC').AsFloat * -1;
  objCadRcxx.fltChqAvi := cdsLancaCC.FieldByName('RCX_CHQAVI').AsFloat * -1;
  objCadRcxx.fltChqPre := cdsLancaCC.FieldByName('RCX_CHQPRE').AsFloat * -1;
  objCadRcxx.fltCarRec := cdsLancaCC.FieldByName('RCX_CARREC').AsFloat * -1;
  objCadRcxx.strJurDes := '';
  objCadRcxx.intSeqCon := intRcxCon;
  objCadRcxx.fltOrdRec := cdsLancaCC.FieldByName('RCX_ORDREC').AsFloat * -1;
  objCadRcxx.intSqFcRx := cdsLancaCC.FieldByName('RCX_SQFCRX').AsInteger;
  objCadRcxx.strEmpDup := cdsLancaCC.FieldByName('RCX_EMPDUP').AsString;
  objCadRcxx.strIdeCai := cdsLancaCC.FieldByName('RCX_IDECAI').AsString;
  objCadRcxx.fltValFin := cdsLancaCC.FieldByName('RCX_VALFIN').AsFloat * -1;
  objCadRcxx.strLanFec := 'N';
  objCadRcxx.dtaDtaGrv := fCampoTabela('CURRENT_TIMESTAMP', 'DUAL', [], []);
  objCadRcxx.strRecPix := cdsLancaCC.FieldByName('RCX_RECPIX').AsString;

  If Not strCodigoCaixa.IsEmpty Then
    objCadRcxx.strCodCax := strCodigoCaixa;

  Result := fGravaCadRcx(objCadRcxx);
end;

procedure TfrmRcxCancelaCC.pExcluiCartao;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_DTACAD>=:DTACAD ' +
                          '  AND MCA_SEQCON=:SEQCON ' +
                          '  AND MCA_EMPRCX=:EMPRCX ';

    LConsulta.ParamByName('DTACAD').AsDateTime := cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime;
    LConsulta.ParamByName('SEQCON').AsInteger := cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('EMPRCX').AsString := cdsLancaCC.FieldByName('RCX_EMPDUP').AsString;

    LConsulta.Open;

    LConsulta.First;
    While Not LConsulta.Eof Do
    Begin
      untLogMca.GravaLogMca(LConsulta.FieldByName('AUTOINCREM').AsString,
                            'EXCLUSÃO',
                            Self.Name);

      fVerificaIntegridade(Self.Name,
                           'MOVCAR',
                           LConsulta);

      LConsulta.Delete;

      LConsulta.First;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRcxCancelaCC.pExcluiCheque;
var
  cadchqRep: TCadChqRepository;
  lstCadChq: TList<TCadChq>;
  cadChq: TCadChq;
begin
  If cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger <= 0 Then
    Exit;

  If cdsLancaCC.FieldByName('RCX_EMPDUP').AsString.IsEmpty Then
    Exit;

  cadchqRep := TCadChqRepository.Create;
  Try
    lstCadChq := cadchqRep.fGetCheques(cdsLancaCC.FieldByName('RCX_SEQCON').AsInteger,
                                       cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    For cadChq in lstCadChq Do
    Begin
      cadchqRep.pGravaLog(cadChq, 'EXCLUSÃO');
      cadchqRep.pGravaDel(cadChq);
      cadchqRep.pExcluir(cadChq);
    End;
  Finally
    FreeAndNil(cadchqRep);
    FreeAndNil(lstCadChq);
  End;
end;

procedure TfrmRcxCancelaCC.pExcluiReceber;
var
  cadrecRep: TCadRecRepository;
  cadRec   : TCadRec;
  strGetCliente : String;
begin
  cadrecRep := TCadRecRepository.Create;
  Try
    cadRec := cadrecRep.fRetDuplicata(cdsLancaCC.FieldByName('RCX_NUMDOC').AsString,
                                      'CC',
                                      cdsLancaCC.FieldByName('RCX_CODCLI').AsString,
                                      cdsLancaCC.FieldByName('RCX_EMPDUP').AsString);

    strGetCliente := cadRec.objCodCli.strCodCli;
    untLogCtr.GravaLogCtr(cadRec.AUTOINCREM, 'EXCLUSÃO', 'frmRcxCancelaCC');
    cadrecRep.pGravaDel(cadRec, 'frmRcxCancelaCC');
    cadrecRep.pExcluir(cadRec);
  Finally
    FreeAndNil(cadrecRep);
  End;
end;

procedure TfrmRcxCancelaCC.pMudaSelecao;
var
  intRecNo : Integer;
  strChaLck: String;
begin
  If (Not cdsLancaCC.IsEmpty) Then
  Begin
    If cdsLancaCC.FieldByName('MARDES').AsString <> 'M' Then
    Begin
      cdsLancaCC.DisableControls;
      intRecNo := cdsLancaCC.RecNo;
      cdsLancaCC.Filtered := False;
      cdsLancaCC.Filter   := 'MARDES = ' + QuotedStr('M');
      cdsLancaCC.Filtered := True;

      Try

        If Not cdsLancaCC.IsEmpty Then
        Begin
          fMensagem('', 'Selecione apenas um registro por vez para fazer o cancelamento!', ['&Ok']);
          Exit;
        End;

      Finally
        cdsLancaCC.Filtered := False;
        cdsLancaCC.RecNo := intRecNo;
        cdsLancaCC.EnableControls;
      End;
    End;

    strChaLck := 'CADREC' +
               cdsLancaCC.FieldByName('RCX_NUMDOC').AsString +
               cdsLancaCC.FieldByName('RCX_ESPDOC').AsString +
               cdsLancaCC.FieldByName('RCX_EMPDUP').AsString +
               cdsLancaCC.FieldByName('RCX_CODCLI').AsString;

    cdsLancaCC.Edit;
    If cdsLancaCC.FieldByName('MARDES').AsString = 'M' Then
    Begin
      cdsLancaCC.FieldByName('MARDES').AsString := 'D';
      objLock.fLock_Unlock(strChaLck + 'A', False);
    End
    Else
    Begin
      If Not fEmptyStr(fGetHostLock(strChaLck)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
        Exit;
      End;
      If Not objLock.fLock_Unlock(strChaLck + 'A', True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck + 'A'), ['&Ok']);
        Exit;
      End;

      cdsLancaCC.FieldByName('MARDES').AsString := 'M';
    End;
    cdsLancaCC.Post;
  End;
end;

function TfrmRcxCancelaCC.fExisteDupPaga : Boolean;
  Var
    strSQL       : String;
    qryGen       : TUniQuery;
begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT AUTOINCREM ';
    strSQL := strSQL + '  FROM CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '   CTR_EMPBAI = :CODEMP AND ';
    strSQL := strSQL + '   CTR_DTABAI = :DTACAD ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsString   := cdsLancaCC.FieldByName('RCX_SEQCON').AsString;
      ParamByName('CODEMP').AsString   := cdsLancaCC.FieldByName('RCX_CODEMP').AsString;
      ParamByName('DTACAD').AsDateTime := cdsLancaCC.FieldByName('RCX_DTACAD').AsDateTime;
      Open;
      Result := Not qryGen.IsEmpty;
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao tentar verificar duplicata paga: ' + E.Message);
    End;
  End;

  FreeAndNil(qryGen);
end;

function TfrmRcxCancelaCC.fVerificaPixAvulso(intSeqCon: Integer; strCodEmp: String; dtaDtaCaixa : TDate): Boolean;
  Var
    qryGen : TUniQuery;
    strSQL : String;
Begin
  Result := False;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT AUTOINCREM FROM MOVPIX ';
    strSQL := strSQL + '  WHERE MPX_SEQCON = :SEQCON ';
    strSQL := strSQL + '    AND MPX_DTACAD = :DTACAD ';
    strSQL := strSQL + '    AND MPX_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQCON').AsInteger  := intSeqCon;
      ParamByName('DTACAD').AsDatetime := dtaDtaCaixa;
      ParamByName('CODEMP').AsString   := strCodEmp;
      Open;

      If IsEmpty Then
         Result := True
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmRcxCancelaCC.fVerificaPixAvulso]');
    End;
  End;

  FreeAndNil(qryGen);

End;

end.
