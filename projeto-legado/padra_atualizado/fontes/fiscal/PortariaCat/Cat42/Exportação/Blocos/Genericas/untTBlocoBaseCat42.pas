unit untTBlocoBaseCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTRegistroBaseCat42,
     untTRepositorioLfe,
     Classes;

type
  TBlocoBase = class
  private
    FListaRegistros: TObjectList<TRegistroBase>; //lista de registros para geração do método abstrato "pGerar"
    FAbertura: TDadosAberturaExportacaoCat42;
    FQuantidadeRegistrosBloco: integer;
    FOrdemCapturaDadosBloco: Integer;
    FOrdemGeracaoBloco: Integer;
    FArquivo: TStringList;
  protected
    procedure pCriarRegistros; virtual; abstract;
    procedure pGerarRegistros; virtual; abstract;
  public
    procedure pGerar; virtual; abstract;

    constructor Create(abertura: TDadosAberturaExportacaoCat42);
    destructor Destroy; override;

    property intQuantidadeRegistrosBloco: integer read FQuantidadeRegistrosBloco write FQuantidadeRegistrosBloco;
    property intOrdemCapturaDadosBloco: Integer read FOrdemCapturaDadosBloco write FOrdemCapturaDadosBloco;
    property listaRegistros: TObjectList<TRegistroBase> read FListaRegistros write FListaRegistros;
    property intOrdemGeracaoBloco: Integer read FOrdemGeracaoBloco write FOrdemGeracaoBloco;
    property abertura: TDadosAberturaExportacaoCat42 read FAbertura write FAbertura;
    property stlArquivo: TStringList read FArquivo write FArquivo;
  end;

implementation

{ TBlocoBase }

constructor TBlocoBase.Create(abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create;

  FListaRegistros := TObjectList<TRegistroBase>.Create;
  FQuantidadeRegistrosBloco := 0;
  FArquivo := TStringList.Create;
  FAbertura := abertura;
end;

destructor TBlocoBase.Destroy;
begin
  FListaRegistros.Free;
  FArquivo.Free;

  inherited;
end;

end.
