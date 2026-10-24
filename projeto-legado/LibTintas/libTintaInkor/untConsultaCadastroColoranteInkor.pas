unit untConsultaCadastroColoranteInkor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroColoranteInkor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroColoranteInkor }

constructor TConsultaCadastroColoranteInkor.Create;
begin
  inherited Create;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'INKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'INKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'INKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'INKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', 'INKE');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroColoranteInkor.Destroy;
begin

  inherited;
end;

function TConsultaCadastroColoranteInkor.fGetSelect(
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
  Result := Result + ' 	INK_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 