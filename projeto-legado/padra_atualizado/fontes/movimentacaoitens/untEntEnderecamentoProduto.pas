unit untEntEnderecamentoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils,
  Math, BitBtnLockedIncrem, frxDMPExport, untEnderecamentoProduto,
  untEnderecamentoArmazem, System.UITypes,
  untCadLote, ComCtrls, MemDS, DBAccess, Provider, frxExportCSVTestabilidade,
  Datasnap.DBClient, System.Types, untTLock, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, CxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, MemoFocus,
  cxButtonEdit, cxContainer, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus,
  cxGridCitel, untParametrosRastreamentoEnderecamento, untTypesSistema, TypesRel, untFuncoesEtiquetas, untFuncoesConsulta,
  untEditorFastImpressao, untSaldoLojas, untSalvaConfiguracaoGrid, untMensagemExplicativa,
  untTDistribuicaoConferencia,
  untTEnderecamentoConferenciaParcial;

type
  TfrmEntEnderecamentoProduto = class(TfrmPaiOrdena)
    lblNotEle: TLabel;
    edtDocumento: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnLocFis: TBitBtnLocked;
    btnCadArm: TBitBtnLocked;
    btnEndArm: TBitBtnLocked;
    prgProgresso: TProgressBar;
    btnPesDoc: TBitBtnLocked;
    btnUmArm: TBitBtnLocked;
    Splitter1: TSplitter;
    btnEntregasPendentes: TBitBtnLocked;
    pnlGarantia: TPanel;
    shpGarantia: TShape;
    lblGarantia: TLabel;
    lblTipDoc: TLabel;
    btnMarDes: TBitBtnLocked;
    ntbLote: TNotebook;
    dtsRastreamentoLote: TDataSource;
    Panel2: TPanel;
    cxgLotes: TcxGrid;
    cxvlotes: TcxGridDBTableView;
    cxvlotesNUMLOT: TcxGridDBColumn;
    cxvlotesMARCAD: TcxGridDBColumn;
    cxvlotesQTDREG: TcxGridDBColumn;
    cxgLotesLevel1: TcxGridLevel;
    Panel3: TPanel;
    btnMarLotMarcados: TBitBtnLocked;
    btmMarLotTodos: TBitBtnLocked;
    MemoFocus1: TMemoFocus;
    dbgArmazens: TDBGridCitel;
    pnlInfWms: TPanel;
    cxgRastreamentoLote: TcxGridCitel;
    cxgRastreamentoLoteTBV: TcxGridDBTableViewCitel;
    cxgRastreamentoLoteNUMERO_LOTE: TcxGridDBColumn;
    cxgRastreamentoLoteQUANTIDADE_ETIQUETAS: TcxGridDBColumn;
    cxgRastreamentoLoteEXCLUIR: TcxGridDBColumn;
    cxgRastreamentoLoteLVL: TcxGridLevel;
    pnlRastreamentoLote: TPanel;
    pnlDadosLoteRastreamento: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtLoteRastreamento: TEditFocus;
    edtQuantidadeEtiquetasLoteRastreamento: TCurrencyEditFocus;
    pnlInformacaoLoteRastreamento: TPanel;
    btnAdicionarLoteRastreamento: TBitBtnLocked;
    btnReqComprasVinculadas: TBitBtnLocked;
    tmrClose: TTimer;
    lblQtdEtiquetas: TLabel;
    edtQtdEti: TEditFocus;
    lblEtiqueta: TLabel;
    btnQtdEti: TBitBtnLocked;
    btnEtiPro: TBitBtnLocked;
    btnDefineLoteEntFut: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnPesDocClick(Sender: TObject);
    procedure btnPesDocEnter(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgConsultaEnter(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLocFisClick(Sender: TObject);
    procedure btnCadArmClick(Sender: TObject);
    procedure dbgConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEndArmClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnUmArmClick(Sender: TObject);
    procedure dbgArmazensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgConsultaExit(Sender: TObject);
    procedure btnEntregasPendentesClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure dbgConsultaCellClick(Column: TColumn);
    procedure cxvlotesNUMLOTPropertiesChange(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btmMarLotTodosClick(Sender: TObject);
    procedure btnMarLotMarcadosClick(Sender: TObject);
    procedure btnAdicionarLoteRastreamentoClick(Sender: TObject);
    procedure cxgRastreamentoLoteEXCLUIRPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxgRastreamentoLoteTBVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnReqComprasVinculadasClick(Sender: TObject);
    procedure tmrCloseTimer(Sender: TObject);
    procedure btnQtdEtiClick(Sender: TObject);
    procedure btnEtiProClick(Sender: TObject);
    procedure btnDefineLoteEntFutClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnCofEnd: Boolean;
    blnUDEVME: Boolean;
    strTraLoc: String;
    blnArmazemVisivel: Boolean;
    blnLocFisVisivel: Boolean;
    blnDocTE: Boolean;
    blnCadLoc: Boolean;
    blnUtiLot: Boolean;
    tpeEtique : TTipoEtiqueta;
    blnPrePro: Boolean;
    intTabPre: Integer;
    strCodCnd: String;
    strCndPag: String;
    strNumPar: String;
    strDesEti: String;
    {blnNaoUtiLot: Boolean;}
    blnSuprimirMensagem: Boolean;
    objEnderecamento: TEnderecamentoProduto;
    objReservaEstAtiPre: TEnderecamentoProduto;
    objEndArm: TEnderecamentoArmazem;
    objLock  : TLock;

    FTodos: Boolean;

    cdsArmSel : TUniClientDataSet;
    dtsArmSel : TDataSource;

    recSaldos,
    recSaldosML: TRecSaldos;

    clrCorZebra : TColor;

    blnFecharForm: Boolean;
    blnCDLTAU: Boolean;

    blnPermiteFracionarQtd: Boolean;
    blnResLtp: Boolean;
    blnMoeXsi: Boolean;
    blnEditaEcomm: Boolean;

    Procedure pConsultaBeforePost(DataSet: TDataSet);

    procedure pCancela(blnPerguntar: Boolean = True; blnAbort: Boolean = False);
    function fChecaDados : Boolean;
    Procedure pSetaRequeridos;
    procedure pPesquisaLocFisica(Var Key: Char; intColuna: Integer);

    Function fValidaLocFisica(fldCampo: TField; strNomCam: String; Var blnRemoverLocFis: Boolean; blnTravar: Boolean): Boolean;
    function fTemProAcaSim : Boolean;

    procedure pSetaLote(blnTodos: Boolean);

    procedure pAtualizaNtbLote;
    function fUtiLot: boolean;
    {function fNaoUtiLot: boolean;}
    function fRegistroUtilizaLote: boolean;
    function fDocumentoConferido(strSeqFgo: String): Boolean;

    function fDocumentoConferidoSimplificado(strCodEmp, strNumDoc, strCodFor : String): Boolean;

    Function fSetaLotePrg(prgProgresso: TCxProgressBar): Boolean;
    procedure pExcluiLoteRastreamento;
    procedure pLimpaRastreamento;
    procedure pCarregaEnderecamento;
    function fEscolheTipoEtiqueta: Boolean;
    function fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer; ABlnQtdFrac: Boolean = False; ABlnApenasEstrutura: Boolean = False): String;
    function fJoinIBPT: string;
    function fRetCamposIBPT: string;
    procedure pImprimeEtiqueta(intQtdIte: Integer);
    procedure pImprimeEtiquetaQtdFrac(intQtdEti: Integer);
    function getColumByFieldName(FieldName: String): TColumn;
    function fLoteFoiCadastradaDuranteProcessoEnderecamento: Boolean;

    function fValidaCadastroLoteCriadoAposInciarEnderecamento : Boolean;

    function fRetAutoIncremOPI(strAutInc: String): String;
    procedure pEnderecamentoAutomatico;
    procedure pAtualizarSaldoLote;

    procedure pValidarPacotesQtdFracionada;
    function fCriaDataSetMultiSelecao(intQtdIte: Integer): TUniClientDataSet;
    function fValidaCadastroLotesEscolhidos: Boolean;
    function fEhEntradaSimplificada(AEndDocumento: TEndDocumento): Boolean;
    function fVerificaEdicaoEcommerce : Boolean;
    procedure AddColumn(strFieldName, strCaption: String);

  public
    strAutoincremGERELE : String;
    blnDocumentoNaoEncontrado: Boolean;
    intNRO_COL_ARMAZE,
    intNRO_COL_LOCFIS,
    intNRO_COL_SUPEST,
    intNRO_COL_QTDPAC,
    intNRO_COL_QTDFRA: integer;

    { Public declarations }
    procedure pLimpaPesquisa; Override;
    class function fGetChaveDocumento(strNumDoc, strCodEmp, strCliFor: String): String;
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fAbreConsulta(blnLike: Boolean): Boolean; override;
    procedure pOrdenaClient; override;
  end;

implementation

uses untPai, untCfgRel, untConsultas, untCadLoteItens,
  untFuncoesSimples, untCadLocFisica, untQckLiberacaoArmazenamento, untFatDigSepConferente,
  untConstantes, untImpEtiLoteDoProduto, untTypesCRM,
  untDefineBaixaPedido, untGravando, untAtualizaOcorrenciasCRM, untTNumeroSerie,
  untImprimeEtiquetaLoteRastreamentoProduto, untFuncoesRel, untFatDefineLoteEntregaFuturaFaltaProduto,
  untPcmger, untFatSeparadorConferente, untFuncoesEtiqItens, untZClient;

{$R *.dfm}

Procedure TfrmEntEnderecamentoProduto.pSetaRequeridos;
  Var
    intIndex: Integer;
Begin
  With cdsConsulta Do
  For intIndex := 0 To FieldDefs.Count - 1 Do
    FieldDefs[intIndex].Required := FALSE;
End;

procedure TfrmEntEnderecamentoProduto.tmrCloseTimer(Sender: TObject);
begin
  inherited;

  Close;
end;

function TfrmEntEnderecamentoProduto.fValidaCadastroLoteCriadoAposInciarEnderecamento: Boolean;
Var
   qryAux : TUniQuery;
   strCodIte : String;
begin
  Result := True;
  If (objEndArm.tplTipLot <> tplArmazem)  Then
  begin
    qryAux := fCriaQuery(nil);
    try
      qryAux.SQL.Add(' SELECT                             ');
      qryAux.SQL.Add('   FDO_CODITE AS CODITE,            ');
      qryAux.SQL.Add('   IF(                              ');
      qryAux.SQL.Add('     (SELECT                        ');
      qryAux.SQL.Add('       COUNT(*)                     ');
      qryAux.SQL.Add('     FROM                           ');
      qryAux.SQL.Add('       CADLOT                       ');
      qryAux.SQL.Add('     WHERE LOT_CODITE = FDO_CODITE  ');
      qryAux.SQL.Add('       AND LOT_CODEMP = FDO_CODEMP  ');
      qryAux.SQL.Add('       AND LOT_STATUS = "S") > 0,   ');
      qryAux.SQL.Add('     "1",                           ');
      qryAux.SQL.Add('     "0"                            ');
      qryAux.SQL.Add('   ) AS TEMLOT                      ');
      qryAux.SQL.Add(' FROM                               ');
      qryAux.SQL.Add('   FATDOR                           ');
      qryAux.SQL.Add(' WHERE FDO_SEQGER = :SEQGER         ');

      qryAux.ParamByName('SEQGER').AsString := objEnderecamento.strAutIncPed;
      qryAux.Close;
      qryAux.Open;

      cdsConsulta.First;

      If (Not qryAux.isEmpty) Then
      Begin

        qryAux.First;
        While Not qryAux.Eof Do
        Begin
           strCodIte := '';
           If qryAux.FieldByName('TEMLOT').AsString = '1' Then
           Begin
              strCodIte := qryAux.FieldByName('CODITE').AsString;
              If cdsConsulta.Locate('FDO_CODITE', strCodIte, []) Then
              Begin
                 If cdsConsulta.FieldByName('TEMLOT').AsString = '0' Then
                 Begin
                  Result := False;
                  Break;
                 End;
              End
           End;

          qryAux.Next;
        End;
      End;

    Finally
      FreeAndNil(qryAux);
      cdsConsulta.First;
    end;
  end
end;

function TfrmEntEnderecamentoProduto.fValidaCadastroLotesEscolhidos: Boolean;
Var
  LNumLot: String;
  LCodIte: String;
begin
  Result := True;
  If cdsConsulta.IsEmpty Then
    Exit;

  If (objEndArm.tplTipLot <> tplArmazem)  Then
  begin
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    try
      While Not cdsConsulta.Eof Do
      Begin
        LNumLot := cdsConsulta.FieldByName('ARMAZE').AsString;
        LCodIte := cdsConsulta.FieldByName('FDO_CODITE').AsString;
        If (Not fEmptyStr(LNumLot)) And (LNumLot <> 'VÁRIOS') Then
        Begin
          If (fCampoTabela('COUNT(1)', 'CADLOT', ['LOT_NUMLOT', 'LOT_CODEMP', 'LOT_CODITE'], [LNumLot, VS_strCodEmp, LCodIte ]) = 0) Then
          Begin
            pMensagemOk('O lote: ' + LNumLot + ' não foi encontrado !' );
            Result := False;
            Exit;
          End;

          If TCadLot.fBloqueiaTranfSaldoLote(LNumLot, '', LCodIte, VS_strCodEmp) Then
          Begin
            Exit(False);
          End;
        End;
        cdsConsulta.Next;
      End;
    Finally
      cdsConsulta.First;
      cdsConsulta.EnableControls;
    end;
  End;
end;

function TfrmEntEnderecamentoProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin

      if (Sender = edtLoteRastreamento)  then
      begin
        if fEmptyStr(edtLoteRastreamento.Text) then
        begin
          pMensagemOk('Informe o Lote do Fornecedor!');
          exit(false);
        end;

        if blnBuscaPorChave then
        begin
          edtQuantidadeEtiquetasLoteRastreamento.Text := IntToStr(objEnderecamento.objRastreamento.fGetQuantidadeRestanteMOVDET(cdsConsulta.FieldByName('SEQDET').AsString));
          blnMudarFoco := False;
          pSetFocus(edtQuantidadeEtiquetasLoteRastreamento);
        end;
      end

      else if (Sender = edtQuantidadeEtiquetasLoteRastreamento) then
      begin
        if fEmptyStr(edtQuantidadeEtiquetasLoteRastreamento.Text) then
        begin
          pMensagemOk('Informe a quantidade de etiquetas!');
          exit(false);
        end;
      end;

    End;

  finally
    If Not Result Then
      pSetFocus(Sender);
  end;
end;

class function TfrmEntEnderecamentoProduto.fGetChaveDocumento(strNumDoc,
  strCodEmp, strCliFor: String): String;
begin
  Result := 'ENDERECAMENTO' + strNumDoc + strCodEmp + strCliFor;
end;

Function TfrmEntEnderecamentoProduto.fGetSql(blnLike: Boolean): String;
Begin
  Result := objEnderecamento.fGetSqlItensPedido;
End;

function TfrmEntEnderecamentoProduto.fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer; ABlnQtdFrac: Boolean = False; ABlnApenasEstrutura: Boolean = False): String;
  Var
    strSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT                    ';
  Result := Result + '     EMP_CODEMP AS CODEMP, ';
  Result := Result + '     EMP_NOMEMP AS NOMEMP, ';
  Result := Result + '   I.ITE_APLICA AS APLICA, ';
  Result := Result + '   I.ITE_ATICOM AS ATICOM, ';
  Result := Result + '   I.ITE_CODITE AS CODITE, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS NUMDOC, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS ESPDOC, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS SERIE_, ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM,   ';
  Result := Result + '     EMP_C_G_C_ AS EMPCGC,   ';
  Result := Result + QuotedStr(cdsConsulta.FieldByName('ITE_LOCFIS').AsString) + ' AS LOCFIS,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';
  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '   I.ITE_CODFOR AS CODFOR,   ';
  Result := Result + '     MAR_CODMAR AS CODMAR,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';
  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + ' IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + ' IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS ITE_PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS ITE_PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS ITE_PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS ITE_PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS ITE_PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS ITE_PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS ITE_PREVE7, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS PREVE7, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';

  Result := Result + '   G.ITE_PREVE1 AS VALITE,         ';
  Result := Result + '   G.ITE_PREVE1 AS VALVIS,         ';
  Result := Result + '   I.ITE_DTAALT,         ';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '   CAST("" AS CHAR(1)) AS DESEMB ,';
  Result := Result + '   0.0000 AS TOTPRA,        ';
  Result := Result + '   G.ITE_PREVE1 AS PREVIS,        ';
  Result := Result + '   0.0000 AS VALPAR,        ';
  Result := Result + '   0.0000 AS QTDPAR,        ';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " " , MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   G.ITE_AMZETI AS AMZETI,  ';
  Result := Result + '   I.ITE_ITEATI AS ITEATI,  ';
  Result := Result + '   G.ITE_SALDOS AS SALDOS,  ';
  Result := Result + '   I.ITE_CODBAR AS BARITE,  ';
  Result := Result + QuotedStr(cdsConsulta.FieldByName('ARMAZE').AsString) + ' AS NUMLOT, ';

  If ABlnQtdFrac Then
  Begin
    Result := Result + StringReplace(FormatFloat(fMskDigitos(1) , cdsConsulta.FieldByName('QTDPAC').AsFloat), ',','.',[rfReplaceAll]) + ' AS QTDPAC, ';
    Result := Result + StringReplace(FormatFloat(fMskDigitos(fCfgSis('DEQTEM', varInteger), False) , cdsConsulta.FieldByName('QTDFRA').AsFloat), ',','.',[rfReplaceAll]) + ' AS QTDFRA, ';
    Result := Result + StringReplace(FormatFloat(fMskDigitos(fCfgSis('DEQTEM', varInteger), False) , cdsConsulta.FieldByName('FDO_QTDITE').AsFloat), ',','.',[rfReplaceAll]) + ' AS QTDITE, ';
  End;

  Result := Result + '   CADEMP.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '   CADEMP.EMP_FONDA2 AS FONDA2,  ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';

  Result := Result + ' CAST("" AS CHAR(1)) AS LOTECR, ';
  Result := Result + ' IF(IFNULL(IB.BAR_EMBALA, 0) =  0, I.ITE_EMBALA, IB.BAR_EMBALA) AS EMBALA, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS EMBPRE, ';
  Result := Result + ' FOR_CODFOR AS CODFOR, ';
  Result := Result + ' FOR_NOMFOR AS NOMFOR, ';
  Result := Result + ' G.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS DESEMB, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS OBSIMP, ';
  Result := Result + ' CAST("" AS CHAR(1)) AS CODAMZ, ';
  Result := Result + ' ITE_VALIDA AS VALIDA,';
  Result := Result + ' ITE_ITESAC AS ITESAC, ';
  Result := Result + ' ITE_COMPOS AS COMPOS, ';
  Result := Result + ' ITE_PAISOR AS PAISOR, ';
  Result := Result + ' ITE_ESTMIN AS ESTMIN, ';
  Result := Result + ' ITE_ESTMAX AS ESTMAX, ';
  Result := Result + ' ITE_MLTVEN AS MLTVEN, ';
  Result := Result +  fRetCamposIBPT;
  Result := Result + '  I.AUTOINCREM, ';
  Result := Result + '  I.ITE_MSGLV1 AS MSGLV1 ';

  Result := Result + ' FROM                        ';
  Result := Result + '   CADITE I  ';
  Result := Result + '   INNER JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';

  Result := Result + '   INNER JOIN CADEMP ON EMP_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   INNER JOIN CADFOR ON FOR_CODFOR = I.ITE_CODFOR  ';

  Result := Result + '   INNER JOIN ITEGER G ON          ';
  Result := Result + '     I.ITE_CODITE = G.ITE_CODITE AND ';
  Result := Result + '     G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Result := Result + '   INNER JOIN CADMAR ON       ';
  Result := Result + '     MAR_CODMAR = ITE_CODMAR  ';

  Result := Result + '   LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '   WHERE  ';
  Result := Result + '   PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  Result := Result + '   LEFT JOIN ITEBAR IB ON I.ITE_CODITE = IB.BAR_CODITE AND I.ITE_CODBAR = IB.BAR_CODBAR' ;

  Result := Result +    fJoinIBPT;
  Result := Result + ' WHERE                      ';
  If ABlnApenasEstrutura Then
    Result := Result + ' TRUE '
  Else
    Result := Result + '   I.ITE_CODITE = ' + QuotedStr(strCodIte);

  strSQL := Result;

end;

function TfrmEntEnderecamentoProduto.fJoinIBPT: string;
begin
  Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = CADEMP.EMP_CODCID ';
  If fCfgSis('IMPPAG', varInteger) = 1 Then
  Begin
    If fCfgSis('TIPABF') = 2 Then
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = G.ITE_CODABF '
    Else
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = I.ITE_CODABF ';
  End
  Else
  begin
    Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = I.ITE_CLAIPI), ';

    Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) , ';
    Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2)))) ';
  End;
end;

procedure TfrmEntEnderecamentoProduto.pAtualizaNtbLote;
begin
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) then
  begin
    if not objEnderecamento.blnRastreamentoIndustrial then
    begin
      With cdsConsulta Do
      Begin
        if (not objEnderecamento.blnRastreamentoIndustrial) and ((FieldByName('ARMAZE').asString = 'VÁRIOS') Or blnUtiLot) Then
        Begin
          objEndArm.pCarregaArmazensEnderecados(FieldByName('FDO_CODITE').AsString, FieldByName('AUTOINCREM').AsString, cdsArmSel);

          dtsArmSel.DataSet      := cdsArmSel;
          dbgArmazens.DataSource := dtsArmSel;

          ntbLote.Visible    := True;
          btnMarDes.Visible      := True;

          Splitter1.Visible      := True;

        End
        Else
        Begin
          ntbLote.Visible := False;
          btnMarDes.Visible   := False;

          Splitter1.Visible   := False;
        End;
      End;
    end
    else
    begin
      objEnderecamento.objRastreamento.pFiltraMOVDET(cdsConsulta.FieldByName('SEQDET').AsString);
      pLimpaRastreamento;
    end;
  end
  Else
  Begin
    ntbLote.Visible := False;
    btnMarDes.Visible   := False;

    Splitter1.Visible   := False;
  End;

end;

procedure TfrmEntEnderecamentoProduto.pCancela(blnPerguntar: Boolean = True; blnAbort: Boolean = False);
Begin
  If (cdsConsulta.IsEmpty) or (not fEmptyStr(strAutoincremGERELE)) Then
  Begin
    Close;
    Exit;
  End;

  If (Not blnPerguntar) Or
     (fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1) Then
  Begin
    pLimpaPesquisa;
    pSetFocus(btnPesDoc);
    objEnderecamento.pLimpar;
    pAtualizaNtbLote;
    edtDocumento.Clear;
    objLock.pDestravarTodos;
  End;

//  If blnAbort Then
//    Abort;
End;

function TfrmEntEnderecamentoProduto.fChecaDados:boolean;
begin
  Result := not fEmptyStr(objEnderecamento.strAutIncPed);
  If not Result Then
  Begin
    If strAutoincremGERELE.IsEmpty Then
    Begin
      fMensagem('','Selecione o documento!', ['&Ok']);
      pSetFocus(btnPesDoc);
    End;
  End;

end;

function TfrmEntEnderecamentoProduto.fVerificaEdicaoEcommerce : Boolean;
var
  strDireitos : String;
begin
  fVerificaDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmCadProdutos');

  Result := (Pos('A', strDireitos) > 0);
end;

procedure TfrmEntEnderecamentoProduto.FormActivate(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(strAutoincremGERELE) then
  begin
    blnDocumentoNaoEncontrado := False;
    btnPesDoc.Enabled := False;
    objEnderecamento.pGetEnderecamentoByGERELE(strAutoincremGERELE);
    If fEmptyStr(objEnderecamento.strAutIncPed) Then
    Begin
      blnDocumentoNaoEncontrado := True;
      tmrClose.Enabled := True;
    End
    Else
      Try
        pCarregaEnderecamento;
      Except
        On E: Exception DO
        Begin
          pMensagemOk(E.Message);
          tmrClose.Enabled := True;
        End;
      End;
  end;
end;

procedure TfrmEntEnderecamentoProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TSalvaConfiguracaoGrid.pSalvaConfiguracoesDbGrid(dbGConsulta, Self.name);
end;

procedure TfrmEntEnderecamentoProduto.FormCreate(Sender: TObject);
begin
  inherited;
  blnCOFEND := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');
  blnUDEVME := (fCfgSis('UDEVME', varBoolean));
  blnFecharForm := False;
  strAutoincremGERELE := '';

  strTraLoc := fCfgSis('TRALOC');
  blnCDLTAU := (fCfgSis('CDLTAU', varBoolean)) And (Not fUsaRotinaWMS) And (fCfgSis('CTLEST', varString) = '1');
  objEnderecamento := TEnderecamentoProduto.Create;

  blnResLtp := fCfgSis('RESLTP', varBoolean);
  If blnResLtp Then
    objReservaEstAtiPre := TEnderecamentoProduto.Create;

  objEndArm :=  TEnderecamentoArmazem.Create(Self, prgProgresso);
  objLock   := TLock.Create;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  btnLocFis.Visible := blnCadLoc;

  btnEtiPro.Visible := fCfgSis('IMPETQ', varBoolean);
  btnQtdEti.Visible := fCfgSis('IMPETQ', varBoolean);

  dtsArmSel := TDataSource.Create(Self);

  blnSuprimirMensagem := False;

  clrCorZebra := fCfgSis('CORZEB');

  If fUsaRotinaWMS And fEmptyStr(fRetNomCliente(fCfgSis('CLI_TA'))) Then
  Begin
    pMensagemOk('Favor configurar corretamente o "Cliente para Transferência de Estoque entre armazéns/Lotes (CFG_CLI_TA)"!');
    blnFecharForm := True;
  End;
  btnEntregasPendentes.Visible := (fCfgSis('ENTFUT', varBoolean));

  shpGarantia.Visible := fCfgSis('REFENT', varBoolean);
  lblGarantia.Visible := fCfgSis('REFENT', varBoolean); // And (not fCfgSis('REFVEN', varBoolean)); a CFG_REFVEN, foi implementado apenas na menil e nao veio para a 30
  btnCadArm.Visible := Not blnCDLTAU;
  blnMoeXsi := fCfgSis('MOEXSI') <> '0';
  blnEditaEcomm := fVerificaEdicaoEcommerce;
end;

procedure TfrmEntEnderecamentoProduto.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLock);
  FreeAndNil(objEnderecamento);
  FreeAndNil(dtsArmSel);
  If Assigned(objReservaEstAtiPre) Then
    FreeAndNil(objReservaEstAtiPre);
  if Assigned(cdsArmSel) Then
    FreeAndNil(cdsArmSel);
  inherited;
end;

procedure TfrmEntEnderecamentoProduto.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_F1: begin
             if objEnderecamento.blnRastreamentoIndustrial then
             begin
               pLimpaRastreamento;
               pSetFocus(edtLoteRastreamento);
             end;
           end;
    VK_F2 : Begin
              Key := 0;
              btnDefineLoteEntFut.Click;
            End;
    VK_F4 : Begin
              Key := 0;
              btnEntregasPendentes.Click;
            End;

    VK_F6 : If btnEndArm.Visible Then
            Begin
              Key := 0;
              btnEndArm.Click;
            End;

    VK_F7 : Begin
              Key := 0;
              btnLocFis.Click;
            End;

    VK_F8 : Begin
              Key := 0;
              btnCadArm.Click;
            End;

    VK_F9 : Begin
              Key := 0;
              btnImprimir.Click;
            End;

    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_F11: Begin
              Key := 0;
              btnUmArm.Click;
            End;
    VK_F12: Begin
              Key := 0;
              btnReqComprasVinculadas.Click;
            End;

    VK_DELETE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;

    VK_ESCAPE: Begin
                 If pnlPesquisa.Visible Then
                   inherited
                 Else
                    pCancela(True, True);
               end;

    Else inherited;
  End;

end;

procedure TfrmEntEnderecamentoProduto.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;

  //btnSair.Top       := btnConfirma.Top;
end;

procedure TfrmEntEnderecamentoProduto.FormShow(Sender: TObject);
  var
    blnExibeDescricaoArmazem: boolean;
begin
  inherited;

  TSalvaConfiguracaoGrid.pCarregaConfiguracoesDbGrid(dbGConsulta, Self.name, True);

  If (objEndArm.tplTipLot <> tplArmazem) Then
  Begin
    btnCadArm.Visible := fUsaRotinaWMS;
    btnEndArm.Visible := False;
    btnUmArm.Visible  := False;
    //btnSair.Top       := btnConfirma.Top;
    //pnlBotoes.Height  := 30;

    fFindColumnByName(dbgConsulta, 'ARMAZE').Visible := fUsaRotinaWMS;
    blnArmazemVisivel := fUsaRotinaWMS;

    blnLocFisVisivel := True;

    If fUsaRotinaWMS Then
    Begin
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Visible := False;
      blnLocFisVisivel := False;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCF').Visible := False;
      fFindColumnByName(dbgConsulta, 'ITE_LOCSUP').Visible := False;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCS').Visible := False;

      fFindColumnByName(dbgConsulta, 'ARMAZE').Title.Caption := 'Lote';
      fFindColumnByName(dbgArmazens, 'NUMLOT').Title.Caption := 'Lote';

      btnCadArm.Caption := '[F8] Cad. Lotes';
    End;
  End;

  blnExibeDescricaoArmazem := ((fCfgSis('CONFME') = '1') And (fCfgSis('CTLEST') = '2'));
  blnPermiteFracionarQtd := fCfgSis('PERQPC', varBoolean);


  fFindColumnByName(dbgConsulta, 'AMZDES').Visible := blnExibeDescricaoArmazem;
  fFindColumnByName(dbgArmazens, 'AMZDES').Visible := blnExibeDescricaoArmazem;

  fFindColumnByName(dbgConsulta, 'LOT_DTAVAL').Visible := fCfgSis('CTLEST') = '1';

  If blnPermiteFracionarQtd Then
  Begin
    If Assigned(fFindColumnByName(dbgConsulta, 'QTDPAC')) Then
      fFindColumnByName(dbgConsulta, 'QTDPAC').Visible := True;
    If Assigned(fFindColumnByName(dbgConsulta, 'QTDFRA')) Then
      fFindColumnByName(dbgConsulta, 'QTDFRA').Visible := True;
  End;

  blnSempreRelerBanco  := FALSE;
  blnTemSelecao        := True;
  blnSelecionaComEnter := False;

  strCampoLista := 'SEQDET';   //CUIDAR AO MUDAR ESSE CAMPO, AFETA O ENDEREÇAMENTO ( T.A )


  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pSetFocus(btnPesDoc);

  btnDefineLoteEntFut.Visible := fVerificaAcessoSistema('frmFatDefineLoteEntregaFuturaFaltaProduto');
  getColumByFieldName('DEFSER').Visible := objEnderecamento.blnNumSer;

  if not objEnderecamento.blnRastreamentoIndustrial then
    ntbLote.ActivePage := 'pgCadastroLote'
  else begin
    ntbLote.ActivePage := 'pgRastreamentoLote';
    dtsRastreamentoLote.DataSet := objEnderecamento.objRastreamento.cdsRastreamentoLote;
  end;

  intNRO_COL_ARMAZE := fFindColumnByName(dbgConsulta, 'ARMAZE').Index;
  intNRO_COL_LOCFIS := fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Index;
  intNRO_COL_SUPEST := fFindColumnByName(dbgConsulta, 'ITE_LOCSUP').Index;

  If blnCofEnd Then
  Begin
    If Not Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDCOF')) Then
      AddColumn('ITE_QTDCOF','Qtd. Conferida');
    If Not Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDNOT')) Then
      AddColumn('ITE_QTDNOT','Qtd. Nota Fiscal');
    If Not  Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDEND')) Then
      AddColumn('ITE_QTDEND','Qtd. Endereçados');
    If Not  Assigned(fFindColumnByName(dbgConsulta, 'QTD_CONF_NAO_LIB_END')) Then
      AddColumn('QTD_CONF_NAO_LIB_END','Qtd. Conf. Não Liberada');
  End
  Else
  Begin
    If Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDCOF')) Then
      fFindColumnByName(dbgConsulta, 'ITE_QTDCOF').Visible := False;
    If Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDNOT')) Then
      fFindColumnByName(dbgConsulta, 'ITE_QTDNOT').Visible := False;
    If Assigned(fFindColumnByName(dbgConsulta, 'ITE_QTDEND')) Then
      fFindColumnByName(dbgConsulta, 'ITE_QTDEND').Visible := False;
    If Assigned(fFindColumnByName(dbgConsulta, 'QTD_CONF_NAO_LIB_END')) Then
      fFindColumnByName(dbgConsulta, 'QTD_CONF_NAO_LIB_END').Visible := False;
  End;
  If blnPermiteFracionarQtd Then
  Begin
    intNRO_COL_QTDPAC := fFindColumnByName(dbgConsulta, 'QTDPAC').Index;
    intNRO_COL_QTDFRA := fFindColumnByName(dbgConsulta, 'QTDFRA').Index;
  End
  Else
  Begin
    intNRO_COL_QTDPAC := 999;
    intNRO_COL_QTDFRA := 998;
  End;

  fFindColumnByName(dbgConsulta, 'PESOIT').Visible := blnMoeXsi;
  fFindColumnByName(dbgConsulta, 'EXPALT').Visible := blnMoeXsi;
  fFindColumnByName(dbgConsulta, 'EXPLAR').Visible := blnMoeXsi;
  fFindColumnByName(dbgConsulta, 'EXPPRO').Visible := blnMoeXsi;

  fFindColumnByName(dbgConsulta, 'PESOIT').ReadOnly := Not blnEditaEcomm;
  fFindColumnByName(dbgConsulta, 'EXPALT').ReadOnly := Not blnEditaEcomm;
  fFindColumnByName(dbgConsulta, 'EXPLAR').ReadOnly := Not blnEditaEcomm;
  fFindColumnByName(dbgConsulta, 'EXPPRO').ReadOnly := Not blnEditaEcomm;

  fFindColumnByName(dbgConsulta, 'PESOIT').Color := IIF(blnEditaEcomm, clYellow, clWhite);
  fFindColumnByName(dbgConsulta, 'EXPALT').Color := IIF(blnEditaEcomm, clYellow, clWhite);
  fFindColumnByName(dbgConsulta, 'EXPLAR').Color := IIF(blnEditaEcomm, clYellow, clWhite);
  fFindColumnByName(dbgConsulta, 'EXPPRO').Color := IIF(blnEditaEcomm, clYellow, clWhite);

  fFindColumnByName(dbgConsulta, 'PESOIT').Font.Color := IIF(blnEditaEcomm, clRed, clBlack);
  fFindColumnByName(dbgConsulta, 'EXPALT').Font.Color := IIF(blnEditaEcomm, clRed, clBlack);
  fFindColumnByName(dbgConsulta, 'EXPLAR').Font.Color := IIF(blnEditaEcomm, clRed, clBlack);
  fFindColumnByName(dbgConsulta, 'EXPPRO').Font.Color := IIF(blnEditaEcomm, clRed, clBlack);


end;

procedure TfrmEntEnderecamentoProduto.btnImprimirClick(Sender: TObject);
  var
    strNomFil,
    strTipImp,
    strLayPadrao,
    strEmpSal: String;
    fltCnvML: Double;
    intCalSal: Integer;
    cdsRelato: TUniClientDataSet;
    intCorre : Integer;
    objImpressao: TEditorFastImpressao;
    stlListaItens: TStringList;
    objSalLoj: TSaldoLojas;
    qryEditor : TUniQuery;
    strSQLCreateProd, strSQLCreateLote : String;

  procedure AddItem;
    Var
      intCorre : Integer;
  Begin
    With cdsConsulta Do
    Begin
      cdsRelato.Append;

      For intCorre := 0 to FieldCount - 1 Do
        cdsRelato.Fields[intCorre].Value := Fields[intCorre].Value;

      cdsRelato.Post;
    End;
  End;

begin
  inherited;
  if not fChecaDados Then Exit;

  If (Not cdsConsulta.Active) Then
    Exit;

  If fLoteFoiCadastradaDuranteProcessoEnderecamento Then
    Exit;

  pLimpaPesquisa;

  Application.ProcessMessages;

  Try

    cdsRelato := TUniClientDataSet.Create(Self);
    stlListaItens := TStringList.Create;
    objSalLoj := TSaldoLojas.Create(Self);

    intCalSal := fCfgSis('CALSAL', varInteger);

    For intCorre := 0 To cdsConsulta.FieldDefs.Count - 1 Do
      cdsRelato.FieldDefs.Add(cdsConsulta.FieldDefs[intCorre].Name, cdsConsulta.FieldDefs[intCorre].DataType, cdsConsulta.FieldDefs[intCorre].Size, False );

    cdsRelato.CreateDataSet;

    cdsConsulta.DisableControls;

    if (not cdsConsulta.Active) then
      cdsConsulta.Open;

      cdsConsulta.First;

      While Not cdsConsulta.Eof Do
      Begin

      cdsConsulta.Edit;
      fltCnvML := 0;
      objSalLoj.pCalculaSaldos(cdsConsulta, recSaldos, recSaldosML,
                               cdsConsulta.FieldByName('ITE_SALDOS').AsFloat, strEmpSal, strEmpSal,
                               cdsConsulta.FieldByName('FDO_CODITE').AsString,
                               fltCnvML, False, False,
                               False, intCalSal);
      cdsConsulta.FieldByName('ITE_SALDSP').AsFloat  := recSaldos.fltSalDis;
      cdsConsulta.Post;

      AddItem;

      //Alterado para sempre na geração do relatório buscar o saldo do armazem/lote para mostrar o resultado apos o enderaçamento. Req: 138264
      If (Not fEmptyStr(cdsConsulta.FieldByName('ARMAZE').AsString)) Then
      Begin
        objEndArm.pCarregaArmazensEnderecados(cdsConsulta.FieldByName('FDO_CODITE').AsString, cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsArmSel);

        While Not cdsArmSel.Eof Do
        Begin
          If Assigned(cdsRelato.FindField('SEQDET')) Then
            cdsRelato.Locate('SEQDET', cdsConsulta.FieldByName('SEQDET').AsString,[])
          Else
            cdsRelato.Locate('FDO_CODITE', cdsConsulta.FieldByName('FDO_CODITE').AsString,[]);

          cdsRelato.Edit;
          cdsRelato.FieldByName('FDO_QTDITE').AsFloat  := cdsArmSel.FieldByName('QTDITE').AsFloat;
          cdsRelato.FieldByName('ARMAZE').AsString     := cdsArmSel.FieldByName('NUMLOT').AsString;
          cdsRelato.FieldByName('ITE_LOCFIS').AsString := cdsArmSel.FieldByName('LOCFIS').AsString;
          cdsRelato.FieldByName('LOT_SALDOS').AsString := FloatToStr(StrToFloat(cdsArmSel.FieldByName('SALDOS').AsString) + cdsArmSel.FieldByName('QTDITE').AsFloat);
          cdsRelato.Post;

          stlListaItens.Add(cdsConsulta.FieldByName('FDO_CODITE').AsString);
          cdsArmSel.Next;
        End;
      End
      Else
      begin
        stlListaItens.Add(cdsConsulta.FieldByName('FDO_CODITE').AsString);
      end;

      cdsConsulta.Next;
    End;

    cdsConsulta.EnableControls;

    strLayPadrao := fCampoTabela('LAY_CODLAY', 'LAYETI', ['LAY_TIPLAY', 'LAY_CODEMP', 'LAY_PADRAO'], [ARR_TIPO_LAYOUT[tpeEnderecamentoDeProduto], VS_strCodEmp, 'S']);

    if (not fEmptyStr(strLayPadrao))  then
    begin

      pCarregaConfImpr(qryCfgRel, Self.Name);
      fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

      objImpressao := TEditorFastImpressao.Create(Nil);

      try

        objImpressao.recDocume.blnEnderecamentoDeProduto := True;
        objImpressao.recDocume.strCodLay := strLayPadrao;
        objImpressao.recDocume.strNomImp := strNomFil;
        objImpressao.recDocume.strTipImp := strTipImp;
        objImpressao.recDocume.strIncPed := objEnderecamento.strAutIncPed;
        objImpressao.recDocume.stlListaItens := stlListaItens;
        objImpressao.fImprimeDocumento(tpaNormal);

      finally
        FreeAndNil(objImpressao);
      end;

    end
    else
    begin

      qryEditor := fCriaQuery(nil);

      strSQLCreateProd := '';
      strSQLCreateProd := strSQLCreateProd + 'DROP TEMPORARY TABLE IF EXISTS TMP_REL_END_PRODUTOS; ';
      strSQLCreateProd := strSQLCreateProd + 'CREATE TEMPORARY TABLE TMP_REL_END_PRODUTOS (	';
      strSQLCreateProd := strSQLCreateProd + '    SEQDET VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    DET_CODFOR VARCHAR (9), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_DIGCON VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_SEQIND INT, ';
      strSQLCreateProd := strSQLCreateProd + '    DET_NITEM_ INT, ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_NUMDOC VARCHAR (13), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_ESPDOC VARCHAR (3), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_CODEMP VARCHAR (4), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_CODITE VARCHAR (7), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_NUMLOT VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_DESCRI VARCHAR (102), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_REFERE VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    UNI_SIGUNI VARCHAR (5), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_QTDITE DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_SALDOS DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_CNV_ML DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_PROACA VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_CODACA VARCHAR (7), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_EMPACA VARCHAR (4), ';
      strSQLCreateProd := strSQLCreateProd + '    FDO_IDEPRO VARCHAR (4), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_SALFIS DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_SALDSP DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_CODBAR VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_CODFAB VARCHAR (51), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_LOCFIS VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_LOCSUP VARCHAR (11), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_USASER VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    LOCTST VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    SUPTST VARCHAR (11), ';
      strSQLCreateProd := strSQLCreateProd + '    LOCANT VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    SUPANT VARCHAR (11), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_TAMLCF VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_TAMLCS VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    ITE_NVLGIR VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    DEFSER INT, ';
      strSQLCreateProd := strSQLCreateProd + '    ARMAZE VARCHAR (31), ';
      strSQLCreateProd := strSQLCreateProd + '    DISTRI VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    LOT_SALDOS DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    TEMLOT VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    REMLOC VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    REFUGO VARCHAR (2), ';
      strSQLCreateProd := strSQLCreateProd + '    QTDEFA DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    QTDEFF DECIMAL (20, 4), ';
      strSQLCreateProd := strSQLCreateProd + '    MEN001 VARCHAR (201), ';
      strSQLCreateProd := strSQLCreateProd + '    GARANT INT, ';
      strSQLCreateProd := strSQLCreateProd + '    AUTOINCREM VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    AMZDES VARCHAR (21), ';
      strSQLCreateProd := strSQLCreateProd + '    LOT_DTAVAL DATE, ';
      strSQLCreateProd := strSQLCreateProd + '    DESMAR VARCHAR (31) ';
      strSQLCreateProd := strSQLCreateProd + '); ';

      qryEditor.SQL.Clear;
      qryEditor.SQL.Text := strSQLCreateProd;
      qryEditor.ExecSQL;

      strSQLCreateLote := '';
      strSQLCreateLote := strSQLCreateLote + 'DROP TEMPORARY TABLE IF EXISTS TMP_REL_END_LOTES; ';
      strSQLCreateLote := strSQLCreateLote + 'CREATE TEMPORARY TABLE TMP_REL_END_LOTES ( ';
      strSQLCreateLote := strSQLCreateLote + '    AUTINC VARCHAR (21), ';
      strSQLCreateLote := strSQLCreateLote + '    CODITE VARCHAR (21), ';
      strSQLCreateLote := strSQLCreateLote + '    NUMLOT VARCHAR (31), ';
      strSQLCreateLote := strSQLCreateLote + '    ARMORI VARCHAR (31), ';
      strSQLCreateLote := strSQLCreateLote + '    ARMDES VARCHAR (31), ';
      strSQLCreateLote := strSQLCreateLote + '    LOCFIS VARCHAR (21), ';
      strSQLCreateLote := strSQLCreateLote + '    DTAVAL DATE, ';
      strSQLCreateLote := strSQLCreateLote + '    CAPANT DECIMAL (20, 4), ';
      strSQLCreateLote := strSQLCreateLote + '    CAPACI DECIMAL (20, 4), ';
      strSQLCreateLote := strSQLCreateLote + '    SALDOS DECIMAL (20, 4), ';
      strSQLCreateLote := strSQLCreateLote + '    QTDITE DECIMAL (20, 4), ';
      strSQLCreateLote := strSQLCreateLote + '    QTDTOT DECIMAL (20, 4), ';
      strSQLCreateLote := strSQLCreateLote + '    AMZDES VARCHAR (31), ';
      strSQLCreateLote := strSQLCreateLote + '    DTAFAB DATETIME ';
      strSQLCreateLote := strSQLCreateLote + ');  ';

      qryEditor.SQL.Clear;
      qryEditor.SQL.Text := strSQLCreateLote;
      qryEditor.ExecSQL;


      cdsRelato.First;
      while not cdsRelato.Eof do
      begin

        qryEditor.SQL.Clear;
        qryEditor.SQL.Add('INSERT INTO TMP_REL_END_PRODUTOS(');
        qryEditor.SQL.Add('  SEQDET, DET_CODFOR, ITE_DIGCON, FDO_SEQIND, DET_NITEM_, FDO_NUMDOC, ');
        qryEditor.SQL.Add('  FDO_ESPDOC, FDO_CODEMP, FDO_CODITE, FDO_NUMLOT, FDO_DESCRI, FDO_REFERE, ');
        qryEditor.SQL.Add('  UNI_SIGUNI, FDO_QTDITE, ITE_SALDOS, ITE_CNV_ML, FDO_PROACA, FDO_CODACA, ');
        qryEditor.SQL.Add('  FDO_EMPACA, FDO_IDEPRO, ITE_SALFIS, ITE_SALDSP, ITE_CODBAR, ITE_CODFAB, ');
        qryEditor.SQL.Add('  ITE_LOCFIS, ITE_LOCSUP, ITE_USASER, LOCTST, SUPTST, LOCANT, SUPANT, ');
        qryEditor.SQL.Add('  ITE_TAMLCF, ITE_TAMLCS, ITE_NVLGIR, DEFSER, ARMAZE, DISTRI, LOT_SALDOS, ');
        qryEditor.SQL.Add('  TEMLOT, REMLOC, REFUGO, QTDEFA, QTDEFF, MEN001, GARANT, AUTOINCREM, AMZDES, ');
        qryEditor.SQL.Add('  LOT_DTAVAL, DESMAR');
        qryEditor.SQL.Add(')VALUES(');
        qryEditor.SQL.Add('  :SEQDET, :DET_CODFOR, :ITE_DIGCON, :FDO_SEQIND, :DET_NITEM_, :FDO_NUMDOC, ');
        qryEditor.SQL.Add('  :FDO_ESPDOC, :FDO_CODEMP, :FDO_CODITE, :FDO_NUMLOT, :FDO_DESCRI, :FDO_REFERE, ');
        qryEditor.SQL.Add('  :UNI_SIGUNI, :FDO_QTDITE, :ITE_SALDOS, :ITE_CNV_ML, :FDO_PROACA, :FDO_CODACA, ');
        qryEditor.SQL.Add('  :FDO_EMPACA, :FDO_IDEPRO, :ITE_SALFIS, :ITE_SALDSP, :ITE_CODBAR, :ITE_CODFAB, ');
        qryEditor.SQL.Add('  :ITE_LOCFIS, :ITE_LOCSUP, :ITE_USASER, :LOCTST, :SUPTST, :LOCANT, :SUPANT, ');
        qryEditor.SQL.Add('  :ITE_TAMLCF, :ITE_TAMLCS, :ITE_NVLGIR, :DEFSER, :ARMAZE, :DISTRI, :LOT_SALDOS, ');
        qryEditor.SQL.Add('  :TEMLOT, :REMLOC, :REFUGO, :QTDEFA, :QTDEFF, :MEN001, :GARANT, :AUTOINCREM, :AMZDES, ');
        qryEditor.SQL.Add('  :LOT_DTAVAL, :DESMAR');
        qryEditor.SQL.Add(');');
        qryEditor.ParamByName('SEQDET').AsString := cdsRelato.FieldByName('SEQDET').AsString;
        qryEditor.ParamByName('DET_CODFOR').AsString := cdsRelato.FieldByName('DET_CODFOR').AsString;
        qryEditor.ParamByName('ITE_DIGCON').AsString := cdsRelato.FieldByName('ITE_DIGCON').AsString;
        qryEditor.ParamByName('FDO_SEQIND').AsInteger := cdsRelato.FieldByName('FDO_SEQIND').AsInteger;
        qryEditor.ParamByName('DET_NITEM_').AsInteger := cdsRelato.FieldByName('DET_NITEM_').AsInteger;
        qryEditor.ParamByName('FDO_NUMDOC').AsString := cdsRelato.FieldByName('FDO_NUMDOC').AsString;
        qryEditor.ParamByName('FDO_ESPDOC').AsString := cdsRelato.FieldByName('FDO_ESPDOC').AsString;
        qryEditor.ParamByName('FDO_CODEMP').AsString := cdsRelato.FieldByName('FDO_CODEMP').AsString;
        qryEditor.ParamByName('FDO_CODITE').AsString := cdsRelato.FieldByName('FDO_CODITE').AsString;
        qryEditor.ParamByName('FDO_NUMLOT').AsString := cdsRelato.FieldByName('FDO_NUMLOT').AsString;
        qryEditor.ParamByName('FDO_DESCRI').AsString := cdsRelato.FieldByName('FDO_DESCRI').AsString;
        qryEditor.ParamByName('FDO_REFERE').AsString := cdsRelato.FieldByName('FDO_REFERE').AsString;
        qryEditor.ParamByName('UNI_SIGUNI').AsString := cdsRelato.FieldByName('UNI_SIGUNI').AsString;
        qryEditor.ParamByName('FDO_QTDITE').AsFloat := cdsRelato.FieldByName('FDO_QTDITE').AsFloat;
        qryEditor.ParamByName('ITE_SALDOS').AsFloat := cdsRelato.FieldByName('ITE_SALDOS').AsFloat;
        qryEditor.ParamByName('ITE_CNV_ML').AsFloat := cdsRelato.FieldByName('ITE_CNV_ML').AsFloat;
        qryEditor.ParamByName('FDO_PROACA').AsString := cdsRelato.FieldByName('FDO_PROACA').AsString;
        qryEditor.ParamByName('FDO_CODACA').AsString := cdsRelato.FieldByName('FDO_CODACA').AsString;
        qryEditor.ParamByName('FDO_EMPACA').AsString := cdsRelato.FieldByName('FDO_EMPACA').AsString;
        qryEditor.ParamByName('FDO_IDEPRO').AsString := cdsRelato.FieldByName('FDO_IDEPRO').AsString;
        qryEditor.ParamByName('ITE_SALFIS').AsFloat := cdsRelato.FieldByName('ITE_SALFIS').AsFloat;
        qryEditor.ParamByName('ITE_SALDSP').AsFloat := cdsRelato.FieldByName('ITE_SALDSP').AsFloat;
        qryEditor.ParamByName('ITE_CODBAR').AsString := cdsRelato.FieldByName('ITE_CODBAR').AsString;
        qryEditor.ParamByName('ITE_CODFAB').AsString := cdsRelato.FieldByName('ITE_CODFAB').AsString;
        qryEditor.ParamByName('ITE_LOCFIS').AsString := cdsRelato.FieldByName('ITE_LOCFIS').AsString;
        qryEditor.ParamByName('ITE_LOCSUP').AsString := cdsRelato.FieldByName('ITE_LOCSUP').AsString;
        qryEditor.ParamByName('ITE_USASER').AsString := cdsRelato.FieldByName('ITE_USASER').AsString;
        qryEditor.ParamByName('LOCTST').AsString := cdsRelato.FieldByName('LOCTST').AsString;
        qryEditor.ParamByName('SUPTST').AsString := cdsRelato.FieldByName('SUPTST').AsString;
        qryEditor.ParamByName('LOCANT').AsString := cdsRelato.FieldByName('LOCANT').AsString;
        qryEditor.ParamByName('SUPANT').AsString := cdsRelato.FieldByName('SUPANT').AsString;
        qryEditor.ParamByName('ITE_TAMLCF').AsString := cdsRelato.FieldByName('ITE_TAMLCF').AsString;
        qryEditor.ParamByName('ITE_TAMLCS').AsString := cdsRelato.FieldByName('ITE_TAMLCS').AsString;
        qryEditor.ParamByName('ITE_NVLGIR').AsString := cdsRelato.FieldByName('ITE_NVLGIR').AsString;
        qryEditor.ParamByName('DEFSER').AsInteger := cdsRelato.FieldByName('DEFSER').AsInteger;
        qryEditor.ParamByName('ARMAZE').AsString := cdsRelato.FieldByName('ARMAZE').AsString;
        qryEditor.ParamByName('DISTRI').AsString := cdsRelato.FieldByName('DISTRI').AsString;
        qryEditor.ParamByName('LOT_SALDOS').AsFloat := cdsRelato.FieldByName('LOT_SALDOS').AsFloat;
        qryEditor.ParamByName('TEMLOT').AsString := cdsRelato.FieldByName('TEMLOT').AsString;
        qryEditor.ParamByName('REMLOC').AsString := cdsRelato.FieldByName('REMLOC').AsString;
        qryEditor.ParamByName('REFUGO').AsString := cdsRelato.FieldByName('REFUGO').AsString;
        qryEditor.ParamByName('QTDEFA').AsFloat := cdsRelato.FieldByName('QTDEFA').AsFloat;
        qryEditor.ParamByName('QTDEFF').AsFloat := cdsRelato.FieldByName('QTDEFF').AsFloat;
        qryEditor.ParamByName('MEN001').AsString := cdsRelato.FieldByName('MEN001').AsString;
        qryEditor.ParamByName('GARANT').AsInteger := cdsRelato.FieldByName('GARANT').AsInteger;
        qryEditor.ParamByName('AUTOINCREM').AsString := cdsRelato.FieldByName('AUTOINCREM').AsString;
        qryEditor.ParamByName('AMZDES').AsString := cdsRelato.FieldByName('AMZDES').AsString;
        qryEditor.ParamByName('LOT_DTAVAL').AsDateTime := cdsRelato.FieldByName('LOT_DTAVAL').AsDateTime;
        qryEditor.ParamByName('DESMAR').AsString := cdsRelato.FieldByName('DESMAR').AsString;
        qryEditor.ExecSQL;

        objEndArm.pCarregaArmazensEnderecados(cdsRelato.FieldByName('FDO_CODITE').AsString,
                                              cdsRelato.FieldByName('AUTOINCREM').AsString,
                                              cdsArmSel);

        cdsArmSel.First;
        while not cdsArmSel.Eof do
        begin

          qryEditor.SQL.Clear;
          qryEditor.SQL.Add('INSERT INTO TMP_REL_END_LOTES(');
          qryEditor.SQL.Add('  AUTINC, CODITE, NUMLOT, ARMORI, ARMDES, LOCFIS, DTAVAL, ');
          qryEditor.SQL.Add('  CAPANT, CAPACI, SALDOS, QTDITE, QTDTOT, AMZDES, DTAFAB ');
          qryEditor.SQL.Add(')VALUES(');
          qryEditor.SQL.Add('  :AUTINC, :CODITE, :NUMLOT, :ARMORI, :ARMDES, :LOCFIS, :DTAVAL, ');
          qryEditor.SQL.Add('  :CAPANT, :CAPACI, :SALDOS, :QTDITE, :QTDTOT, :AMZDES, :DTAFAB ');
          qryEditor.SQL.Add(');');
          qryEditor.ParamByName('AUTINC').AsString := cdsArmSel.FieldByName('AUTINC').AsString;
          qryEditor.ParamByName('CODITE').AsString := cdsArmSel.FieldByName('CODITE').AsString;
          qryEditor.ParamByName('NUMLOT').AsString := cdsArmSel.FieldByName('NUMLOT').AsString;
          qryEditor.ParamByName('ARMORI').AsString := cdsArmSel.FieldByName('ARMORI').AsString;
          qryEditor.ParamByName('ARMDES').AsString := cdsArmSel.FieldByName('ARMDES').AsString;
          qryEditor.ParamByName('LOCFIS').AsString := cdsArmSel.FieldByName('LOCFIS').AsString;
          qryEditor.ParamByName('DTAVAL').AsDateTime := cdsArmSel.FieldByName('DTAVAL').AsDateTime;
          qryEditor.ParamByName('CAPANT').AsFloat := cdsArmSel.FieldByName('CAPANT').AsFloat;
          qryEditor.ParamByName('CAPACI').AsFloat := cdsArmSel.FieldByName('CAPACI').AsFloat;
          qryEditor.ParamByName('SALDOS').AsFloat := cdsArmSel.FieldByName('SALDOS').AsFloat;
          qryEditor.ParamByName('QTDITE').AsFloat := cdsArmSel.FieldByName('QTDITE').AsFloat;
          qryEditor.ParamByName('QTDTOT').AsFloat := cdsArmSel.FieldByName('QTDTOT').AsFloat;
          qryEditor.ParamByName('AMZDES').AsString := cdsArmSel.FieldByName('AMZDES').AsString;
          qryEditor.ParamByName('DTAFAB').AsDateTime := cdsArmSel.FieldByName('DTAFAB').AsDateTime;
          qryEditor.ExecSQL;

          cdsArmSel.Next;
        end;


        cdsRelato.Next;

      end;

      qryEditor.Close;
      qryEditor.SQL.Clear;
      qryEditor.SQL.Text := 'SET @DOCEND := :DOCEND;';
      qryEditor.ParamByName('DOCEND').AsString := edtDocumento.Text;
      qryEditor.ExecSQL;

      if Assigned(prcExecutaRelatorio) then
      begin
        prcExecutaRelatorio(423, 21228, [], [], [], nil, [], True);
      end;

      FreeAndNil(qryEditor);
      FreeAndNil(cdsRelato);
      FreeAndNil(objSalLoj);

    end;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryEditor);
      FreeAndNil(cdsRelato);
      pMensagensErro(E.Message,'[]');
    End;
  End;
end;

procedure TfrmEntEnderecamentoProduto.btnLocFisClick(Sender: TObject);
begin
  inherited;

  If Not btnLocFis.Visible Then
    Exit;

  If fUsaRotinaWMS And Not fVerificaAcessoSistema('frmCadLocFisica') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Localização Física!', ['&O k']);
    Exit;
  End;

  pCriarForm(TfrmCadLocFisica);

end;

procedure TfrmEntEnderecamentoProduto.btnMarDesClick(Sender: TObject);
begin
  inherited;

  pAddListaQuery;
  dbgConsulta.Refresh;
end;

procedure TfrmEntEnderecamentoProduto.btnMarLotMarcadosClick(Sender: TObject);
begin
  inherited;

  pSetaLote(False);

end;

procedure TfrmEntEnderecamentoProduto.pSetaLote(blnTodos: Boolean);
  Var
    frmGravando: TfrmGravando;
Begin
  FTodos := blnTodos;

  TfrmGravando.fExecuta(fSetaLotePrg, frmGravando, 'Atualizando lotes...');
End;

Function TfrmEntEnderecamentoProduto.fSetaLotePrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    strNumLot, strLocFis, strAmzDes: String;
    frmMensagem: TfrmMensagemExplicativa;
Begin
  Result := False;

  If dtsConsulta.DataSet.IsEmpty Then
    Exit;

  If Not objEnderecamento.cdsTodosLotes.Locate('MARCAD', 'S', []) Then
  Begin
    pMensagemOk('Selecione um lote para a transferência!');
    Exit;
  End;

  If (Not FTodos) And (stlListSelecao.Count = 0) Then
  Begin
    pMensagemOk('Nenhum registro selecionado!');
    Exit;
  End;

  With cdsConsulta Do
  Begin
    prgProgresso.Properties.Max := RecordCount;

    If Assigned(objEndArm.stlMesagemErros) Then
      objEndArm.stlMesagemErros.Clear;

    cdsConsulta.BeforePost := Nil;
    First;
    cdsConsulta.BeforePost := pConsultaBeforePost;
    While Not Eof Do
    Begin

      If (FieldByName('TEMLOT').AsString = '1') And (FTodos Or fInLista) And
         objEndArm.fEnderecaArmazens(FieldByName('FDO_CODITE').AsString,
                                     FieldByName('FDO_DESCRI').AsString,
                                     FieldByName('AUTOINCREM').AsString,
                                     FieldByName('FDO_NUMLOT').AsString,
                                     FieldByName('FDO_QTDITE').AsFloat,
                                     FieldByName('REFUGO').AsString = 'S',
                                     strNumLot, strLocFis, strAmzDes,
                                     objEnderecamento.cdsTodosLotes.FieldByName('NUMLOT').AsString,
                                     FieldByName(strCampoLista).AsString) Then
        objEndArm.pAtualizaScrollArmazens(cdsConsulta, strNumLot, strLocFis, strAmzDes);

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  End;

  pAtualizaNtbLote;

  pDesmarcaTodos;

  If Assigned(objEndArm.stlMesagemErros) And (objEndArm.stlMesagemErros.Count > 0) Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagem);
    Try
      frmMensagem.Caption := 'Atenção';

      frmMensagem.mmoInstru.Lines.Clear;
	    frmMensagem.mmoInstru.Lines := objEndArm.stlMesagemErros;

      frmMensagem.Showmodal;
      Exit;

    Finally
      FreeAndNil(frmMensagem);
    End;
  End;

  Result := True;
End;

function TfrmEntEnderecamentoProduto.fTemProAcaSim: Boolean;
begin
  Result := False;

  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) then
    Exit;

  cdsConsulta.DisableControls;
  Try
    cdsConsulta.First;
    while not cdsConsulta.Eof Do
    Begin
      If cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S' Then
        Exit(True);

      cdsConsulta.Next;
    End;
    cdsConsulta.First;
  Finally
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  End;

end;

procedure TfrmEntEnderecamentoProduto.btnPesDocClick(Sender: TObject);
Var
  qryGenGer: TUniQuery;
  chrKey: Char;
  arrEndProd: TConsultasArray;
begin
  inherited;

  Try
    qryGenGer := fCriaQuery(Self);

    chrKey := '/';

    If Not fPesqEnderecamentoProduto(Self.Name, nil, qryGenGer, chrKey, arrEndProd) then
    begin
      objEnderecamento.pLimpar;
      edtDocumento.Clear;
      objLock.pDestravarTodos;

      fMensagem('ATENÇÃO!', 'Selecione o documento para conferência!', ['&O k']);
    end
    Else If qryGenGer.IsEmpty Then
    Begin
      objEnderecamento.pLimpar;
      edtDocumento.Clear;
      objLock.pDestravarTodos;
      fMensagem('ATENÇÃO!', 'Selecione o documento para conferência!', ['&O k']);
    End
    Else
    begin
      objEnderecamento.strAutIncPed := qryGenGer.FieldByName('AUTOINCREM').AsString;
      If TEnderecamentoConferenciaParcial.ConferenciaSemDigConCorreta(qryGenGer.FieldByName('AUTOINCREM').AsString) Then
      Begin
        objEnderecamento.pLimpar;
        edtDocumento.Clear;
        raise Exception.Create('A Conferência foi feita em outra vesão do Autcom, ' +
          'por motivos de compatibilidade esta versão não pode realizar o endereçamento!');
      End;
      Try
        pCarregaEnderecamento;
      Except
        On E: Exception Do
        Begin
          pMensagemOk(E.Message);
          objEnderecamento.pLimpar;
          edtDocumento.Clear;
          objLock.pDestravarTodos;
        End;
      End;
      If Not blnLocFisVisivel Then
        fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Visible := fTemProAcaSim;
    end;
  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TfrmEntEnderecamentoProduto.pCarregaEnderecamento();
var
  strTrava: String;
  strNom_FC: String;
  LblnCOFTRA: Boolean;
  LDistribuicaoConferencia: TDistribuicaoConferencia;
begin

    If fConferenciaDepoisDaEntrada And (Not blnCofEnd)  And ((not fDocumentoConferido(objEnderecamento.strAutIncPed)) OR
       (not fDocumentoConferidoSimplificado(objEnderecamento.endDocumento.strCodEmp, objEnderecamento.endDocumento.strNumDoc, objEnderecamento.endDocumento.strCliFor))) Then
    Begin
    objEnderecamento.pLimpar;
    edtDocumento.Clear;
    objLock.pDestravarTodos;
    pMensagemOK('Não é permitido endereçar um documento que não foi conferido!');
    Exit;
  End;


  strTrava := fGetChaveDocumento(objEnderecamento.endDocumento.strNumDoc,
                                 objEnderecamento.endDocumento.strCodEmp,
                                 objEnderecamento.endDocumento.strCliFor);

  objLock.pDestravarTodos;

  If Not objLock.fLock_Unlock(strTrava, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse documento já está sendo endereçado em outra estação: ' + fGetHostLock(strTrava + '%'), ['&Ok']);

    objEnderecamento.pLimpar;
    edtDocumento.Clear;

    Exit;
  End;

  cdsConsulta.AfterScroll := nil;

  LblnCOFTRA := (fEhEntradaSimplificada(objEnderecamento.endDocumento)
    And (fCfgSis('COFTRA', varString) = 'S'))
    And (fCfgSis('CONSIM', varString) <> 'N');

  If LblnCOFTRA then
  begin
     If not TDistribuicaoConferencia.ReservaTemDigCon(objEnderecamento.strAutIncPed) then
     begin
       lDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorFatGorEntradaSimplificada(objEnderecamento.strAutIncPed);
       Try
         Try
           lDistribuicaoConferencia.fGravaLiberacaoEnderecamento;
         Finally
           FreeAndNil(lDistribuicaoConferencia);
         End;
       Except On
         E:Exception Do
         Begin
           pMensagensErro(E.Message,'[TfrmEntEnderecamentoProduto.pCarregaEnderecamento]');
           FreeAndNil(lDistribuicaoConferencia);
         End;
       End;
     End;
  End;
  If fAbreConsulta(True) Then
  Begin
    blnUtiLot    := fUtiLot;
    {blnNaoUtiLot := fNaoUtiLot;}
    cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
    cdsConsulta.First;

    If objEnderecamento.endDocumento.strTip_FC = 'C' Then
      strNom_FC := fRetNomCliente(objEnderecamento.endDocumento.strCliFor)
    Else
      strNom_FC := fRetNomFornecedor(objEnderecamento.endDocumento.strCliFor);

                            // exibe o número da ordem de produção
      edtDocumento.Text := IfThen(objEnderecamento.endDocumento.strEspDoc = 'OP',
                                  fCampoTabela('GER_ORDPRO',
                                               'MOVGER',
                                               ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'IFNULL(GER_CODFOR, "")' ],
                                               [objEnderecamento.endDocumento.strNumDoc,
                                                objEnderecamento.endDocumento.strEspDoc,
                                                objEnderecamento.endDocumento.strCodEmp,
                                                objEnderecamento.endDocumento.strCliFor]),
                                  objEnderecamento.endDocumento.strNumDoc) + '-' +
                                  objEnderecamento.endDocumento.strEspDoc + ' ' +
                                  objEnderecamento.endDocumento.strSerie_ + ' ' +
                                  objEnderecamento.endDocumento.strCodEmp + ' ' +
                                  objEnderecamento.endDocumento.strTip_FC +
                                  objEnderecamento.endDocumento.strCliFor + '-' +
                                  strNom_FC;

      cdsConsulta.DisableControls;
      Try
        cdsConsulta.First;
        If objEnderecamento.blnNumSer Then
        Begin
          blnDocTE := False;

          blnDocTE :=  (objEnderecamento.endDocumento.strTip_FC  = 'F') And fFornecedorFilial(objEnderecamento.endDocumento.strCliFor);

          while Not cdsConsulta.Eof do
          begin
            If cdsConsulta.FieldByName('ITE_USASER').AsString = 'S' Then
              objEnderecamento.objListaNumSerie.pAdd(cdsConsulta.FieldByName('SEQDET').AsString, tpEntrada, '', cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('DEVOLU').AsString = 'S');
            cdsConsulta.Next;
          End;
        End;
      Finally
        cdsConsulta.First;
        cdsConsulta.EnableControls;
      End;

    if blnCofEnd and (cdsConsulta.FieldByName('AUX_ENTSIM').AsString = 'N') and (cdsConsulta.FieldByName('TEM_DIGCON').AsInteger = 0) then
    begin
      cdsConsulta.Close;
      raise Exception.Create('É preciso finalizar a conferência ou liberar para endereçamento parcial!');
    end;


    If (blnCDLTAU) And (Not cdsConsulta.IsEmpty)Then
      pEnderecamentoAutomatico;
    pSetFocus(dbgConsulta);

    If (blnUDEVME) then
      If cdsConsulta.IsEmpty Then
        case objEnderecamento.fSituacaoEnderecamento(objEnderecamento.strAutIncPed) of
          seAguardandoDevolucao: raise Exception.Create('É necessário finalizar a devolução para concluir o endereçamento!');
          seAguardandoConferencia: raise Exception.Create('É necessário finalizar a conferência parcial para concluir o endereçamento!');
        else
          raise Exception.Create('É necessário finalizar a devolução para concluir o endereçamento!');
        End;
  End;
end;

procedure TfrmEntEnderecamentoProduto.btnPesDocEnter(Sender: TObject);
begin
  inherited;
  cdsConsulta.Close;

  If Assigned(objEnderecamento) And Assigned(objEnderecamento.cdsTodosLotes) Then
   objEnderecamento.cdsTodosLotes.Close;

  objEnderecamento.pLimpar;
  edtDocumento.Clear;
  objLock.pDestravarTodos;
end;

procedure TfrmEntEnderecamentoProduto.btnReqComprasVinculadasClick(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.IsEmpty Then
    Exit;

   prcExecutaRelatorio(58, 4949, [],
                        ['CODITE'],
                        [cdsConsulta.FieldByName('FDO_CODITE').AsString],
                        nil,
                        nil,
                        True);
end;

procedure TfrmEntEnderecamentoProduto.btnSairClick(Sender: TObject);
begin
  pCancela;
end;

procedure TfrmEntEnderecamentoProduto.btnUmArmClick(Sender: TObject);
begin
  inherited;

  objEndArm.pInformaArmazemUnico(cdsConsulta);
end;

Function TfrmEntEnderecamentoProduto.fValidaLocFisica(fldCampo: TField; strNomCam: String; Var blnRemoverLocFis: Boolean; blnTravar: Boolean): Boolean;
  Var
    strItem,
    strLote: String;
    fltSalLot, fltSalLotML: Double;
Begin
  Result := True;
  blnRemoverLocFis := False;

  If fUsaRotinaWMS Then
    Exit;

  With cdsConsulta, objEndArm Do
  If (Not fEmptyStr(fldCampo.AsString)) Then
  Begin

    If fEmptyStr(fRetNomLocFisica(fldCampo.AsString)) Then
    Begin
      pMensagemOk(strNomCam + ' não encontrada!');
      Result := False;
    End

    Else If (FieldByName('TEMLOT').AsInteger = 0)  And fTemProdutoComLocFisica(fldCampo.AsString, strItem, fltSalLot, fltSalLotML, FieldByName('FDO_CODITE').AsString) Then
    Begin

      If blnTravar Then
      Begin
        Result := False;

        If Not blnSuprimirMensagem Then
          pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                    ' já está cadastrado com a ' + strNomCam + ' !' + #13#10 + 'Cadastro de Produtos');
      End

      Else If fltSalLot <> 0 Then
      Begin
        If strTraLoc <> 'N' then
          If Not blnSuprimirMensagem Then
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                      ' já está cadastrado com a ' + strNomCam + ' e está com saldo diferente de zero!' + #13#10 + 'Cadastro de Produtos');

        If strTraLoc = 'T' then
          Result := False;

         blnRemoverLocFis := False;
      End

      Else If strTraLoc <> 'N' then
      Begin
        If Not blnSuprimirMensagem Then
          If Not fPergunta('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' já está cadastrado com a ' + strNomCam + '. Deseja removê-la do item ' +
                             strItem + ' para o item ' + FieldByName('FDO_CODITE').AsString + '?') Then
        Begin
          If strTraLoc = 'T' then
            Result := False;

          blnRemoverLocFis := False;
        End Else
        Begin
          blnRemoverLocFis := True;
        End;
      End;

    End

    Else If TCadLot.fBloqueiaTranfSaldoLote(strLote, fldCampo.AsString, strItem, VS_strCodEmp, True, strTitLab) Then
    Begin
      Result := False;
    End

    Else If (FieldByName('TEMLOT').AsInteger = 1) And fTemLoteComLocFisica(fldCampo.AsString, strItem, strLote, fltSalLot, fltSalLotML) And
            (strItem <> FieldByName('FDO_CODITE').AsString) Then
    Begin

      If blnTravar Then
      Begin
        Result := False;
        If Not blnSuprimirMensagem Then
          pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                    ' (' + strTitLab + ' ' + strLote + ') já está cadastrado com a ' + strNomCam + '!'+ #13#10 + 'Cadastro de Lotes');
      End

      Else If fltSalLot <> 0 Then
      Begin
        If strTraLoc <> 'N' then
          If Not blnSuprimirMensagem Then
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                      ' (' + strTitLab + ' ' + strLote + ') já está cadastrado com a ' + strNomCam + ' e está com saldo diferente de zero!'+ #13#10 + 'Cadastro de Lotes');

        If strTraLoc = 'T' then
          Result := False;

        blnRemoverLocFis := False;
      End

      Else If strTraLoc <> 'N' then
      Begin
        If Not blnSuprimirMensagem Then
          If Not fPergunta('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                    ' (' + strTitLab + ' ' + strLote + ') já está cadastrado com a ' + strNomCam +
                    '. Deseja removê-la do item ' +
                      strItem + ' para o item ' + FieldByName('FDO_CODITE').AsString + '?') Then
        Begin
          If strTraLoc = 'T' then
            Result := False;

          blnRemoverLocFis := False;
        End Else
        Begin
          blnRemoverLocFis := True;
        End;

      End;

    End;

  End;
End;

function TfrmEntEnderecamentoProduto.getColumByFieldName(
  FieldName: String): TColumn;
  var i: integer;
begin
  Result := nil;
  For i := 0 To dbgConsulta.Columns.Count -1 do
    If dbgConsulta.Columns[i].FieldName  = FieldName Then
      Exit(dbgConsulta.Columns[i]);
end;

procedure TfrmEntEnderecamentoProduto.cdsConsultaAfterOpen(DataSet: TDataSet);
Var
  qryAux : TUniQuery;
begin
  inherited;
  if objEndArm.tplTipLot <> tplArmazem then
  begin

    qryAux := fCriaQuery(nil);
    try
      qryAux.SQL.Add('SELECT                                                                                        ');
      qryAux.SQL.Add('  COUNT(0) AS QTD                                                                             ');
      qryAux.SQL.Add('FROM                                                                                          ');
      qryAux.SQL.Add('  CADLOT                                                                                      ');
      qryAux.SQL.Add('WHERE                                                                                         ');
      qryAux.SQL.Add('      LOT_CODEMP = :CODEMP                                                                    ');
      qryAux.SQL.Add('  AND LOT_STATUS <> "N"                                                                       ');
      qryAux.SQL.Add('  AND LOT_CODITE IN (SELECT FDO_CODITE FROM FATDOR WHERE FDO_SEQGER = :SEQGER)                ');

      qryAux.ParamByName('SEQGER').AsString := objEnderecamento.strAutIncPed;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.Open;

      if fUsaRotinaWMS or (qryAux.FieldByName('QTD').AsInteger > 0) then
      begin
        fFindColumnByName(dbgConsulta, 'ARMAZE').Title.Caption := 'Lote';
        fFindColumnByName(dbgArmazens, 'NUMLOT').Title.Caption := 'Lote';
        fFindColumnByName(dbgConsulta, 'ARMAZE').Visible := True;
      end
      else
        fFindColumnByName(dbgConsulta, 'ARMAZE').Visible := False;


      blnArmazemVisivel := fFindColumnByName(dbgConsulta, 'ARMAZE').Visible;
      btnCadArm.Caption := '[F8] Cad. Lotes';

    finally
      qryAux.Close;
      FreeAndNil(qryAux);
    end;

  end
  else
    btnCadArm.Caption := '[F8] Cad. Armazéns';
end;

procedure TfrmEntEnderecamentoProduto.cdsConsultaAfterScroll(DataSet: TDataSet);
var
  blnLote : boolean;
begin
  inherited;

  With cdsConsulta Do
  Begin
    If FieldByName('REFUGO').AsString = 'S' Then
    Begin
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := True;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCF').ReadOnly := True;
      fFindColumnByName(dbgConsulta, 'ITE_LOCSUP').ReadOnly := True;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCS').ReadOnly := True;

      FieldByName('ITE_LOCSUP').ReadOnly := True;
      FieldByName('ITE_TAMLCF').ReadOnly := True;
      FieldByName('ITE_TAMLCS').ReadOnly := True;
      FieldByName('ITE_LOCSUP').ReadOnly := True;
    End
    Else
    Begin
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := False;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCF').ReadOnly := False;
      fFindColumnByName(dbgConsulta, 'ITE_LOCSUP').ReadOnly := False;
      fFindColumnByName(dbgConsulta, 'ITE_TAMLCS').ReadOnly := False;

      FieldByName('ITE_LOCSUP').ReadOnly := False;
      FieldByName('ITE_TAMLCF').ReadOnly := False;
      FieldByName('ITE_TAMLCS').ReadOnly := False;
      FieldByName('ITE_LOCSUP').ReadOnly := False;
    End;

    blnLote := (FieldByName('TEMLOT').AsString = '1') or (((objEndArm.tplTipLot = tplArmazem) Or fUsaRotinaWMS) and (FieldByName('TEMLOT').AsString = '1'));

    fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := blnLote;

    FieldByName('ITE_LOCSUP').ReadOnly := blnLote;
    FieldByName('ITE_TAMLCF').ReadOnly := blnLote;
    FieldByName('ITE_TAMLCS').ReadOnly := blnLote;

    If fRegistroUtilizaLote Then
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := True;


    If Not blnCDLTAU Then
      btnCadArm.Visible := fRegistroUtilizaLote;
    //Tratamento para o requisito 289884, onde não vai informar lote para produto acabado, apenas a localização fisica.
    If FieldByName('FDO_PROACA').AsString = 'S' Then
    Begin
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Title.Caption := 'Loc. Fisica(Prod. Aca.)';
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Width := 130;
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := IIf(blnCadLoc, True, False);
    End
    Else
    Begin
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').Title.Caption := 'Loc. Fisica';
      fFindColumnByName(dbgConsulta, 'ITE_LOCFIS').ReadOnly := IIf(blnLocFisVisivel, False, True);
  End;
  End;
  pAtualizaNtbLote;
end;

procedure TfrmEntEnderecamentoProduto.pValidarPacotesQtdFracionada;
var
  intDeqTem: Integer;
begin
  intNRO_COL_QTDPAC := fFindColumnByName(dbgConsulta, 'QTDPAC').Index;
  intNRO_COL_QTDFRA := fFindColumnByName(dbgConsulta, 'QTDFRA').Index;

  If (dbgConsulta.SelectedIndex <> intNRO_COL_QTDPAC) And (dbgConsulta.SelectedIndex <> intNRO_COL_QTDFRA) Then
    Exit;

  intDeqTem := fCfgSis('DEQTEM', varInteger) * -1;

  If dbgConsulta.SelectedIndex = intNRO_COL_QTDPAC Then
  Begin
    If cdsConsulta.FieldByName('QTDPAC').AsFloat = 0 Then
     cdsConsulta.FieldByName('QTDPAC').AsFloat := 1;
    cdsConsulta.FieldByName('QTDFRA').AsFloat := SimpleRoundTo(cdsConsulta.FieldByName('FDO_QTDITE').AsFloat / cdsConsulta.FieldByName('QTDPAC').AsFloat, intDeqTem);
  End;

  If dbgConsulta.SelectedIndex = intNRO_COL_QTDFRA Then
  Begin
    If cdsConsulta.FieldByName('QTDFRA').AsFloat = 0 Then
      cdsConsulta.FieldByName('QTDFRA').AsFloat := 1;
    cdsConsulta.FieldByName('QTDPAC').AsFloat := SimpleRoundTo(cdsConsulta.FieldByName('FDO_QTDITE').AsFloat / cdsConsulta.FieldByName('QTDFRA').AsFloat, intDeqTem);
  End;
end;

procedure TfrmEntEnderecamentoProduto.cxgRastreamentoLoteEXCLUIRPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pExcluiLoteRastreamento;
end;

procedure TfrmEntEnderecamentoProduto.cxgRastreamentoLoteTBVKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2 : begin
              if objEnderecamento.blnRastreamentoIndustrial then
                pExcluiLoteRastreamento;
            end;
  end;
end;

procedure TfrmEntEnderecamentoProduto.pExcluiLoteRastreamento;
begin
  if objEnderecamento.objRastreamento.cdsRastreamentoLote.Active and (not objEnderecamento.objRastreamento.cdsRastreamentoLote.IsEmpty) then
  begin
    if fMensagem('', 'Deseja excluir o lote de rastreamento "'+objEnderecamento.objRastreamento.cdsRastreamentoLote.fieldByName('NUMERO_LOTE').AsString+'" ?', ['&Sim', '&Não']) = 1 then
      objEnderecamento.objRastreamento.cdsRastreamentoLote.Delete;
  end;
end;

procedure TfrmEntEnderecamentoProduto.pImprimeEtiqueta(intQtdIte: Integer);
Var
  i, x: integer;
  qryIteEti: TUniQuery;
  cdsIteEti: TZClient;
  strNomFil: String;
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  qryIteEti := nil;
  cdsIteEti := nil;
  prmDllEtq := nil;
  Try
    prmDllEtq := TParamDllEtiquetas.Create;
    try
      qryIteEti := fCriarQuery(fGetSqlItemEtiqueta(cdsConsulta.FieldByName('FDO_CODITE').AsString, intQtdIte));
      cdsIteEti := TZClient.Create(nil, fGetSqlItemEtiqueta(cdsConsulta.FieldByName('FDO_CODITE').AsString, intQtdIte));

      qryIteEti.Open;
      cdsIteEti.fAbreClient(False,'TfrmEntEnderecamentoProduto.pImprimeEtiqueta');
      For i := 2 to intQtdIte do
      begin
        cdsIteEti.Insert;
        For x := 0 to qryIteEti.Fields.Count -1 do
           cdsIteEti.Fields[x].Value := qryIteEti.Fields[x].Value;
        cdsIteEti.Post;
      end;

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;


      prmDllEtq.tpeTipEtq := tpeEtique;
      prmDllEtq.intTabPre := intTabPre;
      prmDllEtq.dtsImpres := cdsIteEti;
      prmDllEtq.strNomFil := strNomFil;
      prmDllEtq.intNumCop := 1;
      prmDllEtq.blnImpEti := True;

      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');

    finally
      FreeAndNil(prmDllEtq);
      If Assigned(cdsIteEti) then
        FreeAndNil(cdsIteEti);
      If Assigned(qryIteEti) then
        FreeAndNil(qryIteEti);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntEnderecamentoProduto.pImprimeEtiqueta]');
    End;
  End;
end;

procedure TfrmEntEnderecamentoProduto.pImprimeEtiquetaQtdFrac(intQtdEti: Integer);
Var
  qryIteEti: TUniQuery;
  prmDllEtq: TParamDllEtiquetas;
  ArrNomEti: TStringArray;
  blnExiPrePro : Boolean;
  strNomFil: String;
  intOpcEti: Integer;
  blnImpPre: Boolean;
  cdsDadosMulti: TUniClientDataSet;
  intCont: Integer;
begin
  inherited;
  cdsDadosMulti := Nil;
  qryIteEti := nil;

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    Try
      If stlListSelecao.Count > 1 Then
        cdsDadosMulti := fCriaDataSetMultiSelecao(intQtdEti)
      Else
      Begin
        //Cria aqui somente se stlListSelecao
        qryIteEti := fCriarQuery(fGetSqlItemEtiqueta(cdsConsulta.FieldByName('FDO_CODITE').AsString, intQtdEti, True));
        qryIteEti.Open;
      End;

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      SetLength(ArrNomEti, 0);
      pAddDados(ArrNomEti, 'Laser');
      pAddDados(ArrNomEti, 'Argox');
      intOpcEti := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
      If intOpcEti = -1 Then
        intOpcEti := 1;
      Case intOpcEti Of
        1: prmDllEtq.tpeTipEtq := tpeProdutoQuantidadeFracionadaLaser;
        2: prmDllEtq.tpeTipEtq := tpeProdutoQuantidadeFracionadaArgox;
      End;

      If Not fEscolheTabelaPreco(False,
                                 blnPrePro,
                                 blnImpPre,
                                 intTabPre,
                                 True,
                                 blnExiPrePro,
                                 ArrNomEti[intOpcEti -1]) Then
       Exit;

      prmDllEtq.intTabPre := intTabPre;
      If stlListSelecao.Count > 1 Then
        prmDllEtq.dtsImpres := cdsDadosMulti
      Else
        prmDllEtq.dtsImpres := qryIteEti;
      prmDllEtq.strNomFil := strNomFil;
      prmDllEtq.intNumCop := 1;
      prmDllEtq.blnImpEti := True;
      If stlListSelecao.Count > 1 Then
        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas')
      Else 
      begin 
        For intCont := 0 To Pred(intQtdEti) Do
          fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas'); 
      end;


    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEntEnderecamentoProduto.pImprimeEtiquetaQtdFrac]');
      End;

    End;
  Finally
    If Assigned(qryIteEti) then
      FreeAndNil(qryIteEti);
    FreeAndNil(prmDllEtq);
    If (stlListSelecao.Count > 1) Then
      FreeAndNil(cdsDadosMulti);
  End;
end;

procedure TfrmEntEnderecamentoProduto.cxvlotesNUMLOTPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If objEnderecamento.cdsTodosLotes.State = dsEdit Then
    objEnderecamento.cdsTodosLotes.Post;
end;

Procedure TfrmEntEnderecamentoProduto.pConsultaBeforePost(DataSet: TDataSet);
  Var
    blnRemoverLocFis,
    blnRemoverLocSup: Boolean;
Begin
  inherited;

  With DataSet Do
  Begin

    If blnCadLoc Then
    Begin

      If (FieldByName('LOCTST').AsString <> FieldByName('ITE_LOCFIS').AsString) Then
      Begin
        If (Not fValidaLocFisica(FieldByName('ITE_LOCFIS'), 'Localização Física', blnRemoverLocFis, False)) Then
        Begin
          Abort;
          Exit;
        End
        Else cdsConsulta.FieldByName('REMLOC').AsString    := IfThen(blnRemoverLocFis, 'S', 'N');
      End;

      If (FieldByName('SUPTST').AsString <> FieldByName('ITE_LOCSUP').AsString) And
         (Not fValidaLocFisica(FieldByName('ITE_LOCSUP'), 'Localização de Super Estoque', blnRemoverLocSup, strTraLoc = 'T')) Then
      Begin
        Abort;
        Exit;
      End;

    End;

    FieldByName('LOCTST').AsString := FieldByName('ITE_LOCFIS').AsString;
    FieldByName('SUPTST').AsString := FieldByName('ITE_LOCSUP').AsString;

    If blnPermiteFracionarQtd Then
      pValidarPacotesQtdFracionada;
  End;

End;

procedure TfrmEntEnderecamentoProduto.pLimpaPesquisa;
begin
  inherited;
  lblTipDoc.Visible := False;
end;

procedure TfrmEntEnderecamentoProduto.dbgArmazensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Odd(TDBGridCitel(Sender).DataSource.DataSet.RecNo) Then
  Begin

    TDBGridCitel(Sender).Canvas.Brush.Color := clrCorZebra;
    TDBGridCitel(Sender).Canvas.Font.Color  := clBlack;
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

  End;

end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaCellClick(Column: TColumn);
begin
  If Column.FieldName = 'DEFSER' Then
  Begin
    If (objEnderecamento.blnNumSer) And (cdsConsulta.FieldByName('ITE_USASER').AsString = 'S') Then
      objEnderecamento.objListaNumSerie.NumeroSerie[cdsConsulta.FieldByName('SEQDET').AsString].pVisualizaNumerosDeSerie;
    dbgConsulta.SelectedIndex := 0;

  End;

end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  BUTTON: Integer;
  R: TRect;
  bcolor: TColor;
  strValor : String;
begin
  inherited;
  If cdsConsulta.FieldByName('REFUGO').AsString = 'S' Then
  Begin
    TDBGridCitel(Sender).Canvas.Font.Color := shpGarantia.Brush.Color;
    TDBGridCitel(Sender).Canvas.FillRect(Rect);
    TDBGridCitel(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End
  Else
  If Column.FieldName = 'DEFSER' Then
  begin
    If objEnderecamento.blnNumSer Then
    Begin
      dbgConsulta.Canvas.FillRect(Rect);
      BUTTON := 0;
      R:=Rect;
      InflateRect(R,-1,-1); //Diminue o tamanho do Botão
      DrawFrameControl(dbgConsulta.Canvas.Handle,R,BUTTON, BUTTON or BUTTON);
      bcolor := dbgConsulta.Canvas.Brush.Color; // guarda a cor de fundo original
      dbgConsulta.Canvas.Brush.Color := clBtnFace; // muda a cor de fundo

      If cdsConsulta.FieldByName('ITE_USASER').AsString = 'S' Then
      Begin
        If (Assigned(objEnderecamento.objListaNumSerie.NumeroSerie[cdsConsulta.FieldByName('SEQDET').AsString])) And
           (objEnderecamento.objListaNumSerie.NumeroSerie[cdsConsulta.FieldByName('SEQDET').AsString].fTodosItensDefinidos) Then
           DrawText(dbgConsulta.Canvas.Handle,'Concluído', 9, R, DT_VCENTER or DT_CENTER)
        Else
           DrawText(dbgConsulta.Canvas.Handle,'Definir', 7, R, DT_VCENTER or DT_CENTER);

      End
      Else
        DrawText(dbgConsulta.Canvas.Handle,'', 0, R, DT_VCENTER or DT_CENTER);

      dbgConsulta.Canvas.Brush.Color := bcolor; // devolve a cor original
    end;
  End;

  If Column.FieldName = 'PESOIT' Then
  begin
    strValor := FormatFloat (fMskDigitos(4), Column.Field.AsFloat);
    dbgConsulta.Canvas.FillRect(Rect);
    dbgConsulta.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, strValor);
  end;

  If Pos(Column.FieldName, 'EXPALT_EXPLAR_EXPPRO') > 0 Then
  begin
    strValor := FormatFloat (fMskDigitos(2), Column.Field.AsFloat);
    dbgConsulta.Canvas.FillRect(Rect);
    dbgConsulta.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, strValor);
  end;
end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaEnter(Sender: TObject);
begin
  inherited;
  if not fChecaDados Then Exit;
  If ((objEndArm.tplTipLot = tplArmazem) Or fRegistroUtilizaLote) Then
    cdsConsulta.FieldByName('ARMAZE').FocusControl
  Else
    cdsConsulta.FieldByName('ITE_LOCFIS').FocusControl;

  pnlInfWms.Visible := fRegistroUtilizaLote;
end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaExit(Sender: TObject);
begin
  inherited;
  pnlInfWms.Visible := False;
end;

procedure TfrmEntEnderecamentoProduto.pPesquisaLocFisica(Var Key: Char; intColuna: Integer);
  Var
    qryLocFis: TUniQuery;
    arrSel: TConsultasArray;
    blnRemoverLocFis: Boolean;
    blnProdutoAcabado,
    blnFiltraPickingAtivo: Boolean;
begin

  blnProdutoAcabado := (cdsConsulta.FieldByName('FDO_PROACA').AsString =  'S') And
                       (intColuna = intNRO_COL_LOCFIS) and (dbgConsulta.SelectedIndex = intColuna);

  blnFiltraPickingAtivo :=  blnProdutoAcabado And fUsaRotinaWMS;

     // SE USA CADASTRO DE LOCALIZAÇÃO
  If blnCadLoc and
    (// SE O LOTE FOR DO TIPO ARMAZEM, SO PODE ALTERAR A LOCALIZACAO SE O ITEM NAO TIVER LOTE
    ((((objEndArm.tplTipLot <> tplArmazem) And Not fUsaRotinaWMS)) Or
     (cdsConsulta.FieldByName('TEMLOT').AsString <> '1'))  Or  (blnProdutoAcabado)) Then
  Begin
    qryLocFis := fCriaQuery(Self);

    If fPesqLocFisica(Self, Nil, Nil, qryLocFis, Key, arrSel, True, blnFiltraPickingAtivo, False, False, False, '', False, '', blnFiltraPickingAtivo, blnProdutoAcabado) Then
    Begin
      If fValidaLocFisica(qryLocFis.FieldByName('LOC_CODLOC'), 'Localização Física', blnRemoverLocFis, intColuna = intNRO_COL_SUPEST) Then
      Begin
        Key := #0;
        If cdsConsulta.State <> dsEdit Then
          cdsConsulta.Edit;

        dbgConsulta.Columns[intColuna].Field.AsString := qryLocFis.FieldByName('LOC_CODLOC').AsString;
        If intColuna = intNRO_COL_SUPEST Then
        Begin
          cdsConsulta.FieldByName('SUPTST').AsString := cdsConsulta.FieldByName('ITE_LOCSUP').AsString;
        End Else
        Begin
          cdsConsulta.FieldByName('LOCTST').AsString := cdsConsulta.FieldByName('ITE_LOCFIS').AsString;
          cdsConsulta.FieldByName('REMLOC').AsString := IfThen(blnRemoverLocFis, 'S', 'N');
        End;

        If (blnCDLTAU) And (intColuna = intNRO_COL_LOCFIS) Then
          If Not objEnderecamento.fCarregarItens(cdsConsulta).fItemBalanco Then
          Begin
            objEnderecamento.fGerarLote;
            objEndArm
              .pAtualizaArmazens(cdsConsulta, False, objEnderecamento.fGetSqlLoteItens);
            pAtualizarSaldoLote;
          End;
      End;
    End;

    Key := #0;
    FreeAndNil(qryLocFis);
  End;
end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

end;

procedure TfrmEntEnderecamentoProduto.dbgConsultaKeyPress(Sender: TObject;
  var Key: Char);
var
  blnProdutoAcabado: Boolean;
begin
  intNRO_COL_ARMAZE := fFindColumnByName(dbgConsulta, 'ARMAZE').Index;
  If blnPermiteFracionarQtd Then
  Begin
    intNRO_COL_QTDPAC := fFindColumnByName(dbgConsulta, 'QTDPAC').Index;
    intNRO_COL_QTDFRA := fFindColumnByName(dbgConsulta, 'QTDFRA').Index;
  End;

  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    If (dbgConsulta.SelectedIndex  = intNRO_COL_ARMAZE) And ( cdsConsulta.FieldByName('FDO_PROACA').AsString <> 'S')  Then    Begin
                        Key := #0;
                        btnEndArm.Click;
    End
    Else If dbgConsulta.SelectedIndex = intNRO_COL_LOCFIS Then
      pPesquisaLocFisica(Key, intNRO_COL_LOCFIS)
    Else If dbgConsulta.SelectedIndex = intNRO_COL_SUPEST Then
      pPesquisaLocFisica(Key, intNRO_COL_SUPEST)
  End;

  If (Key = #13) Then
  Begin
    If ((dbgConsulta.SelectedIndex <> intNRO_COL_QTDPAC) And (dbgConsulta.SelectedIndex <> intNRO_COL_QTDFRA)) Then
    begin
      blnProdutoAcabado := (cdsConsulta.FieldByName('FDO_PROACA').AsString =  'S') And (dbgConsulta.SelectedIndex  = intNRO_COL_LOCFIS);
      if fRegistroUtilizaLote And
         (not blnProdutoAcabado) And
         (dbgConsulta.SelectedIndex = intNRO_COL_ARMAZE) then
        btnEndArm.Click;
    end
    else
    begin
      If cdsConsulta.State <> dsEdit Then
        cdsConsulta.Edit;
      cdsConsulta.Post;
    end;
  End;
end;

function TfrmEntEnderecamentoProduto.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  If Assigned(objEnderecamento) And Assigned(objEnderecamento.cdsTodosLotes) Then
    objEnderecamento.cdsTodosLotes.Close;

  Result := (inherited fAbreConsulta(blnLike)) And objEnderecamento.fValidaCrossDocking(cdsConsulta);

  If Result Then
  Begin
    pSetaRequeridos;

    TFloatField(cdsConsulta.FieldByName('FDO_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    TFloatField(cdsConsulta.FieldByName('ITE_SALDOS')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(cdsConsulta.FieldByName('QTDEFA')).DisplayFormat     := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(cdsConsulta.FieldByName('QTDEFF')).DisplayFormat     := fMskDigitos(fCfgSis('DECQTD', varInteger));

    If blnPermiteFracionarQtd Then
    Begin
      TFloatField(cdsConsulta.FieldByName('QTDPAC')).DisplayFormat     := fMskDigitos(1);
      TFloatField(cdsConsulta.FieldByName('QTDFRA')).DisplayFormat     := fMskDigitos(fCfgSis('DEQTEM', varInteger));
    End;

    lblTipDoc.Visible := (Pos('CANCELAMENTO', cdsConsulta.FieldByName('MEN001').AsString) > 0 ) Or
                       (cdsConsulta.FieldByName('GARANT').AsInteger > 0);

    If (Pos('CANCELAMENTO', cdsConsulta.FieldByName('MEN001').AsString) > 0 ) Then
      lblTipDoc.Caption := 'Documento Cancelado'
    Else If cdsConsulta.FieldByName('GARANT').AsInteger = 1 Then
      lblTipDoc.Caption := 'Documento de Garantia';

    objEndArm.pAtualizaArmazens(cdsConsulta, True, objEnderecamento.fGetSqlLoteItens(False, False));

    objEnderecamento.pCarregaLotes;

    objEnderecamento.objRastreamento.pCarregaDados(objEnderecamento.strAutIncPed);
    cxvlotes.DataController.DataSource := objEnderecamento.cdsTodosLotes.dtsSource;

    cdsConsulta.BeforePost := pConsultaBeforePost;
  End

  Else pCancela(False);
End;

procedure TfrmEntEnderecamentoProduto.btmMarLotTodosClick(Sender: TObject);
begin
  inherited;

  pSetaLote(True);
end;

procedure TfrmEntEnderecamentoProduto.btnAdicionarLoteRastreamentoClick(
  Sender: TObject);
  var strCodFor: String;
begin
  if (not cdsConsulta.Active) or cdsConsulta.IsEmpty then
    exit;

  if not fValidaPanel(pnlDadosLoteRastreamento) then
    exit;


  If cdsConsulta.FieldByName('DET_CODFOR').AsString = '' Then
    strCodFor := fRetFornecedorItem(cdsconsulta.FieldByName('FDO_CODITE').AsString)
  Else
    strCodFor := cdsConsulta.FieldByName('DET_CODFOR').AsString;

  try
    objEnderecamento.objRastreamento.pAdicionaRastreamento(
      TParametrosRastreamentoEnderecamento.New()
      .AutoincremMOVDET(cdsConsulta.FieldByName('SEQDET').AsString)
      .AutoincremFATGOR(objEnderecamento.strAutIncPed)
      .CodigoFornecedor(strCodFor)
      .CodigoItem(cdsconsulta.FieldByName('FDO_CODITE').AsString)
      .NumeroLote(edtLoteRastreamento.Text)
      .QuantidadeEtiquetas(strtoint(edtQuantidadeEtiquetasLoteRastreamento.Text))
    );

    pLimpaRastreamento;

    pSetFocus(edtLoteRastreamento);
  except
    On E : Exception do
    begin
      pMensagemOk(E.message);
      if E.HelpContext = TParametrosRastreamentoEnderecamento.NUMERO_LOTE_INDEX then
        pSetFocus(edtLoteRastreamento);
    end;
  end;

end;

procedure TfrmEntEnderecamentoProduto.pLimpaRastreamento;
begin
  edtLoteRastreamento.Clear;
  edtQuantidadeEtiquetasLoteRastreamento.Clear;
end;

procedure TfrmEntEnderecamentoProduto.btnCadArmClick(Sender: TObject);
begin
  inherited;
  If Not btnCadArm.Visible Then
    Exit;

  If fUsaRotinaWMS And Not fVerificaAcessoSistema('frmCadLoteItens') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  pCriarForm(TfrmCadLoteItens);

  If (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0) Then
    objEndArm.pAtualizaArmazens(cdsConsulta, False, objEnderecamento.fGetSqlLoteItens);
end;

procedure TfrmEntEnderecamentoProduto.btnConfirmaClick(Sender: TObject);
  Var
    endItem: TEndItem;
    blnSalvar: Boolean;
    strNumDoc,
    strEspDoc,
    strCodCli,
    strAutIncOPI : String;
    frmQckLibArm : TfrmQckLiberacaoArmazenamento;
    strOperador, strConferente, strObservacao: string;
    stlItens: TStringList;
    objBaixaPedido: TDefineBaixaPedido;
    frmImpEtiLoteDoProduto: TfrmImpEtiLoteDoProduto;
    frmImprimeEtiquetaLoteRastreamentoProduto: TfrmImprimeEtiquetaLoteRastreamentoProduto;
    blnTodosEnderecados: Boolean;
    qryExec: TUniQuery;
    blnUTISEM: Boolean;
    blnSemelhante: Boolean;
    blnGerarReservaAtiPre: Boolean;
begin
  inherited;
  blnTodosEnderecados := false;
  blnGerarReservaAtiPre := False;

  if Not fChecaDados Then
    Exit;

  if not fVerificaCampos then
    exit;

  If Not fValidaCadastroLoteCriadoAposInciarEnderecamento Then
  Begin
    fMensagem('ATENÇÃO!', ' Foi criado lote após a inicialização do endereçamento, recarregue o documento.', ['&Ok']);
    Exit;
  End;

  If (Not fValidaCadastroLotesEscolhidos) Then
  Begin
    fMensagem('ATENÇÃO!', ' O lote foi alterado após a inicialização do endereçamento, recarregue o documento.', ['&Ok']);
    Exit;
  End;

  pLimpaPesquisa;

  Try

    If (Not cdsConsulta.Active) Or cdsConsulta.IsEmpty Then
      Exit;


    If ((not objEnderecamento.blnRastreamentoIndustrial) and
       ((objEndArm.tplTipLot = tplArmazem) Or blnUtiLot)) Then
    Begin
      If (Not (objEndArm.fExistemItensEnderecado(cdsConsulta))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Há itens sem endereçamento.', ['&Ok']);
        Exit;
      End;

      If (Not (objEndArm.fValidaEnderecamentos(cdsConsulta))) Then
        Exit;
    End;

    If blnCadLoc Then
    Begin
      If Not objEndArm.fExistemTodosProdutoAcabadosComLocFis(cdsConsulta) Then
        Exit;
    End;

    if objEnderecamento.blnRastreamentoIndustrial then
    begin
      try
        objEnderecamento.objRastreamento.pValida(objEnderecamento.strAutIncPed);
      except
        On E: Exception do
        begin
          pMensagemOk(E.Message);
          exit;
        end;
      end;
    end;

    If fMensagem('', 'Confirma liberação?', ['','']) = 1 Then
    Begin

      If objEnderecamento.blnNumSer And (Not blnDocTE) Then
      Begin
        cdsConsulta.First;
        While Not cdsConsulta.Eof Do
        Begin
          If cdsConsulta.FieldByName('ITE_USASER').AsString = 'S' Then
          Begin
            If Not (objEnderecamento.objListaNumSerie.NumeroSerie[cdsConsulta.FieldByName('SEQDET').AsString].fTodosItensDefinidos) Then
            Begin
              fMensagem('ATENÇÃO!', 'O Item ' +  cdsConsulta.FieldByName('FDO_CODITE').AsString +
                         ' esta configurado para informar número de série.', ['&Ok']);
              Exit;
            End;

          End;
          cdsConsulta.Next;
        End;
      End;

      blnSalvar := True;

      //Se solicita conferente e separador
      If (fCfgSis('ENDSSC') = 'S')  Then
      Begin
        If Not (TFatSeparadorConferente.New
          .CarregaConferente(False)
          .Solicitar(strOperador, strConferente, strObservacao)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Separador e o Conferente não estão preenchidos! Favor verificar.', ['&Ok']);
          Exit;
        End;
      End;

      stlItens := TStringList.Create;

      strAutIncOPI:= '';
      If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento And (objEnderecamento.endDocumento.strEspDoc = 'OI') Then
      Begin
        If blnSalvar Then
        Begin

          strAutIncOPI:= fRetAutoIncremOPI(objEnderecamento.strAutIncPed);

        End;
      End;

      fStartTransaction;

      cdsConsulta.First;

      blnSuprimirMensagem := True;
      objEnderecamento.SeqFatEnd := '';

      While Not cdsConsulta.Eof Do
      Begin
        If (objEnderecamento.blnNumSer) And (cdsConsulta.FieldByName('ITE_USASER').AsString = 'S') Then
        begin
          blnSalvar := objEnderecamento.objListaNumSerie.NumeroSerie[cdsConsulta.FieldByName('SEQDET').AsString].fSalva;
          If not blnSalvar Then
            Break;
        End;

        If blnEditaEcomm Then
          objEnderecamento.pAtualizaDadosEcommerce(cdsConsulta.FieldByName('FDO_CODITE').AsString,
                                                   cdsConsulta.FieldByName('PESOIT').AsFloat,
                                                   cdsConsulta.FieldByName('EXPALT').AsFloat,
                                                   cdsConsulta.FieldByName('EXPLAR').AsFloat,
                                                   cdsConsulta.FieldByName('EXPPRO').AsFloat );

        If fIsItemEspecial(cdsConsulta.FieldByName('FDO_CODITE').AsString) Then
        Begin
          cdsConsulta.Next;
          Continue;
        End;

        endItem.strCodIte := cdsConsulta.FieldByName('FDO_CODITE').AsString;
        endItem.strCodEmp := cdsConsulta.FieldByName('FDO_CODEMP').AsString;
        endItem.strLocFis := cdsConsulta.FieldByName('ITE_LOCFIS').AsString;
        endItem.strLocAnt := cdsConsulta.FieldByName('LOCANT').AsString;
        endItem.strLocSup := cdsConsulta.FieldByName('ITE_LOCSUP').AsString;
        endItem.strSupAnt := cdsConsulta.FieldByName('SUPANT').AsString;
        endItem.strTamLcF := cdsConsulta.FieldByName('ITE_TAMLCF').AsString;
        endItem.strTamLcS := cdsConsulta.FieldByName('ITE_TAMLCS').AsString;
        endItem.strCodAmz := Trim(cdsConsulta.FieldByName('ARMAZE').AsString);
        endItem.blnRemLoc := SameText(cdsConsulta.FieldByName('REMLOC').AsString, 'S');
        endItem.blnRefugo := cdsConsulta.FieldByName('REFUGO').AsString = 'S';
        endItem.blnEnderecado := objEndArm.fExisteItemEnderecado(cdsConsulta);
        endItem.blnIteAca := cdsConsulta.FieldByName('FDO_PROACA').AsString = 'S';
        endItem.strEmpAca := cdsConsulta.FieldByName('FDO_EMPACA').AsString;
        endItem.strCodAca := cdsConsulta.FieldByName('FDO_CODACA').AsString;
        endItem.blnTemLote := (cdsConsulta.FieldByName('TEMLOT').AsString = '1');
        If endItem.blnIteAca Then
        Begin
          endItem.blnEnderecado := endItem.strLocFis <> '';

        End;

        endItem.strAutInc := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        endItem.blnhouveTrocaDeArmazemLote := (Not cdsConsulta.FieldByName('FDO_NUMLOT').AsString.Equals(cdsConsulta.FieldByName('ARMAZE').AsString)); { Se não for igual é pq houve alteração do lote original}
        objEnderecamento.pAddItem(endItem);


        if endItem.blnEnderecado then
        Begin
          stlItens.Add(cdsConsulta.FieldByName('FDO_CODITE').AsString);

          If (objEnderecamento.endDocumento.strEspDoc = 'OI') Then
          Begin

            If  fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento And  endItem.blnEnderecado Then
            Begin
              If blnSalvar Then
              Begin
                qryExec:= fCriaQuery();
                Try
                  If Not fEmptyStr(strAutIncOPI) Then
                  Begin
                    qryExec.Close;
                    qryExec.SQL.Clear;
                    qryExec.SQL.Add('UPDATE MOVDET SET DET_NUMLOT = :NUMLOT     ');
                    qryExec.SQL.Add('  WHERE DET_NUMDOC = :NUMDOC AND           ');
                    qryExec.SQL.Add('        DET_ESPDOC = :ESPDOC AND           ');
                    qryExec.SQL.Add('        DET_SERIE_ = :SERIE_ AND           ');
                    If objEnderecamento.endDocumento.strTip_FC = 'C' Then
                      qryExec.SQL.Add('        DET_CODCLI = :CLIFOR AND         ')
                    Else
                      qryExec.SQL.Add('        DET_CODFOR = :CLIFOR AND         ');
                    qryExec.SQL.Add('        DET_TIP_FC = :TIP_FC AND           ');
                    qryExec.SQL.Add('        DET_CODEMP = :CODEMP AND           ');
                    qryExec.SQL.Add('        DET_CODITE = :CODITE               ');

                    If Not(fEmptyStr(endItem.strNumLote)) And (endItem.strNumLote <> 'A DEFINIR') Then
                      qryExec.ParamByName('NUMLOT').AsString:= endItem.strNumLote
                    Else
                      qryExec.ParamByName('NUMLOT').AsString:= endItem.strCodAmz;

                    qryExec.ParamByName('NUMDOC').AsString:= objEnderecamento.endDocumento.strNumDoc;
                    qryExec.ParamByName('ESPDOC').AsString:= objEnderecamento.endDocumento.strEspDoc;
                    qryExec.ParamByName('SERIE_').AsString:= objEnderecamento.endDocumento.strSerie_;
                    qryExec.ParamByName('CLIFOR').AsString:= objEnderecamento.endDocumento.strCliFor;
                    qryExec.ParamByName('TIP_FC').AsString:= objEnderecamento.endDocumento.strTip_FC;
                    qryExec.ParamByName('CODEMP').AsString:= objEnderecamento.endDocumento.strCodEmp;
                    qryExec.ParamByName('CODITE').AsString:= endItem.strCodIte;
                    qryExec.ExecSQL;
                  End;
                Finally
                  FreeAndNil(qryExec);
                End;

              End;
            End;

          End;

        End;

        If (cdsConsulta.FieldByName('TEMLOT').AsString = '0') Or ((cdsConsulta.FieldByName('TEMLOT').AsString = '1') And endItem.blnEnderecado) Then
        Begin
          If blnResLtp And (cdsConsulta.FieldByName('LTP_PENDEN').AsString = 'S') Then
          Begin
            objReservaEstAtiPre.pAdicionarItemReservaLotPre(cdsConsulta.FieldByName('LTP_AUTINC').AsString,
                                                            cdsArmSel,
                                                            cdsConsulta.FieldByName('FDO_QTDITE').AsFloat,
                                                            cdsConsulta.FieldByName('FDO_CODITE').AsString);
            objReservaEstAtiPre.endDocumento := objEnderecamento.endDocumento;
            If Not blnGerarReservaAtiPre Then
              blnGerarReservaAtiPre := True;
          End;
        End;

        cdsConsulta.Next;
      End;

      If blnSalvar Then
      begin
        blnTodosEnderecados := objEnderecamento.fTodosEnderecados;
        If (Not endItem.blnIteAca) Then
          objEnderecamento.pAtualizaLocalizacaoItens;
        objEnderecamento.pSetIdEnd;
        objEnderecamento.blnGerouTA := False;

        objEnderecamento.pLiberarRefugos;
        If (Not blnCofEnd) and (Not blnUDEVME) then
          blnSalvar := blnSalvar And objEnderecamento.fApagaPedidoReservaEstoque;
        objEnderecamento.fAtualizaLocFisAcager;

        //Foi Informado operador e conferente então atualiza o documento marcando o operador
        If fCfgSis('ENDSSC') = 'S' Then
          blnSalvar := blnSalvar And objEndArm.fGravaOperadorConferente(strOperador, strConferente, objEnderecamento.endDocumento, strObservacao);

        If ((not objEnderecamento.blnRastreamentoIndustrial) and  ((objEndArm.tplTipLot = tplArmazem) Or blnUtiLot) and (blnSalvar)) Then
        begin
          If fEmptyStr(fRetNomCliente(fCfgSis('CLI_TA'))) Then
          Begin
            pMensagemOk('Favor configurar corretamente o "Cliente para Transferência de Estoque entre armazéns/Lotes (CFG_CLI_TA)"!');
            blnSalvar := False;
          End
          Else If (Not objEnderecamento.SoTemProdutoAcabado) Then
            blnSalvar := blnSalvar And objEndArm.fGeraDocumentoTransfArmazens(strNumDoc,
                                                                              strEspDoc,
                                                                              strCodCli,
                                                                              objEnderecamento.endDocumento.strAutInc,
                                                                              objEnderecamento.endDocumento,
                                                                              objEnderecamento);
        end;
      End;

      If blnSalvar And
        VS_strHabilitarCRM And
        blnTodosEnderecados Then
      Begin
        TUpdateOccurrenceCRM.New()
          .NumDoc(objEnderecamento.endDocumento.strNumDoc)
          .EspDoc(objEnderecamento.endDocumento.strEspDoc)
          .CodEmp(objEnderecamento.endDocumento.strCodEmp)
          .AcaFat(afcEnderecamentoFinalizado)
          .strNomFrm(Self.Name)
          .pRun();
      End;

      If blnSalvar And (Not objEnderecamento.endDocumento.strAutInc.IsEmpty) And fConferenciaDepoisDaEntrada Then
      Begin
        objBaixaPedido := TDefineBaixaPedido.Create(Nil);
        blnSalvar := objBaixaPedido.fGeraTERequisicao(objEnderecamento.endDocumento.strAutInc, fCommaText(stlItens, True));

        If blnSalvar Then
          pEnviaMsgRequisicaoConcluida(objEnderecamento.endDocumento.strAutInc, False);

        FreeAndNil(objBaixaPedido);
      End;

      If blnSalvar And (Not objEnderecamento.endDocumento.strAutInc.IsEmpty) Then
        TDefineBaixaPedido.ProcessaStatusPedidoRequisicao(objEnderecamento.endDocumento.strAutInc);

      If blnSalvar Then
      begin
        objEnderecamento.pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque;

        if objEnderecamento.blnRastreamentoIndustrial then
          objEnderecamento.objRastreamento.pGravaDados;
      End;

      If blnResLtp Then
      Begin
        If blnSalvar And blnGerarReservaAtiPre Then
        Begin
          blnSalvar := objReservaEstAtiPre.fGerarPedidoParaReservarEstoque;
          objReservaEstAtiPre.pLimpar;
        End;
      End;

      If blnCofEnd or blnUDEVME Then
      Begin
        objEnderecamento.pSetIdEnd;
        objEnderecamento
          .fConsulta(cdsConsulta)
          .fGravarFatEnd
          .fGravarQuantidadeParcialEnderecamento;

      End;

      If blnSalvar Then
        If blnCofEnd or blnUDEVME Then
        Begin
          If Not TEnderecamentoConferenciaParcial.fTemPendenciaEnderecamento(objEnderecamento.strAutIncPed) then
            blnSalvar := blnSalvar And objEnderecamento.fApagaPedidoReservaEstoque;
          If objEnderecamento.fMarcaEnderecamentoFinalizado Then
            objEnderecamento.pMarcaEnderecamentoFinalizado;

        End;

      If blnSalvar Then
        fCommit
      Else
        fRollBack;

      If blnSalvar Then
        objEnderecamento.ReprocessaSaldos;

      FreeAndNil(stlItens);

      If blnSalvar Then
      Begin

        If fCfgSis('ENDBAI', varBoolean) And fUsaEnderecamento And (objEnderecamento.endDocumento.strEspDoc = 'OI') Then
        Begin
          If blnSalvar And blnTodosEnderecados Then
          Begin
            qryExec:= fCriaQuery();
            Try
              If Not fEmptyStr(strAutIncOPI) Then
              Begin
                qryExec.Close;
                qryExec.SQL.Clear;
                qryExec.SQL.Add('UPDATE ORDGER SET ORD_PENEND = "N" WHERE AUTOINCREM = :AUTINC ');
                qryExec.ParamByName('AUTINC').AsString:= strAutIncOPI;
                qryExec.ExecSQL;
              End;
            Finally
              FreeAndNil(qryExec);
            End;

          End;
        End;

        //objEndArm.pImprimeTransfArmazens;
        blnUTISEM := False;
        If fCfgSis('UTISEM', varBoolean) Then
        Begin
          blnSemelhante := (Trim(fCampoTabela('SEM_CODITE', 'CADSEM', ['SEM_CODITE'], [cdsConsulta.FieldByName('FDO_CODITE').AsString], False)) <> '');
          if blnSemelhante Then
            blnUTISEM := fMensagem('',
            'Tipo de código de barras:',
            ['&Código de barras', 'Código de barras &semelhante'],
            1,
            False,
            0,
            235,
            False,
            0,
            False,
            False,
            true,
            0,
            550
            ) = 2;
        end;

        If fCfgSis('IMPLIB', varBoolean) Then
        Begin
          pCriarFormularios(TfrmQckLiberacaoArmazenamento, frmQckLibArm);
          Try
            frmQckLibArm.pImprimir(IIF(fEmptyStr(strNumDoc),objEnderecamento.endDocumento.strNumDoc, strNumDoc),
                                   IIF(fEmptyStr(strEspDoc),objEnderecamento.endDocumento.strEspDoc, strEspDoc),
                                   IIF(fEmptyStr(strNumDoc),objEnderecamento.endDocumento.strSerie_,''),
                                   IIF(fEmptyStr(strNumDoc),objEnderecamento.endDocumento.strCliFor,strCodCli),
                                   VS_strCodEmp,
                                   Self.Name,
                                   'V',
                                   IIF(fEmptyStr(strNumDoc),objEnderecamento.endDocumento.strTip_FC,'C'),
                                   oriLibEnderecamentoProduto,
                                   blnUTISEM,
                                   IIf(objEnderecamento.blnGerouTA, IIF(blnCofEnd or blnUDEVME, objEnderecamento.SeqFatEnd, ''), '' ));
          Finally
            FreeAndNil(frmQckLibArm);
          End;
        End;
      End;

      If (blnSalvar) and (fCfgSis('ETQLPR', varBoolean)) Then
      begin
        if blnUtiLot and (not objEnderecamento.blnRastreamentoIndustrial) then
        begin
          pCriarFormularios(TfrmImpEtiLoteDoProduto, frmImpEtiLoteDoProduto);
          Try
            cdsConsulta.DisableControls;
            cdsArmSel.DisableControls;
            Try
              Try
                cdsConsulta.First;
                While Not cdsConsulta.EoF do
                Begin
                  pAtualizaNtbLote;
                  SetLength(frmImpEtiLoteDoProduto.arrNumLot, High(frmImpEtiLoteDoProduto.arrNumLot) + 1 + cdsArmSel.RecordCount);
                  While Not cdsArmSel.Eof Do
                  Begin
                    frmImpEtiLoteDoProduto.arrNumLot[High(frmImpEtiLoteDoProduto.arrNumLot)].strCodigo := cdsArmSel.FieldByName('NUMLOT').AsString;
                    cdsArmSel.Next;
                  End;
                  cdsConsulta.Next;
                End;
                frmImpEtiLoteDoProduto.edtQtdEtq.Text := '1';
                frmImpEtiLoteDoProduto.edtnumLot.Text := '+1';
              Except
                On e: Exception do
                  pMensagensErro(e.Message, '[TfrmEntEnderecamentoProduto.btnConfirmaClick]');
              End;
            Finally
              cdsConsulta.EnableControls;
              cdsArmSel.EnableControls;
            End;
            frmImpEtiLoteDoProduto.blnEscondeFiltros := True;
            frmImpEtiLoteDoProduto.blnNaoImprimirADefinir := True;
            frmImpEtiLoteDoProduto.ShowModal;
          Finally
            FreeAndNil(frmImpEtiLoteDoProduto);
          End;
        End
        else if objEnderecamento.blnRastreamentoIndustrial then
        begin
          pCriarFormularios(TfrmImprimeEtiquetaLoteRastreamentoProduto, frmImprimeEtiquetaLoteRastreamentoProduto);
          Try
            frmImprimeEtiquetaLoteRastreamentoProduto.strSeqGorEnderecamento := objEnderecamento.strAutIncPed;
            frmImprimeEtiquetaLoteRastreamentoProduto.ShowModal;
          Finally
            FreeAndNil(frmImprimeEtiquetaLoteRastreamentoProduto);
          End;
        End;
      end;

      pCancela(False);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      If E is  ExceptionNumeroSerie then
        pMensagemOk(ExceptionNumeroSerie(E).Local)
      Else
        pMensagensErro(E.Message,'[TfrmEntEnderecamentoProduto.btnConfirmaClick]');
    End;
  End;

  blnSuprimirMensagem := False;

end;

procedure TfrmEntEnderecamentoProduto.btnDefineLoteEntFutClick(Sender: TObject);
var
  frmFatDefineLoteEntregaFuturaFaltaProduto: TfrmFatDefineLoteEntregaFuturaFaltaProduto;
begin
  inherited;

  if not btnDefineLoteEntFut.Visible then
    Exit;

  pCriarFormularios(TfrmFatDefineLoteEntregaFuturaFaltaProduto, frmFatDefineLoteEntregaFuturaFaltaProduto);

  try
    frmFatDefineLoteEntregaFuturaFaltaProduto.ShowModal;
  finally
    pFreeAndNil(frmFatDefineLoteEntregaFuturaFaltaProduto);
  end;
end;

function TfrmEntEnderecamentoProduto.fRetAutoIncremOPI(strAutInc: String): String;
var
  qryGenerico: TUniQuery;
Begin
  qryGenerico:= fCriaQuery;
  Try
    qryGenerico.Close;
    qryGenerico.SQL.Clear;
    qryGenerico.SQL.Add('SELECT FGO_ORDIND FROM EXTGOR '+
                        ' JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO  '+
                        '   WHERE (FGO_MEN001 LIKE "%PRODUTO ACABADO OP%") '+
                        '      AND FATGOR.AUTOINCREM = :AUTINC ');
    qryGenerico.ParamByName('AUTINC').AsString:= strAutInc;
    qryGenerico.Open;

    result:= qryGenerico.FieldByName('FGO_ORDIND').AsString;

  Finally
    FreeAndNil(qryGenerico);
  End;
End;

procedure TfrmEntEnderecamentoProduto.btnEndArmClick(Sender: TObject);
  Var
    strNumLot,
    strAmzDes,
    strLocFis: String;
begin
  inherited;

  If blnCDLTAU Then
    Exit;
  If Not btnEndArm.Visible And Not fRegistroUtilizaLote Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  With cdsConsulta Do
  Begin
    If (FieldByName('TEMLOT').AsString <> '1') Then
    Begin
      pMensagemOk('Esse item não possui lote cadastrado!');
      Exit;
    End;

    If objEndArm.fEnderecaArmazens(FieldByName('FDO_CODITE').AsString,
                                   FieldByName('FDO_DESCRI').AsString,
                                   FieldByName('AUTOINCREM').AsString,
                                   FieldByName('FDO_NUMLOT').AsString,
                                   FieldByName('FDO_QTDITE').AsFloat,
                                   FieldByName('REFUGO').AsString = 'S',
                                   strNumLot, strLocFis, strAmzDes,'',
                                   FieldByName(strCampoLista).AsString) Then
    Begin
      objEndArm.pAtualizaScrollArmazens(cdsConsulta, strNumLot, strLocFis, strAmzDes);
      If Not SameText(strNumLot, 'A DEFINIR') Then
        Next;
    End;
  End;

  pAtualizaNtbLote;

end;

procedure TfrmEntEnderecamentoProduto.btnEntregasPendentesClick(
  Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

   prcExecutaRelatorio(57, 4948, [],
                        ['CODITE'],
                        [cdsConsulta.FieldByName('FDO_CODITE').AsString],
                        nil,
                        nil,
                        True);

end;

procedure TfrmEntEnderecamentoProduto.btnEtiProClick(Sender: TObject);
begin
  inherited;
  If blnPermiteFracionarQtd Then
  Begin
    pImprimeEtiquetaQtdFrac(StrToIntDef(edtQtdEti.Text,0));
  End
  Else
  Begin
    if fEscolheTipoEtiqueta then
      pImprimeEtiqueta(StrToIntDef(edtQtdEti.Text,0));
  End;
end;

Procedure TfrmEntEnderecamentoProduto.pOrdenaClient;
Begin
  cdsConsulta.IndexFieldNames := 'REFUGO;' + fGetAliasField(lflLastField.strNomCam);
End;

procedure TfrmEntEnderecamentoProduto.pAtualizarSaldoLote;
var
  strNumLot: string;
  strLocFis: string;
  strAmzDes: string;
begin
  strNumLot := '';
  strLocFis := '';
  strAmzDes := '';
  if objEndArm.fValidar(True).fEnderecaArmazens(cdsConsulta.FieldByName('FDO_CODITE').AsString, cdsConsulta.FieldByName('FDO_DESCRI').AsString, cdsConsulta.FieldByName('AUTOINCREM').AsString, cdsConsulta.FieldByName('FDO_NUMLOT').AsString, cdsConsulta.FieldByName('FDO_QTDITE').AsFloat, cdsConsulta.FieldByName('REFUGO').AsString = 'S', strNumLot, strLocFis, strAmzDes, cdsConsulta.FieldByName('ARMAZE').AsString) then
    If Not strNumLot.IsEmpty Then
      objEndArm.pAtualizaScrollArmazens(cdsConsulta, strNumLot, strLocFis, strAmzDes);
  pAtualizaNtbLote;
end;

procedure TfrmEntEnderecamentoProduto.pEnderecamentoAutomatico;
begin
  objEnderecamento
    .fCarregarItens(cdsConsulta)
    .fGerarLotes;

  objEndArm
    .pAtualizaArmazens(cdsConsulta, False, objEnderecamento.fGetSqlLoteItens);

  cdsConsulta.First;
  cdsConsulta.DisableControls;
  while not cdsConsulta.Eof do
  begin
    pAtualizarSaldoLote;
    cdsConsulta.Next;
  end;
  cdsConsulta.EnableControls;
end;


function TfrmEntEnderecamentoProduto.fUtiLot : boolean;
begin
  cdsConsulta.AfterScroll :=  nil;
  cdsConsulta.First;
  Result := fUsaRotinaWMS;

  If Not Result Then
    Result := cdsConsulta.Locate('TEMLOT', '1', []);

  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
end;

{function TfrmEntEnderecamentoProduto.fNaoUtiLot: boolean;
begin
  cdsConsulta.AfterScroll :=  nil;
  cdsConsulta.First;
  Result := Not fUsaRotinaWMS;
  If Not Result Then
    Result := cdsConsulta.Locate('TEMLOT', '0', []);
  cdsConsulta.AfterScroll := cdsConsultaAfterScroll;
end;}

function TfrmEntEnderecamentoProduto.fRegistroUtilizaLote: boolean;
Begin
  Result := (not objEnderecamento.blnRastreamentoIndustrial) and ((fUsaRotinaWMS) or (cdsConsulta.FieldByName('TEMLOT').AsString = '1'));
End;

function TfrmEntEnderecamentoProduto.fRetCamposIBPT: string;
  var
    i: integer;
Begin
  For i := 1 To 7 Do
  Begin
    If fCfgSis('IMPPAG', varInteger) = 1 Then
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
    End
    Else
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
    End;
  End;
end;

function TfrmEntEnderecamentoProduto.fDocumentoConferido(strSeqFgo : String) : Boolean;
  Var
    qryQuery : TUniQuery;
Begin
  Try
    qryQuery := fCriaQuery;
    With qryQuery, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT GER_DTACON ');
      Add(' FROM FATGOR G     ');
      Add('   INNER JOIN EXTGOR ON FGO_SEQFGO = G.AUTOINCREM ');
      Add('   INNER JOIN GERELE D ON D.B08_NNF    = SUBSTRING(FGO_DOCEND, 01, 12)       ');
      Add('                      AND D.B07_SERIE  = TRIM(SUBSTRING(FGO_DOCEND, 15, 03)) ');
      Add('                      AND D.GER_CODEMP = TRIM(SUBSTRING(FGO_DOCEND, 18, 03)) ');
      Add('                      AND IF(TRIM(SUBSTRING(FGO_DOCEND, 29, 01)) = "C",         ');
      Add('                             D.GER_CODCLI = TRIM(SUBSTRING(FGO_DOCEND, 21, 08)),');
      Add('                             D.GER_CODFOR = TRIM(SUBSTRING(FGO_DOCEND, 21, 08)))');
      Add('                      AND D.GER_TIP_FC = TRIM(SUBSTRING(FGO_DOCEND, 29, 01)) ');
      Add(' WHERE G.AUTOINCREM = ' + QuotedStr(strSeqFgo));

      If fCfgSis('LOCEQU', varBoolean) Then
        Add(' AND D.GER_TIPXML <> "7" ');  //xmlRetornoLocacao

      Open;

      //Se foi entrada direto nao tem XML nem Pre nota
      If (qryQuery.RecordCount = 0) Then
        Result := True
      Else
        Result := not fEmptyStr(FieldByName('GER_DTACON').AsString);

      Close;

    End;

  Finally
    FreeAndNil(qryQuery);
  End;
End;

function TfrmEntEnderecamentoProduto.fDocumentoConferidoSimplificado(strCodEmp, strNumDoc, strCodFor : String): Boolean;
Var
  qryQuery : TUniQuery;
Begin
  Try
    qryQuery := fCriaQuery;

    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add('SELECT GER_DTAFIM FROM MOVGER G');
    qryQuery.SQL.Add('INNER JOIN PCMGER ON PCG_ORIGND = GER_NUMDOC AND PCG_ORIGES = GER_ESPDOC AND PCG_ORIGEP = G.GER_CODEMP AND PCG_DTAPED = G.GER_DTAENT');
    qryQuery.SQL.Add('INNER JOIN CONDOC ON DOC_SEQGER = G.AUTOINCREM');
    qryQuery.SQL.Add('INNER JOIN CONGER ON CONGER.AUTOINCREM = DOC_SEQCON');
    qryQuery.SQL.Add('WHERE GER_NUMDOC = :NUMDOC AND PCG_CODFOR = :CODFOR  AND PCG_EMPDES = :EMPDES');
    qryQuery.ParamByName('NUMDOC').AsString  := strNumDoc;
    qryQuery.ParamByName('CODFOR').AsString  := strCodFor;
    qryQuery.ParamByName('EMPDES').AsString  := strCodEmp;
    qryQuery.Open;

    If qryQuery.RecordCount = 0 Then
      Result := True
    Else
      Result := not fEmptyStr(qryQuery.FieldByName('GER_DTAFIM').AsString);
  Finally
    FreeAndNil(qryQuery);
  End;
End;

function TfrmEntEnderecamentoProduto.fEscolheTipoEtiqueta: Boolean;
Var
  blnExiPrePro : Boolean;
begin
  Result := untFuncoesEtiqItens.fEscolheTipoEtiqueta (tpeEtique, False, blnPrePro, intTabPre, strCodCnd, strCndPag, strNumPar, strDesEti, blnExiPrePro);
  If Result Then
    lblEtiqueta.Caption := strDesEti;
end;

procedure TfrmEntEnderecamentoProduto.btnQtdEtiClick(Sender: TObject);
begin
  inherited;
  edtQtdEti.Visible := True;
  lblQtdEtiquetas.Visible := True;
  lblEtiqueta.Visible := True;
  pSetFocus(edtQtdEti);
end;

function TfrmEntEnderecamentoProduto.fCriaDataSetMultiSelecao(intQtdIte: Integer): TUniClientDataSet;
var
  i,intContador: Integer;
  qryEstrutura,
  qryAux: TUniQuery;
  cdsDados: TUniClientDataSet;
  field: TField;
  stlListaAux: TStringList;
begin
  qryEstrutura := fCriarQuery(fGetSQLItemEtiqueta('', 0, True, True)); 
  cdsDados := TUniClientDataSet.Create(Self);

  cdsDados.FieldDefs.Assign(qryEstrutura.FieldDefs);
  cdsDados.CreateDataSet;
  cdsDados.LogChanges := False;

  stlListaAux := TStringList.Create;
  Try
    For intContador := 0 To Pred(stlListSelecao.Count) Do
    Begin
      If cdsConsulta.Locate(strCampoLista, StringReplace(stlListSelecao[intContador],'''','',[rfReplaceAll]), []) Then
        If stlListaAux.IndexOf(cdsConsulta.FieldByName('FDO_CODITE').AsString) = -1 Then
          stlListaAux.Add(cdsConsulta.FieldByName('FDO_CODITE').AsString);
    End;

    stlListaAux.Sort;

    cdsDados.DisableControls;

    qryAux := fCriaQuery;
    For intContador := 0 To Pred(stlListaAux.Count) Do
    Begin
      If cdsConsulta.Locate('FDO_CODITE', stlListaAux[intContador], []) Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Text := fGetSqlItemEtiqueta(stlListaAux[intContador], intQtdIte, True);
        qryAux.Open;

        qryAux.First;
        While Not qryAux.Eof Do
        Begin
          for i := 1 to intQtdIte do
          begin
            cdsDados.Insert;
            For field in qryAux.Fields Do
            Begin
              cdsDados.FieldByName(field.FieldName).ReadOnly := False;
              cdsDados.FieldByName(field.FieldName).Value := Field.Value;
            End;

            cdsDados.Post;
          end;
          qryAux.Next;
        End;
      End;
    End;
  Finally
    cdsDados.EnableControls;
    cdsDados.IndexFieldNames := 'CODITE';
    FreeAndNil(stlListaAux);
    FreeAndNil(qryEstrutura);
    FreeAndNil(qryAux);
  End;

  Result := cdsDados;
End;


function TfrmEntENderecamentoProduto.fLoteFoiCadastradaDuranteProcessoEnderecamento: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;
  intRecNo := cdsConsulta.RecNo;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    while not cdsConsulta.Eof do
    begin
      if fEmptyStr(cdsConsulta.FieldByName('FDO_NUMLOT').AsString) then
      begin
        if fCampoTabela('FDO_NUMLOT', 'FATDOR', ['AUTOINCREM'], [cdsConsulta.FieldByName('AUTOINCREM').AsString]) <> '' Then
        begin
          pMensagemOk('As informações dessa reserva foram alteradas, ela deve ser recarregada!');
          pCancela(False);
          Exit(True);
        end;
      end;
      cdsConsulta.Next;
    End
  Finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
  End;
end;

function TfrmEntEnderecamentoProduto.fEhEntradaSimplificada(AEndDocumento: TEndDocumento): Boolean;
Begin
  Result := fCampoTabela('AUX_ENTSIM',
   ' MOVGER ' +
   ' JOIN AUXMOV ON  AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ',
   ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP', 'IFNULL(GER_CODFOR, "")' ],
   [AEndDocumento.strNumDoc,
    AEndDocumento.strEspDoc,
    AEndDocumento.strCodEmp,
    AEndDocumento.strCliFor]) = 'S';
End;

procedure TfrmEntEnderecamentoProduto.AddColumn(strFieldName, strCaption: String);
Var
  objColumn: TColumn;
Begin
  objColumn := dbgConsulta.Columns.Add;
  objColumn.FieldName :=strFieldName;
  objColumn.Title.Caption := strCaption;
  objColumn.Width := 120;
End;

end.
