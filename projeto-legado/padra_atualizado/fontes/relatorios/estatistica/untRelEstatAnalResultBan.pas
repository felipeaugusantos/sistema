{****************************************}
{* ************* ATENÇÃO ************** *}
{****************************************}
{* ESSE RELATÓRIO SUPORTA ATE 20 LOJAS  *}
{* CASO PASSE DEVERA ALTERAR ESTRUTURA  *}
{* DO DATASET RELATORIO                 *}
{*************************************AF*}
unit untRelEstatAnalResultBan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport, untGravando,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, cxProgressBar,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, untTypesSistema,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, CheckLst, UniClientDataSet,
  Uni, UniDataSetProvider, DB, StrUtils, Printers, BitBtnLockedIncrem, DateUtils,
  ComboBoxFocus, frxExportCSVTestabilidade, Datasnap.DBClient;

const
  MAX_LOJAS = 25;
  MAX_COLUNA_PAISAGEM = 12; {0..11}
  MAX_COLUNA_RETRATO  = 07; {0..07}
  SEM_EVENTO = '<SEM EVENTO>';
  
type
  TSelecao = (opMTodos, opDTodos);

  TfrmRelEstatAnalResultBan = class(TfrmPaiRelatorio)
    lstEmpresas: TCheckListBox;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label5: TLabel;
    rdgOrientacao: TRadioGroup;
    cdsRelat: TUniClientDataSet;
    cdsRelatREL_CODREL: TIntegerField;
    cdsRelatREL_DESGRU: TStringField;
    cdsRelatREL_CODCAM: TStringField;
    cdsRelatREL_DESCAM: TStringField;
    cdsRelatREL_LOJ001: TFloatField;
    cdsRelatREL_LOJ002: TFloatField;
    cdsRelatREL_LOJ003: TFloatField;
    cdsRelatREL_LOJ004: TFloatField;
    cdsRelatREL_LOJ005: TFloatField;
    cdsRelatREL_LOJ006: TFloatField;
    cdsRelatREL_LOJ007: TFloatField;
    cdsRelatREL_LOJ008: TFloatField;
    cdsRelatREL_LOJ009: TFloatField;
    cdsRelatREL_LOJ010: TFloatField;
    cdsRelatREL_LOJ011: TFloatField;
    cdsRelatREL_LOJ012: TFloatField;
    cdsRelatREL_LOJ013: TFloatField;
    cdsRelatREL_LOJ014: TFloatField;
    cdsRelatREL_LOJ015: TFloatField;
    cdsRelatREL_LOJ016: TFloatField;
    cdsRelatREL_LOJ017: TFloatField;
    cdsRelatREL_LOJ018: TFloatField;
    cdsRelatREL_LOJ019: TFloatField;
    cdsRelatREL_LOJ020: TFloatField;
    cdsRelatREL_LOJ021: TFloatField;
    cdsRelatREL_LOJ022: TFloatField;
    cdsRelatREL_LOJ023: TFloatField;
    cdsRelatREL_LOJ024: TFloatField;
    cdsRelatREL_LOJ025: TFloatField;
    cdsRelatREL_LOJ026: TFloatField;
    cdsRelatREL_LOJ027: TFloatField;
    cdsRelatREL_LOJ028: TFloatField;
    cdsRelatREL_LOJ029: TFloatField;
    cdsRelatREL_LOJ030: TFloatField;
    frxSalPor: TfrxDBDataset;
    cdsRelatREL_MARGEM: TFloatField;
    cdsRelatREL_MAR001: TFloatField;
    cdsRelatREL_MAR002: TFloatField;
    cdsRelatREL_MAR003: TFloatField;
    cdsRelatREL_MAR004: TFloatField;
    cdsRelatREL_MAR005: TFloatField;
    cdsRelatREL_MAR006: TFloatField;
    cdsRelatREL_MAR007: TFloatField;
    cdsRelatREL_MAR008: TFloatField;
    cdsRelatREL_MAR009: TFloatField;
    cdsRelatREL_MAR010: TFloatField;
    cdsRelatREL_MAR011: TFloatField;
    cdsRelatREL_MAR012: TFloatField;
    cdsRelatREL_MAR013: TFloatField;
    cdsRelatREL_MAR014: TFloatField;
    cdsRelatREL_MAR015: TFloatField;
    cdsRelatREL_MAR016: TFloatField;
    cdsRelatREL_MAR017: TFloatField;
    cdsRelatREL_MAR018: TFloatField;
    cdsRelatREL_MAR019: TFloatField;
    cdsRelatREL_MAR020: TFloatField;
    cdsRelatREL_MAR021: TFloatField;
    cdsRelatREL_MAR022: TFloatField;
    cdsRelatREL_MAR023: TFloatField;
    cdsRelatREL_MAR024: TFloatField;
    cdsRelatREL_MAR025: TFloatField;
    cdsRelatREL_MAR026: TFloatField;
    cdsRelatREL_MAR027: TFloatField;
    cdsRelatREL_MAR028: TFloatField;
    cdsRelatREL_MAR029: TFloatField;
    cdsRelatREL_MAR030: TFloatField;
    rdgExibir: TRadioGroup;
    rdgFatura: TRadioGroup;
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
    procedure FormCreate(Sender: TObject);
    procedure lstEmpresasClickCheck(Sender: TObject);
    procedure lstEmpresasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure lstEmpresasEnter(Sender: TObject);
    procedure rdgOrientacaoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    function frxQckEstatAnalResult2JUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    function frxQckEstatAnalResult2MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormDestroy(Sender: TObject);
    procedure edtDestinoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure mnuSelTudoClick(Sender: TObject);
    procedure DesmarcarTudo1Click(Sender: TObject);
  private
    { Private declarations }

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

    cdsCtaAux2: TUniClientDataSet;

    qryEmpTri: TUniQuery;

    fltTotVar: Double;

    fltTotPis,
    fltTotCof,
    fltTotIcm,
    fltTotIpi,
    fltTotRet,
    fltTotFre,
    fltTotJur,
    fltTotDes: Double;

    fltTotASn,
    fltTotAIr,
    fltTotACs: Double;

    VS_DateFim: TDateTime;

    procedure pCarregaCTP124;
    procedure pCarregaVendas;
    procedure pCarregaCtaRes;
    procedure pCarregaCtaPag;
    procedure pCarregaCtaRec;
    procedure pCarregaMovCar;
    procedure pCarregaCadChq;
    procedure pCarregaTransf;
    procedure pCarregaBonifi(blnSaida : Boolean);
    procedure pCarregaEstoqu;
    procedure pCarregaImobil;
    procedure pCarregaAvalia;
    procedure pCarregaPraMed;
    procedure pCarregaAcrFin;
    procedure pCarregaSalPor;
    procedure pAtualizaLst;
    procedure pDesmarcaColunasRetrato;

    procedure pCarregaJurosDescontos;

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
    procedure pSelVarios(Opcao: TSelecao);

    function fEmpSelecionadas: String;
    function fContaSelecoes: Integer;

    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
    function fCarregandoDadosRelatorio(pgbStatus: TcxProgressBar = Nil): Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelEstatAnalResultBan: TfrmRelEstatAnalResultBan;

implementation

uses Math, untExcel,  untConstantes, untMemo, untFuncoesSimples, untConsultas,
     untCadRcxx, untIFuncoes;

{$R *.dfm}

{ TfrmRelEstatAnalResult2 }

procedure TfrmRelEstatAnalResultBan.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstatAnalResultBan.FormCreate(Sender: TObject);
begin
  inherited;

  pCarregaComposicaoCusto(cbbComCus);  

  slsEmpresas := TStringList.Create;

  cdsRelat.CreateDataSet;
  qryGenericaJurosEDescontos := fCriaQuery(Self);
  qryGenerica    := fCriaQuery(Self);
  cdsFaturamento := TUniClientDataSet.Create(Self);
  cpvFaturamento := TUniDataSetProvider.Create(Self);
  cdsFaturamento.DisableControls;

  qryJurDes := fCriaQuery;
  cdsJurDes := TUniClientDataSet.Create(Self);
  cpvJurDes := TUniDataSetProvider.Create(Self);
  cdsJurDes.DisableControls;

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

  cdsCtaAux2 := TUniClientDataSet.Create(Self);
  cdsCtaAux2.DisableControls;

  pAtualizaLst;
  intMaxColuna := MAX_COLUNA_RETRATO;

  frxQckEstatAnalResult2J.AddFunction('function fRetTotalVariacao: String');
  frxQckEstatAnalResult2M.AddFunction('function fRetTotalVariacao: String');

end;

procedure TfrmRelEstatAnalResultBan.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(slsEmpresas);

  If Assigned(qryJurDes) Then
    FreeAndNil(qryJurDes)
end;

function TfrmRelEstatAnalResultBan.fEmpSelecionadas: String;
  Var
    intContador: Integer;
begin
  Result := VS_strCodEmp + '_';

  For intContador := 0 To slsEmpresas.Count -1 Do
    Result := Result + slsEmpresas[intContador] + '_';

end;

function TfrmRelEstatAnalResultBan.fConfiguracaoRegTriAtiva(caCampo: TTipoConfigAtiva;
  strCodEmp: String): Boolean;
  Var
    blnPis,
    blnCof,
    blnIcm,
    blnIpi,
    blnRet,
    blnFre,
    blnJur,
    blnDes: Boolean;
begin
  Result := False;

  cdsFaturamento.Filtered := False;
  cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(strCodEmp);
  cdsFaturamento.Filtered := True;

  pCarregaJurosDescontos;
  cdsJurDes.Filtered := False;
  cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(strCodEmp);
  cdsJurDes.Filtered := True;

  blnPis := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTPIS')).Value > 0);
  blnCof := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCOF')).Value > 0);
  blnIcm := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTICM')).Value > 0);
  blnIpi := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTIPI')).Value > 0);
  blnRet := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTRET')).Value > 0);
  blnFre := (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value <> Null) And (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTFRE')).Value > 0);

  blnJur := (cdsJurDes.FieldByName('VALJUR').AsFloat > 0);
  blnDes := (cdsJurDes.FieldByName('VALDES').AsFloat > 0);

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
      Result := qryEmpTri.Locate('TRI_LRJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_LRDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnDes
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_LRJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_LRDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnDes;
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
      Result := qryEmpTri.Locate('TRI_LPJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_LPDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnDes
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_LPJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_LPDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnDes;
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
      Result := qryEmpTri.Locate('TRI_SNJURR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoVendaBruta  Then
      Result := qryEmpTri.Locate('TRI_SNDESR;TRI_CODEMP', VarArrayOf(['V', strCodEmp]), []) And blnDes
    Else If caCampo = caJurosDespesasFinanceiras Then
      Result := qryEmpTri.Locate('TRI_SNJURR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnJur
    Else If caCampo = caDescontoDespesasFinanceiras  Then
      Result := qryEmpTri.Locate('TRI_SNDESR;TRI_CODEMP', VarArrayOf(['D', strCodEmp]), []) And blnDes;
  End;
end;

procedure TfrmRelEstatAnalResultBan.pCarregaValoresImpostos(strCodEmp: String);
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

  If fConfiguracaoRegTriAtiva(caJurosVendaBruta, strCodEmp) Then
    fltTotJur := cdsJurDes.FieldByName('VALJUR').AsFloat;

  If fConfiguracaoRegTriAtiva(caDescontoVendaBruta, strCodEmp) Then
    fltTotDes := cdsJurDes.FieldByName('VALDES').AsFloat;

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
procedure TfrmRelEstatAnalResultBan.pCarregaVendas;
  Var
    strSQL  : String;
    strCam  : String;
    strCta  : String;
    intCont : Integer;
    fltCusto: Double;
    fltVenda: Double;
    fltMarge: Double;

    fltTotalVendas: Double;
    fltTotalCustos: Double;

    fltAlqSN,
    fltAlqIrp,
    fltAlqCsl: Double;

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

begin

  Try
    strCam := 'IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0)';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DET_CODEMP AS FAT_CODEMP, ';
    strSQL := strSQL + '  IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS FAT_VALVEN, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) < 5, -' + strCam + ', ' + strCam + ') AS FAT_VALCUS, ';
    strSQL := strSQL + '  IF(LOCATE(DET_ESPDOC,"TR_DV_PD_") > 0, "TRODEV", IF(LEFT(DET_CLAFIS,1) < 5, "TRODEV", IF(DET_CONPAG = 1000, "VENVIS", "VENPRA"))) AS FAT_TIPFAT, ';
    strSQL := strSQL + '  DET_CODCND, ';
    strSQL := strSQL + '  DET_CONPAG, ';
    strSQL := strSQL + '  CND_DESCRI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALPIS, 0) AS DET_VALPIS, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALCOF, 0) AS DET_VALCOF, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALICM, 0) AS DET_VALICM, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALIPI, 0) AS DET_VALIPI, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_VALRET, 0) AS DET_VALRET, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS, 1) < 5, -1, 1) * COALESCE(DET_TOTFRE, 0) AS DET_TOTFRE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';

    strSQL := strSQL + '  LEFT JOIN CADCND ON DET_CODCND = CND_CODIGO ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI I ON I.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN MOVICD   ON ICD_SEQGER   = MOVDET.AUTOINCREM AND DET_VALRET = 0 ';


    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + cnsFiltroFFDVTR;    
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  LOCATE(DET_CODEMP, :CODEMP) > 0 AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';
    strSQL := strSQL + IfThen(fCfgSis('ENTBRF', varBoolean), ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) ', ')');

    strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
    
    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

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
    pInsereVenTro('VENVIS','VENDAS A VISTA');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('VENVIS', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    pInsereVenTro('VENPRA','VENDAS A PRAZO');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('VENPRA', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    pInsereVenTro('TRODEV','TROCAS/DEVOLUCAO');
    If (rdgFatura.ItemIndex = 1) Then
      pInsereCndPgto('TRODEV', cdsFaturamento.FieldByName('CND_DESCRI').AsString);

    pIniciaInsercao('***','');
    cdsRelat.Post;

    cdsCta124.Filtered := False;
    cdsCta124.Filter   := 'CTA_TIPCTA = 1';
    cdsCta124.Filtered := True;

    {****************************************}
    {* TOTAL DE VENDAS                      *}
    {*************************************AF*}
    pIniciaInsercao('TOTVEN','TOTAL DA VENDA - DEVOLUÇÕES');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsFaturamento.Filtered := False;
      cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsFaturamento.Filtered := True;
      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;
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
      cdsCtaAux.IndexFieldNames := 'CTB_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 1';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin
        If strCta = cdsCtaAux.FieldByName('CTB_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP1',cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTB_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;

          cdsCta124.Filter   := 'CTB_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTB_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTB_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);

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
      pIniciaInsercao('VALPIS','PIS');
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
      pIniciaInsercao('VALCOF','COFINS');
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
      pIniciaInsercao('VALICM','ICMS');
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
      pIniciaInsercao('VALIPI','(+) IPI');
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
      pIniciaInsercao('VALRET','(+) SUBSTITUIÇÃO TRIBUTÁRIA');
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
      pIniciaInsercao('VALFRE','(+) FRETE');
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
      pIniciaInsercao('ALQSIN','ALÍQUOTA SIMPLES NACIONAL');
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
      pIniciaInsercao('ALQIRP','ALÍQUOTA DE IRPJ');
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
      pIniciaInsercao('ALQCSL','ALÍQUOTA DE CSLL');
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
      pIniciaInsercao('JURREC','JUROS RECEBIDOS');
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
      pIniciaInsercao('DESCON','DESCONTOS CONCEDIDOS');
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
      cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('1') + ' AND CTB_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
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

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenda  +
                                                                        fltCusto  -
                                                                        fltTotPis -
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
    End;
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
      cdsCtaAux.IndexFieldNames := 'CTB_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 2';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin

        If strCta = cdsCtaAux.FieldByName('CTB_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP2',cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTB_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;
          cdsCta124.Filter   := 'CTB_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTB_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTB_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
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
      pIniciaInsercao('CUSTOT','TOTAL DE CUSTO DOS PRODUTOS');

      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsFaturamento.Filtered := False;
        cdsFaturamento.Filter   := 'FAT_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsFaturamento.Filtered := True;

        cdsCta124.Filtered := False;
        cdsCta124.Filter   := 'CTA_TIPCTA = ' + QuotedStr('2') + ' AND CTB_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCta124.Filtered := True;

        If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value = Null Then
          fltVenda := 0
        Else
          fltVenda := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTCUS')).Value;

        If TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value = Null Then
          fltCusto := 0
        Else
          fltCusto := TAggregateField(cdsCta124.FieldByName('CTP_TOTPAG')).Value;

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenda - fltCusto;
      End;
      cdsRelat.Post;
    End;

    pIniciaInsercao('***','');
    cdsRelat.Post;

    {****************************************}
    {* RESULTADO DE VENDA BRUTO             *}
    {*************************************AF*}
    cdsCtaAux.Filter := '';
    cdsCtaAux.Data := cdsRelat.Data;

    pIniciaInsercao('VENBRU','RESULTADO DE VENDA BRUTO');

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('VENLIQ');
      cdsCtaAux.Filtered := True;
      fltVenda := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('CUSTOT');
      cdsCtaAux.Filtered := True;
      fltCusto := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenda - fltCusto;
    End;
    cdsRelat.Post;

    {****************************************}
    {* MARGEM DE CONTRIBUIÇÃO               *}
    {*************************************AF*}
    cdsCtaAux.Filter := '';
    cdsCtaAux.Data := cdsRelat.Data;

    pIniciaInsercao('MARCON','MARGEM DE CONTRIBUICAO');

    fltTotalVendas := 0;
    fltTotalCustos := 0;

    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('VENLIQ');
      cdsCtaAux.Filtered := True;
      fltVenda := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
      fltTotalVendas := fltTotalVendas + fltVenda;

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('CUSTOT');
      cdsCtaAux.Filtered := True;
      fltCusto := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
      fltTotalCustos := fltTotalCustos + fltCusto;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fCalculaPrecoVenda(2, fltCusto, fltVenda, 0,0,0,0,0);
    End;

    fltMarge := fCalculaPrecoVenda(2, fltTotalCustos, fltTotalVendas, 0,0,0,0,0);
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

{****************************************}
{* CARREGA CONTAS DE RESULTADO          *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaCtaRes;
  Var
    strSQL   : String;
    strCta   : String;
    intCont  : Integer;
    fltVenBru: Double;
    fltTotCta: Double;
    fltTotVen: Double;
    fltTotCus: Double;

    fltGerVen: Double;
    fltGerCus: Double;

    fltCusLoj: Double;
    arrTotVen: Array Of Double;

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

      IF ( TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value > 0 ) then
        fltTotDes := fltTotDes + TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;

      if (TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value > 0 ) then
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
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.CTB_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  G.CRE_CODCRE AS CODCRE, ';
    strSQL := strSQL + '  G.CRE_DESCRE AS DESCTA, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C",-CTB_VALLAN, CTB_VALLAN)) AS VALPAG  ';
    strSQL := strSQL + 'FROM ';
	  strSQL := strSQL + '  MOVBAN B ';
    strSQL := strSQL + '  JOIN CADCTA C ON B.CTB_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
    strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  B.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ';
  	strSQL := strSQL + '  LOCATE(B.CTB_CODEMP, :CODEMP) > 0 ';
    strSQL := strSQL + 'GROUP BY CODCRE, CODEMP ';

    strSQL := 'SELECT CODEMP, CODCRE, DESCTA, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODCRE, CODEMP ';
    strSQL := strSQL + 'ORDER BY CODCRE ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;

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
      cdsFaturamento.Filtered := False;

      If TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null Then
        fltTotVen := 0
      Else
        fltTotVen := TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value;

      {*****************************************}
      {* PEGA O TOTAL DE VENDAS DE CADA LOJA   *}
      {**************************************MV*}
      cdsCtaAux2.Data := cdsRelat.Data;
      cdsCtaAux2.Filtered := False;
      cdsCtaAux2.Filter   := 'REL_CODCAM = ' + QuotedStr('VENLIQ');
      cdsCtaAux2.Filtered := True;

      If cdsCtaAux2.IsEmpty Then
      Begin
        cdsCtaAux2.Filtered := False;
        cdsCtaAux2.Filter   := 'REL_CODCAM = ' + QuotedStr('TOTVEN');
        cdsCtaAux2.Filtered := True;
      End;

      SetLength(arrTotVen, slsEmpresas.Count);
      If Not cdsCtaAux2.IsEmpty Then
      Begin

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          arrTotVen[intCont-1] := cdsCtaAux2.FieldByName('REL_LOJ0' + fStrZero(intCont, 2)).AsFloat;
        End;

      End;

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
          Begin
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0;
            cdsRelat.FieldByName('REL_MAR0' + fStrZero(intCont,2)).AsFloat := 0;
          End
          Else
          Begin
            fltCusLoj := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;
            cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltCusLoj;
            If arrTotVen[intCont-1] <> 0 Then
              cdsRelat.FieldByName('REL_MAR0' + fStrZero(intCont,2)).AsFloat := (fltCusLoj/arrTotVen[intCont-1]) * 100
            Else
              cdsRelat.FieldByName('REL_MAR0' + fStrZero(intCont,2)).AsFloat := 0.0;
          End;

          fltTotCus := fltTotCus + cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
        End;

        If (fFormataFloat(fltTotVen, 2) = 0.0) Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
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

      pIniciaInsercao('***','');
      cdsRelat.Post;

      fltTotCus := 0;
      pIniciaInsercao('CTARES','TOTAIS');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaRes.Filtered := False;
        cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaRes.Filtered := True;

        If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat :=  0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;
          fltTotCus := fltTotCus + TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;
        End;
      End;

      pIniciaInsercao('CTARES','');
      For intCont := 1 To slsEmpresas.Count Do
      Begin
        cdsCtaRes.Filtered := False;
        cdsCtaRes.Filter   := 'CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsCtaRes.Filtered := True;

        If TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value = Null Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat :=  0
        Else
        Begin
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := ((TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value) / fltTotven) * 100;
          fltTotCus := fltTotCus;
        End;
      End;

      If (fFormataFloat(fltTotVen, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
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
        fltTotCta := TAggregateField(cdsCtaRes.FieldByName('RESTOT')).Value;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat - fltTotCta;
    End;
    cdsRelat.Post;

    fltGerVen := 0;
    fltGerCus := 0;
    cdsCtaAux.Data := cdsRelat.Data;
    pCarregaJurosDescontos;

    pIniciaInsercao('MARLIQ','MARGEM OPERACIONAL');
    For intCont := 1 To slsEmpresas.Count Do
    Begin
      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('RESLIQ');
      cdsCtaAux.Filtered := True;

      cdsJurDes.Filtered := False;
      cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsJurDes.Filtered := True;

      fltTotCus := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;

      fltTotVen := arrTotVen[intCont-1];

      If fFormataFloat(fltTotVen, 2) = 0.0 Then
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (fltTotCus / fltTotVen) * 100;

      fltGerVen := fltGerVen + fltTotVen;
      fltGerCus := fltGerCus + fltTotCus;

    End;

    If (fFormataFloat(fltGerVen, 2) = 0.0) Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltGerCus / fltGerVen) * 100;

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
      cdsCtaAux.IndexFieldNames := 'CTB_CODCTA';

      cdsCtaAux.Filtered := False;
      cdsCtaAux.Filter   := 'CTA_TIPCTA = 4';
      cdsCtaAux.Filtered := True;

      While Not cdsCtaAux.Eof Do
      Begin

        If strCta = cdsCtaAux.FieldByName('CTB_CODCTA').AsString Then
        Begin
          cdsCtaAux.Next;
          Continue;
        End;

        pIniciaInsercao('CTATP4',cdsCtaAux.FieldByName('CODCTA').AsString + '-' + cdsCtaAux.FieldByName('CTA_DESCTA').AsString);
        strCta := cdsCtaAux.FieldByName('CTB_CODCTA').AsString;

        For intCont := 1 To slsEmpresas.Count Do
        Begin
          cdsCta124.Filtered := False;
          cdsCta124.Filter   := 'CTB_CODCTA = ' + QuotedStr(cdsCtaAux.FieldByName('CTB_CODCTA').AsString) + ' AND CTA_TIPCTA = ' + QuotedStr('4') + ' AND CTB_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
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
        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('CTATP4');
        cdsCtaAux.Filtered := True;

        cdsJurDes.Filtered := False;
        cdsJurDes.Filter   := 'CTR_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
        cdsJurDes.Filtered := True;

        If Not cdsCtaAux.IsEmpty Then
        Begin
          While (Not cdsCtaAux.Eof) Do
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

        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltVenBru +
                                                                          fltTotCta +
                                                                          fltTotJurFin -
                                                                          fltTotDesFin;
      End;
      cdsRelat.Post;

      cdsCtaAux.Filter := '';
      cdsCtaAux.Data := cdsRelat.Data;
      fltGerVen := 0.0;
      fltGerCus := 0.0;
      {****************************************}
      {* % REAL                               *}
      {*************************************AF*}
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

        {*****************************************}
        {* TENTA USAR A VENDA LIQUIDA. SE NÃO    *}
        {* CONSEGUIR, USA O TOTAL DE VENDAS.     *}
        {**************************************MV*}
        cdsCtaAux.Filtered := False;
        cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('VENLIQ');
        cdsCtaAux.Filtered := True;

        If Not cdsCtaAux.IsEmpty Then
        Begin
          fltTotVen := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
        End
        Else
        Begin
          cdsCtaAux.Filtered := False;
          cdsCtaAux.Filter   := 'REL_CODCAM = ' + QuotedStr('TOTVEN');
          cdsCtaAux.Filtered := True;
          If Not cdsCtaAux.IsEmpty Then
          Begin
            fltTotVen := cdsCtaAux.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat;
          End;
        End;

        If (fFormataFloat(fltTotVen, 2) = 0.0) Then
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.0
        Else
          cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := (fltVenBru / fltTotVen * 100);


        fltGerVen := fltGerVen + fltTotVen;
        fltGerCus := fltGerCus + fltVenBru;

      End;

      If (fFormataFloat(fltGerVen, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltGerCus / fltGerVen) * 100;

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
procedure TfrmRelEstatAnalResultBan.pCarregaCtaPag;

  Var
    strSQL,
    strSQLJurosDesc,
    strWhere,
    strWhereJurosDesc,
    strFil: String;
    dtaIni: TDateTime;
    dtaFin: TDateTime;
    fltTestaCTPDOU,
    fltTotDup: Double;
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

      If (fFormataFloat(fltTotDup, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValDup/fltTotDup) * 100;
        
    End;

    cdsRelat.Post;
  End;

begin

  Try
    dtaIni := (VS_DateFim -1) -30;
    dtaFin := (VS_DateFim -1);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  IF(CTP_DTAPAG IS NULL, (CTP_VALDUP - IFNULL(CTP_DESSUJ,0) + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) + IFNULL(CTP_VENDOR,0)), (CTP_VALPAG - IFNULL(CTP_VALJUR,0) + IFNULL(CTP_VALDES,0))) AS CTP_VALDUP, ';
    strSQL := strSQL + '  P.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';

    strSQL          := strSQL + 'WHERE ';
    strSQLJurosDesc := strSQL;

    strWhere          := fComplementoWhereSQLPosContabilPagar(Nil, Nil, False, Nil, Nil, fEmpSelecionadas, False);
    strWhereJurosDesc := fComplementoWhereSQLPosContabilPagar(Nil, Nil, False, Nil, Nil, fEmpSelecionadas, True);

    strSQL          := strSQL + strWhere;
    strSQLJurosDesc := strSQLJurosDesc + strWhereJurosDesc;

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := VS_DateFim;

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
    cdsCtaPag.Filter   := 'CTP_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
                          'CTP_DTAPAG IS NULL ';
    cdsCtaPag.Filtered := True;

    If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;

    strFil := 'CTP_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
              'CTP_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaIni)) + ' AND ' +
              'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaFin)) + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPV30','DOCUMENTOS VENC. ATE 30 DIAS',strFil, True);

    strFil := 'CTP_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
              'CTP_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaIni -1)) + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPM30','DOCUMENTOS VENC. MAIOR 30 DIAS',strFil, True);

    cdsCtaPag.Filter := '';
    cdsCtaPag.Filtered := False;

    If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;

    strFil := 'CTP_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPVEN','TOTAL DE DOCUM. VENCIDOS',strFil, True);

    strFil := 'CTP_DTAVEN >= '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPAVE','TOTAL DE DOCUM. A VENCER',strFil, True);

    strFil := 'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPGER','TOTAL GERAL',strFil,False);

    pIniciaInsercao('***','');
    cdsRelat.Post;

    strFil := 'CTP_PREVIS = ' + QuotedStr('S') + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPPRV','DOCUM. COM PREVISAO',strFil,False);

    strFil := 'CTP_PREVIS = ' + QuotedStr('N') + ' AND ' +
              'CTP_DTAPAG IS NULL AND ';
    pInsereRegistro('CTPSPR','DOCUM. SEM PREVISAO',strFil,False);

    pIniciaInsercao('***','');

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

    strFil := 'CTP_DTAPAG >= ' + QuotedStr(mskDtaIni.Text) + ' AND ' +
              'CTP_DTAPAG <= ' + QuotedStr(mskDtaFin.Text) + ' AND ' +
              'CTP_VALJUR <> 0 AND ';
    pInsereRegistro('CTPJUR','(*) JUROS PAGOS',strFil,False);

    strFil := 'CTP_DTAPAG >= ' + QuotedStr(mskDtaIni.Text) + ' AND ' +
              'CTP_DTAPAG <= ' + QuotedStr(mskDtaFin.Text) + ' AND ' +
              'CTP_TIPDES  = ' + QuotedStr('D') + ' AND ' +
              'CTP_VALDES <> 0 AND ';
    pInsereRegistro('CTPDDE','    DESCONTOS OBTIDOS POR DEVOLUÇÃO',strFil,False);

    strFil := 'CTP_DTAPAG >= ' + QuotedStr(mskDtaIni.Text) + ' AND ' +
              'CTP_DTAPAG <= ' + QuotedStr(mskDtaFin.Text) + ' AND ' +
              'CTP_TIPDES  = ' + QuotedStr('B') + ' AND ' +
              'CTP_VALDES <> 0 AND ';
    pInsereRegistro('CTPDBO','    DESCONTOS OBTIDOS POR BONIFICAÇÃO',strFil,False);

    strFil := 'CTP_DTAPAG >= ' + QuotedStr(mskDtaIni.Text) + ' AND ' +
              'CTP_DTAPAG <= ' + QuotedStr(mskDtaFin.Text) + ' AND ' +
              'CTP_TIPDES  = ' + QuotedStr('O') + ' AND ' +
              'CTP_VALDES <> 0 AND ';
    pInsereRegistro('CTPDOU','    DESCONTOS OBTIDOS POR OUTROS MOTIVOS',strFil,False);

    strFil := 'CTP_DTAPAG >= ' + QuotedStr(mskDtaIni.Text) + ' AND ' +
              'CTP_DTAPAG <= ' + QuotedStr(mskDtaFin.Text) + ' AND ' +
              'CTP_VALDES <> 0 AND ';
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
procedure TfrmRelEstatAnalResultBan.pCarregaCtaRec;
  Var
    strSQL: String;
    strFil: String;
    dtaBase: TDateTime;
    fltTotDup: Double;

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
      If (fFormataFloat(fltTotDup, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValDup/fltTotDup) * 100;
        
    End;

    cdsRelat.Post;
  End;

begin

  Try
    dtaBase := (VS_DateFim -1);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  CTR_CODEMP, ';
    strSQL := strSQL + '  IF(CTR_DTAREC IS NULL, (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)), (CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))) AS CTR_VALDUP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + fComplementoWhereSQLPosContabilReceber(fEmpSelecionadas);

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := VS_DateFim;

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
    cdsCtaRec.Filter := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim));
    cdsCtaRec.Filtered := True;

    If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;

    strFil := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ' +
              'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 30)) + ' AND ' +
              'CTR_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase)) + ' AND ';
    pInsereRegistro('CTRV30','DOC.VENC.ATE 30 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim - 30)) + ' AND ' +
              'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 60)) + ' AND ' +
              'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 30)) + ' AND ';
    pInsereRegistro('CTRV30','DOC.VENC.DE 30 ATE 60 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim - 60)) + ' AND ' +
              'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 120)) + ' AND ' +
              'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 60)) + ' AND ';
    pInsereRegistro('CTRV30','DOC.VENC. DE 60 ATE 120 DIAS',strFil,True);

    strFil := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim - 120)) + ' AND ' +
              'CTR_DTAVEN <  ' + QuotedStr(FormatDateTime('dd/mm/yyyy', dtaBase - 120)) + ' AND ';
    pInsereRegistro('CTRM30','DOC.VENC. MAIOR 120 DIAS',strFil,True);

    cdsCtaRec.Filter := '';
    cdsCtaRec.Filtered := False;

    If TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value = Null Then
      fltTotDup := 0
    Else
      fltTotDup := TAggregateField(cdsCtaRec.FieldByName('CTR_TOTDUP')).Value;

    strFil := 'CTR_DTAVEN < '  + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
    pInsereRegistro('CTRVEN','TOTAL DE DOCUM. VENCIDOS',strFil,True);

    strFil := 'CTR_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
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
procedure TfrmRelEstatAnalResultBan.pCarregaMovCar;
  Var
    strSQL: String;
    strFil: String;
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
      If (fFormataFloat(fltTotCar, 2) = 0.0) Then
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_MARGEM').AsFloat := (fltValCar/fltTotCar) * 100;

    End;

    cdsRelat.Post;
  End;

begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MCA_CODEMP, ';
    strSQL := strSQL + '  MCA_DTAVEN, ';
    strSQL := strSQL + '  MCA_VALSTA AS MCA_VALDUP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR ';
    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + fComplementoWhereSQLPosContabilCartao(Nil, Nil, fEmpSelecionadas);

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDateTime := VS_DateFim;

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

    strFil := 'MCA_DTAVEN < ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
    pInsereRegistro('CARVEN','TOTAL DE DOCUM VENCIDOS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim))    + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+30)) + ' AND ';
    pInsereRegistro('CARAVE','DOC. A VENCER ATÉ 30 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+31)) + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+60)) + ' AND ';
    pInsereRegistro('CARAVE','DOC. A VENCER DE 30 DIAS A 60 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+61)) + ' AND ' +
              'MCA_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+120))+ ' AND ';
    pInsereRegistro('CARAVE','DOC. A VENCER DE 60 DIAS A 120 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+121)) + ' AND ';
    pInsereRegistro('CARAVE','DOC. A VENCER MAIOR QUE 120 DIAS',strFil,True);

    strFil := 'MCA_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
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
procedure TfrmRelEstatAnalResultBan.pCarregaCadChq;
  Var
    strSQL : String;
    strFil: String;
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
      ParamByName('CODEMP').AsString   := fEmpSelecionadas;
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

    strFil := 'CHQ_DTAVEN <  ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
    pInsereRegistro('CHQGER','TOTAL DE CHEQUES VENCIDOS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim))    + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+30)) + ' AND ';
    pInsereRegistro('CHQGER','CHE. COM VENCIMENTO ATÉ 30 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+31)) + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+60)) + ' AND ';
    pInsereRegistro('CHQGER','CHE. COM VENCIMENTO DE 30 DIAS A 60 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+61)) + ' AND ' +
              'CHQ_DTAVEN <= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+120))+ ' AND ';
    pInsereRegistro('CHQGER','CHE. COM VENCIMENTO DE 60 DIAS A 120 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim+121)) + ' AND ';
    pInsereRegistro('CHQGER','CHE. COM VENCIMENTO MAIOR QUE 120 DIAS',strFil,True);

    strFil := 'CHQ_DTAVEN >= ' + QuotedStr(FormatDateTime('dd/mm/yyyy',VS_DateFim)) + ' AND ';
    pInsereRegistro('CHQGER','TOTAL DE CHEQUES A VENCER',strFil,True);

    strFil := '';
    pInsereRegistro('CHQGER','TOTAL GERAL',strFil,True);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA TRANSFERENCIA DE ESTOQUE     *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaTransf;
  Var
    strSQL : String;
    intCont: Integer; 

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
    strSQL := strSQL + '  GER_VLRCON  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  LOCATE(GER_CODEMP, :CODEMP) > 0 AND ';
    strSQL := strSQL + '  GER_CODCLI IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  ((GER_ESPDOC = "TE") OR (GER_ESPDOC IN ("NF", "EL") AND RIGHT(GER_CLAFIS, 3) IN (152,409))) ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

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

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA ESTOQUE                      *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaEstoqu;
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
    strCampoQtd, strCampoPreco: String;

  function fExisteSalMLBase(strTabela: string): Boolean;
  begin
    Result := fCampoExiste(strTabela, 'ITE_SAL_ML');
  end;

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
    strCusSob := fPreInv('I', 'I');
    strCusTit := fPreInvTitulo;

    If (fCfgSis('PREINV') = 'ULTFED') Then
      strSubsti := strCusSob
    Else
      strSubsti := '';

    strCampoQtd := 'ROUND(ROUND((I.ITE_SALDOS + IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, IFNULL(I.ITE_SAL_ML, 0) / CADITE.ITE_CNV_ML, 0)), 2), 2) ';
    strCampoPreco := 'ROUND(' + strCusSob + ' / IF((CADITE.ITE_FATCNV = 0) OR (CADITE.ITE_FATCNV IS NULL), 1, CADITE.ITE_FATCNV), 2)';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_CODEMP, ';
    strSQL := strSQL + '  SUM(' + fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                                            '  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoQtd + ') ', 2) + ') AS ITE_SALDOS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER I ';
    strSQL := strSQL + '  LEFT JOIN CADITE ON I.ITE_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + 'WHERE ';

    {If rdgSalEst.ItemIndex = 0 Then
      strSQL := strSQL + '  ' + strCampoQtd + ' > 0 AND ';}

    strSQL := strSQL + '  LOCATE(I.ITE_CODEMP, :CODEMP) > 0 ';
    strSQL := strSQL + 'GROUP BY I.ITE_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      Filter := EmptyStr;

      strAux := strSQL;
      If (MonthOf(VS_Date) <> MonthOf(StrToDate(mskDtaFin.Text))) Then
      Begin
        strData := FormatDateTime('mm/yyyy', StrToDate(mskDtaFin.Text));
        strData := 'I_' + RightStr(strData, 4) + LeftStr(strData, 2);

        If fTabelaExiste(strData) Then
        Begin
          strAux  := AnsiReplaceStr( strSQL, 'ITEGER', strData );
          If Not fExisteSalMLBase(strData) Then
            strAux  := AnsiReplaceStr( strAux, 'I.ITE_SAL_ML', '0' );
          If Not fEmptyStr(strSubsti) Then
            strAux  := AnsiReplaceStr( strAux, strSubsti, 'IFNULL(I.ITE_PRECUS,0)' );
        End
        Else
        Begin
          strAux  := strSQL + ' LIMIT 0 ';
          If Not fEmptyStr(strSubsti) Then
            strAux  := AnsiReplaceStr( strAux, strSubsti, 'IFNULL(I.ITE_PRECUS,0)' );
        End;

      End;

      SQL.Add(strAux);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;

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

    strData := FormatDateTime('mm/yyyy', IncMonth( StrToDate(mskDtaIni.Text), -1 ) );
    strData := 'I_' + RightStr(strData, 4) + LeftStr(strData, 2);
    If fTabelaExiste(strData) Then
    Begin
      strSQL  := AnsiReplaceStr( strSQL, 'ITEGER', strData );
      If Not fExisteSalMLBase(strData) Then
        strSQL  := AnsiReplaceStr( strSQL, 'I.ITE_SAL_ML', '0' );
      If Not fEmptyStr(strSubsti) Then
        strSQL  := AnsiReplaceStr( strSQL, strSubsti, 'IFNULL(I.ITE_PRECUS,0)' );

    End
    Else
    Begin
      strSQL  := strSQL + ' LIMIT 0 ';
      If Not fEmptyStr(strSubsti) Then
        strSQL  := AnsiReplaceStr(strSQL, strSubsti, 'IFNULL(I.ITE_PRECUS,0)' );
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
        ParamByName('CODEMP').AsString := fEmpSelecionadas;
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
      fltTotVar := (( fltTotEst - fltTotGen) / fltTotGen) * 100
    Else
      fltTotVar := 0;

    cdsRelat.Post;

  Except

    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelEstatAnalResultBan.pCarregaEstoqu]');

  End;

end;

{****************************************}
{* CARREGA IMOBILIZADO/PATRIMONIO       *}
{*************************************IV*}
procedure TfrmRelEstatAnalResultBan.pCarregaImobil;
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
    strSQL := strSQL + '              0,(IMO_VALAQU * (1-(IFNULL(IMO_PERRES, 0)/100))) * (IMO_DEPANU/100) *  ';
    strSQL := strSQL + '                (TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)))) < ((IMO_PERRES/100)*IMO_VALAQU) AND IFNULL(IMO_PERRES,0) > 0, ';
    strSQL := strSQL + '          ((IMO_PERRES/100)*IMO_VALAQU),';
    strSQL := strSQL + '          (IMO_VALAQU  -  ';
    strSQL := strSQL + '          IF( TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)=0, ';
    strSQL := strSQL + '              0,(IMO_VALAQU * (1-(IFNULL(IMO_PERRES, 0)/100))) * (IMO_DEPANU/100) *  ';
    strSQL := strSQL + '                (TRUNCATE(DATEDIFF(' + fCurrentDate + ',IMO_DTAAQU)/365,0)))) ';
    strSQL := strSQL + '       ),0)) AS IMO_TOTIMO ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADIMO ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  IMO_VENDID = "N" AND ';
    strSQL := strSQL + '  LOCATE(IMO_CODEMP, :CODEMP) > 0 ';
    strSQL := strSQL + 'GROUP BY IMO_CODEMP ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      Params.Clear;
      Filter := EmptyStr;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;

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
    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResultBan.pCarregaJurosDescontos;
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
  strSQL := strSQL + '  LOCATE(CTR_CODEMP, :CODEMP) > 0 ';

  With qryJurDes Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  CTR_CODEMP,                ');
    SQL.Add('  SUM(CTR_VALJUR) AS VALJUR, ');
    SQL.Add('  SUM(CTR_VALDES) AS VALDES  ');
    SQL.Add('FROM                         ');
    SQL.Add('(' + strSQL + ') AS TMP      ');
    SQL.Add('GROUP BY                     ');
    SQL.Add('  CTR_CODEMP                 ');
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
    ParamByName('CODEMP').AsString := fEmpSelecionadas;

    cdsJurDes.Close;
    cdsJurDes.SetProvider(cpvJurDes);
    cpvJurDes.DataSet := qryJurDes;
    cdsJurDes.Open;
  End;
end;

{****************************************}
{* CARREGA AVALIACAO DAS LOJAS          *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaAcrFin;
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
    strSQL := strSQL + '  IF(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -((DET_TOTITE - DET_DESESP - DET_DESCFF)-(DET_QTDITE * DET_UNITAB)),(DET_TOTITE - DET_DESESP - DET_DESCFF)-(DET_QTDITE * DET_UNITAB))) < 0, 0.00,      ';
    strSQL := strSQL + '     IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -((DET_TOTITE - DET_DESESP - DET_DESCFF)-(DET_QTDITE * DET_UNITAB)),(DET_TOTITE - DET_DESESP - DET_DESCFF)-(DET_QTDITE * DET_UNITAB)))) AS FAT_VALVEN, ';

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
    strSQL := strSQL + '  LOCATE(DET_CODEMP, :CODEMP) > 0 AND ';
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
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
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
      {***********************************8********FC*}
      SetLength(arrSomatorias,Length(arrSomatorias) + 1);
      arrSomatorias[Length(arrSomatorias) -1] := TAggregateField.Create(Self);

      With arrSomatorias[Length(arrSomatorias) -1] Do
      Begin
        Name          := 'FAT_PRETAB';
        FieldName     := 'FAT_PRETAB';
        DataSet       := cdsAcrFin;
        Expression    := 'SUM(FAT_PRETAB)';
        DisplayFormat := '#,##0.00';
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

end;


{****************************************}
{* CARREGA AVALIACAO DAS LOJAS          *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaAvalia;
  Var
    intCont  : Integer;
    fltTotSal: Double;
    fltTotImo: Double;
    fltTotChq: Double;
    fltTotCar: Double;
    fltTotCtr: Double;
    fltTotCtp: Double;
begin

  Try
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

      cdsCtaPag.Filtered := False;
      cdsCtaPag.Filter   := 'CTP_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1])+ ' AND ' +
                            'CTP_PREVIS = ' + QuotedStr('N');
      cdsCtaPag.Filtered := True;

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

      If TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value = Null Then
        fltTotCtp := 0
      Else
        fltTotCtp := TAggregateField(cdsCtaPag.FieldByName('CTP_TOTDUP')).Value;

      cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := fltTotSal + fltTotChq + fltTotCar +
                                                                        fltTotImo + fltTotCtr - fltTotCtp;
    End;
    cdsRelat.Post;

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

{****************************************}
{* CARREGA PRAZOS MEDIOS                *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaPraMed;
  Var
    strSQL : String;
    strFil : String;
    intCont: Integer;

  procedure pIniciaInsercao(strChave, strDescri: String);
  Begin
    cdsRelat.Append;
    cdsRelat.FieldByName('REL_CODREL').AsInteger := 12;
    cdsRelat.FieldByName('REL_DESGRU').AsString  := 'PRAZOS MEDIOS(DIAS)';
    cdsRelat.FieldByName('REL_CODCAM').AsString  := strChave;
    cdsRelat.FieldByName('REL_DESCAM').AsString  := strDescri;
  End;

  procedure pInsereRegistroFat(strChave, strDescri, strClaVen, strFiltro: String);
    Var
      fltMedia: Double;
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
      cdsPraFat.Filter   := strFiltro + ' AND GER_CODEMP = ' + QuotedStr(slsEmpresas[intCont-1]);
      cdsPraFat.Filtered := True;

      fltParci := 0;
      fltTotal := 0;

      While Not cdsPraFat.Eof Do
      Begin

        If Pos(cdsPraFat.FieldByName('GER_CLAFIS').AsString, strClaVen) > 0 Then
        Begin
          fltMedia := IfThen(cdsPraFat.FieldByName('AUX_PRZMED').AsFloat = 0,
                            fCalcMediaPagto(cdsPraFat.FieldByName('GER_CONPAG').AsString),
                            cdsPraFat.FieldByName('AUX_PRZMED').AsFloat);
          fltParci := fltParci + (fltMedia * cdsPraFat.FieldByName('GER_VLRCON').AsFloat);
          fltTotal := fltTotal + cdsPraFat.FieldByName('GER_VLRCON').AsFloat;
        End;

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
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_CODCLI, ';
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  GER_CLAFIS, ';
    strSQL := strSQL + '  GER_CONPAG, ';
    strSQL := strSQL + '  GER_VLRCON, ';
    strSQL := strSQL + '  GER_TIP_FC, ';
    strSQL := strSQL + '  GER_ESPDOC, ';
    strSQL := strSQL + '  AUX_PRZMED  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER G INNER JOIN AUXMOV A ON G.AUTOINCREM = A.AUX_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';
    strSQL := strSQL + '  IF(GER_TIP_FC = "F", TRUE, GER_CODCLI NOT IN (' + VS_strCliFil + ')) AND ';
    strSQL := strSQL + '  LOCATE(GER_CODEMP, :CODEMP) > 0 ';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      cdsPraFat.Close;
      cdsPraFat.SetProvider(cpvPraFat);
      cpvPraFat.DataSet := qryGenerica;
      cdsPraFat.AggregatesActive := True;
      cdsPraFat.Open;
    End;

    For intCont := 0 To Length(VS_strCliFil) Do


    strFil := 'GER_TIP_FC =  ' + QuotedStr('C')  + ' AND ' +
              'GER_ESPDOC <> ' + QuotedStr('DV') + ' AND ' +
              'GER_ESPDOC <> ' + QuotedStr('TR');
    pInsereRegistroFat('PRAVEN','PRAZO MEDIO DE VENDA',VS_strClaVen,strFil);

    strFil := 'GER_TIP_FC = ' + QuotedStr('F');
    pInsereRegistroFat('PRACOM','PRAZO MEDIO DE COMPRA',VS_strClaCom,strFil);

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
    strSQL := strSQL + '  LOCATE(CTR_CODEMP, :CODEMP) > 0 ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CTR_CODEMP ';

    strSQL := 'SELECT CTR_CODEMP, SUM(CTR_TOTDUP) AS TOTDUP, SUM(CTR_DIFERE) AS DIFERE FROM (' + strSQL + ') AS TMP GROUP BY CTR_CODEMP';

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;

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
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := 0.0
      Else
        cdsRelat.FieldByName('REL_LOJ0' + fStrZero(intCont,2)).AsFloat := cdsPraCtr.FieldByName('DIFERE').AsFloat / cdsPraCtr.FieldByName('TOTDUP').AsFloat;
    End;

    cdsPraCtr.Filter   := '';
    cdsPraCtr.Filtered := False;

    If (fFormataFloat(cdsPraCtr.FieldByName('TOTDUP').AsFloat, 2) = 0.0) Then
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
    Else
      cdsRelat.FieldByName('REL_MARGEM').AsFloat := cdsPraCtr.FieldByName('DIFERE').AsFloat / cdsPraCtr.FieldByName('TOTDUP').AsFloat;

    cdsRelat.Post;
  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

end;

procedure TfrmRelEstatAnalResultBan.pCarregaRegimeTributario;
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
  strSQL := strSQL + '   LOCATE(EMP_CODEMP, :CODEMP) > 0 ';

  With qryEmpTri Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := fEmpSelecionadas;
    Open;
  End;
end;

{****************************************}
{* CARREGA SALDO DO PORTADOR            *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaSalPor;
  Var
    strSQL: String;
    cdsClonePor: TUniClientDataSet;
    intContador: Integer;
    strCodEmp: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    For intContador := 1 To 40 Do
      strSQL := strSQL + '  0.00 AS REL_LOJ0' + fStrZero(intContador,2) + ', ';

    strSQL := strSQL + '  REPEAT(" ", 40) AS POR_NOMPOR, ';
    strSQL := strSQL + '  CTB_CODPOR AS POR_CODPOR, ';
    strSQL := strSQL + '  CTB_CODEMP, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C", CTB_VALLAN, - CTB_VALLAN)) AS TOTAL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVBAN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LOCATE(CTB_CODEMP, :CODEMP) > 0 AND ';
    strSQL := strSQL + '  CTB_CODPOR IS NOT NULL AND ';

    If (rdgSalPor.ItemIndex = 0) Then
      strSQL := strSQL + '  IFNULL(CTB_DTACON,0) <> 0 AND ';

    strSQL := strSQL + '  CTB_DTALAN BETWEEN (SELECT POR_DTAINI FROM CADPOR WHERE POR_CODPOR = CTB_CODPOR LIMIT 1) AND :DTAFIN ';
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
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      Open;

      cdsSalPor   := fCriaClientDatset(qryGenerica);
      cdsClonePor := fCriaClientDatset(qryGenerica);

      pSetaClient(cdsSalPor);
      pSetaClient(cdsClonePor);

      cdsSalPor.EmptyDataSet;
      cdsSalPor.LogChanges := False;
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
      End;
      cdsSalPor.LogChanges := True;
      FreeAndNil(cdsClonePor);
      frxSalPor.DataSet := cdsSalPor;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmRelEstatAnalResultBan.lstEmpresasClickCheck(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;
  {*************************************************}
  {* CONTA QUANTAS EMPRESAS JÁ ESTÃO SELECIONADAS  *}
  {**********************************************AF*}
  intContador := fContaSelecoes;

  {****************************************************************************}
  {* SE A QUANTIDADE FOR MAIOR QUE O PERMITIDO ENTÃO NÃO PERMITE MARCAR OUTRA *}
  {*************************************************************************AF*}
  If (intContador > Pred(intMaxColuna)) And (rdgTipOri.ItemIndex = 0) And (rdgOrientacao.Enabled) Then
  Begin
    lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;

    If (intMaxColuna < MAX_COLUNA_PAISAGEM) Then
      fMensagem('ATENÇÃO!', 'Para selecionar mais de 6 empresas opcionais selecione Modo Paisagem!', ['&O k']);
  End;

  If (edtDestino.Text = 'E') And (intContador > 25) Then
  Begin
    lstEmpresas.Checked[lstEmpresas.ItemIndex] := False;
    fMensagem('ATENÇÃO!', 'O relatório suporta no máximo 25 lojas!', ['&O k']);
  End;

end;

function TfrmRelEstatAnalResultBan.fCarregandoDadosRelatorio(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Try
    Result := True;

    pInformacao('Gerando dados para o relatório. Aguarde...', pgbStatus);
    pProgresso(0, 16, pgbStatus);

    cdsRelat.LogChanges := False;

    pCarregaCTP124; //ESSA PROCEDURE DEVE ESTAR EM PRIMEIRO LUGAR
    pProgresso(1, 16, pgbStatus);

    pCarregaVendas;
    pProgresso(2, 16, pgbStatus);

    pCarregaCtaRes;
    pProgresso(3, 16, pgbStatus);

    pCarregaCtaPag;
    pProgresso(4, 16, pgbStatus);

    pCarregaCtaRec;
    pProgresso(5, 16, pgbStatus);

    pCarregaMovCar;
    pProgresso(6, 16, pgbStatus);

    pCarregaCadChq;
    pProgresso(7, 16, pgbStatus);

    pCarregaTransf;
    pProgresso(8, 16, pgbStatus);

    pCarregaBonifi(True);  // SAÍDA
    pProgresso(9, 16, pgbStatus);

    pCarregaBonifi(False); // ENTRADA
    pProgresso(10, 16, pgbStatus);

    pCarregaEstoqu;
    pProgresso(11, 16, pgbStatus);

    pCarregaImobil;
    pProgresso(12, 16, pgbStatus);

    pCarregaAvalia;
    pProgresso(13, 16, pgbStatus);

    pCarregaPraMed;
    pProgresso(14, 16, pgbStatus);

    If chkExibeAcreFin.Checked Then
      pCarregaAcrFin;

    pProgresso(15, 16, pgbStatus);

    pCarregaSalPor;

    cdsRelat.LogChanges := True;

    pProgresso(16, 16, pgbStatus);
  Except
    Result := False;
  End;
end;

{*************************************************}
{* CONTA QUANTAS EMPRESAS JÁ ESTÃO SELECIONADAS  *}
{**********************************************AF*}
function TfrmRelEstatAnalResultBan.fContaSelecoes: Integer;
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

procedure TfrmRelEstatAnalResultBan.lstEmpresasKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: SelectNext(ActiveControl,True,True);
  End;

end;

procedure TfrmRelEstatAnalResultBan.mnuSelTudoClick(Sender: TObject);
begin
  inherited;
  pSelVarios(opMTodos);
end;

procedure TfrmRelEstatAnalResultBan.pSelVarios(Opcao: TSelecao);
  Var
    intCont: Integer;
    intMax : Integer;
Begin

  Case Opcao Of
    opMTodos: Begin

      intMax := fContaSelecoes;

      For intCont := 0 To lstEmpresas.Count -1 Do
      Begin

        If (intMax > Pred(intMaxColuna)) And (rdgTipOri.ItemIndex = 0) Then
          Break;

        If Not lstEmpresas.Checked[intCont] Then
        Begin
          lstEmpresas.Checked[intCont] := True;
          Inc(intMax);
        End;

      End;
    End;

    opDTodos: Begin

      For intCont := 0 To lstEmpresas.Count -1 Do
        lstEmpresas.Checked[intCont] := False;

    End;
  End;

End;

function TfrmRelEstatAnalResultBan.fRetPercentualTributos(
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

function TfrmRelEstatAnalResultBan.fRetRegimeTributario(strCodEmp: String): TTipoRegime;
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

function TfrmRelEstatAnalResultBan.frxQckEstatAnalResult2JUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;

  If (SameText(MethodName, 'fRetTotalVariacao')) Then
  begin
    Result := FormatFloat('#,##0.00', fltTotVar) + '%';
  End;

end;

function TfrmRelEstatAnalResultBan.frxQckEstatAnalResult2MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;

  If (SameText(MethodName, 'fRetTotalVariacao')) Then
  begin
    Result := FormatFloat('#,##0.00', fltTotVar) + '%';
  End;

end;

function TfrmRelEstatAnalResultBan.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
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

function TfrmRelEstatAnalResultBan.fVerificaSeImpSessao(caCampo: TTipoConfigAtiva): Boolean;
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

function TfrmRelEstatAnalResultBan.fVerificaSeImpSessao(ptCampo: TTipoPercentualTributo): Boolean;
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

procedure TfrmRelEstatAnalResultBan.Label2Click(Sender: TObject);
  Var
    curPos: TPoint;
begin
  inherited;

  GetCursorPos(curPos);
  popSel.Popup(curPos.X - 2, curPos.Y - 2);

end;

procedure TfrmRelEstatAnalResultBan.pAtualizaLst;
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

    For intContador := 0 To lstEmpresas.Items.Count -1 Do
    Begin
      If intContador < Pred(intMaxColuna) Then
        lstEmpresas.Checked[intContador] := True;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmRelEstatAnalResultBan.FormShow(Sender: TObject);
begin
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy', VS_Date);
  inherited;
  lblPreCus.Caption := 'Preço utilizado na seção "Estoque": '+fPreInvTitulo;
  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    rdgSalPor.Left    :=  rdgOrientacao.Left;
    rdgSalPor.Width   :=  rdgOrientacao.Width;
    rdgFatura.Visible := False;
  End;
end;

procedure TfrmRelEstatAnalResultBan.lstEmpresasEnter(Sender: TObject);
begin
  inherited;

  If lstEmpresas.Items.Count > 0 Then
    lstEmpresas.Selected[0] := True
  Else
    SelectNext(ActiveControl,True,True);

end;

procedure TfrmRelEstatAnalResultBan.pDesmarcaColunasRetrato;
  Var
    intIndex: Integer;
    intCount: Integer;
Begin

  intCount := 0;

  For intIndex := 0 To lstEmpresas.Count - 1 Do
    If lstEmpresas.Checked[intIndex] Then
    begin

      If intCount >= Pred(intMaxColuna) Then
        lstEmpresas.Checked[intIndex] := False
      Else
        Inc(intCount);

    End;

End;

procedure TfrmRelEstatAnalResultBan.rdgOrientacaoClick(Sender: TObject);
begin
  inherited;

  If (rdgTipOri.ItemIndex = 0) Then
  Begin
    If rdgOrientacao.ItemIndex = 0 Then
    Begin
      intMaxColuna := MAX_COLUNA_RETRATO;

      pDesmarcaColunasRetrato;

    End
    Else
      intMaxColuna := MAX_COLUNA_PAISAGEM;
  End;

end;

procedure TfrmRelEstatAnalResultBan.btnImprimirClick(Sender: TObject);
  Var
    frxRel   : TfrxReport;
    intCont  : Integer;
    strSigla : String;
    qryAux   : TUniQuery;
    lstLista : TStringList;
    strCodCta: String;
    frmAguarde: TfrmGravando;
begin

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
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) )
        Else
        Begin
          lstLista.Add(' ');
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) );
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

    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines := lstLista;
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRelCtpTitContas.btnImprimirClick]');
      End;
    End;

    pFreeAndNil(frmMemo);

    FreeAndNil(qryAux);
    FreeAndNil(lstLista);

    Exit;

  End
  Else
    FreeAndNil(qryAux);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;

  inherited;

  Try

    If blnImprime Then
    Begin
      {**************************************************************}
      {* SE NAO EXISITIR O CAMPO ITE_IMPULT NA TABELA DE INVENTÁRIO *}
      {* TRAVA O PROCESSO. SOLICITADO PELO RONALDO DIA 20/05/2013.  *}
      {************************************************************FC}
      If (Not fVerificaCampoPrcCmpImp(StrToDate(mskDtaIni.Text))) Or
         (Not fVerificaCampoPrcCmpImp(IncMonth(StrToDate(mskDtaIni.Text), -1)))  Then
      Begin
        pnlInfo.Caption := '';
        pnlInfo.Repaint;
        Exit;
      End;

      Try
        btnImprimir.Enabled := False;
        VS_DateFim := StrToDate(mskDtaFin.Text);

        {****************************************}
        {* REMOVENDO AGGREGATES DA MEMORIA      *}
        {*************************************AF*}
        For intCont := 0 To Length(arrSomatorias) -1 Do
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

        pCarregaRegimeTributario;
        cdsRelat.EmptyDataSet;

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

          If rdgOrientacao.ItemIndex = 0 Then
          Begin
            TfrxReportPage(frxRel.Pages[1]).PaperWidth  := 315;
            TfrxReportPage(frxRel.Pages[1]).PaperHeight := 397;
          End;

          frxRel.DotMatrixReport           := False;
          frxRel.PrintOptions.PrintMode    := pmScale;
          frxRel.PrintOptions.PrintOnSheet := 9; //A4

          If rdgExibir.ItemIndex = 0 Then
            TfrxShapeView(frxRel.FindObject('shpCtaRes')).Tag := 0
          Else
            TfrxShapeView(frxRel.FindObject('shpCtaRes')).Tag := 1;

        End;

        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fCarregandoDadosRelatorio;
        frmAguarde.ShowModal;

        If frmAguarde.blnConfirma Then
        Begin
          If edtDestino.Text = 'E' Then
          Begin
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
              End;
            End
            Else
            Begin
              For intCont := 2 To 12 Do
              Begin
                TfrxMemoView(frxRel.FindObject('rllCabLoj' + fStrZero(intCont,2))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLoj' + fStrZero(intCont,3))).Visible    := False;

                TfrxMemoView(frxRel.FindObject('rllCabLojPor' + fStrZero(intCont,2))).Visible := False;
                TfrxMemoView(frxRel.FindObject('rllLojPor' + fStrZero(intCont,3))).Visible    := False;
              End;

              TfrxMemoView(frxRel.FindObject('rllCabLoj01')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllLoj001')).Text      := '';

              TfrxMemoView(frxRel.FindObject('rllCabLoj01')).Visible := True;
              TfrxMemoView(frxRel.FindObject('rllLoj001')).Visible   := True;

              TfrxMemoView(frxRel.FindObject('rllCabLojPor01')).Text    := '';
              TfrxMemoView(frxRel.FindObject('rllLojPor001')).Text      := '';

              TfrxMemoView(frxRel.FindObject('rllCabLojPor01')).Visible  := True;
              TfrxMemoView(frxRel.FindObject('rllLojPor001')).Visible    := True;
            End;

            frxRel.Script.Variables['NOMREL']  := 'RELATORIO DE ANALISE DE RESULTADO (MOVIMENTO BANCÁRIO)';
            frxRel.Script.Variables['PERIODO'] := 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text));
            frxRel.Script.Variables['PARAM1']  := 'COMPOSIÇÃO DE CUSTO: ' + cbbComCus.Text;
            frxRel.Script.Variables['PARAM2']  := '';

            If (rdgSalPor.ItemIndex = 0) Then
              frxRel.Script.Variables['SALPOR'] := 'SALDO DE PORTADORES: SOMENTE REGISTROS CONCILIADOS'
            Else
              frxRel.Script.Variables['SALPOR'] := 'SALDO DE PORTADORES: TODOS OS REGISTROS';

            frxRel.PrintOptions.ShowDialog := fEmptyStr(frxRel.PrintOptions.Printer);;

            If edtDestino.Text = 'V' Then
            Begin
              SetForegroundWindow(Handle);
              pPreviewReport(Self.Name, Self.Caption, frxRel);
            End
            Else
            Begin

              If frxRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);

            End;

          End;
        End;

        FreeAndNil(qryEmpTri);
        pFreeAndNil(frmAguarde);
      Except
        On E: EXception Do
        Begin
          FreeAndNil(qryEmpTri);
          pMensagensErro(E.Message,'[ImprimeAnaliseResultados]');
        End;
      End;

    End;

  Finally
    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
    pSetFocus(mskDtaIni);
  End;

end;

{****************************************}
{* CARREGA CONTAS DO TIPO 1, 2 e 4      *}
{*************************************AF*}
procedure TfrmRelEstatAnalResultBan.pCarregaCTP124;
  Var
    strSQL: String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CONCAT(SUBSTR(CTB_CODCTA,1,2),".",SUBSTR(CTB_CODCTA,3,2),".",SUBSTR(CTB_CODCTA,5,3)) AS CODCTA, ';
    strSQL := strSQL + '  CTB_CODEMP, ';
    strSQL := strSQL + '  CTA_TIPCTA, ';
    strSQL := strSQL + '  CTB_CODCTA, ';
    strSQL := strSQL + '  CTA_DESCTA, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C",CTB_VALLAN,- CTB_VALLAN)) AS CTB_VALLAN  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVBAN ';
    strSQL := strSQL + '  INNER JOIN CADCTA ON CTA_CODCTA = CTB_CODCTA AND CTA_TIPCTA <> "3" ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  LOCATE(CTB_CODEMP, :CODEMP) > 0 ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CTB_CODCTA, ';
    strSQL := strSQL + '  CTB_CODEMP  ';

    strSQL := 'SELECT SQL_NO_CACHE CODCTA, CTB_CODEMP, CTA_TIPCTA, CTB_CODCTA, CTA_DESCTA, SUM(CTB_VALLAN) AS CTB_VALLAN FROM (' + strSQL + ') AS TMP GROUP BY CTB_CODCTA, CTB_CODEMP ';


    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;

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
        Expression    := 'SUM(CTB_VALLAN)';
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

procedure TfrmRelEstatAnalResultBan.pInformacao(strInfo: String;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmRelEstatAnalResultBan.pProgresso(intProgresso, intMaximo: Integer;
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

procedure TfrmRelEstatAnalResultBan.pInsereCentroCustos(strCodEve, strCodCre: String; fltTotVen: Double);
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

      if ( cdsCtaDet.FieldByName('VALPAG').AsFloat = Null ) then
        cdsRelat.FieldByName('VALPAG').AsFloat := 0
      else
        fltTotDes := fltTotDes + cdsCtaDet.FieldByName('VALPAG').AsFloat;

      if ( cdsCtaDet.FieldByName('FAT_TOTVEN').AsFloat = Null ) then
        cdsRelat.FieldByName('FAT_TOTVEN').AsFloat := 0
      else
        fltTotDes := fltTotDes + cdsCtaDet.FieldByName('FAT_TOTVEN').AsFloat;

      //fltTotDes := fltTotDes + IfThen(cdsCtaDet.FieldByName('VALPAG').AsFloat = Null, 0, cdsCtaDet.FieldByName('VALPAG').AsFloat);
      //fltTotVen := fltTotVen + IfThen(TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value = Null, 0, TAggregateField(cdsFaturamento.FieldByName('FAT_TOTVEN')).Value);
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
    strSQL := strSQL + '  B.CTB_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  C.CTA_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA AS DESCTA, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C",-CTB_VALLAN, CTB_VALLAN)) AS VALPAG  ';
    strSQL := strSQL + 'FROM ';
	  strSQL := strSQL + '  MOVBAN B ';
    strSQL := strSQL + '  JOIN CADCTA C ON B.CTB_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
    strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  B.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ';
   	strSQL := strSQL + '  LOCATE(B.CTB_CODEMP, :CODEMP) > 0 AND ';
    strSQL := strSQL + '  R.CRE_CODCRE =:CODCRE ';
    If not fEmptyStr(strCodEve) Then
    Begin
      If strCodEve = SEM_EVENTO Then
        strSQL := strSQL + '  AND B.CTB_CODEVE IS NULL '
      Else
      	 strSQL := strSQL + '  AND B.CTB_CODEVE = :CODEVE ';
    End;

    strSQL := strSQL + 'GROUP BY CODCTA, CODEMP ';

    strSQL := 'SELECT CODEMP, CODCTA, DESCTA, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODCTA, CODEMP ';
    strSQL := strSQL + 'ORDER BY CODCTA ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
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

        If (fFormataFloat(fltTotVen, 2) = 0.0) Then
          cdsRelat.FieldByName('REL_MARGEM').AsFloat := 0.0
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
end;

procedure TfrmRelEstatAnalResultBan.pInsereEvento(strCodCre: String; fltTotVen: Double);
  Var
    strSQL   : String;
    strCodEve: String;
    strEmp   : String;
    intCont  : Integer;
    fltTotCus: Double;
    qryGenGer: TUniQuery;
    cdsAuxDet: TUniClientDataSet;
    cdsCtaDet: TUniClientDataSet;
    cpvCtaDet: TUniDataSetProvider;

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
    strSQL := strSQL + '  CONCAT(E.EVE_CODEVE, "-", E.EVE_DESEVE) AS DESEVE, ';
    strSQL := strSQL + '  B.CTB_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  C.CTA_CODCTA AS CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA AS DESCTA, ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C",-CTB_VALLAN, CTB_VALLAN)) AS VALPAG  ';
    strSQL := strSQL + 'FROM ';
 	  strSQL := strSQL + '  MOVBAN B ';
    strSQL := strSQL + '  JOIN CADCTA C ON B.CTB_CODCTA = C.CTA_CODCTA AND C.CTA_TIPCTA = "3" ';
	  strSQL := strSQL + '  JOIN CTARES R ON R.CRE_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  JOIN CTAGER G ON TRIM(R.CRE_CODCRE) = TRIM(G.CRE_CODCRE) ';
    strSQL := strSQL + '  LEFT JOIN CADEVE E ON E.EVE_CODEVE = B.CTB_CODEVE ';
    strSQL := strSQL + 'WHERE ';
   	strSQL := strSQL + '  B.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ';
   	strSQL := strSQL + '  LOCATE(B.CTB_CODEMP, :CODEMP) > 0 AND ';
    strSQL := strSQL + '  R.CRE_CODCRE = :CODCRE ';

    strSQL := strSQL + 'GROUP BY CODEVE, CODEMP ';

    strSQL := 'SELECT CODEMP, CODEVE, DESEVE, SUM(VALPAG) AS VALPAG FROM (' + strSQL + ') AS TMP GROUP BY CODEVE, CODEMP ';
    strSQL := strSQL + 'ORDER BY IFNULL(CODEVE, 99999) ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
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

        pInsereCentroCustos(IfThen(fEmptyStr(strCodEve), SEM_EVENTO, strCodEve), strCodCre, fltTotVen);

        cdsAuxDet.Next;
      End;

    End;

    FreeAndNil(qryGenGer);
    FreeAndNil(cdsAuxDet);
    FreeAndNil(cdsCtaDet);
    FreeAndNil(cpvCtaDet);

  Except

    On E: Exception Do
      Raise Exception.Create(E.Message);

  End;

End;

{****************************************}
{* CARREGA BONIFICAÇÃO                  *}
{***********************18/06/09**** AM *}
procedure TfrmRelEstatAnalResultBan.pCarregaBonifi(blnSaida : Boolean);
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
    strSQL := strSQL + '  GER_CODEMP, ';
    strSQL := strSQL + '  GER_VLRCON  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  LOCATE(GER_CODEMP, :CODEMP) > 0 AND ';
    If (blnSaida) Then
    Begin
      strSQL := strSQL + '  ((GER_ESPDOC = "BR") ';
      strSQL := strSQL + '    OR ';
      strSQL := strSQL + '   (LOCATE(GER_CLAFIS,' + CLAFIS_BR + ') AND (GER_ESPDOC = "NF" OR GER_ESPDOC = "EL"))) ';
    End
    Else
    Begin
      strSQL := strSQL + '  LOCATE(GER_CLAFIS,' + CLAFIS_BR_ENT + ') ';
    End;

    With qryGenerica Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := fEmpSelecionadas;
      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

      cdsBonifi.Close;
      cdsBonifi.SetProvider(cpvBonifi);
      cpvBonifi.DataSet := qryGenerica;
      cdsBonifi.AggregatesActive := True;

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

procedure TfrmRelEstatAnalResultBan.pGeraExcel;
  var
    arrSintetico: Array [1..33] Of Array [1..2] Of String;
    arrSalPortad: Array [1..33] Of Array [1..2] Of String;

    intCont  : Integer;
    intAux   : Integer;
    intAuxP  : Integer;
    intQtdCol: Integer;
    fltTotal : Double;
    strUltCol: String;
    strLinAnt: String;
    objExcel : TExcel;
    strSigla : String;
    fltTotPor: Double;
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
  arrSintetico[intAux][02] := 'REL_MARGEM';

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

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    LinhaAtual := 1;
    intQtdCol  := intAux;  //Length(arrSintetico);
    strUltCol  := fGetLetraAlfa(intQtdCol);

    pnlInfo.Caption := 'Aguarde... Gerando Arquivo!';

    Escrever(ProximaLinha,01, fRetNomeEmpresa);
    Escrever(ProximaLinha,01, 'RELATORIO DE ANALISE DE RESULTADO (MOVIMENTO BANCARIO)');
    Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));
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
               ((arrSintetico[intCont][02] = 'REL_MARGEM') And
                (arrSintetico[intCont][01] = '')) Then
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

              If arrSintetico[intCont, 01] = 'TOTAL' Then
              Begin
                fltTotal := 0;

                For intAux := 1 to slsEmpresas.Count Do
                  fltTotal := fltTotal + FieldByName('REL_LOJ0' + fStrZero(intAux,2)).AsFloat;

                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PERDES_') > 0 Then
                Begin
                  If FieldByName('REL_CODCAM').AsString <> 'VAREST' Then
                       Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', FieldByName(arrSintetico[intCont+1, 02]).AsFloat))
                  Else
                    Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00%', fltTotVar));
                End
                Else
                  Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', fltTotal));

                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else If arrSintetico[intCont, 02] = 'REL_MARGEM' Then
              Begin
                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PRACTR_PRACOM_PRAVEN_PERDES_') > 0 Then
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
                If Pos(FieldByName('REL_CODCAM').AsString, 'MARCON_MARLIQ_PERREA_VAREST_PERDES_') > 0 Then
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
    intQtdCol := intAuxP;
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

    OrientacaoPagina(Retrato);

    AutoAjuste;
    SalvarArquivo;
    FecharArquivo;

    pnlInfo.Caption := '';

    fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);

  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstatAnalResultBan.DesmarcarTudo1Click(Sender: TObject);
begin
  inherited;
  pSelVarios(opDTodos);
end;

procedure TfrmRelEstatAnalResultBan.edtDestinoChange(Sender: TObject);
begin
  inherited;
  If (Pos(edtDestino.Text, 'E') > 0) Then
  Begin
    rdgTipOri.Enabled     := False;
    rdgOrientacao.Enabled := False;
  End
  Else
  Begin
    rdgTipOri.Enabled     := True;
    rdgOrientacao.Enabled := True;
    rdgOrientacaoClick(Nil);    
  End;
end;

procedure TfrmRelEstatAnalResultBan.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

end.
