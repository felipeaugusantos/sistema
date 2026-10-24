unit untConsultaCadastroColoranteRennerPerformance;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteRennerPerformance = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroColoranteRennerPerformance }

constructor TConsultaCadastroColoranteRennerPerformance.Create;
begin
  inherited Create;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('COL_MARGEM', 'Margem', 'LIKE');
  pAdicionar('COL_PREVEN', 'Preço Venda', 'LIKE');
  pAdicionar('COL_EMBALA', 'Embalagem', 'LIKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroColoranteRennerPerformance.Destroy;
begin

  inherited;
end;

function TConsultaCadastroColoranteRennerPerformance.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante",	 ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + '  COL_MARGEM "Margem",  ';
  Result := Result + '  COL_PREVEN "Preço Venda",  ';
  Result := Result + '  COL_EMBALA "Embalagem",  ';
  Result := Result + ' 	C.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	REP_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 