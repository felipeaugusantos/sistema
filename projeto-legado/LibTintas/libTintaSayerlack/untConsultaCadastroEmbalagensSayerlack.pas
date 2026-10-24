unit untConsultaCadastroEmbalagensSayerlack;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensSayerlack = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensSayerlack }

constructor TConsultaCadastroEmbalagensSayerlack.Create;
begin
  inherited Create;
  pAdicionar('EMB_DESEMB', 'Código',     'LIKE');
  pAdicionar('EMB_EMBALA', 'Tamanho', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensSayerlack.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensSayerlack.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_DESEMB "Código",	    ';
  Result := Result + ' 	EMB_EMBALA "Tamanho",  ';
  Result := Result + ' 	EMB_CODUNI "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	SAY_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 