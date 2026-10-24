{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemMaestria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoMaestriaCores,
  untGravandoExecucaoMaestriaColorantes;

type
  TAuttinMenuItemMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasMaestria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorMaestria, untLibTintaFactory, untGravandoExecucaoMaestriaNovasFormulas, untCadastroBasesMaestria, 
  untCadastroColorantesMaestria, untGravandoExecucaoMaestriaBases, 
  untCadastroNovasFormulasMaestria;

{ TAuttinMenuItemMaestria }

constructor TAuttinMenuItemMaestria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesMaestria.Create());
  Self.Adicionar(TCadastroBasesMaestria.Create());
  Self.Adicionar(TCadastroColorantesMaestria.Create());
  Self.Adicionar(TCadastroNovasFormulasMaestria.Create());
  Self.Adicionar(TGeracaoTintaMaestria.Create());
  Self.Adicionar(TConsultaMaestria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesMaestria }

constructor TConfiguracoesMaestria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesMaestria');
end;

procedure TConfiguracoesMaestria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorMaestria.Create(auttinWrapper));
end;

{ TCadastroBasesMaestria }

constructor TCadastroBasesMaestria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadMAEBase');
end;

procedure TCadastroBasesMaestria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesMaestria.TCadastroBasesMaestria.Create());
end;

{ TConsultaMaestria }

constructor TConsultaMaestria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaMaestria');
end;

procedure TConsultaMaestria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaMaestria }

constructor TGeracaoTintaMaestria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadMAEGeraArquivo');
end;

procedure TGeracaoTintaMaestria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maestria', [
    TGravandoExecucaoMaestriaColorantes.Create,
    TGravandoExecucaoMaestriaBases.Create,
    TGravandoExecucaoMaestriaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadMAEGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Maestria Imobiliária', [
    TGravandoExecucaoMaestriaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesMaestria }

constructor TCadastroColorantesMaestria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadMAEColorantes');
end;

procedure TCadastroColorantesMaestria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesMaestria.TCadastroColorantesMaestria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasMaestria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadMAENovasFormulas');  
end;

procedure TCadastroNovasFormulasMaestria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasMaestria.TCadastroNovasFormulasMaestria.Create);
end;

end.
