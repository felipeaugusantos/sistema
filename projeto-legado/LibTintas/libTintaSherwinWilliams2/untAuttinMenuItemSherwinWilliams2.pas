{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemSherwinWilliams2;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoSherwinWilliams2Cores,
  untGravandoExecucaoSherwinWilliams2Colorantes;

type
  TAuttinMenuItemSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasSherwinWilliams2 = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorSherwinWilliams2, untLibTintaFactory, untGravandoExecucaoSherwinWilliams2NovasFormulas, untCadastroBasesSherwinWilliams2, 
  untCadastroColorantesSherwinWilliams2, untGravandoExecucaoSherwinWilliams2Bases, 
  untCadastroNovasFormulasSherwinWilliams2;

{ TAuttinMenuItemSherwinWilliams2 }

constructor TAuttinMenuItemSherwinWilliams2.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesSherwinWilliams2.Create());
  Self.Adicionar(TCadastroBasesSherwinWilliams2.Create());
  Self.Adicionar(TCadastroColorantesSherwinWilliams2.Create());
  Self.Adicionar(TCadastroNovasFormulasSherwinWilliams2.Create());
  Self.Adicionar(TGeracaoTintaSherwinWilliams2.Create());
  Self.Adicionar(TConsultaSherwinWilliams2.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesSherwinWilliams2 }

constructor TConfiguracoesSherwinWilliams2.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesSherwinWilliams2');
end;

procedure TConfiguracoesSherwinWilliams2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorSherwinWilliams2.Create(auttinWrapper));
end;

{ TCadastroBasesSherwinWilliams2 }

constructor TCadastroBasesSherwinWilliams2.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadSHWBase');
end;

procedure TCadastroBasesSherwinWilliams2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesSherwinWilliams2.TCadastroBasesSherwinWilliams2.Create());
end;

{ TConsultaSherwinWilliams2 }

constructor TConsultaSherwinWilliams2.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaSherwinWilliams2');
end;

procedure TConsultaSherwinWilliams2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaSherwinWilliams2 }

constructor TGeracaoTintaSherwinWilliams2.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadSHWGeraArquivo');
end;

procedure TGeracaoTintaSherwinWilliams2.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sherwin Williams 2', [
    TGravandoExecucaoSherwinWilliams2Colorantes.Create,
    TGravandoExecucaoSherwinWilliams2Bases.Create,
    TGravandoExecucaoSherwinWilliams2Cores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadSHWGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Sherwin Williams 2', [
    TGravandoExecucaoSherwinWilliams2NovasFormulas.Create
  ]);
end;

{ TCadastroColorantesSherwinWilliams2 }

constructor TCadastroColorantesSherwinWilliams2.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadSHWColorantes');
end;

procedure TCadastroColorantesSherwinWilliams2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesSherwinWilliams2.TCadastroColorantesSherwinWilliams2.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasSherwinWilliams2.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadSHWNovasFormulas');  
end;

procedure TCadastroNovasFormulasSherwinWilliams2.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasSherwinWilliams2.TCadastroNovasFormulasSherwinWilliams2.Create);
end;

end.
