unit untConsultaCadastroNovasFormulasKilling;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasKilling = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasKilling }

constructor TConsultaCadastroNovasFormulasKilling.Create;
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

destructor TConsultaCadastroNovasFormulasKilling.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasKilling.fGetSelect(
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
    '   KILD_CADNFM                     ' +
    ' WHERE NFM_CODUNI = ''LT''        ';
end;

end.
