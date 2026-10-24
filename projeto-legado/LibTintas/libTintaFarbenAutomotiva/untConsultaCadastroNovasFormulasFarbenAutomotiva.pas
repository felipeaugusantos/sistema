unit untConsultaCadastroNovasFormulasFarbenAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasFarbenAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasFarbenAutomotiva }

constructor TConsultaCadastroNovasFormulasFarbenAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasFarbenAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasFarbenAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   FAR	_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
