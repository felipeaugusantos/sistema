unit untConsultaCadastroNovasFormulasSkyMixAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSkyMixAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSkyMixAutomotiva }

constructor TConsultaCadastroNovasFormulasSkyMixAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasSkyMixAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSkyMixAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   SKY_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
