unit Contabilidade.Classes.ImportacaoModeloContabilWriter;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis,
  Contabilidade.Classes.ImportacaoModeloContabil;

type
  TImportacaoModeloContabilWriter = class
  private
    FMeta   : TImportacaoModeloContabilMeta;
    FTabelas: TImportacaoModeloContabilTabelaLista;

    procedure pEscreveMeta(AWriter: TStreamWriter);
    procedure pEscreveTabela(AWriter: TStreamWriter;
      ATabela: TImportacaoModeloContabilTabela);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pAdicionarTabela(const AstrNome: string; AFonte: IImportacaoDadosContabeisFonte);

    procedure pSalvarArquivo(const AstrCaminho: string);
    procedure pSalvarStream(AStream: TStream);

    property Meta   : TImportacaoModeloContabilMeta        read FMeta write FMeta;
    property Tabelas: TImportacaoModeloContabilTabelaLista  read FTabelas;
  end;

implementation

{ TImportacaoModeloContabilWriter }

constructor TImportacaoModeloContabilWriter.Create;
begin
  inherited Create;
  FTabelas := TImportacaoModeloContabilTabelaLista.Create(True);

  FMeta.strVersion := CSV_DEFAULT_VERSION;
end;

destructor TImportacaoModeloContabilWriter.Destroy;
begin
  FreeAndNil(FTabelas);
  inherited;
end;

procedure TImportacaoModeloContabilWriter.pAdicionarTabela(
  const AstrNome: string; AFonte: IImportacaoDadosContabeisFonte);
var
  LintCount: Integer;
begin
  // Remove duplicada se existir
  for LintCount := FTabelas.Count - 1 downto 0 do
    if SameText(FTabelas[LintCount].Nome, AstrNome) then
      FTabelas.Delete(LintCount);

  FTabelas.Add(TImportacaoModeloContabilTabela.Create(UpperCase(AstrNome), AFonte));
end;

procedure TImportacaoModeloContabilWriter.pSalvarArquivo(const AstrCaminho: string);
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(AstrCaminho, fmCreate);
  try
    pSalvarStream(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TImportacaoModeloContabilWriter.pSalvarStream(AStream: TStream);
var
  LWriter: TStreamWriter;
  LintCount: Integer;
begin
  LWriter := TStreamWriter.Create(AStream, TEncoding.UTF8);
  try
    //Escreve a linha META
    pEscreveMeta(LWriter);

    //Escreve tabelas
    for LintCount := 0 to FTabelas.Count - 1 do
      pEscreveTabela(LWriter, FTabelas[LintCount]);
  finally
    LWriter.Free;
  end;
end;

procedure TImportacaoModeloContabilWriter.pEscreveMeta(AWriter: TStreamWriter);
begin
  AWriter.WriteLine(CSV_TAG_META + ';VERSION=' + FMeta.strVersion);
end;

procedure TImportacaoModeloContabilWriter.pEscreveTabela(AWriter: TStreamWriter; ATabela: TImportacaoModeloContabilTabela);
var
  LFonte: IImportacaoDadosContabeisFonte;
  LchrSep: Char;
  LintLinha, LintColuna, LintQntLinhas, LintQntColunas, LintLinhaInicio: Integer;
  LstrCelula, LstrLinha, LstrValor: string;
begin
  LFonte := ATabela.Fonte;
  if not Assigned(LFonte) then
    Exit;

  LchrSep       := CSV_DEFAULT_SEPARATOR;
  LintQntLinhas  := LFonte.fQntLinhas;
  LintQntColunas := LFonte.fQntColunas;

  //Pula cabecalho se a fonte tiver
  if LFonte.fTemCabecalho then
    LintLinhaInicio := 1
  else
    LintLinhaInicio := 0;

  //BEGIN_TABLE
  AWriter.WriteLine(CSV_TAG_BEGIN_TABLE + LchrSep + ATabela.Nome);

  //ROW (dados)
  for LintLinha := LintLinhaInicio to LintQntLinhas - 1 do
  begin
    LstrLinha := CSV_TAG_ROW;
    for LintColuna := 0 to LintQntColunas - 1 do
    begin
      LstrValor := LFonte.fGetDadosCelula(LintColuna, LintLinha, LstrCelula);
      LstrLinha := LstrLinha + LchrSep + LstrValor;
    end;
    LstrLinha := LstrLinha + LchrSep + CSV_TAG_END_ROW;
    AWriter.WriteLine(LstrLinha);
  end;

  //END_TABLE
  AWriter.WriteLine(CSV_TAG_END_TABLE);
end;

end.
