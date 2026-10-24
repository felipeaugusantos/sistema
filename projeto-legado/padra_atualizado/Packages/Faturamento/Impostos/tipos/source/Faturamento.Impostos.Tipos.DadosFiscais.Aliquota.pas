unit Faturamento.Impostos.Tipos.DadosFiscais.Aliquota;

interface

uses Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota, Shared.Functions.Types;

type
  TParametrosDadosFiscaisAliquota = class(TInterfacedObject, IParametrosDadosFiscaisAliquota)
  private
    FClienteEstado                  : String;
    FInscricaoEstadual              : String;
    FMicroEmpreendedor              : Boolean;
    FEmpresaEstado                  : String;
    FDocumentoDeVenda               : Boolean;
    FDentroDoEstadoCFOP             : Boolean;
    FAtividadeConstrutora           : Boolean;
    FEspecieDocumento               : String;
  public

    function ClienteEstado : String; overload;
    function ClienteEstado(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function InscricaoEstadual : String; overload;
    function InscricaoEstadual(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function MicroEmpreendedor : Boolean;  overload;
    function MicroEmpreendedor(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function EmpresaEstado : String; overload;
    function EmpresaEstado(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    function DocumentoDeVenda : Boolean;overload;
    function DocumentoDeVenda(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function DentroDoEstadoCFOP : Boolean;overload;
    function DentroDoEstadoCFOP(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function AtividadeConstrutora : Boolean;overload;
    function AtividadeConstrutora(AValue: Boolean): IParametrosDadosFiscaisAliquota; overload;

    function EspecieDocumento : String; overload;
    function EspecieDocumento(AValue: String): IParametrosDadosFiscaisAliquota; overload;

    class function New(): IParametrosDadosFiscaisAliquota;
  end;

type
  TResultadoDadosFiscaisAliquota = class(TInterfacedObject, IResultadoDadosFiscaisAliquota)
  private
	  FAliquotaIcm : Double;
  public
    function AliquotaIcm: Double ; overload;
    function AliquotaIcm(AValue: Double): IResultadoDadosFiscaisAliquota; overload;

    class function New(): IResultadoDadosFiscaisAliquota;
  end;

implementation

{ TParametrosDadosFiscaisAliquota}

function TResultadoDadosFiscaisAliquota.AliquotaIcm(
  AValue: Double): IResultadoDadosFiscaisAliquota;
begin
  Result := Self;
  FAliquotaIcm := AValue;

end;

function TResultadoDadosFiscaisAliquota.AliquotaIcm: Double;
begin
  Result := FAliquotaIcm;
end;


class function TResultadoDadosFiscaisAliquota.New: IResultadoDadosFiscaisAliquota;
begin
  Result := Self.Create;
end;


{ TParametrosDadosFiscaisAliquota }

function TParametrosDadosFiscaisAliquota.AtividadeConstrutora(
  AValue: Boolean): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FAtividadeConstrutora := AValue;
end;

function TParametrosDadosFiscaisAliquota.AtividadeConstrutora: Boolean;
begin
  Result := FAtividadeConstrutora;
end;

function TParametrosDadosFiscaisAliquota.ClienteEstado: String;
begin
  Result := FClienteEstado;
end;

function TParametrosDadosFiscaisAliquota.ClienteEstado(
  AValue: String): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FClienteEstado := AValue;
end;

function TParametrosDadosFiscaisAliquota.DentroDoEstadoCFOP: Boolean;
begin
  Result := FDentroDoEstadoCFOP;
end;

function TParametrosDadosFiscaisAliquota.DentroDoEstadoCFOP(
  AValue: Boolean): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FDentroDoEstadoCFOP := AValue;
end;

function TParametrosDadosFiscaisAliquota.DocumentoDeVenda: Boolean;
begin
  Result := FDocumentoDeVenda;
end;

function TParametrosDadosFiscaisAliquota.DocumentoDeVenda(
  AValue: Boolean): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FDocumentoDeVenda := AValue;
end;

function TParametrosDadosFiscaisAliquota.EmpresaEstado: String;
begin
  Result := FEmpresaEstado;
end;

function TParametrosDadosFiscaisAliquota.EmpresaEstado(
  AValue: String): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FEmpresaEstado := AValue;
end;

function TParametrosDadosFiscaisAliquota.EspecieDocumento: String;
begin
  Result := FEspecieDocumento;
end;

function TParametrosDadosFiscaisAliquota.EspecieDocumento(
  AValue: String): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FEspecieDocumento := AValue;
end;

function TParametrosDadosFiscaisAliquota.InscricaoEstadual(
  AValue: String): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FInscricaoEstadual := AValue;
end;

function TParametrosDadosFiscaisAliquota.InscricaoEstadual: String;
begin
  Result := FInscricaoEstadual;
end;

function TParametrosDadosFiscaisAliquota.MicroEmpreendedor: Boolean;
begin
  Result := FMicroEmpreendedor;
end;

function TParametrosDadosFiscaisAliquota.MicroEmpreendedor(
  AValue: Boolean): IParametrosDadosFiscaisAliquota;
begin
  Result := Self;
  FMicroEmpreendedor := AValue;
end;

class function TParametrosDadosFiscaisAliquota.New: IParametrosDadosFiscaisAliquota;
begin
  Result := Self.Create;
end;

end.
