unit untConsultaCadastroNovasFormulasSuvinil;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSuvinil = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSuvinil }

constructor TConsultaCadastroNovasFormulasSuvinil.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODPRO', 'Código', 'LIKE');
  pAdicionar('NFM_DTACAD', 'Data Cadastro', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__', 'Base');
  pAdicionarIndice('NFM_DTACAD', 'Data Cadastro');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
  pAdicionarIndice('NFM_CODPRO', 'Código');
  pAdicionarIndice('NFM_UNIDAD', 'Unidade');
end;

destructor TConsultaCadastroNovasFormulasSuvinil.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSuvinil.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_CODPRO "Código"          ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_DTACAD "Data Cadastro"   ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   SUV_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
