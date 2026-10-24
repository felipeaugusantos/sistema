{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemBrasimixAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoBrasimixAutomotivaCores;

type
  TAuttinMenuItemBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasBrasimixAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorBrasimixAutomotiva, untLibTintaFactory, untGravandoExecucaoBrasimixAutomotivaNovasFormulas, untCadastroBasesBrasimixAutomotiva,
  untGravandoExecucaoBrasimixAutomotivaBases,  untCadastroNovasFormulasBrasimixAutomotiva;

{ TAuttinMenuItemBrasimixAutomotiva }

constructor TAuttinMenuItemBrasimixAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesBrasimixAutomotiva.Create());
  Self.Adicionar(TCadastroBasesBrasimixAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasBrasimixAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaBrasimixAutomotiva.Create());
  Self.Adicionar(TConsultaBrasimixAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesBrasimixAutomotiva }

constructor TConfiguracoesBrasimixAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesBrasimixAutomotiva');
end;

procedure TConfiguracoesBrasimixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorBrasimixAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesBrasimixAutomotiva }

constructor TCadastroBasesBrasimixAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadBZABase');
end;

procedure TCadastroBasesBrasimixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesBrasimixAutomotiva.TCadastroBasesBrasimixAutomotiva.Create());
end;

{ TConsultaBrasimixAutomotiva }

constructor TConsultaBrasimixAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaBrasimixAutomotiva');
end;

procedure TConsultaBrasimixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaBrasimixAutomotiva }

constructor TGeracaoTintaBrasimixAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadBzaGeraArquivo');
end;

procedure TGeracaoTintaBrasimixAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Brasimix Automotiva', [
    TGravandoExecucaoBrasimixAutomotivaBases.Create,
    TGravandoExecucaoBrasimixAutomotivaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadBzaGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Brasimix Automotiva', [
    TGravandoExecucaoBrasimixAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasBrasimixAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadBzaNovasFormulas');
end;

procedure TCadastroNovasFormulasBrasimixAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasBrasimixAutomotiva.TCadastroNovasFormulasBrasimixAutomotiva.Create);
end;

end.
