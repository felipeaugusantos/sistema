unit untConsultaCadastroNovasFormulasSalcomix;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSalcomix = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSalcomix }

constructor TConsultaCadastroNovasFormulasSalcomix.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasSalcomix.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSalcomix.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   SAL	_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
