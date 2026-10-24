unit untConsultaCadastroEmbalagensCalamar;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensCalamar = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensCalamar }

constructor TConsultaCadastroEmbalagensCalamar.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_TAMEMB', 'Tamanho', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensCalamar.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensCalamar.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_TAMEMB "Tamanho",  ';
  Result := Result + ' 	EMB_CODUNI "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	CAL_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 