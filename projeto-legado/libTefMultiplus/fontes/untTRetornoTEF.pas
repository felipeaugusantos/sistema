unit untTRetornoTEF;

interface

uses untInterfacesMultiplus, Classes;

type
  TRetornoTEF = Class(TInterfacedObject, IRetornoTEF)
  private
    FCupom : TStringList;
    FDadosCartao: TDadosCartao;
    FStatusTEF: TStatusTEF;
    function GetCupom: TStringList;
    function GetDadosCartao: TDadosCartao;
    function GetStatusTEF: TStatusTEF;
  public
    constructor Create();
    destructor Destroy; override;
    property Cupom: TStringList read GetCupom;
    property DadosCartao: TDadosCartao read GetDadosCartao;
    property StatusTef: TStatusTEF read GetStatusTEF;
  End;

implementation

{ TRetornoTEF }

constructor TRetornoTEF.Create;
begin
  FDadosCartao := TDadosCartao.Create;
  FStatusTEF := TStatusTEF.Create;
  FCupom := TStringList.Create;
end;

destructor TRetornoTEF.Destroy;
begin
  FCupom.Free;
  inherited;
end;

function TRetornoTEF.GetCupom: TStringList;
begin
  Result := FCupom;
end;

function TRetornoTEF.GetDadosCartao: TDadosCartao;
begin
  Result := FDadosCartao;
end;

function TRetornoTEF.GetStatusTEF: TStatusTEF;
begin
  Result := FStatusTEF;
end;

end.
