{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da ProfissionalAutomotiva *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseProfissionalAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseProfissionalAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseProfissionalAutomotiva }

constructor TConsultaCadastroBaseProfissionalAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('BAS_CODBAS', 'Código Base', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('BAS_PRECUS', 'Preço Custo', 'LIKE');
  pAdicionar('BAS_PREVEN', 'Preço Venda', 'LIKE');
  pAdicionar('BAS_MARGEM', 'Margem', 'LIKE');
  pAdicionar('BAS_CODEMB', 'Cód. Embalagem', 'LIKE');

  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+BAS_CODEMB', 'Base/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseProfissionalAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseProfissionalAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_CODBAS "Código Base", ';
  Result := Result + '  BAS_DESCRI "Descrição", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + '  BAS_PRECUS "Preço Custo",  ';
  Result := Result + '  BAS_PREVEN "Preço Venda",  ';
  Result := Result + '  BAS_MARGEM "Margem",  ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM"	 ';
  Result := Result + ' FROM ';
  Result := Result + ' 	PFA_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
