unit untImpressaoDelLamaClass;

interface

uses SysUtils, Classes, untBaseClass,untImpressaoDelLamaIntf;

Type
  TImpressaoDelLamaClass = Class(TBaseClass, IImpressaoDelLamaIntf)
  private
    FstrNumDoc: String;
    FdtaDtaDoc: TDateTime;
    FstrNomCli: String;
    FstrConCli: String;
    FstrCpfCgc: String;
    FstrRg_Ie_: String;
    FstrEndCli: String;
    FstrBaiCli: String;
    FstrCidCli: String;
    FstrCepCli: String;
    FstrFonCli: String;
    FstrFaxCli: String;
    FstrCodEmp: String;
    FstrEspDoc: String;
    FdtaDtaPro: TDateTime;
    FfltTotFre: Double;
    FstrCodFpg: String;
    FstrCodCnd: String;
    FdtaDtaPre: TDateTime;
    FstrEndEnt: String;
    FstrMen001: String;
    FstrMen002: String;
    FstrDesImp: String;
    FstrNomFil: String;
    FstrNomPro: String;
    FblnEntFut: Boolean;
    FstrMenDoc: String;
    function GetstrCodCnd: String;
    procedure SetstrCodCnd(const Value: String);
  protected
    function GetdtaDtaDoc: TDateTime;
    function GetstrBaiCli: String;
    function GetstrCepCli: String;
    function GetstrCpfCgc: String;
    function GetstrCidCli: String;
    function GetstrConCli: String;
    function GetstrEndCli: String;
    function GetstrFaxCli: String;
    function GetstrFonCli: String;
    function GetstrNomCli: String;
    function GetstrNumDoc: String;
    function GetstrRg_Ie_: String;
    procedure SetdtaDtaDoc(const Value: TDateTime);
    procedure SetstrBaiCli(const Value: String);
    procedure SetstrCepCli(const Value: String);
    procedure SetstrCpfCgc(const Value: String);
    procedure SetstrCidCli(const Value: String);
    procedure SetstrConCli(const Value: String);
    procedure SetstrEndCli(const Value: String);
    procedure SetstrFaxCli(const Value: String);
    procedure SetstrFonCli(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrRg_Ie_(const Value: String);
    function GetstrCodEmp: String;
    procedure SetstrCodEmp(const Value: String);
    function GetdtaDtaPre: TDateTime;
    function GetdtaDtaPro: TDateTime;
    function GetfltTotFre: Double;
    function GetstrCodFpg: String;
    function GetstrEndEnt: String;
    function GetstrMen001: String;
    function GetstrMen002: String;
    procedure SetdtaDtaPre(const Value: TDateTime);
    procedure SetdtaDtaPro(const Value: TDateTime);
    procedure SetfltTotFre(const Value: Double);
    procedure SetstrCodFpg(const Value: String);
    procedure SetstrEndEnt(const Value: String);
    procedure SetstrMen001(const Value: String);
    procedure SetstrMen002(const Value: String);
    function GetstrEspDoc: String;
    procedure SetstrEspDoc(const Value: String);
    function GetstrDesImp: String;
    function GetstrNomFil: String;
    procedure SetstrDesImp(const Value: String);
    procedure SetstrNomFil(const Value: String);
    function GetstrNomPro: String;
    procedure SetstrNomPro(const Value: String);
    function GetblnEntFut: Boolean;
    procedure SetblnEntFut(const Value: Boolean);
    function GetstrMenDoc: String;
    procedure SetstrMenDoc(const Value: String);
  public
  published
    property strNumDoc: String    read GetstrNumDoc Write SetstrNumDoc;
    property dtaDtaDoc: TDateTime read GetdtaDtaDoc Write SetdtaDtaDoc;
    property strNomCli: String    read GetstrNomCli Write SetstrNomCli;
    property strConCli: String    read GetstrConCli Write SetstrConCli;
    property strCpfCgc: String    read GetstrCpfCgc Write SetstrCpfCgc;
    property strRg_Ie_: String    read GetstrRg_Ie_ Write SetstrRg_Ie_;
    property strEndCli: String    read GetstrEndCli Write SetstrEndCli;
    property strBaiCli: String    read GetstrBaiCli Write SetstrBaiCli;
    property strCidCli: String    read GetstrCidCli Write SetstrCidCli;
    property strCepCli: String    read GetstrCepCli Write SetstrCepCli;
    property strFonCli: String    read GetstrFonCli Write SetstrFonCli;
    property strFaxCli: String    read GetstrFaxCli Write SetstrFaxCli;
    property strCodEmp: String    read GetstrCodEmp Write SetstrCodEmp;
    property dtaDtaPro: TDateTime read GetdtaDtaPro Write SetdtaDtaPro;
    property fltTotFre: Double    read GetfltTotFre Write SetfltTotFre;
    property strCodFpg: String    read GetstrCodFpg Write SetstrCodFpg;
    property strDesFpg: String    read GetstrCodCnd Write SetstrCodCnd;
    property dtaDtaPre: TDateTime read GetdtaDtaPre Write SetdtaDtaPre;
    property strEndEnt: String    read GetstrEndEnt Write SetstrEndEnt;
    property strMen001: String    read GetstrMen001 Write SetstrMen001;
    property strMen002: String    read GetstrMen002 Write SetstrMen002;
    property strEspDoc: String    read GetstrEspDoc Write SetstrEspDoc;
    property strDesImp: String    read GetstrDesImp Write SetstrDesImp;
    property strNomFil: String    read GetstrNomFil Write SetstrNomFil;
    property strNomPro: String    read GetstrNomPro Write SetstrNomPro;
    property blnEntFut: Boolean   read GetblnEntFut Write SetblnEntFut;
    property strMenDoc: String    read GetstrMenDoc Write SetstrMenDoc;
  End;

implementation

uses untFactoryClass;

{ TImpressaoDelLamaClass }

function TImpressaoDelLamaClass.GetblnEntFut: Boolean;
begin
  Result := FblnEntFut;
end;

function TImpressaoDelLamaClass.GetdtaDtaDoc: TDateTime;
begin
  Result := FdtaDtaDoc;
end;

function TImpressaoDelLamaClass.GetdtaDtaPre: TDateTime;
begin
  Result := FdtaDtaPre;
end;

function TImpressaoDelLamaClass.GetdtaDtaPro: TDateTime;
begin
  Result := FdtaDtaPro;
end;

function TImpressaoDelLamaClass.GetfltTotFre: Double;
begin
  Result := FfltTotFre;
end;

function TImpressaoDelLamaClass.GetstrBaiCli: String;
begin
  Result := FstrBaiCli;
end;

function TImpressaoDelLamaClass.GetstrCepCli: String;
begin
  Result := FstrCepCli;
end;

function TImpressaoDelLamaClass.GetstrCpfCgc: String;
begin
  Result := FstrCpfCgc;
end;

function TImpressaoDelLamaClass.GetstrCodCnd: String;
begin
  Result := FstrCodCnd;
end;

function TImpressaoDelLamaClass.GetstrDesImp: String;
begin
  Result := FstrDesImp;
end;

function TImpressaoDelLamaClass.GetstrCidCli: String;
begin
  Result := FstrCidCli;
end;

function TImpressaoDelLamaClass.GetstrCodEmp: String;
begin
  Result := FstrCodEmp;
end;

function TImpressaoDelLamaClass.GetstrCodFpg: String;
begin
  Result := FstrCodFpg;
end;

function TImpressaoDelLamaClass.GetstrConCli: String;
begin
  Result := FstrConCli;
end;

function TImpressaoDelLamaClass.GetstrEndCli: String;
begin
  Result := FstrEndCli;
end;

function TImpressaoDelLamaClass.GetstrEndEnt: String;
begin
  Result := FstrEndEnt;
end;

function TImpressaoDelLamaClass.GetstrEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TImpressaoDelLamaClass.GetstrFaxCli: String;
begin
  Result := FstrFaxCli;
end;

function TImpressaoDelLamaClass.GetstrFonCli: String;
begin
  Result := FstrFonCli;
end;

function TImpressaoDelLamaClass.GetstrNomCli: String;
begin
  Result := FstrNomCli;
end;

function TImpressaoDelLamaClass.GetstrNomFil: String;
begin
  Result := FstrNomFil;
end;

function TImpressaoDelLamaClass.GetstrNomPro: String;
begin
  Result := FstrNomPro;
end;

function TImpressaoDelLamaClass.GetstrNumDoc: String;
begin
  Result := FstrNumDoc;
end;

function TImpressaoDelLamaClass.GetstrMen001: String;
begin
  Result := FstrMen001;
end;

function TImpressaoDelLamaClass.GetstrMen002: String;
begin
  Result := FstrMen002;
end;

function TImpressaoDelLamaClass.GetstrMenDoc: String;
begin
  Result := FstrMenDoc;
end;

function TImpressaoDelLamaClass.GetstrRg_Ie_: String;
begin
  Result := FstrRg_Ie_;
end;

procedure TImpressaoDelLamaClass.SetblnEntFut(const Value: Boolean);
begin
  FblnEntFut := Value;
end;

procedure TImpressaoDelLamaClass.SetdtaDtaDoc(const Value: TDateTime);
begin
  FdtaDtaDoc := Value;
end;

procedure TImpressaoDelLamaClass.SetdtaDtaPre(const Value: TDateTime);
begin
  FdtaDtaPre := Value;
end;

procedure TImpressaoDelLamaClass.SetdtaDtaPro(const Value: TDateTime);
begin
  FdtaDtaPro := Value;
end;

procedure TImpressaoDelLamaClass.SetfltTotFre(const Value: Double);
begin
  FfltTotFre := Value;
end;

procedure TImpressaoDelLamaClass.SetstrBaiCli(const Value: String);
begin
  FstrBaiCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCepCli(const Value: String);
begin
  FstrCepCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCpfCgc(const Value: String);
begin
  FstrCpfCgc := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCodCnd(const Value: String);
begin
  FstrCodCnd := Value;
end;

procedure TImpressaoDelLamaClass.SetstrDesImp(const Value: String);
begin
  FstrDesImp := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCidCli(const Value: String);
begin
  FstrCidCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TImpressaoDelLamaClass.SetstrCodFpg(const Value: String);
begin
  FstrCodFpg := Value;
end;

procedure TImpressaoDelLamaClass.SetstrConCli(const Value: String);
begin
  FstrConCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrEndCli(const Value: String);
begin
  FstrEndCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrEndEnt(const Value: String);
begin
  FstrEndEnt := Value;
end;

procedure TImpressaoDelLamaClass.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TImpressaoDelLamaClass.SetstrFaxCli(const Value: String);
begin
  FstrFaxCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrFonCli(const Value: String);
begin
  FstrFonCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrNomCli(const Value: String);
begin
  FstrNomCli := Value;
end;

procedure TImpressaoDelLamaClass.SetstrNomFil(const Value: String);
begin
  FstrNomFil := Value;
end;

procedure TImpressaoDelLamaClass.SetstrNomPro(const Value: String);
begin
  FstrNomPro := Value;
end;

procedure TImpressaoDelLamaClass.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TImpressaoDelLamaClass.SetstrMen001(const Value: String);
begin
  FstrMen001 := Value;
end;

procedure TImpressaoDelLamaClass.SetstrMen002(const Value: String);
begin
  FstrMen002 := Value;
end;

procedure TImpressaoDelLamaClass.SetstrMenDoc(const Value: String);
begin
  FstrMenDoc := Value;
end;

procedure TImpressaoDelLamaClass.SetstrRg_Ie_(const Value: String);
begin
  FstrRg_Ie_ := Value;
end;

initialization
  Factory.RegisterClass(TImpressaoDelLamaClass, 'ImpressaoDelLama');

end.
