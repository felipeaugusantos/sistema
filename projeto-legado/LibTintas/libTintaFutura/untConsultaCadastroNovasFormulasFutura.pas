unit untConsultaCadastroNovasFormulasFutura;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasFutura = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasFutura }

constructor TConsultaCadastroNovasFormulasFutura.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODPRO', 'Código',            'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto'  ,         'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODPRO+NFM_DESPRO', 'Código/Base');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
  pAdicionarIndice('NFM_PRODUT',            'Produto');
end;

destructor TConsultaCadastroNovasFormulasFutura.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasFutura.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                             ' +
    '     NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_CODPRO "Código"            ' +
    '   , NFM_BASE__ "Base"              ' +
    '   , NFM_UNIDAD "Unidade"           ' +
    '   , NFM_DESCRI "Descrição"         ' +
    '   , NFM_PRODUT "Produto"           ' +
    '   , AUTOINCREM                     ' +
    ' FROM                               ' +
    '   FUT_CADNFM                       ' +
    ' WHERE NFM_UNIDAD = ''QT''          ';
end;

end.
