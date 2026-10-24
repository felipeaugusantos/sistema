{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da Futura           *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseFutura;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseFutura = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseFutura }

constructor TConsultaCadastroBaseFutura.Create;
begin
  inherited Create;
  pAdicionar('BAS_CODFML', 'Fórmula', 'LIKE');
  pAdicionar('BAS_CODBAS', 'Base', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('BAS_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+BAS_PRODUT', 'Base/Produto');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseFutura.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseFutura.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + ' 	BAS_CODFML "Fórmula", ';
  Result := Result + ' 	BAS_CODBAS "Base", ';
  Result := Result + ' 	BAS_DESCRI "Descrição", ';
  Result := Result + ' 	BAS_PRODUT "Produto", ';
  Result := Result + ' 	BAS_CODUNI "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM  ';
  Result := Result + ' 	FUT_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
