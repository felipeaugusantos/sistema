unit untConsultaCadastroNovasFormulasAnjoSintetica;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAnjoSintetica = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAnjoSintetica }

constructor TConsultaCadastroNovasFormulasAnjoSintetica.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODPRO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_PROKEY', 'Prod. Key', 'LIKE');
  pAdicionar('NFM_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODPRO',            'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__+NFM_DESCRI', 'Base/Descrição');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasAnjoSintetica.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAnjoSintetica.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODPRO "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_PROKEY "Prod. Key"       ' +
    '   , NFM_SUBKEY "Sub. Key"        ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   AJA_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
