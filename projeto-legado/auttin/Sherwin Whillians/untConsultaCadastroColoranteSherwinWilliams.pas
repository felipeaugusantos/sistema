unit untConsultaCadastroColoranteSherwinWilliams;

interface

uses
untConsultaCadastroColoranteLukscolor;

Type
  TConsultaCadastroColoranteSherwinWilliams = class(TConsultaCadastroColoranteLukscolor)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
  End;

implementation

{ TConsultaCadastroColoranteSherwinWilliams }

function TConsultaCadastroColoranteSherwinWilliams.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + ' 	COL_CODCOL "Código do Colorante", ';
  Result := Result + ' 	COL_DESCRI "Descrição", ';
  Result := Result + ' 	ITE_CODITE "Código do Item", ';
  Result := Result + ' 	ITE_DESITE "Descrição do Item", ';
  Result := Result + ' 	ITE_REFERE "Referência do Item", ';
  Result := Result + ' 	C.AUTOINCREM "AUTOINCREM" ';
  Result := Result + ' FROM ';
  Result := Result + ' 	SHE_CADCOL C ';
  Result := Result + ' 	LEFT JOIN CADITE I ON COL_CODITE = ITE_CODITE ';
  Result := Result + ' WHERE ';
  Result := Result + ' 	TRUE ';
end;

end.
