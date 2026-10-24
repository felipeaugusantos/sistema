unit untConsultaCadastroEmbalagensInternational;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensInternational = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensInternational }

constructor TConsultaCadastroEmbalagensInternational.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_DESEMB', 'Descrição Embalagem', 'LIKE');
  pAdicionar('EMB_DESEMB', 'Descrição Unidade', 'LIKE');
  pAdicionar('EMB_TAMEMB', 'Tamanho', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade',    'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensInternational.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensInternational.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + '  EMB_DESEMB "Descrição Embalagem", ';
  Result := Result + '  EMB_DESEMB "Descrição Unidade", ';
  Result := Result + ' 	EMB_TAMEMB "Tamanho",  ';
  Result := Result + ' 	EMB_CODUNI "Unidade",     ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	INT_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 