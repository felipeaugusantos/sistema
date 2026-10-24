unit untConsultaCadastroBaseLazzumix;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseLazzumix = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseLazzumix }

constructor TConsultaCadastroBaseLazzumix.Create;
begin
  inherited;
  pAdicionar('B.AUTOINCREM','AUTOINCREM', '=');
  pAdicionar('BAS_CODBAS', 'Código', 'LIKE');
  pAdicionar('BAS_DESBAS', 'Descrição', 'LIKE');
  pAdicionar('BAS_EMBALA', 'Embalagem', 'LIKE');
  //pAdicionar('BAS_PESESP', 'Peso Específico', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');

  pAdicionarIndice('BAS_DESBAS+BAS_CODBAS', 'Descrição/Código');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseLazzumix.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseLazzumix.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result +  ' SELECT ';
  Result := Result +  '   B.AUTOINCREM    "Autoincrem", ';
  Result := Result +  '   BAS_CODBAS      "Código", ';
  Result := Result +  '   BAS_DESBAS      "Descrição", ';
  Result := Result +  '   BAS_EMBALA      "Embalagem", ';
  //Result := Result +  '   BAS_PESESP      "Peso Específico", ';
  Result := Result +  '   ITE_CODITE      "Código do Item", ';
  Result := Result +  '   ITE_DESITE      "Descrição do Item", ';
  Result := Result +  '   ITE_REFERE      "Referência do Item" ';
  Result := Result +  ' FROM LAZ_CADBAS B ';
  Result := Result +  '   LEFT JOIN CADITE ';
  Result := Result +  '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result +  ' WHERE TRUE ';
end;

end.
