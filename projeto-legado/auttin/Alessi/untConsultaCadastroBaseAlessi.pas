unit untConsultaCadastroBaseAlessi;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseAlessi = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

constructor TConsultaCadastroBaseAlessi.Create;
begin
  inherited Create;
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('BAS_BASE__', 'Base', 'LIKE');
  pAdicionar('EMB_NOME__', 'Embalagem', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_PRODUT+BAS_BASE__+EMB_NOME__', 'Produto/Base/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseAlessi.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseAlessi.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                                 ' +
    '   B.AUTOINCREM                         ' +
    '   , BAS_PRODUT AS "Produto"            ' +
    '   , BAS_BASE__ AS "Base"               ' +
    '   , EMB_NOME__ AS "Embalagem"          ' +
    '   , EMB_CODUNI AS "Unidade"            ' +
    '   , ITE_CODITE AS "Código do Item"     ' +
    '   , ITE_DESITE AS "Descrição do Item"  ' +
    '   , ITE_REFERE AS "Referência do Item" ' +
    ' FROM                                   ' +
    '   ALE_CADBAS B                         ' +
    '   LEFT JOIN ALE_CADEMB                 ' +
    '     ON BAS_EMBALA = EMB_NOME__         ' +
    '   LEFT JOIN CADITE I                   ' +
    '     ON BAS_CODITE = ITE_CODITE         ';
end;

end.
