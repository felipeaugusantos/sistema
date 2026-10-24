unit untTExportacaoCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTParticipantesPresentesLfe,
     System.Generics.Defaults,
     untTItensPresentesLfe,
     untTBlocoBaseCat42,
     untTDadosAbertura,
     untTBloco0Cat42,
     untTBloco1Cat42,
     StrUtils,
     Classes;

type
  TExportacaoCat42 = class
  private
    FParticipantesPresentes: TParticipantesPresentes;
    FAbertura: TDadosAberturaExportacaoCat42;
    FListaBlocos: TObjectList<TBlocoBase>;
    FItensPresentes: TItensPresentes;
    FArquivo: TStringList;

    function fRetOrdenaBlocosCapturaDados: IComparer<TBlocoBase>;
    function fRetOrdenaBlocosGeracao: IComparer<TBlocoBase>;

    procedure pCriarBloco0;
    procedure pCriarBloco1;

    procedure pGravarDadosExportacao;
    procedure pCriarBlocos;
    procedure pGerarBlocos;
  public
    procedure pGerarArquivo;

    constructor create(abertura: TDadosAberturaExportacaoCat42; stlArquivo: TStringList);
    destructor Destroy; override;
  end;

implementation

{ TExportacaoCat42 }

constructor TExportacaoCat42.create(abertura: TDadosAberturaExportacaoCat42; stlArquivo: TStringList);
begin
  inherited create;

  FParticipantesPresentes := TParticipantesPresentes.Create;
  FListaBlocos := TObjectList<TBlocoBase>.Create;
  FItensPresentes := TItensPresentes.Create;
  FArquivo := stlArquivo;
  FAbertura := abertura;
end;

destructor TExportacaoCat42.Destroy;
begin
  FParticipantesPresentes.Free;
  FItensPresentes.Free;
  FListaBlocos.Free;

  inherited;
end;

function TExportacaoCat42.fRetOrdenaBlocosCapturaDados: IComparer<TBlocoBase>;
  var
    criterioComparacao: TComparison<TBlocoBase>;
begin
  criterioComparacao := function(const L: TBlocoBase; const R: TBlocoBase): Integer
                        begin
                          Result := Trunc(Int(L.intOrdemCapturaDadosBloco) - Int(R.intOrdemCapturaDadosBloco));
                        end;

  Result := TComparer<TBlocoBase>.Construct(criterioComparacao);
end;

function TExportacaoCat42.fRetOrdenaBlocosGeracao: IComparer<TBlocoBase>;
  var
    criterioComparacao: TComparison<TBlocoBase>;
begin
  criterioComparacao := function(const L: TBlocoBase; const R: TBlocoBase): Integer
                        begin
                          Result := Trunc(Int(L.intOrdemGeracaoBloco) - Int(R.intOrdemGeracaoBloco));
                        end;

  Result := TComparer<TBlocoBase>.Construct(criterioComparacao);
end;

procedure TExportacaoCat42.pCriarBloco0;
  var
    bloco0: TBloco0;
begin
  bloco0 := TBloco0.Create(FAbertura);
  bloco0.participantesPresentes := FParticipantesPresentes;
  bloco0.itensPresentes := FItensPresentes;
  bloco0.intOrdemCapturaDadosBloco := 1;
  bloco0.intOrdemGeracaoBloco := 2;

  FListaBlocos.Add(bloco0);
end;

procedure TExportacaoCat42.pCriarBloco1;
  var
    bloco1: TBloco1;
begin
  bloco1 := TBloco1.Create(FAbertura);
  bloco1.participantesPresentes := FParticipantesPresentes;
  bloco1.itensPresentes := FItensPresentes;
  bloco1.intOrdemCapturaDadosBloco := 2;
  bloco1.intOrdemGeracaoBloco := 1;

  FListaBlocos.Add(bloco1);
end;

procedure TExportacaoCat42.pCriarBlocos;
begin
  pCriarBloco0;
  pCriarBloco1;
end;

procedure TExportacaoCat42.pGerarArquivo;
begin
  pCriarBlocos;
  pGerarBlocos;
  pGravarDadosExportacao;
end;

procedure TExportacaoCat42.pGerarBlocos;
  var
    bloco: TBlocoBase;
begin
  FListaBlocos.Sort(fRetOrdenaBlocosGeracao);

  for bloco in FListaBlocos do
  begin
    bloco.pGerar;
  end;
end;

procedure TExportacaoCat42.pGravarDadosExportacao;
  var
    bloco: TBlocoBase;
begin
  FAbertura.lblOperacao.Caption := 'Unificando os arquivos...';

  FListaBlocos.Sort(fRetOrdenaBlocosCapturaDados);

  for bloco in FListaBlocos do
  begin
    FArquivo.Text := FArquivo.Text + bloco.stlArquivo.Text;
  end;

  if FArquivo.Count > 1 then
    FArquivo.SaveToFile(FAbertura.strPath + '\' + FAbertura.empresa.strCodigo + '_CAT42_' + AnsiReplaceStr(FAbertura.strMesAno, '/', '') + '.txt');
end;

end.
