unit untConsultaCadastroColoranteRennerIndustrial;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteRennerIndustrial = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroColoranteRennerIndustrial }

constructor TConsultaCadastroColoranteRennerIndustrial.Create;
begin
  inherited Create;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'RENE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'RENE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'RENE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'RENE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', 'RENE');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroColoranteRennerIndustrial.Destroy;
begin

  inherited;
end;

function TConsultaCadastroColoranteRennerIndustrial.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante",	 ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	C.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	REN_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 