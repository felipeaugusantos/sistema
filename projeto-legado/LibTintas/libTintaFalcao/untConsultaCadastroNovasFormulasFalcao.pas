unit untConsultaCadastroNovasFormulasFalcao;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasFalcao = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasFalcao }

constructor TConsultaCadastroNovasFormulasFalcao.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__', 'Base');
end;

destructor TConsultaCadastroNovasFormulasFalcao.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasFalcao.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_CODUNI "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   FAL_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
