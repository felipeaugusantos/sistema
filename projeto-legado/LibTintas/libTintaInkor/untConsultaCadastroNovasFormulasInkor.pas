unit untConsultaCadastroNovasFormulasInkor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasInkor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasInkor }

constructor TConsultaCadastroNovasFormulasInkor.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_BASE__', 'Base',              'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto',           'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_BASE__+NFM_PRODUT', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasInkor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasInkor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_BASE__ "Base"            ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   INK_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
