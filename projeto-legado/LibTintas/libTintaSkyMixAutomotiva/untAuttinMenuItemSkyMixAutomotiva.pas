{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemSkyMixAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSkyMixAutomotivaCores;

type
  TAuttinMenuItemSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSkyMixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorSkyMixAutomotiva, untLibTintaFactory, untGravandoExecucaoSkyMixAutomotivaNovasFormulas, untCadastroBasesSkyMixAutomotiva,
  untGravandoExecucaoSkyMixAutomotivaBases,  untCadastroNovasFormulasSkyMixAutomotiva, untGravandoExecucaoSkyMixAutomotivaGrupos,
  untGravandoExecucaoSkyMixAutomotivaMontadoras;

{ TAuttinMenuItemSkyMixAutomotiva }

constructor TAuttinMenuItemSkyMixAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSkyMixAutomotiva.Create());
  Self.Adicionar(TCadastroBasesSkyMixAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasSkyMixAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaSkyMixAutomotiva.Create());
  Self.Adicionar(TConsultaSkyMixAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSkyMixAutomotiva }

constructor TConfiguracoesSkyMixAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSkyMixAutomotiva');
end;

procedure TConfiguracoesSkyMixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSkyMixAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesSkyMixAutomotiva }

constructor TCadastroBasesSkyMixAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSKYBase');
end;

procedure TCadastroBasesSkyMixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSkyMixAutomotiva.TCadastroBasesSkyMixAutomotiva.Create());
end;

{ TConsultaSkyMixAutomotiva }

constructor TConsultaSkyMixAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSkyMixAutomotiva');
end;

procedure TConsultaSkyMixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSkyMixAutomotiva }

constructor TGeracaoTintaSkyMixAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSkyGeraArquivo');
end;

procedure TGeracaoTintaSkyMixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('SkyMix Automotiva', [
    TGravandoExecucaoSkyMixAutomotivaBases.Create,
    TGravandoExecucaoSkyMixAutomotivaCores.Create,
    TGravandoExecucaoSkyMixAutomotivaGrupos.Create,
    TGravandoExecucaoSkyMixAutomotivaMontadoras.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSkyGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('SkyMix Automotiva', [
    TGravandoExecucaoSkyMixAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSkyMixAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSkyNovasFormulas');
end;

procedure TCadastroNovasFormulasSkyMixAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSkyMixAutomotiva.TCadastroNovasFormulasSkyMixAutomotiva.Create);
end;

end.
