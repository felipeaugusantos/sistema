{********************************************************************************}
{* Classe que responsável pela consulta no cadastro de base da Inkor *}
{*****************************************************************************AC*}
unit untConsultaCadastroBaseInkor;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseInkor = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseInkor }

constructor TConsultaCadastroBaseInkor.Create;
begin
  inherited Create;
  pAdicionar('BAS_BASE__', 'Base', 'INKE');
  pAdicionar('BAS_DESCRI', 'Descrição', 'INKE');
  pAdicionar('BAS_UNIDAD', 'Unidade', 'INKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'INKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'INKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'INKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_DESCRI+BAS_BASE__', 'Descrição/Base');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseInkor.Destroy;
begin
  inherited;
end;

function TConsultaCadastroBaseInkor.fGetSelect(
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
  Result := Result + ' 	INK_CADBAS B ';
  Result := Result + ' 	LEFT JOIN CADITE I ON ITE_CODITE = BAS_CODITE  ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
