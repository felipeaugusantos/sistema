unit untCadPag;

interface

uses

  Classes, DB, Uni, frxClass, frxDMPExport, frxDBSet, Forms, RLFilters, RLTypes,
  RLDraftFilter, untFuncoesSimples, UniClientDataSet, UniDataSetProvider, frxDMPClass,
  untCtaDet;

Var
  FCamposCadPag,
  FCamposNovoCadPag,
  FParametrosNovoCadPag: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTP_DINHEI', 'CTP_CARTAO', 'CTP_CHQAVI', 'CTP_CHQPRE',
                                            'CTP_ORDPAG'];

  FArrEspPagas: Array of String = ['CTP_DINHEI', 'CTP_CARTAO', 'CTP_CHQAVI', 'CTP_CHQPRE', 'CTP_ORDPAG','CTP_REPCHQ'];


Type
  TDuplicataCtp = Record
    strNumDup: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodFor: String;
    strUsoCon: String;
    strSerie_: String;
End;

Type
  PTDuplicataCtp = ^TDuplicataCtp;

type
  TParametrosDesmembraValoresCtaDet = class
  strict private
    FstrCodCta: string;
  private
    procedure SetStrCodCta(pStrValue: string);
  public
    var
      strNumCta: String;
      strCodEve: String;
      frmCadPag: TForm;
      fltValDup: Double;
      strCodEmp: string;
      cdsTemp: TUniClientDataSet;
      blnDireto: Boolean;

    property strCodCta: string read FstrCodCta;
  end;

  TParametrosDesmembraValores = class
  strict private
    FstrCodCta: string;
  private
    procedure SetStrCodCta(pStrValue: string);
  public
    var
      strNumCta: String;
      strCodEve: String;
      fltValDup: Double;
      strCodEmp: string;
      cdsTemp: TUniClientDataSet;
      blnDireto: Boolean;
      strAutoin: String;

    property strCodCta: string read FstrCodCta;
  end;

  TParametrosContasAPagar = class
  private
    FstrNomeFormLogCtp: string;
    FstrDescricaoLotCtp: string;
    FstrCodCta: string;
    FstrDtaVenc: string;
    FstrHistorico: string;
    FstrCodPor: string;
    FstrCodFor: string;
    FstrNumDoc: string;
    FfltValorDupli: Double;
    FstrParcela: string;
    FstrDeposito: string;
    FstrPrevisao: string;
    FstrVeioNF: string;
    FstrUsaCheque: string;
    FstrPagAntecipado: string;
    FstrUsoEConsumo: string;
    FstrVeioBoleto: string;
  public
    property strNomeFormLogCtp: string read FstrNomeFormLogCtp write FstrNomeFormLogCtp;
    property strDescricaoLotCtp: string read FstrDescricaoLotCtp write FstrDescricaoLotCtp;
    property strCodCta: string read FstrCodCta write FstrCodCta;
    property strDtaVenc: string read FstrDtaVenc write FstrDtaVenc;
    property strHistorico: string read FstrHistorico write FstrHistorico;
    property strCodPor: string read FstrCodPor write FstrCodPor;
    property strCodFor: string read FstrCodFor write FstrCodFor;
    property strNumDoc: string read FstrNumDoc write FstrNumDoc;
    property fltValorDupli: Double read FfltValorDupli write FfltValorDupli;
    property strParcela: string read FstrParcela write FstrParcela;
    property strDeposito: string read FstrDeposito write FstrDeposito;
    property strPrevisao: string read FstrPrevisao write FstrPrevisao;
    property strVeioNF: string read FstrVeioNF write FstrVeioNF;
    property strUsaCheque: string read FstrUsaCheque write FstrUsaCheque;
    property strPagAntecipado: string read FstrPagAntecipado write FstrPagAntecipado;
    property strUsoEConsumo: string read FstrUsoEConsumo write FstrUsoEConsumo;
    property strVeioBoleto: string read FstrVeioBoleto write FstrVeioBoleto;
  End;

  function fGravaCadPag(strNomFrmLogCtp,
                        strDescriLogCtp,
                        strCodFor,
                        strNumDup,
                        strParcel,
                        strCodEmp,
                        strCodCta,
                        strSerie: String;
                        intSeqBai: Integer;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri: Double;
                        strPrevis,
                        strVeiobo,
                        strDeposi,
                        strHist01,
                        strHist02,
                        strHisbai,
                        strPorBai,
                        strCtaBai,
                        strDocBai,
                        strOpeBai: String;
                        dtaDtaPag: TDateTime;
                        fltValPag,
                        fltValJur,
                        fltValDes: Double;
                        strEmpGer,
                        strCodEve,
                        strUsaChq,
                        strCodPor,
                        strNumDoc: String;
                        fltJurSuj,
                        fltDesSuj: Double;
                        intSeqCon: Integer;
                        blnResCai: Boolean = False;
                        intRcxCon: Integer = 0;
                        strTipDoc: String = '';
                        fltVendor: Double  = 0;
                        strVeioNF: String = '';
                        strNotEnt: String = '';
                        strNotTip: String = '';
                        strCTPCom: String = '';
                        strAutInc: String = '';
                        strDocTer: String = '';
                        strEspTer: String = '';
                        strEmpTer: String = '';
                        strCliTer: String = '';
                        strUsoCon: String = '';
                        strCompet: String = '';
                        strCodCliUC: String = '';
                        strNumDocUC: String = '';
                        strEspDocUC: String = '';
                        strCodEmpUC: String = '';
                        fltDinhei: Double = 0;
                        fltChqAvi: Double = 0;
                        fltOrdPag: Double = 0;
                        fltRepChq: Double = 0;
                        strCodVen: String = '';
                        fltJurAnt: Double = 0;
                        fltDesAnt: Double = 0;
                        strLinDig: String = '';
                        strCodBar: String = '';
                        strAutCtp: String = '';
                        strNFNumDup: String = '';
                        strAutIncBaixaEmprestimo: String = '';
                        strQ_Guia: String = '0';
                        strCodRec: String = '';
                        strBcoFor: String = '';
                        strAutIncLogCTP: String = '';
                        strCodPrj: String = '';
                        strPagAntecipado: String = 'N';
                        strAutIncFunrural: String = '';
                        strGnreNumeroDocumento: String = '';
                        strGnreChaveDeAcesso: String = '';
                        strGnreNumeroDeControle: String = '';
                        dtaGnreDataPrevisaoPagamento: TDateTime = 0;
                        strGnreConvenio: String = '';
                        fltMulSuj : Double = 0;
                        strAutIncPix: String = '';
                        fltGrvOri: Double = 0;
                        ADtaLiberacao: TDAteTime = 0;
                        AHorLiberacao: TDateTime = 0;
                        AOpeLiberacao: String = '';
                        strGnreChaveDeApuracao: String = '';
                        AIncCadFis: string = '';
                        strQrCode: string = '';
                        AUsaMca: String = ''): Boolean;

  procedure pBaixaTotal(strNumDup,
                        strParcel,
                        strCodEmp,
                        strCodFor,
                        strSerie: String;
                        fltValDup,
                        fltValPag: Double;
                        dtaDtaPag: TDateTime;
                        strPorBai,
                        strHisBai,
                        strHist02,
                        strDocBai,
                        strCtaBai,
                        strOpeBai,
                        strNumDoc,
                        strTipDes: String;
                        intSeqCon: Integer;
                        fltVendor: Double  = 0;
                        intResCai: Integer = 0;
                        intCrxCon: Integer = 0;
                        intSeqRCH: Integer = 0;
                        fltDinhei: Double  = 0;
                        fltChqAvi: Double  = 0;
                        fltOrdPag: Double  = 0;
                        fltRepChq: Double  = 0;
                        fltValJur: Double  = 0;
                        fltValDes: Double  = 0;
                        fltOutEnt: Double  = 0;
                        fltValMul: Double  = 0);

procedure pBaixaParcial(strNomFrmLogCtp,
                        strDescriLogCtp,
                        strNumDup,
                        strParcel,
                        strCodEmp,
                        strCodFor,
                        strSerie: String;
                        dtaDtaPag: TDateTime;
                        fltValPag: Double;
                        strPorBai,
                        strHisBai,
                        strHist02,
                        strDocBai,
                        strCtaBai,
                        strOpeBai,
                        strNumDoc,
                        strTipDes: String;
                        intSeqCon: Integer;
                        intResCai: Integer = 0;
                        intCrxCon: Integer = 0;
                        intSeqRCH: Integer = 0;
                        fltDinhei: Double = 0;
                        fltChqAvi: Double = 0;
                        fltOrdPag: Double = 0;
                        fltRepChq: Double = 0;
                        fltOutEnt: Double = 0;
                        fltGrvOri: Double = 0;
                        blnVerificaValorAntesDeGerarResto: Boolean = False);

  function fBuscaHist(strNumDup, strParcel, strCodEmp, strCodFor:String;strSerie:String=''):String;

  procedure ImprimeCP(strNumDup,
                      strParcel,
                      strCodEmp,
                      strCodFor,
                      strSerie,
                      strNomForm: String;
                      blnReimpressao: Boolean = False;
                      blnOrdena: Boolean = True);

  procedure pEfetuaImpressao(blnReimpressao: Boolean; strNomForm: String; blnImpSel : Boolean=False);

  function fRetSeqBaiCadPag(strNumDup,
                            strParcel,
                            strCodEmp,
                            strCodFor,
                            strSerie: String): Integer;

  function fDuplicataCtpBaixada(strNumDup, strParcel,
    strCodEmp, strCodFor, strSerie: String; intSeqBai: Integer): Boolean;

  function fGravaDupAgp(strNumAgr,
                        strNumDup,
                        strParcel,
                        strSerie_,
                        strPrevis: String;
                        intSeqBai: Integer;
                        strCodFor,
                        strCodEmp: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri: Double;
                        strHist01,
                        strHist02,
                        strCodVen,
                        strCodVel,
                        strCodCta,
                        strEmpAgr: String;
                        fltJurSuj,
                        fltDesSuj: Double;
                        intNCaixa: Integer;
                        fltVendor: Double;
                        strTipoDocumento : Integer;
                        strTipoGuia,
                        strCodigoGuia,
                        strCodigoEvento : String;
                        blUsaCheque : Boolean;
                        strUsoCon: String = '';
                        strNumDDA: String = '';
                        strAutOri: String = '';
                        strDeposi: String = '';
                        strCodPor: String = '';
                        strBcoFor: String = '';
                        strVeioNF: String = '';
                        fltMulSuj: Double = 0;
                        blUsaCartao : Boolean = false): Boolean;

  function fVerificaNumAgr(strNumAgr, strCodFor, strC_G_C_: String): Boolean;
  function EntradaDeMercadoriaQueNaoChegouNaEmpresa(ANumDup,ASerie,ACodEmp,ACodFor: String): Boolean;

  procedure GeraListaDeCamposCADPAG();
  function VerificaSeTemVariasEspeciesPagto(AAutoIncrem: String) : Boolean;
  procedure DesmembraDuplicatasPagarPorEspecie(AAutoIncrem: String);

  function fRetAutIncCadPagAgr(strNomeTabela,
                               strTabelaCadPag,
                               strNumAgr: String): TStringList;

  function fDeletaDuplicatasAgr(strNumAgr, strCodFor: String): Boolean;

  function fDeletaDupAgr(strNumAgr, strCodFor: String; ANomFrm : String = ''): Boolean;

  function fVerificaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var blnRatEve : Boolean): Boolean;
  function fVerificaEvenRat(ACtpDet: TDataset): Boolean;

  procedure pGravaLogCtpDet(AstrAutoIncremento, strDescricaoLog, strNomForm: String);

  Function fDesmembraValoresCtaDet(poParametros: TParametrosDesmembraValoresCtaDet): Boolean; overload;

  Function fDesmembraValoresCtaDet(poParametros: TParametrosDesmembraValores): Boolean; overload;

  function fGravaFatorCalculado(ANumeroDuplicata,
                                AParcela,
                                ACodigoEmpresa,
                                ACodigoFornecedor,
                                ASerie: String;
                                ADatasetCTPDet: TDataset;
                                ANomeFormulario: String;
                                ADatasetNovo: Boolean): Boolean;

  procedure AlteraChaveCtpDet(AChaveAnterior,
                              ANovaChave: TDuplicataCtp;
                              ANomeFormulario: String);

  function RetornaRecordChaveDuplicata(ANumeroDuplicata,
                                       AParcela,
                                       ACodigoEmpresa,
                                       ACodigoFornecedor,
                                       ASerie: String): TDuplicataCtp;

  function HouveAlteracaoCTPDet(ADatasetCTPDet,
                                ADatasetTemporarioCTPDet: TDataset): Boolean;

  function fVerificaSeTodasContasSaoIguais(cdsTemp: TUniClientDataSet): Boolean;
  function fVerificaSeTodosEventosSaoIguais(cdsTemp: TUniClientDataSet): Boolean;

  procedure pCriaClientTemporariaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var cdsTemp: TUniClientDataSet); OverLoad;

  procedure pCriaClientTemporariaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var cdsTemp, ACtpDet: TUniClientDataSet); OverLoad;

  procedure pInicializaImpressaoCP;

  procedure pAdicionaImpressaoCP(strNumDup,
                                 strParcel,
                                 strCodFor,
                                 strSerie_,
                                 strNomFrm: String);

  function fApagaDuplicataContasPagar(qryTabCadPag: TUniQuery; strNomeFormulario: String; strDescri: String = ''): Boolean;
  function FornecedorPossuiPagamentosAntecipados(ACodFor: String): Boolean;

  procedure pImprimeCPs;

  function fLoadReport : Boolean;

  procedure pVerificaImpressao(blnReimpressao: Boolean; strNomForm: String);


  function getSQLDadosBancariosFornecedor(ASelecionaChavesPIX: Boolean = False): String;

  function fRetornaUltimaAlteracaoDuplicataCTP(strNumDup, strParcel, strSerie_, strCodFor,
                                               strCodEmp: String; intSeqBai: Integer = 0): TDateTime;

  function EhAgrupamento(ANumeroDuplicata, AFornecedor, AEmpresa: String): Boolean;
  function DeleteCtpDet(ANomFrm: String; ACtpDet: TDataSet): Boolean;

  {TABELA QUE LIGA A CADPAG COM A COMPRO MT: 193676}
  function GravarCTPCOM(ANumDup,AParcel,ASerie_,ACodFor,ACodEmp, AComPro : String): Boolean;

  function fGravarContasAPagar(objParametros: TParametrosContasAPagar): Boolean;

  function RetornaSQLCamposTabelaTemporaria: String;

  function ExcluirDuplicataGeradaDeKMRodados(AChaveDuplicata: String; ASeqBai : Integer;
                                           ALimpar: Boolean = False): Boolean;

  function DuplicataGeradaDeKMRodados(AChaveDuplicata: String): Boolean;
  procedure AtualizarChaveKMRodados(AChaveAntiga, AChaveNova: String);

  function fGetValOriDuplicata(strNumDup,
                               strSerie,
                               strCodEmp,
                               strParcel,
                               strCodFor: String): Double;

  //MF: 286456  - 02/06/2023
  function fCPJaImpresso(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String): Boolean;


  function IncluidoPeloLivroFiscal(ANumeroDuplicata, AParcela, ASerie, ACodigoEmpresa, ACodigoFornecedor: String): Boolean;

  procedure ApagaDuplicataRETDDA(AAutoIncremCadPag: String);
  function fValidaEventosCFGContabil( ADatasetCTPDet: TDataset; Var stlCodEve: TStringList ): Boolean;
  procedure pInformaEventosInvalidosListaContabilidade( stlCodEve: TStringList );

  function fGravaDadosREINF(strAutoInc, strNumDup, strCodFor, strParcel, strCodEmp, strSerie, strCodNatReinf, strCodServReinf : String; strSeqBai : Integer) : Boolean;

  Function InsereDadosREINF(AAutoInc, ANumeroDuplicata, AFornecedor, AParcela, ACodigoEmpresa, ASerie, ACodNatReinf, ACodServReinf : string; ASeqBai : Integer) : Boolean;
  Function AlteraDadosREINF(AAutoInc, ANumeroDuplicata, AFornecedor, AParcela, ACodigoEmpresa, ASerie, ACodNatReinf, ACodServReinf : string) : Boolean;
  Function DeletaDadosREINF(AAutoInc : String) : Boolean;
  procedure pRetornaDadosREINF(strNumDoc, strCodEmp, strCodFor, ASerie, AParcel : String; ASeqBai: Integer; var ACodNat, ACodServ, AAutoInc : String);
  function fVerificaReinfCtp(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; strSeqBai : Integer; var sAutoInc: String): Boolean;
  function fDescontoMaiorQueDuplicata(AValorDesconto, AValorOriginal, AValorTotal: Double): Boolean;

  Var
    arrImpressaoCP: Array Of TarrImpressaoCP;

implementation

uses SysUtils, Variants,StrUtils, untCfgRel, untQckCtpCompPgtoMod, untConstantes,
  untTCadPag, untLogCtp, untTCadPagRepository, untModulo, untTCtpDet,
  untTCtpDetRepository, untLogCtpDet;

Var
  blnPedirFilaImp: Boolean;
  strNomImp : String;
  strTipImp : String;
  blnVerificaImpressao: Boolean;

procedure TParametrosDesmembraValoresCtaDet.SetStrCodCta(pStrValue: string);
begin
  FstrCodCta := pStrValue;
end;

function fGravaCadPag(strNomFrmLogCtp,
                      strDescriLogCtp,
                      strCodFor,
                      strNumDup,
                      strParcel,
                      strCodEmp,
                      strCodCta,
                      strSerie: String;
                      intSeqBai: Integer;
                      dtaDtaCad,
                      dtaDtaVen: TDateTime;
                      fltValDup,
                      fltValOri: Double;
                      strPrevis,
                      strVeiobo,
                      strDeposi,
                      strHist01,
                      strHist02,
                      strHisbai,
                      strPorBai,
                      strCtaBai,
                      strDocBai,
                      strOpeBai: String;
                      dtaDtaPag: TDateTime;
                      fltValPag,
                      fltValJur,
                      fltValDes: Double;
                      strEmpGer,
                      strCodEve,
                      strUsaChq,
                      strCodPor,
                      strNumDoc: String;
                      fltJurSuj,
                      fltDesSuj: Double;
                      intSeqCon: Integer;
                      blnResCai: Boolean = False;
                      intRcxCon: Integer = 0;
                      strTipDoc: String = '';
                      fltVendor: Double  = 0;
                      strVeioNF: String = '';
                      strNotEnt: String = '';
                      strNotTip: String = '';
                      strCTPCom: String = '';
                      strAutInc: String = '';
                      strDocTer: String = '';
                      strEspTer: String = '';
                      strEmpTer: String = '';
                      strCliTer: String = '';
                      strUsoCon: String = '';
                      strCompet: String = '';
                      strCodCliUC: String = '';
                      strNumDocUC: String = '';
                      strEspDocUC: String = '';
                      strCodEmpUC: String = '';
                      fltDinhei: Double = 0;
                      fltChqAvi: Double = 0;
                      fltOrdPag: Double = 0;
                      fltRepChq: Double = 0;
                      strCodVen: String = '';
                      fltJurAnt: Double = 0;
                      fltDesAnt: Double = 0;
                      strLinDig: String = '';
                      strCodBar: String = '';
                      strAutCtp: String = '';
                      strNFNumDup: String = '';
                      strAutIncBaixaEmprestimo: String = '';
                      strQ_Guia: String = '0';
                      strCodRec: String = '';
                      strBcoFor: String = '';
                      strAutIncLogCTP: String = '';
                      strCodPrj : String = '';
                      strPagAntecipado: String = 'N';
                      strAutIncFunrural: String = '';
                      strGnreNumeroDocumento: String = '';
                      strGnreChaveDeAcesso: String = '';
                      strGnreNumeroDeControle: String = '';
                      dtaGnreDataPrevisaoPagamento: TDateTime = 0;
                      strGnreConvenio: String = '';
                      fltMulSuj : Double = 0;
                      strAutIncPix: String = '';
                      fltGrvOri: Double = 0;
                      ADtaLiberacao: TDAteTime = 0;
                      AHorLiberacao: TDateTime = 0;
                      AOpeLiberacao: String = '';
                      strGnreChaveDeApuracao: String = '';
                      AIncCadFis: string = '';
                      strQrCode: string = '';
                      AUsaMca: String = ''): Boolean;

  Var
    qryTblCadPag: TUniQuery;
    LAtualizaCamposLiberacao: Boolean;
begin

  Result := True;

  qryTblCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE');

  Try
    If fEmptyStr(strAutInc) Then
      strAutInc := fRetAutoIncrem('CADPAG', strCodEmp);

    With qryTblCadPag Do
    Begin

      If (Not Active) Then
        Open;

      Insert;
      FieldByName('CTP_CODFOR').AsString   := strCodFor;
      FieldByName('CTP_NUMDUP').AsString   := strNumDup;
      FieldByName('CTP_PARCEL').AsString   := strParcel;
      FieldByName('CTP_CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strSerie) Then
        FieldByName('CTP_SERIE_').AsString := ''
      Else
        FieldByName('CTP_SERIE_').AsString   := strSerie;

      FieldByName('CTP_CODCTA').AsString   := strCodCta;
      FieldByName('CTP_SEQBAI').AsInteger  := intSeqBai;
      FieldByName('CTP_DTACAD').AsDateTime := dtaDtaCad;
      If dtaDtaCad = 0 Then
        FieldByName('CTP_DTACAD').Clear;
      FieldByName('CTP_DTAVEN').AsDateTime := dtaDtaVen;
      FieldByName('CTP_VALDUP').AsFloat    := fltValDup;
      FieldByName('CTP_VALORI').AsFloat    := fltValOri;
      FieldByName('CTP_PREVIS').AsString   := strPrevis;
      FieldByName('CTP_VEIOBO').AsString   := strVeiobo;
      FieldByName('CTP_HIST01').AsString   := strHist01;
      FieldByName('CTP_HIST02').AsString   := strHist02;
      FieldByName('CTP_HISBAI').AsString   := LeftStr(strHisBai, 50);

      If fEmptyStr(StrCompet) then
        FieldByName('CTP_COMPET').AsString := FormatDateTime('mm/YYYY',dtaDtaCad)
      else
        FieldByName('CTP_COMPET').AsString := strCompet;

      If fEmptyStr(strPorBai) Then
        FieldByName('CTP_PORBAI').Value := Null
      Else
        FieldByName('CTP_PORBAI').AsString   := strPorBai;

      If fEmptyStr(strCodPrj) Then
        FieldByName('CTP_CODPRJ').Value := Null
      Else
        FieldByName('CTP_CODPRJ').AsString   := strCodPrj;

      FieldByName('CTP_DOCBAI').AsString   := strDocBai;

      If (fEmptyStr(strCtaBai)) Then
        FieldByName('CTP_CTABAI').Value := Null
      Else
        FieldByName('CTP_CTABAI').AsString := strCtaBai;

      If (fEmptyStr(strOpeBai)) Then
        FieldByName('CTP_OPEBAI').Value := Null
      Else
        FieldByName('CTP_OPEBAI').AsString := strOpeBai;

      If dtaDtaPag = 0 Then
        FieldByName('CTP_DTAPAG').Value := Null
      Else
      Begin
        FieldByName('CTP_DTAPAG').AsDateTime := dtaDtaPag;
        FieldByName('CTP_DTABAI').AsDateTime := VS_DATE;
      End;

      LAtualizaCamposLiberacao := (fCfgSis('CTPLBB', varBoolean)) And (fCfgSis('LIBDPA', varBoolean));

      FieldByName('CTP_DTALIB').Value := Null;
      FieldByName('CTP_HORLIB').Value := Null;
      FieldByName('CTP_OPELIB').Value := Null;

      If ADtaLiberacao <> 0 Then
      Begin
        If LAtualizaCamposLiberacao Then
          FieldByName('CTP_DTALIB').AsDateTime := ADtaLiberacao;
      End;

      If AHorLiberacao <> 0 Then
      Begin
        If LAtualizaCamposLiberacao Then
          FieldByName('CTP_HORLIB').AsDateTime := AHorLiberacao;
      End;

      If Not (AOpeLiberacao.IsEmpty) Then
      Begin
        If LAtualizaCamposLiberacao Then
          FieldByName('CTP_OPELIB').AsString := AOpeLiberacao;
      End;

      FieldByName('CTP_VALPAG').AsFloat    := fltValPag;
      FieldByName('CTP_VALJUR').AsFloat    := fltValJur;
      FieldByName('CTP_VALDES').AsFloat    := fltValDes;
      FieldByName('CTP_EMPGER').AsString   := strEmpGer;

      If (fEmptyStr(strCodEve)) Then
        FieldByName('CTP_CODEVE').Value := Null
      Else
        FieldByName('CTP_CODEVE').AsString := strCodEve;

      FieldByName('CTP_USACHQ').AsString := strUsaChq;
      FieldByName('CTP_USAMCA').AsString := AUsaMca;

      If Not fEmptyStr(strCodVen) Then
      begin
        FieldByName('CTP_CODVEN').Value := strCodVen;
      end
      else
      If fEmptyStr(strLoginUsuarioLogado) Then
      begin
        FieldByName('CTP_CODVEN').Value := Null;
      end
      Else
      begin
        FieldByName('CTP_CODVEN').AsString := strLoginUsuarioLogado;
      end;

      FieldByName('CTP_NUMDOC').AsString := strNumDoc;

      If fEmptyStr(strCodPor) Then
        FieldByName('CTP_CODPOR').Value := Null
      Else
        FieldByName('CTP_CODPOR').AsString := strCodPor;

      If fEmptyStr(strLinDig) Then
        FieldByName('CTP_LINDIG').Value := Null
      Else
        FieldByName('CTP_LINDIG').AsString := strLinDig;

      If fEmptyStr(strCodBar) Then
        FieldByName('CTP_CODBAR').Value := Null
      Else
        FieldByName('CTP_CODBAR').AsString := strCodBar;

      FieldByName('CTP_JURSUJ').AsFloat  := fltJurSuj;
      FieldByName('CTP_MULSUJ').AsFloat  := fltMulSuj;
      FieldByName('CTP_VENDOR').AsFloat  := fltVendor;
      FieldByName('CTP_DESSUJ').AsFloat  := fltDesSuj;

      FieldByName('CTP_DINHEI').AsFloat  := fltDinhei;
      FieldByName('CTP_CHQAVI').AsFloat  := fltChqAvi;
      FieldByName('CTP_ORDPAG').AsFloat  := fltOrdPag;
      FieldByName('CTP_REPCHQ').AsFloat  := fltRepChq;

      FieldByName('AUTOINCREM').AsString := strAutInc;

      If dtaDtaPag <> 0 Then
      Begin
        FieldByName('CTP_SEQCON').AsInteger := intSeqCon;
        FieldByName('CTP_EMPBAI').AsString  := VS_strCodEmp;
      End Else
      Begin
        FieldByName('CTP_SEQCON').Clear;
        FieldByName('CTP_EMPBAI').Clear;
      End;
      
      FieldByName('CTP_DEPOSI').AsString := strDeposi;

      FieldByName('CTP_RESCAI').AsInteger := IIF(blnResCai, 1, 0);

      If intRcxCon > 0 Then
        FieldByName('CTP_RCXCON').AsInteger := intRcxCon;

      If fEmptyStr(strTipDoc) Then
        FieldByName('CTP_TIPDOC').Value    := Null
      Else
        FieldByName('CTP_TIPDOC').AsString := strTipDoc;

      If strNomFrmLogCtp = 'frmAgrupDuplicatasCtp' Then
        FieldByName('CTP_VEIONF').AsString := strVeioNF
      Else If fEmptyStr(strVeioNF) Then
        FieldByName('CTP_VEIONF').AsString := 'S'
      Else
        FieldByName('CTP_VEIONF').AsString := strVeioNF;

      FieldByName('CTP_NOTENT').AsString := strNotEnt;
      FieldByName('CTP_NOTTIP').AsString := strNotTip;
      FieldByName('CTP_CTPCOM').AsString := strCTPCom;

      FieldByName('CTP_DOCTER').AsString := strDocTer;
      FieldByName('CTP_ESPTER').AsString := strEspTer;
      FieldByName('CTP_EMPTER').AsString := strEmpTer;
      FieldByName('CTP_CLITER').AsString := strCliTer;
      FieldByName('CTP_CODOPE').AsString := strLoginUsuarioLogado;

      If (Not fEmptyStr(strUsoCon)) Then
        FieldByName('CTP_USOCON').AsString := strUsoCon;

      FieldByName('CTP_USOCLI').AsString := strCodCliUC;
      FieldByName('CTP_USODOC').AsString := strNumDocUC;
      FieldByName('CTP_USOESP').AsString := strEspDocUC;
      FieldByName('CTP_USOEMP').AsString := strCodEmpUC;

      FieldByName('CTP_JURANT').Value := fltJurAnt;
      FieldByName('CTP_DESANT').Value := fltDesAnt;
      If Not fEmptyStr(strNFNumDup) Then
        FieldByName('CTP_NUMDDA').Value := strNFNumDup;
      If Not fEmptyStr(strAutIncBaixaEmprestimo) Then
        FieldByName('CTP_BE_INC').Value := strAutIncBaixaEmprestimo;
      If Not fEmptyStr(strBcoFor) Then
        FieldByName('CTP_BCOFOR').Value := strBcoFor;

      strAutCtp := FieldByName('AUTOINCREM').Value;

      FieldByName('CTP_Q_GUIA').Value := Null;
      FieldByName('CTP_CODREC').Value := Null;
      if (Not strQ_Guia.IsEmpty) And (strQ_Guia <> '0') then
      begin
        FieldByName('CTP_Q_GUIA').AsString := strQ_Guia;
        FieldByName('CTP_CODREC').AsString := strCodRec;
      end;

      FieldByName('CTP_PAGANT').AsString := strPagAntecipado;

      if not fEmptyStr(strAutIncFunrural) then
        FieldByName('CTP_SEQRFR').AsString := strAutIncFunrural;

      FieldByName('CTP_APUGNR').AsString   := strGnreChaveDeApuracao;
      FieldByName('CTP_GNRDOC').AsString   := strGnreNumeroDocumento;
      FieldByName('CTP_GNRACE').AsString   := strGnreChaveDeAcesso;
      FieldByName('CTP_GNRCNV').AsString   := strGnreConvenio;
      FieldByName('CTP_GNRCTR').AsString   := strGnreNumeroDeControle;
      FieldByName('CTP_GNRDPG').AsDateTime := dtaGnreDataPrevisaoPagamento;
      FieldByName('CTP_QRCODE').AsString   := strQrCode;

      If Not fEmptyStr(strAutIncPix) Then
        FieldByName('CTP_FORPIX').AsString := strAutIncPix;

      If fltGrvOri <> 0 Then
        FieldByName('CTP_GRVORI').AsFloat := fltGrvOri
      Else
        FieldByName('CTP_GRVORI').AsFloat := fltValOri;
      FieldByName('CTP_INCFIS').AsString   := AIncCadFis;
      If fEmptyStr(AIncCadFis) Then
        FieldByName('CTP_INCFIS').Clear;

      Post;
    End;
    FreeAndNil(qryTblCadPag);

    untLogCtp.GravaLogCtp(strAutCtp,
                          strDescriLogCtp,
                          strNomFrmLogCtp,
                          strAutIncLogCTP);
  Except

    On E: Exception Do
    Begin
      If Assigned(qryTblCadPag) Then
        qryTblCadPag.Cancel;
      Result := False;
      If MatchStr(strNomFrmLogCtp,['frmBaixaCartoes']) Then
        Raise Exception.Create(E.Message + ' - [fGravaCadPag]')
      Else
        pMensagensErro(E.Message, '[fGravaCadPag]');

    End;

  End;

end;


procedure pBaixaTotal(strNumDup,
                      strParcel,
                      strCodEmp,
                      strCodFor,
                      strSerie: String;
                      fltValDup,
                      fltValPag: Double;
                      dtaDtaPag: TDateTime;
                      strPorBai,
                      strHisBai,
                      strHist02,
                      strDocBai,
                      strCtaBai,
                      strOpeBai,
                      strNumDoc,
                      strTipDes: String;
                      intSeqCon: Integer;
                      fltVendor: Double  = 0;
                      intResCai: Integer = 0;
                      intCrxCon: Integer = 0;
                      intSeqRCH: Integer = 0;
                      fltDinhei: Double  = 0;
                      fltChqAvi: Double  = 0;
                      fltOrdPag: Double  = 0;
                      fltRepChq: Double  = 0;
                      fltValJur: Double  = 0;
                      fltValDes: Double  = 0;
                      fltOutEnt: Double  = 0;
                      fltValMul: Double  = 0);



  Var
    strSQL     : String;
    qryGen     : TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE CADPAG ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTP_VALORI = CTP_VALDUP, ';
  strSQL := strSQL + '  CTP_VALDUP = 0, ';
  strSQL := strSQL + '  CTP_MOTEST = NULL, ';
  strSQL := strSQL + '  CTP_DTAPAG = :DTAPAG, ';
  strSQL := strSQL + '  CTP_VALPAG = :VALPAG, ';
  strSQL := strSQL + '  CTP_VALDES = :VALDES, ';
  strSQL := strSQL + '  CTP_VALJUR = :VALJUR, ';
  strSQL := strSQL + '  CTP_VALMUL = :VALMUL, ';
  strSQL := strSQL + '  CTP_PORBAI = :PORBAI, ';
  strSQL := strSQL + '  CTP_HISBAI = :HISBAI, ';
  strSQL := strSQL + '  CTP_HIST02 = :HIST02, ';
  strSQL := strSQL + '  CTP_DOCBAI = :DOCBAI, ';
  strSQL := strSQL + '  CTP_CTABAI = :CTABAI, ';
  strSQL := strSQL + '  CTP_OPEBAI = :OPEBAI, ';
  strSQL := strSQL + '  CTP_NUMDOC = :NUMDOC, ';
  strSQL := strSQL + '  CTP_TIPDES = :TIPDES, ';
  strSQL := strSQL + '  CTP_SEQCON = :SEQCON, ';
  strSQL := strSQL + '  CTP_EMPBAI = :EMPBAI, ';
  strSQL := strSQL + '  CTP_SEQRCH = :SEQRCH, ';
  strSQL := strSQL + '  CTP_DINHEI = :DINHEI, ';
  strSQL := strSQL + '  CTP_CHQAVI = :CHQAVI, ';
  strSQL := strSQL + '  CTP_ORDPAG = :ORDPAG, ';
  strSQL := strSQL + '  CTP_REPCHQ = :REPCHQ, ';
  strSQL := strSQL + '  CTP_DTABAI = ' + fCurrentDate + ', ';
  strSQL := strSQL + '  CTP_RESCAI = :RESCAI  ';
  if intCrxCon > 0 Then
    strSQL := strSQL + ',CTP_RCXCON = :RCXCON  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

  If (fEmptyStr(strSerie)) Then
    strSQL := strSQL + '  IFNULL(CTP_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  CTP_SEQBAI = 0 ';

  Try
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (fltValJur = 0) And (fltValDes = 0) And (fltValMul = 0) Then
      Begin
        If (fltValDup + fltVendor + fltOutEnt > fltValPag) Then
          fltValDes := (fltValDup + fltVendor + fltOutEnt) - fltValPag
        Else
          fltValJur := fltValPag - fltValDup - fltVendor - fltOutEnt;
      End;

      {*****************************************}
      {* DADOS QUE SERÃO ALTERADOS             *}
      {**************************************MV*}
      ParamByName('VALPAG').AsFloat    := fltValPag;
      ParamByName('DTAPAG').AsDateTime := dtaDtaPag;
      ParamByName('VALDES').AsFloat    := fltValDes;
      ParamByName('VALJUR').AsFloat    := fltValJur;
      ParamByName('VALMUL').AsFloat    := fltValMul;

      If (fEmptyStr(strPorBai)) Then
        ParamByName('PORBAI').Value := Null
      Else
        ParamByName('PORBAI').AsString   := strPorBai;

      ParamByName('HISBAI').AsString   := LeftStr(strHisBai, 50);
      ParamByName('HIST02').AsString   := strHist02;
      ParamByName('DOCBAI').AsString   := strDocBai;
      ParamByName('RESCAI').AsInteger  := intResCai;
      ParamByName('NUMDOC').AsString   := strNumDoc;

      If intSeqRCH > 0 Then
        ParamByName('SEQRCH').AsInteger := intSeqRCH
      Else ParamByName('SEQRCH').Value := Null;

      if intCrxCon > 0 Then
        ParamByName('RCXCON').AsInteger  := intCrxCon;

      If (fEmptyStr(strCtaBai)) Then
        ParamByName('CTABAI').Value := Null
      Else
        ParamByName('CTABAI').AsString := strCtaBai;

      If (fEmptyStr(strOpeBai)) Then
        ParamByName('OPEBAI').Value := Null
      Else
        ParamByName('OPEBAI').AsString := strOpeBai;

      If fEmptyStr(strTipDes) Then
        ParamByName('TIPDES').Value    := Null
      Else
        ParamByName('TIPDES').AsString := strTipDes;

      {*****************************************}
      {* DADOS REFERENTES AO FILTRO            *}
      {**************************************MV*}
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;

      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString := strSerie;

      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('EMPBAI').AsString  := VS_strCodEmp;

      ParamByName('DINHEI').AsFloat := fltDinhei;
      ParamByName('CHQAVI').AsFloat := fltChqAvi;
      ParamByName('ORDPAG').AsFloat := fltOrdPag;
      ParamByName('REPCHQ').AsFloat := fltRepChq;

      ExecSQL;
      Close;
      FreeAndNil(qryGen);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

{*****************************************}
{* BAIXA A DUPLICATA PARCIALMENTE        *}
{**************************************MV*}
procedure pBaixaParcial(strNomFrmLogCtp,
                        strDescriLogCtp,
                        strNumDup,
                        strParcel,
                        strCodEmp,
                        strCodFor,
                        strSerie: String;
                        dtaDtaPag: TDateTime;
                        fltValPag: Double;
                        strPorBai,
                        strHisBai,
                        strHist02,
                        strDocBai,
                        strCtaBai,
                        strOpeBai,
                        strNumDoc,
                        strTipDes: String;
                        intSeqCon: Integer;
                        intResCai: Integer = 0;
                        intCrxCon: Integer = 0;
                        intSeqRCH: Integer = 0;
                        fltDinhei: Double = 0;
                        fltChqAvi: Double = 0;
                        fltOrdPag: Double = 0;
                        fltRepChq: Double = 0;
                        fltOutEnt: Double = 0;
                        fltGrvOri: Double = 0;
                        blnVerificaValorAntesDeGerarResto: Boolean = False);
  Var
    strSQL: String;
    intSeqBai: Integer;
    dtaDtaVen: TDateTime;
    fltNovoValDup, fltNovoValOri,
    fltDesSuj,
    fltJurSuj,
    fltVendor,
    fltMulSuj: Double;
    qryGenPag, qryGen: TUniQuery;
    strHist01: String;
    strHistAnt : String;
    strVeioNota: String;
begin
  intSeqBai := fRetSeqBaiCadPag(strNumDup,
                                strParcel,
                                strCodEmp,
                                strCodFor,
                                strSerie);

  Inc(intSeqBai);

  {*****************************************}
  {* SALVA DADOS DA DUPLICATA ANTES DE     *}
  {* BAIXAR                                *}
  {**************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM CADPAG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

  If (fEmptyStr(strSerie)) Then
    strSQL := strSQL + '  IFNULL(CTP_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  CTP_DTAPAG IS NULL ';

  qryGenPag := fCriaQuery;
  With qryGenPag Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;

    If (Not fEmptyStr(strSerie)) Then
      ParamByName('SERIE_').AsString := strSerie;
    Open;

    fltDesSuj := FieldByName('CTP_DESSUJ').AsFloat;
    fltJurSuj := FieldByName('CTP_JURSUJ').AsFloat;
    fltMulSuj := FieldByName('CTP_MULSUJ').AsFloat;
    strVeioNota := FieldByName('CTP_VEIONF').AsString;

    if not fEmptyStr(qryGenPag.FieldByName('CTP_HISBAI').AsString) then
      strHistAnt := qryGenPag.FieldByName('CTP_HISBAI').AsString + ','
    else
      strHistAnt := '';
    fltVendor := FieldByName('CTP_VENDOR').AsFloat;
  End;

  strHist01     := qryGenPag.FieldByName('CTP_HIST01').AsString +
                   ' - PAGTO.PARCIAL - DTA. PGTO.: ' + FormatDateTime('dd/mm/yyyy', dtaDtaPag) +
                   ' - VR. ORIGINAL: ' + FormatFloat('#,##0.00', qryGenPag.FieldByName('CTP_VALDUP').AsFloat) +
                   ' - VR. PAGO: ' + FormatFloat('#,##0.00', fltValPag);

  {*****************************************}
  {* BAIXA A DUPLICATA...                  *}
  {**************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'UPDATE CADPAG ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTP_VALANT = CTP_VALDUP, ';
  strSQL := strSQL + '  CTP_JURANT = CTP_JURSUJ, ';
  strSQL := strSQL + '  CTP_MULANT = CTP_MULSUJ, ';
  strSQL := strSQL + '  CTP_DESANT = CTP_DESSUJ, ';
  strSQL := strSQL + '  CTP_MOTEST = NULL, ';
  strSQL := strSQL + '  CTP_VALDUP = 0, ';
  strSQL := strSQL + '  CTP_JURSUJ = 0, ';
  strSQL := strSQL + '  CTP_MULSUJ = 0, ';
  strSQL := strSQL + '  CTP_DESSUJ = 0, ';
  strSQL := strSQL + '  CTP_DTAPAG = :DTAPAG, ';
  strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI, ';
  strSQL := strSQL + '  CTP_VALORI = :VALPAG, ';
  strSQL := strSQL + '  CTP_VALPAG = :VALPAG, ';
  strSQL := strSQL + '  CTP_PORBAI = :PORBAI, ';
  strSQL := strSQL + '  CTP_HISBAI = :HISBAI, ';
  strSQL := strSQL + '  CTP_HIST01 = :HIST01, ';
  strSQL := strSQL + '  CTP_HIST02 = :HIST02, ';
  strSQL := strSQL + '  CTP_DOCBAI = :DOCBAI, ';
  strSQL := strSQL + '  CTP_CTABAI = :CTABAI, ';
  strSQL := strSQL + '  CTP_OPEBAI = :OPEBAI, ';
  strSQL := strSQL + '  CTP_NUMDOC = :NUMDOC, ';
  strSQL := strSQL + '  CTP_TIPDES = :TIPDES, ';
  strSQL := strSQL + '  CTP_SEQCON = :SEQCON, ';
  strSQL := strSQL + '  CTP_EMPBAI = :EMPBAI, ';
  strSQL := strSQL + '  CTP_SEQRCH = :SEQRCH, ';
  strSQL := strSQL + '  CTP_DINHEI = :DINHEI, ';
  strSQL := strSQL + '  CTP_CHQAVI = :CHQAVI, ';
  strSQL := strSQL + '  CTP_ORDPAG = :ORDPAG, ';
  strSQL := strSQL + '  CTP_REPCHQ = :REPCHQ, ';
  strSQL := strSQL + '  CTP_DTABAI = ' + fCurrentDate + ', ';
  strSQL := strSQL + '  CTP_RESCAI = :RESCAI ';
  if intCrxCon > 0 Then
    strSQL := strSQL + ',CTP_RCXCON = :RCXCON  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

  If (fEmptyStr(strSerie)) Then
    strSQL := strSQL + '  IFNULL(CTP_SERIE_, "") = "" AND '
  Else
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  CTP_DTAPAG IS NULL ';

  {******************************************}
  {* SE FOR BAIXA ANALITICA, O PL. CONTAS DA*}
  {* BAIXA É O MESMO DA DUPLICATA ORIGINAL. *}
  {***************************************MV*}
  If fEmptyStr(strCtaBai) Then
    strCtaBai := qryGenPag.FieldByName('CTP_CODCTA').AsString;

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    {*****************************************}
    {* DADOS QUE SERÃO ALTERADOS             *}
    {**************************************MV*}
    ParamByName('VALPAG').AsFloat    := fltValPag;
    ParamByName('DTAPAG').AsDateTime := dtaDtaPag;

    If fEmptyStr(strPorBai) Then
      ParamByName('PORBAI').Value := Null
    Else
      ParamByName('PORBAI').AsString := strPorBai;

    ParamByName('SEQBAI').AsInteger  := intSeqBai;
    ParamByName('HISBAI').AsString   := LeftStr(strHisBai, 50);
    ParamByName('HIST01').AsString   := strHist01;
    ParamByName('HIST02').AsString   := strHist02;
    ParamByName('DOCBAI').AsString   := strDocBai;
    ParamByName('NUMDOC').AsString   := strNumDoc;
    ParamByName('SEQCON').AsInteger  := intSeqCon;
    ParamByName('EMPBAI').AsString   := VS_strCodEmp;
    ParamByName('RESCAI').AsInteger  := intResCai;

    if intCrxCon > 0 Then
      ParamByName('RCXCON').AsInteger := intCrxCon;

    If intSeqRCH > 0 Then
      ParamByName('SEQRCH').AsInteger := intSeqRCH
    Else ParamByName('SEQRCH').Value := Null;

    If (fEmptyStr(strCtaBai)) Then
      ParamByName('CTABAI').Value := Null
    Else
      ParamByName('CTABAI').AsString := strCtaBai;

    If (fEmptyStr(strOpeBai)) Then
      ParamByName('OPEBAI').Value := Null
    Else
      ParamByName('OPEBAI').AsString := strOpeBai;

    If fEmptyStr(strTipDes) Then
      ParamByName('TIPDES').Value    := Null
    Else
      ParamByName('TIPDES').AsString := strTipDes;

    {*****************************************}
    {* DADOS REFERENTES AO FILTRO            *}
    {**************************************MV*}
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;

    ParamByName('DINHEI').AsFloat := fltDinhei;
    ParamByName('CHQAVI').AsFloat := fltChqAvi;
    ParamByName('ORDPAG').AsFloat := fltOrdPag;
    ParamByName('REPCHQ').AsFloat := fltRepChq;

    If (Not fEmptyStr(strSerie)) Then
      ParamByName('SERIE_').AsString := strSerie;

    ExecSQL;
    Close;
  End;

  fltNovoValDup := qryGenPag.FieldByName('CTP_VALDUP').AsFloat + (fltJurSuj + fltMulSuj) + fltOutEnt + fltVendor - fltDesSuj - fltValPag;
  fltNovoValOri := fltNovoValDup; //qryGenPag.FieldByName('CTP_VALDUP').AsFloat;
  dtaDtaVen     := qryGenPag.FieldByName('CTP_DTAVEN').AsDateTime;
  try
   {criado para caso de alguma falha na distribuição do pagamento antecipado não gerar duplicata com valor 0}
    if blnVerificaValorAntesDeGerarResto then
      If fltNovoValDup = 0 then
        Exit;

    fGravaCadPag(strNomFrmLogCtp,
                 'ALTERACAO DE BAIXA ' + Copy(strDescriLogCtp, 14, 100),
                 qryGenPag.FieldByName('CTP_CODFOR').AsString,   // Fornecedor
                 qryGenPag.FieldByName('CTP_NUMDUP').AsString,   // Numero da Duplicata
                 qryGenPag.FieldByName('CTP_PARCEL').AsString,   // Parcela
                 qryGenPag.FieldByName('CTP_CODEMP').AsString,   // Empresa
                 qryGenPag.FieldByName('CTP_CODCTA').AsString,   // Centro de Custo
                 qryGenPag.FieldByName('CTP_SERIE_').AsString,   // Serie do Documento
                 0,                                              // Sequencial de Baixa
                 qryGenPag.FieldByName('CTP_DTACAD').AsDateTime, // Data do lançamento
                 dtaDtaVen,                                      // Data de Vencimento
                 fltNovoValDup,                                  // Valor da Duplicata
                 fltNovoValOri,                                  // Valor Original
                 qryGenPag.FieldByName('CTP_PREVIS').AsString,   // Previsão?
                 qryGenPag.FieldByName('CTP_VEIOBO').AsString,   // Veio Boleto
                 qryGenPag.FieldByName('CTP_DEPOSI').AsString,   // Deposito
                 strHist01,                                      // Histórico 1
                 qryGenPag.FieldByName('CTP_HIST02').AsString,   // Histórico 2
                 '',                                             // Histórico da Baixa
                 qryGenPag.FieldByName('CTP_PORBAI').AsString,   // Portador da Baixa
                 '',                                             // Centro de Custo da Baixa
                 '',                                             // Documento da Baixa
                 '',                                             // Operador da Baixa
                 0,                                              // Data do Pagamento
                 0,                                              // Valor Pago
                 0,                                              // Valor de Juros
                 0,                                              // Valor Desconto
                 qryGenPag.FieldByName('CTP_EMPGER').AsString,   // Empresa
                 qryGenPag.FieldByName('CTP_CODEVE').AsString,   // Codigo do Evento
                 qryGenPag.FieldByName('CTP_USACHQ').AsString,   // Usa Cheque
                 qryGenPag.FieldByName('CTP_CODPOR').AsString,   // Codigo do Portador
                 strNumDoc,
                 0, //fltJurSuj,
                 0, //fltDesSuj,
                 0,
                 False,
                 0,
                 qryGenPag.FieldByName('CTP_TIPDOC').AsString,
                 0,
                 strVeioNota,
                 '',
                 '',
                 '',
                 '',
                 '',
                 '',
                 '',
                 '',
                 '',
                 qryGenPag.FieldByName('CTP_COMPET').AsString,
                 '',
                 '',
                 '',
                 '',
                 0,
                 0,
                 0,
                 0,
                 qryGenPag.FieldByName('CTP_CODVEN').AsString,
                 0,
                 0,
                 '',
                 '',
                 '',
                 '',
                 '',
                 qryGenPag.FieldByName('CTP_Q_GUIA').AsString,
                 qryGenPag.FieldByName('CTP_CODREC').AsString,
                 qryGenPag.FieldByName('CTP_BCOFOR').AsString,
                 '',
                 qryGenPag.FieldByName('CTP_CODPRJ').AsString,
                 //--
                 qryGenPag.FieldByName('CTP_PAGANT').AsString, //       strPagAntecipado: String = '';
                 '', //       strAutIncFunrural: String = '';
                 '', //       strGnreNumeroDocumento: String = '';
                 '', //       strGnreChaveDeAcesso: String = '';
                 '', //       strGnreNumeroDeControle: String = '';
                 0,  //       dtaGnreDataPrevisaoPagamento: TDateTime = 0;
                 '', //       strGnreConvenio: String = '';
                 0,  //       fltMulSuj : Double = 0;
                 '', //       strAutIncPix: String = '';
                 fltGrvOri,
                 qryGenPag.FieldByName('CTP_DTALIB').AsDateTime,
                 qryGenPag.FieldByName('CTP_HORLIB').AsDateTime,
                 qryGenPag.FieldByName('CTP_OPELIB').AsString,
                 '',
                 '',
                 '',
                 qryGenPag.FieldByName('CTP_USAMCA').AsString);
  finally
    FreeAndNil(qryGenPag);
    FreeAndNil(qryGen);
  End;

end;

{*****************************************}
{* RETORNA O ÚLTIMO SEQUENCIAL DE BAIXA  *}
{* DE DETERMINADA DUPLICATA              *}
{**************************************MV*}
function fRetSeqBaiCadPag(strNumDup,
                          strParcel,
                          strCodEmp,
                          strCodFor,
                          strSerie: String): Integer;
  Var
    strSQL   : String;
    qryGenPag: TUniQuery;

begin
  Try

    qryGenPag := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(CTP_SEQBAI) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString := strSerie;
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;

end;

{*****************************************}
{* RETORNA 'TRUE' CASO A DUPLICATA JA    *}
{* ESTEJA BAIXADA                        *}
{**************************************MV*}
function fDuplicataCtpBaixada(strNumDup, strParcel, strCodEmp,
  strCodFor, strSerie: String; intSeqBai: Integer): Boolean;
  Var
    strSQL: String;
    qryGenPag: TUniQuery;

begin
  Try

    qryGenPag := fCriaQuery;

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTP_DTAPAG AS DTAPAG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND'
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString  := strSerie;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If Not FieldByName('DTAPAG').IsNull Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;

end;

function fGravaDupAgp(strNumAgr,
                      strNumDup,
                      strParcel,
                      strSerie_,
                      strPrevis: String;
                      intSeqBai: Integer;
                      strCodFor,
                      strCodEmp: String;
                      dtaDtaCad,
                      dtaDtaVen: TDateTime;
                      fltValDup,
                      fltValOri: Double;
                      strHist01,
                      strHist02,
                      strCodVen,
                      strCodVel,
                      strCodCta,
                      strEmpAgr: String;
                      fltJurSuj,
                      fltDesSuj: Double;
                      intNCaixa: Integer;
                      fltVendor: Double;
                      strTipoDocumento : Integer;
                      strTipoGuia,
                      strCodigoGuia,
                      strCodigoEvento : String;
                      blUsaCheque : Boolean;
                      strUsoCon: String = '';
                      strNumDDA: String = '';
                      strAutOri: String = '';
                      strDeposi: String = '';
                      strCodPor: String = '';
                      strBcoFor: String = '';
                      strVeioNF: String = '';
                      fltMulSuj: Double = 0;
                      blUsaCartao : Boolean = false): Boolean;
  Var
    strSQL   : String;
    strAutInc: String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    Try

      strAutInc := fRetAutoIncrem('DUPAGP', VS_strCodEmp);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO DUPAGP ';
      strSQL := strSQL + '( ';
      strSQL := strSQL + '  CTP_NUMAGR, ';
      strSQL := strSQL + '  CTP_NUMDUP, ';
      strSQL := strSQL + '  CTP_PARCEL, ';
      strSQL := strSQL + '  CTP_SERIE_, ';
      strSQL := strSQL + '  CTP_PREVIS, ';
      strSQL := strSQL + '  CTP_SEQBAI, ';
      strSQL := strSQL + '  CTP_CODFOR, ';
      strSQL := strSQL + '  CTP_CODEMP, ';
      strSQL := strSQL + '  CTP_DTACAD, ';
      strSQL := strSQL + '  CTP_DTAVEN, ';
      strSQL := strSQL + '  CTP_VALDUP, ';
      strSQL := strSQL + '  CTP_VALORI, ';
      strSQL := strSQL + '  CTP_HIST01, ';
      strSQL := strSQL + '  CTP_HIST02, ';
      strSQL := strSQL + '  CTP_CODVEN, ';
      strSQL := strSQL + '  CTP_CODVEL, ';
      strSQL := strSQL + '  CTP_CODPOR, ';

      If (Not fEmptyStr(strCodCta)) Then
        strSQL := strSQL + '  CTP_CODCTA, ';

      If (Not fEmptyStr(strUsoCon)) Then
        strSQL := strSQL + '  CTP_USOCON, ';

      If (Not fEmptyStr(strDeposi)) Then
        strSQL := strSQL + '  CTP_DEPOSI, ';

      If (Not fEmptyStr(strBcoFor)) Then
        strSQL := strSQL + '  CTP_BCOFOR, ';

      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  CTP_EMPAGR, ';
      strSQL := strSQL + '  CTP_JURSUJ, ';
      strSQL := strSQL + '  CTP_DESSUJ, ';
      strSQL := strSQL + '  CTP_VENDOR, ';
      strSQL := strSQL + '  CTP_NUMDDA, ';
      strSQL := strSQL + '  CTP_NCAIXA, ';
      strSQL := strSQL + '  CTP_AUTORI, ';
      strSQL := strSQL + '  CTP_TIPDOC, ';
      strSQL := strSQL + '  CTP_Q_GUIA, ';
      strSQL := strSQL + '  CTP_CODREC, ';
      strSQL := strSQL + '  CTP_CODEVE, ';
      strSQL := strSQL + '  CTP_USACHQ, ';
      strSQL := strSQL + '  CTP_USAMCA, ';
      strSQL := strSQL + '  CTP_VEIONF, ';
      strSQL := strSQL + '  CTP_MULSUJ) ';
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '  :NUMAGR, ';
      strSQL := strSQL + '  :NUMDUP, ';
      strSQL := strSQL + '  :PARCEL, ';
      strSQL := strSQL + '  :SERIE_, ';
      strSQL := strSQL + '  :PREVIS, ';
      strSQL := strSQL + '  :SEQBAI, ';
      strSQL := strSQL + '  :CODFOR, ';
      strSQL := strSQL + '  :CODEMP, ';
      strSQL := strSQL + '  :DTACAD, ';
      strSQL := strSQL + '  :DTAVEN, ';
      strSQL := strSQL + '  :VALDUP, ';
      strSQL := strSQL + '  :VALORI, ';
      strSQL := strSQL + '  :HIST01, ';
      strSQL := strSQL + '  :HIST02, ';
      strSQL := strSQL + '  :CODVEN, ';
      strSQL := strSQL + '  :CODVEL, ';
      strSQL := strSQL + '  :CODPOR, ';

      If (Not fEmptyStr(strCodCta)) Then
        strSQL := strSQL + '  :CODCTA, ';

      If (Not fEmptyStr(strUsoCon)) Then
        strSQL := strSQL + '  :USOCON, ';

      If (Not fEmptyStr(strDeposi)) Then
        strSQL := strSQL + '  :DEPOSI, ';

      If (Not fEmptyStr(strBcoFor)) Then
        strSQL := strSQL + '  :BCOFOR, ';

      strSQL := strSQL + '  :AUTINC, ';
      strSQL := strSQL + '  :EMPAGR, ';
      strSQL := strSQL + '  :JURSUJ, ';
      strSQL := strSQL + '  :DESSUJ, ';
      strSQL := strSQL + '  :VENDOR, ';
      strSQL := strSQL + '  :NUMDDA, ';
      strSQL := strSQL + '  :NCAIXA, ';
      strSQL := strSQL + '  :AUTORI, ';
      strSQL := strSQL + '  :TIPDOC, ';
      strSQL := strSQL + '  :Q_GUIA, ';
      strSQL := strSQL + '  :CODREC, ';
      strSQL := strSQL + '  :CODEVE, ';
      strSQL := strSQL + '  :USACHQ, ';
      strSQL := strSQL + '  :USAMCA, ';
      strSQL := strSQL + '  :VEIONF, ';
      strSQL := strSQL + '  :MULSUJ) ';

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString   := strNumAgr;
        ParamByName('NUMDUP').AsString   := strNumDup;
        ParamByName('PARCEL').AsString   := strParcel;
        ParamByName('SERIE_').AsString   := strSerie_;
        ParamByName('PREVIS').AsString   := strPrevis;
        ParamByName('SEQBAI').AsInteger  := intSeqBai;
        ParamByName('CODFOR').AsString   := strCodFor;
        ParamByName('CODEMP').AsString   := strCodEmp;
        ParamByName('DTACAD').AsDateTime := dtaDtaCad;
        ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
        ParamByName('VALDUP').AsFloat    := fltValDup;
        ParamByName('VALORI').AsFloat    := fltValOri;
        ParamByName('HIST01').AsString   := strHist01;
        ParamByName('HIST02').AsString   := strHist02;
        ParamByName('CODVEN').AsString   := strCodVen;
        ParamByName('CODPOR').AsString   := strCodPor;

        If (fEmptyStr(strCodVel)) Then
          ParamByName('CODVEL').Value := Null
        Else
          ParamByName('CODVEL').AsString := strCodVel;

        If (Not fEmptyStr(strCodCta)) Then
          ParamByName('CODCTA').AsString := strCodCta;

        If (Not fEmptyStr(strUsoCon)) Then
          ParamByName('USOCON').AsString := strUsoCon;

        If (Not fEmptyStr(strDeposi)) Then
          ParamByName('DEPOSI').AsString := strDeposi;

        If (Not fEmptyStr(strBcoFor)) Then
          ParamByName('BCOFOR').AsString := strBcoFor;

        ParamByName('EMPAGR').AsString   := strEmpAgr;
        ParamByName('AUTINC').AsString   := strAutInc;

        ParamByName('JURSUJ').AsFloat    := fltJurSuj;
        ParamByName('DESSUJ').AsFloat    := fltDesSuj;
        ParamByName('VENDOR').AsFloat    := fltVendor;
        ParamByName('NUMDDA').AsString   := strNumDDA;
        ParamByName('NCAIXA').AsInteger  := intNCaixa;
        ParamByName('AUTORI').AsString   := strAutOri;

        if strTipoDocumento <> 0 then
          ParamByName('TIPDOC').AsInteger  := strTipoDocumento
        else
          ParamByName('TIPDOC').Clear;
        if strTipoGuia <> '' then
          begin
            ParamByName('Q_GUIA').AsString   := strTipoGuia;
            ParamByName('CODREC').AsString   := strCodigoGuia;
          end
        else
          begin
            ParamByName('Q_GUIA').Clear;
            ParamByName('CODREC').Clear;
          end;
        ParamByName('CODEVE').AsString := strCodigoEvento;
        ParamByName('USACHQ').AsString := IIF(blUsaCheque,'S','N');
        ParamByName('VEIONF').AsString := strVeioNF;
        ParamByName('MULSUJ').AsFloat := fltMulSuj;
        ParamByName('USAMCA').AsString := IIF(blUsaCartao,'S','N');

        ExecSQL;
        Close;
        Result := True;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaDupAgp]');
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

{*****************************************}
{* VERIFICA SE EXISTE UM DETERMINADO NÚ- *}
{* MERO DE AGRUPAMENTO                   *}
{**************************************AC*}
function  fVerificaNumAgr(strNumAgr, strCodFor, strC_G_C_: String): Boolean;
  Var
    strSQL : String;
    qryGen1: TUniQuery;
    qryGen2: TUniQuery;
    qryGen3: TUniQuery;
begin
  qryGen1 := fCriaQuery;
  qryGen2 := fCriaQuery;
  qryGen3 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUPAGP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '  CTP_EMPAGR = :EMPAGR AND ';
  strSQL := strSQL + '  CTP_CODFOR IN (SELECT FOR_CODFOR ';
  strSQL := strSQL + '  FROM CADFOR             ';
  strSQL := strSQL + '  WHERE FOR_C_G_C_ LIKE :PARTECNPJ )   ';

  With qryGen1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('EMPAGR').AsString := VS_strCodEmp;
    ParamByName('PARTECNPJ').AsString := leftstr(strC_G_C_,8) + '%';
    Open;

    If Not IsEmpty Then
      Result := True
    Else
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Agrupamento não encontrado!', ['&O k']);
    End;

  End;

  If Result Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  SUBSTRING(CTP_NUMDUP,1,2) = "AG" AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP     ';

    With qryGen3 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not(IsEmpty) Then
        Result := True
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Agrupamento não encontrado!', ['&O k']);
      End;

    End;

  End;

  If Result Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  SUBSTRING(CTP_NUMDUP,1,2) = "AG" AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_DTAPAG IS NOT NULL ';

    With qryGen2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Não é possivel realizar o desagrupamento, pois há duplicatas baixadas para o mesmo.', ['&O k']);
      End;

    End;

  End;

  qryGen1.Close;
  qryGen2.Close;
  qryGen3.Close;

  FreeAndNil(qryGen1);
  FreeAndNil(qryGen2);
  FreeAndNil(qryGen3);

end;

function FornecedorPossuiPagamentosAntecipados(ACodFor: String): Boolean;
  Var
    LCadPag: TUniQuery;
Begin
  Result := False;

  Try
    LCadPag := fCriaQuery(Nil);

    Try
      LCadPag.Close;
      LCadPag.SQL.Clear;
      LCadPag.SQL.Text := 'SELECT                                       '+
                          '  COUNT(CTP_PAGANT) AS QTD                   '+
                          'FROM                                         '+
                          '  CADPAG                                     '+
                          '  LEFT JOIN PGOGER P                         '+
                          '    ON P.PGO_SEQPAG = CADPAG.AUTOINCREM      '+
                          '  LEFT JOIN CADFOR F                         '+
                          '   ON F.FOR_CODFOR = CADPAG.CTP_CODFOR       '+
                          'WHERE PGO_SEQPAG IS NULL                     '+
                          '  AND (                                      '+
                          '    (                                        '+
                          '      F.FOR_CGCCPF = 1                       '+
                          '      AND SUBSTR(F.FOR_C_G_C_, 1, 8) IN      '+
                          '      (SELECT                                '+
                          '        SUBSTR(FB.FOR_C_G_C_, 1, 8)          '+
                          '      FROM                                   '+
                          '        CADFOR FB                            '+
                          '      WHERE FB.FOR_CODFOR = :CODFOR)         '+
                          '    )                                        '+
                          '    OR (                                     '+
                          '      F.FOR_CGCCPF = 2                       '+
                          '      AND CTP_CODFOR = :CODFOR               '+
                          '    )                                        '+
                          ' )                                           '+
                          '  AND CTP_PAGANT = "S"                       '+
                          '  AND CTP_DTAPAG IS NOT NULL                 '+
                          '  AND IFNULL(CTP_USOFIS, "N") = "N"          '+
                          '  AND (                                      '+
                          '    (                                        '+
                          '      IFNULL(                                '+
                          '        (SELECT                              '+
                          '          SUM(PRE_VALUTI)                    '+
                          '        FROM                                 '+
                          '          PREPGA A                           '+
                          '        WHERE A.AUTOINCPAG = P.AUTOINCREM),  '+
                          '        0                                    '+
                          '      )                                      '+
                          '    ) = 0                                    '+
                          '  )                                          ';

      LCadPag.ParamByName('CODFOR').AsString := ACodFor;
      LCadPag.Open;

      If LCadPag.FieldByName('QTD').AsInteger > 0 Then
        Result := True;
    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadPag);
  End;
End;

procedure GeraListaDeCamposCADPAG();
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposNovoCadPag.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery();
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADPAG WHERE FALSE');
    LConsulta.Open;

    FCamposNovoCadPag := '';
    FParametrosNovoCadPag := '';
    FCamposCadPag := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposNovoCadPag := FCamposNovoCadPag + LCampo.FieldName + ',';
      FParametrosNovoCadPag := FParametrosNovoCadPag + ':' + LCampo.FieldName + ',';

      FCamposCadPag := FCamposCadPag + LCampo.FieldName + ',';
    End;

    FCamposNovoCadPag := LeftStr(FCamposNovoCadPag, FCamposNovoCadPag.Length - 1);
    FParametrosNovoCadPag := LeftStr(FParametrosNovoCadPag, FParametrosNovoCadPag.Length - 1);

    FCamposCadPag := LeftStr(FCamposCadPag, FCamposCadPag.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

Function VerificaSeTemVariasEspeciesPagto(AAutoIncrem: String) : Boolean;
  Var
    i,
    iqtdeEsp : integer;
    LAux : TUniQuery;
Begin

  Try
    result := False;
    iqtdeEsp := 0;

    Try
      LAux := fCriaQuery();

      LAux.SQL.Text := 'SELECT ' + FCamposCadPag + ' FROM CADPAG WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LAux.Open;

      For i := 0 To Length(FArrEspPagas) - 1 Do
      Begin

         If LAux.FieldByName(FArrEspPagas[i]).Asfloat > 0 Then
            iqtdeEsp := iqtdeEsp + 1;

      End;

      If iqtdeEsp > 1 Then
         Result := True;

    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    If Assigned(LAux) Then
      FreeAndNil(LAux);
  End;

End;

procedure DesmembraDuplicatasPagarPorEspecie(AAutoIncrem: String);
  Var
    LConsulta,
    LUpdate,
    LGravarNovoReg: TUniQuery;

    LCampo: TField;
    iCont, iSeqBai, iSeqBaiParcial : Integer;

    fltRestArredJuros,
    fltRestArredDescto : Double;

    fltJurosDupInicial,
    fltDesctoDupInicial,
    fltJurosSujDupInicial,
    fltDesctoSujDupInicial,
    fltTotalDupInicial : Double;

    fltValOriCalc,
    fltValRecCalc,
    fltPercJurosDup,
    fltPercDesctoDup,
    fltPercJurosSujDup,
    fltPercDesctoSujDup,
    fltdifJur,
    fltdifDes,
    fltUltimoValOriCalc : Double;

    sUltAutoIncrem : String;

    blnParcial : Boolean;
    LConsultaSequencialBaixa: Integer;
Begin
  GeraListaDeCamposCADPAG();

  If Not VerificaSeTemVariasEspeciesPagto(AAutoIncrem) Then
     Exit;
  Try
    LConsulta  := fCriaQuery();
    LGravarNovoReg := fCriaQuery();
    LUpdate := fCriaQuery();
    blnParcial := False;
    iSeqBaiParcial:= 0;
    Try

      LConsulta.SQL.Text := 'SELECT ' + FCamposCadPag + ' FROM CADPAG WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LConsulta.Open;

      LUpdate.SQL.Text := 'SELECT ' + FCamposCadPag + ' FROM CADPAG WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LUpdate.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        LConsultaSequencialBaixa := fRetSeqBaiCadPag(LConsulta.FieldByName('CTP_NUMDUP').AsString,
                                                     LConsulta.FieldByName('CTP_PARCEL').AsString,
                                                     LConsulta.FieldByName('CTP_CODEMP').AsString,
                                                     LConsulta.FieldByName('CTP_CODFOR').AsString,
                                                     LConsulta.FieldByName('CTP_SERIE_').AsString);


        If (LConsultaSequencialBaixa > 0) Then
        Begin
           iSeqBaiParcial := LConsultaSequencialBaixa;
           blnParcial := True;
        End;

        iseqbai := LConsulta.FieldByName('CTP_SEQBAI').AsInteger;
        fltJurosDupInicial  := LConsulta.FieldByName('CTP_VALJUR').AsFloat;
        fltDesctoDupInicial := LConsulta.FieldByName('CTP_VALDES').AsFloat;
        fltTotalDupInicial  := (LConsulta.FieldByName('CTP_VALORI').AsFloat + LConsulta.FieldByName('CTP_VALJUR').AsFloat)
                                                                            - LConsulta.FieldByName('CTP_VALDES').AsFloat;

        fltJurosSujDupInicial  := LConsulta.FieldByName('CTP_JURSUJ').AsFloat;
        fltDesctoSujDupInicial := LConsulta.FieldByName('CTP_DESSUJ').AsFloat;

        fltRestArredJuros  := 0;
        fltRestArredDescto := 0;
        fltUltimoValOriCalc := 0;

        For iCont := 0 To Length(FArrEspPagas) - 1 Do
        Begin

           If LConsulta.FieldByName(FArrEspPagas[iCont]).Asfloat > 0 Then
           Begin
              // OBS: DIVIDIR JUROS E DESCONTO DE FORMA PROPORCIONAL.
              // 1 = ( 30,00 / 167,00 ) * 17,00 = 3,05
              // 2 = ( 40,00 / 167,00 ) * 17,00 = 4,07
              // 3 = ( 97,00 / 167,00 ) * 17,00 = 9,07 --> FAZER ARREDONDAMENTO NO ULTIMO SEQBAI GERADO, PARA BATER COM O VALOR EXATO.

              fltUltimoValOriCalc := 0;
              // Calcula juros/Desconto proporcionalmente;
              fltPercJurosDup := 0;

              If fltJurosDupInicial > 0 Then
              Begin
                 fltPercJurosDup   := fFormataFloat(((LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat / fltTotalDupInicial) * fltJurosDupInicial) ,2);
                 fltRestArredJuros := fltRestArredJuros + fltPercJurosDup;
              End;
              fltValOriCalc := (LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat - fltPercJurosDup);

              fltPercDesctoDup := 0;
              If fltDesctoDupInicial > 0 Then
              Begin
                 fltPercDesctoDup := fFormataFloat(((LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat / fltTotalDupInicial) * fltDesctoDupInicial) ,2);
                 fltRestArredDescto := fltRestArredDescto + fltPercDesctoDup;
              End;
              fltValOriCalc := fltValOriCalc + fltPercDesctoDup;
              fltValRecCalc := LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat;

              // Calcula Juros/descontos sugeridos
              fltPercJurosSujDup  := 0;
              If fltJurosSujDupInicial > 0 Then
                 fltPercJurosSujDup := fFormataFloat(((LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat / fltTotalDupInicial) * fltJurosSujDupInicial) ,2);

              fltPercDesctoSujDup := 0;
              If fltDesctoSujDupInicial > 0 Then
                 fltPercDesctoSujDup := fFormataFloat(((LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat / fltTotalDupInicial) * fltDesctoSujDupInicial) ,2);


              If iseqbai = LUpdate.FieldByName('CTP_SEQBAI').AsInteger Then
              Begin
                LUpdate.Edit;
                LUpdate.FieldByName('CTP_DINHEI').AsFloat    := 0;
                LUpdate.FieldByName('CTP_CARTAO').AsFloat    := 0;
                LUpdate.FieldByName('CTP_CHQAVI').AsFloat    := 0;
                LUpdate.FieldByName('CTP_CHQPRE').AsFloat    := 0;
                LUpdate.FieldByName('CTP_REPCHQ').AsFloat    := 0;
                LUpdate.FieldByName('CTP_ORDPAG').AsFloat    := 0;
                //LUpdate.FieldByName('CTP_JURANT').AsFloat    := 0;
                //LUpdate.FieldByName('CTP_DESANT').AsFloat    := 0;
                //LUpdate.FieldByName('CTP_VALANT').AsFloat    := fltTotalDupInicial; //LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat;
                LUpdate.FieldByName(FArrEspPagas[iCont]).AsFloat := LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat;
                LUpdate.FieldByName('CTP_VALORI').AsFloat    := fltValOriCalc;
                LUpdate.FieldByName('CTP_VALPAG').AsFloat    := fltValRecCalc;
                LUpdate.FieldByName('CTP_VALDUP').AsFloat    := 0;
                LUpdate.FieldByName('CTP_VALJUR').AsFloat    := fltPercJurosDup;
                LUpdate.FieldByName('CTP_VALDES').AsFloat    := fltPercDesctoDup;
                LUpdate.FieldByName('CTP_JURSUJ').AsFloat    := fltPercJurosSujDup;
                LUpdate.FieldByName('CTP_DESSUJ').AsFloat    := fltPercDesctoSujDup;
                LUpdate.Post;

                If blnParcial Then
                   iseqbai := iSeqBaiParcial + 1
                Else
                   iseqbai := iseqbai + 1;

                Continue;
              End;

              LGravarNovoReg.SQL.Text := 'INSERT INTO CADPAG (' + FCamposNovoCadPag + ') ' +
                                                    ' VALUES (' + FParametrosNovoCadPag + ') ';

              For LCampo In LConsulta.Fields Do
              Begin
                If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
                  Continue;

                LGravarNovoReg.ParamByName(LCampo.FieldName).Value := LCampo.Value;
              End;

              LGravarNovoReg.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADPAG', LConsulta.FieldByName('CTP_CODEMP').AsString);
              LGravarNovoReg.ParamByName('CTP_DINHEI').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_CARTAO').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_CHQAVI').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_CHQPRE').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_REPCHQ').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_ORDPAG').AsFloat    := 0;
              //LGravarNovoReg.ParamByName('CTP_JURANT').AsFloat    := 0;
              //LGravarNovoReg.ParamByName('CTP_DESANT').AsFloat    := 0;
              //LGravarNovoReg.ParamByName('CTP_VALANT').AsFloat    := fltTotalDupInicial; //LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat;
              LGravarNovoReg.ParamByName(FArrEspPagas[iCont]).AsFloat := LConsulta.FieldByName(FArrEspPagas[iCont]).AsFloat;
              LGravarNovoReg.ParamByName('CTP_VALORI').AsFloat    := fltValOriCalc;
              LGravarNovoReg.ParamByName('CTP_VALPAG').AsFloat    := fltValRecCalc;
              LGravarNovoReg.ParamByName('CTP_VALDUP').AsFloat    := 0;
              LGravarNovoReg.ParamByName('CTP_VALJUR').AsFloat    := fltPercJurosDup;
              LGravarNovoReg.ParamByName('CTP_VALDES').AsFloat    := fltPercDesctoDup;
              LGravarNovoReg.ParamByName('CTP_JURSUJ').AsFloat    := fltPercJurosSujDup;
              LGravarNovoReg.ParamByName('CTP_DESSUJ').AsFloat    := fltPercDesctoSujDup;
              LGravarNovoReg.ParamByName('CTP_SEQBAI').AsInteger  := iseqbai;

              iseqbai := iseqbai + 1;

              fltUltimoValOriCalc := fltValOriCalc;
              sUltAutoIncrem := LGravarNovoReg.ParamByName('AUTOINCREM').AsString;

              LGravarNovoReg.ExecSQL;

           End;

        End;

        fltdifJur := 0;
        fltdifDes := 0;

        // Atualiza diferença de juros/desconto no ultimo autoincrem atualizado;
        If fltJurosDupInicial <> fltRestArredJuros Then
           fltdifJur := fFormataFloat(fltJurosDupInicial - fltRestArredJuros,2);

        If fltDesctoDupInicial <> fltRestArredDescto Then
           fltdifDes :=  fFormataFloat(fltDesctoDupInicial - fltRestArredDescto,2);

        If (fltdifJur <> 0) Or (fltdifDes <> 0) Then
        Begin

          fltUltimoValOriCalc := ((fltUltimoValOriCalc - fltdifJur) + fltdifDes);

          LUpdate.Close;
          LUpdate.Sql.Clear;
          LUpdate.Sql.Add('UPDATE CADPAG SET ');
          LUpdate.Sql.Add(' CTP_VALORI = :VALORI ');

          If fltdifJur <> 0 Then
             LUpdate.Sql.Add(' ,CTP_VALJUR = CTP_VALJUR + :DIFJUR ');

          If fltdifDes <> 0 Then
             LUpdate.Sql.Add(' ,CTP_VALDES = CTP_VALDES + :DIFDES ');

          LUpdate.Sql.Add(' WHERE AUTOINCREM = :AUTOINC ');

          LUpdate.ParamByName('VALORI').AsFloat := fltUltimoValOriCalc;

          If fltdifJur <> 0 Then
             LUpdate.ParamByName('DIFJUR').AsFloat := fltdifJur;

          If fltdifDes <> 0 Then
             LUpdate.ParamByName('DIFDES').AsFloat := fltdifDes;

          LUpdate.ParamByName('AUTOINC').AsString   := sUltAutoIncrem;
          LUpdate.ExecSql;
        End;

      End;

    Except
      On E: Exception Do
        Raise;
    End;
  Finally
    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);

    If Assigned(LGravarNovoReg) Then
      FreeAndNil(LGravarNovoReg);

    If Assigned(LUpdate) Then
      FreeAndNil(LUpdate);
  End;
End;

function EntradaDeMercadoriaQueNaoChegouNaEmpresa(ANumDup,ASerie,ACodEmp,ACodFor: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := False;

  Try
    LConsulta := fCriaQuery(Nil);

    Try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Text :=  'SELECT COUNT(0) AS QTD                                  '+
                             '  FROM CADPAG B                                         '+
                             'INNER JOIN MOVGER A ON A.GER_CODFOR = B.CTP_CODFOR AND  '+
                             '                       A.GER_NUMDOC = B.CTP_NUMDUP AND  '+
                             '                       A.GER_CODEMP = B.CTP_CODEMP AND  '+
                             '                       A.GER_SERIE_ = B.CTP_SERIE_ AND  '+
                             '                       A.GER_TIP_FC = "F"          AND  '+
                             '                       A.GER_ORIDOC = ""                '+
                             'WHERE TRUE                                              '+
                             '  AND B.CTP_NUMDUP = :NUMDUP                            '+
                             '  AND B.CTP_SERIE_ = :SERIE_                            '+
                             '  AND B.CTP_CODEMP = :CODEMP                            '+
                             '  AND B.CTP_CODFOR = :CODFOR                            '+
                             '  AND B.CTP_DTACAD IS NULL                              '+
                             '  AND A.GER_DTAENT IS NULL                              ';

      LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
      LConsulta.ParamByName('SERIE_').AsString := ASerie;
      LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
      LConsulta.ParamByName('CODFOR').AsString := ACodFor;
      LConsulta.Open;

      Result := (LConsulta.FieldByName('QTD').AsInteger > 0);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;

End;

function fRetAutIncCadPagAgr(strNomeTabela,
                             strTabelaCadPag,
                             strNumAgr: String): TStringList;
  Var
    strSQL: String;
    qryGen1,
    qryGen2: TUniQuery;
Begin
  Result := Nil;

  qryGen1 := fCriaQuery;
  qryGen2 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomeTabela + ' ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '  CTP_EMPAGR = :EMPAGR ';

  With qryGen1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('EMPAGR').AsString := VS_strCodEmp;
    Open;
  End;

  If Not qryGen1.IsEmpty Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabelaCadPag + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  SUBSTRING(CTP_NUMDUP,1,2) = "AG" AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_SEQBAI = 0 ';

    With qryGen2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODFOR').AsString := qryGen1.FieldByName('CTP_CODFOR').AsString;
      ParamByName('CODEMP').AsString := qryGen1.FieldByName('CTP_CODEMP').AsString;
      Open;

      If Not IsEmpty Then
      Begin
        Result := TStringList.Create;

        First;

        While Not Eof Do
        Begin
          Result.Add(FieldByName('AUTOINCREM').AsString);
          Next;
        End;
      End;
    End;
  End;

  qryGen1.Close;
  qryGen2.Close;

  FreeAndNil(qryGen1);
  FreeAndNil(qryGen2);
End;

function fDeletaDuplicatasAgr(strNumAgr, strCodFor: String): Boolean;
  Var
    strSQL: String;
    qryGen1: TUniQuery;
begin

  qryGen1 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'DELETE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMAGR AND ';
  strSQL := strSQL + '  SUBSTRING(CTP_NUMDUP,1,2) = "AG" AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

  Try
    With qryGen1 Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      ExecSQL;
      Close;

      Result := True;

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      FreeAndNil(qryGen1);
      pMensagensErro(E.Message, '[fDeletaDuplicatasAgr]');
    End;
  End;

  FreeAndNil(qryGen1);

end;


function DeleteCtpDet(ANomFrm: String; ACtpDet: TDataSet): Boolean;
  Var
    LExeCtpDet : TUniQuery;
Begin
  LExeCtpDet := fCriaQuery(Nil);
  Result := True;
  Try
    Try
      fVerificaIntegridade(ANomFrm, 'CTPDET', ACtpDet);

      LExeCtpDet.SQL.Clear;
      LExeCtpDet.SQL.Text := 'DELETE FROM CTPDET WHERE AUTOINCREM = :AUTINC';
      LExeCtpDet.ParamByName('AUTINC').AsString := ACtpDet.FieldByName('AUTOINCREM').AsString;
      LExeCtpDet.ExecSQL;
    Except
      On E : Exception Do
      Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LExeCtpDet);
  End;
End;


function fDeletaDupAgr(strNumAgr, strCodFor: String; ANomFrm : String = ''): Boolean;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;
begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  DUPAGP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMAGR = :NUMAGR AND ';
    strSQL := strSQL + '  CTP_EMPAGR = :EMPAGR AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    Try
      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := VS_strCodEmp;
        ParamByName('CODFOR').AsString := strCodFor;
        ExecSQL;
        Close;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDeletaDupAgr]');
      End;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM ';
    strSQL := strSQL + '  CTPDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  CTP_EMPORI = :EMPAGR AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    Try
      qryGenTmp.Close;
      qryGenTmp.SQL.Clear;
      qryGenTmp.SQL.Add(strSQL);
      qryGenTmp.ParamByName('NUMAGR').AsString := strNumAgr;
      qryGenTmp.ParamByName('EMPAGR').AsString := VS_strCodEmp;
      qryGenTmp.ParamByName('CODFOR').AsString := strCodFor;
      qryGenTmp.Open;

      If Not qryGenTmp.IsEmpty Then
        Result :=  DeleteCtpDet(IIF(fEmptyStr(ANomFrm),'untCadPag',ANomFrm),qryGenTmp);

      qryGenTmp.Close;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDeletaCtpDet]');
      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

procedure ImprimeCP(strNumDup, strParcel, strCodEmp, strCodFor, strSerie, strNomForm: String;
  blnReimpressao: Boolean = False; blnOrdena: Boolean = True);
  Var
    strSQL: String;
    qryRelatorio: TUniQuery;
    intQtdVia : Integer;
    qryCtpDet   : TUniQuery;
    qryCtpChq   : TUniQuery;
    strCtpDescri: String; //MF: 286456 - 02/06/2023
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADPAG.AUTOINCREM AS AUTOINCREM, '; //MF: 286456 - 06/06/2023
  strSQL := strSQL + '  CTP_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  CTP_PARCEL AS PARCEL, ';
  strSQL := strSQL + '  CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CTP_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  CTP_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '  CTP_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  CTP_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  CTP_PARCEL AS PARCEL, ';
  strSQL := strSQL + '  IF(CTP_DTAPAG IS NULL, CTP_VALDUP, CTP_VALORI) AS DUPLIC, ';
  strSQL := strSQL + '  CTP_HIST01 AS HIST01, ';
  strSQL := strSQL + '  CTP_HIST02 AS HIST02, ';
  strSQL := strSQL + '  CTP_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '  POR_NOMPOR AS NOMPOR, ';
  strSQL := strSQL + '  CTP_CODCTA AS PCONTA, ';
  strSQL := strSQL + '  CTA_DESCTA AS DESCUS, ';
  strSQL := strSQL + '  CTP_OUTENT AS OUTENT, ';
  strSQL := strSQL + '  CTP_CODPOR AS CODPOR, ';
  strSQL := strSQL + '  CTP_DEPOSI, ';
  strSQL := strSQL + '  CTP_USACHQ, ';
  strSQL := strSQL + '  (SELECT ' +
                     '     CONCAT(CG.CRE_CODCRE," - ",CG.CRE_DESCRE) ' +
                     '   FROM ' +
                     '     CTARES CR, ' +
                     '     CTAGER CG  ' +
                     '   WHERE ' +
                     '     CTP_CODCTA = CR.CRE_CODCTA AND ' +
                     '     CR.CRE_CODCRE = CG.CRE_CODCRE LIMIT 1) AS DESCRE, ';
  strSQL := strSQL + '  CTP_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  CTP_VEIOBO AS VEIOBO, ';
  strSQL := strSQL + '  CTP_VEIONF AS VEIONF, ';
  strSQL := strSQL + '  CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  CONCAT(CTP_CODEVE,"-",EVE_DESEVE) AS NOMEVE, ';
  strSQL := strSQL + '  (SELECT ' +
                   '       SUM(IF(CTP_DTAPAG IS NULL, CTP_VALDUP, CTP_VALORI)) ' +
                   '     FROM CADPAG ' +
                   '     WHERE ' +
                   '       CTP_NUMDUP = :DUPLIC AND ' +
                   '       CTP_CODFOR = :CODFOR AND ' +
                   '       CTP_CODEMP = :CODEMP AND ' +
                   '       IFNULL(CTP_SERIE_, '''') = :SERIE_ ' +
                   '     GROUP BY ' +
                   '       CTP_NUMDUP, ' +
                   '       CTP_CODFOR, ' +
                   '       CTP_CODEMP) AS VALTOT, ';
  strSQL := strSQL + '  IFNULL(CTP_JURSUJ,0) AS JURSUJ, ';
  strSQL := strSQL + '  IFNULL(CTP_MULSUJ,0) AS MULSUJ, ';
  strSQL := strSQL + '  IFNULL(CTP_VENDOR,0) AS VENDOR, ';
  strSQL := strSQL + '  IFNULL(CTP_DESSUJ,0) AS DESSUJ, ';
  strSQL := strSQL + '  CONCAT(CTP_CODEMP," - ",EMP_NOMEMP) AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(CTP_CODCTA," - ",CTA_DESCTA) AS CENCUS, ';
  strSQL := strSQL + '  CONCAT(CTP_NUMDUP," - ",CTP_PARCEL," - ",CTP_CODEMP) AS CHAVE, ';
  strSQL := strSQL + '  FIS_DTADOC AS DTADOC, ';
  strSQL := strSQL + '  CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ' +
                     '  "AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ' +
                     '  "CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA,B.BCF_DIGVER), 14, " ")) AS CONTADEPOSITO, ';
  strSQL := strSQL + '  CONCAT("BCO:", RPAD(B.BCF_CODBCO, 4, "-"), ' +
                     '  LTRIM(IF(BCO_CODBCO = 001, "BCO DO BRASIL", (IF(BCO_CODBCO = 003, "BCO DA AMAZONIA", (IF(BCO_CODBCO = 369, "DIGIBANCO BANCO COMERCIAL", ' +
                     '  (REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(BCO_NOMBCO, "BANCO DO ", " "), "BANCO DE ", " "), ' +
                     '  "BANCO ", " "), "BCO DO ", " "), "BCO ", " "), "DE CREDITO ", " ")))))))), "  ", ' +
                     '  "AG:", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ' +
                     '  "CONTA:", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA, B.BCF_DIGVER), 14, " ")) AS CONTABANCO, ';
  strSQL := strSQL + '  CONCAT("PIX: ", P.PIX_TIPCHV, " - ", P.PIX_CHAVE_) AS CHAVEPIX, ';

  strSQL := strSQL + '  GUI_DESCRI AS GUIDES ';
  strSQL := strSQL + 'FROM CADPAG ';
  strSQL := strSQL + '  JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ';
  strSQL := strSQL + '  JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA ';
  strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = CTP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON CTP_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADEVE ON CTP_CODEVE = EVE_CODEVE ';
  strSQL := strSQL + '  LEFT JOIN CADFIS ON CTP_NUMDOC = FIS_NUMDOC AND ';
  strSQL := strSQL + '                      CTP_SERIE_ = FIS_SERIE_ AND ';
  strSQL := strSQL + '                      CTP_CODFOR = FIS_FORCLI AND ';
  strSQL := strSQL + '                      CTP_CODEMP = FIS_CODEMP     ';
  strSQL := strSQL + '  LEFT JOIN BCOFOR B ON B.AUTOINCREM = CTP_BCOFOR ';
  strSQL := strSQL + '  LEFT JOIN CADBCO C ON C.BCO_CODBCO = B.BCF_CODBCO ';
  strSQL := strSQL + '  LEFT JOIN FORPIX P ON P.AUTOINCREM = CTP_FORPIX ';
  strSQL := strSQL + '  LEFT JOIN GUITRI G ON G.GUI_CODGUI = CTP_Q_GUIA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :DUPLIC AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PRCELA AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  IFNULL(CTP_SERIE_, '''') = :SERIE_ AND ';
  strSQL := strSQL + '  CTP_SEQBAI = 0  ';

  qryRelatorio := fCriaQuery;
  With qryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DUPLIC').AsString := strNumDup;
    ParamByName('PRCELA').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('SERIE_').AsString := strSerie;
    Open;
  End;


  qryCtpDet := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT                       ';
  strSQL := strSQL + '  CTP_CODFOR,                ';
  strSQL := strSQL + '  CTP_NUMDUP,                ';
  strSQL := strSQL + '  CTP_PARCEL,                ';
  strSQL := strSQL + '  CTP_EMPORI,                ';
  strSQL := strSQL + '  CTP_SERIE_,                ';
  strSQL := strSQL + '  CTP_CODCTA,                ';
  strSQL := strSQL + '  CTA_DESCTA,                ';
  strSQL := strSQL + '  CTP_CODEMP,                ';
  strSQL := strSQL + '  CTP_CODEVE,                ';
  strSQL := strSQL + '  EVE_DESEVE,                ';
  strSQL := strSQL + '  CTP_FATCAL                 ';
  strSQL := strSQL + 'FROM                         ';
  strSQL := strSQL + '  CTPDET                     ';
  strSQL := strSQL + 'INNER JOIN CADCTA            ';
  strSQL := strSQL + '  ON CTA_CODCTA = CTP_CODCTA ';
  strSQL := strSQL + 'LEFT JOIN CADEVE             ';
  strSQL := strSQL + '  ON EVE_CODEVE = CTP_CODEVE ';
  strSQL := strSQL + 'WHERE CTP_CODFOR = :CODFOR   ';
  strSQL := strSQL + '  AND CTP_NUMDUP = :NUMDUP   ';
  strSQL := strSQL + '  AND CTP_PARCEL = :PARCEL   ';
  strSQL := strSQL + '  AND CTP_EMPORI = :EMPORI   ';
  strSQL := strSQL + '  AND IFNULL(CTP_SERIE_, '''') = :SERIE_ ';
  strSQL := strSQL + '  ORDER BY CTP_CODEMP, CTP_CODCTA ';

  With qryCtpDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('EMPORI').AsString := strCodEmp;

    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('SERIE_').AsString := strSerie;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT                        ';
  strSQL := strSQL + '   CHQ_CODBCO AS CHQBCO,       ';
  strSQL := strSQL + '   CHQ_NUMAGE AS CHQAGE,       ';
  strSQL := strSQL + '   CHQ_CONCOR AS CHQCOR,       ';
  strSQL := strSQL + '   CHQ_NUMCHQ AS NUMCHQ,       ';
  strSQL := strSQL + '   CHQ_CODCLI AS CHQCLI,       ';
  strSQL := strSQL + '   CHQ_DTAVEN AS CHQVEN        ';
  strSQL := strSQL + ' FROM                          ';
  strSQL := strSQL + '   CADCHQ                      ';
  strSQL := strSQL + ' LEFT JOIN CADPAG              ';
  strSQL := strSQL + '   ON CHQ_SEQRCH = CTP_SEQRCH  ';
  strSQL := strSQL + '   AND CHQ_EMPRCH = CTP_CODEMP ';
  strSQL := strSQL + 'WHERE                          ';
  strSQL := strSQL + '  CTP_NUMDUP = :DUPLIC AND     ';
  strSQL := strSQL + '  CTP_PARCEL = :PRCELA AND     ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND     ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND     ';
  strSQL := strSQL + '  IFNULL(CTP_SERIE_, '''') = :SERIE_ AND ';
  strSQL := strSQL + '  CTP_SEQBAI = 0  AND ';
  strSQL := strSQL + '  CTP_SEQCON <> 0 ';

  qryCtpChq := fCriaQuery;
  With qryCtpChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DUPLIC').AsString := strNumDup;
    ParamByName('PRCELA').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('SERIE_').AsString := strSerie;
    Open;
  End;

  Try
    {**********************************************}
    {* IMPRESSÃO DO CP FOI REFEITA EM FAST REPORT *}
    {*29/08/2012********************************JU*}

    If Not blnReimpressao Then
    Begin
      pVerificaImpressao(blnReimpressao, strNomForm);
      blnVerificaImpressao := True
    End
    Else
      blnVerificaImpressao := False;

    If Not Assigned(frmQckCtpCompPgtoMod) Then
    Begin
      pCriarFormularios(TfrmQckCtpCompPgtoMod,frmQckCtpCompPgtoMod);
      frmQckCtpCompPgtoMod.intTipoCfg := fCfgSis('LAY_CP', VarInteger);
      fLoadReport;
    End;

    For intQtdVia := 1 To fCfgSis('VIASCP', varInteger) Do
    Begin
      If blnOrdena Then
         frmQckCtpCompPgtoMod.cdsGenCP.Insert
      Else
         frmQckCtpCompPgtoMod.cdsGenCP.Append;

      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CODFOR').AsString  := qryRelatorio.FieldByName('CODFOR').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('PARCEL').AsString  := qryRelatorio.FieldByName('PARCEL').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CODEMP').AsString  := qryRelatorio.FieldByName('CODEMP').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('SERIE_').AsString  := qryRelatorio.FieldByName('SERIE_').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NOMEMP').AsString  := qryRelatorio.FieldByName('NOMEMP').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NOMFOR').AsString  := qryRelatorio.FieldByName('NOMFOR').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NOMEVE').AsString  := qryRelatorio.FieldByName('NOMEVE').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NOMPOR').AsString  := qryRelatorio.FieldByName('NOMPOR').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DESCUS').AsString  := qryRelatorio.FieldByName('DESCUS').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DESCRE').AsString  := qryRelatorio.FieldByName('DESCRE').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DTACAD').AsDateTime:= qryRelatorio.FieldByName('DTACAD').AsDateTime;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('GUIDES').AsString  := qryRelatorio.FieldByName('GUIDES').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CODPOR').AsString  := qryRelatorio.FieldByName('CODPOR').AsString;

      //MF: 286456 - 02/06/2023 - INI
      If (fCPJaImpresso(qryRelatorio.FieldByName('NUMDUP').AsString,
                        qryRelatorio.FieldByName('PARCEL').AsString,
                        qryRelatorio.FieldByName('SERIE_').AsString,
                        qryRelatorio.FieldByName('CODEMP').AsString,
                        qryRelatorio.FieldByName('CODFOR').AsString)) Then
      Begin
        frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('REIMPR').AsString  :=  '*REIMPRESSÃO*';
        strCtpDescri := 'REIMPRESSÃO';
      End
      Else
      Begin
        frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('REIMPR').AsString  :=  '';
        strCtpDescri := 'IMPRESSÃO';
      End;
      //MF: 286456 - 02/06/2023 - FIM

      If fEmptyStr(qryRelatorio.FieldByName('DTADOC').Text)  Then
      Begin
        frmQckCtpCompPgtoMod.cdsGenCp.FieldByName('DTADOC').AsDateTime:= qryRelatorio.FieldByName('DTADOC').AsDateTime;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('DMPMemo14')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('DMPMemo14')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('DMPMemo28')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('DMPMemo28')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('Memo14')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('Memo14')).Visible  := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('Memo28')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('Memo28')).Visible  := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('Memo1')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('Memo1')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('Memo3')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('Memo3')).Visible := False;
      End
      Else
        frmQckCtpCompPgtoMod.cdsGenCp.FieldByName('DTADOC').AsDateTime:= qryRelatorio.FieldByName('DTADOC').AsDateTime;

      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CHAVE').AsString   := qryRelatorio.FieldByName('CHAVE').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NUMDUP').AsString  := qryRelatorio.FieldByName('NUMDUP').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DTAVEN').AsDateTime:= qryRelatorio.FieldByName('DTAVEN').AsDateTime;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('VEIONF').AsString  := IIF(qryRelatorio.FieldByName('VEIONF').AsString = 'S', 'SIM', 'NÃO');
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CENCUS').AsString  := qryRelatorio.FieldByName('CENCUS').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('HIST01').AsString  := StringReplace(qryRelatorio.FieldByName('HIST01').AsString, STRING_QUEBRA, #13#10, [rfReplaceAll]);
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('HIST02').AsString  := qryRelatorio.FieldByName('HIST02').AsString;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DUPLIC').AsFloat   := qryRelatorio.FieldByName('DUPLIC').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('VALTOT').AsFloat   := qryRelatorio.FieldByName('VALTOT').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('JURSUJ').AsFloat   := qryRelatorio.FieldByName('JURSUJ').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('MULSUJ').AsFloat   := qryRelatorio.FieldByName('MULSUJ').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DESSUJ').AsFloat   := qryRelatorio.FieldByName('DESSUJ').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('VENDOR').AsFloat   := qryRelatorio.FieldByName('VENDOR').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('OUTENT').AsFloat   := qryRelatorio.FieldByName('OUTENT').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('VEIOBO').AsString  := IIF(qryRelatorio.FieldByName('VEIOBO').AsString = 'S', 'SIM', 'NÃO');
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('NUMVIA').AsInteger := intQtdVia;
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('DEPOSITO').AsString:= IIF(qryRelatorio.FieldByName('CTP_DEPOSI').AsString = 'S', 'SIM', 'NÃO');
      frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CHEQUE').AsString  := IIF(qryRelatorio.FieldByName('CTP_USACHQ').AsString = 'S', 'SIM', 'NÃO');

      If qryRelatorio.FieldByName('CTP_DEPOSI').AsString = 'N' then
      Begin
        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblInformaDeposito')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblInformaDeposito')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemInformaDeposito')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemInformaDeposito')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblDadosDeposito')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblDadosDeposito')).Visible   := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemDadosDeposito')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemDadosDeposito')).Visible   := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('lblDadosDepositoM')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('lblDadosDepositoM')).Visible  := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('MemDadosDepositoM')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_M.FindObject('MemDadosDepositoM')).Visible  := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblDadosDeposito3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblDadosDeposito3Vias')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('MemDadosDeposito3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('MemDadosDeposito3Vias')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblInfoDeposito3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblInfoDeposito3Vias')).Visible    := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblMemInfodeposito3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblMemInfodeposito3Vias')).Visible := False;
      End
      Else
      Begin
        If qryRelatorio.FieldByName('CONTABANCO').IsNull Then
          frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CONTABANCO').AsString := qryRelatorio.FieldByName('CHAVEPIX').AsString
        Else
          frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CONTABANCO').AsString := qryRelatorio.FieldByName('CONTABANCO').AsString;

        If qryRelatorio.FieldByName('CONTADEPOSITO').IsNull Then
          frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CONTADEPOSITO').AsString := qryRelatorio.FieldByName('CHAVEPIX').AsString
        Else
        frmQckCtpCompPgtoMod.cdsGenCP.FieldByName('CONTADEPOSITO').AsString := qryRelatorio.FieldByName('CONTADEPOSITO').AsString;
      End;

      If qryRelatorio.FieldByName('CTP_USACHQ').AsString = 'N' then
      Begin
        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblInformaCheque')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblInformaCheque')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemInformaCheque')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('MemInformaCheque')).Visible := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblInfoCheque3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblInfoCheque3Vias')).Visible  := False;

        If Assigned(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblMemInfoCheque3Vias')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxMod3Vias.FindObject('lblMemInfoCheque3Vias')).Visible  := False;
      End;

      If Not qryRelatorio.FieldByName('GUIDES').IsNull Then
      Begin
        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblGuia')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('lblGuia')).Visible := True;

        If Assigned(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('memDadosGuia')) Then
          TfrxMemoView(frmQckCtpCompPgtoMod.frxCtpCompPg_J.FindObject('memDadosGuia')).Visible := True;
      End;

      frmQckCtpCompPgtoMod.cdsGenCP.Post;
    End;

    qryCtpDet.First;
    While not qryCtpDet.Eof Do
    Begin
      frmQckCtpCompPgtoMod.cdsGenDT.Insert;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_CODFOR').AsString  := qryCtpDet.FieldByName('CTP_CODFOR').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_NUMDUP').AsString  := qryCtpDet.FieldByName('CTP_NUMDUP').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_PARCEL').AsString  := qryCtpDet.FieldByName('CTP_PARCEL').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_EMPORI').AsString  := qryCtpDet.FieldByName('CTP_EMPORI').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_SERIE_').AsString  := qryCtpDet.FieldByName('CTP_SERIE_').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_CODCTA').AsString  := qryCtpDet.FieldByName('CTP_CODCTA').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTA_DESCTA').AsString  := qryCtpDet.FieldByName('CTA_DESCTA').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_CODEMP').AsString  := qryCtpDet.FieldByName('CTP_CODEMP').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_CODEVE').AsString  := qryCtpDet.FieldByName('CTP_CODEVE').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('EVE_DESEVE').AsString  := qryCtpDet.FieldByName('EVE_DESEVE').AsString;
      frmQckCtpCompPgtoMod.cdsGenDT.FieldByName('CTP_FATCAL').AsFloat   := qryCtpDet.FieldByName('CTP_FATCAL').AsFloat;
      frmQckCtpCompPgtoMod.cdsGenDT.Post;

      qryCtpDet.Next;
    End;

    qryCtpChq.First;
    While not qryCtpChq.Eof Do
    Begin
      frmQckCtpCompPgtoMod.cdsGenCH.Insert;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('CHQBCO').AsString  := qryCtpChq.FieldByName('CHQBCO').AsString;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('CHQAGE').AsString  := qryCtpChq.FieldByName('CHQAGE').AsString;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('CHQCOR').AsString  := qryCtpChq.FieldByName('CHQCOR').AsString;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('NUMCHQ').AsString  := qryCtpChq.FieldByName('NUMCHQ').AsString;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('CHQCLI').AsString  := qryCtpChq.FieldByName('CHQCLI').AsString;
      frmQckCtpCompPgtoMod.cdsGenCH.FieldByName('CHQVEN').AsString  := qryCtpChq.FieldByName('CHQVEN').AsString;
      qryCtpChq.Next
    End;

    If blnOrdena Then
       frmQckCtpCompPgtoMod.cdsGenCP.IndexFieldNames := 'NUMDUP;CHAVE';

    If Not blnReimpressao Then
      pEfetuaImpressao(blnReimpressao, strNomForm);

     //MF: 286456 - 05/06/2023  - INI - GRAVAÇÃO DO LOGCTP INDICANDO A IMPRESSÃO/REIMPRESSÃO
    {strAutCtp := fCampoTabela('AUTOINCREM',
                                'CADPAG',
                                ['CTP_NUMDUP', 'CTP_PARCEL', 'CTP_CODEMP', 'CTP_CODFOR', 'CTP_SERIE_'],
                                [qryRelatorio.FieldByName('NUMDUP').AsString,
                                 qryRelatorio.FieldByName('PARCEL').AsString,
                                 qryRelatorio.FieldByName('CODEMP').AsString,
                                 qryRelatorio.FieldByName('CODFOR').AsString,
                                 qryRelatorio.FieldByName('SERIE_').AsString],
                                True);  }

    untLogCtp.GravaLogCtp(qryRelatorio.FieldByName('AUTOINCREM').AsString,
                          strCtpDescri + ' CP',
                          strNomForm);
    //MF: 286456 - 05/06/2023  - FIM


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Erro ao gerar Controle de Pagamento !','[ImprimeCP]');
    End;
  End;
  FreeAndNil(qryRelatorio);
  FreeAndNil(qryCtpChq);
end;

procedure pEfetuaImpressao(blnReimpressao: Boolean; strNomForm: String; blnImpSel : Boolean);
  Var
    frxContPg : TfrxReport;
Begin
  If blnVerificaImpressao = False Then
    pVerificaImpressao(blnReimpressao, strNomForm);

  If fCfgSis('LAY_CP', VarString) = '3' Then
  Begin
    frxContPg := frmQckCtpCompPgtoMod.frxMod3Vias;

    {If blnReimpressao Then  //MF: 286456 - 06/06/2023
    Begin
      If Assigned(frxContPg.FindObject('rllReimpressao')) Then
      Begin
        TfrxMemoView(frxContPg.FindObject('rllReimpressao')).Memo.Text := 'Ficha Autorização de Pagamento    *REIMPRESSÃO*';

      End;
    End
    Else
    Begin
      If Assigned(frxContPg.FindObject('rllReimpressao')) Then
        TfrxMemoView(frxContPg.FindObject('rllReimpressao')).Memo.Text := 'Ficha Autorização de Pagamento';
    End; }
  End
  Else
  Begin
    If strTipImp = 'M' Then
      frxContPg := frmQckCtpCompPgtoMod.frxCtpCompPg_M
    Else
    Begin
      if blnImpSel then
        frxContPg := frmQckCtpCompPgtoMod.frxCtpCompPgSelecionadas_J
      else
        frxContPg := frmQckCtpCompPgtoMod.frxCtpCompPg_J;
      frxContPg.PrintOptions.PrintMode    := pmScale;
      frxContPg.PrintOptions.PrintOnSheet := 9; //A4
      frmQckCtpCompPgtoMod.strTipoImpressao := 'J';
    End;

    If fCfgSis('LAY_CP', VarString) = '2' Then
    Begin
      If Assigned(frxContPg.FindObject('MasterData1')) Then
        TfrxMasterData(frxContPg.FindObject('MasterData1')).StartNewPage := True
    End
    Else
    Begin
      If Assigned(frxContPg.FindObject('MasterData1')) Then
        TfrxMasterData(frxContPg.FindObject('MasterData1')).StartNewPage := False;
    End;

    frxContPg.Script.Variables['NOMREL'] := ' C.P. CONTROLE DE PAGAMENTO';

    if Not fCfgSis('CTPVND', varBoolean) Then
    Begin
      If Assigned(frxContPg.FindObject('rllValorTotal')) And Assigned(frxContPg.FindObject('rllTotalDoc')) Then
        TfrxMemoView(frxContPg.FindObject('rllValorTotal')).Top := TfrxMemoView(frxContPg.FindObject('rllTotalDoc')).Top;

      If Assigned(frxContPg.FindObject('rlbValorTotal')) And Assigned(frxContPg.FindObject('rlbTotalDoc')) Then
        TfrxMemoView(frxContPg.FindObject('rlbValorTotal')).Top := TfrxMemoView(frxContPg.FindObject('rlbTotalDoc')).Top;

      If Assigned(frxContPg.FindObject('rllTotalDoc')) And Assigned(frxContPg.FindObject('rllVendor'))  Then
        TfrxMemoView(frxContPg.FindObject('rllTotalDoc')).Top := TfrxMemoView(frxContPg.FindObject('rllVendor')).Top;

      If Assigned(frxContPg.FindObject('rlbTotalDoc')) And Assigned(frxContPg.FindObject('rlbVendor')) Then
        TfrxMemoView(frxContPg.FindObject('rlbTotalDoc')).Top := TfrxMemoView(frxContPg.FindObject('rlbVendor')).Top;
    End;
  End;

  If Assigned(frxContPg.FindObject('rllVendor')) Then
    TfrxMemoView(frxContPg.FindObject('rllVendor')).Visible := fCfgSis('CTPVND', varBoolean);

  If Assigned(frxContPg.FindObject('rlbVendor')) Then
    TfrxMemoView(frxContPg.FindObject('rlbVendor')).Visible := fCfgSis('CTPVND', varBoolean);

  frmQckCtpCompPgtoMod.frxDataCtp.DataSet := frmQckCtpCompPgtoMod.cdsGenCP;
  frmQckCtpCompPgtoMod.frxCtpDet.DataSet := frmQckCtpCompPgtoMod.cdsGenDT;
  frmQckCtpCompPgtoMod.frxCtpChq.DataSet := frmQckCtpCompPgtoMod.cdsGenCH;

  If (Not fEmptyStr(strNomImp)) Then
  Begin
    frxContPg.PrintOptions.ShowDialog := False;
    frxContPg.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');
  End;

  If frxContPg.PrepareReport Then
    pPrintReport(strNomForm, 'C.P. CONTROLE DE PAGAMENTO', strNomImp, frxContPg);

  FreeAndNil(frmQckCtpCompPgtoMod);
End;

procedure pCriaClientTemporariaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var cdsTemp: TUniClientDataSet);
Var
    LCtpDet: TUniClientDataset;
Begin
  pCriaClientTemporariaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, cdsTemp, LCtpDet);

  FreeAndNil(LCtpDet);
End;

procedure pCriaClientTemporariaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var cdsTemp, ACtpDet: TUniClientDataSet);
  Var
    strSQL   : String;
    qryGenDet: TUniQuery;
begin
  qryGenDet := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTPDET.AUTOINCREM AS INCREMENTO, ';
    strSQL := strSQL + '  "D" AS CTP_MARDES, ';
    strSQL := strSQL + '  CTP_NUMDUP, ';
    strSQL := strSQL + '  CTP_PARCEL, ';
    strSQL := strSQL + '  CTP_CODEMP, ';
    strSQL := strSQL + '  CTP_CODCTA, ';
    strSQL := strSQL + '  CTA_DESCTA, ';
    strsqL := strSQL + '  CTP_CODFOR, ';
    strSQL := strSQL + '  CTP_SERIE_, ';
    strSQL := strSQL + '  "" AS AUTOINCREM, ';
    strSQL := strSQL + '  CTP_DEBCRE, ';
    strSQL := strSQL + '  IFNULL(CTP_CODEVE," ") AS CTP_CODEVE, ';
    strSQL := strSQL + '  0.00 AS CTP_VALDUP, ';
    strSQL := strSQL + '  CTP_FATCAL,  ';
    strSQL := strSQL + '  0.00 AS PERCENTUAL, ';
    strSQL := strSQL + '  "0" AS TIPOACAO ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CTPDET ';
    strSQL := strSQL + '  JOIN CADCTA ON CADCTA.CTA_CODCTA=CTPDET.CTP_CODCTA ';
    strSQL := strSQL + 'WHERE ';
    If Not strNumDup.IsEmpty Then
    Begin
      strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
 
      If (fEmptyStr(strSerie)) Then
        strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
      Else
        strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
 
      strSQL := strSQL + '  CTP_EMPORI = :EMPORI AND ';
      strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';
 
      qryGenDet.Close;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add(strSQL);
      qryGenDet.ParamByName('NUMDUP').AsString := strNumDup;
      qryGenDet.ParamByName('PARCEL').AsString := strParcel;
 
      If (Not fEmptyStr(strSerie)) Then
        qryGenDet.ParamByName('SERIE_').AsString := strSerie;

      qryGenDet.ParamByName('EMPORI').AsString := strCodEmp;
      qryGenDet.ParamByName('CODFOR').AsString := strCodFor;
    End
    Else
      qryGenDet.SQL.Text := strSQL + '  FALSE ';

  qryGenDet.Open;
 
    ACtpDet := fCriaClientDatset(qryGenDet);
    ACtpDet.Open;
    ACtpDet.First;
 
    cdsTemp := fCriaClientDatset(qryGenDet);
    cdsTemp.Open;
    cdsTemp.First;
  Finally
    qryGenDet.Close;
 
    FreeAndNil(qryGenDet);
  End;
end;

procedure pInicializaImpressaoCP;
begin
  SetLength(arrImpressaoCP, 0);
end;

procedure pAdicionaImpressaoCP(strNumDup,
                               strParcel,
                               strCodFor,
                               strSerie_,
                               strNomFrm: String);
Begin

  SetLength(arrImpressaoCP, Succ(Length(arrImpressaoCP)));

  arrImpressaoCP[High(arrImpressaoCP)].strNumDup := strNumDup;
  arrImpressaoCP[High(arrImpressaoCP)].strParcel := strParcel;
  arrImpressaoCP[High(arrImpressaoCP)].strCodFor := strCodFor;
  arrImpressaoCP[High(arrImpressaoCP)].strSerie_ := strSerie_;
  arrImpressaoCP[High(arrImpressaoCP)].strNomFrm := strNomFrm;

End;

procedure pVerificaImpressao(blnReimpressao: Boolean; strNomForm: String);
  var
    qryCfgRel: TUniQuery;
Begin
  If blnPedirFilaImp Or fEmptyStr(strNomImp) Then
  Begin
    qryCfgRel := fCriaQuery;

    If blnReimpressao Then
      pCarregaConfImpr(qryCfgRel, 'frmReimpressao_CP')
    Else
      pCarregaConfImpr(qryCfgRel, strNomForm + '_CP');

    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);
    FreeAndNil(qryCfgRel);
  End;
End;

{******************************************************}
{* FUNCAO QUE APAGA DUPLICATAS DO CADPAG              *}
{* OBS: JA GRAVA NAS TABELAS LOGCTP E DEL_CADPAG      *}
{**************************21/03/2018**Req. 68936**WS**}
function fApagaDuplicataContasPagar(qryTabCadPag: TUniQuery; strNomeFormulario: String; strDescri: String = ''): Boolean;
  Var
    strSQL: String;

    blnCommit: Boolean;
Begin

  Try

    Result := True;

    {*************************************************}
    {*  CASO NAO ESTEJA EM TRANSACAO INICIA UMA NOVA *}
    {**********************************************WS*}
    blnCommit := (Not frmModulo.GetCurrentConnection.InTransaction);

    If blnCommit Then
      fStartTransaction;

    With qryTabCadPag Do
    Begin
      {******************************************}
      {* FORÇA NULO NO CAMPO NOMFRM PRA GRAVAR  *}
      {* O NOME DO FORMULÁRIO NA TAB DEL_CADPAG *}
      {***************************************WS*}
      qryTabCadPag.Edit;
      qryTabCadPag.FieldByName('CTP_NOMFRM').Value := Null;
      qryTabCadPag.Post;
      {**********************}
      {* GRAVA DEL_CADPAG   *}
      {*******************WS*}
      If Result Then
         fVerificaIntegridade(strNomeFormulario, 'CADPAG', qryTabCadPag);

      {****************}
      {* GRAVA LOGCTP *}
      {*************WS*}
      If Result Then
        untLogCtp.GravaLogCtp(FieldByName('AUTOINCREM').AsString,
                              IIF(fEmptyStr(strDescri), 'EXCLUSÃO DE DUPLICATA', strDescri),
                              strNomeFormulario);

      {********************}
      {* EXCLUI DUPLICATA *}
      {*****************WS*}
      strSQL := '';
      strSQL := strSQL + ' DELETE   ';
      strSQL := strSQL + ' FROM     ';
      strSQL := strSQL + '   CADPAG ';
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   CTP_NUMDUP = ' + QuotedStr(FieldByName('CTP_NUMDUP').AsString) + ' AND ';
      strSQL := strSQL + '   CTP_PARCEL = ' + QuotedStr(FieldByName('CTP_PARCEL').AsString) + ' AND ';
      strSQL := strSQL + '   CTP_SERIE_ = ' + QuotedStr(FieldByName('CTP_SERIE_').AsString) + ' AND ';
      strSQL := strSQL + '   CTP_CODEMP = ' + QuotedStr(FieldByName('CTP_CODEMP').AsString) + ' AND ';
      strSQL := strSQL + '   CTP_CODFOR = ' + QuotedStr(FieldByName('CTP_CODFOR').AsString) + ' AND ';
      strSQL := strSQL + '   CTP_SEQBAI = ' +           FieldByName('CTP_SEQBAI').AsString  + '     ';

      Result := Result And fExecutaSQL(strSQL);

      {**********************************************}
      {* CASO CRIOU UMA NOVA TRANSACAO ENTAO COMITA *}
      {*******************************************WS*}
      If blnCommit and Result Then
        fCommit;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, 'fApagaDuplicataContasPagar');
    End;
  End;

end;

Procedure pImprimeCPs;
  Var
    intContador: Integer;
Begin

  Try
    For intContador := Low(arrImpressaoCP) To High(arrImpressaoCP) Do
      With arrImpressaoCP[intContador] Do
      Begin
        ImprimeCP(strNumDup,
                  strParcel,
                  VS_strCodEmp,
                  strCodFor,
                  strSerie_,
                  strNomFrm);

        blnPedirFilaImp := False;//Para nao solicitar novamente a fila de impressao
      End;
  Finally
    blnPedirFilaImp := True;
  End;

End;

Function fDesmembraValoresCtaDet(poParametros: TParametrosDesmembraValoresCtaDet): Boolean;
Var
  objListRateios: TCtaDetList;
  intIndex: Integer;
begin
  Result := False;
  poParametros.SetStrCodCta(NullAsStringValue);
  objListRateios := TCtaDet.fRetornaRateios(poParametros.strNumCta);
  try
    If objListRateios.Count > 0 Then
    begin
      If ((poParametros.blnDireto) or (fMensagem('ATENÇÃO!', 'Deseja ativar o rateio?', ['&Sim', '&Não']) = 1)) Then
      begin
        pCriaClientTemporariaCtpDet(NullAsStringValue,
                                    NullAsStringValue,
                                    NullAsStringValue,
                                    NullAsStringValue,
                                    NullAsStringValue,
                                    poParametros.cdsTemp);

        If Not poParametros.cdsTemp.Active Then
          poParametros.cdsTemp.Open;

        for intIndex := 0 to objListRateios.Count - 1 do
        begin
          poParametros.cdsTemp.Insert;
          poParametros.cdsTemp.FieldByName('CTP_MARDES').AsString := 'D';
          poParametros.cdsTemp.FieldByName('TIPOACAO').AsString := '1';

          if not fEmptyStr(objListRateios[intIndex].strEmpDet) then
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := objListRateios[intIndex].strEmpDet
          else if not fEmptyStr(poParametros.strCodEmp) then
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := poParametros.strCodEmp
          else
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := VS_strCodEmp;

          if not fEmptyStr(objListRateios[intIndex].strCtaDet) then
            poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString := objListRateios[intIndex].strCtaDet
          else
            poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString := poParametros.strNumCta;

          poParametros.cdsTemp.FieldByName('CTA_DESCTA').AsString := fRetNomeConta(poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString);

          poParametros.cdsTemp.FieldByName('CTP_CODEVE').AsString := IIF(fEmptyStr(objListRateios[intIndex].strCodEve),
                                                                                                poParametros.strCodEve,
                                                                                   objListRateios[intIndex].strCodEve);

          If objListRateios[intIndex].fltPerCen < 0 Then
            objListRateios[intIndex].fltPerCen := objListRateios[intIndex].fltPerCen * -1;

          poParametros.cdsTemp.FieldByName('CTP_FATCAL').AsFloat  := objListRateios[intIndex].fltPerCen / 100;
          poParametros.cdsTemp.FieldByName('CTP_VALDUP').AsFloat  := (poParametros.fltValDup * (objListRateios[intIndex].fltPerCen / 100));
          poParametros.cdsTemp.Post;
        end;
        Result := True;
        If fVerificaSeTodasContasSaoIguais(poParametros.cdsTemp) Then
          poParametros.SetStrCodCta(poParametros.strNumCta);
      end;
    end;
  finally
    objListRateios.Free;
  end;
end;

Function fDesmembraValoresCtaDet(poParametros: TParametrosDesmembraValores): Boolean;
Var
  objListRateios: TCtaDetList;
  intIndex: Integer;
begin
  Result := False;
  poParametros.SetStrCodCta(NullAsStringValue);
  objListRateios := TCtaDet.fRetornaRateios(poParametros.strNumCta);
  try
    If objListRateios.Count > 0 Then
    begin
      If ((poParametros.blnDireto) or (fMensagem('ATENÇÃO!', 'Deseja ativar o rateio?', ['&Sim', '&Não']) = 1)) Then
      begin

        If Not Assigned(poParametros.cdsTemp) Then
          pCriaClientTemporariaCtpDet(NullAsStringValue,
                                      NullAsStringValue,
                                      NullAsStringValue,
                                      NullAsStringValue,
                                      NullAsStringValue,
                                      poParametros.cdsTemp);

        If Not poParametros.cdsTemp.Active Then
          poParametros.cdsTemp.Open;

        for intIndex := 0 to objListRateios.Count - 1 do
        begin
          poParametros.cdsTemp.Insert;
          poParametros.cdsTemp.FieldByName('CTP_MARDES').AsString := 'D';
          poParametros.cdsTemp.FieldByName('TIPOACAO').AsString := '1';

          if not fEmptyStr(objListRateios[intIndex].strEmpDet) then
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := objListRateios[intIndex].strEmpDet
          else if not fEmptyStr(poParametros.strCodEmp) then
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := poParametros.strCodEmp
          else
            poParametros.cdsTemp.FieldByName('CTP_CODEMP').AsString := VS_strCodEmp;

          if not fEmptyStr(objListRateios[intIndex].strCtaDet) then
            poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString := objListRateios[intIndex].strCtaDet
          else
            poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString := poParametros.strNumCta;

          poParametros.cdsTemp.FieldByName('CTA_DESCTA').AsString := fRetNomeConta(poParametros.cdsTemp.FieldByName('CTP_CODCTA').AsString);

          poParametros.cdsTemp.FieldByName('CTP_CODEVE').AsString := IIF(fEmptyStr(objListRateios[intIndex].strCodEve),
                                                                                                poParametros.strCodEve,
                                                                                   objListRateios[intIndex].strCodEve);

          If objListRateios[intIndex].fltPerCen < 0 Then
            objListRateios[intIndex].fltPerCen := objListRateios[intIndex].fltPerCen * -1;

          poParametros.cdsTemp.FieldByName('CTP_FATCAL').AsFloat  := objListRateios[intIndex].fltPerCen / 100;
          poParametros.cdsTemp.FieldByName('CTP_VALDUP').AsFloat  := (poParametros.fltValDup * (objListRateios[intIndex].fltPerCen / 100));
          poParametros.cdsTemp.FieldByName('AUTOINCREM').AsString := poParametros.strAutoin;
          poParametros.cdsTemp.Post;
        end;
        Result := True;
        If fVerificaSeTodasContasSaoIguais(poParametros.cdsTemp) Then
          poParametros.SetStrCodCta(poParametros.strNumCta);
      end;
    end;
  finally
    objListRateios.Free;
  end;
end;

{*****************************************}
{* VERIFICA SE A DUPLICATA CONTEM UM     *}
{* DESMEMBRAMENTO DE VALORES. RETORNA    *}
{* TRUE SE EXISTE.                       *}
{**************************************MV*}
function fVerificaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; Var blnRatEve : Boolean): Boolean;
Var
  strSQL: String;
  qryGenDet: TUniQuery;
begin
  qryGenDet := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *    ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CTPDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  CTP_EMPORI = :EMPORI AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    qryGenDet.SQL.Text := strSQL;
    qryGenDet.ParamByName('NUMDUP').AsString  := strNumDup;
    qryGenDet.ParamByName('PARCEL').AsString  := strParcel;
    If (Not fEmptyStr(strSerie)) Then
      qryGenDet.ParamByName('SERIE_').AsString  := strSerie;

    qryGenDet.ParamByName('EMPORI').AsString  := strCodEmp;
    qryGenDet.ParamByName('CODFOR').AsString  := strCodFor;
    qryGenDet.Open;

    Result := Not qryGenDet.IsEmpty;

    blnRatEve := fVerificaEvenRat(qryGenDet);
  Finally
    qryGenDet.Close;
    FreeAndNil(qryGenDet);
  End;
end;

function fVerificaEvenRat(ACtpDet: TDataset): Boolean;
var
  strCodEve: String;
begin
  Result    := False;
  strCodEve := '';

  If Assigned(ACtpDet) And ACtpDet.Active Then
  Begin
    If Not ACtpDet.IsEmpty Then
    Begin
      ACtpDet.First;
      While Not ACtpDet.Eof Do
      Begin
        if strCodEve = EmptyStr then

        Result := Not fEmptyStr(ACtpDet.FieldByName('CTP_CODEVE').AsString);
        If Result Then
          Break;
        ACtpDet.Next;
      End;

      ACtpDet.First;
    End;
  End;

end;

procedure pGravaLogCtpDet(AstrAutoIncremento, strDescricaoLog, strNomForm: String);
begin
  Try
    untLogCtpDet.GravaLogCtpDet(AstrAutoIncremento, strDescricaoLog, strNomForm);
  Except
    On E: Exception Do
     Raise Exception.Create(E.Message + ' - [frmBaixaCtaPagar.pGravaLogCtpDet]');
  End;
end;

function HouveAlteracaoCTPDet(ADatasetCTPDet,
  ADatasetTemporarioCTPDet: TDataset): Boolean;
  Var
    LPercentualAtual,
    LPercentualSelect: Double;
Begin
  Result := False;

  LPercentualAtual := fFormataFloat(ADatasetTemporarioCTPDet.fieldByName('CTP_FATCAL').AsFloat * 100, 2);
  LPercentualSelect := fFormataFloat(ADatasetCTPDet.FieldByName('CTP_FATCAL').AsFloat * 100, 2);

  If LPercentualAtual <> LPercentualSelect Then
    Exit(True);

  If Not ADatasetTemporarioCTPDet.fieldByName('CTP_CODCTA').AsString.Equals(ADatasetCTPDet.FieldByName('CTP_CODCTA').AsString) Then
    Exit(True);

  If Not ADatasetTemporarioCTPDet.fieldByName('CTP_CODEMP').AsString.Equals(ADatasetCTPDet.FieldByName('CTP_CODEMP').AsString) Then
    Exit(True);

  If Not ADatasetTemporarioCTPDet.fieldByName('CTP_CODEVE').AsString.Equals(ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString) Then
    Exit(True);
End;

function fGravaFatorCalculado(ANumeroDuplicata,
                              AParcela,
                              ACodigoEmpresa,
                              ACodigoFornecedor,
                              ASerie: String;
                              ADatasetCTPDet: TDataset;
                              ANomeFormulario: String;
                              ADatasetNovo: Boolean): Boolean;
  Var
    LGravacaoCTPDet: TUniQuery;

    LDescricaoLog: String;
Begin
  Result := Not ANomeFormulario.Equals('frmCadCtaPagar');

  LGravacaoCTPDet := fCriaQuery;

  Try
    ADatasetCTPDet.First;

    LGravacaoCTPDet.SQL.Add('SELECT * ');
    LGravacaoCTPDet.SQL.Add('FROM CTPDET ');
    LGravacaoCTPDet.SQL.Add('WHERE CTP_CODFOR = :CODFOR AND ');
    LGravacaoCTPDet.SQL.Add('      CTP_NUMDUP = :NUMDUP AND ');
    LGravacaoCTPDet.SQL.Add('      CTP_PARCEL = :PARCEL AND ');
    LGravacaoCTPDet.SQL.Add('      CTP_EMPORI = :CODEMP AND ');
    If ASerie.IsEmpty Then
      LGravacaoCTPDet.SQL.Add('    (CTP_SERIE_ IS NULL OR CTP_SERIE_ = "") ')
    Else
    Begin
      LGravacaoCTPDet.SQL.Add('    CTP_SERIE_ = :SERIE_     ');
      LGravacaoCTPDet.ParamByName('SERIE_').AsString := ASerie;
    End;

    LGravacaoCTPDet.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LGravacaoCTPDet.ParamByName('PARCEL').AsString := AParcela;
    LGravacaoCTPDet.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LGravacaoCTPDet.ParamByName('CODFOR').AsString := ACodigoFornecedor;

    LGravacaoCTPDet.Open;

    LGravacaoCTPDet.First;

    //Exclusão
    ADatasetCTPDet.Filter := 'TIPOACAO=''3'' ';
    ADatasetCTPDet.Filtered := True;
    ADatasetCTPDet.First;

    While Not ADatasetCTPDet.Eof Do
    Begin
      untLogCtpDet.GravaLogCtpDet(ADatasetCTPDet.FieldByName('INCREMENTO').AsString,
                                  'EXCLUSÃO',
                                  'frmDesmembrValores');

      LGravacaoCTPDet.Locate('AUTOINCREM', ADatasetCTPDet.FieldByName('INCREMENTO').AsString, []);
      LGravacaoCTPDet.Delete;

      ADatasetCTPDet.Next;
    End;

    ADatasetCTPDet.Filter := 'TIPOACAO=''1'' OR TIPOACAO=''2'' ';
    ADatasetCTPDet.Filtered := True;
    ADatasetCTPDet.First;

    While Not ADatasetCTPDet.Eof Do
    Begin
      //Inclusão
      If ADatasetCTPDet.FieldByName('TIPOACAO').AsString.Equals('1') Then
      Begin
        LDescricaoLog := 'INCLUSÃO';

        LGravacaoCTPDet.Last;
        LGravacaoCTPDet.Append;
        LGravacaoCTPDet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', ACodigoEmpresa);

        LGravacaoCTPDet.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
        LGravacaoCTPDet.FieldByName('CTP_PARCEL').AsString := AParcela;
        LGravacaoCTPDet.FieldByName('CTP_SERIE_').AsString := ASerie;
        LGravacaoCTPDet.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
        LGravacaoCTPDet.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      End
      //Alteração
      Else
      Begin
        LDescricaoLog := 'ALTERAÇÃO';

        LGravacaoCTPDet.Locate('AUTOINCREM', ADatasetCTPDet.FieldByName('INCREMENTO').AsString, []);

        If Not HouveAlteracaoCTPDet(LGravacaoCTPDet, ADatasetCTPDet) Then
        Begin
          ADatasetCTPDet.Next;
          Continue;
        End;

        LGravacaoCTPDet.Edit;
      End;

      LGravacaoCTPDet.FieldByName('CTP_CODEMP').AsString := ADatasetCTPDet.FieldByName('CTP_CODEMP').AsString;
      LGravacaoCTPDet.FieldByName('CTP_CODCTA').AsString := ADatasetCTPDet.FieldByName('CTP_CODCTA').AsString;
      LGravacaoCTPDet.FieldByName('CTP_DEBCRE').AsString := ADatasetCTPDet.FieldByName('CTP_DEBCRE').AsString;
      LGravacaoCTPDet.FieldByName('CTP_FATCAL').Value := ADatasetCTPDet.FieldByName('CTP_FATCAL').Value;

      LGravacaoCTPDet.FieldByName('CTP_CODEVE').Value := Null;
      If Not ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString.IsEmpty Then
        LGravacaoCTPDet.FieldByName('CTP_CODEVE').Value := ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString;

      LGravacaoCTPDet.Post;

      pGravaLogCtpDet(LGravacaoCTPDet.FieldByName('AUTOINCREM').AsString,
                      LDescricaoLog,
                      'frmDesmembrValores');

      Result := True;

      ADatasetCTPDet.Next;
    End;
  Finally
    LGravacaoCTPDet.Close;
    FreeAndNil(LGravacaoCTPDet);
  End;
End;

function RetornaRecordChaveDuplicata(ANumeroDuplicata,
                                     AParcela,
                                     ACodigoEmpresa,
                                     ACodigoFornecedor,
                                     ASerie: String): TDuplicataCtp;
Begin
  Result.strNumDup := ANumeroDuplicata;
  Result.strParcel := AParcela;
  Result.strCodEmp := ACodigoEmpresa;
  Result.strCodFor := ACodigoFornecedor;
  Result.strSerie_  := ASerie;
End;

procedure AlteraChaveCtpDet(AChaveAnterior,
                            ANovaChave: TDuplicataCtp;
                            ANomeFormulario: String);
  Var
    LSelectCTPDet: TUniQuery;
begin
  LSelectCTPDet := fCriaQuery(Nil);

  Try
    LSelectCTPDet.SQL.Clear;
    LSelectCTPDet.SQL.Add('SELECT * FROM CTPDET  ');
    LSelectCTPDet.SQL.Add('WHERE CTP_NUMDUP = :DUPANT AND ');
    LSelectCTPDet.SQL.Add('      CTP_PARCEL = :PARCEL AND ');
    LSelectCTPDet.SQL.Add('      CTP_EMPORI = :EMPORI AND ');
    LSelectCTPDet.SQL.Add('      CTP_CODFOR = :CODFORANT AND ');

    If AChaveAnterior.strSerie_.IsEmpty Then
      LSelectCTPDet.SQL.Add('  (CTP_SERIE_ IS NULL OR CTP_SERIE_ = "") ')
    Else
      LSelectCTPDet.SQL.Add('  CTP_SERIE_ = "' + AChaveAnterior.strSerie_ + '" ');

    LSelectCTPDet.ParamByName('DUPANT').AsString  := AChaveAnterior.strNumDup;
    LSelectCTPDet.ParamByName('PARCEL').AsString  := AChaveAnterior.strParcel;
    LSelectCTPDet.ParamByName('EMPORI').AsString  := AChaveAnterior.strCodEmp;
    LSelectCTPDet.ParamByName('CODFORANT').AsString  := AChaveAnterior.strCodFor;

    LSelectCTPDet.Open;

    If LSelectCTPDet.IsEmpty then
      Exit;

    While Not LSelectCTPDet.Eof Do
    Begin
      LSelectCTPDet.Edit;
      LSelectCTPDet.FieldByName('CTP_NUMDUP').AsString := ANovaChave.strNumDup;
      LSelectCTPDet.FieldByName('CTP_PARCEL').AsString := ANovaChave.strParcel;
      LSelectCTPDet.FieldByName('CTP_EMPORI').AsString := ANovaChave.strCodEmp;
      LSelectCTPDet.FieldByName('CTP_CODFOR').AsString := ANovaChave.strCodFor;
      LSelectCTPDet.FieldByName('CTP_SERIE_').AsString := ANovaChave.strSerie_;
      LSelectCTPDet.Post;

      pGravaLogCtpDet(LSelectCTPDet.FieldByName('AUTOINCREM').AsString,
                      'ALTERAÇÃO DE CHAVE',
                      ANomeFormulario);

      LSelectCTPDet.Next;
    End;
  Finally
    LSelectCTPDet.Close;
    FreeAndNil(LSelectCTPDet);
  End;
End;

function fVerificaSeTodasContasSaoIguais(cdsTemp: TUniClientDataSet): Boolean;
 Var
   strCodCta : String;
begin
  Result := True;

  If Not cdsTemp.Active Then
    cdsTemp.Open;

  With cdsTemp Do
  Begin
    First;
    strCodCta := FieldByName('CTP_CODCTA').AsString;

    While Not Eof Do
    Begin
      If FieldByName('CTP_CODCTA').AsString <> strCodCta Then
      Begin
        Result := False;
        Exit;
      End
      Else
        Next;
    End;
  End;
end;

function fBuscaHist(strNumDup, strParcel, strCodEmp, strCodFor:String;strSerie:String=''):String;
Var
  qryGenPag:TUniQuery;
  strSQL : String;
begin
  {*****************************************}
  {* BUSCA DADOS DA DUPLICATA ANTES DE     *}
  {* BAIXAR                                *}
  {**************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTP_HIST01 ';
  strSQL := strSQL + 'FROM CADPAG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

  If (fEmptyStr(strSerie)) Then
    strSQL := strSQL + '  IFNULL(CTP_SERIE_, "") = ""  AND '
  Else
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_  AND  ';

  strSQL := strSQL + 'CTP_SEQBAI = 0 ';
  qryGenPag := fCriaQuery;

  With qryGenPag Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;

    If (Not fEmptyStr(strSerie)) Then
      ParamByName('SERIE_').AsString := strSerie;
    Open;

    Result := FieldByName('CTP_HIST01').AsString;
  End;

  FreeAndNil(qryGenPag);

end;

function getSQLDadosBancariosFornecedor(ASelecionaChavesPIX: Boolean = False): String;
begin
  Result := 'SELECT * FROM ( ' +
            '  SELECT B.AUTOINCREM, ' +
            '  CONCAT("BCO: ", RPAD(B.BCF_CODBCO, 4, " "), ' +
            '         "AG: ", RPAD(CONCAT(B.BCF_NUMAGE, IF(B.BCF_DIGAGE = "", "", "-"), B.BCF_DIGAGE), 8, " "), ' +
            '         "CONTA: ", RPAD(CONCAT(B.BCF_NUMCTA, IF(B.BCF_DIGCTA = "", "", "-"), B.BCF_DIGCTA), 14, " "), '+
            '         "TIT.:" , RPAD(IFNULL(B.BCF_NOMTIT, ""), 20, " ") ) AS DESC_CONTA, ' +
            '         "CONTA" AS TIPO_CONTA               ' +
            '  FROM BCOFOR B WHERE B.BCF_CODFOR = :CODFOR ';

  If ASelecionaChavesPix Then
  Begin
    Result := Result + '  UNION ALL ' +

                       '  SELECT P.AUTOINCREM, ' +
                       '         CONCAT("PIX ", P.PIX_TIPCHV,": ", ' +
                       '                P.PIX_CHAVE_) AS DESC_CONTA, ' +
                       '         "PIX" AS TIPO_CONTA   ' +
                       '  FROM FORPIX P  ' +
                       '  WHERE P.PIX_CODFOR = :CODFOR ';
  End;

   Result := Result  + ') AS TMP ORDER BY 2, AUTOINCREM DESC';
end;

function fVerificaSeTodosEventosSaoIguais(cdsTemp: TUniClientDataSet): Boolean;
 Var
   strCodEve : String;
begin
  Result := True;

  If Not cdsTemp.Active Then
    cdsTemp.Open;

  With cdsTemp Do
  Begin
    First;
    strCodEve := FieldByName('CTP_CODEVE').AsString;

    While Not Eof Do
    Begin
      If FieldByName('CTP_CODEVE').AsString <> strCodEve Then
      Begin
        Result := False;
        Exit;
      End
      Else
        Next;
    End;
  End;
end;

function EhAgrupamento(ANumeroDuplicata, AFornecedor, AEmpresa: String): Boolean;
var
  qryAgrupamento: TUniQuery;
begin
  qryAgrupamento := fCriaQuery;

  qryAgrupamento.Close;
  qryAgrupamento.SQL.Clear;
  qryAgrupamento.SQL.Add('SELECT CTP_NUMAGR ');
  qryAgrupamento.SQL.Add('FROM DUPAGP ');
  qryAgrupamento.SQL.Add('WHERE CTP_NUMAGR = :NUMAGR AND ');
  qryAgrupamento.SQL.Add('      CTP_EMPAGR = :EMPAGR AND ');
  qryAgrupamento.SQL.Add('      CTP_CODFOR = :CODFOR ');
  qryAgrupamento.ParamByName('NUMAGR').AsString := ANumeroDuplicata;
  qryAgrupamento.ParamByName('EMPAGR').AsString := AEmpresa;
  qryAgrupamento.ParamByName('CODFOR').AsString := AFornecedor;
  qryAgrupamento.Open;

  If Not qryAgrupamento.IsEmpty Then
    Result := True
  Else
    Result := False;

  FreeAndNil(qryAgrupamento);
end;

function fLoadReport : Boolean;
  Var
   mmsLoad: TStream;
   qryLayImp: TUniQuery;
Begin
  Result := False;

  qryLayImp := fCriaQuery(nil);

  Try
    With qryLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'CPCTP'+IntToStr(fCfgSis('LAY_CP', varInteger));

      If(strTipImp = 'M') Then
        ParamByName('TIPLAY').AsString := 'M'
      Else
        ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

        If fCfgSis('LAY_CP', varInteger) = 3 Then
        Begin
          frmQckCtpCompPgtoMod.frxMod3Vias.LoadFromStream(mmsLoad);
          frmQckCtpCompPgtoMod.frxMod3Vias.Variables.Clear;
        End
        Else
        Begin
          If strTipImp = 'M' Then
          Begin
            frmQckCtpCompPgtoMod.frxCtpCompPg_M.LoadFromStream(mmsLoad);
            frmQckCtpCompPgtoMod.frxCtpCompPg_M.Variables.Clear;
          End
          Else
          Begin
            frmQckCtpCompPgtoMod.frxCtpCompPg_J.LoadFromStream(mmsLoad);
            frmQckCtpCompPgtoMod.frxCtpCompPg_J.Variables.Clear;
          End;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  FreeAndNil(mmsLoad);
  FreeAndNil(qryLayImp);
End;

function GravarCTPCOM(ANumDup,AParcel,ASerie_,ACodFor,ACodEmp, AComPro : String): Boolean;
  Var
    LCtpCom : TUniQuery;
    LSql    : String;
    LAutoin : String;
Begin
  Try
    LCtpCom := fCriaQuery;
    LAutoin := fRetAutoIncrem('CTPCOM', VS_strCodEmp);

    LSql := '';
    LSql := LSql + 'INSERT INTO CTPCOM (    ';
    LSql := LSql + '  AUTOINCREM,           ';
    LSql := LSql + '  CTP_NUMDUP,           ';
    LSql := LSql + '  CTP_PARCEL,           ';
    LSql := LSql + '  CTP_SERIE_,           ';
    LSql := LSql + '  CTP_CODFOR,           ';
    LSql := LSql + '  CTP_CODEMP,           ';
    LSql := LSql + '  CTP_COMPRO )          ';
    LSql := LSql + 'VALUES(                 ';
    LSql := LSql + '  :AUTOIN,              ';
    LSql := LSql + '  :NUMDUP,              ';
    LSql := LSql + '  :PARCEL,              ';
    LSql := LSql + '  :SERIE_,              ';
    LSql := LSql + '  :CODFOR,              ';
    LSql := LSql + '  :CODEMP,              ';
    LSql := LSql + '  :COMPRO )             ';

    Try
      LCtpCom.Close;
      LCtpCom.Sql.Clear;
      LCtpCom.Sql.Add(LSql);
      LCtpCom.ParamByName('AUTOIN').AsString := LAutoin;
      LCtpCom.ParamByName('NUMDUP').AsString := ANumDup;
      LCtpCom.ParamByName('PARCEL').AsString := AParcel;
      LCtpCom.ParamByName('SERIE_').AsString := ASerie_;
      LCtpCom.ParamByName('CODFOR').AsString := ACodFor;
      LCtpCom.ParamByName('CODEMP').AsString := ACodEmp;
      LCtpCom.ParamByName('COMPRO').AsString := AComPro;
      LCtpCom.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[untCadPag.GravarCTPCOM]');
      End;
    End;
  Finally
    FreeAndNil(LCtpCom);
  End;
End;

function fRetornaUltimaAlteracaoDuplicataCTP(strNumDup, strParcel, strSerie_, strCodFor,
                                               strCodEmp: String; intSeqBai: Integer = 0): TDateTime;
  Var
    qryLogCtp: TUniQuery;
    strSQL   : String;
Begin
  Result := 0;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + '      CTP_DTALOG,               ';
    strSQL := strSQL + '      CTP_HORLOG                ';
    strSQL := strSQL + 'FROM LOGCTP                     ';
    strSQL := strSQL + 'WHERE CTP_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '      CTP_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '      CTP_SERIE_ = :SERIE_ AND  ';
    strSQL := strSQL + '      CTP_CODFOR = :CODFOR AND  ';
    strSQL := strSQL + '      CTP_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '      CTP_SEQBAI = :SEQBAI      ';
    strSQL := strSQL + 'ORDER BY CTP_DTALOG DESC,       ';
    strSQL := strSQL + '         CTP_HORLOG DESC        ';

    qryLogCtp := fCriaQuery;
    With qryLogCtp Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('SERIE_').AsString  := strSerie_;
      ParamByName('CODFOR').AsString  := strCodFor;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If Not IsEmpty Then
        Result := StrtoDateTime(FieldByName('CTP_DTALOG').AsString + ' ' +
                                FieldByName('CTP_HORLOG').AsString);
    End;

    FreeAndNil(qryLogCtp);
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar a última alteração da duplicata de contas a pagar.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

function fGravarContasAPagar(objParametros: TParametrosContasAPagar): Boolean;
var
  strNumDoc: String;
  strCodEmp: String;
begin
  strCodEmp := fGetEmpresaLogada;
  strNumDoc := IfThen(fEmptyStr(objParametros.FstrNumDoc),
                      fRetSequencialCadPag,
                      objParametros.FstrNumDoc);

  Result := fGravaCadPag(objParametros.FstrNomeFormLogCtp,                                   // Nome Form LOGCTP
                         objParametros.FstrDescricaoLotCtp,                                  // Descrição LOGCTP
                         objParametros.FstrCodFor,                                           // Fornecedor
                         strNumDoc,                                                          // Número da duplicata
                         objParametros.FstrParcela,                                          // Parcela
                         strCodEmp,                                                          // Empresa
                         objParametros.FstrCodCta,                                           // Plano de Contas
                         '',                                                                 // Serie do Documento
                         0,                                                                  // Sequencial de Baixa
                         fNow,                                                               // Data do lançamento
                         StrToDate(objParametros.FstrDtaVenc),                               // Data de Vencimento
                         objParametros.FfltValorDupli,                                       // Valor da Duplicata
                         objParametros.FfltValorDupli,                                       // Valor Original
                         objParametros.FstrPrevisao,                                         // Previsão?
                         objParametros.FstrVeioBoleto,                                       // Veio Boleto
                         objParametros.FstrDeposito,                                         // Deposito
                         objParametros.FstrHistorico,                                        // Histórico 1
                         '',                                                                 // Histórico 2
                         '',                                                                 // Histórico da Baixa
                         '',                                                                 // Portador da Baixa
                         '',                                                                 // Centro de Custo da Baixa
                         '',                                                                 // Documento da Baixa
                         '',                                                                 // Operador da Baixa
                         0,                                                                  // Data do Pagamento
                         0,                                                                  // Valor Pago
                         0,                                                                  // Valor de Juros
                         0,                                                                  // Valor Desconto
                         '',                                                                 // Empresa
                         '',                                                                 // Codigo do Evento
                         objParametros.FstrUsaCheque,                                        // Usa Cheque
                         objParametros.FstrCodPor,                                           // Codigo do Portador
                         strNumDoc,                                                          // Número do documento
                         0,
                         0,
                         0,
                         False,
                         0,
                         '',
                         0,
                         objParametros.FstrVeioNF,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         objParametros.FstrUsoEConsumo,
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
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
                         '',
                         objParametros.FstrPagAntecipado,
                         '',
                         '',
                         '',
                         '',
                         0,
                         '',
                         0,
                         '');
end;

function RetornaSQLCamposTabelaTemporaria: String;
Begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  P.CTP_SERIE_ AS AGRSER, ';
  Result := Result + '  P.CTP_CODEMP AS AGREMP, ';
  Result := Result + '  P.CTP_CODFOR AS AGRFOR, ';
  Result := Result + '  P.CTP_NUMDUP AS NRODUP, ';
  Result := Result + '  P.CTP_PARCEL AS PARDUP, ';
  Result := Result + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ';
  Result := Result + '  P.CTP_CODFOR, ';
  Result := Result + '  F.FOR_NOMFOR, ';
  Result := Result + '  F.FOR_FONE01, ';
  Result := Result + '  F.FOR_F_A_X_, ';
  Result := Result + '  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
  Result := Result + '  F.FOR_C_G_C_, ';
  Result := Result + '  F.FOR_CGCCPF AS FOR_CGCCPF, ';
  Result := Result + '  P.CTP_CODEMP, ';
  Result := Result + '  P.CTP_SERIE_, ';
  Result := Result + '  E.EMP_NOMEMP, ';
  Result := Result + '  P.CTP_CODCTA, ';
  Result := Result + '  C.CTA_DESCTA, ';
  Result := Result + '  P.CTP_HIST01, ';
  Result := Result + '  P.CTP_HIST02, ';
  Result := Result + '  P.CTP_PREVIS, ';
  Result := Result + '  IF(P.CTP_PREVIS = "S", "SIM", "NÃO") AS PREVISAO, ';
  Result := Result + '  IF(P.CTP_VEIOBO = "S", "SIM", "NÃO") AS CTP_VEIOBO, ';
  Result := Result + '  IF(P.CTP_VEIONF = "S", "SIM", "NÃO") AS CTP_VEIONF, ';
  Result := Result + '  P.CTP_DTACAD, ';
  Result := Result + '  P.CTP_DTAVEN, ';
  Result := Result + '  P.CTP_VALORI, ';
  Result := Result + '  P.CTP_VALDUP, ';
  Result := Result + '  P.CTP_VALPAG, ';
  Result := Result + '  P.CTP_DTAPAG, ';
  Result := Result + '  P.CTP_VALJUR, ';
  Result := Result + '  P.CTP_VALMUL, ';
  Result := Result + '  P.CTP_VALDES, ';
  Result := Result + '  P.CTP_CODEVE, ';
  Result := Result + '  P.CTP_TIPDOC, ';
  Result := Result + '  P.CTP_CODVEL, ';
  Result := Result + '  P.CTP_CODPOR, ';
  Result := Result + '  P.CTP_EMPBAI, ';
  Result := Result + '  P.CTP_RCXCON, ';
  Result := Result + '  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ';
  Result := Result + '  P.CTP_PORBAI, ';
  Result := Result + '  B.POR_NOMPOR, ';
  Result := Result + '  IF(P.CTP_DTALIB IS NULL, "NÃO", "SIM") AS LIBERADO, ';
  Result := Result + '  IF(P.CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ';
  Result := Result + '  V.EVE_DESEVE, ';
  Result := Result + '  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESSUJ, ';
  Result := Result + '  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
  Result := Result + '  IFNULL(P.CTP_MULSUJ, 0) AS CTP_MULSUJ, ';
  Result := Result + '  IFNULL(P.CTP_VENDOR, 0) AS CTP_VENDOR, ';
  Result := Result + '  IFNULL(P.CTP_OUTENT, 0) AS CTP_OUTENT, ';
  Result := Result + '  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURORI, '; //MF: 290852 - 30/06/23
  Result := Result + '  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESORI, '; //MF: 290852 - 03/07/23
  Result := Result + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ';
  Result := Result + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTORI, '; //MF: 290852 - 30/06/23
  Result := Result + '  " " AS CTP_MARDES, ';
  Result := Result + '  " " AS CTP_TIPBAI, ';
  Result := Result + '  " " AS CTP_TIPDES, ';
  Result := Result + '  P.AUTOINCREM, ';
  Result := Result + '  "CADPAG" AS TABELA, ';
  Result := Result + '  CTP_COMPET,         ';
  Result := Result + '  P.CTP_DINHEI, ';
  Result := Result + '  P.CTP_CHQAVI, ';
  Result := Result + '  P.CTP_ORDPAG, ';
  Result := Result + '  P.CTP_REPCHQ, ';
  Result := Result + '  P.CTP_SEQBAI, ';
  Result := Result + '  P.CTP_CHQAVI, ';
  Result := Result + '  P.CTP_DINHEI, ';
  Result := Result + '  P.CTP_DTALIB, ';
  Result := Result + '  IFNULL( ';
  Result := Result + '   (SELECT ';
  Result := Result + '     IFNULL(D.CTP_VALANT, 0) ';
  Result := Result + '   FROM ';
  Result := Result + '     CADPAG D ';
  Result := Result + '   WHERE D.CTP_NUMDUP = P.CTP_NUMDUP ';
  Result := Result + '     AND P.CTP_PARCEL = D.CTP_PARCEL ';
  Result := Result + '     AND D.CTP_CODEMP = P.CTP_CODEMP ';
  Result := Result + '     AND D.CTP_SERIE_ = P.CTP_SERIE_ ';
  Result := Result + '     AND P.CTP_CODFOR = D.CTP_CODFOR ';
  Result := Result + '     AND D.CTP_SEQBAI = 1 ';
  Result := Result + '   LIMIT 1), ';
  Result := Result + '   P.CTP_VALDUP ';
  Result := Result + ' ) AS CTP_GRVORI, ';
  Result := Result + QuotedStr(FormatDateTime('DD/MM/YYYY HH:NN:SS',VS_Date + fRetHoraServidor))+' AS HRAFIL, ';
  Result := Result + '  P.CTP_PAGANT, ';
  Result := Result + '  IF(P.CTP_PAGANT = "S", "SIM", "NÃO") AS ANTECIPACAO ';
  Result := Result + 'FROM ';
  Result := Result + '  CADPAG P ';
  Result := Result + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
  Result := Result + '  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ';
  Result := Result + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';

  Result := Result + ' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ';
  Result := Result + ' LEFT JOIN CADPOR B ON P.CTP_PORBAI = B.POR_CODPOR ';
  Result := Result + ' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ';
End;

function ExcluirDuplicataGeradaDeKMRodados(AChaveDuplicata: String; ASeqBai : Integer;
  ALimpar: Boolean = False): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  If ASeqBai <> 0 Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MANKMT ' +
                          'WHERE KMT_CTPDOC="' + AChaveDuplicata + '"';

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If Not ALimpar Then
        Result := fMensagem('ATENÇÃO', 'Essa duplicata foi gerada através de um registro de Km Rodados.' + #13 +
                                       'Deseja realmente excluir a duplicata selecionada?', ['&Sim', '&Não']) = 1
      Else
      Begin
        LConsulta.Edit;
        LConsulta.FieldByName('KMT_CTPDOC').Value := Null;
        LConsulta.Post;
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure AtualizarChaveKMRodados(AChaveAntiga, AChaveNova: String);
var
  LConsulta: TUniQuery;
begin
  if AChaveAntiga.Equals(AChaveNova) then
    Exit;

  LConsulta := fCriaQuery;
  try
    try
      LConsulta.SQL.Text := 'SELECT * ' +
                            'FROM MANKMT ' +
                            'WHERE KMT_CTPDOC="' + AChaveAntiga + '"';
      LConsulta.Open;
      if not LConsulta.IsEmpty then
      begin
        LConsulta.Edit;
        LConsulta.FieldByName('KMT_CTPDOC').Value := AChaveNova;
        LConsulta.Post;
      end;
    except
      On E: Exception do
        raise Exception.Create('Problemas ao atualizar a chave do registro de Manutençao de KM. ' + E.Message);
    end;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function DuplicataGeradaDeKMRodados(AChaveDuplicata: String): Boolean;
var
  LConsulta: TUniQuery;
begin
  Result := False;
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MANKMT ' +
                          'WHERE KMT_CTPDOC="' + AChaveDuplicata + '"';
    LConsulta.Open;
    if not LConsulta.IsEmpty then
    begin
      Result := True;
    end;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function fGetValOriDuplicata(strNumDup,
                             strSerie,
                             strCodEmp,
                             strParcel,
                             strCodFor: String): Double;
  Var
    qryGen: TUniQuery;
    qryGen2: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTP_VALORI, CTP_VALANT ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADPAG ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTP_SERIE_ = :SERIE_ AND ';
  strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR ';

  Try
    qryGen  := fCriaQuery;
    qryGen2 := fCriaQuery;

    Result  := 0;

    With qryGen Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If Not qryGen.IsEmpty Then
      Begin

        If qryGen.recordcount = 1 Then
           Result := FieldByName('CTP_VALORI').AsFloat
        Else
        Begin

           qryGen2.SQL.Clear;
           strSQL := strSQL + ' AND CTP_SEQBAI = 1 ';
           qryGen2.SQL.Add(strSQL);
           qryGen2.ParamByName('NUMDUP').AsString := strNumDup;
           qryGen2.ParamByName('SERIE_').AsString := strSerie;
           qryGen2.ParamByName('CODEMP').AsString := strCodEmp;
           qryGen2.ParamByName('PARCEL').AsString := strParcel;
           qryGen2.ParamByName('CODFOR').AsString := strCodFor;

           qryGen2.Open;

           If Not qryGen2.IsEmpty Then
              Result := qryGen2.FieldByName('CTP_VALANT').AsFloat
           Else
              Result := 0;

        End;

      End;

    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryGen2);
  End;
End;

//MF: 286456  - 02/06/2023
function fCPJaImpresso(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String): Boolean;
var
  qryLogCtp: TUniQuery;
  strSQL: String;
begin
  strSQL :=          ' SELECT COUNT(1) AS QTD ';
  strSQL := strSQL + ' FROM LOGCTP ';
  strSQL := strSQL + ' WHERE CTP_NUMDUP = :NUMDUP ';
  strSQL := strSQL + ' AND   CTP_PARCEL = :PARCEL ';
  strSQL := strSQL + ' AND   CTP_SERIE_ = :SERIE_ ';
  strSQL := strSQL + ' AND   CTP_CODEMP = :CODEMP ';
  strSQL := strSQL + ' AND   CTP_CODFOR = :CODFOR ';
  strSQL := strSQL + ' AND   CTP_DESCRI = ''IMPRESSÃO CP'' ';

  Try
    qryLogCtp := fCriaQuery;

    qryLogCtp.SQL.Add(strSQL);
    qryLogCTP.ParamByName('NUMDUP').AsString := strNumDup;
    qryLogCTP.ParamByName('PARCEL').AsString := strParcel;
    qryLogCTP.ParamByName('SERIE_').AsString := strSerie;
    qryLogCTP.ParamByName('CODEMP').AsString := strCodEmp;
    qryLogCTP.ParamByName('CODFOR').AsString := strCodFor;
    qryLogCTP.Open;

    Result := qryLogCTP.Fields[0].AsInteger > 0;
  Finally
    FreeAndNil(qryLogCtp);
  End;
end;

{ TParametrosDesmembraValores }

procedure TParametrosDesmembraValores.SetStrCodCta(pStrValue: string);
begin
  FstrCodCta := pStrValue;
end;

function IncluidoPeloLivroFiscal(ANumeroDuplicata, AParcela, ASerie, ACodigoEmpresa, ACodigoFornecedor: String): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := False;

  If ANumeroDuplicata.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM LOGCTP ' +
                          'WHERE CTP_NUMDUP=:NUMDUP ' +
                          '  AND CTP_PARCEL=:PARCEL ' +
                          '  AND CTP_SERIE_=:SERIE_ ' +
                          '  AND CTP_CODEMP=:CODEMP ' +
                          '  AND CTP_CODFOR=:CODFOR ' +
                          '  AND CTP_SEQBAI=0 ' +
                          '  AND CTP_DESCRI IN ("INCLUSÃO LIVRO FISCAL", "INCLUSÃO LIVRO FISCAL LD") ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('PARCEL').AsString := AParcela;
    LConsulta.ParamByName('SERIE_').AsString := ASerie;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODFOR').AsString := ACodigoFornecedor;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

procedure ApagaDuplicataRETDDA(AAutoIncremCadPag: String);
  Var
    LConsulta: TUniQuery;
begin
  If AAutoIncremCadPag.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text :='SELECT * FROM RETDDA WHERE DDA_AUTCTP="' + AAutoIncremCadPag + '"';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Delete;

      LConsulta.First;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function fValidaEventosCFGContabil( ADatasetCTPDet: TDataset; Var stlCodEve: TStringList ): Boolean;
  Var
    lstEventosInvalidos: TStringList;
Begin

  ADatasetCTPDet.First;

  lstEventosInvalidos := TStringList.Create;

  Result := False;

  While Not ADatasetCTPDet.Eof Do
  Begin

    If Not fEmptyStr(ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString) Then
    Begin
       If fVerificaEventoCfgContabil(ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString) Then
       Begin
          if lstEventosInvalidos.IndexOf(ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString) = -1 then
          Begin
             lstEventosInvalidos.Add(ADatasetCTPDet.FieldByName('CTP_CODEVE').AsString);
             Result := True;
          End;
       End;
    End;

    ADatasetCTPDet.Next;
  End;

  stlCodEve := lstEventosInvalidos;

End;

procedure pInformaEventosInvalidosListaContabilidade( stlCodEve: TStringList );
 Var
     strCodigosMsg : String;
     intIndice : integer;
Begin

  For intIndice := 0 To stlCodEve.Count - 1 Do
  Begin
    strCodigosMsg := strCodigosMsg + stlCodEve[intIndice] +',';
  End;

  fMensagem('ATENÇÃO', 'Foram encontrados centro de custos que não podem ser utilizados no rateio, ' +#13+
                       'pois estão configurados na lista de eventos que não serão exportados para a contabilidade!' +#13+
                       'Eventos encontrados : ' + LeftStr(strCodigosMsg, strCodigosMsg.Length - 1) ,['&OK']);
End;

{**********************************}
{* GRAVA A TABELA RNFCTP - REINF  *}
{**********************************}
function fGravaDadosREINF(strAutoInc, strNumDup, strCodFor, strParcel, strCodEmp, strSerie, strCodNatReinf, strCodServReinf : String; strSeqBai : Integer) : Boolean;
begin

  Try

    If fEmptyStr(strAutoInc) Then // INCLUSÃO
    Begin
      Result := InsereDadosREINF(strAutoInc,
                                 strNumDup,
                                 strCodFor,
                                 strParcel,
                                 strCodEmp,
                                 strSerie,
                                 strCodNatReinf,
                                 strCodServReinf,
                                 strSeqBai);
    End
    Else
    Begin // ALTERAÇÃO E EXCLUSAO

      If (Not fEmptyStr(strCodNatReinf)) And (Not fEmptyStr(strCodServReinf)) Then
      Begin
            Result := AlteraDadosREINF(strAutoInc,
                                 strNumDup,
                                 strCodFor,
                                 strParcel,
                                 strCodEmp,
                                 strSerie,
                                 strCodNatReinf,
                                 strCodServReinf);
      End
      Else
         Result := DeletaDadosREINF(strAutoInc);

    End;

  Except
    on E: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaDadosReinfCTP]');
    End;
  End;

end;

Function InsereDadosREINF(AAutoInc, ANumeroDuplicata, AFornecedor, AParcela, ACodigoEmpresa, ASerie, ACodNatReinf, ACodServReinf : string; ASeqBai : Integer) : Boolean;
Var
  qryGenRnf: TUniQuery;
Begin

  Try
    qryGenRnf := fCriaQuery;

    qryGenRnf.SQL.Clear;
    qryGenRnf.SQL.Add('INSERT INTO RNFCTP ( AUTOINCREM, ');
    qryGenRnf.SQL.Add('                     CTP_NUMDUP, ');
    qryGenRnf.SQL.Add('                     CTP_CODFOR, ');
    qryGenRnf.SQL.Add('                     CTP_PARCEL, ');
    qryGenRnf.SQL.Add('                     CTP_CODEMP, ');
    qryGenRnf.SQL.Add('                     CTP_SERIE_, ');
    qryGenRnf.SQL.Add('                     CTP_SEQBAI, ');
    qryGenRnf.SQL.Add('                     NAT_CODIGO, ');
    qryGenRnf.SQL.Add('                     CLA_CODIGO  ');
    qryGenRnf.SQL.Add(' ) VALUES         (              ');
    qryGenRnf.SQL.Add('                     :AUTINC,    ');
    qryGenRnf.SQL.Add('                     :NUMDUP,    ');
    qryGenRnf.SQL.Add('                     :CODFOR,    ');
    qryGenRnf.SQL.Add('                     :PARCEL,    ');
    qryGenRnf.SQL.Add('                     :CODEMP,    ');
    qryGenRnf.SQL.Add('                     :SERIE_,    ');
    qryGenRnf.SQL.Add('                     :SEQBAI,    ');
    qryGenRnf.SQL.Add('                     :CODNAT,    ');
    qryGenRnf.SQL.Add('                     :CODSER     ');
    qryGenRnf.SQL.Add(' )                               ');

    AAutoInc := fRetAutoIncrem('RNFCTP', ACodigoEmpresa);

    qryGenRnf.ParamByName('AUTINC').AsString := AAutoInc;
    qryGenRnf.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    qryGenRnf.ParamByName('CODFOR').AsString := AFornecedor;
    qryGenRnf.ParamByName('PARCEL').AsString := AParcela;
    qryGenRnf.ParamByName('CODEMP').AsString := ACodigoEmpresa;

    If not fEmptyStr(ASerie) Then
      qryGenRnf.ParamByName('SERIE_').AsString := ASerie
    else
      qryGenRnf.ParamByName('SERIE_').AsString := '';

    qryGenRnf.ParamByName('SEQBAI').AsInteger := ASeqBai;
    qryGenRnf.ParamByName('CODNAT').AsString  := ACodNatReinf;
    qryGenRnf.ParamByName('CODSER').AsString  := ACodServReinf;

    qryGenRnf.ExecSQL;

    Result := True;
  Except
    on E: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[InsereDadosREINF]');
    End;
  End;

End;

Function AlteraDadosREINF(AAutoInc, ANumeroDuplicata, AFornecedor, AParcela, ACodigoEmpresa, ASerie, ACodNatReinf, ACodServReinf : string) : Boolean;
Var
  qryUpdRnf: TUniQuery;
Begin

  Try
    qryUpdRnf := fCriaQuery;

    qryUpdRnf.SQL.Clear;
    qryUpdRnf.SQL.Add(' UPDATE RNFCTP ');    //( AUTOINCREM, ');
    qryUpdRnf.SQL.Add('  SET ');
    qryUpdRnf.SQL.Add(' CTP_NUMDUP = :NUMDUP, ');
    qryUpdRnf.SQL.Add(' CTP_CODFOR = :CODFOR, ');
    qryUpdRnf.SQL.Add(' CTP_PARCEL = :PARCEL, ');
    qryUpdRnf.SQL.Add(' CTP_CODEMP = :CODEMP, ');
    qryUpdRnf.SQL.Add(' CTP_SERIE_ = :SERIE_, ');
    qryUpdRnf.SQL.Add(' NAT_CODIGO = :CODNAT, ');
    qryUpdRnf.SQL.Add(' CLA_CODIGO = :CODSER  ');
    qryUpdRnf.SQL.Add('  WHERE ');
    qryUpdRnf.SQL.Add(' AUTOINCREM = :AUTINC  ');

    qryUpdRnf.ParamByName('AUTINC').AsString := AAutoInc;
    qryUpdRnf.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    qryUpdRnf.ParamByName('CODFOR').AsString := AFornecedor;
    qryUpdRnf.ParamByName('PARCEL').AsString := AParcela;
    qryUpdRnf.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    qryUpdRnf.ParamByName('SERIE_').AsString := ASerie;

    If fEmptyStr(ACodNatReinf) Then
       qryUpdRnf.ParamByName('CODNAT').Value := Null
    Else
       qryUpdRnf.ParamByName('CODNAT').AsString := ACodNatReinf;

    If fEmptyStr(ACodServReinf) Then
       qryUpdRnf.ParamByName('CODSER').Value := Null
    Else
       qryUpdRnf.ParamByName('CODSER').AsString := ACodServReinf;

    qryUpdRnf.ExecSQL;

    Result := True;
  Except
    on E: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[AlteraDadosREINF]');
    End;
  End;

End;

Function DeletaDadosREINF(AAutoInc : String) : Boolean;
Var
  qryDelRnf: TUniQuery;
Begin

  Try
    qryDelRnf := fCriaQuery;

    qryDelRnf.SQL.Clear;
    qryDelRnf.SQL.Add(' DELETE FROM RNFCTP ');
    qryDelRnf.SQL.Add('  WHERE ');
    qryDelRnf.SQL.Add('   AUTOINCREM = :AUTINC  ');

    qryDelRnf.ParamByName('AUTINC').AsString := AAutoInc;

    qryDelRnf.ExecSQL;

    Result := True;
  Except
    on E: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[DeletaDadosREINF]');
    End;
  End;

End;

procedure pRetornaDadosREINF(strNumDoc, strCodEmp, strCodFor, ASerie, AParcel : String; ASeqBai: Integer; var ACodNat, ACodServ, AAutoInc : String);
  Var
    LRet: TUniQuery;
begin

    ACodNat  := '';
    ACodServ := '';
    AAutoInc := '';

    Try
      LRet := fCriaQuery;

      LRet.SQL.Text := ' SELECT       '+
                       '  AUTOINCREM, '+
                       '  NAT_CODIGO, '+
                       '  CLA_CODIGO  '+
                       '  FROM        '+
                       '       RNFCTP '+
                       ' WHERE '+
                       '       CTP_CODFOR = :CODFOR '+
                       '   AND CTP_NUMDUP = :NUMDUP '+
                       '   AND CTP_PARCEL = :PARCEL '+
                       '   AND CTP_CODEMP = :CODEMP '+
                       '   AND CTP_SEQBAI = :SEQBAI '+
                       '   AND CTP_SERIE_ = :SERIE_ ';

      LRet.ParamByName('NUMDUP').AsString  := strNumDoc;
      LRet.ParamByName('CODFOR').AsString  := strCodFor;
      LRet.ParamByName('PARCEL').AsString  := AParcel;
      LRet.ParamByName('SEQBAI').AsInteger := ASeqBai;
      LRet.ParamByName('SERIE_').AsString  := ASerie;
      LRet.ParamByName('CODEMP').AsString  := strCodEmp;

      LRet.Open;

      If Not LRet.IsEmpty Then
      Begin
         ACodNat  := LRet.FieldByName('NAT_CODIGO').AsString;
         ACodServ := LRet.FieldByName('CLA_CODIGO').AsString;
         AAutoInc := LRet.FieldByName('AUTOINCREM').AsString;
      End;

    Finally
      FreeAndNil(LRet);
    End;

End;

function fDescontoMaiorQueDuplicata(AValorDesconto,
                                    AValorOriginal,
                                    AValorTotal: Double): Boolean;
begin
  Result := False;

  If fFormataFloat(AValorDesconto, 2) = 0 Then
    Exit;

  If fFormataFloat(AValorTotal, 2) > 0 Then
    Exit;

  If fFormataFloat(AValorOriginal, 2) < 0 Then
    Exit;

  If fFormataFloat(AValorOriginal, 2) > fFormataFloat(AValorDesconto, 2) Then
    Exit;

  Result := True;
end;

{*****************************************}
{* VERIFICA SE A DUPLICATA CONTEM        *}
{* DADOS DO REINF GRAVADOS NA TABELA     *}
{* RNFCTP - RETORNA -> TRUE SE EXISTE.   *}
{*****************************************}
function fVerificaReinfCtp(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; strSeqBai : Integer; var sAutoInc: String): Boolean;
Var
  strSQL: String;
  qryGenDet: TUniQuery;
begin
  Try
    qryGenDet := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  RNFCTP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + ' CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + ' CTP_PARCEL = :PARCEL AND ';
    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      If (Not fEmptyStr(strSerie)) Then
        ParamByName('SERIE_').AsString  := strSerie;

      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      Open;

      Result := Not IsEmpty;

      If Result Then
         sAutoInc := qryGenDet.FieldByName('AUTOINCREM').AsString;

    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

initialization
  blnPedirFilaImp := True;

end.
