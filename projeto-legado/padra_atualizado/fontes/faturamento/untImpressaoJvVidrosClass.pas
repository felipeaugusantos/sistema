unit untImpressaoJvVidrosClass;

interface

uses SysUtils, Classes, untBaseClass, untImpressaoJvVidrosIntf, untDespesasFaturamento;

Type
  TImpressaoJvVidrosClass = Class(TBaseClass, IImpressaoJvVidrosIntf)
  private
    FstrNumDoc: String;
    FstrEspDoc: String;
    FstrCodEmp: String;
    FstrCodCli: String;
    FstrEntCli: String;
    FstrCndPgt: String;
    FfltKilome: Double; //Valor Kilometragem
    FfltPedagi: Double; //Valor Pedagio
    FfltRefeic: Double; //Valor Refeicao
    FfltHosped: Double; //Valor Hospedagem
    FstrCodVen: String;
    FstrCodDig: String;
    FstrMensag: String;
    FdtaDtaDoc: TDateTime;
    FdtaHorDoc: TDateTime;
    FstrCodPro: String;
    FfltPerCom: Double;
    FfltTotFre: Double;
    FfltDesEsp: Double;
    FfltDesAce: Double;
    FfltTotDoc: Double;
    FstrNomCli: String;
    FstrEndCli: String;
    FstrBaiCli: String;
    FstrCidCli: String;
    FstrCpfCgc: String;
    FstrFonCli: String;
    FstrRg_Ie_: String;
    FstrCepCli: String;
    FstrDesImp: String;
    FstrNomFil: String;
    FstrTipImp: String;
    FstrTipNomEmp: String;
    FstrTipExp: String;
    FblnComPre: Boolean;
    FObjDespes: TDespesasFaturamento;
  public
    destructor Destroy; override;
  protected
    function GetdtaDtaDoc: TDateTime;
    function GetdtaHorDoc: TDateTime;
    function GetfltHosped: Double;
    function GetfltKilome: Double;
    function GetfltPedagi: Double;
    function GetfltPerCom: Double;
    function GetfltRefeic: Double;
    function GetstrCndPgt: String;
    function GetstrCodCli: String;
    function GetstrCodEmp: String;
    function GetstrCodPro: String;
    function GetstrCodVen: String;
    function GetstrCodDig: String;
    function GetstrEntCli: String;
    function GetstrEspDoc: String;
    function GetstrMensag: String;
    function GetstrNumDoc: String;
    function GetfltDesEsp: Double;
    function GetfltDesAce: Double;
    function GetfltTotDoc: Double;
    function GetfltTotFre: Double;
    function GetstrBaiCli: String;
    function GetstrCepCli: String;
    function GetstrCidCli: String;
    function GetstrCpfCgc: String;
    function GetstrEndCli: String;
    function GetstrFonCli: String;
    function GetstrNomCli: String;
    function GetstrRg_Ie_: String;
    function GetstrDesImp: String;
    function GetstrNomFil: String;
    function GetstrTipImp: String;
    function GetstrTipNomEmp: String;
    function GetstrTipExp: String;
    function GetblnComPre: Boolean;
    function GetobjDespes: TDespesasFaturamento;
    procedure SetdtaDtaDoc(const Value: TDateTime);
    procedure SetdtaHorDoc(const Value: TDateTime);
    procedure SetfltHosped(const Value: Double);
    procedure SetfltKilome(const Value: Double);
    procedure SetfltPedagi(const Value: Double);
    procedure SetfltPerCom(const Value: Double);
    procedure SetfltRefeic(const Value: Double);
    procedure SetstrCndPgt(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrCodPro(const Value: String);
    procedure SetstrCodVen(const Value: String);
    procedure SetstrCodDig(const Value: String);
    procedure SetstrEntCli(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrMensag(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetfltDesEsp(const Value: Double);
    procedure SetfltDesAce(const Value: Double);
    procedure SetfltTotDoc(const Value: Double);
    procedure SetfltTotFre(const Value: Double);
    procedure SetstrBaiCli(const Value: String);
    procedure SetstrCepCli(const Value: String);
    procedure SetstrCidCli(const Value: String);
    procedure SetstrCpfCgc(const Value: String);
    procedure SetstrEndCli(const Value: String);
    procedure SetstrFonCli(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrRg_Ie_(const Value: String);
    procedure SetstrDesImp(const Value: String);
    procedure SetstrNomFil(const Value: String);
    procedure SetstrTipImp(const Value: String);
    procedure SetstrTipNomEmp(const Value: String);
    procedure SetstrTipExp(const Value: String);
    procedure SetblnComPre(const Value: Boolean);
    procedure SetObjDespes(const Value: TDespesasFaturamento);
  published
    property strNumDoc: String    Read GetstrNumDoc Write SetstrNumDoc;
    property strEspDoc: String    Read GetstrEspDoc Write SetstrEspDoc;
    property strCodEmp: String    Read GetstrCodEmp Write SetstrCodEmp;
    property strCodCli: String    Read GetstrCodCli Write SetstrCodCli;
    property strEntCli: String    Read GetstrEntCli Write SetstrEntCli;
    property strCndPgt: String    Read GetstrCndPgt Write SetstrCndPgt;
    property fltKilome: Double    Read GetfltKilome Write SetfltKilome;
    property fltPedagi: Double    Read GetfltPedagi Write SetfltPedagi;
    property fltRefeic: Double    Read GetfltRefeic Write SetfltRefeic;
    property fltHosped: Double    Read GetfltHosped Write SetfltHosped;
    property strCodVen: String    Read GetstrCodVen Write SetstrCodVen;
    property strCodDig: String    Read GetstrCodDig Write SetstrCodDig;
    property strMensag: String    Read GetstrMensag Write SetstrMensag;
    property dtaDtaDoc: TDateTime Read GetdtaDtaDoc Write SetdtaDtaDoc;
    property dtaHorDoc: TDateTime Read GetdtaHorDoc Write SetdtaHorDoc;
    property strCodPro: String    Read GetstrCodPro Write SetstrCodPro;
    property fltPerCom: Double    Read GetfltPerCom Write SetfltPerCom;
    property fltTotFre: Double    Read GetfltTotFre Write SetfltTotFre;
    property fltDesEsp: Double    Read GetfltDesEsp Write SetfltDesEsp;
    property fltDesAce: Double    Read GetfltDesAce Write SetfltDesAce;
    property fltTotDoc: Double    Read GetfltTotDoc Write SetfltTotDoc;
    property strNomCli: String    Read GetstrNomCli Write SetstrNomCli;
    property strEndCli: String    Read GetstrEndCli Write SetstrEndCli;
    property strBaiCli: String    Read GetstrBaiCli Write SetstrBaiCli;
    property strCidCli: String    Read GetstrCidCli Write SetstrCidCli;
    property strCpfCgc: String    Read GetstrCpfCgc Write SetstrCpfCgc;
    property strFonCli: String    Read GetstrFonCli Write SetstrFonCli;
    property strRg_Ie_: String    Read GetstrRg_Ie_ Write SetstrRg_Ie_;
    property strCepCli: String    Read GetstrCepCli Write SetstrCepCli;
    property strDesImp: String    Read GetstrDesImp Write SetstrDesImp;
    property strNomFil: String    Read GetstrNomFil Write SetstrNomFil;
    property strTipImp: String    Read GetstrTipImp Write SetstrTipImp;
    property strTipNomEmp: String Read GetstrTipNomEmp Write SetstrTipNomEmp;
    property strTipExp: String    Read GetstrTipExp Write SetstrTipExp;
    property blnComPre: Boolean   Read GetblnComPre Write SetblnComPre;
    property objDespesas: TDespesasFaturamento  Read GetObjDespes Write SetObjDespes;
  End;

implementation

uses untFactoryClass;

{ TImpressaoJvVidrosClass }

destructor TImpressaoJvVidrosClass.Destroy;
begin
  If Assigned(objDespesas) Then
    objDespesas.Destroy;
  inherited;
end;

function TImpressaoJvVidrosClass.GetblnComPre: Boolean;
begin
  Result := FblnComPre;
end;

function TImpressaoJvVidrosClass.GetdtaDtaDoc: TDateTime;
begin
  Result := FdtaDtaDoc;
end;

function TImpressaoJvVidrosClass.GetdtaHorDoc: TDateTime;
begin
  Result := FdtaHorDoc;
end;

function TImpressaoJvVidrosClass.GetfltDesEsp: Double;
begin
  Result := FfltDesEsp;
end;

function TImpressaoJvVidrosClass.GetfltDesAce: Double;
begin
  Result := FfltDesAce;
end;

function TImpressaoJvVidrosClass.GetfltHosped: Double;
begin
  Result := FfltHosped;
end;

function TImpressaoJvVidrosClass.GetfltKilome: Double;
begin
  Result := FfltKilome;
end;

function TImpressaoJvVidrosClass.GetfltPedagi: Double;
begin
  Result := FfltPedagi;
end;

function TImpressaoJvVidrosClass.GetfltPerCom: Double;
begin
  Result := FfltPerCom;
end;

function TImpressaoJvVidrosClass.GetfltRefeic: Double;
begin
  Result := FfltRefeic;
end;

function TImpressaoJvVidrosClass.GetfltTotDoc: Double;
begin
  Result := FfltTotDoc;
end;

function TImpressaoJvVidrosClass.GetfltTotFre: Double;
begin
  Result := FfltTotFre;
end;

function TImpressaoJvVidrosClass.GetobjDespes: TDespesasFaturamento;
begin
  Result := FObjDespes;
end;

function TImpressaoJvVidrosClass.GetstrBaiCli: String;
begin
  Result := FstrBaiCli;
end;

function TImpressaoJvVidrosClass.GetstrCepCli: String;
begin
  Result := FstrCepCli;
end;

function TImpressaoJvVidrosClass.GetstrCidCli: String;
begin
  Result := FstrCidCli;
end;

function TImpressaoJvVidrosClass.GetstrCndPgt: String;
begin
  Result := FstrCndPgt;
end;

function TImpressaoJvVidrosClass.GetstrCodCli: String;
begin
  Result := FstrCodCli;
end;

function TImpressaoJvVidrosClass.GetstrCodEmp: String;
begin
  Result := FstrCodEmp;
end;

function TImpressaoJvVidrosClass.GetstrCodPro: String;
begin
  Result := FstrCodPro;
end;

function TImpressaoJvVidrosClass.GetstrCodVen: String;
begin
  Result := FstrCodVen;
end;

function TImpressaoJvVidrosClass.GetstrCodDig: String;
begin
  Result := FstrCodDig;
end;

function TImpressaoJvVidrosClass.GetstrCpfCgc: String;
begin
  Result := FstrCpfCgc;
end;

function TImpressaoJvVidrosClass.GetstrDesImp: String;
begin
  Result := FstrDesImp;
end;

function TImpressaoJvVidrosClass.GetstrEndCli: String;
begin
  Result := FstrEndCli;
end;

function TImpressaoJvVidrosClass.GetstrEntCli: String;
begin
  Result := FstrEntCli;
end;

function TImpressaoJvVidrosClass.GetstrEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TImpressaoJvVidrosClass.GetstrFonCli: String;
begin
  Result := FstrFonCli;
end;

function TImpressaoJvVidrosClass.GetstrMensag: String;
begin
  Result := FstrMensag;
end;

function TImpressaoJvVidrosClass.GetstrNomCli: String;
begin
  Result := FstrNomCli;
end;

function TImpressaoJvVidrosClass.GetstrNomFil: String;
begin
  Result := FstrNomFil;
end;

function TImpressaoJvVidrosClass.GetstrNumDoc: String;
begin
  Result := FstrNumDoc;
end;

function TImpressaoJvVidrosClass.GetstrRg_Ie_: String;
begin
  Result := FstrRg_Ie_;
end;

function TImpressaoJvVidrosClass.GetstrTipExp: String;
begin
  Result := FstrTipExp;
end;

function TImpressaoJvVidrosClass.GetstrTipImp: String;
begin
  Result := FstrTipImp;
end;

function TImpressaoJvVidrosClass.GetstrTipNomEmp: String;
begin
  Result := FstrTipNomEmp;
end;

procedure TImpressaoJvVidrosClass.SetblnComPre(const Value: Boolean);
begin
  FblnComPre := Value;
end;

procedure TImpressaoJvVidrosClass.SetdtaDtaDoc(const Value: TDateTime);
begin
  FdtaDtaDoc := Value;
end;

procedure TImpressaoJvVidrosClass.SetdtaHorDoc(const Value: TDateTime);
begin
  FdtaHorDoc := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltDesEsp(const Value: Double);
begin
  FfltDesEsp := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltDesAce(const Value: Double);
begin
  FfltDesAce := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltHosped(const Value: Double);
begin
  FfltHosped := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltKilome(const Value: Double);
begin
  FfltKilome := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltPedagi(const Value: Double);
begin
  FfltPedagi := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltPerCom(const Value: Double);
begin
  FfltPerCom := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltRefeic(const Value: Double);
begin
  FfltRefeic := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltTotDoc(const Value: Double);
begin
  FfltTotDoc := Value;
end;

procedure TImpressaoJvVidrosClass.SetfltTotFre(const Value: Double);
begin
  FfltTotFre := Value;
end;

procedure TImpressaoJvVidrosClass.SetObjDespes(
  const Value: TDespesasFaturamento);
begin
  FObjDespes := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrBaiCli(const Value: String);
begin
  FstrBaiCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCepCli(const Value: String);
begin
  FstrCepCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCidCli(const Value: String);
begin
  FstrCidCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCndPgt(const Value: String);
begin
  FstrCndPgt := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCodPro(const Value: String);
begin
  FstrCodPro := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCodVen(const Value: String);
begin
  FstrCodVen := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCodDig(const Value: String);
begin
  FstrCodDig := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrCpfCgc(const Value: String);
begin
  FstrCpfCgc := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrDesImp(const Value: String);
begin
  FstrDesImp := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrEndCli(const Value: String);
begin
  FstrEndCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrEntCli(const Value: String);
begin
  FstrEntCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrFonCli(const Value: String);
begin
  FstrFonCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrMensag(const Value: String);
begin
  FstrMensag := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrNomCli(const Value: String);
begin
  FstrNomCli := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrNomFil(const Value: String);
begin
  FstrNomFil := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrRg_Ie_(const Value: String);
begin
  FstrRg_Ie_ := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrTipExp(const Value: String);
begin
  FstrTipExp := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrTipImp(const Value: String);
begin
  FstrTipImp := Value;
end;

procedure TImpressaoJvVidrosClass.SetstrTipNomEmp(const Value: String);
begin
  FstrTipNomEmp := Value;
end;

initialization
  Factory.RegisterClass(TImpressaoJvVidrosClass, 'ImpressaoJvVidros');

end.
