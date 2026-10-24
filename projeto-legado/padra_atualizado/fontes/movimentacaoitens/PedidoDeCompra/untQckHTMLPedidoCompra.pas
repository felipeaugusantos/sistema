unit untQckHTMLPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniClientDataSet, DB,   Uni,
  frxClass, frxDBSet, frxExportPDF, frxExportXLS, MemDS, DBAccess,
  untFuncoesSimples, untTipoFreteAtc;

type
  TfrmQckHTMLPedidoCompra = class(TForm)
    frxPagina: TfrxReport;
    frxExportaPDF: TfrxPDFExport;
    frxRelatorio: TfrxDBDataset;
    frxPedido: TfrxDBDataset;
    qryRelatorio: TUniQuery;
    qryPedido: TUniQuery;
    frxTransp: TfrxDBDataset;
    frxEmpresa: TfrxDBDataset;
    qryEmpresa: TUniQuery;
    qryTransp: TUniQuery;
    qryPedidoPCG_NUMPED: TStringField;
    qryPedidoPCG_CODEMP: TStringField;
    qryPedidoPCG_ESPDOC: TStringField;
    qryPedidoPCG_CODFOR: TStringField;
    qryPedidoPCG_CODTRA: TStringField;
    qryPedidoPCG_CONPAG: TStringField;
    qryPedidoPCG_DTAENT: TDateField;
    qryPedidoPCG_HORENT: TTimeField;
    qryPedidoPCG_DTAPED: TDateField;
    qryPedidoPCG_COMPRA: TStringField;
    qryPedidoPCG_TOTIPI: TFloatField;
    qryPedidoPCG_TOTITE: TFloatField;
    qryPedidoPCG_TOTGER: TFloatField;
    qryPedidoPCG_VALCBS: TFloatField;
    qryPedidoPCG_VALIBS: TFloatField;
    qryPedidoPCG_VAL_IS: TFloatField;
    qryPedidoPCG_OBS001: TStringField;
    qryPedidoPCG_OBS002: TStringField;
    qryPedidoPCG_OBS003: TStringField;
    qryPedidoPCG_OBS004: TStringField;
    qryPedidoPCG_OBS005: TStringField;
    qryPedidoPCG_ATENCA: TStringField;
    qryPedidoAUTOINCREM: TStringField;
    qryPedidoPCG_BAIXAD: TSmallintField;
    qryPedidoPCG_TOTSUB: TFloatField;
    qryPedidoPCG_OBSPD1: TStringField;
    qryPedidoPCG_OBSPD2: TStringField;
    qryPedidoPCG_OBSPD3: TStringField;
    qryPedidoPCG_TIPFRE: TStringField;
    qryPedidoPCG_PEDVEN: TStringField;
    qryPedidoPCG_DOCORI: TStringField;
    qryPedidoPCG_NUMCTN: TIntegerField;
    qryPedidoPCG_PEDIMP: TStringField;
    qryPedidoPCG_JAEMIT: TSmallintField;
    qryPedidoPCG_DTAEMI: TDateField;
    qryPedidoPCG_VALEMI: TFloatField;
    qryPedidoPCG_DOCEMI: TStringField;
    qryPedidoPCG_ESPEMI: TStringField;
    qryPedidoFOR_CODFOR: TStringField;
    qryPedidoFOR_CODATI: TStringField;
    qryPedidoFOR_CODCID: TStringField;
    qryPedidoFOR_NOMFOR: TStringField;
    qryPedidoFOR_DTACAD: TDateField;
    qryPedidoFOR_NOMFAN: TStringField;
    qryPedidoFOR_ENDERE: TStringField;
    qryPedidoFOR_BAIRRO: TStringField;
    qryPedidoFOR_C_E_P_: TStringField;
    qryPedidoFOR_CGCCPF: TStringField;
    qryPedidoFOR_C_G_C_: TStringField;
    qryPedidoFOR_I_E_S_: TStringField;
    qryPedidoFOR_CONTAT: TStringField;
    qryPedidoFOR_CAIPOS: TStringField;
    qryPedidoFOR_FONE01: TStringField;
    qryPedidoFOR_FONE02: TStringField;
    qryPedidoFOR_F_A_X_: TStringField;
    qryPedidoFOR_EMAIL_: TStringField;
    qryPedidoFOR_HOMEPA: TStringField;
    qryPedidoFOR_CNDPAG: TStringField;
    qryPedidoFOR_CODEMP: TStringField;
    qryPedidoAUTOINCREM_1: TStringField;
    qryPedidoFOR_QTDETI: TIntegerField;
    qryPedidoFOR_PERCOM: TFloatField;
    qryPedidoFOR_NUMRG_: TStringField;
    qryPedidoFOR_MATREV: TStringField;
    qryPedidoFOR_OBSERV: TMemoField;
    qryPedidoFOR_NOMCID: TStringField;
    qryRelatorioPCD_NUMPED: TStringField;
    qryRelatorioPCD_CODEMP: TStringField;
    qryRelatorioPCD_ESPDOC: TStringField;
    qryRelatorioAUTOINCREM: TStringField;
    qryRelatorioPCD_CODITE: TStringField;
    qryRelatorioPCD_DTAENT: TDateField;
    qryRelatorioPCD_DTAPED: TDateField;
    qryRelatorioPCD_CONPAG: TStringField;
    qryRelatorioPCD_QTDITE: TFloatField;
    qryRelatorioPCD_TOTITE: TFloatField;
    qryRelatorioPCD_PERIPI: TFloatField;
    qryRelatorioPCD_TOTIPI: TFloatField;
    qryRelatorioPCD_ALQCBS: TFloatField;
    qryRelatorioPCD_ALQIBS: TFloatField;
    qryRelatorioPCD_ALQ_IS: TFloatField;
    qryRelatorioPCD_VALCBS: TFloatField;
    qryRelatorioPCD_VALIBS: TFloatField;
    qryRelatorioPCD_VAL_IS: TFloatField;
    qryRelatorioVALCBS: TFloatField;
    qryRelatorioVALIBS: TFloatField;
    qryRelatorioVAL_IS: TFloatField;
    qryRelatorioBASCBS: TFloatField;
    qryRelatorioBASIBS: TFloatField;
    qryRelatorioBAS_IS: TFloatField;
    qryRelatorioPCD_QTDBAI: TFloatField;
    qryRelatorioPCD_TOTBAI: TFloatField;
    qryRelatorioPCD_IPIBAI: TFloatField;
    qryRelatorioPCD_BAIXAD: TSmallintField;
    qryRelatorioPCD_CODFOR: TStringField;
    qryRelatorioPCD_HORPED: TTimeField;
    qryRelatorioPCD_PERSUB: TFloatField;
    qryRelatorioPCD_TOTSUB: TFloatField;
    qryRelatorioPCD_SUBBAI: TFloatField;
    qryRelatorioPCD_DOCORI: TStringField;
    qryRelatorioPCD_NUMCTN: TIntegerField;
    qryRelatorioPCD_PEDIMP: TStringField;
    qryRelatorioPCD_JAEMIT: TSmallintField;
    qryRelatorioPCD_DTAEMI: TDateField;
    qryRelatorioPCD_VALEMI: TFloatField;
    qryRelatorioPCD_DOCEMI: TStringField;
    qryRelatorioPCD_ESPEMI: TStringField;
    qryRelatorioPCD_PEDTXT: TStringField;
    qryRelatorioITE_CODITE: TStringField;
    qryRelatorioITE_CODEMP: TStringField;
    qryRelatorioITE_CODABF: TStringField;
    qryRelatorioITE_CODUNI: TStringField;
    qryRelatorioITE_CODMAR: TStringField;
    qryRelatorioITE_CODFOR: TStringField;
    qryRelatorioITE_DESITE: TStringField;
    qryRelatorioITE_REFERE: TStringField;
    qryRelatorioITE_CODFAB: TStringField;
    qryRelatorioITE_DTACAD: TDateField;
    qryRelatorioITE_CODBAR: TStringField;
    qryRelatorioITE_CLAIPI: TStringField;
    qryRelatorioITE_INCPIS: TStringField;
    qryRelatorioITE_COMLUB: TStringField;
    qryRelatorioITE_PESOIT: TFloatField;
    qryRelatorioITE_ITEATI: TStringField;
    qryRelatorioAUTOINCREM_1: TStringField;
    qryRelatorioITE_CODSIM: TStringField;
    qryRelatorioITE_ITEBAS: TStringField;
    qryRelatorioITE_CNV_ML: TFloatField;
    qryRelatorioITE_EMBALA: TFloatField;
    qryRelatorioITE_MSGLV1: TStringField;
    qryRelatorioITE_MSGLV2: TStringField;
    qryRelatorioITE_MARBAS: TStringField;
    qryRelatorioITE_CODVEL: TStringField;
    qryRelatorioITE_APLICA: TMemoField;
    qryRelatorioITE_TMPGAR: TSmallintField;
    qryRelatorioITE_FATCNV: TFloatField;
    qryRelatorioITE_CODFIN: TStringField;
    qryRelatorioITE_CODAGR: TStringField;
    qryRelatorioITE_DESFLZ: TStringField;
    qryRelatorioITE_RECFLZ: TIntegerField;
    qryRelatorioITE_CODFLZ: TStringField;
    qryRelatorioITE_TECFLZ: TIntegerField;
    qryRelatorioITE_VALFLZ: TIntegerField;
    qryRelatorioITE_TIPFLZ: TStringField;
    qryRelatorioITE_PORFLZ: TStringField;
    qryRelatorioITE_VALCAL: TIntegerField;
    qryRelatorioITE_PERCAL: TIntegerField;
    qryRelatorioITE_VCARBO: TIntegerField;
    qryRelatorioITE_PCARBO: TIntegerField;
    qryRelatorioITE_VPROTE: TIntegerField;
    qryRelatorioITE_PPROTE: TIntegerField;
    qryRelatorioITE_VGORTO: TFloatField;
    qryRelatorioITE_PGORTO: TIntegerField;
    qryRelatorioITE_VGORSA: TFloatField;
    qryRelatorioITE_PGORSA: TIntegerField;
    qryRelatorioITE_VCOLES: TIntegerField;
    qryRelatorioITE_PCOLES: TIntegerField;
    qryRelatorioITE_PFIBAL: TIntegerField;
    qryRelatorioITE_VCALCI: TFloatField;
    qryRelatorioITE_PCALCI: TIntegerField;
    qryRelatorioITE_VFERRO: TFloatField;
    qryRelatorioITE_PFERRO: TIntegerField;
    qryRelatorioITE_VSODIO: TIntegerField;
    qryRelatorioITE_PSODIO: TIntegerField;
    qryRelatorioITE_ITEPIG: TStringField;
    qryRelatorioITE_SETFLZ: TStringField;
    qryRelatorioMAR_DESMAR: TStringField;
    qryTranspTRA_CODTRA: TStringField;
    qryTranspTRA_CODCID: TStringField;
    qryTranspTRA_NOMTRA: TStringField;
    qryTranspTRA_DTACAD: TDateField;
    qryTranspTRA_ENDERE: TStringField;
    qryTranspTRA_BAIRRO: TStringField;
    qryTranspTRA_C_E_P_: TStringField;
    qryTranspTRA_C_G_C_: TStringField;
    qryTranspTRA_I_E_S_: TStringField;
    qryTranspTRA_FONE01: TStringField;
    qryTranspTRA_FONE02: TStringField;
    qryTranspTRA_F_A_X_: TStringField;
    qryTranspTRA_NUMPLA: TStringField;
    qryTranspTRA_CONTAT: TStringField;
    qryTranspTRA_EMAIL_: TStringField;
    qryTranspTRA_HOMEPA: TStringField;
    qryTranspTRA_CODEMP: TStringField;
    qryTranspAUTOINCREM: TStringField;
    qryTranspTRA_NOMFAN: TStringField;
    qryTranspTRA_CGCCPF: TIntegerField;
    qryTranspTRA_NOMCID: TStringField;
    qryEmpresaEMP_CODEMP: TStringField;
    qryEmpresaEMP_NOMEMP: TStringField;
    qryEmpresaEMP_ENDERE: TStringField;
    qryEmpresaEMP_NOMCID: TStringField;
    qryEmpresaEMP_FONE01: TStringField;
    qryEmpresaEMP_F_A_X_: TStringField;
    frxExportaXLS: TfrxXLSExport;
    qryRelatorioLITROS: TFloatField;
    qryEmpresaEMP_C_G_C_: TStringField;
    qryEmpresaEMP_I_E_S_: TStringField;
    qryRelatorioUNI_SIGUNI: TStringField;
    qryEmpresaEMP_EMAILC: TStringField;
    qryPedidoPCG_VALFRE: TFloatField;
    qryRelatorioPESOIT: TFloatField;
    qryRelatorioPCD_ENTREG: TStringField;
    qryRelatorioPCD_CODACA: TStringField;
    qryRelatorioPCD_EMPACA: TStringField;
    qryRelatorioPCD_PROACA: TStringField;
    qryRelatorioITE_DESFAB: TStringField;
    qryRelatorioITE_OBRCPF: TStringField;
    qryRelatorioITE_CPRCEN: TStringField;
    qryRelatorioITE_INFLAM: TStringField;
    qryRelatorioITE_DTAALT: TDateField;
    qryRelatorioITE_NVLGIR: TStringField;
    qryRelatorioITE_CADPAI: TStringField;
    qryRelatorioITE_MLTCOM: TFloatField;
    qryRelatorioITE_MLTVEN: TFloatField;
    qryRelatorioPCD_DESITE: TStringField;
    qryRelatorioITE_VFIBAL: TFloatField;
    qryPedidoPCG_DESACE: TFloatField;
    qryPedidoPCG_DTAFAT: TDateField;
    qryRelatorioQTDITE: TFloatField;
    qryRelatorioTOTITE: TFloatField;
    qryRelatorioTOTIPI: TFloatField;
    qryRelatorioTOTSUB: TFloatField;
    qryPedidoPCG_NOMENT: TStringField;
    qryPedidoPCG_ENDENT: TStringField;
    qryPedidoPCG_CIDENT: TStringField;
    qryEmpresaEMP_BAIRRO: TStringField;
    qryEmpresaEMP_C_E_P_: TStringField;
    qryRelatorioPCD_DESUNI: TFloatField;
    qryRelatorioUNITAR: TFloatField;
    qryRelatorioPCD_DESUN2: TFloatField;
    qryPedidoCOMPRA: TStringField;
    qryPedidoOPE_E_MAIL: TStringField;
    qryPedidoOPE_NEXTEL: TStringField;
    qryPedidoOPE_RAMAL1: TStringField;
    qryPedidoOPE_FONE01: TStringField;
    frxPaginaPaisagem: TfrxReport;
    frxPaginaReforma: TfrxReport;
    frxPaginaPaisagemReforma: TfrxReport;
    qryRelatorioSIGEMB: TStringField;
    qryPedidoPCG_BASCOF: TFloatField;
    qryPedidoPCG_VALCOF: TFloatField;
    qryPedidoPCG_BASPIS: TFloatField;
    qryPedidoPCG_VALPIS: TFloatField;
    qryPedidoPCG_BASICM: TFloatField;
    qryPedidoPCG_VALICM: TFloatField;
    qryPedidoPCG_BASIPI: TFloatField;
    qryPedidoPCG_BASSUB: TFloatField;
    cdsPedidoPCG_PAGVIS: TStringField;
    qryRelatorioLOCFIS: TStringField;
    qryPedidoENDERE: TStringField;
    qryRelatorioTOTKIL: TFloatField;
    qryRelatorioTOTLIT: TFloatField;
    qryRelatorioLOCSUP: TStringField;
    qryRelatorioITE_APLFAB: TStringField;
    qryPedidoPCG_ORCORI: TStringField;
    qryRelatorioPCD_DESUN3: TFloatField;
    qryRelatorioPCD_DESUN4: TFloatField;
    qryRelatorioPCD_DESUN5: TFloatField;
    qryRelatorioPCD_DESUN6: TFloatField;
    qryRelatorioICMDES: TFloatField;
    qryRelatorioDESPIS: TFloatField;
    qryRelatorioSUBFCP: TFloatField;
    qryRelatorioPCD_SUBFCP: TFloatField;
    qryPedidoPCG_SUBFCP: TFloatField;
    frxTranspRedesp: TfrxDBDataset;
    qryTranspRedes: TUniQuery;
    qryTranspRedesTRA_CODTRA: TStringField;
    qryTranspRedesTRA_CODCID: TStringField;
    qryTranspRedesTRA_NOMTRA: TStringField;
    qryTranspRedesTRA_DTACAD: TDateField;
    qryTranspRedesTRA_ENDERE: TStringField;
    qryTranspRedesTRA_BAIRRO: TStringField;
    qryTranspRedesTRA_C_E_P_: TStringField;
    qryTranspRedesTRA_C_G_C_: TStringField;
    qryTranspRedesTRA_I_E_S_: TStringField;
    qryTranspRedesTRA_FONE01: TStringField;
    qryTranspRedesTRA_FONE02: TStringField;
    qryTranspRedesTRA_F_A_X_: TStringField;
    qryTranspRedesTRA_NUMPLA: TStringField;
    qryTranspRedesTRA_CONTAT: TStringField;
    qryTranspRedesTRA_EMAIL_: TStringField;
    qryTranspRedesTRA_HOMEPA: TStringField;
    qryTranspRedesTRA_CODEMP: TStringField;
    qryTranspRedesAUTOINCREM: TStringField;
    qryTranspRedesTRA_NOMFAN: TStringField;
    qryTranspRedesTRA_CGCCPF: TIntegerField;
    qryTranspRedesTRA_NOMCID: TStringField;
    qryPedidoPCG_CODTRR: TStringField;
    qryPedidoPCG_PEDBON: TStringField;
    qryPedidoPCG_TOTDAR: TFloatField;
    qryRelatorioTOTDAR: TFloatField;
    qryRelatorioPCD_TOTDAR: TFloatField;
    qryPedidoPCG_CODCMP: TStringField;
    qryPedidoPCG_TIPFAB: TStringField;
    qryRelatorioUNILIQ: TFloatField;
    qryPedidoPCG_OBS006: TStringField;
    qryPedidoPCG_OBSPD4: TStringField;
    qryPedidoPCG_OBSPD5: TStringField;
    qryPedidoPCG_OBSPD6: TStringField;
    procedure FormCreate(Sender: TObject);
    function frxPaginaUserFunction(const MethodName: String; var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckHTMLPedidoCompra: TfrmQckHTMLPedidoCompra;

implementation

uses untFuncoesGenerica;

{$R *.dfm}

procedure TfrmQckHTMLPedidoCompra.FormCreate(Sender: TObject);
  Var
    blnZonaFranca: Boolean;
begin
  frxPagina.AddFunction('function fFormataCondPag(strCond : String): String');
  frxPaginaReforma.AddFunction('function fFormataCondPag(strCond : String): String');
  TfrxMemoView(frxPagina.FindObject('rllQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTPC', varInteger));
  TfrxMemoView(frxPaginaReforma.FindObject('rllQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTPC', varInteger));
  frxPagina.Script.Variables['strFatPed'] := fCfgSis('FATPED', varString);
  frxPaginaReforma.Script.Variables['strFatPed'] := fCfgSis('FATPED', varString);

  frxPaginaPaisagem.AddFunction('function fFormataCondPag(strCond : String): String');
  frxPaginaPaisagemReforma.AddFunction('function fFormataCondPag(strCond : String): String');
  TfrxMemoView(frxPaginaPaisagem.FindObject('rllQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTPC', varInteger));
  TfrxMemoView(frxPaginaPaisagemReforma.FindObject('rllQtdIte')).DisplayFormat.FormatStr := fMskDigitos(fCfgSis('DEQTPC', varInteger));
  frxPaginaPaisagem.Script.Variables['strFatPed'] := fCfgSis('FATPED', varString);
  frxPaginaPaisagemReforma.Script.Variables['strFatPed'] := fCfgSis('FATPED', varString);

  frxPagina.AddFunction('function fFormataFone(fone: String): String');
  frxPaginaReforma.AddFunction('function fFormataFone(fone: String): String');
  frxPaginaPaisagem.AddFunction('function fFormataFone(fone: String): String');
  frxPaginaPaisagemReforma.AddFunction('function fFormataFone(fone: String): String');

  frxPagina.AddFunction('function fDescricaoFrete(strTipo: String): String');
  frxPaginaReforma.AddFunction('function fDescricaoFrete(strTipo: String): String');
  frxPaginaPaisagem.AddFunction('function fDescricaoFrete(strTipo: String): String;');
  frxPaginaPaisagemReforma.AddFunction('function fDescricaoFrete(strTipo: String): String;');

  If Not fCfgSis('ENTITE', varBoolean) Then
  Begin
    TfrxMemoView(frxPagina.FindObject('mmoTitDtaEnt')).Visible := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoTitDtaEnt')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('mmoDtaEnt')).Visible    := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoDtaEnt')).Visible    := False;

    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoTitDtaEnt')).Visible := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoTitDtaEnt')).Visible := False;
    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoDtaEnt')).Visible    := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoDtaEnt')).Visible    := False;
  End;

  If Not fCfgSis('DARROR', varBoolean) Then
  Begin
    TfrxMemoView(frxPagina.FindObject('mmoTitDar')).Visible := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoTitDar')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('mmoValDar')).Visible := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoValDar')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('mmoAstDare')).Visible := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoAstDare')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('mmoMsgDare')).Visible  := False;
    TfrxMemoView(frxPaginaReforma.FindObject('mmoMsgDare')).Visible  := False;

    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoTitDarIte')).Visible := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoTitDarIte')).Visible := False;
    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoValDarIte')).Visible := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoValDarIte')).Visible := False;
    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoTitDar')).Visible    := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoTitDar')).Visible    := False;
    TfrxMemoView(frxPaginaPaisagem.FindObject('mmoValDar')).Visible    := False;
    TfrxMemoView(frxPaginaPaisagemReforma.FindObject('mmoValDar')).Visible    := False;
  End;


  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  frxPaginaPaisagem.FindObject('mmoTitIcmDes').Visible := blnZonaFranca;
  frxPaginaPaisagemReforma.FindObject('mmoTitIcmDes').Visible := blnZonaFranca;
  frxPaginaPaisagem.FindObject('mmoIcmDes').Visible    := blnZonaFranca;
  frxPaginaPaisagemReforma.FindObject('mmoIcmDes').Visible    := blnZonaFranca;
  frxPaginaPaisagem.FindObject('linIcmDes').Visible    := blnZonaFranca;
  frxPaginaPaisagemReforma.FindObject('linIcmDes').Visible    := blnZonaFranca;

  frxPaginaPaisagem.FindObject('mmoTitDesPis').Visible := blnZonaFranca;
  frxPaginaPaisagemReforma.FindObject('mmoTitDesPis').Visible := blnZonaFranca;
  frxPaginaPaisagem.FindObject('mmoDesPis').Visible    := blnZonaFranca;
  frxPaginaPaisagemReforma.FindObject('mmoDesPis').Visible    := blnZonaFranca;

  frxPagina.FindObject('chiIcmDes').Visible            := blnZonaFranca;
  frxPaginaReforma.FindObject('chiIcmDes').Visible            := blnZonaFranca;

  pSetaCodIte(qryRelatorioPCD_CODITE);
  pSetaCodIte(qryRelatorioITE_CODITE);

  qryRelatorioITE_REFERE.Size := fTamRefere;
end;

function TfrmQckHTMLPedidoCompra.frxPaginaUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
  Begin
    Result := UpperCase(fFormataCondPag(Params[0]));
    Result := Copy(Result, 5, Length(Result)) + ' D.D.L.'
  End

  Else If SameText(MethodName, 'fFormataFone') Then
    Result := fFormataFone(Params[0])

  Else If SameText(MethodName, 'fDescricaoFrete') Then
  Begin
    If fDescricaoFrete(Params[0]) <> 'Inválido' Then
      Result := fDescricaoFrete(Params[0])
    Else
      Result := '';
  End;

end;

end.

