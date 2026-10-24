unit untCancDepChequePreMod2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, UniClientDataSet, untFechamentoFinanceiro,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, UniDataSetProvider,untBuscaCheques;

type
  TfrmCancDepChequePreMod2 = class(TfrmPai)
    pnlCons: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtCodBco: TEditFocus;
    EdtNumAge: TEditFocus;
    EdtConCor: TEditFocus;
    EdtNumChq: TEditFocus;
    edtNomBco: TEditFocus;
    pnlInf: TPanel;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesNivel: TcxGridLevel;
    dbgCheques: TcxGrid;
    dsConsulta: TDataSource;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTACAD: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTADEP: TcxGridDBColumn;
    dbgChequesDadosCHQ_CTADEP: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    pnlTotais: TPanel;
    Label23: TLabel;
    Label9: TLabel;
    edtTotalCheques: TEditFocus;
    edtValorTotal: TEditFocus;
    pnlAux1: TPanel;
    pnlDadosCheque: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label6: TLabel;
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
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtChqSelecionados: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    btnPesquisa: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure EdtCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    qryConBco: TUniQuery;
    qryCadBco: TUniQuery;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    fldGen: TAggregateField;

    blnCanceladoSucesso,
    blnTransf: Boolean;

    strCodPor,
    strCodCta,
    strPorDeb,
    strCtaDeb,
    strHist01,
    strNumChq,
    strEmpChq,
    strCodCli,
    strCodBco,
    strNumAge,
    strConCor,
    strNomEmi,
    strValorFiltro,
    strCampoFiltro,
    strHistc1,
    strHistc2: String;


    dtaDtaLan: TDateTime;

    fltValChq: Double;

    qryConsDep: TUniQuery;
    objFechamento: TFechamentoFinanceiro;

    procedure pDesbloqueiaRegistro;
    procedure pCarregaBanco;
    procedure pEsconde(blnMens: Boolean = True);
    procedure pLimpaTela(blnLimpaFiltro: Boolean = True);
    procedure pMostra;
    function fSelectChequePre: Boolean;
    procedure pConsultaChequePre;
    function fConsultaDeposito: Boolean;
    procedure pMarcaDesmarcaCheque;
    procedure pMarcaDesmarcaTodosCheques(strMarcaDesmarca: string);
    procedure pApagaCadRecDepDev(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String);
    function fGravaCreditoMovBan: Boolean;
    function fGravaDebitoMovBan: Boolean;
    function fUpdateChequePre: Boolean;
    function fCancelaDeposito: Boolean;
    function fMovimentacaoBancariaConciliada(ASeqDep, AEmpDep, ACodBco,
                                             ANumAge, ACtaCor, ANumChq, ACodCli: String): Boolean;
    function fDuplicataQuitada(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String): Boolean;
    procedure pSetaVariaveis;
    procedure pCancelaDeposito;
    procedure pCancelaDepositoEmLote;
    procedure pAtualizaDados(DataSet: TDataSet);
    function fBuscaNomeBanco(strCodBanco: string): string;
    procedure pBuscaIni;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pBuscaProx;
    procedure pTravaCheques;
    procedure pBuscaGrupoCheque(strCodBanco, strAgencia, strCtaCorrente, strNumCheque: string; var strLoja: string; var strGrupo: string);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untPesqAux, untFuncoesSimples, untConsultas, untTypesSistema, untGravando,
  untDigPortador, untMovBan, untCadRec, untFuncoesGenerica, untConstantes, untCadChq,
  untTCadChqRepository, untTBanChqRepository, untCadPag, untFuncoes;

{$R *.dfm}

procedure TfrmCancDepChequePreMod2.btnCarrChequesClick(Sender: TObject);
begin
  inherited;
  if (Trim(EdtCodBco.Text) = '') then
  begin
    fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
    pSetFocus(EdtCodBco);
    Exit;
  end
  else
  if (Trim(EdtNumAge.Text) = '') then
  begin
    fMensagem('ATENÇÃO!', 'A agência do Banco deve ser preenchido!', ['&O k']);
    pSetFocus(EdtNumAge);
    Exit;
  end
  else
  if (Trim(EdtConCor.Text) = '') then
  begin
    fMensagem('ATENÇÃO!', 'A conta corrente do Banco deve ser preenchido!', ['&O k']);
    pSetFocus(EdtConCor);
    Exit;
  end
  else
  if (Trim(EdtNumChq.Text) = '') then
  begin
    fMensagem('ATENÇÃO!', 'O número do cheque deve ser preenchido!', ['&O k']);
    pSetFocus(EdtNumChq);
    Exit;
  end;

  TfrmGravando.fExecutarModal(pConsultaChequePre,'Aguarde... Carregando Cheques.','');
  pSetFocus(dbgCheques);
end;

procedure TfrmCancDepChequePreMod2.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if (not qryConsulta.IsEmpty) and (StrToIntDef(edtChqSelecionados.Text, 0) > 0) then
  begin
    If fMensagem('AVISO', 'Deseja cancelar o Depósito do(s) Cheque(s) ?', ['&Sim', '&Não']) = 1 Then
    begin
      TfrmGravando.fExecutarModal(pCancelaDepositoEmLote,'Aguarde... Carregando Cheques.','');
    end;
  end
  else
  begin
    fMensagem('', 'É necessário ter registros marcados para cancelar o depósito de cheque!', ['&Ok']);
  end;
end;

procedure TfrmCancDepChequePreMod2.btnDesmTodosClick(Sender: TObject);
begin
  inherited;
  if not qryConsulta.IsEmpty then
  begin
    pMarcaDesmarcaTodosCheques('D');
  end
  else
  begin
    fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
  end;
end;

procedure TfrmCancDepChequePreMod2.btnIniBusClick(Sender: TObject);
begin
  inherited;
  if qryConsulta.IsEmpty then
  begin
    fMensagem('', 'É necessário ter registro para iniciar busca!', ['&Ok']);
  end
  else
  begin
    Try
      pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
      frmBuscaCheques.ShowModal;
      pBuscaIni;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmBaixaCheques.btnIniBusClick]');
      End;
    End;

    pFreeAndNil(frmBuscaCheques);
  end;
end;

procedure TfrmCancDepChequePreMod2.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If qryConsulta.IsEmpty Then
  begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
  end
  else
  begin
    pBuscaProx;
  end;
end;

procedure TfrmCancDepChequePreMod2.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  if not qryConsulta.IsEmpty then
  begin
    pMarcaDesmarcaTodosCheques('M');
  end
  else
  begin
    fMensagem('','É necessário ter registros para marcar!',['&OK']);
  end;
end;

procedure TfrmCancDepChequePreMod2.btnPesquisaClick(Sender: TObject);
  Var
    arrSel    : TConsultasArray;
    chrKey    : Char;

begin
  Try

    chrKey := '/';
    utcRegistros.Limpar(Self.Name + 'CADCHQ');

    Try

      If fPesqCheqDep(Self, qryConsDep, 'CADCHQ', False, chrKey, arrSel) Then
      Begin
        With qryConsDep Do
        Begin
          If Not IsEmpty Then
          Begin
            EdtCodBco.Text := FieldByName('CHQ_CODBCO').AsString;
            EdtNumAge.Text := FieldByname('CHQ_NUMAGE').AsString;
            EdtConCor.Text := FieldByName('CHQ_CONCOR').AsString;
            EdtNumChq.Text := FieldByname('CHQ_NUMCHQ').AsString;
          End;
        End;

        pCarregaBanco;

        If Not fEmptyStr(EdtNumChq.Text) Then
        Begin
          If fValidaCampos(EdtNumChq,True) Then
             btnCarrCheques.Click;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCancDepChequePreMod2.btnPesquisaClick]');
      End;
    End;

  Finally
    qryConsDep.Close;
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);
  End;
end;

procedure TfrmCancDepChequePreMod2.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCancDepChequePreMod2.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: string;
begin
  inherited;
  if cdsConsulta.Active then
  begin
    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_MARDES.Index]);
    if strMarDes = 'M' then
    begin
      ACanvas.Font.Color := clBlue;
    end
    else
    begin
      ACanvas.Font.Color := clBlack;
    end;
  end;
end;

procedure TfrmCancDepChequePreMod2.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN) and (qryConsulta.RecordCount > 0  ) then
  begin
    pMarcaDesmarcaCheque;
  end;
end;

procedure TfrmCancDepChequePreMod2.EdtCodBcoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodBco, edtNomBco, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(EdtCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

function TfrmCancDepChequePreMod2.fBuscaNomeBanco(strCodBanco: string): string;
begin

  Result := '';

  If fEmptyStr(strCodBanco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBanco], False);

end;

function TfrmCancDepChequePreMod2.fCancelaDeposito: Boolean;
begin
  Result := True;

  fStartTransaction;

  If Not fUpdateChequePre Then
    Result := False;

  If Not blnTransf Then
  Begin

    If (Result) And (Not qryConsulta.FieldByName('CHQ_CODPOR').IsNull) And
                    (Not qryConsulta.FieldByName('CHQ_CODCTA').IsNull) Then
    Begin
      If Not fGravaDebitoMovBan Then
        Result := False;
    End;

    If (Result) And (Not qryConsulta.FieldByName('CHQ_PORDEB').IsNull) And
                    (Not qryConsulta.FieldByName('CHQ_CTADEB').IsNull) Then
    Begin
      If Not fGravaCreditoMovBan Then
        Result := False;
    End;

  End
  Else
  Begin

    If (Result) Then
    Begin

      If (Not fEmptyStr(qryConsulta.FieldByName('CHQ_DUPDEP').AsString)) Then
        pApagaCadRecDepDev(qryConsulta.FieldByName('DUPTRF').AsString,
                           qryConsulta.FieldByName('ESPTRF').AsString,
                           qryConsulta.FieldByName('EMPTRF').AsString,
                           qryConsulta.FieldByName('PARTRF').AsString,
                           qryConsulta.FieldByName('CLITRF').AsString);

    End;

  End;

  If Result Then
  BEGIN
    fCommit;
  END
  Else
    fRollBack;
end;

function TfrmCancDepChequePreMod2.fConsultaDeposito: Boolean;
begin
  Result := True;
  If Not fSelectChequePre Then
    Result := False;
end;

function TfrmCancDepChequePreMod2.fDuplicataQuitada(strNumDup, strEspDup,
  strCodEmp, strParcel, strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin

    Clear;
    Add('SELECT');
    Add('  COUNT(*) AS QTDDUP');
    Add('FROM');
    Add('  CADREC ');
    Add('WHERE');
    Add('  CTR_NUMDUP = :NUMDUP AND ');
    Add('  CTR_ESPDOC = :ESPDOC AND ');
    Add('  CTR_CODEMP = :CODEMP AND ');
    Add('  CTR_CODCLI = :CODCLI AND ');
    Add('  CTR_PARCEL = :PARCEL AND ');
    Add('  CTR_DTAREC IS NOT NULL   ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;
    Result := FieldByName('QTDDUP').AsInteger > 0;
    Close;

  End;

  FreeAndNil(qryGen);
End;

function TfrmCancDepChequePreMod2.fGravaCreditoMovBan: Boolean;
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
                  '',                               // Documento da Baixa
                  lstBanChq.fGetList                // Log Bancário
                 ) = '' Then
    Result := False;

  FreeAndNil(lstBanChq);
end;

function TfrmCancDepChequePreMod2.fGravaDebitoMovBan: Boolean;
  Var
    lstBanChq : TBanChqRepository;
Begin
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

  If fGravaMovBan(strCodCta,                       // Centro de Custo
                  strCodPor,                       // Portador da Baixa
                  strLoginUsuarioLogado,           // Operador da Baixa
                  dtaDtaLan,                       // Data do Lançamento
                  fTime(),                         // Hora do Lançamento
                  strNumChq,                       // Numero do Documento
                  'D',                             // Credito / Debito
                  VS_strCodEmp,                    // Empresa da Baixa
                  fltValChq,                       // Valor Do Lançamento
                  strHist01,                       // Histórico 1
                  '',                              // Histórico 2
                  strCodCli,                       // Cliente da Duplicata
                  '',                              // Fornecedor da Duplicata
                  strNumChq,                       // Número da Duplicata
                  0,                               // Sequencial de Baixa
                  '',                              // Parcela da Duplicata
                  strEmpChq,                       // Empresa da Duplicata
                  '',                              // Série
                  '',                              // Código do Evento
                  '',                              // Documento da Baixa
                  lstBanChq.fGetList               // Log Bancário
                 ) = '' Then
    Result := False;

  FreeAndNil(lstBanChq);
End;

function TfrmCancDepChequePreMod2.fMovimentacaoBancariaConciliada(ASeqDep, AEmpDep, ACodBco,
                                                                  ANumAge, ACtaCor, ANumChq, ACodCli: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin

  LConsulta := fCriaQuery;

  Try
    If (fCfgSis('CHQ_AS') = 'A') Then
    Begin
      LConsulta.SQL.Text := 'SELECT                                         '+
                            '  CTB_SEQDEP                                   '+
                            'FROM                                           '+
                            '  MOVBAN                                       '+
                            '  JOIN BANCHQ                                  '+
                            '    ON BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN   '+
                            'WHERE CTB_SEQDEP = :SEQDEP                     '+
                            '  AND CTB_CODEMP = :CODEMP                     '+
                            '  AND CHQ_CODBCO = :CODBCO                     '+
                            '  AND CHQ_NUMAGE = :NUMAGE                     '+
                            '  AND CHQ_CONCOR = :CONCOR                     '+
                            '  AND CHQ_NUMCHQ = :NUMCHQ                     '+
                            '  AND CHQ_CODCLI = :CODCLI                     '+
                            '  AND CTB_DTACON IS NOT NULL                   ';

      LConsulta.ParamByName('SEQDEP').AsString := ASeqDep;
      LConsulta.ParamByName('CODEMP').AsString := AEmpDep;
      LConsulta.ParamByName('CODBCO').AsString := ACodBco;
      LConsulta.ParamByName('NUMAGE').AsString := ANumAge;
      LConsulta.ParamByName('CONCOR').AsString := ACtaCor;
      LConsulta.ParamByName('NUMCHQ').AsString := ANumChq;
      LConsulta.ParamByName('CODCLI').AsString := ACodCli;

      LConsulta.Open;
    End
    Else
    Begin
      LConsulta.SQL.Text := 'SELECT                            '+
                            '  CTB_SEQDEP                      '+
                            'FROM                              '+
                            '  MOVBAN                          '+
                            'WHERE CTB_SEQDEP = :SEQDEP        '+
                            '  AND CTB_CODEMP = :CODEMP        '+
                            '  AND CTB_DTACON IS NOT NULL      ';

      LConsulta.ParamByName('SEQDEP').AsString := ASeqDep;
      LConsulta.ParamByName('CODEMP').AsString := AEmpDep;

      LConsulta.Open;
    End;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCancDepChequePreMod2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(qryConsDep) Then
    FreeAndNil(qryConsDep);

  pDesbloqueiaRegistro;

  If Assigned(qryConsulta) Then
    FreeAndNil(qryConsulta);

  FreeAndNil(qryCadBco);
end;

procedure TfrmCancDepChequePreMod2.FormCreate(Sender: TObject);
begin
  inherited;
  blnTransf := False;
  qryCadBco := fCriaQuery(Self);
  qryConBco := qryCadBco;
  qryConsulta := fCriaQuery(Self);
  dbgChequesDados.DataController.DataSource := dsConsulta;
end;

procedure TfrmCancDepChequePreMod2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_F5:     btnIniBus.Click;
    VK_F6:     btnLocProx.Click;
    VK_F7:     btnMarcarTodos.Click;
    VK_F8:     btnDesmTodos.Click;
    VK_F10:    btnConfirma.Click;
    VK_ESCAPE: btnSairBaixa.Click;
  end;
end;

procedure TfrmCancDepChequePreMod2.FormShow(Sender: TObject);
begin
  inherited;
  qryConsDep := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', Self);
end;

function TfrmCancDepChequePreMod2.fSelectChequePre: Boolean;
var
  strSeqDep: string;
  strLoja: string;
begin
  Result := True;
  pDesbloqueiaRegistro;

  pBuscaGrupoCheque(EdtCodBco.Text, EdtNumAge.Text, EdtConCor.Text, EdtNumChq.Text, strLoja, strSeqDep);

  FreeAndNil(fldGen);
  FreeAndNil(dspConsulta);
  FreeAndNil(cdsConsulta);

  dspConsulta := TUniDataSetProvider.Create(Self);
  cdsConsulta := TUniClientDataSet.Create(Self);
  dspConsulta.DataSet := qryConsulta;
  cdsConsulta.SetProvider(dspConsulta);
  cdsConsulta.OnFilterRecord := pFilterRecord;
  cdsConsulta.AfterScroll    := pAtualizaDados;
  fldGen := TAggregateField.Create(Self);

  With fldGen Do
  Begin
    Name          := 'cdsChequeTotChq';
    FieldName     := 'CHQ_TOTCHQ';
    DataSet       := cdsConsulta;
    Expression    := 'SUM(CHQ_VALCHQ)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  cdsConsulta.AggregatesActive := True;

  With qryConsulta Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add('SELECT  ');
    SQL.Add('  CONCAT(CHQ_CODCLI," - ",CLI_NOMCLI) AS CHQ_CODCLI, ');
    SQL.Add('  CONCAT(CHQ_CODPOR," - ",POR_NOMPOR) AS CHQ_CODPOR, ');

    SQL.Add('  CONCAT(SUBSTRING(CHQ_CODCTA,1,2),".",              ');
    SQL.Add('         SUBSTRING(CHQ_CODCTA,3,2),".",              ');
    SQL.Add('         SUBSTRING(CHQ_CODCTA,5,3)," - ",CTA_DESCTA) AS CHQ_CODCTA, ');

    SQL.Add('  IF (CHQ_CGCCPF = 1, CONCAT(CHQ_CGCCPF," - ",SUBSTRING(CHQ_C_G_C_,1,2),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,3,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,6,3),"/", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,9,4),"-", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,13,2)),   ');
    SQL.Add('                      CONCAT(CHQ_CGCCPF," - ",SUBSTRING(CHQ_C_G_C_,1,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,4,3),".", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,7,3),"/", ');
    SQL.Add('                                              SUBSTRING(CHQ_C_G_C_,10,2))) AS CHQ_C_G_C_,   ');

    SQL.Add('   CHQ_CODBCO, ');
    SQL.Add('   CHQ_NUMAGE, ');
    SQL.Add('   CHQ_CONCOR, ');
    SQL.Add('   CHQ_NUMCHQ, ');
    SQL.Add('   CHQ_NOMEMI, ');
    SQL.Add('   CHQ_ENDERE, ');
    SQL.Add('   CHQ_TELEMI, ');
    SQL.Add('   CHQ_CGCCPF, ');
    SQL.Add('   CHQ_C_G_C_, ');
    SQL.Add('   CHQ_DTACAD, ');
    SQL.Add('   CHQ_DTAVEN, ');
    SQL.Add('   CHQ_VALCHQ, ');
    SQL.Add('   CHQ_HIST01, ');
    SQL.Add('   CHQ_HIST02, ');
    SQL.Add('   CHQ_CTADEP, ');
    SQL.Add('   CHQ_DTADEP, ');
    SQL.Add('   CHQ_DOCDEP, ');
    SQL.Add('   CHQ_DTADEV, ');
    SQL.Add('   CHQ_MOTDEV, ');
    SQL.Add('   CHQ_DTARDP, ');
    SQL.Add('   CHQ_FORREP, ');
    SQL.Add('   CHQ_OBSREP, ');
    SQL.Add('   CHQ_DTAREP, ');
    SQL.Add('   CHQ_RESCAI, ');
    SQL.Add('   CHQ_CODEMP, ');
    SQL.Add('   CHQ_NUMNOT, ');
    SQL.Add('   CHQ_DTACUS, ');
    SQL.Add('   CHQ_PORCUS, ');
    SQL.Add('   CHQ_DOCUME, ');
    SQL.Add('   CHQ_INCCTR, ');
    SQL.Add('   CHQ_HISTOR, ');
    SQL.Add('   CHQ_DOCCUS, ');
    SQL.Add('   CHQ_LOTCUS, ');
    SQL.Add('   CHQ_PORDEB, ');
    SQL.Add('   CHQ_CTADEB, ');
    SQL.Add('   CHQ_MOTDV2, ');
    SQL.Add('   CHQ_DTADP2, ');
    SQL.Add('   CHQ_DTADV2, ');
    SQL.Add('   CHQ_SEQCOM, ');
    SQL.Add('   CHQ_DTATRA, ');
    SQL.Add('   CHQ_SEQCON, ');
    SQL.Add('   CHQ_EMPRCX, ');
    SQL.Add('   CHQ_DEVDEF, ');
    SQL.Add('   CHQ_CODVEN, ');
    SQL.Add('   CHQ_SEQTRF, ');
    SQL.Add('   CHQ_DUPDEV, ');
    SQL.Add('   CHQ_DUPDEP, ');
    SQL.Add('   CHQ_CTDPSV, ');
    SQL.Add('   CHQ_CTDBSV, ');
    SQL.Add('   CHQ_PRDBSV, ');
    SQL.Add('   CHQ_CDCTSV, ');
    SQL.Add('   CHQ_CDPRSV, ');
    SQL.Add('   CHQ_TELCHE, ');
    SQL.Add('   CHQ_TELNUM, ');
    SQL.Add('   CHQ_SEQDEP, ');
    SQL.Add('   CHQ_EMPDEP, ');
    SQL.Add('   CHQ_CODOPE, ');
    SQL.Add('   CHQ_CODCMC, ');
    SQL.Add('   CHQ_DEPORI, ');
    SQL.Add('   "D" AS CHQ_MARDES, ');

    SQL.Add('  CHQ_CODCLI AS CODCLI,  ');
    SQL.Add('  CHQ_CODPOR AS CODPOR,  ');
    SQL.Add('  CHQ_CODCTA AS CODCTA,  ');
    SQL.Add('  IF(CHQ_DEVDEF, "Sim", "Não") AS DEVDEF, ');

    SQL.Add('  SUBSTR(CHQ_DUPDEV,  1, 12) AS DUPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 14,  2) AS ESPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 17,  1) AS PARDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 19,  3) AS EMPDEV,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEV, 23,  8) AS CLIDEV,    ');

    SQL.Add('  SUBSTR(CHQ_DUPCTP,  1, 12) AS DUPCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 14,  1) AS PARCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 16,  3) AS EMPCTP,    ');
    SQL.Add('  SUBSTR(CHQ_DUPCTP, 20,  8) AS FORCTP,    ');

    SQL.Add('  SUBSTR(CHQ_DUPDEP,  1, 12) AS DUPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 14,  1) AS PARTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 18,  2) AS ESPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 21,  3) AS EMPTRF,    ');
    SQL.Add('  SUBSTR(CHQ_DUPDEP, 25,  8) AS CLITRF,    ');

    SQL.Add('  C.AUTOINCREM AS SEQGER ');

    SQL.Add('FROM CADCHQ C ');

    SQL.Add('       JOIN CADCLI ON CLI_CODCLI = CHQ_CODCLI        ');
    SQL.Add('  LEFT JOIN CADCTA ON CTA_CODCTA = CHQ_CODCTA        ');
    SQL.Add('  LEFT JOIN CADPOR ON POR_CODPOR = CHQ_CODPOR        ');
    SQL.Add('  WHERE ');
    SQL.Add('  CHQ_DTAREP IS NULL ');
    SQL.Add('  AND (CHQ_DTADEV IS NULL OR CHQ_DTADV2 IS NULL) ');
    SQL.Add('  AND (NOT ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL)))) ');
    SQL.Add('  AND CHQ_CODEMP = ' + QuotedStr(strLoja));

    if Trim(strSeqDep) <> '' then
    begin
      SQL.Add('  AND CHQ_SEQDEP = ' + QuotedStr(strSeqDep));
    end
    else
    begin
      SQL.Add('  AND CHQ_CODBCO = ' + QuotedStr(EdtCodBco.Text)      );
      SQL.Add('  AND CHQ_NUMAGE = ' + QuotedStr(EdtNumAge.Text)      );
      SQL.Add('  AND CHQ_CONCOR = ' + QuotedStr(EdtConCor.Text)      );
      SQL.Add('  AND CHQ_NUMCHQ = ' + QuotedStr(EdtNumChq.Text)      );
    end;
    Open;

    If IsEmpty Then
    begin
      Result := False;
    end
    else
    begin
      pSetaClient(qryConsulta);
      cdsConsulta.Open;
      (cdsConsulta.FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := ',0.00';
      if not cdsConsulta.IsEmpty then
      begin
        edtTotalCheques.Text := IntToStr(cdsConsulta.RecordCount);
        if not fEmptyStr(TAggregateField(cdsConsulta.FieldByName('CHQ_TOTCHQ')).Value) then
        begin
          edtValorTotal.Text := FormatFloat('#,##0.00',TAggregateField(cdsConsulta.FieldByName('CHQ_TOTCHQ')).Value);
        end
        else
        begin
          edtValorTotal.Text := '0,00';
        end;
      end
      else
      begin
        edtTotalCheques.Text := '0';
        edtValorTotal.Text := '0,00';
      end;

      pMarcaDesmarcaTodosCheques('M');
      pTravaCheques;
    end;


  End;
end;

function TfrmCancDepChequePreMod2.fUpdateChequePre: Boolean;
  Var
    qryUpdate: TUniQuery;
    repCadChq: TCadChqRepository;
begin
   Result := True;

  Try

    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE CADCHQ ');
      SQL.Add('    SET                    ');
      SQL.Add('        CHQ_DTADEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_DTADEP), ');
      SQL.Add('        CHQ_CTADEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_DEPORI), '); //NULL, ');
      SQL.Add('        CHQ_DOCDEP = NULL, ');
      SQL.Add('        CHQ_CODPOR = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_PRCORI), '); //NULL, ');
      SQL.Add('        CHQ_CODCTA = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_CTCORI), '); //NULL, ');


      If blnTransf Then
      Begin
        SQL.Add('      CHQ_DUPDEP = NULL, ');
        SQL.Add('      CHQ_INCCTR = "N",  ');
      End;

      SQL.Add('        CHQ_PORDEB = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_PRDORI), '); //NULL, ');
      SQL.Add('        CHQ_CTADEB = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_CTDORI), '); //NULL, ');
      SQL.Add('        CHQ_DTADP2 = NULL, ');
      SQL.Add('        CHQ_SEQDEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_SEQDEP), ');
      SQL.Add('        CHQ_EMPDEP = IF(CHQ_DTADP2 IS NULL, NULL, CHQ_EMPDEP)  ');

      SQL.Add('       ,CHQ_DTABA1 = IF(CHQ_DTABA2 IS NULL, NULL, CHQ_DTABA1), ');
      SQL.Add('        CHQ_SEQDP1 = IF(CHQ_DTABA2 IS NULL, NULL, CHQ_SEQDP1) ');

      SQL.Add('       ,CHQ_DTABA2 = NULL, ');
      SQL.Add('        CHQ_SEQDP2 = NULL ');

      SQL.Add('  WHERE CHQ_CODBCO = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CODBCO').AsString));
      SQL.Add('    AND CHQ_NUMAGE = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMAGE').AsString));
      SQL.Add('    AND CHQ_CONCOR = ' + QuotedStr(qryConsulta.FieldByName('CHQ_CONCOR').AsString));
      SQL.Add('    AND CHQ_NUMCHQ = ' + QuotedStr(qryConsulta.FieldByName('CHQ_NUMCHQ').AsString));
      ExecSQL;
    End;

    FreeAndNil(qryUpdate);

    repCadChq := TCadChqRepository.Create;
    {********************}
    {* GRAVAR NO LOGCHQ *}
    {*****************JU*}
    repCadChq.pGravaLog(qryConsulta.FieldByName('CHQ_CODBCO').AsString, qryConsulta.FieldByName('CHQ_NUMAGE').AsString,
                        qryConsulta.FieldByName('CHQ_CONCOR').AsString, qryConsulta.FieldByName('CHQ_NUMCHQ').AsString,
                        'CANCELAMENTO DE DEPÓSITO (frmCancDepChequePre.fUpdateChequePre)');
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryUpdate);
			pMensagensErro(E.Message,'[TfrmCancDepChequePre.fUpdateChequePre]');
      Result := False;
    End;
  End;

  FreeAndNil(repCadChq);
end;

function TfrmCancDepChequePreMod2.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodBco) Then
    Begin

      If fEmptyStr(edtCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtNumAge) Then
    Begin
      If fEmptyStr(edtNumAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Agência deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtConCor) Then
    Begin
      If fEmptyStr(edtConCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número da Conta Corrente deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtNumChq) Then
    Begin
      If fEmptyStr(edtNumChq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Cheque deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;


procedure TfrmCancDepChequePreMod2.pCancelaDeposito;
  Var
    frmDigPortador : TfrmDigPortador;
    strEmpSemAcesso: String;
begin
  If blnTransf And fDuplicataQuitada(qryConsulta.FieldByName('DUPTRF').AsString,
                                     qryConsulta.FieldByName('ESPTRF').AsString,
                                     qryConsulta.FieldByName('EMPTRF').AsString,
                                     qryConsulta.FieldByName('PARTRF').AsString,
                                     qryConsulta.FieldByName('CLITRF').AsString) Then
  Begin
    fMensagem('Informação','Cancelamento não permitido.' + #13#10 + 'Já houve baixa da duplicata relativa ao cheque!',['&O K']);
    blnCanceladoSucesso := False;
    Exit;
  End;

  //FECHAMENTO
  If (Not qryConsulta.FieldByName('CHQ_DTADP2').IsNull) Then
  Begin
    if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, qryConsulta.FieldByName('CHQ_DTADP2').AsDateTime) then
    begin
      blnCanceladoSucesso := False;
      pDesbloqueiaRegistro;
      Exit;
    end;
  End
  Else
  If (Not qryConsulta.FieldByName('CHQ_DTADEP').IsNull) Then
  Begin
    if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, qryConsulta.FieldByName('CHQ_DTADEP').AsDateTime) then
    begin
      blnCanceladoSucesso := False;
      pDesbloqueiaRegistro;
      Exit;
    end;
  End;

  pSetaVariaveis;

  If (Not blnTransf) And (fEmptyStr(strPorDeb) Or fEmptyStr(fRetNomPortador(strPorDeb))) Then
  Begin

    fMensagem('', 'Portador para débito em branco!', ['&Ok']);
    pCriarFormularios(TfrmDigPortador, frmDigPortador);
    frmDigPortador.Caption := 'Informe o Portador para o débito';
    frmDigPortador.ShowModal;

    If frmDigPortador.blnConfirma Then
    Begin
      strPorDeb := frmDigPortador.strCodPor;
      FreeAndNil(frmDigPortador);

      {*REQ*145940**********RP*}
      If Not fEmpresasTemAcessoPortador(strPorDeb,
                                        cdsConsulta,
                                        'CHQ_CODEMP',
                                        strEmpSemAcesso,
                                        'CHQ_MARDES = ''M''') Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do Portador informado: '+ strEmpSemAcesso +'. Operação abortada!', ['&OK']);
        Exit;
      End;
    End Else
    Begin
      FreeAndNil(frmDigPortador);
      Exit;
    End;

  End;

  If not fCancelaDeposito Then
  Begin
    blnCanceladoSucesso := False;
  End;

end;

procedure TfrmCancDepChequePreMod2.pCancelaDepositoEmLote;
begin
  blnCanceladoSucesso := True;
  cdsConsulta.First;
  qryConsulta.First;
  cdsConsulta.DisableControls;
  while not cdsConsulta.Eof do
  begin
    if cdsConsulta.FieldByName('CHQ_MARDES').AsString = 'M' then
    begin
      pCancelaDeposito;
    end;
    cdsConsulta.Next;
    qryConsulta.Next;
  end;

  cdsConsulta.EnableControls;

  if blnCanceladoSucesso then
  begin
    pEsconde(False);
    fMensagem('Informação','Cancelamento de Depósito de Cheque executado com sucesso !',['&O K']);
  end
  else
  begin
    fMensagem('INFORMAÇÃO','Existem Cheque(s) não encontrado, não depositado ou rotina cancelada !',['&OK']);
  end;

  If Assigned(cdsConsulta) Then
  begin
    cdsConsulta.Close;
  end;
end;

procedure TfrmCancDepChequePreMod2.pCarregaBanco;
begin
  pPesquisaCadBco(qryCadBco, qryConBco, edtCodBco.Text);
  edtNomBco.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
end;

procedure TfrmCancDepChequePreMod2.pConsultaChequePre;
begin
  If Not fConsultaDeposito Then
    pEsconde
  Else
    pMostra;
end;

procedure TfrmCancDepChequePreMod2.pDesbloqueiaRegistro;
begin
  if Assigned(cdsConsulta) and (cdsConsulta.Active) and (cdsConsulta.RecordCount > 0) then
  begin
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      fLock_Unlock('CADCHQ' + cdsConsulta.FieldByName('SEQGER').AsString, False);
      cdsConsulta.Next;
    end;
  end;
end;


procedure TfrmCancDepChequePreMod2.pEsconde(blnMens: Boolean);
begin
  If blnMens Then
  Begin
    pLimpaTela(false);
    fMensagem('INFORMAÇÃO','Cheque não encontrado ou não depositado !',['&OK']);
  End;
  If Not blnMens Then
    pLimpaTela;

  pSetFocus(EdtCodBco);
end;

procedure TfrmCancDepChequePreMod2.pFilterRecord(DataSet: TDataSet;
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

procedure TfrmCancDepChequePreMod2.pLimpaTela(blnLimpaFiltro: Boolean = True);
begin
  pDesbloqueiaRegistro;
  qryConsulta.Close;
  qryConsulta.Open;
  pCarregaBanco;
  If blnLimpaFiltro Then
  Begin
    EdtCodBco.Clear;
    EdtNumAge.Clear;
    EdtConCor.Clear;
    EdtNumChq.Clear;
    edtNomBco.Clear;
  End;
  edtValorTotal.Clear;
  edtTotalCheques.Clear;
  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;
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
end;

procedure TfrmCancDepChequePreMod2.pMarcaDesmarcaCheque;
var
  crrValorTotalCheqMarcado: Currency;
  intTotalCheqMarcado: integer;
begin
  cdsConsulta.Edit;
  if cdsConsulta.FieldByName('CHQ_MARDES').AsString = 'M' then
  begin
    cdsConsulta.FieldByName('CHQ_MARDES').AsString := 'D';

    crrValorTotalCheqMarcado := StrToCurrDef(edtTotalSelecionado.Text, 0);
    crrValorTotalCheqMarcado := crrValorTotalCheqMarcado - cdsConsulta.FieldByName('CHQ_VALCHQ').AsCurrency;
    edtTotalSelecionado.Text := FormatCurr('#,##0.00', crrValorTotalCheqMarcado);

    intTotalCheqMarcado := StrToIntDef(edtChqSelecionados.Text, 0);
    Dec(intTotalCheqMarcado);
    edtChqSelecionados.Text := IntToStr(intTotalCheqMarcado);
  end
  else
  begin
    if EstaConciliado(cdsConsulta.FieldByName('CHQ_DOCDEP').AsString, 'CADCHQ') then
    begin
      fMensagem('', 'Não é possível cancelar esse cheque, pois o mesmo está conciliado. ' +
                    'Para ser possível cancelá-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
      Exit;
    end
    Else If fMovimentacaoBancariaConciliada(cdsConsulta.FieldByName('CHQ_SEQDEP').AsString,
                                            cdsConsulta.FieldByName('CHQ_EMPDEP').AsString,
                                            cdsConsulta.FieldByName('CHQ_CODBCO').AsString,
                                            cdsConsulta.FieldByName('CHQ_NUMAGE').AsString,
                                            cdsConsulta.FieldByName('CHQ_CONCOR').AsString,
                                            cdsConsulta.FieldByName('CHQ_NUMCHQ').AsString,
                                            cdsConsulta.FieldByName('CODCLI').AsString) Then



    Begin
      fMensagem('', 'Não é possível cancelar esse cheque, pois o mesmo está conciliado. ' +
                    'Para ser possível cancelá-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
      Exit;
    End;

    cdsConsulta.FieldByName('CHQ_MARDES').AsString := 'M';

    crrValorTotalCheqMarcado := StrToCurrDef(edtTotalSelecionado.Text, 0);
    crrValorTotalCheqMarcado := crrValorTotalCheqMarcado + cdsConsulta.FieldByName('CHQ_VALCHQ').AsCurrency;
    edtTotalSelecionado.Text := FormatCurr('#,##0.00', crrValorTotalCheqMarcado);

    intTotalCheqMarcado := StrToIntDef(edtChqSelecionados.Text, 0);
    Inc(intTotalCheqMarcado);
    edtChqSelecionados.Text := IntToStr(intTotalCheqMarcado);
  end;
  cdsConsulta.Post;
  dbgChequesDados.NavigatorButtons.Next.Click;
end;

procedure TfrmCancDepChequePreMod2.pMarcaDesmarcaTodosCheques(
  strMarcaDesmarca: string);
var
  crrValorTotalCheqMarcado: Currency;
  intTotalCheqMarcado: integer;
begin
  cdsConsulta.First;
  while not cdsConsulta.Eof do
  begin
    if EstaConciliado(cdsConsulta.FieldByName('CHQ_DOCDEP').AsString, 'CADCHQ') then
    begin
      fMensagem('', 'Não será possível marcar todos os cheques, pois existe um ou mais cheques conciliados. ' +
                    'Para ser possível cancelá-los, os mesmos devem ser desconciliados. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
      Exit;
    end
    Else If fMovimentacaoBancariaConciliada(cdsConsulta.FieldByName('CHQ_SEQDEP').AsString,
                                            cdsConsulta.FieldByName('CHQ_EMPDEP').AsString,
                                            cdsConsulta.FieldByName('CHQ_CODBCO').AsString,
                                            cdsConsulta.FieldByName('CHQ_NUMAGE').AsString,
                                            cdsConsulta.FieldByName('CHQ_CONCOR').AsString,
                                            cdsConsulta.FieldByName('CHQ_NUMCHQ').AsString,
                                            cdsConsulta.FieldByName('CODCLI').AsString) Then



    Begin
      fMensagem('', 'Não será possível marcar todos os cheques, pois existe um ou mais cheques conciliados. ' +
                    'Para ser possível cancelá-los, os mesmos devem ser desconciliados. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
      Exit;
    End;

    cdsConsulta.Next;
  end;

  cdsConsulta.First;
  cdsConsulta.DisableControls;
  crrValorTotalCheqMarcado := 0;
  intTotalCheqMarcado := 0;
  while not cdsConsulta.Eof do
  begin
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('CHQ_MARDES').AsString := strMarcaDesmarca;
    cdsConsulta.Post;
    if cdsConsulta.FieldByName('CHQ_MARDES').AsString = 'M' then
    begin
      crrValorTotalCheqMarcado := crrValorTotalCheqMarcado + cdsConsulta.FieldByName('CHQ_VALCHQ').AsCurrency;
      Inc(intTotalCheqMarcado);
    end
    else
    begin
      crrValorTotalCheqMarcado := 0;
      intTotalCheqMarcado := 0;
    end;
    cdsConsulta.Next;
  end;
  cdsConsulta.First;
  cdsConsulta.EnableControls;
  edtChqSelecionados.Text := IntToStr(intTotalCheqMarcado);
  edtTotalSelecionado.Text := FormatCurr('#,##0.00', crrValorTotalCheqMarcado);
end;

procedure TfrmCancDepChequePreMod2.pMostra;
begin
  dsConsulta.DataSet := cdsConsulta;

  (qryConsulta.FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
  blnTransf := Not qryConsulta.FieldByName('CHQ_DUPDEP').IsNull;
end;

procedure TfrmCancDepChequePreMod2.pSetaVariaveis;
begin
  strCodPor := qryConsulta.FieldByName('CODPOR').AsString;
  strCodCta := qryConsulta.FieldByName('CODCTA').AsString;
  strPorDeb := qryConsulta.FieldByName('CHQ_PORDEB').AsString;
  strCtaDeb := qryConsulta.FieldByName('CHQ_CTADEB').AsString;
  If qryConsulta.FieldByName('CHQ_DTADEP').AsDateTime > VS_Date Then
    dtaDtaLan := qryConsulta.FieldByName('CHQ_DTADEP').AsDateTime
  Else
    dtaDtaLan := VS_Date;
  fltValChq := qryConsulta.FieldByName('CHQ_VALCHQ').AsFloat;
  strHist01 := 'CANCEL. DO DEPOSITO CHEQUE No ' + qryConsulta.FieldByName('CHQ_NUMCHQ').AsString;
  strNumChq := qryConsulta.FieldByName('CHQ_NUMCHQ').AsString;
  strEmpChq := qryConsulta.FieldByName('CHQ_CODEMP').AsString;
  strCodCli := qryConsulta.FieldByName('CODCLI').AsString;
  strCodBco := qryConsulta.FieldByName('CHQ_CODBCO').AsString;
  strNumAge := qryConsulta.FieldByName('CHQ_NUMAGE').AsString;
  strConCor := qryConsulta.FieldByName('CHQ_CONCOR').AsString;
  strNomEmi := qryConsulta.FieldByName('CHQ_NOMEMI').AsString;
  strHistc1 := qryConsulta.FieldByName('CHQ_HIST01').AsString;
  strHistc2 := qryConsulta.FieldByName('CHQ_HIST02').AsString;
end;

procedure TfrmCancDepChequePreMod2.pTravaCheques;
begin
  if Assigned(cdsConsulta) and (cdsConsulta.RecordCount > 0) then
  begin
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      If Not fLock_Unlock('CADCHQ' + cdsConsulta.FieldByName('SEQGER').AsString, True, False) Then
      Begin
        pLimpaTela(False);
        fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + cdsConsulta.FieldByName('SEQGER').AsString), ['&Ok']);
        cdsConsulta.Close;
        Break;
      End;
      cdsConsulta.Next;
    end;
  end;
end;

procedure TfrmCancDepChequePreMod2.pApagaCadRecDepDev(strNumDup, strEspDup, strCodEmp, strParcel, strCodCli: String);
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE * FROM ');
    Add('  CADREC ');
    Add('WHERE');
    Add('  CTR_NUMDUP = :NUMDUP AND ');
    Add('  CTR_ESPDOC = :ESPDOC AND ');
    Add('  CTR_CODEMP = :CODEMP AND ');
    Add('  CTR_CODCLI = :CODCLI AND ');
    Add('  CTR_PARCEL = :PARCEL     ');

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    While Not Eof Do
    Begin
      fApagaDuplicataContasReceber(qryGen, Self.Name);
      Next;
    End;

  End;
  FreeAndNil(qryGen);
End;

procedure TfrmCancDepChequePreMod2.pAtualizaDados(DataSet: TDataSet);
begin
  if not cdsConsulta.ControlsDisabled then
  begin
    edtBanco.Text       := DataSet.FieldByName('CHQ_CODBCO').AsString;
    edtNome.Text        := fBuscaNomeBanco(DataSet.FieldByName('CHQ_CODBCO').AsString);
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
end;

procedure TfrmCancDepChequePreMod2.pBuscaGrupoCheque(strCodBanco, strAgencia,
  strCtaCorrente, strNumCheque: string; var strLoja, strGrupo: string);
var
  qryGrupoCheque: TUniQuery;
begin
  qryGrupoCheque := fCriaQuery(Self);
  try
    qryGrupoCheque.SQL.Add('SELECT CHQ_SEQDEP, CHQ_CODEMP FROM CADCHQ');
    qryGrupoCheque.SQL.Add('WHERE CHQ_CODBCO = :CODBCO AND CHQ_NUMAGE = :NUMAGE');
    qryGrupoCheque.SQL.Add('AND CHQ_CONCOR = :CONCOR AND CHQ_NUMCHQ = :NUMCHQ');
    qryGrupoCheque.ParamByName('CODBCO').AsString := Trim(strCodBanco);
    qryGrupoCheque.ParamByName('NUMAGE').AsString := Trim(strAgencia);
    qryGrupoCheque.ParamByName('CONCOR').AsString := Trim(strCtaCorrente);
    qryGrupoCheque.ParamByName('NUMCHQ').AsString := Trim(strNumCheque);
    qryGrupoCheque.Open;
    strLoja  := qryGrupoCheque.FieldByName('CHQ_CODEMP').AsString;
    strGrupo := qryGrupoCheque.FieldByName('CHQ_SEQDEP').AsString;
  finally
    FreeAndNil(qryGrupoCheque);
  end;
end;

procedure TfrmCancDepChequePreMod2.pBuscaIni;
begin
  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;
    pSetFocus(dbgCheques);

    If Not cdsConsulta.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques para serem buscados!', ['&Ok']);
    End;

    pSetFocus(dbgCheques);
  End;
end;

procedure TfrmCancDepChequePreMod2.pBuscaProx;
begin
 If (Not cdsConsulta.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsConsulta.FindNext Then
      fMensagem('ATENÇÃO!', 'Busca concluída!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

  pSetFocus(dbgCheques);
end;

end.
