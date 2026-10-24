unit untConsultaCadastroNovasFormulasInternational;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasInternational = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasInternational }

constructor TConsultaCadastroNovasFormulasInternational.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCOR', 'Cor', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem', 'LIKE');
  pAdicionar('NFM_LINHA_', 'Linha/Grupo', 'LIKE');
  pAdicionar('AUTOINCREM',  'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESCOR', 'Base/Cor');
end;

destructor TConsultaCadastroNovasFormulasInternational.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasInternational.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_DESCOR "Cor"            ' +
    '   , NFM_CODBAS "Base"         ' +
    '   , NFM_CODEMB "Embalagem"             ' +
    '   , NFM_LINHA_ "Linha/Grupo"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   INT_CADNFM                  ';
end;

end.
