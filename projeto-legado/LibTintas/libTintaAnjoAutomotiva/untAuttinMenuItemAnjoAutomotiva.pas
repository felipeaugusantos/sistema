{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemAnjoAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAnjoAutomotivaCores;

type
  TAuttinMenuItemAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroMontadoraAnjoAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorAnjoAutomotiva, untLibTintaFactory, untGravandoExecucaoAnjoAutomotivaNovasFormulas, untCadastroBasesAnjoAutomotiva,
  untGravandoExecucaoAnjoAutomotivaBases, untCadastroNovasFormulasAnjoAutomotiva,
  untCadastroMontadoraAnjoAutomotiva,
  untGravandoExecucaoAnjoAutomotivaMontadora;

{ TAuttinMenuItemAnjoAutomotiva }

constructor TAuttinMenuItemAnjoAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAnjoAutomotiva.Create());
  Self.Adicionar(TCadastroBasesAnjoAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasAnjoAutomotiva.Create());
  Self.Adicionar(TCadastroMontadoraAnjoAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaAnjoAutomotiva.Create());
  Self.Adicionar(TConsultaAnjoAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAnjoAutomotiva }

constructor TConfiguracoesAnjoAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAnjoAutomotiva');
end;

procedure TConfiguracoesAnjoAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAnjoAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesAnjoAutomotiva }

constructor TCadastroBasesAnjoAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadAJTBase');
end;

procedure TCadastroBasesAnjoAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAnjoAutomotiva.TCadastroBasesAnjoAutomotiva.Create());
end;

{ TConsultaAnjoAutomotiva }

constructor TConsultaAnjoAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAnjoAutomotiva');
end;

procedure TConsultaAnjoAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAnjoAutomotiva }

constructor TGeracaoTintaAnjoAutomotiva.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadAJTGeraArquivo');
end;

procedure TGeracaoTintaAnjoAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Anjo Automotiva', [
    TGravandoExecucaoAnjoAutomotivaMontadora.Create,
    TGravandoExecucaoAnjoAutomotivaBases.Create,
    TGravandoExecucaoAnjoAutomotivaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadAJTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Anjo Automotiva', [
    TGravandoExecucaoAnjoAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAnjoAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadAJTNovasFormulas');
end;

procedure TCadastroNovasFormulasAnjoAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAnjoAutomotiva.TCadastroNovasFormulasAnjoAutomotiva.Create);
end;

{ TCadastroMontadoraAnjoAutomotiva }

constructor TCadastroMontadoraAnjoAutomotiva.Create;
begin
  inherited Create('Cadastro de Montadora', 'frmCadAJTMontadora');
end;

procedure TCadastroMontadoraAnjoAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroMontadoraAnjoAutomotiva.TCadastroMontadoraAnjoAutomotiva.Create);
end;

end.

