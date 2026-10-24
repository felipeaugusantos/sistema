unit untConsultaCadastroNovasFormulasCalamar;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasCalamar = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasCalamar }

constructor TConsultaCadastroNovasFormulasCalamar.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base',              'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto',           'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_PRODUT', 'Base/Produto');
end;

destructor TConsultaCadastroNovasFormulasCalamar.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasCalamar.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_CODEMB "Embalagem"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   CAL_CADNFM                  ';
end;

end.
