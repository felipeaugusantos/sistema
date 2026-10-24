unit untConsultaCadastroNovasFormulasSparlack;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasSparlack = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasSparlack }

constructor TConsultaCadastroNovasFormulasSparlack.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_REFERE', 'Referência', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS', 'Base');
end;

destructor TConsultaCadastroNovasFormulasSparlack.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasSparlack.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_REFERE "Referência"         ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_CODUNI "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   SPA_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
