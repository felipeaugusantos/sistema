unit untConsultaCadastroBaseInternational;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseInternational = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

{ TConsultaCadastroBaseVelutex }

constructor TConsultaCadastroBaseInternational.Create;
begin
  inherited Create;

  pAdicionar('BAS_CODBAS', 'Base', 'LIKE');
  pAdicionar('EMB_CODEMB', 'Código da Embalagem', 'LIKE');
  pAdicionar('EMB_DESEMB', 'Embalagem', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_CODBAS+EMB_CODEMB', 'Base/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseInternational.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseInternational.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
   ' SELECT                                   ' +
   '   BAS_CODBAS AS ''Base''                 ' +
   '   , EMB_CODEMB AS ''Código Embalagem''   ' +
   '   , EMB_DESEMB AS ''Embalagem''          ' +
   '   , EMB_CODUNI AS ''Unidade''            ' +
   '   , ITE_CODITE AS ''Código do Item''     ' +
   '   , ITE_DESITE AS ''Descrição do Item''  ' +
   '   , ITE_REFERE AS ''Referência do Item'' ' +
   '   , B.AUTOINCREM                         ' +
   ' FROM                                     ' +
   '   INT_CADBAS B                           ' +
   '   LEFT JOIN INT_CADEMB E                 ' +
   '     ON BAS_CODEMB = EMB_CODEMB           ' +
   '   LEFT JOIN CADITE I                     ' +
   '     ON BAS_CODITE = ITE_CODITE           ' +
   '   LEFT JOIN CADUNI U                     ' +
   '     ON E.EMB_CODUNI = U.UNI_CODUNI       ';
end;

end.
