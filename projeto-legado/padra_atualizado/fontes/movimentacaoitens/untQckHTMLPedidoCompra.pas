unit untQckHTMLPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UniClientDataSet, DB,   Uni,
  frxClass, frxDBSet, frxExportPDF, frxExportXLS, MemDS, DBAccess;

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
    qryRelatorioPCD_DESITE: TStringField;
    qryRelatorioPCD_QTDITE: TFloatField;
    qryRelatorioPCD_UNITAR: TFloatField;
    qryRelatorioPCD_TOTITE: TFloatField;
    qryRelatorioPCD_PERIPI: TFloatField;
    qryRelatorioPCD_TOTIPI: TFloatField;
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
    qryRelatorioITE_IMPLIS: TStringField;
    qryRelatorioITE_ITEATI: TStringField;
    qryRelatorioAUTOINCREM_1: TStringField;
    qryRelatorioITE_QTDETI: TIntegerField;
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
    qryRelatorioITE_VFIBAL: TIntegerField;
    qryRelatorioITE_PFIBAL: TIntegerField;
    qryRelatorioITE_VCALCI: TFloatField;
    qryRelatorioITE_PCALCI: TIntegerField;
    qryRelatorioITE_VFERRO: TFloatField;
    qryRelatorioITE_PFERRO: TIntegerField;
    qryRelatorioITE_VSODIO: TIntegerField;
    qryRelatorioITE_PSODIO: TIntegerField;
    qryRelatorioITE_ITEPIG: TStringField;
    qryRelatorioITE_SETFLZ: TStringField;
    qryRelatorioITE_MLTCOM: TIntegerField;
    qryRelatorioITE_MLTVEN: TIntegerField;
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
    procedure FormCreate(Sender: TObject);
    function frxPaginaUserFunction(const MethodName: String;
      var Params: Variant): Variant;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQckHTMLPedidoCompra: TfrmQckHTMLPedidoCompra;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmQckHTMLPedidoCompra.FormCreate(Sender: TObject);
begin
  frxPagina.AddFunction('function fFormataCondPag(strCond : String): String');
  qryRelatorioITE_REFERE.Size := fTamRefere;
end;

function TfrmQckHTMLPedidoCompra.frxPaginaUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  If MethodName = 'FFORMATACONDPAG' Then
    Result := UpperCase(fFormataCondPag(Params[0]));

end;

end.

