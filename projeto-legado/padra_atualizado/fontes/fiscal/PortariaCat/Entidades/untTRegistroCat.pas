unit untTRegistroCat;

interface

uses System.Generics.Collections, untTNotaFiscal, untTItemNotaFiscal, untTProduto;

type
  TRegistroCat = class
  private
    FNotasCreditar: TObjectList<TNotaFiscal>;
    FDataNotaDadosGerais: TDateTime;
    FItemNota: TItemNotaFiscal;
    FEnquadramento: string;
    FCodigoProduto: string;
    FOrdemGeracao: integer;
  public
    constructor Create;
    destructor Destroy; override;

    property notasCreditar: TObjectList<TNotaFiscal> read FNotasCreditar write FNotasCreditar;
    property dtaDataNotaDadosGerais: TDateTime read FDataNotaDadosGerais write FDataNotaDadosGerais;
    property itemNota: TItemNotaFiscal read FItemNota write FItemNota;
    property strEnquadramento: string read FEnquadramento write FEnquadramento;
    property strCodigoProduto: string read FCodigoProduto write FCodigoProduto;
    property intOrdemGeracao: integer read FOrdemGeracao write FOrdemGeracao;
  end;

implementation

{ TRegistroCat }

constructor TRegistroCat.Create;
begin
  inherited create;

  FItemNota := TItemNotaFiscal.Create;
end;

destructor TRegistroCat.Destroy;
begin
  FItemNota.Free;

  inherited;
end;

end.
