unit untConsultaCadastroEmbalagensGlobalColor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensGlobalColor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensGlobalColor }

constructor TConsultaCadastroEmbalagensGlobalColor.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_QTDEMB', 'Quantidade', 'LIKE');
  pAdicionar('EMB_UNIDAD', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensGlobalColor.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensGlobalColor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_QTDEMB "Quantidade",  ';
  Result := Result + ' 	EMB_UNIDAD "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	GLO_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 