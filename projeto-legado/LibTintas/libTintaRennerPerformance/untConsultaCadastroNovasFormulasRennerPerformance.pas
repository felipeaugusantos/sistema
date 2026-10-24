unit untConsultaCadastroNovasFormulasRennerPerformance;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasRennerPerformance = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasRennerPerformance }

constructor TConsultaCadastroNovasFormulasRennerPerformance.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCOR', 'Cor', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base', 'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem', 'LIKE');
  pAdicionar('NFM_LINHA_', 'Linha/Grupo', 'LIKE');
  pAdicionar('AUTOINCREM',  'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESCOR', 'Base/Cor');
end;

destructor TConsultaCadastroNovasFormulasRennerPerformance.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasRennerPerformance.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_DESCOR "Cor"            ' +
    '   , NFM_CODBAS "Base"         ' +
    '   , NFM_CODEMB "Embalagem"             ' +
    '   , NFM_LINHA_ "Linha/Grupo"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   REP_CADNFM                  ';
end;

end.
