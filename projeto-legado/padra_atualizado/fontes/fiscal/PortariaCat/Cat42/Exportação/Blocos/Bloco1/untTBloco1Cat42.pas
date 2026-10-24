unit untTBloco1Cat42;

interface

uses untTParticipantesPresentesLfe, untTItensPresentesLfe, untTBlocoBaseCat42, untTDadosBloco1Cat42,
     untTRegistroBaseCat42, untTRegistro1050Cat42, untTRegistro1100Cat42, untTRegistro1200Cat42, untTRepositorioDadosBloco1Cat42,
     untTDadosAberturaExportacaoCat42;

type
  TBloco1 = class(TBlocoBase)
  private
    FParticipantesPresentes: TParticipantesPresentes;
    FRepositorio: TRepositorioDadosBloco1Cat42;
    FItensPresentes: TItensPresentes;
    FDados: TDadosBloco1Cat42; //obj que carrega as notas utilizadas e os saldos

    procedure pCriarRegistro1050;
    procedure pCriarRegistro1100;
    procedure pCriarRegistro1200;

    procedure pCarregarDados;
  protected
    procedure pCriarRegistros; override;
    procedure pGerarRegistros; override;
  public
    procedure pGerar; override;

    constructor create(abertura: TDadosAberturaExportacaoCat42);
    Destructor Destroy; override;

    property participantesPresentes: TParticipantesPresentes read FParticipantesPresentes write FParticipantesPresentes;
    property itensPresentes: TItensPresentes read FItensPresentes write FItensPresentes;
  end;

implementation

{ TBloco1 }

constructor TBloco1.create(abertura: TDadosAberturaExportacaoCat42);
begin
  inherited create(abertura);
  FRepositorio := TRepositorioDadosBloco1Cat42.Create;
end;

destructor TBloco1.Destroy;
begin
  FRepositorio.Free;

  inherited;
end;

procedure TBloco1.pCarregarDados;
begin
  FDados := FRepositorio.fRetDados(abertura);
end;

procedure TBloco1.pCriarRegistro1050;
  var
    registro1050: TRegistro1050;
begin
  registro1050 := TRegistro1050.Create(stlArquivo, abertura);
  registro1050.itensPresentes := FItensPresentes;
  registro1050.listaDados := FDados.listaSaldo;
  registro1050.strTipoRegistro := '1050';
  registro1050.intOrdemGeracao := 1;

  listaRegistros.Add(registro1050);
end;

procedure TBloco1.pCriarRegistro1100;
  var
    registro1100: TRegistro1100;
begin
  registro1100 := TRegistro1100.Create(stlArquivo, abertura);
  registro1100.participantesPresentes := FParticipantesPresentes;
  registro1100.itensPresentes := FItensPresentes;
  registro1100.listaDados := FDados.listaNotas;
  registro1100.strTipoRegistro := '1100';
  registro1100.intOrdemGeracao := 2;

  listaRegistros.Add(registro1100);
end;

procedure TBloco1.pCriarRegistro1200;
  var
    registro1200: TRegistro1200;
begin
  registro1200 := TRegistro1200.Create(stlArquivo, abertura);
  registro1200.participantesPresentes := FParticipantesPresentes;
  registro1200.itensPresentes := FItensPresentes;
  registro1200.listaDados := FDados.listaNotas;
  registro1200.strTipoRegistro := '1200';
  registro1200.intOrdemGeracao := 3;

  listaRegistros.Add(registro1200);
end;

procedure TBloco1.pCriarRegistros;
begin
  inherited;

  pCriarRegistro1050;
  pCriarRegistro1100;
  pCriarRegistro1200;
end;

procedure TBloco1.pGerar;
begin
  inherited;

  abertura.lblOperacao.Visible := True;
  abertura.lblOperacao.Caption := 'Gerando bloco 1...';

  pCarregarDados;

  pCriarRegistros;
  pGerarRegistros;
end;

procedure TBloco1.pGerarRegistros;
  var
    registro: TRegistroBase;
begin
  for registro in listaRegistros do
  begin
    registro.pGerar;

    intQuantidadeRegistrosBloco := intQuantidadeRegistrosBloco +
                                   registro.intQuantidadeGerada +
                                   registro.intQuantidadeSubRegistros;
  end;
end;

end.
