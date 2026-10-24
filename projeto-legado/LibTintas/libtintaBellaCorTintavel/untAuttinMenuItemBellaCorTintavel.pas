{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemBellaCorTintavel;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBellaCorTintavelCores,
  untGravandoExecucaoBellaCorTintavelColorantes;

type
  TAuttinMenuItemBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBellaCorTintavel = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBellaCorTintavel, untLibTintaFactory, untGravandoExecucaoBellaCorTintavelNovasFormulas, untCadastroBasesBellaCorTintavel, 
  untCadastroColorantesBellaCorTintavel, untGravandoExecucaoBellaCorTintavelBases, 
  untCadastroNovasFormulasBellaCorTintavel;

{ TAuttinMenuItemBellaCorTintavel }

constructor TAuttinMenuItemBellaCorTintavel.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBellaCorTintavel.Create());
  Self.Adicionar(TCadastroBasesBellaCorTintavel.Create());
  Self.Adicionar(TCadastroColorantesBellaCorTintavel.Create());
  Self.Adicionar(TCadastroNovasFormulasBellaCorTintavel.Create());
  Self.Adicionar(TGeracaoTintaBellaCorTintavel.Create());
  Self.Adicionar(TConsultaBellaCorTintavel.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesBellaCorTintavel }

constructor TConfiguracoesBellaCorTintavel.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBellaCorTintavel');
end;

procedure TConfiguracoesBellaCorTintavel.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBellaCorTintavel.Create(auttinWrapper));
end;

{ TCadastroBasesBellaCorTintavel }

constructor TCadastroBasesBellaCorTintavel.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBLTBase');
end;

procedure TCadastroBasesBellaCorTintavel.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBellaCorTintavel.TCadastroBasesBellaCorTintavel.Create());
end;

{ TConsultaBellaCorTintavel }

constructor TConsultaBellaCorTintavel.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBellaCorTintavel');
end;

procedure TConsultaBellaCorTintavel.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBellaCorTintavel }

constructor TGeracaoTintaBellaCorTintavel.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBLTGeraArquivo');
end;

procedure TGeracaoTintaBellaCorTintavel.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('BellaCorTintavel', [
    TGravandoExecucaoBellaCorTintavelColorantes.Create,
    TGravandoExecucaoBellaCorTintavelBases.Create,
    TGravandoExecucaoBellaCorTintavelCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBLTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('BellaCorTintavel Imobiliária', [
    TGravandoExecucaoBellaCorTintavelNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesBellaCorTintavel }

constructor TCadastroColorantesBellaCorTintavel.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadBLTColorantes');
end;

procedure TCadastroColorantesBellaCorTintavel.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesBellaCorTintavel.TCadastroColorantesBellaCorTintavel.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBellaCorTintavel.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBLTNovasFormulas');  
end;

procedure TCadastroNovasFormulasBellaCorTintavel.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBellaCorTintavel.TCadastroNovasFormulasBellaCorTintavel.Create);
end;


end.
