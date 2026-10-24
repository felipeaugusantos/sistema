{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemBautech;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBautechCores,
  untGravandoExecucaoBautechColorantes;

type
  TAuttinMenuItemBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBautech = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBautech, untLibTintaFactory, untGravandoExecucaoBautechNovasFormulas, untCadastroBasesBautech, 
  untCadastroColorantesBautech, untGravandoExecucaoBautechBases, 
  untCadastroNovasFormulasBautech;

{ TAuttinMenuItemBautech }

constructor TAuttinMenuItemBautech.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBautech.Create());
  Self.Adicionar(TCadastroBasesBautech.Create());
  Self.Adicionar(TCadastroColorantesBautech.Create());
  Self.Adicionar(TCadastroNovasFormulasBautech.Create());
  Self.Adicionar(TGeracaoTintaBautech.Create());
  Self.Adicionar(TConsultaBautech.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesBautech }

constructor TConfiguracoesBautech.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBautech');
end;

procedure TConfiguracoesBautech.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBautech.Create(auttinWrapper));
end;

{ TCadastroBasesBautech }

constructor TCadastroBasesBautech.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBAUBase');
end;

procedure TCadastroBasesBautech.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBautech.TCadastroBasesBautech.Create());
end;

{ TConsultaBautech }

constructor TConsultaBautech.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBautech');
end;

procedure TConsultaBautech.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBautech }

constructor TGeracaoTintaBautech.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBAUGeraArquivo');
end;

procedure TGeracaoTintaBautech.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Bautech', [
    TGravandoExecucaoBautechColorantes.Create,
    TGravandoExecucaoBautechBases.Create,
    TGravandoExecucaoBautechCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBAUGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Bautech', [
    TGravandoExecucaoBautechNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesBautech }

constructor TCadastroColorantesBautech.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadBAUColorantes');
end;

procedure TCadastroColorantesBautech.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesBautech.TCadastroColorantesBautech.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBautech.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBAUNovasFormulas');  
end;

procedure TCadastroNovasFormulasBautech.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBautech.TCadastroNovasFormulasBautech.Create);
end;

end.
