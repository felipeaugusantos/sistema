unit untConsultaCadastroNovasFormulasAutoluks;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAutoluks = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAutoluks }

constructor TConsultaCadastroNovasFormulasAutoluks.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasAutoluks.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAutoluks.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ALK_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
