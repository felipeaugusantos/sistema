unit untConsultaCadastroNovasFormulasMazaImobiliaria;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasMazaImobiliaria = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasMazaImobiliaria }

constructor TConsultaCadastroNovasFormulasMazaImobiliaria.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_COLNAM', 'Descrição', 'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS', 'Base');
end;

destructor TConsultaCadastroNovasFormulasMazaImobiliaria.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasMazaImobiliaria.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_COLNAM "Descrição"       ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_CODUNI "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   MZI_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
