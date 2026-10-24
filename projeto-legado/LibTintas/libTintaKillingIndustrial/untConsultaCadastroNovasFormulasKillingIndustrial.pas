unit untConsultaCadastroNovasFormulasKillingIndustrial;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasKillingIndustrial = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasKillingIndustrial }

constructor TConsultaCadastroNovasFormulasKillingIndustrial.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasKillingIndustrial.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasKillingIndustrial.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   KIN_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
