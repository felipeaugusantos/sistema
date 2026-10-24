unit untConsultaCadastroEmbalagensAnjoImobiliaria;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensAnjoImobiliaria = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensAnjoImobiliaria }

constructor TConsultaCadastroEmbalagensAnjoImobiliaria.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_QTDEMB', 'Quantidade', 'LIKE');
  pAdicionar('EMB_UNIDAD', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensAnjoImobiliaria.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensAnjoImobiliaria.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_QTDEMB "Quantidade",  ';
  Result := Result + ' 	EMB_UNIDAD "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ANJ_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 