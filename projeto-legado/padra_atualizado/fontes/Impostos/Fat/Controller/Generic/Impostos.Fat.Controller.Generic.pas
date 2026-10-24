unit Impostos.Fat.Controller.Generic;

interface

uses Impostos.Fat.Controller.Interfaces.Generic, Impostos.Fat.Controller.Interfaces.Ipi,
  Impostos.Fat.Controller.Ipi, untFuncFatTypes, Impostos.Fat.Controller.Interfaces.IcmsSt,
  Impostos.Fat.Controller.IcmsSt,
  Impostos.Fat.Controller.Interfaces.IcmsEfetivo,
  Impostos.Fat.Controller.IcmsEfetivo,
  Impostos.Fat.Controller.Interfaces.FcpDifal,
  Impostos.Fat.Controller.FcpDifal;

type
  TImpostosFatControllerGeneric = class sealed(TInterfacedObject, IImpostosFatControllerGeneric)
  private
    FMatItens: TMatrizFechamento;
    FPosicaoMat: Integer;
    FDadosFechamento: TDadosFechamento;
  public
    function Ipi: IImpostosFatControllerIpi;
    function IcmsSt: IImpostosFatControllerIcmsSt;
    function IcmsEfetivo : IImpostosFatControllerIcmsEfetivo;
    function FcpDifal: IImpostosFatControllerFcpDifal;

    function SetarMatrizItens(var AMatItens: TMatrizFechamento): IImpostosFatControllerGeneric;
    function SetarPosicaoMatriz(const APosicao: Integer): IImpostosFatControllerGeneric;
    function SetarDadosFechamento(var ADadosFechamento: TDadosFechamento): IImpostosFatControllerGeneric;

    destructor Destroy; override;
    class function New(): IImpostosFatControllerGeneric;
  end;

implementation

{ TImpostosFatControllerGeneric }

destructor TImpostosFatControllerGeneric.Destroy;
begin
  FMatItens := Nil;
//  FDadosFechamento := Nil;
  inherited;
end;

function TImpostosFatControllerGeneric.IcmsEfetivo: IImpostosFatControllerIcmsEfetivo;
begin
  Result := TImpostosFatControllerIcmsEfetivo.New(FMatItens);
end;

function TImpostosFatControllerGeneric.FcpDifal: IImpostosFatControllerFcpDifal;
begin
  Result := TImpostosFatControllerFcpDifal.New(FDadosFechamento);
end;

function TImpostosFatControllerGeneric.IcmsSt: IImpostosFatControllerIcmsSt;
begin
  Result := TImpostosFatControllerIcmsSt.New(FMatItens, FPosicaoMat);
end;

function TImpostosFatControllerGeneric.Ipi: IImpostosFatControllerIpi;
begin
  Result := TImpostosFatControllerIpi.New(FMatItens, FPosicaoMat);
end;

class function TImpostosFatControllerGeneric.New: IImpostosFatControllerGeneric;
begin
  Result := Self.Create;
end;

function TImpostosFatControllerGeneric.SetarDadosFechamento(
  var ADadosFechamento: TDadosFechamento): IImpostosFatControllerGeneric;
begin
  Result := Self;
  FDadosFechamento := ADadosFechamento;
end;

function TImpostosFatControllerGeneric.SetarMatrizItens(var AMatItens: TMatrizFechamento): IImpostosFatControllerGeneric;
begin
  Result := Self;
  FMatItens := AMatItens;
end;

function TImpostosFatControllerGeneric.SetarPosicaoMatriz(
  const APosicao: Integer): IImpostosFatControllerGeneric;
begin
  Result := Self;
  FPosicaoMat := APosicao;
end;

end.
