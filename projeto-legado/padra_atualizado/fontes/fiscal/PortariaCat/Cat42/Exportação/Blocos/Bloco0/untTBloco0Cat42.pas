unit untTBloco0Cat42;

interface

uses System.Generics.Collections,
     untTDadosAberturaExportacaoCat42,
     untTParticipantesPresentesLfe,
     untTRepositorioLfeFactory,
     untTRegistroBaseCat42,
     untTRegistro0000Cat42,
     untTRegistro0150Cat42,
     untTRegistro0200Cat42,
     untTItensPresentesLfe,
     untTBlocoBaseCat42,
     untTRepositorioLfe,
     untTParticipante,
     untTProduto;

type
  TBloco0 = class(TBlocoBase)
  private
    FParticipantesPresentes: TParticipantesPresentes;
    FListaParticipantes: TObjectList<TParticipante>;
    FListaProdutos: TObjectList<TProduto>;
    FItensPresentes: TItensPresentes;
    FRepositorio: TRepositorio;

    procedure pCarregarListaParticipantes;
    procedure pCarregarListaProdutos;

    procedure pCriarRegistro0000;
    procedure pCriarRegistro0150;
    procedure pCriarRegistro0200;
  protected
    procedure pCriarRegistros; override;
    procedure pGerarRegistros; override;
  public
    procedure pGerar; override;

    constructor create(abertura: TDadosAberturaExportacaoCat42);
    destructor Destroy; override;

    property participantesPresentes: TParticipantesPresentes read FParticipantesPresentes write FParticipantesPresentes;
    property itensPresentes: TItensPresentes read FItensPresentes write FItensPresentes;
  end;

implementation

{ TBloco0 }

constructor TBloco0.create(abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create(abertura);

  FRepositorio := TRepositorioLfeFactory.fRetRepositorio(abertura);
end;

destructor TBloco0.Destroy;
begin

  inherited;
end;

procedure TBloco0.pCarregarListaParticipantes;
begin
  FListaParticipantes := FRepositorio.participantes.fRetTodosParticipantes(FParticipantesPresentes.listaParticipantes, abertura.empresa.strCNPJ, True);
end;

procedure TBloco0.pCarregarListaProdutos;
begin
  FListaProdutos := FRepositorio.produtos.fRetTodosProdutos(abertura.empresa.strCodigo, FItensPresentes.listaItens, True);
end;

procedure TBloco0.pCriarRegistro0000;
  var
    registro0000: TRegistro0000;
begin
  registro0000 := TRegistro0000.Create(stlArquivo, abertura);
  registro0000.strTipoRegistro := '0000';
  registro0000.intOrdemGeracao := 1;

  listaRegistros.Add(registro0000);
end;

procedure TBloco0.pCriarRegistro0150;
  var
    registro0150: TRegistro0150;
begin
  registro0150 := TRegistro0150.Create(stlArquivo, abertura);
  registro0150.listaParticipantes := FListaParticipantes;
  registro0150.strTipoRegistro := '0150';
  registro0150.intOrdemGeracao := 2;

  listaRegistros.Add(registro0150);
end;

procedure TBloco0.pCriarRegistro0200;
  var
    registro0200: TRegistro0200;
begin
  registro0200 := TRegistro0200.Create(stlArquivo, abertura);
  registro0200.strTipoRegistro := '0200';
  registro0200.intOrdemGeracao := 3;
  registro0200.listaProdutos := FListaProdutos;

  listaRegistros.Add(registro0200);
end;

procedure TBloco0.pCriarRegistros;
begin
  inherited;

  pCriarRegistro0000;
  pCriarRegistro0150;
  pCriarRegistro0200;
end;

procedure TBloco0.pGerar;
begin
  inherited;

  abertura.lblOperacao.Visible := True;
  abertura.lblOperacao.Caption := 'Gerando bloco 0...';

  //carrega a lista de participantes antes da geração
  pCarregarListaParticipantes;

  //carrega a lista de produtos antes da geração
  pCarregarListaProdutos;

  pCriarRegistros;
  pGerarRegistros;
end;

procedure TBloco0.pGerarRegistros;
  var
    registro: TRegistroBase;
begin
  for registro in listaRegistros do
  begin
    registro.pGerar;
  end;
end;

end.
