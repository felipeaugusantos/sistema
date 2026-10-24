{***********************************************************************}
{* Classe que responsável pela consulta no cadastro de base da MazaImobiliaria *}
{********************************************************************PH*}
unit untConsultaCadastroBaseMazaImobiliaria;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseMazaImobiliaria = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseMazaImobiliaria }

constructor TConsultaCadastroBaseMazaImobiliaria.Create;
begin
  inherited Create;
  pAdicionar('BAS_CODBAS', 'Base', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('BAS_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_DESCRI+BAS_CODBAS', 'Descrição/Base');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');
end;

destructor TConsultaCadastroBaseMazaImobiliaria.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseMazaImobiliaria.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_CODBAS "Base", ';
  Result := Result + ' 	BAS_DESCRI "Descrição", ';
  Result := Result + ' 	BAS_CODUNI "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	MZI_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
