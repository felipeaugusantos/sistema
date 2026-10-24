unit untConsultaCadastroNovasFormulasRoberlo;

interface

uses
  untConsultaCadastro;

Type
  TConsultaCadastroNovasFormulasRoberlo = class(TConsultaCadastro)
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
  End;

implementation

{ TConsultaCadastroNovasFormulasRoberlo }

constructor TConsultaCadastroNovasFormulasRoberlo.Create;
begin
  inherited Create;
  pAdicionar('NFM_CODIGO', 'Código da Fórmula', 'LIKE');
  pAdicionar('NFM_DESCRI', 'Descrição', 'LIKE');
  pAdicionar('NFM_CODCOR', 'Cor', 'LIKE');
  pAdicionar('NFM_NOMCOR', 'Nome Cor', 'LIKE');
  pAdicionar('NFM_MARCA_', 'Marca', 'LIKE');
  pAdicionar('AUTOINCREM',  'AUTOINCREM', '=');

  pAdicionarIndice('NFM_CODIGO',            'Código da Fórmula');
  pAdicionarIndice('NFM_DESCRI+NFM_CODCOR', 'Descriçao/Cor');
end;

destructor TConsultaCadastroNovasFormulasRoberlo.Destroy;
begin
  inherited;
end;

function TConsultaCadastroNovasFormulasRoberlo.fGetSelect(
  blnTodos: Boolean): String;
begin
  Result :=
    ' SELECT                            ' +
    '   NFM_CODIGO "Código da Fórmula"  ' +
    '   , NFM_DESCRI "Descrição"        ' +
    '   , NFM_CODCOR "Cor"              ' +
    '   , NFM_NOMCOR "Nome Cor"         ' +
    '   , NFM_MARCA_ "Marca"            ' +
    '   , AUTOINCREM                    ' +
    ' FROM                              ' +
    '   ROB_CADNFM                      ';
end;

end.
