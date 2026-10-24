unit untConsultaCadastroBaseBrazilianColor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseBrazilianColor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseBrazilianColor }

constructor TConsultaCadastroBaseBrazilianColor.Create;
begin
  inherited;
  pAdicionar('B.AUTOINCREM','AUTOINCREM', '=');
  pAdicionar('BAS_CODBAS', 'Código', 'LIKE');
  pAdicionar('BAS_DESBAS', 'Descrição', 'LIKE');
  pAdicionar('BAS_EMBALA', 'Embalagem', 'LIKE');
  pAdicionar('BAS_PESESP', 'Peso Específico', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');

  pAdicionarIndice('BAS_DESBAS+BAS_CODBAS', 'Descrição/Código');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseBrazilianColor.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseBrazilianColor.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                                ' +
    '   B.AUTOINCREM "Autoincrem"           ' +
    '   , BAS_CODBAS "Código"               ' +
    '   , BAS_DESBAS "Descrição"            ' +
    '   , BAS_EMBALA "Embalagem"            ' +
    '   , BAS_PESESP "Peso Específico"      ' +
    '   , ITE_CODITE "Código do Item"       ' +
    '   , ITE_DESITE "Descrição do Item"    ' +
    '   , ITE_REFERE "Referência do Item"   ' +
    ' FROM                                  ' +
    '   BZC_CADBAS B                        ' +
    '   LEFT JOIN CADITE                    ' +
    '     ON BAS_CODITE = ITE_CODITE        ' +
    ' WHERE TRUE                            ';
end;

end.
