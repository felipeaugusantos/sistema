unit untConsultaCadastroNovasFormulasAdvance;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAdvance = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAdvance }

constructor TConsultaCadastroNovasFormulasAdvance.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_PROKEY', 'Prod. Key',         'LIKE');
  pAdicionar('NFM_SUBKEY', 'Sub. Key',          'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESPRO', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasAdvance.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAdvance.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_PROKEY "Prod. Key"       ' +
    '   , NFM_SUBKEY "Sub. Key"        ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ADVCOR_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
