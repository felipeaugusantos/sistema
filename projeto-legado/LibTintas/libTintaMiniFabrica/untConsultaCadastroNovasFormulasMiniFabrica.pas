unit untConsultaCadastroNovasFormulasMiniFabrica;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasMiniFabrica = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasMiniFabrica }

constructor TConsultaCadastroNovasFormulasMiniFabrica.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO', 'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI', 'Descrição');
end;

destructor TConsultaCadastroNovasFormulasMiniFabrica.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasMiniFabrica.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   MIF_CADNFM                     ' +
    ' WHERE TRUE                       ';
end;

end.
