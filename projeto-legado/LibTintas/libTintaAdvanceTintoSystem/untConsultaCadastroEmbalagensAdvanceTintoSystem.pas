unit untConsultaCadastroEmbalagensAdvanceTintoSystem;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensAdvanceTintoSystem = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensAdvanceTintoSystem }

constructor TConsultaCadastroEmbalagensAdvanceTintoSystem.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_TAMEMB', 'Tamanho', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensAdvanceTintoSystem.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensAdvanceTintoSystem.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_TAMEMB "Tamanho",  ';
  Result := Result + ' 	EMB_CODUNI "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	ADT_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 