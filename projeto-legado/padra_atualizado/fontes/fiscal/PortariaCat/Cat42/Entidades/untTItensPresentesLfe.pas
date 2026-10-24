unit untTItensPresentesLfe;

interface

uses Classes;

type
  TItensPresentes = class
  private
    FListaItens: TStringList;
  public
    constructor create;
    destructor Destroy; override;

    property listaItens: TStringList read FListaItens write FListaItens;
  end;

implementation

{ TItensPresentes }

constructor TItensPresentes.create;
begin
  FListaItens := TStringList.Create;
  FListaItens.Clear;
end;

destructor TItensPresentes.Destroy;
begin
  FListaItens.Free;
  inherited;
end;

end.
