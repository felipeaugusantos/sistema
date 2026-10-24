{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da AdvanceTintoSystem *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseAdvanceTintoSystem;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseAdvanceTintoSystem = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseAdvanceTintoSystem }

constructor TConsultaCadastroBaseAdvanceTintoSystem.Create;
begin
  inherited Create;
  pAdicionar('BAS_CODBAS', 'Base', 'LIKE');
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_PRODUT+BAS_CODBAS', 'Produto/Base');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseAdvanceTintoSystem.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseAdvanceTintoSystem.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_CODBAS "Base", ';
  Result := Result + ' 	BAS_PRODUT "Produto", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM"	 ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ADT_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
