unit untConsultaCadastroNovasFormulasAlterPlus;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAlterPlus = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAlterPlus }

constructor TConsultaCadastroNovasFormulasAlterPlus.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS', 'Base');
end;

destructor TConsultaCadastroNovasFormulasAlterPlus.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAlterPlus.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_CODUNI "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ALP_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
