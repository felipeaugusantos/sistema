unit untEntConferPreNotaWMSDevolucao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, Uni,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxProgressBar,
  cxDataStorage, cxEdit, cxNavigator, untZClient, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  MaskEditFocus, untFuncFat, cxCheckBox, StrUtils, UniClientDataSet,
  cxCurrencyEdit, untTControlaReservaDevolucaoVenda,
  untTDistribuicaoConferencia;

type

  TTipoBaixaDivergenciasWMS = (tbdDevolucao, tbdLiberacaoEnderecamento);
  TopcDocEmi = (opcNF, opcTE);

  TfrmEntConferPreNotaWMSDevolucao = class(TfrmPai)
    cxgDadosDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgDadosLevel: TcxGridLevel;
    cxgDados: TcxGridCitel;
    pnlFiltros: TPanel;
    cxgDadosDBTableViewCitelQTDNFE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelQTDCON: TcxGridDBColumn;
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    btnAbreDados: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgDadosDBTableViewCitelMARCA_: TcxGridDBColumn;
    btnEmitirDevolucao: TBitBtnLocked;
    cxgDadosDBTableViewCitelCODITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelDESITE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelQTDDEV: TcxGridDBColumn;
    cxgDadosDBTableViewCitelIDEDIG: TcxGridDBColumn;
    cxgDadosDBTableViewCitelDTAREC: TcxGridDBColumn;
    cxgDadosDBTableViewCitelNOMMOT: TcxGridDBColumn;
    cxgDadosDBTableViewCitelPLACA_: TcxGridDBColumn;
    cxgDadosDBTableViewCitelIDENTI: TcxGridDBColumn;
    cxgDadosLevel1: TcxGridLevel;
    cxgDadosDBTableViewItens: TcxGridDBTableViewCitel;
    cxgDadosDBTableViewItensNUMDOC: TcxGridDBColumn;
    cxgDadosDBTableViewItensESPDOC: TcxGridDBColumn;
    cxgDadosDBTableViewItensSERIE_: TcxGridDBColumn;
    cxgDadosDBTableViewItensFORNEC: TcxGridDBColumn;
    cxgDadosDBTableViewItensUNITAR: TcxGridDBColumn;
    cxgDadosDBTableViewItensQTDENV: TcxGridDBColumn;
    cxgDadosDBTableViewItensQTDITE: TcxGridDBColumn;
    btnLiberarEnderecamento: TBitBtnLocked;
    cxgDadosDBTableViewItensCLAFIS: TcxGridDBColumn;
    cxgDadosDBTableViewItensNATOPE: TcxGridDBColumn;
    cxgDadosDBTableViewCitelQTDLIB: TcxGridDBColumn;
    cxgDadosDBTableViewItensSELEC_: TcxGridDBColumn;
    cxgDadosQTDLDE: TcxGridDBColumn;
    cxgDadosQTDCON: TcxGridDBColumn;
    cxgDadosItemQTDLDE: TcxGridDBColumn;
    pnlFilterFor: TPanel;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAbreDadosClick(Sender: TObject);
    procedure cxgDadosDBTableViewCitelMARCA_PropertiesChange(Sender: TObject);
    procedure btnEmitirDevolucaoClick(Sender: TObject);
    procedure cxgDadosDBTableViewItensEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure btnLiberarEnderecamentoClick(Sender: TObject);
    procedure cxgDadosDBTableViewCitelCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDadosDBTableViewItensCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDadosDBTableViewCitelQTDLIBPropertiesChange(Sender: TObject);
    procedure cxgDadosDBTableViewItensSELEC_PropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
  private
    FblnCOFTRA: Boolean;
    stlDocDev : TStringList;
    cdsDados : TZClient;
    cdsItens : TZClient;
    FstrAutIncExterno: String;
    FBlnChamadaExterna: Boolean;
    blnSemWms: Boolean;
    function fExisteQuantidadeALiberarInformada: boolean;
    procedure cdsDadosAfterPost(DataSet: TDataSet);

    function fGetQtdEnv(var strErro: string; blnValidaQtd: Boolean = False): Double;
    procedure pDistribuiQtdADevolver;
    procedure pZeraQtdADevolver;
    procedure pZeraQtdADevolverItem;
    procedure pSetQtdADevolverItem;
    procedure pDesmarcaItens;
    procedure cdsItensBeforePost(DataSet: TDataSet);
    function fVerificaQuantidadesDevolucao(var strErro: String): Boolean;
    procedure pDefineNotasADevolver(var AList: TStringList);
    function fVaiEmitirNF: Boolean;
    procedure pTrataChamadaExterna;
    procedure setAutIncExterno(const Value: String);
    function fPrecisaConfirmarEspelho(AStrNumDoc, AStrEspDoc, AStrCodFor,
      AStrCodEmp, AStrSerie: String): Boolean;
    function fRetornaDataAGEREC(strAutIncGERELE: String ): String;
    function fGetSQLDifSemWMS: String;
    function fGetSQLEntSemWMS: String;
    function fConfirmaLiberacaoEnderecamentoSemWms(
      cxProgressBar: TcxProgressBar): Boolean;

    Const
      strSqlQtdConf = 'IFNULL((SELECT DIG_QTDITE FROM DIGELE WHERE DIG_IDEDIG = ARC_IDEDIG AND DIG_CODITE = AIT_CODITE AND DIG_CODEMP = ARC_CODEMP), 0.00)';

    function fGetSQLDiferencas : String;
    function fGetSQLEntradas : String;
    procedure pAbreDados;
    procedure pOnChangeMarca(Sender: TField);
    procedure pOnChangeSelec(Sender: TField);
    function fTemRegistroMarcado: Boolean;
    function fConfirma( enuTipoBaixa : TTipoBaixaDivergenciasWMS ) : Boolean;
    function fConfirmaDevolucao(cxProgressBar : TcxProgressBar) : Boolean;
    function fConfirmaLiberacaoEnderecamento(cxProgressBar: TcxProgressBar): Boolean;
    procedure pCarregarCliente(strCodCli: String; var fatVenda : TFatVenda);
    procedure pCarregaDadosFornecedor(strCodFor: String; var fatVenda : TFatVenda);
    function fIncluiItens(var fatVenda: TFatVenda): Boolean;
    function fGetItem(var qryGenIte: TUniQuery; strCodIte: String): Boolean;
    function fGetCFOP: String;
    function fLiberaReservaDeEstoque(const AutIncVen: String): Boolean;
    function fGetQtdNotas: Integer;
    procedure pSelecionaNota;
  protected
    arrLinFor: TConsultasArray;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean = False): Boolean; Override;
  published
    property StrAutIncExterno: String read FstrAutIncExterno write setAutIncExterno;
  end;

implementation

{$R *.dfm}

uses untFuncoesConsulta, untFuncoesSimples, untConsultas, untFuncFatTypes,
  untGravando, untFatDadosFiscais, untFuncoes, untDuplicatas,
  untFatDigMensagemOrc,
  untTRestauraDel;

{ TfrmEntConferPreNotaWMSDevolucao }

procedure TfrmEntConferPreNotaWMSDevolucao.btnAbreDadosClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos Then
    pAbreDados;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.btnEmitirDevolucaoClick(
  Sender: TObject);
var
  strErro: string;
begin
  inherited;
  if not fTemRegistroMarcado then
  begin
    fMensagem('', 'Necessário selecionar pelo menos uma nota para realizar a devolução do item marcado!', ['&Ok']);
    Exit;
  end;

  if not fVerificaQuantidadesDevolucao(strErro) Then
  Begin
    fMensagem('', strErro, ['&Ok']);
    Exit;
  End;

  if fConfirma(tbdDevolucao) Then
  Begin
    If FBlnChamadaExterna Then
      Close
    Else
      pAbreDados;
  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.btnLiberarEnderecamentoClick(
  Sender: TObject);
begin
  inherited;
  if fConfirma(tbdLiberacaoEnderecamento) Then
  begin
    pMensagemOk('Itens liberados com sucesso!');
    pAbreDados;
  end;
end;

function TfrmEntConferPreNotaWMSDevolucao.fVerificaQuantidadesDevolucao(var strErro: String) : Boolean;
var
  cdsCopy : TZClient;
Begin
  Try
    Result := False;

    cdsCopy := TZClient.Create(Nil);
    cdsCopy.CloneCursor(cdsItens, true,true);

    cdsDados.DisableControls;
    cdsDados.Filter := 'MARCA_ = ' + QuotedStr('S');
    cdsDados.Filtered := True;
    cdsDados.First;
    While not cdsDados.Eof Do
    Begin
      cdsCopy.DisableControls;
      cdsCopy.Filter := 'SELEC_ = ' + QuotedStr('S') + ' AND DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
      cdsCopy.Filtered := True;

      if cdsCopy.RecordCount > 0 then
      Begin
        Result := cdsDados.FieldByName('QTDDEV').AsFloat >= fGetQtdEnv(strErro, True);
        if strErro <> '' then
          Result := False;
      End
       else Result := True;


      If not Result Then
        Break;

      If Not FBlnChamadaExterna Then
      Begin
        cdsCopy.Filtered := False;
        cdsCopy.Filter := '';
      End;
      cdsCopy.EnableControls;
      cdsDados.Next;
    End;

  Finally
    FreeAndNil(cdsCopy);

    cdsDados.Filtered := False;
    cdsDados.Filter := '';
    cdsDados.First;
    cdsDados.EnableControls;

  End;
End;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewCitelCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Item = cxgDadosDBTableViewCitelQTDLIB then
  begin
    ACanvas.Brush.Color := $00CCFFFF;
    ACanvas.Font.Color  := clWindowText;
  end;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewCitelMARCA_PropertiesChange(
  Sender: TObject);
Var
  campo: TcxCheckBox;
Begin
  inherited;
  campo :=  TcxCheckBox(Sender);
  if campo.Checked and fExisteQuantidadeALiberarInformada then
  begin
    campo.checked := False;
    fMensagem('', 'Existem itens com a quantidade a liberar para endereçamento informada, não é possível marcar para efetuar devolução!', ['&OK']);
    exit;
  end;

  cdsDados.CheckBrowseMode;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewCitelQTDLIBPropertiesChange(
  Sender: TObject);
var
  cdsCopy : TZClient;
  campo: TcxCurrencyEdit;
Begin
  inherited;
  campo :=  TcxCurrencyEdit(Sender);

  if campo.value > cdsDados.FieldByName('QTDDEV').AsFloat then
  begin
    campo.Value := 0;
    fMensagem('', 'A quantidade a liberar, não pode ser maior que a quantidade a devolver!', ['&OK']);
    exit;
  end;

  cdsCopy := TZClient.Create(Nil);
  try
    cdsCopy.CloneCursor(cdsDados, true,true);

    if campo.Value > 0 then
    begin
      If cdsCopy.Locate('MARCA_', 'S', []) Then
      Begin
        campo.Value := 0;
        fMensagem('', 'Existem itens marcados para efetuar devolução, não é possível informar a quantidade a liberar para endereçamento!', ['&OK']);
      End;
    end;

  finally
    FreeAndNil(cdsCopy);
  end;

end;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewItensCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  if AViewInfo.Item = cxgDadosDBTableViewItensQTDENV then
  begin
    ACanvas.Brush.Color := $00CCFFFF;
    ACanvas.Font.Color  := clWindowText;
  end;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewItensEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := cdsDados.FieldByName('MARCA_').AsString = 'S';
end;

procedure TfrmEntConferPreNotaWMSDevolucao.cxgDadosDBTableViewItensSELEC_PropertiesChange(
  Sender: TObject);
begin
  inherited;
  cdsItens.CheckBrowseMode;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.edtFornecedorExit(Sender: TObject);
  Var
    arrForNot : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrForNot, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmEntConferPreNotaWMSDevolucao.edtFornecedorKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrForNot : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmEntConferPreNotaWMSDevolucao.fGetSQLDiferencas: String;

begin
  Result := '';
  Result := Result + ' SELECT * FROM (              ';
  Result := Result + ' SELECT AIT_CODITE AS CODITE, ';
  Result := Result + '        ITE_DESITE AS DESITE, ';
  Result := Result + '        AIT_QTDTOT AS QTDNFE, ';
  Result := Result + strSqlQtdConf + ' AS QTDCON,   ';
  Result := Result + '        ( IFNULL(AIT_QTDTOT,0) - ' + strSqlQtdConf + ' - IFNULL(AIT_QTDDEV,0) - IFNULL(AIT_DIVLIB,0) ) AS QTDDEV, ';
  Result := Result + '        ARC_IDEDIG AS IDEDIG, ';
  Result := Result + '        ARC_DTAREC AS DTAREC, ';
  Result := Result + '        ARC_NOMMOT AS NOMMOT, ';
  Result := Result + '        ARC_PLACA_ AS PLACA_, ';
  Result := Result + '        ARC_IDENTI AS IDENTI, ';
  Result := Result + '        "N" AS MARCA_,        ';
  Result := Result + '        AGEITE.AUTOINCREM AS INCAIT,  ';
  Result := Result + '        0.00 AS QTDLIB,       ';
  Result := Result + '        CONCAT(R.AUTOINCREM,"_", AIT_CODITE) AS MASTER_KEY  ';
  Result := Result + ' FROM AGEITE                  ';
  Result := Result + '   INNER JOIN AGEREC R ON R.AUTOINCREM = AIT_SEQGER ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = AIT_CODITE ';
  Result := Result + '   INNER JOIN AGEDOC G ON G.ADC_SEQGER = R.AUTOINCREM ';

  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
      Result := Result + '   LEFT JOIN ESPDET AS ED ON ED.DET_DOCDEV = G.ADC_NUMDOC     ';
      Result := Result + '                           AND ED.DET_ESPDEV = G.ADC_ESPDOC   ';
      Result := Result + '                           AND ED.DET_EMPDEV = G.ADC_CODEMP   ';
      Result := Result + '                           AND ED.DET_CODITE = AIT_CODITE     ';
      Result := Result + '   LEFT JOIN ESPGER AS EG ON ED.DET_SEQGER = EG.AUTOINCREM    ';
      Result := Result + '                           AND GER_MOVGER IS NULL             ';
      Result := Result + '                           AND EG.GER_CODFOR = G.ADC_CODFOR   ';
   End;

  Result := Result + ' WHERE R.ARC_CODEMP = :CODEMP ';
  If fConferenciaAntesDoPlanoDeRecebimento Then
    Result := Result + '   AND R.ARC_STATUS = "EP"  '
  Else
    Result := Result + '   AND R.ARC_STATUS = "CN"  ';

  Result := Result + '   AND ( IFNULL(AIT_QTDTOT,0) - ' + strSqlQtdConf + ' - IFNULL(AIT_QTDDEV,0) - IFNULL(AIT_DIVLIB,0) ';

  If fCfgSis('OUSAFO', varString) = '2' Then
    Result := Result + '  - IFNULL(ED.DET_QTDITE,0)  ';

  Result := Result + '   ) > 0 ';

  if not fEmptyDate(mskDtaIni.Text) Then
    Result := Result + ' AND ARC_DTAREC BETWEEN :DTAINI AND :DTAFIN ';

  Result := Result + ' HAVING QTDCON < QTDNFE ';
  Result := Result + ' ORDER BY MASTER_KEY ) TMP ';
  Result := Result + ' GROUP BY MASTER_KEY ';

end;

function TfrmEntConferPreNotaWMSDevolucao.fGetSQLEntradas: String;
begin
  Result := '';
  Result := Result + ' SELECT AIT_CODITE AS CODITE, ';
  Result := Result + '        ITE_DESITE AS DESITE, ';
  Result := Result + '        AIT_QTDTOT AS QTDNFE, ';
  Result := Result + strSqlQtdConf + ' AS QTDCON,   ';
  Result := Result + '        AIT_QTDTOT - ' + strSqlQtdConf + '  - IFNULL(AIT_QTDDEV,0) AS QTDDEV, ';
  Result := Result + '        ARC_IDEDIG AS IDEDIG, ';
  Result := Result + '        ARC_DTAREC AS DTAREC, ';
  Result := Result + '        ARC_NOMMOT AS NOMMOT, ';
  Result := Result + '        ARC_PLACA_ AS PLACA_, ';
  Result := Result + '        ARC_IDENTI AS IDENTI, ';
  Result := Result + '        "N" AS MARCA_,        ';
  Result := Result + '        CONCAT(R.AUTOINCREM,"_", AIT_CODITE) AS DETAIL_KEY,  ';
  Result := Result + '        ADC_NUMDOC AS NUMDOC, ';
  Result := Result + '        ADC_ESPDOC AS ESPDOC, ';
  Result := Result + '        ADC_SERIE_ AS SERIE_, ';
  Result := Result + '        ADC_CODEMP AS EMPENT, ';
  Result := Result + '        ADC_CODFOR AS CODFOR, ';
  Result := Result + '        FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '        CONCAT(ADC_CODFOR, "-", FOR_NOMFOR) AS FORNEC, ';
  Result := Result + '        D.DET_UNITAR AS UNITAR, ';
  Result := Result + '        D.DET_QTDITE AS QTDITE, ';
  Result := Result + '        D.DET_TOTITE AS TOTITE, ';
  Result := Result + '        D.DET_DESACE AS DESACE, ';
  Result := Result + '        D.DET_VLRCON AS VLRCON, ';
  Result := Result + '        D.DET_ALQIPI AS ALQIPI, ';
  Result := Result + '        0.00 AS QTDENV,       ';
  Result := Result + '        CONCAT(R.AUTOINCREM,D.AUTOINCREM) AS PRIMARY_KEY, ';
  Result := Result + '        D.DET_SEQGER AS SEQGER,';
  Result := Result + '        D.AUTOINCREM AS SEQDET,';
  Result := Result + '        R.AUTOINCREM AS RECINC,';
  Result := Result + '        CADFIS.FIS_ACESSO,';
  Result := Result + '        T.AUTOINCREM AS INCAIT,';
  Result := Result + '        D.DET_CLAFIS AS CLAFIS,';
  Result := Result + '        CFO_NATOPE   AS NATOPE,';
  Result := Result + '        "N"          AS SELEC_ ';
  Result := Result + ' FROM AGEITE T                 ';
  Result := Result + '   INNER JOIN AGEREC R ON R.AUTOINCREM = AIT_SEQGER ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = AIT_CODITE ';
  Result := Result + '   INNER JOIN AGEDOC G ON G.ADC_SEQGER = R.AUTOINCREM ';
  Result := Result + '   INNER JOIN MOVDET D ON D.DET_NUMDOC = ADC_NUMDOC ';
  Result := Result + '                      AND D.DET_ESPDOC = ADC_ESPDOC ';
  Result := Result + '                      AND D.DET_SERIE_ = ADC_SERIE_ ';
  Result := Result + '                      AND D.DET_CODEMP = ADC_CODEMP ';
  Result := Result + '                      AND D.DET_CODFOR = ADC_CODFOR ';
  Result := Result + '                      AND D.DET_CODITE = AIT_CODITE ';

  Result := Result + '  LEFT JOIN CADFIS ON DET_NUMDOC = FIS_NUMDOC               ';
  Result := Result + '                  AND DET_ESPDOC = FIS_ESPDOC               ';
  Result := Result + '                  AND DET_CODEMP = FIS_CODEMP               ';
  Result := Result + '                  AND DET_CODFOR = FIS_FORCLI               ';
  Result := Result + '                  AND IFNULL(DET_SERIE_, "") = FIS_SERIE_   ';
  Result := Result + '                  AND DET_TIP_FC = FIS_TIP_FC               ';

  Result := Result + '    INNER JOIN CADFOR ON FOR_CODFOR = ADC_CODFOR    ';
  Result := Result + '   LEFT  JOIN CADCFO  ON CFO_CODCFO = D.DET_CLAFIS';

  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + ' LEFT JOIN ESPDET AS ED ON ED.DET_DOCDEV = D.DET_NUMDOC AND    ';
    Result := Result + '                           ED.DET_ESPDEV = D.DET_ESPDOC AND    ';
    Result := Result + '                           ED.DET_EMPDEV = D.DET_CODEMP AND    ';
    Result := Result + '                           ED.DET_CODITE = D.DET_CODITE        ';
    Result := Result + ' LEFT JOIN ESPGER AS EG ON ED.DET_SEQGER = EG.AUTOINCREM AND   ';
    Result := Result + '                           GER_MOVGER IS NULL  AND             ';
    Result := Result + '                           IF(D.DET_TIP_FC = "C", EG.GER_CODCLI = D.DET_CODCLI, EG.GER_CODFOR = D.DET_CODFOR)  ';
  End;

  Result := Result + ' WHERE R.ARC_CODEMP = :CODEMP ';

  If fConferenciaAntesDoPlanoDeRecebimento Then
    Result := Result + '   AND R.ARC_STATUS = "EP"  '
  Else
    Result := Result + '   AND R.ARC_STATUS = "CN"  ';

  Result := Result + '   AND (IFNULL(AIT_QTDTOT,0) - ' + strSqlQtdConf + ' - IFNULL(AIT_QTDDEV,0) - IFNULL(AIT_DIVLIB,0) ';

  If fCfgSis('OUSAFO', varString) = '2' Then
    Result := Result + '  - IFNULL(ED.DET_QTDITE,0)  ';

  Result := Result + '     ) > 0';

  if not fEmptyDate(mskDtaIni.Text) Then
    Result := Result + ' AND ARC_DTAREC BETWEEN :DTAINI AND :DTAFIN ';

  Result := Result + ' HAVING QTDCON < QTDNFE ';
  Result := Result + ' ORDER BY DETAIL_KEY ';
end;

procedure TfrmEntConferPreNotaWMSDevolucao.FormCreate(Sender: TObject);
begin
  inherited;
  FblnCOFTRA := (fCfgSis('COFTRA', varBoolean))
    And (Not fUsaRotinaWMS)
    And (fCfgSis('CONSIM', varString) <> 'N');
  cdsDados := TZClient.Create(Self);
  cdsDados.AfterPost := cdsDadosAfterPost;
  cdsItens := TZClient.Create(Self);

  blnSemWms := ((Not fCfgSis('UTIWMS', VarBoolean) And fCfgSis('UDEVME', VarBoolean)));
  cxgDadosDBTableViewCitelNOMMOT.Visible := Not blnSemWMS;
  cxgDadosDBTableViewCitelPLACA_.Visible := Not blnSemWMS;
  cxgDadosDBTableViewCitelIDENTI.Visible := Not blnSemWMS;

  pnlFilterFor.Visible := blnSemWMS;
  If blnSemWMS then
  begin
    mskDtaIni.Text := DateToStr(fNow);
    mskDtaFin.Text := DateToStr(fNow);
    cxgDadosQTDCON.Visible := True;
    cxgDadosItemQTDLDE.Visible := True;
    cxgDadosQTDLDE.Visible := True;
  End
  Else
  Begin
    btnAbreDados.Left := 210;
    cxgDadosQTDCON.Visible := False;
    cxgDadosItemQTDLDE.Visible := False;
    cxgDadosQTDLDE.Visible := False;
  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsItens);
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.FormShow(Sender: TObject);
begin
  inherited;
  pTrataChamadaExterna;
end;

function TfrmEntConferPreNotaWMSDevolucao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin
      mskDtaFin.Enabled := not fEmptyDate(mskDtaIni.text);
      If (Not mskDtaFin.Enabled) Then
        mskDtaFin.Clear;
    End

    Else
    If (Sender = mskDtaFin) Then
    Begin
      Result := StrToDateDef(mskDtaFin.Text,0) >= StrToDateDef(mskDtaIni.Text,0);
      If Not Result Then
        fMensagem('', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&OK']);
    End

    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrLinFor);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmEntConferPreNotaWMSDevolucao.pAbreDados;
Begin
  With cdsDados.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    If ((Not fCfgSis('UTIWMS', VarBoolean) And fCfgSis('UDEVME', VarBoolean))) Then
      Add(fGetSQLDifSemWMS)
    Else
      Add(fGetSQLDiferencas);

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    if not fEmptyDate(mskDtaIni.Text) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateDef(mskDtaIni.Text, 0);
      ParamByName('DTAFIN').AsDateTime := StrToDateDef(mskDtaFin.Text, 0);
    End;

  End;

  cdsDados.fAbreClient(True, 'TfrmEntConferPreNotaWMSDevolucao.pAbreDados', False, True);

  TFloatField(cdsDados.FieldByName('QTDNFE')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('QTDCON')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsDados.FieldByName('QTDDEV')).DisplayFormat := fMskDigitos(2);
  TcxCurrencyEditProperties(cxgDadosDBTableViewCitelQTDLIB.Properties).DisplayFormat := fMskDigitos(2);

  cxgDadosDBTableViewCitel.DataController.DataSource := cdsDados.dtsSource;

  cdsDados.Filtered := False;
  cdsDados.Filter   := '';
  cdsDados.FieldByName('MARCA_').OnChange := pOnChangeMarca;

  With cdsItens.qryQuery, SQL Do
  Begin
    Close;
    Clear;

    If ((Not fCfgSis('UTIWMS', VarBoolean) And fCfgSis('UDEVME', VarBoolean))) Then
      Add(fGetSQLEntSemWMS)
    Else
      Add(fGetSQLEntradas);

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    if not fEmptyDate(mskDtaIni.Text) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDateDef(mskDtaIni.Text, 0);
      ParamByName('DTAFIN').AsDateTime := StrToDateDef(mskDtaFin.Text, 0);
    End;

  End;

  cdsItens.fAbreClient(True, 'TfrmEntConferPreNotaWMSDevolucao.pAbreDados', False, True);

  cdsItens.BeforePost := cdsItensBeforePost;

  TFloatField(cdsItens.FieldByName('UNITAR')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('QTDENV')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(2);

  cxgDadosDBTableViewItens.DataController.DataSource := cdsItens.dtsSource;

  cdsItens.FieldByName('SELEC_').OnChange := pOnChangeSelec;

  btnEmitirDevolucao.Enabled := False;
  btnLiberarEnderecamento.Enabled := False;
  cxgDadosDBTableViewCitel.ApplyBestFit();
  cxgDadosDBTableViewItens.ApplyBestFit();
  pSetFocus(cxgDados);

End;

procedure TfrmEntConferPreNotaWMSDevolucao.cdsItensBeforePost(DataSet : TDataSet);
Begin
  If blnsemWms then
    If DataSet.FieldByName('QTDENV').AsFloat > DataSet.FieldByName('QTD_DISP_DEV').AsFloat Then
    Begin
      DataSet.FieldByName('QTDENV').AsFloat := 0;
      fMensagem('', 'A Quantidade a ser enviada na devolução não pode ser maior que a quantidade a Devolver!', ['&OK']);
    End;

  If DataSet.FieldByName('QTDENV').AsFloat > DataSet.FieldByName('QTDITE').AsFloat Then
  Begin
    DataSet.FieldByName('QTDENV').AsFloat := 0;
    fMensagem('', 'A Quantidade a ser enviada na devolução não pode ser maior que a quantidade de entrada!', ['&OK']);
  End;
End;

procedure TfrmEntConferPreNotaWMSDevolucao.pOnChangeMarca(Sender : TField);
Begin
  If (Sender.AsString = 'S') Then
  Begin
    if (fGetQtdNotas = 1) then
    begin
      btnEmitirDevolucao.Enabled := True;
      pSelecionaNota;
      pDistribuiQtdADevolver;
    end;
  End
  Else
  Begin
    pZeraQtdADevolver;
    pDesmarcaItens;
    If (not fTemRegistroMarcado) Then
    Begin
      btnEmitirDevolucao.Enabled := False;
    End;
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fGetQtdEnv(var strErro: string; blnValidaQtd: Boolean = False) : Double;
var  fltQtdSel,
     fltQtdNotSel: Double;
     fltQtdLimite: Double;
     strQtdLimite: String;
     intRecNo: Integer;
Begin
  intRecNo := cdsDados.RecNo;
  fltQtdSel := 0;
  fltQtdNotSel := 0;
  Try
    Result := 0;

    cdsItens.DisableControls;
    cdsItens.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsItens.Filtered := True;
    cdsItens.First;

    strErro := '';

    While not cdsItens.Eof Do
    Begin
     if cdsItens.FieldByName('SELEC_').AsString = 'S' then
     Begin
        fltQtdSel := fltQtdSel + cdsItens.FieldByName('QTDENV').AsFloat;
        If blnSemWms Then
        Begin
          fltQtdLimite := cdsItens.FieldByName('QTD_DISP_DEV').AsFloat;
          strQtdLimite := cdsItens.FieldByName('QTD_DISP_DEV').AsString;
        End
        Else
        Begin
          fltQtdLimite := fltQtdNotSel + cdsItens.FieldByName('QTDITE').AsFloat;
          strQtdLimite := cdsItens.FieldByName('QTDITE').AsString;
        End;
        if cdsItens.FieldByName('QTDENV').AsFloat > fltQtdLimite then
        Begin
          strErro := 'Documento: ' + cdsItens.FieldByName('NUMDOC').AsString +
                     ' Item: ' + cdsItens.FieldByName('CODITE').AsString +
                     ' Qtd. A Devolver: ' + cdsItens.FieldByName('QTDENV').AsString +
                     ' Qtd. Limite: ' + strQtdLimite;
          if blnValidaQtd then
            Exit(0);
        End;
     End
     Else
        fltQtdNotSel := fltQtdNotSel + cdsItens.FieldByName('QTDITE').AsFloat;
      cdsItens.Next;
    End;

    If not blnSemWms Then
    Begin
      if (cdsDados.FieldByName('QTDDEV').AsFloat - fltQtdSel) > fltQtdNotSel then
      Begin
        strErro := 'Quantidade Selecionada para envio no Documento ' + cdsItens.FieldByName('NUMDOC').AsString + ' inviabiliza envios posteriores.';
        if blnValidaQtd then
          Exit(fltQtdSel);
      End;
      if (cdsDados.FieldByName('QTDDEV').AsFloat - fltQtdSel) < 0 then
        strErro := 'Quantidade Selecionada excede o permitido no Item ' + cdsItens.FieldByName('CODITE').AsString + '.';
    End;

    Result :=fltQtdSel;

  Finally
    cdsItens.Filtered := False;
    cdsItens.Filter := '';
    cdsItens.EnableControls;
    cdsDados.RecNo := intRecNo;
  End;

End;

procedure TfrmEntConferPreNotaWMSDevolucao.pZeraQtdADevolver;
  Var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    cdsClone.CloneCursor(cdsItens, False, True);

    cdsClone.DisableControls;
    cdsClone.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsClone.Filtered := True;
    cdsClone.First;

    While not cdsClone.Eof Do
    Begin
      cdsClone.Edit;
      cdsClone.FieldByName('QTDENV').AsFloat := 0;
      cdsClone.Post;

      cdsClone.Next;
    End;

  Finally
    cdsClone.Filtered := False;
    cdsClone.Filter := '';
    cdsClone.EnableControls;

    FreeAndNil(cdsClone);
  End;

End;

procedure TfrmEntConferPreNotaWMSDevolucao.pDistribuiQtdADevolver;
  Var
    fltQtdDev : Double;
    cdsClone : TUniClientDataSet;
    strMenssagem: String;
    intRecno: Integer;
Begin
  cdsClone := TUniClientDataSet.Create(Nil);
  intRecno := cdsItens.RecNo;
  Try
    cdsClone.CloneCursor(cdsItens, False, True);

    fltQtdDev := cdsDados.FieldByName('QTDDEV').AsFloat - fGetQtdEnv(strMenssagem);
    If fltQtdDev <= 0 Then
      Exit;

    cdsClone.DisableControls;
    cdsClone.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsClone.Filtered := True;
    cdsClone.First;

    While not cdsClone.Eof Do
    Begin
      If (cdsClone.FieldByName('QTDITE').AsFloat - cdsClone.FieldByName('QTDENV').AsFloat) >  0 Then
      Begin
        If (cdsClone.FieldByName('QTDITE').AsFloat - cdsClone.FieldByName('QTDENV').AsFloat) >= fltQtdDev Then
        Begin
          cdsClone.Edit;
          cdsClone.FieldByName('QTDENV').AsFloat := fltQtdDev;
          cdsClone.Post;

          cdsClone.Last;
        End
        Else
        Begin
          cdsClone.Edit;
          cdsClone.FieldByName('QTDENV').AsFloat := cdsClone.FieldByName('QTDITE').AsFloat;
          cdsClone.Post;

          fltQtdDev := fltQtdDev - cdsClone.FieldByName('QTDITE').AsFloat;
        End;
      End;

      cdsClone.Next;
    End;

  Finally
    cdsClone.Filtered := False;
    cdsClone.Filter := '';
    cdsClone.EnableControls;

    FreeAndNil(cdsClone);
    if (intRecno > 0) and (intRecno <= cdsItens.RecordCount) then
      cdsItens.RecNo := intRecno;
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fTemRegistroMarcado : Boolean;
  Var
    bkMark : TBookMark;
Begin
  Try
    cdsItens.GetBookmark;
    cdsItens.DisableControls;
    cdsItens.First;
    Result := cdsItens.Locate('SELEC_', 'S', []);
  Finally
    cdsItens.BookMark := bkMark;
    cdsItens.EnableControls;
  End;
End;

procedure TfrmEntConferPreNotaWMSDevolucao.pDefineNotasADevolver(var AList : TStringList);
Begin
  Try
    cdsItens.DisableControls;
    cdsItens.Filter := 'SELEC_ = ' + QuotedStr('S');
    cdsItens.Filtered := True;
    While not cdsItens.Eof Do
    Begin
      If AList.IndexOf(cdsItens.FieldByName('SEQGER').AsString) < 0 Then
        AList.Add(cdsItens.FieldByName('SEQGER').AsString);

      cdsItens.Next;
    End;

  Finally
    cdsItens.Filtered := False;
    cdsItens.Filter := '';
    cdsItens.First;
    cdsItens.EnableControls;
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fConfirma( enuTipoBaixa : TTipoBaixaDivergenciasWMS ) : boolean;
  Var
    frmGrav : TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGrav);
    if enuTipoBaixa = tbdDevolucao then
      frmGrav.fExecutarAcao := fConfirmaDevolucao
    else
    Begin
      If blnSemWms then
        frmGrav.fExecutarAcao := fConfirmaLiberacaoEnderecamentoSemWms
      Else
        frmGrav.fExecutarAcao := fConfirmaLiberacaoEnderecamento;
    End;
    frmGrav.ShowModal;
    Result := frmGrav.blnConfirma;
  Finally
    FreeAndNil(frmGrav);
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fVaiEmitirNF : Boolean;
Begin
  Result := False;
  Try
    cdsItens.DisableControls;
    cdsItens.First;
    While not cdsItens.Eof Do
    Begin
      If (cdsItens.FieldByName('QTDENV').AsFloat > 0) And (cdsItens.FieldByName('ESPDOC').AsString = 'NF') Then
        Exit(True);

      cdsItens.Next;
    End;

  Finally
    cdsItens.First;
    cdsItens.EnableControls;
  End;
End;

function TfrmEntConferPreNotaWMSDevolucao.fConfirmaDevolucao(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    fatVenda : TFatVenda;
    strCodCfo : String;
    strIncNfaDevolver : String;
    opcDoc : TopcDocEmi;
    frmFatDigMensagemOrc : TfrmFatDigMensagemOrc;
Begin
  stlDocDev := TStringList.Create;
  Result := True;

  If fVaiEmitirNF Then
  Begin
    fMensagem('', 'Escolha o CFOP para emissão da Devolução!', ['&OK']);
    strCodCfo := fGetCFOP;
    If fEmptyStr(strCodCfo) Then
    Begin
      Exit(False);
    End;
  End;

  pDefineNotasADevolver(stlDocDev);

  cxProgressBar.Properties.Max := stlDocDev.Count;

  For strIncNfADevolver in stlDocDev Do
  Begin
    cxProgressBar.Position := cxProgressBar.Position + 1;
    Try
      cdsItens.DisableControls;
      cdsItens.Filter := 'SEQGER = ' + QuotedStr(strIncNfADevolver) + ' AND QTDENV > 0';
      cdsItens.Filtered := True;

      If (cdsItens.FieldByName('ESPDOC').AsString = 'PD') Then
        opcDoc := opcTE
      Else
        opcDoc := opcNF;

      pCriarCdsVenda(Self);
      cdsVenda.EmptyDataSet;

      if (opcDoc = opcNF) Then
      Begin
        fatVenda                := TFatVenda.CreateInstance('OF');
        fatVenda.strOpcDocTrue  := 'OF';
        fatVenda.strEspDoc      := 'NF';
        pCarregaDadosFornecedor(cdsItens.FieldByName('CODFOR').AsString, fatVenda);
      End
      Else
      Begin
        fatVenda                := TFatVenda.CreateInstance('TE');
        fatVenda.strOpcDocTrue  := 'TE';
        fatVenda.strEspDoc      := 'TE';
        strCodCfo               := '5999';
        pCarregarCliente( fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_FORFIL'], [cdsItens.FieldByName('CODFOR').AsString]), fatVenda);
      End;

      fatVenda.strOriDoc      := 'V';
      fatVenda.blnVerEstOrc   := False;
      fatVenda.strNomeForm    := 'frmFatVendas';
      fatVenda.blnDvComDta    := True;
      fatVenda.blnDevWms      := True;
      fatVenda.strMen001      := '';
      fatVenda.strMen002      := '';
      fatVenda.strCodVen      := strLoginUsuarioLogado;
      fatVenda.strNomVen      := fRetNomVendRep(fatVenda.strCodVen);
      fatVenda.strConPag      := '01000';
      fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
      fatVenda.fLiberaReservaDeEstoqueDevolucaoWMS := fLiberaReservaDeEstoque;

      if fFornecedorFilial(cdsItens.FieldByName('CODFOR').AsString) Then
      Begin
        fatVenda.blnCliFil   := True;
        fatVenda.strCodForTe := cdsItens.FieldByName('CODFOR').AsString;
        fatVenda.strTEPPRO   := fGetTEPPRO(VS_strCodEmp, cdsItens.FieldByName('CODFOR').AsString, True);
        fatVenda.strTEPREV   := fGetTEPREV(VS_strCodEmp, cdsItens.FieldByName('CODFOR').AsString, True);
      End;

      Result := fIncluiItens(fatVenda);
      If Result Then
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
        fatVenda.pCalculaDescontoEspecialDevolucaoFornecedor;
        fatVenda.pCalculaTotGer(False, False);

        fatVenda.pCalculaTotGer;

        fatVenda.strClaFis := strCodCfo;
        fatVenda.strDesCla := fRetDesCla(fatVenda.strClaFis);

        If (opcDoc = opcNF) Then
        Begin
          Try
            pCriarFormularios(TfrmFatDadosFiscais, frmFatDadosFiscais);
            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Text    := fatVenda.strClafis;
            frmFatDadosFiscais.fraDadosFechamentoVendaClaFisFrame.edtClaFis.Enabled := False;
            frmFatDadosFiscais.blnForcaEdiBas    := True;
            frmFatDadosFiscais.fatVenda := fatVenda;

            frmFatDadosFiscais.Caption := frmFatDadosFiscais.Caption;
            frmFatDadosFiscais.blnPodeCancelar := True;
            frmFatDadosFiscais.ShowModal;

            Result := frmFatDadosFiscais.blnConfirma;

          Except
            On E: Exception Do
            Begin
              Result := False;
              pMensagensErro(E.Message, '');
            End;
          End;

          pFreeAndNil(frmFatDadosFiscais);
        End
        Else
        Begin
          Try
            pCriarFormularios(TfrmFatDigMensagemOrc, frmFatDigMensagemOrc);

            frmFatDigMensagemOrc.blnPodeCancelar := True;
            frmFatDigMensagemOrc.fatVenda := fatVenda;
            frmFatDigMensagemOrc.showModal;

            Result := frmFatDigMensagemOrc.blnConfirma;

          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[fConfirmaVenda_6]');
          End;

          pFreeAndNil(frmFatDigMensagemOrc);
        End;

        If (Not Result) Then
        Begin
          Exit(False);
        End;

        fatVenda.pCalculaTotalParaCadRec;
        fatVenda.pRateiaValores;
        fatVenda.strTabPre :=  fCfgSis('TBPSUG');
        If fatVenda.strTabPre = '' Then
          fatVenda.strTabPre := '0';

        fDigDuplic(fatVenda.arrDuplicata, fTiraCaracEspeciaisParenteses(fatVenda.strConPag), 0, fatVenda.fltTotCadRec,
                                               False, False, False, VS_Date, False, fatVenda.fltImpFre,
                                               'N', fCfgSis('DUPRED', varBoolean), False, 0, False,
                                               Nil, '', fCfgSis('FSDUDP', varBoolean), True, Nil, '', False, True, '', '', Nil, fatVenda.fFaturandoPedido,
                                               False, Nil, False, False, 0, '', fatVenda.strCodCid);

        Try
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.strChave            := 'FATFATURA';
          frmGravando.fExecutarAcao       := fatVenda.fGravaArquivos;
          frmGravando.lblGravando.Caption := 'Aguarde, Gravando Retorno...';
          frmGravando.ShowModal;
          Result := frmGravando.blnConfirma;
          pFreeAndNil(frmGravando);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[fConfirmaVenda - frmGravando]');
            Result := False;
            pFreeAndNil(frmGravando);
          End;
        End;

      End;

    Finally
      cdsItens.Filtered := False;
      cdsItens.Filter := '';
      cdsItens.EnableControls;

      FreeAndNil(fatVenda);
      pFreeCdsVenda;
    End;

    If Not Result Then
      Break;
  End;

  FreeAndNil(stlDocDev);

End;

procedure TfrmEntConferPreNotaWMSDevolucao.pCarregaDadosFornecedor(strCodFor: String; var fatVenda : TFatVenda);
  Var
    strSQL: String;
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery(Self);

  Try

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_I_E_S_, ';
    strSQL := strSQL + '   FOR_CODATI, ';
    strSQL := strSQL + '   FOR_CODFOR, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   FOR_ENDERE, ';
    strSQL := strSQL + '   FOR_ENDNUM, ';
    strSQL := strSQL + '   FOR_ENDCOM, ';
    strSQL := strSQL + '   FOR_BAIRRO, ';
    strSQL := strSQL + '   FOR_C_E_P_, ';
    strSQL := strSQL + '   FOR_CODCID, ';
    strSQL := strSQL + '   FOR_FONE01, ';
    strSQL := strSQL + '   FOR_C_G_C_, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_CGCCPF, ';
    strSQL := strSQL + '   FOR_EMAIL_  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '   CADFOR      ';
    strSQL := strSQL + ' WHERE         ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
    End;

    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliAti := qryDados.FieldByName('FOR_CODATI').AsString;
    fatVenda.strCodCli := qryDados.FieldByName('FOR_CODFOR').AsString;
    //fatVenda.strCodFor := qryDados.FieldByName('FOR_CODFOR').AsString;
    fatVenda.strCodVen := strLoginUsuarioLogado;
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliNom := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliOri := qryDados.FieldByName('FOR_NOMFOR').AsString;
    fatVenda.strCliEnd := qryDados.FieldByName('FOR_ENDERE').AsString;
    fatVenda.strCliNum := qryDados.FieldByName('FOR_ENDNUM').AsString;
    fatVenda.strCliCom := qryDados.FieldByName('FOR_ENDCOM').AsString;
    fatVenda.strCliBai := qryDados.FieldByName('FOR_BAIRRO').AsString;
    fatVenda.strCliCep := qryDados.FieldByName('FOR_C_E_P_').AsString;
    fatVenda.strCodCid := qryDados.FieldByName('FOR_CODCID').AsString;
    fatVenda.strCliCid := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 0);
    fatVenda.strCliEst := fRetNomCidade(qryDados.FieldByName('FOR_CODCID').AsString, 1);
    fatVenda.strCliTel := qryDados.FieldByName('FOR_FONE01').AsString;
    fatVenda.strCliCgc := qryDados.FieldByName('FOR_C_G_C_').AsString;
    fatVenda.intCgcCpf := qryDados.FieldByName('FOR_CGCCPF').AsInteger;
    fatVenda.strCliIes := qryDados.FieldByName('FOR_I_E_S_').AsString;
    fatVenda.strCliEma := qryDados.FieldByName('FOR_EMAIL_').AsString;
    fatVenda.strCliEm2 := '';
    fatVenda.strCliCon := 'N';

    qryDados.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosFornecedor]');
      FreeAndNil(qryDados);
      Exit;
    End;
  End;

  FreeAndNil(qryDados);
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pCarregarCliente(strCodCli:String; var fatVenda : TFatVenda);
begin
  fatVenda.pCarregaDadosClienteBaixa(strCodCli);
  fatVenda.strCodVen := strLoginUsuarioLogado;
end;

function TfrmEntConferPreNotaWMSDevolucao.fIncluiItens(var fatVenda : TFatVenda) : Boolean;
  Var
    qryGenIte : TUniQuery;
    strDesNes,
    strIteDes : String;
    fltPreEnv : Double;
    intContador : Integer;
    recForTin   : TForTin;
    recMadeira  : TDadosMadeira;
Begin
  Try
    Result := True;

    Try
      intContador := 0;
      qryGenIte := fCriaQuery;
      cdsItens.First;
      fatVenda.objItensNotaEspelho := TItensNotaEspelho.Create(fatVenda);
      While Not cdsItens.Eof Do
      Begin
        If (cdsItens.FieldByName('QTDENV').AsFloat > 0) Then
        Begin
          Inc(intContador);
          If (cdsItens.FieldByName('FIS_ACESSO').AsString <> '') And (fatVenda.strChaveNFeRefDevolucao = '') Then
            fatVenda.strChaveNFeRefDevolucao := cdsItens.FieldByName('FIS_ACESSO').AsString;

          fGetItem(qryGenIte, cdsItens.FieldByName('CODITE').AsString);

          strIteDes := cdsItens.FieldByName('DESITE').AsString;

          strDesNes := fPadR(qryGenIte.FieldByName('ITE_REFERE').AsString, 20) +
                       fStrZero(RightStr(cdsItens.FieldByName('NUMDOC').AsString, 9), 9) +
                       fStrZero(cdsItens.FieldByName('SERIE_').AsString, 3);

          fltPreEnv := cdsItens.FieldByName('UNITAR').AsFloat;

          fatVenda.pAdicionaRegistroTemporaria(cdsVenda,
                                               Nil,
                                               'NOR',
                                               qryGenIte.FieldByName('ITE_CODGRU').AsString,
                                               cdsItens.FieldByName('CODITE').AsString,
                                               qryGenIte.FieldByName('ITE_DESITE').AsString,
                                               strIteDes,
                                               qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                               qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                               qryGenIte.FieldByName('UNI_CODUNI').AsString,
                                               qryGenIte.FieldByName('ITE_CODMAR').AsString,
                                               cdsItens.FieldByName('CODFOR').AsString,
                                               qryGenIte.FieldByName('ITE_REFERE').AsString,
                                               fltPreEnv, // fltUniOri
                                               fltPreEnv, // fltUniVis
                                               fltPreEnv, // fltUniTar
                                               0.0,
                                               0.0,
                                               cdsItens.FieldByName('QTDENV').AsFloat,
                                               fltPreEnv * cdsItens.FieldByName('QTDENV').AsFloat, // fltTotIte
                                               'S',
                                               cdsItens.FieldByName('UNITAR').AsFloat,
                                               fFormataFloat(cdsItens.FieldByName('UNITAR').AsFloat * cdsItens.FieldByName('QTDENV').AsFloat, 2), // fltTotCus
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
                                               0.0,
                                               qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                               'N',
                                               qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                               qryGenIte.FieldByName('ITE_COMDIS').AsFloat,

                                               cdsItens.FieldByName('NUMDOC').AsString,
                                               cdsItens.FieldByName('ESPDOC').AsString,
                                               cdsItens.FieldByName('EMPENT').AsString,

                                               0,
                                               0,
                                               cdsItens.FieldByName('SEQDET').AsString, //Autoincrem do documento de entrada (MOVDET)

                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat * cdsItens.FieldByName('QTDENV').AsFloat,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                               qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                               '',
                                               '',
                                               '',
                                               '',
                                               0,
                                               '',
                                               0,
                                               0,
                                               0.00,
                                               0.00,
                                               0.00,
                                               'N',
                                               '',
                                               0,
                                               0,
                                               qryGenIte.FieldByName('ABF_CODABF').AsString,
                                               qryGenIte.FieldByName('ITE_PESOIT').AsFloat,
                                               qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                               'N',
                                               0,
                                               0,
                                               0,
                                               0,
                                               '',
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
                                               fRetNomMarca(qryGenIte.FieldByName('ITE_CODMAR').AsString),
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               '',
                                               0,
                                               strDesNes,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                               fltPreEnv, // fltUniDig
                                               qryGenIte.FieldByName('ITE_QTPPRO').AsFloat,
                                               '',
                                               '',
                                               qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                               '',
                                               '',
                                               fRetSiglaUnidade(qryGenIte.FieldByName('UNI_CODUNI').AsString),
                                               0.00,
                                               intContador,
                                               '',
                                               '',
                                               '',
                                               False,
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
                                               '1',
                                               cdsItens.FieldByName('ALQIPI').AsFloat,
                                               qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                               '',
                                               0.0,
                                               '',
                                               0.0,
                                               'R',
                                               '',
                                               'N',
                                               '',
                                               0,
                                               cdsItens.FieldByName('QTDENV').AsFloat,
                                               0.0,
                                               0,
                                               qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                               '',
                                               0.00,
                                               0.00,
                                               0.00,
                                               0,
                                               0,
                                               0,
                                               0,
                                               0,
                                               recForTin,
                                               '',
                                               '',
                                               'A DEFINIR',
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
                                               fltPreEnv, // fltCusIte
                                               '',
                                               '',
                                               recMadeira,
                                               qryGenIte.FieldByName('ITE_IMPULT').AsFloat * cdsItens.FieldByName('QTDENV').AsFloat,
                                               0,
                                               0,
                                               '',
                                               0,
                                               '',
                                               '',
                                               0,
                                               0,
                                               '',
                                               '',
                                               0,
                                               '',
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
                                               '',
                                               0.00,
                                               cdsItens.FieldByName('SEQDET').AsString,
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
          fatVenda.objItensNotaEspelho.Item[cdsItens.FieldByName('SEQDET').AsString];
        End;

        cdsItens.Next;
      End;

    Finally
      cdsItens.First;
      FreeAndNil(qryGenIte);
    End;

  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmEntConferPreNotaWMSDevolucao.fIncluiItens');
    End;
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fGetItem(Var qryGenIte: TUniQuery; strCodIte: String): Boolean;
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
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  U.UNI_CODUNI, ';
    strSQL := strSQL + '  U.UNI_DESUNI, ';
    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_REFERE, ';

    strSQL := strSQL + '  G.ITE_DESF01, ';
    strSQL := strSQL + '  G.ITE_DESF02, ';
    strSQL := strSQL + '  G.ITE_DESF03, ';
    strSQL := strSQL + '  G.ITE_DESF04, ';
    strSQL := strSQL + '  G.ITE_DESF05, ';
    strSQL := strSQL + '  G.ITE_DESF06, ';
    strSQL := strSQL + '  G.ITE_PREDOL, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A, ';
    strSQL := strSQL + '  CADMAR M, ';
    strSQL := strSQL + '  CADUNI U  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODMAR = M.MAR_CODMAR AND ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  I.ITE_CODUNI = U.UNI_CODUNI AND ';

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

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmEntConferPreNotaWMSDevolucao.fGetItem]');
    End;

  End;

end;

function TfrmEntConferPreNotaWMSDevolucao.fGetCFOP : String;
  Var
    qryCadCfo : TUniQuery;
    chrKey: Char;
    arrSel: TConsultasArray;
    strWhere : String;

Begin
  Try
    qryCadCfo := fCriaQuery;
    chrKey := '?';
    Result := '';
    strWhere := ' LOCATE(CFO_CODCFO, ' + QuotedStr(fTransform(fCfgSis('CLANFO'), 4)) + ') > 0 ';
    If fPesqCFOP(Self, Nil, Nil, qryCadCfo, chrKey, arrSel, True, strWhere) Then
    Begin
      Result := qryCadCfo.FieldByName('CFO_CODCFO').AsString;
    End;

  Finally
    FreeAndNil(qryCadCfo);
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fLiberaReservaDeEstoque(const AutIncVen: String) : Boolean;
  Var
    qryFatDor : TUniQuery;
    qryAuxili : TUniQuery;
    qryFatDorReserva : TUniQuery;
    qryExtDorReserva : TUniQuery;
    strIncFgo : String;
    fltQtdEnvBai : Double;
    objControlaReservaDevolucaoVenda: TControlaReservaDevolucaoVenda;

Begin
  (*  Essa rotina é passada como parametro para o faturamento, para ser executada na mesma transação da venda,
      pois caso der algum erro, todo o processo é abortado e executa o Rollback ! *)
  Try
    Result := True;
    qryFatDor := fCriaQuery;
    qryAuxili := fCriaQuery;
    qryFatDorReserva := fCriaQuery;
    qryExtDorReserva := fCriaQuery;
    objControlaReservaDevolucaoVenda := TControlaReservaDevolucaoVenda.Create(AutIncVen, '');
    objControlaReservaDevolucaoVenda.LimparItens;

    cdsItens.First;
    Try
      While Not cdsItens.Eof Do
      Begin
        If (cdsItens.FieldByName('QTDENV').AsFloat > 0) Then
        Begin
          //Se eh item que não tem enderecamento
          If blnSemWms and fEmptyStr(cdsItens.FieldByName('DIC_SEQDOR').AsString) then
          Begin
            strIncFgo := '';
            objControlaReservaDevolucaoVenda.IncFatGor := '';
            objControlaReservaDevolucaoVenda.AdicionarItem('',
                                                           cdsItens.FieldByName('SEQDET').AsString,
                                                           cdsItens.FieldByName('QTDENV').AsFloat);


          End
          Else
          Begin
            With qryFatDor, SQL Do
            Begin
              Close;
              Clear;
              If Not blnSemWms then
              Begin
                Add('SELECT FATDOR.* ');
                Add('FROM AGEDOC     ');
                Add('    INNER JOIN EXTGOR ON FGO_DOCEND = CONCAT(ADC_NUMDOC, ADC_ESPDOC, RPAD( ADC_SERIE_, 3, " " ), ADC_CODEMP, ADC_CODFOR, "F") ');
                Add('    INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
                Add('    INNER JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ');
                Add('WHERE ADC_SEQGER = :RECINC ');
                Add('  AND FDO_CODITE = :CODITE ');

                ParamByName('RECINC').AsString := cdsItens.FieldByName('RECINC').AsString;
                ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
              End
              Else
              Begin
                Add('SELECT FATDOR.* FROM FATDOR');
                add('WHERE AUTOINCREM = "'+cdsItens.FieldByName('DIC_SEQDOR').AsString+'"');
              End;
              Open;
              If Not IsEmpty Then
              Begin
                fltQtdEnvBai := cdsItens.FieldByName('QTDENV').AsFloat;

                If blnSemWms then
                Begin
                  strIncFgo := qryFatDor.FieldByName('FDO_SEQGER').AsString;
                  objControlaReservaDevolucaoVenda.IncFatGor := strIncFgo;
                  objControlaReservaDevolucaoVenda.AdicionarItem(qryFatDor.FieldByName('AUTOINCREM').AsString,
                                                                 cdsItens.FieldByName('SEQDET').AsString,
                                                                 cdsItens.FieldByName('QTDENV').AsFloat);

                  Result := TDevolucaoRetornaEstoque.fAtualizaReservaEnderecamento(qryFatDor.FieldByName('AUTOINCREM').AsString, cdsItens.FieldByName('QTDENV').AsFloat);
                  If not Result Then
                    Exit;
                End
                Else
                Begin
                  While (Not Eof) And (fltQtdEnvBai > 0) Do
                  Begin

                    //Se o que tem para endereçar é menor ou igual ao que vai devolver, pode apagar a FATDOR, se Apagou a fatDor Verifica se ainda tem intes no PEDIDO, se nao tiver apaga a FATGOR TBM;
                    If ((FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat) <= fltQtdEnvBai) Then
                    Begin
                      fltQtdEnvBai := fltQtdEnvBai - (FieldByName('FDO_QTDITE').AsFloat - FieldByName('FDO_QTDBAI').AsFloat);

                      fVerificaIntegridade(Self.ClassName, 'FATDOR', qryFatDor, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');
                      strIncFgo := FieldByName('FDO_SEQGER').AsString;

                      qryAuxili.Close;
                      qryAuxili.SQL.Clear;
                      qryAuxili.SQL.Add(' DELETE FROM FATDOR WHERE AUTOINCREM = :AUTINC ');
                      qryAuxili.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
                      qryAuxili.ExecSQL;


                      qryAuxili.Close;
                      qryAuxili.SQL.Clear;
                      qryAuxili.SQL.Add('SELECT COUNT(0) AS QTD FROM FATDOR WHERE FDO_SEQGER = :SEQGER ');
                      qryAuxili.ParamByName('SEQGER').AsString := strIncFgo;
                      qryAuxili.Open;

                      //Se nao tem mais itens no Pedido, pode apagar a ExtGor E FatGor
                      If (qryAuxili.FieldByName('QTD').AsInteger = 0) Then
                      Begin
                        qryAuxili.Close;
                        qryAuxili.SQL.Clear;
                        qryAuxili.SQL.Add('SELECT * FROM EXTGOR WHERE FGO_SEQFGO = :SEQFGO ');
                        qryAuxili.ParamByName('SEQFGO').AsString := strIncFgo;
                        qryAuxili.Open;

                        fVerificaIntegridade(Self.ClassName, 'EXTGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

                        qryAuxili.Delete;

                        qryAuxili.Close;
                        qryAuxili.SQL.Clear;
                        qryAuxili.SQL.Add('SELECT * FROM FATGOR WHERE AUTOINCREM = :AUTINC');
                        qryAuxili.ParamByName('AUTINC').AsString := strIncFgo;
                        qryAuxili.Open;

                        fVerificaIntegridade(Self.ClassName, 'FATGOR', qryAuxili, True, False, 'DEVOLUÇÃO DE MERCADORIAS - PRÉ NOTA');

                        qryAuxili.Delete;
                      End;

                    End
                    Else
                    // Se nao for deletar a FATDOR Apenas baixa a Qtde que foi Devolvida
                    Begin
                      Edit;
                      FieldByName('FDO_QTDBAI').AsFloat := FieldByName('FDO_QTDBAI').AsFloat + cdsItens.FieldByName('QTDENV').AsFloat;
                      Post;
                      fltQtdEnvBai := fltQtdEnvBai - cdsItens.FieldByName('QTDENV').AsFloat;
                    End;
                    Next;
                  End;
                End;
              End
              Else If (FblnCOFTRA) And (cdsItens.FieldByName('AUX_ENTSIM').AsString ='S') Then
              Begin
                strIncFgo := '';
                objControlaReservaDevolucaoVenda.IncFatGor := '';
                objControlaReservaDevolucaoVenda.AdicionarItem('',
                  cdsItens.FieldByName('SEQDET').AsString,
                  cdsItens.FieldByName('QTDENV').AsFloat);
              End;

              //Marca a DetEle como diferença já devolvida.
              Close;
              Clear;
              If  Not blnSemWms then
              begin
                Add(' UPDATE AGEITE SET AIT_QTDDEV = IFNULL(AIT_QTDDEV,0) + :QTDENV WHERE AUTOINCREM = :AUTINC');
                ParamByName('AUTINC').AsString := cdsItens.FieldByName('INCAIT').AsString;
                ParamByName('QTDENV').AsFloat  := cdsItens.FieldByName('QTDENV').AsFloat;
                ExecSQL;
              End;

            End;

            If blnSemWms Then
            begin
              If Not TDevolucaoRetornaEstoque.fnsereDevDigitado(cdsItens.FieldByName('RECINC').AsString,
                                                                cdsItens.FieldByName('SEQDET').AsString,
                                                                '',
                                                                cdsItens.FieldByName('QTDDEV').AsFloat) Then
              Begin
                Result := False;
                Exit;
              End;
            end;
          End;
        End;

        cdsItens.Next;
      End;
      If blnSemWms Then
        If objControlaReservaDevolucaoVenda.Count > 0 Then
          objControlaReservaDevolucaoVenda.PersistirItens;


    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmEntConferPreNotaWMSDevolucao.fLiberaReservaDeEstoque');
      End;

    End;

  Finally
   FreeAndNil(qryExtDorReserva);
    FreeAndNil(qryFatDor);
    FreeAndNil(qryAuxili);
    FreeAndNil(qryFatDorReserva);
    FreeAndNil(objControlaReservaDevolucaoVenda);
  End;

End;

function TfrmEntConferPreNotaWMSDevolucao.fExisteQuantidadeALiberarInformada : boolean;
var
  cdsCopy : TZClient;
Begin
  Result := False;
  cdsCopy := TZClient.Create(Nil);
  try
    cdsCopy.CloneCursor(cdsDados, true,true);

    cdsCopy.First;
    while not cdsCopy.Eof do
    begin
      if cdsCopy.FieldByName('QTDLIB').AsFloat > 0 then
      begin
        exit(true);
      end;
      cdsCopy.Next;
    end;


  finally
    FreeAndNil(cdsCopy);
  end;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.cdsDadosAfterPost(DataSet : TDataSet);
Begin
  btnLiberarEnderecamento.Enabled := fExisteQuantidadeALiberarInformada;
End;

function TfrmEntConferPreNotaWMSDevolucao.fConfirmaLiberacaoEnderecamento(cxProgressBar : TcxProgressBar) : Boolean;
var
 qryUpdate : TUniQuery;
Begin
  Result := True;

  qryUpdate := fCriaQuery(nil);
  Try
    qryUpdate.SQL.Add('UPDATE                                        ');
    qryUpdate.SQL.Add('  AGEITE                                      ');
    qryUpdate.SQL.Add('SET                                           ');
    qryUpdate.SQL.Add('  AIT_DIVLIB = IFNULL(AIT_DIVLIB,0) + :QTDLIB ');
    qryUpdate.SQL.Add('WHERE                                         ');
    qryUpdate.SQL.Add('  AUTOINCREM = :AUTINC                        ');

    cdsDados.DisableControls;
    cdsDados.Filter := 'QTDLIB > 0';
    cdsDados.Filtered := True;
    While not cdsDados.Eof Do
    Begin

      qryUpdate.ParamByName('QTDLIB').AsFloat  := cdsDados.FieldByName('QTDLIB').AsFloat;
      qryUpdate.ParamByName('AUTINC').AsString := cdsDados.FieldByName('INCAIT').AsString;
      qryUpdate.ExecSQL;

      cdsDados.Next;
    End;

  Finally
    cdsDados.Filtered := False;
    cdsDados.Filter := '';
    cdsDados.First;
    cdsDados.EnableControls;

    FreeAndNil(qryUpdate);
  End;

End;

procedure TfrmEntConferPreNotaWMSDevolucao.pOnChangeSelec(Sender: TField);
begin
  If (Sender.AsString = 'S') Then
  Begin
    btnEmitirDevolucao.Enabled := True;
    pSetQtdADevolverItem;
  End
  Else
  Begin
    pZeraQtdADevolverItem;
    If (not fTemRegistroMarcado) Then
    Begin
       btnEmitirDevolucao.Enabled := False;
    End;
  End;
end;

function TfrmEntConferPreNotaWMSDevolucao.fGetQtdNotas: Integer;
  Var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    cdsClone.CloneCursor(cdsItens, False, True);

    Result := 0;

    cdsClone.DisableControls;
    cdsClone.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsClone.Filtered := True;

    Result := cdsClone.RecordCount;
  Finally
    cdsClone.Filtered := False;
    cdsClone.Filter := '';
    cdsClone.EnableControls;

    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pZeraQtdADevolverItem;
Begin
  Try
    cdsItens.Edit;
    cdsItens.FieldByName('QTDENV').AsFloat := 0;
    cdsItens.Post;
  Finally

  End;
end;


procedure TfrmEntConferPreNotaWMSDevolucao.setAutIncExterno(const Value: String);
begin
  FstrAutIncExterno := Value;
  FBlnChamadaExterna := Not fEmptyStr(FStrAutIncExterno);
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pSelecionaNota;
  Var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    cdsClone.CloneCursor(cdsItens, False, True);

    cdsClone.DisableControls;
    cdsClone.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsClone.Filtered := True;

    cdsClone.Edit;
    cdsClone.FieldByName('SELEC_').AsString := 'S';
    cdsClone.Post;
  Finally
    cdsClone.Filtered := False;
    cdsClone.Filter := '';
    cdsClone.EnableControls;

    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pSetQtdADevolverItem;
Begin
  Try
    If cdsItens.FieldByName('QTDENV').AsFloat = 0 Then
    Begin
      cdsItens.Edit;
      If blnSemWms then
        cdsItens.FieldByName('QTDENV').AsFloat := cdsItens.FieldByName('QTD_DISP_DEV').AsFloat
      Else
        cdsItens.FieldByName('QTDENV').AsFloat := cdsItens.FieldByName('QTDITE').AsFloat;
      cdsItens.Post;
    End;
  Finally

  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pDesmarcaItens;
  Var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    cdsClone.CloneCursor(cdsItens, False, True);

    cdsClone.DisableControls;
    cdsClone.Filter := 'DETAIL_KEY = ' + QuotedStr(cdsDados.FieldByName('MASTER_KEY').AsString);
    cdsClone.Filtered := True;
    cdsClone.First;

    While not cdsClone.Eof Do
    Begin
      cdsClone.Edit;
      cdsClone.FieldByName('SELEC_').AsString := 'N';
      cdsClone.Post;

      cdsClone.Next;
    End;

  Finally
    cdsClone.Filtered := False;
    cdsClone.Filter := '';
    cdsClone.EnableControls;

    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmEntConferPreNotaWMSDevolucao.pTrataChamadaExterna;
var
  strNumDoc,
  strEspDoc,
  strCodFor,
  strSerie_,
  strCodEmp: String;
begin
  If FBlnChamadaExterna Then
  Begin
    pnlFiltros.Visible := False;

    If fEmptystr(fRetornaDataAGEREC(FStrAutIncExterno)) Then
    Begin
      blnFecharFormPai := True;
      pMensagemOk('Não foram localizados itens de devolução para esta nota!' + #13 + 'É necessário efetuar o plano de recebimento primeiro!');
      Exit;
    End;

    mskDtaIni.Text := fRetornaDataAGEREC(FStrAutIncExterno);
    mskDtaFin.Text := mskDtaIni.Text;
    btnAbreDados.Click;

    strNumDoc := fCampoTabela('GER_DOCENT', 'GERELE', ['AUTOINCREM'], [FStrAutIncExterno]);
    strEspDoc := fCampoTabela('GER_ESPENT', 'GERELE', ['AUTOINCREM'], [FStrAutIncExterno]);
    strCodFor := fCampoTabela('GER_CODFOR', 'GERELE', ['AUTOINCREM'], [FStrAutIncExterno]);
    strCodEmp := fCampoTabela('GER_CODEMP', 'GERELE', ['AUTOINCREM'], [FStrAutIncExterno]);
    strSerie_ := fCampoTabela('B07_SERIE', 'GERELE', ['AUTOINCREM'], [FStrAutIncExterno]);

    cdsItens.Filter := cdsItens.Filter + 'NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ';
    cdsItens.Filter := cdsItens.Filter + 'ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ';
    cdsItens.Filter := cdsItens.Filter + 'CODFOR = ' + QuotedStr(strCodFor) + ' AND ';
    cdsItens.Filter := cdsItens.Filter + 'EMPENT = ' + QuotedStr(strCodEmp) + ' AND ';
    cdsItens.Filter := cdsItens.Filter + 'SERIE_ = ' + QuotedStr(strSerie_);

    cdsItens.Filtered := True;

    If cdsItens.IsEmpty Then
    Begin
      blnFecharFormPai := True;
      If fPrecisaConfirmarEspelho(strNumDoc, strEspdoc, strCodFor, strCodemp, strSerie_) Then
        pMensagemOk('É necessário confirmar o espelho gerado para avaliação do fornecedor!')
      Else
        pMensagemOk('Não foram localizados itens de devolução para esta nota!' + #13 + 'É necessário efetuar o plano de recebimento primeiro!');
    End;
  End;
end;

function TFrmEntConferPreNotaWMSDevolucao.fPrecisaConfirmarEspelho(AStrNumDoc, AStrEspDoc, AStrCodFor, AStrCodEmp, AStrSerie: String): Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS CNT FROM ESPDET                  ');
    qryAux.SQL.Add(' INNER JOIN ESPGER ON DET_SEQGER = ESPGER.AUTOINCREM ');
    qryAux.SQL.Add(' WHERE DET_DOCDEV = :NUMDOC                          ');
    qryAux.SQL.Add('   AND DET_ESPDEV = :ESPDOC                          ');
    qryAux.SQL.Add('   AND GER_CODFOR = :CODFOR                          ');
    qryAux.SQL.Add('   AND DET_EMPDEV = :CODEMP                          ');
    qryAux.SQL.Add('   AND GER_MOVGER IS NULL                            ');

    qryAux.ParamByName('NUMDOC').AsString := AStrNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := AStrEspDoc;
    qryAux.ParamByName('CODFOR').AsString := AStrCodFor;
    qryAux.ParamByName('CODEMP').AsString := AStrCodEmp;

    qryAux.Open;
    Result := qryAux.FieldByName('CNT').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
end;
function TfrmEntConferPreNotaWMSDevolucao.fRetornaDataAGEREC(
  strAutIncGERELE: String): String;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Result := '';
  try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT DATE_FORMAT(ARC_DTAREC,"%d/%m/%Y") AS DTAREC  ');
    qryAux.SQL.Add('  FROM  ');
    qryAux.SQL.Add('   GERELE  ');
    qryAux.SQL.Add('     INNER JOIN MOVGER  ');
    qryAux.SQL.Add('       ON MOVGER.GER_NUMDOC = GERELE.GER_DOCENT  ');
    qryAux.SQL.Add('       AND MOVGER.GER_ESPDOC = GERELE.GER_ESPENT  ');
    qryAux.SQL.Add('       AND MOVGER.GER_CODEMP = GERELE.GER_EMPENT  ');
    qryAux.SQL.Add('       AND IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(GERELE.B07_SERIE, "")  ');
    qryAux.SQL.Add('       AND MOVGER.GER_CODFOR = GERELE.GER_CODFOR  ');
    qryAux.SQL.Add('     INNER JOIN AGEDOC  ');
    qryAux.SQL.Add('       ON ADC_CODEMP = MOVGER.GER_CODEMP  ');
    qryAux.SQL.Add('       AND ADC_CODFOR = MOVGER.GER_CODFOR  ');
    qryAux.SQL.Add('       AND ADC_ESPDOC = MOVGER.GER_ESPDOC  ');
    qryAux.SQL.Add('       AND ADC_NUMDOC = MOVGER.GER_NUMDOC  ');
    qryAux.SQL.Add('     INNER JOIN AGEREC  ');
    qryAux.SQL.Add('       ON ADC_SEQGER = AGEREC.AUTOINCREM  ');
    qryAux.SQL.Add(' WHERE GERELE.AUTOINCREM = :AUTINC  ');

    qryAux.ParamByName('AUTINC').AsString := strAutIncGERELE;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('DTAREC').AsString;

  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmEntConferPreNotaWMSDevolucao.fGetSQLDifSemWMS: String;
begin
  Result := '';
  Result := Result + ' SELECT * FROM (          ';
  Result := Result + '  SELECT                  ';
  Result := Result + '    AUXMOV.AUX_ENTSIM, ';
  Result := Result + '    DET.DET_CODITE AS CODITE, ';
  Result := Result + '    ITE_DESITE AS DESITE, ';
  Result := Result + '    SUM(DET.DET_QTDITE) AS QTDNFE, ';
  Result := Result + '    SUM(DIC_QTDITE) AS QTDCON, ';
  Result := Result + '    SUM(IFNULL(DIC_QTDTOT, 0) - IFNULL(DIC_QTDITE, 0.00) - IFNULL(DIC_QTDLDE, 0)) - SUM((IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00))) ';
  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + '   -  SUM(IFNULL((SELECT';
    Result := Result + '            SUM(IFNULL(ED.DET_QTDITE, 0)) AS ESP_QTDITE';
    Result := Result + '          FROM ESPGER EG ';
    Result := Result + '            INNER JOIN  ESPDET ED';
    Result := Result + '              ON EG.AUTOINCREM = ED.DET_SEQGER';
    Result := Result + '          WHERE ED.DET_SEQDET = DET.AUTOINCREM';
    Result := Result + '            AND EG.GER_MOVGER IS NULL';
    Result := Result + '            AND IF(';
    Result := Result + '              DET.DET_TIP_FC = "C",';
    Result := Result + '              EG.GER_CODCLI = DET.DET_CODCLI,';
    Result := Result + '              EG.GER_CODFOR = DET.DET_CODFOR';
    Result := Result + '            )';
    Result := Result + '          GROUP BY ED.DET_SEQDET),';
    Result := Result + '          0';
    Result := Result + '        ))';
  End;
  Result := Result + '  AS QTDDEV, ';
  Result := Result + '    SUM(IFNULL(DIC_QTDLDE, 0)) AS  QTDLDE, ';
  Result := Result + '    GROUP_CONCAT(DIGCON.AUTOINCREM) AS INCDIGCON, ';
  Result := Result + '    DIC_IDEDIG AS IDEDIG, ';
  Result := Result + '    DET_DTAENT AS DTAREC, ';

  Result := Result + '   SUM(IFNULL(DIC_QTDTOT, 0) - IFNULL(DIC_QTDITE, 0.00) - IFNULL(DIC_QTDLDE, 0)) - SUM((IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00)))';
  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + '   -  SUM(IFNULL((SELECT';
    Result := Result + '            SUM(IFNULL(ED.DET_QTDITE, 0)) AS ESP_QTDITE';
    Result := Result + '          FROM ESPGER EG ';
    Result := Result + '            INNER JOIN  ESPDET ED';
    Result := Result + '              ON EG.AUTOINCREM = ED.DET_SEQGER';
    Result := Result + '          WHERE ED.DET_SEQDET = DET.AUTOINCREM';
    Result := Result + '            AND EG.GER_MOVGER IS NULL';
    Result := Result + '            AND IF(';
    Result := Result + '              DET.DET_TIP_FC = "C",';
    Result := Result + '              EG.GER_CODCLI = DET.DET_CODCLI,';
    Result := Result + '              EG.GER_CODFOR = DET.DET_CODFOR';
    Result := Result + '            )';
    Result := Result + '          GROUP BY ED.DET_SEQDET),';
    Result := Result + '          0';
    Result := Result + '        ))';
  End;
  Result := Result + ' QTDDEV_TOTAL, ';
  Result := Result + '    "" AS NOMMOT, ';
  Result := Result + '    "" AS PLACA_, ';
  Result := Result + '    "" AS IDENTI, ';
  Result := Result + '    "N" AS MARCA_, ';
  Result := Result + '    NULL AS INCAIT, ';
  Result := Result + '    0.00 AS QTDLIB, ';
  Result := Result + '    DIGCON.DIC_SEQDOR, ';
  Result := Result + '    CONCAT(MOV.AUTOINCREM,"_", DET.DET_CODITE) AS MASTER_KEY ';
  Result := Result + '   FROM MOVGER MOV ';
  Result := Result + '   INNER JOIN MOVDET DET ON DET.DET_SEQGER = MOV.AUTOINCREM ';
  Result := Result + '   LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOV.AUTOINCREM';
  Result := Result + '   INNER JOIN DIGCON ON DIC_MOVDET = DET.AUTOINCREM ';
  Result := Result + '   INNER JOIN CADITE ITE ON ITE.ITE_CODITE = DET.DET_CODITE ';
  Result := Result + '   LEFT JOIN GERELE GER ON (GER.B08_NNF = MOV.GER_NUMDOC ';
  Result := Result + '				AND GER.B07_SERIE = MOV.GER_SERIE_ ';
  Result := Result + '				AND IFNULL(GER.GER_ESPENT, "NF") = MOV.GER_ESPDOC ';
  Result := Result + '				AND GER.GER_CODFOR = MOV.GER_CODFOR) ';
  Result := Result + ' 				AND GER.GER_CODEMP = MOV.GER_CODEMP ';
//
//  If fCfgSis('OUSAFO', varString) = '2' Then
//  Begin
//    Result := Result + '   LEFT JOIN ESPDET AS ED ON ED.DET_SEQDET = DET.AUTOINCREM ';
//    Result := Result + '   LEFT JOIN ESPGER AS EG ';
//    Result := Result + '     ON ED.DET_SEQGER = EG.AUTOINCREM ';
//    Result := Result + '     AND GER_MOVGER IS NULL ';
//    Result := Result + '     AND IF( ';
//    Result := Result + '       DET.DET_TIP_FC = "C", ';
//    Result := Result + '       EG.GER_CODCLI = DET.DET_CODCLI, ';
//    Result := Result + '       EG.GER_CODFOR = DET.DET_CODFOR ';
//    Result := Result + '     ) ';
//  End;
//
//  Result := Result + '   LEFT JOIN DEVVEN DD  ON DD.DEV_SEQDET = DET.AUTOINCREM ';
  Result := Result + '   WHERE TRUE ';

  Result := Result + ' AND MOV.GER_DTAENT IS NOT NULL ';

  If (FblnCOFTRA) And (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D') Then
    Result := Result + ' AND (AUXMOV.AUX_ENTSIM = "S" OR GER.GER_DTACON IS NOT NULL)'
  Else If (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D') THen
    Result := Result + '   AND GER.GER_DTACON IS NOT NULL ';

  Result := Result + '   AND MOV.GER_CODEMP = :CODEMP ';
  If not fEmptyStr(edtFornecedor.Text) Then
    Result := Result + '   AND MOV.GER_CODFOR = "'+edtFornecedor.Text+'" ';


  If FblnCOFTRA Then
    Result := Result + ' AND (AUXMOV.AUX_ENTSIM = "S" OR GER.AUTOINCREM IS NOT NULL)'
  Else
    Result := Result + ' AND GER.AUTOINCREM IS NOT NULL ';

  if not fEmptyDate(mskDtaIni.text) Then
    Result := Result + '   AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  Result := Result + '    GROUP BY MASTER_KEY) TMP';
  Result := Result + '      HAVING  QTDDEV_TOTAL > 0 ';
  Result := Result + ' ORDER BY MASTER_KEY ';

end;

function TfrmEntConferPreNotaWMSDevolucao.fGetSQLEntSemWMS: String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + ' DET.DET_CODITE AS CODITE, ';
  Result := Result + '   ITE_DESITE AS DESITE, ';
  Result := Result + '   DET.DET_QTDITE AS QTDNFE, ';
  Result := Result + '   DIC_QTDITE AS QTDCON, ';
  Result := Result + '   IFNULL(DIC_QTDDEV, 0.00) - IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00)  AS QTDDEV, ';
  Result := Result + '   DIC_IDEDIG AS IDEDIG, ';
  Result := Result + '   DET_DTAENT AS DTAREC, ';
  Result := Result + '   "" AS NOMMOT, ';
  Result := Result + '   "" AS PLACA_, ';
  Result := Result + '   "" AS IDENTI, ';
  Result := Result + '   "N" AS MARCA_, ';
  Result := Result + '   IFNULL(DIC_QTDLDE, 0) AS  QTDLDE, ';
  Result := Result + '   IFNULL(DIC_QTDTOT, 0) - IFNULL(DIC_QTDITE, 0.00) - IFNULL(DIC_QTDLDE, 0) ';
  Result := Result + '    - IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00)';
  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + '   -  IFNULL((SELECT';
    Result := Result + '            SUM(IFNULL(ED.DET_QTDITE, 0)) AS ESP_QTDITE';
    Result := Result + '          FROM ESPGER EG ';
    Result := Result + '            INNER JOIN  ESPDET ED';
    Result := Result + '              ON EG.AUTOINCREM = ED.DET_SEQGER';
    Result := Result + '          WHERE ED.DET_SEQDET = DET.AUTOINCREM';
    Result := Result + '            AND EG.GER_MOVGER IS NULL';
    Result := Result + '            AND IF(';
    Result := Result + '              DET.DET_TIP_FC = "C",';
    Result := Result + '              EG.GER_CODCLI = DET.DET_CODCLI,';
    Result := Result + '              EG.GER_CODFOR = DET.DET_CODFOR';
    Result := Result + '            )';
    Result := Result + '          GROUP BY ED.DET_SEQDET),';
    Result := Result + '          0';
    Result := Result + '        )';
  End;
  Result := Result + '   AS QTD_DISP_DEV, ';

  Result := Result + '   IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00)';
  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + '   +  IFNULL((SELECT';
    Result := Result + '            SUM(IFNULL(ED.DET_QTDITE, 0)) AS ESP_QTDITE';
    Result := Result + '          FROM ESPGER EG ';
    Result := Result + '            INNER JOIN  ESPDET ED';
    Result := Result + '              ON EG.AUTOINCREM = ED.DET_SEQGER';
    Result := Result + '          WHERE ED.DET_SEQDET = DET.AUTOINCREM';
    Result := Result + '            AND EG.GER_MOVGER IS NULL';
    Result := Result + '            AND IF(';
    Result := Result + '              DET.DET_TIP_FC = "C",';
    Result := Result + '              EG.GER_CODCLI = DET.DET_CODCLI,';
    Result := Result + '              EG.GER_CODFOR = DET.DET_CODFOR';
    Result := Result + '            )';
    Result := Result + '          GROUP BY ED.DET_SEQDET),';
    Result := Result + '          0';
    Result := Result + '        )';
  End;
  Result := Result + '    DEV_QTDBAI,';

  Result := Result + '   CONCAT(MOV.AUTOINCREM, "_", DET.DET_CODITE) AS DETAIL_KEY, ';
  Result := Result + '   GER_NUMDOC AS NUMDOC, ';
  Result := Result + '   GER_ESPDOC AS ESPDOC, ';
  Result := Result + '   GER_SERIE_ AS SERIE_, ';
  Result := Result + '   MOV.GER_CODEMP AS EMPENT, ';
  Result := Result + '   MOV.GER_CODFOR AS CODFOR, ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '   CONCAT(MOV.GER_CODFOR, "-", FOR_NOMFOR) AS FORNEC, ';
  Result := Result + '   DET.DET_UNITAR AS UNITAR, ';
  Result := Result + '   DET.DET_QTDITE AS QTDITE, ';
  Result := Result + '   DET.DET_TOTITE AS TOTITE, ';
  Result := Result + '   DET.DET_DESACE AS DESACE, ';
  Result := Result + '   DET.DET_VLRCON AS VLRCON, ';
  Result := Result + '   DET.DET_ALQIPI AS ALQIPI, ';
  Result := Result + '   0.00 AS QTDENV, ';
  Result := Result + '   CONCAT(MOV.AUTOINCREM, DET.AUTOINCREM) AS PRIMARY_KEY, ';
  Result := Result + '   DET.DET_SEQGER AS SEQGER, ';
  Result := Result + '   DET.AUTOINCREM AS SEQDET, ';
  Result := Result + '   MOV.AUTOINCREM AS RECINC, ';
  Result := Result + '   CADFIS.FIS_ACESSO, ';
  Result := Result + '   DET.AUTOINCREM AS INCAIT, ';
  Result := Result + '   DET.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '   CFO_NATOPE AS NATOPE, ';
  Result := Result + '   "N" AS SELEC_,';
  Result := Result + '   DIGCON.DIC_SEQDOR ';
  Result := Result + '   ,AUXMOV.AUX_ENTSIM ';

  Result := Result + ' FROM MOVGER MOV ';
  Result := Result + ' INNER JOIN MOVDET DET ON DET.DET_SEQGER = MOV.AUTOINCREM ';
  Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = DET.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADITE ITE ON ITE.ITE_CODITE = DET.DET_CODITE ';
  Result := Result + ' LEFT JOIN GERELE GER ON GER.B08_NNF = MOV.GER_NUMDOC ';
  Result := Result + ' 				AND GER.B07_SERIE = MOV.GER_SERIE_ ';
  Result := Result + ' 				AND IFNULL(GER.GER_ESPENT, "NF") = MOV.GER_ESPDOC ';
  Result := Result + ' 				AND GER.GER_CODFOR = MOV.GER_CODFOR ';
  Result := Result + ' 				AND GER.GER_CODEMP = MOV.GER_CODEMP ';
  Result := Result + ' 				INNER JOIN DIGCON ON DIC_MOVDET = DET.AUTOINCREM ';
  Result := Result + '   LEFT JOIN CADFIS ';
  Result := Result + '     ON DET_NUMDOC = FIS_NUMDOC ';
  Result := Result + '     AND DET_ESPDOC = FIS_ESPDOC ';
  Result := Result + '     AND DET_CODEMP = FIS_CODEMP ';
  Result := Result + '     AND DET_CODFOR = FIS_FORCLI ';
  Result := Result + '     AND IFNULL(DET_SERIE_, "") = FIS_SERIE_ ';
  Result := Result + '     AND DET_TIP_FC = FIS_TIP_FC ';
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = MOV.GER_CODFOR ';
  Result := Result + '   LEFT JOIN CADCFO  ON CFO_CODCFO = DET.DET_CLAFIS ';

//  If fCfgSis('OUSAFO', varString) = '2' Then
//  Begin
//    Result := Result + '   LEFT JOIN ESPDET AS ED ON ED.DET_SEQDET = DET.AUTOINCREM ';
//    Result := Result + '   LEFT JOIN ESPGER AS EG ';
//    Result := Result + '     ON ED.DET_SEQGER = EG.AUTOINCREM ';
//    Result := Result + '     AND GER_MOVGER IS NULL ';
//    Result := Result + '     AND IF( ';
//    Result := Result + '       DET.DET_TIP_FC = "C", ';
//    Result := Result + '       EG.GER_CODCLI = DET.DET_CODCLI, ';
//    Result := Result + '       EG.GER_CODFOR = DET.DET_CODFOR ';
//    Result := Result + '     ) ';
//  End;
//
//  Result := Result + '   LEFT JOIN DEVVEN DD  ';
//  Result := Result + '         ON DD.DEV_SEQDET = DET.AUTOINCREM ';

  Result := Result + ' WHERE MOV.GER_CODEMP = :CODEMP ';
  Result := Result + ' AND MOV.GER_DTAENT IS NOT NULL ';


  Result := Result + '   AND (IFNULL(DIC_QTDDEV, 0) - IFNULL((SELECT SUM(DEV_QTDBAI) FROM DEVVEN WHERE DEV_SEQDET = DET.AUTOINCREM),0.00)  ';
  If fCfgSis('OUSAFO', varString) = '2' Then
  Begin
    Result := Result + '   -  IFNULL((SELECT';
    Result := Result + '            SUM(IFNULL(ED.DET_QTDITE, 0)) AS ESP_QTDITE';
    Result := Result + '          FROM ESPGER EG ';
    Result := Result + '            INNER JOIN  ESPDET ED';
    Result := Result + '              ON EG.AUTOINCREM = ED.DET_SEQGER';
    Result := Result + '          WHERE ED.DET_SEQDET = DET.AUTOINCREM';
    Result := Result + '            AND EG.GER_MOVGER IS NULL';
    Result := Result + '            AND IF(';
    Result := Result + '              DET.DET_TIP_FC = "C",';
    Result := Result + '              EG.GER_CODCLI = DET.DET_CODCLI,';
    Result := Result + '              EG.GER_CODFOR = DET.DET_CODFOR';
    Result := Result + '            )';
    Result := Result + '          GROUP BY ED.DET_SEQDET),';
    Result := Result + '          0';
    Result := Result + '        )';
  End;

  Result := Result + ') > 0 ';
  If not fEmptyStr(edtFornecedor.Text) Then
    Result := Result + '   AND MOV.GER_CODFOR = "'+edtFornecedor.Text+'" ';

  If (FblnCOFTRA) And (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D') Then
    Result := Result + ' AND (AUXMOV.AUX_ENTSIM = "S" OR GER.GER_DTACON IS NOT NULL)'
  Else If (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D') Then
    Result := Result + ' AND GER.GER_DTACON IS NOT NULL '
  Else If FblnCOFTRA Then
    Result := Result + ' AND (AUXMOV.AUX_ENTSIM = "S" OR GER.AUTOINCREM IS NOT NULL)'
  Else
    Result := Result + ' AND GER.AUTOINCREM IS NOT NULL ';

  if not fEmptyDate(mskDtaIni.text) Then
    Result := Result + '   AND DET.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  Result := Result + ' GROUP BY PRIMARY_KEY ';
  Result := Result + ' ORDER BY DETAIL_KEY ';
end;

function TfrmEntConferPreNotaWMSDevolucao.fConfirmaLiberacaoEnderecamentoSemWms(
  cxProgressBar: TcxProgressBar): Boolean;
  var
    objDevolucaoRetornaEstoque : TDevolucaoRetornaEstoque;
begin
  Result := True;
  fStartTransaction;
  Try
    cdsDados.First;
    While not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('QTDLIB').AsFloat > 0 Then
      Begin
        objDevolucaoRetornaEstoque := TDevolucaoRetornaEstoque.Create(StringParaArray(cdsDados.FieldByName('INCDIGCON').AsString));
        Try
          objDevolucaoRetornaEstoque.AjustarQuantidadeDevolucao(cdsDados.FieldByName('QTDLIB').AsFloat);
          If not objDevolucaoRetornaEstoque.DevolveParaEnderecamento then
          begin
            fRollback;
            pMensagemOk('Houve falhas no processo!');
            Break;
          End
          Else
        Finally
          FreeAndNil(objDevolucaoRetornaEstoque);
        End;
      End;
      cdsDados.Next;
    End;
    fCommit;
  Except
    on e: Exception do
    begin
      fRollback;
      pMensagensErro(e.message, '[TfrmEntConferPreNotaWMSDevolucao.fConfirmaLiberacaoEnderecamentoSemWms]');
    End;
  End;
end;

end.




