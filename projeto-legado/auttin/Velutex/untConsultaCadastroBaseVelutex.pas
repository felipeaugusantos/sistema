unit untConsultaCadastroBaseVelutex;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseVelutex = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

{ TConsultaCadastroBaseVelutex }

constructor TConsultaCadastroBaseVelutex.Create;
begin
  inherited Create;

  pAdicionar('BAS_CODBAS', 'Código da Base', 'LIKE');
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('BAS_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+BAS_PRODUT+BAS_CODUNI', 'Base/Produto/Unidade');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseVelutex.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseVelutex.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
   ' SELECT                                   ' +
   '   BAS_CODBAS AS ''Código da Base''       ' +
   '   , BAS_PRODUT AS ''Produto''            ' +
   '   , BAS_CODUNI AS ''Unidade''          ' +
   '   , ITE_CODITE AS ''Código do Item''     ' +
   '   , ITE_DESITE AS ''Descrição do Item''  ' +
   '   , ITE_REFERE AS ''Referência do Item'' ' +
   '   , B.AUTOINCREM                         ' +
   ' FROM                                     ' +
   '   VEL_CADBAS B                           ' +
   '   LEFT JOIN CADUNI E                     ' +
   '     ON  BAS_CODUNI = UNI_CODUNI          ' +
   '   LEFT JOIN CADITE I                     ' +
   '     ON BAS_CODITE = ITE_CODITE           ';
end;

end.
