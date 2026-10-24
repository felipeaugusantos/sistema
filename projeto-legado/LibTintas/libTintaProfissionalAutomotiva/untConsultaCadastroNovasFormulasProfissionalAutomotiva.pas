unit untConsultaCadastroNovasFormulasProfissionalAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasProfissionalAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasProfissionalAutomotiva }

constructor TConsultaCadastroNovasFormulasProfissionalAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCOR', 'Cor', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem', 'LIKE');
  pAdicionar('NFM_LINHA_', 'Linha/Grupo', 'LIKE');
  pAdicionar('AUTOINCREM',  'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESCOR', 'Base/Cor');
end;

destructor TConsultaCadastroNovasFormulasProfissionalAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasProfissionalAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCOR "Cor"            ' +
    '   , NFM_CODBAS "Base"         ' +
    '   , NFM_CODEMB "Embalagem"             ' +
    '   , NFM_LINHA_ "Linha/Grupo"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   PFA_CADNFM                  ';
end;

end.
