unit untGenericDefinicaoTxtCampo;

interface

uses
  untIDefinicaoTxtCampo, untDefinicaoTxtCampoTipo;

type
  TGenericDefinicaoTxtCampo = class(TInterfacedObject, IDefinicaoTxtCampo)
  private
    largura: Integer;
    nome: string;
    tipo: TDefinicaoTxtCampoTipo.Tipo;
  public
    function GetLargura: Integer;
    function GetNome: string;
    function GetTipo: TDefinicaoTxtCampoTipo.Tipo;
  public
    constructor Create(const nome: string; const tipo: TDefinicaoTxtCampoTipo.Tipo; const largura: Integer); overload;
    constructor Create(const nome: string; const tipo: TDefinicaoTxtCampoTipo.Tipo); overload;
  end;

implementation

{ TGenericDefinicaoTxtCampo }

constructor TGenericDefinicaoTxtCampo.Create(const nome: string; const tipo: TDefinicaoTxtCampoTipo.Tipo; const largura: Integer);
begin
  inherited Create();
  Self.largura := largura;
  Self.nome := nome;
  Self.tipo := tipo;
end;

constructor TGenericDefinicaoTxtCampo.Create(const nome: string; const tipo: TDefinicaoTxtCampoTipo.Tipo);
begin
  Create(nome, tipo, -1);
end;

function TGenericDefinicaoTxtCampo.GetLargura: Integer;
begin
  Result := largura;
end;

function TGenericDefinicaoTxtCampo.GetNome: string;
begin
  Result := nome;
end;

function TGenericDefinicaoTxtCampo.GetTipo: TDefinicaoTxtCampoTipo.Tipo;
begin
  Result := tipo;
end;

end.
