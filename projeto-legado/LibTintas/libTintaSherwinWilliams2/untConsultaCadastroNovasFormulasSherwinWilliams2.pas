unit untConsultaCadastroNovasFormulasSherwinWilliams2;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSherwinWilliams2 = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSherwinWilliams2 }

constructor TConsultaCadastroNovasFormulasSherwinWilliams2.Create;
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

destructor TConsultaCadastroNovasFormulasSherwinWilliams2.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSherwinWilliams2.fGetSelect(
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
    '   SHW_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
