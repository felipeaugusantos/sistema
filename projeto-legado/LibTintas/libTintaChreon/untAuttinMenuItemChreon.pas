{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemChreon;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoChreonCores,
  untGravandoExecucaoChreonColorantes;

type
  TAuttinMenuItemChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasChreon = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorChreon, untLibTintaFactory, untGravandoExecucaoChreonNovasFormulas, untCadastroBasesChreon, 
  untCadastroColorantesChreon, untGravandoExecucaoChreonBases, 
  untCadastroNovasFormulasChreon;

{ TAuttinMenuItemChreon }

constructor TAuttinMenuItemChreon.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesChreon.Create());
  Self.Adicionar(TCadastroBasesChreon.Create());
  Self.Adicionar(TCadastroColorantesChreon.Create());
  Self.Adicionar(TCadastroNovasFormulasChreon.Create());
  Self.Adicionar(TGeracaoTintaChreon.Create());
  Self.Adicionar(TConsultaChreon.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesChreon }

constructor TConfiguracoesChreon.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesChreon');
end;

procedure TConfiguracoesChreon.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorChreon.Create(auttinWrapper));
end;

{ TCadastroBasesChreon }

constructor TCadastroBasesChreon.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCHRBase');
end;

procedure TCadastroBasesChreon.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesChreon.TCadastroBasesChreon.Create());
end;

{ TConsultaChreon }

constructor TConsultaChreon.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaChreon');
end;

procedure TConsultaChreon.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaChreon }

constructor TGeracaoTintaChreon.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCHRGeraArquivo');
end;

procedure TGeracaoTintaChreon.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Chreon', [
    TGravandoExecucaoChreonColorantes.Create,
    TGravandoExecucaoChreonBases.Create,
    TGravandoExecucaoChreonCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCHRGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Chreon Imobiliária', [
    TGravandoExecucaoChreonNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesChreon }

constructor TCadastroColorantesChreon.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCHRColorantes');
end;

procedure TCadastroColorantesChreon.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesChreon.TCadastroColorantesChreon.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasChreon.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCHRNovasFormulas');  
end;

procedure TCadastroNovasFormulasChreon.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasChreon.TCadastroNovasFormulasChreon.Create);
end;


end.
