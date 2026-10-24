unit untConsultaCadastroBaseStandox;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseStandox = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseStandox }

constructor TConsultaCadastroBaseStandox.Create;
begin
  inherited Create;

  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');
  pAdicionar('BAS_CODBAS', 'Código', 'LIKE');
  pAdicionar('BAS_DESBAS', 'Descrição', 'LIKE');
  pAdicionar('BAS_PESGRA', 'Peso Grama', 'LIKE');
  pAdicionar('BAS_EMBALA', 'Embalagem', 'LIKE');
  pAdicionar('BAS_PESESP', 'Peso Específico', 'LIKE');
  pAdicionar('BAS_TIPO__', 'Tipo', 'LIKE');
  pAdicionar('BAS_LINHA_', 'Linha', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência Item', 'LIKE');

  pAdicionarIndice('BAS_DESBAS+BAS_CODBAS', 'Descrição/Código');
  pAdicionarIndice('ITE_CODITE', 'Código Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição Item/Referência Item');

end;

destructor TConsultaCadastroBaseStandox.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseStandox.fGetSelect(blnTodos: Boolean): String;
begin
  Result := ' SELECT ';
  Result := Result + '   B.AUTOINCREM    "Autoincrem", ';
  Result := Result + '   BAS_CODBAS      "Código", ';
  Result := Result + '   BAS_DESBAS      "Descrição", ';
  Result := Result + '   BAS_EMBALA      "Embalagem", ';
  Result := Result + '   BAS_PESESP      "Peso Específico", ';
  Result := Result + '   ITE_CODITE      "Código Item", ';
  Result := Result + '   ITE_DESITE      "Descrição Item", ';
  Result := Result + '   ITE_REFERE      "Referência Item" ';
  Result := Result + ' FROM DOX_CADBAS B ';
  Result := Result + '   LEFT JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

end.
