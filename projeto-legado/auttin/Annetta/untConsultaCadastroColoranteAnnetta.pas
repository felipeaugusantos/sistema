unit untConsultaCadastroColoranteAnnetta;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteAnnetta = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
  End;

implementation

{ TConsultaCadastroColoranteAnnetta }

constructor TConsultaCadastroColoranteAnnetta.Create;
begin
  inherited;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'LIKE');
  pAdicionar('COL_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('COL_CODCOL+COL_DESCRI', 'Código do Colorante/Descrição');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

function TConsultaCadastroColoranteAnnetta.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante", ';
  Result := Result + ' 	COL_DESCRI "Descrição", ';  
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	C.AUTOINCREM ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ANN_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = COL_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
