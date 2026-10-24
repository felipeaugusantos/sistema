unit ImportacaoDados.Model.CadastroProspecto;

interface

Uses
  ImportacaoDados.Interfaces, ImportacaoDados.Model.ModeloArquivo,
  Classes, SysUtils, cxProgressBar, System.Generics.Collections, DB, Uni, Variants;

Type

  IProspecto = Interface ['{358DDB31-7734-44F2-BA45-E2313A7AC1CA}']
    function strAutInc(const AValue: String): IProspecto;
    function strCodPro(const AValue: String): IProspecto;
    function strNomPro(const AValue: String): IProspecto;
    function strTipPro(const AValue: String): IProspecto;
    function strCPFCGC(const AValue: String): IProspecto;
    function strEndere(const AValue: String): IProspecto;
    function strNumEnd(const AValue: String): IProspecto;
    function strCodCid(const AValue: String): IProspecto;
    function strNomCid(const AValue: String): IProspecto;
    function strCodVen(const AValue: String): IProspecto;
    function strNomVen(const AValue: String): IProspecto;
    function strCodAti(const AValue: String): IProspecto;
    function strDesAti(const AValue: String): IProspecto;
    function strStatus(const AValue: String): IProspecto;
    function strFone01(const AValue: String): IProspecto;
    function strFone02(const AValue: String): IProspecto;
    function strEmail1(const AValue: String): IProspecto;
    function strEmail2(const AValue: String): IProspecto;
    function strEmail3(const AValue: String): IProspecto;
    function strBairro(const AValue: String): IProspecto;
    function strComple(const AValue: String): IProspecto;
    function strNumCep(const AValue: String): IProspecto;
    function strEstado(const AValue: String): IProspecto;
    function strContat(const AValue: String): IProspecto;
    function strEndCom(const AValue: String): IProspecto;
    function strNomFan(const AValue: String): IProspecto;
    function strNumFax(const AValue: String): IProspecto;
    function strNumPag(const AValue: String): IProspecto;
    function strInsEst(const AValue: String): IProspecto;
    function dtaDatNas(const AValue: TDateTime): IProspecto;
    function dtaDatCad(const AValue: TDateTime): IProspecto;
    function StrDtaNas(const AValue: String): IProspecto;
    function strIdNext(const AValue: String): IProspecto;
    function strNum_Rg(const AValue: String): IProspecto;
    function strObserv(const AValue: String): IProspecto;
    function strNRgExp(const AValue: String): IProspecto;
    function strCodRed(const AValue: String): IProspecto;
    function strDesRed(const AValue: String): IProspecto;
    function strCrmFai(const AValue: String): IProspecto;
    function strDesFai(const AValue: String): IProspecto;
    function strCrmFre(const AValue: String): IProspecto;
    function strDesFre(const AValue: String): IProspecto;
    function strCrmPor(const AValue: String): IProspecto;
    function strDesPor(const AValue: String): IProspecto;
    function strCrmCat(const AValue: String): IProspecto;
    function strDesCat(const AValue: String): IProspecto;
    function strCaiPos(const AValue: String): IProspecto;
    function strCodCrr(const AValue: String): IProspecto;
    function strCrmFor(const AValue: String): IProspecto;
    function strDesFor(const AValue: String): IProspecto;
    function strUFExRg(const AValue: String): IProspecto;
    function strCelula(const AValue: String): IProspecto;
    function strHomePg(const AValue: String): IProspecto;
    function strStaPro(const AValue: String): IProspecto;
    function strCodRep(const AValue: String): IProspecto;
    function strNomRep(const AValue: String): IProspecto;
    function strCodReg(const AValue: String): IProspecto;
    function strDesReg(const AValue: String): IProspecto;

    function GetAutInc: String;
    function GetBairro: String;
    function GetCelula: String;
    function GetCodAti: String;
    function GetCodCid: String;
    function GetCodCrr: String;
    function GetCodPro: String;
    function GetCodRed: String;
    function GetCodVen: String;
    function GetComple: String;
    function GetContat: String;
    function GetCPFCGC: String;
    function GetCrmCat: String;
    function GetCrmFai: String;
    function GetCrmFor: String;
    function GetCrmFre: String;
    function GetCrmPor: String;
    function GetDatNas: TDateTime;
    function GetDesAti: String;
    function GetDesCat: String;
    function GetDesFai: String;
    function GetDesFor: String;
    function GetDesFre: String;
    function GetDesPor: String;
    function GetDesRed: String;
    function GetEmail1: String;
    function GetEmail2: String;
    function GetEmail3: String;
    function GetEndCom: String;
    function GetEndere: String;
    function GetEstado: String;
    function GetFone01: String;
    function GetFone02: String;
    function GetIdNext: String;
    function GetInsEst: String;
    function GetNomCid: String;
    function GetNomFan: String;
    function GetNomPro: String;
    function GetNomVen: String;
    function GetNRgExp: String;
    function GetNum_Rg: String;
    function GetNumCep: String;
    function GetNumEnd: String;
    function GetNumFax: String;
    function GetNumPag: String;
    function GetObserv: String;
    function GetStatus: String;
    function GetStrDatNas: String;
    function GetTipPro: String;
    function GetUFExRg: String;
    function GetCaiPos: String;
    function GetStaPro: String;
    function GetCodRep: String;
    function GetNomRep: String;
    function GetCodReg: String;
    function GetDesReg: String;

    procedure SetAutInc(const AValue: String);
    procedure SetBairro(const AValue: String);
    procedure SetCaiPos(const AValue: String);
    procedure SetCelula(const AValue: String);
    procedure SetCodAti(const AValue: String);
    procedure SetCodCid(const AValue: String);
    procedure SetCodCrr(const AValue: String);
    procedure SetCodPro(const AValue: String);
    procedure SetCodRed(const AValue: String);
    procedure SetCodVen(const AValue: String);
    procedure SetComple(const AValue: String);
    procedure SetContat(const AValue: String);
    procedure SetCPFCGC(const AValue: String);
    procedure SetCrmCat(const AValue: String);
    procedure SetCrmFai(const AValue: String);
    procedure SetCrmFor(const AValue: String);
    procedure SetCrmFre(const AValue: String);
    procedure SetCrmPor(const AValue: String);
    procedure SetDatNas(const AValue: TDateTime);
    procedure SetDesAti(const AValue: String);
    procedure SetDesCat(const AValue: String);
    procedure SetDesFai(const AValue: String);
    procedure SetDesFor(const AValue: String);
    procedure SetDesFre(const AValue: String);
    procedure SetDesPor(const AValue: String);
    procedure SetDesRed(const AValue: String);
    procedure SetEmail1(const AValue: String);
    procedure SetEmail2(const AValue: String);
    procedure SetEmail3(const AValue: String);
    procedure SetEndCom(const AValue: String);
    procedure SetEndere(const AValue: String);
    procedure SetEstado(const AValue: String);
    procedure SetFone01(const AValue: String);
    procedure SetFone02(const AValue: String);
    procedure SetIdNext(const AValue: String);
    procedure SetInsEst(const AValue: String);
    procedure SetNomCid(const AValue: String);
    procedure SetNomFan(const AValue: String);
    procedure SetNomPro(const AValue: String);
    procedure SetNomVen(const AValue: String);
    procedure SetNRgExp(const AValue: String);
    procedure SetNum_Rg(const AValue: String);
    procedure SetNumCep(const AValue: String);
    procedure SetNumEnd(const AValue: String);
    procedure SetNumFax(const AValue: String);
    procedure SetNumPag(const AValue: String);
    procedure SetObserv(const AValue: String);
    procedure SetStatus(const AValue: String);
    procedure SetStrDatNas(const AValue: String);
    procedure SetTipPro(const AValue: String);
    procedure SetUFExRg(const AValue: String);
    procedure SetStaPro(const AValue: String);
    procedure SetCodRep(const AValue: String);
    procedure SetNomRep(const AValue: String);
    procedure SetCodReg(const AValue: String);
    procedure SetDesReg(const AValue: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property CodPro: String read GetCodPro write SetCodPro;
    property NomPro: String read GetNomPro write SetNomPro;
    property TipPro: String read GetTipPro write SetTipPro;
    property CPFCGC: String read GetCPFCGC write SetCPFCGC;
    property Endere: String read GetEndere write SetEndere;
    property NumEnd: String read GetNumEnd write SetNumEnd;
    property CodCid: String read GetCodCid write SetCodCid;
    property NomCid: String read GetNomCid write SetNomCid;
    property CodVen: String read GetCodVen write SetCodVen;
    property NomVen: String read GetNomVen write SetNomVen;
    property CodAti: String read GetCodAti write SetCodAti;
    property DesAti: String read GetDesAti write SetDesAti;
    property Status: String read GetStatus write SetStatus;
    property Fone01: String read GetFone01 write SetFone01;
    property Fone02: String read GetFone02 write SetFone02;
    property Email1: String read GetEmail1 write SetEmail1;
    property Email2: String read GetEmail2 write SetEmail2;
    property Email3: String read GetEmail3 write SetEmail3;
    property Bairro: String read GetBairro write SetBairro;
    property Comple: String read GetComple write SetComple;
    property NumCep: String read GetNumCep write SetNumCep;
    property Estado: String read GetEstado write SetEstado;
    property Contat: String read GetContat write SetContat;
    property EndCom: String read GetEndCom write SetEndCom;
    property NomFan: String read GetNomFan write SetNomFan;
    property NumFax: String read GetNumFax write SetNumFax;
    property NumPag: String read GetNumPag write SetNumPag;
    property InsEst: String read GetInsEst write SetInsEst;
    property DatNas: TDateTime read GetDatNas write SetDatNas;
    property IdNext: String read GetIdNext write SetIdNext;
    property Num_Rg: String read GetNum_Rg write SetNum_Rg;
    property Observ: String read GetObserv write SetObserv;
    property NRgExp: String read GetNRgExp write SetNRgExp;
    property CodRed: String read GetCodRed write SetCodRed;
    property DesRed: String read GetDesRed write SetDesRed;
    property CrmFai: String read GetCrmFai write SetCrmFai;
    property DesFai: String read GetDesFai write SetDesFai;
    property CrmFre: String read GetCrmFre write SetCrmFre;
    property DesFre: String read GetDesFre write SetDesFre;
    property CrmPor: String read GetCrmPor write SetCrmPor;
    property DesPor: String read GetDesPor write SetDesPor;
    property CrmCat: String read GetCrmCat write SetCrmCat;
    property DesCat: String read GetDesCat write SetDesCat;
    property CaiPos: String read GetCaiPos write SetCaiPos;
    property StrDatNas: String read GetStrDatNas write SetStrDatNas;
    property CodCorreio: String read GetCodCrr write SetCodCrr;
    property CrmFor: String read GetCrmFor write SetCrmFor;
    property DesFor: String read GetDesFor write SetDesFor;
    property UFExRg: String read GetUFExRg write SetUFExRg;
    property Celular: String read GetCelula write SetCelula;
    property StaPro: String read GetStaPro write SetStaPro;
    property CodRep: String read GetCodRep write SetCodRep;
    property NomRep: String read GetNomRep write SetNomRep;
    property CodReg: String read GetCodReg write SetCodReg;
    property DesReg: String read GetDesReg write SetDesReg;
  End;

  TProspecto = class(TInterfacedObject, IProspecto)
  private
    FAutInc: String;
    FCodPro: String;
    FNomPro: String;
    FTipPro: String;
    FCPFCGC: String;
    FEndere: String;
    FNumEnd: String;
    FCodCid: String;
    FNomCid: String;
    FCodVen: String;
    FNomVen: String;
    FCodAti: String;
    FDesAti: String;
    FStatus: String;
    FFone01: String;
    FFone02: String;
    FEmail1: String;
    FEmail2: String;
    FEmail3: String;
    FBairro: String;
    FComple: String;
    FNumCep: String;
    FEstado: String;
    FContat: String;
    FEndCom: String;
    FNomFan: String;
    FNumFax: String;
    FNumPag: String;
    FInsEst: String;
    FDatNas: TDateTime;
    FStrDatNas: String;
    FIdNext: String;
    FNum_Rg: String;
    FObserv: String;
    FNRgExp: String;
    FCodRed: String;
    FDesRed: String;
    FCrmFai: String;
    FDesFai: String;
    FCrmFre: String;
    FDesFre: String;
    FCrmPor: String;
    FDesPor: String;
    FCrmCat: String;
    FDesCat: String;
    FCaiPos: String;
    FCodCrr: String;
    FCrmFor: String;
    FDesFor: String;
    FUFExRg: String;
    FCelula: String;
    FDatCad: TDateTime;
    FHomePg: String;
    FStaPro: String;
    FCodRep: String;
    FNomRep: String;
    FCodReg: String;
    FDesReg: String;

    function GetAutInc: String;
    function GetBairro: String;
    function GetCelula: String;
    function GetCodAti: String;
    function GetCodCid: String;
    function GetCodCrr: String;
    function GetCodPro: String;
    function GetCodRed: String;
    function GetCodVen: String;
    function GetComple: String;
    function GetContat: String;
    function GetCPFCGC: String;
    function GetCrmCat: String;
    function GetCrmFai: String;
    function GetCrmFor: String;
    function GetCrmFre: String;
    function GetCrmPor: String;
    function GetDatNas: TDateTime;
    function GetDesAti: String;
    function GetDesCat: String;
    function GetDesFai: String;
    function GetDesFor: String;
    function GetDesFre: String;
    function GetDesPor: String;
    function GetDesRed: String;
    function GetEmail1: String;
    function GetEmail2: String;
    function GetEmail3: String;
    function GetEndCom: String;
    function GetEndere: String;
    function GetEstado: String;
    function GetFone01: String;
    function GetFone02: String;
    function GetIdNext: String;
    function GetInsEst: String;
    function GetNomCid: String;
    function GetNomFan: String;
    function GetNomPro: String;
    function GetNomVen: String;
    function GetNRgExp: String;
    function GetNum_Rg: String;
    function GetNumCep: String;
    function GetNumEnd: String;
    function GetNumFax: String;
    function GetNumPag: String;
    function GetObserv: String;
    function GetStatus: String;
    function GetStrDatNas: String;
    function GetTipPro: String;
    function GetUFExRg: String;
    function GetCaiPos: String;
    procedure SetAutInc(const AValue: String);
    procedure SetBairro(const AValue: String);
    procedure SetCaiPos(const AValue: String);
    procedure SetCelula(const AValue: String);
    procedure SetCodAti(const AValue: String);
    procedure SetCodCid(const AValue: String);
    procedure SetCodCrr(const AValue: String);
    procedure SetCodPro(const AValue: String);
    procedure SetCodRed(const AValue: String);
    procedure SetCodVen(const AValue: String);
    procedure SetComple(const AValue: String);
    procedure SetContat(const AValue: String);
    procedure SetCPFCGC(const AValue: String);
    procedure SetCrmCat(const AValue: String);
    procedure SetCrmFai(const AValue: String);
    procedure SetCrmFor(const AValue: String);
    procedure SetCrmFre(const AValue: String);
    procedure SetCrmPor(const AValue: String);
    procedure SetDatNas(const AValue: TDateTime);
    procedure SetDesAti(const AValue: String);
    procedure SetDesCat(const AValue: String);
    procedure SetDesFai(const AValue: String);
    procedure SetDesFor(const AValue: String);
    procedure SetDesFre(const AValue: String);
    procedure SetDesPor(const AValue: String);
    procedure SetDesRed(const AValue: String);
    procedure SetEmail1(const AValue: String);
    procedure SetEmail2(const AValue: String);
    procedure SetEmail3(const AValue: String);
    procedure SetEndCom(const AValue: String);
    procedure SetEndere(const AValue: String);
    procedure SetEstado(const AValue: String);
    procedure SetFone01(const AValue: String);
    procedure SetFone02(const AValue: String);
    procedure SetIdNext(const AValue: String);
    procedure SetInsEst(const AValue: String);
    procedure SetNomCid(const AValue: String);
    procedure SetNomFan(const AValue: String);
    procedure SetNomPro(const AValue: String);
    procedure SetNomVen(const AValue: String);
    procedure SetNRgExp(const AValue: String);
    procedure SetNum_Rg(const AValue: String);
    procedure SetNumCep(const AValue: String);
    procedure SetNumEnd(const AValue: String);
    procedure SetNumFax(const AValue: String);
    procedure SetNumPag(const AValue: String);
    procedure SetObserv(const AValue: String);
    procedure SetStatus(const AValue: String);
    procedure SetStrDatNas(const AValue: String);
    procedure SetTipPro(const AValue: String);
    procedure SetUFExRg(const AValue: String);
    function GetHomePg: String;
    procedure SetHomePg(const AValue: String);
    procedure SetStaPro(const AValue: String);
    function GetStaPro: String;
    function GetCodRep: String;
    procedure SetCodRep(const AValue: String);
    function GetNomRep: String;
    procedure SetNomRep(const AValue: String);

    function GetCodReg: String;
    procedure SetCodReg(const AValue: String);
    function GetDesReg: String;
    procedure SetDesReg(const AValue: String);

  public
    constructor Create;
    destructor Destroy; override;

    class function fNew: IProspecto;

    function strAutInc(const AValue: String): IProspecto;
    function strCodPro(const AValue: String): IProspecto;
    function strNomPro(const AValue: String): IProspecto;
    function strTipPro(const AValue: String): IProspecto;
    function strCPFCGC(const AValue: String): IProspecto;
    function strEndere(const AValue: String): IProspecto;
    function strNumEnd(const AValue: String): IProspecto;
    function strCodCid(const AValue: String): IProspecto;
    function strNomCid(const AValue: String): IProspecto;
    function strCodVen(const AValue: String): IProspecto;
    function strNomVen(const AValue: String): IProspecto;
    function strCodAti(const AValue: String): IProspecto;
    function strDesAti(const AValue: String): IProspecto;
    function strStatus(const AValue: String): IProspecto;
    function strFone01(const AValue: String): IProspecto;
    function strFone02(const AValue: String): IProspecto;
    function strEmail1(const AValue: String): IProspecto;
    function strEmail2(const AValue: String): IProspecto;
    function strEmail3(const AValue: String): IProspecto;
    function strBairro(const AValue: String): IProspecto;
    function strComple(const AValue: String): IProspecto;
    function strNumCep(const AValue: String): IProspecto;
    function strEstado(const AValue: String): IProspecto;
    function strContat(const AValue: String): IProspecto;
    function strEndCom(const AValue: String): IProspecto;
    function strNomFan(const AValue: String): IProspecto;
    function strNumFax(const AValue: String): IProspecto;
    function strNumPag(const AValue: String): IProspecto;
    function strInsEst(const AValue: String): IProspecto;
    function dtaDatNas(const AValue: TDateTime): IProspecto;
    function dtaDatCad(const AValue: TDateTime): IProspecto;
    function StrDtaNas(const AValue: String): IProspecto;
    function strIdNext(const AValue: String): IProspecto;
    function strNum_Rg(const AValue: String): IProspecto;
    function strObserv(const AValue: String): IProspecto;
    function strNRgExp(const AValue: String): IProspecto;
    function strCodRed(const AValue: String): IProspecto;
    function strDesRed(const AValue: String): IProspecto;
    function strCrmFai(const AValue: String): IProspecto;
    function strDesFai(const AValue: String): IProspecto;
    function strCrmFre(const AValue: String): IProspecto;
    function strDesFre(const AValue: String): IProspecto;
    function strCrmPor(const AValue: String): IProspecto;
    function strDesPor(const AValue: String): IProspecto;
    function strCrmCat(const AValue: String): IProspecto;
    function strDesCat(const AValue: String): IProspecto;
    function strCaiPos(const AValue: String): IProspecto;
    function strCodCrr(const AValue: String): IProspecto;
    function strCrmFor(const AValue: String): IProspecto;
    function strDesFor(const AValue: String): IProspecto;
    function strUFExRg(const AValue: String): IProspecto;
    function strCelula(const AValue: String): IProspecto;
    function strHomePg(const AValue: String): IProspecto;
    function strStaPro(const AValue: String): IProspecto;
    function strCodRep(const AValue: String): IProspecto;
    function strNomRep(const AValue: String): IProspecto;
    function strCodReg(const AValue: String): IProspecto;
    function strDesReg(const AValue: String): IProspecto;

    property AutInc: String read GetAutInc write SetAutInc;
    property CodPro: String read GetCodPro write SetCodPro;
    property NomPro: String read GetNomPro write SetNomPro;
    property TipPro: String read GetTipPro write SetTipPro;
    property CPFCGC: String read GetCPFCGC write SetCPFCGC;
    property Endere: String read GetEndere write SetEndere;
    property NumEnd: String read GetNumEnd write SetNumEnd;
    property CodCid: String read GetCodCid write SetCodCid;
    property NomCid: String read GetNomCid write SetNomCid;
    property CodVen: String read GetCodVen write SetCodVen;
    property NomVen: String read GetNomVen write SetNomVen;
    property CodAti: String read GetCodAti write SetCodAti;
    property DesAti: String read GetDesAti write SetDesAti;
    property Status: String read GetStatus write SetStatus;
    property Fone01: String read GetFone01 write SetFone01;
    property Fone02: String read GetFone02 write SetFone02;
    property Email1: String read GetEmail1 write SetEmail1;
    property Email2: String read GetEmail2 write SetEmail2;
    property Email3: String read GetEmail3 write SetEmail3;
    property Bairro: String read GetBairro write SetBairro;
    property Comple: String read GetComple write SetComple;
    property NumCep: String read GetNumCep write SetNumCep;
    property Estado: String read GetEstado write SetEstado;
    property Contat: String read GetContat write SetContat;
    property EndCom: String read GetEndCom write SetEndCom;
    property NomFan: String read GetNomFan write SetNomFan;
    property NumFax: String read GetNumFax write SetNumFax;
    property NumPag: String read GetNumPag write SetNumPag;
    property InsEst: String read GetInsEst write SetInsEst;
    property DatNas: TDateTime read GetDatNas write SetDatNas;
    property IdNext: String read GetIdNext write SetIdNext;
    property Num_Rg: String read GetNum_Rg write SetNum_Rg;
    property Observ: String read GetObserv write SetObserv;
    property NRgExp: String read GetNRgExp write SetNRgExp;
    property CodRed: String read GetCodRed write SetCodRed;
    property DesRed: String read GetDesRed write SetDesRed;
    property CrmFai: String read GetCrmFai write SetCrmFai;
    property DesFai: String read GetDesFai write SetDesFai;
    property CrmFre: String read GetCrmFre write SetCrmFre;
    property DesFre: String read GetDesFre write SetDesFre;
    property CrmPor: String read GetCrmPor write SetCrmPor;
    property DesPor: String read GetDesPor write SetDesPor;
    property CrmCat: String read GetCrmCat write SetCrmCat;
    property DesCat: String read GetDesCat write SetDesCat;
    property CaiPos: String read GetCaiPos write SetCaiPos;
    property StrDatNas: String read GetStrDatNas write SetStrDatNas;
    property CodCorreio: String read GetCodCrr write SetCodCrr;
    property CrmFor: String read GetCrmFor write SetCrmFor;
    property DesFor: String read GetDesFor write SetDesFor;
    property UFExRg: String read GetUFExRg write SetUFExRg;
    property Celular: String read GetCelula write SetCelula;
    property HomePg: String read GetHomePg write SetHomePg;
    property StaPro: String read GetStaPro write SetStaPro;
    property CodRep: String read GetCodRep write SetCodRep;
    property NomRep: String read GetNomRep write SetNomRep;
    property CodReg: String read GetCodReg write SetCodReg;
    property DesReg: String read GetDesReg write SetDesReg;
  End;

  TModeloImportacaoProspecto = class(TModeloArquivoImportacao)
  private
    FCamposPadrao: TList<TCampoPlanilha>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function fCarregarCamposPadrao: Boolean; override;
    function fCarregarCampos: Boolean; override;
    procedure pDefineCamposPadrao; override;
  End;

implementation

uses
  untFuncoesSimples, untCadCid, untFuncoesGenerica, StrUtils;


{ TProspecto }

constructor TProspecto.Create;
begin
  FStatus := 'A';

  inherited;
end;

destructor TProspecto.Destroy;
begin
  inherited;
end;

function TProspecto.dtaDatCad(const AValue: TDateTime): IProspecto;
begin
  FDatCad := AValue;
  Result := Self;
end;

function TProspecto.dtaDatNas(const AValue: TDateTime): IProspecto;
begin
  FDatNas := AValue;
  Result := Self;
end;

class function TProspecto.fNew: IProspecto;
begin
  Result := TProspecto.Create;
end;

function TProspecto.GetAutInc: String;
begin
  Result := FAutInc;
end;

function TProspecto.GetBairro: String;
begin
  Result := FBairro;
end;

function TProspecto.GetCaiPos: String;
begin
  Result := FCaiPos;
end;

function TProspecto.GetCelula: String;
begin
  Result := FCelula;
end;

function TProspecto.GetCodAti: String;
begin
  Result := FCodAti;
end;

function TProspecto.GetCodCid: String;
begin
  Result := FCodCid;
end;

function TProspecto.GetCodCrr: String;
begin
  Result := FCodCrr;
end;

function TProspecto.GetCodPro: String;
begin
  Result := FCodPro;
end;

function TProspecto.GetCodRed: String;
begin
  Result := FCodRed;
end;

function TProspecto.GetCodReg: String;
begin
  Result := FCodReg;
end;

function TProspecto.GetCodRep: String;
begin
  Result := FCodRep;
end;

function TProspecto.GetCodVen: String;
begin
  Result := FCodVen;
end;

function TProspecto.GetComple: String;
begin
  Result := FComple;
end;

function TProspecto.GetContat: String;
begin
  Result := FContat;
end;

function TProspecto.GetCPFCGC: String;
begin
  Result := FCPFCGC;
end;

function TProspecto.GetCrmCat: String;
begin
  Result := FCrmCat;
end;

function TProspecto.GetCrmFai: String;
begin
  Result := FCrmFai;
end;

function TProspecto.GetCrmFor: String;
begin
  Result := FCrmFor;
end;

function TProspecto.GetCrmFre: String;
begin
  Result := FCrmFre;
end;

function TProspecto.GetCrmPor: String;
begin
  Result := FCrmPor;
end;

function TProspecto.GetDatNas: TDateTime;
begin
  Result := FDatNas;
end;

function TProspecto.GetDesAti: String;
begin
  Result := FDesAti;
end;

function TProspecto.GetDesCat: String;
begin
  Result := FDesCat;
end;

function TProspecto.GetDesFai: String;
begin
  Result := FDesFai;
end;

function TProspecto.GetDesFor: String;
begin
  Result := FDesFor;
end;

function TProspecto.GetDesFre: String;
begin
  Result := FDesFre;
end;

function TProspecto.GetDesPor: String;
begin
  Result := FDesPor;
end;

function TProspecto.GetDesRed: String;
begin
  Result := FDesRed;
end;

function TProspecto.GetDesReg: String;
begin
  Result := FDesReg;
end;

function TProspecto.GetEmail1: String;
begin
  Result := FEmail1;
end;

function TProspecto.GetEmail2: String;
begin
  Result := FEmail2;
end;

function TProspecto.GetEmail3: String;
begin
  Result := FEmail3;
end;

function TProspecto.GetEndCom: String;
begin
  Result := FEndCom;
end;

function TProspecto.GetEndere: String;
begin
  Result := FEndere;
end;

function TProspecto.GetEstado: String;
begin
  Result := FEstado;
end;

function TProspecto.GetFone01: String;
begin
  Result := FFone01;
end;

function TProspecto.GetFone02: String;
begin
  Result := FFone02;
end;

function TProspecto.GetHomePg: String;
begin
  Result := FHomePg;
end;

function TProspecto.GetIdNext: String;
begin
  Result := FIdNext;
end;

function TProspecto.GetInsEst: String;
begin
  Result := FInsEst;
end;

function TProspecto.GetNomCid: String;
begin
  Result := FNomCid;
end;

function TProspecto.GetNomFan: String;
begin
  Result := FNomFan;
end;

function TProspecto.GetNomPro: String;
begin
  Result := FNomPro;
end;

function TProspecto.GetNomRep: String;
begin
  Result := FNomRep;
end;

function TProspecto.GetNomVen: String;
begin
  Result := FNomVen;
end;

function TProspecto.GetNRgExp: String;
begin
  Result := FNRgExp;
end;

function TProspecto.GetNumCep: String;
begin
  Result := FNumCep;
end;

function TProspecto.GetNumEnd: String;
begin
  Result := FNumEnd;
end;

function TProspecto.GetNumFax: String;
begin
  Result := FNumFax;
end;

function TProspecto.GetNumPag: String;
begin
  Result := FNumPag;
end;

function TProspecto.GetNum_Rg: String;
begin
  Result := FNum_Rg;
end;

function TProspecto.GetObserv: String;
begin
  Result := FObserv;
end;

function TProspecto.GetStaPro: String;
begin
  Result := FStaPro;
end;

function TProspecto.GetStatus: String;
begin
  Result := FStatus;
end;

function TProspecto.GetStrDatNas: String;
begin
  Result := FStrDatNas;
end;

function TProspecto.GetTipPro: String;
begin
  Result := FTipPro;
end;

function TProspecto.GetUFExRg: String;
begin
  Result := FUFExRg;
end;

procedure TProspecto.SetAutInc(const AValue: String);
begin
  FAutInc := AValue;
end;

procedure TProspecto.SetBairro(const AValue: String);
begin
  FBairro := AValue;
end;

procedure TProspecto.SetCaiPos(const AValue: String);
begin
  FCaiPos := AValue;
end;

procedure TProspecto.SetCelula(const AValue: String);
begin
  FCelula := AValue;
end;

procedure TProspecto.SetCodAti(const AValue: String);
begin
  FCodAti := AValue;
end;

procedure TProspecto.SetCodCid(const AValue: String);
begin
  FCodCid := AValue;
end;

procedure TProspecto.SetCodCrr(const AValue: String);
begin
  FCodCrr := AValue;
end;

procedure TProspecto.SetCodPro(const AValue: String);
begin
  FCodPro := AValue;
end;

procedure TProspecto.SetCodRed(const AValue: String);
begin
  FCodRed := AValue;
end;

procedure TProspecto.SetCodReg(const AValue: String);
begin
  FCodReg := AValue;
end;

procedure TProspecto.SetCodRep(const AValue: String);
begin
  FCodRep := AValue;
end;

procedure TProspecto.SetCodVen(const AValue: String);
begin
  FCodVen := AValue;
end;

procedure TProspecto.SetComple(const AValue: String);
begin
  FComple := AValue;
end;

procedure TProspecto.SetContat(const AValue: String);
begin
  FContat := AValue;
end;

procedure TProspecto.SetCPFCGC(const AValue: String);
begin
  FCPFCGC := AValue;
end;

procedure TProspecto.SetCrmCat(const AValue: String);
begin
  FCrmCat := AValue;
end;

procedure TProspecto.SetCrmFai(const AValue: String);
begin
  FCrmFai := AValue;
end;

procedure TProspecto.SetCrmFor(const AValue: String);
begin
  FCrmFor := AValue;
end;

procedure TProspecto.SetCrmFre(const AValue: String);
begin
  FCrmFre := AValue;
end;

procedure TProspecto.SetCrmPor(const AValue: String);
begin
  FCrmPor := AValue;
end;

procedure TProspecto.SetDatNas(const AValue: TDateTime);
begin
  FDatNas := AValue;
end;

procedure TProspecto.SetDesAti(const AValue: String);
begin
  FDesAti := AValue;
end;

procedure TProspecto.SetDesCat(const AValue: String);
begin
  FDesCat := AValue;
end;

procedure TProspecto.SetDesFai(const AValue: String);
begin
  FDesFai := AValue;
end;

procedure TProspecto.SetDesFor(const AValue: String);
begin
  FDesFor := AValue;
end;

procedure TProspecto.SetDesFre(const AValue: String);
begin
  FDesFre := AValue;
end;

procedure TProspecto.SetDesPor(const AValue: String);
begin
  FDesPor := AValue;
end;

procedure TProspecto.SetDesRed(const AValue: String);
begin
  FDesRed := AValue;
end;

procedure TProspecto.SetDesReg(const AValue: String);
begin
  FDesReg := AValue;
end;

procedure TProspecto.SetEmail1(const AValue: String);
begin
  FEmail1 := AValue;
end;

procedure TProspecto.SetEmail2(const AValue: String);
begin
  FEmail2 := AValue;
end;

procedure TProspecto.SetEmail3(const AValue: String);
begin
  FEmail3 := AValue;
end;

procedure TProspecto.SetEndCom(const AValue: String);
begin
  FEndCom := AValue;
end;

procedure TProspecto.SetEndere(const AValue: String);
begin
  FEndere := AValue;
end;

procedure TProspecto.SetEstado(const AValue: String);
begin
  FEstado := AValue;
end;

procedure TProspecto.SetFone01(const AValue: String);
begin
  FFone01 := AValue;
end;

procedure TProspecto.SetFone02(const AValue: String);
begin
  FFone02 := AValue;
end;

procedure TProspecto.SetHomePg(const AValue: String);
begin
  FHomePg := AValue;
end;

procedure TProspecto.SetIdNext(const AValue: String);
begin
  FIdNext := AValue;
end;

procedure TProspecto.SetInsEst(const AValue: String);
begin
  FInsEst := AValue;
end;

procedure TProspecto.SetNomCid(const AValue: String);
begin
  FNomCid := AValue;
end;

procedure TProspecto.SetNomFan(const AValue: String);
begin
  FNomFan := AValue;
end;

procedure TProspecto.SetNomPro(const AValue: String);
begin
  FNomPro := AValue;
end;

procedure TProspecto.SetNomRep(const AValue: String);
begin
  FNomRep := AValue;
end;

procedure TProspecto.SetNomVen(const AValue: String);
begin
  FNomVen := AValue;
end;

procedure TProspecto.SetNRgExp(const AValue: String);
begin
  FNRgExp := AValue;
end;

procedure TProspecto.SetNumCep(const AValue: String);
begin
  FNumCep := AValue;
end;

procedure TProspecto.SetNumEnd(const AValue: String);
begin
  FNumEnd := AValue;
end;

procedure TProspecto.SetNumFax(const AValue: String);
begin
  FNumFax := AValue;
end;

procedure TProspecto.SetNumPag(const AValue: String);
begin
  FNumPag := AValue;
end;

procedure TProspecto.SetNum_Rg(const AValue: String);
begin
  FNum_Rg := AValue;
end;

procedure TProspecto.SetObserv(const AValue: String);
begin
  FObserv := AValue;
end;

procedure TProspecto.SetStaPro(const AValue: String);
begin
  FStaPro := AValue;
end;

procedure TProspecto.SetStatus(const AValue: String);
begin
  FStatus := AValue;
end;

procedure TProspecto.SetStrDatNas(const AValue: String);
begin
  FStrDatNas := AValue;
end;

procedure TProspecto.SetTipPro(const AValue: String);
begin
  FTipPro := AValue;
end;

procedure TProspecto.SetUFExRg(const AValue: String);
begin
  FUFExRg := AValue;
end;

function TProspecto.strAutInc(const AValue: String): IProspecto;
begin
  FAutInc := AValue;
  Result := Self;
end;

function TProspecto.strBairro(const AValue: String): IProspecto;
begin
  FBairro := AValue;
  Result := Self;
end;

function TProspecto.strCaiPos(const AValue: String): IProspecto;
begin
  FCaiPos := AValue;
  Result := Self;
end;

function TProspecto.strCelula(const AValue: String): IProspecto;
begin
  FCelula := AValue;
  Result := Self;
end;

function TProspecto.strCodAti(const AValue: String): IProspecto;
begin
  FCodAti := AValue;
  Result := Self;
end;

function TProspecto.strCodCid(const AValue: String): IProspecto;
begin
  FCodCid := AValue;
  Result := Self;
end;

function TProspecto.strCodCrr(const AValue: String): IProspecto;
begin
  FCodCrr := AValue;
  Result := Self;
end;

function TProspecto.strCodPro(const AValue: String): IProspecto;
begin
  FCodPro := AValue;
  Result := Self;
end;

function TProspecto.strCodRed(const AValue: String): IProspecto;
begin
  FCodRed := AValue;
  Result := Self;
end;

function TProspecto.strCodReg(const AValue: String): IProspecto;
begin
  FCodReg := AValue;
  Result := Self;
end;

function TProspecto.strCodRep(const AValue: String): IProspecto;
begin
  FCodRep := AValue;
  Result := Self;
end;

function TProspecto.strCodVen(const AValue: String): IProspecto;
begin
  FCodVen := AValue;
  Result := Self;
end;

function TProspecto.strComple(const AValue: String): IProspecto;
begin
  FComple := AValue;
  Result := Self;
end;

function TProspecto.strContat(const AValue: String): IProspecto;
begin
  FContat := AValue;
  Result := Self;
end;

function TProspecto.strCPFCGC(const AValue: String): IProspecto;
begin
  FCPFCGC := AValue;
  Result := Self;
end;

function TProspecto.strCrmCat(const AValue: String): IProspecto;
begin
  FCrmCat := AValue;
  Result := Self;
end;

function TProspecto.strCrmFai(const AValue: String): IProspecto;
begin
  FCrmFai := AValue;
  Result := Self;
end;

function TProspecto.strCrmFor(const AValue: String): IProspecto;
begin
  FCrmFor := AValue;
  Result := Self;
end;

function TProspecto.strCrmFre(const AValue: String): IProspecto;
begin
  FCrmFre := AValue;
  Result := Self;
end;

function TProspecto.strCrmPor(const AValue: String): IProspecto;
begin
  FCrmPor := AValue;
  Result := Self;
end;

function TProspecto.StrDtaNas(const AValue: String): IProspecto;
begin
  FstrDatNas := AValue;
  Result := Self;
end;

function TProspecto.strDesAti(const AValue: String): IProspecto;
begin
  FDesAti := AValue;
  Result := Self;
end;

function TProspecto.strDesCat(const AValue: String): IProspecto;
begin
  FDesCat := AValue;
  Result := Self;
end;

function TProspecto.strDesFai(const AValue: String): IProspecto;
begin
  FDesFai := AValue;
  Result := Self;
end;

function TProspecto.strDesFor(const AValue: String): IProspecto;
begin
  FDesFor := AValue;
  Result := Self;
end;

function TProspecto.strDesFre(const AValue: String): IProspecto;
begin
  FDesFre := AValue;
  Result := Self;
end;

function TProspecto.strDesPor(const AValue: String): IProspecto;
begin
  FDesPor := AValue;
  Result := Self;
end;

function TProspecto.strDesRed(const AValue: String): IProspecto;
begin
  FDesRed := AValue;
  Result := Self;
end;

function TProspecto.strDesReg(const AValue: String): IProspecto;
begin
  FDesReg := AValue;
  Result := Self;
end;

function TProspecto.strEmail1(const AValue: String): IProspecto;
begin
  FEmail1 := AValue;
  Result := Self;
end;

function TProspecto.strEmail2(const AValue: String): IProspecto;
begin
  FEmail2 := AValue;
  Result := Self;
end;

function TProspecto.strEmail3(const AValue: String): IProspecto;
begin
  FEmail3 := AValue;
  Result := Self;
end;

function TProspecto.strEndCom(const AValue: String): IProspecto;
begin
  FEndCom := AValue;
  Result := Self;
end;

function TProspecto.strEndere(const AValue: String): IProspecto;
begin
  FEndere := AValue;
  Result := Self;
end;

function TProspecto.strEstado(const AValue: String): IProspecto;
begin
  FEstado := AValue;
  Result := Self;
end;

function TProspecto.strFone01(const AValue: String): IProspecto;
begin
  FFone01 := AValue;
  Result := Self;
end;

function TProspecto.strFone02(const AValue: String): IProspecto;
begin
  FFone02 := AValue;
  Result := Self;
end;

function TProspecto.strHomePg(const AValue: String): IProspecto;
begin
  FHomePg := AValue;
  Result := Self;
end;

function TProspecto.strIdNext(const AValue: String): IProspecto;
begin
  FIdNext := AValue;
  Result := Self;
end;

function TProspecto.strInsEst(const AValue: String): IProspecto;
begin
  FInsEst := AValue;
  Result := Self;
end;

function TProspecto.strNomCid(const AValue: String): IProspecto;
begin
  FNomCid := AValue;
  Result := Self;
end;

function TProspecto.strNomFan(const AValue: String): IProspecto;
begin
  FNomFan := AValue;
  Result := Self;
end;

function TProspecto.strNomPro(const AValue: String): IProspecto;
begin
  FNomPro := AValue;
  Result := Self;
end;

function TProspecto.strNomRep(const AValue: String): IProspecto;
begin
  FNomRep := AValue;
  Result := Self;
end;

function TProspecto.strNomVen(const AValue: String): IProspecto;
begin
  FNomVen:= AValue;
  Result := Self;
end;

function TProspecto.strNRgExp(const AValue: String): IProspecto;
begin
  FNRgExp := AValue;
  Result := Self;
end;

function TProspecto.strNumCep(const AValue: String): IProspecto;
begin
  FNumCep := AValue;
  Result := Self;
end;

function TProspecto.strNumEnd(const AValue: String): IProspecto;
begin
  FNumEnd := AValue;
  Result := Self;
end;

function TProspecto.strNumFax(const AValue: String): IProspecto;
begin
  FNumFax := AValue;
  Result := Self;
end;

function TProspecto.strNumPag(const AValue: String): IProspecto;
begin
  FNumPag := AValue;
  Result := Self;
end;

function TProspecto.strNum_Rg(const AValue: String): IProspecto;
begin
  FNum_Rg := AValue;
  Result := Self;
end;

function TProspecto.strObserv(const AValue: String): IProspecto;
begin
  FObserv := AValue;
  Result := Self;
end;

function TProspecto.strStaPro(const AValue: String): IProspecto;
begin
  FStaPro := AValue;
  Result := Self;
end;

function TProspecto.strStatus(const AValue: String): IProspecto;
begin
  FStatus := AValue;
  Result := Self;
end;

function TProspecto.strTipPro(const AValue: String): IProspecto;
begin
  FTipPro := AValue;
  Result := Self;
end;

function TProspecto.strUFExRg(const AValue: String): IProspecto;
begin
  FUFExRg := AValue;
  Result := Self;
end;

{ TModeloImportacaoProspecto }

constructor TModeloImportacaoProspecto.Create;
begin
  inherited;

  FCamposPadrao := TList<TCampoPlanilha>.Create;
  pDefineCamposPadrao;
end;

destructor TModeloImportacaoProspecto.Destroy;
begin
  inherited;

  FreeAndNil(FCamposPadrao);
end;

function TModeloImportacaoProspecto.fCarregarCampos: Boolean;
Begin
  Result := False;

  inherited;
End;

function TModeloImportacaoProspecto.fCarregarCamposPadrao: Boolean;
var
  aCampo: ICamposModeloArquivo;
  intCnt: Integer;
begin
  inherited;

  pLimparCampos;
  Try
    For intCnt := 0 to FCamposPadrao.Count-1 Do
    Begin
      aCampo := Self.AddCampo;
      aCampo.NomeCampo   := FCamposPadrao[intCnt].NomeCampo;
      aCampo.Descricao   := FCamposPadrao[intCnt].DescricaoCampo;
      aCampo.Coluna      := FCamposPadrao[intCnt].Coluna;
      aCampo.Obrigatorio := FCamposPadrao[intCnt].Obrigatorio;
      aCampo.TipoCampo   := FCamposPadrao[intCnt].TipoCampo;
      aCampo.Tamanho     := FCamposPadrao[intCnt].Tamanho;
      aCampo.Posicao     := intCnt;
    End;
    Result := True;
  Except
    Result := False;
  End;

end;

procedure TModeloImportacaoProspecto.pDefineCamposPadrao;
begin
  pLimparCampos;
  FCamposPadrao.Clear;

  FCamposPadrao.Add(fAdicionarCampo(cstNomCli, 'Nome',                 'A',  'S', ftString, 60));
  FCamposPadrao.Add(fAdicionarCampo(cst_C_G_C, 'CPF/CNPJ',             'B',  'N', ftString, 18));
  FCamposPadrao.Add(fAdicionarCampo(cstCodCid, 'Cód.Cidade',           'C',  'S', ftString, 5));
  FCamposPadrao.Add(fAdicionarCampo(cstNomCid, 'Cidade',               'D',  'N', ftString, 40));
  FCamposPadrao.Add(fAdicionarCampo(cstfone01, 'Telefone',             'E',  'S', ftString, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstEMail1, 'E-mail 1',             'F',  'S', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstEmail3, 'E-mail Nf-e',          'G',  'S', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstCodAti, 'Cód.Atividade',        'H',  'S', ftString, 3));
  FCamposPadrao.Add(fAdicionarCampo(cstDesAti, 'Desc. Atividade',      'I',  'N', ftString, 70));
  FCamposPadrao.Add(fAdicionarCampo(cstCodVen, 'Cód.Vendedor',         'J',  'S', ftString, 3));
  FCamposPadrao.Add(fAdicionarCampo(cstNomVen, 'Nome Vendedor',        'K',  'N', ftString, 30));
  FCamposPadrao.Add(fAdicionarCampo(cstStatus, 'Situação',             'L',  'N', ftString, 1));
  FCamposPadrao.Add(fAdicionarCampo(cstCGCCPF, 'Tipo (1-CNPJ;2-CPF)',  'M',  'N', ftInteger, 1));
  FCamposPadrao.Add(fAdicionarCampo(cstContat, 'Contato',              'N',  'N', ftString, 25));
  FCamposPadrao.Add(fAdicionarCampo(cstProCep, 'CEP',                  'O',  'N', ftString, 9));
  FCamposPadrao.Add(fAdicionarCampo(cstEndere, 'Endereço',             'P',  'N', ftString, 60));
  FCamposPadrao.Add(fAdicionarCampo(cstBairro, 'Bairro',               'Q',  'N', ftString, 60));
  FCamposPadrao.Add(fAdicionarCampo(cstEndNum, 'N° Endereço',          'R',  'N', ftString, 10));
  FCamposPadrao.Add(fAdicionarCampo(cstEndCom, 'Complemento',          'S',  'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstFanSob, 'Fantasia/Sobrenome',   'T',  'N', ftString, 60));
  FCamposPadrao.Add(fAdicionarCampo(cstFone02, 'Telefone 2',           'U',  'N', ftString, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstEmail2, 'E-mail Nf-e 2',        'V',  'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstNumFax, 'Fax',                  'X',  'N', ftString, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstCaiPos, 'Caixa Postal',         'W',  'N', ftString, 5));
  FCamposPadrao.Add(fAdicionarCampo(cstHomPag, 'Homepage',             'Y',  'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstInsEst, 'Inscrição Estadual',   'Z',  'N', ftString, 18));
  FCamposPadrao.Add(fAdicionarCampo(cstDatNsc, 'Data Nascimento',      'AA', 'N', ftString, 10));
  FCamposPadrao.Add(fAdicionarCampo(cstNextel, 'Id. Nextel',           'AB', 'N', ftString, 20));
  FCamposPadrao.Add(fAdicionarCampo(cstNumeRg, 'RG',                   'AC', 'N', ftString, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstNRgExp, 'Expedição RG',         'AD', 'N', ftString, 9));
  FCamposPadrao.Add(fAdicionarCampo(cstCodRed, 'Cód. Rede de Lojas',   'AE', 'N', ftString, 5));
  FCamposPadrao.Add(fAdicionarCampo(cstDesRed, 'Rede de Lojas',        'AF', 'N', ftString, 40));
  FCamposPadrao.Add(fAdicionarCampo(cstCrmFai, 'Cód. Faixa Fat. Est.', 'AG', 'N', ftString, 6));
  FCamposPadrao.Add(fAdicionarCampo(cstDesFai, 'Faixa Fat. Estimado',  'AH', 'N', ftString, 70));
  FCamposPadrao.Add(fAdicionarCampo(cstCrmFre, 'Cód. Frequência',      'AI', 'N', ftString, 6));
  FCamposPadrao.Add(fAdicionarCampo(cstDesFre, 'Frequência',           'AJ', 'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstCrmPor, 'Cód. Porte',           'AK', 'N', ftString, 6));
  FCamposPadrao.Add(fAdicionarCampo(cstDesPor, 'Porte',                'AL', 'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstCrmCat, 'Cód. Categoria',       'AM', 'N', ftString, 6));
  FCamposPadrao.Add(fAdicionarCampo(cstDesCat, 'Categoria',            'AN', 'N', ftString, 50));
  FCamposPadrao.Add(fAdicionarCampo(cstObserv, 'Observação',           'AO', 'N', ftString, -1));
  FCamposPadrao.Add(fAdicionarCampo(cstUFExRg, 'Uf Expedição RG',      'AP', 'N', ftString, 2));
  FCamposPadrao.Add(fAdicionarCampo(cstCrmFor, 'Cód. Fornecedor',      'AQ', 'N', ftString, 6));
  FCamposPadrao.Add(fAdicionarCampo(cstDesFor, 'Fornecedor',           'AR', 'N', ftString, 70));
  FCamposPadrao.Add(fAdicionarCampo(cstCelula, 'Celular',              'AS', 'N', ftString, 15));
  FCamposPadrao.Add(fAdicionarCampo(cstCodRep, 'Cód.Representante',    'AT', 'N', ftString, 03));
  FCamposPadrao.Add(fAdicionarCampo(cstNomRep, 'Nome Representante',   'AU', 'N', ftString, 30));
  FCamposPadrao.Add(fAdicionarCampo(cstCodReg, 'Cód.Região',           'AV', 'N', ftString, 05));
  FCamposPadrao.Add(fAdicionarCampo(cstDesReg, 'Descrição Região',     'AW', 'N', ftString, 40));
end;



end.


