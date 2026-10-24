{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemSherwinWilliams;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSherwinWilliamsCores,
  untGravandoExecucaoSherwinWilliamsColorantes;

type
  TAuttinMenuItemSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensSherwinWilliams = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSherwinWilliams, untLibTintaFactory, untGravandoExecucaoSherwinWilliamsNovasFormulas, untCadastroBasesSherwinWilliams, 
  untCadastroColorantesSherwinWilliams, untGravandoExecucaoSherwinWilliamsBases, 
  untCadastroNovasFormulasSherwinWilliams, untCadastroEmbalagensSherwinWilliams;

{ TAuttinMenuItemSherwinWilliams }

constructor TAuttinMenuItemSherwinWilliams.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSherwinWilliams.Create());
  Self.Adicionar(TCadastroBasesSherwinWilliams.Create());
  Self.Adicionar(TCadastroColorantesSherwinWilliams.Create());
  Self.Adicionar(TCadastroEmbalagensSherwinWilliams.Create());
  Self.Adicionar(TCadastroNovasFormulasSherwinWilliams.Create());
  Self.Adicionar(TGeracaoTintaSherwinWilliams.Create());
  Self.Adicionar(TConsultaSherwinWilliams.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSherwinWilliams }

constructor TConfiguracoesSherwinWilliams.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSherwinWilliams');
end;

procedure TConfiguracoesSherwinWilliams.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSherwinWilliams.Create(auttinWrapper));
end;

{ TCadastroBasesSherwinWilliams }

constructor TCadastroBasesSherwinWilliams.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSHEBase');
end;

procedure TCadastroBasesSherwinWilliams.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSherwinWilliams.TCadastroBasesSherwinWilliams.Create());
end;

{ TConsultaSherwinWilliams }

constructor TConsultaSherwinWilliams.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSherwinWilliams');
end;

procedure TConsultaSherwinWilliams.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSherwinWilliams }

constructor TGeracaoTintaSherwinWilliams.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSHEGeraArquivo');
end;

procedure TGeracaoTintaSherwinWilliams.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sherwin Williams', [
    TGravandoExecucaoSherwinWilliamsColorantes.Create,
    TGravandoExecucaoSherwinWilliamsBases.Create,
    TGravandoExecucaoSherwinWilliamsCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSHEGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sherwin Williams', [
    TGravandoExecucaoSherwinWilliamsNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSherwinWilliams }

constructor TCadastroColorantesSherwinWilliams.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSHEColorantes');
end;

procedure TCadastroColorantesSherwinWilliams.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSherwinWilliams.TCadastroColorantesSherwinWilliams.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSherwinWilliams.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSHENovasFormulas');  
end;

procedure TCadastroNovasFormulasSherwinWilliams.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSherwinWilliams.TCadastroNovasFormulasSherwinWilliams.Create);
end;

{ TCadastroEmbalagensSherwinWilliams }

constructor TCadastroEmbalagensSherwinWilliams.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadSHEEmbalagens');
end;

procedure TCadastroEmbalagensSherwinWilliams.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensSherwinWilliams.TCadastroEmbalagensSherwinWilliams.Create);
end;

end.
