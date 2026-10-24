unit Contabilidade.Classes.TImportacaoDadosContabeisFonteStream;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Contabilidade.Classes.TImportacaoDadosContabeis;

type
  TImportacaoDadosContabeisFonteStream = class(TInterfacedObject, IImportacaoDadosContabeisFonte)
  private
    FLinhas: TList<TArray<string>>;
    FintQntColunas: Integer;
  public
    function fQntLinhas: Integer;
    function fQntColunas: Integer;
    function fTemCabecalho: Boolean;
    function fGetDadosCelula(const AintCol, AintRow: Integer; out AstrCelula: string): string;

    procedure pAdicionarLinha(const AarrCampos: TArray<string>);
    procedure pLimpar;

    class function New: IImportacaoDadosContabeisFonte;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TImportacaoDadosContabeisFonteStream }

constructor TImportacaoDadosContabeisFonteStream.Create;
begin
  FLinhas := TList<TArray<string>>.Create;
  FintQntColunas := 0;
end;

destructor TImportacaoDadosContabeisFonteStream.Destroy;
begin
  FreeAndNil(FLinhas);
  inherited;
end;

procedure TImportacaoDadosContabeisFonteStream.pAdicionarLinha(const AarrCampos: TArray<string>);
var
  LintColunas: Integer;
begin
  { Adiciona uma linha de dados e atualiza a quantidade de colunas se necessario }
  LintColunas := Length(AarrCampos);
  if LintColunas > FintQntColunas then
    FintQntColunas := LintColunas;

  FLinhas.Add(AarrCampos);
end;

procedure TImportacaoDadosContabeisFonteStream.pLimpar;
begin
  FLinhas.Clear;
  FintQntColunas := 0;
end;

function TImportacaoDadosContabeisFonteStream.fQntLinhas: Integer;
begin
  Result := FLinhas.Count;
end;

function TImportacaoDadosContabeisFonteStream.fQntColunas: Integer;
begin
  Result := FintQntColunas;
end;

function TImportacaoDadosContabeisFonteStream.fTemCabecalho: Boolean;
begin
  { Dados vindos de stream/CSV nao possuem cabecalho - a ordem das colunas e definida em codigo }
  Result := False;
end;

function TImportacaoDadosContabeisFonteStream.fGetDadosCelula(
  const AintCol, AintRow: Integer; out AstrCelula: string): string;
var
  LarrLinha: TArray<string>;
begin
  { Valida limites de linha }
  if (AintRow < 0) or (AintRow >= FLinhas.Count) then
    raise EImportacaoDadosContabeis.CreateFmt(
      'Linha %d fora do intervalo (0..%d).', [AintRow, FLinhas.Count - 1]);

  LarrLinha := FLinhas[AintRow];

  { Valida limites de coluna }
  if (AintCol < 0) or (AintCol >= Length(LarrLinha)) then
    raise EImportacaoDadosContabeis.CreateFmt(
      'Coluna %d fora do intervalo (0..%d) na linha %d.', [AintCol, Length(LarrLinha) - 1, AintRow]);

  AstrCelula := '(' + IntToStr(AintCol) + ',' + IntToStr(AintRow) + ')';
  Result := LarrLinha[AintCol];
end;

class function TImportacaoDadosContabeisFonteStream.New: IImportacaoDadosContabeisFonte;
begin
  Result := Self.Create;
end;

end.
