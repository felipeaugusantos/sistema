unit untGenericFatFormulacao;

interface

uses
  untIFatFormulacao;

type
  TGenericFatFormulacao = class(TInterfacedObject, IFatFormulacao)
  protected
    strIdePro: string;
  public
    function GetIdePro: string;
    function GetNomeTabelaFormulacao: string;
    function GetQtdCampos: Integer;
    constructor Create(const strIdePro: string); reintroduce;
  end;

implementation

{ TGenericFatFormulacao }

constructor TGenericFatFormulacao.Create(const strIdePro: string);
begin
  inherited Create();
  Self.strIdePro := strIdePro;
end;

function TGenericFatFormulacao.GetIdePro: string;
begin
  Result := strIdePro;
end;

function TGenericFatFormulacao.GetNomeTabelaFormulacao: string;
begin
  Result := 'TMP_FORMULACAO' + strIdePro;
end;

function TGenericFatFormulacao.GetQtdCampos: Integer;
begin
  Result := 15;
end;

end.
