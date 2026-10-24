unit untConsultaCadastroNovasFormulasResicolor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasResicolor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasResicolor }

constructor TConsultaCadastroNovasFormulasResicolor.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODPRO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_PROKEY', 'Prod. Key',         'LIKE');
  pAdicionar('NFM_SUBKEY', 'Sub. Key',          'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODPRO',            'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__+NFM_DESCRI', 'Base/Descrição');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasResicolor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasResicolor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODPRO "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_PROKEY "Prod. Key"       ' +
    '   , NFM_SUBKEY "Sub. Key"        ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   RSI_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
