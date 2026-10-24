unit untTAbstractCarregaNF;

interface

uses Generics.Collections,
     untTItemNotaFiscal,
     untTDadosAbertura,
     untICarregaNF,
     Classes,
     Uni;

type
  TAbstractCarregaNF = class(TInterfacedObject, ICarregaNF)
  private
    FListaItensNota: TObjectList<TItemNotaFiscal>;
    FDadosAbertura: TDadosAbertura;
    FDados: TUniQuery;
  public
    function fCarregar(strItemSubstituido: string): TObjectList<TItemNotaFiscal>; virtual; abstract;

    property listaItensNota: TObjectList<TItemNotaFiscal> read FListaItensNota write FListaItensNota;
    property dadosAbertura: TDadosAbertura read FDadosAbertura;
    property dados: TUniQuery read FDados write FDados;

    constructor create(dadosAbertura: TDadosAbertura);
    destructor Destroy; override;
  end;

implementation

uses untFuncoesSimples,
     untIFuncoes;

{ TAbstractCarregaNF }

constructor TAbstractCarregaNF.create(dadosAbertura: TDadosAbertura);
begin
  inherited create;

  FListaItensNota := TObjectList<TItemNotaFiscal>.Create;
  FDadosAbertura := dadosAbertura;
  FDados := fCriaQuery(nil);
end;

destructor TAbstractCarregaNF.Destroy;
begin
  FListaItensNota.Free;
  FDados.Free;
  inherited;
end;

end.
