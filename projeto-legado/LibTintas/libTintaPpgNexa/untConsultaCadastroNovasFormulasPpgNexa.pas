unit untConsultaCadastroNovasFormulasPpgNexa;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasPpgNexa = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasPpgNexa }

constructor TConsultaCadastroNovasFormulasPpgNexa.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasPpgNexa.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasPpgNexa.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   PPX_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
