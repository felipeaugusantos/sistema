unit untConsultaCadastroNovasFormulasAnjoAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAnjoAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAnjoAutomotiva }

constructor TConsultaCadastroNovasFormulasAnjoAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasAnjoAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAnjoAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   AJT_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
