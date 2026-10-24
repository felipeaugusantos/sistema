{******************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da AnjoAutomotiva *}
{***************************************************************************AC*}
unit untConsultaCadastroBaseAnjoAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseAnjoAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseAnjoAutomotiva }

constructor TConsultaCadastroBaseAnjoAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('B.AUTOINCREM','AUTOINCREM', '=');
  pAdicionar('BAS_CODBAS', 'Código', 'LIKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('BAS_EMBALA', 'Embalagem', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');

  pAdicionarIndice('BAS_DESCRI+BAS_CODBAS', 'Descrição/Código');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseAnjoAutomotiva.Destroy;
begin  
  inherited;
end;

function TConsultaCadastroBaseAnjoAutomotiva.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result +  ' SELECT ';
  Result := Result +  '   B.AUTOINCREM    "Autoincrem", ';
  Result := Result +  '   BAS_CODBAS      "Código", ';
  Result := Result +  '   BAS_DESCRI      "Descrição", ';
  Result := Result +  '   BAS_EMBALA      "Embalagem", ';
  Result := Result +  '   ITE_CODITE      "Código do Item", ';
  Result := Result +  '   ITE_DESITE      "Descrição do Item", ';
  Result := Result +  '   ITE_REFERE      "Referência do Item" ';
  Result := Result +  ' FROM AJT_CADBAS B ';
  Result := Result +  '   LEFT JOIN CADITE ';
  Result := Result +  '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result +  ' WHERE TRUE ';
end;

end.
