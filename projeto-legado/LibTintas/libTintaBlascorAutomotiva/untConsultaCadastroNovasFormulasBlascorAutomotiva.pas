unit untConsultaCadastroNovasFormulasBlascorAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasBlascorAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasBlascorAutomotiva }

constructor TConsultaCadastroNovasFormulasBlascorAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasBlascorAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasBlascorAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   BLA_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
