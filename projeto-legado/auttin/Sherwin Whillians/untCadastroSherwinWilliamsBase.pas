unit untCadastroSherwinWilliamsBase;

interface
uses

  untICadastroTintaBaseLukscolor, untCadastroLukscolorBase;

Type
  TCadastroSherwinWilliamsBase = class(TCadastroLukscolorBase, ICadastroTintaBaseLukscolor)
  public
    constructor Create;
    function fGetIdePro: String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;

implementation

uses untConsultaCadastroBaseSherwinWilliams;

{ TCadastroSherwinWilliamsBase }

constructor TCadastroSherwinWilliamsBase.Create;
begin
  Inherited Create(TConsultaCadastroBaseSherwinWilliams.Create);
end;



function TCadastroSherwinWilliamsBase.fGetIdePro: String;
begin
  Result := 'SHE';
end;

function TCadastroSherwinWilliamsBase.fGetNomeTabela: String;
begin
  Result := 'SHE_CADBAS';
end;

function TCadastroSherwinWilliamsBase.fGetNomeTinta: String;
begin
  Result := 'Sherwin Williams';
end;

end.
