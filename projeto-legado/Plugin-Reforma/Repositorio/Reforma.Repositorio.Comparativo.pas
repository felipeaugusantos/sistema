unit Reforma.Repositorio.Comparativo;

// Sem DDL neste requisito: hoje so a implementacao em memoria. A chave ja carrega
// empresa, item e vigencia para a versao em banco nao depender de ITEGER.

interface

uses
  System.Generics.Collections,
  Reforma.Contrato.Tipos,
  Reforma.Calculo.Modelo;

type
  TChaveComparativo = record
    CodigoEmpresa: string;
    CodigoItem: string;
    Vigencia: TDateTime;
    Lado: TLadoSimulacao;
  end;

  IComparativoRepositorio = interface
    ['{D14E442B-ADA1-4C68-9B50-F2BFEBB2E9B6}']
    procedure Guardar(const Chave: TChaveComparativo; const Formacao: TFormacaoCusto);
    function Obter(const Chave: TChaveComparativo; out Formacao: TFormacaoCusto): Boolean;
    procedure Remover(const Chave: TChaveComparativo);
  end;

  TComparativoMemoria = class(TInterfacedObject, IComparativoRepositorio)
  strict private
    FItens: TDictionary<string, TFormacaoCusto>;
    function Identificar(const Chave: TChaveComparativo): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Guardar(const Chave: TChaveComparativo; const Formacao: TFormacaoCusto);
    function Obter(const Chave: TChaveComparativo; out Formacao: TFormacaoCusto): Boolean;
    procedure Remover(const Chave: TChaveComparativo);
  end;

implementation

uses
  System.SysUtils;

constructor TComparativoMemoria.Create;
begin
  inherited Create;
  FItens := TDictionary<string, TFormacaoCusto>.Create;
end;

destructor TComparativoMemoria.Destroy;
begin
  FreeAndNil(FItens);
  inherited Destroy;
end;

function TComparativoMemoria.Identificar(const Chave: TChaveComparativo): string;
begin
  Result := Chave.CodigoEmpresa + '|' + Chave.CodigoItem + '|' +
    FloatToStr(Chave.Vigencia) + '|' + IntToStr(Ord(Chave.Lado));
end;

procedure TComparativoMemoria.Guardar(const Chave: TChaveComparativo; const Formacao: TFormacaoCusto);
begin
  FItens.AddOrSetValue(Identificar(Chave), Formacao);
end;

function TComparativoMemoria.Obter(const Chave: TChaveComparativo; out Formacao: TFormacaoCusto): Boolean;
begin
  Result := FItens.TryGetValue(Identificar(Chave), Formacao);
end;

procedure TComparativoMemoria.Remover(const Chave: TChaveComparativo);
begin
  FItens.Remove(Identificar(Chave));
end;

end.