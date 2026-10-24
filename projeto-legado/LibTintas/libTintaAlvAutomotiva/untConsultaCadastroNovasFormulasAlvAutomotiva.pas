unit untConsultaCadastroNovasFormulasAlvAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAlvAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAlvAutomotiva }

constructor TConsultaCadastroNovasFormulasAlvAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Cor', 'LIKE');
  pAdicionar('NFM_SYSTEM', 'Sistema', 'LIKE');
  pAdicionar('NFM_TECNOL', 'Tecnologia', 'LIKE');
  pAdicionar('NFM_TONALI', 'Tonalidade', 'LIKE');
  pAdicionar('AUTOINCREM',  'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
end;

destructor TConsultaCadastroNovasFormulasAlvAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAlvAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_DESCRI "Cor"             ' +
    '   , NFM_SYSTEM "Sistema"         ' +
    '   , NFM_TECNOL "Tecnologia"      ' +
    '   , NFM_TONALI "Tonalidade"      ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ALA_CADNFM                     ';
end;

end.
