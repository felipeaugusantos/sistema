unit untProdutosAcabadosIndustrial;

interface

uses SysUtils, Uni, Classes, UniClientDataSet,
     Variants, StrUtils, ComCtrls, Forms, untIteBar, untTypesSistema, untPreAlt_Trigger;

Type
  TIndCampos = Record
    strTabela: String;
    strCampo: String;
End;

Type
  TFiltro = class
    strCodGra    : String;
    strCodAca    : String;
    strLinGruGra : String;
    strLinGruAca : String;
    strDepGra    : String;
    strDepAca    : String;
    strRefGra    : String;
    strRefAca    : String;
end;

Type

  TProdutosAcabados = class
    private
      FCodIte: String;
      FCodGru: String;
      FRefere: String;
      FCodMar: String;
      FCodFor: String;
      FCodUni: String;
      FCodAbf: String;
      FAbfPis: String;
      FAbfCof: String;
      FAbfIpi: String;
      FImpDir: String;
      FIncPis: String;
      FClaIpi: String;
      FComLub: String;
      FIteAti: String;
      FAtiCom: String;
      FPesOit: String;
      FPesLiq: String;      
      FIteBas: String;
      FUsaBon: String;
      FUsaFle: String;
      FValObr: String;
      FCnv_Ml: String;
      FItePig: String;
      FNvlGir: String;
      FMsgLv1: String;
      FMsgLv2: String;
      FAplica: String;
      FInfLam: String;
      FTmpGar: Integer;
      FInfGar: String;
      FRspGar: String;
      FExpSit: String;
      FExpPok: String;
      FExpApp: String;
      FCodGpr: String;
      FIndRev: String;
      FCodOpe: String;
      FUniCom: String;
      FUniTri: String;
      FFatUTr: Double;
      FObrCpf: String;
      FObrIba: String;
      FMltCom: String;
      FMltVen: String;
      FCodMon: String;
      FSitPro: String;
      FBarEmb: String;
      FSetFlz: String;
      FCodVel: String;
      FCodBar: String;
      FTipPro: String;
      //exportacao site
      FDesSit: String;
      FDadTec: String;
      FNomIte: String;
      FAplIte: String;
      FIncLus: String;
      FExpAlt: Double;
      FExpLar: Double;
      FExpPro: Double;
      FUrlImg: String;
      FCprCen: String;
      FMenFis: String;
      FCodOnu: String;
      FIpiSai: String;
      FSitPrd: String;
      FCodLay: String;

      //Complemento
      FComp01: String;
      FComp02: String;
      FComp03: String;
      FComp04: String;
      FComp05: String;
      FComp06: String;
      FComp07: String;
      FComp08: String;
      FComp09: String;
      FComp10: String;

      FstrPraVal: String;
      FstrDesFab: String;
      FstrCDCEST: String;
      FstrNivGir: String;
      FstrPrdGru: String;


      //Decimais arredondamento
      FIncDec: Integer;

      FCodIteGer: String; //usado somente aqui;
      FCodFabGer: String; //usado somente aqui;

      arrDescricao: Array Of TIndCampos;
      arrCodigoFabrica: Array Of TIndCampos;

      FobjFiltro : TFiltro;

      strAgrupadorPreAlt: String;

      FstlAbfIteger: TStringList;

      procedure pZeraValores;
      procedure pLendoCamposDescricao(strCampos: String);
      procedure pLendoCamposCodigoFabrica(strCampos: String);

      function fProximoCodigo(strNomeTabela: String; const strCampoBusca : String): String;
      function fRetornaDescricaoDoProdutoAcabado(strCodUni, strCodCor, strCodIte: String): String;
      function fRetornaCodigoFabricaDoProdutoAcabado(strCodUni, strCodCor, strCodIte: String): String;
      function fRetornaCamposConfigurados(strNomeCampo: String): String;
      function fRetornaSQLConsultaCfgSis: String;
      function fCountCampos(strCampos: String; strSeparador: String): Integer;
      function fRetornaParteDaDescricao(strTabela, strCampo, strCodUni, strCodCor, strCodIte: String): String;
      function fRetornaParteDoCodigaDaFabrica(strTabela, strCampo, strCodUni, strCodCor, strCodIte: String; blnRetZer: Boolean): String;
      function fRetornaSQLDescricao(strTabela, strCampo, strCodUni, strCodCor, strCodIte: String): String;
      function fRetornaSQLCodigoFabrica(strTabela, strCampo, strCodUni, strCodCor, strCodIte: String): String;
      function fRetornaCampoChave(strTabela: String): String;
      function fRetornaParametroChave(strTabela, strCodUni, strCodCor, strCodIte: String): String;
      function fExisteCodigoDeFabricao(strCodFab: String): Boolean;
      function fRetornaPrecoCompraProdutoAcabado(strCodUni, strCodCom, strCodCor: String): Double;
      function fRetornaLitragemUnidade(strCodUni: String): Double;
      function fRetornaComposicaoProdutoAcabado(strCodCom: String): Double;
      function fRetornaCustoProdutoComposicao(strCodIteCom: String): Double;
      function fRetornaTipoUnidade(strCodUni: String): String;
      function fAtualizaPrecoAcabado(strCodAca: String; fltPreCom: Double; blnMargem: Boolean): Boolean;
      function fExisteComplemento(strCodIte : String): Boolean;
      procedure pRetornaProdutoSeExisteCodigoDeFabricao(strCodFab: String; Var strCodPro, strDespro: String);
      function fRetornaCodigoAbreviacao(const Lista: TStringList; const strCodEmpresa: string): String;

      function getCDCEST: String;
      function getDesFab: String;
      function getPraVal: String;
      function getNivGir: String;
      function getPrdGru: String;

      procedure setCDCEST(const Value: String);
      procedure setDesFab(const Value: String);
      procedure setPraVal(const Value: String);
      procedure setNivGir(const Value: String);
      procedure setPrdGru(const Value: String);
      procedure pAtualizaPrecosProdutosAcabados(strCodigoProdutoGranel, strCodigoCor, strAutoIncremGEIMAT : String; fltPesoReal : double);

      function getComp01: String;
      function getComp02: String;
      function getComp03: String;
      function getComp04: String;
      function getComp05: String;
      function getComp06: String;
      function getComp07: String;
      function getComp08: String;
      function getComp09: String;
      function getComp10: String;

      procedure setComp01(const Value: String);
      procedure setComp02(const Value: String);
      procedure setComp03(const Value: String);
      procedure setComp04(const Value: String);
      procedure setComp05(const Value: String);
      procedure setComp06(const Value: String);
      procedure setComp07(const Value: String);
      procedure setComp08(const Value: String);
      procedure setComp09(const Value: String);
      procedure setComp10(const Value: String);

    protected


      function getCodIte: String;
      function getCodGru: String;
      function getRefere: String;
      function getCodMar: String;
      function getCodFor: String;
      function getCodUni: String;
      function getCodAbf: String;
      function getAbfPis: String;
      function getAbfCof: String;
      function getAbfIpi: String;
      function getImpDir: String;
      function getIncPis: String;
      function getClaIpi: String;
      function getComLub: String;
      function getIteAti: String;
      function getAtiCom: String;
      function getPesOit: String;
      function getPesLiq: String;
      function getIteBas: String;
      function getUsaBon: String;
      function getUsaFle: String;
      function getValObr: String;
      function getCnv_Ml: String;
      function getItePig: String;
      function getNvlGir: String;
      function getMsgLv1: String;
      function getMsgLv2: String;
      function getAplica: String;
      function getInfLam: String;
      function getTmpGar: Integer;
      function getInfGar: String;
      function getRspGar: String;
      function getExpSit: String;
      function getExpPok: String;
      function getExpApp: String;
      function getCodGpr: String;
      function getIndRev: String;
      function getCodOpe: String;
      function getUniCom: String;
      function getUniTri: String;
      function getFatUTr: Double;
      function getObrCpf: String;
      function getObrIba: String;
      function getMltCom: String;
      function getMltVen: String;
      function getCodMon: String;
      function getSitPro: String;
      function getBarEmb: String;
      function getSetFlz: String;
      function getCodVel: String;
      function getCodBar: String;
      function getDesSit: String;
      function getDadTec: String;
      function getNomIte: String;
      function getAplIte: String;
      function getIncLus: String;
      function getExpAlt: Double;
      function getExpLar: Double;
      function getExpPro: Double;
      function getUrlImg: String;
      function getIncDec: Integer;
      function getCodOnu: String;
      function getCprCen: String;
      function getIpiSai: String;
      function getMenFis: String;
      function getTipPro: String;
      function getCodLay: String;
      function getAbfIteger: TStringList;

      procedure setCodIte(const Value: String);
      procedure setCodGru(const Value: String);
      procedure setRefere(const Value: String);
      procedure setCodMar(const Value: String);
      procedure setCodFor(const Value: String);
      procedure setCodUni(const Value: String);
      procedure setCodAbf(const Value: String);
      procedure setAbfPis(const Value: String);
      procedure setAbfCof(const Value: String);
      procedure setAbfIpi(const Value: String);
      procedure setImpDir(const Value: String);
      procedure setIncPis(const Value: String);
      procedure setClaIpi(const Value: String);
      procedure setComLub(const Value: String);
      procedure setIteAti(const Value: String);
      procedure setAtiCom(const Value: String);
      procedure setPesOit(const Value: String);
      procedure setPesLiq(const Value: String);
      procedure setIteBas(const Value: String);
      procedure setUsaBon(const Value: String);
      procedure setUsaFle(const Value: String);
      procedure setValObr(const Value: String);
      procedure setCnv_Ml(const Value: String);
      procedure setItePig(const Value: String);
      procedure setNvlGir(const Value: String);
      procedure setMsgLv1(const Value: String);
      procedure setMsgLv2(const Value: String);
      procedure setAplica(const Value: String);
      procedure setInfLam(const Value: String);
      procedure setTmpGar(const Value: Integer);
      procedure setInfGar(const Value: String);
      procedure setRspGar(const Value: String);
      procedure setExpSit(const Value: String);
      procedure setExpPok(const Value: String);
      procedure setExpApp(const Value: String);
      procedure setCodGpr(const Value: String);
      procedure setIndRev(const Value: String);
      procedure setCodOpe(const Value: String);
      procedure setUniCom(const Value: String);
      procedure setUniTri(const Value: String);
      procedure setFatUTr(const Value: Double);
      procedure setObrCpf(const Value: String);
      procedure setObrIba(const Value: String);
      procedure setMltCom(const Value: String);
      procedure setMltVen(const Value: String);
      procedure setCodMon(const Value: String);
      procedure setSitPro(const Value: String);
      procedure setBarEmb(const Value: String);
      procedure setSetFlz(const Value: String);
      procedure setCodVel(const Value: String);
      procedure setCodBar(const Value: String);
      procedure setDesSit(const Value: String);
      procedure setDadTec(const Value: String);
      procedure setNomIte(const Value: String);
      procedure setAplIte(const Value: String);
      procedure setIncLus(const Value: String);
      procedure setExpAlt(const Value: Double);
      procedure setExpLar(const Value: Double);
      procedure setExpPro(const Value: Double);
      procedure setUrlImg(const Value: String);
      procedure setIncDec(const Value: Integer);
      procedure setCodOnu(const Value: String);
      procedure setCprCen(const Value: String);
      procedure setIpiSai(const Value: String);
      procedure setMenFis(const Value: String);
      procedure setTipPro(const Value: String);
      procedure setCodLay(const Value: String);
      procedure setAbfIteger(const Value: TStringList);

      procedure pCalculaAndSetPesos(strCodPagP, strCodCorP, strCodUniP, strCodComP : String);

      procedure pLimpaFiltro;
    public

      Constructor Create;
      Destructor Destroy; override;

      function fAtualizaCustos(blnMargem: Boolean;
                               prgProgresso: TProgressBar): Boolean;
      function fRetornaPrecoCustoProdutoAGranel(strCodCor, strTipUni: String): Double;
      function fInserirProdutosAcabados(ArrayUnidades, ArrayCores, ArrayComposicao: Array of String; strCodIte: String; Var strMsgAdi: String; Var stlProdutosAcabados: TStringList): Boolean;
      procedure pInsereProdutosAcabadosIteGer(strCodUni, strCodCom, strCodCor: String);
      procedure pInsereProdutosExportacaoSite;
      procedure pInsereLayout;
      procedure pInsereComplemento;
      function fPopulaStringListAbfIteger(strCodigoItem: String): TStringList;

      property strCodIte: String Read getCodIte Write setCodIte;
      property strCodGru: String Read getCodGru Write setCodGru;
      property strRefere: String Read getRefere Write setRefere;
      property strCodMar: String Read getCodMar Write setCodMar;
      property strCodFor: String Read getCodFor Write setCodFor;
      property strCodUni: String Read getCodUni Write setCodUni;
      property strCodAbf: String Read getCodAbf Write setCodAbf;
      property strAbfPis: String Read getAbfPis Write setAbfPis;
      property strAbfCof: String Read getAbfCof Write setAbfCof;
      property strAbfIpi: String Read getAbfIpi Write setAbfIpi;
      property strImpDir: String Read getImpDir Write setImpDir;
      property strIncPis: String Read getIncPis Write setIncPis;
      property strClaIpi: String Read getClaIpi Write setClaIpi;
      property strComLub: String Read getComLub Write setComLub;
      property strIteAti: String Read getIteAti Write setIteAti;
      property strAtiCom: String Read getAtiCom Write setAtiCom;
      property strPesOit: String Read getPesOit Write setPesOit;
      property strPesLiq: String Read getPesLiq Write setPesliq;
      property strIteBas: String Read getIteBas Write setIteBas;
      property strUsaBon: String Read getUsaBon Write setUsaBon;
      property strUsaFle: String read getUsaFle write setUsaFle;
      property strValObr: String Read getValObr Write setValObr;
      property strCnv_Ml: String Read getCnv_Ml Write setCnv_Ml;
      property strItePig: String Read getItePig Write setItePig;
      property strNvlGir: String Read getNvlGir Write setNvlGir;
      property strMsgLv1: String Read getMsgLv1 Write setMsgLv1;
      property strMsgLv2: String Read getMsgLv2 Write setMsgLv2;
      property strAplica: String Read getAplica Write setAplica;
      property strInfLam: String Read getInfLam Write setInfLam;
      property strTmpGar: Integer Read getTmpGar Write setTmpGar;
      property strInfGar: String Read getInfGar Write setInfGar;
      property strRspGar: String Read getRspGar Write setRspGar;
      property strExpSit: String Read getExpSit Write setExpSit;
      property strExpPok: String Read getExpPok Write setExpPok;
      property strExpApp: String Read getExpApp Write setExpApp;
      property strCodGpr: String Read getCodGpr Write setCodGpr;
      property strIndRev: String Read getIndRev Write setIndRev;
      property strCodOpe: String Read getCodOpe Write setCodOpe;
      property strUniCom: String Read getUniCom Write setUniCom;
      property strUniTri: String Read getUniTri Write setUniTri;
      property fltFatUTr: Double Read getFatUTr Write setFatUTr;
      property strObrCpf: String Read getObrCpf Write setObrCpf;
      property strObrIba: String Read getObrIba Write setObrIba;
      property strMltCom: String Read getMltCom Write setMltCom;
      property strMltVen: String Read getMltVen Write setMltVen;
      property strCodMon: String Read getCodMon Write setCodMon;
      property strSitPro: String Read getSitPro Write setSitPro;
      property strBarEmb: String Read getBarEmb Write setBarEmb;
      property strSetFlz: String Read getSetFlz Write setSetFlz;
      property strCodVel: String Read getCodVel Write setCodVel;
      property strCodBar: String Read getCodBar Write setCodBar;
      property strDesSit: String Read getDesSit Write setDesSit;
      property strDadTec: String Read getDadTec Write setDadTec;
      property strNomIte: String Read getNomIte Write setNomIte;
      property strAplIte: String Read getAplIte Write setAplIte;
      property strIncLus: String Read getIncLus Write setIncLus;
      property fltExpAlt: Double Read getExpAlt Write setExpAlt;
      property fltExpLar: Double Read getExpLar Write setExpLar;
      property fltExpPro: Double Read getExpPro Write setExpPro;
      property strUrlImg: String Read getUrlImg Write setUrlImg;
      property intIncDec: Integer Read getIncDec Write setIncDec;
      property strTipPro: String Read getTipPro Write setTipPro;

      property strCprCen: String Read getCprCen Write setCprCen;
      property strMenFis: String Read getMenFis Write setMenFis;
      property strCodOnu: String Read getCodOnu Write setCodOnu;
      property strIpiSai: String Read getIpiSai Write setIpiSai;
      property strSitPrd: String Read FSitPrd   Write FSitPrd;

      property strCDCEST: String Read getCDCEST Write setCDCEST;
      property strDesFab: String Read getDesFab write setDesFab;
      property strPraVal: String Read getPraVal Write setPraval;
      property strNivGir: String Read getNivGir Write setNivGir;
      property strPrdGru: String Read getPrdGru Write setPrdGru;
      property strCodLay: String Read getCodLay Write setCodLay;

      //Complemento
      property strComp01: String Read getComp01 Write setComp01;
      property strComp02: String Read getComp02 Write setComp02;
      property strComp03: String Read getComp03 Write setComp03;
      property strComp04: String Read getComp04 Write setComp04;
      property strComp05: String Read getComp05 Write setComp05;
      property strComp06: String Read getComp06 Write setComp06;
      property strComp07: String Read getComp07 Write setComp07;
      property strComp08: String Read getComp08 Write setComp08;
      property strComp09: String Read getComp09 Write setComp09;
      property strComp10: String Read getComp10 Write setComp10;

      property objFiltro: TFiltro Read FobjFiltro write FobjFiltro;
      property stlAbfIteger: TStringList Read getAbfIteger write setAbfIteger;


  End;

implementation

Uses
  untParCalculaPrecoCusto, untPreAlt, Data.DB, untSaldoPedidoCompra,
  untfuncoesSimples, untTConfiguracao, untOrdProIndustrial, untCadLote;

{ TProdutosAcabados }

constructor TProdutosAcabados.Create;
begin
  FobjFiltro := TFiltro.Create;

  FstlAbfIteger := TStringList.Create;
  pZeraValores;
end;

destructor TProdutosAcabados.Destroy;
begin
  pFreeAndNil(FobjFiltro);
  pFreeAndNil(FstlAbfIteger);
  inherited;
end;

function TProdutosAcabados.getAbfCof: String;
begin
  Result := FAbfCof;
end;

function TProdutosAcabados.getAbfIpi: String;
begin
  Result := FAbfIpi;
end;

function TProdutosAcabados.getAbfIteger: TStringList;
begin
  Result := FstlAbfIteger;
end;

function TProdutosAcabados.getAbfPis: String;
begin
  Result := FAbfPis;
end;

function TProdutosAcabados.getAplica: String;
begin
  Result := FAplica;
end;

function TProdutosAcabados.getAplIte: String;
begin
  Result := FAplIte;
end;

function TProdutosAcabados.getAtiCom: String;
begin
  Result := FAtiCom;
end;

function TProdutosAcabados.getBarEmb: String;
begin
  Result := FBarEmb;
end;

function TProdutosAcabados.getClaIpi: String;
begin
  Result := FClaIpi;
end;

function TProdutosAcabados.getCnv_Ml: String;
begin
  Result := FCnv_Ml;
end;

function TProdutosAcabados.getCodAbf: String;
begin
  Result := FCodAbf;
end;

function TProdutosAcabados.getCodBar: String;
begin
  Result := FCodBar;
end;

function TProdutosAcabados.getCodFor: String;
begin
  Result := FCodFor;
end;

function TProdutosAcabados.getCodGpr: String;
begin
  Result := FCodGpr;
end;

function TProdutosAcabados.getCodGru: String;
begin
  Result := FCodGru;
end;

function TProdutosAcabados.getCodIte: String;
begin
  Result := FCodIte;
end;

function TProdutosAcabados.getCodLay: String;
begin
  Result := FCodLay;
end;

function TProdutosAcabados.getCodMar: String;
begin
  Result := FCodMar;
end;

function TProdutosAcabados.getCodMon: String;
begin
  Result := FCodMon;
end;

function TProdutosAcabados.getCodOnu: String;
begin
  Result := FCodOnu;
end;

function TProdutosAcabados.getCodOpe: String;
begin
  Result := FCodOpe;
end;

function TProdutosAcabados.getCodUni: String;
begin
  Result := FCodUni;
end;

function TProdutosAcabados.getCodVel: String;
begin
  Result := FCodVel;
end;

function TProdutosAcabados.getComLub: String;
begin
  Result := FComLub;
end;

function TProdutosAcabados.getComp01: String;
begin
  Result := FComp01;
end;

function TProdutosAcabados.getComp02: String;
begin
  Result := FComp02;
end;

function TProdutosAcabados.getComp03: String;
begin
  Result := FComp03;
end;

function TProdutosAcabados.getComp04: String;
begin
  Result := FComp04;
end;

function TProdutosAcabados.getComp05: String;
begin
  Result := FComp05;
end;

function TProdutosAcabados.getComp06: String;
begin
  Result := FComp06;
end;

function TProdutosAcabados.getComp07: String;
begin
  Result := FComp07;
end;

function TProdutosAcabados.getComp08: String;
begin
  Result := FComp08;
end;

function TProdutosAcabados.getComp09: String;
begin
  Result := FComp09;
end;

function TProdutosAcabados.getComp10: String;
begin
  Result := FComp10;
end;

function TProdutosAcabados.getCprCen: String;
begin
  Result := FCprCen;
end;

function TProdutosAcabados.getDadTec: String;
begin
  Result := FDadTec;
end;

function TProdutosAcabados.getDesSit: String;
begin
  Result := FDesSit;
end;

function TProdutosAcabados.getExpAlt: Double;
begin
  Result := FExpAlt;
end;

function TProdutosAcabados.getExpLar: Double;
begin
  Result := FExpLar;
end;

function TProdutosAcabados.getExpPro: Double;
begin
  Result := FExpPro;
end;

function TProdutosAcabados.getExpSit: String;
begin
  Result := FExpSit;
end;

function TProdutosAcabados.getFatUTr: Double;
begin
  Result := FFatUtr;
end;

function TProdutosAcabados.getExpPok: String;
begin
  Result := FExpPok;
end;

function TProdutosAcabados.getExpApp: String;
begin
  Result := FExpApp;
end;

function TProdutosAcabados.getImpDir: String;
begin
  Result := FImpDir;
end;

function TProdutosAcabados.getIncDec: Integer;
begin
  Result := FIncDec;
end;

function TProdutosAcabados.getIncLus: String;
begin
  Result := FIncLus;
end;

function TProdutosAcabados.getIncPis: String;
begin
  Result := FIncPis;
end;

function TProdutosAcabados.getIndRev: String;
begin
  Result := FIndRev;
end;

function TProdutosAcabados.getInfGar: String;
begin
  Result := FInfGar;
end;

function TProdutosAcabados.getRspGar: String;
begin
  Result := FRspGar;
end;

function TProdutosAcabados.getInfLam: String;
begin
  Result := FInfLam;
end;

function TProdutosAcabados.getIpiSai: String;
begin
  Result := FIpiSai;
end;

function TProdutosAcabados.getIteAti: String;
begin
  Result := FIteAti;
end;

function TProdutosAcabados.getIteBas: String;
begin
  Result := FIteBas;
end;

function TProdutosAcabados.getItePig: String;
begin
  Result := FItePig;
end;

function TProdutosAcabados.getMenFis: String;
begin
  Result := FMenFis;
end;

function TProdutosAcabados.getMltCom: String;
begin
  Result := FMltCom;
end;

function TProdutosAcabados.getMltVen: String;
begin
  Result := FMltVen;
end;

function TProdutosAcabados.getMsgLv1: String;
begin
  Result := FMsgLv1;
end;

function TProdutosAcabados.getMsgLv2: String;
begin
  Result := FMsgLv2;
end;

function TProdutosAcabados.getNomIte: String;
begin
  Result := FNomIte;
end;

function TProdutosAcabados.getNvlGir: String;
begin
  Result := FNvlGir;
end;

function TProdutosAcabados.getObrCpf: String;
begin
  Result := FObrCpf;
end;

function TProdutosAcabados.getObrIba: String;
begin
  Result := FObrIba;
end;

function TProdutosAcabados.getPesOit: String;
begin
  Result := FPesOit;
end;

function TProdutosAcabados.getPesLiq: String;
begin
  Result := FPesLiq;
end;

function TProdutosAcabados.getRefere: String;
begin
  Result := FRefere;
end;

function TProdutosAcabados.getSetFlz: String;
begin
  Result := FSetFlz;
end;

function TProdutosAcabados.getSitPro: String;
begin
  Result := FSitPro;
end;

function TProdutosAcabados.getTipPro: String;
begin
  Result := FTipPro;
end;

function TProdutosAcabados.getTmpGar: Integer;
begin
  Result := FTmpGar;
end;

function TProdutosAcabados.getUniCom: String;
begin
  Result := FUniCom;
end;

function TProdutosAcabados.getUniTri: String;
begin
  Result := FUniTri;
end;

function TProdutosAcabados.getUrlImg: String;
begin
  Result := FUrlImg;
end;

function TProdutosAcabados.getUsaBon: String;
begin
  Result := FUsaBon;
end;

function TProdutosAcabados.getUsaFle: String;
begin
  Result := FUsaFle;
end;

function TProdutosAcabados.getValObr: String;
begin
  Result := FValObr;
end;

procedure TProdutosAcabados.pCalculaAndSetPesos(strCodPagP, strCodCorP, strCodUniP, strCodComP : String);
  Var
    qryCalPes : TUniQuery;
    fltPesLit : Double;
    fltPesRea : Double;
    strKilLit : String;
    blnForEsp : Boolean;
begin
  Try
    qryCalPes := fCriaQuery(Nil);
    With qryCalPes, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT UNI_PESLIT,         ');
      Add('        UNI_KILLIT          ');
      Add(' FROM CADUNI                ');
      Add(' WHERE UNI_CODUNI = :CODUNI ');

      ParamByName('CODUNI').AsString := strCodUniP;

      Open;

      fltPesLit := FieldByName('UNI_PESLIT').AsFloat;
      strKilLit := FieldByName('UNI_KILLIT').AsString;

      Close;
      Clear;

      Add(' SELECT                     ');
      Add('  GMT_PESREA,               ');
      Add('  GMT_FORESP                ');
      Add(' FROM GEIMAT                ');
      Add(' WHERE GMT_CODITE = :CODITE ');
      Add('   AND GMT_CODCOR = :CODCOR ');

      ParamByName('CODITE').AsString := strCodPagP;
      ParamByName('CODCOR').AsString := strCodCorP;

      Open;

      fltPesRea := FieldByName('GMT_PESREA').AsFloat;
      blnForEsp := FieldByName('GMT_FORESP').AsBoolean;

      Close;
      Clear;

      Add(' SELECT SUM( IFNULL(DCO_QTDITE, 0) * IFNULL(ITE_PESOIT, 0) ) AS PESCOM  ');
      Add(' FROM GERCOM CG                                                         ');
      Add('   INNER JOIN DETCOM ON DCO_SEQGER = CG.AUTOINCREM                      ');
      Add('   INNER JOIN CADITE ON ITE_CODITE = DCO_CODITE                         ');
      Add(' WHERE GCO_CODCOM = :CODCOM                                             ');

      ParamByName('CODCOM').AsString := strCodComP;

      Open;


      if blnForEsp then
      begin

        FPesOit := FormatFloat('0.00', FieldByName('PESCOM').AsFloat);
        FPesLiq := FPesOit;

      end
      else
      begin

        if strKilLit = 'K' then
        begin
          FPesLiq := FormatFloat('0.00', fltPesLit);
          FPesOit := FormatFloat('0.00', fltPesLit + FieldByName('PESCOM').AsFloat);
        end
        else
        begin
          FPesLiq := FormatFloat('0.00', fltPesRea * fltPesLit);
          FPesOit := FormatFloat('0.00', (fltPesRea * fltPesLit) + FieldByName('PESCOM').AsFloat);
        end;

      end;

      FPesLiq := ReplaceStr(FPesLiq, ',', '.');
      FPesOit := ReplaceStr(FPesOit, ',', '.');

    End;

  Finally
    FreeAndNil(qryCalPes);
  End;

end;

procedure TProdutosAcabados.pInsereLayout;
var
  qryIns: TUniQuery;
  procedure pLimparParametros;
  begin
    With qryIns Do
    Begin
      ParamByName('CODITE').Value := Null;
      ParamByName('CODLAY').Value := Null;
    End;
  end;
begin
  Try
    Try
      qryIns := fCriaQuery(Nil);

      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO LAYITE ( ');
        SQL.Add('   LAY_CODITE, ');;
        SQL.Add('   LAY_CODLAY) ');
        SQL.Add(' VALUES (   ');
        SQL.Add('   :CODITE, ');
        SQL.Add('   :CODLAY) ');

        pLimparParametros;

        ParamByName('CODITE').AsString := FCodIteGer;
        ParamByName('CODLAY').AsString := FCodLay;

        ExecSQL;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TProdutosAcabados.pInsereLayout]');
      end;
    End;
  Finally
    FreeAndNil(qryIns);
  End;

end;

procedure TProdutosAcabados.pInsereComplemento;
var
  qryIns: TUniQuery;
  procedure pLimparParametros;
  begin
    With qryIns Do
    Begin
      ParamByName('CODITE').Value := Null;
      ParamByName('COMP01').Value := Null;
      ParamByName('COMP02').Value := Null;
      ParamByName('COMP03').Value := Null;
      ParamByName('COMP04').Value := Null;
      ParamByName('COMP05').Value := Null;
      ParamByName('COMP06').Value := Null;
      ParamByName('COMP07').Value := Null;
      ParamByName('COMP08').Value := Null;
      ParamByName('COMP09').Value := Null;
      ParamByName('COMP10').Value := Null;
    End;
  end;
begin
  Try
    Try
      qryIns := fCriaQuery(Nil);

      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO COMETI ( ');
        SQL.Add('   ETI_CODITE, ');
        SQL.Add('   ETI_COMP01, ');
        SQL.Add('   ETI_COMP02, ');
        SQL.Add('   ETI_COMP03, ');
        SQL.Add('   ETI_COMP04, ');
        SQL.Add('   ETI_COMP05, ');
        SQL.Add('   ETI_COMP06, ');
        SQL.Add('   ETI_COMP07, ');
        SQL.Add('   ETI_COMP08, ');
        SQL.Add('   ETI_COMP09, ');
        SQL.Add('   ETI_COMP10) ');
        SQL.Add(' VALUES (   ');
        SQL.Add('   :CODITE, ');
        SQL.Add('   :COMP01, ');
        SQL.Add('   :COMP02, ');
        SQL.Add('   :COMP03, ');
        SQL.Add('   :COMP04, ');
        SQL.Add('   :COMP05, ');
        SQL.Add('   :COMP06, ');
        SQL.Add('   :COMP07, ');
        SQL.Add('   :COMP08, ');
        SQL.Add('   :COMP09, ');
        SQL.Add('   :COMP10) ');

        pLimparParametros;

        ParamByName('CODITE').AsString := FCodIteGer;
        ParamByName('COMP01').Value := FComp01;
        ParamByName('COMP02').Value := FComp02;
        ParamByName('COMP03').Value := FComp03;
        ParamByName('COMP04').Value := FComp04;
        ParamByName('COMP05').Value := FComp05;
        ParamByName('COMP06').Value := FComp06;
        ParamByName('COMP07').Value := FComp07;
        ParamByName('COMP08').Value := FComp08;
        ParamByName('COMP09').Value := FComp09;
        ParamByName('COMP10').Value := FComp10;

        ExecSQL;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TProdutosAcabados.pInsereComplemento]');
      end;
    End;
  Finally
    FreeAndNil(qryIns);
  End;


end;

procedure TProdutosAcabados.pInsereProdutosAcabadosIteGer(strCodUni, strCodCom, strCodCor : String);
var
  strCodAbfEmp: String;
  qryIns: TUniQuery;
  qryEmp: TUniQuery;
  fltPreCom: Double;
  procedure pLimparParametros;
  begin
    With qryIns Do
    Begin
      fltPreCom := 0;
      ParamByName('CODITE').Value := Null;
      ParamByName('CODEMP').Value := Null;
      ParamByName('FORULT').Value := Null;
      ParamByName('CODABF').Value := Null;
      ParamByName('ORDCON').Value := Null;
      ParamByName('DTABAL').Value := Null;
      ParamByName('AUTOIN').Value := Null;
      ParamByName('IPISAI').Value := Null;
      ParamByName('CPRCEN').Value := Null;

    End;
  end;
begin
  Try
    Try
      qryIns := fCriaQuery(Nil);
      qryEmp := fCriaQuery(Nil);

      With qryEmp, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP');
        Open;
      End;

      With qryIns Do
      Begin
        Close;
        SQL.Add(' INSERT INTO ITEGER ');
        SQL.Add(' (                  ');
        SQL.Add('   ITE_CODITE,      ');
        SQL.Add('   ITE_CODEMP,      ');
        SQL.Add('   ITE_FORULT,      ');
        SQL.Add('   ITE_PRECOM,      ');
        SQL.Add('   ITE_IPIENT,      ');
        SQL.Add('   ITE_FREENT,      ');
        SQL.Add('   ITE_PRECUS,      ');
        SQL.Add('   ITE_DESMAX,      ');
        SQL.Add('   ITE_MARBR1,      ');
        SQL.Add('   ITE_MARBR2,      ');
        SQL.Add('   ITE_PREVE1,      ');
        SQL.Add('   ITE_PREVE2,      ');
        SQL.Add('   ITE_DESF01,      ');
        SQL.Add('   ITE_DESF02,      ');
        SQL.Add('   ITE_DESF03,      ');
        SQL.Add('   ITE_DESF04,      ');
        SQL.Add('   ITE_DESF05,      ');
        SQL.Add('   ITE_DESF06,      ');
        SQL.Add('   ITE_ACRFIN,      ');
        SQL.Add('   ITE_SALDOS,      ');
        SQL.Add('   ITE_ESTMIN,      ');
        SQL.Add('   ITE_ESTMAX,      ');
        SQL.Add('   ITE_SALBAL,      ');
        SQL.Add('   ITE_SUBSTI,      ');
        SQL.Add('   ITE_ICMENT,      ');
        SQL.Add('   ITE_ICMSAI,      ');
        SQL.Add('   ITE_IPISAI,      ');
        SQL.Add('   ITE_PREMED,      ');
        SQL.Add('   ITE_PREULT,      ');
        SQL.Add('   ITE_QTDUCO,      ');
        SQL.Add('   ITE_PREUVE,      ');
        SQL.Add('   ITE_QTDUVE,      ');
        SQL.Add('   ITE_COMVAR,      ');
        SQL.Add('   ITE_COMATA,      ');
        SQL.Add('   ITE_COMDIS,      ');
        SQL.Add('   ITE_SAL_ML,      ');
        SQL.Add('   ITE_MARBR3,      ');
        SQL.Add('   ITE_PREVE3,      ');
        SQL.Add('   ITE_MARMIN,      ');
        SQL.Add('   ITE_IMPFED,      ');
        SQL.Add('   ITE_PREVE4,      ');
        SQL.Add('   ITE_MARBR4,      ');
        SQL.Add('   ITE_SALCON,      ');
        SQL.Add('   ITE_QTPPRO,      ');
        SQL.Add('   ITE_PREVE7,      ');
        SQL.Add('   ITE_MARBR7,      ');
        SQL.Add('   ITE_DESADB,      ');
        SQL.Add('   ITE_CODABF,      ');
        SQL.Add('   ITE_ORDCON,      ');
        SQL.Add('   ITE_DTABAL,      ');
        SQL.Add('   ITE_CPRCEN,      ');
        SQL.Add('   ITE_NIVGIR,      ');
        SQL.Add('   ITE_INDREV,      ');
        SQL.Add('   ITE_TIPPRO,      ');
        SQL.Add('   ITE_SITPRO,      ');
        SQL.Add('   ITE_TCIFCU,      ');
        SQL.Add('   ITE_TSCUST,      ');
        SQL.Add('   ITE_DEPICO,      ');
        SQL.Add('   ITE_DEICMS,      ');
        SQL.Add('   ITE_FATREG,      ');
        SQL.Add('   AUTOINCREM       ');
        SQL.Add(' ) VALUES (         ');
        SQL.Add('   :CODITE,      ');
        SQL.Add('   :CODEMP,      ');
        SQL.Add('   :FORULT,      ');
        SQL.Add('   :PRECOM,      ');
        SQL.Add('   :IPIENT,      ');
        SQL.Add('   :FREENT,      ');
        SQL.Add('   :PRECUS,      ');
        SQL.Add('   :DESMAX,      ');
        SQL.Add('   :MARBR1,      ');
        SQL.Add('   :MARBR2,      ');
        SQL.Add('   :PREVE1,      ');
        SQL.Add('   :PREVE2,      ');
        SQL.Add('   :DESF01,      ');
        SQL.Add('   :DESF02,      ');
        SQL.Add('   :DESF03,      ');
        SQL.Add('   :DESF04,      ');
        SQL.Add('   :DESF05,      ');
        SQL.Add('   :DESF06,      ');
        SQL.Add('   :ACRFIN,      ');
        SQL.Add('   :SALDOS,      ');
        SQL.Add('   :ESTMIN,      ');
        SQL.Add('   :ESTMAX,      ');
        SQL.Add('   :SALBAL,      ');
        SQL.Add('   :SUBSTI,      ');
        SQL.Add('   :ICMENT,      ');
        SQL.Add('   :ICMSAI,      ');
        SQL.Add('   :IPISAI,      ');
        SQL.Add('   :PREMED,      ');
        SQL.Add('   :PREULT,      ');
        SQL.Add('   :QTDUCO,      ');
        SQL.Add('   :PREUVE,      ');
        SQL.Add('   :QTDUVE,      ');
        SQL.Add('   :COMVAR,      ');
        SQL.Add('   :COMATA,      ');
        SQL.Add('   :COMDIS,      ');
        SQL.Add('   :SAL_ML,      ');
        SQL.Add('   :MARBR3,      ');
        SQL.Add('   :PREVE3,      ');
        SQL.Add('   :MARMIN,      ');
        SQL.Add('   :IMPFED,      ');
        SQL.Add('   :PREVE4,      ');
        SQL.Add('   :MARBR4,      ');
        SQL.Add('   :SALCON,      ');
        SQL.Add('   :QTPPRO,      ');
        SQL.Add('   :PREVE7,      ');
        SQL.Add('   :MARBR7,      ');
        SQL.Add('   :DESADB,      ');
        SQL.Add('   :CODABF,      ');
        SQL.Add('   :ORDCON,      ');
        SQL.Add('   :DTABAL,      ');
        SQL.Add('   :CPRCEN,      ');
        SQL.Add('   :NIVGIR,      ');
        SQL.Add('   :INDREV,      ');
        SQL.Add('   :TIPPRO,      ');
        SQL.Add('   :SITPRO,      ');
        SQL.Add('   :TCIFCU,      ');
        SQL.Add('   :TSCUST,      ');
        SQL.Add('   :DEPICO,      ');
        SQL.Add('   :DEICMS,      ');
        SQL.Add('   :FATREG,      ');
        SQL.Add('   :AUTOIN)      ');

        pLimparParametros;

        //Preço de compra do produto acabado
        fltPreCom := fRetornaPrecoCompraProdutoAcabado(strCodUni, strCodCom, strCodCor);

        qryEmp.First;
        While not qryEmp.Eof Do
        Begin
          ParamByName('CODITE').AsString  := FCodIteGer;
          ParamByName('CODEMP').AsString  := qryEmp.FieldByName('EMP_CODEMP').AsString;
          ParamByName('FORULT').IsNull;
          ParamByName('PRECOM').AsFloat   := fltPreCom;
          ParamByName('IPIENT').AsFloat   := 0.0;
          ParamByName('FREENT').AsFloat   := 0.0;
          ParamByName('PRECUS').AsFloat   := fltPreCom;
          ParamByName('DESMAX').AsFloat   := 0.0;
          ParamByName('MARBR1').AsFloat   := 0.0;
          ParamByName('MARBR2').AsFloat   := 0.0;
          ParamByName('PREVE1').AsFloat   := fltPreCom;
          ParamByName('PREVE2').AsFloat   := fltPreCom;
          ParamByName('DESF01').AsFloat   := 0.0;
          ParamByName('DESF02').AsFloat   := 0.0;
          ParamByName('DESF03').AsFloat   := 0.0;
          ParamByName('DESF04').AsFloat   := 0.0;
          ParamByName('DESF05').AsFloat   := 0.0;
          ParamByName('DESF06').AsFloat   := 0.0;
          ParamByName('ACRFIN').AsFloat   := 0.0;
          ParamByName('SALDOS').AsFloat   := 0.0;
          ParamByName('ESTMIN').AsFloat   := 0.0;
          ParamByName('ESTMAX').AsFloat   := 0.0;
          ParamByName('SALBAL').AsFloat   := 0.0;
          ParamByName('SUBSTI').AsFloat   := 0.0;
          ParamByName('ICMENT').AsFloat   := 0.0;
          ParamByName('ICMSAI').AsFloat   := 0.0;
          ParamByName('PREMED').AsFloat   := 0.0;
          ParamByName('PREULT').AsFloat   := 0.0;
          ParamByName('QTDUCO').AsFloat   := 0.0;
          ParamByName('PREUVE').AsFloat   := 0.0;
          ParamByName('QTDUVE').AsFloat   := 0.0;
          ParamByName('COMVAR').AsFloat   := 0.0;
          ParamByName('COMATA').AsFloat   := 0.0;
          ParamByName('COMDIS').AsFloat   := 0.0;
          ParamByName('SAL_ML').AsFloat   := 0.0;
          ParamByName('MARBR3').AsFloat   := 0.0;
          ParamByName('PREVE3').AsFloat   := 0.0;
          ParamByName('MARMIN').AsFloat   := 0.0;
          ParamByName('IMPFED').AsFloat   := 0.0;
          ParamByName('PREVE4').AsFloat   := 0.0;
          ParamByName('MARBR4').AsFloat   := 0.0;
          ParamByName('SALCON').AsFloat   := 0.0;
          ParamByName('QTPPRO').AsInteger := 0;
          ParamByName('PREVE7').AsFloat   := 0.0;
          ParamByName('MARBR7').AsFloat   := 0.0;
          ParamByName('DESADB').AsFloat   := 0.0;

          {Abreviçao Fiscal Req 370610}
          strCodAbfEmp := fRetornaCodigoAbreviacao(FstlAbfIteger, qryEmp.FieldByName('EMP_CODEMP').AsString);
          If fEmptyStr(strCodAbfEmp) Then
            ParamByName('CODABF').Clear
          Else
            ParamByName('CODABF').AsString  := strCodAbfEmp;
          {Fim}

          ParamByName('ORDCON').AsInteger := 0;
          ParamByName('DTABAL').AsDate    := VS_Date - 1;
          ParamByName('AUTOIN').AsString  := fRetAutoIncrem('ITEGER', qryEmp.FieldByName('EMP_CODEMP').AsString);
          ParamByName('IPISAI').AsFloat   := fStrToFloat(FIpiSai);
          ParamByName('CPRCEN').AsString  := FCprCen;
          ParamByName('NIVGIR').AsString  := FStrNivGir;
          ParamByName('INDREV').AsString  := FIndRev;
          ParamByName('TIPPRO').AsString  := FTipPro;
          ParamByName('SITPRO').AsString  := FSitPro;
          ParamByName('TCIFCU').AsFloat   := 0.0;
          ParamByName('TSCUST').AsFloat   := 0.0;
          ParamByName('DEPICO').AsFloat   := 0.0;
          ParamByName('DEICMS').AsFloat   := 0.0;
          ParamByName('FATREG').AsFloat   := 0.0;
          ExecSQL;

          qryEmp.Next;
        End;
      End;

      pGeraGirIte(FCodIteGer);
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TProdutosAcabados.pInsereProdutosAcabadosIteGer]');
      end;
    End;
  Finally
    FreeAndNil(qryIns);
    FreeAndNil(qryEmp);
  End;
end;

procedure TProdutosAcabados.pInsereProdutosExportacaoSite;
var
  qryIns: TUniQuery;
  procedure pLimparParametros;
  begin
    With qryIns Do
    Begin
      ParamByName('CODITE').Value := Null;
      ParamByName('DESITE').Value := Null;
      ParamByName('NOMITE').Value := Null;
      ParamByName('APLITE').Value := Null;
      ParamByName('DADTEC').Value := Null;
      ParamByName('INCLUS').Value := Null;
      ParamByName('EXPALT').Value := Null;
      ParamByName('EXPLAR').Value := Null;
      ParamByName('EXPPRO').Value := Null;
      ParamByName('URLIMG').Value := Null;
    End;
  end;
begin
  Try
    Try
      qryIns := fCriaQuery(Nil);

      With qryIns Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO DESSIT ( ');
        SQL.Add('   ITE_CODITE, ');
        SQL.Add('   ITE_DESITE, ');
        SQL.Add('   ITE_NOMITE, ');
        SQL.Add('   ITE_APLITE, ');
        SQL.Add('   ITE_DADTEC, ');
        SQL.Add('   ITE_INCLUS, ');
        SQL.Add('   ITE_EXPALT, ');
        SQL.Add('   ITE_EXPLAR, ');
        SQL.Add('   ITE_EXPPRO, ');
        SQL.Add('   ITE_URLIMG) ');
        SQL.Add(' VALUES (   ');
        SQL.Add('   :CODITE, ');
        SQL.Add('   :DESITE, ');
        SQL.Add('   :NOMITE, ');
        SQL.Add('   :APLITE, ');
        SQL.Add('   :DADTEC, ');
        SQL.Add('   :INCLUS, ');
        SQL.Add('   :EXPALT, ');
        SQL.Add('   :EXPLAR, ');
        SQL.Add('   :EXPPRO, ');
        SQL.Add('   :URLIMG) ');

        pLimparParametros;
        
        ParamByName('CODITE').AsString := FCodIteGer;
        ParamByName('DESITE').AsString := FDesSit;
        ParamByName('NOMITE').AsString := FNomIte;
        ParamByName('APLITE').AsString := FAplIte;
        ParamByName('DADTEC').AsString := FDadTec;
        ParamByName('INCLUS').AsString := FIncLus;
        ParamByName('EXPALT').AsFloat  := FExpAlt;
        ParamByName('EXPLAR').AsFloat  := FExpLar;
        ParamByName('EXPPRO').AsFloat  := FExpPro;
        ParamByName('URLIMG').AsString := FUrlImg;
        ExecSQL;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TProdutosAcabados.pInsereProdutosExportacaoSite]');
      end;
    End;
  Finally
    FreeAndNil(qryIns);
  End;

end;

function TProdutosAcabados.fInserirProdutosAcabados(ArrayUnidades,
                                                    ArrayCores,
                                                    ArrayComposicao: array of String;
                                                    strCodIte: String;
                                                    Var strMsgAdi: String;
                                                    Var stlProdutosAcabados: TStringList): Boolean;
var
  qryIns: TUniQuery;
  intUni,
  intCor: Integer;
  strCodIteTmp: String;
  strDesIteTmp: String;
  objCodBar : TIteBar;
  blnPrinc: Boolean;

  procedure pLimparParametros;
  begin
    With qryIns Do
    Begin
      ParamByName('CODITE').Value := Null;
      ParamByName('DESITE').Value := Null;
      ParamByName('CODDEP').Value := Null;
      ParamByName('CODGRU').Value := Null;
      ParamByName('REFERE').Value := Null;
      ParamByName('CODMAR').Value := Null;
      ParamByName('CODFOR').Value := Null;
      ParamByName('CODFAB').Value := Null;
      ParamByName('CODUNI').Value := Null;
      ParamByName('CODABF').Value := Null;
      ParamByName('ABFPIS').Value := Null;
      ParamByName('ABFCOF').Value := Null;
      ParamByName('ABFIPI').Value := Null;
      ParamByName('IMPDIR').Value := Null;
      ParamByName('INCPIS').Value := Null;
      ParamByName('CLAIPI').Value := Null;
      ParamByName('COMLUB').Value := Null;
      ParamByName('ITEATI').Value := Null;
      ParamByName('ATICOM').Value := Null;
      ParamByName('PESOIT').Value := Null;
      ParamByName('PESLIQ').Value := Null;
      ParamByName('ITEBAS').Value := Null;
      ParamByName('USABON').Value := Null;
      ParamByName('USAFLE').Value := Null;
      ParamByName('VALOBR').Value := Null;
      ParamByName('CNV_ML').Value := Null;
      ParamByName('ITEPIG').Value := Null;
      ParamByName('NVLGIR').Value := Null;
      ParamByName('MSGLV1').Value := Null;
      ParamByName('MSGLV2').Value := Null;
      ParamByName('APLICA').Value := Null;
      ParamByName('INFLAM').Value := Null;
      ParamByName('TMPGAR').Value := Null;
      ParamByName('INFGAR').Value := Null;
      ParamByName('RSPGAR').Value := Null;
      ParamByName('EXPSIT').Value := Null;
      ParamByName('EXPPOK').Value := Null;
      ParamByName('EXPAPP').Value := Null;
      ParamByName('CODGPR').Value := Null;
      ParamByName('INDREV').Value := Null;
      ParamByName('CODCOR').Value := Null;
      ParamByName('DTACAD').Value := Null;
      ParamByName('CODEMP').Value := Null;
      ParamByName('CODOPE').Value := Null;
      ParamByName('DTAALT').Value := Null;
      ParamByName('HULALT').Value := Null;
      ParamByName('UNICOM').Value := Null;
      ParamByName('UNITRI').Value := Null;
      ParamByName('FATUTR').Value := Null;
      ParamByName('OBRCPF').Value := Null;
      ParamByName('OBRIBA').Value := Null;
      ParamByName('MLTCOM').Value := Null;
      ParamByName('MLTVEN').Value := Null;
      ParamByName('CODMON').Value := Null;
      ParamByName('SITPRO').Value := Null;
      ParamByName('BAREMB').Value := Null;
      ParamByName('SETFLZ').Value := Null;
      ParamByName('CODVEL').Value := Null;
      ParamByName('CODBAR').Value := Null;
      ParamByName('CODPAG').Value := Null;
      ParamByName('AUTOIN').Value := Null;
      ParamByName('MENFIS').Value := Null;
      ParamByName('CODONU').Value := Null;
      ParamByName('DENSID').Value := Null;
    End;
  end;

begin
  strMsgAdi := '';
  Result := True;
  Try
    Try
      qryIns := fCriaQuery(Nil);

      fStartTransaction;

      With qryIns Do
      Begin
        Close;
        SQL.Add(' INSERT INTO CADITE ');
        SQL.Add(' (                  ');
        SQL.Add('   ITE_CODITE,      ');
        SQL.Add('   ITE_DESITE,      ');
        SQL.Add('   ITE_CODDEP,      ');
        SQL.Add('   ITE_CODGRU,      ');
        SQL.Add('   ITE_REFERE,      ');
        SQL.Add('   ITE_CODMAR,      ');
        SQL.Add('   ITE_CODFOR,      ');
        SQL.Add('   ITE_CODFAB,      ');
        SQL.Add('   ITE_CODUNI,      ');
        SQL.Add('   ITE_CODABF,      ');
        SQL.Add('   ITE_ABFPIS,      ');
        SQL.Add('   ITE_ABFCOF,      ');
        SQL.Add('   ITE_ABFIPI,      ');
        SQL.Add('   ITE_IMPDIR,      ');
        SQL.Add('   ITE_INCPIS,      ');
        SQL.Add('   ITE_CLAIPI,      ');
        SQL.Add('   ITE_COMLUB,      ');
        SQL.Add('   ITE_ITEATI,      ');
        SQL.Add('   ITE_ATICOM,      ');
        SQL.Add('   ITE_PESOIT,      ');
        SQL.Add('   ITE_PESLIQ,      ');
        SQL.Add('   ITE_ITEBAS,      ');
        SQL.Add('   ITE_USABON,      ');
        SQL.Add('   ITE_USAFLE,      ');
        SQL.Add('   ITE_VALOBR,      ');
        SQL.Add('   ITE_CNV_ML,      ');
        SQL.Add('   ITE_ITEPIG,      ');
        SQL.Add('   ITE_NVLGIR,      ');
        SQL.Add('   ITE_MSGLV1,      ');
        SQL.Add('   ITE_MSGLV2,      ');
        SQL.Add('   ITE_APLICA,      ');
        SQL.Add('   ITE_INFLAM,      ');
        SQL.Add('   ITE_TMPGAR,      ');
        SQL.Add('   ITE_INFGAR,      ');
        SQL.Add('   ITE_RSPGAR,      ');
        SQL.Add('   ITE_EXPSIT,      ');
        SQL.Add('   ITE_EXPPOK,      ');
        SQL.Add('   ITE_EXPAPP,      ');
        SQL.Add('   ITE_CODGPR,      ');
        SQL.Add('   ITE_INDREV,      ');
        SQL.Add('   ITE_CODCOR,      ');
        SQL.Add('   ITE_DTACAD,      ');
        SQL.Add('   ITE_CODEMP,      ');
        SQL.Add('   ITE_CODOPE,      ');
        SQL.Add('   ITE_DTAALT,      ');
        SQL.Add('   ITE_HULALT,      ');
        SQL.Add('   ITE_UNICOM,      ');
        SQL.Add('   ITE_UNITRI,      ');
        SQL.Add('   ITE_FATUTR,      ');
        SQL.Add('   ITE_OBRCPF,      ');
        SQL.Add('   ITE_OBRIBA,      ');
        SQL.Add('   ITE_MLTCOM,      ');
        SQL.Add('   ITE_MLTVEN,      ');
        SQL.Add('   ITE_CODMON,      ');
        SQL.Add('   ITE_SITPRO,      ');
        SQL.Add('   ITE_BAREMB,      ');
        SQL.Add('   ITE_SETFLZ,      ');
        SQL.Add('   ITE_CODVEL,      ');
        SQL.Add('   ITE_CODBAR,      ');
        SQL.Add('   ITE_CODPAG,      '); //Codigo do produto a granel (É O CODITE DO PRODUTO A GRANEL)
        SQL.Add('   ITE_CODCOM,      '); //Codigo da Composição
        SQL.Add('   ITE_MENFIS,      ');
        SQL.Add('   ITE_CODONU,      ');
        SQL.Add('   ITE_SITPRD,      ');
        SQL.Add('   ITE_PRAVAL,      ');
        SQL.Add('   ITE_DESFAB,      ');
        SQL.Add('   ITE_CDCEST,      ');
        SQL.Add('   ITE_PRDGRU,      ');
        SQL.Add('   ITE_DENSID,      ');
        SQL.Add('   AUTOINCREM       ');
        SQL.Add(' ) VALUES (         ');
        SQL.Add('   :CODITE,         ');
        SQL.Add('   :DESITE,         ');
        SQL.Add('   :CODDEP,         ');
        SQL.Add('   :CODGRU,         ');
        SQL.Add('   :REFERE,         ');
        SQL.Add('   :CODMAR,         ');
        SQL.Add('   :CODFOR,         ');
        SQL.Add('   :CODFAB,         ');
        SQL.Add('   :CODUNI,         ');
        SQL.Add('   :CODABF,         ');
        SQL.Add('   :ABFPIS,         ');
        SQL.Add('   :ABFCOF,         ');
        SQL.Add('   :ABFIPI,         ');
        SQL.Add('   :IMPDIR,         ');
        SQL.Add('   :INCPIS,         ');
        SQL.Add('   :CLAIPI,         ');
        SQL.Add('   :COMLUB,         ');
        SQL.Add('   :ITEATI,         ');
        SQL.Add('   :ATICOM,         ');
        SQL.Add('   :PESOIT,         ');
        SQL.Add('   :PESLIQ,         ');
        SQL.Add('   :ITEBAS,         ');
        SQL.Add('   :USABON,         ');
        SQL.Add('   :USAFLE,         ');
        SQL.Add('   :VALOBR,         ');
        SQL.Add('   :CNV_ML,         ');
        SQL.Add('   :ITEPIG,         ');
        SQL.Add('   :NVLGIR,         ');
        SQL.Add('   :MSGLV1,         ');
        SQL.Add('   :MSGLV2,         ');
        SQL.Add('   :APLICA,         ');
        SQL.Add('   :INFLAM,         ');
        SQL.Add('   :TMPGAR,         ');
        SQL.Add('   :INFGAR,         ');
        SQL.Add('   :RSPGAR,         ');
        SQL.Add('   :EXPSIT,         ');
        SQL.Add('   :EXPPOK,         ');
        SQL.Add('   :EXPAPP,         ');
        SQL.Add('   :CODGPR,         ');
        SQL.Add('   :INDREV,         ');
        SQL.Add('   :CODCOR,         ');
        SQL.Add('   :DTACAD,         ');
        SQL.Add('   :CODEMP,         ');
        SQL.Add('   :CODOPE,         ');
        SQL.Add('   :DTAALT,         ');
        SQL.Add('   :HULALT,         ');
        SQL.Add('   :UNICOM,         ');
        SQL.Add('   :UNITRI,         ');
        SQL.Add('   :FATUTR,         ');
        SQL.Add('   :OBRCPF,         ');
        SQL.Add('   :OBRIBA,         ');
        SQL.Add('   :MLTCOM,         ');
        SQL.Add('   :MLTVEN,         ');
        SQL.Add('   :CODMON,         ');
        SQL.Add('   :SITPRO,         ');
        SQL.Add('   :BAREMB,         ');
        SQL.Add('   :SETFLZ,         ');
        SQL.Add('   :CODVEL,         ');
        SQL.Add('   :CODBAR,         ');
        SQL.Add('   :CODPAG,         '); //Codigo do produto a granel (CODITE)
        SQL.Add('   :CODCOM,         '); //Codigo da Composição
        SQL.Add('   :MENFIS,         ');
        SQL.Add('   :CODONU,         ');
        SQL.Add('   :SITPRD,         ');
        SQL.Add('   :PRAVAL,         ');
        SQL.Add('   :DESFAB,         ');
        SQL.Add('   :CDCEST,         ');
        SQL.Add('   :PRDGRU,         ');
        SQL.Add('   :DENSID,         ');
        SQL.Add('   :AUTOIN)         ');

        For intUni := 0 To Length(ArrayUnidades) - 1 Do
        Begin

          If Not (Result) Then
            Break;

          For intCor := 0 To Length(ArrayCores) - 1 Do
          Begin

            If Not (Result) Then
              Break;

            pLimparParametros;

            pCalculaAndSetPesos(strCodIte, ArrayCores[intCor], ArrayUnidades[intUni], ArrayComposicao[intUni]);

            FCodIteGer := fProximoCodigo('CADITE', 'ITE_CODITE');
            FCodFabGer := fRetornaCodigoFabricaDoProdutoAcabado(ArrayUnidades[intUni],ArrayCores[intCor], strCodIte);

            ParamByName('CODITE').AsString := FCodIteGer;
            ParamByName('DESITE').AsString := fRetornaDescricaoDoProdutoAcabado(ArrayUnidades[intUni],ArrayCores[intCor], strCodIte);
            ParamByName('CODDEP').AsString := fCfgSis('PROACA', varString); //Departamento de produtos acabados
            ParamByName('CODGRU').AsString := FCodGru;
            ParamByName('REFERE').AsString := FRefere;
            ParamByName('CODMAR').AsString := FCodMar;


            if fEmptyStr(FCodFor) then
              ParamByName('CODFOR').Clear
            else
              ParamByName('CODFOR').AsString := FCodFor;

            ParamByName('CODFAB').AsString := FCodFabGer;
            ParamByName('CODUNI').AsString := ArrayUnidades[intUni];

            ParamByName('CODCOM').AsString := ArrayComposicao[intUni]; // UTILIZA A MESMA POSIÇÃO DO ARRAY DA UNIDADE

            If fEmptyStr(ParamByName('CODCOM').AsString) Then
              ParamByName('CODCOM').Clear;

            ParamByName('CODABF').AsString := FCodAbf;

            If fEmptyStr(FCodAbf) Then
              ParamByName('CODABF').Clear;

            If fEmptyStr(FAbfPis) Then
              ParamByName('ABFPIS').Clear
            Else
              ParamByName('ABFPIS').AsString := FAbfPis;
            If fEmptyStr(FAbfCof) Then
              ParamByName('ABFCOF').Clear
            Else
              ParamByName('ABFCOF').AsString := FAbfCof;
            If fEmptyStr(FAbfIpi) Then
              ParamByName('ABFIPI').Clear
            Else
              ParamByName('ABFIPI').AsString := FAbfIpi;
            ParamByName('IMPDIR').AsString := FImpDir;
            ParamByName('INCPIS').AsString := FIncPis;
            ParamByName('CLAIPI').AsString := FClaIpi;
            ParamByName('COMLUB').AsString := FComLub;
            ParamByName('ITEATI').AsString := 'N';//FIteAti;
            ParamByName('ATICOM').AsString := FAtiCom;
            ParamByName('PESOIT').AsString := FPesOit;
            ParamByName('PESLIQ').AsString := FPesLiq;
            ParamByName('ITEBAS').AsString := FIteBas;
            ParamByName('USABON').AsString := FUsaBon;
            ParamByName('USAFLE').AsString := FUsaFle;
            ParamByName('VALOBR').AsString := FValObr;
            ParamByName('CNV_ML').AsString := FCnv_Ml;
            ParamByName('ITEPIG').AsString := FItePig;
            ParamByName('NVLGIR').AsString := FNvlGir;
            ParamByName('MSGLV1').AsString := FMsgLv1;
            ParamByName('MSGLV2').AsString := FMsgLv2;
            ParamByName('APLICA').AsString := FAplica;
            ParamByName('INFLAM').AsString := FInfLam;
            ParamByName('TMPGAR').AsInteger := FTmpGar;
            ParamByName('INFGAR').AsString := FInfGar;
            ParamByName('RSPGAR').AsString := FRspGar;
            ParamByName('EXPSIT').AsString := FExpSit;
            ParamByName('EXPPOK').AsString := FExpPok;
            ParamByName('EXPAPP').AsString := FExpApp;
            ParamByName('CODGPR').AsString := FCodGpr;
            If fEmptyStr(FCodGpr) Then
              ParamByName('CODGPR').Clear;
            ParamByName('INDREV').AsString := FIndRev;
            ParamByName('CODCOR').AsString := ArrayCores[intCor];
            ParamByName('DTACAD').AsDate   := VS_Date;
            ParamByName('CODEMP').AsString := Vs_strCodEmp;
            ParamByName('CODOPE').AsString := FCodOpe;

            ParamByName('DTAALT').AsDateTime := VS_Date;
            ParamByName('HULALT').AsDateTime := fNow;

            ParamByName('UNICOM').AsString := FUniCom;

            If fEmptyStr(ParamByName('UNICOM').AsString) Then
              ParamByName('UNICOM').Clear;

            ParamByName('UNITRI').AsString := FUniTri;

            If fEmptyStr(ParamByName('UNITRI').AsString) Then
              ParamByName('UNITRI').Clear;

            ParamByName('FATUTR').AsFloat  := FFatUtr;

            ParamByName('OBRCPF').AsString := FObrCpf;
            ParamByName('OBRIBA').AsString := FObrIba;
            ParamByName('MLTCOM').AsString := FMltCom;
            ParamByName('MLTVEN').AsString := FMltVen;
            If fEmptyStr(FCodMon) Then
              ParamByName('CODMON').Clear
            Else
              ParamByName('CODMON').AsString := FCodMon;
            If fEmptyStr(FSitPro) Then
              ParamByName('SITPRO').Clear
            Else
              ParamByName('SITPRO').AsString := FSitPro;
            If fEmptyStr(FBarEmb) Then
              ParamByName('BAREMB').Clear
            Else
              ParamByName('BAREMB').AsString := FBarEmb;
            If fEmptyStr(FSetFlz) Then
              ParamByName('SETFLZ').Clear
            Else
              ParamByName('SETFLZ').AsString := FSetFlz;
            If fEmptyStr(FCodVel) Then
              ParamByName('CODVEL').Clear
            Else
              ParamByName('CODVEL').AsString := FCodVel;
            If fEmptyStr(FCodBar) Then
              ParamByName('CODBAR').Clear
            Else
              ParamByName('CODBAR').AsString := FCodBar;
            ParamByName('CODPAG').AsString := FCodIte; //Codigo do produto a granel (CODITE)
            ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADITE', VS_strCodEmp);

            ParamByName('MENFIS').AsString := FMenFis;
            ParamByName('CODONU').AsString := FCodOnu;
            If fEmptyStr(FCodOnu) Then
              ParamByName('CODONU').Clear;

            ParamByName('SITPRD').AsString := FSitPrd;
            ParamByName('PRAVAL').AsString  := strPraVal;
            ParamByName('DESFAB').AsString  := strDesFab;

            ParamByName('CDCEST').AsString  := strCdCest;
            If fEmptyStr(strCdCest) Then
              ParamByName('CDCEST').Clear;

            ParamByName('PRDGRU').AsString  := strPrdGru;
            if fEmptyStr(strPrdGru) then
              ParamByName('PRDGRU').Clear;

            ParamByName('DENSID').AsFloat   := TOrdProIndustrial.fRetornaPesoRealFormula(FCodIte, ArrayCores[intCor]);

            If (Result) And (Not fExisteCodigoDeFabricao(FCodFabGer)) Then
            Begin
              ExecSQL;
              fAtualizaBarFabIte(FCodIteGer);
              pInsereProdutosAcabadosIteGer(ArrayUnidades[intUni], ArrayComposicao[intUni], ArrayCores[intCor]);

              If (Not fEmptyStr(FDesSit)) And (Not fEmptyStr(FDadTec)) Then
                pInsereProdutosExportacaoSite;

              If Not fEmptyStr(FCodLay) Then
                pInsereLayout;

              If fExisteComplemento(strCodIte) Then
                pInsereComplemento;

              TCadLot.fGeraADefinirWMS(FCodIteGer);

              stlProdutosAcabados.Add(ParamByName('CODITE').AsString+'-'+ParamByName('DESITE').AsString);
            End
            Else
            Begin
              Result := False;
              pRetornaProdutoSeExisteCodigoDeFabricao(FCodFabGer, strCodIteTmp, strDesIteTmp);
              strMsgAdi := strMsgAdi + 'PRODUTO: "' + strCodIteTmp + ' - ' + strDesIteTmp + '"  CÓDIGO FÁBRICA: "' + FCodFabGer + '"' ;
            End;
          End;

        End;
      End;

      If (Result) Then
      Begin
        objCodBar := TIteBar.Create(opcOperacoes);
        Try
          objCodBar.pCarregaDados(FCodIteGer);
          //Se não tiver cod de barras cadastrado marca este como principal e atualiza a cadite
          blnPrinc := (fRetQtdIteBar(FCodIteGer) = 0);

          If fCfgSis('TIPBAR') = '2' Then
            strCodBar := fGeraCodBarraEAN39(FCodIteGer)
          Else
           strCodBar := fGeraCodBarraEAN13('1' + FCodGru + FCodIteGer);



          objCodBar.pIncluiCodigo(strCodBar, 1, blnPrinc,
                                      Not fTemPrincipalParaCompra(FCodIteGer), True, 0, '', '', '', 0,0,0,0,0,0,0,0, blnPrinc);
          objCodBar.pSalvaDados(FCodIteGer, True);

          Result := fCommit;
        Finally
          FreeAndNil(objCodBar);
        End;
      End
      Else
        fRollBack;        
    Except
      on E: Exception do
      begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TProdutosAcabados.fInserirProdutosAcabados]');
      end;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TProdutosAcabados.pLendoCamposCodigoFabrica(strCampos: String);
var
  intCont: Integer;
begin
  SetLength(arrCodigoFabrica,fCountCampos(strCampos,'+'));
  For intCont := 0 To Length(arrCodigoFabrica) - 1 Do
  Begin
    arrCodigoFabrica[intCont].strTabela := Trim(Copy(strCampos,Pos('.',strCampos) - 6,6));

    If Pos('+',strCampos) > 0 Then
      arrCodigoFabrica[intCont].strCampo := Trim(Copy(strCampos,1,(Pos('+',strCampos) - 1)))
    Else
      arrCodigoFabrica[intCont].strCampo := Trim(strCampos);

    strCampos := Trim(Copy(strCampos,Pos('+',strCampos) + 1,Length(strCampos)));
  End;
end;

procedure TProdutosAcabados.pLendoCamposDescricao(strCampos: String);
var
  intCont: Integer;
begin
  SetLength(arrDescricao,fCountCampos(strCampos,'+'));
  For intCont := 0 To Length(arrDescricao) - 1 Do
  Begin
    arrDescricao[intCont].strTabela := Trim(Copy(strCampos,1,Pos('.',strCampos) - 1));

    If Pos('+',strCampos) > 0 Then
      arrDescricao[intCont].strCampo := Trim(Copy(strCampos,Pos('.',strCampos) + 1,((Pos('+',strCampos) - 1) - (Pos('.',strCampos)))))
    Else
      arrDescricao[intCont].strCampo := Trim(Copy(strCampos,Pos('.',strCampos) + 1,(Length(strCampos) - (Pos('.',strCampos)))));

    strCampos := Trim(Copy(strCampos,Pos('+',strCampos) + 1,Length(strCampos)));
  End;
end;

procedure TProdutosAcabados.pLimpaFiltro;
begin
  FobjFiltro.strCodGra    := '';
  FobjFiltro.strCodAca    := '';
  FobjFiltro.strLinGruGra := '';
  FobjFiltro.strLinGruAca := '';
  FobjFiltro.strDepGra    := '';
  FobjFiltro.strDepAca    := '';
  FobjFiltro.strRefGra    := '';
  FobjFiltro.strRefAca    := '';
end;

procedure TProdutosAcabados.pZeraValores;
begin
  FCodGru := '';
  FRefere := '';
  FCodMar := '';
  FCodFor := '';
  FCodUni := '';
  FCodAbf := '';
  FAbfPis := '';
  FAbfCof := '';
  FAbfIpi := '';
  FImpDir := '';
  FIncPis := '';
  FClaIpi := '';
  FComLub := '';
  FIteAti := '';
  FAtiCom := '';
  FPesOit := '';
  FPesLiq := '';
  FIteBas := '';
  FUsaBon := '';
  FUsaFle := '';
  FValObr := '';
  FCnv_Ml := '';
  FItePig := '';
  FNvlGir := '';
  FMsgLv1 := '';
  FMsgLv2 := '';
  FAplica := '';
  FInfLam := '';
  FTmpGar := 0;
  FInfGar := '';
  FRspGar := '';
  FExpSit := '';
  FExpPok := '';
  FExpApp := '';
  FCodGpr := '';
  FIndRev := '';
  FCodOpe := '';
  FUniCom := '';
  FUniTri := '';
  FFatUTr := 1;
  FObrCpf := '';
  FObrIba := '';
  FMltCom := '';
  FMltVen := '';
  FCodMon := '';
  FSitPro := '';
  FBarEmb := '';
  FSetFlz := '';
  FCodVel := '';
  FCodBar := '';
  FDesSit := '';
  FDadTec := '';
  FNomIte := '';
  FAplIte := '';
  FIncLus := '';
  FExpAlt := 0;
  FExpLar := 0;
  FExpPro := 0;
  FUrlImg := '';
  FMenFis := '';
  FCodOnu := '';
  FIpiSai := '';
  FstlAbfIteger.Clear;
  pLimpaFiltro;

end;

procedure TProdutosAcabados.setAbfCof(const Value: String);
begin
  If (FAbfCof <> Value) Then
    FAbfCof := Value;
end;

procedure TProdutosAcabados.setAbfIpi(const Value: String);
begin
  If (FAbfIpi <> Value) Then
    FAbfIpi := Value;
end;

procedure TProdutosAcabados.setAbfIteger(const Value: TStringList);
begin
  FstlAbfIteger := Value;
end;

procedure TProdutosAcabados.setAbfPis(const Value: String);
begin
  If (FAbfPis <> Value) Then
    FAbfPis := Value;
end;

procedure TProdutosAcabados.setAplica(const Value: String);
begin
  If (FAplica <> Value) Then
    FAplica := Value;
end;

procedure TProdutosAcabados.setAplIte(const Value: String);
begin
  If (FAplIte <> Value) Then
    FAplIte := Value;
end;

procedure TProdutosAcabados.setAtiCom(const Value: String);
begin
  If (FAtiCom <> Value) Then
    FAtiCom := Value;
end;

procedure TProdutosAcabados.setBarEmb(const Value: String);
begin
  If (FBarEmb <> Value) Then
    FBarEmb := Value;
end;

procedure TProdutosAcabados.setClaIpi(const Value: String);
begin
  If (FClaIpi <> Value) Then
    FClaIpi := Value;
end;

procedure TProdutosAcabados.setCnv_Ml(const Value: String);
begin
  If (FCnv_Ml <> Value) Then
    FCnv_Ml := Value;
end;

procedure TProdutosAcabados.setCodAbf(const Value: String);
begin
  If (FCodAbf <> Value) Then
    FCodAbf := Value;
end;

procedure TProdutosAcabados.setCodBar(const Value: String);
begin
  If (FCodBar <> Value) Then
    FCodBar := Value;
end;

procedure TProdutosAcabados.setCodFor(const Value: String);
begin
  If (FCodFor <> Value) Then
    FCodFor := Value;
end;

procedure TProdutosAcabados.setCodGpr(const Value: String);
begin
  If (FCodGpr <> Value) Then
    FCodGpr := Value;
end;

procedure TProdutosAcabados.setCodGru(const Value: String);
begin
  If (FCodGru <> Value) Then
    FCodGru := Value;
end;

procedure TProdutosAcabados.setCodIte(const Value: String);
begin
  If (FCodIte <> Value) Then
    FCodIte := Value;
end;

procedure TProdutosAcabados.setCodLay(const Value: String);
begin
  If (FCodLay <> Value) Then
    FCodLay := Value;
end;

procedure TProdutosAcabados.setCodMar(const Value: String);
begin
  If (FCodMar <> Value) Then
    FCodMar := Value;
end;

procedure TProdutosAcabados.setCodMon(const Value: String);
begin
  If (FCodMon <> Value) Then
    FCodMon := Value;
end;

procedure TProdutosAcabados.setCodOnu(const Value: String);
begin
  if (FCodOnu <> Value) Then
    FCodOnu := Value;
end;

procedure TProdutosAcabados.setCodOpe(const Value: String);
begin
  If (FCodOpe <> Value) Then
    FCodOpe := Value;
end;

procedure TProdutosAcabados.setCodUni(const Value: String);
begin
  If (FCodUni <> Value) Then
    FCodUni := Value;
end;

procedure TProdutosAcabados.setCodVel(const Value: String);
begin
  If (FCodVel <> Value) Then
    FCodVel := Value;
end;

procedure TProdutosAcabados.setComLub(const Value: String);
begin
  If (FComLub <> Value) Then
    FComLub := Value;
end;

procedure TProdutosAcabados.setComp01(const Value: String);
begin
  If (FComp01 <> Value) Then
   FComp01 := Value;
end;

procedure TProdutosAcabados.setComp02(const Value: String);
begin
  If (FComp02 <> Value) Then
   FComp02 := Value;
end;

procedure TProdutosAcabados.setComp03(const Value: String);
begin
  If (FComp03 <> Value) Then
   FComp03 := Value;
end;

procedure TProdutosAcabados.setComp04(const Value: String);
begin
  If (FComp04 <> Value) Then
   FComp04 := Value;
end;

procedure TProdutosAcabados.setComp05(const Value: String);
begin
  If (FComp05 <> Value) Then
   FComp05 := Value;
end;

procedure TProdutosAcabados.setComp06(const Value: String);
begin
  If (FComp06 <> Value) Then
   FComp06 := Value;
end;

procedure TProdutosAcabados.setComp07(const Value: String);
begin
  If (FComp07 <> Value) Then
   FComp07 := Value;
end;

procedure TProdutosAcabados.setComp08(const Value: String);
begin
  If (FComp08 <> Value) Then
   FComp08 := Value;
end;

procedure TProdutosAcabados.setComp09(const Value: String);
begin
  If (FComp09 <> Value) Then
   FComp09 := Value;
end;

procedure TProdutosAcabados.setComp10(const Value: String);
begin
  If (FComp10 <> Value) Then
   FComp10 := Value;
end;

procedure TProdutosAcabados.setCprCen(const Value: String);
begin
  if (FCprCen <> Value) Then
    FCprCen := Value;
end;

procedure TProdutosAcabados.setDadTec(const Value: String);
begin
  If (FDadTec <> Value) Then
    FDadTec := Value;
end;

procedure TProdutosAcabados.setDesSit(const Value: String);
begin
  If (FDesSit <> Value) Then
    FDesSit := Value;
end;

procedure TProdutosAcabados.setExpAlt(const Value: Double);
begin
  If (FExpAlt <> Value) Then
    FExpAlt := Value;
end;

procedure TProdutosAcabados.setExpLar(const Value: Double);
begin
  If (FExpLar <> Value) Then
    FExpLar := Value;
end;

procedure TProdutosAcabados.setExpPro(const Value: Double);
begin
  If (FExpPro <> Value) Then
    FExpPro := Value;
end;

procedure TProdutosAcabados.setExpPok(const Value: String);
begin
  If (FExpPok <> Value) Then
    FExpPok := Value;
end;

procedure TProdutosAcabados.setExpApp(const Value: String);
begin
  If (FExpApp <> Value) Then
    FExpApp := Value;
end;

procedure TProdutosAcabados.setExpSit(const Value: String);
begin
  If (FExpSit <> Value) Then
    FExpSit := Value;
end;

procedure TProdutosAcabados.setFatUTr(const Value: Double);
begin
  FFatUTr := Value;
end;

procedure TProdutosAcabados.setImpDir(const Value: String);
begin
  If (FImpDir <> Value) Then
    FImpDir := Value;
end;

procedure TProdutosAcabados.setIncDec(const Value: Integer);
begin
  If (FIncDec <> Value) Then
    FIncDec := Value;
end;

procedure TProdutosAcabados.setIncLus(const Value: String);
begin
  If (FIncLus <> Value) Then
    FIncLus := Value;
end;

procedure TProdutosAcabados.setIncPis(const Value: String);
begin
  If (FIncPis <> Value) Then
    FIncPis := Value;
end;

procedure TProdutosAcabados.setIndRev(const Value: String);
begin
  If (FIndRev <> Value) Then
    FIndRev := Value;
end;

procedure TProdutosAcabados.setInfGar(const Value: String);
begin
  If (FInfGar <> Value) Then
    FInfGar := Value;
end;

procedure TProdutosAcabados.setRspGar(const Value: String);
Begin
  If (FRspGar <> Value) Then
    FRspGar := Value;
End;

procedure TProdutosAcabados.setInfLam(const Value: String);
begin
  If (FInfLam <> Value) Then
    FInfLam := Value;
end;

procedure TProdutosAcabados.setIpiSai(const Value: String);
begin
  if (FIpiSai <> Value) Then
    FIpiSai := Value;
end;

procedure TProdutosAcabados.setIteAti(const Value: String);
begin
  If (FIteAti <> Value) Then
    FIteAti := Value;
end;

procedure TProdutosAcabados.setIteBas(const Value: String);
begin
  If (FIteBas <> Value) Then
    FIteBas := Value;
end;

procedure TProdutosAcabados.setItePig(const Value: String);
begin
  If (FItePig <> Value) Then
    FItePig := Value;
end;

procedure TProdutosAcabados.setMenFis(const Value: String);
begin
  if (FMenFis <> Value) Then
    FMenFis := Value;
end;

procedure TProdutosAcabados.setMltCom(const Value: String);
begin
  If (FMltCom <> Value) Then
    FMltCom := Value;
end;

procedure TProdutosAcabados.setMltVen(const Value: String);
begin
  If (FMltVen <> Value) Then
    FMltVen := Value;
end;

procedure TProdutosAcabados.setMsgLv1(const Value: String);
begin
  If (FMsgLv1 <> Value) Then
    FMsgLv1 := Value;
end;

procedure TProdutosAcabados.setMsgLv2(const Value: String);
begin
  If (FMsgLv2 <> Value) Then
    FMsgLv2 := Value;
end;

procedure TProdutosAcabados.setNomIte(const Value: String);
begin
  If (FNomIte <> Value) Then
    FNomIte := Value;
end;

procedure TProdutosAcabados.setNvlGir(const Value: String);
begin
  If (FNvlGir <> Value) Then
    FNvlGir := Value;
end;

procedure TProdutosAcabados.setObrCpf(const Value: String);
begin
  If (FObrCpf <> Value) Then
    FObrCpf := Value;
end;

procedure TProdutosAcabados.setObrIba(const Value: String);
begin
  If (FObrIba <> Value) Then
    FObrIba := Value;
end;

procedure TProdutosAcabados.setPesOit(const Value: String);
begin
  If (FPesOit <> Value) Then
    FPesOit := Value;
end;

procedure TProdutosAcabados.setPesLiq(const Value: String);
begin
  If (FPesLiq <> Value) Then
    FPesLiq := Value;
end;

procedure TProdutosAcabados.setRefere(const Value: String);
begin
  If (FRefere <> Value) Then
    FRefere := Value;
end;

procedure TProdutosAcabados.setSetFlz(const Value: String);
begin
  If (FSetFlz <> Value) Then
    FSetFlz := Value;
end;

procedure TProdutosAcabados.setSitPro(const Value: String);
begin
  If (FSitPro <> Value) Then
    FSitPro := Value;
end;

procedure TProdutosAcabados.setTipPro(const Value: String);
begin
  If (FTipPro <> Value) Then
    FTipPro := Value;
end;

procedure TProdutosAcabados.setTmpGar(const Value: Integer);
begin
  If (FTmpGar <> Value) Then
    FTmpGar := Value;
end;

procedure TProdutosAcabados.setUniCom(const Value: String);
begin
  If (FUniCom <> Value) Then
    FUniCom := Value;
end;

procedure TProdutosAcabados.setUniTri(const Value: String);
begin
  FUniTri := Value;
end;

procedure TProdutosAcabados.setUrlImg(const Value: String);
begin
  If (FUrlImg <> Value) Then
    FUrlImg := Value;
end;

procedure TProdutosAcabados.setUsaBon(const Value: String);
begin
  If (FUsaBon <> Value) Then
    FUsaBon := Value;
end;

procedure TProdutosAcabados.setUsaFle(const Value: String);
begin
  If (FUsaFle <> Value) Then
    FUsaFle := Value;
end;

procedure TProdutosAcabados.setValObr(const Value: String);
begin
  If (FValObr <> Value) Then
    FValObr := Value;
end;

function TProdutosAcabados.fCountCampos(strCampos,
  strSeparador: String): Integer;
var
  intCont: Integer;
begin
  Try
    Result    := 0;
    intCont   := Result;
    If Not fEmptyStr(strCampos) Then
    Begin
      While Not fEmptyStr(strCampos) Do
      Begin
        If (Pos(strSeparador, strCampos) > 0) Then
          strCampos := Trim(Copy(strCampos,Pos(strSeparador,strCampos) + 1,Length(strCampos)))
        Else
          strCampos := '';
        inc(intCont);
      End;
      Result := intCont;
    End;
  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fCountCampos]');
    End;
  End;
end;

function TProdutosAcabados.fExisteCodigoDeFabricao(strCodFab: String): Boolean;
  Var
    qryCon : TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ITE_CODITE           ');
        SQL.Add('  FROM CADITE               ');
        SQL.Add(' WHERE ITE_CODFAB = :CODFAB ');
        //SQL.Add('   AND ITE_CODEMP = :CODEMP ');
        ParamByName('CODFAB').AsString := strCodFab;
        //ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;
        Result := Not IsEmpty;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fExisteCodigoDeFabricao]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fExisteComplemento(strCodIte: String): Boolean;
  Var
    qryCon : TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ETI_CODITE           ');
        SQL.Add('  FROM COMETI               ');
        SQL.Add(' WHERE ETI_CODITE = :CODITE ');

        ParamByName('CODITE').AsString := strCodIte;

        Open;
        Result := Not IsEmpty;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fExisteComplemento]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fPopulaStringListAbfIteger(
  strCodigoItem: String): TStringList;
Var
  qryAux: TUniQuery;
begin
  Result := TStringList.Create;
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Add(' SELECT ITE_CODEMP, IFNULL(ITE_CODABF, "") AS ITE_CODABF FROM ITEGER ');
    qryAux.SQL.Add(' INNER JOIN CADEMP ON ITE_CODEMP = EMP_CODEMP ');
    qryAux.SQL.Add(' WHERE ITE_CODITE = '+ QuotedStr(strCodigoItem) );
    qryAux.SQL.Add(' ORDER BY EMP_CODEMP ');

    qryAux.Open;
    qryAux.First;
    While Not qryAux.Eof do
    Begin
      Result.Add(qryAux.FieldByName('ITE_CODEMP').AsString + ';' + qryAux.FieldByName('ITE_CODABF').AsString );
      qryAux.Next;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TProdutosAcabados.fProximoCodigo(strNomeTabela: String; const strCampoBusca : String): String;
begin
  Result := fAtualizaProCod(strNomeTabela, strCampoBusca);
end;


function TProdutosAcabados.fRetornaCampoChave(strTabela: String): String;
begin
  Result := '';
  If strTabela = 'CADGRU' Then Result := 'GRU_CODGRU';
  If strTabela = 'CADMAR' Then Result := 'MAR_CODMAR';
  If strTabela = 'CADCOR' Then Result := 'COR_CODCOR';
  If strTabela = 'CADUNI' Then Result := 'UNI_CODUNI';
  If strTabela = 'CADITE' Then Result := 'ITE_CODITE';  
end;

function TProdutosAcabados.fRetornaCamposConfigurados(strNomeCampo: String): String;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLConsultaCfgSis);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODCFG').AsString := strNomeCampo;
        Open;

        Result := FieldByName('SIS_VALCFG').AsString;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaCamposConfigurados]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fRetornaCodigoAbreviacao(const Lista: TStringList;
  const strCodEmpresa: string): String;
var
  i: Integer;
  Posicao: Integer;
  Index: Integer;
begin
  Result := '';
  Posicao := -1;
  Index := -1; // Valor padrão para "não encontrado"

  for i := 0 to Lista.Count - 1 do
  begin
    Posicao := Pos(';', Lista[i]); // Encontra a posição do ponto e vírgula
    if Posicao > 0 then // Verifica se o ponto e vírgula foi encontrado
    begin
      if LeftStr(Lista[i], Posicao - 1) = strCodEmpresa then // Compara a parte esquerda da string
      begin
        Index := i; // Retorna o índice da string encontrada
        Break; // Sai da função
      end;
    end;
  end;

  If (Index > -1) And (Posicao > -1) Then
    Result := MidStr(Lista[Index], Posicao+1, 3);

end;

function TProdutosAcabados.fRetornaCodigoFabricaDoProdutoAcabado(strCodUni, strCodCor, strCodIte: String): String;
var
  intCont  : Integer;
  blnRetZer: Boolean;
begin
  Result := '';

  blnRetZer := fCfgSis('ZERFAB', varBoolean);

  pLendoCamposCodigoFabrica(fRetornaCamposConfigurados('CFG_CFPACA')); // Descricao do produto acabado
  If Assigned(arrCodigoFabrica) Then
  Begin
    For intCont := 0 To Length(arrCodigoFabrica) - 1 Do
    Begin
      If fEmptyStr(Result) Then
        Result := fRetornaParteDoCodigaDaFabrica(arrCodigoFabrica[intCont].strTabela, arrCodigoFabrica[intCont].strCampo, strCodUni, strCodCor, strCodIte, blnRetZer)
      Else
        Result := Result + '.' + fRetornaParteDoCodigaDaFabrica(arrCodigoFabrica[intCont].strTabela, arrCodigoFabrica[intCont].strCampo, strCodUni, strCodCor, strCodIte, blnRetZer);
    End;
  End;
end;

function TProdutosAcabados.fRetornaComposicaoProdutoAcabado(
  strCodCom: String): Double;
var
  qryCon: TUniQuery;
  fltValCom: Double;
begin
  Result := 0;
  fltValCom := 0;
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT DCO_CODITE, ');
        SQL.Add('        DCO_QTDITE  ');
        SQL.Add('   FROM GERCOM,     ');
        SQL.Add('        DETCOM      ');
        SQL.Add('  WHERE GERCOM.AUTOINCREM = DCO_SEQGER ');
        SQL.Add('    AND GCO_CODEMP = DCO_CODEMP        ');
        SQL.Add('    AND GCO_CODCOM = :CODCOM           ');
        ParamByName('CODCOM').AsString := strCodCom;
        Open;

        First;
        While Not Eof Do
        Begin
          fltValCom := fltValCom +
                       fFormataFloat((fRetornaCustoProdutoComposicao(FieldByName('DCO_CODITE').AsString) *
                        FieldByName('DCO_QTDITE').AsFloat),4);
          Next;
        End;

        Result := fltValCom;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaComposicaoProdutoAcabado]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fRetornaCustoProdutoComposicao(
  strCodIteCom: String): Double;
var
  qryCon: TUniQuery;
begin
  Result := 0;
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT ITE_PRECUS ');
        SQL.Add('   FROM ITEGER     ');
        SQL.Add('  WHERE ITE_CODITE = :CODITE ');
        SQL.Add('    AND ITE_CODEMP = :CODEMP ');
        ParamByName('CODITE').AsString := strCodIteCom;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        Result := FieldByName('ITE_PRECUS').AsFloat;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaCustoProdutoComposicao]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fRetornaDescricaoDoProdutoAcabado(strCodUni, strCodCor, strCodIte: String): String;
var
  intCont: Integer;
  strDescricao : String;
begin
  Result := '';
  pLendoCamposDescricao(fRetornaCamposConfigurados('CFG_DPACAB')); // Descricao do produto acabado
  If Assigned(arrDescricao) Then
  Begin
    For intCont := 0 To Length(arrDescricao) - 1 Do
    Begin
      strDescricao := Trim(fRetornaParteDaDescricao(arrDescricao[intCont].strTabela, arrDescricao[intCont].strCampo, strCodUni, strCodCor, strCodIte));
      if not fEmptyStr(strDescricao) then
      begin
        If fEmptyStr(Result) Then
          Result := strDescricao
        Else
          Result := Result + ' ' + strDescricao;
      end;
    End;
  End;
end;

function TProdutosAcabados.fRetornaLitragemUnidade(strCodUni: String): Double;
var
  qryCons : TUniQuery;
begin
  Result := 0;
  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT UNI_PESLIT ');
        SQL.Add('   FROM CADUNI     ');
        SQL.Add('  WHERE UNI_CODUNI = :CODUNI ');
        ParamByName('CODUNI').AsString := strCodUni;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('UNI_PESLIT').AsFloat;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaLitragemUnidade]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TProdutosAcabados.fRetornaParametroChave(strTabela, strCodUni, strCodCor, strCodIte: String): String;
begin
  Result := '';
  If strTabela = 'CADGRU' Then Result := FCodGru;
  If strTabela = 'CADMAR' Then Result := FCodMar;
  If strTabela = 'CADCOR' Then Result := strCodCor;
  If strTabela = 'CADUNI' Then Result := QuotedStr(strCodUni);
  If strTabela = 'CADITE' Then Result := strCodIte;
end;

function TProdutosAcabados.fRetornaParteDaDescricao(strTabela,
  strCampo, strCodUni, strCodCor, strCodIte: String): String;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLDescricao(strTabela,strCampo,strCodUni,strCodCor, strCodIte));
        Open;

        Result := FieldByName(strCampo).AsString;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaCamposConfigurados]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fRetornaParteDoCodigaDaFabrica(strTabela, strCampo,
  strCodUni, strCodCor, strCodIte: String; blnRetZer: Boolean): String;
var
  qryCon: TUniQuery;

  function fRetiraZeroEsquera(strCodigo: String): String;
  Var
    intContador: Integer;
    blnPriCar  : Boolean;
  Begin

    blnPriCar := False;
    Result      := '';

    strCodigo := Trim(strCodigo);

    For intContador := 1 To Length(strCodigo) Do
    Begin
      {**************************************************}
      {* SE NÃO FOR ZERO OU SE JÁ ENCONTROU O PRIMEIRO  *}
      {* CARACTER DIFERENTE DE ZERO, CONCATENA A STRING *}
      {***********************************************PZ*}
      If (strCodigo[intContador] <> '0') Or (blnPriCar) Then
      Begin
        Result := Result + strCodigo[intContador];
        blnPriCar := True;
      End;
    End;

  End;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetornaSQLCodigoFabrica(strTabela,strCampo,strCodUni,strCodCor, strCodIte));
        Open;

        If (Pos(')',strCampo) <= 0) And (Pos('.',strCampo) > 0) Then
          strCampo := Copy(strCampo,Pos('.',strCampo) + 1,Length(strCampo));

        Result := FieldByName(strCampo).AsString;

        If (fEmptyStr(Result)) And (strTabela = 'CADITE') And (Pos('ITE_CODITE',strCampo) > 0) Then
          Result := strCodIte;

        If blnRetZer Then
          Result := fRetiraZeroEsquera(Result);

      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fRetornaParteDoCodigaDaFabrica]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.fRetornaPrecoCompraProdutoAcabado(strCodUni,
  strCodCom, strCodCor: String): Double;
begin
  Result := fRetornaPrecoCustoProdutoAGranel(strCodCor, fRetornaTipoUnidade(strCodUni)) *
            fRetornaLitragemUnidade(strCodUni) +
            fRetornaComposicaoProdutoAcabado(strCodCom);
end;

function TProdutosAcabados.fRetornaPrecoCustoProdutoAGranel(strCodCor, strTipUni: String): Double;
var
  qryCons  : TUniQuery;
  fltPreCus: Double;
  fltPesEsp: Double;
begin
  Result    := 0;
  fltPreCus := 0;

  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT DMT_QTDITE, ');
        SQL.Add('        ITE_PRECUS AS DMT_CUSITE, ');
        SQL.Add('        GMT_PESREA');
        SQL.Add('   FROM GEIMAT     ');
        SQL.Add('   JOIN DEIMAT ON GEIMAT.AUTOINCREM = DMT_SEQGER   ');
        SQL.Add('   LEFT JOIN CADITE C ON C.ITE_CODITE = DMT_ITESUB ');
        SQL.Add('   LEFT JOIN ITEGER I ON I.ITE_CODITE = DMT_ITESUB AND I.ITE_CODEMP = :CODEMP ');
        SQL.Add('  WHERE ');
        SQL.Add('    GMT_STATUS = "A"     ');
        SQL.Add('    AND GMT_CODITE = :CODITE ');
        SQL.Add('    AND GMT_CODCOR = :CODCOR ');
        ParamByName('CODITE').AsString := FCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODCOR').AsString := strCodCor;
        Open;

        fltPesEsp := FieldByName('GMT_PESREA').AsFloat;

        First;
        While Not Eof Do
        Begin
          If FieldByName('DMT_QTDITE').AsFloat > 0 Then
          Begin
            fltPreCus := fltPreCus + fFormataFloat(((FieldByName('DMT_CUSITE').AsFloat *
                                                     FieldByName('DMT_QTDITE').AsFloat) / 100),4);
          End;

          Next;
        End;

        If strTipUni = 'L' Then //Litro
        Begin
          If (fltPreCus > 0) And (fltPesEsp > 0) Then
            Result := fFormataFloat((fltPreCus * fltPesEsp), 4);
        End
        Else //Kilo
        Begin
          If (fltPreCus > 0) Then
            Result := fFormataFloat(fltPreCus,4);
        End;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaPrecoCustoProdutoAGranel]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TProdutosAcabados.fRetornaSQLCodigoFabrica(strTabela, strCampo,
  strCodUni, strCodCor, strCodIte: String): String;
begin
  Result := '';
  Result := Result + 'SELECT ' + strCampo  + '';
  Result := Result + '  FROM ' + strTabela + '';
  Result := Result + ' WHERE ' + fRetornaCampoChave(strTabela) + ' = ' + fRetornaParametroChave(strTabela,strCodUni,strCodCor, strCodIte);
end;

function TProdutosAcabados.fRetornaSQLConsultaCfgSis: String;
begin
  Result := '';
  Result := Result + 'SELECT SIS_VALCFG  ';
  Result := Result + '  FROM CFGSIS      ';
  Result := Result + ' WHERE SIS_CODEMP = :CODEMP ';
  Result := Result + '   AND SIS_CODCFG = :CODCFG ';
end;

function TProdutosAcabados.fRetornaSQLDescricao(strTabela,
  strCampo, strCodUni, strCodCor, strCodIte : String): String;
begin
  Result := '';
  Result := Result + 'SELECT ' + strCampo  + '';
  Result := Result + '  FROM ' + strTabela + '';
  Result := Result + ' WHERE ' + fRetornaCampoChave(strTabela) + ' = ' + fRetornaParametroChave(strTabela,strCodUni,strCodCor, strCodIte);
end;

function TProdutosAcabados.fRetornaTipoUnidade(strCodUni: String): String;
var
  qryCons : TUniQuery;
begin
  Result := '';
  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT UNI_KILLIT ');
        SQL.Add('   FROM CADUNI     ');
        SQL.Add('  WHERE UNI_CODUNI = :CODUNI ');
        ParamByName('CODUNI').AsString := strCodUni;
        Open;

        If Not IsEmpty Then
          Result := FieldByName('UNI_KILLIT').AsString;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fRetornaTipoUnidade]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TProdutosAcabados.fAtualizaCustos(blnMargem: Boolean;
                              prgProgresso: TProgressBar): Boolean;
  Var
    qryProdutoGranel: TUniQuery;
    fltPreCom: Double;
Begin

  Try
    Result := True;

    qryProdutoGranel := fCriaQuery;

    With qryProdutoGranel, SQL Do
    Begin
      Clear;

      Add('SELECT                                                               ');
      Add('  GR.ITE_CODITE         AS CODITE,                                   ');
      Add('  GTM_CODCOR            AS CODCOR,                                   ');
      Add('  IFNULL(GMT_PESREA, 0) AS PESREA,                                   ');
      Add('  GEIMAT.AUTOINCREM     AS SEQGMT                                    ');
      Add('FROM                                                                 ');
      Add('  CADITE GR                                                          ');
      Add('  INNER JOIN CADITE C ON C.ITE_CODPAG = GR.ITE_CODITE                ');
      Add('  INNER JOIN GEIMAT ON GMT_CODITE = GR.ITE_CODITE                    ');
      Add('                   AND GMT_CODCOR = GR.ITE_CODCOR                    ');
      Add('                   AND GMT_STATUS = "A"                              ');
      Add('WHERE                                                                ');
      Add('     GR.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ') ');
      Add(' AND C.ITE_CODPAG IS NOT NULL                                        ');

      //FILTROS GRANEL
      If Not fEmptyStr(FobjFiltro.strCodGra) Then
        Add(' AND C.ITE_CODPAG IN (' + FobjFiltro.strCodGra + ')                ');

      If Not fEmptyStr(FobjFiltro.strLinGruGra) Then
        Add(' AND GR.ITE_CODGRU IN (' + FobjFiltro.strLinGruGra + ')            ');

      If Not fEmptyStr(FobjFiltro.strDepGra) Then
        Add(' AND GR.ITE_CODDEP IN (' + FobjFiltro.strDepGra + ')               ');

      If Not fEmptyStr(FobjFiltro.strRefGra) Then
        Add(' AND GR.ITE_REFERE = ' + QuotedStr(FobjFiltro.strRefGra)            );


       //FILTROS ACABADO
      If Not fEmptyStr(FobjFiltro.strCodAca) Then
        Add(' AND C.ITE_CODITE IN (' + FobjFiltro.strCodAca + ')                ');

      If Not fEmptyStr(FobjFiltro.strLinGruAca) Then
        Add(' AND C.ITE_CODGRU IN (' + FobjFiltro.strLinGruAca + ')             ');

      If Not fEmptyStr(FobjFiltro.strDepAca) Then
        Add(' AND C.ITE_CODDEP IN (' + FobjFiltro.strDepAca + ')                ');

      If Not fEmptyStr(FobjFiltro.strRefAca) Then
        Add(' AND C.ITE_REFERE = ' + QuotedStr(FobjFiltro.strRefAca)             );

      Add(' GROUP BY GR.ITE_CODITE, GMT_CODCOR                                  ');
      Add(' ORDER BY GR.ITE_CODITE, GMT_CODCOR                                  ');

      Open;

      If IsEmpty Then
      Begin
        pMensagemOk('Nenhum produto encontrado!');
        Result := False;
      End Else
      Begin
        prgProgresso.Position := 0;
        prgProgresso.Max      := RecordCount;
        prgProgresso.Visible  := True;
      End;
      strAgrupadorPreAlt := '';
      pPreAltDefineVariaveisAltPre(fNow, 'ATUALIZACAO CUSTO DE ACABADOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);


      While Not Eof Do
      Begin

        pAtualizaPrecosProdutosAcabados(FieldByName('CODPAG').AsString, FieldByName('CODCOR').AsString, FieldByName('SEQGMT').AsString, FieldByName('PESREA').AsFloat);

        fltPreCom := fRetornaPrecoCompraProdutoAcabado(FieldByName('CODUNI').AsString,
                                                       FieldByName('CODCOM').AsString,
                                                       FieldByName('CODCOR').AsString);

        Result := fAtualizaPrecoAcabado(FieldByName('CODITE').AsString, fltPreCom, blnMargem);

        If Not Result Then
          Break;

        prgProgresso.StepBy(1);
        Application.ProcessMessages;

        Next;
      End;

      prgProgresso.Visible  := False;

      Close;
    End;

    FreeAndNil(qryProdutoGranel);
    strAgrupadorPreAlt := '';

  Except
    On E: Exception Do
    Begin
      Result := False;
      strAgrupadorPreAlt := '';
      pMensagensErro(E.Message, 'TProdutosAcabados.fAtualizaCustos');
    End;

  End;

End;



procedure TProdutosAcabados.pAtualizaPrecosProdutosAcabados(strCodigoProdutoGranel, strCodigoCor, strAutoIncremGEIMAT : String; fltPesoReal : double);
begin
end;

function TProdutosAcabados.fAtualizaPrecoAcabado(strCodAca: String;
                               fltPreCom: Double; blnMargem: Boolean): Boolean;
  Const
    INTMAXPRE = 7;
  Var
    qryIteger: TUniQuery;
    intContador: Integer;
    strCampo: String;
    cpcParams: TParCalculaPrecoCusto;

    fltComAnt,
    fltCusAnt: Double;

    arrPreAnt,
    arrMarAnt: Array[1..INTMAXPRE] Of Double;
Begin
  Try
    Result := True;
    
    qryIteger := fCriaQuery;

    With qryIteger, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM ITEGER');
      Add('WHERE ITE_CODITE = :CODITE AND LOCATE(ITE_CODEMP, "' + fRetEmpresasUsamPrecoMatriz + '") > 0 ');

      ParamByName('CODITE').AsString := strCodAca;

      Open;

      If Not IsEmpty Then
      Begin
        fStartTransaction;
        While not Eof Do
        Begin
          fltCusAnt := FieldByName('ITE_PRECUS').AsFloat;
          fltComAnt := FieldByName('ITE_PRECOM').AsFloat;

          For intContador := Low(arrPreAnt) To High(arrPreAnt) Do
          Begin
            arrPreAnt[intContador] := FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat;
            arrMarAnt[intContador] := FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat;
          End;

          Edit;

          FieldByName('ITE_PRECOM').AsFloat := fltPreCom;
          FieldByName('ITE_PREALT').AsString:= strAgrupadorPreAlt;

          cpcParams := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

          With cpcParams Do
          Begin
            curPreCom := FieldByName('ITE_PRECOM').AsFloat;
            curDesF01 := FieldByName('ITE_DESF01').AsFloat;
            curDesF02 := FieldByName('ITE_DESF02').AsFloat;
            curDesF03 := FieldByName('ITE_DESF03').AsFloat;
            curDesF04 := FieldByName('ITE_DESF04').AsFloat;
            curDesF05 := FieldByName('ITE_DESF05').AsFloat;
            curDesF06 := FieldByName('ITE_DESF06').AsFloat;
            curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
            curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
            curFrete  := FieldByName('ITE_FREENT').AsFloat;
            curValFre := FieldByName('ITE_VALFRE').AsFloat;
            curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
            curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
            curDesAdb := FieldByName('ITE_DESADB').AsFloat;
            curSubFed := FieldByName('ITE_SUBFED').AsFloat;

            if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
            begin
              curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
              curTSCust := FieldByName('ITE_TSCUST').AsFloat;
              curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
              curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
              curFatReg := FieldByName('ITE_FATREG').AsFloat;
            end
            else
            begin
              curTCIFCu := 0;
              curTSCust := 0;
              curDePiCo := 0;
              curDeICMS := 0;
              curFatReg := 0;
            end;

            FieldByName('ITE_PRECUS').AsFloat := fCalculaPrecoCusto;
          End;

          For intContador := 1 To Length(VS_strTabVen) Do
          Begin

            If blnMargem Then
              strCampo := 'ITE_MARBR' + IntToStr(intContador)
            Else
              strCampo := 'ITE_PREVE' + IntToStr(intContador);

            FieldByName(strCampo).AsFloat :=
              fCalculaPrecoVenda(IIF(blnMargem, 2, 1),
                                 FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                                 FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                 FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat,
                                 FieldByName('ITE_ICMSAI').AsFloat,
                                 FieldByName('ITE_IMPFED').AsFloat,
                                 FieldByName('ITE_DESOPE').AsFloat,
                                 FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat);
          End;

          Post;
          If (Not VS_blnPreAltViaTrigger) Then
            Result :=
            fGravaPreAlt(FieldByName('ITE_CODITE').AsString,
                         fltCusAnt,
                         FieldByName('ITE_PRECUS').AsFloat,

                         arrPreAnt[1],
                         FieldByName('ITE_PREVE1').AsFloat,
                         arrMarAnt[1],
                         FieldByName('ITE_MARBR1').AsFloat,

                         arrPreAnt[2],
                         FieldByName('ITE_PREVE2').AsFloat,
                         arrMarAnt[2],
                         FieldByName('ITE_MARBR2').AsFloat,

                         arrPreAnt[3],
                         FieldByName('ITE_PREVE3').AsFloat,
                         arrMarAnt[3],
                         FieldByName('ITE_MARBR3').AsFloat,

                         arrPreAnt[4],
                         FieldByName('ITE_PREVE4').AsFloat,
                         arrMarAnt[4],
                         FieldByName('ITE_MARBR4').AsFloat,

                         arrPreAnt[5],
                         FieldByName('ITE_PREVE5').AsFloat,
                         arrMarAnt[5],
                         FieldByName('ITE_MARBR5').AsFloat,

                         arrPreAnt[5],
                         FieldByName('ITE_PREVE6').AsFloat,
                         arrMarAnt[6],
                         FieldByName('ITE_MARBR6').AsFloat,

                         arrPreAnt[7],
                         FieldByName('ITE_PREVE7').AsFloat,
                         arrMarAnt[7],
                         FieldByName('ITE_MARBR7').AsFloat,

                         fltComAnt,
                         fltPreCom,

                         'ATUALIZACAO CUSTO DE ACABADOS',

                         Nil,
                         '',
                         strLoginUsuarioLogado);
          Next;
        End;
        fCommit;
      End;

    End;

    FreeAndNil(qryIteger);
    FreeAndNil(cpcParams);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, 'TProdutosAcabados.fAtualizaPrecoAcabado');
    End;
  End;

End;

procedure TProdutosAcabados.pRetornaProdutoSeExisteCodigoDeFabricao(strCodFab: String; Var strCodPro, strDespro: String);
  Var
    qryCon : TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ITE_CODITE, ITE_DESITE ');
        SQL.Add('  FROM CADITE                 ');
        SQL.Add(' WHERE ITE_CODFAB = :CODFAB   ');
        ParamByName('CODFAB').AsString := strCodFab;
        Open;

        strCodPro := FieldByName('ITE_CODITE').AsString;
        strDesPro := FieldByName('ITE_DESITE').AsString;

        Close;
      End;
    Except
      On E: Exception Do
      Begin
        strCodPro := '';
        strDesPro := '';
        pMensagensErro(E.Message, '[fExisteCodigoDeFabricao]');
      End;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TProdutosAcabados.getCDCEST: String;
begin
  Result := FStrCDCEST;
end;

function TProdutosAcabados.getDesFab: String;
begin
  Result := FStrDesFab;
end;

function TProdutosAcabados.getPraVal: String;
begin
  Result := FstrPraVal;
end;

function TProdutosAcabados.getNivGir: String;
begin
  Result := FstrNivGir;
end;

function TProdutosAcabados.getPrdGru: String;
begin
  Result := FstrPrdGru;
end;

procedure TProdutosAcabados.setCDCEST(const Value: String);
begin
  FstrCDCEST := Value;
end;

procedure TProdutosAcabados.setDesFab(const Value: String);
begin
  FstrDesFab := Value;
end;

procedure TProdutosAcabados.setPraVal(const Value: String);
begin
  FstrPraVal := Value;
end;

procedure TProdutosAcabados.setNivGir(const Value: String);
begin
  FstrNivGir := Value;
end;

procedure TProdutosAcabados.setPrdGru(const Value: String);
begin
  FstrPrdGru := Value;
end;


end.
