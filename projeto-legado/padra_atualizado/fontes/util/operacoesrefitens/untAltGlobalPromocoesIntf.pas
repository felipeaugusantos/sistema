unit untAltGlobalPromocoesIntf;

interface

uses untBaseIntf;

type
  TTipoPromocao  = (tpPreco, tpPerDesconto);
  TTipoAlteracao = (taFator, taValor);

type
  IAltGlobalPromocoes = interface(IBaseIntf)
    ['{576CB768-AA03-4F53-AB2C-BF25E954437C}']
    function GetblnComDis: Boolean;
    function GetblnComInt: Boolean;
    function GetblnComLoj: Boolean;
    function GetblnPerDes: Boolean;
    function GetblnPreCus: Boolean;
    function GetblnPreVen: Boolean;
    function GetdtaValFim: TDateTime;
    function GetdtaValIni: TDateTime;
    function GetfltComDis: Double;
    function GetfltComInt: Double;
    function GetfltComLoj: Double;
    function GetfltPerDes: Double;
    function GetfltPreCus: Double;
    function GetfltPreVen: Double;
    function GetstrCodFor: String;
    function GetstrCodIte: String;
    function GetstrCodMar: String;
    function GetstrCodPro: String;
    function GetstrCodUni: String;
    function GetstrDesFim: String;
    function GetstrDesIni: String;
    function GetstrLinGru: String;
    function GetstrRefere: String;
    function GettaTipAlt: TTipoAlteracao;
    function GettpTipPro: TTipoPromocao;
    procedure SetblnComDis(const Value: Boolean);
    procedure SetblnComInt(const Value: Boolean);
    procedure SetblnComLoj(const Value: Boolean);
    procedure SetblnPerDes(const Value: Boolean);
    procedure SetblnPreCus(const Value: Boolean);
    procedure SetblnPreVen(const Value: Boolean);
    procedure SetdtaValFim(const Value: TDateTime);
    procedure SetdtaValIni(const Value: TDateTime);
    procedure SetfltComDis(const Value: Double);
    procedure SetfltComInt(const Value: Double);
    procedure SetfltComLoj(const Value: Double);
    procedure SetfltPerDes(const Value: Double);
    procedure SetfltPreCus(const Value: Double);
    procedure SetfltPreVen(const Value: Double);
    procedure SetstrCodFor(const Value: String);
    procedure SetstrCodIte(const Value: String);
    procedure SetstrCodMar(const Value: String);
    procedure SetstrCodPro(const Value: String);
    procedure SetstrCodUni(const Value: String);
    procedure SetstrDesFim(const Value: String);
    procedure SetstrDesIni(const Value: String);
    procedure SetstrLinGru(const Value: String);
    procedure SetstrRefere(const Value: String);
    procedure SettaTipAlt(const Value: TTipoAlteracao);
    procedure SettpTipPro(const Value: TTipoPromocao);
    function GetstrTabPre: String;
    procedure SetstrTabPre(const Value: String);
    property strCodPro: String         Read GetstrCodPro Write SetstrCodPro;
    property tpTipPro : TTipoPromocao  Read GettpTipPro  Write SettpTipPro;
    property dtaValIni: TDateTime      Read GetdtaValIni Write SetdtaValIni;
    property dtaValFim: TDateTime      Read GetdtaValFim Write SetdtaValFim;
    property strLinGru: String         Read GetstrLinGru Write SetstrLinGru;
    property strCodIte: String         Read GetstrCodIte Write SetstrCodIte;
    property strCodMar: String         Read GetstrCodMar Write SetstrCodMar;
    property strCodFor: String         Read GetstrCodFor Write SetstrCodFor;
    property strDesIni: String         Read GetstrDesIni Write SetstrDesIni;
    property strDesFim: String         Read GetstrDesFim Write SetstrDesFim;
    property strRefere: String         Read GetstrRefere Write SetstrRefere;
    property strCodUni: String         Read GetstrCodUni Write SetstrCodUni;
    property taTipAlt : TTipoAlteracao Read GettaTipAlt  Write SettaTipAlt;
    property blnPreCus: Boolean        Read GetblnPreCus Write SetblnPreCus;
    property blnPreVen: Boolean        Read GetblnPreVen Write SetblnPreVen;
    property blnPerDes: Boolean        Read GetblnPerDes Write SetblnPerDes;
    property blnComInt: Boolean        Read GetblnComInt Write SetblnComInt;
    property blnComLoj: Boolean        Read GetblnComLoj Write SetblnComLoj;
    property blnComDis: Boolean        Read GetblnComDis Write SetblnComDis;
    property fltPreCus: Double         Read GetfltPreCus Write SetfltPreCus;
    property fltPreVen: Double         Read GetfltPreVen Write SetfltPreVen;
    property fltPerDes: Double         Read GetfltPerDes Write SetfltPerDes;
    property fltComInt: Double         Read GetfltComInt Write SetfltComInt;
    property fltComLoj: Double         Read GetfltComLoj Write SetfltComLoj;
    property fltComDis: Double         Read GetfltComDis Write SetfltComDis;
    property strTabPre: String         Read GetstrTabPre Write SetstrTabPre;
  end;

implementation

end.
