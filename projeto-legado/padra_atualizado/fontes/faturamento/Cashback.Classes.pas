unit Cashback.Classes;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TItemCashbackVenda = class
  strict private
    FstrIncDet: String;
    FfltDesCsh: Double;

    procedure SetfltDesCsh(const Value: Double);
    procedure SetstrIncDet(const Value: String);
  public
    property strIncDet: String read FstrIncDet write SetstrIncDet;
    property fltDesCsh: Double read FfltDesCsh write SetfltDesCsh;
  end;

  TVendaCashback = class
  strict private
    FstrResCal: String;
    FfltVlrDsp: Double;
    FstrEspDoc: String;
    FfltVlrCsh: Double;
    FstrCodCsh: String;
    FfltPerMax: Double;
    FstrNumDoc: String;
    FdtaIniVal: TDateTime;
    FdtaDtaVal: TDateTime;
    FstrCodEmp: String;
    FstrCodCli: String;
    FstrNumCsh: String;
    FdtaDtaEnt: TDateTime;
    FfltMinPrx: Double;
    FfltVlrDoc: Double;
    FstrSeqGer: String;
    FstrStatus: String;
    FstrAutInc: String;
    FintDiaUti: Integer;
    FstrCodOpe: String;
    FstrOrigem: String;
    FstrTelCon: String;
    FfltQtdEmb: Double;
    FstrCgcCpf: String;
    FstrCgcCon: String;
    FListaItemCashbackVenda: TList<TItemCashbackVenda>;

    procedure SetdtaDtaEnt(const Value: TDateTime);
    procedure SetdtaIniVal(const Value: TDateTime);
    procedure SetdtaDtaVal(const Value: TDateTime);
    procedure SetfltMinPrx(const Value: Double);
    procedure SetfltPerMax(const Value: Double);
    procedure SetfltVlrCsh(const Value: Double);
    procedure SetfltVlrDoc(const Value: Double);
    procedure SetfltVlrDsp(const Value: Double);
    procedure SetstrAutInc(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodCsh(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrNumCsh(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrResCal(const Value: String);
    procedure SetstrSeqGer(const Value: String);
    procedure SetstrStatus(const Value: String);
    procedure SetintDiaUti(const Value: Integer);
    procedure SetstrCodOpe(const Value: String);
    procedure SetstrOrigem(const Value: String);
    procedure SetfltQtdEmb(const Value: Double);
    procedure SetstrCgcCon(const Value: String);
    procedure SetstrCgcCpf(const Value: String);
    procedure SetstrTelCon(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;

    property strAutInc : String    read FstrAutInc write SetstrAutInc;
    property strNumCsh : String    read FstrNumCsh write SetstrNumCsh;
    property strSeqGer : String    read FstrSeqGer write SetstrSeqGer;
    property dtaDtaEnt : TDateTime read FdtaDtaEnt write SetdtaDtaEnt;
    property strCodCli : String    read FstrCodCli write SetstrCodCli;
    property strNumDoc : String    read FstrNumDoc write SetstrNumDoc;
    property strEspDoc : String    read FstrEspDoc write SetstrEspDoc;
    property strCodEmp : String    read FstrCodEmp write SetstrCodEmp;
    property strCodCsh : String    read FstrCodCsh write SetstrCodCsh;
    property strResCal : String    read FstrResCal write SetstrResCal;
    property dtaIniVal : TDateTime read FdtaIniVal write SetdtaIniVal;
    property dtaDtaVal : TDateTime read FdtaDtaVal write SetdtaDtaVal;
    property fltVlrDoc : Double    read FfltVlrDoc write SetfltVlrDoc;
    property fltVlrCsh : Double    read FfltVlrCsh write SetfltVlrCsh;
    property fltVlrDsp : Double    read FfltVlrDsp write SetfltVlrDsp;
    property fltMinPrx : Double    read FfltMinPrx write SetfltMinPrx;
    property fltPerMax : Double    read FfltPerMax write SetfltPerMax;
    property strStatus : String    read FstrStatus write SetstrStatus;
    property intDiaUti : Integer   read FintDiaUti write SetintDiaUti;
    property strCodOpe : String    read FstrCodOpe write SetstrCodOpe;
    property strOrigem : String    read FstrOrigem write SetstrOrigem;
    property strTelCon : String    read FstrTelCon write SetstrTelCon;
    property strCgcCpf : String    read FstrCgcCpf write SetstrCgcCpf;
    property strCgcCon : String    read FstrCgcCon write SetstrCgcCon;
    property fltQtdEmb : Double    read FfltQtdEmb write SetfltQtdEmb;

    property ListaItemCashbackVenda: TList<TItemCashbackVenda> read FListaItemCashbackVenda;

  end;

  TUtilizacaoCashback = class
  strict private
    FfltVlrUti: Double;
    FdtaDtaUti: TDateTime;
    FstrNumPed: String;
    FstrEmpPed: String;
    FstrNumCsh: String;
    FstrAutInc: String;
    FstrEspPed: String;

    procedure SetdtaDtaUti(const Value: TDateTime);
    procedure SetfltVlrUti(const Value: Double);
    procedure SetstrAutInc(const Value: String);
    procedure SetstrEmpPed(const Value: String);
    procedure SetstrNumCsh(const Value: String);
    procedure SetstrNumPed(const Value: String);
    procedure SetstrEspPed(const Value: String);
  public
    property strAutInc : String    read FstrAutInc write SetstrAutInc;
    property strNumCsh : String    read FstrNumCsh write SetstrNumCsh;
    property fltVlrUti : Double    read FfltVlrUti write SetfltVlrUti;
    property dtaDtaUti : TDateTime read FdtaDtaUti write SetdtaDtaUti;
    property strNumPed : String    read FstrNumPed write SetstrNumPed;
    property strEspPed : String    read FstrEspPed write SetstrEspPed;
    property strEmpPed : String    read FstrEmpPed write SetstrEmpPed;
  end;

  TTipoCashback = class
  strict private
    FListaTipos : TDictionary<String,String>;

    procedure pCarregaListaTipos;
  public
    constructor Create;
    destructor Destroy; override;

    property ListaTipos : TDictionary<String,String> read FListaTipos;
  end;

const
  ARR_DOCUMENTOS_OPCDOC_GERACAO_CASHBACK : Array[0..2] Of String = ('VN','11','EI');
  ARR_DOCUMENTOS_GERACAO_CASHBACK        : Array[0..3] Of String = ('NF','CF','IF','FF');
  ARR_DOCUMENTOS_UTILIZACAO_CASHBACK     : Array[0..5] Of String = ('PD','VN','NF','CF','IF','FF');
  ARR_DOCUMENTOS_DEV_CASHBACK_GERADO     : Array[0..1] Of String = ('DV','NF');

implementation

{ TVendaCashback }

constructor TVendaCashback.Create;
begin
  FListaItemCashbackVenda := TList<TItemCashbackVenda>.Create;
end;

destructor TVendaCashback.Destroy;
begin
  FreeAndNil(FListaItemCashbackVenda);

  inherited;
end;

procedure TVendaCashback.SetdtaDtaEnt(const Value: TDateTime);
begin
  FdtaDtaEnt := Value;
end;

procedure TVendaCashback.SetdtaDtaVal(const Value: TDateTime);
begin
  FdtaDtaVal := Value;
end;

procedure TVendaCashback.SetdtaIniVal(const Value: TDateTime);
begin
  FdtaIniVal := Value;
end;

procedure TVendaCashback.SetfltMinPrx(const Value: Double);
begin
  FfltMinPrx := Value;
end;

procedure TVendaCashback.SetfltPerMax(const Value: Double);
begin
  FfltPerMax := Value;
end;

procedure TVendaCashback.SetfltQtdEmb(const Value: Double);
begin
  FfltQtdEmb := Value;
end;

procedure TVendaCashback.SetfltVlrCsh(const Value: Double);
begin
  FfltVlrCsh := Value;
end;

procedure TVendaCashback.SetfltVlrDoc(const Value: Double);
begin
  FfltVlrDoc := Value;
end;

procedure TVendaCashback.SetfltVlrDsp(const Value: Double);
begin
  FfltVlrDsp := Value;
end;

procedure TVendaCashback.SetintDiaUti(const Value: Integer);
begin
  FintDiaUti := Value;
end;

procedure TVendaCashback.SetstrAutInc(const Value: String);
begin
  FstrAutInc := Value;
end;

procedure TVendaCashback.SetstrCgcCon(const Value: String);
begin
  FstrCgcCon := Value;
end;

procedure TVendaCashback.SetstrCgcCpf(const Value: String);
begin
  FstrCgcCpf := Value;
end;

procedure TVendaCashback.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TVendaCashback.SetstrCodCsh(const Value: String);
begin
  FstrCodCsh := Value;
end;

procedure TVendaCashback.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TVendaCashback.SetstrCodOpe(const Value: String);
begin
  FstrCodOpe := Value;
end;

procedure TVendaCashback.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TVendaCashback.SetstrNumCsh(const Value: String);
begin
  FstrNumCsh := Value;
end;

procedure TVendaCashback.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TVendaCashback.SetstrOrigem(const Value: String);
begin
  FstrOrigem := Value;
end;

procedure TVendaCashback.SetstrResCal(const Value: String);
begin
  FstrResCal := Value;
end;

procedure TVendaCashback.SetstrSeqGer(const Value: String);
begin
  FstrSeqGer := Value;
end;

procedure TVendaCashback.SetstrStatus(const Value: String);
begin
  FstrStatus := Value;
end;

procedure TVendaCashback.SetstrTelCon(const Value: String);
begin
  FstrTelCon := Value;
end;

{ TUtilizacaoCashback }

procedure TUtilizacaoCashback.SetdtaDtaUti(const Value: TDateTime);
begin
  FdtaDtaUti := Value;
end;

procedure TUtilizacaoCashback.SetfltVlrUti(const Value: Double);
begin
  FfltVlrUti := Value;
end;

procedure TUtilizacaoCashback.SetstrAutInc(const Value: String);
begin
  FstrAutInc := Value;
end;

procedure TUtilizacaoCashback.SetstrEmpPed(const Value: String);
begin
  FstrEmpPed := Value;
end;

procedure TUtilizacaoCashback.SetstrNumCsh(const Value: String);
begin
  FstrNumCsh := Value;
end;

procedure TUtilizacaoCashback.SetstrNumPed(const Value: String);
begin
  FstrNumPed := Value;
end;

procedure TUtilizacaoCashback.SetstrEspPed(const Value: String);
begin
  FstrEspPed := Value;
end;

{ TTipoCashback }

constructor TTipoCashback.Create;
begin
  pCarregaListaTipos;
end;

destructor TTipoCashback.Destroy;
begin
  FreeAndNil(FListaTipos);
  inherited;
end;

procedure TTipoCashback.pCarregaListaTipos;
begin
  FListaTipos := TDictionary<String,String>.Create;
  FListaTipos.Add('VF','Valor fixo de %s sobre o valor da compra.');
  FListaTipos.Add('PD','Percentual de %s% sobre o valor da compra.');
  FListaTipos.Add('VC','A cada %s em compras, acumulo de %s.');
  FListaTipos.Add('PI','Percentual de %s% sobre o valor dos itens informados.');
  FListaTipos.Add('VI','Valor fixo de %s sobre os itens informados.');
  FListaTipos.Add('DE','Devolução de Embalagem - A cada unidade devolvida, acúmulo de %s.');
end;

{ TItemCashbackVenda }

procedure TItemCashbackVenda.SetfltDesCsh(const Value: Double);
begin
  FfltDesCsh := Value;
end;

procedure TItemCashbackVenda.SetstrIncDet(const Value: String);
begin
  FstrIncDet := Value;
end;

end.
