unit untConsultaCadastroNovasFormulasDacasa;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasDacasa = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasDacasa }

constructor TConsultaCadastroNovasFormulasDacasa.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_CODBAS', 'Base',              'LIKE');
  pAdicionar('NFM_DESPRO', 'Produto',           'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição',         'LIKE');
  pAdicionar('NFM_UNIDAD', 'Unidade',           'LIKE');
  pAdicionar('NFM_CODEMB', 'Embalagem',         'LIKE');
  pAdicionar('AUTOINCREM', 'AUTOINCREM',        '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_CODBAS+NFM_DESPRO', 'Base/Produto');
  pAdicionarIndice('NFM_DESCRI',            'Descrição');
end;

destructor TConsultaCadastroNovasFormulasDacasa.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasDacasa.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                           ' +
    '   NFM_CODIGO "Código da Fórmula" ' +
    '   , NFM_CODBAS "Base"            ' +
    '   , NFM_DESPRO "Produto"         ' +
    '   , NFM_DESCRI "Descrição"       ' +
    '   , NFM_UNIDAD "Unidade"         ' +
    '   , NFM_CODEMB "Embalagem"       ' +
    '   , AUTOINCREM                   ' +
    ' FROM                             ' +
    '   DCA_CADNFM                  ' +
    ' WHERE NFM_UNIDAD = ''LT''        ';
end;

end.
