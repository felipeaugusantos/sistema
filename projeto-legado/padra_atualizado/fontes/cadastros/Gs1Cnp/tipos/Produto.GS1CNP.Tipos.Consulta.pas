unit Produto.GS1CNP.Tipos.Consulta;

interface

uses Produto.GS1CNP.Interfaces.Consulta;

type
  TProdutoGS1CNPConsultaRetorno = class(TInterfacedObject, IProdutoGS1CNPConsultaRetorno)
  private
    FDescricao: String;
    FMarca: String;
    FPesoBruto: Double;
    FPesoLiquido: Double;
    FCodigoGPC: String;
    FImagem: String;
    FStatus: String;
    FNcm: String;
  public
    function GetDescricao: String; overload;
    function SetDescricao(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetMarca: String; overload;
    function SetMarca(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetPesoBruto: Double; overload;
    function SetPesoBruto(const AValue: Double): IProdutoGS1CNPConsultaRetorno; overload;

    function GetPesoLiquido: Double; overload;
    function SetPesoLiquido(const AValue: Double): IProdutoGS1CNPConsultaRetorno; overload;

    function GetCodigoGPC: String; overload;
    function SetCodigoGPC(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetImagem: String; overload;
    function SetImagem(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetStatus: String; overload;
    function SetStatus(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    function GetNcm: String; overload;
    function SetNcm(const AValue: String): IProdutoGS1CNPConsultaRetorno; overload;

    class function New(): IProdutoGS1CNPConsultaRetorno;
  end;

implementation

{ TProdutoGS1CNPConsultaRetorno }

function TProdutoGS1CNPConsultaRetorno.SetCodigoGPC(const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FCodigoGPC := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.GetCodigoGPC: String;
begin
  Result := FCodigoGPC;
end;

function TProdutoGS1CNPConsultaRetorno.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TProdutoGS1CNPConsultaRetorno.SetDescricao(const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FDescricao := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.GetImagem: String;
begin
  Result := FImagem;
end;

function TProdutoGS1CNPConsultaRetorno.SetImagem(const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FImagem := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.SetMarca(const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FMarca := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.SetNcm(
  const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FNcm := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.GetMarca: String;
begin
  Result := FMarca;
end;

function TProdutoGS1CNPConsultaRetorno.GetNcm: String;
begin
  Result := FNcm;
end;

class function TProdutoGS1CNPConsultaRetorno.New: IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self.Create;
end;

function TProdutoGS1CNPConsultaRetorno.GetPesoBruto: Double;
begin
  Result := FPesoBruto;
end;

function TProdutoGS1CNPConsultaRetorno.GetPesoLiquido: Double;
begin
  Result := FPesoLiquido;
end;

function TProdutoGS1CNPConsultaRetorno.GetStatus: String;
begin
  Result := FStatus;
end;

function TProdutoGS1CNPConsultaRetorno.SetPesoBruto(const AValue: Double): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FPesoBruto := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.SetPesoLiquido(
  const AValue: Double): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FPesoLiquido := AValue;
end;

function TProdutoGS1CNPConsultaRetorno.SetStatus(
  const AValue: String): IProdutoGS1CNPConsultaRetorno;
begin
  Result := Self;
  FStatus := AValue;
end;

end.
