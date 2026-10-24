unit untConsultaCadastroNovasFormulasQualyVinil;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasQualyVinil = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasQualyVinil }

constructor TConsultaCadastroNovasFormulasQualyVinil.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base', 'LIKE');
  pAdicionar('NFM_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__', 'Base');
end;

destructor TConsultaCadastroNovasFormulasQualyVinil.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasQualyVinil.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_CODUNI "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   QUA_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
