unit untConsultaCadastroBaseSuvinil;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseSuvinil = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseSuvinil }

constructor TConsultaCadastroBaseSuvinil.Create;
begin
  inherited Create;
  pAdicionar('SUV_CODFML', 'Código', 'LIKE');
  pAdicionar('SUV_CODBAS', 'Base', 'LIKE');
  pAdicionar('SUV_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('SUV_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('SUV_DESCRI+SUV_CODBAS+SUV_CODFML', 'Descrição/Base/Código');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseSuvinil.Destroy;
begin  
  inherited;
end;

function TConsultaCadastroBaseSuvinil.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	SUV_CODFML "Código", ';
  Result := Result + ' 	SUV_CODBAS "Base", ';
  Result := Result + ' 	SUV_DESCRI "Descrição", ';
  Result := Result + ' 	SUV_CODUNI "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	SUV_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON SUV_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
