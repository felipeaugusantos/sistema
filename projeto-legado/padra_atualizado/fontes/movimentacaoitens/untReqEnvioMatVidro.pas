unit untReqEnvioMatVidro;

interface

uses
  Windows, Classes, Controls, Forms, DateUtils,
  StdCtrls, untPaiSimples, DBGridCitel, DBGrids, EditFocus,
  MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, QColorLabel,
  Uni, untCadLote, UniClientDataSet, untFuncoesSimples,
  BitBtnLockedIncrem, Menus, Mask, Grids, AppEvnts, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog, untAuditoriaGravacaoSaldo;

type
  TfrmReqEnvioMatVidro = class(TfrmPaiSimples)
    pnlItem: TPanel;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    Label10: TLabel;
    lblQuantidade: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    edtQtdIte: TEditFocus;
    edtUnitar: TEditFocus;
    edtTotIte: TEditFocus;
    Label26: TLabel;
    pnlBotoesEnt: TPanel;
    Label8: TLabel;
    edtEntSai: TEditFocus;
    pgbItens: TProgressBar;
    Label11: TLabel;
    lblTipoEntSai: TColorLabel;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtSaldos: TEditFocus;
    lblNumLot: TLabel;
    edtNumLot: TEditFocus;
    dtsRequisicao: TDataSource;
    btnConfirma: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    btnEstLoj: TBitBtnLocked;
    pnlDocumento: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label2: TLabel;
    edtNomCli: TEditFocus;
    Label6: TLabel;
    edtNomVen: TEditFocus;
    Label9: TLabel;
    edtDtaEmi: TEditFocus;
    pnlGrid: TPanel;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgITE_CODITE: TcxGridDBColumn;
    cxgITE_DESITE: TcxGridDBColumn;
    cxgITE_ENTSAI: TcxGridDBColumn;
    cxgITE_REFERE: TcxGridDBColumn;
    cxgITE_CODUNI: TcxGridDBColumn;
    cxgITE_QTDITE: TcxGridDBColumn;
    cxgITE_UNITAR: TcxGridDBColumn;
    cxgITE_TOTITE: TcxGridDBColumn;
    cxgItenslevel: TcxGridLevel;
    pnlDetalhe: TPanel;
    Label32: TLabel;
    edtTotGer: TEditFocus;
    Label3: TLabel;
    edtConPag: TEditFocus;
    Label12: TLabel;
    edtValDoc: TEditFocus;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    lblComPec: TLabel;
    lblLarPec: TLabel;
    lblQtdMadeira: TLabel;
    lblMedCom: TLabel;
    lblMedLar: TLabel;
    edtComPec: TEditFocus;
    edtLarPec: TEditFocus;
    edtQtdPec: TEditFocus;
    btnImportarArqTxt: TBitBtnLocked;
    btnDevEntrada: TBitBtnLocked;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtEntSaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormPaint(Sender: TObject);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnEstLojClick(Sender: TObject);
    procedure dtsRequisicaoDataChange(Sender: TObject; Field: TField);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtEntSaiEnter(Sender: TObject);
    procedure btnImportarArqTxtClick(Sender: TObject);
    procedure btnDevEntradaClick(Sender: TObject);
  private
    { Private declarations }

    objCadLot     : TCadLot;
    cdsRequisicao : TUniClientDataSet;

    strArqMovGer : String;
    strArqMovDet : String;
    blnFecharTela: Boolean;
    strCodDig    : String;
    strTabPre    : String;
    intDecQtd    : Integer;
    dtaDataIni   : TDateTime;
    strNumReq    : String;
    strSeqReq    : String;

    strInfVid: String;
    strInfFer: String;
    strInfAlu: String;
    strObserv: String;
    strObrFin: String;

    fltTotGer: Double;
    fltTotMed: Double;
    fltTotUlt: Double;
    fltTotImp: Double;
    fltTotCus: Double;
    fltTotCu2: Double;

    fltDesOpeCli: Double;

    qryConIte: TUniQuery;

    qryDocumento: TUniQuery;

    blnMetragemObrigatoria: Boolean;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    procedure pMostraLote(blnMostrar: Boolean);

    procedure pImprime(strNumDoc, strEspDoc: String; intQtd: Integer);

    procedure pLimpaDadosItem;
    procedure pCarregaItem(blnBuscaPorChave: Boolean = False);
    procedure pHabilitarMetragem(strCodIte, strCodUni: String);
    procedure pCalculaQuantidadeMetrosCubicos;

    procedure pCalculaTotalItem;

    procedure pAtribuiTabelas;

    procedure pHabilitaDocumento;
    procedure pHabilitaItem;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;

    procedure pDeletaItem;

    procedure pCarregaItensAlteracao;
    procedure pLimparTela;

    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);

    function fConfirmaRequisicao: Boolean;
    function fVerificaQtdEstoque(fltQuantidade: Double; strNumLot: String): Boolean;
    function fRetQtdDigitada(strNumLot: String): Double;

    function fGetStatusItem(strCodIte : String) : String;
    function fGetSqlIteGer : String;

    function fCarregarDocumento: Boolean;
    procedure pCalculaTotalGeral;
    procedure pCarregaDigitador;
    function fPedeInformacoesFechamento: Boolean;
    function fGravaInformacoesFechamento: Boolean;
    function fAtualizaStatusObra: Boolean;
    function fAtualizaCustoVenda: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryConCit: TUniQuery;
    class procedure pAdicionaItem(recItems:TRecItemsEnvioMaterial;cdsRequisicao:TUniClientDataSet; intBtnTag:Integer = 0);
    class procedure pPreencheRecordItemsTemporaria(Var recItems:TRecItemsEnvioMaterial; recParametros :TRecParametrosEnvioMaterial);
  end;

  function fAtualizaCustoVendaVidro(strNumDoc, strEspDoc, strCodEmp: String): Boolean;


implementation

uses SysUtils, Variants, StrUtils, untFuncoes, untPesqAux, untPai, untFuncFat,
  untMovGer, untCadIte, untConsultas, untFatMostraEstoqueEmp, untConstantes,
  untTypesSistema, untReqEnvioMatVidroSelDoc, untReqEnvioSelDocDevolucao,
  untParCalculaPrecoCusto, untCadOpeConfig, untTConfiguracao,
  untReqEnvioMatVidroInf, untPanelCxItem, untImportarListaDeMateriais,
  untPnlDadosItem, untMsgLiberacao, untTFatEntregaFutura, untIFatEntregaFutura,
  untFatImpressao;

{$R *.dfm}

function fAtualizaCustoVendaVidro(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryMovDet: TUniquery;
    qryTotCus: TUniquery;
    qryUpdate: TUniquery;
    fltTotGer: Double;
    fltFatCus: Double;
    strSql   : String;
    strAutInc: String;
begin
  strSql := '';
  strSql := strSql  + 'SELECT   ';
  strSql := strSql  + '  SUM(DET_TOTMED * IF(DET_CLAFIS > "5000", 1, -1)) AS TOTMED, ';
  strSql := strSql  + '  SUM(DET_TOTULT * IF(DET_CLAFIS > "5000", 1, -1)) AS TOTULT, ';
  strSql := strSql  + '  SUM(DET_IMPULT * IF(DET_CLAFIS > "5000", 1, -1)) AS IMPULT, ';
  strSql := strSql  + '  SUM(DET_TOTCUS * IF(DET_CLAFIS > "5000", 1, -1)) AS TOTCUS, ';
  strSql := strSql  + '  SUM(DET_IMPFED * IF(DET_CLAFIS > "5000", 1, -1)) AS IMPFED, ';
  strSql := strSql  + '  SUM(DET_DESOPE * IF(DET_CLAFIS > "5000", 1, -1)) AS DESOPE, ';
  strSql := strSql  + '  SUM(DET_ICMSAI * IF(DET_CLAFIS > "5000", 1, -1)) AS ICMSAI, ';
  strSql := strSql  + '  SUM(DET_OUTVAL * IF(DET_CLAFIS > "5000", 1, -1)) AS OUTVAL, ';
  strSql := strSql  + '  SUM(DET_TOTCU2 * IF(DET_CLAFIS > "5000", 1, -1)) AS TOTCU2  ';
  strSql := strSql  + 'FROM      ';
  strSql := strSql  + '  MOVDET ';
  strSql := strSql  + '  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSql := strSql  + 'WHERE     ';
  strSql := strSql  + '  DET_NUMFAT = "' + strNumDoc + '" AND ';
  strSql := strSql  + '  DET_TIPFAT = "' + strEspDoc + '" AND ';
  strSql := strSql  + '  DET_EMPFAT = "' + strCodEmp + '" AND ';
  strSql := strSql  + '  DET_ESPDOC = "RQ" ';

  qryTotCus := fCriaQuery;

  With qryTotCus, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    Open;
  End;

  strSql := '';
  strSql := strSql  + 'SELECT   ';
  strSql := strSql  + '  MOVDET.AUTOINCREM AS AUTINC, ';
  strSql := strSql  + '  MOVDET.DET_VLRCON AS TOTGER  ';
  strSql := strSql  + 'FROM     ';
  strSql := strSql  + '  MOVDET ';
  strSql := strSql  + '  INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSql := strSql  + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  strSql := strSql  + 'WHERE    ';
  strSql := strSql  + '  DET_NUMDOC = "' + strNumDoc + '" AND ';
  strSql := strSql  + '  DET_ESPDOC = "' + strEspDoc + '" AND ';
  strSql := strSql  + '  DET_CODEMP = "' + strCodEmp + '" AND ';

  strSql := strSql  + '  ((DET_CODITE = ' + QuotedStr(fCfgSis('ITEVID')) + ') OR'
   + ' (DET_CODITE = '+ QuotedStr(fCfgSis('ITESER'))+') OR'
   + ' (DET_CODITE = '+ QuotedStr(fCfgSis('SERTER'))+ ') OR'
   + ' (LOCATE("ITEM ESPECIAL", ITE_DESITE ) > 0)) AND';

  strSql := strSql  + '  LOCATE(DET_CLAFIS, "' + VS_strClaVen + '") AND ';
  strSql := strSql  + '  DET_CLAFIS > "5000"  ';

  qryMovDet := fCriaQuery;

  With qryMovDet, SQL Do
  Begin
    Close;
    Clear;
    Add(strSql);
    Open;

    Result := Not IsEmpty;

    fltTotGer := 0;

    First;
    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('TOTGER').AsFloat;
      Next;
    End;

    First;
    While Not Eof Do
    Begin
      strAutInc := FieldByName('AUTINC').AsString;

      If fltTotGer = 0 Then
        fltFatCus := 0
      Else
        fltFatCus := FieldByName('TOTGER').AsFloat / fltTotGer;

      strSql := '';
      strSql := strSql  + 'UPDATE ';
      strSql := strSql  + '  MOVDET, ';
      strSql := strSql  + '  MOVTRI  ';
      strSql := strSql  + 'SET ';
      strSql := strSql  + '  DET_TOTMED = :TOTMED, ';
      strSql := strSql  + '  DET_TOTULT = :TOTULT, ';
      strSql := strSql  + '  DET_IMPULT = :IMPULT, ';
      strSql := strSql  + '  DET_TOTCUS = :TOTCUS, ';
      strSql := strSql  + '  DET_IMPFED = :IMPFED, ';
      strSql := strSql  + '  DET_ICMSAI = :ICMSAI, ';
      strSql := strSql  + '  DET_DESOPE = :DESOPE, ';
      strSql := strSql  + '  DET_OUTVAL = :OUTVAL, ';
      strSql := strSql  + '  DET_TOTCU2 = :TOTCU2  ';
      strSql := strSql  + 'WHERE    ';
      strSql := strSql  + '  MOVDET.AUTOINCREM = "' + strAutInc + '" AND ';
      strSql := strSql  + '  MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';

      qryUpdate := fCriaQuery;

      qryUpdate.SQL.Add(strSql);

      qryUpdate.ParamByName('TOTMED').AsFloat := qryTotCus.FieldByName('TOTMED').AsFloat * fltFatCus;
      qryUpdate.ParamByName('TOTULT').AsFloat := qryTotCus.FieldByName('TOTULT').AsFloat * fltFatCus;
      qryUpdate.ParamByName('IMPULT').AsFloat := qryTotCus.FieldByName('IMPULT').AsFloat * fltFatCus;
      qryUpdate.ParamByName('TOTCUS').AsFloat := qryTotCus.FieldByName('TOTCUS').AsFloat * fltFatCus;
      qryUpdate.ParamByName('IMPFED').AsFloat := qryTotCus.FieldByName('IMPFED').AsFloat * fltFatCus;
      qryUpdate.ParamByName('ICMSAI').AsFloat := qryTotCus.FieldByName('ICMSAI').AsFloat * fltFatCus;
      qryUpdate.ParamByName('DESOPE').AsFloat := qryTotCus.FieldByName('DESOPE').AsFloat * fltFatCus;
      qryUpdate.ParamByName('OUTVAL').AsFloat := qryTotCus.FieldByName('OUTVAL').AsFloat * fltFatCus;
      qryUpdate.ParamByName('TOTCU2').AsFloat := qryTotCus.FieldByName('TOTCU2').AsFloat * fltFatCus;

      qryUpdate.ExecSQL;

      FreeAndNil(qryUpdate);

      Next;
    End;

  End;

  FreeAndNil(qryMovDet);
  FreeAndNil(qryTotCus);
end;

function TfrmReqEnvioMatVidro.fAtualizaStatusObra: Boolean;
  Var
    qryUpd: TUniQuery;
    strTabAux: String;
    strAutInc: String;
begin
  strTabAux := qryDocumento.FieldByName('TABAUX').AsString;
  strAutInc := qryDocumento.FieldByName('AUTOINCREM').AsString;

  qryUpd := fCriaQuery;

  With qryUpd, SQL Do
  Begin
    Close;
    Clear;

    Add('UPDATE ');
    Add('  ' + strTabAux);
    Add('SET ');
    Add('  AUX_OBRFIN = :OBRFIN ');
    Add('WHERE ');
    Add('  AUX_SEQGER = :AUTINC ');

    ParamByName('OBRFIN').AsString := strObrFin;
    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;

    Close;
    Clear;

    Add('UPDATE ');
    Add('  MOVGER, ');
    Add('  AUXMOV  ');
    Add('SET        ');
    Add('  AUX_OBRFIN = :OBRFIN ');
    Add('WHERE ');
    Add('  AUTOINCREM = AUX_SEQGER AND ');
    Add('  GER_NUMFAT = :NUMFAT    AND ');
    Add('  GER_TIPFAT = :TIPFAT    AND ');
    Add('  GER_EMPFAT = :EMPFAT    AND ');
    Add('  GER_ESPDOC = "RQ" ');

    ParamByName('OBRFIN').AsString := strObrFin;
    ParamByName('NUMFAT').AsString := qryDocumento.FieldByName('NUMDOC').AsString;
    ParamByName('TIPFAT').AsString := qryDocumento.FieldByName('ESPDOC').AsString;
    ParamByName('EMPFAT').AsString := qryDocumento.FieldByName('CODEMP').AsString;

    ExecSQL;
  End;

  FreeAndNil(qryUpd);

  Result := True;
end;

function TfrmReqEnvioMatVidro.fCarregarDocumento: Boolean;
  var
    DespesasOperacionaisComplementar : TDespesasOperacionaisComplementar;
begin
  Result := False;

  With qryDocumento, SQL Do
  Begin
    Close;
    Clear;

    Add(TfrmReqEnvioMatVidroSelDoc.fGetSQLDocumentos(edtNumDoc.Text, edtEspDoc.Text));

    Open;

    If IsEmpty Then
    Begin
      pMensagemOk('Documento não foi encontrado!');
    End
    Else If DaysBetween(VS_Date, FieldByName('DTAFAT').AsDateTime) > fCfgSis('DIAVID', varInteger) Then
    Begin
      pMensagemOk('Documento emitido há mais de ' + fCfgSis('DIAVID') + ' dias, portanto ' +
                  'não será permitido emitir novas requisições!');
    End
    Else If FieldByName('OBRFIN').AsString = 'S' Then
    Begin
      pMensagemOk('Obra já foi finalizada, portanto ' +
                  'não será permitido emitir novas requisições!');
    End
    Else
      Result := True;

    strTabPre := FieldByName('TABPRE').AsString;

    If fEmptyStr(strTabPre) Then
      strTabPre := FieldByName('CLITAB').AsString;

    If fEmptyStr(strTabPre) And fCfgSis('HIETAB', VarBoolean) Then
      strTabPre := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [FieldByName('CODVEN').AsString], False);

    If fEmptyStr(strTabPre) Then
      strTabPre := '1';

    fltDesOpeCli := 0.00;
    DespesasOperacionaisComplementar.SetValue(fCfgSis('CLIDOP', varString));

    If (DespesasOperacionaisComplementar <> docNaoUtilizar) Then
      fltDesOpeCli := FieldByName('CLIDOP').AsFloat;

    edtNomCli.Text := FieldByName('CLIFAT').AsString;
    edtNomVen.Text := FieldByName('VENFAT').AsString;
    edtDtaEmi.Text := FieldByName('DTAFAT').AsString;
    edtConPag.Text := fFormataCondPag(FieldByName('CONPAG').AsString);
    edtValDoc.Text := FormatFloat('#,##0.00', FieldByName('VALFAT').AsFloat);
  End;
end;

procedure TfrmReqEnvioMatVidro.pCarregaDigitador;
  Var
    qryConOpe: TUniQuery;
begin
  qryConOpe := fCriaQuery(nil);
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    strCodDig      := FieldByName('OPE_CODOPE').AsString;
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
  FreeAndNil(qryConOpe);
end;


function TfrmReqEnvioMatVidro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) And pnlDocumento.Enabled Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('','Digite o número do documento !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) And pnlDocumento.Enabled Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
      Begin
        fMensagem('','Digite a espécie do documento !',['&O K']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaCampos(edtNumDoc, blnBuscaPorChave) And fCarregarDocumento;
        If Result then
        Begin
          pHabilitaItem;
          btnDevEntrada.Enabled := True;
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtCodDig) And pnlDigitador.Enabled Then
    Begin

      If fEmptyStr(edtCodDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preeenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaDigitador;

        If fEmptyStr(edtNomDig.text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodIte) And pnlItem.Enabled Then
    Begin

      If (edtCodIte.ReadOnly) Then
      Begin
        Result := False;
      End
      Else If fEmptyStr(edtCodIte.Text) Then
      Begin

        If blnBuscaPorChave Then
        Begin
          blnMudarFoco := False;
          pSetFocus(cxgItens);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Item deve ser preenchido!', ['&O k']);
          Result := False;
        End;

      End
      Else
      Begin

        pCarregaItem(blnBuscaPorChave);

        If fGetStatusItem(edtCodIte.Text) = 'N' Then
        Begin

          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;

        End
        Else If qryConCit.FieldByName('ITE_CODITE').IsNull Then
        Begin

          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
          Result := False;

        End

        Else If qryConCit.FieldByName('ITE_ITEATI').AsString <> 'S' Then
        Begin
          pLimpaDadosItem;
          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;
        End

        Else If (qryConIte.FieldByName('ITE_DTABAL').AsDateTime >= VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido vender um item com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);
          Result := False;
        End;
      End;


    End

    Else If (Sender = edtNumLot) And pnlItem.Enabled Then
    Begin
      If edtNumLot.Visible Then
      Begin
        If fEmptyStr(edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe o número do ' + objCadLot.strTitLab + '!', ['&Ok']);
          Result := False;
        End

        Else If Not objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, edtNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
          Result := False;
        End

        Else
        Begin
          edtSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), objCadLot.qryCadLot.FieldByName('LOT_SALDOS').AsFloat);
        End;

      End;
    End

    Else If (Sender = edtUnidade) And pnlItem.Enabled Then
    Begin

      If fEmptyStr(edtUnidade.Text) Then
      Begin
        Result := False;
        pMensagemOk('Unidade do Produto em branco!');
      End;

    End
    
    Else If (Sender = edtEntSai) And pnlItem.Enabled Then
    Begin

      If (Copy(edtEntSai.Text, 1, 1) <> 'E') And
         (Copy(edtEntSai.Text, 1, 1) <> 'S') Then
      Begin
        Result := False;
      End;

    End

    Else If (Sender = edtQtdPec) And
            (edtQtdPec.Enabled)  And
            (pnlItem.Enabled)    And
            (blnBuscaPorChave)   Then
    Begin
      If (fStrToFloat(edtQtdPec.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
        //If (fControlaDigMetrosCubicos(True)) Then
        //Begin
        //  pSetFocus(edtSubQtdIte);
        //  blnMudarFoco := False;
        //End
        //Else
        //  Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else If (Sender = edtComPec) And
            (edtComPec.Enabled)  And
            (pnlItem.Enabled)    And
            (blnBuscaPorChave)   Then
    Begin
      If fStrToFloat(edtComPec.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O comprimento deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else If (Sender = edtLarPec) And
            (edtLarPec.Enabled)  And
            (pnlItem.Enabled)    And
            (blnBuscaPorChave)   Then
    Begin
      If fStrToFloat(edtLarPec.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Largura deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else If (Sender = edtQtdIte) And (pnlItem.Enabled) And (edtQtdIte.ReadOnly) Then
    Begin
      If fEmptyStr(edtQtdIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtQtdIte.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCalculaTotalItem;
      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;


procedure TfrmReqEnvioMatVidro.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strCliMarcas  : String;
    strForAnt     : String;
    strCodAtu : String;
    intOpcAtivos: Integer;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    strTabPre: String;
begin
  inherited;

  If fEntraCons(Key) And Not edtCodIte.ReadOnly Then
  Begin
    Try
      strTabPre    := '1';
      intOpcAtivos := 0;

      objfrmPnl := TPanelCxItem.New();

      objFrmPnl.strNomForm := Self.Name;
      objFrmPnl.recParametros.strCodCli  := '';
      objFrmPnl.strCodVen  := '';
      objFrmPnl.strCodDig  := '';
      objFrmPnl.intPraMedio:= 0;
      objFrmPnl.recParametros.strTabPre  := '1';

      If fPesqItem(conIteCompleta,
                   Self,
                   Nil,
                   Nil,
                   qryConIte,
                   Key,
                   arrSel,
                   True,
                   objfrmPnl,
                   'Consulta de Itens',
                   strTabPre,
                   '',
                   0,
                   false,
                   false,
                   intOpcAtivos) Then

      Begin

        edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
        strCodAtu      := qryConIte.FieldByName('ITE_CODITE').AsString;
        pCarregaItem;
        {*******************************************************}
        {* VALIDA MARCAS CADASTRADAS NOS VENDEDORES DO CLIENTE *}
        {****************************************************IV*}
        If (Not fEmptyStr(strCliMarcas)) And (Pos(qryConIte.FieldByName('ITE_CODMAR').AsString, strCliMarcas) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Item com Marca não permitida para este vendedor informado. Verifique!', ['&O k']);
        End
        Else
        Begin
          edtCodIte.Text := qryConIte.FieldByName('ITE_CODITE').AsString;
          SelectNext(ActiveControl, True, True);
        End;

      End;

      Self.Name := strForAnt;

      Key := #0;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

procedure TfrmReqEnvioMatVidro.pCarregaItem(blnBuscaPorChave: Boolean = False);
  Var
    blnBuscaCodBar: Boolean;
begin
  blnBuscaCodBar := True;

  If (Length(Trim(edtCodIte.Text)) <= fTamCodIte) Then
  Begin
    edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    blnBuscaCodBar := False;
  End;

  pPesquisaCadIte(qryConCit, qryConCit, edtCodIte.Text, '',  blnBuscaCodBar);
  With qryConCit Do
  Begin

    If blnBuscaCodBar Then
      edtCodIte.Text := qryConCit.FieldByName('ITE_CODITE').AsString;

    edtDesIte.Text  := qryConCit.FieldByName('ITE_DESITE').AsString;

    edtRefere.Text  := qryConCit.FieldByName('ITE_REFERE').AsString;
    edtUnidade.Text := qryConCit.FieldByName('ITE_CODUNI').AsString;

    If fEmptyStr(edtQtdIte.Text) Then
      edtQtdIte.Text := '0,00';

    pHabilitarMetragem(qryConCit.FieldByName('ITE_CODITE').AsString,
                       qryConCit.FieldByName('ITE_CODUNI').AsString);

    If edtQtdPec.Enabled And blnBuscaPorChave Then
      edtQtdIte.Text := '0,00';
  End;

  If Not (qryConCit.IsEmpty) Then
  Begin

    With qryConIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(fGetSqlIteGer);
      ParamByName('CODITE').AsString := qryConCit.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      {********************************}
      {* CARREGA O SALDO              *}
      {*****************************JB*}
      If fUsaQtdPendenteEntregaFutura Then
        edtSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat  +
                                                   TEntregaFutura.New(
                                                     TParamEF.New()
                                                       .CodIte(edtCodIte.Text)
                                                       .CodEmp(VS_strCodEmp)
                                                       .TipoTE(tteTodas)
                                                     ).Total())
      Else
        edtSaldos.Text  := FormatFloat(fMskDigitos(intDecQtd), FieldByName('ITE_SALDOS').AsFloat );

      {********************************}
      {* TRAVA ITEM FRACIONADO OU NAO *}
      {*****************************AF*}
      If Not fItemFracionado(qryConCit.FieldByName('ITE_CODUNI').AsString) Then
      Begin
        edtQtdIte.OnKeyPress := pTravaItemFracionadoKey;
        edtQtdPec.OnKeyPress := pTravaItemFracionadoKey;
        edtComPec.OnKeyPress := pTravaItemFracionadoKey;
        edtLarPec.OnKeyPress := pTravaItemFracionadoKey;
      End
      Else
      Begin
        edtQtdIte.OnKeyPress := Nil;
        edtQtdPec.OnKeyPress := Nil;
        edtComPec.OnKeyPress := Nil;
        edtLarPec.OnKeyPress := Nil;
      End;

      edtUnitar.Text := FloatToStrF(qryConIte.FieldByName('ITE_PREVE' + strTabPre).AsFloat, ffFixed, 12, 2);

      pCalculaTotalItem;

    End;

  End
  Else
  Begin

    qryConIte.Close;

  End;

  pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, '', False));

end;

procedure TfrmReqEnvioMatVidro.pAtribuiTabelas;
begin
  qryConCit := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConIte := fCriaQuery(Self);// IteGer(Self);
end;

procedure TfrmReqEnvioMatVidro.pMostraLote(blnMostrar: Boolean);
Begin
  lblNumLot.Visible := blnMostrar;
  edtNumLot.Visible := blnMostrar;
End;

class procedure TfrmReqEnvioMatVidro.pPreencheRecordItemsTemporaria(Var recItems:TRecItemsEnvioMaterial;
recParametros :TRecParametrosEnvioMaterial);

  function fGetSqlIteGer: String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  G.*, ';
    Result := Result + '  C.*  ';
    Result := Result + 'FROM ';
    Result := Result + '  ITEGER G ';
    Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
    Result := Result + 'WHERE ';
    Result := Result + '  G.ITE_CODITE = :CODITE AND ';
    Result := Result + '  G.ITE_CODEMP = :CODEMP ';
  end;

  Var
  parPreCus: TParCalculaPrecoCusto;
  qryConIte: TUniQuery;
begin

  qryConIte := fCriaQuery(Nil);
  With qryConIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSqlIteGer);
    ParamByName('CODITE').AsString := recParametros.strCodIte;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  With recParametros Do
  Begin
    recItems.strCodIte := qryConIte.FieldByName('ITE_CODITE').AsString;
    recItems.strDesIte := qryConIte.FieldByName('ITE_DESITE').AsString;;
    recItems.strRefere := qryConIte.FieldByName('ITE_REFERE').AsString;;
    recItems.strEntSai := strEntSai;
    recItems.strCodUni := qryConIte.FieldByName('ITE_CODUNI').AsString;;

    recItems.fltIteSaldos := fltSaldos;
    recItems.fltIteQtdIte := fltQtdIte;


    recItems.strCodFor := qryConIte.FieldByName('ITE_CODFOR').AsString;
    recItems.strIncPis := qryConIte.FieldByName('ITE_INCPIS').AsString;
    recItems.strCodMar := qryConIte.FieldByName('ITE_CODMAR').AsString;
    recItems.strCodGru := qryConIte.FieldByName('ITE_CODGRU').AsString;

    If (fltQtdPec > 0) Then
      recItems.fltIteQtdPec := fltQtdPec
    Else
      recItems.fltIteQtdPec := 0;

    If (fltComPec > 0) Then
      recItems.fltIteComPec := fltComPec
    Else
      recItems.fltIteComPec := 0;

    If fltLarPec > 0 Then
      recItems.fltIteLarPec :=  fltLarPec
    Else
      recItems.fltIteLarPec := 0;


    recItems.fltIteUnitar :=  fltUnitar;
    recItems.fltTotIte := fltTotIte;
    recItems.strNumLot := strNumLote;
    recItems.fltPrecus := qryConIte.FieldByName('ITE_PRECUS').AsFloat;
    recItems.fltImpFed := qryConIte.FieldByName('ITE_IMPFED').AsFloat;
    recItems.fltOutVal := qryConIte.FieldByName('ITE_OUTVAL').AsFloat;
    recItems.fltDesOpe := qryConIte.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeCli;
    recItems.fltIcmSai := IIF(fCfgSis('IMPCF4', varBoolean), 0.00, qryConIte.FieldByName('ITE_ICMSAI').AsFloat);


    parPreCus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

    recItems.fltPrecu2 := parPreCus.fCalculaPrecoCustoRealVenda(recItems.fltIteUnitar,
                                                                recItems.fltPrecus,
                                                                recItems.fltOutVal,
                                                                recItems.fltIcmSai,
                                                                recItems.fltImpFed,
                                                                recItems.fltDesOpe,
                                                                0,
                                                                0);
    FreeAndNil(parPreCus);

    recItems.fltTotCus :=  recItems.fltPrecus * fltQtdIte;
    recItems.fltTotCu2 :=  recItems.fltPrecu2 * fltQtdIte;

    recItems.fltTotMed :=  qryConIte.FieldByName('ITE_PREMED').AsFloat * fltQtdIte;
    recItems.fltTotUlt :=  qryConIte.FieldByName('ITE_PREULT').AsFloat * fltQtdIte;
    recItems.fltTotImp :=  qryConIte.FieldByName('ITE_PREULT').AsFloat * fltQtdIte;
  End;
  FreeAndNil(qryConIte);
end;

procedure TfrmReqEnvioMatVidro.FormCreate(Sender: TObject);
begin
  inherited;
  intDecQtd  := fCfgSis('DECQTD', varInteger);
  dtaDataIni := VS_Date - fCfgSis('DIAVID', varInteger);

  qryDocumento := fCriaQuery;

  cdsRequisicao := Nil;

  objCadLot := TCadLot.Create(Self);
  pMostraLote(False);

  blnFecharTela := False;

  pAtribuiTabelas;

  pHabilitaDocumento;

  pCriaTemporaria;

  strInfVid := '';
  strInfFer := '';
  strInfAlu := '';
  strObserv := '';
  strObrFin := 'N';

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

procedure TfrmReqEnvioMatVidro.pCalculaTotalItem;
begin
  edtQtdIte.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text), ffFixed, 12, intDecQtd);

  If fEmptyStr(edtUnitar.Text) Then
    edtUnitar.Text := '0,0000';

  edtTotIte.Text := FloatToStrF(fStrToFloat(edtQtdIte.Text) * fStrToFloat(edtUnitar.Text), ffFixed, 12, 2);
end;

procedure TfrmReqEnvioMatVidro.pLimpaDadosItem;
  Var
    intContador: Integer;
    edtTemp: TEdit;
    lblTemp: TLabel;
begin
  For intContador := 0 To pnlItem.ControlCount -1 Do
  Begin

    If (pnlItem.Controls[intContador] Is TEdit) Then
    Begin
      edtTemp := (pnlItem.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlItem.Controls[intContador] Is TLabel) Then
    Begin
      lblTemp := (pnlItem.Controls[intContador] As TLabel);

      If lblTemp.Tag = 99 Then
        lblTemp.Caption := '';

    End;

  End;

  edtCodIte.Enabled := True;
  edtEntSai.Text    := 'S';

  pMostraLote(False);
  pHabilitarMetragem('', '');
end;

procedure TfrmReqEnvioMatVidro.pHabilitaDocumento;
begin
  pnlDocumento.Enabled := True;
  pnlDigitador.Enabled := False;
  pnlItem.Enabled      := False;
  pnlGrid.Enabled      := False;
  btnConfirma.Enabled  := False;
  btnEstLoj.Enabled    := False;
  pSetFocus(edtNumDoc);
end;

procedure TfrmReqEnvioMatVidro.pHabilitaItem;
begin
  pnlDocumento.Enabled := False;
  pnlDigitador.Enabled := True;
  pnlItem.Enabled      := True;
  pnlGrid.Enabled      := True;
  btnConfirma.Enabled  := True;
  btnEstLoj.Enabled    := True;
  pSetFocus(edtCodDig);
end;

procedure TfrmReqEnvioMatVidro.pHabilitarMetragem(strCodIte, strCodUni: String);
begin
  blnMetragemObrigatoria := fMetragemObrigatoria(strCodUni);

  If fEhItemVendaVidro(strCodIte) Then
    blnMetragemObrigatoria := False;

  edtQtdPec.Enabled  := blnMetragemObrigatoria;
  edtComPec.Enabled  := blnMetragemObrigatoria;
  edtLarPec.Enabled  := blnMetragemObrigatoria;
  edtQtdIte.ReadOnly := blnMetragemObrigatoria;

  If Not blnMetragemObrigatoria Then
  Begin
    edtQtdPec.Text := '0,00000';
    edtComPec.Text := fFormataCasaDecimalVIDRO('0,00000');
    edtLarPec.Text := fFormataCasaDecimalVIDRO('0,00000');
    lblQtdMadeira.Caption := '';
    lblQuantidade.Caption := 'Quantidade:';
  End
  Else
  Begin
    lblQtdMadeira.Caption := 'Quantidade:';
    lblQuantidade.Caption := 'Área M²:';
  End;
end;

procedure TfrmReqEnvioMatVidro.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
  edtCodIte.Enabled := True;
  pSetFocus(edtCodIte);
  btnAdicionar.Tag := 0;
end;

function TfrmReqEnvioMatVidro.fRetQtdDigitada(strNumLot: String): Double;
  Var
    intRecNo: Integer;
begin

  Result := 0.0;

  With cdsRequisicao Do
  Begin

    DisableControls;

    intRecNo := RecNo;
    First;

    While Not Eof Do
    Begin
      If (FieldByName('ITE_CODITE').AsString = edtCodIte.Text) And
          SameText(FieldByName('ITE_NUMLOT').AsString, strNumLot) Then
        Result := Result + FieldByName('ITE_QTDITE').AsFloat;
      Next;
    End;

    RecNo := intRecNo;

    EnableControls;
  End;

end;

function TfrmReqEnvioMatVidro.fVerificaQtdEstoque(fltQuantidade: Double; strNumLot: String): Boolean;
  Var
    strNTrava: String;
    fltSaldos: Double;
    objMsg : TMensagemLiberacao;

begin

  Result    := True;

  If edtEntSai.Text = 'E' Then
  Begin
    Exit;
  End;

  If (fltQuantidade <= 0.0) Then
  Begin
    Result := False;
    Exit;
  End;

  If fEmptyStr(strNumLot) Then
    fltSaldos := qryConIte.FieldByName('ITE_SALDOS').AsFloat
  Else
    fltSaldos := objCadLot.fSaldoLote(qryConIte.FieldByName('ITE_CODITE').AsString,
                                      VS_strCodEmp, strNumLot);

  fltQuantidade := fltQuantidade + fRetQtdDigitada(strNumLot);

  If btnAdicionar.Tag > 0 Then
    fltQuantidade := fltQuantidade - cdsRequisicao.FieldByName('ITE_QTDITE').AsFloat;

  If (Pos(fCfgSis('SLD_VN'), 'AT') > 0) Then
  Begin

    If Pos('ITEM ESPECIAL', qryConCit.FieldByName('ITE_DESITE').AsString) > 0 Then
    Begin
      Exit;
    End;

    If fltQuantidade > fltSaldos Then
    Begin
      If (fCfgSis('SLD_VN') = 'T') Then
      Begin
        objMsg := TMensagemLiberacao.Create(Self);
        try
          objMsg.pAddTexto('Este produto não possui saldo suficiente!');
          If (Not fSenhaLiberacaoSemSaldoVN(strCodDig, strCodDig, strNtrava, Nil,
            objMsg, '', TRUE, 'RQ')) Then
          Begin
            Result := False;
            pSetFocus(edtCodIte);
            Exit;
          End;
        finally
          FreeAndNil(objMsg);
        end;
      End;
    End;

  End;

end;

procedure TfrmReqEnvioMatVidro.btnAdicionarClick(Sender: TObject);
  Var
    recItems: TRecItemsEnvioMaterial;
    recParametros:TRecParametrosEnvioMaterial;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If Not fVerificaQtdEstoque(fStrToFloat(edtQtdIte.Text), edtNumLot.Text) Then
      Exit;

    With recParametros Do
    Begin
       strCodIte := edtCodIte.Text;
       strEntSai := edtEntSai.Text;
       fltSaldos := fStrToFloat(edtSaldos.Text);
       fltQtdIte := fStrToFloat(edtQtdIte.Text);
       fltQtdPec := fStrToFloat(edtQtdPec.Text);
       fltComPec := fStrToFloat(edtComPec.Text);
       fltLarPec := fStrToFloat(edtLarPec.Text);
       fltUnitar := fStrToFloat(edtUnitar.Text);
       fltTotIte := fStrToFloat(edtTotIte.Text);
       strNumLote:= edtNumLot.Text;
       fltDesOpeCli:= fltDesOpeCli;
    End;

    pPreencheRecordItemsTemporaria(recItems,recParametros);
    pAdicionaItem(recItems,cdsRequisicao,btnAdicionar.Tag);

    pCalculaTotalGeral;
    btnCancelaItem.Click;
  End;
end;

procedure TfrmReqEnvioMatVidro.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlDigitador) Then
  Begin
    btnCancelaItem.Click;
    pLimparTela;
  End
  Else If (ActiveControl.Parent = pnlItem) Then
  Begin
    If (edtCodIte.Focused) Then
    Begin
      btnCancelaItem.Click;
      pSetFocus(edtCodDig);
    End
    Else
      btnCancelaItem.Click;
  End
  Else If (ActiveControl.Parent = pnlDocumento) Then
  Begin
    inherited;
  End;
end;

procedure TfrmReqEnvioMatVidro.dtsRequisicaoDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnEstLoj.Enabled := (cdsRequisicao.Active) and (not fEmptyStr(cdsRequisicao.FieldByName('ITE_CODITE').AsString));

end;

procedure TfrmReqEnvioMatVidro.pCriaTemporaria;
begin
  cdsRequisicao := TUniClientDataSet.Create(Owner);
  dtsRequisicao.DataSet := cdsRequisicao;

  With cdsRequisicao, FieldDefs Do
  Begin
    AggregatesActive := True;

    With AddFieldDef Do Begin Name := 'ITE_CODITE'; DataType := ftString; Size := fTamCodIte; End;
    With AddFieldDef Do Begin Name := 'ITE_CODGRU'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_DESITE'; DataType := ftString; Size := 057; End;
    With AddFieldDef Do Begin Name := 'ITE_NUMLOT'; DataType := ftString; Size := 030; End;
    With AddFieldDef Do Begin Name := 'ITE_REFERE'; DataType := ftString; Size := 016; End;
    With AddFieldDef Do Begin Name := 'ITE_CODMAR'; DataType := ftString; Size := 006; End;
    With AddFieldDef Do Begin Name := 'ITE_ENTSAI'; DataType := ftString; Size := 001; End;
    With AddFieldDef Do Begin Name := 'ITE_CODUNI'; DataType := ftString; Size := 002; End;
    With AddFieldDef Do Begin Name := 'ITE_CODFOR'; DataType := ftString; Size := 008; End;
    With AddFieldDef Do Begin Name := 'ITE_INCPIS'; DataType := ftString; Size := 001; End;
    With AddFieldDef Do Begin Name := 'ITE_SALDOS'; DataType := ftFloat;   End; //12,2
    With AddFieldDef Do Begin Name := 'ITE_SALDIS'; DataType := ftFloat;   End; //12,2
    With AddFieldDef Do Begin Name := 'ITE_QTDITE'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_QTDPEC'; DataType := ftFloat;   Required := False; End; //(12,05)
    With AddFieldDef Do Begin Name := 'ITE_COMPEC'; DataType := ftFloat;   Required := False; End; //(12,05)
    With AddFieldDef Do Begin Name := 'ITE_LARPEC'; DataType := ftFloat;   Required := False; End; //(12,05)
    With AddFieldDef Do Begin Name := 'ITE_UNITAR'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTITE'; DataType := ftFloat;   End; //12,2
    With AddFieldDef Do Begin Name := 'ITE_PRECUS'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_PRECU2'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTCUS'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTCU2'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_ICMSAI'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_DESOPE'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_IMPFED'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_OUTVAL'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTMED'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTULT'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'ITE_TOTIMP'; DataType := ftFloat;   End; //12,4
    With AddFieldDef Do Begin Name := 'AUTOINCREM'; DataType := ftAutoInc; End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTITE';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTITE)';
      Active        := True;
    End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTMED';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTMED)';
      Active        := True;
    End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTULT';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTULT)';
      Active        := True;
    End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTIMP';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTIMP)';
      Active        := True;
    End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTCUS';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTCUS)';
      Active        := True;
    End;

    With TAggregateField.Create(cdsRequisicao) Do
    Begin
      FieldName     := 'TOT_TOTCU2';
      DataSet       := cdsRequisicao;
      DisplayFormat := '#,##0.00';
      Alignment     := taRightJustify;
      Expression    := 'SUM(ITE_TOTCU2)';
      Active        := True;
    End;

    CreateDataSet;

    Open;

    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(intDecQtd);
    (FieldByName('ITE_QTDPEC') As TFloatField).DisplayFormat := fMskDigitos(5);
    (FieldByName('ITE_COMPEC') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO(fMskDigitos(5));
    (FieldByName('ITE_LARPEC') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO(fMskDigitos(5));
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
  End;

  pSetaClient(cdsRequisicao);

end;

procedure TfrmReqEnvioMatVidro.pDeletaTemporaria;
begin
  If Assigned(cdsRequisicao) And cdsRequisicao.Active Then
    cdsRequisicao.EmptyDataSet;
end;

procedure TfrmReqEnvioMatVidro.pCarregaItensAlteracao;
begin

  With cdsRequisicao Do
  Begin

    If Not Active Then
    Begin
      If edtCodIte.Enabled Then
        pSetFocus(edtCodIte);

      Exit;
    End;

    If IsEmpty Then
    Begin
      If edtCodIte.Enabled Then
        pSetFocus(edtCodIte);

      Exit;
    End;

    {********************************}
    {* TRAVA ITEM FRACIONADO OU NAO *}
    {*****************************AF*}
    If Not fItemFracionado(FieldByName('ITE_CODUNI').AsString) Then
    Begin
      edtQtdIte.OnKeyPress := pTravaItemFracionadoKey;
      edtQtdPec.OnKeyPress := pTravaItemFracionadoKey;
      edtComPec.OnKeyPress := pTravaItemFracionadoKey;
      edtLarPec.OnKeyPress := pTravaItemFracionadoKey;
    End
    Else
    Begin
      edtQtdIte.OnKeyPress := Nil;
      edtQtdPec.OnKeyPress := Nil;
      edtComPec.OnKeyPress := Nil;
      edtLarPec.OnKeyPress := Nil;
    End;

    edtCodIte.Text  := FieldByName('ITE_CODITE').AsString;
    edtDesIte.Text  := FieldByName('ITE_DESITE').AsString;
    edtRefere.Text  := FieldByName('ITE_REFERE').AsString;
    edtUnidade.Text := FieldByName('ITE_CODUNI').AsString;
    edtSaldos.Text  := FloatToStrF(FieldByName('ITE_SALDOS').AsFloat, ffFixed, 12, intDecQtd);
    edtEntSai.Text  := FieldByName('ITE_ENTSAI').AsString;
    edtQtdIte.Text  := FloatToStrF(FieldByName('ITE_QTDITE').AsFloat, ffFixed, 12, intDecQtd);
    edtQtdPec.Text  := FloatToStrF(FieldByName('ITE_QTDPEC').AsFloat, ffFixed, 12, 5);
    edtComPec.Text  := FloatToStrF(FieldByName('ITE_COMPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO('5'),0));
    edtLarPec.Text  := FloatToStrF(FieldByName('ITE_LARPEC').AsFloat, ffFixed, 12, StrToIntDef(fFormataCasaDecimalVIDRO('5'),0));
    edtUnitar.Text  := FloatToStrF(FieldByName('ITE_UNITAR').AsFloat, ffFixed, 12, 4);
    edtTotIte.Text  := FloatToStrF(FieldByName('ITE_TOTITE').AsFloat, ffFixed, 12, 2);

    edtNumLot.Text  := FieldByName('ITE_NUMLOT').AsString;

    objCadLot.strLotAnt := FieldByName('ITE_NUMLOT').AsString;

    {*****************************************}
    {* ATRIBUI O AUTO INCREMENTO DO REGISTRO *}
    {* QUE SERÁ USADO COMO CHAVE PARA A ALTE-*}
    {* RAÇÃO                                 *}
    {**************************************MV*}
    btnAdicionar.Tag   := FieldByName('AUTOINCREM').AsInteger;

    edtCodIte.Enabled  := False;
    pSetFocus(edtEntSai);

    pHabilitarMetragem(edtCodIte.Text, edtUnidade.Text);
  End;

  pMostraLote(objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, '', False));

end;

class procedure TfrmReqEnvioMatVidro.pAdicionaItem(recItems:TRecItemsEnvioMaterial;cdsRequisicao:TUniClientDataSet; intBtnTag:Integer = 0);
begin
  With cdsRequisicao, recItems Do
  Begin
    If intBtnTag <= 0 Then
      Append
    Else
      Edit;

    FieldByName('ITE_CODITE').AsString := strCodIte;
    FieldByName('ITE_CODGRU').AsString := strCodGru;
    FieldByName('ITE_DESITE').AsString := strDesIte;
    FieldByName('ITE_REFERE').AsString := strRefere;
    FieldByName('ITE_CODMAR').AsString := strCodMar;
    FieldByName('ITE_ENTSAI').AsString := strEntSai;
    FieldByName('ITE_CODUNI').AsString := strCodUni;
    FieldByName('ITE_CODFOR').AsString := strCodFor;
    FieldByName('ITE_INCPIS').AsString := strIncPis;
    FieldByName('ITE_SALDOS').AsFloat  := fltIteSaldos;
    FieldByName('ITE_SALDIS').AsFloat  := fRetornaSaldoDisponivel(strCodIte);
    FieldByName('ITE_QTDITE').AsFloat  := fltIteQtdIte;

    If fltIteQtdPec > 0 Then
      FieldByName('ITE_QTDPEC').AsFloat := fltIteQtdPec
    Else
      FieldByName('ITE_QTDPEC').AsFloat := 0;

    If fltIteComPec > 0 Then
      FieldByName('ITE_COMPEC').AsFloat := fltIteComPec
    Else
      FieldByName('ITE_COMPEC').AsFloat := 0;

    If fltIteLarPec > 0 Then
      FieldByName('ITE_LARPEC').AsFloat := fltIteLarPec
    Else
      FieldByName('ITE_LARPEC').AsFloat := 0;

    FieldByName('ITE_UNITAR').AsFloat  := fltIteUnitar;
    FieldByName('ITE_TOTITE').AsFloat  := fltTotIte;
    FieldByName('ITE_NUMLOT').AsString := strNumLot;

    FieldByName('ITE_PRECUS').AsFloat  := fltPrecus;
    FieldByName('ITE_IMPFED').AsFloat  := fltImpFed;
    FieldByName('ITE_OUTVAL').AsFloat  := fltOutVal;
    FieldByName('ITE_DESOPE').AsFloat  := fltDesOpe;
    FieldByName('ITE_ICMSAI').AsFloat  := fltIcmSai;

    FieldByName('ITE_PRECU2').AsFloat  := fltPrecu2;
    FieldByName('ITE_TOTCUS').AsFloat  := fltTotCus;
    FieldByName('ITE_TOTCU2').AsFloat  := fltTotCu2;

    FieldByName('ITE_TOTMED').AsFloat  := fltTotMed;
    FieldByName('ITE_TOTULT').AsFloat  := fltTotUlt;
    FieldByName('ITE_TOTIMP').AsFloat  := fltTotImp;

    Post;
  End;
end;

procedure TfrmReqEnvioMatVidro.pDeletaItem;
begin
  If Not cdsRequisicao.IsEmpty then
    cdsRequisicao.Delete;
  pCalculaTotalGeral;
end;

procedure TfrmReqEnvioMatVidro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryDocumento);
  pDeletaTemporaria;
  inherited;
end;

function TfrmReqEnvioMatVidro.fConfirmaRequisicao: Boolean;
  Var
    strClaFis   : String;
    strAutIncTmp: String;
    strAutIncDet: String;
    recMadeira  : TDadosMadeira;
    recServicos : TDadosServicos;
    arrDuplic   : TarrDuplicata;
    strCodErrosAuditoria: String;
begin
  strArqMovGer := 'MOVGER';
  strArqMovDet := 'MOVDET';

  objAuditoriaSaldo.Limpar;

  fStartTransaction;

  Try

    pgbItens.Visible := True;
    pgbItens.Max     := cdsRequisicao.RecordCount;

    strNumReq := fRetSequencial('PRO_RQ', VS_strCodEmp, fTamDocCadRec);

    If fEmptyStr(strCodDig) Then
       strCodDig := strLoginUsuarioLogado;

    FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

    {****************}
    {* GRAVA MOVGER *}
    {*************MV*}
    Result := fGravaMovGer(strSeqReq,                                                     // Auto Incremento (Retorno)
                           strNumReq,                                                     // Numero Documento
                           'RQ',                                                          // Espécie
                           VS_strCodEmp,                                                  // Empresa
                           '',                                                            // Transportadora
                           qryDocumento.FieldByName('CODVEN').AsString,                   // Vendedor
                           '',                                                            // Fornecedor
                           qryDocumento.FieldByName('CODCLI').AsString,                   // Cliente
                           'C',                                                           // Tipo ((C)liente / (F)ornecedor)
                           VS_DATE,                                                       // Data da Entrada
                           fTime(),                                                       // Hora da Entrada
                           VS_Date,                                                       // Data do Documento
                           '01000',                                                       // Condição de Pagamento
                           '',                                                            // Estado do Cliente / Fornecedor
                           qryDocumento.FieldByName('NOMCON').AsString,                   // Nome do Consumidor
                           qryDocumento.FieldByName('ENDCON').AsString,                   // Endereço do Consumidor
                           qryDocumento.FieldByName('BAICON').AsString,                   // Bairro do Consumidor
                           qryDocumento.FieldByName('CEPCON').AsString,                   // Cep do Consumidor
                           qryDocumento.FieldByName('CIDCON').AsString,                   // Cidade do Consumidor
                           qryDocumento.FieldByName('ESTCON').AsString,                   // Estado do Consumidor
                           qryDocumento.FieldByName('TELCON').AsString,                   // Telefone do Consumidor
                           qryDocumento.FieldByName('NASCON').AsDateTime,                 // Nascimento do Consumidor
                           qryDocumento.FieldByName('CGCCPF').AsString,                   // CNPJ / CGC
                           qryDocumento.FieldByName('CGCCON').AsString,                   // CNPJ / CGC do consumidor
                           qryDocumento.FieldByName('IESCON').AsString,                   // Inscrição estadual do Consumidor
                           qryDocumento.FieldByName('R_GCON').AsString,                   // RG do consumidor
                           0.0,                                                           // Base Simples Paulista
                           0.0,                                                           // Base de IPI
                           0.0,                                                           // Aliquota de IPI
                           0.0,                                                           // Total de IPI
                           0.0,                                                           // Base de ICMS
                           0.0,                                                           // Aliquota de ICMS
                           0.0,                                                           // Total de ICMS
                           0.0,                                                           // Valor de Substituição
                           0.0,                                                           // Aliquota de Substituição
                           0.0,                                                           // Base de Substituição
                           0.0,                                                           // Base de Substituição Simulada
                           0.0,                                                           // Desconto Especial
                           Abs(fltTotGer),                                                // Valor Contábil
                           Abs(fltTotGer),                                                // Total dos Itens
                           Abs(fltTotCus),                                                // Total de Custo
                           Abs(fltTotMed),                                                // Total Médio
                           '',                                                            // Tipo de Frete
                           0.0,                                                           // Valor do Frete
                           0.0,                                                           // Peso Bruto
                           0.0,                                                           // Peso Liquido
                           0.0,                                                           // Volume
                           '',                                                            // Especie
                           '',                                                            // Marca
                           qryDocumento.FieldByName('MEN001').AsString,                   // Mensagem 1
                           qryDocumento.FieldByName('MEN002').AsString,                   // Mensagem 2
                           '',                                                            // Mensagem 3
                           '',                                                            // Mensagem 4
                           '',                                                            // Mensagem 5

                           True,                                                          // Indica se ja esta Faturado
                           qryDocumento.FieldByName('ESPDOC').AsString,                   // Tipo de Faturamento
                           qryDocumento.FieldByName('NUMDOC').AsString,                   // Numero de Faturamento
                           qryDocumento.FieldByName('CODEMP').AsString,                   // Empresa dd Faturamento
                           qryDocumento.FieldByName('DTAENT').AsDateTime,                 // Data de Faturamento
                           qryDocumento.FieldByName('CODVEN').AsString,                   // Vendedor do Faturamento
                           qryDocumento.FieldByName('CONPAG').AsString,                   // Condição de Pagamento do Faturamento
                           False,                                                         // Devolução Especial
                           qryDocumento.FieldByName('VLRCON').AsFloat,                    // Valor do Faturamento

                           0.0,                                                           // Valor Parcela 01
                           0.0,                                                           // Valor Parcela 02
                           0.0,                                                           // Valor Parcela 03
                           0.0,                                                           // Valor Parcela 04
                           0.0,                                                           // Valor Parcela 05
                           0.0,                                                           // Valor Parcela 06
                           0.0,                                                           // Valor Parcela 07
                           0.0,                                                           // Valor Parcela 08
                           0.0,                                                           // Valor Parcela 09
                           0.0,                                                           // Valor Parcela 10
                           0.0,                                                           // Valor Parcela 11
                           0.0,                                                           // Valor Parcela 12
                           arrDuplic,
                           '',                                                            // Série
                           'N',                                                           // Nota Especial
                           '9999',                                                        // Classificação Fiscal 1
                           '',                                                            // Classificação Fiscal 2
                           '',                                                            // Classificação Fiscal 3
                           '',                                                            // Natureza da Operação
                           0.0,                                                           // Percentual de Desconto
                           strCodDig,                                                     // Codigo do Digitador
                           '',                                                            // Codigo da Condição
                           '',                                                            // Forma de Pagamento
                           0.0,                                                           // Fator para meia nota
                           recServicos,
                           0.0,                                                           // Despesa acessoria
                           '',                                                            // Origem do Documento (V)enda (D)evolução
                           'N',                                                           // Usa controle de entrega
                           '',                                                            // Representante
                           0.0,                                                           // Aliquota do IRPF (SERVIÇO)
                           0.0,                                                           // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Pis (SERVIÇO)
                           0.0,                                                           // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do Cofins (SERVIÇO)
                           0.0,                                                           // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                                           // Aliquota do CSLL (SERVIÇO)
                           0.0,                                                           // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                                           // Valor de IRPF que foi retido
                           0.0,                                                           // Valor de PIS que foi retido
                           0.0,                                                           // Valor de COFINS que foi retido
                           0.0,                                                           // Valor de CSLL que foi retido
                           '',                                                            // Notas de Documentos Acumulados
                           0.0,                                                           // Aliquota do IRPF (PRODUTOS)
                           0.0,                                                           // Aliquota do PIS (PRODUTOS)
                           0.0,                                                           // Aliquota do COFINS (PRODUTOS)
                           0.0,                                                           // Aliquota do CSLL (PRODUTOS)
                           0.0,                                                           // Valor de SERVIÇO que foi retido
                           '',                                                            // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                                           // Percentual da Seguridade Social
                           0.0,                                                           // Valor da Seguridade Social
                           0.0,                                                           // Valor do IRPF Retido (Produto)
                           0.0,                                                           // Valor do IRPF Devido (Produto)
                           0.0,                                                           // Valor do IRPF Retido (Serviço)
                           0.0,                                                           // Valor do IRPF Devido (Serviço)
                           0.0,                                                           // Valor do PIS Retido (Produto)
                           0.0,                                                           // Valor do PIS Devido (Produto)
                           0.0,                                                           // Valor do PIS Retido (Serviço)
                           0.0,                                                           // Valor do PIS Devido (Serviço)
                           0.0,                                                           // Valor do COFINS Retido (Produto)
                           0.0,                                                           // Valor do COFINS Devido (Produto)
                           0.0,                                                           // Valor do COFINS Retido (Serviço)
                           0.0,                                                           // Valor do COFINS Devido (Serviço)
                           0.0,                                                           // Valor do CSLL Retido (Produto)
                           0.0,                                                           // Valor do CSLL Devido (Produto)
                           0.0,                                                           // Valor do CSLL Retido (Serviço)
                           0.0,                                                           // Valor do CSLL Devido (Serviço)
                           '',                                                            // Ordem de Produção
                           0.0,                                                           // Base Orgão Público
                           0.0,                                                           // ICMS Orgão Público
                           0,                                                             // Número do Conhecimento de Frete
                           '',                                                            // Consumidor final
                           'N',                                                           // Entrega no Faturamento
                           '',                                                            // Cliente de Faturamento
                           '',                                                            // Operador da Expedição
                           '',                                                            // Separador da Expedição
                           '',                                                            // Tabela de Preços utilizada
                           '',
                           'N',                                                           // Entrega Futura
                           FALSE,                                                         // Baixa de Entrega Futura
                           0,                                                             // Margem de Lucro
                           0.0,                                                           // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                                           // Valor do retido considerando a base acima.
                           'N',                                                           // Gerar produção fora da loja
                           '',                                                            // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                                       // Data de Entrega no Romaneio
                           '',                                                            // Classificação fiscal 4
                           'N',                                                           // AUTO-SERVIÇO
                           '',                                                            // Evento
                           '',                                                            // AUTINC ENDEREÇO DE ENTREGA
                           '',                                                            // Conteúdo do CNFNFE
                           '',                                                            // Motivo da Devolução
                           '',
                           True,                                                          // Imprime Duplicatas na NF-e
                           0,
                           0,
                           qryDocumento.FieldByName('EMLCON').AsString,
                           0,
                           0,
                           Nil,
                           '',
                           '',
                           '',
                           'N',
                           '',
                           '',
                           0,
                           '',
                           0,
                           0,
                           '',
                           '',
                           qryDocumento.FieldByName('MENEXP').AsString,
                           qryDocumento.FieldByName('MENEX2').AsString,
                           qryDocumento.FieldByName('MENEX3').AsString,
                           qryDocumento.FieldByName('MENEX4').AsString);

    If Result Then
      objAuditoriaSaldo.Adicionar(strSeqReq, 'MOVGER');

    With cdsRequisicao Do
    Begin
      First;

      While (Not Eof) And (Result) Do
      Begin

        If FieldByName('ITE_ENTSAI').AsString = 'E' Then
          strClaFis := '1999'
        Else
          strClaFis := '5999';

        {*******************}
        {* GRAVA O MOVDET  *}
        {****************MV*}
        strAutIncTmp := '';
        Result := fGravaMovDet(strAutIncTmp,                                                // Retorna Auto-Incremento por Referencia
                               strSeqReq,                                                   // Sequencial do Arquivo Geral
                               strNumReq,                                                   // Numero Documento
                               'RQ',                                                        // Espécie
                               VS_strCodEmp,                                                // Empresa
                               FieldByName('ITE_CODITE').AsString,                          // Cód. Item
                               qryDocumento.FieldByName('CODVEN').AsString,                 // Vendedor
                               '',                                                          // Código Diversos
                               FieldByName('ITE_CODMAR').AsString,                          // Código da Marca
                               '',                                                          // Fornecedor
                               qryDocumento.FieldByName('CODCLI').AsString,                 // Cliente
                               VS_DATE,                                                     // Data da Entrada
                               fTime(),                                                     // Hora da Entrada
                               VS_Date,                                                     // Data do Documento
                               '01000',                                                     // Condição de Pagamento
                               'C',                                                         // Tipo: (C)liente / (F) Fornecedor
                               '',                                                          // Estado do Fornecedor
                               FieldByName('ITE_DESITE').AsString,                          // Descrição do Item
                               FieldByName('ITE_REFERE').AsString,                          // Referência do Item
                               FieldByName('ITE_CODUNI').AsString,                          // Cód. Unidade
                               FieldByName('ITE_CODFOR').AsString,                          // Fornecedor Item
                               FieldByName('ITE_QTDITE').AsFloat,                           // Quantidade do Item
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitario
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitário Original
                               FieldByName('ITE_UNITAR').AsFloat,                           // Valor Unitário Original sem juros
                               FieldByName('ITE_TOTITE').AsFloat,                           // Total do Item
                               FieldByName('ITE_TOTITE').AsFloat,                           // Valor Contábil do Item
                               FieldByName('ITE_TOTCUS').AsFloat,                           // Valor Total de Custo
                               FieldByName('ITE_TOTMED').AsFloat,                           // Valor Total Medio
                               0.0,                                                         // % Desconto do Item
                               0.0,                                                         // Valor do Frete
                               0.0,                                                         // Valor do Desconto Especial
                               '',                                                          // Código do Representante
                               '',                                                          // Código do Vendedor 2
                               0.0,                                                         // Percentual de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor
                               0.0,                                                         // Total de Comissão do Vendedor 2
                               strClaFis,                                                   // Classificação Fiscal
                               '',                                                          // Código Fiscal
                               0.0,                                                         // Valor IPI
                               0.0,                                                         // Aliquota IPI
                               0.0,                                                         // Base IPI
                               0.0,                                                         // Valor de ICMS
                               0.0,                                                         // Aliquota de ICMS
                               0.0,                                                         // Base de ICMS
                               0.0,                                                         // Valor de Substituição
                               0.0,                                                         // Aliquota de Substituição
                               0.0,                                                         // Base de Substituição
                               0.0,                                                         // Total de Peso
                               0.0,                                                         // Percentual de Base de ICMS
                               0.0,                                                         // Percentual de Redução de Base

                               True,                                                        // Indica se ja esta Faturado
                               qryDocumento.FieldByName('ESPDOC').AsString,                 // Tipo de Faturamento
                               qryDocumento.FieldByName('NUMDOC').AsString,                 // Numero de Faturamento
                               qryDocumento.FieldByName('CODEMP').AsString,                 // Empresa dd Faturamento
                               qryDocumento.FieldByName('DTAENT').AsDateTime,               // Data de Faturamento
                               qryDocumento.FieldByName('CODVEN').AsString,                 // Vendedor do Faturamento
                               qryDocumento.FieldByName('CONPAG').AsString,                 // Condição de Pagamento do Faturamento
                               qryDocumento.FieldByName('VLRCON').AsFloat,                  // Valor do Faturamento

                               'NOR',                                                       // Identificação Produto ( Normal / Outros )
                               FieldByName('ITE_INCPIS').AsString,                          // Indice se incide Pis
                               '',                                                          // Série
                               0.0,                                                         // Valor de Despesa Acessória
                               'N',                                                         // Nota Especial
                               '',                                                          // Documento da Devolução
                               '',                                                          // Espécie da Devolução
                               '',                                                          // Empresa da Devolução
                               '',                                                          // Item de Chamada (TINTA DE MAQUINA)
                               '',                                                          // Item da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Descrição da Cor (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Quantidade de Embalagem (TINTA DE MAQUINA)
                               0.0,                                                         // Preço da Embalagem (TINTA DE MAQUINA)
                               '',                                                          // Tipo de Preço (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Venda da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Preço de Compra da Tinta (TINTA DE MAQUINA)
                               0.0,                                                         // Fator da Tinta (TINTA DE MAQUINA)
                               '',                                                          // Produto Embalagem (TINTA DE MAQUINA)
                               strCodDig,                                                   // Código do Digitador
                               '',                                                          // Codigo da Condição
                               '',                                                          // Forma de Pagamento
                               '',                                                          // Item da Embalagem
                               '',                                                          // Grupo do Item da Embalagem
                               0,                                                           // Quarto da Lazzumiz
                               'N',                                                         // É item em promoção?
                               '',                                                          // Tipo de Tinta
                               0.0,                                                         // Quantidade de Pulsos
                               '',                                                          // Número do pedido de compras
                               '',                                                          // Origem do documento
                               '',                                                          // Pedido de Venda - Número
                               '',                                                          // Pedido de Venda - Espécie
                               '',                                                          // Pedido de Venda - Empresa
                               0,                                                           // Pedido de Venda - Sequencial
                               '',                                                          // Ordem de Produção
                               '',                                                          // Descrição para Nota Fiscal Especial
                               '',
                               0,
                               0,
                               0.0,                                                         // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                               '',
                               '',
                               False,  // PROD ACABADO
                               False, // FILKAR
                               '',                                                          //  Especie da Entrega Fututa
                               '',                                                          //  Documento da Entrega Fututa
                               '',
                               '',                                                          //  Empresa da Entrega Fututa
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               0.0,
                               FieldByName('ITE_UNITAR').AsFloat, //fltUniDig
                               0,
                               'N',
                               '',
                               0,
                               FieldByName('ITE_TOTCU2').AsFloat, //fltTotCu2
                               0,
                               0,                                                                                                                        
                               '',                                                                                                                       
                               FieldByName('ITE_NUMLOT').AsString,                                                                                       
                               'N',                                                                                                                      
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,
                               FieldByName('ITE_TOTULT').AsFloat, // fltTotUlt
                               FieldByName('ITE_TOTIMP').AsFloat, // fltImpUlt
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               '',                                                                                                                       
                               0,                                                                                                                        
                               0,                                                                                                                        
                               0,                                                                                                                        
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               0,
                               0,                                    // fltUniTab
                               '',                                   // strLot_TA
                               0,                                    // fltConFre
                               0,                                    // fltBasAnt
                               0,                                    // fltIcmAnt
                               0,                                    // fltVendor
                               0,                                    // fltOutDes
                               0,                                    // fltVlGnre
                               'P',
                               FieldByName('ITE_TOTITE').AsFloat,    // fltOutIcm
                               0,
                               0,
                               '',
                               '',
                               '',
                               '',
                               FieldByName('ITE_OUTVAL').AsFloat,
                               FieldByName('ITE_ICMSAI').AsFloat,
                               FieldByName('ITE_IMPFED').AsFloat,
                               FieldByName('ITE_DESOPE').AsFloat,
                               0,
                               '',
                               0,
                               0,
                               '',
                               'N',
                               'N',
                               0,
                               0,
                               0,
                               '',
                               'N',
                               0,
                               '',
                               0,
                               'N',
                               '',
                               'NOR',
                               0,
                               0,
                               fltDesOpeCli,
                               0,
                               0);

        If Not Result Then
          Break;

        strAutIncDet := strAutIncTmp;

        If Result Then
        Begin
          recMadeira.strAparel := 'N';
          recMadeira.fltPerApa := 0;
          recMadeira.strBenefi := 'N';
          recMadeira.fltPerBen := 0;
          recMadeira.fltQtdPec := FieldByName('ITE_QTDPEC').AsFloat;
          recMadeira.fltComPec := FieldByName('ITE_COMPEC').AsFloat;
          recMadeira.fltLarPec := FieldByName('ITE_LARPEC').AsFloat;
          recMadeira.fltEspPec := 1;

          Result := fGravaVendaMadeira(strAutIncDet,
                                       AnsiReplaceStr(strArqMovDet, 'DET', 'MAD'),
                                       recMadeira);
        End;

        If Not Result Then
          Break;

        {*****************************************}
        {* ATUALIZA O ESTOQUE DO ITEM, DE ACORDO *}
        {* COM O TIPO DE MOVIMENTAÇÃO (E/S)      *}
        {**************************************MV*}
        Result := fAtualizaEstoqueCadIte(FieldByName('ITE_CODITE').AsString,
                                         FieldByName('ITE_ENTSAI').AsString,
                                         FieldByName('ITE_QTDITE').AsFloat,
                                         0.0,
                                         FieldByName('ITE_NUMLOT').AsString);

        If Not Result Then
          Break;

        pgbItens.StepBy(1);
        Next;
      End;

    End;

    Result := Result And fGravaInformacoesFechamento;
    Result := Result And fAtualizaStatusObra;
    Result := Result And fAtualizaCustoVenda;

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;

    If Result Then
      fCommit
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fConfirmaRequisicao]');
    End;
  End;

  pgbItens.Position := 0;
  pgbItens.Visible := False;
end;

procedure TfrmReqEnvioMatVidro.btnConfirmaClick(Sender: TObject);
Var intQtdImp : Integer;
begin
  inherited;

  If Not btnConfirma.Enabled Then
  begin
    Exit;
  End;

  btnCancelaItem.Click;

  If (Not cdsRequisicao.Active)       Or
     (cdsRequisicao.RecordCount <= 0) Then
  Begin
    pSetFocus(edtCodIte);
    Exit;
  End;

  If Not fValidaCampos(edtCodDig, True) Then
    Exit;

  If Not fPedeInformacoesFechamento Then
    Exit;

  If fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1 Then
  Begin

    If fConfirmaRequisicao Then
    Begin
      fMensagem('', 'Gravação concluída com sucesso!', ['&O k']);

      If fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1 Then
      Begin
        intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1);

        pImprime(strNumReq, 'RQ', intQtdImp);

      End;

      pLimparTela;
    End;

  End
  Else
  Begin
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmReqEnvioMatVidro.btnDevEntradaClick(Sender: TObject);
  Var
    qryAux:TUniQuery;
    frmReqEnvioSelDocDevolucao: TfrmReqEnvioSelDocDevolucao;
begin
  qryAux := fCriaQuery(Nil);

  With qryAux Do
  Begin
    SQL.Add(TfrmReqEnvioSelDocDevolucao.fGetSQLDocumentosDevolucao(edtNumDoc.Text,
                                                                   edtEspDoc.Text,
                                                                   qryDocumento.FieldByName('CODEMP').AsString));
    Open;
    If IsEmpty Then
    Begin
      fMensagem('Atenção!','Não existem requisições de saída vinculadas ao documento escolhido.'+#13+
                           'Não há produto(s) para realizar a devolução!',['&O K']);
      Exit;
    End
    Else
    Begin
      qryAux.Filter   := 'QTDPEN > 0';
      qryAux.Filtered := True;
      If qryAux.IsEmpty Then
      Begin
        fMensagem('Atenção!','Todas saídas vinculadas ao documento escolhido já foram devolvidas.'+#13+
                             'Não há produto(s) para realizar a devolução!',['&O K']);
        FreeAndNil(qryAux);
        Exit;
      End;
      qryAux.Filter   := '';
      qryAux.Filtered := False;
    End;
  End;

  inherited;

  Try
    pCriarFormularios(TfrmReqEnvioSelDocDevolucao, frmReqEnvioSelDocDevolucao);
    frmReqEnvioSelDocDevolucao.strNumDoc := edtNumDoc.Text;
    frmReqEnvioSelDocDevolucao.strEspDoc := edtEspDoc.Text;
    frmReqEnvioSelDocDevolucao.strCodEmp := qryDocumento.FieldByName('CODEMP').AsString;
    frmReqEnvioSelDocDevolucao.fltDesOpeCli := fltDesOpeCli;
    frmReqEnvioSelDocDevolucao.strTabPreGlobal := strTabPre;
    frmReqEnvioSelDocDevolucao.pSetTemporaria(cdsRequisicao);
    frmReqEnvioSelDocDevolucao.ShowModal;
  Finally
    FreeAndNil(frmReqEnvioSelDocDevolucao);
    If cdsRequisicao.RecordCount > 0 Then
    Begin
      btnDevEntrada.Enabled := False;
      pCalculaTotalGeral;
    End;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmReqEnvioMatVidro.btnEstLojClick(Sender: TObject);
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  If (not cdsRequisicao.Active) or (fEmptyStr(cdsRequisicao.FieldByName('ITE_CODITE').AsString)) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    With frmFatMostraEstoqueEmp, cdsRequisicao Do
    Begin
      strCodIte    := FieldByName('ITE_CODITE').AsString;
      fltQtdIte    := 0;
      strTabPre    := Self.strTabPre;
      blnPedCorte  := False;
      edtItem.Text := FieldByName('ITE_CODITE').AsString + ' - ' + fRetNomProduto(FieldByName('ITE_CODITE').AsString);
      pnlSelecEmpresa.Visible := False;

      ShowModal;
    End;


  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);

end;

procedure TfrmReqEnvioMatVidro.btnImportarArqTxtClick(Sender: TObject);
begin
  inherited;
  Try

    cxgItens.BeginUpdate();

    Application.CreateForm(TfrmImportarListaDeMateriais, frmImportarListaDeMateriais);
    frmImportarListaDeMateriais.strTabPre := strTabPre;

    {Importa Materiais}
    If (frmImportarListaDeMateriais.ShowModal = mrOk) And (Not frmImportarListaDeMateriais.cdsDados.IsEmpty) Then
    Begin

      With frmImportarListaDeMateriais Do
      Begin

        pgbItens.Visible := True;
        pgbItens.Max     := cdsDados.RecordCount;

        cdsDados.First;

        While Not cdsDados.Eof Do
        Begin

          edtCodIte.Text := frmImportarListaDeMateriais.cdsDados.FieldByName('CODITE').AsString;
          edtQtdIte.Text := cdsDados.FieldByName('QTDIMP').AsString;
          btnAdicionar.Click;

          pgbItens.StepBy(1);
          cdsDados.Next;

        End;

      End;

    End;

  Finally

    If Assigned(frmImportarListaDeMateriais) Then
      FreeAndNil(frmImportarListaDeMateriais);

    If Not dtsRequisicao.DataSet.IsEmpty Then
      dtsRequisicao.DataSet.First;

    cxgItens.EndUpdate;

    pgbItens.Position := 0;
    pgbItens.Visible := False;

  End;
end;

procedure TfrmReqEnvioMatVidro.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If edtCodIte.Enabled Then
      pSetFocus(edtCodIte);
  End
  Else If (Key = VK_Return) Then
  Begin
    If (cdsRequisicao.FieldByName('ITE_ENTSAI').AsString = 'E') Then
    Begin
      fMensagem('Atenção!','Não é permitido alterar itens de entrada!',['&O K']);
      Exit;
    End;
    pCarregaItensAlteracao;
  End
  Else If (Key = VK_Delete) Then
  Begin
    If Not cdsRequisicao.Active Then
    Begin
      If edtCodIte.Enabled Then
        pSetFocus(edtCodIte);
      Exit;
    End;
    pDeletaItem;
  End;
end;

procedure TfrmReqEnvioMatVidro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else
  If (Key = VK_F6) Then
  Begin
    btnEstLoj.Click;
  End;
  
end;

procedure TfrmReqEnvioMatVidro.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmReqEnvioMatVidro.pLimparTela;
begin
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtNomCli.Clear;
  edtNomVen.Clear;
  edtDtaEmi.Clear;
  edtConPag.Clear;
  edtValDoc.Clear;
  edtTotGer.Clear;
  edtCodDig.Clear;
  edtNomDig.Clear;

  strInfVid := '';
  strInfFer := '';
  strInfAlu := '';
  strObserv := '';
  strObrFin := 'N';

  pDeletaTemporaria;
  pHabilitaDocumento;
  pLimpaDadosItem;

  btnDevEntrada.Enabled := False;
end;

function TfrmReqEnvioMatVidro.fPedeInformacoesFechamento: Boolean;
  Var
    frmReqEnvioMatVidroInf: TfrmReqEnvioMatVidroInf;
begin
  Try
    pCriarFormularios(TfrmReqEnvioMatVidroInf, frmReqEnvioMatVidroInf);

    frmReqEnvioMatVidroInf.memInfVid.Texto := strInfVid;
    frmReqEnvioMatVidroInf.memInfFer.Texto := strInfFer;
    frmReqEnvioMatVidroInf.memInfAlu.Texto := strInfAlu;
    frmReqEnvioMatVidroInf.memObserv.Texto := strObserv;
    frmReqEnvioMatVidroInf.edtObrFin.Text  := strObrFin;

    Result := frmReqEnvioMatVidroInf.ShowModal = mrOk;

    If Result Then
    Begin
      strInfVid := frmReqEnvioMatVidroInf.memInfVid.Texto;
      strInfFer := frmReqEnvioMatVidroInf.memInfFer.Texto;
      strInfAlu := frmReqEnvioMatVidroInf.memInfAlu.Texto;
      strObserv := frmReqEnvioMatVidroInf.memObserv.Texto;
      strObrFin := frmReqEnvioMatVidroInf.edtObrFin.Text;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmReqEnvioMatVidroInf);
end;

procedure TfrmReqEnvioMatVidro.pImprime(strNumDoc, strEspDoc: String; intQtd: Integer);
  Var
    strNomeFila: String;
    strTipImp: String;
    strNomeArquivo: String;
Begin

  pImprimeFatImp(strArqMovDet, strNumDoc, strEspDoc, VS_strCodEmp, qryDocumento.FieldByName('CODCLI').AsString, 'C', '',
                 False, strNomeArquivo, False, strTipImp, intQtd, impComPrecoGeral, 0, False, False, True, False, strNomeFila, '', False, False, False, False, False, False,
                 False,
                 opcTodos,
                 False,
                 False,
                 False,
                 False,
                 False,
                 '',
                  ' ',
                 Nil,
                 False,
                 '',
                 '', // Razao Social ou Fantasia
                 '',     //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                 False,
                 opcNaoAgrupa,
                 False,
                 '',
                 '',
                 False,
                 False,
                 False,
                 '',
                 False,
                 False,
                 False,
                 False,
                 False,
                 False,
                 True);
end;

procedure TfrmReqEnvioMatVidro.FormShow(Sender: TObject);
begin
  inherited;
  lblNumLot.Caption := objCadLot.strTitLab + ':';

  edtQtdIte.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtQtdPec.EditFormat := fMskDigitos(5);
  edtComPec.EditFormat := fFormataCasaDecimalVIDRO(fMskDigitos(5));
  edtLarPec.EditFormat := fFormataCasaDecimalVIDRO(fMskDigitos(5));
  pHabilitarMetragem('', '');
  lblComPec.Caption := fRetornaInfMedVIDRO(True,True);

  pSetaCodIte( edtCodIte );

end;

{*******************************************}
{* PROCEDURE PARA IMPRIMIR 40C             *}
{****************************************AC*}

function TfrmReqEnvioMatVidro.fGetSqlIteGer: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  G.*  ';
  Result := Result + 'FROM ';
  Result := Result + '  ITEGER G ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = G.ITE_CODITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  G.ITE_CODITE = :CODITE AND ';
  Result := Result + '  G.ITE_CODEMP = :CODEMP ';
end;

function TfrmReqEnvioMatVidro.fGetStatusItem(strCodIte : String): String;
begin
  Result := fCampoTabela('ITE_ITEATI', 'CADITE', ['ITE_CODITE'], [strCodIte]);
end;

function TfrmReqEnvioMatVidro.fGravaInformacoesFechamento: Boolean;
  Var
    qryInfVid: TUniQuery;
begin
  qryInfVid := fCriaQuery;

  qryInfVid.SQL.Clear;
  qryInfVid.SQL.Add('SELECT * FROM INFVID WHERE FALSE');
  qryInfVid.Open;

  qryInfVid.Append;

  qryInfVid.FieldByName('GER_SEQGER').AsString := strSeqReq;
  qryInfVid.FieldByName('GER_INFVID').AsString := strInfVid;
  qryInfVid.FieldByName('GER_INFFER').AsString := strInfFer;
  qryInfVid.FieldByName('GER_INFALU').AsString := strInfAlu;
  qryInfVid.FieldByName('GER_OBSERV').AsString := strObserv;

  qryInfVid.Post;

  FreeAndNil(qryInfVid);

  Result := True;
end;

procedure TfrmReqEnvioMatVidro.edtEntSaiEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEntSai.Text) Then
    edtEntSai.Text := 'S';
end;

procedure TfrmReqEnvioMatVidro.edtEntSaiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Pos(UpperCase(Key),'SE') > 0 Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmReqEnvioMatVidro.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin
  If CharInSet(Key, [',','.','-']) Then
    Key := #0;
End;

procedure TfrmReqEnvioMatVidro.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharTela Then
  Begin
    Close;
  End;
end;

procedure TfrmReqEnvioMatVidro.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) And
    TfrmReqEnvioMatVidroSelDoc.fPesquisaDocumentos(edtNumDoc, edtEspDoc, 'N', '', dtaDataIni, VS_Date) Then
  Begin
    pSetFocus(edtEspDoc);
  End;
end;

procedure TfrmReqEnvioMatVidro.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, edtNumLot, Self, False) Then
  Begin
    If fValidaCampos(edtNumLot, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReqEnvioMatVidro.pCalculaQuantidadeMetrosCubicos;
begin
  edtQtdIte.Text := FormatFloat(fMskDigitos(intDecQtd),
                                fCalculaQuantidadeMetrosCubicos(fStrToFloat(edtQtdPec.Text),
                                                                fStrToFloat(edtComPec.Text),
                                                                fStrToFloat(edtLarPec.Text),
                                                                1,
                                                                fRetSiglaUni(edtUnidade.Text)));
end;

procedure TfrmReqEnvioMatVidro.pCalculaTotalGeral;
  Var
    intRecNo: Integer;

  function fAggr(FieldAgg: TField): Variant;
  Begin
    If TAggregateField(FieldAgg).Value = Null Then
      Result := 0
    Else
      Result := TAggregateField(FieldAgg).Value;
  End;

begin
 intRecNo := cdsRequisicao.RecNo;
 Try
   cdsRequisicao.DisableControls;

   cdsRequisicao.Filter := 'ITE_ENTSAI = ' + QuotedStr('E');
   cdsRequisicao.Filtered := True;

   fltTotGer := fAggr(cdsRequisicao.FieldByName('TOT_TOTITE'));
   fltTotMed := fAggr(cdsRequisicao.FieldByName('TOT_TOTMED'));
   fltTotUlt := fAggr(cdsRequisicao.FieldByName('TOT_TOTULT'));
   fltTotImp := fAggr(cdsRequisicao.FieldByName('TOT_TOTIMP'));
   fltTotCus := fAggr(cdsRequisicao.FieldByName('TOT_TOTCUS'));
   fltTotCu2 := fAggr(cdsRequisicao.FieldByName('TOT_TOTCU2'));

   cdsRequisicao.Filter := 'ITE_ENTSAI = ' + QuotedStr('S');
   cdsRequisicao.Filtered := True;

   fltTotGer := fltTotGer - fAggr(cdsRequisicao.FieldByName('TOT_TOTITE'));
   fltTotMed := fltTotMed - fAggr(cdsRequisicao.FieldByName('TOT_TOTMED'));
   fltTotUlt := fltTotUlt - fAggr(cdsRequisicao.FieldByName('TOT_TOTULT'));
   fltTotImp := fltTotImp - fAggr(cdsRequisicao.FieldByName('TOT_TOTIMP'));
   fltTotCus := fltTotCus - fAggr(cdsRequisicao.FieldByName('TOT_TOTCUS'));
   fltTotCu2 := fltTotCu2 - fAggr(cdsRequisicao.FieldByName('TOT_TOTCU2'));

   cdsRequisicao.Filter   := '';
   cdsRequisicao.Filtered := False;

   edtTotGer.Text := FormatFloat('#,##0.00', fltTotGer);
 Finally
   cdsRequisicao.EnableControls;
 End;
 cdsRequisicao.RecNo := intRecNo;
end;

function TfrmReqEnvioMatVidro.fAtualizaCustoVenda: Boolean;
begin
  Result := fAtualizaCustoVendaVidro(qryDocumento.FieldByName('NUMDOC').AsString,
                                     qryDocumento.FieldByName('ESPDOC').AsString,
                                     qryDocumento.FieldByName('CODEMP').AsString);
end;

end.

