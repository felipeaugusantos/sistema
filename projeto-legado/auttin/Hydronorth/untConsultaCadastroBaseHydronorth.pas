unit untConsultaCadastroBaseHydronorth;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroBaseHydronorth = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  end;

implementation

{ TConsultaCadastroBaseVelutex }

constructor TConsultaCadastroBaseHydronorth.Create;
begin
  inherited Create;

  pAdicionar('BAS_BASE__', 'Base', 'LIKE');
  pAdicionar('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionar('EMB_CODEMB', 'Código da Embalagem', 'LIKE');
  pAdicionar('EMB_DESEMB', 'Embalagem', 'LIKE');
  pAdicionar('EMB_CODUNI', 'Unidade', 'LIKE');
  pAdicionar('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionar('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionar('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionar('B.AUTOINCREM', 'AUTOINCREM', '=');

  pAdicionarIndice('BAS_BASE__+BAS_PRODUT+EMB_CODEMB', 'Base/Produto/Embalagem');
  pAdicionarIndice('ITE_CODITE', 'Código do Item');
  pAdicionarIndice('ITE_DESITE+ITE_REFERE', 'Descrição do Item/Referência do Item');
end;

destructor TConsultaCadastroBaseHydronorth.Destroy;
begin

  inherited;
end;

function TConsultaCadastroBaseHydronorth.fGetSelect(blnTodos: Boolean): String;
begin
  Result :=
   ' SELECT                                   ' +
   '   BAS_BASE__ AS ''Base''                 ' +
   '   , BAS_PRODUT AS ''Produto''            ' +
   '   , EMB_CODEMB AS ''Código Embalagem''   ' +
   '   , EMB_DESEMB AS ''Embalagem''          ' +
   '   , EMB_CODUNI AS ''Unidade''            ' +
   '   , ITE_CODITE AS ''Código do Item''     ' +
   '   , ITE_DESITE AS ''Descrição do Item''  ' +
   '   , ITE_REFERE AS ''Referência do Item'' ' +
   '   , B.AUTOINCREM                         ' +
   ' FROM                                     ' +
   '   HYD_CADBAS B                           ' +
   '   LEFT JOIN HYD_CADEMB E                 ' +
   '     ON BAS_CODEMB = EMB_CODEMB           ' +
   '   LEFT JOIN CADITE I                     ' +
   '     ON BAS_CODITE = ITE_CODITE           ' +
   '   LEFT JOIN CADUNI U                     ' +
   '     ON E.EMB_CODUNI = U.UNI_CODUNI       ';
end;

end.