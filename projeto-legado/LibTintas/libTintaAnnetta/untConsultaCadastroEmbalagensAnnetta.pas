unit untConsultaCadastroEmbalagensAnnetta;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensAnnetta = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensAnnetta }

constructor TConsultaCadastroEmbalagensAnnetta.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'ANNE');
  pAdicionar('EMB_QTDEMB', 'Quantidade', 'ANNE');
  pAdicionar('EMB_UNIDAD', 'Unidade',    'ANNE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'ANNE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensAnnetta.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensAnnetta.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_QTDEMB "Quantidade",  ';
  Result := Result + ' 	EMB_UNIDAD "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ANN_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 