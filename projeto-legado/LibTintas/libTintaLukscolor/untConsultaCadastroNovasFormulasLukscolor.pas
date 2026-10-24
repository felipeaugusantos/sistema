unit untConsultaCadastroNovasFormulasLukscolor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasLukscolor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasLukscolor }

constructor TConsultaCadastroNovasFormulasLukscolor.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODPRO', 'Código Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('NFM_PROKEY', 'Prod. Key',         'LIKE');
  pAdicionar('NFM_SUBKEY', 'Sub. Key',          'LIKE');
  pAdicionar('NFM_QTDEMB', 'Quantidade',        'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODPRO',            'Código Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESPRO', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
  pAdicionarIndice('NFM_PROKEY', 'Prod. Key');
  pAdicionarIndice('NFM_SUBKEY', 'Sub. Key');
  pAdicionarIndice('NFM_QTDEMB', 'Quantidade');
end;

destructor TConsultaCadastroNovasFormulasLukscolor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasLukscolor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODPRO "Código Fórmula"    ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , NFM_PROKEY "Prod. Key"       ' +
    '   , NFM_SUBKEY "Sub. Key"        ' +
    '   , NFM_QTDEMB "Quantidade"      ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   LKD_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
