unit untConsultaCadastroColoranteKilling;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteKilling = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroColoranteKilling }

constructor TConsultaCadastroColoranteKilling.Create;
begin
  inherited Create;
  pAdicionar('COL_CODCOL', 'Código', 'LIKE');
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');

end;

destructor TConsultaCadastroColoranteKilling.Destroy;
begin

  inherited;
end;

function TConsultaCadastroColoranteKilling.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante",	 ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	C.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	KILD_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 