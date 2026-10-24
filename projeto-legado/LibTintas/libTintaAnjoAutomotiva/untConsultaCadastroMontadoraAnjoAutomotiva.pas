{******************************************************************************}
{* Classe que responsável pela consulta no cadastro de Montadora da AnjoAutomotiva *}
{***************************************************************************AC*}
unit untConsultaCadastroMontadoraAnjoAutomotiva;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroMontadoraAnjoAutomotiva = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroBaseAnjoAutomotiva }

constructor TConsultaCadastroMontadoraAnjoAutomotiva.Create;
begin
  inherited Create;
  pAdicionar('AUTOINCREM',  'AUTOINCREM', 'LIKE');
  pAdicionar('MON_CODMON',  'Código',     'LIKE');
  pAdicionar('MON_DESCRI',  'Descrição',  'LIKE');

  pAdicionarIndice('MON_CODMON', 'Código');
end;

destructor TConsultaCadastroMontadoraAnjoAutomotiva.Destroy;
begin
  inherited;
end;

function TConsultaCadastroMontadoraAnjoAutomotiva.fGetSelect(blnTodos: Boolean): String;
begin
  Result := '';
  Result := Result +  ' SELECT ';
  Result := Result +  '   AUTOINCREM      "Autoincrem", ';
  Result := Result +  '   MON_CODMON      "Código",     ';
  Result := Result +  '   MON_DESCRI      "Descrição"   ';
  Result := Result +  ' FROM AJT_CADMON   ';
  Result := Result +  ' WHERE TRUE ';
end;

end.
