unit untConsultaCadastroColoranteCoralImobiliaria;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteCoralImobiliaria = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
  End;

implementation

{ TConsultaCadastroColoranteCoralImobiliaria }

constructor TConsultaCadastroColoranteCoralImobiliaria.Create;
begin
  inherited;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

function TConsultaCadastroColoranteCoralImobiliaria.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	C.AUTOINCREM ';
  Result := Result + ' FROM ';
  Result := Result + ' 	CORIMO_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = COL_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
