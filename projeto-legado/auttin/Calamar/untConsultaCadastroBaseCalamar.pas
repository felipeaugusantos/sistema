unit untConsultaCadastroBaseCalamar;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseCalamar = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

{ TConsultaCadastroBaseVelutex }

constructor TConsultaCadastroBaseCalamar.Create;
begin
  inherited Create;

  pAdicionar('BAS_CODBAS', 'Código da Base', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('EMB_CODEMB', 'Código da Embalagem', 'LIKE');
  pAdicionar('EMB_DESEMB', 'Embalagem', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+BAS_DESCRI+EMB_CODEMB', 'Código da Base/Descrição/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseCalamar.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseCalamar.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
   ' SELECT                                 ' +
    '   BAS_CODBAS AS "Código da Base"       ' +
    '   , BAS_DESCRI AS "Descrição"          ' +
    '   , EMB_CODEMB AS "Código Embalagem"   ' +
    '   , EMB_DESCRI AS "Embalagem"          ' +
    '   , EMB_CODUNI AS "Unidade"            ' +
    '   , ITE_CODITE AS "Código do Item"     ' +
    '   , ITE_DESITE AS "Descrição do Item"  ' +
    '   , ITE_REFERE AS "Referência do Item" ' +
    '   , B.AUTOINCREM                       ' +
    ' FROM                                   ' +
    '   CAL_CADBAS B                         ' +
    '   LEFT JOIN CAL_CADEMB E               ' +
    '     ON BAS_CODEMB = EMB_CODEMB         ' +
    '   LEFT JOIN CADITE I                   ' +
    '     ON BAS_CODITE = ITE_CODITE         ' +
    '   LEFT JOIN CADUNI U                   ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI     ';
end;

end.
