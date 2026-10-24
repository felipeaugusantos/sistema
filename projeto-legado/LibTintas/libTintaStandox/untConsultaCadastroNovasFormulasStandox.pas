unit untConsultaCadastroNovasFormulasStandox;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasStandox = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasStandox }

constructor TConsultaCadastroNovasFormulasStandox.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasStandox.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasStandox.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   DOX	_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
