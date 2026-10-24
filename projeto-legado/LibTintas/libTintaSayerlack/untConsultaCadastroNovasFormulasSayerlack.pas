unit untConsultaCadastroNovasFormulasSayerlack;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSayerlack = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSayerlack }

constructor TConsultaCadastroNovasFormulasSayerlack.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto',           'LIKE');
  pAdicionar('NFM_C_O_R_', 'Cor',         'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__+NFM_PRODUT', 'Base/Produto');
end;

destructor TConsultaCadastroNovasFormulasSayerlack.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSayerlack.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_C_O_R_ "Cor"             ' +
    '   , NFM_CODEMB "Embalagem"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   SAY_CADNFM                  ';
end;

end.
