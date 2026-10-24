{****************************************}
{* ************* ATENÇÃO ************** *}
{****************************************}
{* ESSE RELATÓRIO SUPORTA ATE 60 LOJAS  *}
{* CASO PASSE DEVERA ALTERAR ESTRUTURA  *}
{* DO DATASET RELATORIO                 *}
{*************************************AF*}
unit untRelEstatAnalResult2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport, cxProgressBar,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, CheckLst, UniClientDataSet,
  Uni, UniDataSetProvider, DB, StrUtils, Printers, BitBtnLockedIncrem, DateUtils,
  ComboBoxFocus, frxExportCSVTestabilidade, Datasnap.DBClient;

const
  MAX_COLUNA_EXCEL = 60;
  MAX_COLUNA_PAISA = 20;
  MAX_COLUNA_RETRA = 08;
  MAX_COLUNA_MATRI = 12;

  MAX_COLUNA_EXCEL_CONSOL = MAX_COLUNA_EXCEL;
  MAX_COLUNA_PAISA_CONSOL = MAX_COLUNA_EXCEL;
  MAX_COLUNA_RETRA_CONSOL = MAX_COLUNA_EXCEL;

  SEM_EVENTO = '<SEM EVENTO>';

type
  TSelecao = (opMTodos, opDTodos);

  TfrmRelEstatAnalResult2 = class(TfrmPaiRelatorio)
    lstEmpresas: TCheckListBox;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDataFin: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDataIni: TLabel;
    rdgOrientacao: TRadioGroup;
    cdsRelat: TUniClientDataSet;
    cdsRelatREL_CODREL: TIntegerField;
    cdsRelatREL_DESGRU: TStringField;
    cdsRelatREL_CODCAM: TStringField;
    cdsRelatREL_DESCAM: TStringField;
    frxSalPor: TfrxDBDataset;
    cdsRelatREL_MARGEM: TFloatField;
    rdgExibir: TRadioGroup;
    rdgTipDta: TRadioGroup;
    rdgEmpresa: TRadioGroup;
    cdsRelatREL_TOTAL: TFloatField;
    cdsRelatREL_CALTOT: TBooleanField;
    rdgFatura: TRadioGroup;
    rdgSalEst: TRadioGroup;
    chkSalPor: TCheckBox;
    cdsRelatREL_SALPOR: TBooleanField;
    chkResFor: TCheckBox;
    frxResFor: TfrxDBDataset;
    rdgTipOri: TRadioGroup;
    Label1: TLabel;
    cbbComCus: TComboBoxFocus;
    chkExibeAcreFin: TCheckBox;
    frxQckEstatAnalResult2M: TfrxReport;
    frxQckEstatAnalResult2J: TfrxReport;
    rdgSalPor: TRadioGroup;
    chkPerDes: TCheckBox;
    Label2: TLabel;
    popSel: TPopupMenu;
    mnuSelTudo: TMenuItem;
    DesmarcarTudo1: TMenuItem;
    lblPreCus: TLabel;
    chkListaDesmembramento: TCheckBox;
    chkTrMarCus: TCheckBox;
    lblCompetIni: TLabel;
    mskCompetIni: TMaskEditFocus;
    lblCompetFin: TLabel;
    mskCompetFin: TMaskEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure lstEmpresasClickCheck(Sender: TObject);
    procedure lstEmpresasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lstEmpresasEnter(Sender: TObject);
    procedure rdgOrientacaoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtDestinoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function frxQckEstatAnalResult2MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxQckEstatAnalResult2JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure btnImprimirErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);
    procedure Label2Click(Sender: TObject);
    procedure mnuSelTudoClick(Sender: TObject);
    procedure DesmarcarTudo1Click(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure rdgTipDtaClick(Sender: TObject);
  private
    { Private declarations }

    FLog: TStringList;

    intMaxColuna: Integer;
    slsEmpresas : TStringList;
    arrSomatorias: Array Of TAggregateField;

    qryGenericaJurosEDescontos: TUniQuery;
    qryGenerica: TUniQuery;
    cdsFaturamento: TUniClientDataSet;
    cpvFaturamento: TUniDataSetProvider;

    qryJurDes: TUniQuery;
    cdsJurDes: TUniClientDataSet;
    cpvJurDes: TUniDataSetProvider;

    qryJDDedChq: TUniQuery;
    cdsJDDedChq: TUniClientDataSet;
    cpvJDDedChq: TUniDataSetProvider;

    qryJDResChq: TUniQuery;
    cdsJDResChq: TUniClientDataSet;
    cpvJDResChq: TUniDataSetProvider;

    qryJDAgru: TUniQuery;
    cdsJDAgru: TUniClientDataSet;
    cpvJDAgru: TUniDataSetProvider;

    qryJDAgruChqDeducao: TUniQuery;
    cdsJDAgruChqDeducao: TUniClientDataSet;
    cpvJDAgruChqDeducao: TUniDataSetProvider;

    qryJDAgruChqReintegracao: TUniQuery;
    cdsJDAgruChqReintegracao: TUniClientDataSet;
    cpvJDAgruChqReintegracao: TUniDataSetProvider;

    cdsCtaRes: TUniClientDataSet;
    cpvCtaRes: TUniDataSetProvider;

    cdsCtaPag: TUniClientDataSet;
    cpvCtaPag: TUniDataSetProvider;

    cdsCtaRec: TUniClientDataSet;
    cpvCtaRec: TUniDataSetProvider;

    cdsMovCar: TUniClientDataSet;
    cpvMovCar: TUniDataSetProvider;

    cdsCadChq: TUniClientDataSet;
    cpvCadChq: TUniDataSetProvider;

    cdsTransf: TUniClientDataSet;
    cpvTransf: TUniDataSetProvider;

    cdsTransfCus: TUniClientDataSet;
    cpvTransfCus: TUniDataSetProvider;

    cdsUsoCon: TUniClientDataSet;
    cpvUsoCon: TUniDataSetProvider;

    cdsBonifi: TUniClientDataSet;
    cpvBonifi: TUniDataSetProvider;

    cdsEstoqu: TUniClientDataSet;
    cpvEstoqu: TUniDataSetProvider;

    cdsImobil: TUniClientDataSet;
    cpvImobil: TUniDataSetProvider;

    cdsPraFat: TUniClientDataSet;
    cpvPraFat: TUniDataSetProvider;

    cdsPraCtr: TUniClientDataSet;
    cpvPraCtr: TUniDataSetProvider;

    cdsAcrFin: TUniClientDataSet;
    cpvAcrFin: TUniDataSetProvider;

    cdsSalPor: TUniClientDataSet;

    cdsCta124: TUniClientDataSet;
    cpvCta124: TUniDataSetProvider;

    cdsCtaAux: TUniClientDataSet;
    cpvCtaAux: TUniDataSetProvider;

    cdsVenFor: TUniClientDataSet;

    qryEmpTri: TUniQuery;

    VS_DateFim: TDateTime;

    auxStrMarMkp: String;
    auxStrPcmPro: String;
    auxIntDecUni: Integer;

    fltTotPis,
    fltTotCof,
    fltTotIcm,
    fltTotIpi,
    fltTotRet,
    fltTotFre,
    fltTotJur,
    fltTotDes,
    fltTotDeducCtrChq,
    fltTotReintCtrChq,
    fltTotJAg,
    fltTotDAg,
    fltTotDeducChq,
    fltTotReintChq: Double;

    fltTotASn,
    fltTotAIr,
    fltTotACs: Double;

  	blnExecqryJurDes,
	  blnExecqryJDDedChq,
	  blnExecqryJDResChq,
	  blnExecqryJDAgru,
	  blnExecqryJDAgruChqDeducao,
	  blnExecqryJDAgruChqReintegracao: Boolean;
    blnRegimeDefinidoNoPlanoDeContas: Boolean;

    blnIncDupCliForFil: Boolean;

    procedure pCarregaCTP124;
    procedure pCarregaVendas;
    procedure pCarregaVendasFornec;
    procedure pCarregaCtaRes;
    procedure pCarregaCtaPag;
    procedure pCarregaCtaRec;
    procedure pCarregaMovCar;
    procedure pCarregaCadChq;
    procedure pCarregaTransf;
    procedure pCarregaUsoCon;
    procedure pCarregaBonifi(blnSaida : Boolean);
    procedure pCarregaEstoqu;
    procedure pCarregaImobil;
    procedure pCarregaAvalia;
    procedure pCarregaPraMed;
    procedure pCarregaAcrFin;
    procedure pCarregaSalPor;
    procedure pAtualizaLst;
    procedure pDesmarcaColunas;
    procedure pCarregaJurosDescontos;
    procedure pCarregaJurosDescontosAgrupamento;
    procedure pCarregaJurosDescontosAgrupamentoChqDeducao;
    procedure pCarregaJurosDescontosAgrupamentoChqReintegracao;
    procedure pCarregaJurosDescontosDeducaoCheques;
    procedure pCarregaJurosDescontosReintegracaoCheques;

    procedure pCarregaRegimeTributario;
    function fRetRegimeTributario(strCodEmp: String): TTipoRegime;
    function fConfiguracaoRegTriAtiva(caCampo: TTipoConfigAtiva; strCodEmp: String): Boolean;
    function fRetPercentualTributos(ptCampo: TTipoPercentualTributo; strCodEmp: String): Double;
    procedure pCarregaValoresImpostos(strCodEmp: String);

    function fVerificaSeImpSessao(caCampo: TTipoConfigAtiva): Boolean; overload;
    function fVerificaSeImpSessao(ptCampo: TTipoPercentualTributo): Boolean; overload;

    procedure pInsereCentroCustos(strCodEve, strCodCre: String; fltTotVen: Double);
    procedure pInsereEvento(strCodCre: String; fltTotVen: Double);
    procedure pGeraExcel;

    function fEmpSelecionadas(blnIN : Boolean = False): String;
    function fContaSelecoes: Integer;

    procedure pCriaClientVenFor;
    procedure pSelVarios(Opcao: TSelecao);

    function fExisteSalMLBase(strTabela:string):Boolean;
    function fExisteCnvMLBase(strTabela:string):Boolean;

    function fCalculaPrecoVendaInt(curPrecus, curPreven: Currency): Double;

    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
    function fGerarRelatorio(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fCarregandoDadosRelatorio(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fRetCompet(strCompetIni, strCompetFin: String): String;
    function fRetDtaIni(campoMask: TMaskEditFocus = Nil): String;
    function fRetDtaFin(campoMask: TMaskEditFocus = Nil): String;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEstatAnalResult2: TfrmRelEstatAnalResult2;

implementation

uses Math,  untRelEstatAnalResultGraficos, DBAccess, untGravando,
     untExcel, untConstantes, untMemo, untFuncoesSimples, untConsultas,
     untCadRcxx, untIFuncoes;

{$R *.dfm}

{ TfrmRelEstatAnalResult2 }

procedure TfrmRelEstatAnalResult2.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAnalResult2.FormCreate(Sender: TObject);
var
  qryIncDupCliForFil: TUniQuery;
begin
  inherited;

  FLog := TStringList.Create;

  slsEmpresas := TStringList.Create;

  qryGenericaJurosEDescontos := fCriaQuery(Self);
  qryGenerica    := fCriaQuery(Self);
  cdsFaturamento := TUniClientDataSet.Create(Self);
  cpvFaturamento := TUniDataSetProvider.Create(Self);
  cdsFaturamento.DisableControls;

  qryJurDes := fCriaQuery;
  cdsJurDes := TUniClientDataSet.Create(Self);
  cpvJurDes := TUniDataSetProvider.Create(Self);
  cdsJurDes.DisableControls;

  qryJDDedChq := fCriaQuery;
  cdsJDDedChq := TUniClientDataSet.Create(Self);
  cpvJDDedChq := TUniDataSetProvider.Create(Self);
  cdsJDDedChq.DisableControls;

  qryJDResChq := fCriaQuery;
  cdsJDResChq := TUniClientDataSet.Create(Self);
  cpvJDResChq := TUniDataSetProvider.Create(Self);
  cdsJDResChq.DisableControls;

  qryJDAgru := fCriaQuery;
  cdsJDAgru := TUniClientDataSet.Create(Self);
  cpvJDAgru := TUniDataSetProvider.Create(Self);
  cdsJDAgru.DisableControls;

  qryJDAgruChqDeducao := fCriaQuery;
  cdsJDAgruChqDeducao := TUniClientDataSet.Create(Self);
  cpvJDAgruChqDeducao := TUniDataSetProvider.Create(Self);
  cdsJDAgruChqDeducao.DisableControls;

  qryJDAgruChqReintegracao := fCriaQuery;
  cdsJDAgruChqReintegracao := TUniClientDataSet.Create(Self);
  cpvJDAgruChqReintegracao := TUniDataSetProvider.Create(Self);
  cdsJDAgruChqReintegracao.DisableControls;

  cdsCtaRes := TUniClientDataSet.Create(Self);
  cpvCtaRes := TUniDataSetProvider.Create(Self);
  cdsCtaRes.DisableControls;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cpvCtaPag := TUniDataSetProvider.Create(Self);
  cdsCtaPag.DisableControls;

  cdsCtaRec := TUniClientDataSet.Create(Self);
  cpvCtaRec := TUniDataSetProvider.Create(Self);
  cdsCtaRec.DisableControls;

  cdsMovCar := TUniClientDataSet.Create(Self);
  cpvMovCar := TUniDataSetProvider.Create(Self);
  cdsMovCar.DisableControls;

  cdsCadChq := TUniClientDataSet.Create(Self);
  cpvCadChq := TUniDataSetProvider.Create(Self);
  cdsCadChq.DisableControls;

  cdsTransf := TUniClientDataSet.Create(Self);
  cpvTransf := TUniDataSetProvider.Create(Self);
  cdsTransf.DisableControls;

  cdsTransfCus := TUniClientDataSet.Create(Self);
  cpvTransfCus := TUniDataSetProvider.Create(Self);
  cdsTransfCus.DisableControls;

  cdsUsoCon := TUniClientDataSet.Create(Self);
  cpvUsoCon := TUniDataSetProvider.Create(Self);
  cdsUsoCon.DisableControls;

  cdsBonifi := TUniClientDataSet.Create(Self);
  cpvBonifi := TUniDataSetProvider.Create(Self);
  cdsBonifi.DisableControls;

  cdsEstoqu := TUniClientDataSet.Create(Self);
  cpvEstoqu := TUniDataSetProvider.Create(Self);
  cdsEstoqu.DisableControls;

  cdsImobil := TUniClientDataSet.Create(Self);
  cpvImobil := TUniDataSetProvider.Create(Self);
  cdsImobil.DisableControls;

  cdsPraFat := TUniClientDataSet.Create(Self);
  cpvPraFat := TUniDataSetProvider.Create(Self);
  cdsPraFat.DisableControls;

  cdsPraCtr := TUniClientDataSet.Create(Self);
  cpvPraCtr := TUniDataSetProvider.Create(Self);
  cdsPraCtr.DisableControls;

  cdsAcrFin := TUniClientDataSet.Create(Self);
  cpvAcrFin := TUniDataSetProvider.Create(Self);
  cdsAcrFin.DisableControls;

  cdsSalPor := TUniClientDataSet.Create(Self);
  cdsSalPor.DisableControls;

  cdsCta124 := TUniClientDataSet.Create(Self);
  cpvCta124 := TUniDataSetProvider.Create(Self);
  cdsCta124.DisableControls;

  cdsCtaAux := TUniClientDataSet.Create(Self);
  cpvCtaAux := TUniDataSetProvider.Create(Self);
  cdsCtaAux.DisableControls;

  pCarregaComposicaoCusto(cbbComCus);  

  pCriaClientVenFor;

  pAtualizaLst;
  intMaxColuna := MAX_COLUNA_RETRA;

  frxQckEstatAnalResult2M.AddFunction('function fCalculaPrecoVendaInt(curPrecus, curPreven: Currency): Double');
  frxQckEstatAnalResult2J.AddFunction('function fCalculaPrecoVendaInt(curPrecus, curPreven: Currency): Double');

  auxStrMarMkp := fCfgSis('MARMKP');
  auxStrPcmPro := fCfgSis('PCMPRO');
  auxIntDecUni := fCfgSis('DECUNI', varInteger);

  blnExecqryJurDes := True;
	blnExecqryJDDedChq := True;
	blnExecqryJDResChq := True;
	blnExecqryJDAgru := True;
	blnExecqryJDAgruChqDeducao := True;
	blnExecqryJDAgruChqReintegracao := True;

  qryIncDupCliForFil := fCriaQuery(Self);
  try
    qryIncDupCliForFil.Close;
    qryIncDupCliForFil.SQL.Clear;
    qryIncDupCliForFil.SQL.Add(' SELECT CASE EMP_REGTRI                    ');
    qryIncDupCliForFil.SQL.Add('          WHEN "R" THEN TRI_LRCFFD         ');
    qryIncDupCliForFil.SQL.Add('          WHEN "P" THEN TRI_LPCFFD         ');
    qryIncDupCliForFil.SQL.Add('          WHEN "S" THEN TRI_SNCFFD         ');
    qryIncDupCliForFil.SQL.Add('        END AS DCFFDR                      ');
    qryIncDupCliForFil.SQL.Add(' FROM CADEMP                               ');
    qryIncDupCliForFil.SQL.Add(' JOIN EMPTRI ON EMP_CODEMP = TRI_CODEMP    ');
    qryIncDupCliForFil.SQL.Add(' WHERE EMP_CODEMP = "' + VS_strCodEmp + '";');
    qryIncDupCliForFil.Open;
    blnIncDupCliForFil := qryIncDupCliForFil.FieldByName('DCFFDR').AsString = 'S';
  finally
    FreeAndNil(qryIncDupCliForFil);
  end;
end;

procedure TfrmRelEstatAnalResult2.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FLog);

  FreeAndNil(slsEmpresas);

  If Assigned(qryJurDes) Then
    FreeAndNil(qryJurDes)
end;

function TfrmRelEstatAnalResult2.fEmpSelecionadas(blnIN : Boolean = False): String;
Var
  intContador: Integer;
  slsEmpLocal: TStringList;
begin

  {Formato IN}
  If blnIN Then
  Begin

    slsEmpLocal := TStringList.Create;
    slsEmpLocal.Clear;

    Try

      Result := '"' + VS_strCodEmp + '"';
      For intContador := 0 To slsEmpresas.Count -1 Do
        Result := Result + ', "' + slsEmpresas[intContador] + '"';

    Finally
      FreeAndNil(slsEmpLocal);
    End;

  End
  {Formato LOCATE}
  Else
  Begin

    Result := VS_strCodEmp + '_';

    For intContador := 0 To slsEmpresas.Count -1 Do
      Result := Result + slsEmpresas[intContador] + '_';

  End;

end;

function TfrmRelEstatAnalResult2.fExisteSalMLBase(strTabela: string): Boolean;
begin
  Result := fCampoExiste(strTabela, 'ITE_SAL_ML');
end;

function TfrmRelEstatAnalResult2.fExisteCnvMlBase(strTabela: string): Boolean;
begin
  Result := fCampoExiste(strTabela, 'ITE_CNV_ML');
end;

function TfrmRelEstatAnalResult2.fConfiguracaoRegTriAtiva(caCampo: TTipoConfigAtiva;
  strCodEmp: String): Boolean;
  Var
    blnPis,
    blnCof,
    blnIcm,
    blnIpi,
    blnRet,
    blnFre,
    blnJur,
    blnDes,
    blnJurChq,
    blnDesChq,
    blnJAg,
    blnDAg,
    blnDeducaoChq,
    blnReintegracaoChq: Boolean;
begin
  Result := False;

  cdsFaturamento.Filtered := False;
  cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(strCodEmp);
  cdsFaturamento.Filtered := True;

  If blnExecqryJurDes Then
    pCarregaJurosDescontos;
  If blnExecqryJDDedChq Then
    pCarregaJurosDescontosDeducaoCheques;
  If blnExecqryJDResChq Then
    pCarregaJurosDescontosReintegracaoCheques;
  If blnExecqryJDAgru Then
    pCarregaJurosDescontosAgrupamento;
  If blnExecqryJDAgruChqDeducao Then
    pCarregaJurosDescontosAgrupamentoChqDeducao;
  If blnExecqryJDAgruChqReintegracao Then
    pCarregaJurosDescontosAgrupamentoChqReintegracao;

  cdsJurDes.Filtered := False;
  cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJurDes.Filtered := True;

  cdsJDDedChq.Filtered := False;
  cdsJDDedChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDDedChq.Filtered := True;

  cdsJDResChq.Filtered := False;
  cdsJDResChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDResChq.Filtered := True;

  blnPis := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value > 0);
  blnCof := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value > 0);
  blnIcm := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value > 0);
  blnIpi := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value > 0);
  blnRet := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value > 0);
  blnFre := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value > 0);

  blnJur := (cdsJurDes.FieldByName('VALJUR').AsFloat > 0);
  blnDes := (cdsJurDes.FieldByName('VALDES').AsFloat > 0);

  blnJAg := (cdsJDAgru.FieldByName('VALJUR').AsFloat > 0);
  blnDAg := (cdsJDAgru.FieldByName('VALDES').AsFloat > 0);

  blnDeducaoChq := (cdsJDAgruChqDeducao.FieldByName('DEDUCA').AsFloat > 0);
  blnReintegracaoChq := (cdsJDAgruChqReintegracao.FieldByName('REINTE').AsFloat > 0);

  blnJurChq := (cdsJDDedChq.FieldByName('CHQ_DEDUCA').AsFloat > 0);
  blnDesChq := (cdsJDResChq.FieldByName('CHQ_REINTE').AsFloat > 0);

  If fRetRegimeTributario(strCodEmp) = trLucroReal Then
  Begin
    If caCampo = caPIS Then
      Result := qryEmpTri.Locate('TRI_LRPISL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnPis
    Else If caCampo = caCOFINS Then
      Result := qryEmpTri.Locate('TRI_LRCOFL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnCof
    Else If caCampo = caICMS Then
      Result := qryEmpTri.Locate('TRI_LRICML;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIcm
    Else If caCampo = caIPI Then
      Result := qryEmpTri.Locate('TRI_LRIPIL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIpi
    Else If caCampo = caSubsTri Then
      Result := qryEmpTri.Locate('TRI_LRRETL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnRet
    Else If caCampo = caFrete Then
      Result := qryEmpTri.Locate('TRI_LRFREL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnFre
    Else If caCampo = caJurosVendaBruta Then
      Result := qryEmpTri.Locate('TRI_LRJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_LRDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq)
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_LRJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_LRDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq);
  End
  Else If fRetRegimeTributario(strCodEmp) = trLucroPresumido Then
  Begin
    If caCampo = caPIS Then
      Result := qryEmpTri.Locate('TRI_LPPISL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnPis
    Else If caCampo = caCOFINS Then
      Result := qryEmpTri.Locate('TRI_LPCOFL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnCof
    Else If caCampo = caICMS Then
      Result := qryEmpTri.Locate('TRI_LPICML;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIcm
    Else If caCampo = caIPI Then
      Result := qryEmpTri.Locate('TRI_LPIPIL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIpi
    Else If caCampo = caSubsTri Then
      Result := qryEmpTri.Locate('TRI_LPRETL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnRet
    Else If caCampo = caFrete Then
      Result := qryEmpTri.Locate('TRI_LPFREL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnFre
    Else If caCampo = caJurosVendaBruta Then
      Result := qryEmpTri.Locate('TRI_LPJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_LPDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq)
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_LPJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_LPDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq);
  End
  Else If fRetRegimeTributario(strCodEmp) = trSimplesNacional Then
  Begin
    If caCampo = caICMS Then
      Result := qryEmpTri.Locate('TRI_SNICML;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIcm
    Else If caCampo = caIPI Then
      Result := qryEmpTri.Locate('TRI_SNIPIL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnIpi
    Else If caCampo = caSubsTri Then
      Result := qryEmpTri.Locate('TRI_SNRETL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnRet
    Else If caCampo = caFrete Then
      Result := qryEmpTri.Locate('TRI_SNFREL;TRI_CODEMP', VarArrayOf(['S', strCodEmp]), []) And blnFre
    Else If caCampo = caJurosVendaBruta Then
      Result := qryEmpTri.Locate('TRI_SNJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_SNDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq)
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_SNJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnJur Or blnJAg Or blnDeducaoChq Or blnJurChq)
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_SNDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And (blnDes Or blnDAg Or blnReintegracaoChq Or blnDesChq);
  End;
end;

procedure TfrmRelEstatAnalResult2.pCarregaValoresImpostos(strCodEmp: String);
  Var
    fltAlqSN,
    fltAlqIrp,
    fltAlqCsl: Double;
Begin
  fltTotPis := 0;
  fltTotCof := 0;
  fltTotIcm := 0;
  fltTotIpi := 0;
  fltTotRet := 0;
  fltTotFre := 0;
  fltTotJur := 0;
  fltTotDes := 0;
  fltTotDeducCtrChq := 0;
  fltTotReintCtrChq := 0;
  fltTotJAg := 0;
  fltTotDAg := 0;
  fltTotDeducChq := 0;
  fltTotReintChq := 0;


  fltTotASN := 0;
  fltTotAIr := 0;
  fltTotACs := 0;

  fltAlqSN := fRetPercentualTributos(ptAlqSimpNac, strCodEmp);

  If fltAlqSN > 0 Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
      fltTotASN := 0
    Else
      fltTotASN := fFormataFloat((TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqSN) / 100, 2);
  End;

  fltAlqIrp := fRetPercentualTributos(ptAlqIRPJ, strCodEmp);

  If fltAlqIrp > 0 Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
      fltTotAIr := 0
    Else
      fltTotAIr := fFormataFloat((TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqIrp) / 100, 2);
  End;

  fltAlqCsl := fRetPercentualTributos(ptAlqCSLL, strCodEmp);

  If fltAlqCsl > 0 Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
      fltTotACs := 0
    Else
      fltTotACs := fFormataFloat((TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqCsl) / 100, 2);
  End;

  cdsJurDes.Filtered := False;
  cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJurDes.Filtered := True;

  cdsJDDedChq.Filtered := False;
  cdsJDDedChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDDedChq.Filtered := True;

  cdsJDResChq.Filtered := False;
  cdsJDResChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDResChq.Filtered := True;

  cdsJDAgru.Filtered := False;
  cdsJDAgru.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDAgru.Filtered := True;

  cdsJDAgruChqDeducao.Filtered := False;
  cdsJDAgruChqDeducao.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDAgruChqDeducao.Filtered := True;

  cdsJDAgruChqReintegracao.Filtered := False;
  cdsJDAgruChqReintegracao.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJDAgruChqReintegracao.Filtered := True;

  If fConfiguracaoRegTriAtiva(caJurosVendaBruta, strCodEmp) Then
  Begin
    fltTotJur := cdsJurDes.FieldByName('VALJUR').AsFloat;
    fltTotDeducCtrChq := cdsJDDedChq.FieldByName('CHQ_DEDUCA').AsFloat;
    fltTotJAg := cdsJDAgru.FieldByName('VALJUR').AsFloat;
    fltTotDeducChq := cdsJDAgruChqDeducao.FieldByName('DEDUCA').AsFloat;
  End;

  If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, strCodEmp) Then
  Begin
    fltTotDes := cdsJurDes.FieldByName('VALDES').AsFloat;
    fltTotReintCtrChq := cdsJDResChq.FieldByName('CHQ_REINTE').AsFloat;
    fltTotDAg := cdsJDAgru.FieldByName('VALDES').AsFloat;
    fltTotReintChq := cdsJDAgruChqReintegracao.FieldByName('REINTE').AsFloat;
  End;

  If fConfiguracaoRegTriAtiva(caPIS, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value = Null Then
      fltTotPis := 0
    Else
      fltTotPis := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value;
  End;

  If fConfiguracaoRegTriAtiva(caCOFINS, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value = Null Then
      fltTotCof := 0
    Else
      fltTotCof := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value;
  End;

  If fConfiguracaoRegTriAtiva(caICMS, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value = Null Then
      fltTotIcm := 0
    Else
      fltTotIcm := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value;
  End;

  If fConfiguracaoRegTriAtiva(caIPI, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value = Null Then
      fltTotIpi := 0
    Else
      fltTotIpi := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value;
  End;

  If fConfiguracaoRegTriAtiva(caSubsTri, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value = Null Then
      fltTotRet := 0
    Else
      fltTotRet := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value;
  End;

  If fConfiguracaoRegTriAtiva(caFrete, strCodEmp) Then
  Begin
    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value = Null Then
      fltTotFre := 0
    Else
      fltTotFre := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value;
  End;
End;

{****************************************}
{* CARREGA DADOS DE VENDA               *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaVendas;
  Var
    strSQL  : String;
    strCam  : String;
    strCta  : String;
    intCont : Integer;
    fltCusto: Double;
    fltVenda: Double;
    fltMarge: Double;
    fltJur  : Double;
    fltTotalOperacional: Double;
    fltTotalVendas: Double;
    fltTotalBrutas: Double;
    fltMargem: Double;
    blnAnlsVndSintetica:Boolean;

    fltAlqSN,
    fltAlqIrp,
    fltAlqCsl: Double;

    fltTotPisGer,
    fltTotCofGer,
    fltTotIcmGer,
    fltTotIpiGer,
    fltTotRetGer,
    fltTotFreGer,
    fltTotJurGer,
    fltTotDesGer,
    fltTotASNGer,
    fltTotAIrGer,
    fltTotACsGer,
    fltTotJAgGer,
    fltTotDAgGer,
    fltTotDeducGerChq,
    fltTotReintGerChq,
    fltTotDeducGerCtrChq,
    fltTotReintGerCtrChq: Double;

   Const
    arrCampos: Array [0..8] Of String = ('FAT_TOTVEN',     'FAT_TOTCUS',      'FAT_VENBRU',
                                         'FAT_TOTPIS',     'FAT_TOTCOF',      'FAT_TOTICM',
                                         'FAT_TOTIPI',     'FAT_TOTRET',      'FAT_TOTFRE');
    arrExpres: Array [0..8] Of String = ('SUM(FAT_VALVEN)','SUM(FAT_VALCUS)', 'SUM(FAT_VALVEN) - SUM(FAT_VALCUS)',
                                         'SUM(DET_VALPIS)','SUM(DET_VALCOF)', 'SUM(DET_VALICM)',
                                         'SUM(DET_VALIPI)','SUM(DET_VALRET)', 'SUM(DET_TOTFRE)');

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 1;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := '';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereVenTro(strChave, strDescri: String);
    Var
      intCont: Integer;
  Begin
    pIniciaInsercao(strChave,strDescri);

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]) + ' AND FAT_TIPFAT = ' + QuotedStr(strChave);
      cdsFaturamento.Filtered := True;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;
    End;
    cdsRelat.Post;
  End;

  procedure pInsereCndPgto(strChave, strDescri: String);
    Var
      intAux   : Integer;
      intCont  : Integer;
      strCodCnd: String;
      strConPag: String;
  Begin
    intAux := 0;
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]) + ' AND FAT_TIPFAT = ' + QuotedStr(strChave);
      cdsFaturamento.Filtered := True;
      cdsFaturamento.First;
      While Not cdsFaturamento.Eof Do
      Begin
        If (cdsFaturamento.FieldByName('DET_CODCND').AsString <> strCodCnd) Or
           (cdsFaturamento.FieldByName('DET_CONPAG').AsString <> strConPag) Then
        Begin
          pIniciaInsercao(strChave, '    (' + cdsFaturamento.FieldByName('DET_CONPAG').AsString + ')-' + cdsFaturamento.FieldByName('CND_DESCRI').AsString);
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsFaturamento.FieldByName('FAT_VALVEN').Value;
        End
        Else If (intAux > 0) And ((strCodCnd <> '') Or (strConPag <> '')) Then
        Begin
          cdsRelat.Edit;
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat +
                                                                            cdsFaturamento.FieldByName('FAT_VALVEN').Value;
        End;
        Inc(intAux);
        strCodCnd := cdsFaturamento.FieldByName('DET_CODCND').AsString;
        strConPag := cdsFaturamento.FieldByName('DET_CONPAG').AsString;
        cdsFaturamento.Next;
      End;
      cdsFaturamento.First;
    End;
  End;

  function fSQLFiltroEmpresa: String;
  begin
    If (rdgEmpresa.ItemIndex = 0) Then
      Result := ' DET_CODEMP '
    Else
      Result := ' I.DET_EMPORI ';
  end;
begin

  Try
    strCam := 'IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0)';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FOR_CODFOR, ';
    strSQL := strSQL + '  FOR_NOMFOR, ';
    strSQL := strSQL + '  ' + fSQLFiltroEmpresa + ' AS FAT_CODEMP, ';

    If(chkTrMarcus.Checked) Then
      strSQL := strSQL + '  IF(LOCATE(DET_ESPDOC,"TR_DV_PD_") > 0, "TRODEV", IF(LEFT(DET_CLAFIS,1) < 5, "TRODEV", IF(DET_CONPAG = 1000, IF(DET_CODCLI IN(' + VS_strCliFil + '), "VALTRA", "VENVIS"), IF(DET_CODCLI IN(' + VS_strCliFil + '), "VALTRA", "VENPRA"))) ) AS FAT_TIPFAT,'
    Else
      strSQL := strSQL + '  IF(LOCATE(DET_ESPDOC,"TR_DV_PD_") > 0, "TRODEV", IF(LEFT(DET_CLAFIS,1) < 5, "TRODEV", IF(DET_CONPAG = 1000, "VENVIS", "VENPRA"))) AS FAT_TIPFAT, ';

    strSQL := strSQL + '  DET_CODCND, ';
    strSQL := strSQL + '  DET_CONPAG, ';
    strSQL := strSQL + '  DET_CLAFIS, ';
    strSQL := strSQL + '  CND_DESCRI, ';
    strSQL := strSQL + '  CND_INFANA, ';
    strSQL := strSQL + '  (DET_QTDITE * IFNULL(UNI_PESLIT, 0) / :LITGAL) AS DET_PESLIT, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -' + strCam + ', ' + strCam + ') AS FAT_VALCUS, ';
    strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS FAT_VALVEN, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALPIS, 0) AS DET_VALPIS, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALCOF, 0) AS DET_VALCOF, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALICM, 0) AS DET_VALICM, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALIPI, 0) AS DET_VALIPI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALRET, 0) AS DET_VALRET, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_TOTFRE, 0) AS DET_TOTFRE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';

    strSQL := strSQL + '  LEFT JOIN MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM AND DET_VALRET = 0 ';
    strSQL := strSQL + '  LEFT JOIN CADCND ON DET_CODCND = CND_CODIGO ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI I ON I.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD  ';
    strSQL := strSQL + '  LEFT JOIN CADFOR ON DET_FORITE = FOR_CODFOR  ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + cnsFiltroFFDVTR;    
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"  AND ';

    If not fCfgSis('FATCLF', varBoolean) Then
      strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  ' + fSQLFiltroEmpresa + ' IN (' + fEmpSelecionadas(True) + ') AND ';

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';
    strSQL := strSQL + IfThen(fCfgSis('ENTBRF', varBoolean), ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ', ')');
    
    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
     
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  FOR_CODFOR, ');
      SQL.Add('  FOR_NOMFOR, ');
      SQL.Add('  FAT_CODEMP, ');
      SQL.Add('  FAT_TIPFAT, ');
      SQL.Add('  DET_CODCND, ');
      SQL.Add('  DET_CONPAG, ');
      SQL.Add('  DET_CLAFIS, ');
      SQL.Add('  CND_DESCRI, ');
      SQL.Add('  CND_INFANA, ');
      SQL.Add('  SUM(DET_PESLIT) AS DET_PESLIT, ');
      SQL.Add('  SUM(FAT_VALCUS) AS FAT_VALCUS, ');
      SQL.Add('  SUM(FAT_VALVEN) AS FAT_VALVEN, ');
      SQL.Add('  SUM(DET_VALPIS) AS DET_VALPIS, ');
      SQL.Add('  SUM(DET_VALCOF) AS DET_VALCOF, ');
      SQL.Add('  SUM(DET_VALICM) AS DET_VALICM, ');
      SQL.Add('  SUM(DET_VALIPI) AS DET_VALIPI, ');
      SQL.Add('  SUM(DET_VALRET) AS DET_VALRET, ');
      SQL.Add('  SUM(DET_TOTFRE) AS DET_TOTFRE  ');
      SQL.Add('FROM ');
      SQL.Add('  (' + strSQL + ') AS VENDAS ');
      SQL.Add('GROUP BY ');
      SQL.Add('  FOR_CODFOR, ');
      SQL.Add('  FAT_CODEMP, ');
      SQL.Add('  FAT_TIPFAT, ');
      SQL.Add('  DET_CODCND, ');
      SQL.Add('  DET_CONPAG, ');
      SQL.Add('  DET_CLAFIS  ');

      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
          ParamByName('LITGAL').AsFloat := 1
        Else
          ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;
      
      cdsFaturamento.Close;
      cdsFaturamento.SetProvider(cpvFaturamento);
      cpvFaturamento.DataSet := qryGenerica;
      cdsFaturamento.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {* DE VENDAS E TOTAL DE CUSTO           *}
      {*************************************AF*}
      For intCont := 0 To Length(arrCampos)-1 Do
      Begin

        SetLength(arrSomatorias,Length(arrSomatorias) + 1);
        arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

        With arrSomatorias[Length(arrSomatorias) -1] Do
        Begin
          Name          := arrCampos[intCont];
          FieldName     := arrCampos[intCont];
          DataSet       := cdsFaturamento;
          Expression    := arrExpres[intCont];
          DisplayFormat := '#,##0.00';
          Active        := True;
        End;

      End;

      cdsFaturamento.Filter := 'FAT_TIPFAT = ' + QuotedStr('VENVIS');
      cdsFaturamento.Filtered := True;
      cdsFaturamento.Open;
      cdsFaturamento.IndexFieldNames := 'FAT_TIPFAT;DET_CODCND;DET_CONPAG';
    End;

    {******************************************}
    {* INSERE NA TABELA DO RELATORIO OS DADOS *}
    {***************************************AF*}
    pInsereVenTro('VENVIS','(+)VENDAS A VISTA');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('VENVIS', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    pInsereVenTro('VENPRA','(+)VENDAS A PRAZO');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('VENPRA', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    If(chkTrMarcus.Checked) Then
    Begin
      pInsereVenTro('VALTRA','(+)TRANSFERENCIAS');
      If (rdgFatura.ItemIndex = 1) Then
        pInsereCndPgto('VALTRA', cdsFaturamento.FieldByName('CND_DESCRI').AsString);
    End;

    pInsereVenTro('TRODEV','(-)TROCAS/DEVOLUCAO');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('TRODEV', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    pIniciaInsercao('***','');
    cdsRelat.Post;

    fltTotalVendas := 0.0;
    fltTotalBrutas := 0.0;

    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = 1';
    cdsCta124.Filtered := True;

    {****************************************}
    {* TOTAL DE VENDAS                      *}
    {*************************************AF*}
    pIniciaInsercao('TOTVEN','TOTAL DA VENDA - DEVOLUÇÕES');

    blnAnlsVndSintetica:=cdsCta124.IsEmpty;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;
      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;
      fltTotalVendas := fltTotalVendas + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
    End;
    cdsRelat.Post;

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {****************************************}
    {* CONTAS TIPO 1                        *}
    {*************************************AF*}
    If Not cdsCta124.IsEmpty Then
    Begin
      strCta := '';
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsCta124.Data;
      cdsCtaAux.IndexFieldNames := 'CTP_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 1';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin
        If strCta = cdsCtaAux.FieldByName('CTP_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP1','(-)' + cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTP_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;
          cdsCta124.Filter   := 'CTP_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTP_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsCta124.Filtered := True;
          If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;
        End;
        cdsRelat.Post;

        cdsCtaAux.Next;
      End;
      cdsCtaAux.IndexFieldNames := '';
    End;

    If fVerificaSeImpSessao(caPIS) Then
    Begin
      pIniciaInsercao('VALPIS','(-)PIS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caPIS, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caCOFINS) Then
    Begin
      pIniciaInsercao('VALCOF','(-)COFINS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caCOFINS, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caICMS) Then
    Begin
      pIniciaInsercao('VALICM','(-)ICMS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caICMS, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caIPI) Then
    Begin
      pIniciaInsercao('VALIPI','(+)IPI');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caIPI, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caSubsTri) Then
    Begin
      pIniciaInsercao('VALRET','(+)SUBSTITUIÇÃO TRIBUTÁRIA');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caSubsTri, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caFrete) Then
    Begin
      pIniciaInsercao('VALFRE','(+)FRETE');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caFrete, slsEmpresas[intCont-1]) Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(ptAlqSimpNac) Then
    Begin
      pIniciaInsercao('ALQSIN','(-)ALÍQUOTA SIMPLES NACIONAL');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltAlqSN := fRetPercentualTributos(ptAlqSimpNac, slsEmpresas[intCont-1]);

        If fltAlqSN > 0 Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqSN) / 100;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(ptAlqIRPJ) Then
    Begin
      pIniciaInsercao('ALQIRP','(-)ALÍQUOTA DE IRPJ');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltAlqIrp := fRetPercentualTributos(ptAlqIRPJ, slsEmpresas[intCont-1]);

        If fltAlqIrp > 0 Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqIrp) / 100;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(ptAlqCSLL) Then
    Begin
      pIniciaInsercao('ALQCSL','(-)ALÍQUOTA DE CSLL');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltAlqCsl := fRetPercentualTributos(ptAlqCSLL, slsEmpresas[intCont-1]);

        If fltAlqCsl > 0 Then
        Begin
          cdsFaturamento.Filtered := False;
          cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsFaturamento.Filtered := True;

          If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value * fltAlqCsl) / 100;
        End;
      End;
      cdsRelat.Post;
    End;

    {****************************************}
    {* JUROS E DESCONTOS                    *}
    {*************************************AF*}
    pCarregaJurosDescontos;

    If fVerificaSeImpSessao(caJurosVendaBruta) Then
    Begin
      pIniciaInsercao('JURREC','(+)JUROS RECEBIDOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caJurosVendaBruta, slsEmpresas[intCont-1]) Then
        Begin
          cdsJurDes.Filtered := False;
          cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJurDes.Filtered := True;
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJurDes.FieldByName('VALJUR').AsFloat;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caDescontoVendaBruta) Then
    Begin
      pIniciaInsercao('DESCON','(-)DESCONTOS CONCEDIDOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, slsEmpresas[intCont-1]) Then
        Begin
          cdsJurDes.Filtered := False;
          cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJurDes.Filtered := True;
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJurDes.FieldByName('VALDES').AsFloat;
        End;
      End;
      cdsRelat.Post;
    End;

    {************************************************}
    {* JUROS E DESCONTOS APLICADOS AOS AGRUPAMENTOS *}
    {*********************************************VM*}

    pCarregaJurosDescontosAgrupamento;

    If fVerificaSeImpSessao(caJurosVendaBruta) Then
    Begin
      pIniciaInsercao('JURAGR','(+)JUROS COBRADOS EM AGRUPAMENTOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caJurosVendaBruta, slsEmpresas[intCont-1]) Then
        Begin
          cdsJDAgru.Filtered := False;
          cdsJDAgru.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJDAgru.Filtered := True;
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDAgru.FieldByName('VALJUR').AsFloat;
        End;
      End;
      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caDescontoVendaBruta) Then
    Begin
      pIniciaInsercao('DESAGR','(-)DESCONTOS CONCEDIDOS EM AGRUPAMENTOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, slsEmpresas[intCont-1]) Then
        Begin
          cdsJDAgru.Filtered := False;
          cdsJDAgru.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJDAgru.Filtered := True;
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDAgru.FieldByName('VALDES').AsFloat;
        End;
      End;
      cdsRelat.Post;
    End;

    If (fCfgSis('CHQDRE') = 'S') Then
    Begin
      pCarregaJurosDescontosDeducaoCheques;

      If fVerificaSeImpSessao(caJurosVendaBruta) Then
      Begin
        pIniciaInsercao('JURECH','(-)DEDUÇÃO JUR POR REC CHQ');
        For intCont := 1 To slsEmpresas.Count Do
        Begin
          If fConfiguracaoRegTriAtiva(caJurosVendaBruta, slsEmpresas[intCont-1]) Then
          Begin
            cdsJDDedChq.Filtered := False;
            cdsJDDedChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
            cdsJDDedChq.Filtered := True;
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDDedChq.FieldByName('CHQ_DEDUCA').AsFloat;
          End;
        End;
        cdsRelat.Post;
      End;

      pCarregaJurosDescontosReintegracaoCheques;

      If fVerificaSeImpSessao(caDescontoVendaBruta) Then
      Begin
        pIniciaInsercao('DERECH','(+)REINTEGRAÇÃO JUR POR REDEPOSITO CHQ');
        For intCont := 1 To slsEmpresas.Count Do
        Begin
          If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, slsEmpresas[intCont-1]) Then
          Begin
            cdsJDResChq.Filtered := False;
            cdsJDResChq.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
            cdsJDResChq.Filtered := True;
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDResChq.FieldByName('CHQ_REINTE').AsFloat;
          End;
        End;
        cdsRelat.Post;
      End;

      pCarregaJurosDescontosAgrupamentoChqDeducao;

      If fVerificaSeImpSessao(caJurosVendaBruta) Then
      Begin
        pIniciaInsercao('JURCHQ','(-)DEDUÇÃO JUR COB. EM AGR. POR DEV CHQ');
        For intCont := 1 To slsEmpresas.Count Do
        Begin
          If fConfiguracaoRegTriAtiva(caJurosVendaBruta, slsEmpresas[intCont-1]) Then
          Begin
            cdsJDAgruChqDeducao.Filtered := False;
            cdsJDAgruChqDeducao.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]) ;
            cdsJDAgruChqDeducao.Filtered := True;
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDAgruChqDeducao.FieldByName('DEDUCA').AsFloat;
          End;
        End;
        cdsRelat.Post;
      End;

      pCarregaJurosDescontosAgrupamentoChqReintegracao;

      If fVerificaSeImpSessao(caDescontoVendaBruta) Then
      Begin
        pIniciaInsercao('DESCHQ','(+)REINTE.JUR.COB.AGR.REDEPOSITO CHQ');
        For intCont := 1 To slsEmpresas.Count Do
        Begin
          If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, slsEmpresas[intCont-1]) Then
          Begin
            cdsJDAgruChqReintegracao.Filtered := False;
            cdsJDAgruChqReintegracao.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
            cdsJDAgruChqReintegracao.Filtered := True;
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJDAgruChqReintegracao.FieldByName('REINTE').AsFloat;
          End;
        End;
        cdsRelat.Post;
      End;

    End;

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {****************************************}
    {* TOTAL DE VENDA LIQUIDA               *}
    {*************************************AF*}
    pIniciaInsercao('VENLIQ','RECEITA LÍQUIDA');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      pCarregaValoresImpostos(slsEmpresas[intCont-1]);

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        fltVenda := 0
      Else
        fltVenda := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
        fltCusto := 0
      Else
        fltCusto := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenda  -
                                                                        Abs(fltCusto)  -
                                                                        fltTotPis -
                                                                        fltTotCof -
                                                                        fltTotIcm +
                                                                        fltTotIpi +
                                                                        fltTotRet +
                                                                        fltTotFre +
                                                                        fltTotJur +
                                                                        fltTotJAg -
                                                                        fltTotDeducChq -
                                                                        fltTotDeducCtrChq -
                                                                        fltTotDes -
                                                                        fltTotDAg +
                                                                        fltTotReintChq +
                                                                        fltTotReintCtrChq -
                                                                        fltTotASN -
                                                                        fltTotAIr -
                                                                        fltTotACs;

      fltTotalBrutas := fltTotalBrutas + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
    End;

    cdsRelat.Post;

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {****************************************}
    {* TOTAL DE CUSTO                       *}
    {*************************************AF*}
    pIniciaInsercao('TOTCUS','CUSTO LÍQ.CMV (sem PIS/COFINS/ICMS ENTRADA)');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value;
    End;
    cdsRelat.Post;

    {****************************************}
    {* CONTAS DO TIPO 2                     *}
    {*************************************AF*}
    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2');
    cdsCta124.Filtered := True;

    If Not cdsCta124.IsEmpty Then
    Begin
      strCta := '';
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsCta124.Data;
      cdsCtaAux.IndexFieldNames := 'CTP_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 2';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin

        If strCta = cdsCtaAux.FieldByName('CTP_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP2',cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTP_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;
          cdsCta124.Filter   := 'CTP_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTP_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsCta124.Filtered := True;
          If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;
        End;
        cdsRelat.Post;

        cdsCtaAux.Next;
      End;
      cdsCtaAux.IndexFieldNames := '';

      {****************************************}
      {* TOTAL DE CUSTO DOS PRODUTOS          *}
      {*************************************AF*}
      pIniciaInsercao('CUSTOT','(-)TOTAL DE CUSTO DOS PRODUTOS');

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsFaturamento.Filtered := False;
        cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsFaturamento.Filtered := True;

        cdsCta124.Filtered := False;
        cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCta124.Filtered := True;

        If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value = Null Then
          fltVenda := 0
        Else
          fltVenda := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value;

        If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
          fltCusto := 0
        Else
          fltCusto := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenda + fltCusto;
      End;
      cdsRelat.Post;
    End;

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {****************************************}
    {* RESULTADO DE VENDA BRUTO             *}
    {*************************************AF*}
    pIniciaInsercao('VENBRU','RESULTADO DE VENDA BRUTO');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      pCarregaValoresImpostos(slsEmpresas[intCont-1]);

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
        fltVenda := 0
      Else
        fltVenda := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
        fltCusto := 0
      Else
        fltCusto := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_VENBRU')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0 -
                                                                          fltVenda -
                                                                          Abs(fltCusto) -
                                                                          fltTotPis -
                                                                          fltTotCof -
                                                                          fltTotIcm +
                                                                          fltTotIpi +
                                                                          fltTotRet +
                                                                          fltTotFre +
                                                                          fltTotJur +
                                                                          fltTotJAg -
                                                                          fltTotDeducChq -
                                                                          fltTotDeducCtrChq -
                                                                          fltTotDes -
                                                                          fltTotDAg +
                                                                          fltTotReintChq +
                                                                          fltTotReintCtrChq -
                                                                          fltTotASN -
                                                                          fltTotAIr -
                                                                          fltTotACs
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_VENBRU')).Value - fltVenda - Abs(fltCusto) -
                                                                          fltTotPis -
                                                                          fltTotCof -
                                                                          fltTotIcm +
                                                                          fltTotIpi +
                                                                          fltTotRet +
                                                                          fltTotFre +
                                                                          fltTotJur +
                                                                          fltTotJAg -
                                                                          fltTotDeducChq -
                                                                          fltTotDeducCtrChq -
                                                                          fltTotDes -
                                                                          fltTotDag +
                                                                          fltTotReintChq +
                                                                          fltTotReintCtrChq -
                                                                          fltTotASN -
                                                                          fltTotAIr -
                                                                          fltTotACs;
    End;
    cdsRelat.Post;

    {****************************************}
    {* MARGEM DE CONTRIBUIÇÃO               *}
    {*************************************AF*}
    pIniciaInsercao('MARCON','MARGEM DE CONTRIBUICAO');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value = Null Then
        fltCusto := 0
      Else
        fltCusto := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value <> Null Then
        fltCusto := fltCusto + TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        fltVenda := 0
      Else
        fltVenda := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value <> Null Then
        fltVenda := fltVenda - Abs(TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value);

      pCarregaValoresImpostos(slsEmpresas[intCont-1]);

      fltVenda := fltVenda - fltTotPis -
                             fltTotCof -
                             fltTotIcm +
                             fltTotIpi +
                             fltTotRet +
                             fltTotFre +
                             fltTotJur +
                             fltTotJAg -
                             fltTotDeducChq -
                             fltTotDeducCtrChq -
                             fltTotDes -
                             fltTotDAg +
                             fltTotReintChq +
                             fltTotReintCtrChq -
                             fltTotASN -
                             fltTotAIr -
                             fltTotACs;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fCalculaPrecoVenda(2, fltCusto, fltVenda, 0,0,0,0,0, auxStrMarMkp, auxStrPcmPro, auxIntDecUni);
    End;

    cdsFaturamento.Filtered := False;

    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value = Null Then
      fltCusto := 0 Else fltCusto := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value;

    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2');
    cdsCta124.Filtered := True;

    If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value <> Null Then
      fltCusto := fltCusto + TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

    If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
      fltVenda := 0
    Else
      fltVenda := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1');
    cdsCta124.Filtered := True;

    If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value <> Null Then
      fltVenda := fltVenda - Abs(TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value);

    fltTotPisGer := 0;
    fltTotCofGer := 0;
    fltTotIcmGer := 0;
    fltTotIpiGer := 0;
    fltTotRetGer := 0;
    fltTotFreGer := 0;
    fltTotJurGer := 0;
    fltTotDesGer := 0;
    fltTotASNGer := 0;
    fltTotAIrGer := 0;
    fltTotACsGer := 0;
    fltTotJAgGer := 0;
    fltTotDAgGer := 0;
    fltTotDeducGerChq := 0;
    fltTotReintGerChq := 0;
    fltTotDeducGerCtrChq := 0;
    fltTotReintGerCtrChq := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      pCarregaValoresImpostos(slsEmpresas[intCont-1]);

      fltTotPisGer := fltTotPisGer + fltTotPis;
      fltTotCofGer := fltTotCofGer + fltTotCof;
      fltTotIcmGer := fltTotIcmGer + fltTotIcm;
      fltTotIpiGer := fltTotIpiGer + fltTotIpi;
      fltTotRetGer := fltTotRetGer + fltTotRet;
      fltTotFreGer := fltTotFreGer + fltTotFre;
      fltTotJurGer := fltTotJurGer + fltTotJur;
      fltTotDesGer := fltTotDesGer + fltTotDes;
      fltTotASNGer := fltTotASNGer + fltTotASN;
      fltTotAIrGer := fltTotAIrGer + fltTotAIr;
      fltTotACsGer := fltTotACsGer + fltTotACs;
      fltTotJAgGer := fltTotJAgGer + fltTotJAg;
      fltTotDAgGer := fltTotDAgGer + fltTotDAg;
      fltTotDeducGerChq := fltTotDeducGerChq + fltTotDeducChq;
      fltTotReintGerChq := fltTotReintGerChq + fltTotReintChq;
      fltTotDeducGerCtrChq := fltTotDeducGerCtrChq + fltTotDeducCtrChq;
      fltTotReintGerCtrChq := fltTotReintGerCtrChq + fltTotReintCtrChq;
    End;

    cdsFaturamento.Filtered := False;

    fltVenda := fltVenda - fltTotPisGer -
                           fltTotCofGer -
                           fltTotIcmGer +
                           fltTotIpiGer +
                           fltTotRetGer +
                           fltTotFreGer +
                           fltTotJurGer +
                           fltTotJAgGer -
                           fltTotDeducGerChq -
                           fltTotDeducGerCtrChq -
                           fltTotDesGer -
                           fltTotDAgGer +
                           fltTotReintGerChq +
                           fltTotReintGerCtrChq -
                           fltTotASNGer -
                           fltTotAIrGer -
                           fltTotACsGer;

    fltMarge := fCalculaPrecoVenda(2, fltCusto, fltVenda, 0,0,0,0,0, auxStrMarMkp, auxStrPcmPro, auxIntDecUni);
    cdsRelat.FieldByName('REL_MARGEM').AsFloat := fltMarge;
    cdsRelat.Post;

    If cdsRelat.Locate('REL_CODCAM','VENBRU',[]) Then
    Begin
      cdsRelat.Edit;
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := fltMarge;
      cdsRelat.Post;
    End;
  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaVendasFornec;
  Var
    strCodFor: String;
    blnUsaCnd: Boolean;
    fltTotGer: Double;
    fltTotAcu: Double;
begin
  Try

    blnUsaCnd := fCfgSis('USACND', varBoolean);
    fltTotGer := 0;
    fltTotAcu := 0;

    With cdsFaturamento Do
    Begin
      DisableControls;
      Filtered        := False;
      IndexFieldNames := 'FOR_CODFOR';
      First;
      cdsVenFor.EmptyDataSet;
      cdsVenFor.DisableControls;
      cdsVenFor.LogChanges := False;
      While Not Eof Do
      Begin
        If (strCodFor <> FieldByName('FOR_CODFOR').AsString) Then
        Begin
          cdsVenFor.Insert;
          cdsVenFor.FieldByName('CODFOR').AsString := FieldByName('FOR_CODFOR').AsString;
          cdsVenFor.FieldByName('NOMFOR').AsString := FieldByName('FOR_NOMFOR').AsString;
        End
        Else
          cdsVenFor.Edit;

        cdsVenFor.FieldByName('PESLIT').AsFloat := cdsVenFor.FieldByName('PESLIT').AsFloat + FieldByName('DET_PESLIT').AsFloat;

        If (FieldByName('FAT_TIPFAT').AsString = 'VENVIS') Then
        Begin
          cdsVenFor.FieldByName('TOTVIS').AsFloat := cdsVenFor.FieldByName('TOTVIS').AsFloat + FieldByName('FAT_VALVEN').AsFloat;
          cdsVenFor.FieldByName('TOTPRZ').AsFloat := cdsVenFor.FieldByName('TOTPRZ').AsFloat + 0;
        End
        Else
        Begin
          cdsVenFor.FieldByName('TOTVIS').AsFloat := cdsVenFor.FieldByName('TOTVIS').AsFloat + 0;
          cdsVenFor.FieldByName('TOTPRZ').AsFloat := cdsVenFor.FieldByName('TOTPRZ').AsFloat + FieldByName('FAT_VALVEN').AsFloat;
        End;

        cdsVenFor.FieldByName('TOTVEN').AsFloat := cdsVenFor.FieldByName('TOTVEN').AsFloat + FieldByName('FAT_VALVEN').AsFloat;

        If (cdsVenFor.FieldByName('TOTVEN').AsFloat > 0) Then
        Begin
          If (cdsVenFor.FieldByName('TOTVIS').AsFloat > 0) Then
            cdsVenFor.FieldByName('PERVIS').AsFloat := (cdsVenFor.FieldByName('TOTVIS').AsFloat / cdsVenFor.FieldByName('TOTVEN').AsFloat) * 100;

          If (cdsVenFor.FieldByName('TOTPRZ').AsFloat > 0) Then
            cdsVenFor.FieldByName('PERPRZ').AsFloat := (cdsVenFor.FieldByName('TOTPRZ').AsFloat / cdsVenFor.FieldByName('TOTVEN').AsFloat) * 100;
        End;

        cdsVenFor.FieldByName('TOTCUS').AsFloat := cdsVenFor.FieldByName('TOTCUS').AsFloat + FieldByName('FAT_VALCUS').AsFloat;

        cdsVenFor.FieldByName('MARGEM').AsFloat := fCalculaPrecoVenda(2,
                                                                      cdsVenFor.FieldByName('TOTCUS').AsFloat,
                                                                      cdsVenFor.FieldByName('TOTVEN').AsFloat, 0, 0, 0, 0, 0, auxStrMarMkp, auxStrPcmPro, auxIntDecUni);

        If (blnUsaCnd)                                         And
           (FieldByName('CND_INFANA').AsString = 'N')          And
           (Not fEmptyStr(FieldByName('DET_CODCND').AsString)) Then
        Begin
          cdsVenFor.FieldByName('TOTPAR').AsFloat := cdsVenFor.FieldByName('TOTPAR').AsFloat + 0;
          cdsVenFor.FieldByName('TOTFOR').AsFloat := cdsVenFor.FieldByName('TOTFOR').AsFloat + 0;
          cdsVenFor.FieldByName('PRZMED').AsFloat := 0;
        End

        Else If Pos(FieldByName('DET_CLAFIS').AsString, VS_strClaVen) > 0 Then
        Begin
          cdsVenFor.FieldByName('PRZMED').AsFloat := fCalcMediaPagto(FieldByName('DET_CONPAG').AsString);
          cdsVenFor.FieldByName('TOTPAR').AsFloat := cdsVenFor.FieldByName('TOTPAR').AsFloat +
                                                     (cdsVenFor.FieldByName('PRZMED').AsFloat * FieldByName('FAT_VALVEN').AsFloat);
          cdsVenFor.FieldByName('TOTFOR').AsFloat := cdsVenFor.FieldByName('TOTFOR').AsFloat + FieldByName('FAT_VALVEN').AsFloat;
        End;

        If (fFormataFloat(cdsVenFor.FieldByName('TOTFOR').AsFloat, 2) = 0.0) Then
          cdsVenFor.FieldByName('PRZMED').AsFloat := 0.0
        Else
        Begin
          If (cdsVenFor.FieldByName('TOTPAR').AsFloat > 0) And
             (cdsVenFor.FieldByName('TOTFOR').AsFloat > 0) Then
            cdsVenFor.FieldByName('PRZMED').AsFloat := cdsVenFor.FieldByName('TOTPAR').AsFloat / cdsVenFor.FieldByName('TOTFOR').AsFloat;
        End;

        fltTotGer := fltTotGer + FieldByName('FAT_VALVEN').AsFloat;
        cdsVenFor.Post;
        strCodFor := FieldByName('FOR_CODFOR').AsString;
        Next;
      End;
      cdsVenFor.EnableControls;
      EnableControls;
    End;
    With cdsVenFor Do
    Begin
      DisableControls;
      First;
      While Not Eof Do
      Begin
        Edit;
        If (cdsVenFor.FieldByName('TOTVEN').AsFloat > 0) And (fltTotGer > 0) Then
          FieldByName('PERREP').AsFloat := (cdsVenFor.FieldByName('TOTVEN').AsFloat / fltTotGer) * 100;
        Post;
        Next;
      End;
      IndexName := 'IDX_001';
      First;
      While Not Eof Do
      Begin
        Edit;
        fltTotAcu := fltTotAcu + cdsVenFor.FieldByName('PERREP').AsFloat;
        FieldByName('PERACU').AsFloat := fltTotAcu;
        Post;
        Next;
      End;
      First;
      EnableControls;
    End;

    cdsVenFor.LogChanges := True;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmRelEstatAnalResult2.pCriaClientVenFor;
begin
  cdsVenFor := TUniClientDataSet.Create(Self);
  With cdsVenFor, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name     := 'CODFOR';
      DataType := ftString;
      Size     := 8;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'NOMFOR';
      DataType := ftString;
      Size     := 60;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PESLIT';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PRZMED';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTVIS';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PERVIS';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTPRZ';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PERPRZ';
     DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTCUS';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTVEN';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'MARGEM';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PERREP';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'PERACU';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTPAR';
      DataType := ftFloat;
      Required := False;
    End;
    With AddFieldDef Do
    Begin
      Name     := 'TOTFOR';
      DataType := ftFloat;
      Required := False;
    End;

    With cdsVenFor.IndexDefs.AddIndexDef Do
    Begin
      Name       := 'IDX_001';
      Fields     := 'PERREP';
      DescFields := 'PERREP';
    End;

    CreateDataSet;
    Open;
  End;
end;

{****************************************}
{* CARREGA CONTAS DE RESULTADO          *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaCtaRes;
  Var
    strSQL   : String;
    strCta   : String;
    strEmp   : String;
    intCont  : Integer;
    intRecNo : Integer;
    fltVenBru: Double;
    fltTotCta: Double;
    fltTotVen: Double;
    fltTotCus: Double;
    fltTotCom: Double;

    fltGerVen: Double;
    fltGerCus: Double;

    strSQLDet: String;
    strSQLGer: String;
    strSQLRec: String;

    qryComissao: TUniQuery;
    arrTotCom : Array Of Double;

    fltTotJurFin,
    fltTotDesFin: Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 2;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CONTAS DE RESULTADO';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  {****************************}
  { INSERE PERCENTUAL DESPESAS }
  {**************************RL}

  procedure pInserePercentualDespesa(strCta: String);
    Var
      intCont  : Integer;
      fltTotDes,
      fltTotVen: Double;
  begin
    pIniciaInsercao('PERDES','');

    fltTotDes := 0;
    fltTotVen := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaRes.Filtered      := False;

      If Not fEmptyStr(strCta) Then
        cdsCtaRes.Filter      := 'CODCRE = ' + QuotedStr(strCta) + ' AND CODEMP = ' + QuotedStr(slsEmpresas[intCont-1])
      Else
        cdsCtaRes.Filter      := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);

      cdsCtaRes.Filtered      := True;

      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      If (TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null) Or
         (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null) Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value * 100) / TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      If Not (TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null) Then
        fltTotDes := fltTotDes + TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;

      If Not (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null) Then
        fltTotVen := fltTotVen + TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;
    End;

    If (fltTotVen = 0) Or (fltTotDes = 0) Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotDes * 100) / fltTotVen;

    cdsRelat.Post;
  end;

  Procedure pZerarArrayTotCom;
    Var
      intCnt : Integer;
  Begin
    For intCnt := Low(arrTotCom) To High(arrTotCom) Do
      arrTotCom[intCnt] := 0.00;
  End;

  function fFormataConta(strCodCta: String): String;
  begin
    Result := Copy(strCodCta, 1, 2) + '.' +
              Copy(strCodCta, 3, 2) + '.' +
              Copy(strCodCta, 5, 3);
  end;

begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  D.CTP_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CODEMP, ';
    strSQL := strSQL + '  G.CRE_CODCRE AS CODCRE, ';
    strSQL := strSQL + '  G.CRE_DESCRE AS DESCTA, ';
    strSQL := strSQL + '  VALOR        AS VALPAG  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
    strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
    strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
    strSQL := strSQL + '                        (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
    strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = ABRV ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + 'WHERE ';

    If blnRegimeDefinidoNoPlanoDeContas Then
    Begin
      If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND '
      Else
      Begin
        strSQL := strSQL + ' IF(CTA_REGDRE = 2, ';
        strSQL := strSQL + '    P.CTP_COMPET IN (' + fRetCompet(mskCompetIni.Text, mskCompetFin.Text) + '), ';
        strSQL := strSQL + '    P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
        strSQL := strSQL + ' ) AND ';
      End;
    End
    Else
    Begin
      If (rdgTipDta.ItemIndex = 2) Then
        strSQL := strSQL + '  P.CTP_COMPET IN (' + fRetCompet(mskDtaIni.Text, mskDtaFin.Text) + ') AND '
      Else
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND ';
    End;

    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) IN (' + fEmpSelecionadas(True) + ') ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    If rdgTipDta.ItemIndex = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQl, 'P.CTP_DTAPAG', 'P.CTP_DTACAD');
//      strSQL := strSQL + ' AND P.CTP_DTAPAG IS NOT NULL ';
      strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL,'VALOR','SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
      strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
      strSQLDet := strSQLDet + 'GROUP BY CODCRE, CODCTA, CODEMP ';

      strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'),'VALOR','SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                ' AND D.CTP_CODCTA IS NULL GROUP BY CODCRE, CODEMP ';
    End
    Else
    Begin
      If blnRegimeDefinidoNoPlanoDeContas Then
      Begin
        strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG) * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
        strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
        strSQLDet := strSQLDet + 'GROUP BY CODCRE, CODCTA, CODEMP ';

        strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG))'), 'ABRV', 'C.CTA_CODCTA') +
                  ' AND D.CTP_CODCTA IS NULL GROUP BY CODCRE, CODEMP ';
      End
      Else
      Begin
        If (rdgTipDta.ItemIndex = 0) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALPAG * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODCRE, CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALPAG)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODCRE, CODEMP ';
        End
        Else If (rdgTipDta.ItemIndex = 2) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODCRE, CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODCRE, CODEMP ';
        End;
      End;
    End;

    strSQL := strSQLDet + ' UNION ALL ' + strSQLGer;

    strSQL := 'SELECT CODEMP, CODCRE, DESCTA, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODCRE, CODCTA, CODEMP ';
    strSQL := strSQL + 'ORDER BY CODCRE ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(FindParam('DTAINI')) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(fRetDtaIni());
        ParamByName('DTAFIN').AsDate := StrToDate(fRetDtaFin());
      End;

      cdsCtaRes.Close;
      cpvCtaRes.DataSet := qryGenerica;
      cdsCtaRes.AggregatesActive := True;
      cdsCtaRes.SetProvider(cpvCtaRes);

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'RESTOT';
        FieldName     := 'RESTOT';
        DataSet       := cdsCtaRes;
        Expression    := 'SUM(VALPAG)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsCtaRes.Open;

      strEmp := '';
      For intCont := 1 To slsEmpresas.Count Do
        strEmp := strEmp + QuotedStr(slsEmpresas[intCont-1]) + ', ';

      strEmp := LeftStr(strEmp, Length(strEmp) - 2);

      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter := 'FAT_CODEMP IN (' + strEmp + ') ';
      cdsFaturamento.Filtered := True;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        fltTotVen := 0
      Else
        fltTotVen := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      {*****************************************}
      {* PROCESSA CTARES E INSERE NO RELATORIO *}
      {**************************************AF*}
      strCta := '';
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsCtaRes.Data;

      While Not cdsCtaAux.Eof Do
      Begin

        If strCta = cdsCtaAux.FieldByName('CODCRE').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        fltTotCus := 0;
        pIniciaInsercao('CTARES',cdsCtaAux.FieldByName('CODCRE').AsString + '-' + cdsCtaAux.FieldByName('DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CODCRE').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCtaRes.Filtered := False;
          cdsCtaRes.Filter   := 'CODCRE = ' + QuotedStr(cdsCtaAux.FieldByName('CODCRE').AsString) + ' AND CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsCtaRes.Filtered := True;

          If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;

          fltTotCus := fltTotCus + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
        End;

        If fltTotVen = 0 Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;

        cdsRelat.Post;

        If (chkPerDes.Checked) Then
          pInserePercentualDespesa(strCta);

        If rdgExibir.ItemIndex = 1 Then
          pInsereCentroCustos('', cdsCtaAux.FieldByName('CODCRE').AsString, fltTotVen)
        Else If rdgExibir.ItemIndex = 2 Then
          pInsereEvento(cdsCtaAux.FieldByName('CODCRE').AsString, fltTotVen);

        cdsCtaAux.Next;
      End;

      fltTotCom := 0;
      SetLength(arrTotCom, slsEmpresas.Count);
      pZerarArrayTotCom;

      {****************************************}
      {* BANDA DE COMISSÃO                    *}
      {*************************************AL*}
      If fCfgSis('TCOPRO') = 2 Then
      Begin
        Try
          qryComissao := fCriaQuery;

          if fCfgSis('ECPDRE', varBoolean) then
            pIniciaInsercao('COMISS','COMISSAO DE PROFISSIONAIS');

          strSQLRec :=             ' SELECT SUM(CTR_VALREC * - 1) AS VALREC FROM ';
          strSQLRec := strSQLRec + '   (SELECT DISTINCT CTR_VALREC, CTR_CODCLI, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP ';
          strSQLRec := strSQLRec + '   FROM CADREC ';
          strSQLRec := strSQLRec + '   JOIN CADDIV D ON D.DIV_CODCLI = CTR_CODCLI ';
          strSQLRec := strSQLRec + '  WHERE CTR_ESPDOC = "CC" ';
          strSQLRec := strSQLRec + '    AND IFNULL(CTR_DOCDIV,"") <> "" ';
          strSQLRec := strSQLRec + '    AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
          strSQLRec := strSQLRec + '    AND LOCATE(CTR_CTABAI, :CTABAI) ';

          if not blnIncDupCliForFil then
            strSQLRec := strSQLRec + '    AND CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

          strSQLRec := strSQLRec + '    AND CTR_CODEMP = :CODEMP) AS TAB';

          With qryComissao.SQL do
          Begin
            Clear;
            Add( strSQLRec );
          End;

          For intCont := 1 To slsEmpresas.Count Do
          Begin
            qryComissao.Close;
            qryComissao.ParamByName('DTAINI').AsDateTime := StrToDate(fRetDtaIni());
            qryComissao.ParamByName('DTAFIN').AsDateTime := StrToDate(fRetDtaFin());
            qryComissao.ParamByName('CODEMP').AsString   := slsEmpresas[intCont -1];
            qryComissao.ParamByName('CTABAI').AsString   := fCfgSis('CTARCX') + '_' + fCfgSis('COMRCX');
            qryComissao.Open;

            if fCfgSis('ECPDRE', varBoolean) then
              cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0;

            qryComissao.First; // com o union pode ser que tenha dois resultados no sum.
            While Not qryComissao.Eof Do
            Begin
              fltTotCom := fltTotCom + qryComissao.FieldByName('VALREC').AsFloat;
              arrTotCom[intCont-1] := arrTotCom[intCont-1] + qryComissao.FieldByName('VALREC').AsFloat;
              if fCfgSis('ECPDRE', varBoolean) then
                cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat + qryComissao.FieldByName('VALREC').AsFloat
              else
              begin
                intRecNo := cdsRelat.RecNo;
                // realocando o valor da comissão para o plano de conta do config CFG_COMRCX
                if cdsRelat.Locate('REL_CODCAM;REL_DESCAM', VarArrayOf(['CTADET', '    ' + fFormataConta(fCfgSis('COMRCX')) + '-' + fCampoTabela('CTA_DESCTA', 'CADCTA', ['CTA_CODCTA'], [fCfgSis('COMRCX')])]), []) then
                begin
                  cdsRelat.Edit;
                  cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat + qryComissao.FieldByName('VALREC').AsFloat;
                  cdsRelat.Post;
                end;
                // realocando o valor da comissão para a conta de resultado associada
                if cdsRelat.Locate('REL_CODCAM;REL_DESCAM', VarArrayOf(['CTARES', fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')]) + '-' + fCampoTabela('CRE_DESCRE', 'CTAGER', ['CRE_CODCRE'], [fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')])])]), []) then
                begin
                  cdsRelat.Edit;
                  cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat + qryComissao.FieldByName('VALREC').AsFloat;
                  cdsRelat.Post;
                end;
                cdsRelat.RecNo := intRecNo;
              end;

              qryComissao.Next;
            End;
          End;

          if fCfgSis('ECPDRE', varBoolean) then
          begin
            If fltTotVen = 0 Then
              cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
            Else
              cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCom/fltTotVen) * 100;

            cdsRelat.Post;
          end
          else
          begin
            intRecNo := cdsRelat.RecNo;
            // recálculo de margem para o plano de conta do config CFG_COMRCX
            fltTotCus := 0;
            if cdsRelat.Locate('REL_CODCAM;REL_DESCAM', VarArrayOf(['CTADET', '    ' + fFormataConta(fCfgSis('COMRCX')) + '-' + fCampoTabela('CTA_DESCTA', 'CADCTA', ['CTA_CODCTA'], [fCfgSis('COMRCX')])]), []) then
            begin
              for intCont := 1 to slsEmpresas.Count do
                fltTotCus := fltTotCus + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
              cdsRelat.Edit;
              if fltTotVen = 0 then
                cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
              else
                cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;
              cdsRelat.Post;
            end;
            // recálculo de margem da conta de resultado associada
            fltTotCus := 0;
            if cdsRelat.Locate('REL_CODCAM;REL_DESCAM', VarArrayOf(['CTARES', fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')]) + '-' + fCampoTabela('CRE_DESCRE', 'CTAGER', ['CRE_CODCRE'], [fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')])])]), []) then
            begin
              for intCont := 1 to slsEmpresas.Count do
                fltTotCus := fltTotCus + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
              cdsRelat.Edit;
              if fltTotVen = 0 then
                cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
              else
                cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;
              cdsRelat.Post;
            end;
            cdsRelat.RecNo := intRecNo;
          end;
        Finally
          FreeAndNil(qryComissao);
        End;
      End;

      pIniciaInsercao('***','');
      cdsRelat.Post;

      fltTotCus := 0;
      pIniciaInsercao('CTARES','(-)TOTAIS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaRes.Filtered := False;
        cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaRes.Filtered := True;

        If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat :=  0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value + arrTotCom[intCont-1];
          fltTotCus := fltTotCus + TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;
        End;
      End;

      pIniciaInsercao('CTAEMP%','TOTAIS EMP%');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaRes.Filtered := False;
        cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaRes.Filtered := True;

        cdsFaturamento.Filtered := False;
        cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsFaturamento.Filtered := True;

        If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat :=  0
        Else
        Begin
          If Not TAggregateField(cdsCtaRes.FieldByName('RESTOT')).isNull Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (((TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value + arrTotCom[intCont-1]) / TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value)) * 100
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.00;
        End;
      End;

      pIniciaInsercao('CTARTO%','TOTAL GERAL%');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaRes.Filtered := False;
        cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaRes.Filtered := True;

        If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat :=  0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := ((TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value + arrTotCom[intCont-1]) / fltTotven) * 100;
          fltTotCus := fltTotCus ;
        End;
      End;

      If fltTotVen = 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;

      cdsRelat.Post;

      pIniciaInsercao('***','');
      cdsRelat.Post;
    End;

    cdsCtaAux.Filter := '';
    cdsCtaAux.Data := cdsRelat.Data;

    pIniciaInsercao('RESLIQ','RESULTADO OPERACIONAL');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('VENBRU');
      cdsCtaAux.Filtered := True;

      cdsCtaRes.Filtered := False;
      cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCtaRes.Filtered := True;

      If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
        fltTotCta := 0
      Else
        fltTotCta := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value + arrTotCom[intCont-1];

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat - fltTotCta;
    End;
    cdsRelat.Post;

    cdsCtaAux.Filter := '';
    cdsCtaAux.Data := cdsRelat.Data;
    fltGerVen := 0;
    fltGerCus := 0;

    pCarregaJurosDescontos;
    pCarregaJurosDescontosAgrupamento;

    pIniciaInsercao('MARLIQ','MARGEM OPERACIONAL');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      fltTotCus := 0;
      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('RESLIQ');
      cdsCtaAux.Filtered := True;
      If Not cdsCtaAux.IsEmpty Then fltTotCus := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

      cdsJurDes.Filtered := False;
      cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsJurDes.Filtered := True;

      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      cdsCta124.Filtered := False;
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCta124.Filtered := True;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        fltTotVen := 0
      Else
        fltTotVen := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value <> Null Then
        fltTotVen := fltTotVen - TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

      pCarregaValoresImpostos(slsEmpresas[intCont-1]);

      fltTotVen := fltTotVen - fltTotPis -
                               fltTotCof -
                               fltTotIcm +
                               fltTotIpi +
                               fltTotRet +
                               fltTotFre +
                               fltTotJur -
                               fltTotDes -
                               fltTotASN -
                               fltTotAIr -
                               fltTotACs;

      fltGerVen := fltGerVen + fltTotVen;
      fltGerCus := fltGerCus + fltTotCus;

      If (fltTotVen) = 0 Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := ((fltTotCus/(fltTotVen)) * 100);

    End;

    If fltGerVen = 0 Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltGerCus/fltGerVen)*100;
    cdsRelat.Post;

    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('4');
    cdsCta124.Filtered := True;

    {****************************************}
    {* CONTAS TIPO 4                        *}
    {*************************************AF*}
    If Not cdsCta124.IsEmpty Then
    Begin
      strCta := '';
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsCta124.Data;
      cdsCtaAux.IndexFieldNames := 'CTP_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 4';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin

        If strCta = cdsCtaAux.FieldByName('CTP_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP4','(-)' + cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTP_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;
          cdsCta124.Filter   := 'CTP_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTP_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('4') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsCta124.Filtered := True;
          If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;
        End;
        cdsRelat.Post;

        cdsCtaAux.Next;
      End;
    End;
    cdsCtaAux.IndexFieldNames := '';

    {****************************************}
    {* JUROS E DESCONTOS                    *}
    {*************************************AF*}
    If fVerificaSeImpSessao(caJurosDespesasFinanceiras) Then
    Begin
      pIniciaInsercao('RECJUR','JUROS RECEBIDOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caJurosDespesasFinanceiras, slsEmpresas[intCont-1]) Then
        Begin
          cdsJurDes.Filtered := False;
          cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJurDes.Filtered := True;

          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJurDes.FieldByName('VALJUR').AsFloat;
        End;
      End;

      cdsRelat.Post;
    End;

    If fVerificaSeImpSessao(caDescontoDespesasFinanceiras) Then
    Begin
      pIniciaInsercao('CONDES','DESCONTOS CONCEDIDOS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        If fConfiguracaoRegTriAtiva(caDescontoDespesasFinanceiras, slsEmpresas[intCont-1]) Then
        Begin
          cdsJurDes.Filtered := False;
          cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsJurDes.Filtered := True;

          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsJurDes.FieldByName('VALDES').AsFloat;
        End;
      End;

      cdsRelat.Post;
    End;

    {****************************************}
    {* BANDA DE LUCRO REAL                  *}
    {*************************************AF*}
    cdsCta124.Filtered := False;
    cdsCtaRes.Filtered := False;
    If (Not cdsCtaRes.IsEmpty) And (Not cdsCta124.IsEmpty) Then
    Begin
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsRelat.Data;

      {****************************************}
      {* LUCRO REAL                           *}
      {*************************************AF*}
      pIniciaInsercao('LUCREA','LUCRO LÍQUIDO');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltVenBru := 0;
        fltTotCta := 0;

        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('RESLIQ');
        cdsCtaAux.Filtered := True;

        If Not cdsCtaAux.IsEmpty Then
          fltVenBru := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter := '';
        cdsCtaAux.Active := False;
        cdsCtaAux.Active := True;

        cdsJurDes.Filtered := False;
        cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsJurDes.Filtered := True;

        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('CTATP4');
        cdsCtaAux.Filtered := True;

        If Not cdsCtaAux.IsEmpty Then
        Begin
          While Not cdsCtaAux.Eof Do
          Begin
            fltTotCta := fltTotCta + cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
            cdsCtaAux.Next;
          End;
        End;

        fltTotJurFin := 0;
        fltTotDesFin := 0;

        If fConfiguracaoRegTriAtiva(caJurosDespesasFinanceiras, slsEmpresas[intCont-1]) Then
          fltTotJurFin := cdsJurDes.FieldByName('VALJUR').AsFloat;

        If fConfiguracaoRegTriAtiva(caDescontoDespesasFinanceiras, slsEmpresas[intCont-1]) Then
          fltTotDesFin := cdsJurDes.FieldByName('VALDES').AsFloat;

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenBru -
                                                                          fltTotCta +
                                                                          fltTotJurFin -
                                                                          fltTotDesFin;
      End;
      cdsRelat.Post;

      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsRelat.Data;
      {****************************************}
      {* % REAL                               *}
      {*************************************AF*}
      fltGerVen := 0;
      fltGerCus := 0;
      pIniciaInsercao('PERREA','MARGEM LÍQUIDA');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltVenBru := 0;
        fltTotVen := 0;

        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('LUCREA');
        cdsCtaAux.Filtered := True;

        If Not cdsCtaAux.IsEmpty Then
          fltVenBru := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

        cdsCta124.Filtered := False;
        cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCta124.Filtered := True;

        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter := '';
        cdsCtaAux.Active := False;
        cdsCtaAux.Active := True;

        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('VENLIQ');
        cdsCtaAux.Filtered := True;
        If Not cdsCtaAux.IsEmpty Then
        Begin
          While Not cdsCtaAux.Eof Do
          Begin
            fltTotVen := fltTotVen + cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
            cdsCtaAux.Next;
          End;
        End
        Else
        Begin
          cdsCtaAux.Filtered := False;
          cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('TOTVEN');
          cdsCtaAux.Filtered := True;
          fltTotVen := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat
        End;

        fltGerVen := fltGerVen + fltTotVen;
        fltGerCus := fltGerCus + fltVenBru;

        If fFormataFLoat(fltTotVen, 2) = 0 Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (fltVenBru/(fltTotVen)) * 100;

      End;

      If fltGerVen = 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltGerCus/fltGerVen)*100;
      cdsRelat.Post;
    End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA CONTAS A PAGAR               *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaCtaPag;
  Var
    strSQL,
    strSQLJurosDesc,
    strFilDta,
    strFil: String;
    dtaFin: TDateTime;
    fltTestaCTPDOU,
    fltTotDup: Double;
    strWhere,
    strWhereJurosDesc: String;
    intCont: integer;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 3;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CONTAS A PAGAR';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistro(strChave, strDescri, strFiltro: String; blnCalcPer: Boolean);
    Var
      intCont: Integer;
      fltValDup: Double;
  Begin
    pIniciaInsercao(strChave, strDescri);
    fltValDup := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaPag.Filtered := False;
      cdsCtaPag.Filter   := strFiltro + 'CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCtaPag.Filtered := True;

      If (strChave = 'CTPJUR') Then
      Begin
        If cdsCtaPag.IsEmpty Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.00
        Else
        Begin
          While Not cdsCtaPag.Eof Do
          Begin
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat + cdsCtaPag.FieldByName('CTP_VALJUR').AsFloat;
            cdsCtaPag.Next;
          End;
          cdsCtaPag.First;
        End;
      End
      Else If (Pos(strChave, 'CTPDDE_CTPDBO_CTPDOU_CTPDTO_') > 0) Then
      Begin
        If cdsCtaPag.IsEmpty Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.00
        Else
        Begin
          While Not cdsCtaPag.Eof Do
          Begin
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat + cdsCtaPag.FieldByName('CTP_VALDES').AsFloat;
            cdsCtaPag.Next;
          End;
          cdsCtaPag.First;
        End;
      End
      Else
      Begin
        If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;
          fltValDup := fltValDup + TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;
        End;
      End;
    End;

    If blnCalcPer Then
    Begin
      If fltTotDup > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValDup/fltTotDup) * 100
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;
    End;

    cdsRelat.Post;
  End;

begin
  Try
    dtaFin := StrToDate(fRetDtaFin());

    strSQLJurosDesc := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  P.CTP_DTACAD, ';
    strSQL := strSQL + '  P.CTP_DTAVEN, ';
    strSQL := strSQL + '  P.CTP_DTAPAG, ';
    strSQL := strSQL + '  P.CTP_PREVIS, ';
    strSQL := strSQL + '  P.CTP_NUMDUP, ';
    strSQL := strSQL + '  P.CTP_PARCEL, ';
    strSQL := strSQL + '  P.CTP_HIST01, ';
    strSQL := strSQL + '  P.CTP_HIST02, ';
    strSQL := strSQL + '  P.CTP_PREVIS, ';
    strSQL := strSQL + '  SUM(P.CTP_VALJUR) AS CTP_VALJUR, ';
    strSQL := strSQL + '  P.CTP_TIPDES, ';
    strSQL := strSQL + '  SUM(P.CTP_VALDES) AS CTP_VALDES, ';

    If blnRegimeDefinidoNoPlanoDeContas Then
      strSQL := strSQL + '  IF(IFNULL(CTA_REGDRE,1) = 2, P.CTP_DTACAD, P.CTP_DTAPAG) AS DTA_REGDRE, ';

    If chkListaDesmembramento.Checked Then
    begin
      strSQL := strSQL + '  IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CTP_CODEMP, ';
      strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) AS CTP_CODCTA, ';
      strSQL := strSQL + '  SUM(IF(CTP_DTAPAG IS NULL, ';
      strSQL := strSQL + '      ((IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_VALDUP, 0), ROUND(COALESCE(P.CTP_VALDUP, 0)*D.CTP_FATCAL,2))) - ';
      strSQL := strSQL + '       (IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_DESSUJ, 0), ROUND(COALESCE(P.CTP_DESSUJ, 0)*D.CTP_FATCAL,2))) + ';
      strSQL := strSQL + '       (IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_JURSUJ, 0), ROUND(COALESCE(P.CTP_JURSUJ, 0)*D.CTP_FATCAL,2))) + ';
      strSQL := strSQL + '       (IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_VENDOR, 0), ROUND(COALESCE(P.CTP_VENDOR, 0)*D.CTP_FATCAL,2)))),  ';
      strSQL := strSQL + '      ((IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_VALPAG, 0), ROUND(COALESCE(P.CTP_VALPAG, 0)*D.CTP_FATCAL,2))) - ';
      strSQL := strSQL + '       (IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_VALJUR, 0), ROUND(COALESCE(P.CTP_VALJUR, 0)*D.CTP_FATCAL,2))) + ';
      strSQL := strSQL + '       (IF(D.CTP_FATCAL IS NULL, COALESCE(P.CTP_VALDES, 0), ROUND(COALESCE(P.CTP_VALDES, 0)*D.CTP_FATCAL,2)))))) AS CTP_VALDUP ';
    end
    else
    begin
      strSQL := strSQL + '  P.CTP_CODCTA, ';
      strSQL := strSQL + '  P.CTP_CODEMP, ';
      strSQL := strSQL + '  SUM(IF(CTP_DTAPAG IS NULL, (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_VENDOR,0)), (CTP_VALPAG - IFNULL(CTP_VALJUR,0) + IFNULL(CTP_VALDES,0)))) AS CTP_VALDUP ';
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';

    If blnRegimeDefinidoNoPlanoDeContas Then
      strSQL := strSQL + '  LEFT JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';

    If chkListaDesmembramento.Checked Then
    Begin
      strSQL := strSQL + '  LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
      strSQL := strSQL + '                        P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
      strSQL := strSQL + '                        ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
      strSQL := strSQL + '                        (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
    end;

    strSQL          := strSQL + 'WHERE ';
    strSQLJurosDesc := strSQL;

    strWhere          := fComplementoWhereSQLPosContabilPagar(Nil, Nil, False, Nil, Nil, fEmpSelecionadas, False);
    strWhereJurosDesc := fComplementoWhereSQLPosContabilPagar(Nil, Nil, False, Nil, Nil, fEmpSelecionadas, True);

    If chkListaDesmembramento.Checked Then
    Begin
      strWhere          := StringReplace(strWhere, 'CTP_CODEMP', 'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', [rfReplaceAll]);
      strWhereJurosDesc := StringReplace(strWhereJurosDesc, 'CTP_CODEMP', 'IF(D.CTP_CODEMP IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', [rfReplaceAll]);
    End;

    if not blnIncDupCliForFil then
      strWhere := strWhere + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    strSQL          := strSQL + strWhere + ' GROUP BY CTP_DTAVEN, CTP_DTAPAG, CTP_PREVIS, CTP_CODEMP, CTP_CODCTA ';
    strSQLJurosDesc := strSQLJurosDesc + strWhereJurosDesc + ' GROUP BY CTP_DTACAD, CTP_DTAPAG, CTP_TIPDES, CTP_CODEMP, CTP_CODCTA, CTP_VALJUR, CTP_VALDES ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      cdsCtaPag.Close;
      cdsCtaPag.SetProvider(cpvCtaPag);
      cpvCtaPag.DataSet := qryGenerica;
      cdsCtaPag.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'CTP_TOTDUP';
        FieldName     := 'CTP_TOTDUP';
        DataSet       := cdsCtaPag;
        Expression    := 'SUM(CTP_VALDUP)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsCtaPag.Open;
    End;

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter   := 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin));
    cdsCtaPag.Filtered := True;

    If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;

    strFil := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 30)) + ' AND ' +
              'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTPV30','DOC.VENC.ÚLT. 30 DIAS',strFil, True);

    strFil := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 180)) + ' AND ' +
              'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 31)) + ' AND ';

    pInsereRegistro('CTPM30','DOC.VENC. ENTRE 31 E 180 DIAS',strFil, True);

    strFil := 'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 360)) + ' AND ' +
              'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 181)) + ' AND ';

    pInsereRegistro('CTPM180','DOC.VENC. ENTRE 181 E 360 DIAS',strFil, True);

    strFil := 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 361)) + ' AND ';

    pInsereRegistro('CTPM360','DOC.VENC. MAIOR 360 DIAS',strFil, True);

    cdsCtaPag.Filter   := '';
    cdsCtaPag.Filtered := False;

    If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;

    strFil := 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTPVEN','TOTAL DE DOCUM. VENCIDOS',strFil, True);

    strFil := 'CTP_DTAVEN > ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTPAVE','TOTAL DE DOCUM. A VENCER',strFil, True);

    strFil := '';

    pInsereRegistro('CTPGER','TOTAL GERAL',strFil,False);

    pIniciaInsercao('***','');

    strFil := 'CTP_PREVIS = ' + QuotedStr('S') + ' AND ';

    pInsereRegistro('CTPPRV','DOCUM. COM PREVISAO',strFil,False);

    strFil := 'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin + 30)) + ' AND ' +
              'CTP_PREVIS = ' + QuotedStr('S') + ' AND ';

    pInsereRegistro('CTPPRVV30','    DOC.VENC.ATE 30 DIAS',strFil,False);

    strFil := 'CTP_DTAVEN > ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin + 30)) + ' AND ' +
              'CTP_PREVIS = ' + QuotedStr('S') + ' AND ';

    pInsereRegistro('CTPPRVM30','    DOC.VENC.MAIOR 30 DIAS',strFil,False);

    strFil := 'CTP_PREVIS = ' + QuotedStr('N') + ' AND ';

    pInsereRegistro('CTPSPR','DOCUM. SEM PREVISAO',strFil,False);

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {*****************************************************************}
    { RECONSTRUÇÃO DA QUERY POR CONSIDERAR DATA DE PAGAMENTO DEFINIDA }
    {*****************************************************************}
    With qryGenericaJurosEDescontos Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLJurosDesc);
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;

      cdsCtaPag.Close;
      cdsCtaPag.SetProvider(cpvCtaPag);
      cpvCtaPag.DataSet := qryGenericaJurosEDescontos;
      cdsCtaPag.AggregatesActive := True;
      cdsCtaPag.Open;

    End;

    If blnRegimeDefinidoNoPlanoDeContas Then
      strFilDta := 'DTA_REGDRE'
    Else
    Begin
      If (rdgTipDta.ItemIndex = 0) Then
        strFilDta := 'CTP_DTAPAG'
      Else
        strFilDta := 'CTP_DTACAD';
    End;

    strFil := strFilDta + ' >= ' + QuotedStr(fRetDtaIni) + ' AND ' +
              strFilDta + ' <= ' + QuotedStr(fRetDtaFin) + ' AND ' +
              'CTP_VALJUR   <> 0 AND ';
    pInsereRegistro('CTPJUR','(*) JUROS PAGOS',strFil,False);

    strFil := strFilDta + ' >= ' + QuotedStr(fRetDtaIni) + ' AND ' +
              strFilDta + ' <= ' + QuotedStr(fRetDtaFin) + ' AND ' +
              'CTP_TIPDES    = ' + QuotedStr('D') + ' AND ' +
              'CTP_VALDES   <> 0 AND ';
    pInsereRegistro('CTPDDE','    DESCONTOS OBTIDOS POR DEVOLUÇÃO',strFil,False);

    strFil := strFilDta + ' >= ' + QuotedStr(fRetDtaIni) + ' AND ' +
              strFilDta + ' <= ' + QuotedStr(fRetDtaFin) + ' AND ' +
              'CTP_TIPDES    = ' + QuotedStr('B') + ' AND ' +
              'CTP_VALDES   <> 0 AND ';
    pInsereRegistro('CTPDBO','    DESCONTOS OBTIDOS POR BONIFICAÇÃO',strFil,False);

    strFil := strFilDta + ' >= ' + QuotedStr(fRetDtaIni) + ' AND ' +
              strFilDta + ' <= ' + QuotedStr(fRetDtaFin) + ' AND ' +
              'CTP_TIPDES    = ' + QuotedStr('O') + ' AND ' +
              'CTP_VALDES   <> 0 AND ';
    pInsereRegistro('CTPDOU','    DESCONTOS OBTIDOS POR OUTROS MOTIVOS',strFil,False);

    strFil := strFilDta + ' >= ' + QuotedStr(fRetDtaIni) + ' AND ' +
              strFilDta + ' <= ' + QuotedStr(fRetDtaFin) + ' AND ' +
              'CTP_VALDES   <> 0 AND ';
    pInsereRegistro('CTPDTO','(*) TOTAL DESCONTOS OBTIDOS',strFil,False);

    {************************************************************************}
    { VERIFICA SE "DESCONTOS OBTIDOS POR OUTROS MOTIVOS" É TOTALMENTE ZERADO }
    { NESSE CASO, OCULTA ESSA LINHA DO RELATÓRIO                             }
    {*********************************************************************CH*}
     fltTestaCTPDOU := 0;
     cdsRelat.First;
     While Not cdsRelat.Eof Do
     Begin
       If cdsRelat.FieldByName('REL_CODCAM').asString = 'CTPDOU' Then
       Begin
         For intCont := 1 To slsEmpresas.Count Do
           fltTestaCTPDOU := fltTestaCTPDOU + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
         If (fltTestaCTPDOU=0) Then
           cdsRelat.Delete;
       End;
       cdsRelat.Next;
     End;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;
end;

{****************************************}
{* CARREGA CONTAS A RECEBER             *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaCtaRec;
  Var
    strSQL: String;
    strFil: String;
    strPorOpe: String;
    dtaFin: TDateTime;
    fltTotDup: Double;
    blnDacPor: Boolean;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 4;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CONTAS A RECEBER';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistro(strChave, strDescri, strFiltro: String; blnCalcPer: Boolean);
    Var
      intCont: Integer;
      fltValDup: Double;
  Begin
    pIniciaInsercao(strChave, strDescri);
    fltValDup := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaRec.Filtered := False;
      cdsCtaRec.Filter   := strFiltro + 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCtaRec.Filtered := True;

      If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
      Begin
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;
        fltValDup := fltValDup + TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;
      End;
    End;

    If blnCalcPer Then
    Begin
      If fltTotDup > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValDup/fltTotDup) * 100
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;
    End;

    cdsRelat.Post;
  End;

  function fSQLFiltroEmpresa: String;
  begin
    Result := '';
    If (rdgEmpresa.ItemIndex = 0) Then
    Begin
      Result := ' CTR_CODEMP ';
    End
    Else
    Begin
      Result := ' IF(IFNULL(CTR_EMP_PD, "") <> "", IFNULL(CTR_EMP_PD, ""), CTR_CODEMP) ';
    End;
  end;

begin

  Try
    dtaFin := StrToDate(fRetDtaFin());

    blnDacPor := fCfgSis('DACPOR', varBoolean);
    strPorOpe := fRetPortadoresOperador(strLoginUsuarioLogado);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  ' + fSQLFiltroEmpresa + ' AS CTR_CODEMP, ';
    strSQL := strSQL + '  IF(CTR_DTAREC IS NULL, (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0)), (CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))) AS CTR_VALDUP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + fComplementoWhereSQLPosContabilReceber(fEmpSelecionadas, rdgEmpresa.ItemIndex = 1);

    if not blnIncDupCliForFil then
      strSQL := strSQL + ' AND CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

    if blnDacPor then
      strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPorOpe) + ') > 0 ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(fEmpSelecionadas) Then
        ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      cdsCtaRec.Close;
      cdsCtaRec.SetProvider(cpvCtaRec);
      cpvCtaRec.DataSet := qryGenerica;
      cdsCtaRec.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'CTR_TOTDUP';
        FieldName     := 'CTR_TOTDUP';
        DataSet       := cdsCtaRec;
        Expression    := 'SUM(CTR_VALDUP)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsCtaRec.Open;
    End;

    cdsCtaRec.Filtered := False;
    cdsCtaRec.Filter := 'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin));
    cdsCtaRec.Filtered := True;

    If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;

    strFil := 'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 30)) + ' AND ' +
              'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTRV30','DOC.VENC.ÚLT. 30 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 180)) + ' AND ' +
              'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 31)) + ' AND ';

    pInsereRegistro('CTRM30','DOC.VENC. ENTRE 31 E 180 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 360)) + ' AND ' +
              'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 181)) + ' AND ';

    pInsereRegistro('CTRM180','DOC.VENC. ENTRE 181 E 360 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 361)) + ' AND ';

    pInsereRegistro('CTRM360','DOC.VENC. MAIOR 360 DIAS',strFil,True);

    cdsCtaRec.Filter := '';
    cdsCtaRec.Filtered := False;

    If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;

    strFil := 'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTRVEN','TOTAL DE DOCUM. VENCIDOS',strFil,True);

    strFil := 'CTR_DTAVEN > ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CTRAVE','TOTAL DE DOCUM. A VENCER',strFil,True);

    strFil := '';

    pInsereRegistro('CTRGER','TOTAL GERAL',strFil,False);

  Except

    On E: Exception Do
      Exception.Create(E.Message);

  End;

end;

{****************************************}
{* TOTAL DE CARTOES                     *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaMovCar;
  Var
    strSQL: String;
    strFil: String;
    dtaFin: TDateTime;
    fltTotCar: Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 5;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CARTAO';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistro(strChave, strDescri, strFiltro: String; blnCalcPer: Boolean);
    Var
      intCont: Integer;
      fltValCar: Double;
  Begin
    pIniciaInsercao(strChave, strDescri);
    fltValCar := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsMovCar.Filtered := False;
      cdsMovCar.Filter   := strFiltro + 'MCA_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsMovCar.Filtered := True;

      If TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
      Begin
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value;
        fltValCar := fltValCar + TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value;
      End;
    End;

    If blnCalcPer Then
    Begin
      If fltTotCar > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValCar/fltTotCar) * 100
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;
    End;

    cdsRelat.Post;
  End;

begin

  Try

    dtaFin := StrToDate(fRetDtaFin());

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MCA_CODEMP, ';
    strSQL := strSQL + '  MCA_DTAVEN, ';
    strSQL := strSQL + '  SUM(MCA_VALSTA) AS MCA_VALDUP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR ';
    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + fComplementoWhereSQLPosContabilCartao(Nil, Nil, fEmpSelecionadas);

    strSQL := strSQL + ' GROUP BY MCA_DTAVEN, MCA_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(fEmpSelecionadas) Then
        ParamByName('CODEMP').AsString   := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      cdsMovCar.Close;
      cdsMovCar.SetProvider(cpvMovCar);
      cpvMovCar.DataSet := qryGenerica;
      cdsMovCar.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'MCA_TOTDUP';
        FieldName     := 'MCA_TOTDUP';
        DataSet       := cdsMovCar;
        Expression    := 'SUM(MCA_VALDUP)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsMovCar.Open;
      cdsMovCar.Filter := '';
      cdsMovCar.Filtered := False;
    End;

    If TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value = Null Then
      fltTotCar := 0
    Else
      fltTotCar := TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value;

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 30)) + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CARAVE','DOC.VENC.ÚLT. 30 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 180)) + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 31)) + ' AND ';

    pInsereRegistro('CARAVE','DOC.VENC. ENTRE 31 E 180 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 360)) + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 181)) + ' AND ';

    pInsereRegistro('CARAVE','DOC.VENC. ENTRE 181 E 360 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 361)) + ' AND ';

    pInsereRegistro('CARAVE','DOC.VENC. MAIOR 360 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CARVEN','TOTAL DE DOCUM VENCIDOS',strFil,True);

    strFil := 'MCA_DTAVEN > ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CARAVE','TOTAL DE DOCUM A VENCER',strFil,True);

    strFil := '';

    pInsereRegistro('CARGER','TOTAL GERAL',strFil,False);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA CHEQUES                      *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaCadChq;
  Var
    strSQL : String;
    strFil: String;
    dtaFin: TDateTime;
    fltTotChq: Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 6;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CHEQUES';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistro(strChave, strDescri, strFiltro: String; blnCalcPer: Boolean);
    Var
      intCont: Integer;
      fltValChq: Double;
  Begin
    pIniciaInsercao(strChave, strDescri);
    fltValChq := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCadChq.Filtered := False;
      cdsCadChq.Filter   := strFiltro + 'CHQ_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCadChq.Filtered := True;

      If TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
      Begin
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value;
        fltValChq := fltValChq + TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value;
      End;
    End;

    If blnCalcPer Then
    Begin
      If fltTotChq > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValChq/fltTotChq) * 100
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;
    End;

    cdsRelat.Post;
  End;

begin

  Try

    dtaFin := StrToDate(fRetDtaFin());

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CHQ_CODEMP, ';
    strSQL := strSQL + '  CHQ_DTAVEN,  ';
    strSQL := strSQL + '  CHQ_VALCHQ  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fComplementoWhereSQLPosContabilCheque(fEmpSelecionadas);
    strSQL := strSQL + ' AND (IFNULL(CHQ_INCCTR, "N") = "N") ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(fEmpSelecionadas) Then
        ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := VS_DateFim;

      cdsCadChq.Close;
      cdsCadChq.SetProvider(cpvCadChq);
      cpvCadChq.DataSet := qryGenerica;
      cdsCadChq.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'CHQ_TOTCHQ';
        FieldName     := 'CHQ_TOTCHQ';
        DataSet       := cdsCadChq;
        Expression    := 'SUM(CHQ_VALCHQ)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsCadChq.Open;
      cdsCadChq.Filter := '';
      cdsCadChq.Filtered := False;
    End;

    If TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value = Null Then
      fltTotChq := 0
    Else
      fltTotChq := TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value;

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 30)) + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CHQGER','CHE. VENC. ÚLT. 30 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 180)) + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 31)) + ' AND ';

    pInsereRegistro('CHQGER','CHE. VENC. ENTRE 31 E 180 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 360)) + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 181)) + ' AND ';

    pInsereRegistro('CHQGER','CHE. VENC. ENTRE 181 E 360 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin - 361)) + ' AND ';

    pInsereRegistro('CHQGER','CHE. VENC. MAIOR 360 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CHQGER','TOTAL DE CHEQUES VENCIDOS',strFil,True);

    strFil := 'CHQ_DTAVEN > ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ';

    pInsereRegistro('CHQGER','TOTAL DE CHEQUES A VENCER',strFil,True);

    strFil := '';

    pInsereRegistro('CHQGER','TOTAL GERAL',strFil,False);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA TRANSFERENCIA DE ESTOQUE     *}
{*************************************AF*}
  procedure TfrmRelEstatAnalResult2.pCarregaTransf;
  Var
    strSQL : String;
    intCont: Integer;
    fltTotTrans,
    fltCusTrans: Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 7;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'TRANSFERENCIA DE ESTOQUE';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  GER_VLRCON,  ';
    strSQL := strSQL + '  GER_TOTCUS  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  GER_CODEMP IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  GER_CODCLI IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  GER_CODCLI NOT IN (SELECT IFNULL(EMP_CLIFIL, "") AS EMP_CLIFIL FROM CADEMP WHERE CADEMP.EMP_CODEMP = MOVGER.GER_CODEMP) AND ';
    strSQL := strSQL + '  ((GER_ESPDOC = "TE") OR ((GER_ESPDOC IN ("NF", "EL")) AND ((RIGHT(GER_CLAFIS, 3) IN ("152", "409")) OR (LOCATE(GER_CLAFIS, :CLAFIS) > 0)))) ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
      ParamByName('CLAFIS').AsString := VS_strClaVen;

      cdsTransf.Close;
      cdsTransf.SetProvider(cpvTransf);
      cpvTransf.DataSet := qryGenerica;
      cdsTransf.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'GER_TOTCON';
        FieldName     := 'GER_TOTCON';
        DataSet       := cdsTransf;
        Expression    := 'SUM(GER_VLRCON)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsTransf.Open;
    End;

    pIniciaInsercao('TRANSF','TOTAL TRANSF. DE ESTOQUE');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsTransf.Filtered := False;
      cdsTransf.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsTransf.Filtered := True;
      If TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value;
    End;
    cdsRelat.Post;

    If chkTrMarCus.Checked Then
    Begin
      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
        ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
        ParamByName('CLAFIS').AsString := VS_strClaVen;

        cdsTransfCus.Close;
        cdsTransfCus.SetProvider(cpvTransfCus);
        cpvTransfCus.DataSet := qryGenerica;
        cdsTransfCus.AggregatesActive := True;

        {****************************************}
        {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
        {*************************************AF*}
        SetLength(arrSomatorias,Length(arrSomatorias) + 1);
        arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

        With arrSomatorias[Length(arrSomatorias) -1] Do
        Begin
          Name          := 'GER_VLRCUS';
          FieldName     := 'GER_VLRCUS';
          DataSet       := cdsTransfCus;
          Expression    := 'SUM(GER_TOTCUS)';
          DisplayFormat := '#,##0.00';
          Active        := True;
        End;

        cdsTransfCus.Open;
      End;

      pIniciaInsercao('TRANSF','TOTAL TRANSF. À PR.CUSTO');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsTransfCus.Filtered := False;
        cdsTransfCus.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsTransfCus.Filtered := True;
        If TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value;
      End;
      cdsRelat.Post;

      pIniciaInsercao('TRANSF','RESULTADO');

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsTransf.Filtered := False;
        cdsTransf.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsTransf.Filtered := True;

        cdsTransfCus.Filtered := False;
        cdsTransfCus.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsTransfCus.Filtered := True;

        If ((TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = Null) Or (TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = 0))  Then
           cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
            If ((TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = Null) Or (TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = 0)) Then
               cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
            Else
               cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value -
                                                                                 TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value;
      End;
      cdsRelat.Post;

      pIniciaInsercao('TRANSF','MARGEM');

      fltTotTrans := 0;
      fltCusTrans := 0;

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsTransf.Filtered := False;
        cdsTransf.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsTransf.Filtered := True;

        cdsTransfCus.Filtered := False;
        cdsTransfCus.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsTransfCus.Filtered := True;

        If ((TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = Null) Or (TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = 0))  Then
           cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
            If ((TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = Null) Or (TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = 0)) Then
               cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
            Else
               cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (1 - (TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value /
                                                                                       TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value )) * 100;

        If Not((TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value = Null)) Then
           fltTotTrans := fltTotTrans +  TAggregateField(cdsTransf.FieldByName('GER_TOTCON')).Value;

        If Not((TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value = Null))  Then
           fltCusTrans := fltCusTrans + TAggregateField(cdsTransfCus.FieldByName('GER_VLRCUS')).Value;

        If (fltTotTrans = 0) Or (fltCusTrans = 0) Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := (1- (fltCusTrans / fltTotTrans)) * 100;

      End;
      cdsRelat.Post;

    End;
  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaUsoCon;
  Var
    strSQL : String;
    intCont: Integer;
    strCLA_UC: String;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 14;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'USO/CONSUMO DE MATERIAIS';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin

  Try

    strCLA_UC := fCfgSis('CLA_UC', varString);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  GER_VLRCON  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  GER_CODEMP IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  GER_CODCLI IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  (GER_ESPDOC IN ("UC") OR ';
    strSQL := strSQL + '   (GER_ESPDOC IN("NF","EL") AND RIGHT(GER_CLAFIS,3) IN (' + strCLA_UC + '))) ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

      cdsUsoCon.Close;
      cdsUsoCon.SetProvider(cpvUsoCon);
      cpvUsoCon.DataSet := qryGenerica;
      cdsUsoCon.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'GER_TOTUSO';
        FieldName     := 'GER_TOTUSO';
        DataSet       := cdsUsoCon;
        Expression    := 'SUM(GER_VLRCON)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsUsoCon.Open;
    End;

    pIniciaInsercao('USOCON','TOTAL USO/CONSUMO MATERIAIS');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsUsoCon.Filtered := False;
      cdsUsoCon.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsUsoCon.Filtered := True;
      If TAggregateField(cdsUsoCon.FieldByName('GER_TOTUSO')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsUsoCon.FieldByName('GER_TOTUSO')).Value;
    End;
    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;
end;

{****************************************}
{* CARREGA BONIFICAÇÃO                  *}
{***********************18/06/09**** AM *}
procedure TfrmRelEstatAnalResult2.pCarregaBonifi(blnSaida : Boolean);
  Var
    strSQL : String;
    intCont: Integer;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 8;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'BRINDES / BONIFICAÇÕES';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DET_CODEMP AS GER_CODEMP, ';
    strSQL := strSQL + '  SUM(DET_TOTITE) AS GER_VLRCON  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  DET_CODEMP IN (' + fEmpSelecionadas(True) + ') AND ';
    If (blnSaida) Then
    Begin
      strSQL := strSQL + '  ((DET_ESPDOC = "BR") ';
      strSQL := strSQL + '    OR ';
      strSQL := strSQL + '   (LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') AND (DET_ESPDOC = "NF" OR DET_ESPDOC = "EL"))) ';
    End
    Else
    Begin
      strSQL := strSQL + '  LOCATE(DET_CLAFIS,' + CLAFIS_BR_ENT + ') ';
    End;

    strSQL := strSQL + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

      cdsBonifi.Close;
      cdsBonifi.SetProvider(cpvBonifi);
      cpvBonifi.DataSet := qryGenerica;
      cdsBonifi.AggregatesActive := True;

      qryGenerica.Filter := '';
      qryGenerica.Open;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      If (blnSaida) Then
      Begin

        SetLength(arrSomatorias,Length(arrSomatorias) + 1);
        arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

        With arrSomatorias[Length(arrSomatorias) -1] Do
        Begin
          Name          := 'GER_TOTBON';
          FieldName     := 'GER_TOTBON';
          DataSet       := cdsBonifi;
          Expression    := 'SUM(GER_VLRCON)';
          DisplayFormat := '#,##0.00';
          Active        := True;
        End;

      End;

      cdsBonifi.Open;
    End;

    If (strTipImp = 'M') Then
      pIniciaInsercao('BONIFI','TOTAL DE ' + IfThen(blnSaida,'SAÍDA','ENTRADA'))
    Else
      pIniciaInsercao('BONIFI','TOTAL BRINDES / BONIFICAÇÕES DE ' + IfThen(blnSaida,'SAÍDA','ENTRADA'));

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsBonifi.Filtered := False;
      cdsBonifi.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsBonifi.Filtered := True;
      If TAggregateField(cdsBonifi.FieldByName('GER_TOTBON')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsBonifi.FieldByName('GER_TOTBON')).Value;
    End;
    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA ESTOQUE                      *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaEstoqu;
  Var
    strSQL : String;
    strAux : String;
    intCont: Integer;
    strData: String;
    fltVari: Double;
    fltTotEst: Double;
    fltTotGen: Double;
    strCusSob: String;
    strCusTit: String;
    strSubsti: String;
    strQuanti, strValUni: String;
    intDecUni: Integer;
    strCampoPre: String;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 9;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'ESTOQUE';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin
  Try

    {CÁLCULO AJUSTADO PARA BATER COM O RELTÓRIO DE INVENTÁRIO FISÍCO - NÃO ALTRERAR}
    intDecUni := fCfgSis('DECUNI');

    strQuanti := '';
    strValUni := '';

    strCusSob := fPreInv('G', 'G', '', True, False);
    strCusTit := fPreInvTitulo;

    If (fCfgSis('PREINV') = 'ULTFED') Then
      strSubsti := strCusSob
    Else
      strSubsti := '';

    strCampoPre := fCfgSis('PREINV');

    strData := FormatDateTime('mm/yyyy', StrToDate(fRetDtaFin()));

    strQuanti := '(G.ITE_SALDOS + IF(IFNULL(I.ITE_CNV_ML, 0) > 0, IFNULL(G.ITE_SAL_ML, 0) / I.ITE_CNV_ML, 0))';

    strValUni := '( ROUND(' + fPreInv('G', '', strCampoPre, True, False) + ', ' + IntToStr(intDecUni) + ') / IF((I.ITE_FATCNV = 0) OR (I.ITE_FATCNV IS NULL), 1, I.ITE_FATCNV))';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  G.ITE_CODEMP, ';

    strSql := strSql + ' SUM(( IF(' + strValUni + ' < 0.0, 0.0, ' + strValUni + ') ) * ( IF(' + strQuanti + ' < 0.0, 0.0, ' + strQuanti + ') )) AS ITE_SALDOS ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER G ';
    strSQL := strSQL + '  LEFT JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + 'WHERE ';

    If rdgSalEst.ItemIndex = 0 Then
      strSQL := strSQL + '  ROUND(' + strQuanti + ', 2) > 0 AND ';

    strSQL := strSQL + '  G.ITE_CODEMP IN (' + fEmpSelecionadas(True) + ') ';
    strSQL := strSQL + 'GROUP BY G.ITE_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      Filter := EmptyStr;

      strAux := strSQL;
      If (MonthOf(VS_Date) <> MonthOf(StrToDate(fRetDtaFin()))) Then
      Begin
        strData := FormatDateTime('mm/yyyy', StrToDate(fRetDtaFin()));
        strData := 'I_' + RightStr(strData, 4) + LeftStr(strData, 2);

        If fTabelaExiste(strData) Then
        Begin
          strAux  := AnsiReplaceStr( strSQL, 'ITEGER', strData );
          If Not fExisteSalMLBase(strData) Then
            strAux  := AnsiReplaceStr( strAux, 'G.ITE_SAL_ML', '0' );
          If fExisteCnvMLBase(strData) Then
            strAux  := AnsiReplaceStr( strAux, 'I.ITE_CNV_ML', 'G.ITE_CNV_ML' );
          If Not fEmptyStr(strSubsti) Then
            strAux  := AnsiReplaceStr( strAux, strSubsti, 'IFNULL(G.ITE_PRECUS,0)' );
        End
        Else
        Begin
          strAux  := strSQL + ' LIMIT 0 ';
          If Not fEmptyStr(strSubsti) Then
            strAux  := AnsiReplaceStr( strAux, strSubsti, 'IFNULL(G.ITE_PRECUS,0)' );
        End;

      End;

      SQL.Add(strAux);

      cdsEstoqu.Close;
      cdsEstoqu.Filter  := EmptyStr;
      cpvEstoqu.DataSet := qryGenerica;
      cdsEstoqu.AggregatesActive := True;
      cdsEstoqu.SetProvider(cpvEstoqu);

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'ITE_TOTSAL';
        FieldName     := 'ITE_TOTSAL';
        DataSet       := cdsEstoqu;
        Expression    := 'SUM(ITE_SALDOS)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsEstoqu.Open;
    End;

    pIniciaInsercao('ESTOQU','TOT ESTOQ ' + strCusTit );
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsEstoqu.Filtered := False;
      cdsEstoqu.Filter   := 'ITE_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsEstoqu.Filtered := True;
      If TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value;
    End;
    cdsRelat.Post;

    strData := FormatDateTime('mm/yyyy', IncMonth( StrToDate(fRetDtaFin()), -1 ) );
    strData := 'I_' + RightStr(strData, 4) + LeftStr(strData, 2);
    If fTabelaExiste(strData) Then
    Begin
      strSQL  := AnsiReplaceStr( strSQL, 'ITEGER', strData );
      If Not fExisteSalMLBase(strData) Then
        strSQL  := AnsiReplaceStr( strSQL, 'G.ITE_SAL_ML', '0' );
      If fExisteCnvMLBase(strData) Then
        strSQL  := AnsiReplaceStr( strSQL, 'I.ITE_CNV_ML', 'G.ITE_CNV_ML' );
      If Not fEmptyStr(strSubsti) Then
        strSQL  := AnsiReplaceStr( strSQL, strSubsti, 'IFNULL(G.ITE_PRECUS,0)' );
    End
    Else
    Begin
      strAux  := strSQL + ' LIMIT 0 ';
      If Not fEmptyStr(strSubsti) Then
        strAux  := AnsiReplaceStr( strAux, strSubsti, 'IFNULL(G.ITE_PRECUS,0)' );
    End;

    fltTotEst := 0;
    fltTotGen := 0;

    pIniciaInsercao('VAREST','VAR DO ESTOQ SOBRE MES ANTERIOR');

    If fTabelaExiste(strData) = False Then
    Begin
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        fltVari := 0;
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVari;

      End;

    End
    Else
    Begin

      With qryGenerica Do
      Begin
        Close;
        SQL.Clear;
        Params.Clear;
        Filter := EmptyStr;        
        SQL.Add(strSQL);
        qryGenerica.Open;
      End;

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        qryGenerica.Filtered := False;
        qryGenerica.Filter   := 'ITE_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        qryGenerica.Filtered := True;

        cdsEstoqu.Filtered := False;
        cdsEstoqu.Filter   := 'ITE_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsEstoqu.Filtered := True;

        If (TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value <> Null) And
           (qryGenerica.FieldByName('ITE_SALDOS').Value <> Null)                And
           (qryGenerica.FieldByName('ITE_SALDOS').AsFloat <> 0)                 Then
          fltVari := (( TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value -
                        qryGenerica.FieldByName('ITE_SALDOS').Value ) / qryGenerica.FieldByName('ITE_SALDOS').Value) * 100
        Else
          fltVari := 0;

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVari;

        If (qryGenerica.FieldByName('ITE_SALDOS').Value <> Null) Then
          fltTotGen := fltTotGen + qryGenerica.FieldByName('ITE_SALDOS').Value;

        If (TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value <> Null) Then
          fltTotEst := fltTotEst + TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value;

      End;

    End;

    If fltTotGen <> 0 Then
      cdsRelat.FieldByName('REL_TOTAL').AsFloat := (( fltTotEst - fltTotGen) / fltTotGen) * 100
    Else
      cdsRelat.FieldByName('REL_TOTAL').AsFloat := 0;

    cdsRelat.FieldByName('REL_CALTOT').AsBoolean := True;

    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA IMOBILIZADO/PATRIMONIO       *}
{*************************************IV*}
procedure TfrmRelEstatAnalResult2.pCarregaImobil;
  Var
    strSQL : String;
    intCont: Integer;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 10;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'IMOBILIZADO/PATRIMONIO';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin

  Try
    strSQL := '';

    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  IMO_CODEMP, ';
    strSQL := strSQL + '  SUM(IMO_QTDIMO * GREATEST(IF((IMO_VALAQU  -  ';
    strSQL := strSQL + '          IF( TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)=0, ';
    strSQL := strSQL + '              0,(IMO_VALAQU * (1-(IFNULL(IMO_PERRES, 0)/100))) * (IF('+ QuotedStr(fCfgSis('DEPIMO',varString)) +' = "1",100 / IFNULL(IMO_VIDUTI, 1),IMO_DEPANU ) / 100) * ';
    strSQL := strSQL + '                (TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)))) < ((IMO_PERRES/100)*IMO_VALAQU) AND IFNULL(IMO_PERRES,0) > 0, ';
    strSQL := strSQL + '          ((IMO_PERRES/100)*IMO_VALAQU),';
    strSQL := strSQL + '          (IMO_VALAQU  -  ';
    strSQL := strSQL + '          IF( TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)=0, ';
    strSQL := strSQL + '              0,(IMO_VALAQU * (1-(IFNULL(IMO_PERRES, 0)/100))) * (IF('+ QuotedStr(fCfgSis('DEPIMO',varString)) +' = "1",100 / IFNULL(IMO_VIDUTI, 1),IMO_DEPANU ) / 100) *  ';
    strSQL := strSQL + '                (TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)))) ';
    strSQL := strSQL + '       ),0)) AS IMO_TOTIMO ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADIMO ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  IMO_VENDID = "N" AND ';
    strSQL := strSQL + '  IMO_CODEMP IN (' + fEmpSelecionadas(True) + ') ';
    strSQL := strSQL + 'GROUP BY IMO_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      Filter := EmptyStr;
      SQL.Add(strSQL);

      cdsImobil.Close;
      cdsImobil.Filter  := EmptyStr;
      cpvImobil.DataSet := qryGenerica;
      cdsImobil.AggregatesActive := True;
      cdsImobil.SetProvider(cpvImobil);

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'IMO_TOTIMO';
        FieldName     := 'IMO_TOTIMO';
        DataSet       := cdsImobil;
        Expression    := 'SUM(IMO_TOTIMO)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsImobil.Open;
    End;

    pIniciaInsercao('IMOBIL','IMOBILIZADO / PATRIMONIO');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsImobil.Filtered := False;
      cdsImobil.Filter   := 'IMO_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsImobil.Filtered := True;
      If TAggregateField(cdsImobil.FieldByName('IMO_TOTIMO')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsImobil.FieldByName('IMO_TOTIMO')).Value;
    End;

    {***************************************************************************}
    {* para indicar que apos imprimir o ativo imobilizado                      *}
    {* seja impresso os saldo dos portadores, pois os mesmos irao influenciar  *}
    {* no Resultado (Avaliacao das Lojas)                                      *}
    {***********************************************************************JC**}
    cdsRelat.FieldByName('REL_SALPOR').AsBoolean := chkSalPor.Checked;

    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontos;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_VALJUR, ';
  strSQL := strSQL + '  CTR_VALDES  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  CTR_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

  if not blnIncDupCliForFil then
    strSQL := strSQL + '  AND CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

  With qryJurDes Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                       ');
    SQL.Add('  CTR_CODEMP,                ');
    SQL.Add('  SUM(CTR_VALJUR) AS VALJUR, ');
    SQL.Add('  SUM(CTR_VALDES) AS VALDES  ');
    SQL.Add('FROM                         ');
    SQL.Add('(' + strSQL + ') AS TMP      ');
    SQL.Add('GROUP BY                     ');
    SQL.Add('  CTR_CODEMP                 ');
    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJurDes.Close;
    cdsJurDes.SetProvider(cpvJurDes);
    cpvJurDes.DataSet := qryJurDes;
    cdsJurDes.Open;
    blnExecqryJurDes := False;
  End;
end;


procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontosAgrupamento;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR.CTR_CODEMP, ';
  strSQL := strSQL + '   ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALJUR < 0, 0, AGR_VALJUR) - IF(AGR_VALDES < 0, AGR_VALDES, 0))) AS CTR_VALJUR, ';
  strSQL := strSQL + '   ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALDES < 0, 0, AGR_VALDES) - IF(AGR_VALJUR < 0, AGR_VALJUR, 0))) AS CTR_VALDES  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC CTR  ';
  strSQL := strSQL + '   LEFT JOIN   ';
  strSQL := strSQL + '     (SELECT   ';
  strSQL := strSQL + '       DPG.CTR_NUMAGR AS AGR_NUMAGR, ';
  strSQL := strSQL + '       DPG.CTR_CODCLI AS AGR_CODCLI, ';
  strSQL := strSQL + '       DPG.CTR_EMPAGR AS AGR_EMPAGR, ';
  strSQL := strSQL + '       SUM(DPG.CTR_VALJUR) AS AGR_VALJUR, ';
  strSQL := strSQL + '       SUM(DPG.CTR_VALDES) AS AGR_VALDES, ';
  strSQL := strSQL + '       SUM(DPG.CTR_VALDUP +  ';
  strSQL := strSQL + '           DPG.CTR_VALJUR -  ';
  strSQL := strSQL + '           DPG.CTR_VALDES) AS AGR_TOTDUP  ';
  strSQL := strSQL + '     FROM ';
  strSQL := strSQL + '       DUPAGR DPG  ';
  strSQL := strSQL + '     WHERE DPG.CTR_EMPAGR IN (' + fEmpSelecionadas(True) + ') ';
  strSQL := strSQL + '     GROUP BY AGR_NUMAGR, AGR_CODCLI, AGR_EMPAGR) AS AGR ON (AGR_NUMAGR = CTR_NUMDUP AND ';
  strSQL := strSQL + '                                                             AGR_EMPAGR = CTR_CODEMP AND ';
  strSQL := strSQL + '                                                             AGR_CODCLI = CTR_CODCLI)    ';
  strSQL := strSQL + '     WHERE CTR.CTR_ESPDOC = "AG" ';
  strSQL := strSQL + '       AND CTR.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '       AND CTR.CTR_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

  if not blnIncDupCliForFil then
    strSQL := strSQL + '       AND CTR.CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

  With qryJDAgru Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                       ');
    SQL.Add('  CTR_CODEMP,                ');
    SQL.Add('  SUM(CTR_VALJUR) AS VALJUR, ');
    SQL.Add('  SUM(CTR_VALDES) AS VALDES  ');
    SQL.Add('FROM                         ');
    SQL.Add('(' + strSQL + ') AS TMP      ');
    SQL.Add('GROUP BY                     ');
    SQL.Add('  CTR_CODEMP                 ');
    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJDAgru.Close;
    cdsJDAgru.SetProvider(cpvJDAgru);
    cpvJDAgru.DataSet := qryJDAgru;
    cdsJDAgru.Open;
    blnExecqryJDAgru := False;
  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontosDeducaoCheques;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT                                                  ';
  strSQL := strSQL + '   CTR_CODEMP,                                           ';
  strSQL := strSQL + '   CTR_VALORI,                                           ';
  strSQL := strSQL + '   CTR_VALJUR,                                           ';
	strSQL := strSQL + '   CTR_SEQCON,                                           ';
	strSQL := strSQL + '   CTR_EMPBAI                                            ';
  strSQL := strSQL + ' FROM                                                    ';
  strSQL := strSQL + '   CADREC                                                ';
	strSQL := strSQL + ' LEFT JOIN CADCHQ ON CHQ_SEQCON = CTR_SEQCON             ';
	strSQL := strSQL + '                 AND CHQ_CODEMP = CTR_EMPBAI             ';

  If (fCfgSis('CHQDRE') = 'S') Then
      strSQL := strSQL + ' WHERE TRUE                                          '
  Else
      strSQL := strSQL + ' WHERE FALSE                                         ';

  strSQL := strSQL + ' AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN              ';
  strSQL := strSQL + ' AND CTR_CODEMP IN (' + fEmpSelecionadas(True) + ')      ';
	strSQL := strSQL + ' AND (CTR_CHQPRE <> 0 OR CTR_CHQAVI <> 0)                ';

  if not blnIncDupCliForFil then
    strSQL := strSQL + ' AND CTR_CODCLI NOT IN (' + VS_strCliFil + ')          ';

  strSQL := strSQL + ' GROUP BY   CTR_SEQCON, CTR_EMPBAI, CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP ';

  With qryJDDedChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('  SELECT                                       ');
    SQL.Add('    CTR_CODEMP,                                ');
    SQL.Add('    ABS(SUM(CTR_VALJUR)) AS CHQ_DEDUCA ');
    SQL.Add('  FROM                                         ');
    SQL.Add('  (' + strSQL + ') AS TMP                      ');
    SQL.Add('  GROUP BY                                     ');
    SQL.Add('    CTR_CODEMP                                 ');

    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJDDedChq.Close;
    cdsJDDedChq.SetProvider(cpvJDDedChq);
    cpvJDDedChq.DataSet := qryJDDedChq;
    cdsJDDedChq.Open;
    blnExecqryJDDedChq := False;
  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontosReintegracaoCheques;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT                                                                                                       ';
  strSQL := strSQL + '   CTR_CODEMP,                                                                                                ';
  strSQL := strSQL + '   CTR_VALORI,                                                                                                ';
  strSQL := strSQL + '   CTR_VALJUR,                                                                                                ';
	strSQL := strSQL + '   CTR_SEQCON,                                                                                                ';
	strSQL := strSQL + '   CTR_EMPBAI                                                                                                 ';
  strSQL := strSQL + ' FROM                                                                                                         ';
  strSQL := strSQL + '   CADREC                                                                                                     ';
	strSQL := strSQL + ' LEFT JOIN CADCHQ ON CHQ_SEQCON = CTR_SEQCON                                                                  ';
	strSQL := strSQL + '                 AND CHQ_CODEMP = CTR_EMPBAI                                                                  ';

  If (fCfgSis('CHQDRE') = 'S') Then
      strSQL := strSQL + ' WHERE TRUE                                                                                               '
  Else
      strSQL := strSQL + ' WHERE FALSE                                                                                              ';

  strSQL := strSQL + ' AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                           							                          ';
  strSQL := strSQL + ' AND CTR_CODEMP IN (' + fEmpSelecionadas(True) + ')                   							                          ';
	strSQL := strSQL + ' AND ( CTR_CHQPRE <> 0 OR CTR_CHQAVI <> 0 )                   											                          ';
	strSQL := strSQL + ' AND ((CHQ_DTADEP IS NOT NULL AND CHQ_DTADEV IS NULL) OR (CHQ_DTADP2 IS NOT NULL AND CHQ_DTADV2 IS NULL) )    ';

  if not blnIncDupCliForFil then
    strSQL := strSQL + ' AND CTR_CODCLI NOT IN (' + VS_strCliFil + ')                                                               ';

  With qryJDResChq Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('  SELECT                                       ');
    SQL.Add('    CTR_CODEMP,                                ');
    SQL.Add('    ABS(SUM(CTR_VALJUR)) AS CHQ_REINTE ');
    SQL.Add('  FROM                                         ');
    SQL.Add('  (' + strSQL + ') AS TMP                      ');
    SQL.Add('  GROUP BY                                     ');
    SQL.Add('    CTR_CODEMP                                 ');

    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJDResChq.Close;
    cdsJDResChq.SetProvider(cpvJDResChq);
    cpvJDResChq.DataSet := qryJDResChq;
    cdsJDResChq.Open;
    blnExecqryJDResChq := False;
  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontosAgrupamentoChqDeducao;
Var
  strSQL: String;
begin

    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                                     ';
    strSQL := strSQL + '  	CTR_CODEMP,                                                                                                              ';
    strSQL := strSQL + '  	ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALJUR < 0, 0, AGR_VALJUR) - IF(AGR_VALDES < 0, AGR_VALDES, 0))) AS CTR_VALJUR,  ';
    strSQL := strSQL + '  	ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALDES < 0, 0, AGR_VALDES) - IF(AGR_VALJUR < 0, AGR_VALJUR, 0))) AS CTR_VALDES   ';
    strSQL := strSQL + '  FROM                                                                                                                       ';
    strSQL := strSQL + '  	(                                                                                                                        ';
    strSQL := strSQL + '  	SELECT                                                                                                                   ';
    strSQL := strSQL + '  		REC.CTR_CODEMP,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_VALORI,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_TOTDUP,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_VALJUR,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_VALDES,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_SEQCON,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_EMPBAI                                                                                                         ';
    strSQL := strSQL + '  	FROM CADREC REC                                                                                                          ';
    strSQL := strSQL + '  			LEFT JOIN                                                                                                            ';
    strSQL := strSQL + '  				(SELECT                                                                                                            ';
    strSQL := strSQL + '  					DPG.CTR_NUMAGR AS AGR_NUMAGR,                                                                                    ';
    strSQL := strSQL + '  					DPG.CTR_CODCLI AS AGR_CODCLI,                                                                                    ';
    strSQL := strSQL + '  					DPG.CTR_EMPAGR AS AGR_EMPAGR,                                                                                    ';
    strSQL := strSQL + '  					SUM(DPG.CTR_VALJUR * DPG.CTR_FATCO2) AS AGR_VALJUR,                                                              ';
    strSQL := strSQL + '  					SUM(DPG.CTR_VALDES * DPG.CTR_FATCO2) AS AGR_VALDES,                                                              ';
    strSQL := strSQL + '  					SUM((DPG.CTR_VALDUP + DPG.CTR_VALJUR - DPG.CTR_VALDES) * DPG.CTR_FATCO2) AS AGR_TOTDUP                           ';
    strSQL := strSQL + '  				FROM                                                                                                               ';
    strSQL := strSQL + '  					DUPAGR DPG                                                                                                       ';
    strSQL := strSQL + '  					LEFT JOIN CADREC BAI ON BAI.CTR_NUMDUP = DPG.CTR_NUMAGR                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_CODEMP = DPG.CTR_EMPAGR                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_CODCLI = DPG.CTR_CODCLI                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_ESPDOC = "AG"                                                                    ';

    If (fCfgSis('CHQDRE') = 'S') Then
      strSQL := strSQL + '  				WHERE TRUE                                                                                                         '
    Else
      strSQL := strSQL + '  				WHERE FALSE                                                                                                        ';

    strSQL := strSQL + '  					AND DPG.CTR_EMPAGR IN (' + fEmpSelecionadas(True) + ')                                                           ';
    strSQL := strSQL + '  					AND BAI.CTR_DTAREC IS NOT NULL                                                                                   ';
    strSQL := strSQL + '  					AND BAI.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                                                                   ';
    strSQL := strSQL + '  				GROUP BY AGR_NUMAGR, AGR_CODCLI, AGR_EMPAGR) AS AGR ON AGR_NUMAGR = CTR_NUMDUP                                     ';
    strSQL := strSQL + '  																													 AND AGR_EMPAGR = CTR_CODEMP                                     ';
    strSQL := strSQL + '  																													 AND AGR_CODCLI = CTR_CODCLI                                     ';
    strSQL := strSQL + '  	WHERE TRUE                                                                                                               ';
    strSQL := strSQL + '  			AND REC.CTR_ESPDOC = "AG"                                                                                            ';
    strSQL := strSQL + '  			AND REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                                                                       ';
    strSQL := strSQL + '        AND REC.CTR_CODEMP IN (' + fEmpSelecionadas(True) + ')                                                               ';
    strSQL := strSQL + '  			AND (REC.CTR_CHQPRE <> 0 OR REC.CTR_CHQAVI <> 0)                                                                     ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '        AND REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ')                                                                   ';

    strSQL := strSQL + '  	ORDER BY                                                                                                                 ';
    strSQL := strSQL + '  		REC.CTR_DTAREC                                                                                                         ';
    strSQL := strSQL + '  	) AS AGR                                                                                                                 ';
    strSQL := strSQL + '  	LEFT JOIN CADCHQ AS CHQ ON CHQ.CHQ_SEQCON = AGR.CTR_SEQCON                                                               ';
    strSQL := strSQL + '  									       AND CHQ.CHQ_CODEMP = AGR.CTR_EMPBAI                                                               ';

  With qryJDAgruChqDeducao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                       ');
    SQL.Add('  CTR_CODEMP,                ');
    SQL.Add('  SUM(CTR_VALJUR + CTR_VALDES) AS DEDUCA ');
    SQL.Add('FROM                         ');
    SQL.Add('(' + strSQL + ') AS TMP      ');
    SQL.Add('GROUP BY                     ');
    SQL.Add('  CTR_CODEMP                 ');
    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJDAgruChqDeducao.Close;
    cdsJDAgruChqDeducao.SetProvider(cpvJDAgruChqDeducao);
    cpvJDAgruChqDeducao.DataSet := qryJDAgruChqDeducao;
    cdsJDAgruChqDeducao.Open;
    blnExecqryJDAgruChqDeducao := False;
  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaJurosDescontosAgrupamentoChqReintegracao;
Var
  strSQL: String;
begin

    strSQL := '';
    strSQL := strSQL + '  SELECT                                                                                                                     ';
    strSQL := strSQL + '  	CTR_CODEMP,                                                                                                              ';
    strSQL := strSQL + '  	ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALJUR < 0, 0, AGR_VALJUR) - IF(AGR_VALDES < 0, AGR_VALDES, 0))) AS CTR_VALJUR,  ';
    strSQL := strSQL + '  	ABS((CTR_VALORI / AGR_TOTDUP) * (IF(AGR_VALDES < 0, 0, AGR_VALDES) - IF(AGR_VALJUR < 0, AGR_VALJUR, 0))) AS CTR_VALDES   ';
    strSQL := strSQL + '  FROM                                                                                                                       ';
    strSQL := strSQL + '  	(                                                                                                                        ';
    strSQL := strSQL + '  	SELECT                                                                                                                   ';
    strSQL := strSQL + '  		REC.CTR_CODEMP,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_VALORI,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_TOTDUP,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_VALJUR,                                                                                                        ';
    strSQL := strSQL + '  		AGR.AGR_VALDES,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_SEQCON,                                                                                                        ';
    strSQL := strSQL + '  		REC.CTR_EMPBAI                                                                                                         ';
    strSQL := strSQL + '  	FROM CADREC REC                                                                                                          ';
    strSQL := strSQL + '  			LEFT JOIN                                                                                                            ';
    strSQL := strSQL + '  				(SELECT                                                                                                            ';
    strSQL := strSQL + '  					DPG.CTR_NUMAGR AS AGR_NUMAGR,                                                                                    ';
    strSQL := strSQL + '  					DPG.CTR_CODCLI AS AGR_CODCLI,                                                                                    ';
    strSQL := strSQL + '  					DPG.CTR_EMPAGR AS AGR_EMPAGR,                                                                                    ';
    strSQL := strSQL + '  					SUM(DPG.CTR_VALJUR * DPG.CTR_FATCO2) AS AGR_VALJUR,                                                              ';
    strSQL := strSQL + '  					SUM(DPG.CTR_VALDES * DPG.CTR_FATCO2) AS AGR_VALDES,                                                              ';
    strSQL := strSQL + '  					SUM((DPG.CTR_VALDUP + DPG.CTR_VALJUR - DPG.CTR_VALDES) * DPG.CTR_FATCO2) AS AGR_TOTDUP                           ';
    strSQL := strSQL + '  				FROM                                                                                                               ';
    strSQL := strSQL + '  					DUPAGR DPG                                                                                                       ';
    strSQL := strSQL + '  					LEFT JOIN CADREC BAI ON BAI.CTR_NUMDUP = DPG.CTR_NUMAGR                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_CODEMP = DPG.CTR_EMPAGR                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_CODCLI = DPG.CTR_CODCLI                                                          ';
    strSQL := strSQL + '  															AND BAI.CTR_ESPDOC = "AG"                                                                    ';
    strSQL := strSQL + '  				WHERE TRUE                                                                                                         ';
    strSQL := strSQL + '  					AND DPG.CTR_EMPAGR IN (' + fEmpSelecionadas(True) + ')                                                           ';
    strSQL := strSQL + '  					AND BAI.CTR_DTAREC IS NOT NULL                                                                                   ';
    strSQL := strSQL + '  					AND BAI.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                                                                   ';
    strSQL := strSQL + '  				GROUP BY AGR_NUMAGR, AGR_CODCLI, AGR_EMPAGR) AS AGR ON AGR_NUMAGR = CTR_NUMDUP                                     ';
    strSQL := strSQL + '  																													 AND AGR_EMPAGR = CTR_CODEMP                                     ';
    strSQL := strSQL + '  																													 AND AGR_CODCLI = CTR_CODCLI                                     ';

    If (fCfgSis('CHQDRE') = 'S') Then
      strSQL := strSQL + '  				WHERE TRUE                                                                                                       '
    Else
      strSQL := strSQL + '  				WHERE FALSE                                                                                                      ';

    strSQL := strSQL + '  			AND REC.CTR_ESPDOC = "AG"                                                                                            ';
    strSQL := strSQL + '  			AND REC.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN                                                                       ';
    strSQL := strSQL + '        AND REC.CTR_CODEMP IN (' + fEmpSelecionadas(True) + ')                                                               ';
    strSQL := strSQL + '  			AND (REC.CTR_CHQPRE <> 0 OR REC.CTR_CHQAVI <> 0)                                                                     ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '        AND REC.CTR_CODCLI NOT IN (' + VS_strCliFil + ')                                                                   ';

    strSQL := strSQL + '  	ORDER BY                                                                                                                 ';
    strSQL := strSQL + '  		REC.CTR_DTAREC                                                                                                         ';
    strSQL := strSQL + '  	) AS AGR                                                                                                                 ';
    strSQL := strSQL + '  	LEFT JOIN CADCHQ AS CHQ ON CHQ.CHQ_SEQCON = AGR.CTR_SEQCON                                                               ';
    strSQL := strSQL + '  									       AND CHQ.CHQ_CODEMP = AGR.CTR_EMPBAI                                                               ';
    strSQL := strSQL + ' WHERE ((CHQ_DTADEP IS NOT NULL AND CHQ_DTADEV IS NULL) OR (CHQ_DTADP2 IS NOT NULL AND CHQ_DTADV2 IS NULL) )                 ';

  With qryJDAgruChqReintegracao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT                       ');
    SQL.Add('  CTR_CODEMP,                ');
    SQL.Add('  SUM(CTR_VALJUR + CTR_VALDES) AS REINTE ');
    SQL.Add('FROM                         ');
    SQL.Add('(' + strSQL + ') AS TMP      ');
    SQL.Add('GROUP BY                     ');
    SQL.Add('  CTR_CODEMP                 ');
    ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
    ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

    cdsJDAgruChqReintegracao.Close;
    cdsJDAgruChqReintegracao.SetProvider(cpvJDAgruChqReintegracao);
    cpvJDAgruChqReintegracao.DataSet := qryJDAgruChqReintegracao;
    cdsJDAgruChqReintegracao.Open;
    blnExecqryJDAgruChqReintegracao := False;
  End;

end;



{****************************************}
{* CARREGA ACRÉSCIMO FINANCEIRO         *}
{*************************************MM*}
procedure TfrmRelEstatAnalResult2.pCarregaAcrFin;
  Var
    strSQL: String;
    intCont: Integer;
    fltTotVen: Double;
    fltTotTab: Double;
    fltVenda : Double;
    fltValCnd: Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 13;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'ACRÉSCIMO FINANCEIRO (VENDA)';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

begin
  fltTotVen := 0;
  fltTotTab := 0;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DET_CODEMP AS FAT_CODEMP, ';
    strSQL := strSQL + '  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ') OR DET_CLAFIS < 5000, 0.00, '; //Se For Brinde ou CFOP de entrada nao exibe o acrescimo
    strSQL := strSQL + '      IF( ( (DET_TOTITE - DET_DESESP - DET_DESCFF) - (DET_QTDITE * DET_UNITAB) ) < 0.00, 0.00, '; //se nao houve acrescimo ou desconto maior que acrescimo, tambem nao exibe
    strSQL := strSQL + '            (DET_TOTITE - DET_DESESP - DET_DESCFF)-(DET_QTDITE * DET_UNITAB))) AS FAT_VALVEN, '; //Acrescimo é dado pela diferenca entre o preco praticado na venda e o preco de tabela

    strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -(DET_QTDITE * DET_UNITAB), (DET_QTDITE * DET_UNITAB))) AS FAT_PRETAB, ';

    If fCfgSis('USACND', varBoolean) Then
    Begin
      strSQL := strSQL + '  DET_CODCND AS FAT_CODCND, ';
      strSQL := strSQL + '  CND_DESCRI AS FAT_TIPFAT ';
    End
    Else
    Begin
      strSQL := strSQL + '  0 AS FAT_CODCND, ';
      strSQL := strSQL + '  "ACREFIN"  AS FAT_TIPFAT ';
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
    strSQL := strSQL + '         LEFT  JOIN CADCND ON DET_CODCND        = CND_CODIGO ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + cnsFiltroFFDVTR;    
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  DET_CODEMP IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';
    strSQL := strSQL + IfThen(fCfgSis('ENTBRF', varBoolean), ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ', ')');

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
    
    strSQL := 'SELECT FAT_CODEMP, SUM(FAT_VALVEN) AS FAT_VALVEN, FAT_CODCND, FAT_TIPFAT, SUM(FAT_PRETAB) AS FAT_PRETAB '+
              'FROM  ('+strSQL+') AS ACRFIN '+
              'GROUP BY FAT_CODEMP, FAT_CODCND, FAT_TIPFAT ' +
              'HAVING ROUND(FAT_VALVEN, 2) > 0 ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      cdsAcrFin.Close;
      cdsAcrFin.Filter  := EmptyStr;
      cpvAcrFin.DataSet := qryGenerica;
      cdsAcrFin.SetProvider(cpvAcrFin);
      cdsAcrFin.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************MM*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'FAT_VALVEN';
        FieldName     := 'FAT_VALVEN';
        DataSet       := cdsAcrFin;
        Expression    := 'SUM(FAT_VALVEN)';
        DisplayFormat
        := '#,##0.00';
        Active        := True;
      End;

      {***********************************************}
      {* CRIANDO CAMPO AGGREGATES PARA PRECO TABELA  *}
      {********************************************FC*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'FAT_PRETAB';
        FieldName     := 'FAT_PRETAB';
        DataSet       := cdsAcrFin;
        Expression    := 'SUM(FAT_PRETAB)';
        DisplayFormat
        := '#,##0.00';
        Active        := True;
      End;

      cdsAcrFin.Open;
    End;

    {**********************************}
    {* INSERE A LINHA DO PREÇO TABELA *}
    {********************************FC}
    cdsCtaAux.Filter := '';
    cdsCtaAux.Data := cdsAcrFin.Data;

    pIniciaInsercao(IfThen(fCfgSis('USACND', varBoolean), 'ACREDES', 'ACREFIN'), 'PREÇO DE TABELA');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsAcrFin.Filtered := False;
      cdsAcrFin.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsAcrFin.Filtered := True;

      cdsAcrFin.First;
      While Not cdsAcrFin.Eof Do
      Begin
        {*************************************}
        {* LIMPA SUJEIRA DO CAMPO NO DATASET *}
        {*************************************}
        If cdsAcrFin.RecNo = 1 Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0;

        If Not (TAggregateField(cdsAcrFin.FieldByName('FAT_PRETAB')).Value = Null) Then
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat +
                                                                            TAggregateField(cdsAcrFin.FieldByName('FAT_PRETAB')).Value;

          fltTotTab := fltTotTab + TAggregateField(cdsAcrFin.FieldByName('FAT_PRETAB')).Value;
        End;

        cdsAcrFin.Next;
      End;
    End;
    cdsRelat.Post;

    cdsCtaAux.First;

    If fCfgSis('USACND', varBoolean) Then
    Begin
      {*******************************************}
      {* PROCESSA ACRÉSCIMO FINANCEIRO ANALÍTICO *}
      {* POR CONDIÇÃO DE PAGAMENTO               *}
      {****************************************MM*}
      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsAcrFin.Data;

      While Not cdsCtaAux.Eof Do
      Begin
        if (cdsCtaAux.FieldByName('FAT_VALVEN').Value > 0) Then
        Begin
          If Not cdsRelat.Locate('REL_DESCAM', cdsCtaAux.FieldByName('FAT_CODCND').AsString + '-' + cdsCtaAux.FieldByName('FAT_TIPFAT').AsString, []) Then
          Begin
            pIniciaInsercao('ACREDES',cdsCtaAux.FieldByName('FAT_CODCND').AsString + '-' + cdsCtaAux.FieldByName('FAT_TIPFAT').AsString);

            fltVenda := 0;

            For intCont := 1 To slsEmpresas.Count Do
            Begin
              cdsAcrFin.Filtered := False;
              cdsAcrFin.Filter   := 'FAT_CODCND = ' + QuotedStr(cdsCtaAux.FieldByName('FAT_CODCND').AsString) + ' AND FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
              cdsAcrFin.Filtered := True;

              If TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value = Null Then
                cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
              Else
              Begin
                cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
                fltVenda  := fltVenda  + TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
                fltTotVen := fltTotVen + TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
              End;
            End;

            If fltTotTab > 0 Then
              cdsRelat.FieldByName('REL_MARGEM').AsFloat := ((fltVenda/fltTotTab) * 100)
            Else
              cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;

            cdsRelat.Post;
          End;
        End;

        cdsCtaAux.Next;
      End;

      pIniciaInsercao('***','');
      cdsRelat.Post;
      pIniciaInsercao('ACREDES', 'TOTAL GERAL');

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaAux.Filtered := True;

        fltValCnd := 0;

        cdsCtaAux.First;
        While Not cdsCtaAux.Eof Do
        Begin
          fltValCnd := fltValCnd + TAggregateField(cdsCtaAux.FieldByName('FAT_VALVEN')).Value;;

          cdsCtaAux.Next;
        End;

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltValCnd;
      End;

      If fltTotTab > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := ((fltTotVen/fltTotTab) * 100)
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;

      cdsRelat.Post;

      pIniciaInsercao('***','');
      cdsRelat.Post;
    End
    Else
    Begin
      pIniciaInsercao('ACREFIN','ACRÉSCIMO FINANCEIRO');
      fltVenda := 0;
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsAcrFin.Filtered := False;
        cdsAcrFin.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsAcrFin.Filtered := True;
        If TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
          fltVenda  := fltVenda  + TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
          fltTotVen := fltTotVen + TAggregateField(cdsAcrFin.FieldByName('FAT_VALVEN')).Value;
        End;
      End;

      If fltTotTab > 0 Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := ((fltVenda/fltTotTab) * 100)
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0;

      cdsRelat.Post;
    End;
    
  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

End;

procedure TfrmRelEstatAnalResult2.pCarregaAvalia;
  Var
    intCont  : Integer;
    fltTotSal: Double;
    fltTotImo: Double;
    fltTotChq: Double;
    fltTotCar: Double;
    fltTotCtr: Double;
    fltTotCtp: Double;
    fltTotPor: Double;
    arrCtaPag: Array Of Double;
begin

  Try
    SetLength(arrCtaPag, slsEmpresas.Count);

    If cdsRelat.Locate('REL_CODCAM', 'CTPSPR', []) Then
      For intCont := 1 To slsEmpresas.Count Do
        arrCtaPag[intCont-1] := cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 11;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'AVALIACAO DAS LOJAS';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := 'AVALIA';
    cdsRelat.FieldByName('REL_DESCAM').AsString  := 'RESULTADO';

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsEstoqu.Filtered := False;
      cdsEstoqu.Filter   := 'ITE_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsEstoqu.Filtered := True;

      cdsImobil.Filtered := False;
      cdsImobil.Filter   := 'IMO_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsImobil.Filtered := True;

      cdsCadChq.Filtered := False;
      cdsCadChq.Filter   := 'CHQ_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCadChq.Filtered := True;

      cdsMovCar.Filtered := False;
      cdsMovCar.Filter   := 'MCA_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsMovCar.Filtered := True;

      cdsCtaRec.Filtered := False;
      cdsCtaRec.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCtaRec.Filtered := True;

      If TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value = Null Then
        fltTotSal := 0
      Else
        fltTotSal := TAggregateField(cdsEstoqu.FieldByName('ITE_TOTSAL')).Value;

      If TAggregateField(cdsImobil.FieldByName('IMO_TOTIMO')).Value = Null Then
        fltTotImo := 0
      Else
        fltTotImo := TAggregateField(cdsImobil.FieldByName('IMO_TOTIMO')).Value;

      If TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value = Null Then
        fltTotChq := 0
      Else
        fltTotChq := TAggregateField(cdsCadChq.FieldByName('CHQ_TOTCHQ')).Value;

      If TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value = Null Then
        fltTotCar := 0
      Else
        fltTotCar := TAggregateField(cdsMovCar.FieldByName('MCA_TOTDUP')).Value;

      If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
        fltTotCtr := 0
      Else
        fltTotCtr := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;

      fltTotCtp := arrCtaPag[intCont-1];

      fltTotPor := 0 ;
      if chkSalPor.Checked then
      begin
        cdsSalPor.Filtered := False;
        cdsSalPor.Filter   := 'REL_LOJ0' + fStrZero(intCont,2) + ' <> 0 ';
        cdsSalPor.Filtered := True;

        with cdsSalPor do
        begin
          first;
          While not eof do
          begin
            fltTotPor := fltTotPor + FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
            next;
          end;
        end;
      end;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltTotSal + fltTotChq + fltTotCar +
                                                                        fltTotImo + fltTotCtr + fltTotPor - fltTotCtp;

    End;
    cdsRelat.Post;

    cdsSalPor.Filtered := False;
    cdsSalPor.IndexFieldNames := 'POR_CODPOR;POR_NOMPOR';
    frxSalPor.DataSet := cdsSalPor;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA PRAZOS MEDIOS                *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaPraMed;
  Var
    strSQL : String;
    strFil : String;
    intCont: Integer;

    fltTotDifere : Double;
    fltTotTotDup : Double;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 12;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'PRAZOS MEDIOS(DIAS)';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistroFat(strChave, strDescri, strFiltro: String);
    Var
      fltParci: Double;
      fltTotal: Double;
      fltParGe: Double;
      fltTotGe: Double;
      intCont : Integer;
  Begin

    pIniciaInsercao(strChave, strDescri);
    fltParGe := 0;
    fltTotGe := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsPraFat.Filtered := False;
      cdsPraFat.Filter   := 'GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsPraFat.Filtered := True;

      fltParci := 0;
      fltTotal := 0;

      While Not cdsPraFat.Eof Do
      Begin
        fltParci := fltParci + cdsPraFat.FieldByName('PARGER').AsFloat;
        fltTotal := fltTotal + cdsPraFat.FieldByName('TOTGER').AsFloat;

        cdsPraFat.Next;
      End;

      If (fFormataFloat(fltTotal, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltParci / fltTotal;


      fltParGe := fltParGe + fltParci;
      fltTotGe := fltTotGe + fltTotal;
    End;

    If (fFormataFloat(fltTotGe, 2) = 0.0) Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := fltParGe / fltTotGe;

    cdsRelat.Post;
  End;

begin

  Try
    fltTotDifere := 0;
    fltTotTotDup := 0;

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SET @ABRINDO_CONSULTA := TRUE;');
      ExecSQL;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  ((SELECT SUM(DET_TOTITE - DET_DESESP) FROM MOVDET WHERE DET_SEQGER = MOVGER.AUTOINCREM)) AS TOTGER, ';
    strSQL := strSQL + '  ((SELECT SUM(DET_TOTITE - DET_DESESP) FROM MOVDET WHERE DET_SEQGER = MOVGER.AUTOINCREM)*IF(IFNULL(AUX_PRZMED,0)=0,fCalcMediaPagto(GER_CONPAG),AUX_PRZMED)) AS PARGER ';
    strSQL := strSQL + 'FROM MOVGER ';
    strSQL := strSQL + '  INNER JOIN AUXMOV ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + cnsFiltroFFDVTR;
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    strSQL := strSQL + '  AND IF("' + fCfgSis('FATCLF') + '" = "N", GER_CODCLI NOT IN (' + VS_strCliFil + '), TRUE) ';
    strSQL := strSQL + '  AND ((LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0) ';
    strSQL := strSQL + '    OR (LOCATE(GER_CLAFIS, "' + VS_strClaDev + '") > 0) ';
    strSQL := strSQL + '    OR IF("' + fCfgSis('ENTBRF') + '" = "S",(GER_ESPDOC = "BR") ';
    strSQL := strSQL + '    OR LOCATE(GER_CLAFIS, ' + CLAFIS_BR + '), FALSE)) ';
    strSQL := strSQL + '  AND GER_TIP_FC = "C" ';
    strSQL := strSQL + '  AND GER_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL,[],[],[],'GER_');

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
      Filter := '';
      Open;

      cdsPraFat.Close;
      cdsPraFat.SetProvider(cpvPraFat);
      cpvPraFat.DataSet := qryGenerica;
      cdsPraFat.AggregatesActive := True;
      cdsPraFat.Open;
    End;

    strFil := '';

    pInsereRegistroFat('PRAVEN','PRAZO MEDIO DE VENDA',strFil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  (GER_VLRCON) AS TOTGER, ';
    strSQL := strSQL + '  (GER_VLRCON*IF(IFNULL(AUX_PRZMED,0)=0,fCalcMediaPagto(GER_CONPAG),AUX_PRZMED)) AS PARGER ';
    strSQL := strSQL + 'FROM MOVGER ';
    strSQL := strSQL + '  INNER JOIN AUXMOV ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ';
    strSQL := strSQL + 'WHERE TRUE ';
    strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    strSQL := strSQL + '  AND NOT LOCATE(GER_CODFOR,"' + fRetForFilialTodos() + '") ';
    strSQL := strSQL + '  AND LOCATE(GER_CLAFIS, "' + VS_strClaCom + '") > 0 ';
    strSQL := strSQL + '  AND GER_ESPDOC <> "DV" ';
    strSQL := strSQL + '  AND GER_ESPDOC <> "TR" ';
    strSQL := strSQL + '  AND GER_TIP_FC = "F" ';
    strSQL := strSQL + '  AND GER_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());
      Filter := '';
      Open;

      cdsPraFat.Close;
      cdsPraFat.SetProvider(cpvPraFat);
      cpvPraFat.DataSet := qryGenerica;
      cdsPraFat.AggregatesActive := True;
      cdsPraFat.Open;
    End;

    strFil := '';

    pInsereRegistroFat('PRACOM','PRAZO MEDIO DE COMPRA',strFil);

    {****************************************}
    {* CARREGA DADOS DO CTR                 *}
    {*************************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_CODEMP, ';
    strSQL := strSQL + '  COUNT(*) AS CTR_TOTDUP, ';
    strSQL := strSQL + '  SUM(DATEDIFF(CTR_DTAREC, CTR_DTAVEN)) AS CTR_DIFERE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_DTAREC IS NOT NULL AND ';
    strSQL := strSQL + '  CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  CTR_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CTR_CODEMP ';

    strSQL := 'SELECT CTR_CODEMP, SUM(CTR_TOTDUP) AS TOTDUP, SUM(CTR_DIFERE) AS DIFERE FROM (' + strSQL + ') AS TMP GROUP BY CTR_CODEMP';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(fRetDtaIni());
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

      cdsPraCtr.Close;
      cdsPraCtr.SetProvider(cpvPraCtr);
      cpvPraCtr.DataSet := qryGenerica;
      cdsPraCtr.Open;
    End;

    pIniciaInsercao('PRACTR','PRAZO MEDIO RECEBIMENTO');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsPraCtr.Filtered := False;
      cdsPraCtr.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsPraCtr.Filtered := True;

      If (fFormataFloat(cdsPraCtr.FieldByName('TOTDUP').AsFloat, 2) = 0.0) Then
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.0;
          fltTotDifere := fltTotDifere + 0;
          fltTotTotDup := fltTotTotDup + 0;
        end
      Else
        Begin
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsPraCtr.FieldByName('DIFERE').AsFloat / cdsPraCtr.FieldByName('TOTDUP').AsFloat;
          fltTotDifere := fltTotDifere + cdsPraCtr.FieldByName('DIFERE').AsFloat;
          fltTotTotDup := fltTotTotDup + cdsPraCtr.FieldByName('TOTDUP').AsFloat;
        end;

    End;

    cdsPraCtr.Filter   := '';
    cdsPraCtr.Filtered := False;

    If fltTotTotDup = 0.0 Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := fltTotDifere / fltTotTotDup;

    cdsRelat.Post;
  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResult2.pCarregaRegimeTributario;
  Var
    strSQL: String;
begin
  qryEmpTri := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EMP_REGTRI, ';
  strSQL := strSQL + '   EMPTRI.* ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEMP ';
  strSQL := strSQL + '   JOIN EMPTRI ON (TRI_CODEMP = EMP_CODEMP)';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   EMP_CODEMP IN (' + fEmpSelecionadas(True) + ') ';

  With qryEmpTri Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

{****************************************}
{* CARREGA SALDO DO PORTADOR            *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaSalPor;
  Var
    strSQL: String;
    dtaDtaCai: TDateTime;
    intContador: Integer;
    strCodEmp: String;

    fltSalFec: Double;
    dtaDtaFec: TDateTime;
    qryGenRcx: TUniQuery;

    cdsClonePor: TUniClientDataSet;

    procedure pAddItem(strCampo: String; fltValor: Double; strCampoLoja: String;
      strCodEmpP: String);
    Begin
      If Not cdsSalPor.Locate('POR_NOMPOR', strCampo, []) Then
      Begin
        cdsSalPor.Append;
        cdsSalPor.FieldByName('POR_NOMPOR').AsString := strCampo;
      End
      Else
        cdsSalPor.Edit;

      cdsSalPor.FieldByName('CTB_CODEMP').AsString := strCodEmpP;
      cdsSalPor.FieldByName('POR_CODPOR').AsString := '';
      cdsSalPor.FieldByName(strCampoLoja).AsFloat := fltValor;
      cdsSalPor.Post;
    End;

    procedure pAddSomaFechamento(strCampo: String; fltValor: Double; strCampoLoja: String);
    Begin
      If Not cdsSalPor.Locate('POR_NOMPOR', strCampo, []) Then
      Begin
        cdsSalPor.Append;
        cdsSalPor.FieldByName('POR_NOMPOR').AsString := strCampo;
      End
      Else
        cdsSalPor.Edit;

      cdsSalPor.FieldByName('POR_CODPOR').AsString := '';
      cdsSalPor.FieldByName(strCampoLoja).AsFloat  := cdsSalPor.FieldByName(strCampoLoja).AsFloat + fltValor;
      cdsSalPor.Post;
    End;
begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    For intContador := 1 To MAX_COLUNA_EXCEL Do
      strSQL := strSQL + '  0.00 AS REL_LOJ0' + fStrZero(intContador,2) + ', ';

    strSQL := strSQL + '  REPEAT(" ", 40) AS POR_NOMPOR, ';
    strSQL := strSQL + '  CTB_CODPOR AS POR_CODPOR, ';
    strSQL := strSQL + '  CTB_CODEMP, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C", CTB_VALLAN, - CTB_VALLAN)) AS TOTAL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVBAN ';
    strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTB_CODPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTB_CODEMP IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  CTB_CODPOR IS NOT NULL  AND ';
    strSQL := strSQL + '  CTB_DTALAN BETWEEN POR_DTAINI AND :DTAFIN ';

    If (rdgSalPor.ItemIndex = 0) Then
      strSQL := strSQL + ' AND IFNULL(CTB_DTACON,0) <> 0  ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  POR_CODPOR, ';
    strSQL := strSQL + '  CTB_CODEMP  ';
    strSQL := strSQL + 'HAVING TOTAL <> 0 ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  POR_CODPOR ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Filter := '';
      ParamByName('DTAFIN').AsDate   := StrToDate(fRetDtaFin());

      Open;

      cdsSalPor   := fCriaClientDatset(qryGenerica);
      cdsClonePor := fCriaClientDatset(qryGenerica);

      pSetaClient(cdsSalPor);
      pSetaClient(cdsClonePor);

      cdsSalPor.EmptyDataSet;

      For intContador := 0 To slsEmpresas.Count -1 Do
      Begin
        strCodEmp := LeftStr(slsEmpresas[intContador], 3);

        cdsClonePor.Filtered := False;
        cdsClonePor.Filter   := 'CTB_CODEMP = ' + QuotedStr(strCodEmp);
        cdsClonePor.Filtered := True;

        cdsClonePor.First;
        While Not cdsClonePor.Eof Do
        Begin
          If fCampoTabela('POR_ENTANA', 'CADPOR', ['POR_CODPOR'], [cdsClonePor.FieldByName('POR_CODPOR').AsString]) = 'S' Then
          Begin
            If Not cdsSalPor.Locate('POR_CODPOR', cdsClonePor.FieldByName('POR_CODPOR').AsString, []) Then
            Begin
              cdsSalPor.Append;
              cdsSalPor.FieldByName('POR_CODPOR').AsString := cdsClonePor.FieldByName('POR_CODPOR').AsString;
              cdsSalPor.FieldByName('POR_NOMPOR').AsString := fRetNomPortador(cdsClonePor.FieldByName('POR_CODPOR').AsString);
            End
            Else
              cdsSalPor.Edit;

            cdsSalPor.FieldByName('CTB_CODEMP').AsString := strCodEmp;
            cdsSalPor.FieldByName('REL_LOJ0' + fStrZero(intContador+1,2)).AsFloat := cdsClonePor.FieldByName('TOTAL').AsFloat;

            If cdsSalPor.FieldByName('REL_LOJ0' + fStrZero(intContador+1,2)).AsFloat <> 0 Then
              cdsSalPor.Post
            Else
              cdsSalPor.Cancel;
          End;

          cdsClonePor.Next;
        End;

        fltSalFec := 0;

        If fCfgSis('USARCX', varBoolean, strCodEmp) Then
        Begin
          qryGenRcx := fCriaQuery(nil);

          pRetornaUltimoFechamento(fltSalFec, dtaDtaFec, strCodEmp);
          fNecessitaFecharCaixa(False, dtaDtaCai, False, strCodEmp);

          //If (dtaDtaFec <> dtaDtaCai) And fCaixaTemMovimento(StrToDate(fRetDtaIni()), qryGenRcx, strCodEmp, True, StrToDate(fRetDtaFin())) Then
          If fCaixaTemMovimento(StrToDate(fRetDtaIni()), qryGenRcx, strCodEmp, True, StrToDate(fRetDtaFin())) Then
          Begin
            While (Not qryGenRcx.Eof) Do
            Begin
              pAddItem('DINHEIRO',
                       qryGenRcx.FieldByName('RCX_DINREC').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              pAddItem('CHEQUE À VISTA',
                       qryGenRcx.FieldByName('RCX_CHQAVI').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              pAddItem('CHEQUE-PRÉ',
                       qryGenRcx.FieldByName('RCX_CHQPRE').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              pAddItem('CARTÃO',
                       qryGenRcx.FieldByName('RCX_CARREC').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              pAddItem('ORDEM PAGAMENTO',
                       qryGenRcx.FieldByName('RCX_ORDREC').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              pAddItem('FINANCIAMENTO',
                       qryGenRcx.FieldByName('RCX_VALFIN').AsFloat,
                       'REL_LOJ0' + fStrZero(intContador+1,2),
                       strCodEmp);

              qryGenRcx.Next;
            End;

            qryGenRcx.Close;

            If (fMovimentoFechamentoCaixa(StrToDate(fRetDtaIni()), qryGenRcx, strCodEmp)) Then
            Begin
              While (Not qryGenRcx.Eof) Do
              Begin
                pAddSomaFechamento('DINHEIRO',
                         qryGenRcx.FieldByName('RCX_DINREC').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                pAddSomaFechamento('CHEQUE À VISTA',
                         qryGenRcx.FieldByName('RCX_CHQAVI').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                pAddSomaFechamento('CHEQUE-PRÉ',
                         qryGenRcx.FieldByName('RCX_CHQPRE').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                pAddSomaFechamento('CARTÃO',
                         qryGenRcx.FieldByName('RCX_CARREC').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                pAddSomaFechamento('ORDEM PAGAMENTO',
                         qryGenRcx.FieldByName('RCX_ORDREC').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                pAddSomaFechamento('FINANCIAMENTO',
                         qryGenRcx.FieldByName('RCX_VALFIN').AsFloat,
                         'REL_LOJ0' + fStrZero(intContador+1,2));

                qryGenRcx.Next;
              End;

              qryGenRcx.Close;
            End;
          End;

          FreeAndNil(qryGenRcx);
        End;
      End;

      FreeAndNil(cdsClonePor);

    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmRelEstatAnalResult2.lstEmpresasClickCheck(Sender: TObject);
  Var
    strMsg: String;

  function fAtingiuLimiteSelecao: Boolean;
  begin
    Result := ((fContaSelecoes+1) > intMaxColuna);
  End;

begin
  inherited;

  if (fAtingiuLimiteSelecao) then
  begin
    lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;

    if (Pos(edtDestino.Text, 'E_') > 0) then
    begin
      strMsg :=  'O Modo Excel suporta no máximo ' + IntToStr(IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_EXCEL, MAX_COLUNA_EXCEL_CONSOL) - 1) + ' empresas opcionais!';
    end
    else
    begin
      if (rdgOrientacao.ItemIndex = 0) then
      begin
         strMsg := 'Orientação "Retrato" (' + IfThen(rdgTipOri.ItemIndex = 0, 'Distribuído', 'Consolidado')  + ') suporta no máximo ' + IntToStr(IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_RETRA, MAX_COLUNA_RETRA_CONSOL) - 1) + ' empresas opcionais. '+
                   'Para selecionar mais que ' + IntToStr(IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_PAISA, MAX_COLUNA_PAISA_CONSOL) - 1) + ' empresas opcionais, use a Orientação "Paisagem" ou Destino "Excel".';
      end
      else
      begin
         strMsg := 'Orientação "Paisagem" (' + IfThen(rdgTipOri.ItemIndex = 0, 'Distribuído', 'Consolidado')  + ') suporta no máximo ' + IntToStr(IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_PAISA, MAX_COLUNA_PAISA_CONSOL) - 1) + ' empresas opcionais.';
      end;
    end;

    fMensagem('ATENÇÃO!', strMsg, ['&O k']);
  end;

end;

{*************************************************}
{* CONTA QUANTAS EMPRESAS JÁ ESTÃO SELECIONADAS  *}
{**********************************************AF*}
function TfrmRelEstatAnalResult2.fCalculaPrecoVendaInt(curPrecus,
  curPreven: Currency): Double;
begin
  Result := fCalculaPrecoVenda(2, curPrecus, curPreven, 0, 0, 0, 0, 0, auxStrMarMkp, auxStrPcmPro, auxIntDecUni);
end;

function TfrmRelEstatAnalResult2.fCarregandoDadosRelatorio(
  pgbStatus: TcxProgressBar): Boolean;
begin
//  Result := False;
//  Try
    pInformacao('Gerando dados para o relatório. Aguarde...', pgbStatus);
    pProgresso(0, 18, pgbStatus);

    pInformacao('Carregando contas. Aguarde...', pgbStatus);
    pCarregaCTP124; //ESSA PROCEDURE DEVE ESTAR EM PRIMEIRO LUGAR
    pProgresso(1, 18, pgbStatus);

    pInformacao('Carregando vendas. Aguarde...', pgbStatus);
    pCarregaVendas;
    pProgresso(2, 18, pgbStatus);

    pInformacao('Carregando vendas fornecedor. Aguarde...', pgbStatus);
    If chkResFor.Checked Then
      pCarregaVendasFornec;
    pProgresso(3, 18, pgbStatus);

    pInformacao('Carregando contas de resultado. Aguarde...', pgbStatus);
    pCarregaCtaRes;
    pProgresso(4, 18, pgbStatus);

    pInformacao('Carregando pagamentos. Aguarde...', pgbStatus);
    pCarregaCtaPag;
    pProgresso(5, 18, pgbStatus);

    pInformacao('Carregando recebimentos. Aguarde...', pgbStatus);
    pCarregaCtaRec;
    pProgresso(6, 18, pgbStatus);

    pInformacao('Carregando cartões. Aguarde...', pgbStatus);
    pCarregaMovCar;
    pProgresso(7, 18, pgbStatus);

    pInformacao('Carregando cheques. Aguarde...', pgbStatus);
    pCarregaCadChq;
    pProgresso(8, 18, pgbStatus);

    pInformacao('Carregando transferências. Aguarde...', pgbStatus);
    pCarregaTransf;
    pProgresso(9, 18, pgbStatus);

    pInformacao('Carregando uso e consumo. Aguarde...', pgbStatus);
    pCarregaUsoCon;
    pProgresso(10, 18, pgbStatus);

    pInformacao('Carregando saídas bonificações. Aguarde...', pgbStatus);
    pCarregaBonifi(True);  // SAÍDA
    pProgresso(11, 18, pgbStatus);

    pInformacao('Carregando entradas bonificações. Aguarde...', pgbStatus);
    pCarregaBonifi(False); // ENTRADA
    pProgresso(12, 18, pgbStatus);

    pInformacao('Carregando estoque. Aguarde...', pgbStatus);
    pCarregaEstoqu;
    pProgresso(13, 18, pgbStatus);

    pInformacao('Carregando patrimônio. Aguarde...', pgbStatus);
    pCarregaImobil;
    pProgresso(14, 18, pgbStatus);

    pInformacao('Carregando saldo portadores. Aguarde...', pgbStatus);
    pCarregaSalPor;
    pProgresso(15, 18, pgbStatus);

    pInformacao('Carregando avaliação das lojas. Aguarde...', pgbStatus);
    pCarregaAvalia;
    pProgresso(16, 18, pgbStatus);

    pInformacao('Carregando acréscimo financeiro. Aguarde...', pgbStatus);
    If chkExibeAcreFin.Checked Then
      pCarregaAcrFin;
    pProgresso(17, 18, pgbStatus);

    pInformacao('Carregando prazos médios. Aguarde...', pgbStatus);
    pCarregaPraMed;
    pProgresso(18, 18, pgbStatus);

    Result := True;

//  Except
//    On E: Exception Do
//      pMensagensErro(E.Message, '[fCarregandoDadosRelatorio]');
//  End;
end;

function TfrmRelEstatAnalResult2.fContaSelecoes: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;

  For intContador := 0 To lstEmpresas.Items.Count -1 Do
  Begin
    If lstEmpresas.Checked[intContador] Then
      Inc(Result);
  End;

end;

procedure TfrmRelEstatAnalResult2.lstEmpresasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
  End;

end;

procedure TfrmRelEstatAnalResult2.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmRelEstatAnalResult2.mnuSelTudoClick(Sender: TObject);
begin
  inherited;
  pSelVarios(opMTodos);
end;

procedure TfrmRelEstatAnalResult2.pSelVarios(Opcao: TSelecao);
  Var
    intIdx: Integer;
    intSel : Integer;
Begin

  Case Opcao Of
    opMTodos: Begin
                intSel := (fContaSelecoes+1);

                For intIdx := 0 To lstEmpresas.Count -1 Do
                Begin

                  If (intSel >= intMaxColuna) And (rdgTipOri.ItemIndex = 0) Then
                    Break;

                  If Not lstEmpresas.Checked[intIdx] Then
                  Begin
                    lstEmpresas.Checked[intIdx] := True;
                    Inc(intSel);
                  End;
                End;

              End;

    opDTodos: Begin
                For intIdx := 0 To lstEmpresas.Count -1 Do
                  lstEmpresas.Checked[intIdx] := False;
              End;
  End;

End;

function TfrmRelEstatAnalResult2.fRetCompet(strCompetIni, strCompetFin: String): String;
  Var
    intMesAtu, intAnoAtu, intMesFin, intAnoFin: Integer;
begin
  Result := '';

  intMesAtu := StrToInt(Copy(strCompetIni, 1, 2));
  intAnoAtu := StrToInt(Copy(strCompetIni, 4, 4));

  If (intMesAtu = 1) Then
  Begin
    intMesAtu := 12;
    intAnoAtu := intAnoAtu - 1;
  End
  Else
    intMesAtu := intMesAtu - 1;

  intMesFin := StrToInt(Copy(strCompetFin, 1, 2));
  intAnoFin := StrToInt(Copy(strCompetFin, 4, 4));

  Repeat
    If (intMesAtu = 12) Then
    Begin
      intAnoAtu := intAnoAtu + 1;
      intMesAtu := 1;
    End
    Else
      intMesAtu := intMesAtu + 1;

    If (FormatFloat('##00', intMesAtu) + '/' + FormatFloat('####0000', intAnoAtu) =
        FormatFloat('##00', intMesFin) + '/' + FormatFloat('####0000', intAnoFin)) Then
      Result := Result + QuotedStr(FormatFloat('##00', intMesAtu) + '/' + FormatFloat('####0000', intAnoAtu))
    Else
      Result := Result + QuotedStr(FormatFloat('##00', intMesAtu) + '/' + FormatFloat('####0000', intAnoAtu)) + ', ';
  Until (FormatFloat('##00', intMesAtu) + '/' + FormatFloat('####0000', intAnoAtu) =
         FormatFloat('##00', intMesFin) + '/' + FormatFloat('####0000', intAnoFin));
end;

function TfrmRelEstatAnalResult2.fRetDtaFin(campoMask: TMaskEditFocus = Nil): String;
begin
  If (rdgTipDta.ItemIndex = 2) Then
    Result := FormatDateTime('dd/mm/yyyy', EndOfAMonth(StrToInt(Copy(mskDtaFin.Text, 4, 4)), StrToInt(Copy(mskDtaFin.Text, 1, 2))))
  Else If Assigned(campoMask) Then
    Result := FormatDateTime('dd/mm/yyyy', EndOfAMonth(StrToInt(Copy(campoMask.Text, 4, 4)), StrToInt(Copy(campoMask.Text, 1, 2))))
  Else
    Result := mskDtaFin.Text;
end;

function TfrmRelEstatAnalResult2.fRetDtaIni(campoMask: TMaskEditFocus = Nil): String;
begin
  If (rdgTipDta.ItemIndex = 2) Then
    Result := '01/' + mskDtaIni.Text
  Else If Assigned(campoMask) Then
    Result := '01/' + campoMask.Text
  Else
    Result := mskDtaIni.Text;
end;

function TfrmRelEstatAnalResult2.fRetPercentualTributos(
  ptCampo: TTipoPercentualTributo; strCodEmp: String): Double;
begin
  Result := 0;

  If fRetRegimeTributario(strCodEmp) = trSimplesNacional Then
  Begin
    If qryEmpTri.Locate('TRI_CODEMP', strCodEmp, []) And
      (ptCampo = ptAlqSimpNac)                       Then
      Result := qryEmpTri.FieldByName('TRI_SNALQF').AsFloat;
  End
  Else If fRetRegimeTributario(strCodEmp) = trLucroPresumido Then
  Begin
    If qryEmpTri.Locate('TRI_CODEMP', strCodEmp, []) Then
    Begin
      If ptCampo = ptAlqIRPJ Then
        Result := qryEmpTri.FieldByName('TRI_LPALQI').AsFloat
      Else If ptCampo = ptAlqCSLL Then
        Result := qryEmpTri.FieldByName('TRI_LPALQC').AsFloat;
    End;
  End;
end;

function TfrmRelEstatAnalResult2.fRetRegimeTributario(strCodEmp: String): TTipoRegime;
begin
  Result := trNenhum;

  If qryEmpTri.Locate('TRI_CODEMP', strCodEmp, []) Then
  Begin
    If qryEmpTri.FieldByName('EMP_REGTRI').AsString = 'R' Then
      Result := trLucroReal
    Else If qryEmpTri.FieldByName('EMP_REGTRI').AsString = 'P' Then
      Result := trLucroPresumido
    Else If qryEmpTri.FieldByName('EMP_REGTRI').AsString = 'S' Then
      Result := trSimplesNacional;
  End;
end;

function TfrmRelEstatAnalResult2.frxQckEstatAnalResult2JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If SameText(MethodName, 'fCalculaPrecoVendaInt') Then
    Result := fCalculaPrecoVendaInt(Params[0], Params[1]);
end;

function TfrmRelEstatAnalResult2.frxQckEstatAnalResult2MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName, 'fCalculaPrecoVendaInt') Then
    Result := fCalculaPrecoVendaInt(Params[0], Params[1]);
end;

function TfrmRelEstatAnalResult2.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else If (rdgTipDta.ItemIndex = 2) And (Length(fTiraCaracEspeciais(Trim(mskDtaIni.Text))) < 6) Then
      Begin
        fMensagem('', 'O ano da Competência Inicial deve ser preenchido com 4 dígitos!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If (rdgTipDta.ItemIndex = 2) And (Length(fTiraCaracEspeciais(Trim(mskDtaFin.Text))) < 6) Then
          Begin
            fMensagem('', 'O ano da Competência Final deve ser preenchido com 4 dígitos!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If (rdgTipDta.ItemIndex = 2) Then Begin
              If StrToDate(fRetDtaIni()) > StrToDate(fRetDtaFin()) Then
              Begin
                fMensagem('','A Competência Inicial deve ser menor que a Competência Final!',['&O K']);
                Result := False;
              End;
            End Else Begin
              If StrToDate(fRetDtaIni()) > StrToDate(fRetDtaFin()) Then
              Begin
                fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
                Result := False;
              End;
            End;
          End;
        End
      End;

    End

    Else If (Sender = mskCompetIni) And mskCompetIni.Visible Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskCompetIni.Text)) Then
      Begin
        fMensagem('', 'A Competência Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Length(fTiraCaracEspeciais(Trim(mskCompetIni.Text))) < 6 Then
      Begin
        fMensagem('', 'O ano da Competência Inicial deve ser preenchido com 4 dígitos!', ['&O k']);
        Result := False;
      End
      Else If StrToDateDef('01/'+ mskCompetIni.Text, -1) = -1 Then
      Begin
        fMensagem('', 'Competência Inicial inválida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskCompetFin) And mskCompetFin.Visible Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskCompetFin.Text)) Then
      Begin
        fMensagem('', 'A Competência Final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Length(fTiraCaracEspeciais(Trim(mskCompetFin.Text))) < 6 Then
      Begin
        fMensagem('', 'O ano da Competência Final deve ser preenchido com 4 dígitos!', ['&O k']);
        Result := False;
      End
      Else If StrToDateDef('01/'+ mskCompetFin.Text, -1) = -1 Then
      Begin
        fMensagem('', 'Competência Final inválida!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(fRetDtaIni(mskCompetIni)) > StrToDate(fRetDtaFin(mskCompetFin)) Then
      Begin
        fMensagem('','A Competência Inicial deve ser menor que a Competência Final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDestino) Then
    Begin

      {**************************}
      {* VERIFICA CAMPO DESTINO *}
      {***********************LU*}
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmRelEstatAnalResult2.fVerificaSeImpSessao(caCampo: TTipoConfigAtiva): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;

  For intCont := 1 To slsEmpresas.Count Do
  Begin
    If fConfiguracaoRegTriAtiva(caCampo, slsEmpresas[intCont-1]) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmRelEstatAnalResult2.fVerificaSeImpSessao(ptCampo: TTipoPercentualTributo): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;

  For intCont := 1 To slsEmpresas.Count Do
  Begin
    If fRetPercentualTributos(ptCampo, slsEmpresas[intCont-1]) > 0 Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TfrmRelEstatAnalResult2.Label2Click(Sender: TObject);
  Var
    curPos: TPoint;
begin
  inherited;

  GetCursorPos(curPos);
  popSel.Popup(curPos.X - 2, curPos.Y - 2);

end;

procedure TfrmRelEstatAnalResult2.pAtualizaLst;
  Var
    strSQL     : String;
    intContador: Integer;
    qryGen     : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    lstEmpresas.Items.Clear;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_CODEMP, ';
    strSQL := strSQL + '  EMP_NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP AND ';
    strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  EMP_CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      While Not Eof Do
      Begin
        Application.ProcessMessages;
        lstEmpresas.Items.Add(FieldByName('EMP_CODEMP').AsString + ' - ' +
                              FieldByName('EMP_NOMEMP').AsString);
        Next;
      End;
      Close;
    End;

    For intContador := 1 To MAX_COLUNA_EXCEL Do
    Begin
      With TFloatField.Create(Self) Do
      Begin
        Name := cdsRelat.Name+'REL_LOJ0' + fStrZero(intContador, 2);
        FieldKind := fkData;
        FieldName := 'REL_LOJ0' + fStrZero(intContador, 2);
        DataSet := cdsRelat;
      End;
    End;

  Finally
    cdsRelat.CreateDataSet;

    FreeAndNil(qryGen);
  End;
End;

procedure TfrmRelEstatAnalResult2.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  inherited;
  lblPreCus.Caption := 'Preço utilizado na seção "Estoque": '+fPreInvTitulo;
  If Not fCfgSis('USACND', varBoolean) Then
    rdgFatura.Visible := False;

  blnRegimeDefinidoNoPlanoDeContas := fCfgSis('REGDRE', varBoolean);

  If blnRegimeDefinidoNoPlanoDeContas Then
  Begin
    rdgTipDta.Items.Clear;
    rdgTipDta.Items.Add('De acordo com o Plano de Contas');
    rdgTipDta.Items.Add('Por data de Cadastro');
    rdgTipDta.ItemIndex := 0;

    lblCompetIni.Visible := True;
    mskCompetIni.Visible := True;
    lblCompetFin.Visible := True;
    mskCompetFin.Visible := True;

    mskCompetIni.Text := FormatDateTime('mm/yyyy', VS_Date);
    mskCompetFin.Text := FormatDateTime('mm/yyyy', VS_Date);
  End;
end;

procedure TfrmRelEstatAnalResult2.lstEmpresasEnter(Sender: TObject);
begin
  inherited;

  If lstEmpresas.Items.Count > 0 Then
    lstEmpresas.Selected[0] := True
  Else
    SelectNext(ActiveControl,True,True);

end;

procedure TfrmRelEstatAnalResult2.pDesmarcaColunas;
  Var
    intIdx: Integer;
    intSel: Integer;
Begin
  intSel := 1;

  For intIdx := 0 To lstEmpresas.Count - 1 Do
  Begin
    If lstEmpresas.Checked[intIdx] Then
    begin
      If intSel >= (intMaxColuna) Then
        lstEmpresas.Checked[intIdx] := False
      Else
        Inc(intSel);
    End;
  End;
End;

procedure TfrmRelEstatAnalResult2.rdgOrientacaoClick(Sender: TObject);
begin
  inherited;

  if strTipImp = 'M' then
    intMaxColuna := MAX_COLUNA_MATRI
  else
  begin
    if (Pos(edtDestino.Text, 'E_') > 0) then
      intMaxColuna := IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_EXCEL, MAX_COLUNA_EXCEL_CONSOL)
    else
      intMaxColuna := IfThen(rdgOrientacao.ItemIndex = 0, IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_RETRA, MAX_COLUNA_RETRA_CONSOL), IfThen(rdgTipOri.ItemIndex = 0, MAX_COLUNA_PAISA, MAX_COLUNA_PAISA_CONSOL));
  end;

  pDesmarcaColunas;

end;

procedure TfrmRelEstatAnalResult2.rdgTipDtaClick(Sender: TObject);
begin
  inherited;

  If (rdgTipDta.ItemIndex = 2) Then
  Begin
    lblDataIni.Caption   := 'Competência Inicial';
    lblDataFin.Caption   := 'Competência Final';
    mskDtaIni.EditMask   := '99/9999;1;_';
    mskDtaFin.EditMask   := '99/9999;1;_';
    mskDtaIni.MaxLength  := 7;
    mskDtaFin.MaxLength  := 7;
    mskDtaIni.ValidaData := False;
    mskDtaFin.ValidaData := False;
    mskDtaIni.Clear();
    mskDtaFin.Clear();
    mskDtaIni.Text       := FormatDateTime('mm/yyyy', VS_Date);
    mskDtaFin.Text       := FormatDateTime('mm/yyyy', VS_Date);
  End
  Else
  Begin
    lblDataIni.Caption   := 'Data Inicial';
    lblDataFin.Caption   := 'Data Final';
    mskDtaIni.EditMask   := '99/99/9999;1;_';
    mskDtaFin.EditMask   := '99/99/9999;1;_';
    mskDtaIni.MaxLength  := 10;
    mskDtaFin.MaxLength  := 10;
    mskDtaIni.ValidaData := True;
    mskDtaFin.ValidaData := True;
    mskDtaIni.Clear();
    mskDtaFin.Clear();
    mskDtaIni.Text       := FormatDateTime('dd/mm/yyyy', VS_Date);
    mskDtaFin.Text       := FormatDateTime('dd/mm/yyyy', VS_Date);
  End;

  If blnRegimeDefinidoNoPlanoDeContas Then
  Begin
    lblCompetIni.Visible := rdgTipDta.ItemIndex = 0;
    mskCompetIni.Visible := rdgTipDta.ItemIndex = 0;
    lblCompetFin.Visible := rdgTipDta.ItemIndex = 0;
    mskCompetFin.Visible := rdgTipDta.ItemIndex = 0;
  End;
end;

procedure TfrmRelEstatAnalResult2.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmRelEstatAnalResult2.btnImprimirClick(Sender: TObject);
Var
  frmAguarde: TfrmGravando;
begin
  inherited;
  If (strTipImp = 'M') And (fContaSelecoes > MAX_COLUNA_MATRI) Then
  Begin
    pMensagemOk('Para impressão em matricial o máximo de lojas permitido é 12!');
    Exit;
  End;

  frmAguarde := nil;

  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
  Except
    frmAguarde := nil;
  End;

  If Not Assigned(frmAguarde) Then
  Begin
    fGerarRelatorio;
    Exit;
  End;

  Try
    frmAguarde.fExecutarAcao := fGerarRelatorio;
    frmAguarde.ShowModal;
  Finally
    pFreeAndNil(frmAguarde);
  End;

end;

procedure TfrmRelEstatAnalResult2.btnImprimirErro(Sender: TWinControl;
  strMsgErro: string; E: Exception);
begin
  inherited;
  pMensagensErro(E.Message, 'TfrmRelEstatAnalResult2.btnImprimirErro');
end;

function TfrmRelEstatAnalResult2.fGerarRelatorio(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    frxRel   : TfrxReport;
    intCont  : Integer;
    strSigla : String;
    qryAux   : TUniQuery;
    lstLista : TStringList;
    strCodCta: String;
    intTamFonte :Integer;
begin
  Result := False;

  FLog.Clear;

  pInformacao('Aguarde, Gerando Relatório ...', pgbStatus);

  qryAux := fCriaQuery(Nil);

  If fRetornaCtaResDuplicado(qryAux) Then
  Begin
    lstLista := TStringList.Create;

    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('     PLANOS DE CONTAS DUPLICADOS NO CADASTRO DE CONTAS RESULTADO     ');
    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('CONTAS RESULTADO   PLANO DE CONTAS   DESCRICAO                       ');
    lstLista.Add('---------------------------------------------------------------------');

    With qryAux Do
    Begin
      First;

      strCodCta := FieldByName('CRE_CODCTA').AsString;

      While Not Eof Do
      Begin
        If FieldByName('CRE_CODCTA').AsString = strCodCta Then
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 30) )
        Else
        Begin
          lstLista.Add(' ');
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 30) );
          strCodCta := FieldByName('CRE_CODCTA').AsString;
        End;

        Next;
      End;

      lstLista.Add(' ');
      lstLista.Add('---------------------------------------------------------------------');
      lstLista.Add('SERA NECESSARIO ACESSAR O MENU DE CADASTROS, AUXILIARES, CONTAS DE   ');
      lstLista.Add('RESULTADO, E EXCLUIR OS REGISTROS DUPLICADOS, DEIXANDO APENAS O      ');
      lstLista.Add('PLANO DE CONTAS DENTRO DE UMA UNICA CONTA DE RESULTADO.              ');
      lstLista.Add('---------------------------------------------------------------------');

    End;

    pCriarFormularios(TfrmMemo, frmMemo);
    Try
      frmMemo.cxMemo.Lines := lstLista;
      frmMemo.ShowModal;
    Finally
      pFreeAndNil(frmMemo);
    End;

    FreeAndNil(qryAux);
    FreeAndNil(lstLista);

    Exit;
  End
  Else
    FreeAndNil(qryAux);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;

  Try

    If blnImprime Then
    Begin

      Try
        btnImprimir.Enabled := False;
        VS_DateFim := StrToDate(fRetDtaFin());

        {****************************************}
        {* REMOVENDO AGGREGATES DA MEMORIA      *}
        {*************************************AF*}
        For intCont := 0 To Length(arrSomatorias) -1  Do
        Begin
          {*******************************************************************}
          {* QUANDO FreeAndNil(arrSomatorias[intCont]) É EXECUTADO, O CDS    *}
          {* ASSOCIADO A arrSomatorias[intCont] É DADO UM REFRESH, COMO ESSE *}
          {* POR SUA VEZ ESTA LIGADO A qryGenerica É EXCUTADO O ÚLTIMO SQL,  *}
          {* O QUE DEIXAVA O SISTEMA LENTO. POR ISSO PASSEI UM SQL PRA VIR   *}
          {*  VAZIO :(                                                       *}
          {****************************************************************VA*}
          qryGenerica.SQL.Text := 'SELECT * FROM CADEMP WHERE FALSE';
          FreeAndNil(arrSomatorias[intCont]);
        End;
        SetLength(arrSomatorias, 0);

        slsEmpresas.Clear;
        slsEmpresas.Add(VS_strCodEmp);
        For intCont := 0 To lstEmpresas.Count - 1 Do
        Begin

          If lstEmpresas.Checked[intCont] Then
            slsEmpresas.Add( LeftStr(lstEmpresas.Items[intCont],3) );

        End;

        pInformacao('Aguarde, Carregando Regime Tributário ...', pgbStatus);
        pCarregaRegimeTributario;

        cdsRelat.EmptyDataSet;

        pInformacao('Aguarde, Definindo Layout do Relatório ...', pgbStatus);

        If (strTipImp = 'M') Then
        Begin
          frxRel := frxQckEstatAnalResult2M;
          TfrxReportPage(frxRel.Pages[1]).PaperWidth := IfThen(rdgOrientacao.ItemIndex = 0, 410, 568);
        End
        Else
        Begin
          frxRel := frxQckEstatAnalResult2J;

          If rdgOrientacao.ItemIndex = 0 Then
            TfrxReportPage(frxRel.Pages[1]).Orientation := poPortrait
          Else
            TfrxReportPage(frxRel.Pages[1]).Orientation := poLandscape;

          If (rdgOrientacao.ItemIndex = 0) Then
          Begin
            TfrxReportPage(frxRel.Pages[1]).PaperWidth  := 315;
            TfrxReportPage(frxRel.Pages[1]).PaperHeight := 397;
          End
          Else
          Begin

            If ((fContaSelecoes + 1) > 12) Then
            Begin
              TfrxReportPage(frxRel.Pages[1]).PaperWidth  := 430 + ((fContaSelecoes + 1 - 12) * 25);
              TfrxReportPage(frxRel.Pages[1]).PaperHeight := 210 + ((fContaSelecoes + 1 - 12) * 12);

              intTamFonte := fCfgSis('FONDRE');

              IF intTamFonte > 10 Then
              Begin
							// HEADER
							TfrxReport(frxRel.FindObject('rllTitDesGru')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllTotal')).Font.Size := intTamFonte;
					    TfrxReport(frxRel.FindObject('rllCabLoj01')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj02')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj03')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj04')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj05')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj06')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj07')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj08')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj09')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj10')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj11')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj12')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj13')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj14')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj15')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj16')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj17')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj18')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj19')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj20')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLoj21')).Font.Size := intTamFonte;

							// DATA
	            TfrxReport(frxRel.FindObject('rllDesCam')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rlbDados')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLojTot')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllPerc')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj001')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj002')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj003')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj004')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj005')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj006')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj007')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj008')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj009')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj010')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj011')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj012')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj013')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj014')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj015')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj016')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj017')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj018')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj019')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj020')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllLoj021')).Font.Size := intTamFonte;

							// PORTADOR - HEADER
							TfrxReport(frxRel.FindObject('rllSalPor')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor01')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor02')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor03')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor04')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor05')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor06')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor07')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor08')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor09')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor10')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor11')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor12')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor13')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor14')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor15')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor16')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor17')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor18')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor19')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor20')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllCabLojPor21')).Font.Size := intTamFonte;

							// PORTADOR - DATA
							TfrxReport(frxRel.FindObject('rllCodPor')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllNomPor')).Font.Size := intTamFonte;
              TfrxReport(frxRel.FindObject('rllDetSalPor')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor001')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor002')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor003')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor004')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor005')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor006')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor007')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor008')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor009')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor010')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor011')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor012')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor013')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor014')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor015')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor016')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor017')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor018')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor019')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor020')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPor021')).Font.Size := intTamFonte;

							// PORTADOR FOOTER
							TfrxReport(frxRel.FindObject('rllTotPor')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllTotSalPor')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot001')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot002')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot003')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot004')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot005')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot006')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot007')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot008')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot009')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot010')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot011')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot012')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot013')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot014')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot015')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot016')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot017')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot018')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot019')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot020')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('rllLojPorTot021')).Font.Size := intTamFonte;

              TfrxReport(frxRel.FindObject('Memo22')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo24')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo25')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo26')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo30')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo31')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo32')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo33')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo34')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo35')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo36')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo38')).Font.Size := intTamFonte;
							TfrxReport(frxRel.FindObject('Memo39')).Font.Size := intTamFonte;
             End;
            End
            Else
            Begin
              TfrxReportPage(frxRel.Pages[1]).PaperWidth  := 430;
              TfrxReportPage(frxRel.Pages[1]).PaperHeight := 210;
            End;

          End;

          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9; //A4

          If rdgExibir.ItemIndex = 0 Then
            TfrxShapeView(frxRel.FindObject('shpCtaRes')).Tag := 0
          Else
            TfrxShapeView(frxRel.FindObject('shpCtaRes')).Tag := 1;

        End;

        If chkSalPor.Checked Then
        Begin
          TfrxMasterData(frxRel.FindObject('rlbDados')).Child      := TfrxChild(frxRel.FindObject('CSalPor'));
          TfrxReportSummary(frxRel.FindObject('rlbSumario')).Child := TfrxChild(frxRel.FindObject('CResFor'));
          TfrxChild(frxRel.FindObject('CSalPor')).Child            := nil;
        End
        Else
        Begin
          TfrxMasterData(frxRel.FindObject('rlbDados')).Child      := nil;
          TfrxReportSummary(frxRel.FindObject('rlbSumario')).Child := TfrxChild(frxRel.FindObject('CSalPor'));
          TfrxChild(frxRel.FindObject('CSalPor')).Child            := TfrxChild(frxRel.FindObject('CResFor'));
        End;

        pInformacao('Aguarde, Carregando Dados ...', pgbStatus);

        Result := fCarregandoDadosRelatorio(pgbStatus);

        pInformacao('Aguarde, Preparando Relatório ...', pgbStatus);

        If Result Then
        Begin
          frxResFor.DataSet := cdsVenFor;
          TfrxChild(frxRel.FindObject('CResFor')).Visible := chkResFor.Checked;

          frxRel.Script.Variables['chkSalPorChecked'] := chkSalPor.Checked;
          frxRel.Script.Variables['intQtdEmp']        := slsEmpresas.Count;
          frxRel.Script.Variables['blnConsolidado']   := rdgTipOri.ItemIndex = 1;
          frxRel.Script.Variables['intTamFonte']   := fCfgSis('FONDRE');

          If edtDestino.Text = 'E' Then
          Begin
            pInformacao('Aguarde, Gerando Arquivo ...', pgbStatus);
            pGeraExcel;
          End
          Else
          Begin

            If (rdgTipOri.ItemIndex = 0) Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllLoj001')).Text := '[frxRelatorio."REL_LOJ001"]';

              For intCont := 1 To slsEmpresas.Count Do
              Begin
                TfrxMemoView(frxRel.FindObject('rllCabLoj' + fStrZero(intCont,2))).Visible := True;

                strSigla := fRetSiglaEmpresa(slsEmpresas[intCont-1]);

                If fEmptyStr(strSigla) Then
                  strSigla := 'LOJA-' + slsEmpresas[intCont-1];

                TfrxMemoView(frxRel.FindObject('rllCabLoj' + fStrZero(intCont,2))).Text := strSigla;

                TfrxMemoView(frxRel.FindObject('rllLoj' + fStrZero(intCont,3))).Visible := True;

                //PORTADOR
                TfrxMemoView(frxRel.FindObject('rllCabLojPor' + fStrZero(intCont,2))).Visible := True;
                strSigla := fRetSiglaEmpresa(slsEmpresas[intCont-1]);

                If fEmptyStr(strSigla) Then
                  strSigla := 'LOJA-' + slsEmpresas[intCont-1];

                TfrxMemoView(frxRel.FindObject('rllCabLojPor' + fStrZero(intCont,2))).Text := strSigla;
                TfrxMemoView(frxRel.FindObject('rllLojPor' + fStrZero(intCont,3))).Visible := True;
                TfrxMemoView(frxRel.FindObject('rllLojPorTot' + fStrZero(intCont,3))).Visible := True;
              End;
          End
          Else
          Begin
            For intCont := 2 To IfThen(strTipImp = 'M', MAX_COLUNA_MATRI, MAX_COLUNA_PAISA) Do
            Begin
              TfrxMemoView(frxRel.FindObject('rllCabLoj' + fStrZero(intCont,2))).Visible := False;
              TfrxMemoView(frxRel.FindObject('rllLoj' + fStrZero(intCont,3))).Visible    := False;

                TfrxMemoView(frxRel.FindObject('rllCabLojPor' + fStrZero(intCont,2))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLojPor' + fStrZero(intCont,3))).Visible    := False;
                TfrxMemoView(frxRel.FindObject('rllLojPorTot' + fStrZero(intCont,3))).Visible := False;
              End;

              TfrxMemoView(frxRel.FindObject('rllCabLoj01')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllLoj001')).Text      := '';

              TfrxMemoView(frxRel.FindObject('rllCabLoj01')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rllLoj001')).Visible   := True;

              TfrxMemoView(frxRel.FindObject('rllCabLojPor01')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllLojPor001')).Text      := '';
              TfrxMemoView(frxRel.FindObject('rllLojPorTot001')).Text   := '';

              TfrxMemoView(frxRel.FindObject('rllCabLojPor01')).Visible  := True;
              TfrxMemoView(frxRel.FindObject('rllLojPor001')).Visible    := True;
              TfrxMemoView(frxRel.FindObject('rllLojPorTot001')).Visible := True;
            End;

            frxRel.Script.Variables['NOMREL']  := 'RELATORIO DE ANALISE DE RESULTADO (CONTAS A PAGAR) / DRE';
            frxRel.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(fRetDtaIni())) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(fRetDtaFin()));
            frxRel.Script.Variables['PARAM1']  := 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text;
            frxRel.Script.Variables['PARAM2']  := '';

            If (rdgSalPor.ItemIndex = 0) Then
              frxRel.Script.Variables['SALPOR'] := 'SALDO DE PORTADORES: SOMENTE REGISTROS CONCILIADOS'
            Else
              frxRel.Script.Variables['SALPOR'] := 'SALDO DE PORTADORES: TODOS OS REGISTROS';

            If (rdgEmpresa.ItemIndex = 0) Then
              frxRel.Script.Variables['EMPRESA'] := 'EMPRESA DE FATURAMENTO'
            Else
              frxRel.Script.Variables['EMPRESA'] := 'EMPRESA DE ORIGEM';

            If edtDestino.Text = 'V' Then
            Begin
              SetForegroundWindow(Handle);
              pInformacao('Aguarde, Exibindo Relatório ...', pgbStatus);
              pPreviewReport(Self.Name, Self.Caption, frxRel);
            End
            Else
            Begin
              pInformacao('Aguarde, Imprimindo Relatório ...', pgbStatus);
              If frxRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
            End;

            If (rdgTipOri.ItemIndex = 0) Then
            Begin
              For intCont := 1 To slsEmpresas.Count Do
              Begin
                TfrxMemoView(frxRel.FindObject('rllCabLoj' + fStrZero(intCont,2))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLoj' + fStrZero(intCont,3))).Visible := False;

                TfrxMemoView(frxRel.FindObject('rllCabLojPor' + fStrZero(intCont,2))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLojPor' + fStrZero(intCont,3))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLojPorTot' + fStrZero(intCont,3))).Visible := False;
              End;
            End;

          End;
        End;

        pInformacao('Aguarde, Finalizando ...', pgbStatus);

      Except
        On E: Exception Do
          pMensagensErro(E.Message, 'TfrmRelEstatAnalResult2.fGerarRelatorio', FLog.Text);
      End;
    End;

  Finally
    If Assigned(qryEmpTri) Then
      FreeAndNil(qryEmpTri);

    blnExecqryJurDes := True;
	  blnExecqryJDDedChq := True;
	  blnExecqryJDResChq := True;
	  blnExecqryJDAgru := True;
	  blnExecqryJDAgruChqDeducao := True;
	  blnExecqryJDAgruChqReintegracao := True;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);
  End;

  If Result Then
    pMensagemOk('Relatório gerado com sucesso!');
end;

{****************************************}
{* CARREGA CONTAS DO TIPO 1, 2 e 4      *}
{*************************************AF*}
procedure TfrmRelEstatAnalResult2.pCarregaCTP124;

  function fRetValorCTP124(blnFator: Boolean) : String;
  begin
    If blnRegimeDefinidoNoPlanoDeContas Then
      Result := ' SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG) '+ IIF(blnFator, '* C.CTP_FATCAL', '') +') AS CTP_VALPAG '
    Else
    Begin
      If (rdgTipDta.ItemIndex In [1, 2]) Then
        Result := ' SUM(P.CTP_VALORI '+ IIF(blnFator, '* C.CTP_FATCAL', '') +') AS CTP_VALPAG '
      Else
        Result := ' SUM(P.CTP_VALPAG '+ IIF(blnFator, '* C.CTP_FATCAL', '') +') AS CTP_VALPAG ';
    End;
  end;
  
  Var
    strSQL: String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CONCAT(SUBSTR(P.CTP_CODCTA,1,2),".",SUBSTR(P.CTP_CODCTA,3,2),".",SUBSTR(P.CTP_CODCTA,5,3)) AS CODCTA, ';
    strSQL := strSQL + '  P.CTP_CODEMP, ';
    strSQL := strSQL + '  CTA_TIPCTA, ';
    strSQL := strSQL + '  P.CTP_CODCTA, ';
    strSQL := strSQL + '  CTA_DESCTA, ';
    strSQL := strSQL + fRetValorCTP124(False);
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  INNER JOIN CADCTA ON CTA_CODCTA = P.CTP_CODCTA AND CTA_TIPCTA <> "3" ';
    strSQL := strSQL + '  LEFT  JOIN CTPDET C ON P.CTP_CODFOR = C.CTP_CODFOR AND P.CTP_NUMDUP = C.CTP_NUMDUP AND ';
    strSQL := strSQL + '                         P.CTP_PARCEL = C.CTP_PARCEL AND P.CTP_CODEMP = C.CTP_EMPORI AND ';
    strSQL := strSQL + '                       ((P.CTP_SERIE_ = C.CTP_SERIE_) OR ';
    strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((C.CTP_SERIE_ IS NULL) OR (C.CTP_SERIE_ = "")))) ';
    strSQL := strSQL + 'WHERE ';

    If blnRegimeDefinidoNoPlanoDeContas Then
    Begin
      If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
      Else
      Begin
        strSQL := strSQL + ' IF(CTA_REGDRE = 2, ';
        strSQL := strSQL + '    P.CTP_COMPET IN (' + fRetCompet(mskCompetIni.Text, mskCompetFin.Text) + '), ';
        strSQL := strSQL + '    P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
        strSQL := strSQL + ' ) AND ';
      End;
    End
    Else
    Begin
      If (rdgTipDta.ItemIndex = 2) Then
        strSQL := strSQL + '  P.CTP_COMPET IN (' + fRetCompet(mskDtaIni.Text, mskDtaFin.Text) + ') AND '
      Else If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
      Else
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND ';
    End;

    strSQL := strSQL + '  IF(C.CTP_CODCTA IS NULL, P.CTP_CODEMP, C.CTP_CODEMP) IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  C.CTP_CODCTA IS NULL ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  P.CTP_CODCTA, ';
    strSQL := strSQL + '  P.CTP_CODEMP  ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CONCAT(SUBSTR(C.CTP_CODCTA,1,2),".",SUBSTR(C.CTP_CODCTA,3,2),".",SUBSTR(C.CTP_CODCTA,5,3)) AS CODCTA, ';
    strSQL := strSQL + '  C.CTP_CODEMP, ';
    strSQL := strSQL + '  B.CTA_TIPCTA, ';
    strSQL := strSQL + '  C.CTP_CODCTA, ';
    strSQL := strSQL + '  B.CTA_DESCTA, ';
    strSQL := strSQL + fRetValorCTP124(True);
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  INNER JOIN CTPDET C ON P.CTP_CODFOR = C.CTP_CODFOR AND P.CTP_NUMDUP = C.CTP_NUMDUP AND ';
    strSQL := strSQL + '                         P.CTP_PARCEL = C.CTP_PARCEL AND P.CTP_CODEMP = C.CTP_EMPORI AND ';
    strSQL := strSQL + '                       ((P.CTP_SERIE_ = C.CTP_SERIE_) OR ';
    strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((C.CTP_SERIE_ IS NULL) OR (C.CTP_SERIE_ = "")))) ';
    strSQL := strSQL + '  INNER JOIN CADCTA B ON B.CTA_CODCTA = C.CTP_CODCTA AND B.CTA_TIPCTA <> "3" ';
    strSQL := strSQL + 'WHERE ';

    If blnRegimeDefinidoNoPlanoDeContas Then
    Begin
      If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
      Else
      Begin
        strSQL := strSQL + ' IF(CTA_REGDRE = 2, ';
        strSQL := strSQL + '    P.CTP_COMPET IN (' + fRetCompet(mskCompetIni.Text, mskCompetFin.Text) + '), ';
        strSQL := strSQL + '    P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
        strSQL := strSQL + ' ) AND ';
      End;
    End
    Else
    Begin
      If (rdgTipDta.ItemIndex = 2) Then
        strSQL := strSQL + '  P.CTP_COMPET IN (' + fRetCompet(mskDtaIni.Text, mskDtaFin.Text) + ') AND '
      Else If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
      Else
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND ';
    End;

    strSQL := strSQL + '  IF(C.CTP_CODCTA IS NULL, P.CTP_CODEMP, C.CTP_CODEMP) IN (' + fEmpSelecionadas(True) + ') ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  C.CTP_CODCTA, ';
    strSQL := strSQL + '  C.CTP_CODEMP  ';

    strSQL := 'SELECT SQL_NO_CACHE CODCTA, CTP_CODEMP, CTA_TIPCTA, CTP_CODCTA, CTA_DESCTA, SUM(CTP_VALPAG) AS CTP_VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CTP_CODCTA, CTP_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(FindParam('DTAINI')) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(fRetDtaIni());
        ParamByName('DTAFIN').AsDate := StrToDate(fRetDtaFin());
      End;

      cdsCta124.Close;
      cdsCta124.SetProvider(cpvCta124);
      cpvCta124.DataSet := qryGenerica;
      cdsCta124.AggregatesActive := True;

      {****************************************}
      {* CRIANDO CAMPO AGGREGATES PARA TOTAL  *}
      {*************************************AF*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'CTP_TOTPAG';
        FieldName     := 'CTP_TOTPAG';
        DataSet       := cdsCta124;
        Expression    := 'SUM(CTP_VALPAG)';
        DisplayFormat := '#,##0.00';
        Active        := True;
      End;

      cdsCta124.Open;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

{*************************************}
{* CARREGA CENTRO DE CUSTOS (CTARES) *}
{**********************************AF*}
procedure TfrmRelEstatAnalResult2.pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
  FLog.Add(DateTimeToStr(fNow) + ' - ' + strInfo);
end;

procedure TfrmRelEstatAnalResult2.pInsereCentroCustos(strCodEve, strCodCre: String; fltTotVen: Double);
  Var
    strSQL   : String;
    strCta   : String;
    strEmp   : String;
    intCont  : Integer;
    fltTotCus: Double;
    qryGenGer: TUniQuery;
    cdsAuxDet: TUniClientDataSet;
    cdsCtaDet: TUniClientDataSet;
    cpvCtaDet: TUniDataSetProvider;

    strSQLDet: String;
    strSQLGer: String;

  function fFormataConta(strCodCta: String): String;
  begin
    Result := Copy(strCodCta, 1, 2) + '.' +
              Copy(strCodCta, 3, 2) + '.' +
              Copy(strCodCta, 5, 3);
  end;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 2;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CONTAS DE RESULTADO';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInserePercentualDespesa(strCta: String);
    Var
      intCont  : Integer;
      fltTotDes,
      fltTotVen: Double;
  begin
    pIniciaInsercao('PERDES','');

    fltTotDes := 0;
    fltTotVen := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaDet.Filtered := False;
      cdsCtaDet.Filter   := 'CODCTA = ' + QuotedStr(strCta) + ' AND CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsCtaDet.Filtered := True;

      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;

      If (cdsCtaDet.FieldByName('VALPAG').AsFloat = Null) Or
         (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null) Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (cdsCtaDet.FieldByName('VALPAG').AsFloat * 100) / TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      If Not (cdsCtaDet.FieldByName('VALPAG').AsFloat = Null) Then
        fltTotDes := fltTotDes + cdsCtaDet.FieldByName('VALPAG').AsFloat;

      If Not (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null) Then
        fltTotVen := fltTotVen + TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;
    End;

    If (fltTotVen = 0) Or (fltTotDes = 0) Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotDes * 100) / fltTotVen;

    cdsRelat.Post;
  end;

begin

  Try
    QryGenGer := fCriaQuery(Nil);

    cdsAuxDet := TUniClientDataSet.Create(Nil);
    cdsAuxDet.DisableControls;

    cdsCtaDet := TUniClientDataSet.Create(Self);
    cpvCtaDet := TUniDataSetProvider.Create(Self);
    cdsCtaDet.DisableControls;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CODEMP, ';
    strSQL := strSQL + '  C.CTA_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA AS DESCTA, ';
    strSQL := strSQL + '  VALOR        AS VALPAG  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
    strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
    strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
    strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
    strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = ABRV ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + 'WHERE ';

    If blnRegimeDefinidoNoPlanoDeContas Then
    Begin
      If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND '
      Else
      Begin
        strSQL := strSQL + ' IF(CTA_REGDRE = 2, ';
        strSQL := strSQL + '    P.CTP_COMPET IN (' + fRetCompet(mskCompetIni.Text, mskCompetFin.Text) + '), ';
        strSQL := strSQL + '    P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
        strSQL := strSQL + ' ) AND ';
      End;
    End
    Else
    Begin
      If (rdgTipDta.ItemIndex = 2) Then
        strSQL := strSQL + '  P.CTP_COMPET IN (' + fRetCompet(mskDtaIni.Text, mskDtaFin.Text) + ') AND '
      Else
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND ';
    End;

    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  R.CRE_CODCRE =:CODCRE ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    If not fEmptyStr(strCodEve) Then
    Begin
      If chkListaDesmembramento.Checked Then
      Begin
        If strCodEve = SEM_EVENTO Then
          strSQL := strSQL + '  AND D.CTP_CODEVE IS NULL '
        Else
           strSQL := strSQL + '  AND IF(D.CTP_CODEVE IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) = :CODEVE ';
      End
      Else
      Begin
        If strCodEve = SEM_EVENTO Then
          strSQL := strSQL + '  AND P.CTP_CODEVE IS NULL '
        Else
           strSQL := strSQL + '  AND P.CTP_CODEVE = :CODEVE ';
      End;
    End;

    If rdgTipDta.ItemIndex = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQl, 'P.CTP_DTAPAG', 'P.CTP_DTACAD');
      strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL,'VALOR','SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
      strSQLDet := AnsiReplaceStr(strSQLDet, 'C.CTA_CODCTA AS CODCTA', 'D.CTP_CODCTA AS CODCTA');
      strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
      strSQLDet := strSQLDet + 'GROUP BY CODCTA, CODEMP ';

      strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'),'VALOR','SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                ' AND D.CTP_CODCTA IS NULL GROUP BY CODCTA, CODEMP ';
    End
    Else
    Begin
      If blnRegimeDefinidoNoPlanoDeContas Then
      Begin
        strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG) * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
        strSQLDet := AnsiReplaceStr(strSQLDet, 'C.CTA_CODCTA AS CODCTA', 'D.CTP_CODCTA AS CODCTA');
        strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
        strSQLDet := strSQLDet + 'GROUP BY CODCTA, CODEMP ';

        strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG))'), 'ABRV', 'C.CTA_CODCTA') +
                  ' AND D.CTP_CODCTA IS NULL GROUP BY CODCTA, CODEMP ';
      End
      Else
      Begin
        If (rdgTipDta.ItemIndex = 0) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALPAG * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'C.CTA_CODCTA AS CODCTA', 'D.CTP_CODCTA AS CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALPAG)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODCTA, CODEMP ';
        End
        Else If (rdgTipDta.ItemIndex = 2) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'C.CTA_CODCTA AS CODCTA', 'D.CTP_CODCTA AS CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODCTA, CODEMP ';
        End;
      End;
    End;

    strSQL := strSQLDet + ' UNION ALL ' + strSQLGer;

    strSQL := 'SELECT CODEMP, CODCTA, DESCTA, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODCTA, CODEMP ';
    strSQL := strSQL + 'ORDER BY CODCTA ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(FindParam('DTAINI')) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(fRetDtaIni());
        ParamByName('DTAFIN').AsDate := StrToDate(fRetDtaFin());
      End;

      ParamByName('CODCRE').AsString := strCodCre;
      If (not fEmptyStr(strCodEve)) and (strCodEve <> SEM_EVENTO) Then
        ParamByName('CODEVE').AsString := strCodEve;

      cdsCtaDet.Close;
      cpvCtaDet.DataSet := qryGenGer;
      cdsCtaDet.SetProvider(cpvCtaDet);

      cdsCtaDet.Open;

      strEmp := '';
      For intCont := 1 To slsEmpresas.Count Do
        strEmp := strEmp + QuotedStr(slsEmpresas[intCont-1]) + ', ';

      strEmp := LeftStr(strEmp, Length(strEmp) - 2);

      strCta := '';
      cdsAuxDet.Filter := '';
      cdsAuxDet.Data   := cdsCtaDet.Data;

      While Not cdsAuxDet.Eof Do
      Begin

        If strCta = cdsAuxDet.FieldByName('CODCTA').AsString Then
        Begin
          cdsAuxDet.Next;
          Continue;
        End;

        fltTotCus := 0.0;
        pIniciaInsercao('CTADET','    ' + fFormataConta(cdsAuxDet.FieldByName('CODCTA').AsString) + '-' + cdsAuxDet.FieldByName('DESCTA').AsString);
        strCta := cdsAuxDet.FieldByName('CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCtaDet.Filtered := False;
          cdsCtaDet.Filter   := 'CODCTA = ' + QuotedStr(cdsAuxDet.FieldByName('CODCTA').AsString) + ' AND CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
          cdsCtaDet.Filtered := True;
          
          If cdsCtaDet.FieldByName('VALPAG').Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsCtaDet.FieldByName('VALPAG').AsFloat;
            
          fltTotCus := fltTotCus + cdsCtaDet.FieldByName('VALPAG').AsFloat;
        End;

        If fltTotVen = 0 Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;

        cdsRelat.Post;

        If (chkPerDes.Checked) Then
          pInserePercentualDespesa(strCta);

        cdsAuxDet.Next;
      End;

    End;

    FreeAndNil(QryGenGer);
    FreeAndNil(cdsAuxDet);
    FreeAndNil(cdsCtaDet);
    FreeAndNil(cpvCtaDet);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

End;

procedure TfrmRelEstatAnalResult2.pInsereEvento(strCodCre: String; fltTotVen: Double);
  Var
    strSQL   : String;
    strSQLRec : String;
    strCodEve: String;
    strEmp   : String;
    intCont  : Integer;
    fltTotCus: Double;
    fltTotCom: Double;
    qryGenGer: TUniQuery;
    qryComissao: TUniQuery;
    cdsAuxDet: TUniClientDataSet;
    cdsCtaDet: TUniClientDataSet;
    cpvCtaDet: TUniDataSetProvider;

    strSQLDet: String;
    strSQLGer: String;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 2;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'CONTAS DE RESULTADO';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

Begin
  Try
    qryGenGer := fCriaQuery(Nil);

    cdsAuxDet := TUniClientDataSet.Create(Nil);
    cdsAuxDet.DisableControls;

    cdsCtaDet := TUniClientDataSet.Create(Self);
    cpvCtaDet := TUniDataSetProvider.Create(Self);
    cdsCtaDet.DisableControls;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  E.EVE_CODEVE AS CODEVE, ';
    strSQL := strSQL + '  C.CTA_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  R.CRE_CODCRE AS CODCRE, ';
    strSQL := strSQL + '  CONCAT(E.EVE_CODEVE, "-", E.EVE_DESEVE) AS DESEVE, ';
    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) AS CODEMP, ';
    strSQL := strSQL + '  VALOR AS VALPAG ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  	strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
    strSQL := strSQL + '                        ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
    strSQL := strSQL + '                        (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';

    If chkListaDesmembramento.Checked Then
      strSQL := strSQL + '  LEFT JOIN CADEVE E ON IF(D.CTP_CODEVE IS NULL, P.CTP_CODEVE = E.EVE_CODEVE,  D.CTP_CODEVE = E.EVE_CODEVE) '
    Else
      strSQL := strSQL + '  LEFT JOIN CADEVE E ON  P.CTP_CODEVE = E.EVE_CODEVE ';

    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
    strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = ABRV ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + 'WHERE ';

    If blnRegimeDefinidoNoPlanoDeContas Then
    Begin
      If (rdgTipDta.ItemIndex = 1) Then
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND '
      Else
      Begin
        strSQL := strSQL + ' IF(CTA_REGDRE = 2, ';
        strSQL := strSQL + '    P.CTP_COMPET IN (' + fRetCompet(mskCompetIni.Text, mskCompetFin.Text) + '), ';
        strSQL := strSQL + '    P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
        strSQL := strSQL + ' ) AND ';
      End;
    End
    Else
    Begin
      If (rdgTipDta.ItemIndex = 2) Then
        strSQL := strSQL + '  P.CTP_COMPET IN (' + fRetCompet(mskDtaIni.Text, mskDtaFin.Text) + ') AND '
      Else
        strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN AND ';
    End;

    strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP) IN (' + fEmpSelecionadas(True) + ') AND ';
    strSQL := strSQL + '  R.CRE_CODCRE = :CODCRE ';

    if not blnIncDupCliForFil then
      strSQL := strSQL + '  AND NOT LOCATE(P.CTP_CODFOR,"' + fRetForFilialTodos() + '") ';

    If rdgTipDta.ItemIndex = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQl, 'P.CTP_DTAPAG', 'P.CTP_DTACAD');
//      strSQL := strSQL + ' AND P.CTP_DTAPAG IS NOT NULL ';
      strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL,'VALOR','SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
      strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
      strSQLDet := strSQLDet + 'GROUP BY CODEVE, CODCTA, CODEMP ';

      strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'),'VALOR','SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                ' AND D.CTP_CODCTA IS NULL GROUP BY CODEVE, CODEMP ';
    End
    Else
    Begin
      If blnRegimeDefinidoNoPlanoDeContas Then
      Begin
        strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG) * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
        strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
        strSQLDet := strSQLDet + 'GROUP BY CODEVE, CODCTA, CODEMP ';

        strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(IF(CTA_REGDRE = 2, P.CTP_VALORI, P.CTP_VALPAG))'), 'ABRV', 'C.CTA_CODCTA') +
                  ' AND D.CTP_CODCTA IS NULL GROUP BY CODEVE, CODEMP ';
      End
      Else
      Begin
        If (rdgTipDta.ItemIndex = 0) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALPAG * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODEVE, CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALPAG)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODEVE, CODEMP ';
        End
        Else If (rdgTipDta.ItemIndex = 2) Then
        Begin
          strSQLDet := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'VALOR', 'SUM(P.CTP_VALORI * D.CTP_FATCAL)'), 'ABRV', 'D.CTP_CODCTA');
          strSQLDet := AnsiReplaceStr(strSQLDet, 'P.CTP_CODCTA = C.CTA_CODCTA', 'D.CTP_CODCTA = C.CTA_CODCTA');
          strSQLDet := strSQLDet + 'GROUP BY CODEVE, CODCTA, CODEMP ';

          strSQLGer := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'INNER', 'LEFT'), 'VALOR', 'SUM(P.CTP_VALORI)'), 'ABRV', 'C.CTA_CODCTA') +
                    ' AND D.CTP_CODCTA IS NULL GROUP BY CODEVE, CODEMP ';
        End;
      End;
    End;

    strSQL := strSQLDet + ' UNION ALL ' + strSQLGer;

    strSQL := 'SELECT CODEVE, DESEVE, CODCRE, CODEMP, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODEVE, CODCTA, CODEMP ';
    strSQL := strSQL + 'ORDER BY IFNULL(CODEVE, 99999) ';

    if fCfgSis('TCOPRO') = 2 then
    begin
      if strCodCre = fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')]) then
      begin
        if not fCfgSis('ECPDRE', varBoolean) then
        begin
          qryComissao := fCriaQuery;

          strSQLRec :=             ' SELECT SUM(CTR_VALREC * - 1) AS VALREC FROM ';
          strSQLRec := strSQLRec + '   (SELECT DISTINCT CTR_VALREC, CTR_CODCLI, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP ';
          strSQLRec := strSQLRec + '   FROM CADREC ';
          strSQLRec := strSQLRec + '   JOIN CADDIV D ON D.DIV_CODCLI = CTR_CODCLI ';
          strSQLRec := strSQLRec + '  WHERE CTR_ESPDOC = "CC" ';
          strSQLRec := strSQLRec + '    AND IFNULL(CTR_DOCDIV,"") <> "" ';
          strSQLRec := strSQLRec + '    AND CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
          strSQLRec := strSQLRec + '    AND LOCATE(CTR_CTABAI, :CTABAI) ';

          if not blnIncDupCliForFil then
            strSQLRec := strSQLRec + '    AND CTR_CODCLI NOT IN (' + VS_strCliFil + ') ';

          strSQLRec := strSQLRec + '    AND CTR_CODEMP = :CODEMP) AS TAB';

          qryComissao.SQL.Clear;
          qryComissao.SQL.Add(strSQLRec);
        end;
      end;
    end;

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(FindParam('DTAINI')) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(fRetDtaIni());
        ParamByName('DTAFIN').AsDate := StrToDate(fRetDtaFin());
      End;

      ParamByName('CODCRE').AsString := strCodCre;

      cdsCtaDet.Close;
      cpvCtaDet.DataSet := qryGenGer;
      cdsCtaDet.AggregatesActive := True;
      cdsCtaDet.SetProvider(cpvCtaDet);

      cdsCtaDet.Open;

      strEmp := '';
      For intCont := 1 To slsEmpresas.Count Do
        strEmp := strEmp + QuotedStr(slsEmpresas[intCont-1]) + ', ';

      strEmp := LeftStr(strEmp, Length(strEmp) - 2);

      strCodEve := '<VAZIO>';
      cdsAuxDet.Filter := '';
      cdsAuxDet.Data   := cdsCtaDet.Data;

      While Not cdsAuxDet.Eof Do
      Begin

        If strCodEve = cdsAuxDet.FieldByName('CODEVE').AsString Then
        Begin
          cdsAuxDet.Next;
          Continue;
        End;

        strCodEve := cdsAuxDet.FieldByName('CODEVE').AsString;
        fltTotCus := 0;
        pIniciaInsercao('CTAEVE', '  ' + IfThen(fEmptyStr(strCodEve), SEM_EVENTO, cdsAuxDet.FieldByName('DESEVE').AsString));

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCtaDet.Filtered := False;
          If fEmptyStr(strCodEve) Then
            cdsCtaDet.Filter := 'CODEVE IS NULL AND CODEMP = '+ QuotedStr(slsEmpresas[intCont-1])
          Else
            cdsCtaDet.Filter := 'CODEVE = ' + QuotedStr(strCodEve) + ' AND CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
            
          cdsCtaDet.Filtered := True;

          fltTotCom := 0;
          if fCfgSis('TCOPRO') = 2 then
          begin
            if strCodCre = fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')]) then
            begin
              if not fCfgSis('ECPDRE', varBoolean) then
              begin
                qryComissao.Close;
                qryComissao.ParamByName('DTAINI').AsDateTime := StrToDate(fRetDtaIni());
                qryComissao.ParamByName('DTAFIN').AsDateTime := StrToDate(fRetDtaFin());
                qryComissao.ParamByName('CODEMP').AsString   := slsEmpresas[intCont -1];
                qryComissao.ParamByName('CTABAI').AsString   := fCfgSis('CTARCX') + '_' + fCfgSis('COMRCX');
                qryComissao.Open;
                qryComissao.First;
                while not qryComissao.Eof do
                begin
                  fltTotCom := fltTotCom + qryComissao.FieldByName('VALREC').AsFloat;
                  qryComissao.Next;
                end;
              end;
            end;
          end;

          If cdsCtaDet.FieldByName('VALPAG').Value = Null Then
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0 + fltTotCom
          Else
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsCtaDet.FieldByName('VALPAG').AsFloat + fltTotCom;
            
          fltTotCus := fltTotCus + cdsCtaDet.FieldByName('VALPAG').AsFloat + fltTotCom;
        End;

        If fltTotVen = 0 Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0
        Else
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltTotCus/fltTotVen) * 100;

        cdsRelat.Post;

        pInsereCentroCustos(IfThen(fEmptyStr(strCodEve), SEM_EVENTO, strCodEve), strCodCre, fltTotVen);

        cdsAuxDet.Next;
      End;

    End;

    FreeAndNil(qryGenGer);
    FreeAndNil(cdsAuxDet);
    FreeAndNil(cdsCtaDet);
    FreeAndNil(cpvCtaDet);

    if fCfgSis('TCOPRO') = 2 then
      if strCodCre = fCampoTabela('CRE_CODCRE', 'CTARES', ['CRE_CODCTA'], [fCfgSis('COMRCX')]) then
        if not fCfgSis('ECPDRE', varBoolean) then
          FreeAndNil(qryComissao);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

End;

procedure TfrmRelEstatAnalResult2.pProgresso(intProgresso, intMaximo: Integer;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmRelEstatAnalResult2.pGeraExcel;
  var
    arrSintetico: Array [1..99] Of Array [1..2] Of String;
    arrSalPortad: Array [1..99] Of Array [1..2] Of String;
    arrResFornec: Array [1..11] Of Array [1..2] Of String;

    intCont  : Integer;
    intAux   : Integer;
    intAuxP  : Integer;
    intQtdCol: Integer;
    fltTotal : Double;
    fltPesLit: Double;
    fltTotVis: Double;
    fltTotPrz: Double;
    fltTotCus: Double;
    fltTotVen: Double;
    strUltCol: String;
    strLinAnt: String;
    objExcel : TExcel;
    strSigla : String;
    fltTotPor: Double;
    fltTotPorGer: Double;
begin

  arrSintetico[01][01] := 'REL_DESGRU';
  intAux := 0;
  For intCont := 1 To slsEmpresas.Count Do
  Begin
    strSigla := fRetSiglaEmpresa(slsEmpresas[intCont-1]);

    If fEmptyStr(strSigla) Then
      strSigla := 'LOJA-' + slsEmpresas[intCont-1];

    arrSintetico[intCont+1][01] := strSigla;
    arrSintetico[intCont+1][02] := 'REL_LOJ0' + fStrZero(intCont,2);

    intAux := intCont;
  End;

  Inc(intAux);
  arrSintetico[01][02] := 'REL_DESCAM';

  Inc(intAux);
  arrSintetico[intAux][01] := 'TOTAL';
  arrSintetico[intAux][02] := 'REL_TOTAL';

  Inc(intAux);
  arrSintetico[intAux][02] := 'REL_MARGEM';

  arrSalPortad[01][01] := 'SALDO DE PORTADORES';
  arrSalPortad[01][02] := 'POR_CODPOR';

  arrSalPortad[02][01] := '';
  arrSalPortad[02][02] := 'POR_NOMPOR';

  intAuxP := 0;
  For intCont := 1 To slsEmpresas.Count Do
  Begin
    strSigla := fRetSiglaEmpresa(slsEmpresas[intCont-1]);

    If fEmptyStr(strSigla) Then
      strSigla := 'LOJA-' + slsEmpresas[intCont-1];

    arrSalPortad[intCont+1][01] := strSigla;
    arrSalPortad[intCont+1][02] := 'REL_LOJ0' + fStrZero(intCont,2);

    intAuxP := intCont;
  End;

  Inc(intAuxP);
  Inc(intAuxP);
  arrSalPortad[intAuxP][01] := 'TOTAL';
  arrSalPortad[intAuxP][02] := 'TOTAL';

  arrResFornec[01][01] := 'FORNECEDOR';
  arrResFornec[02][01] := 'LITROS/KILOS';
  arrResFornec[03][01] := 'PRAZO MEDIO';
  arrResFornec[04][01] := 'FAT. A VISTA';
  arrResFornec[05][01] := '%';
  arrResFornec[06][01] := 'FAT. A PRAZO';
  arrResFornec[07][01] := '%';
  arrResFornec[08][01] := 'TOT. CUSTO';
  arrResFornec[09][01] := 'MARGEM';
  arrResFornec[10][01] := '% REP.';
  arrResFornec[11][01] := '% ACUM.';

  arrResFornec[01][02] := 'CODFOR';
  arrResFornec[02][02] := 'PESLIT';
  arrResFornec[03][02] := 'PRZMED';
  arrResFornec[04][02] := 'TOTVIS';
  arrResFornec[05][02] := 'PERVIS';
  arrResFornec[06][02] := 'TOTPRZ';
  arrResFornec[07][02] := 'PERPRZ';
  arrResFornec[08][02] := 'TOTCUS';
  arrResFornec[09][02] := 'MARGEM';
  arrResFornec[10][02] := 'PERREP';
  arrResFornec[11][02] := 'PERACU';

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    //PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    LinhaAtual := 1;
    intQtdCol  := intAux;
    strUltCol  := fGetLetraAlfa(intQtdCol);

    pnlInfo.Caption       := 'Aguarde... Gerando Arquivo!';

    Escrever(ProximaLinha,01, fRetNomeEmpresa);
    Escrever(ProximaLinha,01, 'RELATORIO DE ANALISE DE RESULTADO (CONTAS A PAGAR) / DRE');
    Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(fRetDtaIni())) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(fRetDtaFin())));
    Escrever(ProximaLinha,01, 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text);

    If (rdgSalPor.ItemIndex = 0) Then
      Escrever(ProximaLinha,01, 'SALDO DE PORTADORES: SOMENTE REGISTROS CONCILIADOS')
    Else
      Escrever(ProximaLinha,01, 'SALDO DE PORTADORES: TODOS OS REGISTROS');

    With cdsRelat Do
    Begin

      For intCont := 1 To LinhaAtual Do
      Begin
        Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
      End;

      CorFundo('A2', strUltCol + '3', Cinza);
      Bordas('A2', strUltCol + '3',True,True,True,True);

      First;

      While Not Eof Do
      Begin

        strLinAnt := FieldByName('REL_CODREL').AsString;

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin
          If intCont = 1 Then
               Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont, 01]).AsString)
          Else
          Begin
            If ((FieldByName('REL_CODCAM').AsString = 'ACREDES') Or
               (FieldByName('REL_CODCAM').AsString = 'ACREFIN')) And
               (arrSintetico[intCont][02] = 'REL_MARGEM') Then
              Escrever(LinhaAtual, intCont, '% SOBRE PR.TAB')
            Else
              Escrever(LinhaAtual, intCont, arrSintetico[intCont, 01]);
          End;

          Negrito(LinhaAtual, intCont, True);

          If FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat Then
            Alinhamento(LinhaAtual,intCont, Direita)
          Else
            Alinhamento(LinhaAtual,intCont, Esquerda);

        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        While (Not Eof) And (FieldByName('REL_CODREL').AsString = strLinAnt) Do
        Begin

          ProximaLinha;

          If FieldByName('REL_CODCAM').AsString = '***' Then
          Begin
            CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);
          End
          Else
          Begin

            For intCont := 1 To intQtdCol Do
            Begin

              If arrSintetico[intCont, 02] = 'REL_TOTAL' Then
              Begin
                If FieldByName('REL_CALTOT').AsBoolean Then
                  fltTotal := FieldByName('REL_TOTAL').AsFloat
                Else
                Begin
                  fltTotal := 0;

                  For intAux := 1 to slsEmpresas.Count Do
                    fltTotal := fltTotal + FieldByName('REL_LOJ0' + fStrZero(intAux,2)).AsFloat;
                End;

                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PERDES') > 0 Then
                Begin
                  If FieldByName('REL_CODCAM').AsString <> 'VAREST' Then
                       Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', FieldByName(arrSintetico[intCont+1, 02]).AsFloat))
                  Else Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', fltTotal));
                End
                Else If Pos(FieldByName('REL_CODCAM').AsString, 'PRAVEN_PRACOM_PRACTR') > 0 Then
                Begin
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName('REL_MARGEM').AsFloat));
                End
                Else
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotal));

                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else If arrSintetico[intCont, 02] = 'REL_MARGEM' Then
              Begin
                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PRACTR_PRACOM_PRAVEN_PERDES') > 0 Then
                Begin
                  Escrever(LinhaAtual, intCont, '');
                End
                Else
                Begin
                  If FieldByName('REL_MARGEM').AsFloat = 0 Then
                       Escrever(LinhaAtual, intCont, '')
                  Else Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', FieldByName(arrSintetico[intCont, 02]).AsFloat));
                End;

                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else If FieldByName(arrSintetico[intCont, 02]).DataType = ftFloat Then
              Begin
                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PERDES') > 0 Then
                Begin
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', FieldByName(arrSintetico[intCont, 02]).AsFloat));
                End
                Else
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont, 02]).AsFloat));

                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else
              Begin
                Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont, 02]).AsString);
                Alinhamento(LinhaAtual, intCont, Esquerda);
              End;

            End;


          End;

          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

          Next;

        End;

      End;

    End;

    ProximaLinha;
    intQtdCol  := intAuxP;
    strUltCol := fGetLetraAlfa(intQtdCol);

    With cdsSalPor Do
    Begin
      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrSalPortad[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);

        If FieldByName(arrSalPortad[intCont, 02]).DataType = ftFloat Then
          Alinhamento(LinhaAtual, intCont, Direita)
        Else
          Alinhamento(LinhaAtual, intCont, Esquerda);
      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      While Not Eof Do
      Begin
        fltTotPor := 0;

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin

          If FieldByName(arrSalPortad[intCont, 02]).DataType = ftFloat Then
          Begin
            If arrSalPortad[intCont][02] = 'TOTAL' Then
              Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotPor))
            Else
              Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSalPortad[intCont, 02]).AsFloat));

            Alinhamento(LinhaAtual, intCont, Direita);

            fltTotPor := fltTotPor + FieldByName(arrSalPortad[intCont, 02]).AsFloat;
          End
          Else
          Begin
            If arrSalPortad[intCont, 02] = 'POR_CODPOR' Then
                 Escrever(LinhaAtual, intCont, '''' + FieldByName('POR_CODPOR').AsString +
                                               ' '  + FieldByName('POR_NOMPOR').AsString )
            Else Escrever(LinhaAtual, intCont, '');
            Alinhamento(LinhaAtual, intCont, Esquerda);
          End;

        End;

        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        Next;

      End;

    End;

    ProximaLinha;
    Escrever(LinhaAtual, 01, 'TOTAL DOS PORTADORES');
    Alinhamento(LinhaAtual, 01, Esquerda);

    fltTotPorGer := 0;

    With cdsSalPor Do
    Begin
      For intCont := 2 To intQtdCol Do
      Begin
        fltTotPor := 0;

        First;

        While Not Eof Do
        Begin
          If FieldByName(arrSalPortad[intCont, 02]).DataType = ftFloat Then
          Begin
            fltTotPor    := fltTotPor    + FieldByName(arrSalPortad[intCont, 02]).AsFloat;
            fltTotPorGer := fltTotPorGer + FieldByName(arrSalPortad[intCont, 02]).AsFloat;
          End;

          Next;
        End;

        If arrSalPortad[intCont][02] = 'TOTAL' Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotPorGer))
        Else
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotPor));

        Alinhamento(LinhaAtual, intCont, Direita);
      End;
    End;

    Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

    ProximaLinha;
    intQtdCol := Length(arrResFornec);
    strUltCol := fGetLetraAlfa(intQtdCol);
    fltPesLit := 0;
    fltTotVis := 0;
    fltTotPrz := 0;
    fltTotCus := 0;
    fltTotVen := 0;

    With cdsVenFor Do
    Begin
      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrResFornec[intCont, 01]);
        Negrito(LinhaAtual, intCont, True);

        If FieldByName(arrResFornec[intCont, 02]).DataType = ftFloat Then
          Alinhamento(LinhaAtual, intCont, Direita)
        Else
          Alinhamento(LinhaAtual, intCont, Esquerda);
      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      While Not Eof Do
      Begin

        ProximaLinha;

        For intCont := 1 To intQtdCol Do
        Begin

          If FieldByName(arrResFornec[intCont, 02]).DataType = ftFloat Then
          Begin
            Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrResFornec[intCont, 02]).AsFloat));
            Alinhamento(LinhaAtual, intCont, Direita);
          End
          Else
          Begin
            If arrResFornec[intCont, 02] = 'CODFOR' Then
              Escrever(LinhaAtual, intCont, '''' + FieldByName('CODFOR').AsString +
                                            ' '  + FieldByName('NOMFOR').AsString )
            Else
              Escrever(LinhaAtual, intCont, '');
            Alinhamento(LinhaAtual, intCont, Esquerda);
          End;

        End;

        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

        fltPesLit := fltPesLit + FieldByName('PESLIT').AsFloat;
        fltTotVis := fltTotVis + FieldByName('TOTVIS').AsFloat;
        fltTotPrz := fltTotPrz + FieldByName('TOTPRZ').AsFloat;
        fltTotCus := fltTotCus + FieldByName('TOTCUS').AsFloat;
        fltTotVen := fltTotVen + FieldByName('TOTVEN').AsFloat;

        Next;

      End;

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin

        If (arrResFornec[intCont, 02] = 'PESLIT') Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltPesLit))
        Else If (arrResFornec[intCont, 02] = 'TOTVIS') Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotVis))
        Else If (arrResFornec[intCont, 02] = 'TOTPRZ') Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotPrz))
        Else If (arrResFornec[intCont, 02] = 'TOTCUS') Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotCus))
        Else If (arrResFornec[intCont, 02] = 'MARGEM') Then
          Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fCalculaPrecoVendaInt(fltTotCus, fltTotVen)));

        Alinhamento(LinhaAtual, intCont, Direita);
        Negrito(LinhaAtual, intCont, True);

      End;

      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

    End;

    OrientacaoPagina(Retrato);

    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    pnlInfo.Caption := '';

    fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstatAnalResult2.DesmarcarTudo1Click(Sender: TObject);
begin
  inherited;
  pSelVarios(opDTodos);
end;

procedure TfrmRelEstatAnalResult2.edtDestinoChange(Sender: TObject);
begin
  inherited;
  If (Pos(edtDestino.Text, 'E_') > 0) Then
  Begin
    rdgTipOri.Enabled     := False;
    rdgOrientacao.Enabled := False;
    intMaxColuna          := MAX_COLUNA_EXCEL;
  End
  Else
  Begin
    rdgTipOri.Enabled     := True;
    rdgOrientacao.Enabled := True;
    rdgOrientacaoClick(rdgOrientacao);
  End;
end;

procedure TfrmRelEstatAnalResult2.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

end.
