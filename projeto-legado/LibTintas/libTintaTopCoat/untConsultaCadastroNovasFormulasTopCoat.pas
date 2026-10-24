unit untConsultaCadastroNovasFormulasTopCoat;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasTopCoat = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasTopCoat }

constructor TConsultaCadastroNovasFormulasTopCoat.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasTopCoat.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasTopCoat.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   COA_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
