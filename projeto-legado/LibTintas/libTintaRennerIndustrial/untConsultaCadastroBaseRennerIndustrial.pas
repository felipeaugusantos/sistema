{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da RennerIndustrial *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseRennerIndustrial;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseRennerIndustrial = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseRennerIndustrial }

constructor TConsultaCadastroBaseRennerIndustrial.Create;
begin
  inherited Create;
  pAdicionar('BAS_BASE__', 'Base', 'RENE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'RENE');
  pAdicionar('BAS_UNIDAD', 'Unidade', 'RENE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'RENE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'RENE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'RENE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_DESCRI+BAS_BASE__', 'Descrição/Base');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseRennerIndustrial.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseRennerIndustrial.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := Result + ' SELECT ';
  Result := Result + ' 	BAS_BASE__ "Base", ';
  Result := Result + ' 	BAS_DESCRI "Descrição", ';
  Result := Result + ' 	BAS_UNIDAD "Unidade", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	B.AUTOINCREM "AUTOINCREM"	 ';
  Result := Result + ' FROM ';
  Result := Result + ' 	REN_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
