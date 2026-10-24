unit untAltGlobalPromocoesClass;

interface

uses SysUtils, Classes, untBaseClass, untAltGlobalPromocoesIntf;

type
  TAltGlobalPromocoes = Class(TBaseClass, IAltGlobalPromocoes)
  private
    FblnPerDes: Boolean;
    FfltComInt: Double;
    FtpTipPro: TTipoPromocao;
    FblnComInt: Boolean;
    FdtaValIni: TDateTime;
    FfltComDis: Double;
    FstrDesIni: String;
    FfltComLoj: Double;
    FblnComDis: Boolean;
    FstrCodUni: String;
    FfltPreCus: Double;
    FblnComLoj: Boolean;
    FblnPreCus: Boolean;
    FtaTipAlt: TTipoAlteracao;
    FstrCodFor: String;
    FstrCodMar: String;
    FstrRefere: String;
    FdtaValFim: TDateTime;
    FstrDesFim: String;
    FstrCodIte: String;
    FfltPreVen: Double;
    FstrLinGru: String;
    FblnPreVen: Boolean;
    FstrCodPro: String;
    FfltPerDes: Double;
    FstrTabPre: String;
  protected
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
  public
  published
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

uses untFactoryClass;

{ TAltGlobalPromocoes }

function TAltGlobalPromocoes.GetblnComDis: Boolean;
begin
  Result := FblnComDis;
end;

function TAltGlobalPromocoes.GetblnComInt: Boolean;
begin
  Result := FblnComInt;
end;

function TAltGlobalPromocoes.GetblnComLoj: Boolean;
begin
  Result := FblnComLoj;
end;

function TAltGlobalPromocoes.GetblnPerDes: Boolean;
begin
  Result := FblnPerDes;
end;

function TAltGlobalPromocoes.GetblnPreCus: Boolean;
begin
  Result := FblnPreCus;
end;

function TAltGlobalPromocoes.GetblnPreVen: Boolean;
begin
  Result := FblnPreVen;
end;

function TAltGlobalPromocoes.GetdtaValFim: TDateTime;
begin
  Result := FdtaValFim;
end;

function TAltGlobalPromocoes.GetdtaValIni: TDateTime;
begin
  Result := FdtaValIni;
end;

function TAltGlobalPromocoes.GetfltComDis: Double;
begin
  Result := FfltComDis;
end;

function TAltGlobalPromocoes.GetfltComInt: Double;
begin
  Result := FfltComInt;
end;

function TAltGlobalPromocoes.GetfltComLoj: Double;
begin
  Result := FfltComLoj;
end;

function TAltGlobalPromocoes.GetfltPerDes: Double;
begin
  Result := FfltPerDes;
end;

function TAltGlobalPromocoes.GetfltPreCus: Double;
begin
  Result := FfltPreCus;
end;

function TAltGlobalPromocoes.GetfltPreVen: Double;
begin
  Result := FfltPreVen;
end;

function TAltGlobalPromocoes.GetstrCodFor: String;
begin
  Result := FstrCodFor;
end;

function TAltGlobalPromocoes.GetstrCodIte: String;
begin
  Result := FstrCodIte;
end;

function TAltGlobalPromocoes.GetstrCodMar: String;
begin
  Result := FstrCodMar;
end;

function TAltGlobalPromocoes.GetstrCodPro: String;
begin
  Result := FstrCodPro;
end;

function TAltGlobalPromocoes.GetstrCodUni: String;
begin
  Result := FstrCodUni;
end;

function TAltGlobalPromocoes.GetstrDesFim: String;
begin
  Result := FstrDesFim;
end;

function TAltGlobalPromocoes.GetstrDesIni: String;
begin
  Result := FstrDesIni;
end;

function TAltGlobalPromocoes.GetstrLinGru: String;
begin
  Result := FstrLinGru;
end;

function TAltGlobalPromocoes.GetstrRefere: String;
begin
  Result := FstrRefere;
end;

function TAltGlobalPromocoes.GetstrTabPre: String;
begin
  Result := FstrTabPre;
end;

function TAltGlobalPromocoes.GettaTipAlt: TTipoAlteracao;
begin
  Result := FtaTipAlt;
end;

function TAltGlobalPromocoes.GettpTipPro: TTipoPromocao;
begin
  Result := FtpTipPro;
end;

procedure TAltGlobalPromocoes.SetblnComDis(const Value: Boolean);
begin
  FblnComDis := Value;
end;

procedure TAltGlobalPromocoes.SetblnComInt(const Value: Boolean);
begin
  FblnComInt := Value;
end;

procedure TAltGlobalPromocoes.SetblnComLoj(const Value: Boolean);
begin
  FblnComLoj := Value;
end;

procedure TAltGlobalPromocoes.SetblnPerDes(const Value: Boolean);
begin
  FblnPerDes := Value;
end;

procedure TAltGlobalPromocoes.SetblnPreCus(const Value: Boolean);
begin
  FblnPreCus := Value;
end;

procedure TAltGlobalPromocoes.SetblnPreVen(const Value: Boolean);
begin
  FblnPreVen := Value;
end;

procedure TAltGlobalPromocoes.SetdtaValFim(const Value: TDateTime);
begin
  FdtaValFim := Value;
end;

procedure TAltGlobalPromocoes.SetdtaValIni(const Value: TDateTime);
begin
  FdtaValIni := Value;
end;

procedure TAltGlobalPromocoes.SetfltComDis(const Value: Double);
begin
  FfltComDis := Value;
end;

procedure TAltGlobalPromocoes.SetfltComInt(const Value: Double);
begin
  FfltComInt := Value;
end;

procedure TAltGlobalPromocoes.SetfltComLoj(const Value: Double);
begin
  FfltComLoj := Value;
end;

procedure TAltGlobalPromocoes.SetfltPerDes(const Value: Double);
begin
  FfltPerDes := Value;
end;

procedure TAltGlobalPromocoes.SetfltPreCus(const Value: Double);
begin
  FfltPreCus := Value;
end;

procedure TAltGlobalPromocoes.SetfltPreVen(const Value: Double);
begin
  FfltPreVen := Value;
end;

procedure TAltGlobalPromocoes.SetstrCodFor(const Value: String);
begin
  FstrCodFor := Value;
end;

procedure TAltGlobalPromocoes.SetstrCodIte(const Value: String);
begin
  FstrCodIte := Value;
end;

procedure TAltGlobalPromocoes.SetstrCodMar(const Value: String);
begin
  FstrCodMar := Value;
end;

procedure TAltGlobalPromocoes.SetstrCodPro(const Value: String);
begin
  FstrCodPro := Value;
end;

procedure TAltGlobalPromocoes.SetstrCodUni(const Value: String);
begin
  FstrCodUni := Value;
end;

procedure TAltGlobalPromocoes.SetstrDesFim(const Value: String);
begin
  FstrDesFim := Value;
end;

procedure TAltGlobalPromocoes.SetstrDesIni(const Value: String);
begin
  FstrDesIni := Value;
end;

procedure TAltGlobalPromocoes.SetstrLinGru(const Value: String);
begin
  FstrLinGru := Value;
end;

procedure TAltGlobalPromocoes.SetstrRefere(const Value: String);
begin
  FstrRefere := Value;
end;

procedure TAltGlobalPromocoes.SetstrTabPre(const Value: String);
begin
  FstrTabPre := Value;
end;

procedure TAltGlobalPromocoes.SettaTipAlt(const Value: TTipoAlteracao);
begin
  FtaTipAlt := Value;
end;

procedure TAltGlobalPromocoes.SettpTipPro(const Value: TTipoPromocao);
begin
  FtpTipPro := Value;
end;

initialization
  Factory.RegisterClass(TAltGlobalPromocoes, 'AltGlobalPromocoes');

end.
