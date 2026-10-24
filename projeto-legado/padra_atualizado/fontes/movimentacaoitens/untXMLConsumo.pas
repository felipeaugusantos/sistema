unit untXMLConsumo;

interface

uses
  System.SysUtils,
  System.Classes,
  Xml.XMLIntf,
  Xml.XMLDoc,
  System.Generics.Collections,
  System.IOUtils,
  System.StrUtils,
  DateUtils,
  Variants,
  System.Math;

type

  TXMLDoc = class;
  TXMLNFdet = class;

  TProcXMLDoc = reference to procedure(ADoc: TXMLDoc);
  TProcXMLProd = reference to procedure(AItem: TXMLNFdet);

  TXMLIde = class
  private
    FDoc: TXMLDoc;
  public
    constructor Create(ADoc: TXMLDoc);
    function Numero: string;
    function Serie: string;
    function DataEmissao: String;
    function cUF: string;
    function tpAmb: string;
    function tpEmis: string;
    function ChaveAcesso: string;
  end;

  TXMLEmit = class
  private
    FDoc: TXMLDoc;
  public
    constructor Create(ADoc: TXMLDoc);
    function CNPJ: string;
    function IE: string;
    function Nome: string;
    function Fantasia: string;
    function Logradouro: string;
    function Numero: string;
    function Bairro: string;
    function CidadeCod: string;
    function UF: string;
  end;

  TXMLDest = class
  private
    FDoc: TXMLDoc;
  public
    constructor Create(ADoc: TXMLDoc);
    function CNPJ: string;
    function IE: string;
    function Nome: string;
    function Fantasia: string;
    function Logradouro: string;
    function Numero: string;
    function Bairro: string;
    function CidadeCod: string;
    function UF: string;
    function IdOutros: string;
  end;

  TXMLTotal = class
  private
    FDoc: TXMLDoc;
    FpPIS: Currency;
    FpCOFINS: Currency;
    FvBC_PIS: Currency;
    FvBC_COFINS: Currency;
    FRetPISAcum: Currency;
    FRetCOFINSAcum: Currency;
    FRetCSLLAcum: Currency;
    FRetIRRFAcum: Currency;
    FvIS_Doc      : Currency;   // SUM vIS por item      -> CADFIS.FIS_TOT_IS
    FvIBS_Doc     : Currency;   // SUM vIBSUF + vIBSMun  -> CADFIS.FIS_TOTIBS
    FvIBSUF_Doc   : Currency;   // SUM vIBSUF            -> FISREF.FIS_IBSUFV
    FvIBSMun_Doc  : Currency;   // SUM vIBSMun           -> FISREF.FIS_IBSMNV
    FvCBS_Doc     : Currency;   // SUM vCBS              -> CADFIS.FIS_TOTCBS
    FvProIS_Doc   : Currency;   // Total profissional IS -> CADFIS.FIS_TPROIS
    FvNF_Doc      : Currency;   // vNF totalizador       -> CADFIS.FIS_TOT_NF
    FvBC_IBSCBS   : Currency;   // SUM vBC do gIBSCBS
    FvBCIS_Doc    : Currency;
  public
    constructor Create(ADoc: TXMLDoc);
    function ValorTotal: Currency;
    function ValorICMS: Currency;
    function ValorBC: Currency;
    function ValorPIS: Currency;
    function ValorCOFINS: Currency;
    function ValorPISEfet: Currency;
    function ValorCOFINSEfet: Currency;
    function ValorRetTribTot: Currency;
    function ValorOutros: Currency;

    function ValorRetPISAcum: Currency;
    function ValorRetCOFINSAcum: Currency;
    function ValorRetCSLLAcum: Currency;
    function ValorRetIRRFAcum: Currency;
    function AliquotaPis: Currency;
    function AliquotaCofins: Currency;
    function BasePis: Currency;
    function BaseCOFINS: Currency;
    function ValorIS_Doc     : Currency;
    function ValorIBS_Doc    : Currency;
    function ValorIBSUF_Doc  : Currency;
    function ValorIBSMun_Doc : Currency;
    function ValorCBS_Doc    : Currency;
    function ValorProIS_Doc  : Currency;
    function ValorNF_Doc     : Currency;
    function BaseIBSCBS_Doc  : Currency;
    function BaseIS_Doc      : Currency;
    function AliqEfetIBSUF_Doc : Currency;
    function AliqEfetIBSMun_Doc: Currency;
    function AliqEfetCBS_Doc   : Currency;
  end;

  TXMLSCEE = class
  private
    FDoc: TXMLDoc;
    FTpPartComp     : String;
    FIdAcessGer     : String;
    FVPotInst       : Currency;
    FTpFonteEnergia : String;
    FEnerAloc       : Currency;
    FTpPosTar       : String;
    FEnerInjet      : Currency;
    FTpPosTarInjet  : String;
  public
    constructor Create(ADoc: TXMLDoc);
    property TpPartComp     : String   read FTpPartComp     write FTpPartComp;
    property IdAcessGer     : String   read FIdAcessGer     write FIdAcessGer;
    property VPotInst       : Currency read FVPotInst       write FVPotInst;
    property TpFonteEnergia : String   read FTpFonteEnergia write FTpFonteEnergia;
    property EnerAloc       : Currency read FEnerAloc       write FEnerAloc;
    property TpPosTar       : String   read FTpPosTar       write FTpPosTar;
    property EnerInjet      : Currency read FEnerInjet      write FEnerInjet;
    property TpPosTarInjet  : String   read FTpPosTarInjet  write FTpPosTarInjet;
  end;

  TXMLgTarif = class
  private
    FDoc: TXMLDoc;
  public
    dIniTarif: string;
    dFimTarif: string;
    tpAto: string;
    nAto: string;
    anoAto: string;
    tpTarif: string;
    cPosTarif: string;
    uMed: string;
    vTarifHom: Currency;
    vTarifAplic: Currency;
    motDifTarif: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLgAdBand = class
  private
    FDoc: TXMLDoc;
  public
    dIniAdBand: string;
    dFimAdBand: string;
    tpBand: string;
    vAdBand: Currency;
    vAdBandAplic: Currency;
    motDifBand: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLgANEEL = class
  private
    FDoc: TXMLDoc;
    FCompetList: TList<string>;
    FValueList: TList<Currency>;
  public
    constructor Create(ADoc: TXMLDoc);
    destructor Destroy; override;
    procedure AddCompet(const ACompet: string; AValue: Currency);
    function Count: Integer;
    function Compet(Index: Integer): string;
    function Valor(Index: Integer): Currency;
  end;

  TXMLgFat = class
  private
    FDoc: TXMLDoc;
  public
    nFat: string;
    CompetFat: string;
    dVencFat: string;
    dApresFat: string;
    codBarras: string;
    codDebAuto: string;
    urlQRCodePIX: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLAcessante = class
  private
    FDoc: TXMLDoc;
  public
    idAcesso: string;
    idCodCliente: string;
    tpAcesso: string;
    xNomeUC: string;
    tpClasse: string;
    tpSubClasse: string;
    tpFase: string;
    tpGrpTensao: string;
    tpModTar: string;
    latGPS: string;
    longGPS: string;
    codRoteiroLeitura: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  // --- Assinante (NFCom) ---
  TXMLAssinante = class
  private
    FDoc: TXMLDoc;
  public
    iCodAssinante: string;
    tpAssinante: string;
    tpServUtil: string;
    nContrato: string;
    dContratoIni: string;
    dContratoFim: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  // --- Prot (protocolo) ---
  TXMLProt = class
  private
    FDoc: TXMLDoc;
  public
    nProt: string;
    dhRecbto: string;
    digVal: string;
    cStat: string;
    xMotivo: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLRespTec = class
  private
    FDoc: TXMLDoc;
  public
    CNPJ: string;
    xContato: string;
    email: string;
    fone: string;
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLNFdet = class
  private
    FDoc: TXMLDoc;
  public
    cProd: string;
    xProd: string;
    cClass: string;
    CFOP: string;
    uMed: string;
    qFaturada: Currency;
    vItem: Currency;
    vProd: Currency;
    nMed: string;
    vMed: Currency;
    vBC_ICMS: Currency;
    pICMS: Currency;
    vICMS: Currency;
    vBC_PIS: Currency;
    pPIS: Currency;
    vPIS: Currency;
    vBC_COFINS: Currency;
    pCOFINS: Currency;
    vCOFINS: Currency;
    vBCPISEfet: Currency;
    pPISEfet: Currency;
    vPISEfet: Currency;
    vBCCOFINSEfet: Currency;
    pCOFINSEfet: Currency;
    vCOFINSEfet: Currency;
    vRetPIS: Currency;
    vRetCofins: Currency;
    vRetCSLL: Currency;
    vBCIRRF: Currency;
    vIRRF: Currency;
    indOrigemQtd: string;
    indSemCST: string;
    CSTICMS: String;
    CSTPIS: String;
    CSTCOFINS: String;

    CSTIS         : String;
    cClassTribIS  : String;
    vBC_IS        : Currency;
    pIS           : Currency;
    vIS           : Currency;
    CSTIBSCBS         : String;
    cClassTrib        : String;
    vBC_IBSCBS        : Currency;
    pIBSUF            : Currency;
    pAliqEfetIBSUF    : Currency;
    vIBSUF            : Currency;
    pIBSMun           : Currency;
    pAliqEfetIBSMun   : Currency;
    vIBSMun           : Currency;
    pCBS              : Currency;
    pAliqEfetCBS      : Currency;
    vCBS              : Currency;
    CSTReg              : String;
    cClassTribReg       : String;
    pAliqEfetRegIBSUF   : Currency;   // -> MOVREF.REF_AIUREG
    vTribRegIBSUF       : Currency;   // -> MOVREF.REF_TIUREG
    pAliqEfetRegIBSMun  : Currency;   // -> MOVREF.REF_AIMREG
    vTribRegIBSMun      : Currency;   // -> MOVREF.REF_TIMREG
    pAliqEfetRegCBS     : Currency;   // -> MOVREF.REF_CBSREG
    vTribRegCBS         : Currency;   // -> MOVREF.REF_TCBREG
    constructor Create(ADoc: TXMLDoc);
  end;

  TXMLDoc = class
  private
    FXMLDoc: IXMLDocument;
    FNodeInf: IXMLNode;
    FRootName: string;
    FFileName: string;
    FModelo: Integer;
    FValid: Boolean;
    FError: string;
    FIde: TXMLIde;
    FEmit: TXMLEmit;
    FDest: TXMLDest;
    FTotal: TXMLTotal;
    FgTarif: TObjectList<TXMLgTarif>;
    FgAdBand: TObjectList<TXMLgAdBand>;
    FgANEEL: TXMLgANEEL;
    FgFat: TXMLgFat;
    FAcessante: TXMLAcessante;
    FAssinante: TXMLAssinante;
    FProt: TXMLProt;
    FRespTec: TXMLRespTec;
    FProdutos: TObjectList<TXMLNFdet>;
    FInfCpl: string;
    FSCEE: TXMLSCEE;
    function GetNodeText(AParent: IXMLNode; const ATag: string): string;
    function FindNode(const APath: array of string): IXMLNode;
    function LocalizarGrupoICMS(AImposto: IXMLNode): IXMLNode;
    procedure ParseDocument;
    procedure ParseProducts;
    procedure ParsegTarif;
    procedure ParsegAdBand;
    procedure ParsegANEEL;
    procedure ParsegFat;
    procedure ParseAcessante;
    procedure ParseAssinante;
    procedure ParseProt;
    procedure ParseRespTec;
    procedure ParseInfAdic;
    procedure ParseDetItem(const ProdNode, ImpNode: IXMLNode);
    procedure ParseTotaisReformaTributaria;
    procedure ParseItemReformaTributaria(AItem: TXMLNFdet; const ImpNode: IXMLNode);
    procedure ParseSCEE;
    function fInferirTipoValor(const AValor: string): string;
    procedure pPercorrerNo(ANode: IXMLNode; const APath: string;
      ALista: TStringList);
  public
    constructor Create(const AFileName: string);
    destructor Destroy; override;

    property FileName: string read FFileName;
    property Modelo: Integer read FModelo;
    property Valido: Boolean read FValid;
    property Erro: string read FError;

    property Ide: TXMLIde read FIde;
    property Emit: TXMLEmit read FEmit;
    property Dest: TXMLDest read FDest;
    property Total: TXMLTotal read FTotal;
    property gTarifList: TObjectList<TXMLgTarif> read FgTarif;
    property gAdBandList: TObjectList<TXMLgAdBand> read FgAdBand;
    property gANEEL: TXMLgANEEL read FgANEEL;
    property gFat: TXMLgFat read FgFat;
    property Acessante: TXMLAcessante read FAcessante;
    property Assinante: TXMLAssinante read FAssinante;
    property Prot: TXMLProt read FProt;
    property RespTec: TXMLRespTec read FRespTec;
    property InfCpl: string read FInfCpl;
    property SCEE: TXMLSCEE read FSCEE;
    function ProductCount: Integer;
    function Product(Index: Integer): TXMLNFdet;
    procedure LerProdutos(Proc: TProcXMLProd);

    function Protocolo: string;
    function DigestValue: string;
    function fXMLTexto: String;
  end;

  TXMLManager = class
  private
    FList: TObjectList<TXMLDoc>;
    FPathOrFile: string;
    FIsFolder: Boolean;
    procedure CollectFiles(const APath: string);
  public
    constructor Create(const APathOrFile: string; AIsFolder: Boolean = False);
    destructor Destroy; override;

    procedure Reload;
    function Count: Integer;
    function Items(Index: Integer): TXMLDoc;
    procedure ForEach(Proc: TProcXMLDoc);
  end;

function fValor(AstrValor: String; AdobPadrao: Double = 0): Double;
function fAliqEfetiva(AcurValor, AcurBase: Currency): Currency;

implementation

{ TXMLIde }
constructor TXMLIde.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

function TXMLIde.ChaveAcesso: string;
var
  IdAttr: OleVariant;
begin
  Result := '';
  if (FDoc = nil) or (FDoc.FNodeInf = nil) then
    Exit;

  IdAttr := FDoc.FNodeInf.Attributes['Id'];

  if not VarIsNull(IdAttr) then
  begin
    if FDoc.FModelo = 62 then
      Result := Copy(string(IdAttr), 6, 44)
    else
      Result := Copy(string(IdAttr), 5, 44);
  end;
end;

function TXMLIde.Numero: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'nNF');
end;

function TXMLIde.Serie: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'serie');
end;

function TXMLIde.DataEmissao: String;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'dhEmi');
end;

function TXMLIde.cUF: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'cUF');
end;

function TXMLIde.tpAmb: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'tpAmb');
end;

function TXMLIde.tpEmis: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['ide']), 'tpEmis');
end;

{ TXMLEmit }
constructor TXMLEmit.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

function TXMLEmit.CNPJ: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit']), 'CNPJ');
end;

function TXMLEmit.IE: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit']), 'IE');
end;

function TXMLEmit.Nome: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit']), 'xNome');
end;

function TXMLEmit.Fantasia: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit']), 'xFant');
end;

function TXMLEmit.Logradouro: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit', 'enderEmit']), 'xLgr');
end;

function TXMLEmit.Numero: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit', 'enderEmit']), 'nro');
end;

function TXMLEmit.Bairro: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit', 'enderEmit']), 'xBairro');
end;

function TXMLEmit.CidadeCod: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit', 'enderEmit']), 'cMun');
end;

function TXMLEmit.UF: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['emit', 'enderEmit']), 'UF');
end;

{ TXMLDest }
constructor TXMLDest.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

function TXMLDest.CNPJ: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest']), 'CNPJ');
end;

function TXMLDest.IE: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest']), 'IE');
end;

function TXMLDest.Nome: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest']), 'xNome');
end;

function TXMLDest.Fantasia: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest']), 'xFant');
end;

function TXMLDest.Logradouro: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest', 'enderDest']), 'xLgr');
end;

function TXMLDest.Numero: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest', 'enderDest']), 'nro');
end;

function TXMLDest.IdOutros: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest']), 'idOutros');
end;

function TXMLDest.Bairro: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest', 'enderDest']), 'xBairro');
end;

function TXMLDest.CidadeCod: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest', 'enderDest']), 'cMun');
end;

function TXMLDest.UF: string;
begin
  Result := FDoc.GetNodeText(FDoc.FindNode(['dest', 'enderDest']), 'UF');
end;

{ TXMLTotal }
function TXMLTotal.AliquotaCofins: Currency;
begin
  Result := FpCOFINS;
end;

function TXMLTotal.AliquotaPis: Currency;
begin
  Result := FpPIS;
end;

function TXMLTotal.BaseCOFINS: Currency;
begin
  Result := FvBC_COFINS;
end;

function TXMLTotal.BasePis: Currency;
begin
  Result := FvBC_PIS;
end;

constructor TXMLTotal.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

function TXMLTotal.ValorTotal: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vNF'), 0);
end;

function TXMLTotal.ValorICMS: Currency;
var
  LNode: IXMLNode;
begin
  // NF3e: total/ICMSTot/vICMS
  LNode := FDoc.FindNode(['total', 'ICMSTot']);
  if not Assigned(LNode) then
    LNode := FDoc.FindNode(['total']);
  Result := fValor(FDoc.GetNodeText(LNode, 'vICMS'), 0);
end;

function TXMLTotal.ValorBC: Currency;
var
  LNode: IXMLNode;
begin
  // NF3e: total/ICMSTot/vBC
  LNode := FDoc.FindNode(['total', 'ICMSTot']);
  if not Assigned(LNode) then
    LNode := FDoc.FindNode(['total']);
  Result := fValor(FDoc.GetNodeText(LNode, 'vBC'), 0);
end;

function TXMLTotal.ValorPIS: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vPIS'), 0);
end;

function TXMLTotal.ValorCOFINS: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vCOFINS'), 0);
end;

function TXMLTotal.ValorPISEfet: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vPISEfet'), 0);
end;

function TXMLTotal.ValorCOFINSEfet: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vCOFINSEfet'), 0);
end;

function TXMLTotal.ValorRetCOFINSAcum: Currency;
begin
  Result := FRetCOFINSAcum;
end;

function TXMLTotal.ValorRetCSLLAcum: Currency;
begin
  Result := FRetCSLLAcum;
end;

function TXMLTotal.ValorRetIRRFAcum: Currency;
begin
  Result := FRetIRRFAcum;
end;

function TXMLTotal.ValorRetPISAcum: Currency;
begin
  Result := FRetPISAcum;
end;

function TXMLTotal.ValorRetTribTot: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vRetTribTot'), 0);
end;

function TXMLTotal.ValorOutros: Currency;
begin
  Result := fValor(FDoc.GetNodeText(FDoc.FindNode(['total']), 'vOutro'), 0);
end;

function TXMLTotal.ValorIS_Doc: Currency;
begin
  Result := FvIS_Doc;
end;

function TXMLTotal.ValorIBS_Doc: Currency;
begin
  Result := FvIBS_Doc;
end;

function TXMLTotal.ValorIBSUF_Doc: Currency;
begin
  Result := FvIBSUF_Doc;
end;

function TXMLTotal.ValorIBSMun_Doc: Currency;
begin
  Result := FvIBSMun_Doc;
end;

function TXMLTotal.ValorCBS_Doc: Currency;
begin
  Result := FvCBS_Doc;
end;

function TXMLTotal.ValorProIS_Doc: Currency;
begin
  Result := FvProIS_Doc;
end;

function TXMLTotal.ValorNF_Doc: Currency;
begin
  if FvNF_Doc > 0 then
    Result := FvNF_Doc
  else
    Result := ValorTotal;
end;

function TXMLTotal.BaseIBSCBS_Doc: Currency;
begin Result := FvBC_IBSCBS; end;

function TXMLTotal.BaseIS_Doc: Currency;
begin
  Result := FvBCIS_Doc;
end;

{ TXMLgTarif }
constructor TXMLgTarif.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLgAdBand }
constructor TXMLgAdBand.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLgANEEL }
constructor TXMLgANEEL.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
  FCompetList := TList<string>.Create;
  FValueList := TList<Currency>.Create;
end;

destructor TXMLgANEEL.Destroy;
begin
  FCompetList.Free;
  FValueList.Free;
  inherited;
end;

procedure TXMLgANEEL.AddCompet(const ACompet: string; AValue: Currency);
begin
  FCompetList.Add(ACompet);
  FValueList.Add(AValue);
end;

function TXMLgANEEL.Count: Integer;
begin
  Result := FCompetList.Count;
end;

function TXMLgANEEL.Compet(Index: Integer): string;
begin
  Result := FCompetList[Index];
end;

function TXMLgANEEL.Valor(Index: Integer): Currency;
begin
  Result := FValueList[Index];
end;

{ TXMLgFat }
constructor TXMLgFat.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLAcessante }
constructor TXMLAcessante.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLAssinante }
constructor TXMLAssinante.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLProt }
constructor TXMLProt.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLRespTec }
constructor TXMLRespTec.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

{ TXMLNFdet }
constructor TXMLNFdet.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
  qFaturada := 0;
  vItem := 0;
  vProd := 0;
  vMed := 0;
  vBC_ICMS := 0;
  vBC_PIS := 0;
  vBC_COFINS := 0;
  vBCPISEfet := 0;
  vBCCOFINSEfet := 0;
  vRetPIS := 0;
  vRetCofins := 0;
  vRetCSLL := 0;
  vBCIRRF := 0;
  vIRRF := 0;
end;

{ TXMLDoc }
constructor TXMLDoc.Create(const AFileName: string);
begin
  inherited Create;
  FFileName := AFileName;
  FProdutos := TObjectList<TXMLNFdet>.Create(True);
  FgTarif := TObjectList<TXMLgTarif>.Create(True);
  FgAdBand := TObjectList<TXMLgAdBand>.Create(True);
  FgANEEL := TXMLgANEEL.Create(Self);
  FgFat := TXMLgFat.Create(Self);
  FAcessante := TXMLAcessante.Create(Self);
  FAssinante := TXMLAssinante.Create(Self);
  FProt := TXMLProt.Create(Self);
  FRespTec := TXMLRespTec.Create(Self);
  FIde := TXMLIde.Create(Self);
  FEmit := TXMLEmit.Create(Self);
  FDest := TXMLDest.Create(Self);
  FTotal := TXMLTotal.Create(Self);
  FSCEE  := TXMLSCEE.Create(Self);
  FInfCpl := '';
  FValid := False;
  FError := '';

  if not TFile.Exists(AFileName) then
  begin
    FError := 'Arquivo não encontrado: ' + AFileName;
    FValid := False;
    Exit;
  end;

  try
    FXMLDoc := TXMLDocument.Create(nil);
    FXMLDoc.LoadFromFile(AFileName);
    FXMLDoc.Active := True;
    ParseDocument;
    FValid := (FError = '');
  except
    on E: Exception do
    begin
      FError := E.Message;
      FValid := False;
    end;
  end;
end;

destructor TXMLDoc.Destroy;
begin
  FProdutos.Free;
  FgTarif.Free;
  FgAdBand.Free;
  FgANEEL.Free;
  FgFat.Free;
  FAcessante.Free;
  FAssinante.Free;
  FProt.Free;
  FRespTec.Free;
  FTotal.Free;
  FEmit.Free;
  FDest.Free;
  FIde.Free;
  FSCEE.Free;
  FXMLDoc := nil;
  inherited;
end;

function TXMLDoc.GetNodeText(AParent: IXMLNode; const ATag: string): string;
var
  LintContador: Integer;
  LNode: IXMLNode;
begin
  Result := '';
  if not Assigned(AParent) then
    Exit;

  for LintContador := 0 to AParent.ChildNodes.Count - 1 do
  begin
    LNode := AParent.ChildNodes[LintContador];
    if LNode.NodeType = ntElement then
    begin
      if SameText(LNode.LocalName, ATag) then
      begin
        if not LNode.HasChildNodes or (LNode.ChildNodes.First.NodeType = ntText) then
          Result := LNode.Text;
        Break;
      end;
    end;
  end;
end;

function TXMLDoc.FindNode(const APath: array of string): IXMLNode;
var
  i: Integer;
  Node: IXMLNode;
begin
  Result := nil;
  Node := FNodeInf;

  for i := Low(APath) to High(APath) do
  begin
    if (Node = nil) then
      Exit;

    Node := Node.ChildNodes.FindNode(APath[i]);

    if (Node = nil) then
      Exit;
  end;
  Result := Node;
end;

procedure TXMLDoc.ParseDocument;
var
  NodeRoot, NodeDoc: IXMLNode;
begin
  FProdutos.Clear;
  FgTarif.Clear;
  FgAdBand.Clear;
  FgANEEL.FCompetList.Clear;
  FgANEEL.FValueList.Clear;
  FInfCpl := '';

  NodeRoot := FXMLDoc.DocumentElement;
  if not Assigned(NodeRoot) then
  begin
    FError := 'Documento XML inválido';
    Exit;
  end;

  FRootName := NodeRoot.NodeName;

  if FRootName = 'nfcomProc' then
  begin
    FModelo := 62;
    NodeDoc := NodeRoot.ChildNodes.FindNode('NFCom');
    if Assigned(NodeDoc) then
      FNodeInf := NodeDoc.ChildNodes.FindNode('infNFCom');
  end
  else if FRootName = 'nf3eProc' then
  begin
    FModelo := 66;
    NodeDoc := NodeRoot.ChildNodes.FindNode('NF3e');
    if Assigned(NodeDoc) then
      FNodeInf := NodeDoc.ChildNodes.FindNode('infNF3e');
  end
  else if FRootName = 'nfagProc' then
  begin
    FModelo := 75;
    NodeDoc := NodeRoot.ChildNodes.FindNode('NFAg');
    if Assigned(NodeDoc) then
      FNodeInf := NodeDoc.ChildNodes.FindNode('infNFAg');
  end
  else
  begin
    FError := 'Tag raiz não reconhecida: ' + FRootName;
    Exit;
  end;

  if not Assigned(FNodeInf) then
  begin
    FError := 'Bloco infNF não encontrado';
    Exit;
  end;

  // Parse sub-blocos
  ParseProducts;
  ParsegTarif;
  ParsegAdBand;
  ParsegANEEL;
  ParsegFat;
  ParseAcessante;
  ParseAssinante;
  ParseProt;
  ParseRespTec;
  ParseInfAdic;
  ParseTotaisReformaTributaria;
  ParseSCEE;
end;

procedure TXMLDoc.ParseSCEE;
var
  nodSCEE, nodCons: IXMLNode;
begin
  nodSCEE := FindNode(['gSCEE']);
  if not Assigned(nodSCEE) then
    Exit;

  FSCEE.FTpPartComp := GetNodeText(nodSCEE, 'tpPartComp');

  nodCons := nodSCEE.ChildNodes.FindNode('gConsumidor');
  if not Assigned(nodCons) then
    Exit;

  FSCEE.FIdAcessGer     := GetNodeText(nodCons, 'idAcessGer');
  FSCEE.FVPotInst       := fValor(GetNodeText(nodCons, 'vPotInst'),  0);
  FSCEE.FTpFonteEnergia := GetNodeText(nodCons, 'tpFonteEnergia');
  FSCEE.FEnerAloc       := fValor(GetNodeText(nodCons, 'enerAloc'),  0);
  FSCEE.FTpPosTar       := GetNodeText(nodCons, 'tpPosTar');
  FSCEE.FEnerInjet      := fValor(GetNodeText(nodCons, 'enerInjet'), 0);
  FSCEE.FTpPosTarInjet  := GetNodeText(nodCons, 'tpPosTarInjet');
end;

function TXMLDoc.LocalizarGrupoICMS(AImposto: IXMLNode): IXMLNode;
var
  I: Integer;
  LstrName: string;
begin
  Result := nil;
  if not Assigned(AImposto) then
    Exit;

  for I := 0 to AImposto.ChildNodes.Count - 1 do
  begin
    LstrName := AImposto.ChildNodes[I].LocalName;
    if StartsText('ICMS', LstrName) and
       not SameText(LstrName, 'ICMSUFDest') then
      Exit(AImposto.ChildNodes[I]);
  end;
end;

procedure TXMLDoc.ParseProducts;
var
  i           : Integer;
  RootDetNode : IXMLNode;
  DetNode     : IXMLNode;
  DetItemNode : IXMLNode;
  ProdNode    : IXMLNode;
  ImpNode     : IXMLNode;
begin
  // Reset dos acumuladores fiscais alimentados por ParseDetItem
  FTotal.FvBC_PIS       := 0;
  FTotal.FvBC_COFINS    := 0;
  FTotal.FpPIS          := 0;
  FTotal.FpCOFINS       := 0;
  FTotal.FRetPISAcum    := 0;
  FTotal.FRetCOFINSAcum := 0;
  FTotal.FRetCSLLAcum   := 0;
  FTotal.FRetIRRFAcum   := 0;

  FProdutos.Clear;

  if not Assigned(FNodeInf) then
    Exit;

  RootDetNode := FNodeInf.ChildNodes.FindNode('NFdet');

  if Assigned(RootDetNode) then
  begin
    // NF3e — itens em NFdet/det/detItem
    for i := 0 to RootDetNode.ChildNodes.Count - 1 do
    begin
      DetNode := RootDetNode.ChildNodes[i];
      if not SameText(DetNode.LocalName, 'det') then
        Continue;

      DetItemNode := DetNode.ChildNodes.FindNode('detItem');
      if not Assigned(DetItemNode) then
        Continue;

      ProdNode := DetItemNode.ChildNodes.FindNode('prod');
      ImpNode  := DetItemNode.ChildNodes.FindNode('imposto');

      if Assigned(ProdNode) then
        ParseDetItem(ProdNode, ImpNode);
    end;
  end
  else
  begin
    // NFCom — itens em det direto
    for i := 0 to FNodeInf.ChildNodes.Count - 1 do
    begin
      DetNode := FNodeInf.ChildNodes[i];
      if not SameText(DetNode.LocalName, 'det') then
        Continue;

      ProdNode := DetNode.ChildNodes.FindNode('prod');
      ImpNode  := DetNode.ChildNodes.FindNode('imposto');

      if Assigned(ProdNode) then
        ParseDetItem(ProdNode, ImpNode);
    end;
  end;
end;

procedure TXMLDoc.ParsegTarif;
var
  NFdetNode, DetNode, DetItemNode, NodeTarif: IXMLNode;
  i: Integer;
  Obj: TXMLgTarif;
begin
  FgTarif.Clear;
  if not Assigned(FNodeInf) then
    Exit;
  NFdetNode := FNodeInf.ChildNodes.FindNode('NFdet');
  if not Assigned(NFdetNode) then
    Exit;

  for i := 0 to NFdetNode.ChildNodes.Count - 1 do
  begin
    DetNode := NFdetNode.ChildNodes[i];
    if not Assigned(DetNode) then
      Continue;
    DetItemNode := DetNode.ChildNodes.FindNode('detItem');
    if not Assigned(DetItemNode) then
      Continue;
    NodeTarif := DetItemNode.ChildNodes.FindNode('gTarif');
    if Assigned(NodeTarif) then
    begin
      Obj := TXMLgTarif.Create(Self);
      Obj.dIniTarif := GetNodeText(NodeTarif, 'dIniTarif');
      Obj.dFimTarif := GetNodeText(NodeTarif, 'dFimTarif');
      Obj.tpAto := GetNodeText(NodeTarif, 'tpAto');
      Obj.nAto := GetNodeText(NodeTarif, 'nAto');
      Obj.anoAto := GetNodeText(NodeTarif, 'anoAto');
      Obj.tpTarif := GetNodeText(NodeTarif, 'tpTarif');
      Obj.cPosTarif := GetNodeText(NodeTarif, 'cPosTarif');
      Obj.uMed := GetNodeText(NodeTarif, 'uMed');
      Obj.vTarifHom := fValor(GetNodeText(NodeTarif, 'vTarifHom'), 0);
      Obj.vTarifAplic := fValor(GetNodeText(NodeTarif, 'vTarifAplic'), 0);
      Obj.motDifTarif := GetNodeText(NodeTarif, 'motDifTarif');
      FgTarif.Add(Obj);
    end;
  end;
end;

procedure TXMLDoc.ParsegAdBand;
var
  NFdetNode, DetNode, DetItemNode, NodeBand: IXMLNode;
  i: Integer;
  Obj: TXMLgAdBand;
begin
  FgAdBand.Clear;
  if not Assigned(FNodeInf) then
    Exit;
  NFdetNode := FNodeInf.ChildNodes.FindNode('NFdet');
  if not Assigned(NFdetNode) then
    Exit;

  for i := 0 to NFdetNode.ChildNodes.Count - 1 do
  begin
    DetNode := NFdetNode.ChildNodes[i];
    if not Assigned(DetNode) then
      Continue;
    DetItemNode := DetNode.ChildNodes.FindNode('detItem');
    if not Assigned(DetItemNode) then
      Continue;
    NodeBand := DetItemNode.ChildNodes.FindNode('gAdBand');
    if Assigned(NodeBand) then
    begin
      Obj := TXMLgAdBand.Create(Self);
      Obj.dIniAdBand := GetNodeText(NodeBand, 'dIniAdBand');
      Obj.dFimAdBand := GetNodeText(NodeBand, 'dFimAdBand');
      Obj.tpBand := GetNodeText(NodeBand, 'tpBand');
      Obj.vAdBand := fValor(GetNodeText(NodeBand, 'vAdBand'), 0);
      Obj.vAdBandAplic := fValor(GetNodeText(NodeBand, 'vAdBandAplic'), 0);
      Obj.motDifBand := GetNodeText(NodeBand, 'motDifBand');
      FgAdBand.Add(Obj);
    end;
  end;
end;

procedure TXMLDoc.ParsegANEEL;
var
  NodeANEEL, NodeHist, NodeGrand: IXMLNode;
  i: Integer;
begin
  if not Assigned(FNodeInf) then
    Exit;
  NodeANEEL := FNodeInf.ChildNodes.FindNode('gANEEL');
  if not Assigned(NodeANEEL) then
    Exit;
  NodeHist := NodeANEEL.ChildNodes.FindNode('gHistFat');
  if not Assigned(NodeHist) then
    Exit;
  for i := 0 to NodeHist.ChildNodes.Count - 1 do
  begin
    NodeGrand := NodeHist.ChildNodes[i];
    if Assigned(NodeGrand) then
      FgANEEL.AddCompet(GetNodeText(NodeGrand, 'CompetFat'),
        fValor(GetNodeText(NodeGrand, 'vFat'), 0));
  end;
end;

procedure TXMLDoc.ParsegFat;
var
  NodeGFat, NodePIX: IXMLNode;
begin
  if not Assigned(FNodeInf) then
    Exit;
  NodeGFat := FNodeInf.ChildNodes.FindNode('gFat');
  if not Assigned(NodeGFat) then
    Exit;
  FgFat.nFat := GetNodeText(NodeGFat, 'nFat');
  FgFat.CompetFat := GetNodeText(NodeGFat, 'CompetFat');
  FgFat.dVencFat := GetNodeText(NodeGFat, 'dVencFat');
  FgFat.dApresFat := GetNodeText(NodeGFat, 'dApresFat');
  FgFat.codBarras := GetNodeText(NodeGFat, 'codBarras');
  FgFat.codDebAuto := GetNodeText(NodeGFat, 'codDebAuto');
  NodePIX := NodeGFat.ChildNodes.FindNode('gPIX');
  if Assigned(NodePIX) then
    FgFat.urlQRCodePIX := GetNodeText(NodePIX, 'urlQRCodePIX');
end;

procedure TXMLDoc.ParseAcessante;
begin
  if not Assigned(FNodeInf) then
    Exit;
  FAcessante.idAcesso := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'idAcesso');
  FAcessante.idCodCliente :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'), 'idCodCliente');
  FAcessante.tpAcesso := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'tpAcesso');
  FAcessante.xNomeUC := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'xNomeUC');
  FAcessante.tpClasse := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'tpClasse');
  FAcessante.tpSubClasse :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'), 'tpSubClasse');
  FAcessante.tpFase := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'tpFase');
  FAcessante.tpGrpTensao :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'), 'tpGrpTensao');
  FAcessante.tpModTar := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'tpModTar');
  FAcessante.latGPS := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'latGPS');
  FAcessante.longGPS := GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'),
    'longGPS');
  FAcessante.codRoteiroLeitura :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('acessante'), 'codRoteiroLeitura');
end;

procedure TXMLDoc.ParseAssinante;
begin
  if not Assigned(FNodeInf) then
    Exit;
  FAssinante.iCodAssinante :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'), 'iCodAssinante');
  FAssinante.tpAssinante :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'), 'tpAssinante');
  FAssinante.tpServUtil :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'), 'tpServUtil');
  FAssinante.nContrato := GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'),
    'nContrato');
  FAssinante.dContratoIni :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'), 'dContratoIni');
  FAssinante.dContratoFim :=
    GetNodeText(FNodeInf.ChildNodes.FindNode('assinante'), 'dContratoFim');
end;

procedure TXMLDoc.ParseProt;
var
  NodeProt, NodeInfProt: IXMLNode;
begin
  if not Assigned(FXMLDoc.DocumentElement) then
    Exit;

  // Tenta encontrar a tag de protocolo dependendo do modelo
  NodeProt := FXMLDoc.DocumentElement.ChildNodes.FindNode('protNFCom');
  if not Assigned(NodeProt) then
    NodeProt := FXMLDoc.DocumentElement.ChildNodes.FindNode('protNF3e');
  if not Assigned(NodeProt) then
    NodeProt := FXMLDoc.DocumentElement.ChildNodes.FindNode('protNFAg');

  if Assigned(NodeProt) then
  begin
    NodeInfProt := NodeProt.ChildNodes.FindNode('infProt');
    if Assigned(NodeInfProt) then
    begin
      FProt.nProt := GetNodeText(NodeInfProt, 'nProt');
      FProt.dhRecbto := GetNodeText(NodeInfProt, 'dhRecbto');
      FProt.digVal := GetNodeText(NodeInfProt, 'digVal');
      FProt.cStat := GetNodeText(NodeInfProt, 'cStat');
      FProt.xMotivo := GetNodeText(NodeInfProt, 'xMotivo');
    end;
  end;
end;

procedure TXMLDoc.ParseRespTec;
var
  NodeResp: IXMLNode;
begin
  if not Assigned(FNodeInf) then
    Exit;
  NodeResp := FNodeInf.ChildNodes.FindNode('gRespTec');
  if not Assigned(NodeResp) then
    Exit;
  FRespTec.CNPJ := GetNodeText(NodeResp, 'CNPJ');
  FRespTec.xContato := GetNodeText(NodeResp, 'xContato');
  FRespTec.email := GetNodeText(NodeResp, 'email');
  FRespTec.fone := GetNodeText(NodeResp, 'fone');
end;

procedure TXMLDoc.ParseTotaisReformaTributaria;
var
  nodTotal, nodISTot, nodIBSCBSTot, nodGIBS, nodGIBSUF, nodGIBSMun, nodGCBS: IXMLNode;
begin
  nodTotal := FindNode(['total']);
  if not Assigned(nodTotal) then
    Exit;

  // NF3e/NFCom: total/vTotDFe (a NF-e usa vNFTot). Sem a tag, ValorNF_Doc usa vNF.
  FTotal.FvNF_Doc := fValor(GetNodeText(nodTotal, 'vTotDFe'), 0);

  nodISTot := nodTotal.ChildNodes.FindNode('ISTot');
  if Assigned(nodISTot) then
  begin
    FTotal.FvIS_Doc    := fValor(GetNodeText(nodISTot, 'vIS'),    FTotal.FvIS_Doc);
    FTotal.FvProIS_Doc := fValor(GetNodeText(nodISTot, 'vProIS'), FTotal.FvProIS_Doc);
  end;

  // Totais oficiais do documento. Sem IBSCBSTot, fica a soma dos itens
  // feita em ParseItemReformaTributaria.
  nodIBSCBSTot := nodTotal.ChildNodes.FindNode('IBSCBSTot');
  if not Assigned(nodIBSCBSTot) then
    Exit;

  FTotal.FvBC_IBSCBS := fValor(GetNodeText(nodIBSCBSTot, 'vBCIBSCBS'), FTotal.FvBC_IBSCBS);

  nodGIBS := nodIBSCBSTot.ChildNodes.FindNode('gIBS');
  if Assigned(nodGIBS) then
  begin
    FTotal.FvIBS_Doc := fValor(GetNodeText(nodGIBS, 'vIBS'), FTotal.FvIBS_Doc);

    nodGIBSUF := nodGIBS.ChildNodes.FindNode('gIBSUF');
    if Assigned(nodGIBSUF) then
      FTotal.FvIBSUF_Doc := fValor(GetNodeText(nodGIBSUF, 'vIBSUF'), FTotal.FvIBSUF_Doc);

    nodGIBSMun := nodGIBS.ChildNodes.FindNode('gIBSMun');
    if Assigned(nodGIBSMun) then
      FTotal.FvIBSMun_Doc := fValor(GetNodeText(nodGIBSMun, 'vIBSMun'), FTotal.FvIBSMun_Doc);
  end;

  // gCBS fica no mesmo nível de gIBS, não dentro dele
  nodGCBS := nodIBSCBSTot.ChildNodes.FindNode('gCBS');
  if Assigned(nodGCBS) then
    FTotal.FvCBS_Doc := fValor(GetNodeText(nodGCBS, 'vCBS'), FTotal.FvCBS_Doc);
end;

procedure TXMLDoc.ParseInfAdic;
var
  NodeInfAdic: IXMLNode;
begin
  if not Assigned(FNodeInf) then
    Exit;
  NodeInfAdic := FNodeInf.ChildNodes.FindNode('infAdic');
  if Assigned(NodeInfAdic) then
    FInfCpl := GetNodeText(NodeInfAdic, 'infCpl');
end;

function TXMLDoc.ProductCount: Integer;
begin
  Result := FProdutos.Count;
end;

function TXMLDoc.Product(Index: Integer): TXMLNFdet;
begin
  if (Index >= 0) and (Index < FProdutos.Count) then
    Result := FProdutos[Index]
  else
    Result := nil;
end;

procedure TXMLDoc.LerProdutos(Proc: TProcXMLProd);
var
  i: Integer;
begin
  if not Assigned(Proc) then
    Exit;
  for i := 0 to FProdutos.Count - 1 do
    Proc(FProdutos[i]);
end;

function TXMLDoc.Protocolo: string;
begin
  Result := FProt.nProt;
end;

function TXMLDoc.DigestValue: string;
begin
  Result := FProt.digVal;
end;

{ TXMLManager }
constructor TXMLManager.Create(const APathOrFile: string; AIsFolder: Boolean);
begin
  inherited Create;
  FList := TObjectList<TXMLDoc>.Create(True);
  FPathOrFile := APathOrFile;
  FIsFolder := AIsFolder;
  Reload;
end;

destructor TXMLManager.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TXMLManager.CollectFiles(const APath: string);
var
  SR: TSearchRec;
  Dir: string;
begin
  FList.Clear;
  if FIsFolder then
  begin
    if not TDirectory.Exists(APath) then
      Exit;
    Dir := IncludeTrailingPathDelimiter(APath);
    if FindFirst(Dir + '*.xml', faAnyFile, SR) = 0 then
    begin
      try
        repeat
          FList.Add(TXMLDoc.Create(Dir + SR.Name));
        until FindNext(SR) <> 0;
      finally
        FindClose(SR);
      end;
    end;
  end
  else
  begin
    if TFile.Exists(APath) then
      FList.Add(TXMLDoc.Create(APath));
  end;
end;

procedure TXMLManager.Reload;
begin
  CollectFiles(FPathOrFile);
end;

function TXMLManager.Count: Integer;
begin
  Result := FList.Count;
end;

function TXMLManager.Items(Index: Integer): TXMLDoc;
begin
  if (Index >= 0) and (Index < FList.Count) then
    Result := FList[Index]
  else
    Result := nil;
end;

procedure TXMLManager.ForEach(Proc: TProcXMLDoc);
var
  i: Integer;
begin
  if not Assigned(Proc) then
    Exit;
  for i := 0 to FList.Count - 1 do
    Proc(FList[i]);
end;

function fValor(AstrValor: String; AdobPadrao: Double = 0): Double;
var LFS: TFormatSettings;
begin
  if Trim(AstrValor) = '' then
    Exit(AdobPadrao);
  LFS := TFormatSettings.Invariant;
  Result := StrToFloatDef(StringReplace(AstrValor, ',', '.', [rfReplaceAll]), AdobPadrao, LFS);
end;

procedure TXMLDoc.ParseDetItem(
  const ProdNode : IXMLNode;
  const ImpNode  : IXMLNode);
var
  Item           : TXMLNFdet;
  ICMSNode       : IXMLNode;
  PISNode        : IXMLNode;
  COFINSNode     : IXMLNode;
  PISEfetNode    : IXMLNode;
  COFINSEfetNode : IXMLNode;
  RetTribNode    : IXMLNode;
  gMedNode       : IXMLNode;
  gMedidaNode    : IXMLNode;
begin
  Item := TXMLNFdet.Create(Self);

  Item.cProd        := GetNodeText(ProdNode, 'cProd');
  Item.xProd        := GetNodeText(ProdNode, 'xProd');
  Item.cClass       := GetNodeText(ProdNode, 'cClass');
  Item.CFOP         := GetNodeText(ProdNode, 'CFOP');
  Item.uMed         := GetNodeText(ProdNode, 'uMed');
  Item.indOrigemQtd := GetNodeText(ProdNode, 'indOrigemQtd');

  Item.qFaturada :=
    fValor(GetNodeText(ProdNode, 'qFaturada'),
           fValor(GetNodeText(ProdNode, 'qCom'), 0));

  Item.vItem :=
    fValor(GetNodeText(ProdNode, 'vItem'),
           fValor(GetNodeText(ProdNode, 'vUnCom'), 0));

  Item.vProd := fValor(GetNodeText(ProdNode, 'vProd'), 0);

  // gMedicao (NF3e)
  gMedNode := ProdNode.ChildNodes.FindNode('gMedicao');
  if Assigned(gMedNode) then
  begin
    Item.nMed   := GetNodeText(gMedNode, 'nMed');
    gMedidaNode := gMedNode.ChildNodes.FindNode('gMedida');
    if Assigned(gMedidaNode) then
      Item.vMed := fValor(GetNodeText(gMedidaNode, 'vMed'), 0);
  end;

  if Assigned(ImpNode) then
  begin
    ICMSNode := LocalizarGrupoICMS(ImpNode);
    if Assigned(ICMSNode) then
    begin
      Item.CSTICMS := GetNodeText(ICMSNode, 'CST');
      if Item.CFOP = '' then
        Item.CFOP := GetNodeText(ICMSNode, 'CFOP');
      Item.vBC_ICMS := fValor(GetNodeText(ICMSNode, 'vBC'), 0);
      Item.pICMS    := fValor(GetNodeText(ICMSNode, 'pICMS'), 0);
      Item.vICMS    := fValor(GetNodeText(ICMSNode, 'vICMS'), 0);
    end;

    PISNode := ImpNode.ChildNodes.FindNode('PIS');
    if Assigned(PISNode) then
    begin
      Item.CSTPIS  := GetNodeText(PISNode, 'CST');
      Item.vBC_PIS := fValor(GetNodeText(PISNode, 'vBC'), 0);
      Item.pPIS    := fValor(GetNodeText(PISNode, 'pPIS'), 0);
      Item.vPIS    := fValor(GetNodeText(PISNode, 'vPIS'), 0);

      FTotal.FvBC_PIS := FTotal.FvBC_PIS + Item.vBC_PIS;
      if FTotal.FpPIS < Item.pPIS then
        FTotal.FpPIS := Item.pPIS;
    end;

    COFINSNode := ImpNode.ChildNodes.FindNode('COFINS');
    if Assigned(COFINSNode) then
    begin
      Item.CSTCOFINS  := GetNodeText(COFINSNode, 'CST');
      Item.vBC_COFINS := fValor(GetNodeText(COFINSNode, 'vBC'), 0);
      Item.pCOFINS    := fValor(GetNodeText(COFINSNode, 'pCOFINS'), 0);
      Item.vCOFINS    := fValor(GetNodeText(COFINSNode, 'vCOFINS'), 0);

      FTotal.FvBC_COFINS := FTotal.FvBC_COFINS + Item.vBC_COFINS;
      if FTotal.FpCOFINS < Item.pCOFINS then
        FTotal.FpCOFINS := Item.pCOFINS;
    end;

    // PISEfet
    PISEfetNode := ImpNode.ChildNodes.FindNode('PISEfet');
    if Assigned(PISEfetNode) then
    begin
      Item.vBCPISEfet := fValor(GetNodeText(PISEfetNode, 'vBCPISEfet'), 0);
      Item.pPISEfet   := fValor(GetNodeText(PISEfetNode, 'pPISEfet'), 0);
      Item.vPISEfet   := fValor(GetNodeText(PISEfetNode, 'vPISEfet'), 0);
    end;

    // COFINSEfet
    COFINSEfetNode := ImpNode.ChildNodes.FindNode('COFINSEfet');
    if Assigned(COFINSEfetNode) then
    begin
      Item.vBCCOFINSEfet := fValor(GetNodeText(COFINSEfetNode, 'vBCCOFINSEfet'), 0);
      Item.pCOFINSEfet   := fValor(GetNodeText(COFINSEfetNode, 'pCOFINSEfet'), 0);
      Item.vCOFINSEfet   := fValor(GetNodeText(COFINSEfetNode, 'vCOFINSEfet'), 0);
    end;

    // retTrib
    RetTribNode := ImpNode.ChildNodes.FindNode('retTrib');
    if Assigned(RetTribNode) then
    begin
      Item.vRetPIS    := fValor(GetNodeText(RetTribNode, 'vRetPIS'), 0);
      Item.vRetCofins := fValor(GetNodeText(RetTribNode, 'vRetCofins'), 0);
      Item.vRetCSLL   := fValor(GetNodeText(RetTribNode, 'vRetCSLL'), 0);
      Item.vBCIRRF    := fValor(GetNodeText(RetTribNode, 'vBCIRRF'), 0);
      Item.vIRRF      := fValor(GetNodeText(RetTribNode, 'vIRRF'), 0);

      FTotal.FRetPISAcum    := FTotal.FRetPISAcum    + Item.vRetPIS;
      FTotal.FRetCOFINSAcum := FTotal.FRetCOFINSAcum + Item.vRetCofins;
      FTotal.FRetCSLLAcum   := FTotal.FRetCSLLAcum   + Item.vRetCSLL;
      FTotal.FRetIRRFAcum   := FTotal.FRetIRRFAcum   + Item.vIRRF;
    end;

    Item.indSemCST := GetNodeText(ImpNode, 'indSemCST');
  end;
  if Assigned(ImpNode) then
    ParseItemReformaTributaria(Item, ImpNode);
  FProdutos.Add(Item);
end;

procedure TXMLDoc.ParseItemReformaTributaria(AItem: TXMLNFdet; const ImpNode: IXMLNode);
var
  nodIS, nodIBSCBS, nodGIBSCBS, nodGIBSUF, nodGIBSMun, nodGCBS, nodTribReg,
  nodRed: IXMLNode;
begin
  // IS
  nodIS := ImpNode.ChildNodes.FindNode('IS');
  if Assigned(nodIS) then
  begin
    AItem.CSTIS        := GetNodeText(nodIS, 'CST');
    AItem.cClassTribIS := GetNodeText(nodIS, 'cClassTribIS');
    AItem.vBC_IS       := fValor(GetNodeText(nodIS, 'vBCIS'), 0);
    AItem.pIS          := fValor(GetNodeText(nodIS, 'pIS'),   0);
    AItem.vIS          := fValor(GetNodeText(nodIS, 'vIS'),   0);
    FTotal.FvIS_Doc    := FTotal.FvIS_Doc + AItem.vIS;
    FTotal.FvBCIS_Doc  := FTotal.FvBCIS_Doc + AItem.vBC_IS;
  end;

  // IBSCBS
  nodIBSCBS := ImpNode.ChildNodes.FindNode('IBSCBS');
  if not Assigned(nodIBSCBS) then
    Exit;

  AItem.CSTIBSCBS  := GetNodeText(nodIBSCBS, 'CST');
  AItem.cClassTrib := GetNodeText(nodIBSCBS, 'cClassTrib');

  nodGIBSCBS := nodIBSCBS.ChildNodes.FindNode('gIBSCBS');
  if not Assigned(nodGIBSCBS) then
    Exit;

  AItem.vBC_IBSCBS   := fValor(GetNodeText(nodGIBSCBS, 'vBC'), 0);
  FTotal.FvBC_IBSCBS := FTotal.FvBC_IBSCBS + AItem.vBC_IBSCBS;

  // gIBSUF
  nodGIBSUF := nodGIBSCBS.ChildNodes.FindNode('gIBSUF');
  if Assigned(nodGIBSUF) then
  begin
    AItem.pIBSUF         := fValor(GetNodeText(nodGIBSUF, 'pIBSUF'),    0);
    // pAliqEfet fica em gIBSUF/gRed; sem redução, a efetiva é a nominal
    nodRed := nodGIBSUF.ChildNodes.FindNode('gRed');
    if Assigned(nodRed) then
      AItem.pAliqEfetIBSUF := fValor(GetNodeText(nodRed, 'pAliqEfet'), 0)
    else
      AItem.pAliqEfetIBSUF := AItem.pIBSUF;
    AItem.vIBSUF         := fValor(GetNodeText(nodGIBSUF, 'vIBSUF'),    0);
  end;

  // gIBSMun
  nodGIBSMun := nodGIBSCBS.ChildNodes.FindNode('gIBSMun');
  if Assigned(nodGIBSMun) then
  begin
    AItem.pIBSMun         := fValor(GetNodeText(nodGIBSMun, 'pIBSMun'),   0);
    nodRed := nodGIBSMun.ChildNodes.FindNode('gRed');
    if Assigned(nodRed) then
      AItem.pAliqEfetIBSMun := fValor(GetNodeText(nodRed, 'pAliqEfet'), 0)
    else
      AItem.pAliqEfetIBSMun := AItem.pIBSMun;
    AItem.vIBSMun         := fValor(GetNodeText(nodGIBSMun, 'vIBSMun'),   0);
  end;

  // Totalizadores IBS (geral e separados - correcao v2)
  FTotal.FvIBS_Doc     := FTotal.FvIBS_Doc     + AItem.vIBSUF + AItem.vIBSMun;
  FTotal.FvIBSUF_Doc   := FTotal.FvIBSUF_Doc   + AItem.vIBSUF;
  FTotal.FvIBSMun_Doc  := FTotal.FvIBSMun_Doc  + AItem.vIBSMun;

  // gCBS
  nodGCBS := nodGIBSCBS.ChildNodes.FindNode('gCBS');
  if Assigned(nodGCBS) then
  begin
    AItem.pCBS         := fValor(GetNodeText(nodGCBS, 'pCBS'),      0);
    nodRed := nodGCBS.ChildNodes.FindNode('gRed');
    if Assigned(nodRed) then
      AItem.pAliqEfetCBS := fValor(GetNodeText(nodRed, 'pAliqEfet'), 0)
    else
      AItem.pAliqEfetCBS := AItem.pCBS;
    AItem.vCBS         := fValor(GetNodeText(nodGCBS, 'vCBS'),      0);
    FTotal.FvCBS_Doc   := FTotal.FvCBS_Doc + AItem.vCBS;
  end;

  // gTribRegular: procura primeiro em gIBSCBS (leiaute RTC); se não achar, procura em IBSCBS,
  // que é onde o parser da NF-e busca (untEntNfeXml.pas:6139)
  nodTribReg := nodGIBSCBS.ChildNodes.FindNode('gTribRegular');
  if not Assigned(nodTribReg) then
    nodTribReg := nodIBSCBS.ChildNodes.FindNode('gTribRegular');
  if Assigned(nodTribReg) then
  begin
    AItem.CSTReg             := GetNodeText(nodTribReg, 'CSTReg');
    AItem.cClassTribReg      := GetNodeText(nodTribReg, 'cClassTribReg');
    AItem.pAliqEfetRegIBSUF  := fValor(GetNodeText(nodTribReg, 'pAliqEfetRegIBSUF'),  0);
    AItem.vTribRegIBSUF      := fValor(GetNodeText(nodTribReg, 'vTribRegIBSUF'),      0);
    AItem.pAliqEfetRegIBSMun := fValor(GetNodeText(nodTribReg, 'pAliqEfetRegIBSMun'), 0);
    AItem.vTribRegIBSMun     := fValor(GetNodeText(nodTribReg, 'vTribRegIBSMun'),     0);
    AItem.pAliqEfetRegCBS    := fValor(GetNodeText(nodTribReg, 'pAliqEfetRegCBS'),    0);
    AItem.vTribRegCBS        := fValor(GetNodeText(nodTribReg, 'vTribRegCBS'),        0);
  end;
end;

{ TXMLSCEE }

constructor TXMLSCEE.Create(ADoc: TXMLDoc);
begin
  inherited Create;
  FDoc := ADoc;
end;

function TXMLDoc.fInferirTipoValor(const AValor: string): string;
var
  LintAux: Int64;
  LdblAux: Double;
  LdtAux : TDateTime;
  LstrNum: string;
  LFS    : TFormatSettings;
begin
  if Trim(AValor) = '' then
  begin
    Result := 'String';
    Exit;
  end;

  if TryStrToInt64(AValor, LintAux) then
  begin
    Result := 'Integer';
    Exit;
  end;

  LFS := TFormatSettings.Invariant;
  LstrNum := StringReplace(AValor, ',', '.', [rfReplaceAll]);
  if TryStrToFloat(LstrNum, LdblAux, LFS) then
  begin
    Result := 'Double';
    Exit;
  end;

  if (Length(AValor) >= 10) and TryStrToDateTime(Copy(AValor, 1, 19), LdtAux) then
  begin
    Result := 'TDateTime';
    Exit;
  end;

  Result := 'String';
end;

procedure TXMLDoc.pPercorrerNo(ANode: IXMLNode; const APath: string; ALista: TStringList);
var
  i, j       : Integer;
  LNode      : IXMLNode;
  LstrCaminho: string;
  LstrValor  : string;
  LblnGrupo  : Boolean;
begin
  if not Assigned(ANode) then
    Exit;

  for i := 0 to ANode.ChildNodes.Count - 1 do
  begin
    LNode := ANode.ChildNodes[i];

    if LNode.NodeType <> ntElement then
      Continue;

    if APath = '' then
      LstrCaminho := LNode.NodeName
    else
      LstrCaminho := APath + '.' + LNode.NodeName;

    LblnGrupo := False;
    if LNode.HasChildNodes then
      for j := 0 to LNode.ChildNodes.Count - 1 do
        if LNode.ChildNodes[j].NodeType = ntElement then
        begin
          LblnGrupo := True;
          Break;
        end;

    if LblnGrupo then
      pPercorrerNo(LNode, LstrCaminho, ALista)
    else
    begin
      LstrValor := LNode.Text;
      ALista.Add(Format('%s: %s : %s', [
        LstrCaminho,
        fInferirTipoValor(LstrValor),
        LstrValor
      ]));
    end;
  end;
end;

function TXMLDoc.fXMLTexto: String;
var
  LNodeRaiz: IXMLNode;
  LobjLista: TStringList;
begin
  LobjLista := TStringList.Create;
  Try
    LNodeRaiz := FNodeInf;
    if not Assigned(LNodeRaiz) and Assigned(FXMLDoc) and FXMLDoc.Active then
      LNodeRaiz := FXMLDoc.DocumentElement;

    if not Assigned(LNodeRaiz) then
      Exit;

    LobjLista.Add(LNodeRaiz.NodeName);
    pPercorrerNo(LNodeRaiz, '', LobjLista);
  Finally
    Result := LobjLista.Text;
    LobjLista.Free;
  End;
end;

function fAliqEfetiva(AcurValor, AcurBase: Currency): Currency;
begin
  if AcurBase <= 0 then
    Exit(0);
  Result := RoundTo(AcurValor / AcurBase * 100, -4);
end;

function TXMLTotal.AliqEfetIBSUF_Doc: Currency;
begin
  Result := fAliqEfetiva(FvIBSUF_Doc, FvBC_IBSCBS);
end;

function TXMLTotal.AliqEfetIBSMun_Doc: Currency;
begin
  Result := fAliqEfetiva(FvIBSMun_Doc, FvBC_IBSCBS);
end;

function TXMLTotal.AliqEfetCBS_Doc: Currency;
begin
  Result := fAliqEfetiva(FvCBS_Doc, FvBC_IBSCBS);
end;


end.

