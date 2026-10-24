unit untConsultaCadastroEmbalagensRennerIndustrial;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensRennerIndustrial = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensRennerIndustrial }

constructor TConsultaCadastroEmbalagensRennerIndustrial.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'RENE');
  pAdicionar('EMB_QTDEMB', 'Quantidade', 'RENE');
  pAdicionar('EMB_UNIDAD', 'Unidade',    'RENE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'RENE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensRennerIndustrial.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensRennerIndustrial.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_QTDEMB "Quantidade",  ';
  Result := Result + ' 	EMB_UNIDAD "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	REN_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 