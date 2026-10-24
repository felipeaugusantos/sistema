unit untConsultaCadastroNovasFormulasAdvanceTintoSystem;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasAdvanceTintoSystem = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasAdvanceTintoSystem }

constructor TConsultaCadastroNovasFormulasAdvanceTintoSystem.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODNFM', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base',              'LIKE');
  pAdicionar('NFM_PRODUT', 'Produto',           'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem',           'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODNFM',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_PRODUT', 'Base/Produto');
end;

destructor TConsultaCadastroNovasFormulasAdvanceTintoSystem.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasAdvanceTintoSystem.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODNFM "Código da Fórmula" ' +
    '   , NFM_CODBAS_ "Base"            ' +
    '   , NFM_PRODUT "Produto"         ' +
    '   , NFM_C_O_R_ "Cor"             ' +
    '   , NFM_CODEMB "Embalagem"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   ADT_CADNFM                  ';
end;

end.
