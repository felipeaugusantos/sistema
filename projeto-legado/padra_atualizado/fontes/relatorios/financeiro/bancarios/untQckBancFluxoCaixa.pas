unit untQckBancFluxoCaixa;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, Math, StrUtils,
  Dialogs, StdCtrls, untPaiQck, RLParser, RLReport, RLPreviewForm, DB, UniClientDataSet,
  untTypesSistema;

type
  TfrmQckBancFluxoCaixa = class(TfrmPaiQck)
    rllChqPre: TRLLabel;
    rllCtaReceber: TRLLabel;
    rllCartCred: TRLLabel;
    rllCtaPagar: TRLLabel;
    rlbDtaVen: TRLDBText;
    RLDBText1: TRLDBText;
    rlbChqPre: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    rllTotChq: TRLLabel;
    rllTotCtr: TRLLabel;
    rllTotCar: TRLLabel;
    rllTotCtp: TRLLabel;
    rllTotDia: TRLLabel;
    rlbSaldo: TRLBand;
    rlbSumario2: TRLBand;
    rllTotGerChq: TRLLabel;
    rllTotGerCtr: TRLLabel;
    rllTotGerCar: TRLLabel;
    rllTotGerCtp: TRLLabel;
    RLLabel9: TRLLabel;
    rlbTitulo2: TRLBand;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    rllChqPre2: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    rllCtaPagar2: TRLLabel;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    rllTitPedVen: TRLLabel;
    rllTitPedVen2: TRLLabel;
    rlbPedVen: TRLDBText;
    rllTotPdv: TRLLabel;
    rllTotGerPdv: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel22: TRLLabel;
    rllFilEmp: TRLLabel;
    rllFilPor: TRLLabel;
    pnlSalIni: TRLPanel;
    pnlCtpVen: TRLPanel;
    pnlCtrVen: TRLPanel;
    rlbResPortador: TRLBand;
    rllNomPor: TRLLabel;
    rllValCtr: TRLLabel;
    rlbTotResPortador: TRLBand;
    RLLabel24: TRLLabel;
    rllTotPorCtr: TRLLabel;
    rllTotPorCtp: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel31: TRLLabel;
    RLDBText14: TRLDBText;
    rlbGrupoSintetico: TRLGroup;
    rlSubGrupoSintetico: TRLGroup; 
    rlbDetalheSintetico: TRLBand;
    RLDBText15: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    rlbPedVen2: TRLDBText;
    RLDBText10: TRLDBText;
    RLLabel30: TRLLabel;
    RLDBText11: TRLDBText;
    RLBand1: TRLBand;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    rllPdvSem: TRLLabel;
    RLLabel43: TRLLabel;
    RLBand2: TRLBand;
    RLLabel44: TRLLabel;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    rllTotMes: TRLLabel;
    RLLabel52: TRLLabel;
    RLLabel53: TRLLabel;
    rllPdvMes: TRLLabel;
    RLLabel55: TRLLabel;
    RLDBText16: TRLDBText;
    dtsFluxoCaixa: TDataSource;
    pnl1: TRLPanel;
    rllPedCompra: TRLLabel;
    pnlI1: TRLPanel;
    rllVarDiaria: TRLLabel;
    rllSaldo: TRLLabel;
    rllTpagar1: TRLLabel;
    rllCadPag1: TRLLabel;
    rllCadPag2: TRLLabel;
    pnl2: TRLPanel;
    rllPedCompra2: TRLLabel;
    pnlI2: TRLPanel;
    rllVarDiaria2: TRLLabel;
    RLLabel12: TRLLabel;
    rllTpagar2: TRLLabel;
    pnl3: TRLPanel;
    rllCtrVen: TRLLabel;
    RLLabel25: TRLLabel;
    pnl4: TRLPanel;
    rllCtpVen: TRLLabel;
    RLLabel23: TRLLabel;
    pnl5: TRLPanel;
    rllSalIni: TRLLabel;
    rllSaldoInicial: TRLLabel;
    pnl6: TRLPanel;
    rllPedComp: TRLLabel;
    pnlI3: TRLPanel;
    rllValSal: TRLLabel;
    rllVarDia: TRLLabel;
    rllTpagar3: TRLLabel;
    pnl7: TRLPanel;
    rllTotPed: TRLLabel;
    pnlI4: TRLPanel;
    rllTotSal: TRLLabel;
    rllTotVar: TRLLabel;
    rllTpagar4: TRLLabel;
    rllCadPag4: TRLLabel;
    pnl8: TRLPanel;
    RLLabel2: TRLLabel;
    pnlI5: TRLPanel;
    RLLabel13: TRLLabel;
    RLLabel3: TRLLabel;
    rllTpagar5: TRLLabel;
    pnl9: TRLPanel;
    RLLabel36: TRLLabel;
    pnlI6: TRLPanel;
    RLLabel38: TRLLabel;
    RLLabel37: TRLLabel;
    rllTpagar6: TRLLabel;
    rllCadPag6: TRLLabel;
    pnl10: TRLPanel;
    RLLabel48: TRLLabel;
    pnlI7: TRLPanel;
    RLLabel50: TRLLabel;
    RLLabel49: TRLLabel;
    rllTpagar7: TRLLabel;
    rllCadPag7: TRLLabel;
    pnl11: TRLPanel;
    rllTotGerPed: TRLLabel;
    pnlI8: TRLPanel;
    rllTotGerSal: TRLLabel;
    rllTotGerVar: TRLLabel;
    rllTpagar8: TRLLabel;
    rllCadPag8: TRLLabel;
    rllCadPag3: TRLDBText;
    rllCadPag5: TRLDBText;
    rllImposto: TRLLabel;
    rllImposto2: TRLLabel;
    rllImposto3: TRLDBText;
    rllImposto4: TRLDBResult;
    rllImposto5: TRLDBText;
    rllImposto6: TRLDBResult;
    rllImposto7: TRLDBResult;
    rllImposto8: TRLDBResult;
    rllTextoLeg: TRLLabel;
    rllFatDes: TRLLabel;
    rllDiaCar: TRLLabel;
    rllDiaChq: TRLLabel;
    rllDiaCtr: TRLLabel;
    rllLimDia: TRLLabel;
    rllPreDVi: TRLLabel;
    rllPreDPr: TRLLabel;
    rllTipEmp: TRLLabel;
    dtsListaPortadores: TDataSource;
    RlbPortadores: TRLSubDetail;
    RLBand4: TRLBand;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLBand7: TRLBand;
    rllNomeForm2: TRLLabel;
    RLSystemInfo1: TRLSystemInfo;
    RLBand3: TRLBand;
    rllCaptionPortador: TRLLabel;
    subSalPor: TRLSubDetail;
    rlbTitSalPor: TRLBand;
    rllTitCodPor: TRLLabel;
    rllTitNomPor: TRLLabel;
    rllTitSalPor: TRLLabel;
    rlbDetSalPor: TRLBand;
    rllCodPor: TRLDBText;
    rllNomSalPor: TRLDBText;
    rllSalPor: TRLDBText;
    rlbSumSalPor: TRLBand;
    rllTitSalPort: TRLLabel;
    rllFtrValSalPor: TRLDBResult;
    dtsSalPor: TDataSource;
    rllFtrSalPor: TRLLabel;
    procedure rllOrdemBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetalheGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rllPedCompBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllVarDiaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllValSalBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotChqBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotCtrBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotCarBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotCtpBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotPedBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotVarBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotSalBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerChqBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerCtrBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerCarBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerCtpBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerPedBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerVarBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerSalBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText2BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDtaVenBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel19BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel21BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel18BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel20BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotPdvBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotGerPdvBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText6BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText13BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText12BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbCodigoBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText1BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbCabecalhoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure RLLabel28BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel29BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel31BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLDBText14BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllTotMesBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel52BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel53BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel44BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel45BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllPdvMesBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel46BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel47BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel48BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel49BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure RLLabel55BeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rlbDetalheSinteticoAfterPrint(Sender: TObject);
    procedure rllTpagar3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllTpagar4BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllTpagar6BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllTpagar7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllTpagar8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllCadPag4BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllCadPag8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllCadPag7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbResumoGrupoAfterPrint(Sender: TObject);
    procedure RLBand2AfterPrint(Sender: TObject);
    procedure rlbSumario2AfterPrint(Sender: TObject);
    procedure rllTotDiaBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rllSalPorBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);

  private
    { Private declarations }
    fltPreCom: Double;
    fltPreVen: Double;
    fltChqPre: Double;
    fltCtaRec: Double;
    fltCarCre: Double;
    fltCtaPag: Double;
    fltCtaDes: Double;    
    fltPedCom: Double;
    fltPedVen: Double;
    fltVarDia: Double;
    fltVReceb: Double;

    fltTotCom: Double;
    fltTotVen: Double;
    fltTotChq: Double;
    fltTotRec: Double;
    fltTotCar: Double;
    fltTotPag: Double;
    fltTotDes: Double;    
    fltTotPed: Double;
    fltTotPdv: Double;
    fltTotVar: Double;
    fltTReceb: Double;

    fltMesCom: Double;
    fltMesVen: Double;
    fltMesChq: Double;
    fltMesRec: Double;
    fltMesCar: Double;
    fltMesPag: Double;
    fltMesDes: Double;    
    fltMesPed: Double;
    fltMesPdv: Double;
    fltMesVar: Double;
    fltMReceb: Double;    

    blnPedVen: Boolean;

    dtaMesAno: TDateTime;

    fltTotCtpD: Double;
    fltTotCtpS: Double;
    fltTotCtpM: Double;
    fltTotCtpG: Double;

    function fAdicionaRlLabels(rlpParent: TRLBand;
      rllReferencia: TRLLabel; strTexto: String;
      blnAlinDireita: Boolean = False): TRLLabel;
    procedure pMontaResumoPortador;
  public
    { Public declarations }
    fltFator : Double;
    fltSalIni: Double;

    blnIncPre: Boolean;
    qryResumo: TDataSet;
    qryLista : TDataSet;
    blnImpResumo: Boolean;
    cdsFluxoCaixa : TUniClientDataSet;
    cdsListaPortadores : TUniClientDataSet;
    cdsSalPor : TUniClientDataSet;
    blnQbrMes: Boolean;
    blnPdFlux: Boolean;

    procedure pAtribuiDataSet;
  end;

var
  frmQckBancFluxoCaixa: TfrmQckBancFluxoCaixa;

implementation

uses untFuncoesFactory, untIFuncoes;

{$R *.dfm}

procedure TfrmQckBancFluxoCaixa.rllOrdemBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := strOrdem;
end;

procedure TfrmQckBancFluxoCaixa.rlbDetalheGrupoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
  Var
    fltPedVen: Double;
begin
  inherited;

  dtaMesAno := cdsFluxoCaixa.FieldByName('FLU_DTAVEN').AsDateTime;

  fltPreCom := fltPreCom + cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat;
  fltPreVen := fltPreVen + cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat;
  fltChqPre := fltChqPre + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat;
  fltCtaRec := fltCtaRec + (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);
  fltCarCre := fltCarCre + cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat;
  fltCtaPag := fltCtaPag + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat;
  fltCtaDes := fltCtaDes + cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat;
  fltVReceb := fltVReceb + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                           cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat +
                          (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);

  If blnPedVen Then
    fltVReceb := fltVReceb + cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;

  fltTotCom := fltTotCom + cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat;
  fltTotVen := fltTotVen + cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat;
  fltTotChq := fltTotChq + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat;
  fltTotRec := fltTotRec + (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);
  fltTotCar := fltTotCar + cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat;
  fltTotPag := fltTotPag + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat;
  fltTotDes := fltTotDes + cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat;

  fltMesCom := fltMesCom + cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat;
  fltMesVen := fltMesVen + cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat;
  fltMesChq := fltMesChq + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat;
  fltMesRec := fltMesRec + (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);
  fltMesCar := fltMesCar + cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat;
  fltMesPag := fltMesPag + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat;
  fltMesDes := fltMesDes + cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat;

  If blnPedVen Then
  Begin
    fltMesPdv := fltTotPdv + cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;
    fltTotPdv := fltTotPdv + cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;
  End;

  fltTReceb := fltTReceb + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                           cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat +
                          (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);

  If blnPedVen Then
    fltTReceb := fltTReceb + cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;

  fltMReceb := fltMReceb + cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                           cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat +
                          (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator);

  If blnPedVen Then
    fltMReceb := fltMReceb + cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;

  If blnPedVen Then
    fltPedVen := cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat
  Else
    fltPedVen := 0.0;

  If blnIncPre Then
  Begin
    fltSalIni := fltSalIni +
                 (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                 (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                 cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                 IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) -
                 cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat +
                 cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat +
                 fltPedVen);

  End
  Else
  Begin
    fltSalIni := fltSalIni +
                 (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                 (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                 cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                 cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                 IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) +
                 fltPedVen);

  End;

  fltPedCom := fltPedCom + cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;
  fltMesPed := fltMesPed + cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;
  fltTotPed := fltTotPed + cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;

  fltTotCtpD := fltTotCtpD + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;
  fltTotCtpS := fltTotCtpS + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;
  fltTotCtpM := fltTotCtpM + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;
  fltTotCtpG := fltTotCtpG + cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat;

  If blnPedVen Then
    fltPedVen := cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat
  Else
    fltPedVen := 0.0;

  If blnIncPre Then
  Begin
    fltVarDia := fltVarDia + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) -
                             cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat +
                             fltPedVen);

    fltTotVar := fltTotVar + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) -
                             cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat +
                             fltPedVen);

    fltMesVar := fltMesVar + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) -
                             cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat +
                             cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat +
                             fltPedVen);
  End
  Else
  Begin
    fltVarDia := fltVarDia + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) +
                             fltPedVen);

    fltTotVar := fltTotVar + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) +
                             fltPedVen);

    fltMesVar := fltMesVar + (cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                             (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                             cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                             cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                             IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) +
                             fltPedVen);
  End;

end;

procedure TfrmQckBancFluxoCaixa.rllPedCompBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllVarDiaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
  Var
    fltPedVen: Double;
begin
  inherited;

  If blnPedVen Then
    fltPedVen := cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat
  Else
    fltPedVen := 0.0;

  If blnIncPre Then
  Begin
    Text := FloatToStrF(cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                       (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                       cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                       IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) -
                       cdsFluxoCaixa.FieldByName('FLU_PRECOM').AsFloat +
                       cdsFluxoCaixa.FieldByName('FLU_PREVEN').AsFloat +
                       fltPedVen, ffNumber, 15, 2);
  End
  Else
  Begin
    Text := FloatToStrF(cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                       (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                       cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat -
                       cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat -
                       IfThen(Not blnPdFlux,0,cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat) +
                       fltPedVen, ffNumber, 15, 2);
  End;

end;

procedure TfrmQckBancFluxoCaixa.rllValSalBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  
  Text := FloatToStrF(fltSalIni,ffNumber,15,2);

end;

procedure TfrmQckBancFluxoCaixa.rllTotChqBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltChqPre,ffNumber,15,2);
  fltChqPre := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotCtrBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltCtaRec,ffNumber,15,2);
  fltCtaRec := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotDiaBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;

  If blnQbrMes Then
    Text := UpperCase(FormatDateTime('mmm/yy',dtaMesAno)) + ':';

end;

procedure TfrmQckBancFluxoCaixa.rllTotCarBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltCarCre,ffNumber,15,2);
  fltCarCre := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotCtpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltCtaPag,ffNumber,15,2);
  fltCtaPag := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotPedBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltPedCom,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTotVarBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltVarDia,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTpagar3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;

  Text := FloatToStrF(cdsFluxoCaixa.FieldByName('FLU_CTAPAG').AsFloat +
                      cdsFluxoCaixa.FieldByName('FLU_CTADES').AsFloat +
                      cdsFluxoCaixa.FieldByName('FLU_CTAIMP').AsFloat +
                      cdsFluxoCaixa.FieldByName('FLU_PEDCOM').AsFloat,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTpagar4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotCtpD,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTpagar6BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotCtpS,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTpagar7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotCtpM,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTpagar8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotCtpG,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTotSalBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltSalIni,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerChqBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltTotChq,ffNumber,15,2);
  fltTotChq := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerCtrBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltTotRec,ffNumber,15,2);
  fltTotRec := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerCarBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin

  inherited;
  Text := FloatToStrF(fltTotCar,ffNumber,15,2);
  fltTotCar := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerCtpBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltTotPag,ffNumber,15,2);
  fltTotPag := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerPedBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotPed,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerVarBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltTotVar,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerSalBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltSalIni,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rllSalPorBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;

  Text := FloatToStrF(fStrToFloat(Text), ffNumber, 15, 2);
end;

procedure TfrmQckBancFluxoCaixa.RLDBText2BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.rlbDtaVenBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not fEmptyStr(Text) Then
    Text := FormatDateTime('dd/mm/yy',StrToDate(Text));
    
end;

procedure TfrmQckBancFluxoCaixa.rlbResumoGrupoAfterPrint(Sender: TObject);
begin
  inherited;
  fltPedCom  := 0;
  fltVarDia  := 0;
  fltTotCtpD := 0;
  fltTotCtpS := 0;
  fltCtaRec  := 0;
end;

procedure TfrmQckBancFluxoCaixa.rlbSumario2AfterPrint(Sender: TObject);
begin
  inherited;
  fltTotPed := 0;
  fltTotVar := 0;
  fltTotCtpG := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel19BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltPreVen := 0;

  Text      := FloatToStrF(fltPreVen,ffNumber,15,2);
  fltPreVen := 0;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel21BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltTotCom := 0;

  Text      := FloatToStrF(fltTotCom,ffNumber,15,2);
  fltTotCom := 0;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel18BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltPreCom := 0;

  Text      := FloatToStrF(fltPreCom,ffNumber,15,2);
  fltPreCom := 0;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel20BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltTotVen := 0;

  Text      := FloatToStrF(fltTotVen,ffNumber,15,2);
  fltTotVen := 0;

end;

procedure TfrmQckBancFluxoCaixa.rllTotPdvBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltPedVen,ffNumber,15,2);
  fltPedVen := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllTotGerPdvBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltTotPdv,ffNumber,15,2);
  fltTotPdv := 0;
end;

procedure TfrmQckBancFluxoCaixa.FormCreate(Sender: TObject);
begin
  inherited;
  If (fCfgSis('PDVFLX') <> 'S') Then
  Begin
    rllTitPedVen.Visible  := False;
    rllTitPedVen2.Visible := False;
    rlbPedVen.Visible     := False;
    rlbPedVen2.Visible    := False;
    rllTotPdv.Visible     := False;
    rllTotGerPdv.Visible  := False;
    rllPdvSem.Visible     := False;
    rllPdvMes.Visible     := False;
    blnPedVen             := False;
  End
  Else
    blnPedVen := True;

  blnImpResumo := False;
  blnQbrMes    := False;

  {fltPreCom  := 0;
  fltPreVen  := 0;
  fltChqPre  := 0;
  fltCtaRec  := 0;
  fltCarCre  := 0;
  fltCtaPag  := 0;
  fltCtaDes  := 0;
  fltPedCom  := 0;
  fltPedVen  := 0;
  fltVarDia  := 0;
  fltVReceb  := 0;
  fltTotCom  := 0;
  fltTotVen  := 0;
  fltTotChq  := 0;
  fltTotRec  := 0;
  fltTotCar  := 0;
  fltTotPag  := 0;
  fltTotDes  := 0;
  fltTotPed  := 0;
  fltTotPdv  := 0;
  fltTotVar  := 0;
  fltTReceb  := 0;
  fltMesCom  := 0;
  fltMesVen  := 0;
  fltMesChq  := 0;
  fltMesRec  := 0;
  fltMesCar  := 0;
  fltMesPag  := 0;
  fltMesDes  := 0;
  fltMesPed  := 0;
  fltMesPdv  := 0;
  fltMesVar  := 0;
  fltMReceb  := 0;
  fltTotCtpD := 0;
  fltTotCtpS := 0;
  fltTotCtpM := 0;
  fltTotCtpG := 0;   }

end;

procedure TfrmQckBancFluxoCaixa.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

  If Not blnPdFlux Then
  Begin
    rllPedCompra.Visible  := False;
    rllPedCompra2.Visible := False;
    rllPedComp.Visible    := False;
    rllTotPed.Visible     := False;
    RLLabel2.Visible      := False;
    RLLabel36.Visible     := False;
    RLLabel48.Visible     := False;
    rllTotGerPed.Visible  := False;
  End;
  
end;

procedure TfrmQckBancFluxoCaixa.RLBand2AfterPrint(Sender: TObject);
begin
  inherited;
  fltMesPed := 0;
  fltMesVar := 0;
  fltTotCtpM := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLDBText7BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    Text := '0.00';

end;

procedure TfrmQckBancFluxoCaixa.RLDBText6BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    Text := '0.00';

end;

procedure TfrmQckBancFluxoCaixa.RLDBText13BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    Text := '0.00';

end;

procedure TfrmQckBancFluxoCaixa.RLDBText12BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    Text := '0.00';
  
end;

procedure TfrmQckBancFluxoCaixa.rlbCodigoBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := 'Codigo: ' + Text;
end;

procedure TfrmQckBancFluxoCaixa.RLDBText1BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  Text := 'CLIENTE/FORNECEDOR: ' + cdsFluxoCaixa.FieldByName('FLU_CODIGO').AsString + '-' + Text;

end;

function TfrmQckBancFluxoCaixa.fAdicionaRlLabels(rlpParent: TRLBand;
  rllReferencia: TRLLabel; strTexto: String; blnAlinDireita: Boolean = False): TRLLabel;
  Var
    rllTemp: TRLLabel;
begin
  rllTemp := TRLLabel.Create(qckPagina);
  With rllTemp Do
  Begin
    AutoSize   := False;
    Parent     := rlpParent;

    If blnAlinDireita Then
      Alignment  := taRightJustify;

    Left       := rllReferencia.Left;
    Height     := rllReferencia.Height;
    Top        := rllReferencia.Top + rllReferencia.Height + 6;
    Width      := rllReferencia.Width;
    Caption    := strTexto;

    Font       := rllReferencia.Font;
  End;

  Result := rllTemp;
end;

procedure TfrmQckBancFluxoCaixa.rlbCabecalhoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  If blnImpResumo Then
  Begin
    pMontaResumoPortador;
    blnImpResumo := False;
  End
  Else
  Begin
    rlbResPortador.Visible := False;
    rlbTotResPortador.Visible := False;
  End;
end;

procedure TfrmQckBancFluxoCaixa.pAtribuiDataSet;
begin
  dtsFluxoCaixa.DataSet := cdsFluxoCaixa;
  dtsListaPortadores.DataSet := cdsListaPortadores;
  dtsSalPor.DataSet := cdsSalPor;
end;

procedure TfrmQckBancFluxoCaixa.pMontaResumoPortador;
  Var
    rllNomPorTmp: TRLLabel;
    rllValCtrTmp: TRLLabel;
    strNomPor: String;
begin

  If qryResumo.IsEmpty Then
  Begin
    rlbResPortador.Visible := False;
    rlbTotResPortador.Visible := False;
  End
  Else
  Begin
    rlbResPortador.Visible := True;
    rlbTotResPortador.Visible := True;
    qryResumo.First;

    strNomPor := qryResumo.FieldByName('NOMPOR').AsString;

    rllNomPor.Caption := strNomPor;
    rllValCtr.Caption := FloatToStrF(qryResumo.FieldByName('VALDUP').AsFloat, ffNumber, 12, 2);

    qryResumo.Next;

    rllNomPorTmp := rllNomPor;
    rllValCtrTmp := rllValCtr;

    While (Not qryResumo.Eof) Do
    Begin

      strNomPor := qryResumo.FieldByName('NOMPOR').AsString;

      rllNomPorTmp := fAdicionaRlLabels(rlbResPortador, rllNomPorTmp,
        strNomPor, False);
      rllValCtrTmp := fAdicionaRlLabels(rlbResPortador, rllValCtrTmp,
        FloatToStrF(qryResumo.FieldByName('VALDUP').AsFloat, ffNumber, 12, 2), True);

      rlbResPortador.Height := rlbResPortador.Height + rllNomPorTmp.Height + 6;

      qryResumo.Next;
    End;

  End;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel28BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
  Var
    fltPedidoVenda: Double;
begin
  inherited;

  If Not blnPedVen Then
    fltPedidoVenda := 0
  Else
    fltPedidoVenda := cdsFluxoCaixa.FieldByName('FLU_PEDVEN').AsFloat;

  Text := FormatFloat('##,#0.00', cdsFluxoCaixa.FieldByName('FLU_CHQPRE').AsFloat +
                                  (cdsFluxoCaixa.FieldByName('FLU_CTAREC').AsFloat * fltFator) +
                                  cdsFluxoCaixa.FieldByName('FLU_MOVCAR').AsFloat +
                                  fltPedidoVenda);
end;

procedure TfrmQckBancFluxoCaixa.RLLabel29BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltVReceb,ffNumber,15,2);
  fltVReceb := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel31BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  inherited;
  Text := FloatToStrF(fltTReceb,ffNumber,15,2);
  fltTReceb := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLDBText14BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  If Not fEmptyStr(Text) Then
    Text := UpperCase(AnsiReplaceStr(FormatDateTime('ddd',StrToDate(Text)),'á','a'));
end;

procedure TfrmQckBancFluxoCaixa.rllTotMesBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := UpperCase(FormatDateTime('mmm/yy',dtaMesAno)) + ':';
end;

procedure TfrmQckBancFluxoCaixa.RLLabel52BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltMesCom := 0;

  Text      := FloatToStrF(fltMesCom,ffNumber,15,2);
  fltMesCom := 0;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel53BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;

  If Not blnIncPre Then
    fltMesVen := 0;

  Text      := FloatToStrF(fltMesVen,ffNumber,15,2);
  fltMesVen := 0;

end;

procedure TfrmQckBancFluxoCaixa.RLLabel44BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltMesChq,ffNumber,15,2);
  fltMesChq := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel45BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltMesRec,ffNumber,15,2);
  fltMesRec := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllPdvMesBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltMesPdv,ffNumber,15,2);
  fltMesPdv := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel46BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltMesCar,ffNumber,15,2);
  fltMesCar := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel47BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltMesPag,ffNumber,15,2);
  fltMesPag := 0;
end;

procedure TfrmQckBancFluxoCaixa.RLLabel48BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltMesPed,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.RLLabel49BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltMesVar,ffNumber,15,2);
end;

procedure TfrmQckBancFluxoCaixa.RLLabel55BeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  inherited;
  Text := FloatToStrF(fltMReceb,ffNumber,15,2);
  fltMReceb := 0;
end;

procedure TfrmQckBancFluxoCaixa.rlbDetalheSinteticoAfterPrint(
  Sender: TObject);
begin
  inherited;
  If (rlbDetalheSintetico.Color = Cor1) Then
    rlbDetalheSintetico.Color := Cor2
  Else
    rlbDetalheSintetico.Color := Cor1;
end;

procedure TfrmQckBancFluxoCaixa.rllCadPag4BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltCtaDes,ffNumber,15,2);
  fltCtaDes := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllCadPag8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltTotDes,ffNumber,15,2);
  fltTotDes := 0;
end;

procedure TfrmQckBancFluxoCaixa.rllCadPag7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text      := FloatToStrF(fltMesDes,ffNumber,15,2);
  fltMesDes := 0;
end;

end.

