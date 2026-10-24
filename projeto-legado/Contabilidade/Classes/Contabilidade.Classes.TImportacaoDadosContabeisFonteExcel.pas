unit Contabilidade.Classes.TImportacaoDadosContabeisFonteExcel;

interface

uses
  System.SysUtils, System.Classes,
  untExcel,
  Contabilidade.Classes.TImportacaoDadosContabeis;

type
  TImportacaoDadosContabeisFonteExcel = class(TInterfacedObject, IImportacaoDadosContabeisFonte)
  private
    FobjExcel: TExcel;
    procedure pEnsureObject;
    function fGetLetraAlfa(const AintCol: Integer): string; //1-based
    function fGetCelula(const AintCol, AintRow: Integer): string;
  public
    function fQntLinhas: Integer; //incluindo cabecalho, se tiver
    function fQntColunas: Integer;
    function fTemCabecalho: Boolean;
    function fGetDadosCelula(const AintCol, AintRow: Integer; out AstrCelula: string): string; //coluna e linha sempre 0-based

    class function New(AobjExcel: TExcel): IImportacaoDadosContabeisFonte;
    constructor Create(AobjExcel: TExcel);
  end;

implementation

uses
  untFuncoesSimples;

{ TImportacaoDadosContabeisFonteExcel }

constructor TImportacaoDadosContabeisFonteExcel.Create(AobjExcel: TExcel);
begin
  FobjExcel := AobjExcel;
end;

function TImportacaoDadosContabeisFonteExcel.fGetDadosCelula(const AintCol, AintRow: Integer; out AstrCelula: string): string;
begin
  try
    pEnsureObject;
    AstrCelula := fGetCelula(AintCol, AintRow);
    Result := FobjExcel.Ler_Celula(AstrCelula);
  except
    on EI: EImportacaoDadosContabeis do
      raise;

    on E: Exception do
      raise EImportacaoDadosContabeisExcel.Create(E.Message);
  end;
end;

function TImportacaoDadosContabeisFonteExcel.fGetCelula(const AintCol, AintRow: Integer): string;
var
  LintCol, LintRow: Integer;
begin
  LintCol := AintCol + 1;
  LintRow := AintRow + 1;
  Result := fGetLetraAlfa(LintCol) + LintRow.ToString;
end;

function TImportacaoDadosContabeisFonteExcel.fGetLetraAlfa(const AintCol: Integer): string;
const
  LETRAS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  LintLetra1, LintLetra2: Integer;
  LfltValor : Double;
begin
  If AIntCol > 26 Then
  Begin
    LfltValor  := (AIntCol / 26);
    LintLetra1 := fFloatToInt(LfltValor - Frac(LfltValor));
    LintLetra2 := fFloatToInt(AIntCol Mod 26);

    If LintLetra2 = 0 Then
    Begin
      Dec(LintLetra1);
      LintLetra2 := 26;
    End;

    Result := LETRAS[LintLetra1] + LETRAS[LintLetra2];
  End
  Else
    Result := LETRAS[AIntCol];
end;

function TImportacaoDadosContabeisFonteExcel.fQntColunas: Integer;
var
  LintCol: Integer;
  LstrValor: string;
begin
  { Percorre o cabecalho (linha 1) ate encontrar celula vazia }
  try
    pEnsureObject;
    LintCol := 1;
    repeat
      LstrValor := Trim(FobjExcel.Ler_Celula(fGetLetraAlfa(LintCol) + '1'));
      if LstrValor <> '' then
        Inc(LintCol);
    until LstrValor = '';
    Result := LintCol - 1;
  except
    on EImportacaoDadosContabeis do
      raise;

    on E: Exception do
      raise EImportacaoDadosContabeisExcel.Create(E.Message);
  end;
end;

function TImportacaoDadosContabeisFonteExcel.fQntLinhas: Integer;
begin
  try
    pEnsureObject;

    Result := FobjExcel.MaximodeLinhas ;

  except
    on EImportacaoDadosContabeis do
      raise;

    on E: Exception do
      raise EImportacaoDadosContabeisExcel.Create(E.Message);
  end;
end;

function TImportacaoDadosContabeisFonteExcel.fTemCabecalho: Boolean;
begin
  Result := True;
end;

class function TImportacaoDadosContabeisFonteExcel.New(
  AobjExcel: TExcel): IImportacaoDadosContabeisFonte;
begin
  Result := Self.Create(AobjExcel);
end;

procedure TImportacaoDadosContabeisFonteExcel.pEnsureObject;
begin
  if not Assigned(FobjExcel) then
    raise EImportacaoDadosContabeisExcel.Create('Erro interno: Objeto Excel nulo.');
end;

end.
