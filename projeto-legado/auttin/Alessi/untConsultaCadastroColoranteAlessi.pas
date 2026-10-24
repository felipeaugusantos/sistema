unit untConsultaCadastroColoranteAlessi;

interface

uses
  untConsultaCadastro;

type
  TConsultaCadastroColoranteAlessi = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

constructor TConsultaCadastroColoranteAlessi.Create;
begin
  inherited Create;
  pAdicionar('COL_CODCOL', 'Código do Colorante', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('C.AUTOINCREM', 'AUTOINCREM', 'LIKE');

  pAdicionarIndice('COL_CODCOL', 'Código do Colorante');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');

end;

destructor TConsultaCadastroColoranteAlessi.Destroy;
begin

  inherited;
end;

function TConsultaCadastroColoranteAlessi.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                                    ' +
    '   C.AUTOINCREM                            ' +
    '   , COL_CODCOL AS ''Código do Colorante'' ' +
    '   , ITE_CODITE AS ''Código do Item''      ' +
    '   , ITE_DESITE AS ''Descrição do Item''   ' +
    '   , ITE_REFERE AS ''Referência do Item''  ' +
    ' FROM                                      ' +
    '   ALE_CADCOL C                            ' +
    '   LEFT JOIN CADITE I                      ' +
    '     ON COL_CODITE = ITE_CODITE            ';
end;

end.
