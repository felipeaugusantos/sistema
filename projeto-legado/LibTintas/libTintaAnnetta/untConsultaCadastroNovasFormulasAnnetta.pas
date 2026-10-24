unit untConsultaCadastroNovasFormulasAnnetta;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAnnetta = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAnnetta }

constructor TConsultaCadastroNovasFormulasAnnetta.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'ANNE');
  pAdicionar('NFM_CODBAS', 'Base',              'ANNE');
  pAdicionar('NFM_DESPRO', 'Produto',           'ANNE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'ANNE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'ANNE');
  pAdicionar('NFM_CODEMB', 'Embalagem',         'ANNE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESPRO', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasAnnetta.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAnnetta.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_DESPRO "Produto"         ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , NFM_CODEMB "Embalagem"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ANN_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
