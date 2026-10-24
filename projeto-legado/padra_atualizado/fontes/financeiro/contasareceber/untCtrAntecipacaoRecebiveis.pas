Unit untCtrAntecipacaoRecebiveis;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, UITypes,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  Vcl.Mask, MaskEditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, clipbrd,
  Datasnap.DBClient, untParcelamento, DBGridCitel, UniClientDataSet, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, untGravaMovCar,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxClasses, cxTextEdit, System.Generics.Collections, untTypesSistema,
  System.Math, untConsultas, untFuncoes, untFuncoesSimples, Uni, UniDataSetProvider, untConstantes,
  untTBanCtrRepository, untLiberacao, untCadChq, StrUtils, untTCadChqRepository, untTefRecebimento, untMsgLiberacao;

type
  TfrmCtrAntecipacaoRecebiveis = class(TfrmPai)
    pnlDados: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtValorCorrigido: TEditFocus;
    lblPreVis: TLabel;
    mskDtaPagto: TMaskEditFocus;
    Panel1: TPanel;
    pnlGrid: TPanel;
    pnlTotais: TPanel;
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    cxGridParcelas: TcxGrid;
    cxvGridParcelas: TcxGridDBTableView;
    cxvGridANT_VLRCAL: TcxGridDBColumn;
    cxvGridANT_PRCDSC: TcxGridDBColumn;
    cxvGridANT_VLRDSC: TcxGridDBColumn;
    cxvGridANT_NROCHQ: TcxGridDBColumn;
    cxvGridANT_NOMCAR: TcxGridDBColumn;
    cxvGridANT_DTAVEN: TcxGridDBColumn;
    cxGridParcelasLevel1: TcxGridLevel;
    pnlFundo: TPanel;
    lblvaldig: TLabel;
    lblPorBaiDin: TLabel;
    edtPorBaiDin: TEditFocus;
    edtDesPorBaiDin: TEditFocus;
    lblDinheiro: TLabel;
    edtDinheiro: TEditFocus;
    lblPorBaiChV: TLabel;
    edtPorBaiChV: TEditFocus;
    edtDesPorChV: TEditFocus;
    lblChequeVista: TLabel;
    edtChqVista: TEditFocus;
    lblPorBaiOrd: TLabel;
    edtPorBaiChP: TEditFocus;
    edtDesPorChP: TEditFocus;
    lblChequePre: TLabel;
    edtChqPre: TEditFocus;
    lblPorBaiRep: TLabel;
    edtPorCart: TEditFocus;
    edtDesPorCart: TEditFocus;
    lblCartao: TLabel;
    edtCartao: TEditFocus;
    Label2: TLabel;
    edtPorAntec: TEditFocus;
    edtDesPorAntec: TEditFocus;
    lbl1: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    cxvGridANT_ESPORI: TcxGridDBColumn;
    cxvGridANT_VLRORI: TcxGridDBColumn;
    Label3: TLabel;
    edtValCalc: TEditFocus;
    edtValDig: TEditFocus;
    edtValTotDesconto: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    mskDtaBase: TMaskEditFocus;
    btnCalculo: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAltValChqEmiClick(Sender: TObject);
    procedure edtPorBaiChVKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorBaiChPKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorCartKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorBaiDinKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtPorAntecKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnCalculoClick(Sender: TObject);
  private
    { Private declarations }

    FobjTefRecebimento            : ITefRecebimento;
    FstrSessaoTef                 : String;
    FblnExecutandoPeloFaturamento : Boolean;

    objLiberacao : TLiberacao;

    //qryConVen   : TUniQuery;
    qryConPor   : TUniQuery;
    qryConOpe   : TUniQuery;

    qryValoresCalc : TUniQuery;
    cdsValoresCalc : TUniClientDataSet;
    dtSourceValoresCalc : TUniDataSource;

    blnDescontoAteVencimento: Boolean;

    strNumAgr     : String;
    strCCGerado   : String;
    strCodCnd     : String;
    blnUsaTelaCnd : Boolean;

    blnEfetuandoRateio : Boolean;

    intDigitChq : Integer;
    intSeqCon   : Integer;

    strCodOpe   : String;

    //blnBaiUtl: Boolean;

    //TOTALIZADORES
    fltDinhei : Double;
    fltChqVis : Double;
    fltChqPre : Double;
    fltCartao : Double;
    fltValDig : Double;
    fltValCal : Double;
    fltValTotDes : Double;

    procedure pGravaAntecipacaoValores;
    procedure pCriaTemporaria(arrDupSel: array of TDuplicataCtr);
    procedure pRetornaTotal(strCodCli, strCodEmp: String; var fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre: Double; strParcela: String = '');
    procedure pAtualizaValDig;
    procedure pCarregaImpostoProporcional(fltValor: Double; out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
    procedure pCarregaVendedor;

    function fGravaOperacoes( dtaDtaAgr, dtaDtaVenc: TDateTime; strConPag: String): Boolean;
    function fMontaHistoricoAntecipacao: String;
    function fGravaRelacionaisAntecRecebiveis(strNumAgr, strParcel, strNumCre, strCodCli, strCodEmp: String; strSeqLan: String; strEspecie: String; flValLan : double; strCodCta : String; strCodPor : String ): String;
    function fCriacdsValoresCalc: TUniClientDataSet;
    function fRetornaDataPagamento: TDate;
    function fDeletaDuplicatas(arrDupSel: array of TDuplicataCtr): Boolean;
    function fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
    function fRetornaCliente: String;
    function fRetornaEmpresa: String;
    function fRetornaAutoIncrem(strNroDup, strParDup, strEspDoc, strCodCli, strCodEmp: String): String;
    function fChequePre(strValor: String): Boolean;
    function fChequeVis(strValor: String): Boolean;
    function fPrecisaDigitarChequeAVista: Boolean;
    function fPrecisaDigitarChequePre: Boolean;
    function fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
    function fDigitacaoCartoes(fltValor: Double; Var arrCartoes: TCartoesResumoCaixaArray; strCodCar: String = ''; strCodFin: String = ''; intQtdPar: Integer = 0) : Boolean;
    function fGravaDupsGeradas(strNumDup, strParDup, strEspDoc, strCodEmp, strCodCli : String ) : Boolean;
    function fRetornaDupsGeradas() : String;
    function fGravaCheques(intSeqCon: Integer; dtaDtaLan : TDateTime;
                           strNumDup, strCodCli, strCodEmp, strCodVen, strCodOpe, strCodPorChV, strCodPorChP,
                           strCtaBai: String; flTotChV, flTotChP : Double): Boolean;

    function fGravaCreditoCliente(fltValCre: Double; intSeqCon: Integer; dtaDtaLan : TDateTime;
                                  strNumDup, strCodCli, strCodEmp, strCodVen, strCodOpe, strCodPor,
                                  strCtaBai: String): Boolean;

    function fGravaMovimentacaoBancaria(strCodCta, strCodPor, strOper: String;
                                        dtaDtaLan: TDate; horHorLan: TTime; strNumDoc, strEspdoc, strTipo, strCodEmp: String;
                                        fltValLan: Double; strHis, strCodCli: String; IntSeqCon: Integer): String;

    procedure pMontaGrid;
    procedure pLimpaTela;
    procedure pCalculaJurosAntecipacao;
    procedure pPreencheArrayDuplicatas;
    function fVeiodeCH: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    arrCartoes       : TCartoesResumoCaixaArray;
    blnConfCartoes   : Boolean;

    strDupsGeradas   : String;   // retorna para abir automaticamente carregadas no baixa de contas receber

    blnConfirma      : Boolean;
    blnGravou        : Boolean;
    objParcelamento  : TParcelamento;
    cdsCtaRecDups    : TUniClientDataSet;
    cdsCtaRecDados   : TUniClientDataSet;

    arrRegDup        : Array Of TRecDuplicatas;
    arrDupAbeAut     : Array Of TDuplicataCtr; // array para trazer carregadas as duplicatas geradas no processo.

    dicCheques       : TDictionary<String, TChequeEmitido>;

    flTotalDups      : Double;
    strCliente       : String;

    fltValTot        : Double;
    cdsChqPre        : TUniClientDataSet;
    cdsChqVis        : TUniClientDataSet;

    blnVeiodeCH      : Boolean;
    blnCtaRec        : Boolean;
    blnTroChq        : Boolean; // Troco para cheque.
    blnTroCar        : Boolean; // Troco para cartao
    strDocume        : String;
    optTroco         : TOperacaoTroco;
    fltValorTroco    : Double;

    property objTefRecebimento            : ITefRecebimento read FobjTefRecebimento            write FobjTefRecebimento;
    property strSessaoTef                 : String          read FstrSessaoTef                 write FstrSessaoTef;
    property blnExecutandoPeloFaturamento : Boolean         read FblnExecutandoPeloFaturamento write FblnExecutandoPeloFaturamento;

  end;

var
  frmCtrAntecipacaoRecebiveis: TfrmCtrAntecipacaoRecebiveis;

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untRcxMostraCartoes, untRcxDigCartoes, untGravando, untEmissaoCheques, untCadRec, untRcxMostraCheques, untCadCheques,
  untArredondaParcelaImpl, untMovCar, untMovBan, untPesqAux, untDuplicatas;

{$R *.dfm}

procedure TfrmCtrAntecipacaoRecebiveis.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodVen.Text, False, True);
  With qryConOpe Do
  Begin
    edtNomVen.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCtrAntecipacaoRecebiveis.pCriaTemporaria(arrDupSel: Array Of TDuplicataCtr);
  Var
    strSQL      : String;
    qryCtaRec   : TUniQuery;
    dspCtaRec   : TUniDataSetProvider;
    intContador : Integer;
begin
  Try
      // ***************************************************************//
      // RETORNA OS DADOS DOS REGISTROS DO CONTAS PARA GRAVAR O DUPAGR  //
      // ***************************************************************//
      cdsCtaRecDados.Close;
      qryCtaRec         := fCriaQuery(Self);
      dspCtaRec         := TUniDataSetProvider.Create(Self);
      dspCtaRec.DataSet := qryCtaRec;
      cdsCtaRecDados.SetProvider(dspCtaRec);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
      strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
      strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
      strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
      strSQL := strSQL + '  R.CTR_SEQBAI AS CTR_SEQBAI, ';
      strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
      strSQL := strSQL + '  R.CTR_DTACAD AS CTR_DTACAD, ';

      If blnDescontoAteVencimento Then
      Begin
        strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IF(R.CTR_DTAVEN >= CURRENT_DATE, IFNULL(R.CTR_DESSUJ, 0), 0) AS CTR_VALDUP, ';
        strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IF(R.CTR_DTAVEN >= CURRENT_DATE, IFNULL(R.CTR_DESSUJ, 0), 0) AS CTR_VALCOR, ';
      End
      Else
      Begin
        strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALDUP, ';
        strSQL := strSQL + '  R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0) - IFNULL(R.CTR_DESSUJ, 0) AS CTR_VALCOR, ';
      End;

      strSQL := strSQL + '  0.00 AS CTR_JURATR,  '; //VALOR DE JUROS ATRASO
      strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
      strSQL := strSQL + '  R.AUTOINCREM AS CTR_AUTOIN, ';
      strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';
      strSQL := strSQL + '  C.CLI_CODCLI AS CLI_CODCLI, ';
      strSQL := strSQL + '  C.AUTOINCREM AS CLI_AUTOIN, ';
      strSQL := strSQL + '  C.CLI_NOMCLI AS CTR_NOMCLI, ';
      strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
      strSQL := strSQL + '  C.CLI_CODREP AS CTR_CODREP, ';
      strSQL := strSQL + '  R.CTR_CODVEN AS CTR_CODVEN, ';
      strSQL := strSQL + '  R.CTR_CODDIG AS CTR_CODDIG, ';
      strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
      strSQL := strSQL + '  P.POR_NOMPOR AS POR_NOMPOR, ';
      strSQL := strSQL + '  CONCAT(R.CTR_CODPOR, "-", P.POR_NOMPOR) AS CTR_NOMPOR, ';
      strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
      strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
      strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
      strSQL := strSQL + '  R.CTR_ADTCLI AS CTR_ADTCLI, ';
      strSQL := strSQL + '  R.CTR_CODEVE AS CTR_CODEVE, ';
      strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
      //strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';  //REPLACE(CTR_HIST01, "<<csq>>" , " "), " "
      strSQL := strSQL + '  REPLACE(R.CTR_HIST01, "<<csq>>" , " ") AS CTR_HIST01, ';
      strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
      strSQL := strSQL + '  R.CTR_CODCND AS CTR_CODCND, ';
      strSQL := strSQL + '  IF(R.CTR_TIPFOR IS NULL OR CTR_TIPFOR="", "NENHUM", R.CTR_TIPFOR) AS CTR_TIPFOR, ';
      strSQL := strSQL + '  R.CTR_CODCTA AS CTR_CODCTA, ';
      strSQL := strSQL + '  R.CTR_CTASER AS CTR_CTASER, ';
      strSQL := strSQL + '  R.CTR_SERVAL AS CTR_SERVAL, ';
      strSQL := strSQL + '  R.CTR_CARTEI AS CTR_CARTEI, ';
      strSQL := strSQL + '  CTR_CONAPR, ';
      strSQL := strSQL + '  CTR_VALCOM, ';
      strSQL := strSQL + '  CTR_FATCOM, ';
      strSQL := strSQL + '  CTR_COMREP, ';
      strSQL := strSQL + '  CTR_FATREP, ';
      strSQL := strSQL + '  CTR_EMP_PD, ';
      strSQL := strSQL + '  CTR_VALIPI, ';
      strSQL := strSQL + '  CTR_VALRET, ';
      strSQL := strSQL + '  CTR_VALCBS, ';
      strSQL := strSQL + '  CTR_VALIBS, ';
      strSQL := strSQL + '  CTR_VAL_IS, ';
      strSQL := strSQL + '  CTR_VALACE, ';
      strSQL := strSQL + '  CTR_VALFRE, ';
      strSQL := strSQL + '  CTR_SEQCON, ';
      strSQL := strSQL + '  CTR_DIFORI, ';
      strSQL := strSQL + '  CTR_GRVORI, ';
      strSQL := strSQL + '  CTR_VALANT, ';
      strSQL := strSQL + '  R.CTR_DESSUJ, ';
      strSQL := strSQL + '  R.CTR_JURSUJ, ';
      strSQL := strSQL + '  R.CTR_BARCON, ';
      strSQL := strSQL + '  R.CTR_PERDPO, ';
      strSQL := strSQL + '  R.CTR_QTDDAV, ';
      strSQL := strSQL + '  R.CTR_VALORI, ';
      strSQL := strSQL + '  C.CLI_CODVEN, ';

      strSQL := strSQL + '  0.00 AS CTR_VALDES, ';
      strSQL := strSQL + '  0.00 AS CTR_VALJUR, ';
      strSQL := strSQL + '  0.00 AS CTR_VALCOB, ';
      strSQL := strSQL + '  0.00 AS CTR_VALCAL, ';
      strSQL := strSQL + '  0.00 AS CTR_VALREC, ';
      strSQL := strSQL + '  0.00 AS CTR_VALRES, ';
      strSQL := strSQL + '  " "  AS CTR_TIPBAI, ';

      strSQL := strSQL + '  CURRENT_TIMESTAMP AS HRAFIL, ';
      strSQL := strSQL + '    (SELECT COUNT(*) FROM  ';
      strSQL := strSQL + '     CADREC C ';
      strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI) - 1 AS CTR_BAIXAS, ';

      strSQL := strSQL + '    (SELECT IFNULL(CTR_VALCOM, 0) FROM ';
      strSQL := strSQL + '     CADREC C ';
      strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
      strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_VALCOM_SEQBAI_01, ';

      strSQL := strSQL + '    (SELECT SUM(IFNULL(CTR_VALREC, 0)) FROM ';
      strSQL := strSQL + '     CADREC C ';
      strSQL := strSQL + '          WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '            AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '            AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '            AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '            AND C.CTR_CODCLI = R.CTR_CODCLI) AS CTR_TOTAL_RECEB, ';

      strSQL := strSQL + '    (SELECT IFNULL(CTR_FATCOM, 0) FROM ';
      strSQL := strSQL + '     CADREC C ';
      strSQL := strSQL + '    WHERE C.CTR_NUMDUP = R.CTR_NUMDUP ';
      strSQL := strSQL + '      AND C.CTR_ESPDOC = R.CTR_ESPDOC ';
      strSQL := strSQL + '      AND C.CTR_PARCEL = R.CTR_PARCEL ';
      strSQL := strSQL + '      AND C.CTR_CODEMP = R.CTR_CODEMP ';
      strSQL := strSQL + '      AND C.CTR_CODCLI = R.CTR_CODCLI ';
      strSQL := strSQL + '      AND C.CTR_SEQBAI = 1) AS CTR_FATCOM_SEQBAI_01, ';

      strSQL := strSQL + '  " " AS CTR_MARDES,  ';
      strSQL := strSQL + '  0.00 AS CTR_VALDES, ';
      strSQL := strSQL + '  "CADREC" AS TABELA, ';
      strSQL := strSQL + '  0.00 AS CTR_JURREP,  ';//VALOR DE JUROS DO REPARCELAMENTO
      strSQL := strSQL + '  CTR_DOCDIV,  ';
      strSQL := strSQL + '  CTR_ESPDIV,  ';
      strSQL := strSQL + '  CTR_EMPDIV,  ';
      strSQL := strSQL + '  CTR_CLIDIV,  ';
      strSQL := strSQL + '  CTR_COMDIV,  ';
      strSQL := strSQL + '  CTR_FATDIV,  ';
      strSQL := strSQL + '  CTR_CODDIV,  ';
      strSQL := strSQL + '  CONCAT(R.CTR_CODCND, "-", N.CND_DESCRI) AS CONDPAG ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI C ';
      strSQL := strSQL + '  JOIN CADREC R ON R.CTR_CODCLI = C.CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
      strSQL := strSQL + '  LEFT JOIN CADCND N ON R.CTR_CODCND = N.CND_CODIGO ';
      strSQL := strSQL + ' WHERE R.AUTOINCREM IN (';
      For intContador := 0 To Length(arrDupSel) -1 Do
          strSQL := strSQL + '"' + arrDupSel[intContador].strAutoIn + '"' +
                             IIF(intContador < Length(arrDupSel) - 1, ',', ')');

      With qryCtaRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
      End;
      cdsCtaRecDados.Open;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCtrAntecipacaoRecebiveis.pCriaTemporaria]');
  End;
  cdsCtaRecDados.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
end;

function TfrmCtrAntecipacaoRecebiveis.fRetornaAutoIncrem( strNroDup, strParDup, strEspDoc, strCodCli, strCodEmp : String) : String;
  Var
    strSQL     : String;
    qryGenRec  : TUniQuery;
begin
  Try
    Result := '';

    qryGenRec := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT AUTOINCREM FROM CADREC ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '     CTR_NUMDUP = :NRODUP ';
      strSQL := strSQL + ' AND CTR_PARCEL = :PARDUP ';
      strSQL := strSQL + ' AND CTR_ESPDOC = :ESPDOC ';
      strSQL := strSQL + ' AND CTR_CODEMP = :CODEMP ';
      strSQL := strSQL + ' AND CTR_CODCLI = :CODCLI ';
      With qryGenRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NRODUP').Value := strNroDup;
        ParamByName('PARDUP').Value := strParDup;
        ParamByName('ESPDOC').Value := strEspDoc;
        ParamByName('CODEMP').Value := strCodCli;
        ParamByName('CODCLI').Value := strCodEmp;

        Open;

        If Not IsEmpty Then
           Result := FieldByName('AUTOINCREM').AsString;

        Close;

      End;

    Except
      On E: Exception Do
      Begin
        Result := '';
        Raise Exception.Create('Erro ao buscar autoincrem. Erro gerado: ' + E.Message);
      End;

    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

function TfrmCtrAntecipacaoRecebiveis.fRetornaCliente: String;
var
  cdsGen: TUniClientDataSet;
Begin
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin
    DisableControls;
    IndexFieldNames := 'CTR_CODCLI';
    Result := '';
    First;

    If Not IsEmpty Then
    Begin
       If Not fEmptyStr(FieldByName('CTR_CODCLI').AsString) Then
          Result := FieldByName('CTR_CODCLI').AsString;
    End;
    EnableControls;
  End;
  FreeAndNil(cdsGen);
End;

function TfrmCtrAntecipacaoRecebiveis.fRetornaEmpresa: String;
var
  cdsGen: TUniClientDataSet;
Begin
  If (fCfgSis('AGRTPR', varInteger) = 3) Then
  Begin
    cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
    With cdsGen Do
    Begin
      DisableControls;
      IndexFieldNames := 'CTR_CODEMP';
      Result := '';
      First;

      If Not IsEmpty Then
      Begin
        If Not fEmptyStr(FieldByName('CTR_CODEMP').AsString) Then
        Begin
           Result := FieldByName('CTR_CODEMP').AsString;;
        End;
      End;

      EnableControls;
    End;
    FreeAndNil(cdsGen);
  End
  Else
  Begin
    Result := VS_strCodEmp;
  End;
end;

Procedure TfrmCtrAntecipacaoRecebiveis.pPreencheArrayDuplicatas;
var
  cdsGen: TUniClientDataSet;
  intTam : Integer;
Begin
  cdsGen := fCriaClientCtaRec('CTR_MARDES = ' + QuotedStr('M'));
  With cdsGen Do
  Begin

    DisableControls;
    First;

    SetLength(arrRegDup,0);
    while Not Eof do
    Begin
       intTam := Length(arrRegDup);
       SetLength(arrRegDup, intTam+1);

       arrRegDup[intTam].  strValDup := cdsGen.FieldByName('CTR_VALDUP').AsString;
       arrRegDup[intTam].strDtaVen := cdsGen.FieldByName('CTR_DTAVEN').AsString;

       Next;
    End;

    EnableControls;
  End;
  FreeAndNil(cdsGen);
End;

function TfrmCtrAntecipacaoRecebiveis.fVeiodeCH: Boolean;
Begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Recebimento de documento proveniente de cheque.');
  objLiberacao.objMsgLibera.pAddTexto('Existem duplicatas com espécie CH, ou seja, documento ' +
                                      'proveniente de um cheque transformado em contas a receber. ');
  objLiberacao.objMsgLibera.pAddTexto('Não é permitido receber nessa modalidade (Cheque/Cartão).');

  objLiberacao.strDirAce := 'CTRCHQ';
  objLiberacao.strMsgSen := 'Recebimento de documento proveniente de cheque';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
End;

function TfrmCtrAntecipacaoRecebiveis.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;

begin
  Result := True;

  Try

      {************************************}
      {* VALIDA DINHEIRO                  *}
      {*********************************MV*}
      If (Sender = edtDinheiro) Then
      Begin

         If (fEmptyStr(edtDinheiro.Text)) Then
            edtDinheiro.Text := '0,00'
         Else
         If Not (fEmptyStr(edtPorBaiDin.Text)) And  (edtDinheiro.Text = '0,00') Then
         Begin
            fMensagem('', 'O valor do dinheiro deve ser preenchido!', ['&OK']);
            Result := False;
         End;

         pAtualizaValDig;

      End

      {************************************}
      {* VALIDA CHEQUE A VISTA            *}
      {*********************************AF*}
      Else If (Sender = edtChqVista) And (edtChqVista.Enabled) Then
      Begin

        If InterlockedIncrement(intDigitChq) = 0 Then
        Begin

           If (fEmptyStr(edtChqVista.Text)) Then
              edtChqVista.Text := '0,00'
           Else
           If Result And (fStrToFloat(edtChqVista.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(edtPorBaiChV.Text, 'MODCHV')) Then
           Begin
             fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
             Result := False;
           End;

          {*************************************************}
          {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
          {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
          {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
          {* O CHEQUE PARA O CTR.                          *}
          {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
          {* DE LIBERAÇÃO PARA O MESMO                     *}
          {**24/02/2015**REQ:30058***********************AF*}
          If Result And blnVeiodeCH And (fStrToFloat(edtChqVista.Text) <> 0.0) Then
          Begin
            If Not fVeiodeCH Then
            Begin
              Result := False;
              edtChqVista.Text := '0,00';
            End;
          End;

          If (Not cdsChqVis.IsEmpty) Then
              Result := fChequeVis(edtChqVista.Text)
          Else
          {*********************************************************}
          {SE ESTIVER CONFIGURADO PARA CADASTRAR CHEQUES A VISTA   *}
          {******************************************************AF*}
          If Result And (fStrToFloat(edtChqVista.Text) <> 0.0) Then
             Result := fChequeVis(edtChqVista.Text);

          If Result Then
             pAtualizaValDig;

          InterlockedDecrement(intDigitChq);
        End
        Else
          InterlockedDecrement(intDigitChq);
      End

      {************************************}
      {* VALIDA CHEQUE A PRAZO            *}
      {*********************************AF*}
      Else If (Sender = edtChqPre) And (edtChqPre.Enabled) Then
      Begin
        If InterlockedIncrement(intDigitChq) = 0 Then
        Begin
          If (fEmptyStr(edtChqPre.Text)) Then
              edtChqPre.Text := '0,00'
          Else
          If Result And (fStrToFloat(edtChqPre.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(edtPorBaiChP.Text, 'MODCHP')) Then
          Begin
            fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
            Result := False;
          End;

          {*************************************************}
          {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
          {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
          {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
          {* O CHEQUE PARA O CTR.                          *}
          {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
          {* DE LIBERAÇÃO PARA O MESMO                     *}
          {**24/02/2015**REQ:30058***********************AF*}
          If Result And blnVeiodeCH And (fStrToFloat(edtChqPre.Text) <> 0.0) Then
          Begin
            If Not fVeiodeCH Then
            Begin
              Result := False;
              edtChqPre.Text := '0,00';
            End;
          End;

          If (Not cdsChqPre.IsEmpty) Then
              Result := fChequePre(edtChqPre.Text)
          Else

          If Result And (fStrToFloat(edtChqPre.Text) <> 0.0) Then
            Result := fChequePre(edtChqPre.Text);

          If Result Then
            pAtualizaValDig;

          InterlockedDecrement(intDigitChq);
        End
        Else
          InterlockedDecrement(intDigitChq);
      End

      {************************************}
      {* VALIDA CARTÃO                    *}
      {*********************************AF*}
      Else If (Sender = edtCartao) And (edtCartao.Enabled) Then
      Begin

        If ( fStrToFloat(edtCartao.Text) = 0) And ( length(arrCartoes) > 0 ) Then
        Begin

          If fMensagem('AVISO', 'Existe(m) Cartão(s) Digitado(s)! Limpar a Digitação de Cartão?', ['&Sim', '&Não']) = 1 Then
          Begin
            edtCartao.Text := '0,00';
            SetLength(arrCartoes, 0);
          End;

        End
        Else

        If (fStrToFloat(edtCartao.Text) <> 0.0) And (Not fPermiteModalidadeParaPortador(edtPorCart.text, 'MODCAR')) Then
        Begin
          fMensagem('','O Portador para baixa não tem permissão para esta modalidade!',['&OK']);
          Result := False;
        End;

        {*************************************************}
        {* VERIFICA SE EXISTE ALGUM DOCUMENTO MARCADO    *}
        {* COM ESPÉCIE CH, O QUE SIGNIFICA QUE O MESMO   *}
        {* VEIO DE UMA DEVOLUÇÃO DEFINITIVA OU TRANFERIU *}
        {* O CHEQUE PARA O CTR.                          *}
        {* CASO SEJA ISSO DEVE SER SOLICITADO UMA SENHA  *}
        {* DE LIBERAÇÃO PARA O MESMO                     *}
        {**24/02/2015**REQ:30058***********************AF*}
        //If Result And blnVeiodeCH And (fStrToFloat(edtCartao.Text) <> 0.0) Then
        If blnVeiodeCH And (fStrToFloat(edtCartao.Text) <> 0.0) Then
        Begin
           If Not fVeiodeCH Then
           Begin
              Result         := False;
              edtCartao.Text := '0,00';
           End;
        End;

        If (fStrToFloat(edtCartao.Text) <> 0.0) Then
            fDigitacaoCartoes(fStrToFloat(edtCartao.Text), arrCartoes);

        pAtualizaValDig;

      End
      Else
      If Sender = edtPorBaiDin Then
      Begin
         If fEmptyStr(edtPorBaiDin.Text) And (edtDinheiro.Text <> '0,00') Then
         Begin
            fMensagem('','Informe o Portador!', ['&OK']);
            Result := False;
         End
         Else If Not fEmptyStr(edtPorBaiDin.Text) Then
         Begin
            edtDesPorBaiDin.Text := fRetNomPortador(edtPorBaiDin.Text);

            If fEmptyStr(edtDesPorBaiDin.Text) Then
            Begin
              fMensagem('','Portador não Cadastrado!', ['&OK']);
              Result := False;
            End
            Else If Not fPortadorPermiteBaixa(edtPorBaiDin.Text) Then
            Begin
              fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
              Result := False;
            End
            Else If Not fEmpresaTemAcessoPortador(edtPorBaiDin.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
              Result := False;
            End
            Else If fCfgSis('DACPOR', varBoolean) Then
            Begin
              If Pos(edtPorBaiDin.Text, strPortadoresOperador) <= 0 Then
              Begin
                fMensagem('', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
                Result := False;
              End;
            End;
         End;
         pAtualizaValDig;
      End
      Else
      If Sender = edtPorBaiChV Then
      Begin

        If (Not fEmptyStr(edtPorBaiChV.Text)) Then
        Begin
          edtDesPorChV.Text := fRetNomPortador(edtPorBaiChV.Text);

          If fEmptyStr(edtDesPorChV.Text) Then
          Begin
            fMensagem('','Portador não Cadastrado!', ['&OK']);
            Result := False;
          End
          Else If Not fPortadorPermiteBaixa(edtPorBaiChV.Text) Then
          Begin
            fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBaiChV.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) And (Pos(edtPorBaiChV.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
            Result := False;
          End
          Else
            pAtualizaValDig;
        End
        Else
        Begin
          edtChqVista.Text := '0,00';
          edtDesPorChV.Text := '';
          pAtualizaValDig;
        End;
      End
      Else
      If Sender = edtPorBaiChP Then
      Begin

        If (Not fEmptyStr(edtPorBaiChP.Text)) Then
        Begin
          edtDesPorChP.Text := fRetNomPortador(edtPorBaiChP.Text);

          If fEmptyStr(edtDesPorChP.Text) Then
          Begin
            fMensagem('','Portador não Cadastrado!', ['&OK']);
            Result := False;
          End
          Else If Not fPortadorPermiteBaixa(edtPorBaiChP.Text) Then
          Begin
            fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorBaiChP.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) And (Pos(edtPorBaiChP.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
            Result := False;
          End
          Else
            pAtualizaValDig;
        End
        Else
        Begin
          edtChqPre.Text := '0,00';
          edtDesPorChP.Text := '';
          pAtualizaValDig;
        End;
      End
      Else
      If Sender = edtPorCart Then
      Begin

        If (Not fEmptyStr(edtPorCart.Text)) Then
        Begin
          edtDesPorCart.Text := fRetNomPortador(edtPorCart.Text);

          If fEmptyStr(edtDesPorCart.Text) Then
          Begin
            fMensagem('','Portador não Cadastrado!', ['&OK']);
            Result := False;
          End
          Else If Not fPortadorPermiteBaixa(edtPorCart.Text) Then
          Begin
            fMensagem('', 'Esse portador não tem permissão para realizar baixa!', ['&OK']);
            Result := False;
          End

          Else If Not fEmpresaTemAcessoPortador(edtPorCart.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) And (Pos(edtPorCart.Text, strPortadoresOperador) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&OK']);
            Result := False;
          End
          Else
            pAtualizaValDig;
        End
        Else
        Begin
          edtCartao.Text := '0,00';
          edtDesPorCart.Text := '';
          pAtualizaValDig;
        End;
      End
      Else
      If Sender = edtPorAntec Then
      Begin
         If Not fEmptyStr(edtPorAntec.Text) Then
            edtDesPorAntec.Text := fRetNomPortador(edtPorAntec.Text)
         Else
         If fEmptyStr(edtPorAntec.Text) Then
         Begin
            fMensagem('ATENÇÃO!', 'O portador de antecipação deve ser preenchido!', ['&O k']);
            edtDesPorAntec.Text := '';
            Result := False;
         End;
      End
      Else
      If Sender = edtCodVen Then
      Begin
         If Not fEmptyStr(edtCodVen.Text) Then
         Begin

            pCarregaVendedor;
            If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
            Begin
               fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
               Result := False;
            End
            Else
            If fEmptyStr(edtCodVen.text) And fEmptyStr(edtNomVen.text) Then
            Begin
               fMensagem('ATENÇÃO!', 'O vendedor deve ser preenchido!', ['&O k']);
               edtNomVen.text := '';
               Result := False;
            End;

         End
         Else
         Begin
           fMensagem('ATENÇÃO!', 'O vendedor deve ser preenchido!', ['&O k']);
           edtNomVen.text := '';
           Result := False;
         End;
      End;

  Except

    On E: ExceptionAutcom Do
    Begin
      Result := False;
      pMensagemOk(E.Message);
      pSetFocus(Sender);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;

  End;

  If (Not Result) Then
      pSetFocus(Sender);
end;

procedure TfrmCtrAntecipacaoRecebiveis.pAtualizaValDig;

  procedure pChecaText(objT : TEditFocus);
  Begin
    If not objT.Enabled Then
      objT.Clear;

  End;

  Var
     intContador: Integer;
Begin
  fltDinhei := 0;
  fltChqVis := 0;
  fltChqPre := 0;
  fltCartao := 0;

  If Not fEmptyStr(edtDinheiro.Text) Then
     fltDinhei := fStrToFloat(edtDinheiro.Text);

  If Not fEmptyStr(edtChqVista.Text) Then
     fltChqVis := fStrToFloat(edtChqVista.Text);

  If Not fEmptyStr(edtChqPre.Text) Then
     fltChqPre := fStrToFloat(edtChqPre.Text);

  //If (Not fEmptyStr(edtCartao.Text)) And (fStrToFloat(edtCartao.Text) <> 0.0) Then
  //Begin

     If fCfgSis('DIGCAR', varBoolean) Then
     Begin
        If Length(arrCartoes) > 0 Then
        Begin
          For intContador := 0 To Length(arrCartoes)-1 Do
          Begin
            fltCartao := fltCartao + arrCartoes[intContador].fltValDig;
          End;
        End;
        edtCartao.Text := FloatToStrF(fltCartao,ffFixed,12,2);
     End
     Else
     Begin
       fltCartao := fStrToFloat(edtCartao.Text);
     End;

  //End;

  pMontaGrid();

  edtDinheiro.Enabled       := (Not fEmptyStr(edtPorBaiDin.Text));
  edtChqVista.Enabled       := (Not fEmptyStr(edtPorBaiChV.Text));
  edtChqPre.Enabled         := (Not fEmptyStr(edtPorBaiChP.Text));
  edtCartao.Enabled         := (Not fEmptyStr(edtPorCart.Text));

  edtDesPorBaiDin.Enabled   := (Not fEmptyStr(edtPorBaiDin.Text));
  edtDesPorChV.Enabled      := (Not fEmptyStr(edtPorBaiChV.Text));
  edtDesPorChP.Enabled      := (Not fEmptyStr(edtPorBaiChP.Text));
  edtDesPorCart.Enabled     := (Not fEmptyStr(edtPorCart.Text));

  pChecaText(edtDinheiro);
  pChecaText(edtDesPorBaiDin);

  pChecaText(edtChqVista);
  pChecaText(edtDesPorChV);

  pChecaText(edtChqPre);
  pChecaText(edtDesPorChP);

  pChecaText(edtCartao);
  pChecaText(edtDesPorCart);

  If fEmptyStr(edtDinheiro.Text) Then
     edtDinheiro.Text := '0,00';

  If fEmptyStr(edtChqVista.Text) Then
     edtChqVista.Text := '0,00';

  If fEmptyStr(edtChqPre.Text) Then
     edtChqPre.Text   :=  '0,00';

  If fEmptyStr(edtCartao.Text) Then
     edtCartao.Text :=  '0,00';

  fltValDig := fltDinhei + fltChqVis + fltChqPre + fltCartao;

  //lblValDig.Caption := 'Valor Original: ' + FloatToStrF(fltValDig,ffFixed,12,2);
  edtValdig.Text := FloatToStrF(fltValDig,ffFixed,12,2);
End;

procedure TfrmCtrAntecipacaoRecebiveis.pMontaGrid();
 Var
     intC, intC2     : Integer;
     fltValCalc      : Double;
     objArredParcela : IArredondaParcela;
     arrDuplicata    : TArrDigDuplicArray;

     LDataBaseCartao: TDateTime;
     LTipoParcelamento: String;
Begin
  cdsValoresCalc.DisableControls;
  cdsValoresCalc.EmptyDataSet;
  fltValCalc := 0;

  // Dinheiro
  If (Not fEmptyStr(edtporBaiDin.text)) And ( (fStrToFloat(edtDinheiro.Text) <> 0.0) and (Not fEmptyStr(edtDinheiro.Text)) ) Then
  Begin
     cdsValoresCalc.append;
     cdsValoresCalc.fieldByName('ANT_ESPORI').AsString     := 'Dinheiro';
     cdsValoresCalc.fieldByName('ANT_VLRORI').AsFloat      := fStrToFloat(edtDinheiro.Text);
     cdsValoresCalc.fieldByName('ANT_VLRCAL').AsFloat      := fStrToFloat(edtDinheiro.Text);
     cdsValoresCalc.fieldByName('ANT_PRCDSC').AsFloat      := 0.00;
     cdsValoresCalc.fieldByName('ANT_VLRDSC').AsFloat      := 0.00;
     cdsValoresCalc.fieldByName('ANT_NROCHQ').AsString     := '';
     cdsValoresCalc.fieldByName('ANT_NOMCAR').AsString     := '';
     cdsValoresCalc.fieldByName('ANT_DTAVEN').AsDateTime   := VS_Date;
     cdsValoresCalc.fieldByName('ANT_DIACAL').AsInteger    := 0;
     cdsValoresCalc.fieldByName('ANT_TXJURD').AsFloat      := 0.00;
     cdsValoresCalc.post;

     fltValCalc := fltValCalc + fStrToFloat(edtDinheiro.Text);
  End;

  // Cheque a Vista
  If (Not fEmptyStr(edtPorBaiChV.text)) And ( (fStrToFloat(edtChqVista.Text) <> 0.0) and (Not fEmptyStr(edtChqVista.Text)) )
  And (Not cdsChqVis.IsEmpty) Then
  Begin

     cdsChqVis.first;
     While Not cdsChqVis.Eof Do
     Begin
       cdsValoresCalc.append;
       cdsValoresCalc.fieldByName('ANT_ESPORI').AsString     := 'Cheque á Vista';
       cdsValoresCalc.fieldByName('ANT_VLRORI').AsFloat      := cdsChqVis.FieldByName('CHQ_VALCHQ').AsFloat;
       cdsValoresCalc.fieldByName('ANT_VLRCAL').AsFloat      := cdsChqVis.FieldByName('CHQ_VALCHQ').AsFloat;
       cdsValoresCalc.fieldByName('ANT_PRCDSC').AsFloat      := 0.00;
       cdsValoresCalc.fieldByName('ANT_VLRDSC').AsFloat      := 0.00;
       cdsValoresCalc.fieldByName('ANT_NROCHQ').AsString     := cdsChqVis.FieldByName('CHQ_NUMCHQ').AsString;
       cdsValoresCalc.fieldByName('ANT_NOMCAR').AsString     := '';
       cdsValoresCalc.fieldByName('ANT_DTAVEN').AsDatetime   := cdsChqVis.FieldByName('CHQ_DTAVEN').AsDateTime;
       cdsValoresCalc.fieldByName('ANT_DIACAL').AsInteger    := 0;
       cdsValoresCalc.fieldByName('ANT_TXJURD').AsFloat      := 0.00;
       cdsValoresCalc.post;

       fltValCalc := fltValCalc + cdsChqVis.FieldByName('CHQ_VALCHQ').AsFloat;

       cdsChqVis.next;
     End;

  End;

  // Cheque a pre
  If (Not fEmptyStr(edtPorBaiChP.text)) And ( (fStrToFloat(edtChqPre.Text) <> 0.0) and (Not fEmptyStr(edtChqPre.Text)) )
  And (Not cdsChqPre.IsEmpty) Then
  Begin

     cdsChqPre.first;
     While Not cdsChqPre.Eof Do
     Begin
       cdsValoresCalc.append;
       cdsValoresCalc.fieldByName('ANT_ESPORI').AsString     := 'Cheque Pré';
       cdsValoresCalc.fieldByName('ANT_VLRORI').AsFloat      := cdsChqPre.FieldByName('CHQ_VALCHQ').AsFloat;
       cdsValoresCalc.fieldByName('ANT_VLRCAL').AsFloat      := cdsChqPre.FieldByName('CHQ_VALCHQ').AsFloat;
       cdsValoresCalc.fieldByName('ANT_PRCDSC').AsFloat      := 0.00;
       cdsValoresCalc.fieldByName('ANT_VLRDSC').AsFloat      := 0.00;
       cdsValoresCalc.fieldByName('ANT_NROCHQ').AsString     := cdsChqPre.FieldByName('CHQ_NUMCHQ').AsString;
       cdsValoresCalc.fieldByName('ANT_NOMCAR').AsString     := '';
       cdsValoresCalc.fieldByName('ANT_DTAVEN').AsDateTime   := cdsChqPre.FieldByName('CHQ_DTAVEN').AsDateTime;
       cdsValoresCalc.fieldByName('ANT_DIACAL').AsInteger    := 0;
       cdsValoresCalc.fieldByName('ANT_TXJURD').AsFloat      := 0.00;
       cdsValoresCalc.post;

       fltValCalc := fltValCalc + cdsChqPre.FieldByName('CHQ_VALCHQ').AsFloat;

       cdsChqPre.next;
     End;

  End;

  // Cartões
  If (Not fEmptyStr(edtPorCart.text)) And ( (fStrToFloat(edtCartao.Text) <> 0.0) and (Not fEmptyStr(edtCartao.Text)) )
  And (Length(arrCartoes) > 0) Then
  Begin

        For intC := 0 To Length(arrCartoes) -1 Do
        Begin
          LTipoParcelamento := '';

          {$IFNDEF LINUX}
            LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intC].strCodCar]);

            If (arrCartoes[intC].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
              objArredParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intC].strCodCar)
            Else
              objArredParcela := fArredondamentoParcelas(arrCartoes[intC].strCodCar);
          {$ELSE}
            objArredParcela := fArredondamentoParcelas(arrCartoes[intC].strCodCar);
          {$ENDIF LINUX}
          LDataBaseCartao := RetornaDataBaseCartao(VS_Date, arrCartoes[intC].dtaDtaTra);

          fDigDuplicVar(arrCartoes[intC].strCndPag, 0, arrCartoes[intC].fltValDig, False, False, False, LDataBaseCartao, False, arrDuplicata, 0, 'N', False, False, 0, objArredParcela);

          intC2 := 0;
          //pgbProgresso.Position := 0;
          //pgbProgresso.Properties.Max := Length(arrDuplicata);
          While (intC2 < Length(arrDuplicata)) Do
          Begin

            // strCndPagCar
            cdsValoresCalc.append;
            cdsValoresCalc.fieldByName('ANT_ESPORI').AsString     := 'Cartão';
            cdsValoresCalc.fieldByName('ANT_VLRORI').AsFloat      := arrDuplicata[intC2].curValor;
            cdsValoresCalc.fieldByName('ANT_VLRCAL').AsFloat      := arrDuplicata[intC2].curValor;//arrCartoes[intC].fltValDig;
            cdsValoresCalc.fieldByName('ANT_PRCDSC').AsFloat      := 0.00;
            cdsValoresCalc.fieldByName('ANT_VLRDSC').AsFloat      := 0.00;
            cdsValoresCalc.fieldByName('ANT_NROCHQ').AsString     := '';
            cdsValoresCalc.fieldByName('ANT_NOMCAR').AsString     := arrCartoes[intC].strDesCar;
            cdsValoresCalc.fieldByName('ANT_DTAVEN').AsDatetime   := StrToDatetime(arrDuplicata[intC2].dtaDtaVen);//arrCartoes[intC].dtaDtaCad;
            cdsValoresCalc.fieldByName('ANT_DIACAL').AsInteger    := 0;
            cdsValoresCalc.fieldByName('ANT_TXJURD').AsFloat      := 0.00;
            cdsValoresCalc.post;

            fltValCalc := fltValCalc + cdsValoresCalc.fieldByName('ANT_VLRCAL').AsFloat;

            inc(intC2);

          End;
        End;
  End;
  cdsValoresCalc.EnableControls;

  if (cdsValoresCalc.RecordCount > 0) then
      pCalculaJurosAntecipacao()
  Else
  Begin
      edtValCalc.Text        := FloatToStrF(fltValCalc,ffFixed,12,2);
      edtValTotDesconto.Text := FloatToStrF(fltValTotDes,ffFixed,12,2);
  End;
End;

Procedure TfrmCtrAntecipacaoRecebiveis.pCalculaJurosAntecipacao();
 Var
    intT : Integer;

    intMediaDiasPgto,
    intDifDias : Double;
    intDiasCalc : Double;
    dtaDataBaseJuros : TDate;
    flTaxaJurosDiario : Double;
    flPercJurosMes,
    flPercJuroscalc : Double;
    flVlrJurosCalc,
    flVlrCalculadoCheque : Double;
Begin

   fltValCal         := 0;
   fltValTotDes      := 0;
   intDifDias        := 0;
   dtaDataBaseJuros  := Date;
   flPercJurosMes    := fCfgSis('PRCATR', varDouble);;

   For intT := 0 To Length(arrRegDup) -1 Do
   Begin
      intDifDias := intDifDias + (StrToDateDef(arrRegDup[intT].strDtaVen,0) - StrToDateDef(mskDtaPagto.Text,0));
   End;

   //acha a media da soma da qtde de dias antecipados
   // ex dia pgto                : 15/07/2020
   //    dia vencto da duplicata : 14/07/2020  ->> diferenca de 1 dia, soma todos as diferencas e acha a media
   // dia do vencto - dia pagto. = 1
   intMediaDiasPgto := Round(intDifDias / Length(arrRegDup));

   // Database de juros será a data de hoje + a media de dias encontrada acima
   dtaDataBaseJuros := dtaDataBaseJuros + intMediaDiasPgto;

   // juros diario sera a taxa de juros mes / 30
   // ex 3,5% / 30 = 0,1166666667 -> (0,1167)
   flTaxaJurosDiario := fArredondaABNT_NBR5891_77( (flPercJurosMes / 30), 4);

   //******************* Aplica o calculo no grid************************//

   If Not cdsValoresCalc.IsEmpty then
   Begin

     cdsValoresCalc.DisableControls;
     cdsValoresCalc.First;
     While Not cdsValoresCalc.Eof do
     Begin

        // dias para calculo dos juros de antecipação do cheque;
        // sempre será a (Data de Vencto. do cheque - Data base de juros)
        intDiasCalc := cdsValoresCalc.FieldByName('ANT_DTAVEN').AsDateTime - dtaDataBaseJuros;

        // Juros diario *  a qtde diaa para calculo de juros
        flPercJurosCalc := (flTaxaJurosDiario * intDiasCalc) / 100;

        // valor dos juros vai ser o valor do cheque * (qtde dias para calculo de juros * %juros diarios)
        // se for negativo nao esta aplicando
        if (flPercJurosCalc > 0.00) then
           flVlrJurosCalc := cdsValoresCalc.FieldByName('ANT_VLRORI').AsFloat * flPercJurosCalc
        else
           flVlrJurosCalc := 0.00;

        // Valor Caluclado do cheque = Valor do cheque - Valor dos Juros;
        flVlrCalculadoCheque := cdsValoresCalc.FieldByName('ANT_VLRORI').AsFloat - flVlrJurosCalc;

        cdsValoresCalc.edit;
        cdsValoresCalc.FieldByName('ANT_TXJURD').AsFloat   := flTaxaJurosDiario;    // TAXA DE JUROS DIARIA
        cdsValoresCalc.FieldByName('ANT_DIACAL').AsInteger := round(intDiasCalc);          // DIAS PARA CALCULO DE JUROS
        cdsValoresCalc.FieldByName('ANT_VLRDSC').AsFloat   := flVlrJurosCalc;       // VALOR DOS JUROS CALCULADOS
        cdsValoresCalc.FieldByName('ANT_PRCDSC').AsFloat   := flPercJurosCalc;      // PERCENTUAL DE JUROS APLICADO
        cdsValoresCalc.FieldByName('ANT_VLRCAL').AsFloat   := flVlrCalculadoCheque; // NOVO VALOR DA ESPECIE (DESCONTO APLICADO)
        cdsValoresCalc.Post;

        fltValTotDes := fltValTotDes + flVlrJurosCalc;

        fltValCal    := fltValCal + flVlrCalculadoCheque;

        cdsValoresCalc.Next;

     End;
     cdsValoresCalc.EnableControls;

   End;

   mskdtaBase.Text        := DateTimeToStr(dtaDataBaseJuros);
   edtValCalc.Text        := FloatToStrF(fltValCal,ffFixed,12,2);
   edtValTotDesconto.Text := FloatToStrF(fltValTotDes,ffFixed,12,2);

End;

Function TfrmCtrAntecipacaoRecebiveis.fMontaHistoricoAntecipacao() : String;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    objLiberacao : TLiberacao;
Begin
   Result := '';
{   strHis := '';

   cdsValoresCalc.DisableControls;
   cdsValoresCalc.First;
   While Not cdsValoresCalc.Eof do
   Begin

     If ( UpperCase(copy(cdsValoresCalc.FieldByName('ANT_ESPORI').AsString,1,6)) = 'CHEQUE') then
     Begin
        strHis := strHis + #13 +
                           cdsValoresCalc.FieldbyName('ANT_ESPORI').AsString                                               + ' - ' +
                           'Número: '     + cdsValoresCalc.FieldbyName('ANT_NROCHQ').AsString                              + ' - ' +
                           'Dt. Vcto: '   + cdsValoresCalc.FieldbyName('ANT_DTAVEN').AsString                              + ' - ' +
                           'Tx. diária: ' + FloatToStrF( cdsValoresCalc.FieldbyName('ANT_TXJURD').AsFloat, ffFixed, 12,4 ) + ' - ' +
                           'Qt. dias: '   + cdsValoresCalc.FieldbyName('ANT_DIACAL').AsString                              + ' - ' +
                           '%Desc: '      + FloatToStrF( cdsValoresCalc.FieldbyName('ANT_PRCDSC').AsFloat, ffFixed, 12,4 ) + ' - ' +
                           'Vl. Orig.: '  + FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRORI').AsFloat, ffFixed, 12,2 ) + ' - ' +
                           'Vl. Desc.: '  + FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRDSC').AsFloat, ffFixed, 12,2 ) + ' - ' +
                           'Vl. Calc.: '  + FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRCAL').AsFloat, ffFixed, 12,2 ) + #13;
     End;

     cdsValoresCalc.Next;
   End;
   cdsValoresCalc.EnableControls;

   result := strHis;

   **********   }

  Try
    objLiberacao := TLiberacao.Create;
    objLiberacao.Clear;
    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;

    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'ESPECIE'    , 7 , alEsquerda  , teAutcom);
    objLinha.pAddColuna(''  , 'NUMERO'     , 8 , alCentro    , teAutcom);
    //objLinha.pAddColuna(''  , 'DT.VENCTO'  , 10 , alCentro    , teAutcom);
    objLinha.pAddColuna(''  , 'TX.DIA'     , 8 , alDireita   , teAutcom);
    objLinha.pAddColuna(''  , 'DIAS'       , 4 , alCentro    , teAutcom);
    objLinha.pAddColuna(''  , '%DESC'      , 6 , alDireita   , teAutcom);
    objLinha.pAddColuna(''  , 'VL.ORIG'    , 10 , alDireita   , teAutcom);
    objLinha.pAddColuna(''  , 'VL.DESC'    , 9 , alDireita   , teAutcom);
    objLinha.pAddColuna(''  , 'VL.CALC'    , 10 , alDireita   , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    cdsValoresCalc.DisableControls;
    cdsValoresCalc.First;
    While Not cdsValoresCalc.Eof do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna(' ESPECIE'  ,cdsValoresCalc.FieldbyName('ANT_ESPORI').AsString , 7 , alEsquerda );
      objLinha.pAddColuna(' NUMERO'   ,cdsValoresCalc.FieldbyName('ANT_NROCHQ').AsString , 8 , alCentro );
      //objLinha.pAddColuna(' DT.VENCTO',cdsValoresCalc.FieldbyName('ANT_DTAVEN').AsString , 10 , alCentro );
      objLinha.pAddColuna(' TX.DIA'   ,FloatToStrF( cdsValoresCalc.FieldbyName('ANT_TXJURD').AsFloat, ffFixed, 12,4 ) , 8 , alDireita );
      objLinha.pAddColuna(' DIAS'  ,cdsValoresCalc.FieldbyName('ANT_DIACAL').AsString , 4 , alCentro );
      objLinha.pAddColuna(' %DESC'    ,FloatToStrF( cdsValoresCalc.FieldbyName('ANT_PRCDSC').AsFloat, ffFixed, 12,4 ) ,  6 , alDireita );
      objLinha.pAddColuna(' VL.ORIG'  ,FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRORI').AsFloat, ffFixed, 12,2 ) , 10 , alDireita );
      objLinha.pAddColuna(' VL.DESC'  ,FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRDSC').AsFloat, ffFixed, 12,2 ) , 9 , alDireita );
      objLinha.pAddColuna(' VL.CALC'  ,FloatToStrF( cdsValoresCalc.FieldbyName('ANT_VLRCAL').AsFloat, ffFixed, 12,2 ) , 10 , alDireita );
      objTabela.lstLinhas.Add(objLinha);

      cdsValoresCalc.Next;
    End;
    cdsValoresCalc.EnableControls;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    Result := #13#10 + objLiberacao.objMsgLibera.fGetMensagem;

  Finally
    FreeAndNil(objLiberacao);
  End


End;

procedure TfrmCtrAntecipacaoRecebiveis.btnAltValChqEmiClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Alterar registros de cheques emitidos?', ['&Sim','&Não'], 2) = 1 Then
  Begin
    edtChqVista.ReadOnly := False;
    pSetFocus(edtChqVista);
  End;
end;

procedure TfrmCtrAntecipacaoRecebiveis.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  {if (fStrToFloat(edtValDig.Text) < fStrToFloat(edtValorCorrigido.Text)) then
  begin
    fMensagem('ATENÇÃO!', 'O valor digitado não pode ser menor que o valor Informado para pagamento!', ['&OK']);
    Exit;
  end;  }

  if (fEmptyStr(edtValDig.text)) or (fStrToFloat(edtValDig.Text) = 0.0) then
  begin
    fMensagem('ATENÇÃO!', 'Verifique os valores informados!', ['&OK']);
    Exit;
  end;

  if (fEmptyStr(edtValCalc.text)) or (fStrToFloat(edtValCalc.Text) = 0.0) then
  begin
    fMensagem('ATENÇÃO!', 'O crédito não pode ser gerado com valor zerado !', ['&OK']);
    Exit;
  end;

  If fEmptyStr(edtPorAntec.Text) Then
  Begin
     fMensagem('ATENÇÃO!', 'O portador de antecipação deve ser preenchido!', ['&O k']);
     psetFocus(edtPorAntec);
     exit;
  End;

  If fEmptyStr(edtCodVen.text) And fEmptyStr(edtNomVen.text) Then
  Begin
     fMensagem('ATENÇÃO!', 'O vendedor deve ser preenchido!', ['&O k']);
     psetFocus(edtCodVen);
     Exit;
  End;

  If fMensagem('', 'Confirma a antecipação de recebíveis informada ?', ['&Sim','&Não']) = 1 Then
  Begin
     TfrmGravando.fExecutarModalA(pGravaAntecipacaoValores, 'Aguarde, Realizando antecipação dos valores informados...', '');
     Close;
  End;

end;

procedure TfrmCtrAntecipacaoRecebiveis.btnCalculoClick(Sender: TObject);
begin
   inherited;

  fMensagem('Cálculo Antecipação de Recebíveis', 'Cálculo sobre valor sem juros das duplicatas' + #13#10 +
                                                 '1-Data Base (Data Hoje + Média de dias antecipação).' + #13#10 +
                                                 '2-% Diário de juros ( % Configurado/30 ).' + #13#10 +
                                                 '3-Qtde. dias antecipação (Data Vencimento - Data Base).' + #13#10 +
                                                 '4-Valor Recebível - (Qtde. dias antecipação * % diário de juros).', ['&Ok'],
                                                 1, False, 2);

end;

procedure TfrmCtrAntecipacaoRecebiveis.btnSairClick(Sender: TObject);
begin

  If (fStrToFloat(edtValDig.Text) > 0.00) Then
  Begin
     If fMensagem('', 'Existem valores informados, deseja realmente sair ?', ['&Sim', '&Não']) = 1 Then
        Close;
  End
  Else
     Close;

end;

procedure TfrmCtrAntecipacaoRecebiveis.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqOperador(Self, edtCodVen, edtNomVen, qryConOpe, Key, arrSel, True, True);
end;

procedure TfrmCtrAntecipacaoRecebiveis.edtPorBaiChVKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqPortador(conSimples, Self, edtPorBaiChV, edtDesPorChV, qryConPor, Key, arrSel);
end;

procedure TfrmCtrAntecipacaoRecebiveis.edtPorBaiDinKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqPortador(conSimples, Self, edtPorBaiDin, edtDesPorBaiDin, qryConPor, Key, arrSel);
end;

procedure TfrmCtrAntecipacaoRecebiveis.edtPorCartKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqPortador(conSimples, Self, edtPorCart, edtDesPorCart, qryConPor, Key, arrSel);
end;

procedure TfrmCtrAntecipacaoRecebiveis.edtPorAntecKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqPortador(conSimples, Self, edtPorAntec, edtDesPorAntec, qryConPor, Key, arrSel);
end;

procedure TfrmCtrAntecipacaoRecebiveis.edtPorBaiChPKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
     fPesqPortador(conSimples, Self, edtPorBaiChP, edtDesPorChP, qryConPor, Key, arrSel);
end;

procedure TfrmCtrAntecipacaoRecebiveis.FormActivate(Sender: TObject);
begin
  inherited;

  edtDinheiro.Enabled := False;
  edtChqVista.Enabled := False;
  edtChqPre.Enabled   := False;
  edtCartao.Enabled   := False;

  If edtPorBaiDin.CanFocus Then
     pSetFocus(edtPorBaiDin)
  Else
     pSetFocus(edtDinheiro);

end;

procedure TfrmCtrAntecipacaoRecebiveis.FormCreate(Sender: TObject);
begin
  inherited;

  strCodOpe   := strLoginUsuarioLogado;
  blnCtaRec   := False;
  blnTroChq   := False;
  blnTroCar   := False;
  blnVeiodeCH := False;
  blnGravou   := False;

  cdsCtaRecDups := TUniClientDataSet.Create(Self);

  qryConPor   := fCriaQuery(Self);
  qryConOpe   := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);


  cdsChqPre := fCriaCdsCheques(Self);
  cdsChqVis := fCriaCdsCheques(Self);

  cdsValoresCalc := fCriacdsValoresCalc();
  qryValoresCalc := fCriaQuery(Self);

  dtSourceValoresCalc := TUniDataSource.Create(Self);
  dtSourceValoresCalc.dataset := cdsValoresCalc;
  cxvGridParcelas.DataController.DataSource := dtSourceValoresCalc;


  blnDescontoAteVencimento := fCfgSis('UTDEFN') = '2';
  intDigitChq              := -1;
  blnEfetuandoRateio       := False;

  edtValdig.Text         := '0,00';
  edtValCalc.Text        := '0,00';
  edtValTotDesconto.Text := '0,00';

  (cdsValoresCalc.FieldByName('ANT_VLRORI') As TFloatField).DisplayFormat := ',0.00';
  (cdsValoresCalc.FieldByName('ANT_VLRCAL') As TFloatField).DisplayFormat := ',0.00';
  (cdsValoresCalc.FieldByName('ANT_VLRDSC') As TFloatField).DisplayFormat := ',0.00';
  (cdsValoresCalc.FieldByName('ANT_PRCDSC') As TFloatField).DisplayFormat := ',0.0000';

end;

procedure TfrmCtrAntecipacaoRecebiveis.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : Begin
                 btnConfirma.Click;
                 Key := 0;
               End;

    VK_DELETE: If cxGridParcelas.Focused Then
                 Key := 0;

    VK_ESCAPE: btnSair.Click;
  end;
end;

procedure TfrmCtrAntecipacaoRecebiveis.FormShow(Sender: TObject);
begin
  inherited;

  edtValorCorrigido.Text := FormatFloat('#,##0.00', flTotalDups);
  mskDtaPagto.text := DateToStr( fRetornaDataPagamento() );
  blnConfirma      := False;
  pnlDados.Enabled := True;
  edtDinheiro.Text := '0,00';
  edtChqVista.Text := '0,00';
  edtChqPre.Text   := '0,00';
  edtCartao.Text   := '0,00';

  pPreencheArrayDuplicatas;

  pCalculaJurosAntecipacao();

end;

function TfrmCtrAntecipacaoRecebiveis.fRetornaDataPagamento(): TDate;
  Var
    cdsGen: TUniClientDataSet;
begin

  cdsGen := TUniClientDataSet.Create(Self);
  Result := 0;

  With cdsGen Do
  Begin

    Data     := cdsCtaRecDups.Data;
    Filtered := False;
    Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;

    if Not IsEmpty then
       Result := FieldByName('CTR_DTAPAG').AsDateTime;

  End;
  FreeAndNil(cdsGen);

end;

function TfrmCtrAntecipacaoRecebiveis.fCriaClientCtaRec(strFiltro: String = ''): TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);
  With Result Do
  Begin
    Data := cdsCtaRecDups.Data;
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter := strFiltro;
      Filtered := True;
    End;
  End;
End;

Procedure TfrmCtrAntecipacaoRecebiveis.pGravaAntecipacaoValores();
Begin

   blnGravou := fGravaOperacoes( Date, StrToDate(mskDtaPagto.Text), '' );

   If blnGravou Then
   Begin
      pMensagemOk('Antecipação de recebiveis concluída!' + #13+#10  +
                  'Agrupamento nº: '+ strNumAgr   + '  ' + #13+#10 +
                  'Crédito nº: '    + strCCGerado + '  ' + #13+#10 +
                  'Gerados com sucesso !');

      pLimpaTela();
   End;

End;

Procedure TfrmCtrAntecipacaoRecebiveis.pLimpaTela();
Begin

  edtporBaidin.clear;
  edtdesPorBaiDin.Clear;
  edtdinheiro.clear;

  edtporBaiChV.clear;
  edtdesPorChV.Clear;
  edtChqVista.clear;

  edtporBaiChP.clear;
  edtdesPorChP.Clear;
  edtChqPre.clear;

  edtPorCart.clear;
  edtdesPorCart.Clear;
  edtCartao.Clear;

  edtporAntec.Clear;
  edtDesPorAntec.Clear;
  edtCodven.Clear;
  edtnomVen.Clear;

  cdsValoresCalc.EmptyDataSet;

  edtValdig.Clear;
  edtValcalc.Clear;

  edtValorCorrigido.Clear;
  MskDtaPagto.Clear;

End;

function TfrmCtrAntecipacaoRecebiveis.fGravaOperacoes( dtaDtaAgr, dtaDtaVenc: TDateTime; strConPag: String): Boolean;
  Var
    intTamAnt    : Integer;
    blnConfirma  : Boolean;
    fltTotAgr,
    fltTotIPI,
    fltTotRet,
    fltTotAce,
    fltTotFre    : Double;

    strDupAgr    : String;
    strSeqLan    : String;

    strCodVenAnt : String;
    strCodPorAnt : String;
    strCodPorDin : String;
    strCodPorCar : String;
    strCodPorChV : String;
    strCodPorChP : String;

    fltValCom    : Double;
    fltValDes    : Double;
    strHistorico : String;
    strCodCli    : String;
    strCodEmp    : String;
    strCodCta    : String;
    strHisCar    : String;
    intContador  : Integer;
    intContCopia : Integer;
    intContador2 : Integer;
    intQtdDup    : Integer;

    cdsGenCtr    : TUniClientDataSet;

    dagAgrup            : TDadosAgrup;
    objArredondaParcela : IArredondaParcela;

    arrDuplicCarIpi,
    arrDuplicCarRet,
    arrDuplicCarAce,
    arrDuplicCarFre,
    arrDuplicCarCbs,
    arrDuplicCarIbs,
    arrDuplicCar_Is,
    arrDuplicFat,
    arrDuplicata     : TArrDigDuplicArray;

    arrDupSel        : Array Of TDuplicataCtr;

    strAutInc_Antec  : String;
    LTipoParcelamento: String;
Begin

    blnUsaTelaCnd := False;
    Screen.Cursor := crHourGlass;

    {******************************}
    {* RETORNA O CLIENTE, EMPRESA *}
    {***************************AC*}
    strCodCli := fRetornaCliente;
    strCodEmp := fRetornaEmpresa;

    strNumAgr := fSeqAgrupamentoCtr;

    strCodVenAnt := edtCodVen.Text;
    strCodPorAnt := edtPorAntec.Text;
    strCodPorDin := edtPorBaiDin.Text;
    strCodPorCar := edtPorCart.Text;
    strCodPorChV := edtPorBaiChV.Text;
    strCodPorChP := edtPorBaiChP.Text;

    intQtdDup      := 0;
    strHisCar      := '';
    strDocume      := '';
    strDupsGeradas := '';

    {***************************************************}
    {* CRIANDO UM CLIENTDATASET COM OS DADOS DO PADRAO *}
    {* DO FORM PARA CONCLUIR O AGRUPAMENTO DE DUPLIC   *}
    {************************************************AN*}
    cdsGenCtr := fCriaClientCtaRec('CTR_MARDES = ''M'' AND CTR_CODCLI = ' + QuotedStr(strCodCli));

    Try

      cdsGenCtr.DisableControls;

      {*************************************************}
      {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
      {*********************************************JC**}
      intSeqCon := 0; //Esta sendo passado '0' pq nao existe nada pagono momento; //StrToInt(fRetRcxCon);

      {*************************************************}
      {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
      {*********************************************JC**}
      fRetSequencialMovCar('MOVCAR', VS_strCodEmp, arrCartoes);

      {*****************************************}
      {* INICIA A TRANSAÇÃO                    *}
      {**************************************MV*}
      fStartTransaction;

      cdsGenCtr.First;
      While Not cdsGenCtr.Eof Do
      Begin
        {**********************************************}
        {* SALVA AS DUPLICATAS QUE SERÃO ATUALIZADAS  *}
        {*******************************************MV*}
        intTamAnt := Length(arrDupSel);
        SetLength(arrDupSel, intTamAnt+1);

        arrDupSel[intTamAnt].strNumDup := cdsGenCtr.FieldByName('NRODUP').AsString;
        arrDupSel[intTamAnt].strParcel := cdsGenCtr.FieldByName('PARDUP').AsString;
        arrDupSel[intTamAnt].strEspDoc := cdsGenCtr.FieldByName('CTR_ESPDOC').AsString;
        arrDupSel[intTamAnt].strCodEmp := cdsGenCtr.FieldByName('CTR_CODEMP').AsString;
        arrDupSel[intTamAnt].strCodCli := cdsGenCtr.FieldByName('CTR_CODCLI').AsString;
        arrDupSel[intTamAnt].strAutoIn := fRetornaAutoIncrem(cdsGenCtr.FieldByName('NRODUP'    ).AsString,
                                                             cdsGenCtr.FieldByName('PARDUP'    ).AsString,
                                                             cdsGenCtr.FieldByName('CTR_ESPDOC').AsString,
                                                             cdsGenCtr.FieldByName('CTR_CODEMP').AsString,
                                                             cdsGenCtr.FieldByName('CTR_CODCLI').AsString);

        {*****************************************}
        {* NUMERO DAS DUPLICATAS AGRUPADAS       *}
        {**************************************RV*}
        If (cdsGenCtr.RecNo = 1) Then
          strDupAgr := cdsGenCtr.FieldByName('CTR_NUMDUP').AsString
        Else
          strDupAgr := strDupAgr + '/' + cdsGenCtr.FieldByName('CTR_NUMDUP').AsString;

        Application.ProcessMessages;
        cdsGenCtr.Next;
      End;

      //blnConfirma := True;

      {****************************************************}
      {* GRAVA AS DUPLICATAS AGRUPADAS NESTA ROTINA SERA  *}
      {* GRAVADO SEMPRE APENAS 1 REGISTRO                 *}
      {*************************************************MV*}
      intContador  := 0;

      strHistorico := 'REF. AGRUPAMENTO Nro. ' + strNumAgr+ ' ANTEC. DE RECEBÍVEIS - PARC. ' + IntToStr(intContador+1) + ' / ' +
                                                 '1' + ' - DOC(S): ' + strDupAgr;
      strHistorico := strHistorico + fMontaHistoricoAntecipacao();

      strCodCnd    := '';
      strCodCta    := fCfgSis('CTRPAR');  // Codigo do Plano de Contas

      blnConfirma := fGravaCadRec(Self.Name,
                                  'INCLUSÃO',
                                  strNumAgr,
                                  'A',                   //[intContador].strSequen,
                                  0,
                                  'AG',
                                  cdsGenCtr.FieldByName('CTR_CODCLI').AsString,
                                  strCodEmp,
                                  strCodVenAnt,
                                  strLoginUsuarioLogado, //FieldByName('CTR_CODDIG').AsString,
                                  strCodPorAnt,
                                  dtaDtaAgr,
                                  dtaDtaVenc,
                                  fStrToFloat(edtValorCorrigido.text),
                                  fStrToFloat(edtValorCorrigido.text),
                                  0,
                                  'N',
                                  strHistorico,
                                  '',
                                  '',
                                  '',
                                  '',
                                  '',
                                  0.0,
                                  0,
                                  '', //FieldByName('CTR_ADTCLI').AsString,
                                  '', //FieldByName('CTR_CODEVE').AsString,
                                  '', //FieldByName('CTR_CODVEL').AsString,
                                  '',
                                  strCodCnd, //IIF(blnUsaTelaCnd, strCodCnd, FieldByName('CTR_CODCND').AsString),
                                  False,
                                  strCodCta, //FieldByName('CTR_CODCTA').AsString,
                                  0,
                                  0, //fStrToFloat(edtValorCorrigido.text),
                                  dagAgrup.strObsAg1,
                                  dagAgrup.strObsAg2,
                                  dagAgrup.strObsAg3,
                                  '', //FieldByName('CTR_CTASER').AsString,
                                  0,  //FieldByName('CTR_SERVAL').AsFloat,
                                  0,  //intResCai
                                  0,  //fltVlrCom
                                  0,  //fltFatCom
                                  '', //strEmpBai
                                  '', // Empresa de Origem
                                  '', //strDocDiv
                                  '', //strEspDiv
                                  '', //strEmpDiv
                                  '', //strCliDiv
                                  0,  //fltVlrRep
                                  0,  //fltFatRep
                                  '', //*************//FieldByName('CTR_CODREP').AsString,
                                  0,
                                  0,  //arrDuplicRet[intContador].curValor,
                                  'N',
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  '', //strCodigoBarrasContrato,
                                  0.00, //fltPerDpo
                                  0,
                                  0,
                                  '',
                                  0,  //arrDuplicAce[intContador].curValor,
                                  0); //arrDuplicFre[intContador].curValor);


      If (Not blnConfirma) Then
      Begin
         fRollback;
      End
      Else
      Begin

         blnConfirma := fGravaDupsGeradas(strNumAgr,'A','AG',strCodEmp, cdsGenCtr.FieldByName('CTR_CODCLI').AsString);

         {********************************************************************}
         {*** GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AO AGRUPAMENTO ***}
         {*** GERADO PELA ANTECIPAÇÃO DOS RECEBIVEIS                       ***}
         {********************************************************************}
         if blnConfirma then
            blnConfirma := (fGravaRelacionaisAntecRecebiveis( strNumAgr, 'A', '', strCodCli, strCodEmp, '',
                                                             'AG',fStrToFloat(edtValorCorrigido.text), strCodCta, edtPorAntec.Text ) <> '');

      End;

      //************************************************************************/
      // CARREGA O CDS COM OS DADOS DO CONTAS A RECEBER PARA GRAVAR O DUPAGR;
      //************************************************************************/
      cdsCtaRecDados := TUniClientDataSet.Create(Self);
      pCriaTemporaria(arrDupSel);

      If blnConfirma Then
      Begin
         {*****************************************}
         {* DELETA AS DUPLICATAS ORIGINAIS        *}
         {**************************************MV*}
         blnConfirma := fDeletaDuplicatas(arrDupSel);
      End;

      {*******************************************}
      {* WHILE PARA GRAVACAO DO DUPAGR           *}
      {****************************************AF*}
      If blnConfirma Then
      Begin

        {************************************************}
        {* RETORNA VALOR TOTAL DAS DUPLICATAS AGRUPADAS *}
        {*********************************************AC*}
        pRetornaTotal(strCodCli, strCodEmp, fltTotAgr, fltTotIPI, fltTotRet, fltTotAce, fltTotFre);

        cdsCtaRecDados.First;
        While Not cdsCtaRecDados.Eof Do
        Begin
          {*****************************************}
          {* GRAVA A TABELA DUPAGR                 *}
          {**************************************MV*}
          Inc(intQtdDup);

          {***********************************************************}
          {* SE EU ESTIVER AGRUPANDO UMA PARCELA QUE JÁ TEVE BAIXA   *}
          {* CALCULO O CTR_VALCOM DO AGRUPAMENTO DESCONTANDO O VALOR *}
          {* JÁ PAGO DE COMISSÃO QUE ESTARÁ NA DUPLICATA CUJO        *}
          {* CTR_SEQBAI É 1                                          *}
          {********************************************************VA*}
          fltValCom := cdsCtaRecDados.FieldByName('CTR_VALCOM').AsFloat;
          If (cdsCtaRecDados.FieldByName('CTR_BAIXAS').AsInteger > 0) Then
            fltValCom := (cdsCtaRecDados.FieldByName('CTR_VALCOM_SEQBAI_01').AsFloat)
                       - (cdsCtaRecDados.FieldByName('CTR_TOTAL_RECEB').AsFloat * cdsCtaRecDados.FieldByName('CTR_FATCOM_SEQBAI_01').AsFloat);

          If blnDescontoAteVencimento Then
          Begin
             If cdsCtaRecDados.FieldByName('CTR_DTAVEN').AsDateTime >= VS_Date Then
                fltValDes := cdsCtaRecDados.FieldByName('CTR_DESSUJ').AsFloat
             Else
                fltValDes := 0;
          End
          Else
             fltValDes := cdsCtaRecDados.FieldByName('CTR_DESSUJ').AsFloat;

          strHisCar := strHisCar + cdsCtaRecDados.FieldByName('NRODUP').AsString +
                                   cdsCtaRecDados.FieldByName('PARDUP').AsString + '-' +
                                   cdsCtaRecDados.FieldByName('CTR_ESPDOC').AsString + '-' +
                                   cdsCtaRecDados.FieldByName('CTR_CODEMP').AsString + '/';

          strDocume := cdsCtaRecDados.FieldByName('NRODUP'    ).AsString + '-' +
                       cdsCtaRecDados.FieldByName('PARDUP'    ).AsString + '-' +
                       cdsCtaRecDados.FieldByName('CTR_ESPDOC').AsString + '-' +
                       cdsCtaRecDados.FieldByName('CTR_CODEMP').AsString + '-' +
                       fStrZero(cdsCtaRecDados.FieldByName('CTR_SEQBAI').AsInteger,3);

          blnConfirma := fGravaDupAgr(strNumAgr,
                                      cdsCtaRecDados.FieldByName('NRODUP').AsString,
                                      cdsCtaRecDados.FieldbyName('PARDUP').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_SEQBAI').AsInteger,
                                      cdsCtaRecDados.FieldByName('CTR_ESPDOC').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODCLI').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODEMP').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODPOR').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODVEN').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODDIG').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_DTACAD').AsDateTime,
                                      cdsCtaRecDados.FieldByName('CTR_DTAVEN').AsDateTime,
                                      cdsCtaRecDados.FieldByName('CTR_VALDUP').AsFloat - cdsCtaRecDados.FieldByName('CTR_JURSUJ').AsFloat - cdsCtaRecDados.FieldByName('CTR_DESCOB').AsFloat + fltValDes,
                                      cdsCtaRecDados.FieldByName('CTR_VALORI').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_DESCOB').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_DESCON').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_HIST01').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_HIST02').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_ADTCLI').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODEVE').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODVEL').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_TIPFOR').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CODCND').AsString,
                                      IIF(cdsCtaRecDados.FieldByName('CTR_CONAPR').AsInteger = 1, True, False),
                                      strCodEmp,
                                      cdsCtaRecDados.FieldByName('CTR_CODCTA').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_EMP_PD').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_SEQCON').AsInteger,
                                      cdsCtaRecDados.FieldByName('CTR_DIFORI').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_VALANT').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_GRVORI').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_CTASER').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_SERVAL').AsFloat,
                                      fltValCom,
                                      fltValCom/fltTotAgr,
                                      cdsCtaRecDados.FieldByName('CTR_VALCOR').AsFloat/fltTotAgr,
                                      cdsCtaRecDados.FieldByName('CTR_VALDES').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_JURATR').AsFloat + cdsCtaRecDados.FieldByName('CTR_JURREP').AsFloat,
                                      strConPag,
                                      cdsCtaRecDados.FieldByName('CTR_CODREP').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_COMREP').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_COMREP').AsFloat/fltTotAgr,
                                      cdsCtaRecDados.FieldByName('CTR_VALIPI').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_VALRET').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_DESSUJ').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_JURSUJ').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_BARCON').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_PERDPO').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_QTDDAV').AsInteger,
                                      cdsCtaRecDados.FieldByName('CTR_VALACE').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_VALFRE').AsFloat,
                                      0,
                                      cdsCtaRecDados.FieldByName('CTR_DOCDIV').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_ESPDIV').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_EMPDIV').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_CLIDIV').AsString,
                                      cdsCtaRecDados.FieldByName('CTR_COMDIV').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_FATDIV').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_CODDIV').AsString,
                                      0,
                                      '',
                                      '',
                                      '',
                                      cdsCtaRecDados.FieldByName('CTR_VALCBS').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_VALIBS').AsFloat,
                                      cdsCtaRecDados.FieldByName('CTR_VAL_IS').AsFloat);

          If (Not blnConfirma) Then
          Begin
             blnConfirma := fALSE;
             Break;
             fRollback;
          End;

          cdsCtaRecDados.Next;
          Application.ProcessMessages;

        End;

      End;

      If (blnConfirma) And (Not fEmptyStr(strCodPorDin)) And (Not fEmptyStr(edtDinheiro.Text)) And (fStrToFloat(edtDinheiro.Text) <> 0.0) Then
      Begin

         {********************************}
         {* GRAVA MOVIMENTAÇÃO BANCÁRIA  *}
         {********************************}
         strSeqLan   := '';
         strSeqLan   := fGravaMovimentacaoBancaria( strCodCta,
                                                    strCodPorDin,
                                                    strCodOpe,
                                                    VS_Date,
                                                    fTime(),
                                                    strNumAgr,
                                                    'AG',
                                                    'C',
                                                    strCodEmp,
                                                    fStrtofloat(edtDinheiro.Text),
                                                    'REF. LANC. DINHEIRO - ANTEC. DE RECEBÍVEIS',
                                                    strCodCli,
                                                    intSeqCon );

         blnConfirma := (strSeqLan <> '');

         {*** GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AO DINHEIRO GERADO PELA ANTECIPAÇÃO DOS RECEBIVEIS ***}
         if blnConfirma then
            blnConfirma := (fGravaRelacionaisAntecRecebiveis( strNumAgr, 'A', '', strCodCli, strCodEmp, strSeqLan, 'DH', fStrtofloat(edtDinheiro.Text), strCodCta, strCodPorDin ) <> '');

         If (Not blnConfirma) Then
            fRollBack;

      End;

      {*****************}
      {* GRAVA CARTOES *}
      {*****************}
      If (blnConfirma) And (fCfgSis('USACTC', varBoolean)) And (Length(arrCartoes) > 0) Then
      Begin

        //pgbProgresso.Position := 0;
        //pgbProgresso.Properties.Max := Length(arrCartoes);
        {****************************************}
        {* GRAVA MOVIMENTAÇÃO BANCÁRIA DO CARTAO*}
        {****************************************}
         strSeqLan   := '';
         strSeqLan   := fGravaMovimentacaoBancaria( strCodCta,
                                                    strCodPorCar,
                                                    strCodOpe,
                                                    VS_Date,
                                                    fTime(),
                                                    //arrCartoes[intContador].strNumDup,
                                                    strNumAgr,
                                                    'AG',
                                                    'C',
                                                    strCodEmp,
                                                    //arrDuplicFat[intContador2].curValor,
                                                    fStrToFloat(edtCartao.text),
                                                    'REF. LANC. CARTOES - ANTEC. DE RECEBÍVEIS',
                                                    strCodCli,
                                                    intSeqCon);

        blnConfirma := (strSeqLan <> '');

        If (Not blnConfirma) Then
        Begin
           fRollBack;
           SetLength(arrCartoes,0);
        End;

        strAutInc_Antec := '';

        // GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AOS CARTOES GERADOS PELA ANTECIPAÇÃO DOS RECEBIVEIS
        If blnConfirma Then
           strAutInc_Antec := fGravaRelacionaisAntecRecebiveis( strNumAgr, 'A', '', strCodCli, strCodEmp, strSeqLan, 'CT', fStrToFloat(edtCartao.text), strCodCta, strCodPorCar );

        blnConfirma := (strAutInc_Antec <> '');

        strHisCar := Copy(strHisCar, 1, Length(strHisCar) - 1);
        If Pos('/', strHisCar) <= 0 Then
          strHisCar := 'REF. AO DOC. ' + Copy(strHisCar, 1, 250 - Length('REF. AO DOC. '))
        Else
          strHisCar := 'REF. AOS DOCS. ' + Copy(strHisCar, 1, 250 - Length('REF. AOS DOCS. '));

        For intContador := 0 To Length(arrCartoes) -1 Do
        Begin
          LTipoParcelamento := '';

          {$IFNDEF LINUX}
            LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intContador].strCodCar]);

            If (arrCartoes[intContador].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
              objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intContador].strCodCar)
            Else
              objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
          {$ELSE}
            objArredondaParcela := fArredondamentoParcelas(arrCartoes[intContador].strCodCar);
          {$ENDIF LINUX}

          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDig, False, False, False, VS_Date, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
          SetLength(arrDuplicFat, Length(arrDuplicata));

          //pgbProgresso.Position := 0;
          //pgbProgresso.Properties.Max := Length(arrDuplicata);
          For intContCopia := 0 To Length(arrDuplicata) - 1 Do
          Begin
            arrDuplicFat[intContCopia] := arrDuplicata[intContCopia];
            //pStepStatusSelecao(pgbProgresso);
          End;

          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValDes, False, False, False, VS_Date, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

          // Impostos
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValIpi, False, False, False, VS_Date, False, arrDuplicCarIpi, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValRet, False, False, False, VS_Date, False, arrDuplicCarRet, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValAce, False, False, False, VS_Date, False, arrDuplicCarAce, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValFre, False, False, False, VS_Date, False, arrDuplicCarFre, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValCbs, False, False, False, VS_Date, False, arrDuplicCarCbs, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltValIbs, False, False, False, VS_Date, False, arrDuplicCarIbs, 0, 'N', False, False, 0, objArredondaParcela);
          fDigDuplicVar(arrCartoes[intContador].strCndPag, 0, arrCartoes[intContador].fltVal_Is, False, False, False, VS_Date, False, arrDuplicCar_Is, 0, 'N', False, False, 0, objArredondaParcela);

          intContador2 := 0;
          //pgbProgresso.Position := 0;
          //pgbProgresso.Properties.Max := Length(arrDuplicata);
          While (intContador2 < Length(arrDuplicata))                 And
                (Not fEmptyStr(arrDuplicata[intContador2].strSequen)) Do
          Begin

            blnConfirma := fGravaMovCar( Self.Name,
                                         'INCLUSÃO',
                                         arrCartoes[intContador].strNumDup,
                                         cdsGenCtr.FieldByName('CTR_CODCLI').AsString,
                                         arrDuplicata[intContador2].strSequen,
                                         VS_strCodEmp,
                                         arrCartoes[intContador].strCodCar,
                                         VS_Date,
                                         StrToDate(arrDuplicata[intContador2].dtaDtaVen),
                                         arrDuplicata[intContador2].curValor,
                                         arrDuplicata[intContador2].curValor,
                                         arrCartoes[intContador].strObsCar,
                                         strHisCar,
                                         arrCartoes[intContador].strCndPag,
                                         0,
                                         0.0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         arrCartoes[intContador].fltPerDes,
                                         arrDuplicFat[intContador2].curValor,
                                         arrDuplicFat[intContador2].curValor - arrDuplicata[intContador2].curValor,
                                         arrCartoes[intContador].strNumCcd,
                                         IIF(intQtdDup > 1,'DIVERSOS',strDocume),
                                         '',
                                         intSeqCon,
                                         VS_strCodEmp,
                                         strLoginUsuarioLogado,
                                         False,
                                         '',
                                         'B',
                                         '',
                                         arrCartoes[intContador].strTipCar,
                                         arrDuplicCarIpi[intContador2].curValor,
                                         arrDuplicCarRet[intContador2].curValor,
                                         arrDuplicCarAce[intContador2].curValor,
                                         arrDuplicCarFre[intContador2].curValor,
                                         arrCartoes[intContador].strNumNsu,
                                         '',
                                         arrCartoes[intContador].dtaDtaTra,
                                         0,
                                         0,
                                         0,
                                         '',
                                         False,
                                         strAutInc_Antec,
                                         '',
                                         'N',
                                         0,
                                         False,
                                         '',
                                         '',
                                         '',
                                         0,
                                         '',
                                         '',
                                         '',
                                         arrDuplicCarCbs[intContador2].curValor,
                                         arrDuplicCarIbs[intContador2].curValor,
                                         arrDuplicCar_Is[intContador2].curValor);

            Inc(intContador2);
            //pStepStatusSelecao(pgbProgresso);

            If (Not blnConfirma) Then
            Begin
              fRollBack;
              SetLength(arrCartoes,0);
            End;

          End;

        End;

        SetLength(arrCartoes,0);
      End;

      {************************************}
      { GRAVAÇÃO DOS CHEQUES               }
      {************************************}
      If (blnConfirma) And ((Not cdsChqPre.IsEmpty) Or (Not cdsChqVis.IsEmpty)) Then
      Begin

          //pgbProgresso.Position       := 0;
          //pgbProgresso.Properties.Max := 1;
          blnConfirma := fGravaCheques( intSeqCon,
                                        dtaDtaVenc,                    // Data de lançamento
                                        strNumAgr,                     // Numero duplicata gerada
                                        strCodCli,                     // Codigo do cliente
                                        strCodEmp,                     // Codigo da Empresa
                                        strCodVenAnt,                  // Codigo do Vendedor
                                        strLoginUsuarioLogado,         // Codigo do Operador
                                        strCodPorChV,                  // Codigo do Portador cheque a vista
                                        strCodPorChP,                  // Codigo do Portador cheque a prazo
                                        strCodCta,                     // Codigo do Plano de contas
                                        fStrToFloat(edtChqVista.text), // Total do cheque a vista
                                        fStrToFloat(edtChqPre.text) ); // Total do cheque a prazo
          //pStepStatusSelecao(pgbProgresso);

          cdsChqPre.EmptyDataSet;
          cdsChqVis.EmptyDataSet;

          If (Not blnConfirma) Then
             fRollBack;

      End;

      {**********************************}
      {* GRAVA CREDITO DO CLIENTE       *}
      {**********************************}
      If (blnConfirma) And (fFormataFloat(fltValCal,2) > 0) Then
      Begin

        blnConfirma := fGravaCreditoCliente( fltValCal,             // Valor calculado com os descontos da antecipação
                                             intSeqCon,
                                             dtaDtaVenc,            // Data de lançamento
                                             strNumAgr,             // Numero duplicata gerada
                                             strCodCli,             // Codigo do cliente
                                             strCodEmp,             // Codigo da Empresa
                                             strCodVenAnt,          // Codigo do Vendedor
                                             strLoginUsuarioLogado, // Codigo do Operador
                                             strCodPorAnt,          // Codigo do Portador
                                             strCodCta);            // Codigo do Plano de contas
        If (Not blnConfirma) Then
           fRollBack;

      End;

      FreeAndnil(cdsCtaRecDados);

    Except
      On E: Exception Do
      Begin
        FreeAndnil(cdsCtaRecDados);
        blnConfirma := False;
        fRollBack;
        pMensagensErro(E.Message, '[untCtrAntecipacaoRecebiveis]');
      End;
    End;

    If blnConfirma Then
    Begin
       strDupsGeradas := fRetornaDupsGeradas();
       fCommit;
    End else
      fRollBack;

    Result        := blnConfirma;
    Screen.Cursor := crDefault;
    FreeAndNil(cdsGenCtr);

end;

function TfrmCtrAntecipacaoRecebiveis.fDeletaDuplicatas(
  arrDupSel: Array Of TDuplicataCtr): Boolean;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGenRec  : TUniQuery;

begin
  Try
    Result := True;

    qryGenRec := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE * FROM CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'AUTOINCREM IN (';
      For intContador := 0 To Length(arrDupSel) -1 Do
        strSQL := strSQL + '"' + arrDupSel[intContador].strAutoIn + '"' +
                           IIF(intContador < Length(arrDupSel) - 1, ',', ')');

      With qryGenRec Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result And fApagaDuplicataContasReceber(qryGenRec, Self.Name,'',False);
          Next;
        End;

        Close;

      End;

      If Not Result Then
        Raise Exception.Create('Erro ao apagar as duplicatas. Operação cancelada!');
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('Erro ao apagar as duplicatas. Erro gerado: ' + E.Message);
      End;

    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

procedure TfrmCtrAntecipacaoRecebiveis.pRetornaTotal(strCodCli, strCodEmp: String; Var fltTotCli, fltTotIPI, fltTotRet, fltTotAce, fltTotFre: Double; strParcela: String = '');
  Var
    cdsGen: TUniClientDataSet;
    fldTotCli, fldTotIPI, fldTotRet, fldTotAce, fldTotFre: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldTotCli := fCriaAggregateField(cdsGen, 'FLDTOTCLI', 'SUM(CTR_VALCOR)', '#,##0.00');
  fldTotIPI := fCriaAggregateField(cdsGen, 'FLDTOTIPI', 'SUM(CTR_VALIPI)', '#,##0.00');
  fldTotRet := fCriaAggregateField(cdsGen, 'FLDTOTRET', 'SUM(CTR_VALRET)', '#,##0.00');
  fldTotAce := fCriaAggregateField(cdsGen, 'FLDTOTACE', 'SUM(CTR_VALACE)', '#,##0.00');
  fldTotFre := fCriaAggregateField(cdsGen, 'FLDTOTFRE', 'SUM(CTR_VALFRE)', '#,##0.00');

  With cdsGen Do
  Begin
    Data := cdsCtaRecDados.Data;
    Filtered := False;
    Filter := '';
    //Filter := Filter + 'CTR_MARDES = ''M'' AND ';
    Filter := Filter + 'CTR_CODCLI = ' + QuotedStr(strCodCli);
    If Not fEmptyStr(strParcela) Then
      Filter := Filter + ' AND PARDUP = ' + QuotedStr(strParcela);
    If (fCfgSis('AGRTPR', varInteger) = 3) Then
      Filter := Filter + ' AND CTR_CODEMP = ' + QuotedStr(strCodEmp);
    Filtered := True;

    AggregatesActive := True;
    fltTotCli := IIF(fldTotCli.Value = Null, 0, fldTotCli.Value);
    fltTotIPI := IIF(fldTotIPI.Value = Null, 0, fldTotIPI.Value);
    fltTotRet := IIF(fldTotRet.Value = Null, 0, fldTotRet.Value);
    fltTotAce := IIF(fldTotAce.Value = Null, 0, fldTotAce.Value);
    fltTotFre := IIF(fldTotFre.Value = Null, 0, fldTotFre.Value);
  End;

  FreeAndNil(cdsGen);
end;

function TfrmCtrAntecipacaoRecebiveis.fPrecisaDigitarChequeAVista: Boolean;
begin
  Result := (fCfgSis('CHQRCX') = 'S') And (fCfgSis('CHQVIS') = 'S');
end;

function TfrmCtrAntecipacaoRecebiveis.fPrecisaDigitarChequePre: Boolean;
begin
  Result := (fCfgSis('CHQRCX') = 'S')
end;

{************************************}
{* CADASTRA CHEQUES A VISTA         *}
{*********************************AF*}
function TfrmCtrAntecipacaoRecebiveis.fChequeVis(strValor: String): Boolean;
  Var
    fltValCar: Double;
    fltValChq: Double;
    strChave : String;
Begin
  Result    := True;
  fltValChq := 0.0;

  If Not fPrecisaDigitarChequeAVista Then
     Exit;

  If Not Assigned(cdsChqVis) Then cdsChqVis := fCriaCdsCheques(Self);

  With cdsChqVis Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    If cdsChqVis.RecordCount > 0 Then
    Begin
      If fltValCar = 0.0 Then
      Begin
        If fMensagem('AVISO', 'Existe(m) Cheque(s) Digitado(s)! Limpa a Digitação dos Cheques?', ['&Sim', '&Não']) = 1 Then
          cdsChqVis.CancelUpdates
        Else
        Begin
          fMensagem('Aviso','Informe o valor de Cheque a Vista!!!',['&OK']);
          Result := False;
          pSetFocus(edtChqVista);
        End;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqVis;
        frmRcxMostraCheques.ShowModal;

        fltValChq := frmRcxMostraCheques.fltValTot;
      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequeVis]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);
    End;

    If fltValChq <> fltValCar Then
    Begin
      Try

        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.strCodOpe         := strCodOpe;
        frmCadCheques.blnResumida       := True;
        frmCadCheques.blnResCai         := Not(blnCtaRec);

        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot         := fltValCar;
        frmCadCheques.blnPrazo          := False;
        frmCadCheques.cdsChqRcx         := cdsChqVis;
        frmCadCheques.dbeDtaCad.Enabled := False;
        frmCadCheques.dbeDtaCad.TabStop := False;
        frmCadCheques.dbeDtaVen.Enabled := False;
        frmCadCheques.dbeDtaVen.TabStop := False;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqPre.Data;

        frmCadCheques.blnJaIncluiu      := True;
        frmCadCheques.edtTotDig.Text    := FormatFloat('#,##0.00',fltValChq);
        frmCadCheques.edtTotGer.Text    := FormatFloat('#,##0.00',fltValCar);

        frmCadCheques.blnTroChq         := blnTroChq;
        frmCadCheques.strDocume         := IIF(strDocume <> 'DIVERSOS', strDocume + 'AVI', strDocume);
        frmCadCheques.strCliente        := strCliente;
        frmCadCheques.dicCheques        := TDictionary<String, TChequeEmitido>.Create;
        frmCadCheques.blnCtaRec         := blnCtaRec;

        If Not blnCtaRec Then
        Begin
           If (Assigned(dicCheques)) And (dicCheques.Count > 0) Then
           Begin
               For strChave In dicCheques.Keys Do
                   frmCadCheques.dicCheques.AddOrSetValue(strChave, dicCheques[strChave]);
           End;
        End;

        //pAdicionaCtrBaixando;

        frmCadCheques.ShowModal;

        cdsChqVis.Data := frmCadCheques.cdsTabela.Data;

        If IsEmpty Or (Not frmCadCheques.blnConfima) Then
           Result := False;

        If Result Then
        Begin
          optTroco      := frmCadCheques.optTroco;
          fltValorTroco := frmCadCheques.fltValorTroco;
        End;

        If (Assigned(frmCadCheques.dicCheques)) And (frmCadCheques.dicCheques.Count > 0) Then
        Begin
           For strChave In frmCadCheques.dicCheques.Keys Do
               dicCheques.AddOrSetValue(strChave, frmCadCheques.dicCheques[strChave]);
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[frmFatFormasPagamento.fChequeVis]');
        End;
      End;
      pFreeAndNil(frmCadCheques);

    End;

  End;

End;

{************************************}
{* CADASTRA OS CHEQUES A PRAZO.     *}
{*********************************AF*}
function TfrmCtrAntecipacaoRecebiveis.fChequePre(strValor: String): Boolean;
  Var
    fltValCar: Double;
    fltValChq: Double;
    strChave : String;
Begin
  Result    := True;
  fltValChq := 0.0;

  If Not fPrecisaDigitarChequePre Then
     Exit;

  If Not Assigned(cdsChqPre) Then cdsChqPre := fCriaCdsCheques(Self);

  With cdsChqPre Do
  Begin
    First;

    fltValCar := fStrToFloat(strValor);

    If cdsChqPre.RecordCount > 0 Then
    Begin

      If fltValCar = 0.0 Then
      Begin
        If fMensagem('AVISO', 'Existe(m) Cheque(s) Digitado(s)! Limpar a Digitação dos Cheques?', ['&Sim', '&Não']) = 1 Then
          cdsChqPre.CancelUpdates
        Else
        Begin
          fMensagem('Aviso','Informe o valor de Cheque - Pré!!!',['&OK']);
          Result := False;
          pSetFocus(edtChqPre);
        End;
        Exit;
      End;

      Try
        pCriarFormularios(TfrmRcxMostraCheques,frmRcxMostraCheques);
        frmRcxMostraCheques.dsCheques.DataSet := cdsChqPre;
        frmRcxMostraCheques.ShowModal;

        fltValChq := frmRcxMostraCheques.fltValTot;

      Except
        On E: Exception Do
        Begin
          fltValChq := 0.0;
          pMensagensErro(E.Message, '[fChequePre]');
        End;
      End;

      pFreeAndNil(frmRcxMostraCheques);
    End;

    If fltValChq <> fltValCar Then
    Begin
      Try
        pCriarFormularios(TfrmCadCheques,frmCadCheques);
        frmCadCheques.strCodOpe         := strCodOpe;
        frmCadCheques.blnResumida       := True;
        frmCadCheques.blnResCai         := Not(blnCtaRec);

        frmCadCheques.blnGravacaoFisica := False;
        frmCadCheques.fltValTot  := fltValCar;
        frmCadCheques.blnPrazo   := True;
        frmCadCheques.cdsChqRcx  := cdsChqPre;
        frmCadCheques.blnTroChq  := blnTroChq;

        frmCadCheques.cdsChqOutroTip.Data := cdsChqVis.Data;

        frmCadCheques.blnJaIncluiu   := True;
        frmCadCheques.edtTotDig.Text := FormatFloat('#,##0.00',fltValChq);
        frmCadCheques.edtTotGer.Text := FormatFloat('#,##0.00',fltValCar);

        frmCadCheques.strDocume  := IIF(strDocume <> 'DIVERSOS', strDocume + 'PRZ', strDocume);
        frmCadCheques.strCliente := strCliente;
        frmCadCheques.dicCheques := TDictionary<String, TChequeEmitido>.Create;
        frmCadCheques.blnCtaRec  := blnCtaRec;

        If Not blnCtaRec Then
          If (Assigned(dicCheques)) And (dicCheques.Count > 0) Then
          Begin
            For strChave In dicCheques.Keys Do
                frmCadCheques.dicCheques.AddOrSetValue(strChave, dicCheques[strChave]);
          End;

        //pAdicionaCtrBaixando;

        frmCadCheques.ShowModal;

        cdsChqPre.Data := frmCadCheques.cdsTabela.Data;

        If IsEmpty Or (Not frmCadCheques.blnConfima) Then
           Result := False;

        If Result Then
        Begin
           optTroco      := frmCadCheques.optTroco;
           fltValorTroco := frmCadCheques.fltValorTroco;
        End;

        If (Assigned(frmCadCheques.dicCheques)) And
           (frmCadCheques.dicCheques.Count > 0) Then
        Begin
           For strChave In frmCadCheques.dicCheques.Keys Do
               dicCheques.AddOrSetValue(strChave, frmCadCheques.dicCheques[strChave]);
        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[frmFatFormasPagamento.fChequePre]');
        End;
      End;
      pFreeAndNil(frmCadCheques);
    End;

  End;

End;

procedure TfrmCtrAntecipacaoRecebiveis.pCarregaImpostoProporcional(fltValor: Double; Out fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double);
  Var
    intRec: Integer;
    fltProporcao, fltValDup, fltValRec, fltTotRec, fltTotIpi, fltTotRet, fltTotAce, fltTotFre, fltTotCbs, fltTotIbs, fltTot_Is: Double;
begin
  intRec := cdsCtaRecDados.RecNo;

  Try
    fltTotRec := 0;
    fltTotIpi := 0;
    fltTotRet := 0;
    fltTotAce := 0;
    fltTotFre := 0;
    fltTotCbs := 0;
    fltTotIbs := 0;
    fltTot_Is := 0;

    With cdsCtaRecDados Do
    Begin

      First;
      DisableControls;
      While Not Eof Do
      Begin
        //If fField('CTR_MARDES').AsString <> 'M' Then
        //Begin
        //  cdsCtaRecDados.Next;
        //  Continue;
        //End;

        fltTotRec := fltTotRec + FieldbyName('CTR_VALREC').AsFloat;

        fltValDup := FieldbyName('CTR_VALDUP').AsFloat;
        fltValRec := FieldbyName('CTR_VALREC').AsFloat - FieldbyName('CTR_VALJUR').AsFloat + FieldbyName('CTR_VALDES').AsFloat;

        If fltValDup = 0 Then
           fltProporcao := 0
        Else
           fltProporcao := fltValRec / fltValDup;

        fltTotIpi := fltTotIpi + FieldbyName('CTR_VALIPI').AsFloat * fltProporcao;
        fltTotRet := fltTotRet + FieldbyName('CTR_VALRET').AsFloat * fltProporcao;
        fltTotAce := fltTotAce + FieldbyName('CTR_VALACE').AsFloat * fltProporcao;
        fltTotFre := fltTotFre + FieldbyName('CTR_VALFRE').AsFloat * fltProporcao;
        fltTotCbs := fltTotCbs + FieldbyName('CTR_VALCBS').AsFloat * fltProporcao;
        fltTotIbs := fltTotIbs + FieldbyName('CTR_VALIBS').AsFloat * fltProporcao;
        fltTot_Is := fltTot_Is + FieldbyName('CTR_VAL_IS').AsFloat * fltProporcao;

        Next;
      End;

      If fltTotRec = 0 Then
      Begin
        fltValIpi := 0;
        fltValRet := 0;
        fltValAce := 0;
        fltValFre := 0;
        fltValCbs := 0;
        fltValIbs := 0;
        fltVal_Is := 0;
      End
      Else
      Begin
        fltValIpi := (fltValor / fltTotRec) * fltTotIpi;
        fltValRet := (fltValor / fltTotRec) * fltTotRet;
        fltValAce := (fltValor / fltTotRec) * fltTotAce;
        fltValFre := (fltValor / fltTotRec) * fltTotFre;
        fltValCbs := (fltValor / fltTotRec) * fltTotCbs;
        fltValIbs := (fltValor / fltTotRec) * fltTotIbs;
        fltVal_Is := (fltValor / fltTotRec) * fltTot_Is;
      End;

    End;

  Finally
    cdsCtaRecDados.RecNo := intRec;
    cdsCtaRecDados.EnableControls;
  End;
End;

function TfrmCtrAntecipacaoRecebiveis.fGravaDupsGeradas(strNumDup : String;             // Numero duplicata gerada
                                                        strParDup : String;             // Codigo do cliente
                                                        strEspDoc : String;             // Codigo do Vendedor
                                                        strCodEmp : String;             // Codigo da Empresa
                                                        strCodCli : String              // Codigo do Operador
                                                        ) : Boolean;
  Var intTamAnt : Integer;
Begin

    intTamAnt := Length(arrDupAbeAut);
    SetLength(arrDupAbeAut, intTamAnt+1);

    arrDupAbeAut[intTamAnt].strNumDup := strNumDup;
    arrDupAbeAut[intTamAnt].strParcel := strParDup;
    arrDupAbeAut[intTamAnt].strEspDoc := strEspDoc;
    arrDupAbeAut[intTamAnt].strCodEmp := strCodEmp;
    arrDupAbeAut[intTamAnt].strCodCli := strCodCli;
    arrDupAbeAut[intTamAnt].strAutoIn := fRetornaAutoIncrem(strNumDup,
                                                            strParDup,
                                                            strEspDoc,
                                                            strCodEmp,
                                                            strCodCli);

    result := (arrDupAbeAut[intTamAnt].strAutoIn <> '');

End;

function TfrmCtrAntecipacaoRecebiveis.fRetornaDupsGeradas() : String;
  Var Str : String;
      intContador : Integer;
Begin

    Str := '';
    For intContador := 0 To Length(arrDupAbeAut) -1 Do
      Str := Str + '"' + arrDupAbeAut[intContador].strAutoIn + '"' +
                         IIF(intContador < Length(arrDupAbeAut) - 1, ',', ' ');

    Result := Str;

End;

function TfrmCtrAntecipacaoRecebiveis.fGravaCheques(intSeqCon : Integer;
                                                    dtaDtaLan : TDateTime;          // Data de Lançamento
                                                    strNumDup : String;             // Numero duplicata gerada
                                                    strCodCli : String;             // Codigo do cliente
                                                    strCodEmp : String;             // Codigo da Empresa
                                                    strCodVen : String;             // Codigo do Vendedor
                                                    strCodOpe : String;             // Codigo do Operador
                                                    strCodPorChV : String;          // Codigo do Portador cheque a vista
                                                    strCodPorChP : String;          // Codigo do Portador cheque a prazo
                                                    strCtaBai : String;             // Codigo do Plano de contas
                                                    flTotChV : Double;              // total de cheque Vista
                                                    flTotChP : Double): Boolean;    // total de cheque Pre

  Var
    fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is: Double;
    strSeqLan,
    strAutInc_Antec : String;
Begin
  Try
    Result := True;

    With cdsChqPre Do
    Begin
      DisableControls;
      If Assigned(cdsChqPre) And (Active) And (Not IsEmpty) Then
      Begin

        {***************************************************}
        {* GRAVA MOVIMENTAÇÃO BANCÁRIA DOS CHEQUES A PRAZO *}
        {***************************************************}
        If Result Then
        Begin

          strSeqLan := '';
          strSeqLan := fGravaMovimentacaoBancaria(strCtaBai,
                                                  strCodPorChP,
                                                  strCodOpe,
                                                  dtaDtaLan,
                                                  fTime(),
                                                  strNumDup,
                                                  'AG',
                                                  'C',
                                                  strCodEmp,
                                                  flTotChP, //FieldByName('CHQ_VALCHQ').AsFloat,
                                                  'REF. LANC. CHQ PRE - ANTEC. DE RECEBÍVEIS',
                                                  strCodCli,
                                                  intSeqCon);

          Result := (strSeqLan <> '');

          // GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AOS CHEQUES-PRE GERADOS PELA ANTECIPAÇÃO DOS RECEBIVEIS
          strAutInc_Antec := '';
          If Result Then
             strAutInc_Antec := fGravaRelacionaisAntecRecebiveis( strNumDup, 'A', '', strCodCli, strCodEmp, strSeqLan, 'CP', flTotChP, strCtaBai, strCodPorChP );

          Result := (strAutInc_Antec <> '');

        End;

        First;
        While (Not Eof) Do
        Begin
          Application.ProcessMessages;
          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          Result := fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-PRZ', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 fltValIpi,
                                 fltValRet,
                                 fltValAce,
                                 fltValFre,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 '',
                                 strAutInc_Antec,
                                 '',
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

            {********************}
            {* GRAVA LOGCHQ     *}
            {*****************JU*}
            If Result Then
               Result := fLogChq(cdsChqPre, 1);

          Next;
        End;

      End;
      EnableControls;
    End;

    With cdsChqVis Do
    Begin
      DisableControls;
      If Assigned(cdsChqVis) And (Active) And (Not IsEmpty) Then
      Begin

        {***********************************************}
        {* GRAVA MOVIMENTAÇÃO BANCÁRIA CHEQUES A VISTA *}
        {***********************************************}
        If Result Then
        Begin

           strSeqLan := '';
           strSeqLan := fGravaMovimentacaoBancaria(strCtaBai,
                                                   strCodPorChV,
                                                   strCodOpe,
                                                   dtaDtaLan,
                                                   fTime(),
                                                   strNumDup,
                                                   'AG',
                                                   'C',
                                                   strCodEmp,
                                                   flTotChV, //FieldByName('CHQ_VALCHQ').AsFloat,
                                                   'REF. LANC. CHQ - ANTEC. DE RECEBÍVEIS',
                                                   strCodCli,
                                                   intSeqCon);
           Result := (strSeqLan <> '');

           // GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AOS CHEQUES-PRE GERADOS PELA ANTECIPAÇÃO DOS RECEBIVEIS
           strAutInc_Antec := '';
           If Result Then
              strAutInc_Antec := fGravaRelacionaisAntecRecebiveis( strNumDup, 'A', '', strCodCli, strCodEmp, strSeqLan, 'CV', flTotChV, strCtaBai, strCodPorChV );

           Result := (strAutInc_Antec <> '');

        End;


        First;
        While Not Eof Do
        Begin
          Application.ProcessMessages;

          pCarregaImpostoProporcional(FieldByName('CHQ_VALCHQ').AsFloat, fltValIpi, fltValRet, fltValAce, fltValFre, fltValCbs, fltValIbs, fltVal_Is);

          Result := fGravaCheque(FieldByName('CHQ_CODBCO').AsString,
                                 FieldByName('CHQ_NUMAGE').AsString,
                                 FieldByName('CHQ_CONCOR').AsString,
                                 FieldByName('CHQ_NUMCHQ').AsString,
                                 FieldByName('CHQ_CODCLI').AsString,
                                 FieldByName('CHQ_NOMEMI').AsString,
                                 FieldByName('CHQ_ENDERE').AsString,
                                 FieldByName('CHQ_TELEMI').AsString,
                                 FieldByName('CHQ_CGCCPF').AsString,
                                 FieldByName('CHQ_C_G_C_').AsString,
                                 FieldByName('CHQ_HIST01').AsString,
                                 FieldByName('CHQ_HIST02').AsString,
                                 FieldByName('CHQ_CTADEP').AsString,
                                 FieldByName('CHQ_DOCDEP').AsString,
                                 FieldByName('CHQ_CODPOR').AsString,
                                 FieldByName('CHQ_CODCTA').AsString,
                                 FieldByName('CHQ_MOTDEV').AsString,
                                 FieldByName('CHQ_FORREP').AsString,
                                 FieldByName('CHQ_OBSREP').AsString,
                                 FieldByName('CHQ_CODEMP').AsString,
                                 FieldByName('CHQ_NUMNOT').AsString,
                                 FieldByName('CHQ_PORCUS').AsString,
                                 IfThen(FieldByName('CHQ_DOCUME').AsString = 'DIVERSOS', FieldByName('CHQ_DOCUME').AsString + '-AVI', FieldByName('CHQ_DOCUME').AsString),
                                 FieldByName('CHQ_INCCTR').AsString,
                                 FieldByName('CHQ_DTACAD').AsDateTime,
                                 FieldByName('CHQ_DTAVEN').AsDateTime,
                                 FieldByName('CHQ_DTADEP').AsDateTime,
                                 FieldByName('CHQ_DTADEV').AsDateTime,
                                 FieldByName('CHQ_DTARDP').AsDateTime,
                                 FieldByName('CHQ_DTAREP').AsDateTime,
                                 FieldByName('CHQ_DTACUS').AsDateTime,
                                 FieldByName('CHQ_VALCHQ').AsFloat,
                                 '',
                                 intSeqCon,
                                 VS_strCodEmp,
                                 0,
                                 FieldByName('CHQ_TELCHE').AsString,
                                 FieldByName('CHQ_TELNUM').AsString,
                                 FieldByName('CHQ_CODOPE').AsString,
                                 FieldByName('CHQ_CODCMC').AsString,
                                 fltValIpi,
                                 fltValRet,
                                 fltValAce,
                                 fltValFre,
                                 FieldByName('CHQ_PORCHQ').AsString,
                                 Self.Name,
                                 FieldByName('CHQ_NAODEP').AsString,
                                 FieldByName('CHQ_CODCID').AsString,
                                 '',
                                 strAutInc_Antec,
                                 '',
                                 fltValCbs,
                                 fltValIbs,
                                 fltVal_Is);

            {******************}
            {* GRAVA O LOGCHQ *}
            {***************JU*}
            If Result Then
               Result := fLogChq(cdsChqVis, 2);

          Next;
        End;

        EnableControls;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCtrAntecipacaoRecebiveis.fLogChq(cdsLog: TUniClientDataSet; intOpcao: Integer): Boolean;
  Var
    strHisLog: String;
    repCadChq: TCadChqRepository;
begin

  Try
    Result := True;
    strHisLog := IIF(intOpcao = 1, 'CHQ. PRE.', 'CHQ. VIS.');

    repCadChq := TCadChqRepository.Create;
    //cdsCtaRec.DisableControls;
    With cdsLog Do
    Begin
      repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                          'INSERINDO ' + strHisLog + '(FrmCtrAntecipacaoRecebiveis.fLogChq)');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(repCadChq);

end;

{************************************}
{* DIGITAÇÃO DOS CARTÕES            *}
{*********************************MV*}
function TfrmCtrAntecipacaoRecebiveis.fDigitacaoCartoes(fltValor: Double;
                                                        Var arrCartoes: TCartoesResumoCaixaArray;
                                                             strCodCar: String = '';
                                                             strCodFin: String = '';
                                                             intQtdPar: Integer = 0) : Boolean;
  Var
    fltTotCar    : Double;
    intTamMat    : Integer;
    intContador  : Integer;
    intContador2 : Integer;
    intContador3 : Integer;

    strDesCar : String;
    fltValDig : Double;
    fltValDes : Double;
    fltPerDes : Double;
    strCndPag : String;
    strObsCar : String;
    strNumCcd : String;
    strNumNsu : String;
    strTipCar : String;

    blnSaiFor : Boolean;

    stlDeletados        : TStringList;
    frmRcxMostraCartoes : TfrmRcxMostraCartoes;
    frmRcxDigCartoes    : TfrmRcxDigCartoes;

    LstrArquivoTef: String;

    LDataTransacao: TDateTime;
begin

  Result    := True;

  fltValDig := 0.0;
  fltValDes := 0.0;
  fltPerDes := 0.0;

  If (fltValor = 0.0) Then
  Begin
    SetLength(arrCartoes, 0);
    Exit;
  End;

  If (fCfgSis('DIGCAR') <> 'S') Then
  Begin
    SetLength(arrCartoes, 0);
    Exit;
  End;

  // pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If (fltTotCar = fltValor) Then
  Begin

    Try
      pCriarFormularios(TfrmRcxMostraCartoes, frmRcxMostraCartoes);

      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        frmRcxMostraCartoes.lsvCartoes.AddItem(arrCartoes[intContador].strCodCar + ' - ' +
                                               arrCartoes[intContador].strDesCar, Nil);
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(FloatToStrF(arrCartoes[intContador].fltValDig, ffFixed, 12, 2));
        frmRcxMostraCartoes.lsvCartoes.Items[intContador].SubItems.Add(IntToStr(arrCartoes[intContador].intCodSeq));
      End;

      frmRcxMostraCartoes.lsvCartoes.Columns[2].Width := 0;

      frmRcxMostraCartoes.ShowModal;

      blnConfCartoes := frmRcxMostraCartoes.blnConfirma;

      stlDeletados := frmRcxMostraCartoes.stlDeletados;

      For intContador := 0 To stlDeletados.Count -1 Do
      Begin

        blnSaiFor := False;

        For intContador2 := 0 To Length(arrCartoes) -1 Do
        Begin

          If (arrCartoes[intContador2].intCodSeq = StrToInt(stlDeletados[intContador])) Then
          Begin

            if not fEmptyStr(FstrSessaoTef) then
              frmRcxDigCartoes.pGarantirCancelamentoTefRecebimento(FobjTefRecebimento, arrCartoes[intContador2].strArqTef);

            For intContador3 := intContador2 To Length(arrCartoes) - 2 Do
            Begin
              arrCartoes[intContador3] := arrCartoes[intContador3+1];
            End;
            SetLength(arrCartoes, Length(arrCartoes)-1);
            blnSaiFor := True;
          End;

          If (blnSaiFor) Then
            Break;

        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatFormasPagamento.fDigitacaoCartoes]');
      End;
    End;

    pFreeAndNil(frmRcxMostraCartoes);
  End;

  fltTotCar := 0.0;
  For intContador := 0 To Length(arrCartoes) -1 Do
  Begin
    fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
  End;

  If fltValor < fltTotCar Then
  Begin
    fltTotCar := 0.0;
    SetLength(arrCartoes,0);
  End;

  LDataTransacao := VS_Date;

  While RoundTo(fltTotCar, -2) < RoundTo(fltValor, -2) Do
  Begin

    Try
      pCriarFormularios(TfrmRcxDigCartoes, frmRcxDigCartoes);
      frmRcxDigCartoes.strCodFin := strCodFin;
      frmRcxDigCartoes.strCodCar := strCodCar;
      frmRcxDigCartoes.intQtdPar := intQtdPar;

      frmRcxDigCartoes.blnTroCar := blnTroCar;
      frmRcxDigCartoes.fltTotDig := fltTotCar;
      frmRcxDigCartoes.fltTotGer := fltValor;
      frmRcxDigCartoes.fltMaxDig := (fltValor - fltTotCar);
      frmRcxDigCartoes.arrCartoes := arrCartoes;

      if not fEmptyStr(FstrSessaoTef) then
      Begin
        frmRcxDigCartoes.blnExecutandoPeloFaturamento := FblnExecutandoPeloFaturamento;
        frmRcxDigCartoes.strSessaoTef                 := FstrSessaoTef;
        frmRcxDigCartoes.objTefRecebimento            := FobjTefRecebimento;
        frmRcxDigCartoes.blnTefRcx                    := fCfgSis('TEFREC', varBoolean);
      End;

      frmRcxDigCartoes.ShowModal;

      strCodCar := frmRcxDigCartoes.edtCodCar.Text;
      strDesCar := frmRcxDigCartoes.edtDesCar.Text;
      fltValDig := frmRcxDigCartoes.fltValDig;
      fltValDes := frmRcxDigCartoes.fltValDes;
      strCndPag := frmRcxDigCartoes.mskCndPag.Text;
      strNumCcd := frmRcxDigCartoes.edtNumCcd.Text;
      strNumNsu := fPadL(frmRcxDigCartoes.edtNumNsu.Text, 14, '0');
      strObsCar := frmRcxDigCartoes.edtObsCar.Text;
      fltPerDes := frmRcxDigCartoes.fltPerDes;
      strTipCar := IIF(frmRcxDigCartoes.blnTipPOS, 'POS', 'TEF');
      LstrArquivoTef := frmRcxDigCartoes.strArquivoTef;

      LDataTransacao := frmRcxDigCartoes.mskDtaTra.Date;

      Result    := frmRcxDigCartoes.blnConfirma;

      if Result then
      begin
        if (not VS_blnTefCitel) and (strTipCar = 'TEF') and fEmptyStr(LstrArquivoTef) then
        begin
          Result := False;
          pMensagemOk('A modalidade selecionada utiliza "TEF", ' +
                      'porém não foi encontrado o arquivo que confirma a transação TEF. ' +
                      'Entre em contato com a CITEL para solução do problema!');
        end;
      end;

      If Result Then
      Begin
        optTroco      := frmRcxDigCartoes.optTrocoCar;
        fltValorTroco := frmRcxDigCartoes.fltValorTrocoCar;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[frmFatFormasPagamento.fDigitacaoCartoes_1]');
      End;
    End;

    pFreeAndNil(frmRcxDigCartoes);

    If (Result) Then
    Begin
      intTamMat := Length(arrCartoes);
      SetLength(arrCartoes, intTamMat+1);
      arrCartoes[intTamMat].intCodSeq := intTamMat;
      arrCartoes[intTamMat].strCodCar := strCodCar;
      arrCartoes[intTamMat].strDesCar := strDesCar;
      arrCartoes[intTamMat].fltValDig := fltValDig;
      arrCartoes[intTamMat].strCndPag := strCndPag;
      arrCartoes[intTamMat].strObsCar := strObsCar;
      arrCartoes[intTamMat].fltValDes := fltValDes;
      arrCartoes[intTamMat].strNumCcd := strNumCcd;
      arrCartoes[intTamMat].fltPerDes := fltPerDes;
      arrCartoes[intTamMat].strCodFin := strCodFin;
      arrCartoes[intTamMat].strNumNsu := strNumNsu;
      arrCartoes[intTamMat].strTipCar := strTipCar;
      arrCartoes[intTamMat].strArqTef := LstrArquivoTef;
      arrCartoes[intTamMat].dtaDtaTra := LDataTransacao;

      If Not fEmptyStr(LstrArquivoTef) Then
        arrCartoes[intTamMat].strConteudoArquivo := fLerConteudoArquivo(LstrArquivoTef);

      fltTotCar := 0.0;
      For intContador := 0 To Length(arrCartoes) -1 Do
      Begin
        fltTotCar := fltTotCar + arrCartoes[intContador].fltValDig;
      End;

    End
    Else
    Begin
      if Assigned(FobjTefRecebimento) then
      Begin
        frmRcxDigCartoes.pGarantirCancelamentoTefRecebimento(FobjTefRecebimento, LstrArquivoTef);
        frmRcxDigCartoes.pCancelarTefDeCartoesJaConfirmados(FobjTefRecebimento, arrCartoes);
      End;
      SetLength(arrCartoes, 0);
      Break;
    End;

    strCodCar := '';

  End;

  // pFreeAndNil(frmRcxDigCartoes);
end;

function TfrmCtrAntecipacaoRecebiveis.fGravaRelacionaisAntecRecebiveis(strNumAgr : String;             // Numero do agrupamento gerado
                                                                       strParcel : String;             // Numero da parcela do Agrupamento
                                                                       strNumCre : String;             // Numero do credito gerado
                                                                       strCodCli : String;             // Codigo do cliente
                                                                       strCodEmp : String;             // Codigo da empresa
                                                                       strSeqLan : String;             // Sequencia de Lancamento da Movban
                                                                       strEspecie: String;             // Especie do registro
                                                                       flValLan  : Double;             // Valor do lançamento
                                                                       strCodCta : String;             // Codigo do plano de contas
                                                                       strCodPor : String): String;    // Codigo do Portador

  Var
    strSQL: String;
    qryGenCtr : TUniQuery;
    strAutInc : String;
begin
  strAutInc := '';

  qryGenCtr := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ANTREC ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  AUTOINCREM,  ';
  strSQL := strSQL + '  ANT_NUM_AG,  ';
  strSQL := strSQL + '  ANT_PARCEL,  ';
  strSQL := strSQL + '  ANT_NUM_CC,  ';
  strSQL := strSQL + '  ANT_CODCLI,  ';
  strSQL := strSQL + '  ANT_CODEMP,  ';
  strSQL := strSQL + '  ANT_SEQLAN,  ';
  strSQL := strSQL + '  ANT_ESPECI,  ';
  strSQL := strSQL + '  ANT_VALLAN,  ';
  strSQL := strSQL + '  ANT_CODCTA,  ';
  strSQL := strSQL + '  ANT_CODPOR ) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :AUTOINCREM, ';
  strSQL := strSQL + '  :ANT_NUM_AG, ';
  strSQL := strSQL + '  :ANT_PARCEL, ';
  strSQL := strSQL + '  :ANT_NUM_CC, ';
  strSQL := strSQL + '  :ANT_CODCLI, ';
  strSQL := strSQL + '  :ANT_CODEMP, ';
  strSQL := strSQL + '  :ANT_SEQLAN, ';
  strSQL := strSQL + '  :ANT_ESPECI, ';
  strSQL := strSQL + '  :ANT_VALLAN, ';
  strSQL := strSQL + '  :ANT_CODCTA, ';
  strSQL := strSQL + '  :ANT_CODPOR) ';


  try

    strAutInc := fRetAutoIncrem('ANTREC', strCodEmp);

    With qryGenCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTOINCREM').AsString   := strAutInc;
      ParamByName('ANT_NUM_AG').AsString   := strNumAgr;
      ParamByName('ANT_PARCEL').AsString   := strParcel;
      ParamByName('ANT_NUM_CC').AsString   := strNumCre;
      ParamByName('ANT_CODCLI').AsString   := strCodCli;
      ParamByName('ANT_CODEMP').AsString   := strCodEmp;
      ParamByName('ANT_SEQLAN').AsString   := strSeqLan;
      ParamByName('ANT_ESPECI').AsString   := strEspecie;
      ParamByName('ANT_VALLAN').AsFloat    := flValLan;
      ParamByName('ANT_CODCTA').AsString   := strCodCta;
      ParamByName('ANT_CODPOR').AsString   := strCodPor;
      ExecSQL;

      Close;

      Result := strAutInc;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaRelacionaisAntecRecebiveis] - ' + E.Message);
      Result := '';
    End;
  End;

  FreeAndNil(qryGenCtr);
end;

function TfrmCtrAntecipacaoRecebiveis.fGravaCreditoCliente(fltValCre : Double;
                                                           intSeqCon : Integer;
                                                           dtaDtaLan : TDateTime;          // Data de Lançamento
                                                           strNumDup : String;             // Numero duplicata gerada
                                                           strCodCli : String;             // Codigo do cliente
                                                           strCodEmp : String;             // Codigo da Empresa
                                                           strCodVen : String;             // Codigo do Vendedor
                                                           strCodOpe : String;             // Codigo do Operador
                                                           strCodPor : String;             // Codigo do Portador
                                                           strCtaBai : String): Boolean;   // Codigo do Plano de contas
  Var
    strNumDupli : String;
    strPortador : String;
    strSeqLan   : String;
    strSeqRec : String;
begin
  Try
    strCCGerado := '';
    strPortador := fRetornaPortadorCliente(strCodCli);

    If fEmptyStr(strPortador) Then
       strPortador := strCodPor;

    strNumDupli := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);

    Result := fGravaCadRec(strSeqRec,
                           Self.Name,
                           'INCLUSÃO',
                           strNumDupli,                                                        // Duplicata
                           'A',                                                                // Parcela
                           0,                                                                  // Sequencial de Baixa
                           'CC',                                                               // Espécie
                           strCodCli,                                                          // Cliente
                           strCodEmp,                                                          // Empresa
                           strCodVen,                                                          // Vendedor
                           strCodOpe,                                                          // Digitador
                           strPortador,                                                        // Portador
                           VS_Date,                                                            // Data de Cadastro
                           VS_Date,                                                            // Data de Vencimento
                           -fltValCre,                                                         // Valor da Duplicata
                           -fltValCre,                                                         // Valor Original
                           0.0,                                                                // Despesa de Cobrança
                           'N',                                                                // Desconto
                           'REF. LANC. CREDITO ANTEC. DE RECEBIVEIS',                                               // Histórico 1
                           '',                                                                 // Histórico 2
                           '',                                                                 // Portador da Baixa
                           '',                                                                 // Centro de Custo da Baixa
                           '',                                                                 // Operador da Baixa
                           '',                                                                 // Documento da Baixa
                           0.0,                                                                // Valor do Recebimento
                           0,                                                                  // Data do Recebimento
                           'N',
                           '',                                                                 // Código do Evento
                           '',                                                                 // Código Velho (CONVERSÃO)
                           '',                                                                 // Tipo de Fora (Condição de Pagamento)
                           '',                                                                 // Código da Condição de Pagamento
                           False,
                           IIF(fEmptyStr(fCfgSis('CTR_CC')),'',fCfgSis('CTR_CC')),             // Codigo do Plano de Contas
                           intSeqCon,
                           0,
                           '',                                                                 // Observação de Agrupamento 1
                           '',                                                                 // Observação de Agrupamento 2
                           '');                                                                // Observação de Agrupamento 3

    If (Not Result) Then
      Exit;

    If (Result) Then
        Result := fGravaDupsGeradas(strNumDupli,'A','CC',strCodEmp, strCodCli);

    {********************************}
    {* GRAVA MOVIMENTAÇÃO BANCÁRIA  *}
    {********************************}
    if Result then
    Begin
       strSeqLan := '';
       strSeqLan := fGravaMovimentacaoBancaria(strCtaBai,
                                               strCodPor,
                                               strCodOpe,
                                               dtaDtaLan,
                                               fTime(),
                                               strNumDup,
                                               'CC',
                                               'C',
                                               VS_strCodEmp,
                                               fltValCre,
                                               'REF. LANC. CREDITO ANTEC. DE RECEBIVEIS',
                                               strCodCli,
                                               intSeqCon);

       pAtualizarSequencialMovBanInclusaoCredito(strSeqRec, strSeqLan);

       Result := (strSeqLan <> '');

       strCCGerado := strNumDupli;
    End;

    // GRAVA NA TABELA ANTREC -> OS DADOS REFERENTES AOS CREDITOS GERADOS PELA ANTECIPAÇÃO DOS RECEBIVEIS
    if result then
       Result := (fGravaRelacionaisAntecRecebiveis( strNumDup, 'A', strNumDupli, strCodCli, strCodEmp, strSeqLan, 'CC', -fltValCre, strCtaBai, strCodPor ) <> '');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

function TfrmCtrAntecipacaoRecebiveis.fGravaMovimentacaoBancaria( strCodCta  : String;            // Centro de Custo
                                                                  strCodPor  : String;            // Portador
                                                                  strOper    : String;            // Operador
                                                                  dtaDtaLan  : TDate;             // Data do Lançamento
                                                                  horHorLan  : TTime;             // Hora do Lançamento
                                                                  strNumDoc  : String;            // Documento
                                                                  strEspdoc  : String;            // Especie do Documento
                                                                  strTipo    : String;            // 'C' = Credito / 'D' = Debito
                                                                  strCodEmp  : String;            // Empresa
                                                                  fltValLan  : Double;            // Valor Documento
                                                                  strHis     : String;            // Historico 1
                                                                  strCodCli  : String;            // Cliente
                                                                  IntSeqCon  : Integer ): String; // Sequencial Duplicata

Var
  strSeqLan : String;
  lstBanLog : TBanCtrRepository;
begin

  lstBanLog := TBanCtrRepository.Create;

  lstBanLog.fAdd(strNumDoc,
                 'A',
                 strEspdoc,
                 strCodEmp,
                 strCodCli,
                 strHis,
                 '',
                 intSeqCon,
                 fltValLan);

  strSeqLan := fGravaMovBan( strCodCta,           // Centro de Custo
                             strCodPor,           // Portador
                             strOper,             // Operador            *** strLoginUsuarioLogado,
                             dtaDtaLan,           // Data do Lançamento
                             horHorLan,           // Hora do Lançamento
                             strNumDoc,           // Documento
                             strTipo,             // Credito / Debito
                             strCodEmp,           // Empresa
                             fltValLan,           // Valor Documento
                             strHis,              // Historico 1
                             '',                  // Historico 2
                             strCodCli,           // Cliente
                             '',                  // Fornecedor
                             '',                  // Numero da Duplicata
                             IntSeqCon,           // Sequencial Duplicata
                             '',                  // Parcela da Duplicata
                             '',                  // Empresa da Duplicata
                             '',                  // Série
                             //'',                // Sequencial de Lançamento
                             '',                  // Código do Evento
                             '',                  // Documento da Baixa
                             lstBanLog.fGetList );// Log Bancário

  //Result := (Not fEmptyStr(strSeqLan));
  Result := strSeqLan;

  FreeAndNil(lstBanLog);
end;

function TfrmCtrAntecipacaoRecebiveis.fCriacdsValoresCalc : TUniClientDataSet;
Begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ANT_ESPORI'; // ESPECIE ORIGINAL
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_VLRORI';  // VALOR ORIGINAL INFORMADO
    DataType  := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_VLRCAL';  // VALOR CALCULADO
    DataType  := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_PRCDSC';  // PERCENTUAL DE DESCONTO
    DataType  := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_VLRDSC';  // VALOR DESCONTADO
    DataType  := ftFloat;
    Precision := 2;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ANT_NROCHQ'; // NRO CHEQUE, PREENCHIDO QDO FOR CHEQUE
    DataType := ftString;
    Size     := 20;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ANT_NOMCAR'; // NOME CARTAO, PREENCHIDO QDO FOR CARTAO
    DataType := ftString;
    Size     := 50;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ANT_DTAVEN'; // DATA VENCIMENTO, PREENCHIDO SEMPRE
    DataType := ftDate;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_DIACAL';  // DIAS PARA CALCULO DE JUROS
    DataType  := ftInteger;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name      := 'ANT_TXJURD';   // TAXA DE JUROS DIARIA
    DataType  := ftFloat;
  End;

  Result.CreateDataSet;

End;

end.


