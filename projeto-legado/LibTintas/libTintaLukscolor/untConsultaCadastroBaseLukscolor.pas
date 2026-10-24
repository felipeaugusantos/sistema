{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da Lukscolor *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseLukscolor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseLukscolor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseLukscolor }

constructor TConsultaCadastroBaseLukscolor.Create;
begin
  inherited Create;
  pAdicionar('BAS_BASE__', 'Código Base', 'LIKE');
  pAdicionar('BAS_PROKEY', 'Prod. Key', 'LIKE');
  PAdicionar('BAS_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('BAS_UNIDAD', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência', 'LIKE');
  pAdicionar('BAS_PRECUS', 'Preço de Custo', 'LIKE');
  pAdicionar('BAS_PREVEN', 'Preço de Venda', 'LIKE');
  pAdicionar('BAS_MARGEM', 'Margem', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_DESCRI+BAS_BASE__', 'Descrição/Base');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseLukscolor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseLukscolor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_BASE__ "Código Base", ';
  Result := Result + '  BAS_PROKEY "Prod. Key", ';
  Result := Result + '  BAS_SUBKEY "Sub. Key", ';
  Result := Result + ' 	BAS_DESCRI "Descrição", ';
  Result := Result + ' 	BAS_UNIDAD "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição Item", ';
  Result := Result + ' 	ITE_REFERE "Referência", ';
  Result := Result + '  BAS_PRECUS "Preço de Custo", ';
  Result := Result + '  BAS_PREVEN "Preço de Venda", ';
  Result := Result + '  BAS_MARGEM "Margem", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM"	 ';
  Result := Result + ' FROM ';
  Result := Result + ' 	LKD_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
