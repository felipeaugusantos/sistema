{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemBrazilianColorAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBrazilianColorAutomotivaCores;

type
  TAuttinMenuItemBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBrazilianColorAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorBrazilianColorAutomotiva, untLibTintaFactory, untGravandoExecucaoBrazilianColorAutomotivaNovasFormulas, untCadastroBasesBrazilianColorAutomotiva,
  untGravandoExecucaoBrazilianColorAutomotivaBases, untCadastroNovasFormulasBrazilianColorAutomotiva,
  untGravandoExecucaoBrazilianColorAutomotivaMontadora;

{ TAuttinMenuItemBrazilianColorAutomotiva }

constructor TAuttinMenuItemBrazilianColorAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBrazilianColorAutomotiva.Create());
  Self.Adicionar(TCadastroBasesBrazilianColorAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasBrazilianColorAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaBrazilianColorAutomotiva.Create());
  Self.Adicionar(TConsultaBrazilianColorAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());

end;

{ TConfiguracoesBrazilianColorAutomotiva }

constructor TConfiguracoesBrazilianColorAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBrazilianColorAutomotiva');
end;

procedure TConfiguracoesBrazilianColorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBrazilianColorAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesBrazilianColorAutomotiva }

constructor TCadastroBasesBrazilianColorAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBzcBase');
end;

procedure TCadastroBasesBrazilianColorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBrazilianColorAutomotiva.TCadastroBasesBrazilianColorAutomotiva.Create());
end;

{ TConsultaBrazilianColorAutomotiva }

constructor TConsultaBrazilianColorAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBrazilianColorAutomotiva');
end;

procedure TConsultaBrazilianColorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBrazilianColorAutomotiva }

constructor TGeracaoTintaBrazilianColorAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBzcGeraArquivo');
end;

procedure TGeracaoTintaBrazilianColorAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('BrazilianColor Automotiva', [
    TGravandoExecucaoBrazilianColorAutomotivaBases.Create,
    TGravandoExecucaoBrazilianColorAutomotivaMontadora.Create,
    TGravandoExecucaoBrazilianColorAutomotivaCores.Create]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBzcGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('BrazilianColorAutomotiva', [
    TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBrazilianColorAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBzcNovasFormulas');
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBrazilianColorAutomotiva.TCadastroNovasFormulasBrazilianColorAutomotiva.Create);
end;

end.
