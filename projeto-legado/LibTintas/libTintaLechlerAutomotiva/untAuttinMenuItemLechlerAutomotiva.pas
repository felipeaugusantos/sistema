{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemLechlerAutomotiva;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoLechlerAutomotivaBases,
  untGravandoExecucaoLechlerAutomotivaCores;

type
  TAuttinMenuItemLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasLechlerAutomotiva = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorLechlerAutomotiva, untLibTintaFactory, untGravandoExecucaoLechlerAutomotivaNovasFormulas, untCadastroBasesLechlerAutomotiva,
  untCadastroNovasFormulasLechlerAutomotiva;

{ TAuttinMenuItemLechlerAutomotiva }

constructor TAuttinMenuItemLechlerAutomotiva.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesLechlerAutomotiva.Create());
  Self.Adicionar(TCadastroBasesLechlerAutomotiva.Create());
  Self.Adicionar(TGeracaoTintaLechlerAutomotiva.Create());
  Self.Adicionar(TCadastroNovasFormulasLechlerAutomotiva.Create());
  Self.Adicionar(TConsultaLechlerAutomotiva.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesLechlerAutomotiva }

constructor TConfiguracoesLechlerAutomotiva.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesLechlerAutomotiva');
end;

procedure TConfiguracoesLechlerAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorLechlerAutomotiva.Create(auttinWrapper));
end;

{ TCadastroBasesLechlerAutomotiva }

constructor TCadastroBasesLechlerAutomotiva.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadLCABase');
end;

procedure TCadastroBasesLechlerAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesLechlerAutomotiva.TCadastroBasesLechlerAutomotiva.Create());
end;

{ TConsultaLechlerAutomotiva }

constructor TConsultaLechlerAutomotiva.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaLechlerAutomotiva');
end;

procedure TConsultaLechlerAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;


{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadLCAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('LechlerAutomotiva', [
    TGravandoExecucaoLechlerAutomotivaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasLechlerAutomotiva.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadLCANovasFormulas');
end;

procedure TCadastroNovasFormulasLechlerAutomotiva.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasLechlerAutomotiva.TCadastroNovasFormulasLechlerAutomotiva.Create);
end;

{ TGeracaoTintaLechlerAutomotiva }

constructor TGeracaoTintaLechlerAutomotiva.Create;
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadLCAGeraArquivo');
end;

procedure TGeracaoTintaLechlerAutomotiva.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('LechlerAutomotiva', [
    TGravandoExecucaoLechlerAutomotivaBases.Create,
    TGravandoExecucaoLechlerAutomotivaCores.Create
  ]);
end;

end.
