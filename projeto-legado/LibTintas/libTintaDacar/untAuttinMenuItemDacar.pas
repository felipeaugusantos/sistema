{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemDacar;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoDacarCores,
  untGravandoExecucaoDacarColorantes;

type
  TAuttinMenuItemDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroUnidadesDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasDacar = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorDacar, untLibTintaFactory, untGravandoExecucaoDacarNovasFormulas,
  untCadastroBasesDacar, untCadastroColorantesDacar, untGravandoExecucaoDacarBases,
  untCadastroNovasFormulasDacar, untCadastroEmbalagensDacar;

{ TAuttinMenuItemDacar }

constructor TAuttinMenuItemDacar.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesDacar.Create());
  Self.Adicionar(TCadastroBasesDacar.Create());
  Self.Adicionar(TCadastroColorantesDacar.Create());
  Self.Adicionar(TCadastroUnidadesDacar.Create());
  Self.Adicionar(TCadastroNovasFormulasDacar.Create());
  Self.Adicionar(TGeracaoTintaDacar.Create());
  Self.Adicionar(TConsultaDacar.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesDacar }

constructor TConfiguracoesDacar.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesDacar');
end;

procedure TConfiguracoesDacar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorDacar.Create(auttinWrapper));
end;

{ TCadastroBasesDacar }

constructor TCadastroBasesDacar.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadDacBase');
end;

procedure TCadastroBasesDacar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesDacar.TCadastroBasesDacar.Create());
end;

{ TConsultaDacar }

constructor TConsultaDacar.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaDacar');
end;

procedure TConsultaDacar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaDacar }

constructor TGeracaoTintaDacar.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadDacGeraArquivo');
end;

procedure TGeracaoTintaDacar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Dacar', [
    TGravandoExecucaoDacarColorantes.Create,
    TGravandoExecucaoDacarBases.Create,
    TGravandoExecucaoDacarCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadDacGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Dacar', [
    TGravandoExecucaoDacarNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesDacar }

constructor TCadastroColorantesDacar.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadDacColorantes');
end;

procedure TCadastroColorantesDacar.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesDacar.TCadastroColorantesDacar.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasDacar.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadDacNovasFormulas');
end;

procedure TCadastroNovasFormulasDacar.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasDacar.TCadastroNovasFormulasDacar.Create);
end;

{ TCadastroUnidadesDacar }

constructor TCadastroUnidadesDacar.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadDacEmbalagens');
end;

procedure TCadastroUnidadesDacar.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensDacar.TCadastroEmbalagensDacar.Create);
end;

end.
