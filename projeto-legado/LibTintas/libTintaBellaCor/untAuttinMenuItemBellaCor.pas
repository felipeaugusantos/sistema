{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemBellaCor;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBellaCorCores,
  untGravandoExecucaoBellaCorColorantes;

type
  TAuttinMenuItemBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBellaCor = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBellaCor, untLibTintaFactory, untGravandoExecucaoBellaCorNovasFormulas, untCadastroBasesBellaCor,
  untCadastroColorantesBellaCor, untGravandoExecucaoBellaCorBases,
  untCadastroNovasFormulasBellaCor;

{ TAuttinMenuItemBellaCor }

constructor TAuttinMenuItemBellaCor.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBellaCor.Create());
  Self.Adicionar(TCadastroBasesBellaCor.Create());
  Self.Adicionar(TCadastroColorantesBellaCor.Create());
  Self.Adicionar(TCadastroNovasFormulasBellaCor.Create());
  Self.Adicionar(TGeracaoTintaBellaCor.Create());
  Self.Adicionar(TConsultaBellaCor.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesBellaCor }

constructor TConfiguracoesBellaCor.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBellaCor');
end;

procedure TConfiguracoesBellaCor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBellaCor.Create(auttinWrapper));
end;

{ TCadastroBasesBellaCor }

constructor TCadastroBasesBellaCor.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBELBase');
end;

procedure TCadastroBasesBellaCor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBellaCor.TCadastroBasesBellaCor.Create());
end;

{ TConsultaBellaCor }

constructor TConsultaBellaCor.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBellaCor');
end;

procedure TConsultaBellaCor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBellaCor }

constructor TGeracaoTintaBellaCor.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBELGeraArquivo');
end;

procedure TGeracaoTintaBellaCor.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Bellacor', [
    TGravandoExecucaoBellaCorColorantes.Create,
    TGravandoExecucaoBellaCorBases.Create,
    TGravandoExecucaoBellaCorCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBELGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Bellacor', [
    TGravandoExecucaoBellaCorNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesBellaCor }

constructor TCadastroColorantesBellaCor.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadBELColorantes');
end;

procedure TCadastroColorantesBellaCor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesBellaCor.TCadastroColorantesBellaCor.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBellaCor.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBELNovasFormulas');  
end;

procedure TCadastroNovasFormulasBellaCor.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBellaCor.TCadastroNovasFormulasBellaCor.Create);
end;

end.
