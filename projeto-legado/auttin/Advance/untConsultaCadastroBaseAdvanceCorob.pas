unit untConsultaCadastroBaseAdvanceCorob;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseAdvance = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;

  End;


implementation

{ TConsultaCadastroBaseAdvance }

constructor TConsultaCadastroBaseAdvance.Create;
begin
  inherited Create;
  pAdicionar('BAS_BASE__', 'Base', 'LIKE');
  pAdicionar('BAS_PROKEY', 'Prod. Key', 'LIKE');
  pAdicionar('BAS_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('BAS_UNIDAD', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_DESCRI+BAS_BASE__', 'Descrição/Base');
  pAdicionarIndice('BAS_BASE__+BAS_PROKEY+BAS_SUBKEY', 'Base/Prod. Key/Sub. Key');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseAdvance.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseAdvance.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_BASE__ "Base", ';
  Result := Result + ' 	BAS_PROKEY "Prod. Key", ';
  Result := Result + ' 	BAS_SUBKEY "Sub. Key", ';
  Result := Result + ' 	BAS_DESCRI "Descrição", ';
  Result := Result + ' 	BAS_UNIDAD "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ADVCOR_CADBAS B  ';
  Result := Result + ' 	LEFT JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
