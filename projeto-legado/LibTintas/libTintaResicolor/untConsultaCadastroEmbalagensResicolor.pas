unit untConsultaCadastroEmbalagensResicolor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroEmbalagensResicolor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroEmbalagensResicolor }

constructor TConsultaCadastroEmbalagensResicolor.Create;
begin
  inherited Create;
  pAdicionar('EMB_CODEMB', 'Código',     'LIKE');
  pAdicionar('EMB_QTDEMB', 'Quantidade', 'LIKE');
  pAdicionar('EMB_UNIDAD', 'Unidade',    'LIKE');
  pAdicionar('EMB_USAEMB', 'Utilizar Embalagem', 'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('EMB_CODEMB', 'Código');
end;

destructor TConsultaCadastroEmbalagensResicolor.Destroy;
begin

  inherited;
end;

function TConsultaCadastroEmbalagensResicolor.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	EMB_CODEMB "Código",	    ';
  Result := Result + ' 	EMB_QTDEMB "Quantidade",  ';
  Result := Result + ' 	EMB_UNIDAD "Unidade",     ';
  Result := Result + '  EMB_USAEMB "Utilizar Embalagem",      ';
  Result := Result + ' 	AUTOINCREM "AUTOINCREM"   ';
  Result := Result + ' FROM ';
  Result := Result + ' 	RSI_CADEMB ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
 