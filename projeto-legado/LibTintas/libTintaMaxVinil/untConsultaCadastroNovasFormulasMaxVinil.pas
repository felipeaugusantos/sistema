unit untConsultaCadastroNovasFormulasMaxVinil;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasMaxVinil = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasMaxVinil }

constructor TConsultaCadastroNovasFormulasMaxVinil.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base',              'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto',           'LIKE');
  pAdicionar('NFM_COLECA', 'Coleção',           'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_PRODUT', 'Base/Produto');
  pAdicionarIndice('NFM_COLECA',            'Coleção');
end;

destructor TConsultaCadastroNovasFormulasMaxVinil.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasMaxVinil.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_COLECA "Coleção"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   MAX_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
