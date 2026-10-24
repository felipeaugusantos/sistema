unit untConsultaCadastroNovasFormulasCiacollor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasCiacollor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasCiacollor }

constructor TConsultaCadastroNovasFormulasCiacollor.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__', 'Base');
end;

destructor TConsultaCadastroNovasFormulasCiacollor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasCiacollor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   CIA_CADNFM                     ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
