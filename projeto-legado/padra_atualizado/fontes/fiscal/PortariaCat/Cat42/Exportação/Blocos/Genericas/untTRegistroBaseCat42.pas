unit untTRegistroBaseCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     Classes;

type
  TRegistroBase = class
  private
    FAbertura: TDadosAberturaExportacaoCat42;
    FQuantidadeSubRegistros: integer;
    FQuantidadeGerada: Integer;
    FOrdemGeracao: integer;
    FTipoRegistro: String;
    FArquivo: TStringList;
    FLinha: String;
  public
    procedure pGerar; virtual; abstract;

    procedure pCampo(strValor: string; blnPipe: boolean = true);
    procedure pInicializaLinha;
    procedure pAdicionaLista;

    constructor create(stlArquivo: TStringList; abertura: TDadosAberturaExportacaoCat42);

    property abertura: TDadosAberturaExportacaoCat42 read FAbertura write FAbertura;
    property intQuantidadeSubRegistros: integer read FQuantidadeSubRegistros write FQuantidadeSubRegistros;
    property intQuantidadeGerada: Integer read FQuantidadeGerada write FQuantidadeGerada;
    property intOrdemGeracao: integer read FOrdemGeracao write FOrdemGeracao;
    property strTipoRegistro: String read FTipoRegistro write FTipoRegistro;
    property stlArquivo: TStringList read FArquivo write FArquivo;
  end;

implementation

uses untFuncoes;

{ TRegistroBase }

constructor TRegistroBase.create(stlArquivo: TStringList; abertura: TDadosAberturaExportacaoCat42);
begin
  FQuantidadeSubRegistros := 0;
  FQuantidadeGerada := 0;
  FArquivo := stlArquivo;
  FAbertura := abertura;
end;

procedure TRegistroBase.pAdicionaLista;
begin
  FArquivo.Add(FLinha);
end;

procedure TRegistroBase.pCampo(strValor: string; blnPipe: boolean = true);
begin
  FLinha := FLinha + strValor + IIF(blnPipe, '|', '');
end;

procedure TRegistroBase.pInicializaLinha;
begin
  FLinha := '';
end;

end.
