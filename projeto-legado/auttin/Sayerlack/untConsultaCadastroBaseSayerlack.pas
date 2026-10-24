unit untConsultaCadastroBaseSayerlack;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseSayerlack = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

{ TConsultaCadastroBaseSayerlack }

constructor TConsultaCadastroBaseSayerlack.Create;
begin
  inherited Create;

  pAdicionar('BAS_CODBAS', 'Código da Base', 'LIKE');
  pAdicionar('BAS_BASE__', 'Base', 'LIKE');
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('BAS_DESEMB', 'Embalagem', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+BAS_BASE__+UNI_CODUNI', 'Base/Produto/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseSayerlack.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseSayerlack.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                                   ' +
    '   BAS_BASE__ AS ''Base''                 ' +
    '   , BAS_CODBAS AS ''Código da Base''     ' +
    '   , BAS_PRODUT AS ''Produto''            ' +
    '   , BAS_DESEMB AS ''Embalagem''          ' +
    '   , ITE_CODITE AS ''Código do Item''     ' +
    '   , ITE_DESITE AS ''Descrição do Item''  ' +
    '   , ITE_REFERE AS ''Referência do Item'' ' +
    '   , B.AUTOINCREM                         ' +
    '   , UNI_CODUNI AS ''Código da Unidade''  ' +
    '   , UNI_SIGUNI AS ''Sigla da Unidade''   ' +
    ' FROM                                     ' +
    '   SAY_CADBAS B                           ' +
    '   LEFT JOIN SAY_CADEMB E                 ' +
    '     ON B.BAS_DESEMB = E.EMB_DESEMB       ' +
    '   LEFT JOIN CADITE I                     ' +
    '     ON B.BAS_CODITE = I.ITE_CODITE       ' +
    '   LEFT JOIN CADUNI U                     ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI       ';
end;

end.
