unit untConsultaCadastroNovasFormulasRennerIndustrial;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasRennerIndustrial = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasRennerIndustrial }

constructor TConsultaCadastroNovasFormulasRennerIndustrial.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'RENE');
  pAdicionar('NFM_CODBAS', 'Base',              'RENE');
  pAdicionar('NFM_DESPRO', 'Produto',           'RENE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'RENE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'RENE');
  pAdicionar('NFM_CODEMB', 'Embalagem',         'RENE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESPRO', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasRennerIndustrial.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasRennerIndustrial.fGetSelect(
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
    '   REN_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
