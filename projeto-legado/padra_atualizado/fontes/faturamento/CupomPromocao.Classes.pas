unit CupomPromocao.Classes;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections;

type
  TCupomGerado = class
  strict private
    FAutoincrem: String;
    FstrEspDoc: String;
    FhorHorEnt: TDateTime;
    FstrNumDoc: String;
    FfltValAcm: Double;
    FfltValDoc: Double;
    FstrSequen: String;
    FstrCodEmp: String;
    FstrEmpCpp: String;
    FfltValUti: Double;
    FstrCodCli: String;
    FstrDesCpp: String;
    FdtaDtaEnt: TDateTime;
    FstrCodCpp: String;
    FstrTipImp: String;
    FstrCodLay: String;
    FstrCliCpf: String;
    FstrImpres: String;
    FstrSeqPro: String;
    FstrImpCup: String;

    procedure SetAutoincrem(const Value: String);
    procedure SetdtaDtaEnt(const Value: TDateTime);
    procedure SetfltValAcm(const Value: Double);
    procedure SetfltValDoc(const Value: Double);
    procedure SetfltValUti(const Value: Double);
    procedure SethorHorEnt(const Value: TDateTime);
    procedure SetstrSequen(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodCpp(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrEmpCpp(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrTipImp(const Value: String);
    procedure SetstrCodLay(const Value: String);
    procedure SetstrCliCpf(const Value: String);
    procedure SetstrImpres(const Value: String);
    procedure SetstrSeqPro(const Value: String);
    procedure SetstrDesCpp(const Value: String);
    procedure SetstrImpCup(const Value: String);

    function getCodigoCupom: String;
  public
    property Autoincrem: String   read FAutoincrem write SetAutoincrem;
    property dtaDtaEnt: TDateTime read FdtaDtaEnt  write SetdtaDtaEnt;
    property horHorEnt: TDateTime read FhorHorEnt  write SethorHorEnt;
    property strSequen: String    read FstrSequen  write SetstrSequen;
    property strNumDoc: String    read FstrNumDoc  write SetstrNumDoc;
    property strEspDoc: String    read FstrEspDoc  write SetstrEspDoc;
    property strCodEmp: String    read FstrCodEmp  write SetstrCodEmp;
    property strCodCli: String    read FstrCodCli  write SetstrCodCli;
    property fltValDoc: Double    read FfltValDoc  write SetfltValDoc;
    property strCodCpp: String    read FstrCodCpp  write SetstrCodCpp;
    property strDesCpp: String    read FstrDesCpp  write SetstrDesCpp;
    property strEmpCpp: String    read FstrEmpCpp  write SetstrEmpCpp;
    property fltValUti: Double    read FfltValUti  write SetfltValUti;
    property fltValAcm: Double    read FfltValAcm  write SetfltValAcm;
    property strTipImp: String    read FstrTipImp  write SetstrTipImp;
    property strCodLay: String    read FstrCodLay  write SetstrCodLay;
    property strCliCpf: String    read FstrCliCpf  write SetstrCliCpf;
    property strImpres: String    read FstrImpres  write SetstrImpres;
    property strSeqPro: String    read FstrSeqPro  write SetstrSeqPro;
    property strImpCup: String    read FstrImpCup  write SetstrImpCup;
    property strCodigoCupom: String read getCodigoCupom;
  end;

  TCupomValorAcumulado = class
  strict private
    FAutoincrem: String;
    FstrDocUti: String;
    FstrEspDoc: String;
    FdtaDtaUti: TDateTime;
    FstrEspUti: String;
    FstrNumDoc: String;
    FfltValAcm: Double;
    FfltValDoc: Double;
    FstrCodEmp: String;
    FstrEmpCpp: String;
    FstrCodCli: String;
    FdtaDtaVen: TDateTime;
    FhorHorUti: TDateTime;
    FstrEmpUti: String;
    FstrCodCpp: String;

    procedure SetAutoincrem(const Value: String);
    procedure SetdtaDtaUti(const Value: TDateTime);
    procedure SetdtaDtaVen(const Value: TDateTime);
    procedure SetfltValAcm(const Value: Double);
    procedure SetfltValDoc(const Value: Double);
    procedure SethorHorUti(const Value: TDateTime);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodCpp(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrDocUti(const Value: String);
    procedure SetstrEmpCpp(const Value: String);
    procedure SetstrEmpUti(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrEspUti(const Value: String);
    procedure SetstrNumDoc(const Value: String);
  public
    property Autoincrem: String   read FAutoincrem write SetAutoincrem;
    property dtaDtaVen: TDateTime read FdtaDtaVen  write SetdtaDtaVen;
    property strNumDoc: String    read FstrNumDoc  write SetstrNumDoc;
    property strEspDoc: String    read FstrEspDoc  write SetstrEspDoc;
    property strCodEmp: String    read FstrCodEmp  write SetstrCodEmp;
    property strCodCli: String    read FstrCodCli  write SetstrCodCli;
    property fltValDoc: Double    read FfltValDoc  write SetfltValDoc;
    property strCodCpp: String    read FstrCodCpp  write SetstrCodCpp;
    property strEmpCpp: String    read FstrEmpCpp  write SetstrEmpCpp;
    property fltValAcm: Double    read FfltValAcm  write SetfltValAcm;
    property dtaDtaUti: TDateTime read FdtaDtaUti  write SetdtaDtaUti;
    property horHorUti: TDateTime read FhorHorUti  write SethorHorUti;
    property strDocUti: String    read FstrDocUti  write SetstrDocUti;
    property strEspUti: String    read FstrEspUti  write SetstrEspUti;
    property strEmpUti: String    read FstrEmpUti  write SetstrEmpUti;
  end;

  TCupomPromocao = class
  strict private
    FValPr1: Double;
    FNumCup: integer;
    FAcmVal: string;
    FTipPro: integer;
    FCupTil: string;
    FCodEmp: string;
    FTipCli: string;
    FCodCli: string;
    FValTot: Double;
    FCodPro: string;
    FCpcLcs: string;
    FCupDes: string;
    FValPr2: Double;
    FTotCup: integer;
    FSldUti: Double;
    FCodLay: String;
    FImpCup: String;

    FstlValoresAcoumuladosUtilizados: TStrings;

    procedure SetAcmVal(const Value: string);
    procedure SetCodCli(const Value: string);
    procedure SetCodEmp(const Value: string);
    procedure SetCodPro(const Value: string);
    procedure SetCpcLcs(const Value: string);
    procedure SetCupDes(const Value: string);
    procedure SetCupTil(const Value: string);
    procedure SetNumCup(const Value: integer);
    procedure SetTipCli(const Value: string);
    procedure SetTipPro(const Value: integer);
    procedure SetTotCup(const Value: integer);
    procedure SetValPr1(const Value: Double);
    procedure SetValPr2(const Value: Double);
    procedure SetValTot(const Value: Double);
    procedure SetSldUti(const Value: Double);
    procedure SetCodLay(const Value: String);
    procedure SetImpCup(const Value: String);

    function getValAcm: Double;
    function getValUti: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property strCodPro: string  read FCodPro   write SetCodPro;
    property intTipPro: integer read FTipPro   write SetTipPro;
    property fltValPr1: Double  read FValPr1   write SetValPr1;
    property fltValPr2: Double  read FValPr2   write SetValPr2;
    property intNumCup: integer read FNumCup   write SetNumCup;
    property fltValTot: Double  read FValTot   write SetValTot;
    property intTotCup: integer read FTotCup   write SetTotCup;
    property strCupTil: string  read FCupTil   write SetCupTil;
    property strCupDes: string  read FCupDes   write SetCupDes;
    property strCodCli: string  read FCodCli   write SetCodCli;
    property strCodEmp: string  read FCodEmp   write SetCodEmp;
    property strTipCli: string  read FTipCli   write SetTipCli;
    property strCpcLcs: string  read FCpcLcs   write SetCpcLcs;
    property strAcmVal: string  read FAcmVal   write SetAcmVal;
    property fltSldUti: Double  read FSldUti   write SetSldUti;
    property strCodLay: String  read FCodLay   write SetCodLay;
    property strImpCup: String  read FImpCup   write SetImpCup;

    property fltValAcm: Double  read getValAcm;
    property fltValUti: Double  read getValUti;

    property stlValoresAcoumuladosUtilizados: TStrings  read FstlValoresAcoumuladosUtilizados;
  end;

implementation

uses
  untFuncoesSimples;

{ TCupomGerado }

function TCupomGerado.getCodigoCupom: String;
begin
  Result := fPreencheEspaco(FstrSequen, 12, False, '0')
          + '-'
          + FstrCodEmp;
end;

procedure TCupomGerado.SetAutoincrem(const Value: String);
begin
  FAutoincrem := Value;
end;

procedure TCupomGerado.SetdtaDtaEnt(const Value: TDateTime);
begin
  FdtaDtaEnt := Value;
end;

procedure TCupomGerado.SetfltValAcm(const Value: Double);
begin
  FfltValAcm := Value;
end;

procedure TCupomGerado.SetfltValDoc(const Value: Double);
begin
  FfltValDoc := Value;
end;

procedure TCupomGerado.SetfltValUti(const Value: Double);
begin
  FfltValUti := Value;
end;

procedure TCupomGerado.SethorHorEnt(const Value: TDateTime);
begin
  FhorHorEnt := Value;
end;

procedure TCupomGerado.SetstrSeqPro(const Value: String);
begin
  FstrSeqPro := Value;
end;

procedure TCupomGerado.SetstrSequen(const Value: String);
begin
  FstrSequen := Value;
end;

procedure TCupomGerado.SetstrCliCpf(const Value: String);
begin
  FstrCliCpf := Value;
end;

procedure TCupomGerado.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TCupomGerado.SetstrCodCpp(const Value: String);
begin
  FstrCodCpp := Value;
end;

procedure TCupomGerado.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TCupomGerado.SetstrCodLay(const Value: String);
begin
  FstrCodLay := Value;
end;

procedure TCupomGerado.SetstrDesCpp(const Value: String);
begin
  FstrDesCpp := Value;
end;

procedure TCupomGerado.SetstrEmpCpp(const Value: String);
begin
  FstrEmpCpp := Value;
end;

procedure TCupomGerado.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TCupomGerado.SetstrImpCup(const Value: String);
begin
  FstrImpCup := Value;
end;

procedure TCupomGerado.SetstrImpres(const Value: String);
begin
  FstrImpres := Value;
end;

procedure TCupomGerado.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TCupomGerado.SetstrTipImp(const Value: String);
begin
  FstrTipImp := Value;
end;

{ TCupomValorAcumulado }

procedure TCupomValorAcumulado.SetAutoincrem(const Value: String);
begin
  FAutoincrem := Value;
end;

procedure TCupomValorAcumulado.SetdtaDtaUti(const Value: TDateTime);
begin
  FdtaDtaUti := Value;
end;

procedure TCupomValorAcumulado.SetdtaDtaVen(const Value: TDateTime);
begin
  FdtaDtaVen := Value;
end;

procedure TCupomValorAcumulado.SetfltValAcm(const Value: Double);
begin
  FfltValAcm := Value;
end;

procedure TCupomValorAcumulado.SetfltValDoc(const Value: Double);
begin
  FfltValDoc := Value;
end;

procedure TCupomValorAcumulado.SethorHorUti(const Value: TDateTime);
begin
  FhorHorUti := Value;
end;

procedure TCupomValorAcumulado.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TCupomValorAcumulado.SetstrCodCpp(const Value: String);
begin
  FstrCodCpp := Value;
end;

procedure TCupomValorAcumulado.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TCupomValorAcumulado.SetstrDocUti(const Value: String);
begin
  FstrDocUti := Value;
end;

procedure TCupomValorAcumulado.SetstrEmpCpp(const Value: String);
begin
  FstrEmpCpp := Value;
end;

procedure TCupomValorAcumulado.SetstrEmpUti(const Value: String);
begin
  FstrEmpUti := Value;
end;

procedure TCupomValorAcumulado.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TCupomValorAcumulado.SetstrEspUti(const Value: String);
begin
  FstrEspUti := Value;
end;

procedure TCupomValorAcumulado.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

{ TCupomPromocao }

constructor TCupomPromocao.Create;
begin
  FstlValoresAcoumuladosUtilizados := TStringList.Create;
end;

destructor TCupomPromocao.Destroy;
begin
  FreeAndNil(FstlValoresAcoumuladosUtilizados);
  inherited;
end;

function TCupomPromocao.getValAcm: Double;
begin
  Result := 0;

  If FAcmVal = 'S' Then
    Result := (FValTot + FSldUti) - getValUti;
end;

function TCupomPromocao.getValUti: Double;
begin
  Result := 0;

  If FAcmVal = 'S' Then
    Result := (FValPr1 * FTotCup);
end;

procedure TCupomPromocao.SetAcmVal(const Value: string);
begin
  FAcmVal := Value;
end;

procedure TCupomPromocao.SetCodCli(const Value: string);
begin
  FCodCli := Value;
end;

procedure TCupomPromocao.SetCodEmp(const Value: string);
begin
  FCodEmp := Value;
end;

procedure TCupomPromocao.SetCodLay(const Value: String);
begin
  FCodLay := Value;
end;

procedure TCupomPromocao.SetCodPro(const Value: string);
begin
  FCodPro := Value;
end;

procedure TCupomPromocao.SetCpcLcs(const Value: string);
begin
  FCpcLcs := Value;
end;

procedure TCupomPromocao.SetCupDes(const Value: string);
begin
  FCupDes := Value;
end;

procedure TCupomPromocao.SetCupTil(const Value: string);
begin
  FCupTil := Value;
end;

procedure TCupomPromocao.SetImpCup(const Value: String);
begin
  FImpCup := Value;
end;

procedure TCupomPromocao.SetNumCup(const Value: integer);
begin
  FNumCup := Value;
end;

procedure TCupomPromocao.SetSldUti(const Value: Double);
begin
  FSldUti := Value;
end;

procedure TCupomPromocao.SetTipCli(const Value: string);
begin
  FTipCli := Value;
end;

procedure TCupomPromocao.SetTipPro(const Value: integer);
begin
  FTipPro := Value;
end;

procedure TCupomPromocao.SetTotCup(const Value: integer);
begin
  FTotCup := Value;
end;

procedure TCupomPromocao.SetValPr1(const Value: Double);
begin
  FValPr1 := Value;
end;

procedure TCupomPromocao.SetValPr2(const Value: Double);
begin
  FValPr2 := Value;
end;

procedure TCupomPromocao.SetValTot(const Value: Double);
begin
  FValTot := Value;
end;

end.
