unit Romaneio.Types;

interface

uses
  Uni, UniClientDataSet;

type
  TTipoCds = (tpcTmpDoc, tpcRomDet);
  TTipoDevolucao = (tdNaoListaDevolucao, tdListaDevolucaoNFeDV, tdListaDevolucaoPR, tdListaTodasDevolucoes,
                    tdListaResidualDaDevolucaoNF, tdListaTodasDevolucoesAbatendoQtdDevolvida);
  TTipoDocRom    = (tdrFGO, tdrGER, tdrCNF, tdrCRM, tdrRomInvalido);
  TTipoManter    = (tmNenhum, tmSelecionados, tmTodos);
  TTipoTela      = (ttRomaneio, ttRomaneioSimplificado);
  TIncluirTransportadoraDiferente = (itdSim = 1, itdNao = 2, itdApenasEste = 3);
  TModeloBipagem = (mbChaveDeAcesso = 1, mbEtiquetaDeDespacho = 2, mbAutomatico = 3);
  TTipoTabelaTmp = (tbAutInc, tbCRM, tbRomInvalido);

type
  TDadosDocumento = record
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
  end;

type
  TarrayDadosDocumento = array of TDadosDocumento;

type
  TTransporte = record
    strTransportadora: String;
    strPlacaVeiculo: String;
    strMotorista: String;
  end;

type
  TVeiculo = record
    blnTemRom   : Boolean;
    strNumVeic  : String;
    strCodTRansp: string;
    strDesTransp: string;
    strCodMot   : string;
    strDesMot   : string;
    strPlaVeic  : string;
    strCodReg   : string;
    strCodAj1   : string;
    strCodAj2   : string;
    strCodAj3   : string;
    strCodAj4   : string;
    strObsFec   : string;
    fltVlrFre   : Double;
    fltVlrAdi   : Double;
    fltPerFre   : Double;
    fltPeso     : Double;
    fltTotVlr   : Double;
    fltCapCar   : Double;
  end;

type
  TFusion = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strIntFus: String;
    strRomFus: String;
    strLatLon: String;
  end;

type
  TarrayVeiculos = array of TVeiculo;
  TarrayFusion = array of TFusion;

type
  TDadosFiltro = record
    Periodo: Integer;
    DataInicial,
    DataFinal: TDate;
    Dias: Integer;
    CodCidade,
    CodRegiao,
    CodCliente,
    CodProduto,
    CodTransportadora,
    CodRota,
    CodTransFat,
    CodVendedor,
    CodDepartamento,
    CodLinhaGrupo,
    CodLote: String;
    Turno: Integer;
    CodigoBarras : String;
    FIL_CODFIL : String;
  end;

  TDadosDet = record
    NumeroDocumento,
    EspecieDocumento,
    CodEmpresa,
    CodCliente,
    Tip_FC,
    Veicul,
    MarDes,
    Palet: String;
    VolumeBipado : Integer;
    ValorSelecionado: Double;
    OrdemImpressao: Integer;
    cdsRomDet: TUniClientDataSet;
  end;

type
  TDadosTransMot = record
    strCodTra: String;
    strCodMot: String;
    strNumBox: String;
    strCodAj1: String;
    strCodAj2: String;
    strCodAj3: String;
    strCodAj4: String;
    strObsFec: String;
    strPlaVei: String;
    strCodReg: String;
  end;

type
  TDadosRomGer = record
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodVen,
    strCodFor,
    strCodCli,
    strTip_Fc: String;
    dtaDtaEnt,
    tmrHorEnt,
    dtaDtaDoc: TDateTime;
    strConPag,
    strEstado,
    strNomCon,
    strEndCon,
    strBaiCon,
    strCepCon,
    strCidCon,
    strEstCon,
    strTelCon,
    strCgcCpf,
    strCgcCon,
    strIesCon,
    strCli_Rg,
    strRomImp: String;
    fltBasSim,
    fltBasIpi,
    fltAlqIpi,
    fltTotIpi,
    fltBasIcm,
    fltAlqIcm,
    fltTotIcm,
    fltTotRet,
    fltAlqRet,
    fltBasRet,
    fltDesEsp,
    fltVlrCon,
    fltTotPro,
    fltTotCus,
    fltTotMed: Double;
    strTipFre: String;
    fltTotFre,
    fltPesBru,
    fltPesLiq,
    fltVolume: Double;
    strEspeci,
    strMarca,
    strMen001,
    strMen002: String;
    strTipFat,
    strNumFat: String;
    dtaDtaFat: TDateTime;
    strVenFat,
    strCndFat: String;
    fltValFat,
    fltVPar01,
    fltVPar02,
    fltVPar03,
    fltVPar04,
    fltVPar05,
    fltVPar06,
    fltVPar07,
    fltVPar08,
    fltVPar09,
    fltVPar10,
    fltVPar11,
    fltVPar12: Double;
    strSerie,
    strNotEsp,
    strClaFis: String;
    fltPorDes: Double;
    strCodDig,
    strCodCnd,
    strCodFpg: String;
    intOrdImp: Integer;
    fltVlrOri: Double;
    strAutEnt: String;
    strMsgExp,
    strPalet,
    strStatus,
    strNomTab,
    strAutIncGer,
    strMenExp,
    strMenEx2,
    strMenEx3,
    strMenEx4,
    strLocali,
    strLibApp,
    strEvitar: String;
    fltDistan,
    fltTmpEnt: Double;
    strEndEnt,
    strBaiEnt,
    strCepEnt,
    strCidEnt,
    strRefEnt,
    strFilial,
    strIniPar,
    strSeqTra,
    strAltEnd,
    strLatLon: String;
    intPriori: Integer;
    strIntFus,
    strRomFus: String;
    dtaDtaIni,
    hraHorIni: TDateTime;
    strFstSht,
    strFinRot,
    strDefCon: String;
  end;

implementation

end.
